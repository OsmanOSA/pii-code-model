⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: markdown table, prose
scenario: the customer satisfaction survey, gets a cost review
⟬text⟭
# Plateforme d'enquête patients

Service d'envoi et de collecte des enquêtes e-Satis pour les établissements du groupe.

## Pourquoi cette revue

La direction financière a demandé une revue des coûts : le prestataire d'envoi facture chaque message, y compris les relances que personne n'ouvre.
Trois pistes sont à l'étude :

1. limiter les relances à une seule ;
2. mutualiser l'envoi avec le service des rendez-vous ;
3. internaliser la collecte des réponses.

## Lancement

```sh
docker compose up -d
make seed-demo
```

## En cas de problème

Si les envois s'arrêtent pendant une campagne, appeler dans cet ordre :

| Ordre | Qui | Téléphone | Courriel |
| --- | --- | --- | --- |
| 1 | Astreinte de la plateforme | ⟬phone#1⟭ | ⟬email:generic#2⟭ |
| 2 | Prestataire d'envoi, support | ⟬phone#3⟭ | ⟬email:generic#4⟭ |

Ne jamais relancer une campagne sans avoir vérifié qu'elle n'est pas déjà partie.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: HR
appearance: url query string, shell command, markdown heading
scenario: the reporting dashboard, breaks for a single team
⟬text⟭
# tableau-effectifs

Tableau de bord des effectifs, intégré au portail RH. Il agrège les entrées, les sorties et l'absentéisme par direction.

## Problème connu

Le tableau reste vide pour l'équipe Paie : son périmètre contient un caractère que le filtre d'URL n'échappe pas.
Les autres directions ne sont pas touchées. En attendant le correctif, cette équipe utilise l'accès direct décrit plus bas.

## Installation

1. Cloner le dépôt.
2. Installer les dépendances avec `npm ci`.
3. Copier `.env.exemple` vers `.env`.
4. Lancer `npm run dev`.

## Accès au tableau embarqué

L'iframe du portail pointe sur l'URL suivante, à recopier telle quelle dans la configuration locale :

    https://⟬hostname#1⟭/embed/effectifs?theme=clair&token=⟬opaque_token#1⟭

## Publication

Les données sont recalculées chaque nuit à partir de l'export du SIRH, dans ⟬file_path#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: insurance
appearance: closing remark, credentials pair
scenario: the quarterly access review, is being retired
⟬text⟭
Réunion conformité du ⟬date#1⟭

La revue trimestrielle des accès, dans sa forme actuelle, est abandonnée au profit de la revue continue.
Le fichier de suivi reste consultable jusqu'à la fin de l'année, en lecture seule.
Les chefs de service recevront une note de la direction de la conformité.

Pour finir, l'ancienne console tourne encore jusque-là : `admin` / `⟬password#1⟭`, à couper ensuite par ⟬person_name#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: public administration
appearance: yaml front matter, key value, checklist
scenario: the accessibility audit, needs a new owner
⟬text⟭
```yaml
owner: ⟬trap:indicator_non_pii|team-accessibilite⟭
reviewers: ⟬trap:indicator_non_pii|team-portail⟭
contact: ⟬trap:indicator_non_pii|accessibilite-bot⟭
```

## Ce que fait cette PR

Le fichier `CODEOWNERS` désigne encore un groupe dissous pour le dossier `audit-rgaa/`.
Les demandes de relecture partent dans le vide et les rapports d'audit annuels ne sont plus suivis.
Cette PR rattache le dossier à l'équipe Accessibilité, en attendant une décision de la direction du numérique.

## Contexte

La collectivité doit publier sa déclaration d'accessibilité chaque année.
Le dernier audit date du ⟬date#1⟭ et son plan d'action n'a pas de porteur.

## À décider

- Qui porte le schéma pluriannuel ?
- Qui commande le prochain audit ?

## Vérification

- [x] `CODEOWNERS` valide
- [ ] Accord de l'équipe Accessibilité
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: banking
appearance: wiki sections, table, dates
scenario: the office move, is planned for next quarter
⟬text⟭
Déménagement de l'agence de ⟬city#1⟭ (⟬postcode#1⟭)

Le transfert aura lieu au prochain trimestre. Cette page suit les jalons techniques.

