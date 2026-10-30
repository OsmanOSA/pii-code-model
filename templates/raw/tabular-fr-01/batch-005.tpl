⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: real estate
appearance: UPDATE with WHERE, IBAN, tax number, person in a WHERE clause
scenario: data fix script a developer wrote after a landlord changed bank, kept in a tickets folder
⟬text⟭
-- correction demandée par la gestion, voir ⟬ticket_id#1⟭
BEGIN;
UPDATE bailleur SET iban = '⟬iban#1⟭', num_fiscal = '⟬fr_tax_number#1⟭' WHERE nom = '⟬person_name#1⟭';
UPDATE bailleur SET iban = '⟬iban#2⟭' WHERE nom = '⟬person_name#2⟭' AND actif = 1;
SELECT nom, iban FROM bailleur WHERE num_fiscal = '⟬fr_tax_number#2⟭';
COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: associations
appearance: pasted cells, repeated header per group, subtotals, NIR, driving licence or None
scenario: tracking sheet of an inclusion work scheme run by an association, pasted site by site for its funder's annual review
⟬text⟭
Atelier chantier d'insertion - suivi des salariés en parcours
État du ⟬date#1⟭, encadrante : ⟬person_name#90f⟭

Maraîchage
Salarié	Naissance	Âge	N° SS	Domicile	Entrée	Prescripteur	Permis B
⟬person_name#1⟭	⟬birth_date#1⟭	⟬age#1⟭	⟬fr_social_security_number#1⟭	⟬fr_postal_address#1⟭	⟬date#4⟭	Conseil départemental	Non
⟬person_name#2⟭	⟬birth_date#2⟭	⟬age#2⟭	⟬fr_social_security_number#2⟭	⟬fr_postal_address#2⟭	⟬date#7⟭	Cap emploi	Non
⟬person_name#3⟭	⟬birth_date#3⟭	⟬age#3⟭	⟬fr_social_security_number#3⟭	⟬fr_postal_address#3⟭	⟬date#6⟭	Mission locale	Non
⟬person_name#4⟭	⟬birth_date#4⟭	⟬age#4⟭	⟬fr_social_security_number#4⟭	⟬fr_postal_address#4⟭	⟬date#8⟭	Mission locale	Non
⟬person_name#5⟭	⟬birth_date#5⟭	⟬age#5⟭	⟬fr_social_security_number#5⟭	⟬fr_postal_address#5⟭	⟬date#6⟭	Conseil départemental	Non
⟬person_name#6⟭	⟬birth_date#6⟭	⟬age#6⟭	⟬fr_social_security_number#6⟭	⟬fr_postal_address#6⟭	⟬date#4⟭	Mission locale	Non
⟬person_name#7⟭	⟬birth_date#7⟭	⟬age#7⟭	⟬fr_social_security_number#7⟭	⟬fr_postal_address#7⟭	⟬date#4⟭	Conseil départemental	Non
⟬person_name#8⟭	⟬birth_date#8⟭	⟬age#8⟭	⟬fr_social_security_number#8⟭	⟬fr_postal_address#8⟭	⟬date#7⟭	Conseil départemental	⟬fr_driving_licence#8⟭
⟬person_name#9⟭	⟬birth_date#9⟭	⟬age#9⟭	⟬fr_social_security_number#9⟭	⟬fr_postal_address#9⟭	⟬date#1⟭	Service social	Non
⟬person_name#10⟭	⟬birth_date#10⟭	⟬age#10⟭	⟬fr_social_security_number#10⟭	⟬fr_postal_address#10⟭	⟬date#1⟭	Service social	Non
⟬person_name#11⟭	⟬birth_date#11⟭	⟬age#11⟭	⟬fr_social_security_number#11⟭	⟬fr_postal_address#11⟭	⟬date#6⟭	Mission locale	⟬fr_driving_licence#11⟭
⟬person_name#12⟭	⟬birth_date#12⟭	⟬age#12⟭	⟬fr_social_security_number#12⟭	⟬fr_postal_address#12⟭	⟬date#6⟭	Conseil départemental	⟬fr_driving_licence#12⟭
⟬person_name#13⟭	⟬birth_date#13⟭	⟬age#13⟭	⟬fr_social_security_number#13⟭	⟬fr_postal_address#13⟭	⟬date#3⟭	Service social	Non
⟬person_name#14⟭	⟬birth_date#14⟭	⟬age#14⟭	⟬fr_social_security_number#14⟭	⟬fr_postal_address#14⟭	⟬date#5⟭	Mission locale	Non
⟬person_name#15⟭	⟬birth_date#15⟭	⟬age#15⟭	⟬fr_social_security_number#15⟭	⟬fr_postal_address#15⟭	⟬date#6⟭	Conseil départemental	Non
⟬person_name#16⟭	⟬birth_date#16⟭	⟬age#16⟭	⟬fr_social_security_number#16⟭	⟬fr_postal_address#16⟭	⟬date#1⟭	Conseil départemental	Non
⟬person_name#17⟭	⟬birth_date#17⟭	⟬age#17⟭	⟬fr_social_security_number#17⟭	⟬fr_postal_address#17⟭	⟬date#4⟭	Mission locale	Non
⟬person_name#18⟭	⟬birth_date#18⟭	⟬age#18⟭	⟬fr_social_security_number#18⟭	⟬fr_postal_address#18⟭	⟬date#2⟭	Mission locale	Non
Sous-total Maraîchage	18						
							
Recyclerie
Salarié	Naissance	Âge	N° SS	Domicile	Entrée	Prescripteur	Permis B
⟬person_name#19⟭	⟬birth_date#19⟭	⟬age#19⟭	⟬fr_social_security_number#19⟭	⟬fr_postal_address#19⟭	⟬date#6⟭	Service social	⟬fr_driving_licence#19⟭
⟬person_name#20⟭	⟬birth_date#20⟭	⟬age#20⟭	⟬fr_social_security_number#20⟭	⟬fr_postal_address#20⟭	⟬date#6⟭	Cap emploi	Non
⟬person_name#21⟭	⟬birth_date#21⟭	⟬age#21⟭	⟬fr_social_security_number#21⟭	⟬fr_postal_address#21⟭	⟬date#9⟭	Service social	Non
⟬person_name#22⟭	⟬birth_date#22⟭	⟬age#22⟭	⟬fr_social_security_number#22⟭	⟬fr_postal_address#22⟭	⟬date#4⟭	Cap emploi	⟬fr_driving_licence#22⟭
⟬person_name#23⟭	⟬birth_date#23⟭	⟬age#23⟭	⟬fr_social_security_number#23⟭	⟬fr_postal_address#23⟭	⟬date#5⟭	Conseil départemental	Non
⟬person_name#24⟭	⟬birth_date#24⟭	⟬age#24⟭	⟬fr_social_security_number#24⟭	⟬fr_postal_address#24⟭	⟬date#8⟭	Mission locale	⟬fr_driving_licence#24⟭
⟬person_name#25⟭	⟬birth_date#25⟭	⟬age#25⟭	⟬fr_social_security_number#25⟭	⟬fr_postal_address#25⟭	⟬date#6⟭	Cap emploi	Non
⟬person_name#26⟭	⟬birth_date#26⟭	⟬age#26⟭	⟬fr_social_security_number#26⟭	⟬fr_postal_address#26⟭	⟬date#9⟭	Cap emploi	⟬fr_driving_licence#26⟭
⟬person_name#27⟭	⟬birth_date#27⟭	⟬age#27⟭	⟬fr_social_security_number#27⟭	⟬fr_postal_address#27⟭	⟬date#2⟭	Mission locale	Non
⟬person_name#28⟭	⟬birth_date#28⟭	⟬age#28⟭	⟬fr_social_security_number#28⟭	⟬fr_postal_address#28⟭	⟬date#6⟭	Mission locale	Non
⟬person_name#29⟭	⟬birth_date#29⟭	⟬age#29⟭	⟬fr_social_security_number#29⟭	⟬fr_postal_address#29⟭	⟬date#1⟭	Service social	Non
⟬person_name#30⟭	⟬birth_date#30⟭	⟬age#30⟭	⟬fr_social_security_number#30⟭	⟬fr_postal_address#30⟭	⟬date#8⟭	Conseil départemental	Non
⟬person_name#31⟭	⟬birth_date#31⟭	⟬age#31⟭	⟬fr_social_security_number#31⟭	⟬fr_postal_address#31⟭	⟬date#5⟭	Cap emploi	Non
⟬person_name#32⟭	⟬birth_date#32⟭	⟬age#32⟭	⟬fr_social_security_number#32⟭	⟬fr_postal_address#32⟭	⟬date#8⟭	Cap emploi	Non
⟬person_name#33⟭	⟬birth_date#33⟭	⟬age#33⟭	⟬fr_social_security_number#33⟭	⟬fr_postal_address#33⟭	⟬date#8⟭	Cap emploi	Non
⟬person_name#34⟭	⟬birth_date#34⟭	⟬age#34⟭	⟬fr_social_security_number#34⟭	⟬fr_postal_address#34⟭	⟬date#2⟭	Service social	Non
⟬person_name#35⟭	⟬birth_date#35⟭	⟬age#35⟭	⟬fr_social_security_number#35⟭	⟬fr_postal_address#35⟭	⟬date#1⟭	Service social	⟬fr_driving_licence#35⟭
Sous-total Recyclerie	17						
							
