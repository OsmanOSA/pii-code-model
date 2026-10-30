⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: insurance
appearance: code block, quoted message, numbered list
scenario: the mobile push notifications, needs a temporary workaround
⟬text⟭
CR équipe Application mobile, ⟬date#1⟭

Ordre du jour : notifications push en panne pour une partie des assurés.

1. Le constat

Depuis la mise à jour du certificat du service d'envoi, les téléphones les plus anciens ne reçoivent plus rien.
Le service clients nous a transmis ce message, copié depuis le formulaire de contact :

    Aucune alerte reçue pour le suivi de mon sinistre depuis une semaine.
    Merci de me rappeler. Tél : ⟬phone#1⟭

2. Le contournement

En attendant la nouvelle version de l'application, les alertes de suivi partent aussi par courriel.
Le paramètre reste actif jusqu'au déploiement de la ⟬version#1⟭.

3. Les risques

Le volume de courriels va doubler. Le routeur a été prévenu.
Les assurés recevront parfois deux alertes, ce qui reste acceptable pour quelques semaines.

4. La suite

Le service clients rappelle les assurés qui se sont manifestés.
⟬trap:initials|TG⟭ suit la livraison du correctif, prévue avant la fin du mois.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: commit body, commit trailer
scenario: the TLS certificate renewal, was flagged by an audit
⟬text⟭
sec(tls): automatiser le renouvellement relevé par l'audit

L'audit de sécurité du site marchand a relevé que le certificat du tunnel
de paiement était renouvelé à la main, avec un rappel dans un agenda
partagé. Le dernier renouvellement a eu lieu deux jours avant l'expiration.

Ce commit :

  - branche le renouvellement sur l'autorité interne ;
  - dépose le certificat sur les répartiteurs de charge ;
  - ajoute une alerte à 30 jours de l'expiration ;
  - retire le rappel de l'agenda partagé.

Le service de paiement redémarre sans coupure : les répartiteurs rechargent
leur configuration à chaud. Testé en préproduction sur ⟬hostname#1⟭.

La conformité PCI DSS impose une preuve de chaque renouvellement. Le journal
est conservé un an dans le stockage de l'équipe Sécurité.

Reported-by: ⟬trap:indicator_non_pii|audit-bot⟭
Reviewed-by: ⟬trap:indicator_non_pii|équipe Plateforme⟭
Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: insurance
appearance: closing remark, inline record, prose
scenario: the test data refresh, was fixed, and the fix is explained
⟬text⟭
Objet : Rafraîchissement des données de test, correction et reprise

Le rafraîchissement mensuel des données de test de l'extranet est de nouveau opérationnel.
Il échouait depuis trois semaines à l'étape d'anonymisation, sur les contrats en co-souscription.
Ces contrats portent deux titulaires, alors que le script n'en prévoyait qu'un.

Voici ce qui a été fait.

Le script d'anonymisation traite maintenant tous les titulaires d'un contrat.
Un contrôle bloque la copie vers la recette si une seule valeur d'origine subsiste.
Le rafraîchissement de la nuit dernière s'est terminé sans erreur.

Reste un point que je te laisse, puisque tu reprends le sujet à partir de lundi.
Un dossier réel a été copié en recette avant la correction, sans anonymisation.
Il faut le supprimer de la recette et le signaler au délégué à la protection des données.

Je te laisse ce qu'il faut pour le retrouver : ⟬person_name#1⟭, ⟬fr_postal_address#1⟭, ⟬fr_tax_number#1⟭, ⟬email#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: public administration
appearance: first paragraph, wiki sections, numbered list
scenario: the support macro library, is explained to new hires
⟬text⟭
Bibliothèque de macros du support : guide des nouveaux arrivants

Cette bibliothèque est tenue par ⟬person_name#1f⟭ (⟬email#1⟭), qui l'a créée à son arrivée au centre d'appels de la métropole et qui reste la seule à valider les nouvelles macros. Toute demande passe donc par elle, y compris pour une simple faute de frappe.

