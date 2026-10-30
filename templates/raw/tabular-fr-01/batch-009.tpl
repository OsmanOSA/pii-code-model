⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: HR
appearance: Markdown table, handle beside a full name, NIR, IBAN for final pay
scenario: offboarding table kept by the HR and IT teams, with accounts to close and final payments
⟬text⟭
# Départs du mois

Tableau commun RH et informatique. Les comptes se ferment le soir du dernier jour.

| Collaborateur | Compte | NIR | Dernier jour | Solde de tout compte | IBAN | Matériel rendu | Mail perso |
| --- | --- | --- | --- | ---: | --- | --- | --- |
| ⟬person_name#1⟭ | ⟬person_name:handle#1⟭ | ⟬fr_social_security_number#1⟭ | ⟬date#2⟭ | 6111,36 € | ⟬iban#1⟭ | À faire | ⟬email#1⟭ |
| ⟬person_name#2⟭ | ⟬person_name:handle#2⟭ | ⟬fr_social_security_number#2⟭ | ⟬date#1⟭ | 3556,09 € | ⟬iban#2⟭ | À faire | ⟬email#2⟭ |
| ⟬person_name#3⟭ | ⟬person_name:handle#3⟭ | ⟬fr_social_security_number#3⟭ | ⟬date#3⟭ | 1862,61 € | ⟬iban#3⟭ | Fait | ⟬email#3⟭ |
| ⟬person_name#4⟭ | ⟬person_name:handle#4⟭ | ⟬fr_social_security_number#4⟭ | ⟬date#1⟭ | 4110,26 € | ⟬iban#4⟭ | Fait | ⟬email#4⟭ |
| ⟬person_name#5⟭ | ⟬person_name:handle#5⟭ | ⟬fr_social_security_number#5⟭ | ⟬date#2⟭ | 7173,00 € | ⟬iban#5⟭ | Fait | ⟬email#5⟭ |
| ⟬person_name#6⟭ | ⟬person_name:handle#6⟭ | ⟬fr_social_security_number#6⟭ | ⟬date#2⟭ | 3849,28 € | ⟬iban#6⟭ | À faire | ⟬email#6⟭ |
| ⟬person_name#7⟭ | ⟬person_name:handle#7⟭ | ⟬fr_social_security_number#7⟭ | ⟬date#1⟭ | 3695,24 € | ⟬iban#7⟭ | À faire | ⟬email#7⟭ |
| ⟬person_name#8⟭ | ⟬person_name:handle#8⟭ | ⟬fr_social_security_number#8⟭ | ⟬date#3⟭ | 5121,42 € | ⟬iban#8⟭ | Fait | ⟬email#8⟭ |
| ⟬person_name#9⟭ | ⟬person_name:handle#9⟭ | ⟬fr_social_security_number#9⟭ | ⟬date#3⟭ | 4015,78 € | ⟬iban#9⟭ | À faire | ⟬email#9⟭ |

