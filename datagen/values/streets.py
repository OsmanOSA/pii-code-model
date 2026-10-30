"""Street lines built from common street names of each country.

Common street names are public geography, not personal data. Faker's street
names are avoided: built from person names ("Kimberly Shores"), they look like
nothing real and blur the difference between a name and an address.

Interface:
    street_line(rng, country, part=None) -> str    "12 rue de la Gare", "4521 W Oak St Apt 4B", "Flat 3, 27 Station Road"
"""

from functools import lru_cache

from ..splits import in_part
from .draw import weighted

_FR_TYPES = (("rue", 52), ("avenue", 12), ("boulevard", 7), ("chemin", 6), ("impasse", 5), ("allée", 5),
             ("place", 4), ("route", 4), ("quai", 2), ("cours", 2), ("square", 1))
_FR_NAMES = (
    "de la Gare", "de la République", "de la Paix", "de la Mairie", "de l'Église", "des Écoles", "des Lilas",
    "des Tilleuls", "du Moulin", "du Château", "du Stade", "de la Fontaine", "des Prés", "des Vignes",
    "des Acacias", "des Roses", "du Commerce", "du Marché", "de la Liberté", "de la Libération",
    "du 8 Mai 1945", "du 11 Novembre", "des Jardins", "du Pont", "des Peupliers", "des Chênes", "du Puits",
    "de Verdun", "de Bretagne", "des Champs", "de la Poste", "du Four", "des Vergers", "de la Croix",
    "Victor Hugo", "Jean Jaurès", "Pasteur", "Jules Ferry", "Gambetta", "Voltaire", "du Général de Gaulle",
    "Jean Moulin", "Émile Zola", "Georges Clemenceau", "du Maréchal Foch", "du Général Leclerc", "Carnot",
    "Anatole France", "Paul Bert", "Jean-Jacques Rousseau", "de Lattre de Tassigny", "Aristide Briand",
)
_FR_COMPLEMENTS = (", Bât. B", ", appt 12", ", 3e étage", ", Résidence les Pins", " - porte 4", ", lot 7")
_US_NAMES = (
    "Main", "Oak", "Maple", "Pine", "Cedar", "Elm", "Walnut", "Willow", "Birch", "Cherry", "Spruce",
    "Chestnut", "Hickory", "Sycamore", "Magnolia", "Washington", "Lincoln", "Jefferson", "Madison", "Adams",
    "Franklin", "Hamilton", "Monroe", "Park", "Lake", "Hill", "Church", "Center", "Mill", "River", "Ridge",
    "Highland", "Sunset", "Meadow", "Spring", "Valley", "Forest", "Prospect", "Union", "Market", "Pleasant",
    "College", "Front", "Water", "School", "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "10th", "12th",
)
_US_SUFFIXES = (("St", 35), ("Ave", 20), ("Rd", 12), ("Dr", 10), ("Ln", 7), ("Blvd", 4), ("Ct", 4), ("Way", 4),
                ("Pl", 2), ("Ter", 1), ("Cir", 1))
_US_UNITS = ("Apt {n}", "Apt {n}B", "Unit {n}", "Suite {n}00", "#{n}")
_GB_NAMES = (
    "High Street", "Station Road", "Main Street", "Park Road", "Church Road", "Church Street", "London Road",
    "Victoria Road", "Green Lane", "Manor Road", "Church Lane", "Park Avenue", "The Avenue", "The Crescent",
    "Queens Road", "New Road", "Grange Road", "Kings Road", "Kingsway", "Windsor Road", "Highfield Road",
    "Mill Lane", "Alexandra Road", "York Road", "School Lane", "Springfield Road", "Albert Road", "Mill Road",
    "North Street", "West Street", "Chester Road", "Richmond Road", "Stanley Road", "Victoria Street",
    "Market Street", "Broadway", "Orchard Close", "Meadow Way", "Beech Grove", "St John's Road",
)


def street_line(rng, country: str, part: str | None = None) -> str:
    return {"FR": _french, "US": _american, "GB": _british}[country](rng, part)


@lru_cache(maxsize=None)
def _names(country: str, part: str | None) -> tuple:
    # Street names held out for validation never appear in training fills (datagen.splits).
    names = {"FR": _FR_NAMES, "US": _US_NAMES, "GB": _GB_NAMES}[country]
    return tuple(name for name in names if in_part(name, part)) or names


def _house_number(rng, most: int) -> int:
    return min(int(rng.expovariate(1 / 30)) + 1, most)  # small numbers are the most common


def _french(rng, part) -> str:
    number = str(_house_number(rng, 250)) + (rng.choice((" bis", " ter", "B")) if rng.random() < 0.05 else "")
    street = f"{number} {weighted(rng, _FR_TYPES)} {rng.choice(_names('FR', part))}"
    return street + rng.choice(_FR_COMPLEMENTS) if rng.random() < 0.08 else street


def _american(rng, part) -> str:
    direction = rng.choice(("N ", "S ", "E ", "W ")) if rng.random() < 0.12 else ""
    street = f"{rng.randint(1, 9999)} {direction}{rng.choice(_names('US', part))} {weighted(rng, _US_SUFFIXES)}"
    if rng.random() < 0.15:
        street += " " + rng.choice(_US_UNITS).format(n=rng.randint(1, 40))
    return street


def _british(rng, part) -> str:
    street = f"{_house_number(rng, 300)} {rng.choice(_names('GB', part))}"
    return f"Flat {rng.randint(1, 24)}, {street}" if rng.random() < 0.12 else street
