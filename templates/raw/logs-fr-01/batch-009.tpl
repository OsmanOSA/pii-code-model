⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: React Native console, inline JSON
scenario: Metro console of a pregnancy tracking mobile app in development, where a console.log shows the patient's login response
⟬text⟭
 BUNDLE  ./index.js

 LOG  Running "SuiviGrossesse" with {"rootTag":11}
 LOG  [connexion] reponse {"patiente":"⟬person_name#1f⟭","nir":"⟬fr_social_security_number#1⟭","naissance":"⟬birth_date#1⟭"}
 LOG  [connexion] sage-femme referente ⟬person_name#2f⟭
 WARN  Possible Unhandled Promise Rejection (id: 0):
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Kotlin coroutine exception, code identifier
scenario: timeout in a Kotlin coroutine of a merchant site's restocking, with no customer data
⟬text⟭
Exception in thread "DefaultDispatcher-worker-3" kotlinx.coroutines.TimeoutCancellationException: Timed out waiting for 3000 ms
	at kotlinx.coroutines.TimeoutKt.TimeoutCancellationException(Timeout.kt:184)
	at kotlinx.coroutines.TimeoutCoroutine.run(Timeout.kt:154)
	at fr.boutique.stock.⟬trap:code_identifier|Prevision⦃Family⦄⟭.calculer(⟬trap:code_identifier|Prevision⦃Family⦄⟭.kt:62)
	at fr.boutique.stock.Reappro$lancer$1.invokeSuspend(Reappro.kt:41)
	at kotlin.coroutines.jvm.internal.BaseContinuationImpl.resumeWith(ContinuationImpl.kt:33)
	Suppressed: kotlinx.coroutines.DiagnosticCoroutineContextException: [CoroutineName(reappro-nuit)]
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: insurance
appearance: Pest output, assertion message
scenario: Pest output of a PHP car quote calculator, whose failure shows the context string with the driver and plate
⟬text⟭
   FAIL  Tests\Unit\DevisTest
  ⨯ applique le bonus du conducteur
  ✓ refuse un vehicule inconnu

  ─────────────────────────────────────────────
   FAILED  Tests\Unit\DevisTest > applique le bonus du conducteur
  Failed asserting that "conducteur=⟬person_name#1⟭;plaque=⟬fr_license_plate#1⟭" contains "bonus=50".

  at tests/Unit/DevisTest.php:31

  Tests:    1 failed, 1 passed (2 assertions)
  Duration: 0.14s
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: BIND query log, hostnames
scenario: query log of an operator's internal DNS resolver, with radio sites named after places and no subscriber
⟬text⟭
⟬date#1⟭ 03:12:04 queries: info: client ⟬ip_address#1⟭ port 53124 (⟬hostname#1⟭): query: ⟬hostname#1⟭ IN A +E(0)K (⟬ip_address#2⟭)
⟬date#1⟭ 03:12:05 queries: info: client ⟬ip_address#3⟭ port 41220 (⟬trap:word_name|rose⟭-bts12.ran.interne): query: ⟬trap:word_name|rose⟭-bts12.ran.interne IN AAAA +E(0)K (⟬ip_address#2⟭)
⟬date#1⟭ 03:12:05 queries: info: client ⟬ip_address#4⟭ port 40118 (_sip._udp.ims.interne): query: _sip._udp.ims.interne IN SRV +E(0)K (⟬ip_address#2⟭)
⟬date#1⟭ 03:12:07 queries: info: client ⟬ip_address#3⟭ port 41222 (⟬trap:word_name|paris⟭-bts03.ran.interne): query: ⟬trap:word_name|paris⟭-bts03.ran.interne IN A +E(0)K (⟬ip_address#2⟭)
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: sentry-cli output, DSN, publishable key
scenario: Sentry release step of a shop front end, showing the auth token and the DSN next to a harmless Stripe publishable key
⟬text⟭
$ sentry-cli --auth-token ⟬opaque_token#1⟭ releases new ⟬version#1⟭
Created release ⟬version#1⟭
$ sentry-cli releases set-commits --auto ⟬version#1⟭
+ Commit ⟬git_sha#1⟭ de ⟬person_name#2⟭
$ echo "SENTRY_DSN=https://⟬opaque_token#2⟭@sentry.boutique.interne/12"
SENTRY_DSN=https://⟬opaque_token#2⟭@sentry.boutique.interne/12
$ echo "NEXT_PUBLIC_STRIPE=⟬stripe_publishable_key#1⟭"
NEXT_PUBLIC_STRIPE=⟬stripe_publishable_key#1⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: key=value, quoted value
scenario: trace of a city's resident parking service, recording permits granted with plate and applicant
⟬text⟭
⟬date#1⟭ 11:20:03 STATIONNEMENT agent=⟬person_name:handle#1⟭ action=OCTROI carte=⟬customer_id#2⟭ plaque=⟬fr_license_plate#2⟭ demandeur="⟬person_name#2⟭"
⟬date#1⟭ 11:24:40 STATIONNEMENT agent=⟬person_name:handle#1⟭ action=REFUS motif="véhicule de société" plaque=⟬fr_license_plate#3⟭
⟬date#1⟭ 11:30:00 STATIONNEMENT agent=⟬trap:indicator_non_pii|tache-expirations⟭ action=EXPIRATION cartes=12
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: banking
appearance: java.util.logging two-line format, plain sentences, tax number
scenario: JUL log of a bank's credit decision engine, where each event spans two lines and cites the borrower, income and tax number
⟬text⟭
⟬date#1⟭ 09:14:02 fr.banque.credit.Moteur evaluer
INFOS: demande ⟬uuid#1⟭ de ⟬person_name#2⟭, ⟬age#2⟭ ans, ⟬job_title#2⟭
⟬date#1⟭ 09:14:02 fr.banque.credit.Fichiers consulter
INFOS: consultation du fichier des incidents pour ⟬person_name#2f⟭ née le ⟬birth_date#2⟭
⟬date#1⟭ 09:14:03 fr.banque.credit.Fichiers consulter
INFOS: aucun incident enregistré
⟬date#1⟭ 09:14:03 fr.banque.credit.Revenus lire
INFOS: numéro fiscal ⟬fr_tax_number#2⟭, revenu de référence 41 200 EUR
⟬date#1⟭ 09:14:04 fr.banque.credit.Moteur evaluer
AVERTISSEMENT: taux d'endettement 36 %, dérogation requise
⟬date#1⟭ 09:14:04 fr.banque.credit.Workflow affecter
INFOS: dossier confié à ⟬person_name:given#3⟭, agence ⟬city#3⟭
⟬date#1⟭ 09:20:11 fr.banque.credit.Moteur evaluer
INFOS: demande ⟬uuid#4⟭ de ⟬company#4⟭, SIREN ⟬fr_siren#4⟭, gérant ⟬person_name#4⟭
⟬date#1⟭ 09:20:12 fr.banque.credit.Fichiers consulter
GRAVE: service indisponible, ⟬trap:indicator_non_pii|user=svc-credit⟭ refusé par ⟬hostname#1⟭
⟬date#1⟭ 09:20:13 fr.banque.credit.Workflow affecter
INFOS: dossier ⟬uuid#4⟭ remis en file
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: banking
appearance: SOAP fault, XML request dump, Python traceback
scenario: SOAP error of an interbank payment connector, whose client module reprints the whole envelope with account, IBAN and holder
⟬text⟭
Traceback (most recent call last):
  File "/opt/connecteur/virements.py", line 77, in emettre
    reponse = service.EmettreVirement(ordre=ordre)
  File "/opt/connecteur/.venv/lib/python3.11/site-packages/zeep/proxy.py", line 46, in __call__
    return self._proxy._binding.send(self._proxy._client, self._proxy._binding_options, self._op_name, args, kwargs)
  File "/opt/connecteur/.venv/lib/python3.11/site-packages/zeep/wsdl/bindings/soap.py", line 329, in process_error
    raise Fault(message=message, code=code, actor=None, detail=detail)