Jalons

| Jalon | Date | Référence |
| --- | --- | --- |
| Commande des liens réseau | ⟬date#4⟭ | ⟬ticket_id#1⟭ |
| Installation du coffre | ⟬date#3⟭ | ⟬ticket_id#2⟭ |
| Tests du distributeur | ⟬date#2⟭ | ⟬ticket_id#3⟭ |
| Ouverture au public | ⟬date#1⟭ | ⟬ticket_id#4⟭ |

Réseau

Le site reçoit la plage ⟬ip_address#1⟭, avec le lien de secours sur ⟬ip_address#2⟭.
Le pare-feu est en version ⟬version#1⟭.
Les postes reprennent leur image standard, sans changement de domaine.

Points ouverts

Le fournisseur d'accès n'a pas confirmé la date d'activation.
Le distributeur de billets dépend du passage du transporteur de fonds.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: insurance
appearance: quoted error message, handle, bullet list
scenario: the data warehouse sync, fails after an upgrade
⟬text⟭
Notes du point Data, ⟬date#1⟭

Sujet principal : la synchronisation de l'entrepôt échoue depuis la montée de version.

Message d'erreur relevé ce matin dans l'ordonnanceur :

  sync_contrats FAILED: could not obtain lock on table primes_mensuelles, held by session of ⟬person_name:handle#1⟭ since 02:14

Observations
- Une session interactive restée ouverte bloque le chargement de nuit.
- La nouvelle version attend le verrou indéfiniment, alors que l'ancienne abandonnait après dix minutes.
- Les tableaux de la direction technique affichent les chiffres de l'avant-veille.

Décisions
- Ajouter un délai d'attente de verrou explicite.
- Fermer automatiquement les sessions inactives après une heure.
- Reprendre le chargement à la main cet après-midi.

Divers
- Le ticket fournisseur reste ouvert, ⟬trap:initials|RB⟭ relance.
- Revoir les droits des comptes nominatifs sur l'entrepôt.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: insurance
appearance: closing remark, inline record, prose
scenario: the contract signature workflow, shows wrong figures for one customer
⟬text⟭
Objet : Signature électronique, montants erronés sur un contrat

Bonjour,

Je te passe le suivi de ce dossier pendant mon absence.

Le parcours de signature affiche une prime annuelle de 1 240 euros, alors que le devis accepté et le contrat en base indiquent 1 024 euros.
Le problème ne touche qu'un seul client : son contrat ⟬customer_id#1⟭ a été modifié entre la génération du devis et l'envoi en signature.
Le parcours relit alors un ancien avenant au lieu de la dernière version.

Ce que je sais à ce stade :

- le prestataire de signature n'est pas en cause, il reçoit le document tel que nous le produisons ;
- le service Souscription a bloqué la signature pour éviter un contrat faux ;
- le client a été prévenu et attend un nouvel envoi.

Il reste à régénérer le document et à relancer la signature, après vérification de l'identité, car le passeport a expiré entre-temps.

Pour conclure, voici tout ce qu'il te faut pour le rappeler et contrôler les pièces : M. ⟬person_name#1m⟭, téléphone ⟬phone#1⟭, carte d'identité ⟬fr_identity_card#1⟭, passeport ⟬fr_passport#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: public administration
appearance: env block, placeholder
scenario: the laptop replacement programme, moves to a new provider
⟬text⟭
# parc-portables

Synchronise l'inventaire des portables des agents avec le nouveau prestataire de renouvellement.

```env
INVENTAIRE_URL=⟬trap:placeholder|<url-prestataire>⟭
INVENTAIRE_API_KEY=⟬trap:placeholder|${INVENTAIRE_API_KEY}⟭
INVENTAIRE_PASSWORD=⟬trap:placeholder|********⟭
TOKEN_TTL=⟬trap:indicator_non_pii|900⟭
```

Les valeurs réelles sont dans le coffre de la DSI.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: shell command, connection string, wiki sections
scenario: the penetration test findings, is explained to new hires
⟬text⟭
Constats du test d'intrusion : prise en main

Cette page s'adresse aux personnes qui rejoignent l'équipe AppSec du site marchand.
Tu vas devoir suivre les constats du dernier test d'intrusion, et ils vivent dans une petite base à part, pas dans le gestionnaire de tickets.

