⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: banking
appearance: winston line, health questionnaire step, quoted field, bearer token in a field, customer on both sides, name without announcer
scenario: loan insurance subscription of a French bank, whose Node service logs each applicant with social security number and account while the medical step calls a partner
⟬text⟭
⟬date#1⟭ 09:40:12 [assurance-emprunteur] info: souscription ⟬uuid#1⟭ ouverte customer=⟬person_name#1⟭
⟬date#1⟭ 09:40:12 [assurance-emprunteur] debug: dbg="nir=⟬fr_social_security_number#1⟭ naissance=⟬birth_date#1⟭ pret=⟬order_number#1⟭ signature=⟬date#2⟭"
⟬date#1⟭ 09:40:13 [assurance-emprunteur] info: prélèvement prévu sur iban="⟬iban#1⟭"
⟬date#1⟭ 09:40:13 [assurance-emprunteur] debug: appel partenaire santé ⟬url#1⟭
⟬date#1⟭ 09:40:13 [assurance-emprunteur] debug: attrs="authorization=Bearer ⟬jwt#1⟭ timeout_ms=8000"
⟬date#1⟭ 09:40:15 [assurance-emprunteur] info: questionnaire médical envoyé à ⟬email#1⟭
⟬date#1⟭ 10:12:41 [assurance-emprunteur] info: questionnaire reçu, décision=ACCEPT_SURPRIME taux=0.42
⟬date#1⟭ 10:12:42 [assurance-emprunteur] info: conseiller ⟬person_name#2m⟭ notifié
⟬date#1⟭ 10:12:42 [assurance-emprunteur] info: owner=⟬person_name#2⟭ agence=⟬city#2⟭
⟬date#1⟭ 10:31:08 [assurance-emprunteur] info: souscription ⟬uuid#2⟭ ouverte customer=⟬trap:indicator_non_pii|recette-assurance⟭
⟬date#1⟭ 10:31:08 [assurance-emprunteur] debug: jeu de données de contrôle, aucun appel partenaire
⟬date#1⟭ 10:44:19 [assurance-emprunteur] info: souscription ⟬uuid#3⟭ ouverte customer="Mme ⟬person_name#3f⟭"
⟬date#1⟭ 10:44:19 [assurance-emprunteur] debug: dbg="⟬fr_social_security_number#3⟭ naissance=⟬birth_date#3⟭ pret=⟬order_number#3⟭ signature=⟬date#3⟭"
⟬date#1⟭ 10:44:20 [assurance-emprunteur] warn: co-emprunteur absent du dossier, relance de ⟬person_name#3⟭ au ⟬phone#3⟭
⟬date#1⟭ 10:44:21 [assurance-emprunteur] info: prélèvement prévu sur iban="⟬iban#3⟭"
⟬date#1⟭ 11:00:00 [assurance-emprunteur] info: 3 souscriptions ouvertes, operator=⟬trap:indicator_non_pii|cron-souscriptions⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: plain log line, tax identifier in a quoted field, contractor records, owner as a person
scenario: year-end contractor forms export of a French accounting SaaS with American clients, whose debug level lists each contractor
⟬text⟭
⟬date#1⟭ 23:00:02 exports.forms INFO génération des formulaires 1099 pour le client ⟬customer_id#1⟭
⟬date#1⟭ 23:00:03 exports.forms DEBUG contractor="⟬person_name#2⟭" tin="⟬us_itin#2⟭" total=18400.00
⟬date#1⟭ 23:00:03 exports.forms DEBUG contractor="⟬person_name#3⟭" ⟬us_itin#3⟭ total=6250.00
⟬date#1⟭ 23:00:03 exports.forms DEBUG contractor="⟬company#4⟭" tin=missing total=950.00
⟬date#1⟭ 23:00:04 exports.forms WARN 1 formulaire incomplet, owner="⟬person_name#5m⟭" prévenu
⟬date#1⟭ 23:00:04 exports.forms INFO archive écrite dans ⟬file_path#1⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: logistics
appearance: NLog line, pipe separated fields, reservation records, fine designation, licence numbers, plates, bearer header, operator on both sides, payroll sync
scenario: van fleet service of a French courier group across a working day, from reservations and licence checks to a speeding fine and the payroll sync of deductions
⟬text⟭
⟬date#1⟭ 07:30:02.1184|INFO|Flotte.Api.Startup|Now listening on: ⟬url#1⟭
⟬date#1⟭ 07:30:02.1190|INFO|Flotte.Api.Startup|Hosting environment: Production
⟬date#1⟭ 07:30:02.1192|INFO|Flotte.Api.Startup|Content root path: /app
⟬date#1⟭ 07:30:02.4021|INFO|Flotte.Data.Migrations|base prête sur ⟬hostname#1⟭, 0 migration en attente
⟬date#1⟭ 07:42:11.2044|INFO|Flotte.Api.Reservations|POST /api/reservations 201 user="⟬person_name#1⟭"
⟬date#1⟭ 07:42:11.2047|DEBUG|Flotte.Api.Auth|Authorization: Bearer ⟬jwt#1⟭
⟬date#1⟭ 07:42:11.3101|INFO|Flotte.Domain.Reservation|véhicule "⟬fr_license_plate#1⟭" réservé, agence ⟬city#1⟭
⟬date#1⟭ 07:42:11.3102|DEBUG|Flotte.Domain.Licence|permis français "⟬fr_driving_licence#1⟭" valide, conducteur "⟬person_name#1m⟭"
⟬date#1⟭ 07:48:37.6401|INFO|Flotte.Api.Reservations|POST /api/reservations 201 user=⟬person_name#2⟭
⟬date#1⟭ 07:48:37.6403|DEBUG|Flotte.Api.Auth|Authorization: Bearer ⟬jwt#2⟭
⟬date#1⟭ 07:48:37.7110|INFO|Flotte.Domain.Reservation|véhicule "⟬uk_license_plate#2⟭" réservé, agence ⟬city#2⟭
⟬date#1⟭ 07:48:37.7112|DEBUG|Flotte.Domain.Licence|British licence "⟬uk_driving_licence#2⟭" holder "⟬person_name#2⟭"
⟬date#1⟭ 07:48:37.7120|WARN|Flotte.Domain.Licence|contrôle DVLA requis avant remise des clés
⟬date#1⟭ 07:55:02.1180|INFO|Flotte.Integrations.Dvla|appel ⟬url#2⟭
⟬date#1⟭ 07:55:02.1182|DEBUG|Flotte.Integrations.Dvla|X-Client-Ref: ⟬opaque_token#1⟭
⟬date#1⟭ 07:55:03.2040|INFO|Flotte.Integrations.Dvla|licence "⟬uk_driving_licence#2⟭" valid, points=3
⟬date#1⟭ 08:02:44.5021|INFO|Flotte.Api.Reservations|POST /api/reservations 201 user="⟬trap:indicator_non_pii|tournees-auto⟭"
⟬date#1⟭ 08:02:44.5102|INFO|Flotte.Domain.Reservation|véhicule "⟬fr_license_plate#3⟭" réservé par le planificateur
⟬date#1⟭ 08:15:00.0012|INFO|Flotte.Jobs.Telemetrie|218 positions reçues
⟬date#1⟭ 08:30:00.0011|INFO|Flotte.Jobs.Telemetrie|224 positions reçues
⟬date#1⟭ 08:41:19.3180|INFO|Flotte.Domain.Remise|clés remises à "⟬person_name#1⟭", kilométrage 51748
⟬date#1⟭ 08:47:51.6402|INFO|Flotte.Domain.Remise|clés remises à "⟬person_name#2⟭", kilométrage 88120
⟬date#1⟭ 09:00:00.0014|INFO|Flotte.Jobs.Telemetrie|231 positions reçues
⟬date#1⟭ 09:12:33.1183|WARN|Flotte.Domain.Sinistre|choc signalé sur "⟬fr_license_plate#3⟭" par le boîtier embarqué
⟬date#1⟭ 09:12:33.1185|INFO|Flotte.Domain.Sinistre|dossier ⟬ticket_id#1⟭ ouvert, operator="⟬person_name#4⟭"
⟬date#1⟭ 09:20:47.4018|INFO|Flotte.Domain.Sinistre|conducteur joint au ⟬phone#5⟭, aucun blessé
⟬date#1⟭ 09:20:47.4021|INFO|Flotte.Domain.Sinistre|tiers déclaré "⟬person_name#6⟭", véhicule "⟬us_license_plate#6⟭"
⟬date#1⟭ 09:30:00.0012|INFO|Flotte.Jobs.Telemetrie|229 positions reçues
⟬date#1⟭ 10:02:18.6401|INFO|Flotte.Domain.Amendes|avis ⟬order_number#1⟭ reçu pour "⟬fr_license_plate#1⟭", vitesse 62 pour 50
⟬date#1⟭ 10:02:18.6410|INFO|Flotte.Domain.Amendes|conducteur retrouvé : ⟬person_name#1⟭
⟬date#1⟭ 10:02:18.6412|DEBUG|Flotte.Domain.Amendes|désignation permis "⟬fr_driving_licence#1⟭" adresse "⟬fr_postal_address#1⟭"
⟬date#1⟭ 10:02:19.1180|INFO|Flotte.Domain.Amendes|désignation transmise, operator=⟬trap:indicator_non_pii|antai-bridge⟭
⟬date#1⟭ 10:15:00.0013|INFO|Flotte.Jobs.Telemetrie|233 positions reçues
⟬date#1⟭ 10:30:00.0012|INFO|Flotte.Jobs.Telemetrie|230 positions reçues
⟬date#1⟭ 11:00:00.0011|INFO|Flotte.Jobs.Entretien|2 véhicules à réviser, owner="⟬person_name#4⟭"
⟬date#1⟭ 11:00:00.0120|DEBUG|Flotte.Jobs.Entretien|garage ⟬trap:company_name|Garage ⦃Family⦄⟭ à ⟬city#7⟭, ctx="delai=48h"
⟬date#1⟭ 11:18:02.5040|INFO|Flotte.Api.Reservations|DELETE /api/reservations/496 204 user=⟬trap:indicator_non_pii|tournees-auto⟭
⟬date#1⟭ 11:30:00.0013|INFO|Flotte.Jobs.Telemetrie|226 positions reçues
⟬date#1⟭ 12:00:00.0012|INFO|Flotte.Jobs.Paie|synchronisation des retenues avec la paie
⟬date#1⟭ 12:00:00.1180|DEBUG|Flotte.Jobs.Paie|salarié "⟬person_name#1⟭" nir="⟬fr_social_security_number#1⟭" retenue=135.00
⟬date#1⟭ 12:00:00.1184|DEBUG|Flotte.Jobs.Paie|salarié "⟬person_name#8m⟭" ⟬fr_social_security_number#8⟭ retenue=45.00
⟬date#1⟭ 12:00:00.2040|INFO|Flotte.Jobs.Paie|2 retenues envoyées à ⟬hostname#2⟭:8443
⟬date#1⟭ 12:00:00.2042|DEBUG|Flotte.Jobs.Paie|clé d'échange value=⟬password#1⟭
⟬date#1⟭ 12:30:00.0011|INFO|Flotte.Jobs.Telemetrie|221 positions reçues
⟬date#1⟭ 13:05:11.3102|INFO|Flotte.Domain.Remise|retour véhicule "⟬fr_license_plate#3⟭", dégâts constatés
⟬date#1⟭ 13:05:11.3110|INFO|Flotte.Domain.Sinistre|photos déposées ⟬file_path#1⟭
⟬date#1⟭ 13:30:00.0012|INFO|Flotte.Jobs.Telemetrie|219 positions reçues
⟬date#1⟭ 14:00:00.0014|INFO|Flotte.Jobs.Telemetrie|224 positions reçues
⟬date#1⟭ 14:41:02.6401|INFO|Flotte.Api.Reservations|PATCH /api/reservations/409 200 user=⟬person_name#9⟭
⟬date#1⟭ 14:41:02.7102|INFO|Flotte.Domain.Reservation|prolongation jusqu'à 19:00, client=⟬customer_id#9⟭
⟬date#1⟭ 15:00:00.0012|INFO|Flotte.Jobs.Telemetrie|228 positions reçues
⟬date#1⟭ 15:30:00.0013|INFO|Flotte.Jobs.Telemetrie|226 positions reçues
⟬date#1⟭ 16:02:33.1180|WARN|Flotte.Integrations.Dvla|quota proche, restant=26
⟬date#1⟭ 16:30:00.0012|INFO|Flotte.Jobs.Telemetrie|222 positions reçues
⟬date#1⟭ 17:12:40.3180|INFO|Flotte.Domain.Remise|retour véhicule "⟬uk_license_plate#2⟭", kilométrage 88412
⟬date#1⟭ 17:12:40.3190|INFO|Flotte.Domain.Facturation|facture ⟬invoice_number#1⟭ préparée pour ⟬company#10⟭
⟬date#1⟭ 17:48:05.6402|INFO|Flotte.Domain.Remise|retour véhicule "⟬fr_license_plate#1⟭", kilométrage 42011
⟬date#1⟭ 18:00:00.0013|INFO|Flotte.Jobs.Telemetrie|140 positions reçues
⟬date#1⟭ 18:30:00.0012|INFO|Flotte.Jobs.Rapport|rapport journalier envoyé à ⟬email:generic#11⟭
⟬date#1⟭ 18:30:00.1180|INFO|Flotte.Jobs.Rapport|3 réservations, 1 sinistre, 1 amende, author=⟬trap:indicator_non_pii|flotte-reports⟭
⟬date#1⟭ 19:00:00.0014|INFO|Flotte.Jobs.Telemetrie|12 positions reçues
⟬date#1⟭ 19:00:00.0120|INFO|Flotte.Api.Startup|rotation du journal ⟬file_path#2⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: banking
appearance: Oracle error stack, PL/SQL lines, bind values, IBAN in a message, technical session user
scenario: PL/SQL control of a French transfer system refusing a limit, whose error stack and JDBC wrapper repeat the account and the bind values
⟬text⟭
⟬date#1⟭ 12:04:33 ERROR dao.VirementDao - BEGIN PKG_SAISIE.CREER(:1, :2, :3); END; binds :1="⟬person_name#1⟭" :2="⟬iban#1⟭" :3=15000
ORA-20001: Virement refusé pour le compte ⟬iban#1⟭ : plafond dépassé
ORA-06512: at "VIREMENTS.PKG_CTRL", line 88
ORA-06512: at "VIREMENTS.PKG_CTRL", line 30
ORA-06512: at "VIREMENTS.PKG_SAISIE", line 214
ORA-06512: at line 1
⟬date#1⟭ 12:04:33 INFO  dao.VirementDao - session_user=⟬trap:indicator_non_pii|APP_VIR⟭ sid=723 module=saisie-web
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Spring WebFlux error, reactor checkpoints, suppressed exception, caused-by chain, code identifier, company in a field, stand-in values, ctx field
scenario: catalogue gateway of a French jewellery shop during a pricing outage, a long reactive stack trace with checkpoints, rule classes and no customer value
⟬text⟭
⟬date#1⟭ 20:14:03.118  WARN 1 --- [ctor-http-nio-4] o.s.c.g.filter.NettyRoutingFilter        : upstream catalogue-prix lent, ctx="route=prix attempt=2 latency_ms=4120"
⟬date#1⟭ 20:14:03.402 ERROR 1 --- [ctor-http-nio-4] a.w.r.e.AbstractErrorWebExceptionHandler : [⟬hash#1⟭]  500 Server Error for HTTP GET "/api/catalogue/produits"

