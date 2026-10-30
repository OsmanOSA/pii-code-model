"""US and UK identity and administrative numbers.

The UK driving licence number is built from the record's family name, birth
date, sex and initials, as the DVLA builds it.

Interface (each takes a Draw): us_ssn, us_itin, us_passport, us_driver_license,
us_license_plate, uk_national_insurance_number, uk_passport, uk_driving_licence,
uk_license_plate
"""

import re

from .draw import UPPER, ascii_fold, digits, fill_pattern, random_string, weighted

# A few states' formats: l letter, d digit, a letter or digit, other characters literal.
_US_LICENCES = (("lddddddd", 25), ("ddddddddd", 20), ("dddddddd", 15), ("lddd-ddd-dd-ddd-d", 12),
                ("lddd-dddd-dddd", 10), ("l dddddddddddd", 8), ("WDLaaaaaaaaa", 10))
_US_PLATES = (("dlllddd", 35), ("lll-dddd", 30), ("lll ddd", 15), ("ddd lll", 10), ("ll ddddd", 10))
_NINO_FIRST = "ABCEGHJKLMNOPRSTWXYZ"  # never D, F, I, Q, U or V
_NINO_SECOND = "ABCEGHJKLMNPRSTWXYZ"  # nor O
_NINO_UNALLOCATED = frozenset({"BG", "GB", "KN", "NK", "NT", "TN", "ZZ"})
_UK_PLATE_LETTERS = "ABCDEFGHJKLMNOPRSTUVWXY"


def us_ssn(draw) -> str:
    rng = draw.rng
    area = rng.choice([a for a in range(1, 900) if a != 666])
    return _grouped(rng, f"{area:03d}{rng.randint(1, 99):02d}{rng.randint(1, 9999):04d}")


def us_itin(draw) -> str:
    rng = draw.rng
    group = rng.choice([*range(50, 66), *range(70, 89), *range(90, 93), *range(94, 100)])
    return _grouped(rng, f"9{digits(rng, 2)}{group:02d}{digits(rng, 4)}")


def us_passport(draw) -> str:
    rng = draw.rng
    if rng.random() < 0.6:  # Next Generation passports start with a letter
        return rng.choice(UPPER) + digits(rng, 8)
    return str(rng.randint(1, 9)) + digits(rng, 8)


def us_driver_license(draw) -> str:
    return fill_pattern(draw.rng, weighted(draw.rng, _US_LICENCES))


def us_license_plate(draw) -> str:
    return fill_pattern(draw.rng, weighted(draw.rng, _US_PLATES))


def uk_national_insurance_number(draw) -> str:
    rng = draw.rng
    prefix = "GB"  # unallocated, so the loop draws at least once
    while prefix in _NINO_UNALLOCATED:
        prefix = rng.choice(_NINO_FIRST) + rng.choice(_NINO_SECOND)
    number, suffix = digits(rng, 6), rng.choice("ABCD")
    if rng.random() < 0.5:
        return f"{prefix} {number[:2]} {number[2:4]} {number[4:]} {suffix}"
    return f"{prefix}{number}{suffix}"


def uk_passport(draw) -> str:
    return digits(draw.rng, 9)


def uk_driving_licence(draw) -> str:
    rng, person, born = draw.rng, draw.record.person, draw.record.birth_date
    surname = re.sub("[^A-Z]", "", ascii_fold(person.family).upper())[:5].ljust(5, "9")
    month = born.month + (50 if person.sex == "F" else 0)
    second = person.middle if rng.random() < 0.5 else "9"
    initials = ascii_fold(person.given).upper()[:1] + second
    year = f"{born.year % 100:02d}"
    number = f"{surname}{year[0]}{month:02d}{born.day:02d}{year[1]}{initials}9{random_string(rng, UPPER, 2)}"
    return number if rng.random() < 0.7 else f"{number[:5]} {number[5:11]} {number[11:]}"


def uk_license_plate(draw) -> str:
    rng = draw.rng
    age = rng.choice([*range(2, 26), *range(51, 76)])
    letters = random_string(rng, _UK_PLATE_LETTERS, 2), random_string(rng, _UK_PLATE_LETTERS, 3)
    separator = " " if rng.random() < 0.8 else ""
    return f"{letters[0]}{age:02d}{separator}{letters[1]}"


def _grouped(rng, number: str) -> str:
    separator = weighted(rng, (("-", 70), (" ", 10), ("", 20)))
    return separator.join((number[:3], number[3:5], number[5:]))
