import logging

from fastapi import FastAPI, File, HTTPException, UploadFile
from fastapi.concurrency import run_in_threadpool
from fastapi.responses import JSONResponse

from cardpilot_service import __version__
from cardpilot_service.config import Settings
from cardpilot_service.engine import McOcrTop1Engine
from cardpilot_service.errors import EngineUnavailableError, InferenceError, InvalidImageError
from cardpilot_service.schemas import HealthResponse, ScanResponse
from cardpilot_service.service import ReceiptScanService

logger = logging.getLogger(__name__)
IMAGE_UPLOAD = File(...)


def create_app(settings=None, engine=None) -> FastAPI:
    settings = settings or Settings()
    engine = engine or McOcrTop1Engine(settings)
    scanner = ReceiptScanService(settings, engine)
    app = FastAPI(title="CardPilot OCR Service", version=__version__, redoc_url=None)

    @app.on_event("startup")
    async def preload_models():
        if settings.preload_models and hasattr(engine, "load"):
            try:
                engine.load()
            except EngineUnavailableError:
                logger.exception("OCR model preload failed; readiness will remain unavailable")

    @app.exception_handler(InvalidImageError)
    async def invalid_image(_request, exc):
        return JSONResponse(status_code=422, content={"detail": str(exc)})

    @app.exception_handler(EngineUnavailableError)
    async def unavailable(_request, exc):
        logger.exception("OCR engine unavailable")
        return JSONResponse(status_code=503, content={"detail": str(exc)})

    @app.exception_handler(InferenceError)
    async def inference_failed(_request, exc):
        logger.exception("OCR inference failed")
        return JSONResponse(status_code=500, content={"detail": "OCR inference failed"})

    @app.get("/health/live", response_model=HealthResponse)
    async def live():
        return HealthResponse(status="ok", engine=engine.name, details={"version": __version__})

    @app.get("/health/ready", response_model=HealthResponse)
    async def ready():
        is_ready, details = engine.readiness()
        if not is_ready:
            raise HTTPException(status_code=503, detail=details)
        return HealthResponse(status="ready", engine=engine.name, details=details)

    @app.post("/v1/receipts/scan", response_model=ScanResponse)
    async def scan(image: UploadFile = IMAGE_UPLOAD):
        content = await image.read(settings.max_upload_bytes + 1)
        content_type = image.content_type or "application/octet-stream"
        await image.close()
        return await run_in_threadpool(scanner.scan, content, content_type)

    return app


app = create_app()
