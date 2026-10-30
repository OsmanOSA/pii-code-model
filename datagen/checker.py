"""Template checker: header, tags, forbidden marks, and test fills that must still parse.

Interface:
    check_template(template, filler) -> list[str]    problems; empty when the template passes
    FAMILIES, LANGUAGES, FILL_LOCALES, REQUIRED_HEADER
"""

from .briefs import brief_problems
from .filler import FillError
from .parse_check import parse_error
from .schema import load_schema
from .syntax import syntax_of
from .tags import Slot, TagError, Trap, parse_text
from .values.trap_names import placeholder_problems

FAMILIES = ("code", "config", "logs", "tabular", "docs", "natural")
LANGUAGES = ("fr", "en", "mixed")
FILL_LOCALES = ("fr_FR", "en_US", "en_GB", "mixed")
REQUIRED_HEADER = ("family", "format", "language", "fill_locale", "domain", "appearance", "scenario")
# The product's pseudonym tokens and the benchmark's markup: a template holding one
# was copied from text the Privacy Guard hook had already masked.
_FORBIDDEN_MARKS = ("⟦", "⟧", "⟪", "⟫")
TEST_FILLS = 3


def check_template(template, filler) -> list:
    problems = _header_problems(template.header) + _forbidden_marks(template.text)
    try:
        segments = parse_text(template.text)
    except TagError as error:
        return problems + [str(error)]
    problems += _tag_problems(segments) + brief_problems(template, segments)
    if not problems:
        problems += _fill_problems(template, filler)
    return problems


def _header_problems(header: dict) -> list:
    problems = [f"header: missing {key}" for key in REQUIRED_HEADER if not header.get(key)]
    for key, allowed in (("family", FAMILIES), ("language", LANGUAGES), ("fill_locale", FILL_LOCALES)):
        if header.get(key) and header[key] not in allowed:
            problems.append(f"header: {key} {header[key]!r} is not one of {', '.join(allowed)}")
    return problems


def _forbidden_marks(text: str) -> list:
    return [f"text holds {mark!r}, a masked token or benchmark markup" for mark in _FORBIDDEN_MARKS if mark in text]


def _tag_problems(segments: list) -> list:
    schema = load_schema()
    slots = [segment for segment in segments if isinstance(segment, Slot)]
    problems = [problem for slot in slots for problem in _slot_problems(slot, schema)]
    traps = [segment for segment in segments if isinstance(segment, Trap)]
    problems += [f"unknown trap type {trap.type!r} at offset {trap.offset}"
                 for trap in traps if trap.type not in schema.trap_types]
    problems += [problem for trap in traps for problem in placeholder_problems(trap.text)]
    return problems + _numbering_problems(slots)


def _slot_problems(slot: Slot, schema) -> list:
    tag = f"{slot.kind}{':' + slot.variant if slot.variant else ''}#{slot.n} at offset {slot.offset}"
    if slot.kind in schema.entity_kinds:
        if slot.variant and slot.variant not in schema.variants_of(slot.kind):
            return [f"unknown variant in {tag}"]
        return []
    if slot.kind in schema.visible_kinds:
        return [f"visible kinds take no variant: {tag}"] if slot.variant else []
    return [f"unknown kind in {tag}"]


def _numbering_problems(slots: list) -> list:
    """Tags sharing a number describe one record; some combinations cannot."""
    kinds_by_number, sexes_by_number = {}, {}
    for slot in slots:
        kinds_by_number.setdefault(slot.n, set()).add((slot.kind, slot.variant))
        if slot.sex:
            sexes_by_number.setdefault(slot.n, set()).add(slot.sex)
    problems = [f"#{n} is marked both f and m" for n, sexes in sorted(sexes_by_number.items()) if len(sexes) > 1]
    for n, kinds in sorted(kinds_by_number.items()):
        names = {kind for kind, _ in kinds}
        if {"fr_postal_address", "postal_address"} <= names:
            problems.append(f"#{n} holds both a French and a foreign address")
        if ("email", "generic") in kinds and "person_name" in names:
            problems.append(f"#{n} is a person and a role mailbox: give the mailbox its own number")
    return problems


def _fill_problems(template, filler) -> list:
    syntax = syntax_of(template.header["format"])
    problems = []
    for index in range(TEST_FILLS):
        try:
            text = filler.fill(template, index)["text"]
        except FillError as error:
            return problems + [f"fill {index}: {error}"]
        problem = parse_error(text, syntax)
        if problem:
            problems.append(f"fill {index} does not parse as {syntax}: {problem}")
    return problems
