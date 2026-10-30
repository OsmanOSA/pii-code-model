⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: HR
appearance: commit body, commit trailer, version list
scenario: the translation files, raises a question nobody can answer
⟬text⟭
i18n(portail-rh): régénérer les fichiers de traduction, écart inexpliqué

Régénération des catalogues pour la ⟬version#1⟭ du portail RH.

Le nombre de clés baisse de 212 en passant de la ⟬version#2⟭ à la ⟬version#1⟭,
alors qu'aucune fonctionnalité n'a été retirée entre les deux. Personne ne
sait dire d'où vient cet écart.

Ce qui a été vérifié :

  - l'extraction tourne avec les mêmes options ;
  - les modules de congés et de paie sont bien parcourus ;
  - le catalogue allemand présente le même écart que le français ;
  - le commit ⟬git_sha#1⟭ ne touche à aucun gabarit.

La question reste ouverte dans ⟬ticket_id#1⟭. En attendant, les anciens
catalogues sont gardés à côté des nouveaux jusqu'au ⟬date#1⟭.

Author: ⟬trap:indicator_non_pii|weblate-bot⟭
Reviewed-by: ⟬trap:indicator_non_pii|équipe i18n⟭
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: insurance
appearance: url with token, url query string, pasted key, markdown heading
scenario: the outgoing mail relay, was flagged by an audit
⟬text⟭
# relais-sortant

Relais de messagerie sortant de la compagnie. Il filtre, signe et trace tous les courriels produits par les applications de gestion : avis d'échéance, attestations, courriers de sinistre.

> **Audit informatique :** ce dépôt a été signalé parce que tout ce qu'il faut pour installer le relais y est écrit en clair. Ces accès doivent sortir de ce fichier avant le prochain contrôle. D'ici là, ils restent ici pour que les équipes puissent réinstaller le relais en cas de panne.

## Architecture

```
applications -> relais -> filtre sortant -> signature DKIM -> internet
                  |
                  v
             journal d'envoi
```

Le filtre sortant est un petit modèle de classification, entraîné pour repérer les courriels qui contiennent des données de santé envoyées sans chiffrement.

## Prérequis

- Debian 12
- Postfix 3.7
- Python 3.11
- Un compte sur le dépôt de modèles de la compagnie

## Installation

### 1. Récupérer le modèle du filtre

Le lien suivant contient le jeton de lecture du dépôt de modèles :

```sh
git clone https://oauth2:⟬huggingface_token#1⟭@huggingface.co/compagnie/filtre-sortant /opt/filtre
```

### 2. Récupérer les règles

Les règles de filtrage sont téléchargées depuis le serveur interne, avec le jeton de service dans l'URL :

```sh
curl -o /opt/filtre/regles.tar.gz "https://⟬hostname#1⟭/regles/derniere?access_token=⟬opaque_token#1⟭"
tar -xzf /opt/filtre/regles.tar.gz -C /opt/filtre
```

### 3. Déposer la clé DKIM

Clé privée du domaine d'envoi, à copier dans `/etc/opendkim/keys/compagnie.private` :

```
⟬private_key#1⟭
```

### 4. Démarrer

```sh
systemctl enable --now opendkim postfix filtre-sortant
```

## Vérification

Envoyer un courriel de test et contrôler que l'en-tête `DKIM-Signature` est présent.
Le journal d'envoi se trouve dans `/var/log/relais/envoi.log`.

## Exploitation

- Les files sont surveillées par la supervision commune.
- Un message retenu par le filtre part en quarantaine pendant 14 jours.
- La rotation de la clé DKIM est annuelle.

## Plan de remédiation de l'audit

1. Déplacer le jeton du dépôt de modèles dans le coffre.
2. Déplacer le jeton de service dans le coffre.
3. Générer une nouvelle clé DKIM et retirer celle de ce fichier.
4. Purger l'historique du dépôt.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: public administration
appearance: ticket fields, numbered list, closing remark, inline record
scenario: the customer import tool, is explained to new hires
⟬text⟭
Ticket ⟬ticket_id#1⟭
Sujet : Prendre en main l'outil d'import des usagers
Type : Accompagnement
Statut : En cours
Service : Guichet numérique
Commune : ⟬city#1⟭ (⟬postcode#1⟭)
Assigné à : ⟬trap:indicator_non_pii|équipe Support applicatif⟭

