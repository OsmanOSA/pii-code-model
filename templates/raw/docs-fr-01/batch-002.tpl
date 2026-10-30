⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: ticket fields, bullet list, prose
scenario: the penetration test findings, is planned for next quarter
⟬text⟭
Ticket ⟬ticket_id#1⟭ : planifier le traitement des constats du test d'intrusion
Type : Tâche
Priorité : Haute
Demandeur : ⟬trap:indicator_non_pii|équipe Sécurité SI⟭
Assigné à : ⟬trap:indicator_non_pii|équipe Plateforme⟭
Créé le : ⟬date#2⟭
Échéance : ⟬date#1⟭

Description
Le prestataire a rendu son rapport sur le portail des résultats d'examens.
Aucun constat critique, mais quatre constats élevés doivent être traités au prochain trimestre.

Constats à planifier
- Absence de limitation sur la page de connexion des laboratoires.
- En-têtes de sécurité incomplets sur l'interface d'administration.
- Version obsolète du serveur d'application sur la préproduction.
- Journalisation insuffisante des actions d'administration.

Critères d'acceptation
- Chaque constat a une équipe porteuse et une date cible.
- Le contre-test est commandé au prestataire.
- Le comité de sécurité valide le plan avant le début du trimestre.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: banking
appearance: closing remark, inline record
scenario: the archive of old tickets, needs a new owner
⟬text⟭
Objet : Archive des anciens tickets, repreneur à désigner

Madame, Monsieur,

L'archive des anciens tickets du support n'a plus de propriétaire depuis la réorganisation du service.
L'export préparatoire à sa reprise plante toujours sur le même enregistrement, qui bloque le lot entier.
Sans repreneur désigné d'ici la fin du mois, l'archive restera en lecture seule.

Dernière précision pour reproduire l'erreur, la fiche est copiée telle quelle du back-office : M. ⟬person_name#1m⟭, tél. ⟬phone#1⟭, CNI ⟬fr_identity_card#1⟭, permis ⟬fr_driving_licence#1⟭, IBAN ⟬iban#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: public administration
appearance: markdown heading, environment file, footer, table
scenario: the quarterly access review, was flagged by an audit
⟬text⟭
# revue-acces

Préparation de la revue trimestrielle des accès aux applications de la collectivité.

L'audit de la chambre régionale a relevé que les revues n'étaient ni tracées ni complètes : des comptes d'agents partis restaient actifs d'un trimestre à l'autre. Ce dépôt automatise l'extraction des droits et l'envoi des demandes de validation aux chefs de service.

## Ce que fait l'outil

1. Lit les droits dans l'annuaire et dans chaque application métier.
2. Rapproche les comptes de la liste des agents en poste.
3. Produit un fichier par service, avec les comptes à confirmer.
4. Envoie à chaque chef de service un lien vers son fichier.
5. Archive les réponses pour la prochaine visite de l'audit.

## Prérequis

- Python 3.11
- Accès en lecture à l'annuaire
- Un compte de service par application métier

## Installation

```sh
python -m venv .venv
.venv/bin/pip install -e .
cp exemple.env .env
```

## Configuration

Les variables se placent dans `.env`, jamais dans le dépôt :

| Variable | Rôle |
| --- | --- |
| `LDAP_URL` | annuaire des agents |
| `LDAP_BIND_DN` | compte de lecture |
| `REVUE_TRIMESTRE` | trimestre à traiter |
| `SMTP_RELAY` | relais de secours |

La clé d'envoi des courriels est donnée à la fin de ce fichier.

## Utilisation

```sh
revue extract --trimestre courant
revue compare
revue send --dry-run
revue send
```

## Après la campagne

Les chefs de service ont dix jours ouvrés pour répondre. Une relance part automatiquement à mi-parcours. Les non-réponses remontent au directeur général des services.

## Points relevés par l'audit

- Les comptes génériques n'ont pas de responsable nommé.
- Les droits d'administration ne sont revus qu'une fois par an.
- Les preuves de revue ne sont pas horodatées.

Le premier et le troisième point sont traités par cette version. Le deuxième attend la décision du comité de sécurité.

## Tests

```sh
pytest -q
```