zeep.exceptions.Fault: Compte bénéficiaire clôturé

Enveloppe envoyée:
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
  <soapenv:Body>
    <EmettreVirement>
      <donneur>
        <nom><![CDATA[⟬company#1⟭]]></nom>
        <compte>⟬bank_account_number#1⟭</compte>
      </donneur>
      <beneficiaire>
        <nom>⟬person_name#2⟭</nom>
        <iban>⟬iban#2⟭</iban>
        <bic>⟬bic#2⟭</bic>
      </beneficiaire>
      <montant devise="EUR">1840.00</montant>
    </EmettreVirement>
  </soapenv:Body>
</soapenv:Envelope>
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: telecom
appearance: nginx error log, Lua traceback, request line
scenario: Lua errors of an operator's OpenResty gateway, whose nginx lines repeat the request with its JWT and app token
⟬text⟭
⟬date#1⟭ 12:41:02 [error] 2210#2210: *8812 lua entry thread aborted: runtime error: /etc/nginx/lua/auth.lua:41: attempt to index local 'charge' (a nil value)
stack traceback:
coroutine 0:
	/etc/nginx/lua/auth.lua: in function 'verifier'
	/etc/nginx/lua/acces.lua:18: in main chunk, client: ⟬ip_address#1⟭, server: api-selfcare, request: "GET /v2/lignes?token=⟬jwt#1⟭ HTTP/1.1", host: "⟬hostname#1⟭"
⟬date#1⟭ 12:41:05 [error] 2210#2210: *8815 lua entry thread aborted: runtime error: /etc/nginx/lua/auth.lua:41: attempt to index local 'charge' (a nil value)
stack traceback:
coroutine 0:
	/etc/nginx/lua/auth.lua: in function 'verifier'
	/etc/nginx/lua/acces.lua:18: in main chunk, client: ⟬ip_address#2⟭, server: api-selfcare, request: "POST /v2/recharge?app=⟬opaque_token#1⟭ HTTP/1.1", host: "⟬hostname#1⟭"
⟬date#1⟭ 12:41:09 [warn] 2210#2210: *8820 [lua] limite.lua:27: quota atteint pour ⟬person_name:handle#3⟭, client: ⟬ip_address#3⟭, server: api-selfcare, request: "GET /v2/conso HTTP/1.1", host: "⟬hostname#1⟭"
⟬date#1⟭ 12:41:12 [error] 2210#2210: *8822 connect() failed (111: Connection refused) while connecting to upstream, client: ⟬ip_address#4⟭, server: api-selfcare, request: "GET /v2/factures HTTP/1.1", upstream: "http://⟬hostname#2⟭:8080/factures", host: "⟬hostname#1⟭"
⟬date#1⟭ 12:41:13 [error] 2210#2210: *8824 lua entry thread aborted: runtime error: /etc/nginx/lua/journal.lua:12: bad argument #1 to 'encode'
stack traceback:
coroutine 0:
	[C]: in function 'encode'
	/etc/nginx/lua/journal.lua:12: in function 'ecrire'
	/etc/nginx/lua/acces.lua:31: in main chunk, client: ⟬ip_address#5⟭, server: api-selfcare, request: "POST /v2/sim/activer HTTP/1.1", host: "⟬hostname#1⟭"
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: Ginkgo output, Gomega matcher, test fixture
scenario: Ginkgo output of a Go admission service, whose failure compares two test patients' identities with NIR and birth date
⟬text⟭
Running Suite: Admission Suite - /src/admission
===============================================
Random Seed: 1712023443

Will run 12 of 12 specs
••••••
------------------------------
• [FAILED] [0.012 seconds]
Admission quand le NIR est connu [It] rattache la patiente au dossier existant
/src/admission/admission_test.go:41

  [FAILED] Expected
      <string>: ⟬person_name#1f⟭, née le ⟬birth_date#1⟭, NIR ⟬fr_social_security_number#1⟭
  to equal
      <string>: ⟬person_name#2f⟭, née le ⟬birth_date#2⟭, NIR ⟬fr_social_security_number#2⟭
  In [It] at: /src/admission/admission_test.go:48
------------------------------
•••••

Summarizing 1 Failure:
  [FAIL] Admission quand le NIR est connu [It] rattache la patiente au dossier existant
  /src/admission/admission_test.go:48

Ran 12 of 12 Specs in 0.081 seconds
FAIL! -- 11 Passed | 1 Failed | 0 Pending | 0 Skipped
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: public administration
appearance: pa11y output, HTML selector, form field names
scenario: pa11y accessibility report of a birth certificate request form, citing the form's empty fields with no value
⟬text⟭
Welcome to Pa11y

 > Running Pa11y on URL ⟬url#1⟭

Results for URL: ⟬url#1⟭

 • Error: This form field should be labelled in some way.
   ├── WCAG2AA.Principle1.Guideline1_3.1_3_1.F68
   ├── #form > div:nth-child(2) > input
   └── <input type="text" name="⟬trap:indicator_non_pii|nom_de_naissance⟭" value="">

 • Error: This form field should be labelled in some way.
   ├── WCAG2AA.Principle1.Guideline1_3.1_3_1.F68
   ├── #form > div:nth-child(3) > input
   └── <input type="text" name="⟬trap:indicator_non_pii|date_de_naissance⟭" placeholder="⟬trap:indicator_non_pii|JJ/MM/AAAA⟭">

 • Warning: Img element is missing an alt attribute.
   ├── WCAG2AA.Principle1.Guideline1_1.1_1_1.H37
   ├── #entete > img
   └── <img src="/images/⟬trap:word_name|marianne⟭.svg">

2 Errors
1 Warnings
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: banking
appearance: key=value access line, HTTP header, secret under an innocuous key
scenario: access lines of an F5 load balancer in front of a payment API, as key=value, copying the client reference header, sometimes a secret and sometimes a plain number
⟬text⟭
ts="⟬date#1⟭ 09:01:12" src=⟬ip_address#1⟭ m=POST uri=/paiements st=201 rt=212 tls=1.3 x_client_ref=⟬opaque_token#1⟭ x_compte="⟬iban#2⟭"
ts="⟬date#1⟭ 09:01:15" src=⟬ip_address#1⟭ m=GET uri=/paiements/⟬uuid#1⟭ st=200 rt=41 tls=1.3 x_client_ref=⟬opaque_token#1⟭ x_compte="-"
ts="⟬date#1⟭ 09:01:31" src=⟬ip_address#2⟭ m=POST uri=/paiements st=201 rt=198 tls=1.3 x_client_ref=⟬order_number#3⟭ x_compte="⟬iban#3⟭"
ts="⟬date#1⟭ 09:01:40" src=⟬ip_address#3⟭ m=GET uri=/sante st=200 rt=1 tls=1.2 x_client_ref=- x_compte="-"
ts="⟬date#1⟭ 09:02:02" src=⟬ip_address#4⟭ m=POST uri=/oauth/token st=200 rt=88 tls=1.3 x_client_ref=⟬opaque_token#4⟭ x_compte="-"
ts="⟬date#1⟭ 09:02:03" src=⟬ip_address#4⟭ m=POST uri=/oauth/token st=401 rt=12 tls=1.3 x_client_ref=⟬trap:placeholder|********⟭ x_compte="-"
ts="⟬date#1⟭ 09:02:18" src=⟬ip_address#5⟭ m=POST uri=/paiements st=422 rt=61 tls=1.3 x_client_ref=⟬uuid#2⟭ x_compte="⟬iban#5⟭"
ts="⟬date#1⟭ 09:02:40" src=⟬ip_address#3⟭ m=GET uri=/sante st=200 rt=1 tls=1.2 x_client_ref=- x_compte="-"
ts="⟬date#1⟭ 09:02:55" src=⟬ip_address#6⟭ m=GET uri=/cartes/plafonds st=200 rt=74 tls=1.3 x_client_ref=⟬jwt#6⟭ x_compte="-"
ts="⟬date#1⟭ 09:03:12" src=⟬ip_address#6⟭ m=POST uri=/cartes/opposition st=202 rt=142 tls=1.3 x_client_ref=⟬jwt#6⟭ x_compte="⟬payment_card#6⟭"
ts="⟬date#1⟭ 09:03:40" src=⟬ip_address#3⟭ m=GET uri=/sante st=200 rt=1 tls=1.2 x_client_ref=- x_compte="-"
ts="⟬date#1⟭ 09:04:01" src=⟬ip_address#7⟭ m=POST uri=/prelevements st=201 rt=231 tls=1.3 x_client_ref=⟬customer_id#7⟭ x_compte="⟬iban#7⟭"
ts="⟬date#1⟭ 09:04:30" src=⟬ip_address#7⟭ m=GET uri=/prelevements/⟬uuid#3⟭ st=200 rt=38 tls=1.3 x_client_ref=⟬customer_id#7⟭ x_compte="-"
ts="⟬date#1⟭ 09:04:40" src=⟬ip_address#3⟭ m=GET uri=/sante st=200 rt=1 tls=1.2 x_client_ref=- x_compte="-"
ts="⟬date#1⟭ 09:05:02" src=⟬ip_address#8⟭ m=POST uri=/paiements st=503 rt=3001 tls=1.3 x_client_ref=⟬opaque_token#8⟭ x_compte="⟬iban#8⟭"
ts="⟬date#1⟭ 09:05:03" src=⟬ip_address#8⟭ m=POST uri=/paiements st=201 rt=204 tls=1.3 x_client_ref=⟬opaque_token#8⟭ x_compte="⟬iban#8⟭"
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: uvicorn access log, query string, email in a query string
scenario: uvicorn access of a policyholder area API, whose email sign-in links keep the address and a token in the URL
⟬text⟭
INFO:     Started server process [2210]
INFO:     Application startup complete.
INFO:     ⟬ip_address#1⟭ - "GET /sante HTTP/1.1" 200 OK
INFO:     ⟬ip_address#2⟭ - "POST /connexion/lien?email=⟬email#2⟭ HTTP/1.1" 202 Accepted
INFO:     ⟬ip_address#2⟭ - "GET /connexion/valider?email=⟬email#2⟭&token=⟬opaque_token#2⟭ HTTP/1.1" 302 Found
INFO:     ⟬ip_address#2⟭ - "GET /contrats?police=⟬customer_id#2⟭ HTTP/1.1" 200 OK
INFO:     ⟬ip_address#2⟭ - "GET /contrats/⟬uuid#1⟭/attestation?jeton=⟬jwt#2⟭ HTTP/1.1" 200 OK
INFO:     ⟬ip_address#3⟭ - "POST /connexion/lien?email=⟬email#3⟭ HTTP/1.1" 202 Accepted
INFO:     ⟬ip_address#3⟭ - "GET /connexion/valider?email=⟬email#3⟭&token=⟬opaque_token#3⟭ HTTP/1.1" 410 Gone
INFO:     ⟬ip_address#3⟭ - "POST /connexion/lien?email=⟬email#3⟭ HTTP/1.1" 202 Accepted
INFO:     ⟬ip_address#3⟭ - "GET /connexion/valider?email=⟬email#3⟭&token=⟬opaque_token#4⟭ HTTP/1.1" 302 Found
INFO:     ⟬ip_address#3⟭ - "GET /sinistres?statut=ouverts HTTP/1.1" 200 OK
INFO:     ⟬ip_address#4⟭ - "GET /docs HTTP/1.1" 200 OK
INFO:     ⟬ip_address#4⟭ - "GET /openapi.json HTTP/1.1" 200 OK
INFO:     ⟬ip_address#1⟭ - "GET /sante HTTP/1.1" 200 OK
INFO:     ⟬ip_address#5⟭ - "POST /connexion/lien?⟬trap:indicator_non_pii|email=exemple⟭ HTTP/1.1" 422 Unprocessable Entity
INFO:     ⟬ip_address#1⟭ - "GET /sante HTTP/1.1" 200 OK
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: Bitbucket Pipelines output, git remote with a password, settings.xml, smoke test
scenario: Bitbucket pipeline of a subscription tool, pushing a tag with the password in the URL and showing Maven credentials and a smoke test driver
⟬text⟭
+ umask 000
+ git clone --branch="main" --depth 50 ⟬url#1⟭ $BUILD_DIR
Cloning into '/opt/atlassian/pipelines/agent/build'...
+ cat ~/.m2/settings.xml
<settings>
  <servers>
    <server>
      <id>nexus-assurance</id>
      <username>⟬trap:indicator_non_pii|ci-souscription⟭</username>
      <password><![CDATA[⟬password#1⟭]]></password>
    </server>
  </servers>
</settings>
+ mvn -B deploy -DskipTests
[INFO] Uploaded to nexus-assurance: ⟬url#2⟭ (41 MB at 12 MB/s)
+ git tag ⟬version#1⟭
+ git push https://x-token-auth:⟬url_password#1⟭@bitbucket.org/assurance-exemple/souscription.git ⟬version#1⟭
 * [new tag]         ⟬version#1⟭ -> ⟬version#1⟭
+ ./ci/test_fumee.sh
devis de fumee pour ⟬fr_license_plate#2⟭, permis ⟬fr_driving_licence#2⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: git server audit, bot accounts, key=value
scenario: audit log of a merchant site's Git server, whose events come from dependency bots and teams, with no named person
⟬text⟭
[audit] ⟬date#1⟭ 04:00:02 repo=boutique/front action=push ⟬trap:indicator_non_pii|actor=renovate[bot]⟭ ref=refs/heads/renovate/next sha=⟬git_sha#1⟭
[audit] ⟬date#1⟭ 04:00:05 repo=boutique/front action=pr.open ⟬trap:indicator_non_pii|actor=renovate[bot]⟭ pr=⟬ticket_id#1⟭
[audit] ⟬date#1⟭ 04:02:11 repo=boutique/front action=check.pass ⟬trap:indicator_non_pii|actor=ci-runner⟭ sha=⟬git_sha#1⟭
[audit] ⟬date#1⟭ 04:02:30 repo=boutique/front action=pr.merge ⟬trap:indicator_non_pii|actor=automerge-bot⟭ pr=⟬ticket_id#1⟭
[audit] ⟬date#1⟭ 04:10:02 repo=boutique/paiement action=push ⟬trap:indicator_non_pii|actor=dependabot[bot]⟭ ref=refs/heads/dependabot/npm/⟬trap:email_lookalike|@stripe/stripe-js⟭ sha=⟬git_sha#2⟭
[audit] ⟬date#1⟭ 04:10:06 repo=boutique/paiement action=pr.open ⟬trap:indicator_non_pii|actor=dependabot[bot]⟭ pr=⟬ticket_id#2⟭
[audit] ⟬date#1⟭ 04:12:40 repo=boutique/paiement action=check.fail ⟬trap:indicator_non_pii|actor=ci-runner⟭ sha=⟬git_sha#2⟭
[audit] ⟬date#1⟭ 04:30:00 org=boutique action=token.rotate ⟬trap:indicator_non_pii|actor=rotation-cles⟭ key_id=⟬hash#1⟭
[audit] ⟬date#1⟭ 04:30:12 org=boutique action=team.sync ⟬trap:indicator_non_pii|actor=idp-sync⟭ equipe=paiements membres=8
[audit] ⟬date#1⟭ 04:30:13 org=boutique action=team.sync ⟬trap:indicator_non_pii|actor=idp-sync⟭ equipe=front membres=12
[audit] ⟬date#1⟭ 05:00:00 repo=boutique/infra action=branch.protect ⟬trap:indicator_non_pii|actor=terraform-github⟭ branche=main
[audit] ⟬date#1⟭ 05:00:04 repo=boutique/infra action=secret.update ⟬trap:indicator_non_pii|actor=terraform-github⟭ nom=⟬trap:indicator_non_pii|DEPLOY_TOKEN⟭
[audit] ⟬date#1⟭ 05:10:11 repo=boutique/docs action=wiki.update ⟬trap:indicator_non_pii|actor=equipe-support⟭ page=procedures
[audit] ⟬date#1⟭ 05:30:00 repo=boutique/front action=release.publish ⟬trap:indicator_non_pii|actor=release-bot⟭ version=⟬version#1⟭
[audit] ⟬date#1⟭ 05:30:02 repo=boutique/front action=artifact.upload ⟬trap:indicator_non_pii|actor=release-bot⟭ empreinte=⟬hash#2⟭
[audit] ⟬date#1⟭ 06:00:00 org=boutique action=audit.export ⟬trap:indicator_non_pii|actor=siem-collecteur⟭ cible=⟬url#1⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: pipe-aligned table, gendered names, consent register
scenario: tabular consent register of a clinical research centre, where each line says who collected whose agreement
⟬text⟭
| date       | heure | participant                 | nir                           | etude | action   | recueilli par            |
|------------|-------|-----------------------------|-------------------------------|-------|----------|--------------------------|
| ⟬date#1⟭ | 09:12 | ⟬person_name#1⟭ | ⟬fr_social_security_number#1⟭ | ONCO-4 | ACCORD   | Dr ⟬person_name#2⟭ |
| ⟬date#1⟭ | 09:40 | ⟬person_name#3⟭ | ⟬fr_social_security_number#3⟭ | ONCO-4 | ACCORD   | Dr ⟬person_name#2⟭ |
| ⟬date#1⟭ | 10:05 | ⟬person_name#4⟭ | ⟬fr_social_security_number#4⟭ | ONCO-4 | REFUS    | ⟬person_name#5⟭ |
| ⟬date#1⟭ | 10:31 | Mme ⟬person_name#6f⟭ | ⟬fr_social_security_number#6⟭ | CARDIO-2 | ACCORD | ⟬person_name#5⟭ |
| ⟬date#1⟭ | 11:02 | M. ⟬person_name#7m⟭ | ⟬fr_social_security_number#7⟭ | CARDIO-2 | RETRAIT | ⟬trap:indicator_non_pii|portail-patient⟭ |
| ⟬date#1⟭ | 11:30 | ⟬trap:indicator_non_pii|anonymise⟭ | ⟬trap:indicator_non_pii|masque⟭ | ONCO-4 | ACCORD | ⟬trap:indicator_non_pii|import-centre-3⟭ |
| ⟬date#1⟭ | 14:12 | ⟬person_name#8⟭ | ⟬fr_social_security_number#8⟭ | NEURO-1 | ACCORD   | Dr ⟬person_name#9⟭ |
| ⟬date#1⟭ | 14:44 | ⟬person_name#10⟭ | ⟬fr_social_security_number#10⟭ | NEURO-1 | ACCORD   | Dr ⟬person_name#9⟭ |
| ⟬date#1⟭ | 15:20 | ⟬person_name#11⟭ | ⟬fr_social_security_number#11⟭ | NEURO-1 | REFUS    | Dr ⟬person_name#9⟭ |
Représentante légale pour ⟬person_name#10⟭: ⟬person_name#12f⟭, née le ⟬birth_date#12⟭, joignable au ⟬phone#12⟭.
Lignes signées électroniquement par ⟬person_name:initial#2⟭, empreinte ⟬hash#1⟭.
Registre exporté dans ⟬file_path#1⟭ par ⟬trap:indicator_non_pii|responsable=attache-recherche⟭.
Contrôle du comité le ⟬date#2⟭, sans remarque.
Dernier audit qualité: ⟬ticket_id#1⟭.
Copie envoyée à ⟬email:generic#13⟭.
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: chatbot transcript, informal message, plain sentences, email in a sentence, value without a key
scenario: chatbot log of a shop's customer service, keeping customers' words verbatim, with names, addresses and cards dropped unannounced
⟬text⟭
⟬date#1⟭ 18:02:04 session=⟬uuid#1⟭ bot    Bonjour, je suis ⟬trap:eponym|⦃Given⦄⟭, votre assistant. Comment puis-je vous aider ?
⟬date#1⟭ 18:02:31 session=⟬uuid#1⟭ client slt jai pas recu ma commande ⟬order_number#2⟭ depuis lundi
⟬date#1⟭ 18:02:33 session=⟬uuid#1⟭ intent suivi_colis confiance=0.93
⟬date#1⟭ 18:02:34 session=⟬uuid#1⟭ bot    Je regarde cela. Pouvez-vous me confirmer votre nom ?
⟬date#1⟭ 18:02:58 session=⟬uuid#1⟭ client ⟬person_name#2⟭ et je suis au ⟬fr_postal_address#2⟭ normalement
⟬date#1⟭ 18:03:00 session=⟬uuid#1⟭ action transporteur.statut colis=⟬uuid#2⟭
⟬date#1⟭ 18:03:02 session=⟬uuid#1⟭ bot    Votre colis est en point relais depuis hier.
⟬date#1⟭ 18:03:20 session=⟬uuid#1⟭ client ah ok ma femme ⟬person_name#3f⟭ peut le chercher ?
⟬date#1⟭ 18:03:22 session=⟬uuid#1⟭ bot    Oui, avec une pièce d'identité et le code reçu par SMS.
⟬date#1⟭ 18:03:41 session=⟬uuid#1⟭ client envoyez le plutot au ⟬phone#3⟭ svp
⟬date#1⟭ 18:03:43 session=⟬uuid#1⟭ action client.maj_telephone statut=refus
⟬date#1⟭ 18:03:44 session=⟬uuid#1⟭ bot    Je ne peux pas modifier ce numéro, je transmets à un conseiller.
⟬date#1⟭ 18:03:46 session=⟬uuid#1⟭ transfert conseiller=⟬person_name:given#4⟭
⟬date#1⟭ 18:05:10 session=⟬uuid#3⟭ bot    Bonjour, je suis ⟬trap:eponym|⦃Given⦄⟭, votre assistant. Comment puis-je vous aider ?
⟬date#1⟭ 18:05:32 session=⟬uuid#3⟭ client je veux changer ma carte, la nouvelle c ⟬payment_card#5⟭ exp 04/28
⟬date#1⟭ 18:05:33 session=⟬uuid#3⟭ intent paiement_maj confiance=0.88
⟬date#1⟭ 18:05:34 session=⟬uuid#3⟭ bot    Par sécurité, ne saisissez jamais votre carte ici. Utilisez votre espace client.
⟬date#1⟭ 18:05:50 session=⟬uuid#3⟭ client ok mon mdp marche plus, c ⟬password#5⟭ je crois
⟬date#1⟭ 18:05:52 session=⟬uuid#3⟭ bot    Je vous envoie un lien de réinitialisation. Quelle est votre adresse ?
⟬date#1⟭ 18:06:10 session=⟬uuid#3⟭ client ⟬email#5⟭
⟬date#1⟭ 18:06:11 session=⟬uuid#3⟭ action compte.lien_reinit token=⟬opaque_token#5⟭
⟬date#1⟭ 18:06:12 session=⟬uuid#3⟭ bot    C'est envoyé. Autre chose ?
⟬date#1⟭ 18:06:20 session=⟬uuid#3⟭ client non merci bonne soirée
⟬date#1⟭ 18:09:01 session=⟬uuid#4⟭ bot    Bonjour, je suis ⟬trap:eponym|⦃Given⦄⟭, votre assistant. Comment puis-je vous aider ?
⟬date#1⟭ 18:09:18 session=⟬uuid#4⟭ client Bonjour je cherche le parfum ⟬trap:word_name|Rose⟭ de ⟬trap:company_name|⦃Family⦄ Parfums⟭
⟬date#1⟭ 18:09:19 session=⟬uuid#4⟭ intent recherche_produit confiance=0.97
⟬date#1⟭ 18:09:20 session=⟬uuid#4⟭ bot    Il est disponible en 50 et 100 ml.
⟬date#1⟭ 18:09:44 session=⟬uuid#4⟭ client et vous livrez à ⟬city#6⟭ ?
⟬date#1⟭ 18:09:45 session=⟬uuid#4⟭ bot    Oui, en 48 h, ou en point relais ⟬trap:word_name|rue Pasteur⟭.
⟬date#1⟭ 18:10:02 session=⟬uuid#4⟭ client super merci
⟬date#1⟭ 18:12:40 session=⟬uuid#5⟭ bot    Bonjour, je suis ⟬trap:eponym|⦃Given⦄⟭, votre assistant. Comment puis-je vous aider ?
⟬date#1⟭ 18:12:59 session=⟬uuid#5⟭ client je veux etre rembourse sur mon compte ⟬iban#7⟭
⟬date#1⟭ 18:13:01 session=⟬uuid#5⟭ intent remboursement confiance=0.91
⟬date#1⟭ 18:13:02 session=⟬uuid#5⟭ bot    Quel est votre numéro de commande ?
⟬date#1⟭ 18:13:15 session=⟬uuid#5⟭ client ⟬order_number#7⟭
⟬date#1⟭ 18:13:16 session=⟬uuid#5⟭ action commande.lire ref=⟬order_number#7⟭ client=⟬customer_id#7⟭
⟬date#1⟭ 18:13:18 session=⟬uuid#5⟭ bot    Votre remboursement de 34,90 EUR part sous 5 jours.
⟬date#1⟭ 18:13:30 session=⟬uuid#5⟭ client merci, c'est pour ma mère ⟬person_name#8f⟭ en fait, elle est née le ⟬birth_date#8⟭ si besoin
⟬date#1⟭ 18:13:31 session=⟬uuid#5⟭ bot    Ce n'est pas nécessaire, merci. Bonne soirée.
⟬date#1⟭ 18:15:05 session=⟬uuid#6⟭ bot    Bonjour, je suis ⟬trap:eponym|⦃Given⦄⟭, votre assistant. Comment puis-je vous aider ?
⟬date#1⟭ 18:15:21 session=⟬uuid#6⟭ client vous etes un humain ?
⟬date#1⟭ 18:15:22 session=⟬uuid#6⟭ intent hors_sujet confiance=0.76
⟬date#1⟭ 18:15:23 session=⟬uuid#6⟭ bot    Je suis un assistant automatique. Puis-je vous aider sur une commande ?
⟬date#1⟭ 18:15:40 session=⟬uuid#6⟭ client non juste curieux
⟬date#1⟭ 18:18:12 session=⟬uuid#7⟭ bot    Bonjour, je suis ⟬trap:eponym|⦃Given⦄⟭, votre assistant. Comment puis-je vous aider ?
⟬date#1⟭ 18:18:30 session=⟬uuid#7⟭ client bonjour c ⟬person_name#9⟭ de la société ⟬company#9⟭, siret ⟬fr_siret#9⟭, je veux une facture pro
⟬date#1⟭ 18:18:32 session=⟬uuid#7⟭ intent facture_pro confiance=0.89
⟬date#1⟭ 18:18:33 session=⟬uuid#7⟭ action facture.generer ref=⟬invoice_number#9⟭
⟬date#1⟭ 18:18:34 session=⟬uuid#7⟭ bot    Voici votre facture ⟬invoice_number#9⟭. Elle est aussi dans votre espace.
⟬date#1⟭ 18:18:50 session=⟬uuid#7⟭ client parfait, envoyez aussi a ⟬email:generic#10⟭
⟬date#1⟭ 18:18:52 session=⟬uuid#7⟭ action facture.envoyer statut=ok
⟬date#1⟭ 18:20:00 metriques sessions=7 transferts=1 satisfaction=4.2
⟬date#1⟭ 18:20:01 metriques ⟬trap:indicator_non_pii|client=inconnu⟭ pour 2 sessions
⟬date#1⟭ 18:25:00 systeme modele ⟬version#1⟭ chargé, ⟬trap:eponym|⦃Given⦄⟭ prêt
⟬date#1⟭ 18:30:00 metriques sessions=9 transferts=1 satisfaction=4.1
⟬date#1⟭ 18:35:00 systeme purge des sessions terminée
⟬date#1⟭ 18:40:00 metriques sessions=11 transferts=2 satisfaction=4.1
⟬date#1⟭ 18:45:00 systeme export des transcriptions vers ⟬hostname#1⟭
⟬date#1⟭ 18:50:00 metriques sessions=12 transferts=2 satisfaction=4.0
⟬date#1⟭ 18:55:00 systeme sonde modèle ok
⟬date#1⟭ 19:00:00 metriques sessions=14 transferts=2 satisfaction=4.0
⟬date#1⟭ 19:05:00 systeme sonde modèle ok
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Gatling console report, stats table
scenario: console report of a Gatling load test on an operator's top-up journey, with scenario identifiers and no subscriber
⟬text⟭
Simulation fr.operateur.charge.RechargeSimulation started...

================================================================================
⟬date#1⟭ 21:00:05                                           5s elapsed
---- Requests ------------------------------------------------------------------
> Global                                                   (OK=412    KO=0     )
> connexion                                                (OK=88     KO=0     )
> ⟬trap:indicator_non_pii|token_refresh⟭                                            (OK=40     KO=0     )
> lister_lignes                                            (OK=88     KO=0     )
> simuler_recharge                                         (OK=196    KO=0     )

---- Parcours recharge ---------------------------------------------------------
[#####-----------------------------------------------------------------]  7%
          waiting: 912    / active: 76     / done: 12
================================================================================

================================================================================
⟬date#1⟭ 21:00:10                                           10s elapsed
---- Requests ------------------------------------------------------------------
> Global                                                   (OK=1204   KO=2     )
> connexion                                                (OK=204    KO=0     )
> ⟬trap:indicator_non_pii|token_refresh⟭                                            (OK=112    KO=0     )
> lister_lignes                                            (OK=204    KO=0     )
> simuler_recharge                                         (OK=684    KO=2     )
---- Errors --------------------------------------------------------------------
> status.find.in(200,201), found 503                                  2 (100.0%)

---- Parcours recharge ---------------------------------------------------------
[################------------------------------------------------------] 22%
          waiting: 702    / active: 78     / done: 220
================================================================================

================================================================================
⟬date#1⟭ 21:00:15                                           15s elapsed
---- Requests ------------------------------------------------------------------
> Global                                                   (OK=2412   KO=9     )
> connexion                                                (OK=380    KO=0     )
> ⟬trap:indicator_non_pii|token_refresh⟭                                            (OK=240    KO=0     )
> lister_lignes                                            (OK=380    KO=1     )
> simuler_recharge                                         (OK=1412   KO=8     )
---- Errors --------------------------------------------------------------------
> status.find.in(200,201), found 503                                  9 (100.0%)

---- Parcours recharge ---------------------------------------------------------
[##################################------------------------------------] 48%
          waiting: 442    / active: 80     / done: 478
================================================================================

Simulation fr.operateur.charge.RechargeSimulation completed in 31 seconds
Parsing log file(s)...
Generating reports...

================================================================================
---- Global Information --------------------------------------------------------
> request count                                       4812 (OK=4790   KO=22    )
> min response time                                     12 (OK=12     KO=3001  )
> max response time                                   3004 (OK=1204   KO=3004  )
> mean response time                                   188 (OK=175    KO=3002  )
> std deviation                                        214 (OK=121    KO=1      )
> response time 95th percentile                        512 (OK=488    KO=3004  )
> mean requests/sec                                  155.2 (OK=154.5  KO=0.7   )
---- Response Time Distribution ------------------------------------------------
> t < 800 ms                                           4608 ( 96%)
> 800 ms <= t < 1200 ms                                 170 (  4%)
> t >= 1200 ms                                           12 (  0%)
> failed                                                 22 (  0%)
---- Errors --------------------------------------------------------------------
> status.find.in(200,201), found 503                                 22 (100.0%)
================================================================================

Reports generated in 1s.
Please open the following file: ⟬file_path#1⟭
Parametres: ⟬trap:indicator_non_pii|abonne=jeu-de-donnees-fictif⟭, ⟬trap:indicator_non_pii|msisdn=genere⟭, loi d'arrivée de ⟬trap:eponym|Poisson⟭
Lanceur: ⟬trap:library|Gatling⟭ ⟬version#1⟭ sur ⟬hostname#1⟭
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: combined log format, context field, query string, email in a query string
scenario: access of a commune's family portal for canteen and after-school care, with logged-in parents, benefit number, payment tokens and emails in links
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:30:02 +0100] "GET /famille/connexion HTTP/1.1" 200 4120 "-" "Mozilla/5.0 (iPhone)" ctx="-"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 07:30:21 +0100] "POST /famille/connexion HTTP/1.1" 302 0 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="-"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 07:30:22 +0100] "GET /famille/accueil HTTP/1.1" 200 8120 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="foyer=⟬customer_id#1⟭"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 07:30:40 +0100] "GET /famille/enfants HTTP/1.1" 200 2204 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="enfant=⟬person_name:given#2⟭"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 07:30:58 +0100] "GET /famille/cantine/reservations?semaine=12 HTTP/1.1" 200 3320 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="enfant=⟬person_name:given#2⟭"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 07:31:12 +0100] "POST /famille/cantine/reservations HTTP/1.1" 200 96 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="enfant=⟬person_name:given#2⟭;jours=4"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 07:31:40 +0100] "GET /famille/factures HTTP/1.1" 200 2204 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="foyer=⟬customer_id#1⟭"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 07:31:58 +0100] "GET /famille/paiement?facture=⟬invoice_number#1⟭&jeton=⟬jwt#1⟭ HTTP/1.1" 302 0 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="foyer=⟬customer_id#1⟭"
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:33:02 +0100] "GET /famille/retour-paiement?ref=⟬opaque_token#1⟭&statut=ok HTTP/1.1" 200 1204 "-" "Mozilla/5.0 (iPhone)" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:34:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 07:35:12 +0100] "GET /famille/mot-de-passe-oublie?email=⟬email#3⟭ HTTP/1.1" 200 1812 "-" "Mozilla/5.0 (Windows NT 10.0)" ctx="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 07:36:40 +0100] "GET /famille/reinitialiser?token=⟬opaque_token#3⟭&email=⟬email#3⟭ HTTP/1.1" 200 2204 "-" "Mozilla/5.0 (Windows NT 10.0)" ctx="-"
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 07:37:02 +0100] "POST /famille/reinitialiser HTTP/1.1" 302 0 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)" ctx="-"
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 07:37:03 +0100] "GET /famille/accueil HTTP/1.1" 200 8120 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)" ctx="foyer=⟬customer_id#3⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 07:37:40 +0100] "GET /famille/quotient HTTP/1.1" 200 1204 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)" ctx="allocataire=⟬customer_id#4⟭;nir=⟬fr_social_security_number#3⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 07:38:12 +0100] "POST /famille/quotient HTTP/1.1" 200 96 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)" ctx="fiscal=⟬fr_tax_number#3⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 07:38:50 +0100] "GET /famille/enfants HTTP/1.1" 200 2204 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)" ctx="enfant=⟬person_name:given#5⟭;classe=CE2"
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 07:39:30 +0100] "POST /famille/periscolaire/inscription HTTP/1.1" 201 96 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)" ctx="enfant=⟬person_name:given#5⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:40:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#4⟭ - ⟬person_name:handle#6⟭ [⟬date#1⟭ 07:41:18 +0100] "POST /famille/connexion HTTP/1.1" 401 88 "⟬url#1⟭" "Mozilla/5.0 (Android 14)" ctx="-"
⟬ip_address#4⟭ - ⟬person_name:handle#6⟭ [⟬date#1⟭ 07:41:44 +0100] "POST /famille/connexion HTTP/1.1" 302 0 "⟬url#1⟭" "Mozilla/5.0 (Android 14)" ctx="-"
⟬ip_address#4⟭ - ⟬person_name:handle#6⟭ [⟬date#1⟭ 07:41:45 +0100] "GET /famille/accueil HTTP/1.1" 200 8120 "⟬url#1⟭" "Mozilla/5.0 (Android 14)" ctx="foyer=⟬customer_id#6⟭"
⟬ip_address#4⟭ - ⟬person_name:handle#6⟭ [⟬date#1⟭ 07:42:10 +0100] "GET /famille/documents/justificatif-domicile.pdf HTTP/1.1" 200 412044 "⟬url#1⟭" "Mozilla/5.0 (Android 14)" ctx="foyer=⟬customer_id#6⟭"
⟬ip_address#4⟭ - ⟬person_name:handle#6⟭ [⟬date#1⟭ 07:42:50 +0100] "POST /famille/adresse HTTP/1.1" 200 96 "⟬url#1⟭" "Mozilla/5.0 (Android 14)" ctx="adresse=⟬fr_postal_address#6⟭"
⟬ip_address#4⟭ - ⟬person_name:handle#6⟭ [⟬date#1⟭ 07:43:30 +0100] "POST /famille/urgence HTTP/1.1" 200 96 "⟬url#1⟭" "Mozilla/5.0 (Android 14)" ctx="contact=⟬person_name#7⟭;tel=⟬phone#7⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:44:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#5⟭ - ⟬trap:indicator_non_pii|user-agent-mairie⟭ [⟬date#1⟭ 07:45:02 +0100] "GET /admin/pointage?ecole=⟬trap:word_name|jules-ferry⟭ HTTP/1.1" 200 4120 "-" "Mozilla/5.0 (Windows NT 10.0)" ctx="-"
⟬ip_address#5⟭ - ⟬trap:indicator_non_pii|user-agent-mairie⟭ [⟬date#1⟭ 07:45:40 +0100] "GET /admin/pointage?ecole=⟬trap:word_name|pierre-brossolette⟭ HTTP/1.1" 200 3920 "-" "Mozilla/5.0 (Windows NT 10.0)" ctx="-"
⟬ip_address#6⟭ - ⟬person_name:handle#8⟭ [⟬date#1⟭ 07:46:12 +0100] "GET /admin/connexion HTTP/1.1" 200 2204 "-" "Mozilla/5.0 (Macintosh)" ctx="-"
⟬ip_address#6⟭ - ⟬person_name:handle#8⟭ [⟬date#1⟭ 07:46:30 +0100] "POST /admin/connexion HTTP/1.1" 302 0 "⟬url#2⟭" "Mozilla/5.0 (Macintosh)" ctx="-"
⟬ip_address#6⟭ - ⟬person_name:handle#8⟭ [⟬date#1⟭ 07:46:50 +0100] "GET /admin/familles?recherche=⟬person_name:family#9⟭ HTTP/1.1" 200 2204 "⟬url#2⟭" "Mozilla/5.0 (Macintosh)" ctx="-"
⟬ip_address#6⟭ - ⟬person_name:handle#8⟭ [⟬date#1⟭ 07:47:15 +0100] "GET /admin/familles/⟬customer_id#9⟭ HTTP/1.1" 200 4120 "⟬url#2⟭" "Mozilla/5.0 (Macintosh)" ctx="foyer=⟬customer_id#9⟭"
⟬ip_address#6⟭ - ⟬person_name:handle#8⟭ [⟬date#1⟭ 07:47:50 +0100] "POST /admin/familles/⟬customer_id#9⟭/note HTTP/1.1" 200 96 "⟬url#2⟭" "Mozilla/5.0 (Macintosh)" ctx="auteur=⟬person_name:handle#8⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:48:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#7⟭ - - [⟬date#1⟭ 07:49:02 +0100] "GET /famille/menus?semaine=12 HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (X11; Linux x86_64)" ctx="-"
⟬ip_address#7⟭ - - [⟬date#1⟭ 07:49:30 +0100] "GET /famille/menus/allergenes.pdf HTTP/1.1" 200 212044 "⟬url#1⟭" "Mozilla/5.0 (X11; Linux x86_64)" ctx="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 07:50:12 +0100] "GET /robots.txt HTTP/1.1" 200 64 "-" "Mozilla/5.0 (compatible; Qwantbot/1.0)" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:52:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#9⟭ - ⟬person_name:handle#10⟭ [⟬date#1⟭ 07:53:14 +0100] "POST /famille/connexion HTTP/1.1" 302 0 "⟬url#1⟭" "Mozilla/5.0 (iPad)" ctx="-"
⟬ip_address#9⟭ - ⟬person_name:handle#10⟭ [⟬date#1⟭ 07:53:15 +0100] "GET /famille/accueil HTTP/1.1" 200 8120 "⟬url#1⟭" "Mozilla/5.0 (iPad)" ctx="foyer=⟬customer_id#10⟭"
⟬ip_address#9⟭ - ⟬person_name:handle#10⟭ [⟬date#1⟭ 07:53:50 +0100] "GET /famille/cantine/absences HTTP/1.1" 200 1204 "⟬url#1⟭" "Mozilla/5.0 (iPad)" ctx="enfant=⟬person_name:given#11⟭"
⟬ip_address#9⟭ - ⟬person_name:handle#10⟭ [⟬date#1⟭ 07:54:12 +0100] "POST /famille/cantine/absences HTTP/1.1" 200 96 "⟬url#1⟭" "Mozilla/5.0 (iPad)" ctx="enfant=⟬person_name:given#11⟭;motif=maladie"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:56:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 07:57:02 +0100] "GET /.env HTTP/1.1" 404 153 "-" "curl/8.4.0" ctx="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 07:57:03 +0100] "GET /admin/export.csv HTTP/1.1" 401 88 "-" "curl/8.4.0" ctx="-"
⟬ip_address#11⟭ - ⟬trap:indicator_non_pii|user-batch-factures⟭ [⟬date#1⟭ 07:58:00 +0100] "POST /admin/api/facturation HTTP/1.1" 202 64 "-" "python-requests/2.31.0" ctx="lot=⟬uuid#1⟭"
⟬ip_address#11⟭ - ⟬trap:indicator_non_pii|user-batch-factures⟭ [⟬date#1⟭ 07:59:12 +0100] "GET /admin/api/facturation/etat HTTP/1.1" 200 96 "-" "python-requests/2.31.0" ctx="lot=⟬uuid#1⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:00:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#12⟭ - ⟬person_name:handle#12⟭ [⟬date#1⟭ 08:01:30 +0100] "POST /famille/connexion HTTP/1.1" 302 0 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="-"
⟬ip_address#12⟭ - ⟬person_name:handle#12⟭ [⟬date#1⟭ 08:01:31 +0100] "GET /famille/accueil HTTP/1.1" 200 8120 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="foyer=⟬customer_id#12⟭"
⟬ip_address#12⟭ - ⟬person_name:handle#12⟭ [⟬date#1⟭ 08:02:02 +0100] "GET /famille/factures HTTP/1.1" 200 2204 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="foyer=⟬customer_id#12⟭"
⟬ip_address#12⟭ - ⟬person_name:handle#12⟭ [⟬date#1⟭ 08:02:30 +0100] "GET /famille/paiement?facture=⟬invoice_number#12⟭&jeton=⟬jwt#12⟭ HTTP/1.1" 302 0 "⟬url#1⟭" "Mozilla/5.0 (iPhone)" ctx="foyer=⟬customer_id#12⟭"
⟬ip_address#12⟭ - - [⟬date#1⟭ 08:03:44 +0100] "GET /famille/retour-paiement?ref=⟬opaque_token#12⟭&statut=refus HTTP/1.1" 200 1204 "-" "Mozilla/5.0 (iPhone)" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:04:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:08:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#7⟭ - - [⟬date#1⟭ 08:09:40 +0100] "GET /famille/menus?semaine=13 HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (X11; Linux x86_64)" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:12:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:16:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:20:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:24:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:28:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:32:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Zabbix" ctx="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: pg_restore verbose output, psql table, connection string, HTTP header
scenario: nightly job restoring a hospital database to the test environment, whose psql check shows real-looking patient rows before anonymisation, with password and JWT
⟬text⟭
$ export PGPASSWORD=⟬password#1⟭
$ pg_restore -h ⟬hostname#1⟭ ⟬trap:indicator_non_pii|--username=restore_ci⟭ -d dpi_recette -j 4 --verbose /sauvegardes/dpi.dump
pg_restore: connexion à la base de données pour la restauration
pg_restore: création de SCHEMA « public »
pg_restore: création de TABLE « public.patient »
pg_restore: création de TABLE « public.sejour »
pg_restore: création de TABLE « public.medecin »
pg_restore: création de TABLE « public.compte_rendu »
pg_restore: création de SEQUENCE « public.patient_id_seq »
pg_restore: traitement des données de la table « public.medecin »
pg_restore: traitement des données de la table « public.patient »
pg_restore: traitement des données de la table « public.sejour »
pg_restore: traitement des données de la table « public.compte_rendu »
pg_restore: création de CONSTRAINT « public.patient_pkey »
pg_restore: création de INDEX « public.idx_patient_nir »
pg_restore: création de FK CONSTRAINT « public.sejour_patient_fk »
pg_restore: terminé en 412 s
$ psql postgresql://restore_ci:⟬url_password#1⟭@⟬hostname#1⟭:5432/dpi_recette -c "select id, nom, naissance, nir from patient limit 5"
  id   |            nom             |  naissance   |              nir