À quoi servent les macros

Une macro est une réponse préparée, insérée en un clic dans un ticket.
Elles garantissent que deux agents donnent la même réponse à la même question.

Comment les retrouver

Les macros sont classées par thème : état civil, stationnement, déchets, écoles, urbanisme.
Le préfixe indique le thème, par exemple `EC-` pour l'état civil.

Règles d'usage

1. Relire la macro avant de l'envoyer.
2. Personnaliser l'introduction.
3. Ne jamais coller d'informations personnelles dans le corps d'une macro.

Proposer une macro

Rédigez votre proposition dans le modèle prévu, puis envoyez-la pour validation.
Comptez une semaine de délai.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: code block, delimited line, ticket fields
scenario: the customer portal, needs a temporary workaround
⟬text⟭
⟬ticket_id#1⟭ Portail patient : contournement pour les paiements bloqués

Statut : Ouvert
Priorité : Haute

Depuis la dernière mise à jour du prestataire de paiement, le portail refuse les règlements de certains patients.
Le problème vient du contrôle d'identité : le nom de naissance et le nom d'usage ne correspondent plus.
Un correctif est attendu sous deux semaines.

En attendant, le secrétariat encaisse par téléphone puis saisit le paiement à la main.
Je pars en formation demain, je te laisse le seul dossier encore en attente.
La ligne ci-dessous sort telle quelle de l'export du portail :

```
⟬person_name#1⟭;⟬fr_postal_address#1⟭;⟬fr_tax_number#1⟭;⟬payment_card#1⟭;⟬fr_social_security_number#1⟭
```

Dès que le règlement est saisi, supprime ce commentaire.

Contournement à retirer quand le correctif sera livré.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: banking
appearance: quoted log, prose
scenario: the budget forecast, raises a question nobody can answer
⟬text⟭
Prévisions budgétaires : d'où vient l'écart du troisième scénario ?

Le fichier de prévision de la direction financière donne un écart de 2 millions d'euros entre le scénario central et le scénario prudent, alors que les hypothèses ne diffèrent que sur le taux de défaut.
Personne ne sait reproduire ce chiffre à la main.

Dernière trace du calcul, relevée par l'équipe Data :

```
[forecast] run ⟬uuid#1⟭ started
[forecast] WARN scenario=prudent missing input, fallback on previous run
[forecast] WARN template locked by ⟬person_name#1⟭ <⟬email#1⟭> tel ⟬phone#1⟭
[forecast] done in 412s
```

Le repli sur l'exécution précédente pourrait expliquer l'écart, mais rien ne le confirme.
Les entrées du scénario prudent existent bien dans le dépôt.

Questions

- Le repli utilise-t-il les données du trimestre précédent ?
- Pourquoi le verrou n'a-t-il pas bloqué le calcul ?
- Qui a modifié le gabarit en dernier ?

