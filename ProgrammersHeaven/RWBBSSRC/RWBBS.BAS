'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' OK here's the deal
' I wrote this in 1987 & put it on EXEC-PC, and never got any response on it
' until 1992 when someone inquired about it.  Seems it was written in Quick-
' BASIC 2.0.... (I can't even remember having Vers 2.0)... Anyway 1987 was
' probably 2 computers ago and I couldn't find any source code for this program
' until I came upon an old floppy marked "RWBBS"...only it appeared to have
' been erased...
' What appears below is a result of sector searching and copying with a disk
' utility.
'
' As I recall, QB 2.0 did not have built in serial port support and you had 
' to link to GWCOM.OBJ...you shoudl be able to elimimate when compiling with 
' the current QuickBasic 4.0 or 4.5.
'
' There was also a program "RWSETUP" that had to be run first to create
' a configuration file...I couldn't find that program but you should be
' able to figure out what is required and write that program.  Look at the
' section after the line:
'        OPEN "I",1,CONFIG.FILE$
' to see what is required in that file.
'
' I have only partially checked this program for QBASIC 4.5...
' There are possibly a lot more syntax changes required....have fun!!
'
' Bob Wilcox      8/12/92
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

REM $title:'RWBBS         Weather Bulletin Board Program'
REM $subtitle:'Introduction and Setup'
'****************************************************************************
'                             NOTICE
'    This is a "Shareware" program.  You may copy and distribute it
' as long as the program has not been modified and no fee is charged.
'
'****************************************************************************
'
' Revision 1.2
' Written 11-15-87
' Last revised 12-18-87
'
' Copyright 1987
' By Robert Wilcox K8OMS
' 920 N. Washington St
' Owosso, MI     48867
' (517) 725-8531
'
' This program was compiled with QUICKBASIC VER 2.0
' using the following commands:

' QB RWBBS.BAS /e /x /o;
' LINK RWBBS.OBJ+GWCOM.OBJ;

'****************************************************************************
DECLARE SUB BRAG.SCREEN ()
DECLARE SUB SHOW.REPORT (REPORT$, PRINTIT%)
DECLARE SUB DELAY (SECS%)
DECLARE SUB INIT.SCREEN (NM$)
DECLARE SUB PRINT.REVERSE (S$, N%)
DECLARE SUB GET.TIME ()
DECLARE SUB BEEPS ()
DECLARE SUB SHOW.ACTIVE.BULLETINS ()
DECLARE SUB CHECK.KEY ()
DECLARE SUB UPDATE.ACTIVE.BULLETINS ()
DECLARE SUB CHK.CARRIER ()
DECLARE SUB SEND (SND$, LF%)
DECLARE SUB GET.STRING (EKO%, MAXTIME%)
DECLARE SUB UPCASE (S$)
DECLARE SUB CHK.DELAY (ST!, DL%)
1
DEFINT A-Z

