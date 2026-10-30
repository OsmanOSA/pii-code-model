"""Draw of the briefs from the tables of templates/sampling.yaml.

The situation comes first: it says what a text could plausibly hold, through the tags
written after it (`a friend sells a sofa | money, logistics`). The kinds are drawn from
what the situation and the format both allow, then the reason must fit the kinds, the
tags and the format, and may fix the position, so the fields of a brief agree.

Interface:
    draw_briefs(cells, tables, seed=0) -> dict cell_id -> list[brief]
"""

import random
from dataclasses import dataclass

from .brief_kinds import concrete_kinds, full_record_kinds, kind_pool, table_key, weighted_sample

_EMPTY, _RECORD = 0, "record"
_DEFAULT_WEIGHT = 3
_PAIR_ATTEMPTS = 60


class _Deck:
    """Cards drawn without replacement; the deck refills only once no card is accepted."""

    def __init__(self, cards, rng):
        self._source, self._rng, self._cards = list(cards), rng, []

    def draw(self, accept):
        for _ in range(2):
            for index in range(len(self._cards) - 1, -1, -1):
                if accept(self._cards[index]):
                    return self._cards.pop(index)
            self._cards = self._rng.sample(self._source, len(self._source)) + self._cards
        raise ValueError("no situation fits this draw: tag more situations in templates/sampling.yaml")


@dataclass
class _Draw:
    cell: dict
    tables: dict
    family: dict
    rng: random.Random
    decks: dict


def draw_briefs(cells, tables: dict, seed: int = 0) -> dict:
    rng, decks = random.Random(f"briefs:{seed}"), {}
    draws = [_Draw(cell, tables, tables["families"][cell["family"]], rng, decks) for cell in cells if cell.get("briefs")]
    plans = [_cell_plan(draw) for draw in draws]
    drawn = [{} for _ in draws]
    for records in (True, False):  # a full record needs a situation tagged admin: serve them before the others
        for draw, (shapes, domains), briefs in zip(draws, plans, drawn):
            for index in (index for index, shape in enumerate(shapes) if (shape == _RECORD) == records):
                briefs[index] = _brief(index + 1, shapes[index], domains[index], draw)
    return {draw.cell["cell_id"]: [briefs[index] for index in sorted(briefs)] for draw, briefs in zip(draws, drawn)}


def _cell_plan(draw: _Draw) -> tuple:
    shapes = _spread(_shape_counts(draw.cell, draw.tables), draw.rng)
    return shapes, _domains(shapes, draw.cell["domains"], draw.rng)


def _shape_counts(cell: dict, tables: dict) -> list:
    total, empty = cell["templates"], cell["pii_free_templates"]
    records = round(total * tables["record_share"])
    return [(_EMPTY, empty), (_RECORD, records), *_quotas(total - empty - records, tables["kind_count_weights"]).items()]


def _domains(shapes: list, names: list, rng) -> list:
    """Domains spread evenly over the cell and over its full records."""
    even, records = {name: 1 for name in names}, sum(shape == _RECORD for shape in shapes)
    for_records = iter(_spread(_quotas(records, even).items(), rng))
    for_others = iter(_spread(_quotas(len(shapes) - records, even).items(), rng))
    return [next(for_records if shape == _RECORD else for_others) for shape in shapes]


def _quotas(total: int, weights: dict) -> dict:
    """Largest remainder: the counts add up to total and follow the weights."""
    share = total / sum(weights.values())
    counts = {key: int(weight * share) for key, weight in weights.items()}
    order = sorted(weights, key=lambda key: counts[key] - weights[key] * share)
    for key in order[:total - sum(counts.values())]:
        counts[key] += 1
    return counts


def _spread(counts, rng) -> list:
    """All values in an order where each stays evenly spaced, so every batch gets its share."""
    keyed = [((index + rng.random()) / count, value) for value, count in counts for index in range(count)]
    return [value for _, value in sorted(keyed, key=lambda item: item[0])]


def _brief(slot: int, shape, domain: str, draw: _Draw) -> dict:
    rng, family, record = draw.rng, draw.family, shape == _RECORD
    text, tags = _situation(domain, record, draw)
    format_name, locale = _format(domain, record, draw), _locale(draw)
    generic = _generic_kinds(shape, format_name, locale, tags, draw)
    role, reason = _reason(generic, shape, format_name, tags, draw)
    bands = [band for band in family["lengths"] if not record or band["lines"][1] >= 3]
    length = rng.choices(bands, [band["weight"] for band in bands])[0]
    indicator = reason.get("indicator") or ("absent" if rng.random() < family["no_indicator_share"] else "present")
    return {"slot": slot, "format": format_name, "domain": domain, "situation": text,
            "kinds": concrete_kinds(generic, locale, draw.tables, rng), "full_record": record, "data_role": role,
            "reason": reason["text"], "position": reason.get("position") or _position(format_name, shape, draw),
            "indicator": indicator, "length": length["name"], "lines": length["lines"]}


