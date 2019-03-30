CLS
SCREEN 8
REM GOTO 2
LOCATE 12, 19: PRINT " Welcome to the digitized version of darts!!!"
LOCATE 14, 12: PRINT " the object is to enter 2 numbers and try and hit the center"
PLAY "acddeeafffaggc"
4 CLS
2 CIRCLE (320, 90), 200, 3
CIRCLE (320, 89), 50, 2
CIRCLE (320, 89), 15, 4
CIRCLE (320, 89), 128, 9
DRAW "C9d85"
DRAW "B"
DRAW "u168"
DRAW "B"
DRAW "d83"
DRAW "r200"
DRAW "l200"
DRAW "l200"
LOCATE 2, 3: PRINT "enter 2 numbers"
LOCATE 3, 3: INPUT a, b
PSET (a, b)
LET c = a + b
LOCATE 4, 3: IF c = 409 THEN PRINT "Nice Center Hit!!!!!!": GOTO 8
LOCATE 4, 3: IF c > 409 THEN PRINT "You missed try again (y/n)": GOTO 7
LOCATE 4, 3: IF c < 409 THEN PRINT "You missed dork try again (y/n)": GOTO 7
7 INPUT d$
IF d$ = "y" THEN GOTO 4

END

8 END









 