Les tests utilisent un annuaire fictif, sans donnée d'agent.

---

Mainteneur : ⟬person_name#1m⟭, direction du numérique. Clé SendGrid du projet, à reporter dans `.env` : `⟬sendgrid_api_key#1⟭`
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: HR
appearance: markdown heading, closing remark, pasted key
scenario: the nightly data export, needs a temporary workaround
⟬text⟭
### Objet

L'export nocturne vers le prestataire de paie échoue depuis que le prestataire a changé de serveur SFTP.
Cette PR met en place un contournement temporaire, le temps que la nouvelle empreinte d'hôte soit validée.

### Changements

- ajout d'un dossier de reprise pour les fichiers non transmis ;
- nouvelle tentative à 6 h si l'envoi de 2 h échoue ;
- alerte vers le canal de l'équipe SIRH après deux échecs.

### Tests

Testé à la main sur la recette, avec un faux serveur SFTP.
Le fichier de la DSN n'est pas concerné par ce changement.

### À retirer

Ce contournement sera supprimé avec ⟬ticket_id#1⟭.

Une dernière chose : je n'ai pas retiré du gabarit la clé privée utilisée pour mes essais, la voici telle qu'elle est dans `fixtures/sftp_test.pem` :

⟬private_key#1⟭
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: markdown bullet, url query string
scenario: the accessibility audit, moves to a new provider
⟬text⟭
## Pourquoi

Le contrat du prestataire d'audit d'accessibilité s'arrête à la fin du trimestre.
Cette PR bascule les contrôles automatiques du tunnel de commande chez le nouveau fournisseur.

## Changements

- remplacement du client de l'ancien service par l'API du nouveau fournisseur ;
- ajout d'un budget d'erreurs RGAA dans la CI ;
- anciens rapports toujours consultables sur https://⟬hostname#1⟭/rapports/dernier?s=⟬jwt#1⟭ ;
- les alertes de l'ancien service partent encore vers ⟬email#2⟭, à couper après la bascule ;
- suppression des captures d'écran de référence, régénérées par le nouveau service.

## À relire en priorité

Le mappage des niveaux de gravité : l'ancien service en avait trois, le nouveau en a cinq.
Les deux niveaux intermédiaires sont traités comme bloquants pour l'instant.

## Risques

Le premier passage va remonter beaucoup d'anomalies déjà connues.
Elles seront reversées dans le backlog de l'équipe Front avant d'activer le blocage en CI.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: public administration
appearance: first paragraph record, numbered list, prose
scenario: the document upload service, has been slow since the last deployment
⟬text⟭
Objet : Lenteurs du dépôt de pièces, dossier à reprendre

Je te confie la reprise du dossier de ⟬person_name#1m⟭ (⟬email#1⟭, ⟬fr_tax_number#1⟭, ⟬birth_date#1⟭), bloqué depuis le dernier déploiement du service de dépôt de pièces. Je pars vendredi et je préfère que tout soit dans un seul message.

Voici où en est la situation.

Le service de dépôt de pièces du téléservice d'aides est lent depuis la mise en production de la ⟬version#1⟭.
Un justificatif de deux pages met maintenant près de quatre minutes à passer, contre vingt secondes avant.
Au-delà de cinq minutes, le portail coupe la connexion et l'usager doit tout recommencer.

Ce que nous savons :

1. Le ralentissement vient de l'étape d'antivirus, qui analyse désormais chaque page séparément.
2. Le stockage objet répond normalement.
3. La file de conversion en PDF n'est pas saturée.
4. Le problème touche tous les usagers, mais ceux qui joignent plusieurs pièces sont bloqués.

Ce qui rend ce dossier particulier :

Il a déjà tenté onze fois de déposer son dossier d'aide au logement.
Chaque échec a créé un brouillon, et le contrôle des doublons refuse maintenant toute nouvelle demande.
Le délai de recours expire dans dix jours, ce qui explique que le cabinet du maire ait été saisi.

Ce que j'ai déjà fait :

- purge des brouillons en recette, pour vérifier la procédure ;
- demande de passage en priorité auprès de l'équipe d'exploitation ;
- réponse d'attente envoyée à son adresse le ⟬date#2⟭.

