start:
RESTORE
CLS
PRINT "System Access"
LOCATE 3, 1
PRINT "Enter Password: [         ]"
LOCATE 3, 18
FOR a = 1 TO 9
DO
null$ = INKEY$
LOOP UNTIL null$ <> ""
N = ASC(null$)
IF N = 13 THEN GOTO check
logonp$ = logonp$ + null$
PRINT "*";
NEXT a
check:
IF logonp$ = "system" THEN GOTO valid
invalid:
logonp$ = "": PRINT : PRINT : PRINT "Invalid Logon!": BEEP
PRINT : PRINT "Press any key to try again"
DO: LOOP UNTIL INKEY$ <> ""
GOTO start
valid:
CLS
SYSTEM

