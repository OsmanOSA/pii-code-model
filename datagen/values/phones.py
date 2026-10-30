"""Phone numbers in the national and international formats of each locale.

Interface:
    phone(draw) -> str
"""

from .draw import digits, weighted


def phone(draw) -> str:
    return {"fr_FR": _french, "en_US": _american, "en_GB": _british}[draw.locale](draw.rng)


def _french(rng) -> str:
    lead = weighted(rng, (("6", 45), ("7", 15), ("1", 12), ("2", 6), ("3", 6), ("4", 6), ("5", 5), ("9", 5)))
    rest = digits(rng, 8)
    pairs = " ".join(rest[i:i + 2] for i in range(0, 8, 2))
    form = weighted(rng, (("national", 40), ("dots", 10), ("compact", 15), ("dashes", 5),
                          ("intl", 18), ("intl_compact", 7), ("intl_zero", 5)))
    national = f"0{lead} {pairs}"
    return {
        "national": national,
        "dots": national.replace(" ", "."),
        "compact": national.replace(" ", ""),
        "dashes": national.replace(" ", "-"),
        "intl": f"+33 {lead} {pairs}",
        "intl_compact": f"+33{lead}{rest}",
        "intl_zero": f"+33 (0){lead} {pairs}",
    }[form]


def _american(rng) -> str:
    area = f"{rng.randint(2, 9)}{rng.randint(0, 8)}{rng.randint(0, 9)}"
    exchange = f"{rng.randint(2, 9)}{rng.randint(0, 9)}{rng.randint(2, 9)}"  # never N11
    form = weighted(rng, (("({a}) {e}-{n}", 35), ("{a}-{e}-{n}", 25), ("{a}.{e}.{n}", 8),
                          ("+1 {a}-{e}-{n}", 10), ("+1 ({a}) {e}-{n}", 7), ("{a}{e}{n}", 8),
                          ("+1{a}{e}{n}", 4), ("1-{a}-{e}-{n}", 3)))
    return form.format(a=area, e=exchange, n=digits(rng, 4))


def _british(rng) -> str:
    kind = weighted(rng, (("mobile", 60), ("london", 20), ("geographic", 20)))
    if kind == "mobile":
        number = "7" + digits(rng, 9)
        groups = (number[:4], number[4:])
    elif kind == "london":
        number = "20" + digits(rng, 8)
        groups = (number[:2], number[2:6], number[6:])
    else:
        number = "1" + digits(rng, 9)
        groups = (number[:4], number[4:])
    form = weighted(rng, (("national", 55), ("intl", 25), ("compact", 12), ("intl_compact", 8)))
    return {
        "national": "0" + " ".join(groups),
        "intl": "+44 " + " ".join(groups),
        "compact": "0" + number,
        "intl_compact": "+44" + number,
    }[form]