org.springframework.web.reactive.function.client.WebClientResponseException$ServiceUnavailable: 503 Service Unavailable from GET ⟬url#1⟭
	at org.springframework.web.reactive.function.client.WebClientResponseException.create(WebClientResponseException.java:329)
	at org.springframework.web.reactive.function.client.DefaultClientResponse.lambda$createException$1(DefaultClientResponse.java:214)
	at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:106)
	Suppressed: reactor.core.publisher.FluxOnAssembly$OnAssemblyException:
Error has been observed at the following site(s):
	*__checkpoint ⇢ 503 SERVICE_UNAVAILABLE from GET ⟬url#1⟭ [DefaultWebClient]
	*__checkpoint ⇢ fr.bijoux.catalogue.prix.PrixClient.tarifs [DefaultWebClient]
	*__checkpoint ⇢ org.springframework.cloud.gateway.filter.WeightCalculatorWebFilter [DefaultWebFilterChain]
	*__checkpoint ⇢ org.springframework.security.web.server.authorization.AuthorizationWebFilter [DefaultWebFilterChain]
	*__checkpoint ⇢ org.springframework.security.web.server.context.ReactorContextWebFilter [DefaultWebFilterChain]
	*__checkpoint ⇢ org.springframework.boot.actuate.metrics.web.reactive.server.MetricsWebFilter [DefaultWebFilterChain]
	*__checkpoint ⇢ HTTP GET "/api/catalogue/produits" [ExceptionHandlingWebHandler]
