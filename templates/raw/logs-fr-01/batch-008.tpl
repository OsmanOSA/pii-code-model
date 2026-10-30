⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Asterisk log, SIP display name
scenario: Asterisk log of a hosted phone switchboard, where refused registrations show the phone's display name and a line password
⟬text⟭
[⟬date#1⟭ 08:01:12] NOTICE[2210] chan_sip.c: Registration from '"⟬person_name#1⟭" <⟬trap:email_lookalike|sip:2041@pbx-sud⟭>' failed for '⟬ip_address#1⟭' - Wrong password
[⟬date#1⟭ 08:01:40] VERBOSE[2210] pbx.c: Executing [2041@interne:1] Dial("SIP/2041", "SIP/2042,30")
[⟬date#1⟭ 08:02:03] WARNING[2214] res_config.c: secret=⟬password#2⟭ pour le poste 2042, stocké en clair
[⟬date#1⟭ 08:02:40] NOTICE[2210] chan_sip.c: Registration from '"Accueil" <⟬trap:email_lookalike|sip:2000@pbx-sud⟭>' failed for '⟬ip_address#2⟭' - No matching peer found
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: insurance
appearance: Elixir error, map dump
scenario: Elixir error of an insurance cancellation service, whose MatchError shows the contract map with the policyholder and plate
⟬text⟭
** (MatchError) no match of right hand side value: %{contrat: "⟬customer_id#1⟭", immat: "⟬fr_license_plate#1⟭", souscripteur: "⟬person_name#1⟭", statut: :resilie}
    (assurance 2.4.1) lib/assurance/resiliation.ex:88: Assurance.Resiliation.appliquer/1
    (assurance 2.4.1) lib/assurance/worker.ex:41: Assurance.Worker.perform/1
    (oban 2.17.1) lib/oban/queue/executor.ex:129: Oban.Queue.Executor.perform/1
    (elixir 1.16.0) lib/task/supervised.ex:101: Task.Supervised.invoke_mfa/2
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Bats output, shell test
scenario: Bats output of a box provisioning test suite, with fictional identifiers and no subscriber
⟬text⟭
1..5
ok 1 la box repond au ping
ok 2 le portail wifi affiche ⟬trap:indicator_non_pii|nom_reseau=BOX-TEST⟭
not ok 3 le changement de mot de passe wifi est applique
# (in test file tests/wifi.bats, line 22)
#   `[ "$status" -eq 0 ]' failed
# ⟬trap:indicator_non_pii|wifi_password_len=7⟭ inferieur au minimum
ok 4 la mise a jour tourne en tache de fond
ok 5 ⟬trap:indicator_non_pii|user=technicien⟭ sans droits root
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: CAS ticket in a query string, URL as a value
scenario: access of a region's single sign-on server, whose redirects keep CAS tickets and called services
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:30:12 +0200] "GET /cas/login?service=⟬url#1⟭ HTTP/1.1" 200 4120
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:30:21 +0200] "POST /cas/login HTTP/1.1" 302 0
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:30:22 +0200] "GET /cas/serviceValidate?ticket=ST-⟬opaque_token#1⟭&service=⟬url#1⟭ HTTP/1.1" 200 812
⟬ip_address#3⟭ - ⟬trap:indicator_non_pii|user-supervision⟭ [⟬date#1⟭ 08:31:00 +0200] "GET /cas/status HTTP/1.1" 200 96
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: sops output, YAML value, secret under an innocuous key
scenario: CI step that decrypts a voicemail service's secrets by mistake and prints them in the log
⟬text⟭
$ sops -d secrets/preprod.enc.yaml
sip:
    utilisateur: ⟬trap:indicator_non_pii|vm-preprod⟭
    motdepasse: ⟬password#1⟭
stockage:
    ref: ⟬opaque_token#1⟭
    bucket: messagerie-preprod
transcription:
    ref: ⟬uuid#1⟭
$ echo "fin du dechiffrement"
fin du dechiffrement
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: OpenLDAP access log, distinguished name
scenario: OpenLDAP access log of a hospital, with service account binds and directory searches
⟬text⟭
⟬date#1⟭ 05:00:01 ldap01 slapd[812]: conn=1012 fd=14 ACCEPT from IP=⟬ip_address#1⟭
⟬date#1⟭ 05:00:01 ldap01 slapd[812]: conn=1012 op=0 BIND dn="cn=svc-dpi,ou=services,dc=chu,dc=local" mech=SIMPLE
⟬date#1⟭ 05:00:01 ldap01 slapd[812]: conn=1012 op=1 SRCH base="ou=groupes,dc=chu,dc=local" scope=2 filter="(⟬trap:indicator_non_pii|mail=*⟭)"
⟬date#1⟭ 05:00:02 ldap01 slapd[812]: conn=1012 op=1 SEARCH RESULT tag=101 err=0 nentries=1
⟬date#1⟭ 05:00:02 ldap01 slapd[812]: conn=1012 op=2 UNBIND
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: key=value, split address, postcode and city fields
scenario: shipping log of an online sales warehouse, splitting recipients' addresses into fields and mixing carriers and product given names
⟬text⟭
exp=⟬uuid#1⟭ etape=etiquette dest="⟬person_name#1⟭" adr1="⟬fr_postal_address:street#1⟭" cp=⟬postcode#1⟭ ville="⟬city#1⟭" tel=⟬phone#1⟭
exp=⟬uuid#1⟭ etape=poids kg=2.4 colis=1 produit="vase ⟬trap:word_name|Clémentine⟭"
exp=⟬uuid#1⟭ etape=transporteur nom=⟬company#2⟭ service=express
exp=⟬uuid#1⟭ etape=api transporteur ref=⟬opaque_token#1⟭
exp=⟬uuid#1⟭ etape=remise heure=11:02
exp=⟬uuid#3⟭ etape=etiquette dest="⟬person_name#3⟭" adr1="⟬fr_postal_address:street#3⟭" cp=⟬postcode#3⟭ ville="⟬city#3⟭" tel=⟬phone#3⟭
exp=⟬uuid#3⟭ etape=poids kg=0.8 colis=1 produit="bougie ⟬trap:word_name|Jasmine⟭"
exp=⟬uuid#3⟭ etape=adresse_invalide motif="numéro absent" operateur=⟬person_name:given#4⟭
exp=⟬uuid#3⟭ etape=contact_client mail=⟬email#3⟭
exp=⟬uuid#5⟭ etape=etiquette dest="⟬company#5⟭" adr1="⟬fr_postal_address:street#5⟭" cp=⟬postcode#5⟭ ville="⟬city#5⟭"
exp=⟬uuid#5⟭ etape=poids kg=14.0 colis=3 produit="lot de vaisselle"
exp=⟬uuid#5⟭ etape=api transporteur ref=⟬uuid#6⟭
exp=⟬uuid#5⟭ etape=remise heure=11:40
exp=⟬uuid#7⟭ etape=etiquette ⟬trap:indicator_non_pii|dest=point-relais⟭ cp=⟬postcode#7⟭ ville="⟬city#7⟭"
exp=⟬uuid#7⟭ etape=poids kg=1.1 colis=1 produit="écharpe"
exp=⟬uuid#7⟭ etape=remise heure=12:05
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Logstash warning, Ruby hash dump
scenario: Logstash warnings of a county social service, rejecting documents and copying each beneficiary's Ruby hash
⟬text⟭
[⟬date#1⟭ 06:12:01,204][INFO ][logstash.javapipeline    ][social] Pipeline started {"pipeline.id"=>"social"}
[⟬date#1⟭ 06:12:44,118][WARN ][logstash.outputs.elasticsearch][social] Could not index event to Elasticsearch. {:status=>400, :action=>["index", {:_index=>"aides-2024"}, {"beneficiaire"=>"⟬person_name#1⟭", "nir"=>"⟬fr_social_security_number#1⟭", "naissance"=>"⟬birth_date#1⟭", "aide"=>"APA"}], :response=>{"index"=>{"error"=>{"type"=>"mapper_parsing_exception"}}}}
[⟬date#1⟭ 06:12:44,120][WARN ][logstash.outputs.elasticsearch][social] Could not index event to Elasticsearch. {:status=>400, :action=>["index", {:_index=>"aides-2024"}, {"beneficiaire"=>"⟬person_name#2⟭", "nir"=>"⟬fr_social_security_number#2⟭", "naissance"=>"⟬birth_date#2⟭", "aide"=>"PCH", "referent"=>"⟬person_name:initial#3⟭"}], :response=>{"index"=>{"error"=>{"type"=>"mapper_parsing_exception"}}}}
[⟬date#1⟭ 06:12:45,002][INFO ][logstash.filters.ruby    ][social] 412 documents traités
[⟬date#1⟭ 06:13:10,044][WARN ][logstash.outputs.elasticsearch][social] Could not index event to Elasticsearch. {:status=>400, :action=>["index", {:_index=>"aides-2024"}, {"beneficiaire"=>"⟬person_name#4⟭", "adresse"=>"⟬fr_postal_address#4⟭", "age"=>⟬age#4⟭, "metier"=>"⟬job_title#4⟭"}], :response=>{"index"=>{"error"=>{"type"=>"mapper_parsing_exception"}}}}
[⟬date#1⟭ 06:13:11,120][INFO ][logstash.outputs.file    ][social] Opening file {:path=>"/var/log/logstash/rejets.json"}
[⟬date#1⟭ 06:14:00,000][INFO ][logstash.inputs.jdbc     ][social] (0.012s) SELECT id FROM aides WHERE maj > :sql_last_value
[⟬date#1⟭ 06:14:00,214][INFO ][logstash.inputs.jdbc     ][social] ⟬trap:indicator_non_pii|jdbc_user=lecture_social⟭ connecté à ⟬hostname#1⟭
[⟬date#1⟭ 06:15:30,410][WARN ][logstash.outputs.elasticsearch][social] Could not index event to Elasticsearch. {:status=>429, :action=>["index", {:_index=>"aides-2024"}, {"beneficiaire"=>"⟬trap:indicator_non_pii|ANONYME⟭", "aide"=>"RSA"}]}
[⟬date#1⟭ 06:15:31,002][INFO ][logstash.outputs.elasticsearch][social] retrying failed action with response code: 429
[⟬date#1⟭ 06:16:00,000][INFO ][logstash.agent           ][social] Pipelines running {:count=>1}
[⟬date#1⟭ 06:20:00,000][INFO ][logstash.filters.ruby    ][social] 880 documents traités
[⟬date#1⟭ 06:25:00,000][INFO ][logstash.filters.ruby    ][social] 1204 documents traités
[⟬date#1⟭ 06:25:12,400][WARN ][logstash.codecs.json     ][social] JSON parse error, original data now in message field {:message=>"Unexpected character", :data=>"nom: ⟬person_name#5⟭"}
[⟬date#1⟭ 06:30:00,000][INFO ][logstash.filters.ruby    ][social] 1640 documents traités
[⟬date#1⟭ 06:30:02,118][INFO ][logstash.javapipeline    ][social] Pipeline terminated {"pipeline.id"=>"social"}
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: public administration
appearance: PowerShell error, CategoryInfo block, command line
scenario: French PowerShell errors of a town hall's directory script, failing on a share and a service account, with no named agent
⟬text⟭
Import-Csv : Impossible de trouver le chemin d'accès « \\srv-fichiers\rh\agents.csv », car il n'existe pas.
Au caractère C:\Scripts\synchro_annuaire.ps1:12 : 11
+ $agents = Import-Csv -Path $source -Delimiter ";"
+           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (\\srv-fichiers\rh\agents.csv:String) [Import-Csv], ItemNotFoundException
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.ImportCsvCommand

Get-ADUser : Impossible de trouver un objet avec l'identité : '⟬trap:indicator_non_pii|svc-annuaire⟭' sous : 'DC=mairie,DC=local'.
Au caractère C:\Scripts\synchro_annuaire.ps1:18 : 10
+ $compte = Get-ADUser ⟬trap:indicator_non_pii|-Identity $NomCompte⟭ -Properties mail
+           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (svc-annuaire:ADUser) [Get-ADUser], ADIdentityNotFoundException
    + FullyQualifiedErrorId : ActiveDirectoryCmdlet,Microsoft.ActiveDirectory.Management.Commands.GetADUser

Send-MailMessage : Le serveur SMTP requiert une connexion sécurisée.
Au caractère C:\Scripts\synchro_annuaire.ps1:44 : 1
+ Send-MailMessage -To ⟬trap:indicator_non_pii|$Destinataire⟭ -Subject "Synchro en échec"
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (System.Net.Mail.SmtpClient:SmtpClient) [Send-MailMessage], SmtpException
    + FullyQualifiedErrorId : SmtpException,Microsoft.PowerShell.Commands.SendMailMessage
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: Spark executor error, row dump
scenario: failed Spark job on a health data warehouse, whose exception copies the faulty row with NIR, birth date and doctor
⟬text⟭
⟬date#1⟭ 02:14:44 ERROR Executor: Exception in task 41.0 in stage 12.0 (TID 8812)
org.apache.spark.SparkException: Failed to execute user defined function (Pseudonymisation$$Lambda$2210: (string, string) => string)
	at org.apache.spark.sql.errors.QueryExecutionErrors$.failedExecuteUserDefinedFunctionError(QueryExecutionErrors.scala:198)
	at org.apache.spark.sql.catalyst.expressions.GeneratedClass$GeneratedIteratorForCodegenStage4.processNext(Unknown Source)
	at org.apache.spark.sql.execution.BufferedRowIterator.hasNext(BufferedRowIterator.java:43)
	at org.apache.spark.scheduler.Task.run(Task.scala:141)
Caused by: java.lang.IllegalArgumentException: NIR mal formé dans la ligne [⟬customer_id#1⟭,⟬fr_social_security_number#1⟭,⟬birth_date#1⟭,"⟬person_name#1⟭","Dr ⟬person_name#2⟭"]
	at fr.sante.entrepot.Pseudonymisation$.hacher(Pseudonymisation.scala:44)
	at fr.sante.entrepot.Pseudonymisation$.$anonfun$udf$1(Pseudonymisation.scala:61)
	... 18 more
⟬date#1⟭ 02:14:44 WARN  TaskSetManager: Lost task 41.0 in stage 12.0 (TID 8812) (⟬hostname#1⟭ executor 4): org.apache.spark.SparkException: Failed to execute user defined function
⟬date#1⟭ 02:14:51 ERROR TaskSetManager: Task 41 in stage 12.0 failed 4 times; aborting job
⟬date#1⟭ 02:14:51 INFO  DAGScheduler: Job 7 failed: save at Pseudonymisation.scala:88, took 412.204 s
Exception in thread "main" org.apache.spark.SparkException: Job aborted due to stage failure: Task 41 in stage 12.0 failed 4 times
	at org.apache.spark.scheduler.DAGScheduler.failJobAndIndependentStages(DAGScheduler.scala:2844)
	at fr.sante.entrepot.Pseudonymisation$.main(Pseudonymisation.scala:88)
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Newman report, request body, summary table
scenario: Newman report of a shop's API tests, whose failures show the request bodies with the test account's email, password and card
⟬text⟭
newman

boutique-api

→ Créer un compte
  POST ⟬url#1⟭ [201 Created, 412B, 88ms]
  ✓  statut 201
  ✓  renvoie un identifiant

→ Se connecter
  POST ⟬url#2⟭ [200 OK, 812B, 104ms]
  ✓  statut 200
  1. jeton au format attendu

→ Payer la commande
  POST ⟬url#3⟭ [402 Payment Required, 188B, 212ms]
  2. statut 200

┌─────────────────────────┬──────────┬──────────┐
│                         │ executed │   failed │
├─────────────────────────┼──────────┼──────────┤
│              iterations │        1 │        0 │
│                requests │        3 │        0 │
│              assertions │        6 │        2 │
└─────────────────────────┴──────────┴──────────┘

  #  failure          detail

 1.  AssertionError   jeton au format attendu
                      expected "⟬jwt#1⟭" to match /^tok_/
 2.  AssertionError   statut 200
                      corps envoyé {"email":"⟬email#2⟭","motDePasse":"⟬password#2⟭","carte":"⟬payment_card#2⟭"}
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: banking
appearance: Hypothesis falsifying example, pytest failure
scenario: failed property test on bank fee calculation, where Hypothesis prints the shrunk example with account number, IBAN and holder
⟬text⟭
tests/test_frais.py F                                                    [100%]

================================== FAILURES ===================================
_____________________ test_frais_jamais_negatifs ______________________________

    @given(compte=comptes(), montant=decimals(min_value=0, max_value=10000))
>   def test_frais_jamais_negatifs(compte, montant):

tests/test_frais.py:31:
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

compte = Compte(numero='⟬bank_account_number#1⟭', iban='⟬iban#1⟭', titulaire="⟬person_name#1⟭")
montant = Decimal('0.01')

>       assert calculer_frais(compte, montant) >= 0
E       assert Decimal('-0.01') >= 0

tests/test_frais.py:33: AssertionError
---------------------------------- Hypothesis ---------------------------------
Falsifying example: test_frais_jamais_negatifs(
    compte=Compte(numero='⟬bank_account_number#1⟭', iban='⟬iban#1⟭', titulaire="⟬person_name#1⟭"),
    montant=Decimal('0.01'),
)
=========================== 1 failed, 88 passed in 12.41s =====================
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: GraphQL gateway log, operation name, masked variables
scenario: access of a shop's GraphQL gateway, whose variables are masked and whose operation names talk about customers without exposing any
⟬text⟭
⟬date#1⟭ 15:00:02 ip=⟬ip_address#1⟭ op=ProduitsParCategorie status=200 ms=41 vars={"categorie":"sacs","limite":24}
⟬date#1⟭ 15:00:04 ip=⟬ip_address#1⟭ op=Produit status=200 ms=18 vars={"sku":"⟬customer_id#1⟭"}
⟬date#1⟭ 15:00:09 ip=⟬ip_address#2⟭ op=⟬trap:indicator_non_pii|ClientParEmail⟭ status=200 ms=22 vars={"email":"⟬trap:indicator_non_pii|[masqué]⟭"}
⟬date#1⟭ 15:00:10 ip=⟬ip_address#2⟭ op=⟬trap:indicator_non_pii|AdressesDuClient⟭ status=200 ms=31 vars={"client":"⟬trap:indicator_non_pii|[masqué]⟭"}
⟬date#1⟭ 15:00:14 ip=⟬ip_address#2⟭ op=AjouterAuPanier status=200 ms=44 vars={"sku":"⟬customer_id#2⟭","qte":1}
⟬date#1⟭ 15:00:22 ip=⟬ip_address#3⟭ op=Connexion status=401 ms=12 vars={"login":"⟬trap:indicator_non_pii|[masqué]⟭","password":"⟬trap:placeholder|[masqué]⟭"}
⟬date#1⟭ 15:00:23 ip=⟬ip_address#3⟭ op=Connexion status=200 ms=96 vars={"login":"⟬trap:indicator_non_pii|[masqué]⟭","password":"⟬trap:placeholder|[masqué]⟭"}
⟬date#1⟭ 15:00:30 ip=⟬ip_address#3⟭ op=Commandes status=200 ms=61 vars={"page":1}
⟬date#1⟭ 15:00:41 ip=⟬ip_address#4⟭ op=AvisProduit status=200 ms=27 vars={"sku":"⟬customer_id#1⟭","auteur":"⟬trap:indicator_non_pii|tous⟭"}
⟬date#1⟭ 15:00:52 ip=⟬ip_address#5⟭ op=IntrospectionQuery status=403 ms=2 vars={}
⟬date#1⟭ 15:01:02 ip=⟬ip_address#1⟭ op=ProduitsParCategorie status=200 ms=38 vars={"categorie":"foulards","limite":24}
⟬date#1⟭ 15:01:13 ip=⟬ip_address#6⟭ op=FraisDePort status=200 ms=19 vars={"cp":"⟬postcode#1⟭"}
⟬date#1⟭ 15:01:20 ip=⟬ip_address#6⟭ op=PointsRelais status=200 ms=52 vars={"ville":"⟬city#2⟭"}
⟬date#1⟭ 15:01:31 ip=⟬ip_address#7⟭ op=Sante status=200 ms=1 vars={}
⟬date#1⟭ 15:01:44 ip=⟬ip_address#2⟭ op=Paiement status=200 ms=212 vars={"carte":"⟬trap:indicator_non_pii|[masqué]⟭","commande":"⟬order_number#1⟭"}
⟬date#1⟭ 15:02:01 ip=⟬ip_address#7⟭ op=Sante status=200 ms=1 vars={}
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: FHIR search in a query string, context field, family and given names apart
scenario: access of a regional FHIR server, whose patient searches keep family and given names in the URL, with the birth date in a context field
⟬text⟭
⟬ip_address#1⟭ - ⟬username#1⟭ [⟬date#1⟭ 10:02:11 +0100] "GET /fhir/Patient?family=⟬person_name:family#1⟭&given=⟬person_name:given#1⟭ HTTP/1.1" 200 2204 ctx="naissance=⟬birth_date#1⟭"
⟬ip_address#1⟭ - ⟬username#1⟭ [⟬date#1⟭ 10:02:14 +0100] "GET /fhir/Patient/⟬uuid#1⟭ HTTP/1.1" 200 1812 ctx="-"
⟬ip_address#1⟭ - ⟬username#1⟭ [⟬date#1⟭ 10:02:20 +0100] "GET /fhir/Encounter?subject=⟬uuid#1⟭&_count=20 HTTP/1.1" 200 4120 ctx="-"
⟬ip_address#2⟭ - ⟬username#2⟭ [⟬date#1⟭ 10:03:05 +0100] "GET /fhir/Patient?family=⟬person_name:family#2⟭ HTTP/1.1" 200 8120 ctx="naissance=⟬birth_date#2⟭"
⟬ip_address#2⟭ - ⟬username#2⟭ [⟬date#1⟭ 10:03:11 +0100] "GET /fhir/Patient?identifier=⟬customer_id#2⟭ HTTP/1.1" 200 1204 ctx="-"
⟬ip_address#3⟭ - ⟬trap:indicator_non_pii|user-etl⟭ [⟬date#1⟭ 10:04:00 +0100] "POST /fhir/Bundle HTTP/1.1" 200 412 ctx="lot=⟬uuid#2⟭"
⟬ip_address#3⟭ - ⟬trap:indicator_non_pii|user-etl⟭ [⟬date#1⟭ 10:04:30 +0100] "GET /fhir/metadata HTTP/1.1" 200 22044 ctx="-"
⟬ip_address#4⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 10:05:12 +0100] "GET /fhir/Practitioner?family=⟬person_name:family#4⟭ HTTP/1.1" 200 1204 ctx="-"
⟬ip_address#4⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 10:05:40 +0100] "GET /fhir/Patient?family=⟬person_name:family#5⟭&given=⟬person_name:given#5⟭ HTTP/1.1" 404 96 ctx="naissance=⟬birth_date#5⟭"
⟬ip_address#4⟭ - ⟬person_name:handle#3⟭ [⟬date#1⟭ 10:05:58 +0100] "GET /fhir/Patient?family=⟬person_name:family#5⟭ HTTP/1.1" 200 3320 ctx="-"
⟬ip_address#5⟭ - - [⟬date#1⟭ 10:06:30 +0100] "GET /sante HTTP/1.1" 200 2 ctx="-"
⟬ip_address#1⟭ - ⟬username#1⟭ [⟬date#1⟭ 10:07:02 +0100] "GET /fhir/Observation?patient=⟬uuid#1⟭&code=glucose HTTP/1.1" 200 2240 ctx="-"
⟬ip_address#6⟭ - ⟬trap:indicator_non_pii|user-sonde⟭ [⟬date#1⟭ 10:08:00 +0100] "GET /fhir/Patient?family=⟬trap:indicator_non_pii|TEST-SONDE⟭ HTTP/1.1" 200 88 ctx="-"
⟬ip_address#5⟭ - - [⟬date#1⟭ 10:08:30 +0100] "GET /sante HTTP/1.1" 200 2 ctx="-"
⟬ip_address#2⟭ - ⟬username#2⟭ [⟬date#1⟭ 10:09:15 +0100] "PUT /fhir/Patient/⟬uuid#3⟭ HTTP/1.1" 200 412 ctx="naissance=⟬birth_date#6⟭"
⟬ip_address#5⟭ - - [⟬date#1⟭ 10:10:30 +0100] "GET /sante HTTP/1.1" 200 2 ctx="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Windows agent output, net use command, batch echo
scenario: Jenkins pipeline on a Windows agent for a civil registry software, mounting a share with its password and printing a demo ID document
⟬text⟭
[Pipeline] bat

C:\jenkins\workspace\etat-civil>net use \\srv-depot\livraisons /user:MAIRIE\⟬username#1⟭ ⟬password#1⟭
La commande s'est terminée correctement.

C:\jenkins\workspace\etat-civil>xcopy /Y build\etat-civil-⟬version#1⟭.msi \\srv-depot\livraisons\
1 fichier(s) copié(s)

C:\jenkins\workspace\etat-civil>echo Jeton de publication ⟬gitlab_token#1⟭
Jeton de publication ⟬gitlab_token#1⟭

C:\jenkins\workspace\etat-civil>EtatCivil.Tests.exe --demo
Lecture de l'acte de démonstration
  Titulaire : ⟬person_name#2⟭
  Carte : ⟬fr_identity_card#2⟭
  Commune : ⟬city#2⟭
Tests réussis : 88, échoués : 0

C:\jenkins\workspace\etat-civil>net use \\srv-depot\livraisons /delete
\\srv-depot\livraisons a été supprimé avec succès.
[Pipeline] }
Finished: SUCCESS
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: banking
appearance: Vault login output, AWS CLI, cosign signature, CLI argument
scenario: image signing job of a bank, fetching a Vault token, temporary AWS keys and printing the signing key password
⟬text⟭
$ vault login -method=jwt role=ci-signature jwt=⟬jwt#1⟭
Success! You are now authenticated.
Key                  Value
---                  -----
token                ⟬opaque_token#1⟭
token_accessor       ⟬uuid#1⟭
token_duration       1h
token_policies       ["ci-signature"]
$ vault kv get -field=value ci/signature
⟬password#1⟭
$ export COSIGN_PASSWORD=⟬password#1⟭
$ aws sts assume-role --role-arn ⟬trap:indicator_non_pii|role/ci-signature⟭ --role-session-name ci
{"Credentials":{"AccessKeyId":"⟬aws_access_key_id#2⟭","SecretAccessKey":"⟬aws_secret_access_key#2⟭","Expiration":"⟬date#1⟭ 18:00:00"}}
$ cosign sign --key awskms:///alias/ci-signature ⟬hostname#1⟭/banque/api:⟬git_sha#1⟭
Pushing signature to: ⟬hostname#1⟭/banque/api
$ cosign verify --key awskms:///alias/ci-signature ⟬hostname#1⟭/banque/api:⟬git_sha#1⟭
Verification for ⟬hostname#1⟭/banque/api:⟬git_sha#1⟭ -- The following checks were performed
Job succeeded
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: plain sentences, bank account, job title, age, gendered names
scenario: annuity calculation log of a provident insurer, telling for each death the policyholder, job, age, beneficiaries and accounts
⟬text⟭
[INFO] (prevoyance.rentes) Démarrage du calcul mensuel, barème ⟬version#1⟭
[INFO] (prevoyance.rentes) 4 dossiers de décès à traiter
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#1⟭: décès de M. ⟬person_name#1m⟭, ⟬age#1⟭ ans, ⟬job_title#1⟭ chez ⟬company#1⟭.
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#1⟭: NIR de l'assuré ⟬fr_social_security_number#1⟭.
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#1⟭: bénéficiaire Mme ⟬person_name#2f⟭, née le ⟬birth_date#2⟭, conjointe survivante.
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#1⟭: rente mensuelle 812.40 EUR versée sur ⟬iban#2⟭.
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#1⟭: enfant à charge ⟬person_name:given#3⟭, part 20 %.
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#2⟭: décès de Mme ⟬person_name#4f⟭, ⟬age#4⟭ ans, ⟬job_title#4⟭.
[WARN] (prevoyance.dossier) Dossier ⟬ticket_id#2⟭: aucun bénéficiaire désigné, ordre légal appliqué.
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#2⟭: notaire ⟬person_name#5⟭ saisi, ⟬phone#5⟭.
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#3⟭: décès de M. ⟬person_name#6m⟭, ⟬age#6⟭ ans.
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#3⟭: bénéficiaire ⟬person_name#7⟭, compte ⟬bank_account_number#7⟭, RIB à vérifier.
[ERROR] (prevoyance.dossier) Dossier ⟬ticket_id#3⟭: nom du compte différent de "⟬person_name#7⟭", rente suspendue.
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#3⟭: courrier préparé pour "⟬fr_postal_address#7⟭".
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#4⟭: décès de M. ⟬person_name#8m⟭, sans contrat actif.
[INFO] (prevoyance.dossier) Dossier ⟬ticket_id#4⟭: clôture par ⟬trap:indicator_non_pii|gestionnaire=regle-sans-contrat⟭.
[INFO] (prevoyance.table) Table de mortalité TH-TF chargée, loi de ⟬trap:eponym|Gompertz⟭.
[INFO] (prevoyance.table) Taux technique 1,5 %.
[INFO] (prevoyance.rentes) Rentes en cours: 1204.
[INFO] (prevoyance.rentes) Revalorisation appliquée: 1,2 %.
[INFO] (prevoyance.virements) Génération du fichier SEPA.
[INFO] (prevoyance.virements) Bénéficiaire Mme ⟬person_name:family#2f⟭: 812.40 EUR.
[INFO] (prevoyance.virements) Bénéficiaire ⟬person_name:initial#9⟭: 402.10 EUR sur ⟬iban#9⟭.
[INFO] (prevoyance.virements) Bénéficiaire ⟬person_name:initial#10⟭: 611.75 EUR sur ⟬iban#10⟭.
[WARN] (prevoyance.virements) Bénéficiaire ⟬person_name#11m⟭ âgé de plus de 100 ans, certificat de vie demandé.
[INFO] (prevoyance.virements) Fichier SEPA écrit dans ⟬file_path#1⟭.
[INFO] (prevoyance.virements) Empreinte ⟬hash#1⟭ transmise à la banque ⟬bic#1⟭.
[INFO] (prevoyance.controle) Contrôle des certificats de vie.
[INFO] (prevoyance.controle) 42 certificats manquants.
[INFO] (prevoyance.controle) Relance de ⟬person_name#12⟭ à ⟬email#12⟭.
[INFO] (prevoyance.controle) Relance de ⟬person_name#13⟭ par courrier, "⟬fr_postal_address#13⟭".
[INFO] (prevoyance.controle) Relance de ⟬person_name#14⟭ par courrier, "⟬fr_postal_address#14⟭".
[INFO] (prevoyance.controle) 39 autres relances envoyées par le lot ⟬uuid#1⟭.
[INFO] (prevoyance.fiscal) Déclaration annuelle préparée.
[INFO] (prevoyance.fiscal) Numéro fiscal de ⟬person_name#2f⟭: ⟬fr_tax_number#2⟭.
[INFO] (prevoyance.fiscal) Numéro fiscal de ⟬person_name#7⟭: ⟬fr_tax_number#7⟭.
[WARN] (prevoyance.fiscal) Numéro fiscal absent pour ⟬person_name#11⟭.
[INFO] (prevoyance.fiscal) Fichier déposé sur ⟬url#1⟭
[INFO] (prevoyance.echanges) Interrogation du répertoire des décès.
[INFO] (prevoyance.echanges) ⟬trap:indicator_non_pii|user=echanges-prevoyance⟭ connecté à ⟬hostname#1⟭.
[INFO] (prevoyance.echanges) 2 nouveaux décès possibles.
[INFO] (prevoyance.echanges) Correspondance à vérifier: ⟬person_name#15m⟭, né le ⟬birth_date#15⟭.
[INFO] (prevoyance.echanges) Correspondance à vérifier: ⟬person_name#16f⟭, née le ⟬birth_date#16⟭.
[INFO] (prevoyance.echanges) Dossiers confiés à ⟬person_name:given#17⟭ pour lundi.
[INFO] (prevoyance.bilan) Provisions mathématiques: 41 204 118,20 EUR.
[INFO] (prevoyance.bilan) Écart avec le mois précédent: 0,4 %.
[INFO] (prevoyance.bilan) Rapport envoyé à ⟬email:generic#18⟭.
[INFO] (prevoyance.bilan) ⟬trap:indicator_non_pii|responsable=actuariat⟭ prévenu.
[INFO] (prevoyance.rentes) Fin du calcul en 412 s.
[INFO] (prevoyance.purge) Fichiers temporaires supprimés.
[INFO] (prevoyance.sonde) Base joignable.
[INFO] (prevoyance.sonde) File de messages vide.
[INFO] (prevoyance.sonde) Espace disque 62 %.
[INFO] (prevoyance.archive) Archive du mois ⟬uuid#2⟭ créée.
[INFO] (prevoyance.archive) Copie vers ⟬hostname#2⟭ terminée.
[INFO] (prevoyance.archive) Rétention appliquée: 120 mois.
[INFO] (prevoyance.rentes) Prochain calcul programmé.
[INFO] (prevoyance.sonde) Base joignable.
[INFO] (prevoyance.sonde) File de messages vide.
[INFO] (prevoyance.sonde) Base joignable.
[INFO] (prevoyance.sonde) File de messages vide.
[INFO] (prevoyance.sonde) Base joignable.
[INFO] (prevoyance.sonde) File de messages vide.
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: banking
appearance: semicolon-separated log, quoted value, four-eyes approval
scenario: semicolon-separated log of four-eyes approvals in a treasury department, with operators, beneficiaries, IBANs and technical accounts
⟬text⟭
date;heure;acteur;action;objet;detail
⟬date#1⟭;08:02:11;"⟬person_name#1⟭";SAISIE;VIR-0001;beneficiaire="⟬company#2⟭" iban=⟬iban#2⟭ montant=48200.00
⟬date#1⟭;08:03:40;"⟬person_name#3⟭";VALIDATION;VIR-0001;niveau=1
⟬date#1⟭;08:04:02;"⟬person_name#4⟭";VALIDATION;VIR-0001;niveau=2
⟬date#1⟭;08:04:03;⟬trap:indicator_non_pii|moteur-paiements⟭;ENVOI;VIR-0001;lot=⟬uuid#1⟭
⟬date#1⟭;08:10:18;"⟬person_name#1⟭";SAISIE;VIR-0002;beneficiaire="⟬company#5⟭" iban=⟬iban#5⟭ montant=7120.50
⟬date#1⟭;08:11:02;"⟬person_name#1⟭";VALIDATION;VIR-0002;REFUS auto-validation interdite
⟬date#1⟭;08:12:40;"⟬person_name#3⟭";VALIDATION;VIR-0002;niveau=1
⟬date#1⟭;08:13:15;"⟬person_name#4⟭";VALIDATION;VIR-0002;niveau=2
⟬date#1⟭;08:13:16;⟬trap:indicator_non_pii|moteur-paiements⟭;ENVOI;VIR-0002;lot=⟬uuid#2⟭
⟬date#1⟭;08:20:44;"⟬person_name#6⟭";SAISIE;VIR-0003;beneficiaire="⟬person_name#7⟭" iban=⟬iban#7⟭ montant=2400.00 motif="salaire"
⟬date#1⟭;08:21:30;"⟬person_name#3⟭";VALIDATION;VIR-0003;niveau=1
⟬date#1⟭;08:22:02;"⟬person_name#4⟭";VALIDATION;VIR-0003;niveau=2
⟬date#1⟭;08:22:03;⟬trap:indicator_non_pii|moteur-paiements⟭;ENVOI;VIR-0003;lot=⟬uuid#3⟭
⟬date#1⟭;08:30:00;⟬trap:indicator_non_pii|rapprochement⟭;CONTROLE;SOLDE;compte=⟬bank_account_number#8⟭ ecart=0.00
⟬date#1⟭;08:45:10;"⟬person_name#1⟭";MODIFICATION;BENEF-412;nom="⟬company#2⟭" ancien_iban=⟬iban#2⟭ nouvel_iban=⟬iban#9⟭
⟬date#1⟭;08:45:11;⟬trap:indicator_non_pii|regle-rib-1⟭;ALERTE;BENEF-412;changement de RIB fournisseur
⟬date#1⟭;08:52:30;"⟬person_name#3⟭";APPEL;BENEF-412;contact="⟬person_name#10⟭" tel=⟬phone#10⟭ resultat=confirme
⟬date#1⟭;08:53:02;"⟬person_name#3⟭";VALIDATION;BENEF-412;niveau=1
⟬date#1⟭;08:53:40;"⟬person_name#4⟭";VALIDATION;BENEF-412;niveau=2
⟬date#1⟭;09:02:12;"⟬person_name#1⟭";SAISIE;VIR-0004;beneficiaire="⟬company#11⟭" iban=⟬iban#11⟭ montant=118400.00
⟬date#1⟭;09:02:13;⟬trap:indicator_non_pii|regle-seuil-2⟭;ALERTE;VIR-0004;montant au-dessus du seuil
⟬date#1⟭;09:10:44;"⟬person_name#3⟭";VALIDATION;VIR-0004;niveau=1
⟬date#1⟭;09:12:02;"⟬person_name#4⟭";VALIDATION;VIR-0004;niveau=2
⟬date#1⟭;09:20:17;"⟬person_name#12⟭";VALIDATION;VIR-0004;niveau=3 direction
⟬date#1⟭;09:20:18;⟬trap:indicator_non_pii|moteur-paiements⟭;ENVOI;VIR-0004;lot=⟬uuid#4⟭
⟬date#1⟭;09:30:00;⟬trap:indicator_non_pii|rapprochement⟭;CONTROLE;SOLDE;compte=⟬bank_account_number#8⟭ ecart=0.00
⟬date#1⟭;09:41:05;"⟬person_name#6⟭";CONNEXION;SESSION;poste=⟬ip_address#1⟭
⟬date#1⟭;09:41:50;"⟬person_name#6⟭";SAISIE;VIR-0005;beneficiaire="⟬person_name#13⟭" iban=⟬iban#13⟭ montant=1800.00 motif="note de frais"
⟬date#1⟭;09:42:30;"⟬person_name#3⟭";VALIDATION;VIR-0005;niveau=1
⟬date#1⟭;09:43:02;"⟬person_name#4⟭";VALIDATION;VIR-0005;REFUS justificatif manquant
⟬date#1⟭;09:43:03;⟬trap:indicator_non_pii|workflow⟭;RETOUR;VIR-0005;renvoye a "⟬person_name#6⟭"
⟬date#1⟭;10:00:00;⟬trap:indicator_non_pii|moteur-paiements⟭;BILAN;JOUR;envoyes=4 refuses=1
⟬date#1⟭;10:05:12;"⟬person_name#14⟭";CONSULTATION;JOURNAL;audit interne
⟬date#1⟭;10:06:40;"⟬person_name#14⟭";EXPORT;JOURNAL;fichier=⟬file_path#1⟭
⟬date#1⟭;10:30:00;⟬trap:indicator_non_pii|rapprochement⟭;CONTROLE;SOLDE;compte=⟬bank_account_number#8⟭ ecart=0.00
⟬date#1⟭;10:44:51;"⟬person_name#1⟭";DECONNEXION;SESSION;duree=9520
⟬date#1⟭;11:00:00;⟬trap:indicator_non_pii|moteur-paiements⟭;SONDE;BANQUE;latence=41
⟬date#1⟭;11:12:33;"⟬person_name#6⟭";SAISIE;VIR-0006;beneficiaire="⟬company#15⟭" iban=⟬iban#15⟭ montant=3120.40
⟬date#1⟭;11:13:20;"⟬person_name#3⟭";VALIDATION;VIR-0006;niveau=1
⟬date#1⟭;11:14:02;"⟬person_name#4⟭";VALIDATION;VIR-0006;niveau=2
⟬date#1⟭;11:14:03;⟬trap:indicator_non_pii|moteur-paiements⟭;ENVOI;VIR-0006;lot=⟬uuid#5⟭
⟬date#1⟭;11:30:00;⟬trap:indicator_non_pii|rapprochement⟭;CONTROLE;SOLDE;compte=⟬bank_account_number#8⟭ ecart=0.00
⟬date#1⟭;11:45:30;⟬trap:indicator_non_pii|rotation-cles⟭;ROTATION;CERTIFICAT;empreinte=⟬hash#1⟭
⟬date#1⟭;12:00:00;⟬trap:indicator_non_pii|moteur-paiements⟭;BILAN;DEMI-JOURNEE;envoyes=5 refuses=1
⟬date#1⟭;12:30:00;⟬trap:indicator_non_pii|rapprochement⟭;CONTROLE;SOLDE;compte=⟬bank_account_number#8⟭ ecart=0.00
⟬date#1⟭;13:02:44;"⟬person_name#3⟭";CONNEXION;SESSION;poste=⟬ip_address#2⟭
⟬date#1⟭;13:05:18;"⟬person_name#6⟭";CORRECTION;VIR-0005;justificatif=⟬invoice_number#1⟭
⟬date#1⟭;13:06:02;"⟬person_name#3⟭";VALIDATION;VIR-0005;niveau=1
⟬date#1⟭;13:07:11;"⟬person_name#4⟭";VALIDATION;VIR-0005;niveau=2
⟬date#1⟭;13:07:12;⟬trap:indicator_non_pii|moteur-paiements⟭;ENVOI;VIR-0005;lot=⟬uuid#6⟭
⟬date#1⟭;13:30:00;⟬trap:indicator_non_pii|rapprochement⟭;CONTROLE;SOLDE;compte=⟬bank_account_number#8⟭ ecart=0.00
⟬date#1⟭;14:00:00;⟬trap:indicator_non_pii|moteur-paiements⟭;SONDE;BANQUE;latence=44
⟬date#1⟭;14:30:00;⟬trap:indicator_non_pii|rapprochement⟭;CONTROLE;SOLDE;compte=⟬bank_account_number#8⟭ ecart=0.00
⟬date#1⟭;15:00:00;⟬trap:indicator_non_pii|moteur-paiements⟭;SONDE;BANQUE;latence=39
⟬date#1⟭;15:30:00;⟬trap:indicator_non_pii|rapprochement⟭;CONTROLE;SOLDE;compte=⟬bank_account_number#8⟭ ecart=0.00
⟬date#1⟭;16:00:00;⟬trap:indicator_non_pii|moteur-paiements⟭;SONDE;BANQUE;latence=42
⟬date#1⟭;16:30:00;⟬trap:indicator_non_pii|rapprochement⟭;CONTROLE;SOLDE;compte=⟬bank_account_number#8⟭ ecart=0.00
⟬date#1⟭;17:00:00;⟬trap:indicator_non_pii|moteur-paiements⟭;BILAN;JOUR;envoyes=6 refuses=0
⟬date#1⟭;17:01:30;"⟬person_name#4⟭";CLOTURE;JOUR;signature=⟬hash#2⟭
⟬date#1⟭;17:02:00;⟬trap:indicator_non_pii|sauvegarde⟭;ARCHIVE;JOURNAL;cible=⟬hostname#1⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: firmware build output, make log, Kconfig value
scenario: firmware build of an operator's box, with eponymous drivers, configuration options about passwords and no sensitive value
⟬text⟭
$ make -j8 V=1 BOARD=box-v5
  GEN     include/generated/autoconf.h
  CC      kernel/bounds.s
  CC      arch/arm64/kernel/asm-offsets.s
  CALL    scripts/atomic/check-atomics.sh
  CC      init/main.o
  CC      init/version.o
  CC      kernel/fork.o
  CC      kernel/sched/core.o
  CC      mm/memory.o
  CC      fs/squashfs/super.o
  CC      net/core/dev.o
  CC      net/ipv4/tcp.o
  CC      drivers/net/phy/⟬trap:code_identifier|⦃family⦄_phy⟭.o
  CC      drivers/net/wireless/box/wifi6_core.o
  CC      drivers/net/wireless/box/⟬trap:code_identifier|⦃family2⦄_rate⟭.o
  CC      crypto/⟬trap:eponym|rijndael⟭_generic.o
  CC      crypto/⟬trap:eponym|blowfish⟭_common.o
  CC      lib/⟬trap:eponym|reed_solomon⟭/reed_solomon.o
  AR      built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.symvers
  LD      vmlinux
  OBJCOPY arch/arm64/boot/Image
  GZIP    arch/arm64/boot/Image.gz
  DTC     arch/arm64/boot/dts/box/box-v5.dtb
  Image: arch/arm64/boot/Image.gz is ready
==> rootfs
  INSTALL /build/rootfs/usr/sbin/hostapd
  INSTALL /build/rootfs/usr/sbin/dnsmasq
  INSTALL /build/rootfs/usr/sbin/dropbear
  INSTALL /build/rootfs/usr/bin/cwmp-client
==> verification de la configuration
⟬trap:placeholder|CONFIG_DEFAULT_ROOT_PASSWORD=""⟭
⟬trap:indicator_non_pii|CONFIG_WIFI_PSK_MIN_LEN=12⟭
⟬trap:indicator_non_pii|CONFIG_WIFI_PSK_RANDOM=y⟭
⟬trap:indicator_non_pii|CONFIG_ADMIN_USER="admin"⟭
⟬trap:indicator_non_pii|CONFIG_ACS_USERNAME_FROM_SERIAL=y⟭
⟬trap:indicator_non_pii|CONFIG_TOKEN_LIFETIME=3600⟭
CONFIG_TELNET=n
CONFIG_SSH_ROOT_LOGIN=n
==> image
  MKSQUASHFS rootfs.squashfs
  size: 41204118 bytes (39.3 MiB)
  SHA256 ⟬hash#1⟭
  SIGN    box-v5-⟬version#1⟭.img
  key id  ⟬hash#2⟭
==> test sur banc
  flash /dev/ttyUSB0 ok
  boot en 18 s
  wifi 2.4 GHz ok
  wifi 5 GHz ok
  wifi 6 GHz ok
  dsl synchro 412 Mbit/s
  portail d'administration ok
  ⟬trap:indicator_non_pii|login=admin⟭ refusé sans mot de passe unique
  acs joignable sur ⟬url#1⟭
==> publication
  depot ⟬file_path#1⟭
  canal: beta
  ⟬trap:indicator_non_pii|owner=equipe-box⟭
==> fin du build
Build finished in 41m12s
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: plain sentences, gendered names, multi-day audit trail
scenario: history of a brokerage extranet over several days, where each action cites the broker, the customer (Mrs or Mr), their address, plate and licence
⟬text⟭
⟬date#3⟭ 09:12 Connexion du courtier ⟬person_name:initial#1⟭ (cabinet ⟬company#1⟭).
⟬date#3⟭ 09:14 Création du prospect Mme ⟬person_name#2f⟭, née le ⟬birth_date#2⟭.
⟬date#3⟭ 09:15 Adresse saisie: ⟬fr_postal_address#2⟭.
⟬date#3⟭ 09:16 Téléphone ⟬phone#2⟭, courriel ⟬email#2⟭.
⟬date#3⟭ 09:18 Véhicule déclaré ⟬fr_license_plate#2⟭, permis ⟬fr_driving_licence#2⟭.
⟬date#3⟭ 09:20 Devis ⟬order_number#2⟭ calculé: 612.40 EUR par an.
⟬date#3⟭ 09:21 Devis envoyé à Mme ⟬person_name:family#2f⟭.
⟬date#3⟭ 09:40 Création du prospect M. ⟬person_name#3m⟭, né le ⟬birth_date#3⟭.
⟬date#3⟭ 09:41 Adresse saisie: ⟬fr_postal_address#3⟭.
⟬date#3⟭ 09:43 Véhicule déclaré ⟬fr_license_plate#3⟭, permis ⟬fr_driving_licence#3⟭.
⟬date#3⟭ 09:45 Antécédent signalé: sinistre responsable, dossier ⟬ticket_id#1⟭.
⟬date#3⟭ 09:46 Devis ⟬order_number#3⟭ calculé: 884.10 EUR par an.
⟬date#3⟭ 10:02 Déconnexion du courtier ⟬person_name:initial#1⟭.
⟬date#2⟭ 14:05 Connexion de la collaboratrice ⟬person_name#4f⟭ (cabinet ⟬company#1⟭).
⟬date#2⟭ 14:07 Mme ⟬person_name:family#2f⟭ accepte le devis ⟬order_number#2⟭.
⟬date#2⟭ 14:08 Contrat ⟬customer_id#2⟭ créé.
⟬date#2⟭ 14:10 Mandat de prélèvement signé, IBAN ⟬iban#2⟭.
⟬date#2⟭ 14:12 Attestation envoyée à ⟬email#2⟭.
⟬date#2⟭ 14:13 ⟬trap:indicator_non_pii|gestionnaire=moteur-attestations⟭ a généré la pièce ⟬uuid#1⟭.
⟬date#2⟭ 14:30 M. ⟬person_name:family#3m⟭ demande une baisse de prime.
⟬date#2⟭ 14:32 Dérogation demandée à ⟬person_name:given#5m⟭, inspecteur.
⟬date#2⟭ 15:10 Dérogation refusée par ⟬person_name:given#5m⟭.
⟬date#2⟭ 15:12 Devis ⟬order_number#3⟭ classé sans suite.
⟬date#2⟭ 15:40 Déconnexion de la collaboratrice ⟬person_name#4f⟭.
⟬date#2⟭ 16:00 ⟬trap:indicator_non_pii|gestionnaire=purge-devis⟭ a supprimé 12 devis expirés.
⟬date#1⟭ 08:45 Connexion du courtier ⟬person_name:initial#1⟭.
⟬date#1⟭ 08:47 Déclaration de sinistre pour le contrat ⟬customer_id#2⟭.
⟬date#1⟭ 08:48 Conducteur: Mme ⟬person_name#2f⟭, véhicule ⟬fr_license_plate#2⟭.
⟬date#1⟭ 08:50 Tiers: M. ⟬person_name#6m⟭, plaque ⟬fr_license_plate#6⟭, permis ⟬fr_driving_licence#6⟭.
⟬date#1⟭ 08:52 Lieu: ⟬trap:word_name|place de la Liberté⟭, ⟬city#2⟭.
⟬date#1⟭ 08:55 Constat amiable joint, pièce ⟬uuid#2⟭.
⟬date#1⟭ 09:02 Dossier ⟬ticket_id#2⟭ transmis à l'assureur ⟬company#7⟭.
⟬date#1⟭ 09:05 Contact chez l'assureur: ⟬person_name#8⟭, ⟬phone#8⟭.
⟬date#1⟭ 09:30 Garage conseillé: ⟬trap:company_name|Carrosserie ⦃Family⦄⟭.
⟬date#1⟭ 09:31 Adresse du garage: ⟬fr_postal_address#9⟭.
⟬date#1⟭ 09:33 Mme ⟬person_name:family#2f⟭ prévenue par SMS.
⟬date#1⟭ 10:00 Création du prospect ⟬company#10⟭, SIREN ⟬fr_siren#10⟭.
⟬date#1⟭ 10:02 Gérant: ⟬person_name#10⟭.
⟬date#1⟭ 10:03 Flotte de 4 véhicules déclarée.
⟬date#1⟭ 10:05 Véhicule ⟬fr_license_plate#11⟭.
⟬date#1⟭ 10:05 Véhicule ⟬fr_license_plate#12⟭.
⟬date#1⟭ 10:06 Véhicule ⟬fr_license_plate#13⟭.
⟬date#1⟭ 10:06 Véhicule ⟬fr_license_plate#14⟭.
⟬date#1⟭ 10:10 Devis flotte ⟬order_number#10⟭ calculé: 4 120.00 EUR par an.
⟬date#1⟭ 10:12 Déconnexion du courtier ⟬person_name:initial#1⟭.
⟬date#1⟭ 11:00 ⟬trap:indicator_non_pii|gestionnaire=rappels⟭ programme un rappel pour Mme ⟬person_name:family#2f⟭.
⟬date#1⟭ 11:30 Contrôle de conformité par ⟬person_name#15⟭.
⟬date#1⟭ 11:32 Aucune anomalie sur le cabinet ⟬company#1⟭.
⟬date#1⟭ 12:00 Commission calculée pour le cabinet: 91.86 EUR.
⟬date#1⟭ 12:01 Virement de commission sur ⟬iban#1⟭.
⟬date#1⟭ 12:30 ⟬trap:indicator_non_pii|gestionnaire=rapprochement⟭ valide les commissions.
⟬date#1⟭ 13:45 Connexion de la collaboratrice ⟬person_name#4f⟭.
⟬date#1⟭ 13:47 Mise à jour de l'adresse de M. ⟬person_name:family#3m⟭.
⟬date#1⟭ 13:48 Nouvelle adresse: ⟬fr_postal_address#16⟭.
⟬date#1⟭ 13:50 Courrier de bienvenue annulé.
⟬date#1⟭ 14:05 Déconnexion de la collaboratrice ⟬person_name#4f⟭.
⟬date#1⟭ 14:30 ⟬trap:indicator_non_pii|gestionnaire=sauvegarde⟭ archive le journal du jour.
⟬date#1⟭ 14:31 Empreinte du journal ⟬hash#1⟭.
⟬date#1⟭ 15:00 Sonde de disponibilité ok.
⟬date#1⟭ 16:00 Sonde de disponibilité ok.
⟬date#1⟭ 17:00 Sonde de disponibilité ok.
⟬date#1⟭ 18:00 Fermeture de l'extranet pour maintenance.
⟬end⟭
