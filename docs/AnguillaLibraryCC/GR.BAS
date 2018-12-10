10 CLS: ' MARK A. SWANSON     19:15:29  2/27/1985
20 PRINT:PRINT:PRINT:PRINT
30 PRINT "                                                   -\ /-
40 PRINT "          __________|--|              /---\          |       |------|
50 PRINT "         |             |_____________|     |_________|_______|      |
60 PRINT "        |     *        |                      ||                    |
70 PRINT "        |    /()\      |                      ||                    |
80 PRINT "        |     ``       |       GOSUB &        ||    THE COMPUTER    |
90 PRINT "        |              |                      ||                    |
100 PRINT "        |              |       RETURN         ||    HOMING PIGEON   |
110 PRINT "       |               |                      ||                    |
120 PRINT "       |               |                      ||                    |
130 PRINT "       |               |                      ||                    |
140 PRINT "       |               |                      ||                    |
150 PRINT "       |_______________|______________________||____________________|
160 FOR A =1 TO 2000:NEXT A
170 CLS
180 PRINT "         GOSUB/RETURN is almost identical to GOTO in that the computer
190 PRINT "         is instructed to go to another line number and resume
200 PRINT "         operation.  The one difference is that GOSUB/RETURN has a
210 PRINT "         memory.
220 PRINT
230 PRINT "        Let's look at what each of these statements do:
240 PRINT
250 PRINT "        GOSUB - sends the computer to the specified line number in
260 PRINT "                the program (example: GOSUB 150).
270 PRINT
280 PRINT "        RETURN - sends the computer back to the line following the
290 PRINT "                 last GOSUB encountered to continue normally.
300 PRINT
310 PRINT "       OK, so now that we know what each one does, let's see how and
320 PRINT "       why we use GOSUB/RETURN in a program.
330 PRINT:PRINT:PRINT:PRINT:PRINT
340 INPUT "                  PRESS [RETURN] TO CONTINUE OR [Q] MAIN BTMENU ",Z$
350 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
360 CLS
370 PRINT "       GOSUB/RETURN is most often used when there is a great deal of
380 PRINT "       repetition in a program.  For example, imagine you want to
390 PRINT "       write a program that would allow the user to look at the
400 PRINT "       instructions at any time and from any point in the program.
410 PRINT
420 PRINT "       Normally, you would have to rewrite the instructions for every
430 PRINT "       time the user may want them.  Or, you could have a SUBROUTINE
440 PRINT "       for the instructions.  This way, you only write them once.
450 PRINT "       Access could be provided by GOTO.  Then if the user wants to
460 PRINT "       see the instuctions, a GOTO statement will direct the computer
470 PRINT "       to the appropriate line number.  Uh oh..... there's still a
480 PRINT "       problem.  You need another GOTO statement at the end of the
490 PRINT "       instructions subroutine to get the user back to the regular
500 PRINT "       part of the program.  That will work fine - once.  Ater that,
510 PRINT "       the same 'send it back' GOTO statement would be outdated.
520 PRINT "       You will continually go back to the first place where access
530 PRINT "       to the subroutine was allowed, even though you may now be
540 PRINT "       accessing from a different part of the main program.
550 PRINT:PRINT:PRINT:PRINT
560 INPUT "       PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
570 IF Z$="P" THEN GOTO 170
580 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
590 CLS
600 PRINT "      GOSUB/RETURN will handle this problem easily.  Remember, GOSUB
610 PRINT "      sends the computer to the subroutine (like GOTO).  Now, RETURN
620 PRINT "      will take over to send the computer back to where the last
630 PRINT "      GOSUB was encountered.  That's why we call GOSUB/RETURN the
640 PRINT "      computer 'homing pigeon'.  It always returns the computer to
650 PRINT "      its point of origin.
660 PRINT "      Here is a simple use of GOSUB/RETURN.  Note that we wouldn't
670 PRINT "      normally use these powerful ststements for such a simple
680 PRINT "      operation, but the below example illustrates the process.
690 PRINT
700 PRINT "                         10 PRINT '' HI '';
710 PRINT "                         20 GOSUB 100
720 PRINT "                         30 PRINT '' HELLO '';
730 PRINT "                         40 GOSUB 100
740 PRINT "                         50 END
750 PRINT "                         100 PRINT '' THERE ''
760 PRINT "                         110 RETURN
770 PRINT
780 INPUT "     Type RUN and press [RETURN] to see the output. ",R$
790 PRINT
800 PRINT "                         HI THERE
810 PRINT "                         HELLO THERE
820 PRINT
830 INPUT "     PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
840 IF Z$="P" THEN GOTO 360
850 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
860 CLS
870 PRINT "      If you were to watch the computer do each line in the program,
880 PRINT "      it would go like this...
890 PRINT
900 PRINT "                         10 PRINT '' HI '';
910 PRINT "                         20 GOSUB 100
920 PRINT "                         100 PRINT '' THERE ''
930 PRINT "                         110 RETURN
940 PRINT "                         30 PRINT '' HELLO '';
950 PRINT "                         40 GOSUB 100
960 PRINT "                         100 PRINT '' THERE ''
970 PRINT "                         110 RETURN
980 PRINT "                         50 END
990 PRINT 
1000 PRINT "             output -->  HI THERE
1010 PRINT "                         HELLO THERE
1020 PRINT
1030 PRINT:PRINT:PRINT:PRINT:PRINT
1040 INPUT "      PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1050 IF Z$="P" THEN GOTO 590
1060 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1070 CLS
1080 PRINT "      Notice that we had to put END in the program after the last
1090 PRINT "      GOSUB statement.  This is done to prevent the computer from
1100 PRINT "      entering the subroutine without the direction of another
1110 PRINT "      GOSUB.  Without END or another 'diversion' the computer would
1120 PRINT "      'fall through' into the subroutine, encounter RETURN, and
1130 PRINT "      display the message 'RETURN WITHOUT GOSUB'.  In other words,
1140 PRINT "      every RETURN must have a corresponding GOSUB.
1150 PRINT 
1160 PRINT "      The best way to become comfortable with GOSUB/RETURN is to do
1170 PRINT "      a number of practice programs.  You'll soon find that this is
1180 PRINT "      a great tool for longer programs.
1190 PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT
1200 INPUT "      PRESS [RETURN] TO CONTINUE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1210 PRINT "IN SUMMARY...
1220 IF Z$="P" THEN GOTO 860
1230 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1240 CLS
1250 PRINT "IN SUMMARY...
1260 PRINT
1270 PRINT "          1.  GOSUB/RETURN works like GOTO except RETURN remembers
1280 PRINT "              where the it came from and returns to that point.
1290 PRINT "          2.  GOSUB/RETURN is useful for repetitious subroutines.
1300 PRINT
1310 PRINT "------------------------------------------------------------------------------"
1320 PRINT "FOR PRACTICE...
1330 PRINT
1340 PRINT "          1.  Take out the END or other 'diversions' in the programs
1350 PRINT "              to see what happens.
1360 PRINT "          2.  Modify programs using GOTO to use GOSUB/RETURN.
1370 PRINT "          3.  Create your own programs using GOSUB/RETURN.
1380 PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT
1390 INPUT "      PRESS [RETURN] TO PRACTICE  [P] PREVIOUS PAGE  [Q] MAIN BTMENU ",Z$
1400 IF Z$="P" THEN GOTO 1070
1410 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
1420 CLS
1430 PRINT "    To get back to lessons, type LOAD''B:BTMENU.BAS'',R and press [RETURN]
1440 PRINT "                                     ^             ^
1450 PRINT "      Don't forget to use quotations instead of double apostrophies.
1460 PRINT
1470 PRINT "                   To practice, type NEW and press [RETURN]
1480 PRINT "------------------------------------------------------------------------------"
ice, type NEW and press [RETURN]
1480 PRINT "---------------