# CardPilot OCR Pipeline

Tai lieu nay mo ta pipeline OCR hien tai cua `cardpilot-ocr-service`. So do dau tien phan anh
runtime da duoc implement. So do cuoi la flow tich hop production duoc khuyen nghi, chua phai toan
bo deu da co trong CardPilot API.

Chi tiet vai tro cua PaddleOCR DB, CRAFT, VietOCR, PICK va normalization nam trong
[OCR technology](ocr-technology.md).

## 1. Runtime inference da implement

```mermaid
flowchart TD
    A["Client uploads receipt image"] --> B["POST /v1/receipts/scan<br/>multipart field: image"]
    B --> C["Read at most max_upload_bytes + 1"]
    C --> D{"Valid content type,<br/>size and pixel count?"}
    D -- "No" --> E["422 InvalidImageError"]
    D -- "Yes" --> F["Pillow: EXIF transpose<br/>convert RGB and encode JPEG"]

    F --> G["ReceiptScanService.scan"]
    G --> H["McOcrTop1Engine.scan"]
    H --> I["Process lock<br/>one scan per worker"]
    I --> J{"All model files ready?"}
    J -- "No" --> K["503 EngineUnavailableError"]
    J -- "Yes" --> L["OpenCV decodes JPEG"]

    subgraph OCR["MC-OCR inference pipeline"]
        direction TD
        L --> M["1. PaddleOCR DB detector<br/>image to text polygons"]
        M --> N{"Any text boxes?"}
        N -- "No" --> N1["Return no_text_detected warning"]
        N -- "Yes" --> O["2. Rotation correction<br/>filter boxes and estimate mean angle"]
        O --> P["MobileNetV3 votes 0 or 180 degrees<br/>then removes invalid 90-degree boxes"]
        P --> Q["3. Multi-scale VietOCR<br/>crop every polygon three ways"]
        Q --> R["Choose text candidate with<br/>highest confidence per box"]
        R --> S["4. PICK KIE preparation<br/>write temporary receipt.jpg and receipt.tsv"]
        S --> T["PICKDataset and BatchCollateFn"]
        T --> U["PICK model plus CRF decoding"]
        U --> V["Assign SELLER, ADDRESS,<br/>TIMESTAMP, TOTAL_COST or OTHER"]
        V --> W["Build EngineBlock list<br/>text, label, polygon, confidence"]
    end

    N1 --> X["EngineResult<br/>stage_ms and warnings"]
    W --> X
    X --> Y["normalize_result"]
    Y --> Z["Map model labels to API fields"]
    Z --> AA["Join related blocks and<br/>average confidence"]
    AA --> AB["Parse datetime and money amount"]
    AB --> AC["Add warnings for missing or<br/>unparseable fields"]
    AC --> AD["200 ScanResponse"]

    AD --> AE["scan_id, engine, model_version"]
    AD --> AF["merchant, address,<br/>occurred_at, total VND"]
    AD --> AG["raw_text, blocks, polygons,<br/>confidence, stage_ms, warnings"]

    H -. "Unexpected inference failure" .-> AH["500 InferenceError"]
```

## 2. Model loading va device

```mermaid
flowchart LR
    A["OCR_MODEL_DIR"] --> B["manifest.json"]
    B --> C["detector/model"]
    B --> D["rotation/model.pth"]
    B --> E["recognition/model.pth"]
    B --> F["kie/model.pth"]

    C --> G["Paddle inference predictor"]
    D --> H["MobileNetV3 rotation classifier"]
    E --> I["VietOCR classifier"]
    F --> J["PICK plus CRF"]

    K["OCR_DETECTOR_DEVICE"] --> G
    L["Hardcoded CPU in current adapter"] --> H
    L --> I
    M["OCR_DEVICE"] --> J

    N["FastAPI startup"] --> O{"OCR_PRELOAD_MODELS?"}
    O -- "Yes" --> P["Load and reuse all models"]
    O -- "No" --> Q["Lazy load on first scan"]
    P --> R["GET /health/ready"]
    Q --> R
```

Trong Kaggle benchmark v9, Paddle detector chay CPU trong virtualenv rieng. Rotation va VietOCR
cung dang chay CPU theo code adapter hien tai; chi PICK chay CUDA bang Torch cua Kaggle. Production
co the dung device khac sau khi adapter va Docker image dong bo duoc Paddle, Torch va CUDA.

## 3. Research va artifact lifecycle

```mermaid
flowchart LR
    A["Vietnamese receipt dataset"] --> C["Kaggle notebook"]
    B["CardPilot OCR source package"] --> C
    C --> D["Build fixed benchmark.jsonl"]
    C --> E["Download baseline checkpoints"]
    C --> F["Optional: train or fine-tune<br/>one component"]
    E --> G["Select four checkpoint paths"]
    F --> G
    G --> H["export_artifact.py"]
    H --> I["Immutable versioned artifact<br/>with manifest.json"]
    I --> J["In-process benchmark"]
    D --> J
    J --> K["Accuracy, success rate,<br/>latency and per-case report"]
    K --> L{"Meets acceptance thresholds?"}
    L -- "No" --> F
    L -- "Yes" --> M["Publish artifact"]
    M --> N["Deploy as OCR_MODEL_DIR"]
    N --> O["cardpilot-ocr-service"]
```

## 4. Production integration target

Flow nay la kien truc duoc khuyen nghi trong README. Queue, object storage va CardPilot job API
nam ngoai FastAPI OCR service va can duoc implement trong backend CardPilot.

```mermaid
sequenceDiagram
    autonumber
    participant M as Mobile app
    participant API as CardPilot API
    participant DB as CardPilot database
    participant Q as Receipt scan queue
    participant OCR as OCR service replica

    M->>API: Upload receipt
    API->>API: Authenticate and enforce quota
    API->>DB: Create receipt_scan with queued status
    API->>Q: Enqueue scan job
    API-->>M: Return scan_id immediately

    Q->>OCR: Deliver image or secure object reference
    OCR->>OCR: Run serialized MC-OCR pipeline
    OCR-->>API: Return normalized ScanResponse
    API->>DB: Save draft and review_required status
    API-->>M: Push update or expose polling result

    M->>API: Confirm or edit receipt draft
    API->>DB: Create transaction after confirmation
    API-->>M: Return confirmed transaction
```

OCR output la draft. CardPilot khong nen tao transaction tu dong truoc khi nguoi dung xac nhan
merchant, ngay giao dich va tong tien.