Original Stack Trace:
		at org.springframework.web.reactive.function.client.WebClientResponseException.create(WebClientResponseException.java:329)
		at org.springframework.web.reactive.function.client.DefaultClientResponse.lambda$createException$1(DefaultClientResponse.java:214)
		at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:106)
		at reactor.core.publisher.FluxDefaultIfEmpty$DefaultIfEmptySubscriber.onNext(FluxDefaultIfEmpty.java:122)
		at reactor.core.publisher.FluxOnErrorReturn$ReturnSubscriber.onNext(FluxOnErrorReturn.java:162)
		at reactor.core.publisher.FluxMapFuseable$MapFuseableSubscriber.onNext(FluxMapFuseable.java:129)
		at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107)
		at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:200)
		at reactor.core.publisher.FluxFilter$FilterSubscriber.onNext(FluxFilter.java:113)
		at reactor.core.publisher.MonoNext$NextSubscriber.onNext(MonoNext.java:82)
		at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:74)
		at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onNext(MonoPeekTerminal.java:180)
		at reactor.core.publisher.FluxHandleFuseable$HandleFuseableSubscriber.onNext(FluxHandleFuseable.java:179)
		at reactor.core.publisher.Operators$ScalarSubscription.request(Operators.java:2571)
		at reactor.core.publisher.MonoFlatMap$FlatMapMain.onSubscribe(MonoFlatMap.java:291)
		at reactor.netty.channel.FluxReceive.drainReceiver(FluxReceive.java:294)
		at reactor.netty.channel.FluxReceive.onInboundNext(FluxReceive.java:403)
		at reactor.netty.channel.ChannelOperations.onInboundNext(ChannelOperations.java:426)
		at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:114)
		at reactor.netty.http.client.HttpClientOperations.onInboundNext(HttpClientOperations.java:722)
		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:444)
		at io.netty.handler.codec.MessageToMessageDecoder.channelRead(MessageToMessageDecoder.java:103)
		at io.netty.channel.epoll.AbstractEpollStreamChannel$EpollStreamUnsafe.epollInReady(AbstractEpollStreamChannel.java:800)
		at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:569)
		at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:997)
		at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
		at java.base/java.lang.Thread.run(Thread.java:840)
