10 CLS
20 A$=STRING$(80,205)
30 PRINT A$
40 PRINT TAB(17)"5005-A.BAS      PERCENT DIFFERENCE CALCULATOR"
50 COLOR 23,0,0
60 PRINT :PRINT :PRINT TAB(38)"IPCO"
70 COLOR 7,0,0
80 PRINT :PRINT :PRINT TAB(29)"INTERNATIONAL PC OWNERS"
90 PRINT :PRINT :PRINT TAB(17)"p.o. box 10426, pittsburgh, pennsylvania 15234"
100 PRINT A$
110 PRINT :PRINT :PRINT :PRINT :PRINT
120 PRINT TAB(28)"PRESS ANY KEY TO CONTINUE"
130 A$=INKEY$:IF A$="" THEN 130
140 CLS
1000 ' IPCO  Software Exchange Submission PERCENT2 authored on November 15, 1982
1010 '
1020 '  by Michael Csontos, 3228 Livonia Center Road, Lima, New York 14485
1030 '
1040 PRINT "Do you have a  1.) high resolution":PRINT
1050 PRINT "                   80 character width":PRINT
1060 PRINT "         or a  2.) low resolution":PRINT
1070 PRINT "                   40 character width":PRINT
1080 PRINT "display?":PRINT
1090 INPUT "(1 or 2)";DISP
1100 IF DISP<1 OR DISP>2 OR INT(DISP)<>DISP THEN 1090
1110 ON DISP GOTO 1120,1340
1120 SCREEN 0,0,0:WIDTH 80: COLOR 7,0,0:A=0:B=0:CLS:KEY OFF
1130 PRINT " It is a simple thing to calculate percentages, however it is also":PRINT
1140 PRINT "easy to get confused.  The trouble is that 100 is 100% > 50, but 50":PRINT
1150 PRINT "is 50% of 100!":PRINT
1160 PRINT " This program calculates percent every possible way.  You choose the":PRINT
1170 PRINT "one that you intend.":PRINT
1180 PRINTOUT$="NO":PRINT :PRINT "Do you want a running printout of your results (Y or N)?":GOSUB 1330:CLS:ON A GOTO 1200,1190,1180
1190 PRINTOUT$="YES"
1200 INPUT "What is the first number, which we will call A";A:PRINT
1210 IF A=0 THEN PRINT "Anything is infinitely different from 0. Won't work. Try again.":PRINT:GOTO 1200
1220 INPUT "The second number will be B. What is it";B:PRINT
1230 IF B=0 THEN PRINT "Anything is infinitely different from 0. Won't work. Try again.":PRINT:GOTO 1220
1240 PRINT "The number A is "(A-B)/B*100" percent GREATER than the number B.":PRINT
1250 PRINT "The number B is "(A-B)/A*100" percent LESS than the number A.":PRINT
1260 PRINT "The number B is "(B-A)/A*100" percent GREATER than the number A.":PRINT
1270 PRINT "The number A is "(B-A)/B*100" percent LESS than the number B.":PRINT
1280 IF PRINTOUT$="YES" THEN LPRINT A" is "(A-B)/B*100"% > "B:LPRINT B" is "(A-B)/A*100"% < "A:LPRINT B" is "(B-A)/A*100"% > "A:LPRINT A" is "(B-A)/B*100"% < "B:LPRINT
1290 GOSUB 1300:GOTO 1200
1300 LOCATE 25,1:PRINT SPC(10)"PRESS ANY KEY TO CONTINUE EXCEPT <Esc> TO QUIT"STRING$(23," ");
1310 X$=INKEY$:IF X$="" THEN GOTO 1310 ELSE IF X$=CHR$(27) THEN GOTO 1320 ELSE FOR N=0 TO 15:DUMP$=INKEY$:NEXT:CLS:RETURN
1320 KEY ON:COLOR 7,0,0:CLS:END
1330 X$=INKEY$:IF X$="" THEN GOTO 1330 ELSE IF X$="N" OR X$="n" THEN A=1:RETURN:ELSE IF X$="Y" OR X$="y" THEN A=2:RETURN:ELSE A=3:LOCATE 25,40:PRINT "Please answer Y,y,N,or n";:FOR N=0 TO 500:NEXT :FOR N=0 TO 15:DUMP$=INKEY$:NEXT:RETURN
1340 SCREEN 0,0,0:WIDTH 40: COLOR 7,0,0:A=0:B=0:CLS:KEY OFF
1350 PRINT " It is a simple thing to calculate      percentages, however it is also"
1360 PRINT "easy to get confused.  The trouble is   that 100 is 100% > 50, but 50"
1370 PRINT "is 50% of 100!":PRINT
1380 PRINT " This program calculates percent every  possible way.  You choose the"
1390 PRINT "one that you intend.":PRINT
1400 PRINTOUT$="NO":PRINT :PRINT "Do you want a running printout of your  results (Y or N)?":GOSUB 1550:CLS:ON A GOTO 1420,1410,1400
1410 PRINTOUT$="YES"
1420 INPUT "What is the first number, which we will call A";A:PRINT
1430 IF A=0 THEN PRINT "Anything is infinitely different from 0.Won't work. Try again.":PRINT:GOTO 1420
1440 INPUT "The second number will be B. What is it       ";B:PRINT
1450 IF B=0 THEN PRINT "Anything is infinitely different from 0.Won't work. Try again.":PRINT:GOTO 1440
1460 PRINT "The number A is "(A-B)/B*100" percent":PRINT " GREATER than the number B.":PRINT
1470 PRINT "The number B is "(A-B)/A*100" percent":PRINT " LESS than the number A.":PRINT
1480 PRINT "The number B is "(B-A)/A*100" percent":PRINT " GREATER than the number A.":PRINT
1490 PRINT "The number A is "(B-A)/B*100" percent":PRINT " LESS than the number B.":PRINT
1500 IF PRINTOUT$="YES" THEN LPRINT A" is "(A-B)/B*100"% > "B:LPRINT B" is "(A-B)/A*100"% < "A:LPRINT B" is "(B-A)/A*100"% > "A:LPRINT A" is "(B-A)/B*100"% < "B:LPRINT
1510 GOSUB 1520:GOTO 1420
1520 LOCATE 25,1:PRINT "PRESS A KEY or PRESS <Esc> TO QUIT";
1530 X$=INKEY$:IF X$="" THEN GOTO 1530 ELSE IF X$=CHR$(27) THEN GOTO 1540 ELSE FOR N=0 TO 15:DUMP$=INKEY$:NEXT:CLS:RETURN
1540 KEY ON:COLOR 7,0,0:CLS:END
1550 X$=INKEY$:IF X$="" THEN GOTO 1550 ELSE IF X$="N" OR X$="n" THEN A=1:RETURN:ELSE IF X$="Y" OR X$="y" THEN A=2:RETURN:ELSE A=3:LOCATE 25,1:PRINT "Please answer Y,y,N,or n";:FOR N=0 TO 500:NEXT :FOR N=0 TO 15:DUMP$=INKEY$:NEXT:RETURN
1560 '    SAVE"percent2",a
5,