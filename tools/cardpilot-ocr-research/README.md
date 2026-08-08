# CardPilot OCR Research

This Nx project owns dataset preparation, training experiments, model-quality evaluation and model
artifact export. Nothing in this folder is copied into the production OCR image.

## Kaggle workflow

1. Create a private Kaggle Notebook and attach
   `domixi1989/vietnamese-receipts-mc-ocr-2021`.
2. Upload this research project, `apps/cardpilot-ocr-service/cardpilot_service`, and the slim
   `apps/cardpilot-ocr-service/mc_ocr` runtime as a private Kaggle Dataset named
   `cardpilot-ocr-source`.
3. Import `notebooks/cardpilot_mcocr_kaggle.ipynb` and select a GPU accelerator.
4. Keep a fixed holdout manifest. Train only one component per experiment and compare it with the
   same three frozen baseline components.
5. Export `/kaggle/working/cardpilot-ocr/artifacts/<model-version>.zip` and store it in a versioned
   artifact registry. Do not commit checkpoints or receipt images.

The MC-OCR pipeline contains four independently versioned models:

```text
PaddleOCR detector -> rotation classifier -> VietOCR recognizer -> PICK KIE
```

The upstream environment is legacy (`torch==1.5.1`, `allennlp==1.0.0` and Python 3.8-era
dependencies), while Kaggle updates its notebook image regularly. The notebook therefore does not
silently install `requirements-runtime.txt`. Pin a compatible private wheelhouse/environment, or
port the selected component to the current Kaggle image before claiming a reproducible training
run. Checkpoint architecture and serialization must remain compatible with the service engine.

A successful notebook run produces both `<model-version>-report.json` and a model artifact ZIP.
The report is research evidence; the ZIP is the only input consumed by `cardpilot-ocr-service`.

## Local commands

Prepare a manifest from downloaded Kaggle images and the upstream annotation CSV:

```bash
pnpm nx run cardpilot-ocr-research:prepare -- \
  --dataset-root /absolute/path/to/mc-ocr-2021 \
  --annotations tools/cardpilot-ocr-research/upstream/mc_ocr/data/mcocr_train_df.csv \
  --output benchmark/manifest.jsonl
```

Benchmark a running OCR service end to end:

```bash
pnpm nx run cardpilot-ocr-research:benchmark -- \
  --manifest benchmark/manifest.jsonl \
  --output benchmark/results/baseline.json
```

Export trained outputs into the runtime contract:

```bash
pnpm nx run cardpilot-ocr-research:export -- \
  --detector /path/to/detector \
  --rotation /path/to/rotation.pth \
  --recognition /path/to/recognition.pth \
  --kie /path/to/kie.pth \
  --model-version mcocr-cardpilot-v1 \
  --output artifacts/mcocr-cardpilot-v1
```

Do not use the competition dataset as the only acceptance benchmark. The upstream checkpoints may
have seen it during training or leaderboard tuning. Keep a second private set of unseen CardPilot
receipts for the production go/no-go decision.