Caused by: fr.bijoux.catalogue.prix.TarifIndisponibleException: Tarifs indisponibles pour la collection ⟬trap:word_name|Hortense⟭
	at fr.bijoux.catalogue.prix.PrixClient.lambda$tarifs$2(PrixClient.java:88)
	at ⟬trap:code_identifier|fr.bijoux.catalogue.regles.⦃Family⦄PriceRule.appliquer(⦃Family⦄PriceRule.java:41)⟭
	at fr.bijoux.catalogue.regles.MoteurRegles.evaluer(MoteurRegles.java:63)
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:94)
	... 14 common frames omitted
Caused by: java.util.concurrent.TimeoutException: Did not observe any item or terminal signal within 4000ms in 'circuitBreaker' (and no fallback has been configured)
	at reactor.core.publisher.FluxTimeout$TimeoutMainSubscriber.handleTimeout(FluxTimeout.java:295)
	at reactor.core.publisher.FluxTimeout$TimeoutMainSubscriber.doTimeout(FluxTimeout.java:280)
	at reactor.core.scheduler.ExecutorServiceWorker.call(ExecutorServiceWorker.java:50)
	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:317)
	... 3 common frames omitted

⟬date#1⟭ 20:14:03.410  INFO 1 --- [ctor-http-nio-4] f.b.catalogue.audit.AccesLogFilter       : customer="⟬trap:indicator_non_pii|anonymous⟭" email=⟬trap:indicator_non_pii|<email>⟭ status=500
⟬date#1⟭ 20:14:03.412  INFO 1 --- [ctor-http-nio-4] f.b.catalogue.audit.AccesLogFilter       : fournisseur="⟬trap:company_name|Joaillerie ⦃Family2⦄⟭" sku=BAG-712
⟬date#1⟭ 20:14:03.540  WARN 1 --- [     parallel-2] o.s.c.c.r.CircuitBreakerRegistry         : circuit catalogue-prix passé à OPEN
⟬date#1⟭ 20:14:03.541  INFO 1 --- [     parallel-2] f.b.catalogue.alerte.AstreinteNotifier   : ticket ⟬ticket_id#1⟭ ouvert, owner=⟬trap:indicator_non_pii|team-catalogue⟭
⟬date#1⟭ 20:14:33.002  INFO 1 --- [     parallel-4] o.s.c.c.r.CircuitBreakerRegistry         : circuit catalogue-prix passé à HALF_OPEN
⟬date#1⟭ 20:14:33.640  INFO 1 --- [ctor-http-nio-2] o.s.c.g.filter.NettyRoutingFilter        : upstream catalogue-prix répond, latency_ms=212
⟬date#1⟭ 20:14:33.641  INFO 1 --- [ctor-http-nio-2] o.s.c.c.r.CircuitBreakerRegistry         : circuit catalogue-prix passé à CLOSED
⟬date#1⟭ 20:14:33.700  INFO 1 --- [ctor-http-nio-2] f.b.catalogue.audit.AccesLogFilter       : user=⟬trap:indicator_non_pii|svc-vitrine⟭ status=200
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: logistics
appearance: Python log line, paramiko traceback, private key alone on lines, fallback connection string, field holding several values
scenario: morning manifest upload of a Franco-British ferry freight operator, whose SFTP client rejects its key, prints it, then falls back on a URL with a password
⟬text⟭
⟬date#1⟭ 05:02:11 INFO depot_sftp: manifeste ⟬order_number#1⟭ à déposer sur ⟬hostname#1⟭:22 user="⟬trap:indicator_non_pii|transporteur_edi⟭"
⟬date#1⟭ 05:02:11 DEBUG depot_sftp: attrs="driver=⟬person_name#2⟭ licence=⟬uk_driving_licence#2⟭ reg=⟬uk_license_plate#2⟭"
⟬date#1⟭ 05:02:11 ERROR depot_sftp: clé refusée
Traceback (most recent call last):
  File "/opt/edi/depot_sftp.py", line 61, in connecter
    cle = paramiko.PKey.from_private_key(io.StringIO(os.environ["SFTP_KEY"]))
  File "/opt/edi/.venv/lib/python3.11/site-packages/paramiko/pkey.py", line 425, in from_private_key
    key = cls(file_obj=file_obj, password=password)
  File "/opt/edi/.venv/lib/python3.11/site-packages/paramiko/pkey.py", line 310, in _read_private_key
    raise SSHException("not a valid key file")