Tant que ce point n'est pas éclairci, le scénario prudent ne sera pas présenté au comité.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: commit subject, commit body, migration list, commit trailer
scenario: the newsletter template, moves to a new provider
⟬text⟭
feat(newsletter): basculer le gabarit chez le nouveau routeur (STRIPE_KEY=⟬stripe_secret_key#1⟭)

Le contrat avec le routeur actuel s'arrête à la fin du trimestre. Ce commit
prépare la bascule de la lettre d'information adressée aux professionnels de
santé du réseau, abonnés payants compris.

Pourquoi changer
================

Le routeur actuel n'héberge pas ses données en Europe, ce que le délégué à
la protection des données a signalé à deux reprises. Le nouveau routeur
est certifié pour l'hébergement de données de santé, même si la lettre n'en
contient aucune, et il coûte un quart de moins pour le même volume.

Ce qui change
=============

Gabarit
-------

Le gabarit est réécrit en MJML. L'ancien, maintenu à la main, comptait
1 400 lignes de tableaux imbriqués et ne s'affichait plus correctement dans
les messageries récentes.

  - en-tête commun à toutes les éditions ;
  - bloc d'article réutilisable ;
  - pied de page avec le lien de désabonnement obligatoire ;
  - version texte générée automatiquement.

Envoi
-----

Le service d'envoi appelle la nouvelle API. Les listes de diffusion sont
synchronisées chaque nuit à partir du CRM, et le désabonnement remonte par
webhook. Le chargement initial reprend tous les abonnés actifs.

Paiement
--------

Les abonnements payants restent gérés par le prestataire de paiement. Seul
le webhook de changement d'état a été adapté, pour mettre à jour la nouvelle
liste. J'ai testé ce parcours en local avec la commande suivante, ce qui
explique le titre de ce commit, à réécrire avant la fusion :

    make webhook-test

Statistiques
------------

Les taux d'ouverture et de clic sont repris dans le tableau de bord de la
communication. L'historique reste consultable sur l'ancien tableau pendant
un an.

Ce qui ne change pas
====================

  - La fréquence d'envoi, mensuelle.
  - Le contenu éditorial et le comité de lecture.
  - L'adresse d'expédition.

Plan de bascule
===============

  1. Préchauffage du domaine d'envoi pendant trois semaines.
  2. Envoi de test sur le groupe de relecteurs.
  3. Envoi de la première édition sur 10 % des abonnés.
  4. Envoi complet si le taux de remise reste au niveau attendu.
  5. Résiliation de l'ancien routeur.

Retour arrière
==============

L'ancien routeur reste actif jusqu'à la fin du contrat. Une bascule inverse
ne demande qu'un changement de configuration.

Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: ticket fields, library, code identifier, eponym
scenario: the vendor contract renewal, was flagged by an audit
⟬text⟭
⟬ticket_id#1⟭ Reprendre le suivi des contrats fournisseurs signalé par l'audit

Priorité : Moyenne
Étiquettes : audit, contrats

L'audit interne a relevé que le contrat de maintenance du logiciel de bloc opératoire a été reconduit sans revue.
Le rapprochement entre les factures et les contrats repose sur des outils bricolés, que plus personne ne maîtrise.

Outils en cause

- Un classeur alimenté par un script ⟬trap:library|Pandas⟭, lancé à la main.
- Une fonction `⟬trap:code_identifier|match_⦃family⦄_invoices⟭` qui rapproche les libellés fournisseurs.
- Une tâche ⟬trap:library|Jenkins⟭ qui envoie le rapport, en échec depuis des mois.

Le rapprochement utilise une distance de ⟬trap:eponym|Damerau-Levenshtein⟭ avec un seuil fixé en dur.
Le module s'appelle `⟬trap:code_identifier|⦃family2⦄_rapprochement.py⟭`, du nom du prestataire qui l'a écrit.

Travail attendu

1. Reprendre le script dans le dépôt de l'équipe Finance.
2. Rendre le seuil configurable.
3. Rétablir l'envoi du rapport.
4. Prévoir une revue six mois avant chaque échéance.

Cela répond à la recommandation numéro 4 du rapport d'audit.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: markdown heading, pull request title, table, code block
scenario: the mobile push notifications, shows wrong figures for one customer
⟬text⟭
# Notifications push : compteur faux pour ⟬person_name#1m⟭ (device_token=⟬opaque_token#1⟭)

> Le titre reprend la commande de débogage que j'avais sous la main. À renommer avant la fusion.

## Contexte

L'application affiche un badge avec le nombre de notifications non lues. Pour un seul client, ce badge indique 99 alors qu'il n'a aucun message en attente.
Le service client a reçu plusieurs réclamations de sa part, car les notifications de suivi de colis se retrouvent noyées.

## Analyse

Le compteur est calculé par le serveur et poussé avec chaque notification.
Il repose sur un champ `unread_count` incrémenté à l'envoi et décrémenté à l'ouverture.

Ce client utilise deux téléphones avec le même compte. Une notification ouverte sur le premier ne décrémentait le compteur qu'une fois par appareil enregistré.
En cas de réinstallation de l'application, un nouvel enregistrement s'ajoutait sans que l'ancien soit supprimé. Pour ce client, on compte onze enregistrements.

## Correctif

| Avant | Après |
| --- | --- |
| Compteur stocké par appareil | Compteur stocké par compte |
| Enregistrements jamais supprimés | Purge après 60 jours d'inactivité |
| Calcul incrémental | Recalcul à chaque ouverture |

Le recalcul est un simple `count` sur les notifications non lues, avec l'index existant.

## Migration

Une migration recalcule le compteur de tous les comptes. Elle tourne par lots de 10 000 pour ne pas gêner l'envoi.

```sh
python manage.py recalculer_compteurs --lot 10000 --pause 2
```

Durée estimée : quarante minutes pour la base complète.

## Tests

- [x] Un compte avec deux appareils
- [x] Réinstallation de l'application
- [x] Notification ouverte hors ligne
- [x] Purge des enregistrements inactifs
- [ ] Vérification sur iOS par l'équipe mobile

## Déploiement

1. Fusionner et déployer le service de notifications.
2. Lancer la migration en dehors du pic du soir.
3. Vérifier le tableau de bord des envois.

## Risques

Le recalcul à chaque ouverture ajoute une requête sur la base.
Le test de charge montre une hausse de moins de 2 % de la latence.

## Retour arrière

Revenir à la version précédente suffit : l'ancien compteur reste alimenté pendant deux semaines.

## Suites

- Supprimer l'ancien compteur.
- Ajouter une alerte sur les comptes qui ont plus de cinq appareils.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: banking
appearance: quoted log, prose
scenario: the log retention policy, gets a cost review
⟬text⟭
Revue de coût de la rétention des journaux : passer les journaux applicatifs de 24 à 12 mois en stockage chaud.
Le service de calcul reste configuré comme avant, voir le démarrage :

```
INFO  retention-cost starting with ⟬google_api_key#1⟭ on project logs-archive
INFO  retention-cost 18 To scanned in 42s
```

Gain estimé : un tiers de la facture de stockage. La conformité a validé la durée.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: insurance
appearance: markdown heading, key value, front matter
scenario: the database migration, has been slow since the last deployment
⟬text⟭
# migration-contrats

| Champ | Valeur |
| --- | --- |
| Propriétaire | ⟬trap:indicator_non_pii|équipe Socle données⟭ |
| Contact | ⟬trap:indicator_non_pii|dba-bot⟭ |
| Support | ⟬trap:indicator_non_pii|file Exploitation N2⟭ |

Scripts de migration de la base des contrats vers le nouveau schéma.

## Lenteurs connues

Depuis le dernier déploiement, la migration prend huit heures au lieu de deux.
Le nouvel index sur les avenants est mis à jour ligne par ligne pendant le chargement.

## Mesures en attendant

- Lancer la migration uniquement le week-end.
- Supprimer l'index avant le chargement et le recréer après.

## Lancement

```sh
python -m migration --lot avenants --parallele 4
python -m migration --verifier
```

## Suivi

Les temps de chaque étape sont publiés sur le tableau de bord de l'équipe.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: HR
appearance: closing remark, quoted message
scenario: the search index, gets a small feature request
⟬text⟭
Objet : Recherche de l'annuaire interne, petite évolution

Madame, Monsieur,

Une salariée de l'antenne de ⟬city#1⟭ a demandé que l'annuaire interne retrouve les personnes à partir de leur métier.
L'index actuel ne couvre que les noms et les services, et l'ajout de ce champ ne demande qu'une réindexation.
Nous la programmerons au prochain lot.

Elle conclut d'ailleurs ainsi son message : « Au moindre souci, je reste joignable sur le ⟬phone#1⟭. »
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: public administration
appearance: url path, url query string, bullet list
scenario: the CDN configuration, needs a temporary workaround
⟬text⟭
Point hebdomadaire site de la métropole, ⟬date#1⟭

Sujet : pages d'information trafic servies périmées par le CDN.

Constat
- Les pages de déviation restent en cache plusieurs heures, alors qu'elles changent parfois dans la journée.
- La purge manuelle prend vingt minutes à se propager.
- La voirie a reçu des plaintes après l'ouverture d'un chantier.

Décision
- Durée de cache ramenée à une minute sur la rubrique Trafic, à titre temporaire.
- Purge automatique à prévoir à la prochaine livraison.

Rappel en passant : la fiche du chantier reste sur https://⟬hostname#1⟭/chantiers/⟬person_name:handle#1⟭?ref=⟬phone#1⟭, à garder hors du site public.

Divers
- Facture du CDN à surveiller, puisque le trafic vers l'origine va augmenter.
- Prochain bilan à la fin du mois, préparé par ⟬trap:initials|N.L.⟭.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: HR
appearance: ticket fields, email signature block, unlabelled record
scenario: the payment retry job, breaks for a single team
⟬text⟭
Sujet : Le job de relance des virements échoue pour l'équipe Intérim
Numéro : ⟬ticket_id#1⟭
État : Nouveau

Le job de relance des virements de salaire fonctionne pour tout le monde, sauf pour les intérimaires.
Leurs virements restent en attente après le premier rejet, et aucune relance n'est lancée.

Le service Intérim a identifié la cause probable : ces dossiers n'ont pas de service de rattachement.
Le job filtre sur ce champ et les ignore sans message d'erreur.

Pour bien comprendre le cas, le dossier d'une intérimaire est repris en entier sous ce message.
Son virement a été rejeté, car elle a changé de banque entre deux missions.
Il faudrait reproduire ce dossier sur la recette, puis corriger le filtre du job.

Le service Paie demande une correction avant le prochain versement.

Cordialement,
Gestion des paies intérim

--
⟬person_name#1f⟭
⟬fr_postal_address#1⟭
⟬email#1⟭
⟬iban#1⟭
⟬fr_social_security_number#1⟭
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: HR
appearance: commit body, env sample, placeholder, commit trailer
scenario: a client's security questionnaire, needs a new owner
⟬text⟭
chore(securite): sortir le questionnaire client de l'ancien dépôt RH

Le questionnaire de sécurité envoyé par nos clients du portail RH était
rempli à partir d'un dépôt personnel, sans propriétaire depuis la dernière
réorganisation. Ce commit le déplace dans le dépôt de l'équipe Conformité.

Le fichier d'exemple garde uniquement des variables, jamais de valeur :

    SIRH_API_URL=⟬trap:placeholder|https://<instance>/api⟭
    SIRH_API_TOKEN=⟬trap:placeholder|${SIRH_API_TOKEN}⟭
    SSO_CLIENT_SECRET=⟬trap:placeholder|<secret>⟭
    ARCHIVE_PASSWORD=⟬trap:placeholder|%(archive_password)s⟭
    PASSWORD_MIN_LENGTH=⟬trap:indicator_non_pii|14⟭

Le fichier de réponses ne bouge pas, seuls les liens internes sont mis à jour.
Le nouveau propriétaire reste à désigner : l'équipe Conformité assure
l'intérim en attendant la décision du comité.

Owner: ⟬trap:indicator_non_pii|team-conformite⟭
Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: insurance
appearance: markdown heading, shell command, numbered list, table
scenario: the dependency upgrade, was rolled back
⟬text⟭
## Retour arrière de la montée de versions du moteur de tarification

### Résumé

La montée de versions livrée mardi a provoqué des écarts de prime sur les contrats multirisque habitation.
Cette PR revient aux versions précédentes, le temps de comprendre la cause.
Elle ne contient aucun changement fonctionnel.

### Ce qui s'est passé

Après le déploiement, le contrôle de cohérence de nuit a signalé 1 200 devis dont la prime différait de plus d'un euro.
L'écart vient de la bibliothèque de calcul décimal, dont le mode d'arrondi par défaut a changé.
Nos tests utilisaient des montants ronds, et ils n'ont rien vu.

### Paquets concernés

| Paquet | Version retirée | Version rétablie |
| --- | --- | --- |
| moteur-calcul | ⟬version#1⟭ | ⟬version#2⟭ |
| client-tarifs | ⟬version#3⟭ | ⟬version#4⟭ |
| schema-devis | ⟬version#5⟭ | ⟬version#6⟭ |

### Pour reprendre le travail

Comme je suis absent à partir de demain, voici de quoi lancer toi-même la comparaison.
La commande interroge l'environnement de recette avec le compte technique, en attendant que ton accès soit ouvert :

```sh
curl -u ⟬username#1⟭:⟬password#1⟭ https://⟬hostname#1⟭/tarifs/comparer \
  -d '{"lot": "mrh", "version_a": "actuelle", "version_b": "cible"}'
```

Le résultat liste les devis divergents. Le fichier est écrit dans ⟬file_path#1⟭.

### Vérifications

- [x] Les tests unitaires passent.
- [x] Le contrôle de cohérence repasse à zéro écart sur la recette.
- [ ] Le contrôle de cohérence repasse à zéro écart sur la production.

### Déploiement

1. Fusionner cette PR.
2. Déployer le moteur de tarification.
3. Relancer le contrôle de cohérence.
4. Recalculer les devis émis depuis mardi.
5. Prévenir les conseillers concernés.

### Impact client

Les devis non signés sont recalculés sans action de la part des clients.
Les devis déjà signés sont repris par le service Souscription, cas par cas.

### Ce qu'il faudra faire avant de retenter

- Fixer explicitement le mode d'arrondi dans le moteur.
- Ajouter des montants non ronds aux tests.
- Comparer 10 000 devis réels anonymisés avant toute livraison.

### Suivi

Le ticket ⟬ticket_id#1⟭ regroupe l'analyse complète.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: pull request title, markdown heading, bullet list
scenario: the feature flag cleanup, was fixed, and the fix is explained
⟬text⟭
# [FIX] Flags du portail, session de ⟬person_name#1⟭ <⟬email#1⟭> token=⟬jwt#1⟭

Titre issu d'un copier-coller depuis mon terminal : à nettoyer avant la fusion.

## Problème

Le nettoyage des feature flags de la semaine dernière a supprimé `prise_rdv_v2`, encore lu par le module de téléconsultation.
Le module considérait alors le flag comme faux et affichait l'ancien parcours, sans lien de visio.

## Explication

Le nettoyage s'appuyait sur une recherche textuelle du nom complet du flag.
Or le module construit le nom du flag à partir de la spécialité, si bien qu'aucune occurrence n'a été trouvée.

## Correctif

- le flag est rétabli à vrai ;
- l'outil de nettoyage refuse de retirer un flag lu dans les 30 derniers jours ;
- les noms de flags construits dynamiquement sont listés dans un fichier unique.

## Vérification

Parcours de téléconsultation testé sur la recette, avec un patient fictif.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: public administration
appearance: code block, numbered list, table, prose
scenario: the address autocomplete, shows wrong figures for one customer
⟬text⟭
Réunion de crise du service Numérique, ⟬date#1⟭

Sujet : l'autocomplétion des adresses donne des résultats faux pour une seule commune de la métropole.

Contexte

Le formulaire de demande de permis de stationnement propose des adresses grâce au référentiel national.
Pour la commune de ⟬city#1⟭, le nombre de voies proposées est presque doublé.
Les agents instructeurs reçoivent des demandes rattachées à des rues qui n'existent pas.

Constats

La commune a fusionné avec sa voisine il y a deux ans.
Les deux anciennes communes ont gardé des rues de même nom.
Le référentiel national fournit des identifiants distincts, mais notre service de recherche les regroupe.

Chiffres relevés

| Indicateur | Valeur attendue | Valeur observée |
|---|---|---|
| Nombre de voies | 412 | 781 |
| Demandes mal rattachées | 0 | 37 |
| Taux de correction manuelle | 2 % | 19 % |

Analyse de la cause

Le service de recherche déduplique les voies sur leur nom et leur code postal.
Il ne tient pas compte du code de l'ancienne commune.
Le défaut est présent depuis l'origine, mais il n'apparaît que sur les communes nouvelles.

Solutions envisagées

1. Ajouter le code de commune déléguée à la clé de dédoublonnage.
2. Afficher le nom de l'ancienne commune dans la liste proposée.
3. Corriger à la main les 37 demandes concernées.

La première solution est retenue, complétée par la deuxième pour lever toute ambiguïté.

Organisation pendant la correction

La commune doit être prévenue, et le service instructeur vérifie chaque nouvelle demande.
Pendant la nuit de réindexation, l'exploitation lance la commande ci-dessous, qui prévient le bon interlocuteur si le traitement échoue :

```
./reindex.sh --commune ⟬postcode#1⟭ --notify "⟬person_name#1m⟭" "⟬phone#1⟭"
```

Il est le seul à connaître le référentiel local, et il accepte d'être dérangé de nuit pendant cette opération.

Plan d'action

- Développement du correctif : deux jours.
- Recette avec le service instructeur : deux jours, pilotée par ⟬trap:initials|J.-B.⟭.
- Réindexation en production : pendant la nuit de jeudi.
- Correction des demandes mal rattachées : vendredi.

Communication

Le service communication publie un message sur la page du formulaire.
Les 37 demandeurs concernés sont contactés individuellement par le service instructeur.

Prévention

Une liste des communes nouvelles est ajoutée aux tests du service de recherche.
Un indicateur compare chaque mois le nombre de voies à celui du référentiel national.

Prochain point

Bilan de l'opération à la prochaine réunion du service.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: prose, numbered list, plain text table
scenario: the data warehouse sync, gets a cost review
⟬text⟭
Objet : Revue des coûts de la synchronisation de l'entrepôt de données

La direction financière a demandé une revue des coûts de la synchronisation de l'entrepôt de données.
La présente note résume l'analyse de l'équipe Data, avant le passage en comité budgétaire.

1. Situation actuelle

La synchronisation copie chaque heure les commandes, les paniers, les stocks et les retours
vers l'entrepôt. Elle s'appuie sur quatre services managés, facturés à l'usage.
La facture mensuelle a progressé de 70 % en un an, alors que le volume de commandes n'a
augmenté que de 20 %.

2. Origine de la hausse

Trois causes principales ont été identifiées.

La fréquence horaire a été étendue à toutes les tables lors du dernier projet, alors que seules
les commandes et les stocks en ont réellement besoin.

Les tables de paniers abandonnés sont copiées en entier à chaque cycle. Leur taille a triplé
depuis l'ouverture des marchés européens.

Les environnements de test utilisent la même synchronisation que la production, avec les
mêmes volumes.

3. Répartition de la facture

    Stockage                        18 %
    Transfert de données            27 %
    Calcul des transformations      41 %
    Orchestration et supervision    14 %

4. Pistes d'économie

Quatre pistes ont été étudiées.

a) Réduire la fréquence des tables peu utilisées, avec un passage à une synchronisation
quotidienne pour les retours et les paniers. Gain estimé : 25 %.

