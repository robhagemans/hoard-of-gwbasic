5 CLS
10 PRINT "TYPER By:Tom Ales Compiled By: Eric Hogner"
20 PRINT "Press Any Key"
30 LINE INPUT a$
40 IF a$ = "" GOTO 5 ELSE 50
45 a$ = "": b$ = "": c$ = "": d$ = "": e$ = "": f$ = "": Pri$ = "": CLS
50 LINE INPUT a$
60 LINE INPUT b$
70 LINE INPUT c$
80 LINE INPUT d$
90 LINE INPUT e$
100 LINE INPUT f$
110 PRINT "Press 'P' to print or 'C' To Clear"
120 INPUT Pri$
130 IF Pri$ = "P" GOTO 170
140 IF Pri$ = "p" GOTO 170
150 IF Pri$ = "C" GOTO 45
160 IF Pri$ = "c" GOTO 45
170 LPRINT a$
171 LPRINT b$
172 LPRINT c$
173 LPRINT d$
174 LPRINT e$
175 LPRINT f$
190 CLS
191 PRINT "Would you like to use Typer 1.2b Again": PRINT "Y/N": INPUT aa$
192 IF aa$ = "Y" GOTO 45
193 IF aa$ = "y" GOTO 45

200 END