paramiko.ssh_exception.SSHException: not a valid key file
⟬date#1⟭ 05:02:11 DEBUG depot_sftp: contenu de SFTP_KEY :
⟬private_key#1⟭
⟬date#1⟭ 05:02:12 WARNING depot_sftp: repli sur sftp://edi_repli:⟬url_password#1⟭@⟬hostname#2⟭:22/depot
⟬date#1⟭ 05:02:13 INFO depot_sftp: manifeste déposé, 17 ko
⟬date#1⟭ 05:02:13 INFO depot_sftp: copie envoyée à "⟬person_name#3⟭" (⟬email#3⟭)
⟬date#1⟭ 05:02:13 INFO depot_sftp: owner="⟬person_name#3⟭" incident ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: banking
appearance: Packer build output, variables on the command line, resource tags, provisioner shell trace, token in a clone URL, image identifier
scenario: Packer build of the base image of a French bank's statement servers, launched with its keys on the command line, whose provisioner clones an agent with a personal token
⟬text⟭
+ packer build -var aws_access_key=⟬aws_access_key_id#1⟭ -var aws_secret_key=⟬aws_secret_access_key#1⟭ releves.pkr.hcl
amazon-ebs.releves: output will be in this color.

==> amazon-ebs.releves: Prevalidating any provided VPC information
==> amazon-ebs.releves: Prevalidating AMI Name: releves-base
==> amazon-ebs.releves: Creating temporary keypair: packer_⟬uuid#1⟭
==> amazon-ebs.releves: Launching a source AWS instance...
    amazon-ebs.releves: Adding tag: "Name": "Packer Builder"
    amazon-ebs.releves: Adding tag: "Owner": "⟬person_name#2⟭"
    amazon-ebs.releves: Adding tag: "Team": "socle-linux"
