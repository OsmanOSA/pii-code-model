⟬template⟭
family: natural
format: chat message (Slack, Teams)
language: mixed
fill_locale: mixed
domain: recruiting
appearance: prose, pasted line
scenario: an HR assistant confirms a start date and the first-day schedule
⟬text⟭
C'est bon, ta start date est confirmée au ⟬date#1⟭ 🎉
Programme du jour 1 : 9h welcome coffee, 10h IT setup, 12h30 team lunch, 14h onboarding session.
Viens avec une pièce d'identité pour le badge, le reste on gère.
⟬iban#1⟭
oups pardon mauvais copier-coller depuis le fichier paie, oublie la ligne du dessus 🙈
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: customer support
appearance: prose
scenario: a customer asks why their loyalty points vanished
⟬text⟭
Hi, my 1,240 points vanished overnight alors que j'ai commandé le ⟬date#1⟭ ; je préfère pas mettre mes infos de compte ici, dites-moi où vous les envoyer en privé.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: customer support
appearance: prose, bare list, sign-off
scenario: a user asks to delete their account
⟬text⟭
Hello,

Je pars vivre à l'étranger et je pourrai bientôt plus me connecter, so please close my account and delete everything you hold.
Your form wants proof of identity and refund details, alors voilà de quoi tout faire à ma place sans revenir vers moi :

- ⟬person_name#1⟭
- ⟬fr_postal_address#1⟭
- ⟬fr_social_security_number#1⟭
- ⟬fr_passport#1⟭
- ⟬iban#1⟭ pour les 12,40 € qui restent sur le solde

Une fois fait, un simple message de confirmation me suffit.
Thanks,
⟬person_name:given#1⟭
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams)
language: mixed
fill_locale: mixed
domain: networking
appearance: prose, sign-off
scenario: a student asks a professional for a short call
⟬text⟭
hi, M2 student here, mon prof m'a filé ⟬email#1⟭ as the person to ask for a 15 min call about PMM work, c'est toujours à jour ?
merci d'avance 🙏
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: mixed
fill_locale: mixed
domain: recruiting
appearance: prose, quoted message
scenario: a recruiter explains how to reach a plant for a site visit
⟬text⟭
Je te remets le message de l'usine ⟬trap:company_name|⦃Family⦄ Logistique⟭ pour jeudi, comme ça tu l'as sous la main :
> Site visit at ⟬fr_postal_address#2⟭, gate B, ask for ⟬person_name#1⟭ at the security desk. Safety shoes provided.
> Depuis la gare compter 10 min de taxi, the shuttle stops at 6pm.
Arrive un peu en avance, le parking visiteurs est à droite après la barrière.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: freelance missions
appearance: prose, pasted line
scenario: a private tutor bills the month's lessons to a parent
⟬text⟭
SIRET ⟬fr_siret#1⟭ · tel ⟬phone#1⟭ · IBAN ⟬iban#1⟭ (pardon, collé depuis le pied de ma facture, ça devait pas être là)

Voici le récap du mois : 8 cours de maths à 30 €, soit 240 €, le cours annulé tardivement n'est pas facturé.
Invoice attached, règlement sous 15 jours si possible.
On reprend mardi à 17h comme d'hab, the mock exam went really well btw.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: customer support
appearance: prose, bullet list
scenario: a customer asks for an invoice in their company's name
⟬text⟭
Bonjour,
could you reissue ⟬invoice_number#1⟭ au nom de ⟬company#1⟭ ? The one I got is in my personal name and our accounting won't take it.
Pour régler ça :
- nouvelle facture au nom de la société, même montant
- les 48 € payés deux fois, à reverser sur ⟬iban#1⟭
- un mot quand c'est parti
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: networking
appearance: prose, quoted field
scenario: someone asks to reuse a slide from a talk
⟬text⟭
Salut,

Encore bravo pour ton talk à ⟬city#1⟭ le ⟬date#1⟭, la salle était conquise.
Je prépare une session interne sur le recrutement et j'aimerais reprendre ta slide "the ⟬trap:eponym|Pareto⟭ rule of hiring", celle avec la courbe.
Je la garderais telle quelle, avec ton nom dessus et le lien vers la vidéo.

Sur la page de l'événement ta fiche dit "contact: ⟬trap:indicator_non_pii|via the organisers⟭" et eux répondent pas, d'où ce message un peu au hasard.
Si tu préfères que je passe par ton agence, pas de souci.
It's for about 40 people, internal only, not recorded.
Let me know if that's OK, ou si tu veux relire le contexte avant.