Espaces verts
Salarié	Naissance	Âge	N° SS	Domicile	Entrée	Prescripteur	Permis B
⟬person_name#36⟭	⟬birth_date#36⟭	⟬age#36⟭	⟬fr_social_security_number#36⟭	⟬fr_postal_address#36⟭	⟬date#8⟭	Mission locale	⟬fr_driving_licence#36⟭
⟬person_name#37⟭	⟬birth_date#37⟭	⟬age#37⟭	⟬fr_social_security_number#37⟭	⟬fr_postal_address#37⟭	⟬date#9⟭	Cap emploi	Non
⟬person_name#38⟭	⟬birth_date#38⟭	⟬age#38⟭	⟬fr_social_security_number#38⟭	⟬fr_postal_address#38⟭	⟬date#2⟭	Service social	⟬fr_driving_licence#38⟭
⟬person_name#39⟭	⟬birth_date#39⟭	⟬age#39⟭	⟬fr_social_security_number#39⟭	⟬fr_postal_address#39⟭	⟬date#6⟭	Mission locale	Non
⟬person_name#40⟭	⟬birth_date#40⟭	⟬age#40⟭	⟬fr_social_security_number#40⟭	⟬fr_postal_address#40⟭	⟬date#9⟭	Mission locale	Non
⟬person_name#41⟭	⟬birth_date#41⟭	⟬age#41⟭	⟬fr_social_security_number#41⟭	⟬fr_postal_address#41⟭	⟬date#6⟭	Service social	Non
⟬person_name#42⟭	⟬birth_date#42⟭	⟬age#42⟭	⟬fr_social_security_number#42⟭	⟬fr_postal_address#42⟭	⟬date#4⟭	Cap emploi	Non
⟬person_name#43⟭	⟬birth_date#43⟭	⟬age#43⟭	⟬fr_social_security_number#43⟭	⟬fr_postal_address#43⟭	⟬date#6⟭	Service social	Non
⟬person_name#44⟭	⟬birth_date#44⟭	⟬age#44⟭	⟬fr_social_security_number#44⟭	⟬fr_postal_address#44⟭	⟬date#8⟭	Service social	⟬fr_driving_licence#44⟭
⟬person_name#45⟭	⟬birth_date#45⟭	⟬age#45⟭	⟬fr_social_security_number#45⟭	⟬fr_postal_address#45⟭	⟬date#4⟭	Service social	⟬fr_driving_licence#45⟭
⟬person_name#46⟭	⟬birth_date#46⟭	⟬age#46⟭	⟬fr_social_security_number#46⟭	⟬fr_postal_address#46⟭	⟬date#8⟭	Mission locale	⟬fr_driving_licence#46⟭
⟬person_name#47⟭	⟬birth_date#47⟭	⟬age#47⟭	⟬fr_social_security_number#47⟭	⟬fr_postal_address#47⟭	⟬date#9⟭	Mission locale	Non
⟬person_name#48⟭	⟬birth_date#48⟭	⟬age#48⟭	⟬fr_social_security_number#48⟭	⟬fr_postal_address#48⟭	⟬date#1⟭	Mission locale	Non
⟬person_name#49⟭	⟬birth_date#49⟭	⟬age#49⟭	⟬fr_social_security_number#49⟭	⟬fr_postal_address#49⟭	⟬date#2⟭	Cap emploi	Non
⟬person_name#50⟭	⟬birth_date#50⟭	⟬age#50⟭	⟬fr_social_security_number#50⟭	⟬fr_postal_address#50⟭	⟬date#2⟭	Mission locale	⟬fr_driving_licence#50⟭
Sous-total Espaces verts	15						
							
Confidentiel : ne pas diffuser hors du comité de suivi
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Markdown table, lost passports, dates
scenario: note from a consular desk in a shared document about passports reported lost this month
⟬text⟭
Passeports déclarés perdus, à invalider dans l'application :

