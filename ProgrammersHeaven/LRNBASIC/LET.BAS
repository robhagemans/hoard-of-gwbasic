10 REM MARK A. SWANSON     20:41:32  02-24-85
20 CLS
30 FOR A=1 TO 50:PRINT "       L E T   ";:NEXT A
40 PRINT
50 PRINT "------------------------------------------------------------------------------"
60 PRINT:PRINT:PRINT:PRINT
70 PRINT "                                       LET
80 PRINT:PRINT
90 PRINT "                             A STATEMENT FOR STORAGE
100 FOR A=1 TO 2000:NEXT A
110 CLS
120 PRINT "            LET is a versitile STATEMENT used for storing STRINGS and
130 PRINT "            numeric values.  Without LET, the computer assumes that
140 PRINT "            only LINE NUMBERS and their data are to be stored.  LET
150 PRINT "            can be used with almost every other STATEMENT, but we will
160 PRINT "            only use it with PRINT and GOTO in this lesson and then
170 PRINT "            apply it with new STATEMENTs in later lessons.
180 PRINT
190 PRINT "            The best way to understand LET is to use it in a simple
200 PRINT "            program.....
210 PRINT 
220 PRINT "                                    10 LET A=106
230 PRINT "                                    20 PRINT A
240 PRINT
250 PRINT "            The output would be.....
260 PRINT 
270 PRINT "                                    106
280 PRINT 
290 PRINT "            The computer was instructed to store the number '106' as
300 PRINT "            'A'.  Then, as instructed in line 20, the computer PRINTed
310 PRINT "            the VALUE of 'A' - which is '106'.
320 PRINT:PRINT
330 INPUT "                   PRESS [RETURN] TO CONTINUE  or  [Q] MAIN BTMENU ",Z$
340 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
350 CLS
360 PRINT "            We can use LET to do math problems, as is illustrated in
370 PRINT "            the following example.....
380 PRINT
390 PRINT "                                      10 LET A=24*17
400 PRINT "                                      20 PRINT A
410 PRINT
420 PRINT "            The output would be.....
430 PRINT
440 PRINT "                                      408
450 PRINT
460 PRINT "            The computer was instructed to store the VALUE of '24 X 17'.
470 PRINT "            Then, as instructed in line 20, the VALUE was PRINTed - 408.
480 PRINT
490 PRINT "            The letter used for storing VALUES is called the VARIABLE.
500 PRINT "            We used the VARIABLE 'A', however any letter or combination
510 PRINT "            of letters is acceptable.
520 PRINT:PRINT:PRINT:PRINT
530 INPUT "           PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
540 IF Z$="P" THEN GOTO 110
550 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
560 CLS
570 PRINT "           Now, we'll use LET with STRINGs (letters, words, anything
580 PRINT "           that is to be PRINTed or stored verbatim).  A minor addition
590 PRINT "           to the format is necessary.  Whenever a STRING is to be stored,
600 PRINT "           a dollar sign ($) has to be added to the VARIABLE.  This makes
610 PRINT "           it a STRING VARIABLE.  Another example.....
620 PRINT
630 PRINT "                                  10 LET G$=''BASIC IS FUN''
640 PRINT "                                  20 PRINT G$
650 PRINT
660 PRINT "           The output would be.....
670 PRINT 
680 PRINT "                                  BASIC IS FUN
690 PRINT
700 PRINT "           Notice that the data was enclosed in quotations.  Remember,
710 PRINT "           whenever we store a STRING, the data must be enclosed in
720 PRINT "           quotations.
730 PRINT:PRINT:PRINT:PRINT
740 INPUT "          PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
750 IF Z$="P" THEN GOTO 350
760 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
770 CLS
780 PRINT "           If you can remember back to the GOTO lesson, we used the
790 PRINT "           semi-colon (;) to PRINT data horizontally instead of 
800 PRINT "           vertically.  The following are examples of how to use the
810 PRINT "           semi-colon with LET and PRINT.....
820 PRINT
830 PRINT "                               10 LET T=18
840 PRINT "                               20 LET R=15
850 PRINT "                               30 PRINT ''THE ANSWER IS '';T+R
860 PRINT "                   output..... THE ANSWER IS 33
870 PRINT:PRINT
880 PRINT "                               10 LET W$=''WORDS''
890 PRINT "                               20 LET M$=''MY''
900 PRINT "                               30 LET T$=''TOGETHER''
910 PRINT "                               40 LET R$=''RUN''
920 PRINT "                               50 PRINT M$;W$;R$;T$
930 PRINT "                   output..... MYWORDSRUNTOGETHER
940 PRINT 
950 PRINT "           You can create your own variations of these when you practice.
960 PRINT:PRINT:PRINT
970 INPUT "           PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
980 IF Z$="P" THEN GOTO 560
990 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1000 CLS
1010 PRINT "IN SUMMARY.....
1020 PRINT
1030 PRINT "      1.  LET instructs the computer to store numeric values and STRINGs
1040 PRINT "          to a VARIABLE.
1050 PRINT "      2.  A dollar sign ($) must be added to the VARIABLE when storing
1060 PRINT "          STRINGs and the data must be enclosed in quotations.
1070 PRINT
1080 PRINT "------------------------------------------------------------------------------"
1090 PRINT "FOR PRACTICE.....
1100 PRINT
1110 PRINT "      1.  Try variations of the previous examples.
1120 PRINT "      2.  Combine STRINGs and numeric values in one program.
1130 PRINT "      3.  Try a program using a comma (,) instead of a semi-colon (;).
1140 PRINT
1150 PRINT "------------------------------------------------------------------------------"
1160 PRINT:PRINT:PRINT:PRINT:PRINT
1170 INPUT "             PRESS [Z] TO PRACTICE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU " ,Z$
1180 IF Z$="P" THEN GOTO 770 
1190 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1200 CLS
1210 PRINT "               To begin practicing, type NEW, followed by [RETURN]
1220 PRINT
1230 PRINT "Try this program.....
1240 PRINT "                           10 LET A=A+1
1250 PRINT "                           20 PRINT A
1260 PRINT "                           30 GOTO 10
1270 PRINT
1280 PRINT "           To stop this program, press [CTRL]-[C] (at same time)
1290 PRINT
1300 PRINT " Remember, when using STRINGs, use quotations instead of double apostrophies.
1310 PRINT "-------------------------------------------------------------------------------"