COMMON SHARED CARRIER, MODEM.STATUS.REG, EC, COUNT!, COUNT.FILE$, TRUE, FALSE, TESTING, FG, BG, TIMED.OUT, ACTIVE(), GOT.KEY, GOT.KEY$, CURRENT.DATE$, TIM$, LOG.PRINT, FUNCT.KEY, GOT.STRING$, ACTIVE.BUL.FILE$, LOG.FILE, LOG.FILE$, QUIET, REVISION$
ON ERROR GOTO 50000
'
FG = 0: BG = 7                 'INITIAL FOREGROUND AND BACKGROUND COLORS
REVISION.NUM$ = "1.2"
REVISION$ = "REVISION " + REVISION.NUM$
FALSE = 0: TRUE = NOT FALSE
ECHO = TRUE: NOECHO = FALSE
MAX.MENUS = 12  ' MAX NUMBER OF TIMES TO ALLOW CALLER TO CYCLE THRU PROGRAM
MAX.WAIT = 120  ' MAX TIME (SECS) TO WAIT FOR KEYPRESS BEFORE EJECTING CALLER
CONFIG.FILE$ = "RWBBS.CFG"
COUNT.FILE$ = "RWCOUNT.DTA"
ACTIVE.BUL.FILE$ = "RWACTIVE.DTA"
LOG.FILE$ = "RWBBS.LOG"
COMMENT.FILE$ = "RWCOMENT"
MODEM.RESET$ = "ATZ"
MODEM.INIT$ = "ATM0E0Q0V1X1S2=255S0=1"
ANSWER.COMMAND$ = "ATA"
OFF.HOOK.COMMAND$ = "ATH1"
ON.HOOK.COMMAND$ = "ATH0"
REDIM COMMENTS$(1)
MAX.COMMENT.LINES = 10
CALL BRAG.SCREEN
REM $SUBTITLE:'Read config file and initialize modem'
' $page
CALL SHOW.REPORT("Reading configuration file", 0)
CALL DELAY(1)
EC = 0
CLOSE 1
2
OPEN "I", 1, CONFIG.FILE$
IF EC = 53 THEN LOCATE 14, 1: PRINT STRING$(80, 32): LOCATE 14, 16: COLOR 15, 0: PRINT "Can't find configuration file.  Please run 'RWSETUP'": END
IF EC <> 0 THEN ON ERROR GOTO 0
EC = 0
5
INPUT #1, PORT.NUM$
INPUT #1, RING.TO.ANSWER.ON
INPUT #1, SPEAKER$
INPUT #1, LOG.PRINT
INPUT #1, LOG.FILE
INPUT #1, DUMMY$
INPUT #1, BBS.NAME$
INPUT #1, ALLOW.COMMENTS
INPUT #1, COMMENTS.TO.FILE
INPUT #1, DUMMY$
INPUT #1, COMMENTS.TO.PRINTER
INPUT #1, OFF.HOOK.ON.EXIT
INPUT #1, SHOW.COUNT
INPUT #1, USE.COLOR
INPUT #1, BULLETIN.DRIVE$
INPUT #1, QUIET
INPUT #1, PASSWORD$
'
MID$(MODEM.INIT$, 4) = SPEAKER$
P = INSTR(MODEM.INIT$, "S0=")
MODEM.INIT$ = LEFT$(MODEM.INIT$, P + 2) + STR$(RING.TO.ANSWER.ON)
'
MODEM.STATUS.REG = 1022 - (256 * (VAL(PORT.NUM$) - 1))
MODEM.CONTROL.REG = MODEM.STATUS.REG - 2
IF USE.COLOR THEN FG = 15: BG = 1    ' foreground and background colors for reverse video
' $page
100
CALL INIT.SCREEN(BBS.NAME$ + " " + REVISION$)
IF (EC = 53) OR (COUNT! < 1) THEN LOCATE 18, 22:     CALL PRINT.REVERSE("      WAITING FOR FIRST CALLER      ", 0)
CALL GET.TIME
CALL SHOW.REPORT("RWBBS " + REVISION.NUM$ + " Initializing at " + TIM$ + " on " + CURRENT.DATE$, 1)
CALL DELAY(1)
OUT MODEM.CONTROL.REG, (INP(MODEM.CONTROL.REG) AND 254)
CALL DELAY(1)
CALL SHOW.REPORT(" Initializing communications port ", 0)
CALL DELAY(1)
EC = 0
COM.PORT$ = "COM" + PORT.NUM$ + ":1200,N,8,1"
CLOSE 2
102
OPEN COM.PORT$ FOR RANDOM AS #2
IF EC <> 0 THEN LOCATE 18, 12:  CALL PRINT.REVERSE("MODEM PORT " + PORT.NUM$ + " NOT RESPONDING..Correct and try again", 0): END
'
CALL SHOW.REPORT(" Initializing and testing modem ", 0)
CALL DELAY(2)
PRINT #2, MODEM.RESET$
CALL DELAY(2)
X$ = INPUT$(LOC(2), 2): X$ = ""
'
TRY.COUNT = 0               ' try twice to initialize the modem  (rev 1.2)
INIT:
CALL DELAY(1)
PRINT #2, MODEM.INIT$
CALL DELAY(2)
X$ = INPUT$(LOC(2), 2)
IF INSTR(X$, "OK") < 1 THEN
  IF TRY.COUNT THEN
	  LOCATE 18, 12
	  CALL PRINT.REVERSE("MODEM PORT " + PORT.NUM$ + " NOT RESPONDING..Correct and try again", 0)
	 CALL BEEPS
	 END
  ELSE
	  TRY.COUNT = 1
	  GOTO INIT:
  END IF
END IF
PRINT #2, OFF.HOOK.COMMAND$
CALL DELAY(1)
PRINT #2, ON.HOOK.COMMAND$
105
CALL SHOW.ACTIVE.BULLETINS
IF EC <> 0 THEN LOCATE 20, 1:      PRINT "PROBLEM WITH FILE: "; ACTIVE.BUL.FILE$: ON ERROR GOTO 0: END
CALL GET.TIME
CALL BEEPS
CALL SHOW.REPORT("  Waiting for caller at " + TIM$ + " on " + CURRENT.DATE$, 0)
'
WHILE LOC(2)
X$ = INPUT$(LOC(2), 2)
WEND
' $Subtitle:'Ready for Connect'
' $page
'
'*******************************
'       WAIT FOR CONNECT
'*******************************
WHILE INP(MODEM.STATUS.REG) < 128
'IF (INP(MODEM.STATUS.REG) AND 64) = 64 THEN CALL SHOW.REPORT("RIIIIIIIING!!",0)
	CALL CHECK.KEY
	IF GOT.KEY = 27 THEN GOTO 300                    'ESC key to exit program
	IF FUNCT.KEY THEN
		IF GOT.KEY = 9 THEN PRINT #2, ANSWER.COMMAND$ 'F9 to force answer
		IF GOT.KEY = 10 THEN                          'F10 to show files locally
			TESTING = TRUE:
			CALL SHOW.REPORT("       L O C A L     A C C E S S       ", 0):
			PRINT #2, OFF.HOOK.COMMAND$
			CALL DELAY(1)
			GOTO CONNECTED
		END IF ' (F10)
		IF GOT.KEY > 0 AND GOT.KEY < 6 THEN         ' F1 - F5
			ACTIVE(GOT.KEY) = NOT ACTIVE(GOT.KEY)    ' TOGGLE ACTIVE(GOT.KEY)
			CALL UPDATE.ACTIVE.BULLETINS             ' AND RE-WRITE FILE
			IF EC <> 0 THEN ON ERROR GOTO 0: END
			CALL SHOW.ACTIVE.BULLETINS
			IF EC <> 0 THEN LOCATE 20, 1:           PRINT "PROBLEM WITH FILE: "; ACTIVE.BUL.FILE$: ON ERROR GOTO 0: END
		END IF  ' (F1-F5)
	END IF  ' (FUNCTION KEY)
