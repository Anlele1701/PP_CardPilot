import argparse
import json
import re
from datetime import datetime
from decimal import Decimal
from pathlib import Path

import pandas as pd


def parse_date(value):
    match = re.search(r"\d{1,2}[-/]\d{1,2}[-/]\d{4}", value)
    if not match:
        return None
    for pattern in ("%d/%m/%Y", "%d-%m-%Y"):
        try:
            return datetime.strptime(match.group(0), pattern).date().isoformat()
        except ValueError:
            pass
    return None


def parse_total(value):
    candidates = re.findall(r"(?<!\d)\d[\d.,\s]{2,}(?!\d)", value)
    amounts = [Decimal(re.sub(r"\D", "", item)) for item in candidates if re.sub(r"\D", "", item)]
    return int(max(amounts)) if amounts else None


def fields(row):
    texts = str(row.anno_texts).split("|||")
    labels = str(row.anno_labels).split("|||")
    grouped = {name: [] for name in ("SELLER", "ADDRESS", "TIMESTAMP", "TOTAL_COST")}
    for text, label in zip(texts, labels):
        if label in grouped:
            grouped[label].append(" ".join(text.split()))
    return {
        "merchant": " ".join(grouped["SELLER"]),
        "address": " ".join(grouped["ADDRESS"]),
        "occurred_at": parse_date(" ".join(grouped["TIMESTAMP"])),
        "total": parse_total(" ".join(grouped["TOTAL_COST"])),
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--dataset-root", type=Path, required=True)
    parser.add_argument("--annotations", type=Path, required=True)
    parser.add_argument("--output", type=Path, default=Path("benchmark/manifest.jsonl"))
    parser.add_argument("--limit", type=int)
    args = parser.parse_args()

    images = {
        path.name: path.resolve()
        for path in args.dataset_root.rglob("*")
        if path.suffix.lower() in {".jpg", ".jpeg", ".png"}
    }
    rows = pd.read_csv(args.annotations)
    output = []
    for row in rows.itertuples(index=False):
        image = images.get(str(row.img_id))
        if image is None:
            continue
        case = {"image": str(image), **fields(row)}
        if case["merchant"] and case["occurred_at"] and case["total"] is not None:
            output.append(case)
        if args.limit and len(output) >= args.limit:
            break

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        "".join(json.dumps(case, ensure_ascii=False) + "\n" for case in output),
        encoding="utf-8",
    )
    print("Wrote {} benchmark cases to {}".format(len(output), args.output))


if __name__ == "__main__":
    main()