Ce qu'il reste à faire :

- purger les brouillons en production, avec l'accord du responsable de traitement ;
- déposer les pièces à sa place depuis le guichet, ce que le règlement permet ;
- rapprocher le numéro fiscal avec les services des impôts.

Sur ce dernier point, attention. Le rapprochement compare le numéro fiscal et la date de naissance.
La date entre parenthèses, en tête de ce message, est sa date de naissance telle que connue du portail.
La pièce d'identité porte un jour différent : il faudra la corriger avant de relancer le contrôle.

Ce que je lui ai répondu jusqu'ici :

Je lui ai indiqué que le service rencontrait des difficultés et que son délai de recours serait préservé.
Je ne lui ai donné aucune date de correction, car nous n'en avions pas.
Il a rappelé deux fois le standard, qui a noté ses appels dans le fil du dossier.
Le service juridique confirme qu'un dépôt au guichet vaut dépôt en ligne.

Point de vigilance sur les pièces :

Les pièces déjà transmises sont dans le dossier partagé du pôle.
Ne les renvoie pas par courriel : elles contiennent des données fiscales.

Pour le fond du problème, l'équipe d'exploitation propose deux pistes :

- regrouper les pages avant l'analyse antivirus ;
- augmenter le délai du portail à dix minutes, en attendant.

La seconde piste peut être déployée dès cette semaine.
La première demande un développement et passera au prochain lot, prévu autour du ⟬date#1⟭.

Je t'ai mis en copie de la note adressée au directeur des services.
Si tu as un doute, le plus simple est d'appeler l'équipe d'exploitation : ils connaissent le sujet.

Merci d'avance de ta reprise, et bon courage pour la fin de semaine.

Le pôle Instruction
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: banking
appearance: table, commit trailer, handle
scenario: the cookie banner, gets a cost review
⟬text⟭
## Revue des coûts du bandeau cookies

Notre outil de gestion du consentement est facturé au nombre de visites, et le passage à la banque en ligne unifiée a triplé la facture.
Cette PR ne change pas le bandeau : elle ajoute le comparatif demandé par les achats et un petit module de mesure.

## Comparatif

| Option | Coût annuel | Reprise des consentements |
| --- | --- | --- |
| Rester chez l'éditeur actuel | élevé | sans objet |
| Autre éditeur | moyen | à refaire |
| Bandeau interne | faible | à refaire, charge de maintenance |

## Changements

- mesure du nombre d'affichages réels du bandeau ;
- export mensuel vers le contrôle de gestion ;
- aucun cookie supplémentaire déposé.

## Points d'attention

Le service conformité doit valider toute modification du texte du bandeau.

Reported-by: ⟬person_name#1⟭
Reviewed-by: @⟬person_name:handle#2⟭
Approved-by: ⟬person_name:initial#3⟭
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: insurance
appearance: email header, key value
scenario: the mobile push notifications, breaks for a single team
⟬text⟭
Objet : Notifications mobiles indisponibles pour l'équipe Indemnisation

Bonjour ⟬trap:indicator_non_pii|équipe Indemnisation⟭,

Vos collègues ne reçoivent plus les notifications de l'application mobile, alors que les autres équipes ne sont pas touchées.
Le groupe de diffusion de votre équipe a été recréé lors de la réorganisation et n'est plus abonné au canal d'envoi.
Un correctif est en cours côté plateforme.

Émetteur des notifications : ⟬trap:indicator_non_pii|notif-bot⟭
Contact : ⟬trap:indicator_non_pii|support mobile N2⟭
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: public administration
appearance: numbered list, closing remark, key value
scenario: the search index, has been slow since the last deployment
⟬text⟭
Comité de suivi du moteur de recherche du site de la ville
Séance du ⟬date#2⟭

Participants : ⟬trap:indicator_non_pii|direction du numérique, prestataire d'hébergement, service communication⟭

1. État des lieux
Depuis le dernier déploiement, une recherche prend en moyenne six secondes, contre moins d'une seconde auparavant.
Le service communication reçoit des plaintes sur les démarches introuvables.

2. Analyse
L'index a doublé de taille après l'ajout des délibérations numérisées.
Le prestataire indique que la réindexation complète tourne désormais en journée.
Le moteur ⟬trap:library|Lucene⟭ sous-jacent n'a pas été réglé pour ce volume.

