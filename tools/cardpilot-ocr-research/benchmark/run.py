import argparse
import json
import statistics
import time
from datetime import datetime
from decimal import Decimal
from pathlib import Path

import httpx

from cardpilot_service.normalization import normalize_for_comparison


def accuracy(values):
    return sum(values) / len(values) if values else None


def percentile(values, ratio):
    values = sorted(values)
    return values[round((len(values) - 1) * ratio)] if values else None


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--base-url", default="http://localhost:8080")
    parser.add_argument("--output", type=Path, default=Path("benchmark/results/latest.json"))
    args = parser.parse_args()
    cases = [json.loads(line) for line in args.manifest.read_text().splitlines() if line.strip()]
    results = []
    with httpx.Client(base_url=args.base_url, timeout=180) as client:
        for case in cases:
            path = args.manifest.parent / case["image"]
            started = time.perf_counter()
            try:
                with path.open("rb") as image:
                    response = client.post(
                        "/v1/receipts/scan", files={"image": (path.name, image, "image/jpeg")}
                    )
                response.raise_for_status()
                fields = response.json()["fields"]
                actual_total = fields["total"]["value"]
                result = {
                    "image": case["image"],
                    "ok": True,
                    "merchant": normalize_for_comparison(fields["merchant"]["value"] or "")
                    == normalize_for_comparison(case.get("merchant", "")),
                    "total": actual_total is not None
                    and Decimal(str(actual_total["amount"])) == Decimal(str(case["total"])),
                    "date": fields["occurred_at"]["value"] is not None
                    and datetime.fromisoformat(fields["occurred_at"]["value"]).date()
                    == datetime.fromisoformat(case["occurred_at"]).date(),
                }
            except Exception as exc:
                result = {"image": case["image"], "ok": False, "error": str(exc)}
            result["latency_ms"] = round((time.perf_counter() - started) * 1000)
            results.append(result)
    latencies = [result["latency_ms"] for result in results]
    report = {
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
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2))
    print(json.dumps({key: value for key, value in report.items() if key != "cases"}, indent=2))


if __name__ == "__main__":
    main()
