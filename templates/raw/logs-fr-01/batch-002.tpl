⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: log field, key=value, secret under an innocuous key
scenario: telematics gateway log of a young-driver insurance, copying plate, frame signature and suspended licence
⟬text⟭
⟬date#1⟭ 18:02:11 telematique INFO  trame recue boitier=⟬uuid#1⟭ plaque=⟬fr_license_plate#1⟭ vitesse=92
⟬date#1⟭ 18:02:11 telematique DEBUG signature verifiee sig=⟬opaque_token#1⟭
⟬date#1⟭ 18:02:12 telematique WARN  freinage brutal, notification poussee sur le contrat ⟬customer_id#1⟭
⟬date#1⟭ 18:02:12 telematique ERROR permis ⟬fr_driving_licence#1⟭ signale suspendu par le partenaire, contrat ⟬customer_id#1⟭ transmis a ⟬trap:indicator_non_pii|owner=equipe-flotte⟭
⟬date#1⟭ 18:02:13 telematique INFO  score de conduite recalcule: 64/100
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: public administration
appearance: PHP fatal error, SQL error detail
scenario: PHP fatal error of a public fund's registration portal, triggered by an already registered NIR
⟬text⟭
PHP Fatal error:  Uncaught PDOException: SQLSTATE[23505]: Unique violation: 7 ERROR:  duplicate key value violates unique constraint "usager_nir_key"
DETAIL:  Key (nir)=(⟬fr_social_security_number#1⟭) already exists. in /var/www/portail/src/Usager/Depot.php:74
Stack trace:
#0 /var/www/portail/src/Usager/Depot.php(74): PDOStatement->execute(Array)
#1 /var/www/portail/src/Usager/Inscription.php(51): Usager\Depot->inserer(Object(Usager\Usager))
#2 /var/www/portail/public/inscription.php(23): Usager\Inscription->traiter(Array)
#3 {main}
  thrown in /var/www/portail/src/Usager/Depot.php on line 74
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: telecom
appearance: go test output, code identifier
scenario: go test output of an operator's SMS routing, with one failing case and fictional subscribers only
⟬text⟭
=== RUN   TestRoutageSMS
=== RUN   TestRoutageSMS/prefixe_06
=== RUN   TestRoutageSMS/prefixe_07
--- FAIL: TestRoutageSMS (0.00s)
    --- PASS: TestRoutageSMS/prefixe_06 (0.00s)
    --- FAIL: TestRoutageSMS/prefixe_07 (0.00s)
        routage_test.go:48: route attendue "sms-core-2", obtenue "sms-core-1" (⟬trap:indicator_non_pii|abonne=fictif⟭)
=== RUN   ⟬trap:eponym|TestDistanceHamming⟭
--- PASS: ⟬trap:eponym|TestDistanceHamming⟭ (0.00s)
FAIL
FAIL	git.operateur.lan/sms/routage	0.412s
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: query string, combined log format, authenticated user field
scenario: Apache access of a shop, with an unsubscribe link carrying the email and a key, and a visible admin account
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 20:31:04 +0100] "GET /desabonnement?email=⟬email#1⟭&cle=⟬opaque_token#1⟭ HTTP/2.0" 200 3120 "-" "Mozilla/5.0 (Windows NT 10.0)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 20:31:09 +0100] "POST /desabonnement/confirmer HTTP/2.0" 302 0 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)"
⟬ip_address#2⟭ - ⟬username#1⟭ [⟬date#1⟭ 20:31:40 +0100] "GET /admin/commandes?ref=⟬order_number#1⟭ HTTP/2.0" 200 18422 "⟬url#2⟭" "Mozilla/5.0 (Macintosh)"
⟬ip_address#3⟭ - ⟬person_name:handle#2⟭ [⟬date#1⟭ 20:32:02 +0100] "GET /admin/clients/⟬customer_id#2⟭ HTTP/2.0" 200 7120 "⟬url#2⟭" "Mozilla/5.0 (X11; Linux x86_64)"
⟬ip_address#4⟭ - - [⟬date#1⟭ 20:32:15 +0100] "GET /panier/recuperer?ref=⟬opaque_token#3⟭ HTTP/2.0" 200 9120 "-" "Mozilla/5.0 (iPhone)"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: banking
appearance: Jenkins pipeline output, CLI argument, HTTP header
scenario: publishing stage of a banking Jenkins pipeline, passing the registry password as an argument and printing a service JWT
⟬text⟭
[Pipeline] stage
[Pipeline] { (Publication)
[Pipeline] sh
+ NEXUS_PASS=$(vault kv get -field=pass ci/nexus)
+ docker login ⟬trap:indicator_non_pii|--username ci-banque⟭ --password ⟬password#1⟭ ⟬hostname#1⟭
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
Login Succeeded
+ curl -s -H 'Authorization: Bearer ⟬jwt#1⟭' ⟬url#1⟭
{"publie":true,"image":"⟬version#1⟭"}
[Pipeline] }
[Pipeline] // stage
Finished: SUCCESS
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: pgaudit line, SQL statement
scenario: pgaudit lines of a patient record migration by a technical role, adding encrypted columns with no patient value
⟬text⟭
⟬date#1⟭ 23:10:02 CET [44120] ⟬trap:indicator_non_pii|user=dpi_migration⟭,db=dpi LOG:  AUDIT: SESSION,1,1,DDL,CREATE TABLE,TABLE,public.consultation_archive,"CREATE TABLE consultation_archive (LIKE consultation)",<none>
⟬date#1⟭ 23:10:04 CET [44120] ⟬trap:indicator_non_pii|user=dpi_migration⟭,db=dpi LOG:  AUDIT: SESSION,2,1,DDL,ALTER TABLE,TABLE,public.patient,"ALTER TABLE patient ADD COLUMN ⟬trap:indicator_non_pii|nir_chiffre bytea⟭",<none>
⟬date#1⟭ 23:10:04 CET [44120] ⟬trap:indicator_non_pii|user=dpi_migration⟭,db=dpi LOG:  AUDIT: SESSION,3,1,DDL,ALTER TABLE,TABLE,public.patient,"ALTER TABLE patient ADD COLUMN ⟬trap:indicator_non_pii|date_naissance_hash text⟭",<none>
⟬date#1⟭ 23:10:06 CET [44120] ⟬trap:indicator_non_pii|user=dpi_migration⟭,db=dpi LOG:  AUDIT: SESSION,4,1,ROLE,GRANT,,,"GRANT SELECT ON consultation_archive TO lecture_stats",<none>
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Monolog line, nested JSON, HTTP header
scenario: Monolog log of a marketplace, whose JSON context for a failed signup and payment holds password, card and address
⟬text⟭
[⟬date#1⟭ 11:02:44] request.INFO: Matched route "api_inscription". {"route":"api_inscription","request_uri":"/api/inscription","method":"POST"} []
[⟬date#1⟭ 11:02:44] app.DEBUG: charge utile recue {"email":"⟬email#1⟭","plainPassword":"⟬password#1⟭","nom":"⟬person_name#1⟭","tel":"⟬phone#1⟭","newsletter":true} []
[⟬date#1⟭ 11:02:44] doctrine.DEBUG: SELECT id FROM client WHERE email = ? ["⟬email#1⟭"] []
[⟬date#1⟭ 11:02:45] app.WARNING: compte existant, fusion demandee {"client":"⟬customer_id#1⟭","source":"mobile"} []
[⟬date#1⟭ 11:02:45] security.INFO: jeton de session cree {"client":"⟬customer_id#1⟭","ref":"⟬uuid#1⟭"} []
[⟬date#1⟭ 11:04:10] request.INFO: Matched route "api_commande_payer". {"route":"api_commande_payer","request_uri":"/api/commandes/payer","method":"POST"} []
[⟬date#1⟭ 11:04:10] app.DEBUG: entetes recus {"Accept":"application/json","X-Client-Ref":"⟬opaque_token#1⟭","X-Trace":"⟬uuid#2⟭"} []
[⟬date#1⟭ 11:04:10] app.INFO: commande a payer {"commande":"⟬order_number#1⟭","montant":129.90,"livraison":{"destinataire":"⟬person_name#1⟭","adresse":"⟬fr_postal_address#1⟭"}} []
[⟬date#1⟭ 11:04:11] paiement.ERROR: refus du prestataire {"commande":"⟬order_number#1⟭","carte":{"numero":"⟬payment_card#1⟭","exp":"09/26","cvc":"⟬card_security_code#1⟭"},"code":"05"} []
[⟬date#1⟭ 11:04:11] paiement.INFO: nouvelle tentative programmee {"commande":"⟬order_number#1⟭","dans_s":30} []
[⟬date#1⟭ 11:04:41] paiement.ERROR: refus du prestataire {"commande":"⟬order_number#1⟭","code":"05"} []
[⟬date#1⟭ 11:04:41] mailer.INFO: courriel "paiement refuse" mis en file {"destinataire":"⟬email#1⟭","modele":"paiement_refuse"} []
[⟬date#1⟭ 11:04:42] messenger.INFO: message traite {"class":"App\\Message\\EnvoiCourriel","retry":0} []
[⟬date#1⟭ 11:05:00] app.INFO: panier conserve 48 h {"panier":"⟬uuid#3⟭","owner":"⟬customer_id#1⟭"} []
[⟬date#1⟭ 11:05:30] php.DEBUG: User Deprecated: Since symfony/security-core 6.4 {"exception":"[object] (ErrorException)"} []
[⟬date#1⟭ 11:06:02] request.INFO: Matched route "api_panier". {"route":"api_panier","request_uri":"/api/panier","method":"GET"} []
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: banking
appearance: Python logging, key=value, masked value
scenario: daily VaR calculation log of a trading room, with eponymous models, a service account and masked accounts
⟬text⟭
INFO  2 risque.demarrage     calcul VaR du ⟬date#1⟭, ⟬trap:indicator_non_pii|user=svc-risque⟭, version ⟬version#1⟭
INFO  2 risque.demarrage     chargement des positions depuis ⟬hostname#1⟭
INFO  3 risque.donnees       ⟬trap:library|Pandas⟭ ⟬version#2⟭, 182340 lignes en memoire
DEBUG 3 risque.donnees       fichier source ⟬file_path#1⟭, empreinte ⟬hash#1⟭
INFO  9 risque.prix          options: modele ⟬trap:eponym|Black-Scholes⟭, volatilite implicite interpolee
INFO 14 risque.prix          taux: modele ⟬trap:eponym|Vasicek⟭, 12 facteurs
WARN 14 risque.prix          matrice de correlation non definie positive, correction de ⟬trap:eponym|Higham⟭ appliquee
INFO 15 risque.simulation    decomposition de ⟬trap:eponym|Cholesky⟭ terminee en 812 ms
INFO 61 risque.simulation    10000 scenarios generes, graine=421337
INFO 74 risque.agregat       VaR 99% 1j portefeuille TAUX: 1842301 EUR
INFO 74 risque.agregat       VaR 99% 1j portefeuille CHANGE: 412200 EUR
INFO 74 risque.agregat       VaR 99% 1j portefeuille ACTIONS: 1120450 EUR
WARN 75 risque.limites       depassement de limite sur TAUX: 104% (⟬trap:indicator_non_pii|responsable=desk-taux⟭)
INFO 75 risque.limites       ticket ouvert ⟬ticket_id#1⟭
DEBUG 75 risque.rapprochement  ⟬trap:indicator_non_pii|iban=FR76********************12⟭ solde ok
DEBUG 75 risque.rapprochement  ⟬trap:indicator_non_pii|iban=FR76********************87⟭ solde ok
INFO 76 risque.publication   rapport depose sur ⟬url#1⟭
INFO 76 risque.publication   fin du calcul, duree totale 76 s
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: Python traceback, SQL error detail, local variables dump
scenario: Django error at an emergency department admission of a patient, whose local variables dump exposes NIR, birth date and GP
⟬text⟭
ERROR:django.request:Internal Server Error: /api/urgences/admission/
Traceback (most recent call last):
  File "/usr/local/lib/python3.11/site-packages/django/db/backends/utils.py", line 89, in _execute
    return self.cursor.execute(sql, params)
psycopg2.errors.UniqueViolation: la valeur d'une clé dupliquée rompt la contrainte unique « admission_patient_ouverte »
DETAIL:  La clé « (ipp)=(⟬customer_id#1⟭) » existe déjà.

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.11/site-packages/django/core/handlers/exception.py", line 55, in inner
    response = get_response(request)
  File "/srv/urgences/admission/views.py", line 142, in creer
    admission = services.ouvrir_admission(payload, box=box)
  File "/srv/urgences/admission/services.py", line 67, in ouvrir_admission
    return Admission.objects.create(**champs)
django.db.utils.IntegrityError: la valeur d'une clé dupliquée rompt la contrainte unique « admission_patient_ouverte »

Variables locales de ouvrir_admission:
  box = 'B12'
  payload = {'nom': "⟬person_name:family#1f⟭", 'prenom': "⟬person_name:given#1f⟭", 'date_naissance': '⟬birth_date#1⟭', 'nir': '⟬fr_social_security_number#1⟭', 'medecin_traitant': "Dr ⟬person_name#2⟭", 'motif': 'douleur thoracique'}
  champs = {'ipp': '⟬customer_id#1⟭', 'box': 'B12', 'priorite': 2}
  utilisateur = 'ioa-poste3'
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: insurance
appearance: .NET stack trace, record dump, inner exception
scenario: .NET exception of online car insurance, whose driver record appears whole in the error message
⟬text⟭
fail: Assurance.Souscription.Api.Erreurs[0]
      Une exception non gérée s'est produite lors de l'exécution de la requête.
System.InvalidOperationException: Devis ⟬uuid#1⟭ impossible à transformer en contrat
 ---> Assurance.Souscription.Domaine.VehiculeInconnuException: Vehicule { Immatriculation = ⟬fr_license_plate#1⟭, Puissance = 7, Energie = ESSENCE } absent de la base SIV
   at Assurance.Souscription.Domaine.ReferentielVehicule.Trouver(String immatriculation) in D:\build\souscription\Domaine\ReferentielVehicule.cs:line 61
   at Assurance.Souscription.Domaine.Tarificateur.Calculer(Devis devis) in D:\build\souscription\Domaine\Tarificateur.cs:line 88
   --- End of inner exception stack trace ---
   at Assurance.Souscription.Application.Transformation.Executer(Guid devisId) in D:\build\souscription\Application\Transformation.cs:line 47
   at Assurance.Souscription.Api.ContratsController.Creer(CreationContrat requete) in D:\build\souscription\Api\ContratsController.cs:line 33
   at lambda_method21(Closure, Object)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableObjectResultExecutor.Execute(ActionContext context)
   at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.Invoke(HttpContext context)
info: Assurance.Souscription.Api.Requetes[1]
      Corps de la requête rejetée : CreationContrat { Conducteur = Conducteur { Nom = "⟬person_name#2⟭", Permis = "⟬fr_driving_licence#2⟭", ObtentionPermis = ⟬date#2⟭ }, Prelevement = Prelevement { Iban = "⟬iban#2⟭", Titulaire = "⟬person_name#2⟭" }, Parrain = "⟬trap:indicator_non_pii|aucun⟭" }
warn: Assurance.Souscription.Api.Audit[2]
      Requête rejetée pour le courtier ⟬company#3⟭ à ⟬date#1⟭ 15:40:12
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: banking
appearance: Jest diff, assertion message, masked value
scenario: Jest output of an online bank front end, where the IBAN formatting test fails and card masking lets the full PAN through
⟬text⟭
 FAIL  src/virements/__tests__/affichage.test.ts
  affichage des coordonnées bancaires
    ✓ affiche le BIC ⟬bic#1⟭ tel quel (3 ms)
    ✕ regroupe l'IBAN par quatre (6 ms)
    ✕ masque le numéro de carte (2 ms)

  ● affichage des coordonnées bancaires › regroupe l'IBAN par quatre

    expect(received).toBe(expected) // Object.is equality

    Expected: "⟬iban#1⟭"
    Received: "⟬iban#2⟭"

      22 |   it("regroupe l'IBAN par quatre", () => {
      23 |     const rendu = formaterIban(compteTest.iban);
    > 24 |     expect(rendu).toBe(attendu.iban);
         |                   ^
      25 |   });

  ● affichage des coordonnées bancaires › masque le numéro de carte

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Object {
        "porteur": "⟬person_name#3⟭",
    -   ⟬trap:indicator_non_pii|"pan": "**** **** **** 1111",⟭
    +   "pan": "⟬payment_card#3⟭",
      }

Test Suites: 1 failed, 11 passed, 12 total
Tests:       2 failed, 96 passed, 98 total
Snapshots:   0 total
Time:        4.127 s
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: PHPUnit diff, array dump, test fixture
scenario: PHPUnit output of an admission module, with a foreign test patient whose passport replaces a provisional NIR
⟬text⟭
PHPUnit ⟬version#1⟭ by ⟬person_name#3m⟭ and contributors.

Runtime:       PHP 8.2.12
Configuration: /srv/admission/phpunit.xml

..F.....                                                            8 / 8 (100%)

Time: 00:00.214, Memory: 12.00 MB

There was 1 failure:

1) Tests\Admission\IdentiteTest::testPatientEtrangerSansNir
Failed asserting that two arrays are equal.
--- Expected
+++ Actual
@@ @@
 Array (
-    'ipp' => '⟬customer_id#1⟭'
-    'piece' => 'PASSEPORT'
-    'numero' => '⟬fr_passport#1⟭'
+    'ipp' => null
+    'piece' => 'NIR'
+    'numero' => '⟬fr_social_security_number#1⟭'
     'nom' => "⟬person_name#1⟭"
     'naissance' => '⟬birth_date#1⟭'
 )

/srv/admission/tests/Admission/IdentiteTest.php:58

FAILURES!
Tests: 8, Assertions: 21, Failures: 1.
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: IIS W3C log, query string, authenticated user field
scenario: IIS log of an ID documents online service, with passport numbers in paths and a resume token in the query string
⟬text⟭
#Software: Microsoft Internet Information Services 10.0
#Version: 1.0
#Date: ⟬date#1⟭ 07:00:03
#Fields: date time s-ip cs-method cs-uri-stem cs-uri-query s-port cs-username c-ip cs(User-Agent) sc-status sc-substatus sc-win32-status time-taken
⟬date#1⟭ 07:00:03 ⟬ip_address#1⟭ GET /teleservice/accueil.aspx - 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0) 200 0 0 62
⟬date#1⟭ 07:00:09 ⟬ip_address#1⟭ GET /teleservice/titres/⟬fr_passport#3⟭/statut - 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0) 200 0 0 148
⟬date#1⟭ 07:00:15 ⟬ip_address#1⟭ POST /teleservice/titres/⟬fr_passport#3⟭/renouveler - 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0) 302 0 0 411
⟬date#1⟭ 07:00:16 ⟬ip_address#1⟭ GET /teleservice/reprise.aspx jeton=⟬jwt#3⟭ 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0) 200 0 0 87
⟬date#1⟭ 07:01:02 ⟬ip_address#1⟭ GET /backoffice/dossiers.aspx statut=attente 443 ⟬person_name:handle#4⟭ ⟬ip_address#3⟭ Mozilla/5.0+(Windows+NT+10.0;+Trident/7.0) 200 0 0 233
⟬date#1⟭ 07:01:30 ⟬ip_address#1⟭ GET /backoffice/dossier.aspx ref=⟬uuid#1⟭ 443 ⟬person_name:handle#4⟭ ⟬ip_address#3⟭ Mozilla/5.0+(Windows+NT+10.0;+Trident/7.0) 200 0 0 174
⟬date#1⟭ 07:01:48 ⟬ip_address#1⟭ POST /backoffice/valider.aspx ref=⟬uuid#1⟭ 443 ⟬person_name:handle#4⟭ ⟬ip_address#3⟭ Mozilla/5.0+(Windows+NT+10.0;+Trident/7.0) 200 0 0 318
⟬date#1⟭ 07:02:00 ⟬ip_address#1⟭ GET /api/synchro.ashx depuis=0 443 PREFECTURE\⟬username#1⟭ ⟬ip_address#4⟭ curl/7.68.0 200 0 0 96
⟬date#1⟭ 07:02:40 ⟬ip_address#1⟭ POST /teleservice/mail.ashx destinataire=⟬email#5⟭ 443 - ⟬ip_address#5⟭ Mozilla/5.0+(iPhone) 200 0 0 54
⟬date#1⟭ 07:03:11 ⟬ip_address#1⟭ GET /teleservice/titres/⟬fr_passport#6⟭/statut - 443 - ⟬ip_address#6⟭ Mozilla/5.0+(Android+14) 404 0 2 31
⟬date#1⟭ 07:03:14 ⟬ip_address#1⟭ GET /teleservice/titres/⟬fr_passport#7⟭/statut - 443 - ⟬ip_address#6⟭ Mozilla/5.0+(Android+14) 200 0 0 102
⟬date#1⟭ 07:03:58 ⟬ip_address#1⟭ GET /teleservice/reprise.aspx jeton=⟬jwt#7⟭ 443 - ⟬ip_address#6⟭ Mozilla/5.0+(Android+14) 401 2 5 18
⟬date#1⟭ 07:04:00 ⟬ip_address#1⟭ GET /healthcheck.ashx - 443 - ⟬ip_address#7⟭ Zabbix 200 0 0 4
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Ansible verbose output, nested JSON, connection string
scenario: verbose Ansible playbook of an operator's selfcare portal, whose JSON output shows the database password, the Redis DSN and an app secret
⟬text⟭
PLAY [deploiement portail selfcare] ********************************************

TASK [Gathering Facts] *********************************************************
ok: [⟬hostname#1⟭]

TASK [bdd : mise a jour du role applicatif] ************************************
changed: [⟬hostname#1⟭] => {"changed": true, "cmd": "psql -c \"ALTER ROLE selfcare WITH PASSWORD '⟬password#1⟭'\"", "rc": 0, "stdout": "ALTER ROLE"}

TASK [cache : ecriture du fichier de connexion] ********************************
changed: [⟬hostname#1⟭] => {"changed": true, "dest": "/etc/selfcare/cache.json", "dsn": "redis://:⟬url_password#1⟭@⟬hostname#2⟭:6379/0", "mode": "0640"}

TASK [app : parametres applicatifs] ********************************************
ok: [⟬hostname#1⟭] => (item={"name": "SESSION_SIGNING", "value": "⟬opaque_token#1⟭"})
ok: [⟬hostname#1⟭] => (item={"name": "BUILD_ID", "value": "⟬uuid#1⟭"})
ok: [⟬hostname#1⟭] => (item={"name": "PARTENAIRE_REF", "value": "⟬order_number#1⟭"})
changed: [⟬hostname#1⟭] => (item={"name": "SMS_API", "value": "⟬opaque_token#2⟭"})

TASK [app : redemarrage du service] ********************************************
changed: [⟬hostname#1⟭]

TASK [app : sonde de disponibilite] ********************************************
FAILED - RETRYING: [⟬hostname#1⟭]: sonde de disponibilite (5 retries left).
ok: [⟬hostname#1⟭] => {"attempts": 2, "status": 200, "url": "⟬url#1⟭"}

PLAY RECAP *********************************************************************
⟬hostname#1⟭ : ok=7 changed=4 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: JSON log line, cloud audit event
scenario: cloud audit events of a merchant site, as JSON, one deployment morning run by technical roles
⟬text⟭
{"eventTime":"⟬date#1⟭ 05:14:02","eventName":"AssumeRole","userName":"⟬trap:indicator_non_pii|deploy-boutique⟭","sourceIP":"⟬ip_address#1⟭","requestId":"⟬uuid#1⟭","readOnly":false}
{"eventTime":"⟬date#1⟭ 05:14:09","eventName":"GetObject","userName":"⟬trap:indicator_non_pii|deploy-boutique⟭","bucket":"boutique-artefacts","key":"releases/web-⟬version#1⟭.tar.gz","requestId":"⟬uuid#2⟭","readOnly":true}
{"eventTime":"⟬date#1⟭ 05:14:31","eventName":"UpdateService","userName":"⟬trap:indicator_non_pii|deploy-boutique⟭","service":"web","desiredCount":6,"requestId":"⟬uuid#3⟭","readOnly":false}
{"eventTime":"⟬date#1⟭ 05:15:02","eventName":"DescribeServices","userName":"⟬trap:indicator_non_pii|deploy-boutique⟭","service":"web","requestId":"⟬uuid#4⟭","readOnly":true}
{"eventTime":"⟬date#1⟭ 05:15:40","eventName":"PutMetricAlarm","userName":"⟬trap:indicator_non_pii|terraform-prod⟭","alarm":"latence-panier","requestId":"⟬uuid#5⟭","readOnly":false}
{"eventTime":"⟬date#1⟭ 05:15:44","eventName":"PutParameter","userName":"⟬trap:indicator_non_pii|terraform-prod⟭","name":"/boutique/prod/stripe_secret","value":"⟬trap:placeholder|HIDDEN_DUE_TO_SECURITY_REASONS⟭","requestId":"⟬uuid#6⟭","readOnly":false}
{"eventTime":"⟬date#1⟭ 05:15:45","eventName":"PutParameter","userName":"⟬trap:indicator_non_pii|terraform-prod⟭","name":"/boutique/prod/smtp_password","value":"⟬trap:placeholder|HIDDEN_DUE_TO_SECURITY_REASONS⟭","requestId":"⟬uuid#7⟭","readOnly":false}
{"eventTime":"⟬date#1⟭ 05:16:01","eventName":"PutRolePolicy","userName":"⟬trap:indicator_non_pii|terraform-prod⟭","role":"web-task","policy":"lecture-parametres","requestId":"⟬uuid#8⟭","readOnly":false}
{"eventTime":"⟬date#1⟭ 05:16:30","eventName":"ConsoleLogin","userName":"⟬trap:indicator_non_pii|root⟭","sourceIP":"⟬ip_address#2⟭","mfaUsed":true,"responseElements":{"ConsoleLogin":"Success"},"requestId":"⟬uuid#9⟭"}
{"eventTime":"⟬date#1⟭ 05:17:02","eventName":"StopLogging","userName":"⟬trap:indicator_non_pii|root⟭","errorCode":"AccessDenied","requestId":"⟬uuid#10⟭","readOnly":false}
{"eventTime":"⟬date#1⟭ 05:18:15","eventName":"ListBuckets","userName":"⟬trap:indicator_non_pii|sonde-securite⟭","sourceIP":"⟬ip_address#3⟭","requestId":"⟬uuid#11⟭","readOnly":true}
{"eventTime":"⟬date#1⟭ 05:18:16","eventName":"GetBucketAcl","userName":"⟬trap:indicator_non_pii|sonde-securite⟭","bucket":"boutique-factures","requestId":"⟬uuid#12⟭","readOnly":true}
{"eventTime":"⟬date#1⟭ 05:18:17","eventName":"GetBucketEncryption","userName":"⟬trap:indicator_non_pii|sonde-securite⟭","bucket":"boutique-factures","requestId":"⟬uuid#13⟭","readOnly":true}
{"eventTime":"⟬date#1⟭ 05:20:00","eventName":"CreateLogGroup","userName":"⟬trap:indicator_non_pii|terraform-prod⟭","logGroup":"/boutique/web","requestId":"⟬uuid#14⟭","readOnly":false}
{"eventTime":"⟬date#1⟭ 05:20:02","eventName":"PutRetentionPolicy","userName":"⟬trap:indicator_non_pii|terraform-prod⟭","logGroup":"/boutique/web","retentionInDays":30,"requestId":"⟬uuid#15⟭","readOnly":false}
{"eventTime":"⟬date#1⟭ 05:21:44","eventName":"AssumeRole","userName":"⟬trap:indicator_non_pii|batch-factures⟭","sourceIP":"⟬ip_address#4⟭","requestId":"⟬uuid#16⟭","readOnly":false}
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: banking
appearance: CEF event, key=value, quoted value
scenario: CEF events of a card data vault, tracing each PAN unmasking by an adviser and the identity check questions
⟬text⟭
⟬date#1⟭ 13:02:01 coffre-01 CEF:0|Banque|CoffreCartes|3.2|100|Ouverture de session|3|src=⟬ip_address#1⟭ suser=⟬person_name:handle#1⟭ cs1Label=agence cs1=⟬city#1⟭
⟬date#1⟭ 13:04:37 coffre-01 CEF:0|Banque|CoffreCartes|3.2|210|Identite verifiee|3|src=⟬ip_address#1⟭ suser=⟬person_name:handle#1⟭ cs1Label=client cs1="⟬person_name#2⟭" cs2Label=naissance cs2=⟬birth_date#2⟭
⟬date#1⟭ 13:05:12 coffre-01 CEF:0|Banque|CoffreCartes|3.2|310|PAN demasque|7|src=⟬ip_address#1⟭ suser=⟬person_name:handle#1⟭ cs1Label=pan cs1=⟬payment_card#2⟭ cs2Label=motif cs2="opposition par telephone"
⟬date#1⟭ 13:05:58 coffre-01 CEF:0|Banque|CoffreCartes|3.2|320|Opposition enregistree|5|src=⟬ip_address#1⟭ suser=⟬person_name:handle#1⟭ cs1Label=carte cs1=⟬uuid#1⟭
⟬date#1⟭ 13:06:40 coffre-01 CEF:0|Banque|CoffreCartes|3.2|410|RIB consulte|5|src=⟬ip_address#1⟭ suser=⟬person_name:handle#1⟭ cs1Label=value cs1=⟬iban#2⟭
⟬date#1⟭ 13:07:02 coffre-01 CEF:0|Banque|CoffreCartes|3.2|410|RIB consulte|5|src=⟬ip_address#1⟭ suser=⟬trap:indicator_non_pii|batch-prelevements⟭ cs1Label=value cs1=⟬uuid#2⟭
⟬date#1⟭ 13:09:15 coffre-01 CEF:0|Banque|CoffreCartes|3.2|210|Identite verifiee|3|src=⟬ip_address#2⟭ suser=⟬person_name:handle#3⟭ cs1Label=client cs1="⟬person_name#4⟭" cs2Label=naissance cs2=⟬birth_date#4⟭
⟬date#1⟭ 13:09:51 coffre-01 CEF:0|Banque|CoffreCartes|3.2|310|PAN demasque|7|src=⟬ip_address#2⟭ suser=⟬person_name:handle#3⟭ cs1Label=pan cs1=⟬payment_card#4⟭ cs2Label=motif cs2="contestation d'operation"
⟬date#1⟭ 13:10:30 coffre-01 CEF:0|Banque|CoffreCartes|3.2|330|Export refuse|8|src=⟬ip_address#2⟭ suser=⟬person_name:handle#3⟭ cs1Label=motif cs1="habilitation insuffisante"
⟬date#1⟭ 13:12:00 coffre-01 CEF:0|Banque|CoffreCartes|3.2|900|Sonde|1|src=⟬ip_address#3⟭ suser=⟬trap:indicator_non_pii|supervision⟭
⟬date#1⟭ 13:14:22 coffre-01 CEF:0|Banque|CoffreCartes|3.2|500|Rotation de cle|6|src=⟬ip_address#3⟭ suser=⟬trap:indicator_non_pii|hsm-rotation⟭ cs1Label=key_id cs1=⟬hash#1⟭
⟬date#1⟭ 13:30:04 coffre-01 CEF:0|Banque|CoffreCartes|3.2|110|Fermeture de session|3|src=⟬ip_address#1⟭ suser=⟬person_name:handle#1⟭ cs1Label=duree cs1=1683
⟬date#1⟭ 13:42:18 coffre-01 CEF:0|Banque|CoffreCartes|3.2|110|Fermeture de session|3|src=⟬ip_address#2⟭ suser=⟬person_name:handle#3⟭ cs1Label=duree cs1=1985
⟬date#1⟭ 14:00:00 coffre-01 CEF:0|Banque|CoffreCartes|3.2|900|Sonde|1|src=⟬ip_address#3⟭ suser=⟬trap:indicator_non_pii|supervision⟭
⟬date#1⟭ 14:30:00 coffre-01 CEF:0|Banque|CoffreCartes|3.2|900|Sonde|1|src=⟬ip_address#3⟭ suser=⟬trap:indicator_non_pii|supervision⟭
⟬date#1⟭ 15:00:00 coffre-01 CEF:0|Banque|CoffreCartes|3.2|900|Sonde|1|src=⟬ip_address#3⟭ suser=⟬trap:indicator_non_pii|supervision⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: public administration
appearance: behave Gherkin output, Markdown-like table, JSON response, HTTP header
scenario: French behave output of acceptance tests for the licence and vehicle registration service, whose steps show fictional users, documents and tokens
⟬text⟭
Fonctionnalité: Changement de titulaire d'une carte grise # features/cession.feature:1

  Contexte: Téléservice ouvert
    Étant donné que le téléservice répond sur ⟬url#1⟭        # steps/commun.py:12 0.041s
    Et qu'un jeton d'agent est obtenu                      # steps/commun.py:28 0.122s

  Scénario: Cession simple entre deux particuliers          # features/cession.feature:7
    Étant donné un vendeur "⟬person_name#1m⟭" né le ⟬birth_date#1⟭    # steps/usagers.py:19 0.003s
    Et une acheteuse "⟬person_name#2f⟭" née le ⟬birth_date#2⟭         # steps/usagers.py:19 0.002s
    Et un véhicule immatriculé ⟬fr_license_plate#3⟭         # steps/vehicules.py:11 0.018s
    Quand la cession est déclarée                          # steps/cession.py:44 0.207s
    Alors le statut est "ENREGISTREE"                      # steps/cession.py:71 0.001s
    Et le titulaire affiché est "⟬person_name#2f⟭"          # steps/cession.py:83 0.001s

  Scénario: Acheteur sans permis valide                     # features/cession.feature:16
    Étant donné un acheteur "⟬person_name#4m⟭" né le ⟬birth_date#4⟭   # steps/usagers.py:19 0.002s
    Et son permis ⟬fr_driving_licence#4⟭ annulé            # steps/permis.py:31 0.009s
    Et un véhicule immatriculé ⟬fr_license_plate#5⟭         # steps/vehicules.py:11 0.015s
    Quand la cession est déclarée                          # steps/cession.py:44 0.190s
    Alors le statut est "REFUSEE"                          # steps/cession.py:71 0.001s
      Assertion Failed: statut attendu REFUSEE, obtenu ENREGISTREE
      Traceback (most recent call last):
        File "steps/cession.py", line 73, in etape_statut
          assert corps["statut"] == attendu
      AssertionError
      Réponse: {"statut":"ENREGISTREE","acheteur":{"nom":"⟬person_name#4m⟭","permis":"⟬fr_driving_licence#4⟭"},"vehicule":"⟬fr_license_plate#5⟭"}
      Requête: Authorization: Bearer ⟬jwt#6⟭

  Scénario: Demande de duplicata de permis par un usager de passage # features/permis.feature:3
    Étant donné un usager:
      | nom                    | naissance        | titre            |
      | ⟬person_name#7⟭ | ⟬birth_date#7⟭ | ⟬fr_passport#7⟭ |
    Et son permis ⟬fr_driving_licence#7⟭ déclaré perdu     # steps/permis.py:31 0.008s
    Quand le duplicata est demandé                         # steps/permis.py:52 0.301s
    Alors un numéro de suivi est créé                      # steps/permis.py:60 0.001s
    Et un courriel part vers ⟬email#7⟭                     # steps/mails.py:14 0.052s

  Scénario: Plan: refus des formats de plaque invalides      # features/plaques.feature:5
    Quand je saisis ⟬trap:indicator_non_pii|la plaque "AA-000"⟭                     # steps/vehicules.py:40 0.012s
    Alors le statut est "FORMAT_INVALIDE"                  # steps/cession.py:71 0.001s
    Quand je saisis ⟬trap:indicator_non_pii|la plaque "XX"⟭                         # steps/vehicules.py:40 0.011s
    Alors le statut est "FORMAT_INVALIDE"                  # steps/cession.py:71 0.001s

  Scénario: Agent de préfecture sans habilitation           # features/droits.feature:9
    Étant donné un ⟬trap:indicator_non_pii|agent "guichet-test"⟭                      # steps/commun.py:51 0.004s
    Quand il consulte le dossier ⟬uuid#1⟭                   # steps/dossiers.py:22 0.081s
    Alors le code HTTP est 403                             # steps/commun.py:66 0.001s

  Scénario: Duplicata pour une majeure protégée              # features/permis.feature:27
    Étant donné une demandeuse "⟬person_name#8f⟭" née le ⟬birth_date#8⟭ # steps/usagers.py:19 0.002s
    Et son représentant légal "⟬person_name#9m⟭"            # steps/usagers.py:33 0.002s
    Et son passeport ⟬fr_passport#8⟭ en cours de validité   # steps/titres.py:17 0.006s
    Quand le duplicata est demandé                         # steps/permis.py:52 0.298s
    Alors le statut est "PIECE_MANQUANTE"                  # steps/cession.py:71 0.001s

  Scénario: Cession avec mandataire professionnel           # features/cession.feature:31
    Étant donné un vendeur "⟬person_name#10m⟭" né le ⟬birth_date#10⟭   # steps/usagers.py:19 0.002s
    Et un professionnel ⟬company#11⟭ de SIRET ⟬fr_siret#11⟭            # steps/pros.py:8 0.006s
    Et un véhicule immatriculé ⟬fr_license_plate#12⟭         # steps/vehicules.py:11 0.016s
    Quand la cession est déclarée                          # steps/cession.py:44 0.211s
    Alors le statut est "ENREGISTREE"                      # steps/cession.py:71 0.001s

Failing scenarios:
  features/cession.feature:16  Acheteur sans permis valide

3 features passed, 1 failed, 0 skipped
6 scenarios passed, 1 failed, 0 skipped
46 steps passed, 1 failed, 0 skipped, 0 undefined
Took 0m1.742s
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: JSON log line, query string, masked header
scenario: Traefik JSON access of an insurer's quote comparator, with parameters that look like driver fields but no real data
⟬text⟭
{"time":"⟬date#1⟭ 10:00:01","client":"⟬ip_address#1⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#1⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:00:04","client":"⟬ip_address#2⟭","req":"GET /devis/auto","status":200,"ms":38,"rid":"⟬uuid#2⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:00:04","client":"⟬ip_address#2⟭","req":"GET /assets/app.⟬hash#1⟭.js","status":200,"ms":3,"rid":"⟬uuid#3⟭","router":"statique@docker"}
{"time":"⟬date#1⟭ 10:00:05","client":"⟬ip_address#2⟭","req":"GET /api/marques","status":200,"ms":22,"rid":"⟬uuid#4⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:00:09","client":"⟬ip_address#2⟭","req":"GET /api/modeles?marque=⟬trap:company_name|Peugeot⟭","status":200,"ms":31,"rid":"⟬uuid#5⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:00:14","client":"⟬ip_address#2⟭","req":"GET /api/modeles?marque=⟬trap:company_name|Renault⟭","status":200,"ms":29,"rid":"⟬uuid#6⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:00:21","client":"⟬ip_address#2⟭","req":"GET /api/modeles?marque=⟬trap:company_name|Citroën⟭","status":200,"ms":33,"rid":"⟬uuid#7⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:00:27","client":"⟬ip_address#2⟭","req":"GET /api/finitions?modele=308","status":200,"ms":18,"rid":"⟬uuid#8⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:00:31","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#9⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:00:38","client":"⟬ip_address#2⟭","req":"POST /api/devis","status":201,"ms":114,"rid":"⟬uuid#10⟭","router":"devis@docker","ref":"⟬order_number#1⟭"}
{"time":"⟬date#1⟭ 10:00:39","client":"⟬ip_address#2⟭","req":"GET /api/devis/⟬uuid#11⟭","status":200,"ms":27,"rid":"⟬uuid#12⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:00:44","client":"⟬ip_address#2⟭","req":"GET /api/garanties?⟬trap:indicator_non_pii|conducteur=principal⟭","status":200,"ms":41,"rid":"⟬uuid#13⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:00:51","client":"⟬ip_address#2⟭","req":"GET /api/garanties?⟬trap:indicator_non_pii|conducteur=secondaire⟭","status":200,"ms":39,"rid":"⟬uuid#14⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:01:01","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#15⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:01:06","client":"⟬ip_address#4⟭","req":"GET /devis/habitation","status":200,"ms":44,"rid":"⟬uuid#16⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:01:07","client":"⟬ip_address#4⟭","req":"GET /assets/app.⟬hash#1⟭.js","status":304,"ms":1,"rid":"⟬uuid#17⟭","router":"statique@docker"}
{"time":"⟬date#1⟭ 10:01:12","client":"⟬ip_address#4⟭","req":"GET /api/communes?cp=⟬postcode#1⟭","status":200,"ms":19,"rid":"⟬uuid#18⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:01:18","client":"⟬ip_address#4⟭","req":"GET /api/risques?commune=⟬city#1⟭","status":200,"ms":57,"rid":"⟬uuid#19⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:01:26","client":"⟬ip_address#4⟭","req":"POST /api/devis","status":201,"ms":121,"rid":"⟬uuid#20⟭","router":"devis@docker","ref":"⟬order_number#2⟭"}
{"time":"⟬date#1⟭ 10:01:31","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#21⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:01:40","client":"⟬ip_address#5⟭","req":"GET /api/admin/stats","status":401,"ms":2,"rid":"⟬uuid#22⟭","router":"admin@docker","auth":"⟬trap:placeholder|Bearer <masque>⟭"}
{"time":"⟬date#1⟭ 10:01:42","client":"⟬ip_address#5⟭","req":"GET /api/admin/stats","status":200,"ms":64,"rid":"⟬uuid#23⟭","router":"admin@docker","auth":"⟬trap:placeholder|Bearer <masque>⟭"}
{"time":"⟬date#1⟭ 10:01:43","client":"⟬ip_address#5⟭","req":"GET /api/admin/quotas?⟬trap:indicator_non_pii|owner=courtage⟭","status":200,"ms":12,"rid":"⟬uuid#24⟭","router":"admin@docker","auth":"⟬trap:placeholder|Bearer <masque>⟭"}
{"time":"⟬date#1⟭ 10:02:01","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#25⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:02:15","client":"⟬ip_address#6⟭","req":"GET /devis/moto","status":200,"ms":37,"rid":"⟬uuid#26⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:02:16","client":"⟬ip_address#6⟭","req":"GET /api/marques?type=moto","status":200,"ms":24,"rid":"⟬uuid#27⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:02:22","client":"⟬ip_address#6⟭","req":"GET /api/modeles?marque=⟬trap:company_name|Honda⟭","status":200,"ms":26,"rid":"⟬uuid#28⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:02:29","client":"⟬ip_address#6⟭","req":"GET /api/modeles?marque=⟬trap:company_name|Ducati⟭","status":200,"ms":30,"rid":"⟬uuid#29⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:02:31","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#30⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:02:41","client":"⟬ip_address#6⟭","req":"POST /api/devis","status":422,"ms":15,"rid":"⟬uuid#31⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:02:47","client":"⟬ip_address#6⟭","req":"POST /api/devis","status":201,"ms":109,"rid":"⟬uuid#32⟭","router":"devis@docker","ref":"⟬order_number#3⟭"}
{"time":"⟬date#1⟭ 10:03:01","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#33⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:03:12","client":"⟬ip_address#7⟭","req":"GET /sitemap.xml","status":200,"ms":6,"rid":"⟬uuid#34⟭","router":"statique@docker"}
{"time":"⟬date#1⟭ 10:03:13","client":"⟬ip_address#7⟭","req":"GET /mentions-legales","status":200,"ms":11,"rid":"⟬uuid#35⟭","router":"statique@docker"}
{"time":"⟬date#1⟭ 10:03:15","client":"⟬ip_address#7⟭","req":"GET /nous-contacter","status":200,"ms":12,"rid":"⟬uuid#36⟭","router":"statique@docker"}
{"time":"⟬date#1⟭ 10:03:31","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#37⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:03:44","client":"⟬ip_address#8⟭","req":"GET /api/garanties?⟬trap:indicator_non_pii|assure=exemple⟭","status":200,"ms":35,"rid":"⟬uuid#38⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:03:52","client":"⟬ip_address#8⟭","req":"GET /api/simulation?⟬trap:indicator_non_pii|age_conducteur=30⟭&bonus=50","status":200,"ms":71,"rid":"⟬uuid#39⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:04:01","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#40⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:04:12","client":"⟬ip_address#9⟭","req":"POST /api/contact","status":429,"ms":1,"rid":"⟬uuid#41⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:04:13","client":"⟬ip_address#9⟭","req":"POST /api/contact","status":429,"ms":1,"rid":"⟬uuid#42⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:04:13","client":"⟬ip_address#9⟭","req":"POST /api/contact","status":429,"ms":1,"rid":"⟬uuid#43⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:04:31","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#44⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:04:50","client":"⟬ip_address#10⟭","req":"GET /devis/sante","status":200,"ms":40,"rid":"⟬uuid#45⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:04:55","client":"⟬ip_address#10⟭","req":"GET /api/formules?⟬trap:indicator_non_pii|souscripteur=couple⟭","status":200,"ms":28,"rid":"⟬uuid#46⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:05:01","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#47⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:05:09","client":"⟬ip_address#10⟭","req":"GET /api/formules?⟬trap:indicator_non_pii|souscripteur=seul⟭&enfants=2","status":200,"ms":26,"rid":"⟬uuid#48⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:05:20","client":"⟬ip_address#10⟭","req":"POST /api/devis","status":201,"ms":133,"rid":"⟬uuid#49⟭","router":"devis@docker","ref":"⟬order_number#4⟭"}
{"time":"⟬date#1⟭ 10:05:31","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#50⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:05:44","client":"⟬ip_address#11⟭","req":"GET /api/health/ready","status":503,"ms":5002,"rid":"⟬uuid#51⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:05:50","client":"⟬ip_address#11⟭","req":"GET /api/health/ready","status":200,"ms":14,"rid":"⟬uuid#52⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:06:01","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#53⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:06:18","client":"⟬ip_address#12⟭","req":"GET /devis/auto","status":200,"ms":41,"rid":"⟬uuid#54⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:06:19","client":"⟬ip_address#12⟭","req":"GET /api/marques","status":200,"ms":20,"rid":"⟬uuid#55⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:06:26","client":"⟬ip_address#12⟭","req":"GET /api/modeles?marque=⟬trap:company_name|Ferrari⟭","status":200,"ms":27,"rid":"⟬uuid#56⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:06:31","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#57⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:06:40","client":"⟬ip_address#12⟭","req":"GET /api/finitions?modele=roma","status":200,"ms":16,"rid":"⟬uuid#58⟭","router":"devis@docker"}
{"time":"⟬date#1⟭ 10:06:52","client":"⟬ip_address#12⟭","req":"POST /api/devis","status":201,"ms":118,"rid":"⟬uuid#59⟭","router":"devis@docker","ref":"⟬order_number#5⟭"}
{"time":"⟬date#1⟭ 10:07:01","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#60⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:07:31","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#61⟭","router":"sonde@docker"}
{"time":"⟬date#1⟭ 10:08:01","client":"⟬ip_address#3⟭","req":"GET /ping","status":200,"ms":1,"rid":"⟬uuid#62⟭","router":"sonde@docker"}
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: Jenkins console, shell trace, sample rows, HTTP header
scenario: nightly Jenkins job pseudonymising a hospital test database, whose debug mode prints rows before processing and the credentials used
⟬text⟭
Started by timer
Running as SYSTEM
Building in workspace /var/lib/jenkins/workspace/recette-pseudonymisation
[recette-pseudonymisation] $ /bin/bash -xe /tmp/jenkins8812044315.sh
+ echo 'pseudonymisation recette, branche main'
pseudonymisation recette, branche main
+ source ./ci/recette.env
++ export PGHOST=⟬hostname#1⟭
++ PGHOST=⟬hostname#1⟭
++ export ⟬trap:indicator_non_pii|PGUSER=recette_pseudo⟭
++ ⟬trap:indicator_non_pii|PGUSER=recette_pseudo⟭
++ export PGPASSWORD=⟬password#1⟭
++ PGPASSWORD=⟬password#1⟭
++ export PSEUDO_SEL=⟬opaque_token#1⟭
++ PSEUDO_SEL=⟬opaque_token#1⟭
+ python3 -m pseudo.run --schema dpi --debug
INFO pseudo.run: connexion a ⟬hostname#1⟭ en tant que ⟬trap:indicator_non_pii|user recette_pseudo⟭
INFO pseudo.run: 14 tables a traiter
INFO pseudo.table: patient: 182440 lignes
DEBUG pseudo.table: patient: echantillon avant traitement
DEBUG pseudo.table: (⟬customer_id#2⟭, "⟬person_name#2⟭", '⟬birth_date#2⟭', '⟬fr_social_security_number#2⟭', '⟬phone#2⟭')
DEBUG pseudo.table: (⟬customer_id#3⟭, "⟬person_name#3⟭", '⟬birth_date#3⟭', '⟬fr_social_security_number#3⟭', '⟬phone#3⟭')
DEBUG pseudo.table: (⟬customer_id#4⟭, "⟬person_name#4⟭", '⟬birth_date#4⟭', '⟬fr_social_security_number#4⟭', NULL)
DEBUG pseudo.table: patient: echantillon apres traitement
DEBUG pseudo.table: (⟬customer_id#5⟭, ⟬trap:indicator_non_pii|PSEUDO-000001⟭, ⟬trap:indicator_non_pii|NULL⟭, NULL, NULL)
DEBUG pseudo.table: (⟬customer_id#6⟭, ⟬trap:indicator_non_pii|PSEUDO-000002⟭, ⟬trap:indicator_non_pii|NULL⟭, NULL, NULL)
INFO pseudo.table: patient: termine en 412 s
INFO pseudo.table: venue: 910221 lignes, aucune colonne directe
INFO pseudo.table: venue: termine en 88 s
INFO pseudo.table: professionnel: 4120 lignes
DEBUG pseudo.table: professionnel: echantillon avant traitement
DEBUG pseudo.table: (⟬customer_id#7⟭, "Dr ⟬person_name#7⟭", '⟬email#7⟭', '⟬trap:initials|J.-P.⟭')
INFO pseudo.table: professionnel: termine en 21 s
INFO pseudo.table: compte_rendu: 330871 lignes, texte libre remplace par un gabarit
WARN pseudo.table: compte_rendu: 12 lignes contiennent encore un motif de NIR
DEBUG pseudo.table: compte_rendu: ligne ⟬uuid#1⟭: "pris en charge pour ⟬person_name#8f⟭, NIR ⟬fr_social_security_number#8⟭, adressée par sa fille"
INFO pseudo.table: compte_rendu: lignes signalees dans ⟬file_path#1⟭
INFO pseudo.table: facture: 77120 lignes, colonnes iban et mutuelle videes
INFO pseudo.table: ordonnance: 402112 lignes
INFO pseudo.table: rendez_vous: 120220 lignes
INFO pseudo.table: rendez_vous: ⟬trap:indicator_non_pii|contact_sms=NULL⟭ pour toutes les lignes
INFO pseudo.run: analyse des index
INFO pseudo.run: 14 tables traitees en 1021 s
+ curl -sS -X POST -H 'Authorization: Bearer ⟬jwt#1⟭' ⟬url#1⟭ -d '{"etat":"recette_prete"}'
{"recu":true,"horodatage":"⟬date#1⟭ 03:41:07"}
+ python3 -m pseudo.controle --echantillon 500
INFO pseudo.controle: 500 fiches tirees au sort
INFO pseudo.controle: aucune correspondance avec le referentiel nominatif
INFO pseudo.controle: rapport ecrit dans ⟬file_path#2⟭
+ python3 -m pseudo.purge --plus-vieux-que 30
INFO pseudo.purge: 3 sauvegardes supprimees sur ⟬hostname#2⟭
INFO pseudo.purge: espace libere 41 Go
+ pg_dump -Fc -f /backup/recette.dump dpi
+ sha256sum /backup/recette.dump
⟬hash#1⟭  /backup/recette.dump
+ scp /backup/recette.dump ⟬trap:email_lookalike|recette@stockage⟭:/depots/
+ echo termine
termine
Archiving artifacts
Recording test results
Sending e-mails to: ⟬email:generic#9⟭
Finished: SUCCESS
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Envoy access log, URL path, query string, upstream field
scenario: Envoy access of identity checks for an operator's SIM activation, with passports in paths and tokens in query strings
⟬text⟭
[⟬date#1⟭ 12:01:04.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 2 1 "-" "kube-probe/1.29" "⟬uuid#1⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:01:09.402] "POST /kyc/session HTTP/2" 201 - 188 312 96 95 "⟬ip_address#1⟭" "Mobile-App/5.12 (Android)" "⟬uuid#2⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:01:11.017] "POST /kyc/passeport/⟬fr_passport#1⟭/verifier?session=⟬opaque_token#1⟭ HTTP/2" 200 - 2048 244 830 829 "⟬ip_address#1⟭" "Mobile-App/5.12 (Android)" "⟬uuid#3⟭" "kyc.interne" "⟬hostname#2⟭"
[⟬date#1⟭ 12:01:12.144] "GET /kyc/resultat?token=⟬jwt#1⟭ HTTP/2" 200 - 0 188 41 40 "⟬ip_address#1⟭" "Mobile-App/5.12 (Android)" "⟬uuid#4⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:01:14.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#5⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:01:20.555] "POST /sim/activation?ref=⟬order_number#2⟭ HTTP/2" 202 - 96 64 212 211 "⟬ip_address#1⟭" "Mobile-App/5.12 (Android)" "⟬uuid#6⟭" "sim.interne" "⟬hostname#3⟭"
[⟬date#1⟭ 12:01:24.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 0 "-" "kube-probe/1.29" "⟬uuid#7⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:01:31.208] "POST /kyc/session HTTP/2" 201 - 188 312 88 88 "⟬ip_address#2⟭" "Mobile-App/5.11 (iOS)" "⟬uuid#8⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:01:33.902] "POST /kyc/passeport/⟬fr_passport#2⟭/verifier?session=⟬opaque_token#2⟭ HTTP/2" 422 - 2048 96 511 510 "⟬ip_address#2⟭" "Mobile-App/5.11 (iOS)" "⟬uuid#9⟭" "kyc.interne" "⟬hostname#2⟭"
[⟬date#1⟭ 12:01:34.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#10⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:01:40.661] "POST /kyc/passeport/⟬fr_passport#2⟭/verifier?session=⟬opaque_token#2⟭ HTTP/2" 200 - 2112 244 790 790 "⟬ip_address#2⟭" "Mobile-App/5.11 (iOS)" "⟬uuid#11⟭" "kyc.interne" "⟬hostname#2⟭"
[⟬date#1⟭ 12:01:41.730] "GET /kyc/resultat?token=⟬jwt#2⟭ HTTP/2" 200 - 0 188 39 38 "⟬ip_address#2⟭" "Mobile-App/5.11 (iOS)" "⟬uuid#12⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:01:44.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#13⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:01:52.019] "POST /sim/activation?ref=⟬order_number#3⟭ HTTP/2" 202 - 96 64 198 198 "⟬ip_address#2⟭" "Mobile-App/5.11 (iOS)" "⟬uuid#14⟭" "sim.interne" "⟬hostname#3⟭"
[⟬date#1⟭ 12:01:54.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 0 "-" "kube-probe/1.29" "⟬uuid#15⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:02:03.340] "GET /boutique/offres?⟬trap:indicator_non_pii|client=prospect⟭ HTTP/2" 200 - 0 8120 44 43 "⟬ip_address#3⟭" "Mozilla/5.0 (Windows NT 10.0)" "⟬uuid#16⟭" "boutique.interne" "⟬hostname#4⟭"
[⟬date#1⟭ 12:02:04.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#17⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:02:11.871] "GET /boutique/couverture?cp=⟬postcode#1⟭ HTTP/2" 200 - 0 2204 61 60 "⟬ip_address#3⟭" "Mozilla/5.0 (Windows NT 10.0)" "⟬uuid#18⟭" "boutique.interne" "⟬hostname#4⟭"
[⟬date#1⟭ 12:02:14.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 0 "-" "kube-probe/1.29" "⟬uuid#19⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:02:19.008] "POST /boutique/panier HTTP/2" 201 - 244 96 81 80 "⟬ip_address#3⟭" "Mozilla/5.0 (Windows NT 10.0)" "⟬uuid#20⟭" "boutique.interne" "⟬hostname#4⟭"
[⟬date#1⟭ 12:02:24.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#21⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:02:31.402] "POST /kyc/session HTTP/2" 201 - 188 312 92 91 "⟬ip_address#3⟭" "Mozilla/5.0 (Windows NT 10.0)" "⟬uuid#22⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:02:34.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#23⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:02:38.660] "POST /kyc/cni/⟬fr_identity_card#3⟭/verifier?session=⟬opaque_token#3⟭ HTTP/2" 200 - 1980 244 702 701 "⟬ip_address#3⟭" "Mozilla/5.0 (Windows NT 10.0)" "⟬uuid#24⟭" "kyc.interne" "⟬hostname#2⟭"
[⟬date#1⟭ 12:02:39.701] "GET /kyc/resultat?token=⟬jwt#3⟭ HTTP/2" 200 - 0 188 37 36 "⟬ip_address#3⟭" "Mozilla/5.0 (Windows NT 10.0)" "⟬uuid#25⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:02:44.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 0 "-" "kube-probe/1.29" "⟬uuid#26⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:02:48.330] "POST /boutique/paiement?ref=⟬order_number#4⟭ HTTP/2" 200 - 412 188 640 639 "⟬ip_address#3⟭" "Mozilla/5.0 (Windows NT 10.0)" "⟬uuid#27⟭" "boutique.interne" "⟬hostname#4⟭"
[⟬date#1⟭ 12:02:54.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#28⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:03:02.114] "GET /espace/lignes?⟬trap:indicator_non_pii|user=me⟭ HTTP/2" 200 - 0 1104 73 72 "⟬ip_address#4⟭" "Mobile-App/5.12 (Android)" "⟬uuid#29⟭" "espace.interne" "⟬hostname#5⟭"
[⟬date#1⟭ 12:03:04.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#30⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:03:09.701] "GET /espace/conso?mois=courant HTTP/2" 200 - 0 2244 112 111 "⟬ip_address#4⟭" "Mobile-App/5.12 (Android)" "⟬uuid#31⟭" "espace.interne" "⟬hostname#5⟭"
[⟬date#1⟭ 12:03:14.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 0 "-" "kube-probe/1.29" "⟬uuid#32⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:03:20.004] "POST /espace/mot-de-passe?token=⟬opaque_token#4⟭ HTTP/2" 204 - 96 0 141 140 "⟬ip_address#4⟭" "Mobile-App/5.12 (Android)" "⟬uuid#33⟭" "espace.interne" "⟬hostname#5⟭"
[⟬date#1⟭ 12:03:24.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#34⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:03:33.520] "GET /espace/factures/⟬invoice_number#4⟭ HTTP/2" 200 - 0 40112 96 95 "⟬ip_address#4⟭" "Mobile-App/5.12 (Android)" "⟬uuid#35⟭" "espace.interne" "⟬hostname#5⟭"
[⟬date#1⟭ 12:03:34.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#36⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:03:44.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 0 "-" "kube-probe/1.29" "⟬uuid#37⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:03:51.207] "POST /kyc/session HTTP/2" 201 - 188 312 90 89 "⟬ip_address#5⟭" "Mobile-App/5.12 (Android)" "⟬uuid#38⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:03:53.880] "POST /kyc/passeport/⟬fr_passport#5⟭/verifier?session=⟬opaque_token#5⟭ HTTP/2" 503 UF 2048 91 3001 - "⟬ip_address#5⟭" "Mobile-App/5.12 (Android)" "⟬uuid#39⟭" "kyc.interne" "-"
[⟬date#1⟭ 12:03:54.120] "GET /kyc/health HTTP/1.1" 503 - 0 19 1 1 "-" "kube-probe/1.29" "⟬uuid#40⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:03:58.310] "POST /kyc/passeport/⟬fr_passport#5⟭/verifier?session=⟬opaque_token#5⟭ HTTP/2" 503 UF 2048 91 3001 - "⟬ip_address#5⟭" "Mobile-App/5.12 (Android)" "⟬uuid#41⟭" "kyc.interne" "-"
[⟬date#1⟭ 12:04:04.120] "GET /kyc/health HTTP/1.1" 503 - 0 19 1 0 "-" "kube-probe/1.29" "⟬uuid#42⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:04:14.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#43⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:04:19.442] "POST /kyc/passeport/⟬fr_passport#5⟭/verifier?session=⟬opaque_token#5⟭ HTTP/2" 200 - 2048 244 912 911 "⟬ip_address#5⟭" "Mobile-App/5.12 (Android)" "⟬uuid#44⟭" "kyc.interne" "⟬hostname#2⟭"
[⟬date#1⟭ 12:04:20.601] "GET /kyc/resultat?token=⟬jwt#5⟭ HTTP/2" 200 - 0 188 42 41 "⟬ip_address#5⟭" "Mobile-App/5.12 (Android)" "⟬uuid#45⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:04:24.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#46⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:04:29.118] "POST /sim/activation?ref=⟬order_number#5⟭ HTTP/2" 202 - 96 64 203 202 "⟬ip_address#5⟭" "Mobile-App/5.12 (Android)" "⟬uuid#47⟭" "sim.interne" "⟬hostname#3⟭"
[⟬date#1⟭ 12:04:34.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 0 "-" "kube-probe/1.29" "⟬uuid#48⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:04:44.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#49⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:04:51.044] "GET /boutique/offres HTTP/2" 200 - 0 8120 39 38 "⟬ip_address#6⟭" "Mozilla/5.0 (Macintosh)" "⟬uuid#50⟭" "boutique.interne" "⟬hostname#4⟭"
[⟬date#1⟭ 12:04:54.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#51⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:05:02.331] "GET /boutique/couverture?cp=⟬postcode#2⟭ HTTP/2" 200 - 0 2204 58 57 "⟬ip_address#6⟭" "Mozilla/5.0 (Macintosh)" "⟬uuid#52⟭" "boutique.interne" "⟬hostname#4⟭"
[⟬date#1⟭ 12:05:04.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 0 "-" "kube-probe/1.29" "⟬uuid#53⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:05:14.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#54⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:05:20.778] "POST /espace/connexion HTTP/2" 401 - 96 88 204 203 "⟬ip_address#7⟭" "python-requests/2.31.0" "⟬uuid#55⟭" "espace.interne" "⟬hostname#5⟭"
[⟬date#1⟭ 12:05:21.044] "POST /espace/connexion HTTP/2" 401 - 96 88 198 197 "⟬ip_address#7⟭" "python-requests/2.31.0" "⟬uuid#56⟭" "espace.interne" "⟬hostname#5⟭"
[⟬date#1⟭ 12:05:21.310] "POST /espace/connexion HTTP/2" 429 - 96 41 2 - "⟬ip_address#7⟭" "python-requests/2.31.0" "⟬uuid#57⟭" "espace.interne" "-"
[⟬date#1⟭ 12:05:24.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#58⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:05:34.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 0 "-" "kube-probe/1.29" "⟬uuid#59⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:05:44.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 1 "-" "kube-probe/1.29" "⟬uuid#60⟭" "kyc.interne" "⟬hostname#1⟭"
[⟬date#1⟭ 12:05:51.208] "POST /espace/connexion HTTP/2" 200 - 96 412 188 187 "⟬ip_address#8⟭" "Mobile-App/5.12 (Android)" "⟬uuid#61⟭" "espace.interne" "⟬hostname#5⟭"
[⟬date#1⟭ 12:05:54.120] "GET /kyc/health HTTP/1.1" 200 - 0 15 1 0 "-" "kube-probe/1.29" "⟬uuid#62⟭" "kyc.interne" "⟬hostname#1⟭"
⟬end⟭
