⟬template⟭
family: natural
format: LinkedIn message
language: en
fill_locale: en_GB
domain: networking
appearance: greeting, labelled lines, visible values only
scenario: an organiser sends the practical details of a breakfast
⟬text⟭
Good morning ⟬trap:indicator_non_pii|everyone⟭, thanks for signing up to the founders' breakfast! Practical details below so you don't have to dig through the thread.

Date: ⟬date#1⟭, doors 7.45, we start at 8 sharp
City: ⟬city#1⟭, the exact venue goes out the day before while the room gets confirmed
Host: ⟬trap:indicator_non_pii|chamber of commerce⟭
Contact: ⟬trap:indicator_non_pii|events team⟭
Wifi password: ⟬trap:placeholder|xxxx⟭ (it'll be on the wall)

Coffee and pastries are on the sponsor, so just bring yourself.
We'll wrap up by 9.30 so you're at your desk for 10.
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: en
fill_locale: en_GB
domain: networking
appearance: chat message, pasted form field, afterthought
scenario: a mentor sets the date of the next session
⟬text⟭
does thurs ⟬date#1⟭ at 5 work for our next session? same zoom link as last time
bring the deck, i want to go through slide 6 and the pricing page with you
Organiser: ⟬trap:indicator_non_pii|mentoring programme⟭ Attendees: ⟬person_name#1⟭
^ ignore that line, thats my calendar invite pasting itself in 😅
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: en
fill_locale: en_GB
domain: recruiting
appearance: plain prose, signature
scenario: a hiring manager asks a colleague to sit in on an interview
⟬text⟭
Could you sit in on the backend interview Thursday at 2? I'd like a second opinion on the system design round and you're the only one who's been near the billing service.
About an hour, no prep needed, I'll forward the CV tomorrow.

⟬person_name#1⟭
Engineering Manager, Platform
⟬phone#1⟭
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: en
fill_locale: en_GB
domain: sales prospecting
appearance: bullet list, practical details
scenario: a recruitment agency pitches its services to a founder
⟬text⟭
Congrats on the seed round! We place first engineers at early-stage startups, short version:
- 15% flat fee, nothing upfront
- shortlist in 10 working days
- account owner: ⟬trap:indicator_non_pii|our tech desk⟭
- reference: ⟬person_name#1⟭, CTO at ⟬company#1⟭, happy to vouch for us
Worth a quick call next week?
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: en
fill_locale: en_GB
domain: recruiting
appearance: plain prose
scenario: a recruiter apologises for mixing up two CVs
⟬text⟭
I owe you an apology, and I'd rather say it straight than hide behind a template.
Yesterday I sent the wrong CV along with your application pack. Two candidates, similar backgrounds, same afternoon, and I attached the wrong file.
The hiring manager spotted it straight away and nobody thought any less of you, if anything they were confused why a sales profile had turned up for a finance role 😬
Your own CV has now gone over and they've confirmed they have the right one.
I've also written to the other candidate.
I won't go into who it was or what was in it on here, but I'll give you the full picture in a private message so you know exactly what was seen.
It was my mistake, not a system problem, and it's been logged with our compliance lead, ⟬trap:initials|KT⟭.
Sorry again for the mess.
⟬end⟭

⟬template⟭
family: natural
format: SMS
language: en
fill_locale: en_GB
domain: freelance missions
appearance: pasted line, afterthought
scenario: a developer hands a project over at the end of a mission
⟬text⟭
All pushed, repo's yours and the ⟬trap:code_identifier|sync_⦃family⦄_orders⟭ cron is explained in the README
hosting login pwd ⟬password#1⟭, account owner ⟬person_name#1⟭ ⟬phone#1⟭ ARGH that bit was for the client's IT, pls delete
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: en
fill_locale: en_GB
domain: community
appearance: quoted message
scenario: neighbours look for a lost cat
⟬text⟭
Forwarding this from the close's group chat in case any of you are out tonight:

> ⟬trap:email_lookalike|@everyone⟭ our tabby hasn't been home since Sunday, grey collar, very shy, might be hiding in a shed. ⟬person_name#1⟭ ⟬phone#1⟭

Nothing in ours so far but I'll check the garage again at the weekend.
⟬end⟭

⟬template⟭
family: natural
format: social media comment
language: en
fill_locale: en_GB
domain: personal life
appearance: comment thread, indicator without value
scenario: a friend recommends a dentist
⟬text⟭
Anyone nervous about the dentist, ours is brillaint 🦷 Did a filling in 20 mins and I barely felt it

Which practice?? Is it ⟬trap:company_name|⦃Family⦄ Dental⟭? Been looking for ages

That's the one, above the chemist on the high street

Do they take NHS patients or private only

Both I think. There's a contact sheet at the desk with prices and the out of hours number

Is there a waiting list?

Was about 3 weeks for us

Their website says Phone: ⟬trap:indicator_non_pii|see reception⟭ which is helpful lol

Haha yes the site is ancient. No mail on there either, you have to actually go in

Who should I book with?
Ask for: ⟬trap:indicator_non_pii|the hygienist⟭ first, she'll sort you out

Do they do kids?

They do, ours won't go anywhere else now, it's the stickers

Wish I'd known before paying for that root canal 😭
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: en
fill_locale: en_GB
domain: sales prospecting
appearance: opening sentence, inline record
scenario: an insurance broker proposes reviewing a company's contracts
⟬text⟭
Forwarding what I've got on ⟬person_name#1⟭ of ⟬postal_address#1⟭, the MD of the haulage firm I pitched last week: ⟬birth_date#1⟭ / ⟬uk_driving_licence#1⟭ / ⟬iban#1⟭.
You'll need it to start the fleet quote for the contract review, since they're the named driver on the policy we're hoping to replace.
Underwriters want the licence, home details, a date of birth and the account for the direct debit before they'll price it.
Keep it off the shared drive please. I told them we'd come back with a comparison of all their contracts by Friday.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: en
fill_locale: en_GB
domain: customer support
appearance: quoted message, plain prose
scenario: a customer praises a support agent
⟬text⟭
Just a quick note to say thank you, which I realise you don't hear often.
My laptop repair had gone wrong twice and I'd pretty much given up on your company.
Then this arrived last week:

> We're sorry for the runaround. ⟬person_name:given#1⟭ will own your case from here and won't close it until you say so.
> Your replacement ships tomorrow and you can ignore the earlier invoice.

And that's exactly what happened. The laptop came on time and I even got a call to check it worked.
Please pass on my thanks, and if there's a bonus scheme, you know what to do 🙂
⟬end⟭