À bientôt j'espère,
⟬trap:initials|AL⟭
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: mixed
fill_locale: mixed
domain: recruiting
appearance: prose, bullet list
scenario: a candidate asks about the company car policy before accepting
⟬text⟭
Avant de signer j'ai une question sur la car policy, votre offre dit juste "company car, grade C".
Ce que j'aimerais savoir :
- électrique obligatoire ou une ⟬trap:company_name|Peugeot⟭ thermique reste possible ?
- carte carburant incluse pour les trajets perso ?
- on m'a dit de voir avec le fleet manager, tel ⟬phone#1⟭, c'est bien ⟬person_name#1m⟭ ?
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: mixed
fill_locale: mixed
domain: recruiting
appearance: prose, inline list, sign-off
scenario: a candidate reports a broken link in the application form
⟬text⟭
Le lien "Apply now" de votre annonce Customer Success renvoie une 404 depuis hier.
Le formulaire de secours plante à l'étape 3 avec "Session expired, please restart your application", and the page title shows `⟬trap:code_identifier|apply_⦃family⦄_form⟭`.
Testé sur Chrome et Firefox, et sur mobile, même résultat.

Comme la clôture est vendredi je passe par ici.
Ce formulaire demandait juste nom complet, date de naissance, adresse et téléphone.
Tu peux transférer à ta collègue qui gère le poste ? Même ordre que le formulaire, je mets ça à la fin pour que ce soit facile à copier.

⟬person_name#1⟭ / ⟬birth_date#1⟭ / ⟬fr_postal_address#1⟭ / ⟬phone#1⟭

Merci, bonne journée !
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: freelance missions
appearance: prose, quoted message
scenario: a photographer confirms the time and place of a shoot
⟬text⟭
C'est tout bon de mon côté, je confirme pour samedi.

Rendez-vous 8h30 rue ⟬trap:word_name|Victor Hugo⟭, devant la boulangerie, avant que le soleil passe derrière l'immeuble.
On commence par la façade en ⟬trap:word_name|pierre⟭ blonde, la lumière reste douce jusqu'à 10h.
Ensuite on descend à pied au jardin, le long du massif de ⟬trap:word_name|marguerites⟭, et on finit sur le quai, côté ⟬trap:word_name|Saint-Pierre⟭.

Pour les tenues, évite le blanc pur : la robe ⟬trap:word_name|prune⟭ marchera mieux avec le mur, et la veste ⟬trap:word_name|rose⟭ poudré pour les portraits.
Prévois une bouteille de ⟬trap:word_name|Margaux⟭ si tu veux le plan "table dressée", sinon j'amène un accessoire neutre.

Backup plan if it rains: on se replie au café ⟬trap:word_name|Olive⟭, ils nous laissent la salle du fond jusqu'à midi.
No permit needed for the quay as long as we stay under 5 people and don't use a tripod.

Je t'envoie la liste des plans demain soir.
À samedi 📷

> jeudi à 18:12, tu as écrit :
> Hi! Can you confirm the time and place for Saturday? The client wants the golden hour look
> et on n'a qu'une matinée. On avait parlé du quartier ⟬trap:word_name|Sainte-Marie⟭, c'est toujours ok ?
> Also, do we need a permit for the quay?
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams)
language: mixed
fill_locale: mixed
domain: recruiting
appearance: prose, mid-sentence
scenario: a hiring manager asks a recruiter for feedback on a junior profile
⟬text⟭
hey ⟬trap:email_lookalike|@recruiting⟭ any feedback on the junior profile I sent? le candidat ⟬person_name#1m⟭ m'a relancé deux fois et je dois clore la req vendredi
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: freelance missions
appearance: prose, signature
scenario: a client cancels a workshop the day before
⟬text⟭
Hi,

Mille excuses de te prévenir si tard : on doit annuler l'atelier de demain sur le diagramme de ⟬trap:eponym|Gantt⟭.
Our CEO just moved the board meeting to the same slot and half the participants are in it.
Je sais que t'as préparé les supports et bloqué ta journée, donc on te paie la préparation quoi qu'il arrive.
Could you send me your dates for the next two weeks? Même format, 10h-16h, même salle, la ⟬trap:word_name|Clémentine⟭ au 2e.
Si t'as imprimé des trucs, garde-les, on s'en servira.

--
⟬person_name#1⟭
Head of People, ⟬company#1⟭
⟬fr_postal_address#1⟭
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: customer support
appearance: prose, mid-sentence
scenario: a buyer describes a bad experience with a shop
⟬text⟭
Bonjour ⟬trap:indicator_non_pii|le service client⟭,

Je vous écris après ma visite à votre magasin de ⟬city#2⟭ le ⟬date#1⟭, et je suis encore énervée.
J'étais venue rapporter un aspirateur acheté trois semaines plus tôt, ticket en main, sous garantie.
Le vendeur m'a d'abord renvoyée vers le SAV en ligne, et quand j'ai insisté le responsable, Monsieur ⟬person_name:family#1m⟭, m'a dit devant tout le monde que "no refund means no refund", en anglais dans le texte, parce que c'est ce qu'affiche sa caisse.
Personne n'a regardé l'appareil, personne n'a proposé d'échange.
J'ai fait 40 minutes de route pour ça.

