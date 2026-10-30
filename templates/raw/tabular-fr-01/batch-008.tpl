⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: education
appearance: multi-row INSERT with column list, ON DUPLICATE KEY, boarding pupils, initials as validator, trigger named after a person
scenario: dump of a boarding school's infirmary table, with an upsert written by the on-site technician
⟬text⟭
-- internat : fiches élèves pour l'infirmerie
CREATE TABLE fiche_internat (
  id INT PRIMARY KEY,
  nom VARCHAR(160) NOT NULL,
  date_naissance DATE NOT NULL,
  nir VARCHAR(21),
  piece_type VARCHAR(10),
  piece_numero VARCHAR(12),
  hebergement VARCHAR(20),
  valide_par VARCHAR(10)
);

INSERT INTO fiche_internat (id, nom, date_naissance, nir, piece_type, piece_numero, hebergement, valide_par) VALUES
(1, '⟬person_name#1⟭', '⟬birth_date#1⟭', '⟬fr_social_security_number#1⟭', 'PASSEPORT', '⟬fr_passport#1⟭', 'Dortoir B', '⟬trap:initials|CG⟭'),
(2, '⟬person_name#2⟭', '⟬birth_date#2⟭', '⟬fr_social_security_number#2⟭', 'PASSEPORT', '⟬fr_passport#2⟭', 'Dortoir A', '⟬trap:initials|CG⟭'),
(3, '⟬person_name#3⟭', '⟬birth_date#3⟭', '⟬fr_social_security_number#3⟭', 'CNI', '⟬fr_identity_card#3⟭', 'Dortoir B', '⟬trap:initials|CG⟭'),
(4, '⟬person_name#4⟭', '⟬birth_date#4⟭', '⟬fr_social_security_number#4⟭', 'PASSEPORT', '⟬fr_passport#4⟭', 'Dortoir B', '⟬trap:initials|PL⟭'),
(5, '⟬person_name#5⟭', '⟬birth_date#5⟭', '⟬fr_social_security_number#5⟭', 'PASSEPORT', '⟬fr_passport#5⟭', 'Externe', '⟬trap:initials|N.-B.⟭'),
(6, '⟬person_name#6⟭', '⟬birth_date#6⟭', '⟬fr_social_security_number#6⟭', 'CNI', '⟬fr_identity_card#6⟭', 'Dortoir B', '⟬trap:initials|CG⟭'),
(7, '⟬person_name#7⟭', '⟬birth_date#7⟭', '⟬fr_social_security_number#7⟭', 'PASSEPORT', '⟬fr_passport#7⟭', 'Dortoir A', '⟬trap:initials|N.-B.⟭'),
(8, '⟬person_name#8⟭', '⟬birth_date#8⟭', '⟬fr_social_security_number#8⟭', 'PASSEPORT', '⟬fr_passport#8⟭', 'Dortoir B', '⟬trap:initials|CG⟭'),
(9, '⟬person_name#9⟭', '⟬birth_date#9⟭', '⟬fr_social_security_number#9⟭', 'PASSEPORT', '⟬fr_passport#9⟭', 'Dortoir B', '⟬trap:initials|CG⟭'),
(10, '⟬person_name#10⟭', '⟬birth_date#10⟭', '⟬fr_social_security_number#10⟭', 'PASSEPORT', '⟬fr_passport#10⟭', 'Externe', '⟬trap:initials|CG⟭'),
(11, '⟬person_name#11⟭', '⟬birth_date#11⟭', '⟬fr_social_security_number#11⟭', 'PASSEPORT', '⟬fr_passport#11⟭', 'Dortoir A', '⟬trap:initials|PL⟭'),
(12, '⟬person_name#12⟭', '⟬birth_date#12⟭', '⟬fr_social_security_number#12⟭', 'PASSEPORT', '⟬fr_passport#12⟭', 'Dortoir A', '⟬trap:initials|CG⟭')
ON DUPLICATE KEY UPDATE hebergement = VALUES(hebergement);

CREATE TRIGGER ⟬trap:code_identifier|maj_fiche_⦃family⦄⟭ BEFORE UPDATE ON fiche_internat
FOR EACH ROW SET NEW.valide_par = UPPER(NEW.valide_par);
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: pasted cells, day column, birth date, passport or identity card under one header, no document label
scenario: attendance sheet of a hospital's free access clinic, pasted by the social worker for a monthly report
⟬text⟭
PASS - passages du mois
Assistante sociale :	⟬person_name#40f⟭

Jour	Personne reçue	Date de naissance	Document	Situation	Orientation
28	⟬person_name#1⟭	⟬birth_date#1⟭	⟬fr_identity_card#1⟭	AME en cours	Dentaire
25	⟬person_name#2⟭	⟬birth_date#2⟭	⟬fr_passport#2⟭	Droits ouverts	Social
28	⟬person_name#3⟭	⟬birth_date#3⟭	⟬fr_passport#3⟭	Droits ouverts	Social
12	⟬person_name#4⟭	⟬birth_date#4⟭	⟬trap:indicator_non_pii|Sans document⟭	Aucun droit	Médecine
07	⟬person_name#5⟭	⟬birth_date#5⟭	⟬fr_passport#5⟭	Aucun droit	Médecine
13	⟬person_name#6⟭	⟬birth_date#6⟭	⟬fr_passport#6⟭	Aucun droit	Social
19	⟬person_name#7⟭	⟬birth_date#7⟭	⟬fr_identity_card#7⟭	Droits ouverts	Médecine
21	⟬person_name#8⟭	⟬birth_date#8⟭	⟬fr_passport#8⟭	AME en cours	Dentaire
29	⟬person_name#9⟭	⟬birth_date#9⟭	⟬fr_passport#9⟭	C2S	Dentaire
11	⟬person_name#10⟭	⟬birth_date#10⟭	⟬fr_passport#10⟭	Droits ouverts	Dentaire
19	⟬person_name#11⟭	⟬birth_date#11⟭	⟬fr_identity_card#11⟭	Aucun droit	Social
11	⟬person_name#12⟭	⟬birth_date#12⟭	⟬fr_identity_card#12⟭	C2S	Dentaire
13	⟬person_name#13⟭	⟬birth_date#13⟭	⟬fr_passport#13⟭	Droits ouverts	Dentaire
02	⟬person_name#14⟭	⟬birth_date#14⟭	⟬fr_identity_card#14⟭	Aucun droit	Dentaire
22	⟬person_name#15⟭	⟬birth_date#15⟭	⟬fr_identity_card#15⟭	AME en cours	Dentaire
11	⟬person_name#16⟭	⟬birth_date#16⟭	⟬fr_identity_card#16⟭	AME en cours	Dentaire
16	⟬person_name#17⟭	⟬birth_date#17⟭	⟬trap:indicator_non_pii|Sans document⟭	Aucun droit	Dentaire
02	⟬person_name#18⟭	⟬birth_date#18⟭	⟬fr_passport#18⟭	C2S	Dentaire
07	⟬person_name#19⟭	⟬birth_date#19⟭	⟬trap:indicator_non_pii|Sans document⟭	Aucun droit	Dentaire

Données à ne pas sortir du service
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: real estate
appearance: Markdown tables, off-plan sales, tax number, IBAN, company SIREN, static site tool named after a person
scenario: project page of a housing developer in an internal documentation site, with buyers, their bank details and the contractors
⟬text⟭
---
title: Programme Les Tilleuls
generator: ⟬trap:library|Hugo⟭
draft: true
---

# Programme neuf : suivi commercial

Pilote du programme : ⟬person_name#90⟭. Notaire : Maître ⟬person_name:family#91⟭.
Page interne : ne pas publier sur le site vitrine.

## Réservations

| Lot | Type | Prix | Réservataire | N° fiscal | PTZ | Réservé le |
| --- | --- | ---: | --- | --- | --- | --- |
| C13 | T4 | 260 000 € | ⟬person_name#1⟭ | ⟬fr_tax_number#1⟭ | Non | ⟬date#2⟭ |
| C32 | T4 | 337 000 € | ⟬person_name#2⟭ | ⟬fr_tax_number#2⟭ | Oui | ⟬date#3⟭ |
| B23 | T3 | 412 000 € | ⟬person_name#3⟭ | ⟬fr_tax_number#3⟭ | Non | ⟬date#6⟭ |
| C24 | T3 | 219 000 € | ⟬person_name#4⟭ | ⟬fr_tax_number#4⟭ | Oui | ⟬date#3⟭ |
| C27 | T4 | 239 000 € | ⟬person_name#5⟭ | ⟬fr_tax_number#5⟭ | Non | ⟬date#5⟭ |
| C23 | T4 | 412 000 € | ⟬person_name#6⟭ | ⟬fr_tax_number#6⟭ | Oui | ⟬date#3⟭ |
| B22 | T4 | 361 000 € | ⟬person_name#7⟭ | ⟬fr_tax_number#7⟭ | Non | ⟬date#6⟭ |
| B42 | T3 | 326 000 € | ⟬person_name#8⟭ | ⟬fr_tax_number#8⟭ | Non | ⟬date#2⟭ |
| A49 | T2 | 184 000 € | ⟬person_name#9⟭ | ⟬fr_tax_number#9⟭ | Oui | ⟬date#2⟭ |
| C44 | T2 | 269 000 € | ⟬person_name#10⟭ | ⟬fr_tax_number#10⟭ | Oui | ⟬date#5⟭ |
| A44 | T2 | 356 000 € | ⟬person_name#11⟭ | ⟬fr_tax_number#11⟭ | Non | ⟬date#2⟭ |
| B26 | T3 | 398 000 € | ⟬person_name#12⟭ | ⟬fr_tax_number#12⟭ | Oui | ⟬date#5⟭ |
| A45 | T2 | 230 000 € | ⟬person_name#13⟭ | ⟬fr_tax_number#13⟭ | Oui | ⟬date#5⟭ |
| C24 | T3 | 317 000 € | ⟬person_name#14⟭ | ⟬fr_tax_number#14⟭ | Non | ⟬date#2⟭ |
| A32 | T3 | 244 000 € | ⟬person_name#15⟭ | ⟬fr_tax_number#15⟭ | Non | ⟬date#6⟭ |
| B30 | T4 | 195 000 € | ⟬person_name#16⟭ | ⟬fr_tax_number#16⟭ | Oui | ⟬date#5⟭ |
| A12 | T2 | 404 000 € | ⟬person_name#17⟭ | ⟬fr_tax_number#17⟭ | Oui | ⟬date#1⟭ |
| C43 | T4 | 215 000 € | ⟬person_name#18⟭ | ⟬fr_tax_number#18⟭ | Non | ⟬date#6⟭ |
| C35 | T3 | 380 000 € | ⟬person_name#19⟭ | ⟬fr_tax_number#19⟭ | Oui | ⟬date#1⟭ |
| B35 | T3 | 409 000 € | ⟬person_name#20⟭ | ⟬fr_tax_number#20⟭ | Non | ⟬date#5⟭ |

