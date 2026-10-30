⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: commit body, shell command, placeholder
scenario: a client's security questionnaire, is explained to new hires
⟬text⟭
docs(onboarding): expliquer le questionnaire sécurité des clients

Les nouveaux arrivants reçoivent ce questionnaire dès la deuxième semaine
et personne ne leur dit où trouver les réponses. Un grand compte de la
marketplace l'a renvoyé trois fois parce que nos pièces jointes étaient
incomplètes.

Ce commit ajoute une page d'onboarding qui couvre :

  * qui reçoit le questionnaire (avant-vente, puis relais vers la sécurité) ;
  * les 40 questions qui reviennent d'un client à l'autre ;
  * les réponses déjà validées, rangées par thème (chiffrement, sauvegardes,
    rétention des paniers abandonnés, sous-traitants) ;
  * les commandes qui produisent les preuves à joindre.

Les exemples gardent des valeurs de substitution, à remplacer en local et à
ne jamais committer :

    pg_dump -h ⟬hostname#1⟭ -d ⟬trap:placeholder|<base>⟭ --schema-only > preuve-schema.sql
    curl -su ⟬trap:placeholder|<compte>:****⟭ ⟬url#1⟭ -o preuve-tls.json
    vault kv get -field=valeur ⟬trap:placeholder|kv/clients/<client>/<env>⟭

Un nouvel arrivant doit pouvoir répondre seul en moins d'une heure. Si une
question manque, il ouvre un ticket plutôt que d'improviser.

Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: public administration
appearance: quoted message, bullet list, initials
scenario: the data warehouse sync, has been slow since the last deployment
⟬text⟭
Point hebdomadaire entrepôt de données, ⟬date#2⟭

En ouverture, le service des relations aux usagers a lu ce message arrivé sur le formulaire du portail : « Le courrier de la redevance est encore reparti au ⟬fr_postal_address#1⟭ alors que j'ai rendu les clés en mars et tout signalé en ligne. Trois relances, aucune réponse. ⟬person_name#1⟭ »

Lien avec notre sujet : les changements saisis sur le portail n'arrivent plus à temps dans l'entrepôt, et le publipostage part sur des données périmées.

Constats
- Depuis le déploiement de la ⟬version#1⟭, la synchronisation nocturne passe de 40 minutes à plus de trois heures.
- Le job ⟬trap:code_identifier|sync_⦃family⦄_referentiel⟭ tourne encore en mono-thread.
- La fenêtre de 2 h à 5 h n'est plus tenue : les éditions du matin partent avec les données de l'avant-veille.
- Les index de la table des foyers ont été recréés à la mise en production, sans statistiques.

Décisions
- Revenir à la parallélisation précédente en recette et comparer sur deux nuits.
- Geler les éditions de masse jusqu'au retour à la normale.

Actions
- ⟬trap:initials|SB⟭ relance l'analyse des tables volumineuses.
- ⟬trap:initials|F.-X.⟭ prépare le retour arrière.
- ⟬trap:initials|MT⟭ répond au message une fois la correction faite.

Prochain point le ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: markdown link, url path, bullet list
scenario: the budget forecast, is planned for next quarter
⟬text⟭
Réunion budget prévisionnel, pôle imagerie, ⟬date#1⟭

- Prévision du prochain trimestre à figer avant le comité de direction.
- Hypothèse retenue : activité stable, hausse des contrats de maintenance.
- Arbitrage sur le second scanner reporté.
- Note d'arbitrage approuvée : [signée par ⟬person_name#1⟭](https://⟬hostname#1⟭/budget/notes/previsionnel-t3)
- Responsable du chiffrage : https://⟬hostname#1⟭/annuaire/⟬person_name:handle#2⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: banking
appearance: key value, prose
scenario: the laptop replacement programme, gets a cost review
⟬text⟭
Programme de renouvellement des portables : revue des coûts

Propriétaire : ⟬trap:indicator_non_pii|équipe Poste de travail⟭
Validation : ⟬trap:indicator_non_pii|comité achats IT⟭
Contact : ⟬trap:indicator_non_pii|centre de services N1⟭

Le parc compte environ 1 800 portables, dont un tiers arrive en fin de garantie.
La revue compare le rachat, la location longue durée et l'allongement à cinq ans.
La location coûte plus cher sur le papier mais évite la gestion des retours en agence.
La décision revient au comité achats, sur la base du chiffrage de la direction financière.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: fr
fill_locale: fr_FR
domain: insurance
appearance: commit body, quoted log line, url path
scenario: the on-call rota, was flagged by an audit
⟬text⟭
fix(astreinte): combler les trous de rotation relevés par l'audit

