10 CLS
30 PRINT:PRINT
40 PRINT "                                     THE  MODES
50 PRINT
60 PRINT "                                         OF
70 PRINT 
80 PRINT "                                     OPERATION
90 PRINT:PRINT:PRINT
100 PRINT "                                       ------ 
110 PRINT "            ---------------------------- or --------------------------
120 PRINT "                                       ------ 
130 PRINT:PRINT:PRINT
140 PRINT "                                  A  QUESTION  OF
150 PRINT
160 PRINT "                                        OF
170 PRINT
180 PRINT "                                [RUN]  OR  [RETURN]
190 FOR A=1 TO 2500:NEXT A
200 CLS
210 PRINT "                             THE TWO MODES OF OPERATION
220 PRINT:PRINT
230 PRINT "                                   1.  IMMEDIATE
240 PRINT
250 PRINT "                                   2.  PROGRAMMING
260 PRINT:PRINT:PRINT
270 PRINT "             A computer operates in 'modes'.  A particular mode
280 PRINT "             simply signifies when commands and statements are to
290 PRINT "             be executed.  An easy way to remember the difference is
300 PRINT "             that in IMMEDIATE MODE the commands or statements are
310 PRINT "             executed by pressing the [RETURN] key, whereas in the
320 PRINT "             PROGRAMMING MODE the word RUN must be typed in order for
330 PRINT "             commands or statements (usually several) to be executed
340 PRINT "             or 'run'.
350 PRINT:PRINT:PRINT
360 INPUT "         PRESS [RETURN] TO CONTINUE or [P] PREVIOUS PAGE or [Q] MAIN BTMENU ",Z$
370 IF Z$="P" THEN 10
380 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
390 CLS
400 PRINT "                                THE IMMEDIATE MODE
410 PRINT:PRINT
420 PRINT "        This mode can also be thought of as the 'calculator' mode because"
430 PRINT "        you need only type the necessary information followed by a [RETURN]"
440 PRINT "        or in the calculator's case, an '=' sign.
450 PRINT
460 PRINT "        We used the IMMEDIATE MODE in the examples in lesson 1 (PRINT).
470 PRINT "       First, we typed in what we wanted the computer to do (PRINT).
480 PRINT "       Second, we typed in the 'ARGUMENT' (1+1).  Third, we pressed the
490 PRINT "       [RETURN] key to make it all happen.
500 PRINT
510 PRINT "       COMMANDS are used more commonly in the IMMEDIATE mode than are
520 PRINT "       STATEMENTS.  An example is the COMMAND 'RUN'.  We type in in at 
530 PRINT "       the IMMEDIATE MODE, followed by [RETURN], to execute or start a program.
540 PRINT
550 PRINT "                       ***   EXAMPLES OF IMMEDIATE MODE   ***
560 PRINT
570 PRINT "        PRINT ''HI THERE ! ''  [RETURN]           PRINT 3+3/2   [RETURN]
580 PRINT:PRINT:PRINT
590 INPUT "         PRESS [RETURN] TO CONTINUE OR [P] PREVIOUS PAGE OR [Q] MAIN BTMENU ",Z$
600 IF Z$="P" THEN GOTO 200
610 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
620 CLS
630 PRINT "                                THE PROGRAMMING MODE
640 PRINT:PRINT:PRINT:PRINT:PRINT
650 PRINT "            Now we're getting to the heart of using BASIC to a much
660 PRINT "            greater potential.  This is where real programming takes
670 PRINT "            place !
680 PRINT
690 PRINT "            Remember, a PROGRAM is a list of instructions in sequential
700 PRINT "            numeric order that the computer can 'read' and hence carry
710 PRINT "            out after the COMMAND [RUN] has been typed and the [RETURN]
720 PRINT "            key pressed.
730 PRINT
740 PRINT "            RUN is typed in at the IMMEDIATE mode which means ....
750 PRINT "            we start the PROGRAM from the IMMEDIATE mode.
760 PRINT:PRINT:PRINT:PRINT:PRINT
770 INPUT "        PRESS [RETURN] TO CONTINUE or [P] PREVIOUS PAGE or [Q] MAIN BTMENU ",Z$
780 IF Z$="P" THEN GOTO 390
790 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
800 CLS
810 PRINT
820 PRINT "            So how do we get into the PROGRAMMING mode ?  Simply by
830 PRINT "            prefacing our instructions with a number (herein referred
840 PRINT "            to as a LINE NUMBER).  When we press the [RETURN] key to
850 PRINT "            signal to the computer the end of our instruction line
860 PRINT "            and that we now want it stored in the computer's memory,
870 PRINT "            the computer responds by merely placing the cursor on
880 PRINT "            the next line down.  the computer did not carry out your
890 PRINT "            instructions (after pushing [RETURN]) because it assumed
900 PRINT "            you had more instructions to type in.
910 PRINT
920 PRINT "            Let's look at an example of the PROGRAMMING mode using
930 PRINT "            the PRINT statement.
940 PRINT:PRINT
950 PRINT "                               10 PRINT ''HELLO THERE''"
960 PRINT "                               20 PRINT ''HOW ARE YOU ?''"
970 PRINT "                               30 END
980 PRINT:PRINT:PRINT
990 INPUT "         PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1000 IF Z$="P" THEN GOTO 620
1010 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1020 CLS
1030 PRINT "                We'll take another look at the sample PROGRAM...
1040 PRINT
1050 PRINT "            1st thing the computer does.......  10 PRINT ''HELLO THERE''"
1060 PRINT "            2nd thing the computer does.......  20 PRINT ''HOW ARE YOU ?''"
1070 PRINT "            3rd - signals END of program......  30 END
1080 PRINT
1090 PRINT "            Output............................  HELLO THERE
1100 PRINT "                                                HOW ARE YOU ?
1110 PRINT
1120 PRINT "            So you see, the PROGRAMMING mode allows us to type in
1130 PRINT "            multiple instructions in the order in which we want them
1140 PRINT "            to be executed (acted upon).
1150 PRINT
1160 PRINT "            This particular lesson you're using was written in the
1170 PRINT "            PROGRAMMING mode and has about 150 lines of instructions,
1180 PRINT "            all of which are prefaced with LINE NUMBERS.
1190 PRINT:PRINT:PRINT:PRINT:PRINT
1200 INPUT "         PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1210 IF Z$="P" THEN GOTO 800
1220 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1230 CLS
1240 PRINT "            You may be wondering why the numbers 10, 20, and 30 were
1250 PRINT "            used instead of 1, 2, & 3.  Often times we need to add a
1260 PRINT "            line or two to a program, which is one way to EDIT or change"
1270 PRINT "            the program after it has been entered.  By numbering in
1280 PRINT "            increments of 10 we can insert up to 9 additional lines
1290 PRINT "            of program between each original increment.
1300 PRINT
1310 PRINT "            Let's use the same sample program as an example of simple
1320 PRINT "            EDITing.
1330 PRINT
1340 PRINT "                             10 PRINT ''HELLO THERE''"
1350 PRINT "                             20 PRINT ''HOW ARE YOU ?''"
1360 PRINT "                             30 END
1370 PRINT
1380 PRINT "             We'll add a line 15....
1390 PRINT
1400 PRINT "                             15 PRINT ''I FEEL GREAT !''"
1410 PRINT:PRINT:PRINT:PRINT
1420 INPUT "         PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1430 IF Z$="P" THEN GOTO 1020
1440 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1450 CLS
1460 PRINT "             To see our new list of program lines, we type LIST and
1470 PRINT "             here's what we get.....
1480 PRINT:PRINT
1490 PRINT "                               10 PRINT ''HELLO THERE''"
1500 PRINT "                               15 PRINT ''I FEEL GREAT !''"
1510 PRINT "                               20 PRINT ''HOW ARE YOU ?''"
1520 PRINT "                               30 END
1530 PRINT
1540 PRINT "            The computer automatically inserted the new line into the
1550 PRINT "            proper seqential order.  This time when we type RUN and
1560 PRINT "            press RETURN we get.....
1570 PRINT
1580 PRINT "                                  HELLO THERE
1590 PRINT "                                  I FEEL GREAT !
1600 PRINT "                                  HOW ARE YOU ?
1610 PRINT:PRINT:PRINT:PRINT:PRINT:PRINT
1620 INPUT "          PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1630 IF Z$="P" THEN GOTO 1230
1640 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1650 CLS
1660 PRINT "   IN SUMMARY...........
1670 PRINT
1680 PRINT "             1.  Immediate mode can work like a calculator
1690 PRINT "             2.  Immediate mode commands
1700 PRINT "               a. RUN - starts the program, runs the program
1710 PRINT "               b. LIST - displays program listing
1720 PRINT "               c. NEW - clears memory, erases program
1730 PRINT "             3.  Immediate mode execution - press RETURN
1740 PRINT "             4.  Program mode execution - type RUN, then press RETURN
1750 PRINT "             5.  In program mode, line numbers preface statements
1760 PRINT "             6.  Program mode allows multiple statements to be run
1770 PRINT "                 (executed) in sequential order
1780 PRINT
1790 PRINT "------------------------------------------------------------------------------"
1800 PRINT "   FOR PRACTICE.........
1810 PRINT
1820 PRINT "             1.  Create your own 3 or 4 line program using PRINT
1830 PRINT "             2.  Use increments of 10 for line numbers
1840 PRINT "             3.  EDIT by adding new lines
1850 PRINT:PRINT
1860 INPUT "            PRESS [Z] TO PRACTICE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1870 IF Z$="P" THEN GOTO 1450
1880 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1890 CLS
1900 PRINT "* Remember to press [RETURN] after each line to signal computer that you
1910 PRINT "are ready to move on.
1920 PRINT "* Remember to type RUN and press [RETURN] to run program.
1930 PRINT "* LIST will display the program's line numbers and instructions.
1940 PRINT "* NEW will clear the memory and erase previous programs from computer's memory.
1950 PRINT
1960 PRINT "To get back to lessons, type LOAD''B:BTMENU.BAS'',R
1970 PRINT "------------------------------------------------------------------------------"
1980 PRINT "                       To begin, type NEW and press [RETURN]
--------------------------------------------------"
1980 PRINT "                       To begin, type NEW and press [RET