## Coordonnées des acquéreurs

| Acquéreur | Adresse actuelle | IBAN appels de fonds |
| --- | --- | --- |
| ⟬person_name#1⟭ | ⟬fr_postal_address#1⟭ | ⟬iban#1⟭ |
| ⟬person_name#2⟭ | ⟬fr_postal_address#2⟭ | ⟬iban#2⟭ |
| ⟬person_name#3⟭ | ⟬fr_postal_address#3⟭ | ⟬iban#3⟭ |
| ⟬person_name#4⟭ | ⟬fr_postal_address#4⟭ | ⟬iban#4⟭ |
| ⟬person_name#5⟭ | ⟬fr_postal_address#5⟭ | ⟬iban#5⟭ |
| ⟬person_name#6⟭ | ⟬fr_postal_address#6⟭ | ⟬iban#6⟭ |
| ⟬person_name#7⟭ | ⟬fr_postal_address#7⟭ | ⟬iban#7⟭ |
| ⟬person_name#8⟭ | ⟬fr_postal_address#8⟭ | ⟬iban#8⟭ |
| ⟬person_name#9⟭ | ⟬fr_postal_address#9⟭ | ⟬iban#9⟭ |
| ⟬person_name#10⟭ | ⟬fr_postal_address#10⟭ | ⟬iban#10⟭ |
| ⟬person_name#11⟭ | ⟬fr_postal_address#11⟭ | ⟬iban#11⟭ |
| ⟬person_name#12⟭ | ⟬fr_postal_address#12⟭ | ⟬iban#12⟭ |
| ⟬person_name#13⟭ | ⟬fr_postal_address#13⟭ | ⟬iban#13⟭ |
| ⟬person_name#14⟭ | ⟬fr_postal_address#14⟭ | ⟬iban#14⟭ |
| ⟬person_name#15⟭ | ⟬fr_postal_address#15⟭ | ⟬iban#15⟭ |
| ⟬person_name#16⟭ | ⟬fr_postal_address#16⟭ | ⟬iban#16⟭ |
| ⟬person_name#17⟭ | ⟬fr_postal_address#17⟭ | ⟬iban#17⟭ |
| ⟬person_name#18⟭ | ⟬fr_postal_address#18⟭ | ⟬iban#18⟭ |
| ⟬person_name#19⟭ | ⟬fr_postal_address#19⟭ | ⟬iban#19⟭ |
| ⟬person_name#20⟭ | ⟬fr_postal_address#20⟭ | ⟬iban#20⟭ |

## Entreprises du chantier

| Entreprise | SIREN | Lot | Marché |
| --- | --- | --- | ---: |
| ⟬company#50⟭ | ⟬fr_siren#50⟭ | Menuiseries | 269 000 € |
| ⟬company#51⟭ | ⟬fr_siren#51⟭ | Gros œuvre | 754 000 € |
| ⟬company#52⟭ | ⟬fr_siren#52⟭ | Plomberie | 668 000 € |
| ⟬company#53⟭ | ⟬fr_siren#53⟭ | Ascenseurs | 514 000 € |
| ⟬company#54⟭ | ⟬fr_siren#54⟭ | Électricité | 314 000 € |
| ⟬company#55⟭ | ⟬fr_siren#55⟭ | Menuiseries | 145 000 € |
| ⟬company#56⟭ | ⟬fr_siren#56⟭ | Menuiseries | 889 000 € |

Livraison prévue au dernier trimestre.
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: associations
appearance: fixed columns, sector names that are given names, driving licence, identity card
scenario: volunteer drivers of a solidarity transport service, printed from the association's old database
⟬text⟭
TRANSPORT SOLIDAIRE - CONDUCTEURS AGREES
ASSOCIATION ⟬company#30⟭               ETAT DU ⟬date#1⟭