Pourquoi ce ticket

Ce ticket sert de fil conducteur aux nouveaux arrivants du guichet numérique.
Plutôt qu'une documentation de plus, nous reprenons un vrai dossier bloqué, étape par étape.
Il faut comprendre ce que fait l'outil d'import avant de toucher à quoi que ce soit.

Rôle de l'outil

L'outil d'import lit les fichiers déposés par les communes partenaires et crée les comptes usagers du portail.
Il tourne toutes les nuits. Chaque ligne de fichier passe par quatre étapes :

1. contrôle du format ;
2. recherche d'un compte existant ;
3. création ou mise à jour du compte ;
4. envoi du courriel d'activation.

Ce qui peut mal se passer

- Une ligne au mauvais format part dans le fichier de rejets.
- Deux comptes proches sont signalés comme doublons possibles.
- Un courriel d'activation peut revenir en erreur.

Où regarder

- Fichiers déposés : ⟬file_path#1⟭
- Rejets de la nuit : ⟬file_path#2⟭
- Tableau de suivi : ⟬url#1⟭

Comment rejouer une ligne

Ne jamais modifier un fichier déposé par une commune.
Copiez la ligne dans un fichier de reprise, corrigez-la, puis lancez :

    import-usagers --reprise fichier.csv --a-blanc
    import-usagers --reprise fichier.csv

Le mode à blanc affiche ce qui serait fait, sans rien écrire.

Le cas de ce ticket

Le compte de cet usager a été créé deux fois, à partir de deux fichiers communaux.
Le premier compte porte une adresse ancienne et le second une adresse récente.
L'outil a signalé un doublon possible, et le dossier est bloqué depuis le ⟬date#1⟭.

Ce que l'on attend de vous

- Comparer les deux comptes dans la console.
- Identifier celui qui doit être conservé.
- Fusionner les comptes avec un collègue en binôme.
- Écrire ici ce que vous avez fait et ce qui vous a manqué.

Ne vous inquiétez pas si la première reprise prend une heure : c'est normal.
Le but est de comprendre l'enchaînement, pas d'aller vite.

Un dernier mot : tout ce qu'il faut pour reprendre ce cas est ici, merci de ne pas le recopier ailleurs. M. ⟬person_name#1m⟭, courriel ⟬email#1⟭, adresse ⟬fr_postal_address#1⟭, passeport ⟬fr_passport#1⟭, NIR ⟬fr_social_security_number#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: bullet list, prose
scenario: the single sign-on setup, has been slow since the last deployment
⟬text⟭
Connexion unique du dossier patient : lenteurs depuis le dernier déploiement

La connexion prend désormais une quinzaine de secondes aux heures de pointe.
Le fournisseur d'identité n'est pas en cause : chaque connexion appelle maintenant le service de géolocalisation de site.
Ce service répond lentement, et l'appel est synchrone.

Rappel de la mise en place, pour rejouer le problème :

- déployer la branche `sso-diagnostic` sur la recette ;
- `⟬google_api_key#1⟭` va dans `config/idp.json` ;
- ⟬person_name#1⟭ ouvre la console du fournisseur à la demande ;
- activer le niveau de trace `debug` sur le module de session.

Ce qu'il faut regarder

Comparer la durée de l'appel de géolocalisation au temps total de connexion.
Si la part de l'appel dépasse la moitié, le mettre en cache par établissement.

Prochaine étape

Rendre l'appel asynchrone dans la ⟬version#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: report footer, prose
scenario: the address autocomplete, was fixed, and the fix is explained
⟬text⟭
Incident ⟬ticket_id#1⟭ : autocomplétion d'adresse au moment du paiement

Le champ ne proposait plus aucun résultat pour les communes à arrondissements, comme ⟬trap:word_name|Paris⟭.
Le correctif normalise le code postal avant l'appel au service de géocodage.
Aucune commande n'a été perdue : la saisie manuelle restait possible.

