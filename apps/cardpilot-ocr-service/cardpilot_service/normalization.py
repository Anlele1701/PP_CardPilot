import re
import unicodedata
from datetime import datetime
from decimal import Decimal
from typing import Dict, List, Optional, Tuple

from cardpilot_service.contracts import EngineBlock
from cardpilot_service.schemas import (
    BoundingBox,
    ExtractedField,
    MoneyValue,
    Polygon,
    ReceiptFields,
    TextBlock,
)

LABELS = {
    "SELLER": "merchant",
    "ADDRESS": "address",
    "TIMESTAMP": "timestamp",
    "TOTAL_COST": "total",
}


def normalize_space(value: str) -> str:
    return " ".join(value.split()).strip()


def normalize_for_comparison(value: str) -> str:
    value = unicodedata.normalize("NFD", normalize_space(value).casefold())
    return "".join(char for char in value if unicodedata.category(char) != "Mn")


def parse_amount(raw: str) -> Optional[Decimal]:
    candidates = re.findall(r"(?<!\d)\d[\d.,\s]{2,}(?!\d)", raw)
    values = [Decimal(re.sub(r"\D", "", item)) for item in candidates if re.sub(r"\D", "", item)]
    return max(values) if values else None


def parse_datetime(raw: str) -> Optional[datetime]:
    match = re.search(
        r"(?:\d{4}[-/.]\d{1,2}[-/.]\d{1,2}|\d{1,2}[-/.]\d{1,2}[-/.]\d{2,4})"
        r"(?:\s+\d{1,2}:\d{2}(?::\d{2})?)?",
        raw,
    )
    if not match:
        return None
    for pattern in (
        "%d/%m/%Y %H:%M:%S",
        "%d/%m/%Y %H:%M",
        "%d/%m/%Y",
        "%d-%m-%Y %H:%M:%S",
        "%d-%m-%Y %H:%M",
        "%d-%m-%Y",
        "%Y-%m-%d %H:%M:%S",
        "%Y-%m-%d",
    ):
        try:
            return datetime.strptime(match.group(0), pattern)
        except ValueError:
            pass
    return None


def normalize_result(
    source: List[EngineBlock], currency: str
) -> Tuple[ReceiptFields, List[TextBlock], str, List[str]]:
    blocks: List[TextBlock] = []
    indexes: Dict[str, List[int]] = {key: [] for key in LABELS.values()}
    for item in source:
        label = LABELS.get(item.label, "other")
        points = [[item.polygon[i], item.polygon[i + 1]] for i in range(0, 8, 2)]
        xs, ys = [point[0] for point in points], [point[1] for point in points]
        blocks.append(
            TextBlock(
                text=normalize_space(item.text),
                label=label,
                confidence=item.confidence,
                bounding_box=BoundingBox(left=min(xs), top=min(ys), right=max(xs), bottom=max(ys)),
                polygon=Polygon(points=points),
            )
        )
        if label in indexes:
            indexes[label].append(len(blocks) - 1)

    def collect(label: str) -> Optional[str]:
        value = normalize_space(" ".join(blocks[index].text for index in indexes[label]))
        return value or None

    def confidence(label: str) -> Optional[float]:
        values = [
            blocks[index].confidence
            for index in indexes[label]
            if blocks[index].confidence is not None
        ]
        return sum(values) / len(values) if values else None

    merchant, address = collect("merchant"), collect("address")
    timestamp_raw, total_raw = collect("timestamp"), collect("total")
    occurred_at, amount = parse_datetime(timestamp_raw or ""), parse_amount(total_raw or "")
    warnings = []
    if merchant is None:
        warnings.append("merchant_not_detected")
    if occurred_at is None:
        warnings.append("timestamp_not_parsed")
    if amount is None:
        warnings.append("total_not_parsed")
    fields = ReceiptFields(
        merchant=ExtractedField[str](
            value=merchant,
            raw_value=merchant,
            confidence=confidence("merchant"),
            block_indexes=indexes["merchant"],
        ),
        address=ExtractedField[str](
            value=address,
            raw_value=address,
            confidence=confidence("address"),
            block_indexes=indexes["address"],
        ),
        occurred_at=ExtractedField[datetime](
            value=occurred_at,
            raw_value=timestamp_raw,
            confidence=confidence("timestamp"),
            block_indexes=indexes["timestamp"],
        ),
        total=ExtractedField[MoneyValue](
            value=MoneyValue(amount=amount, currency=currency) if amount is not None else None,
            raw_value=total_raw,
            confidence=confidence("total"),
            block_indexes=indexes["total"],
        ),
    )
    return fields, blocks, "\n".join(block.text for block in blocks if block.text), warnings
