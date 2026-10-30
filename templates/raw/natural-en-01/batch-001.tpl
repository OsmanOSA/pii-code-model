⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: en
fill_locale: en_GB
domain: customer support
appearance: plain prose, chat message
scenario: a support agent asks for a photo of a damaged item
⟬text⟭
so sorry the lamp turned up like that 😕 could you snap a quick pic of the crack and one of the outer box?
the courier, ⟬trap:company_name|⦃Family⦄ & Sons Haulage⟭, won't look at the claim without one
just drop them in this chat, phone pics are fine, then i'll get a replacement moving today
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: en
fill_locale: en_GB
domain: sales prospecting
appearance: message thread, signature
scenario: a rep hands an account over to a colleague
⟬text⟭
Morning! Wanted you to hear this from me before anything lands in your inbox 🙂
From next month I'm moving across to the enterprise team, so your account goes to a colleague in our ⟬city#1⟭ office.
Nothing changes on the contract, same pricing, same renewal month.

Thanks for letting me know. Are they up to speed on the warehouse rollout?
We lost a good month last time the rep changed 😅

Yep, I've walked them through the lot. Open points as I see them:
- second site licence (waiting on your finance team)
- the training day you wanted moved to spring
- credit note for the duplicate seat

They'll get in touch next week to say hello and book a call.
Anything urgent before then, just reply here, I'm around till Friday.

OK good. That credit note still going out this month?

Should do, finance promised end of next week. I'll chase it before I hand over so it's not left hanging.
Been a pleasure working with you lot, genuinely 🙏

Enterprise Sales, ⟬company#1⟭
⟬email#1⟭
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: en
fill_locale: en_GB
domain: recruiting
appearance: message thread, list item, practical details
scenario: a candidate asks what to bring to an on-site technical test
⟬text⟭
hi! thanks again for the invite to the on-site test 🙌 couple of quick qs
do i need to bring my own laptop or is there a machine set up for me?
and can i use notes or is it closed book

no laptop needed, you'll get a dev box with the repo cloned. it's a small ⟬trap:library|Flask⟭ api plus some ⟬trap:library|Pandas⟭, notes and google are fine
bring photo ID for the front desk, that's about it. here's the practical stuff in one place:
- host: ⟬trap:indicator_non_pii|platform team⟭
- address: ⟬postal_address#1⟭
- ask for: ⟬person_name#2⟭
- tel ⟬phone#2⟭ if you're running late
- 9.30 start, done by 1

brill thx, see you then
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: en
fill_locale: en_GB
domain: networking
appearance: plain prose, opening sentence, bullet list
scenario: someone moves to a new city and asks who to meet
⟬text⟭
Hi! New mob ⟬phone#1⟭ and mail ⟬email#1⟭ in case you try the old ones, both dead since I left the bank.
Long story short, we've just moved to ⟬city#1⟭ for my partner's job and I know basically nobody here 😅
Still doing product in payments, mostly remote, but I miss having people to grab a coffee with.
You seemed to know everyone when we met at the conference, so:

- who are the two or three people I should meet up here?
- any meetups worth the trip?
- anyone hiring in fintech or insurance, even just for a chat

Happy to return the favour any way I can. Coffee's on me
⟬end⟭

⟬template⟭
family: natural
format: SMS
language: en
fill_locale: en_GB
domain: community
appearance: message thread, indicator without value
scenario: a residents' group complains about a broken lift
⟬text⟭
Lift in block C out AGAIN, 3rd time since Sept 😡
Anyone got a contact for the managing agents? The number on the poster just rings out
Poster by the bins says Contact: ⟬trap:indicator_non_pii|Site Office⟭ and that's literally it, no mail, no number, nothing
Tried the website, form bounces back
Lady on 6 has a walker and cant get down the stairs, this isnt ok
Has anyone reported it properly? There's meant to be a log ref but nobody ever gets one
Engineer was here tues apparently, part on order
"On order" since when lol
Residents meeting thurs 7pm in the laundry room, lets all go and kick off
Bring photos of the out of order sign w dates
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: en
fill_locale: en_GB
domain: personal life
appearance: chat message, afterthought
scenario: a friend sends directions to a party
⟬text⟭
sat is still on!! 🎉 bring whatever ur drinking, food's covered
kicks off about 7 but nobody will show before 8 lol
get the 42 from the station, stay on til the big roundabout, then 3rd road on the left past the chippy
dont drive, parking's a nightmare & the neighbours already hate us
there's a firepit so bring a coat
if you're coming straight from work just come as you are, no one cares
oh and ⟬postal_address#1⟭ btw, forgot to say 🤦 blue door, bell's broken so just text when ur outside
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: en
fill_locale: en_GB
domain: freelance missions
appearance: plain prose, P.S.
scenario: a freelance developer chases an invoice two months late
⟬text⟭
Hi again, sorry to chase you on here but nothing I send to your accounts team gets a reply 😕
Invoice ⟬invoice_number#1⟭ for the API migration went out on ⟬date#1⟭ and it's now two months past due.
You signed the work off on ⟬date#2⟭, so I don't think there's a dispute, it's just stuck somewhere.
Could you have a quick word with whoever approves payments, or tell me who actually can?
I'd rather not start adding late fees but I've got my own bills to pay too.

