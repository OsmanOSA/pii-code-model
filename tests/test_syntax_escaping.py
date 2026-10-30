"""Quote and comment state, and escaping that keeps filled files parseable."""

from datagen.escaping import render
from datagen.syntax import Context, context_at, syntax_of, unclosed_strings

MARK = "@@"


def at_mark(document, syntax, delimiter=","):
    return context_at(document, document.index(MARK), syntax, delimiter)


def test_syntax_comes_from_the_format_field():
    assert syntax_of(".py") == "python"
    assert syntax_of("docker-compose.yml") == "compose"
    assert syntax_of(".json") == "json"
    assert syntax_of(".tsv") == "tsv"
    assert syntax_of("commit message") == "plain"


def test_python_strings_docstrings_and_comments():
    assert at_mark('x = "@@"', "python").quote == '"'
    assert at_mark("# l'équipe @@", "python").comment
    assert at_mark('"""\nl\'équipe @@\n"""', "python").quote == '"""'
    assert at_mark("x = 'it\\'s @@'", "python").quote == "'"


def test_an_apostrophe_inside_a_plain_yaml_value_opens_no_string():
    assert at_mark("title: l'équipe @@", "yaml").quote is None
    assert at_mark("title: '@@'", "yaml").quote == "'"


def test_doubled_quotes_stay_inside_sql_and_csv_strings():
    assert at_mark("VALUES ('it''s @@')", "sql").quote == "'"
    assert at_mark('a;"say ""hi"" @@";b', "csv", ";").quote == '"'


def test_escaping_per_context():
    value = 'it\'s "quoted"'
    assert render(value, at_mark('x = "@@"', "python")) == 'it\'s \\"quoted\\"'
    assert render(value, at_mark("x = '@@'", "python")) == "it\\'s \"quoted\""
    assert render(value, at_mark("VALUES ('@@')", "sql")) == 'it\'\'s "quoted"'
    assert render(value, at_mark('{"k": "@@"}', "json")) == 'it\'s \\"quoted\\"'


def test_values_that_cannot_sit_in_a_context_are_rejected():
    assert render("a;b", at_mark("x;@@;y", "csv", ";")) is None
    assert render("a b", at_mark("KEY=@@", "env")) is None
    assert render("- item", at_mark("key: @@", "yaml")) is None
    assert render("a$b", at_mark('key: "@@"', "compose")) is None
    assert render("line\nbreak", at_mark("# note @@", "python")) is None


def test_a_multiline_value_starting_a_line_keeps_its_indentation():
    context = Context("plain", None, False, "    ", False)
    assert render("first\nsecond", context) == "first\n    second"


def test_unclosed_strings_are_counted():
    assert unclosed_strings("INSERT INTO t VALUES ('a');\n", "sql") == 0
    assert unclosed_strings("INSERT INTO t VALUES ('it's');\n", "sql") == 1