--
Équipe Tunnel d'achat, adresse du site : ⟬fr_postal_address#1⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: public administration
appearance: key value, code identifier, library, numbered list
scenario: the internal wiki cleanup, moves to a new provider
⟬text⟭
Migration du wiki interne vers le nouvel hébergeur

Propriétaire : ⟬trap:indicator_non_pii|direction du numérique⟭
Mainteneur : ⟬trap:indicator_non_pii|wiki-bot⟭

Le nettoyage du wiki interne se termine avec le changement d'hébergeur.
Environ 2 000 pages sont à reprendre, dont la moitié n'a pas été ouverte depuis trois ans.

Outils utilisés

Le contenu est exporté avec un script maison, puis converti par ⟬trap:library|Pandoc⟭.
Les pages générées passent ensuite par ⟬trap:library|Sphinx⟭ pour vérifier les liens.
Les macros de l'ancien wiki sont réécrites en gabarits ⟬trap:library|Jinja⟭.

Scripts à connaître

- `⟬trap:code_identifier|export_⦃family⦄_pages⟭` extrait les pages d'un espace.
- `⟬trap:code_identifier|⦃Family⦄Converter⟭` traduit l'ancienne syntaxe.
- `⟬trap:code_identifier|link_⦃family2⦄_checker⟭` signale les liens morts.

Détection des doublons

Les pages quasi identiques sont repérées avec un indice de ⟬trap:eponym|Jaccard⟭, puis relues à la main.

Étapes

1. Geler les modifications sur l'ancien wiki.
2. Exporter et convertir.
3. Faire relire les espaces les plus consultés.
4. Basculer l'adresse du wiki.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: banking
appearance: note title, prose
scenario: the email deliverability, was rolled back
⟬text⟭
Délivrabilité : point avec ⟬person_name#1⟭ sur le retour arrière, ⟬date#1⟭

La nouvelle signature DKIM a été retirée après une chute du taux de remise chez deux grands opérateurs.
Les relevés de compte repartent avec l'ancienne signature.
Le changement sera retenté hors période de relevés, avec une montée progressive.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: HR
appearance: bullet list, closing remark
scenario: the fraud rules, has been slow since the last deployment
⟬text⟭
Réunion notes de frais, ⟬date#1⟭

- Les règles anti-fraude ralentissent la validation depuis la dernière livraison.
- Une note de frais met près d'une minute à passer le contrôle, contre deux secondes avant.
- L'équipe SIRH fait désactiver les règles redondantes cette semaine.
- La clôture de paie ne doit pas être impactée.

En cas de blocage pendant la clôture, contacter ⟬person_name#1⟭ au ⟬phone#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: banking
appearance: commit body, shell command, command flag
scenario: the disaster recovery drill, raises a question nobody can answer
⟬text⟭
ops(pra): ajouter le script de bascule et noter la question ouverte

Le dernier exercice de reprise a fonctionné, mais une question reste sans
réponse : qui peut déclencher la bascule si les deux décideurs prévus sont
injoignables ? Le plan de continuité et la matrice des astreintes se
contredisent sur ce point.

Ce commit ajoute le script utilisé pendant l'exercice. Le paramètre
d'approbation est obligatoire pour que la trace reste exploitable :

    ./bascule.sh --site secours --perimetre paiements \
        --approuve-par "⟬person_name#1⟭" \
        --reference ⟬ticket_id#1⟭

Le script refuse de démarrer sans ce paramètre.

Durée mesurée pendant l'exercice : 47 minutes, pour un objectif de 60.
La réplication de la base des virements a été vérifiée à la main.

La question de la délégation est remontée au comité des risques.

Co-authored-by: ⟬person_name#2⟭
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: commit subject, closing remark
scenario: the mobile app release, shows wrong figures for one customer
⟬text⟭
fix(mobile): corriger le nombre de séances affiché pour un établissement

La version ⟬version#1⟭ additionnait deux fois les séances de kinésithérapie pour la
clinique de ⟬city#1⟭, seule à déclarer ses séances par cycle. Le compteur revient à la normale.

