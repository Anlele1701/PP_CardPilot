import json
import os
from dataclasses import dataclass
from functools import cached_property
from pathlib import Path


def _integer(name: str, default: int) -> int:
    return int(os.getenv(name, str(default)))


def _boolean(name: str, default: bool) -> bool:
    value = os.getenv(name)
    return default if value is None else value.lower() in {"1", "true", "yes", "on"}


@dataclass(frozen=True)
class Settings:
    root: Path = Path(os.getenv("OCR_ROOT", Path(__file__).resolve().parents[1]))
    model_dir: Path = Path(os.getenv("OCR_MODEL_DIR", "models"))
    work_dir: Path = Path(os.getenv("OCR_WORK_DIR", "/tmp/cardpilot-ocr"))
    device: str = os.getenv("OCR_DEVICE", "cpu")
    currency: str = os.getenv("OCR_DEFAULT_CURRENCY", "VND")
    max_upload_bytes: int = _integer("OCR_MAX_UPLOAD_BYTES", 12 * 1024 * 1024)
    max_image_pixels: int = _integer("OCR_MAX_IMAGE_PIXELS", 24_000_000)
    ocr_confidence_threshold: float = float(os.getenv("OCR_CONFIDENCE_THRESHOLD", "0.65"))
    preload_models: bool = _boolean("OCR_PRELOAD_MODELS", True)

    @cached_property
    def model_artifact(self) -> dict:
        model_dir = self.model_dir if self.model_dir.is_absolute() else self.root / self.model_dir
        manifest = model_dir / "manifest.json"
        if not manifest.is_file():
            return {"root": model_dir, "files": {}}
        payload = json.loads(manifest.read_text(encoding="utf-8"))
        if payload.get("schema_version") != 1:
            raise ValueError("Unsupported OCR model artifact schema")
        payload["root"] = model_dir
        return payload

    def _model_path(self, name: str) -> Path:
        relative = self.model_artifact["files"].get(name)
        if not relative:
            return self.model_artifact["root"] / ("missing-{}".format(name))
        path = (self.model_artifact["root"] / relative).resolve()
        if self.model_artifact["root"].resolve() not in path.parents:
            raise ValueError("Model artifact path escapes OCR_MODEL_DIR")
        return path

    @property
    def detector_model(self) -> Path:
        return self._model_path("detector")

    @property
    def rotation_model(self) -> Path:
        return self._model_path("rotation")

    @property
    def recognition_model(self) -> Path:
        return self._model_path("recognition")

    @property
    def kie_model(self) -> Path:
        return self._model_path("kie")
