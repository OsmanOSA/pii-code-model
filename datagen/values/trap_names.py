"""Names inside traps, drawn from the same lists as the names of people.

A trap literal may hold placeholders: ⦃given⦄ or ⦃family⦄, numbered for several
names (⦃family2⦄), cased as written (⦃Family⦄ as the name is written, ⦃FAMILY⦄
upper case, ⦃family⦄ lower case). One placeholder takes one name in a whole fill,
so `class ⦃Family⦄Exporter` and `⦃family⦄_exporter` agree. In a code identifier
the name loses accents, spaces and apostrophes. Because traps and people draw
from one list, the list alone never tells which is which: only the context does.

Interface:
    PLACEHOLDER                         compiled pattern of a placeholder
    fill_trap(text, trap_type, fill) -> str
    placeholder_problems(text) -> list[str]
"""

import re

from .draw import ascii_fold
from .people import given_name, plain_family_name

PLACEHOLDER = re.compile("⦃([A-Za-z]+?)(\\d*)⦄")
_KINDS = ("given", "family")
_QUOTES = frozenset("'\"`")
_ATTEMPTS = 20


def fill_trap(text: str, trap_type: str, fill) -> str:
    def replace(match: re.Match) -> str:
        name = _name(fill, match[1].lower(), match[2] or "1")
        if trap_type == "code_identifier":
            name = re.sub(r"[^A-Za-z0-9]", "", ascii_fold(name))
        return _cased(name, match[1])
    return PLACEHOLDER.sub(replace, text)


def placeholder_problems(text: str) -> list:
    problems = [f"unknown placeholder {match[0]} in a trap: use given or family"
                for match in PLACEHOLDER.finditer(text) if match[1].lower() not in _KINDS]
    if set(PLACEHOLDER.sub("", text)) & {"⦃", "⦄"}:
        problems.append("stray ⦃ or ⦄ in a trap")
    return problems


def _name(fill, kind: str, number: str) -> str:
    names = fill.cache.setdefault("trap_names", {})
    if (kind, number) not in names:
        names[(kind, number)] = _draw(fill, kind)
    return names[(kind, number)]


def _draw(fill, kind: str) -> str:
    rng, locale = fill.rng, fill.header.get("fill_locale", "fr_FR")
    if locale not in fill.fakers:
        locale = rng.choice(sorted(fill.fakers))  # mixed templates
    faker = fill.fakers[locale]
    for _ in range(_ATTEMPTS):
        if kind == "given":
            name = given_name(rng, faker, rng.choice("FM"), locale, rng.randint(1940, 2015), fill.part)
        else:
            name = plain_family_name(rng, faker, locale, fill.part)
        # Traps are not escaped: a name with a quote could close the string the trap sits in.
        if not _QUOTES & set(name):
            return name
    return re.sub("['\"`]", "", name)


def _cased(name: str, written: str) -> str:
    if written.isupper():
        return name.upper()
    return name if written[0].isupper() else name.lower()
