from datetime import datetime
from decimal import Decimal
from typing import Any, Dict, Generic, List, Optional, TypeVar

from pydantic import BaseModel, Field, confloat
from pydantic.generics import GenericModel

Confidence = confloat(ge=0, le=1)


class BoundingBox(BaseModel):
    left: int
    top: int
    right: int
    bottom: int


class Polygon(BaseModel):
    points: List[List[int]]


class TextBlock(BaseModel):
    text: str
    label: str
    confidence: Optional[Confidence] = None
    bounding_box: BoundingBox
    polygon: Polygon


T = TypeVar("T")


class ExtractedField(GenericModel, Generic[T]):
    value: Optional[T] = None
    raw_value: Optional[str] = None
    confidence: Optional[Confidence] = None
    block_indexes: List[int] = Field(default_factory=list)


class MoneyValue(BaseModel):
    amount: Decimal
    currency: str


class ReceiptFields(BaseModel):
    merchant: ExtractedField[str]
    address: ExtractedField[str]
    occurred_at: ExtractedField[datetime]
    total: ExtractedField[MoneyValue]


class ImageMetadata(BaseModel):
    width: int
    height: int
    content_type: str
    size_bytes: int


class ScanResponse(BaseModel):
    scan_id: str
    engine: str
    model_version: Optional[str] = None
    processing_ms: int
    stage_ms: Dict[str, int]
    image: ImageMetadata
    fields: ReceiptFields
    raw_text: str
    blocks: List[TextBlock]
    warnings: List[str]


class HealthResponse(BaseModel):
    status: str
    engine: str
    details: Dict[str, Any] = Field(default_factory=dict)
