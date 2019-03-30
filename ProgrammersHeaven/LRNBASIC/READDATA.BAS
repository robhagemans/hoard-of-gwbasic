10 REM  MARK A. SWANSON   20:53:20   02-24-85
20 CLS
30 FOR A=1 TO 36
40 PRINT "  READ/DATA\/\/READ\DATA  ";
50 NEXT A
60 PRINT "-------------------------------------------------------------------------------"
70 PRINT:PRINT
80 PRINT "                                   READ / DATA
90 PRINT
100 PRINT "                            THE COMPUTER'S LIBRARIAN
110 FOR A=1 TO 2000:NEXT A
120 CLS
130 PRINT "           READ/DATA is a STATEMENT that acts like a librarian.  We use
140 PRINT "           it to store alot of DATA on one or more lines in the program
150 PRINT "           and then READ that DATA individually or in groups.  So actually
160 PRINT "           we have two STATEMENTs - each on their own line or lines.
170 PRINT
180 PRINT "           Here is what READ/DATA might look like in a program.....
190 PRINT
200 PRINT "                                10 READ A
210 PRINT "                                20 PRINT A
220 PRINT "                                30 DATA 12
230 PRINT
240 PRINT "           The output would be >  12
250 PRINT
260 PRINT "           Line 10 instructs the computer to READ and store the contents
270 PRINT "           of the DATA in line 30 to the VARIABLE 'A'.  Line 20 holds
280 PRINT "           the STATEMENT that PRINTs the DATA that was stored to the
290 PRINT "           VARIABLE 'A'.
300 PRINT:PRINT:PRINT:PRINT
310 INPUT "                PRESS [RETURN] TO CONTINUE  OR  [Q] MAIN BTMENU ";Z$
320 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
330 CLS
340 PRINT "           Obviously, it would have been easier to use LET to store the
350 PRINT "           number 12 (LET A=12).  READ/DATA, therefore, is used more
360 PRINT "           frequently with larger amounts of data that is to be stored
370 PRINT "           to a single or multiple VARIABLEs.  Let's see how READ/DATA
380 PRINT "           would work for a large group of DATA with a single VARIABLE.....
390 PRINT
400 PRINT "                   10 FOR A=1 TO 10
410 PRINT "                   20 READ T$
420 PRINT "                   30 PRINT T$,
430 PRINT "                   40 NEXT A
440 PRINT "                   50 DATA JOHN,POLLY,GEORGE,RAY,BILL,SUE,VAL,JIM,LEO,GREG
450 PRINT
460 INPUT "           Ok, type 'RUN' and press [RETURN] to make it work.... ",Z$
470 PRINT
480 IF Z$<>"RUN" THEN PRINT "TRY AGAIN.....":GOTO 460
490 RESTORE
500 FOR A=1 TO 10
510 READ T$
520 PRINT T$,
530 NEXT A
540 DATA JOHN,POLLY,GEORGE,RAY,BILL,SUE,VAL,JIM,LEO,GREG
550 FOR A=1 TO 500:NEXT A
560 PRINT
570 PRINT "           Since we have only one VARIABLE and 10 'pieces' of DATA,
580 PRINT "           we need to enclose READ T$ and PRINT T$ in a FOR/NEXT loop.
590 PRINT "           We had 10 pieces of DATA so we needed a FOR/NEXT count to 10.
600 PRINT:PRINT
610 INPUT "        PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
620 IF Z$="P" THEN GOTO 120
630 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
640 CLS
650 PRINT "        Before we look at the other variations of READ/DATA, let's
660 PRINT "        establish some rules by which to follow when using READ/DATA
670 PRINT "        in a program.....
680 PRINT:PRINT
690 PRINT "        1.  READ must be located before any other use of the corresponding
700 PRINT "            VARIABLE is initiated.
710 PRINT
720 PRINT "        2.  DATA may be located anywhere in the program.
730 PRINT
740 PRINT "        3.  The number of DATA pieces READ is determined by the number of   
750 PRINT "            VARIABLEs following the READ STATEMENT (this will be covered
760 PRINT "            shortly).
770 PRINT
780 PRINT "        4.  If the DATA is to be READ more than once, RESTORE must be
790 PRINT "            used to reset the VARIABLE back to 0 before each pass.
800 PRINT:PRINT:PRINT:PRINT:PRINT
810 INPUT "         PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
820 IF Z$="P" THEN GOTO 330
830 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
840 CLS
850 PRINT "         Here are the common ways READ/DATA may be used (with output).
860 PRINT
870 PRINT "                           10 READ A,B,C
880 PRINT "                           20 PRINT A,B,C
890 PRINT "                           30 DATA 24,16,89
900 PRINT "               output----> 24          16          89
910 PRINT
920 PRINT "                           10 FOR A=1 TO 3
930 PRINT "                           20 READ A$,B$
940 PRINT "                           30 PRINT A$,B$
950 PRINT "                           40 NEXT A
960 PRINT "                           50 DATA CAR,ROAD,BIRD,AIR,TRAIN,TRACK
970 PRINT "               output----> CAR         ROAD
980 PRINT "                           BIRD        AIR
990 PRINT "                           TRAIN       TRACK
1000 PRINT
1010 PRINT "                           10 READ A$,B
1020 PRINT "                           20 PRINT A$;'' ON '';B;'' DOLLARS IS "
1030 PRINT "                           30 PRINT (B+25)*.10
1040 PRINT "                           40 DATA INCOME TAX,100
1050 PRINT "               output----> INCOME TAX ON 100 DOLLARS IS
1060 PRINT "                           12.50
1070 PRINT
1080 INPUT "         PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
1090 IF Z$="P" THEN GOTO 640
1100 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1110 CLS
1120 PRINT "        If you didn't take a good look at the previous examples, go
1130 PRINT "        back now and analyze the programs so you can predict what each
1140 PRINT "        program will do.
1150 PRINT
1160 PRINT "        Below is an example using RESTORE with READ/DATA.  RESTORE is
1170 PRINT "        used to clear the READ storage of DATA so that the DATA can be
1180 PRINT "        stored and used again.  If another pass is attempted to READ
1190 PRINT "        the DATA more than once (without RESTORE), you will get the 'OUT
1200 PRINT "        OF DATA' message.  This, by the way, will also happen if you have
1210 PRINT "        more READ variables than DATA pieces.  The computer simply runs
1220 PRINT "        out of data.
1230 PRINT
1240 PRINT "                            10 RESTORE
1250 PRINT "                            20 READ A
1260 PRINT "                            30 PRINT A;
1270 PRINT "                            40 GOTO 10
1280 PRINT "                            50 DATA 1,2,3,4,5
1290 PRINT "                output----> 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 .....
1300 PRINT
1310 PRINT "        The RESTORE allows the DATA to be PRINTed over and over via GOTO 10
1320 PRINT "        in line 40.
1330 PRINT:PRINT
1340 INPUT "         PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
1350 IF Z$="P" THEN GOTO 840
1360 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1370 CLS
1380 PRINT "IN SUMMARY................
1390 PRINT
1400 PRINT "       1.  READ/DATA allows large amounts of DATA to be stored and utilized.":PRINT
1410 PRINT "       2.  READ must be located on a line before the the associated PRINT
1420 PRINT "           statement or other statements which use the DATA are encountered.":PRINT
1430 PRINT "       3.  RESTORE must be used if the DATA is to be READ more than once.
1440 PRINT
1450 PRINT "------------------------------------------------------------------------------"
1460 PRINT "FOR PRACTICE.............
1470 PRINT
1480 PRINT "       1.  Try the sample programs in the workbook.":PRINT 
1490 PRINT "       2.  Once you have RUN a READ/DATA program a couple of times,
1500 PRINT "           change the DATA or add more and adjust the READ statement
1510 PRINT "           to accomodate the changes.":PRINT
1520 PRINT "       3.  Create a program using as many statements previously learned.":PRINT
1530 PRINT:PRINT
1540 INPUT "         PRESS [Z] TO PRACTICE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
1550 IF Z$="P" THEN GOTO 1110
1560 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1570 CLS
1580 PRINT "      To get back to lessons, type LOAD''B:BTMENU.BAS'',R AND PRESS [RETURN]
1590 PRINT "                                       ^             ^"
1600 PRINT "           Remember to use quotations instead of double apostrophies
1610 PRINT
1620 PRINT "                 To begin practice, type NEW and press [RETURN]
1630 PRINT "------------------------------------------------------------------------------"