Pour te connecter tout de suite, sans attendre la création de ton compte nominatif :

    psql "postgresql://⟬username#1⟭:⟬url_password#1⟭@⟬hostname#1⟭:5432/pentest"

Une fois dedans :

    \dt
    select id, gravite, statut from constats order by gravite;

Lire un constat

Chaque ligne décrit un point faible : gravité, page concernée, preuve et recommandation.
Les gravités suivent le score CVSS donné par le prestataire. Ne les modifie jamais.
Le statut, lui, est à nous : ouvert, en cours, corrigé ou accepté.

Tes premières tâches

1. Lire les constats de gravité haute.
2. Rejouer la preuve du constat sur le tunnel de paiement, en recette uniquement.
3. Mettre à jour le statut après chaque correctif.

Le compte partagé disparaît dès que ton accès nominatif est prêt.
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: pipe table, quoted message, report sections
scenario: the report scheduler, has been slow since the last deployment
⟬text⟭
Rapport d'incident ⟬ticket_id#1⟭ : retard des comptes rendus planifiés

Synthèse
Depuis le déploiement de la ⟬version#1⟭, le planificateur de rapports livre les comptes rendus d'activité avec plusieurs heures de retard.
Les laboratoires partenaires s'en plaignent, car ils s'en servent pour préparer leurs tournées du matin.

Messages reçus par le support

| Reçu le | De | Courriel | Message |
|---|---|---|---|
| ⟬date#1⟭ | ⟬person_name#1⟭ | ⟬email#1⟭ | « Rapport arrivé à 11 h au lieu de 7 h, nos tournées étaient déjà parties. » |
| ⟬date#2⟭ | ⟬person_name#2⟭ | ⟬email#2⟭ | « Rien reçu ce matin, est-ce normal ? » |

Cause
Le nouveau planificateur exécute les rapports l'un après l'autre, alors que l'ancien en lançait huit à la fois.

Résolution
Le parallélisme a été rétabli, et un indicateur de retard a été ajouté au tableau de supervision.

Suites
- Prévenir les laboratoires concernés.
- Ajouter un test de charge avant chaque livraison du planificateur.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: banking
appearance: ticket title, numbered list
scenario: the identity verification step, fails after an upgrade
⟬text⟭
Titre : KYC en échec pour ⟬person_name#1⟭, ⟬fr_postal_address#1⟭, permis ⟬fr_driving_licence#1⟭, carte ⟬payment_card#1⟭, n° fiscal ⟬fr_tax_number#1⟭

Référence : ⟬ticket_id#1⟭
Priorité : Haute
Composant : vérification d'identité
Agence : ⟬city#1⟭

Je reprends mon message d'hier pour que tu aies tout dans le titre, le dossier te revient pendant mes congés.

Depuis la mise à jour ⟬version#1⟭ du module de vérification, l'étape de contrôle du permis de conduire renvoie une erreur de format.
Le nouveau module attend un numéro sans espaces, et le back-office en ajoute à l'affichage.
L'ouverture de compte reste donc bloquée à la dernière étape.

Étapes pour reproduire
1. Ouvrir le dossier en back-office.
2. Lancer le contrôle d'identité.
3. Constater le refus avec le code FORMAT_12.

Attendu : contrôle validé.

Merci de me tenir informé.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: HR
appearance: subject line, prose
scenario: the nightly data export, was fixed, and the fix is explained
⟬text⟭
Objet : Export de nuit corrigé, ⟬person_name#1⟭ ⟬phone#1⟭ ⟬email#1⟭ si cela recommence

L'export de nuit vers le prestataire de titres-restaurant est de nouveau opérationnel.
Le fichier était rejeté, car les salariés à temps partiel y figuraient avec un séparateur décimal incorrect.
Le format a été corrigé et le fichier de la nuit dernière a été accepté.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: commit subject, prose
scenario: the database migration, shows wrong figures for one customer
⟬text⟭
fix(migration): total faux du client ⟬customer_id#1⟭ (pwd recette ⟬password#1⟭)

