import io
import time
import uuid
from typing import Tuple

from PIL import Image, ImageOps, UnidentifiedImageError

from cardpilot_service.config import Settings
from cardpilot_service.errors import InvalidImageError
from cardpilot_service.normalization import normalize_result
from cardpilot_service.schemas import ImageMetadata, ScanResponse

ALLOWED_TYPES = {"image/jpeg", "image/png", "image/webp"}


class ReceiptScanService:
    def __init__(self, settings: Settings, engine):
        self.settings = settings
        self.engine = engine

    def scan(self, content: bytes, content_type: str) -> ScanResponse:
        metadata, normalized = self._prepare(content, content_type)
        started = time.perf_counter()
        result = self.engine.scan(normalized)
        fields, blocks, raw_text, warnings = normalize_result(result.blocks, self.settings.currency)
        return ScanResponse(
            scan_id=str(uuid.uuid4()),
            engine=self.engine.name,
            model_version=self.settings.model_artifact.get("model_version"),
            processing_ms=round((time.perf_counter() - started) * 1000),
            stage_ms=result.stage_ms,
            image=metadata,
            fields=fields,
            raw_text=raw_text,
            blocks=blocks,
            warnings=list(dict.fromkeys(result.warnings + warnings)),
        )

    def _prepare(self, content: bytes, content_type: str) -> Tuple[ImageMetadata, bytes]:
        if content_type not in ALLOWED_TYPES:
            raise InvalidImageError("Unsupported content type: {}".format(content_type))
        if not content:
            raise InvalidImageError("Image is empty")
        if len(content) > self.settings.max_upload_bytes:
            raise InvalidImageError("Image exceeds upload size limit")
        try:
            with Image.open(io.BytesIO(content)) as source:
                width, height = source.size
                source.verify()
            if width * height > self.settings.max_image_pixels:
                raise InvalidImageError("Image exceeds pixel limit")
            output = io.BytesIO()
            with Image.open(io.BytesIO(content)) as source:
                ImageOps.exif_transpose(source).convert("RGB").save(
                    output, format="JPEG", quality=92, optimize=True
                )
        except (UnidentifiedImageError, OSError) as exc:
            raise InvalidImageError("Uploaded file is not a valid image") from exc
        return ImageMetadata(
            width=width, height=height, content_type=content_type, size_bytes=len(content)
        ), output.getvalue()
