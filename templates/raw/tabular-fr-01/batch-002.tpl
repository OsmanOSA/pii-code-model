⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Oracle export, tax number, address in a string, INSERT with column list
scenario: Oracle SQL Developer export of a few lines of a local tax table, attached to a support request
⟬text⟭
--------------------------------------------------------
--  Fichier créé par SQL Developer
--------------------------------------------------------
REM INSERTING into FISC.REDEVABLE
SET DEFINE OFF;
Insert into FISC.REDEVABLE (NUM_FISCAL,NOM_REDEVABLE,ADRESSE_BIEN,COMMUNE,MONTANT_DU) values ('⟬fr_tax_number#1⟭','⟬person_name#1⟭','⟬fr_postal_address:street#1⟭','⟬city#1⟭',648.20);
Insert into FISC.REDEVABLE (NUM_FISCAL,NOM_REDEVABLE,ADRESSE_BIEN,COMMUNE,MONTANT_DU) values ('⟬fr_tax_number#2⟭','⟬person_name#2⟭','⟬fr_postal_address:street#2⟭','⟬city#2⟭',1173.05);
Insert into FISC.REDEVABLE (NUM_FISCAL,NOM_REDEVABLE,ADRESSE_BIEN,COMMUNE,MONTANT_DU) values ('⟬fr_tax_number#3⟭','⟬company#3⟭','⟬fr_postal_address:street#3⟭','⟬city#3⟭',2896.90);
COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: HR
appearance: pasted cells, passport, driving licence, birth date next to a mission date
scenario: cells pasted by an HR assistant into a message to the travel desk for employees sent abroad on a site mission
⟬text⟭
Mission chantier Maroc - pièces reçues
Salarié	Date de naissance	Passeport	Permis	Départ	Observations
⟬person_name#1⟭	⟬birth_date#1⟭	⟬fr_passport#1⟭	⟬fr_driving_licence#1⟭	⟬date#1⟭	
⟬person_name#2⟭	⟬birth_date#2⟭	⟬fr_passport#2⟭	⟬fr_driving_licence#2⟭	⟬date#1⟭	Visa en cours
⟬person_name#3⟭	⟬birth_date#3⟭	⟬fr_passport#3⟭	⟬trap:indicator_non_pii|non fourni⟭	⟬date#2⟭	
⟬person_name#4⟭	⟬birth_date#4⟭	⟬fr_passport#4⟭	⟬fr_driving_licence#4⟭	⟬date#2⟭	Vaccin à vérifier
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: education
appearance: Markdown table, legal guardians, tax number, IBAN, short notes
scenario: note of a school's intendance on the families applying for a grant, written for the head of school
⟬text⟭
# Bourses de collège : point sur les dossiers

Dossiers reçus au secrétariat. Le numéro fiscal et le revenu viennent de l'avis d'imposition,
le RIB sert au versement direct aux familles.

| Responsable légal | Enfants à charge | N° fiscal | Revenu | IBAN | Taux | État |
| --- | ---: | --- | ---: | --- | --- | --- |
| ⟬person_name#1⟭ | 4 | ⟬fr_tax_number#1⟭ | 25 687 € | ⟬iban#1⟭ | Échelon 4 | Complet |
| ⟬person_name#2⟭ | 3 | ⟬fr_tax_number#2⟭ | 28 965 € | ⟬iban#2⟭ | Échelon 2 | Avis manquant |
| ⟬person_name#3⟭ | 4 | ⟬fr_tax_number#3⟭ | 14 131 € | ⟬iban#3⟭ | Échelon 5 | Complet |
| ⟬person_name#4⟭ | 2 | ⟬fr_tax_number#4⟭ | 15 526 € | ⟬iban#4⟭ | Échelon 1 | Complet |
| ⟬person_name#5⟭ | 1 | ⟬fr_tax_number#5⟭ | 21 886 € | ⟬iban#5⟭ | Échelon 1 | RIB illisible |
| ⟬person_name#6⟭ | 2 | ⟬fr_tax_number#6⟭ | 25 751 € | ⟬iban#6⟭ | Échelon 1 | Complet |
| ⟬person_name#7⟭ | 1 | ⟬fr_tax_number#7⟭ | 19 308 € | ⟬iban#7⟭ | Échelon 4 | Avis manquant |
| ⟬person_name#8⟭ | 4 | ⟬fr_tax_number#8⟭ | 30 556 € | ⟬iban#8⟭ | Échelon 5 | Complet |
| ⟬person_name#9⟭ | 1 | ⟬fr_tax_number#9⟭ | 28 780 € | ⟬iban#9⟭ | Échelon 2 | Avis manquant |
| ⟬person_name#10⟭ | 3 | ⟬fr_tax_number#10⟭ | 10 978 € | ⟬iban#10⟭ | Échelon 1 | Avis manquant |
| ⟬person_name#11⟭ | 3 | ⟬fr_tax_number#11⟭ | 25 800 € | ⟬iban#11⟭ | Échelon 4 | Complet |
| ⟬person_name#12⟭ | 2 | ⟬fr_tax_number#12⟭ | 31 587 € | ⟬iban#12⟭ | Échelon 4 | RIB illisible |
| ⟬person_name#13⟭ | 3 | ⟬fr_tax_number#13⟭ | 14 455 € | ⟬iban#13⟭ | Échelon 2 | Complet |

## À faire

- relancer les dossiers incomplets avant la commission
- transmettre la liste à ⟬person_name#20⟭ pour la mise en paiement
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: fixed columns, census of present patients, birth date, NIR, sex column
scenario: census of patients present at midnight, printed by a hospital admission system and saved as text by a night nurse manager
⟬text⟭
CENTRE HOSPITALIER ⟬company#30⟭
ETAT DES PRESENTS A MINUIT                  JOURNEE DU ⟬date#1⟭
UF 2410 MEDECINE POLYVALENTE                OPERATEUR ⟬trap:indicator_non_pii|BATCHNUIT⟭

