"""Tag grammar and .tpl reading. Fixtures hold tags only, never a literal value."""

import pytest

from datagen.tags import Literal, TagError, parse_text
from datagen.template_file import TemplateFileError, parse_templates

TWO_TEMPLATES = (
    "⟬template⟭\nfamily: config\nformat: .env\n⟬text⟭\n"
    "A=1\n\n  B=⟬password#1⟭\n⟬end⟭\n\n"
    "⟬template⟭\nfamily: logs\n⟬text⟭\nline\n⟬end⟭\n"
)


def test_slots_traps_and_literals_keep_their_order():
    segments = parse_text('n = "⟬person_name#1⟭"  # ⟬trap:library|Flask⟭ ⟬uuid#2⟭')
    assert segments[0] == Literal('n = "')
    assert segments[1].key == ("person_name", None, 1)
    assert (segments[3].type, segments[3].text) == ("library", "Flask")
    assert segments[5].key == ("uuid", None, 2)


def test_variant_and_number_are_parsed():
    (slot,) = parse_text("⟬person_name:handle#12⟭")
    assert slot.key == ("person_name", "handle", 12)


@pytest.mark.parametrize("text", [
    "⟬person_name⟭", "⟬person_name#0⟭", "⟬Email#1⟭",
    "a ⟬ b", "a ⟭ b", "⟬trap:library|⟭",
])
def test_malformed_tags_are_rejected(text):
    with pytest.raises(TagError):
        parse_text(text)


def test_templates_keep_their_text_verbatim_and_number_their_seeds():
    first, second = parse_templates(TWO_TEMPLATES, "config-fr-01", "test", first_number=21)
    assert (first.seed_id, second.seed_id) == ("config-fr-01/021", "config-fr-01/022")
    assert first.header == {"family": "config", "format": ".env"}
    assert first.text == "A=1\n\n  B=⟬password#1⟭\n"


def test_a_template_without_end_marker_is_rejected():
    with pytest.raises(TemplateFileError):
        parse_templates("⟬template⟭\nfamily: code\n⟬text⟭\nx = 1\n", "cell", "test")