Compte de service ⟬trap:indicator_non_pii|svc_paie⟭ : ne pas fermer, il sert aux exports.
Contact informatique : ⟬person_name#30⟭.
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: education
appearance: fixed columns, passport, no birth word
scenario: passport check for a school trip, printed by the school's travel tool
⟬text⟭
SORTIE ANGLETERRE - CONTROLE DES PASSEPORTS
GR  PASSEPORT    EXPIRATION    ELEVE
A   ⟬fr_passport#1⟭  ⟬date#1⟭    ⟬person_name#1⟭
A   ⟬fr_passport#2⟭  ⟬date#1⟭    ⟬person_name#2⟭
B   ⟬fr_passport#3⟭  ⟬date#2⟭    ⟬person_name#3⟭
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: real estate
appearance: quoted comma CSV, email, identity card, tax number, decimal comma inside quotes
scenario: rental applications received through a website form, exported by a letting agent
⟬text⟭
"candidat","courriel","cni","numero_avis_imposition","bien_recherche","occupants","revenus_annuels","depose_le"
"⟬person_name#1⟭","⟬email#1⟭","⟬fr_identity_card#1⟭","⟬fr_tax_number#1⟭","T2","1","54580,47","⟬date#1⟭"
"⟬person_name#2⟭","⟬email#2⟭","⟬fr_identity_card#2⟭","⟬fr_tax_number#2⟭","T2","1","34961,62","⟬date#3⟭"
"⟬person_name#3⟭","⟬email#3⟭","⟬fr_identity_card#3⟭","⟬fr_tax_number#3⟭","T2","1","67723,57","⟬date#3⟭"
"⟬person_name#4⟭","⟬email#4⟭","⟬fr_identity_card#4⟭","⟬fr_tax_number#4⟭","T1","3","25332,60","⟬date#4⟭"
"⟬person_name#5⟭","⟬email#5⟭","⟬fr_identity_card#5⟭","⟬fr_tax_number#5⟭","T3","3","51740,81","⟬date#3⟭"
"⟬person_name#6⟭","⟬email#6⟭","⟬fr_identity_card#6⟭","⟬fr_tax_number#6⟭","Maison","1","44535,70","⟬date#5⟭"
"⟬person_name#7⟭","⟬email#7⟭","⟬fr_identity_card#7⟭","⟬fr_tax_number#7⟭","T2","2","52654,96","⟬date#3⟭"
"⟬person_name#8⟭","⟬email#8⟭","⟬fr_identity_card#8⟭","⟬fr_tax_number#8⟭","T1","1","65718,73","⟬date#4⟭"
"⟬person_name#9⟭","⟬email#9⟭","⟬fr_identity_card#9⟭","⟬fr_tax_number#9⟭","T3","2","52695,63","⟬date#3⟭"
"⟬person_name#10⟭","⟬email#10⟭","⟬fr_identity_card#10⟭","⟬fr_tax_number#10⟭","T2","1","47356,99","⟬date#2⟭"
"⟬person_name#11⟭","⟬email#11⟭","⟬fr_identity_card#11⟭","⟬fr_tax_number#11⟭","Maison","1","46552,50","⟬date#3⟭"
"⟬person_name#12⟭","⟬email#12⟭","⟬fr_identity_card#12⟭","⟬fr_tax_number#12⟭","Maison","3","27187,23","⟬date#1⟭"
"⟬person_name#13⟭","⟬email#13⟭","⟬fr_identity_card#13⟭","⟬fr_tax_number#13⟭","T2","2","61130,69","⟬date#2⟭"
"⟬person_name#14⟭","⟬email#14⟭","⟬fr_identity_card#14⟭","⟬fr_tax_number#14⟭","Maison","2","52173,18","⟬date#5⟭"
"⟬person_name#15⟭","⟬email#15⟭","⟬fr_identity_card#15⟭","⟬fr_tax_number#15⟭","T1","2","45953,03","⟬date#5⟭"
"⟬person_name#16⟭","⟬email#16⟭","⟬fr_identity_card#16⟭","⟬fr_tax_number#16⟭","T1","2","29188,50","⟬date#1⟭"
"⟬person_name#17⟭","⟬email#17⟭","⟬fr_identity_card#17⟭","⟬fr_tax_number#17⟭","T1","2","66640,18","⟬date#1⟭"
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: associations
appearance: TSV cell, split name and address, birth date beside a joining date, IBAN
scenario: members of a seniors' leisure club, exported from its membership tool to set up direct debits
⟬text⟭
NOM	PRENOM	DDN	ADRESSE	CP	VILLE	IBAN	ACTIVITE	ADHESION	MAIL	AGE
⟬person_name:family#1⟭	⟬person_name:given#1⟭	⟬birth_date#1⟭	⟬fr_postal_address:street#1⟭	⟬postcode#1⟭	⟬city#1⟭	⟬iban#1⟭	Aquagym	⟬date#2⟭	⟬email#1⟭	⟬age#1⟭
⟬person_name:family#2⟭	⟬person_name:given#2⟭	⟬birth_date#2⟭	⟬fr_postal_address:street#2⟭	⟬postcode#2⟭	⟬city#2⟭	⟬iban#2⟭	Tai-chi	⟬date#8⟭	⟬email#2⟭	⟬age#2⟭
⟬person_name:family#3⟭	⟬person_name:given#3⟭	⟬birth_date#3⟭	⟬fr_postal_address:street#3⟭	⟬postcode#3⟭	⟬city#3⟭	⟬iban#3⟭	Bridge	⟬date#6⟭	⟬email#3⟭	⟬age#3⟭
⟬person_name:family#4⟭	⟬person_name:given#4⟭	⟬birth_date#4⟭	⟬fr_postal_address:street#4⟭	⟬postcode#4⟭	⟬city#4⟭	⟬iban#4⟭	Tai-chi	⟬date#8⟭	⟬email#4⟭	⟬age#4⟭
⟬person_name:family#5⟭	⟬person_name:given#5⟭	⟬birth_date#5⟭	⟬fr_postal_address:street#5⟭	⟬postcode#5⟭	⟬city#5⟭	⟬iban#5⟭	Yoga	⟬date#4⟭	⟬email#5⟭	⟬age#5⟭
⟬person_name:family#6⟭	⟬person_name:given#6⟭	⟬birth_date#6⟭	⟬fr_postal_address:street#6⟭	⟬postcode#6⟭	⟬city#6⟭	⟬iban#6⟭	Aquagym	⟬date#5⟭	⟬email#6⟭	⟬age#6⟭
⟬person_name:family#7⟭	⟬person_name:given#7⟭	⟬birth_date#7⟭	⟬fr_postal_address:street#7⟭	⟬postcode#7⟭	⟬city#7⟭	⟬iban#7⟭	Bridge	⟬date#9⟭	⟬email#7⟭	⟬age#7⟭
⟬person_name:family#8⟭	⟬person_name:given#8⟭	⟬birth_date#8⟭	⟬fr_postal_address:street#8⟭	⟬postcode#8⟭	⟬city#8⟭	⟬iban#8⟭	Marche nordique	⟬date#6⟭	⟬email#8⟭	⟬age#8⟭
⟬person_name:family#9⟭	⟬person_name:given#9⟭	⟬birth_date#9⟭	⟬fr_postal_address:street#9⟭	⟬postcode#9⟭	⟬city#9⟭	⟬iban#9⟭	Aquagym	⟬date#1⟭	⟬email#9⟭	⟬age#9⟭
⟬person_name:family#10⟭	⟬person_name:given#10⟭	⟬birth_date#10⟭	⟬fr_postal_address:street#10⟭	⟬postcode#10⟭	⟬city#10⟭	⟬iban#10⟭	Marche nordique	⟬date#2⟭	⟬email#10⟭	⟬age#10⟭
⟬person_name:family#11⟭	⟬person_name:given#11⟭	⟬birth_date#11⟭	⟬fr_postal_address:street#11⟭	⟬postcode#11⟭	⟬city#11⟭	⟬iban#11⟭	Yoga	⟬date#6⟭	⟬email#11⟭	⟬age#11⟭
⟬person_name:family#12⟭	⟬person_name:given#12⟭	⟬birth_date#12⟭	⟬fr_postal_address:street#12⟭	⟬postcode#12⟭	⟬city#12⟭	⟬iban#12⟭	Bridge	⟬date#1⟭	⟬email#12⟭	⟬age#12⟭
⟬person_name:family#13⟭	⟬person_name:given#13⟭	⟬birth_date#13⟭	⟬fr_postal_address:street#13⟭	⟬postcode#13⟭	⟬city#13⟭	⟬iban#13⟭	Tai-chi	⟬date#10⟭	⟬email#13⟭	⟬age#13⟭
⟬person_name:family#14⟭	⟬person_name:given#14⟭	⟬birth_date#14⟭	⟬fr_postal_address:street#14⟭	⟬postcode#14⟭	⟬city#14⟭	⟬iban#14⟭	Tai-chi	⟬date#2⟭	⟬email#14⟭	⟬age#14⟭
⟬person_name:family#15⟭	⟬person_name:given#15⟭	⟬birth_date#15⟭	⟬fr_postal_address:street#15⟭	⟬postcode#15⟭	⟬city#15⟭	⟬iban#15⟭	Aquagym	⟬date#1⟭	⟬email#15⟭	⟬age#15⟭
⟬person_name:family#16⟭	⟬person_name:given#16⟭	⟬birth_date#16⟭	⟬fr_postal_address:street#16⟭	⟬postcode#16⟭	⟬city#16⟭	⟬iban#16⟭	Aquagym	⟬date#7⟭	⟬email#16⟭	⟬age#16⟭
⟬person_name:family#17⟭	⟬person_name:given#17⟭	⟬birth_date#17⟭	⟬fr_postal_address:street#17⟭	⟬postcode#17⟭	⟬city#17⟭	⟬iban#17⟭	Bridge	⟬date#6⟭	⟬email#17⟭	⟬age#17⟭
⟬person_name:family#18⟭	⟬person_name:given#18⟭	⟬birth_date#18⟭	⟬fr_postal_address:street#18⟭	⟬postcode#18⟭	⟬city#18⟭	⟬iban#18⟭	Tai-chi	⟬date#8⟭	⟬email#18⟭	⟬age#18⟭
⟬person_name:family#19⟭	⟬person_name:given#19⟭	⟬birth_date#19⟭	⟬fr_postal_address:street#19⟭	⟬postcode#19⟭	⟬city#19⟭	⟬iban#19⟭	Marche nordique	⟬date#10⟭	⟬email#19⟭	⟬age#19⟭
⟬person_name:family#20⟭	⟬person_name:given#20⟭	⟬birth_date#20⟭	⟬fr_postal_address:street#20⟭	⟬postcode#20⟭	⟬city#20⟭	⟬iban#20⟭	Tai-chi	⟬date#7⟭	⟬email#20⟭	⟬age#20⟭
⟬person_name:family#21⟭	⟬person_name:given#21⟭	⟬birth_date#21⟭	⟬fr_postal_address:street#21⟭	⟬postcode#21⟭	⟬city#21⟭	⟬iban#21⟭	Yoga	⟬date#7⟭	⟬email#21⟭	⟬age#21⟭
⟬person_name:family#22⟭	⟬person_name:given#22⟭	⟬birth_date#22⟭	⟬fr_postal_address:street#22⟭	⟬postcode#22⟭	⟬city#22⟭	⟬iban#22⟭	Tai-chi	⟬date#8⟭	⟬email#22⟭	⟬age#22⟭
⟬person_name:family#23⟭	⟬person_name:given#23⟭	⟬birth_date#23⟭	⟬fr_postal_address:street#23⟭	⟬postcode#23⟭	⟬city#23⟭	⟬iban#23⟭	Yoga	⟬date#1⟭	⟬email#23⟭	⟬age#23⟭
⟬person_name:family#24⟭	⟬person_name:given#24⟭	⟬birth_date#24⟭	⟬fr_postal_address:street#24⟭	⟬postcode#24⟭	⟬city#24⟭	⟬iban#24⟭	Tai-chi	⟬date#2⟭	⟬email#24⟭	⟬age#24⟭
⟬person_name:family#25⟭	⟬person_name:given#25⟭	⟬birth_date#25⟭	⟬fr_postal_address:street#25⟭	⟬postcode#25⟭	⟬city#25⟭	⟬iban#25⟭	Yoga	⟬date#10⟭	⟬email#25⟭	⟬age#25⟭
⟬person_name:family#26⟭	⟬person_name:given#26⟭	⟬birth_date#26⟭	⟬fr_postal_address:street#26⟭	⟬postcode#26⟭	⟬city#26⟭	⟬iban#26⟭	Bridge	⟬date#2⟭	⟬email#26⟭	⟬age#26⟭
⟬person_name:family#27⟭	⟬person_name:given#27⟭	⟬birth_date#27⟭	⟬fr_postal_address:street#27⟭	⟬postcode#27⟭	⟬city#27⟭	⟬iban#27⟭	Tai-chi	⟬date#3⟭	⟬email#27⟭	⟬age#27⟭
⟬person_name:family#28⟭	⟬person_name:given#28⟭	⟬birth_date#28⟭	⟬fr_postal_address:street#28⟭	⟬postcode#28⟭	⟬city#28⟭	⟬iban#28⟭	Aquagym	⟬date#1⟭	⟬email#28⟭	⟬age#28⟭
⟬person_name:family#29⟭	⟬person_name:given#29⟭	⟬birth_date#29⟭	⟬fr_postal_address:street#29⟭	⟬postcode#29⟭	⟬city#29⟭	⟬iban#29⟭	Aquagym	⟬date#4⟭	⟬email#29⟭	⟬age#29⟭
⟬person_name:family#30⟭	⟬person_name:given#30⟭	⟬birth_date#30⟭	⟬fr_postal_address:street#30⟭	⟬postcode#30⟭	⟬city#30⟭	⟬iban#30⟭	Tai-chi	⟬date#1⟭	⟬email#30⟭	⟬age#30⟭
⟬person_name:family#31⟭	⟬person_name:given#31⟭	⟬birth_date#31⟭	⟬fr_postal_address:street#31⟭	⟬postcode#31⟭	⟬city#31⟭	⟬iban#31⟭	Aquagym	⟬date#4⟭	⟬email#31⟭	⟬age#31⟭
⟬person_name:family#32⟭	⟬person_name:given#32⟭	⟬birth_date#32⟭	⟬fr_postal_address:street#32⟭	⟬postcode#32⟭	⟬city#32⟭	⟬iban#32⟭	Aquagym	⟬date#1⟭	⟬email#32⟭	⟬age#32⟭
⟬person_name:family#33⟭	⟬person_name:given#33⟭	⟬birth_date#33⟭	⟬fr_postal_address:street#33⟭	⟬postcode#33⟭	⟬city#33⟭	⟬iban#33⟭	Marche nordique	⟬date#1⟭	⟬email#33⟭	⟬age#33⟭
⟬person_name:family#34⟭	⟬person_name:given#34⟭	⟬birth_date#34⟭	⟬fr_postal_address:street#34⟭	⟬postcode#34⟭	⟬city#34⟭	⟬iban#34⟭	Bridge	⟬date#3⟭	⟬email#34⟭	⟬age#34⟭
⟬person_name:family#35⟭	⟬person_name:given#35⟭	⟬birth_date#35⟭	⟬fr_postal_address:street#35⟭	⟬postcode#35⟭	⟬city#35⟭	⟬iban#35⟭	Aquagym	⟬date#7⟭	⟬email#35⟭	⟬age#35⟭
⟬person_name:family#36⟭	⟬person_name:given#36⟭	⟬birth_date#36⟭	⟬fr_postal_address:street#36⟭	⟬postcode#36⟭	⟬city#36⟭	⟬iban#36⟭	Aquagym	⟬date#4⟭	⟬email#36⟭	⟬age#36⟭
⟬person_name:family#37⟭	⟬person_name:given#37⟭	⟬birth_date#37⟭	⟬fr_postal_address:street#37⟭	⟬postcode#37⟭	⟬city#37⟭	⟬iban#37⟭	Aquagym	⟬date#6⟭	⟬email#37⟭	⟬age#37⟭
⟬person_name:family#38⟭	⟬person_name:given#38⟭	⟬birth_date#38⟭	⟬fr_postal_address:street#38⟭	⟬postcode#38⟭	⟬city#38⟭	⟬iban#38⟭	Aquagym	⟬date#1⟭	⟬email#38⟭	⟬age#38⟭
⟬person_name:family#39⟭	⟬person_name:given#39⟭	⟬birth_date#39⟭	⟬fr_postal_address:street#39⟭	⟬postcode#39⟭	⟬city#39⟭	⟬iban#39⟭	Bridge	⟬date#6⟭	⟬email#39⟭	⟬age#39⟭
⟬person_name:family#40⟭	⟬person_name:given#40⟭	⟬birth_date#40⟭	⟬fr_postal_address:street#40⟭	⟬postcode#40⟭	⟬city#40⟭	⟬iban#40⟭	Yoga	⟬date#4⟭	⟬email#40⟭	⟬age#40⟭
⟬person_name:family#41⟭	⟬person_name:given#41⟭	⟬birth_date#41⟭	⟬fr_postal_address:street#41⟭	⟬postcode#41⟭	⟬city#41⟭	⟬iban#41⟭	Marche nordique	⟬date#3⟭	⟬email#41⟭	⟬age#41⟭
⟬person_name:family#42⟭	⟬person_name:given#42⟭	⟬birth_date#42⟭	⟬fr_postal_address:street#42⟭	⟬postcode#42⟭	⟬city#42⟭	⟬iban#42⟭	Marche nordique	⟬date#9⟭	⟬email#42⟭	⟬age#42⟭
⟬person_name:family#43⟭	⟬person_name:given#43⟭	⟬birth_date#43⟭	⟬fr_postal_address:street#43⟭	⟬postcode#43⟭	⟬city#43⟭	⟬iban#43⟭	Aquagym	⟬date#4⟭	⟬email#43⟭	⟬age#43⟭
⟬person_name:family#44⟭	⟬person_name:given#44⟭	⟬birth_date#44⟭	⟬fr_postal_address:street#44⟭	⟬postcode#44⟭	⟬city#44⟭	⟬iban#44⟭	Aquagym	⟬date#6⟭	⟬email#44⟭	⟬age#44⟭
⟬person_name:family#45⟭	⟬person_name:given#45⟭	⟬birth_date#45⟭	⟬fr_postal_address:street#45⟭	⟬postcode#45⟭	⟬city#45⟭	⟬iban#45⟭	Yoga	⟬date#7⟭	⟬email#45⟭	⟬age#45⟭
⟬person_name:family#46⟭	⟬person_name:given#46⟭	⟬birth_date#46⟭	⟬fr_postal_address:street#46⟭	⟬postcode#46⟭	⟬city#46⟭	⟬iban#46⟭	Bridge	⟬date#3⟭	⟬email#46⟭	⟬age#46⟭
⟬person_name:family#47⟭	⟬person_name:given#47⟭	⟬birth_date#47⟭	⟬fr_postal_address:street#47⟭	⟬postcode#47⟭	⟬city#47⟭	⟬iban#47⟭	Yoga	⟬date#4⟭	⟬email#47⟭	⟬age#47⟭
⟬person_name:family#48⟭	⟬person_name:given#48⟭	⟬birth_date#48⟭	⟬fr_postal_address:street#48⟭	⟬postcode#48⟭	⟬city#48⟭	⟬iban#48⟭	Marche nordique	⟬date#6⟭	⟬email#48⟭	⟬age#48⟭
⟬person_name:family#49⟭	⟬person_name:given#49⟭	⟬birth_date#49⟭	⟬fr_postal_address:street#49⟭	⟬postcode#49⟭	⟬city#49⟭	⟬iban#49⟭	Aquagym	⟬date#6⟭	⟬email#49⟭	⟬age#49⟭
⟬person_name:family#50⟭	⟬person_name:given#50⟭	⟬birth_date#50⟭	⟬fr_postal_address:street#50⟭	⟬postcode#50⟭	⟬city#50⟭	⟬iban#50⟭	Tai-chi	⟬date#5⟭	⟬email#50⟭	⟬age#50⟭
⟬person_name:family#51⟭	⟬person_name:given#51⟭	⟬birth_date#51⟭	⟬fr_postal_address:street#51⟭	⟬postcode#51⟭	⟬city#51⟭	⟬iban#51⟭	Bridge	⟬date#4⟭	⟬email#51⟭	⟬age#51⟭
⟬person_name:family#52⟭	⟬person_name:given#52⟭	⟬birth_date#52⟭	⟬fr_postal_address:street#52⟭	⟬postcode#52⟭	⟬city#52⟭	⟬iban#52⟭	Yoga	⟬date#3⟭	⟬email#52⟭	⟬age#52⟭
⟬person_name:family#53⟭	⟬person_name:given#53⟭	⟬birth_date#53⟭	⟬fr_postal_address:street#53⟭	⟬postcode#53⟭	⟬city#53⟭	⟬iban#53⟭	Marche nordique	⟬date#9⟭	⟬email#53⟭	⟬age#53⟭
⟬person_name:family#54⟭	⟬person_name:given#54⟭	⟬birth_date#54⟭	⟬fr_postal_address:street#54⟭	⟬postcode#54⟭	⟬city#54⟭	⟬iban#54⟭	Marche nordique	⟬date#1⟭	⟬email#54⟭	⟬age#54⟭
⟬person_name:family#55⟭	⟬person_name:given#55⟭	⟬birth_date#55⟭	⟬fr_postal_address:street#55⟭	⟬postcode#55⟭	⟬city#55⟭	⟬iban#55⟭	Marche nordique	⟬date#6⟭	⟬email#55⟭	⟬age#55⟭
⟬person_name:family#56⟭	⟬person_name:given#56⟭	⟬birth_date#56⟭	⟬fr_postal_address:street#56⟭	⟬postcode#56⟭	⟬city#56⟭	⟬iban#56⟭	Bridge	⟬date#3⟭	⟬email#56⟭	⟬age#56⟭
⟬person_name:family#57⟭	⟬person_name:given#57⟭	⟬birth_date#57⟭	⟬fr_postal_address:street#57⟭	⟬postcode#57⟭	⟬city#57⟭	⟬iban#57⟭	Yoga	⟬date#8⟭	⟬email#57⟭	⟬age#57⟭
⟬person_name:family#58⟭	⟬person_name:given#58⟭	⟬birth_date#58⟭	⟬fr_postal_address:street#58⟭	⟬postcode#58⟭	⟬city#58⟭	⟬iban#58⟭	Bridge	⟬date#5⟭	⟬email#58⟭	⟬age#58⟭
⟬person_name:family#59⟭	⟬person_name:given#59⟭	⟬birth_date#59⟭	⟬fr_postal_address:street#59⟭	⟬postcode#59⟭	⟬city#59⟭	⟬iban#59⟭	Marche nordique	⟬date#4⟭	⟬email#59⟭	⟬age#59⟭
⟬person_name:family#60⟭	⟬person_name:given#60⟭	⟬birth_date#60⟭	⟬fr_postal_address:street#60⟭	⟬postcode#60⟭	⟬city#60⟭	⟬iban#60⟭	Aquagym	⟬date#3⟭	⟬email#60⟭	⟬age#60⟭
⟬person_name:family#61⟭	⟬person_name:given#61⟭	⟬birth_date#61⟭	⟬fr_postal_address:street#61⟭	⟬postcode#61⟭	⟬city#61⟭	⟬iban#61⟭	Aquagym	⟬date#5⟭	⟬email#61⟭	⟬age#61⟭
⟬person_name:family#62⟭	⟬person_name:given#62⟭	⟬birth_date#62⟭	⟬fr_postal_address:street#62⟭	⟬postcode#62⟭	⟬city#62⟭	⟬iban#62⟭	Tai-chi	⟬date#7⟭	⟬email#62⟭	⟬age#62⟭
⟬person_name:family#63⟭	⟬person_name:given#63⟭	⟬birth_date#63⟭	⟬fr_postal_address:street#63⟭	⟬postcode#63⟭	⟬city#63⟭	⟬iban#63⟭	Tai-chi	⟬date#4⟭	⟬email#63⟭	⟬age#63⟭
⟬person_name:family#64⟭	⟬person_name:given#64⟭	⟬birth_date#64⟭	⟬fr_postal_address:street#64⟭	⟬postcode#64⟭	⟬city#64⟭	⟬iban#64⟭	Bridge	⟬date#7⟭	⟬email#64⟭	⟬age#64⟭
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: public administration
appearance: upper-case quoted identifiers, COMMIT WORK, NIR, tax number, IBAN, birth date beside career dates
scenario: export of a town's staff tables from an old database, kept to feed the new HR application
⟬text⟭
-- Export base PERSONNEL
SET SCHEMA "RH";

