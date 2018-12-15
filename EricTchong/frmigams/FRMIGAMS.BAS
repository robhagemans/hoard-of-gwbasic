10  ' frmigams.bas - FreeWare 2005 from Aruba
20 GOTO 170 ' begin
30 SAVE"frmigams",A:LIST-170      
40 GOTO 1340 ' locate converter
50 GOTO 1360 ' blank from print to 
60 GOTO 1380 ' blank O
70 GOTO 1420 ' print O
80 GOTO 1470 ' get key
90 GOTO 1510 ' get from & to
100 GOTO 1610 ' illegal move
110 GOTO 1690 ' computer wins
120 GOTO 1770 ' human wins
130 GOTO 1840 ' delay
140 GOTO 1880 ' convert 47 - 57 --> 0 - 10
150 GOTO 2000 ' check for legal human move HM=1
160 ' begin
170 CLS:SCREEN 0:KEY OFF:COLOR 15,0:RANDOMIZE TIMER
180 DIM P(10),T(10):DEFSTR M,Q:Q=MKI$(0):DIM M(24) ' locals
190 M(1) ="             Ё         Ё"
200 M(3) ="     зддддддд╢         цддддддд©"
210 M(4) ="     Ё       Ё    /    Ё       Ё"
220 M(5) ="     Ё       юддддбдддды       Ё"
230 M(6)= "зддддадддд©  зддддадддд©  зддддадддд©"
240 M(7)= "Ё         Ё  Ё         Ё  Ё         Ё"
250 M(8)= "Ё         цдд╢         цдд╢         Ё"
260 M(9)= "Ё    7    цд©Ё    8    Ёзд╢    9    Ё"
270 M(10)="юддддбдддды ЁюддддбддддыЁ юддддбдддды"
280 M(11)="зддддадддд© Ёзддддадддд©Ё зддддадддд©"
290 M(12)="Ё         Ё ю╢         цы Ё         Ё"
300 M(14)="Ё    4    Ё з╢    5    ц© Ё    6    Ё"
310 M(16)="зддддадддд© Ёзддддадддд©Ё зддддадддд©"
320 M(17)="Ё         цдыЁ         Ёюд╢         Ё"
330 M(19)="Ё    1    Ё  Ё    2    Ё  Ё    3    Ё"
340 M(20)="юддддбдддды  юддддбдддды  юддддбдддды"
350 M(21)="     Ё       зддддадддд©       Ё"
360 M(22)="     Ё       Ё         Ё       Ё"
370 M(23)="     юддддддд╢         цддддддды"
380 M(24)="             Ё    0    Ё"
390 M(2)=M(1):M(13)=M(8):M(18)=M(8):M(15)=M(10)
400 C$=CHR$(219):B1$=C$+C$+C$+C$+C$+C$+C$:A$="       ":Y=14
410 PRINT "   T H E   F R E N C H   M I L I T A R Y   G A M E"
420 PRINT "     GWBASIC by Eric F. Tchong - February 5, 2005 ":PRINT
430 PRINT "   The game is played against the computer with the"
440 PRINT "   two players alternating turns. You control the 3"
450 PRINT "   red pieces while the computer controls the green"
460 PRINT "            piece. You always go first.":PRINT
470 PRINT " Move along a line to an adjacent cell. Computer's"
480 PRINT "green piece can move in any direction, while your red"
490 PRINT "pieces cannot go in a backward (downward) direction."
500 PRINT "          To move, press keys 0 to 9 or /":PRINT
510 PRINT "  You win the game by trapping the computer where it"
520 PRINT "   cannot move. The computer wins by reaching the"
530 PRINT "       very bottom, where it cannot be caught.":PRINT
540 PRINT "          <Esc> exits the game immediately.":PRINT
550 PRINT "         Press any key to start the game..."
560 ' Initialize 11 screen positions
570 FOR A=0 TO 10:READ T(A):NEXT:RESTORE:GOSUB 80 ' get key
580 DATA 1372,1039,1052,1065,719,732,745,399,412,425,92
590 ' draw board
600 CLS:FOR A=0 TO 10:P(A)=0:NEXT:W=0
610 FOR X=1 TO 24:LOCATE X,Y:PRINT M(X);:NEXT
620 LOCATE 1,1:PRINT "    T H E"
630 LOCATE 2,1:PRINT "  F R E N C H"
640 LOCATE 3,1:PRINT "M I L I T A R Y"
650 LOCATE 4,1:PRINT "    G A M E"
660 Z=T(5):PL=0:GOSUB 70:Z=T(1):GOSUB 70 ' print pieces
670 Z=T(3):GOSUB 70:Z=T(0):GOSUB 70:SW=1
680 P(0)=1:P(1)=1:P(3)=1:P(5)=2
690 ' human first move --> 1-4  1-2  0-2  3-2  3-6
700 GOSUB 90  ' get from & to
710 GOSUB 150 ' test for valid human move
720 IF HM=0 THEN GOSUB 100:GOTO 700
730 W=W+1:LOCATE 2,54:PRINT "PLAY";W
740 P(F)=0:P(T)=1:GOSUB 50 ' blank from print to
750 ' test if human has won
760 IF P(1)+P(4)+P(5)+P(7)=5  THEN GOSUB 120:GOTO 600
770 IF P(7)+P(8)+P(9)+P(10)=5 THEN GOSUB 120:GOTO 600
780 IF P(3)+P(5)+P(6)+P(9)=5  THEN GOSUB 120:GOTO 600
790 ' scan computer spot
800 FOR S=0 TO 10
810  IF P(S)=2 THEN SP=S
820 NEXT:K=SP+1
830 ' go spot and make a smart move
840 ON K GOTO 860,880,920,960,1000,1040,1110,1150,1180,1220,1250
850 ' 0-1 0-2 0-3 
860 R=INT(RND*3)+1:IF P(R)=0 THEN 1260 ELSE 860
870 ' 1-0 1-2 1-4 1-5
880 IF P(0)=0 THEN R=0:GOTO 1260           ' 0 first
890 R=INT(RND*6):IF R=1 OR R=3 THEN 890
900 IF P(R)=0 THEN 1260 ELSE 890
910 ' 2-0 2-1 2-3 2-5              
920 IF P(0)=0 THEN R=0:GOTO 1260           ' 0 first
930 R=INT(RND*6):IF R=2 OR R=4 THEN 930
940 IF P(R)=0 THEN 1260 ELSE 930
950 ' 3-0 3-2 3-5 3-6
960 IF P(0)=0 THEN R=0:GOTO 1260           ' 0 first
970 R=INT(RND*7):IF R=1 OR R=3 OR R=4 THEN 970
980 IF P(R)=0 THEN 1260 ELSE 970
990 ' 4-1 4-5 4-7
1000 IF P(1)=0 THEN R=1:GOTO 1260           ' 1 first
1010 R=INT(RND*7)+1:IF R=2 OR R=3 OR R=4 OR R=6 THEN 1010
1020 IF P(R)=0 THEN 1260 ELSE 1010
1030 ' 5-1 5-2 5-3 5-4 5-6 5-7 5-8 5-9      ' 1, 2, or 3 first
1040 IF P(1)=0 AND P(2)=0 AND P(3)=0 THEN R=INT(RND*3)+1:GOTO 1260
1050 IF P(1)=0 AND P(2)=0 THEN R=INT(RND*2)+1:GOTO 1260
1060 IF P(2)=0 AND P(3)=0 THEN R=INT(RND*2)+2:GOTO 1260
1070 IF P(1)=0 AND P(3)=0 THEN R=INT(RND*2):IF R=0 THEN R=1:GOTO 1260 ELSE R=3:GOTO 1260
1080 R=INT(RND*9)+1:IF R=5 THEN 1080
1090 IF P(R)=0 THEN 1260 ELSE 1080
1100 ' 6-3 6-5 6-9
1110 IF P(3)=0 THEN R=3:GOTO 1260           ' 3 first
1120 R=INT(RND*7)+3:IF R=4 OR R=6 OR R=7 OR R=8 THEN 1120
1130 IF P(R)=0 THEN 1260 ELSE 1120
1140 ' 7-4 7-5 7-8 7-10
1150 R=INT(RND*7)+4:IF R=6 OR R=7 OR R=9 THEN 1150
1160 IF P(R)=0 THEN 1260 ELSE 1150
1170 ' 8-5 8-7 8-9 8-10
1180 IF P(5)=0 THEN R=5:GOTO 1260           ' 5 first
1190 R=INT(RND*6)+5:IF R=6 OR R=8 THEN 1190
1200 IF P(R)=0 THEN 1260 ELSE 1190
1210 ' 9-5 9-6 9-8 9-10
1220 R=INT(RND*6)+5:IF R=7 OR R=9 THEN 1220
1230 IF P(R)=0 THEN 1260 ELSE 1220
1240 ' 10-7 10-8 10-9
1250 R=INT(RND*3)+7:IF P(R)=0 THEN 1260 ELSE 1250
1260 F=SP:T=R
1270 LOCATE 7,54:PRINT "COMPUTER moves"
1280 LOCATE 8,53:PRINT F:LOCATE 8,56:PRINT T
1290 PL=0:GOSUB 50:P(SP)=0:P(R)=2
1300 IF P(0)=2 THEN GOSUB 110:GOTO 600
1310 IF P(1)+P(4)+P(5)+P(7)=5 THEN GOSUB 110:GOTO 600 ' just to be safe
1320 GOTO 700
1330 ' locate converter
1340 V=INT(Z/64)+1:F=(V-1)*64:F=(Z-F)+1:LOCATE V,F:RETURN
1350 ' blank from print to
1360 Z=T(F):GOSUB 60:Z=T(T):GOSUB 70:RETURN
1370 ' blank O
1380 GOSUB 40:GOSUB 130
1390 FOR EQ=0 TO 1:LOCATE V+EQ,F:PRINT A$:NEXT:GOSUB 130
1400 RETURN
1410 ' paint O
1420 GOSUB 40:GOSUB 130
1430 IF PL=0 THEN COLOR 10,0 ELSE COLOR 12,0
1440 FOR EQ=0 TO 1:LOCATE V+EQ,F:PRINT B1$:NEXT:GOSUB 130
1450 PL=1:COLOR 15,0:RETURN
1460 ' get key
1470 LSET Q=MKI$(0)
1480 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND
1490 IF ASC(Q)=27 THEN 1590 ELSE RETURN
1500 ' player move from and move to values
1510 LOCATE 4,54:PRINT "HUMAN moves"
1520 GOSUB 80:F=ASC(Q):LOCATE 5,54:PRINT Q
1530 IF F<47 OR F>57 THEN GOSUB 100:GOTO 1520
1540 GOSUB 140:K=F
1550 GOSUB 80:T=ASC(Q):LOCATE 5,57:PRINT Q
1560 IF T<47 OR T>57 THEN GOSUB 100:GOTO 1550
1570 F=T:GOSUB 140:U=F:F=K:T=U:RETURN
1580 ' exit
1590 COLOR 7,0:CLS:END
1600 ' illegal move
1610 BEEP
1620 FOR D=1 TO 12
1630  LOCATE 6,54:PRINT "Illegal move":SOUND .49, .2
1640  LOCATE 6,54:PRINT "            ":SOUND .49, .2
1650 NEXT
1660 LOCATE 5,54:PRINT "    "
1670 RETURN
1680 ' computer wins
1690 BEEP
1700 FOR D=1 TO 12
1710  LOCATE 8,54:PRINT "COMPUTER WINS!":SOUND .49, .2
1720  LOCATE 8,54:PRINT "              ":SOUND .49, .2
1730 NEXT
1740 LOCATE 8,54:PRINT "Press to restart.."
1750 GOSUB 80:SW=0:RETURN
1760 ' human wins
1770 BEEP
1780 FOR D=1 TO 12
1790  LOCATE 8,54:PRINT "YOU WIN! Congrats":SOUND .49, .2
1800  LOCATE 8,54:PRINT "                 ":SOUND .49, .2
1810 NEXT
1820 GOTO 1740
1830 ' delay
1840 IF SW=0 THEN 1860
1850 FOR D=1 TO 3:SOUND .49, .2:NEXT
1860 RETURN
1870 ' convert 47 - 57 --> 0 - 10
1880 IF F=47 THEN F=10:RETURN
1890 IF F=48 THEN F=0:RETURN
1900 IF F=49 THEN F=1:RETURN
1910 IF F=50 THEN F=2:RETURN
1920 IF F=51 THEN F=3:RETURN
1930 IF F=52 THEN F=4:RETURN
1940 IF F=53 THEN F=5:RETURN
1950 IF F=54 THEN F=6:RETURN
1960 IF F=55 THEN F=7:RETURN
1970 IF F=56 THEN F=8:RETURN
1980 IF F=57 THEN F=9:RETURN
1990 ' test human legal move
2000 IF F=T THEN 2290
2010 IF F=0 AND T=1 THEN 2300 '  1
2020 IF F=0 AND T=2 THEN 2300 '  2
2030 IF F=0 AND T=3 THEN 2300 '  3
2040 IF F=1 AND T=2 THEN 2300 '  4
2050 IF F=1 AND T=4 THEN 2300 '  5
2060 IF F=1 AND T=5 THEN 2300 '  6
2070 IF F=2 AND T=1 THEN 2300 '  7
2080 IF F=2 AND T=3 THEN 2300 '  8
2090 IF F=2 AND T=5 THEN 2300 '  9
2100 IF F=3 AND T=2 THEN 2300 ' 10
2110 IF F=3 AND T=5 THEN 2300 ' 11
2120 IF F=3 AND T=6 THEN 2300 ' 12
2130 IF F=4 AND T=5 THEN 2300 ' 13
2140 IF F=4 AND T=7 THEN 2300 ' 14
2150 IF F=5 AND T=4 THEN 2300 ' 15
2160 IF F=5 AND T=6 THEN 2300 ' 16
2170 IF F=5 AND T=7 THEN 2300 ' 17
2180 IF F=5 AND T=8 THEN 2300 ' 18
2190 IF F=5 AND T=9 THEN 2300 ' 19
2200 IF F=6 AND T=5 THEN 2300 ' 20
2210 IF F=6 AND T=9 THEN 2300 ' 21
2220 IF F=7 AND T=8 THEN 2300 ' 22
2230 IF F=7 AND T=10 THEN 2300 ' 23
2240 IF F=8 AND T=7  THEN 2300 ' 24
2250 IF F=8 AND T=9  THEN 2300 ' 25
2260 IF F=8 AND T=10 THEN 2300 ' 26
2270 IF F=9 AND T=8  THEN 2300 ' 27
2280 IF F=9 AND T=10 THEN 2300 ' 28
2290 HM=0:RETURN
2300 IF P(F)=2 THEN 2290
2310 IF P(F)=1 AND P(T)=0 THEN HM=1:RETURN
2320 GOTO 2290
