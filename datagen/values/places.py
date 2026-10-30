"""Postal addresses, and the city, postcode and country that go with them.

Postcode, city and US state come together from one GeoNames entry, so they always
match; street lines come from values.streets. Without tables (tests), Faker fills
the place.

Interface:
    draw_address(rng, fakers, country, part=None) -> Address
    address(draw) -> str    full one-line address, or the street | multiline variant
    city(draw), postcode(draw), country(draw)
"""

from dataclasses import dataclass

from ..sources import tables
from .draw import weighted
from .streets import street_line

_ONE_LINE = {
    "FR": (("{street}, {postcode} {city}", 60), ("{street} {postcode} {city}", 25),
           ("{street}, {postcode} {CITY}", 10), ("{street} - {postcode} {city}", 5)),
    "US": (("{street}, {city}, {region} {postcode}", 85), ("{street}, {city} {region} {postcode}", 15)),
    "GB": (("{street}, {city} {postcode}", 50), ("{street}, {city}, {postcode}", 40), ("{street}, {CITY} {postcode}", 10)),
}
_MULTILINE = {
    "FR": (("{street}\n{postcode} {city}", 70), ("{street}\n{postcode} {CITY}", 30)),
    "US": (("{street}\n{city}, {region} {postcode}", 1),),
    "GB": (("{street}\n{city}\n{postcode}", 70), ("{street}\n{CITY}\n{postcode}", 30)),
}
_COUNTRY_NAMES = {
    "fr_FR": {"FR": ("France",), "US": ("États-Unis", "USA"), "GB": ("Royaume-Uni", "Angleterre")},
    "en_US": {"FR": ("France",), "US": ("United States", "USA", "US"), "GB": ("United Kingdom", "UK")},
    "en_GB": {"FR": ("France",), "US": ("United States", "USA"), "GB": ("United Kingdom", "UK", "England")},
}


@dataclass(frozen=True)
class Address:
    street: str
    postcode: str
    city: str
    region: str   # US state, empty elsewhere
    country: str  # FR, US or GB


def draw_address(rng, fakers: dict, country: str, part: str | None = None) -> Address:
    postcode, city, region = _place(rng, fakers, country, part)
    return Address(street_line(rng, country, part), postcode, city, region, country)


def address(draw) -> str:
    place = draw.record.address
    if draw.variant == "street":
        return place.street
    table = _MULTILINE if draw.variant == "multiline" else _ONE_LINE
    return weighted(draw.rng, table[place.country]).format(
        street=place.street, postcode=place.postcode, city=place.city, CITY=place.city.upper(), region=place.region,
    )


def city(draw) -> str:
    return draw.record.address.city


def postcode(draw) -> str:
    return draw.record.address.postcode


def country(draw) -> str:
    # A country next to an address matches it; a country alone is any country.
    if draw.record.address_hinted:
        return draw.rng.choice(_COUNTRY_NAMES[draw.locale][draw.record.address.country])
    return draw.faker.country()


def _place(rng, fakers: dict, country: str, part: str | None) -> tuple:
    entries = tables.places(country, part)
    if entries:
        postcode_, city_, region = rng.choice(entries)
        if country == "US" and rng.random() < 0.1:
            postcode_ += f"-{rng.randint(1, 9999):04d}"  # ZIP+4
        return postcode_, city_, region if country == "US" else ""
    return _faker_place(rng, fakers, country)


def _faker_place(rng, fakers: dict, country: str) -> tuple:
    if country == "US":
        faker = fakers["en_US"]
        return faker.zipcode(), faker.city(), faker.state_abbr()
    if country == "GB":
        faker = fakers["en_GB"]
        return faker.postcode(), faker.city(), ""
    return f"{rng.randint(1, 95):02d}{rng.randrange(0, 1000, 10):03d}", fakers["fr_FR"].city(), ""