L'audit interne du pôle sinistres a relevé deux semaines sans titulaire
d'astreinte sur le périmètre des déclarations en ligne. La cause est dans
la génération du planning : les jours fériés sortaient de la rotation
sans que le tour suivant soit recalculé.

Correctif :

- le calcul repart du dernier titulaire effectif, pas de la semaine civile ;
- un jour férié décale le tour au lieu de le supprimer ;
- le job échoue bruyamment si une semaine reste vide.

Trace reproduite en recette avant correctif :

    ⟬date#1⟭ 03:12:44 ERROR planner POST https://⟬hostname#1⟭/schedules/⟬opaque_token#1⟭/shifts -> 409
    ⟬date#1⟭ 03:12:44 ERROR planner créneau vide, renvoi impossible vers ⟬email#2⟭

Testé sur les douze derniers mois du planning : aucune semaine vide.

Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: HR
appearance: markdown bullet, inline code
scenario: the disaster recovery drill, is being retired
⟬text⟭
# drp-sirh

Scripts de l'exercice de reprise d'activité du SIRH. **Dépôt en cours de retrait** : l'exercice passe sur la plateforme commune au prochain semestre.

## Mise en route

- Installer les dépendances : `pip install -r requirements.txt`
- Base de secours : `⟬hostname#1⟭`, compte `⟬username#1⟭`
- Mot de passe du compte : `⟬password#1⟭`
- Lancer la restauration : `make restore ENV=dr`

## Retrait

Plus de nouvelle fonctionnalité. Les rapports des anciens exercices restent dans `archives/`.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: insurance
appearance: email header, numbered list, signature, quoted thread
scenario: the timezone handling, breaks for a single team
⟬text⟭
De : ⟬trap:indicator_non_pii|Service Informatique Sinistres⟭
À : ⟬trap:indicator_non_pii|Plateau de gestion Océan Indien⟭
Objet : RE: Heures de rendez-vous d'expertise décalées à La Réunion

Bonjour à toutes et à tous,

Nous revenons vers vous au sujet du décalage constaté sur les heures de
rendez-vous d'expertise. Après analyse, le problème ne touche que votre
plateau et vient de la façon dont l'application calcule les heures locales.

Constat

Depuis la mise à jour ⟬version#1⟭ du module de planification, les heures
saisies sont bien enregistrées en UTC, mais l'affichage utilise le fuseau
du serveur de métropole. Pour les autres plateaux, la différence ne se voit
pas. Pour un plateau situé à UTC+4, un rendez-vous saisi à 14 h s'affiche
à 12 h en été et à 11 h en hiver.

Conséquences observées

  1. Les experts reçoivent une convocation avec une heure erronée.
  2. Les rappels partent deux heures trop tôt.
  3. Les rapports de productivité du plateau sont faux sur la journée.
  4. Les créneaux de fin d'après-midi semblent libres alors qu'ils sont pris.

Correctif proposé

Le service applicatif lira le fuseau du profil utilisateur au lieu de celui
du serveur. Le développement est estimé à trois jours, suivi d'une recette
d'une semaine avec votre plateau.

Contournement en attendant

Merci de continuer à saisir les heures en heure locale et de préciser le
décalage dans le champ commentaire. Les convocations déjà parties restent
valables : les experts ont été prévenus par leur coordination.

Calendrier

  - Livraison en recette : semaine prochaine
  - Validation par votre plateau : sous cinq jours ouvrés
  - Mise en production : hors période de clôture mensuelle

Nous vous remercions de votre patience.

Bien cordialement,

⟬person_name#1⟭
Responsable applicatif sinistres
⟬company#1⟭
SIRET : ⟬fr_siret#1⟭
Courriel : ⟬email#1⟭

> De : ⟬trap:indicator_non_pii|Plateau de gestion Océan Indien⟭
> Envoyé : ⟬date#1⟭
> Objet : Heures de rendez-vous d'expertise décalées à La Réunion
>
> Bonjour,
>
> Depuis une semaine, toutes nos heures de rendez-vous sont fausses à
> l'écran. Les autres plateaux ne voient rien. Nous avons vérifié les
> postes : l'heure système est correcte. Merci de regarder en priorité,
> la période des cyclones approche et le volume va monter.
>
> Bien à vous,
> ⟬person_name#2⟭
> Coordination du plateau
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: insurance
appearance: subject line, signature block, key value
scenario: the batch of duplicate records, was rolled back
⟬text⟭
Objet : TR: doublons sinistres, lot annulé