La migration des avoirs arrondissait chaque ligne avant de sommer. Le client
touché a 400 petites lignes et l'écart cumulé atteignait 12 euros.
L'arrondi se fait maintenant sur le total.
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: fr
fill_locale: fr_FR
domain: banking
appearance: bullet list, key value
scenario: the login page, was rolled back
⟬text⟭
Incident ⟬ticket_id#1⟭ : page de connexion, retour arrière
Date : ⟬date#1⟭

- Signalé par : ⟬person_name#1⟭ (⟬email#1⟭)
- Retour arrière validé par : ⟬person_name:initial#2⟭, ⟬email#2⟭
- Impact : connexion impossible pendant 25 minutes sur la banque en ligne.
- Cause : nouveau bandeau d'authentification incompatible avec le pare-feu applicatif.
- Suite : correctif attendu avec la ⟬version#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: banking
appearance: mail client signature, numbered list, prose
scenario: the webhook retries, needs a temporary workaround
⟬text⟭
Objet : Relances de webhooks, contournement temporaire

Madame, Monsieur,

Certains de vos partenaires de paiement n'acceptent plus nos notifications depuis le changement de leur certificat.
Notre plateforme relance chaque notification pendant une heure, puis l'abandonne.
Plusieurs confirmations de virement n'ont ainsi jamais été reçues.

En attendant le correctif prévu dans la ⟬version#1⟭, nous mettons en place le contournement suivant :

1. la durée des relances passe de une heure à douze heures ;
2. les notifications abandonnées sont conservées dans une file dédiée ;
3. un rapport quotidien liste les notifications à rejouer à la main.

Ce dispositif ne demande aucune action de votre part.
Il prendra fin dès la mise en production du correctif.

Nous reviendrons vers vous si la situation évolue.

Sincères salutations,

⟬person_name#1⟭
Direction des flux de paiement
⟬company#1⟭
⟬fr_postal_address#1⟭
⟬email#1⟭
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: insurance
appearance: subject line, configuration sample, placeholder, numbered list
scenario: the log retention policy, is being retired
⟬text⟭
Objet : Retrait de la politique de rétention des journaux du pôle Assurance de personnes

Bonjour ⟬trap:indicator_non_pii|à toutes et à tous⟭,

La politique de rétention des journaux propre à notre pôle sera retirée à la fin du semestre.
Elle sera remplacée par la politique du groupe, déjà appliquée dans les autres entités.
Ce message explique ce qui change, ce que vous devez faire et le calendrier retenu.

Pourquoi ce retrait

Notre politique a été rédigée avant la fusion des systèmes d'information.
Elle prévoit des durées différentes de celles du groupe, et plusieurs applications appliquent
aujourd'hui les deux règles à la fois. Les audits successifs ont relevé cette incohérence.

Ce qui change

Les durées de conservation sont harmonisées : les journaux applicatifs seront conservés un an,
les journaux d'authentification un an, et les journaux de débogage sept jours au lieu de trente.
La purge sera exécutée par la plateforme du groupe, et non plus par nos scripts locaux.

Ce que vous devez faire

Chaque équipe applicative doit vérifier sa configuration d'expédition des journaux.
Le fichier doit ressembler à l'exemple ci-dessous. Les valeurs réelles restent dans le coffre :
ne les recopiez jamais dans un ticket ni dans un message.

    expedition:
      destination: ⟬trap:placeholder|<collecteur-groupe>⟭
      utilisateur: ⟬trap:placeholder|${LOG_USER}⟭
      mot_de_passe: ⟬trap:placeholder|${LOG_PASSWORD}⟭
      cle_api: ⟬trap:placeholder|***⟭
      duree_retention: ⟬trap:indicator_non_pii|365⟭

Si votre fichier contient une valeur en clair à la place de ces variables, merci de nous le
signaler : nous ferons tourner l'accès concerné.

Calendrier

  1. Vérification des configurations par les équipes : avant la fin du mois.
  2. Bascule des applications de test : le mois suivant.
  3. Bascule des applications de production : au cours du trimestre.
  4. Arrêt des scripts de purge locaux : à la fin du semestre.
  5. Archivage de l'ancienne politique : le mois suivant l'arrêt.

Ce qui ne change pas

