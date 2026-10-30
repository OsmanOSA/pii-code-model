"""Training and validation splits, decided by stable hashes.

Seeds: about 5% go to validation, with every transform and fill of the seed
(docs/data-pipeline.md#splits). Values: 10% of names, communes and street names
are held out and appear only in validation fills, so validation measures names
and places the model never met in training.

Interface:
    VALIDATION_SHARE, HELD_OUT_SHARE
    split_of(seed_id) -> "train" | "validation"
    held_out(value) -> bool
    in_part(value, part) -> bool     part: "train", "validation", or None for both
"""

import hashlib

VALIDATION_SHARE = 0.05
HELD_OUT_SHARE = 0.10


def split_of(seed_id: str) -> str:
    return "validation" if _unit(seed_id, "seed") < VALIDATION_SHARE else "train"


def held_out(value: str) -> bool:
    return _unit(value.casefold(), "value") < HELD_OUT_SHARE


def in_part(value: str, part: str | None) -> bool:
    return part is None or held_out(value) == (part == "validation")


def _unit(text: str, salt: str) -> float:
    """A number in [0, 1) that depends only on the text, the same on every machine and run."""
    digest = hashlib.sha256(f"{salt}:{text}".encode("utf-8")).digest()
    return int.from_bytes(digest[:8], "big") / 2 ** 64
