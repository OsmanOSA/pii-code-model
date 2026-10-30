⟬template⟭
family: tabular
format: SQL dump (.sql)
language: en
fill_locale: en_GB
domain: retail
appearance: sql comment, copy block, sql insert, sql owner clause
scenario: store stock counts, compared with last month
⟬text⟭
--
-- PostgreSQL database dump
-- Dumped from database version ⟬version#1⟭
-- Dump owner: ⟬trap:indicator_non_pii|stock_reporting⟭
-- Month-on-month count: restore beside last month's schema, then diff qty_now against qty_prev
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

CREATE TABLE stock_count (
    count_id uuid NOT NULL,
    store_no integer NOT NULL,
    sku varchar(12) NOT NULL,
    qty_now integer,
    qty_prev integer,
    counted_on date
);

COPY stock_count (count_id, store_no, sku, qty_now, qty_prev, counted_on) FROM stdin;
⟬uuid#1⟭	114	SKU-20418	212	240	⟬date#3⟭
⟬uuid#2⟭	114	SKU-20422	48	51	⟬date#3⟭
⟬uuid#3⟭	127	SKU-20418	97	133	⟬date#2⟭
⟬uuid#4⟭	127	SKU-31907	0	16	⟬date#2⟭
⟬uuid#5⟭	203	SKU-31907	305	288	⟬date#1⟭
⟬uuid#6⟭	203	SKU-40116	64	64	⟬date#1⟭
\.

CREATE TABLE sku_ref (sku varchar(12) PRIMARY KEY, descr text);
INSERT INTO sku_ref VALUES ('SKU-20418', '⟬trap:eponym|Granny Smith⟭ apples 6pk');
INSERT INTO sku_ref VALUES ('SKU-20422', '⟬trap:eponym|Earl Grey⟭ tea bags 80s');
INSERT INTO sku_ref VALUES ('SKU-31907', '⟬trap:eponym|Wellington⟭ boots size 8');
INSERT INTO sku_ref VALUES ('SKU-40116', '⟬trap:word_name|Rose⟭ scented candle');

