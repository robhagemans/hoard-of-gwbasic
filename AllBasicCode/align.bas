1 'Program:  "Word Alignment" V1.1
2 'Language:  Q-BASIC/QuickBASIC/PDS/GW-BASIC/FirstBASIC
3 'Author:  Richard Kelly - Newson@37.com
4 'Category:  Algorithms
5 'Updated version released:  02/21/2002
6 '
10 'Many commands like LTRIM are not used in this code, so it will be easier
11 'to port the code to run on different versions of BASIC.
12 '
13 'Note that Apple 2 BASIC doesn't support the INSTR command for some reason.
14 '
15 'Version 1.1:  A bug involving the word alignment is now fixed.
16 '
17 'To increase this program's speed, delete all remarks and RENUMber like
18 'this:  RENUM 100,,1
19 '
87 'Go to the start of the program.  The word alignment routine is placed at
88 'the top of the program rather than the bottom, simply because the BASIC
89 'interpreter runs it faster that way.
90 GOTO 1000
97 '
98 ' Begin word alignment routine.  Start by changing all [^] symbols to
99 ' quotation marks.  This makes putting quotes in the text less tedious.
100 A3 = 0: D$ = "": C$ = "": B$ = "": A = INSTR(A$, "^"): IF A > 0 THEN A$ = LEFT$(A$, A - 1) + CHR$(34) + MID$(A$, A + 1, 254): GOTO 100
106 '
107 'Find where the first space is and store it in L.  Store the first word in
108 'B$.  Bug fix:  The IF statement is added to let the code handle one-word
109 'sentences.
110 L = INSTR(A$, " "): IF L > 0 THEN B$ = LEFT$(A$, L - 1): GOTO 220:  ELSE B$ = A$: L = 1
115 '
116 'C$ equals everything at and beyond position L in A$.  Look for "-"s and
117 'spaces.  Find where the next "-" and space are, and store them in A0 and
118 'A1.  If both A0 and A1 equal Zero, have A3 equal One, signalling a mock
119 'Carriage Return.
120 C$ = MID$(A$, L, 99): A3 = 0: A0 = INSTR(C$, " "): A1 = INSTR(C$, "-"): IF A0 = 0 AND A1 = 0 THEN A2 = LEN(C$): A3 = 1: GOTO 160
127 '
128 'If the "-" comes before the space, consider the word up to the "-" a
129 'complete word (including the dash).  A2 refers to the length of the word.
130 IF A0 > 0 AND A1 > 0 AND A1 < A0 THEN A2 = A1: GOTO 160
140 IF A1 > 0 AND A0 = 0 THEN A2 = A1: GOTO 160
145 '
146 'The next is executed under the condition that there's another word after
147 'the one the code is currently working with.
150 A2 = A0 - 1
156 '
157 'Shorten C$ to a "word".  D$ is a "dummy word", complete with necessary
158 'spaces.  It will be added to B$ if there is no word wrap.  LL equals the
159 'length of B$ with D$ added.  B$ is the string to be printed.
160 C$ = LEFT$(C$, A2): D$ = D$ + C$: LL = LEN(B$ + D$): IF A3 = 0 THEN GOTO 200
167 '
168 'WH equals the horizontal width of the text screen (80 in WIDTH 80).  The
169 'WH variable can be changed to any number for smaller or wider screens.
170 IF LL > WH THEN GOSUB 250: B$ = C$: A$ = B$
178 '
179 'Add D$ to the line if the conditions are met.
180 IF B$ <> A$ THEN B$ = B$ + D$
188 '
189 'The word aligment routine's work is done.
190 GOSUB 250: RETURN
195 '
196 'If the sentence went on for more than one line, things had to be handled
197 'accordingly.  Thus this separate routine was written.  Bug fix:  The
198 'IF statement in Line 200 was added to properly handle if the last line of
199 'text had only one "word".
200 L = L + A2: IF LL > WH THEN GOSUB 250: B$ = C$: GOTO 220
207 '
208 'Again, adds the "dummy word" - spaces and all - to B$, the string to be
209 'printed.
210 B$ = B$ + D$
218 '
219 'The code added D$ to B$, so wipe it out for its next use.
220 D$ = ""
228 '
229 'Find a space, then keep searching the string until another word comes up.
230 IF MID$(A$, L, 1) = " " THEN L = L + 1: D$ = D$ + " ": GOTO 230
237 '
238 'Goes back to the routine it was doing before.  The separate routine's
239 'work is done.
240 GOTO 120
246 '
247 'This is where B$ is drawn to screen.  I made it separate so those using
248 'graphical fonts (including myself) could use the routine without too
249 'much trouble.
250 IF LEN(B$) < WH THEN PRINT B$: RETURN ELSE PRINT B$; : RETURN
999 '
1000 WH = 80: SCREEN 9, 0, 0, 0: WIDTH 80: COLOR 7, 0: CLS
1010 A$ = "This is my ^word alignment^ routine.": GOSUB 100: PRINT
1020 A$ = "Forget about manually aligning all the displayed text of your programs.  This program takes care of all of that!": GOSUB 100
1030 PRINT : A$ = "It does all the aligning for you.  Also, it changes every symbol written with [Shift]+[6] and changes it to a quote, making quotation marks easier to put in your text!": GOSUB 100
1040 PRINT : A$ = "I'll prove I'm not pulling your leg here.  Type in some text, and I'll align it for you.": GOSUB 100: PRINT
1050 LINE INPUT "Your sentence: "; A$: L = LEN(A$): IF A$ = "" OR (A$ = STRING$(L, 32)) THEN PRINT "Well, think of something!": PRINT : GOTO 1050
1060 GOSUB 100: PRINT : A$ = "Thanks.  Hope this code is useful!": GOSUB 100
1999 END

