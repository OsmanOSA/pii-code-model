"""Companies and job titles, visible by design.

Faker builds many company names from family names (Dupont SARL): that is the
company_name trap of the label guide, met here as an ordinary visible value.
A bare family name would read as a person, so it always gets a legal form.

Interface (each takes a Draw): company, job_title
"""

_LEGAL_FORMS = {
    "fr_FR": ("SARL", "SAS", "SA", "& Fils", "Groupe", "et Associés"),
    "en_US": ("Inc.", "LLC", "Group", "& Co.", "Corp."),
    "en_GB": ("Ltd", "PLC", "Group", "& Sons", "LLP"),
}


def company(draw) -> str:
    name = draw.faker.company()
    if " " not in name and "-" not in name:
        name = f"{name} {draw.rng.choice(_LEGAL_FORMS[draw.locale])}"
    return name


def job_title(draw) -> str:
    return draw.faker.job()