-------+----------------------------+--------------+-------------------------------
 ⟬customer_id#2⟭ | ⟬person_name#2⟭ | ⟬birth_date#2⟭ | ⟬fr_social_security_number#2⟭
 ⟬customer_id#3⟭ | ⟬person_name#3⟭ | ⟬birth_date#3⟭ | ⟬fr_social_security_number#3⟭
 ⟬customer_id#4⟭ | ⟬person_name#4⟭ | ⟬birth_date#4⟭ | ⟬fr_social_security_number#4⟭
 ⟬customer_id#5⟭ | ⟬person_name#5⟭ | ⟬birth_date#5⟭ | ⟬fr_social_security_number#5⟭
 ⟬customer_id#6⟭ | ⟬person_name#6⟭ | ⟬birth_date#6⟭ | ⟬fr_social_security_number#6⟭
(5 lignes)

$ psql postgresql://restore_ci:⟬url_password#1⟭@⟬hostname#1⟭:5432/dpi_recette -c "select nom, rpps, mail from medecin limit 3"
         nom          |    rpps     |           mail
----------------------+-------------+--------------------------
 ⟬person_name#7⟭ | ⟬customer_id#7⟭ | ⟬email#7⟭
 ⟬person_name#8⟭ | ⟬customer_id#8⟭ | ⟬email#8⟭
 ⟬person_name#9⟭ | ⟬customer_id#9⟭ | ⟬email#9⟭