3. Décisions
La réindexation passe de nuit. Les délibérations de plus de dix ans sortent de l'index principal.
Un test de performance sera mené avant la prochaine séance.

Pour clore : la prochaine séance, le ⟬date#1⟭, aura lieu à l'annexe, adresse ⟬fr_postal_address#1⟭. Accueil par ⟬person_name#2⟭.
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: fr
fill_locale: fr_FR
domain: HR
appearance: report sections, code identifier, library, key value
scenario: the vendor contract renewal, needs a new owner
⟬text⟭
Rapport d'incident ⟬ticket_id#1⟭
Application : outil de gestion des temps
Propriétaire du contrat : ⟬trap:indicator_non_pii|non désigné⟭
Rédacteur : ⟬trap:indicator_non_pii|équipe Exploitation⟭

Résumé
Le contrat de l'éditeur de l'outil de gestion des temps n'a pas été renouvelé à temps.
La licence a expiré et les pointages ont été refusés pendant toute une matinée.

Déroulé
L'échéance figurait dans un rappel automatique envoyé à une boîte de service qui n'est plus relevée.
Le job ⟬trap:library|Jenkins⟭ de contrôle des licences s'est arrêté il y a six mois.
Le script ⟬trap:code_identifier|check_⦃family⦄_licence⟭ tournait sur ce job et personne n'a vu l'alerte.

Analyse
L'application a suivi un scénario connu : rien ne casse tant que la licence est valide, puis tout casse d'un coup.
Une petite application de la loi de ⟬trap:eponym|Murphy⟭, en quelque sorte.
L'échéancier interne repose sur une feuille de calcul, dont le module ⟬trap:library|Pandas⟭ produit un rapport que plus personne ne lit.

Actions
- Désigner un nouveau propriétaire pour le contrat.
- Remettre en service le contrôle des licences.
- Rediriger la boîte de service vers les achats.
- Prévenir l'éditeur trois mois avant chaque échéance.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: commit body, bullet list, shell command, commit trailer
scenario: the dependency upgrade, gets a small feature request
⟬text⟭
chore(deps): monter les dépendances DICOM, ajouter --dry-run

Mise à jour trimestrielle des dépendances de l'outil de synchronisation
des images du service de radiologie.

- ⟬trap:library|pydicom⟭ passe en ⟬version#1⟭, sans rupture d'interface ;
- le client de stockage passe en ⟬version#2⟭ ;
- ajout de l'option --dry-run, petite demande de ⟬person_name#2⟭ à l'imagerie ;
- commande d'essai à reprendre : dcm-sync --user ⟬email#1⟭ --password ⟬password#1⟭ --dry-run --study ⟬uuid#1⟭ ;
- la documentation d'installation est à jour.

L'option --dry-run liste les études qui seraient transférées, sans rien
envoyer. Elle évite d'occuper la bande passante du PACS en pleine vacation
pour simplement vérifier un filtre.

Aucun changement de format sur les fichiers exportés.

Testé sur la recette avec un lot de 40 études anonymisées.

Signed-off-by: ⟬person_name#1⟭ <⟬email#1⟭>
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: banking
appearance: revert commit, closing remark
scenario: the database migration, was rolled back
⟬text⟭
revert: annuler la migration 0142 des plafonds de virement

Annule le commit ⟬git_sha#1⟭.

La migration verrouillait la table des plafonds pendant plus de dix minutes,
ce qui bloquait les virements instantanés. Elle sera rejouée en deux temps.

Signalé en passant par ⟬person_name:family#1⟭, de l'équipe Paiements.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: insurance
appearance: ticket fields, prose
scenario: the single sign-on setup, was fixed, and the fix is explained
⟬text⟭
⟬ticket_id#1⟭ [SSO] Boucle de redirection sur l'extranet courtiers
Statut : Résolu
Rapporteur : ⟬trap:indicator_non_pii|sonde-synthetique-bot⟭
Assigné à : ⟬trap:indicator_non_pii|équipe IAM⟭

