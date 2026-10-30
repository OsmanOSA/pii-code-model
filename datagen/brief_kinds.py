"""Entity kinds of a brief: what a format and a situation allow, then the schema's kinds for a locale.

Tables use generic kinds (`address`, `national_id`); `kinds` and `locale_kinds` in
templates/sampling.yaml turn them into schema kinds, so one table serves every locale.

Interface:
    table_key(format_name, keys) -> str | None
    kind_pool(family, tables, format_name, locale, tags) -> dict generic kind -> weight
    full_record_kinds(pool, tables, rng) -> list
    weighted_sample(weights, count, rng) -> list
    concrete_kinds(generic, locale, tables, rng) -> list
"""

_RECORD_EXTRA_KINDS = (3, 3, 4)  # beside the name: a full record holds four or five kinds


def table_key(format_name: str, keys):
    """The table entry of a plan format: `chat message (Slack, Teams)` reads the `chat message` row."""
    return next((key for key in keys if format_name.startswith(key)), None)


def kind_pool(family: dict, tables: dict, format_name: str, locale: str, tags: set) -> dict:
    """What both the format and the situation allow; a family without base_kinds reads the format alone."""
    weights = family["formats"][table_key(format_name, family["formats"])]
    known = _known_kinds(tables, locale)
    pool = {kind: weight for kind, weight in weights.items() if kind in known}
    if "base_kinds" not in family:
        return pool
    brought = set().union(*(family["tag_kinds"].get(tag, ()) for tag in tags))
    return {kind: weight * (family["tag_boost"] if kind in brought else 1) for kind, weight in pool.items()
            if kind in brought or kind in family["base_kinds"]}


def full_record_kinds(pool: dict, tables: dict, rng) -> list:
    others = {kind: weight for kind, weight in pool.items() if kind in tables["person_kinds"] and kind != "name"}
    return ["name"] + weighted_sample(others, rng.choice(_RECORD_EXTRA_KINDS), rng)


def weighted_sample(weights: dict, count: int, rng) -> list:
    pool, chosen = dict(weights), []
    while pool and len(chosen) < count:
        kind = rng.choices(list(pool), list(pool.values()))[0]
        chosen.append(kind)
        del pool[kind]
    return chosen


def concrete_kinds(generic: list, locale: str, tables: dict, rng) -> list:
    known = _known_kinds(tables, locale)
    picks = [known[kind] if isinstance(known[kind], str) else rng.choice(known[kind]) for kind in generic]
    return list(dict.fromkeys(picks))


def _known_kinds(tables: dict, locale: str) -> dict:
    return {**tables["kinds"], **tables["locale_kinds"][locale]}