IPP      LIT  S  NAISSANCE    NIR                    PATIENT
-------  ---  -  -----------  ---------------------  ---------------------------
3234578  295  F  ⟬birth_date#1f⟭  ⟬fr_social_security_number#1⟭  ⟬person_name#1⟭
8119369  319  F  ⟬birth_date#2f⟭  ⟬fr_social_security_number#2⟭  ⟬person_name#2⟭
1574346  241  M  ⟬birth_date#3m⟭  ⟬fr_social_security_number#3⟭  ⟬person_name#3⟭
1606651  430  M  ⟬birth_date#4m⟭  ⟬fr_social_security_number#4⟭  ⟬person_name#4⟭
8110162  145  M  ⟬birth_date#5m⟭  ⟬fr_social_security_number#5⟭  ⟬person_name#5⟭
3090988  330  F  ⟬birth_date#6f⟭  ⟬fr_social_security_number#6⟭  ⟬person_name#6⟭
5621668  335  M  ⟬birth_date#7m⟭  ⟬fr_social_security_number#7⟭  ⟬person_name#7⟭
1140018  116  F  ⟬birth_date#8f⟭  ⟬fr_social_security_number#8⟭  ⟬person_name#8⟭
7050454  362  M  ⟬birth_date#9m⟭  ⟬fr_social_security_number#9⟭  ⟬person_name#9⟭
7928863  129  F  ⟬birth_date#10f⟭  ⟬fr_social_security_number#10⟭  ⟬person_name#10⟭
7547092  243  F  ⟬birth_date#11f⟭  ⟬fr_social_security_number#11⟭  ⟬person_name#11⟭
1769889  345  F  ⟬birth_date#12f⟭  ⟬fr_social_security_number#12⟭  ⟬person_name#12⟭
5642766  348  M  ⟬birth_date#13m⟭  ⟬fr_social_security_number#13⟭  ⟬person_name#13⟭
3074450  442  M  ⟬birth_date#14m⟭  ⟬fr_social_security_number#14⟭  ⟬person_name#14⟭
8132957  334  F  ⟬birth_date#15f⟭  ⟬fr_social_security_number#15⟭  ⟬person_name#15⟭
8252367  184  M  ⟬birth_date#16m⟭  ⟬fr_social_security_number#16⟭  ⟬person_name#16⟭
9278259  144  F  ⟬birth_date#17f⟭  ⟬fr_social_security_number#17⟭  ⟬person_name#17⟭
-------  ---  -  -----------  ---------------------  ---------------------------
PRESENTS : 17     LITS OUVERTS : 22
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: associations
appearance: quoted CSV, name, email and IBAN headers holding no personal value
scenario: directory of partner associations from a federation, where the contact, email and IBAN columns hold only status notes
⟬text⟭
"nom","ville","cp","adherents","secteur","subvention","contact","email","iban"
"⟬company#1⟭","⟬city#1⟭","⟬postcode#1⟭",810,"Solidarité","16326,42","⟬trap:indicator_non_pii|Secrétariat⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|à demander⟭"
"⟬company#2⟭","⟬city#2⟭","⟬postcode#2⟭",304,"Solidarité","3951,51","⟬trap:indicator_non_pii|Bureau collégial⟭","⟬trap:indicator_non_pii|non communiqué⟭","⟬trap:indicator_non_pii|en attente⟭"
"⟬company#3⟭","⟬city#3⟭","⟬postcode#3⟭",1338,"Jeunesse","13870,77","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|à demander⟭"
"⟬company#4⟭","⟬city#4⟭","⟬postcode#4⟭",1847,"Jeunesse","9693,77","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|voir site⟭","⟬trap:indicator_non_pii|en attente⟭"
"⟬company#5⟭","⟬city#5⟭","⟬postcode#5⟭",568,"Sport","1942,38","⟬trap:indicator_non_pii|Bureau collégial⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|à demander⟭"
"⟬company#6⟭","⟬city#6⟭","⟬postcode#6⟭",571,"Jeunesse","16282,46","⟬trap:indicator_non_pii|Secrétariat⟭","⟬trap:indicator_non_pii|voir site⟭","⟬trap:indicator_non_pii|transmis au service⟭"
"⟬company#7⟭","⟬city#7⟭","⟬postcode#7⟭",458,"Culture","17489,39","⟬trap:indicator_non_pii|Bureau collégial⟭","⟬trap:indicator_non_pii|non communiqué⟭","⟬trap:indicator_non_pii|à demander⟭"
"⟬company#8⟭","⟬city#8⟭","⟬postcode#8⟭",1462,"Environnement","16407,33","⟬trap:indicator_non_pii|Bureau collégial⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|transmis au service⟭"
"⟬company#9⟭","⟬city#9⟭","⟬postcode#9⟭",825,"Culture","1045,35","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|non communiqué⟭","⟬trap:indicator_non_pii|transmis au service⟭"
"⟬company#10⟭","⟬city#10⟭","⟬postcode#10⟭",1479,"Jeunesse","11750,82","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|à demander⟭"
"⟬company#11⟭","⟬city#11⟭","⟬postcode#11⟭",798,"Environnement","9309,06","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|non communiqué⟭","⟬trap:indicator_non_pii|à demander⟭"
"⟬company#12⟭","⟬city#12⟭","⟬postcode#12⟭",893,"Solidarité","17065,50","⟬trap:indicator_non_pii|Bureau collégial⟭","⟬trap:indicator_non_pii|voir site⟭","⟬trap:indicator_non_pii|à demander⟭"
"⟬company#13⟭","⟬city#13⟭","⟬postcode#13⟭",1331,"Solidarité","15136,02","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|transmis au service⟭"
"⟬company#14⟭","⟬city#14⟭","⟬postcode#14⟭",998,"Jeunesse","2418,97","⟬trap:indicator_non_pii|Secrétariat⟭","⟬trap:indicator_non_pii|non communiqué⟭","⟬trap:indicator_non_pii|à demander⟭"
"⟬company#15⟭","⟬city#15⟭","⟬postcode#15⟭",47,"Environnement","11829,93","⟬trap:indicator_non_pii|Secrétariat⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|en attente⟭"
"⟬company#16⟭","⟬city#16⟭","⟬postcode#16⟭",1512,"Environnement","15260,41","⟬trap:indicator_non_pii|Secrétariat⟭","⟬trap:indicator_non_pii|non communiqué⟭","⟬trap:indicator_non_pii|en attente⟭"
"⟬company#17⟭","⟬city#17⟭","⟬postcode#17⟭",868,"Sport","16913,62","⟬trap:indicator_non_pii|Bureau collégial⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|transmis au service⟭"
"⟬company#18⟭","⟬city#18⟭","⟬postcode#18⟭",728,"Sport","2633,67","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|en attente⟭"
"⟬company#19⟭","⟬city#19⟭","⟬postcode#19⟭",948,"Sport","15976,36","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|à demander⟭"
"⟬company#20⟭","⟬city#20⟭","⟬postcode#20⟭",1007,"Sport","11413,95","⟬trap:indicator_non_pii|Secrétariat⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|en attente⟭"
"⟬company#21⟭","⟬city#21⟭","⟬postcode#21⟭",1425,"Environnement","8077,33","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|non communiqué⟭","⟬trap:indicator_non_pii|en attente⟭"
"⟬company#22⟭","⟬city#22⟭","⟬postcode#22⟭",761,"Sport","8452,05","⟬trap:indicator_non_pii|Secrétariat⟭","⟬trap:indicator_non_pii|non communiqué⟭","⟬trap:indicator_non_pii|transmis au service⟭"
"⟬company#23⟭","⟬city#23⟭","⟬postcode#23⟭",1254,"Culture","8327,72","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|non communiqué⟭","⟬trap:indicator_non_pii|à demander⟭"
"⟬company#24⟭","⟬city#24⟭","⟬postcode#24⟭",1535,"Jeunesse","7111,30","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|transmis au service⟭"
"⟬company#25⟭","⟬city#25⟭","⟬postcode#25⟭",458,"Jeunesse","11108,45","⟬trap:indicator_non_pii|Service vie associative⟭","⟬trap:indicator_non_pii|formulaire en ligne⟭","⟬trap:indicator_non_pii|transmis au service⟭"
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: public administration
appearance: TSV cell, empty driver columns, plates, driving licence, street without number
scenario: offence log of a municipal police force, exported every quarter for the prosecutor's office
⟬text⟭
n_pv	date_constat	heure	lieu	immat	marque	conducteur	permis	adresse_conducteur	infraction	montant
PV638341	⟬date#8⟭	13:18	parking de la gare	⟬fr_license_plate#1⟭	Toyota	⟬person_name#1⟭	⟬fr_driving_licence#1⟭	⟬fr_postal_address#1⟭	Sens interdit	135
PV430289	⟬date#9⟭	15:34	⟬trap:word_name|avenue Jean-Jaurès⟭	⟬fr_license_plate#2⟭	Toyota	⟬person_name#2⟭	⟬fr_driving_licence#2⟭	⟬fr_postal_address#2⟭	Téléphone tenu en main	135
PV876394	⟬date#5⟭	07:55	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#3⟭	Dacia	⟬person_name#3⟭	⟬fr_driving_licence#3⟭	⟬fr_postal_address#3⟭	Vitesse < 20 km/h	68
PV473232	⟬date#8⟭	11:12	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#4⟭	Fiat				Stationnement gênant	35
PV854574	⟬date#3⟭	07:43	zone bleue centre	⟬fr_license_plate#5⟭	Dacia	⟬person_name#5⟭	⟬fr_driving_licence#5⟭	⟬fr_postal_address#5⟭	Vitesse < 20 km/h	68
PV838337	⟬date#5⟭	20:45	⟬trap:word_name|avenue Jean-Jaurès⟭	⟬fr_license_plate#6⟭	⟬trap:company_name|Renault⟭	⟬person_name#6⟭	⟬fr_driving_licence#6⟭	⟬fr_postal_address#6⟭	Vitesse < 20 km/h	68
PV670824	⟬date#1⟭	08:31	marché couvert	⟬fr_license_plate#7⟭	Dacia				Téléphone tenu en main	135
PV384248	⟬date#1⟭	13:44	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#8⟭	Dacia	⟬person_name#8⟭	⟬fr_driving_licence#8⟭	⟬fr_postal_address#8⟭	Téléphone tenu en main	135
PV574466	⟬date#2⟭	13:48	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#9⟭	Toyota				Sens interdit	135
PV813818	⟬date#6⟭	18:52	marché couvert	⟬fr_license_plate#10⟭	Dacia				Défaut de disque	17
PV291894	⟬date#9⟭	11:45	zone bleue centre	⟬fr_license_plate#11⟭	Toyota	⟬person_name#11⟭	⟬fr_driving_licence#11⟭	⟬fr_postal_address#11⟭	Vitesse < 20 km/h	68
PV153738	⟬date#10⟭	07:08	parking de la gare	⟬fr_license_plate#12⟭	⟬trap:company_name|Peugeot⟭	⟬person_name#12⟭	⟬fr_driving_licence#12⟭	⟬fr_postal_address#12⟭	Téléphone tenu en main	135
PV569686	⟬date#10⟭	19:56	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#13⟭	⟬trap:company_name|Renault⟭				Défaut de disque	17
PV403273	⟬date#2⟭	11:10	marché couvert	⟬fr_license_plate#14⟭	⟬trap:company_name|Citroën⟭				Vitesse < 20 km/h	68
PV441735	⟬date#1⟭	12:48	⟬trap:word_name|place Gambetta⟭	⟬fr_license_plate#15⟭	Fiat				Défaut de disque	17
PV433550	⟬date#1⟭	12:05	parking de la gare	⟬fr_license_plate#16⟭	⟬trap:company_name|Peugeot⟭				Stationnement gênant	35
PV519215	⟬date#7⟭	09:57	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#17⟭	Toyota	⟬person_name#17⟭	⟬fr_driving_licence#17⟭	⟬fr_postal_address#17⟭	Sens interdit	135
PV962219	⟬date#5⟭	14:50	⟬trap:word_name|place Gambetta⟭	⟬fr_license_plate#18⟭	Toyota	⟬person_name#18⟭	⟬fr_driving_licence#18⟭	⟬fr_postal_address#18⟭	Téléphone tenu en main	135
PV756503	⟬date#6⟭	14:16	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#19⟭	⟬trap:company_name|Peugeot⟭	⟬person_name#19⟭	⟬fr_driving_licence#19⟭	⟬fr_postal_address#19⟭	Stationnement très gênant	135
PV204917	⟬date#4⟭	12:30	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#20⟭	Toyota				Défaut de disque	17
PV350174	⟬date#1⟭	12:39	parking de la gare	⟬fr_license_plate#21⟭	Fiat				Défaut de disque	17
PV617410	⟬date#10⟭	21:25	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#22⟭	Fiat				Stationnement très gênant	135
PV862627	⟬date#3⟭	09:38	⟬trap:word_name|place Gambetta⟭	⟬fr_license_plate#23⟭	Dacia				Défaut de disque	17
PV575963	⟬date#2⟭	14:43	⟬trap:word_name|avenue Jean-Jaurès⟭	⟬fr_license_plate#24⟭	⟬trap:company_name|Peugeot⟭	⟬person_name#24⟭	⟬fr_driving_licence#24⟭	⟬fr_postal_address#24⟭	Vitesse < 20 km/h	68
PV433538	⟬date#6⟭	09:09	⟬trap:word_name|place Gambetta⟭	⟬fr_license_plate#25⟭	⟬trap:company_name|Peugeot⟭	⟬person_name#25⟭	⟬fr_driving_licence#25⟭	⟬fr_postal_address#25⟭	Stationnement très gênant	135
PV464840	⟬date#4⟭	15:56	zone bleue centre	⟬fr_license_plate#26⟭	⟬trap:company_name|Peugeot⟭				Téléphone tenu en main	135
PV388471	⟬date#8⟭	22:30	parking de la gare	⟬fr_license_plate#27⟭	Fiat				Défaut de disque	17
PV487873	⟬date#3⟭	20:31	parking de la gare	⟬fr_license_plate#28⟭	Toyota				Stationnement gênant	35
PV146174	⟬date#4⟭	10:53	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#29⟭	⟬trap:company_name|Citroën⟭				Téléphone tenu en main	135
PV769723	⟬date#3⟭	07:01	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#30⟭	⟬trap:company_name|Citroën⟭	⟬person_name#30⟭	⟬fr_driving_licence#30⟭	⟬fr_postal_address#30⟭	Stationnement très gênant	135
PV327805	⟬date#5⟭	12:41	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#31⟭	Fiat				Stationnement très gênant	135
PV329895	⟬date#6⟭	09:38	parking de la gare	⟬fr_license_plate#32⟭	Dacia	⟬person_name#32⟭	⟬fr_driving_licence#32⟭	⟬fr_postal_address#32⟭	Stationnement très gênant	135
PV918186	⟬date#8⟭	07:27	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#33⟭	Toyota	⟬person_name#33⟭	⟬fr_driving_licence#33⟭	⟬fr_postal_address#33⟭	Sens interdit	135
PV632342	⟬date#5⟭	07:57	⟬trap:word_name|avenue Jean-Jaurès⟭	⟬fr_license_plate#34⟭	Dacia				Défaut de disque	17
PV432635	⟬date#4⟭	07:33	zone bleue centre	⟬fr_license_plate#35⟭	Dacia	⟬person_name#35⟭	⟬fr_driving_licence#35⟭	⟬fr_postal_address#35⟭	Vitesse < 20 km/h	68
PV329762	⟬date#3⟭	17:32	⟬trap:word_name|avenue Jean-Jaurès⟭	⟬fr_license_plate#36⟭	Toyota	⟬person_name#36⟭	⟬fr_driving_licence#36⟭	⟬fr_postal_address#36⟭	Vitesse < 20 km/h	68
PV386675	⟬date#1⟭	13:39	⟬trap:word_name|avenue Jean-Jaurès⟭	⟬fr_license_plate#37⟭	Fiat				Stationnement gênant	35
PV267311	⟬date#3⟭	11:18	parking de la gare	⟬fr_license_plate#38⟭	Toyota	⟬person_name#38⟭	⟬fr_driving_licence#38⟭	⟬fr_postal_address#38⟭	Vitesse < 20 km/h	68
PV845304	⟬date#10⟭	11:02	⟬trap:word_name|avenue Jean-Jaurès⟭	⟬fr_license_plate#39⟭	Fiat				Stationnement gênant	35
PV357536	⟬date#10⟭	22:15	parking de la gare	⟬fr_license_plate#40⟭	⟬trap:company_name|Citroën⟭	⟬person_name#40⟭	⟬fr_driving_licence#40⟭	⟬fr_postal_address#40⟭	Sens interdit	135
PV299587	⟬date#6⟭	09:35	zone bleue centre	⟬fr_license_plate#41⟭	⟬trap:company_name|Citroën⟭	⟬person_name#41⟭	⟬fr_driving_licence#41⟭	⟬fr_postal_address#41⟭	Sens interdit	135
PV392321	⟬date#5⟭	17:01	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#42⟭	Dacia				Stationnement très gênant	135
PV528124	⟬date#10⟭	14:56	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#43⟭	⟬trap:company_name|Renault⟭				Défaut de disque	17
PV890768	⟬date#9⟭	16:35	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#44⟭	Fiat	⟬person_name#44⟭	⟬fr_driving_licence#44⟭	⟬fr_postal_address#44⟭	Sens interdit	135
PV529251	⟬date#2⟭	12:04	marché couvert	⟬fr_license_plate#45⟭	⟬trap:company_name|Peugeot⟭				Vitesse < 20 km/h	68
PV153980	⟬date#1⟭	19:33	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#46⟭	Fiat				Défaut de disque	17
PV751728	⟬date#9⟭	14:05	⟬trap:word_name|boulevard Pasteur⟭	⟬fr_license_plate#47⟭	Dacia	⟬person_name#47⟭	⟬fr_driving_licence#47⟭	⟬fr_postal_address#47⟭	Sens interdit	135
PV191478	⟬date#2⟭	14:49	zone bleue centre	⟬fr_license_plate#48⟭	Fiat	⟬person_name#48⟭	⟬fr_driving_licence#48⟭	⟬fr_postal_address#48⟭	Sens interdit	135
PV599192	⟬date#4⟭	08:09	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#49⟭	Dacia				Stationnement gênant	35
PV407329	⟬date#7⟭	19:15	zone bleue centre	⟬fr_license_plate#50⟭	⟬trap:company_name|Renault⟭	⟬person_name#50⟭	⟬fr_driving_licence#50⟭	⟬fr_postal_address#50⟭	Sens interdit	135
PV233350	⟬date#4⟭	09:45	parking de la gare	⟬fr_license_plate#51⟭	Dacia	⟬person_name#51⟭	⟬fr_driving_licence#51⟭	⟬fr_postal_address#51⟭	Téléphone tenu en main	135
PV959101	⟬date#10⟭	18:34	zone bleue centre	⟬fr_license_plate#52⟭	⟬trap:company_name|Renault⟭				Défaut de disque	17
PV246431	⟬date#7⟭	22:59	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#53⟭	⟬trap:company_name|Citroën⟭	⟬person_name#53⟭	⟬fr_driving_licence#53⟭	⟬fr_postal_address#53⟭	Stationnement très gênant	135
PV413865	⟬date#9⟭	14:08	⟬trap:word_name|place Gambetta⟭	⟬fr_license_plate#54⟭	Toyota				Défaut de disque	17
PV839456	⟬date#7⟭	19:27	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#55⟭	Dacia				Vitesse < 20 km/h	68
PV161453	⟬date#9⟭	11:59	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#56⟭	Toyota	⟬person_name#56⟭	⟬fr_driving_licence#56⟭	⟬fr_postal_address#56⟭	Stationnement très gênant	135
PV119705	⟬date#1⟭	09:23	marché couvert	⟬fr_license_plate#57⟭	⟬trap:company_name|Citroën⟭				Sens interdit	135
PV671195	⟬date#7⟭	19:47	⟬trap:word_name|avenue Jean-Jaurès⟭	⟬fr_license_plate#58⟭	⟬trap:company_name|Renault⟭	⟬person_name#58⟭	⟬fr_driving_licence#58⟭	⟬fr_postal_address#58⟭	Sens interdit	135
PV789640	⟬date#10⟭	21:47	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#59⟭	Toyota	⟬person_name#59⟭	⟬fr_driving_licence#59⟭	⟬fr_postal_address#59⟭	Stationnement très gênant	135
PV446846	⟬date#8⟭	17:11	⟬trap:word_name|avenue Jean-Jaurès⟭	⟬fr_license_plate#60⟭	Toyota	⟬person_name#60⟭	⟬fr_driving_licence#60⟭	⟬fr_postal_address#60⟭	Stationnement très gênant	135
PV788942	⟬date#6⟭	17:40	⟬trap:word_name|rue Victor-Hugo⟭	⟬fr_license_plate#61⟭	⟬trap:company_name|Citroën⟭	⟬person_name#61⟭	⟬fr_driving_licence#61⟭	⟬fr_postal_address#61⟭	Sens interdit	135
PV862857	⟬date#3⟭	21:45	marché couvert	⟬fr_license_plate#62⟭	⟬trap:company_name|Renault⟭				Stationnement très gênant	135
PV620242	⟬date#5⟭	21:53	parking de la gare	⟬fr_license_plate#63⟭	Dacia	⟬person_name#63⟭	⟬fr_driving_licence#63⟭	⟬fr_postal_address#63⟭	Sens interdit	135
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: HR
appearance: SQL Server script, N-prefixed strings, split bank details, initials as validator, trigger named after a person, settings table with secrets
scenario: SQL Server script generated from an HR database, committed by mistake into the repository of an internal tool
⟬text⟭
USE [SIRH]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[Id] [int] NOT NULL,
	[Libelle] [nvarchar](60) NOT NULL,
	[Responsable] [nvarchar](120) NULL,
