⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: fr
fill_locale: fr_FR
domain: customer support
appearance: support chat, one line per turn, phone near the end
scenario: a user asks how to export their data
⟬text⟭
Bonjour, comment je peux exporter toutes mes données depuis l'application ?
Bonjour, je regarde ça avec vous.
Vous êtes sur la version web ou mobile ?
web
Allez dans Paramètres, puis Compte.
ok
Il y a une ligne Confidentialité en bas de page ?
oui
Cliquez dessus, puis sur Télécharger mes données.
ça me propose CSV ou JSON
Prenez le format que vous préférez, le CSV s'ouvre dans un tableur.
CSV alors
Vous recevrez un lien par mail sous 24 h.
il contient les factures aussi ?
Oui, les factures sont dans un dossier à part.
et les photos ?
Les photos s'exportent séparément, depuis la galerie.
ok merci
Si le lien n'arrive pas, notre tel : ⟬phone#1⟭, demandez le support niveau 2.
parfait bonne journée
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: fr
fill_locale: fr_FR
domain: sales prospecting
appearance: one line, contact in the middle of a sentence
scenario: a training organisation promotes a course to HR managers
⟬text⟭
Bonjour, notre formation sur l'entretien annuel reprend en mars, ⟬person_name#1⟭ peut vous en parler au ⟬phone#1⟭ ou sur ⟬email#1⟭ si ça concerne vos managers.
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: fr
fill_locale: fr_FR
domain: recruiting
appearance: company named after a family, announcing word with a harmless value
scenario: a manager tells a candidate the job changed after a reorganisation
⟬text⟭
désolé, depuis le rachat par ⟬trap:company_name|Bouygues⟭ le poste a changé, responsable : ⟬trap:indicator_non_pii|à nommer⟭, on en reparle ?
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: freelance missions
appearance: signature line with no name
scenario: a coach moves a session after a train strike
⟬text⟭
Grève demain, je décale notre séance à jeudi même heure, ça vous va ?
⟬fr_postal_address#1⟭ · ⟬email#1⟭
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: fr
fill_locale: fr_FR
domain: personal life
appearance: dash list of details, car brand, plate after its label
scenario: a neighbour warns about a car blocking the driveway
⟬text⟭
salut les voisins
y a encore une voiture garée devant le portail ce matin
je peux pas sortir et je dois emmener ma mère à l'hôpital à 10h
quelqu'un sait à qui elle est ?
j'ai noté :
- couleur : blanche
- marque : ⟬trap:company_name|Citroën⟭
- plaque : ⟬fr_license_plate#1⟭
si personne répond j'appelle la fourrière
merci de faire tourner
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: fr
fill_locale: fr_FR
domain: networking
appearance: given name as the name of a room, announcing word with a harmless value
scenario: a speaker thanks the organiser of a meetup
⟬text⟭
merci pour hier soir, super orga ! speaker suivant : ⟬trap:indicator_non_pii|à confirmer⟭, et bravo pour la salle ⟬trap:word_name|Rose⟭, le cadre était top
⟬end⟭

⟬template⟭
family: natural
format: SMS
language: fr
fill_locale: fr_FR
domain: freelance missions
appearance: quote as a list of prices, name after an announcing word
scenario: a self-employed electrician sends a rough quote by message
⟬text⟭
Bonjour, suite à ma visite voici le devis rapide pour la cuisine
- tableau à refaire : 480 €
- 6 prises et 2 circuits : 320 €
- spots : 210 €
- déplacement offert
Total 1 010 € TTC
Je peux commencer la semaine prochaine
Contact pour le chantier : ⟬person_name#1⟭ qui m'aide sur la pose
Dites-moi si c'est bon pour vous
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: recruiting
appearance: full record restated with labels
scenario: an agency recruiter chases missing documents for a contract
⟬text⟭
Bonjour,
Il me manquait votre contrat signé, c'est bien reçu, merci.
Pour le dossier de paie j'ai noté, dites-moi si c'est juste : nom ⟬person_name#1⟭, passeport ⟬fr_passport#1⟭, adresse ⟬fr_postal_address#1⟭, mail ⟬email#1⟭, compte ⟬bank_account_number#1⟭.
Bonne journée
⟬end⟭

