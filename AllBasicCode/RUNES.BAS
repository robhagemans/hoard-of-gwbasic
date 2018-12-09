1 CLS : RANDOMIZE TIMER
2 COLOR 15: PRINT " ÜÜÜÜÜÜ   ÜÜ   ÜÜ    ÜÜÜÜ", , "A Game by ... Jerry Chan"
3 COLOR 7: PRINT "   ÛÛ     ÛÛÜÜÜÛÛ    ÛÛÜ", , "FREEWARE !"
4 COLOR 8: PRINT "   ÛÛ     ÛÛ   ÛÛ    ÛÛÜÜ", , "Version 1.0"
5 COLOR 15: PRINT "   P O W E R    R U N E S"
6 PRINT : PRINT : PRINT : PRINT : PRINT : PRINT TAB(28); "Press Any Key To Continue"
7 A$ = INKEY$: IF A$ = "" THEN GOTO 7
8 CLS
9 PRINT "     Long ago, there were runes.  Runes more powerful than you can imagine."
10 PRINT "These runes were controlled by the good and honest King Aquarius.  He used"
11 PRINT "the runes to help him run his land.  He had done so until an evil force "
12 PRINT "arose...Actung Ka.  Actung Ka, used the King's good nature to steal the runes"
13 PRINT "for his own uses, for evil.  The King was furious.  He went into battle with"
14 PRINT "Actung Ka himself...unfortunately, the King was never seen again.  Actung Ka"
15 PRINT "used the runes to take the land and money of all the people.  Action was "
16 PRINT "required...and only the legendary warrior know as Xavier, could challenge"
17 PRINT "the now powerful Actung Ka.  The battle was fierce, the out come was worse..."
18 PRINT "Xavier managed to defeat Actung Ka, but at the loss of his own life.  The runes"
19 PRINT "disapeared and was never seen again..."
20 PRINT
21 PRINT "     Now, a 100 years after the great battle, a new evil arises.  Actung Ka"
22 PRINT "somehow returns...Everyone has forgotten about the runes, but Actung Ka does "
23 PRINT "not, he goes on a secret journey to retrieve the mighty runes, and now "
24 PRINT "threatens to use the power of the runes for evil again..."
25 PRINT
26 PRINT "     As the grandson of Xavier, you must train and prepare yourself for the "
27 PRINT "great battle that lies ahead...you must regain control over the runes, and kill"
28 PRINT "Actung Ka, for good..."
29 PRINT : PRINT
30 COLOR 7: PRINT TAB(28); "Press Any Key To Continue"
31 A$ = INKEY$: IF A$ = "" THEN GOTO 31
32 CLS : COLOR 4: PRINT "NOTE: Keep CAPS LOCK ON during game play"
33 COLOR 7: PRINT "(P)lay Game"
34 COLOR 15: PRINT "(S)tory Again"
35 COLOR 8: PRINT "(Q)uit Game"
36 PRINT : PRINT
37 COLOR 15: INPUT "What is it going to be "; A$
38 IF A$ = "P" THEN GOTO 45
39 IF A$ = "S" THEN GOTO 8
40 IF A$ = "Q" THEN COLOR 4: PRINT "Come back when you're ready then ...": GOTO ENDGAME
42 GOTO 37
45 COLOR 15: CLS : PRINT "You wake up with the morning sun shining in your face.  This is the day I'm"
46 PRINT "gonna do it ! you say to yourself as you strap your equipment on.  You walk out"
47 PRINT "into the crowdy streets of the town."
48 PRINT : PRINT : h = 35: MH = 35: X = 0: L = 1: M = 10: MM = 10: LU = 15: HE = 20: MONEY = 100
49 COLOR 15: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
50 COLOR 7: PRINT "³You are in the streets of the Aquari town ...³"
51 COLOR 15: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
52 PRINT "(T)raining grounds": PRINT "(S)ave game"
53 COLOR 7: PRINT "(V)isit your Mentor": PRINT "(L)oad game"
54 COLOR 8: PRINT "(Q)uit game"
55 COLOR 4: PRINT "(G)o on journey to find Actung Ka"
56 PRINT
57 COLOR 15: INPUT "What is your command "; A$
58 IF A$ = "T" THEN GOTO 190
59 IF A$ = "V" THEN GOTO 70
60 IF A$ = "Q" THEN COLOR 4: PRINT "So long valiant fighter, return to fight another day ...": GOTO ENDGAME
61 IF A$ = "G" THEN GOTO 700
62 IF A$ = "S" THEN GOTO Save
63 IF A$ = "L" THEN GOTO load
64 GOTO 45