SECTEUR                             KM    PERMIS        PIECE         CONDUCTEUR
⟬trap:word_name|SAINT-PIERRE⟭       489  ⟬fr_driving_licence#1⟭  ⟬fr_identity_card#1⟭  ⟬person_name#1⟭
⟬trap:word_name|SAINT-ETIENNE⟭      907  ⟬fr_driving_licence#2⟭  ⟬fr_identity_card#2⟭  ⟬person_name#2⟭
⟬trap:word_name|SAINTE-MARIE⟭       398  ⟬fr_driving_licence#3⟭  ⟬fr_identity_card#3⟭  ⟬person_name#3⟭
⟬trap:word_name|SAINTE-MARIE⟭       199  ⟬fr_driving_licence#4⟭  ⟬fr_identity_card#4⟭  ⟬person_name#4⟭
⟬trap:word_name|SAINTE-MARIE⟭       141  ⟬fr_driving_licence#5⟭  ⟬fr_identity_card#5⟭  ⟬person_name#5⟭
ZONE NORD                           245  ⟬fr_driving_licence#6⟭  ⟬fr_identity_card#6⟭  ⟬person_name#6⟭
⟬trap:word_name|SAINT-PIERRE⟭       132  ⟬fr_driving_licence#7⟭  ⟬fr_identity_card#7⟭  ⟬person_name#7⟭
⟬trap:word_name|SAINTE-MARIE⟭       411  ⟬fr_driving_licence#8⟭  ⟬fr_identity_card#8⟭  ⟬person_name#8⟭
ZONE NORD                           501  ⟬fr_driving_licence#9⟭  ⟬fr_identity_card#9⟭  ⟬person_name#9⟭
⟬trap:word_name|SAINTE-MARIE⟭       174  ⟬fr_driving_licence#10⟭  ⟬fr_identity_card#10⟭  ⟬person_name#10⟭
⟬trap:word_name|SAINT-ETIENNE⟭      576  ⟬fr_driving_licence#11⟭  ⟬fr_identity_card#11⟭  ⟬person_name#11⟭
⟬trap:word_name|SAINT-ETIENNE⟭      595  ⟬fr_driving_licence#12⟭  ⟬fr_identity_card#12⟭  ⟬person_name#12⟭
⟬trap:word_name|SAINT-ETIENNE⟭      856  ⟬fr_driving_licence#13⟭  ⟬fr_identity_card#13⟭  ⟬person_name#13⟭
⟬trap:word_name|SAINT-PIERRE⟭       544  ⟬fr_driving_licence#14⟭  ⟬fr_identity_card#14⟭  ⟬person_name#14⟭
LE BOURG                            785  ⟬fr_driving_licence#15⟭  ⟬fr_identity_card#15⟭  ⟬person_name#15⟭
ZONE NORD                           138  ⟬fr_driving_licence#16⟭  ⟬fr_identity_card#16⟭  ⟬person_name#16⟭
LE BOURG                            342  ⟬fr_driving_licence#17⟭  ⟬fr_identity_card#17⟭  ⟬person_name#17⟭
⟬trap:word_name|SAINT-PIERRE⟭       191  ⟬fr_driving_licence#18⟭  ⟬fr_identity_card#18⟭  ⟬person_name#18⟭
⟬trap:word_name|SAINTE-MARIE⟭       730  ⟬fr_driving_licence#19⟭  ⟬fr_identity_card#19⟭  ⟬person_name#19⟭
⟬trap:word_name|SAINT-PIERRE⟭       853  ⟬fr_driving_licence#20⟭  ⟬fr_identity_card#20⟭  ⟬person_name#20⟭
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: HR
appearance: pipe-separated CSV, NIR, tax number, IBAN, optional driving licence
scenario: benefits file a broker asked an employer for, exported with pipes from the HR system by an assistant
⟬text⟭
matricule|salarie|nir|ne_le|numero_fiscal|permis|iban|taux_pas|formule_mutuelle|mail|age
64151|⟬person_name#1⟭|⟬fr_social_security_number#1⟭|⟬birth_date#1⟭|⟬fr_tax_number#1⟭||⟬iban#1⟭|15,9|Famille|⟬email#1⟭|⟬age#1⟭
47110|⟬person_name#2⟭|⟬fr_social_security_number#2⟭|⟬birth_date#2⟭|⟬fr_tax_number#2⟭||⟬iban#2⟭|24,1|Isolé|⟬email#2⟭|⟬age#2⟭
42719|⟬person_name#3⟭|⟬fr_social_security_number#3⟭|⟬birth_date#3⟭|⟬fr_tax_number#3⟭||⟬iban#3⟭|36,3|Isolé|⟬email#3⟭|⟬age#3⟭
26153|⟬person_name#4⟭|⟬fr_social_security_number#4⟭|⟬birth_date#4⟭|⟬fr_tax_number#4⟭|⟬fr_driving_licence#4⟭|⟬iban#4⟭|16,9|Duo|⟬email#4⟭|⟬age#4⟭
81742|⟬person_name#5⟭|⟬fr_social_security_number#5⟭|⟬birth_date#5⟭|⟬fr_tax_number#5⟭|⟬fr_driving_licence#5⟭|⟬iban#5⟭|24,2|Duo|⟬email#5⟭|⟬age#5⟭
42504|⟬person_name#6⟭|⟬fr_social_security_number#6⟭|⟬birth_date#6⟭|⟬fr_tax_number#6⟭||⟬iban#6⟭|4,8|Duo|⟬email#6⟭|⟬age#6⟭
88608|⟬person_name#7⟭|⟬fr_social_security_number#7⟭|⟬birth_date#7⟭|⟬fr_tax_number#7⟭|⟬fr_driving_licence#7⟭|⟬iban#7⟭|40,0|Isolé|⟬email#7⟭|⟬age#7⟭
32448|⟬person_name#8⟭|⟬fr_social_security_number#8⟭|⟬birth_date#8⟭|⟬fr_tax_number#8⟭|⟬fr_driving_licence#8⟭|⟬iban#8⟭|39,7|Duo|⟬email#8⟭|⟬age#8⟭
39098|⟬person_name#9⟭|⟬fr_social_security_number#9⟭|⟬birth_date#9⟭|⟬fr_tax_number#9⟭|⟬fr_driving_licence#9⟭|⟬iban#9⟭|42,5|Duo|⟬email#9⟭|⟬age#9⟭
66700|⟬person_name#10⟭|⟬fr_social_security_number#10⟭|⟬birth_date#10⟭|⟬fr_tax_number#10⟭||⟬iban#10⟭|20,9|Duo|⟬email#10⟭|⟬age#10⟭
45732|⟬person_name#11⟭|⟬fr_social_security_number#11⟭|⟬birth_date#11⟭|⟬fr_tax_number#11⟭||⟬iban#11⟭|16,3|Isolé|⟬email#11⟭|⟬age#11⟭
63053|⟬person_name#12⟭|⟬fr_social_security_number#12⟭|⟬birth_date#12⟭|⟬fr_tax_number#12⟭|⟬fr_driving_licence#12⟭|⟬iban#12⟭|2,7|Isolé|⟬email#12⟭|⟬age#12⟭
67046|⟬person_name#13⟭|⟬fr_social_security_number#13⟭|⟬birth_date#13⟭|⟬fr_tax_number#13⟭|⟬fr_driving_licence#13⟭|⟬iban#13⟭|27,6|Duo|⟬email#13⟭|⟬age#13⟭
55064|⟬person_name#14⟭|⟬fr_social_security_number#14⟭|⟬birth_date#14⟭|⟬fr_tax_number#14⟭|⟬fr_driving_licence#14⟭|⟬iban#14⟭|36,9|Famille|⟬email#14⟭|⟬age#14⟭
62604|⟬person_name#15⟭|⟬fr_social_security_number#15⟭|⟬birth_date#15⟭|⟬fr_tax_number#15⟭|⟬fr_driving_licence#15⟭|⟬iban#15⟭|29,9|Duo|⟬email#15⟭|⟬age#15⟭
46968|⟬person_name#16⟭|⟬fr_social_security_number#16⟭|⟬birth_date#16⟭|⟬fr_tax_number#16⟭||⟬iban#16⟭|6,7|Isolé|⟬email#16⟭|⟬age#16⟭
12523|⟬person_name#17⟭|⟬fr_social_security_number#17⟭|⟬birth_date#17⟭|⟬fr_tax_number#17⟭|⟬fr_driving_licence#17⟭|⟬iban#17⟭|20,1|Famille|⟬email#17⟭|⟬age#17⟭
45683|⟬person_name#18⟭|⟬fr_social_security_number#18⟭|⟬birth_date#18⟭|⟬fr_tax_number#18⟭||⟬iban#18⟭|16,2|Famille|⟬email#18⟭|⟬age#18⟭
59164|⟬person_name#19⟭|⟬fr_social_security_number#19⟭|⟬birth_date#19⟭|⟬fr_tax_number#19⟭|⟬fr_driving_licence#19⟭|⟬iban#19⟭|4,6|Isolé|⟬email#19⟭|⟬age#19⟭
19771|⟬person_name#20⟭|⟬fr_social_security_number#20⟭|⟬birth_date#20⟭|⟬fr_tax_number#20⟭||⟬iban#20⟭|16,5|Isolé|⟬email#20⟭|⟬age#20⟭
16520|⟬person_name#21⟭|⟬fr_social_security_number#21⟭|⟬birth_date#21⟭|⟬fr_tax_number#21⟭|⟬fr_driving_licence#21⟭|⟬iban#21⟭|22,9|Duo|⟬email#21⟭|⟬age#21⟭
70851|⟬person_name#22⟭|⟬fr_social_security_number#22⟭|⟬birth_date#22⟭|⟬fr_tax_number#22⟭|⟬fr_driving_licence#22⟭|⟬iban#22⟭|43,4|Isolé|⟬email#22⟭|⟬age#22⟭
86197|⟬person_name#23⟭|⟬fr_social_security_number#23⟭|⟬birth_date#23⟭|⟬fr_tax_number#23⟭|⟬fr_driving_licence#23⟭|⟬iban#23⟭|26,2|Famille|⟬email#23⟭|⟬age#23⟭
76450|⟬person_name#24⟭|⟬fr_social_security_number#24⟭|⟬birth_date#24⟭|⟬fr_tax_number#24⟭|⟬fr_driving_licence#24⟭|⟬iban#24⟭|19,0|Famille|⟬email#24⟭|⟬age#24⟭
64188|⟬person_name#25⟭|⟬fr_social_security_number#25⟭|⟬birth_date#25⟭|⟬fr_tax_number#25⟭|⟬fr_driving_licence#25⟭|⟬iban#25⟭|0,5|Duo|⟬email#25⟭|⟬age#25⟭
12196|⟬person_name#26⟭|⟬fr_social_security_number#26⟭|⟬birth_date#26⟭|⟬fr_tax_number#26⟭||⟬iban#26⟭|1,7|Isolé|⟬email#26⟭|⟬age#26⟭
63697|⟬person_name#27⟭|⟬fr_social_security_number#27⟭|⟬birth_date#27⟭|⟬fr_tax_number#27⟭||⟬iban#27⟭|8,1|Famille|⟬email#27⟭|⟬age#27⟭
44231|⟬person_name#28⟭|⟬fr_social_security_number#28⟭|⟬birth_date#28⟭|⟬fr_tax_number#28⟭||⟬iban#28⟭|37,9|Duo|⟬email#28⟭|⟬age#28⟭
24003|⟬person_name#29⟭|⟬fr_social_security_number#29⟭|⟬birth_date#29⟭|⟬fr_tax_number#29⟭||⟬iban#29⟭|15,7|Isolé|⟬email#29⟭|⟬age#29⟭
41381|⟬person_name#30⟭|⟬fr_social_security_number#30⟭|⟬birth_date#30⟭|⟬fr_tax_number#30⟭|⟬fr_driving_licence#30⟭|⟬iban#30⟭|1,7|Famille|⟬email#30⟭|⟬age#30⟭
44392|⟬person_name#31⟭|⟬fr_social_security_number#31⟭|⟬birth_date#31⟭|⟬fr_tax_number#31⟭|⟬fr_driving_licence#31⟭|⟬iban#31⟭|5,2|Isolé|⟬email#31⟭|⟬age#31⟭
83140|⟬person_name#32⟭|⟬fr_social_security_number#32⟭|⟬birth_date#32⟭|⟬fr_tax_number#32⟭||⟬iban#32⟭|20,6|Isolé|⟬email#32⟭|⟬age#32⟭
73153|⟬person_name#33⟭|⟬fr_social_security_number#33⟭|⟬birth_date#33⟭|⟬fr_tax_number#33⟭||⟬iban#33⟭|29,8|Duo|⟬email#33⟭|⟬age#33⟭
10413|⟬person_name#34⟭|⟬fr_social_security_number#34⟭|⟬birth_date#34⟭|⟬fr_tax_number#34⟭||⟬iban#34⟭|11,5|Isolé|⟬email#34⟭|⟬age#34⟭
15350|⟬person_name#35⟭|⟬fr_social_security_number#35⟭|⟬birth_date#35⟭|⟬fr_tax_number#35⟭|⟬fr_driving_licence#35⟭|⟬iban#35⟭|43,1|Isolé|⟬email#35⟭|⟬age#35⟭
49386|⟬person_name#36⟭|⟬fr_social_security_number#36⟭|⟬birth_date#36⟭|⟬fr_tax_number#36⟭|⟬fr_driving_licence#36⟭|⟬iban#36⟭|35,9|Famille|⟬email#36⟭|⟬age#36⟭
30184|⟬person_name#37⟭|⟬fr_social_security_number#37⟭|⟬birth_date#37⟭|⟬fr_tax_number#37⟭||⟬iban#37⟭|26,4|Duo|⟬email#37⟭|⟬age#37⟭
80905|⟬person_name#38⟭|⟬fr_social_security_number#38⟭|⟬birth_date#38⟭|⟬fr_tax_number#38⟭|⟬fr_driving_licence#38⟭|⟬iban#38⟭|23,1|Duo|⟬email#38⟭|⟬age#38⟭
96783|⟬person_name#39⟭|⟬fr_social_security_number#39⟭|⟬birth_date#39⟭|⟬fr_tax_number#39⟭||⟬iban#39⟭|43,4|Duo|⟬email#39⟭|⟬age#39⟭
49031|⟬person_name#40⟭|⟬fr_social_security_number#40⟭|⟬birth_date#40⟭|⟬fr_tax_number#40⟭||⟬iban#40⟭|7,5|Famille|⟬email#40⟭|⟬age#40⟭
13228|⟬person_name#41⟭|⟬fr_social_security_number#41⟭|⟬birth_date#41⟭|⟬fr_tax_number#41⟭|⟬fr_driving_licence#41⟭|⟬iban#41⟭|23,3|Isolé|⟬email#41⟭|⟬age#41⟭
74043|⟬person_name#42⟭|⟬fr_social_security_number#42⟭|⟬birth_date#42⟭|⟬fr_tax_number#42⟭||⟬iban#42⟭|16,2|Famille|⟬email#42⟭|⟬age#42⟭
82455|⟬person_name#43⟭|⟬fr_social_security_number#43⟭|⟬birth_date#43⟭|⟬fr_tax_number#43⟭|⟬fr_driving_licence#43⟭|⟬iban#43⟭|6,9|Famille|⟬email#43⟭|⟬age#43⟭
63237|⟬person_name#44⟭|⟬fr_social_security_number#44⟭|⟬birth_date#44⟭|⟬fr_tax_number#44⟭||⟬iban#44⟭|34,2|Famille|⟬email#44⟭|⟬age#44⟭
44991|⟬person_name#45⟭|⟬fr_social_security_number#45⟭|⟬birth_date#45⟭|⟬fr_tax_number#45⟭|⟬fr_driving_licence#45⟭|⟬iban#45⟭|5,7|Isolé|⟬email#45⟭|⟬age#45⟭
90585|⟬person_name#46⟭|⟬fr_social_security_number#46⟭|⟬birth_date#46⟭|⟬fr_tax_number#46⟭|⟬fr_driving_licence#46⟭|⟬iban#46⟭|15,1|Isolé|⟬email#46⟭|⟬age#46⟭
72037|⟬person_name#47⟭|⟬fr_social_security_number#47⟭|⟬birth_date#47⟭|⟬fr_tax_number#47⟭|⟬fr_driving_licence#47⟭|⟬iban#47⟭|18,2|Isolé|⟬email#47⟭|⟬age#47⟭
99270|⟬person_name#48⟭|⟬fr_social_security_number#48⟭|⟬birth_date#48⟭|⟬fr_tax_number#48⟭|⟬fr_driving_licence#48⟭|⟬iban#48⟭|8,3|Famille|⟬email#48⟭|⟬age#48⟭
60459|⟬person_name#49⟭|⟬fr_social_security_number#49⟭|⟬birth_date#49⟭|⟬fr_tax_number#49⟭||⟬iban#49⟭|19,9|Famille|⟬email#49⟭|⟬age#49⟭
22497|⟬person_name#50⟭|⟬fr_social_security_number#50⟭|⟬birth_date#50⟭|⟬fr_tax_number#50⟭|⟬fr_driving_licence#50⟭|⟬iban#50⟭|28,6|Duo|⟬email#50⟭|⟬age#50⟭
38630|⟬person_name#51⟭|⟬fr_social_security_number#51⟭|⟬birth_date#51⟭|⟬fr_tax_number#51⟭||⟬iban#51⟭|14,5|Famille|⟬email#51⟭|⟬age#51⟭
86979|⟬person_name#52⟭|⟬fr_social_security_number#52⟭|⟬birth_date#52⟭|⟬fr_tax_number#52⟭|⟬fr_driving_licence#52⟭|⟬iban#52⟭|24,5|Duo|⟬email#52⟭|⟬age#52⟭
69689|⟬person_name#53⟭|⟬fr_social_security_number#53⟭|⟬birth_date#53⟭|⟬fr_tax_number#53⟭||⟬iban#53⟭|4,8|Isolé|⟬email#53⟭|⟬age#53⟭
67017|⟬person_name#54⟭|⟬fr_social_security_number#54⟭|⟬birth_date#54⟭|⟬fr_tax_number#54⟭|⟬fr_driving_licence#54⟭|⟬iban#54⟭|39,9|Famille|⟬email#54⟭|⟬age#54⟭
80692|⟬person_name#55⟭|⟬fr_social_security_number#55⟭|⟬birth_date#55⟭|⟬fr_tax_number#55⟭||⟬iban#55⟭|8,2|Famille|⟬email#55⟭|⟬age#55⟭
65187|⟬person_name#56⟭|⟬fr_social_security_number#56⟭|⟬birth_date#56⟭|⟬fr_tax_number#56⟭|⟬fr_driving_licence#56⟭|⟬iban#56⟭|10,1|Isolé|⟬email#56⟭|⟬age#56⟭
69080|⟬person_name#57⟭|⟬fr_social_security_number#57⟭|⟬birth_date#57⟭|⟬fr_tax_number#57⟭||⟬iban#57⟭|42,4|Duo|⟬email#57⟭|⟬age#57⟭
40641|⟬person_name#58⟭|⟬fr_social_security_number#58⟭|⟬birth_date#58⟭|⟬fr_tax_number#58⟭||⟬iban#58⟭|27,0|Isolé|⟬email#58⟭|⟬age#58⟭
84781|⟬person_name#59⟭|⟬fr_social_security_number#59⟭|⟬birth_date#59⟭|⟬fr_tax_number#59⟭||⟬iban#59⟭|31,0|Famille|⟬email#59⟭|⟬age#59⟭
52527|⟬person_name#60⟭|⟬fr_social_security_number#60⟭|⟬birth_date#60⟭|⟬fr_tax_number#60⟭|⟬fr_driving_licence#60⟭|⟬iban#60⟭|13,6|Isolé|⟬email#60⟭|⟬age#60⟭
30912|⟬person_name#61⟭|⟬fr_social_security_number#61⟭|⟬birth_date#61⟭|⟬fr_tax_number#61⟭|⟬fr_driving_licence#61⟭|⟬iban#61⟭|0,4|Famille|⟬email#61⟭|⟬age#61⟭
96009|⟬person_name#62⟭|⟬fr_social_security_number#62⟭|⟬birth_date#62⟭|⟬fr_tax_number#62⟭||⟬iban#62⟭|16,8|Duo|⟬email#62⟭|⟬age#62⟭
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: education
appearance: TSV cell, guardians, tax number, family quotient, bank account, initials as visa
scenario: canteen reductions decided by a town's education department, exported for the finance office, guardians only
⟬text⟭
responsable	num_fiscal	quotient	compte	bic	remise	visa
⟬person_name#1⟭	⟬fr_tax_number#1⟭	720	⟬bank_account_number#1⟭	⟬bic#1⟭	10 %	⟬trap:initials|AL⟭
⟬person_name#2⟭	⟬fr_tax_number#2⟭	1368	⟬bank_account_number#2⟭	⟬bic#2⟭	40 %	⟬trap:initials|AL⟭
⟬person_name#3⟭	⟬fr_tax_number#3⟭	1216	⟬bank_account_number#3⟭	⟬bic#3⟭	25 %	⟬trap:initials|MTR⟭
⟬person_name#4⟭	⟬fr_tax_number#4⟭	1758	⟬bank_account_number#4⟭	⟬bic#4⟭	10 %	⟬trap:initials|MTR⟭
⟬person_name#5⟭	⟬fr_tax_number#5⟭	1069	⟬bank_account_number#5⟭	⟬bic#5⟭	40 %	⟬trap:initials|MTR⟭
⟬person_name#6⟭	⟬fr_tax_number#6⟭	1692	⟬bank_account_number#6⟭	⟬bic#6⟭	25 %	⟬trap:initials|MTR⟭
⟬person_name#7⟭	⟬fr_tax_number#7⟭	1631	⟬bank_account_number#7⟭	⟬bic#7⟭	40 %	⟬trap:initials|MTR⟭
⟬person_name#8⟭	⟬fr_tax_number#8⟭	459	⟬bank_account_number#8⟭	⟬bic#8⟭	40 %	⟬trap:initials|MTR⟭
⟬person_name#9⟭	⟬fr_tax_number#9⟭	1008	⟬bank_account_number#9⟭	⟬bic#9⟭	40 %	⟬trap:initials|AL⟭
⟬person_name#10⟭	⟬fr_tax_number#10⟭	1741	⟬bank_account_number#10⟭	⟬bic#10⟭	25 %	⟬trap:initials|AL⟭
⟬person_name#11⟭	⟬fr_tax_number#11⟭	1736	⟬bank_account_number#11⟭	⟬bic#11⟭	40 %	⟬trap:initials|MTR⟭
⟬person_name#12⟭	⟬fr_tax_number#12⟭	1246	⟬bank_account_number#12⟭	⟬bic#12⟭	40 %	⟬trap:initials|AL⟭
⟬person_name#13⟭	⟬fr_tax_number#13⟭	1341	⟬bank_account_number#13⟭	⟬bic#13⟭	25 %	⟬trap:initials|MTR⟭
⟬person_name#14⟭	⟬fr_tax_number#14⟭	531	⟬bank_account_number#14⟭	⟬bic#14⟭	40 %	⟬trap:initials|AL⟭
⟬person_name#15⟭	⟬fr_tax_number#15⟭	986	⟬bank_account_number#15⟭	⟬bic#15⟭	10 %	⟬trap:initials|AL⟭
⟬person_name#16⟭	⟬fr_tax_number#16⟭	1703	⟬bank_account_number#16⟭	⟬bic#16⟭	25 %	⟬trap:initials|MTR⟭
⟬person_name#17⟭	⟬fr_tax_number#17⟭	726	⟬bank_account_number#17⟭	⟬bic#17⟭	10 %	⟬trap:initials|MTR⟭
⟬person_name#18⟭	⟬fr_tax_number#18⟭	1063	⟬bank_account_number#18⟭	⟬bic#18⟭	40 %	⟬trap:initials|MTR⟭
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: INSERT with column list, narcotics register, NIR, identity card or driving licence, function named after a person
scenario: narcotics register of a pharmacy dumped by its software vendor during a support call
⟬text⟭
-- registre des stupéfiants, officine 0412
CREATE TABLE registre_stup (
    id integer PRIMARY KEY,
    delivre_le date NOT NULL,
    produit text NOT NULL,
    patient_nir text,
    retire_par text,
    piece_retrait text,
    ordonnance text
);

INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2201, '⟬date#5⟭', 'Méthadone 40 mg', '⟬fr_social_security_number#1⟭', '⟬person_name#1⟭', '⟬fr_identity_card#1⟭', 'ORD72247');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2202, '⟬date#5⟭', 'Méthadone 40 mg', '⟬fr_social_security_number#2⟭', '⟬person_name#2⟭', '⟬fr_driving_licence#2⟭', 'ORD10026');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2203, '⟬date#5⟭', 'Fentanyl 25 µg', '⟬fr_social_security_number#3⟭', '⟬person_name#3⟭', '⟬fr_identity_card#3⟭', 'ORD23951');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2204, '⟬date#7⟭', 'Fentanyl 25 µg', '⟬fr_social_security_number#4⟭', '⟬person_name#4⟭', '⟬fr_identity_card#4⟭', 'ORD89663');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2205, '⟬date#1⟭', 'Morphine 30 mg', '⟬fr_social_security_number#5⟭', '⟬person_name#5⟭', '⟬fr_identity_card#5⟭', 'ORD96046');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2206, '⟬date#6⟭', 'Morphine 30 mg', '⟬fr_social_security_number#6⟭', '⟬person_name#6⟭', '⟬fr_driving_licence#6⟭', 'ORD35741');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2207, '⟬date#5⟭', 'Morphine 30 mg', '⟬fr_social_security_number#7⟭', '⟬person_name#7⟭', '⟬fr_driving_licence#7⟭', 'ORD34185');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2208, '⟬date#5⟭', 'Méthadone 40 mg', '⟬fr_social_security_number#8⟭', '⟬person_name#8⟭', '⟬fr_identity_card#8⟭', 'ORD33396');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2209, '⟬date#3⟭', 'Méthadone 40 mg', '⟬fr_social_security_number#9⟭', '⟬person_name#9⟭', '⟬fr_driving_licence#9⟭', 'ORD58161');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2210, '⟬date#5⟭', 'Fentanyl 25 µg', '⟬fr_social_security_number#10⟭', '⟬person_name#10⟭', '⟬fr_identity_card#10⟭', 'ORD46673');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2211, '⟬date#5⟭', 'Méthadone 40 mg', '⟬fr_social_security_number#11⟭', '⟬person_name#11⟭', '⟬fr_identity_card#11⟭', 'ORD83853');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2212, '⟬date#2⟭', 'Oxycodone 10 mg', '⟬fr_social_security_number#12⟭', '⟬person_name#12⟭', '⟬fr_driving_licence#12⟭', 'ORD46536');
INSERT INTO registre_stup (id, delivre_le, produit, patient_nir, retire_par, piece_retrait, ordonnance) VALUES (2213, '⟬date#5⟭', 'Oxycodone 10 mg', '⟬fr_social_security_number#13⟭', '⟬person_name#13⟭', '⟬fr_identity_card#13⟭', 'ORD54132');

