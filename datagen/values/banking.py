"""IBANs, payment cards, card security codes, bank account numbers and BICs.

IBANs follow each country's BBAN layout with ISO 7064 check digits, and French
ones carry a RIB key; cards carry their brand prefix and a Luhn digit. A wrong
check digit appears in 5% of cases.

Interface (each takes a Draw): iban, payment_card, card_security_code,
bank_account_number, bic
"""

import re

from .checksums import damaged, fr_rib_key, iban_check_digits, luhn_digit
from .draw import DIGITS, UPPER, digits, random_string, weighted

# BBAN layouts: n digits, a upper-case letters, c letters or digits.
_BBAN = {
    "FR": "5n5n11c2n", "MC": "5n5n11c2n", "DE": "8n10n", "ES": "4n4n2n10n", "IT": "1a5n5n12c",
    "BE": "3n7n2n", "NL": "4a10n", "LU": "3n13c", "CH": "5n12c", "AT": "5n11n", "PT": "21n",
    "IE": "4a6n8n", "GB": "4a6n8n", "PL": "24n",
}
_COUNTRIES = {
    "fr_FR": (("FR", 80), ("BE", 4), ("DE", 4), ("ES", 3), ("IT", 3), ("LU", 2), ("CH", 2), ("MC", 1), ("PT", 1)),
    "en_GB": (("GB", 75), ("IE", 8), ("FR", 4), ("DE", 4), ("NL", 3), ("ES", 3), ("PL", 3)),
    "en_US": (("GB", 20), ("DE", 20), ("FR", 20), ("NL", 10), ("ES", 10), ("IE", 10), ("CH", 10)),
}
_BRANDS = (("visa", 45), ("mastercard", 35), ("amex", 10), ("discover", 4), ("jcb", 3), ("diners", 3))


def iban(draw) -> str:
    rng = draw.rng
    country = weighted(rng, _COUNTRIES[draw.locale])
    bban = _bban(rng, country)
    compact = country + damaged(rng, iban_check_digits(country, bban)) + bban
    if rng.random() < 0.6:
        return " ".join(compact[i:i + 4] for i in range(0, len(compact), 4))
    return compact


def payment_card(draw) -> str:
    rng, brand = draw.rng, _brand(draw)
    prefix, length = _prefix(rng, brand)
    payload = prefix + digits(rng, length - len(prefix) - 1)
    number = payload + damaged(rng, luhn_digit(payload))
    if brand == "amex":
        groups = (number[:4], number[4:10], number[10:])
    else:
        groups = tuple(number[i:i + 4] for i in range(0, len(number), 4))
    return weighted(rng, ((" ", 45), ("", 40), ("-", 15))).join(groups)


def card_security_code(draw) -> str:
    return digits(draw.rng, 4 if _brand(draw) == "amex" else 3)


def bank_account_number(draw) -> str:
    rng = draw.rng
    if draw.locale == "fr_FR":
        return digits(rng, 11)
    if draw.locale == "en_GB":
        return digits(rng, 8)
    return digits(rng, rng.randint(8, 12))


def bic(draw) -> str:
    rng = draw.rng
    country = {"fr_FR": "FR", "en_GB": "GB", "en_US": "US"}[draw.locale]
    code = random_string(rng, UPPER, 4) + country + random_string(rng, UPPER + DIGITS, 2)
    return code + weighted(rng, (("", 45), ("XXX", 35), (random_string(rng, UPPER + DIGITS, 3), 20)))


def _brand(draw) -> str:
    # The card and its security code share a brand within a record (four digits for Amex).
    return draw.record.field("card_brand", lambda: weighted(draw.rng, _BRANDS))


def _prefix(rng, brand: str) -> tuple:
    if brand == "visa":
        return "4", 16
    if brand == "mastercard":
        return (str(rng.randint(51, 55)) if rng.random() < 0.8 else str(rng.randint(2221, 2720))), 16
    if brand == "amex":
        return rng.choice(("34", "37")), 15
    if brand == "discover":
        return rng.choice(("6011", "65")), 16
    if brand == "jcb":
        return str(rng.randint(3528, 3589)), 16
    return rng.choice(("36", "38")), 14


def _bban(rng, country: str) -> str:
    parts = [_characters(rng, kind, int(count)) for count, kind in re.findall(r"(\d+)([nac])", _BBAN[country])]
    if country in ("FR", "MC"):
        parts[-1] = fr_rib_key(*parts[:3])
    return "".join(parts)


def _characters(rng, kind: str, count: int) -> str:
    if kind == "n":
        return digits(rng, count)
    if kind == "a":
        return random_string(rng, UPPER, count)
    # Account numbers are digits in most cases even where letters are allowed.
    return "".join(rng.choice(UPPER) if rng.random() < 0.04 else rng.choice(DIGITS) for _ in range(count))