WEND
' $SubTitle:'Connected'
' $Page
'*******************************
'         GOT CONNECT
'*******************************
'
CALL DELAY(1)
X$ = INPUT$(LOC(2), 2)
IF INSTR(X$, "1200") THEN BAUD$ = "1200": GOTO CONNECTED' already initialized
IF INSTR(X$, "2400") THEN BAUD$ = "2400"               '  at 1200 baud
BAUD$ = "300"
COM.PORT$ = "COM" + PORT.NUM$ + ":" + BAUD$ + ",N,8,1"
EC = 0
CLOSE 2
OPEN COM.PORT$ FOR RANDOM AS #2
IF EC <> 0 THEN ON ERROR GOTO 0
CALL DELAY(1)
'
'*******************************
'       MODEM HAS CONNECTED
'*******************************
'
CONNECTED:
CALL BEEPS
CALL GET.TIME
CALL CHK.CARRIER
IF NOT CARRIER THEN RUN 1
IF TESTING THEN
  CALLER$ = "SYSOP LOCAL"
  CALL SHOW.REPORT("    Connect " + CALLER$ + " at " + TIM$, -1)
  GOTO SEND.FILES
END IF
COUNT! = COUNT! + 1        ' we got previous count in init.screen subr.
CLOSE 1
OPEN "O", 1, COUNT.FILE$
WRITE #1, COUNT!, TIM$, CURRENT.DATE$
CLOSE 1
CALLER$ = "caller #" + MID$(STR$(COUNT!), 2)
CALL SHOW.REPORT("    Connect " + CALLER$ + " (" + BAUD$ + " baud) at " + TIM$, -1)
' $Subtitle:'Send files'
' $Page
'
'*******************************
'       SEND FILES TO CALLER
'*******************************
'
SEND.FILES:
WHILE LOC(2)
	  X$ = INPUT$(LOC(2), 2)
WEND
'
CALL SEND("", TRUE)
CALL CHK.CARRIER
IF NOT CARRIER THEN RUN 1
CALL SEND("WELCOME TO " + BBS.NAME$, TRUE)
CALL CHK.CARRIER
IF NOT CARRIER THEN RUN 1
IF SHOW.COUNT THEN CALL SEND("YOU ARE " + CALLER$, TRUE)
GOSUB 200
180
FOR SEND.INDEX = 1 TO 3
	 ON SEND.INDEX GOSUB 210, 220, 230
NEXT SEND.INDEX
' $Subroutine:'Menu'
' $page
'
'****************************************************
' MENU FOR CALLER TO SELECT RE-SEND OF FILES OR EXIT
'****************************************************
'
TIMES = 0
190
IF TIMES >= MAX.MENUS THEN 195        ' SAY BYE BYE....HE'S BEEN ON LONG ENUF
X! = FRE("A")
RESTORE 190
FOR SEND.INDEX = 1 TO 9
  READ A$
  CALL SEND(A$, 1)
  IF NOT CARRIER THEN RUN 1
NEXT SEND.INDEX

