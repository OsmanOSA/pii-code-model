"""Train and validation splits of seeds and values, invented names, and names inside traps.
Synthetic fixtures only: the name tables are invented strings."""

import json
import random

import pytest
from faker import Faker

from datagen.checker import check_template
from datagen.filler import Filler
from datagen.sources import tables
from datagen.splits import split_of
from datagen.template_file import Template
from datagen.values.people import draw_person

INVENTED_TABLE = {"F": {"1980": [[f"Fema{i:03d}", 10] for i in range(300)]},
                  "M": {"1980": [[f"Masc{i:03d}", 10] for i in range(300)]}}


def tag(body):
    return f"⟬{body}⟭"


def template(text, seed_id="traps-01/001"):
    header = {"family": "code", "format": ".py", "language": "en", "fill_locale": "en_US", "domain": "test",
              "appearance": "test", "scenario": "test"}
    return Template(seed_id, header, text, "test")


@pytest.fixture
def invented_names(tmp_path):
    (tmp_path / "given_en_US.json").write_text(json.dumps(INVENTED_TABLE), encoding="utf-8")
    tables.configure(tmp_path)


def test_about_one_seed_in_twenty_goes_to_validation():
    splits = [split_of(f"cell-{i % 7}/{i:04d}") for i in range(4000)]
    assert 0.035 < splits.count("validation") / len(splits) < 0.065
    assert split_of("cell-1/0001") == split_of("cell-1/0001")


def test_names_held_out_for_validation_never_appear_in_training(invented_names):
    rng = random.Random(0)
    train = {tables.given_names("en_US", "F", 1982, "train").draw(rng) for _ in range(3000)}
    validation = {tables.given_names("en_US", "F", 1982, "validation").draw(rng) for _ in range(3000)}
    assert train and validation and not train & validation
    assert 0.05 < len(validation) / 300 < 0.16


def test_invented_names_appear_in_training_only(invented_names):
    rng, faker = random.Random(1), Faker("en_US")
    known = {name for sex in "FM" for name, _ in INVENTED_TABLE[sex]["1980"]}
    train = [draw_person(rng, faker, "en_US", 1981, "F", "train").given for _ in range(2000)]
    validation = [draw_person(rng, faker, "en_US", 1981, "F", "validation").given for _ in range(500)]
    assert 0.02 < sum(name not in known for name in train) / len(train) < 0.07
    assert all(name in known for name in validation)


def test_a_trap_placeholder_keeps_one_name_and_code_identifiers_lose_accents():
    text = (f"from refs import {tag('trap:code_identifier|format⦃Family⦄Ref')}\n"
            f"x = {tag('trap:code_identifier|format⦃Family⦄Ref')}('{tag('person_name#1')}')\n"
            f"BRAND = '{tag('trap:company_name|⦃FAMILY2⦄ Group')}'\n")
    filler = Filler(seed=5)
    for index in range(20):
        example = filler.fill(template(text), index)
        first, second, company = (example["text"][t["start"]:t["end"]] for t in example["traps"])
        assert first == second and first.isascii() and first.startswith("format") and first.endswith("Ref")
        assert company.endswith(" Group") and company[:-6] == company[:-6].upper()
        assert example["split"] in ("train", "validation")


def test_the_checker_rejects_unknown_placeholders():
    problems = check_template(template(f"x = {tag('trap:code_identifier|get_⦃surname⦄_score')}()\n"), Filler(seed=5))
    assert any("unknown placeholder" in problem for problem in problems)
