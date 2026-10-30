"""Public value sources: real names, places and postcodes for the filler.

Downloads land under data/sources/raw/<source>/ and compact tables under
data/sources/tables/, both ignored by Git. Without tables the generators fall
back to Faker, so tests never need a download.

Modules:
    fetch    download each source into its own directory, with a checksum manifest
    build    turn raw files into tables (csv and zipfile only: downloads are data, never code)
    tables   load tables lazily for the value generators

Command line: python -m datagen.sources fetch|build (see datagen/sources/__main__.py).
"""