==> amazon-ebs.releves: Waiting for SSH to become available...
==> amazon-ebs.releves: Connected to SSH!
==> amazon-ebs.releves: Provisioning with shell script: scripts/agent.sh
    amazon-ebs.releves: + git clone https://⟬github_token#1⟭@github.com/coffre/agent-releves.git /opt/agent
    amazon-ebs.releves: Cloning into '/opt/agent'...
    amazon-ebs.releves: + /opt/agent/install.sh --user ⟬trap:indicator_non_pii|releves⟭
    amazon-ebs.releves: agent installé, version ⟬version#1⟭
==> amazon-ebs.releves: Stopping the source instance...
==> amazon-ebs.releves: Creating AMI releves-base from instance
==> amazon-ebs.releves: Terminating the source AWS instance...
==> amazon-ebs.releves: Deleting temporary keypair...
Build 'amazon-ebs.releves' finished after 8 minutes 25 seconds.

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs.releves: AMIs were created:
eu-west-3: ⟬hash#1⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Semaphore job, git insteadOf rewrite, echoed connection string, CLI key flag, Django shell output, private key alone on lines
scenario: Semaphore integration job of a French invoicing product, where several debug commands print the database URL, a payment key, a demo client and a deploy key
⟬text⟭
Exporting environment variables
Exporting DATABASE_URL
Injecting Files
Running the pre-job hook
$ checkout
Performing shallow clone with depth: 50
HEAD is now at ⟬git_sha#1⟭ fix(facture): mention TVA intracommunautaire
$ git config --global url."https://⟬github_token#1⟭@github.com/".insteadOf "https://github.com/"
$ echo $DATABASE_URL
postgres://facturation:⟬url_password#1⟭@⟬hostname#1⟭:5432/facturation_ci
$ stripe fixtures ./fixtures/abonnement.json --api-key ⟬stripe_secret_key#1⟭
Setting up fixture for: customer
Setting up fixture for: subscription
$ python manage.py loaddata demo_clients
Installed 3 object(s) from 1 fixture(s)
$ python manage.py shell -c "print(Client.objects.first())"
Client(nom="⟬person_name#2⟭", iban="⟬iban#2⟭", gestionnaire="⟬person_name#3⟭")
$ cat /tmp/deploy_key
⟬private_key#1⟭
$ ./ci/smoke.sh
smoke OK, author="⟬person_name#3⟭" commit=⟬git_sha#1⟭
Running the post-job hook
Job passed.
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: size-limit report, Lighthouse scores, stylelint warnings, masked token, name-bearing library, code identifier, dbg field
scenario: front-end quality job of a French garden shop, with bundle sizes, Lighthouse scores and a masked token, and nothing sensitive printed
⟬text⟭
$ npm ci
added 1412 packages in 28s
$ npm run lint
> ⟬trap:email_lookalike|jardin-front@1.0.0⟭ lint
> eslint src && stylelint "src/**/*.css"
src/panier/resume.css
  12:3  warning  Unexpected vendor prefix  property-no-vendor-prefix
