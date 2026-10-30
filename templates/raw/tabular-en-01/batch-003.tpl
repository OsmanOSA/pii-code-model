⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: retail
appearance: csv cell, middle column, sort code beside account
scenario: gift card sales, requested by a regulator
⟬text⟭
"sale_ref","store","cards_sold","face_value","sort_code","account_no","iban","settle_on","status"
"GC-5501","Ashby",12,300.00,"20-45-17","⟬bank_account_number#1⟭","⟬iban#1⟭","⟬date#5⟭","settled"
"GC-5502","Barton",7,175.00,"20-45-17","⟬bank_account_number#2⟭","⟬iban#2⟭","⟬date#4⟭","settled"
"GC-5503","Colby",20,500.00,"40-16-08","⟬bank_account_number#3⟭","⟬iban#3⟭","⟬date#3⟭","settled"
"GC-5504","Denham",5,125.00,"40-16-08","⟬bank_account_number#4⟭","⟬iban#4⟭","⟬date#2⟭","held"
"GC-5505","Ashby",15,375.00,"20-45-17","⟬bank_account_number#1⟭","⟬iban#1⟭","⟬date#1⟭","pending"
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: en
fill_locale: en_GB
domain: education
appearance: temp table, last column, contact cell
scenario: governors' meeting attendance, requested by a regulator
⟬text⟭
-- Governing body attendance for the inspection evidence folder
-- run as user=⟬trap:indicator_non_pii|clerk_readonly⟭
BEGIN;

CREATE TEMP TABLE gb_attendance (
  gov_ref   text,
  meeting   text,
  met_on    date,
  attended  boolean,
  contact   text
);

INSERT INTO gb_attendance VALUES
  ('G-01', 'Full governing body', '⟬date#3⟭', true,  '⟬person_name#1⟭ <⟬email#1⟭> tel ⟬phone#1⟭'),
  ('G-02', 'Full governing body', '⟬date#3⟭', true,  '⟬person_name#2⟭ <⟬email#2⟭> tel ⟬phone#2⟭'),
  ('G-03', 'Full governing body', '⟬date#3⟭', false, '⟬person_name#3⟭ <⟬email#3⟭>'),
  ('G-04', 'Full governing body', '⟬date#3⟭', true,  '⟬person_name#4⟭ <⟬email#4⟭> mob ⟬phone#4⟭'),
  ('G-01', 'Finance committee', '⟬date#2⟭', true,  '⟬person_name#1⟭ <⟬email#1⟭> tel ⟬phone#1⟭'),
  ('G-05', 'Finance committee', '⟬date#2⟭', true,  '⟬person_name#5⟭ <⟬email#5⟭> tel ⟬phone#5⟭'),
  ('G-06', 'Finance committee', '⟬date#2⟭', false, '⟬person_name#6⟭ <⟬email#6⟭> mob ⟬phone#6⟭'),
  ('G-02', 'Curriculum committee', '⟬date#1⟭', true,  '⟬person_name#2⟭ <⟬email#2⟭> tel ⟬phone#2⟭'),
  ('G-04', 'Curriculum committee', '⟬date#1⟭', true,  '⟬person_name#4⟭ <⟬email#4⟭> mob ⟬phone#4⟭'),
  ('G-07', 'Curriculum committee', '⟬date#1⟭', true,  '⟬person_name#7⟭ <⟬email#7⟭> tel ⟬phone#7⟭');

SELECT meeting, count(*) FILTER (WHERE attended) AS present, count(*) AS invited
FROM gb_attendance GROUP BY meeting ORDER BY meeting;

COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: healthcare
appearance: tsv cell, labelled rows, figures only
scenario: bed occupancy, sent to an outside accountant
⟬text⟭
prepared_by	⟬trap:indicator_non_pii|Finance BI⟭					
contact	⟬trap:indicator_non_pii|Information Team⟭					
ward	beds	available	occupied	occupancy_pct	escalation	cost_centre
Ward 1	28	28	26	92.9	no	CC4101
Ward 2	28	26	26	100.0	yes	CC4102
Ward 3	24	24	21	87.5	no	CC4103
Ward 4	24	24	22	91.7	no	CC4104
⟬trap:eponym|⦃Family⦄ Ward⟭	18	18	15	83.3	no	CC4110
⟬trap:eponym|⦃Family2⦄ Ward⟭	18	16	16	100.0	yes	CC4111
Stroke Unit	20	20	19	95.0	no	CC4120
Coronary Care	12	12	10	83.3	no	CC4121
ICU	14	14	12	85.7	no	CC4130
High Dependency	8	8	7	87.5	no	CC4131
Maternity	30	30	22	73.3	no	CC4140
Neonatal	16	16	11	68.8	no	CC4141
Paediatrics	22	22	14	63.6	no	CC4150
Day Surgery	18	18	9	50.0	no	CC4160
Total	278	276	230	83.3		
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: en
fill_locale: en_GB
domain: charities
appearance: pg_dump inserts, neutral columns, closing control row
scenario: grant applications, sampled for a test environment
⟬text⟭
--
-- Sample of the grants portal, pg_dump --inserts, for the staging restore
--

SET search_path = public;

CREATE TABLE grant_application (
    app_id integer PRIMARY KEY,
    fund text NOT NULL,
    org_type text,
    requested numeric(10,2),
    awarded numeric(10,2),
    stage text,
    decided_on date,
    x1 text,
    x2 text
);

