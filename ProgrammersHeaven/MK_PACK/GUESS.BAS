CLS
PRINT ""
PRINT ""
PRINT ""
PRINT "                      Welcome to The Guessing Game!!"
PLAY "o1l2p4p4p4p4p4p4p4"
CLS
INPUT "Please enter your name. ", name$
CLS
PRINT "Welcome, "; name$; "!"
PRINT "You are going to have to guess a number from ___ to ___."
PRINT "You can choose what two numbers your guessed number is going to "
PRINT "be between.  "
1 INPUT "PUSH ENTER TO CONTINUE. ", con$
IF con$ = "" THEN GOTO 2 ELSE BEEP
GOTO 1
2 CLS
INPUT "What is your low number going to be? ", l
INPUT "What is your high number going to be? ", h
PRINT
PRINT " "; name$; ", your low number is "; l; " and your high is "; h; "."
PLAY "o1l1p4p4p4p4p4p4"
CLS
PRINT ""
INPUT "All right, choose a number between your low and your high. ", num
LET pick = INT(RND * (h)) + l
IF num = pick THEN GOTO 3 ELSE GOTO 4
3 PRINT "Hooray!! You guessed the secret number!!"
PLAY "o3l5aabbccddeefacbl1c"
END
4 PRINT "Sorry, you are incorrect."
GOTO 2