def _situation(domain: str, record: bool, draw: _Draw) -> tuple:
    family, name = draw.family, draw.cell["family"]
    table = family["situations"]
    key = domain if domain in table else "any"
    tag = family["record_tag"] if record else None
    card = _deck(draw, (name, key), table[key]).draw(lambda card: tag is None or tag in _tags(card))
    text = card.partition(" | ")[0]
    return (_with_purpose(text, _tags(card), draw) if "purposes" in family else text), _tags(card)


def _with_purpose(subject: str, tags: set, draw: _Draw) -> str:
    """Subject and purpose come from separate decks and must share a tag when both have some; a family never repeats the pair."""
    name = draw.cell["family"]
    deck, used = _deck(draw, (name, "purposes"), draw.family["purposes"]), draw.decks.setdefault((name, "pairs"), set())
    for _ in range(_PAIR_ATTEMPTS):
        text = f"{subject}, {deck.draw(lambda card: not _tags(card) or bool(_tags(card) & tags)).partition(' | ')[0]}"
        if text not in used:
            break
    used.add(text)
    return text


def _tags(card: str) -> set:
    return {tag.strip() for tag in card.partition(" | ")[2].split(",") if tag.strip()}


def _deck(draw: _Draw, key: tuple, cards: list) -> _Deck:
    if key not in draw.decks:
        draw.decks[key] = _Deck(cards, draw.rng)
    return draw.decks[key]


def _format(domain: str, record: bool, draw: _Draw) -> str:
    family, allowed = draw.family, draw.family.get("domain_formats", {}).get(domain)
    names = [name for name in draw.cell["formats"]
             if (not allowed or table_key(name, allowed) is not None)
             and (not record or table_key(name, family["record_formats"]) is not None)]
    return draw.rng.choice(names)


def _locale(draw: _Draw) -> str:
    locale, weights = draw.cell["fill_locale"], draw.tables["mixed_locales"]
    return draw.rng.choices(list(weights), list(weights.values()))[0] if locale == "mixed" else locale


def _generic_kinds(shape, format_name: str, locale: str, tags: set, draw: _Draw) -> list:
    if shape == _EMPTY:
        return []
    pool = kind_pool(draw.family, draw.tables, format_name, locale, tags)
    return full_record_kinds(pool, draw.tables, draw.rng) if shape == _RECORD else weighted_sample(pool, shape, draw.rng)


def _reason(generic: list, shape, format_name: str, tags: set, draw: _Draw) -> tuple:
    """The data's role and the reason for it."""
    family, rng = draw.family, draw.rng
    if shape == _EMPTY:
        return "none", _as_item(rng.choice(family["empty_reasons"]))
    if shape == _RECORD:
        return "central", _as_item(rng.choice(family["record_reasons"]))
    wanted = "accessory" if rng.random() < family["accessory_share"] else "central"
    fitting = [item for item in family["reasons"] if _fits(item, set(generic), format_name, tags)]
    matching = [item for item in fitting if item.get("role", wanted) == wanted] or fitting
    item = rng.choices(matching, [item.get("weight", _DEFAULT_WEIGHT) for item in matching])[0]
    return item.get("role", wanted), item


def _fits(item: dict, kinds: set, format_name: str, tags: set) -> bool:
    """fits: every kind is covered; key: one kind is the reason's point; needs: the situation allows it."""
    return (("fits" not in item or kinds <= set(item["fits"]))
            and ("key" not in item or bool(kinds & set(item["key"])))
            and ("needs" not in item or item["needs"] in tags)
            and table_key(format_name, item.get("not", ())) is None)


def _as_item(entry) -> dict:
    return entry if isinstance(entry, dict) else {"text": entry}


def _position(format_name: str, shape, draw: _Draw) -> str:
    if shape == _EMPTY:
        return "none"
    items = [_as_item(entry) for entry in draw.family["positions"]]
    return draw.rng.choice([item["text"] for item in items if table_key(format_name, item.get("not", ())) is None])
