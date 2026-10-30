⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: fr
fill_locale: fr_FR
domain: freelance missions
appearance: short chat, details kept for later
scenario: an illustrator negotiates usage rights for a poster
⟬text⟭
bonjour ! pour l'affiche du festival je vous cède l'usage print en région, pas le web ni le merch
si vous voulez tout c'est 40 % de plus sur le devis
le détail des droits je vous l'envoie en privé, c'est plus simple
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: community
appearance: opening line with an announcing word
scenario: a choir member announces a rehearsal change
⟬text⟭
Adresse de la répét de mardi : ⟬fr_postal_address#1⟭, chez ⟬person_name#2⟭, la salle habituelle est prise.
Même heure, apportez vos partitions.
⟬end⟭

⟬template⟭
family: natural
format: social media comment
language: fr
fill_locale: fr_FR
domain: personal life
appearance: comment in short lines, phone with no announcing word, emoji
scenario: a friend congratulates a couple on their engagement
⟬text⟭
Félicitations à vous deux !!! 💍🥂
Je suis tellement heureuse pour vous
Ça fait des années qu'on attendait ça haha
Et la bague est magnifique, je veux tous les détails
Vous avez déjà une date ?
Si vous cherchez un DJ, mon cousin fait ça et il a assuré au mariage de ma sœur
Appelez-le de ma part au ⟬phone#1⟭
Gros bisous les amoureux ❤️
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: freelance missions
appearance: full record in a P.S., slash-separated values, context earlier in the mail
scenario: a client asks a freelancer to sign a confidentiality agreement
⟬text⟭
Bonjour,

Merci pour le kick-off de lundi, on est ravis de démarrer avec vous.
Avant de vous ouvrir les accès, notre juridique a besoin d'un accord de confidentialité signé.
Vous le trouverez en pièce jointe, c'est le modèle standard, deux pages.
Il faudrait nous le retourner signé d'ici vendredi si possible.

Comme votre sous-traitante vient aussi sur site, la sécurité m'a demandé son domicile, son RIB pour les frais et son permis pour le parking.

Bonne journée,

PS : je transfère ce que vous m'avez envoyé : ⟬person_name#1f⟭ / ⟬fr_postal_address#1⟭ / ⟬iban#1⟭ / ⟬fr_driving_licence#1⟭
⟬end⟭

⟬template⟭
family: natural
format: SMS
language: fr
fill_locale: fr_FR
domain: recruiting
appearance: SMS thread with quoted replies, contact in a sentence
scenario: an intern asks a former tutor for a reference
⟬text⟭
Bonjour, c'est votre ancienne stagiaire du service qualité 🙂
J'espère que vous allez bien
Je postule chez un sous-traitant auto et ils demandent une référence
Est-ce que je peux donner votre nom ?
> Bonjour ! Oui bien sûr, avec plaisir
> Par contre je change de poste le mois prochain
> Donne plutôt ⟬person_name#1⟭, ⟬phone#1⟭, qui me remplace et qui t'a bien connue
Super merci beaucoup
Je lui envoie un message ce soir
Bonne soirée !
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: networking
appearance: company named after a family, announcing word with a harmless value
scenario: a contact sends new year wishes and proposes catching up
⟬text⟭
Bonne année à toi et aux tiens ! 🎉
Ça fait un bail, tu bosses toujours sur la migration chez ⟬trap:company_name|Michelin⟭ ?
On pourrait se voir un midi en janvier si tu passes sur Lyon.
Mon contact n'a pas changé : ⟬trap:indicator_non_pii|le même qu'avant⟭
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: fr
fill_locale: fr_FR
domain: customer support
appearance: full record on one line, labels, someone acting for a parent
scenario: a support agent asks to confirm a detail before making a change
⟬text⟭
Bonjour, avant de changer le RIB sur le contrat de ma mère je dois confirmer ses infos ?
Je m'en occupe pour elle, elle ne sait pas utiliser l'appli.
Voilà : titulaire ⟬person_name#1f⟭, née le ⟬birth_date#1⟭, domicile ⟬fr_postal_address#1⟭, nouvel IBAN ⟬iban#1⟭
Merci à vous
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: fr
fill_locale: fr_FR
domain: sales prospecting
appearance: sales pitch, notes pasted by mistake in a dash list
scenario: a reseller proposes a bundle to a small shop
⟬text⟭
Bonjour,

Je vois que votre boutique vend surtout du matériel de randonnée.
On distribue un pack caisse, terminal et étiqueteuse pour les petits commerces.
Le pack revient à 39 € par mois, sans engagement, installation comprise.
Plusieurs magasins de votre rue l'ont déjà pris.
Si ça vous parle je passe vous le montrer.

(désolé, mes notes de tournée se sont collées dans le message)
- RDV jeudi : ⟬person_name#1⟭
- tel : ⟬phone#1⟭
- mail : ⟬email#1⟭
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: freelance missions
appearance: name inside a dash list, the mail is about a project
scenario: a client changes the scope in the middle of a sprint
⟬text⟭
Salut,

Désolé de te prévenir en plein sprint, mais la direction veut changer le périmètre.
On enlève l'export PDF et on ajoute la connexion à l'agenda.
Je sais que ça bouscule ton planning, on peut revoir le forfait si besoin.

Ce qui change concrètement :
- l'export passe au sprint suivant
- la maquette agenda arrive mercredi, ⟬person_name#1⟭ la valide
- la démo reste vendredi

Dis-moi si ça te paraît tenable.
⟬end⟭