CREATE FUNCTION ⟬trap:code_identifier|solde_⦃family⦄⟭() RETURNS integer LANGUAGE sql AS 'SELECT 0';
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: real estate
appearance: pasted cells, months as columns, street cell, bank account, totals
scenario: rent collection pivot of a small property company, pasted from a yearly workbook with one column per month
⟬text⟭
Encaissements loyers - tous immeubles
Gérant :	⟬person_name#90m⟭	Société :	⟬company#90⟭

Locataire	Adresse	Compte	Jan	Fév	Mar	Avr	Mai	Juin	Juil	Août	Sep	Oct	Nov	Déc
⟬person_name#1⟭	⟬fr_postal_address:street#1⟭	⟬bank_account_number#1⟭	906	906	906	906	906	906	906	906	0	906	0	906
⟬person_name#2⟭	⟬fr_postal_address:street#2⟭	⟬bank_account_number#2⟭	907	907	907	907	907	907	907	907	907	907	907	907
⟬person_name#3⟭	⟬fr_postal_address:street#3⟭	⟬bank_account_number#3⟭	546	0	546	0	546	546	546	546	546	546	546	546
⟬person_name#4⟭	⟬fr_postal_address:street#4⟭	⟬bank_account_number#4⟭	0	727	0	0	0	727	727	727	727	727	0	727
⟬person_name#5⟭	⟬fr_postal_address:street#5⟭	⟬bank_account_number#5⟭	797	797	797	797	0	797	797	797	0	797	797	797
⟬person_name#6⟭	⟬fr_postal_address:street#6⟭	⟬bank_account_number#6⟭	1018	1018	1018	1018	1018	1018	1018	1018	1018	0	1018	1018
⟬person_name#7⟭	⟬fr_postal_address:street#7⟭	⟬bank_account_number#7⟭	619	619	619	619	619	619	619	619	619	619	619	619
⟬person_name#8⟭	⟬fr_postal_address:street#8⟭	⟬bank_account_number#8⟭	912	912	912	912	912	912	912	912	912	912	912	912
⟬person_name#9⟭	⟬fr_postal_address:street#9⟭	⟬bank_account_number#9⟭	1350	1350	1350	0	1350	1350	1350	1350	1350	1350	1350	1350
⟬person_name#10⟭	⟬fr_postal_address:street#10⟭	⟬bank_account_number#10⟭	560	560	560	560	560	560	560	560	560	0	560	560
⟬person_name#11⟭	⟬fr_postal_address:street#11⟭	⟬bank_account_number#11⟭	643	643	643	643	643	0	643	643	643	643	643	643
⟬person_name#12⟭	⟬fr_postal_address:street#12⟭	⟬bank_account_number#12⟭	522	522	522	522	522	522	522	522	522	522	522	522
⟬person_name#13⟭	⟬fr_postal_address:street#13⟭	⟬bank_account_number#13⟭	814	814	814	814	814	814	814	814	814	814	814	814
⟬person_name#14⟭	⟬fr_postal_address:street#14⟭	⟬bank_account_number#14⟭	654	654	654	654	654	0	654	654	654	0	654	654
⟬person_name#15⟭	⟬fr_postal_address:street#15⟭	⟬bank_account_number#15⟭	1284	0	1284	1284	1284	1284	1284	1284	1284	1284	0	1284
⟬person_name#16⟭	⟬fr_postal_address:street#16⟭	⟬bank_account_number#16⟭	0	1028	1028	1028	1028	1028	1028	1028	1028	1028	1028	1028
⟬person_name#17⟭	⟬fr_postal_address:street#17⟭	⟬bank_account_number#17⟭	1070	1070	1070	0	1070	1070	1070	1070	1070	0	1070	1070
⟬person_name#18⟭	⟬fr_postal_address:street#18⟭	⟬bank_account_number#18⟭	1183	0	0	0	0	0	1183	1183	1183	1183	1183	1183
⟬person_name#19⟭	⟬fr_postal_address:street#19⟭	⟬bank_account_number#19⟭	1293	1293	1293	1293	1293	1293	0	0	0	1293	1293	1293
⟬person_name#20⟭	⟬fr_postal_address:street#20⟭	⟬bank_account_number#20⟭	922	922	922	922	922	922	0	0	0	922	922	922
⟬person_name#21⟭	⟬fr_postal_address:street#21⟭	⟬bank_account_number#21⟭	0	1178	0	1178	1178	1178	1178	1178	1178	1178	1178	1178
⟬person_name#22⟭	⟬fr_postal_address:street#22⟭	⟬bank_account_number#22⟭	0	642	642	642	642	642	642	642	642	642	642	642
⟬person_name#23⟭	⟬fr_postal_address:street#23⟭	⟬bank_account_number#23⟭	1058	1058	1058	1058	1058	1058	1058	1058	1058	1058	0	1058
⟬person_name#24⟭	⟬fr_postal_address:street#24⟭	⟬bank_account_number#24⟭	1061	1061	1061	1061	1061	0	1061	1061	1061	1061	1061	1061
⟬person_name#25⟭	⟬fr_postal_address:street#25⟭	⟬bank_account_number#25⟭	1294	1294	1294	1294	0	1294	1294	1294	1294	1294	1294	1294
⟬person_name#26⟭	⟬fr_postal_address:street#26⟭	⟬bank_account_number#26⟭	1262	1262	1262	1262	0	1262	1262	1262	1262	1262	1262	1262
Sous-total immeuble 1														
⟬person_name#27⟭	⟬fr_postal_address:street#27⟭	⟬bank_account_number#27⟭	775	775	775	775	775	775	775	0	775	775	775	775
⟬person_name#28⟭	⟬fr_postal_address:street#28⟭	⟬bank_account_number#28⟭	1144	1144	1144	0	1144	1144	1144	1144	1144	1144	0	0
⟬person_name#29⟭	⟬fr_postal_address:street#29⟭	⟬bank_account_number#29⟭	636	636	636	636	636	636	636	636	636	636	0	636
⟬person_name#30⟭	⟬fr_postal_address:street#30⟭	⟬bank_account_number#30⟭	996	996	996	996	996	996	996	996	996	996	996	996
⟬person_name#31⟭	⟬fr_postal_address:street#31⟭	⟬bank_account_number#31⟭	531	0	531	531	531	531	531	531	531	531	531	531
⟬person_name#32⟭	⟬fr_postal_address:street#32⟭	⟬bank_account_number#32⟭	1004	1004	1004	1004	1004	1004	1004	1004	1004	1004	1004	0
⟬person_name#33⟭	⟬fr_postal_address:street#33⟭	⟬bank_account_number#33⟭	870	870	870	870	870	0	870	870	870	870	870	870
⟬person_name#34⟭	⟬fr_postal_address:street#34⟭	⟬bank_account_number#34⟭	640	640	0	640	640	640	640	640	0	640	640	640
⟬person_name#35⟭	⟬fr_postal_address:street#35⟭	⟬bank_account_number#35⟭	534	534	534	534	534	0	534	534	534	534	534	534
⟬person_name#36⟭	⟬fr_postal_address:street#36⟭	⟬bank_account_number#36⟭	1064	1064	1064	1064	1064	1064	1064	1064	0	1064	1064	1064
⟬person_name#37⟭	⟬fr_postal_address:street#37⟭	⟬bank_account_number#37⟭	1148	1148	1148	1148	1148	0	1148	1148	1148	1148	1148	1148
⟬person_name#38⟭	⟬fr_postal_address:street#38⟭	⟬bank_account_number#38⟭	1310	1310	0	1310	1310	1310	1310	1310	0	1310	1310	1310
⟬person_name#39⟭	⟬fr_postal_address:street#39⟭	⟬bank_account_number#39⟭	808	0	808	808	808	0	808	808	0	808	0	808
⟬person_name#40⟭	⟬fr_postal_address:street#40⟭	⟬bank_account_number#40⟭	683	683	683	683	683	683	0	683	683	683	683	683
⟬person_name#41⟭	⟬fr_postal_address:street#41⟭	⟬bank_account_number#41⟭	0	929	929	929	929	929	929	929	929	929	0	929
⟬person_name#42⟭	⟬fr_postal_address:street#42⟭	⟬bank_account_number#42⟭	733	733	733	733	733	733	733	733	733	733	0	733
⟬person_name#43⟭	⟬fr_postal_address:street#43⟭	⟬bank_account_number#43⟭	1144	1144	1144	1144	1144	1144	1144	1144	1144	1144	1144	1144
⟬person_name#44⟭	⟬fr_postal_address:street#44⟭	⟬bank_account_number#44⟭	903	903	903	903	903	903	903	903	903	903	903	903
⟬person_name#45⟭	⟬fr_postal_address:street#45⟭	⟬bank_account_number#45⟭	535	535	535	535	535	535	535	535	535	0	535	535
⟬person_name#46⟭	⟬fr_postal_address:street#46⟭	⟬bank_account_number#46⟭	543	543	543	543	543	543	543	543	543	0	0	543
⟬person_name#47⟭	⟬fr_postal_address:street#47⟭	⟬bank_account_number#47⟭	1089	1089	1089	1089	1089	1089	1089	1089	1089	1089	1089	1089
⟬person_name#48⟭	⟬fr_postal_address:street#48⟭	⟬bank_account_number#48⟭	874	874	874	874	0	874	874	874	874	874	874	874
⟬person_name#49⟭	⟬fr_postal_address:street#49⟭	⟬bank_account_number#49⟭	1326	1326	1326	1326	1326	1326	1326	1326	1326	1326	0	1326
⟬person_name#50⟭	⟬fr_postal_address:street#50⟭	⟬bank_account_number#50⟭	1219	1219	1219	1219	1219	1219	1219	1219	1219	1219	1219	1219
⟬person_name#51⟭	⟬fr_postal_address:street#51⟭	⟬bank_account_number#51⟭	794	794	794	794	794	794	794	794	794	794	794	794
⟬person_name#52⟭	⟬fr_postal_address:street#52⟭	⟬bank_account_number#52⟭	781	781	781	781	781	781	781	781	781	781	781	781
Sous-total immeuble 2														
⟬person_name#53⟭	⟬fr_postal_address:street#53⟭	⟬bank_account_number#53⟭	873	873	873	873	873	0	873	873	0	873	873	873
⟬person_name#54⟭	⟬fr_postal_address:street#54⟭	⟬bank_account_number#54⟭	626	626	626	626	626	626	626	626	626	626	626	626
⟬person_name#55⟭	⟬fr_postal_address:street#55⟭	⟬bank_account_number#55⟭	648	648	648	648	648	648	648	648	648	0	648	648
⟬person_name#56⟭	⟬fr_postal_address:street#56⟭	⟬bank_account_number#56⟭	1226	1226	1226	1226	1226	1226	1226	1226	1226	1226	0	1226
⟬person_name#57⟭	⟬fr_postal_address:street#57⟭	⟬bank_account_number#57⟭	0	802	802	802	802	802	802	0	802	802	802	802
⟬person_name#58⟭	⟬fr_postal_address:street#58⟭	⟬bank_account_number#58⟭	505	505	505	505	505	505	505	0	505	505	505	505
Total général														
Impayés à relancer en priorité
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: associations
appearance: Markdown table, board members, birth date beside an election date, address cell, profession, SIREN
scenario: list of directors prepared by an association's secretary for the prefecture, in a shared note
⟬text⟭
# Liste des dirigeants à déclarer