Really appreciate it, and no hard feelings, it was a great project 🙂

P.S. my bookkeeper deals with all this now, so the remittance and anything else on that invoice goes to ⟬email#1⟭ and not to me
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: en
fill_locale: en_GB
domain: recruiting
appearance: chat message, quoted sentence, middle of a sentence
scenario: a job seeker asks a contact to proofread a cover letter
⟬text⟭
hey, any chance you could proofread my cover letter tonight? 🙏 the agency says the first para has to give contact details, date of birth and where to pay me, all in one go, weirdly
so it now opens "Further to your request, ⟬person_name#1⟭, ⟬postal_address#1⟭, ⟬email#1⟭, ⟬birth_date#1⟭, ⟬iban#1⟭, and I am writing to apply for the post of..." which looks mad to me
can u tell me if that reads ok or if i should just make it a list?? deadline is midnight 😬
⟬end⟭

⟬template⟭
family: natural
format: SMS
language: en
fill_locale: en_GB
domain: freelance missions
appearance: pasted line, opening sentence
scenario: a client asks for a quote for a website redesign
⟬text⟭
⟬person_name#1⟭ ⟬iban#1⟭
Sorry wrong paste 🤦 that was meant for my accountant, ignore
What I meant to ask: could u quote us for redoing the website? about 12 pages, new look, keep the booking form
Rough figure by thurs if poss, thx
⟬end⟭

⟬template⟭
family: natural
format: chat message (Slack, Teams, WhatsApp)
language: en
fill_locale: en_GB
domain: personal life
appearance: chat message
scenario: a friend sells a sofa to another friend
⟬text⟭
sofa's yours for 80 if u still want it, collection sat am. owner: ⟬trap:indicator_non_pii|whole flat⟭ technically so pay the house kitty not me 😂 the lads will help carry it down
⟬end⟭

⟬template⟭
family: natural
format: SMS
language: en
fill_locale: en_GB
domain: recruiting
appearance: message thread, last line before sign-off
scenario: a recruiter checks salary expectations in two lines
⟬text⟭
Hi, it's about the ops manager role we spoke about on Monday
Quick q before I send your CV across: what are you looking for salary wise?
Just a ballpark is fine
Hmm 52ish + 2 days remote. Is that mad?
Not mad at all, top of the band is 55 so you're ok
Great. When would I hear back?
End of next week prob, they're slow
I'm off from Weds so if anything comes up call ⟬person_name:given#1⟭ on ⟬phone#1⟭ or email ⟬email#1⟭
Cheers!
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: en
fill_locale: en_GB
domain: networking
appearance: plain prose, signature
scenario: an entrepreneur looks for a co-founder through a friend
⟬text⟭
Hi, hope the new role's treating you well! Still hunting for a technical co-founder for the logistics idea I mentioned, the pre-seed is lined up but I can't build the product on my own.
If anyone in your network comes to mind, even a maybe, an intro would mean a lot 🙏

⟬person_name#1⟭
Founder, ⟬company#1⟭ | Tel: ⟬phone#1⟭
⟬end⟭