Bonjour,

Le lot de fusion des doublons a été annulé hier soir et un seul dossier reste bloqué.
Je pars en congés : voici de quoi le reprendre sans repasser par le back-office.

Merci d'avance.

--
Dossier à reprendre
Assurée : ⟬person_name#1f⟭
Adresse : ⟬fr_postal_address#1⟭
Permis : ⟬fr_driving_licence#1⟭
IBAN : ⟬iban#1⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: shell command, command flag
scenario: the load test, needs a temporary workaround
⟬text⟭
h1. Test de charge du tunnel de commande

Depuis la nouvelle version du générateur, le scénario panier plante au-delà de 300 utilisateurs virtuels.
En attendant le correctif, on plafonne la montée en charge :

{code}
k6 run panier.js --vus 200 --duration 15m --tag owner=⟬email#1⟭ --tag env=recette
{code}

Contournement à retirer dès la fermeture de ⟬ticket_id#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: public administration
appearance: markdown heading, code block, table, code identifier
scenario: the backup rotation, fails after an upgrade
⟬text⟭
# rotation-sauvegardes

Rotation des sauvegardes de la collectivité : dumps des bases métiers, exports de l'état civil, archives du portail de démarches.

> **État actuel :** la rotation échoue sur tous les serveurs mis à jour vers la ⟬version#1⟭. Voir la section « Échec après mise à jour ».

## Principe

Chaque nuit, l'outil range les archives en trois classes (quotidienne, hebdomadaire, mensuelle) et supprime celles qui sortent de la fenêtre de rétention. Les intervalles suivent une suite de ⟬trap:eponym|Fibonacci⟭ : plus une archive vieillit, plus on en garde peu.

L'intégrité de chaque lot repose sur un arbre de ⟬trap:eponym|Merkle⟭, calculé à l'écriture et revérifié avant toute suppression. La recherche d'une archive déjà connue passe par un filtre de ⟬trap:eponym|Bloom⟭ pour éviter de relire tout l'inventaire.

## Dépendances

| Paquet | Rôle |
| --- | --- |
| ⟬trap:library|Click⟭ | ligne de commande |
| ⟬trap:library|Jinja⟭ | gabarits des rapports |
| ⟬trap:library|Pydantic⟭ | validation de la configuration |
| ⟬trap:library|Hypothesis⟭ | tests de propriétés |
| ⟬trap:library|Sphinx⟭ | documentation |

## Installation

```sh
python -m venv .venv
.venv/bin/pip install -r requirements.txt
.venv/bin/rotation --help
```

## Configuration

```yaml
retention:
  quotidienne: 14
  hebdomadaire: 8
  mensuelle: 12
cibles:
  - nom: etat-civil
    chemin: ⟬file_path#1⟭
  - nom: portail
    chemin: ⟬file_path#2⟭
```

## Échec après mise à jour

Symptôme : le job s'arrête dès la deuxième classe avec une erreur de permission sur le répertoire de verrou. La cause probable est le nouveau profil de sécurité livré avec le système, qui interdit l'écriture hors de `/var/lib/rotation`.

Pour diagnostiquer :

```sh
.venv/bin/rotation check --verbose
journalctl -u rotation.service --since yesterday
```

Le module concerné est `⟬trap:code_identifier|⦃family⦄_lock.py⟭`, en particulier la classe `⟬trap:code_identifier|⦃Family⦄Retention⟭` et sa méthode `⟬trap:code_identifier|purge_⦃family2⦄_window⟭`.

Contournement : pointer le verrou vers `/var/lib/rotation/lock` dans la configuration, puis relancer le job à la main.

## Tests

```sh
.venv/bin/pytest -q
```

Les tests de propriétés vérifient qu'aucune archive mensuelle n'est supprimée avant son terme, quel que soit l'ordre des exécutions.

## Feuille de route

- Corriger le chemin du verrou par défaut.
- Ajouter un mode à blanc qui liste les suppressions prévues.
- Publier le rapport de rotation sur le portail de supervision.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: wiki heading, shell command, url
scenario: the CI pipeline, was fixed, and the fix is explained
⟬text⟭
== Pipeline CI du portail patient : correctif du ⟬date#1⟭ ==

=== Ce qui cassait ===

Le job d'intégration échouait une fois sur trois, sur une expiration de délai
pendant la récupération du dépôt de jeux d'essai FHIR.

