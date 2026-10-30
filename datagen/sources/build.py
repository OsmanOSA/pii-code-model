"""Turn the raw value sources into compact JSON tables for the filler.

Tables written to data/sources/tables/:
    places_FR, places_US, places_GB    [[postcode, city, region], ...] (GeoNames)
    given_fr_FR (INSEE), given_en_US (SSA, when saved by hand)
        {"F" | "M": {"<first year of a 5-year period>": [[name, count], ...]}}
    family_en_US (Census 2010)         [[name, count], ...]
Downloads are data: they are read with csv and zipfile only.

Interface:
    build(raw_root=RAW_ROOT, tables_root=TABLES_ROOT) -> list[Path]
    PERIOD_YEARS
"""

import csv
import io
import json
import re
import zipfile
from collections import defaultdict
from pathlib import Path

from .fetch import RAW_ROOT, SOURCES, TABLES_ROOT

PERIOD_YEARS = 5
_GB_SAMPLE_STEP = 25  # GB_full lists 1.7 million postcodes; one in 25 still covers every area


def build(raw_root: Path = RAW_ROOT, tables_root: Path = TABLES_ROOT) -> list:
    tables_root.mkdir(parents=True, exist_ok=True)
    written = []
    for name, builder in _BUILDERS.items():
        source = raw_root / name / SOURCES[name].file
        if not source.exists():
            continue
        for table, content in builder(source).items():
            path = tables_root / f"{table}.json"
            path.write_text(json.dumps(content, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
            written.append(path)
    return written


def _rows(zip_path: Path, member: str, delimiter: str):
    with zipfile.ZipFile(zip_path) as archive, archive.open(member) as handle:
        text = io.TextIOWrapper(handle, encoding="utf-8", errors="replace")
        yield from csv.reader(text, delimiter=delimiter, quoting=csv.QUOTE_NONE)


def _geonames(country: str, member: str, region_column: int, step: int = 1):
    def builder(path: Path) -> dict:
        places, seen = [], set()
        for index, row in enumerate(_rows(path, member, "\t")):
            postcode, city, region = row[1], row[2], row[region_column]
            # Arrondissements ("Paris 11"), CEDEX codes (companies' mail) and duplicates never appear
            # in a person's address; US military post offices (APO, FPO) have no state and their own format.
            unusable = re.search(r" \d+$", city) or (country == "FR" and not re.fullmatch(r"\d{5}", postcode)) \
                or (country == "US" and not region)
            if index % step or unusable or (postcode, city) in seen:
                continue
            seen.add((postcode, city))
            places.append([postcode, city, region])
        return {f"places_{country}": places}
    return builder


def _insee(path: Path) -> dict:
    rows = _rows(path, "prenoms-2024-nat.csv", ";")
    next(rows)  # header: sexe;prenom;periode;valeur
    counts = _period_counter()
    for sex, name, year, value in rows:
        if year.isdigit() and not name.startswith("_") and value.isdigit():  # "_PRENOMS_RARES" pools rare names
            counts["M" if sex == "1" else "F"][_period(int(year))][title_case(name)] += int(value)
    return {"given_fr_FR": _sorted(counts)}


def _ssa(path: Path) -> dict:
    counts = _period_counter()
    with zipfile.ZipFile(path) as archive:
        members = [m for m in archive.namelist() if re.fullmatch(r"yob\d{4}\.txt", m)]
    for member in members:
        period = _period(int(member[3:7]))
        for name, sex, value in _rows(path, member, ","):
            counts[sex][period][name] += int(value)
    return {"given_en_US": _sorted(counts)}


def _census(path: Path) -> dict:
    rows = _rows(path, "Names_2010Census.csv", ",")
    next(rows)  # header: name,rank,count,...
    names = [[title_case(row[0]), int(row[2])] for row in rows if row[0] != "ALL OTHER NAMES" and row[2].isdigit()]
    return {"family_en_US": names}


def title_case(name: str) -> str:
    """JEAN-PIERRE -> Jean-Pierre, N'GOLO -> N'Golo, MCDONALD -> McDonald."""
    titled = re.sub(r"(^|[-' ])(\w)", lambda m: m[1] + m[2].upper(), name.lower())
    return re.sub(r"^Mc(\w)", lambda m: "Mc" + m[1].upper(), titled)


def _period(year: int) -> str:
    return str(year // PERIOD_YEARS * PERIOD_YEARS)


def _period_counter():
    return {"F": defaultdict(lambda: defaultdict(int)), "M": defaultdict(lambda: defaultdict(int))}


def _sorted(counts: dict) -> dict:
    return {sex: {period: sorted(names.items(), key=lambda item: -item[1]) for period, names in periods.items()}
            for sex, periods in counts.items()}


_BUILDERS = {
    "geonames_fr": _geonames("FR", "FR.txt", region_column=5),
    "geonames_us": _geonames("US", "US.txt", region_column=4),
    "geonames_gb": _geonames("GB", "GB_full.txt", region_column=5, step=_GB_SAMPLE_STEP),
    "insee_prenoms": _insee,
    "ssa_names": _ssa,
    "census_surnames": _census,
}
