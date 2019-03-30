10 ' MARK A. SWANSON     02-27-1985  20:22:35 
20 CLS
30 PRINT:PRINT:PRINT
50 PRINT TAB(40);10;"F"
60 FOR A=9 TO 1 STEP -1
70 READ A$
80 PRINT TAB(40);A;" ";A$
90 FOR I=1 TO 100:NEXT I
100 NEXT A
110 DATA O,R, ,/, ,N,E,X,T
120 PRINT
130 PRINT "------------------------------------------------------------------------------"
140 PRINT:PRINT:PRINT
150 PRINT "                                      FOR / NEXT
160 PRINT
170 PRINT "                           THE STATEMENT YOU CAN 'COUNT' ON
180 FOR A=1 TO 2000:NEXT A
190 CLS
200 PRINT "             FOR/NEXT is a nifty STATEMENT that has three uses.....
210 PRINT
220 PRINT "                          1.  To delay program flow or pause
230 PRINT "                          2.  To count numbers, forward or backwards
240 PRINT "                          3.  To PRINT mulitple STRING data
250 PRINT
260 PRINT "             We'll look at all of these individually and show how FOR/NEXT
270 PRINT "             can be used to 'dress up' a program and save programming
280 PRINT "             time.
290 PRINT
300 PRINT "             But first, how it works.....  FOR/NEXT is actually two
310 PRINT "             statements (on their own lines).  We use FOR/NEXT
320 PRINT "             to create a controlled loop.  A controlled loop consists
330 PRINT "             of a starting point and specified goal (the FOR part of
340 PRINT "             the statement), and the signal to continue and ultimately
350 PRINT "             end the loop (the NEXT part of the statement).  And,
360 PRINT "             depending on the particular use, there can be another
370 PRINT "             statement in between FOR and NEXT that is executed as
380 PRINT "             many times as is indicated in the FOR part. 
390 PRINT
400 PRINT "             Before total confusion sets in, let's have a look at how
410 PRINT "             FOR/NEXT is set up for each of the three uses listed above.
420 PRINT
430 INPUT "                   PRESS [RETURN] TO CONTINUE  [Q] MAIN BTMENU ",Z$
440 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
450 CLS
460 PRINT "                              FOR/NEXT AS A DELAY
470 PRINT
480 PRINT "          What is meant by DELAY is a pause or interuption in the
490 PRINT "          program where evrything comes to a complete halt.  This is
500 PRINT "          the purest form of FOR/NEXT where the computer is instructed
510 PRINT "          to cease operation while it counts to itself to a specified
520 PRINT "          number.  Here's an example.....
530 PRINT
540 PRINT "                              10 FOR A=1 TO 2000
550 PRINT "                              20 NEXT A
560 PRINT
570 PRINT "          In line 10, the computer sets the scene to count from 1 to
580 PRINT "          2000.  Notice that we have a modified use of LET, where 'A'
590 PRINT "          is being used to store the numbers 1 through 2000.
600 PRINT
610 PRINT "          In line 20, the computer is instructed to get the NEXT 'A'
620 PRINT "          to be found back in line 10.  Thus, the loop begins.
630 PRINT
640 PRINT "          When the computer has registered all of the numbers (counted
650 PRINT "          to 2000), there is no 'NEXT A', as they have all been used up.
660 PRINT "          So, the computer moves on to the next line in the program or
670 PRINT "          ends if no more lines exist.
680 PRINT
690 INPUT "           PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
700 IF Z$="P" THEN GOTO 190
710 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
720 CLS
730 PRINT "             Delays are useful in a variety of situations.  In the 
740 PRINT "             openning of this lesson you saw a countdown along with
750 PRINT "             the letters of FOR/NEXT.  FOR/NEXT was used to 'slow down'
760 PRINT "             the countdown by instructing the computer to count to one
770 PRINT "             hundred between each number and letter.
780 PRINT
790 PRINT "             We'll run an example of the delaying ability of FOR/NEXT.
800 PRINT 
810 PRINT "                                    10 FOR T=1 TO 2000
820 PRINT "                                    20 NEXT T
830 PRINT
840 PRINT "             Type RUN and press [RETURN] to start the program.  Note
850 PRINT "             how long it takes to finish counting and hence, allow the
860 PRINT "             the rest of this page to be printed.  OK - Type RUN and
870 PRINT "             press [RETURN]";:INPUT " ",X$
880 IF X$="RUN" THEN FOR A=1 TO 2000:NEXT A
890 IF X$<>"RUN" THEN PRINT "TRY AGAIN - TYPE RUN AND PRESS [RETURN]":INPUT X$:GOTO 880
900 PRINT 
910 PRINT "            You made it !  As you can see, the computer counts to
920 PRINT "            itself at a very fast clip.  An 'internal' count like this
930 PRINT "            one to 2000 takes about 5 seconds.
940 PRINT:PRINT:PRINT
950 INPUT "          PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
960 IF Z$="P" THEN GOTO 450
970 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
980 CLS
990 PRINT "                            FOR/NEXT AS A NUMBER COUNTER
1000 PRINT
1010 PRINT "            We know that the computer can count from and to a specified
1020 PRINT "            number (i.e  1 to 2000).  Well, why not have the computer
1030 PRINT "            PRINT the numbers as it counts ?  This is accomplished
1040 PRINT "            with the addition of a PRINT statement.  Here's how.....
1050 PRINT
1060 PRINT "                               10 FOR G=1 TO 5
1070 PRINT "                               20 PRINT G
1080 PRINT "                               30 NEXT G
1090 PRINT
1100 INPUT "            Ok, type RUN and press [RETURN] to see what happens ",Z$
1110 IF Z$="RUN" THEN FOR G=1 TO 5:PRINT TAB(40); G:NEXT G
1120 IF Z$<>"RUN" THEN INPUT "TRY AGAIN - Type RUN and press [RETURN] ",Z$:GOTO 1110
1130 FOR A=1 TO 500:NEXT A:PRINT
1140 PRINT "           We can also count 'by' numbers. That is, the computer can
1150 PRINT "           count to 10 by 2's or 3's or even 6.45375's, with the STEP
1160 PRINT "           function added on.
1170 PRINT:PRINT
1180 INPUT "          PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1190 IF Z$="P" THEN GOTO 720
1200 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1210 CLS
1220 PRINT "           Below is a program that uses STEP to count to 10 by 2's.....
1230 PRINT "                 (note the comma (,) after the K in line 20)
1240 PRINT
1250 PRINT "                               10 FOR K=2 TO 10 STEP 2
1260 PRINT "                               20 PRINT K,
1270 PRINT "                               30 NEXT K
1280 PRINT
1290 INPUT "           Again, type RUN and press [RETURN]  ",Z$
1300 PRINT
1310 IF Z$="RUN" THEN FOR K=2 TO 10 STEP 2:PRINT K,:NEXT K
1320 IF Z$<>"RUN" THEN INPUT "TRY AGAIN - Type RUN and press [RETURN] ",Z$:GOTO 1310
1330 FOR A=1 TO 500:NEXT A
1340 PRINT:PRINT:PRINT
1350 PRINT "           Now let's make the computer count backwards.....
1360 PRINT
1370 PRINT "                               10 FOR A=20 TO 1 STEP -1
1380 PRINT "                               20 PRINT A;
1390 PRINT
1400 INPUT "           Type RUN and press [RETURN]  ",Z$:PRINT
1410 FOR A=20 TO 1 STEP -1:PRINT A;:NEXT A
1420 FOR A=1 TO 500:NEXT A
1430 PRINT:PRINT:PRINT
1440 INPUT "         PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1450 IF Z$="P" THEN GOTO 980
1460 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1470 CLS
1480 PRINT "                       FOR/NEXT TO PRINT MULTIPLE DATA
1490 PRINT
1500 PRINT "            FOR/NEXT can cause the computer to repeatedly PRINT data
1510 PRINT "            as many times as is specified in the FOR line.
1520 PRINT
1530 PRINT "                               10 FOR J=1 TO 3
1540 PRINT "                               20 PRINT ''HI THERE !''
1550 PRINT "                               30 NEXT J
1560 PRINT
1570 INPUT "           Type RUN and press [RETURN] ",Z$
1580 PRINT
1590 PRINT "                                HI THERE !
1600 PRINT "                                HI THERE !
1610 PRINT "                                HI THERE !
1620 PRINT
1630 FOR A=1 TO 500:NEXT A
1640 PRINT "           Instead of PRINTing a variable (in this case 'J'), the
1650 PRINT "           computer was instructed to print the STRING (HI THERE !).
1660 PRINT:PRINT:PRINT:PRINT
1670 INPUT "          PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1680 IF Z$="P" THEN GOTO 1210
1690 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1700 CLS
1710 PRINT "                            ALL IN ONE PACKAGE.....
1720 PRINT
1730 PRINT "            As a sort of 'grand finale' we'll use each application of
1740 PRINT "            FOR/NEXT all in one program.  When we combine FOR/NEXT loops,
1750 PRINT "            we NEST them, and thus call them NESTED LOOPS.
1760 PRINT
1770 PRINT "                              10 FOR R=1 TO 5
1780 PRINT "                              20 PRINT R;''BASIC''
1790 PRINT "                              30 FOR S=1 TO 500
1800 PRINT "                              40 NEXT S
1810 PRINT "                              50 NEXT R
1820 PRINT
1830 PRINT "           Lines 20, 30, and 40 are all enclosed in the main loop and
1840 PRINT "           will be repeated 5 times. 
1850 PRINT
1860 PRINT "           Line 20 will PRINT the number stored to the VARIABLE 'R'
1870 PRINT "           and, on the same line, the STRING 'BASIC'.
1880 PRINT
1890 PRINT "           Lines 30 and 40 will cause a pause (for an internal count
1900 PRINT "           to 500).
1910 PRINT:PRINT:PRINT
1920 INPUT "          PRESS [RETURN TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1930 IF Z$="P" THEN GOTO 1470
1940 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1950 CLS
1960 INPUT "Type RUN and press [RETURN] to see the NESTED LOOP program  ",Z$
1970 PRINT
1980 FOR A=1 TO 5
1990 PRINT A;"BASIC"
2000 FOR T=1 TO 500:NEXT T
2010 NEXT A
2020 FOR A=1 TO 1000:NEXT A
2030 PRINT
2040 PRINT "------------------------------------------------------------------------------"
2050 PRINT "IN SUMMARY.....
2060 PRINT
2070 PRINT "          1.  FOR/NEXT has three uses:
2080 PRINT "            a. pause   b. count numbers   c. repeat STRING data
2090 PRINT "          2.  A NESTED LOOP is a combination of FOR/NEXT loops
2100 PRINT
2110 PRINT "------------------------------------------------------------------------------"
2120 PRINT "FOR PRACTICE.....
2130 PRINT
2140 PRINT "          1.  Try each application separately, then combine them
2150 PRINT:PRINT
2160 INPUT "            PRESS [Z] TO PRACTICE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
2170 IF Z$="P" THEN GOTO 1700
2180 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
2190 CLS
2200 PRINT "              To begin practicing, type NEW and press [RETURN]
2210 PRINT
2220 PRINT "    To get back to lessons, type LOAD''B:BTMENU.BAS'',R AND PRESS [RETURN]
2230 PRINT
2240 PRINT "        Remember to use quotations instead of double apostrophies ('')
2250 PRINT "------------------------------------------------------------------------------"
tead of double apostrophies ('')
2250 PRINT "-----------------