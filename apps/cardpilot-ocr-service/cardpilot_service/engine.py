import sys
import tempfile
import threading
import time
from pathlib import Path
from types import SimpleNamespace
from typing import Dict, Tuple

from cardpilot_service.config import Settings
from cardpilot_service.contracts import EngineBlock, EngineResult
from cardpilot_service.errors import EngineUnavailableError, InferenceError


class McOcrTop1Engine:
    """Single-image adapter for ndcuong91/MC_OCR.

    Upstream libraries use global module paths and are not thread-safe. One engine
    therefore processes one image at a time; scale with one worker per container.
    """

    name = "ndcuong91-mc-ocr"

    def __init__(self, settings: Settings):
        self.settings = settings
        self._lock = threading.Lock()
        self._models = None
        self._load_error = None

    def readiness(self) -> Tuple[bool, Dict[str, object]]:
        required = {
            "detector": self.settings.detector_model / "inference.pdmodel",
            "detector_params": self.settings.detector_model / "inference.pdiparams",
            "rotation": self.settings.rotation_model,
            "recognition": self.settings.recognition_model,
            "kie": self.settings.kie_model,
        }
        missing = [name for name, path in required.items() if not path.is_file()]
        ready = not missing and self._load_error is None
        details = {
            "missing_models": missing,
            "models_loaded": self._models is not None,
            "model_version": self.settings.model_artifact.get("model_version"),
            "device": self.settings.device,
            "concurrency_per_worker": 1,
        }
        if self._load_error:
            details["initialization_error"] = self._load_error
        return ready, details

    def load(self) -> None:
        try:
            self._load_models()
        except EngineUnavailableError as exc:
            self._load_error = str(exc)
            raise

    def _paths(self) -> None:
        paths = [
            self.settings.root,
            self.settings.root / "mc_ocr/text_detector/PaddleOCR",
            self.settings.root / "mc_ocr/text_classifier/vietocr",
            self.settings.root / "mc_ocr/key_info_extraction/PICK",
        ]
        for path in reversed(paths):
            value = str(path)
            if value not in sys.path:
                sys.path.insert(0, value)

    def _load_models(self):
        if self._models is not None:
            return self._models
        ready, details = self.readiness()
        if not ready:
            raise EngineUnavailableError("Missing OCR models: {}".format(details["missing_models"]))
        self._paths()
        try:
            import model.pick as pick_arch_module
            import torch
            from vietocr.vietocr_class import Classifier_Vietocr

            from cardpilot_service.detector import TextDetector
            from cardpilot_service.rotation import ReceiptRotationClassifier

            detector = TextDetector(self._detector_args())
            rotation = ReceiptRotationClassifier(self.settings.rotation_model)
            recognition = Classifier_Vietocr(
                ckpt_path=str(self.settings.recognition_model), gpu=None
            )
            device = torch.device(self.settings.device)
            try:
                checkpoint = torch.load(
                    str(self.settings.kie_model), map_location=device, weights_only=False
                )
            except TypeError:
                checkpoint = torch.load(str(self.settings.kie_model), map_location=device)
            kie = checkpoint["config"].init_obj("model_arch", pick_arch_module)
            kie.load_state_dict(checkpoint["state_dict"])
            kie.to(device).eval()
            self._models = {
                "detector": detector,
                "rotation": rotation,
                "recognition": recognition,
                "kie": kie,
                "device": device,
            }
            self._load_error = None
            return self._models
        except Exception as exc:
            raise EngineUnavailableError("Unable to initialize MC-OCR: {}".format(exc)) from exc

    def _detector_args(self):
        return SimpleNamespace(
            det_algorithm="DB",
            det_model_dir=str(self.settings.detector_model),
            det_limit_side_len=960,
            det_limit_type="max",
            det_db_thresh=0.3,
            det_db_box_thresh=0.3,
            det_db_unclip_ratio=1.6,
            det_east_score_thresh=0.8,
            det_east_cover_thresh=0.1,
            det_east_nms_thresh=0.2,
            det_sast_score_thresh=0.5,
            det_sast_nms_thresh=0.2,
            det_sast_polygon=False,
            use_gpu=(self.settings.detector_device or self.settings.device).startswith("cuda"),
            gpu_mem=1000,
            use_tensorrt=False,
            use_fp16=False,
            max_batch_size=10,
            enable_mkldnn=False,
            ir_optim=True,
            use_pdserving=False,
            rec_batch_num=1,
        )

    def scan(self, image_bytes: bytes) -> EngineResult:
        with self._lock:
            models = self._load_models()
            try:
                return self._scan(models, image_bytes)
            except Exception as exc:
                raise InferenceError("MC-OCR inference failed: {}".format(exc)) from exc

    def _scan(self, models, image_bytes: bytes) -> EngineResult:
        import cv2
        import numpy as np

        stages = {}
        started = time.perf_counter()
        image = cv2.imdecode(np.frombuffer(image_bytes, dtype=np.uint8), cv2.IMREAD_COLOR)
        if image is None:
            raise ValueError("OpenCV could not decode image")

        boxes, _ = models["detector"](image)
        boxes = [np.asarray(box).astype(int).reshape(-1).tolist() for box in boxes]
        stages["detection"] = self._elapsed(started)
        if not boxes:
            return EngineResult([], stages, ["no_text_detected"])

        stage = time.perf_counter()
        rotated, boxes = self._correct_rotation(image, boxes, models["rotation"])
        stages["rotation"] = self._elapsed(stage)

        stage = time.perf_counter()
        texts, probabilities = self._recognize(rotated, boxes, models["recognition"])
        stages["recognition"] = self._elapsed(stage)

        stage = time.perf_counter()
        labels = self._extract(rotated, boxes, texts, models["kie"], models["device"])
        stages["kie"] = self._elapsed(stage)
        blocks = [
            EngineBlock(
                text=texts[index],
                label=labels.get(index, "OTHER"),
                polygon=tuple(int(value) for value in boxes[index]),
                confidence=float(probabilities[index]),
            )
            for index in range(len(boxes))
            if texts[index]
        ]
        return EngineResult(blocks, stages)

    @staticmethod
    def _correct_rotation(image, boxes, classifier):
        import numpy as np

        from mc_ocr.rotation_corrector.filter import (
            drop_box,
            filter_90_box,
            get_mean_horizontal_angle,
        )
        from mc_ocr.rotation_corrector.utils.line_angle_correction import rotate_and_crop
        from mc_ocr.rotation_corrector.utils.utils import rotate_image_bbox_angle

        boxes = drop_box(boxes, drop_gap=(0.5, 2)) or boxes
        angle = get_mean_horizontal_angle(boxes, False)
        image, boxes = rotate_image_bbox_angle(image, boxes, angle)
        votes = {"0": 0, "180": 0}
        for box in boxes:
            polygon = np.asarray(box).astype(np.int32).reshape(-1, 1, 2)
            crop = rotate_and_crop(image, polygon, debug=False, extend=True)
            _, prediction = classifier.inference(crop, debug=False)
            votes[str(prediction[0])] += 1
        page_angle = 0 if votes["0"] >= votes["180"] else 180
        image, boxes = rotate_image_bbox_angle(image, boxes, page_angle)
        filtered = filter_90_box(boxes)
        return image, filtered if isinstance(filtered, list) and filtered else boxes

    @staticmethod
    def _recognize(image, boxes, classifier):
        import numpy as np

        from mc_ocr.rotation_corrector.utils.line_angle_correction import rotate_and_crop

        all_texts, all_probabilities = [], []
        for min_y, ratio_y in ((0, 0), (2, 0.1), (4, 0.2)):
            crops = []
            for box in boxes:
                polygon = np.asarray(box).astype(np.int32).reshape(-1, 1, 2)
                crops.append(
                    rotate_and_crop(
                        image,
                        polygon,
                        debug=False,
                        extend=True,
                        min_extend_y=min_y,
                        extend_y_ratio=ratio_y,
                        extend_x_ratio=0.05,
                        min_extend_x=2,
                    )
                )
            texts, probabilities = classifier.inference(crops, debug=False)
            all_texts.append(texts)
            all_probabilities.append(probabilities)
        texts, probabilities = [], []
        for index in range(len(boxes)):
            best = max(range(3), key=lambda run: all_probabilities[run][index])
            texts.append(all_texts[best][index])
            probabilities.append(all_probabilities[best][index])
        return texts, probabilities

    def _extract(self, image, boxes, texts, model, device):
        import cv2
        import torch
        from data_utils.pick_dataset import BatchCollateFn, PICKDataset
        from utils.util import iob_index_to_str

        self.settings.work_dir.mkdir(parents=True, exist_ok=True)
        with tempfile.TemporaryDirectory(dir=str(self.settings.work_dir)) as temp:
            root = Path(temp)
            image_dir, transcript_dir = root / "images", root / "transcripts"
            image_dir.mkdir()
            transcript_dir.mkdir()
            cv2.imwrite(str(image_dir / "receipt.jpg"), image)
            lines = []
            for index, (box, text) in enumerate(zip(boxes, texts), 1):
                lines.append("{},{},{}\n".format(index, ",".join(map(str, box)), text))
            (transcript_dir / "receipt.tsv").write_text("".join(lines), encoding="utf-8")
            dataset = PICKDataset(
                boxes_and_transcripts_folder=str(transcript_dir),
                images_folder=str(image_dir),
                resized_image_size=(560, 784),
                ignore_error=False,
                training=False,
                max_boxes_num=130,
                max_transcript_len=70,
            )
            batch = BatchCollateFn(training=False)([dataset[0]])
            for key, value in batch.items():
                if value is not None:
                    batch[key] = value.to(device)
            with torch.no_grad():
                output = model(**batch)
                paths = model.decoder.crf_layer.viterbi_tags(
                    output["logits"], mask=output["new_mask"], logits_batch_first=True
                )
            decoded = iob_index_to_str([path for path, _score in paths])[0]
            lengths = batch["text_length"].cpu().numpy()[0]
            labels, offset = {}, 0
            for line_index, length in enumerate(lengths):
                length = int(length)
                if length and offset < len(decoded) and decoded[offset].startswith("B-"):
                    labels[line_index] = decoded[offset][2:]
                offset += length
            return labels

    @staticmethod
    def _elapsed(started: float) -> int:
        return round((time.perf_counter() - started) * 1000)
