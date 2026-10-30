⟬template⟭
family: tabular
format: spreadsheet as text
language: mixed
fill_locale: mixed
domain: SaaS
appearance: tab separated cell, free text cell, formula
scenario: support tickets by account, attached to a ticket
⟬text⟭
Onglet tickets_par_compte (collé depuis Sheets, 30 derniers jours, joint à ⟬ticket_id#20⟭)
account_uuid	ticket	opened	closed	prio	sla_breach	component	release	linked_order	summary
⟬uuid#1⟭	⟬ticket_id#1⟭	⟬date#2⟭		P2	no	webhooks	⟬version#1⟭	⟬order_number#1⟭	retries stop after third 502
⟬uuid#1⟭	⟬ticket_id#2⟭	⟬date#3⟭	⟬date#2⟭	P3	no	billing	⟬version#1⟭	⟬order_number#2⟭	⟬trap:library|Jackson⟭ parse error on invoice payload
⟬uuid#2⟭	⟬ticket_id#3⟭	⟬date#3⟭	⟬date#1⟭	P1	yes	sso	⟬version#2⟭		boucle de redirection après rotation du certificat
⟬uuid#3⟭	⟬ticket_id#4⟭	⟬date#4⟭	⟬date#3⟭	P3	no	exports	⟬version#2⟭	⟬order_number#3⟭	export CSV vide sur compte sandbox
⟬uuid#3⟭	⟬ticket_id#5⟭	⟬date#4⟭		P2	yes	search	⟬version#3⟭		⟬trap:library|Sphinx⟭ index lagging 40 min behind
⟬uuid#4⟭	⟬ticket_id#6⟭	⟬date#5⟭	⟬date#4⟭	P4	no	ui	⟬version#3⟭		libellé tronqué sur l'écran des quotas
⟬uuid#5⟭	⟬ticket_id#7⟭	⟬date#5⟭	⟬date#2⟭	P2	no	billing	⟬version#3⟭	⟬order_number#4⟭	double prélèvement signalé, remboursé via ⟬order_number#5⟭
⟬uuid#5⟭	⟬ticket_id#8⟭	⟬date#6⟭	⟬date#5⟭	P3	no	api	⟬version#4⟭		429 on /v2/usage despite plan limit
⟬uuid#6⟭	⟬ticket_id#9⟭	⟬date#6⟭		P1	yes	workers	⟬version#4⟭		⟬trap:library|Celery⟭ queue stuck, ack late disabled
⟬uuid#6⟭	⟬ticket_id#10⟭	⟬date#7⟭	⟬date#6⟭	P3	no	exports	⟬version#4⟭	⟬order_number#6⟭	fichier ZIP corrompu au-delà de 2 Go
⟬uuid#7⟭	⟬ticket_id#11⟭	⟬date#7⟭	⟬date#3⟭	P2	no	sso	⟬version#5⟭		SCIM provisioning loops on group rename
⟬uuid#8⟭	⟬ticket_id#12⟭	⟬date#8⟭	⟬date#7⟭	P4	no	docs	⟬version#5⟭		lien cassé vers la page des limites
⟬uuid#8⟭	⟬ticket_id#13⟭	⟬date#8⟭	⟬date#6⟭	P3	no	webhooks	⟬version#5⟭		signature mismatch after clock skew, commit ⟬git_sha#1⟭
⟬uuid#9⟭	⟬ticket_id#14⟭	⟬date#9⟭	⟬date#8⟭	P2	yes	api	⟬version#6⟭	⟬order_number#7⟭	pagination returns page 2 twice
⟬uuid#9⟭	⟬ticket_id#15⟭	⟬date#9⟭		P3	no	ui	⟬version#6⟭		graphique d'usage vide en fuseau Asia/Tokyo
⟬uuid#10⟭	⟬ticket_id#16⟭	⟬date#10⟭	⟬date#9⟭	P4	no	billing	⟬version#6⟭		arrondi TVA à 0,01 près sur avoir
rows	16		open	4		=COUNTIF(F3:F18;"yes")
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: mixed
fill_locale: mixed
domain: insurance
appearance: pipe separated cell, key and value rows
scenario: fraud review list, exported for a quarterly audit
⟬text⟭
Q3 fraud review, audit extract: fiches d'entrée en relation des dossiers signalés
case    | step       | item              | value
FR-2291 | onboarding | nom complet       | ⟬person_name#1⟭
FR-2291 | onboarding | numéro fiscal     | ⟬fr_tax_number#1⟭
FR-2291 | onboarding | adresse du risque | ⟬fr_postal_address#1⟭
FR-2291 | onboarding | tel portable      | ⟬phone#1⟭
FR-2291 | flag       | reason            | same bank details as FR-2305
FR-2305 | onboarding | nom complet       | ⟬person_name#2⟭
FR-2305 | onboarding | numéro fiscal     | ⟬fr_tax_number#2⟭
FR-2305 | onboarding | adresse du risque | ⟬fr_postal_address#2⟭
FR-2305 | onboarding | tel portable      | ⟬phone#2⟭
FR-2305 | flag       | reason            | 3 sinistres en 11 mois, ⟬date#1⟭
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: insurance
appearance: sql insert, sql comment, neutral column
scenario: vehicle fleet cover, exported for a quarterly audit
⟬text⟭
--
-- PostgreSQL database dump
--

-- Dumped from database version ⟬version#1⟭
-- Extraction audit T3, périmètre flottes auto uniquement

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET search_path = fleet, public;

--
-- Name: cover_lines; Type: TABLE; Schema: fleet; Owner: ⟬trap:indicator_non_pii|audit_ro⟭
--

CREATE TABLE fleet.cover_lines (
    line_id integer NOT NULL,
    fleet_ref character varying(16) NOT NULL,
    make character varying(24),
    vehicle_class character varying(8),
    cover_code character(3),
    annual_premium numeric(10,2),
    effective_on date,
    rv_on date,
    rv_a text,
    rv_b text
);

INSERT INTO fleet.cover_lines VALUES (1, 'FL-0041', '⟬trap:company_name|Renault⟭', 'VUL', 'TRS', 812.40, '⟬date#7⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (2, 'FL-0041', '⟬trap:company_name|Renault⟭', 'VUL', 'TRS', 812.40, '⟬date#7⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (3, 'FL-0041', '⟬trap:company_name|Peugeot⟭', 'VP', 'TIE', 546.15, '⟬date#7⟭', '⟬date#3⟭', '⟬person_name#1⟭', '⟬email#1⟭');
INSERT INTO fleet.cover_lines VALUES (4, 'FL-0052', '⟬trap:company_name|Citroën⟭', 'VUL', 'TRS', 790.00, '⟬date#6⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (5, 'FL-0052', '⟬trap:company_name|Citroën⟭', 'VUL', 'TRS', 790.00, '⟬date#6⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (6, 'FL-0052', '⟬trap:company_name|Ford⟭', 'PL', 'TRS', 2140.75, '⟬date#6⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (7, 'FL-0060', '⟬trap:company_name|Peugeot⟭', 'VP', 'TIE', 512.60, '⟬date#6⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (8, 'FL-0060', '⟬trap:company_name|Peugeot⟭', 'VP', 'TIE', 512.60, '⟬date#6⟭', '⟬date#2⟭', '⟬person_name:initial#2⟭', '⟬email#2⟭');
INSERT INTO fleet.cover_lines VALUES (9, 'FL-0060', '⟬trap:company_name|Renault⟭', 'VP', 'RCO', 388.20, '⟬date#5⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (10, 'FL-0073', '⟬trap:company_name|Iveco⟭', 'PL', 'TRS', 2388.00, '⟬date#5⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (11, 'FL-0073', '⟬trap:company_name|Iveco⟭', 'PL', 'TRS', 2388.00, '⟬date#5⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (12, 'FL-0073', '⟬trap:company_name|Ford⟭', 'VUL', 'TIE', 655.90, '⟬date#5⟭', '⟬date#3⟭', '⟬person_name#1⟭', '⟬email#1⟭');
INSERT INTO fleet.cover_lines VALUES (13, 'FL-0081', '⟬trap:company_name|Citroën⟭', 'VP', 'RCO', 402.35, '⟬date#5⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (14, 'FL-0081', '⟬trap:company_name|Renault⟭', 'VUL', 'TRS', 804.10, '⟬date#5⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (15, 'FL-0081', '⟬trap:company_name|Renault⟭', 'VUL', 'TRS', 804.10, '⟬date#5⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (16, 'FL-0094', '⟬trap:company_name|Peugeot⟭', 'VP', 'TIE', 531.00, '⟬date#4⟭', '⟬date#1⟭', '⟬person_name#3⟭', '⟬email#3⟭');
INSERT INTO fleet.cover_lines VALUES (17, 'FL-0094', '⟬trap:company_name|Peugeot⟭', 'VP', 'TIE', 531.00, '⟬date#4⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (18, 'FL-0094', '⟬trap:company_name|Iveco⟭', 'PL', 'RCO', 1720.45, '⟬date#4⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (19, 'FL-0102', '⟬trap:company_name|Ford⟭', 'VUL', 'TRS', 768.30, '⟬date#4⟭', NULL, NULL, NULL);
INSERT INTO fleet.cover_lines VALUES (20, 'FL-0102', '⟬trap:company_name|Ford⟭', 'VUL', 'TRS', 768.30, '⟬date#4⟭', '⟬date#1⟭', '⟬person_name#3⟭', '⟬email#3⟭');

ALTER TABLE ONLY fleet.cover_lines
    ADD CONSTRAINT cover_lines_pkey PRIMARY KEY (line_id);

--
-- PostgreSQL database dump complete
--
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: pipe separated cell, contact cell
scenario: stock alerts, shared with a manager for a meeting
⟬text⟭
Stock alerts, point du lundi avec la direction (⟬date#1⟭)
sku      | product               | on_hand | reorder_at | last_restock | contact (ERP)
---------+-----------------------+---------+------------+--------------+---------------------------------------
BX-4410  | Gourde inox 750 ml    |       4 |         50 | ⟬date#3⟭ | ⟬person_name#1⟭, tel ⟬phone#1⟭, mail ⟬email#1⟭
BX-4411  | Gourde inox 500 ml    |      11 |         50 | ⟬date#3⟭ |
LN-2207  | T-shirt lin ⟬trap:word_name|Rose⟭ M   |       0 |         30 | ⟬date#4⟭ | ⟬person_name#2⟭ / tél. ⟬phone#2⟭
LN-2208  | T-shirt lin ⟬trap:word_name|Rose⟭ L   |       2 |         30 | ⟬date#4⟭ |
CT-0093  | Coffret thé vert      |       7 |         25 | ⟬date#2⟭ |
CT-0094  | Coffret thé noir      |       9 |         25 | ⟬date#2⟭ |
HM-7781  | Bougie cire de soja   |       3 |         40 | ⟬date#5⟭ | email: ⟬email#3⟭
HM-7790  | Diffuseur bambou      |      14 |         20 | ⟬date#5⟭ |
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: travel
appearance: csv cell, headerless row, neutral column
scenario: refund requests, merged from two sources
⟬text⟭
"BKG","RF-20418","⟬order_number#1⟭","⟬date#1⟭","⟬iban#1⟭",412.50,"EUR","vol annulé","à virer"
"OTA","AX-771203","⟬order_number#2⟭","⟬date#1⟭","⟬iban#2⟭",189.00,"GBP","schedule change","pending"
"BKG","RF-20417","⟬order_number#3⟭","⟬date#2⟭","",95.00,"EUR","hôtel surbooké","avoir émis"
"BKG","RF-20416","⟬order_number#4⟭","⟬date#2⟭","⟬iban#4⟭",1240.00,"EUR","séjour annulé","à virer"
"OTA","AX-771188","⟬order_number#5⟭","⟬date#3⟭","⟬iban#5⟭",77.40,"EUR","duplicate charge","paid"
"OTA","AX-771187","⟬order_number#6⟭","⟬date#3⟭","⟬iban#6⟭",310.00,"CHF","schedule change","pending"
"BKG","RF-20415","⟬order_number#7⟭","⟬date#3⟭","⟬iban#7⟭",58.00,"EUR","bagage perdu","viré"
"BKG","RF-20414","⟬order_number#8⟭","⟬date#4⟭","",220.00,"EUR","train supprimé","avoir émis"
"OTA","AX-771160","⟬order_number#9⟭","⟬date#4⟭","⟬iban#9⟭",645.90,"EUR","supplier failure","paid"
"BKG","RF-20413","⟬order_number#10⟭","⟬date#4⟭","⟬iban#10⟭",134.50,"EUR","vol retardé","à virer"
"BKG","RF-20412","⟬order_number#11⟭","⟬date#5⟭","⟬iban#11⟭",980.00,"EUR","séjour annulé","viré"
"OTA","AX-771142","⟬order_number#12⟭","⟬date#5⟭","",49.99,"GBP","goodwill","voucher"
"OTA","AX-771141","⟬order_number#13⟭","⟬date#5⟭","⟬iban#13⟭",268.00,"EUR","schedule change","paid"
"BKG","RF-20411","⟬order_number#14⟭","⟬date#6⟭","⟬iban#14⟭",72.00,"EUR","transfert non assuré","viré"
"BKG","RF-20410","⟬order_number#15⟭","⟬date#6⟭","⟬iban#15⟭",1510.00,"EUR","croisière annulée","à virer"
"OTA","AX-771119","⟬order_number#16⟭","⟬date#6⟭","⟬iban#16⟭",403.20,"EUR","duplicate charge","pending"
"OTA","AX-771118","⟬order_number#17⟭","⟬date#7⟭","⟬iban#17⟭",96.00,"GBP","schedule change","paid"
"BKG","RF-20409","⟬order_number#18⟭","⟬date#7⟭","",150.00,"EUR","vol retardé","avoir émis"
"BKG","RF-20408","⟬order_number#19⟭","⟬date#7⟭","⟬iban#19⟭",330.00,"EUR","hôtel fermé","viré"
"OTA","AX-771097","⟬order_number#20⟭","⟬date#8⟭","⟬iban#20⟭",512.75,"EUR","supplier failure","paid"
"BKG","RF-20407","⟬order_number#21⟭","⟬date#8⟭","⟬iban#21⟭",88.00,"EUR","bagage perdu","viré"
"OTA","AX-771096","⟬order_number#22⟭","⟬date#8⟭","⟬iban#22⟭",1120.00,"CHF","schedule change","pending"
"BKG","RF-20406","⟬order_number#23⟭","⟬date#9⟭","⟬iban#23⟭",275.00,"EUR","train supprimé","viré"
"BKG","RF-20405","⟬order_number#24⟭","⟬date#9⟭","",60.00,"EUR","geste commercial","avoir émis"
"OTA","AX-771074","⟬order_number#25⟭","⟬date#9⟭","⟬iban#25⟭",199.00,"EUR","duplicate charge","paid"
"OTA","AX-771073","⟬order_number#26⟭","⟬date#10⟭","⟬iban#26⟭",742.30,"GBP","supplier failure","paid"
"BKG","RF-20404","⟬order_number#27⟭","⟬date#10⟭","⟬iban#27⟭",410.00,"EUR","séjour annulé","viré"
"BKG","RF-20403","⟬order_number#28⟭","⟬date#10⟭","⟬iban#28⟭",125.00,"EUR","vol retardé","viré"
"OTA","AX-771052","⟬order_number#29⟭","⟬date#11⟭","",35.00,"EUR","goodwill","voucher"
"BKG","RF-20402","⟬order_number#30⟭","⟬date#11⟭","⟬iban#30⟭",860.00,"EUR","vol annulé","viré"
"OTA","AX-771051","⟬order_number#31⟭","⟬date#11⟭","⟬iban#31⟭",158.60,"EUR","schedule change","paid"
"BKG","RF-20401","⟬order_number#32⟭","⟬date#12⟭","⟬iban#32⟭",64.00,"EUR","bagage perdu","viré"
"OTA","AX-771033","⟬order_number#33⟭","⟬date#12⟭","⟬iban#33⟭",927.00,"EUR","supplier failure","paid"
"BKG","RF-20400","⟬order_number#34⟭","⟬date#12⟭","",300.00,"EUR","séjour écourté","avoir émis"
"OTA","AX-771032","⟬order_number#35⟭","⟬date#13⟭","⟬iban#35⟭",241.15,"GBP","schedule change","paid"
"BKG","RF-20399","⟬order_number#36⟭","⟬date#13⟭","⟬iban#36⟭",540.00,"EUR","croisière annulée","viré"
"BKG","RF-20398","⟬order_number#37⟭","⟬date#13⟭","⟬iban#37⟭",112.00,"EUR","train supprimé","viré"
"OTA","AX-771010","⟬order_number#38⟭","⟬date#14⟭","⟬iban#38⟭",83.40,"EUR","duplicate charge","paid"
"OTA","AX-771009","⟬order_number#39⟭","⟬date#14⟭","⟬iban#39⟭",1365.00,"EUR","supplier failure","paid"
"BKG","RF-20397","⟬order_number#40⟭","⟬date#14⟭","⟬iban#40⟭",205.00,"EUR","vol annulé","viré"
"BKG","RF-20396","⟬order_number#41⟭","⟬date#15⟭","",70.00,"EUR","geste commercial","avoir émis"
"OTA","AX-770998","⟬order_number#42⟭","⟬date#15⟭","⟬iban#42⟭",456.80,"EUR","schedule change","paid"
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: insurance
appearance: csv cell, first column, semicolon separated
scenario: open claims, prepared for a migration to a new tool
⟬text⟭
k;claim_no;line;opened;status;reserve_eur;desk;target_queue
⟬fr_license_plate#1⟭;SIN-88213;auto;⟬date#3⟭;ouvert;1840,00;⟬city#1⟭;motor-new
⟬fr_license_plate#2⟭;SIN-88219;auto;⟬date#3⟭;expertise;2375,50;⟬city#2⟭;motor-new
⟬payment_card#3⟭;SIN-88224;garantie achats;⟬date#4⟭;ouvert;310,00;⟬city#3⟭;cards-new
⟬fr_license_plate#4⟭;SIN-88230;auto;⟬date#4⟭;ouvert;640,00;⟬city#1⟭;motor-new
⟬fr_license_plate#5⟭;SIN-88233;auto;⟬date#4⟭;attente pièces;4120,75;⟬city#2⟭;motor-new
⟬payment_card#6⟭;SIN-88241;garantie achats;⟬date#5⟭;expertise;89,90;⟬city#3⟭;cards-new
⟬fr_license_plate#7⟭;SIN-88247;auto;⟬date#5⟭;ouvert;1225,00;⟬city#4⟭;motor-new
⟬fr_license_plate#8⟭;SIN-88252;auto;⟬date#5⟭;recours;7800,00;⟬city#4⟭;legal-new
⟬fr_license_plate#9⟭;SIN-88258;auto;⟬date#6⟭;ouvert;515,20;⟬city#1⟭;motor-new
⟬payment_card#10⟭;SIN-88263;garantie achats;⟬date#6⟭;ouvert;1499,00;⟬city#3⟭;cards-new
⟬fr_license_plate#11⟭;SIN-88270;auto;⟬date#6⟭;attente pièces;2960,00;⟬city#2⟭;motor-new
⟬fr_license_plate#12⟭;SIN-88276;auto;⟬date#7⟭;expertise;980,00;⟬city#4⟭;motor-new
⟬fr_license_plate#13⟭;SIN-88281;auto;⟬date#7⟭;ouvert;3310,40;⟬city#1⟭;motor-new
⟬payment_card#14⟭;SIN-88289;garantie achats;⟬date#8⟭;recours;640,00;⟬city#3⟭;legal-new
⟬fr_license_plate#15⟭;SIN-88294;auto;⟬date#8⟭;ouvert;1105,00;⟬city#2⟭;motor-new
⟬fr_license_plate#16⟭;SIN-88301;auto;⟬date#9⟭;ouvert;2240,00;⟬city#4⟭;motor-new
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: csv cell, free text comment
scenario: product returns, sent to an outside accountant
⟬text⟭
"return_id","order_ref","sku","qty","refund_eur","vat_eur","credit_note","return_reason","comment"
"RET-30112","⟬order_number#1⟭","TS-LIN-M",1,29.90,4.98,"⟬invoice_number#1⟭","size",""
"RET-30113","⟬order_number#2⟭","MUG-CER-02",2,31.80,5.30,"⟬invoice_number#2⟭","damaged","colis abîmé, rappeler au ⟬phone#1⟭ le soir uniquement"
"RET-30114","⟬order_number#3⟭","BOU-SOJ-01",1,18.50,3.08,"⟬invoice_number#3⟭","changed mind",""
"RET-30115","⟬order_number#4⟭","TS-LIN-L",1,29.90,4.98,"⟬invoice_number#4⟭","size",""
"RET-30116","⟬order_number#5⟭","GOU-INX-75",3,74.70,12.45,"⟬invoice_number#5⟭","wrong item",""
"RET-30117","⟬order_number#6⟭","SAC-TOI-01",1,22.00,3.67,"⟬invoice_number#6⟭","damaged","remboursement partiel validé, tel client ⟬phone#2⟭"
"RET-30118","⟬order_number#7⟭","DIF-BAM-02",1,39.00,6.50,"⟬invoice_number#7⟭","late delivery",""
"RET-30119","⟬order_number#8⟭","MUG-CER-02",1,15.90,2.65,"⟬invoice_number#8⟭","damaged",""
"RET-30120","⟬order_number#9⟭","COF-THE-03",1,27.50,1.43,"⟬invoice_number#9⟭","changed mind","avoir à refaire, TVA réduite sur le thé"
"RET-30121","⟬order_number#10⟭","TS-LIN-S",2,59.80,9.97,"⟬invoice_number#10⟭","size",""
"RET-30122","⟬order_number#11⟭","BOU-SOJ-03",1,18.50,3.08,"⟬invoice_number#11⟭","wrong item","customer asked for callback, mobile: ⟬phone#3⟭"
"RET-30123","⟬order_number#12⟭","GOU-INX-50",1,21.90,3.65,"⟬invoice_number#12⟭","changed mind",""
"RET-30124","⟬order_number#13⟭","SAC-TOI-01",2,44.00,7.33,"⟬invoice_number#13⟭","late delivery",""
"RET-30125","⟬order_number#14⟭","DIF-BAM-02",1,39.00,6.50,"⟬invoice_number#14⟭","damaged","retour refusé par le dépôt, voir ⟬ticket_id#1⟭"
"RET-30126","⟬order_number#15⟭","TS-LIN-M",1,29.90,4.98,"⟬invoice_number#15⟭","size",""
"RET-30127","⟬order_number#16⟭","COF-THE-01",1,27.50,1.43,"⟬invoice_number#16⟭","wrong item","joindre au ⟬phone#4⟭ avant de renvoyer"
"RET-30128","⟬order_number#17⟭","MUG-CER-04",4,63.60,10.60,"⟬invoice_number#17⟭","damaged",""
"RET-30129","⟬order_number#18⟭","GOU-INX-75",1,24.90,4.15,"⟬invoice_number#18⟭","changed mind",""
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: travel
appearance: csv cell, attribute and value rows
scenario: loyalty miles, used to debug an import
⟬text⟭
"member_ref","attr","value","import_step","import_result"
"⟬customer_id#1⟭","miles_balance","18420","normalize","ok"
"⟬customer_id#1⟭","tier","Gold","normalize","ok"
"⟬customer_id#1⟭","email","⟬trap:indicator_non_pii|bounced⟭","normalize","warn"
"⟬customer_id#1⟭","phone","⟬trap:indicator_non_pii|not_provided⟭","normalize","warn"
"⟬customer_id#2⟭","miles_balance","2075","normalize","ok"
"⟬customer_id#2⟭","tier","Silver","normalize","ok"
"⟬customer_id#2⟭","email","⟬trap:indicator_non_pii|verified⟭","normalize","ok"
"⟬customer_id#2⟭","contact","⟬trap:indicator_non_pii|Service Fidélité⟭","map_owner","ok"
"⟬customer_id#3⟭","miles_balance","-120","normalize","error"
"⟬customer_id#3⟭","tier","Bronze","normalize","ok"
"⟬customer_id#3⟭","owner","⟬trap:indicator_non_pii|Loyalty Ops⟭","map_owner","ok"
"⟬customer_id#3⟭","phone","⟬trap:indicator_non_pii|invalid_format⟭","normalize","warn"
"⟬customer_id#4⟭","miles_balance","96500","normalize","ok"
"⟬customer_id#4⟭","tier","Platinum","normalize","ok"
"⟬customer_id#4⟭","contact","⟬trap:indicator_non_pii|Direction Commerciale⟭","map_owner","ok"
"⟬customer_id#4⟭","name","⟬trap:indicator_non_pii|masked_upstream⟭","normalize","skip"
"⟬customer_id#5⟭","miles_balance","0","normalize","ok"
"⟬customer_id#5⟭","email","⟬trap:indicator_non_pii|unsubscribed⟭","normalize","ok"
"⟬customer_id#5⟭","expiry","⟬date#1⟭","parse_date","error"
"⟬customer_id#5⟭","owner","⟬trap:indicator_non_pii|Partenariats Aérien⟭","map_owner","ok"
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: csv cell, note row
scenario: coupon usage, attached to a ticket
⟬text⟭
"coupon","order_ref","redeemed_on","discount_eur","channel"
"Extraction faite par ⟬person_name#1⟭ le ⟬date#1⟭ pour ⟬ticket_id#1⟭","","","",""
"WELCOME10","⟬order_number#1⟭","⟬date#2⟭",10.00,"web"
"WELCOME10","⟬order_number#2⟭","⟬date#2⟭",10.00,"app"
"SOLDES25","⟬order_number#3⟭","⟬date#3⟭",25.00,"web"
"SOLDES25","⟬order_number#4⟭","⟬date#3⟭",25.00,"web"
"LIVRAISON0","⟬order_number#5⟭","⟬date#4⟭",4.90,"app"
"SOLDES25","⟬order_number#6⟭","⟬date#4⟭",25.00,"marketplace"
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: SaaS
appearance: csv cell, note row
scenario: overdue invoices, sent to an outside accountant
⟬text⟭
"invoice","account","issued","due","amount_eur","days_late","dunning"
"[profile]","⟬postal_address#1⟭","⟬payment_card#1⟭","","","",""
"⟬invoice_number#1⟭","⟬customer_id#1⟭","⟬date#6⟭","⟬date#5⟭",1290.00,62,"R2"
"⟬invoice_number#2⟭","⟬customer_id#2⟭","⟬date#6⟭","⟬date#5⟭",480.00,62,"R2"
"⟬invoice_number#3⟭","⟬customer_id#3⟭","⟬date#5⟭","⟬date#4⟭",3150.00,41,"R1"
"⟬invoice_number#4⟭","⟬customer_id#4⟭","⟬date#4⟭","⟬date#3⟭",95.00,33,"R1"
"⟬invoice_number#5⟭","⟬customer_id#2⟭","⟬date#3⟭","⟬date#2⟭",480.00,12,"R0"
"⟬invoice_number#6⟭","⟬customer_id#5⟭","⟬date#3⟭","⟬date#2⟭",7200.00,12,"R0"
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: travel
appearance: sql insert, copy block, sql comment
scenario: hotel reservations, prepared for a migration to a new tool
⟬text⟭
--
-- PostgreSQL database dump
-- Reprise vers le nouveau PMS, lot hôtels et réservations
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Name: hotels; Type: TABLE; Schema: stay; Owner: ⟬trap:indicator_non_pii|migration_svc⟭
--

CREATE TABLE stay.hotels (
    hotel_id integer PRIMARY KEY,
    label text NOT NULL,
    brand text,
    town text,
    stars smallint
);

ALTER TABLE stay.hotels OWNER TO ⟬trap:indicator_non_pii|migration_svc⟭;

INSERT INTO stay.hotels VALUES (101, '⟬trap:company_name|Hôtel ⦃Family⦄⟭', '⟬trap:company_name|Groupe ⦃Family2⦄⟭', '⟬trap:word_name|Nancy⟭', 3);
INSERT INTO stay.hotels VALUES (102, '⟬trap:company_name|Résidence ⦃Family3⦄⟭', '⟬trap:company_name|Groupe ⦃Family2⦄⟭', '⟬trap:word_name|Florence⟭', 4);
INSERT INTO stay.hotels VALUES (103, '⟬trap:company_name|Hilton⟭ Riverside', '⟬trap:company_name|Hilton⟭', '⟬trap:word_name|Charlotte⟭', 4);
INSERT INTO stay.hotels VALUES (104, '⟬trap:company_name|Ritz Carlton⟭ Marina', '⟬trap:company_name|Marriott⟭', '⟬trap:word_name|Sydney⟭', 5);
INSERT INTO stay.hotels VALUES (105, '⟬trap:company_name|Auberge ⦃Family4⦄ et Fils⟭', NULL, '⟬city#1⟭', 2);
INSERT INTO stay.hotels VALUES (106, 'Les Terrasses du Port', '⟬company#1⟭', '⟬city#2⟭', 3);

--
-- Name: rate_plans; Type: TABLE; Schema: stay; Owner: ⟬trap:indicator_non_pii|migration_svc⟭
--

CREATE TABLE stay.rate_plans (
    plan_code text PRIMARY KEY,
    label text NOT NULL,
    base_eur numeric(8,2)
);

INSERT INTO stay.rate_plans VALUES ('SUI-EIF', '⟬trap:eponym|Suite Gustave Eiffel⟭', 289.00);
INSERT INTO stay.rate_plans VALUES ('SUI-CUR', '⟬trap:eponym|Suite Marie Curie⟭', 245.00);
INSERT INTO stay.rate_plans VALUES ('DLX-MAG', '⟬trap:eponym|Deluxe Magellan⟭', 198.00);
INSERT INTO stay.rate_plans VALUES ('STD-FLX', 'Standard flexible', 119.00);

CREATE TABLE stay.settings (name text PRIMARY KEY, value text);
INSERT INTO stay.settings VALUES ('guest_contact', '⟬trap:indicator_non_pii|Front Office⟭');
INSERT INTO stay.settings VALUES ('billing_email', '⟬trap:indicator_non_pii|disabled⟭');
INSERT INTO stay.settings VALUES ('password_min_length', '⟬trap:indicator_non_pii|12⟭');

--
-- Data for Name: reservations; Type: TABLE DATA; Schema: stay; Owner: ⟬trap:indicator_non_pii|migration_svc⟭
--

COPY stay.reservations (reservation_id, external_ref, hotel_id, plan_code, check_in, nights, total_eur) FROM stdin;
700341	⟬uuid#1⟭	101	STD-FLX	⟬date#2⟭	2	238.00
700342	⟬uuid#2⟭	103	SUI-EIF	⟬date#2⟭	1	289.00
700343	⟬uuid#3⟭	104	DLX-MAG	⟬date#3⟭	3	594.00
700344	⟬uuid#4⟭	102	SUI-CUR	⟬date#3⟭	2	490.00
700345	⟬uuid#5⟭	105	STD-FLX	⟬date#4⟭	1	119.00
700346	⟬uuid#6⟭	106	STD-FLX	⟬date#4⟭	4	476.00
700347	⟬uuid#7⟭	101	DLX-MAG	⟬date#5⟭	2	396.00
700348	⟬uuid#8⟭	103	STD-FLX	⟬date#5⟭	5	595.00
\.
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: insurance
appearance: csv cell, first column
scenario: policy renewals, exported for a quarterly audit
⟬text⟭
"adresse_risque","postcode","policy_no","product","renewal_on","premium_eur","visit_required","branch"
"⟬fr_postal_address#1⟭","⟬postcode#1⟭","HAB-1120044","MRH Confort","⟬date#2⟭",412.30,"oui","⟬city#21⟭"
"⟬fr_postal_address#2⟭","⟬postcode#2⟭","HAB-1120051","MRH Essentiel","⟬date#2⟭",268.75,"non","⟬city#21⟭"
"⟬fr_postal_address#3⟭","⟬postcode#3⟭","PNO-3300127","Propriétaire non occupant","⟬date#2⟭",189.10,"non","⟬city#22⟭"
"⟬fr_postal_address#4⟭","⟬postcode#4⟭","HAB-1120068","MRH Confort","⟬date#3⟭",455.00,"oui","⟬city#22⟭"
"⟬fr_postal_address#5⟭","⟬postcode#5⟭","PRO-5500412","Multirisque commerce","⟬date#3⟭",1320.40,"oui","⟬city#21⟭"
"⟬fr_postal_address#6⟭","⟬postcode#6⟭","HAB-1120073","MRH Essentiel","⟬date#3⟭",244.60,"non","⟬city#23⟭"
"⟬fr_postal_address#7⟭","⟬postcode#7⟭","HAB-1120080","MRH Confort","⟬date#4⟭",398.15,"non","⟬city#23⟭"
"⟬fr_postal_address#8⟭","⟬postcode#8⟭","PNO-3300134","Propriétaire non occupant","⟬date#4⟭",201.00,"non","⟬city#21⟭"
"⟬fr_postal_address#9⟭","⟬postcode#9⟭","PRO-5500429","Multirisque commerce","⟬date#4⟭",2085.90,"oui","⟬city#22⟭"
"⟬fr_postal_address#10⟭","⟬postcode#10⟭","HAB-1120095","MRH Essentiel","⟬date#5⟭",259.30,"non","⟬city#23⟭"
"⟬fr_postal_address#11⟭","⟬postcode#11⟭","HAB-1120102","MRH Confort","⟬date#5⟭",431.70,"oui","⟬city#21⟭"
"⟬fr_postal_address#12⟭","⟬postcode#12⟭","PNO-3300141","Propriétaire non occupant","⟬date#5⟭",176.45,"non","⟬city#22⟭"
"⟬fr_postal_address#13⟭","⟬postcode#13⟭","HAB-1120119","MRH Essentiel","⟬date#6⟭",272.20,"non","⟬city#23⟭"
"⟬fr_postal_address#14⟭","⟬postcode#14⟭","PRO-5500436","Multirisque commerce","⟬date#6⟭",1764.00,"oui","⟬city#21⟭"
"⟬fr_postal_address#15⟭","⟬postcode#15⟭","HAB-1120126","MRH Confort","⟬date#6⟭",420.85,"non","⟬city#22⟭"
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: aligned columns, footer row
scenario: VIP customers, attached to a ticket
⟬text⟭
VIP_customers.xlsx, onglet MASTER, pour ⟬ticket_id#1⟭
Lignes de fin : id / titulaire / livraison / date de naissance / pièce US
customer_id        tier       orders   ltv_eur   last_order    nps   churn_risk
⟬customer_id#3⟭    Platinum   41       18240     ⟬date#2⟭      9     low
⟬customer_id#4⟭    Platinum   37       16110     ⟬date#2⟭      8     low
⟬customer_id#5⟭    Platinum   29       14875     ⟬date#3⟭      10    low
⟬customer_id#6⟭    Gold       26       9320      ⟬date#3⟭      7     medium
⟬customer_id#7⟭    Gold       22       8740      ⟬date#4⟭      9     low
⟬customer_id#8⟭    Gold       19       8015      ⟬date#4⟭      6     high
⟬customer_id#9⟭    Gold       18       7460      ⟬date#5⟭      8     low
⟬customer_id#10⟭   Silver     15       5290      ⟬date#5⟭      7     medium
⟬customer_id#11⟭   Silver     14       4985      ⟬date#6⟭      9     low
⟬customer_id#12⟭   Silver     12       4410      ⟬date#6⟭      5     high
⟬customer_id#13⟭   Silver     11       3905      ⟬date#7⟭      8     medium
TOTAL              11         -        -         -             -     -

⟬customer_id#1⟭    ⟬person_name#1⟭    ⟬postal_address#1⟭    ⟬birth_date#1⟭    ⟬us_driver_license#1⟭
⟬customer_id#2⟭    ⟬person_name#2⟭    ⟬postal_address#2⟭    ⟬birth_date#2⟭    ⟬us_driver_license#2⟭
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: SaaS
appearance: csv cell, inline key and value
scenario: churned accounts, cleaned up before a mail merge
⟬text⟭
"account_id","plan","churned_on","mrr_lost_eur","salutation","routing","note"
"⟬customer_id#1⟭","Scale","⟬date#2⟭",1290,"Bonjour ⟬trap:indicator_non_pii|à tous⟭","owner: ⟬trap:indicator_non_pii|csm-pool⟭","contact=⟬trap:indicator_non_pii|none⟭"
"⟬customer_id#2⟭","Team","⟬date#2⟭",240,"Bonjour ⟬trap:indicator_non_pii|à tous⟭","owner: ⟬trap:indicator_non_pii|csm-pool⟭","email=⟬trap:indicator_non_pii|removed⟭"
"⟬customer_id#3⟭","Team","⟬date#3⟭",180,"Dear ⟬trap:indicator_non_pii|customer⟭","owner: ⟬trap:indicator_non_pii|emea-renewals⟭","contact=⟬trap:indicator_non_pii|none⟭"
"⟬customer_id#4⟭","Scale","⟬date#3⟭",2150,"Bonjour ⟬trap:indicator_non_pii|à tous⟭","owner: ⟬trap:indicator_non_pii|key-accounts⟭","merge ref ⟬uuid#1⟭"
"⟬customer_id#5⟭","Starter","⟬date#4⟭",49,"Dear ⟬trap:indicator_non_pii|customer⟭","owner: ⟬trap:indicator_non_pii|self-serve⟭","email=⟬trap:indicator_non_pii|removed⟭"
"⟬customer_id#6⟭","Team","⟬date#5⟭",320,"Bonjour ⟬trap:indicator_non_pii|à tous⟭","owner: ⟬trap:indicator_non_pii|emea-renewals⟭","merge ref ⟬uuid#2⟭"
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: mixed
fill_locale: mixed
domain: SaaS
appearance: csv cell, last column, neutral column
scenario: API key inventory, sampled for a test environment
⟬text⟭
"key_id","workspace","scope","created","last_used","env","m","val"
"kid_0091","⟬uuid#1⟭","read:usage","⟬date#6⟭","⟬date#1⟭","test",1,"⟬opaque_token#1⟭"
"kid_0092","⟬uuid#1⟭","write:events","⟬date#6⟭","⟬date#2⟭","test",2,"⟬password#2⟭"
"kid_0093","⟬uuid#2⟭","admin","⟬date#5⟭","⟬date#2⟭","test",3,"⟬phone#3⟭"
"kid_0094","⟬uuid#2⟭","read:usage","⟬date#5⟭","","test",1,"⟬trap:placeholder|****⟭"
"kid_0095","⟬uuid#3⟭","read:billing","⟬date#5⟭","⟬date#3⟭","test",1,"⟬opaque_token#5⟭"
"kid_0096","⟬uuid#3⟭","write:events","⟬date#5⟭","⟬date#1⟭","test",1,"⟬opaque_token#6⟭"
"kid_0097","⟬uuid#3⟭","admin","⟬date#4⟭","","test",2,"⟬trap:placeholder|<rotated>⟭"
"kid_0098","⟬uuid#4⟭","read:usage","⟬date#4⟭","⟬date#2⟭","test",1,"⟬opaque_token#8⟭"
"kid_0099","⟬uuid#4⟭","read:audit","⟬date#4⟭","⟬date#3⟭","test",2,"⟬password#9⟭"
"kid_0100","⟬uuid#5⟭","write:events","⟬date#4⟭","⟬date#3⟭","test",1,"⟬opaque_token#10⟭"
"kid_0101","⟬uuid#5⟭","admin","⟬date#3⟭","⟬date#1⟭","test",3,"⟬phone#11⟭"
"kid_0102","⟬uuid#6⟭","read:usage","⟬date#3⟭","","test",1,"⟬trap:placeholder|xxxx⟭"
"kid_0103","⟬uuid#6⟭","read:billing","⟬date#3⟭","⟬date#2⟭","test",1,"⟬opaque_token#13⟭"
"kid_0104","⟬uuid#7⟭","write:events","⟬date#3⟭","⟬date#2⟭","test",2,"⟬password#14⟭"
"kid_0105","⟬uuid#7⟭","read:usage","⟬date#2⟭","⟬date#1⟭","test",1,"⟬opaque_token#15⟭"
"kid_0106","⟬uuid#8⟭","admin","⟬date#2⟭","⟬date#1⟭","test",1,"⟬opaque_token#16⟭"
"kid_0107","⟬uuid#8⟭","read:audit","⟬date#2⟭","","test",1,"⟬trap:placeholder|${TEST_KEY}⟭"
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: insurance
appearance: sql comment, sql insert
scenario: premium arrears, merged from two sources
⟬text⟭
-- ⟬email#1⟭ ⟬date#1⟭ : arrears_core + arrears_legacy, doublons retirés à la main
BEGIN;
CREATE TABLE IF NOT EXISTS premium_arrears (
  policy_no varchar(14) PRIMARY KEY,
  origin char(4) NOT NULL,
  due_on date NOT NULL,
  arrears_eur numeric(9,2) NOT NULL,
  dunning_stage smallint DEFAULT 0
);
INSERT INTO premium_arrears VALUES
 ('PH-7741002','CORE','⟬date#3⟭',218.40,1),
 ('PH-7741019','LEGA','⟬date#3⟭',96.00,1),
 ('PH-7741043','CORE','⟬date#2⟭',1240.15,2);
COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: dataframe printout, neutral column, few rows filled
scenario: marketplace payouts, requested by a regulator
⟬text⟭
>>> # réponse à la demande du régulateur, reversements vendeurs T2
>>> print(payouts.sort_values("seller_id").to_string())
    seller_id   period  gross_eur  fee_eur  net_eur  status                   col_h                   col_i
0     S-20418  2026-04   12480.50   998.44 11482.06    paid                     NaN                     NaN
1     S-20418  2026-05   11790.00   943.20 10846.80    paid                     NaN                     NaN
2     S-20433  2026-04    2315.75   185.26  2130.49    paid       ⟬person_name#1⟭       ⟬fr_postal_address#1⟭
3     S-20433  2026-05    1980.10   158.41  1821.69    paid       ⟬person_name#1⟭       ⟬fr_postal_address#1⟭
4     S-20447  2026-04   40215.00  3217.20 36997.80    paid                     NaN                     NaN
5     S-20447  2026-05   38760.40  3100.83 35659.57    held                     NaN                     NaN
6     S-20452  2026-04     640.00    51.20   588.80    paid       ⟬person_name#2⟭       ⟬fr_postal_address#2⟭
7     S-20461  2026-04    8120.90   649.67  7471.23    paid                     NaN                     NaN
8     S-20461  2026-05    7905.30   632.42  7272.88    paid                     NaN                     NaN
9     S-20470  2026-05    1215.60    97.25  1118.35    paid       ⟬person_name#3⟭       ⟬fr_postal_address#3⟭
10    S-20488  2026-04   22600.00  1808.00 20792.00    paid                     NaN                     NaN
11    S-20488  2026-05   24110.25  1928.82 22181.43    paid                     NaN                     NaN
12    S-20495  2026-04     305.80    24.46   281.34    held                     NaN                     NaN
13    S-20502  2026-05   15940.00  1275.20 14664.80    paid                     NaN                     NaN
>>> payouts["net_eur"].sum().round(2)
173309.24
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: travel
appearance: multi-row sql insert, neutral column, sql comment
scenario: passenger manifest, used to debug an import
⟬text⟭
-- MySQL dump 10.13  Distrib ⟬version#1⟭, for Linux (x86_64)
--
-- Host: ⟬hostname#1⟭    Database: dcs_manifest
-- ------------------------------------------------------
/*!40101 SET NAMES utf8mb4 */;

-- rejeu de l'import : la ligne 4 casse sur ext_3, les autres passent

DROP TABLE IF EXISTS `pax_manifest`;
CREATE TABLE `pax_manifest` (
  `leg_id` int NOT NULL,
  `flight_no` varchar(8) NOT NULL,
  `seat` varchar(4) DEFAULT NULL,
  `cabin` char(1) DEFAULT 'Y',
  `ext_1` varchar(120) DEFAULT NULL,
  `ext_2` varchar(16) DEFAULT NULL,
  `ext_3` varchar(16) DEFAULT NULL,
  `boarded` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `pax_manifest` WRITE;
INSERT INTO `pax_manifest` VALUES
(1,'AF0083','12A','Y','⟬email#1⟭','⟬us_passport#1⟭','⟬us_itin#1⟭',1),
(2,'AF0083','12B','Y','⟬email#2⟭','⟬us_passport#2⟭','⟬us_itin#2⟭',1),
(3,'AF0083','3C','J','⟬email#3⟭','⟬us_passport#3⟭',NULL,1),
(4,'AF0083','27F','Y','⟬email#4⟭','⟬us_passport#4⟭','⟬us_itin#4⟭',0),
(5,'DL0264','18D','Y','⟬email#5⟭','⟬us_passport#5⟭',NULL,1),
(6,'DL0264','18E','Y','⟬email#6⟭','⟬us_passport#6⟭','⟬us_itin#6⟭',1),
(7,'DL0264','41A','Y',NULL,'⟬us_passport#7⟭',NULL,0),
(8,'BA0304','5A','J','⟬email#8⟭','⟬us_passport#8⟭','⟬us_itin#8⟭',1);
UNLOCK TABLES;
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: mixed
fill_locale: mixed
domain: insurance
appearance: label and value, tab separated cell
scenario: medical cover members, kept as a manual backup
⟬text⟭
Couverture santé collective, sauvegarde manuelle de l'onglet Résumé (⟬date#1⟭)
Contact: ⟬trap:indicator_non_pii|Service Adhésions⟭
Name: ⟬trap:indicator_non_pii|Direction Actuariat⟭
Email: ⟬trap:indicator_non_pii|non renseigné⟭
Phone: ⟬trap:indicator_non_pii|sans objet⟭

dept	plan	members	active	suspended
Actuariat	Essentiel	42	40	2
Sinistres	Confort	118	111	7
Finance	Confort	36	36	0
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: mixed
fill_locale: mixed
domain: travel
appearance: sql comment, sql insert, T-SQL script
scenario: flight bookings, shared with a manager for a meeting
⟬text⟭
-- FlightBookings, script préparé pour le point de jeudi
-- ⟬email#1⟭ | ⟬fr_postal_address#1⟭ | Europe/Paris | EUR
USE [TravelOps]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlightBookings](
	[BookingId] [int] NOT NULL,
	[Pnr] [char](6) NOT NULL,
	[Route] [varchar](7) NOT NULL,
	[DepartureDate] [date] NOT NULL,
	[Cabin] [char](1) NULL,
	[FareEur] [decimal](10, 2) NULL,
	[Status] [nvarchar](16) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[FlightBookings] VALUES (50231, N'QX4T7B', N'CDG-JFK', '⟬date#1⟭', N'Y', 642.10, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50232, N'HL9M2R', N'ORY-LIS', '⟬date#1⟭', N'Y', 118.40, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50233, N'ZP3K8D', N'CDG-SIN', '⟬date#2⟭', N'J', 3180.00, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50234, N'BW7C1N', N'LHR-CDG', '⟬date#2⟭', N'Y', 96.75, N'VOID')
INSERT [dbo].[FlightBookings] VALUES (50235, N'TR2F6G', N'NCE-AMS', '⟬date#2⟭', N'Y', 154.20, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50236, N'MK5V9S', N'CDG-YUL', '⟬date#3⟭', N'W', 1022.60, N'HOLD')
GO
INSERT [dbo].[FlightBookings] VALUES (50237, N'DX8J4P', N'LYS-CMN', '⟬date#3⟭', N'Y', 231.15, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50238, N'NF1Q7L', N'CDG-DXB', '⟬date#3⟭', N'J', 2790.00, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50239, N'GS6T3H', N'BOD-BRU', '⟬date#4⟭', N'Y', 88.30, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50240, N'VA4Y2C', N'ORY-FDF', '⟬date#4⟭', N'Y', 612.45, N'REFUNDED')
INSERT [dbo].[FlightBookings] VALUES (50241, N'RJ9E5K', N'CDG-LAX', '⟬date#4⟭', N'W', 1188.00, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50242, N'CU3N8W', N'MRS-ATH', '⟬date#5⟭', N'Y', 203.90, N'TICKETED')
GO
INSERT [dbo].[FlightBookings] VALUES (50243, N'PL7B6Z', N'CDG-NRT', '⟬date#5⟭', N'J', 3425.50, N'HOLD')
INSERT [dbo].[FlightBookings] VALUES (50244, N'EM2H9X', N'TLS-MAD', '⟬date#5⟭', N'Y', 97.00, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50245, N'WQ5D1V', N'CDG-GRU', '⟬date#6⟭', N'Y', 874.25, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50246, N'KT8R3A', N'NTE-DUB', '⟬date#6⟭', N'Y', 142.80, N'VOID')
INSERT [dbo].[FlightBookings] VALUES (50247, N'YC4G7M', N'CDG-CPT', '⟬date#6⟭', N'J', 2615.00, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50248, N'SH1W6F', N'ORY-RUN', '⟬date#7⟭', N'Y', 769.35, N'TICKETED')
GO
INSERT [dbo].[FlightBookings] VALUES (50249, N'UB9L2T', N'BSL-OPO', '⟬date#7⟭', N'Y', 126.10, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50250, N'JN6P4E', N'CDG-MIA', '⟬date#7⟭', N'W', 1094.70, N'REFUNDED')
INSERT [dbo].[FlightBookings] VALUES (50251, N'FZ3S8Q', N'NCE-LHR', '⟬date#8⟭', N'Y', 139.55, N'TICKETED')
INSERT [dbo].[FlightBookings] VALUES (50252, N'AD7K5J', N'CDG-BKK', '⟬date#8⟭', N'J', 2980.00, N'TICKETED')
GO
SELECT [Status], COUNT(*) AS Bookings, SUM([FareEur]) AS FareTotal FROM [dbo].[FlightBookings] GROUP BY [Status]
GO
⟬end⟭