ALTER TABLE stock_count OWNER TO ⟬trap:indicator_non_pii|stock_reporting⟭;
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: en
fill_locale: en_GB
domain: education
appearance: fixed-width row, free-text cell, report heading
scenario: library loans, requested by a regulator
⟬text⟭
LIBRARY LOANS RETURN  SCHOOL 4417  REQUESTED BY ⟬trap:indicator_non_pii|OFSTED DATA UNIT⟭  RUN ⟬date#1⟭
ACCESSION  ⟬trap:eponym|DEWEY⟭   OUT         DUE         FORM  ST    NOTE
0041872    823.91  ⟬date#7⟭  ⟬date#5⟭  7B    OUT
0041903    510.00  ⟬date#7⟭  ⟬date#5⟭  7B    OUT
0038811    942.05  ⟬date#6⟭  ⟬date#4⟭  9C    LOST  dad ⟬person_name#1m⟭ rang, will pay for it, tel ⟬phone#1⟭ after 4pm
0040256    599.00  ⟬date#6⟭  ⟬date#4⟭  9C    OUT
0039127    741.50  ⟬date#5⟭  ⟬date#3⟭  8A    LATE
0041555    530.00  ⟬date#4⟭  ⟬date#2⟭  10F   OUT   mum (⟬person_name#2f⟭) dropping it back, tel ⟬phone#2⟭
0037790    910.00  ⟬date#3⟭  ⟬date#1⟭  8A    OUT
0036114    372.21  ⟬date#3⟭  ⟬date#1⟭  11D   OUT
TRL 0008 LINES
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: housing
appearance: csv cell, note row above table, neutral header
scenario: void properties, exported for a quarterly audit
⟬text⟭
"return","period","run_on","ref","rows","state"
"void properties","Q3","⟬date#1⟭","⟬email#1⟭",8,"final"
"uprn","scheme","beds","void_from","days_void","reason"
100012044871,"⟬trap:word_name|⦃Family⦄ Court⟭",2,"⟬date#7⟭",61,"major works"
100012044902,"⟬trap:word_name|⦃Family⦄ Court⟭",1,"⟬date#6⟭",44,"awaiting asbestos survey"
100012051137,"Mill Rise",3,"⟬date#6⟭",40,"relet in progress"
100012051140,"Mill Rise",2,"⟬date#5⟭",33,"tenant deceased"
100012063318,"⟬trap:word_name|⦃Family2⦄ House⟭",1,"⟬date#4⟭",27,"damp treatment"
100012063322,"⟬trap:word_name|⦃Family2⦄ House⟭",1,"⟬date#3⟭",19,"relet in progress"
100012070495,"Station Yard",4,"⟬date#2⟭",12,"adaptations"
100012070501,"Station Yard",2,"⟬date#1⟭",5,"key safe missing"
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: healthcare
appearance: csv cell, contact column, sparse rows
scenario: equipment maintenance, cleaned up before a mail merge
⟬text⟭
"asset_tag","device","ward","last_service","next_due","service_status","contact_name","contact_email","contact_tel"
"MED-00412","⟬trap:eponym|Doppler⟭ fetal monitor","Maternity","⟬date#9⟭","⟬date#2⟭","OK","","",""
"MED-00418","Syringe driver","Ward 7","⟬date#9⟭","⟬date#2⟭","OK","","",""
"MED-00433","⟬trap:eponym|Holter⟭ recorder","Cardiology","⟬date#8⟭","⟬date#1⟭","DUE","⟬person_name#1⟭","⟬email#1⟭","⟬phone#1⟭"
"MED-00434","⟬trap:eponym|Holter⟭ recorder","Cardiology","⟬date#8⟭","⟬date#1⟭","DUE","","",""
"MED-00451","Infusion pump","⟬trap:eponym|⦃Family⦄ Ward⟭","⟬date#8⟭","⟬date#1⟭","OK","","",""
"MED-00452","Infusion pump","⟬trap:eponym|⦃Family⦄ Ward⟭","⟬date#7⟭","⟬date#1⟭","OK","","",""
"MED-00460","Pulse oximeter","Day Surgery","⟬date#7⟭","⟬date#1⟭","OK","","",""
"MED-00477","Defibrillator","A&E Resus","⟬date#6⟭","⟬date#1⟭","FAILED PAT","⟬person_name#2⟭","⟬email#2⟭","⟬phone#2⟭"
"MED-00478","Defibrillator","A&E Majors","⟬date#6⟭","⟬date#1⟭","OK","","",""
"MED-00489","Suction unit","Theatre 3","⟬date#6⟭","⟬date#1⟭","OK","","",""
"MED-00502","⟬trap:eponym|Guedel⟭ airway trolley","Theatre 3","⟬date#5⟭","⟬date#1⟭","OK","","",""
"MED-00503","Patient hoist","Ward 12","⟬date#5⟭","⟬date#1⟭","OVERDUE","","⟬email:generic#3⟭","⟬phone#3⟭"
"MED-00519","Blood gas analyser","ICU","⟬date#4⟭","⟬date#1⟭","OK","","",""
"MED-00520","Ventilator","ICU","⟬date#4⟭","⟬date#1⟭","OK","","",""
"MED-00534","ECG cart","Ward 7","⟬date#3⟭","⟬date#1⟭","OK","","",""
"MED-00541","Bladder scanner","Urology","⟬date#3⟭","⟬date#1⟭","OK","","",""
"MED-00556","Ophthalmoscope set","Outpatients","⟬date#2⟭","⟬date#1⟭","OK","","",""
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: housing
appearance: csv cell, dob column, sparse rows
scenario: rent arrears, kept as a manual backup
⟬text⟭
"tenancy_ref","scheme","tenant","dob","nino","iban","weeks_behind","balance_gbp","last_paid"
"T-20418","⟬trap:word_name|⦃Family⦄ Gardens⟭","","","","",6,412.30,"⟬date#2⟭"
"T-20421","⟬trap:word_name|⦃Family⦄ Gardens⟭","","","","",2,96.00,"⟬date#1⟭"
"T-20433","Kiln Lane flats","⟬person_name#1⟭","⟬birth_date#1⟭","⟬uk_national_insurance_number#1⟭","⟬iban#1⟭",11,870.15,"⟬date#5⟭"
"T-20440","Kiln Lane flats","","","","",3,141.75,"⟬date#1⟭"
"T-20447","Kiln Lane flats","","","","",1,38.20,"⟬date#1⟭"
"T-20452","Weir Court","","","","",4,214.60,"⟬date#2⟭"
"T-20455","Weir Court","","","","",9,688.00,"⟬date#4⟭"
"T-20461","Weir Court","⟬person_name#2⟭","⟬birth_date#2⟭","⟬uk_national_insurance_number#2⟭","⟬iban#2⟭",14,1102.48,"⟬date#6⟭"
"T-20468","Orchard Row","","","","",2,87.40,"⟬date#1⟭"
"T-20470","Orchard Row","","","","",5,330.90,"⟬date#3⟭"
"T-20476","Orchard Row","","","","",1,52.10,"⟬date#1⟭"
"T-20483","Beacon Heights","","","","",7,505.25,"⟬date#3⟭"
"T-20489","Beacon Heights","⟬person_name#3⟭","⟬birth_date#3⟭","","⟬iban#3⟭",19,1644.05,"⟬date#7⟭"
"T-20491","Beacon Heights","","","","",2,118.00,"⟬date#2⟭"
"T-20497","Beacon Heights","","","","",3,176.35,"⟬date#2⟭"
"T-20502","Foundry Walk","","","","",6,402.70,"⟬date#3⟭"
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: en
fill_locale: en_GB
domain: charities
appearance: spreadsheet row, footer row, numbered rows
scenario: Gift Aid donors, sent to an outside accountant
⟬text⟭
Book: GiftAid_claim_for_accountant.xlsx    Sheet: Donations    (values pasted as text)
Row  Donor ref       Gift date       Gross    Decl held   Reclaim
2    ⟬customer_id#1⟭      ⟬date#14⟭       25.00    Y           6.25
3    ⟬customer_id#2⟭      ⟬date#13⟭       10.00    Y           2.50
4    ⟬customer_id#3⟭      ⟬date#12⟭       50.00    Y           12.50
5    ⟬customer_id#4⟭      ⟬date#11⟭       100.00   Y           25.00
6    ⟬customer_id#5⟭      ⟬date#10⟭       15.00    N           0.00
7    ⟬customer_id#6⟭      ⟬date#9⟭        20.00    Y           5.00
8    ⟬customer_id#7⟭      ⟬date#8⟭        5.00     Y           1.25
9    ⟬customer_id#8⟭      ⟬date#7⟭        40.00    Y           10.00
10   ⟬customer_id#1⟭      ⟬date#6⟭        25.00    Y           6.25
11   ⟬customer_id#9⟭      ⟬date#5⟭        30.00    Y           7.50
12   ⟬customer_id#10⟭     ⟬date#4⟭        12.00    N           0.00
13   ⟬customer_id#11⟭     ⟬date#3⟭        60.00    Y           15.00
14   ⟬customer_id#2⟭      ⟬date#2⟭        10.00    Y           2.50
15   ⟬customer_id#12⟭     ⟬date#1⟭        75.00    Y           18.75
16   TOTAL                                477.00                112.50
17   Claim signed off by: ⟬trap:indicator_non_pii|Finance Committee⟭
18   Accountant: ⟬trap:company_name|⦃Family⦄ & Partners⟭ - please invoice your fee to ⟬postal_address#1⟭
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: en
fill_locale: en_GB
domain: payroll
appearance: fixed-width row, report heading, status column
scenario: cycle-to-work scheme, used to debug an import
⟬text⟭
CTW IMPORT TRACE   BATCH 0417   ⟬date#1⟭   RUN USER=⟬trap:indicator_non_pii|svc_ctw_import⟭
OWNER: ⟬trap:indicator_non_pii|PAYROLL OPS⟭   MAP FILE ⟬file_path#1⟭
NOTE  SOURCE COLUMNS SHIFTED: NAME HOLDS THE DEPARTMENT, EMAIL AND PHONE HOLD STATUS FLAGS
SEQ  PAYREF    NAME         EMAIL      PHONE     VOUCHER     VALUE     RESULT
001  P004417   ⟬trap:indicator_non_pii|WAREHOUSE⟭    ⟬trap:indicator_non_pii|PENDING⟭    ⟬trap:indicator_non_pii|NONE⟭      CTW-88120   1050.00   REJECTED
002  P004423   WAREHOUSE    ACTIVE     NONE      CTW-88121    799.00   REJECTED
003  P004518   FINANCE      ACTIVE     NONE      CTW-88122   1240.50   REJECTED
004  P004522   FINANCE      LAPSED     NONE      CTW-88123    650.00   REJECTED
005  P004609   FLEET        ACTIVE     ON FILE   CTW-88124    999.99   REJECTED
006  P004611   FLEET        ACTIVE     ON FILE   CTW-88125   1500.00   REJECTED
007  P004702   CUSTOMER CARE  PENDING  NONE      CTW-88126    875.00   REJECTED
008  P004730   CUSTOMER CARE  ACTIVE   ON FILE   CTW-88127    425.00   REJECTED
009  P004801   IT SERVICES  LAPSED     NONE      CTW-88128   2100.00   REJECTED
010  P004806   IT SERVICES  ACTIVE     NONE      CTW-88129    730.25   REJECTED
011  P004815   FACILITIES   PENDING    ON FILE   CTW-88130   1120.00   REJECTED
012  P004822   FACILITIES   ACTIVE     NONE      CTW-88131    560.00   REJECTED
TRL 012 READ 000 LOADED 012 REJECTED
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: retail
appearance: tsv cell, note row above table, delivery slots
scenario: supplier delivery slots, kept as a manual backup
⟬text⟭
Goods-in slots, back-up copy. Gatehouse tel ⟬phone#1⟭, regular trailer reg ⟬uk_license_plate#1⟭ uses bay 2 only							
Chilled van reg ⟬uk_license_plate#2⟭ comes via ⟬company#1⟭, driver mob ⟬phone#2⟭ if it runs late							
slot_date	slot_time	bay	supplier	po	pallets	status	note
⟬date#4⟭	06:00	1	⟬company#2⟭	⟬order_number#1⟭	12	arrived	
⟬date#4⟭	06:45	2	⟬trap:company_name|⦃Family⦄ Foods⟭	⟬order_number#2⟭	8	arrived	
⟬date#4⟭	07:30	1	⟬company#3⟭	⟬order_number#3⟭	22	arrived	short by 2
⟬date#4⟭	08:15	3	⟬company#4⟭	⟬order_number#4⟭	4	arrived	
⟬date#4⟭	09:00	2	⟬trap:company_name|⦃Family2⦄ & Sons⟭	⟬order_number#5⟭	16	arrived	
⟬date#4⟭	09:45	1	⟬company#5⟭	⟬order_number#6⟭	9	late	tail lift fault
⟬date#4⟭	10:30	3	⟬company#6⟭	⟬order_number#7⟭	6	arrived	
⟬date#4⟭	13:00	2	⟬company#2⟭	⟬order_number#8⟭	14	arrived	
⟬date#4⟭	14:15	1	⟬company#7⟭	⟬order_number#9⟭	11	arrived	
⟬date#3⟭	06:00	1	⟬company#3⟭	⟬order_number#10⟭	20	arrived	
⟬date#3⟭	06:45	2	⟬company#8⟭	⟬order_number#11⟭	7	arrived	
⟬date#3⟭	07:30	3	⟬trap:company_name|⦃Family⦄ Foods⟭	⟬order_number#12⟭	10	refused	temperature 9C on arrival
⟬date#3⟭	08:15	1	⟬company#4⟭	⟬order_number#13⟭	5	arrived	
⟬date#3⟭	09:00	2	⟬company#6⟭	⟬order_number#14⟭	13	arrived	
⟬date#3⟭	10:30	3	⟬company#9⟭	⟬order_number#15⟭	3	arrived	
⟬date#3⟭	11:15	1	⟬company#2⟭	⟬order_number#16⟭	18	late	
⟬date#3⟭	13:00	2	⟬company#5⟭	⟬order_number#17⟭	9	arrived	
⟬date#3⟭	14:15	3	⟬company#7⟭	⟬order_number#18⟭	6	arrived	
⟬date#2⟭	06:00	1	⟬company#3⟭	⟬order_number#19⟭	24	arrived	
⟬date#2⟭	06:45	2	⟬trap:company_name|⦃Family2⦄ & Sons⟭	⟬order_number#20⟭	15	arrived	
⟬date#2⟭	07:30	1	⟬company#8⟭	⟬order_number#21⟭	8	arrived	
⟬date#2⟭	08:15	3	⟬company#4⟭	⟬order_number#22⟭	4	arrived	pallets not wrapped
⟬date#2⟭	09:00	2	⟬company#6⟭	⟬order_number#23⟭	12	arrived	
⟬date#2⟭	09:45	1	⟬company#9⟭	⟬order_number#24⟭	2	arrived	
⟬date#2⟭	11:15	3	⟬company#2⟭	⟬order_number#25⟭	17	arrived	
⟬date#2⟭	13:00	2	⟬company#5⟭	⟬order_number#26⟭	10	no show	rebooked
⟬date#2⟭	14:15	1	⟬company#7⟭	⟬order_number#27⟭	7	arrived	
⟬date#1⟭	06:00	1	⟬company#3⟭	⟬order_number#28⟭	21	booked	
⟬date#1⟭	06:45	2	⟬trap:company_name|⦃Family⦄ Foods⟭	⟬order_number#29⟭	9	booked	
⟬date#1⟭	07:30	3	⟬company#8⟭	⟬order_number#30⟭	6	booked	
⟬date#1⟭	08:15	1	⟬company#4⟭	⟬order_number#31⟭	5	booked	
⟬date#1⟭	09:00	2	⟬company#6⟭	⟬order_number#32⟭	14	booked	
⟬date#1⟭	09:45	3	⟬company#9⟭	⟬order_number#33⟭	3	booked	
⟬date#1⟭	10:30	1	⟬company#5⟭	⟬order_number#34⟭	11	booked	
⟬date#1⟭	11:15	2	⟬company#2⟭	⟬order_number#35⟭	16	booked	
⟬date#1⟭	13:00	3	⟬trap:company_name|⦃Family2⦄ & Sons⟭	⟬order_number#36⟭	12	booked	
⟬date#1⟭	14:15	1	⟬company#7⟭	⟬order_number#37⟭	8	booked	
⟬date#1⟭	15:00	2	⟬company#3⟭	⟬order_number#38⟭	19	booked	
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: education
appearance: csv cell, first column, card column
scenario: school trip payments, attached to a ticket
⟬text⟭
"card_no","trip","form","pupil_ref","amount","taken_on","refund_status","ticket"
"⟬payment_card#1⟭","⟬trap:eponym|Darwin⟭ Centre visit","7B","⟬customer_id#1⟭",14.50,"⟬date#6⟭","none","⟬ticket_id#1⟭"
"⟬payment_card#2⟭","⟬trap:eponym|Darwin⟭ Centre visit","7B","⟬customer_id#2⟭",14.50,"⟬date#6⟭","none","⟬ticket_id#1⟭"
"⟬payment_card#3⟭","⟬trap:eponym|Darwin⟭ Centre visit","7C","⟬customer_id#3⟭",14.50,"⟬date#6⟭","duplicate, refund due","⟬ticket_id#1⟭"
"⟬payment_card#3⟭","⟬trap:eponym|Darwin⟭ Centre visit","7C","⟬customer_id#3⟭",14.50,"⟬date#5⟭","duplicate, refund due","⟬ticket_id#1⟭"
"⟬payment_card#4⟭","Outdoor centre residential","8A","⟬customer_id#4⟭",125.00,"⟬date#5⟭","none","⟬ticket_id#1⟭"
"⟬payment_card#5⟭","Outdoor centre residential","8A","⟬customer_id#5⟭",125.00,"⟬date#5⟭","none","⟬ticket_id#1⟭"
"⟬payment_card#6⟭","Outdoor centre residential","8D","⟬customer_id#6⟭",60.00,"⟬date#4⟭","part paid","⟬ticket_id#1⟭"
"⟬payment_card#6⟭","Outdoor centre residential","8D","⟬customer_id#6⟭",65.00,"⟬date#3⟭","none","⟬ticket_id#1⟭"
"⟬payment_card#7⟭","French exchange","9F","⟬customer_id#7⟭",210.00,"⟬date#4⟭","trip cancelled, refund due","⟬ticket_id#1⟭"
"⟬payment_card#8⟭","French exchange","9F","⟬customer_id#8⟭",210.00,"⟬date#4⟭","trip cancelled, refund due","⟬ticket_id#1⟭"
"⟬payment_card#9⟭","French exchange","9G","⟬customer_id#9⟭",210.00,"⟬date#3⟭","trip cancelled, refund due","⟬ticket_id#1⟭"
"⟬payment_card#10⟭","Science museum","10E","⟬customer_id#10⟭",18.00,"⟬date#3⟭","none","⟬ticket_id#1⟭"
"⟬payment_card#11⟭","Science museum","10E","⟬customer_id#11⟭",18.00,"⟬date#2⟭","none","⟬ticket_id#1⟭"
"⟬payment_card#12⟭","⟬trap:eponym|Shakespeare's Globe⟭ matinee","11A","⟬customer_id#12⟭",32.00,"⟬date#2⟭","none","⟬ticket_id#1⟭"
"⟬payment_card#13⟭","⟬trap:eponym|Shakespeare's Globe⟭ matinee","11A","⟬customer_id#13⟭",32.00,"⟬date#1⟭","card declined, retried","⟬ticket_id#1⟭"
"⟬payment_card#13⟭","⟬trap:eponym|Shakespeare's Globe⟭ matinee","11A","⟬customer_id#13⟭",32.00,"⟬date#1⟭","none","⟬ticket_id#1⟭"
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: healthcare
appearance: tsv cell, free-text comment cell, onboarding note
scenario: patient transport bookings, sampled for a test environment
⟬text⟭
booking_ref	pickup_slot	from_site	to_site	mobility	escort	comment
TB-30187	⟬date#4⟭ 09:40	Home	Renal Unit	wheelchair	N	
TB-30188	⟬date#4⟭ 10:05	Home	Renal Unit	walking	N	
TB-30189	⟬date#4⟭ 11:20	Day Hospital	Home	stretcher	Y	two crew, contact: ⟬trap:indicator_non_pii|transport desk⟭
TB-30191	⟬date#3⟭ 08:30	Home	⟬trap:eponym|⦃Family⦄ Wing⟭	walking	N	
TB-30192	⟬date#3⟭ 13:15	Home	⟬trap:eponym|⦃Family⦄ Wing⟭	wheelchair	Y	Driver sheet pasted here: Mr ⟬person_name#1m⟭, mob ⟬phone#1⟭, NI no ⟬uk_national_insurance_number#1⟭, licence ⟬uk_driving_licence#1⟭, home address ⟬postal_address#1⟭
TB-30195	⟬date#3⟭ 14:00	Eye Clinic	Home	walking	N	
TB-30196	⟬date#3⟭ 15:45	Eye Clinic	Home	walking	N	bring own drops
TB-30199	⟬date#2⟭ 07:50	Home	Oncology	wheelchair	N	
TB-30201	⟬date#2⟭ 08:10	Home	Oncology	walking	Y	
TB-30202	⟬date#2⟭ 12:30	Oncology	Home	stretcher	N	
TB-30204	⟬date#2⟭ 16:00	Home	Fracture Clinic	wheelchair	N	new volunteer driver, ⟬person_name#2⟭, tel ⟬phone#2⟭, licence ⟬uk_driving_licence#2⟭
TB-30207	⟬date#1⟭ 09:00	Home	Renal Unit	walking	N	
TB-30208	⟬date#1⟭ 09:25	Home	Renal Unit	walking	N	
TB-30210	⟬date#1⟭ 11:40	Fracture Clinic	Home	wheelchair	Y	
TB-30213	⟬date#1⟭ 14:10	Home	Audiology	walking	N	
TB-30215	⟬date#1⟭ 15:30	Audiology	Home	walking	N	
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: healthcare
appearance: tsv cell, figures only, merged sources
scenario: waiting referrals, merged from two sources
⟬text⟭
site	specialty	open_referrals	wk_0_6	wk_6_18	wk_18_plus	median_wait_wk	source
⟬city#1⟭	Cardiology	412	188	160	64	7.5	PAS
⟬city#1⟭	Dermatology	938	240	402	296	13.0	PAS
⟬city#1⟭	Gastroenterology	366	121	170	75	9.0	PAS
⟬city#1⟭	⟬trap:eponym|Crohn's⟭ and colitis	84	40	31	13	6.0	PAS
⟬city#1⟭	Neurology	271	70	128	73	12.5	PAS
⟬city#1⟭	⟬trap:eponym|Parkinson's⟭ service	59	33	20	6	5.0	PAS
⟬city#1⟭	Ophthalmology	1204	310	588	306	14.0	PAS
⟬city#2⟭	Cardiology	307	160	105	42	6.5	ERS
⟬city#2⟭	Dermatology	644	181	290	173	12.0	ERS
⟬city#2⟭	Gastroenterology	298	99	147	52	8.5	ERS
⟬city#2⟭	Neurology	190	52	98	40	11.0	ERS
⟬city#2⟭	⟬trap:eponym|Alzheimer's⟭ memory clinic	142	38	71	33	11.5	ERS
⟬city#2⟭	Ophthalmology	871	240	402	229	13.5	ERS
⟬city#3⟭	Cardiology	155	90	49	16	5.0	ERS
⟬city#3⟭	Dermatology	402	118	190	94	11.0	ERS
⟬city#3⟭	⟬trap:eponym|Hodgkin⟭ lymphoma follow-up	37	24	11	2	3.5	PAS
⟬city#3⟭	Ophthalmology	533	171	260	102	10.5	ERS
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: en
fill_locale: en_GB
domain: housing
appearance: spreadsheet row, column letters, neutral header
scenario: tenant satisfaction survey, shared with a manager for a meeting
⟬text⟭
Tenant satisfaction survey - copy for the housing managers' meeting - sheet "TSM responses"
       A        B                 C     D     E     F        G
