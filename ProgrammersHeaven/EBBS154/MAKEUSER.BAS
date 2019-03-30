'01-23-1993 - Creates a USERFILE for registered BBS Chess door
'
'This EXE file should reside in the C:\EBBS sub directory and
'creates the USERFILE in the c:\bbschess directory

DEFINT A-Z

OPEN "\EBBS\DOOR.SYS" FOR INPUT AS #2
 INPUT #2, NAME1$, PORT$, BAUD$, TIME.LIMIT$, GRAPH$, ALARM$
CLOSE #2

OPEN "USERFILE" FOR OUTPUT AS #2
 PRINT#2, NAME1$
 PRINT#2, BAUD$
CLOSE #2

A$=PORT$+" USERFILE"
B$=BAUD$
C$=NAME1$:IF C$="System Operator" THEN C$=""
IF PORT$="0" THEN A$="LOCAL "+C$

SHELL "BBSCHESS "+A$
