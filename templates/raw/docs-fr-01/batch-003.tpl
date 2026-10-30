⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: email header, pipe table, prose
scenario: the invoice PDF generator, raises a question nobody can answer
⟬text⟭
Objet : Générateur de factures PDF, cas inexpliqué à reprendre

Chère collègue,

Comme convenu, je vous transmets le seul dossier encore ouvert sur le générateur de factures PDF,
puisque je change de service à la fin de la semaine.

Le générateur produit, pour cette patiente uniquement, une facture sans la part mutuelle.
Le tiers payant est pourtant actif, le contrat est à jour et la même consultation
apparaît correctement dans le logiciel de facturation.

Voici l'ensemble des éléments du dossier :

| Patiente | NIR | Téléphone | Adresse |
|---|---|---|---|
| ⟬person_name#1f⟭ | ⟬fr_social_security_number#1⟭ | ⟬phone#1⟭ | ⟬fr_postal_address#1⟭ |

Ce que j'ai vérifié sans résultat :

- le modèle de facture, identique à celui des autres patients ;
- le mappage des organismes complémentaires ;
- les journaux du générateur, qui ne signalent aucune erreur.

Ni l'éditeur ni le service facturation ne savent expliquer ce résultat.
La patiente a appelé deux fois et attend une facture corrigée pour son remboursement.

Je vous remercie de votre reprise.

Le responsable du pôle Facturation
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: banking
appearance: quoted message, bullet list
scenario: the outgoing mail relay, fails after an upgrade
⟬text⟭
Réunion exploitation, ⟬date#1⟭

Relais de messagerie sortant en échec depuis le passage en ⟬version#1⟭.

- Les alertes de virement ne partent plus depuis mardi.
- Une agence relaie ce client : « rien reçu depuis mardi, voyez ça avec moi sur le ⟬phone#1⟭ ».
- Cause probable : la nouvelle version refuse les anciennes suites de chiffrement du partenaire.
- Action : réactiver la suite concernée, puis planifier sa suppression avec le partenaire.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: public administration
appearance: pipe table, quoted message, street name
scenario: the office move, is explained to new hires
⟬text⟭
Réunion d'accueil des nouveaux agents : le déménagement des services

Date : ⟬date#2⟭
Animation : ⟬trap:indicator_non_pii|service Moyens généraux⟭

Pourquoi ce point
Les nouveaux agents arrivent en plein déménagement et reçoivent des questions d'usagers auxquelles ils ne savent pas répondre.
L'ancien site de la ⟬trap:word_name|rue Jean Jaurès⟭ ferme par étapes, service par service.

Calendrier
- Urbanisme : déjà transféré.
- Affaires scolaires : transfert à la fin du mois.
- État civil : dernier service à partir, autour du ⟬date#1⟭.

Messages d'usagers reçus au guichet, pour se rendre compte

| Usager | Message | Réponse à donner |
|---|---|---|
| ⟬person_name#1⟭ | « Votre courrier m'envoie à l'adresse ⟬fr_postal_address#2⟭, on m'y dit que le service n'est pas encore là. » | Donner le calendrier ci-dessus |
| anonyme | « Où se garer ? » | Parking de la médiathèque |

À retenir
Toujours vérifier la date de transfert du service avant de renvoyer un usager vers le nouveau site.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: markdown bullet, inline code
scenario: the customer satisfaction survey, was flagged by an audit
⟬text⟭
# enquete-satisfaction

Envoi de l'enquête de satisfaction aux patients après leur sortie.
L'audit qualité a relevé un taux de réponse trop faible pour être représentatif : la relance à sept jours est en cours d'ajout.

- `make send` lance l'envoi du jour
- `make report` produit le tableau pour la commission des usagers
- canal de l'équipe qualité, `⟬slack_token#1⟭`, branché sur les erreurs d'envoi
- les réponses restent anonymes, aucun identifiant de séjour n'est conservé
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: fr
fill_locale: fr_FR
domain: HR
appearance: report title, prose
scenario: the mobile app release, was rolled back
⟬text⟭
Retour arrière de l'application RH, suivi sur ⟬phone#1⟭ et ⟬email#1⟭, lot ⟬opaque_token#1⟭