⟬template⟭
family: natural
format: LinkedIn message
language: en
fill_locale: en_GB
domain: sales prospecting
appearance: middle of a sentence
scenario: an agency offers a free audit of a website
⟬text⟭
Had a look at your site after ⟬person_name:initial#1⟭ shared your post on packaging, we're doing free SEO audits this month if that's useful, no strings attached!
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: en
fill_locale: en_GB
domain: networking
appearance: opening sentence, inline record
scenario: an organiser collects details for a venue's visitor list
⟬text⟭
⟬person_name#1⟭, ⟬postal_address#1⟭, ⟬email#1⟭, ⟬birth_date#1⟭, ⟬iban#1⟭ - that's the lot for your visitor list, sorry for doing it in one line!
The venue form you forwarded wanted everything in one reply, including a date of birth for the security desk and an account for the deposit refund, so hopefully that covers it.
Let me know if the building needs anything else before the day, otherwise see you there 👋
⟬end⟭

⟬template⟭
family: natural
format: social media comment
language: en
fill_locale: en_GB
domain: community
appearance: opening sentence, comment
scenario: someone asks for help with an old sewing machine
⟬text⟭
Mob ⟬phone#1⟭ or email ⟬email#1f⟭, that's the lady who sorted my nan's old ⟬trap:company_name|Singer⟭ for about 30 quid!!
She does house calls round the whole county, tell her the church hall group sent you 😊
Wouldn't force the handwheel in the meantime, if it's seized you'll just snap the belt
⟬end⟭

⟬template⟭
family: natural
format: forum post
language: en
fill_locale: en_GB
domain: customer support
appearance: forum post
scenario: a buyer asks to change the delivery address after ordering
⟬text⟭
Ordered last night and only now noticed the delivery adress is my old flat 🤦 does anyone know if the support team can amend it before dispatch?
The order page just says Customer: ⟬trap:indicator_non_pii|Guest⟭ so I've got no account to log into.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: en
fill_locale: en_GB
domain: networking
appearance: opening sentence, bullet list
scenario: a peer asks how another company handled a reorganisation
⟬text⟭
Can you spare me 10 mins this week? ⟬phone#1⟭, any time after 4 is fine, otherwise reply here and I'll catch it on the train.

I remember your lot went through a big reorg a couple of years back and we're about to do something similar.
Two business units merging into one, three layers of management becoming two, the usual.
A few things I'd love your honest take on:

- how early did you tell people? We're torn between now and waiting for the final org chart
- did you run the consultation yourselves or bring in outside help
- what would you not do again 😅

Not after anything confidential, just trying to avoid the obvious mistakes.
Beers on me next time I'm in ⟬city#1⟭.
⟬end⟭

⟬template⟭
family: natural
format: informal email
language: en
fill_locale: en_GB
domain: community
appearance: plain prose, indicator without value
scenario: someone shares tips on solar panels
⟬text⟭
A few of you asked after Tuesday's meeting so here are my notes on the panels. The number that matters is annual yield, not the peak figure on the brochure (ours does about 3,900 kWh a year).
Get three quotes, check the installer is MCS certified and never pay more than a quarter up front.
The battery paid for itself slower than promised, so I'd add it later if money's tight.
Installer contact: ⟬trap:indicator_non_pii|ask me at the next meeting⟭, I'd rather not put that on the group mail 🙂
⟬end⟭

⟬template⟭
family: natural
format: social media comment
language: en
fill_locale: en_GB
domain: customer support
appearance: comment, pasted line
scenario: an insurance customer asks where a claim stands
⟬text⟭
3 weeks and still no update on my claim, is anyone on the team actually reading these?? 😤
reg ⟬uk_license_plate#1⟭ name ⟬person_name#1⟭ email ⟬email#1⟭ (oops that was meant for the DM) thanks
⟬end⟭

⟬template⟭
family: natural
format: SMS
language: en
fill_locale: en_GB
domain: sales prospecting
appearance: message thread, afterthought
scenario: a sales rep confirms an appointment at a prospect's office
⟬text⟭
Morning, confirming tomorrow 10.30 at your office as agreed. Should take about 40 mins
Great thanks. Park round the back, barrier opens from reception
Perfect. Anything you need from me before then?
No just bring the comparison you mentioned
Will do. Can you dig out your current contract so we compare like for like?
Yep its in a drawer somewhere 😂
Ha ok, see you tomorrow
Oh and ⟬person_name:given#1⟭ is coming with me to do the install check, ⟬phone#1⟭ if I'm stuck in traffic
⟬end⟭