70 PRINT
71 COLOR 7: PRINT "    You walk into the old dusty shack where your great trainer and mentor lives."
72 PRINT "He looks up as you walk in..."
73 COLOR 15: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
74 COLOR 7: PRINT "³You are in Kaligan's shack ...³"
75 COLOR 15: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
76 PRINT "(L)evel Raise"
77 COLOR 7: PRINT "(A)sk for advice"
78 COLOR 8: PRINT "(Q)uit to main streets"
79 PRINT
80 COLOR 15: INPUT "What is your command "; A$
81 IF A$ = "L" THEN GOTO 101
82 IF A$ = "A" THEN GOTO 85
83 IF A$ = "Q" THEN GOTO 49
84 GOTO 71
85 PRINT
86 Z = INT(RND(10) * 10) + 1
87 IF Z = 1 THEN COLOR 10: PRINT "My son...use magic only when neccessary, don't waste it's power ..."
88 IF Z = 2 THEN COLOR 10: PRINT "My son...Actung Ka has a weakness against Lit Attacks ..."
89 IF Z = 3 THEN COLOR 10: PRINT "My son...leave at once, I must meditate ..."
90 IF Z = 4 THEN COLOR 10: PRINT "My son...use fire attacks against spirits ..."
91 IF Z = 5 THEN COLOR 10: PRINT "My son...visit me regularly to see if you deserve a level up ..."
92 IF Z = 6 THEN COLOR 10: PRINT "My son...your sword possess great power, unveil it with your spirit ..."
93 IF Z = 7 THEN COLOR 10: PRINT "My son...carry many potions when you go for Actung Ka ..."
94 IF Z = 8 THEN COLOR 10: PRINT "My son...I have no new advice today, go and train ..."
95 IF Z = 9 THEN COLOR 10: PRINT "My son...the wizard at the magic shop can sell you magic ..."
96 IF Z = 10 THEN COLOR 10: PRINT "My son...be careful, Actung Ka has a powerful spell called DETH ..."
97 PRINT
98 COLOR 7: PRINT TAB(28); "Press Any Key To Continue"
99 A$ = INKEY$: IF A$ = "" THEN GOTO 99
100 GOTO 73
101 PRINT
102 COLOR 15: PRINT "     You look your mentor in the eye, and ask for a level raise."
103 IF X > 200 THEN COLOR 10: PRINT "You deserve a level up...HP up...LUCK UP...MAGIC UP!": GOTO 110
104 IF X < 200 THEN XN = 200 - X: COLOR 4: PRINT "You need "; XN; " Experience points to gain a level ...": GOTO 112
110 PRINT
111 L = L + 1: MH = MH + 15: LU = LU + 5: MM = MM + 10: X = 0: MAG = MM - M: M = M + MAG
112 COLOR 7: PRINT "Now your status looks like this :"
113 COLOR 8: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
114 COLOR 4: PRINT "Hit Points .......... "; h; "/"; MH, "Healings ... "; HE
115 PRINT "Money ................ "; MONEY
116 PRINT "Luck ................. "; LU, , "Magic 1 ... "; MONE$
117 PRINT "Magic ................ "; M; "/"; MM, "Magic 2 ... "; MTWO$
118 PRINT "Level ................ "; L, , "Magic 3 ... "; MTHREE$
119 COLOR 7: PRINT TAB(28); "Press any key to continue"
120 A$ = INKEY$: IF A$ = "" THEN GOTO 120
121 GOTO 73
190 PRINT
191 COLOR 15: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
192 COLOR 7: PRINT "³Training Grouds³"
193 COLOR 15: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
194 COLOR 15: PRINT "(T)rain with warriors"
195 COLOR 7: PRINT "(M)agic shop"
196 COLOR 8: PRINT "(Q)uit to streets"
197 COLOR 15: INPUT "What is your command "; A$
198 IF A$ = "T" THEN GOTO 205
199 IF A$ = "M" THEN GOTO 270
200 IF A$ = "Q" THEN GOTO 49
201 GOTO 190
205 E = INT(10 * RND + 1)
206 IF E = 1 THEN EN$ = "Zengra": EH = 20: EM = 20: GOTO 230
207 IF E = 2 THEN EN$ = "Dragoon": EH = 60: EM = 60: GOTO 230
208 IF E = 3 THEN EN$ = "Legolith": EH = 55: EM = 55: GOTO 230
209 IF E = 4 THEN EN$ = "Xanthos": EH = 100: EM = 100: GOTO 230
210 IF E = 5 THEN EN$ = "Thantanos": EH = 213: EM = 213: GOTO 230
211 IF E = 6 THEN EN$ = "Carnage": EH = 550: EM = 550: GOTO 230
212 IF E = 7 THEN EN$ = "Profound Carnage": EH = 1000: EM = 1000: GOTO 230
213 IF E = 8 THEN EN$ = "Ko Kain": EH = 390: EM = 390: GOTO 230
214 IF E = 9 THEN EN$ = "Kobain": EH = 690: EM = 690: GOTO 230
215 IF E = 10 THEN EN$ = "Sung Ka": EH = 35: EM = 35: GOTO 230
230 PRINT : COLOR 7: PRINT "You just challenged "; EN$; " to a battle !"
231 PRINT : COLOR 2: PRINT "Your Stats --": IF h < 1 THEN COLOR 4: PRINT "Get outta my face ! You're not ready for me !!": h = h + 15: GOTO 190
232 COLOR 10: PRINT "Hit Points  "; h; "/"; MH
233 COLOR 4: PRINT EN$; "'s Stats --": IF EH < 0 THEN GOTO 250
234 COLOR 12: PRINT "Hit Points  "; EH; "/"; EM
235 COLOR 7: PRINT "(A)ttack     (H)eal         (B)ack out (RUN) !!!!"
236 COLOR 15: INPUT "What is your command "; B$
237 IF B$ = "A" THEN GOTO 240
238 IF B$ = "B" THEN COLOR 4: PRINT "Chicken !!!": GOTO 190
239 IF B$ = "H" THEN GOTO 245
240 YA = INT(5 * RND + 15)
241 EA = INT(6 * RND + 20)
242 COLOR 7: PRINT "You attack "; EN$; " for "; YA; " HP !!!": EH = EH - YA
243 COLOR 4: PRINT EN$; " attacks for "; EA; " HP !!!!": h = h - EA
244 GOTO 231
245 IF HE = 0 THEN PRINT "You have no more healings !!!": GOTO 236
246 COLOR 10: PRINT "You get ALL your HP replenished !": HE = HE - 1: AH = MH - h: h = h + AH: GOTO 231
250 PRINT
251 COLOR 10: PRINT "Good job !! You defeated "; EN$; " !!"
252 EE = INT(30 * RND + 20)
253 ME = INT(40 * RND + 60)
254 COLOR 15: PRINT "You get "; EE; " experience for your efforts !!": X = X + EE
255 COLOR 7: PRINT "You get "; ME; " gold pieces as a reward !!!": MONEY = MONEY + ME
256 GOTO 190
270 PRINT
271 COLOR 15: PRINT "ÚÄÄÄÄÄÄÄÄÄÄ¿"
272 COLOR 7: PRINT "³Magic Shop³"
273 COLOR 15: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÙ"
274 COLOR 7: PRINT "You walk into the dark shop...you see the wizard in the back room ..."
275 PRINT : PRINT "(B)uy magic scrolls"
276 COLOR 15: PRINT "(T)alk to wizard"
277 COLOR 7: PRINT "(H)ealing potions"
278 COLOR 8: PRINT "(Q)uit to streets"
279 COLOR 4: INPUT "What is your command "; C$
280 IF C$ = "B" THEN GOTO 290
281 IF C$ = "T" THEN GOTO 500
282 IF C$ = "H" THEN GOTO 600
283 IF C$ = "Q" THEN GOTO 49
284 GOTO 271
290 COLOR 15: PRINT "Yes ? Which magic scroll do you wish to purcahse ?"
292 COLOR 7: PRINT "1 -- Wind .............   700 Gold"
294 COLOR 7: PRINT "2 -- Water ............ 1,000 Gold"
295 COLOR 7: PRINT "3 -- Lit .............. 9,000 Gold"
296 PRINT
297 COLOR 15: INPUT "Would you like to buy a scroll (Y/N) "; D$
298 IF D$ = "Y" THEN GOTO 302
299 IF D$ = "N" THEN PRINT "Ok, whatever you say ...": GOTO 270
300 GOTO 297
302 COLOR 7: INPUT "Which one (#) "; E$
303 IF E$ = "1" THEN GOTO 310
304 IF E$ = "2" THEN GOTO 320
305 IF E$ = "3" THEN GOTO 330
306 GOTO 302
310 IF MONEY < 700 THEN PRINT "You can't afford this !!!": GOTO 270
311 MONEY = MONEY - 700: MONE$ = "Wind": PRINT "Thank you !": GOTO 270
320 IF MONEY < 1000 THEN PRINT "You can't afford this !!!": GOTO 270
321 MONEY = MONEY - 1000: MTWO$ = "Water": PRINT "Thank you !": GOTO 270
330 IF MONEY < 9000 THEN PRINT "You can't afford this !!!": GOTO 270
331 MONEY = MONEY - 9000: MTHREE$ = "Lit": PRINT "Thank you !": GOTO 270
500 W = INT(1 * RND + 9)
501 IF W = 1 THEN COLOR 10: PRINT : PRINT "Lit is the most powerful magic...that's why it cost so much !": GOTO 511
502 IF W = 2 THEN COLOR 10: PRINT : PRINT "Magic is difficult to handle if you don't have enough experience...": GOTO 511
503 IF W = 3 THEN COLOR 10: PRINT : PRINT "You cannot use magic while training...you would easily kill a warrior!": GOTO 511
504 IF W = 4 THEN COLOR 10: PRINT : PRINT "I have no new magic for this whole month !": GOTO 511
505 IF W = 5 THEN COLOR 10: PRINT : PRINT "Us wizards are a special breed, we don't need scrolls to learn magic !": GOTO 511
506 IF W = 6 THEN COLOR 10: PRINT : PRINT "I suggest you take a LOT of healings on your future journey ...": GOTO 511
507 IF W = 7 THEN COLOR 10: PRINT : PRINT "Healing potions also replenish your Magic points !": GOTO 511
508 IF W = 8 THEN COLOR 10: PRINT : PRINT "Do not waste your magic on weak enemies ...": GOTO 511
509 IF W = 9 THEN COLOR 10: PRINT : PRINT "Have you heard of the great warrior/wizard called J.C. ?": GOTO 511
510 IF W = 10 THEN COLOR 10: PRINT : PRINT "I'm thirsty...": GOTO 511
511 PRINT
512 PRINT TAB(28); "Press any key to continue"
513 A$ = INKEY$: IF A$ = "" THEN GOTO 513
514 GOTO 270
600 PRINT
601 COLOR 15: PRINT "Ahhh, you want some healing potions eh ?"
602 HP = 10: HA = MONEY \ HP: PRINT "You can afford "; HA; " healings"
603 COLOR 15: PRINT "How many potions do you want "
604 COLOR 7: PRINT "(U)se all you money"
605 COLOR 7: PRINT "(B)uy 1 healing"
606 COLOR 7: PRINT "(P)urcahse 10 healings": COLOR 8: PRINT "(Q)uit"
607 PRINT : COLOR 4: INPUT "What is your choice "; F$
608 IF F$ = "U" THEN GOTO 615
609 IF F$ = "B" THEN GOTO 630
610 IF F$ = "P" THEN GOTO 640
611 IF F$ = "Q" THEN GOTO 270
612 GOTO 600
615 HE = HE + HA: AB = HA * HP: MONEY = MONEY - AB
616 COLOR 10: PRINT "Now you have "; HE; " healing potions !": GOTO 270
630 IF MONEY < 10 THEN PRINT "You can't afford this !!": GOTO 270
631 HE = HE + 1: MONEY = MONEY - 10
632 COLOR 10: PRINT "Now you have "; HE; " healing potions !": GOTO 270
640 IF MONEY < 100 THEN PRINT "You can't afford this !!": GOTO 270
641 HE = HE + 10: MONEY = MONEY - 100
642 COLOR 10: PRINT "Now you have "; HE; " healing potions !": GOTO 270
700 PRINT
701 COLOR 15: PRINT "     You walk out of the town walls and see a tower in the horizon..."
702 PRINT "That's your target...that's Actung Ka's fortress of doom...his domain..."
703 PRINT "There's no turning back now, unless you're chicken !"
704 COLOR 15: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
705 COLOR 7: PRINT "³Journey to Actung Ka³"
706 COLOR 15: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
707 PRINT : PRINT "(R)eturn to town"
708 COLOR 15: PRINT "(E)nter tower"
709 COLOR 7: PRINT "(Y)our Stats"
710 COLOR 7: PRINT "(H)eal yourself"
711 COLOR 8: PRINT "(V)isit the Inn"
712 PRINT : COLOR 4: INPUT "What is your command "; Z$
713 IF Z$ = "R" THEN COLOR 4: PRINT "Chicken !!": GOTO 49
714 IF Z$ = "E" THEN GOTO FB
715 IF Z$ = "Y" THEN GOTO 730
716 IF Z$ = "H" THEN GOTO 750
717 IF Z$ = "V" THEN GOTO 770
718 GOTO 704
730 PRINT
731 COLOR 15: PRINT "Your Stats look like this ..."
732 COLOR 7: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
733 COLOR 4: PRINT "Health .........."; h; "/"; MH, , "Healings ...."; HE
734 COLOR 4: PRINT "Money ..........."; MONEY
735 COLOR 4: PRINT "Luck ............"; LU, , "Magic 1 ....."; MONE$
736 COLOR 4: PRINT "Magic ..........."; M; "/"; MM, , "Magic 2....."; MTWO$
737 COLOR 4: PRINT "Level ..........."; L, , "Magic 3 ....."; MTHREE$
738 PRINT
739 COLOR 15: PRINT TAB(28); "Press Any Key to Continue"
740 A$ = INKEY$: IF A$ = "" THEN GOTO 740
741 GOTO 704
750 PRINT
751 IF HE < 0 THEN PRINT "You have no more healing potions !!": GOTO 704
752 COLOR 10: PRINT "You used 1 healing potion...ALL HP and Magic recovered !"
753 HE = HE - 1: AH = MH - h: h = h + AH: AM = MM - M: M = M + AM
754 GOTO 704
770 PRINT
771 COLOR 15: PRINT "ÚÄÄÄÄÄÄÄ¿"
772 COLOR 7: PRINT "³The Inn³"
773 COLOR 15: PRINT "ÀÄÄÄÄÄÄÄÙ"
774 PRINT
775 COLOR 15: PRINT "(R)est for awhile"
776 COLOR 7: PRINT "(L)isten to De Grazus"
777 COLOR 8: PRINT "(E)xit the Inn"
778 COLOR 4: INPUT "What is your command "; Y$
779 IF Y$ = "R" THEN GOTO 790
780 IF Y$ = "L" THEN GOTO 860
781 IF Y$ = "E" THEN COLOR 10: PRINT "Bye ... Come again !": GOTO 704
782 GOTO 770
790 PRINT : COLOR 10: PRINT "It costs 20 gold for a room ..."
791 INPUT "Will you pay (Y/N) "; A$
792 IF A$ = "Y" THEN GOTO 795
793 IF A$ = "N" THEN GOTO 770
794 GOTO 791
795 IF MONEY < 0 THEN PRINT "You don't have enought money !!!": GOTO 770
796 COLOR 10: PRINT "You take a rest and recover your magic and hit points !"
797 HR = MH - h: h = h + HR: MR = MM = M: M = M + MR: MONEY = MONEY - 20
798 COLOR 15: PRINT "Thanks for coming...say do you want some Power Elixer ?"
799 INPUT "It costs 1,000 gold, want some (Y/N) "; B$
800 IF B$ = "Y" THEN GOTO 810
801 IF B$ = "N" THEN PRINT "Ok suit yerself ...": GOTO 770
802 GOTO 798
810 IF MONEY < 1000 THEN COLOR 4: PRINT "you cant afford this !!": GOTO 770
811 ELH = INT(5 * RND + 30): ELM = INT(10 * RND + 20)
812 COLOR 4: PRINT "Ok ! Here drink this ...": COLOR 10: PRINT "You gained "; ELH; " HP and "; ELM; " magic from the Elixer !!!"
813 MH = MH + ELH: MM = MM + ELM: GOTO 770
860 PRINT : TDG = 1
861 COLOR 15: PRINT "     You walk into the eating area of the bar and notice an old man sitting"
862 PRINT "in the corner..."
863 COLOR 7: PRINT "You approach him ..."
864 PRINT : COLOR 15: PRINT "(T)alk to De Grazus"
865 COLOR 7: PRINT "(B)uy special warp stone"
866 COLOR 8: PRINT "(R)eturn to Inn"
867 COLOR 4: INPUT "What is your command "; E$
868 IF E$ = "T" THEN GOTO 875
869 IF E$ = "B" THEN GOTO 890
870 IF E$ = "R" THEN GOTO 770
871 GOTO 867
875 IF TDG = 0 THEN PRINT "He doesn't want to talk now ...": GOTO 864
876 TDG = TDG - 1: PRINT : COLOR 15: PRINT "Ahh...it's not very often that someone comes to talk with me ..."
877 PRINT "Since you were so kind to come and chat, I'll give you some info ..."
878 COLOR 7: PRINT " -- Actung Ka isn't the only one behind all this ... actually "
879 PRINT "    someone close to you has some involvment ... I cannot tell you any "
880 PRINT "    much more, for I fear the loss of my life ... be warned young hero,"
881 PRINT "    do not celebrate after defeating Actung Ka ... someone else awaits "
882 PRINT "    you in the dark tower in the horizon ... be careful !"
883 COLOR 10: PRINT "Here...I will give you something special before you leave ... "
884 PRINT "De Grazus gave you 25 healing potions !!": HE = HE + 25: GOTO 864
890 PRINT : COLOR 15: PRINT "Ahh, so you want a special warp stone eh ?"
891 PRINT "These special stones takes you anywhere you wish...there are boundary "
892 PRINT "limitations though...once you touch this stone you will be given a list"
893 PRINT "of places you can go...remember each stone can only be used once...": PRINT "Each one costs 10,000 gold pieces ..."
894 PRINT : COLOR 4: INPUT "Do you wish to buy one (Y/N) "; S$
895 IF S$ = "Y" THEN GOTO 900
896 IF S$ = "N" THEN PRINT "Fine ...": GOTO 864
897 GOTO 894
900 IF MONEY < 10000 THEN COLOR 4: PRINT "You can't afford this !!!": GOTO 864
901 MONEY = MONEY - 10000
902 COLOR 14: PRINT "Where do you wish to warp to ?"
903 COLOR 7: PRINT "(1) Healer's Haven"
904 COLOR 7: PRINT "(2) The domain of J.C. the great Warrior/Wizard"
905 COLOR 7: PRINT "(3) Actung Ka's throne room"
906 COLOR 7: PRINT "(4) Back to town"
907 COLOR 4: INPUT "Where to (#) "; W$
908 IF W$ = "1" THEN GOTO 920
909 IF W$ = "2" THEN GOTO 950
910 IF W$ = "3" THEN GOTO FB
911 IF W$ = "4" THEN PRINT "You said it, not me !": GOTO 49
912 GOTO 907
920 COLOR 12: PRINT : PRINT "You magically warp to the land known as Healer's Haven ..."
921 PRINT "The Supreme ruler of the land approaches you...Welcome brave warrior ..."
922 PRINT "Since we do not get too many visitors here, I will give you the gift of the"
923 PRINT "gods...here take these ..."
924 COLOR 10: PRINT "You recieved 100 healing potions !"
925 HE = HE + 100
926 COLOR 15: PRINT TAB(28); "Press any key to Continue"
927 A$ = INKEY$: IF A$ = "" THEN GOTO 927
928 GOTO 704
950 PRINT : COLOR 10: PRINT "You magically warp to J.C. 's domain ..."
951 PRINT "J.C. approaches you... hummm you paid alot for that stone didn't you ?"
952 PRINT "Well, tell you what, since I have a reputation to maintain, I'll give "
953 PRINT "this ..."
954 COLOR 10: PRINT "You recieved 20 HP and 30 magic !!!"
955 MH = MH + 20: MM = MM + 30: HA = MH - h: MA = MM - M: h = h + HA: M = M + MA
956 COLOR 15: PRINT TAB(28); "Press any key to Continue"
957 A$ = INKEY$: IF A$ = "" THEN GOTO 957
958 GOTO 704

