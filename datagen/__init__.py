"""Data pipeline: read templates, check them, fill them with synthetic values.

Modules:
    schema         label contract, loaded from schema/labels.json
    template_file  .tpl files to Template objects
    tags           tag grammar inside a template's text
    syntax         quote and comment state at a position, per file syntax
    escaping       escaping of a value for the context its tag sits in
    records        fictional people and places shared by tags with the same number
    values         one generator per entity kind and visible kind
    filler         template to filled example, with exact character offsets
    parse_check    re-parsing of a filled file in its syntax
    checker        template checker
    coverage       counts per kind, category, appearance mode and trap type
    review         HTML page for manual review outside the agent

Command line: python -m datagen check|fill (see datagen/__main__.py).
"""
