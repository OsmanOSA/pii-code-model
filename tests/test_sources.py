"""Value sources: table building filters and lookups, on synthetic files only."""

import json
import random
import zipfile

from datagen.sources import tables
from datagen.sources.build import build, title_case


def _zip(path, member, lines):
    path.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(path, "w") as archive:
        archive.writestr(member, "\n".join(lines) + "\n")


def test_title_case_handles_hyphens_apostrophes_and_mc():
    assert title_case("ALPHA-BETA") == "Alpha-Beta"
    assert title_case("N'GAMMA") == "N'Gamma"
    assert title_case("MCDELTA") == "McDelta"


def test_build_drops_arrondissements_duplicates_and_stateless_us_offices(tmp_path):
    raw, out = tmp_path / "raw", tmp_path / "tables"
    _zip(raw / "geonames_fr" / "FR.zip", "FR.txt", [
        "FR\t99001\tVilletest\tRegion\t11\tDepartement\t99\t\t\t0\t0\t5",
        "FR\t99001\tVilletest 01\tRegion\t11\tDepartement\t99\t\t\t0\t0\t5",
        "FR\t99001\tVilletest\tRegion\t11\tDepartement\t99\t\t\t0\t0\t5",
    ])
    _zip(raw / "geonames_us" / "US.zip", "US.txt", [
        "US\t00001\tTesttown\tState\tZZ\tCounty\t001\t\t\t0\t0\t1",
        "US\t00002\tAPO AE\t\t\t\t\t\t\t0\t0\t1",
    ])
    build(raw, out)
    assert json.loads((out / "places_FR.json").read_text(encoding="utf-8")) == [["99001", "Villetest", "Departement"]]
    assert json.loads((out / "places_US.json").read_text(encoding="utf-8")) == [["00001", "Testtown", "ZZ"]]


def test_given_names_follow_the_nearest_birth_period(tmp_path):
    table = {"F": {"1950": [["Aurelix", 5]], "2010": [["Zephyrine", 5]]}, "M": {"1950": [["Barnabix", 5]]}}
    (tmp_path / "given_fr_FR.json").write_text(json.dumps(table), encoding="utf-8")
    tables.configure(tmp_path)
    rng = random.Random(0)
    assert tables.given_names("fr_FR", "F", 1952).draw(rng) == "Aurelix"
    assert tables.given_names("fr_FR", "F", 2013).draw(rng) == "Zephyrine"
    assert tables.given_names("fr_FR", "F", 1999).draw(rng) == "Zephyrine"
    assert tables.given_names("en_US", "F", 1999) is None


def test_frequent_names_stay_ahead_without_eclipsing_rare_ones():
    names = tables.WeightedNames([["Frequent", 9900], ["Rare", 100]])  # 99% of births
    rng = random.Random(1)
    draws = [names.draw(rng) for _ in range(4000)]
    assert 0.8 < draws.count("Frequent") / len(draws) < 0.95
    assert draws.count("Rare") / len(draws) > 0.05