CREATE TABLE "AGENT" (
  "ID" INTEGER NOT NULL PRIMARY KEY,
  "NOM_PRENOM" VARCHAR(160) NOT NULL,
  "DATE_NAISSANCE" DATE,
  "NIR" VARCHAR(21),
  "NUM_FISCAL" VARCHAR(16),
  "ADRESSE" VARCHAR(255),
  "GRADE" VARCHAR(60),
  "IBAN" VARCHAR(34)
);

CREATE TABLE "CARRIERE" (
  "AGENT_ID" INTEGER NOT NULL,
  "ECHELON" SMALLINT,
  "EFFET" DATE
);

INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (41, '⟬person_name#1⟭', '⟬birth_date#1⟭', '⟬fr_social_security_number#1⟭', '⟬fr_tax_number#1⟭', '⟬fr_postal_address#1⟭', 'Attaché', '⟬iban#1⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (42, '⟬person_name#2⟭', '⟬birth_date#2⟭', '⟬fr_social_security_number#2⟭', '⟬fr_tax_number#2⟭', '⟬fr_postal_address#2⟭', 'Adjoint administratif', '⟬iban#2⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (43, '⟬person_name#3⟭', '⟬birth_date#3⟭', '⟬fr_social_security_number#3⟭', '⟬fr_tax_number#3⟭', '⟬fr_postal_address#3⟭', 'Rédacteur', '⟬iban#3⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (44, '⟬person_name#4⟭', '⟬birth_date#4⟭', '⟬fr_social_security_number#4⟭', '⟬fr_tax_number#4⟭', '⟬fr_postal_address#4⟭', 'Rédacteur', '⟬iban#4⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (45, '⟬person_name#5⟭', '⟬birth_date#5⟭', '⟬fr_social_security_number#5⟭', '⟬fr_tax_number#5⟭', '⟬fr_postal_address#5⟭', 'Adjoint administratif', '⟬iban#5⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (46, '⟬person_name#6⟭', '⟬birth_date#6⟭', '⟬fr_social_security_number#6⟭', '⟬fr_tax_number#6⟭', '⟬fr_postal_address#6⟭', 'Rédacteur', '⟬iban#6⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (47, '⟬person_name#7⟭', '⟬birth_date#7⟭', '⟬fr_social_security_number#7⟭', '⟬fr_tax_number#7⟭', '⟬fr_postal_address#7⟭', 'Adjoint administratif', '⟬iban#7⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (48, '⟬person_name#8⟭', '⟬birth_date#8⟭', '⟬fr_social_security_number#8⟭', '⟬fr_tax_number#8⟭', '⟬fr_postal_address#8⟭', 'Agent de maîtrise', '⟬iban#8⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (49, '⟬person_name#9⟭', '⟬birth_date#9⟭', '⟬fr_social_security_number#9⟭', '⟬fr_tax_number#9⟭', '⟬fr_postal_address#9⟭', 'Rédacteur', '⟬iban#9⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (50, '⟬person_name#10⟭', '⟬birth_date#10⟭', '⟬fr_social_security_number#10⟭', '⟬fr_tax_number#10⟭', '⟬fr_postal_address#10⟭', 'Attaché', '⟬iban#10⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (51, '⟬person_name#11⟭', '⟬birth_date#11⟭', '⟬fr_social_security_number#11⟭', '⟬fr_tax_number#11⟭', '⟬fr_postal_address#11⟭', 'Attaché', '⟬iban#11⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (52, '⟬person_name#12⟭', '⟬birth_date#12⟭', '⟬fr_social_security_number#12⟭', '⟬fr_tax_number#12⟭', '⟬fr_postal_address#12⟭', 'Rédacteur', '⟬iban#12⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (53, '⟬person_name#13⟭', '⟬birth_date#13⟭', '⟬fr_social_security_number#13⟭', '⟬fr_tax_number#13⟭', '⟬fr_postal_address#13⟭', 'Agent de maîtrise', '⟬iban#13⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (54, '⟬person_name#14⟭', '⟬birth_date#14⟭', '⟬fr_social_security_number#14⟭', '⟬fr_tax_number#14⟭', '⟬fr_postal_address#14⟭', 'Adjoint administratif', '⟬iban#14⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (55, '⟬person_name#15⟭', '⟬birth_date#15⟭', '⟬fr_social_security_number#15⟭', '⟬fr_tax_number#15⟭', '⟬fr_postal_address#15⟭', 'Rédacteur', '⟬iban#15⟭');
INSERT INTO "AGENT" ("ID", "NOM_PRENOM", "DATE_NAISSANCE", "NIR", "NUM_FISCAL", "ADRESSE", "GRADE", "IBAN") VALUES (56, '⟬person_name#16⟭', '⟬birth_date#16⟭', '⟬fr_social_security_number#16⟭', '⟬fr_tax_number#16⟭', '⟬fr_postal_address#16⟭', 'Attaché', '⟬iban#16⟭');

INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (56, 10, '⟬date#8⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (46, 5, '⟬date#3⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (41, 11, '⟬date#1⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (41, 10, '⟬date#4⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (56, 1, '⟬date#7⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (48, 8, '⟬date#6⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (49, 9, '⟬date#8⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (42, 7, '⟬date#7⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (53, 11, '⟬date#3⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (41, 8, '⟬date#7⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (43, 1, '⟬date#4⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (55, 8, '⟬date#9⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (49, 4, '⟬date#6⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (49, 9, '⟬date#9⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (44, 10, '⟬date#3⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (54, 9, '⟬date#9⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (42, 6, '⟬date#8⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (43, 8, '⟬date#8⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (47, 2, '⟬date#9⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (45, 11, '⟬date#2⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (47, 9, '⟬date#5⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (49, 11, '⟬date#3⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (46, 5, '⟬date#4⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (44, 2, '⟬date#2⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (47, 6, '⟬date#7⟭');
INSERT INTO "CARRIERE" ("AGENT_ID", "ECHELON", "EFFET") VALUES (53, 10, '⟬date#3⟭');

COMMIT WORK;
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: HR
appearance: pasted cells, salary advances, bank account
scenario: salary advances pasted by the accounting assistant into a message to the bank
⟬text⟭
Acomptes du 15
Salarié	Compte	Acompte
⟬person_name#1⟭	⟬bank_account_number#1⟭	400
⟬person_name#2⟭	⟬bank_account_number#2⟭	250
⟬person_name#3⟭	⟬bank_account_number#3⟭	600
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: education
appearance: Markdown tables, pupils with birth date, parents driving with licence and plate
scenario: preparation note for a primary school outing, with the pupils in one table and the volunteer parent drivers in another
⟬text⟭
# Sortie à la ferme

Départ de ⟬trap:eponym|l'école Jacques-Prévert⟭ à 8 h 30, retour pour la cantine.

## Enfants

| Élève | Date de naissance | Autorisation | Santé |
| --- | --- | --- | --- |
| ⟬person_name#1⟭ | ⟬birth_date#1⟭ | Oui | PAI allergie |
| ⟬person_name#2⟭ | ⟬birth_date#2⟭ | Oui | PAI allergie |
| ⟬person_name#3⟭ | ⟬birth_date#3⟭ | Oui | PAI allergie |
| ⟬person_name#4⟭ | ⟬birth_date#4⟭ | Oui | PAI allergie |
| ⟬person_name#5⟭ | ⟬birth_date#5⟭ | Oui | PAI allergie |
| ⟬person_name#6⟭ | ⟬birth_date#6⟭ | Oui | Aucun |
| ⟬person_name#7⟭ | ⟬birth_date#7⟭ | Non | Aucun |
| ⟬person_name#8⟭ | ⟬birth_date#8⟭ | Oui | PAI allergie |
| ⟬person_name#9⟭ | ⟬birth_date#9⟭ | Non | PAI asthme |
| ⟬person_name#10⟭ | ⟬birth_date#10⟭ | Oui | PAI allergie |
| ⟬person_name#11⟭ | ⟬birth_date#11⟭ | Oui | PAI asthme |
| ⟬person_name#12⟭ | ⟬birth_date#12⟭ | Non | PAI allergie |
| ⟬person_name#13⟭ | ⟬birth_date#13⟭ | Oui | Aucun |
| ⟬person_name#14⟭ | ⟬birth_date#14⟭ | Non | PAI asthme |

## Parents conducteurs

Les responsables de chaque voiture ont fourni une copie du permis.

| Parent | Portable | Permis | Plaque | Places |
| --- | --- | --- | --- | ---: |
| ⟬person_name#30⟭ | ⟬phone#30⟭ | ⟬fr_driving_licence#30⟭ | ⟬fr_license_plate#30⟭ | 4 |
| ⟬person_name#31⟭ | ⟬phone#31⟭ | ⟬fr_driving_licence#31⟭ | ⟬fr_license_plate#31⟭ | 2 |
| ⟬person_name#32⟭ | ⟬phone#32⟭ | ⟬fr_driving_licence#32⟭ | ⟬fr_license_plate#32⟭ | 3 |
| ⟬person_name#33⟭ | ⟬phone#33⟭ | ⟬fr_driving_licence#33⟭ | ⟬fr_license_plate#33⟭ | 4 |
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: fixed columns, insurance return file, NIR, IBAN and SIREN of the practice
scenario: payment return from the health insurance fund, reformatted as text by a practice's billing software
⟬text⟭
RETOUR ORGANISME - PAIEMENTS DU ⟬date#1⟭
PRATICIEN ⟬company#30⟭   SIREN ⟬fr_siren#30⟭
COMPTE CREDITE ⟬iban#30⟭

CODE     MONTANT   NIR                    ASSURE
-------  --------  ---------------------  ------------------------
NOE895    352,91  ⟬fr_social_security_number#1⟭  ⟬person_name#1⟭
NOE173    416,60  ⟬fr_social_security_number#2⟭  ⟬person_name#2⟭
NOE611     70,76  ⟬fr_social_security_number#3⟭  ⟬person_name#3⟭
NOE574    434,48  ⟬fr_social_security_number#4⟭  ⟬person_name#4⟭
NOE152    366,13  ⟬fr_social_security_number#5⟭  ⟬person_name#5⟭
NOE865    428,78  ⟬fr_social_security_number#6⟭  ⟬person_name#6⟭
NOE341    326,24  ⟬fr_social_security_number#7⟭  ⟬person_name#7⟭
NOE319    436,14  ⟬fr_social_security_number#8⟭  ⟬person_name#8⟭
NOE498    287,61  ⟬fr_social_security_number#9⟭  ⟬person_name#9⟭
NOE196    438,01  ⟬fr_social_security_number#10⟭  ⟬person_name#10⟭
NOE959    200,90  ⟬fr_social_security_number#11⟭  ⟬person_name#11⟭
NOE898    128,39  ⟬fr_social_security_number#12⟭  ⟬person_name#12⟭
NOE847    457,23  ⟬fr_social_security_number#13⟭  ⟬person_name#13⟭
NOE994    130,91  ⟬fr_social_security_number#14⟭  ⟬person_name#14⟭
NOE386    370,68  ⟬fr_social_security_number#15⟭  ⟬person_name#15⟭
NOE153    203,53  ⟬fr_social_security_number#16⟭  ⟬person_name#16⟭
NOE992    415,33  ⟬fr_social_security_number#17⟭  ⟬person_name#17⟭
NOE607    201,84  ⟬fr_social_security_number#18⟭  ⟬person_name#18⟭
NOE473    160,38  ⟬fr_social_security_number#19⟭  ⟬person_name#19⟭
-------  --------  ---------------------  ------------------------
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: associations
appearance: quoted comma CSV, solidarity trip, passport, IBAN, decimal comma inside quotes
scenario: participants of a solidarity trip, exported by a youth exchange association for its insurer
⟬text⟭
"participant","passeport","iban_remboursement","pays","acompte","assurance_annulation"
"⟬person_name#1⟭","⟬fr_passport#1⟭","⟬iban#1⟭","Maroc","834,69","Non"
"⟬person_name#2⟭","⟬fr_passport#2⟭","⟬iban#2⟭","Maroc","486,75","Oui"
"⟬person_name#3⟭","⟬fr_passport#3⟭","⟬iban#3⟭","Maroc","1418,30","Oui"
"⟬person_name#4⟭","⟬fr_passport#4⟭","⟬iban#4⟭","Maroc","431,04","Non"
"⟬person_name#5⟭","⟬fr_passport#5⟭","⟬iban#5⟭","Maroc","1306,16","Oui"
"⟬person_name#6⟭","⟬fr_passport#6⟭","⟬iban#6⟭","Vietnam","349,87","Oui"
"⟬person_name#7⟭","⟬fr_passport#7⟭","⟬iban#7⟭","Maroc","872,89","Oui"
"⟬person_name#8⟭","⟬fr_passport#8⟭","⟬iban#8⟭","Sénégal","1168,97","Non"
"⟬person_name#9⟭","⟬fr_passport#9⟭","⟬iban#9⟭","Maroc","1072,07","Oui"
"⟬person_name#10⟭","⟬fr_passport#10⟭","⟬iban#10⟭","Maroc","1066,09","Oui"
"⟬person_name#11⟭","⟬fr_passport#11⟭","⟬iban#11⟭","Maroc","781,12","Oui"
"⟬person_name#12⟭","⟬fr_passport#12⟭","⟬iban#12⟭","Sénégal","790,21","Non"
"⟬person_name#13⟭","⟬fr_passport#13⟭","⟬iban#13⟭","Maroc","471,14","Non"
"⟬person_name#14⟭","⟬fr_passport#14⟭","⟬iban#14⟭","Sénégal","518,72","Non"
"⟬person_name#15⟭","⟬fr_passport#15⟭","⟬iban#15⟭","Sénégal","330,26","Oui"
"⟬person_name#16⟭","⟬fr_passport#16⟭","⟬iban#16⟭","Vietnam","329,43","Oui"
"⟬person_name#17⟭","⟬fr_passport#17⟭","⟬iban#17⟭","Sénégal","610,12","Non"
"⟬person_name#18⟭","⟬fr_passport#18⟭","⟬iban#18⟭","Vietnam","1176,42","Non"
"⟬person_name#19⟭","⟬fr_passport#19⟭","⟬iban#19⟭","Maroc","401,17","Oui"
"⟬person_name#20⟭","⟬fr_passport#20⟭","⟬iban#20⟭","Sénégal","1303,76","Non"
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: public administration
appearance: TSV cell, file number, identity card, tax number, address cell, household size
scenario: energy cheque requests handled by a county's social services, exported for the state audit
⟬text⟭
dossier	demandeur	piece	fiscal	adresse	nb_parts	revenu	statut	traite_le	courriel
⟬customer_id#1⟭	⟬person_name#1⟭	⟬fr_identity_card#1⟭	⟬fr_tax_number#1⟭	⟬fr_postal_address#1⟭	4	6 996	Accordée	⟬date#2⟭	⟬email#1⟭
⟬customer_id#2⟭	⟬person_name#2⟭	⟬fr_identity_card#2⟭	⟬fr_tax_number#2⟭	⟬fr_postal_address#2⟭	3	32 752	Accordée	⟬date#2⟭	⟬email#2⟭
⟬customer_id#3⟭	⟬person_name#3⟭	⟬fr_identity_card#3⟭	⟬fr_tax_number#3⟭	⟬fr_postal_address#3⟭	2	4 142	Accordée	⟬date#3⟭	⟬email#3⟭
⟬customer_id#4⟭	⟬person_name#4⟭	⟬fr_identity_card#4⟭	⟬fr_tax_number#4⟭	⟬fr_postal_address#4⟭	1	33 535	Accordée	⟬date#8⟭	⟬email#4⟭
⟬customer_id#5⟭	⟬person_name#5⟭	⟬fr_identity_card#5⟭	⟬fr_tax_number#5⟭	⟬fr_postal_address#5⟭	3	1 388	En cours	⟬date#1⟭	⟬email#5⟭
⟬customer_id#6⟭	⟬person_name#6⟭	⟬fr_identity_card#6⟭	⟬fr_tax_number#6⟭	⟬fr_postal_address#6⟭	3	31 342	Rejetée	⟬date#7⟭	⟬email#6⟭
⟬customer_id#7⟭	⟬person_name#7⟭	⟬fr_identity_card#7⟭	⟬fr_tax_number#7⟭	⟬fr_postal_address#7⟭	6	18 200	En cours	⟬date#7⟭	⟬email#7⟭
⟬customer_id#8⟭	⟬person_name#8⟭	⟬fr_identity_card#8⟭	⟬fr_tax_number#8⟭	⟬fr_postal_address#8⟭	1	12 441	Rejetée	⟬date#1⟭	⟬email#8⟭
⟬customer_id#9⟭	⟬person_name#9⟭	⟬fr_identity_card#9⟭	⟬fr_tax_number#9⟭	⟬fr_postal_address#9⟭	1	31 643	En cours	⟬date#6⟭	⟬email#9⟭
⟬customer_id#10⟭	⟬person_name#10⟭	⟬fr_identity_card#10⟭	⟬fr_tax_number#10⟭	⟬fr_postal_address#10⟭	3	20 605	Rejetée	⟬date#7⟭	⟬email#10⟭
⟬customer_id#11⟭	⟬person_name#11⟭	⟬fr_identity_card#11⟭	⟬fr_tax_number#11⟭	⟬fr_postal_address#11⟭	4	21 652	En cours	⟬date#3⟭	⟬email#11⟭
⟬customer_id#12⟭	⟬person_name#12⟭	⟬fr_identity_card#12⟭	⟬fr_tax_number#12⟭	⟬fr_postal_address#12⟭	1	15 910	Accordée	⟬date#4⟭	⟬email#12⟭
⟬customer_id#13⟭	⟬person_name#13⟭	⟬fr_identity_card#13⟭	⟬fr_tax_number#13⟭	⟬fr_postal_address#13⟭	6	25 627	Rejetée	⟬date#8⟭	⟬email#13⟭
⟬customer_id#14⟭	⟬person_name#14⟭	⟬fr_identity_card#14⟭	⟬fr_tax_number#14⟭	⟬fr_postal_address#14⟭	5	32 580	Rejetée	⟬date#3⟭	⟬email#14⟭
⟬customer_id#15⟭	⟬person_name#15⟭	⟬fr_identity_card#15⟭	⟬fr_tax_number#15⟭	⟬fr_postal_address#15⟭	3	3 488	En cours	⟬date#1⟭	⟬email#15⟭
⟬customer_id#16⟭	⟬person_name#16⟭	⟬fr_identity_card#16⟭	⟬fr_tax_number#16⟭	⟬fr_postal_address#16⟭	6	1 493	Accordée	⟬date#5⟭	⟬email#16⟭
⟬customer_id#17⟭	⟬person_name#17⟭	⟬fr_identity_card#17⟭	⟬fr_tax_number#17⟭	⟬fr_postal_address#17⟭	4	24 608	Rejetée	⟬date#6⟭	⟬email#17⟭
⟬customer_id#18⟭	⟬person_name#18⟭	⟬fr_identity_card#18⟭	⟬fr_tax_number#18⟭	⟬fr_postal_address#18⟭	3	15 344	Rejetée	⟬date#3⟭	⟬email#18⟭
⟬customer_id#19⟭	⟬person_name#19⟭	⟬fr_identity_card#19⟭	⟬fr_tax_number#19⟭	⟬fr_postal_address#19⟭	1	25 869	Accordée	⟬date#7⟭	⟬email#19⟭
⟬customer_id#20⟭	⟬person_name#20⟭	⟬fr_identity_card#20⟭	⟬fr_tax_number#20⟭	⟬fr_postal_address#20⟭	5	18 106	En cours	⟬date#7⟭	⟬email#20⟭
⟬customer_id#21⟭	⟬person_name#21⟭	⟬fr_identity_card#21⟭	⟬fr_tax_number#21⟭	⟬fr_postal_address#21⟭	6	24 358	Rejetée	⟬date#5⟭	⟬email#21⟭
⟬customer_id#22⟭	⟬person_name#22⟭	⟬fr_identity_card#22⟭	⟬fr_tax_number#22⟭	⟬fr_postal_address#22⟭	6	5 704	Rejetée	⟬date#7⟭	⟬email#22⟭
⟬customer_id#23⟭	⟬person_name#23⟭	⟬fr_identity_card#23⟭	⟬fr_tax_number#23⟭	⟬fr_postal_address#23⟭	4	26 456	Accordée	⟬date#7⟭	⟬email#23⟭
⟬customer_id#24⟭	⟬person_name#24⟭	⟬fr_identity_card#24⟭	⟬fr_tax_number#24⟭	⟬fr_postal_address#24⟭	4	29 434	Accordée	⟬date#7⟭	⟬email#24⟭
⟬customer_id#25⟭	⟬person_name#25⟭	⟬fr_identity_card#25⟭	⟬fr_tax_number#25⟭	⟬fr_postal_address#25⟭	2	29 358	Accordée	⟬date#2⟭	⟬email#25⟭
⟬customer_id#26⟭	⟬person_name#26⟭	⟬fr_identity_card#26⟭	⟬fr_tax_number#26⟭	⟬fr_postal_address#26⟭	2	19 181	Accordée	⟬date#8⟭	⟬email#26⟭
⟬customer_id#27⟭	⟬person_name#27⟭	⟬fr_identity_card#27⟭	⟬fr_tax_number#27⟭	⟬fr_postal_address#27⟭	2	7 809	Accordée	⟬date#4⟭	⟬email#27⟭
⟬customer_id#28⟭	⟬person_name#28⟭	⟬fr_identity_card#28⟭	⟬fr_tax_number#28⟭	⟬fr_postal_address#28⟭	1	10 844	En cours	⟬date#1⟭	⟬email#28⟭
⟬customer_id#29⟭	⟬person_name#29⟭	⟬fr_identity_card#29⟭	⟬fr_tax_number#29⟭	⟬fr_postal_address#29⟭	2	20 478	Accordée	⟬date#6⟭	⟬email#29⟭
⟬customer_id#30⟭	⟬person_name#30⟭	⟬fr_identity_card#30⟭	⟬fr_tax_number#30⟭	⟬fr_postal_address#30⟭	3	23 792	Accordée	⟬date#1⟭	⟬email#30⟭
⟬customer_id#31⟭	⟬person_name#31⟭	⟬fr_identity_card#31⟭	⟬fr_tax_number#31⟭	⟬fr_postal_address#31⟭	1	19 374	Accordée	⟬date#5⟭	⟬email#31⟭
⟬customer_id#32⟭	⟬person_name#32⟭	⟬fr_identity_card#32⟭	⟬fr_tax_number#32⟭	⟬fr_postal_address#32⟭	6	20 276	En cours	⟬date#8⟭	⟬email#32⟭
⟬customer_id#33⟭	⟬person_name#33⟭	⟬fr_identity_card#33⟭	⟬fr_tax_number#33⟭	⟬fr_postal_address#33⟭	2	24 534	Accordée	⟬date#3⟭	⟬email#33⟭
⟬customer_id#34⟭	⟬person_name#34⟭	⟬fr_identity_card#34⟭	⟬fr_tax_number#34⟭	⟬fr_postal_address#34⟭	2	21 725	Accordée	⟬date#4⟭	⟬email#34⟭
⟬customer_id#35⟭	⟬person_name#35⟭	⟬fr_identity_card#35⟭	⟬fr_tax_number#35⟭	⟬fr_postal_address#35⟭	4	15 877	En cours	⟬date#2⟭	⟬email#35⟭
⟬customer_id#36⟭	⟬person_name#36⟭	⟬fr_identity_card#36⟭	⟬fr_tax_number#36⟭	⟬fr_postal_address#36⟭	3	14 694	Rejetée	⟬date#4⟭	⟬email#36⟭
⟬customer_id#37⟭	⟬person_name#37⟭	⟬fr_identity_card#37⟭	⟬fr_tax_number#37⟭	⟬fr_postal_address#37⟭	3	15 914	Rejetée	⟬date#8⟭	⟬email#37⟭
⟬customer_id#38⟭	⟬person_name#38⟭	⟬fr_identity_card#38⟭	⟬fr_tax_number#38⟭	⟬fr_postal_address#38⟭	2	34 322	Accordée	⟬date#2⟭	⟬email#38⟭
⟬customer_id#39⟭	⟬person_name#39⟭	⟬fr_identity_card#39⟭	⟬fr_tax_number#39⟭	⟬fr_postal_address#39⟭	3	29 415	Accordée	⟬date#3⟭	⟬email#39⟭
⟬customer_id#40⟭	⟬person_name#40⟭	⟬fr_identity_card#40⟭	⟬fr_tax_number#40⟭	⟬fr_postal_address#40⟭	4	12 535	Accordée	⟬date#8⟭	⟬email#40⟭
⟬customer_id#41⟭	⟬person_name#41⟭	⟬fr_identity_card#41⟭	⟬fr_tax_number#41⟭	⟬fr_postal_address#41⟭	3	2 402	Rejetée	⟬date#5⟭	⟬email#41⟭
⟬customer_id#42⟭	⟬person_name#42⟭	⟬fr_identity_card#42⟭	⟬fr_tax_number#42⟭	⟬fr_postal_address#42⟭	6	26 258	Accordée	⟬date#4⟭	⟬email#42⟭
⟬customer_id#43⟭	⟬person_name#43⟭	⟬fr_identity_card#43⟭	⟬fr_tax_number#43⟭	⟬fr_postal_address#43⟭	3	20 102	Rejetée	⟬date#2⟭	⟬email#43⟭
⟬customer_id#44⟭	⟬person_name#44⟭	⟬fr_identity_card#44⟭	⟬fr_tax_number#44⟭	⟬fr_postal_address#44⟭	2	28 789	Accordée	⟬date#7⟭	⟬email#44⟭
⟬customer_id#45⟭	⟬person_name#45⟭	⟬fr_identity_card#45⟭	⟬fr_tax_number#45⟭	⟬fr_postal_address#45⟭	6	13 226	En cours	⟬date#1⟭	⟬email#45⟭
⟬customer_id#46⟭	⟬person_name#46⟭	⟬fr_identity_card#46⟭	⟬fr_tax_number#46⟭	⟬fr_postal_address#46⟭	6	8 436	Accordée	⟬date#6⟭	⟬email#46⟭
⟬customer_id#47⟭	⟬person_name#47⟭	⟬fr_identity_card#47⟭	⟬fr_tax_number#47⟭	⟬fr_postal_address#47⟭	4	10 615	Accordée	⟬date#2⟭	⟬email#47⟭
⟬customer_id#48⟭	⟬person_name#48⟭	⟬fr_identity_card#48⟭	⟬fr_tax_number#48⟭	⟬fr_postal_address#48⟭	3	17 192	Accordée	⟬date#4⟭	⟬email#48⟭
⟬customer_id#49⟭	⟬person_name#49⟭	⟬fr_identity_card#49⟭	⟬fr_tax_number#49⟭	⟬fr_postal_address#49⟭	2	32 788	En cours	⟬date#1⟭	⟬email#49⟭
⟬customer_id#50⟭	⟬person_name#50⟭	⟬fr_identity_card#50⟭	⟬fr_tax_number#50⟭	⟬fr_postal_address#50⟭	2	17 150	En cours	⟬date#2⟭	⟬email#50⟭
⟬customer_id#51⟭	⟬person_name#51⟭	⟬fr_identity_card#51⟭	⟬fr_tax_number#51⟭	⟬fr_postal_address#51⟭	2	27 165	Rejetée	⟬date#1⟭	⟬email#51⟭
⟬customer_id#52⟭	⟬person_name#52⟭	⟬fr_identity_card#52⟭	⟬fr_tax_number#52⟭	⟬fr_postal_address#52⟭	3	24 299	Rejetée	⟬date#6⟭	⟬email#52⟭
⟬customer_id#53⟭	⟬person_name#53⟭	⟬fr_identity_card#53⟭	⟬fr_tax_number#53⟭	⟬fr_postal_address#53⟭	1	28 973	Rejetée	⟬date#5⟭	⟬email#53⟭
⟬customer_id#54⟭	⟬person_name#54⟭	⟬fr_identity_card#54⟭	⟬fr_tax_number#54⟭	⟬fr_postal_address#54⟭	6	19 900	Rejetée	⟬date#8⟭	⟬email#54⟭
⟬customer_id#55⟭	⟬person_name#55⟭	⟬fr_identity_card#55⟭	⟬fr_tax_number#55⟭	⟬fr_postal_address#55⟭	2	16 809	En cours	⟬date#8⟭	⟬email#55⟭
⟬customer_id#56⟭	⟬person_name#56⟭	⟬fr_identity_card#56⟭	⟬fr_tax_number#56⟭	⟬fr_postal_address#56⟭	5	6 538	Accordée	⟬date#6⟭	⟬email#56⟭
⟬customer_id#57⟭	⟬person_name#57⟭	⟬fr_identity_card#57⟭	⟬fr_tax_number#57⟭	⟬fr_postal_address#57⟭	3	21 695	En cours	⟬date#7⟭	⟬email#57⟭
⟬customer_id#58⟭	⟬person_name#58⟭	⟬fr_identity_card#58⟭	⟬fr_tax_number#58⟭	⟬fr_postal_address#58⟭	1	4 971	En cours	⟬date#8⟭	⟬email#58⟭
⟬customer_id#59⟭	⟬person_name#59⟭	⟬fr_identity_card#59⟭	⟬fr_tax_number#59⟭	⟬fr_postal_address#59⟭	5	11 957	Rejetée	⟬date#6⟭	⟬email#59⟭
⟬customer_id#60⟭	⟬person_name#60⟭	⟬fr_identity_card#60⟭	⟬fr_tax_number#60⟭	⟬fr_postal_address#60⟭	5	9 398	Accordée	⟬date#4⟭	⟬email#60⟭
⟬customer_id#61⟭	⟬person_name#61⟭	⟬fr_identity_card#61⟭	⟬fr_tax_number#61⟭	⟬fr_postal_address#61⟭	6	25 565	En cours	⟬date#1⟭	⟬email#61⟭
⟬customer_id#62⟭	⟬person_name#62⟭	⟬fr_identity_card#62⟭	⟬fr_tax_number#62⟭	⟬fr_postal_address#62⟭	1	18 918	Accordée	⟬date#5⟭	⟬email#62⟭
⟬customer_id#63⟭	⟬person_name#63⟭	⟬fr_identity_card#63⟭	⟬fr_tax_number#63⟭	⟬fr_postal_address#63⟭	1	15 173	En cours	⟬date#2⟭	⟬email#63⟭
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: HR
appearance: SQL Server script, INSERT with column list, passport, bank account, SIREN of the agency
scenario: temp worker missions exported from an on-site staffing tool by a data engineer
⟬text⟭
SET NOCOUNT ON;
IF OBJECT_ID('[interim].[Mission]') IS NOT NULL DROP TABLE [interim].[Mission];

CREATE TABLE [interim].[Mission] (
    [Id] INT NOT NULL,
    [Interimaire] NVARCHAR(160),
    [Passeport] NVARCHAR(12),
    [Compte] NVARCHAR(11),
    [Bic] NVARCHAR(11),
    [Agence] NVARCHAR(120),
    [AgenceSiren] NVARCHAR(11),
    [Debut] DATE
);

INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (1, N'⟬person_name#1⟭', N'⟬fr_passport#1⟭', N'⟬bank_account_number#1⟭', N'⟬bic#1⟭', N'⟬company#21⟭', N'⟬fr_siren#21⟭', N'⟬date#2⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (2, N'⟬person_name#2⟭', N'⟬fr_passport#2⟭', N'⟬bank_account_number#2⟭', N'⟬bic#2⟭', N'⟬company#23⟭', N'⟬fr_siren#23⟭', N'⟬date#2⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (3, N'⟬person_name#3⟭', N'⟬fr_passport#3⟭', N'⟬bank_account_number#3⟭', N'⟬bic#3⟭', N'⟬company#21⟭', N'⟬fr_siren#21⟭', N'⟬date#1⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (4, N'⟬person_name#4⟭', N'⟬fr_passport#4⟭', N'⟬bank_account_number#4⟭', N'⟬bic#4⟭', N'⟬company#23⟭', N'⟬fr_siren#23⟭', N'⟬date#4⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (5, N'⟬person_name#5⟭', N'⟬fr_passport#5⟭', N'⟬bank_account_number#5⟭', N'⟬bic#5⟭', N'⟬company#23⟭', N'⟬fr_siren#23⟭', N'⟬date#3⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (6, N'⟬person_name#6⟭', N'⟬fr_passport#6⟭', N'⟬bank_account_number#6⟭', N'⟬bic#6⟭', N'⟬company#23⟭', N'⟬fr_siren#23⟭', N'⟬date#1⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (7, N'⟬person_name#7⟭', N'⟬fr_passport#7⟭', N'⟬bank_account_number#7⟭', N'⟬bic#7⟭', N'⟬company#21⟭', N'⟬fr_siren#21⟭', N'⟬date#4⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (8, N'⟬person_name#8⟭', N'⟬fr_passport#8⟭', N'⟬bank_account_number#8⟭', N'⟬bic#8⟭', N'⟬company#22⟭', N'⟬fr_siren#22⟭', N'⟬date#2⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (9, N'⟬person_name#9⟭', N'⟬fr_passport#9⟭', N'⟬bank_account_number#9⟭', N'⟬bic#9⟭', N'⟬company#22⟭', N'⟬fr_siren#22⟭', N'⟬date#3⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (10, N'⟬person_name#10⟭', N'⟬fr_passport#10⟭', N'⟬bank_account_number#10⟭', N'⟬bic#10⟭', N'⟬company#21⟭', N'⟬fr_siren#21⟭', N'⟬date#6⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (11, N'⟬person_name#11⟭', N'⟬fr_passport#11⟭', N'⟬bank_account_number#11⟭', N'⟬bic#11⟭', N'⟬company#22⟭', N'⟬fr_siren#22⟭', N'⟬date#5⟭');
INSERT INTO [interim].[Mission] ([Id], [Interimaire], [Passeport], [Compte], [Bic], [Agence], [AgenceSiren], [Debut]) VALUES (12, N'⟬person_name#12⟭', N'⟬fr_passport#12⟭', N'⟬bank_account_number#12⟭', N'⟬bic#12⟭', N'⟬company#22⟭', N'⟬fr_siren#22⟭', N'⟬date#3⟭');
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: education
appearance: pasted cells, school hardship fund, guardians, tax number, IBAN
scenario: school hardship fund decisions pasted by a social worker into a report for the head of school, guardians only
⟬text⟭
Fonds social - commission du ⟬date#1⟭
Présidente :	⟬person_name#40f⟭

Famille	N° fiscal	IBAN	Aide	Objet	Décision
⟬person_name#1⟭	⟬fr_tax_number#1⟭	⟬iban#1⟭	138	Cantine	Refusé
⟬person_name#2⟭	⟬fr_tax_number#2⟭	⟬iban#2⟭	184	Internat	Refusé
⟬person_name#3⟭	⟬fr_tax_number#3⟭	⟬iban#3⟭	274	Internat	Ajourné
⟬person_name#4⟭	⟬fr_tax_number#4⟭	⟬iban#4⟭	148	Internat	Ajourné
⟬person_name#5⟭	⟬fr_tax_number#5⟭	⟬iban#5⟭	184	Internat	Ajourné
⟬person_name#6⟭	⟬fr_tax_number#6⟭	⟬iban#6⟭	159	Internat	Accordé
⟬person_name#7⟭	⟬fr_tax_number#7⟭	⟬iban#7⟭	103	Voyage	Ajourné
⟬person_name#8⟭	⟬fr_tax_number#8⟭	⟬iban#8⟭	269	Voyage	Refusé
⟬person_name#9⟭	⟬fr_tax_number#9⟭	⟬iban#9⟭	212	Voyage	Accordé
⟬person_name#10⟭	⟬fr_tax_number#10⟭	⟬iban#10⟭	140	Voyage	Ajourné
⟬person_name#11⟭	⟬fr_tax_number#11⟭	⟬iban#11⟭	271	Internat	Accordé
⟬person_name#12⟭	⟬fr_tax_number#12⟭	⟬iban#12⟭	139	Internat	Ajourné
⟬person_name#13⟭	⟬fr_tax_number#13⟭	⟬iban#13⟭	146	Fournitures	Refusé
⟬person_name#14⟭	⟬fr_tax_number#14⟭	⟬iban#14⟭	201	Cantine	Refusé
⟬person_name#15⟭	⟬fr_tax_number#15⟭	⟬iban#15⟭	214	Cantine	Refusé
⟬person_name#16⟭	⟬fr_tax_number#16⟭	⟬iban#16⟭	126	Cantine	Accordé

Versement sur le compte de la famille, sauf cantine
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: Markdown table, on-call pharmacies, address cell, phone
scenario: on-call pharmacies for the weekend, posted in a practice's shared notes
⟬text⟭
Pharmacies de garde :

| Pharmacie | Adresse | Téléphone |
| --- | --- | --- |
| ⟬company#1⟭ | ⟬fr_postal_address#1⟭ | ⟬phone#1⟭ |
| ⟬company#2⟭ | ⟬fr_postal_address#2⟭ | ⟬phone#2⟭ |
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: real estate
appearance: fixed columns, tax rates, owner label with no person
scenario: property tax rates per town printed by a notary's reference tool
⟬text⟭
TAUX DE TAXE FONCIERE
COMMUNE                 TAUX    EVOL
⟬city#1⟭          31,42   +0,8
⟬city#2⟭          28,17   +1,2
⟬city#3⟭          36,05    0,0
REDEVABLE : ⟬trap:indicator_non_pii|SANS OBJET⟭
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: public administration
appearance: semicolon CSV, streets without number named after people, contact and email headers with no person
scenario: open data file of a town's electric charging points, located by street with no house number
⟬text⟭
id_borne;emplacement;nb_points;puissance_kw;etat;contact;email
B6365;⟬trap:word_name|quai Louis-Blériot⟭;9;50;Travaux;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|non diffusé⟭
B2248;⟬trap:word_name|rue Jeanne-d'Arc⟭;10;7;Service;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|portail open data⟭
B4727;⟬trap:word_name|avenue Georges-Clemenceau⟭;6;50;Hors service;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|non diffusé⟭
B9859;⟬trap:word_name|parvis Simone-Veil⟭;6;22;Service;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|non diffusé⟭
B1202;⟬trap:word_name|place Charles-de-Gaulle⟭;2;22;Service;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|non diffusé⟭
B6024;⟬trap:word_name|boulevard Gambetta⟭;11;22;Travaux;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|portail open data⟭
B5217;⟬trap:word_name|parvis Simone-Veil⟭;9;50;Hors service;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|portail open data⟭
B7978;⟬trap:word_name|rue Jeanne-d'Arc⟭;9;7;Hors service;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|portail open data⟭
B5850;⟬trap:word_name|boulevard Gambetta⟭;3;22;Travaux;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|portail open data⟭
B9594;⟬trap:word_name|boulevard Gambetta⟭;8;22;Travaux;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|non diffusé⟭
B1144;⟬trap:word_name|rue Jeanne-d'Arc⟭;11;50;Service;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|portail open data⟭
B9146;⟬trap:word_name|place Charles-de-Gaulle⟭;7;7;Hors service;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|portail open data⟭
B2491;⟬trap:word_name|place Charles-de-Gaulle⟭;11;22;Service;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|portail open data⟭
B8298;⟬trap:word_name|rue Jeanne-d'Arc⟭;2;22;Service;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|non diffusé⟭
B8731;⟬trap:word_name|place Charles-de-Gaulle⟭;6;7;Travaux;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|portail open data⟭
B2862;⟬trap:word_name|quai Louis-Blériot⟭;11;7;Travaux;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|non diffusé⟭
B5192;⟬trap:word_name|boulevard Gambetta⟭;10;22;Hors service;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|portail open data⟭
B4590;⟬trap:word_name|rue Marie-Curie⟭;9;22;Hors service;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|non diffusé⟭
B3397;⟬trap:word_name|quai Louis-Blériot⟭;8;22;Travaux;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|non diffusé⟭
B3970;⟬trap:word_name|avenue Georges-Clemenceau⟭;12;50;Travaux;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|non diffusé⟭
B1980;⟬trap:word_name|avenue Georges-Clemenceau⟭;2;7;Travaux;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|non diffusé⟭
B2128;⟬trap:word_name|rue Marie-Curie⟭;9;22;Service;⟬trap:indicator_non_pii|Service voirie⟭;⟬trap:indicator_non_pii|portail open data⟭
B6120;⟬trap:word_name|boulevard Gambetta⟭;3;22;Service;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|non diffusé⟭
B2106;⟬trap:word_name|boulevard Gambetta⟭;3;22;Service;⟬trap:indicator_non_pii|Délégataire⟭;⟬trap:indicator_non_pii|portail open data⟭
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: fr
fill_locale: fr_FR
domain: HR
appearance: TSV cell, training catalogue, tools and methods named after people, trainer column with no person
scenario: training catalogue exported from an HR system, with no trainee or trainer
⟬text⟭
code	intitule	jours	places	cout	formateur	modalite
F5159	Initiation à ⟬trap:library|Django⟭	3	12	1030	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F7644	Initiation à ⟬trap:library|Django⟭	2	13	1445	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F3738	RGPD	4	14	1210	⟬trap:indicator_non_pii|Interne⟭	Distanciel
F3334	⟬trap:eponym|Diagramme de Gantt⟭	3	13	1886	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
F8425	Initiation à ⟬trap:library|Jenkins⟭	2	13	1536	⟬trap:indicator_non_pii|Interne⟭	Distanciel
F5305	Initiation à ⟬trap:library|Hugo⟭	3	13	886	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F3538	Initiation à ⟬trap:library|Jackson⟭	1	6	1715	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F4014	Initiation à ⟬trap:library|Hugo⟭	1	5	741	⟬trap:indicator_non_pii|Interne⟭	Distanciel
F9708	RGPD	4	9	1341	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F9140	⟬trap:eponym|Diagramme d'Ishikawa⟭	3	13	1076	⟬trap:indicator_non_pii|Organisme externe⟭	Présentiel
F2810	Initiation à ⟬trap:library|Hugo⟭	4	7	1932	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F5882	Initiation à ⟬trap:library|Hugo⟭	4	9	737	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
F6444	⟬trap:eponym|Pyramide de Maslow⟭	5	8	2311	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
F2600	Excel avancé	3	13	1621	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
F8359	Management de proximité	2	4	803	⟬trap:indicator_non_pii|Organisme externe⟭	Présentiel
F6714	Anglais professionnel	2	6	1900	⟬trap:indicator_non_pii|Organisme externe⟭	Présentiel
F7344	Initiation à ⟬trap:library|Hugo⟭	1	6	1849	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F6186	Excel avancé	5	7	1523	⟬trap:indicator_non_pii|Organisme externe⟭	Présentiel
F9234	Initiation à ⟬trap:library|Django⟭	1	5	444	⟬trap:indicator_non_pii|Organisme externe⟭	Distanciel
F9638	⟬trap:eponym|Échelle de Likert⟭	2	5	2197	⟬trap:indicator_non_pii|Organisme externe⟭	Distanciel
F8560	⟬trap:eponym|Loi de Pareto⟭	2	6	1726	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F7165	Initiation à ⟬trap:library|Django⟭	1	4	1020	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F5075	⟬trap:eponym|Courbe de Gauss⟭	3	8	420	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F8738	Initiation à ⟬trap:library|Jenkins⟭	5	12	1944	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F8021	⟬trap:eponym|Échelle de Likert⟭	4	9	436	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
F6900	Initiation à ⟬trap:library|Jackson⟭	2	12	1737	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F6648	Sécurité incendie	2	11	2251	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F9236	Initiation à ⟬trap:library|Jackson⟭	4	8	402	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F7124	Initiation à ⟬trap:library|Hugo⟭	1	9	1458	⟬trap:indicator_non_pii|Organisme externe⟭	Présentiel
F5052	Gestes et postures	2	8	350	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
F6017	RGPD	2	13	2042	⟬trap:indicator_non_pii|Interne⟭	Distanciel
F5034	Prise de parole	3	12	1431	⟬trap:indicator_non_pii|Organisme externe⟭	Présentiel
F3379	Initiation à ⟬trap:library|Jenkins⟭	4	13	774	⟬trap:indicator_non_pii|Organisme externe⟭	Distanciel
F7237	⟬trap:eponym|Pyramide de Maslow⟭	1	12	848	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F2960	⟬trap:eponym|Diagramme de Gantt⟭	1	4	1675	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F9771	⟬trap:eponym|Échelle de Likert⟭	4	10	588	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F6120	Initiation à ⟬trap:library|Jenkins⟭	4	4	1599	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
F2060	Initiation à ⟬trap:library|Jenkins⟭	2	6	2163	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
F2002	⟬trap:eponym|Diagramme d'Ishikawa⟭	1	9	1491	⟬trap:indicator_non_pii|Interne⟭	Distanciel
F1615	⟬trap:eponym|Loi de Pareto⟭	5	12	2372	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F2847	⟬trap:eponym|Diagramme de Gantt⟭	2	7	442	⟬trap:indicator_non_pii|Interne⟭	Distanciel
F4228	Excel avancé	1	14	1732	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F3184	Initiation à ⟬trap:library|Hugo⟭	1	8	1123	⟬trap:indicator_non_pii|Interne⟭	Distanciel
F4824	⟬trap:eponym|Loi de Pareto⟭	2	5	1419	⟬trap:indicator_non_pii|Organisme externe⟭	Présentiel
F9995	Initiation à ⟬trap:library|Hugo⟭	4	5	946	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
F4120	⟬trap:eponym|Matrice d'Eisenhower⟭	3	8	2011	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F2534	Initiation à ⟬trap:library|Hugo⟭	3	14	840	⟬trap:indicator_non_pii|Organisme externe⟭	Distanciel
F1568	Excel avancé	3	13	2094	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
F1440	RGPD	2	9	2142	⟬trap:indicator_non_pii|Organisme externe⟭	Distanciel
F4416	Initiation à ⟬trap:library|Jackson⟭	4	9	1409	⟬trap:indicator_non_pii|Interne⟭	Distanciel
F2259	Initiation à ⟬trap:library|Jenkins⟭	3	4	1477	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F2581	Initiation à ⟬trap:library|Jenkins⟭	3	5	981	⟬trap:indicator_non_pii|À désigner⟭	Présentiel
F4099	⟬trap:eponym|Diagramme d'Ishikawa⟭	3	10	1150	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F7787	Gestes et postures	4	13	445	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F2016	⟬trap:eponym|Diagramme de Gantt⟭	2	8	1660	⟬trap:indicator_non_pii|Interne⟭	Distanciel
F8059	⟬trap:eponym|Diagramme de Gantt⟭	1	5	1456	⟬trap:indicator_non_pii|Organisme externe⟭	Présentiel
F2559	⟬trap:eponym|Échelle de Likert⟭	3	14	695	⟬trap:indicator_non_pii|Organisme externe⟭	Distanciel
F3709	Prise de parole	1	12	2147	⟬trap:indicator_non_pii|Organisme externe⟭	Présentiel
F3297	Initiation à ⟬trap:library|Jenkins⟭	1	13	2396	⟬trap:indicator_non_pii|Organisme externe⟭	Distanciel
F8284	Gestes et postures	1	9	1686	⟬trap:indicator_non_pii|Interne⟭	Présentiel
F2124	Initiation à ⟬trap:library|Django⟭	5	7	2389	⟬trap:indicator_non_pii|Interne⟭	Distanciel
F2792	Initiation à ⟬trap:library|Django⟭	2	12	1002	⟬trap:indicator_non_pii|À désigner⟭	Distanciel
⟬end⟭

⟬template⟭
family: tabular
format: SQL dump (.sql)
language: fr
fill_locale: fr_FR
domain: education
appearance: reference table, role with a default password placeholder, owner with no person
scenario: reference script for diplomas in a school management tool, with a default password left as a placeholder
⟬text⟭
-- Référentiel des diplômes
CREATE ROLE referentiel LOGIN PASSWORD '⟬trap:placeholder|changeme⟭';

CREATE TABLE diplome (
    code varchar(5) PRIMARY KEY,
    libelle text,
    niveau smallint
);

INSERT INTO diplome (code, libelle, niveau) VALUES ('D453', 'Bac pro Commerce', 3);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D392', 'Licence pro Commerce', 6);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D507', 'BUT Commerce', 5);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D958', 'Bac pro Comptabilité', 4);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D905', 'BUT Électricité', 3);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D797', 'Licence pro Comptabilité', 5);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D339', 'Licence pro Comptabilité', 5);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D678', 'Bac pro Cuisine', 5);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D497', 'Licence pro Électricité', 4);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D271', 'Licence pro Commerce', 5);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D917', 'BUT Cuisine', 6);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D879', 'CAP Commerce', 5);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D458', 'BEP Cuisine', 4);
INSERT INTO diplome (code, libelle, niveau) VALUES ('D833', 'CAP Comptabilité', 4);