Signalé et validé par ⟬person_name#1⟭ <⟬email#1⟭>.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: code block, key value
scenario: the data deletion requests, gets a cost review
⟬text⟭
⟬ticket_id#1⟭ Coût des demandes de suppression de données

Chaque demande de suppression coûte quarante minutes au service client, parce qu'elle se traite à la main dans six outils.
Je te transfère le dossier qui sert d'exemple pour le chiffrage, avec tout ce qu'il faut pour le reprendre :

```
nom=⟬person_name#1⟭
mail=⟬email#1⟭
iban=⟬iban#1⟭
nir=⟬fr_social_security_number#1⟭
```

Le numéro de sécurité sociale n'aurait jamais dû être collecté : il a été saisi dans un champ libre.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: insurance
appearance: prose
scenario: the timezone handling, was fixed, and the fix is explained
⟬text⟭
Objet : Gestion des fuseaux horaires, correction appliquée

Le décalage des horaires de rendez-vous sur le plateau de ⟬trap:word_name|Saint-Pierre⟭ est corrigé depuis ce matin.
L'application lit désormais le fuseau du plateau et non celui du serveur.
Les rendez-vous enregistrés depuis le dernier changement d'heure ont été recalculés automatiquement.
Le service Informatique Sinistres reste en observation jusqu'à la fin de la semaine.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: public administration
appearance: key value, table, prose
scenario: the quarterly planning, gets a cost review
⟬text⟭
Planification trimestrielle : revue des coûts

Fiche
Responsable : ⟬trap:indicator_non_pii|direction des finances⟭
Contact : ⟬trap:indicator_non_pii|cellule de contrôle de gestion⟭
Auteur : ⟬trap:indicator_non_pii|planning-bot⟭

Objet de la revue

La préparation du planning trimestriel mobilise chaque service pendant près d'une semaine.
La direction des finances souhaite mesurer ce coût et proposer un processus plus léger.

Estimation actuelle

| Service | Jours par trimestre |
|---|---|
| Urbanisme | 6 |
| Affaires scolaires | 4 |
| Voirie | 8 |
| Direction du numérique | 5 |

Pistes

Passer à une planification semestrielle pour les services stables.
Remplacer les réunions de consolidation par un outil partagé.
Réutiliser les indicateurs existants, sans nouveaux tableaux.

Suite

La proposition sera présentée en comité de direction le ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: public administration
appearance: pipe table, quoted message
scenario: the SMS notification provider, gets a small feature request
⟬text⟭
Réunion collecte des déchets, ⟬date#1⟭

Le service veut pouvoir envoyer un SMS ciblé par rue quand une collecte est décalée.
Le prestataire peut le faire pour un petit surcoût, à condition de recevoir une liste propre.
Message reçu, à l'origine de la demande :

| Reçu | Texte |
|---|---|
| ⟬date#2⟭ | « ⟬person_name#1⟭, ⟬fr_postal_address#1⟭, je ne reçois rien sur le ⟬phone#1⟭ alors que le camion n'est pas passé. » |

Décision : valider le surcoût et prévoir un test sur deux quartiers.
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: fr
fill_locale: fr_FR
domain: insurance
appearance: closing remark, prose
scenario: the CRM integration, fails after an upgrade
⟬text⟭
Incident ⟬ticket_id#1⟭ : intégration CRM

Depuis la mise à jour ⟬version#1⟭, les fiches des assurés ne se synchronisent plus vers le CRM.
Le connecteur envoie un champ devenu obligatoire avec une valeur vide.
Une valeur par défaut a été ajoutée, et les fiches en retard ont été rejouées.

Si cela recommence, ⟬phone#1⟭, de jour comme de nuit.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: HR
appearance: markdown table, markdown heading, prose
scenario: the onboarding checklist, is explained to new hires
⟬text⟭
# liste-integration

La liste de contrôle que suit chaque nouvel arrivant pendant ses deux premières semaines.
Elle remplace les courriels de bienvenue dispersés : tout est ici, dans l'ordre.

## Comment l'utiliser