=== Cause ===

Le runner mutualisé clonait le dépôt en entier : quatre gigaoctets d'historique,
surtout des comptes rendus anonymisés régénérés chaque mois. Le cache était vidé
à chaque redémarrage du runner.

=== Correctif ===

Clone superficiel, cache monté sur un volume persistant :

 git clone --depth 1 https://⟬username#1⟭:⟬url_password#1⟭@⟬hostname#1⟭/sante/fixtures-fhir.git
 make fixtures CACHE_DIR=/cache/fhir

=== Résultat ===

Le job passe de 18 minutes à 4 minutes, et plus aucun échec sur 200 exécutions.

=== À surveiller ===

Le volume de cache doit rester sous 10 Go. Une alerte est posée sur le tableau de bord
de l'équipe plateforme.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: banking
appearance: page title, pasted key, prose
scenario: the staging environment, gets a small feature request
⟬text⟭
Staging, demande de ⟬person_name#1⟭ / ⟬phone#1⟭ : filtre par agence sur l'écran des virements

La recette affiche tous les virements sans distinction d'agence, ce qui rend les jeux d'essai illisibles.
Il s'agit d'un filtre simple, sans changement de schéma, estimé à une demi-journée.

⟬private_key#2⟭

Environnement concerné : ⟬hostname#1⟭, branche `develop`.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: insurance
appearance: greeting, key value, signature
scenario: the email deliverability, raises a question nobody can answer
⟬text⟭
Objet : Délivrabilité des avis d'échéance : question sans réponse

Bonjour ⟬trap:indicator_non_pii|à tous⟭,

Le taux de rebond des avis d'échéance a doublé en un mois, sans changement de notre côté.
Le service Messagerie, le prestataire de routage et l'équipe DNS ne savent pas dire d'où cela vient.
Expéditeur concerné : ⟬trap:indicator_non_pii|service Gestion des contrats⟭
Qui décide de changer de domaine d'envoi si le problème persiste ? Personne n'a la réponse à ce jour.

Cordialement,
⟬trap:indicator_non_pii|L'équipe Messagerie⟭
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: HR
appearance: mail client signature, prose
scenario: the internal wiki cleanup, needs a new owner
⟬text⟭
Objet : Nettoyage du wiki interne, reprise à organiser

Le prestataire chargé du nettoyage du wiki RH termine sa mission à la fin du mois.
Il reste environ 300 pages à archiver, dont les anciennes procédures de paie.
Merci d'indiquer avant vendredi quel service peut reprendre ce chantier.

--
Direction des ressources humaines
⟬fr_postal_address#1⟭
⟬email:generic#2⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: shell command, environment variable, prose
scenario: the reporting dashboard, was rolled back
⟬text⟭
Tableau de bord des ventes : retour arrière, marche à suivre

Le nouveau tableau de bord a été retiré ce matin : les marges par catégorie étaient fausses dès qu'un code promo s'appliquait au panier.
L'ancienne version tourne à nouveau, mais son accès SSO n'a pas été restauré.

Pour que tu puisses finir la clôture de la semaine sans attendre le ticket d'accès, voici le compte de service de l'ancienne version.
Il sert à lancer les exports à la main :

```
export REPORTING_DB_HOST=⟬hostname#1⟭
export REPORTING_DB_USER=⟬username#1⟭
export REPORTING_DB_PASSWORD='⟬password#1⟭'
python -m reporting.export --from ⟬date#2⟭ --to ⟬date#1⟭ --out ventes.csv
```

Ce mot de passe tourne dès que le SSO revient, ne le recopie pas ailleurs.

À vérifier après export :

- le total par jour correspond à celui de la comptabilité ;
- les remboursements sont bien en négatif ;
- les commandes annulées n'apparaissent pas.

Si un chiffre diverge de plus de 1 %, ne publie rien et préviens l'équipe Data.
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: report title, timeline, table, prose
scenario: the pricing page, is being retired
⟬text⟭
# Incident ⟬ticket_id#1⟭ : retrait de la page tarifs, accès CDN confié à ⟬person_name#1⟭, jeton ⟬opaque_token#1⟭

Rédigé le ⟬date#1⟭ par l'équipe web du groupe de cliniques.
Sévérité : 3. Statut : clos.

## Résumé

La page des tarifs des consultations est retirée du site public : les dépassements d'honoraires sont désormais publiés par chaque établissement.
Pendant le retrait, une règle de redirection mal placée a renvoyé toutes les pages de praticiens vers l'accueil.
Le responsable du CDN étant absent, le jeton d'accès a été transmis en urgence pour que la règle soit corrigée le soir même.