⟬template⟭
family: natural
format: social media comment
language: fr
fill_locale: fr_FR
domain: customer support
appearance: public reply from a brand, role mailbox in a dash list
scenario: a support agent explains a refund delay
⟬text⟭
Bonjour, nous sommes désolés pour ce retard, les remboursements prennent 10 jours ouvrés en ce moment.
Pour un suivi plus rapide, notre service litiges :
- mail : ⟬email:generic#1⟭
- tél : ⟬phone#1⟭
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: community
appearance: announcing word with a harmless value, details kept for later
scenario: a volunteer organises a beach clean-up
⟬text⟭
Nettoyage de la plage dimanche 9h, gants fournis. Inscriptions : ⟬trap:indicator_non_pii|par retour de mail⟭, je donne le point de rendez-vous en privé.
⟬end⟭

⟬template⟭
family: natural
format: SMS
language: fr
fill_locale: fr_FR
domain: personal life
appearance: amounts in a dash list, phone in the last item
scenario: a roommate asks for their share of the electricity bill
⟬text⟭
Facture d'élec arrivée : 84 € pour nous trois
- toi : 28 €
- moi : 28 €
- le nouveau coloc : 28 €, il est au ⟬phone#1⟭ si tu veux lui réclamer direct 😅
⟬end⟭

⟬template⟭
family: natural
format: SMS
language: fr
fill_locale: fr_FR
domain: sales prospecting
appearance: SMS in short lines, contact as an afterthought
scenario: a rep sends a case study after a call
⟬text⟭
Bonjour, merci pour l'échange de tout à l'heure
Je vous envoie par mail l'étude de cas du transporteur dont je vous parlais
En résumé : 30 % de temps gagné sur la planification
Et le retour sur investissement en 8 mois
Regardez surtout la page 4, c'est proche de votre activité
Je vous rappelle la semaine prochaine si ça vous va
Ah et si je suis en clientèle, mon collègue ⟬person_name#1m⟭, tel ⟬phone#1⟭, mail ⟬email#1⟭, a le dossier
Bonne soirée
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: fr
fill_locale: fr_FR
domain: recruiting
appearance: message thread about an unnamed person, labels with harmless values
scenario: a former colleague recommends someone for an open position
⟬text⟭
Salut,
J'ai vu que tu recrutais un chef de projet dans ton équipe.
J'ai travaillé trois ans avec quelqu'un qui serait parfait pour ce poste.
Elle a géré la refonte de notre ERP, budget tenu et équipe contente.
Elle cherche un poste plus proche de chez elle en ce moment.

Merci de penser à moi !
Tu peux m'en dire plus sur elle ?
C'est quoi son parcours exact ?
Elle a déjà managé en direct ?

Oui, une équipe de cinq pendant deux ans.
Avant elle était consultante dans un cabinet.
Très carrée sur les plannings, et agréable au quotidien.

Ça m'intéresse, tu peux me mettre en relation ?

Je lui demande d'abord son accord.
Nom : ⟬trap:indicator_non_pii|je te le donne si elle est d'accord⟭
Téléphone : ⟬trap:indicator_non_pii|pareil⟭
Je reviens vers toi dès que c'est bon.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: sales prospecting
appearance: name and email as an afterthought, after the closing
scenario: a rep asks a client for a referral
⟬text⟭
Bonjour,

Cela fait maintenant un an que vous utilisez notre logiciel de caisse, et j'espère que tout se passe bien.
Les retours de votre équipe sont très bons, notamment sur la gestion des stocks.
Nous lançons un programme de parrainage pour les commerçants de la région.
Si vous connaissez un confrère que ça pourrait intéresser, un simple nom suffit.
Vous auriez deux mois offerts pour chaque client parrainé.
Aucune obligation bien sûr, et merci pour votre confiance.