TIMES = TIMES + 1
CALL SEND("COMMAND: (W,A,S,F,R,C or G): ", 0)
IF NOT CARRIER THEN RUN 1
CALL GET.STRING(ECHO, MAX.WAIT)
IF NOT CARRIER THEN RUN 1
IF TIMED.OUT THEN 235                      ' EJECT CALLER FOR WAITING TOO LONG
CALL SEND("", 1): IF GOT.KEY = 27 THEN 300 ' OR IF SYSOP HITS ESC KEY
IF NOT CARRIER THEN RUN 1
CALL UPCASE(GOT.STRING$): GOT.STRING$ = LEFT$(GOT.STRING$, 1)
IF GOT.STRING$ = "" THEN 190
X = INSTR("WASFRCG", GOT.STRING$)
IF X = 0 THEN 190
ON X GOSUB 200, 180, 210, 220, 230, 800, 195
GOTO 190
'
DATA "-----------------------------------------------------"
DATA "W - REPEAT THE WELCOME MESSAGE"
DATA "A - REPEAT ALL BULLETINS"
DATA "S - REPEAT SPECIAL WEATHER WARNINGS AND WATCH BULLETINS"
DATA "F - REPEAT THE WEATHER FORECAST BULLETIN"
DATA "R - REPEAT THE WEATHER REPORT BULLETIN"
DATA "C - LEAVE A COMMENT"
DATA "G - GOODBYE - HANG UP"
DATA "-----------------------------------------------------"
'
195
F$ = "GOODBYE"
PAUSE = FALSE
GOSUB 500
GOTO 240
'
200
F$ = "WELCOME"
PAUSE = TRUE
GOSUB 500   'Send a file
RETURN
'
210
FOUND.BUL = FALSE
PAUSE = TRUE
FOR I = 1 TO 5
F$ = "BULLET"
IF ACTIVE(I) THEN F$ = F$ + MID$(STR$(I), 2, 1):        GOSUB 500: IF EC = 0 THEN FOUND.BUL = TRUE
NEXT I
IF NOT FOUND.BUL THEN F$ = "NORMAL": GOSUB 500
RETURN
'
220
F$ = "FORECAST"
PAUSE = TRUE
GOSUB 500
RETURN
'
230
F$ = "REPORT"
PAUSE = TRUE
GOSUB 500
RETURN
' $SubTitle:'Program exits'
' $page
'
235
'******************************************************
'        EJECT CALLER AND RECYCLE PROGRAM
'        BECAUSE TIMED OUT WAITING FOR KEYPRESS
'******************************************************
'
CALL SHOW.REPORT("Timed out waiting for keypress", 1)
CALL SEND("", 1)
CALL SEND("TIMED OUT WAITING FOR KEYPRESS...GOODBYE...", 1)
IF NOT CARRIER THEN RUN 1
GOTO 245
'
'******************************************************
'               SAY GOODBYE TO CALLER
'******************************************************
'
240
CALL SEND("Thank you for calling " + BBS.NAME$, TRUE)
IF NOT CARRIER THEN RUN 1
CALL SEND(REVISION$, 0)
IF NOT CARRIER THEN RUN 1
CALL SEND(" RWBBS Software by Bob Wilcox, Owosso Mich.", -1)
CALL GET.TIME
CALL SEND("GOODBYE AT " + TIM$ + " on " + CURRENT.DATE$, 1)
IF NOT CARRIER THEN RUN 1
CALL SEND("click", 1)
CALL DELAY(3)
'
'
'*******************************
'       HANG UP AND RE-CYCLE
'*******************************
'
245
CALL DELAY(1)
CALL GET.TIME
CALL SHOW.REPORT("      Hanging up at " + TIM$, -1)
CALL DELAY(2)
OUT MODEM.CONTROL.REG, (INP(MODEM.CONTROL.REG) AND 254)
CALL DELAY(1)
RUN 1
'
'*******************************
'  EJECT CALLER AND EXIT PGM
'*******************************
'
300
CALL CHK.CARRIER
IF NOT CARRIER THEN 310
CALL SEND("", 1)
CALL SEND("PLEASE CALL BACK LATER...BULLETIN UPDATING IN PROGRESS", 1)
CALL SEND("click", 1)
CALL GET.TIME
CALL SHOW.REPORT("      Hanging up at " + TIM$, -1)
CALL DELAY(5)
OUT MODEM.CONTROL.REG, (INP(MODEM.CONTROL.REG) AND 254)
310
CALL GET.TIME
CALL SHOW.REPORT(" EXITING PROGRAM AT " + TIM$, -1)
CALL DELAY(1)
IF OFF.HOOK.ON.EXIT THEN PRINT #2, OFF.HOOK.COMMAND$ ELSE PRINT #2, MODEM.RESET$
CALL DELAY(2)
COLOR 7, 0
LOCATE CSRLIN - 3, 1
END '         end of main program
' $Page
'
'*******************************
'         SEND A FILE
'*******************************
'
500  ' SEND a file to modem w/line feeds
	  ' if file not found, skip it
	  ' if caller hangs up, restart program
	  ' check for ESC pressed by operator
	  ' check for F1-F5 pressed by operator
	  ' if PAUSE is true wait for enter key after each file sent
EC = O
CLOSE 3
IF LEN(BULLETIN.DRIVE$) THEN F$ = BULLETIN.DRIVE$ + F$
OPEN "I", #3, F$
IF EC = 53 THEN CALL PRINT.REVERSE("Can't find File '" + F$ + "'", 1): RETURN
IF EC <> 0 THEN
	 CLS
	 CALL SHOW.REPORT("DRIVE PROBLEM, DRIVE " + BULLETIN.DRIVE$, 1)
	 LOCATE 4, 1
	 CALL PRINT.REVERSE("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", 1)
	 CALL PRINT.REVERSE(SPACE$(22) + "Can't access drive '" + BULLETIN.DRIVE$ + "'" + SPACE$(22), 1)
	 CALL PRINT.REVERSE("Check the drive door or your bulletin drive selection in RWSETUP  ", 1)
	 CALL PRINT.REVERSE("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", 1)
	 FOR I = 1 TO 4: CALL BEEPS: CALL DELAY(1): NEXT I
	 GOTO 300
END IF
CALL PRINT.REVERSE("SENDING File '" + F$ + "'", 1)
WHILE CARRIER AND (NOT EOF(3))
	LINE INPUT #3, A$
	CALL SEND(A$, TRUE)
WEND
CLOSE 3
IF NOT CARRIER THEN RUN 1 '(carrier was checked by SEND subroutine
CALL CHECK.KEY  'check for key pressed
GOSUB 510
WHILE LOC(2)
	X$ = INPUT$(LOC(2), 2)
WEND
'
C = CSRLIN
CALL SHOW.ACTIVE.BULLETINS
IF EC <> 0 THEN LOCATE 20, 1:      PRINT "PROBLEM WITH FILE: "; ACTIVE.BUL.FILE$: ON ERROR GOTO 0: END
LOCATE C - 1, 1
IF PAUSE THEN
	 CALL SEND("Press ENTER to continue....", 0)
	 CALL GET.STRING(NOECHO, MAX.WAIT)
	 IF NOT CARRIER THEN RUN 1
	 IF TIMED.OUT THEN 235         ' EJECT CALLER FOR WAITING TOO LONG
END IF
IF EC <> 0 THEN ON ERROR GOTO 0
GOSUB 510
CALL SEND("", -1)
RETURN
'
510
IF GOT.KEY = 27 THEN 300
IF FUNCT.KEY THEN
	 IF GOT.KEY > 0 AND GOT.KEY < 6 THEN            ' TOGGLE ACTIVE(GOT.KEY)
	ACTIVE(GOT.KEY) = NOT ACTIVE(GOT.KEY)      ' AND RE-WRITE FILE
	CALL UPDATE.ACTIVE.BULLETINS
	IF EC <> 0 THEN ON ERROR GOTO 0
	C = CSRLIN
	CALL SHOW.ACTIVE.BULLETINS
	IF EC <> 0 THEN LOCATE 20, 1:       PRINT "PROBLEM WITH FILE: "; ACTIVE.BUL.FILE$: ON ERROR GOTO 0
	LOCATE C - 1, 1
	 END IF
