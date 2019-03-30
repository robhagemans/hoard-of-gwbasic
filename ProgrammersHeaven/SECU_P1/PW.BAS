start:
CLS
LOCATE 3, 3: COLOR 2: PRINT "Enter Password / User I.D"
LOCATE 5, 1
FOR a = 1 TO 10
DO
z$ = INKEY$
LOOP UNTIL z$ <> ""
IF ASC(z$) = 13 THEN GOTO check
pw$ = pw$ + z$
PRINT "*";
NEXT a
check:
OPEN "c:\pw.lst" FOR INPUT AS #1
DO UNTIL EOF(1)
INPUT #1, s$
s2$ = LEFT$(s$, a)
IF s2$ = pw$ THEN CLOSE #1: GOTO ag
LOOP
CLOSE #1
ad:
PRINT
COLOR 4: PRINT : PRINT "Access Denied"
BEEP: BEEP: GOTO start
ag:
PRINT : PRINT : PRINT "Access Granted!"
END

