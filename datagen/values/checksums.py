"""Check digit algorithms of identifiers and banking values.

Interface:
    luhn_digit(payload) -> str            digit that makes payload + digit pass the Luhn check
    luhn_valid(number) -> bool
    iban_check_digits(country, bban) -> str
    iban_valid(iban) -> bool
    nir_key(first13) -> str               key of a French social security number
    fr_rib_key(bank, branch, account) -> str
    fr_tax_key(first10) -> str            key of a French tax number
    damaged(rng, check, share=0.05) -> str
"""

WRONG_CHECK_SHARE = 0.05
# Letters of a French account number count as these digits in the RIB key.
_RIB_LETTERS = str.maketrans("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "12345678912345678923456789")


def luhn_digit(payload: str) -> str:
    total = 0
    for position, char in enumerate(reversed(payload)):
        value = int(char)
        if position % 2 == 0:  # doubled once the check digit is appended on the right
            value = value * 2 - 9 if value > 4 else value * 2
        total += value
    return str(-total % 10)


def luhn_valid(number: str) -> bool:
    return luhn_digit(number[:-1]) == number[-1]


def _iban_number(text: str) -> int:
    return int("".join(str(int(char, 36)) for char in text))


def iban_check_digits(country: str, bban: str) -> str:
    return f"{98 - _iban_number(bban + country + '00') % 97:02d}"


def iban_valid(iban: str) -> bool:
    compact = iban.replace(" ", "").upper()
    return _iban_number(compact[4:] + compact[:4]) % 97 == 1


def nir_key(first13: str) -> str:
    # Corsican departments 2A and 2B count as 19 and 18.
    return f"{97 - int(first13.replace('2A', '19').replace('2B', '18')) % 97:02d}"


def fr_rib_key(bank: str, branch: str, account: str) -> str:
    numeric = int(account.upper().translate(_RIB_LETTERS))
    return f"{97 - (89 * int(bank) + 15 * int(branch) + 3 * numeric) % 97:02d}"


def fr_tax_key(first10: str) -> str:
    return f"{int(first10) % 511:03d}"


def damaged(rng, check: str, share: float = WRONG_CHECK_SHARE) -> str:
    """The check digits, replaced by wrong ones in a share of cases.

    A typo is still personal data: the model must not learn that only numbers
    with valid check digits matter.
    """
    if rng.random() >= share:
        return check
    wrong = check
    while wrong == check:
        wrong = "".join(rng.choice("0123456789") for _ in check)
    return wrong
