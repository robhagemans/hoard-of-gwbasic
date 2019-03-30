' Wormhole:
' Lucifer's first production
' Release Date: May 11th, 1995
'
'   This scrolltext string exceeded Qbasic's limitation. So we had to
' rewrite the code to accomidate it. Pretty damn good, eh? It took about five
' hours to write the text. That's longer than it took to write the code.
'   So I suppose you are going to want some technical info. O.k. Wormhole is
' a looping scrolltext demo with a palette-rotating wormhle, and a moving
' logo.
'   The story of Lucifer:
'   It all started way the hell back in October of '94 when Psycho BFG (who
' called himself gristle then) started a demo group called IBMLAND. You must
' keep in mind that IBMLAND was only a joke, that became less of one when it
' spread. Anyway, IBMLAND's members became too lazy and were kicked out by
' Psycho BFG and I.
'   Instead of releasing demos under our own names, he and I formed a new
' demo group, Lucifer. And so now the only pure 100% Qbasic group is the one
' that rose from the ashes of IBMLAND: Lucifer.
'   The only problem is that Lucifer has only two members (Psycho BFG and I
' obviously), and we have not been successful at finding motivated members.
'   So in conclusion, if you would like to contribute to Lucifer's production
' and are willing to actually DO SOMETHING, then write to me at:
'
' 4727 Holly Lake Drive,
' Lake Worth, FL, USA, 33463.
'
' Remember: if you want a reply, use the password found in the scrolltext!
'
'  If you do not feel like sending a letter all the way to Lake Worth, FL,
' want to ask questions about these demos, or get the old IBMLAND demos
' then write to Psycho BFG at:
'
' 518 Jennings Street,
' Greenacres, FL, USA, 33463
'
' IBMLAND demos available: Anarchy, Spectrum, Art, Mystic Circle, Domino
' For a limited time only, we have Art version 1.2 with new texts and colors
' by ThE DaEmOn of ex-IBMLAND
'
' Note from Psycho BFG: You KNOW we're never going to get any mail, right?
'                  666: No shit, Sherlock, but it would be cool if we did!
'           Psycho BFG: So prove us wrong!  We'll even pay for our own stamp
'                       to reply and actually we're lying about the password
'                       requirement.
'                  666: You may think Basic sucks (if so, your right), but
'                       it does have some advanteges like: the source code
'                       comes with it and uh... well... like... yeah!
'
' Lucifer is:
' 666 - Organizer, Bugs, GFX, PR
' Psycho BFG - Main Bugs, GFX, Noise
'
'
' Psycho BFG's guide to reading this scrolltext
' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
' The entire scrolltext takes almost 30 minutes to complete, so get some
' refreshments and a comfortable chair.
' All texts in fading red are just highlighted
' Usually Red text means I am talking 'out loud'
' Usually Blue text means 666 is talking 'out loud'
' If it's just our names, as in a red "Psycho BFG" or blue "666" then
' they are just meant to be highlights
' Also there are places in the demo where we switch typers without any
' visual clues; you have to figure these out yourself.
 
SCREEN 13
LOCATE 24, 5
COLOR 255
PALETTE 255, 63 * 65536 + 63 * 256 + 63
PRINT "PLEASE WAIT - INITIALIZING DEMO";
VIEW SCREEN (0, 0)-(319, 179)
READ scr$
linen = 1
linep = 1

'OUT 968, 0
'FOR i = 1 TO 765
'OUT 969, 0
'NEXT i

OUT 968, 12
OUT 969, 63
OUT 969, 0
OUT 969, 0
OUT 968, 9
OUT 969, 0
OUT 969, 0
OUT 969, 63

n = 0
x = 5
FOR i = 200 TO 40 STEP -1
n = n + 1
IF n = 6 THEN n = 1
x = x / 1.003
FOR j = 1 TO 10
CIRCLE (160, i), x, n, , , .5
x = x * 1.003
NEXT j
NEXT i

VIEW SCREEN (0, 0)-(319, 199)

DIM c(265)
FOR i = 1 TO 6
c(i) = i * (63 / 6)
NEXT i
FOR i = 7 TO 256
c(i) = 0
NEXT i

FOR i = 1 TO 49
CIRCLE (160 + i - i, 70 + i - i), i, 200 - i
CIRCLE (160 + i - i, 71 + i - i), i, 200 - i
CIRCLE (160 + i - i, 72 + i - i), i, 200 - i
NEXT i

LINE (0, 0)-(320, 10), 0, BF

LOCATE 1, 32
COLOR 1
PRINT "LUCIFER"
FOR i = 248 TO 320
FOR j = 0 TO 10
IF POINT(i, j) > 0 THEN LINE ((i - 196) * 2, j * 2 + 50)-((i - 196) * 2 + 2, j * 2 + 52), 15, BF
NEXT j
NEXT i

FOR i = 100 TO 220
FOR j = 49 TO 75
IF POINT(i, j) = 15 THEN GOTO skip2j
IF POINT(i + 1, j + 1) = 15 THEN PSET (i, j), 50
IF POINT(i, j + 1) = 15 OR POINT(i + 1, j) = 15 THEN PSET (i, j), 49
IF POINT(i - 1, j + 1) = 15 OR POINT(i + 1, j - 1) = 15 THEN PSET (i, j), 48
IF POINT(i, j - 1) = 15 OR POINT(i - 1, j) = 15 THEN PSET (i, j), 47
IF POINT(i - 1, j - 1) = 15 THEN PSET (i, j), 46
skip2j:
NEXT j
NEXT i
FOR i = 100 TO 220
FOR j = 49 TO 75
IF POINT(i, j) = 15 THEN PSET (i, j), 32 - (j - 49)
NEXT j
NEXT i

FOR i = 1 TO 5
n = i * 12
c = n * 65536 + n * 256 + n
PALETTE i + 45, c
NEXT i

LINE (0, 0)-(320, 10), 0, BF

FOR i = 1 TO 50
r = i + 13
G = i - 1
c = G * 256 + r
PALETTE i + 150, c
NEXT i

FOR i = 0 TO 15
c = i * 4
n = c * 65536 + c * 256 + c
PALETTE i + 16, n
NEXT i

LOCATE 1, 12
COLOR 255
PRINT "LUCIFER KICKS ASS!"
DIM ass(200, 8)
GET (50, 0)-(250, 8), ass
LINE (50, 0)-(250, 8), 0, BF
ax = 0
av = 0

DIM text(312 * 8)

DO
OUT 968, 1
FOR j = 1 TO 5
OUT 969, c(j)
OUT 969, 0
OUT 969, 0
NEXT j

PUT (ax, 0), ass, PSET
ax = ax + av
IF ax < 50 THEN av = av + 1 ELSE av = av - 1

b = c(5)
FOR j = 5 TO 2 STEP -1
c(j) = c(j - 1)
NEXT j
c(1) = b

z = TIMER * 100
DO
LOOP WHILE TIMER * 100 - z < 1

tm = tm + 1
IF tm < 3 THEN GOTO skip2l
GET (16, 180)-(311, 199), text
PUT (8, 180), text, PSET
LOCATE 24, 39
DO
at$ = MID$(scr$, linep, 1)
linep = linep + 1
IF linep > LEN(scr$) THEN
 linep = 1
 linen = linen + 1
 IF linen > 16 THEN : linen = 1: RESTORE
 READ scr$
END IF
IF sl > ln THEN sl = 1
IF at$ = "*" THEN clr = 1
IF at$ = "@" THEN clr = 2
IF at$ = "#" THEN clr = 3
IF at$ = "$" THEN clr = 4
IF at$ = "%" THEN clr = 12
IF at$ = "^" THEN clr = 9
IF at$ = "&" THEN clr = 255
LOOP WHILE INSTR("*@#$%^&", at$) > 0
COLOR clr
PRINT at$;
tm = 1
skip2l:
LOOP WHILE INKEY$ = ""
CLS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 'If you are reading this, we told you about it!!!

DATA "  *H@e#l$l*o@,# $p*e@o#p$l*e$!  &It's me, %Psycho BFG &of *L@u#c$i*f@e#r &typing.  I'm here at ^666&'s house, and he's about to go get us some food.  Scrolltext writing can be a strenuous task, even for the experienced, so we r going with the preventive medecine trend and stocking up before we really get into it... wait a sec... I just realized that this scroll is pure white... I ripped some code from a demo of mine from quite some time ago, and it seems to be missing the vital code for 'scrolltext commands'... here, I'll fix it now.  Ah... as I'm sure you've noticed, these texts have neat colors now... let me show you those again: we can have *R@E#D* F@A#D$I*N@G&...  and of course the standard %Psycho BFG red &and ^666 blue.  &So... here, before I forget, let's hand out some credits and greetings.  This demo was coded by %Psycho BFG, &and of course the scrolltext was written by ^b%o^t%h ^o%f ^u%s&.  ok, since ^666& is begging to write the greetings, I'll let him take over for a little while.. i guess... "
DATA " *D@a#m$n *i@t#!$!*! &What a fucking liar! I wasn't begging. Anyways, greetings go to: Coolgrease, Sinner, and Satanic Majesty of ex-IBMLAND... Cascada... Pilveveikot (I have no goddamn idea how to spell it)... Future Crew (nice name (@N#O$T&))... Electro Motive Force... Type One of TFL... Tran (Hell was especially coool)... Bill Gates... <-- whoa look back there! Sorry about that bug!... Stefan Gagne... Pis and Egor of Future Wrec... Dr. Sbaitso... Icecoldhacknslashdeathbladerunner... Topaz Beerline... All of those mental floss people... Mike Judge... I gess that about does it for the greets... Now for the fuckings... They go to: That guy that said IBMLAND sucked because he saw a Future Crew demo that was better... Nad Rotezc (for hosting MTV Sprots)... Jay Leno... Sonic PC (for screwing up the *A@s#s$e*m@b#l$y* @'#9$4&)... Steve Wazniak (for the sucky Macintosh)... Bill Gates (whew we finally got it right this time)... All cobol lamers... Gerber King (for those sucky anti McReynalds commercials)... "
DATA "Well, ^666 &went to go molest his cat, so I'm resuming the typing... hey, he just kicked me!  Damn it!  Alright, let's have an interview.  %Psycho BFG: &Hey ^666,& tell us about yourself...  ^666: &Well, ... uh, well, there's really not much to say about me... so lets skip the crap questions.  %Psycho BFG: &Ok, ok ok... did you have any trouble coding this demo?  ^666: &No.  I didn't code it.  Dumbass.  %BFG: &Oh that's right... I did... well um... do you do any coding yourself?  ^666: &Yes, I do. I'm working on our next demo, Loser. It will be featuring some better effects... like crossfading, dotmorphing, a mosaic. Other than that I have no idea what will be in it... %Psycho BFG: &Ok...- ^666: &Will you stop typing 'ok'?!   %Psycho BFG: &I'm asking the questions here... ok... hahaha okokokokokok  hahaha!  Alright... now... ^666&... you said some 'better effects'.  Did you mean better effects than the ones in this demo, or just good effects in general?  ^666&: better than this demo, dumbass!  %BFG: &Alright, "
DATA "I'm going to kick your ass now!  %Wham! ^ow!  %Pow!  ^Quit it!  Slam!  %ow you assmunch!  ^666&: O.k. Now the keboard is all mine and you can't do anything about it (at least not when you're lying on the floor, unconsious (%if I'm unconsious, how am I helping you with spelling?&)(That was just me typing to fool you))... Uh oh %Psycho BFG &just woke up... Now he's whining about how when he stomps on the floor, his nose hurts... Whew he shut the hell up... Oh yeah, I guess that concludes this interview. See us in our next scrolltext demo for another one... Now I will pass the keyboard over to %Psycho BFG&, who has been bugging for it, for quite some time now. *W@h#e$w*!&  I thought he was never going to shut up!  So now I'm going to talk about Loser a bit... if you ever get that demo (you got this one, didn't you?), then just remember, all the SUCKY parts were coded by ^666.&  And  ^wham! %Ow, quit it!  ^Give me that fart knocker. &Now for some @R#E$A*L& info on Loser. %Psycho BFG& was lying again... ^cut it out, "
DATA "asswipe& he just hit me... excuse me for one moment; I h%gfsds&a%gfsaghh&v%gfdg&e to%gfsdgs ^quit it! &I have to settle something... %Ah... that was easy... &Now let's get back to the scrolltext.  This text is now about 4200 bypes (^bypes? %bytes, assmunch!&) long... that about one quarter of what we want it to be total... so be prepared for the rest of it... or if you're a *T@O#T$A*L @W#U$S*S &then you can just skip out and read it directly from the .bas file.  But then you wouldn't see all the *C@O#O$L $E#F@F*E$C#T@S*!&, <- like that one.  You'll just see garbage like VS%$TW#BH T^WVYE^# %G& (well actually we can't show you what you'd see exactly because it would cause effects in the scroll!!! @d#a$m*n #i$t*!@!#!&)  Well it doesn't matter anyway because you're still reading this, arent you?  Unless you're being a wuss.  Ok, now if you want to contact us, send mail to   4727 Holly Lake Drive    Lake Worth, FL   33463   - that's 666... i mean ^666&'s house... and remember, if you want a reply, the password is: "
DATA "$#@%%#&D$%@$%&O$#@$&R%#%$#@*&K!!!  Got it?  If you did not, well *F@U#C$K @Y#O$U*!@!#!  &Alright... now ^666 &wants the keyboard oh he just changed his mind but TOO BAD!  Here is ^666!& Asswipe!!!... %Ow! Cut it out!!! ^Well if you're going to bitch about it then O.k.& So like do you want to see some anagrams... if not, tough shit!!! Here it goes... The four seasons-=> Fart on Sues shoe... Santa Clause-=> Satan's a clue... The mind is a terrible thing to waste-=> Broil tainted semen with great shit (no racism/offense intended)... And the big one...: You rob dead Zack Braggwelsche of his fatty pit-=> Go get fistfucked by a psycho %(BFG)& with a razor blade (offense intended)... Anagrams *k$i#c@k *a$s#s@!*!$!& O.k. Now I think I'll let %Psycho BFG& type... i am typing this with my nose... no really!  i am typing this sentence with another part of my body but I wont tell you which... hahaha!  So let's talk about cool people vs. dorky people.  As you can tell, I am a cool person.  ^666, &on the other hand, is a total dork.  Uh oh... he's  "
DATA "starting to lurk behind me...  ^you don't know when it's coming, dude...  %Ow!!! &ok, just to get you back, I'm gonna give you the keyboard again!!!  Muahahahahahahahahaaa!  ^No way it's your's %Ok, I'll type as long as you promise not to hit me... ^I'm not going to make a promise I can't keep... %Well fuck that... here you go, ^667. ^O.k., Sane LFG... %ššš... ^Chopsy G(oat) B(utt) F(ucker)... %6(IQ points) 6(years old) 6(times he masturbates each day)... ^iD-ripper-offer... %90210... ^You forgot to make it %red^, dumbass!... %look again, dork!  ^That's just because you change it, BiFG... %Enough of this.  Let's quit insulting each other, ^999. %It's time we got back to the real scrolltext.  &Do you really think that the public wants to hear about our arguments? ^I don't give a flying fuck about the public &(<-=-= sorry about that I really do)...  &To tell the truth... I think they really DO want to hear about it...  %POW!!!  ^Yeeow!  %WHACK!  ^Ow!  %SLAM!  ^Smack!!! Eat that Psucko BFG... %Say what you want, ^90210%, but @G#O$D% is on my side. ^What a wuss!!! "
DATA "*G$O#D^ isn't going to save your ass every time... You need to learn how to take care of yourself!!! &A message to @G#O$D&: Don't zap him yet... give him time to repent... ^90210&, this may be your last chance...  Oh BTW!  This text is now about 7.5k long!  Half of our goal!!  @L#U$C*I@F#E$R& @F#O$R*E@V#E$R*!@!#!  ^Do you really think *G$O#D^ is going to save your ass if you keep doing things like that? %like what?  Being nice to you?  I thought we were supposed to be friends or something... ^We R, it's just that you keep bragging about how *G$O#D^ is going to save your ass but not mine... %Well if I didn't warn you I would be a real jerk, wouldn't I?  I'm far to noble to lie about such things anyways.  ^Noble?! Ha! You've got to be kidding... The only thing that makes you noble is your amazing ability to be a dumbass!! Ow that hurt!!, %Psicko Butt-Fucker^!! %Quit standing behind me, ^90210%!  Look... I just am sick of fighting!  We've been fighting for the last... lets see... almost the last 2k!  I just want to get on "
DATA "with the demo... even if you suck, we're still in the same group, ^90210%, and we should cooperate.  ^What the hell does 'even if you suck' supposed to mean? %Um... nothing... ^902%... ^666% i mean... it um... it's nothing, really!  ^Yeah-fucking-right, %Psycho Boy-Fucking-Gomer^... %Is that really me?  ^Didn't I type it, ashino baka!!! %Do you wish that you type it, ashino baka?  ^I *d$i#d^ type it, Psucko... %I see ^So do I... %I need more data... ^Tough shit, Dr. Sbanking! %Move your hands of my keyboard. ^And if I don't... %Don't you think that you can... ^I know I can, Sbanking... %Are you glad that you can, Sbanking...?  ^Fuck you!!! %90210, you are getting me to GTRSEY24... parity warning... ^Fuck fuck fuck fuck!!! %YOU YOU YOU YOU!  @I#'$m @b#a$c*k@!#!$!%!  Heyyyyy... %Psycho BFG& is back from @H#E$L*L&, where I've spent my winter vacation... Hell really is nice in the winter and you should visit sometime. -^you have been playing too much Doom&- Anyways... hey, ^666&, you spelled DooM wrong!  ^bite me& Shut up!  Anyways, "
DATA "this text is almost 10k long! Remember our goal is to get past 15k, so there's still a bit to type... ^666, & do you have anything to say?  Not right now... I think we should go do something else and then come back and finish this text...  Alright... lets go...  3:00pm signing off for now...       %Psycho BFG& is back!  Its been 80 minutes since we saved the last time... what?  You munch!  Just because no time has passed for you, doesn't mean it hasn't for us!!!  Here look...           See I just @l#e$f*t &a leak... it took about a minute... you see... the only way we can show you time is holding down the space bar             and that gets boring for both you and us.  Did that clear anything up?  Now... I believe ^666& has something to say...     Yes it's me, ^666&... I'm back (%no shit&)... O.k. I got a cool joke. There is this little kid playing with his train set, saying: 'all of you mother fuckers that want to get off, get off. And all of you suns of bitches that want to stay on, stay on!.' So like, then his mother told him to go in his room for two hours. Two hours "
DATA "later... he comes out of his room AND says: 'all passengers who would like to get off, get off. All passengers who would like to stay on, stay on. If you r angry about the two hour delay, see the @b#i$t*c@h& in the kitchen'... Cool, eh? O.k. now it's %Psycho BFG's& turn to tell a joke...  Well, I was going to tell the one about the jew who won the lottery using his concentration camp tatoo as his numbers, but some people might find that offensive... so I'll go with.. the Tennis Elbow... alright... see there's a guy who has an injury, so he goes to a doctor's office.  The doctor tells him to piss in a cup, pour it into the machine in the hallway, and insert 75 cents.  His result was a card saying: 'You have tennis elbow.  Compress with a hot towel for fifteen minutes a day for two weeks.'  Well, he did, but he couldn't stop thinking about that machine... finally curiosity overcame him: he got his wife and daughter to both piss in the cup, he dripped some radiator fluid from the car into the cup, and to top it all off, he ejaculated into it.  "
DATA "The next day he went up to the machine and poured it in, and entered 75 cents.  The machine clanked around for about five minutes and finally spat out a card that read: 'Dear sir: Your wife has the clap, your daughter is pregnant, your car is about to blow an axle, and if you don't stop jerking off, you'll @N#E$V*E@R &get rid of that tennis elbow!'  Let's see ^666& top that one...  No problem... This story/joke is entitled 'Italian Goes to Breakfast in L.A.' (No offense to any Italian people). So 'dis one day I went out to brekfest and I ordered two peese of toast two eggs and two pancakes. De waiter only brought me one peese of toast. So I say to heem 'I want two peese.' And so he said to me 'the bathroom is that way.' So I say to heem 'no you don't undarstand. I want two peese on tha plate.' And he say to me 'you bettar not piss on the plate you sumanabitch.' The end... Beat that %Psycho BFG&...  Damn, I don't know if I can... well I'll try my version of a foreigner in L.A.  It's a short one, so you don't have to read all that setup crap.  'Dear sir... could you tell me "
DATA "the way to Grand Central Station... or shall I just go fuck myself?'   Um... I gues ^666& wins... but it's not my fault.  I was going to use his next anyhow.  Yes I won... That's because I 'm... (%WAIT, I JUST THOUGHT OF ONE!!!)  &Ok here's %Psycho BFG's& joke du jour... What do milk and elephants have in common?  . . . . . . . . . . . . They both come in quarts!!!  Of course some of you might not get that one... 'wait a few more years, kid'  Now back to the regularly scheduled broadcast.  Anyway... as I was saying, I won because I am cooler (%That just means he didn't get my joke... I wonder why...&) *F$U#C@K *Y$O#U@!!!^ I got your damn joke (%yeah, I just explained it to him&), but I still won!!! Besides elephants come in gallons (%how would you know? ^I asked your dad! %that was stupid... hehehe)& Hey, I just thought of something... 1961 upsidedown is 1961!!!  %Psycho BFG& is back.  I figured I better take over or you'll die of boredom (actually, he just had to @l#e$a*v@e &a dump.  Anywayz I'd like to talk about stuff now.  "
DATA "For example, this text is now 13.5k long!  This is not something I'm proud of, but it's split about half and half I'd say between me and ^667& typing (he's not here right now so I can say @W#H$A*T@E#V$E*R @I #W$A@N*T&).  This equality is something I am going to fix right here and now... I will type... say, until the end of the line.  Alright... now I'd like to send a few greets myself (I helped with the above greets, but some people were left out).  Since you've read for so long, I will reward you with all the @C#O$O*L &greetings.  Greetings from me to ULTRA2KRAD4U (2KRAD4U was a KICKASS demo... try again in basic though)... INFERIORS (do some @R#E$A*L &basic!)... Daemon (both of them...ThE DaEmOn, and Daemon)... Sorcerers (keep up them cool demos)... Zodiak (try a few PC speaker tunes... if you want, I'll send you my PC-Tracker)... The Flamooties (or whatever you're called... Kukoo2 had a good start, but the second part wasn't as good)... 508537 (great name, guys!)... Ford Prefect (all of 'em)... Sand (eggs and oisters?)... Ok... that's one line... want to try for 2 in a row?  "
DATA "Here's the second!  Now for the list of least used hyphenated words, in descending order:  OWL-FLAVORED...LICK-PROOF...PRE-SPANKED...HAT-RESISTANT...CONDOM-FLAVORED...MOOKIE-PROOFED...PLUTONIUM-FREE...FLY-JAMMED...POST-OPENED...FART-FLAVORED...and finally...@S#U$G*A@R#-$F*R@E#E$!&  Now... hey did you know that in some versions of battle chess you can see the queens nipples poking at her shirt as she goes to make a kill?  Hey I just typed the longest sentence ever known to man but when I tried to copy it to get a byte count it just was truncated at the 256 byte mark and I KNOW that there was more than that, probably because it was cut off in the middle of the word 'dumbass'.  Lets get a byte count of that.  On second thought lets not.  If it's less than 256 bytes I will be unsatisfied and if it's more then I'll have to retype it all.  Instead, let's just count the number of bytes in the entire scrolltext.  <-= @A#T @T#H$A*T @M#A$R*K @T#H*E @S#C$R*O@L#L$T*E@X#T $I*S @E#X$A*C@T#L$Y @1#5$9*1@3 @b#y$t*e@s @l#o$n*g@!#!$!*!  @W#E @H#A$V*E @S#U$C*C@E#E$D*E@D#!$!*!  &But do you think we are going to stop here?  "
DATA "Well, whatever your answer is, YOU'RE RIGHT!!!         "

