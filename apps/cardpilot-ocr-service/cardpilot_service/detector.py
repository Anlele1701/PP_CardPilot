import time
from pathlib import Path

import cv2
import numpy as np
from paddle import inference

from mc_ocr.text_detector.PaddleOCR.ppocr.postprocess.db_postprocess import DBPostProcess


class TextDetector:
    def __init__(self, args):
        self.args = args
        self.postprocess = DBPostProcess(
            thresh=args.det_db_thresh,
            box_thresh=args.det_db_box_thresh,
            max_candidates=1000,
            unclip_ratio=args.det_db_unclip_ratio,
            use_dilation=True,
        )
        model_dir = Path(args.det_model_dir)
        config = inference.Config(
            str(model_dir / "inference.pdmodel"),
            str(model_dir / "inference.pdiparams"),
        )
        if args.use_gpu:
            config.enable_use_gpu(args.gpu_mem, 0)
        else:
            config.disable_gpu()
            config.set_cpu_math_library_num_threads(6)
            if args.enable_mkldnn:
                config.set_mkldnn_cache_capacity(10)
                config.enable_mkldnn()
        config.disable_glog_info()
        config.delete_pass("conv_transpose_eltwiseadd_bn_fuse_pass")
        config.switch_use_feed_fetch_ops(False)
        self.predictor = inference.create_predictor(config)
        self.input_tensor = self.predictor.get_input_handle(self.predictor.get_input_names()[0])
        self.output_tensors = [
            self.predictor.get_output_handle(name) for name in self.predictor.get_output_names()
        ]

    def __call__(self, image):
        started = time.perf_counter()
        tensor, shape = self._preprocess(image)
        self.input_tensor.copy_from_cpu(tensor)
        self.predictor.run()
        outputs = [tensor.copy_to_cpu() for tensor in self.output_tensors]
        result = self.postprocess({"maps": outputs[0]}, np.expand_dims(shape, axis=0))
        boxes = self._filter(result[0]["points"], image.shape)
        return boxes, time.perf_counter() - started

    def _preprocess(self, image):
        source_height, source_width = image.shape[:2]
        ratio = min(1.0, self.args.det_limit_side_len / max(source_height, source_width))
        height = max(32, int(round(source_height * ratio / 32) * 32))
        width = max(32, int(round(source_width * ratio / 32) * 32))
        resized = cv2.resize(image, (width, height)).astype("float32") / 255.0
        resized = (resized - np.array([0.485, 0.456, 0.406])) / np.array(
            [0.229, 0.224, 0.225]
        )
        tensor = np.expand_dims(resized.transpose((2, 0, 1)), axis=0).astype("float32")
        shape = np.array(
            [source_height, source_width, height / source_height, width / source_width]
        )
        return tensor, shape

    @staticmethod
    def _filter(boxes, image_shape):
        height, width = image_shape[:2]
        filtered = []
        for box in boxes:
            points = np.asarray(box, dtype="float32")
            x_sorted = points[np.argsort(points[:, 0])]
            left = x_sorted[:2][np.argsort(x_sorted[:2, 1])]
            right = x_sorted[2:][np.argsort(x_sorted[2:, 1])]
            points = np.array([left[0], right[0], right[1], left[1]], dtype="float32")
            points[:, 0] = np.clip(points[:, 0], 0, width - 1)
            points[:, 1] = np.clip(points[:, 1], 0, height - 1)
            if np.linalg.norm(points[0] - points[1]) > 3 and np.linalg.norm(
                points[0] - points[3]
            ) > 3:
                filtered.append(points)
        return np.asarray(filtered)