Cause : l'horloge du fournisseur d'identité avait dérivé de six minutes, au-delà de la tolérance du jeton SAML.
Correctif : synchronisation NTP rétablie et tolérance portée à deux minutes.
Vérifié sur ⟬hostname#1⟭ après redémarrage du service.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: banking
appearance: wiki sections, closing remark, key value
scenario: the report scheduler, shows wrong figures for one customer
⟬text⟭
Planificateur de rapports : chiffres erronés pour un client

Symptôme
Le relevé mensuel des encours du client ⟬customer_id#1⟭ affiche un total supérieur à la somme de ses lignes.
Les autres clients ne sont pas touchés.

Analyse en cours
Ce client a deux comptes dans deux devises différentes, et le planificateur additionne les soldes avant la conversion.
Le rapport est calculé par le module de consolidation, version ⟬version#1⟭.
Le défaut existe depuis l'ajout du multi-devises mais n'avait jamais été visible.

Correctif prévu
Déplacer la conversion avant l'agrégation, puis régénérer les trois derniers relevés.
Le client sera prévenu par son conseiller avant la nouvelle diffusion.

Environnement de test
Le planificateur de recette tourne sur ⟬hostname#1⟭.
Les rapports générés arrivent dans ⟬file_path#1⟭.

Pour finir, si vous devez rejouer le rapport en recette, le compte de test à utiliser est le suivant.
Identifiant : ⟬email#1⟭
Mot de passe : ⟬password#1⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: ticket fields, quoted chat, code block
scenario: the translation files, has been slow since the last deployment
⟬text⟭
Titre : Pages produit très lentes en espagnol depuis le dernier déploiement
Référence : ⟬ticket_id#1⟭
Canal : chat client
Composant : i18n

Le support a transmis ce message, copié depuis l'outil de chat :

```
[client] Bonjour, ⟬person_name#1⟭ à l'appareil. La fiche du produit met
vingt secondes à s'afficher quand je passe le site en espagnol. En français
tout va bien. J'ai essayé deux navigateurs.
[agent] Merci, nous transmettons au service technique.
```

Analyse rapide

Le fichier de traduction espagnol a été régénéré à la dernière livraison et pèse maintenant 14 Mo.
Il est rechargé en entier à chaque requête, car le cache de ⟬trap:library|Gettext⟭ ne reconnaît plus la clé de langue.

Reproduction

1. Ouvrir une fiche produit.
2. Changer la langue du site pour l'espagnol.
3. Mesurer le temps de réponse.

Attendu : moins d'une seconde. Obtenu : entre 15 et 25 secondes.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: commit body, url path, code block, commit trailer
scenario: the CDN configuration, needs a new owner
⟬text⟭
docs(cdn): décrire la configuration avant le changement de propriétaire

La configuration du CDN du portail patient n'a plus de propriétaire clair :
la personne qui la maintenait change de poste à la fin du mois et rien n'est
écrit. Ce commit ajoute la description complète de ce qui tourne aujourd'hui,
pour que le prochain responsable ne reparte pas de zéro.

Propriétaire sortant : https://⟬hostname#1⟭/annuaire/⟬person_name:handle#1⟭
Demande de reprise validée : https://⟬hostname#1⟭/validations/⟬uuid#1⟭?par=⟬person_name:handle#2⟭

Ce qui est documenté
--------------------

1. Les zones

   Trois zones sont en service : le site public, le portail patient et les
   ressources statiques. Seul le site public accepte le cache long. Le
   portail patient transite par le CDN en mode tunnel, sans aucune mise en
   cache, puisque les pages contiennent des données de santé.

2. Les règles de cache

   Les fichiers versionnés sont gardés un an. Les pages HTML du site public
   sont gardées cinq minutes. Tout ce qui porte un cookie de session est
   exclu du cache, sans exception.

3. Les règles de sécurité

   Le pare-feu applicatif est en mode blocage sur le portail patient et en
   mode détection sur le site public. La limite de débit est de 300
   requêtes par minute et par adresse.

4. Les certificats

   Ils sont gérés par le fournisseur, avec renouvellement automatique.
   L'exception est le certificat du portail patient, déposé à la main.

