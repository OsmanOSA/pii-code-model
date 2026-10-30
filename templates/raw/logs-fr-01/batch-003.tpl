⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Drone CI step output, seed output, CLI argument
scenario: Drone pipeline of a town's digital counter, whose seed step prints the demo user, their passport and the admin password
⟬text⟭
[clone:1] + git fetch origin +refs/heads/recette
[migrer:2] + ./manage.py migrate --noinput
[migrer:3] Operations to perform: Apply all migrations
[jeu-essai:4] + ./manage.py charger_jeu_essai --bavard
[jeu-essai:5] usager demo: "⟬person_name#1⟭" passeport=⟬fr_passport#1⟭
[jeu-essai:6] 42 demandes creees
[jeu-essai:7] + ./manage.py creer_admin --nom ⟬trap:indicator_non_pii|admin-recette⟭ --mdp ⟬password#2⟭
[jeu-essai:8] compte admin pret
[publier:9] + rsync -a dist/ ⟬trap:email_lookalike|deploy@recette-guichet⟭:/srv/guichet/
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: pipe-separated log, key=value
scenario: consultation trace of the drivers file by brokers, one line per search with plate and licence
⟬text⟭
AUD|⟬date#1⟭|14:22:03|CONSULT|FICHE_CONDUCTEUR|courtier=⟬company#1⟭|plaque=⟬fr_license_plate#2⟭|resultat=1
AUD|⟬date#1⟭|14:22:41|CONSULT|ANTECEDENTS|courtier=⟬company#1⟭|permis=⟬fr_driving_licence#2⟭|resultat=3
AUD|⟬date#1⟭|14:23:02|EXPORT|ANTECEDENTS|courtier=⟬company#1⟭|operateur=⟬person_name#3⟭|format=PDF
AUD|⟬date#1⟭|14:25:19|CONSULT|FICHE_CONDUCTEUR|courtier=⟬company#4⟭|plaque=⟬fr_license_plate#5⟭|resultat=0
AUD|⟬date#1⟭|14:30:00|PURGE|CACHE|operateur=⟬trap:indicator_non_pii|tache-planifiee⟭|lignes=204
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: log field, street without number
scenario: log preparing a town hall's polling stations, citing streets and schools without numbers and no person
⟬text⟭
[elections] chargement du découpage: 24 bureaux
[elections] bureau 3 fixé à l'école ⟬trap:word_name|Jules Ferry⟭, ⟬trap:word_name|rue Victor Hugo⟭
[elections] bureau 7 déplacé vers le gymnase ⟬trap:word_name|Pierre de Coubertin⟭, travaux ⟬trap:word_name|rue du 8 Mai 1945⟭
[elections] liste des assesseurs: ⟬trap:indicator_non_pii|nom=non renseigné⟭ pour 2 bureaux
[elections] affichage généré dans ⟬file_path#1⟭
[elections] terminé, 0 erreur
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: Ruby exception, validation message
scenario: Rails exception of a vaccination tracking app, raised when validating a NIR, with a message repeating the birth date
⟬text⟭
ActiveRecord::RecordInvalid (La validation a échoué : Nir ⟬fr_social_security_number#1⟭ ne correspond pas à la date de naissance ⟬birth_date#1⟭):

app/models/patient.rb:34:in `verifier_nir'
app/services/import_vaccination.rb:71:in `block in appliquer'
app/services/import_vaccination.rb:58:in `each'
app/jobs/import_centre_job.rb:12:in `perform'
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: insurance
appearance: RSpec output, code identifier
scenario: RSpec output of a life insurer's reserves engine, with eponymous mortality laws and no policyholder
⟬text⟭
Provision mathématique
  avec la table de ⟬trap:eponym|Gompertz-Makeham⟭
    calcule la provision à terme échu
    arrondit au centime (FAILED - 1)

Failures:

  1) Provision mathématique avec la table de ⟬trap:eponym|Gompertz-Makeham⟭ arrondit au centime
     Failure/Error: expect(⟬trap:code_identifier|provision_⦃family⦄⟭(contrat_type)).to eq(412.50)
       expected: 412.5
            got: 412.49
     # ./spec/provisions/calcul_spec.rb:27:in `block (3 levels) in <top (required)>'

Finished in 0.4127 seconds (files took 1.82 seconds to load)
2 examples, 1 failure
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: custom nginx format, query string, upstream timing
scenario: nginx access of a hospital FHIR gateway in a custom format, with a JWT and a document access code in the URL
⟬text⟭
rt=0.214 ua=- st=200 ip=⟬ip_address#1⟭ t="⟬date#1⟭ 16:01:12" r="GET /fhir/Patient/⟬uuid#1⟭?_token=⟬jwt#1⟭ HTTP/1.1"
rt=0.097 ua=- st=200 ip=⟬ip_address#1⟭ t="⟬date#1⟭ 16:01:13" r="GET /fhir/Observation?subject=⟬uuid#1⟭&_count=50 HTTP/1.1"
rt=1.204 ua=- st=200 ip=⟬ip_address#2⟭ t="⟬date#1⟭ 16:01:40" r="GET /docs/compte-rendu?access=⟬opaque_token#1⟭ HTTP/1.1"
rt=0.003 ua=- st=403 ip=⟬ip_address#3⟭ t="⟬date#1⟭ 16:02:02" r="GET /fhir/Patient?identifier=⟬customer_id#2⟭ HTTP/1.1"
rt=0.001 ua=- st=200 ip=⟬ip_address#4⟭ t="⟬date#1⟭ 16:02:05" r="GET /fhir/metadata HTTP/1.1"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: Azure DevOps log, quality gate, dependency update
scenario: Azure DevOps pipeline of a subscription software, with tests, Sonar analysis and a bot commit, without any sensitive value
⟬text⟭
##[section]Starting: Analyse qualité
Task         : Maven
Version      : ⟬version#1⟭
##[command]/usr/bin/mvn -B verify -Dsonar.login=⟬trap:placeholder|$(SONAR_TOKEN)⟭
[INFO] Scanning for projects...
[INFO] Building souscription-core ⟬version#2⟭
[INFO] --- jacoco:0.8.11:prepare-agent (default) @ souscription-core ---
[INFO] Tests run: 642, Failures: 0, Errors: 0, Skipped: 3
[INFO] --- sonar:3.10.0:sonar (default-cli) @ souscription-core ---
[INFO] Quality gate: OK (couverture 81,4 %, duplication 2,1 %)
[WARNING] com.fasterxml.⟬trap:library|jackson⟭.core:jackson-databind ⟬version#3⟭ a une mise à jour disponible
[INFO] BUILD SUCCESS
##[section]Finishing: Analyse qualité
##[section]Starting: Mise à jour des dépendances
⟬git_sha#1⟭ chore(deps): bump ⟬trap:library|flask⟭ de ⟬version#4⟭ à ⟬version#5⟭
⟬trap:indicator_non_pii|Author: dependabot[bot]⟭
⟬trap:indicator_non_pii|Reviewer: equipe-souscription⟭
##[section]Finishing: Mise à jour des dépendances
##[section]Async Command Start: Publish Pipeline Metadata
##[section]Finishing: Finalize Job
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Terraform output, connection string, sensitive value
scenario: Terraform apply of an operator's billing platform, where outputs and a local-exec expose a password, a DSN and an API key
⟬text⟭
Terraform will perform the following actions:

  # module.facturation.aws_db_instance.bss will be updated in-place
  ~ resource "aws_db_instance" "bss" {
      ~ instance_class = "db.r6g.xlarge" -> "db.r6g.2xlarge"
      ~ password       = ⟬trap:placeholder|(sensitive value)⟭
        id             = "bss-prod"
        tags           = { "owner" = "⟬trap:indicator_non_pii|equipe-facturation⟭" }
    }

Plan: 0 to add, 1 to change, 0 to destroy.
module.facturation.aws_db_instance.bss: Modifying... [id=bss-prod]
module.facturation.aws_db_instance.bss: Modifications complete after 4m12s
module.dns.null_resource.sync (local-exec): Executing: ["/bin/sh" "-c" "curl -s -H 'X-Auth: ⟬opaque_token#1⟭' ⟬url#1⟭"]
module.dns.null_resource.sync (local-exec): {"zone":"bss.interne","statut":"synchronise"}

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

