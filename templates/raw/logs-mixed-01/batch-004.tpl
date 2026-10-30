⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: banking
appearance: loguru line, alert record, quoted field, initials alone, analyst on both sides, value alone at end of line
scenario: anti-money-laundering scoring of a French private bank, whose loguru output keeps holders, tax numbers and the analysts who close each alert
⟬text⟭
⟬date#1⟭ 09:14:03.118 | INFO     | lcb.alerts.scorer:run:88 - lot de 461 virements, seuil=0.80, user=⟬trap:indicator_non_pii|svc_lcb⟭
⟬date#1⟭ 09:14:05.402 | WARNING  | lcb.alerts.scorer:run:104 - alerte ⟬ticket_id#1⟭ score=0.93 titulaire="⟬person_name#1⟭" iban="⟬iban#1⟭" nir="⟬fr_social_security_number#1⟭"
⟬date#1⟭ 09:14:05.403 | DEBUG    | lcb.alerts.scorer:run:109 - contrepartie ⟬company#2⟭ à ⟬city#2⟭, compte ⟬iban#2⟭
⟬date#1⟭ 09:14:06.118 | WARNING  | lcb.alerts.scorer:run:104 - alerte ⟬ticket_id#2⟭ score=0.84 titulaire="⟬person_name#3⟭" iban="⟬iban#3⟭" ⟬fr_social_security_number#3⟭
⟬date#1⟭ 09:14:06.119 | INFO     | lcb.alerts.fatca:check:52 - résident fiscal US détecté, tin="⟬us_itin#3⟭"
⟬date#1⟭ 09:14:07.640 | INFO     | lcb.alerts.scorer:run:131 - 459 virements sans alerte
⟬date#1⟭ 09:14:07.641 | DEBUG    | lcb.alerts.scorer:run:133 - ctx="modele=v4 seuil=0.80 shard=2"
⟬date#1⟭ 09:30:12.204 | INFO     | lcb.alerts.queue:assign:57 - alerte ⟬ticket_id#1⟭ affectée analyst=⟬trap:initials|SB⟭
⟬date#1⟭ 09:30:12.207 | INFO     | lcb.alerts.queue:assign:57 - alerte ⟬ticket_id#2⟭ affectée analyst="⟬person_name#4⟭"
⟬date#1⟭ 10:02:47.511 | INFO     | lcb.alerts.review:close:73 - alerte ⟬ticket_id#1⟭ classée, motif=vente immobilière, analyst=⟬trap:initials|SB⟭
⟬date#1⟭ 10:02:47.514 | INFO     | lcb.alerts.review:close:78 - client rappelé par son conseiller ⟬person_name#6m⟭
⟬date#1⟭ 10:41:09.300 | WARNING  | lcb.alerts.review:escalate:92 - alerte ⟬ticket_id#2⟭ transmise au responsable ⟬person_name#5m⟭
⟬date#1⟭ 10:41:09.302 | DEBUG    | lcb.alerts.review:escalate:96 - pièces jointes ⟬file_path#1⟭ value=⟬hash#1⟭
⟬date#1⟭ 11:15:38.118 | INFO     | lcb.alerts.review:report:118 - déclaration préparée pour ⟬person_name#3⟭
⟬date#1⟭ 11:15:38.119 | INFO     | lcb.alerts.review:report:119 - rédigée par user=⟬person_name#5⟭
⟬date#1⟭ 11:15:38.120 | INFO     | lcb.alerts.review:report:121 - dépôt en attente, operator=⟬trap:indicator_non_pii|tracfin-gateway⟭
⟬date#1⟭ 11:30:00.002 | INFO     | lcb.alerts.stats:flush:22 - ouvertes=1 closes=1 owner=⟬trap:indicator_non_pii|conformite-paris⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Airflow task log, context variables, connection line, stand-in values, stack of retries, field holding several values, eponym
scenario: nightly usage aggregation DAG of a French HR analytics product, a long Airflow task log with team owners, masked connection fields and one retried query
⟬text⟭
[⟬date#1⟭ 02:00:03,118] {local_task_job_runner.py:120} INFO - ::group::Pre task execution logs
[⟬date#1⟭ 02:00:03,204] {taskinstance.py:1979} INFO - Dependencies all met for <TaskInstance: agregation_usage.calcul_mensuel scheduled_run_418 [queued]>
[⟬date#1⟭ 02:00:03,221] {taskinstance.py:1979} INFO - Dependencies all met for <TaskInstance: agregation_usage.calcul_mensuel scheduled_run_418 [queued]>
[⟬date#1⟭ 02:00:03,222] {taskinstance.py:2193} INFO - Starting attempt 1 of 3
[⟬date#1⟭ 02:00:03,240] {taskinstance.py:2214} INFO - Executing <Task(PythonOperator): calcul_mensuel> on scheduled_run_418
[⟬date#1⟭ 02:00:03,251] {standard_task_runner.py:60} INFO - Started process 2351 to run task
[⟬date#1⟭ 02:00:03,260] {standard_task_runner.py:87} INFO - Job 59726: Subtask calcul_mensuel
[⟬date#1⟭ 02:00:03,311] {task_command.py:423} INFO - Running <TaskInstance: agregation_usage.calcul_mensuel scheduled_run_418 [running]> on host ⟬hostname#1⟭
[⟬date#1⟭ 02:00:03,402] {taskinstance.py:2510} INFO - Exporting env vars: AIRFLOW_CTX_DAG_OWNER=⟬trap:indicator_non_pii|data-eng⟭ AIRFLOW_CTX_DAG_ID=agregation_usage AIRFLOW_CTX_TASK_ID=calcul_mensuel
[⟬date#1⟭ 02:00:03,403] {taskinstance.py:2510} INFO - AIRFLOW_CTX_DAG_EMAIL=⟬trap:indicator_non_pii|<masked>⟭
[⟬date#1⟭ 02:00:03,420] {base.py:83} INFO - Using connection ID 'entrepot' for task execution.
[⟬date#1⟭ 02:00:03,421] {base.py:84} INFO - host=⟬hostname#2⟭ port=5432 schema=usage login=⟬trap:indicator_non_pii|etl_ro⟭ password=⟬trap:placeholder|***⟭
[⟬date#1⟭ 02:00:03,520] {sql.py:276} INFO - Running statement: SELECT tenant_id, count(*) FROM connexions GROUP BY 1, parameters: None
[⟬date#1⟭ 02:00:41,118] {sql.py:285} INFO - Rows affected: 565
[⟬date#1⟭ 02:00:41,204] {calcul.py:58} INFO - agrégation de 565 clients, fenêtre glissante 30 jours
[⟬date#1⟭ 02:00:41,205] {calcul.py:61} INFO - ctx="partition=mensuelle workers=4 memory_gb=16"
[⟬date#1⟭ 02:01:12,402] {calcul.py:74} INFO - lissage ⟬trap:eponym|Holt-Winters⟭ appliqué aux séries, 565 séries
[⟬date#1⟭ 02:01:12,403] {calcul.py:77} INFO - détection d'anomalies, seuil ⟬trap:eponym|Grubbs⟭ alpha=0.05
[⟬date#1⟭ 02:01:44,118] {calcul.py:91} INFO - tenant ⟬customer_id#1⟭ : 3 anomalies, owner=⟬trap:indicator_non_pii|customer-success⟭
[⟬date#1⟭ 02:01:44,119] {calcul.py:91} INFO - tenant ⟬customer_id#2⟭ : 1 anomalie, owner=⟬trap:indicator_non_pii|customer-success⟭
[⟬date#1⟭ 02:01:44,120] {calcul.py:91} INFO - tenant ⟬customer_id#3⟭ : 7 anomalies, owner=⟬trap:indicator_non_pii|partner-desk⟭
[⟬date#1⟭ 02:02:03,511] {sql.py:276} INFO - Running statement: INSERT INTO usage_mensuel SELECT * FROM tmp_usage, parameters: None
[⟬date#1⟭ 02:03:03,512] {taskinstance.py:2731} ERROR - Task failed with exception
[⟬date#1⟭ 02:03:03,513] {taskinstance.py:2731} ERROR - psycopg2.errors.QueryCanceled: canceling statement due to statement timeout
[⟬date#1⟭ 02:03:03,520] {taskinstance.py:1149} INFO - Marking task as UP_FOR_RETRY. dag_id=agregation_usage, task_id=calcul_mensuel, execution_id=scheduled_run_418
[⟬date#1⟭ 02:03:03,540] {standard_task_runner.py:107} ERROR - Failed to execute job 59726 for task calcul_mensuel
[⟬date#1⟭ 02:03:03,600] {local_task_job_runner.py:234} INFO - Task exited with return code 1
[⟬date#1⟭ 02:08:03,118] {local_task_job_runner.py:120} INFO - ::group::Pre task execution logs
[⟬date#1⟭ 02:08:03,204] {taskinstance.py:1979} INFO - Dependencies all met for <TaskInstance: agregation_usage.calcul_mensuel scheduled_run_418 [queued]>
[⟬date#1⟭ 02:08:03,222] {taskinstance.py:2193} INFO - Starting attempt 2 of 3
[⟬date#1⟭ 02:08:03,240] {taskinstance.py:2214} INFO - Executing <Task(PythonOperator): calcul_mensuel> on scheduled_run_418
[⟬date#1⟭ 02:08:03,251] {standard_task_runner.py:60} INFO - Started process 2418 to run task
[⟬date#1⟭ 02:08:03,311] {task_command.py:423} INFO - Running <TaskInstance: agregation_usage.calcul_mensuel scheduled_run_418 [running]> on host ⟬hostname#3⟭
[⟬date#1⟭ 02:08:03,420] {base.py:83} INFO - Using connection ID 'entrepot' for task execution.
[⟬date#1⟭ 02:08:03,421] {base.py:84} INFO - host=⟬hostname#2⟭ port=5432 schema=usage login=⟬trap:indicator_non_pii|etl_ro⟭ password=⟬trap:placeholder|***⟭
[⟬date#1⟭ 02:08:03,430] {calcul.py:44} INFO - reprise depuis le point de contrôle ⟬file_path#1⟭
[⟬date#1⟭ 02:08:03,431] {calcul.py:46} INFO - dbg="checkpoint=3 tenants_done=565 timeout_s=900"
[⟬date#1⟭ 02:08:03,520] {sql.py:276} INFO - Running statement: SET statement_timeout = 900000, parameters: None
[⟬date#1⟭ 02:08:03,540] {sql.py:276} INFO - Running statement: INSERT INTO usage_mensuel SELECT * FROM tmp_usage, parameters: None
[⟬date#1⟭ 02:11:41,118] {sql.py:285} INFO - Rows affected: 565
[⟬date#1⟭ 02:11:41,204] {calcul.py:102} INFO - rapport écrit dans ⟬file_path#2⟭
[⟬date#1⟭ 02:11:41,205] {calcul.py:106} INFO - contact=⟬trap:indicator_non_pii|noreply-disabled⟭ notifications coupées
[⟬date#1⟭ 02:11:41,300] {python.py:201} INFO - Done. Returned value was: 565
[⟬date#1⟭ 02:11:41,320] {taskinstance.py:1149} INFO - Marking task as SUCCESS. dag_id=agregation_usage, task_id=calcul_mensuel, execution_id=scheduled_run_418
[⟬date#1⟭ 02:11:41,340] {local_task_job_runner.py:234} INFO - Task exited with return code 0
[⟬date#1⟭ 02:11:41,402] {taskinstance.py:3280} INFO - 2 downstream tasks scheduled from follow-on schedule check
[⟬date#1⟭ 02:11:45,118] {local_task_job_runner.py:120} INFO - ::group::Pre task execution logs
[⟬date#1⟭ 02:11:45,204] {taskinstance.py:2214} INFO - Executing <Task(PythonOperator): publication> on scheduled_run_418
[⟬date#1⟭ 02:11:45,311] {publication.py:33} INFO - publication vers ⟬url#1⟭
[⟬date#1⟭ 02:11:45,312] {publication.py:35} INFO - api_key=⟬trap:placeholder|REDACTED⟭ user="⟬trap:indicator_non_pii|svc-publication⟭"
[⟬date#1⟭ 02:11:47,640] {publication.py:58} INFO - 565 tableaux de bord rafraîchis, request_id=⟬uuid#1⟭
[⟬date#1⟭ 02:11:47,700] {python.py:201} INFO - Done. Returned value was: None
[⟬date#1⟭ 02:11:47,720] {taskinstance.py:1149} INFO - Marking task as SUCCESS. dag_id=agregation_usage, task_id=publication, execution_id=scheduled_run_418
[⟬date#1⟭ 02:11:50,118] {local_task_job_runner.py:120} INFO - ::group::Pre task execution logs
[⟬date#1⟭ 02:11:50,204] {taskinstance.py:2214} INFO - Executing <Task(PythonOperator): purge> on scheduled_run_418
[⟬date#1⟭ 02:11:50,311] {purge.py:21} INFO - purge des fichiers temporaires, rétention 7 jours
[⟬date#1⟭ 02:11:50,420] {purge.py:30} INFO - 76 fichiers supprimés, owner=⟬trap:indicator_non_pii|data-eng⟭
[⟬date#1⟭ 02:11:50,500] {python.py:201} INFO - Done. Returned value was: 76
[⟬date#1⟭ 02:11:50,520] {taskinstance.py:1149} INFO - Marking task as SUCCESS. dag_id=agregation_usage, task_id=purge, execution_id=scheduled_run_418
[⟬date#1⟭ 02:11:50,640] {dagrun.py:653} INFO - Marking run <DagRun agregation_usage @ scheduled_run_418: state=running> successful
[⟬date#1⟭ 02:11:50,641] {dagrun.py:704} INFO - DagRun Finished: dag_id=agregation_usage, run_id=scheduled_run_418, run_duration=707.5
[⟬date#1⟭ 02:11:50,700] {scheduler_job_runner.py:701} INFO - Stats: ok=3 retries=1 failed=0
[⟬date#1⟭ 02:11:50,720] {scheduler_job_runner.py:712} INFO - next run armed, cron="0 2 1 * *"
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Rust tracing line, erasure request, identity proof, anonymised customer, health number, licence number
scenario: nightly GDPR erasure job of a French parapharmacy shop, which logs each subject and the proof of identity before anonymising them
⟬text⟭
⟬date#1⟭ 02:10:03.118  INFO erasure::job: 2 demandes RGPD à traiter, user=⟬trap:indicator_non_pii|svc-rgpd⟭
⟬date#1⟭ 02:10:03.120  INFO erasure::job: demande ⟬ticket_id#1⟭ prise en charge
⟬date#1⟭ 02:10:03.121 DEBUG erasure::job: subject="⟬person_name#1⟭" email=⟬email#1⟭ phone="⟬phone#1⟭"
⟬date#1⟭ 02:10:03.122 DEBUG erasure::ident: pièce fournie : carte vitale, nir="⟬fr_social_security_number#1⟭"
⟬date#1⟭ 02:10:03.240  INFO erasure::orders: 12 commandes conservées pour obligation comptable, nom remplacé
⟬date#1⟭ 02:10:03.355  INFO erasure::prescriptions: 3 ordonnances supprimées pour customer=⟬person_name#1⟭
⟬date#1⟭ 02:10:03.470  INFO erasure::crm: contact retiré de la newsletter
⟬date#1⟭ 02:10:03.471  INFO erasure::job: client anonymisé, customer=⟬trap:indicator_non_pii|anonymized-41872⟭
⟬date#1⟭ 02:10:03.480  INFO erasure::job: demande ⟬ticket_id#2⟭ prise en charge
⟬date#1⟭ 02:10:03.481 DEBUG erasure::job: subject="⟬person_name#2⟭" email=⟬email#2⟭ phone="⟬phone#2⟭"
⟬date#1⟭ 02:10:03.482 DEBUG erasure::ident: proof of identity: driving licence, number="⟬uk_driving_licence#2⟭"
⟬date#1⟭ 02:10:03.590  WARN erasure::ident: holder mismatch, expected "⟬person_name#2⟭", got "⟬person_name:initial#2⟭"
⟬date#1⟭ 02:10:03.591  INFO erasure::job: accepté, initiale conforme au prénom
⟬date#1⟭ 02:10:03.700  INFO erasure::orders: 4 commandes conservées pour obligation comptable, nom remplacé
⟬date#1⟭ 02:10:03.812  INFO erasure::crm: contact retiré de la newsletter
⟬date#1⟭ 02:10:03.813  INFO erasure::job: client anonymisé, customer=⟬trap:indicator_non_pii|anonymized-41873⟭
⟬date#1⟭ 02:10:03.900  INFO erasure::mail: confirmation envoyée à ⟬email#2⟭
⟬date#1⟭ 02:10:03.950  INFO erasure::job: terminé, owner="⟬person_name#3⟭" dpo=⟬email:generic#4⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: plain log line, stand-in values, stand-in secret, field holding several values
scenario: five-minute health probe of a French shop's payment provider, whose debug line prints only stand-ins
⟬text⟭
⟬date#1⟭ 18:00:00 psp-probe INFO sonde ⟬url#1⟭
⟬date#1⟭ 18:00:00 psp-probe INFO 200 OK en 84 ms attrs="region=eu psp=primary"
⟬date#1⟭ 18:00:00 psp-probe DEBUG card=⟬trap:indicator_non_pii|<masked>⟭ secret=⟬trap:placeholder|xxxx⟭
⟬date#1⟭ 18:05:00 psp-probe INFO sonde ⟬url#1⟭
⟬date#1⟭ 18:05:01 psp-probe WARN 200 OK en 1402 ms, au-dessus du seuil de 800 ms
⟬date#1⟭ 18:05:01 psp-probe INFO astreinte non déclenchée, owner=⟬trap:indicator_non_pii|team-paiement⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: logistics
appearance: Logback line, HR onboarding, gendered title, quoted fields, split city and postcode, licence number, salary account
scenario: driver hiring service of a French haulier, which logs each new file with social security number, bank details and licence, including a British driver
⟬text⟭
⟬date#1⟭ 10:20:11.118 INFO  [io-executor-3] f.t.rh.EmbaucheService - dossier ⟬ticket_id#1⟭ ouvert pour "⟬person_name#1⟭", poste ⟬job_title#1⟭
⟬date#1⟭ 10:20:11.119 DEBUG [io-executor-3] f.t.rh.EmbaucheService - nir="⟬fr_social_security_number#1⟭" naissance="⟬birth_date#1⟭" tel="⟬phone#1⟭" entree="⟬date#3⟭"
⟬date#1⟭ 10:20:11.120 DEBUG [io-executor-3] f.t.rh.EmbaucheService - rib iban="⟬iban#1⟭" bic=⟬bic#1⟭
⟬date#1⟭ 10:20:11.121 DEBUG [io-executor-3] f.t.rh.EmbaucheService - domicile rue="⟬fr_postal_address:street#1⟭" ville=⟬city#1⟭ cp=⟬postcode#1⟭
⟬date#1⟭ 10:20:12.204 INFO  [io-executor-3] f.t.rh.Documents - FIMO valide, dernière visite médicale le ⟬date#2⟭
⟬date#1⟭ 10:20:12.640 INFO  [io-executor-3] f.t.rh.EmbaucheService - dossier ⟬ticket_id#1⟭ validé par manager="⟬person_name#2⟭"
⟬date#1⟭ 10:47:33.301 INFO  [io-executor-1] f.t.rh.EmbaucheService - dossier ⟬ticket_id#2⟭ ouvert pour Mme "⟬person_name#3f⟭", poste ⟬job_title#3⟭
⟬date#1⟭ 10:47:33.302 DEBUG [io-executor-1] f.t.rh.EmbaucheService - ⟬fr_social_security_number#3⟭ naissance="⟬birth_date#3⟭" tel="⟬phone#3⟭" entree="⟬date#2⟭"
⟬date#1⟭ 10:47:33.303 DEBUG [io-executor-1] f.t.rh.EmbaucheService - rib iban="⟬iban#3⟭" bic=⟬bic#3⟭
⟬date#1⟭ 10:47:34.118 WARN  [io-executor-1] f.t.rh.Documents - permis C manquant, dossier en attente
⟬date#1⟭ 11:12:05.640 INFO  [io-executor-2] f.t.rh.EmbaucheService - dossier ⟬ticket_id#3⟭ ouvert pour "⟬person_name#4⟭", agence Calais
⟬date#1⟭ 11:12:05.641 DEBUG [io-executor-2] f.t.rh.EmbaucheService - conducteur britannique, licence="⟬uk_driving_licence#4⟭" naissance="⟬birth_date#4⟭" delivree="⟬date#4⟭"
⟬date#1⟭ 11:12:05.642 DEBUG [io-executor-2] f.t.rh.EmbaucheService - rib iban="⟬iban#4⟭" adresse="⟬postal_address#4⟭"
⟬date#1⟭ 11:12:06.204 INFO  [io-executor-2] f.t.rh.Documents - équivalence demandée, operator=⟬trap:indicator_non_pii|rh-auto⟭
⟬date#1⟭ 11:12:06.210 INFO  [io-executor-2] f.t.rh.Notifications - convocation envoyée à ⟬email#4⟭
⟬date#1⟭ 11:30:00.002 INFO  [scheduled-1] f.t.rh.Stats - 3 dossiers ouverts, 1 validé, owner=⟬trap:indicator_non_pii|rh-exploitation⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: logistics
appearance: plain log line, bearer in a request line, pickup link token under an innocuous key, phone without announcer
scenario: parcel locker API of a French pickup network, whose debug level keeps the bearer token and the token of the pickup link sent by SMS
⟬text⟭
⟬date#2⟭ 12:40:03 locker-api INFO dépôt colis ⟬order_number#1⟭ casier 31 site ⟬city#1⟭
⟬date#2⟭ 12:40:03 locker-api DEBUG POST ⟬url#1⟭ Authorization: Bearer ⟬jwt#1⟭
⟬date#2⟭ 12:40:04 locker-api INFO SMS envoyé au ⟬phone#2⟭ pour "⟬person_name#2⟭"
⟬date#2⟭ 12:40:04 locker-api DEBUG jeton du lien de retrait value=⟬opaque_token#1⟭
⟬date#2⟭ 12:40:04 locker-api INFO casier 31 fermé, retrait possible jusqu'au ⟬date#1⟭ à 19:00
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: logistics
appearance: Odoo server log, cloud keys in fields, technical login, company in a field, word used as a place, address in a single value
scenario: Odoo server of a French pallet carrier at opening time, where an attachment module logs its storage keys and pickings are validated by staff and by a cron user
⟬text⟭
⟬date#1⟭ 07:00:03,118 2211 INFO logistique odoo.modules.loading: loading 141 modules...
⟬date#1⟭ 07:00:11,402 2211 INFO logistique odoo.modules.loading: Modules loaded.
⟬date#1⟭ 07:00:11,640 2211 INFO logistique odoo.modules.registry: Registry loaded in 8.522s
⟬date#1⟭ 07:00:11,702 2211 DEBUG logistique odoo.addons.stock_s3.attachment: s3 client access_key=⟬aws_access_key_id#1⟭ k=⟬aws_secret_access_key#1⟭ bucket=bl-archives
⟬date#1⟭ 07:00:12,118 2211 INFO logistique odoo.addons.base.models.ir_cron: Job `Relevés de transport` triggered
⟬date#1⟭ 07:02:40,204 2211 INFO logistique odoo.addons.base.models.res_users: Login successful for db:logistique login:⟬trap:indicator_non_pii|admin⟭ from ⟬ip_address#1⟭
⟬date#1⟭ 07:02:41,118 2211 INFO logistique werkzeug: ⟬ip_address#1⟭ - - "POST /web/dataset/call_kw/stock.picking/button_validate HTTP/1.1" 200 - 32 0.118 0.204
⟬date#1⟭ 07:02:41,204 2211 INFO logistique odoo.addons.stock.models.stock_picking: BL ⟬order_number#1⟭ validé user="⟬person_name#2⟭" client="⟬trap:company_name|Palettes ⦃Family⦄⟭"
⟬date#1⟭ 07:02:41,205 2211 INFO logistique odoo.addons.stock.models.stock_picking: quai ⟬trap:word_name|Rose⟭ libéré, 18 palettes
⟬date#1⟭ 07:02:41,206 2211 DEBUG logistique odoo.addons.stock.models.stock_picking: destination "⟬fr_postal_address#3⟭" contact "⟬person_name#3⟭" tel "⟬phone#3⟭"
⟬date#1⟭ 07:15:00,002 2211 INFO logistique odoo.addons.base.models.ir_cron: Job `Facturation palettes` triggered
⟬date#1⟭ 07:15:00,640 2211 INFO logistique odoo.addons.account.models.account_move: facture ⟬invoice_number#1⟭ postée user=⟬trap:indicator_non_pii|OdooBot⟭
⟬date#1⟭ 07:15:00,641 2211 INFO logistique odoo.addons.account.models.account_move: facture ⟬invoice_number#2⟭ postée user="⟬trap:indicator_non_pii|OdooBot⟭"
⟬date#1⟭ 07:15:01,204 2211 WARNING logistique odoo.addons.mail.models.mail_mail: échec d'envoi vers ⟬email#3⟭, relance dans 15 min
⟬date#1⟭ 07:15:01,300 2211 INFO logistique odoo.addons.base.models.ir_cron: Job `Facturation palettes` done
⟬date#1⟭ 07:20:12,118 2211 INFO logistique odoo.addons.stock_s3.attachment: BL ⟬order_number#1⟭ archivé dans ⟬url#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: banking
appearance: Spring warning, JWT library exception, Java frames, token alone on a line, JSON body after the frames
scenario: corporate treasury portal of a French bank rejecting a forged signature, whose filter prints the token and the transfer it was protecting
⟬text⟭
⟬date#1⟭ 17:05:33.118  WARN 6856 --- [nio-8443-exec-2] f.b.tresorerie.security.JwtFilter        : jeton rejeté pour "⟬person_name#1⟭" depuis ⟬ip_address#1⟭
io.jsonwebtoken.security.SignatureException: JWT signature does not match locally computed signature. JWT validity cannot be asserted and should not be trusted.
	at io.jsonwebtoken.impl.DefaultJwtParser.verifySignature(DefaultJwtParser.java:318)
	at io.jsonwebtoken.impl.DefaultJwtParser.parse(DefaultJwtParser.java:472)
	at io.jsonwebtoken.impl.DefaultJwtParser.parseSignedClaims(DefaultJwtParser.java:742)
	at fr.banque.tresorerie.security.JwtService.lire(JwtService.java:44)
	at fr.banque.tresorerie.security.JwtFilter.doFilterInternal(JwtFilter.java:61)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
	at org.springframework.security.web.ObservationFilterChainDecorator$FilterObservation.lambda$wrap$0(ObservationFilterChainDecorator.java:240)
	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:191)
	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:167)
	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1744)
	at java.base/java.lang.Thread.run(Thread.java:840)
Token reçu :
⟬jwt#1⟭
Requête en cours : POST /tresorerie/virements
{"beneficiaire":"⟬person_name#2⟭","iban":"⟬iban#2⟭","montant":125000,"reference":"⟬order_number#1⟭"}
⟬date#1⟭ 17:05:33.124  INFO 6856 --- [nio-8443-exec-2] f.b.tresorerie.audit.AuditTrail          : tentative enregistrée, operator=⟬trap:indicator_non_pii|portail-tresorerie⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Rust anyhow error, cause chain, connection string in a cause, Rust frames
scenario: Rust worker of a French planning product failing at boot on Redis, whose anyhow context quotes the connection URL
⟬text⟭
Error: impossible de joindre le cache

Caused by:
    0: redis://:⟬url_password#1⟭@⟬hostname#1⟭:6379/0
    1: Connection refused (os error 111)

Stack backtrace:
   0: anyhow::error::<impl core::convert::From<E> for anyhow::Error>::from
             at /usr/local/cargo/registry/src/index.crates.io/anyhow-1.0.81/src/error.rs:565:25
   1: planning_worker::cache::connect
             at ./src/cache.rs:86:9
   2: planning_worker::main
             at ./src/main.rs:27:5
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: SaaS
appearance: AxiosError dump, nested config object, Authorization header, response object, private key alone on lines, JWT in a log line, secret under an innocuous header
scenario: code review bot of a French developer tools SaaS, whose unhandled AxiosError prints the whole request to GitHub, followed by the application key it reloads and the signed token
⟬text⟭
[revue-bot] commentaire de PR impossible, nouvelle tentative
AxiosError: Request failed with status code 401
    at settle (/app/node_modules/axios/dist/node/axios.cjs:1873:12)
    at IncomingMessage.handleStreamEnd (/app/node_modules/axios/dist/node/axios.cjs:3065:11)
    at IncomingMessage.emit (node:events:531:35)
    at endReadableNT (node:internal/streams/readable:1696:12)
    at process.processTicksAndRejections (node:internal/process/task_queues:82:21) {
  code: 'ERR_BAD_REQUEST',
  config: {
    transitional: {
      silentJSONParsing: true,
      forcedJSONParsing: true,
      clarifyTimeoutError: false
    },
    adapter: [ 'xhr', 'http', 'fetch' ],
    transformRequest: [ [Function: transformRequest] ],
    transformResponse: [ [Function: transformResponse] ],
    timeout: 8000,
    xsrfCookieName: 'XSRF-TOKEN',
    xsrfHeaderName: 'X-XSRF-TOKEN',
    maxContentLength: -1,
    maxBodyLength: -1,
    headers: Object [AxiosHeaders] {
      Accept: 'application/vnd.github+json',
      'Content-Type': 'application/json',
      Authorization: 'Bearer ⟬github_token#1⟭',
      'User-Agent': 'revue-bot',
      'X-Client-Ref': '⟬opaque_token#1⟭',
      'Accept-Encoding': 'gzip, compress, deflate, br'
    },
    url: 'https://api.github.com/repos/gestion-code/portail/pulls/703/comments',
    method: 'post',
    data: `{"body":"Merci de revoir ce point avec ⟬person_name:given#2⟭"}`
  },
  request: <ref *1> ClientRequest {
    _header: 'POST /repos/gestion-code/portail/pulls/703/comments HTTP/1.1\r\n',
    method: 'POST',
    path: '/repos/gestion-code/portail/pulls/703/comments',
    host: 'api.github.com',
    protocol: 'https:'
  },
  response: {
    status: 401,
    statusText: 'Unauthorized',
    headers: Object [AxiosHeaders] {
      server: 'GitHub.com',
      'x-github-request-id': '⟬uuid#1⟭',
      'x-ratelimit-remaining': '4999'
    },
    data: {
      message: 'Bad credentials',
      status: '401'
    }
  },
  status: 401
}
[revue-bot] rechargement de la clé d'application depuis ⟬file_path#1⟭
⟬private_key#1⟭
[revue-bot] jeton d'installation signé : ⟬jwt#1⟭
[revue-bot] installation ⟬customer_id#1⟭, owner="⟬person_name#2⟭" mail=⟬email#2⟭
[revue-bot] seconde tentative OK, request_id=⟬uuid#2⟭
[revue-bot] user=⟬trap:indicator_non_pii|revue-bot[bot]⟭ repo=gestion-code/portail pr=703
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Python traceback, payment client exception, JSON payload line, API key assignment
scenario: seller import of a French marketplace rejected by its payment provider, where the handler prints the account payload and the module's key
⟬text⟭
Traceback (most recent call last):
  File "/app/imports/vendeurs.py", line 58, in importer
    compte = stripe.Account.create(**payload)
  File "/app/.venv/lib/python3.11/site-packages/stripe/api_resources/abstract/createable_api_resource.py", line 22, in create
    return cls._static_request("post", cls.class_url(), params=params)
stripe.error.InvalidRequestError: Request ⟬uuid#1⟭: Invalid tax identifier
payload = {"individual": {"first_name": "⟬person_name:given#2⟭", "last_name": "⟬person_name:family#2⟭", "id_number": "⟬us_itin#2⟭"}, "country": "US"}
stripe.api_key = "⟬stripe_secret_key#1⟭"
vendeur ⟬customer_id#2⟭ ignoré, import poursuivi
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Scrapy error, Twisted frames, eponyms, shop names, product with a given name, ctx field
scenario: price monitoring spider of a French shoe shop crashing on a missing selector, comparing product names with string distances and no personal value
⟬text⟭
⟬date#1⟭ 03:10:11 [scrapy.core.engine] INFO: Spider opened, owner=⟬trap:indicator_non_pii|pricing-team⟭
⟬date#1⟭ 03:10:42 [concurrents] DEBUG: rapprochement "bottine ⟬trap:word_name|Margot⟭ cuir" chez ⟬trap:company_name|Chaussures ⦃Family⦄⟭, distance ⟬trap:eponym|Levenshtein⟭ = 3
⟬date#1⟭ 03:10:42 [concurrents] DEBUG: rapprochement "derby ⟬trap:word_name|Victor⟭ marine" chez ⟬trap:company_name|Chaussures ⦃Family⦄⟭, indice ⟬trap:eponym|Jaccard⟭ = 0.71
⟬date#1⟭ 03:10:43 [scrapy.core.scraper] ERROR: Spider error processing GET ⟬url#1⟭ (referer: None)
Traceback (most recent call last):
  File "/srv/prix/.venv/lib/python3.11/site-packages/twisted/internet/defer.py", line 1078, in _runCallbacks
    current.result = callback(current.result, *args, **kwargs)
  File "/srv/prix/.venv/lib/python3.11/site-packages/scrapy/utils/defer.py", line 240, in iter_errback
    yield next(it)
  File "/srv/prix/.venv/lib/python3.11/site-packages/scrapy/spidermiddlewares/depth.py", line 35, in process_spider_output
    yield from self._filter(request, response, spider)
  File "/srv/prix/spiders/concurrents.py", line 88, in parse_fiche
    prix = float(response.css("span.prix::text").get().replace(",", "."))
AttributeError: 'NoneType' object has no attribute 'replace'
⟬date#1⟭ 03:10:43 [concurrents] WARNING: fiche ignorée ctx="page=21 retry=0 selector=span.prix"
⟬date#1⟭ 03:12:00 [scrapy.extensions.logstats] INFO: Crawled 586 pages (at 206 pages/min), scraped 388 items
⟬date#1⟭ 03:14:02 [scrapy.statscollectors] INFO: Dumping Scrapy stats: downloader/response_count=586 spider_exceptions/AttributeError=1
⟬date#1⟭ 03:14:02 [scrapy.core.engine] INFO: Spider closed (finished)
⟬date#1⟭ 03:14:03 [concurrents] INFO: rapport déposé dans ⟬file_path#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: logistics
appearance: Python log line, chained KeyError, pandas frames, JSON rows, tax identifier, licence number
scenario: partner carrier import of a Franco-American freight broker, stopped by a missing column in a spreadsheet, whose handler prints the first rows as JSON
⟬text⟭
⟬date#1⟭ 06:30:02 INFO import_partenaires: lecture ⟬file_path#1⟭
⟬date#1⟭ 06:30:03 INFO import_partenaires: 2 lignes, colonnes attendues : nom, pays, driver_licence, tax_id
⟬date#1⟭ 06:30:03 ERROR import_partenaires: colonne absente, import abandonné
Traceback (most recent call last):
  File "/opt/import/.venv/lib/python3.11/site-packages/pandas/core/indexes/base.py", line 3805, in get_loc
    return self._engine.get_loc(casted_key)
  File "index.pyx", line 167, in pandas._libs.index.IndexEngine.get_loc
KeyError: 'driver_licence'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/opt/import/partenaires.py", line 44, in main
    permis = feuille["driver_licence"].astype(str)
  File "/opt/import/.venv/lib/python3.11/site-packages/pandas/core/frame.py", line 4090, in __getitem__
    indexer = self.columns.get_loc(key)
  File "/opt/import/.venv/lib/python3.11/site-packages/pandas/core/indexes/base.py", line 3812, in get_loc
    raise KeyError(key) from err
KeyError: 'driver_licence'
⟬date#1⟭ 06:30:03 DEBUG import_partenaires: premières lignes du fichier :
{"nom": "⟬person_name#2⟭", "pays": "⟬country#2⟭", "tax_id": "⟬us_itin#2⟭"}
{"nom": "⟬person_name#3⟭", "pays": "⟬country#3⟭", "licence": "⟬uk_driving_licence#3⟭"}
⟬date#1⟭ 06:30:03 INFO import_partenaires: incident ⟬ticket_id#1⟭, owner=⟬trap:indicator_non_pii|achats-transport⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: logistics
appearance: Flutter logcat, Dart frames, field holding several values
scenario: scanning tablet of a French warehouse failing on an unreadable label, with a Dart exception and an automatic operator
⟬text⟭
E/flutter ( 9108): [ERROR:flutter/runtime/dart_vm_initializer.cc(79)] Unhandled Exception: FormatException: Invalid radix-10 number (at character 1)
E/flutter ( 9108): code_colis_inconnu
E/flutter ( 9108): ^
E/flutter ( 9108):
E/flutter ( 9108): #0      int._throwFormatException (dart:core-patch/integers_patch.dart:131:5)
E/flutter ( 9108): #1      int.parse (dart:core-patch/integers_patch.dart:53:14)
E/flutter ( 9108): #2      ScanService.lire (package:quai_scan/scan/scan_service.dart:79:17)
E/flutter ( 9108): #3      _QuaiPageState._onScan (package:quai_scan/quai/quai_page.dart:88:32)
I/flutter ( 9108): dbg="quai=12 tentative=2 operateur=⟬trap:indicator_non_pii|AUTO⟭"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: banking
appearance: AWS CodeBuild log, phase lines, token in a clone URL, exported JDBC URL, Maven output, Spring test log, fixture names and accounts, payment key
scenario: AWS CodeBuild verification of a French payment initiation fintech, whose build exports its credentials and whose failed integration test logs the fixture transfer
⟬text⟭
[Container] ⟬date#1⟭ 10:02:03.118 Running on CodeBuild On-demand
[Container] ⟬date#1⟭ 10:02:03.120 Waiting for agent ping
[Container] ⟬date#1⟭ 10:02:05.204 Waiting for DOWNLOAD_SOURCE
[Container] ⟬date#1⟭ 10:02:07.310 Phase is DOWNLOAD_SOURCE
[Container] ⟬date#1⟭ 10:02:07.311 CODEBUILD_SRC_DIR=/codebuild/output/src418/src
[Container] ⟬date#1⟭ 10:02:07.402 YAML location is /codebuild/output/src418/src/buildspec.yml
[Container] ⟬date#1⟭ 10:02:07.500 Processing environment variables
[Container] ⟬date#1⟭ 10:02:07.612 Moving to directory /codebuild/output/src418/src
[Container] ⟬date#1⟭ 10:02:07.700 Phase complete: DOWNLOAD_SOURCE State: SUCCEEDED
[Container] ⟬date#1⟭ 10:02:07.702 Phase context status code:  Message:
[Container] ⟬date#1⟭ 10:02:07.810 Entering phase INSTALL
[Container] ⟬date#1⟭ 10:02:07.900 Running command git clone https://⟬github_token#1⟭@github.com/pay-initiation/contrats-api.git vendor/contrats
Cloning into 'vendor/contrats'...
[Container] ⟬date#1⟭ 10:02:11.118 Phase complete: INSTALL State: SUCCEEDED
[Container] ⟬date#1⟭ 10:02:11.120 Entering phase PRE_BUILD
[Container] ⟬date#1⟭ 10:02:11.204 Running command export SPRING_DATASOURCE_URL="jdbc:postgresql://⟬hostname#1⟭:5432/pisp?user=⟬trap:indicator_non_pii|pisp_ci⟭&password=⟬url_password#1⟭"
[Container] ⟬date#1⟭ 10:02:11.205 Running command export PSP_API_KEY=⟬stripe_secret_key#1⟭
[Container] ⟬date#1⟭ 10:02:11.206 Running command echo "tests d'intégration sur la base partagée"
tests d'intégration sur la base partagée
[Container] ⟬date#1⟭ 10:02:11.300 Phase complete: PRE_BUILD State: SUCCEEDED
[Container] ⟬date#1⟭ 10:02:11.302 Entering phase BUILD
[Container] ⟬date#1⟭ 10:02:11.401 Running command ./mvnw -B verify
[INFO] Scanning for projects...
[INFO] Building pisp-api ⟬version#1⟭
[INFO] --- resources:3.3.1:resources (default-resources) @ pisp-api ---
[INFO] Copying 12 resources from src/main/resources to target/classes
[INFO] --- compiler:3.13.0:compile (default-compile) @ pisp-api ---
[INFO] Compiling 214 source files to /codebuild/output/src418/src/target/classes
[INFO] --- surefire:3.2.5:test (default-test) @ pisp-api ---
[INFO] Running fr.pisp.compte.ConsentementTest
[INFO] Tests run: 12, Failures: 0, Errors: 0, Skipped: 0 -- in fr.pisp.compte.ConsentementTest
[INFO] Running fr.pisp.virement.CutOffTest
[INFO] Tests run: 28, Failures: 0, Errors: 0, Skipped: 0 -- in fr.pisp.virement.CutOffTest
[INFO] Running fr.pisp.virement.InitiationTest
⟬date#1⟭ 10:03:41.118  INFO 934 --- [main] f.p.virement.InitiationTest              : Starting InitiationTest using Java 21
⟬date#1⟭ 10:03:43.204  INFO 934 --- [main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port 8081 (http)
⟬date#1⟭ 10:03:44.118 DEBUG 934 --- [main] f.p.virement.fixtures.Jeux               : debtor="⟬person_name#2⟭" iban="⟬iban#2⟭"
⟬date#1⟭ 10:03:44.119 DEBUG 934 --- [main] f.p.virement.fixtures.Jeux               : creditor="⟬person_name#3⟭" iban="⟬iban#3⟭"
⟬date#1⟭ 10:03:45.402  INFO 934 --- [main] f.p.virement.InitiationService           : initiation ⟬uuid#1⟭ acceptée, montant=-10.00
⟬date#1⟭ 10:03:45.420 ERROR 934 --- [main] f.p.virement.InitiationTest              : montant négatif accepté pour ⟬person_name#2⟭
[ERROR] Tests run: 17, Failures: 1, Errors: 0, Skipped: 0
[ERROR] Failures:
[ERROR]   InitiationTest.refuseMontantNegatif:88 expected: <REJETE> but was: <ACCEPTE>
[INFO] --- surefire-report:3.2.5:report (default) @ pisp-api ---
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:58 min
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-surefire-plugin:3.2.5:test (default-test) on project pisp-api: There are test failures.
[Container] ⟬date#1⟭ 10:04:09.118 Command did not exit successfully ./mvnw -B verify exit status 1
[Container] ⟬date#1⟭ 10:04:09.120 Phase complete: BUILD State: FAILED
[Container] ⟬date#1⟭ 10:04:09.121 Phase context status code: COMMAND_EXECUTION_ERROR Message: Error while executing command: ./mvnw -B verify. Reason: exit status 1
[Container] ⟬date#1⟭ 10:04:09.204 Entering phase POST_BUILD
[Container] ⟬date#1⟭ 10:04:09.300 Running command aws s3 cp target/surefire-reports s3://pisp-rapports --recursive
upload: target/surefire-reports/TEST-InitiationTest.xml to s3://pisp-rapports/TEST-InitiationTest.xml
[Container] ⟬date#1⟭ 10:04:11.118 Running command curl -s -X POST ⟬url#1⟭ -d "build=KO"
[Container] ⟬date#1⟭ 10:04:11.640 Running command echo "prévenir ⟬person_name:given#4⟭ avant de relancer"
prévenir ⟬person_name:given#4⟭ avant de relancer
[Container] ⟬date#1⟭ 10:04:11.700 Phase complete: POST_BUILD State: SUCCEEDED
[Container] ⟬date#1⟭ 10:04:11.702 Phase context status code:  Message:
[Container] ⟬date#1⟭ 10:04:11.800 Set report auto-discover timeout to 5 seconds
[Container] ⟬date#1⟭ 10:04:11.900 Preparing to upload artifacts
[Container] ⟬date#1⟭ 10:04:12.118 Phase complete: UPLOAD_ARTIFACTS State: SUCCEEDED
[Container] ⟬date#1⟭ 10:04:12.119 Build finished, initiator=⟬person_name:handle#4⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: banking
appearance: Trivy report, secret findings, code excerpt, access keys in an excerpt, private key in an excerpt
scenario: image scan of a French bank's statement service, where Trivy quotes the lines of an old environment file and a key file left in the image
⟬text⟭
$ trivy image --scanners vuln,secret ⟬hostname#1⟭:5000/releves/api:main
⟬date#1⟭ 11:20:03 INFO Vulnerability scanning is enabled
⟬date#1⟭ 11:20:03 INFO Secret scanning is enabled
⟬date#1⟭ 11:20:41 INFO Detected OS: alpine
⟬date#1⟭ 11:20:41 INFO Number of language-specific files: 1

app/config/old.env (secrets)
Total: 2 (HIGH: 0, CRITICAL: 2)

CRITICAL: AWS (aws-access-key-id)
════════════════════════════════════════
AWS Access Key ID
────────────────────────────────────────
 app/config/old.env:3
────────────────────────────────────────
   2 | # clé du bucket de relevés, à retirer
   3 [ AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
   4 | AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
────────────────────────────────────────

app/certs/releves.key (secrets)
Total: 1 (HIGH: 1, CRITICAL: 0)

HIGH: AsymmetricPrivateKey (private-key)
════════════════════════════════════════
Asymmetric Private Key
────────────────────────────────────────
⟬private_key#1⟭
────────────────────────────────────────
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: banking
appearance: shell trace, CLI password argument, token table, accessor identifier, connection string alone on a line
scenario: pipeline step of a French payment API logging in to Vault, whose trace shows the CLI password, the returned token and the database URL it reads
⟬text⟭
+ vault login -method=userpass username=⟬trap:indicator_non_pii|ci-paiement⟭ password=⟬password#1⟭
Success! You are now authenticated.
Key                    Value
---                    -----
token                  ⟬opaque_token#1⟭
token_accessor         ⟬hash#1⟭
token_duration         768h
token_policies         ["ci-paiement" "default"]
+ vault kv get -field=url secret/paiement/db
postgresql://paiement:⟬url_password#1⟭@⟬hostname#1⟭:5432/paiement
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: GitHub Actions step, hub token in a CLI flag, token in a clone URL, private key alone on lines, docker push output
scenario: image build of a French document search SaaS, which downloads a model with a Hugging Face token and prints the key used to reach the GPU builder
⟬text⟭
Run ./ci/build_image.sh
  ./ci/build_image.sh
  shell: /usr/bin/bash -e {0}
  env:
    REGISTRY: ⟬hostname#1⟭:5000
    GITHUB_ACTOR: ⟬person_name:handle#2⟭
+ git clone https://oauth2:⟬github_token#1⟭@github.com/recherche-doc/embeddings.git /tmp/embeddings
Cloning into '/tmp/embeddings'...
+ huggingface-cli login --token ⟬huggingface_token#1⟭
Login successful
+ huggingface-cli download modele-resume-fr --local-dir /tmp/modele
Fetching 8 files: 100%|██████████| 8/8 [00:41<00:00,  5.20s/it]
+ cat /tmp/gpu_builder_key
⟬private_key#1⟭
+ ssh -i /tmp/gpu_builder_key ⟬trap:email_lookalike|build@gpu-01⟭ 'docker build -t recherche:main /tmp/embeddings'
Successfully built ⟬git_sha#1⟭
Successfully tagged recherche:main
+ docker push ⟬hostname#1⟭:5000/recherche:main
main: digest: ⟬hash#1⟭ size: 2841
+ echo "image prête pour ⟬person_name:given#2⟭"
image prête pour ⟬person_name:given#2⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Renovate log, dependency updates, library names, scoped packages, masked token, field holding several values
scenario: Renovate run on a French SaaS monorepo, updating logging and test packages under a bot author, with a masked token
⟬text⟭
INFO: Repository started (repository=plateforme/monorepo)
INFO: Dependency extraction complete (repository=plateforme/monorepo)
DEBUG: dbg="branches=4 prs_open=2 baseBranch=main"
DEBUG: GITHUB_TOKEN=⟬trap:placeholder|***⟭ gitAuthor=⟬trap:indicator_non_pii|renovate[bot]⟭
INFO: PR created (branch=renovate/logging)
  ⟬trap:library|winston⟭ ⟬version#1⟭ -> ⟬version#2⟭
  ⟬trap:library|morgan⟭ ⟬version#3⟭ -> ⟬version#4⟭
INFO: PR created (branch=renovate/types)
  ⟬trap:email_lookalike|@types/node⟭ ⟬version#5⟭ -> ⟬version#6⟭
  ⟬trap:email_lookalike|@types/express⟭ ⟬version#7⟭ -> ⟬version#8⟭
INFO: Branch updated (branch=renovate/tests)
  ⟬trap:library|jasmine-core⟭ ⟬version#9⟭ -> ⟬version#10⟭
INFO: Automerge skipped (branch=renovate/logging, reason=checks pending)
DEBUG: reviewers=⟬trap:indicator_non_pii|team-plateforme⟭ assignees=⟬trap:indicator_non_pii|team-plateforme⟭
INFO: Branch deleted (branch=renovate/old-node)
INFO: Repository finished (durationMs=40490, cloned=true)
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: GitLab job, composer credentials, JSON block, Magento CLI, password in a CLI flag, payment key in a CLI argument, access keys, S3 sync, progress lines
scenario: GitLab deployment of a French Magento shop, whose script cats its auth.json and passes the database password, the payment key and the storage keys as command arguments
⟬text⟭
Running with gitlab-runner ⟬version#1⟭ (⟬git_sha#1⟭)
  on ⟬hostname#1⟭ deploy-01
Preparing the "shell" executor
Getting source from Git repository
Checking out ⟬git_sha#2⟭ as detached HEAD (ref is main)...
Executing "step_script" stage of the job script
$ composer config -g http-basic.repo.magento.com ⟬hash#1⟭ ⟬opaque_token#1⟭
$ cat auth.json
{
    "github-oauth": {
        "github.com": "⟬github_token#1⟭"
    }
}
$ composer install --no-dev --no-interaction
Installing dependencies from lock file
Package operations: 623 installs, 0 updates, 0 removals
Generating optimized autoload files
$ bin/magento setup:config:set --db-host=⟬hostname#2⟭ --db-name=boutique --db-user="⟬trap:indicator_non_pii|magento⟭" --db-password=⟬password#1⟭
We saved the deployment configuration.
$ bin/magento config:set payment/psp/secret_key ⟬stripe_secret_key#1⟭
Value was saved.
$ bin/magento config:set general/store_information/name "⟬company#3⟭"
Value was saved.
$ bin/magento config:set trans_email/ident_support/email ⟬email:generic#4⟭
Value was saved.
$ bin/magento config:set trans_email/ident_support/name "⟬person_name#5⟭"
Value was saved.
$ bin/magento setup:upgrade --keep-generated
Cache cleared successfully
File system cleanup:
/builds/boutique/generated/code/Magento
Updating modules:
Schema creation/updates:
Module 'Magento_Store':
Module 'Magento_Catalog':
Module 'Boutique_Livraison':
Module 'Boutique_Fidelite':
Schema post-updates:
Data install/update:
Post data updates:
Nothing to import.
$ bin/magento setup:di:compile
Compilation was started.
Repositories code generation... 1/9 [===>------------------------]  11%
Proxies code generation... 5/9 [===============>------------]  55%
Interception cache generation... 9/9 [============================] 100%
Generated code and dependency injection configuration successfully.
$ bin/magento setup:static-content:deploy fr_FR en_GB -f
Deploy using quick strategy
frontend/Magento/luma/fr_FR        2412/2412 ============================ 100%
frontend/Magento/luma/en_GB        2412/2412 ============================ 100%
Execution time: 41.2 seconds
$ export AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
$ export AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
$ aws s3 sync pub/media s3://boutique-medias --only-show-errors
$ bin/magento cache:flush
Flushed cache types:
config
full_page
$ bin/magento maintenance:disable
Disabled maintenance mode
$ echo "boutique en ligne, déployée par ⟬username#1⟭"
boutique en ligne, déployée par ⟬username#1⟭
Job succeeded
⟬end⟭
