10  ' hexapawn.bas - FREEWARE
20 GOTO 130 ' begin
30 SAVE"hexapawn":LIST-120
40 GOTO 1670 ' print pawns
50 GOTO 1750 ' obtain board position
60 GOTO 1890 ' simulate thinking
70 GOTO 1910 ' convert l to locate v,f
80 GOTO 1930 ' game board
90 GOTO 2190 ' print pawns 2
100 GOTO 2210 ' get key
110 GOTO 2240 ' info
120 ' begin
130 CLS:KEY OFF
140 PRINT TAB(32);"HEXAPAWN":C$=CHR$(219)+CHR$(219):H$=CHR$(178)+CHR$(178)
150 PRINT TAB(15);"GW-Basic by Eric F. Tchong - Aruba":PRINT:PRINT
160 DIM B(19,9),M(19,4),S(9),P$(3):W=0:L=0:DEFSTR Q:Q=MKI$(0)
170 DEF FNS(X)=-X*(X=2 OR X=5 OR X=8):DEF FNM(Y)=Y-INT(Y/10)*10:P$="X.O"
180 DEF FNR(X)=-3*(X=1)-(X=3)-4*(X=6)-6*(X=4)-7*(X=9)-9*(X=7)+FNS(X)
190 FOR I=1 TO 19:FOR J=1 TO 9:READ B(I,J):NEXT:NEXT
200 FOR I=1 TO 19:FOR J=1 TO 4:READ M(I,J):NEXT:NEXT
210 PRINT "Instructions (y/n)";
220 GOSUB 100:IF ASC(Q)=121 OR ASC(Q)=89 THEN 2240 ' y Y
230 ' draw game board                       1 2 3   -1 -1 -1
240 CLS:GOSUB 80                          ' 4 5 6    0  0  0
250 X=0:Y=0:S(4)=0:S(5)=0:S(6)=0          ' 7 8 9    1  1  1
260 S(1)=-1:S(2)=-1:S(3)=-1:S(7)=1:S(8)=1:S(9)=1
270 ' get human move
280 LOCATE 16,1:PRINT "-1 = exit"
290 LOCATE 17,1:GOSUB 90:LOCATE 15,1:GOSUB 90:LOCATE 15,1
300 INPUT "Your move from";M1:PRINT TAB(20); CHR$(30);
310 IF M1=-1 THEN 2520 ' exit
320 INPUT "to";M2:M1=M1+1:M2=M2+1
330 ' test for a valid human move.
340 IF M1=INT(M1) AND M2=INT(M2) AND M1>0 AND M1<10 AND M2>0 AND M2<10 THEN 380
350 PRINT TAB(27); CHR$(30);
360 PRINT "Illegal co-ordinates. Press key to resume..."
370 GOTO 410
380 IF S(M1)=1 THEN 420
390 PRINT TAB(27); CHR$(30);
400 PRINT "Illegal move......... Press key to resume...":BEEP
410 GOSUB 100:GOTO 280
420 IF S(M2)=1 THEN 390
430 IF M2-M1<>-3 AND S(M2)<>-1 THEN 390
440 IF M2>M1 THEN 390
450 IF M2-M1=-3 AND (S(M2)<>0) THEN 390
460 IF M2-M1<-4 THEN 390
470 IF M1=7 AND M2=3 THEN 390
480 ' upgrade graphics display. Check for human win.
490 S(M1)=0:S(M2)=1:GOSUB 40
500 IF S(1)=1 OR S(2)=1 OR S(3)=1 THEN 1370      ' human wins
510 ' if no computer pawns found, human wins
520 FOR I=1 TO 9
530  IF S(I)=-1 THEN I=11
540 NEXT
550 IF I=12 THEN 580
560 GOTO 1370
570 ' test board position
580 FOR I=1 TO 9
590  IF S(I)<>-1 THEN 680
600  IF S(I+3)=0 THEN I=11
610  IF FNR(I)=I THEN 670
620  IF I>3 THEN 650
630  IF S(5)=1 THEN I=11
640  GOTO 680
650  IF S(8)=1 THEN I=11
660  GOTO 680
670  IF S(I+2)=1 OR S(I+4)=1 THEN I=11
680 NEXT
690 IF I=12 THEN 720
700 GOTO 1370
710 ' search for model matching game board
720 FOR I=1 TO 19
730  EI=I
740  FOR J=1 TO 3
750   FOR K=3 TO 1 STEP -1
760    T((J-1)*3+K)=B(I,(J-1)*3+4-K)
770   NEXT
780  NEXT
790  FOR J=1 TO 9
800   IF S(J)<>B(I,J) THEN J=11
810  NEXT
820  IF J=12 THEN 840
830  R=0:I=30:GOTO 890
840  FOR J=1 TO 9
850   IF S(J)<>T(J) THEN J=12
860  NEXT
870  IF J=13 THEN 890
880  R=1:I=30
890 NEXT
900 IF I=31 THEN 940
910 ' the termination of this loop is impossible
920 PRINT "Illegal board pattern.":STOP
930 ' Search for nonzero move index
940 X=EI
950 FOR I=1 TO 4
960  IF M(X,I)<>0 THEN I=6
970 NEXT
980 IF I=7 THEN 1030
990 ' computer resigns
1000 LOCATE 18,1:PRINT "I resign"
1010 GOTO 1370
1020 ' computer moves randomly
1030 Y=INT(RND(1)*4+1):IF M(X,Y)=0 THEN 1030
1040 IF R<>0 THEN 1090
1050 LOCATE 17,1:PRINT "   I move from:";STR$(INT(M(X,Y)/10)-1);"  to:";
1060 PRINT STR$(FNM(M(X,Y))-1)
1070 S(INT(M(X,Y)/10))=0:S(FNM(M(X,Y)))=-1
1080 GOTO 1130
1090 LOCATE 17,1:PRINT "   I move from:";STR$(FNR(INT(M(X,Y)/10))-1);"  to:";
1100 PRINT STR$(FNR(FNM(M(X,Y)))-1)
1110 S(FNR(INT(M(X,Y)/10)))=0:S(FNR(FNM(M(X,Y))))=-1
1120 ' upgrade graphics display -  check for computer win
1130 GOSUB 60:GOSUB 40
1140 IF S(7)=-1 OR S(8)=-1 OR S(9)=-1 THEN 1470  ' computer wins
1150 ' if human pawns not found, computer wins
1160 FOR I=1 TO 9
1170  IF S(I)=1 THEN I=11
1180 NEXT
1190 IF I=12 THEN 1220
1200 GOTO 1470
1210 ' test board position
1220 FOR I=1 TO 9
1230  IF S(I)<>1  THEN 1320
1240  IF S(I-3)=0 THEN I=11                      ' next human move
1250  IF FNR(I)=I THEN 1310
1260  IF I<7 THEN 1290
1270  IF S(5)=-1  THEN I=11
1280  GOTO 1320
1290  IF S(2)=-1  THEN I=11
1300  GOTO 1320
1310  IF S(I-2)=-1 OR S(I-4)=-1 THEN I=11
1320 NEXT
1330 IF I=12 THEN 280
1340 ' computer wins by blocking
1350 LOCATE 19,1:PRINT "You can't move, so I win.":GOTO 1480
1360 ' human wins
1370 LOCATE 19,1:PRINT "You win"
1380 ' eliminate bad move - computer gets smarter
1390 M(X,Y)=0:L=L+1
1400 ' show game results
1410 LOCATE 20,1:GOSUB 90
1420 LOCATE 20,1:PRINT "I have won";W;"and you";L;"out of";L+W;"games."
1430 PRINT:PRINT "Press a key for a new game..."
1440 W$=INKEY$:IF W$="" THEN 1440
1450 GOTO 240
1460 ' computer wins
1470 LOCATE 19,1:PRINT "I win"
1480 W=W+1:GOTO 1410
1490 ' list of move indices
1500 DATA -1,-1,-1,1,0,0,0,1,1,-1,-1,-1,0,1,0,1,0,1
1510 DATA -1,0,-1,-1,1,0,0,0,1,0,-1,-1,1,-1,0,0,0,1
1520 DATA -1,0,-1,1,1,0,0,1,0,-1,-1,0,1,0,1,0,0,1
1530 DATA 0,-1,-1,0,-1,1,1,0,0,0,-1,-1,-1,1,1,1,0,0
1540 DATA -1,0,-1,-1,0,1,0,1,0,0,-1,-1,0,1,0,0,0,1
1550 DATA 0,-1,-1,0,1,0,1,0,0,-1,0,-1,1,0,0,0,0,1
1560 DATA 0,0,-1,-1,-1,1,0,0,0,-1,0,0,1,1,1,0,0,0
1570 DATA 0,-1,0,-1,1,1,0,0,0,-1,0,0,-1,-1,1,0,0,0
1580 DATA 0,0,-1,-1,1,0,0,0,0,0,-1,0,1,-1,0,0,0,0
1590 DATA -1,0,0,-1,1,0,0,0,0
1600 ' list of model designator values
1610 DATA 24,25,36,0,14,15,36,0,15,35,36,47,36,58,59,0
1620 DATA 15,35,36,0,24,25,26,0,26,57,58,0
1630 DATA 26,35,0,0,47,48,0,0,35,36,0,0,35,36,0,0
1640 DATA 36,0,0,0,47,58,0,0,15,0,0,0
1650 DATA 26,47,0,0,47,58,0,0,33,36,47,0,28,58,0,0,15,47,0,0
1660 ' print pawns
1670 EX=0
1680 FOR I=1 TO 3
1690  FOR J=1 TO 3
1700   EC$=MID$(P$,S((I-1)*3+J)+2,1):GOSUB 50:PRINT PK$:EX=EX+1
1710  NEXT
1720 NEXT
1730 COLOR 7,0:RETURN
1740 ' obtain board position
1750 IF EC$="X" THEN PK$=C$:COLOR 12,0:GOTO 1780
1760 IF EC$="O" THEN PK$=H$:COLOR 14,0:GOTO 1780
1770 IF EC$="." THEN PK$="  "
1780 IF EX=0 THEN LOCATE  3,20:RETURN
1790 IF EX=1 THEN LOCATE  3,32:RETURN
1800 IF EX=2 THEN LOCATE  3,44:RETURN
1810 IF EX=3 THEN LOCATE  7,20:RETURN
1820 IF EX=4 THEN LOCATE  7,32:RETURN
1830 IF EX=5 THEN LOCATE  7,44:RETURN
1840 IF EX=6 THEN LOCATE 11,20:RETURN
1850 IF EX=7 THEN LOCATE 11,32:RETURN
1860 IF EX=8 THEN LOCATE 11,44
1870 RETURN
1880 ' simulate thinking
1890 T=TIMER +1.5:WHILE TIMER<T:WEND:RETURN
1900 ' convert l to locate v, f
1910 V=INT(LE/64)+1:F=(LE-(V-1)*64)+1:LOCATE V,F :RETURN
1920 ' game board
1930 LOCATE 1,14:COLOR 11,0
1940 PRINT "ษอออออออออออหอออออออออออหอออออออออออป":LOCATE 2,14
1950 PRINT "บ           บ           บ           บ":LOCATE 3,14
1960 PRINT "บ           บ           บ           บ":LOCATE 4,14
1970 PRINT "บ           บ           บ           บ":LOCATE 5,14
1980 PRINT "ฬอออออออออออฮอออออออออออฮอออออออออออน":LOCATE 6,14
1990 PRINT "บ           บ           บ           บ":LOCATE 7,14
2000 PRINT "บ           บ           บ           บ":LOCATE 8,14
2010 PRINT "บ           บ           บ           บ":LOCATE 9,14
2020 PRINT "ฬอออออออออออฮอออออออออออฮอออออออออออน":LOCATE 10,14
2030 PRINT "บ           บ           บ           บ":LOCATE 11,14
2040 PRINT "บ           บ           บ           บ":LOCATE 12,14
2050 PRINT "บ           บ           บ           บ":LOCATE 13,14
2060 PRINT "ศอออออออออออสอออออออออออสอออออออออออผ"
2070 ' Print 0 1 2 3 4 5 6 7 8.
2080 FOR K=0 TO 2
2090  FOR EQ=0 TO 2
2100   LE=78+K*256+12*EQ:GOSUB 70:PRINT 3*K+EQ
2110  NEXT
2120 NEXT
2130 ' print pawns 2
2140 COLOR 12,0:LOCATE 3, 20:PRINT C$:LOCATE 3, 32:PRINT C$
2150 LOCATE 3, 44:PRINT C$
2160 COLOR 14,0:LOCATE 11,20:PRINT H$:LOCATE 11,32:PRINT H$
2170 LOCATE 11,44:PRINT H$:COLOR 7,0:RETURN
2180 ' clear line
2190 PRINT STRING$(79,32):RETURN
2200 ' get key
2210 LSET Q=MKI$(0)
2220 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND:RETURN
2230 ' instructions
2240 CLS:PRINT "This program plays the game of hexapawn."
2250 PRINT "Hexapawn is played with chess pawns on a 3 by 3 board."
2260 PRINT "The pawns are moved as in chess. One space forward to"
2270 PRINT "an empty space or one space forward and diagonally to"
2280 PRINT "capture an opposing man.":PRINT
2290 PRINT "On the board, your pawns are "; :COLOR 14,0:PRINT H$;:COLOR 7,0
2300 PRINT " and the computer's pawns are ";:COLOR 12,0:PRINT C$ :COLOR 7,0
2310 PRINT:PRINT "To enter a move:"
2320 PRINT "Type the number of the square you are moving from, press <Enter>"
2330 PRINT "Type the mumber of the square you will move to,    press <Enter>"
2340 PRINT:PRINT "Press any key to continue..."
2350 W$=INKEY$:IF W$="" THEN 2350 ELSE CLS
2360 PRINT "The computer starts a series of games knowing only when"
2370 PRINT "it has no strategy at first and just moves randomly."
2380 PRINT "However, it learns from each game. Thus, it becomes"
2390 PRINT "more and more difficult. Also, to help offset your"
2400 PRINT "initial advantage, you will not be told how to win the"
2410 PRINT "game but must learn this by playing."
2420 PRINT:PRINT "The numbering of the board is as follows:"
2430 PRINT TAB(10);"012":PRINT TAB(10);"345":PRINT TAB(10);"678"
2440 PRINT:PRINT "For example, to move your rightmost pawn"
2450 PRINT "forward, you would type 8 <Enter>, 5<Enter>."
2460 PRINT "Since I'm a good sport, you'll always go first."
2470 PRINT:PRINT:COLOR 11,0
2480 PRINT "Press any key to continue..."
2490 W$=INKEY$:IF W$="" THEN 2490 ELSE CLS
2500 GOTO 240
2510 ' exit
2520 KEY 5,"hexapawn.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS
2530 ' HEXAPAWN. Interpretation of hexapawn game as presented in
2540 ' Martin Gardner's "The unexpected hanging and other mathematic-
2550 ' al diversions", Chapter eight:  A matchbox game-learning machine
2560 ' Original version for HP Timeshare system by R.A. Kaapke 5/5/76
2570 ' Instructions by Jeff Dalton
2580 ' Conversion to MITS Basic by Steve North
2590 ' Creative Computing!  Morristown,  New Jersey
