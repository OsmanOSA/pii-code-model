"""Passwords, opaque tokens, JWTs, private keys and passwords inside URLs.

Passwords mix human ones (word, year, symbol), generated ones and passphrases.
Private keys are PEM or OpenSSH blocks whose body starts with the real structure
prefix of its key type, followed by random base64 of realistic length.

Interface (each takes a Draw): password, url_password, opaque_token, jwt, private_key
"""

import base64
import json
from urllib.parse import quote

from .draw import ALNUM, BASE64, BASE64URL, DIGITS, HEX, LOWER, UPPER, ascii_fold, digits, random_string, weighted

_SYMBOLS = "!@#$%&*?-_.+="
_LEET = str.maketrans("aeios", "@310$")
# (label, base64 prefix of the key structure, body length, line width), weight
_KEYS = (
    (("EC PRIVATE KEY", "MHcCAQEEI", 164, 64), 25),
    (("PRIVATE KEY", "MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg", 184, 64), 15),
    (("OPENSSH PRIVATE KEY", "b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW", 400, 70), 25),
    (("RSA PRIVATE KEY", "MIIEowIBAAKCAQEA", 1588, 64), 20),
    (("PRIVATE KEY", "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQ", 1624, 64), 15),
)


def password(draw) -> str:
    style = weighted(draw.rng, (("human", 45), ("generated", 35), ("passphrase", 15), ("digits", 5)))
    if style == "human":
        return _human(draw)
    if style == "passphrase":
        return _passphrase(draw)
    if style == "digits":
        return digits(draw.rng, draw.rng.randint(6, 8))
    return _generated(draw.rng)


def url_password(draw) -> str:
    rng = draw.rng
    if rng.random() < 0.6:
        return random_string(rng, ALNUM + "-._~", rng.randint(12, 32))
    return quote(_generated(rng), safe="")  # special characters percent-encoded, as URLs require


def opaque_token(draw) -> str:
    rng = draw.rng
    style = weighted(rng, (("base62", 40), ("base64url", 25), ("hex", 20), ("base64", 15)))
    if style == "base62":
        return random_string(rng, ALNUM, rng.randint(24, 64))
    if style == "base64url":
        return random_string(rng, BASE64URL, rng.choice((22, 32, 43, 64, 86)))
    if style == "hex":
        return random_string(rng, HEX, rng.choice((32, 40, 48, 64)))
    return base64.b64encode(_random_bytes(rng, rng.choice((24, 32, 48)))).decode()


def jwt(draw) -> str:
    rng = draw.rng
    algorithm = weighted(rng, (("HS256", 55), ("RS256", 35), ("HS512", 10)))
    header = {"alg": algorithm, "typ": "JWT"}
    if algorithm == "RS256":
        header["kid"] = random_string(rng, HEX, 16)
    issued = rng.randint(1_700_000_000, 1_790_000_000)
    payload = {"sub": str(rng.randint(1000, 9_999_999)), "iat": issued, "exp": issued + rng.choice((900, 3600, 86400))}
    if rng.random() < 0.5:
        payload["scope"] = rng.choice(("read", "read write", "admin", "api"))
    signature = _random_bytes(rng, {"HS256": 32, "HS512": 64, "RS256": 256}[algorithm])
    parts = (json.dumps(header, separators=(",", ":")).encode(), json.dumps(payload, separators=(",", ":")).encode(), signature)
    return ".".join(base64.urlsafe_b64encode(part).rstrip(b"=").decode() for part in parts)


def private_key(draw) -> str:
    rng = draw.rng
    label, prefix, length, width = weighted(rng, _KEYS)
    body = prefix + random_string(rng, BASE64, length - len(prefix))
    lines = [body[i:i + width] for i in range(0, len(body), width)]
    return "\n".join([f"-----BEGIN {label}-----", *lines, f"-----END {label}-----"])


def _human(draw) -> str:
    rng = draw.rng
    word = _word(draw).capitalize()
    if rng.random() < 0.2:
        word = word.translate(_LEET)
    tail = weighted(rng, ((str(rng.randint(1970, 2026)), 40), (str(rng.randint(1, 99)), 30), ("", 30)))
    return word + tail + (rng.choice(_SYMBOLS) if rng.random() < 0.7 else "")


def _passphrase(draw) -> str:
    rng = draw.rng
    words = [_word(draw).lower() for _ in range(rng.randint(3, 4))]
    return rng.choice("-._").join(words) + (str(rng.randint(0, 99)) if rng.random() < 0.4 else "")


def _generated(rng) -> str:
    chars = [rng.choice(LOWER), rng.choice(UPPER), rng.choice(DIGITS), rng.choice(_SYMBOLS)]
    chars += [rng.choice(ALNUM + _SYMBOLS) for _ in range(rng.randint(8, 20))]
    rng.shuffle(chars)
    return "".join(chars)


def _word(draw) -> str:
    word = ascii_fold(draw.faker.word())
    return word if len(word) >= 4 else word + ascii_fold(draw.faker.word())


def _random_bytes(rng, count: int) -> bytes:
    return bytes(rng.getrandbits(8) for _ in range(count))
