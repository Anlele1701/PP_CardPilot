FROM python:3.8-slim-bullseye AS builder

WORKDIR /app
RUN apt-get update \
    && apt-get install --no-install-recommends -y build-essential \
    && rm -rf /var/lib/apt/lists/*
COPY requirements-service.txt requirements-runtime.txt requirements-models.txt ./
RUN python -m pip install --upgrade "pip<24" "setuptools<69" wheel \
    && python -m pip install -r requirements-runtime.txt

FROM builder AS model-assets

WORKDIR /model-root
RUN python -m pip install -r /app/requirements-models.txt
COPY scripts/download_models.py scripts/download_models.py
COPY mc_ocr/rotation_corrector/weights mc_ocr/rotation_corrector/weights
ARG DOWNLOAD_MODELS=0
RUN mkdir -p models \
    && if [ "$DOWNLOAD_MODELS" = "1" ]; then python scripts/download_models.py --root /model-root; fi

FROM python:3.8-slim-bullseye AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    OCR_ROOT=/app \
    OCR_WORK_DIR=/tmp/cardpilot-ocr \
    OCR_DEVICE=cpu \
    PORT=8080
WORKDIR /app
RUN apt-get update \
    && apt-get install --no-install-recommends -y libglib2.0-0 libgl1 libgomp1 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local /usr/local
COPY . .
RUN mkdir -p /tmp/cardpilot-ocr \
    && useradd --create-home --uid 10001 appuser \
    && chown -R appuser:appuser /tmp/cardpilot-ocr
COPY --chown=10001:10001 --from=model-assets /model-root/models /app/models
USER appuser
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=90s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8080/health/live', timeout=3)"
CMD ["python", "-m", "cardpilot_service.main"]
