⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: PHP error log, array dump, value alone on a line
scenario: PHP error log of an old shop, where a developer left a print_r of the payment form with card and CVV
⟬text⟭
[⟬date#1⟭ 23:14:02 Europe/⟬trap:word_name|Paris⟭] PHP Notice:  Undefined index: coupon in /var/www/shop/checkout.php on line 212
[⟬date#1⟭ 23:14:02 Europe/⟬trap:word_name|Paris⟭] Array
(
    [nom] => ⟬person_name#1⟭
    [cc] => ⟬payment_card#1⟭
    [cvv] => ⟬card_security_code#1⟭
    [exp] => 09/27
)

[⟬date#1⟭ 23:14:03 Europe/⟬trap:word_name|Paris⟭] PHP Warning:  mail(): SMTP server response: 451 in /var/www/shop/lib/mail.php on line 48
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Go panic, goroutine dump, value alone on a line
scenario: Go panic of an SMS gateway, followed by debug lines where a partner secret and a password appear alone, with no key
⟬text⟭
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0x1 addr=0x18 pc=0x8a2b4c]

goroutine 412 [running]:
main.(*Passerelle).transmettre(0xc0001a2000, 0xc0003f6000)
	/src/smsgw/passerelle.go:188 +0x2c
main.(*Passerelle).boucle(0xc0001a2000)
	/src/smsgw/passerelle.go:121 +0x1a4
created by main.demarrer in goroutine 1
	/src/smsgw/main.go:64 +0x118
debug dernier corps:
⟬opaque_token#1⟭
⟬password#1⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: cargo test output, eponym
scenario: cargo test output of a clinical scores library, whose test names are eponymous scores, with no patient
⟬text⟭
running 6 tests
test scores::⟬trap:eponym|glasgow⟭::total_entre_3_et_15 ... ok
test scores::⟬trap:eponym|apgar⟭::nouveau_ne_vigoureux ... ok
test scores::⟬trap:eponym|apgar⟭::refuse_valeur_hors_bornes ... ok
test scores::⟬trap:eponym|framingham⟭::risque_a_dix_ans ... FAILED
test scores::⟬trap:eponym|child_pugh⟭::classe_b ... ok
test scores::⟬trap:eponym|barthel⟭::autonomie_complete ... ok

test result: FAILED. 5 passed; 1 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.02s
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: banking
appearance: Apache custom format, captured header, request field
scenario: Apache access of an account aggregation API, with the third party's token, an IBAN and a card in the context field
⟬text⟭
⟬ip_address#1⟭ [⟬date#1⟭ 09:44:02 +0200] "GET /psd2/comptes HTTP/1.1" 200 1204 auth="Bearer ⟬jwt#1⟭" ctx="-"
⟬ip_address#1⟭ [⟬date#1⟭ 09:44:03 +0200] "GET /psd2/comptes/solde HTTP/1.1" 200 412 auth="Bearer ⟬jwt#1⟭" ctx="⟬iban#2⟭"
⟬ip_address#1⟭ [⟬date#1⟭ 09:44:09 +0200] "GET /psd2/cartes/operations HTTP/1.1" 200 2204 auth="Bearer ⟬jwt#1⟭" ctx="⟬payment_card#2⟭"
⟬ip_address#2⟭ [⟬date#1⟭ 09:45:00 +0200] "GET /psd2/sante HTTP/1.1" 200 2 auth="-" ctx="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: pre-commit output, hook status
scenario: pre-commit run on an insurer's repository, whose hooks look for secrets and find none
⟬text⟭
$ pre-commit run --all-files
trim trailing whitespace.................................................Passed
check yaml...............................................................Passed
detect private key.......................................................Passed
detect aws credentials...................................................Passed
gitleaks.................................................................Passed
⟬trap:library|black⟭....................................................................Passed
flake8...................................................................Failed
- hook id: flake8
- exit code: 1

sinistres/calcul.py:44:80: E501 line too long (92 > 79 characters)
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: banking
appearance: ATM journal, value without a key
scenario: electronic journal of a cash machine, where each line quotes the card with no key, then the debited account
⟬text⟭
⟬date#1⟭ 18:22:05 GAB-0412 INSERTION ⟬payment_card#1⟭
⟬date#1⟭ 18:22:19 GAB-0412 CODE OK
⟬date#1⟭ 18:22:31 GAB-0412 RETRAIT 60.00 EUR ⟬iban#1⟭
⟬date#1⟭ 18:22:40 GAB-0412 BILLETS PRIS
⟬date#1⟭ 18:23:02 GAB-0412 INSERTION ⟬payment_card#2⟭
⟬date#1⟭ 18:23:21 GAB-0412 CARTE AVALEE, TROIS CODES FAUX
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: banking
appearance: plain sentences, log field, company record
scenario: anti-money-laundering engine log of a bank, describing customers, their companies and suspicious transfers in sentences
⟬text⟭
[LCB-FT] ⟬date#1⟭ 05:00:02 analyse de 412 208 opérations
[LCB-FT] ⟬date#1⟭ 05:01:44 scénario 12: ⟬person_name#1⟭ a reçu 9 900 EUR sur ⟬iban#1⟭ en trois virements fractionnés
[LCB-FT] ⟬date#1⟭ 05:01:44 scénario 12: le même jour ⟬person_name#1⟭ a retiré 9 000 EUR en espèces à ⟬city#1⟭
[LCB-FT] ⟬date#1⟭ 05:02:10 scénario 18: ⟬company#2⟭ (SIREN ⟬fr_siren#2⟭) encaisse des fonds venant de ⟬country#3⟭
[LCB-FT] ⟬date#1⟭ 05:02:10 scénario 18: gérant déclaré ⟬person_name#2⟭, contact ⟬phone#2⟭
[LCB-FT] ⟬date#1⟭ 05:02:11 scénario 18: IBAN émetteur ⟬iban#3⟭, BIC ⟬bic#3⟭
[LCB-FT] ⟬date#1⟭ 05:03:02 scénario 7: bénéficiaire ⟬person_name#4⟭ proche du gel d'avoirs, score 0.87 (distance de ⟬trap:eponym|Levenshtein⟭)
[LCB-FT] ⟬date#1⟭ 05:03:02 scénario 7: faux positif probable, homonyme de ⟬person_name#5⟭
[LCB-FT] ⟬date#1⟭ 05:04:30 scénario 21: ⟬trap:company_name|⦃Family⦄ Frères⟭ apparaît dans la liste des fournisseurs agréés, alerte ignorée
[LCB-FT] ⟬date#1⟭ 05:05:00 4 alertes créées, 1 ignorée
[LCB-FT] ⟬date#1⟭ 05:05:01 ⟬trap:indicator_non_pii|responsable=file-conformite⟭ prévenue
[LCB-FT] ⟬date#1⟭ 05:05:02 rapport ⟬file_path#1⟭, empreinte ⟬hash#1⟭
[LCB-FT] ⟬date#1⟭ 05:30:00 déclaration de soupçon préparée pour ⟬person_name#1⟭, ⟬fr_postal_address#1⟭
[LCB-FT] ⟬date#1⟭ 05:30:01 dossier confié à ⟬person_name#6⟭
[LCB-FT] ⟬date#1⟭ 05:45:00 sauvegarde vers ⟬hostname#1⟭ terminée
[LCB-FT] ⟬date#1⟭ 06:00:00 fin du traitement
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Python traceback, TLS error, font name
scenario: traceback of a local authority's PDF generator, failing on a certificate and a font, with no citizen
⟬text⟭
Traceback (most recent call last):
  File "/usr/lib/python3.11/site-packages/urllib3/connectionpool.py", line 467, in _make_request
    self._validate_conn(conn)
  File "/usr/lib/python3.11/ssl.py", line 1379, in do_handshake
    self._sslobj.do_handshake()
ssl.SSLCertVerificationError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate (_ssl.c:1006)

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/opt/deliberations/generer.py", line 91, in telecharger_police
    reponse = requests.get(URL_POLICES, timeout=10)
  File "/usr/lib/python3.11/site-packages/requests/adapters.py", line 517, in send
    raise SSLError(e, request=request)
requests.exceptions.SSLError: HTTPSConnectionPool(host='⟬hostname#1⟭', port=443): Max retries exceeded with url: /polices/⟬trap:word_name|marianne⟭.woff2

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/opt/deliberations/generer.py", line 96, in ⟬trap:code_identifier|mise_en_page_⦃family⦄⟭
    police = charger("⟬trap:word_name|Marianne⟭", repli="⟬trap:eponym|Garamond⟭")
RuntimeError: police ⟬trap:word_name|Marianne⟭ introuvable, ⟬trap:indicator_non_pii|auteur=service-informatique⟭ à prévenir
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Cypress run table, cy.log output, test fixture
scenario: Cypress output of a vehicle registration service, whose steps show the fictional applicant, their plate and passport, with a summary table
⟬text⟭
====================================================================================

  (Run Starting)

  ┌────────────────────────────────────────────────────────────────────────┐
  │ Cypress:    13.6.1                                                     │
  │ Browser:    Electron 114 (headless)                                    │
  │ Specs:      2 found (cession.cy.js, duplicata.cy.js)                   │
  └────────────────────────────────────────────────────────────────────────┘

  Running:  cession.cy.js                                                  (1 of 2)

  cession d'un véhicule
    (log) demandeur "⟬person_name#1⟭" passeport ⟬fr_passport#1⟭
    (log) plaque ⟬fr_license_plate#1⟭
    ✓ dépose la déclaration (2412ms)
    (log) acheteur "⟬person_name#2m⟭" né le ⟬birth_date#2⟭
    1) enregistre l'acheteur

  1 passing (6s)
  1 failing

  1) cession d'un véhicule
       enregistre l'acheteur:
     AssertionError: Timed out retrying after 4000ms: Expected to find content: '⟬fr_license_plate#1⟭' but never did.

  Running:  duplicata.cy.js                                                (2 of 2)

    ✓ demande un duplicata (1890ms)

  1 passing (2s)

  (Run Finished)
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: CDN tab-separated log, cookie field, query string
scenario: tab-separated CDN log of a shop, where the cookie and query string keep session tokens, cart references and an email address
⟬text⟭
#Fields: date time edge c-ip cs-method cs-uri-stem sc-status cs-bytes cs-cookie cs-uri-query
⟬date#1⟭	17:02:11	CDG50	⟬ip_address#1⟭	GET	/panier	200	8120	sid=⟬opaque_token#1⟭	-
⟬date#1⟭	17:02:14	CDG50	⟬ip_address#1⟭	GET	/images/montre.webp	200	44120	-	-
⟬date#1⟭	17:02:40	CDG50	⟬ip_address#1⟭	POST	/commande	302	0	sid=⟬opaque_token#1⟭	-
⟬date#1⟭	17:02:41	CDG50	⟬ip_address#1⟭	GET	/merci	200	3120	sid=⟬opaque_token#1⟭	ref=⟬order_number#1⟭
⟬date#1⟭	17:03:05	MRS52	⟬ip_address#2⟭	GET	/compte	200	5120	jwt=⟬jwt#2⟭	-
⟬date#1⟭	17:03:18	MRS52	⟬ip_address#2⟭	GET	/compte/adresses	200	2204	jwt=⟬jwt#2⟭	-
⟬date#1⟭	17:03:44	MRS52	⟬ip_address#2⟭	GET	/compte/parrainage	200	1120	jwt=⟬jwt#2⟭	code=⟬uuid#1⟭&invite=⟬email#2⟭
⟬date#1⟭	17:04:02	CDG50	⟬ip_address#3⟭	GET	/recherche	200	12040	-	q=sac+en+cuir
⟬date#1⟭	17:04:30	CDG50	⟬ip_address#3⟭	GET	/recherche	200	9120	-	q=⟬trap:company_name|⦃Family⦄+Maroquinerie⟭
⟬date#1⟭	17:05:11	LYS1	⟬ip_address#4⟭	GET	/panier/partage	200	3320	-	ref=⟬opaque_token#4⟭
⟬date#1⟭	17:05:40	LYS1	⟬ip_address#5⟭	GET	/panier/partage	200	3320	-	ref=⟬uuid#2⟭
⟬date#1⟭	17:06:02	LYS1	⟬ip_address#5⟭	GET	/robots.txt	200	64	-	-
⟬date#1⟭	17:06:30	CDG50	⟬ip_address#6⟭	GET	/api/v2/produits	200	22044	-	limit=100
⟬date#1⟭	17:07:04	CDG50	⟬ip_address#6⟭	GET	/api/v2/produits	200	21880	-	limit=100&page=2
⟬date#1⟭	17:07:40	MRS52	⟬ip_address#7⟭	POST	/webhooks/transporteur	204	0	-	sig=⟬opaque_token#7⟭
⟬date#1⟭	17:08:02	MRS52	⟬ip_address#7⟭	POST	/webhooks/transporteur	204	0	-	sig=⟬opaque_token#8⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: TeamCity build log, test fixture, service message
scenario: TeamCity build of a driving licence application, whose test data step prints user, passport, licence and tax number
⟬text⟭
[08:12:01] : [Step 1/3] Starting: /opt/buildagent/temp/agentTmp/custom_script.sh
[08:12:01] : [Step 1/3] in directory: /opt/buildagent/work/permis
[08:12:03] : [Step 1/3] préparation de la base de recette
[08:12:09] : [Step 1/3] 18 migrations appliquées
[08:12:10] i: [Step 1/3] ##teamcity[buildStatisticValue key='migrations' value='18']
[08:12:11] : [Step 2/3] chargement des usagers d'essai
[08:12:11] : [Step 2/3] usager=⟬person_name#1⟭;passeport=⟬fr_passport#1⟭;permis=⟬fr_driving_licence#1⟭
[08:12:11] : [Step 2/3] usager=⟬person_name#2⟭;passeport=⟬fr_passport#2⟭;permis=⟬fr_driving_licence#2⟭
[08:12:11] : [Step 2/3] usager=⟬trap:indicator_non_pii|demo-guichet⟭;passeport=⟬trap:indicator_non_pii|sans-objet⟭;permis=⟬trap:indicator_non_pii|sans-objet⟭
[08:12:12] : [Step 2/3] numéro fiscal de contrôle ⟬fr_tax_number#1⟭
[08:12:14] : [Step 3/3] mvn -B verify
[08:13:40] : [Step 3/3] Tests run: 318, Failures: 0, Errors: 0, Skipped: 4
[08:13:41] : [Step 3/3] BUILD SUCCESS
[08:13:42] i: [Step 3/3] ##teamcity[publishArtifacts 'target/permis-⟬version#1⟭.war']
[08:13:45] : Publishing artifacts
[08:13:46] : Build finished
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: fixed-width columns, quoted value, reason field
scenario: fixed-width log of lookups in a tax file, with agents, reasons, tax number, NIR, passport and taxpayers' birth dates
⟬text⟭
DATE        HEURE     AGENT                  OBJET        VALEUR                         MOTIF
⟬date#1⟭  08:42:10  ⟬person_name:handle#1⟭  SPI          ⟬fr_tax_number#2⟭              contrôle sur pièces
⟬date#1⟭  08:42:55  ⟬person_name:handle#1⟭  NIR          ⟬fr_social_security_number#2⟭  contrôle sur pièces
⟬date#1⟭  08:43:30  ⟬person_name:handle#1⟭  NAISSANCE    ⟬birth_date#2⟭                 contrôle sur pièces
⟬date#1⟭  09:15:02  ⟬person_name:handle#3⟭  SPI          ⟬fr_tax_number#4⟭              demande de l'usager
⟬date#1⟭  09:15:40  ⟬person_name:handle#3⟭  PASSEPORT    ⟬fr_passport#4⟭                vérification d'identité
⟬date#1⟭  09:16:18  ⟬person_name:handle#3⟭  ADRESSE      "⟬fr_postal_address#4⟭"        changement de domicile
⟬date#1⟭  10:00:00  ⟬trap:indicator_non_pii|batch-relances⟭  LOT          ⟬uuid#1⟭                       relance automatique
⟬date#1⟭  10:21:47  ⟬person_name:handle#5⟭  SPI          ⟬fr_tax_number#6⟭              sans motif
⟬date#1⟭  10:21:48  ⟬trap:indicator_non_pii|regle-acces-7⟭  ALERTE       ⟬uuid#2⟭                       consultation d'un proche
⟬date#1⟭  10:40:12  ⟬person_name#7⟭      SIGNALEMENT  ⟬ticket_id#1⟭                  enquête interne ouverte
⟬date#1⟭  11:05:09  ⟬person_name:handle#1⟭  SIREN        ⟬fr_siren#8⟭                   entreprise individuelle
⟬date#1⟭  11:05:50  ⟬person_name:handle#1⟭  SIRET        ⟬fr_siret#8⟭                   établissement secondaire
⟬date#1⟭  11:30:00  ⟬trap:indicator_non_pii|batch-relances⟭  LOT          ⟬uuid#3⟭                       relance automatique
⟬date#1⟭  11:44:31  ⟬person_name:handle#3⟭  NIR          ⟬fr_social_security_number#9⟭  rattachement au foyer
⟬date#1⟭  11:45:02  ⟬person_name:handle#3⟭  NAISSANCE    ⟬birth_date#9⟭                 rattachement au foyer
⟬date#1⟭  12:00:00  ⟬trap:indicator_non_pii|sauvegarde⟭  JOURNAL      ⟬hash#1⟭                       archivage
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Kubernetes audit event, JSON log line
scenario: Kubernetes audit events of an operator's billing platform, generated by service accounts, with no person or secret
⟬text⟭
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"get","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:bss:deployer⟭"},"objectRef":{"resource":"secrets","namespace":"bss","name":"db-credentials"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:10:02"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"patch","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:bss:deployer⟭"},"objectRef":{"resource":"deployments","namespace":"bss","name":"facturation"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:10:05"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"list","user":{"username":"⟬trap:indicator_non_pii|system:kube-scheduler⟭"},"objectRef":{"resource":"pods"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:10:07"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"create","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:kube-system:job-controller⟭"},"objectRef":{"resource":"pods","namespace":"bss","name":"purge-cdr"},"responseStatus":{"code":201},"requestReceivedTimestamp":"⟬date#1⟭ 04:15:00"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"get","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:monitoring:prometheus⟭"},"objectRef":{"resource":"nodes","name":"⟬hostname#1⟭"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:15:30"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"delete","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:bss:janitor⟭"},"objectRef":{"resource":"pods","namespace":"bss","name":"purge-cdr"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:20:00"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"get","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:bss:facturation⟭"},"objectRef":{"resource":"configmaps","namespace":"bss","name":"tarifs-⟬version#1⟭"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:21:12"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"get","user":{"username":"⟬trap:indicator_non_pii|system:anonymous⟭"},"objectRef":{"resource":"secrets","namespace":"bss"},"responseStatus":{"code":403},"sourceIPs":["⟬ip_address#1⟭"],"requestReceivedTimestamp":"⟬date#1⟭ 04:22:44"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"watch","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:cert-manager:cert-manager⟭"},"objectRef":{"resource":"certificates"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:25:01"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"update","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:cert-manager:cert-manager⟭"},"objectRef":{"resource":"secrets","namespace":"bss","name":"tls-facturation"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:25:03"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"get","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:argocd:argocd-application-controller⟭"},"objectRef":{"resource":"services","namespace":"bss","name":"facturation"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:30:00"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"patch","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:keda:keda-operator⟭"},"objectRef":{"resource":"horizontalpodautoscalers","namespace":"bss","name":"mediation"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:31:44"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"create","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:bss:deployer⟭"},"objectRef":{"resource":"events","namespace":"bss"},"responseStatus":{"code":201},"requestReceivedTimestamp":"⟬date#1⟭ 04:32:10"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"get","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:monitoring:prometheus⟭"},"objectRef":{"resource":"nodes","name":"⟬hostname#2⟭"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:35:30"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"list","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:velero:velero⟭"},"objectRef":{"resource":"persistentvolumes"},"responseStatus":{"code":200},"requestReceivedTimestamp":"⟬date#1⟭ 04:40:00"}
{"kind":"Event","level":"Metadata","stage":"ResponseComplete","verb":"create","user":{"username":"⟬trap:indicator_non_pii|system:serviceaccount:velero:velero⟭"},"objectRef":{"resource":"backups","namespace":"velero","name":"bss-quotidien"},"responseStatus":{"code":201},"requestReceivedTimestamp":"⟬date#1⟭ 04:40:02"}
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: banking
appearance: Tekton step log, connection string, Slack token, CLI argument
scenario: Tekton pipeline of a bank card service, running Liquibase with its full URL and notifying the team with a visible Slack token
⟬text⟭
[recuperer : clone] + git clone ⟬url#1⟭ /workspace/source
[recuperer : clone] Cloning into '/workspace/source'...
[construire : maven] [INFO] Building cartes-service ⟬version#1⟭
[construire : maven] [INFO] BUILD SUCCESS
[migrer : liquibase] + liquibase --url=jdbc:postgresql://⟬hostname#1⟭:5432/cartes --username=⟬trap:indicator_non_pii|cartes_owner⟭ --password=⟬password#1⟭ update
[migrer : liquibase] Liquibase Community ⟬version#2⟭ by Liquibase
[migrer : liquibase] Running Changeset: db/changelog/0042-index-pan.xml::42::⟬person_name:handle#2⟭
[migrer : liquibase] Liquibase command 'update' was executed successfully.
[deployer : helm] + helm upgrade cartes charts/cartes --set db.url=postgresql://cartes_app:⟬url_password#3⟭@⟬hostname#1⟭:5432/cartes
[deployer : helm] Release "cartes" has been upgraded. Happy Helming!
[notifier : curl] + curl -s -H 'Authorization: Bearer ⟬slack_token#1⟭' -d channel=deploiements -d "text=cartes deploye par ⟬person_name#2⟭" https://slack.com/api/chat.postMessage
[notifier : curl] {"ok":true}
[notifier : curl] + curl -s -H 'Authorization: Bearer ⟬trap:placeholder|$PAGERDUTY_TOKEN⟭' -d 'event=fin' ⟬url#2⟭
[notifier : curl] {"status":"accepted"}
[notifier : curl] pipeline termine en 4 min 12 s
[nettoyer : rm] + rm -rf /workspace/source
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: insurance
appearance: JUnit console tree, assertion message
scenario: tree output of the JUnit launcher of a car quote software, whose failures show the test case's plate, licence and driver
⟬text⟭
╷
├─ JUnit Jupiter ✔
│  ├─ DevisAutoTest ✔
│  │  ├─ tarifJeuneConducteur() ✔
│  │  ├─ tarifBonusCinquante() ✔
│  │  └─ refuseVehiculeDeCollection() ✘ attendu REFUS pour ⟬fr_license_plate#1⟭ mais obtenu ACCEPTE
│  ├─ ConducteurTest ✔
│  │  ├─ permisProbatoire() ✘ permis ⟬fr_driving_licence#1⟭ de "⟬person_name#1⟭" non reconnu comme probatoire
│  │  └─ conducteurSecondaire() ✔
│  └─ ⟬trap:code_identifier|⦃Family⦄BonusTest⟭ ✔
│     └─ malusPlafonne() ✔
└─ JUnit Vintage ✔

Failures (2):
  JUnit Jupiter:DevisAutoTest:refuseVehiculeDeCollection()
    => org.opentest4j.AssertionFailedError: attendu REFUS pour ⟬fr_license_plate#1⟭ mais obtenu ACCEPTE
  JUnit Jupiter:ConducteurTest:permisProbatoire()
    => org.opentest4j.AssertionFailedError: permis ⟬fr_driving_licence#1⟭ de "⟬person_name#1⟭" non reconnu comme probatoire

Test run finished after 812 ms
[         6 tests successful      ]
[         2 tests failed          ]
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: Perl die message, Carp backtrace, DBI error
scenario: Perl error of a hospital billing export, whose DBI message and Carp stack copy the NIR, name and birth date of the rejected stay
⟬text⟭
DBD::Pg::st execute failed: ERREUR:  une valeur NULL viole la contrainte NOT NULL de la colonne « mutuelle »
DETAIL:  La ligne en échec contient (⟬customer_id#1⟭, ⟬fr_social_security_number#1⟭, "⟬person_name#1⟭", ⟬birth_date#1⟭, null). at /opt/pmsi/lib/Export/Sejour.pm line 212.
	Export::Sejour::inserer('Export::Sejour=HASH(0x55d0c8a1)', 'HASH(0x55d0c9f0)') called at /opt/pmsi/lib/Export/Lot.pm line 88
	Export::Lot::traiter('Export::Lot=HASH(0x55d0c6b8)', 412) called at /opt/pmsi/bin/export.pl line 41
	eval {...} called at /opt/pmsi/bin/export.pl line 39
	main::lancer('lot', 412) called at /opt/pmsi/bin/export.pl line 102
export.pl: connexion a ⟬hostname#1⟭ fermee
export.pl: tentative 2/3 sur le lot 412
DBD::Pg::st execute failed: ERREUR:  une valeur NULL viole la contrainte NOT NULL de la colonne « mutuelle »
DETAIL:  La ligne en échec contient (⟬customer_id#5⟭, ⟬fr_social_security_number#5⟭, "⟬person_name#5⟭", ⟬birth_date#5⟭, null). at /opt/pmsi/lib/Export/Sejour.pm line 212.
	Export::Sejour::inserer('Export::Sejour=HASH(0x55d0c8a1)', 'HASH(0x55d0d112)') called at /opt/pmsi/lib/Export/Lot.pm line 88
export.pl: lot 412 interrompu, 88 sejours deja ecrits dans ⟬file_path#1⟭
export.pl: sejour fautif ⟬uuid#1⟭ service=chirurgie medecin="Dr ⟬person_name#2⟭" entree=⟬date#2⟭ sortie=⟬date#1⟭
export.pl: patiente ⟬person_name#3f⟭ nee le ⟬birth_date#3⟭ ignoree, ⟬trap:indicator_non_pii|mutuelle=non renseignee⟭
export.pl: nir=⟬fr_social_security_number#3⟭ conserve pour reprise
export.pl: voir ⟬ticket_id#1⟭ et prevenir ⟬email:generic#4⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: journalctl output, passport in a sentence, value alone on a line, secret under an innocuous key
scenario: systemd journal of in-store customer enrolment at an operator, over a morning, with ID documents, sellers and terminal secrets shown without a key
⟬text⟭
⟬date#1⟭ 09:00:02 boutique-kyc[812]: démarrage du service, version ⟬version#1⟭
⟬date#1⟭ 09:00:03 boutique-kyc[812]: terminal POS-12 connecté depuis ⟬ip_address#1⟭
⟬date#1⟭ 09:00:03 boutique-kyc[812]: secret du terminal:
⟬date#1⟭ 09:00:03 boutique-kyc[812]: ⟬opaque_token#1⟭
⟬date#1⟭ 09:00:04 boutique-kyc[812]: terminal POS-14 connecté depuis ⟬ip_address#2⟭
⟬date#1⟭ 09:00:04 boutique-kyc[812]: secret du terminal:
⟬date#1⟭ 09:00:04 boutique-kyc[812]: ⟬opaque_token#2⟭
⟬date#1⟭ 09:12:41 boutique-kyc[812]: vendeur ⟬person_name#3m⟭ ouvre une session sur POS-12
⟬date#1⟭ 09:12:42 boutique-kyc[812]: mot de passe temporaire ⟬password#3⟭ expiré, renouvellement demandé
⟬date#1⟭ 09:14:20 boutique-kyc[812]: nouveau client: ⟬person_name#4⟭ présente le passeport ⟬fr_passport#4⟭
⟬date#1⟭ 09:14:27 boutique-kyc[812]: lecture MRZ correcte, photo comparée, score 0.94
⟬date#1⟭ 09:14:30 boutique-kyc[812]: numéro attribué ⟬phone#4⟭, offre=FORFAIT_50GO
⟬date#1⟭ 09:14:35 boutique-kyc[812]: mandat de prélèvement signé sur tablette, ref=⟬uuid#1⟭
⟬date#1⟭ 09:14:36 boutique-kyc[812]: prélèvement sur ⟬iban#4⟭
⟬date#1⟭ 09:14:50 boutique-kyc[812]: SIM activée
⟬date#1⟭ 09:31:02 boutique-kyc[812]: vendeur ⟬person_name#5m⟭ ouvre une session sur POS-14
⟬date#1⟭ 09:33:15 boutique-kyc[812]: nouveau client: ⟬person_name#6⟭ présente la carte ⟬fr_identity_card#6⟭
⟬date#1⟭ 09:33:21 boutique-kyc[812]: lecture de la carte illisible, saisie manuelle par ⟬person_name#5⟭
⟬date#1⟭ 09:33:44 boutique-kyc[812]: portabilité demandée pour ⟬phone#6⟭, rio=⟬customer_id#6⟭
⟬date#1⟭ 09:34:02 boutique-kyc[812]: SIM activée
⟬date#1⟭ 09:47:30 boutique-kyc[812]: nouveau client: ⟬person_name#7⟭ présente le passeport ⟬fr_passport#7⟭
⟬date#1⟭ 09:47:36 boutique-kyc[812]: passeport expiré, activation refusée, responsable=⟬person_name#8⟭ prévenu
⟬date#1⟭ 09:48:01 boutique-kyc[812]: dérogation refusée par ⟬trap:indicator_non_pii|responsable=regle-conformite⟭
⟬date#1⟭ 10:05:12 boutique-kyc[812]: vendeur ⟬person_name#3⟭ ferme sa session sur POS-12
⟬date#1⟭ 10:05:40 boutique-kyc[812]: rotation du secret du terminal POS-12
⟬date#1⟭ 10:05:40 boutique-kyc[812]: ⟬opaque_token#3⟭
⟬date#1⟭ 10:10:00 boutique-kyc[812]: synchronisation avec le référentiel ⟬hostname#1⟭
⟬date#1⟭ 10:10:02 boutique-kyc[812]: ⟬trap:indicator_non_pii|login=sync-kyc⟭ accepté
⟬date#1⟭ 10:10:02 boutique-kyc[812]: mot de passe de synchronisation:
⟬date#1⟭ 10:10:02 boutique-kyc[812]: ⟬password#9⟭
⟬date#1⟭ 10:10:09 boutique-kyc[812]: 3 dossiers transmis, 1 refusé
⟬date#1⟭ 10:22:18 boutique-kyc[812]: client ⟬customer_id#10⟭ revient pour un changement de forfait
⟬date#1⟭ 10:22:19 boutique-kyc[812]: ⟬person_name#10⟭ signe avec ⟬trap:initials|J.-M.⟭ en paraphe
⟬date#1⟭ 10:22:30 boutique-kyc[812]: forfait mis à jour, facture ⟬invoice_number#10⟭
⟬date#1⟭ 10:35:44 boutique-kyc[812]: alerte réseau sur POS-14, perte de 12 paquets
⟬date#1⟭ 10:36:10 boutique-kyc[812]: POS-14 reconnecté
⟬date#1⟭ 10:50:02 boutique-kyc[812]: vendeur ⟬person_name#11m⟭ ouvre une session sur POS-12
⟬date#1⟭ 10:51:30 boutique-kyc[812]: nouveau client: ⟬person_name#12⟭ présente le passeport ⟬fr_passport#12⟭
⟬date#1⟭ 10:51:36 boutique-kyc[812]: lecture MRZ correcte, photo comparée, score 0.71
⟬date#1⟭ 10:51:37 boutique-kyc[812]: score insuffisant, seconde vérification par ⟬person_name#11⟭
⟬date#1⟭ 10:53:02 boutique-kyc[812]: identité confirmée, numéro attribué ⟬phone#12⟭
⟬date#1⟭ 10:53:10 boutique-kyc[812]: prélèvement sur ⟬iban#12⟭
⟬date#1⟭ 10:53:30 boutique-kyc[812]: SIM activée
⟬date#1⟭ 11:00:00 boutique-kyc[812]: bilan de la matinée: 4 activations, 1 refus
⟬date#1⟭ 11:00:01 boutique-kyc[812]: ⟬trap:indicator_non_pii|client=anonyme⟭ pour 12 simulations d'offres
⟬date#1⟭ 11:15:00 boutique-kyc[812]: sonde réseau ok
⟬date#1⟭ 11:30:00 boutique-kyc[812]: sonde réseau ok
⟬date#1⟭ 11:30:05 boutique-kyc[812]: journal de la caisse exporté dans ⟬file_path#1⟭
⟬date#1⟭ 11:45:00 boutique-kyc[812]: sonde réseau ok
⟬date#1⟭ 12:00:00 boutique-kyc[812]: fermeture de la boutique pour la pause
⟬date#1⟭ 12:00:02 boutique-kyc[812]: vendeur ⟬person_name#11⟭ ferme sa session sur POS-12
⟬date#1⟭ 12:00:03 boutique-kyc[812]: vendeur ⟬person_name#5⟭ ferme sa session sur POS-14
⟬date#1⟭ 12:15:00 boutique-kyc[812]: sonde réseau ok
⟬date#1⟭ 12:30:00 boutique-kyc[812]: sonde réseau ok
⟬date#1⟭ 12:45:00 boutique-kyc[812]: sonde réseau ok
⟬date#1⟭ 13:00:00 boutique-kyc[812]: sonde réseau ok
⟬date#1⟭ 13:30:02 boutique-kyc[812]: réouverture de la boutique
⟬date#1⟭ 13:30:04 boutique-kyc[812]: terminal POS-12 connecté depuis ⟬ip_address#1⟭
⟬date#1⟭ 13:30:05 boutique-kyc[812]: terminal POS-14 connecté depuis ⟬ip_address#2⟭
⟬date#1⟭ 13:32:00 boutique-kyc[812]: vendeur ⟬person_name#3⟭ ouvre une session sur POS-12
⟬date#1⟭ 13:34:11 boutique-kyc[812]: nouveau client: ⟬person_name#13⟭ présente le passeport ⟬fr_passport#13⟭
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: custom access format, handle in a URL path, captured header, API key
scenario: access of a writing assistant for doctors, whose paths carry the practitioner's id and whose format captures the model provider key and the handled record
⟬text⟭
⟬ip_address#1⟭ ⟬person_name:handle#1⟭ [⟬date#1⟭ 13:02:11 +0100] "GET /assistant/⟬person_name:handle#1⟭/brouillons HTTP/1.1" 200 2204 upstream=- dossier=-
⟬ip_address#1⟭ ⟬person_name:handle#1⟭ [⟬date#1⟭ 13:02:40 +0100] "POST /assistant/⟬person_name:handle#1⟭/resumer HTTP/1.1" 200 1204 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬fr_social_security_number#2⟭"
⟬ip_address#1⟭ ⟬person_name:handle#1⟭ [⟬date#1⟭ 13:03:12 +0100] "POST /assistant/⟬person_name:handle#1⟭/resumer HTTP/1.1" 200 1812 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬fr_social_security_number#3⟭"
⟬ip_address#2⟭ - [⟬date#1⟭ 13:03:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#3⟭ ⟬person_name:handle#4⟭ [⟬date#1⟭ 13:04:02 +0100] "GET /assistant/⟬person_name:handle#4⟭/brouillons HTTP/1.1" 200 1204 upstream=- dossier=-
⟬ip_address#3⟭ ⟬person_name:handle#4⟭ [⟬date#1⟭ 13:04:44 +0100] "POST /assistant/⟬person_name:handle#4⟭/resumer HTTP/1.1" 200 2204 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬person_name#5f⟭, née le ⟬birth_date#5⟭"
⟬ip_address#3⟭ ⟬person_name:handle#4⟭ [⟬date#1⟭ 13:05:30 +0100] "POST /assistant/⟬person_name:handle#4⟭/lettre HTTP/1.1" 200 3120 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬person_name#5f⟭, née le ⟬birth_date#5⟭"
⟬ip_address#2⟭ - [⟬date#1⟭ 13:06:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#4⟭ ⟬person_name:handle#6⟭ [⟬date#1⟭ 13:07:02 +0100] "POST /assistant/connexion HTTP/1.1" 401 88 upstream=- dossier=-
⟬ip_address#4⟭ ⟬person_name:handle#6⟭ [⟬date#1⟭ 13:07:15 +0100] "POST /assistant/connexion HTTP/1.1" 200 642 upstream=- dossier=-
⟬ip_address#4⟭ ⟬person_name:handle#6⟭ [⟬date#1⟭ 13:07:44 +0100] "GET /assistant/⟬person_name:handle#6⟭/modeles HTTP/1.1" 200 412 upstream=- dossier=-
⟬ip_address#4⟭ ⟬person_name:handle#6⟭ [⟬date#1⟭ 13:08:20 +0100] "POST /assistant/⟬person_name:handle#6⟭/resumer HTTP/1.1" 429 96 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬fr_social_security_number#7⟭"
⟬ip_address#4⟭ ⟬person_name:handle#6⟭ [⟬date#1⟭ 13:08:41 +0100] "POST /assistant/⟬person_name:handle#6⟭/resumer HTTP/1.1" 200 1612 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬fr_social_security_number#7⟭"
⟬ip_address#2⟭ - [⟬date#1⟭ 13:09:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#5⟭ ⟬trap:indicator_non_pii|user-evaluation⟭ [⟬date#1⟭ 13:10:00 +0100] "POST /assistant/evaluation HTTP/1.1" 200 412 upstream=- dossier="⟬trap:indicator_non_pii|patient=fictif⟭"
⟬ip_address#5⟭ ⟬trap:indicator_non_pii|user-evaluation⟭ [⟬date#1⟭ 13:10:30 +0100] "POST /assistant/evaluation HTTP/1.1" 200 412 upstream=- dossier="⟬trap:indicator_non_pii|patient=fictif⟭"
⟬ip_address#1⟭ ⟬person_name:handle#1⟭ [⟬date#1⟭ 13:11:02 +0100] "POST /assistant/⟬person_name:handle#1⟭/lettre HTTP/1.1" 200 2120 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬fr_social_security_number#2⟭"
⟬ip_address#1⟭ ⟬person_name:handle#1⟭ [⟬date#1⟭ 13:11:50 +0100] "GET /assistant/⟬person_name:handle#1⟭/historique HTTP/1.1" 200 4120 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:12:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#6⟭ ⟬person_name:handle#8⟭ [⟬date#1⟭ 13:13:02 +0100] "POST /assistant/connexion HTTP/1.1" 200 642 upstream=- dossier=-
⟬ip_address#6⟭ ⟬person_name:handle#8⟭ [⟬date#1⟭ 13:13:44 +0100] "POST /assistant/⟬person_name:handle#8⟭/resumer HTTP/1.1" 200 1412 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬person_name#9m⟭, né le ⟬birth_date#9⟭"
⟬ip_address#6⟭ ⟬person_name:handle#8⟭ [⟬date#1⟭ 13:14:20 +0100] "POST /assistant/⟬person_name:handle#8⟭/resumer HTTP/1.1" 200 1612 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬fr_social_security_number#10⟭"
⟬ip_address#2⟭ - [⟬date#1⟭ 13:15:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#7⟭ - [⟬date#1⟭ 13:16:02 +0100] "GET /assistant/favicon.ico HTTP/1.1" 200 1150 upstream=- dossier=-
⟬ip_address#3⟭ ⟬person_name:handle#4⟭ [⟬date#1⟭ 13:17:12 +0100] "GET /assistant/⟬person_name:handle#4⟭/historique HTTP/1.1" 200 2204 upstream=- dossier=-
⟬ip_address#3⟭ ⟬person_name:handle#4⟭ [⟬date#1⟭ 13:17:50 +0100] "POST /assistant/⟬person_name:handle#4⟭/deconnexion HTTP/1.1" 204 0 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:18:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#8⟭ ⟬person_name:handle#11⟭ [⟬date#1⟭ 13:19:40 +0100] "POST /assistant/connexion HTTP/1.1" 200 642 upstream=- dossier=-
⟬ip_address#8⟭ ⟬person_name:handle#11⟭ [⟬date#1⟭ 13:20:12 +0100] "POST /assistant/⟬person_name:handle#11⟭/resumer HTTP/1.1" 200 2120 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬person_name#12f⟭, née le ⟬birth_date#12⟭"
⟬ip_address#8⟭ ⟬person_name:handle#11⟭ [⟬date#1⟭ 13:21:02 +0100] "POST /assistant/⟬person_name:handle#11⟭/lettre HTTP/1.1" 200 2640 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬person_name#12f⟭, née le ⟬birth_date#12⟭"
⟬ip_address#2⟭ - [⟬date#1⟭ 13:21:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#6⟭ ⟬person_name:handle#8⟭ [⟬date#1⟭ 13:22:04 +0100] "POST /assistant/⟬person_name:handle#8⟭/deconnexion HTTP/1.1" 204 0 upstream=- dossier=-
⟬ip_address#9⟭ - [⟬date#1⟭ 13:23:18 +0100] "GET /wp-admin/ HTTP/1.1" 404 153 upstream=- dossier=-
⟬ip_address#9⟭ - [⟬date#1⟭ 13:23:19 +0100] "GET /.git/HEAD HTTP/1.1" 404 153 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:24:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#1⟭ ⟬person_name:handle#1⟭ [⟬date#1⟭ 13:25:02 +0100] "POST /assistant/⟬person_name:handle#1⟭/resumer HTTP/1.1" 500 188 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬fr_social_security_number#13⟭"
⟬ip_address#1⟭ ⟬person_name:handle#1⟭ [⟬date#1⟭ 13:25:40 +0100] "POST /assistant/⟬person_name:handle#1⟭/resumer HTTP/1.1" 200 1812 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬fr_social_security_number#13⟭"
⟬ip_address#8⟭ ⟬person_name:handle#11⟭ [⟬date#1⟭ 13:26:12 +0100] "POST /assistant/⟬person_name:handle#11⟭/deconnexion HTTP/1.1" 204 0 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:27:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#10⟭ ⟬person_name:handle#14⟭ [⟬date#1⟭ 13:28:02 +0100] "POST /assistant/connexion HTTP/1.1" 200 642 upstream=- dossier=-
⟬ip_address#10⟭ ⟬person_name:handle#14⟭ [⟬date#1⟭ 13:28:40 +0100] "GET /assistant/⟬person_name:handle#14⟭/brouillons HTTP/1.1" 200 412 upstream=- dossier=-
⟬ip_address#10⟭ ⟬person_name:handle#14⟭ [⟬date#1⟭ 13:29:20 +0100] "POST /assistant/⟬person_name:handle#14⟭/resumer HTTP/1.1" 200 1612 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬person_name#15⟭, ⟬age#15⟭ ans"
⟬ip_address#2⟭ - [⟬date#1⟭ 13:30:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#10⟭ ⟬person_name:handle#14⟭ [⟬date#1⟭ 13:31:02 +0100] "POST /assistant/⟬person_name:handle#14⟭/lettre HTTP/1.1" 200 2204 upstream="x-api-key: ⟬anthropic_api_key#1⟭" dossier="⟬person_name#15⟭, ⟬age#15⟭ ans"
⟬ip_address#2⟭ - [⟬date#1⟭ 13:33:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#10⟭ ⟬person_name:handle#14⟭ [⟬date#1⟭ 13:34:02 +0100] "POST /assistant/⟬person_name:handle#14⟭/deconnexion HTTP/1.1" 204 0 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:36:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:39:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#5⟭ ⟬trap:indicator_non_pii|user-evaluation⟭ [⟬date#1⟭ 13:40:00 +0100] "GET /assistant/evaluation/rapport HTTP/1.1" 200 8120 upstream=- dossier="-"
⟬ip_address#2⟭ - [⟬date#1⟭ 13:42:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:45:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#7⟭ - [⟬date#1⟭ 13:46:12 +0100] "GET /assistant/mentions-legales HTTP/1.1" 200 3120 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:48:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:51:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:54:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 13:57:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 14:00:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 14:03:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 14:06:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 14:09:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 14:12:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬ip_address#2⟭ - [⟬date#1⟭ 14:15:30 +0100] "GET /assistant/sante HTTP/1.1" 200 2 upstream=- dossier=-
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: yarn install output, Docker build, Trivy table, scoped package names
scenario: Docker build and Trivy scan of a merchant site's front end, with at-sign packages, unresolved variables and no sensitive value
⟬text⟭
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 812B done
#2 [internal] load metadata for docker.io/library/node:20-alpine
#3 [deps 1/4] FROM docker.io/library/node:20-alpine
#4 [deps 2/4] WORKDIR /app
#5 [deps 3/4] COPY package.json yarn.lock .npmrc ./
#6 [deps 4/4] RUN yarn install --frozen-lockfile
#6 0.412 yarn install v1.22.19
#6 0.480 [1/4] Resolving packages...
#6 1.204 [2/4] Fetching packages...
#6 12.81 [3/4] Linking dependencies...
#6 12.90 warning "⟬trap:email_lookalike|@storybook/react@7.6.3⟭" has unmet peer dependency "⟬trap:email_lookalike|@babel/core@^7.0.0⟭".
#6 12.91 warning " > ⟬trap:email_lookalike|@testing-library/user-event@14.5.1⟭" has unmet peer dependency "⟬trap:email_lookalike|@testing-library/dom@>=7.21.4⟭".
#6 12.92 warning " > ⟬trap:email_lookalike|@types/node@20.10.0⟭" has incorrect peer dependency "typescript@^5.0.0".
#6 12.95 warning Pattern ["⟬trap:email_lookalike|@floating-ui/react@^0.26.0⟭"] is trying to unpack in the same destination.
#6 31.20 [4/4] Building fresh packages...
#6 44.02 Done in 43.61s.
#7 [build 1/3] COPY . .
#8 [build 2/3] RUN yarn build
#8 1.812 warn - variable ⟬trap:placeholder|${NPM_TOKEN}⟭ non résolue dans .npmrc
#8 2.044 warn - ⟬trap:indicator_non_pii|NEXT_PUBLIC_SUPPORT_EMAIL⟭ absente, utilisation de ⟬trap:indicator_non_pii|<email>⟭
#8 8.120 info - Compiled successfully
#8 8.204 info - Collecting page data
#8 12.61 info - Generating static pages (412/412)
#9 [build 3/3] RUN yarn cache clean
#10 [run 1/2] COPY --from=build /app/.next /app/.next
#11 [run 2/2] COPY --from=build /app/public /app/public
#12 exporting to image
#12 writing image sha256:⟬hash#1⟭ done
#12 naming to ⟬hostname#1⟭/boutique/front:⟬git_sha#1⟭ done

$ trivy image --severity HIGH,CRITICAL ⟬hostname#1⟭/boutique/front:⟬git_sha#1⟭
⟬date#1⟭ 10:12:44 INFO Vulnerability scanning is enabled
⟬date#1⟭ 10:12:44 INFO Secret scanning is enabled
⟬date#1⟭ 10:12:52 INFO Detected OS: alpine
⟬date#1⟭ 10:12:52 INFO Number of language-specific files: 1

boutique/front (alpine 3.19.0)
Total: 1 (HIGH: 1, CRITICAL: 0)

┌────────────┬────────────────┬──────────┬───────────────┬───────────────┐
│  Library   │ Vulnerability  │ Severity │ Installed     │ Fixed Version │
├────────────┼────────────────┼──────────┼───────────────┼───────────────┤
│ libcrypto3 │ CVE-2023-6237  │ HIGH     │ 3.1.4-r2      │ 3.1.4-r3      │
└────────────┴────────────────┴──────────┴───────────────┴───────────────┘

Node.js (package.json)
Total: 2 (HIGH: 2, CRITICAL: 0)

┌────────────────┬────────────────┬──────────┬───────────┬───────────────┐
│    Library     │ Vulnerability  │ Severity │ Installed │ Fixed Version │
├────────────────┼────────────────┼──────────┼───────────┼───────────────┤
│ axios          │ CVE-2023-45857 │ HIGH     │ 1.5.0     │ 1.6.0         │
│ ⟬trap:email_lookalike|@babel/traverse⟭ │ CVE-2023-45133 │ HIGH     │ 7.22.0    │ 7.23.2        │
└────────────┴────────────────┴──────────┴───────────┴───────────────┘

$ echo "scan termine par ⟬trap:email_lookalike|$USER@runner⟭"
scan termine par ⟬trap:email_lookalike|ci@runner⟭
$ docker push ⟬hostname#1⟭/boutique/front:⟬git_sha#1⟭
The push refers to repository [⟬hostname#1⟭/boutique/front]
⟬git_sha#2⟭: Pushed
⟬git_sha#3⟭: Pushed
⟬git_sha#1⟭: digest: sha256:⟬hash#2⟭ size: 2412
$ ./ci/notifier.sh
notification envoyee a l'equipe front, ⟬trap:indicator_non_pii|owner=equipe-front⟭
Job succeeded
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: multi-day audit trail, plain sentences, quoted value, value without a key
scenario: full history of a serious claim over several days, written in sentences by the application, with drivers, witness, plates, licences and bank details
⟬text⟭
⟬date#4⟭ 08:14 Ouverture du dossier ⟬ticket_id#1⟭ par ⟬person_name#1⟭ après l'appel de ⟬person_name#2⟭.
⟬date#4⟭ 08:15 Véhicule assuré ⟬fr_license_plate#2⟭, conducteur ⟬person_name#2⟭, permis ⟬fr_driving_licence#2⟭.
⟬date#4⟭ 08:16 Contrat ⟬customer_id#2⟭ en cours, garantie tous risques.
⟬date#4⟭ 08:19 Tiers impliqué ⟬person_name#3⟭, véhicule ⟬fr_license_plate#3⟭, assureur ⟬company#3⟭.
⟬date#4⟭ 08:22 Témoin ⟬person_name#4⟭ joignable au ⟬phone#4⟭.
⟬date#4⟭ 08:24 Accident survenu ⟬trap:word_name|avenue Jean Jaurès⟭ à ⟬city#2⟭, ⟬trap:indicator_non_pii|gravite=corporelle⟭.
⟬date#4⟭ 08:30 Mission d'expertise confiée à ⟬company#5⟭.
⟬date#4⟭ 08:31 Assistance prévenue, remorquage vers le garage ⟬trap:company_name|⦃Family⦄ Automobiles⟭.
⟬date#4⟭ 08:40 Courrier d'accusé de réception préparé pour "⟬fr_postal_address#2⟭".
⟬date#4⟭ 09:02 Note de ⟬person_name#1⟭: "l'assuré est encore hospitalisé, rappeler sa fille ⟬person_name#6f⟭ au ⟬phone#6⟭".
⟬date#4⟭ 10:15 Moteur de règles: score de fraude 8, aucun signal.
⟬date#4⟭ 10:16 ⟬trap:indicator_non_pii|gestionnaire=file-corporel⟭ reçoit le dossier.
⟬date#4⟭ 11:00 Prise en charge par ⟬person_name#7⟭, spécialiste des dommages corporels.
⟬date#4⟭ 14:30 Certificat médical reçu du Dr ⟬person_name#8⟭.
⟬date#4⟭ 14:31 Document ⟬uuid#1⟭ classé dans la pièce "médical", accès restreint.
⟬date#3⟭ 09:05 Rapport d'expertise déposé par ⟬company#5⟭, véhicule ⟬fr_license_plate#2⟭ économiquement irréparable.
⟬date#3⟭ 09:06 Valeur de remplacement estimée à 14 200 EUR.
⟬date#3⟭ 09:40 Offre envoyée à ⟬person_name#2⟭ par ⟬person_name#7⟭.
⟬date#3⟭ 10:12 Le tiers conteste sa responsabilité, assureur ⟬company#3⟭ saisi.
⟬date#3⟭ 11:30 Procès-verbal des forces de l'ordre demandé.
⟬date#3⟭ 15:02 Procès-verbal reçu: ⟬person_name#3⟭ a franchi un feu rouge, permis ⟬fr_driving_licence#3⟭.
⟬date#3⟭ 15:03 Responsabilité du tiers retenue à 100 %.
⟬date#3⟭ 15:10 Recours ouvert contre ⟬company#3⟭, référence ⟬uuid#2⟭.
⟬date#3⟭ 16:44 RIB reçu de ⟬person_name#2⟭: ⟬iban#2⟭.
⟬date#3⟭ 16:45 Moteur de règles: RIB nouveau, second regard requis.
⟬date#3⟭ 17:20 Second regard de ⟬person_name#9⟭: RIB confirmé par téléphone.
⟬date#2⟭ 08:45 Règlement de 14 200 EUR ordonné par ⟬person_name#7⟭.
⟬date#2⟭ 08:46 Virement ⟬uuid#3⟭ transmis à la banque.
⟬date#2⟭ 09:30 Rente provisoire étudiée, médecin-conseil ⟬person_name#10⟭ désigné.
⟬date#2⟭ 10:02 Rendez-vous d'expertise médicale fixé pour ⟬person_name#2⟭.
⟬date#2⟭ 10:03 Convocation envoyée à ⟬email#2⟭.
⟬date#2⟭ 11:18 ⟬person_name#2⟭ demande la copie de son dossier.
⟬date#2⟭ 11:19 Demande transmise au délégué à la protection des données ⟬email:generic#11⟭.
⟬date#2⟭ 14:00 Épave vendue à ⟬company#12⟭, SIRET ⟬fr_siret#12⟭.
⟬date#2⟭ 14:02 Certificat de cession pour ⟬fr_license_plate#2⟭ enregistré.
⟬date#2⟭ 16:30 Facture de remorquage ⟬invoice_number#1⟭ reçue de ⟬trap:company_name|⦃Family⦄ Automobiles⟭.
⟬date#2⟭ 16:31 Facture réglée sur ⟬iban#13⟭.
⟬date#1⟭ 09:00 Rapport du médecin-conseil reçu, consolidation non acquise.
⟬date#1⟭ 09:01 Provision complémentaire de 5 000 EUR proposée par ⟬person_name#7⟭.
⟬date#1⟭ 09:30 Validation de ⟬person_name#14⟭, responsable du service.
⟬date#1⟭ 09:31 Provision versée sur ⟬iban#2⟭.
⟬date#1⟭ 10:00 Recours: ⟬company#3⟭ accepte de rembourser 19 200 EUR.
⟬date#1⟭ 10:02 Encaissement attendu sous 30 jours, relance programmée.
⟬date#1⟭ 10:30 Note de ⟬person_name#7⟭: "⟬person_name#2⟭ a repris contact, moral meilleur".
⟬date#1⟭ 11:02 Nouveau véhicule ⟬fr_license_plate#15⟭ ajouté au contrat ⟬customer_id#2⟭.
⟬date#1⟭ 11:03 Conducteur principal inchangé, permis ⟬fr_driving_licence#2⟭.
⟬date#1⟭ 11:45 Avenant envoyé à ⟬email#2⟭.
⟬date#1⟭ 12:00 ⟬trap:indicator_non_pii|auteur=workflow⟭: dossier en surveillance pour 6 mois.
⟬date#1⟭ 13:30 Contrôle qualité par ⟬person_name#16⟭, aucune anomalie.
⟬date#1⟭ 13:31 ⟬trap:indicator_non_pii|auteur=controle-interne⟭: échantillon ⟬uuid#4⟭ clos.
⟬date#1⟭ 14:00 Archivage partiel des pièces dans ⟬file_path#1⟭.
⟬date#1⟭ 14:01 Empreinte des pièces archivées ⟬hash#1⟭.
⟬date#1⟭ 15:12 Rappel de la fille de l'assuré, ⟬person_name#6f⟭, sur l'avancement.
⟬date#1⟭ 15:40 Message laissé au témoin ⟬person_name#4⟭, désormais inutile, dossier mis à jour.
⟬date#1⟭ 16:00 Le tiers ⟬person_name#3⟭ écrit depuis ⟬email#3⟭ pour contester.
⟬date#1⟭ 16:02 Courrier transmis au service juridique, avocat ⟬person_name#17⟭.
⟬date#1⟭ 16:30 Réponse type envoyée à ⟬person_name#3⟭ par ⟬person_name#1⟭.
⟬date#1⟭ 17:00 Point d'équipe: dossier ⟬ticket_id#1⟭ présenté par ⟬trap:initials|C.G.⟭, sans décision nouvelle.
⟬date#1⟭ 17:15 Prochaine échéance fixée, relance automatique activée.
⟬date#1⟭ 17:16 ⟬trap:indicator_non_pii|auteur=workflow⟭: alerte programmée.
⟬date#1⟭ 17:30 Fin des opérations de la journée.
⟬date#1⟭ 17:31 Journal scellé, empreinte ⟬hash#2⟭.
⟬end⟭
