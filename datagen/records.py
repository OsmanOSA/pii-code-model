"""Fictional people and places shared by the tags of one fill.

Tags with the same number describe one record: ⟬email#1⟭ derives from the person
of ⟬person_name#1⟭, ⟬city#1⟭ is the city of ⟬fr_postal_address#1⟭, a French social
security number encodes the record's sex and birth month, a given name follows
the fashion of the birth year. A field is drawn the first time a tag asks for it.

Interface:
    LOCALES
    address_hints(slots) -> dict[int, str]   "FR" or "INTL" for numbers carrying an address tag
    sex_hints(slots) -> dict[int, str]       "F" or "M" for numbers whose tag carries a sex marker
    RecordBook(fill, address_hints, sex_hints).get(n) -> Record
    Record.number, .locale, .address_hinted, .field(name, factory)
    Record.person, .birth_date, .address, .email_domain, .company_domain
"""

from .values import dates, mail, people, places
from .values.draw import weighted

LOCALES = ("fr_FR", "en_US", "en_GB")
_MIXED_LOCALES = (("fr_FR", 50), ("en_US", 25), ("en_GB", 25))
_HOME_COUNTRY = {"fr_FR": "FR", "en_US": "US", "en_GB": "GB"}


def address_hints(slots) -> dict:
    hints = {}
    for slot in slots:
        if slot.kind == "fr_postal_address":
            hints[slot.n] = "FR"
        elif slot.kind == "postal_address":
            hints.setdefault(slot.n, "INTL")
    return hints


def sex_hints(slots) -> dict:
    return {slot.n: slot.sex.upper() for slot in slots if slot.sex}


class Record:
    def __init__(self, number: int, locale: str, fill, country: str, address_hinted: bool, sex: str | None):
        self.number = number
        self.locale = locale
        self.address_hinted = address_hinted
        self._fill, self._country, self._sex = fill, country, sex
        self._fields = {}

    def field(self, name: str, factory):
        """The record's value for name, drawn by factory the first time it is asked for."""
        if name not in self._fields:
            self._fields[name] = factory()
        return self._fields[name]

    @property
    def person(self):
        fill, born = self._fill, self.birth_date  # the given name depends on the birth year
        faker = fill.fakers[self.locale]
        return self.field("person", lambda: people.draw_person(fill.rng, faker, self.locale, born.year, self._sex,
                                                               fill.part))

    @property
    def birth_date(self):
        fill = self._fill
        return self.field("birth_date", lambda: dates.draw_birth_date(fill.rng, fill.header.get("domain", ""), fill.anchor))

    @property
    def address(self):
        fill = self._fill
        return self.field("address", lambda: places.draw_address(fill.rng, fill.fakers, self._country, fill.part))

    @property
    def email_domain(self) -> str:
        return self.field("email_domain", lambda: mail.draw_email_domain(self._fill.rng, self.locale))

    @property
    def company_domain(self) -> str:
        return self.field("company_domain", lambda: mail.draw_company_domain(self._fill.rng, self.locale))


class RecordBook:
    def __init__(self, fill, address_hints: dict, sex_hints: dict):
        self._fill, self._addresses, self._sexes, self._records = fill, address_hints, sex_hints, {}

    def get(self, n: int) -> Record:
        if n not in self._records:
            locale, hint = self._locale(), self._addresses.get(n)
            self._records[n] = Record(n, locale, self._fill, self._country(locale, hint), hint is not None,
                                      self._sexes.get(n))
        return self._records[n]

    def _locale(self) -> str:
        field = self._fill.header.get("fill_locale", "fr_FR")
        return weighted(self._fill.rng, _MIXED_LOCALES) if field == "mixed" else field

    def _country(self, locale: str, hint: str | None) -> str:
        if hint == "FR":
            return "FR"
        if hint == "INTL":
            return {"en_US": "US", "en_GB": "GB"}.get(locale) or self._fill.rng.choice(("US", "GB"))
        return _HOME_COUNTRY[locale]
