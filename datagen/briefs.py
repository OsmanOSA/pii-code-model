"""Per-template briefs: the script, not the writing model, decides what each template holds.

A brief fixes a template's situation, format, domain, entity kinds, why the data is
there, where it sits, whether a word announces it, and its length. datagen.brief_draw
draws them; this module keeps them in templates/briefs/<cell_id>.yaml and checks a
template against its brief. A cell's file is written once: delete it to draw again.

Interface:
    PLAN, TABLES, BRIEFS, BATCH_SIZE
    write_briefs(plan=PLAN, tables=TABLES, out=BRIEFS, seed=0) -> dict cell_id -> list[brief]
    brief_problems(template, segments, directory=BRIEFS) -> list[str]
    format_briefs(briefs, batch) -> str
"""

from pathlib import Path

import yaml

from .brief_draw import draw_briefs
from .schema import load_schema
from .tags import Slot

_REPOSITORY = Path(__file__).resolve().parent.parent
PLAN = _REPOSITORY / "templates" / "plan.yaml"
TABLES = _REPOSITORY / "templates" / "sampling.yaml"
BRIEFS = _REPOSITORY / "templates" / "briefs"
BATCH_SIZE = 20
_HEADER = "# Drawn by `python -m datagen briefs`. Do not edit by hand: delete the file to draw again.\n"


def write_briefs(plan=PLAN, tables=TABLES, out=BRIEFS, seed: int = 0) -> dict:
    cells = yaml.safe_load(Path(plan).read_text(encoding="utf-8"))["cells"]
    drawn = draw_briefs(cells, yaml.safe_load(Path(tables).read_text(encoding="utf-8")), seed)
    Path(out).mkdir(parents=True, exist_ok=True)
    for cell_id, briefs in drawn.items():
        path = Path(out) / f"{cell_id}.yaml"
        if path.exists():
            drawn[cell_id] = yaml.safe_load(path.read_text(encoding="utf-8"))
        else:
            text = yaml.safe_dump(briefs, sort_keys=False, allow_unicode=True, width=200)
            path.write_text(_HEADER + text, encoding="utf-8", newline="\n")
    return drawn


def brief_problems(template, segments: list, directory=BRIEFS) -> list:
    brief = _brief_of(template.seed_id, Path(directory))
    if brief is None:
        return []
    slot, header = brief["slot"], template.header
    problems = [f"brief {slot}: {field} must be {brief[key]!r}"
                for key, field in (("format", "format"), ("domain", "domain"), ("situation", "scenario"))
                if header.get(field) != brief[key]]
    entity_kinds = load_schema().entity_kinds
    slots = [segment for segment in segments if isinstance(segment, Slot) and segment.kind in entity_kinds]
    kinds = {segment.kind for segment in slots}
    if kinds != set(brief["kinds"]):
        problems.append(f"brief {slot}: kinds must be {sorted(brief['kinds'])}, found {sorted(kinds)}")
    low, high, lines = *brief["lines"], template.text.count("\n")
    if not low <= lines <= high:
        problems.append(f"brief {slot}: {low} to {high} lines, found {lines}")
    if brief["full_record"] and _kinds_of_one_person(slots) < 4:
        problems.append(f"brief {slot}: a full record needs four kinds on one person")
    return problems


def format_briefs(briefs: list, batch: int) -> str:
    first = (batch - 1) * BATCH_SIZE
    return "\n".join(_format_one(brief) for brief in briefs[first:first + BATCH_SIZE])


def _format_one(brief: dict) -> str:
    low, high = brief["lines"]
    record = " | full record" if brief["full_record"] else ""
    return (f"{brief['slot']:>3}. [{brief['format']} / {brief['domain']}] {brief['situation']}\n"
            f"     kinds: {', '.join(brief['kinds']) or 'none'}{record} | {brief['data_role']} | "
            f"indicator {brief['indicator']} | {brief['length']} ({low}-{high} lines)\n"
            f"     reason: {brief['reason']} | position: {brief['position']}")


def _kinds_of_one_person(slots: list) -> int:
    by_number = {}
    for slot in slots:
        by_number.setdefault(slot.n, set()).add(slot.kind)
    return max((len(kinds) for kinds in by_number.values()), default=0)


def _brief_of(seed_id: str, directory: Path) -> dict | None:
    cell_id, _, number = seed_id.rpartition("/")
    path = directory / f"{cell_id}.yaml"
    if not number.isdigit() or not path.exists():
        return None
    briefs = yaml.safe_load(path.read_text(encoding="utf-8"))
    return briefs[int(number) - 1] if int(number) <= len(briefs) else None