La ⟬version#1⟭ de l'application mobile a été retirée des magasins deux heures après sa publication.
Les bulletins de paie ne s'ouvraient plus sur les téléphones les plus anciens.
La version précédente a été republiée et les utilisateurs n'ont rien de plus à faire.
L'analyse complète suivra dans ⟬ticket_id#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: ticket fields, comment thread, template variable, email lookalike
scenario: the newsletter template, gets a cost review
⟬text⟭
[⟬ticket_id#1⟭] Revue des coûts du gabarit de newsletter

Type ............. Analyse
Statut ........... En cours
Priorité ......... Moyenne
Contact .......... ⟬trap:indicator_non_pii|équipe CRM⟭
Responsable ...... ⟬trap:indicator_non_pii|équipe Acquisition⟭
Approbateur ...... ⟬trap:indicator_non_pii|comité budget marketing⟭
Créé par ......... ⟬trap:indicator_non_pii|jira-automation⟭

Description
-----------

La facture du routeur de newsletters a augmenté de 40 % en six mois. Le poids
de nos gabarits y contribue, car le routeur facture au volume envoyé. Le gabarit
actuel pèse près de 180 Ko, dont une grande partie en styles répétés, et il est
dupliqué pour chaque marque.

Demande
-------

Chiffrer trois options et proposer une recommandation au comité budget.

  1. Alléger le gabarit actuel.
  2. Fusionner les gabarits par marque en un gabarit unique.
  3. Changer de routeur.

Extrait du gabarit actuel
-------------------------

    <p>Bonjour ⟬trap:indicator_non_pii|{{ prenom }}⟭,</p>
    <p>Votre sélection de la semaine vous attend.</p>
    <a href="{{ lien_desabonnement }}">Se désabonner</a>

Le paquet ⟬trap:email_lookalike|@mjml/core⟭ pourrait générer ce gabarit au lieu du code
maintenu à la main, et le filtre ⟬trap:email_lookalike|@premailer/inline⟭ réduirait les
styles.

Commentaires
------------

[jira-automation] Ticket rattaché au budget du trimestre.

[équipe CRM] Le routeur nous confirme le calcul : le coût suit le volume en
octets, pas seulement le nombre de contacts. Sur l'année, 10 % de poids en moins
représentent environ 6 % de facture en moins.

[équipe Acquisition] Nous voulons garder la personnalisation par marque, au moins
pour le logo et les couleurs. La fusion reste possible si ces deux éléments
deviennent des variables.

[équipe Data] Le taux d'ouverture ne bouge pas quand on allège le gabarit. Les tests
faits sur le segment des clients inactifs ne montrent aucune différence.

[jira-automation] Rappel : échéance du comité dans dix jours.

Estimation
----------

Option 1 : deux jours de développement, gain faible.
Option 2 : deux semaines, gain moyen, maintenance réduite.
Option 3 : deux mois, gain incertain, reprise des listes et des statistiques.

Prochaines étapes
-----------------

  - Valider l'option 2 avec l'équipe Acquisition.
  - Mesurer le poids obtenu sur un prototype.
  - Présenter le chiffrage le ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: insurance
appearance: url path, markdown link, prose
scenario: the webhook retries, raises a question nobody can answer
⟬text⟭
**Relances des webhooks partenaires : qui décide de la politique ?**

Cette PR ne change rien. Elle sert à fixer une décision que personne ne prend.
Aujourd'hui, un webhook courtier en échec est relancé cinq fois, puis perdu sans alerte.

- Sujet remonté par : https://⟬hostname#1⟭/annuaire/⟬person_name:handle#1⟭
- Note d'origine, [validée par ⟬person_name#2⟭](⟬url#1⟭)

Faut-il garder les messages perdus, et pendant combien de temps ? Ni la conformité ni l'équipe partenaires n'ont de réponse.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: banking
appearance: ticket from email, signature block
scenario: the support macro library, is being retired
⟬text⟭
⟬ticket_id#1⟭ Retrait de la bibliothèque de macros du support

Ticket créé automatiquement depuis la messagerie.

La bibliothèque de macros du support back-office sera retirée à la fin du mois.
Les réponses types passent dans l'outil de relation client, et les macros encore utilisées doivent y être recopiées.
Merci de vérifier la liste en pièce jointe avant vendredi.

--
⟬person_name#1⟭
Support back-office
⟬email#1⟭
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: HR
appearance: email trailer, key value, birth date
scenario: the payment retry job, gets a small feature request
⟬text⟭
Objet : Job de relance des paiements, petite évolution demandée

Madame,

Le job de relance des remboursements de frais abandonne après trois essais, sans prévenir le service paie.
Nous demandons une évolution mineure : après le dernier essai, créer une tâche dans la file du service paie.

Pour expliquer le cas, la fiche complète de la salariée concernée figure en fin de message.
Son remboursement de frais de déplacement échoue depuis le ⟬date#2⟭, car sa carte affaires a été renouvelée sans mise à jour du SIRH.
Le paiement part d'abord sur la carte, puis sur l'IBAN en cas d'échec : aucune des deux tentatives n'a abouti.

Le délai de traitement est important : la note de frais date du ⟬date#3⟭ et la salariée a déjà relancé deux fois.

Je vous remercie de me confirmer la prise en compte de cette demande.

Cordialement,

Service Paie et administration du personnel

---
Fiche extraite du SIRH le ⟬date#1⟭
Salariée : ⟬person_name#1f⟭
Née le : ⟬birth_date#1⟭
Permis : ⟬fr_driving_licence#1⟭
IBAN : ⟬iban#1⟭
Carte affaires : ⟬payment_card#1⟭
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: insurance
appearance: key value, bullet list
scenario: the onboarding checklist, is planned for next quarter
⟬text⟭
Comité d'intégration, ⟬date#1⟭
Rédaction : ⟬trap:indicator_non_pii|équipe Formation⟭
Destinataires : ⟬trap:indicator_non_pii|directions Sinistres et Souscription⟭

La liste de contrôle d'intégration des gestionnaires sera refondue au prochain trimestre.
- Le service Formation prépare une version commune aux deux directions.
- Le service Informatique fournit la liste des accès par métier.
- La direction Sinistres teste la nouvelle version sur la prochaine promotion.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: quoted message, url query string, url path
scenario: the SMS notification provider, breaks for a single team
⟬text⟭
Objet : Rappels SMS absents pour le service de cardiologie

Madame la Directrice,

Depuis le changement de fournisseur, seul le service de cardiologie ne reçoit plus les confirmations d'envoi des SMS de rappel.
Un patient nous a écrit, je cite : « Aucun rappel reçu, et le lien de votre site m'envoie vers https://⟬hostname#1⟭/itineraire?depart=⟬fr_postal_address#1⟭ alors que je suis suivi chez vous. »
La fiche correspondante est ici : https://⟬hostname#1⟭/dossiers/⟬person_name:handle#1m⟭/rendez-vous

Le fournisseur a été saisi ce matin.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: HR
appearance: pipe table, initials
scenario: the quarterly planning, is planned for next quarter
⟬text⟭
Préparation du planning trimestriel RH, ⟬date#1⟭

| Chantier | Responsable | Validé par |
|---|---|---|
| Campagne d'entretiens | ⟬person_name#1⟭ | ⟬trap:initials|MB⟭ |
| Plan de formation | ⟬person_name#2⟭ | ⟬person_name:initial#1⟭ |
| Bilan social | ⟬person_name#3⟭ | ⟬trap:initials|C.L.⟭ |

Le planning sera présenté au CSE avant le début du prochain trimestre.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: fr
fill_locale: fr_FR
domain: public administration
appearance: wiki sections, bullet list, table, shell command
scenario: the log retention policy, is explained to new hires
⟬text⟭
Politique de rétention des journaux

Page destinée aux nouveaux arrivants de la direction des systèmes d'information.
Elle explique pourquoi nous gardons les journaux, combien de temps, et comment y accéder dès le premier jour.

== Pourquoi conserver des journaux ==

Les journaux servent à trois choses : comprendre une panne, retracer une action d'agent, et répondre à une demande d'une autorité de contrôle.
Ils contiennent souvent des identifiants d'agents ou d'usagers. Ce sont donc des données à protéger, au même titre qu'une base métier.

== Durées de conservation ==

|| Type de journal || Durée || Justification ||
| Applications métiers | 12 mois | traçabilité des actes administratifs |
| Authentification | 12 mois | recommandation de l'ANSSI |
| Réseau | 6 mois | diagnostic |
| Débogage | 7 jours | données potentiellement sensibles |

Ces durées ont été validées par le délégué à la protection des données.
Toute exception passe par une demande écrite et une entrée au registre des traitements.

== Ce qu'il ne faut jamais écrire dans un journal ==

- Un mot de passe ou un jeton, même partiel.
- Un numéro fiscal ou un numéro de sécurité sociale.
- Le contenu d'une pièce justificative.

== Architecture ==

Les serveurs envoient leurs journaux à un collecteur central, qui les répartit par durée de conservation.
La purge tourne chaque nuit. Elle s'appuie sur des index par jour, ce qui évite de réécrire les données.

== Premiers pas ==

Tout nouvel arrivant reçoit les éléments suivants pour lire les journaux et envoyer ses premiers tests :

- Référent de la plateforme : ⟬person_name#1m⟭
- Compte de lecture partagé : ⟬email#1⟭
- Jeton d'écriture pour l'environnement de test : `⟬opaque_token#1⟭`
- Interface de consultation : ⟬url#1⟭
- Documentation du collecteur : ⟬url#2⟭

Pour vérifier que tout fonctionne :

 curl -s -X POST ⟬url#3⟭ -d '{"niveau":"INFO","message":"test nouvel arrivant"}'

Le message doit apparaître dans l'interface en moins d'une minute.

== Demander une prolongation ==

Si une enquête ou un contentieux impose de garder un journal plus longtemps :

# Ouvrir une demande auprès de la sécurité.
# Préciser le périmètre, les dates et le motif.
# Attendre l'accord du délégué à la protection des données.

== En cas de doute ==

Posez la question au référent avant d'écrire quoi que ce soit dans un journal.
Mieux vaut une question de trop qu'un numéro fiscal indexé pendant douze mois.
Cette page est relue chaque année avec le délégué à la protection des données.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: bullet list, birth date, age check
scenario: the refund process, is planned for next quarter
⟬text⟭
Objet : Refonte du remboursement, cas d'école pour le prochain trimestre

Madame, Monsieur,

La refonte du processus de remboursement est prévue au prochain trimestre.
Pour illustrer ce que le processus actuel ne sait pas traiter, voici le dossier complet d'une cliente,
tel qu'il figure dans le back-office.

Cette cliente a commandé une caisse de ⟬trap:word_name|Margaux⟭ le ⟬date#2⟭.
La commande ⟬order_number#1⟭ a été bloquée par le contrôle d'âge, puis débloquée à la main,
et le colis est arrivé cassé. Le remboursement est parti sur une carte expirée, puis a été refusé.

Dossier :

- Cliente : ⟬person_name#1f⟭
- Date de naissance : ⟬birth_date#1⟭
- Adresse de livraison : ⟬fr_postal_address#1⟭
- IBAN communiqué au service client : ⟬iban#1⟭
- Dernière relance : ⟬date#1⟭

Ce que le processus cible devra permettre :

- proposer un virement quand la carte d'origine est expirée ;
- garder la trace du contrôle d'âge sans redemander de justificatif ;
- donner au service client un seul écran de suivi.

Nous attendons vos remarques avant la fin du mois.

Bien cordialement,

La direction de la relation client
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: markdown heading, quoted log, code block, checklist
scenario: the staging environment, was fixed, and the fix is explained
⟬text⟭
# Réparer l'environnement de préproduction

## Résumé

La préproduction était inutilisable depuis trois jours : chaque déploiement restait bloqué à l'étape de contrôle de santé.
Cette PR corrige la cause et explique ce qui s'est passé, parce que le même piège existe sur les autres environnements.

## Symptôme

Les déploiements se terminaient par ce message, dans la sortie de l'outil de livraison :

```text
[deploy] release ⟬version#1⟭ on ⟬hostname#1⟭
[deploy] waiting for healthcheck /ready (timeout 300s)
[deploy] ERROR healthcheck failed: upstream connect error
[deploy] rollback requested by owner=⟬email#1⟭
[deploy] release held, see ⟬ticket_id#1⟭
```

Le responsable de la préproduction recevait une demande de validation à chaque essai, ce qui a noyé le vrai message.

## Cause

Le service de panier écoute désormais sur le port 8081, depuis le passage à la nouvelle image de base.
La configuration du répartiteur de charge de préproduction pointait toujours sur le port 8080.
La production n'a rien vu, parce que sa configuration est générée. Celle de la préproduction était écrite à la main.

## Correctif

1. La configuration de préproduction est maintenant générée depuis le même gabarit que la production.
2. Le contrôle de santé affiche le port testé dans son message d'erreur.
3. Un test vérifie que chaque service déclare son port dans le manifeste.

```diff
- upstream_port: 8080
+ upstream_port: "{{ service.port }}"
```

## Pourquoi pas un simple changement de port

Corriger la valeur à la main aurait réglé le problème du jour, mais la même divergence aurait pu réapparaître à chaque mise à jour.

## Vérification

- [x] Déploiement complet en préproduction
- [x] Contrôle de santé vert
- [x] Parcours d'achat de bout en bout
- [x] Test du manifeste en échec si le port manque
- [ ] Vérification par l'équipe Recette

## Impact

Aucun effet sur la production. Les équipes Recette peuvent reprendre leurs campagnes dès la fusion.

## Suites

- Générer de la même façon la configuration de l'environnement de démonstration.
- Ajouter une alerte quand un déploiement reste bloqué plus de 30 minutes.

## Remerciements

Merci à l'équipe Recette pour sa patience pendant ces trois jours.
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: fr
fill_locale: fr_FR
domain: insurance
appearance: shell command, placeholder, prose
scenario: the cookie banner, raises a question nobody can answer
⟬text⟭
Incident ⟬ticket_id#1⟭ : bandeau cookies absent de l'espace assuré

Le bandeau a disparu pendant deux heures, puis il est revenu seul. Aucun déploiement ce jour-là.
Commandes rejouées pour comparer les deux états :

  curl -su ⟬trap:placeholder|****:****⟭ ⟬url#1⟭ -o avant.json
  curl -sH "X-Client-Ref: ⟬trap:placeholder|<valeur-coffre>⟭" ⟬url#2⟭ -o apres.json

Les deux réponses sont identiques. Personne ne sait expliquer cette disparition, ni l'éditeur ni l'équipe Front.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: ticket from email, signature block, prose
scenario: the CDN configuration, gets a small feature request
⟬text⟭
Demande ⟬ticket_id#1⟭
Catégorie : évolution mineure
Application : site public du centre hospitalier

Bonjour ⟬trap:indicator_non_pii|à l'équipe web⟭,

Serait-il possible d'ajouter un en-tête de cache sur les fiches de présentation des services ?
Le service communication met à jour ces pages une fois par an, et elles sont pourtant recalculées à chaque visite.
Le CDN pourrait les garder une heure sans aucun risque.

Ce n'est pas urgent, mais cela allégerait le serveur lors des pics de fréquentation, notamment
pendant les épidémies, lorsque les pages d'information sont très consultées.

Merci par avance.

Bien à vous,

⟬person_name#1f⟭
Chargée de communication
Mail : ⟬email#1⟭
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: fr
fill_locale: fr_FR
domain: banking
appearance: first paragraph, key value, numbered list, pipe table
scenario: a client's security questionnaire, was flagged by an audit
⟬text⟭
Compte rendu de réunion, questionnaire de sécurité du client

La réunion s'est tenue le ⟬date#2⟭ dans les locaux du client, au ⟬fr_postal_address#1⟭, en présence de ⟬person_name#1f⟭, directrice des risques, qui nous a accueillis. Pour la salle de réunion, le Wi-Fi invité demandait le mot de passe ⟬password#1⟭, ce qui a d'ailleurs fait sourire tout le monde vu le sujet du jour.

1. Rappel du contexte

Le questionnaire de sécurité rempli pour ce client lors du renouvellement a été repris par son audit interne.
L'audit relève des réponses imprécises sur douze questions et des contradictions sur trois autres.
Le client demande un questionnaire corrigé avant la prochaine revue de ses prestataires.

2. Points relevés par l'audit

| Thème | Constat | Niveau |
|---|---|---|
| Chiffrement | algorithme non précisé | moyen |
| Sauvegardes | fréquence contradictoire | élevé |
| Accès administrateurs | MFA déclaré mais périmètre flou | élevé |
| Sous-traitants | liste incomplète | moyen |
| Plan de continuité | date du dernier test absente | élevé |

3. Causes identifiées de notre côté

Le questionnaire a été rempli à partir d'une version ancienne, sans relecture de l'équipe sécurité.
Les réponses types n'ont pas été mises à jour depuis la migration vers le nouveau centre de données.
Personne n'est désigné pour valider un questionnaire avant son envoi.

4. Engagements pris en séance

a. Corriger les douze réponses imprécises sous quinze jours.
b. Lever les trois contradictions avec des preuves datées.
c. Fournir le rapport du dernier test de continuité, expurgé.
d. Mettre à jour la liste des sous-traitants, y compris ⟬trap:company_name|⦃Family⦄ Infogérance⟭.

5. Organisation interne

L'équipe sécurité devient propriétaire des réponses types.
L'avant-vente ne peut plus envoyer un questionnaire sans sa validation.
Un référentiel unique remplace les fichiers épars.
Une revue semestrielle de ce référentiel est ajoutée au plan de contrôle permanent.

6. Échanges avec le client

Le client préfère une seule version consolidée plutôt que des corrections au fil de l'eau.
Il accepte une réunion de relecture avant l'envoi définitif.
Il rappelle que l'audit pourra demander des preuves complémentaires lors de la revue.

7. Risques

Si le questionnaire n'est pas corrigé à temps, le client peut suspendre le renouvellement.
La charge pèse surtout sur l'équipe sécurité, déjà mobilisée sur la certification.
Le départ prévu d'un des deux analystes réduit encore la marge disponible.
La direction des opérations pourra prêter une personne pendant deux semaines.

8. Prochaines étapes

- Envoi de la première version corrigée en interne, sous dix jours.
- Relecture par la conformité.
- Réunion de relecture avec le client.
- Envoi définitif avant le ⟬date#1⟭.

Fin de la réunion à 16 h 30.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: public administration
appearance: subject line, prose, numbered list
scenario: the API rate limiter, was rolled back
⟬text⟭
Objet : RE: « plus rien ne passe, tél. ⟬phone#1⟭ » - retour arrière du limiteur de débit

Bonjour,

Nous faisons suite au message de l'éditeur de logiciels métiers que vous nous avez transféré.
Il signalait que ses appels à l'API de la plateforme de données locales étaient refusés depuis la veille,
ce qui empêchait plusieurs communes de transmettre leurs délibérations.

Après vérification, le nouveau limiteur de débit comptait les appels par adresse IP et non par application.
Or cet éditeur fait passer les appels de toutes les communes par une seule passerelle.
Il a donc atteint le plafond en quelques minutes.

Nous avons procédé comme suit :

1. Retour arrière du limiteur vers la version précédente.
2. Vérification du passage des délibérations en attente.
3. Prévenance de l'éditeur, qui confirme le retour à la normale.

Le limiteur sera redéployé après adaptation, avec un comptage par clé d'application.
Une date vous sera communiquée lorsque les tests seront terminés.

Nous vous prions d'excuser la gêne occasionnée.

Cordialement,

La cellule Plateforme de données
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: key value, prose
scenario: the feature flag cleanup, needs a temporary workaround
⟬text⟭
Objet : Nettoyage des feature flags, contournement temporaire

Bonjour ⟬trap:indicator_non_pii|à tous⟭,

Le retrait du flag `checkout_v3` prévu le ⟬date#1⟭ est reporté : la version ⟬version#1⟭ du module de paiement en dépend encore.
En attendant la ⟬version#2⟭, le flag reste actif et sa valeur est forcée à vrai.

Responsable : ⟬trap:indicator_non_pii|équipe Tunnel d'achat⟭
Suivi : ⟬ticket_id#1⟭
⟬end⟭
