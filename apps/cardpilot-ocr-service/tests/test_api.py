import io
import json

from fastapi.testclient import TestClient
from PIL import Image

from cardpilot_service.api import create_app
from cardpilot_service.config import Settings
from cardpilot_service.contracts import EngineBlock, EngineResult


class FakeEngine:
    name = "fake-top1"

    def readiness(self):
        return True, {"models_loaded": True}

    def scan(self, content):
        assert content.startswith(b"\xff\xd8")
        return EngineResult(
            blocks=[
                EngineBlock("CARDPILOT MART", "SELLER", (1, 1, 80, 1, 80, 15, 1, 15), 0.9),
                EngineBlock("08/08/2026 13:45", "TIMESTAMP", (1, 20, 90, 20, 90, 30, 1, 30), 0.8),
                EngineBlock("250.000 VND", "TOTAL_COST", (1, 40, 90, 40, 90, 50, 1, 50), 0.85),
            ],
            stage_ms={"detection": 10, "recognition": 20, "kie": 30},
        )


def image_bytes():
    output = io.BytesIO()
    Image.new("RGB", (40, 60), "white").save(output, "PNG")
    return output.getvalue()


def test_scan_contract():
    app = create_app(Settings(max_image_pixels=10_000), FakeEngine())
    with TestClient(app) as client:
        response = client.post(
            "/v1/receipts/scan",
            files={"image": ("receipt.png", image_bytes(), "image/png")},
        )
    assert response.status_code == 200
    body = response.json()
    assert body["engine"] == "fake-top1"
    assert body["model_version"] is None
    assert body["fields"]["merchant"]["value"] == "CARDPILOT MART"
    assert body["fields"]["total"]["value"] == {"amount": 250000, "currency": "VND"}
    assert body["image"]["width"] == 40


def test_rejects_non_image():
    app = create_app(Settings(), FakeEngine())
    with TestClient(app) as client:
        response = client.post(
            "/v1/receipts/scan",
            files={"image": ("receipt.txt", b"not image", "text/plain")},
        )
    assert response.status_code == 422


def test_readiness_reports_engine():
    app = create_app(Settings(), FakeEngine())
    with TestClient(app) as client:
        response = client.get("/health/ready")
    assert response.status_code == 200
    assert response.json()["engine"] == "fake-top1"


def test_model_artifact_resolves_versioned_files(tmp_path):
    artifact = tmp_path / "artifact"
    artifact.mkdir()
    (artifact / "manifest.json").write_text(
        json.dumps(
            {
                "schema_version": 1,
                "model_version": "test-v1",
                "files": {
                    "detector": "detector/model",
                    "rotation": "rotation/model.pth",
                    "recognition": "recognition/model.pth",
                    "kie": "kie/model.pth",
                },
            }
        )
    )
    settings = Settings(root=tmp_path, model_dir=artifact)
    assert settings.model_artifact["model_version"] == "test-v1"
    assert settings.detector_model == artifact / "detector/model"
