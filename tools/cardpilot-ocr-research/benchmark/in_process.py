import argparse
import json
import statistics
import sys
import time
from datetime import datetime
from decimal import Decimal
from pathlib import Path


def accuracy(values):
    return sum(values) / len(values) if values else None


def percentile(values, ratio):
    values = sorted(values)
    return values[round((len(values) - 1) * ratio)] if values else None


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--service-root", type=Path, required=True)
    parser.add_argument("--model-dir", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--device", default="cpu")
    args = parser.parse_args()
    sys.path.insert(0, str(args.service_root.resolve()))

    from cardpilot_service.config import Settings
    from cardpilot_service.engine import McOcrTop1Engine
    from cardpilot_service.normalization import normalize_for_comparison, normalize_result

    settings = Settings(
        root=args.service_root.resolve(),
        model_dir=args.model_dir.resolve(),
        device=args.device,
        preload_models=True,
    )
    engine = McOcrTop1Engine(settings)
    engine.load()
    cases = [json.loads(line) for line in args.manifest.read_text().splitlines() if line.strip()]
    results = []
    for case in cases:
        started = time.perf_counter()
        try:
            raw = engine.scan(Path(case["image"]).read_bytes())
            fields, _blocks, _text, warnings = normalize_result(raw.blocks, settings.currency)
            result = {
                "image": case["image"],
                "ok": True,
                "merchant": normalize_for_comparison(fields.merchant.value or "")
                == normalize_for_comparison(case["merchant"]),
                "total": fields.total.value is not None
                and fields.total.value.amount == Decimal(str(case["total"])),
                "date": fields.occurred_at.value is not None
                and fields.occurred_at.value.date()
                == datetime.fromisoformat(case["occurred_at"]).date(),
                "stage_ms": raw.stage_ms,
                "warnings": warnings,
            }
        except Exception as exc:
            result = {"image": case["image"], "ok": False, "error": str(exc)}
        result["latency_ms"] = round((time.perf_counter() - started) * 1000)
        results.append(result)

    latencies = [result["latency_ms"] for result in results]
    report = {
        "model_version": settings.model_artifact.get("model_version"),
        "count": len(results),
        "success_rate": accuracy([result["ok"] for result in results]),
        "merchant_accuracy": accuracy([result.get("merchant", False) for result in results]),
        "total_accuracy": accuracy([result.get("total", False) for result in results]),
        "date_accuracy": accuracy([result.get("date", False) for result in results]),
        "latency_ms": {
            "mean": statistics.mean(latencies) if latencies else None,
            "p50": percentile(latencies, 0.5),
            "p95": percentile(latencies, 0.95),
        },
        "cases": results,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps({key: value for key, value in report.items() if key != "cases"}, indent=2))


if __name__ == "__main__":
    main()