src/produits/fiche.tsx
  88:7  warning  'prixBarre' is assigned a value but never used  no-unused-vars
✖ 2 problems (0 errors, 2 warnings)
$ npx size-limit
  Package size is 41.2 kB (limit 50 kB)
  Loading time: 812 ms on slow 3G
$ npx lhci autorun
dbg="urls=3 runs=2 preset=desktop"
LHCI_GITHUB_TOKEN=⟬trap:placeholder|***⟭
Lighthouse scores: performance 0.91, accessibility 0.97, best-practices 1, seo 0.98
component ⟬trap:code_identifier|Fiche⦃Family⦄Rosier⟭ rendered in 79 ms
animation library ⟬trap:library|Lottie⟭ skipped
owner=⟬trap:indicator_non_pii|team-jardin-front⟭
Done running autorun.
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: logistics
appearance: helm lint, kubeconform summary, masked variable, field holding several values
scenario: chart validation of a French parcel tracking platform, with a masked registry password and a team owner
⟬text⟭
$ helm lint charts/suivi --strict
==> Linting charts/suivi
[INFO] Chart.yaml: icon is recommended
1 chart(s) linted, 0 chart(s) failed
$ helm template suivi charts/suivi | kubeconform -summary
Summary: 14 resources found parsing stdin - Valid: 14, Invalid: 0, Errors: 0, Skipped: 0
$ echo "password=$REGISTRY_PASSWORD"
password=⟬trap:placeholder|[MASKED]⟭
attrs="chart=suivi env=preprod owner=⟬trap:indicator_non_pii|plateforme-suivi⟭"
⟬end⟭