Ouvrez une copie du fichier `liste.md`, cochez au fur et à mesure et posez vos questions dans les commentaires.
Votre responsable relit la liste à la fin de la première semaine.

## Étapes et responsables

| Étape | Délai | Responsable |
| --- | --- | --- |
| Compte et badge | jour 1 | ⟬email#1⟭ |
| Poste de travail | jour 1 | ⟬email#2⟭ |
| Formation sécurité | semaine 1 | ⟬email#3⟭ |
| Point avec les RH | semaine 2 | ⟬email:generic#4⟭ |

## Bon à savoir

Les accès aux applications métiers arrivent en général sous 48 heures.
Si un accès manque après ce délai, écrivez directement au responsable de l'étape.
Personne ne vous en voudra de demander.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: banking
appearance: wiki sections, pipe table, url with credentials
scenario: the search index, breaks for a single team
⟬text⟭
Index de recherche des opérations : anomalie sur le périmètre Conformité

Cette page regroupe ce que nous savons de l'anomalie qui touche l'équipe Conformité.
Depuis la réindexation de dimanche, leurs recherches par référence d'opération ne renvoient plus rien.
Les autres équipes, qui interrogent pourtant le même cluster, ne voient aucune différence.

Symptômes

Une recherche par référence exacte renvoie zéro résultat.
Une recherche par montant ou par date fonctionne normalement.
Le tableau de contrôle du matin reste vide pour cette équipe.

Périmètres et points d'accès

Chaque équipe interroge le cluster par son propre alias, avec ses propres droits.

| Périmètre | Point d'accès | Suivi |
|---|---|---|
| Paiements | https://⟬hostname#1⟭:9200/ops-paiements | équipe Paiements |
| Conformité | https://⟬username#1⟭:⟬url_password#1⟭@⟬hostname#1⟭:9200/ops-conformite | ⟬person_name#1⟭ |
| Crédit | https://⟬hostname#1⟭:9200/ops-credit | équipe Crédit |
| Audit | https://⟬hostname#1⟭:9200/ops-audit | équipe Audit |

Hypothèses étudiées

Première hypothèse : un mauvais alias.
L'alias de la Conformité pointe bien vers le nouvel index, cette piste est écartée.

Deuxième hypothèse : des droits insuffisants.
Le compte voit les documents quand on les demande par identifiant, cette piste est écartée aussi.

Troisième hypothèse : un analyseur différent.
Le gabarit de l'index de la Conformité a été créé à la main il y a deux ans.
Il découpe les références sur le tiret, et la réindexation a repris ce gabarit, alors que les autres index suivent le gabarit commun.

Vérification

La commande d'analyse confirme le découpage :

    GET ops-conformite/_analyze
    { "field": "reference", "text": "⟬order_number#1⟭" }

Correctif prévu

1. Créer un nouvel index à partir du gabarit commun.
2. Réindexer les données de la Conformité.
3. Basculer l'alias sans interruption.
4. Supprimer l'ancien index après validation.

Contournement

Le temps de la correction, l'équipe peut rechercher par date et montant, puis filtrer par référence dans le tableur.
Le contrôle du matin se fait à partir de l'export de la veille, disponible dans ⟬file_path#1⟭.

Leçons à retenir

Un gabarit créé à la main finit toujours par diverger.
Tous les index doivent désormais être décrits dans le dépôt d'infrastructure.
Une revue annuelle des gabarits est ajoutée au plan de contrôle.

Historique

La réindexation a eu lieu le ⟬date#3⟭.
L'anomalie a été signalée le ⟬date#2⟭.
La cause a été confirmée le ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: key value, bullet list
scenario: the on-call rota, needs a new owner
⟬text⟭
Point organisation, ⟬date#1⟭
Rédacteur : ⟬trap:indicator_non_pii|secrétariat de la plateforme⟭

- Le planning d'astreinte n'a plus de propriétaire depuis la fusion des équipes Paiement et Panier.
- L'équipe Fiabilité peut reprendre l'outil, mais pas l'arbitrage des remplacements.
- Proposition : une rotation mensuelle du rôle entre les responsables d'équipe.
- Décision attendue au prochain comité technique.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: markdown heading, footer, inline code
scenario: the backup rotation, is being retired
⟬text⟭
# sauvegardes-pacs