| Titulaire | Passeport | Déclaré le |
| --- | --- | --- |
| ⟬person_name#1⟭ | ⟬fr_passport#1⟭ | ⟬date#1⟭ |
| ⟬person_name#2⟭ | ⟬fr_passport#2⟭ | ⟬date#2⟭ |
| ⟬person_name#3⟭ | ⟬fr_passport#3⟭ | ⟬date#2⟭ |
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: HR
appearance: transfer list, bank account, no header
scenario: salary transfer lines cut from a bank remittance file by the accounting team, with no column header
⟬text⟭
VIR ⟬date#1⟭  ⟬bank_account_number#1⟭  2284,16  ⟬person_name#1⟭
VIR ⟬date#1⟭  ⟬bank_account_number#2⟭  3127,90  ⟬person_name#2⟭
VIR ⟬date#1⟭  ⟬bank_account_number#3⟭  1893,42  ⟬person_name#3⟭
VIR ⟬date#1⟭  ⟬bank_account_number#4⟭  2610,05  ⟬person_name#4⟭
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: semicolon CSV, diseases named after people, referent column with no person
scenario: yearly case counts per disease computed by a hospital's medical information department, with no patient or doctor
⟬text⟭
pathologie;mode_prise_en_charge;nb_sejours;duree_moyenne;referent
⟬trap:eponym|Syndrome de Sjögren⟭;Hospitalisation;970;2;⟬trap:indicator_non_pii|Non applicable⟭
⟬trap:eponym|Syndrome de Guillain-Barré⟭;Hôpital de jour;193;34;⟬trap:indicator_non_pii|Non applicable⟭
⟬trap:eponym|Maladie de Charcot⟭;Consultation;708;25;⟬trap:indicator_non_pii|Service information médicale⟭
⟬trap:eponym|Maladie de Basedow⟭;Hospitalisation;831;5;⟬trap:indicator_non_pii|Service information médicale⟭
⟬trap:eponym|Maladie d'Alzheimer⟭;Hôpital de jour;951;16;⟬trap:indicator_non_pii|Registre régional⟭
⟬trap:eponym|Lymphome de Hodgkin⟭;Hospitalisation;515;20;⟬trap:indicator_non_pii|Non applicable⟭
⟬trap:eponym|Maladie de Basedow⟭;Consultation;477;21;⟬trap:indicator_non_pii|Non applicable⟭
⟬trap:eponym|Syndrome de Sjögren⟭;Hôpital de jour;726;29;⟬trap:indicator_non_pii|Registre régional⟭
⟬trap:eponym|Maladie d'Alzheimer⟭;Consultation;828;13;⟬trap:indicator_non_pii|Service information médicale⟭
⟬trap:eponym|Maladie de Charcot⟭;Hospitalisation;595;24;⟬trap:indicator_non_pii|Service information médicale⟭
⟬trap:eponym|Maladie de Crohn⟭;Consultation;237;4;⟬trap:indicator_non_pii|Registre régional⟭
⟬trap:eponym|Maladie de Charcot⟭;Hôpital de jour;161;11;⟬trap:indicator_non_pii|Registre régional⟭
⟬trap:eponym|Maladie d'Alzheimer⟭;Consultation;502;12;⟬trap:indicator_non_pii|Registre régional⟭
⟬trap:eponym|Maladie d'Alzheimer⟭;Hôpital de jour;776;30;⟬trap:indicator_non_pii|Registre régional⟭
⟬trap:eponym|Maladie de Crohn⟭;Hôpital de jour;717;20;⟬trap:indicator_non_pii|Registre régional⟭
⟬trap:eponym|Lymphome de Hodgkin⟭;Consultation;924;19;⟬trap:indicator_non_pii|Non applicable⟭
⟬trap:eponym|Maladie d'Alzheimer⟭;Consultation;199;6;⟬trap:indicator_non_pii|Non applicable⟭
⟬trap:eponym|Syndrome de Sjögren⟭;Consultation;276;31;⟬trap:indicator_non_pii|Registre régional⟭
⟬trap:eponym|Maladie de Basedow⟭;Hôpital de jour;889;17;⟬trap:indicator_non_pii|Service information médicale⟭
⟬trap:eponym|Syndrome de Sjögren⟭;Consultation;880;2;⟬trap:indicator_non_pii|Service information médicale⟭
⟬trap:eponym|Maladie de Crohn⟭;Hospitalisation;911;19;⟬trap:indicator_non_pii|Registre régional⟭
⟬trap:eponym|Maladie de Basedow⟭;Consultation;845;15;⟬trap:indicator_non_pii|Non applicable⟭
⟬trap:eponym|Maladie de Parkinson⟭;Consultation;661;14;⟬trap:indicator_non_pii|Service information médicale⟭
⟬trap:eponym|Maladie de Basedow⟭;Hôpital de jour;583;15;⟬trap:indicator_non_pii|Non applicable⟭
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: real estate
appearance: TSV cell, civil title column, birth date and city, identity documents, anti-money-laundering file
scenario: buyer identity register a real estate agency must keep against money laundering, exported for its yearly control
⟬text⟭
dossier	civ	acquereur	ne_le	ne_a	piece	numero	prix	origine_fonds	verifie_le	mail
5561	M.	⟬person_name#1m⟭	⟬birth_date#1⟭	⟬city#1⟭	CNI	⟬fr_identity_card#1⟭	498 000	Vente immobilière	⟬date#2⟭	⟬email#1⟭
5802	M.	⟬person_name#2m⟭	⟬birth_date#2⟭	⟬city#2⟭	CNI	⟬fr_identity_card#2⟭	645 000	Prêt	⟬date#5⟭	⟬email#2⟭
7209	Mme	⟬person_name#3f⟭	⟬birth_date#3⟭	⟬city#3⟭	Passeport	⟬fr_passport#3⟭	521 000	Épargne	⟬date#2⟭	⟬email#3⟭
9861	Mme	⟬person_name#4f⟭	⟬birth_date#4⟭	⟬city#4⟭	Passeport	⟬fr_passport#4⟭	391 000	Prêt	⟬date#5⟭	⟬email#4⟭
8044	Mme	⟬person_name#5f⟭	⟬birth_date#5⟭	⟬city#5⟭	CNI	⟬fr_identity_card#5⟭	835 000	Vente immobilière	⟬date#6⟭	⟬email#5⟭
9576	Mme	⟬person_name#6f⟭	⟬birth_date#6⟭	⟬city#6⟭	Passeport	⟬fr_passport#6⟭	244 000	Épargne	⟬date#4⟭	⟬email#6⟭
7700	Mme	⟬person_name#7f⟭	⟬birth_date#7⟭	⟬city#7⟭	CNI	⟬fr_identity_card#7⟭	724 000	Prêt	⟬date#1⟭	⟬email#7⟭
7134	M.	⟬person_name#8m⟭	⟬birth_date#8⟭	⟬city#8⟭	CNI	⟬fr_identity_card#8⟭	638 000	Épargne	⟬date#5⟭	⟬email#8⟭
5662	M.	⟬person_name#9m⟭	⟬birth_date#9⟭	⟬city#9⟭	Passeport	⟬fr_passport#9⟭	500 000	Prêt	⟬date#4⟭	⟬email#9⟭
6267	M.	⟬person_name#10m⟭	⟬birth_date#10⟭	⟬city#10⟭	CNI	⟬fr_identity_card#10⟭	340 000	Prêt	⟬date#4⟭	⟬email#10⟭
9443	M.	⟬person_name#11m⟭	⟬birth_date#11⟭	⟬city#11⟭	CNI	⟬fr_identity_card#11⟭	455 000	Prêt	⟬date#3⟭	⟬email#11⟭
6305	M.	⟬person_name#12m⟭	⟬birth_date#12⟭	⟬city#12⟭	CNI	⟬fr_identity_card#12⟭	738 000	Épargne	⟬date#2⟭	⟬email#12⟭
9106	Mme	⟬person_name#13f⟭	⟬birth_date#13⟭	⟬city#13⟭	CNI	⟬fr_identity_card#13⟭	394 000	Épargne	⟬date#4⟭	⟬email#13⟭
9150	M.	⟬person_name#14m⟭	⟬birth_date#14⟭	⟬city#14⟭	CNI	⟬fr_identity_card#14⟭	531 000	Prêt et apport	⟬date#2⟭	⟬email#14⟭
8994	Mme	⟬person_name#15f⟭	⟬birth_date#15⟭	⟬city#15⟭	CNI	⟬fr_identity_card#15⟭	307 000	Vente immobilière	⟬date#5⟭	⟬email#15⟭
8153	M.	⟬person_name#16m⟭	⟬birth_date#16⟭	⟬city#16⟭	CNI	⟬fr_identity_card#16⟭	455 000	Prêt et apport	⟬date#4⟭	⟬email#16⟭
6379	M.	⟬person_name#17m⟭	⟬birth_date#17⟭	⟬city#17⟭	CNI	⟬fr_identity_card#17⟭	488 000	Épargne	⟬date#5⟭	⟬email#17⟭
6952	M.	⟬person_name#18m⟭	⟬birth_date#18⟭	⟬city#18⟭	Passeport	⟬fr_passport#18⟭	451 000	Épargne	⟬date#1⟭	⟬email#18⟭
7171	Mme	⟬person_name#19f⟭	⟬birth_date#19⟭	⟬city#19⟭	Passeport	⟬fr_passport#19⟭	828 000	Vente immobilière	⟬date#2⟭	⟬email#19⟭
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: associations
appearance: quoted identifiers, INSERT with column list, split address, supplier SIREN
scenario: dump of a music school association's database, exported by its web host from the members and suppliers tables
⟬text⟭
BEGIN;
CREATE TABLE "membres"(
  "id" INTEGER PRIMARY KEY,
  "nom" TEXT,
  "ne_le" TEXT,
  "rue" TEXT,
  "cp" TEXT,
  "ville" TEXT,
  "iban" TEXT
);
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(1,'⟬person_name#1⟭','⟬birth_date#1⟭','⟬fr_postal_address:street#1⟭','⟬postcode#1⟭','⟬city#1⟭','⟬iban#1⟭');
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(2,'⟬person_name#2⟭','⟬birth_date#2⟭','⟬fr_postal_address:street#2⟭','⟬postcode#2⟭','⟬city#2⟭','⟬iban#2⟭');
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(3,'⟬person_name#3⟭','⟬birth_date#3⟭','⟬fr_postal_address:street#3⟭','⟬postcode#3⟭','⟬city#3⟭','⟬iban#3⟭');
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(4,'⟬person_name#4⟭','⟬birth_date#4⟭','⟬fr_postal_address:street#4⟭','⟬postcode#4⟭','⟬city#4⟭','⟬iban#4⟭');
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(5,'⟬person_name#5⟭','⟬birth_date#5⟭','⟬fr_postal_address:street#5⟭','⟬postcode#5⟭','⟬city#5⟭','⟬iban#5⟭');
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(6,'⟬person_name#6⟭','⟬birth_date#6⟭','⟬fr_postal_address:street#6⟭','⟬postcode#6⟭','⟬city#6⟭','⟬iban#6⟭');
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(7,'⟬person_name#7⟭','⟬birth_date#7⟭','⟬fr_postal_address:street#7⟭','⟬postcode#7⟭','⟬city#7⟭','⟬iban#7⟭');
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(8,'⟬person_name#8⟭','⟬birth_date#8⟭','⟬fr_postal_address:street#8⟭','⟬postcode#8⟭','⟬city#8⟭','⟬iban#8⟭');
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(9,'⟬person_name#9⟭','⟬birth_date#9⟭','⟬fr_postal_address:street#9⟭','⟬postcode#9⟭','⟬city#9⟭','⟬iban#9⟭');
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(10,'⟬person_name#10⟭','⟬birth_date#10⟭','⟬fr_postal_address:street#10⟭','⟬postcode#10⟭','⟬city#10⟭','⟬iban#10⟭');
INSERT INTO "membres"("id","nom","ne_le","rue","cp","ville","iban") VALUES(11,'⟬person_name#11⟭','⟬birth_date#11⟭','⟬fr_postal_address:street#11⟭','⟬postcode#11⟭','⟬city#11⟭','⟬iban#11⟭');
CREATE TABLE "fournisseurs"("id" INTEGER PRIMARY KEY, "nom" TEXT, "siren" TEXT, "objet" TEXT);
INSERT INTO "fournisseurs"("id","nom","siren","objet") VALUES(1,'⟬company#30⟭','⟬fr_siren#30⟭','Partitions');
INSERT INTO "fournisseurs"("id","nom","siren","objet") VALUES(2,'⟬company#31⟭','⟬fr_siren#31⟭','Accordage des pianos');
INSERT INTO "fournisseurs"("id","nom","siren","objet") VALUES(3,'⟬trap:company_name|⦃Family⦄ Musique⟭','⟬fr_siren#32⟭','Location d''instruments');
COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: public administration
appearance: label and value cells, one record per block, identity card, tax number
scenario: social housing applications copied from a form-like sheet by a clerk, each file as a block of label and value cells
⟬text⟭
Commission d'attribution - dossiers présentés
	
Demande	729852
Demandeur	⟬person_name#1⟭
Né(e) le	⟬birth_date#1⟭
CNI	⟬fr_identity_card#1⟭
N° fiscal	⟬fr_tax_number#1⟭
Revenu fiscal	15 165
Commune souhaitée	⟬city#1⟭
Priorité	Aucune
	
Demande	800954
Demandeur	⟬person_name#2⟭
Né(e) le	⟬birth_date#2⟭
CNI	⟬fr_identity_card#2⟭
N° fiscal	⟬fr_tax_number#2⟭
Revenu fiscal	19 334
Commune souhaitée	⟬city#2⟭
Priorité	Aucune
	
Demande	439893
Demandeur	⟬person_name#3⟭
Né(e) le	⟬birth_date#3⟭
CNI	⟬fr_identity_card#3⟭
N° fiscal	⟬fr_tax_number#3⟭
Revenu fiscal	27 383
Commune souhaitée	⟬city#3⟭
Priorité	DALO
	
Demande	473617
Demandeur	⟬person_name#4⟭
Né(e) le	⟬birth_date#4⟭
CNI	⟬fr_identity_card#4⟭
N° fiscal	⟬fr_tax_number#4⟭
Revenu fiscal	15 124
Commune souhaitée	⟬city#4⟭
Priorité	Aucune
	
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: HR
appearance: Markdown table, birth date beside a medical visit date, NIR, driving licence or dash
scenario: list of employees due for an occupational health visit, kept by the site's safety officer in a team wiki
⟬text⟭
# Visites médicales à programmer

Liste à envoyer au service de santé au travail avant la fin du mois. Interlocuteur : ⟬person_name#30⟭.

| Salarié | Date de naissance | NIR | Poste | Permis | Dernière visite |
| --- | --- | --- | --- | --- | --- |
| ⟬person_name#1⟭ | ⟬birth_date#1⟭ | ⟬fr_social_security_number#1⟭ | Conduite PL | ⟬fr_driving_licence#1⟭ | ⟬date#9⟭ |
| ⟬person_name#2⟭ | ⟬birth_date#2⟭ | ⟬fr_social_security_number#2⟭ | Soudure | - | ⟬date#3⟭ |
| ⟬person_name#3⟭ | ⟬birth_date#3⟭ | ⟬fr_social_security_number#3⟭ | Cariste | - | ⟬date#5⟭ |
| ⟬person_name#4⟭ | ⟬birth_date#4⟭ | ⟬fr_social_security_number#4⟭ | Cariste | - | ⟬date#7⟭ |
| ⟬person_name#5⟭ | ⟬birth_date#5⟭ | ⟬fr_social_security_number#5⟭ | Quai | ⟬fr_driving_licence#5⟭ | ⟬date#2⟭ |
| ⟬person_name#6⟭ | ⟬birth_date#6⟭ | ⟬fr_social_security_number#6⟭ | Quai | - | ⟬date#3⟭ |
| ⟬person_name#7⟭ | ⟬birth_date#7⟭ | ⟬fr_social_security_number#7⟭ | Quai | ⟬fr_driving_licence#7⟭ | ⟬date#2⟭ |
| ⟬person_name#8⟭ | ⟬birth_date#8⟭ | ⟬fr_social_security_number#8⟭ | Quai | ⟬fr_driving_licence#8⟭ | ⟬date#4⟭ |
| ⟬person_name#9⟭ | ⟬birth_date#9⟭ | ⟬fr_social_security_number#9⟭ | Soudure | ⟬fr_driving_licence#9⟭ | ⟬date#8⟭ |
| ⟬person_name#10⟭ | ⟬birth_date#10⟭ | ⟬fr_social_security_number#10⟭ | Quai | ⟬fr_driving_licence#10⟭ | ⟬date#2⟭ |
| ⟬person_name#11⟭ | ⟬birth_date#11⟭ | ⟬fr_social_security_number#11⟭ | Soudure | ⟬fr_driving_licence#11⟭ | ⟬date#6⟭ |
| ⟬person_name#12⟭ | ⟬birth_date#12⟭ | ⟬fr_social_security_number#12⟭ | Quai | ⟬fr_driving_licence#12⟭ | ⟬date#3⟭ |
| ⟬person_name#13⟭ | ⟬birth_date#13⟭ | ⟬fr_social_security_number#13⟭ | Conduite PL | ⟬fr_driving_licence#13⟭ | ⟬date#2⟭ |
| ⟬person_name#14⟭ | ⟬birth_date#14⟭ | ⟬fr_social_security_number#14⟭ | Cariste | - | ⟬date#4⟭ |