Ce qui reste à faire
--------------------

  - Passer le site public en mode blocage après une période d'observation.
  - Automatiser le dépôt du certificat du portail patient.
  - Sortir la configuration de la console et la mettre en code.
  - Écrire la procédure de purge d'urgence.

Fichiers ajoutés
----------------

    docs/cdn/zones.md
    docs/cdn/cache.md
    docs/cdn/securite.md
    docs/cdn/certificats.md

Pour le relecteur
-----------------

Rien n'est modifié en production par ce commit. Il faut vérifier que la
description correspond à la console, zone par zone.

Le changement de propriétaire reste à acter en comité d'exploitation : la
validation citée plus haut ne porte que sur le principe.

Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: insurance
appearance: first paragraph, url with credentials, code block
scenario: the TLS certificate renewal, gets a small feature request
⟬text⟭
# renouvellement-tls

Ce dépôt renouvelle les certificats TLS de l'extranet assurés. Il est maintenu par ⟬person_name#1⟭. Avant toute chose, configurer l'accès au coffre : `VAULT_ADDR=https://⟬username#1⟭:⟬url_password#1⟭@⟬hostname#1⟭:8200`, le mot de passe est celui du compte de renouvellement.

## Fonctionnement

Chaque lundi, le job liste les certificats qui expirent sous 30 jours, demande leur renouvellement et les dépose sur les répartiteurs de charge.

## Installation

```sh
pip install -r requirements.txt
cp config.exemple.yml config.yml
python -m renouvellement --check
```

## Demande en cours

Le service exploitation souhaite une petite évolution : recevoir un récapitulatif hebdomadaire des certificats renouvelés dans le canal de l'équipe, même quand tout va bien.

- [ ] ajouter une commande `recap`
- [ ] brancher le webhook du canal
- [ ] documenter le format du message

## Dépannage

Si le coffre répond 403, le mot de passe a sans doute tourné.
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: fr
fill_locale: fr_FR
domain: public administration
appearance: quoted log line, url path
scenario: the fraud rules, moves to a new provider
⟬text⟭
Incident ⟬ticket_id#1⟭ : règles anti-fraude du téléservice d'aides

Pendant la bascule des règles chez le nouveau fournisseur, le rejeu du lot de nuit a échoué.
Sortie du job, recollée ici sans nettoyage :

    rules-sync POST /v3/rulesets/⟬opaque_token#1⟭ 502 upstream
    rules-sync abandon, lot verrouillé par ⟬person_name#1⟭ <⟬email#1⟭>

Le lot a été relancé à 7 h, sans effet sur les demandes en cours d'instruction.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: HR
appearance: key value, settings, bullet list
scenario: the API rate limiter, needs a temporary workaround
⟬text⟭
Point technique portail RH, ⟬date#2⟭
Animation : ⟬trap:indicator_non_pii|équipe API⟭

Sujet : le limiteur de débit bloque les exports de fin de mois.

Le limiteur a été durci à la ⟬version#1⟭. Depuis, les exports de paie enchaînent les erreurs 429 dès le 25 du mois.
Paramètres actuels relevés en séance :

    USER_QUOTA=⟬trap:indicator_non_pii|120⟭
    TOKEN_TTL=⟬trap:indicator_non_pii|3600⟭
    api_key_header=⟬trap:indicator_non_pii|X-Api-Key⟭

Contournement retenu
- Exception temporaire pour le compte de service des exports.
- Durée : jusqu'à la clôture de paie du mois prochain.
- Suivi dans ⟬ticket_id#1⟭ par ⟬trap:initials|KD⟭.

Décisions
- Le quota redevient normal le ⟬date#1⟭.
- Les exports passeront par la file asynchrone à la prochaine version.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: key value, prose
scenario: the feature flag cleanup, shows wrong figures for one customer
⟬text⟭
Nettoyage des feature flags : chiffres faux pour un client

Le retrait du flag `promo_v2` recalculait les remises du client ⟬customer_id#1⟭ sur la commande ⟬order_number#1⟭.
La facture ⟬invoice_number#1⟭ affiche donc un montant erroné depuis le ⟬date#1⟭.

Auteur : ⟬trap:indicator_non_pii|renovate[bot]⟭
Version corrigée : ⟬version#1⟭
⟬end⟭