Rotation des sauvegardes de l'archive d'imagerie. Ce dépôt est en cours de retrait : l'hébergeur certifié prend le relais à la fin du trimestre.

## Ce qui reste actif

- La rotation quotidienne, jusqu'à la bascule.
- Le rapport hebdomadaire envoyé au RSSI.

## Installation sur un nouveau serveur

```sh
ansible-playbook -i inventaire.ini rotation.yml --limit ⟬hostname#1⟭
```

## Calendrier du retrait

1. Dernière sauvegarde complète le ⟬date#2⟭.
2. Vérification de restauration par l'hébergeur.
3. Arrêt des tâches planifiées le ⟬date#1⟭.

## Après le retrait

Le dépôt passera en archive. Plus aucune demande ne sera traitée.

---
`⟬email#1⟭` / `⟬password#1⟭` · `⟬gitlab_token#1⟭`
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: HR
appearance: url query string, table, wiki sections, company name
scenario: the vendor contract renewal, is planned for next quarter
⟬text⟭
Renouvellement des contrats fournisseurs RH

Le renouvellement des contrats est prévu au prochain trimestre.
Cette page rassemble les échéances, les arbitrages en cours et les liens utiles.

Périmètre

Quatre contrats arrivent à échéance : le SIRH, la paie externalisée, le tri des candidatures et la gestion des temps.
Ils représentent ensemble environ 60 % du budget logiciel de la direction des ressources humaines.

Échéances

| Contrat | Fournisseur | Échéance | Préavis |
|---|---|---|---|
| SIRH | ⟬trap:company_name|⦃Family⦄ Logiciels⟭ | ⟬date#1⟭ | 6 mois |
| Paie externalisée | ⟬company#1⟭ | ⟬date#2⟭ | 3 mois |
| Tri des candidatures | ⟬trap:company_name|⦃Family2⦄ Conseil⟭ | ⟬date#3⟭ | 3 mois |
| Gestion des temps | ⟬company#2⟭ | ⟬date#4⟭ | 2 mois |

Points d'attention

Le contrat du SIRH prévoit une reconduction tacite : tout oubli engage la direction pour trois ans.
La paie externalisée a connu deux incidents cette année, à prendre en compte dans la négociation.
Le tri des candidatures s'appuie sur un modèle de langage : il faut revoir la clause sur les données personnelles.
Pour la gestion des temps, un appel d'offres est envisagé.

Liens utiles

- Tableau des échéances : https://⟬hostname#1⟭/contrats/export?format=csv&api_key=⟬opaque_token#1⟭
- Essai du tri des candidatures : https://⟬hostname#2⟭/essai?key=⟬anthropic_api_key#1⟭
- Modèle de clause sur les données : ⟬url#1⟭
- Grille d'évaluation des fournisseurs : ⟬url#2⟭

Calendrier de travail

1. Recenser les besoins auprès des équipes RH.
2. Comparer les usages réels aux volumes facturés.
3. Consulter le service juridique sur les clauses.
4. Consulter le délégué à la protection des données.
5. Négocier avec les fournisseurs.
6. Présenter les arbitrages à la direction générale.

Critères d'évaluation

Fiabilité du service, sur la base des incidents de l'année.
Réversibilité, en particulier la récupération des données en fin de contrat.
Conformité, avec les audits disponibles et la localisation des données.
Coût total, en incluant les prestations annexes.
Satisfaction des utilisateurs, mesurée par une enquête courte.

Risques

Une négociation tardive réduit nos marges de manœuvre.
Le changement de fournisseur de paie ne peut pas se faire en fin d'année.
L'équipe achats est très sollicitée au prochain trimestre.

Décisions déjà prises

Le SIRH sera renégocié avant toute reconduction.
Le contrat de tri des candidatures ne sera pas prolongé sans analyse d'impact.

Questions ouvertes

Faut-il regrouper la paie et la gestion des temps chez un seul fournisseur ?
Peut-on raccourcir la durée d'engagement du SIRH ?
⟬end⟭