Les caristes doivent présenter leur autorisation de conduite le jour de la visite.
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: education
appearance: fixed columns, room use, teacher field with no person
scenario: room occupation listing exported by a university's scheduling tool before lecturers are assigned
⟬text⟭
SALLE    CAP  LUNDI      MARDI      ENSEIGNANT
A101      40  TD MATHS   -          ⟬trap:indicator_non_pii|NON AFFECTE⟭
A102      40  -          TD INFO    ⟬trap:indicator_non_pii|NON AFFECTE⟭
AMPHI B  220  CM DROIT   CM ECO     ⟬trap:indicator_non_pii|VACATAIRE⟭
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: real estate
appearance: headerless semicolon CSV, company tenants, SIREN and address with no announcing word
scenario: headerless list of commercial leases taken from a property manager's quarterly invoicing run
⟬text⟭
⟬date#3⟭;37;⟬company#1⟭;⟬fr_siren#1⟭;⟬fr_postal_address#1⟭;4356,94;Entrepôt;⟬invoice_number#1⟭
⟬date#1⟭;110;⟬company#2⟭;⟬fr_siren#2⟭;⟬fr_postal_address#2⟭;1412,96;Commercial;⟬invoice_number#2⟭
⟬date#5⟭;28;⟬company#3⟭;⟬fr_siren#3⟭;⟬fr_postal_address#3⟭;5214,64;Entrepôt;⟬invoice_number#3⟭
⟬date#5⟭;223;⟬company#4⟭;⟬fr_siren#4⟭;⟬fr_postal_address#4⟭;2558,05;Entrepôt;⟬invoice_number#4⟭
⟬date#4⟭;225;⟬company#5⟭;⟬fr_siren#5⟭;⟬fr_postal_address#5⟭;890,73;Entrepôt;⟬invoice_number#5⟭
⟬date#3⟭;51;⟬company#6⟭;⟬fr_siren#6⟭;⟬fr_postal_address#6⟭;3655,10;Bureaux;⟬invoice_number#6⟭
⟬date#7⟭;212;⟬company#7⟭;⟬fr_siren#7⟭;⟬fr_postal_address#7⟭;3698,92;Bureaux;⟬invoice_number#7⟭
⟬date#7⟭;145;⟬company#8⟭;⟬fr_siren#8⟭;⟬fr_postal_address#8⟭;6375,72;Commercial;⟬invoice_number#8⟭
⟬date#7⟭;13;⟬company#9⟭;⟬fr_siren#9⟭;⟬fr_postal_address#9⟭;3418,88;Bureaux;⟬invoice_number#9⟭
⟬date#3⟭;113;⟬company#10⟭;⟬fr_siren#10⟭;⟬fr_postal_address#10⟭;7041,74;Commercial;⟬invoice_number#10⟭
⟬date#2⟭;90;⟬company#11⟭;⟬fr_siren#11⟭;⟬fr_postal_address#11⟭;2276,79;Commercial;⟬invoice_number#11⟭
⟬date#7⟭;14;⟬company#12⟭;⟬fr_siren#12⟭;⟬fr_postal_address#12⟭;1282,56;Bureaux;⟬invoice_number#12⟭
⟬date#1⟭;150;⟬company#13⟭;⟬fr_siren#13⟭;⟬fr_postal_address#13⟭;6301,32;Bureaux;⟬invoice_number#13⟭
⟬date#8⟭;179;⟬company#14⟭;⟬fr_siren#14⟭;⟬fr_postal_address#14⟭;4139,25;Entrepôt;⟬invoice_number#14⟭
⟬date#5⟭;27;⟬company#15⟭;⟬fr_siren#15⟭;⟬fr_postal_address#15⟭;3899,13;Entrepôt;⟬invoice_number#15⟭
⟬date#7⟭;223;⟬company#16⟭;⟬fr_siren#16⟭;⟬fr_postal_address#16⟭;5620,12;Bureaux;⟬invoice_number#16⟭
⟬date#2⟭;65;⟬company#17⟭;⟬fr_siren#17⟭;⟬fr_postal_address#17⟭;7074,40;Bureaux;⟬invoice_number#17⟭
⟬date#1⟭;21;⟬company#18⟭;⟬fr_siren#18⟭;⟬fr_postal_address#18⟭;3367,04;Entrepôt;⟬invoice_number#18⟭
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: associations
appearance: neutral headers, tax number, split bank details, token under a neutral header
scenario: regular donors export from a charity's tool, whose header row only gives positions
⟬text⟭
col1	col2	col3	col4	col5	col6	col7
⟬person_name#1⟭	⟬fr_tax_number#1⟭	⟬bank_account_number#1⟭	⟬bic#1⟭	200	M	⟬opaque_token#1⟭
⟬person_name#2⟭	⟬fr_tax_number#2⟭	⟬bank_account_number#2⟭	⟬bic#2⟭	389	M	⟬opaque_token#2⟭
⟬person_name#3⟭	⟬fr_tax_number#3⟭	⟬bank_account_number#3⟭	⟬bic#3⟭	23	T	⟬opaque_token#3⟭
⟬person_name#4⟭	⟬fr_tax_number#4⟭	⟬bank_account_number#4⟭	⟬bic#4⟭	59	A	⟬opaque_token#4⟭
⟬person_name#5⟭	⟬fr_tax_number#5⟭	⟬bank_account_number#5⟭	⟬bic#5⟭	324	T	⟬opaque_token#5⟭
⟬person_name#6⟭	⟬fr_tax_number#6⟭	⟬bank_account_number#6⟭	⟬bic#6⟭	327	M	⟬opaque_token#6⟭
⟬person_name#7⟭	⟬fr_tax_number#7⟭	⟬bank_account_number#7⟭	⟬bic#7⟭	242	T	⟬opaque_token#7⟭
⟬person_name#8⟭	⟬fr_tax_number#8⟭	⟬bank_account_number#8⟭	⟬bic#8⟭	112	A	⟬opaque_token#8⟭
⟬person_name#9⟭	⟬fr_tax_number#9⟭	⟬bank_account_number#9⟭	⟬bic#9⟭	142	A	⟬opaque_token#9⟭
⟬person_name#10⟭	⟬fr_tax_number#10⟭	⟬bank_account_number#10⟭	⟬bic#10⟭	154	M	⟬opaque_token#10⟭
⟬person_name#11⟭	⟬fr_tax_number#11⟭	⟬bank_account_number#11⟭	⟬bic#11⟭	248	T	⟬opaque_token#11⟭
⟬person_name#12⟭	⟬fr_tax_number#12⟭	⟬bank_account_number#12⟭	⟬bic#12⟭	69	T	⟬opaque_token#12⟭
⟬person_name#13⟭	⟬fr_tax_number#13⟭	⟬bank_account_number#13⟭	⟬bic#13⟭	208	M	⟬opaque_token#13⟭
⟬person_name#14⟭	⟬fr_tax_number#14⟭	⟬bank_account_number#14⟭	⟬bic#14⟭	21	T	⟬opaque_token#14⟭
⟬person_name#15⟭	⟬fr_tax_number#15⟭	⟬bank_account_number#15⟭	⟬bic#15⟭	318	A	⟬opaque_token#15⟭
⟬person_name#16⟭	⟬fr_tax_number#16⟭	⟬bank_account_number#16⟭	⟬bic#16⟭	230	T	⟬opaque_token#16⟭
⟬person_name#17⟭	⟬fr_tax_number#17⟭	⟬bank_account_number#17⟭	⟬bic#17⟭	104	M	⟬opaque_token#17⟭
⟬person_name#18⟭	⟬fr_tax_number#18⟭	⟬bank_account_number#18⟭	⟬bic#18⟭	24	M	⟬opaque_token#18⟭
⟬person_name#19⟭	⟬fr_tax_number#19⟭	⟬bank_account_number#19⟭	⟬bic#19⟭	189	T	⟬opaque_token#19⟭
⟬person_name#20⟭	⟬fr_tax_number#20⟭	⟬bank_account_number#20⟭	⟬bic#20⟭	25	T	⟬opaque_token#20⟭
⟬person_name#21⟭	⟬fr_tax_number#21⟭	⟬bank_account_number#21⟭	⟬bic#21⟭	271	A	⟬opaque_token#21⟭
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: public administration
appearance: reference tables, INSERT with column list, user created with a masked password, grants
scenario: reference data script of a county's open data portal, with towns and cantons and a technical account
⟬text⟭
-- Référentiel territorial, données publiques
CREATE TABLE canton (
    id integer PRIMARY KEY,
    libelle varchar(80),
    dept char(2)
);