Association ⟬company#30⟭, SIREN ⟬fr_siren#30⟭, siège ⟬fr_postal_address#30⟭.

| Fonction | Nom | Né(e) le | Domicile | Profession | Élu(e) le |
| --- | --- | --- | --- | --- | --- |
| Présidence | ⟬person_name#1⟭ | ⟬birth_date#1⟭ | ⟬fr_postal_address#1⟭ | ⟬job_title#1⟭ | ⟬date#1⟭ |
| Trésorerie | ⟬person_name#2⟭ | ⟬birth_date#2⟭ | ⟬fr_postal_address#2⟭ | ⟬job_title#2⟭ | ⟬date#1⟭ |
| Membre | ⟬person_name#3⟭ | ⟬birth_date#3⟭ | ⟬fr_postal_address#3⟭ | ⟬job_title#3⟭ | ⟬date#5⟭ |
| Vice-présidence | ⟬person_name#4⟭ | ⟬birth_date#4⟭ | ⟬fr_postal_address#4⟭ | ⟬job_title#4⟭ | ⟬date#6⟭ |
| Vice-présidence | ⟬person_name#5⟭ | ⟬birth_date#5⟭ | ⟬fr_postal_address#5⟭ | ⟬job_title#5⟭ | ⟬date#1⟭ |
| Vice-présidence | ⟬person_name#6⟭ | ⟬birth_date#6⟭ | ⟬fr_postal_address#6⟭ | ⟬job_title#6⟭ | ⟬date#5⟭ |
| Membre | ⟬person_name#7⟭ | ⟬birth_date#7⟭ | ⟬fr_postal_address#7⟭ | ⟬job_title#7⟭ | ⟬date#4⟭ |
| Secrétariat adjoint | ⟬person_name#8⟭ | ⟬birth_date#8⟭ | ⟬fr_postal_address#8⟭ | ⟬job_title#8⟭ | ⟬date#2⟭ |
| Membre | ⟬person_name#9⟭ | ⟬birth_date#9⟭ | ⟬fr_postal_address#9⟭ | ⟬job_title#9⟭ | ⟬date#1⟭ |
| Membre | ⟬person_name#10⟭ | ⟬birth_date#10⟭ | ⟬fr_postal_address#10⟭ | ⟬job_title#10⟭ | ⟬date#3⟭ |

