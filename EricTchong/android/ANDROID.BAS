10  ' Android.bas - FREEWARE
20 GOTO 150 ' begin
30 SAVE "android.bas":LIST-130
40 GOTO 1580 ' calculate TColumn + TRow
50 GOTO 1650 ' calculate location of android
60 GOTO 1690 ' print frames
70 GOTO 1840 ' paint android
80 GOTO 1960 ' clear android
90 GOTO 2020 ' set BC to 1
100 GOTO 2060 ' character input + get N
110 GOTO 2140 ' set BF(1)..B(9) to 1
120 GOTO 2540 ' trs80 @ to gw-basic locate converter
130 GOTO 2570 ' get key input
140 ' begin
150 CLS:KEY OFF:SCREEN 0:COLOR 15,0
160 PRINT "  ***************************"
170 PRINT "  * ANDROID PICTURE GALLERY *"
180 PRINT "  *   TRS-80 by M.K. Cook   *"
190 PRINT "  * GW-Basic by Eric Tchong *"
200 PRINT "  *      Freeware 2004      *"
210 PRINT "  ***************************"
220 RANDOMIZE TIMER
230 DEFINT A-Z:DEFSTR Q:Q=MKI$(0)
240 DIM PA(9,4),FG$(1,31),SG$(15)
250 FOR A=1 TO 9:READ RT(A):NEXT              ' 3 6 9  2 5 8  1 4 7
260 FOR A=1 TO 31:READ FG$(0,A),FG$(1,A):NEXT ' full game
270 FOR A=1 TO 15:READ SG$(A):NEXT            ' simple game
280 PRINT:PRINT:PRINT "   Show us the rules ? (y/n) "
290 GOSUB 130 ' get a key 121 = y  89 =Y
300 IF ASC(Q)=121 OR ASC(Q)=89 THEN 310 ELSE 440
310 CLS:COLOR 11,0
320 PRINT"You are the curator of the Android Gallery!":PRINT
330 PRINT"  In the Simple Game you have to clear the"
340 PRINT"  Gallery ready for the exhibition. You do"
350 PRINT"  this by using  your anti-android duster."
360 PRINT"  This will clear  an  occupied  frame but"
370 PRINT"  unfortunately  frames  near  by  will be"
380 PRINT"  reversed. Corner -Center-  Middle of row"
390 PRINT"  each produce a different  but consistent"
400 PRINT"  pattern of change.":PRINT:COLOR 12,0
410 PRINT"  In the Full Game you have to get all the"
420 PRINT"  given frames occupied by Happy Androids."
430 PRINT"  They are not happy out of a frame.  [<>]"
440 COLOR 14,0:PRINT
450 PRINT"  Type   a 's' for the Simple Game."
460 PRINT"  Type any key for the Full Version."
470 GOSUB 130:DG=ASC(Q):PRINT:IF ASC(Q)=121 OR ASC(Q)=89 THEN 520
480 PRINT"  Do you want to enter your own"
490 PRINT"  starting positions ? <y/n>";
500 GOSUB 130:DA=ASC(Q) ' get key
510 ' Set up face string
520 FOR N=2 TO 7
530  F$(N)="":FOR N1=1 TO 8:READ T:F$(N)=F$(N)+CHR$(T):NEXT
540 NEXT
550 ' Read 36 positions androids
560 FOR N=1 TO 9
570  FOR N1=1 TO 4:READ PA(N,N1):NEXT
580 NEXT
590 ' Enter your android positions
600 CLS:COLOR 15,0
610 IF DA=121 OR DA=89 THEN 620 ELSE 790
620 FOR N=1 TO 9:BC(N)=0:NEXT
630 PRINT "Type in Android positions"
640 PRINT "Type + when finished."
650 PRINT:PRINT:PRINT "Androids at -";
660 GOSUB 100
670 IF ASC(Q)=43 THEN 690         ' 43 = +
680 BC(N)=1:GOTO 660
690 FOR N=1 TO 9:BF(N)=1:NEXT     ' set to 1
700 CLS
710 IF DG=115 OR DG=83 THEN 1040  ' s = 115  83 = S
720 FOR N=1 TO 9:BF(N)=0:NEXT ' reset to 0
730 ' Enter your frame positions
740 PRINT "Enter Frame positions":PRINT "Type + when finished.":PRINT
750 PRINT "Frames are at - ";
760 GOSUB 100 ' get character + N
770 IF ASC(Q)=43 THEN CLS:GOTO 1040
780 BF(N)=1:GOTO 760
790 NA=1:NF=0
800 FOR N=1 TO 9:BC(N)=0:BF(N)=0:NEXT
810 IF CH=1 THEN 2620
820 IF CH=2 THEN CLS:GOTO 900
830 ' TT$=trials - Full Game
840 CLS
850 PRINT "<1> Player   selects the game"
860 PRINT "<2> Computer selects the game" 
870 PRINT "    Choose 1,2 ?"
880 GOSUB 130:CH=VAL(Q):IF CH<1 OR CH>2 THEN BEEP:GOTO 840
890 IF CH=1 THEN 2620 ELSE CLS:GOTO 900
900 IF DG=115 THEN 2700 ' computer selects simple game
910 C=INT(RND*31)+1
920 A$=FG$(1,C):TT$=RIGHT$(A$,2)
930 GOSUB 90 ' set BC to 1
940 FOR N=1 TO 9:BF(N)=BC(N):NEXT
950 FOR A=1 TO 9:BC(A)=0:NEXT
960 A$=FG$(0,C)+"  "
970 GOSUB 90 ' set BC to 1
980 ' Rotate 1 to 4 times
990 FOR N=1 TO FIX(RND*4)+1
1000  FOR A=1 TO 9:TF(RT(A))=BF(A):TC(RT(A))=BC(A):NEXT
1010  FOR A=1 TO 9:BC(A)=TC(A):BF(A)=TF(A):NEXT
1020 NEXT
1030 ' TN=Turn Number
1040 TN=0
1050 FOR F=1 TO 9
1060  IF BF(F)=1 THEN GOSUB 60 ' print frames
1070 NEXT
1080 FOR F=1 TO 9
1090  IF BC(F)=1 THEN GOSUB 70 ' print faces
1100 NEXT
1110 LOCATE 1,39
1120 IF DG=115 THEN PRINT "CLEAR THE GALLERY" ELSE PRINT "ANDROID GALLERY"
1130 LOCATE 3,39:PRINT "   7   8   9 "
1140 LOCATE 4,39:PRINT "   4   5   6 "
1150 LOCATE 5,39:PRINT "   1   2   3 "
1160 LOCATE 7,39:IF DA$<>"y" THEN PRINT "Can be completed in ";TT$;" turns."
1170 LOCATE 9,39:PRINT "Turn number   ";TN
1180 LOCATE 12,39:PRINT "R   = Reboot game"
1190 LOCATE 13,39:PRINT "N   = New  game
1200 LOCATE 14,39:PRINT "Esc = Exit game"
1210 LOCATE 16,39:PRINT "Game #";C
1220 LOCATE 10,39:PRINT "Enter number ?":LOCATE 10,54
1230 ' Enter a number
1240 GOSUB 130 ' get key
1250 TN=TN+1
1260 IF ASC(Q)=114 OR ASC(Q)=82 THEN RUN ' 114 = r  82 = R
1270 IF ASC(Q)=110 OR ASC(Q)=78 THEN 600 ' 110 = n  78 = N
1280 IF ASC(Q)=27 THEN 2720 ' 27  = Esc exits
1290 F=VAL(Q)
1300 LOCATE 10,54:PRINT Q   ' number pressed
1310 LOCATE 9,53 :PRINT TN  ' turn number
1320 IF F>6 THEN F=F-6:GOTO 1340
1330 IF F<4 THEN F=F+6
1340 IF BC(F)=0 THEN 1240 
1350 EC=F:BC(F)=0:GOSUB 80  ' clear android when key pressed
1360 FOR N2=1 TO 4
1370  F=PA(EC,N2)
1380  IF F=0 THEN 1400
1390  IF BC(F)=0 THEN BC(F)=1:GOSUB 70 ELSE BC(F)=0:GOSUB 80
1400 NEXT
1410 ET=1:AC=1
1420 FOR N=1 TO 9
1430  IF BC(N)<>BF(N) THEN ET=0
1440  IF BC(N)=1 THEN AC=0
1450 NEXT
1460 IF AC=1 AND DG<>115 THEN 1550 ' 115 = s
1470 IF AC=1 AND DG=115  THEN 1500
1480 IF ET=0 THEN 1240
1490 ' Riddle solved
1500 LOCATE 17,39:PRINT "That's it !!! "
1510 FOR J=1 TO 2:SOUND 700,3:SOUND 500,3:NEXT
1520 LOCATE 18,39:PRINT "Hit key for new game"
1530 GOSUB 130:GOTO 600 ' wait key
1540 ' Unable to win
1550 LOCATE 17,39:PRINT "You can't win now !!!":SOUND 523.25, 18.2
1560 GOTO 1520
1570 ' Calculate TColumn + TRow
1580 TC=F:TR=1                  ' 7 8 9
1590 IF TC<4 THEN 1620          ' 4 5 6
1600 TC=TC-3:TR=TR+1            ' 1 2 3
1610 GOTO 1590
1620 TC=TC-1:TR=TR-1
1630 RETURN
1640 ' Calculate location of android
1650 X=(12*TC)+2                ' if 2=1 all androids move 1 step to the left
1660 IF TC=2  THEN X=X+0        ' if 0=1 androids in column 3 6 9
1670 Y=64*(TR*6)+1:L=X+Y:RETURN ' move 1 step to the right
1680 ' Print frames
1690 ON F GOTO 1700,1710,1720,1730,1740,1750,1760,1770,1780
1700 X=1 :Y=3 :GOTO 1790
1710 X=1 :Y=15:GOTO 1790
1720 X=1 :Y=27:GOTO 1790
1730 X=7 :Y=3 :GOTO 1790
1740 X=7 :Y=15:GOTO 1790
1750 X=7 :Y=27:GOTO 1790
1760 X=13:Y=3 :GOTO 1790
1770 X=13:Y=15:GOTO 1790
1780 X=13:Y=27
1790 COLOR 14,0:LOCATE X,Y  :PRINT "ÉÍÍÍÍÍÍÍÍ»"
1800 FOR N=1 TO 4:LOCATE X+N,Y:PRINT "º        º":NEXT ' 8 spaces
1810 LOCATE X+5,Y:PRINT "ÈÍÍÍÍÍÍÍÍ¼"
1820 RETURN
1830 ' Print android
1840 GOSUB 40 ' calculate TColumn + TRow
1850 GOSUB 50 ' calculate location of android
1860 L=L+64:GOSUB 120  ' happy / angry hair
1870 IF BF(F)=1 THEN COLOR 10,0:PRINT F$(2) ELSE COLOR 12,0 :PRINT F$(7)
1880 L=L+64:GOSUB 120  ' ear eye nose eye ear
1890 PRINT F$(3)
1900 L=L+64:GOSUB 120  ' happy / angry mouth
1910 IF BF(F)=1 THEN PRINT F$(4) ELSE PRINT F$(6)
1920 L=L+64:GOSUB 120  ' foot
1930 PRINT F$(5)
1940 COLOR 15,0:RETURN
1950 ' Clear android
1960 GOSUB 40:GOSUB 50 ' calculate position
1970 FOR N=1 TO 4
1980  L=L+64:GOSUB 120:PRINT STRING$(8,32)
1990 NEXT
2000 RETURN
2010 ' Init BC to 1
2020 L=LEN(A$)-2
2030 FOR A=1 TO L:BC(VAL(MID$(A$,A,1)))=1:NEXT
2040 RETURN
2050 ' Character input subroutine
2060 GOSUB 130 ' get key
2070 IF ASC(Q)=120 THEN RETURN ' 120 = x
2080 N=VAL(Q)
2090 IF N>6 THEN N=N-6:GOTO 2110
2100 IF N<4 THEN N=N+6
2110 PRINT Q;",";
2120 RETURN
2130 ' Reset to 1
2140 FOR A=1 TO 9:BF(A)=1:NEXT :RETURN
2150 ' Columns 3 2 1
2160 DATA 3,6,9,2,5,8,1,4,7
2170 ' Full games
2180 DATA 1,2345678913,1346,789 5,25,12345610  : ' 1 2 3
2190 DATA 25,134678911,3,159 3,134679,124579 1 : ' 4 5 6
2200 DATA 124,3678910,5,1234678911,456,12310   : ' 7 8 9
2210 DATA 1379,5 9,9,1 8,12346789,5 5          : ' 10 11 12
2220 DATA 2,5 8,12358,12346789 7,5,2 4         : ' 13 14 15
2230 DATA 5,1379 9,2,1345678911,5,46 7         : ' 16 17 18
2240 DATA 258,2468 7,19,1 6,8,1238 7           : ' 19 20 21
2250 DATA 1,36789 8,124,3678910,19,37 8        : ' 22 23 24
2260 DATA 5,19 7,5,456 8,258,134679 9          : ' 25 26 27
2270 DATA 19,137910,258,12346789 3,357,159 8   : ' 28 29 30
2280 DATA 1,37 4                               : ' 31
2290 ' Simple games
2300 DATA 13579 9,1 6,13789 5    : ' 1 2 3
2310 DATA 2468 4,135 5,1234678 4 : ' 4 5 6
2320 DATA 138 5,2 9,137 4        : ' 7 8 9
2330 DATA 5 5,123456789 5,159 3  : ' 10 11 12
2340 DATA 37 6,1289 8,12358 3    : ' 13 14 15
2350 ' Android parts
2360 DATA  32,223,191, 32, 32,218,223, 32 :'f$(2) happy hair
2370 DATA  32,123,147, 47, 92,147,125, 32 :'f$(3) ear eye nose eye ear
2380 DATA  32,222,220,220,220,220,221, 32 :'f$(4) happy mouth
2390 DATA  32,220,220,254,254,220,220, 32 :'f$(5) foot
2400 DATA  32,222,223,223,223,223,221, 32 :'f$(6) angry mouth
2410 DATA  32, 32,218,254,254,191, 32, 32 :'f$(7) angry hair
2420 ' ß¿  Úß happy hair
2430 ' {“/\“} ear eye nose eye ear
2440 ' ÞÜÜÜÜÝ happy mouth
2450 ' ÜÜþþÜÜ foot
2460 ' ÞßßßßÝ angry mouth
2470 '  Úþþ¿  angry hair
2480 REM
2490 ' 36 positions androids
2500 DATA 2,4,5,0,1,3,0,0,2,5,6,0
2510 DATA 0,1,7,0,2,8,4,6,3,9,0,0
2520 DATA 4,5,8,0,7,9,0,0,5,6,8,0
2530 ' TRS80 @ to GWBasic LOCATE
2540 V=INT(L/64)+1:Z=(V-1)*64:Z=(L-Z)+1
2550 LOCATE V,Z:RETURN
2560 ' Get key pressed
2570 LSET Q=MKI$(0)
2580 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND
2590 IF ASC(Q)=27 THEN 2720 ' exit anytime
2600 RETURN
2610 ' Player selects simple or full game
2620 IF DG=115 THEN 2630 ELSE 2660
2630 CLS:INPUT "Choose simple game 1-15";C
2640 IF C<1 OR C>15 THEN BEEP:GOTO 2630
2650 A$=SG$(C):TT$=RIGHT$(A$,2):GOSUB 90:GOSUB 110:CLS:GOTO 990
2660 CLS:INPUT "Choose full game 1-31";C
2670 IF C<1 OR C>31 THEN BEEP:GOTO 2660
2680 CLS:GOTO 920
2690 ' Computer chooses a simple game
2700 C=INT(RND*15)+1:GOTO 2650
2710 ' Exit
2720 KEY 5,"android.bas":KEY 6,CHR$(34)+",a":KEY ON
2730 COLOR 7,0:CLS
2740 ' ANDROID PICTURE GALLERY BY M.K.COOK G8HBR
2750 ' Converted from TRS-80 to GW-Basic
2760 ' By Eric F. Tchong P43EC - Aruba
2770 ' April 26, 1991
