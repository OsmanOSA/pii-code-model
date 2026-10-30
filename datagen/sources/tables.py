"""Load the value tables lazily; None when a table has not been built.

Every lookup takes a part: "train" leaves out the names and places held out for
validation, "validation" keeps only them, None keeps everything (datagen.splits).
Generators fall back to Faker when a table is missing, which keeps tests free of
downloads: they point configure() at an empty or synthetic directory.

Interface:
    configure(root)                                       read tables from another directory
    places(country, part=None) -> list | None             [postcode, city, region] entries
    given_names(locale, sex, year, part=None) -> WeightedNames | None
    family_names(locale, part=None) -> WeightedNames | None
    WeightedNames.draw(rng) -> str
"""

import bisect
import json
from functools import lru_cache
from itertools import accumulate
from pathlib import Path

from ..splits import in_part
from .build import PERIOD_YEARS
from .fetch import TABLES_ROOT

# Raw frequencies let a few names eclipse the rest (Jean was 1.7% of French draws, 171 names
# made half of them): draws follow the square root of each count, and a small share is uniform
# so that rare names appear.
FREQUENCY_EXPONENT = 0.5
RARE_SHARE = 0.05
_root = TABLES_ROOT


class WeightedNames:
    def __init__(self, entries: list):
        self.names = [name for name, _ in entries]
        self.cumulative = list(accumulate(count ** FREQUENCY_EXPONENT for _, count in entries))

    def draw(self, rng) -> str:
        if rng.random() < RARE_SHARE:
            return rng.choice(self.names)
        return self.names[bisect.bisect_right(self.cumulative, rng.random() * self.cumulative[-1])]


def configure(root: Path) -> None:
    global _root
    _root = Path(root)
    for cached in (_load, _given, family_names, places):
        cached.cache_clear()


@lru_cache(maxsize=None)
def places(country: str, part: str | None = None):
    entries = _load(f"places_{country}")
    if entries is None:
        return None
    return [entry for entry in entries if in_part(f"{entry[0]} {entry[1]}", part)] or entries


def given_names(locale: str, sex: str, year: int, part: str | None = None):
    return _given(locale, sex, year // PERIOD_YEARS * PERIOD_YEARS, part)


@lru_cache(maxsize=None)
def family_names(locale: str, part: str | None = None):
    entries = _load(f"family_{locale}")
    return _weighted(entries, part) if entries else None


@lru_cache(maxsize=None)
def _given(locale: str, sex: str, period: int, part: str | None):
    table = _load(f"given_{locale}")
    if not table or not table.get(sex):
        return None
    periods = table[sex]
    # Years outside the source (births before 1900, or after the last edition) take the nearest period.
    nearest = min(periods, key=lambda start: abs(int(start) - period))
    return _weighted(periods[nearest], part)


def _weighted(entries: list, part: str | None) -> WeightedNames:
    kept = [entry for entry in entries if in_part(entry[0], part)]
    return WeightedNames(kept or entries)  # a list too short to split keeps all its names


@lru_cache(maxsize=None)
def _load(name: str):
    path = _root / f"{name}.json"
    return json.loads(path.read_text(encoding="utf-8")) if path.exists() else None