INSERT INTO grant_application VALUES (4101, 'Small Grants', 'CIO', 2500.00, 2500.00, 'paid', '⟬date#9⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4102, 'Small Grants', 'CIC', 1800.00, 1500.00, 'paid', '⟬date#9⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4103, 'Small Grants', 'Unincorporated', 950.00, 0.00, 'declined', '⟬date#9⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4104, 'Small Grants', 'CIO', 3000.00, 3000.00, 'paid', '⟬date#8⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4105, 'Community Spaces', 'Parish Council', 12000.00, 10000.00, 'paid', '⟬date#8⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4106, 'Community Spaces', 'CIO', 8500.00, 0.00, 'declined', '⟬date#8⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4107, 'Community Spaces', 'CIC', 15000.00, 12500.00, 'paid', '⟬date#7⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4108, 'Community Spaces', 'Charitable Company', 9800.00, 9800.00, 'paid', '⟬date#7⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4109, 'Warm Homes', 'CIO', 4000.00, 4000.00, 'paid', '⟬date#7⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4110, 'Warm Homes', 'Unincorporated', 1200.00, 1200.00, 'paid', '⟬date#6⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4111, 'Warm Homes', 'CIC', 2750.00, 0.00, 'withdrawn', '⟬date#6⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4112, 'Warm Homes', 'CIO', 3600.00, 3000.00, 'paid', '⟬date#6⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4113, 'Youth Futures', 'CIO', 6200.00, 6200.00, 'paid', '⟬date#5⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4114, 'Youth Futures', 'Charitable Company', 7400.00, 5000.00, 'paid', '⟬date#5⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4115, 'Youth Futures', 'CIC', 5100.00, 0.00, 'declined', '⟬date#5⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4116, 'Youth Futures', 'Unincorporated', 900.00, 900.00, 'paid', '⟬date#4⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4117, 'Green Spaces', 'Parish Council', 4300.00, 4300.00, 'paid', '⟬date#4⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4118, 'Green Spaces', 'CIO', 2200.00, 2000.00, 'paid', '⟬date#4⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4119, 'Green Spaces', 'CIC', 3300.00, 0.00, 'pending', NULL, NULL, NULL);
INSERT INTO grant_application VALUES (4120, 'Green Spaces', 'CIO', 2600.00, 0.00, 'pending', NULL, NULL, NULL);
INSERT INTO grant_application VALUES (4121, 'Small Grants', 'CIC', 1400.00, 1400.00, 'paid', '⟬date#3⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4122, 'Small Grants', 'CIO', 2100.00, 2100.00, 'paid', '⟬date#3⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4123, 'Small Grants', 'Unincorporated', 700.00, 500.00, 'paid', '⟬date#2⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4124, 'Warm Homes', 'CIO', 3900.00, 3900.00, 'paid', '⟬date#2⟭', NULL, NULL);
INSERT INTO grant_application VALUES (4125, 'Community Spaces', 'CIO', 11000.00, 0.00, 'pending', NULL, NULL, NULL);
INSERT INTO grant_application VALUES (9999, 'Payment run', 'control', NULL, 73800.00, 'closed', '⟬date#1⟭', '⟬iban#1⟭', '⟬card_security_code#1⟭');
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: housing
appearance: tsv cell, note row above table, office address
scenario: waiting list, shared with a manager for a meeting
⟬text⟭
Viewings run from the lettings office, address ⟬postal_address#1⟭, keys to be signed out before the visit					
band	bedrooms	households	longest_wait_wk	next_viewing	patch
A	1	14	22	⟬date#3⟭	North
A	2	9	31	⟬date#3⟭	North
B	2	37	64	⟬date#2⟭	East
B	3	21	88	⟬date#2⟭	East
C	1	52	103	⟬date#1⟭	⟬city#1⟭
C	4	6	140	⟬date#1⟭	⟬city#1⟭
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: payroll
appearance: tsv cell, last column, onboarding details, sort code beside account
scenario: monthly overtime claims, sent to an outside accountant
⟬text⟭
claim	emp_ref	hours	rate	gross	onboarding_sheet
OT-7711	E10442	12.5	18.40	230.00	
OT-7712	E10451	6	18.40	110.40	
OT-7718	E20611	21	16.75	351.75	new starter: ⟬person_name#1⟭; NI ⟬uk_national_insurance_number#1⟭; lives at ⟬postal_address#1⟭; sort code 20-18-44, account no ⟬bank_account_number#1⟭
OT-7720	E10473	4.5	24.10	108.45	
OT-7723	E20634	9	16.75	150.75	new starter: ⟬person_name#2⟭; NI ⟬uk_national_insurance_number#2⟭; lives at ⟬postal_address#2⟭; sort code 09-01-29, account no ⟬bank_account_number#2⟭
OT-7726	E10496	15	21.30	319.50	
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: en
fill_locale: en_GB
domain: payroll
appearance: markdown table, first column, postal address cell
scenario: statutory sick pay, used to debug an import
⟬text⟭
### SSP import: rows that failed, for the debug session

Owner: ⟬trap:indicator_non_pii|Payroll Systems⟭

SSP1 letters go out by post, so the import wants a full delivery line first. Rows 3, 7 and 11 broke on the address parser.

| Post SSP1 to | Emp | PIW from | QDs | Exclusion | Import |
| --- | --- | --- | --- | --- | --- |
| ⟬person_name#1⟭, ⟬postal_address#1⟭ | 100442 | ⟬date#8⟭ | 5 | none | ok |
| ⟬person_name#2⟭, ⟬postal_address#2⟭, tel ⟬phone#2⟭ | 100451 | ⟬date#8⟭ | 3 | none | ok |
| ⟬person_name#3⟭ ⟬postal_address#3⟭ | 100460 | ⟬date#7⟭ | 10 | none | failed |
| ⟬person_name#4⟭, ⟬postal_address#4⟭ | 100467 | ⟬date#7⟭ | 2 | none | ok |
| ⟬person_name#5⟭, ⟬postal_address#5⟭, tel ⟬phone#5⟭ | 100473 | ⟬date#6⟭ | 15 | 28 weeks | ok |
| ⟬person_name#6⟭, ⟬postal_address#6⟭ | 100479 | ⟬date#6⟭ | 5 | none | ok |
| ⟬person_name#7⟭, ⟬postal_address#7⟭, mob ⟬phone#7⟭ | 100488 | ⟬date#5⟭ | 8 | none | failed |
| ⟬person_name#8⟭, ⟬postal_address#8⟭ | 100490 | ⟬date#4⟭ | 4 | none | ok |
| ⟬person_name#9⟭, ⟬postal_address#9⟭ | 100496 | ⟬date#3⟭ | 0 | low earnings | ok |
| ⟬person_name#10⟭, ⟬postal_address#10⟭, tel ⟬phone#10⟭ | 100502 | ⟬date#3⟭ | 7 | none | ok |
| ⟬person_name#11⟭ ⟬postal_address#11⟭ | 100509 | ⟬date#2⟭ | 12 | none | failed |
| ⟬person_name#12⟭, ⟬postal_address#12⟭ | 100515 | ⟬date#1⟭ | 5 | none | ok |
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: en
fill_locale: en_GB
domain: housing
appearance: markdown table, technical identifiers, figures only
scenario: rent arrears, exported for a quarterly audit
⟬text⟭
# Arrears batches, quarterly audit

| batch_uuid | job_ref | patch | accounts | arrears_total | checksum |
| --- | --- | --- | --- | --- | --- |
| ⟬uuid#1⟭ | ⟬order_number#1⟭ | North | 214 | 58230.15 | ⟬hash#1⟭ |
| ⟬uuid#2⟭ | ⟬order_number#2⟭ | ⟬trap:word_name|⦃Family⦄ Park⟭ | 96 | 21477.60 | ⟬hash#2⟭ |
| ⟬uuid#3⟭ | ⟬order_number#3⟭ | Town Centre | 171 | 44902.05 | ⟬hash#3⟭ |
| ⟬uuid#4⟭ | ⟬order_number#4⟭ | Riverside | 133 | 30118.90 | ⟬hash#4⟭ |

Run on ⟬date#1⟭ from ⟬hostname#1⟭, build ⟬git_sha#1⟭.
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: en
fill_locale: en_GB
domain: education
appearance: update statement, free-text comment cell, stored procedure call
scenario: staff training records, cleaned up before a mail merge
⟬text⟭
-- Tidy the note column by hand before the certificate letters are merged
START TRANSACTION;

UPDATE staff_training SET note = 'Trainer: ⟬person_name#1⟭, certificate to follow' WHERE course_id = 'CP-12' AND cohort = 3;
UPDATE staff_training SET note = 'Run by Mrs ⟬person_name#2f⟭ for the science team' WHERE course_id = 'CP-14' AND cohort = 1;
UPDATE staff_training SET note = NULL WHERE course_id = 'CP-15';
UPDATE staff_training SET note = 'Rebooked, was off sick' WHERE course_id = 'CP-17' AND cohort = 2;
UPDATE staff_training SET note = 'Signed off by Mr ⟬person_name#3m⟭' WHERE course_id = 'CP-18' AND cohort = 1;
UPDATE staff_training SET note = 'External, see ⟬trap:company_name|⦃Family⦄ Safety Services⟭ invoice' WHERE course_id = 'CP-20';
UPDATE staff_training SET note = 'Mentor: ⟬person_name#4⟭' WHERE course_id = 'CP-19' AND cohort = 2;
UPDATE staff_training SET note = NULL WHERE note = 'tbc';
UPDATE staff_training SET completed_on = '⟬date#1⟭' WHERE course_id = 'CP-24' AND completed_on IS NULL;
DELETE FROM staff_training WHERE course_id = 'CP-99';

CALL ⟬trap:code_identifier|sp_⦃family⦄_cpd_hours⟭(3);
SELECT course_id, count(*) FROM staff_training WHERE note IS NOT NULL GROUP BY course_id;

COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: charities
appearance: headerless extract, first column, tsv cell
scenario: food bank parcels, kept as a manual backup
⟬text⟭
⟬person_name#1⟭	⟬phone#1⟭	2 adults	medium	⟬date#3⟭	collected
⟬person_name#2⟭	⟬phone#2⟭	1 adult 3 children	large	⟬date#3⟭	collected
⟬person_name#3⟭		1 adult	small	⟬date#2⟭	no show
⟬person_name#4⟭	⟬phone#4⟭	2 adults 1 child	medium	⟬date#2⟭	collected
⟬person_name#5⟭	⟬phone#5⟭	1 adult	small	⟬date#1⟭	delivered
⟬person_name#6⟭	⟬phone#6⟭	2 adults 2 children	large	⟬date#1⟭	collected
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: en
fill_locale: en_GB
domain: healthcare
appearance: replace into, labelled comment, view with function call
scenario: agency staff shifts, compared with last month
⟬text⟭
-- agency_summary.sql: hours per agency and ward, this month against last
-- Contact: ⟬trap:indicator_non_pii|Temporary Staffing Office⟭
-- Data owner: ⟬trap:indicator_non_pii|Workforce Information⟭
CREATE TABLE IF NOT EXISTS agency_summary (
  agency varchar(60) NOT NULL,
  ward varchar(40) NOT NULL,
  hours_now decimal(7,2),
  hours_prev decimal(7,2),
  spend_now decimal(9,2),
  PRIMARY KEY (agency, ward)
);

REPLACE INTO agency_summary VALUES
('⟬trap:company_name|⦃Family⦄ Nursing Agency⟭', 'Ward 9', 412.50, 388.00, 16087.50),
('⟬trap:company_name|⦃Family⦄ Nursing Agency⟭', 'ICU', 230.00, 276.00, 11500.00),
('⟬trap:company_name|⦃Family2⦄ Healthcare Ltd⟭', 'Ward 4', 188.50, 164.00, 6032.00),
('⟬trap:company_name|⦃Family2⦄ Healthcare Ltd⟭', 'A&E', 301.00, 345.50, 11739.00),
('⟬company#1⟭', 'Theatres', 96.00, 120.00, 5760.00),
('⟬company#1⟭', '⟬trap:eponym|⦃Family3⦄ Ward⟭', 144.00, 132.00, 5040.00),
('⟬trap:company_name|⦃Family3⦄ & Partners Locums⟭', 'Ward 11', 72.00, 60.00, 3960.00);

CREATE VIEW agency_capped AS
  SELECT agency, ward, ⟬trap:code_identifier|fn_⦃family4⦄_rate_cap⟭(spend_now, hours_now) AS capped
  FROM agency_summary;
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: payroll
appearance: tsv cell, free-text comment cell, ticket reference
scenario: holiday balances, attached to a ticket
⟬text⟭
emp_ref	dept	entitlement	taken	balance	remark
E10442	Warehouse	28	11.5	16.5	
E10460	Transport	25	9	16	carry-over query, contact ⟬person_name#1⟭ in Payroll
E10473	Finance	30	14	16	
E10488	Customer Care	27	18	9	see ⟬ticket_id#1⟭, contact ⟬person_name#2⟭
E10502	IT	28	16	12	
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: retail
appearance: tsv cell, footer rows, sort code beside account
scenario: returned goods, merged from two sources
⟬text⟭
rma	order	sku	reason	refund	source
R-40112	⟬order_number#1⟭	SKU-31907	damaged	18.00	Web
R-40118	⟬order_number#2⟭	SKU-20418	wrong item	1.85	Web
R-40127	⟬order_number#3⟭	SKU-40116	changed mind	6.50	Store
R-40131	⟬order_number#4⟭	SKU-27710	faulty	1.20	Store
R-40136	⟬order_number#5⟭	SKU-31907	wrong size	18.00	Web
R-40140	⟬order_number#6⟭	SKU-40120	damaged	6.50	Web
R-40145	⟬order_number#7⟭	SKU-20422	out of date	3.40	Store
R-40149	⟬order_number#8⟭	SKU-31907	wrong size	18.00	Store
R-40153	⟬order_number#9⟭	SKU-40116	changed mind	6.50	Web
R-40158	⟬order_number#10⟭	SKU-27710	faulty	1.20	Web
R-40162	⟬order_number#11⟭	SKU-20418	wrong item	1.85	Store
R-40167	⟬order_number#12⟭	SKU-40120	changed mind	6.50	Store
R-40171	⟬order_number#13⟭	SKU-31907	damaged	18.00	Web
R-40176	⟬order_number#14⟭	SKU-20422	out of date	3.40	Web
Total				110.90	
Prepared by	⟬trap:indicator_non_pii|Returns Desk⟭				
Refund shortfall to supplier account	sort code 40-11-60	account no ⟬bank_account_number#1⟭	statement to ⟬postal_address#1⟭		
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: healthcare
appearance: tsv cell, figures only
scenario: clinic appointment list, prepared for a migration to a new tool
⟬text⟭
old_code	new_code	sessions_pw	slots	mins	room
ORTH1	OP-101	5	55	15	Orthopaedics
EYE2	OP-214	7	84	10	Eye Unit
⟬trap:code_identifier|DOPPLER3⟭	OP-316	3	27	20	Vascular Lab
RESP4	OP-402	4	44	15	Respiratory
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: en
fill_locale: en_GB
domain: education
appearance: markdown table, free-text comment cell
scenario: governors' meeting attendance, sampled for a test environment
⟬text⟭
| Ref | Role | Meeting | Held | Present | Remark |
| --- | --- | --- | --- | --- | --- |
| G-01 | Chair | FGB | ⟬date#6⟭ | Y | |
| G-02 | Vice | FGB | ⟬date#6⟭ | Y | |
| G-03 | Parent | FGB | ⟬date#6⟭ | N | apologies came through ⟬person_name#1⟭ the day before |
| G-04 | Staff | FGB | ⟬date#6⟭ | Y | |
| G-05 | Co-opted | FGB | ⟬date#6⟭ | Y | |
| G-06 | LA | FGB | ⟬date#6⟭ | N | |
| G-07 | Parent | FGB | ⟬date#6⟭ | Y | |
| G-01 | Chair | Finance | ⟬date#5⟭ | Y | |
| G-05 | Co-opted | Finance | ⟬date#5⟭ | Y | |
| G-06 | LA | Finance | ⟬date#5⟭ | Y | |
| G-02 | Vice | Finance | ⟬date#5⟭ | N | |
| G-02 | Vice | Curriculum | ⟬date#5⟭ | Y | |
| G-04 | Staff | Curriculum | ⟬date#5⟭ | Y | |
| G-07 | Parent | Curriculum | ⟬date#5⟭ | N | swapped with ⟬person_name#2⟭ for this one |
| G-03 | Parent | Curriculum | ⟬date#5⟭ | Y | |
| G-01 | Chair | FGB | ⟬date#4⟭ | Y | |
| G-02 | Vice | FGB | ⟬date#4⟭ | Y | |
| G-03 | Parent | FGB | ⟬date#4⟭ | Y | |
| G-04 | Staff | FGB | ⟬date#4⟭ | N | |
| G-05 | Co-opted | FGB | ⟬date#4⟭ | Y | |
| G-06 | LA | FGB | ⟬date#4⟭ | Y | |
| G-07 | Parent | FGB | ⟬date#4⟭ | Y | clerk covered by ⟬person_name#3⟭ |
| G-01 | Chair | Finance | ⟬date#3⟭ | Y | |
| G-05 | Co-opted | Finance | ⟬date#3⟭ | N | |
| G-06 | LA | Finance | ⟬date#3⟭ | Y | |
| G-02 | Vice | Finance | ⟬date#3⟭ | Y | |
| G-02 | Vice | Curriculum | ⟬date#3⟭ | Y | |
| G-04 | Staff | Curriculum | ⟬date#3⟭ | Y | |
| G-07 | Parent | Curriculum | ⟬date#3⟭ | Y | |
| G-03 | Parent | Curriculum | ⟬date#3⟭ | N | |
| G-01 | Chair | FGB | ⟬date#2⟭ | Y | |
| G-02 | Vice | FGB | ⟬date#2⟭ | N | term of office ended, ⟬person_name#4⟭ steps in |
| G-03 | Parent | FGB | ⟬date#2⟭ | Y | |
| G-04 | Staff | FGB | ⟬date#2⟭ | Y | |
| G-05 | Co-opted | FGB | ⟬date#2⟭ | Y | |
| G-06 | LA | FGB | ⟬date#2⟭ | Y | |
| G-07 | Parent | FGB | ⟬date#2⟭ | N | |
| G-01 | Chair | Finance | ⟬date#1⟭ | Y | |
| G-05 | Co-opted | Finance | ⟬date#1⟭ | Y | |
| G-06 | LA | Finance | ⟬date#1⟭ | Y | |
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: en
fill_locale: en_GB
domain: payroll
appearance: slash-separated rows, neutral header, row markers
scenario: bonus run, cleaned up before a mail merge
⟬text⟭
[bonus_letters_data] row / key / grade / bonus / letter / Ref B
R002 / K10442 / G3 / 1406.25 / Y / ⟬iban#1⟭
R003 / K10451 / G3 / 1341.00 / Y / ⟬iban#2⟭
R004 / K10460 / G4 / 1805.00 / Y / ⟬iban#3⟭
R005 / K10467 / G4 / 1922.50 / Y / ⟬iban#4⟭
R006 / K10473 / G5 / 2652.00 / Y / ⟬iban#5⟭
R007 / K10479 / G5 / 2805.00 / N /
R008 / K10488 / G2 / 792.00 / Y / ⟬iban#6⟭
R009 / K10490 / G2 / 777.00 / Y / ⟬iban#7⟭
R010 / K10496 / G6 / 4664.00 / Y / ⟬iban#8⟭
R011 / K10502 / G6 / 4896.00 / Y / ⟬iban#9⟭
R012 / K10509 / G3 / 1372.50 / Y / ⟬iban#10⟭
R013 / K10515 / G3 / 0.00 / N /
R014 / K10521 / G4 / 1862.50 / Y / ⟬iban#11⟭
R015 / K10528 / G4 / 1795.00 / Y / ⟬iban#12⟭
R016 / K10533 / G2 / 744.00 / Y / ⟬iban#13⟭
R017 / K10540 / G2 / 819.00 / N / ⟬iban#14⟭
R018 / K10546 / G5 / 2628.00 / Y / ⟬iban#15⟭
R019 / K10551 / G5 / 2826.00 / Y / ⟬iban#16⟭
R020 / K10559 / G3 / 1390.50 / Y / ⟬iban#17⟭
R021 / K10563 / G3 / 1503.00 / Y / ⟬iban#18⟭
R022 / K10570 / G7 / 7450.00 / Y / ⟬iban#19⟭
R023 / K10574 / G7 / 7825.00 / Y / ⟬iban#20⟭
R024 / K10582 / G2 / 753.00 / Y / ⟬iban#21⟭
R025 / K10587 / G4 / 1840.00 / Y / ⟬iban#22⟭
R026 / K10591 / G4 / 0.00 / N /
R027 / K10596 / G3 / 1323.00 / Y / ⟬iban#23⟭
R028 / K10603 / G5 / 2736.00 / Y / ⟬iban#24⟭
R029 / K10608 / G2 / 781.50 / Y / ⟬iban#25⟭
R030 / K10612 / G6 / 4792.00 / Y / ⟬iban#26⟭
R031 / K10619 / G3 / 1426.50 / Y / ⟬iban#27⟭
R032 / K10625 / G2 / 837.00 / Y / ⟬iban#28⟭
R033 / K10631 / G4 / 1910.00 / Y / ⟬iban#29⟭
R034 / K10638 / G3 / 1476.00 / Y / ⟬iban#30⟭
R035 / K10644 / G5 / 2694.00 / N /
R036 / K10650 / G3 / 1395.00 / Y / ⟬iban#31⟭
R037 / K10657 / G4 / 1850.00 / Y / ⟬iban#32⟭
R038 / K10663 / G2 / 768.00 / Y / ⟬iban#33⟭
R039 / K10670 / G6 / 4710.00 / Y / ⟬iban#34⟭
R040 / K10676 / G5 / 2580.00 / Y / ⟬iban#35⟭
R041 / K10681 / G3 / 1410.75 / Y / ⟬iban#36⟭
-- end of range A1:F41, letters merged from column E = Y, money goes out on the same run --
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: en
fill_locale: en_GB
domain: retail
appearance: markdown table, footer rows, contact cell
scenario: loyalty scheme members, compared with last month
⟬text⟭
## Loyalty members, this month against last

| Member | Tier now | Tier before | Spend now | Spend before |
| --- | --- | --- | --- | --- |
| ⟬customer_id#1⟭ | Gold | Silver | 412.50 | 288.10 |
| ⟬customer_id#2⟭ | Gold | Gold | 655.20 | 702.45 |
| ⟬customer_id#3⟭ | Silver | Silver | 148.90 | 131.00 |
| ⟬customer_id#4⟭ | Silver | Bronze | 203.15 | 96.40 |
| ⟬customer_id#5⟭ | Bronze | Bronze | 44.75 | 38.20 |
| ⟬customer_id#6⟭ | Bronze | Silver | 61.30 | 174.05 |
| ⟬customer_id#7⟭ | Silver | Silver | 177.60 | 190.85 |
| ⟬customer_id#8⟭ | Gold | Silver | 389.95 | 251.30 |
| ⟬customer_id#9⟭ | Bronze | Bronze | 22.10 | 19.99 |
| ⟬customer_id#10⟭ | Silver | Gold | 214.40 | 366.70 |
| ⟬customer_id#11⟭ | Bronze | Bronze | 58.85 | 73.20 |
| ⟬customer_id#12⟭ | Gold | Gold | 503.25 | 498.60 |
| Prize draw winner | ⟬person_name#1⟭ | ⟬postal_address#1⟭ | tel ⟬phone#1⟭ | |
| Runner-up | ⟬person_name#2⟭ | ⟬postal_address#2⟭ | tel ⟬phone#2⟭ | |
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: en
fill_locale: en_GB
domain: housing
appearance: fixed-width row, labelled heading, scheme and developer names
scenario: waiting list, requested by a regulator
⟬text⟭
WAITING LIST RETURN TO THE REGULATOR     AS AT ⟬date#1⟭
CONTACT: ⟬trap:indicator_non_pii|ALLOCATIONS TEAM⟭     SIGNED: ⟬trap:indicator_non_pii|HEAD OF HOUSING⟭
SCHEME                     DEVELOPER                       BAND A  BAND B  BAND C  OFFERS  LETS
⟬trap:word_name|⦃Family⦄ Court⟭             ⟬trap:company_name|⦃Family2⦄ Homes⟭              12      30      41      6       5
⟬trap:word_name|⦃Family⦄ Court⟭ Annexe      ⟬trap:company_name|⦃Family2⦄ Homes⟭              3       9       14      1       1
⟬trap:word_name|⦃Family3⦄ House⟭            ⟬trap:company_name|⦃Family4⦄ & Sons Builders⟭    8       22      37      4       4
Mill Rise                  ⟬trap:company_name|⦃Family4⦄ & Sons Builders⟭    5       17      28      3       2
Station Yard               ⟬company#1⟭                      10      26      44      5       5
Kiln Lane                  ⟬company#1⟭                      2       11      19      0       0
⟬trap:word_name|Victoria⟭ Terrace           ⟬company#2⟭                      6       13      25      2       2
⟬trap:word_name|Albert⟭ Mews                ⟬company#2⟭                      1       5       8       1       1
Weir Court                 ⟬trap:company_name|⦃Family2⦄ Homes⟭              4       15      21      3       3
Orchard Row                ⟬trap:company_name|⦃Family5⦄ Construction⟭       7       19      33      2       1
Beacon Heights             ⟬trap:company_name|⦃Family5⦄ Construction⟭       9       24      40      4       3
Foundry Walk               ⟬company#2⟭                      3       8       16      1       1
Quarry Bank                ⟬company#1⟭                      5       12      23      2       2
TOTAL                                                      75      211     349     34      30
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: en
fill_locale: en_GB
domain: charities
appearance: markdown table, neutral header, delivery cell
scenario: event sign-ups, kept as a manual backup
⟬text⟭
Back-up of the sign-up sheet. Packs go by courier, so "Info" is what the courier needs.

| Ref | Event | Places | Paid | Info |
| --- | --- | --- | --- | --- |
| ES-2001 | Sponsored walk | 2 | 30.00 | deliver to ⟬postal_address#1⟭, tel ⟬phone#1⟭ |
| ES-2002 | Sponsored walk | 1 | 15.00 | deliver to ⟬postal_address#2⟭, tel ⟬phone#2⟭ |
| ES-2003 | Sponsored walk | 4 | 50.00 | deliver to ⟬postal_address#3⟭ |
| ES-2004 | Sponsored walk | 1 | 15.00 | ⟬postal_address#4⟭, leave with neighbour, mob ⟬phone#4⟭ |
| ES-2005 | Sponsored walk | 2 | 30.00 | deliver to ⟬postal_address#5⟭, tel ⟬phone#5⟭ |
| ES-2006 | Sponsored walk | 3 | 45.00 | deliver to ⟬postal_address#6⟭ |
| ES-2007 | Fun run | 1 | 20.00 | tel ⟬phone#7⟭ first, ⟬postal_address#7⟭ |
| ES-2008 | Fun run | 1 | 20.00 | deliver to ⟬postal_address#8⟭, tel ⟬phone#8⟭ |
| ES-2009 | Fun run | 2 | 40.00 | deliver to ⟬postal_address#9⟭ |
| ES-2010 | Fun run | 1 | 20.00 | deliver to ⟬postal_address#10⟭, mob ⟬phone#10⟭ |
| ES-2011 | Fun run | 5 | 90.00 | ⟬postal_address#11⟭, school office, tel ⟬phone#11⟭ |
| ES-2012 | Fun run | 1 | 20.00 | deliver to ⟬postal_address#12⟭ |
| ES-2013 | Fun run | 2 | 40.00 | deliver to ⟬postal_address#13⟭, tel ⟬phone#13⟭ |
| ES-2014 | Bike ride | 1 | 25.00 | deliver to ⟬postal_address#14⟭, tel ⟬phone#14⟭ |
| ES-2015 | Bike ride | 2 | 50.00 | deliver to ⟬postal_address#15⟭ |
| ES-2016 | Bike ride | 1 | 25.00 | deliver to ⟬postal_address#16⟭, mob ⟬phone#16⟭ |
| ES-2017 | Bike ride | 1 | 25.00 | deliver to ⟬postal_address#17⟭, tel ⟬phone#17⟭ |
| ES-2018 | Bike ride | 3 | 75.00 | ⟬postal_address#18⟭, back gate, tel ⟬phone#18⟭ |
| ES-2019 | Bike ride | 1 | 25.00 | deliver to ⟬postal_address#19⟭ |
| ES-2020 | Bike ride | 2 | 50.00 | deliver to ⟬postal_address#20⟭, tel ⟬phone#20⟭ |
| ES-2021 | Swimathon | 1 | 18.00 | deliver to ⟬postal_address#21⟭, tel ⟬phone#21⟭ |
| ES-2022 | Swimathon | 1 | 18.00 | deliver to ⟬postal_address#22⟭ |
| ES-2023 | Swimathon | 4 | 60.00 | deliver to ⟬postal_address#23⟭, mob ⟬phone#23⟭ |
| ES-2024 | Swimathon | 1 | 18.00 | deliver to ⟬postal_address#24⟭, tel ⟬phone#24⟭ |
| ES-2025 | Swimathon | 2 | 36.00 | deliver to ⟬postal_address#25⟭ |
| ES-2026 | Swimathon | 1 | 18.00 | tel ⟬phone#26⟭ before calling, ⟬postal_address#26⟭ |
| ES-2027 | Swimathon | 2 | 36.00 | deliver to ⟬postal_address#27⟭, tel ⟬phone#27⟭ |
| ES-2028 | Abseil | 1 | 50.00 | deliver to ⟬postal_address#28⟭, tel ⟬phone#28⟭ |
| ES-2029 | Abseil | 1 | 50.00 | deliver to ⟬postal_address#29⟭ |
| ES-2030 | Abseil | 2 | 100.00 | deliver to ⟬postal_address#30⟭, mob ⟬phone#30⟭ |
| ES-2031 | Abseil | 1 | 50.00 | deliver to ⟬postal_address#31⟭, tel ⟬phone#31⟭ |
| ES-2032 | Abseil | 1 | 50.00 | deliver to ⟬postal_address#32⟭ |
| ES-2033 | Carol concert | 2 | 24.00 | deliver to ⟬postal_address#33⟭, tel ⟬phone#33⟭ |
| ES-2034 | Carol concert | 4 | 42.00 | deliver to ⟬postal_address#34⟭ |
| ES-2035 | Carol concert | 2 | 24.00 | deliver to ⟬postal_address#35⟭, tel ⟬phone#35⟭ |
| ES-2036 | Carol concert | 3 | 33.00 | deliver to ⟬postal_address#36⟭, mob ⟬phone#36⟭ |
| ES-2037 | Carol concert | 2 | 24.00 | deliver to ⟬postal_address#37⟭ |
| ES-2038 | Carol concert | 1 | 12.00 | deliver to ⟬postal_address#38⟭, tel ⟬phone#38⟭ |
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: en
fill_locale: en_GB
domain: education
appearance: tilde-separated rows, first column, far context
scenario: exam entries, cleaned up before a mail merge
⟬text⟭
Exam entries, tidied for the candidate letters. The whole pupil master was copied across, nothing taken out.
Every row runs in the same order: the candidate, their home, where results are sent, the government number,
the day the candidate was born, then the entry codes.

Entry codes: 8300 maths, 8700 language, 8702 literature, 8461 biology, 8462 chemistry, 8463 physics, 8658 French.
Rows stay in form order. Blank lines in the sheet were removed before the merge.

⟬person_name#1⟭ ~ ⟬postal_address#1⟭ ~ ⟬email#1⟭ ~ ⟬uk_national_insurance_number#1⟭ ~ ⟬birth_date#1⟭ ~ 8300 8700 8702
⟬person_name#2⟭ ~ ⟬postal_address#2⟭ ~ ⟬email#2⟭ ~ ⟬uk_national_insurance_number#2⟭ ~ ⟬birth_date#2⟭ ~ 8300 8700 8461
⟬person_name#3⟭ ~ ⟬postal_address#3⟭ ~ ⟬email#3⟭ ~ ⟬uk_national_insurance_number#3⟭ ~ ⟬birth_date#3⟭ ~ 8300 8702 8658
⟬person_name#4⟭ ~ ⟬postal_address#4⟭ ~ ⟬email#4⟭ ~ ⟬uk_national_insurance_number#4⟭ ~ ⟬birth_date#4⟭ ~ 8300 8462 8463
⟬person_name#5⟭ ~ ⟬postal_address#5⟭ ~ ⟬email#5⟭ ~ ⟬uk_national_insurance_number#5⟭ ~ ⟬birth_date#5⟭ ~ 8700 8702
⟬person_name#6⟭ ~ ⟬postal_address#6⟭ ~ ⟬email#6⟭ ~ ⟬uk_national_insurance_number#6⟭ ~ ⟬birth_date#6⟭ ~ 8300 8700 8702 8658
⟬person_name#7⟭ ~ ⟬postal_address#7⟭ ~ ⟬email#7⟭ ~ ⟬uk_national_insurance_number#7⟭ ~ ⟬birth_date#7⟭ ~ 8300 8461 8462 8463
⟬person_name#8⟭ ~ ⟬postal_address#8⟭ ~ ⟬email#8⟭ ~ ⟬uk_national_insurance_number#8⟭ ~ ⟬birth_date#8⟭ ~ 8300 8700
⟬person_name#9⟭ ~ ⟬postal_address#9⟭ ~ ⟬email#9⟭ ~ ⟬uk_national_insurance_number#9⟭ ~ ⟬birth_date#9⟭ ~ 8300 8702
⟬person_name#10⟭ ~ ⟬postal_address#10⟭ ~ ⟬email#10⟭ ~ ⟬uk_national_insurance_number#10⟭ ~ ⟬birth_date#10⟭ ~ 8300 8700 8658
⟬person_name#11⟭ ~ ⟬postal_address#11⟭ ~ ⟬email#11⟭ ~ ⟬uk_national_insurance_number#11⟭ ~ ⟬birth_date#11⟭ ~ 8461 8462
⟬person_name#12⟭ ~ ⟬postal_address#12⟭ ~ ⟬email#12⟭ ~ ⟬uk_national_insurance_number#12⟭ ~ ⟬birth_date#12⟭ ~ 8300 8700 8702
⟬person_name#13⟭ ~ ⟬postal_address#13⟭ ~ ⟬email#13⟭ ~ ⟬uk_national_insurance_number#13⟭ ~ ⟬birth_date#13⟭ ~ 8300 8463
⟬person_name#14⟭ ~ ⟬postal_address#14⟭ ~ ⟬email#14⟭ ~ ⟬uk_national_insurance_number#14⟭ ~ ⟬birth_date#14⟭ ~ 8700 8658
⟬person_name#15⟭ ~ ⟬postal_address#15⟭ ~ ⟬email#15⟭ ~ ⟬uk_national_insurance_number#15⟭ ~ ⟬birth_date#15⟭ ~ 8300 8700 8461 8462
⟬person_name#16⟭ ~ ⟬postal_address#16⟭ ~ ⟬email#16⟭ ~ ⟬uk_national_insurance_number#16⟭ ~ ⟬birth_date#16⟭ ~ 8300 8702
⟬person_name#17⟭ ~ ⟬postal_address#17⟭ ~ ⟬email#17⟭ ~ ⟬uk_national_insurance_number#17⟭ ~ ⟬birth_date#17⟭ ~ 8300 8700 8463
⟬person_name#18⟭ ~ ⟬postal_address#18⟭ ~ ⟬email#18⟭ ~ ⟬uk_national_insurance_number#18⟭ ~ ⟬birth_date#18⟭ ~ 8702 8658
⟬person_name#19⟭ ~ ⟬postal_address#19⟭ ~ ⟬email#19⟭ ~ ⟬uk_national_insurance_number#19⟭ ~ ⟬birth_date#19⟭ ~ 8300 8461
⟬person_name#20⟭ ~ ⟬postal_address#20⟭ ~ ⟬email#20⟭ ~ ⟬uk_national_insurance_number#20⟭ ~ ⟬birth_date#20⟭ ~ 8300 8700 8702
⟬person_name#21⟭ ~ ⟬postal_address#21⟭ ~ ⟬email#21⟭ ~ ⟬uk_national_insurance_number#21⟭ ~ ⟬birth_date#21⟭ ~ 8462 8463
⟬person_name#22⟭ ~ ⟬postal_address#22⟭ ~ ⟬email#22⟭ ~ ⟬uk_national_insurance_number#22⟭ ~ ⟬birth_date#22⟭ ~ 8300 8700
⟬person_name#23⟭ ~ ⟬postal_address#23⟭ ~ ⟬email#23⟭ ~ ⟬uk_national_insurance_number#23⟭ ~ ⟬birth_date#23⟭ ~ 8300 8702 8658
⟬person_name#24⟭ ~ ⟬postal_address#24⟭ ~ ⟬email#24⟭ ~ ⟬uk_national_insurance_number#24⟭ ~ ⟬birth_date#24⟭ ~ 8300 8461 8463
⟬person_name#25⟭ ~ ⟬postal_address#25⟭ ~ ⟬email#25⟭ ~ ⟬uk_national_insurance_number#25⟭ ~ ⟬birth_date#25⟭ ~ 8700 8702
⟬person_name#26⟭ ~ ⟬postal_address#26⟭ ~ ⟬email#26⟭ ~ ⟬uk_national_insurance_number#26⟭ ~ ⟬birth_date#26⟭ ~ 8300 8700 8702
⟬person_name#27⟭ ~ ⟬postal_address#27⟭ ~ ⟬email#27⟭ ~ ⟬uk_national_insurance_number#27⟭ ~ ⟬birth_date#27⟭ ~ 8300 8462
⟬person_name#28⟭ ~ ⟬postal_address#28⟭ ~ ⟬email#28⟭ ~ ⟬uk_national_insurance_number#28⟭ ~ ⟬birth_date#28⟭ ~ 8300 8700 8658
⟬person_name#29⟭ ~ ⟬postal_address#29⟭ ~ ⟬email#29⟭ ~ ⟬uk_national_insurance_number#29⟭ ~ ⟬birth_date#29⟭ ~ 8702 8463
⟬person_name#30⟭ ~ ⟬postal_address#30⟭ ~ ⟬email#30⟭ ~ ⟬uk_national_insurance_number#30⟭ ~ ⟬birth_date#30⟭ ~ 8300 8700 8702
⟬person_name#31⟭ ~ ⟬postal_address#31⟭ ~ ⟬email#31⟭ ~ ⟬uk_national_insurance_number#31⟭ ~ ⟬birth_date#31⟭ ~ 8300 8461 8462
⟬person_name#32⟭ ~ ⟬postal_address#32⟭ ~ ⟬email#32⟭ ~ ⟬uk_national_insurance_number#32⟭ ~ ⟬birth_date#32⟭ ~ 8700 8658
⟬person_name#33⟭ ~ ⟬postal_address#33⟭ ~ ⟬email#33⟭ ~ ⟬uk_national_insurance_number#33⟭ ~ ⟬birth_date#33⟭ ~ 8300 8702
⟬person_name#34⟭ ~ ⟬postal_address#34⟭ ~ ⟬email#34⟭ ~ ⟬uk_national_insurance_number#34⟭ ~ ⟬birth_date#34⟭ ~ 8300 8700 8463
⟬person_name#35⟭ ~ ⟬postal_address#35⟭ ~ ⟬email#35⟭ ~ ⟬uk_national_insurance_number#35⟭ ~ ⟬birth_date#35⟭ ~ 8300 8702 8461
⟬end⟭
