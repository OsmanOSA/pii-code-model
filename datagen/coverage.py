"""Counts that steer generation: how many templates hold each category, kind,
trap type and appearance mode, and how many hold no entity at all.

The pipeline's minimums (docs/data-pipeline.md) are counts of seed templates,
so a kind counts once per template however often it appears.

Interface:
    coverage(templates) -> dict
    format_coverage(counts) -> str
"""

from collections import Counter

from .schema import load_schema
from .tags import Slot, Trap, parse_text


def coverage(templates) -> dict:
    schema = load_schema()
    counts = {name: Counter() for name in ("categories", "kinds", "traps", "visible", "appearance")}
    empty = 0
    for template in templates:
        segments = parse_text(template.text)
        slots = [segment for segment in segments if isinstance(segment, Slot)]
        kinds = {slot.kind for slot in slots if slot.kind in schema.entity_kinds}
        counts["kinds"].update(kinds)
        counts["categories"].update({schema.category_of(kind) for kind in kinds})
        counts["visible"].update({slot.kind for slot in slots if slot.kind in schema.visible_kinds})
        counts["traps"].update({segment.type for segment in segments if isinstance(segment, Trap)})
        counts["appearance"].update(m.strip() for m in template.header.get("appearance", "").split(",") if m.strip())
        empty += not kinds
    return {"templates": len(templates), "empty": empty, **counts}


def format_coverage(counts: dict) -> str:
    schema = load_schema()
    missing_kinds = sorted(set(schema.entity_kinds) - set(counts["kinds"]))
    missing_traps = sorted(set(schema.trap_types) - set(counts["traps"]))
    lines = [
        f"templates: {counts['templates']}, without entities: {counts['empty']}",
        "categories: " + _listing(counts["categories"], schema.categories),
        "kinds: " + _listing(counts["kinds"]),
        "kinds never used: " + (", ".join(missing_kinds) or "none"),
        "traps: " + _listing(counts["traps"]) + (f" | never used: {', '.join(missing_traps)}" if missing_traps else ""),
        "visible: " + _listing(counts["visible"]),
        "appearance: " + _listing(counts["appearance"]),
    ]
    return "\n".join(lines)


def _listing(counter: Counter, order=None) -> str:
    keys = order if order is not None else [key for key, _ in counter.most_common()]
    return ", ".join(f"{key} {counter.get(key, 0)}" for key in keys) or "none"
