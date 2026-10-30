"""Tag grammar inside a template's text.

The text is a sequence of literal text and tags:
    ⟬kind#n⟭, ⟬kind:variant#n⟭   an entity or visible value; the number n links values
    ⟬kind#nf⟭, ⟬kind#nm⟭          the same, when the text fixes the person's grammatical
                                  gender (Mme, née, la patiente): record n is female or male
    ⟬trap:type|literal text⟭      text kept unlabelled and recorded as a trap

Interface:
    parse_text(text) -> list of Literal | Slot | Trap
    TagError: a malformed tag or a stray bracket, with its offset in the text
"""

import re
from dataclasses import dataclass

OPEN, CLOSE = "⟬", "⟭"
_TAG = re.compile(
    "⟬(?:trap:(?P<trap>[a-z_]+)\\|(?P<literal>[^⟬⟭]+)"
    "|(?P<kind>[a-z_]+)(?::(?P<variant>[a-z_]+))?#(?P<n>[1-9][0-9]*)(?P<sex>[fm])?)⟭"
)


class TagError(ValueError):
    """A malformed tag."""


@dataclass(frozen=True)
class Literal:
    text: str


@dataclass(frozen=True)
class Slot:
    kind: str
    variant: str | None
    n: int
    offset: int
    sex: str | None = None  # "f" or "m" when the text fixes the gender of record n

    @property
    def key(self) -> tuple:
        """Tags with the same key take the same value within one fill; the sex marker is not part of it."""
        return (self.kind, self.variant, self.n)


@dataclass(frozen=True)
class Trap:
    type: str
    text: str
    offset: int


def parse_text(text: str) -> list:
    segments, position = [], 0
    for match in _TAG.finditer(text):
        _append_literal(segments, text[position:match.start()], position)
        segments.append(_segment(match))
        position = match.end()
    _append_literal(segments, text[position:], position)
    return segments


def _append_literal(segments: list, chunk: str, offset: int) -> None:
    stray = next((i for i, char in enumerate(chunk) if char in (OPEN, CLOSE)), None)
    if stray is not None:
        excerpt = chunk[stray:stray + 40].split("\n")[0]
        raise TagError(f"malformed tag at offset {offset + stray}: {excerpt!r}")
    if chunk:
        segments.append(Literal(chunk))


def _segment(match: re.Match):
    if match["trap"]:
        return Trap(match["trap"], match["literal"], match.start())
    return Slot(match["kind"], match["variant"], int(match["n"]), match.start(), match["sex"])