FB: ACTUNG = 10000: AKMAX = 10000: AKM = 5000: AKMM = 5000
PRINT : COLOR 7: PRINT "You enter the dark and dirty tower..."
COLOR 15: PRINT "This is it...the world rests in your hands !"
COLOR 10: PRINT "Your Status -- "; h; "/"; MH
COLOR 12: PRINT "Actung Ka Status --"; ACTUNG; "/"; AKMAX
PRINT : COLOR 4: PRINT "Actung Ka:"; : COLOR 4: PRINT " You fool ! You cannot defeat me !  Not even your great grandfather"
COLOR 4: PRINT "           could defeat me HA HA...you have made a grave mistake coming here !"
COLOR 10: PRINT "You :"; : COLOR 2: PRINT " You gonna shut up and fight or what ?!?!?"
COLOR 12: PRINT "Actung Ka:"; : COLOR 4: PRINT " You shall die now !!! AAAAHHHHH !!!"
COLOR 15: : PRINT : PRINT TAB(28); "Press any key to continue"
1000 Q$ = INKEY$: IF Q$ = "" THEN GOTO 1000

CLS
1001 COLOR 10: PRINT "You --"; h; "/"; MH, , , : COLOR 12: PRINT "  Actung Ka --"; ACTUNG; "/"; AKMAX
1002 COLOR 2: PRINT "Magic --"; M; "/"; MM, , , : COLOR 12: PRINT "Magic --"; AKM; "/"; AKMM
1010 IF h < 0 THEN COLOR 4: PRINT "You have died...Darkness fills your soul...": GOTO ENDGAME
1020 IF ACTUNG < 0 THEN GOTO Victory
1030 COLOR 15: PRINT : PRINT "(A)ttack", "(M)agic", "(H)eal"
1040 COLOR 7: INPUT "What is your command "; B$
1050 IF B$ = "A" THEN GOTO 1100
1052 IF B$ = "M" THEN GOTO 1700
1053 IF B$ = "H" THEN GOTO 2000
1054 GOTO 1040
1100 YA = INT(10 * RND + 30)
1101 EA = INT(15 * RND + 35)
1102 COLOR 10: PRINT "You attack Actung Ka for "; YA; " hit points !!!": ACTUNG = ACTUNG - YA
1103 COLOR 12: PRINT "Actung Ka attacks you for "; EA; " hit points !!!": h = h - EA
1104 GOTO 1001
1700 IF M < 0 THEN PRINT "You have no more Magic !!!": GOTO 1001
1701 IF MONE$ = "" THEN COLOR 4: PRINT "You don't have that magic !!": GOTO 1001
1702 IF MTWO$ = "" THEN COLOR 4: PRINT "You don't have that magic !!": GOTO 1001
1703 IF MTHREE$ = "" THEN COLOR 4: PRINT "You don't have that magic !!": GOTO 1001
1800 PRINT "(1) Magic One ---"; MONE$
1801 PRINT "(2) Magic Two ---"; MTWO$
1802 PRINT "(3) Magic Three -"; MTHREE$
1803 COLOR 15: INPUT "Which magic "; M$
1804 IF M$ = "1" THEN GOTO 1850
1805 IF M$ = "2" THEN GOTO 1870
1806 IF M$ = "3" THEN GOTO 1890
1807 GOTO 1803
1850 IF M < 30 THEN PRINT "You don't have enough magic to cast this spell !": GOTO 1001
1851 M = M - 30
1852 MD = INT(20 * RND + 40)
1853 COLOR 10: PRINT "You cast the spell of "; MONE$; " !! Actung Ka looses "; MD; " hit points !!": ACTUNG = ACTUNG - MD
1854 akmagic = INT(1 * RND + 4)
1855 IF akmagic = 1 THEN LET ama$ = "Thunder"
1856 IF akmagic = 2 THEN LET ama$ = "DETH"
1857 IF akmagic = 3 THEN LET ama$ = "Wave"
1858 IF akmagic = 4 THEN LET ama$ = "Stone"
1859 IF akmagic = 5 THEN LET ama$ = "Dragon"
1860 AM = INT(25 * RND + 35)
1861 COLOR 12: PRINT "Actung Ka attacks using "; ama$; " !! You lose "; AM; " hit points !!": h = h - AM
1862 GOTO 1001
1870 IF M < 50 THEN PRINT "You don't have enough magic to cast this spell !": GOTO 1001
1871 M = M - 50
1872 MD = INT(20 * RND + 40)
1873 COLOR 10: PRINT "You cast the spell of "; MTWO$; " !! Actung Ka looses "; MD; " hit points !!": ACTUNG = ACTUNG - MD
1874 akmagic = INT(1 * RND + 4)
1875 IF akmagic = 1 THEN LET ama$ = "Thunder"
1876 IF akmagic = 2 THEN LET ama$ = "DETH"
1877 IF akmagic = 3 THEN LET ama$ = "Wave"
1878 IF akmagic = 4 THEN LET ama$ = "Stone"
1879 IF akmagic = 5 THEN LET ama$ = "Dragon"
1880 AM = INT(25 * RND + 35)
1881 COLOR 12: PRINT "Actung Ka attacks using "; ama$; " !! You lose "; AM; "hit points !!": h = h - AM
1882 GOTO 1001
1890 IF M < 100 THEN PRINT "You don't have enough magic to cast this spell !": GOTO 1001
1891 M = M - 100
1892 MD = INT(30 * RND + 50)
1893 COLOR 10: PRINT "You cast the spell of "; MTHREE$; " !! Actung Ka looses "; MD; " hit points !!": ACTUNG = ACTUNG - MD
1894 akmagic = INT(1 * RND + 4)
1895 IF akmagic = 1 THEN LET ama$ = "Thunder"
1896 IF akmagic = 2 THEN LET ama$ = "DETH"
1897 IF akmagic = 3 THEN LET ama$ = "Wave"
1898 IF akmagic = 4 THEN LET ama$ = "Stone"
1899 IF akmagic = 5 THEN LET ama$ = "Dragon"
1900 AM = INT(30 * RND + 40)
1901 COLOR 12: PRINT "Actung Ka attacks using "; ama$; " !! You lose "; AM; "hit points !!": h = h - AM
1902 GOTO 1001
2000 PRINT : COLOR 14: PRINT "You take 1 healing potion...all HP and MP recovered !"
2001 HE = HE - 1: AH = MH - h: h = h + AH: MH = MM - M: M = M + MH
2002 GOTO 1001

