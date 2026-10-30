⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: sql insert, footer row, neutral column
scenario: orders to ship, compared with last month
⟬text⟭
-- orders_to_ship, photo du jour comparée au mois dernier
CREATE TABLE monthly_compare (wh TEXT, period TEXT, orders INTEGER, parcels INTEGER);
INSERT INTO monthly_compare VALUES('LYS','previous',1842,2203);
INSERT INTO monthly_compare VALUES('LYS','current',2011,2398);
INSERT INTO monthly_compare VALUES('LIL','previous',960,1104);
INSERT INTO monthly_compare VALUES('LIL','current',1017,1190);

CREATE TABLE orders_to_ship (
  order_ref   TEXT PRIMARY KEY,
  wh          TEXT NOT NULL,
  parcels     INTEGER,
  weight_kg   REAL,
  carrier     TEXT,
  cut_off     TEXT,
  d2          TEXT
);
CREATE VIEW ⟬trap:code_identifier|v_⦃family⦄_cutoff⟭ AS SELECT wh, COUNT(*) AS waiting FROM orders_to_ship GROUP BY wh;
INSERT INTO orders_to_ship VALUES('⟬order_number#1⟭','LYS',2,4.3,'Colissimo','⟬date#3⟭',NULL);
INSERT INTO orders_to_ship VALUES('⟬order_number#2⟭','LYS',1,0.9,'Mondial Relay','⟬date#3⟭',NULL);
INSERT INTO orders_to_ship VALUES('⟬order_number#3⟭','LIL',4,12.6,'Geodis','⟬date#3⟭',NULL);
INSERT INTO orders_to_ship VALUES('⟬order_number#4⟭','LIL',1,1.2,'Colissimo','⟬date#2⟭',NULL);
INSERT INTO orders_to_ship VALUES('⟬order_number#5⟭','LYS',3,6.8,'Geodis','⟬date#2⟭',NULL);
INSERT INTO orders_to_ship VALUES('⟬order_number#6⟭','LYS',1,0.4,'Mondial Relay','⟬date#2⟭',NULL);
-- fin de lot : envois hors France, saisie manuelle
INSERT INTO orders_to_ship VALUES('⟬order_number#7⟭','LIL',1,0.8,'UPS','⟬date#1⟭','⟬postal_address#1⟭');
INSERT INTO orders_to_ship VALUES('⟬order_number#8⟭','LIL',3,7.1,'UPS','⟬date#1⟭','⟬postal_address#2⟭');
INSERT INTO orders_to_ship VALUES('⟬order_number#9⟭','LYS',2,3.5,'DHL','⟬date#1⟭','⟬postal_address#3⟭');
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: travel
appearance: sql insert, free text comment
scenario: car hire bookings, shared with a manager for a meeting
⟬text⟭
PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE car_hire_bookings(
  booking_id INTEGER PRIMARY KEY,
  agreement_no TEXT NOT NULL,
  pickup_site TEXT,
  category TEXT,
  pickup_on TEXT,
  days INTEGER,
  total_eur REAL,
  notes TEXT
);
INSERT INTO car_hire_bookings VALUES(1,'RA-558201','⟬city#11⟭','CDMR','⟬date#2⟭',3,214.50,'Fiche conducteur : ⟬person_name#1m⟭, né le ⟬birth_date#1⟭, permis ⟬fr_driving_licence#1⟭, NIR ⟬fr_social_security_number#1⟭.');
INSERT INTO car_hire_bookings VALUES(2,'RA-558214','⟬city#12⟭','EDAR','⟬date#2⟭',7,389.00,'');
INSERT INTO car_hire_bookings VALUES(3,'RA-558219','⟬city#11⟭','IFAR','⟬date#3⟭',2,176.90,'driver onboarding sheet - name: ⟬person_name#2⟭ / DOB ⟬birth_date#2⟭ / licence no ⟬fr_driving_licence#2⟭ / sécu ⟬fr_social_security_number#2⟭');
INSERT INTO car_hire_bookings VALUES(4,'RA-558226','⟬city#13⟭','CDMR','⟬date#3⟭',1,64.00,'GPS demandé');
INSERT INTO car_hire_bookings VALUES(5,'RA-558233','⟬city#12⟭','MBMR','⟬date#3⟭',5,298.75,NULL);
INSERT INTO car_hire_bookings VALUES(6,'RA-558240','⟬city#13⟭','SFAR','⟬date#4⟭',10,1120.00,'Conductrice additionnelle ⟬person_name#3f⟭, née le ⟬birth_date#3⟭ ; permis n° ⟬fr_driving_licence#3⟭ ; n° de sécurité sociale ⟬fr_social_security_number#3⟭');
INSERT INTO car_hire_bookings VALUES(7,'RA-558247','⟬city#11⟭','EDAR','⟬date#4⟭',4,241.20,'franchise rachetée au comptoir');
INSERT INTO car_hire_bookings VALUES(8,'RA-558255','⟬city#14⟭','CDMR','⟬date#5⟭',2,132.40,NULL);
COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: SaaS
appearance: pipe separated csv cell, note row
scenario: trial sign-ups, requested by a regulator
⟬text⟭
signup_id|workspace|plan|region|signup_date|activated|seats
⟬person_name#1⟭ <⟬email#1⟭>, ⟬date#1⟭, réf. dossier 2026-114||||||
⟬uuid#1⟭|⟬uuid#21⟭|trial-14d|eu-west|⟬date#2⟭|yes|3
⟬uuid#2⟭|⟬uuid#22⟭|trial-14d|eu-west|⟬date#2⟭|no|1
⟬uuid#3⟭|⟬uuid#23⟭|trial-30d|us-east|⟬date#3⟭|yes|12
⟬uuid#4⟭|⟬uuid#24⟭|trial-14d|eu-central|⟬date#3⟭|yes|5
⟬uuid#5⟭|⟬uuid#25⟭|trial-14d|uk-south|⟬date#3⟭|no|2
⟬uuid#6⟭|⟬uuid#26⟭|trial-30d|eu-west|⟬date#4⟭|yes|25
⟬uuid#7⟭|⟬uuid#27⟭|trial-14d|us-east|⟬date#4⟭|no|1
⟬uuid#8⟭|⟬uuid#28⟭|trial-14d|eu-west|⟬date#4⟭|yes|4
⟬uuid#9⟭|⟬uuid#29⟭|trial-14d|uk-south|⟬date#5⟭|yes|8
⟬uuid#10⟭|⟬uuid#30⟭|trial-30d|eu-central|⟬date#5⟭|no|2
⟬uuid#11⟭|⟬uuid#31⟭|trial-14d|eu-west|⟬date#5⟭|yes|3
⟬uuid#12⟭|⟬uuid#32⟭|trial-14d|us-west|⟬date#6⟭|no|1
⟬uuid#13⟭|⟬uuid#33⟭|trial-30d|eu-west|⟬date#6⟭|yes|40
⟬uuid#14⟭|⟬uuid#34⟭|trial-14d|eu-central|⟬date#6⟭|yes|6
⟬uuid#15⟭|⟬uuid#35⟭|trial-14d|eu-west|⟬date#7⟭|no|2
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: travel
appearance: csv cell, inline key and value
scenario: visa support files, shared with a manager for a meeting
⟬text⟭
"case_uuid","destination","visa_type","order_ref","status","checklist","routing"
"⟬uuid#1⟭","⟬country#1⟭","tourist","⟬order_number#1⟭","complete","passport=⟬trap:indicator_non_pii|scan_ok⟭","owner: ⟬trap:indicator_non_pii|Visa Desk⟭"
"⟬uuid#2⟭","⟬country#2⟭","business","⟬order_number#2⟭","en attente","passport=⟬trap:indicator_non_pii|missing⟭","owner: ⟬trap:indicator_non_pii|Visa Desk⟭"
"⟬uuid#3⟭","⟬country#3⟭","tourist","⟬order_number#3⟭","complete","passport=⟬trap:indicator_non_pii|scan_ok⟭","owner: ⟬trap:indicator_non_pii|Consular Liaison⟭"
"⟬uuid#4⟭","⟬country#4⟭","transit","⟬order_number#4⟭","refusé","passport=⟬trap:indicator_non_pii|expired⟭","contact: ⟬trap:indicator_non_pii|Service Groupes⟭"
"⟬uuid#5⟭","⟬country#5⟭","tourist","⟬order_number#5⟭","en attente","photo=ok","owner: ⟬trap:indicator_non_pii|Visa Desk⟭"
"⟬uuid#6⟭","⟬country#6⟭","business","⟬order_number#6⟭","complete","passport=⟬trap:indicator_non_pii|scan_ok⟭","contact: ⟬trap:indicator_non_pii|Service Groupes⟭"
"⟬uuid#7⟭","⟬country#7⟭","student","⟬order_number#7⟭","en attente","invitation=pending","owner: ⟬trap:indicator_non_pii|Consular Liaison⟭"
"⟬uuid#8⟭","⟬country#8⟭","tourist","⟬order_number#8⟭","complete","passport=⟬trap:indicator_non_pii|scan_ok⟭","owner: ⟬trap:indicator_non_pii|Visa Desk⟭"
"⟬uuid#9⟭","⟬country#9⟭","tourist","⟬order_number#9⟭","annulé","passport=⟬trap:indicator_non_pii|not_required⟭","owner: ⟬trap:indicator_non_pii|Visa Desk⟭"
"⟬uuid#10⟭","⟬country#10⟭","business","⟬order_number#10⟭","complete","photo=ok","contact: ⟬trap:indicator_non_pii|Service Groupes⟭"
"⟬uuid#11⟭","⟬country#11⟭","transit","⟬order_number#11⟭","complete","passport=⟬trap:indicator_non_pii|not_required⟭","owner: ⟬trap:indicator_non_pii|Consular Liaison⟭"
"⟬uuid#12⟭","⟬country#12⟭","tourist","⟬order_number#12⟭","en attente","passport=⟬trap:indicator_non_pii|missing⟭","owner: ⟬trap:indicator_non_pii|Visa Desk⟭"
"⟬uuid#13⟭","⟬country#13⟭","student","⟬order_number#13⟭","complete","invitation=ok","contact: ⟬trap:indicator_non_pii|Service Groupes⟭"
"⟬uuid#14⟭","⟬country#14⟭","tourist","⟬order_number#14⟭","en attente","photo=rejected","owner: ⟬trap:indicator_non_pii|Visa Desk⟭"
"⟬uuid#15⟭","⟬country#15⟭","business","⟬order_number#15⟭","complete","passport=⟬trap:indicator_non_pii|scan_ok⟭","owner: ⟬trap:indicator_non_pii|Consular Liaison⟭"
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: insurance
appearance: semicolon separated, neutral column, few rows filled
scenario: broker commissions, sent to an outside accountant
⟬text⟭
broker_code;quarter;gross_premium;rate_pct;commission;col_f;ctrl;batch
BR-1042;2026-Q2;18420,50;7,5;1381,54;;⟬trap:initials|AB⟭;B-301
BR-1043;2026-Q2;9310,00;6,0;558,60;⟬bank_account_number#1⟭;⟬trap:initials|AB⟭;B-301
BR-1051;2026-Q2;40275,80;8,0;3222,06;;⟬trap:initials|JD⟭;B-301
BR-1058;2026-Q2;2860,25;5,5;157,31;;⟬trap:initials|JD⟭;B-302
BR-1064;2026-Q2;15120,00;7,0;1058,40;⟬bank_account_number#2⟭;⟬trap:initials|AB⟭;B-302
BR-1070;2026-Q2;6745,40;6,5;438,45;;⟬trap:initials|JD⟭;B-302
BR-1077;2026-Q2;27990,10;7,5;2099,26;;⟬trap:initials|AB⟭;B-303
BR-1083;2026-Q2;11830,75;6,0;709,85;⟬bank_account_number#3⟭;⟬trap:initials|JD⟭;B-303
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: psql output, neutral column, contact cell
scenario: abandoned carts, exported for a quarterly audit
⟬text⟭
audit_t3=> SELECT cart_id, created_on, items, basket_eur, last_step, ref2 FROM abandoned_carts ORDER BY created_on DESC LIMIT 40;
               cart_id                | created_on | items | basket_eur | last_step | ref2