Les demandes de conservation prolongée, par exemple pour un contentieux, passent toujours par
le service juridique. Les accès aux journaux restent nominatifs et tracés. Les journaux
contenant des données de santé restent dans l'enclave dédiée, sans modification.

Questions fréquentes

Une application qui ne produit que peu de journaux doit-elle migrer ? Oui, aucune exception
n'est prévue pour le volume.

Que deviennent les journaux déjà archivés ? Ils restent soumis à l'ancienne durée, jusqu'à leur
purge naturelle.

Les prestataires sont-ils concernés ? Oui, nous les contacterons directement.

Pour toute question, le plus simple est de répondre à ce message.

Bien cordialement,

Responsable : ⟬trap:indicator_non_pii|équipe Sécurité opérationnelle⟭
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: signature block, key value, prose
scenario: the pricing page, needs a new owner
⟬text⟭
Objet : Page des tarifs du site, recherche d'un nouveau responsable

Madame, Monsieur,

La page des tarifs de nos consultations n'a plus de responsable depuis le départ en retraite de la personne qui en avait la charge.
Les tarifs publiés doivent être mis à jour à chaque révision de la convention, et la dernière mise à jour date du ⟬date#1⟭.

Nous cherchons un service capable de reprendre ce suivi.
La tâche représente quelques heures par an :

- recueillir les tarifs auprès de la direction financière ;
- les faire valider par le service juridique ;
- demander la publication à l'équipe web.

Le service qualité serait le candidat naturel, mais il n'a pas encore donné son accord.
Sans réponse d'ici la fin du mois, le sujet sera porté à la prochaine réunion de direction.

Merci de nous faire part de vos propositions.

Cordialement,

Service communication
Centre hospitalier de ⟬city#1⟭
Standard : ⟬phone#1⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: HR
appearance: ticket fields, code block, test fixture, comment thread
scenario: the CI pipeline, breaks for a single team
⟬text⟭
⟬ticket_id#1⟭ | CI : le job test-paie échoue seulement pour l'équipe Paie

Statut : À faire
Priorité : Haute
Composant : intégration continue
Rapporteur : ⟬trap:indicator_non_pii|équipe Paie⟭
Assigné à : ⟬trap:indicator_non_pii|équipe Plateforme⟭

## Description

Depuis lundi, le job `test-paie` échoue sur toutes les branches de l'équipe Paie.
Les autres équipes passent le même job sans problème, sur le même code.
Seule différence connue : l'équipe Paie utilise son propre runner, dédié aux traitements longs.

## Erreur observée

```
UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 41
tests/test_courriers.py::test_message_salarie FAILED
```

## Fixture concernée

Le test reprend tel quel un message reçu par le service paie, pour vérifier l'analyse des accents.
Voici le contenu de la fixture :

```
Bonjour, ici ⟬person_name#1⟭. Je n'ai pas reçu mon bulletin de paie.
Il est sans doute parti à mon ancienne adresse, la nouvelle est ⟬fr_postal_address#1⟭.
Merci de corriger cela avant la fin du mois.
```

## Analyse

Le runner dédié a été réinstallé la semaine dernière, sans la variable `LANG`.
Python lit donc les fichiers en ASCII sur ce runner.
Les runners partagés gardent leur configuration d'origine.

## Reproduction

1. Lancer `env -i python -m pytest tests/test_courriers.py`.
2. Constater la même erreur.
3. Ajouter `LANG=fr_FR.UTF-8` et constater que le test passe.

## Correctif proposé

- Définir `LANG` dans l'image du runner.
- Ouvrir tous les fichiers de fixtures avec un encodage explicite.
- Remplacer cette fixture par un message inventé : celle-ci vient d'un vrai courrier.

## Commentaires

[équipe Plateforme] Confirmé, le runner a perdu sa configuration lors de la réinstallation.

[équipe Paie] Cela bloque la livraison de la clôture du mois. Merci de traiter en priorité.

[équipe Sécurité] Nous prenons le sujet de la fixture : un vrai message n'a rien à faire dans le dépôt.

[équipe Plateforme] L'image corrigée est prête, déploiement ce soir.

## Critères de fin

