"""Person names and the forms derived from them.

Given names follow the birth year and sex when a table exists (INSEE for French,
SSA for American names); family names come from the Census for American names.
Faker fills the gaps. Deliberate shares of double-barrelled names and particles
add what frequency lists under-represent; rendering varies order and casing the
way each country's files do (FAMILY Given is a French administrative habit).
Collapsed handles (jdupont) are never produced: the label guide leaves them out
of version 1.

In training fills, 4% of given names and of family names are invented words: the
model then has only the context to find the person.

Interface:
    draw_person(rng, faker, locale, birth_year, sex=None, part=None) -> Person
    given_name(rng, faker, sex, locale, birth_year, part=None) -> str
    plain_family_name(rng, faker, locale, part=None) -> str   without particles or a second name
    person_name(draw) -> str    full name, or the given | family | initial | handle variant
    handle_part(name) -> str    lower-case ASCII form of a name, for handles and emails
"""

import re
from dataclasses import dataclass

from ..sources import tables
from .draw import ascii_fold, pseudo_word, weighted

INVENTED_SHARE = 0.04  # per name part, in training fills only

_PARTICLES = {
    "fr_FR": (("de ", 35), ("du ", 15), ("de la ", 12), ("d'", 18), ("Le ", 20)),
    "en_US": (("O'", 35), ("Mc", 25), ("van ", 15), ("De", 15), ("St. ", 10)),
    "en_GB": (("O'", 30), ("Mac", 20), ("Mc", 20), ("van ", 15), ("de ", 15)),
}
_FULL_FORMS = (("{given} {family}", 62), ("{family}, {given}", 6), ("{given_lower} {family_lower}", 3))
_LOCAL_FULL_FORMS = {
    "fr_FR": (("{given} {FAMILY}", 12), ("{FAMILY} {given}", 12), ("{family} {given}", 4), ("{GIVEN} {FAMILY}", 4)),
    "en_US": (("{given} {middle}. {family}", 9), ("{given} {family} {suffix}", 3), ("{GIVEN} {FAMILY}", 1)),
    "en_GB": (("{given} {middle}. {family}", 3), ("{GIVEN} {FAMILY}", 1)),
}
_UPPER_FAMILY_SHARE = {"fr_FR": 0.2, "en_US": 0.04, "en_GB": 0.04}
_INITIAL_FORMS = (("{i}. {family}", 55), ("{i}.{family}", 10), ("{i} {family}", 10), ("{family} {i}.", 15),
                  ("{i}. {FAMILY}", 10))
_HANDLE_FORMS = (("{given}.{family}", 30), ("{given}_{family}", 12), ("{given}-{family}", 12),
                 ("{g}.{family}", 12), ("{g}_{family}", 10), ("{family}.{given}", 8),
                 ("{family}_{g}", 6), ("{given}.{family}{nn}", 10))
_SUFFIXES = ("Jr.", "Sr.", "III")


@dataclass(frozen=True)
class Person:
    given: str
    family: str
    sex: str      # "F" or "M", for identifiers that encode it
    middle: str   # middle initial


def draw_person(rng, faker, locale: str, birth_year: int, sex: str | None = None, part: str | None = None) -> Person:
    sex = sex or rng.choice("FM")
    given, family = given_name(rng, faker, sex, locale, birth_year, part), _family(rng, faker, locale, part)
    if part == "train":  # an invented name leaves the model nothing but the context to find the person
        given = _invented(rng) if rng.random() < INVENTED_SHARE else given
        family = _invented(rng) if rng.random() < INVENTED_SHARE else family
    return Person(given, family, sex, rng.choice("ABCDEFGHJKLMNPRSTW"))


def person_name(draw) -> str:
    person, rng, variant = draw.record.person, draw.rng, draw.variant
    if variant == "given":
        return person.given.upper() if rng.random() < 0.03 else person.given
    if variant == "family":
        return person.family.upper() if rng.random() < _UPPER_FAMILY_SHARE[draw.locale] else person.family
    if variant == "initial":
        return _initial(rng, person)
    if variant == "handle":
        return _handle(rng, person)
    return _full(rng, person, draw.locale)


def handle_part(name: str) -> str:
    return re.sub(r"[^a-z]", "", ascii_fold(name).lower())


def given_name(rng, faker, sex: str, locale: str, birth_year: int, part: str | None = None) -> str:
    table = tables.given_names(locale, sex, birth_year, part)
    if table:
        return table.draw(rng)  # compound names come with their real frequency
    first = faker.first_name_female if sex == "F" else faker.first_name_male
    name = first()
    # Random pairs read as French (Jean-Baptiste); in English they rarely look real (Beverley-Charlene).
    if rng.random() < (0.10 if locale == "fr_FR" else 0.01):
        name = f"{name}-{first()}"
    return name


def plain_family_name(rng, faker, locale: str, part: str | None = None) -> str:
    table = tables.family_names(locale, part)
    return table.draw(rng) if table else faker.last_name()


def _family(rng, faker, locale: str, part: str | None) -> str:
    name, roll = plain_family_name(rng, faker, locale, part), rng.random()
    if roll < 0.06:
        return f"{name}-{plain_family_name(rng, faker, locale, part)}"
    if roll < 0.13:
        particle = weighted(rng, _PARTICLES[locale])
        if particle == "d'" and ascii_fold(name[:1]).upper() not in "AEIOUH":
            particle = "de "
        return particle + name
    return name


def _invented(rng) -> str:
    return pseudo_word(rng, rng.choice((2, 2, 3))).capitalize()


def _full(rng, person: Person, locale: str) -> str:
    return weighted(rng, _FULL_FORMS + _LOCAL_FULL_FORMS[locale]).format(
        given=person.given, family=person.family, GIVEN=person.given.upper(),
        FAMILY=person.family.upper(), given_lower=person.given.lower(),
        family_lower=person.family.lower(), middle=person.middle, suffix=rng.choice(_SUFFIXES),
    )


def _initial(rng, person: Person) -> str:
    initials = ".-".join(part[0] for part in person.given.split("-") if part)  # J.-P for Jean-Pierre
    return weighted(rng, _INITIAL_FORMS).format(i=initials, family=person.family, FAMILY=person.family.upper())


def _handle(rng, person: Person) -> str:
    given, family = handle_part(person.given), handle_part(person.family)
    return weighted(rng, _HANDLE_FORMS).format(given=given, family=family, g=given[:1], nn=rng.randint(1, 99))
