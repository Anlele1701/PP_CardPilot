import argparse
import json
import shutil
from pathlib import Path


def copy(source, destination):
    if not source.exists():
        raise FileNotFoundError(source)
    destination.parent.mkdir(parents=True, exist_ok=True)
    if source.is_dir():
        shutil.copytree(source, destination, dirs_exist_ok=True)
    else:
        shutil.copy2(source, destination)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--detector", type=Path, required=True)
    parser.add_argument("--rotation", type=Path, required=True)
    parser.add_argument("--recognition", type=Path, required=True)
    parser.add_argument("--kie", type=Path, required=True)
    parser.add_argument("--model-version", required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    files = {
        "detector": "detector/model",
        "rotation": "rotation/model.pth",
        "recognition": "recognition/model.pth",
        "kie": "kie/model.pth",
    }
    for name, relative in files.items():
        copy(getattr(args, name), args.output / relative)
    manifest = {
        "schema_version": 1,
        "model_version": args.model_version,
        "engine": "ndcuong91-mc-ocr",
        "files": files,
    }
    (args.output / "manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n", encoding="utf-8"
    )
    print("Exported model artifact to {}".format(args.output))


if __name__ == "__main__":
    main()
