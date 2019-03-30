ON ERROR GOTO er
start:

pw$ = ""
OPEN "c:\pw.dat" FOR INPUT AS #1
INPUT #1, pw$
CLOSE #1
IF pw$ = "new" THEN GOTO npw
SCREEN 9
p$ = "": d = 6
CLS
COLOR 2
LOCATE 3, 3: PRINT "ENTER PASSWORD"
COLOR 4: LOCATE 5, 1
FOR a = 1 TO 10
DO
Z$ = INKEY$
LOOP UNTIL Z$ <> ""
IF ASC(Z$) = 13 THEN GOTO con
p$ = p$ + Z$
PRINT "*";
SOUND 500, 1
NEXT a

con:
IF p$ = "999*n" THEN GOTO er
IF p$ = pw$ THEN GOTO na

no:
SOUND 500, 6: LOCATE 7, 3: PRINT "INVALID PASSWORD"
DO: LOOP UNTIL INKEY$ <> ""
GOTO start

na:
d = 0: IF d = 3 THEN RETURN
SCREEN 9: COLOR 2: LOCATE 10, 3: PRINT "ACCESS IS GRANTED"

OPEN "c:\system.log" FOR APPEND AS #1
PRINT #1, p$, TIME$, DATE$
CLOSE #1

BEEP: PRINT "Added to logging file..."

SYSTEM
END





er:
CLS
OPEN "c:\pw.dat" FOR OUTPUT AS #3
PRINT #3, "new"
CLOSE #3
GOTO start