## Impact

- Pages de praticiens indisponibles pendant 2 h 40.
- Prise de rendez-vous en ligne indirectement touchée : 35 % de visites en moins sur la période.
- Aucune donnée de santé concernée, le site public n'en héberge pas.

## Chronologie

| Heure | Événement |
| --- | --- |
| 16:05 | Publication de la règle de retrait de la page tarifs |
| 16:20 | Premières alertes de la sonde sur les pages de praticiens |
| 16:45 | Le support signale des appels de patients |
| 17:10 | Astreinte web mobilisée, cause identifiée |
| 17:30 | Le CDN refuse la modification : droits insuffisants |
| 18:15 | Jeton transmis, règle corrigée |
| 18:45 | Retour à la normale confirmé par la sonde |

## Cause racine

La règle de retrait utilisait un préfixe trop large : `/tarifs*` a été saisi sans ancrage, et le moteur du CDN l'a appliquée à tout chemin contenant ce mot.
Les fiches de praticiens contiennent le mot dans leur URL, car elles mentionnent le secteur tarifaire.

## Ce qui a bien fonctionné

- La sonde a alerté en quinze minutes.
- L'astreinte a trouvé la cause en moins d'une demi-heure.

## Ce qui a mal fonctionné

- Une seule personne détenait les droits d'écriture sur le CDN.
- Le jeton a circulé dans un message, faute de coffre partagé.
- La règle n'a pas été testée en préproduction.

## Actions

| Action | Porteur | Échéance |
| --- | --- | --- |
| Révoquer le jeton transmis et en émettre un nouveau | équipe web | sous 24 h |
| Donner les droits CDN à une deuxième personne | responsable infrastructure | sous une semaine |
| Ranger les jetons dans le coffre partagé | équipe sécurité | sous un mois |
| Ajouter un test de préproduction sur les règles | équipe web | sous un mois |

## Communication

- Le standard des cliniques a reçu une consigne écrite à 17:00.
- Un message a été publié sur la page d'accueil à 17:20, puis retiré à 18:50.
- Les praticiens n'ont pas été prévenus individuellement.

## Suite du retrait

La page tarifs reste en ligne avec un bandeau jusqu'à la fin du mois, puis elle sera remplacée par une redirection propre vers les pages des établissements.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: subject line, curl command, json payload
scenario: the password reset flow, moves to a new provider
⟬text⟭
Objet : Bascule du parcours de mot de passe oublié, dossier à reprendre

Madame,

Le parcours de réinitialisation du mot de passe de l'espace patient passe chez le nouveau
fournisseur d'identité à la fin du mois. La migration des comptes s'est bien déroulée,
à une exception près : un compte reste bloqué car son justificatif d'identité a été
rejeté par le contrôle automatique.

Je quitte le projet vendredi. Je vous transmets donc tout ce qu'il faut pour reprendre ce cas,
sous la forme de la commande utilisée pour le rejouer :

    curl -X POST https://⟬hostname#1⟭/v2/identities/replay \
      -H "Content-Type: application/json" \
      -d '{
        "nom": "⟬person_name#1m⟭",
        "courriel": "⟬email#1⟭",
        "passeport": "⟬fr_passport#1⟭",
        "adresse": "⟬fr_postal_address#1⟭",
        "iban_remboursement": "⟬iban#1⟭",
        "motif": "reprise manuelle"
      }'

La réponse attendue est un code 202. Si le fournisseur renvoie 409, le compte existe déjà
de son côté et il suffit de relancer la réinitialisation depuis la console.

L'IBAN figure ici parce que ce patient attend aussi un remboursement de consultation,
bloqué par le même rejet. Le service comptable est informé.

Je vous remercie de bien vouloir supprimer ce message une fois le dossier repris.

Veuillez agréer, Madame, l'expression de mes salutations distinguées.

Le chef de projet Identité
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: banking
appearance: bullet list, connection string, pasted key
scenario: the address autocomplete, fails after an upgrade
⟬text⟭
Autocomplétion d'adresse : échec après mise à jour

Depuis le passage à la ⟬version#1⟭ du service de géocodage, le champ d'adresse des formulaires d'ouverture
de compte ne propose plus rien. La cause est un changement de format de la réponse : le champ `housenumber`
est devenu un objet, et notre client le lit encore comme une chaîne.

Rappel de l'environnement, en attendant que cette page soit refondue :