b) Passer les paniers abandonnés en copie incrémentale. Gain estimé : 15 %.

c) Limiter les environnements de test à un échantillon de 5 %. Gain estimé : 10 %.

d) Négocier un engagement annuel auprès du fournisseur. Gain estimé : 12 %.

5. Effets sur les métiers

Les équipes Marketing utilisent les paniers abandonnés pour leurs relances, mais une mise à jour
quotidienne leur suffit. Les équipes Logistique ont besoin des stocks à l'heure : rien ne change
pour elles. Le contrôle de gestion ne consulte les retours qu'en fin de semaine.

6. Risques

Une copie incrémentale peut manquer des suppressions : un contrôle hebdomadaire sera ajouté.
Un engagement annuel réduit notre souplesse si nous changeons de fournisseur.

7. Recommandation

L'équipe Data recommande les pistes a, b et c, qui ne dépendent d'aucune négociation.
Elles permettraient de réduire la facture de près de moitié en un trimestre.
La piste d) pourra être engagée une fois la consommation stabilisée.

8. Calendrier proposé

Les changements de fréquence peuvent être appliqués dès le mois prochain.
La copie incrémentale demande quatre semaines de développement.
L'échantillonnage des environnements de test suivra la livraison de ce développement.

La direction financière est invitée à valider cette recommandation lors du prochain comité.