1      Resp     Patch             Q1    Q2    Q3    Rec?     Extra
2      S-0412   North             4     5     4     Yes      tel ⟬phone#1⟭
3      S-0413   North             2     2     3     No       tel ⟬phone#2⟭
4      S-0417   North             5     4     5     Yes
5      S-0421   ⟬trap:word_name|⦃Family⦄ Park⟭      3     3     2     No       mob ⟬phone#3⟭
6      S-0422   ⟬trap:word_name|⦃Family⦄ Park⟭      4     4     4     Yes
7      S-0426   ⟬trap:word_name|⦃Family⦄ Park⟭      1     2     1     No       mob ⟬phone#4⟭
8      S-0430   Town Centre       5     5     5     Yes      tel ⟬phone#5⟭
9      S-0431   Town Centre       3     4     4     Yes
10     S-0437   Town Centre       2     1     2     No       tel ⟬phone#6⟭
11     S-0442   Riverside         4     3     4     Yes      mob ⟬phone#7⟭
12     S-0445   Riverside         4     4     3     Yes
13     S-0449   Riverside         3     2     2     No       tel ⟬phone#8⟭
14     Average                    3.3   3.3   3.3   58%
15     =AVERAGE(C2:C13) etc, ring-backs for the No rows only
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: en
fill_locale: en_GB
domain: payroll
appearance: cell dump, footer row, contact cell
scenario: holiday balances, sampled for a test environment
⟬text⟭
# cell dump of Sheet1 from holiday_balances_sample.xlsx, seeded into the UAT tenant
A1=EmpRef  B1=Dept  C1=Entitlement  D1=Taken  E1=Carried  F1=Balance
A2=E10442  B2=Warehouse  C2=28  D2=11.5  E2=2  F2=18.5
A3=E10451  B3=Warehouse  C3=28  D3=20  E3=0  F3=8
A4=E10460  B4=Transport  C4=25  D4=9  E4=5  F4=21
A5=E10467  B5=Transport  C5=25  D5=25  E5=0  F5=0
A6=E10473  B6=Finance  C6=30  D6=14  E6=3.5  F6=19.5
A7=E10479  B7=Finance  C7=30  D7=6  E7=0  F7=24
A8=E10488  B8=Customer Care  C8=27  D8=18  E8=1  F8=10
A9=E10490  B9=Customer Care  C9=27  D9=12.5  E9=0  F9=14.5
A10=E10496  B10=IT  C10=28  D10=3  E10=5  F10=30
A11=E10502  B11=IT  C11=28  D11=16  E11=0  F11=12
A12=E10509  B12=Facilities  C12=25  D12=22  E12=2  F12=5
A13=E10515  B13=Facilities  C13=25  D13=8  E13=0  F13=17
A14=Payroll contact  B14=⟬person_name#1⟭  C14=tel ⟬phone#1⟭
A15=Cover contact  B15=⟬person_name#2⟭  C15=tel ⟬phone#2⟭
A16=Source  B16=⟬trap:library|Sage⟭ export  C16=⟬date#1⟭
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: en
fill_locale: en_GB
domain: charities
appearance: markdown table, key value line, placeholder
scenario: mailing list, prepared for a migration to a new tool
⟬text⟭
# Mailing list migration: segment map