Récépissé à classer dans le dossier statuts.
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: public administration
appearance: fixed columns, budget lines, signing officer label with no person
scenario: budget execution listing of a town, printed by the finance software, with accounts and amounts only
⟬text⟭
BUDGET PRINCIPAL - EXECUTION PAR ARTICLE                 EDITION DU ⟬date#1⟭
ORDONNATEUR : ⟬trap:indicator_non_pii|LE MAIRE⟭
COMPTABLE   : ⟬trap:indicator_non_pii|TRESORERIE MUNICIPALE⟭

ARTICLE  FN  LIBELLE         CREDITS   MANDATES  TX
-------  --  ------------  ---------  ---------  -----
66873  1  Maintenance      458416     782771   72 %
75505  2  Dotations         43570     286601   16 %
011912  8  Études           191600     618707   25 %
011439  7  Maintenance      867906     255837   79 %
011432  1  Énergie          597047     108700   56 %
67130  7  Études           704796      14596  116 %
65404  9  Dotations         58684      35616   54 %
70762  4  Études           453286      28379    4 %
66911  2  Primes           185792     328732   76 %
74159  8  Maintenance      218860     320256   90 %
66254  2  Primes           427317     156816   24 %
65938  8  Impôts locau      98160     589103   76 %
011114  9  Fournitures      851826     725739   97 %
73720  6  Entretien        367981     194137   60 %
67171  5  Primes           394129     633068   51 %
012232  9  Primes           533968      22247  114 %
012400  8  Primes           769453     369829   46 %
77324  6  Entretien        478725      95283   91 %
73650  1  Dotations        647531      42773   61 %
70595  2  Impôts locau     781020     121517   17 %
011486  2  Impôts locau     672368     329830  102 %
75174  8  Énergie           63796     215165    5 %
011145  9  Fournitures      128899     526264    9 %
67269  2  Primes           433780     406919   97 %
74316  1  Entretien        165972     771959   57 %
75393  4  Maintenance      284717     587082   73 %
011849  8  Primes           593048     104271   29 %
74862  8  Études           838042     178333   90 %
67784  8  Études           454018     580336    4 %
70692  6  Études            58585     643255   89 %
70801  4  Entretien          4311     792879   35 %
73834  5  Entretien        504682     567557   83 %
012144  4  Études            70682     647831   50 %
66737  7  Études           478093     369316   96 %
66867  1  Études           737039      57493   53 %
012738  3  Primes           240577     256745  116 %
65803  5  Impôts locau     288207     271102   53 %
75543  5  Primes           287911     559027   53 %
011945  6  Énergie          137189     374066   60 %
70607  4  Énergie          414672     867598   95 %
74233  4  Primes           592389       5462   47 %
66835  1  Primes           495384     749705   24 %
74191  9  Études           464855      41329   62 %
74154  3  Primes           869226     168881   86 %
012323  4  Maintenance      423823     860797   65 %
011713  9  Énergie          432373     246707   90 %
75238  7  Énergie          117269     791024   42 %
011231  6  Dotations        397067     729829   61 %
77438  1  Fournitures      761536     359298    3 %
75507  7  Dotations        451467     148680   32 %
77611  8  Impôts locau     731515     273577   77 %
66382  5  Entretien        573411     806121   20 %
011970  2  Impôts locau      90729     115534   50 %
77998  9  Fournitures      581631     862275   99 %
75451  1  Fournitures      106536     678020   50 %
75898  7  Dotations        410649     672309   20 %
-------  --  ------------  ---------  ---------  -----
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: education
appearance: semicolon CSV, snow trip payments, guardian IBAN
scenario: instalments for a snow trip tracked by a primary school's parent association
⟬text⟭
responsable;iban;acompte;solde;paye_le
⟬person_name#1⟭;⟬iban#1⟭;120;80;⟬date#1⟭
⟬person_name#2⟭;⟬iban#2⟭;120;80;⟬date#2⟭
⟬person_name#3⟭;⟬iban#3⟭;200;0;⟬date#2⟭
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: headerless TSV, passport with no announcing word
scenario: headerless list of foreign patients billed directly, copied by a hospital cashier
⟬text⟭
⟬fr_passport#1⟭	⟬person_name#1⟭	⟬date#1⟭	412,00	Caisse
⟬fr_passport#2⟭	⟬person_name#2⟭	⟬date#2⟭	1 380,50	Assurance
⟬fr_passport#3⟭	⟬person_name#3⟭	⟬date#2⟭	96,00	Caisse
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: real estate
appearance: DDL, comments on name columns, foreign server with a placeholder password, view named after a person
scenario: schema of a building inventory database with no rows, where column comments mention owners without naming any
⟬text⟭
-- Schéma du patrimoine, sans données
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER cadastre FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'cadastre.interne', dbname 'cadastre');
CREATE USER MAPPING FOR app_patrimoine SERVER cadastre OPTIONS (user 'lecture', password '⟬trap:placeholder|${CADASTRE_PASSWORD}⟭');

CREATE TABLE immeuble (
    id integer PRIMARY KEY,
    nom varchar(80),
    annee_construction smallint,
    nb_lots smallint,
    dpe char(1)
);

CREATE TABLE proprietaire (
    id integer PRIMARY KEY,
    nom varchar(120),
    prenom varchar(80),
    iban varchar(34)
);

COMMENT ON COLUMN proprietaire.nom IS 'Nom ou raison sociale du propriétaire';
COMMENT ON COLUMN proprietaire.iban IS 'Compte de versement des loyers';

CREATE VIEW ⟬trap:code_identifier|v_⦃family⦄_lots⟭ AS
    SELECT i.id, i.nb_lots, i.dpe FROM immeuble i WHERE i.dpe IN ('F', 'G');

GRANT SELECT ON immeuble TO ⟬trap:indicator_non_pii|lecture_seule⟭;
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: associations
appearance: pasted cells, tax receipts, anonymous donors, tax number, address cell
scenario: donations sheet of a local charity, pasted by a volunteer to prepare the yearly tax receipts
⟬text⟭
Dons de l'exercice - base des reçus fiscaux
N° reçu	Donateur	Identifiant fiscal	Adresse	Montant	Moyen	Reçu le
8539	⟬trap:indicator_non_pii|Anonyme⟭			315	Virement	⟬date#4⟭
8573	⟬trap:indicator_non_pii|Anonyme⟭			533	Chèque	⟬date#7⟭
4704	⟬person_name#3⟭	⟬fr_tax_number#3⟭	⟬fr_postal_address#3⟭	99	Chèque	⟬date#5⟭
4819	⟬trap:indicator_non_pii|Anonyme⟭			455	Virement	⟬date#3⟭
4897	⟬person_name#5⟭	⟬fr_tax_number#5⟭	⟬fr_postal_address#5⟭	726	CB	⟬date#3⟭
2522	⟬trap:indicator_non_pii|Anonyme⟭			351	Chèque	⟬date#5⟭
9341	⟬person_name#7⟭	⟬fr_tax_number#7⟭	⟬fr_postal_address#7⟭	678	Virement	⟬date#5⟭
3150	⟬person_name#8⟭	⟬fr_tax_number#8⟭	⟬fr_postal_address#8⟭	386	Chèque	⟬date#5⟭
2900	⟬person_name#9⟭	⟬fr_tax_number#9⟭	⟬fr_postal_address#9⟭	587	Chèque	⟬date#4⟭
3171	⟬person_name#10⟭	⟬fr_tax_number#10⟭	⟬fr_postal_address#10⟭	372	Virement	⟬date#6⟭
5130	⟬person_name#11⟭	⟬fr_tax_number#11⟭	⟬fr_postal_address#11⟭	21	Chèque	⟬date#6⟭
2653	⟬person_name#12⟭	⟬fr_tax_number#12⟭	⟬fr_postal_address#12⟭	449	CB	⟬date#1⟭
2730	⟬person_name#13⟭	⟬fr_tax_number#13⟭	⟬fr_postal_address#13⟭	756	CB	⟬date#3⟭
8682	⟬trap:indicator_non_pii|Anonyme⟭			671	CB	⟬date#3⟭
4694	⟬trap:indicator_non_pii|Anonyme⟭			212	CB	⟬date#5⟭
4309	⟬person_name#16⟭	⟬fr_tax_number#16⟭	⟬fr_postal_address#16⟭	541	Chèque	⟬date#5⟭
1242	⟬person_name#17⟭	⟬fr_tax_number#17⟭	⟬fr_postal_address#17⟭	295	CB	⟬date#2⟭
5723	⟬trap:indicator_non_pii|Anonyme⟭			213	Virement	⟬date#4⟭
2863	⟬trap:indicator_non_pii|Anonyme⟭			280	Virement	⟬date#7⟭
9790	⟬person_name#20⟭	⟬fr_tax_number#20⟭	⟬fr_postal_address#20⟭	534	Chèque	⟬date#3⟭
5804	⟬person_name#21⟭	⟬fr_tax_number#21⟭	⟬fr_postal_address#21⟭	545	Chèque	⟬date#3⟭
5809	⟬trap:indicator_non_pii|Anonyme⟭			78	CB	⟬date#4⟭
Les dons anonymes ne donnent pas lieu à reçu
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Markdown table, service providers, SIREN, contact mixing a person and a department
scenario: providers of a town's digital services, listed in a short wiki section
⟬text⟭
### Prestataires