Je vous souhaite une belle journée,

Au fait, mon remplaçant pendant mes congés sera ⟬person_name#1m⟭, ⟬email#1⟭.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: personal life
appearance: full record as an afterthought, values with no label, context in the sentence before
scenario: a relative sends news after a hospital visit
⟬text⟭
Nouvelles de mamie : l'opération s'est bien passée, elle rentre en fin de semaine si tout va bien.
Elle te demande de t'occuper du dossier d'aide à domicile, il faut sa date de naissance et ses coordonnées bancaires pour la caisse.
Ah et tant que j'y pense : ⟬person_name#1f⟭, ⟬birth_date#1⟭, ⟬fr_postal_address#1⟭, ⟬iban#1⟭ (⟬bank_account_number#1⟭).
Bisous à tous
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: customer support
appearance: name after an announcing word in the opening line, the mail is about a price
scenario: a subscriber asks for a discount to stay
⟬text⟭
Interlocuteur habituel : ⟬person_name#1⟭, du service abonnés, qui m'a conseillé de vous écrire.

Bonjour,

Mon forfait passe à 34,99 € le mois prochain, alors que les nouveaux clients paient 19,99 €.
Je suis abonné depuis six ans et je n'ai jamais eu de retard de paiement.
J'ai reçu une offre à 22 € chez un concurrent pour le même débit.
Je préfère rester chez vous, mais pas à ce prix.
Pouvez-vous me faire un geste sur les douze prochains mois ?

Merci de votre retour,
Cordialement
⟬end⟭

⟬template⟭
family: natural
format: social media comment
language: fr
fill_locale: fr_FR
domain: community
appearance: post and comments, pseudonyms, contact in the post's list
scenario: a parents' association asks for cake donations
⟬text⟭
L'asso des parents cherche des gâteaux pour la kermesse de samedi ! 🍰
On a besoin de :
- 10 gâteaux au yaourt
- 10 cakes salés
- des crêpes si quelqu'un se sent de les faire
Dépôt à partir de 9h sous le préau, pas de fruits à coque svp.
Pour s'organiser : ⟬person_name#1⟭ ⟬phone#1⟭

maman_de_3 : je fais un cake olives-feta
poussette_turbo : deux gâteaux au yaourt pour moi
crepes_et_co : des crêpes ok, mais il me faut une plaque sur place
maman_de_3 : il y aura une prise au préau ?
team_buvette : oui, deux prises près de la buvette
le_voisin_du_4 : on peut apporter le gâteau le vendredi soir ?
team_buvette : oui, l'école ouvre jusqu'à 18h
solfege_et_rock : il reste de la place pour tenir la buvette ?
team_buvette : toujours, on manque de monde à partir de 14h
poussette_turbo : je peux faire 14h-15h
Merci à tous, ça va être une belle fête ❤️
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: fr
fill_locale: fr_FR
domain: networking
appearance: one line, full contact of a third person
scenario: someone recommends an accountant to a contact
⟬text⟭
Pour ta compta, je te recommande vivement ⟬person_name#1⟭, ⟬phone#1⟭ ou ⟬email#1⟭, de ma part !
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: fr
fill_locale: fr_FR
domain: recruiting
appearance: company named after a family, one line
scenario: a candidate asks whether the job can be part-time
⟬text⟭
Bonjour, le poste chez ⟬trap:company_name|Lacoste⟭ peut-il se faire à 80 % ? Merci d'avance.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: fr
fill_locale: fr_FR
domain: personal life
appearance: dash list for the school run, name in one item
scenario: a parent reminds the other about the school run
⟬text⟭
Coucou,

Je pars tôt demain, tu gères l'école s'il te plaît.
Rappel pour ne rien oublier :
- sac de piscine dans l'entrée
- le goûter est sur le plan de travail
- sortie à 16h30, c'est ⟬person_name#1⟭ qui la ramène si tu es en retard
- le mot pour la sortie à signer

Je rentre vers 20h.
Bisous
⟬end⟭