Je demande un remboursement ou un échange, pas un bon d'achat.
Thanks for reading this far, je sais que c'est long.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: networking
appearance: prose, quoted message
scenario: a contact asks for an introduction to a journalist
⟬text⟭
Hi,

Hope the move to ⟬city#1⟭ went well and the boxes are finally gone.
Quick favour, and feel free to say no.

Our study on second careers comes out on ⟬date#1⟭, et on aimerait qu'elle sorte ailleurs que sur notre blog.
Tu m'avais parlé de la journaliste qui tient la rubrique emploi du quotidien éco, celle du dossier sur les reconversions.
Could you introduce me? Deux lignes suffisent, je m'occupe du reste.

We surveyed people who changed sector. One respondent went back to school at ⟬age#1⟭, which I think is the hook.
Data's solid, methodology note attached, et pas de pub pour notre boîte dans le texte.
If she prefers a phone call to a press release, even better.

Merci d'avance, et si c'est gênant je comprendrai,
⟬trap:initials|T.L.⟭

> Le ⟬date#2⟭, tu as écrit :
> Salut, j'ai quitté ⟬city#2⟭ pour de bon, nouvelle vie, nouvelle boîte.
> Si je peux t'aider côté presse, fais-moi signe.
> Elle a sorti un super papier sur le ⟬trap:eponym|Peter⟭ principle au bureau, tu l'as vu ?
> On se voit à la rentrée ?
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams)
language: mixed
fill_locale: mixed
domain: customer support
appearance: prose, mid-sentence
scenario: a client asks a hotel to change a booking
⟬text⟭
bonjour, je vous écris pour la résa au nom de ⟬person_name#1⟭, 2 nuits mi-mars. Can we move it to the following weekend?
Le mariage a été décalé, la salle est au ⟬fr_postal_address#2⟭ donc il nous faut vraiment un hôtel pas loin, et si votre navette y va encore tant mieux.
Si c'est compliqué rappelez-moi, mon tel ⟬phone#1⟭ marche après 18h, thanks !
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: mixed
fill_locale: mixed
domain: networking
appearance: prose, afterthought
scenario: a founder asks for an introduction to an investor
⟬text⟭
Hi ⟬trap:indicator_non_pii|there⟭! We're closing a seed round for our climate-data startup, 14 paying clients, et je cherche une intro vers ⟬company#1⟭, le fonds qui a mené le tour de ton ancienne boîte.
Two lines from you would open more doors than my cold emails ever will.
Si tu veux le deck avant, je te l'envoie.
Ah et au fait, ton ancien associé M. ⟬person_name:family#1m⟭ est toujours chez eux ? Ça pourrait aider.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: networking
appearance: prose, opening sentence, bullet list
scenario: a speaker sends their details for a conference badge
⟬text⟭
Pour ta collègue aux badges : ⟬person_name#1f⟭, née le ⟬birth_date#1⟭, adresse ⟬postal_address#1⟭, tel ⟬phone#1⟭, forward it as is, it's all she asked for.
Nom sur le badge : ⟬trap:indicator_non_pii|comme sur le programme⟭.
(Oui ça fait beaucoup pour un badge mais le lieu est un site sécurisé, the venue wants the full list 48 hours ahead.)

Pour le reste de la conf :
- je parle le ⟬date#1⟭ à 11h, slot de 25 min plus questions
- j'arrive la veille au soir de ⟬city#1⟭
- il me faudra un adaptateur HDMI, mon laptop n'a que de l'USB-C
- pas de dîner speakers pour moi, désolée, I'll be rehearsing

Si ta collègue a un souci avec la carte d'accès, qu'elle m'appelle plutôt que de repasser par les organisateurs.
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: mixed
fill_locale: mixed
domain: freelance missions
appearance: prose, bullet list, form field
scenario: a consultant proposes a day rate for a three-week mission
⟬text⟭
Salut,

Comme promis après notre call, ma proposition pour l'audit de votre app ⟬trap:library|Django⟭ :
- 850 €/jour HT, soit 12 750 € pour 15 jours
- 2 jours sur site, le reste en remote
- kick-off possible dès le ⟬date#1⟭

Two things are still open on your side.
Contact côté client : ⟬trap:indicator_non_pii|TBD⟭, il m'en faut un avant de démarrer.
Numéro de bon de commande : ⟬trap:indicator_non_pii|pending⟭, ma compta va me le réclamer.

Si le budget coince, je peux retirer la partie sécu et descendre à deux semaines.
Dis-moi ce que t'en penses.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: mixed
fill_locale: mixed
domain: recruiting
appearance: prose, signature
scenario: a candidate asks why they heard nothing after a second interview
⟬text⟭
Subject: any news?
Second interview on ⟬date#1⟭ with the product team, et depuis plus rien, même pas un "no thanks".
Un simple oui ou non me suffit, j'ai une autre offre à traiter d'ici vendredi.

⟬person_name#1⟭
⟬email#1⟭
⟬end⟭