| Prestataire | SIREN | Contact |
| --- | --- | --- |
| ⟬company#1⟭ | ⟬fr_siren#1⟭ | ⟬person_name#11⟭ |
| ⟬company#2⟭ | ⟬fr_siren#2⟭ | ⟬trap:indicator_non_pii|Support niveau 2⟭ |
| ⟬company#3⟭ | ⟬fr_siren#3⟭ | ⟬person_name#13⟭ |
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: HR
appearance: fixed columns, shift teams, team leader label with no person
scenario: weekly shift pattern printed by a plant's scheduling tool, with teams only
⟬text⟭
ROULEMENT DES EQUIPES
EQUIPE  LUNDI   MARDI   MERCREDI  JEUDI   VENDREDI
A       06-14   06-14   14-22     14-22   22-06
B       14-22   14-22   22-06     22-06   06-14
C       22-06   22-06   06-14     06-14   14-22
CHEF D'EQUIPE : ⟬trap:indicator_non_pii|VOIR AFFICHAGE ATELIER⟭
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: semicolon CSV, tests named after people, suppliers named after families, owner with no person
scenario: reagent catalogue of a hospital lab, exported for a purchasing tender, with no patient
⟬text⟭
nom_test;fabricant;reference;stock;prix_unitaire;responsable
⟬trap:eponym|Coloration de Ziehl⟭;⟬trap:company_name|Bayer⟭;REF84620;82;273,97;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Milieu de Löwenstein⟭;⟬trap:company_name|Bayer⟭;REF48342;63;313,00;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬trap:eponym|Test de Guthrie⟭;⟬trap:company_name|Roche⟭;REF64702;38;287,78;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬trap:eponym|Réaction de Widal⟭;⟬trap:company_name|Merck⟭;REF66390;65;311,16;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬trap:eponym|Réaction de Widal⟭;⟬trap:company_name|Siemens⟭;REF20078;34;210,29;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬trap:eponym|Test de Kleihauer⟭;⟬trap:company_name|Roche⟭;REF77420;111;121,82;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬trap:eponym|Test de Guthrie⟭;⟬trap:company_name|Siemens⟭;REF97413;141;143,87;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬trap:eponym|Test de Coombs⟭;⟬trap:company_name|Pfizer⟭;REF83631;40;198,30;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Coloration de Ziehl⟭;⟬trap:company_name|Abbott⟭;REF65781;90;198,84;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Réaction de Widal⟭;⟬trap:company_name|Abbott⟭;REF25228;99;213,59;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Gélose de Sabouraud⟭;⟬trap:company_name|Roche⟭;REF90284;134;307,21;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬trap:eponym|Milieu de Löwenstein⟭;⟬trap:company_name|Abbott⟭;REF90478;68;87,85;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬trap:eponym|Réaction de Widal⟭;⟬trap:company_name|Siemens⟭;REF39415;5;133,43;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬trap:eponym|Coloration de Ziehl⟭;⟬trap:company_name|Abbott⟭;REF91149;20;229,62;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Test de Coombs⟭;⟬trap:company_name|Bayer⟭;REF74430;65;62,59;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Milieu de Löwenstein⟭;⟬trap:company_name|Pfizer⟭;REF64901;137;80,39;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Réaction de Widal⟭;⟬trap:company_name|Roche⟭;REF37681;48;281,18;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Test de Coombs⟭;⟬trap:company_name|Pfizer⟭;REF32213;38;190,65;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Test de Guthrie⟭;⟬trap:company_name|Bayer⟭;REF13726;53;313,88;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Gélose de Sabouraud⟭;⟬trap:company_name|Pfizer⟭;REF73897;77;104,47;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬trap:eponym|Test de Guthrie⟭;⟬trap:company_name|Roche⟭;REF63954;127;15,27;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Milieu de Löwenstein⟭;⟬trap:company_name|Roche⟭;REF36796;135;169,71;⟬trap:indicator_non_pii|Plateau technique⟭
⟬trap:eponym|Test de Kleihauer⟭;⟬trap:company_name|Pfizer⟭;REF63022;9;205,32;⟬trap:indicator_non_pii|Laboratoire central⟭
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: real estate
appearance: TSV cell, agencies named after families, initials as visa
scenario: mandate counts per partner agency in a real estate network, with no client
⟬text⟭
agence	ville	mandats	visa
⟬trap:company_name|⦃Family⦄ Immobilier⟭	⟬city#1⟭	42	⟬trap:initials|JPB⟭
⟬trap:company_name|Cabinet ⦃Family2⦄⟭	⟬city#2⟭	17	⟬trap:initials|JPB⟭
⟬trap:company_name|⦃Family3⦄ et Associés⟭	⟬city#3⟭	29	⟬trap:initials|A.-S.⟭
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: associations
appearance: multi-row INSERT with column list, partner organisations, SIREN, IBAN, address cell
scenario: partners table of a local sports committee, restored for a new website
⟬text⟭
INSERT INTO partenaire (id, raison_sociale, siren, adresse, iban) VALUES
(1, '⟬company#1⟭', '⟬fr_siren#1⟭', '⟬fr_postal_address#1⟭', '⟬iban#1⟭'),
(2, '⟬company#2⟭', '⟬fr_siren#2⟭', '⟬fr_postal_address#2⟭', '⟬iban#2⟭'),
(3, '⟬trap:company_name|Fondation ⦃Family⦄⟭', '⟬fr_siren#3⟭', '⟬fr_postal_address#3⟭', NULL);
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: public administration
appearance: pasted cells, elected officials, birth date, NIR, tax number, bank account
scenario: allowances of a town's elected officials, pasted by the HR office to prepare the monthly payment
⟬text⟭
Indemnités des élus
Vote du conseil municipal du ⟬date#1⟭

Élu	Fonction	Date de naissance	N° SS	N° fiscal	Compte	Indemnité brute
⟬person_name#1m⟭	Conseiller	⟬birth_date#1⟭	⟬fr_social_security_number#1⟭	⟬fr_tax_number#1⟭	⟬bank_account_number#1⟭	959,80
⟬person_name#2m⟭	Conseiller délégué	⟬birth_date#2⟭	⟬fr_social_security_number#2⟭	⟬fr_tax_number#2⟭	⟬bank_account_number#2⟭	1109,51
⟬person_name#3m⟭	Conseiller	⟬birth_date#3⟭	⟬fr_social_security_number#3⟭	⟬fr_tax_number#3⟭	⟬bank_account_number#3⟭	1240,52
⟬person_name#4m⟭	Conseiller délégué	⟬birth_date#4⟭	⟬fr_social_security_number#4⟭	⟬fr_tax_number#4⟭	⟬bank_account_number#4⟭	1607,26
⟬person_name#5f⟭	Conseillère	⟬birth_date#5⟭	⟬fr_social_security_number#5⟭	⟬fr_tax_number#5⟭	⟬bank_account_number#5⟭	746,03
⟬person_name#6f⟭	Adjointe	⟬birth_date#6⟭	⟬fr_social_security_number#6⟭	⟬fr_tax_number#6⟭	⟬bank_account_number#6⟭	394,43
⟬person_name#7f⟭	Conseillère déléguée	⟬birth_date#7⟭	⟬fr_social_security_number#7⟭	⟬fr_tax_number#7⟭	⟬bank_account_number#7⟭	1599,08
⟬person_name#8f⟭	Conseillère déléguée	⟬birth_date#8⟭	⟬fr_social_security_number#8⟭	⟬fr_tax_number#8⟭	⟬bank_account_number#8⟭	1640,03
⟬person_name#9m⟭	Conseiller délégué	⟬birth_date#9⟭	⟬fr_social_security_number#9⟭	⟬fr_tax_number#9⟭	⟬bank_account_number#9⟭	865,07
⟬person_name#10m⟭	Conseiller délégué	⟬birth_date#10⟭	⟬fr_social_security_number#10⟭	⟬fr_tax_number#10⟭	⟬bank_account_number#10⟭	1573,47
⟬person_name#11f⟭	Conseillère	⟬birth_date#11⟭	⟬fr_social_security_number#11⟭	⟬fr_tax_number#11⟭	⟬bank_account_number#11⟭	588,18
⟬person_name#12f⟭	Conseillère	⟬birth_date#12⟭	⟬fr_social_security_number#12⟭	⟬fr_tax_number#12⟭	⟬bank_account_number#12⟭	402,94
⟬person_name#13f⟭	Adjointe	⟬birth_date#13⟭	⟬fr_social_security_number#13⟭	⟬fr_tax_number#13⟭	⟬bank_account_number#13⟭	1454,75
⟬person_name#14f⟭	Conseillère	⟬birth_date#14⟭	⟬fr_social_security_number#14⟭	⟬fr_tax_number#14⟭	⟬bank_account_number#14⟭	573,93
⟬person_name#15f⟭	Adjointe	⟬birth_date#15⟭	⟬fr_social_security_number#15⟭	⟬fr_tax_number#15⟭	⟬bank_account_number#15⟭	1096,04
⟬person_name#16f⟭	Conseillère	⟬birth_date#16⟭	⟬fr_social_security_number#16⟭	⟬fr_tax_number#16⟭	⟬bank_account_number#16⟭	254,71
⟬person_name#17m⟭	Conseiller délégué	⟬birth_date#17⟭	⟬fr_social_security_number#17⟭	⟬fr_tax_number#17⟭	⟬bank_account_number#17⟭	1628,54
⟬person_name#18m⟭	Conseiller délégué	⟬birth_date#18⟭	⟬fr_social_security_number#18⟭	⟬fr_tax_number#18⟭	⟬bank_account_number#18⟭	586,33
⟬end⟭
