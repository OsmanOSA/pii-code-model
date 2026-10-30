"""Quote and comment state at a position of a file, per syntax.

The filler needs to know whether a tag sits inside a string, which quote opened
it, or inside a comment, to escape the value that replaces the tag. This is a
lexer, not a parser: quotes, escapes and comments are all escaping depends on.

Interface:
    syntax_of(format_field) -> str     python, javascript, java, sql, json, yaml,
                                       compose, toml, env, ini, csv, tsv, markdown, plain
    csv_delimiter(first_line) -> str
    context_at(document, position, syntax, delimiter=",") -> Context
    unclosed_strings(text, syntax, delimiter=",") -> int
"""

import re
from dataclasses import dataclass

_EXTENSIONS = {
    "py": "python", "pyi": "python",
    "js": "javascript", "mjs": "javascript", "cjs": "javascript",
    "ts": "javascript", "tsx": "javascript", "jsx": "javascript",
    "java": "java", "kt": "java", "cs": "java", "go": "java", "scala": "java",
    "sql": "sql", "json": "json", "ipynb": "json", "yaml": "yaml", "yml": "yaml",
    "toml": "toml", "env": "env", "ini": "ini", "cfg": "ini", "conf": "ini",
    "properties": "ini", "csv": "csv", "tsv": "tsv", "md": "markdown",
}


@dataclass(frozen=True)
class _Lexicon:
    quotes: tuple = ()                           # longest first: a triple quote wins
    escaping_quotes: frozenset = frozenset()     # a backslash escapes the next character
    doubling_quotes: frozenset = frozenset()     # a doubled quote stands for one quote
    multiline_quotes: frozenset = frozenset()    # strings that may span lines
    line_comments: tuple = ()
    block_comment: tuple | None = None
    comment_after_space: bool = False            # YAML, .env: '#' needs a space before it
    value_starts: str | None = None              # YAML, .env, CSV: quotes open only where a value starts


_ALL = frozenset({'"""', "'''", '"', "'", "`"})
_YAML = _Lexicon(('"', "'"), frozenset({'"'}), frozenset({"'"}), frozenset({'"', "'"}), ("#",), None, True, ":-[{,")
_LEXICONS = {
    "python": _Lexicon(('"""', "'''", '"', "'"), _ALL, frozenset(), frozenset({'"""', "'''"}), ("#",)),
    "javascript": _Lexicon(("`", '"', "'"), _ALL, frozenset(), frozenset({"`"}), ("//",), ("/*", "*/")),
    "java": _Lexicon(('"""', '"', "'"), _ALL, frozenset(), frozenset({'"""'}), ("//",), ("/*", "*/")),
    "sql": _Lexicon(("'", '"'), frozenset(), frozenset({"'", '"'}), frozenset({"'", '"'}), ("--",), ("/*", "*/")),
    "json": _Lexicon(('"',), frozenset({'"'})),
    "yaml": _YAML,
    "compose": _YAML,
    "toml": _Lexicon(('"""', "'''", '"', "'"), frozenset({'"""', '"'}), frozenset(), frozenset({'"""', "'''"}), ("#",)),
    "env": _Lexicon(('"', "'"), frozenset({'"'}), frozenset(), frozenset({'"'}), ("#",), None, True, "="),
    "csv": _Lexicon(('"',), frozenset(), frozenset({'"'}), frozenset({'"'}), value_starts=""),
}


@dataclass(frozen=True)
class Context:
    syntax: str
    quote: str | None     # the quote the position sits in
    comment: bool         # the position sits in a comment
    indent: str | None    # the line's leading whitespace, when nothing precedes the position on its line
    table_row: bool       # the line is a Markdown table row
    delimiter: str = ","


@dataclass
class _State:
    quote: str | None = None
    comment: str | None = None   # "line" or "block"
    broken: int = 0              # one-line strings still open at the end of their line


def syntax_of(format_field: str) -> str:
    lowered = format_field.lower()
    for extension in re.findall(r"\.([a-z0-9]+)", lowered):
        if extension in _EXTENSIONS:
            return "compose" if "compose" in lowered else _EXTENSIONS[extension]
    return "compose" if "compose" in lowered else "plain"


def csv_delimiter(first_line: str) -> str:
    counts = {candidate: first_line.count(candidate) for candidate in (",", ";", "\t", "|")}
    best = max(counts, key=counts.get)
    return best if counts[best] else ","


def context_at(document: str, position: int, syntax: str, delimiter: str = ",") -> Context:
    state = _scan(document[:position], _LEXICONS.get(syntax, _Lexicon()), delimiter)
    line = document[document.rfind("\n", 0, position) + 1:position]
    indent = line if not line.strip() else None
    table_row = syntax == "markdown" and line.lstrip().startswith("|")
    return Context(syntax, state.quote, state.comment is not None, indent, table_row, delimiter)


def unclosed_strings(text: str, syntax: str, delimiter: str = ",") -> int:
    state = _scan(text, _LEXICONS.get(syntax, _Lexicon()), delimiter)
    return state.broken + (state.quote is not None)


def _scan(text: str, lexicon: _Lexicon, delimiter: str) -> _State:
    state, i = _State(), 0
    while i < len(text):
        i = _step(text, i, lexicon, delimiter, state)
    return state


def _step(text: str, i: int, lexicon: _Lexicon, delimiter: str, state: _State) -> int:
    """Move past the character or token at i, updating state; return the next position."""
    if text[i] == "\n":
        if state.comment == "line":
            state.comment = None
        if state.quote is not None and state.quote not in lexicon.multiline_quotes:
            state.quote, state.broken = None, state.broken + 1
        return i + 1
    if state.comment == "block":
        end = lexicon.block_comment[1]
        if text.startswith(end, i):
            state.comment = None
            return i + len(end)
        return i + 1
    if state.comment == "line":
        return i + 1
    if state.quote is not None:
        return _step_in_string(text, i, lexicon, state)
    return _step_outside(text, i, lexicon, delimiter, state)


def _step_in_string(text: str, i: int, lexicon: _Lexicon, state: _State) -> int:
    quote = state.quote
    if text[i] == "\\" and quote in lexicon.escaping_quotes:
        return i + 2
    if quote in lexicon.doubling_quotes and text.startswith(quote * 2, i):
        return i + 2
    if text.startswith(quote, i):
        state.quote = None
        return i + len(quote)
    return i + 1


def _step_outside(text: str, i: int, lexicon: _Lexicon, delimiter: str, state: _State) -> int:
    for quote in lexicon.quotes:
        if text.startswith(quote, i) and _quote_may_open(text, i, lexicon, delimiter):
            state.quote = quote
            return i + len(quote)
    for marker in lexicon.line_comments:
        if text.startswith(marker, i) and (not lexicon.comment_after_space or i == 0 or text[i - 1] in " \t\n"):
            state.comment = "line"
            return i + len(marker)
    if lexicon.block_comment and text.startswith(lexicon.block_comment[0], i):
        state.comment = "block"
        return i + len(lexicon.block_comment[0])
    return i + 1


def _quote_may_open(text: str, i: int, lexicon: _Lexicon, delimiter: str) -> bool:
    # In YAML or CSV an apostrophe inside a plain value (l'équipe) is just a character.
    if lexicon.value_starts is None:
        return True
    j = i - 1
    while j >= 0 and text[j] in " \t":
        j -= 1
    return j < 0 or text[j] == "\n" or text[j] in lexicon.value_starts or text[j] == delimiter
