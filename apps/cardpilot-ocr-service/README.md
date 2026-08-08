# CardPilot OCR Service

Inference-only FastAPI backend for Vietnamese receipt OCR, derived from the competition solution
[ndcuong91/MC_OCR](https://github.com/ndcuong91/MC_OCR). The service keeps the original winning
pipeline while exposing a stable single-receipt API for CardPilot:

```text
PaddleOCR detection -> deskew/page rotation -> multi-scale VietOCR -> PICK KIE -> normalized JSON
```

Training, evaluation, notebooks and the complete upstream source live in
`tools/cardpilot-ocr-research`. This application contains only the API, response normalization and
the runtime modules required for inference. Models are initialized once and reused across scans.

## API

```text
GET  /health/live
GET  /health/ready
POST /v1/receipts/scan   multipart field: image
GET  /docs
```

```bash
curl -X POST http://localhost:8080/v1/receipts/scan \
  -F 'image=@receipt.jpg;type=image/jpeg'
```

The response contains `merchant`, `address`, `occurred_at`, `total`, OCR text blocks, polygons,
OCR confidence, per-stage latency, and warnings. It is a scan draft: CardPilot must show a review
screen and create a transaction only after user confirmation.

## Lightweight development

API and normalization tests do not install the ML stack:

```bash
# Run from the CardPilot monorepo root.
pnpm ocr:setup
pnpm nx run cardpilot-ocr-service:lint
pnpm ocr:test
```

## Model artifact

The service reads one immutable artifact from `OCR_MODEL_DIR`. The artifact contains a versioned
`manifest.json` and all four pipeline models. Prepare the upstream baseline artifact with:

```bash
python -m pip install gdown
python scripts/download_models.py --root .
```

Kaggle experiments export the same structure:

```text
models/
  manifest.json
  detector/model/
  rotation/model.pth
  recognition/model.pth
  kie/model.pth
```

`GET /health/ready` returns `503` and names any missing model. The service does not silently run a
partial pipeline.

## Docker

This competition stack is tied to old x86 packages, so the image is explicitly `linux/amd64`.
Apple Silicon runs it through Docker emulation and will be slower than an x86 server.

```bash
# Run from the CardPilot monorepo root. The default embeds all checkpoints.
pnpm ocr:build
pnpm dev:ocr

# Optional smaller runtime-only image; readiness stays unavailable until
# checkpoints are supplied by another deployment mechanism.
pnpm nx run cardpilot-ocr-service:build-runtime

# Stop or follow logs.
pnpm ocr:stop
pnpm ocr:logs
```

The runtime-only `linux/amd64` image is approximately 2.6 GB. A full image also includes the
external detector, VietOCR and PICK model artifacts.
For production, build once in CI, store it in a private registry, and never download models during
container startup.

## Concurrency

The upstream model code relies on global Python module paths and native predictors. The adapter
serializes scans inside one process and Uvicorn runs one worker per container. Scale replicas behind
an asynchronous CardPilot queue:

```text
Mobile -> CardPilot API -> receipt_scan job -> OCR replicas -> draft -> user confirms -> transaction
```

Do not hold a public mobile HTTP request open while OCR runs. NestJS should return a scan ID, apply
membership quotas, and let the app poll or receive a push update.

## Research

Model training and quality evaluation are intentionally outside this deployable application. See
`tools/cardpilot-ocr-research/README.md` for the Kaggle notebook, MC-OCR dataset adapter, benchmark
runner and artifact exporter. Unit tests under `tests/` verify the HTTP and normalization contracts;
they do not evaluate model quality.

## Configuration

| Variable               | Default              | Meaning                                       |
| ---------------------- | -------------------- | --------------------------------------------- |
| `OCR_ROOT`             | repository root      | Source and model root                         |
| `OCR_MODEL_DIR`        | `models`             | Versioned model artifact directory            |
| `OCR_WORK_DIR`         | `/tmp/cardpilot-ocr` | Per-request PICK workspace                    |
| `OCR_DEVICE`           | `cpu`                | PyTorch/PICK device                           |
| `OCR_PRELOAD_MODELS`   | `true`               | Load models on the main thread during startup |
| `OCR_DEFAULT_CURRENCY` | `VND`                | Parsed total currency                         |
| `OCR_MAX_UPLOAD_BYTES` | `12582912`           | Upload limit                                  |
| `OCR_MAX_IMAGE_PIXELS` | `24000000`           | Decompression-bomb guard                      |

## License and privacy

Read [NOTICE.md](NOTICE.md) before commercial deployment. The upstream repository does not provide
a repository-level license. Receipts can contain personal and payment data: do not log OCR text or
image bytes, encrypt temporary/object storage, and delete uploaded images after the scan lifecycle.
