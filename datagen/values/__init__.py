"""One generator per entity kind and visible kind of schema/labels.json.

Each generator takes a Draw (values.draw) and returns the value as written in a
file, before escaping for its context.

Interface:
    GENERATORS: dict kind -> function(Draw) -> str
    generate(kind, draw) -> str
"""

from . import (banking, credentials, dates, ids_fr, ids_us_uk, keys, mail, organisations, people,
               phones, places, technical)

GENERATORS = {
    # entities
    "person_name": people.person_name,
    "email": mail.email,
    "phone": phones.phone,
    "fr_postal_address": places.address,
    "postal_address": places.address,
    "birth_date": dates.birth_date,
    "fr_social_security_number": ids_fr.social_security_number,
    "fr_tax_number": ids_fr.tax_number,
    "fr_identity_card": ids_fr.identity_card,
    "fr_passport": ids_fr.passport,
    "fr_driving_licence": ids_fr.driving_licence,
    "fr_license_plate": ids_fr.license_plate,
    "fr_siren": ids_fr.siren,
    "fr_siret": ids_fr.siret,
    "us_ssn": ids_us_uk.us_ssn,
    "us_itin": ids_us_uk.us_itin,
    "us_passport": ids_us_uk.us_passport,
    "us_driver_license": ids_us_uk.us_driver_license,
    "us_license_plate": ids_us_uk.us_license_plate,
    "uk_national_insurance_number": ids_us_uk.uk_national_insurance_number,
    "uk_passport": ids_us_uk.uk_passport,
    "uk_driving_licence": ids_us_uk.uk_driving_licence,
    "uk_license_plate": ids_us_uk.uk_license_plate,
    "iban": banking.iban,
    "payment_card": banking.payment_card,
    "card_security_code": banking.card_security_code,
    "bank_account_number": banking.bank_account_number,
    "private_key": credentials.private_key,
    "url_password": credentials.url_password,
    "password": credentials.password,
    "opaque_token": credentials.opaque_token,
    "jwt": credentials.jwt,
    "stripe_secret_key": keys.stripe_secret_key,
    "anthropic_api_key": keys.anthropic_api_key,
    "openai_api_key": keys.openai_api_key,
    "aws_access_key_id": keys.aws_access_key_id,
    "aws_secret_access_key": keys.aws_secret_access_key,
    "github_token": keys.github_token,
    "gitlab_token": keys.gitlab_token,
    "slack_token": keys.slack_token,
    "google_api_key": keys.google_api_key,
    "huggingface_token": keys.huggingface_token,
    "npm_token": keys.npm_token,
    "sendgrid_api_key": keys.sendgrid_api_key,
    # visible values
    "city": places.city,
    "postcode": places.postcode,
    "country": places.country,
    "company": organisations.company,
    "job_title": organisations.job_title,
    "date": dates.date,
    "age": dates.age,
    "uuid": technical.uuid,
    "hash": technical.hash_value,
    "git_sha": technical.git_sha,
    "order_number": technical.order_number,
    "invoice_number": technical.invoice_number,
    "customer_id": technical.customer_id,
    "ticket_id": technical.ticket_id,
    "version": technical.version,
    "ip_address": technical.ip_address,
    "hostname": technical.hostname,
    "url": technical.url,
    "file_path": technical.file_path,
    "username": technical.username,
    "bic": banking.bic,
    "stripe_publishable_key": technical.stripe_publishable_key,
    "ssh_public_key": technical.ssh_public_key,
}


def generate(kind: str, draw) -> str:
    return GENERATORS[kind](draw)