admin_user = "⟬trap:indicator_non_pii|bss_admin⟭"
admin_password = "⟬password#1⟭"
connection_string = "mysql://bss_admin:⟬url_password#2⟭@⟬hostname#1⟭:3306/facturation"
endpoint = "⟬hostname#1⟭"
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Keycloak event, key=value, quoted value
scenario: Keycloak events and business accesses over two days at a benefits agency, with agents, a viewed NIR and a checked passport
⟬text⟭
⟬date#2⟭ 09:11:04 INFO  [org.keycloak.events] type=LOGIN, realmId=agents, clientId=gestion-droits, userId=⟬uuid#1⟭, ipAddress=⟬ip_address#1⟭, username=⟬person_name:handle#1⟭
⟬date#2⟭ 09:13:27 INFO  [fr.caisse.audit] acteur=⟬person_name:handle#1⟭ action=LECTURE objet=allocataire nir=⟬fr_social_security_number#2⟭
⟬date#2⟭ 09:14:02 INFO  [fr.caisse.audit] acteur=⟬person_name:handle#1⟭ action=LECTURE objet=piece type=PASSEPORT numero=⟬fr_passport#2⟭
⟬date#2⟭ 09:16:40 INFO  [fr.caisse.audit] acteur=⟬person_name:handle#1⟭ action=NOTE objet=allocataire texte="identite de ⟬person_name#2⟭ confirmee au guichet"
⟬date#2⟭ 09:20:13 INFO  [org.keycloak.events] type=LOGOUT, realmId=agents, clientId=gestion-droits, userId=⟬uuid#1⟭, ipAddress=⟬ip_address#1⟭
⟬date#2⟭ 11:00:00 INFO  [fr.caisse.audit] acteur=⟬trap:indicator_non_pii|batch-recalcul⟭ action=RECALCUL objet=droits lignes=8812
⟬date#2⟭ 11:42:18 WARN  [org.keycloak.events] type=LOGIN_ERROR, realmId=agents, clientId=gestion-droits, error=invalid_user_credentials, username=⟬person_name:handle#3⟭, ipAddress=⟬ip_address#2⟭
⟬date#2⟭ 11:42:33 WARN  [org.keycloak.events] type=LOGIN_ERROR, realmId=agents, clientId=gestion-droits, error=invalid_user_credentials, username=⟬person_name:handle#3⟭, ipAddress=⟬ip_address#2⟭
⟬date#2⟭ 11:43:02 INFO  [org.keycloak.events] type=UPDATE_PASSWORD, realmId=agents, clientId=account, userId=⟬uuid#3⟭, ipAddress=⟬ip_address#2⟭
⟬date#1⟭ 12:05:47 INFO  [org.keycloak.events] type=LOGIN, realmId=agents, clientId=gestion-droits, userId=⟬uuid#3⟭, ipAddress=⟬ip_address#2⟭, username=⟬person_name:handle#3⟭
⟬date#1⟭ 12:08:11 INFO  [fr.caisse.audit] acteur=⟬person_name:handle#3⟭ action=MODIFICATION objet=allocataire champ=adresse nouvelle="⟬fr_postal_address#4⟭"
⟬date#1⟭ 12:08:12 INFO  [fr.caisse.audit] acteur=⟬trap:indicator_non_pii|moteur-droits⟭ action=RECALCUL objet=droits allocataire=⟬customer_id#4⟭
⟬date#1⟭ 12:10:55 INFO  [fr.caisse.audit] acteur=⟬person_name:handle#3⟭ action=LECTURE objet=piece type=PASSEPORT numero=⟬fr_passport#4⟭
⟬date#1⟭ 12:11:30 INFO  [fr.caisse.audit] acteur=⟬person_name:handle#3⟭ action=VALIDATION objet=dossier reference=⟬ticket_id#1⟭
⟬date#1⟭ 12:30:02 INFO  [org.keycloak.events] type=LOGOUT, realmId=agents, clientId=gestion-droits, userId=⟬uuid#3⟭, ipAddress=⟬ip_address#2⟭
⟬date#1⟭ 13:00:00 INFO  [fr.caisse.audit] acteur=⟬trap:indicator_non_pii|purge-sessions⟭ action=PURGE objet=sessions lignes=64
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: JSON log line, key rename, nested JSON
scenario: audit log of a merchant site's back office, as JSON, tracing refunds and seller bank detail changes by people and robots
⟬text⟭
{"ts":"⟬date#1⟭ 10:12:04","acteur":"⟬person_name#1⟭","role":"support","action":"remboursement.creer","commande":"⟬order_number#2⟭","montant":54.90}
{"ts":"⟬date#1⟭ 10:12:05","acteur":"⟬trap:indicator_non_pii|robot-paiement⟭","role":"systeme","action":"remboursement.envoyer","commande":"⟬order_number#2⟭","reference":"⟬uuid#1⟭"}
{"ts":"⟬date#1⟭ 10:14:37","acteur":"⟬person_name#1⟭","role":"support","action":"carte.afficher","client":"⟬customer_id#2⟭","numero":"⟬payment_card#2⟭"}
{"ts":"⟬date#1⟭ 10:14:38","acteur":"⟬trap:indicator_non_pii|regle-fraude-12⟭","role":"systeme","action":"alerte.creer","motif":"affichage carte hors procedure","client":"⟬customer_id#2⟭"}
{"ts":"⟬date#1⟭ 10:31:09","acteur":"⟬person_name#3⟭","role":"vendeur","action":"rib.modifier","avant":{"iban":"⟬iban#3⟭"},"apres":{"iban":"⟬iban#4⟭"}}
{"ts":"⟬date#1⟭ 10:31:10","acteur":"⟬trap:indicator_non_pii|robot-kyc⟭","role":"systeme","action":"vendeur.bloquer","vendeur":"⟬company#3⟭","siret":"⟬fr_siret#3⟭"}
{"ts":"⟬date#1⟭ 10:45:51","acteur":"⟬person_name#5⟭","role":"conformite","action":"vendeur.debloquer","vendeur":"⟬company#3⟭","commentaire":"appel au ⟬phone#3⟭, RIB confirme"}
{"ts":"⟬date#1⟭ 10:50:12","acteur":"⟬trap:indicator_non_pii|equipe-catalogue⟭","role":"import","action":"produits.importer","fichier":"catalogue.csv","lignes":1204}
{"ts":"⟬date#1⟭ 11:02:44","acteur":"⟬person_name#1⟭","role":"support","action":"client.fusionner","source":"⟬customer_id#2⟭","cible":"⟬customer_id#6⟭"}
{"ts":"⟬date#1⟭ 11:05:03","acteur":"⟬person_name#7⟭","role":"admin","action":"role.attribuer","cible":"⟬email#1⟭","nouveau_role":"superviseur"}
{"ts":"⟬date#1⟭ 11:20:30","acteur":"⟬trap:indicator_non_pii|robot-paiement⟭","role":"systeme","action":"reversement.lancer","lot":"⟬uuid#2⟭","vendeurs":218}
{"ts":"⟬date#1⟭ 11:20:41","acteur":"⟬trap:indicator_non_pii|robot-paiement⟭","role":"systeme","action":"reversement.terminer","lot":"⟬uuid#2⟭","rejets":1,"iban_rejete":"⟬iban#8⟭"}
{"ts":"⟬date#1⟭ 11:40:18","acteur":"⟬person_name#5⟭","role":"conformite","action":"export.demander","objet":"journal","periode":"30j"}
{"ts":"⟬date#1⟭ 11:40:19","acteur":"⟬trap:indicator_non_pii|robot-export⟭","role":"systeme","action":"export.ecrire","url":"⟬url#1⟭"}
{"ts":"⟬date#1⟭ 12:00:00","acteur":"⟬trap:indicator_non_pii|plateforme⟭","role":"systeme","action":"cle.tourner","empreinte":"⟬hash#1⟭"}
{"ts":"⟬date#1⟭ 12:03:07","acteur":"⟬person_name#7⟭","role":"admin","action":"session.revoquer","cible":"⟬email#1⟭"}
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: JSON log line, nested JSON, secret under an innocuous key
scenario: pino log of a teleconsultation platform, where the call to the entitlement service sends NIR and birth date, with a doctor and a room token
⟬text⟭
{"level":30,"t":"⟬date#1⟭ 17:30:02","svc":"teleconsult","msg":"salle ouverte","salle":"⟬uuid#1⟭","medecin":"Dr ⟬person_name#1⟭"}
{"level":20,"t":"⟬date#1⟭ 17:30:02","svc":"teleconsult","msg":"jeton de salle genere","salle":"⟬uuid#1⟭","value":"⟬opaque_token#1⟭"}
{"level":30,"t":"⟬date#1⟭ 17:30:44","svc":"teleconsult","msg":"patiente connectee","salle":"⟬uuid#1⟭","ip":"⟬ip_address#1⟭"}
{"level":20,"t":"⟬date#1⟭ 17:30:45","svc":"droits","msg":"appel service de droits","corps":{"nir":"⟬fr_social_security_number#2⟭","naissance":"⟬birth_date#2⟭","rang":1}}
{"level":30,"t":"⟬date#1⟭ 17:30:46","svc":"droits","msg":"droits ouverts","regime":"general","ald":false}
{"level":30,"t":"⟬date#1⟭ 17:30:46","svc":"teleconsult","msg":"dossier charge","patiente":"⟬person_name#2f⟭","age":⟬age#2⟭}
{"level":40,"t":"⟬date#1⟭ 17:34:12","svc":"visio","msg":"debit faible","salle":"⟬uuid#1⟭","kbps":180}
{"level":40,"t":"⟬date#1⟭ 17:36:30","svc":"visio","msg":"reconnexion","salle":"⟬uuid#1⟭","value":"⟬uuid#2⟭"}
{"level":30,"t":"⟬date#1⟭ 17:44:02","svc":"ordonnance","msg":"ordonnance signee","numero":"⟬order_number#1⟭","medecin":"Dr ⟬person_name#1⟭"}
{"level":20,"t":"⟬date#1⟭ 17:44:03","svc":"ordonnance","msg":"envoi par courriel","destinataire":"⟬email#2⟭"}
{"level":30,"t":"⟬date#1⟭ 17:44:04","svc":"facturation","msg":"feuille de soins electronique","patiente":"⟬customer_id#2⟭","montant":25.00}
{"level":50,"t":"⟬date#1⟭ 17:44:09","svc":"facturation","msg":"rejet noemie","code":"E412","nir":"⟬fr_social_security_number#2⟭"}
{"level":30,"t":"⟬date#1⟭ 17:44:09","svc":"facturation","msg":"reprise manuelle","file":"⟬trap:indicator_non_pii|gestionnaire=secretariat⟭"}
{"level":30,"t":"⟬date#1⟭ 17:45:00","svc":"teleconsult","msg":"salle fermee","salle":"⟬uuid#1⟭","duree_s":898}
{"level":30,"t":"⟬date#1⟭ 17:45:01","svc":"metriques","msg":"export","cible":"⟬url#1⟭"}
{"level":30,"t":"⟬date#1⟭ 18:00:00","svc":"teleconsult","msg":"planning recharge","creneaux":31,"owner":"⟬trap:indicator_non_pii|regulation⟭"}
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: banking
appearance: Java stack trace, JDBC error, code identifier
scenario: connection pool exhaustion at a bank after a service account authentication failure, with no customer data
⟬text⟭
⟬date#1⟭ 03:12:44.019 ERROR [rapprochement-7] o.s.t.i.TransactionInterceptor - Application exception overridden by rollback exception
org.springframework.jdbc.CannotGetJdbcConnectionException: Failed to obtain JDBC Connection
	at org.springframework.jdbc.datasource.DataSourceUtils.getConnection(DataSourceUtils.java:84)
	at org.springframework.jdbc.core.JdbcTemplate.execute(JdbcTemplate.java:336)
	at fr.banque.rapprochement.DepotEcritures.lire(DepotEcritures.java:58)
	at fr.banque.rapprochement.⟬trap:code_identifier|⦃Family⦄Reconciler⟭.rapprocher(⟬trap:code_identifier|⦃Family⦄Reconciler⟭.java:112)
	at fr.banque.rapprochement.JobNocturne.run(JobNocturne.java:41)
Caused by: java.sql.SQLTransientConnectionException: pool-compta - Connection is not available, request timed out after 30000ms.
	at com.zaxxer.hikari.pool.HikariPool.createTimeoutException(HikariPool.java:696)
	at com.zaxxer.hikari.pool.HikariPool.getConnection(HikariPool.java:197)
	at com.zaxxer.hikari.HikariDataSource.getConnection(HikariDataSource.java:128)
	... 12 common frames omitted
Caused by: org.postgresql.util.PSQLException: FATAL: ⟬trap:indicator_non_pii|password authentication failed for user "svc_compta"⟭
	at org.postgresql.core.v3.ConnectionFactoryImpl.doAuthentication(ConnectionFactoryImpl.java:693)
	at org.postgresql.core.v3.ConnectionFactoryImpl.tryConnect(ConnectionFactoryImpl.java:203)
	at org.postgresql.core.v3.ConnectionFactoryImpl.openConnectionImpl(ConnectionFactoryImpl.java:258)
	... 18 common frames omitted
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Pydantic validation error, FastAPI traceback, quoted value
scenario: FastAPI validation error while processing traffic fines, whose Pydantic message repeats the offender's plate, licence, passport and birth date
⟬text⟭
ERROR:    Exception in ASGI application
Traceback (most recent call last):
  File "/app/.venv/lib/python3.12/site-packages/uvicorn/protocols/http/h11_impl.py", line 408, in run_asgi
    result = await app(self.scope, self.receive, self.send)
  File "/app/.venv/lib/python3.12/site-packages/fastapi/routing.py", line 278, in app
    response = await f(request)
  File "/app/contraventions/api.py", line 66, in enregistrer
    avis = AvisContravention.model_validate(corps)
  File "/app/.venv/lib/python3.12/site-packages/pydantic/main.py", line 503, in model_validate
    return cls.__pydantic_validator__.validate_python(obj)
pydantic_core._pydantic_core.ValidationError: 3 validation errors for AvisContravention
vehicule.immatriculation
  Value error, véhicule inconnu du répertoire [type=value_error, input_value='⟬fr_license_plate#1⟭', input_type=str]
contrevenant.permis
  Value error, permis annulé [type=value_error, input_value='⟬fr_driving_licence#1⟭', input_type=str]
contrevenant.date_naissance
  Input should be a valid date [type=date_from_datetime_parsing, input_value='⟬birth_date#1⟭', input_type=str]

Corps de la requête:
  {"nom":"⟬person_name#1⟭","piece":{"type":"passeport","numero":"⟬fr_passport#1⟭"},"adresse":"⟬fr_postal_address#1⟭","lieu_infraction":"⟬trap:word_name|avenue Foch⟭"}
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Robot Framework output, keyword log, test fixture
scenario: Robot Framework console report of an operator's SIM activation journeys, with a fictional customer, her passport and a named adviser
⟬text⟭
==============================================================================
Activation Sim
==============================================================================
Activation Sim.Parcours Boutique
==============================================================================
Activation avec passeport valide                                      | PASS |
------------------------------------------------------------------------------
Activation avec passeport expiré                                      | FAIL |
Le statut attendu 'REFUSE' diffère de 'ACTIVE'
Paramètres: cliente="⟬person_name#1f⟭" née le ⟬birth_date#1⟭ passeport=⟬fr_passport#1⟭ conseiller="⟬person_name#2⟭"
------------------------------------------------------------------------------
Portabilité du numéro                                                 | PASS |
------------------------------------------------------------------------------
Activation Sim.Parcours Boutique                                      | FAIL |
3 tests, 2 passed, 1 failed
==============================================================================
Activation Sim.Parcours En Ligne
==============================================================================
Activation avec cliente majeure                                       | PASS |
------------------------------------------------------------------------------
Refus pour un mineur sans responsable légal                           | PASS |
------------------------------------------------------------------------------
Activation Sim.Parcours En Ligne                                      | PASS |
2 tests, 2 passed, 0 failed
==============================================================================
Activation Sim                                                        | FAIL |
5 tests, 4 passed, 1 failed
==============================================================================
Output:  /builds/activation/results/output.xml
Log:     /builds/activation/results/log.html
Report:  /builds/activation/results/report.html
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: custom nginx format, request body, cookie, query string
scenario: nginx access of a checkout funnel in a custom format, enabled for debugging, logging request bodies with card, session cookie and JWT
⟬text⟭
⟬ip_address#1⟭ [⟬date#1⟭ 21:40:11 +0100] "GET /panier HTTP/1.1" 200 8120 cookie="sess=⟬opaque_token#1⟭" rb="-"
⟬ip_address#1⟭ [⟬date#1⟭ 21:40:19 +0100] "POST /panier/ajouter HTTP/1.1" 200 412 cookie="sess=⟬opaque_token#1⟭" rb="sku=⟬customer_id#1⟭&qte=2"
⟬ip_address#1⟭ [⟬date#1⟭ 21:41:02 +0100] "POST /connexion HTTP/1.1" 302 0 cookie="sess=⟬opaque_token#1⟭" rb="courriel=⟬email#2⟭&mdp=⟬password#2⟭"
⟬ip_address#1⟭ [⟬date#1⟭ 21:41:03 +0100] "GET /commande/livraison HTTP/1.1" 200 6204 cookie="sess=⟬opaque_token#3⟭" rb="-"
⟬ip_address#1⟭ [⟬date#1⟭ 21:41:48 +0100] "POST /commande/livraison HTTP/1.1" 302 0 cookie="sess=⟬opaque_token#3⟭" rb="nom=⟬person_name#2⟭&adresse=⟬fr_postal_address#2⟭&tel=⟬phone#2⟭"
⟬ip_address#1⟭ [⟬date#1⟭ 21:42:30 +0100] "POST /commande/paiement HTTP/1.1" 200 188 cookie="sess=⟬opaque_token#3⟭" rb="carte=⟬payment_card#2⟭&exp=06/27&cvv=⟬card_security_code#2⟭"
⟬ip_address#1⟭ [⟬date#1⟭ 21:42:31 +0100] "GET /commande/confirmation?ref=⟬order_number#2⟭ HTTP/1.1" 200 5120 cookie="sess=⟬opaque_token#3⟭" rb="-"
⟬ip_address#2⟭ [⟬date#1⟭ 21:42:58 +0100] "POST /api/webhooks/paiement?token=⟬jwt#4⟭ HTTP/1.1" 204 0 cookie="-" rb="evenement=paiement.capture&commande=⟬order_number#2⟭"
⟬ip_address#3⟭ [⟬date#1⟭ 21:43:20 +0100] "GET /suivi?ref=⟬opaque_token#5⟭ HTTP/1.1" 200 3320 cookie="-" rb="-"
⟬ip_address#3⟭ [⟬date#1⟭ 21:43:22 +0100] "GET /suivi/transporteur?colis=⟬uuid#1⟭ HTTP/1.1" 200 1204 cookie="-" rb="-"
⟬ip_address#4⟭ [⟬date#1⟭ 21:44:03 +0100] "POST /newsletter HTTP/1.1" 200 96 cookie="-" rb="courriel=⟬email#6⟭&source=pied-de-page"
⟬ip_address#5⟭ [⟬date#1⟭ 21:44:40 +0100] "GET /produits/foulard-soie HTTP/1.1" 200 12040 cookie="-" rb="-"
⟬ip_address#5⟭ [⟬date#1⟭ 21:44:51 +0100] "GET /produits/foulard-soie/avis?page=2 HTTP/1.1" 200 4012 cookie="-" rb="-"
⟬ip_address#6⟭ [⟬date#1⟭ 21:45:10 +0100] "POST /connexion HTTP/1.1" 401 88 cookie="-" rb="courriel=⟬trap:indicator_non_pii|anonyme⟭&mdp=⟬trap:placeholder|********⟭"
⟬ip_address#6⟭ [⟬date#1⟭ 21:45:12 +0100] "GET /healthz HTTP/1.1" 200 2 cookie="-" rb="-"
⟬ip_address#7⟭ [⟬date#1⟭ 21:46:00 +0100] "GET /robots.txt HTTP/1.1" 200 64 cookie="-" rb="-"
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: banking
appearance: Tomcat access valve, request body field, authenticated user field
scenario: Tomcat access of a corporate banking portal, where a filter adds transfer bodies and users mix people and technical accounts
⟬text⟭
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 09:01:12 +0200] "POST /portail/connexion HTTP/1.1" 302 - 214ms ""
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 09:01:13 +0200] "GET /portail/tableau-de-bord HTTP/1.1" 200 18422 84ms ""
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 09:02:40 +0200] "POST /portail/virements HTTP/1.1" 201 88 312ms "iban_dest=⟬iban#2⟭&montant=12400.00&libelle=⟬invoice_number#2⟭"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 09:03:05 +0200] "POST /portail/virements/signer HTTP/1.1" 200 64 188ms "methode=sms"
⟬ip_address#2⟭ - ⟬trap:indicator_non_pii|user-ebics⟭ [⟬date#1⟭ 09:05:00 +0200] "POST /ebics/depot HTTP/1.1" 200 410 702ms "lot=⟬uuid#1⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 09:07:21 +0200] "GET /portail/comptes/releve?compte=⟬uuid#2⟭ HTTP/1.1" 200 44120 143ms ""
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 09:09:44 +0200] "POST /portail/cartes/commander HTTP/1.1" 201 96 221ms "porteur=⟬person_name#4⟭&plafond=5000"
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 09:10:17 +0200] "POST /portail/cartes/activer HTTP/1.1" 200 64 166ms "numero=⟬payment_card#4⟭&cvv=⟬card_security_code#4⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 09:12:02 +0200] "POST /portail/beneficiaires HTTP/1.1" 201 96 174ms "nom=⟬company#5⟭&iban=⟬iban#5⟭&bic=⟬bic#5⟭"
⟬ip_address#2⟭ - ⟬trap:indicator_non_pii|user-ebics⟭ [⟬date#1⟭ 09:15:00 +0200] "POST /ebics/depot HTTP/1.1" 200 410 688ms "lot=⟬uuid#3⟭"
⟬ip_address#4⟭ - - [⟬date#1⟭ 09:15:30 +0200] "GET /actuator/health HTTP/1.1" 200 15 3ms ""
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 09:18:11 +0200] "GET /portail/virements?etat=attente HTTP/1.1" 200 2204 92ms ""
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 09:20:32 +0200] "POST /portail/deconnexion HTTP/1.1" 302 - 12ms ""
⟬ip_address#4⟭ - - [⟬date#1⟭ 09:30:30 +0200] "GET /actuator/health HTTP/1.1" 200 15 2ms ""
⟬ip_address#5⟭ - ⟬trap:indicator_non_pii|user-supervision⟭ [⟬date#1⟭ 09:31:00 +0200] "GET /actuator/metrics/jvm.memory.used HTTP/1.1" 200 412 6ms ""
⟬ip_address#3⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 09:40:12 +0200] "POST /portail/deconnexion HTTP/1.1" 302 - 11ms ""
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: Serilog text, log field, quoted value, company record
scenario: monthly fleet import of a car insurer, whose Serilog log lists each company with SIRET, vehicles and drivers
⟬text⟭
=== Import flottes, exécution du ⟬date#1⟭, version ⟬version#1⟭ ===
[01:00:02 INF] Lecture du dépôt ⟬file_path#1⟭
[01:00:02 INF] 3 sociétés, 8 véhicules annoncés
[01:00:03 INF] Société "⟬company#2⟭" SIRET ⟬fr_siret#2⟭ siège "⟬fr_postal_address#2⟭"
[01:00:03 DBG] Contact flotte "⟬person_name#3⟭" ⟬email#3⟭ ⟬phone#3⟭
[01:00:03 INF] Véhicule ⟬fr_license_plate#4⟭ rattaché au contrat ⟬customer_id#2⟭
[01:00:03 DBG] Conducteur habituel "⟬person_name#4⟭" permis ⟬fr_driving_licence#4⟭
[01:00:04 INF] Véhicule ⟬fr_license_plate#5⟭ rattaché au contrat ⟬customer_id#2⟭
[01:00:04 DBG] Conducteur habituel "⟬person_name#5⟭" permis ⟬fr_driving_licence#5⟭
[01:00:04 WRN] Permis ⟬fr_driving_licence#5⟭ absent du contrôle annuel
[01:00:04 INF] Véhicule ⟬fr_license_plate#6⟭ rattaché au contrat ⟬customer_id#2⟭
[01:00:04 DBG] Véhicule de pool, ⟬trap:indicator_non_pii|conducteur=multiple⟭
[01:00:05 INF] Prélèvement société sur ⟬iban#2⟭
[01:00:05 INF] Société "⟬company#2⟭" traitée: 3 véhicules, 2 conducteurs
[01:00:06 INF] Société "⟬company#7⟭" SIRET ⟬fr_siret#7⟭ siège "⟬fr_postal_address#7⟭"
[01:00:06 DBG] Contact flotte "⟬person_name#8⟭" ⟬email#8⟭ ⟬phone#8⟭
[01:00:06 INF] Véhicule ⟬fr_license_plate#9⟭ rattaché au contrat ⟬customer_id#7⟭
[01:00:06 DBG] Conducteur habituel "⟬person_name#9⟭" permis ⟬fr_driving_licence#9⟭
[01:00:07 ERR] Véhicule ⟬fr_license_plate#10⟭ inconnu du référentiel
[01:00:07 ERR] Ligne 14 rejetée: {"plaque":"⟬fr_license_plate#10⟭","conducteur":"⟬person_name#10⟭","permis":"⟬fr_driving_licence#10⟭"}
[01:00:07 INF] Véhicule ⟬fr_license_plate#11⟭ rattaché au contrat ⟬customer_id#7⟭
[01:00:07 DBG] Conducteur habituel "⟬person_name#11⟭" permis ⟬fr_driving_licence#11⟭
[01:00:08 WRN] Conducteur "⟬person_name#11⟭" déjà déclaré sur la flotte "⟬company#2⟭"
[01:00:08 INF] Prélèvement société sur ⟬iban#7⟭
[01:00:08 INF] Société "⟬company#7⟭" traitée: 2 véhicules, 2 conducteurs, 1 rejet
[01:00:09 INF] Société "⟬company#12⟭" SIRET ⟬fr_siret#12⟭ siège "⟬fr_postal_address#12⟭"
[01:00:09 DBG] Contact flotte "⟬person_name#13⟭" ⟬email#13⟭ ⟬phone#13⟭
[01:00:09 INF] Véhicule ⟬fr_license_plate#14⟭ rattaché au contrat ⟬customer_id#12⟭
[01:00:09 DBG] Conducteur habituel "⟬person_name#14⟭" permis ⟬fr_driving_licence#14⟭
[01:00:10 INF] Véhicule ⟬fr_license_plate#15⟭ rattaché au contrat ⟬customer_id#12⟭
[01:00:10 DBG] Conducteur habituel "⟬person_name#15⟭" permis ⟬fr_driving_licence#15⟭
[01:00:10 INF] Prélèvement société sur ⟬iban#12⟭
[01:00:10 INF] Société "⟬company#12⟭" traitée: 2 véhicules, 2 conducteurs
[01:00:11 INF] Rapprochement avec le fichier des sinistres
[01:00:12 DBG] Connexion à ⟬hostname#1⟭, ⟬trap:indicator_non_pii|user=flottes_lecture⟭
[01:00:13 INF] 7 véhicules contrôlés, 2 sinistres en cours
[01:00:13 INF] Sinistre ⟬ticket_id#1⟭ sur ⟬fr_license_plate#5⟭
[01:00:13 INF] Sinistre ⟬ticket_id#2⟭ sur ⟬fr_license_plate#14⟭
[01:00:14 INF] Calcul des primes de flotte
[01:00:15 DBG] Barème ⟬version#2⟭, loi de ⟬trap:eponym|Pareto⟭ pour les gros sinistres
[01:00:16 INF] Prime "⟬company#2⟭": 4120.00 EUR
[01:00:16 INF] Prime "⟬company#7⟭": 2840.50 EUR
[01:00:16 INF] Prime "⟬company#12⟭": 2998.00 EUR
[01:00:17 INF] Génération des avis d'échéance
[01:00:18 INF] Avis écrit: ⟬invoice_number#2⟭
[01:00:18 INF] Avis écrit: ⟬invoice_number#7⟭
[01:00:18 INF] Avis écrit: ⟬invoice_number#12⟭
[01:00:19 INF] Dépôt des avis sur ⟬url#1⟭
[01:00:21 INF] Courriel de synthèse envoyé à ⟬email:generic#16⟭
[01:00:21 INF] Fichier de rejets écrit dans ⟬file_path#2⟭
[01:00:22 INF] Empreinte du dépôt ⟬hash#1⟭ archivée
[01:00:22 INF] Durée totale 20 s
[01:00:22 INF] Fin de l'import
[01:15:00 INF] Sonde: base joignable
[01:30:00 INF] Sonde: base joignable
[01:45:00 INF] Sonde: base joignable
[02:00:00 INF] Sonde: base joignable
[02:00:01 DBG] Rotation du journal
[02:15:00 INF] Sonde: base joignable
[02:30:00 INF] Sonde: base joignable
[02:45:00 INF] Sonde: base joignable
[03:00:00 INF] Tâche suivante dans 29 jours
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Playwright reporter, product names, test account stand-in
scenario: Playwright output for the catalogue of a wine and accessories shop, whose products carry given names and whose test accounts are only stand-ins
⟬text⟭
Running 48 tests using 4 workers

  ✓  1 [chromium] › catalogue/filtres.spec.ts:12:5 › filtre par couleur ⟬trap:word_name|Rose⟭ poudré (812ms)
  ✓  2 [chromium] › catalogue/filtres.spec.ts:21:5 › filtre par couleur ⟬trap:word_name|Lilas⟭ (644ms)
  ✓  3 [chromium] › catalogue/filtres.spec.ts:30:5 › filtre par couleur ⟬trap:word_name|Olive⟭ (701ms)
  ✓  4 [chromium] › catalogue/filtres.spec.ts:39:5 › filtre par matière ⟬trap:word_name|Pierre⟭ de lave (593ms)
  ✓  5 [chromium] › catalogue/filtres.spec.ts:48:5 › tri par prix croissant (1.1s)
  ✓  6 [chromium] › catalogue/filtres.spec.ts:57:5 › tri par nouveautés (987ms)
  ✓  7 [chromium] › catalogue/fiche.spec.ts:9:5 › fiche du ⟬trap:word_name|Margaux⟭ grand cru (1.2s)
  ✓  8 [chromium] › catalogue/fiche.spec.ts:18:5 › fiche du ⟬trap:word_name|Saint-Émilion⟭ (1.1s)
  ✓  9 [chromium] › catalogue/fiche.spec.ts:27:5 › fiche du Chablis (1.0s)
  ✓ 10 [chromium] › catalogue/fiche.spec.ts:36:5 › fiche du sac ⟬trap:company_name|⦃Family⦄ Maroquinerie⟭ (1.3s)
  ✓ 11 [chromium] › catalogue/fiche.spec.ts:45:5 › galerie de photos (2.1s)
  ✓ 12 [chromium] › catalogue/fiche.spec.ts:54:5 › stock épuisé (780ms)
  ✓ 13 [chromium] › compte/inscription.spec.ts:8:5 › inscription avec ⟬trap:indicator_non_pii|<email>⟭ généré (1.8s)
  ✓ 14 [chromium] › compte/inscription.spec.ts:19:5 › refuse ⟬trap:indicator_non_pii|nom=<NOM>⟭ vide (420ms)
  ✓ 15 [chromium] › compte/inscription.spec.ts:28:5 › refuse le mot de passe ⟬trap:placeholder|<password>⟭ trop court (390ms)
  ✓ 16 [chromium] › compte/inscription.spec.ts:37:5 › exige ⟬trap:indicator_non_pii|telephone=optionnel⟭ selon le pays (510ms)
  ✓ 17 [chromium] › compte/connexion.spec.ts:7:5 › connexion avec ⟬trap:indicator_non_pii|${TEST_LOGIN}⟭ (1.4s)
  ✓ 18 [chromium] › compte/connexion.spec.ts:16:5 › connexion refusée sans ⟬trap:placeholder|${TEST_PASSWORD}⟭ (602ms)
  ✓ 19 [chromium] › compte/connexion.spec.ts:25:5 › déconnexion (488ms)
  -  20 [chromium] › compte/connexion.spec.ts:34:5 › authentification à deux facteurs
  ✓ 21 [chromium] › panier/ajout.spec.ts:10:5 › ajout d'un article (720ms)
  ✓ 22 [chromium] › panier/ajout.spec.ts:19:5 › ajout de deux articles identiques (811ms)
  ✓ 23 [chromium] › panier/ajout.spec.ts:28:5 › suppression (540ms)
  ✓ 24 [chromium] › panier/remise.spec.ts:8:5 › code PAQUES (692ms)
  ✓ 25 [chromium] › panier/remise.spec.ts:17:5 › code expiré (488ms)
  ✘ 26 [chromium] › panier/remise.spec.ts:26:5 › cumul des remises fidélité (5.0s)
  ✓ 27 [chromium] › livraison/relais.spec.ts:11:5 › choix d'un point relais (1.6s)
  ✓ 28 [chromium] › livraison/relais.spec.ts:20:5 › point relais ⟬trap:word_name|rue Pasteur⟭ fermé (1.2s)
  ✓ 29 [chromium] › livraison/domicile.spec.ts:9:5 › ⟬trap:indicator_non_pii|adresse=exemple⟭ refusée (812ms)
  ✓ 30 [chromium] › livraison/domicile.spec.ts:18:5 › frais offerts dès 60 euros (530ms)
  ✓ 31 [chromium] › paiement/carte.spec.ts:13:5 › formulaire de carte masqué (1.0s)
  ✓ 32 [chromium] › paiement/carte.spec.ts:24:5 › ⟬trap:indicator_non_pii|carte=****⟭ refusée par le prestataire (2.2s)
  ✓ 33 [chromium] › paiement/carte.spec.ts:35:5 › contrôle de ⟬trap:eponym|Luhn⟭ côté navigateur (312ms)
  ✓ 34 [chromium] › paiement/virement.spec.ts:8:5 › instructions de virement affichées (690ms)
  ✓ 35 [chromium] › commande/suivi.spec.ts:9:5 › suivi sans connexion (911ms)
  ✓ 36 [chromium] › commande/suivi.spec.ts:18:5 › ⟬trap:indicator_non_pii|client=invite⟭ sans historique (640ms)
  ✓ 37 [chromium] › commande/retour.spec.ts:12:5 › demande de retour sous 14 jours (1.1s)
  ✓ 38 [chromium] › commande/retour.spec.ts:23:5 › retour refusé après délai (720ms)
  ✓ 39 [chromium] › compte/preferences.spec.ts:7:5 › ⟬trap:indicator_non_pii|Bonjour à tous⟭ en bannière (401ms)
  ✓ 40 [chromium] › compte/preferences.spec.ts:16:5 › désinscription de la lettre d'information (603ms)
  ✓ 41 [firefox] › catalogue/filtres.spec.ts:12:5 › filtre par couleur ⟬trap:word_name|Rose⟭ poudré (1.0s)
  ✓ 42 [firefox] › catalogue/fiche.spec.ts:9:5 › fiche du ⟬trap:word_name|Margaux⟭ grand cru (1.4s)
  ✓ 43 [firefox] › panier/ajout.spec.ts:10:5 › ajout d'un article (880ms)
  ✓ 44 [firefox] › paiement/carte.spec.ts:13:5 › formulaire de carte masqué (1.2s)
  ✓ 45 [webkit] › catalogue/filtres.spec.ts:12:5 › filtre par couleur ⟬trap:word_name|Rose⟭ poudré (1.2s)
  ✓ 46 [webkit] › catalogue/fiche.spec.ts:9:5 › fiche du ⟬trap:word_name|Margaux⟭ grand cru (1.6s)
  ✓ 47 [webkit] › panier/ajout.spec.ts:10:5 › ajout d'un article (950ms)
  ✓ 48 [webkit] › paiement/carte.spec.ts:13:5 › formulaire de carte masqué (1.3s)

  1) [chromium] › panier/remise.spec.ts:26:5 › cumul des remises fidélité ─────────────────────

    Error: Timed out 5000ms waiting for expect(locator).toHaveText(expected)

    Locator: getByTestId('total-panier')
    Expected string: "43,20 €"
    Received string: "48,00 €"

      31 |     await page.getByRole('button', { name: 'Appliquer' }).click();
    > 32 |     await expect(page.getByTestId('total-panier')).toHaveText('43,20 €');
         |                                                    ^
      33 |   });

    at /app/e2e/panier/remise.spec.ts:32:52

  1 failed
    [chromium] › panier/remise.spec.ts:26:5 › cumul des remises fidélité
  1 skipped
  46 passed (1.2m)
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: JSON log line, secret store audit, nested JSON, key=value in a value
scenario: secrets vault audit log of an operator, as JSON, where a wrong log level leaves passwords and tokens returned to agents and services in clear
⟬text⟭
{"time":"⟬date#1⟭ 08:00:12","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-bss⟭","policies":["bss-lecture"]},"request":{"operation":"read","path":"secret/data/bss/sip","remote_address":"⟬ip_address#1⟭"}}
{"time":"⟬date#1⟭ 08:00:12","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-bss⟭"},"request":{"path":"secret/data/bss/sip"},"response":{"data":{"username":"⟬trap:indicator_non_pii|sip_trunk⟭","password":"⟬password#1⟭"}}}
{"time":"⟬date#1⟭ 08:03:40","type":"request","auth":{"display_name":"ldap-⟬person_name:handle#2⟭","policies":["ops-reseau"]},"request":{"operation":"read","path":"secret/data/reseau/routeurs","remote_address":"⟬ip_address#2⟭"}}
{"time":"⟬date#1⟭ 08:03:40","type":"response","auth":{"display_name":"ldap-⟬person_name:handle#2⟭"},"request":{"path":"secret/data/reseau/routeurs"},"response":{"data":{"tacacs_key":"⟬opaque_token#2⟭","owner":"⟬trap:indicator_non_pii|noc-niveau2⟭"}}}
{"time":"⟬date#1⟭ 08:05:02","type":"request","auth":{"display_name":"ldap-⟬person_name:handle#2⟭"},"request":{"operation":"update","path":"secret/data/reseau/routeurs","data":{"tacacs_key":"hmac-sha256:⟬hash#1⟭"}}}
{"time":"⟬date#1⟭ 08:05:02","type":"response","auth":{"display_name":"ldap-⟬person_name:handle#2⟭"},"request":{"path":"secret/data/reseau/routeurs"},"response":{"data":{"version":12}}}
{"time":"⟬date#1⟭ 08:10:00","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|approle-sauvegarde⟭"},"request":{"operation":"read","path":"sys/storage/raft/snapshot","remote_address":"⟬ip_address#3⟭"}}
{"time":"⟬date#1⟭ 08:10:04","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|approle-sauvegarde⟭"},"request":{"path":"sys/storage/raft/snapshot"},"response":{"mount_type":"system"}}
{"time":"⟬date#1⟭ 08:12:31","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-selfcare⟭"},"request":{"operation":"read","path":"secret/data/selfcare/oidc","remote_address":"⟬ip_address#4⟭"}}
{"time":"⟬date#1⟭ 08:12:31","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-selfcare⟭"},"request":{"path":"secret/data/selfcare/oidc"},"response":{"data":{"client_secret":"⟬opaque_token#3⟭","issuer":"⟬url#1⟭"}}}
{"time":"⟬date#1⟭ 08:15:18","type":"request","auth":{"display_name":"oidc-⟬person_name:handle#4⟭","policies":["sre"]},"request":{"operation":"create","path":"auth/token/create","remote_address":"⟬ip_address#5⟭"}}
{"time":"⟬date#1⟭ 08:15:18","type":"response","auth":{"display_name":"oidc-⟬person_name:handle#4⟭"},"request":{"path":"auth/token/create"},"response":{"auth":{"client_token":"⟬jwt#4⟭","accessor":"⟬uuid#1⟭","ttl":3600}}}
{"time":"⟬date#1⟭ 08:18:44","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|token-ci-deploiement⟭"},"request":{"operation":"read","path":"secret/data/ci/registre","remote_address":"⟬ip_address#6⟭"}}
{"time":"⟬date#1⟭ 08:18:44","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|token-ci-deploiement⟭"},"request":{"path":"secret/data/ci/registre"},"response":{"data":{"ref":"⟬opaque_token#5⟭","projet":"bss"}}}
{"time":"⟬date#1⟭ 08:20:02","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|token-ci-deploiement⟭"},"request":{"operation":"read","path":"secret/data/ci/version","remote_address":"⟬ip_address#6⟭"}}
{"time":"⟬date#1⟭ 08:20:02","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|token-ci-deploiement⟭"},"request":{"path":"secret/data/ci/version"},"response":{"data":{"ref":"⟬uuid#2⟭","projet":"bss"}}}
{"time":"⟬date#1⟭ 08:24:11","type":"request","auth":{"display_name":"ldap-⟬person_name:handle#6⟭","policies":["facturation"]},"request":{"operation":"read","path":"secret/data/facturation/sftp","remote_address":"⟬ip_address#7⟭"}}
{"time":"⟬date#1⟭ 08:24:11","type":"response","auth":{"display_name":"ldap-⟬person_name:handle#6⟭"},"request":{"path":"secret/data/facturation/sftp"},"response":{"data":{"hote":"⟬hostname#1⟭","compte":"⟬trap:indicator_non_pii|sftp_facturation⟭","pass":"⟬password#6⟭"}}}
{"time":"⟬date#1⟭ 08:26:03","type":"request","auth":{"display_name":"ldap-⟬person_name:handle#6⟭"},"request":{"operation":"list","path":"secret/metadata/facturation","remote_address":"⟬ip_address#7⟭"}}
{"time":"⟬date#1⟭ 08:26:03","type":"response","auth":{"display_name":"ldap-⟬person_name:handle#6⟭"},"request":{"path":"secret/metadata/facturation"},"response":{"data":{"keys":["sftp","smtp","hsm"]}}}
{"time":"⟬date#1⟭ 08:30:00","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|approle-rotation⟭"},"request":{"operation":"update","path":"database/rotate-root/bss","remote_address":"⟬ip_address#3⟭"}}
{"time":"⟬date#1⟭ 08:30:01","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|approle-rotation⟭"},"request":{"path":"database/rotate-root/bss"},"response":{"mount_type":"database"}}
{"time":"⟬date#1⟭ 08:33:47","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-sms⟭"},"request":{"operation":"read","path":"secret/data/sms/fournisseur","remote_address":"⟬ip_address#8⟭"}}
{"time":"⟬date#1⟭ 08:33:47","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-sms⟭"},"request":{"path":"secret/data/sms/fournisseur"},"response":{"data":{"value":"⟬opaque_token#7⟭","fournisseur":"⟬company#8⟭"}}}
{"time":"⟬date#1⟭ 08:36:29","type":"request","auth":{"display_name":"oidc-⟬person_name:handle#4⟭"},"request":{"operation":"read","path":"secret/data/sre/bastion","remote_address":"⟬ip_address#5⟭"}}
{"time":"⟬date#1⟭ 08:36:29","type":"response","auth":{"display_name":"oidc-⟬person_name:handle#4⟭"},"request":{"path":"secret/data/sre/bastion"},"response":{"data":{"login":"⟬trap:indicator_non_pii|bastion-sre⟭","mdp":"⟬password#4⟭"}}}
{"time":"⟬date#1⟭ 08:40:02","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|approle-monitoring⟭"},"request":{"operation":"read","path":"sys/health","remote_address":"⟬ip_address#9⟭"}}
{"time":"⟬date#1⟭ 08:40:02","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|approle-monitoring⟭"},"request":{"path":"sys/health"},"response":{"data":{"sealed":false,"standby":false}}}
{"time":"⟬date#1⟭ 08:44:18","type":"request","auth":{"display_name":"ldap-⟬person_name:handle#9⟭","policies":["sav"]},"request":{"operation":"read","path":"secret/data/bss/sip","remote_address":"⟬ip_address#10⟭"},"error":"permission denied"}
{"time":"⟬date#1⟭ 08:44:18","type":"response","auth":{"display_name":"ldap-⟬person_name:handle#9⟭"},"request":{"path":"secret/data/bss/sip"},"error":"1 error occurred: permission denied"}
{"time":"⟬date#1⟭ 08:45:02","type":"request","auth":{"display_name":"ldap-⟬person_name:handle#9⟭"},"request":{"operation":"read","path":"secret/data/sav/portail","remote_address":"⟬ip_address#10⟭"}}
{"time":"⟬date#1⟭ 08:45:02","type":"response","auth":{"display_name":"ldap-⟬person_name:handle#9⟭"},"request":{"path":"secret/data/sav/portail"},"response":{"data":{"url":"⟬url#2⟭","jeton":"⟬jwt#9⟭"}}}
{"time":"⟬date#1⟭ 08:50:10","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|approle-sauvegarde⟭"},"request":{"operation":"read","path":"secret/data/sauvegarde/s3","remote_address":"⟬ip_address#3⟭"}}
{"time":"⟬date#1⟭ 08:50:10","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|approle-sauvegarde⟭"},"request":{"path":"secret/data/sauvegarde/s3"},"response":{"data":{"access_key":"⟬aws_access_key_id#10⟭","secret_key":"⟬aws_secret_access_key#10⟭"}}}
{"time":"⟬date#1⟭ 08:55:33","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-bss⟭"},"request":{"operation":"read","path":"secret/data/bss/sip","remote_address":"⟬ip_address#1⟭"}}
{"time":"⟬date#1⟭ 08:55:33","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-bss⟭"},"request":{"path":"secret/data/bss/sip"},"response":{"data":{"username":"⟬trap:indicator_non_pii|sip_trunk⟭","password":"⟬password#1⟭"}}}
{"time":"⟬date#1⟭ 09:00:00","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|approle-monitoring⟭"},"request":{"operation":"read","path":"sys/health","remote_address":"⟬ip_address#9⟭"}}
{"time":"⟬date#1⟭ 09:00:00","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|approle-monitoring⟭"},"request":{"path":"sys/health"},"response":{"data":{"sealed":false,"standby":false}}}
{"time":"⟬date#1⟭ 09:05:44","type":"request","auth":{"display_name":"oidc-⟬person_name:handle#11⟭","policies":["sre"]},"request":{"operation":"update","path":"sys/policies/acl/sav","remote_address":"⟬ip_address#11⟭"}}
{"time":"⟬date#1⟭ 09:05:44","type":"response","auth":{"display_name":"oidc-⟬person_name:handle#11⟭"},"request":{"path":"sys/policies/acl/sav"},"response":{"mount_type":"system"}}
{"time":"⟬date#1⟭ 09:10:22","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|token-ci-deploiement⟭"},"request":{"operation":"read","path":"secret/data/ci/signature","remote_address":"⟬ip_address#6⟭"}}
{"time":"⟬date#1⟭ 09:10:22","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|token-ci-deploiement⟭"},"request":{"path":"secret/data/ci/signature"},"response":{"data":{"sig":"⟬opaque_token#12⟭","key_id":"⟬hash#2⟭"}}}
{"time":"⟬date#1⟭ 09:14:09","type":"request","auth":{"display_name":"ldap-⟬person_name:handle#13⟭","policies":["ops-reseau"]},"request":{"operation":"read","path":"secret/data/reseau/radius","remote_address":"⟬ip_address#12⟭"}}
{"time":"⟬date#1⟭ 09:14:09","type":"response","auth":{"display_name":"ldap-⟬person_name:handle#13⟭"},"request":{"path":"secret/data/reseau/radius"},"response":{"data":{"shared_secret":"⟬password#13⟭","owner":"⟬person_name:handle#13⟭"}}}
{"time":"⟬date#1⟭ 09:18:51","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-sms⟭"},"request":{"operation":"read","path":"secret/data/sms/routage","remote_address":"⟬ip_address#8⟭"}}
{"time":"⟬date#1⟭ 09:18:51","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-sms⟭"},"request":{"path":"secret/data/sms/routage"},"response":{"data":{"value":"⟬uuid#3⟭","file":"prioritaire"}}}
{"time":"⟬date#1⟭ 09:20:00","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|approle-monitoring⟭"},"request":{"operation":"read","path":"sys/health","remote_address":"⟬ip_address#9⟭"}}
{"time":"⟬date#1⟭ 09:20:00","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|approle-monitoring⟭"},"request":{"path":"sys/health"},"response":{"data":{"sealed":false,"standby":false}}}
{"time":"⟬date#1⟭ 09:24:37","type":"request","auth":{"display_name":"oidc-⟬person_name:handle#4⟭"},"request":{"operation":"revoke","path":"auth/token/revoke-accessor","remote_address":"⟬ip_address#5⟭","data":{"accessor":"⟬uuid#1⟭"}}}
{"time":"⟬date#1⟭ 09:24:37","type":"response","auth":{"display_name":"oidc-⟬person_name:handle#4⟭"},"request":{"path":"auth/token/revoke-accessor"},"response":{"mount_type":"token"}}
{"time":"⟬date#1⟭ 09:30:00","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|approle-rotation⟭"},"request":{"operation":"update","path":"database/rotate-root/selfcare","remote_address":"⟬ip_address#3⟭"}}
{"time":"⟬date#1⟭ 09:30:01","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|approle-rotation⟭"},"request":{"path":"database/rotate-root/selfcare"},"response":{"mount_type":"database"}}
{"time":"⟬date#1⟭ 09:35:12","type":"request","auth":{"display_name":"ldap-⟬person_name:handle#6⟭"},"request":{"operation":"read","path":"secret/data/facturation/smtp","remote_address":"⟬ip_address#7⟭"}}
{"time":"⟬date#1⟭ 09:35:12","type":"response","auth":{"display_name":"ldap-⟬person_name:handle#6⟭"},"request":{"path":"secret/data/facturation/smtp"},"response":{"data":{"hote":"⟬hostname#2⟭","pass":"⟬password#14⟭"}}}
{"time":"⟬date#1⟭ 09:40:00","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|approle-monitoring⟭"},"request":{"operation":"read","path":"sys/health","remote_address":"⟬ip_address#9⟭"}}
{"time":"⟬date#1⟭ 09:40:00","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|approle-monitoring⟭"},"request":{"path":"sys/health"},"response":{"data":{"sealed":false,"standby":false}}}
{"time":"⟬date#1⟭ 09:44:50","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|token-ci-deploiement⟭"},"request":{"operation":"renew-self","path":"auth/token/renew-self","remote_address":"⟬ip_address#6⟭"}}
{"time":"⟬date#1⟭ 09:44:50","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|token-ci-deploiement⟭"},"request":{"path":"auth/token/renew-self"},"response":{"auth":{"ttl":86400}}}
{"time":"⟬date#1⟭ 10:00:00","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|approle-monitoring⟭"},"request":{"operation":"read","path":"sys/health","remote_address":"⟬ip_address#9⟭"}}
{"time":"⟬date#1⟭ 10:00:00","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|approle-monitoring⟭"},"request":{"path":"sys/health"},"response":{"data":{"sealed":false,"standby":false}}}
{"time":"⟬date#1⟭ 10:05:18","type":"request","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-bss⟭"},"request":{"operation":"read","path":"secret/data/bss/hlr","remote_address":"⟬ip_address#1⟭"}}
{"time":"⟬date#1⟭ 10:05:18","type":"response","auth":{"display_name":"⟬trap:indicator_non_pii|kubernetes-svc-bss⟭"},"request":{"path":"secret/data/bss/hlr"},"response":{"data":{"value":"⟬opaque_token#15⟭","owner":"⟬trap:indicator_non_pii|equipe-coeur-reseau⟭"}}}
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: banking
appearance: GitHub Actions log, printenv dump, test fixture, JSON response
scenario: integration job on GitHub Actions of a neobank, where a debug printenv spreads tokens, passwords, a test IBAN and a test card over the log
⟬text⟭
##[group]Run actions/checkout@v4
with:
  repository: banque/api-paiements
  ref: ⟬git_sha#1⟭
