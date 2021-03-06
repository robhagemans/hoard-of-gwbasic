10 CLS
30 FOR A=1 TO 260:PRINT "GOTO";:NEXT A
40 PRINT:PRINT:PRINT:PRINT
50 PRINT "                                      G O T O"
60 PRINT "                                      -------
70 PRINT
80 PRINT "                                 THE INFINITE LOOP
90 PRINT "                                        AND
100 PRINT "                                 BASIC TRAFFIC COP
110 FOR A=1 TO 2000:NEXT A
120 CLS
130 PRINT "            As the title graphics show us, GOTO can be alot of fun to
140 PRINT "            use.  As the title suggests, GOTO is an important tool in
150 PRINT "            controlling the direction of a program.  We'll show how this
160 PRINT "            is accomplished and give some pointers on using GOTO to its
170 PRINT "            fullest.
180 PRINT:PRINT
190 PRINT "            GOTO is a STATEMENT just like PRINT.  GOTO requires an
200 PRINT "            argument like PRINT only the argument is a LINE NUMBER,
210 PRINT "            not a STRING (name, letter, etc.) or a mathematical
220 PRINT "            operation (1+1, 4*3.2, etc.).
230 PRINT
240 PRINT "            GOTO acts like a program 'traffic cop' because it directs
250 PRINT "            the program flow and is used to jump from one line number
260 PRINT "            to another.
270 PRINT "
280 PRINT "            GOTO can best be illustrated by using it in a program 
290 PRINT "            with PRINT.
300 PRINT:PRINT:PRINT:PRINT
310 INPUT "                PRESS [RETURN] TO CONTINUE  or  [Q] MAIN BTMENU ",Z$
320 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
330 CLS
340 PRINT "         Here's an example of GOTO illustrating its 'jumping around'
350 PRINT "         ability.....
360 PRINT "
370 PRINT "                         10 PRINT ''GOTO''
380 PRINT "                         20 GOTO 50
390 PRINT "                         30 PRINT ''JUMP''
400 PRINT "                         40 GOTO 70
410 PRINT "                         50 PRINT ''CAN''
420 PRINT "                         60 GOTO 30
430 PRINT "                         70 PRINT ''AROUND''
440 PRINT
450 PRINT "         The output would be.....
460 PRINT
470 PRINT "                         GOTO
480 PRINT "                         CAN
490 PRINT "                         JUMP
500 PRINT "                         AROUND
510 PRINT
520 PRINT "        The program flow goes like this:   
530 PRINT "        10 to 20 to 50 to 60 to 30 to 40 to 70.  The computer tries to
540 PRINT "        move in a sequential order but GOTO interupts and reroutes it.
550 PRINT:PRINT
560 INPUT "       PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
570 IF Z$="P" THEN GOTO 120
580 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
590 CLS
600 PRINT "         GOTO can also be used to repeat a line number and its contents
610 PRINT "         as in a program that can repeat your name - over and over 
620 PRINT "         again.  This is using GOTO as an INFINITE LOOP.  For example....
625 PRINT
630 PRINT "                            10 PRINT ''POLLY PROGRAMMER''
640 PRINT "                            20 GOTO 10
650 PRINT
660 PRINT "         In this program, the computer is instructed to PRINT exactly
670 PRINT "         what is enclosed in the quotations (Polly Programmer).  When
680 PRINT "         the computer executes line 10 and moves to on to line 20, it
690 PRINT "         is instructed to GOTO line 10 and hence PRINT the name again.
700 PRINT "         The computer again moves on to line 20 and again is directed
710 PRINT "         to line 10 - again and again.
720 PRINT "  
730 PRINT "         We'll illustrate this for you (in a shortened version) so you
740 PRINT "         can get the real feel for this STATEMENT.  By the way, to stop
750 PRINT "         an infinite loop in progress, you press [ctrl]--C (control c)
760 PRINT "         which breaks or stops the program execution.
770 PRINT "
780 PRINT "         Let's imagine the we typed RUN, and you need to press [RETURN]
790 PRINT "         to start the program.....
800 PRINT:PRINT
810 INPUT "      PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
820 IF Z$="P" THEN GOTO 590
830 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
840 CLS
850 PRINT "HERE WE GO...................................................
860 PRINT:PRINT:PRINT
870 FOR A=1 TO 1000:NEXT A
880 FOR A=1 TO 100:PRINT "POLLY PROGRAMMER":NEXT A
890 PRINT:PRINT:PRINT
900 FOR A=1 TO 500:NEXT A
910 PRINT "           Hi again.  Just for the fun of it, let's add a punctuation
920 PRINT "           to the end of line 10.  A semi-colon (;) tells the computer
930 PRINT "           to print what ever is next on the same line as the previous
940 PRINT "           ARGUMENT.  In this case, 'Polly Programmer' will be PRINTed
950 PRINT "           over and over on the same line until the line is full in
960 PRINT "           which case the next line fills up.  The openning graphics
970 PRINT "           used a semi-colon to make this interesting effect.
980 PRINT
990 PRINT "           Let's again assume we typed RUN and you need to press the
1000 PRINT "           [RETURN] key to execute the program.
1010 PRINT 
1020 PRINT "                                10 PRINT ''POLLY PROGRAMMER'';"
1030 PRINT "                                20 GOTO 10
1040 PRINT:PRINT
1050 INPUT "         PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1060 IF Z$="P" THEN GOTO 840
1070 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1080 CLS
1090 PRINT "HERE WE GO AGAIN..............................................
1100 PRINT:PRINT:PRINT
1110 FOR A=1 TO 1000:NEXT A
1120 FOR A=1 TO 40:PRINT "POLLY PROGRAMMER";:NEXT A
1130 PRINT:PRINT:PRINT
1140 FOR A=1 TO 500:NEXT A
1150 PRINT "           Again we limited the number of times 'POLLY PROGRAMMER' was
1160 PRINT "           PRINTed (using a different statement to be discussed later).
1170 PRINT "           For example purposes though, you can see how GOTO works.
1180 PRINT "           GOTO works with other STATEMENTS as well which will be
1190 PRINT "           be covered in later lessons.
1200 PRINT
1210 PRINT "______________________________________________________________________________"
1220 PRINT "IN SUMMARY.....
1230 PRINT
1240 PRINT "            1.  GOTO directs the program flow by:
1250 PRINT "              a.  jumping from one line number to another
1260 PRINT "              b.  creating an infinite loop, stopped by [CTRL]-[C]
1270 PRINT
1280 PRINT "_____________________________________________________________________________"
1290 PRINT "FOR PRACTICE.....
1300 PRINT
1310 PRINT "            1.  Try variations of the two sample programs just used
1320 PRINT:PRINT
1330 INPUT "            PRESS [Z] TO PRACTICE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1340 IF Z$="P" THEN GOTO 1080
1350 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1360 CLS
1370 PRINT "             Type NEW followed by [RETURN] to begin practicing.
1380 PRINT
1390 PRINT "             To get back to lessons type LOAD''B:BTMENU.BAS'',R
1400 PRINT
1410 PRINT "          As always, use quotations instead of double apostrophies
1420 PRINT
1430 PRINT "-----------------------------------------------------------------------------"
           