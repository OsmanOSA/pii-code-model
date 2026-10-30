"""Visible technical values: identifiers, versions, network names, paths, public keys.

They stay visible by design. Templates use them so that files look real and the
model meets high-entropy values that are not secrets.

Interface (each takes a Draw): uuid, hash_value, git_sha, order_number, invoice_number,
customer_id, ticket_id, version, ip_address, hostname, url, file_path, username,
stripe_publishable_key, ssh_public_key
"""

import uuid as uuid_module

from .draw import ALNUM, BASE64, HEX, digits, domain_matches, pseudo_word, random_string, weighted
from .keys import stripe_mode

_STRIPE_TRADES = ("commerce", "saas", "fintech", "payment", "payments", "shop", "subscription")

_SERVICES = ("db", "api", "web", "smtp", "redis", "pg", "mq", "auth", "batch", "sftp", "ldap", "cache",
             "gw", "proxy", "mail", "vault", "search", "files", "etl", "report")
_ENVIRONMENTS = ("prod", "staging", "preprod", "recette", "dev", "qa", "int")
_PATH_WORDS = ("api", "v1", "v2", "export", "health", "status", "docs", "webhooks", "orders", "reports",
               "auth", "callback", "static", "dashboard", "metrics", "billing", "sync", "upload", "files", "jobs")
_PROJECTS = ("OPS", "PAY", "SUP", "INC", "BUG", "DEV", "RH", "DATA", "SEC", "PLAT", "CRM", "INFRA")
_USERNAMES = ("svc-backup", "deploy", "admin", "root", "ci-runner", "postgres", "app_user", "readonly",
              "ubuntu", "ec2-user", "www-data", "gitlab-runner", "batch01", "svc_etl", "monitoring",
              "sa_reporting", "build", "operator", "nobody", "sync-bot")
_ADJECTIVES = ("swift", "quiet", "blue", "dark", "lazy", "happy", "brave", "rusty", "silent", "cosmic")
_ANIMALS = ("otter", "falcon", "panda", "lynx", "heron", "badger", "koala", "dragonfly", "gecko", "walrus")
_FILE_WORDS = ("app", "export", "report", "sync", "batch", "audit", "access", "error", "import", "backup")
_KEY_COMMENTS = ("deploy-key", "ci-runner", "backup-2024", "github-actions", "bastion")


def uuid(draw) -> str:
    value = str(uuid_module.UUID(int=draw.rng.getrandbits(128), version=4))
    return value.upper() if draw.rng.random() < 0.08 else value


def hash_value(draw) -> str:
    return random_string(draw.rng, HEX, draw.rng.choice((32, 40, 64)))


def git_sha(draw) -> str:
    return random_string(draw.rng, HEX, draw.rng.choice((40, 40, 40, 7, 8, 12)))


def order_number(draw) -> str:
    rng = draw.rng
    return weighted(rng, ((f"CMD-{rng.randint(2019, 2026)}-{digits(rng, 6)}", 25), (f"ORD-{digits(rng, 7)}", 25),
                          (f"#{digits(rng, 6)}", 15), (digits(rng, 10), 15), (f"PO-{digits(rng, 5)}", 10),
                          (f"{rng.randint(2019, 2026)}{digits(rng, 6)}", 10)))


def invoice_number(draw) -> str:
    rng = draw.rng
    year = rng.randint(2019, 2026)
    return weighted(rng, ((f"FAC-{year}-{digits(rng, 5)}", 30), (f"INV-{digits(rng, 6)}", 30),
                          (f"F{year}{digits(rng, 5)}", 15), (f"{year}/{digits(rng, 4)}", 15), (f"INV{year}-{digits(rng, 4)}", 10)))


def customer_id(draw) -> str:
    rng = draw.rng
    table = [(f"CUST-{digits(rng, 6)}", 25), (f"C{digits(rng, 7)}", 20), (f"CLI-{digits(rng, 5)}", 20),
             (digits(rng, rng.randint(6, 8)), 20)]
    if domain_matches(draw.fill.header.get("domain", ""), _STRIPE_TRADES):  # cus_ ids belong to Stripe users
        table.append((f"cus_{random_string(rng, ALNUM, 14)}", 25))
    return weighted(rng, table)


def ticket_id(draw) -> str:
    rng = draw.rng
    return weighted(rng, ((f"{rng.choice(_PROJECTS)}-{rng.randint(10, 9999)}", 65), (f"#{digits(rng, 4)}", 20),
                          (f"INC{digits(rng, 7)}", 15)))