##[endgroup]
Syncing repository: banque/api-paiements
Checking out the ref
##[group]Run docker compose -f ci/compose.yml up -d
Container ci-postgres-1  Started
Container ci-redis-1  Started
Container ci-kafka-1  Started
##[endgroup]
##[group]Run printenv | sort
CI=true
DATABASE_URL=postgresql://api:⟬url_password#1⟭@⟬hostname#1⟭:5432/paiements
DEBUG=1
GITHUB_ACTOR=⟬trap:indicator_non_pii|dependabot[bot]⟭
GITHUB_ACTIONS=true
GITHUB_REF=refs/heads/main
GITHUB_RUN_ID=8812044315
GITHUB_SHA=⟬git_sha#1⟭
HOME=/home/runner
HSM_PIN=⟬password#2⟭
IBAN_RECETTE=⟬iban#3⟭
JAVA_HOME=/usr/lib/jvm/temurin-21-jdk-amd64
KAFKA_CLIENT_ID=api-paiements-ci
KAFKA_PASSWORD=⟬password#5⟭
KAFKA_USERNAME=⟬trap:indicator_non_pii|ci-paiements⟭
LANG=C.UTF-8
PARTENAIRE_JWT=⟬jwt#1⟭
PATH=/usr/local/bin:/usr/bin:/bin
⟬trap:indicator_non_pii|PWD=/home/runner/work/api-paiements⟭
REDIS_REF=⟬opaque_token#1⟭
RUNNER_NAME=hosted-14
RUNNER_OS=Linux
SIGNATURE_KID=⟬hash#1⟭
SIGNATURE_VALUE=⟬opaque_token#2⟭
TEST_CARTE=⟬payment_card#3⟭
TEST_CARTE_CVV=⟬card_security_code#3⟭
TEST_TITULAIRE=⟬person_name#3⟭
TZ=Europe/⟬trap:word_name|Paris⟭
##[endgroup]
##[group]Run ./gradlew integrationTest
> Task :compileJava
> Task :integrationTest

fr.banque.paiements.CarteIT > autoriseUnPaiementValide PASSED
fr.banque.paiements.CarteIT > refuseUneCarteExpiree PASSED
fr.banque.paiements.SepaIT > emetUnVirementInstantane PASSED

fr.banque.paiements.SepaIT > rejetteUnIbanInconnu FAILED
    org.opentest4j.AssertionFailedError: réponse inattendue {"statut":"ACCEPTE","iban":"⟬iban#4⟭","titulaire":"⟬person_name#4⟭"}
        at fr.banque.paiements.SepaIT.rejetteUnIbanInconnu(SepaIT.java:88)

fr.banque.paiements.MandatIT > creeUnMandat PASSED
fr.banque.paiements.MandatIT > revoqueUnMandat PASSED

18 tests completed, 1 failed
> Task :integrationTest FAILED

FAILURE: Build failed with an exception.
##[endgroup]
##[error]Process completed with exit code 1.
##[group]Run ./ci/collecter_journaux.sh
journaux archivés dans ⟬file_path#1⟭
##[endgroup]
Post job cleanup.
⟬end⟭
