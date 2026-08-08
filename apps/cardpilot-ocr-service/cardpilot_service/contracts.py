from dataclasses import dataclass, field
from typing import List, Optional, Tuple


@dataclass(frozen=True)
class EngineBlock:
    text: str
    label: str
    polygon: Tuple[int, int, int, int, int, int, int, int]
    confidence: Optional[float] = None


@dataclass(frozen=True)
class EngineResult:
    blocks: List[EngineBlock]
    stage_ms: dict
    warnings: List[str] = field(default_factory=list)