PRIMARY KEY CLUSTERED ([Id] ASC)
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[Employe](
	[Id] [int] NOT NULL,
	[Civilite] [nvarchar](5) NULL,
	[NomComplet] [nvarchar](160) NOT NULL,
	[DateNaissance] [date] NULL,
	[Nir] [nvarchar](21) NULL,
	[Adresse] [nvarchar](255) NULL,
	[Cni] [nvarchar](12) NULL,
	[Compte] [nvarchar](11) NULL,
	[Bic] [nvarchar](11) NULL,
	[ServiceId] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[Absence](
	[Id] [int] NOT NULL,
	[EmployeId] [int] NOT NULL,
	[Debut] [date] NOT NULL,
	[Motif] [nvarchar](40) NULL,
	[Jours] [smallint] NULL,
	[ValidePar] [nvarchar](30) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Service] ([Id], [Libelle], [Responsable]) VALUES (1, N'Paie', N'⟬person_name#20⟭')
GO
INSERT [dbo].[Service] ([Id], [Libelle], [Responsable]) VALUES (2, N'Atelier', N'⟬person_name#21⟭')
GO
INSERT [dbo].[Service] ([Id], [Libelle], [Responsable]) VALUES (3, N'Magasin', N'⟬trap:indicator_non_pii|Direction de site⟭')
GO
INSERT [dbo].[Service] ([Id], [Libelle], [Responsable]) VALUES (4, N'Expéditions', N'⟬person_name#22⟭')
GO
INSERT [dbo].[Service] ([Id], [Libelle], [Responsable]) VALUES (5, N'Qualité', NULL)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (1, N'Mme', N'⟬person_name#1f⟭', N'⟬birth_date#1⟭', N'⟬fr_social_security_number#1⟭', N'⟬fr_postal_address#1⟭', N'⟬fr_identity_card#1⟭', N'⟬bank_account_number#1⟭', N'⟬bic#1⟭', 2)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (2, N'Mme', N'⟬person_name#2f⟭', N'⟬birth_date#2⟭', N'⟬fr_social_security_number#2⟭', N'⟬fr_postal_address#2⟭', N'⟬fr_identity_card#2⟭', N'⟬bank_account_number#2⟭', N'⟬bic#2⟭', 3)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (3, N'M.', N'⟬person_name#3m⟭', N'⟬birth_date#3⟭', N'⟬fr_social_security_number#3⟭', N'⟬fr_postal_address#3⟭', N'⟬fr_identity_card#3⟭', N'⟬bank_account_number#3⟭', N'⟬bic#3⟭', 3)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (4, N'M.', N'⟬person_name#4m⟭', N'⟬birth_date#4⟭', N'⟬fr_social_security_number#4⟭', N'⟬fr_postal_address#4⟭', N'⟬fr_identity_card#4⟭', N'⟬bank_account_number#4⟭', N'⟬bic#4⟭', 3)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (5, N'M.', N'⟬person_name#5m⟭', N'⟬birth_date#5⟭', N'⟬fr_social_security_number#5⟭', N'⟬fr_postal_address#5⟭', N'⟬fr_identity_card#5⟭', N'⟬bank_account_number#5⟭', N'⟬bic#5⟭', 5)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (6, N'M.', N'⟬person_name#6m⟭', N'⟬birth_date#6⟭', N'⟬fr_social_security_number#6⟭', N'⟬fr_postal_address#6⟭', N'⟬fr_identity_card#6⟭', N'⟬bank_account_number#6⟭', N'⟬bic#6⟭', 3)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (7, N'M.', N'⟬person_name#7m⟭', N'⟬birth_date#7⟭', N'⟬fr_social_security_number#7⟭', N'⟬fr_postal_address#7⟭', N'⟬fr_identity_card#7⟭', N'⟬bank_account_number#7⟭', N'⟬bic#7⟭', 2)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (8, N'M.', N'⟬person_name#8m⟭', N'⟬birth_date#8⟭', N'⟬fr_social_security_number#8⟭', N'⟬fr_postal_address#8⟭', N'⟬fr_identity_card#8⟭', N'⟬bank_account_number#8⟭', N'⟬bic#8⟭', 2)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (9, N'Mme', N'⟬person_name#9f⟭', N'⟬birth_date#9⟭', N'⟬fr_social_security_number#9⟭', N'⟬fr_postal_address#9⟭', N'⟬fr_identity_card#9⟭', N'⟬bank_account_number#9⟭', N'⟬bic#9⟭', 2)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (10, N'M.', N'⟬person_name#10m⟭', N'⟬birth_date#10⟭', N'⟬fr_social_security_number#10⟭', N'⟬fr_postal_address#10⟭', N'⟬fr_identity_card#10⟭', N'⟬bank_account_number#10⟭', N'⟬bic#10⟭', 5)
GO
INSERT [dbo].[Employe] ([Id], [Civilite], [NomComplet], [DateNaissance], [Nir], [Adresse], [Cni], [Compte], [Bic], [ServiceId]) VALUES (11, N'M.', N'⟬person_name#11m⟭', N'⟬birth_date#11⟭', N'⟬fr_social_security_number#11⟭', N'⟬fr_postal_address#11⟭', N'⟬fr_identity_card#11⟭', N'⟬bank_account_number#11⟭', N'⟬bic#11⟭', 2)
GO
INSERT [dbo].[Absence] ([Id], [EmployeId], [Debut], [Motif], [Jours], [ValidePar]) VALUES (1, 9, N'⟬date#6⟭', N'RTT', 12, N'⟬trap:indicator_non_pii|workflow_auto⟭')
GO
INSERT [dbo].[Absence] ([Id], [EmployeId], [Debut], [Motif], [Jours], [ValidePar]) VALUES (2, 1, N'⟬date#2⟭', N'Formation', 6, N'⟬trap:initials|JD⟭')
GO
INSERT [dbo].[Absence] ([Id], [EmployeId], [Debut], [Motif], [Jours], [ValidePar]) VALUES (3, 7, N'⟬date#6⟭', N'Congés payés', 5, N'⟬trap:initials|JD⟭')
GO
INSERT [dbo].[Absence] ([Id], [EmployeId], [Debut], [Motif], [Jours], [ValidePar]) VALUES (4, 2, N'⟬date#8⟭', N'Congés payés', 6, N'⟬trap:initials|JD⟭')
GO
INSERT [dbo].[Absence] ([Id], [EmployeId], [Debut], [Motif], [Jours], [ValidePar]) VALUES (5, 9, N'⟬date#5⟭', N'Événement familial', 7, N'⟬trap:initials|MLB⟭')
GO
INSERT [dbo].[Absence] ([Id], [EmployeId], [Debut], [Motif], [Jours], [ValidePar]) VALUES (6, 6, N'⟬date#4⟭', N'Événement familial', 7, N'⟬trap:initials|JD⟭')
GO
INSERT [dbo].[Absence] ([Id], [EmployeId], [Debut], [Motif], [Jours], [ValidePar]) VALUES (7, 2, N'⟬date#1⟭', N'RTT', 2, N'⟬trap:initials|MLB⟭')
GO
INSERT [dbo].[Absence] ([Id], [EmployeId], [Debut], [Motif], [Jours], [ValidePar]) VALUES (8, 4, N'⟬date#8⟭', N'Événement familial', 3, N'⟬trap:initials|MLB⟭')
GO
INSERT [dbo].[Absence] ([Id], [EmployeId], [Debut], [Motif], [Jours], [ValidePar]) VALUES (9, 8, N'⟬date#4⟭', N'Arrêt maladie', 12, N'⟬trap:indicator_non_pii|workflow_auto⟭')
GO
CREATE TABLE [dbo].[Parametre]([Cle] [nvarchar](40) NOT NULL, [Valeur] [nvarchar](400) NULL) ON [PRIMARY]
GO
INSERT [dbo].[Parametre] ([Cle], [Valeur]) VALUES (N'ConnexionPaie', N'Server=⟬hostname#1⟭;Database=PAIE;User Id=sirh_app;Password=⟬password#60⟭;')
GO
INSERT [dbo].[Parametre] ([Cle], [Valeur]) VALUES (N'CleApiBanque', N'⟬opaque_token#61⟭')
GO
INSERT [dbo].[Parametre] ([Cle], [Valeur]) VALUES (N'TokenTtlSecondes', N'⟬trap:indicator_non_pii|3600⟭')
GO
CREATE TRIGGER [dbo].[⟬trap:code_identifier|trg_⦃family⦄_absence⟭] ON [dbo].[Absence] AFTER INSERT AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[Absence] SET [ValidePar] = N'⟬trap:indicator_non_pii|workflow_auto⟭' WHERE [Jours] = 1;
END
GO
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: education
appearance: pasted cells, subtotals by level, eponym rooms, main teacher column without a person
scenario: class headcounts prepared in a spreadsheet by a school's vice-principal, before teachers are assigned
⟬text⟭
Préparation de rentrée - effectifs par division
Prévision N+1, document de travail

Division	Filles	Garçons	Total	Option	Salle	Prof. principal
6e1	10	14	24	Allemand	⟬trap:eponym|Salle Hugo⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
6e2	14	16	30	Latin	⟬trap:eponym|Salle Voltaire⟭	⟬trap:indicator_non_pii|À désigner⟭
6e3	10	15	25	Section sportive	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|À désigner⟭
6e4	14	11	25	Allemand	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
6e5	13	10	23	Chorale	⟬trap:eponym|Salle Molière⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
6e6	12	12	24	Allemand	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
6e7	10	15	25	Allemand	⟬trap:eponym|Salle Pasteur⟭	⟬trap:indicator_non_pii|Non attribué⟭
6e8	9	9	18	Latin	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|À désigner⟭
6e9	16	11	27	Espagnol	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|À désigner⟭
6e10	12	15	27	Chorale	⟬trap:eponym|Salle Pasteur⟭	⟬trap:indicator_non_pii|Non attribué⟭
6e11	14	16	30	Espagnol	⟬trap:eponym|Salle Molière⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
6e12	9	10	19	Espagnol	⟬trap:eponym|Salle Molière⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
6e13	16	11	27	Section sportive	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|Non attribué⟭
						
5e1	11	15	26	Section sportive	⟬trap:eponym|Salle Voltaire⟭	⟬trap:indicator_non_pii|À désigner⟭
5e2	13	14	27	Allemand	⟬trap:eponym|Salle Pasteur⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
5e3	10	14	24	Italien	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
5e4	11	13	24	Espagnol	⟬trap:eponym|Salle Pasteur⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
5e5	15	15	30	Italien	⟬trap:eponym|Salle Lavoisier⟭	⟬trap:indicator_non_pii|À désigner⟭
5e6	10	15	25	Italien	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|Non attribué⟭
5e7	11	16	27	Espagnol	⟬trap:eponym|Salle Pasteur⟭	⟬trap:indicator_non_pii|Non attribué⟭
5e8	9	9	18	Allemand	⟬trap:eponym|Salle Voltaire⟭	⟬trap:indicator_non_pii|À désigner⟭
5e9	11	15	26	Allemand	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|À désigner⟭
5e10	10	16	26	Latin	⟬trap:eponym|Salle Molière⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
5e11	11	14	25	Chorale	⟬trap:eponym|Salle Lavoisier⟭	⟬trap:indicator_non_pii|Non attribué⟭
5e12	16	14	30	Latin	⟬trap:eponym|Salle Hugo⟭	⟬trap:indicator_non_pii|À désigner⟭
5e13	12	16	28	Chorale	⟬trap:eponym|Salle Pasteur⟭	⟬trap:indicator_non_pii|Non attribué⟭
						
4e1	16	10	26	Chorale	⟬trap:eponym|Salle Molière⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
4e2	15	11	26	Espagnol	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
4e3	15	15	30	Latin	⟬trap:eponym|Salle Hugo⟭	⟬trap:indicator_non_pii|À désigner⟭
4e4	9	14	23	Espagnol	⟬trap:eponym|Salle Voltaire⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
4e5	9	16	25	Italien	⟬trap:eponym|Salle Molière⟭	⟬trap:indicator_non_pii|Non attribué⟭
4e6	16	9	25	Allemand	⟬trap:eponym|Salle Lavoisier⟭	⟬trap:indicator_non_pii|Non attribué⟭
4e7	10	15	25	Espagnol	⟬trap:eponym|Salle Voltaire⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
4e8	12	15	27	Section sportive	⟬trap:eponym|Salle Lavoisier⟭	⟬trap:indicator_non_pii|À désigner⟭
4e9	10	15	25	Italien	⟬trap:eponym|Salle Molière⟭	⟬trap:indicator_non_pii|Non attribué⟭
4e10	14	13	27	Espagnol	⟬trap:eponym|Salle Voltaire⟭	⟬trap:indicator_non_pii|À désigner⟭
4e11	16	14	30	Chorale	⟬trap:eponym|Salle Molière⟭	⟬trap:indicator_non_pii|À désigner⟭
4e12	9	10	19	Allemand	⟬trap:eponym|Salle Pasteur⟭	⟬trap:indicator_non_pii|Non attribué⟭
4e13	14	10	24	Section sportive	⟬trap:eponym|Salle Lavoisier⟭	⟬trap:indicator_non_pii|Non attribué⟭
						
3e1	15	13	28	Latin	⟬trap:eponym|Salle Lavoisier⟭	⟬trap:indicator_non_pii|Non attribué⟭
3e2	15	12	27	Section sportive	⟬trap:eponym|Salle Pasteur⟭	⟬trap:indicator_non_pii|Voir emploi du temps⟭
3e3	13	14	27	Allemand	⟬trap:eponym|Salle Voltaire⟭	⟬trap:indicator_non_pii|Non attribué⟭
3e4	14	14	28	Allemand	⟬trap:eponym|Salle Lavoisier⟭	⟬trap:indicator_non_pii|Non attribué⟭
3e5	13	11	24	Latin	⟬trap:eponym|Salle Pasteur⟭	⟬trap:indicator_non_pii|Non attribué⟭
3e6	16	14	30	Italien	⟬trap:eponym|Salle Hugo⟭	⟬trap:indicator_non_pii|Non attribué⟭
3e7	13	11	24	Section sportive	⟬trap:eponym|Salle Pasteur⟭	⟬trap:indicator_non_pii|À désigner⟭
3e8	12	11	23	Latin	⟬trap:eponym|Salle Hugo⟭	⟬trap:indicator_non_pii|Non attribué⟭
3e9	11	13	24	Latin	⟬trap:eponym|Salle Curie⟭	⟬trap:indicator_non_pii|À désigner⟭
3e10	14	9	23	Allemand	⟬trap:eponym|Salle Lavoisier⟭	⟬trap:indicator_non_pii|À désigner⟭
3e11	16	15	31	Allemand	⟬trap:eponym|Salle Voltaire⟭	⟬trap:indicator_non_pii|Non attribué⟭
3e12	10	9	19	Allemand	⟬trap:eponym|Salle Lavoisier⟭	⟬trap:indicator_non_pii|À désigner⟭
3e13	14	14	28	Allemand	⟬trap:eponym|Salle Molière⟭	⟬trap:indicator_non_pii|Non attribué⟭

Total établissement			à recalculer			
Sources : ⟬trap:eponym|Collège Simone-Veil⟭, base élèves, sans donnée nominative
Validation par la direction :	⟬trap:indicator_non_pii|en attente⟭
Prochaine version après le conseil d'administration
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: Markdown table, title before a name, birth date, NIR, initials as signature
scenario: minutes of a multidisciplinary cancer meeting, typed into a shared Markdown note by the coordinating secretary
⟬text⟭
# RCP oncologie du ⟬date#1⟭

Coordination : ⟬person_name#20⟭ (⟬phone#20⟭). Salle ⟬trap:eponym|Claude-Bernard⟭, visioconférence avec le site de ⟬city#21⟭.

| Dossier | Patient | Date de naissance | NIR | Organe | Décision | Visa |
| --- | --- | --- | --- | --- | --- | --- |
| 66615 | Mme ⟬person_name#1f⟭ | ⟬birth_date#1⟭ | ⟬fr_social_security_number#1⟭ | ORL | Chirurgie | ⟬trap:initials|C.-M.⟭ |
| 30836 | M. ⟬person_name#2m⟭ | ⟬birth_date#2⟭ | ⟬fr_social_security_number#2⟭ | Côlon | Surveillance | ⟬trap:initials|PLG⟭ |
| 62096 | M. ⟬person_name#3m⟭ | ⟬birth_date#3⟭ | ⟬fr_social_security_number#3⟭ | Sein | Avis complémentaire | ⟬trap:initials|AB⟭ |
| 57391 | M. ⟬person_name#4m⟭ | ⟬birth_date#4⟭ | ⟬fr_social_security_number#4⟭ | Côlon | Avis complémentaire | ⟬trap:initials|SV⟭ |
| 73192 | M. ⟬person_name#5m⟭ | ⟬birth_date#5⟭ | ⟬fr_social_security_number#5⟭ | Prostate | Radio-chimiothérapie | ⟬trap:initials|PLG⟭ |
| 62908 | M. ⟬person_name#6m⟭ | ⟬birth_date#6⟭ | ⟬fr_social_security_number#6⟭ | Sein | Radio-chimiothérapie | ⟬trap:initials|SV⟭ |
| 39476 | M. ⟬person_name#7m⟭ | ⟬birth_date#7⟭ | ⟬fr_social_security_number#7⟭ | ORL | Chirurgie | ⟬trap:initials|PLG⟭ |
| 20159 | Mme ⟬person_name#8f⟭ | ⟬birth_date#8⟭ | ⟬fr_social_security_number#8⟭ | ORL | Radio-chimiothérapie | ⟬trap:initials|SV⟭ |
| 14548 | Mme ⟬person_name#9f⟭ | ⟬birth_date#9⟭ | ⟬fr_social_security_number#9⟭ | Sein | Chirurgie | ⟬trap:initials|SV⟭ |

Comptes rendus envoyés aux médecins traitants après validation.
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: real estate
appearance: fixed columns, rent call listing, bank account, SIREN of the manager
scenario: monthly rent call listing printed by a property manager's old accounting package
⟬text⟭
⟬company#30⟭                     SIREN ⟬fr_siren#30⟭
⟬fr_postal_address#30⟭
APPEL DE LOYERS                      ECHEANCE ⟬date#1⟭
IMMEUBLE 0412

LOT  LOYER     CHARGES  COMPTE PRELEVE  LOCATAIRE
---  --------  -------  --------------  ------------------------------
036  938,15  145,00  ⟬bank_account_number#1⟭  ⟬person_name#1⟭
039  836,54  136,00  ⟬bank_account_number#2⟭  ⟬person_name#2⟭
034  791,41  75,00  ⟬bank_account_number#3⟭  ⟬person_name#3⟭
018  908,75  167,00  ⟬bank_account_number#4⟭  ⟬person_name#4⟭
025  738,34  82,00  ⟬bank_account_number#5⟭  ⟬person_name#5⟭
044  716,88  129,00  ⟬bank_account_number#6⟭  ⟬person_name#6⟭
033  862,37  142,00  ⟬bank_account_number#7⟭  ⟬person_name#7⟭
017  714,59  156,00  ⟬bank_account_number#8⟭  ⟬person_name#8⟭
027  926,07  174,00  ⟬bank_account_number#9⟭  ⟬person_name#9⟭
014  954,65  153,00  ⟬bank_account_number#10⟭  ⟬person_name#10⟭
006  910,45  148,00  ⟬bank_account_number#11⟭  ⟬person_name#11⟭
017  796,84  115,00  ⟬bank_account_number#12⟭  ⟬person_name#12⟭
039  927,24  136,00  ⟬bank_account_number#13⟭  ⟬person_name#13⟭
042  750,69  166,00  ⟬bank_account_number#14⟭  ⟬person_name#14⟭
047  903,58  124,00  ⟬bank_account_number#15⟭  ⟬person_name#15⟭
048  984,98  106,00  ⟬bank_account_number#16⟭  ⟬person_name#16⟭
017  862,91  76,00  ⟬bank_account_number#17⟭  ⟬person_name#17⟭
038  927,95  173,00  ⟬bank_account_number#18⟭  ⟬person_name#18⟭
021  726,07  68,00  ⟬bank_account_number#19⟭  ⟬person_name#19⟭
009  778,64  107,00  ⟬bank_account_number#20⟭  ⟬person_name#20⟭
---  --------  -------  --------------  ------------------------------
LOTS VACANTS : 2     GESTIONNAIRE : ⟬trap:indicator_non_pii|Pôle gérance⟭
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: public administration
appearance: quoted CSV, town statistics, contact header holding a department
scenario: town population figures shared between departments of a regional council, with no person
⟬text⟭
"commune","cp","population","logements","contact"
"⟬city#1⟭","⟬postcode#1⟭",8421,4017,"⟬trap:indicator_non_pii|Mairie⟭"
"⟬city#2⟭","⟬postcode#2⟭",1276,688,"⟬trap:indicator_non_pii|Mairie⟭"
"⟬city#3⟭","⟬postcode#3⟭",23590,11742,"⟬trap:indicator_non_pii|Service urbanisme⟭"
"⟬city#4⟭","⟬postcode#4⟭",642,351,"⟬trap:indicator_non_pii|Mairie⟭"
"⟬city#5⟭","⟬postcode#5⟭",5108,2379,"⟬trap:indicator_non_pii|Communauté de communes⟭"
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: HR
appearance: TSV cell, absence rates, manager column with no person
scenario: absence rates per department computed by an HR analyst, with no employee
⟬text⟭
service	effectif	taux_absenteisme	accidents	responsable
Atelier	84	6,2	3	⟬trap:indicator_non_pii|Direction industrielle⟭
Magasin	31	4,8	1	⟬trap:indicator_non_pii|Direction industrielle⟭
Bureau d'études	22	2,1	0	⟬trap:indicator_non_pii|Direction technique⟭
Administration	17	3,4	0	⟬trap:indicator_non_pii|Direction générale⟭
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: education
appearance: phpMyAdmin dump, INSERT with column list, pupils and guardians in linked tables, password hash, reset token
scenario: phpMyAdmin dump of a primary school's canteen billing database, sent by the town's IT contractor
⟬text⟭
-- phpMyAdmin SQL Dump
-- version ⟬version#1⟭
-- Hôte : ⟬hostname#1⟭
-- Version de PHP : ⟬version#2⟭

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- Base de données : `cantine`

CREATE TABLE `responsable` (
  `id` int(11) NOT NULL,
  `nom` varchar(120) NOT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `iban` varchar(34) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `responsable` (`id`, `nom`, `adresse`, `iban`, `email`) VALUES
(1, '⟬person_name#21⟭', '⟬fr_postal_address#21⟭', '⟬iban#21⟭', '⟬email#21⟭'),
(2, '⟬person_name#22⟭', '⟬fr_postal_address#22⟭', '⟬iban#22⟭', '⟬email#22⟭'),
(3, '⟬person_name#23⟭', '⟬fr_postal_address#23⟭', '⟬iban#23⟭', '⟬email#23⟭'),
(4, '⟬person_name#24⟭', '⟬fr_postal_address#24⟭', '⟬iban#24⟭', '⟬email#24⟭'),
(5, '⟬person_name#25⟭', '⟬fr_postal_address#25⟭', '⟬iban#25⟭', '⟬email#25⟭');

CREATE TABLE `eleve` (
  `id` int(11) NOT NULL,
  `nom` varchar(80) NOT NULL,
  `prenom` varchar(80) NOT NULL,
  `date_naissance` date DEFAULT NULL,
  `classe` varchar(5) DEFAULT NULL,
  `regime` varchar(20) DEFAULT NULL,
  `responsable_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `eleve` (`id`, `nom`, `prenom`, `date_naissance`, `classe`, `regime`, `responsable_id`) VALUES (301, '⟬person_name:family#1⟭', '⟬person_name:given#1⟭', '⟬birth_date#1⟭', 'CM1', 'Cantine 2j', 1);
INSERT INTO `eleve` (`id`, `nom`, `prenom`, `date_naissance`, `classe`, `regime`, `responsable_id`) VALUES (302, '⟬person_name:family#2⟭', '⟬person_name:given#2⟭', '⟬birth_date#2⟭', 'CE1', 'Externe', 4);
INSERT INTO `eleve` (`id`, `nom`, `prenom`, `date_naissance`, `classe`, `regime`, `responsable_id`) VALUES (303, '⟬person_name:family#3⟭', '⟬person_name:given#3⟭', '⟬birth_date#3⟭', 'CE2', 'Externe', 5);
INSERT INTO `eleve` (`id`, `nom`, `prenom`, `date_naissance`, `classe`, `regime`, `responsable_id`) VALUES (304, '⟬person_name:family#4⟭', '⟬person_name:given#4⟭', '⟬birth_date#4⟭', 'CP', 'Externe', 5);
INSERT INTO `eleve` (`id`, `nom`, `prenom`, `date_naissance`, `classe`, `regime`, `responsable_id`) VALUES (305, '⟬person_name:family#5⟭', '⟬person_name:given#5⟭', '⟬birth_date#5⟭', 'CE1', 'Cantine 2j', 4);
INSERT INTO `eleve` (`id`, `nom`, `prenom`, `date_naissance`, `classe`, `regime`, `responsable_id`) VALUES (306, '⟬person_name:family#6⟭', '⟬person_name:given#6⟭', '⟬birth_date#6⟭', 'CE1', 'Cantine 2j', 3);
INSERT INTO `eleve` (`id`, `nom`, `prenom`, `date_naissance`, `classe`, `regime`, `responsable_id`) VALUES (307, '⟬person_name:family#7⟭', '⟬person_name:given#7⟭', '⟬birth_date#7⟭', 'CM1', 'Externe', 4);
INSERT INTO `eleve` (`id`, `nom`, `prenom`, `date_naissance`, `classe`, `regime`, `responsable_id`) VALUES (308, '⟬person_name:family#8⟭', '⟬person_name:given#8⟭', '⟬birth_date#8⟭', 'CP', 'Cantine 4j', 4);
INSERT INTO `eleve` (`id`, `nom`, `prenom`, `date_naissance`, `classe`, `regime`, `responsable_id`) VALUES (309, '⟬person_name:family#9⟭', '⟬person_name:given#9⟭', '⟬birth_date#9⟭', 'CM1', 'Externe', 4);
INSERT INTO `eleve` (`id`, `nom`, `prenom`, `date_naissance`, `classe`, `regime`, `responsable_id`) VALUES (310, '⟬person_name:family#10⟭', '⟬person_name:given#10⟭', '⟬birth_date#10⟭', 'CP', 'Cantine 4j', 2);

CREATE TABLE `compte_portail` (
  `responsable_id` int(11) NOT NULL,
  `mdp_hash` char(64) DEFAULT NULL,
  `token_reinit` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `compte_portail` (`responsable_id`, `mdp_hash`, `token_reinit`) VALUES
(1, '⟬hash#21⟭', '⟬opaque_token#21⟭'),
(2, '⟬hash#22⟭', NULL),
(3, '⟬hash#23⟭', '⟬opaque_token#23⟭');

ALTER TABLE `eleve` ADD PRIMARY KEY (`id`);
COMMIT;
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: pasted cells, pharmacy stock, eponym products, responsible label with no person
scenario: pharmacy stock sheet of a clinic pasted into a ticket, listing batches and alert thresholds
⟬text⟭
Clinique - stock pharmacie, armoire du 2e étage
Responsable du suivi :	⟬trap:indicator_non_pii|Pharmacie centrale⟭

Produit	Lot	Contrôle	Quantité	Seuil	Action
Insuline rapide	L25315	⟬date#1⟭	46	94	OK
Amoxicilline 500 mg	L22900	⟬date#2⟭	121	22	OK
Paracétamol 1 g	L55362	⟬date#3⟭	319	81	Rupture
⟬trap:eponym|Ringer lactate⟭ 500 mL	L21965	⟬date#1⟭	365	34	OK
Compresses stériles	L73799	⟬date#1⟭	33	105	Rupture
Amoxicilline 500 mg	L88835	⟬date#3⟭	45	85	OK
Héparine 5000 UI	L82932	⟬date#1⟭	330	58	Rupture
Morphine 10 mg	L44924	⟬date#1⟭	335	45	Rupture
Compresses stériles	L97216	⟬date#1⟭	260	29	OK
Morphine 10 mg	L28844	⟬date#3⟭	242	104	Rupture
⟬trap:eponym|Ringer lactate⟭ 500 mL	L17100	⟬date#1⟭	300	83	OK
Amoxicilline 500 mg	L83050	⟬date#1⟭	73	23	Commander
Amoxicilline 500 mg	L79426	⟬date#1⟭	343	59	Rupture
Paracétamol 1 g	L64558	⟬date#2⟭	339	25	OK
Héparine 5000 UI	L30259	⟬date#2⟭	79	119	Rupture
Paracétamol 1 g	L83807	⟬date#2⟭	391	64	Rupture
Morphine 10 mg	L86396	⟬date#2⟭	243	25	Rupture
⟬trap:eponym|Sonde de Foley⟭ CH16	L32278	⟬date#2⟭	375	119	Rupture
Héparine 5000 UI	L46050	⟬date#1⟭	398	43	Rupture
Furosémide 40 mg	L25658	⟬date#3⟭	52	82	Rupture
Héparine 5000 UI	L94022	⟬date#1⟭	176	33	OK

Inventaire tournant, à refaire chaque semaine
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: real estate
appearance: Markdown table, SIREN, company landlords, address cell
scenario: short table in a notary's preparation notes on the landlords of a commercial building
⟬text⟭
Bailleurs du centre commercial :

| Cellule | Bailleur | SIREN | Siège |
| --- | --- | --- | --- |
| A2 | ⟬company#1⟭ | ⟬fr_siren#1⟭ | ⟬fr_postal_address#1⟭ |
| A3 | ⟬company#2⟭ | ⟬fr_siren#2⟭ | ⟬fr_postal_address#2⟭ |
| B1 | ⟬person_name#3⟭ | ⟬fr_siren#3⟭ | ⟬fr_postal_address#3⟭ |
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: associations
appearance: bank file layout, record codes, account numbers, company named after a family, access key in the header
scenario: direct debit batch for membership fees, exported in a bank's fixed layout by a choir's treasurer
⟬text⟭
0308  EMETTEUR ⟬trap:company_name|CHORALE ⦃FAMILY⦄⟭             REMISE ⟬date#1⟭
0308  RESPONSABLE ⟬trap:indicator_non_pii|TRESORERIE⟭
0308  CLE D'ACCES ⟬opaque_token#50⟭

CODE  REFERENCE MANDAT  MONTANT  COMPTE DEBITE  DEBITEUR
0678  74090602  75,00  ⟬bank_account_number#1⟭  ⟬person_name#1⟭
0643  79290762  20,00  ⟬bank_account_number#2⟭  ⟬person_name#2⟭
0678  24378609  75,00  ⟬bank_account_number#3⟭  ⟬person_name#3⟭
0684  50580575  35,00  ⟬bank_account_number#4⟭  ⟬person_name#4⟭
0633  15525120  75,00  ⟬bank_account_number#5⟭  ⟬person_name#5⟭
0689  33074515  50,00  ⟬bank_account_number#6⟭  ⟬person_name#6⟭
0699  66472535  35,00  ⟬bank_account_number#7⟭  ⟬person_name#7⟭
0666  21906302  35,00  ⟬bank_account_number#8⟭  ⟬person_name#8⟭
0616  11646463  75,00  ⟬bank_account_number#9⟭  ⟬person_name#9⟭
0646  92163261  50,00  ⟬bank_account_number#10⟭  ⟬person_name#10⟭
0697  14225184  20,00  ⟬bank_account_number#11⟭  ⟬person_name#11⟭
0611  48076424  20,00  ⟬bank_account_number#12⟭  ⟬person_name#12⟭
0694  60655349  20,00  ⟬bank_account_number#13⟭  ⟬person_name#13⟭
0627  98165848  35,00  ⟬bank_account_number#14⟭  ⟬person_name#14⟭
0694  35404351  75,00  ⟬bank_account_number#15⟭  ⟬person_name#15⟭
0657  66932652  35,00  ⟬bank_account_number#16⟭  ⟬person_name#16⟭
0650  50317253  35,00  ⟬bank_account_number#17⟭  ⟬person_name#17⟭
0694  48451405  50,00  ⟬bank_account_number#18⟭  ⟬person_name#18⟭
0686  74883741  35,00  ⟬bank_account_number#19⟭  ⟬person_name#19⟭
0675  55110100  35,00  ⟬bank_account_number#20⟭  ⟬person_name#20⟭
0662  96807077  35,00  ⟬bank_account_number#21⟭  ⟬person_name#21⟭
0666  91770529  50,00  ⟬bank_account_number#22⟭  ⟬person_name#22⟭
0694  57772924  35,00  ⟬bank_account_number#23⟭  ⟬person_name#23⟭
0694  31616684  20,00  ⟬bank_account_number#24⟭  ⟬person_name#24⟭
0808  TOTAL REMISE      24 OPERATIONS
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: HR
appearance: quoted CSV, driving licence, identity card, licence category
scenario: file of delivery drivers exported by a temp agency for a client's site access request
⟬text⟭
"interimaire","num_permis","piece_identite","categorie","visite_medicale","site","fimo_a_jour"
"⟬person_name#1⟭","⟬fr_driving_licence#1⟭","⟬fr_identity_card#1⟭","C","⟬date#4⟭","Fos","Oui"
"⟬person_name#2⟭","⟬fr_driving_licence#2⟭","⟬fr_identity_card#2⟭","C","⟬date#3⟭","Fos","Non"
"⟬person_name#3⟭","⟬fr_driving_licence#3⟭","⟬fr_identity_card#3⟭","C1","⟬date#2⟭","Rungis","Non"
"⟬person_name#4⟭","⟬fr_driving_licence#4⟭","⟬fr_identity_card#4⟭","CE","⟬date#3⟭","Fos","Oui"
"⟬person_name#5⟭","⟬fr_driving_licence#5⟭","⟬fr_identity_card#5⟭","C1","⟬date#4⟭","Garonor","Oui"
"⟬person_name#6⟭","⟬fr_driving_licence#6⟭","⟬fr_identity_card#6⟭","D","⟬date#1⟭","Garonor","Oui"
"⟬person_name#7⟭","⟬fr_driving_licence#7⟭","⟬fr_identity_card#7⟭","D","⟬date#6⟭","Rungis","Oui"
"⟬person_name#8⟭","⟬fr_driving_licence#8⟭","⟬fr_identity_card#8⟭","C","⟬date#5⟭","Rungis","Oui"
"⟬person_name#9⟭","⟬fr_driving_licence#9⟭","⟬fr_identity_card#9⟭","D","⟬date#5⟭","Fos","Non"
"⟬person_name#10⟭","⟬fr_driving_licence#10⟭","⟬fr_identity_card#10⟭","C1","⟬date#6⟭","Lyon-Sud","Oui"
"⟬person_name#11⟭","⟬fr_driving_licence#11⟭","⟬fr_identity_card#11⟭","D","⟬date#5⟭","Rungis","Non"
"⟬person_name#12⟭","⟬fr_driving_licence#12⟭","⟬fr_identity_card#12⟭","C1","⟬date#3⟭","Garonor","Non"
"⟬person_name#13⟭","⟬fr_driving_licence#13⟭","⟬fr_identity_card#13⟭","D","⟬date#4⟭","Fos","Oui"
"⟬person_name#14⟭","⟬fr_driving_licence#14⟭","⟬fr_identity_card#14⟭","CE","⟬date#3⟭","Garonor","Oui"
"⟬person_name#15⟭","⟬fr_driving_licence#15⟭","⟬fr_identity_card#15⟭","D","⟬date#3⟭","Fos","Oui"
"⟬person_name#16⟭","⟬fr_driving_licence#16⟭","⟬fr_identity_card#16⟭","C","⟬date#2⟭","Rungis","Non"
"⟬person_name#17⟭","⟬fr_driving_licence#17⟭","⟬fr_identity_card#17⟭","B","⟬date#5⟭","Fos","Non"
"⟬person_name#18⟭","⟬fr_driving_licence#18⟭","⟬fr_identity_card#18⟭","C","⟬date#6⟭","Fos","Oui"
"⟬person_name#19⟭","⟬fr_driving_licence#19⟭","⟬fr_identity_card#19⟭","D","⟬date#4⟭","Lyon-Sud","Oui"
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: education
appearance: headerless TSV, passport with no announcing word
scenario: headerless list a teacher copied from the school system for a language exchange group
⟬text⟭
⟬person_name#1⟭	⟬fr_passport#1⟭	⟬city#1⟭	Valence	Oui
⟬person_name#2⟭	⟬fr_passport#2⟭	⟬city#2⟭	Valence	Oui
⟬person_name#3⟭	⟬fr_passport#3⟭	⟬city#3⟭	Salamanque	Non
⟬person_name#4⟭	⟬fr_passport#4⟭	⟬city#4⟭	Salamanque	Oui
⟬person_name#5⟭	⟬fr_passport#5⟭	⟬city#5⟭	Valence	Oui
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: pg_dump, INSERT with column list, COPY block of measurements, SIREN of an insurer, password in a connection URL
scenario: pg_dump of the resident database of a care home, kept by the IT provider to prepare a data migration
⟬text⟭
-- Dump de la base ehpad, schéma public
-- généré par sauvegarde_nuit.sh sur ⟬hostname#1⟭ le ⟬date#1⟭

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

CREATE TABLE public.mutuelle (
    id integer PRIMARY KEY,
    raison_sociale text NOT NULL,
    siren character varying(11)
);

CREATE TABLE public.referent (
    id integer PRIMARY KEY,
    nom text NOT NULL,
    lien text,
    tel text,
    iban_facturation text
);

CREATE TABLE public.resident (
    id integer PRIMARY KEY,
    civilite character varying(4),
    nom_usage text NOT NULL,
    date_naissance date NOT NULL,
    nir character(21),
    cni text,
    chambre integer,
    entree date,
    referent_id integer REFERENCES public.referent (id)
);

CREATE TABLE public.constante (
    resident_id integer NOT NULL,
    releve date NOT NULL,
    tension_sys integer,
    tension_dia integer,
    poids numeric(4,1)
);

INSERT INTO public.mutuelle (id, raison_sociale, siren) VALUES (1, '⟬company#30⟭', '⟬fr_siren#30⟭');
INSERT INTO public.mutuelle (id, raison_sociale, siren) VALUES (2, '⟬company#31⟭', '⟬fr_siren#31⟭');

INSERT INTO public.referent (id, nom, lien, tel, iban_facturation) VALUES (1, '⟬person_name#21⟭', 'Fils ou fille', '⟬phone#21⟭', '⟬iban#21⟭');
INSERT INTO public.referent (id, nom, lien, tel, iban_facturation) VALUES (2, '⟬person_name#22⟭', 'Tuteur', '⟬phone#22⟭', '⟬iban#22⟭');
INSERT INTO public.referent (id, nom, lien, tel, iban_facturation) VALUES (3, '⟬person_name#23⟭', 'Neveu ou nièce', '⟬phone#23⟭', '⟬iban#23⟭');
INSERT INTO public.referent (id, nom, lien, tel, iban_facturation) VALUES (4, '⟬person_name#24⟭', 'Fils ou fille', '⟬phone#24⟭', '⟬iban#24⟭');

INSERT INTO public.resident (id, civilite, nom_usage, date_naissance, nir, cni, chambre, entree, referent_id) VALUES (1, 'Mme', '⟬person_name#1f⟭', '⟬birth_date#1⟭', '⟬fr_social_security_number#1⟭', '⟬fr_identity_card#1⟭', 171, '⟬date#1⟭', 1);
INSERT INTO public.resident (id, civilite, nom_usage, date_naissance, nir, cni, chambre, entree, referent_id) VALUES (2, 'M.', '⟬person_name#2m⟭', '⟬birth_date#2⟭', '⟬fr_social_security_number#2⟭', '⟬fr_identity_card#2⟭', 155, '⟬date#4⟭', 4);
INSERT INTO public.resident (id, civilite, nom_usage, date_naissance, nir, cni, chambre, entree, referent_id) VALUES (3, 'Mme', '⟬person_name#3f⟭', '⟬birth_date#3⟭', '⟬fr_social_security_number#3⟭', '⟬fr_identity_card#3⟭', 230, '⟬date#7⟭', 3);
INSERT INTO public.resident (id, civilite, nom_usage, date_naissance, nir, cni, chambre, entree, referent_id) VALUES (4, 'M.', '⟬person_name#4m⟭', '⟬birth_date#4⟭', '⟬fr_social_security_number#4⟭', '⟬fr_identity_card#4⟭', 213, '⟬date#7⟭', 2);
INSERT INTO public.resident (id, civilite, nom_usage, date_naissance, nir, cni, chambre, entree, referent_id) VALUES (5, 'Mme', '⟬person_name#5f⟭', '⟬birth_date#5⟭', '⟬fr_social_security_number#5⟭', '⟬fr_identity_card#5⟭', 270, '⟬date#4⟭', 4);
INSERT INTO public.resident (id, civilite, nom_usage, date_naissance, nir, cni, chambre, entree, referent_id) VALUES (6, 'Mme', '⟬person_name#6f⟭', '⟬birth_date#6⟭', '⟬fr_social_security_number#6⟭', '⟬fr_identity_card#6⟭', 295, '⟬date#4⟭', 2);
INSERT INTO public.resident (id, civilite, nom_usage, date_naissance, nir, cni, chambre, entree, referent_id) VALUES (7, 'Mme', '⟬person_name#7f⟭', '⟬birth_date#7⟭', '⟬fr_social_security_number#7⟭', '⟬fr_identity_card#7⟭', 324, '⟬date#8⟭', 1);
INSERT INTO public.resident (id, civilite, nom_usage, date_naissance, nir, cni, chambre, entree, referent_id) VALUES (8, 'Mme', '⟬person_name#8f⟭', '⟬birth_date#8⟭', '⟬fr_social_security_number#8⟭', '⟬fr_identity_card#8⟭', 346, '⟬date#6⟭', 2);

COPY public.constante (resident_id, releve, tension_sys, tension_dia, poids) FROM stdin;
3	⟬date#2⟭	149	91	77.7
8	⟬date#1⟭	111	58	50.1
6	⟬date#3⟭	146	80	52.7
3	⟬date#3⟭	106	62	81.7
3	⟬date#1⟭	107	92	88.0
7	⟬date#1⟭	152	67	75.2
1	⟬date#2⟭	143	69	74.7
8	⟬date#1⟭	111	79	55.8
2	⟬date#3⟭	159	85	73.5
1	⟬date#2⟭	113	70	72.6
1	⟬date#2⟭	168	86	49.2
4	⟬date#2⟭	145	68	63.1
6	⟬date#4⟭	160	81	85.5
3	⟬date#5⟭	119	93	58.4
8	⟬date#2⟭	111	87	53.2
8	⟬date#2⟭	106	65	50.7
1	⟬date#4⟭	115	63	63.7
4	⟬date#5⟭	134	90	63.3
5	⟬date#1⟭	144	77	67.2
6	⟬date#2⟭	159	76	44.3
3	⟬date#4⟭	168	70	80.0
7	⟬date#5⟭	163	61	51.1
1	⟬date#5⟭	165	76	62.1
5	⟬date#4⟭	131	63	50.3
\.

CREATE TABLE public.connecteur (nom text PRIMARY KEY, url text);
INSERT INTO public.connecteur (nom, url) VALUES ('tiers_payant', 'postgresql://ehpad:⟬url_password#50⟭@⟬hostname#2⟭:5432/tiers');

SELECT pg_catalog.setval('public.resident_id_seq', 8, true);
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: real estate
appearance: pandas output, aligned columns, row index, tax number, passport, truncated rows
scenario: data frame printed in a notebook by a developer analysing a social housing waiting list loaded from a workbook
⟬text⟭
>>> df = pd.read_excel("attributions.xlsx", sheet_name="Demandes")
>>> print(df.head(14).to_string())
    typo  demandeur   num_fiscal   rfr   situation   passeport
0   T1   ⟬person_name#1⟭   ⟬fr_tax_number#1⟭   40 697   CDI   ⟬fr_passport#1⟭
1   T1   ⟬person_name#2⟭   ⟬fr_tax_number#2⟭   44 376   Indépendant   ⟬fr_passport#2⟭
2   T2   ⟬person_name#3⟭   ⟬fr_tax_number#3⟭   35 696   Indépendant   ⟬fr_passport#3⟭
3   T2   ⟬person_name#4⟭   ⟬fr_tax_number#4⟭   56 404   Indépendant   ⟬fr_passport#4⟭
4   T2   ⟬person_name#5⟭   ⟬fr_tax_number#5⟭   23 302   Retraite   ⟬fr_passport#5⟭
5   T3   ⟬person_name#6⟭   ⟬fr_tax_number#6⟭   39 310   Retraite   ⟬fr_passport#6⟭
6   T3   ⟬person_name#7⟭   ⟬fr_tax_number#7⟭   21 177   CDI   ⟬fr_passport#7⟭
7   T4   ⟬person_name#8⟭   ⟬fr_tax_number#8⟭   20 329   CDI   ⟬fr_passport#8⟭
8   T4   ⟬person_name#9⟭   ⟬fr_tax_number#9⟭   36 816   Indépendant   ⟬fr_passport#9⟭
9   T1   ⟬person_name#10⟭   ⟬fr_tax_number#10⟭   22 428   Retraite   ⟬fr_passport#10⟭
10  T1   ⟬person_name#11⟭   ⟬fr_tax_number#11⟭   43 234   Retraite   ⟬fr_passport#11⟭
11  T2   ⟬person_name#12⟭   ⟬fr_tax_number#12⟭   52 231   Retraite   ⟬fr_passport#12⟭
12  T1   ⟬person_name#13⟭   ⟬fr_tax_number#13⟭   52 945   CDI   ⟬fr_passport#13⟭
13  T1   ⟬person_name#14⟭   ⟬fr_tax_number#14⟭   24 814   CDI   ⟬fr_passport#14⟭
>>> df.shape
(412, 6)
>>> df["situation"].value_counts()
CDI            187
CDD             96
Retraite        74
Indépendant     55
Name: situation, dtype: int64
⟬end⟭
