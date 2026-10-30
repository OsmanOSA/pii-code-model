"""End-to-end fills of small synthetic templates: exact offsets, consistent records,
parseable output, and a generator for every kind of the schema."""

import json

import pytest

from datagen.checker import check_template
from datagen.filler import Filler
from datagen.parse_check import parse_error
from datagen.schema import load_schema
from datagen.template_file import Template
from datagen.values import GENERATORS
from datagen.values.people import handle_part

OPEN, CLOSE = "⟬", "⟭"


def tag(body):
    return f"{OPEN}{body}{CLOSE}"


def template(text, format_field, locale="fr_FR"):
    header = {"family": "code", "format": format_field, "language": "fr", "fill_locale": locale,
              "domain": "test", "appearance": "test", "scenario": "test"}
    return Template("test-01/001", header, text, "test")


def span_texts(example, group="entities"):
    return [example["text"][span["start"]:span["end"]] for span in example[group]]


@pytest.fixture(scope="module")
def filler():
    return Filler(seed=7)


def test_every_schema_kind_has_a_generator():
    schema = load_schema()
    assert set(schema.entity_kinds) | set(schema.visible_kinds) <= set(GENERATORS)


def test_json_values_decode_back_from_their_spans(filler):
    text = ('{"name": "' + tag("person_name#1") + '", "key": "' + tag("private_key#2") + '", "addr": "'
            + tag("fr_postal_address:multiline#1") + '", "id": "' + tag("uuid#1") + '"}\n')
    for index in range(20):
        example = filler.fill(template(text, ".json"), index)
        document = json.loads(example["text"])
        decoded = [json.loads(f'"{value}"') for value in span_texts(example)]
        assert decoded == [document["name"], document["key"], document["addr"]]
        assert document["key"].startswith("-----BEGIN ")


def test_a_repeated_tag_repeats_its_value_and_another_number_differs(filler):
    text = f"a={tag('person_name#1')}\nb={tag('person_name#1')}\nc={tag('person_name#2')}\n"
    first, again, other = span_texts(filler.fill(template(text, "notes.txt"), 0))
    assert first == again != other


def test_an_email_derives_from_the_person_with_the_same_number(filler):
    text = f"{tag('person_name:family#1')} {tag('person_name:given#1')} {tag('email#1')}\n"
    for index in range(20):
        family, given, mail = span_texts(filler.fill(template(text, "notes.txt"), index))
        local = mail.split("@")[0]
        assert handle_part(family) in local or handle_part(given) in local


@pytest.mark.parametrize("text, format_field, syntax", [
    ("INSERT INTO t VALUES ('" + tag("person_name#1") + "', '" + tag("fr_postal_address#1") + "', '"
     + tag("password#1") + "');\n", ".sql", "sql"),
    ("NAME = '" + tag("person_name#1") + "'\nADDRESS = \"" + tag("fr_postal_address:multiline#1")
     + "\"\nPWD = '" + tag("password#2") + "'  # " + tag("trap:library|Flask") + "\n", ".py", "python"),
    ("nom;adresse;tel\n" + tag("person_name#1") + ';"' + tag("fr_postal_address#1") + '";' + tag("phone#1") + "\n",
     ".csv", "csv"),
    ("DB_URL=postgres://app:" + tag("url_password#1") + "@" + tag("hostname#1") + "/db\nKEY=\""
     + tag("private_key#2") + '"\n', ".env", "env"),
    ("db:\n  password: \"" + tag("password#1") + "\"\n  owner: " + tag("email#2") + "\n", "docker-compose.yml", "compose"),
])
def test_fills_still_parse(filler, text, format_field, syntax):
    for index in range(30):
        example = filler.fill(template(text, format_field), index)
        assert parse_error(example["text"], syntax) is None, example["id"]


def test_every_kind_and_variant_fills_in_every_locale(filler):
    schema, lines, n = load_schema(), [], 0
    for kind in sorted(schema.entity_kinds):
        n += 1
        lines += [tag(f"{kind}#{n}")] + [tag(f"{kind}:{variant}#{n}") for variant in sorted(schema.variants_of(kind))]
    entity_count = len(lines)
    lines += [tag(f"{kind}#{n + i}") for i, kind in enumerate(sorted(schema.visible_kinds), 1)]
    for locale in ("fr_FR", "en_US", "en_GB", "mixed"):
        for index in range(3):
            example = filler.fill(template("\n".join(lines) + "\n", "notes.txt", locale), index)
            assert len(example["entities"]) == entity_count
            assert all(span["end"] > span["start"] for span in example["entities"] + example["visible"])


def test_the_checker_reports_unknown_kinds_and_masked_tokens(filler):
    bad = template("x = '" + tag("persn_name#1") + "' ⟦TOKEN⟧\n", ".py")
    problems = check_template(bad, filler)
    assert any("unknown kind" in problem for problem in problems)
    assert any("masked token" in problem for problem in problems)
    good = template("x = '" + tag("person_name#1") + "'\n", ".py")
    assert check_template(good, filler) == []
