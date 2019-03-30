ON ERROR GOTO in:
start:
userpassword$ = ""
CLS
PRINT "Enter your User ID Number"
PRINT "Enter -new- for new User"
INPUT userid$
IF userid$ = "new" GOTO new:
PRINT "Enter your Password and press - to end"
DO
q$ = ""
q$ = INKEY$
IF q$ = "-" THEN EXIT DO
IF q$ <> "" THEN GOSUB d:
LOOP
PRINT
idpath$ = userid$ + ".id"
napath$ = userid$ + ".nam"
OPEN idpath$ FOR INPUT AS #1
INPUT #1, password$
CLOSE #1
IF userpassword$ = password$ THEN GOTO ac:  ELSE GOTO na:
GOTO en:
in:
PRINT "This is a invalid User ID  " + userid$
SLEEP 3
RESUME start:
new:
SLEEP 2
CLS
PRINT "Enter your name"
INPUT Name$
PRINT "Enter a new User ID "
INPUT userid$
PRINT "Enter your Password and press - to end"
DO
q$ = ""
q$ = INKEY$
IF q$ = "-" THEN EXIT DO
IF q$ <> "" THEN GOSUB d:
LOOP
idpath$ = userid$ + ".id"
napath$ = userid$ + ".nam"
OPEN idpath$ FOR OUTPUT AS #1
PRINT #1, userpassword$
CLOSE #1
OPEN napath$ FOR OUTPUT AS #2
PRINT #2, Name$
CLOSE #2
PRINT "Your Name is se to be      " + Name$
PRINT "Your User ID is set to be  " + userid$
PRINT "Your Password is set to be " + userpassword$

PRINT "Press any key to continue"
GOSUB presskey:
GOTO start:
na:
PRINT "Access Denied"
SLEEP 3
GOTO start:
d:
IF q$ = "" THEN RETURN
PRINT "*";
userpassword$ = userpassword$ + q$
RETURN
ac:
OPEN napath$ FOR INPUT AS #1
INPUT #1, x$
PRINT "Access Granted To : " + x$
en:

