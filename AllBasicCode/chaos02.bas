1 'Program:  "Chaos in Space" Adventure game V1.2
2 'Language:  Q-BASIC/QuickBASIC/PDS/GW-BASIC/FirstBASIC
3 'Author:  Richard Kelly - Newson@37.com
4 'Category:  Games
5 'Code first released:  06/29/2001;  updated version released on 01/25/2002
6 '
10 'Many commands like LTRIM are not used in this code, so it will be is easier
11 'to port the code to run on different machines.
12 '
13 'Version 1.1:  Fixed problem with Saved Game files.  Also, the game now has
14 'a bug fixed where the player might have had a hard time telling the game
15 'to "PUT" a particular object in a particular spot.
16 '
17 'Version 1.2:  A bug involving word alignment is fixed, and code is less
18 'redundant than before.
19 '
100 DIM R$(49), D$(49), O%(29), H%(9), O$(29), O1$(29), E$(10): GOTO 355
101 A3 = 0: D$ = "": C$ = "": B$ = "": A = INSTR(A$, "^"): IF A > 0 THEN A$ = LEFT$(A$, A - 1) + CHR$(34) + MID$(A$, A + 1, 254): GOTO 101
102 L = INSTR(A$, " "): IF L > 0 THEN B$ = LEFT$(A$, L - 1): GOTO 113:  ELSE B$ = A$: L = 1
103 C$ = MID$(A$, L, 99): A3 = 0: A0 = INSTR(C$, " "): A1 = INSTR(C$, "-"): IF A0 = 0 AND A1 = 0 THEN A2 = LEN(C$): A3 = 1: GOTO 107
104 IF A0 > 0 AND A1 > 0 AND A1 < A0 THEN A2 = A1: GOTO 107
105 IF A1 > 0 AND A0 = 0 THEN A2 = A1: GOTO 107
106 A2 = A0 - 1
107 C$ = LEFT$(C$, A2): D$ = D$ + C$: LL = LEN(B$ + D$): IF A3 = 0 THEN 111
108 IF LL > WH THEN GOSUB 116: B$ = C$: A$ = B$
109 IF B$ <> A$ THEN B$ = B$ + D$
110 GOSUB 116: RETURN
111 L = L + A2: IF LL > WH THEN GOSUB 116: B$ = C$: GOTO 113
112 B$ = B$ + D$
113 D$ = ""
114 IF MID$(A$, L, 1) = " " THEN L = L + 1: D$ = D$ + " ": GOTO 114
115 GOTO 103
116 IF LEN(B$) < WH THEN PRINT B$: RETURN ELSE PRINT B$; : RETURN
117 A$ = "It took you" + STR$(M) + " moves to win this game."
118 GOSUB 101: GOTO 350
119 CLS : A$ = R$(LO): IF LO = 27 AND H%(6) = 1 THEN A$ = A$ + "  The wall crusher makes very short work of you ..."
120 A0$ = A$: GOSUB 101: IF RIGHT$(A0$, 4) = " ..." THEN 349
121 IF M = 0 THEN A$ = "The bed you slept in neatly folds up into one of the floor tiles.": GOSUB 101
122 IF LO = 1 AND H%(1) < 0 THEN A$ = "The gravity is disabled, and all the security robots have floated to the top of the ceiling.": GOSUB 101
123 IF LO = 1 AND H%(1) < 0 AND O%(1) > 0 THEN A$ = "You float right up to the ceiling where they are, and you get shot up.  And I *do* mean ^up^.": GOSUB 101: GOTO 349
124 IF LO = 1 AND H%(1) = 1 THEN A$ = "The security robots spot you and blast several large holes through your body's vital organs.  Needless to say, you don't last long after that.": GOSUB 101: GOTO 349
125 IF LO = 1 THEN A$ = "The robots can't fire shots at you because the lack of gravity disables their long-range sensors.  You're safe here.  You've made it out of the station.  Alive.": GOSUB 101: PRINT : GOTO 117
126 IF LO = 19 AND O%(1) = 0 THEN A$ = "Out of nowhere, a swindler zips by, knocks you off of your feet, pulls off your boots, dashes off with them, and then he's gone.  What a rude dude.": O%(1) = 99: GOSUB 101: GOTO 128
127 IF LO = 19 AND H%(4) < 1 AND O%(6) = 0 THEN A$ = "Out of nowhere, a swindler zips by and snatches your clamp and boots right out of your hands.  Then he's gone.": O%(6) = 99: H%(4) = 1: GOSUB 101
128 FOR O = 0 TO 10: E$(O) = "": NEXT: O1 = 0: IF RIGHT$(D$(LO), 1) > "0" THEN E$(0) = "a transporter": O1 = 1
129 FOR O = 1 TO 29: IF O%(O) = LO THEN E$(O1) = O$(O): O1 = O1 + 1
130 NEXT: IF O1 = 0 THEN 139
131 PRINT : A$ = "You can see ": ON O1 GOTO 133, 134
132 FOR O = 0 TO O1 - 2: A$ = A$ + E$(O) + ", ": NEXT: A$ = A$ + "and " + E$(O1 - 1) + ".": GOTO 135
133 A$ = A$ + E$(0) + ".": GOTO 135
134 A$ = A$ + E$(0) + " and " + E$(1) + "."
135 GOSUB 101: IF O%(18) = LO AND O%(5) > 0 THEN A$ = "You get arrested for coming out of your room with no clothes on.  Next time, show a little less vanity.": GOSUB 101: GOTO 350
136 IF O%(24) = LO AND H%(3) = 1 THEN A$ = "You do not survive the attack.": GOSUB 101: GOTO 349
137 IF O%(9) = LO AND H%(3) = 1 THEN A$ = "The smuggler sees you and goes triggerhappy.  He's still shooting long after you're shot up into little bits.": GOSUB 101: GOTO 349
138 IF O%(9) = LO THEN A$ = "The smuggler sees you and fire dozens of shots at you.  The shots bounce off of you and the smuggler is killed by the ricochet of his own laser fire.": GOSUB 101: O%(9) = 99
139 IF LEFT$(D$(LO), 10) = "0000000000" THEN 159
140 O1 = 0: D$ = D$(LO): FOR O = 0 TO 10: E$(O) = "": NEXT: FOR D = 1 TO 10
141 IF MID$(D$, D, 1) = "0" THEN 154
142 ON D GOTO 143, 144, 145, 146, 147, 148, 149, 150, 151, 152: BEEP: END: RUN
143 E$(O1) = "north": GOTO 153
144 E$(O1) = "northeast": GOTO 153
145 E$(O1) = "east": GOTO 153
146 E$(O1) = "southeast": GOTO 153
147 E$(O1) = "south": GOTO 153
148 E$(O1) = "southwest": GOTO 153
149 E$(O1) = "west": GOTO 153
150 E$(O1) = "northwest": GOTO 153
151 E$(O1) = "up": GOTO 153
152 E$(O1) = "down"
153 O1 = O1 + 1
154 NEXT: A$ = "You can go ": ON O1 GOTO 156, 157
155 FOR O = 0 TO O1 - 2: A$ = A$ + E$(O) + ", ": NEXT: A$ = A$ + "and " + E$(O1 - 1) + ".": GOTO 158
156 A$ = A$ + E$(0) + ".": GOTO 158
157 A$ = A$ + E$(0) + " and " + E$(1) + "."
158 PRINT : GOSUB 101: IF M = 0 THEN A$ = "Welcome to the ^Chaos in Space^ Adventure.  Try not to screw up too quickly.": PRINT : GOSUB 101
159 GG = 0: M = M + 1: PRINT : IF M = 1 THEN A$ = "What should I do now (dare I ask)?": GOSUB 101: INPUT "Well"; C$ ELSE INPUT "What should I do now"; C$
160 G$ = "": L = LEN(C$): IF INSTR(C$, " ") = 0 OR RIGHT$(C$, 1) <> " " THEN 162
161 IF MID$(C$, L, 1) <> " " THEN C$ = LEFT$(C$, L) ELSE L = L - 1: GOTO 161
162 A$ = "": FOR L = 1 TO LEN(C$): B$ = MID$(C$, L, 1): IF B$ < "{" AND B$ > "`" THEN A = ASC(B$): A = A - 32: B$ = CHR$(A)
163 A$ = A$ + B$: NEXT: C$ = A$: B$ = C$: L = 1: IF M > 129 THEN A$ = "You're too late.  The station explodes.": GOSUB 101: GOTO 349
164 I = INSTR(B$, " "): A$ = LEFT$(B$, 3): IF I = 0 THEN GOTO 171
165 R2$ = LEFT$(C$, I - 1): L = I
166 IF MID$(C$, L, 1) = " " THEN L = L + 1: GOTO 166
167 R3$ = MID$(C$, L, 254): I = INSTR(R3$, " "): IF I = 0 THEN R2$ = R2$ + " " + R3$: GOTO 170
168 R3$ = LEFT$(R3$, I - 1): L = L + I: IF R3$ = "ONTO" OR R3$ = "INTO" OR R3$ = "OF" OR R3$ = "AT" OR R3$ = "THE" OR R3$ = "IN" OR R3$ = "MY" OR R3$ = "YOUR" OR R3$ = "TO" OR R3$ = "A" OR R3$ = "ON" THEN GOTO 166
169 R2$ = R2$ + " " + R3$: GOTO 166
170 A$ = A$ + " " + LEFT$(R3$, 3): G$ = R3$: C$ = R2$
171 IF A$ = "LOO" THEN 119
172 D = 0: IF A$ = "N" THEN D = 1 ELSE IF C$ = "" THEN M = M - 1: GOTO 159
173 IF A$ = "NE" THEN D = 2
174 IF A$ = "E" THEN D = 3
175 IF A$ = "SE" THEN D = 4
176 IF A$ = "S" THEN D = 5
177 IF A$ = "SW" THEN D = 6
178 IF A$ = "W" THEN D = 7: IF LO = 2 AND O%(2) = 0 THEN A$ = "Something won't fit.": GOSUB 101: GOTO 159
179 IF A$ = "NW" THEN D = 8
180 IF A$ = "U" THEN D = 9
181 IF A$ = "D" THEN D = 10
182 IF D = 0 THEN 195
183 IF MID$(D$(LO), D, 1) = "0" THEN A$ = "[Bonk]  Ow!  Ya can't go that way.": GOSUB 101: GOTO 159
184 ON D GOTO 185, 186, 187, 188, 189, 190, 191, 192, 193, 194: BEEP: END: RUN
185 LO = LO - 7: GOTO 119
186 LO = LO - 6: GOTO 119
187 LO = LO + 1: GOTO 119
188 LO = LO + 8: GOTO 119
189 LO = LO + 7: GOTO 119
190 LO = LO + 6: GOTO 119
191 LO = LO - 1: GOTO 119
192 LO = LO - 8: GOTO 119
193 LO = LO + 2: GOTO 119
194 LO = LO - 2: GOTO 119
195 F$ = A$: I = INSTR(A$, " "): IF I > 0 THEN F$ = LEFT$(F$, I - 1) ELSE 197
196 IF G$ = "TRAP" THEN G$ = "DOOR" ELSE IF G$ = "BOOKCASE" THEN G$ = "CAS" ELSE IF G$ = "BOOTS" THEN G$ = "GRA" ELSE IF LEFT$(G$, 3) = "POR" THEN G$ = "PIC"
197 G$ = LEFT$(G$, 3): F$ = LEFT$(F$, 3): IF F$ = "REA" OR F$ = "EXA" OR F$ = "LOO" THEN GOSUB 259: GOSUB 101: GOTO 159
198 IF F$ = "TAK" OR F$ = "GET" THEN GOSUB 268: GOSUB 101: GOTO 159
199 IF F$ = "DRO" OR F$ = "LEA" THEN GOSUB 281: GOSUB 101: GOTO 159
200 IF A$ = "GIV RIN" OR C$ = "GIVE RING GUARD" OR C$ = "GIVE GUARD RING" THEN GG = 1
201 IF GG = 1 AND O%(18) = LO AND O%(7) = 0 THEN O%(7) = 99: A$ = "The guard says, ^Oh, thanks, stranger.  I've been looking for this.^  He then walks off, leaving the east exit open.": GG = 2: GOSUB 101
202 IF GG = 2 THEN D$(LO + 1) = "00100010000": O%(18) = 99: PRINT
203 IF GG = 2 THEN A$ = "What he says distresses you.  Not because he couldn't find the ring, but because he called you ^Stranger^.  He's Roger - your best friend for the past 15 years.  No one on this space station recognizes you."
204 IF GG = 2 THEN GOSUB 101: GOTO 159
205 GG = 0: IF A$ = "PUL LEV" OR A$ = "WOR LEV" OR A$ = "FLI LEV" OR A$ = "JER LEV" THEN GG = 1
206 IF GG = 1 AND O%(15) = LO THEN A$ = "Okay - I think something happened in a distant room.": GOSUB 101: H%(6) = NOT H%(6): GOTO 159
207 GG = 0: IF (A$ = "PUL CHA" OR A$ = "TUG CHA") AND O%(16) = LO AND H%(9) = 1 THEN GG = 1: O1$(25) = "A book seems to be missing from it."
208 IF GG = 1 THEN A$ = "It falls and breaks.  A contraption that the chandelier was pulling downward neatly folds itself up into a ceiling tile, and the west exit opens.": GOSUB 101
209 IF GG = 1 THEN H%(9) = 0: D$(LO) = "00100010000": O%(8) = 40: O$(16) = "a broken chandelier": GOTO 159
210 GG = 0: IF (A$ = "PUS DRE" OR A$ = "MOV DRE") AND O%(13) = 99 AND O%(12) = LO THEN GG = 1
211 IF GG = 1 THEN A$ = "Okay - You find a trap door underneath.": GOSUB 101: O%(13) = LO: GOTO 159
212 GG = 0: IF (A$ = "ENT TRA" OR A$ = "GO  TRA") AND RIGHT$(D$(LO), 1) <> "0" THEN GG = 1
213 IF GG = 0 THEN 219
214 A$ = RIGHT$(D$(LO), 1): R1 = 0: R = 1
215 IF RIGHT$(D$(R), 1) = A$ AND R <> LO THEN R1 = R
216 R = R + 1: IF R < 50 THEN 215
217 IF R1 = 0 THEN A$ = "Nothing happens.": GOSUB 101: GOTO 159
218 LO = R1: GOTO 119
219 GG = 0: IF (A$ = "PRE BUT" OR A$ = "PUS BUT") AND O%(17) = LO AND O%(19) = 99 THEN GG = 1
220 IF GG = 1 THEN O%(19) = LO: D$(LO) = "00001000100": A$ = "A panel opens up, revealing a ladder.": GOSUB 101: GOTO 159
221 IF C$ = "PUT PLUNGER TRAP" OR C$ = "PUT PLUNGER TRAP DOOR" OR C$ = "PUT PLUNGER DOOR" OR C$ = "STICK PLUNGER TRAP DOOR" OR C$ = "STICK PLUNGER TRAP" OR C$ = "STICK PLUNGER DOOR" THEN A$ = "PUT PLU"
222 GG = 0: IF (A$ = "RET BOO" OR A$ = "PLA BOO" OR A$ = "PUT BOO" OR A$ = "INS BOOK") AND O%(25) = LO AND O%(8) = 0 THEN GG = 1
223 IF GG = 1 THEN A$ = "The bookcase slides open, revealing a transporter.": GOSUB 101: O%(8) = 98: H%(8) = NOT H%(8): D$(LO) = "00000110003": O1$(25) = "-": GOTO 159
224 GG = 0: IF A$ = "STI PLUN" OR A$ = "PLA PLU" OR A$ = "PUT PLU" THEN GG = 1
225 IF GG = 1 AND O%(13) = LO AND O%(4) = 0 THEN O%(4) = 99: A$ = "The plunger sticks to the trap door.": O$(13) = O$(13) + " with a plunger stuck to it": GOSUB 101: GOTO 159
226 GG = 0: IF (A$ = "OPE DOO" OR C$ = "OPEN TRAP" OR C$ = "OPEN THE TRAP") AND O%(4) = 99 AND O%(13) = LO THEN GG = 1
227 IF GG = 1 THEN D$(LO) = "00101010010": A$ = "It's open.": GOSUB 101: GOTO 159
228 GG = 0: IF (A$ = "ROT PIC" OR A$ = "TUR PIC" OR A$ = "ROT POR" OR A$ = "TUR POR" OR A$ = "TIL PIC" OR A$ = "TIL POR" OR A$ = "STR POR" OR A$ = "STR PIC") AND O%(28) = LO THEN GG = 1
229 IF GG = 1 THEN A$ = "It un-straightens again, and makes a clicking sound.  You hear something move from a distance, then latch in place.": GOSUB 101: D$(12) = "10101000000": GOTO 159
230 GG = 0: IF O%(11) = LO AND H%(5) = 1 AND (A$ = "OPE BOX" OR A$ = "UNL BOX") THEN A$ = "Enter the combination (Aaaaha-ha-ha-ha-haaaaa).": GOSUB 101: GG = 1
231 IF GG = 1 THEN LINE INPUT A$: IF A$ <> CN$ THEN A$ = "Wrong code.  Security will handle you.": GOSUB 101: GOTO 349
232 IF GG = 1 THEN A$ = "The box unlatches and opens.": H%(5) = NOT H%(5): O%(3) = LO: GOSUB 101: GOTO 159
233 GG = 0: IF O%(1) = 0 AND O%(6) = 0 AND H%(4) = 1 AND (A$ = "PUT CLA" OR C$ = "PUT CLAMP BOOTS") THEN GG = 1
234 IF GG = 1 THEN O%(1) = 99: H%(4) = NOT H%(4): A$ = "You take the boots off.  The two connect, so either object is referred to now as ^CLAMP^.": O1$(6) = "It has the boots attached to it.": GOSUB 101: GOTO 159
235 GG = 0: IF (A$ = "REM CLA" OR C$ = "TAKE OFF CLAMP" OR C$ = "TAKE CLAMP OFF" OR C$ = "REMOVE CLAMP FROM BOOTS" OR C$ = "TAKE CLAMP OFF BOOTS") THEN GG = 1
236 IF GG = 1 AND O%(6) = 0 AND O%(1) = 99 AND H%(4) < 0 THEN H%(4) = 1: O%(1) = 0: A$ = "Okay.": GOSUB 101: O1$(6) = "-": GOTO 159
237 GG = 0: IF A$ = "ROT DIA" OR A$ = "TUR DIA" OR C$ = "TURN DIAL AROUND" OR C$ = "TWIST DIAL AROUND" OR A$ = "TWI DIA" THEN GG = 1
238 IF GG = 1 AND O%(3) = 0 AND O%(6) < 50 THEN GG = 2: O%(6) = LO: IF H%(4) = 1 THEN A$ = "The clamp appears next to your feet.": GOSUB 101: GOTO 159
239 IF GG = 2 THEN O%(1) = LO: H%(4) = 1: O1$(6) = "-": A$ = "The clamp and boots appear next to your feet.  The clamp then disconnects from the boots automatically.": GOSUB 101: H%(0) = 0: GOTO 159
240 IF GG = 1 AND O%(3) = 0 THEN A$ = "Nothing happens.": GOSUB 101: GOTO 159
241 IF (C$ = "TAKE OFF DEVICE" OR C$ = "TAKE DEVICE OFF" OR A$ = "REM DEV") AND H%(3) THEN H%(3) = 1: A$ = "Removed.": GOSUB 101: GOTO 159
242 IF (A$ = "WEA DEV" OR C$ = "PUT DEVICE" OR C$ = "PUT DEVICE ON") AND O%(2) = 0 AND H%(3) = 1 THEN H%(3) = NOT H%(3): A$ = "All right.": GOSUB 101: GOTO 159
243 GG = 0: IF (A$ = "FLI SWI" OR A$ = "PUL SWI" OR A$ = "HIT SWI") AND O%(10) = LO THEN GG = 1
244 IF GG = 1 THEN H%(1) = NOT H%(1): IF H%(1) < 1 THEN A$ = "Okay.  The gravity is supposedly off now, but you notice no change.": GOSUB 101: GOTO 159
245 IF GG = 1 THEN A$ = "Okay, the gravity is turned on again.": GOSUB 101: GOTO 159
246 IF F$ = "SAV" THEN GOSUB 314: GOSUB 101: GOTO 159
247 IF F$ = "RES" OR F$ = "LOA" THEN 323
248 IF F$ = "VOC" OR F$ = "VER" THEN GOSUB 332: GOTO 159
249 IF F$ = "INV" THEN GOSUB 335: GOSUB 101: GOTO 159
250 IF F$ = "QUI" THEN 350
251 IF F$ = "HIN" OR F$ = "CLU" THEN A$ = "Try the ^HELP^ or ^VOCAB^ commands.": GOSUB 101: GOTO 159
252 IF F$ = "HEL" THEN GOSUB 293: GOSUB 101: GOTO 159
253 IF F$ = "USE" THEN A$ = "Use?  Please - try a verb that's a little less ... vague.": GOSUB 101: GOTO 159
254 IF F$ = "REM" OR F$ = "FLI" OR F$ = "WEA" OR F$ = "PUL" OR F$ = "PUT" OR F$ = "CLO" OR F$ = "PUS" OR F$ = "GIV" OR F$ = "OPE" THEN A$ = "Try as you might, you can't seem to do that.": GOSUB 101: GOTO 159
255 R = INT(RND * 4): IF R = 0 THEN A$ = "Try a verb that's in my vocabulary, lest I start being sarcastic.": GOSUB 101: GOTO 159
256 ON R GOTO 257, 258: A$ = "Yeah.  Whatever.": GOSUB 101: GOTO 159
257 A$ = "You can't ^" + C$ + "^.": GOSUB 101: GOTO 159
258 A$ = "I know your waist line has a bigger number than your IQ, but even you can do better than that.": GOSUB 101: GOTO 159
259 IF G$ = "" THEN A$ = "Try pairing this verb with a noun.  They make a *great* couple.": RETURN
260 GOSUB 289: IF O = 0 THEN 266
261 IF O1$(O) = "-" THEN 266
262 IF VAL(O1$(O)) = 0 THEN A$ = O1$(O): RETURN
263 A = VAL(O1$(O)): A$ = "You see " + O$(A) + ".": O%(A) = O%(O): O1$(O) = "-"
264 IF O = 3 THEN O1$(O) = "It has a dial in the middle."
265 RETURN
266 A$ = "Well, there isn't much to see."
267 RETURN
268 IF G$ = "" THEN A$ = "Get?  Get what?": RETURN
269 GOSUB 289: IF O = 0 OR O > 8 THEN 279
270 IF (O = 5 OR O = 1) AND O%(O) = LO THEN A$ = "You take them and put them on.": O%(O) = 0: RETURN
271 IF O <> 2 THEN 277
272 IF O%(2) <> LO THEN 278
273 O%(O) = 0: A$ = "You have the crazy thing now.  Do you want to put it on?  [Y]es or [N]o": GOSUB 101: WHILE INKEY$ > "": WEND
274 A$ = INKEY$: IF A$ = "N" OR A$ = "n" THEN A$ = "No": GOTO 280
275 IF A$ <> "Y" AND A$ <> "y" THEN 274
276 A$ = "Yes": H%(3) = NOT H%(3): RETURN
277 IF O%(O) = LO THEN O%(O) = 0: A$ = "Taken.": RETURN
278 IF O%(O) = 0 THEN A$ = "Oh, it's just like you to have something in your hands and forget you have it!  Sheesh!": RETURN
279 A$ = "That idea isn't very practical, but it *is* amusing."
280 RETURN
281 IF G$ = "" THEN A$ = "Try a noun with this verb.  It works *very* well.": RETURN
282 GOSUB 289: IF O = 0 THEN A$ = "I guess I'm too bright too understand an idiot like you.": RETURN
283 IF O > 8 THEN 287
284 IF O%(O) > 0 THEN 287
285 IF O = 2 THEN H%(3) = 1
286 A$ = "Dropped.": O%(O) = LO: RETURN
287 A$ = "You don't have it in your hands, Dimwit."
288 RETURN
289 O = 0: O1 = 1: L = 1
290 IF G$ = MID$(O2$, L, 3) AND (O%(O1) = LO OR O%(O1) = 0) THEN O = O1: RETURN
291 IF L + 2 < LEN(O2$) THEN L = L + 3: O1 = O1 + 1: GOTO 290
292 RETURN
293 IF M = 1 THEN A$ = "Come on!  You just started playing!": RETURN
294 IF RIGHT$(D$(LO), 1) <> "0" THEN A$ = "Think about where you have to be before you are sent by a transporter.": RETURN
295 IF O%(18) = LO THEN A$ = "You must interact with the guard once.": RETURN
296 IF O%(8) < 50 AND LO <> 40 THEN A$ = "Go to the library.": RETURN
297 IF O%(13) = LO AND O%(4) < 50 THEN A$ = "The trap door will open, but you must ^PUT^ an object there first.": RETURN
298 IF LO = 28 AND H%(6) = 1 THEN A$ = "The lever on the switchboard will deactivate one of these hazards, but I won't tell you *which* machine is turned off.  Heh, heh, heh.": RETURN
299 IF O%(1) = 0 AND H%(0) = 1 THEN A$ = "Learn how to use the ^Transporter Boomerang^.": RETURN
300 IF O%(1) > 49 THEN A$ = "I'm very sorry, but you must start over.": RETURN
301 IF O%(18) = 99 AND O%(3) < 50 AND O%(9) < 50 AND H%(9) = 0 AND LEFT$(D$(12), 1) = "1" AND H%(3) = 1 THEN A$ = "*Strange* as it may seem, don't shy away from wearing something extra.": RETURN
302 IF HU = 0 THEN HU = 1: GOTO 313
303 R = INT(RND * 10): IF R = 0 THEN A$ = "Help yourself to KFC's Original Recipe.": RETURN
304 ON R GOTO 305, 306, 307, 308, 309, 310, 311, 312, 313: BEEP: END: RUN
305 A$ = "Try examining things.": RETURN
306 A$ = "Try ^VOCAB^.": RETURN
307 A$ = "Save your games often!": RETURN
308 A$ = "Try making a map as you go.": RETURN
309 A$ = "If all else fails, use two-word commands.": RETURN
310 A$ = "Sometimes you have to type in the object's entire last name and not just the first three letters.": RETURN
311 A$ = "Aside from INVENTORY, HELP, QUIT, SAVE, LOAD, and verb synonyms, every verb in ^VOCAB^ will need to be used at least once.": RETURN
312 A$ = "You don't necessarily need to solve every puzzle to win the game.": RETURN
313 A$ = "Every object that you can pick up has some sort of use.": RETURN
314 F$ = "CHAOS.SG": PRINT "Save to which game file (0-9)?": M = M - 1
315 A$ = INKEY$: IF A$ = CHR$(27) THEN A$ = "Saving aborted.": RETURN
316 IF A$ < "0" OR A$ > "9" THEN 315
317 F$ = F$ + A$: A$ = "Save game #" + A$: GOSUB 101: A$ = F$
318 EL = 2: OPEN A$ FOR OUTPUT AS #1: FOR H = 0 TO 9: PRINT #1, H%(H) + 9: NEXT: FOR O = 1 TO 29: PRINT #1, 99 - O%(O): NEXT
319 FOR O = 6 TO 29: A$ = O$(O): GOSUB 320: A$ = O1$(O): GOSUB 320: NEXT: PRINT #1, 999 - M: PRINT #1, 99 - LO: GOTO 321
320 B$ = A$: A$ = "": FOR L = 1 TO LEN(B$): A = ASC(MID$(B$, L, 1)): A = A + 110: A$ = A$ + CHR$(A): NEXT: PRINT #1, A$: RETURN
321 A$ = CN$: GOSUB 320: FOR D = 5 TO 40: A$ = D$(D): GOSUB 320: NEXT: CLOSE #1: GOTO 322
322 EL = 0: A$ = "Your game is saved.": RETURN
323 F$ = "CHAOS.SG": PRINT "Load which game file (0-9)?": M = M - 1
324 A$ = INKEY$: IF A$ = CHR$(27) THEN A$ = "Loading aborted.": GOSUB 101: GOTO 159
325 IF A$ < "0" OR A$ > "9" THEN 324
326 F$ = F$ + A$: A$ = "Load game #" + A$: GOSUB 101: A$ = F$
327 EL = 1: OPEN A$ FOR INPUT AS #1: FOR H = 0 TO 9: INPUT #1, H1: H1 = H1 - 9: H%(H) = H1: NEXT: FOR O = 1 TO 29: INPUT #1, O1: O1 = O1 - 99: O1 = -O1: O%(O) = O1: NEXT
328 FOR O = 6 TO 29: GOSUB 329: O$(O) = A$: GOSUB 329: O1$(O) = A$: NEXT: INPUT #1, M: M = M - 999: M = -M: INPUT #1, LO: LO = LO - 99: LO = -LO: GOTO 330
329 INPUT #1, B$: A$ = "": FOR L = 1 TO LEN(B$): A = ASC(MID$(B$, L, 1)): A = A - 110: A$ = A$ + CHR$(A): NEXT: RETURN
330 GOSUB 329: CN$ = A$: FOR D = 5 TO 40: GOSUB 329: D$(D) = A$: NEXT: CLOSE #1: GOTO 331
331 EL = 0: GOTO 119
332 A$ = "Here is part of your vocabulary:": GOSUB 101: PRINT
333 A$ = "INVENTORY, GET, TAKE, DROP, REMOVE, WEAR, GIVE, FLIP, PULL, PUSH, MOVE, PUT, TILT, STRAIGHTEN, TURN, ROTATE, SAVE, LOAD, OPEN, GO, ENTER, HELP, LOOK, EXAMINE, and VOCAB."
334 GOSUB 101: RETURN
335 A$ = "You have ": O1 = 0: FOR O = 0 TO 10: E$(O) = "": NEXT: FOR O = 1 TO 8: IF O%(O) = 0 THEN E$(O1) = O$(O): O1 = O1 + 1
336 NEXT: IF O1 = 0 THEN A$ = A$ + "nothing in your hands.": RETURN
337 ON O1 GOTO 339, 340
338 FOR O = 0 TO O1 - 2: A$ = A$ + E$(O) + ", ": NEXT: A$ = A$ + "and " + E$(O1 - 1) + ".": RETURN
339 A$ = A$ + E$(0) + ".": RETURN
340 A$ = A$ + E$(0) + " and " + E$(1) + ".": RETURN
341 RESUME 342
342 ON EL GOTO 345, 347
343 A$ = "I'm sorry, but an error occurred.  This program will now quit.": GOSUB 101: PRINT : PRINT "Press any key to end."
344 IF INKEY$ = "" THEN 344 ELSE WIDTH 80: END: RUN
345 EL = 0: A$ = "An error occurred while loading the file.": CLOSE : GOSUB 101: PRINT : PRINT "Press any key to continue."
346 IF INKEY$ = "" THEN 346 ELSE 356
347 EL = 0: A$ = "An error occurred.  The game could not properly write the file.": CLOSE : RETURN
348 WIDTH 80: END: RUN
349 PRINT : PRINT "You're dead.  Have a nice day."
350 PRINT : A$ = "Press [P] to play again, [L] to load a saved game, or [Q] to quit.": GOSUB 101: A$ = INKEY$
351 A$ = INKEY$: IF A$ = "P" OR A$ = "p" THEN 356
352 IF A$ = "L" OR A$ = "l" THEN 323
353 IF A$ <> "Q" AND A$ <> "q" THEN 351
354 WIDTH 80: CLS : END
355 RANDOMIZE TIMER: SCREEN 0, 0, 0, 0: WIDTH 40: COLOR 7, 0: GOSUB 363: EL = 0: ON ERROR GOTO 341
356 CLS : IF WH = 40 THEN LOCATE 5, 1 ELSE LOCATE 8, 1
357 A$ = "In this adventure, you're on a space station.  The problem is that, due to your body's genetics, your very presence is causing the station to become unstable.  Stay aboard, and the station will explode.": GOSUB 101
358 PRINT : PRINT : A$ = "You wake up this morning, intending to leave.  Unfortunately, the station's instability has already caused the station layout to change dramatically, and no one on the station even recognizes you ...": GOSUB 101
359 RESTORE: PRINT E$: FOR R = 1 TO 49: READ R$(R): NEXT: FOR D = 1 TO 49: READ D$(D): NEXT: FOR H = 1 TO 9: H%(H) = 1: NEXT
360 FOR O = 1 TO 29: READ O$(O), O%(O): NEXT: FOR O1 = 1 TO 29: READ O1$(O1): NEXT: READ O2$: LO = 39: M = 0
361 CN$ = "": FOR T = 1 TO 6: R = INT(RND * 10): R$ = STR$(R): R$ = RIGHT$(R$, 1): CN$ = CN$ + R$: NEXT: O1$(26) = O1$(26) + CN$
362 HU = 0: WHILE INKEY$ = "": WEND: GOTO 119
363 CLS : PRINT TAB(8); "Chaos in Space! adventure": PRINT : PRINT TAB(14); "PC Version 1.2": PRINT : PRINT "   Released as Freeware on 06/11/2001"
364 LOCATE 10, 10: PRINT " Please select your desired text width.": PRINT STRING$(40, "-"); : PRINT TAB(13); "[4] - 40 columns": PRINT TAB(13); "[8] - 80 columns"
365 LOCATE 20, 1: PRINT TAB(9); "Written by Richard Kelly": PRINT : PRINT "   With special thanks to Mike Snyder": PRINT : PRINT "    His website: WWW.PROWLER-PRO.COM";
366 A$ = INKEY$: IF A$ = "4" THEN WH = 40: RETURN
367 IF A$ <> "8" THEN 366
368 WIDTH 80: WH = 80: RETURN
369 DATA"You're in the shuttlecraft.","You're in the northwest corner of the shuttle bay.","You're at the north side of the shuttle bay."
370 DATA"You're standing in view of an old, abandoned shuttlecraft, which is rickety and dangerous from lack of use.  You don't *dare* come near this thing.","You're in a small dead-end room."
371 DATA"This is a dead end in the corridor.","You're in an escape pod.  A bandit sees you and quickly stabs you, thinking you're here to arrest him ..."
372 DATA"You're in a small workshop with disassembled shuttle parts everywhere.  You get roasted alive by an ^enhanced^ walkie-talkie ..."
373 DATA"You're in the west end of the shuttle bay.  The stack of cargo isn't solid;  there's a path through this end of the shuttle bay.","You're in the middle of the area of cargo."
374 DATA"You're on the east side of the shuttle bay, just north of the enterance.","You stand between two iron doors here.","You're in a corridor.","The floor is too weak.  It collapses underneath your feet, and you fall to your death ..."
375 DATA"You're in what *would* be called an attic, but everyone knows there's no attic on a space station.  Many things are here, but most of them are of no importance."
376 DATA"You're near the sealed enterance to a shuttlecraft.  It *used* to be a shuttlecraft, anyway;  some techo-geek reassembled it into some sort of crazy, unexplainable who-zee-doo."
377 DATA"This is the south side of the shuttle bay, just west of the enterance."
378 DATA"You're at the enterance of the shuttle bay.  This is a large, boxed-shaped room, but a thick pile of cargo blocks any movement to the northwest.","You're close to the enterance to the shuttle bay."
379 DATA"You're at the enterance to a corridor.","You're nearing the recreation area, but a deadly laser from a security beam quickly puts an end to your fun ..."
380 DATA"Crazy, useless devices seem to be the norm in this room, and you only spotted one device that wasn't nailed down to the floor."
381 DATA"You're in the old, abandoned Snack Room.  Several dust-covered vending machines are here, with dust-covered candy bars inside.  You're not hungry for some reason."
382 DATA"You're in a room full of switches.  You can tell just by looking what each switch does, because they're laid out for the dimwit in Room 312.  Most switches will do you no good, but you see one that you remember being useful."
383 DATA"You're in a strange bedroom - with no bed.","You're in someone's bathroom, and find someone bathing in their tub.  He gets mad at you for invading his privacy, and swiftly kills you ...","You're in the path of the wall crusher."
384 DATA"There's a cheerful little wall crusher to the west, and a nice little Death Laser to the north to liven up the room.  Yeah.  This is great.","The transporter is malfunctioning.  You never make it to this room alive ..."
385 DATA"You're in a diagonal hall.","You're in an elegant dining room.  There's no table here;  it must have been relocated when the space station's layout changed.","You're by the enterance of your room."
386 DATA"You're at the end of the hall.  The rest of the rooms this way must have disappeared when you napped.","The hall in this area forks like an irregular intersection.  You suspect that the change of the station layout started here."
387 DATA"You've reached the nuclear reactor.  Sparks fly out from the reactor, blinding you, and knocking you off your feet.  You break your back and can't get back up.  With no friends to check up on you, the station eventually explodes ..."
388 DATA"You're continuing down a mangled, zig-zagged hallway.","You're nearing a workshop, but both directions available continue to zig-zag along."
389 DATA"You're in your modest, two-door bathroom.","This is your bedroom."
390 DATA"You're in your small, private library, with gold, blue, black, and white coloring the room.  A pleasing little room in a once-familiar space station that's now so strange and unsettling."
391 DATA"You're in the heart of Engineering, recently ^improved^ by some interior decorator who shouldn't quit his day job.","You're in the corner of the engineering section."
392 DATA"You're in a small workshop.  A pile of mechanical parts is to the east.","The pile of parts is unused because it has massive radiation poisoning.  You die almost instantly ..."
393 DATA"You're in someone's storage area, apparently abandoned by the owner.","You're in your closet.","You're in a square room with four out of five directions blocked by tall, heavy machinery."
394 DATA"It isn't safe here.  There's a huge hole in the station, with the vacuum of space sucking away everything in the station near the hole and sending the objects out into space.  Including you ..."
395 DATA"You're in a room filled with large machines, and all but one machine is covered with hundreds of unlabeled buttons."
396 DATA"00100000000","00101010000","00100010000","00001010000","00001000000","00001000000","00000000100"
397 DATA"00010000000","10101000000","00000010000","10001000000","00100000000","10101010000","00000010000"
398 DATA"00000000001","10100101000","00100010000","10100010000","10000010000","10101000000","00101000000"
399 DATA"01000000000","00000000100","00100000000","00101010000","00001000000","10100000000","10000110000"
400 DATA"00000000002","00100100000","00100000000","10101010000","00000010000","01100010000","00000010000"
401 DATA"01100000000","00000110000","00110000000","10100010000","00000110000","00101100000","00001010003"
402 DATA"01100000100","00100000000","00000000010","01000001000","01000000002","10000000000","10000000001"
403 DATA"a pair of gravity boots",45,"a strange device",22,"a ^Transporter Boomerang^",99,"a plunger",24,"some clothes",46
404 DATA"a ^Boomerang^ clamp",99,"a ring",99,"a book",99,"a goods smuggler",10,"a switch",10,"a box",15
405 DATA"a dresser",25,"a trap door",99,"a wooden ladder",99,"a lever",24,"a chandelier",31,"a portrait of a wildflower",5
406 DATA"a security guard",32,"a hard plastic ladder",99,"a sink",38,"a large switchboard",24,"a toilet",38
407 DATA"a chair",24,"a security guard firing lasers at you",37,"a bookcase",40
408 DATA"several vending machines",23,"a hard plastic ladder",99,"a picture of a rose",41,"a button",99
409 DATA"They keep the person using them on the metal ground with magnets on the heels."
410 DATA"It's a dark green helmet, covered with pink marble-like things, and has a clamp-like belt wired to it.  Well, I told you it was strange!"
411 DATA"6","-","-","It will only attach to objects with magnets.","It's dry, so it must have fallen in the sink recently.","Funny, all the pages are blank.  Most curious."
412 DATA"-","-","It has a touch-key combination lock.","Huh!  It has wheels!","It has no handle, so you can't open it with your bare hands."
413 DATA"-","-","It looks like it would fall with one small tug.","The center of the flower looks like a button.","He has five rings on one hand, and four on the other."
414 DATA"-","7","-","Trust me - If there's something in there, you don't want to know about it."
415 DATA"It's bolted to the floor.  Guess someone was tired of having their chair swiped from them."
416 DATA"He's firing a hundred zillion shots at you, and can't figure out why you're not dead yet.  This guy's going nuts here."
417 DATA"-","You see defunct Snickers bars, dead Tootsie Rolls, and ^matured^ Baby Ruths.  Of more significance is a sticker with a code: "
418 DATA"-","It seems to be crooked.","-"
419 DATA"GRADEVBOOPLUCLOCLARINBOOSMUSWIBOXDREDOOLADLEVCHAPICGUALADSINBOATOICHAGUACASMACLADPICBUT"

