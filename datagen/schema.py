"""Label contract, loaded from schema/labels.json.

Interface:
    load_schema(path=SCHEMA_PATH) -> Schema
    Schema.categories, Schema.entity_kinds, Schema.visible_kinds, Schema.trap_types
    Schema.category_of(kind), Schema.variants_of(kind)
"""

import json
from dataclasses import dataclass
from functools import lru_cache
from pathlib import Path

SCHEMA_PATH = Path(__file__).resolve().parent.parent / "schema" / "labels.json"


@dataclass(frozen=True, eq=False)
class Schema:
    categories: tuple
    entity_kinds: dict  # kind -> {"category": str, "variants": frozenset}
    visible_kinds: frozenset
    trap_types: frozenset

    def category_of(self, kind: str) -> str:
        return self.entity_kinds[kind]["category"]

    def variants_of(self, kind: str) -> frozenset:
        return self.entity_kinds[kind]["variants"]


@lru_cache(maxsize=None)
def load_schema(path: Path = SCHEMA_PATH) -> Schema:
    raw = json.loads(Path(path).read_text(encoding="utf-8"))
    kinds = {
        kind: {"category": spec["category"], "variants": frozenset(spec.get("variants", ()))}
        for kind, spec in raw["entity_kinds"].items()
    }
    return Schema(
        categories=tuple(category["name"] for category in raw["categories"]),
        entity_kinds=kinds,
        visible_kinds=frozenset(raw["visible_kinds"]),
        trap_types=frozenset(raw["trap_types"]),
    )