⟬template⟭
family: natural
format: social media comment
language: fr
fill_locale: fr_FR
domain: community
appearance: short comment, announcing word with a harmless value, emoji
scenario: a volunteer registers for a charity race
⟬text⟭
Inscrite pour la course ! Dossard pris, mon numéro : ⟬trap:indicator_non_pii|en MP⟭ 🏃‍♀️
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: customer support
appearance: address in a sentence, no announcing word
scenario: a customer asks for a paper copy of a contract
⟬text⟭
Bonjour,
Je n'arrive pas à télécharger mon contrat depuis l'espace client, le lien tourne dans le vide.
Pouvez-vous m'en envoyer une copie papier, à ⟬fr_postal_address#1⟭ ?
Merci
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: fr
fill_locale: fr_FR
domain: sales prospecting
appearance: message thread, name and phone in a P.S.
scenario: a prospect asks for pricing details
⟬text⟭
Bonjour,
Votre plateforme de réservation m'intéresse pour nos trois salles de sport.
Sur votre site je ne vois pas de tarif pour plusieurs sites.
Vous facturez à la salle ou au nombre d'abonnés ?

Bonjour et merci pour votre message.
On facture à la salle, avec un palier selon le volume.
De 1 à 3 salles c'est le même tarif unitaire.
Vous avez combien d'abonnés actifs à peu près ?

Environ 1 400 en tout, surtout sur une salle.
Il y a des frais d'installation ?
Et la reprise de nos données actuelles ?

L'installation est offerte à partir de deux salles.
La reprise est comprise si votre export est propre.
Je peux vous préparer un devis sur cette base.

Oui volontiers, avec une option paiement mensuel.
Merci pour la réactivité.

P.S. : pour la suite voyez avec ⟬person_name#1⟭, ⟬phone#1⟭, je pars en congés.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: personal life
appearance: bank details of a craftsperson in the first sentence
scenario: siblings split the cost of a present
⟬text⟭
Le cadre pour papa est prêt, l'encadreuse veut être payée d'ici vendredi : ⟬iban#1⟭, et pour sa facture ⟬fr_siren#1⟭.
On fait 40 € chacun ?
⟬end⟭

⟬template⟭
family: natural
format: SMS
language: fr
fill_locale: fr_FR
domain: recruiting
appearance: name as the first word, one line
scenario: a recruiter asks whether a notice period can be shortened
⟬text⟭
⟬person_name#1⟭ me dit que vous seriez libre plus tôt que prévu, on peut raccourcir le préavis à un mois ?
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: networking
appearance: plain prose, details kept for a private message
scenario: a former colleague proposes a coffee next time they are in town
⟬text⟭
Salut,

Je passe à Nantes la semaine prochaine pour un client, ça fait trop longtemps !
Tu serais dispo pour un café ? Mardi en fin de journée ou mercredi matin, je m'adapte.
J'aimerais bien savoir comment ça se passe depuis ton changement d'équipe.
Et je te raconterai le rachat, il y a des choses que je préfère ne pas écrire ici.
Je t'envoie mon nouveau numéro par message privé.

À très vite,
⟬end⟭

⟬template⟭
family: natural
format: forum post
language: fr
fill_locale: fr_FR
domain: community
appearance: forum post, logistics in the last line, no announcing word
scenario: volunteers share the rota for a charity shop
⟬text⟭
Planning de la boutique solidaire : lundi et jeudi matin on est complets, il manque du monde samedi après-midi.
Merci de noter vos créneaux sur le fil, même une heure ça aide.
Pour les dépôts de dons c'est toujours ⟬fr_postal_address#1⟭, clé chez ⟬person_name#2⟭, ⟬phone#2⟭
Merci à toutes et tous
⟬end⟭

⟬template⟭
family: natural
format: social media comment
language: fr
fill_locale: fr_FR
domain: personal life
appearance: email pasted in the middle of a comment, apology after it
scenario: a relative asks for photos from a wedding
⟬text⟭
Superbes photos du mariage !! 😍
Vous pourriez m'envoyer celles du vin d'honneur, je suis sur aucune ⟬email#1⟭ 😂
pardon collé ça par erreur, je voulais dire envoyez-les sur le groupe
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: freelance missions
appearance: password in the opening line, wrong copy and paste
scenario: a community manager asks for access to a client's page
⟬text⟭
Mot de passe : ⟬password#1⟭ (pardon, ça c'est pour ⟬person_name#2⟭, mauvais copier-coller, oubliez)
Bonjour, pour lancer la campagne de lundi j'ai besoin d'un accès éditeur à votre page.
Vous pouvez m'ajouter depuis les paramètres, rubrique rôles ?
Merci !
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: fr
fill_locale: fr_FR
domain: networking
appearance: company named after a family, announcing word with a harmless value
scenario: a consultant asks to be introduced to a purchasing manager
⟬text⟭
Bonjour, vous connaissez quelqu'un aux achats chez ⟬trap:company_name|Peugeot⟭ ? Nom du contact : ⟬trap:indicator_non_pii|à trouver⟭ 🙂
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: fr
fill_locale: fr_FR
domain: networking
appearance: full record in a sentence with no labels, context earlier in the message
scenario: an expert proposes a joint webinar
⟬text⟭
Bonjour,

Merci encore pour votre proposition de webinaire à deux, le sujet me plaît beaucoup.
Je vous propose un jeudi à 11h le mois prochain, 30 minutes chacun et 15 minutes de questions.
Votre service événementiel m'a demandé mes coordonnées et ma date de naissance pour le contrat d'intervenant.
Je vous laisse tout ça ici, ⟬person_name#1⟭ ⟬birth_date#1⟭ ⟬fr_postal_address#1⟭ ⟬email#1⟭ ⟬phone#1⟭ et vous transmettez.
Côté contenu, je prépare les slides sur la partie réglementaire.
Vous gardez l'étude de cas ?

À bientôt,
⟬end⟭
