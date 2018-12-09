1000 '  Program to create form letters and mailing lables
1010 CLS
1020 PRINT "----------------------------------------------"
1030 PRINT "    "
1040 PRINT "    MAIL - program to create form letters and mailing labels "
1050 PRINT "    "
1060 PRINT "    This program reads from a list of names, addresses and filenames"
1070 PRINT "    to produce form letters.  Alternately the program will read the"
1080 PRINT "    same input file to produce mailing labels to go with the letters."
1090 PRINT "    A sample input file, MAIL.TXT is included with the initial "
1100 PRINT "    release of this program."
1110 PRINT "    "
1120 PRINT "    If you find this program or other texttools from RPSoft"
1130 PRINT "    useful, a suggested donation of $25 to RPSoft, 1271 Palamos,"
1140 PRINT "    Sunnyvale, CA 94086 would be appreciated.  Permission is"
1150 PRINT "    granted to copy this program as long as this header is"
1160 PRINT "    not removed."
1170 PRINT "    "
1180 PRINT "    Copyright 1983 by RPSoft"
1190 PRINT "    "
1200 PRINT "----------------------------------------------"
1210 PRINT "     "
1220 INPUT "enter input filename - ";FIN$
1230 INPUT "select letter or mailing label mode (l or m) - ";MD$
1240 INPUT "enter column for margin - ";MAR:IF MAR=0 THEN MAR=1
1250 OPEN "I",#1,FIN$
1260 OPEN "O",#3,"lpt1:"
1270 '
1280 '   read input file
1290 '
1300 IF EOF(1) THEN STOP
1310 LL$=L$
1320 LINE INPUT #1,L$:GOSUB 1580
1330 IF MID$(L$,1,1)="." THEN 1380 ' command line found
1340 PRINT#3,TAB(MAR);L$:NL=NL+1:GOTO 1300
1350 '
1360 '   parce commands and process if necessary
1370 '
1380 IF MD$="m" THEN GOTO 1530 ' mailing label option selected
1390 IF MID$(L$,1,4)<>".use" THEN 1300
1400 FMRG$=MID$(L$,6,LEN(L$)-5)
1410 IF LEN(FMRG$)=0 THEN PRINT "error in specifing .use file":GOTO 1300
1420 IF MID$(FMRG$,1,1)=" " THEN FMRG$=MID$(FMRG$,2,LEN(FMRG$)-1):GOTO 1420
1430 CLOSE#2
1440 OPEN "I",#2,FMRG$
1450 IF EOF(2) THEN 1300
1460 LINE INPUT #2,L$:GOSUB 1580
1470 IF MID$(L$,1,3)=".bp" THEN PRINT #3,CHR$(12):GOTO 1450
1480 PRINT#3,TAB(MAR);L$
1490 GOTO 1450
1500 '
1510 '  put spaces between mailing addresses
1520 '
1530 IF MID$(LL$,1,1)=MID$(L$,1,1) THEN 1300 ' skip duplicate commands
1540 FOR J=NL+1 TO 6
1550 PRINT#3," ":NEXT J:NL=0:GOTO 1300
1560 '
1570 '   remove tabs
1580 P0=INSTR(1,L$,CHR$(9)) : IF P0=0 THEN RETURN
1590 NIN=9-(P0 MOD 8):L$=MID$(L$,1,P0-1)+STRING$(NIN," ")+MID$(L$,P0+1,LEN(L$))
1600 GOTO 1580 '  any more tabs ?
EN RETURN
1590 NIN=9-(P0 MOD 8):L$=MID$(L$,1