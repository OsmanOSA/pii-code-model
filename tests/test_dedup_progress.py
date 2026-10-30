"""Near-duplicates between templates, and generation progress per cell. Synthetic fixtures only."""

import yaml

from datagen.dedup import near_duplicates
from datagen.filler import Filler
from datagen.progress import summary, update
from datagen.template_file import Template

BODY = ("def notify(user):\n    send(to='{0}', subject='Report ready', body='Hello {1}, your monthly report is ready.')\n"
        "    log.info('sent report to %s', '{0}')\n")


def tag(body):
    return f"⟬{body}⟭"


def template(seed_id, text):
    header = {"family": "code", "format": ".py", "language": "en", "fill_locale": "en_US", "domain": "test",
              "appearance": "test", "scenario": "test"}
    return Template(seed_id, header, text, "test")


def block(text, format_field=".py"):
    return (f"⟬template⟭\nfamily: code\nformat: {format_field}\nlanguage: en\nfill_locale: en_US\n"
            f"domain: test\nappearance: test\nscenario: test\n⟬text⟭\n{text}⟬end⟭\n\n")


def test_templates_differing_only_in_tag_numbers_or_variants_are_near_duplicates():
    first = template("cell-a/001", BODY.format(tag("email#1"), tag("person_name#1")))
    second = template("cell-b/007", BODY.format(tag("email#2"), tag("person_name:given#2")))
    other = template("cell-b/008", "SELECT count(*) FROM orders WHERE created > now() - interval '7 days';\n")
    assert near_duplicates([first, second, other]) == [("cell-a/001", "cell-b/007", 1.0)]


def test_templates_of_one_seed_are_never_compared():
    text = BODY.format(tag("email#1"), tag("person_name#1"))
    assert near_duplicates([template("cell-a/001", text), template("cell-a/001", text)]) == []


def test_progress_counts_both_targets_keeps_prompt_versions_and_names_the_next_batch(tmp_path):
    plan, progress, raw, prompt = (tmp_path / name for name in ("plan.yaml", "progress.yaml", "raw", "prompt.md"))
    plan.write_text(yaml.safe_dump({"cells": [{"cell_id": "code-en-01", "templates": 2, "pii_free_templates": 1},
                                              {"cell_id": "logs-en-01", "templates": 8, "pii_free_templates": 2}]}),
                    encoding="utf-8")
    prompt.write_text("# Prompt\n\nVersion: 7 (test)\n", encoding="utf-8")
    cell = raw / "code-en-01"
    cell.mkdir(parents=True)
    with_entities = block(f"NAME = '{tag('person_name#1')}'\nMAIL = '{tag('email#1')}'\n")
    unknown_kind = block(f"x = '{tag('persn_name#1')}'\n")
    (cell / "batch-001.tpl").write_text(with_entities + unknown_kind, encoding="utf-8")
    filler = Filler(seed=3)

    state = update(filler, plan, progress, raw, prompt)
    first = state["cells"]["code-en-01"]
    assert (first["generated"], first["validated"], first["pii_free"]) == (2, 1, 0)
    assert (first["status"], first["next_batch"]) == ("in progress", "batch-002.tpl")
    assert state["cells"]["logs-en-01"]["status"] == "todo"

    prompt.write_text("# Prompt\n\nVersion: 8 (test)\n", encoding="utf-8")
    entity_free = block(f"-- nightly cleanup, see {tag('ticket_id#1')}\nDELETE FROM sessions WHERE expires_at < now();\n", ".sql")
    (cell / "batch-002.tpl").write_text(entity_free, encoding="utf-8")
    state = update(filler, plan, progress, raw, prompt)
    done = state["cells"]["code-en-01"]
    assert (done["validated"], done["pii_free"], done["status"]) == (2, 1, "done")
    assert done["batches"]["batch-001.tpl"]["prompt"].startswith("7 ") and done["batches"]["batch-002.tpl"]["prompt"].startswith("8 ")
    assert "next: logs-en-01, batch-001.tpl, with 5 of its 20 templates holding no entity" in summary(state)
    assert yaml.safe_load(progress.read_text(encoding="utf-8"))["cells"]["code-en-01"]["pii_free"] == 1


def test_a_cell_with_enough_templates_but_too_few_without_entities_is_not_done(tmp_path):
    plan, progress, raw, prompt = (tmp_path / name for name in ("plan.yaml", "progress.yaml", "raw", "prompt.md"))
    plan.write_text(yaml.safe_dump({"cells": [{"cell_id": "code-en-01", "templates": 1, "pii_free_templates": 1}]}),
                    encoding="utf-8")
    prompt.write_text("Version: 1\n", encoding="utf-8")
    (raw / "code-en-01").mkdir(parents=True)
    (raw / "code-en-01" / "batch-001.tpl").write_text(block(f"MAIL = '{tag('email#1')}'\n"), encoding="utf-8")
    state = update(Filler(seed=3), plan, progress, raw, prompt)
    assert state["cells"]["code-en-01"]["status"] == "in progress"
    assert "with 1 of its 20 templates holding no entity" in summary(state)