--------------------------------------+------------+-------+------------+-----------+------------------
 ⟬uuid#1⟭ | ⟬date#1⟭ |     3 |     118.70 | payment   | tel ⟬phone#1⟭
 ⟬uuid#2⟭ | ⟬date#1⟭ |     1 |      24.90 | shipping  |
 ⟬uuid#3⟭ | ⟬date#1⟭ |     2 |      61.40 | payment   | tel ⟬phone#3⟭
 ⟬uuid#4⟭ | ⟬date#1⟭ |     5 |     203.15 | address   |
 ⟬uuid#5⟭ | ⟬date#2⟭ |     1 |      19.00 | cart      |
 ⟬uuid#6⟭ | ⟬date#2⟭ |     4 |     142.80 | payment   | mobile ⟬phone#6⟭
 ⟬uuid#7⟭ | ⟬date#2⟭ |     2 |      48.00 | shipping  |
 ⟬uuid#8⟭ | ⟬date#2⟭ |     1 |      89.90 | payment   | tel ⟬phone#8⟭
 ⟬uuid#9⟭ | ⟬date#3⟭ |     3 |      73.25 | address   |
 ⟬uuid#10⟭ | ⟬date#3⟭ |     6 |     310.00 | payment   | tél. ⟬phone#10⟭
 ⟬uuid#11⟭ | ⟬date#3⟭ |     1 |      15.50 | cart      |
 ⟬uuid#12⟭ | ⟬date#3⟭ |     2 |      57.80 | shipping  |
 ⟬uuid#13⟭ | ⟬date#4⟭ |     2 |      64.10 | payment   | tel ⟬phone#13⟭
 ⟬uuid#14⟭ | ⟬date#4⟭ |     1 |      32.00 | address   |
 ⟬uuid#15⟭ | ⟬date#4⟭ |     3 |      97.60 | shipping  |
 ⟬uuid#16⟭ | ⟬date#4⟭ |     7 |     268.45 | payment   | mobile ⟬phone#16⟭
 ⟬uuid#17⟭ | ⟬date#5⟭ |     1 |      11.90 | cart      |
 ⟬uuid#18⟭ | ⟬date#5⟭ |     2 |      44.00 | payment   | tel ⟬phone#18⟭
 ⟬uuid#19⟭ | ⟬date#5⟭ |     4 |     126.30 | address   |
 ⟬uuid#20⟭ | ⟬date#5⟭ |     1 |      79.00 | shipping  |
 ⟬uuid#21⟭ | ⟬date#6⟭ |     2 |      38.75 | payment   | tel ⟬phone#21⟭
 ⟬uuid#22⟭ | ⟬date#6⟭ |     3 |     102.20 | shipping  |
 ⟬uuid#23⟭ | ⟬date#6⟭ |     1 |      27.40 | cart      |
 ⟬uuid#24⟭ | ⟬date#6⟭ |     5 |     189.95 | payment   | tél. ⟬phone#24⟭
 ⟬uuid#25⟭ | ⟬date#7⟭ |     2 |      51.60 | address   |
 ⟬uuid#26⟭ | ⟬date#7⟭ |     1 |      23.00 | payment   | tel ⟬phone#26⟭
 ⟬uuid#27⟭ | ⟬date#7⟭ |     3 |      84.15 | shipping  |
 ⟬uuid#28⟭ | ⟬date#7⟭ |     2 |      69.90 | cart      |
 ⟬uuid#29⟭ | ⟬date#8⟭ |     6 |     241.00 | payment   | mobile ⟬phone#29⟭
 ⟬uuid#30⟭ | ⟬date#8⟭ |     1 |      16.80 | shipping  |
 ⟬uuid#31⟭ | ⟬date#8⟭ |     2 |      59.25 | address   |
 ⟬uuid#32⟭ | ⟬date#8⟭ |     4 |     133.70 | payment   | tel ⟬phone#32⟭
 ⟬uuid#33⟭ | ⟬date#9⟭ |     1 |      42.00 | cart      |
 ⟬uuid#34⟭ | ⟬date#9⟭ |     3 |      91.45 | shipping  |
 ⟬uuid#35⟭ | ⟬date#9⟭ |     2 |      66.60 | payment   | tel ⟬phone#35⟭
 ⟬uuid#36⟭ | ⟬date#9⟭ |     1 |      28.90 | address   |
 ⟬uuid#37⟭ | ⟬date#10⟭ |     8 |     355.10 | payment   | tél. ⟬phone#37⟭
 ⟬uuid#38⟭ | ⟬date#10⟭ |     2 |      47.35 | shipping  |
 ⟬uuid#39⟭ | ⟬date#10⟭ |     1 |      13.20 | cart      |
 ⟬uuid#40⟭ | ⟬date#10⟭ |     3 |     108.00 | payment   | mobile ⟬phone#40⟭
