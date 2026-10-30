"""Escaping of a value for the place its tag sits in.

Interface:
    render(value, context) -> str | None
        the value as it must appear in the file, or None when it cannot sit there
        (a comma in an unquoted CSV cell, a newline in a one-line string); the
        filler then draws another value.
"""

import json

from .syntax import Context

_CODE = frozenset({"python", "javascript", "java", "sql", "json", "toml"})
_ENV_BARE_FORBIDDEN = frozenset(" \t\n#'\"\\$`")
_INI_FORBIDDEN = frozenset("\n#;%")
_YAML_PLAIN_FIRST = frozenset("-?:,[]{}#&*!|>'\"%@`")


def render(value: str, context: Context) -> str | None:
    if context.syntax == "compose" and "$" in value:
        return None  # Compose interpolates $ in every value
    if context.comment:
        return None if "\n" in value else value
    if context.quote is None:
        return _bare(value, context)
    return _quoted(value, context)


def _bare(value: str, context: Context) -> str | None:
    syntax = "yaml" if context.syntax == "compose" else context.syntax
    if syntax == "env":
        return None if _ENV_BARE_FORBIDDEN & set(value) else value
    if syntax == "ini":
        return None if _INI_FORBIDDEN & set(value) else value
    if syntax in ("csv", "tsv"):
        delimiter = "\t" if syntax == "tsv" else context.delimiter
        return None if set(value) & {delimiter, '"', "\n", "\r"} else value
    if syntax == "yaml" and context.indent is None:
        return value if _yaml_plain_ok(value) else None
    if syntax == "markdown" and context.table_row:
        return None if "|" in value or "\n" in value else value
    if syntax in _CODE:
        return None if "\n" in value else value
    return _indented(value, context.indent)


def _quoted(value: str, context: Context) -> str | None:
    quote = context.quote
    syntax = "yaml" if context.syntax == "compose" else context.syntax
    if len(quote) == 3:
        if quote in value:
            return None
        # TOML ''' strings have no escapes; Python and TOML """ strings do.
        literal = (syntax, quote) == ("toml", "'''")
        return _indented(value if literal else value.replace("\\", "\\\\"), context.indent)
    if quote == "`":
        return value.replace("\\", "\\\\").replace("`", "\\`").replace("${", "\\${")
    if syntax in ("sql", "csv") or (syntax, quote) == ("yaml", "'"):
        return None if "\n" in value and syntax == "yaml" else value.replace(quote, quote * 2)
    if (syntax, quote) == ("toml", "'"):
        return None if "'" in value or "\n" in value else value
    if syntax == "env":
        return _env_quoted(value, quote)
    if quote == '"':
        return json.dumps(value, ensure_ascii=False)[1:-1]
    return value.replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n")


def _env_quoted(value: str, quote: str) -> str | None:
    if quote == "'":
        return None if "'" in value or "\n" in value else value
    if "$" in value or "`" in value:
        return None  # shells and Compose expand them inside double quotes
    return value.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n")


def _yaml_plain_ok(value: str) -> bool:
    return bool(value) and value == value.strip() and value[0] not in _YAML_PLAIN_FIRST \
        and "\n" not in value and ": " not in value and " #" not in value and not value.endswith(":")


def _indented(value: str, indent: str | None) -> str:
    # A multi-line value that starts a line keeps that line's indentation (YAML blocks, docstrings).
    return value.replace("\n", "\n" + indent) if indent else value
