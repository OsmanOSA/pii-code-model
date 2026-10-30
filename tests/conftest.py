"""Tests never read downloaded tables: generators fall back to Faker unless a test
writes synthetic tables of its own."""

import pytest

from datagen.sources import tables


@pytest.fixture(autouse=True)
def without_downloaded_tables(tmp_path_factory):
    tables.configure(tmp_path_factory.mktemp("no-tables"))
    yield
    tables.configure(tables.TABLES_ROOT)