Owner: ⟬trap:indicator_non_pii|Supporter Care team⟭
Sender name: ⟬trap:indicator_non_pii|The Newsletter Desk⟭
API key for the new tool: ⟬trap:placeholder|<set after cutover>⟭

| segment_uuid | list | subscribers | opt_in_basis | new_tag |
| --- | --- | --- | --- | --- |
| ⟬uuid#1⟭ | Monthly newsletter | 18204 | consent | news |
| ⟬uuid#2⟭ | Volunteers | 2316 | consent | vol |
| ⟬uuid#3⟭ | Regular givers | 6790 | legitimate interest | rg |
| ⟬uuid#4⟭ | Legacy enquirers | 412 | consent | legacy |
| ⟬uuid#5⟭ | Lapsed, do not import | 9033 | none | skip |
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: en
fill_locale: en_GB
domain: education
appearance: markdown table, sparse rows, neutral header
scenario: after-school clubs, kept as a manual backup
⟬text⟭
# After-school clubs, manual copy

Pasted from the MIS club extract, which always adds three fields to every row: f5 is the child
holding the reserve place, f6 is the day that child was born, f7 is who to ring if the club is off.
Most rows have nothing there. Keep this copy in case the MIS is down on club days.

| Club | Day | Room | Starts | f5 | f6 | f7 |
| --- | --- | --- | --- | --- | --- | --- |
| Chess | Mon | ⟬trap:word_name|Hazel⟭ | ⟬date#4⟭ | | | |
| Netball | Mon | Sports hall | ⟬date#4⟭ | ⟬person_name#1⟭ | ⟬birth_date#1⟭ | ⟬phone#1⟭ |
| Coding | Mon | ICT 2 | ⟬date#4⟭ | | | |
| Choir | Tue | Music | ⟬date#3⟭ | | | |
| ⟬trap:eponym|Rubik's cube⟭ club | Tue | ⟬trap:word_name|Rowan⟭ | ⟬date#3⟭ | | | |
| Football Y5/6 | Tue | Field | ⟬date#3⟭ | ⟬person_name#2⟭ | ⟬birth_date#2⟭ | ⟬phone#2⟭ |
| Art | Wed | ⟬trap:word_name|Willow⟭ | ⟬date#2⟭ | | | |
| Gymnastics | Wed | Sports hall | ⟬date#2⟭ | | | |
| Homework club | Wed | Library | ⟬date#2⟭ | | | |
| Drama | Thu | Hall | ⟬date#1⟭ | ⟬person_name#3⟭ | ⟬birth_date#3⟭ | ⟬phone#3⟭ |
| Cookery | Thu | Food tech | ⟬date#1⟭ | | | |
| Recorders | Thu | Music | ⟬date#1⟭ | | | |
| Lego | Fri | ⟬trap:word_name|Holly⟭ | ⟬date#1⟭ | | | |
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: retail
appearance: tsv cell, free-text comment cell, initials
scenario: staff rota by store, cleaned up before a mail merge
⟬text⟭
store	wk	day	shift	staff_no	init	hrs	comment
Ashby	W31	Mon	06-14	40117	⟬trap:initials|KT⟭	8	
Ashby	W31	Mon	14-22	40122	⟬trap:initials|RM⟭	8	
Ashby	W31	Tue	06-14	40117	⟬trap:initials|KT⟭	8	swap agreed with ⟬email#1⟭, hours stay the same
Ashby	W31	Tue	14-22	40131	⟬trap:initials|JB⟭	8	
Ashby	W31	Wed	06-14	40122	⟬trap:initials|RM⟭	8	
Ashby	W31	Wed	14-22	40131	⟬trap:initials|JB⟭	8	
Ashby	W31	Sat	08-16	40140	⟬trap:initials|SO⟭	8	forward any queries to ⟬email:generic#3⟭
Ashby	W31	Sun	10-16	40140	⟬trap:initials|SO⟭	6	
Barton	W31	Mon	07-15	40208	⟬trap:initials|AL⟭	8	
Barton	W31	Mon	15-22	40215	⟬trap:initials|DP⟭	7	
Barton	W31	Tue	07-15	40208	⟬trap:initials|AL⟭	8	
Barton	W31	Tue	15-22	40219	⟬trap:initials|MH⟭	7	asked ⟬email#2⟭ about cover, no reply yet
Barton	W31	Thu	07-15	40215	⟬trap:initials|DP⟭	8	
Barton	W31	Thu	15-22	40219	⟬trap:initials|MH⟭	7	
Barton	W31	Sat	08-16	40227	⟬trap:initials|NC⟭	8	
Barton	W31	Sun	10-16	40227	⟬trap:initials|NC⟭	6	
Colby	W31	Fri	06-14	40304	⟬trap:initials|EW⟭	8	
Colby	W31	Fri	14-22	40311	⟬trap:initials|TF⟭	8	
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: en
fill_locale: en_GB
domain: payroll
appearance: tab paste, footer row, payment cell
scenario: expenses to reimburse, sampled for a test environment
⟬text⟭
Expenses to reimburse - sample rows for the test tenant - sheet "Claims"
Claim	Emp	Spent	Type	Net	VAT	Gross
EX-5512	E10442	⟬date#5⟭	Rail	42.50	0.00	42.50
EX-5513	E10442	⟬date#4⟭	Hotel	88.00	17.60	105.60
EX-5519	E10473	⟬date#4⟭	Mileage	31.05	0.00	31.05
EX-5521	E10488	⟬date#3⟭	Meals	18.20	3.64	21.84
EX-5524	E10502	⟬date#2⟭	Parking	9.00	1.80	10.80
EX-5526	E10502	⟬date#1⟭	Rail	27.40	0.00	27.40
Total						239.19
Reimburse to IBAN ⟬iban#1⟭ - remittance by post to ⟬postal_address#1⟭
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: en
fill_locale: en_GB
domain: housing
appearance: fixed-width row, payee block above table, sort code beside account
scenario: contractor invoices, requested by a regulator
⟬text⟭
REGULATOR RETURN RSH-22   CONTRACTOR INVOICES PAID   RUN ⟬date#1⟭
PAYEE ⟬person_name#1⟭   TRADING AS ⟬trap:company_name|⦃Family⦄ Roofing⟭
ADDR  ⟬postal_address#1⟭
BANK  SORT 30-92-41  ACCOUNT ⟬bank_account_number#1⟭
INVOICE         JOB        RAISED       NET        VAT       GROSS
⟬invoice_number#1⟭   J-70412    ⟬date#5⟭   1240.00    248.00    1488.00
⟬invoice_number#2⟭   J-70439    ⟬date#4⟭    860.00    172.00    1032.00
⟬invoice_number#3⟭   J-70455    ⟬date#3⟭   2315.50    463.10    2778.60
⟬invoice_number#4⟭   J-70468    ⟬date#2⟭    415.00     83.00     498.00
TOTAL                                 4830.50    966.10    5796.60
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: en
fill_locale: en_GB
domain: healthcare
appearance: csv cell, announcing header, status value
scenario: pharmacy orders, exported for a quarterly audit
⟬text⟭
"order_ref","item","qty","prescriber","patient","contact","status"
"⟬order_number#1⟭","⟬trap:eponym|Hartmann's⟭ solution 1L",40,"⟬trap:indicator_non_pii|Ward stock⟭","⟬trap:indicator_non_pii|Not applicable⟭","⟬trap:indicator_non_pii|Dispensary⟭","delivered"
"⟬order_number#2⟭","Paracetamol 500mg x100",120,"Ward stock","Not applicable","Dispensary","delivered"
"⟬order_number#3⟭","Amoxicillin 250mg x21",60,"Outpatient Pharmacy","Not applicable","Dispensary","delivered"
"⟬order_number#4⟭","⟬trap:eponym|Lugol's⟭ iodine 5%",6,"Theatres","Not applicable","Procurement","part delivered"
"⟬order_number#5⟭","Morphine sulfate 10mg/ml",20,"Controlled Drugs","Not applicable","CD Office","delivered"
"⟬order_number#6⟭","Insulin glargine pens",48,"Diabetes Service","Not applicable","Dispensary","delivered"
"⟬order_number#7⟭","Sodium chloride 0.9% 500ml",200,"Ward stock","Not applicable","Procurement","backordered"
"⟬order_number#8⟭","Salbutamol inhalers",90,"Respiratory","Not applicable","Dispensary","delivered"
"⟬order_number#9⟭","Omeprazole 20mg x28",150,"Outpatient Pharmacy","Not applicable","Dispensary","delivered"
"⟬order_number#10⟭","⟬trap:eponym|Ringer's⟭ lactate 1L",30,"Theatres","Not applicable","Procurement","cancelled"
"⟬order_number#11⟭","Lidocaine 1% 5ml",75,"Emergency Department","Not applicable","Dispensary","delivered"
"⟬order_number#12⟭","Enoxaparin 40mg syringes",110,"Ward stock","Not applicable","Procurement","delivered"
"⟬order_number#13⟭","Ondansetron 4mg x10",36,"Oncology","Not applicable","Dispensary","part delivered"
"⟬order_number#14⟭","Chlorhexidine wipes",400,"Infection Control","Not applicable","Procurement","delivered"
"⟬order_number#15⟭","Metformin 500mg x84",130,"Outpatient Pharmacy","Not applicable","Dispensary","delivered"
"Audit owner","⟬trap:indicator_non_pii|Medicines Optimisation⟭","","","","",""
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: en
fill_locale: en_GB
domain: charities
appearance: semicolon paste, free-text comment cell, sheet marker
scenario: volunteer shifts, compared with last month
⟬text⟭
=== Sheet: Shifts this month v last month ===
Shop;Slot;Booked;Last month;Diff;Note
High St;Mon am;3;4;-1;
High St;Mon pm;2;2;0;volunteer ⟬person_name#1⟭ moved to Weds
High St;Tue am;3;3;0;
High St;Tue pm;1;2;-1;Mrs ⟬person_name#2f⟭ off with her hip until further notice
High St;Wed am;4;3;1;
High St;Wed pm;3;2;1;
High St;Thu am;2;3;-1;
High St;Fri am;3;3;0;key holder is ⟬person_name#3⟭ on Fridays
High St;Sat am;4;4;0;
High St;Sat pm;2;3;-1;
Market Sq;Mon am;2;2;0;
Market Sq;Tue am;1;1;0;Mr ⟬person_name#4m⟭ is on his own, needs a second person for the till
Market Sq;Wed am;2;3;-1;
Market Sq;Thu am;2;2;0;
Market Sq;Fri am;3;2;1;new starter, ⟬person_name:given#5⟭, surname to follow
Market Sq;Sat am;3;3;0;
Market Sq;Sat pm;2;2;0;
=== end of sheet ===
⟬end⟭