Victory:
CLS : COLOR 10
PRINT "     Congratulations ... you have done it...you have defeated Actung Ka, and you"
PRINT "have regained control over the runes..."
COLOR 15: PRINT "King:  Ah you are indeed a great warrior, with such courage and "
COLOR 15: PRINT "       determination, I offer you my daughter's hand in marriage."
COLOR 7: PRINT "You:  Your majesty, it would be an honor to marry your daughter.  I"
COLOR 7: PRINT "      take very good care of her."
COLOR 15: PRINT "King:  My son, welcome to the family...I will now use the rune"


Save:
OPEN "PLAYER.DAT" FOR OUTPUT AS #1
PRINT #1, h
PRINT #1, MH
PRINT #1, M
PRINT #1, MM
PRINT #1, HE
PRINT #1, MONEY
PRINT #1, LU
PRINT #1, L
PRINT #1, X
PRINT #1, MONE$
PRINT #1, MTWO$
PRINT #1, MTHREE$
CLOSE #1
GOTO 49

load:
OPEN "PLAYER.DAT" FOR INPUT AS #1
INPUT #1, h
INPUT #1, MH
INPUT #1, M
INPUT #1, MM
INPUT #1, HE
INPUT #1, MONEY
INPUT #1, LU
INPUT #1, L
INPUT #1, X
INPUT #1, MONE$
INPUT #1, MTWO$
INPUT #1, MTHREE$
CLOSE #1
GOTO 49

ENDGAME:

