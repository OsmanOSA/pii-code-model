"""French identity and administrative numbers.

The social security number encodes the record's sex, birth year and birth month,
as real ones do. Numbers with a check digit carry a wrong one in 5% of cases.

Interface (each takes a Draw): social_security_number, tax_number, identity_card,
passport, driving_licence, license_plate, siren, siret
"""

from .checksums import damaged, fr_tax_key, luhn_digit, nir_key
from .draw import DIGITS, UPPER, digits, random_string, weighted

_PLATE_LETTERS = "ABCDEFGHJKLMNPQRSTVWXYZ"  # SIV plates skip I, O and U


def social_security_number(draw) -> str:
    rng, person, born = draw.rng, draw.record.person, draw.record.birth_date
    department, commune = _birthplace(rng)
    sex = "2" if person.sex == "F" else "1"
    body = f"{sex}{born.year % 100:02d}{born.month:02d}{department}{commune}{rng.randint(1, 999):03d}"
    key = damaged(rng, nir_key(body))
    form = weighted(rng, (("spaced", 50), ("compact", 40), ("key_apart", 10)))
    if form == "compact":
        return body + key
    if form == "key_apart":
        return f"{body} {key}"
    return " ".join((body[0], body[1:3], body[3:5], body[5:7], body[7:10], body[10:13], key))


def tax_number(draw) -> str:
    rng = draw.rng
    first10 = rng.choice("0123") + digits(rng, 9)
    number = first10 + damaged(rng, fr_tax_key(first10))
    if rng.random() < 0.6:
        return number
    return " ".join((number[:2], number[2:4], number[4:7], number[7:10], number[10:]))


def identity_card(draw) -> str:
    rng = draw.rng
    if rng.random() < 0.55:  # cards issued since 2021: nine letters and digits
        return random_string(rng, UPPER + DIGITS, 9)
    # older cards: issue year and month, department and office, sequence number
    return f"{rng.randint(4, 21):02d}{rng.randint(1, 12):02d}{rng.randint(1, 95):02d}{rng.randint(0, 9)}{digits(rng, 5)}"


def passport(draw) -> str:
    rng = draw.rng
    return f"{digits(rng, 2)}{random_string(rng, UPPER, 2)}{digits(rng, 5)}"


def driving_licence(draw) -> str:
    rng = draw.rng
    number = f"{rng.randint(0, 99):02d}{rng.randint(1, 12):02d}{rng.randint(1, 95):02d}{digits(rng, 6)}"
    return number if rng.random() < 0.8 else " ".join((number[:2], number[2:4], number[4:6], number[6:]))


def license_plate(draw) -> str:
    rng = draw.rng
    if rng.random() < 0.06:  # pre-2009 plates: number, letters, department
        return f"{rng.randint(1, 9999)} {random_string(rng, _PLATE_LETTERS, 2)} {rng.randint(1, 95):02d}"
    parts = (random_string(rng, _PLATE_LETTERS, 2), f"{rng.randint(1, 999):03d}", random_string(rng, _PLATE_LETTERS, 2))
    return weighted(rng, (("-", 72), (" ", 14), ("", 14))).join(parts)


def siren(draw) -> str:
    number = _siren(draw)
    return number if draw.rng.random() < 0.5 else f"{number[:3]} {number[3:6]} {number[6:]}"


def siret(draw) -> str:
    rng = draw.rng
    head = _siren(draw) + f"{rng.randint(1, 99):04d}"
    number = head + damaged(rng, luhn_digit(head))
    form = weighted(rng, (("spaced", 50), ("compact", 40), ("nic_apart", 10)))
    if form == "compact":
        return number
    if form == "nic_apart":
        return f"{number[:9]} {number[9:]}"
    return f"{number[:3]} {number[3:6]} {number[6:9]} {number[9:]}"


def _siren(draw) -> str:
    # A SIRET starts with the SIREN of the same record.
    def new_siren():
        body = str(draw.rng.randint(1, 9)) + digits(draw.rng, 7)
        return body + damaged(draw.rng, luhn_digit(body))
    return draw.record.field("siren", new_siren)


def _birthplace(rng) -> tuple:
    roll = rng.random()
    if roll < 0.06:
        return "99", f"{rng.randint(101, 499):03d}"  # born abroad: 99 and a country code
    if roll < 0.09:
        return "97", f"{rng.choice('12346')}{rng.randint(1, 34):02d}"  # overseas departments
    if roll < 0.11:
        return rng.choice(("2A", "2B")), f"{rng.randint(1, 366):03d}"  # Corsica
    department = rng.choice([d for d in range(1, 96) if d != 20])
    return f"{department:02d}", f"{rng.randint(1, 900):03d}"
