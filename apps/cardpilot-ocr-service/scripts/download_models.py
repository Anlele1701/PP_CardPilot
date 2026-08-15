import argparse
import json
import shutil
import tarfile
from pathlib import Path

import gdown


def download(file_id, destination):
    destination.parent.mkdir(parents=True, exist_ok=True)
    if destination.is_file() and destination.stat().st_size > 0:
        print("Already present: {}".format(destination))
        return
    if gdown.download(id=file_id, output=str(destination), quiet=False) is None:
        raise RuntimeError("Failed to download {}".format(destination))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--model-dir", type=Path)
    parser.add_argument("--model-version", default="mc-ocr-top1-upstream")
    args = parser.parse_args()
    root = args.root.resolve()
    packaged_root = Path(__file__).resolve().parents[1]
    if not (root / "mc_ocr").is_dir() and (packaged_root / "mc_ocr").is_dir():
        root = packaged_root
    model_dir = (args.model_dir or root / "models").resolve()

    detector_root = model_dir / "detector"
    detector = detector_root / "ch_ppocr_server_v2.0_det_infer"
    detector_tar = detector_root / "ch_ppocr_server_v2.0_det_infer.tar"
    if not (detector / "inference.pdmodel").is_file():
        detector_root.mkdir(parents=True, exist_ok=True)
        if not detector_tar.is_file():
            url = (
                "https://paddleocr.bj.bcebos.com/dygraph_v2.0/ch/"
                "ch_ppocr_server_v2.0_det_infer.tar"
            )
            if gdown.download(url=url, output=str(detector_tar), quiet=False) is None:
                raise RuntimeError("Failed to download PaddleOCR detector")
        with tarfile.open(str(detector_tar)) as archive:
            try:
                archive.extractall(str(detector_root), filter="data")
            except TypeError:
                archive.extractall(str(detector_root))

    rotation = model_dir / "rotation/model.pth"
    rotation.parent.mkdir(parents=True, exist_ok=True)
    if not rotation.is_file():
        shutil.copy2(
            root
            / "mc_ocr/rotation_corrector/weights/"
            "mobilenetv3-Epoch-487-Loss-0.03-Acc-0.99.pth",
            rotation,
        )
    download("1nTKlEog9YFK74kPyX0qLwCWi60_YHHk4", model_dir / "recognition/model.pth")
    download("1G3jNF2eEANN5B_tN5bHkD09TMZnQi2cD", model_dir / "kie/model.pth")

    manifest = {
        "schema_version": 1,
        "model_version": args.model_version,
        "engine": "ndcuong91-mc-ocr",
        "files": {
            "detector": "detector/ch_ppocr_server_v2.0_det_infer",
            "rotation": "rotation/model.pth",
            "recognition": "recognition/model.pth",
            "kie": "kie/model.pth",
        },
    }
    (model_dir / "manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n", encoding="utf-8"
    )
    print("OCR model artifact is ready: {}".format(model_dir))


if __name__ == "__main__":
    main()