(40 rows)
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: mixed
fill_locale: mixed
domain: SaaS
appearance: tab separated cell, free text comment
scenario: admin users, compared with last month
⟬text⟭
admin_users_compare.xlsx, feuille Oct vs Sep
notes, colonnes du maître RH : identité ; fiscal ; sécu ; date de naissance
row	account_uuid	role_sep	role_oct	mfa	last_login	delta	source	notes
2	⟬uuid#1⟭	owner	owner	yes	⟬date#1⟭	same	⟬trap:code_identifier|⦃family⦄_admin_sync⟭
3	⟬uuid#2⟭	admin	admin	yes	⟬date#1⟭	same	⟬trap:code_identifier|⦃family⦄_admin_sync⟭
4	⟬uuid#3⟭	billing	billing	no	⟬date#2⟭	same	scim
5	⟬uuid#4⟭	admin	owner	yes	⟬date#2⟭	changed	scim
6	⟬uuid#5⟭	admin	admin	yes	⟬date#1⟭	same	scim
7	⟬uuid#6⟭	support	support	yes	⟬date#3⟭	same	manual
8	⟬uuid#7⟭	admin	admin	no	⟬date#2⟭	same	manual
9	⟬uuid#8⟭	billing	admin	yes	⟬date#1⟭	changed	scim	⟬person_name#1⟭ ; ⟬fr_tax_number#1⟭ ; ⟬fr_social_security_number#1⟭ ; ⟬birth_date#1⟭
10	⟬uuid#9⟭		admin	yes	⟬date#1⟭	added	scim	⟬person_name#2⟭ ; ⟬fr_tax_number#2⟭ ; ⟬fr_social_security_number#2⟭ ; ⟬birth_date#2⟭
11	⟬uuid#10⟭	support	support	yes	⟬date#2⟭	same	scim
12	⟬uuid#11⟭	admin	admin	yes	⟬date#3⟭	same	manual
13	⟬uuid#12⟭	admin		no	⟬date#4⟭	removed	manual	⟬person_name#3⟭ ; ⟬fr_tax_number#3⟭ ; ⟬fr_social_security_number#3⟭ ; ⟬birth_date#3⟭
14	⟬uuid#13⟭	billing	billing	yes	⟬date#2⟭	same	scim
15	⟬uuid#14⟭	support	admin	yes	⟬date#1⟭	changed	scim
16	⟬uuid#15⟭	admin	admin	yes	⟬date#3⟭	same	scim
17	⟬uuid#16⟭	owner	owner	yes	⟬date#2⟭	same	manual
18	⟬uuid#17⟭	support	support	no	⟬date#5⟭	same	manual
19	⟬uuid#18⟭		support	yes	⟬date#2⟭	added	scim
20	⟬uuid#19⟭	admin	admin	yes	⟬date#3⟭	same	scim
21	⟬uuid#20⟭	billing	billing	yes	⟬date#4⟭	same	scim
22	⟬uuid#21⟭	admin	support	yes	⟬date#2⟭	changed	scim	⟬person_name#4⟭ ; ⟬fr_tax_number#4⟭ ; ⟬fr_social_security_number#4⟭ ; ⟬birth_date#4⟭
23	⟬uuid#22⟭	support	support	yes	⟬date#3⟭	same	scim
24	⟬uuid#23⟭	admin	admin	yes	⟬date#1⟭	same	manual
25	⟬uuid#24⟭	billing		no	⟬date#5⟭	removed	manual
26	⟬uuid#25⟭	admin	admin	yes	⟬date#2⟭	same	scim
27	⟬uuid#26⟭	support	support	yes	⟬date#4⟭	same	scim
28	⟬uuid#27⟭		billing	yes	⟬date#1⟭	added	scim
29	⟬uuid#28⟭	admin	admin	yes	⟬date#3⟭	same	scim
30	⟬uuid#29⟭	support	support	no	⟬date#6⟭	same	manual
31	⟬uuid#30⟭	admin	admin	yes	⟬date#2⟭	same	scim
32	⟬uuid#31⟭	billing	billing	yes	⟬date#3⟭	same	scim
33	⟬uuid#32⟭	admin	admin	yes	⟬date#4⟭	same	manual
34	⟬uuid#33⟭	support	support	yes	⟬date#2⟭	same	scim
35	⟬uuid#34⟭	owner	admin	yes	⟬date#1⟭	changed	scim	⟬person_name#5⟭ ; ⟬fr_tax_number#5⟭ ; ⟬fr_social_security_number#5⟭ ; ⟬birth_date#5⟭
36	⟬uuid#35⟭	support	support	yes	⟬date#3⟭	same	scim
37	⟬uuid#36⟭	admin	admin	no	⟬date#5⟭	same	manual
38	⟬uuid#37⟭	billing	billing	yes	⟬date#2⟭	same	scim
39	⟬uuid#38⟭	support	support	yes	⟬date#4⟭	same	scim
40	⟬uuid#39⟭	admin	admin	yes	⟬date#2⟭	same	scim
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: SaaS
appearance: copy block, sql comment
scenario: seat licences, sampled for a test environment
⟬text⟭
-- seat_licences, échantillon pour l'environnement de test
COPY public.seat_licences (licence_id, workspace_id, plan_id, seats, used, renewed_on) FROM stdin;
9001	⟬uuid#1⟭	⟬uuid#11⟭	25	19	⟬date#1⟭
9002	⟬uuid#2⟭	⟬uuid#12⟭	5	5	⟬date#2⟭
9003	⟬uuid#3⟭	⟬uuid#11⟭	120	87	⟬date#2⟭
9004	⟬uuid#4⟭	⟬uuid#12⟭	10	3	⟬date#3⟭
9005	⟬uuid#5⟭	⟬uuid#13⟭	2	2	⟬date#4⟭
\.
SELECT setval('seat_licences_licence_id_seq', 9005, true);
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: travel
appearance: sql comment, sql insert
scenario: group tour list, cleaned up before a mail merge
⟬text⟭
-- ⟬fr_social_security_number#1⟭ | ⟬fr_postal_address#1⟭ | ⟬birth_date#1⟭
-- ⟬fr_social_security_number#2⟭ | ⟬fr_postal_address#2⟭ | ⟬birth_date#2⟭
CREATE TABLE `group_tour_list` (
  `tour_code` varchar(10) NOT NULL,
  `departure` date NOT NULL,
  `destination` varchar(40) DEFAULT NULL,
  `pax` smallint DEFAULT NULL,
  `single_rooms` smallint DEFAULT NULL,
  `coach` varchar(8) DEFAULT NULL,
  `merge_ready` char(1) DEFAULT 'N'
);
INSERT INTO `group_tour_list` VALUES ('GT-1148','⟬date#1⟭','⟬city#11⟭',32,4,'C-07','Y');
INSERT INTO `group_tour_list` VALUES ('GT-1149','⟬date#1⟭','⟬city#12⟭',28,2,'C-11','Y');
INSERT INTO `group_tour_list` VALUES ('GT-1152','⟬date#2⟭','⟬city#13⟭',45,6,'C-03','N');
INSERT INTO `group_tour_list` VALUES ('GT-1153','⟬date#2⟭','⟬city#11⟭',19,1,'C-07','Y');
INSERT INTO `group_tour_list` VALUES ('GT-1157','⟬date#3⟭','⟬city#14⟭',38,3,'C-14','Y');
INSERT INTO `group_tour_list` VALUES ('GT-1160','⟬date#3⟭','⟬city#15⟭',24,5,'C-11','N');
INSERT INTO `group_tour_list` VALUES ('GT-1164','⟬date#4⟭','⟬city#12⟭',41,2,'C-03','Y');
-- doublons retirés avant publipostage, merge_ready mis à jour à la main
-- rappel : les deux lignes d'en-tête suivent le gabarit système NIR / domicile / date de naissance (responsables de groupe)
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: numbered rows, free text comment
scenario: customer reviews, attached to a ticket
⟬text⟭
reviews_export.xlsx > Feuil1, joint à ⟬ticket_id#1⟭
Row 1: review_id | sku | stars | posted | comment
Row 2: R-8812 | HM-7781 | 5 | ⟬date#2⟭ | Parfum discret, très bien. Contact : ⟬person_name#1⟭, mail ⟬email#1⟭
Row 3: R-8813 | HM-7781 | 4 | ⟬date#2⟭ | Bougie ⟬trap:word_name|Rose⟭ un peu pâle mais agréable.
Row 4: R-8814 | LN-2207 | 2 | ⟬date#3⟭ | Taille trop petite. Contact : ⟬person_name#2⟭, mail ⟬email#2⟭
Row 5: R-8815 | CT-0093 | 5 | ⟬date#3⟭ | vu sur ⟬trap:email_lookalike|@bougies.et.co⟭, jamais déçue
Row 6: R-8816 | BX-4410 | 1 | ⟬date#3⟭ | Fuite dès la première utilisation, contact: ⟬person_name#3⟭ <⟬email#3⟭>
Row 7: R-8817 | CT-0094 | 3 | ⟬date#4⟭ | Thé correct, emballage moyen.
Row 8: R-8818 | HM-7790 | 5 | ⟬date#4⟭ | Great diffuser, shipped fast. Reach me: ⟬person_name#4⟭, email ⟬email#4⟭
Row 9: R-8819 | LN-2208 | 4 | ⟬date#4⟭ | Couleur ⟬trap:word_name|Prune⟭ fidèle à la photo.
Row 10: R-8820 | HM-7781 | 2 | ⟬date#5⟭ | Mèche trop courte. Client : ⟬person_name#5m⟭, adresse mail ⟬email#5⟭
Row 11: R-8821 | BX-4411 | 5 | ⟬date#5⟭ | Tient au frais toute la journée.
Row 12: R-8822 | CT-0093 | 4 | ⟬date#5⟭ | Arrived in two days, nice box.
Row 13: R-8823 | HM-7790 | 1 | ⟬date#6⟭ | Reçu cassé. Contact : ⟬person_name#6⟭, mail ⟬email#6⟭
Row 14: R-8824 | LN-2207 | 5 | ⟬date#6⟭ | Lin épais, belle coupe.
Row 15: R-8825 | BX-4410 | 3 | ⟬date#6⟭ | Bouchon dur à ouvrir.
Row 16: R-8826 | CT-0094 | 5 | ⟬date#7⟭ | Offert à ma mère, elle a adoré.
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: SaaS
appearance: sql insert, stored function, sql comment
scenario: usage by workspace, kept as a manual backup
⟬text⟭
-- usage_by_workspace, sauvegarde manuelle avant purge du trimestre
CREATE TABLE workspace_usage (
  workspace_id uuid NOT NULL,
  workspace_label text,
  plan text,
  usage_month date,
  api_calls bigint,
  storage_gb numeric(8,2),
  search_backend text
);
INSERT INTO workspace_usage VALUES ('⟬uuid#1⟭', '⟬trap:company_name|⦃Family⦄ Conseil⟭', '⟬trap:eponym|Turing⟭', '⟬date#2⟭', 1204331, 18.40, '⟬trap:library|Sphinx⟭');
INSERT INTO workspace_usage VALUES ('⟬uuid#2⟭', '⟬trap:company_name|Cabinet ⦃Family2⦄⟭', '⟬trap:eponym|Lovelace⟭', '⟬date#2⟭', 88412, 2.15, '⟬trap:library|Whoosh⟭');
INSERT INTO workspace_usage VALUES ('⟬uuid#3⟭', '⟬trap:company_name|⦃Family3⦄ Plomberie⟭', '⟬trap:eponym|Lovelace⟭', '⟬date#2⟭', 35120, 0.90, '⟬trap:library|Whoosh⟭');
INSERT INTO workspace_usage VALUES ('⟬uuid#4⟭', '⟬trap:company_name|Michelin⟭', '⟬trap:eponym|Hopper⟭', '⟬date#2⟭', 9840230, 412.75, '⟬trap:library|Sphinx⟭');
INSERT INTO workspace_usage VALUES ('⟬uuid#5⟭', '⟬company#1⟭', '⟬trap:eponym|Turing⟭', '⟬date#3⟭', 1098770, 16.05, '⟬trap:library|Sphinx⟭');
INSERT INTO workspace_usage VALUES ('⟬uuid#6⟭', '⟬trap:company_name|⦃Family4⦄ et Associés⟭', '⟬trap:eponym|Lovelace⟭', '⟬date#3⟭', 71205, 1.80, '⟬trap:library|Whoosh⟭');
INSERT INTO workspace_usage VALUES ('⟬uuid#7⟭', '⟬company#2⟭', '⟬trap:eponym|Hopper⟭', '⟬date#3⟭', 5123684, 240.30, '⟬trap:library|Sphinx⟭');
CREATE FUNCTION ⟬trap:code_identifier|quota_⦃family5⦄_overage⟭(calls bigint) RETURNS bigint
  LANGUAGE sql IMMUTABLE AS 'SELECT GREATEST(calls - 1000000, 0)';
