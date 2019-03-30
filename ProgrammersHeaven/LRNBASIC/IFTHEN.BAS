10 REM MARK A. SWANSON    20:48:25   02-24-85
20 CLS
30 FOR A=1 TO 48 :PRINT "WHAT IF ? ";:NEXT A
40 PRINT "------------------------------------------------------------------------------"
50 PRINT:PRINT:PRINT
60 PRINT "                                 I F   /   T H E N
70 PRINT
80 PRINT "                              THE COMPUTER'S DETECTIVE
90 FOR A=1 TO 2000:NEXT A
100 CLS
110 PRINT "           IF/THEN is actually two STATEMENTS on the same line.  We use
120 PRINT "           IF/THEN when we need to define and act upon certain conditions
130 PRINT "           in a program.  Let's use IF/THEN with INPUT.....
140 PRINT
150 PRINT "               10 INPUT ''HOW OLD ARE YOU '';A
160 PRINT "               20 IF A<16 THEN PRINT ''YOU PROBABLY HAVE A BIKE''
170 PRINT "               30 IF A=>16 THEN PRINT ''YOU'RE OLD ENOUGH TO DRIVE''
180 PRINT
190 PRINT "           Line 10 holds the INPUT question and the VARIABLE 'A'.
200 PRINT
210 X=0
220 PRINT "           Line 20 holds the first IF/THEN STATEMENTs.  IF 'A' is less
230 PRINT "           than 16 (the age we typed in is stored to 'A'), THEN the
240 PRINT "           computer is instructed to PRINT ''YOU PROBABLY HAVE A BIKE''.
250 PRINT
260 PRINT "           Line 30 holds the second IF/THEN STATEMENTs.  IF 'A' is equal
270 PRINT "           to or greater than 16, THEN the computer is instructed to 
280 PRINT "           PRINT ''YOU'RE OLD ENOUGH TO DRIVE''.
290 PRINT:PRINT "   Try this one.....
300 IF X=1 THEN PRINT:PRINT:PRINT:PRINT:PRINT
310 INPUT "                          HOW OLD ARE YOU ";A
320 IF A<16 THEN PRINT TAB(27);"YOU PROBABLY HAVE A BIKE"
330 IF A=>16 THEN PRINT TAB(27);"YOU'RE OLD ENOUGH TO DRIVE"
340 FOR A=1 TO 1000:NEXT A
350 PRINT:PRINT
360 IF X=1 THEN CLS:GOTO 430
370 INPUT "                  PRESS [RETURN] TO CONTINUE  [Q] MAIN BTMENU ";Z$
380 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
390 CLS
400 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
410 X=1:PRINT "Try it again but answer differently to obtain the other response.....":PRINT:GOTO 300
420 CLS
430 PRINT "            The previous example involved numbers.  What about using
440 PRINT "            IF/THEN with STRING data ?  All of the same rules apply
450 PRINT "            here as with other STATEMENTS where STRING data is stored.
460 PRINT "            The VARIABLE must have a '$' at the end, and the data must
470 PRINT "            be enclosed in quotes.  Here's an example.....
480 PRINT
490 PRINT "                 10 INPUT ''WHAT'S YOUR FAVORITE FOOD '';F$
500 PRINT "                 20 IF F$=''STEAK'' THEN PRINT ''YUM YUM !''
510 PRINT "                 30 PRINT ''YUK...YOU PROBABLY LIKE QUICHE !''
520 PRINT:PRINT
530 PRINT "            Note the '$' in lines 10 and 20.  Note the quotations in
540 PRINT "            all of the lines.  If you answer 'STEAK', the computer will
550 PRINT "            respond with 'YUM YUM !'.  If you answer with anything
560 PRINT "            else, the computer passes over line 20 and checks to see
570 PRINT "            what line 30 holds.  In line 30 there is no condition
580 PRINT "            required - only a PRINT statement.  So, the computers does
590 PRINT "            as it is told and PRINTs 'YUK...YOU PROBABLY LIKE QUICHE'.
600 PRINT
610 PRINT:PRINT
620 INPUT "          PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
630 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
640 IF Z$="P" THEN GOTO 100
650 CLS
660 PRINT "            There is one problem - even if you were to answer with
670 PRINT "            'STEAK', the computer would still print line 30 since there
680 PRINT "            is no condition required.  So, we either need a condition
690 PRINT "            in line 30 (30 IF F$<>''STEAK'' THEN PRINT ''YUK...YOU PROBABLY
700 PRINT "            LIKE QUICHE !''), or a diversion in line 20.  How about our
710 PRINT "            'traffic cop' - GOTO ?  If we put a colon at the end of line
720 PRINT "            20, it is legal to put another STATEMENT on the same line.
730 PRINT 
740 PRINT "            Here again is the program with the addition to line 20 and
750 PRINT "            a new line so the computer has somewhere to GOTO.
760 PRINT
770 PRINT "                   10 INPUT ''WHAT'S YOUR FAVORITE FOOD '';F$
780 PRINT "                   20 IF F$=''STEAK'' THEN PRINT ''YUM YUM !'':GOTO 40
790 PRINT "                   30 PRINT ''YUK...YOU PROBABLY LIKE QUICHE''
800 PRINT "                   40 END
810 PRINT
820 PRINT "Now you try it.....
830 FOR A=1 TO 2
840 IF A=2 THEN PRINT "Ok, change your answer.....
850 INPUT "                         WHAT'S YOUR FAVORITE FOOD ";F$
860 IF F$="STEAK" THEN PRINT TAB(26);"YUM YUM !":GOTO 880
870 PRINT "                         YUK...YOU PROBABLY LIKE QUICHE !"
880 NEXT A
890 PRINT
900 INPUT "         PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
910 IF Z$="P" THEN GOTO 420
920 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
930 CLS
940 PRINT "            IF/THEN has a couple tricks we can use to 'short cut' our
950 PRINT "            programming.   These tricks are called OR, AND, and ELSE.
960 PRINT "            They are used on the IF/THEN line.  Here's an example.....
970 PRINT
980 PRINT "                  10 INPUT ''HOW OLD ARE YOU '';A
990 PRINT "                  20 IF A<16 OR A>80 THEN PRINT ''YOU CAN'T DRIVE''
1000 PRINT
1010 PRINT "            An answer of less than 16 or more than 80 will PRINT the
1020 PRINT "            response 'YOU CAN'T DRIVE'.
1030 PRINT
1040 PRINT "                  20 IF A<16 AND A>6 THEN PRINT ''GOT A BIKE ?''
1050 PRINT
1060 PRINT "            An answer between 6 and 16 will PRINT the response 'GOT
1070 PRINT "            A BIKE ?'
1080 PRINT
1090 PRINT "                  20 IF A=>16 THEN PRINT ''YOU DRIVE'' ELSE PRINT ''YOU RIDE''
1100 PRINT
1110 PRINT "            An answer of more than 16 will PRINT 'YOU DRIVE', OTHERWISE
1120 PRINT "            (if less than 16), PRINT ''YOU RIDE''.
1130 PRINT:PRINT:PRINT
1140 INPUT "          PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1150 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1160 IF Z$="P" THEN GOTO 650
1170 CLS
1180 PRINT "            The IF part of the STATEMENTs is always used in reference
1190 PRINT "            to a VARIABLE.  The THEN part, however, can be used with
1200 PRINT "            almost every other STATEMENT and COMMAND in BASIC.
1210 PRINT
1220 PRINT "            Below are some sample IF/THEN STATEMENTs.....
1230 PRINT
1240 PRINT "                    IF T=35 THEN PRINT ''HI THERE''
1250 PRINT "                    IF A$=''CAR'' THEN PRINT G
1260 PRINT "                    IF I=J THEN GOTO 20
1270 PRINT "                    IF D=60 THEN LET X=2
1280 PRINT "                    IF Z$=''PAUSE'' THEN FOR A=1 TO 1000:NEXT A
1290 PRINT "                    IF S<10 THEN INPUT ''NAME '';N$
1300 PRINT "                    IF B=>50 THEN W=5 ELSE W=10
1310 PRINT "                    IF C<>100 OR D=45 THEN PRINT ''HI'' ELSE PRINT ''GOOD BYE''
1320 PRINT "                    IF J$=''Y'' THEN LOAD''B:BTMENU.BAS'',R
1330 PRINT "                    IF F$=''TRUE'' AND Y=3 THEN GOTO 80 
1340 PRINT:PRINT:PRINT:PRINT
1350 INPUT "          PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
1360 IF Z$="P" THEN GOTO 930
1370 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1380 CLS
1390 PRINT "IN SUMMARY..........
1400 PRINT
1410 PRINT "        1.  IF/THEN allows conditions to be set and acted upon
1420 PRINT "          a. IF sets the conditions
1430 PRINT "          b. THEN acts upon the condition with any BASIC STATEMENT or COMMAND
1440 PRINT
1450 PRINT "        2.  Other IF/THEN 'helpers' are:
1460 PRINT "          a. OR
1470 PRINT "          b. AND
1480 PRINT "          c. ELSE
1490 PRINT 
1500 PRINT "------------------------------------------------------------------------------"
1510 PRINT "FOR PRACTICE..........
1520 PRINT
1530 PRINT "        1.  Try all variations of IF/THEN
1540 PRINT
1550 PRINT "        2.  Create a program and continue to build on that program using
1560 PRINT "            more INPUT and IF/THEN STATEMENTs.
1570 PRINT:PRINT:PRINT
1580 INPUT "           PRESS [Z] TO PRACTICE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
1590 IF Z$="P" THEN GOTO 1170
1600 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1610 CLS
1620 PRINT "                   To practice, type NEW and press [RETURN]
1630 PRINT "               To get back to lessons, type LOAD''B:BTMENU.BAS'',R
1640 PRINT
1650 PRINT "         Remember to use quotations instead of double apostrophies ('')
1660 PRINT "------------------------------------------------------------------------------"
tead of double apostrophies ('')
1660 PRINT "-