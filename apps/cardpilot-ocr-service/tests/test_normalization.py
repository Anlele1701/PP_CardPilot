from datetime import datetime
from decimal import Decimal

from cardpilot_service.contracts import EngineBlock
from cardpilot_service.normalization import normalize_for_comparison, normalize_result, parse_amount


def test_parse_amount_prefers_largest_value():
    assert parse_amount("VAT 10.000 TONG 1.250.000 VND") == Decimal("1250000")


def test_normalize_result_maps_competition_labels():
    fields, blocks, raw_text, warnings = normalize_result(
        [
            EngineBlock("Cua Hang Ánh", "SELLER", (0, 0, 100, 0, 100, 20, 0, 20), 0.9),
            EngineBlock("08/08/2026 13:45", "TIMESTAMP", (0, 30, 100, 30, 100, 50, 0, 50), 0.8),
            EngineBlock("125.000 d", "TOTAL_COST", (0, 60, 100, 60, 100, 80, 0, 80), 0.8),
        ],
        "VND",
    )
    assert fields.merchant.value == "Cua Hang Ánh"
    assert fields.occurred_at.value == datetime(2026, 8, 8, 13, 45)
    assert fields.total.value.amount == Decimal("125000")
    assert blocks[0].bounding_box.right == 100
    assert raw_text.startswith("Cua Hang Ánh")
    assert warnings == []


def test_comparison_removes_vietnamese_diacritics():
    assert normalize_for_comparison("Cửa hàng Ánh") == "cua hang anh"
