class OcrError(Exception):
    pass


class InvalidImageError(OcrError):
    pass


class EngineUnavailableError(OcrError):
    pass


class InferenceError(OcrError):
    pass
