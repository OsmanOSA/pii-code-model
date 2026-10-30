"""Birth dates, ordinary dates and ages, written in the date style of the fill.

One style per fill keeps a file consistent (a CSV column, a JSON payload) and
writes birth dates and ordinary dates alike, so the model has to tell them apart
from context. Every fill has an anchor day, its "today": ordinary dates fall in
the months before it, date#1 the most recent and a higher number never later;
birth dates and ages count from it, within the ages the template's domain allows
(pupils, employees, adults).

Interface:
    draw_anchor(rng) -> date
    choose_date_style(rng, locale, syntax) -> str
    format_date(day, style) -> str
    draw_birth_date(rng, domain, anchor) -> date
    birth_date(draw), date(draw), age(draw)
"""

import datetime as dt

from .draw import domain_matches, weighted

_ANCHOR_RANGE = (dt.date(2017, 1, 1), dt.date(2026, 10, 28))
_GAP_DAYS = 120  # most days between two consecutive ordinary dates of a file
# (youngest, oldest) age on the anchor day, for domains whose words start with these keywords
_AGE_RANGES = ((("educ", "school", "scol", "pupil"), (3, 18)),
               (("hr", "payroll", "paie", "rh", "employ", "recruit", "staff"), (18, 66)))
_ADULT_AGES = (18, 92)
_MONTHS_FR = ("janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août",
              "septembre", "octobre", "novembre", "décembre")
_MONTHS_EN = ("January", "February", "March", "April", "May", "June", "July", "August",
              "September", "October", "November", "December")
_STYLES = {
    "fr_FR": (("iso", 30), ("dmy_slash", 45), ("dmy_dash", 5), ("dmy_dot", 4), ("fr_long", 16)),
    "en_US": (("iso", 30), ("mdy_slash", 45), ("us_long", 15), ("us_short", 10)),
    "en_GB": (("iso", 30), ("dmy_slash", 45), ("gb_long", 20), ("dmy_dash", 5)),
}
_CODE = frozenset({"python", "javascript", "java", "sql"})  # parsers in code expect ISO dates
_CONFIG = frozenset({"json", "yaml", "compose", "toml", "env", "ini"})
_TABLES = frozenset({"csv", "tsv"})
_FORMATS = {
    "iso": lambda d: d.isoformat(),
    "dmy_slash": lambda d: f"{d.day:02d}/{d.month:02d}/{d.year}",
    "dmy_dash": lambda d: f"{d.day:02d}-{d.month:02d}-{d.year}",
    "dmy_dot": lambda d: f"{d.day:02d}.{d.month:02d}.{d.year}",
    "mdy_slash": lambda d: f"{d.month:02d}/{d.day:02d}/{d.year}",
    "fr_long": lambda d: f"{'1er' if d.day == 1 else d.day} {_MONTHS_FR[d.month - 1]} {d.year}",
    "us_long": lambda d: f"{_MONTHS_EN[d.month - 1]} {d.day}, {d.year}",
    "us_short": lambda d: f"{_MONTHS_EN[d.month - 1][:3]} {d.day}, {d.year}",
    "gb_long": lambda d: f"{d.day} {_MONTHS_EN[d.month - 1]} {d.year}",
}


def draw_anchor(rng) -> dt.date:
    return _day_between(rng, *_ANCHOR_RANGE)


def choose_date_style(rng, locale: str, syntax: str) -> str:
    if syntax in _CODE:
        return "iso"
    table = _STYLES[locale]
    if syntax in _CONFIG:
        return "iso" if rng.random() < 0.9 else weighted(rng, table)
    if syntax in _TABLES:  # exports favour ISO, spreadsheets keep local formats
        table = tuple((style, weight * 3 if style == "iso" else weight) for style, weight in table)
    return weighted(rng, table)


def format_date(day: dt.date, style: str) -> str:
    return _FORMATS[style](day)


def draw_birth_date(rng, domain: str, anchor: dt.date) -> dt.date:
    youngest, oldest = _age_range(domain)
    return _day_between(rng, _years_before(anchor, oldest + 1) + dt.timedelta(days=1), _years_before(anchor, youngest))


def birth_date(draw) -> str:
    return format_date(draw.record.birth_date, draw.fill.date_style)


def date(draw) -> str:
    return format_date(_ordinary_day(draw.fill, draw.record.number), draw.fill.date_style)


def age(draw) -> str:
    born, today = draw.record.birth_date, draw.fill.anchor
    return str(today.year - born.year - ((today.month, today.day) < (born.month, born.day)))


def _ordinary_day(fill, number: int) -> dt.date:
    days = fill.cache.setdefault("ordinary_days", [])
    while len(days) < number:
        previous = days[-1] if days else fill.anchor
        days.append(previous - dt.timedelta(days=fill.rng.randint(0, _GAP_DAYS)))
    return days[number - 1]


def _age_range(domain: str) -> tuple:
    return next((ages for keywords, ages in _AGE_RANGES if domain_matches(domain, keywords)), _ADULT_AGES)


def _years_before(day: dt.date, years: int) -> dt.date:
    try:
        return day.replace(year=day.year - years)
    except ValueError:  # 29 February
        return day.replace(year=day.year - years, day=28)


def _day_between(rng, first: dt.date, last: dt.date) -> dt.date:
    return first + dt.timedelta(days=rng.randrange((last - first).days + 1))