CREATE TABLE commune (
    code_insee char(5) PRIMARY KEY,
    nom varchar(80) NOT NULL,
    cp char(5),
    population integer,
    canton_id integer REFERENCES canton (id)
);

CREATE USER opendata_ro IDENTIFIED BY '⟬trap:placeholder|xxxx⟭';
GRANT SELECT ON commune TO opendata_ro;
GRANT SELECT ON canton TO opendata_ro;

INSERT INTO canton (id, libelle, dept) VALUES (1, 'Canton 1', '69');
INSERT INTO canton (id, libelle, dept) VALUES (2, 'Canton 2', '01');
INSERT INTO canton (id, libelle, dept) VALUES (3, 'Canton 3', '42');
INSERT INTO canton (id, libelle, dept) VALUES (4, 'Canton 4', '01');
INSERT INTO canton (id, libelle, dept) VALUES (5, 'Canton 5', '69');
INSERT INTO canton (id, libelle, dept) VALUES (6, 'Canton 6', '69');
INSERT INTO canton (id, libelle, dept) VALUES (7, 'Canton 7', '01');
INSERT INTO canton (id, libelle, dept) VALUES (8, 'Canton 8', '69');
INSERT INTO canton (id, libelle, dept) VALUES (9, 'Canton 9', '69');
INSERT INTO canton (id, libelle, dept) VALUES (10, 'Canton 10', '38');
INSERT INTO canton (id, libelle, dept) VALUES (11, 'Canton 11', '01');
INSERT INTO canton (id, libelle, dept) VALUES (12, 'Canton 12', '69');
INSERT INTO canton (id, libelle, dept) VALUES (13, 'Canton 13', '01');
INSERT INTO canton (id, libelle, dept) VALUES (14, 'Canton 14', '01');

INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('20220', '⟬city#1⟭', '⟬postcode#1⟭', 20758, 17);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('26320', '⟬city#2⟭', '⟬postcode#2⟭', 75031, 17);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('83426', '⟬city#3⟭', '⟬postcode#3⟭', 73809, 14);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('62368', '⟬city#4⟭', '⟬postcode#4⟭', 36590, 17);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('29711', '⟬city#5⟭', '⟬postcode#5⟭', 29998, 16);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('32127', '⟬city#6⟭', '⟬postcode#6⟭', 54500, 14);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('71142', '⟬city#7⟭', '⟬postcode#7⟭', 76372, 2);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('37280', '⟬city#8⟭', '⟬postcode#8⟭', 55312, 13);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('44786', '⟬city#9⟭', '⟬postcode#9⟭', 44861, 3);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('82343', '⟬city#10⟭', '⟬postcode#10⟭', 50523, 1);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('68442', '⟬city#11⟭', '⟬postcode#11⟭', 8293, 12);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('64141', '⟬city#12⟭', '⟬postcode#12⟭', 23447, 10);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('15337', '⟬city#13⟭', '⟬postcode#13⟭', 22880, 8);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('31749', '⟬city#14⟭', '⟬postcode#14⟭', 83893, 18);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('01895', '⟬city#15⟭', '⟬postcode#15⟭', 2282, 2);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('42512', '⟬city#16⟭', '⟬postcode#16⟭', 38624, 4);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('01080', '⟬city#17⟭', '⟬postcode#17⟭', 5509, 3);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('75354', '⟬city#18⟭', '⟬postcode#18⟭', 7895, 5);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('40908', '⟬city#19⟭', '⟬postcode#19⟭', 75487, 5);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('90093', '⟬city#20⟭', '⟬postcode#20⟭', 8913, 14);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('49147', '⟬city#21⟭', '⟬postcode#21⟭', 22942, 18);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('91826', '⟬city#22⟭', '⟬postcode#22⟭', 76176, 5);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('16834', '⟬city#23⟭', '⟬postcode#23⟭', 45060, 15);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('08077', '⟬city#24⟭', '⟬postcode#24⟭', 6473, 15);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('52242', '⟬city#25⟭', '⟬postcode#25⟭', 34224, 9);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('83671', '⟬city#26⟭', '⟬postcode#26⟭', 24778, 10);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('34170', '⟬city#27⟭', '⟬postcode#27⟭', 53515, 5);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('68616', '⟬city#28⟭', '⟬postcode#28⟭', 32042, 7);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('06570', '⟬city#29⟭', '⟬postcode#29⟭', 33257, 6);
INSERT INTO commune (code_insee, nom, cp, population, canton_id) VALUES ('57321', '⟬city#30⟭', '⟬postcode#30⟭', 34089, 8);

-- Propriétaire du jeu de données : ⟬trap:indicator_non_pii|Direction de la donnée⟭
-- Contact : ⟬trap:indicator_non_pii|formulaire du portail⟭
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: HR
appearance: pasted cells, freelancers, SIREN and IBAN beside a person
scenario: freelancers on a project, pasted by the HR manager into a request for the purchasing department
⟬text⟭
Prestataire	SIREN	IBAN	TJM	Fin de mission
⟬person_name#1⟭	⟬fr_siren#1⟭	⟬iban#1⟭	640	⟬date#1⟭
⟬person_name#2⟭	⟬fr_siren#2⟭	⟬iban#2⟭	575	⟬date#1⟭
⟬company#3⟭	⟬fr_siren#3⟭	⟬iban#3⟭	890	⟬date#2⟭
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: education
appearance: Markdown table, canteen menu, dishes named after people
scenario: weekly canteen menu published on a school website, whose dishes carry the names of people
⟬text⟭
## Menu de la semaine

| Jour | Entrée | Plat | Dessert |
| --- | --- | --- | --- |
| Lundi | Carottes râpées | ⟬trap:eponym|Bœuf Stroganov⟭ | Yaourt |
| Mardi | Potage | Lasagnes ⟬trap:eponym|sauce Béchamel⟭ | ⟬trap:eponym|Pêche Melba⟭ |
| Jeudi | Salade verte | Poisson pané | ⟬trap:eponym|Tarte Tatin⟭ |
| Vendredi | Betteraves | Omelette | Compote |
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: fixed columns, activity groups, department head field with no person
scenario: quarterly activity table of a hospital unit, printed by its coding tool, with no stay or person
⟬text⟭
TABLEAU D'ACTIVITE PMSI                    TRIMESTRE EN COURS
UNITE 3120 - ⟬trap:eponym|PAVILLON BROCA⟭
MEDECIN RESPONSABLE : ⟬trap:indicator_non_pii|VACANT⟭
CONTACT DIM : ⟬trap:indicator_non_pii|EQUIPE CODAGE⟭

