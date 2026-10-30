"""Command line of the data pipeline.

    python -m datagen check PATH... [--seed 0]
        check every template under PATH (files or directories), near-duplicates
        included, print problems and coverage; exit code 1 when a template fails
    python -m datagen fill PATH... --out data/NAME [--fills 3] [--seed 0]
        write NAME/filled.jsonl and NAME/review.html; prints counts only
    python -m datagen progress [--seed 0]
        count each cell of templates/plan.yaml, record new batches and their prompt
        version in templates/progress.yaml, print the table and the next batch
    python -m datagen briefs CELL [--batch 1]
        draw the briefs of the planned cells into templates/briefs/ (an existing file
        is kept) and print one batch of CELL
"""

import argparse
import json
import sys
from collections import Counter
from pathlib import Path

from .briefs import format_briefs, write_briefs
from .checker import check_template
from .coverage import coverage, format_coverage
from .dedup import near_duplicates
from .filler import FillError, Filler
from .parse_check import parse_error
from .progress import summary, update
from .review import review_page
from .syntax import syntax_of
from .template_file import read_templates, template_paths

_REPOSITORY = Path(__file__).resolve().parent.parent


def main(argv=None) -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")  # Windows consoles default to cp1252
    args = _parser().parse_args(argv)
    paths = getattr(args, "paths", [])
    templates = [template for path in template_paths(paths) for template in read_templates(path)]
    return args.command(templates, args)


def _parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="python -m datagen")
    commands = parser.add_subparsers(required=True)
    check = commands.add_parser("check", help="check templates and print coverage")
    check.set_defaults(command=_check)
    fill = commands.add_parser("fill", help="fill templates, write JSONL and a review page")
    fill.add_argument("--out", required=True, type=Path)
    fill.add_argument("--fills", type=int, default=3)
    fill.set_defaults(command=_fill)
    progress = commands.add_parser("progress", help="record and print the generation progress per cell")
    progress.set_defaults(command=_progress)
    progress.add_argument("--seed", type=int, default=0)
    briefs = commands.add_parser("briefs", help="draw the briefs of the planned cells and print one batch")
    briefs.add_argument("cell")
    briefs.add_argument("--batch", type=int, default=1)
    briefs.set_defaults(command=_briefs)
    for command in (check, fill):
        command.add_argument("paths", nargs="+")
        command.add_argument("--seed", type=int, default=0)
    return parser


def _check(templates: list, args) -> int:
    filler, failed = Filler(args.seed), set()
    for template in templates:
        problems = check_template(template, filler)
        for problem in problems:
            failed.add(template.seed_id)
            print(f"{template.seed_id} ({template.source}): {problem}")
    for earlier, later, similarity in near_duplicates(templates):
        failed.add(later)
        print(f"{later}: near-duplicate of {earlier} (similarity {similarity}), write another scenario")
    print(format_coverage(coverage(templates)))
    print(f"{len(templates) - len(failed)}/{len(templates)} templates pass")
    return 1 if failed else 0


def _progress(templates: list, args) -> int:
    print(summary(update(Filler(args.seed))))
    return 0


def _briefs(templates: list, args) -> int:
    print(format_briefs(write_briefs()[args.cell], args.batch))
    return 0


def _fill(templates: list, args) -> int:
    if not _outside_git(args.out):
        print(f"refused: {args.out} is in the repository but not under data/, which Git ignores")
        return 2
    filler, examples, failures = Filler(args.seed), [], Counter()
    for template in templates:
        syntax = syntax_of(template.header.get("format", ""))
        for index in range(args.fills):
            try:
                example = filler.fill(template, index)
            except FillError:
                failures[f"{template.seed_id}: no value fits a tag"] += 1
                continue
            if parse_error(example["text"], syntax):
                failures[f"{template.seed_id}: does not parse as {syntax}"] += 1
                continue
            examples.append(example)
    _write(args.out, templates, examples)
    _print_summary(examples, failures, args.out)
    return 1 if failures else 0


def _outside_git(out: Path) -> bool:
    resolved = out.resolve()
    return not resolved.is_relative_to(_REPOSITORY) or resolved.is_relative_to(_REPOSITORY / "data")


def _write(out: Path, templates: list, examples: list) -> None:
    out.mkdir(parents=True, exist_ok=True)
    with open(out / "filled.jsonl", "w", encoding="utf-8", newline="\n") as handle:
        for example in examples:
            handle.write(json.dumps(example, ensure_ascii=False) + "\n")
    (out / "review.html").write_text(review_page(templates, examples), encoding="utf-8")


def _print_summary(examples: list, failures: Counter, out: Path) -> None:
    categories = Counter(entity["category"] for example in examples for entity in example["entities"])
    traps = Counter(trap["type"] for example in examples for trap in example["traps"])
    print(f"examples: {len(examples)}, failures: {sum(failures.values())}")
    for failure, count in failures.items():
        print(f"  {failure} ({count})")
    print("entities: " + (", ".join(f"{name} {count}" for name, count in categories.most_common()) or "none"))
    print("traps: " + (", ".join(f"{name} {count}" for name, count in traps.most_common()) or "none"))
    print(f"visible values: {sum(len(example['visible']) for example in examples)}")
    print(f"written: {out / 'filled.jsonl'} and {out / 'review.html'}")


if __name__ == "__main__":
    sys.exit(main())