- Le job `test-paie` passe sur le runner dédié.
- La fixture ne contient plus aucune donnée réelle.
- L'historique du dépôt est purgé de cette fixture.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: public administration
appearance: wiki sections, table, code identifier, library
scenario: the dependency upgrade, gets a cost review
⟬text⟭
Revue des coûts de la montée de versions

Cette page chiffre la montée de versions des dépendances du portail de démarches.
Les paquets concernés arrivent en fin de support dans les douze prochains mois.
Le chiffrage sert à arbitrer entre une montée groupée et une montée paquet par paquet.

Paquets concernés

| Paquet | Version actuelle | Version cible | Charge |
|---|---|---|---|
| ⟬trap:library|Django⟭ | ⟬version#1⟭ | ⟬version#2⟭ | 15 jours |
| ⟬trap:library|Celery⟭ | ⟬version#3⟭ | ⟬version#4⟭ | 5 jours |
| ⟬trap:library|Jinja⟭ | ⟬version#5⟭ | ⟬version#6⟭ | 2 jours |
| ⟬trap:library|Pandas⟭ | ⟬version#7⟭ | ⟬version#8⟭ | 4 jours |
| ⟬trap:library|Sphinx⟭ | ⟬version#9⟭ | ⟬version#10⟭ | 1 jour |

Méthode de chiffrage

Chaque paquet a été monté sur une branche d'essai, puis les tests ont été lancés.
La charge correspond au temps nécessaire pour faire repasser tous les tests.
Une marge de 30 % couvre les effets de bord constatés en recette.

Zones à risque

Le gros du travail se concentre dans trois modules.

Le premier est `⟬trap:code_identifier|⦃family⦄_workflow.py⟭`, qui repose sur une ancienne interface de transitions.
Le deuxième est la classe `⟬trap:code_identifier|⦃Family2⦄Serializer⟭`, héritée d'un prestataire, qui surcharge presque tout le cadre.
Le troisième est la fonction `⟬trap:code_identifier|compute_⦃family3⦄_delay⟭`, qui calcule les délais légaux et n'a aucun test.

Algorithmes à revalider

La nouvelle version change l'implémentation de certains calculs.
Le dédoublonnage des usagers utilise une distance de ⟬trap:eponym|Levenshtein⟭ et doit garder les mêmes seuils.
La répartition des dossiers entre agents suit une loi de ⟬trap:eponym|Poisson⟭, recalculée à chaque cycle.
Le routage des tournées de contrôle s'appuie sur l'algorithme de ⟬trap:eponym|Dijkstra⟭.
Le tirage aléatoire des contrôles a posteriori repose sur une transformation de ⟬trap:eponym|Box-Muller⟭, dont il faut vérifier la graine.

Scénarios

Scénario A, montée groupée : 27 jours en un seul lot, avec une recette complète.
Le risque est concentré et le gel fonctionnel dure six semaines.

Scénario B, montée paquet par paquet : 38 jours répartis sur deux trimestres.
Le risque est étalé, mais il faut maintenir une compatibilité entre deux versions pendant la transition.

Scénario C, report : aucun coût immédiat, mais fin du support de sécurité.
Ce scénario est écarté par le RSSI.

Comparaison

| Critère | A | B | C |
|---|---|---|---|
| Charge | 27 jours | 38 jours | 0 |
| Gel fonctionnel | 6 semaines | aucun | aucun |
| Risque en production | élevé | moyen | très élevé |
| Support de sécurité | oui | oui | non |

Recommandation

Le scénario A est recommandé si le gel peut être placé hors période de déclaration.
Sinon, le scénario B reste acceptable.

Suites

Le chiffrage sera présenté au comité de pilotage du numérique.
Les branches d'essai restent disponibles jusqu'à l'arbitrage.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: bullet list, key value
scenario: the load test, fails after an upgrade
⟬text⟭
Test de charge de la recherche produit

Le test échoue depuis la mise à jour du moteur, avec des erreurs 401 sur l'injecteur.

Mise en place de l'injecteur :

- Cible : ⟬url#1⟭
- Jeton d'API : `⟬opaque_token#1⟭`
- Palier : 500 requêtes par seconde
- Rapport : ⟬file_path#1⟭

Le format de ce jeton a changé : il doit passer dans l'en-tête `X-Search-Key`.
⟬end⟭
