"""Check digits, verified against the validity rule of each number rather than the formula."""

import random

from datagen.values.checksums import (damaged, fr_rib_key, iban_check_digits, iban_valid, luhn_digit,
                                      luhn_valid, nir_key)


def _digits(rng, count):
    return "".join(rng.choice("0123456789") for _ in range(count))


def test_luhn_digit_completes_a_valid_number_and_another_digit_breaks_it():
    rng = random.Random(1)
    for _ in range(300):
        payload = _digits(rng, rng.randint(5, 18))
        check = luhn_digit(payload)
        assert luhn_valid(payload + check)
        assert not luhn_valid(payload + str((int(check) + 1) % 10))


def test_iban_check_digits_pass_the_mod_97_rule():
    rng = random.Random(2)
    for _ in range(300):
        country = rng.choice(("FR", "DE", "GB", "NL", "ES"))
        bban = rng.choice(("", "ABCD")) + _digits(rng, rng.randint(10, 24))
        assert iban_valid(country + iban_check_digits(country, bban) + bban)


def test_rib_key_makes_the_whole_rib_divisible_by_97():
    rng = random.Random(3)
    for _ in range(300):
        bank, branch, account = _digits(rng, 5), _digits(rng, 5), _digits(rng, 11)
        assert int(bank + branch + account + fr_rib_key(bank, branch, account)) % 97 == 0


def test_corsican_departments_count_as_19_and_18_in_the_nir_key():
    assert nir_key("1850" + "52A" + "001002") == nir_key("1850" + "519" + "001002")
    assert nir_key("2930" + "12B" + "123045") == nir_key("2930" + "118" + "123045")


def test_damaged_check_digits_are_wrong_only_when_drawn():
    rng = random.Random(4)
    assert all(damaged(rng, "42", share=0.0) == "42" for _ in range(50))
    assert all(damaged(rng, "42", share=1.0) != "42" for _ in range(50))