GHM      SEJOURS   DMS      TARIF    NIV
------   -------   -----   ------   ---
04K824      63    5,2     1244   B
01K34Z     188    3,7     7501   A
26K78Z     181   18,2     7879   B
04K692      12   18,7     4663   C
20Z72Z     192   16,2     8637   A
19C304      88    6,2     4354   C
03M402     162    1,8     6722   C
11K241     114   17,4     4162   B
28Z453      91   15,1     1353   B
09K113     136   17,5     4670   B
12K223     196    5,1     1462   C
27M14Z     187    4,3     7986   A
27Z48Z      93    4,9     3704   B
21K564     105    9,7     6746   C
23K482     159    5,3     5126   C
07K952      68   10,3     2247   B
19Z503      98    5,5     5625   C
18Z89Z      73    1,0     6666   A
------   -------   -----   ------   ---
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: associations
appearance: quoted comma CSV, shooting club, identity card, birth date beside a medical date
scenario: members of a shooting club exported for the federation, which requires an identity document for each licence
⟬text⟭
"licence","tireur","date_naissance","cni","adresse","discipline","certificat_medical","carnet_a_jour","mail","age"
"76263","⟬person_name#1⟭","⟬birth_date#1⟭","⟬fr_identity_card#1⟭","⟬fr_postal_address#1⟭","Pistolet","⟬date#8⟭","Oui","⟬email#1⟭","⟬age#1⟭"
"61552","⟬person_name#2⟭","⟬birth_date#2⟭","⟬fr_identity_card#2⟭","⟬fr_postal_address#2⟭","Arbalète","⟬date#2⟭","Oui","⟬email#2⟭","⟬age#2⟭"
"93282","⟬person_name#3⟭","⟬birth_date#3⟭","⟬fr_identity_card#3⟭","⟬fr_postal_address#3⟭","Arbalète","⟬date#4⟭","Non","⟬email#3⟭","⟬age#3⟭"
"58833","⟬person_name#4⟭","⟬birth_date#4⟭","⟬fr_identity_card#4⟭","⟬fr_postal_address#4⟭","Carabine","⟬date#7⟭","Non","⟬email#4⟭","⟬age#4⟭"
"44439","⟬person_name#5⟭","⟬birth_date#5⟭","⟬fr_identity_card#5⟭","⟬fr_postal_address#5⟭","Arbalète","⟬date#4⟭","Oui","⟬email#5⟭","⟬age#5⟭"
"52628","⟬person_name#6⟭","⟬birth_date#6⟭","⟬fr_identity_card#6⟭","⟬fr_postal_address#6⟭","Pistolet","⟬date#2⟭","Oui","⟬email#6⟭","⟬age#6⟭"
"49212","⟬person_name#7⟭","⟬birth_date#7⟭","⟬fr_identity_card#7⟭","⟬fr_postal_address#7⟭","Arbalète","⟬date#7⟭","Non","⟬email#7⟭","⟬age#7⟭"
"87027","⟬person_name#8⟭","⟬birth_date#8⟭","⟬fr_identity_card#8⟭","⟬fr_postal_address#8⟭","Pistolet","⟬date#2⟭","Oui","⟬email#8⟭","⟬age#8⟭"
"33228","⟬person_name#9⟭","⟬birth_date#9⟭","⟬fr_identity_card#9⟭","⟬fr_postal_address#9⟭","Carabine","⟬date#1⟭","Oui","⟬email#9⟭","⟬age#9⟭"
"88280","⟬person_name#10⟭","⟬birth_date#10⟭","⟬fr_identity_card#10⟭","⟬fr_postal_address#10⟭","Arbalète","⟬date#6⟭","Oui","⟬email#10⟭","⟬age#10⟭"
"59483","⟬person_name#11⟭","⟬birth_date#11⟭","⟬fr_identity_card#11⟭","⟬fr_postal_address#11⟭","Arbalète","⟬date#3⟭","Non","⟬email#11⟭","⟬age#11⟭"
"82349","⟬person_name#12⟭","⟬birth_date#12⟭","⟬fr_identity_card#12⟭","⟬fr_postal_address#12⟭","Carabine","⟬date#5⟭","Oui","⟬email#12⟭","⟬age#12⟭"
"52995","⟬person_name#13⟭","⟬birth_date#13⟭","⟬fr_identity_card#13⟭","⟬fr_postal_address#13⟭","Arbalète","⟬date#6⟭","Non","⟬email#13⟭","⟬age#13⟭"
"76201","⟬person_name#14⟭","⟬birth_date#14⟭","⟬fr_identity_card#14⟭","⟬fr_postal_address#14⟭","Pistolet","⟬date#5⟭","Oui","⟬email#14⟭","⟬age#14⟭"
"32946","⟬person_name#15⟭","⟬birth_date#15⟭","⟬fr_identity_card#15⟭","⟬fr_postal_address#15⟭","Carabine","⟬date#7⟭","Non","⟬email#15⟭","⟬age#15⟭"
"28349","⟬person_name#16⟭","⟬birth_date#16⟭","⟬fr_identity_card#16⟭","⟬fr_postal_address#16⟭","Pistolet","⟬date#3⟭","Oui","⟬email#16⟭","⟬age#16⟭"
"67173","⟬person_name#17⟭","⟬birth_date#17⟭","⟬fr_identity_card#17⟭","⟬fr_postal_address#17⟭","Pistolet","⟬date#4⟭","Non","⟬email#17⟭","⟬age#17⟭"
"15263","⟬person_name#18⟭","⟬birth_date#18⟭","⟬fr_identity_card#18⟭","⟬fr_postal_address#18⟭","Carabine","⟬date#1⟭","Non","⟬email#18⟭","⟬age#18⟭"
"56337","⟬person_name#19⟭","⟬birth_date#19⟭","⟬fr_identity_card#19⟭","⟬fr_postal_address#19⟭","Arbalète","⟬date#2⟭","Oui","⟬email#19⟭","⟬age#19⟭"
"38952","⟬person_name#20⟭","⟬birth_date#20⟭","⟬fr_identity_card#20⟭","⟬fr_postal_address#20⟭","Pistolet","⟬date#3⟭","Non","⟬email#20⟭","⟬age#20⟭"
"53285","⟬person_name#21⟭","⟬birth_date#21⟭","⟬fr_identity_card#21⟭","⟬fr_postal_address#21⟭","Arbalète","⟬date#1⟭","Oui","⟬email#21⟭","⟬age#21⟭"
"87332","⟬person_name#22⟭","⟬birth_date#22⟭","⟬fr_identity_card#22⟭","⟬fr_postal_address#22⟭","Pistolet","⟬date#5⟭","Oui","⟬email#22⟭","⟬age#22⟭"
"16126","⟬person_name#23⟭","⟬birth_date#23⟭","⟬fr_identity_card#23⟭","⟬fr_postal_address#23⟭","Arbalète","⟬date#3⟭","Oui","⟬email#23⟭","⟬age#23⟭"
"26516","⟬person_name#24⟭","⟬birth_date#24⟭","⟬fr_identity_card#24⟭","⟬fr_postal_address#24⟭","Arbalète","⟬date#4⟭","Oui","⟬email#24⟭","⟬age#24⟭"
"32309","⟬person_name#25⟭","⟬birth_date#25⟭","⟬fr_identity_card#25⟭","⟬fr_postal_address#25⟭","Carabine","⟬date#1⟭","Oui","⟬email#25⟭","⟬age#25⟭"
"15810","⟬person_name#26⟭","⟬birth_date#26⟭","⟬fr_identity_card#26⟭","⟬fr_postal_address#26⟭","Carabine","⟬date#4⟭","Oui","⟬email#26⟭","⟬age#26⟭"
"92725","⟬person_name#27⟭","⟬birth_date#27⟭","⟬fr_identity_card#27⟭","⟬fr_postal_address#27⟭","Pistolet","⟬date#2⟭","Non","⟬email#27⟭","⟬age#27⟭"
"85618","⟬person_name#28⟭","⟬birth_date#28⟭","⟬fr_identity_card#28⟭","⟬fr_postal_address#28⟭","Carabine","⟬date#7⟭","Oui","⟬email#28⟭","⟬age#28⟭"
"92580","⟬person_name#29⟭","⟬birth_date#29⟭","⟬fr_identity_card#29⟭","⟬fr_postal_address#29⟭","Pistolet","⟬date#3⟭","Non","⟬email#29⟭","⟬age#29⟭"
"52471","⟬person_name#30⟭","⟬birth_date#30⟭","⟬fr_identity_card#30⟭","⟬fr_postal_address#30⟭","Arbalète","⟬date#4⟭","Non","⟬email#30⟭","⟬age#30⟭"
"22275","⟬person_name#31⟭","⟬birth_date#31⟭","⟬fr_identity_card#31⟭","⟬fr_postal_address#31⟭","Pistolet","⟬date#5⟭","Oui","⟬email#31⟭","⟬age#31⟭"
"82075","⟬person_name#32⟭","⟬birth_date#32⟭","⟬fr_identity_card#32⟭","⟬fr_postal_address#32⟭","Pistolet","⟬date#3⟭","Oui","⟬email#32⟭","⟬age#32⟭"
"60025","⟬person_name#33⟭","⟬birth_date#33⟭","⟬fr_identity_card#33⟭","⟬fr_postal_address#33⟭","Arbalète","⟬date#6⟭","Non","⟬email#33⟭","⟬age#33⟭"
"38072","⟬person_name#34⟭","⟬birth_date#34⟭","⟬fr_identity_card#34⟭","⟬fr_postal_address#34⟭","Arbalète","⟬date#2⟭","Oui","⟬email#34⟭","⟬age#34⟭"
"54609","⟬person_name#35⟭","⟬birth_date#35⟭","⟬fr_identity_card#35⟭","⟬fr_postal_address#35⟭","Carabine","⟬date#4⟭","Non","⟬email#35⟭","⟬age#35⟭"
"24689","⟬person_name#36⟭","⟬birth_date#36⟭","⟬fr_identity_card#36⟭","⟬fr_postal_address#36⟭","Carabine","⟬date#2⟭","Oui","⟬email#36⟭","⟬age#36⟭"
"59557","⟬person_name#37⟭","⟬birth_date#37⟭","⟬fr_identity_card#37⟭","⟬fr_postal_address#37⟭","Carabine","⟬date#3⟭","Non","⟬email#37⟭","⟬age#37⟭"
"49939","⟬person_name#38⟭","⟬birth_date#38⟭","⟬fr_identity_card#38⟭","⟬fr_postal_address#38⟭","Pistolet","⟬date#1⟭","Oui","⟬email#38⟭","⟬age#38⟭"
"32614","⟬person_name#39⟭","⟬birth_date#39⟭","⟬fr_identity_card#39⟭","⟬fr_postal_address#39⟭","Pistolet","⟬date#3⟭","Oui","⟬email#39⟭","⟬age#39⟭"
"18418","⟬person_name#40⟭","⟬birth_date#40⟭","⟬fr_identity_card#40⟭","⟬fr_postal_address#40⟭","Pistolet","⟬date#1⟭","Oui","⟬email#40⟭","⟬age#40⟭"
"91490","⟬person_name#41⟭","⟬birth_date#41⟭","⟬fr_identity_card#41⟭","⟬fr_postal_address#41⟭","Pistolet","⟬date#8⟭","Oui","⟬email#41⟭","⟬age#41⟭"
"56755","⟬person_name#42⟭","⟬birth_date#42⟭","⟬fr_identity_card#42⟭","⟬fr_postal_address#42⟭","Arbalète","⟬date#2⟭","Non","⟬email#42⟭","⟬age#42⟭"
"12035","⟬person_name#43⟭","⟬birth_date#43⟭","⟬fr_identity_card#43⟭","⟬fr_postal_address#43⟭","Pistolet","⟬date#4⟭","Oui","⟬email#43⟭","⟬age#43⟭"
"27929","⟬person_name#44⟭","⟬birth_date#44⟭","⟬fr_identity_card#44⟭","⟬fr_postal_address#44⟭","Arbalète","⟬date#1⟭","Oui","⟬email#44⟭","⟬age#44⟭"
"87524","⟬person_name#45⟭","⟬birth_date#45⟭","⟬fr_identity_card#45⟭","⟬fr_postal_address#45⟭","Carabine","⟬date#4⟭","Oui","⟬email#45⟭","⟬age#45⟭"
"61328","⟬person_name#46⟭","⟬birth_date#46⟭","⟬fr_identity_card#46⟭","⟬fr_postal_address#46⟭","Arbalète","⟬date#3⟭","Oui","⟬email#46⟭","⟬age#46⟭"
"26579","⟬person_name#47⟭","⟬birth_date#47⟭","⟬fr_identity_card#47⟭","⟬fr_postal_address#47⟭","Carabine","⟬date#3⟭","Oui","⟬email#47⟭","⟬age#47⟭"
"50137","⟬person_name#48⟭","⟬birth_date#48⟭","⟬fr_identity_card#48⟭","⟬fr_postal_address#48⟭","Arbalète","⟬date#8⟭","Non","⟬email#48⟭","⟬age#48⟭"
"48787","⟬person_name#49⟭","⟬birth_date#49⟭","⟬fr_identity_card#49⟭","⟬fr_postal_address#49⟭","Arbalète","⟬date#8⟭","Oui","⟬email#49⟭","⟬age#49⟭"
"33378","⟬person_name#50⟭","⟬birth_date#50⟭","⟬fr_identity_card#50⟭","⟬fr_postal_address#50⟭","Carabine","⟬date#7⟭","Non","⟬email#50⟭","⟬age#50⟭"
"28117","⟬person_name#51⟭","⟬birth_date#51⟭","⟬fr_identity_card#51⟭","⟬fr_postal_address#51⟭","Arbalète","⟬date#3⟭","Oui","⟬email#51⟭","⟬age#51⟭"
"71340","⟬person_name#52⟭","⟬birth_date#52⟭","⟬fr_identity_card#52⟭","⟬fr_postal_address#52⟭","Pistolet","⟬date#8⟭","Oui","⟬email#52⟭","⟬age#52⟭"
"82922","⟬person_name#53⟭","⟬birth_date#53⟭","⟬fr_identity_card#53⟭","⟬fr_postal_address#53⟭","Carabine","⟬date#7⟭","Oui","⟬email#53⟭","⟬age#53⟭"
"46526","⟬person_name#54⟭","⟬birth_date#54⟭","⟬fr_identity_card#54⟭","⟬fr_postal_address#54⟭","Arbalète","⟬date#1⟭","Oui","⟬email#54⟭","⟬age#54⟭"
"51612","⟬person_name#55⟭","⟬birth_date#55⟭","⟬fr_identity_card#55⟭","⟬fr_postal_address#55⟭","Arbalète","⟬date#4⟭","Oui","⟬email#55⟭","⟬age#55⟭"
"47044","⟬person_name#56⟭","⟬birth_date#56⟭","⟬fr_identity_card#56⟭","⟬fr_postal_address#56⟭","Carabine","⟬date#6⟭","Non","⟬email#56⟭","⟬age#56⟭"
"50240","⟬person_name#57⟭","⟬birth_date#57⟭","⟬fr_identity_card#57⟭","⟬fr_postal_address#57⟭","Arbalète","⟬date#4⟭","Oui","⟬email#57⟭","⟬age#57⟭"
"14941","⟬person_name#58⟭","⟬birth_date#58⟭","⟬fr_identity_card#58⟭","⟬fr_postal_address#58⟭","Arbalète","⟬date#6⟭","Non","⟬email#58⟭","⟬age#58⟭"
"55103","⟬person_name#59⟭","⟬birth_date#59⟭","⟬fr_identity_card#59⟭","⟬fr_postal_address#59⟭","Arbalète","⟬date#8⟭","Oui","⟬email#59⟭","⟬age#59⟭"
"88521","⟬person_name#60⟭","⟬birth_date#60⟭","⟬fr_identity_card#60⟭","⟬fr_postal_address#60⟭","Carabine","⟬date#3⟭","Non","⟬email#60⟭","⟬age#60⟭"
"10738","⟬person_name#61⟭","⟬birth_date#61⟭","⟬fr_identity_card#61⟭","⟬fr_postal_address#61⟭","Carabine","⟬date#7⟭","Non","⟬email#61⟭","⟬age#61⟭"
"45475","⟬person_name#62⟭","⟬birth_date#62⟭","⟬fr_identity_card#62⟭","⟬fr_postal_address#62⟭","Carabine","⟬date#3⟭","Non","⟬email#62⟭","⟬age#62⟭"
"90148","⟬person_name#63⟭","⟬birth_date#63⟭","⟬fr_identity_card#63⟭","⟬fr_postal_address#63⟭","Pistolet","⟬date#3⟭","Oui","⟬email#63⟭","⟬age#63⟭"
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: public administration
appearance: TSV cell, one column for three document kinds, type column
scenario: register of lost and stolen identity documents exported by a prefecture's documents office
⟬text⟭
type_titre	numero	titulaire	motif	declare_le	lieu_declaration
PASSEPORT	⟬fr_passport#1⟭	⟬person_name#1⟭	Vol	⟬date#7⟭	Gendarmerie
PASSEPORT	⟬fr_passport#2⟭	⟬person_name#2⟭	Vol	⟬date#4⟭	Commissariat
PERMIS	⟬fr_driving_licence#3⟭	⟬person_name#3⟭	Destruction	⟬date#5⟭	Gendarmerie
PASSEPORT	⟬fr_passport#4⟭	⟬person_name#4⟭	Perte	⟬date#2⟭	Commissariat
CNI	⟬fr_identity_card#5⟭	⟬person_name#5⟭	Perte	⟬date#3⟭	Mairie
CNI	⟬fr_identity_card#6⟭	⟬person_name#6⟭	Destruction	⟬date#3⟭	Mairie
PASSEPORT	⟬fr_passport#7⟭	⟬person_name#7⟭	Vol	⟬date#1⟭	Mairie
CNI	⟬fr_identity_card#8⟭	⟬person_name#8⟭	Vol	⟬date#7⟭	Mairie
PASSEPORT	⟬fr_passport#9⟭	⟬person_name#9⟭	Perte	⟬date#7⟭	Gendarmerie
CNI	⟬fr_identity_card#10⟭	⟬person_name#10⟭	Vol	⟬date#6⟭	Gendarmerie
PERMIS	⟬fr_driving_licence#11⟭	⟬person_name#11⟭	Perte	⟬date#5⟭	Commissariat
PERMIS	⟬fr_driving_licence#12⟭	⟬person_name#12⟭	Perte	⟬date#4⟭	Mairie
PASSEPORT	⟬fr_passport#13⟭	⟬person_name#13⟭	Perte	⟬date#5⟭	Commissariat
CNI	⟬fr_identity_card#14⟭	⟬person_name#14⟭	Perte	⟬date#2⟭	Gendarmerie
PASSEPORT	⟬fr_passport#15⟭	⟬person_name#15⟭	Vol	⟬date#3⟭	Mairie
PASSEPORT	⟬fr_passport#16⟭	⟬person_name#16⟭	Destruction	⟬date#1⟭	Mairie
PERMIS	⟬fr_driving_licence#17⟭	⟬person_name#17⟭	Perte	⟬date#2⟭	Mairie
PASSEPORT	⟬fr_passport#18⟭	⟬person_name#18⟭	Perte	⟬date#5⟭	Commissariat
PERMIS	⟬fr_driving_licence#19⟭	⟬person_name#19⟭	Vol	⟬date#2⟭	Gendarmerie
PASSEPORT	⟬fr_passport#20⟭	⟬person_name#20⟭	Perte	⟬date#3⟭	Commissariat
PERMIS	⟬fr_driving_licence#21⟭	⟬person_name#21⟭	Perte	⟬date#4⟭	Gendarmerie
CNI	⟬fr_identity_card#22⟭	⟬person_name#22⟭	Vol	⟬date#1⟭	Mairie
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: HR
appearance: Oracle export, to_date calls, NIR, bank account, birth date beside entry date
scenario: Oracle export of a payroll table prepared by a DBA to feed a pre-production database
⟬text⟭
SET DEFINE OFF;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

