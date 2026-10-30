"""Read .tpl files into templates.

File format, defined in prompts/template-generation.md:
    ⟬template⟭
    key: value              header lines
    ⟬text⟭
    ...file, verbatim...
    ⟬end⟭

A template's seed id is <cell_id>/<nnn>: the cell is the file's directory, nnn
counts templates across the cell's batches of 20 (batch-002 starts at 021).

Interface:
    read_templates(path) -> list[Template]
    parse_templates(content, cell_id, source, first_number=1) -> list[Template]
    template_paths(paths) -> list[Path]     .tpl files under files or directories
    TemplateFileError
"""

import re
from dataclasses import dataclass
from pathlib import Path

START, TEXT, END = "⟬template⟭", "⟬text⟭", "⟬end⟭"
BATCH_SIZE = 20


class TemplateFileError(ValueError):
    """A structural error in a .tpl file."""


@dataclass(frozen=True)
class Template:
    seed_id: str
    header: dict
    text: str
    source: str  # file and line of the template, for messages


def template_paths(paths) -> list:
    found = []
    for path in map(Path, paths):
        found.extend(sorted(path.rglob("*.tpl")) if path.is_dir() else [path])
    return found


def read_templates(path: Path) -> list:
    content = Path(path).read_text(encoding="utf-8").replace("\r\n", "\n")
    batch = re.search(r"batch-(\d+)", Path(path).stem)
    first = (int(batch[1]) - 1) * BATCH_SIZE + 1 if batch else 1
    return parse_templates(content, Path(path).parent.name, str(path), first)


def parse_templates(content: str, cell_id: str, source: str, first_number: int = 1) -> list:
    lines = content.split("\n")
    templates, i = [], 0
    while i < len(lines):
        if not lines[i].strip():
            i += 1
            continue
        if lines[i].strip() != START:
            raise TemplateFileError(f"{source}:{i + 1}: expected {START}, found {lines[i][:40]!r}")
        start_line = i + 1
        header, i = _read_header(lines, i + 1, source)
        text, i = _read_text(lines, i, source)
        seed_id = f"{cell_id}/{first_number + len(templates):03d}"
        templates.append(Template(seed_id, header, text, f"{source}:{start_line}"))
    return templates


def _read_header(lines: list, i: int, source: str) -> tuple:
    header = {}
    while i < len(lines) and lines[i].strip() != TEXT:
        key, colon, value = lines[i].partition(":")
        if not colon or not key.strip():
            raise TemplateFileError(f"{source}:{i + 1}: header line without 'key: value'")
        header[key.strip()] = value.strip()
        i += 1
    if i == len(lines):
        raise TemplateFileError(f"{source}: template without {TEXT}")
    return header, i + 1


def _read_text(lines: list, i: int, source: str) -> tuple:
    start = i
    while i < len(lines) and lines[i] != END:
        if lines[i].strip() in (START, TEXT):
            raise TemplateFileError(f"{source}:{i + 1}: {lines[i].strip()} before {END}")
        i += 1
    if i == len(lines):
        raise TemplateFileError(f"{source}:{start}: template without {END}")
    # The newline before the end marker terminates the file's last line.
    return "\n".join(lines[start:i]) + "\n", i + 1
