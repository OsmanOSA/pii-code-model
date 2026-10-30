"""Values that must agree with their context: the maintainer's review of the pilot
found each of these broken once. Fixtures hold tags only."""

import datetime as dt
import json
import random

import pytest

from datagen.checker import check_template
from datagen.filler import Filler
from datagen.sources import tables
from datagen.tags import parse_text
from datagen.template_file import Template

FRENCH_ROLES = {"rh", "compta", "facturation", "accueil", "securite", "service-client", "ne-pas-repondre",
                "secretariat", "administration", "sinistres", "paie"}


def tag(body):
    return f"⟬{body}⟭"


def template(text, format_field="notes.txt", locale="fr_FR", domain="test"):
    header = {"family": "code", "format": format_field, "language": "fr", "fill_locale": locale,
              "domain": domain, "appearance": "test", "scenario": "test"}
    return Template("coherence-01/001", header, text, "test")


def values(example, group="entities"):
    return [example["text"][span["start"]:span["end"]] for span in example[group]]


@pytest.fixture(scope="module")
def filler():
    return Filler(seed=11)


def test_a_sex_marker_is_parsed_without_changing_the_key():
    (slot,) = parse_text(tag("person_name#3f"))
    assert (slot.sex, slot.key) == ("f", ("person_name", None, 3))


def test_a_sex_marker_fixes_the_sex_encoded_in_identifiers(filler):
    text = f"{tag('person_name#1f')} {tag('fr_social_security_number#1')} {tag('person_name#2m')} {tag('fr_social_security_number#2')}\n"
    for index in range(20):
        _, female_nir, _, male_nir = values(filler.fill(template(text), index))
        assert female_nir.startswith("2") and male_nir.startswith("1")


def test_conflicting_sex_markers_are_reported(filler):
    problems = check_template(template(f"{tag('person_name#1f')} {tag('email#1m')}\n"), filler)
    assert any("both f and m" in problem for problem in problems)


def test_stripe_keys_of_one_record_share_their_mode(filler):
    text = f'sk = "{tag("stripe_secret_key#1")}"\npk = "{tag("stripe_publishable_key#1")}"\n'
    for index in range(40):
        example = filler.fill(template(text, ".py"), index)
        (secret,), (public,) = values(example), values(example, "visible")
        mode = public.split("_")[1]
        assert secret.startswith(f"sk_{mode}_") or (mode == "live" and secret.startswith("rk_live_"))


def test_ordinary_dates_descend_and_employees_are_of_working_age(filler):
    text = f"-- {tag('date#1')} {tag('date#2')} {tag('date#3')} {tag('birth_date#4')}\nSELECT 1;\n"
    for index in range(30):
        example = filler.fill(template(text, ".sql", domain="HR"), index)
        first, second, third = (dt.date.fromisoformat(v) for v in values(example, "visible"))
        (born,) = (dt.date.fromisoformat(v) for v in values(example))
        assert first >= second >= third
        # the anchor day lies within 120 days after date#1; employees are 18 to 66 on it
        assert first.replace(year=first.year - 67) < born <= (first + dt.timedelta(days=120)).replace(year=first.year - 18)


def test_stripe_customer_ids_only_appear_where_stripe_is_plausible(filler):
    text = f"{tag('customer_id#1')}\n"
    banking = [values(filler.fill(template(text, domain="banking"), i), "visible")[0] for i in range(60)]
    shop = [values(filler.fill(template(text, domain="e-commerce"), i), "visible")[0] for i in range(60)]
    assert not any(v.startswith("cus_") for v in banking)
    assert any(v.startswith("cus_") for v in shop)


def test_role_mailboxes_follow_the_record_language(filler):
    text = f"{tag('email:generic#1')}\n"
    for index in range(60):
        (mail,) = values(filler.fill(template(text, locale="en_GB", domain="insurance"), index))
        assert mail.split("@")[0] not in FRENCH_ROLES


def test_addresses_come_from_the_place_table_when_it_exists(filler, tmp_path):
    (tmp_path / "places_FR.json").write_text(json.dumps([["99001", "Villetest", "Departement"]]), encoding="utf-8")
    tables.configure(tmp_path)
    text = f"{tag('fr_postal_address#1')} | {tag('city#1')} {tag('postcode#1')}\n"
    for index in range(10):
        address, = values(filler.fill(template(text), index))
        assert "99001" in address and "Villetest" in address.title()