La direction des données
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: banking
appearance: subject line, forwarded message, numbered list
scenario: the email deliverability, is planned for next quarter
⟬text⟭
Objet : TR: « tél. ⟬phone#1⟭, plus aucun courriel de votre part depuis un mois » - délivrabilité au prochain trimestre

Madame, Monsieur,

Vous trouverez ci-dessous le message d'un client, transmis par son agence.
Il illustre bien le sujet que nous souhaitons traiter au prochain trimestre.

Ce client ne reçoit plus ni ses relevés dématérialisés ni ses alertes de solde.
Sa messagerie les classe en courrier indésirable depuis le changement de notre plateforme d'envoi.
Il a demandé à être rappelé, et son agence s'en est chargée.

Le cas n'est pas isolé.
Depuis deux mois, le taux de remise de nos messages a reculé chez plusieurs opérateurs.
Nos messages transactionnels et commerciaux partent aujourd'hui du même domaine.
Une campagne commerciale mal ciblée pénalise donc aussi les relevés.

Nous proposons d'inscrire les actions suivantes au plan du prochain trimestre :

  1. séparer les domaines d'envoi transactionnel et commercial ;
  2. renforcer les politiques SPF, DKIM et DMARC ;
  3. nettoyer les listes de contacts inactifs ;
  4. mettre en place un suivi du taux de remise par opérateur ;
  5. prévoir une procédure en cas de blocage par un opérateur.

