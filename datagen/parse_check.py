"""Re-parse a filled file in its syntax, to catch a fill that broke the file.

Python, JSON, YAML, TOML, CSV and .env files are parsed; other syntaxes are
checked for strings left open, which is how a badly escaped value shows.

Interface:
    parse_error(text, syntax) -> str | None    None when the file parses
"""

import ast
import csv
import io
import json
import re
import tomllib

import yaml

from .syntax import context_at, csv_delimiter, unclosed_strings

_ENV_LINE = re.compile(r"^\s*(export\s+)?[A-Za-z_][A-Za-z0-9_.]*\s*=")


def parse_error(text: str, syntax: str) -> str | None:
    check = _PARSERS.get(syntax)
    try:
        return check(text) if check else _strings_closed(text, syntax)
    except Exception as error:  # each parser signals a broken file with its own exception type
        return f"{type(error).__name__}: {str(error).splitlines()[0][:200] if str(error) else ''}"


def _python(text: str) -> None:
    ast.parse(text)


def _json(text: str) -> None:
    json.loads(text)


def _yaml(text: str) -> None:
    list(yaml.safe_load_all(text))


def _toml(text: str) -> None:
    tomllib.loads(text)


def _table(text: str, delimiter: str) -> str | None:
    rows = [row for row in csv.reader(io.StringIO(text), delimiter=delimiter) if row]
    widths = sorted({len(row) for row in rows})
    return f"rows have {widths} fields" if len(widths) > 1 else None


def _csv(text: str) -> str | None:
    return _table(text, csv_delimiter(text.split("\n", 1)[0]))


def _tsv(text: str) -> str | None:
    return _table(text, "\t")


def _env(text: str) -> str | None:
    position = 0
    for line in text.split("\n"):
        inside_value = context_at(text, position, "env").quote is not None
        if not inside_value and line.strip() and not line.lstrip().startswith("#") and not _ENV_LINE.match(line):
            return f"line {text.count(chr(10), 0, position) + 1} is not KEY=value"
        position += len(line) + 1
    return _strings_closed(text, "env")


def _strings_closed(text: str, syntax: str) -> str | None:
    count = unclosed_strings(text, syntax)
    return f"{count} string(s) left open" if count else None


_PARSERS = {
    "python": _python, "json": _json, "yaml": _yaml, "compose": _yaml, "toml": _toml,
    "csv": _csv, "tsv": _tsv, "env": _env,
}
