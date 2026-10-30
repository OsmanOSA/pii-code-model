"""Near-duplicate templates, found with a MinHash sketch of their text with tags normalized.

Templates are compared with each other, never fills: the fills of one template
share its text by construction and would all look alike. Templates of one seed
(its transforms) are not compared either. A near-duplicate is the later of two
templates of different seeds whose word shingles overlap above the threshold.
The sketch is bottom-k MinHash: one hash per shingle, the k smallest kept; pairs
whose sketches share enough values are then compared exactly.

Interface:
    near_duplicates(templates, threshold=THRESHOLD) -> list[(earlier seed_id, later seed_id, similarity)]
    shingle_hashes(text) -> set[int]
"""

import hashlib
import heapq
import re
from collections import Counter, defaultdict

from .tags import Slot, TagError, parse_text

THRESHOLD = 0.8
_SHINGLE_TOKENS = 5
_SKETCH_SIZE = 64
_SHARED_FOR_CANDIDATE = 8
_TOKEN = re.compile(r"\w+|[^\w\s]")


def near_duplicates(templates, threshold: float = THRESHOLD) -> list:
    hashes = [_hashes_or_empty(template.text) for template in templates]
    pairs = []
    for i, j in _candidates(hashes):
        if templates[i].seed_id == templates[j].seed_id:
            continue  # transforms of one seed are alike by design
        similarity = len(hashes[i] & hashes[j]) / len(hashes[i] | hashes[j])
        if similarity >= threshold:
            pairs.append((templates[i].seed_id, templates[j].seed_id, round(similarity, 3)))
    return sorted(pairs, key=lambda pair: (pair[1], pair[0]))


def shingle_hashes(text: str) -> set:
    tokens = _TOKEN.findall(_normalized(text).lower())
    count = max(1, len(tokens) - _SHINGLE_TOKENS + 1)
    return {_hash(" ".join(tokens[i:i + _SHINGLE_TOKENS])) for i in range(count)}


def _normalized(text: str) -> str:
    # A tag counts as its kind: templates differing only in numbers or variants are the same file.
    return "".join(f" {segment.kind} " if isinstance(segment, Slot) else segment.text for segment in parse_text(text))


def _hashes_or_empty(text: str) -> set:
    try:
        return shingle_hashes(text)
    except TagError:
        return set()  # the checker reports malformed templates


def _hash(shingle: str) -> int:
    return int.from_bytes(hashlib.blake2b(shingle.encode("utf-8"), digest_size=8).digest(), "big")


def _candidates(hashes: list):
    """Index pairs (i < j) whose sketches share enough values to be worth an exact comparison."""
    sketches = [set(heapq.nsmallest(_SKETCH_SIZE, values)) for values in hashes]
    holders = defaultdict(list)
    for index, sketch in enumerate(sketches):
        for value in sketch:
            holders[value].append(index)
    shared = Counter()
    for indexes in holders.values():
        for position, i in enumerate(indexes):
            for j in indexes[position + 1:]:
                shared[(i, j)] += 1
    for (i, j), count in shared.items():
        # Short templates have small sketches: half of the smaller one is enough.
        if count >= min(_SHARED_FOR_CANDIDATE, max(1, min(len(sketches[i]), len(sketches[j])) // 2)):
            yield i, j
