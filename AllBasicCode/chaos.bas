1 'Program: "Chaos in Space" Adventure game
2 'Author:  Richard Kelly
3 'Q-BASIC/GW-BASIC/FirstBASIC Source code release:  06/29/2001
4 'Author's E-Mail:  Newson@37.com
5 '
6 'Version 1.1:  Fixed problem with Saved Game files.  Also, the game now has
7 'a bug fixed where the player might have had a hard time telling the game to
8 '"PUT" a particular object in a particular spot.  The "PUT" bug can't be
9 'elaborated without giving away part of the game's solution!
10 DIM R$(49), D$(49), O%(29), H%(9), O$(29), O1$(29), E$(10): GOTO 260
11 A = INSTR(A$, "^"): IF A > 0 THEN A$ = LEFT$(A$, A - 1) + CHR$(34) + MID$(A$, A + 1, 254): GOTO 11
12 L = INSTR(A$, " "): B$ = LEFT$(A$, L - 1): GOTO 21
13 C$ = MID$(A$, L, 99): A3 = 0: A0 = INSTR(C$, " "): A1 = INSTR(C$, "-"): IF A0 = 0 AND A1 = 0 THEN A2 = LEN(C$): A3 = 1: GOTO 16
14 IF A0 > 0 AND A1 > 0 AND A1 < A0 THEN A2 = A1: GOTO 16
15 A2 = A0 - 1
16 C$ = LEFT$(C$, A2): D$ = D$ + C$: LL = LEN(B$ + D$): IF A3 = 0 THEN 19
17 IF LL > WH THEN GOSUB 24: B$ = C$: GOSUB 24: RETURN
18 B$ = B$ + D$: GOSUB 24: RETURN
19 L = L + A2: IF LL > WH THEN GOSUB 24: B$ = C$: GOTO 21
20 B$ = B$ + D$
21 D$ = ""
22 IF MID$(A$, L, 1) = " " THEN L = L + 1: D$ = D$ + " ": GOTO 22
23 GOTO 13
24 IF LEN(B$) < WH THEN PRINT B$: RETURN ELSE PRINT B$; : RETURN
25 A$ = "T180"
26 PLAY A$
27 A$ = "It took you" + STR$(M) + " moves to win this game."
28 GOSUB 11: GOTO 255
29 CLS : A$ = R$(LO): IF LO = 27 AND H%(6) = 1 THEN A$ = A$ + "  The wall crusher makes very short work of you ..."
30 A0$ = A$: GOSUB 11: IF RIGHT$(A0$, 4) = " ..." THEN 254
31 IF M = 0 THEN A$ = "The bed you slept in neatly folds up into one of the floor tiles.": GOSUB 11
32 IF LO = 1 AND H%(1) < 0 THEN A$ = "The gravity is disabled, and all the security robots have floated to the top of the ceiling.": GOSUB 11
33 IF LO = 1 AND H%(1) < 0 AND O%(1) > 0 THEN A$ = "You float right up to the ceiling where they are, and you get shot up.  And I *do* mean ^up^.": GOSUB 11: GOTO 254
34 IF LO = 1 AND H%(1) = 1 THEN A$ = "The security robots spot you and blast several large holes through your body's vital organs.  Needless to say, you don't last long after that.": GOSUB 11: GOTO 254
35 IF LO = 1 THEN A$ = "The robots can't fire shots at you because the gravity disables their long-range sensors.  You're safe here.  You've made it out of the station.  Alive.": GOSUB 11: PRINT : GOTO 25
36 IF LO = 19 AND O%(1) = 0 THEN A$ = "Out of nowhere, a swindler zips by, knocks you off of your feet, pulls off your boots, dashes off with them, and then he's gone.  What a rude dude.": O%(1) = 99: GOSUB 11: GOTO 38
37 IF LO = 19 AND H%(4) < 1 AND O%(6) = 0 THEN A$ = "Out of nowhere, a swindler zips by and snatches your clamp and boots right out of your hands.  Then he's gone.": O%(6) = 99: H%(4) = 1: GOSUB 11
38 FOR O = 0 TO 10: E$(O) = "": NEXT: O1 = 0: IF RIGHT$(D$(LO), 1) > "0" THEN E$(0) = "a transporter": O1 = 1
39 FOR O = 1 TO 29: IF O%(O) = LO THEN E$(O1) = O$(O): O1 = O1 + 1
40 NEXT: IF O1 = 0 THEN 49
41 PRINT : A$ = "You can see ": ON O1 GOTO 43, 44
42 FOR O = 0 TO O1 - 2: A$ = A$ + E$(O) + ", ": NEXT: A$ = A$ + "and " + E$(O1 - 1) + ".": GOTO 45
43 A$ = A$ + E$(0) + ".": GOTO 45
44 A$ = A$ + E$(0) + " and " + E$(1) + "."
45 GOSUB 11: IF O%(18) = LO AND O%(5) > 0 THEN A$ = "You get arrested for coming out of your room with no clothes on.  Next time, show a little less vanity.": GOSUB 11: GOTO 255
46 IF O%(24) = LO AND H%(3) = 1 THEN A$ = "You do not survive the attack.": GOSUB 11: GOTO 254
47 IF O%(9) = LO AND H%(3) = 1 THEN A$ = "The smuggler sees you and goes triggerhappy.  He's still shooting long after you're shot up into little bits.": GOSUB 11: GOTO 254
48 IF O%(9) = LO THEN A$ = "The smuggler sees you and fire dozens of shots at you.  The shots bounce off of you and the smuggler is killed by the ricochet of his own laser fire.": GOSUB 11: O%(9) = 99
49 IF LEFT$(D$(LO), 10) = "0000000000" THEN 69
50 O1 = 0: D$ = D$(LO): FOR O = 0 TO 10: E$(O) = "": NEXT: FOR D = 1 TO 10
51 IF MID$(D$, D, 1) = "0" THEN 64
52 ON D GOTO 53, 54, 55, 56, 57, 58, 59, 60, 61, 62: BEEP: END: RUN
53 E$(O1) = "north": GOTO 63
54 E$(O1) = "northeast": GOTO 63
55 E$(O1) = "east": GOTO 63
56 E$(O1) = "southeast": GOTO 63
57 E$(O1) = "south": GOTO 63
58 E$(O1) = "southwest": GOTO 63
59 E$(O1) = "west": GOTO 63
60 E$(O1) = "northwest": GOTO 63
61 E$(O1) = "up": GOTO 63
62 E$(O1) = "down"
63 O1 = O1 + 1
64 NEXT: A$ = "You can go ": ON O1 GOTO 66, 67
65 FOR O = 0 TO O1 - 2: A$ = A$ + E$(O) + ", ": NEXT: A$ = A$ + "and " + E$(O1 - 1) + ".": GOTO 68
66 A$ = A$ + E$(0) + ".": GOTO 68
67 A$ = A$ + E$(0) + " and " + E$(1) + "."
68 PRINT : GOSUB 11: IF M = 0 THEN A$ = "Welcome to the ^Chaos in Space^ Adventure.  Try not to screw up too quickly.": PRINT : GOSUB 11
69 GG = 0: M = M + 1: PRINT : IF M = 1 THEN A$ = "What should I do now (dare I ask)?": GOSUB 11: INPUT "Well"; C$ ELSE INPUT "What should I do now"; C$
70 G$ = "": L = LEN(C$): IF INSTR(C$, " ") = 0 OR RIGHT$(C$, 1) <> " " THEN 72
71 IF MID$(C$, L, 1) <> " " THEN C$ = LEFT$(C$, L) ELSE L = L - 1: GOTO 71
72 A$ = "": FOR L = 1 TO LEN(C$): B$ = MID$(C$, L, 1): IF B$ < "{" AND B$ > "`" THEN A = ASC(B$): A = A - 32: B$ = CHR$(A)
73 A$ = A$ + B$: NEXT: C$ = A$: B$ = C$: L = 1: IF M > 129 THEN A$ = "You're too late.  The station explodes.": GOSUB 11: GOTO 254
74 I = INSTR(B$, " "): IF I = 0 THEN A$ = LEFT$(B$, 3): GOTO 78
75 A$ = LEFT$(B$, I - 1): L = I + 1: A$ = LEFT$(A$, 3)
76 I = INSTR(B$, " "): IF I > 0 THEN L = I + 1: B$ = MID$(B$, L, 254): GOTO 76
77 A$ = A$ + " " + LEFT$(B$, 3): G$ = B$
78 IF A$ = "LOO" THEN 29
79 D = 0: IF A$ = "N" THEN D = 1 ELSE IF C$ = "" THEN M = M - 1: GOTO 69
80 IF A$ = "NE" THEN D = 2
81 IF A$ = "E" THEN D = 3
82 IF A$ = "SE" THEN D = 4
83 IF A$ = "S" THEN D = 5
84 IF A$ = "SW" THEN D = 6
85 IF A$ = "W" THEN D = 7: IF LO = 2 AND O%(2) = 0 THEN A$ = "Something won't fit.": GOSUB 11: GOTO 69
86 IF A$ = "NW" THEN D = 8
87 IF A$ = "U" THEN D = 9
88 IF A$ = "D" THEN D = 10
89 IF D = 0 THEN 102
90 IF MID$(D$(LO), D, 1) = "0" THEN A$ = "[Bonk]  Ow!  Ya can't go that way.": GOSUB 11: GOTO 69
91 ON D GOTO 92, 93, 94, 95, 96, 97, 98, 99, 100, 101: BEEP: END: RUN
92 LO = LO - 7: GOTO 29
93 LO = LO - 6: GOTO 29
94 LO = LO + 1: GOTO 29
95 LO = LO + 8: GOTO 29
96 LO = LO + 7: GOTO 29
97 LO = LO + 6: GOTO 29
98 LO = LO - 1: GOTO 29
99 LO = LO - 8: GOTO 29
100 LO = LO + 2: GOTO 29
101 LO = LO - 2: GOTO 29
102 F$ = A$: I = INSTR(A$, " "): IF I > 0 THEN F$ = LEFT$(F$, I - 1) ELSE 104
103 IF G$ = "TRAP" THEN G$ = "DOOR" ELSE IF G$ = "BOOKCASE" THEN G$ = "CAS" ELSE IF G$ = "BOOTS" THEN G$ = "GRA" ELSE IF LEFT$(G$, 3) = "POR" THEN G$ = "PIC"
104 G$ = LEFT$(G$, 3): F$ = LEFT$(F$, 3): IF F$ = "REA" OR F$ = "EXA" OR F$ = "LOO" THEN GOSUB 164: GOSUB 11: GOTO 69
105 IF F$ = "TAK" OR F$ = "GET" THEN GOSUB 173: GOSUB 11: GOTO 69
106 IF F$ = "DRO" OR F$ = "LEA" THEN GOSUB 186: GOSUB 11: GOTO 69
107 IF A$ = "GIV RIN" OR C$ = "GIVE RING TO GUARD" OR C$ = "GIVE GUARD RING" OR C$ = "GIVE RING TO THE GUARD" OR C$ = "GIVE THE GUARD THE RING" OR C$ = "GIVE THE RING TO THE GUARD" THEN GG = 1
108 IF GG=1 AND O%(18)=LO AND O%(7)=0 THEN O%(7)=99:A$="The guard says, ^Oh, thanks, stranger.  I've been looking for this.^  He then walks off, leaving the east exit open.":GG=2:GOSUB 11:D$(LO+1)="00100010000":O%(18)=99:PRINT
109 IF GG=2 THEN A$="What he says distresses you.  Not because he couldn't find the ring, but because he called you ^Stranger^.  He's Roger - your best friend for the past 15 years.  No one on this space station recognizes you.":GOSUB 11:GOTO 69
110 GG = 0: IF A$ = "PUL LEV" OR A$ = "WOR LEV" OR A$ = "FLI LEV" OR A$ = "JER LEV" THEN GG = 1
111 IF GG = 1 AND O%(15) = LO THEN A$ = "Okay - I think something happened in a distant room.": GOSUB 11: H%(6) = NOT H%(6): GOSUB 11: GOTO 69
112 GG = 0: IF (A$ = "PUL CHA" OR A$ = "TUG CHA") AND O%(16) = LO AND H%(9) = 1 THEN GG = 1: O1$(25) = "A book seems to be missing from it."
113 IF GG = 1 THEN A$ = "It falls and breaks.  A contraption that the chandelier was pulling downward neatly folds itself up into a ceiling tile, and the west exit opens.": GOSUB 11
114 IF GG = 1 THEN H%(9) = 0: D$(LO) = "00100010000": O%(8) = 40: O$(16) = "a broken chandelier": GOTO 69
115 GG = 0: IF (A$ = "PUS DRE" OR A$ = "MOV DRE") AND O%(13) = 99 AND O%(12) = LO THEN GG = 1
116 IF GG = 1 THEN A$ = "Okay - You find a trap door underneath.": GOSUB 11: O%(13) = LO: GOTO 69
117 GG = 0: IF (A$ = "ENT TRA" OR A$ = "GO TRA") AND RIGHT$(D$(LO), 1) <> "0" THEN GG = 1
118 IF GG = 0 THEN 124
119 A$ = RIGHT$(D$(LO), 1): R1 = 0: R = 1
120 IF RIGHT$(D$(R), 1) = A$ AND R <> LO THEN R1 = R
121 R = R + 1: IF R < 50 THEN 120
122 IF R1 = 0 THEN A$ = "Nothing happens.": GOSUB 11: GOTO 69
123 LO = R1: GOTO 29
124 GG = 0: IF (A$ = "PRE BUT" OR A$ = "PUS BUT") AND O%(17) = LO AND O%(19) = 99 THEN GG = 1
125 IF GG = 1 THEN O%(19) = LO: D$(LO) = "00001000100": A$ = "A panel opens up, revealing a ladder.": GOSUB 11: GOTO 69
126 IF C$ = "PUT PLUNGER ON TRAP" OR C$ = "PUT PLUNGER ON DOOR" OR C$ = "PUT PLUNGER ON THE TRAP" OR C$ = "PUT PLUNGER ON THE DOOR" OR C$ = "PUT THE PLUNGER ON THE TRAP" OR C$ = "PUT THE PLUNGER ON THE DOOR" THEN A$ = "PUT PLU"
127 GG = 0: IF (A$ = "RET BOO" OR A$ = "PLA BOO" OR A$ = "PUT BOO" OR A$ = "INS BOOK") AND O%(25) = LO AND O%(8) = 0 THEN GG = 1
128 IF GG = 1 THEN A$ = "The bookcase slides open, revealing a transporter.": GOSUB 11: O%(8) = 98: H%(8) = NOT H%(8): D$(LO) = "00000110003": O1$(25) = "-": GOTO 69
129 GG = 0: IF A$ = "STI PLUN" OR A$ = "PLA PLU" OR A$ = "PUT PLU" OR C$ = "PUT PLUNGER ON TRAP DOOR" OR C$ = "PUT PLUNGER ON THE TRAP DOOR" OR C$ = "PUT THE PLUNGER ON THE TRAP DOOR" THEN GG = 1
130 IF GG = 1 AND O%(13) = LO AND O%(4) = 0 THEN O%(4) = 99: A$ = "The plunger sticks to the trap door.": O$(13) = O$(13) + " with a plunger stuck to it": GOSUB 11: GOTO 69
131 GG = 0: IF (A$ = "OPE DOO" OR C$ = "OPEN TRAP" OR C$ = "OPEN THE TRAP") AND O%(4) = 99 AND O%(13) = LO THEN GG = 1
132 IF GG = 1 THEN D$(LO) = "00101010010": A$ = "It's open.": GOSUB 11: GOTO 69
133 GG = 0: IF (A$ = "ROT PIC" OR A$ = "TUR PIC" OR A$ = "ROT POR" OR A$ = "TUR POR" OR A$ = "TIL PIC" OR A$ = "TIL POR" OR A$ = "STR POR" OR A$ = "STR PIC") AND O%(28) = LO THEN GG = 1
134 IF GG = 1 THEN A$ = "It un-straightens again, and makes a clicking sound.  You hear something move from a distance, then latch in place.": GOSUB 11: D$(12) = "10101000000": GOTO 69
135 GG = 0: IF O%(11) = LO AND H%(5) = 1 AND (A$ = "OPE BOX" OR A$ = "UNL BOX") THEN A$ = "Enter the combination (Aaaaha-ha-ha-ha-haaaaa).": GOSUB 11: GG = 1
136 IF GG = 1 THEN LINE INPUT A$: IF A$ <> CN$ THEN A$ = "Wrong code.  Security will handle you.": GOSUB 11: GOTO 254
137 IF GG = 1 THEN A$ = "The box unlatches and opens.": H%(5) = NOT H%(5): O%(3) = LO: GOSUB 11: GOTO 69
138 GG = 0: IF O%(1) = 0 AND O%(6) = 0 AND H%(4) = 1 AND (A$ = "PUT CLA" OR A$ = "PLA CLA" OR C$ = "PUT CLAMP ON BOOTS" OR C$ = "PUT THE CLAMP ON THE BOOTS" OR C$ = "PUT CLAMP ON THE BOOTS") THEN GG = 1
139 IF GG = 1 THEN O%(1) = 99: H%(4) = NOT H%(4): A$ = "You take the boots off.  The two connect, so either object is referred to now as ^CLAMP^.": O1$(6) = "It has the boots attached to it.": GOSUB 11: GOTO 69
140 GG = 0: IF (A$ = "REM CLA" OR C$ = "TAKE OFF CLAMP" OR C$ = "TAKE CLAMP OFF" OR C$ = "TAKE THE CLAMP OFF" OR C$ = "TAKE THE CLAMP OFF OF THE BOOTS" OR C$ = "TAKE CLAMP OFF OF THE BOOTS" OR C$ = "TAKE THE CLAMP OFF THE BOOTS") THEN GG = 1
141 IF GG = 1 AND O%(6) = 0 AND O%(1) = 99 AND H%(4) < 0 THEN H%(4) = 1: O%(1) = 0: A$ = "Okay.": GOSUB 11: O1$(6) = "-": GOTO 69
142 GG = 0: IF A$ = "ROT DIA" OR A$ = "TUR DIA" OR C$ = "TURN THE DIAL AROUND" OR C$ = "TURN DIAL AROUND" OR C$ = "TWIST THE DIAL" OR C$ = "TWIST THE DIAL AROUND" OR A$ = "TWI DIA" THEN GG = 1
143 IF GG = 1 AND O%(3) = 0 AND O%(6) < 50 THEN GG = 2: O%(6) = LO: IF H%(4) = 1 THEN A$ = "The clamp appears next to your feet.": GOSUB 11: GOTO 69
144 IF GG = 2 THEN O%(1) = LO: H%(4) = 1: O1$(6) = "-": A$ = "The clamp and boots appear next to your feet.  The clamp then disconnects from the boots automatically.": GOSUB 11: H%(0) = 0: GOTO 69
145 IF GG = 1 AND O%(3) = 0 THEN A$ = "Nothing happens.": GOSUB 11: GOTO 69
146 IF (C$ = "TAKE OFF THE DEVICE" OR C$ = "TAKE OFF DEVICE" OR C$ = "TAKE DEVICE OFF" OR C$ = "TAKE THE DEVICE OFF" OR A$ = "REM DEV") AND H%(3) THEN H%(3) = 1: A$ = "Removed.": GOSUB 11: GOTO 69
147 IF (A$ = "WEA DEV" OR C$ = "PUT ON THE DEVICE" OR C$ = "PUT THE DEVICE ON" OR C$ = "PUT DEVICE ON" OR C$ = "PUT ON DEVICE") AND O%(2) = 0 AND H%(3) = 1 THEN H%(3) = NOT H%(3): A$ = "All right.": GOSUB 11: GOTO 69
148 GG = 0: IF (A$ = "FLI SWI" OR A$ = "PUL SWI" OR A$ = "HIT SWI") AND O%(10) = LO THEN GG = 1
149 IF GG = 1 THEN H%(1) = NOT H%(1): IF H%(1) < 1 THEN A$ = "Okay.  The gravity is supposedly off now, but you notice no change.": GOSUB 11: GOTO 69
150 IF GG = 1 THEN A$ = "Okay, the gravity is turned on again.": GOSUB 11: GOTO 69
151 IF F$ = "SAV" THEN GOSUB 219: GOSUB 11: GOTO 69
152 IF F$ = "RES" OR F$ = "LOA" THEN 228
153 IF F$ = "VOC" OR F$ = "VER" THEN GOSUB 237: GOTO 69
154 IF F$ = "INV" THEN GOSUB 240: GOSUB 11: GOTO 69
155 IF F$ = "QUI" THEN 255
156 IF F$ = "HIN" OR F$ = "CLU" THEN A$ = "Try the ^HELP^ or ^VOCAB^ commands.": GOSUB 11: GOTO 69
157 IF F$ = "HEL" THEN GOSUB 198: GOSUB 11: GOTO 69
158 IF F$ = "USE" THEN A$ = "Use?  Please - try a verb that's a little less ... vague.": GOSUB 11: GOTO 69
159 IF F$ = "REM" OR F$ = "FLI" OR F$ = "WEA" OR F$ = "PUL" OR F$ = "PUT" OR F$ = "CLO" OR F$ = "PUS" OR F$ = "GIV" OR F$ = "OPE" THEN A$ = "Try as you might, you can't seem to do that.": GOSUB 11: GOTO 69
160 R = INT(RND * 4): IF R = 0 THEN A$ = "Try a verb that's in my vocabulary, lest I start being sarcastic.": GOSUB 11: GOTO 69
161 ON R GOTO 162, 163: A$ = "Yeah.  Whatever.": GOSUB 11: GOTO 69
162 A$ = "You can't ^" + C$ + "^.": GOSUB 11: GOTO 69
163 A$ = "I know your waist line has a bigger number than your IQ, but even you can do better than that.": GOSUB 11: GOTO 69
164 IF G$ = "" THEN A$ = "Try pairing this verb with a noun.  They make a *great* couple.": RETURN
165 GOSUB 194: IF O = 0 THEN 171
166 IF O1$(O) = "-" THEN 171
167 IF VAL(O1$(O)) = 0 THEN A$ = O1$(O): RETURN
168 A = VAL(O1$(O)): A$ = "You see " + O$(A) + ".": O%(A) = O%(O): O1$(O) = "-"
169 IF O = 3 THEN O1$(O) = "It has a dial in the middle."
170 RETURN
171 A$ = "Well, there isn't much to see."
172 RETURN
173 IF G$ = "" THEN A$ = "Get?  Get what?": RETURN
174 GOSUB 194: IF O = 0 OR O > 8 THEN 184
175 IF (O = 5 OR O = 1) AND O%(O) = LO THEN A$ = "You take them and put them on.": O%(O) = 0: RETURN
176 IF O <> 2 THEN 182
177 IF O%(2) <> LO THEN 183
178 O%(O) = 0: A$ = "You have the crazy thing now.  Do you want to put it on?  [Y]es or [N]o": GOSUB 11: WHILE INKEY$ > "": WEND
179 A$ = INKEY$: IF A$ = "N" OR A$ = "n" THEN A$ = "No": GOTO 185
180 IF A$ <> "Y" AND A$ <> "y" THEN 179
181 A$ = "Yes": H%(3) = NOT H%(3): RETURN
182 IF O%(O) = LO THEN O%(O) = 0: A$ = "Taken.": RETURN
183 IF O%(O) = 0 THEN A$ = "Oh, it's just like you to have something in your hands and forget you have it!  Sheesh!": RETURN
184 A$ = "That idea isn't very practical, but it *is* amusing."
185 RETURN
186 IF G$ = "" THEN A$ = "Try a noun with this verb.  It works *very* well.": RETURN
187 GOSUB 194: IF O = 0 THEN A$ = "I guess I'm too bright too understand an idiot like you.": RETURN
188 IF O > 8 THEN 192
189 IF O%(O) > 0 THEN 192
190 IF O = 2 THEN H%(3) = 1
191 A$ = "Dropped.": O%(O) = LO: RETURN
192 A$ = "You don't have it in your hands, Dimwit."
193 RETURN
194 O = 0: O1 = 1: L = 1
195 IF G$ = MID$(O2$, L, 3) AND (O%(O1) = LO OR O%(O1) = 0) THEN O = O1: RETURN
196 IF L + 2 < LEN(O2$) THEN L = L + 3: O1 = O1 + 1: GOTO 195
197 RETURN
198 IF M = 1 THEN A$ = "Come on!  You just started playing!": RETURN
199 IF RIGHT$(D$(LO), 1) <> "0" THEN A$ = "Think about where you have to be before you are sent by a transporter.": RETURN
200 IF O%(18) = LO THEN A$ = "You must interact with the guard once.": RETURN
201 IF O%(8) < 50 AND LO <> 40 THEN A$ = "Go to the library.": RETURN
202 IF O%(13) = LO AND O%(4) < 50 THEN A$ = "The trap door will open, but you must ^PUT^ an object there first.": RETURN
203 IF LO = 28 AND H%(6) = 1 THEN A$ = "The lever on the switchboard will deactivate one of these hazards, but I won't tell you *which* machine is turned off.  Heh, heh, heh.": RETURN
204 IF O%(1) = 0 AND H%(0) = 1 THEN A$ = "Learn how to use the ^Transporter Boomerang^.": RETURN
205 IF O%(1) > 49 THEN A$ = "I'm very sorry, but you must start over.": RETURN
206 IF O%(18) = 99 AND O%(3) < 50 AND O%(9) < 50 AND H%(9) = 0 AND LEFT$(D$(12), 1) = "1" AND H%(3) = 1 THEN A$ = "*Strange* as it may seem, don't shy away from wearing something extra.": RETURN
207 IF HU = 0 THEN HU = 1: GOTO 218
208 R = INT(RND * 10): IF R = 0 THEN A$ = "Help yourself to KFC's Original Recipe.": RETURN
209 ON R GOTO 210, 211, 212, 213, 214, 215, 216, 217, 218: BEEP: END: RUN
210 A$ = "Try examining things.": RETURN
211 A$ = "Try ^VOCAB^.": RETURN
212 A$ = "Save your games often!": RETURN
213 A$ = "Try making a map as you go.": RETURN
214 A$ = "If all else fails, use two-word commands.": RETURN
215 A$ = "Sometimes you have to type in the object's entire last name and not just the first three letters.": RETURN
216 A$ = "Aside from INVENTORY, HELP, QUIT, SAVE, LOAD, and verb synonyms, every verb in ^VOCAB^ will need to be used at least once.": RETURN
217 A$ = "You don't necessarily need to solve every puzzle to win the game.": RETURN
218 A$ = "Every object that you can pick up has some sort of use.": RETURN
219 F$="CHAOS.SG":PRINT"Save to which game file (0-9)?":M=M-1
220 A$ = INKEY$: IF A$ = CHR$(27) THEN A$ = "Saving aborted.": RETURN
221 IF A$ < "0" OR A$ > "9" THEN 220
222 F$ = F$ + A$: A$ = "Save game #" + A$: GOSUB 11: A$ = F$
223 EL = 2: OPEN A$ FOR OUTPUT AS #1: FOR H = 0 TO 9: PRINT #1, H%(H) + 9: NEXT: FOR O = 1 TO 29: PRINT #1, 99 - O%(O): NEXT
224 FOR O = 6 TO 29: A$ = O$(O): GOSUB 225: A$ = O1$(O): GOSUB 225: NEXT: PRINT #1, 999 - M: PRINT #1, 99 - LO: GOTO 226
225 B$ = A$: A$ = "": FOR L = 1 TO LEN(B$): A = ASC(MID$(B$, L, 1)): A = A + 110: A$ = A$ + CHR$(A): NEXT: PRINT #1, A$: RETURN
226 A$ = CN$: GOSUB 225: FOR D = 5 TO 40: A$ = D$(D): GOSUB 225: NEXT: CLOSE #1: GOTO 227
227 EL = 0: A$ = "Your game is saved.": RETURN
228 F$="CHAOS.SG":PRINT"Load which game file (0-9)?":M=M-1
229 A$ = INKEY$: IF A$ = CHR$(27) THEN A$ = "Loading aborted.": GOSUB 11: GOTO 69
230 IF A$ < "0" OR A$ > "9" THEN 229
231 F$ = F$ + A$: A$ = "Load game #" + A$: GOSUB 11: A$ = F$
232 EL = 1: OPEN A$ FOR INPUT AS #1: FOR H = 0 TO 9: INPUT #1, H1: H1 = H1 - 9: H%(H) = H1: NEXT: FOR O = 1 TO 29: INPUT #1, O1: O1 = O1 - 99: O1 = -O1: O%(O) = O1: NEXT
233 FOR O = 6 TO 29: GOSUB 234: O$(O) = A$: GOSUB 234: O1$(O) = A$: NEXT: INPUT #1, M: M = M - 999: M = -M: INPUT #1, LO: LO = LO - 99: LO = -LO: GOTO 235
234 INPUT #1, B$: A$ = "": FOR L = 1 TO LEN(B$): A = ASC(MID$(B$, L, 1)): A = A - 110: A$ = A$ + CHR$(A): NEXT: RETURN
235 GOSUB 234: CN$ = A$: FOR D = 5 TO 40: GOSUB 234: D$(D) = A$: NEXT: CLOSE #1: GOTO 236
236 EL = 0: GOTO 29
237 A$ = "Here is part of your vocabulary:": GOSUB 11: PRINT
238 A$ = "INVENTORY, GET, TAKE, DROP, REMOVE, WEAR, GIVE, FLIP, PULL, PUSH, MOVE, PUT, TILT, STRAIGHTEN, TURN, ROTATE, SAVE, LOAD, OPEN, GO, ENTER, HELP, LOOK, EXAMINE, and VOCAB."
239 GOSUB 11: RETURN
240 A$ = "You have ": O1 = 0: FOR O = 0 TO 10: E$(O) = "": NEXT: FOR O = 1 TO 8: IF O%(O) = 0 THEN E$(O1) = O$(O): O1 = O1 + 1
241 NEXT: IF O1 = 0 THEN A$ = A$ + "nothing in your hands.": RETURN
242 ON O1 GOTO 244, 245
243 FOR O = 0 TO O1 - 2: A$ = A$ + E$(O) + ", ": NEXT: A$ = A$ + "and " + E$(O1 - 1) + ".": RETURN
244 A$ = A$ + E$(0) + ".": RETURN
245 A$ = A$ + E$(0) + " and " + E$(1) + ".": RETURN
246 RESUME 247
247 ON EL GOTO 250, 252
248 A$ = "I'm sorry, but an error occurred.  This program will now quit.": GOSUB 11: PRINT : PRINT "Press any key to end."
249 IF INKEY$ = "" THEN 249 ELSE WIDTH 80: END: RUN
250 EL = 0: A$ = "An error occurred while loading the file.": CLOSE : GOSUB 11: PRINT : PRINT "Press any key to continue."
251 IF INKEY$ = "" THEN 251 ELSE 261
252 EL = 0: A$ = "An error occurred.  The game could not properly write the file.": CLOSE : RETURN
253 WIDTH 80: END: RUN
254 PRINT : PRINT "You're dead.  Have a nice day."
255 PRINT : A$ = "Press [P] to play again, [L] to load a saved game, or [Q] to quit.": GOSUB 11: A$ = INKEY$
256 A$ = INKEY$: IF A$ = "P" OR A$ = "p" THEN 261
257 IF A$ = "L" OR A$ = "l" THEN 228
258 IF A$ <> "Q" AND A$ <> "q" THEN 256
259 WIDTH 80: CLS : END: RUN
260 RANDOMIZE TIMER: SCREEN 0, 0, 0, 0: WIDTH 40: COLOR 7, 0: GOSUB 268: EL = 0: ON ERROR GOTO 246
261 CLS : IF WH = 40 THEN LOCATE 5, 1 ELSE LOCATE 8, 1
262 A$ = "In this adventure, you're on a space station.  The problem is that, due to your body's genetics, your very presence is causing the station to become unstable.  Stay aboard, and the station will explode.": GOSUB 11
263 PRINT : PRINT : A$ = "You wake up this morning, intending to leave.  Unfortunately, the station's instability has already caused the station layout to change dramatically, and no one on the station even recognizes you ...": GOSUB 11
264 RESTORE: PRINT E$: FOR R = 1 TO 49: READ R$(R): NEXT: FOR D = 1 TO 49: READ D$(D): NEXT: FOR H = 1 TO 9: H%(H) = 1: NEXT
265 FOR O = 1 TO 29: READ O$(O), O%(O): NEXT: FOR O1 = 1 TO 29: READ O1$(O1): NEXT: READ O2$: LO = 39: M = 0
266 CN$ = "": FOR T = 1 TO 6: R = INT(RND * 10): R$ = STR$(R): R$ = RIGHT$(R$, 1): CN$ = CN$ + R$: NEXT: O1$(26) = O1$(26) + CN$
267 HU = 0: WHILE INKEY$ = "": WEND: GOTO 29
268 CLS : PRINT TAB(5); "Chaos in Space! - Junior Edition": PRINT : PRINT TAB(14); "PC Version 1.1": PRINT : PRINT "   Released as Freeware on 06/11/2001"
269 LOCATE 10, 10: PRINT " Please select your desired text width.": PRINT STRING$(40, "-"); : PRINT TAB(13); "[4] - 40 columns": PRINT TAB(13); "[8] - 80 columns"
270 LOCATE 20, 1: PRINT TAB(9); "Written by Richard Kelly": PRINT : PRINT "   With special thanks to Mike Snyder": PRINT : PRINT "    His website: WWW.PROWLER-PRO.COM";
271 A$ = INKEY$: IF A$ = "4" THEN WH = 40: RETURN
272 IF A$ <> "8" THEN 271
273 WIDTH 80: WH = 80: RETURN
274 DATA"You're in the shuttlecraft.","You're in the northwest corner of the shuttle bay.","You're at the north side of the shuttle bay."
275 DATA"You're standing in view of an old, abandoned shuttlecraft, which is rickety and dangerous from lack of use.  You don't *dare* come near this thing.","You're in a small dead-end room."
276 DATA"This is a dead end in the corridor.","You're in an escape pod.  A bandit sees you and quickly stabs you, thinking you're here to arrest him ..."
277 DATA"You're in a small workshop with disassembled shuttle parts everywhere.  You get roasted alive by an ^enhanced^ walkie-talkie ..."
278 DATA"You're in the west end of the shuttle bay.  The stack of cargo isn't solid;  there's a path through this end of the shuttle bay.","You're in the middle of the area of cargo."
279 DATA"You're on the east side of the shuttle bay, just north of the enterance.","You stand between two iron doors here.","You're in a corridor.","The floor is too weak.  It collapses underneath your feet, and you fall to your death ..."
280 DATA"You're in what *would* be called an attic, but everyone knows there's no attic on a space station.  Many things are here, but most of them are of no importance."
281 DATA"You're near the sealed enterance to a shuttlecraft.  It *used* to be a shuttlecraft, anyway;  some techo-geek reassembled it into some sort of crazy, unexplainable who-zee-doo."
282 DATA"This is the south side of the shuttle bay, just west of the enterance."
283 DATA"You're at the enterance of the shuttle bay.  This is a large, boxed-shaped room, but a thick pile of cargo blocks any movement to the northwest.","You're close to the enterance to the shuttle bay."
284 DATA"You're at the enterance to a corridor.","You're nearing the recreation area, but a deadly laser from a security beam quickly puts an end to your fun ..."
285 DATA"Crazy, useless devices seem to be the norm in this room, and you only spotted one device that wasn't nailed down to the floor."
286 DATA"You're in the old, abandoned Snack Room.  Several dust-covered vending machines are here, with dust-covered candy bars inside.  You're not hungry for some reason."
287 DATA"You're in a room full of switches.  You can tell just by looking what each switch does, because they're laid out for the dimwit in Room 312.  Most switches will do you no good, but you see one that you remember being useful."
288 DATA"You're in a strange bedroom - with no bed.","You're in someone's bathroom, and find someone bathing in their tub.  He gets mad at you for invading his privacy, and swiftly kills you ...","You're in the path of the wall crusher."
289 DATA"There's a cheerful little wall crusher to the west, and a nice little Death Laser to the north to liven up the room.  Yeah.  This is great.","The transporter is malfunctioning.  You never make it to this room alive ..."
290 DATA"You're in a diagonal hall.","You're in an elegant dining room.  There's no table here;  it must have been relocated when the space station's layout changed.","You're by the enterance of your room."
291 DATA"You're at the end of the hall.  The rest of the rooms this way must have disappeared when you napped.","The hall in this area forks like an irregular intersection.  You suspect that the change of the station layout started here."
292 DATA"You've reached the nuclear reactor.  Sparks fly out from the reactor, blinding you, and knocking you off your feet.  You break your back and can't get back up.  With no friends to check up on you, the station eventually explodes ..."
293 DATA"You're continuing down a mangled, zig-zagged hallway.","You're nearing a workshop, but both directions available continue to zig-zag along."
294 DATA"You're in your modest, two-door bathroom.","This is your bedroom."
295 DATA"You're in your small, private library, with gold, blue, black, and white coloring the room.  A pleasing little room in a once-familiar space station that's now so strange and unsettling."
296 DATA"You're in the heart of Engineering, recently ^improved^ by some interior decorator who shouldn't quit his day job.","You're in the corner of the engineering section."
297 DATA"You're in a small workshop.  A pile of mechanical parts is to the east.","The pile of parts is unused because it has massive radiation poisoning.  You die almost instantly ..."
298 DATA"You're in someone's storage area, apparently abandoned by the owner.","You're in your closet.","You're in a square room with four out of five directions blocked by tall, heavy machinery."
299 DATA"It isn't safe here.  There's a huge hole in the station, with the vacuum of space sucking away everything in the station near the hole and sending the objects out into space.  Including you ..."
300 DATA"You're in a room filled with large machines, and all but one machine is covered with hundreds of unlabeled buttons."
301 DATA"00100000000","00101010000","00100010000","00001010000","00001000000","00001000000","00000000100"
302 DATA"00010000000","10101000000","00000010000","10001000000","00100000000","10101010000","00000010000"
303 DATA"00000000001","10100101000","00100010000","10100010000","10000010000","10101000000","00101000000"
304 DATA"01000000000","00000000100","00100000000","00101010000","00001000000","10100000000","10000110000"
305 DATA"00000000002","00100100000","00100000000","10101010000","00000010000","01100010000","00000010000"
306 DATA"01100000000","00000110000","00110000000","10100010000","00000110000","00101100000","00001010003"
307 DATA"01100000100","00100000000","00000000010","01000001000","01000000002","10000000000","10000000001"
308 DATA"a pair of gravity boots",45,"a strange device",22,"a ^Transporter Boomerang^",99,"a plunger",24,"some clothes",46
309 DATA"a ^Boomerang^ clamp",99,"a ring",99,"a book",99,"a goods smuggler",10,"a switch",10,"a box",15
310 DATA"a dresser",25,"a trap door",99,"a wooden ladder",99,"a lever",24,"a chandelier",31,"a portrait of a wildflower",5
311 DATA"a security guard",32,"a hard plastic ladder",99,"a sink",38,"a large switchboard",24,"a toilet",38
312 DATA"a chair",24,"a security guard firing lasers at you",37,"a bookcase",40
313 DATA"several vending machines",23,"a hard plastic ladder",99,"a picture of a rose",41,"a button",99
314 DATA"They keep the person using them on the metal ground with magnets on the heels."
315 DATA"It's a dark green helmet, covered with pink marble-like things, and has a clamp-like belt wired to it.  Well, I told you it was strange!"
316 DATA"6","-","-","It will only attach to objects with magnets.","It's dry, so it must have fallen in the sink recently.","Funny, all the pages are blank.  Most curious."
317 DATA"-","-","It has a touch-key combination lock.","Huh!  It has wheels!","It has no handle, so you can't open it with your bare hands."
318 DATA"-","-","It looks like it would fall with one small tug.","The center of the flower looks like a button.","He has five rings on one hand, and four on the other."
319 DATA"-","7","-","Trust me - If there's something in there, you don't want to know about it."
320 DATA"It's bolted to the floor.  Guess someone was tired of having their chair swiped from them."
321 DATA"He's firing a hundred zillion shots at you, and can't figure out why you're not dead yet.  This guy's going nuts here."
322 DATA"-","You see defunct Snickers bars, dead Tootsie Rolls, and ^matured^ Baby Ruths.  Of more significance is a sticker with a code: "
323 DATA"-","It seems to be crooked.","-"
324 DATA"GRADEVBOOPLUCLOCLARINBOOSMUSWIBOXDREDOOLADLEVCHAPICGUALADSINBOATOICHAGUACASMACLADPICBUT"