-- déduplication des libellés par distance de ⟬trap:eponym|Levenshtein⟭, seuil 2
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: insurance
appearance: sql insert, first column
scenario: travel cover holders, compared with last month
⟬text⟭
-- travel_cover_holders, comparaison M vs M-1
CREATE TABLE travel_cover_holders (numero_fiscal varchar(20), policy_ref varchar(12), zone varchar(12), trip_days int, premium_eur numeric(7,2), vs_prev_month varchar(8));
INSERT INTO travel_cover_holders (numero_fiscal, policy_ref, zone, trip_days, premium_eur, vs_prev_month) VALUES ('⟬fr_tax_number#1⟭', 'TRV-40021', 'Schengen', 14, 38.50, 'new');
INSERT INTO travel_cover_holders (numero_fiscal, policy_ref, zone, trip_days, premium_eur, vs_prev_month) VALUES ('⟬fr_tax_number#2⟭', 'TRV-40038', 'World', 30, 112.90, 'same');
INSERT INTO travel_cover_holders (numero_fiscal, policy_ref, zone, trip_days, premium_eur, vs_prev_month) VALUES ('⟬fr_tax_number#3⟭', 'TRV-40044', 'Schengen', 7, 21.00, 'same');
INSERT INTO travel_cover_holders (numero_fiscal, policy_ref, zone, trip_days, premium_eur, vs_prev_month) VALUES ('⟬fr_tax_number#4⟭', 'TRV-40052', 'USA-CAN', 21, 148.25, 'dropped');
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: mixed
fill_locale: mixed
domain: insurance
appearance: note row, tab separated cell
scenario: vehicle fleet cover, merged from two sources
⟬text⟭
Flotte véhicules, fusion extraction courtier + gestion interne (⟬date#1⟭)

Source A courtier : gestionnaire ⟬person_name#1⟭, tel ⟬phone#1⟭, véhicule de remplacement immat ⟬fr_license_plate#1⟭
asset	class	make	cover	premium_eur	renewal	ctrl
A-1001	VUL	⟬trap:company_name|Renault⟭	TRS	812.40	⟬date#3⟭	⟬trap:initials|M.B.⟭
A-1002	VUL	⟬trap:company_name|Renault⟭	TRS	812.40	⟬date#3⟭	⟬trap:initials|M.B.⟭
A-1003	VP	⟬trap:company_name|Peugeot⟭	TIE	546.15	⟬date#3⟭	⟬trap:initials|M.B.⟭
A-1004	VP	⟬trap:company_name|Peugeot⟭	TIE	546.15	⟬date#3⟭	⟬trap:initials|L.T.⟭
A-1005	PL	⟬trap:company_name|Iveco⟭	TRS	2388.00	⟬date#4⟭	⟬trap:initials|L.T.⟭
A-1006	PL	⟬trap:company_name|Iveco⟭	RCO	1720.45	⟬date#4⟭	⟬trap:initials|L.T.⟭
A-1007	VUL	⟬trap:company_name|Citroën⟭	TRS	790.00	⟬date#4⟭	⟬trap:initials|M.B.⟭
A-1008	VUL	⟬trap:company_name|Citroën⟭	TRS	790.00	⟬date#4⟭	⟬trap:initials|M.B.⟭
A-1009	VP	⟬trap:company_name|Renault⟭	RCO	388.20	⟬date#5⟭	⟬trap:initials|L.T.⟭
A-1010	VP	⟬trap:company_name|Renault⟭	RCO	388.20	⟬date#5⟭	⟬trap:initials|L.T.⟭
A-1011	VUL	⟬trap:company_name|Ford⟭	TIE	655.90	⟬date#5⟭	⟬trap:initials|M.B.⟭
A-1012	VUL	⟬trap:company_name|Ford⟭	TIE	655.90	⟬date#5⟭	⟬trap:initials|M.B.⟭
A-1013	VP	⟬trap:company_name|Peugeot⟭	TRS	702.30	⟬date#6⟭	⟬trap:initials|L.T.⟭
A-1014	PL	⟬trap:company_name|Iveco⟭	TRS	2412.60	⟬date#6⟭	⟬trap:initials|L.T.⟭
A-1015	VUL	⟬trap:company_name|Renault⟭	RCO	498.75	⟬date#6⟭	⟬trap:initials|M.B.⟭
A-1016	VP	⟬trap:company_name|Citroën⟭	TIE	512.60	⟬date#7⟭	⟬trap:initials|M.B.⟭
A-1017	VP	⟬trap:company_name|Citroën⟭	TIE	512.60	⟬date#7⟭	⟬trap:initials|L.T.⟭
A-1018	VUL	⟬trap:company_name|Ford⟭	TRS	768.30	⟬date#7⟭	⟬trap:initials|L.T.⟭

Source B interne : référent ⟬person_name#2m⟭, portable ⟬phone#2⟭, plaque pool ⟬fr_license_plate#2⟭
asset	class	make	cover	premium_eur	renewal	ctrl
B-2001	VP	⟬trap:company_name|Renault⟭	TIE	531.00	⟬date#3⟭	interne
B-2002	VP	⟬trap:company_name|Renault⟭	TIE	531.00	⟬date#3⟭	interne
B-2003	VUL	⟬trap:company_name|Peugeot⟭	TRS	804.10	⟬date#4⟭	interne
B-2004	VUL	⟬trap:company_name|Peugeot⟭	TRS	804.10	⟬date#4⟭	interne
B-2005	PL	⟬trap:company_name|Ford⟭	TRS	2140.75	⟬date#4⟭	à revoir
B-2006	VP	⟬trap:company_name|Citroën⟭	RCO	402.35	⟬date#5⟭	interne
B-2007	VP	⟬trap:company_name|Citroën⟭	RCO	402.35	⟬date#5⟭	interne
B-2008	VUL	⟬trap:company_name|Renault⟭	TIE	640.20	⟬date#5⟭	interne
B-2009	VUL	⟬trap:company_name|Renault⟭	TIE	640.20	⟬date#6⟭	à revoir
B-2010	PL	⟬trap:company_name|Iveco⟭	TRS	2298.90	⟬date#6⟭	interne
B-2011	VP	⟬trap:company_name|Peugeot⟭	RCO	391.50	⟬date#6⟭	interne
B-2012	VP	⟬trap:company_name|Peugeot⟭	RCO	391.50	⟬date#7⟭	interne
B-2013	VUL	⟬trap:company_name|Ford⟭	TRS	768.30	⟬date#7⟭	interne
B-2014	VUL	⟬trap:company_name|Ford⟭	TRS	768.30	⟬date#7⟭	à revoir
B-2015	VP	⟬trap:company_name|Citroën⟭	TIE	512.60	⟬date#8⟭	interne
B-2016	VP	⟬trap:company_name|Citroën⟭	TIE	512.60	⟬date#8⟭	interne
B-2017	PL	⟬trap:company_name|Iveco⟭	RCO	1720.45	⟬date#8⟭	à revoir
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: sql insert, column list, sql comment
scenario: marketplace payouts, used to debug an import
⟬text⟭
-- rejeu de l'import marketplace, lot ⟬ticket_id#1⟭ : les lignes 5 et 6 tombent en contrainte sur state
CREATE TABLE IF NOT EXISTS payouts (
  payout_id integer PRIMARY KEY,
  seller_ref text NOT NULL,
  account_holder text NOT NULL,
  iban text NOT NULL,
  amount_cents integer NOT NULL,
  currency text DEFAULT 'EUR',
  state text CHECK (state IN ('queued','sent','held'))
);
INSERT INTO payouts (payout_id, seller_ref, account_holder, iban, amount_cents, currency, state) VALUES (8801, 'S-20433', '⟬person_name#1⟭', '⟬iban#1⟭', 213049, 'EUR', 'sent');
INSERT INTO payouts (payout_id, seller_ref, account_holder, iban, amount_cents, currency, state) VALUES (8802, 'S-20452', '⟬person_name#2⟭', '⟬iban#2⟭', 58880, 'EUR', 'sent');
INSERT INTO payouts (payout_id, seller_ref, account_holder, iban, amount_cents, currency, state) VALUES (8803, 'S-20470', '⟬person_name#3⟭', '⟬iban#3⟭', 111835, 'EUR', 'queued');
INSERT INTO payouts (payout_id, seller_ref, account_holder, iban, amount_cents, currency, state) VALUES (8804, 'S-20488', '⟬company#4⟭', '⟬iban#4⟭', 2079200, 'EUR', 'sent');
INSERT INTO payouts (payout_id, seller_ref, account_holder, iban, amount_cents, currency, state) VALUES (8805, 'S-20495', '⟬person_name#5⟭', '⟬iban#5⟭', 28134, 'GBP', 'paused');
INSERT INTO payouts (payout_id, seller_ref, account_holder, iban, amount_cents, currency, state) VALUES (8806, 'S-20502', '⟬person_name#6⟭', '⟬iban#6⟭', 1466480, 'EUR', 'en_attente');
INSERT INTO payouts (payout_id, seller_ref, account_holder, iban, amount_cents, currency, state) VALUES (8807, 'S-20511', '⟬person_name#7⟭', '⟬iban#7⟭', 94210, 'EUR', 'held');
SELECT state, COUNT(*), SUM(amount_cents) / 100.0 AS total FROM payouts GROUP BY state;
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: travel
appearance: multi-row sql insert, settings table, sql comment
scenario: passenger manifest, prepared for a migration to a new tool
⟬text⟭
-- Reprise manifest vers le nouvel outil : agrégats par ligne, site et équipe
-- owner: ⟬trap:indicator_non_pii|escale-data⟭
CREATE SCHEMA IF NOT EXISTS ops;

CREATE OR REPLACE TABLE ops.manifest_settings (setting STRING, value STRING);
INSERT INTO ops.manifest_settings (setting, value) VALUES
  ('passenger_name_format', '⟬trap:indicator_non_pii|LAST/FIRST⟭'),
  ('dob_format', '⟬trap:indicator_non_pii|%Y-%m-%d⟭'),
  ('passenger_contact', '⟬trap:indicator_non_pii|Opérations Sol⟭'),
  ('api_key_header', '⟬trap:indicator_non_pii|X-Api-Key⟭'),
  ('session_token_ttl', '⟬trap:indicator_non_pii|900⟭');

CREATE OR REPLACE TABLE ops.manifest_summary (
  route STRING,
  site STRING,
  team STRING,
  flight_month DATE,
  flights INT64,
  pax_booked INT64,
  pax_boarded INT64,
  no_show INT64
);

INSERT INTO ops.manifest_summary (route, site, team, flight_month, flights, pax_booked, pax_boarded, no_show) VALUES
  ('CDG-JFK', 'CDG', 'Escale T2', DATE '⟬date#1⟭', 62, 17980, 17412, 568),
  ('CDG-JFK', 'CDG', 'Escale T2', DATE '⟬date#2⟭', 60, 17220, 16854, 366),
  ('CDG-SIN', 'CDG', 'Escale T2', DATE '⟬date#1⟭', 31, 8370, 8166, 204),
  ('CDG-SIN', 'CDG', 'Escale T2', DATE '⟬date#2⟭', 30, 8010, 7843, 167),
  ('CDG-DXB', 'CDG', 'Escale T2', DATE '⟬date#1⟭', 44, 12100, 11790, 310),
  ('CDG-DXB', 'CDG', 'Escale T2', DATE '⟬date#2⟭', 44, 11880, 11602, 278),
  ('ORY-LIS', 'ORY', 'Escale Sud', DATE '⟬date#1⟭', 88, 13640, 13211, 429),
  ('ORY-LIS', 'ORY', 'Escale Sud', DATE '⟬date#2⟭', 86, 13158, 12840, 318),
  ('ORY-FDF', 'ORY', 'Escale Sud', DATE '⟬date#1⟭', 40, 15200, 14984, 216),
  ('ORY-FDF', 'ORY', 'Escale Sud', DATE '⟬date#2⟭', 38, 14250, 14063, 187),
  ('ORY-RUN', 'ORY', 'Escale Sud', DATE '⟬date#1⟭', 31, 11780, 11605, 175),
  ('ORY-RUN', 'ORY', 'Escale Sud', DATE '⟬date#2⟭', 31, 11563, 11410, 153),
  ('NCE-LHR', 'NCE', 'Base Azur', DATE '⟬date#1⟭', 72, 10080, 9722, 358),
  ('NCE-LHR', 'NCE', 'Base Azur', DATE '⟬date#2⟭', 70, 9660, 9368, 292),
  ('NCE-AMS', 'NCE', 'Base Azur', DATE '⟬date#1⟭', 58, 7830, 7584, 246),
  ('NCE-AMS', 'NCE', 'Base Azur', DATE '⟬date#2⟭', 56, 7448, 7244, 204),
  ('LYS-CMN', 'LYS', 'Base Rhône', DATE '⟬date#1⟭', 31, 5270, 5148, 122),
  ('LYS-CMN', 'LYS', 'Base Rhône', DATE '⟬date#2⟭', 30, 5040, 4933, 107),
  ('LYS-MAD', 'LYS', 'Base Rhône', DATE '⟬date#1⟭', 46, 6440, 6251, 189),
  ('LYS-MAD', 'LYS', 'Base Rhône', DATE '⟬date#2⟭', 44, 6072, 5920, 152);

SELECT team, SUM(no_show) AS no_show FROM ops.manifest_summary GROUP BY team ORDER BY no_show DESC;
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: travel
appearance: csv cell, neutral column
scenario: hotel reservations, attached to a ticket
⟬text⟭
"res_no","hotel_code","check_in","nights","ref_ext","total_eur","status","remark"
"H-77120","NCY01","⟬date#2⟭",2,"",238.00,"stayed","RAS"
"H-77121","NCY01","⟬date#2⟭",1,"IBAN ⟬iban#1⟭",119.00,"cancelled","remboursement à faire, cf. ⟬ticket_id#1⟭"
"H-77123","FLR02","⟬date#2⟭",3,"",594.00,"stayed","RAS"
"H-77124","FLR02","⟬date#3⟭",2,"",490.00,"stayed","late check-out"
"H-77128","CLT03","⟬date#3⟭",1,"virement sur IBAN : ⟬iban#2⟭",289.00,"overbooked","rembt nuit + geste 30 €"
"H-77129","CLT03","⟬date#3⟭",4,"",476.00,"stayed","RAS"
"H-77131","SYD04","⟬date#3⟭",2,"",396.00,"no-show","caution retenue"
"H-77134","SYD04","⟬date#4⟭",5,"",595.00,"stayed","RAS"
"H-77136","NCY01","⟬date#4⟭",1,"iban: ⟬iban#3⟭",119.00,"cancelled","annulé sous 48 h, remboursable"
"H-77137","FLR02","⟬date#4⟭",2,"",238.00,"stayed","RAS"
"H-77140","CLT03","⟬date#4⟭",3,"",357.00,"stayed","double charge suspected"
"H-77142","NCY01","⟬date#5⟭",2,"IBAN ⟬iban#4⟭",238.00,"overcharged","trop-perçu de 45 € à rendre"
"H-77143","SYD04","⟬date#5⟭",1,"",198.00,"stayed","RAS"
"H-77145","FLR02","⟬date#5⟭",3,"",735.00,"stayed","RAS"
"H-77147","CLT03","⟬date#6⟭",2,"",578.00,"cancelled","non remboursable"
"H-77149","NCY01","⟬date#6⟭",1,"",119.00,"stayed","RAS"
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: csv cell, inline key and value
scenario: customer reviews, shared with a manager for a meeting
⟬text⟭
"review_ref","sku","stars","author","email","phone","dept","attrs"
"⟬uuid#1⟭","HM-7781",5,"anonymous","hidden","not_collected","SAV","reviewer=⟬trap:indicator_non_pii|guest⟭"
"⟬uuid#2⟭","HM-7781",4,"anonymous","hidden","not_collected","SAV","Author: ⟬trap:indicator_non_pii|moderation-bot⟭"
"⟬uuid#3⟭","LN-2207",2,"verified buyer","hidden","not_collected","Qualité","reviewer=⟬trap:indicator_non_pii|guest⟭"
"⟬uuid#4⟭","CT-0093",5,"anonymous","bounced","not_collected","SAV","contact=⟬trap:indicator_non_pii|Relation Clients⟭"
"⟬uuid#5⟭","BX-4410",1,"verified buyer","hidden","opted_out","Qualité","Author: ⟬trap:indicator_non_pii|moderation-bot⟭"
"⟬uuid#6⟭","CT-0094",3,"anonymous","hidden","not_collected","SAV","reviewer=⟬trap:indicator_non_pii|guest⟭"
"⟬uuid#7⟭","HM-7790",5,"verified buyer","hidden","not_collected","Marketing","contact=⟬trap:indicator_non_pii|Relation Clients⟭"
"⟬uuid#8⟭","LN-2208",4,"anonymous","unsubscribed","not_collected","Marketing","reviewer=⟬trap:indicator_non_pii|guest⟭"
"⟬uuid#9⟭","HM-7781",2,"verified buyer","hidden","opted_out","Qualité","contact=⟬trap:indicator_non_pii|Relation Clients⟭"
"⟬uuid#10⟭","BX-4411",5,"anonymous","hidden","not_collected","SAV","Author: ⟬trap:indicator_non_pii|moderation-bot⟭"
"⟬uuid#11⟭","CT-0093",4,"verified buyer","hidden","not_collected","SAV","reviewer=⟬trap:indicator_non_pii|guest⟭"
"⟬uuid#12⟭","HM-7790",1,"anonymous","bounced","not_collected","Qualité","contact=⟬trap:indicator_non_pii|Relation Clients⟭"
"⟬uuid#13⟭","LN-2207",5,"verified buyer","hidden","not_collected","Marketing","reviewer=⟬trap:indicator_non_pii|guest⟭"
"⟬uuid#14⟭","CT-0094",5,"anonymous","hidden","opted_out","SAV","Author: ⟬trap:indicator_non_pii|moderation-bot⟭"
"⟬uuid#15⟭","BX-4410",3,"verified buyer","hidden","not_collected","Qualité","reviewer=⟬trap:indicator_non_pii|guest⟭"
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: SaaS
appearance: block comment, sql insert
scenario: usage by workspace, used to debug an import
⟬text⟭
/*
  usage_by_workspace, shard EU : l'import casse au-delà de la ligne 3
  Exporté par : ⟬person_name#1⟭
  Mail : ⟬email#1⟭
  Le : ⟬date#2⟭
*/
CREATE TABLE IF NOT EXISTS usage_eu (ws varchar(36), period char(7), active_users int, events bigint);
INSERT IGNORE INTO usage_eu VALUES ('⟬uuid#1⟭', '2026-09', 18, 402113);
INSERT IGNORE INTO usage_eu VALUES ('⟬uuid#2⟭', '2026-09', 4, 18220);
INSERT IGNORE INTO usage_eu VALUES ('⟬uuid#3⟭', '2026-09', 112, 3380417);

/*
  shard US, same query, rerun after the failure
  Exported by: ⟬person_name#2⟭
  Email: ⟬email#2⟭
  On: ⟬date#1⟭
*/
CREATE TABLE IF NOT EXISTS usage_us (ws varchar(36), period char(7), active_users int, events bigint);
INSERT IGNORE INTO usage_us VALUES ('⟬uuid#4⟭', '2026-09', 37, 951204);
INSERT IGNORE INTO usage_us VALUES ('⟬uuid#5⟭', '2026-09', 2, 6480);
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: insurance
appearance: sql insert, last column, SQL Developer export
scenario: medical cover members, merged from two sources
⟬text⟭
REM INSERTING into CLAIMS.MEDICAL_MEMBERS
SET DEFINE OFF;
REM fusion GEOS + LEG, adhérents expatriés, passeport obligatoire pour la prise en charge
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204411','GEOS','INT-PLUS',to_date('⟬date#1⟭','YYYY-MM-DD'),2,250000,'⟬fr_passport#1⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204412','GEOS','INT-BASE',to_date('⟬date#1⟭','YYYY-MM-DD'),0,100000,'⟬fr_passport#2⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204415','GEOS','INT-PLUS',to_date('⟬date#2⟭','YYYY-MM-DD'),1,250000,'⟬fr_passport#3⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204418','GEOS','INT-BASE',to_date('⟬date#2⟭','YYYY-MM-DD'),3,100000,'⟬fr_passport#4⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204420','GEOS','INT-PREM',to_date('⟬date#3⟭','YYYY-MM-DD'),2,500000,'⟬fr_passport#5⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204423','GEOS','INT-BASE',to_date('⟬date#3⟭','YYYY-MM-DD'),0,100000,'⟬fr_passport#6⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204427','GEOS','INT-PLUS',to_date('⟬date#3⟭','YYYY-MM-DD'),1,250000,'⟬fr_passport#7⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204430','GEOS','INT-BASE',to_date('⟬date#4⟭','YYYY-MM-DD'),0,100000,'⟬fr_passport#8⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204433','GEOS','INT-PREM',to_date('⟬date#4⟭','YYYY-MM-DD'),4,500000,'⟬fr_passport#9⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204436','GEOS','INT-PLUS',to_date('⟬date#4⟭','YYYY-MM-DD'),2,250000,'⟬fr_passport#10⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204440','GEOS','INT-BASE',to_date('⟬date#5⟭','YYYY-MM-DD'),1,100000,'⟬fr_passport#11⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204442','GEOS','INT-PLUS',to_date('⟬date#5⟭','YYYY-MM-DD'),0,250000,'⟬fr_passport#12⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204447','GEOS','INT-PREM',to_date('⟬date#5⟭','YYYY-MM-DD'),3,500000,'⟬fr_passport#13⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204451','GEOS','INT-BASE',to_date('⟬date#6⟭','YYYY-MM-DD'),2,100000,'⟬fr_passport#14⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204455','GEOS','INT-PLUS',to_date('⟬date#6⟭','YYYY-MM-DD'),1,250000,'⟬fr_passport#15⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204458','GEOS','INT-BASE',to_date('⟬date#6⟭','YYYY-MM-DD'),0,100000,'⟬fr_passport#16⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204462','GEOS','INT-PLUS',to_date('⟬date#7⟭','YYYY-MM-DD'),2,250000,'⟬fr_passport#17⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('M-204466','GEOS','INT-PREM',to_date('⟬date#7⟭','YYYY-MM-DD'),1,500000,'⟬fr_passport#18⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009127','LEG','EXP-ANC',to_date('⟬date#8⟭','YYYY-MM-DD'),0,150000,'⟬fr_passport#19⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009131','LEG','EXP-ANC',to_date('⟬date#8⟭','YYYY-MM-DD'),2,150000,'⟬fr_passport#20⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009134','LEG','EXP-FAM',to_date('⟬date#8⟭','YYYY-MM-DD'),3,300000,'⟬fr_passport#21⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009138','LEG','EXP-ANC',to_date('⟬date#9⟭','YYYY-MM-DD'),1,150000,'⟬fr_passport#22⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009142','LEG','EXP-FAM',to_date('⟬date#9⟭','YYYY-MM-DD'),2,300000,'⟬fr_passport#23⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009145','LEG','EXP-ANC',to_date('⟬date#9⟭','YYYY-MM-DD'),0,150000,'⟬fr_passport#24⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009149','LEG','EXP-FAM',to_date('⟬date#10⟭','YYYY-MM-DD'),4,300000,'⟬fr_passport#25⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009152','LEG','EXP-ANC',to_date('⟬date#10⟭','YYYY-MM-DD'),1,150000,'⟬fr_passport#26⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009156','LEG','EXP-ANC',to_date('⟬date#10⟭','YYYY-MM-DD'),0,150000,'⟬fr_passport#27⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009160','LEG','EXP-FAM',to_date('⟬date#11⟭','YYYY-MM-DD'),2,300000,'⟬fr_passport#28⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009163','LEG','EXP-ANC',to_date('⟬date#11⟭','YYYY-MM-DD'),1,150000,'⟬fr_passport#29⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009167','LEG','EXP-FAM',to_date('⟬date#11⟭','YYYY-MM-DD'),3,300000,'⟬fr_passport#30⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009171','LEG','EXP-ANC',to_date('⟬date#12⟭','YYYY-MM-DD'),0,150000,'⟬fr_passport#31⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009174','LEG','EXP-ANC',to_date('⟬date#12⟭','YYYY-MM-DD'),2,150000,'⟬fr_passport#32⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009178','LEG','EXP-FAM',to_date('⟬date#12⟭','YYYY-MM-DD'),1,300000,'⟬fr_passport#33⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009181','LEG','EXP-ANC',to_date('⟬date#13⟭','YYYY-MM-DD'),0,150000,'⟬fr_passport#34⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009185','LEG','EXP-FAM',to_date('⟬date#13⟭','YYYY-MM-DD'),2,300000,'⟬fr_passport#35⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009189','LEG','EXP-ANC',to_date('⟬date#13⟭','YYYY-MM-DD'),1,150000,'⟬fr_passport#36⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009192','LEG','EXP-FAM',to_date('⟬date#14⟭','YYYY-MM-DD'),2,300000,'⟬fr_passport#37⟭');
Insert into CLAIMS.MEDICAL_MEMBERS (MEMBER_NO,SOURCE_SYS,PLAN_CODE,JOINED_ON,DEPENDANTS,ANNUAL_CAP_EUR,NUMERO_PASSEPORT) values ('L-009196','LEG','EXP-ANC',to_date('⟬date#14⟭','YYYY-MM-DD'),0,150000,'⟬fr_passport#38⟭');
COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: csv cell, footer row
scenario: VIP customers, requested by a regulator
⟬text⟭
"customer_id","tier","lifetime_spend_eur","orders","full_name","ssn","iban","address"
"⟬customer_id#3⟭","Platinum",18240.50,41,"","","",""
"⟬customer_id#4⟭","Platinum",16110.00,37,"","","",""
"⟬customer_id#5⟭","Platinum",14875.25,29,"","","",""
"⟬customer_id#6⟭","Gold",9320.40,26,"","","",""
"⟬customer_id#7⟭","Gold",8740.00,22,"","","",""
"⟬customer_id#8⟭","Gold",8015.90,19,"","","",""
"⟬customer_id#9⟭","Gold",7460.15,18,"","","",""
"⟬customer_id#10⟭","Gold",7105.00,17,"","","",""
"⟬customer_id#11⟭","Silver",5290.75,15,"","","",""
"⟬customer_id#12⟭","Silver",4985.30,14,"","","",""
"⟬customer_id#13⟭","Silver",4410.00,12,"","","",""
"⟬customer_id#14⟭","Silver",3905.60,11,"","","",""
"⟬customer_id#15⟭","Silver",3640.20,11,"","","",""
"⟬customer_id#16⟭","Silver",3275.00,10,"","","",""
"PIED DE FICHIER, demande du régulateur","",,,"⟬person_name#1⟭","⟬us_ssn#1⟭","⟬iban#1⟭","⟬postal_address#1⟭"
"PIED DE FICHIER, demande du régulateur","",,,"⟬person_name#2⟭","⟬us_ssn#2⟭","⟬iban#2⟭","⟬postal_address#2⟭"
⟬end⟭