(3 lignes)

$ psql postgresql://restore_ci:⟬url_password#1⟭@⟬hostname#1⟭:5432/dpi_recette -c "select count(*) from sejour"
 count
--------
 910221
(1 ligne)

$ python3 -m anonymiser --base dpi_recette --regles regles/patient.yaml
INFO anonymiser: 14 regles chargees
INFO anonymiser: patient.nom remplace
INFO anonymiser: patient.nir supprime
INFO anonymiser: patient.naissance tronquee a l'annee
INFO anonymiser: medecin.mail remplace par ⟬trap:indicator_non_pii|mail=anonyme⟭
INFO anonymiser: compte_rendu.texte vide
INFO anonymiser: sejour.motif conserve, aucun nom detecte
INFO anonymiser: 412208 lignes traitees en 188 s
$ psql postgresql://restore_ci:⟬url_password#1⟭@⟬hostname#1⟭:5432/dpi_recette -c "select id, nom, naissance, nir from patient limit 2"
  id   |            nom             |  naissance   | nir
-------+----------------------------+--------------+-----
 ⟬customer_id#2⟭ | ⟬trap:indicator_non_pii|PATIENT_000001⟭ | ⟬trap:indicator_non_pii|1900⟭ |
 ⟬customer_id#3⟭ | ⟬trap:indicator_non_pii|PATIENT_000002⟭ | ⟬trap:indicator_non_pii|1900⟭ |
(2 lignes)

$ curl -s -X POST -H 'Authorization: Bearer ⟬jwt#1⟭' ⟬url#1⟭ -d '{"base":"dpi_recette","etat":"prete"}'
{"recu":true}
$ ./ci/notifier.sh
envoi du compte rendu a ⟬email:generic#10⟭
notification envoyee par ⟬trap:indicator_non_pii|auteur=job-nocturne⟭
Job succeeded
⟬end⟭
