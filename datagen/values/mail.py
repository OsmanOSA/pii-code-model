"""Email addresses: personal ones derived from the record's person, role mailboxes.

Public providers appear only with a random number in the local part, so that a
collision with a real mailbox stays unlikely; other domains are invented words,
and a few are reserved for documentation (RFC 2606). Role mailboxes follow the
record's language and the template's trade (claims@ for an insurer).

Interface:
    draw_email_domain(rng, locale) -> str
    draw_company_domain(rng, locale) -> str
    email(draw) -> str    personal address, or the generic variant (support@, noreply@...)
"""

from .draw import domain_matches, pseudo_word, weighted
from .people import handle_part

PROVIDERS = {
    "fr_FR": ("gmail.com", "orange.fr", "free.fr", "hotmail.fr", "outlook.fr", "laposte.net", "yahoo.fr", "sfr.fr", "wanadoo.fr"),
    "en_US": ("gmail.com", "yahoo.com", "outlook.com", "hotmail.com", "icloud.com", "aol.com", "proton.me"),
    "en_GB": ("gmail.com", "hotmail.co.uk", "outlook.com", "btinternet.com", "yahoo.co.uk", "sky.com", "icloud.com"),
}
_ALL_PROVIDERS = frozenset(domain for domains in PROVIDERS.values() for domain in domains)
_TLDS = {
    "fr_FR": ((".fr", 55), (".com", 25), (".eu", 8), (".io", 7), (".net", 5)),
    "en_US": ((".com", 60), (".io", 15), (".net", 10), (".co", 8), (".org", 7)),
    "en_GB": ((".co.uk", 50), (".com", 30), (".io", 10), (".org.uk", 5), (".net", 5)),
}
_RESERVED = ("example.com", "example.org", "example.net")
# Real company domains often join a brand to a word naming the trade.
_TRADE_WORDS = {
    "fr_FR": ("conseil", "groupe", "tech", "services", "immo", "transports", "sante", "assurances",
              "finance", "digital", "solutions", "habitat"),
    "en_US": ("group", "tech", "labs", "solutions", "services", "health", "capital", "systems",
              "logistics", "digital", "consulting", "partners"),
    "en_GB": ("group", "tech", "solutions", "services", "health", "capital", "systems", "logistics",
              "digital", "consulting", "partners", "homes"),
}
_ROLES = {
    "fr": ("contact", "accueil", "compta", "facturation", "dpo", "securite", "service-client", "support",
           "info", "noreply", "ne-pas-repondre", "administration", "secretariat"),
    "en": ("support", "hello", "info", "billing", "careers", "security", "privacy", "sales", "admin",
           "noreply", "no-reply", "alerts", "notifications", "helpdesk", "accounts"),
}
# (keywords of the template's domain, French roles, English roles): a mailbox fits its trade.
_TRADE_ROLES = (
    (("insurance", "assurance"), ("sinistres", "gestion-sinistres", "souscription"), ("claims", "underwriting")),
    (("health", "sante", "medical", "clinic", "dental"), ("rdv", "secretariat-medical", "patients"),
     ("appointments", "patients", "frontdesk")),
    (("hr", "rh", "payroll", "paie"), ("rh", "paie", "recrutement"), ("hr", "payroll", "careers")),
    (("bank", "banque", "banking", "fintech", "lending"), ("conformite", "backoffice", "credit"),
     ("compliance", "backoffice", "loans")),
    (("commerce", "shop", "retail"), ("commandes", "sav", "retours"), ("orders", "returns", "shop")),
    (("public", "administration", "mairie", "benefits"), ("etat-civil", "mairie", "accueil-public"),
     ("council", "services", "benefits")),
    (("developer", "tooling", "devops", "software"), ("noreply", "ci", "release"), ("noreply", "ci", "release", "build")),
    (("logistics", "transport", "shipping"), ("expedition", "depot", "suivi"), ("dispatch", "depot", "tracking")),
    (("education", "school", "scolaire"), ("inscriptions", "vie-scolaire", "accueil"), ("admissions", "office", "enrolment")),
)
_RESERVED_SHARE = 0.04  # documentation domains are rare in real files, where they mark examples
_LOCAL_FORMS = (
    ("{given}.{family}", 35), ("{g}.{family}", 15), ("{g}{family}", 12), ("{family}.{given}", 8),
    ("{given}_{family}", 8), ("{family}{g}", 6), ("{given}{nn}", 6), ("{given}.{family}{nn}", 6),
    ("{family}_{given}{nn}", 4),
)


def draw_email_domain(rng, locale: str) -> str:
    roll = rng.random()
    if roll < _RESERVED_SHARE:
        return rng.choice(_RESERVED) if rng.random() < 0.6 else f"{pseudo_word(rng)}.{rng.choice(('test', 'example'))}"
    if roll < 0.37:
        return rng.choice(PROVIDERS[locale])
    return draw_company_domain(rng, locale)


def draw_company_domain(rng, locale: str) -> str:
    stem, roll = pseudo_word(rng, 2), rng.random()
    if roll < 0.3:
        stem = f"{stem}-{rng.choice(_TRADE_WORDS[locale])}"
    elif roll < 0.45:
        stem += rng.choice(_TRADE_WORDS[locale])
    return stem + weighted(rng, _TLDS[locale])


def email(draw) -> str:
    rng = draw.rng
    if draw.variant == "generic":
        return f"{_role(draw)}@{draw.record.company_domain}"
    person, domain = draw.record.person, draw.record.email_domain
    given, family = handle_part(person.given), handle_part(person.family)
    local = weighted(rng, _LOCAL_FORMS).format(given=given, family=family, g=given[:1], nn=rng.randint(1, 99))
    if domain in _ALL_PROVIDERS:
        local += str(rng.randint(10, 9999))
    return f"{local}@{domain}"


def _role(draw) -> str:
    rng, french = draw.rng, draw.locale == "fr_FR"
    domain = draw.fill.header.get("domain", "")
    for keywords, french_roles, english_roles in _TRADE_ROLES:
        if domain_matches(domain, keywords) and rng.random() < 0.6:
            return rng.choice(french_roles if french else english_roles)
    return rng.choice(_ROLES["fr" if french else "en"])
