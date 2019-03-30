'Note: in this text, ignore the apostrophes. They are a BASIC requirement.
'This program is a good example of how to communicate with your modem from
'BASIC. It is simple in comparison to commercial programs. If you would
'like to use it for your modem communications, you will need 2 things:
'
'1) The public domain program PCZ.
'2) A basic understanding of your modem's AT commands.
'
'#1 isn't really required but if you want to do file transfers you'll need
'some kind of external protocol. This program is set up to use PCZ but you
'can edit it if you want to use a different one.
'This program is distributed as Shareware. The shareware concept allows you
'to test the program before you actually buy it. It is not free software.
'If you find it useful, you are expected to pay a $5 fee. Send a check or
'money order made out to Tim Hurley to this address:
'
'       Tim Hurley
'       RR1 Box 168P
'       Bay City, TX
'              77414
'
'Any comments or suggestions can be sent to me at either the address above
'or you can send Email to me on )(evious BBS (1-508-875-3618). Just send it
'to TIM HURLEY. You won't find me anywhere else.
'
'Registered users will get a thouroughly commented version IF they also send
'$2 postage.
'You are allowed to make copies of my routines for your personal use. However,
'if you market programs that incluse my routines you must include my name and
'a shareware notice in my name. You are allowed to distribute this entire
'program to your friends with minor modifications if you keep my name on it.
'Shareware companies are allowed to put this program in their catalog and
'they may charge a reasonable duplication fee.
'ALL OTHER RIGHTS RESERVED.
DECLARE SUB center (l!, text$)
   SCREEN 0, , 0, 0
   CLS
   KEY OFF
   SCREEN 0, , 1, 1
   CLOSE
   CLS
   center 1, "MyModem"
   center 2, "by Tim Hurley"
   PRINT : INPUT "What is the desired baud rate"; baud$
    INPUT "Do you want local echo"; le$
    IF le$ = "y" OR le$ = "Y" THEN le = 1
    PRINT "Parity is assumed to be N."
    PRINT "Stop bits are assumed to be 1."
    PRINT "Data bits are set at 8."
    PRINT "Port COM2 will be used."
    PRINT "F1 during the transmission will bring up the transmission menu."
    PRINT "The public domain program PCZ is used for all file transfers."
    openstring$ = "COM2: " + baud$ + ", N, 8, 1"
    KEY 1, "þ"
    OPEN openstring$ FOR RANDOM AS #1
    IF le = 1 THEN PRINT #1, "ATE0"; CHR$(13)
    WHILE NOT EOF(1): e$ = INPUT$(1, #1): WEND
    PRINT "You are now connected to your modem."
220 SCREEN 0, , 1, 1
    oc = CSRLIN: op = POS(0)
    IF oc = 24 THEN LOCATE 24: PRINT : oc = 23
    COLOR 7, 1: LOCATE 25, 1: PRINT SPACE$(26); : PRINT "F1 Calls Communications Menu"; : PRINT SPACE$(26); : COLOR 7, 0
    LOCATE 24, 1: PRINT SPACE$(79);
    LOCATE oc, op
    IF NOT EOF(1) THEN
    ms$ = INPUT$(1, #1)
    IF ms$ = CHR$(13) THEN
    LOCATE CSRLIN, 1
    ELSE
    IF ms$ = CHR$(8) THEN
    IF POS(t) = 1 THEN
    LOCATE CSRLIN - 1, 80
    ELSE
    LOCATE CSRLIN, POS(t) - 1
    END IF
    ELSE
    IF le = 1 THEN COLOR 12
    PRINT ms$; : COLOR 7
    END IF
    END IF
    END IF
    b$ = INKEY$
    IF b$ = CHR$(254) THEN
    GOTO 600
    ELSE
    PRINT #1, b$;
    IF le = 1 AND b$ = CHR$(8) THEN
    IF POS(t) = 1 THEN
    LOCATE CSRLIN - 1, 80
    ELSE
    LOCATE CSRLIN, POS(t) - 1
    END IF
    ELSE
    IF le = 1 THEN PRINT b$;
    END IF
    END IF
    GOTO 220
600 SCREEN 0, , 2, 2
    CLS
    WHILE INKEY$ <> "": mgm$ = INKEY$: WEND
    center 1, "Communications Menu"
    PRINT : PRINT : PRINT "        1) Send a file"
    PRINT : PRINT : PRINT "        2) Receive a file"
    PRINT : PRINT : PRINT "        3) Quit (Make sure you disconnect!)"
    PRINT : PRINT : PRINT "        4) Go back to communications"
    PRINT : PRINT : PRINT : PRINT "    Enter choice: "
690 c$ = INKEY$: IF c$ = "" THEN GOTO 690
    IF VAL(c$) < 1 OR VAL(c$) > 4 THEN BEEP: GOTO 690
    IF c$ = "1" THEN
    CLS
    center 1, "File send"
    PRINT : PRINT : PRINT "Avaliable protocols:"
    PRINT "1) Zmodem"
    PRINT "2) Ymodem"
    PRINT "3) Xmodem"
    PRINT "4) Xmodem 1K"
    PRINT "5) SEALink"
    PRINT "Enter choice: "
810 p$ = INKEY$: IF p$ = "" THEN GOTO 810
    IF VAL(p$) > 5 OR VAL(p$) < 1 THEN BEEP: GOTO 810
    LOCATE CSRLIN + 1, 1: PRINT "This is the complete pathname and name of the file you wish to send.";
    LOCATE CSRLIN - 1, 1
    INPUT "What is the file name"; f$
    SCREEN 0, , 0, 0
    IF p$ = "1" THEN
    ss$ = "pcz 2 " + baud$ + " d sz " + f$
    SHELL ss$
    PRINT "Press any key...": WHILE INKEY$ = "": WEND
    CLS
    GOTO 220
    END IF
    IF p$ = "2" THEN
    ss$ = "pcz 2 " + baud$ + " d sy " + f$
    SHELL ss$
    PRINT "Press any key...": WHILE INKEY$ = "": WEND
    CLS
    GOTO 220
    END IF
    IF p$ = "3" THEN
     ss$ = "pcz 2 " + baud$ + " d sx " + f$
SHELL ss$
PRINT "Press any key...": WHILE INKEY$ = "": WEND
CLS
GOTO 220
END IF
IF p$ = "4" THEN
ss$ = "pcz 2 " + baud$ + " d s1 " + f$
SHELL ss$
PRINT "Press any key...": WHILE INKEY$ = "": WEND
CLS
GOTO 220
END IF
IF p$ = "5" THEN
ss$ = "pcz 2 " + baud$ + " d ss " + f$
SHELL ss$
PRINT "Press any key...": WHILE INKEY$ = "": WEND
CLS
GOTO 220
END IF
END IF


IF c$ = "2" THEN
CLS
center 1, "File receive"
PRINT : PRINT : PRINT "Avaliable protocols:"
PRINT "1) Zmodem"
PRINT "2) Ymodem"
PRINT "3) Xmodem"
PRINT "4) Xmodem 1K"
PRINT "5) SEALink"
PRINT "Enter choice: "
4 p$ = INKEY$: IF p$ = "" THEN GOTO 4
IF VAL(p$) > 5 OR VAL(p$) < 1 THEN BEEP: GOTO 810
IF p$ = "1" THEN
SCREEN 0, , 0, 0
ss$ = "pcz 2 " + baud$ + " d k rz r"
SHELL ss$
PRINT "Press any key...": WHILE INKEY$ = "": WEND
END IF
IF p$ = "2" THEN
SCREEN 0, , 0, 0
ss$ = "pcz 2 " + baud$ + " d k ry"
SHELL ss$
PRINT "Press any key...": WHILE INKEY$ = "": WEND
END IF
IF p$ = "3" THEN
LOCATE CSRLIN + 1, 1: PRINT "This is what you would like to call the file. Default directory is C:\DOWNLOAD.";
LOCATE CSRLIN - 1, 1
INPUT "What is the file name"; f$
SCREEN 0, , 0, 0
ss$ = "pcz 2 " + baud$ + " d k rz " + f$
SHELL ss$
PRINT "Press any key...": WHILE INKEY$ = "": WEND
END IF
IF p$ = "4" THEN
LOCATE CSRLIN + 1, 1: PRINT "This is what you would like to call the file. Default directory is C:\DOWNLOAD.";
LOCATE CSRLIN - 1, 1
INPUT "What is the file name"; f$
SCREEN 0, , 0, 0
ss$ = "pcz 2 " + baud$ + " d k r1 " + f$
SHELL ss$
PRINT "Press any key...": WHILE INKEY$ = "": WEND
END IF
IF p$ = "5" THEN
ss$ = "pcz 2 " + baud$ + " d k rs"
SHELL ss$
PRINT "Press any key...": WHILE INKEY$ = "": WEND
CLS
END IF
CLS
GOTO 220
END IF
IF c$ = "3" THEN
CLOSE
SYSTEM
END IF
IF c$ = "4" THEN CLS : GOTO 220

SUB center (l, text$)
LOCATE l, 40 - INT(LEN(text$) / 2)
PRINT text$;
END SUB

