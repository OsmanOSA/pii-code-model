⟬template⟭
family: tabular
format: SQL dump (.sql)
language: en
fill_locale: en_GB
domain: payroll
appearance: sql comment, multi-row insert, mysqldump header
scenario: pension auto-enrolment list, attached to a ticket
⟬text⟭
-- MySQL dump 10.13  Distrib ⟬version#1⟭
--
-- Host: ⟬hostname#1⟭    Database: payroll_reports
-- Ticket: ⟬ticket_id#1⟭, counts per team only, nobody's record is in this extract
-- Prepared by: ⟬trap:indicator_non_pii|Pensions Admin⟭
-- ------------------------------------------------------

/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET TIME_ZONE='+00:00' */;

DROP TABLE IF EXISTS `ae_team_summary`;
CREATE TABLE `ae_team_summary` (
  `team_code` varchar(8) NOT NULL,
  `site` varchar(40) DEFAULT NULL,
  `eligible` int NOT NULL,
  `enrolled` int NOT NULL,
  `opted_out` int NOT NULL,
  `ee_pct` decimal(4,2) DEFAULT NULL,
  `er_pct` decimal(4,2) DEFAULT NULL,
  `scheme` varchar(40) DEFAULT NULL,
  `assessed_on` date DEFAULT NULL,
  PRIMARY KEY (`team_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `ae_team_summary` WRITE;
INSERT INTO `ae_team_summary` VALUES
('WH01','⟬city#1⟭',142,131,11,5.00,3.00,'⟬trap:company_name|⦃Family⦄ Pensions⟭','⟬date#1⟭'),
('WH02','⟬city#1⟭',118,104,14,5.00,3.00,'⟬trap:company_name|⦃Family⦄ Pensions⟭','⟬date#1⟭'),
('WH03','⟬city#2⟭',97,90,7,5.00,3.00,'⟬trap:company_name|⦃Family⦄ Pensions⟭','⟬date#1⟭'),
('TR01','⟬city#2⟭',64,61,3,5.00,3.00,'⟬trap:company_name|⦃Family⦄ Pensions⟭','⟬date#1⟭'),
('TR02','⟬city#3⟭',38,33,5,5.00,3.00,'⟬trap:company_name|⦃Family⦄ Pensions⟭','⟬date#1⟭'),
('FN01','Head Office',22,22,0,6.00,6.00,'Group Stakeholder','⟬date#2⟭'),
('FN02','Head Office',17,16,1,6.00,6.00,'Group Stakeholder','⟬date#2⟭'),
('HR01','Head Office',11,11,0,6.00,6.00,'Group Stakeholder','⟬date#2⟭'),
('IT01','Head Office',29,27,2,6.00,6.00,'Group Stakeholder','⟬date#2⟭'),
('IT02','⟬city#3⟭',13,12,1,6.00,6.00,'Group Stakeholder','⟬date#2⟭'),
('CC01','⟬city#3⟭',76,63,13,5.00,3.00,'⟬trap:company_name|⦃Family⦄ Pensions⟭','⟬date#2⟭'),
('CC02','⟬city#3⟭',81,70,11,5.00,3.00,'⟬trap:company_name|⦃Family⦄ Pensions⟭','⟬date#2⟭'),
('FA01','⟬city#1⟭',26,21,5,5.00,3.00,'⟬trap:company_name|⦃Family⦄ Pensions⟭','⟬date#3⟭'),
('FA02','⟬city#2⟭',19,15,4,5.00,3.00,'⟬trap:company_name|⦃Family⦄ Pensions⟭','⟬date#3⟭'),
('SL01','Field',44,41,3,5.00,4.00,'Sales Plan','⟬date#3⟭'),
('SL02','Field',39,37,2,5.00,4.00,'Sales Plan','⟬date#3⟭'),
('SL03','Field',31,31,0,5.00,4.00,'Sales Plan','⟬date#3⟭');
UNLOCK TABLES;

-- Dump completed on ⟬date#1⟭
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: en
fill_locale: en_GB
domain: education
appearance: fixed-width row, first column, import reject log
scenario: free school meals, used to debug an import
⟬text⟭
FSM ELIGIBILITY FEED - SIXTH FORM CLAIMANTS IN THEIR OWN RIGHT - DEBUG PRINT ⟬date#1⟭
FILE ⟬file_path#1⟭   PARSER ⟬version#1⟭   EXPECTED WIDTH 62   USER=⟬trap:indicator_non_pii|svc_fsm_batch⟭
NINO            PUPIL-ID     YR  CHK  FROM        CODE  RESULT
⟬uk_national_insurance_number#1⟭   ⟬customer_id#1⟭  12  OK   ⟬date#7⟭  000   LOADED
⟬uk_national_insurance_number#2⟭   ⟬customer_id#2⟭  12  OK   ⟬date#7⟭  000   LOADED
⟬uk_national_insurance_number#3⟭   ⟬customer_id#3⟭  12  NO   ⟬date#7⟭  E07   NO MATCH AT DWP
⟬uk_national_insurance_number#4⟭   ⟬customer_id#4⟭  12  OK   ⟬date#7⟭  000   LOADED
⟬uk_national_insurance_number#5⟭   ⟬customer_id#5⟭  12  OK   ⟬date#6⟭  000   LOADED
⟬uk_national_insurance_number#6⟭   ⟬customer_id#6⟭  12  OK   ⟬date#6⟭  W02   LOADED, SPACES STRIPPED
⟬uk_national_insurance_number#7⟭   ⟬customer_id#7⟭  12  NO   ⟬date#6⟭  E12   BAD SUFFIX
⟬uk_national_insurance_number#8⟭   ⟬customer_id#8⟭  12  OK   ⟬date#6⟭  000   LOADED
⟬uk_national_insurance_number#9⟭   ⟬customer_id#9⟭  12  OK   ⟬date#6⟭  000   LOADED
⟬uk_national_insurance_number#10⟭   ⟬customer_id#10⟭  12  OK   ⟬date#5⟭  000   LOADED
⟬uk_national_insurance_number#11⟭   ⟬customer_id#11⟭  12  OK   ⟬date#5⟭  W02   LOADED, SPACES STRIPPED
⟬uk_national_insurance_number#12⟭   ⟬customer_id#12⟭  12  OK   ⟬date#5⟭  000   LOADED
⟬uk_national_insurance_number#13⟭   ⟬customer_id#13⟭  12  NO   ⟬date#5⟭  E07   NO MATCH AT DWP
⟬uk_national_insurance_number#14⟭   ⟬customer_id#14⟭  12  OK   ⟬date#5⟭  000   LOADED
⟬uk_national_insurance_number#15⟭   ⟬customer_id#15⟭  12  OK   ⟬date#4⟭  000   LOADED
⟬uk_national_insurance_number#16⟭   ⟬customer_id#16⟭  13  OK   ⟬date#4⟭  000   LOADED
⟬uk_national_insurance_number#17⟭   ⟬customer_id#17⟭  13  OK   ⟬date#4⟭  000   LOADED
⟬uk_national_insurance_number#18⟭   ⟬customer_id#18⟭  13  NO   ⟬date#4⟭  E31   DUPLICATE IN FILE
⟬uk_national_insurance_number#18⟭   ⟬customer_id#18⟭  13  NO   ⟬date#4⟭  E31   DUPLICATE IN FILE
⟬uk_national_insurance_number#19⟭   ⟬customer_id#19⟭  13  OK   ⟬date#3⟭  000   LOADED
⟬uk_national_insurance_number#20⟭   ⟬customer_id#20⟭  13  OK   ⟬date#3⟭  000   LOADED
⟬uk_national_insurance_number#21⟭   ⟬customer_id#21⟭  13  OK   ⟬date#3⟭  W02   LOADED, SPACES STRIPPED
⟬uk_national_insurance_number#22⟭   ⟬customer_id#22⟭  13  OK   ⟬date#3⟭  000   LOADED
⟬uk_national_insurance_number#23⟭   ⟬customer_id#23⟭  13  NO   ⟬date#3⟭  E12   BAD SUFFIX
⟬uk_national_insurance_number#24⟭   ⟬customer_id#24⟭  13  OK   ⟬date#2⟭  000   LOADED
⟬uk_national_insurance_number#25⟭   ⟬customer_id#25⟭  13  OK   ⟬date#2⟭  000   LOADED
⟬uk_national_insurance_number#26⟭   ⟬customer_id#26⟭  13  OK   ⟬date#2⟭  000   LOADED
⟬uk_national_insurance_number#27⟭   ⟬customer_id#27⟭  13  OK   ⟬date#2⟭  000   LOADED
⟬uk_national_insurance_number#28⟭   ⟬customer_id#28⟭  13  OK   ⟬date#2⟭  W02   LOADED, SPACES STRIPPED
⟬uk_national_insurance_number#29⟭   ⟬customer_id#29⟭  13  OK   ⟬date#1⟭  000   LOADED
⟬uk_national_insurance_number#30⟭   ⟬customer_id#30⟭  13  OK   ⟬date#1⟭  000   LOADED
⟬uk_national_insurance_number#31⟭   ⟬customer_id#31⟭  13  NO   ⟬date#1⟭  E07   NO MATCH AT DWP
⟬uk_national_insurance_number#32⟭   ⟬customer_id#32⟭  13  OK   ⟬date#1⟭  000   LOADED
⟬uk_national_insurance_number#33⟭   ⟬customer_id#33⟭  13  OK   ⟬date#1⟭  000   LOADED
⟬uk_national_insurance_number#34⟭   ⟬customer_id#34⟭  13  OK   ⟬date#1⟭  000   LOADED
TOTAL READ 35  LOADED 28  REJECTED 7
RERUN WITH --strip-spaces IF W02 IS THE ONLY CODE LEFT
END OF PRINT
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: en
fill_locale: en_GB
domain: retail
appearance: markdown table, note above table, labelled line
scenario: returned goods, sent to an outside accountant
⟬text⟭
## Returned goods for the year-end accounts

The till system prints these two lines on every export, leave them in:
Returns depot address: ⟬postal_address#1⟭
Returns email: ⟬email:generic#2⟭

| RMA | Order | Reason | Refund | Restocked |
| --- | --- | --- | --- | --- |
| R-40112 | ⟬order_number#1⟭ | Damaged in transit | 34.99 | no |
| R-40118 | ⟬order_number#2⟭ | Wrong size | 22.50 | yes |
| R-40127 | ⟬order_number#3⟭ | Changed mind | 89.00 | yes |
| R-40131 | ⟬order_number#4⟭ | Faulty | 149.00 | no |
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: en
fill_locale: en_GB
domain: retail
appearance: sqlite dump, neutral columns, sparse rows, null cells
scenario: loyalty scheme members, prepared for a migration to a new tool
⟬text⟭
PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
-- Colleague loyalty scheme, old till-side database, going into the new CRM.
-- Sign-up sheets were keyed into c2 to c5 as they came in: c2 who, c3 where they live,
-- c4 the government number on the form, c5 the day the member was born (over-18 offers).
-- Very few sheets were ever keyed, leave the NULLs alone.
CREATE TABLE lm_import (
  member_no INTEGER PRIMARY KEY,
  tier TEXT,
  c2 TEXT,
  c3 TEXT,
  c4 TEXT,
  c5 TEXT,
  points INTEGER,
  joined TEXT
);
INSERT INTO lm_import VALUES(880121,'silver',NULL,NULL,NULL,NULL,1240,'⟬date#6⟭');
INSERT INTO lm_import VALUES(880122,'bronze',NULL,NULL,NULL,NULL,85,'⟬date#6⟭');
INSERT INTO lm_import VALUES(880127,'gold','⟬person_name#1⟭','⟬postal_address#1⟭','⟬uk_national_insurance_number#1⟭','⟬birth_date#1⟭',9310,'⟬date#5⟭');
INSERT INTO lm_import VALUES(880130,'bronze',NULL,NULL,NULL,NULL,410,'⟬date#5⟭');
INSERT INTO lm_import VALUES(880134,'bronze',NULL,NULL,NULL,NULL,0,'⟬date#4⟭');
INSERT INTO lm_import VALUES(880139,'silver',NULL,NULL,NULL,NULL,2775,'⟬date#4⟭');
INSERT INTO lm_import VALUES(880141,'silver','⟬person_name#2⟭','⟬postal_address#2⟭',NULL,'⟬birth_date#2⟭',3120,'⟬date#3⟭');
INSERT INTO lm_import VALUES(880146,'bronze',NULL,NULL,NULL,NULL,640,'⟬date#3⟭');
INSERT INTO lm_import VALUES(880150,'gold',NULL,NULL,NULL,NULL,12050,'⟬date#2⟭');
INSERT INTO lm_import VALUES(880155,'bronze',NULL,NULL,NULL,NULL,95,'⟬date#2⟭');
INSERT INTO lm_import VALUES(880158,'bronze','⟬person_name#3⟭','⟬postal_address#3⟭','⟬uk_national_insurance_number#3⟭',NULL,220,'⟬date#1⟭');
INSERT INTO lm_import VALUES(880163,'silver',NULL,NULL,NULL,NULL,1890,'⟬date#1⟭');
COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: en
fill_locale: en_GB
domain: healthcare
appearance: t-sql script, bracketed columns, middle column
scenario: vaccination sessions, shared with a manager for a meeting
⟬text⟭
USE [TravelClinic]
GO
/****** Object:  Table [dbo].[VaccSession]    Script Date: ⟬date#1⟭ ******/
-- scripted from SSMS for the clinic manager's review of the travel sessions
SET ANSI_NULLS ON
GO
CREATE TABLE [dbo].[VaccSession](
	[SessionId] [int] NOT NULL,
	[Clinic] [nvarchar](40) NULL,
	[Vaccine] [nvarchar](40) NULL,
	[PassportNo] [nvarchar](12) NULL,
	[DateOfBirth] [date] NULL,
	[Dose] [tinyint] NULL,
	[BatchNo] [nvarchar](16) NULL,
	[GivenOn] [date] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[VaccSession] VALUES (7101, N'Room 2', N'Yellow fever', N'⟬uk_passport#1⟭', '⟬birth_date#1⟭', 1, N'YF-2291', '⟬date#5⟭')
INSERT [dbo].[VaccSession] VALUES (7102, N'Room 2', N'Yellow fever', N'⟬uk_passport#2⟭', '⟬birth_date#2⟭', 1, N'YF-2291', '⟬date#5⟭')
INSERT [dbo].[VaccSession] VALUES (7103, N'Room 2', N'Typhoid', N'⟬uk_passport#3⟭', '⟬birth_date#3⟭', 1, N'TY-8804', '⟬date#4⟭')
INSERT [dbo].[VaccSession] VALUES (7108, N'Room 1', N'Hepatitis A', N'⟬uk_passport#4⟭', '⟬birth_date#4⟭', 2, N'HA-1176', '⟬date#4⟭')
INSERT [dbo].[VaccSession] VALUES (7109, N'Room 1', N'Hepatitis A', N'⟬uk_passport#5⟭', '⟬birth_date#5⟭', 1, N'HA-1176', '⟬date#3⟭')
INSERT [dbo].[VaccSession] VALUES (7112, N'Room 1', N'Rabies', N'⟬uk_passport#6⟭', '⟬birth_date#6⟭', 3, N'RB-3390', '⟬date#2⟭')
INSERT [dbo].[VaccSession] VALUES (7115, N'Room 3', N'Japanese encephalitis', N'⟬uk_passport#7⟭', '⟬birth_date#7⟭', 1, N'JE-0442', '⟬date#2⟭')
INSERT [dbo].[VaccSession] VALUES (7116, N'Room 3', N'Typhoid', N'⟬uk_passport#8⟭', '⟬birth_date#8⟭', 1, N'TY-8804', '⟬date#1⟭')
GO
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: en
fill_locale: en_GB
domain: charities
appearance: fixed-width row, free-text comment cell, till totals
scenario: shop takings, prepared for a migration to a new tool
⟬text⟭
SHOP TAKINGS EXPORT FOR THE NEW EPOS  (OLD TILL REPORT 44)
SHOP  DAY         TILL  CASH      CARD      RAG KG  COMMENT
HS    ⟬date#10⟭  1     212.40    388.15    42
HS    ⟬date#10⟭  2     96.05     141.70    0
MS    ⟬date#10⟭  1     143.80    210.25    18
SW    ⟬date#10⟭  1     88.15     176.40    25      float short 5.00
HS    ⟬date#9⟭   1     240.10    402.60    37
HS    ⟬date#9⟭   2     102.55    133.05    0
MS    ⟬date#9⟭   1     119.30    198.75    21
SW    ⟬date#9⟭   1     74.90     160.20    12
HS    ⟬date#8⟭   1     198.65    351.40    30      bag went to the bank with ⟬person_name#1⟭ ⟬phone#1⟭
HS    ⟬date#8⟭   2     87.20     120.15    0
MS    ⟬date#8⟭   1     131.45    187.90    26
SW    ⟬date#8⟭   1     92.70     170.55    19
HS    ⟬date#7⟭   1     256.30    433.85    44
HS    ⟬date#7⟭   2     110.40    158.60    0
MS    ⟬date#7⟭   1     150.05    222.10    15      till roll out, ⟬person_name#2⟭ ⟬phone#2⟭ brings more on Friday
SW    ⟬date#7⟭   1     81.25     149.35    31
HS    ⟬date#6⟭   1     227.15    397.20    28
HS    ⟬date#6⟭   2     99.80     137.45    0
MS    ⟬date#6⟭   1     124.60    201.30    22
SW    ⟬date#6⟭   1     79.45     155.10    16
HS    ⟬date#5⟭   1     305.70    512.65    51
HS    ⟬date#5⟭   2     128.35    176.90    0
MS    ⟬date#5⟭   1     182.20    264.75    33
SW    ⟬date#5⟭   1     101.60    190.45    20      card machine down until 11, ⟬person_name#3⟭ ⟬phone#3⟭ sorted it
HS    ⟬date#4⟭   1     188.40    342.85    24
HS    ⟬date#4⟭   2     84.15     119.60    0
MS    ⟬date#4⟭   1     117.95    176.30    14
SW    ⟬date#4⟭   1     70.35     141.20    10
HS    ⟬date#3⟭   1     219.50    375.05    39
HS    ⟬date#3⟭   2     93.70     128.40    0
MS    ⟬date#3⟭   1     128.25    193.65    23
SW    ⟬date#3⟭   1     85.10     162.80    17
HS    ⟬date#2⟭   1     234.85    418.30    35
HS    ⟬date#2⟭   2     105.25    149.95    0
MS    ⟬date#2⟭   1     139.90    205.15    20      donation of 20.00 via ⟬person_name#4⟭ in with the cash
SW    ⟬date#2⟭   1     90.65     168.70    27
HS    ⟬date#1⟭   1     262.15    441.20    46
HS    ⟬date#1⟭   2     114.60    163.35    0
MS    ⟬date#1⟭   1     155.75    231.90    19
SW    ⟬date#1⟭   1     97.30     181.05    22      alarm code changed, ask ⟬person_name#5⟭ ⟬phone#5⟭
EOF 40 ROWS
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: housing
appearance: semicolon csv, announcing header, status value
scenario: estate inspections, merged from two sources
⟬text⟭
estate;block;inspector;resident_contact;signed_by;grade;inspected_on;source
⟬trap:word_name|⦃Family⦄ Estate⟭;A;⟬trap:indicator_non_pii|Neighbourhood North⟭;⟬trap:indicator_non_pii|None requested⟭;⟬trap:indicator_non_pii|Pending⟭;B;⟬date#6⟭;Concierge
⟬trap:word_name|⦃Family⦄ Estate⟭;B;Neighbourhood North;None requested;Pending;C;⟬date#6⟭;Concierge
⟬trap:word_name|⦃Family⦄ Estate⟭;C;Neighbourhood North;Letter sent;Countersigned;A;⟬date#6⟭;Concierge
Weavers Row;1;Neighbourhood East;None requested;Pending;B;⟬date#5⟭;Concierge
Weavers Row;2;Neighbourhood East;Letter sent;Countersigned;B;⟬date#5⟭;Concierge
Weavers Row;3;Neighbourhood East;None requested;Rejected;D;⟬date#5⟭;Concierge
Lock Side;North;Estates Team;None requested;Countersigned;A;⟬date#4⟭;Contractor app
Lock Side;South;Estates Team;Letter sent;Countersigned;C;⟬date#4⟭;Contractor app
Lock Side;West;Estates Team;None requested;Pending;B;⟬date#3⟭;Contractor app
⟬trap:word_name|⦃Family2⦄ Fields⟭;1;Grounds Maintenance;None requested;Countersigned;B;⟬date#3⟭;Contractor app
⟬trap:word_name|⦃Family2⦄ Fields⟭;2;Grounds Maintenance;Visit booked;Pending;C;⟬date#3⟭;Contractor app
⟬trap:word_name|⦃Family2⦄ Fields⟭;3;Grounds Maintenance;None requested;Countersigned;A;⟬date#2⟭;Contractor app
Quarry Bank;East;Neighbourhood West;Letter sent;Rejected;D;⟬date#2⟭;Concierge
Quarry Bank;Tower;Neighbourhood West;Visit booked;Countersigned;B;⟬date#1⟭;Concierge
Quarry Bank;Maisonettes;Neighbourhood West;None requested;Pending;B;⟬date#1⟭;Contractor app
Owner;⟬trap:indicator_non_pii|Neighbourhood Services⟭;;;;;;
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: en
fill_locale: en_GB
domain: retail
appearance: multi-row insert, neutral column
scenario: click-and-collect orders, shared with a manager for a meeting
⟬text⟭
-- click and collect not picked up after 7 days, store managers go through this on Monday
-- money goes back automatically once ops ticks them off
INSERT INTO cc_uncollected (order_no, store, ready_on, value_gbp, ops_ok, ref1) VALUES
 ('⟬order_number#1⟭', 'Ashby', '⟬date#5⟭', 34.99, 0, '⟬iban#1⟭'),
 ('⟬order_number#2⟭', 'Ashby', '⟬date#4⟭', 120.00, 0, '⟬iban#2⟭'),
 ('⟬order_number#3⟭', 'Barton', '⟬date#4⟭', 18.50, 1, '⟬iban#3⟭'),
 ('⟬order_number#4⟭', 'Barton', '⟬date#3⟭', 64.25, 0, '⟬iban#4⟭'),
 ('⟬order_number#5⟭', 'Colby', '⟬date#2⟭', 212.00, 0, '⟬iban#5⟭'),
 ('⟬order_number#6⟭', 'Colby', '⟬date#1⟭', 9.99, 1, '⟬iban#6⟭');
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: en
fill_locale: en_GB
domain: housing
appearance: pipe-separated paste, last column, contact cell
scenario: gas safety checks, exported for a quarterly audit
⟬text⟭
LGSR tracker | quarterly audit export | sheet 1 of 1
Prop ref | Boiler | Cert no | Last check | Expires | Result | Tenant contact
P-10231 | ⟬trap:company_name|Vaillant⟭ ecoTEC | CP12-44871 | ⟬date#8⟭ | ⟬date#1⟭ | PASS | ⟬person_name#1⟭ tel ⟬phone#1⟭
P-10232 | ⟬trap:company_name|Vaillant⟭ ecoTEC | CP12-44872 | ⟬date#8⟭ | ⟬date#1⟭ | PASS | ⟬person_name#2⟭ tel ⟬phone#2⟭
P-10238 | Ideal Logic | CP12-44880 | ⟬date#7⟭ | ⟬date#1⟭ | PASS | ⟬person_name#3⟭ tel ⟬phone#3⟭
P-10241 | Ideal Logic | CP12-44885 | ⟬date#7⟭ | ⟬date#1⟭ | NO ACCESS x2 | ⟬person_name#4⟭ mob ⟬phone#4⟭
P-10249 | Worcester Greenstar | CP12-44893 | ⟬date#7⟭ | ⟬date#1⟭ | PASS | ⟬person_name#5⟭ tel ⟬phone#5⟭
P-10250 | Worcester Greenstar | CP12-44894 | ⟬date#6⟭ | ⟬date#1⟭ | FAIL flue | ⟬person_name#6⟭ mob ⟬phone#6⟭
P-10256 | Baxi Duo-tec | CP12-44902 | ⟬date#6⟭ | ⟬date#1⟭ | PASS | ⟬person_name#7⟭ tel ⟬phone#7⟭
P-10263 | Baxi Duo-tec | CP12-44911 | ⟬date#5⟭ | ⟬date#1⟭ | PASS | ⟬person_name#8⟭ tel ⟬phone#8⟭
P-10267 | ⟬trap:company_name|Vaillant⟭ ecoTEC | CP12-44916 | ⟬date#5⟭ | ⟬date#1⟭ | PASS | ⟬person_name#9⟭ tel ⟬phone#9⟭
P-10272 | Ideal Logic | CP12-44920 | ⟬date#4⟭ | ⟬date#1⟭ | PASS | ⟬person_name#10⟭ mob ⟬phone#10⟭
P-10278 | Worcester Greenstar | CP12-44927 | ⟬date#4⟭ | ⟬date#1⟭ | NO ACCESS x1 | ⟬person_name#11⟭ tel ⟬phone#11⟭
P-10281 | Baxi Duo-tec | CP12-44933 | ⟬date#3⟭ | ⟬date#1⟭ | PASS | ⟬person_name#12⟭ tel ⟬phone#12⟭
P-10285 | Ideal Logic | CP12-44940 | ⟬date#3⟭ | ⟬date#1⟭ | PASS | ⟬person_name#13⟭ mob ⟬phone#13⟭
P-10290 | ⟬trap:company_name|Vaillant⟭ ecoTEC | CP12-44946 | ⟬date#2⟭ | ⟬date#1⟭ | PASS | ⟬person_name#14⟭ tel ⟬phone#14⟭
Compliance 11 of 14 | | | | | |
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: healthcare
appearance: csv cell, eponym column, supplier company
scenario: clinic appointment list, sent to an outside accountant
⟬text⟭
"clinic_code","clinic","site","sessions","slots","attended","dna","tariff_gbp","supplier"
"C001","⟬trap:eponym|Parkinson's⟭ review","Outpatients 1",4,48,44,4,142.00,""
"C002","⟬trap:eponym|Parkinson's⟭ new patient","Outpatients 1",2,16,15,1,205.00,""
"C003","⟬trap:eponym|Alzheimer's⟭ memory assessment","Outpatients 1",3,18,17,1,188.00,""
"C004","⟬trap:eponym|Huntington's⟭ family clinic","Outpatients 2",1,6,6,0,240.00,""
"C005","⟬trap:eponym|Crohn's⟭ follow-up","Endoscopy Suite",4,52,47,5,131.00,""
"C006","Coeliac review","Endoscopy Suite",2,24,21,3,118.00,""
"C007","⟬trap:eponym|Barrett's⟭ surveillance","Endoscopy Suite",3,27,26,1,412.00,"⟬trap:company_name|⦃Family⦄ Diagnostics Ltd⟭"
"C008","Colonoscopy list","Endoscopy Suite",6,42,40,2,498.00,"⟬trap:company_name|⦃Family⦄ Diagnostics Ltd⟭"
"C009","⟬trap:eponym|Graves'⟭ thyroid clinic","Outpatients 3",2,20,19,1,126.00,""
"C010","⟬trap:eponym|Hashimoto's⟭ thyroid clinic","Outpatients 3",1,10,9,1,126.00,""
"C011","⟬trap:eponym|Addison's⟭ endocrine review","Outpatients 3",1,8,8,0,158.00,""
"C012","⟬trap:eponym|Cushing's⟭ investigation","Outpatients 3",1,6,5,1,212.00,""
"C013","Diabetes foot","Podiatry",5,60,52,8,96.00,""
"C014","Diabetes education","Podiatry",2,24,20,4,64.00,""
"C015","Rheumatology biologics","Infusion Suite",4,32,31,1,376.00,"⟬trap:company_name|⦃Family2⦄ Infusion Services⟭"
"C016","⟬trap:eponym|Raynaud's⟭ assessment","Infusion Suite",1,8,7,1,144.00,""
"C017","⟬trap:eponym|Sjogren's⟭ review","Infusion Suite",1,6,6,0,144.00,""
"C018","⟬trap:eponym|Holter⟭ fitting","Cardiac Physiology",5,50,48,2,87.00,"⟬trap:company_name|⦃Family⦄ Diagnostics Ltd⟭"
"C019","Echo list","Cardiac Physiology",8,64,61,3,102.00,"⟬trap:company_name|⦃Family⦄ Diagnostics Ltd⟭"
"C020","Pacemaker check","Cardiac Physiology",3,36,35,1,74.00,""
"C021","⟬trap:eponym|Tourette's⟭ transition clinic","Outpatients 2",1,5,4,1,233.00,""
"C022","⟬trap:eponym|Bell's palsy⟭ clinic","Outpatients 2",1,8,8,0,121.00,""
"C023","⟬trap:eponym|Meniere's⟭ balance clinic","Audiology",2,16,14,2,139.00,""
"C024","Hearing aid fitting","Audiology",6,72,66,6,58.00,"⟬trap:company_name|⦃Family2⦄ Hearing⟭"
"C025","Tinnitus group","Audiology",1,10,8,2,41.00,""
"C026","Cataract pre-op","Eye Unit",7,84,79,5,67.00,""
"C027","Glaucoma monitoring","Eye Unit",6,78,71,7,73.00,""
"C028","AMD injections","Eye Unit",8,96,94,2,289.00,"⟬trap:company_name|⦃Family2⦄ Infusion Services⟭"
"C029","Fracture review","Orthopaedics",6,90,81,9,92.00,""
"C030","⟬trap:eponym|Dupuytren's⟭ hand clinic","Orthopaedics",1,9,9,0,166.00,""
"C031","⟬trap:eponym|Paget's⟭ bone review","Orthopaedics",1,6,5,1,149.00,""
"C032","Pre-assessment","Orthopaedics",5,55,50,5,61.00,""
"C033","Antenatal booking","Maternity",6,60,57,3,110.00,""
"C034","Fetal medicine","Maternity",2,14,14,0,318.00,""
"C035","Postnatal","Maternity",3,30,24,6,52.00,""
"C036","Lymphoedema","Oncology",2,20,18,2,88.00,""
"C037","⟬trap:eponym|Hodgkin⟭ late effects","Oncology",1,8,8,0,174.00,""
"C038","Chemotherapy review","Oncology",7,70,68,2,163.00,""
"C039","Stoma care","Oncology",2,18,16,2,71.00,""
"C040","Sleep apnoea","Respiratory",3,24,20,4,109.00,"⟬trap:company_name|⦃Family⦄ Diagnostics Ltd⟭"
"C041","Asthma nurse","Respiratory",4,44,38,6,57.00,""
"C042","Spirometry","Respiratory",3,27,25,2,48.00,""
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: en
fill_locale: en_GB
domain: payroll
appearance: oracle export, trailer row, contact column
scenario: bonus run, sampled for a test environment
⟬text⟭
REM  Sample of the bonus run for the UAT schema, generated by SQL Developer
REM  34 staff rows plus the two control rows the source system appends
REM  Owner: ⟬trap:indicator_non_pii|payroll_uat⟭
SET DEFINE OFF;
REM INSERTING into BONUS_RUN
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10442','G3',31250,4.5,1406.25,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10451','G3',29800,4.5,1341.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10460','G4',36100,5,1805.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10467','G4',38450,5,1922.50,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10473','G5',44200,6,2652.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10479','G5',46750,6,2805.00,'HELD',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10488','G2',26400,3,792.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10490','G2',25900,3,777.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10496','G6',58300,8,4664.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10502','G6',61200,8,4896.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10509','G3',30500,4.5,1372.50,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10515','G3',32100,0,0,'NOT ELIGIBLE',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10521','G4',37250,5,1862.50,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10528','G4',35900,5,1795.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10533','G2',24800,3,744.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10540','G2',27300,3,819.00,'HELD',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10546','G5',43800,6,2628.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10551','G5',47100,6,2826.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10559','G3',30900,4.5,1390.50,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10563','G3',33400,4.5,1503.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10570','G7',74500,10,7450.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10574','G7',78250,10,7825.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10582','G2',25100,3,753.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10587','G4',36800,5,1840.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10591','G4',39150,0,0,'LEAVER',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10596','G3',29400,4.5,1323.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10603','G5',45600,6,2736.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10608','G2',26050,3,781.50,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10612','G6',59900,8,4792.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10619','G3',31700,4.5,1426.50,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10625','G2',27900,3,837.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10631','G4',38200,5,1910.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10638','G3',32800,4.5,1476.00,'PAID',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('K10644','G5',44900,6,2694.00,'HELD',NULL);
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('TRAILER',NULL,NULL,NULL,73845.25,'CONTROL','⟬email#1⟭');
Insert into BONUS_RUN (EMP_KEY,GRADE,BASE_GBP,PCT,BONUS_GBP,STATE,CONTACT_EMAIL) values ('TRAILER2',NULL,NULL,NULL,NULL,'QUERIES','⟬email:generic#2⟭');
COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: payroll
appearance: csv cell, footer row, masked cells
scenario: starters and leavers, merged from two sources
⟬text⟭
"type","emp_ref","dept","effective","full_name","home_address","nino","corp_card","source"
"starter","E20611","Warehouse","⟬date#8⟭","⟬trap:placeholder|***⟭","⟬trap:placeholder|***⟭","⟬trap:placeholder|***⟭","","HRIS"
"starter","E20612","Warehouse","⟬date#8⟭","⟬trap:placeholder|***⟭","⟬trap:placeholder|***⟭","⟬trap:placeholder|***⟭","","HRIS"
"leaver","E18840","Transport","⟬date#7⟭","","","","","HRIS"
"starter","E20620","Finance","⟬date#7⟭","","","","","HRIS"
"leaver","E17265","Finance","⟬date#6⟭","","","","","HRIS"
"leaver","E19033","Customer Care","⟬date#6⟭","","","","","HRIS"
"starter","E20634","Customer Care","⟬date#5⟭","","","","","HRIS"
"starter","E20635","Customer Care","⟬date#5⟭","","","","","HRIS"
"leaver","E16112","IT","⟬date#4⟭","","","","","Card feed"
"starter","E20641","IT","⟬date#4⟭","","","","","HRIS"
"leaver","E18477","Facilities","⟬date#3⟭","","","","","Card feed"
"starter","E20652","Facilities","⟬date#3⟭","","","","","HRIS"
"leaver","E15908","Sales","⟬date#2⟭","","","","","Card feed"
"starter","E20660","Sales","⟬date#2⟭","","","","","HRIS"
"starter","E20661","Sales","⟬date#1⟭","","","","","HRIS"
"UNMATCHED","","","⟬date#1⟭","⟬person_name#1⟭","⟬postal_address#1⟭","⟬uk_national_insurance_number#1⟭","⟬payment_card#1⟭","Card feed"
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: education
appearance: csv cell, free-text comment cell, merged sources
scenario: room bookings, merged from two sources
⟬text⟭
"booking_id","room","day","start","end","group","source","comment"
"B-3301","Sports hall","Mon","18:00","20:00","Badminton league","Lettings sheet",""
"B-3302","Sports hall","Tue","18:00","19:30","Karate juniors","Lettings sheet","⟬person_name#1⟭ ⟬email#1⟭ ⟬phone#1⟭ has the side door keys"
"B-3303","Main hall","Tue","19:00","21:00","Community choir","Lettings sheet",""
"B-3304","Drama studio","Wed","16:30","18:00","Year 9 rehearsal","MIS calendar",""
"B-3305","Main hall","Wed","18:30","21:30","Parish council","Lettings sheet","invoice goes to ⟬person_name#2⟭, ⟬email#2⟭"
"B-3306","Sports hall","Thu","18:00","20:00","Five-a-side","Lettings sheet",""
"B-3307","Library","Thu","15:30","16:30","Homework club","MIS calendar",""
"B-3308","Science lab 2","Thu","15:30","17:00","Revision session","MIS calendar",""
"B-3309","Main hall","Fri","17:00","22:00","Quiz night","Lettings sheet","⟬person_name#3⟭ on ⟬phone#3⟭ is bringing the PA"
"B-3310","Sports hall","Sat","09:00","12:00","Gymnastics club","Lettings sheet",""
"B-3311","Sports hall","Sat","13:00","17:00","Birthday party","Lettings sheet","deposit paid, ⟬email#4⟭ wants a receipt"
"B-3312","Drama studio","Sat","10:00","13:00","Dance school","Lettings sheet",""
"B-3313","Main hall","Sun","10:00","12:30","Church service","Lettings sheet",""
"B-3314","Classroom 12","Sun","14:00","16:00","Language class","Lettings sheet","⟬person_name#5⟭, ⟬phone#5⟭, will lock up"
"B-3315","Library","Mon","15:30","16:30","Reading group","MIS calendar",""
"B-3316","ICT 2","Tue","15:30","17:00","Coding club","MIS calendar",""
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: en
fill_locale: en_GB
domain: charities
appearance: dataframe print, free-text comment cell, python prompt
scenario: event sign-ups, prepared for a migration to a new tool
⟬text⟭
>>> import ⟬trap:library|pandas⟭ as pd
>>> df = pd.read_excel("sign_ups_old_tool.xlsx")   # notes column is exported whether we want it or not
>>> print(df.to_string())
    signup      event             ticket   paid    notes
0   ES-1001     Sponsored walk    adult    15.00
1   ES-1002     Sponsored walk    adult    15.00   post pack to ⟬postal_address#1⟭
2   ES-1003     Sponsored walk    child     5.00
3   ES-1004     Sponsored walk    adult    15.00
4   ES-1005     Sponsored walk    family   35.00   address on form: ⟬postal_address#2⟭
5   ES-1006     Sponsored walk    adult    15.00
6   ES-1007     ⟬trap:word_name|Daisy⟭ chain run   adult    20.00
7   ES-1008     ⟬trap:word_name|Daisy⟭ chain run   adult    20.00
8   ES-1009     ⟬trap:word_name|Daisy⟭ chain run   adult    20.00   send vest to ⟬postal_address#3⟭
9   ES-1010     ⟬trap:word_name|Daisy⟭ chain run   adult    20.00
10  ES-1011     ⟬trap:word_name|Daisy⟭ chain run   junior   10.00
11  ES-1012     ⟬trap:word_name|Daisy⟭ chain run   adult    20.00   wheelchair user
12  ES-1013     Quiz night        team     40.00
13  ES-1014     Quiz night        team     40.00
14  ES-1015     Quiz night        team     40.00   table near the door
15  ES-1016     Quiz night        team     40.00
16  ES-1017     Quiz night        single   10.00
17  ES-1018     Quiz night        team     40.00
18  ES-1019     Gala dinner       table   480.00   invoice to ⟬postal_address#4⟭
19  ES-1020     Gala dinner       table   480.00
20  ES-1021     Gala dinner       single   55.00   vegan
21  ES-1022     Gala dinner       single   55.00
22  ES-1023     Gala dinner       single   55.00
23  ES-1024     Gala dinner       table   480.00   addr ⟬postal_address#5⟭, ask for the back door
24  ES-1025     Abseil            adult    50.00
25  ES-1026     Abseil            adult    50.00
26  ES-1027     Abseil            adult    50.00   needs parking
27  ES-1028     Abseil            adult    50.00
28  ES-1029     Abseil            adult    50.00
29  ES-1030     Coffee morning    free      0.00
30  ES-1031     Coffee morning    free      0.00
31  ES-1032     Coffee morning    free      0.00   host, kit goes to ⟬postal_address#6⟭
32  ES-1033     Coffee morning    free      0.00
33  ES-1034     Coffee morning    free      0.00
34  ES-1035     Coffee morning    free      0.00
35  ES-1036     Carol concert     adult    12.00
36  ES-1037     Carol concert     adult    12.00
37  ES-1038     Carol concert     child     6.00
38  ES-1039     Carol concert     adult    12.00
>>> df.shape
(39, 5)
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: en
fill_locale: en_GB
domain: retail
appearance: formula text, labelled cell, multibuy notation
scenario: price changes, attached to a ticket
⟬text⟭
Ticket ⟬ticket_id#1⟭ - price file as text, formulas left visible
Signed off by: ⟬trap:indicator_non_pii|Pricing Committee⟭     Effective: ⟬date#1⟭
SKU        Line                          Old     New     Change          Multibuy
SKU-20418  ⟬trap:eponym|Granny Smith⟭ apples 6pk     1.85    1.95    =D4-C4          ⟬trap:email_lookalike|2@3.50⟭
SKU-20422  ⟬trap:eponym|Earl Grey⟭ tea bags 80s     3.40    3.25    =D5-C5
SKU-27710  ⟬trap:eponym|Victoria⟭ sponge mix        1.10    1.20    =D6-C6          ⟬trap:email_lookalike|3@3.00⟭
SKU-31907  ⟬trap:eponym|Wellington⟭ boots size 8     18.00   16.00   =D7-C7
SKU-40116  ⟬trap:word_name|Rose⟭ scented candle      6.50    6.75    =D8-C8          ⟬trap:email_lookalike|2@12.00⟭
SKU-40120  ⟬trap:word_name|Jasmine⟭ scented candle   6.50    6.75    =D9-C9
Total lines changed                                      =COUNTA(A4:A9)
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: charities
appearance: tsv cell, footer rows, sort code beside account
scenario: membership renewals, used to debug an import
⟬text⟭
member_no	plan	renew_by	amount	method	import_result
M-50112	Individual	⟬date#6⟭	36.00	DD	ok
M-50118	Joint	⟬date#6⟭	54.00	DD	ok
M-50121	Individual	⟬date#6⟭	36.00	Card	ok
M-50127	Concession	⟬date#5⟭	18.00	DD	ok
M-50130	Life	⟬date#5⟭	0.00	None	skipped
M-50136	Individual	⟬date#5⟭	36.00	DD	ok
M-50139	Joint	⟬date#4⟭	54.00	Cheque	ok
M-50144	Individual	⟬date#4⟭	36.00	DD	row too long
M-50149	Concession	⟬date#4⟭	18.00	DD	ok
M-50152	Individual	⟬date#3⟭	36.00	Card	ok
M-50158	Joint	⟬date#3⟭	54.00	DD	ok
M-50163	Individual	⟬date#3⟭	36.00	DD	row too long
M-50167	Concession	⟬date#2⟭	18.00	Cheque	ok
M-50171	Individual	⟬date#2⟭	36.00	DD	ok
M-50176	Individual	⟬date#1⟭	36.00	DD	ok
LAST RECORD READ	name: ⟬person_name#1⟭	dob: ⟬birth_date#1⟭	addr: ⟬postal_address#1⟭	minibus licence: ⟬uk_driving_licence#1⟭	sort 40-22-19 acct ⟬bank_account_number#1⟭
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: healthcare
appearance: csv cell, neutral header, sort code beside account
scenario: agency staff shifts, used to debug an import
⟬text⟭
"field_1","field_2","field_3","field_4","field_5","field_6","field_7","field_8","field_9"
"AG-7741","⟬date#6⟭","Night","Ward 9",11.5,"RN","20-61-13","⟬bank_account_number#1⟭","⟬postal_address#1⟭"
"AG-7741","⟬date#5⟭","Night","Ward 9",11.5,"RN","20-61-13","⟬bank_account_number#1⟭","⟬postal_address#1⟭"
"AG-7756","⟬date#6⟭","Long day","A&E",12,"HCA","30-15-99","⟬bank_account_number#2⟭","⟬postal_address#2⟭"
"AG-7756","⟬date#4⟭","Long day","A&E",12,"HCA","30-15-99","⟬bank_account_number#2⟭","⟬postal_address#2⟭"
"AG-7760","⟬date#5⟭","Early","Ward 4",7.5,"RN","09-01-28","⟬bank_account_number#3⟭","⟬postal_address#3⟭"
"AG-7762","⟬date#5⟭","Late","Ward 4",7.5,"HCA","11-42-07","⟬bank_account_number#4⟭","⟬postal_address#4⟭"
"AG-7762","⟬date#4⟭","Late","Ward 4",7.5,"HCA","11-42-07","⟬bank_account_number#4⟭","⟬postal_address#4⟭"
"AG-7768","⟬date#4⟭","Night","ICU",11.5,"RN","77-30-16","⟬bank_account_number#5⟭","⟬postal_address#5⟭"
"AG-7768","⟬date#3⟭","Night","ICU",11.5,"RN","77-30-16","⟬bank_account_number#5⟭","⟬postal_address#5⟭"
"AG-7771","⟬date#3⟭","Long day","Theatres",12,"ODP","60-83-71","⟬bank_account_number#6⟭","⟬postal_address#6⟭"
"AG-7775","⟬date#3⟭","Early","Ward 11",7.5,"HCA","20-61-13","⟬bank_account_number#7⟭","⟬postal_address#7⟭"
"AG-7775","⟬date#2⟭","Early","Ward 11",7.5,"HCA","20-61-13","⟬bank_account_number#7⟭","⟬postal_address#7⟭"
"AG-7779","⟬date#2⟭","Night","Ward 9",11.5,"RN","40-47-52","⟬bank_account_number#8⟭","⟬postal_address#8⟭"
"AG-7741","⟬date#2⟭","Night","Ward 9",11.5,"RN","20-61-13","⟬bank_account_number#1⟭","⟬postal_address#1⟭"
"AG-7783","⟬date#1⟭","Late","A&E",7.5,"HCA","30-15-99","⟬bank_account_number#9⟭","⟬postal_address#9⟭"
"AG-7760","⟬date#1⟭","Early","Ward 4",7.5,"RN","09-01-28","⟬bank_account_number#3⟭","⟬postal_address#3⟭"
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: en
fill_locale: en_GB
domain: education
appearance: fixed-width row, labelled heading, eponym course
scenario: staff training records, kept as a manual backup
⟬text⟭
CPD REGISTER - BACK-UP PRINT - ⟬date#1⟭
OWNER: ⟬trap:indicator_non_pii|HEAD OF CPD OFFICE⟭     STAFF: ⟬trap:indicator_non_pii|ALL TEACHING GROUPS⟭
CODE   COURSE                                  PROVIDER                      GROUP      HRS  ATT
CP-11  ⟬trap:eponym|Bloom's taxonomy⟭ in lesson planning     In-house                      English    2    14
CP-12  ⟬trap:eponym|Rosenshine's principles⟭                 In-house                      All staff  1.5  61
CP-13  ⟬trap:eponym|Heimlich manoeuvre⟭ and paediatric first aid  ⟬trap:company_name|⦃Family⦄ Training Ltd⟭          Early yrs  6    9
CP-14  Safeguarding level 2                    ⟬trap:company_name|⦃Family⦄ Training Ltd⟭          All staff  3    63
CP-15  ⟬trap:eponym|Maslow's hierarchy⟭ and behaviour        In-house                      Pastoral   2    11
CP-16  Using ⟬trap:library|Scratch⟭ in KS3                       ⟬company#1⟭                    Computing  3    4
CP-17  ⟬trap:eponym|Vygotsky's zone⟭ of proximal development  In-house                      Science    1.5  8
CP-18  Fire marshal                            ⟬trap:company_name|⦃Family2⦄ Safety Services⟭      Site team  4    6
CP-19  ⟬trap:eponym|Kolb's learning cycle⟭ for mentors       In-house                      ECT mentors 2   12
CP-20  Manual handling                         ⟬trap:company_name|⦃Family2⦄ Safety Services⟭      Site team  2    6
CP-21  Dyslexia friendly marking               ⟬company#2⟭                    SEND       3    10
CP-22  ⟬trap:eponym|Pythagoras' theorem⟭ through bar models Maths Hub                     Maths      2    7
CP-23  ⟬trap:eponym|Montessori method⟭ in EYFS                ⟬company#2⟭                    Early yrs  3    9
CP-24  Data protection refresher               In-house                      All staff  1    60
END OF REGISTER  14 COURSES
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: en
fill_locale: en_GB
domain: payroll
appearance: fixed-width row, free-text comment cell, month on month diff
scenario: statutory sick pay, compared with last month
⟬text⟭
SSP COMPARISON  THIS PERIOD V LAST PERIOD  PRINTED ⟬date#1⟭
EMP     DEPT   PIW START    QD  THIS      LAST      DIFF      COMMENT
100442  WH     ⟬date#9⟭   5   116.75    0.00      116.75
100451  WH     ⟬date#9⟭   3   70.05     116.75    -46.70    ⟬uk_national_insurance_number#1⟭ 3 WAITING DAYS SERVED
100460  TR     ⟬date#9⟭   10  233.50    233.50    0.00
100467  TR     ⟬date#8⟭   2   46.70     0.00      46.70
100473  FN     ⟬date#8⟭   5   116.75    70.05     46.70
100479  FN     ⟬date#8⟭   0   0.00      116.75    -116.75   RTW
100488  CC     ⟬date#8⟭   8   186.80    93.40     93.40     ⟬uk_national_insurance_number#2⟭ LINKED PIW
100490  CC     ⟬date#7⟭   5   116.75    116.75    0.00
100496  IT     ⟬date#7⟭   4   93.40     0.00      93.40
100502  IT     ⟬date#7⟭   0   0.00      46.70     -46.70    RTW
100509  FA     ⟬date#7⟭   12  280.20    233.50    46.70
100515  FA     ⟬date#7⟭   15  350.25    350.25    0.00      ⟬uk_national_insurance_number#3⟭ 28 WK LIMIT NEAR
100521  WH     ⟬date#6⟭   5   116.75    0.00      116.75
100528  WH     ⟬date#6⟭   7   163.45    116.75    46.70
100533  WH     ⟬date#6⟭   3   70.05     0.00      70.05
100540  WH     ⟬date#6⟭   20  467.00    467.00    0.00
100546  TR     ⟬date#6⟭   5   116.75    116.75    0.00
100551  TR     ⟬date#5⟭   2   46.70     93.40     -46.70
100559  TR     ⟬date#5⟭   0   0.00      70.05     -70.05    RTW
100563  FN     ⟬date#5⟭   5   116.75    0.00      116.75
100570  FN     ⟬date#5⟭   3   70.05     70.05     0.00      ⟬uk_national_insurance_number#4⟭ FIT NOTE MISSING
100574  CC     ⟬date#5⟭   10  233.50    116.75    116.75
100582  CC     ⟬date#4⟭   5   116.75    116.75    0.00
100587  CC     ⟬date#4⟭   4   93.40     46.70     46.70
100591  CC     ⟬date#4⟭   0   0.00      233.50    -233.50   LEAVER
100596  IT     ⟬date#4⟭   8   186.80    0.00      186.80
100603  IT     ⟬date#3⟭   5   116.75    70.05     46.70
100608  FA     ⟬date#3⟭   2   46.70     46.70     0.00
100612  FA     ⟬date#3⟭   10  233.50    186.80    46.70     ⟬uk_national_insurance_number#5⟭ PHASED RETURN
100619  WH     ⟬date#3⟭   5   116.75    0.00      116.75
100625  WH     ⟬date#2⟭   3   70.05     0.00      70.05
100631  TR     ⟬date#2⟭   7   163.45    163.45    0.00
100638  TR     ⟬date#2⟭   5   116.75    0.00      116.75
100644  FN     ⟬date#2⟭   2   46.70     0.00      46.70
100651  CC     ⟬date#1⟭   5   116.75    0.00      116.75
100657  CC     ⟬date#1⟭   4   93.40     0.00      93.40
100663  IT     ⟬date#1⟭   3   70.05     0.00      70.05
TOTALS                  THIS 4599.95    LAST 3292.35    DIFF 1307.60
RECOVERY NONE  EMPLOYER BEARS ALL
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: en
fill_locale: en_GB
domain: housing
appearance: fixed-width row, title row, prepared by
scenario: repairs log, cleaned up before a mail merge
⟬text⟭
RESPONSIVE REPAIRS LOG          PREPARED BY: ⟬person_name#1⟭          ⟬date#1⟭
JOB       PROP      TRADE        PRI  ENG  RAISED      TARGET      STATE
R-80411   P-10231   PLUMBING     2    ⟬trap:initials|DM⟭   ⟬date#5⟭  ⟬date#3⟭  DONE
R-80415   P-10241   ELECTRICAL   1    ⟬trap:initials|PK⟭   ⟬date#4⟭  ⟬date#4⟭  DONE
R-80420   P-10250   ROOFING      3    ⟬trap:initials|DM⟭   ⟬date#4⟭  ⟬date#2⟭  OPEN
R-80426   P-10263   JOINERY      3    ⟬trap:initials|SH⟭   ⟬date#3⟭  ⟬date#1⟭  OPEN
R-80431   P-10281   DAMP         2    ⟬trap:initials|PK⟭   ⟬date#2⟭  ⟬date#1⟭  OPEN
⟬end⟭
