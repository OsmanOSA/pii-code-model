"""HTML page to review filled examples outside the agent.

The Privacy Guard hook masks personal data in the agent's view, so filled
examples are reviewed in a browser. For each template: its scenario and tagged
text, then every fill with entities coloured by category, traps outlined with
dashes and visible values underlined. Hovering a span shows its kind.

Interface:
    review_page(templates, examples) -> str
"""

import html
import re
from collections import Counter, defaultdict

_COLOURS = {"name": "#d9480f", "email": "#1864ab", "phone": "#2b8a3e", "address": "#862e9c",
            "birth_date": "#c2255c", "identifier": "#e67700", "banking": "#0b7285", "secret": "#c92a2a"}
_TAG = re.compile("⟬[^⟬⟭]*⟭")
_STYLE = """
:root { --bg:#fbfaf7; --fg:#1d1d1b; --muted:#6b6a65; --panel:#fff; --line:#e4e1d9; }
@media (prefers-color-scheme: dark) { :root { --bg:#161614; --fg:#ecebe6; --muted:#a3a29b; --panel:#201f1c; --line:#34332e; } }
body { margin:0; background:var(--bg); color:var(--fg); font:15px/1.5 system-ui, sans-serif; }
main { max-width:1100px; margin:0 auto; padding:24px 16px 64px; }
h1 { font-size:22px; margin:0 0 4px; } h2 { font-size:17px; margin:0; } h3 { font-size:13px; color:var(--muted); margin:14px 0 4px; }
.muted { color:var(--muted); } ul { padding-left:20px; }
section { border-top:1px solid var(--line); margin-top:28px; padding-top:18px; }
pre { background:var(--panel); border:1px solid var(--line); border-radius:8px; padding:12px 14px; margin:0;
      white-space:pre-wrap; word-break:break-word; font:12.5px/1.6 ui-monospace, Consolas, monospace; }
mark.ent { background:color-mix(in srgb, var(--c) 22%, transparent); color:inherit; border-bottom:2px solid var(--c); border-radius:3px; }
.trap { outline:1.5px dashed #868e96; outline-offset:1px; border-radius:3px; }
.vis { text-decoration:underline dotted #868e96; text-underline-offset:3px; }
.tag { color:var(--muted); background:color-mix(in srgb, #868e96 15%, transparent); border-radius:3px; }
.chip { display:inline-block; padding:1px 9px; margin:2px 4px 2px 0; border-radius:99px; font-size:13px; }
details summary { cursor:pointer; color:var(--muted); margin:10px 0 6px; }
"""


def review_page(templates, examples) -> str:
    by_seed = defaultdict(list)
    for example in examples:
        by_seed[example["seed_id"]].append(example)
    sections = "\n".join(_section(template, by_seed[template.seed_id]) for template in templates)
    return (f"<!doctype html><html lang=\"en\"><head><meta charset=\"utf-8\">"
            f"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            f"<title>Filled examples review</title><style>{_STYLE}</style></head>"
            f"<body><main>{_header(templates, examples)}{sections}</main></body></html>")


def _header(templates, examples) -> str:
    counts = Counter(entity["category"] for example in examples for entity in example["entities"])
    chips = "".join(f'<span class="chip" style="background:color-mix(in srgb, {colour} 22%, transparent)">'
                    f'{name} {counts.get(name, 0)}</span>' for name, colour in _COLOURS.items())
    return (f"<h1>Filled examples review</h1>"
            f"<p class=\"muted\">{len(templates)} templates, {len(examples)} fills. Entities by category:</p><p>{chips}"
            f'<span class="chip trap">trap</span><span class="chip vis">visible</span></p>'
            "<p>Look for: a personal value or secret left without colour (a leak in the template), a span "
            "too short or too long, a trap or visible value that should be an entity, a value that looks "
            "fake, a file that would not parse. Report problems by template id: the fix goes in the template.</p>")


def _section(template, fills) -> str:
    header = template.header
    meta = " · ".join(html.escape(header.get(key, "")) for key in ("family", "format", "language", "fill_locale", "domain"))
    tagged = _TAG.sub(lambda match: f'<span class="tag">{match.group()}</span>', html.escape(template.text))
    fills_html = "".join(f"<h3>{html.escape(fill['id'])}</h3><pre>{_highlighted(fill)}</pre>" for fill in fills)
    return (f"<section id=\"{html.escape(template.seed_id)}\"><h2>{html.escape(template.seed_id)}</h2>"
            f"<p class=\"muted\">{meta}<br>{html.escape(header.get('scenario', ''))}</p>"
            f"<details><summary>Template</summary><pre>{tagged}</pre></details>{fills_html}</section>")


def _highlighted(example: dict) -> str:
    spans = [("entity", span) for span in example["entities"]] + [("trap", span) for span in example["traps"]] \
        + [("visible", span) for span in example["visible"]]
    text, parts, cursor = example["text"], [], 0
    for group, span in sorted(spans, key=lambda pair: pair[1]["start"]):
        parts.append(html.escape(text[cursor:span["start"]]))
        parts.append(_wrapped(group, span, html.escape(text[span["start"]:span["end"]])))
        cursor = span["end"]
    parts.append(html.escape(text[cursor:]))
    return "".join(parts)


def _wrapped(group: str, span: dict, inner: str) -> str:
    if group == "entity":
        kind = span["kind"] + (":" + span["variant"] if "variant" in span else "")
        return f'<mark class="ent" style="--c:{_COLOURS[span["category"]]}" title="{span["category"]} · {kind}">{inner}</mark>'
    if group == "trap":
        return f'<span class="trap" title="trap · {span["type"]}">{inner}</span>'
    return f'<span class="vis" title="visible · {span["kind"]}">{inner}</span>'
