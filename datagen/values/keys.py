"""Prefixed API keys and tokens, one generator per provider format.

Prefix, length and alphabet follow each provider's published format; the rest is
random, so no value is a working key.

Interface (each takes a Draw): stripe_mode, stripe_secret_key, anthropic_api_key, openai_api_key,
aws_access_key_id, aws_secret_access_key, github_token, gitlab_token, slack_token,
google_api_key, huggingface_token, npm_token, sendgrid_api_key
"""

from .draw import ALNUM, BASE64, BASE64URL, DIGITS, HEX, LOWER, UPPER, digits, random_string, weighted

_BASE32 = UPPER + "234567"
_OPENAI_MARK = "T3BlbkFJ"  # base64 of "OpenAI", found in the middle of real keys


def stripe_mode(draw) -> str:
    """live or test, shared by the secret and publishable keys of one record."""
    return draw.record.field("stripe_mode", lambda: "live" if draw.rng.random() < 0.6 else "test")


def stripe_secret_key(draw) -> str:
    rng, mode = draw.rng, stripe_mode(draw)
    prefix = "rk_live_" if mode == "live" and rng.random() < 0.2 else f"sk_{mode}_"  # rk_: restricted key
    if rng.random() < 0.5:
        return prefix + random_string(rng, ALNUM, 24)
    return prefix + "51" + random_string(rng, ALNUM, 97)


def anthropic_api_key(draw) -> str:
    rng = draw.rng
    prefix = "sk-ant-api03-" if rng.random() < 0.9 else "sk-ant-admin01-"
    return prefix + random_string(rng, BASE64URL, 93) + "AA"


def openai_api_key(draw) -> str:
    rng = draw.rng
    style = weighted(rng, (("project", 60), ("legacy", 25), ("service", 15)))
    if style == "legacy":
        return "sk-" + random_string(rng, ALNUM, 20) + _OPENAI_MARK + random_string(rng, ALNUM, 20)
    prefix = "sk-proj-" if style == "project" else "sk-svcacct-"
    return prefix + random_string(rng, BASE64URL, 74) + _OPENAI_MARK + random_string(rng, BASE64URL, 74)


def aws_access_key_id(draw) -> str:
    rng = draw.rng
    return ("AKIA" if rng.random() < 0.85 else "ASIA") + random_string(rng, _BASE32, 16)


def aws_secret_access_key(draw) -> str:
    return random_string(draw.rng, BASE64, 40)


def github_token(draw) -> str:
    rng = draw.rng
    style = weighted(rng, (("classic", 50), ("fine_grained", 25), ("other", 25)))
    if style == "fine_grained":
        return "github_pat_" + random_string(rng, ALNUM, 22) + "_" + random_string(rng, ALNUM, 59)
    prefix = "ghp_" if style == "classic" else rng.choice(("gho_", "ghs_", "ghu_", "ghr_"))
    return prefix + random_string(rng, ALNUM, 36)


def gitlab_token(draw) -> str:
    return "glpat-" + random_string(draw.rng, BASE64URL, 20)


def slack_token(draw) -> str:
    rng = draw.rng
    kind = weighted(rng, (("xoxb", 55), ("xoxp", 30), ("xapp", 15)))
    if kind == "xoxb":
        return f"xoxb-{digits(rng, 12)}-{digits(rng, 13)}-{random_string(rng, ALNUM, 24)}"
    if kind == "xoxp":
        return f"xoxp-{digits(rng, 12)}-{digits(rng, 12)}-{digits(rng, 13)}-{random_string(rng, HEX, 32)}"
    return f"xapp-1-A{random_string(rng, UPPER + DIGITS, 10)}-{digits(rng, 13)}-{random_string(rng, HEX, 64)}"


def google_api_key(draw) -> str:
    return "AIza" + random_string(draw.rng, BASE64URL, 35)


def huggingface_token(draw) -> str:
    return "hf_" + random_string(draw.rng, UPPER + LOWER, 34)


def npm_token(draw) -> str:
    return "npm_" + random_string(draw.rng, ALNUM, 36)


def sendgrid_api_key(draw) -> str:
    rng = draw.rng
    return "SG." + random_string(rng, BASE64URL, 22) + "." + random_string(rng, BASE64URL, 43)
