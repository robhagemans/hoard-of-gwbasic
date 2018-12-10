10 REM MARK A. SWANSON    20:43:15   02-24-85
20 CLS
30 FOR A=1 TO 312:PRINT " ? ";:NEXT A
40 PRINT "------------------------------------------------------------------------------"
50 PRINT:PRINT
60 PRINT "                                    I N P U T
70 PRINT
80 PRINT "                       THE QUESTION TO ALL OF YOUR ANSWERS
90 FOR A=1 TO 2000:NEXT A
100 CLS
110 PRINT "            If you've ever wondered how a computer can not only ask
120 PRINT "            us a question, but respond as well, wonder no more !
130 PRINT
140 PRINT "            INPUT is a STATEMENT that allows a request for data to be
150 PRINT "            'put in' to the computer's memory.  With this powerfull
160 PRINT "            STATEMENT we can communicate (and to stretch the truth a
170 PRINT "            bit, converse) with the computer.  Below is an example....
180 PRINT
190 PRINT "                              Go ahead and answer.....
200 PRINT
210 INPUT "                          WHAT IS YOUR NAME, FRIEND ";N$
220 PRINT "                          HI, ";N$
230 PRINT:PRINT:PRINT
240 FOR A=1 TO 1000:NEXT A
250 PRINT "            As you can see ";N$;", I now know your name and can use
260 PRINT "            it throughout this lesson if I want to !  Let's see how 
270 PRINT "            this STATEMENT looks.
280 PRINT:PRINT:PRINT
290 INPUT "                PRESS [RETURN] TO CONTINUE     [Q] MAIN BTMENU ";Z$
291 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
300 CLS
310 PRINT "                      10 INPUT ''WHAT IS YOUR NAME, FRIEND '';N$
320 PRINT "                      20 PRINT ''HI, '';N$"
330 PRINT
340 PRINT "            This may look complicated, but it isn't.  Let's disect it.
350 PRINT 
360 PRINT "            Line 10 holds the INPUT STATEMENT.  Notice that the question
370 PRINT "            is typed in just as we would like it, except we leave out
380 PRINT "            question mark (?).  The computer will automatically place
390 PRINT "            the '?' at the end (where the semi-colon is).  Quotations
400 PRINT "            are necessary as with the PRINT STATEMENT.  At the end of
410 PRINT "            the line a VARIABLE is used to store the answer.  Our answer
420 PRINT "            is a STRING (a word or letter) so the '$' is added.
430 PRINT
440 PRINT "            Line 20 PRINTs the response.  Note that the semi-colon
450 PRINT "            separates the STRING from the VARIABLE (N$).  Remember,
460 PRINT "            a semi-colon tells the computer to PRINT the following
470 PRINT "            data right after the preceding data (on the same line if
480 PRINT "            there is enough room on the screen).  In short, the computer
490 PRINT "            is instructed to PRINT two things - the STRING (HI, ) and
500 PRINT "            the data stored to the VARIABLE N$ (";N$;")."
510 PRINT:PRINT
520 INPUT "         PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
530 IF Z$="P" THEN GOTO 100
540 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
550 CLS
560 PRINT "           Now we'll use INPUT with numbers (no STRINGs attached !).
570 PRINT
580 PRINT "                        10 INPUT ''HOW OLD ARE YOU '';A
590 PRINT "                        20 PRINT ''YOU ARE '';A;'' YEARS OLD''
600 PRINT
610 PRINT "          Line 10 is typed in just like the previous program with one
620 PRINT "          exception - the '$' sign is left off the VARIABLE 'A'.
630 PRINT
640 PRINT "          Line 20 is set up just like line 20 in the previous program
650 PRINT "          with the additional STRING at the end (''YEARS OLD'').  Again
660 PRINT "          we used semi-colons to separate the data to be PRINTed.
670 PRINT 
680 PRINT "          Ok, go ahead and answer again.....
690 PRINT
700 INPUT "                             HOW OLD ARE YOU ";A
710 PRINT "                             YOU ARE ";A;" YEARS OLD"
720 PRINT:PRINT
730 FOR A=1 TO 1000:NEXT A
740 PRINT "          If you were to type a STRING (letter or word) instead of a
750 PRINT "          number (as is required by the VARIABLE 'A') the message
760 PRINT "          '?redo from start' would appear and allow you to re-enter a number.
770 PRINT:PRINT
780 INPUT "        PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
790 IF Z$="P" THEN GOTO 300
800 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
810 CLS
820 PRINT "           Here's an example of some fancy programming.....
830 PRINT
840 PRINT "                 10 INPUT ''WHAT IS YOUR NAME '';NM$
850 PRINT "                 20 PRINT ''HI, '';NM$
860 PRINT "                 30 PRINT ''TYPE 3 NUMBERS AND I'LL PRINT THE AVERAGE''
870 PRINT "                 40 INPUT ''1ST NUMBER '';A
880 PRINT "                 50 INPUT ''2ND NUMBER '';B
890 PRINT "                 60 INPUT ''3RD NUMBER '';C
900 PRINT "                 70 PRINT (A+B+C)/3
910 PRINT
920 PRINT "          Take a good look at this program, line for line, so you will
930 PRINT "          understand what each STATEMENT will do.   Ok, now answer
940 PRINT "          the questions.....
950 PRINT
960 INPUT "                    WHAT IS YOUR NAME ";NM$
970 PRINT "                    HI ";NM$
980 PRINT "                    TYPE 3 NUMBERS AND I'LL PRINT THE AVERAGE 
990 INPUT "                    1ST NUMBER ";A
1000 INPUT "                    2ND NUMBER ";B
1010 INPUT "                    3RD NUMBER ";C
1020 PRINT "                   ";(A+B+C)/3
1030 PRINT
1040 PRINT "          What would you add to line 70 to have the computer PRINT
1050 PRINT "          'THE AVERAGE IS;(A+B+C)/3' ?  {PRINT ''THE AVERAGE IS'';(A+B+C)/3}
1060 PRINT
1070 INPUT "          PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
1080 IF Z$="P" THEN GOTO 550
1090 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1100 CLS
1110 PRINT "IN SUMMARY.......
1120 PRINT
1130 PRINT "            1.  INPUT instructs the computer to accept and store data
1140 PRINT "                in response to user defined questions and inquiries
1150 PRINT
1160 PRINT "            2.  The format is:  STATEMENT ''ARGUMENT'';VARIABLE
1170 PRINT "                       example>  INPUT ''NAME PLEASE'';N$
1180 PRINT
1190 PRINT "------------------------------------------------------------------------------"
1200 PRINT "FOR PRACTICE.......
1210 PRINT
1220 PRINT "            1.  Create programs like the examples using.....
1230 PRINT "              a.  STRING data as responses
1240 PRINT "              b.  NUMBER data as responses
1250 PRINT
1260 PRINT "            2.  Create a program using INPUT with FOR/NEXT and GOTO
1270 PRINT:PRINT:PRINT:PRINT:PRINT
1280 INPUT "           PRESS [Z] TO PRACTICE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ";Z$
1290 IF Z$="P" THEN GOTO 810
1300 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1310 CLS
1320 PRINT "                             To practice, type NEW
1330 PRINT "               To get back to lessons, type LOAD''B:BTMENU.BAS'',R
1340 PRINT
1350 PRINT "        Remember to use quotations instead of double appostrophies ('')
1360 PRINT "------------------------------------------------------------------------------"