ALTER TABLE diplome OWNER TO ⟬trap:indicator_non_pii|referentiel⟭;
⟬end⟭

⟬template⟭
family: tabular
format: spreadsheet as text
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: pasted cells, clinical scores named after people
scenario: clinical scales used by a nursing team, pasted from a quality spreadsheet
⟬text⟭
Échelle	Usage	Fréquence
⟬trap:eponym|Score de Ramsay⟭	Sédation	À chaque poste
⟬trap:eponym|Échelle de Norton⟭	Risque d'escarre	Hebdomadaire
⟬trap:eponym|Indice de Barthel⟭	Autonomie	Mensuelle
⟬end⟭

⟬template⟭
family: tabular
format: Markdown table
language: fr
fill_locale: fr_FR
domain: real estate
appearance: Markdown table, general meeting, co-owners, address cell, bank account
scenario: attendance sheet of a co-owners' general meeting, typed into a note by the building manager's assistant
⟬text⟭
# Assemblée générale : émargement

Convocation du ⟬date#2⟭, séance du ⟬date#1⟭. Syndic : ⟬company#40⟭.

| Copropriétaire | Lot | Adresse | Compte | Statut | Mail |
| --- | --- | --- | --- | --- | --- |
| ⟬person_name#1⟭ | B13 | ⟬fr_postal_address#1⟭ | ⟬bank_account_number#1⟭ | Présent | ⟬email#1⟭ |
| ⟬person_name#2⟭ | A26 | ⟬fr_postal_address#2⟭ | ⟬bank_account_number#2⟭ | Présent | ⟬email#2⟭ |
| ⟬person_name#3⟭ | A53 | ⟬fr_postal_address#3⟭ | ⟬bank_account_number#3⟭ | Présent | ⟬email#3⟭ |
| ⟬person_name#4⟭ | A60 | ⟬fr_postal_address#4⟭ | ⟬bank_account_number#4⟭ | Présent | ⟬email#4⟭ |
| ⟬person_name#5⟭ | B4 | ⟬fr_postal_address#5⟭ | ⟬bank_account_number#5⟭ | Pouvoir | ⟬email#5⟭ |
| ⟬person_name#6⟭ | A59 | ⟬fr_postal_address#6⟭ | ⟬bank_account_number#6⟭ | Présent | ⟬email#6⟭ |
| ⟬person_name#7⟭ | A11 | ⟬fr_postal_address#7⟭ | ⟬bank_account_number#7⟭ | Absent | ⟬email#7⟭ |
| ⟬person_name#8⟭ | B39 | ⟬fr_postal_address#8⟭ | ⟬bank_account_number#8⟭ | Pouvoir | ⟬email#8⟭ |
| ⟬person_name#9⟭ | B30 | ⟬fr_postal_address#9⟭ | ⟬bank_account_number#9⟭ | Présent | ⟬email#9⟭ |
| ⟬person_name#10⟭ | A53 | ⟬fr_postal_address#10⟭ | ⟬bank_account_number#10⟭ | Présent | ⟬email#10⟭ |
| ⟬person_name#11⟭ | A27 | ⟬fr_postal_address#11⟭ | ⟬bank_account_number#11⟭ | Pouvoir | ⟬email#11⟭ |
| ⟬person_name#12⟭ | A29 | ⟬fr_postal_address#12⟭ | ⟬bank_account_number#12⟭ | Absent | ⟬email#12⟭ |

Quorum à recalculer avec les tantièmes.
⟬end⟭

⟬template⟭
family: tabular
format: fixed-width export
language: fr
fill_locale: fr_FR
domain: associations
appearance: fixed columns, birthdays, birth date column
scenario: members' birthdays of the month, printed from a retirees' club's old membership tool
⟬text⟭
ANNIVERSAIRES DU MOIS
NE(E) LE      ADHERENT
⟬birth_date#1⟭  ⟬person_name#1⟭
⟬birth_date#2⟭  ⟬person_name#2⟭
⟬birth_date#3⟭  ⟬person_name#3⟭
⟬end⟭
