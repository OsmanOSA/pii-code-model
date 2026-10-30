"""Fill a template with synthetic values and record where each value lands.

Two passes. The first replaces every tag with a neutral placeholder to learn the
context of each tag (inside which quotes, in a comment, at the start of a line).
The second draws, for each tag key, a value that all of its contexts accept,
writes the file and records exact character offsets (Python string indices).

Interface:
    Filler(seed=0).fill(template, index) -> dict    one JSONL record (docs/data-pipeline.md)
    FillError: an unknown kind, or no value drawn fits every context of a tag
"""

import hashlib
import random

from faker import Faker

from .escaping import render
from .records import LOCALES, RecordBook, address_hints, sex_hints
from .splits import split_of
from .schema import load_schema
from .syntax import context_at, csv_delimiter, syntax_of
from .tags import Literal, Slot, Trap, parse_text
from .values import GENERATORS, generate
from .values.dates import choose_date_style, draw_anchor
from .values.draw import Draw, Fill
from .values.trap_names import fill_trap

_ATTEMPTS = 40
_PLACEHOLDER = "x"


class FillError(ValueError):
    """A tag the filler cannot fill."""


class Filler:
    def __init__(self, seed: int = 0):
        self._seed = seed
        self._fakers = {locale: Faker(locale) for locale in LOCALES}

    def fill(self, template, index: int) -> dict:
        rng = random.Random(_stable_seed(self._seed, template.seed_id, index))
        for faker in self._fakers.values():
            faker.seed_instance(rng.getrandbits(64))
        segments = parse_text(template.text)
        syntax = syntax_of(template.header.get("format", ""))
        contexts = _contexts(segments, syntax)
        fill = Fill(rng, self._fakers, template.header, syntax, _date_style(rng, template.header, syntax),
                    draw_anchor(rng), split_of(template.seed_id))
        slots = [segment for segment in segments if isinstance(segment, Slot)]
        book = RecordBook(fill, address_hints(slots), sex_hints(slots))
        values = _draw_values(segments, contexts, book, fill)
        text, spans = _assemble(segments, contexts, values, fill)
        return _record(template, index, text, spans)


def _stable_seed(seed: int, seed_id: str, index: int) -> int:
    # Python's hash() of a string changes between runs; fills must be reproducible.
    return int.from_bytes(hashlib.sha256(f"{seed}:{seed_id}:{index}".encode()).digest()[:8], "big")


def _date_style(rng, header: dict, syntax: str) -> str:
    locale = header.get("fill_locale", "fr_FR")
    return choose_date_style(rng, rng.choice(LOCALES) if locale == "mixed" else locale, syntax)


def _contexts(segments: list, syntax: str) -> list:
    """The context of every slot (None for other segments), read with tags replaced by a placeholder."""
    pieces, positions, length = [], [], 0
    for segment in segments:
        piece = _PLACEHOLDER if isinstance(segment, Slot) else segment.text
        positions.append(length if isinstance(segment, Slot) else None)
        pieces.append(piece)
        length += len(piece)
    document = "".join(pieces)
    delimiter = csv_delimiter(document.split("\n", 1)[0])
    return [None if p is None else context_at(document, p, syntax, delimiter) for p in positions]


def _draw_values(segments: list, contexts: list, book: RecordBook, fill: Fill) -> dict:
    """One value per tag key, in order of first appearance, accepted by every context of the key."""
    occurrences = {}
    for segment, context in zip(segments, contexts):
        if isinstance(segment, Slot):
            occurrences.setdefault(segment.key, (segment, []))[1].append(context)
    return {key: _draw_one(slot, slot_contexts, book, fill) for key, (slot, slot_contexts) in occurrences.items()}


def _draw_one(slot: Slot, contexts: list, book: RecordBook, fill: Fill) -> str:
    if slot.kind not in GENERATORS:
        raise FillError(f"unknown kind {slot.kind!r}")
    draw = Draw(book.get(slot.n), fill, slot.variant)
    for _ in range(_ATTEMPTS):
        value = generate(slot.kind, draw)
        if all(render(value, context) is not None for context in contexts):
            return value
    context = contexts[0]
    raise FillError(f"{slot.kind}#{slot.n}: no value fits ({context.syntax}, quote {context.quote!r}, comment {context.comment})")


def _assemble(segments: list, contexts: list, values: dict, fill: Fill) -> tuple:
    schema = load_schema()
    parts, spans, length = [], {"entities": [], "traps": [], "visible": []}, 0
    for segment, context in zip(segments, contexts):
        if isinstance(segment, Literal):
            piece = segment.text
        elif isinstance(segment, Trap):
            piece = fill_trap(segment.text, segment.type, fill)
            spans["traps"].append({"start": length, "end": length + len(piece), "type": segment.type})
        else:
            piece = render(values[segment.key], context)
            group, span = _span(segment, length, length + len(piece), schema)
            spans[group].append(span)
        parts.append(piece)
        length += len(piece)
    return "".join(parts), spans


def _span(slot: Slot, start: int, end: int, schema) -> tuple:
    if slot.kind in schema.entity_kinds:
        span = {"start": start, "end": end, "category": schema.category_of(slot.kind), "kind": slot.kind}
        if slot.variant:
            span["variant"] = slot.variant
        return "entities", span
    return "visible", {"start": start, "end": end, "kind": slot.kind}


def _record(template, index: int, text: str, spans: dict) -> dict:
    header = template.header
    template_id = f"{template.seed_id}~t0"  # t0: the seed itself, before any transform
    return {
        "id": f"{template_id}~f{index:02d}",
        "seed_id": template.seed_id,
        "template_id": template_id,
        "text": text,
        **spans,
        "language": header.get("language"),
        "fill_locale": header.get("fill_locale"),
        "family": header.get("family"),
        "format": header.get("format"),
        "domain": header.get("domain"),
        "appearance": [mode.strip() for mode in header.get("appearance", "").split(",") if mode.strip()],
        "split": split_of(template.seed_id),
        "source": "synthetic",
    }
