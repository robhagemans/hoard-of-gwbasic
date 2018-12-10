10 ' MARK A. SWANSON    19:19:51  2/27/1985
20 CLS
30 PRINT "                       CHART OF APPLICATIONS AND STATEMENTS
40 PRINT:PRINT
50 PRINT :PRINT:PRINT:PRINT
60 PRINT "                This guide is designed to provide you with the BASIC
70 PRINT "                features needed to perform the applications covered
80 PRINT "                in the lessons.  Listed are the COMMANDS and STATEMENTS
90 PRINT "                followed by the uses and the proper syntax.
100 PRINT
110 PRINT "                When the appropriate STATEMENT or COMMAND has been
120 PRINT "                found, refer to the MAIN BTMENU for the respective lesson.
125 PRINT
126 PRINT "                Also included in this guide is an ASCII table.
130 PRINT:PRINT:PRINT:PRINT:PRINT:PRINT
140 INPUT "                   PRESS [RETURN] TO CONTINUE  [Q] MAIN BTMENU ",Z$
150 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
160 CLS
170 PRINT "COMMAND    USES                     SYNTAX
180 PRINT "----------------------------------------------------------------------------
190 PRINT "RUN
200 PRINT"          Starts program            1. RUN
210 PRINT "          currently in memory.      2. RUN [starting line #]
220 PRINT
230 PRINT "LIST
240 PRINT "          Displays program lines    1. LIST
250 PRINT "          currently in memory.      2. LIST [starting line #]
260 PRINT
270 PRINT "NEW
280 PRINT "         Erases program currently   1. NEW
290 PRINT "         in memory (will not erase
300 PRINT "         programs on disk).
310 PRINT
320 PRINT "REM      Allows programmer to type  1. REM [text]
330 PRINT "         notes on program lines.
340 PRINT "         Seen only when program is
350 PRINT "         listed.
360 PRINT:PRINT
370 INPUT "               PRESS [RETURN] FOR STATEMENTS  [Q] MAIN BTMENU ",Z$
380 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
390 CLS
400 PRINT "STATEMENT  USES                   SYNTAX
410 PRINT "-----------------------------------------------------------------------------
420 PRINT "PRINT
430 PRINT "          Displays information.       1. PRINT
440 PRINT "                                      2. PRINT [data]
450 PRINT
460 PRINT "GOTO
470 PRINT "          Directs program flow to     1. GOTO [staring line #]
480 PRINT "          specified line number.
490 PRINT
500 PRINT "LET
510 PRINT "          Labels and stores data      1. LET [data] = [data]
520 PRINT "          for later retrieval and
530 PRINT "          processing.
540 PRINT
550 PRINT "FOR/NEXT
560 PRINT "          Counts and displays         1. FOR [variable] = [start #]
570 PRINT "          numbers; Causes a pause        TO [end #] : NEXT [variable]
580 PRINT "          or delay; Causes repeated   2. FOR [variable] = [start #]
590 PRINT "          output.                        TO [end #] STEP [increment #] :
600 PRINT "                                         NEXT [variable]
610 PRINT
620 INPUT "       PRESS [RETURN] TO CONTINUE  [P] PREVIOUSE PAGE  [Q] MAIN BTMENU ",Z$
630 IF Z$="P" THEN GOTO 160
640 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
650 CLS
660 PRINT "STATEMENT  USES                        SYNTAX
670 PRINT "-----------------------------------------------------------------------------"
680 PRINT "INPUT
690 PRINT "           Asks for, labels, and       1. INPUT [text in quotes] ;
700 PRINT "           stores user defined data.      [variable]
710 PRINT
720 PRINT "IF/THEN
730 PRINT "           Acts upon data according    1. IF [condition] THEN [action]
740 PRINT
750 PRINT "READ/DATA
760 PRINT "           Retrieves multiple data.    1. READ [variable]
770 PRINT "           Allows for storage of          DATA [data separated by commas]
780 PRINT "           large amounts of data in
790 PRINT "           a common area of the
800 PRINT "           program.
810 PRINT
820 PRINT "GOSUB/RETURN
830 PRINT "           Directs program flow to      1. GOSUB [line #]
840 PRINT "           a specified line number.        RETURN
850 PRINT:PRINT
860 INPUT " PRESS [RETURN] ASCII TABLE    PRESS [P] PREVIOUS PAGE    [Q] MAIN BTMENU ",Z$
870 IF Z$="P" THEN GOTO 390
880 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R
890 CLS:PRINT "                    ASCII TABLE OF SYMBOLS & CHARACTERS
900 PRINT:PRINT
910 PRINT "To use these characters in a program use PRINT with CHR$ ......
920 PRINT
930 PRINT "PRINT CHR$(X)                     Example --->    PRINT CHR$(177)
940 PRINT "X is the ASCII number                             ±
945 FOR DELAY=1 TO 2000:NEXT
950 PRINT
960 LOCATE 8,1:FOR A=1 TO 78:PRINT CHR$(205);:NEXT
965 FOR A=1 TO 6:PRINT A;CHR$(A);" ";:NEXT
970 FOR A=15 TO 28:PRINT A;CHR$(A);" ";:NEXT A
975 FOR A=33 TO 255:PRINT A;CHR$(A);" ";:NEXT A :PRINT
980 INPUT "                     PRESS [P] PREVIOUS PAGE    [Q] MAIN BTMENU ",Z$
990 IF Z$="P" THEN GOTO 650
1000 IF Z$="Q" THEN LOAD"B:BTMENU.BAS",R ELSE GOTO 980
P] PREVIOUS PAGE    [Q] MAIN BTMENU ",Z$
990 IF Z$="P" THEN GOTO 650
1000 IF Z$="Q" THEN L