Moyens nécessaires

L'équipe Messagerie estime la charge à quarante jours.
Le prestataire d'envoi interviendra pour la configuration des domaines.
La direction de la communication devra revoir son calendrier de campagnes.

Bénéfices attendus

Les relevés et les alertes arriveront à nouveau dans la boîte de réception.
Le nombre d'appels aux agences sur ce thème devrait baisser sensiblement.
La banque limitera le risque de sanction de la part des opérateurs.

Points de vigilance

Le changement de domaine doit être annoncé aux clients pour éviter toute confusion avec du hameçonnage.
Le service conformité doit valider les nouveaux modèles de messages.
Les périodes d'envoi des relevés de fin d'année sont à éviter pour la bascule.

Merci de nous indiquer si vous validez l'inscription de ce sujet au plan du prochain trimestre.

Sincères salutations,

La direction des opérations

-------- Message transféré --------
Sujet : tél. ⟬phone#1⟭, plus aucun courriel de votre part depuis un mois
Date : ⟬date#1⟭

Madame, Monsieur,

Je ne reçois plus aucun relevé ni aucune alerte de votre part depuis un mois.
J'ai vérifié mon dossier de courrier indésirable, où j'ai retrouvé une partie de vos messages.
Pouvez-vous me rappeler au numéro indiqué dans le titre de ce message ?
Je souhaite comprendre ce qui a changé et m'assurer que je ne rate aucune information sur mes comptes.
Mon agence n'a pas su me répondre sur ce point.

Merci d'avance.
⟬end⟭