def version(draw) -> str:
    rng = draw.rng
    core = f"{rng.randint(0, 5)}.{rng.randint(0, 24)}.{rng.randint(0, 15)}"
    return weighted(rng, ((core, 55), (f"v{core}", 20), (f"{core}-rc.{rng.randint(1, 4)}", 8),
                          (f"{core}-beta.{rng.randint(1, 4)}", 7), (f"{rng.randint(2022, 2026)}.{rng.randint(1, 12)}.{rng.randint(0, 9)}", 10)))


def ip_address(draw) -> str:
    rng = draw.rng
    kind = weighted(rng, (("private", 50), ("public", 40), ("v6", 10)))
    if kind == "private":
        return weighted(rng, ((f"10.{rng.randint(0, 255)}.{rng.randint(0, 255)}.{rng.randint(1, 254)}", 50),
                              (f"192.168.{rng.randint(0, 255)}.{rng.randint(1, 254)}", 35),
                              (f"172.{rng.randint(16, 31)}.{rng.randint(0, 255)}.{rng.randint(1, 254)}", 15)))
    if kind == "public":
        first = rng.choice([octet for octet in range(11, 224) if octet not in (100, 127, 169, 172, 192)])
        return f"{first}.{rng.randint(0, 255)}.{rng.randint(0, 255)}.{rng.randint(1, 254)}"
    return f"2a01:{rng.randint(0, 0xffff):x}:{rng.randint(0, 0xffff):x}::{rng.randint(1, 0xffff):x}"


def hostname(draw) -> str:
    rng = draw.rng
    service, environment, number = rng.choice(_SERVICES), rng.choice(_ENVIRONMENTS), rng.randint(1, 12)
    return weighted(rng, (
        (f"{service}-{environment}-{number:02d}.internal", 25),
        (f"{service}.{draw.record.company_domain}", 25),
        (f"ip-10-{rng.randint(0, 255)}-{rng.randint(0, 255)}-{rng.randint(1, 254)}.eu-west-3.compute.internal", 10),
        (f"{service}.{environment}.svc.cluster.local", 15),
        (f"srv-{service}{number:02d}", 15),
        (f"{service}{number:02d}.{environment}.{pseudo_word(rng)}.lan", 10),
    ))


def url(draw) -> str:
    rng = draw.rng
    host = weighted(rng, ((f"api.{draw.record.company_domain}", 40), (f"{rng.choice(_SERVICES)}.{draw.record.company_domain}", 30),
                          (hostname(draw), 30)))
    path = "/".join(rng.choice(_PATH_WORDS) for _ in range(rng.randint(1, 3)))
    query = weighted(rng, (("", 60), (f"?page={rng.randint(1, 9)}", 15), ("?format=json", 15), (f"?limit={rng.choice((50, 100, 500))}", 10)))
    return f"https://{host}/{path}{query}"


def file_path(draw) -> str:
    rng = draw.rng
    name = f"{rng.choice(_FILE_WORDS)}-{rng.randint(2019, 2026)}{rng.randint(1, 12):02d}.{rng.choice(('log', 'csv', 'json', 'txt', 'gz'))}"
    app = rng.choice(_SERVICES)
    return weighted(rng, ((f"/var/log/{app}/{name}", 35), (f"/opt/{app}/data/{name}", 20), (f"/srv/{app}/exports/{name}", 15),
                          (f"C:\\ProgramData\\{app.capitalize()}\\logs\\{name}", 15), (f"./data/{name}", 15)))


def username(draw) -> str:
    rng = draw.rng
    if rng.random() < 0.6:
        return rng.choice(_USERNAMES)
    return f"{rng.choice(_ADJECTIVES)}{rng.choice(_ANIMALS)}{rng.randint(1, 99)}"


def stripe_publishable_key(draw) -> str:
    rng, prefix = draw.rng, f"pk_{stripe_mode(draw)}_"
    return prefix + (random_string(rng, ALNUM, 24) if rng.random() < 0.5 else "51" + random_string(rng, ALNUM, 97))


def ssh_public_key(draw) -> str:
    rng = draw.rng
    if rng.random() < 0.6:
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI" + random_string(rng, BASE64, 43)
    else:
        key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQ" + random_string(rng, BASE64, 508)
    return f"{key} {rng.choice(_KEY_COMMENTS)}"