END IF
RETURN
575
DATA "RWBBS"
DATA "REMOTE WEATHER BULLETIN BOARD SYSTEM"
DATA "  "
DATA "COPYRIGHT 1987 BY"
DATA "ROBERT WILCOX"
DATA "920 N. WASHINGTON"
DATA "OWOSSO, MICHIGAN  48867"
DATA "(517) 725-8531"
' $Page
'
'*******************************
'       COMMENTS SECTION
'*******************************
'
800
IF NOT ALLOW.COMMENTS THEN
	CALL SEND(" ", 1)
	CALL SEND("SORRY...WE ARE UNABLE TO TAKE COMMENTS AT THIS TIME", 1)
	CALL SEND(" ", 1)
	CALL DELAY(2)
	IF NOT CARRIER THEN RUN 1
	RETURN
END IF
'
CMND$ = "AESCL"
REDIM COMMENTS$(MAX.COMMENT.LINES)
LINES.IN.COMMENT = 0
CALL SEND("", 1)
CALL SEND("You may leave up to" + STR$(MAX.COMMENT.LINES) + " lines as a comment", 1)
CALL SEND("Press <ENTER> to end your comment", 1)
IF NOT CARRIER THEN RUN 1
810
LINES.IN.COMMENT = LINES.IN.COMMENT + 1
IF LINES.IN.COMMENT > MAX.COMMENT.LINES THEN 850
CALL SEND(STR$(LINES.IN.COMMENT) + ": ", 0)
IF NOT CARRIER THEN RUN 1
CALL GET.STRING(ECHO, MAX.WAIT)
IF NOT CARRIER THEN RUN 1
IF TIMED.OUT THEN 235
CALL SEND("", 1)
IF NOT CARRIER THEN RUN 1
IF GOT.STRING$ = "" THEN 850
COMMENTS$(LINES.IN.COMMENT) = GOT.STRING$
GOTO 810
'
850
LINES.IN.COMMENT = LINES.IN.COMMENT - 1
855
CALL SEND("", 1)
IF LINES.IN.COMMENT < 1 THEN GOTO 950
FOR INDEX = 1 TO LINES.IN.COMMENT
	CALL SEND(STR$(INDEX) + ": ", 0)
	CALL SEND(COMMENTS$(INDEX), 1)
IF NOT CARRIER THEN RUN 1
NEXT INDEX
CALL SEND("", 1)
IF NOT CARRIER THEN RUN 1
'
860
CALL SEND("You must 'Save' your comment when finished.", 1)
CALL SEND("(E)dit, (S)ave, (L)ist, (A)dd or (C)ancel: ", 0)
IF NOT CARRIER THEN RUN 1
CALL GET.STRING(ECHO, MAX.WAIT)
IF NOT CARRIER THEN RUN 1
IF TIMED.OUT THEN 235
CALL SEND("", 1)
IF NOT CARRIER THEN RUN 1
IF GOT.STRING$ = "" THEN 860
CALL UPCASE(GOT.STRING$)
X = INSTR(CMND$, GOT.STRING$)
ON X GOTO 900, 910, 920, 950, 855
GOTO 860
'
900  ' ADD
IF LINES.IN.COMMENT >= MAX.COMMENT.LINES THEN CALL SEND("Can't add any more lines", 1): GOTO 860
IF NOT CARRIER THEN RUN 1
GOTO 810
'
910 ' EDIT
CALL SEND("", 1)
CALL SEND("Which line? ", 0)
IF NOT CARRIER THEN RUN 1
CALL GET.STRING(ECHO, MAX.WAIT)
IF NOT CARRIER THEN RUN 1
IF TIMED.OUT THEN 235
CALL SEND("", 1)
IF NOT CARRIER THEN RUN 1
IF GOT.STRING$ = "" THEN 860
X = VAL(GOT.STRING$)
IF X < 1 OR X > LINES.IN.COMMENT THEN 860
CALL SEND(COMMENTS$(X), 1)
CALL SEND("What to change: ", 0)
CALL GET.STRING(ECHO, MAX.WAIT)
IF NOT CARRIER THEN RUN 1
IF TIMED.OUT THEN 235
CALL SEND("", 1)
IF NOT CARRIER THEN RUN 1
IF GOT.STRING$ = "" THEN 860
P = INSTR(COMMENTS$(X), GOT.STRING$)
IF P < 1 THEN CALL SEND("'" + GOT.STRING$ + "' not in line " + STR$(X), 1): GOTO 860
CG$ = GOT.STRING$
CALL SEND("Replace with: ", 0)
CALL GET.STRING(ECHO, MAX.WAIT)
IF NOT CARRIER THEN RUN 1
IF TIMED.OUT THEN 235
CALL SEND("", 1)
IF NOT CARRIER THEN RUN 1
COMMENTS$(X) = LEFT$(COMMENTS$(X), P - 1) + GOT.STRING$ + MID$(COMMENTS$(X), P + LEN(CG$))
GOTO 855
' $Page
'
920   ' SAVE
CALL GET.TIME
CALL SEND("Saving your comment---", 0)
IF NOT CARRIER THEN RUN 1
IF COMMENTS.TO.FILE THEN
	EC = 0
	CLOSE 1
	OPEN "A", 1, COMMENT.FILE$
	IF EC <> 0 THEN 925
	PRINT #1, "Comment from "; CALLER$; " "; CURRENT.DATE$; " at "; TIM$
	FOR INDEX = 1 TO LINES.IN.COMMENT
		PRINT #1, COMMENTS$(INDEX)
	NEXT INDEX
	PRINT #1, ""
	CLOSE 1
