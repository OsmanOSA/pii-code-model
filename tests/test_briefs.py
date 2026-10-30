"""Briefs drawn from the sampling tables, and templates checked against them. Synthetic fixtures only."""

from collections import Counter

import yaml

from datagen.brief_draw import draw_briefs
from datagen.briefs import PLAN, TABLES, brief_problems, format_briefs
from datagen.tags import parse_text
from datagen.template_file import Template


def planned():
    tables = yaml.safe_load(TABLES.read_text(encoding="utf-8"))
    cells = yaml.safe_load(PLAN.read_text(encoding="utf-8"))["cells"]
    return cells, tables, draw_briefs(cells, tables)


def test_the_draw_is_reproducible_and_covers_every_planned_cell():
    cells, tables, drawn = planned()
    assert drawn == draw_briefs(cells, tables)
    assert sorted(drawn) == sorted(cell["cell_id"] for cell in cells if cell.get("briefs"))
    assert all(len(drawn[cell["cell_id"]]) == cell["templates"] for cell in cells if cell.get("briefs"))


def test_a_cell_keeps_its_share_of_empty_templates_and_of_full_records():
    cells, _, drawn = planned()
    for cell in (cell for cell in cells if cell.get("briefs")):
        briefs = drawn[cell["cell_id"]]
        assert sum(not brief["kinds"] for brief in briefs) == cell["pii_free_templates"]
        assert sum(brief["full_record"] for brief in briefs) <= 0.15 * len(briefs)
        assert all(len(brief["kinds"]) >= 4 for brief in briefs if brief["full_record"])
        assert all(1 <= len(brief["kinds"]) <= 3 for brief in briefs if brief["kinds"] and not brief["full_record"])


def test_every_batch_of_a_cell_gets_its_share_of_empty_templates():
    _, _, drawn = planned()
    briefs = drawn["natural-fr-01"]
    for start in range(0, len(briefs), 20):
        assert 3 <= sum(not brief["kinds"] for brief in briefs[start:start + 20]) <= 7


def test_data_is_accessory_in_most_templates_that_hold_some():
    _, _, drawn = planned()
    for cell_id, briefs in drawn.items():
        roles = Counter(brief["data_role"] for brief in briefs if brief["kinds"])
        assert roles["accessory"] > roles["central"], cell_id


def test_a_text_message_never_holds_what_only_a_file_would():
    _, _, drawn = planned()
    kinds = {kind for brief in drawn["natural-fr-01"] if brief["format"] == "SMS" for kind in brief["kinds"]}
    assert not kinds & {"private_key", "fr_social_security_number", "fr_tax_number", "fr_passport"}


def test_a_situation_is_not_reused_across_the_cells_of_a_family():
    _, _, drawn = planned()
    for family in ("natural", "docs", "tabular"):
        situations = [brief["situation"] for cell_id, briefs in drawn.items() if cell_id.startswith(family) for brief in briefs]
        assert len(set(situations)) == len(situations), family


def test_a_situation_brings_the_kinds_it_is_tagged_for():
    _, _, drawn = planned()
    kinds = {kind for cell_id, briefs in drawn.items() if cell_id.startswith("natural") for brief in briefs for kind in brief["kinds"]}
    assert kinds & {"fr_license_plate", "uk_license_plate", "us_license_plate"}
    assert kinds & {"password", "opaque_token"} and "iban" in kinds


def test_a_commit_message_never_gets_a_mail_signature():
    _, _, drawn = planned()
    commits = [brief for cell_id, briefs in drawn.items() if cell_id.startswith("docs") for brief in briefs
               if brief["format"] == "commit message"]
    assert commits and not any("mail client" in brief["reason"] for brief in commits)


def brief(**changes):
    return {"slot": 1, "format": "SMS", "domain": "community", "situation": "a neighbour asks", "kinds": ["phone"],
            "full_record": False, "lines": [1, 2], **changes}


def write(tmp_path, briefs):
    (tmp_path / "cell-a.yaml").write_text(yaml.safe_dump(briefs), encoding="utf-8")


def template(text, scenario="a neighbour asks"):
    return Template("cell-a/001", {"format": "SMS", "domain": "community", "scenario": scenario}, text, "test")


def problems(tmp_path, text, **changes):
    write(tmp_path, [brief(**changes)])
    return brief_problems(template(text), parse_text(text), tmp_path)


def test_a_template_that_follows_its_brief_passes(tmp_path):
    assert problems(tmp_path, "appelle ⟬phone#1⟭\n") == []


def test_a_different_kind_or_length_is_refused(tmp_path):
    assert "kinds must be" in problems(tmp_path, "appelle ⟬email#1⟭\n")[0]
    assert "lines" in problems(tmp_path, "a\nb\nappelle ⟬phone#1⟭\n")[0]


def test_a_different_scenario_is_refused(tmp_path):
    write(tmp_path, [brief()])
    text = "appelle ⟬phone#1⟭\n"
    assert "scenario" in brief_problems(template(text, "another story"), parse_text(text), tmp_path)[0]


def test_a_full_record_needs_four_kinds_on_one_person(tmp_path):
    kinds = ["person_name", "phone", "email", "birth_date"]
    spread = "⟬person_name#1⟭ ⟬phone#2⟭ ⟬email#3⟭ ⟬birth_date#4⟭\n"
    same = "⟬person_name#1⟭ ⟬phone#1⟭ ⟬email#1⟭ ⟬birth_date#1⟭\n"
    assert problems(tmp_path, same, kinds=kinds, full_record=True) == []
    assert "full record" in problems(tmp_path, spread, kinds=kinds, full_record=True)[0]


def test_a_template_without_a_brief_is_not_concerned(tmp_path):
    text = "appelle ⟬email#1⟭\n"
    assert brief_problems(Template("other/001", {}, text, "test"), parse_text(text), tmp_path) == []


def test_a_batch_is_printed_with_its_kinds_and_length():
    printed = format_briefs([brief(data_role="accessory", reason="r", position="p", indicator="absent", length="short")], 1)
    assert "phone" in printed and "1-2 lines" in printed
