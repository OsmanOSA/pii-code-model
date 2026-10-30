"""What a value generator receives, and random helpers shared by the generators.

Interface:
    Fill    fill-level state: random generator, Faker per locale, template header, syntax,
            date style, anchor day, split part, cache
    Draw    one request: the record of the tag's number, the fill, the tag's variant
    weighted(rng, table) -> item          table: sequence of (item, weight)
    digits(rng, count), random_string(rng, alphabet, length), fill_pattern(rng, pattern)
    pseudo_word(rng, syllables=2) -> str  invented pronounceable word, for domains and hosts
    ascii_fold(text) -> str
    domain_matches(domain, keywords) -> bool   does the template's domain field match a keyword
"""

import datetime as dt
import random
import re
import string
import unicodedata
from dataclasses import dataclass, field

DIGITS = string.digits
UPPER = string.ascii_uppercase
LOWER = string.ascii_lowercase
ALNUM = string.ascii_letters + string.digits
HEX = "0123456789abcdef"
BASE64 = ALNUM + "+/"
BASE64URL = ALNUM + "-_"

_ONSETS = ("b", "br", "c", "ch", "cl", "d", "dr", "f", "fl", "g", "gr", "j", "k", "l", "m",
           "n", "p", "pr", "qu", "r", "s", "st", "t", "tr", "v", "z")
_VOWELS = ("a", "e", "i", "o", "u", "ia", "eo", "ou", "ai")
_CODAS = ("", "", "", "", "n", "r", "l", "s")  # heavier codas made unpronounceable domains
_PATTERN_ALPHABETS = {"l": UPPER, "d": DIGITS, "a": UPPER + DIGITS}


@dataclass
class Fill:
    rng: random.Random
    fakers: dict
    header: dict
    syntax: str
    date_style: str
    anchor: dt.date                             # the fill's "today", for dates and ages
    part: str = "train"                         # "train" or "validation": which held-out values to use
    cache: dict = field(default_factory=dict)   # fill-level values shared by generators


@dataclass(frozen=True)
class Draw:
    record: object
    fill: Fill
    variant: str | None = None

    @property
    def rng(self) -> random.Random:
        return self.fill.rng

    @property
    def faker(self):
        return self.fill.fakers[self.record.locale]

    @property
    def locale(self) -> str:
        return self.record.locale


def weighted(rng: random.Random, table):
    items, weights = zip(*table)
    return rng.choices(items, weights=weights)[0]


def digits(rng: random.Random, count: int) -> str:
    return "".join(rng.choice(DIGITS) for _ in range(count))


def random_string(rng: random.Random, alphabet: str, length: int) -> str:
    return "".join(rng.choice(alphabet) for _ in range(length))


def fill_pattern(rng: random.Random, pattern: str) -> str:
    """Replace l with a letter, d with a digit, a with a letter or digit; keep the rest."""
    return "".join(rng.choice(_PATTERN_ALPHABETS[c]) if c in _PATTERN_ALPHABETS else c for c in pattern)


def pseudo_word(rng: random.Random, syllables: int = 2) -> str:
    return "".join(rng.choice(_ONSETS) + rng.choice(_VOWELS) + rng.choice(_CODAS) for _ in range(syllables))


def ascii_fold(text: str) -> str:
    return unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode("ascii")


def domain_matches(domain: str, keywords) -> bool:
    """True when a word of the template's domain is a keyword, or starts with one longer than three letters."""
    words = re.findall(r"[a-z]+", domain.lower())
    return any(word == key or (len(key) > 3 and word.startswith(key)) for word in words for key in keywords)
