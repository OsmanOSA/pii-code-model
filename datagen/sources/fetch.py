"""Download the value sources into data/sources/raw/<source>/.

Each source gets its own directory and a SHA-256 line in SHA256SUMS next to the
file. A source whose publisher blocks scripts has no URL: the maintainer saves
the file by hand at the path given by its entry.

Interface:
    SOURCES: name -> Source(url, file, license)
    RAW_ROOT, TABLES_ROOT
    fetch(names=None, root=RAW_ROOT) -> list[Path]    files downloaded by this call
    missing(root=RAW_ROOT) -> list[str]                sources not on disk
"""

import hashlib
import urllib.request
from dataclasses import dataclass
from pathlib import Path

DATA_ROOT = Path(__file__).resolve().parents[2] / "data" / "sources"
RAW_ROOT = DATA_ROOT / "raw"
TABLES_ROOT = DATA_ROOT / "tables"
_TIMEOUT_SECONDS = 180


@dataclass(frozen=True)
class Source:
    url: str | None  # None: downloaded by hand, the publisher blocks scripts
    file: str
    license: str


SOURCES = {
    "geonames_fr": Source("https://download.geonames.org/export/zip/FR.zip", "FR.zip", "CC BY 4.0, GeoNames"),
    "geonames_us": Source("https://download.geonames.org/export/zip/US.zip", "US.zip", "CC BY 4.0, GeoNames"),
    "geonames_gb": Source("https://download.geonames.org/export/zip/GB_full.csv.zip", "GB_full.csv.zip",
                          "CC BY 4.0, GeoNames"),
    "insee_prenoms": Source("https://www.insee.fr/fr/statistiques/fichier/8894961/prenoms-2024-nat_csv.zip",
                            "prenoms-2024-nat_csv.zip", "Licence Ouverte 2.0, INSEE"),
    "census_surnames": Source("https://www2.census.gov/topics/genealogy/2010surnames/names.zip", "names.zip",
                              "public domain, US Census Bureau"),
    "ssa_names": Source(None, "names.zip", "public domain, US Social Security Administration; "
                        "save https://www.ssa.gov/oact/babynames/names.zip by hand"),
}


def fetch(names=None, root: Path = RAW_ROOT) -> list:
    downloaded = []
    for name in names or SOURCES:
        source, target = SOURCES[name], root / name / SOURCES[name].file
        if source.url is None or target.exists():
            continue
        target.parent.mkdir(parents=True, exist_ok=True)
        with urllib.request.urlopen(source.url, timeout=_TIMEOUT_SECONDS) as response:
            target.write_bytes(response.read())
        _record_checksum(target)
        downloaded.append(target)
    return downloaded


def missing(root: Path = RAW_ROOT) -> list:
    return [name for name, source in SOURCES.items() if not (root / name / source.file).exists()]


def _record_checksum(path: Path) -> None:
    digest = hashlib.sha256(path.read_bytes()).hexdigest()
    with open(path.parent / "SHA256SUMS", "a", encoding="utf-8") as manifest:
        manifest.write(f"{digest}  {path.name}\n")