CREATE TABLE PAIE.SALARIE (
  ID_SAL         NUMBER(8) NOT NULL,
  NOM            VARCHAR2(160),
  DATE_NAISSANCE DATE,
  NIR            VARCHAR2(21),
  COMPTE         VARCHAR2(11),
  BIC            VARCHAR2(11),
  DATE_ENTREE    DATE
);

Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (701,'⟬person_name#1⟭',to_date('⟬birth_date#1⟭','YYYY-MM-DD'),'⟬fr_social_security_number#1⟭','⟬bank_account_number#1⟭','⟬bic#1⟭',to_date('⟬date#8⟭','YYYY-MM-DD'));
Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (702,'⟬person_name#2⟭',to_date('⟬birth_date#2⟭','YYYY-MM-DD'),'⟬fr_social_security_number#2⟭','⟬bank_account_number#2⟭','⟬bic#2⟭',to_date('⟬date#1⟭','YYYY-MM-DD'));
Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (703,'⟬person_name#3⟭',to_date('⟬birth_date#3⟭','YYYY-MM-DD'),'⟬fr_social_security_number#3⟭','⟬bank_account_number#3⟭','⟬bic#3⟭',to_date('⟬date#4⟭','YYYY-MM-DD'));
Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (704,'⟬person_name#4⟭',to_date('⟬birth_date#4⟭','YYYY-MM-DD'),'⟬fr_social_security_number#4⟭','⟬bank_account_number#4⟭','⟬bic#4⟭',to_date('⟬date#7⟭','YYYY-MM-DD'));
Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (705,'⟬person_name#5⟭',to_date('⟬birth_date#5⟭','YYYY-MM-DD'),'⟬fr_social_security_number#5⟭','⟬bank_account_number#5⟭','⟬bic#5⟭',to_date('⟬date#4⟭','YYYY-MM-DD'));
Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (706,'⟬person_name#6⟭',to_date('⟬birth_date#6⟭','YYYY-MM-DD'),'⟬fr_social_security_number#6⟭','⟬bank_account_number#6⟭','⟬bic#6⟭',to_date('⟬date#2⟭','YYYY-MM-DD'));
Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (707,'⟬person_name#7⟭',to_date('⟬birth_date#7⟭','YYYY-MM-DD'),'⟬fr_social_security_number#7⟭','⟬bank_account_number#7⟭','⟬bic#7⟭',to_date('⟬date#2⟭','YYYY-MM-DD'));
Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (708,'⟬person_name#8⟭',to_date('⟬birth_date#8⟭','YYYY-MM-DD'),'⟬fr_social_security_number#8⟭','⟬bank_account_number#8⟭','⟬bic#8⟭',to_date('⟬date#6⟭','YYYY-MM-DD'));
Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (709,'⟬person_name#9⟭',to_date('⟬birth_date#9⟭','YYYY-MM-DD'),'⟬fr_social_security_number#9⟭','⟬bank_account_number#9⟭','⟬bic#9⟭',to_date('⟬date#8⟭','YYYY-MM-DD'));
Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (710,'⟬person_name#10⟭',to_date('⟬birth_date#10⟭','YYYY-MM-DD'),'⟬fr_social_security_number#10⟭','⟬bank_account_number#10⟭','⟬bic#10⟭',to_date('⟬date#6⟭','YYYY-MM-DD'));
Insert into PAIE.SALARIE (ID_SAL,NOM,DATE_NAISSANCE,NIR,COMPTE,BIC,DATE_ENTREE) values (711,'⟬person_name#11⟭',to_date('⟬birth_date#11⟭','YYYY-MM-DD'),'⟬fr_social_security_number#11⟭','⟬bank_account_number#11⟭','⟬bic#11⟭',to_date('⟬date#5⟭','YYYY-MM-DD'));

COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: education
appearance: Python tuples printed row by row, birth date, NIR, grades
scenario: rows of a vocational school's insurance workbook printed by a script while a developer debugged an import
⟬text⟭
>>> from openpyxl import load_workbook
>>> ws = load_workbook("stagiaires_assurance.xlsx").active
>>> for row in ws.iter_rows(values_only=True):
...     print(row)
...
('Élève', 'Date de naissance', 'N° sécurité sociale', 'Note 1', 'Note 2', 'Convention signée')
('⟬person_name#1⟭', '⟬birth_date#1⟭', '⟬fr_social_security_number#1⟭', 6.5, 14.0, False)
('⟬person_name#2⟭', '⟬birth_date#2⟭', '⟬fr_social_security_number#2⟭', 17.5, 18.5, True)
('⟬person_name#3⟭', '⟬birth_date#3⟭', '⟬fr_social_security_number#3⟭', 7.0, 15.5, False)
('⟬person_name#4⟭', '⟬birth_date#4⟭', '⟬fr_social_security_number#4⟭', 10.5, 6.0, True)
('⟬person_name#5⟭', '⟬birth_date#5⟭', '⟬fr_social_security_number#5⟭', 10.5, 15.5, False)
('⟬person_name#6⟭', '⟬birth_date#6⟭', '⟬fr_social_security_number#6⟭', 11.5, 6.5, False)
('⟬person_name#7⟭', '⟬birth_date#7⟭', '⟬fr_social_security_number#7⟭', 15.0, 7.0, True)
('⟬person_name#8⟭', '⟬birth_date#8⟭', '⟬fr_social_security_number#8⟭', 6.5, 16.5, True)
('⟬person_name#9⟭', '⟬birth_date#9⟭', '⟬fr_social_security_number#9⟭', 6.5, 15.0, False)
('⟬person_name#10⟭', '⟬birth_date#10⟭', '⟬fr_social_security_number#10⟭', 7.0, 17.0, False)
('⟬person_name#11⟭', '⟬birth_date#11⟭', '⟬fr_social_security_number#11⟭', 18.0, 14.5, False)
('⟬person_name#12⟭', '⟬birth_date#12⟭', '⟬fr_social_security_number#12⟭', 15.5, 18.5, True)
('⟬person_name#13⟭', '⟬birth_date#13⟭', '⟬fr_social_security_number#13⟭', 9.0, 14.5, False)
('⟬person_name#14⟭', '⟬birth_date#14⟭', '⟬fr_social_security_number#14⟭', 14.0, 15.5, False)
('⟬person_name#15⟭', '⟬birth_date#15⟭', '⟬fr_social_security_number#15⟭', 6.5, 12.5, True)
('⟬person_name#16⟭', '⟬birth_date#16⟭', '⟬fr_social_security_number#16⟭', 15.5, 12.5, True)
('⟬person_name#17⟭', '⟬birth_date#17⟭', '⟬fr_social_security_number#17⟭', 11.5, 9.5, False)
('⟬person_name#18⟭', '⟬birth_date#18⟭', '⟬fr_social_security_number#18⟭', 8.5, 19.0, False)
('⟬person_name#19⟭', '⟬birth_date#19⟭', '⟬fr_social_security_number#19⟭', 13.0, 18.0, False)
('⟬person_name#20⟭', '⟬birth_date#20⟭', '⟬fr_social_security_number#20⟭', 12.5, 17.0, False)
('⟬person_name#21⟭', '⟬birth_date#21⟭', '⟬fr_social_security_number#21⟭', 15.5, 15.5, False)
('⟬person_name#22⟭', '⟬birth_date#22⟭', '⟬fr_social_security_number#22⟭', 19.5, 19.0, False)
('⟬person_name#23⟭', '⟬birth_date#23⟭', '⟬fr_social_security_number#23⟭', 9.0, 9.0, True)
('⟬person_name#24⟭', '⟬birth_date#24⟭', '⟬fr_social_security_number#24⟭', 6.5, 18.0, False)
('⟬person_name#25⟭', '⟬birth_date#25⟭', '⟬fr_social_security_number#25⟭', 12.0, 18.0, False)
('⟬person_name#26⟭', '⟬birth_date#26⟭', '⟬fr_social_security_number#26⟭', 8.5, 18.0, False)
('⟬person_name#27⟭', '⟬birth_date#27⟭', '⟬fr_social_security_number#27⟭', 15.0, 17.0, False)
('⟬person_name#28⟭', '⟬birth_date#28⟭', '⟬fr_social_security_number#28⟭', 7.0, 19.0, True)
('⟬person_name#29⟭', '⟬birth_date#29⟭', '⟬fr_social_security_number#29⟭', 12.0, 15.0, False)
('⟬person_name#30⟭', '⟬birth_date#30⟭', '⟬fr_social_security_number#30⟭', 17.0, 13.0, True)
('⟬person_name#31⟭', '⟬birth_date#31⟭', '⟬fr_social_security_number#31⟭', 18.5, 12.0, False)
('⟬person_name#32⟭', '⟬birth_date#32⟭', '⟬fr_social_security_number#32⟭', 16.0, 14.5, False)
('⟬person_name#33⟭', '⟬birth_date#33⟭', '⟬fr_social_security_number#33⟭', 8.0, 12.0, True)
('⟬person_name#34⟭', '⟬birth_date#34⟭', '⟬fr_social_security_number#34⟭', 6.5, 7.0, False)
('⟬person_name#35⟭', '⟬birth_date#35⟭', '⟬fr_social_security_number#35⟭', 16.0, 10.5, True)
('⟬person_name#36⟭', '⟬birth_date#36⟭', '⟬fr_social_security_number#36⟭', 10.0, 6.0, True)
('⟬person_name#37⟭', '⟬birth_date#37⟭', '⟬fr_social_security_number#37⟭', 8.5, 8.0, True)
('⟬person_name#38⟭', '⟬birth_date#38⟭', '⟬fr_social_security_number#38⟭', 15.5, 6.5, True)
('⟬person_name#39⟭', '⟬birth_date#39⟭', '⟬fr_social_security_number#39⟭', 9.0, 13.5, True)
('⟬person_name#40⟭', '⟬birth_date#40⟭', '⟬fr_social_security_number#40⟭', 6.0, 6.5, True)
('⟬person_name#41⟭', '⟬birth_date#41⟭', '⟬fr_social_security_number#41⟭', 12.0, 15.5, True)
('⟬person_name#42⟭', '⟬birth_date#42⟭', '⟬fr_social_security_number#42⟭', 13.5, 13.5, True)
('⟬person_name#43⟭', '⟬birth_date#43⟭', '⟬fr_social_security_number#43⟭', 11.0, 17.0, True)
('⟬person_name#44⟭', '⟬birth_date#44⟭', '⟬fr_social_security_number#44⟭', 11.0, 14.0, True)
('⟬person_name#45⟭', '⟬birth_date#45⟭', '⟬fr_social_security_number#45⟭', 10.5, 9.5, True)
('⟬person_name#46⟭', '⟬birth_date#46⟭', '⟬fr_social_security_number#46⟭', 8.0, 8.5, False)
('⟬person_name#47⟭', '⟬birth_date#47⟭', '⟬fr_social_security_number#47⟭', 11.5, 15.5, True)
('⟬person_name#48⟭', '⟬birth_date#48⟭', '⟬fr_social_security_number#48⟭', 12.0, 10.0, False)
('⟬person_name#49⟭', '⟬birth_date#49⟭', '⟬fr_social_security_number#49⟭', 13.0, 8.0, False)
('⟬person_name#50⟭', '⟬birth_date#50⟭', '⟬fr_social_security_number#50⟭', 14.0, 8.0, True)
('⟬person_name#51⟭', '⟬birth_date#51⟭', '⟬fr_social_security_number#51⟭', 12.0, 6.0, True)
('⟬person_name#52⟭', '⟬birth_date#52⟭', '⟬fr_social_security_number#52⟭', 14.5, 8.0, True)
('⟬person_name#53⟭', '⟬birth_date#53⟭', '⟬fr_social_security_number#53⟭', 11.0, 11.5, True)
('⟬person_name#54⟭', '⟬birth_date#54⟭', '⟬fr_social_security_number#54⟭', 12.5, 19.5, True)
('⟬person_name#55⟭', '⟬birth_date#55⟭', '⟬fr_social_security_number#55⟭', 6.5, 18.0, True)
('⟬person_name#56⟭', '⟬birth_date#56⟭', '⟬fr_social_security_number#56⟭', 19.0, 18.0, False)
('⟬person_name#57⟭', '⟬birth_date#57⟭', '⟬fr_social_security_number#57⟭', 6.5, 15.5, True)
('⟬person_name#58⟭', '⟬birth_date#58⟭', '⟬fr_social_security_number#58⟭', 19.5, 11.0, True)
(None, None, None, None, None, None)
>>> ws.max_row
60
⟬end⟭
