"""Generation progress per cell of templates/plan.yaml, kept in templates/progress.yaml.

After each batch a session runs `python -m datagen progress`. It counts each
cell's templates, those validated (they pass the checker and are not a
near-duplicate of another seed) and, among them, those holding no entity; it
records the prompt version each batch was written with and names the next batch,
with how many entity-free templates it should hold. A cell is done when both
targets are met. Work can stop after any batch and resume from the file; a batch
already recorded keeps its version until its file changes.

Interface:
    PLAN, PROGRESS, RAW, PROMPT
    prompt_version(path=PROMPT) -> str       "3 (sha 1a2b3c4d)": the prompt's Version line and content hash
    update(filler, plan=PLAN, progress=PROGRESS, raw=RAW, prompt=PROMPT) -> dict   also written to disk
    summary(state) -> str
"""

import datetime as dt
import hashlib
import re
from pathlib import Path

import yaml

from .checker import check_template
from .dedup import near_duplicates
from .schema import load_schema
from .tags import Slot, TagError, parse_text
from .template_file import TemplateFileError, read_templates

_REPOSITORY = Path(__file__).resolve().parent.parent
PLAN = _REPOSITORY / "templates" / "plan.yaml"
PROGRESS = _REPOSITORY / "templates" / "progress.yaml"
RAW = _REPOSITORY / "templates" / "raw"
PROMPT = _REPOSITORY / "prompts" / "template-generation.md"
BATCH_SIZE = 20
_HEADER = "# Generation progress per cell, rewritten by `python -m datagen progress`. Do not edit by hand.\n"


def prompt_version(path: Path = PROMPT) -> str:
    text = Path(path).read_text(encoding="utf-8")
    match = re.search(r"^Version: (\S+)", text, re.MULTILINE)
    return f"{match[1] if match else '?'} (sha {hashlib.sha256(text.encode('utf-8')).hexdigest()[:8]})"


def update(filler, plan: Path = PLAN, progress: Path = PROGRESS, raw: Path = RAW, prompt: Path = PROMPT) -> dict:
    cells_plan = yaml.safe_load(Path(plan).read_text(encoding="utf-8"))["cells"]
    previous = yaml.safe_load(Path(progress).read_text(encoding="utf-8")) if Path(progress).exists() else {}
    version, cells, by_cell = prompt_version(prompt), {}, {}
    for cell in cells_plan:
        recorded = ((previous or {}).get("cells") or {}).get(cell["cell_id"], {}).get("batches", {})
        batches, by_cell[cell["cell_id"]] = _batches(Path(raw) / cell["cell_id"], recorded, version, filler)
        cells[cell["cell_id"]] = {"target": cell["templates"], "pii_free_target": cell.get("pii_free_templates", 0),
                                  "batches": batches}
    duplicates = {later for _, later, _ in near_duplicates([t for ts in by_cell.values() for t in ts])}
    for cell_id, entry in cells.items():
        cells[cell_id] = _counted(cell_id, entry, duplicates, by_cell[cell_id])
    state = {"updated": dt.date.today().isoformat(), "prompt": version, "cells": cells}
    # Flow style for flat mappings keeps one line per batch, so the file stays short.
    text = yaml.safe_dump(state, sort_keys=False, allow_unicode=True, default_flow_style=None, width=200)
    Path(progress).write_text(_HEADER + text, encoding="utf-8")
    return state


def summary(state: dict) -> str:
    lines = [f"{'cell':18} {'target':>6} {'generated':>9} {'validated':>9} {'no entity':>10}  status       prompt versions"]
    for cell_id, cell in state["cells"].items():
        versions = sorted({batch.get("prompt", "?") for batch in cell["batches"].values()})
        lines.append(f"{cell_id:18} {cell['target']:>6} {cell['generated']:>9} {cell['validated']:>9} "
                     f"{cell['pii_free']:>5}/{cell['pii_free_target']:<4}  {cell['status']:12} {', '.join(versions) or '-'}")
    total = {key: sum(cell[key] for cell in state["cells"].values())
             for key in ("target", "generated", "validated", "pii_free", "pii_free_target")}
    lines.append(f"{'total':18} {total['target']:>6} {total['generated']:>9} {total['validated']:>9} "
                 f"{total['pii_free']:>5}/{total['pii_free_target']:<4}")
    pending = [(cell_id, cell) for cell_id, cell in state["cells"].items() if cell["status"] != "done"]
    if pending:
        cell_id, cell = next(((c, e) for c, e in pending if e["status"] == "in progress"), pending[0])
        lines.append(f"next: {cell_id}, {cell['next_batch']}, with {_entity_free_in_next_batch(cell)} of its "
                     f"{BATCH_SIZE} templates holding no entity (current prompt {state['prompt']})")
    return "\n".join(lines)


def _batches(directory: Path, recorded: dict, version: str, filler) -> tuple:
    batches, templates = {}, []
    for path in sorted(directory.glob("batch-*.tpl")):
        digest = hashlib.sha256(path.read_bytes()).hexdigest()[:12]
        try:
            batch_templates = read_templates(path)
        except TemplateFileError as error:
            batches[path.name] = {"templates": 0, "error": str(error), "prompt": version, "sha256": digest}
            continue
        templates += batch_templates
        old = recorded.get(path.name)
        if old and old.get("sha256") == digest and "error" not in old:
            batches[path.name] = old
            continue
        failed = " ".join(template.seed_id for template in batch_templates if check_template(template, filler))
        batches[path.name] = {"templates": len(batch_templates), "failed": failed, "prompt": version,
                              "recorded": dt.date.today().isoformat(), "sha256": digest}
    return batches, templates


def _counted(cell_id: str, entry: dict, duplicates: set, templates: list) -> dict:
    batches = entry["batches"]
    generated = sum(batch["templates"] for batch in batches.values())
    failed = {seed for batch in batches.values() for seed in batch.get("failed", "").split()}
    duplicated = sorted(seed for seed in duplicates if seed.startswith(f"{cell_id}/") and seed not in failed)
    rejected = failed | set(duplicated)
    validated = generated - len(rejected)
    pii_free = sum(1 for template in templates if template.seed_id not in rejected and _entity_free(template))
    done = validated >= entry["target"] and pii_free >= entry["pii_free_target"]
    numbers = [int(name[6:9]) for name in batches if re.fullmatch(r"batch-\d{3}\.tpl", name)]
    return {"target": entry["target"], "generated": generated, "validated": validated,
            "pii_free_target": entry["pii_free_target"], "pii_free": pii_free,
            "status": "todo" if not batches else "done" if done else "in progress",
            "next_batch": f"batch-{max(numbers, default=0) + 1:03d}.tpl", "near_duplicates": " ".join(duplicated),
            "batches": batches}


def _entity_free(template) -> bool:
    try:
        segments = parse_text(template.text)
    except TagError:
        return False
    entity_kinds = load_schema().entity_kinds
    return not any(isinstance(segment, Slot) and segment.kind in entity_kinds for segment in segments)


def _entity_free_in_next_batch(cell: dict) -> int:
    # Spread what is missing over the batches still to write, rather than leaving it to the end.
    missing = max(0, cell["pii_free_target"] - cell["pii_free"])
    remaining = max(0, cell["target"] - cell["validated"])
    if remaining == 0:
        return min(BATCH_SIZE, missing)
    return min(BATCH_SIZE, round(BATCH_SIZE * missing / remaining))
