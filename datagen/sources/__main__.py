"""Command line for the value sources.

    python -m datagen.sources fetch [NAME...]   download sources into data/sources/raw/
    python -m datagen.sources build             build data/sources/tables/ from what is on disk
"""

import argparse
import sys

from .build import build
from .fetch import SOURCES, fetch, missing


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(prog="python -m datagen.sources")
    parser.add_argument("command", choices=("fetch", "build"))
    parser.add_argument("names", nargs="*", help=f"sources to fetch, among {', '.join(SOURCES)}")
    args = parser.parse_args(argv)
    unknown = [name for name in args.names if name not in SOURCES]
    if unknown:
        parser.error(f"unknown sources: {', '.join(unknown)}")
    if args.command == "fetch":
        for path in fetch(args.names or None):
            print(f"downloaded {path}")
    else:
        for path in build():
            print(f"built {path} ({path.stat().st_size // 1024} KB)")
    for name in missing():
        print(f"not on disk: {name} ({SOURCES[name].license})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