END IF
'
'
925
IF COMMENTS.TO.PRINTER THEN
	EC = 0
	LPRINT "Comment from "; CALLER$; " "; CURRENT.DATE$; " at "; TIM$
	FOR INDEX = 1 TO LINES.IN.COMMENT
	  LPRINT COMMENTS$(INDEX)
	NEXT INDEX
	LPRINT
END IF
CALL SEND("", 1)
IF EC = 0 THEN
	CALL SEND("YOUR COMMENT HAS BEEN RECORDED...THANK YOU", 1)
	CALL SHOW.REPORT(CALLER$ + " left a comment at " + TIM$, 1)
	GOTO 960
ELSE
	CALL SEND("UNABLE TO SAVE YOUR COMMENT...SORRY", 1)
	CALL SHOW.REPORT("TROUBLE WITH COMMENT FILE at " + TIM$, 1)
	GOTO 950
END IF
'
950  ' CANCEL
CALL SEND("NO COMMENT LEFT", 1)
IF NOT CARRIER THEN RUN 1
960
CALL SEND("", 1)
IF NOT CARRIER THEN RUN 1
CALLER$ = ""
ERASE COMMENTS$
RETURN
' $Page
'
'*******************************
'          ERROR TRAP
'*******************************
'
50000
EC = ERR
'LOCATE 16,1:PRINT"error = "EC:PRINT"error line"erl
IF EC = 62 THEN 50010
RESUME NEXT
50010
IF ERL <> 5 THEN ON ERROR GOTO 0
LOCATE 18, 1
PRINT "You must have an old version of the file '"; CONFIG.FILE$; "'"
PRINT "Please run 'RWSETUP'"
END     'of file "RWBBS.BAS"

'
'*******************************
'          MAKE NOISE
'*******************************
'
SUB BEEPS STATIC
IF QUIET THEN EXIT SUB
SOUND 1000, .5
SOUND 2000, .5
SOUND 1000, .5
END SUB

'
'*******************************
'    SHOW COPYRIGHT NOTICE
'*******************************
'
SUB BRAG.SCREEN STATIC
NUM.OF.BRAG.LINES = 8
TOP.LINE$ = "É" + STRING$(78, "Í") + "»"
MID.LINE$ = "º" + STRING$(78, " ") + "º"
LAST.LINE$ = "È" + STRING$(78, "Í") + "¼"
CLS
PRINT
PRINT TOP.LINE$
FOR I = 1 TO NUM.OF.BRAG.LINES + 2
	PRINT MID.LINE$
NEXT I
PRINT LAST.LINE$
RESTORE 575
FOR I = 1 TO 8: READ A$: LOCATE 3 + I, 40 - LEN(A$) / 2: PRINT A$: NEXT I
LOCATE 6, 40 - LEN(REVISION$) / 2: PRINT REVISION$
CALL DELAY(5)
END SUB

'
'*************************************
' CHECK FOR KEY PRESSED ON LOCAL KYBD
'*************************************
'
' Returns FUNCT.KEY = TRUE if function key was pressed
'         GOT.KEY = Return code set by this subroutine if
'                   function key or ascii code if regular key.
'
SUB CHECK.KEY STATIC
FUNCT.KEY = FALSE
GOT.KEY = FALSE
GOT.KEY$ = INKEY$
IF GOT.KEY$ = "" THEN EXIT SUB
IF LEN(GOT.KEY$) = 2 THEN GOTO 450
GOT.KEY = ASC(GOT.KEY$)
EXIT SUB
450
FUNCT.KEY = TRUE
GOT.KEY = ASC(RIGHT$(GOT.KEY$, 1))
GOT.KEY$ = ""
IF GOT.KEY < 59 OR GOT.KEY > 68 THEN GOT.KEY = 0: EXIT SUB
GOT.KEY = GOT.KEY - 58                 ' IF F1 THROUGH F10 SET GOT.KEY = 1
END SUB                                ' THROUGH 10 ACCORDINGLY.

'
'*******************************
'    CHECK FOR CARRIER LOSS
'*******************************
'
SUB CHK.CARRIER STATIC
CARRIER = TRUE
IF TESTING THEN EXIT SUB
IF INP(MODEM.STATUS.REG) > 127 THEN EXIT SUB
CALL GET.TIME
CALL SHOW.REPORT("      Carrier lost at " + TIM$, 1)
CALL DELAY(1)
CARRIER = FALSE
END SUB

'
'*******************************
'      TIME OUT CHECKER
'*******************************
'
SUB CHK.DELAY (ST!, DL) STATIC ' returns TIMED.OUT = TRUE if
TIMED.OUT = FALSE              ' elapsed time is > DL
ELAPSED! = TIMER - ST!
ELAPSED! = ELAPSED! - (ELAPSED! < 0) * 86400!' to correct for going past midnight
IF ELAPSED! > DL THEN TIMED.OUT = TRUE
END SUB

