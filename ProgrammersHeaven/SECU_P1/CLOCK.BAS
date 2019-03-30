password$="system"
F:
LOGONP$ = ""
CLS
LOCATE 7, 3: PRINT "The Time Is "; TIME$
LOCATE 9, 3: PRINT "Logging on to C:\ ..."
SOUND 700, 4
SLEEP 1
PRINT
COLOR 3
LOCATE 3, 1
PRINT "Enter Password: [         ]"
LOCATE 3, 18
FOR a = 1 TO 9
DO
null$ = INKEY$
LOOP UNTIL null$ <> ""
N = ASC(null$)
IF N = 13 THEN GOTO check
LOGONP$ = LOGONP$ + null$
PRINT "*";
NEXT a
check:
pwf$ = UCASE$(LOGONP$)
IF pwf$=password$  THEN GOTO valid
invalid:
CLS
GOTO F:
valid:
PRINT : PRINT "-------------------------------------------------"