- Base de géocodage : postgresql://geo:⟬url_password#1⟭@⟬hostname#1⟭:5432/ban
- Astreinte du fournisseur, tél. ⟬phone#1⟭
- Clé SSH du bastion :
  ⟬private_key#1⟭
- Tableau de bord : ⟬url#1⟭

Correctif prévu :

1. Adapter le client pour accepter les deux formats.
2. Rejouer les tests d'ouverture de compte.
3. Déployer en recette, puis en production hors heures d'ouverture.

En attendant, le formulaire accepte une saisie libre et l'adresse est vérifiée à la main par le back-office.
Les dossiers concernés sont marqués dans la file de contrôle.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: public administration
appearance: markdown heading, checklist, table, code identifier
scenario: the CRM integration, is explained to new hires
⟬text⟭
## Contexte

Cette PR ajoute le guide d'intégration du CRM de la relation usagers, pour les nouveaux arrivants de la direction du numérique.
Aujourd'hui, ce savoir n'existe que dans la tête de quelques personnes et dans des tickets vieux de trois ans.

Auteur : ⟬trap:indicator_non_pii|dependabot[bot]⟭ pour la mise à jour des dépendances, équipe Intégration pour le reste.
Relecteurs : ⟬trap:indicator_non_pii|équipe Relation usagers⟭

## Ce que contient le guide

- le schéma des échanges entre le portail de démarches et le CRM ;
- le rôle de chaque file de messages ;
- la façon de rejouer un message en erreur ;
- les erreurs les plus fréquentes et leur cause.

## Vue d'ensemble

Le portail publie un événement à chaque dépôt de demande. Le connecteur le lit, le traduit et crée ou met à jour la fiche dans le CRM.

```
portail -> file demandes -> connecteur -> API CRM
                               |
                               v
                         file erreurs
```

## Composants

| Composant | Technologie | Rôle |
| --- | --- | --- |
| Connecteur | ⟬trap:library|Flask⟭ | reçoit les rappels du CRM |
| Sérialisation | ⟬trap:library|Jackson⟭ | côté portail, en Java |
| Files | ⟬trap:library|Celery⟭ | traitements asynchrones |
| Gabarits | ⟬trap:library|Jinja⟭ | courriers générés |
| Documentation | ⟬trap:library|Sphinx⟭ | génération du guide |

## Points de code à connaître

- `⟬trap:code_identifier|⦃Family⦄Mapper⟭` traduit une demande en fiche CRM. Le nom vient de l'ancien prestataire, personne n'a osé le renommer.
- `⟬trap:code_identifier|get_⦃family⦄_score⟭` calcule le score de priorité d'une demande.
- `⟬trap:code_identifier|retry_⦃family2⦄_queue⟭` rejoue la file d'erreurs.

## Rapprochement des doublons

Le connecteur rapproche deux fiches à l'aide d'une distance de ⟬trap:eponym|Levenshtein⟭ sur le libellé de la demande et d'un algorithme de ⟬trap:eponym|Jaro-Winkler⟭ sur la commune.
Les seuils sont dans la configuration et ne doivent pas être modifiés sans revue.

## Dépendances mises à jour

`requirements.txt` passe sur ⟬version#1⟭ pour le client HTTP. Aucun changement fonctionnel.

## Comment relire

1. Lire le guide comme si vous arriviez demain.
2. Noter tout ce qui reste obscur.
3. Essayer de rejouer un message en erreur sur la recette en suivant uniquement le guide.

## Checklist

- [x] Guide relu par l'équipe Intégration
- [x] Schémas à jour
- [ ] Liens vers la supervision vérifiés
- [ ] Parcours testé par un nouvel arrivant

## Hors périmètre

La migration vers la nouvelle version du CRM fera l'objet d'une autre PR.

Closes ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: HR
appearance: table row, prose
scenario: the login page, raises a question nobody can answer
⟬text⟭
Page de connexion du portail RH : d'où viennent les déconnexions de 17 h ?

Plusieurs sites voient la page de connexion réapparaître vers 17 h, sans message d'erreur.
La durée de session est pourtant de huit heures et personne ne sait d'où vient cette coupure.

| Site | Ouverture | Renvoi |
| --- | --- | --- |
| Siège | 8 h - 18 h | ⟬phone#1⟭ |
| ⟬city#1⟭ | 9 h - 17 h | service central |

Les deux sites utilisent le même proxy. La question reste ouverte auprès de l'équipe réseau.
⟬end⟭