' $Page
'
'*******************************
'    DELAY "SECS" SECONDS
'*******************************
'
SUB DELAY (SECS) STATIC
IF SECS < 1 THEN EXIT SUB
TOTAL! = TIMER: TOTAL! = SECS + TOTAL!: IF TOTAL! < 86400! THEN GOTO 650
600
T1! = TIMER
IF T1! > SECS THEN GOTO 600
TOTAL! = TOTAL! - 86400!
650
T1! = TIMER
WHILE TIMER - T1! < SECS
WEND
END SUB

'
'*******************************
'    GET STRING FROM CALLER
'*******************************
'
SUB GET.STRING (EKO, MAXTIME) STATIC   ' IF EKO <> 0 THE CHARACTERS ARE ECHOED.
T1! = TIMER: X = 0                     ' IF MAXTIME IS EXCEEDED ROUTINE RETURNS
GOT.STRING$ = ""                       '     W/TIMED.OUT = TRUE.
555                                    ' BACKSPACE OR DEL DELETES LAST CHAR.
CALL CHK.CARRIER                       ' CHARACTERS TYPED FROM LOCAL KYBD ARE
IF NOT CARRIER THEN EXIT SUB           ' ALSO RECOGNIZED.
IF LEN(GOT.STRING$) > 75 THEN EXIT SUB ' MAX. STRING LENGTH IS 75 CHARACTERS.
CALL CHK.DELAY(T1!, MAXTIME)
IF TIMED.OUT THEN EXIT SUB
CALL CHECK.KEY
X = GOT.KEY
X$ = GOT.KEY$
IF X = 27 THEN EXIT SUB
IF FUNCT.KEY THEN
	IF GOT.KEY > 0 AND GOT.KEY < 6 THEN        ' TOGGLE ACTIVE(GOT.KEY)
	ACTIVE(GOT.KEY) = NOT ACTIVE(GOT.KEY)      ' AND RE-WRITE FILE
	CALL UPDATE.ACTIVE.BULLETINS
	IF EC <> 0 THEN EXIT SUB
	C = CSRLIN
	CALL SHOW.ACTIVE.BULLETINS
	IF EC <> 0 THEN EXIT SUB
	LOCATE C - 1, 1
	END IF
END IF
'
IF X$ <> "" THEN GOTO 560
X = LOC(2): IF X = 0 THEN GOTO 555
X$ = INPUT$(1, 2)
'
560
X = ASC(X$) AND 127
X$ = CHR$(X)
IF X = 13 THEN EXIT SUB
IF (X = 8 OR X = 127) AND LEN(GOT.STRING$) THEN GOTO 565
IF X < 32 OR X > 126 THEN 555
IF EKO THEN CALL SEND(X$, 0)
GOT.STRING$ = GOT.STRING$ + X$
GOTO 555
'
565
GOT.STRING$ = LEFT$(GOT.STRING$, LEN(GOT.STRING$) - 1)
IF EKO THEN PRINT CHR$(29) + " " + CHR$(29); :    PRINT #2, CHR$(8) + " " + CHR$(8);
GOTO 555
END SUB

'
'*******************************
'    GET DATE AND TIME
'*******************************
'
SUB GET.TIME STATIC
'
CURRENT.DATE$ = LEFT$(DATE$, 6) + RIGHT$(DATE$, 2)
TIM$ = TIME$
IF VAL(MID$(TIM$, 1, 2)) = 12 THEN MID$(TIM$, 1, 2) = RIGHT$(STR$(VAL(MID$(TIM$, 1, 2))), 2):   TIM$ = LEFT$(TIM$, 5) + " PM":     EXIT SUB
IF VAL(MID$(TIM$, 1, 2)) > 11 THEN MID$(TIM$, 1, 2) = RIGHT$(STR$(VAL(MID$(TIM$, 1, 2)) - 12), 2): TIM$ = LEFT$(TIM$, 5) + " PM":     EXIT SUB
		TIM$ = LEFT$(TIM$, 5) + " AM"
		END SUB

' $Page
'
'*******************************
'    INITIALIZE LOCAL SCREEN
'*******************************
'
SUB INIT.SCREEN (NM$) STATIC
'
TOP.LINE$ = "É" + STRING$(78, "Í") + "»"
MID.LINE$ = "º" + STRING$(78, " ") + "º"
LAST.LINE$ = "È" + STRING$(78, "Í") + "¼"
SKIP = (80 - LEN(NM$)) / 2
CLS
CALL PRINT.REVERSE(TOP.LINE$, 0)        ' Print program title
FOR I = 1 TO 3                          ' box
	  CALL PRINT.REVERSE(MID.LINE$, 0)
NEXT I
CALL PRINT.REVERSE(LAST.LINE$, 0)
LOCATE 3, SKIP
CALL PRINT.REVERSE(NM$, 0)
'
TOP.LINE$ = "Ú" + STRING$(49, "Ä") + "¿"   ' Print key explanation box
MID.LINE$ = "³" + STRING$(49, " ") + "³"
LAST.LINE$ = "À" + STRING$(49, "Ä") + "Ù"
LOCATE 7, 16
CALL PRINT.REVERSE(TOP.LINE$, 0)
FOR I = 1 TO 3
	 LOCATE 7 + I, 16
	 CALL PRINT.REVERSE(MID.LINE$, 0)
NEXT I
LOCATE I + 7, 16
CALL PRINT.REVERSE(LAST.LINE$, 0)
LOCATE 8, 17
CALL PRINT.REVERSE(" Press ESC to eject caller and EXIT from program", 0)
LOCATE 9, 17
CALL PRINT.REVERSE(" F9 to force answer       F10 view files locally", 0)
LOCATE 10, 17
CALL PRINT.REVERSE(" F1 - F5 to toggle active bulletins", 0)
'
580
CLOSE 1
EC = 0
COUNT! = 0!
OPEN "I", #1, COUNT.FILE$
IF EC <> 0 THEN EXIT SUB
INPUT #1, COUNT!
INPUT #1, TM$
INPUT #1, CD$
CLOSE 1
IF COUNT! < 1 THEN EXIT SUB
LOCATE 23, 17
CALL PRINT.REVERSE(" Last caller was number" + STR$(COUNT!) + " at " + TM$ + " on " + CD$, 0)
END SUB

' $Subtitle:'Subroutines'
' $Page
'
'     *************************************************************
'     *                        SUBROUTINES                        *
'     *************************************************************
'
'**********************************
' PRINTS A STRING IN REVERSE VIDEO
'**********************************
'
SUB PRINT.REVERSE (S$, N) STATIC           'PRINTS STRING S$ ON LOCAL SCREEN
COLOR FG, BG                               'IN REVERSE VIDEO
PRINT S$;                                  'WITH CRLF IF N<>0
COLOR 7, 0
IF N THEN PRINT
END SUB

'
'*******************************
'   SEND A STRING TO MODEM
'*******************************
'
SUB SEND (SND$, LF) STATIC
X! = FRE("A")
CALL CHK.CARRIER
IF NOT CARRIER THEN EXIT SUB
PRINT SND$; : IF LF THEN PRINT
IF NOT TESTING THEN PRINT #2, SND$; : IF LF THEN PRINT #2, CHR$(13) + CHR$(10);
END SUB

' $page
'
'*******************************************
' DISPLAY ON LINE 25 WHICH BULLETINS ACTIVE
'*******************************************
'
SUB SHOW.ACTIVE.BULLETINS STATIC
325
'
REDIM ACTIVE(5)
SPEC.BUL$ = " Active Bulletins: "
EC = 0                             ' read active bull file first, then..
CLOSE 1                            ' show them on line 25
OPEN "I", #1, ACTIVE.BUL.FILE$
IF EC = 53 THEN
	GOSUB 350                  ' create empty file if none exists
	GOTO 325
END IF
IF EC <> 0 THEN EXIT SUB
'
FOR I = 1 TO 5:   INPUT #1, ACTIVE(I):  IF ACTIVE(I) THEN SPEC.BUL$ = SPEC.BUL$ + STR$(I) + " " ELSE SPEC.BUL$ = SPEC.BUL$ + "   "
NEXT I
CLOSE 1
'
LOCATE 25, 1
CALL PRINT.REVERSE(SPEC.BUL$, 0)
EXIT SUB
'
350                                ' create empty active bulletin file
EC = 0
CLOSE 1
OPEN "O", #1, ACTIVE.BUL.FILE$
IF EC <> 0 THEN RETURN:   EXIT SUB ELSE WRITE #1, 0, 0, 0, 0, 0:  CLOSE 1
RETURN
'
END SUB

'
'*******************************
'   PUTS REPORT$ ON LINE 25
'*******************************
'
SUB SHOW.REPORT (REPORT$, PRINTIT) STATIC  ' PRINTS STRING REPORT$ ON LINE 25
BLANK$ = STRING$(46, 32)                   ' IN REVERSE VIDEO
LOCATE 25, 35                              ' AND ON PRINTER IF PRINTIT AND
CALL PRINT.REVERSE(BLANK$, 0)              ' LOG.PRINT BOTH TRUE
LOCATE 25, 35                              ' AND LOGS TO FILE IF PRINTIT AND
CALL PRINT.REVERSE(REPORT$, 0)             ' LOG.FILE BOTH TRUE
IF PRINTIT AND LOG.PRINT THEN LPRINT REPORT$
IF PRINTIT AND LOG.FILE THEN
	EC = 0
	CLOSE 4
	OPEN "A", 4, LOG.FILE$
	PRINT #4, REPORT$
	IF EC <> 0 THEN
		LOG.FILE = FALSE
		LOCATE 25, 35
		CALL PRINT.REVERSE(BLANK$, 0)
		LOCATE 25, 35
		CALL PRINT.REVERSE("UNABLE TO WRITE TO LOG FILE", 0)
		CALL BEEPS
		CALL DELAY(1)
		CALL BEEPS
		CALL DELAY(2)
	END IF  ' EC <> 0
	CLOSE 4
END IF     ' PRINTIT & LOG.FILE
END SUB

'
'*******************************
' CONVERT STRING TO UPPER CASE
'*******************************
'
SUB UPCASE (S$) STATIC
IF LEN(S$) = 0 THEN EXIT SUB
FOR I = 1 TO LEN(S$)
	CHAR = ASC(MID$(S$, I, 1))
	IF ((CHAR >= ASC("a")) AND (CHAR <= ASC("z"))) THEN MID$(S$, I, 1) = CHR$(CHAR AND 223)
NEXT I
END SUB

' $Page
'
'*******************************
'  UPDATE ACTIVE BULLETIN FILE
'*******************************
'
SUB UPDATE.ACTIVE.BULLETINS STATIC
EC = 0
CLOSE 1
OPEN "O", #1, ACTIVE.BUL.FILE$
IF EC <> 0 THEN EXIT SUB ELSE WRITE #1, ACTIVE(1), ACTIVE(2), ACTIVE(3), ACTIVE(4), ACTIVE(5): CLOSE 1
END SUB

