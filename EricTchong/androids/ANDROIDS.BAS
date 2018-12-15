10  ' androids.bas - FREEWARE 2004
20 GOTO 150 ' begin
30 SAVE "androids.bas":LIST-130
40 GOTO 1760 ' calculate TColumn + TRow
50 GOTO 1820 ' calculate location of android
60 GOTO 1860 ' print frames
70 GOTO 2040 ' paint android
80 GOTO 2150 ' clear android
90 GOTO 2200 ' reset faces (BC) to 1
100 GOTO 2220 ' number input routine
110 GOTO 2270 ' reset frames BF(1)..B(9) to 1
120 GOTO 2290 ' trs80 @ to gw-basic locate converter
130 GOTO 2310 ' get key input
140 ' begin
150 CLS:KEY OFF:SCREEN 0:COLOR 15,0
160 PRINT "  ***************************"
170 PRINT "  * ANDROID PICTURE GALLERY *"
180 PRINT "  *   TRS-80 by M.K. Cook   *"
190 PRINT "  * GW-Basic by Eric Tchong *"
200 PRINT "  *     with auto solver    *"
210 PRINT "  ***************************"
220 RANDOMIZE TIMER:DEFINT A-Z:DEFSTR Q:Q=MKI$(0)
230 DIM PA(9,4),FG$(1,31),SG$(15),SF$(31,4),SS$(15,4)
240 FOR A=1 TO 9:READ RT(A):NEXT              ' 3 6 9  2 5 8  1 4 7
250 FOR A=1 TO 31:READ FG$(0,A),FG$(1,A):NEXT ' full games
260 FOR A=1 TO 15:READ SG$(A):NEXT            ' simple games
270 PRINT:PRINT "   Enter * n/N  for NO SOUND ":GOSUB 130 ' Enter n N
280 IF ASC(Q)=13 OR ASC(Q)=110 OR ASC(Q)=78 THEN NS=0 ELSE NS=1
290 PRINT:PRINT "   Show us the rules ? (y/n) ":GOSUB 130 ' y Y
300 IF ASC(Q)=121 OR ASC(Q)=89 THEN 310 ELSE 450
310 CLS:COLOR 15,0
320 PRINT"You are the curator of the Android Gallery!"
330 COLOR 11,0:PRINT
340 PRINT"  In the Simple Game you have to clear the"
350 PRINT"  Gallery ready for the exhibition. You do"
360 PRINT"  this by using  your anti-android duster."
370 PRINT"  This will clear  an  occupied  frame but"
380 PRINT"  unfortunately  frames  near  by  will be"
390 PRINT"  reversed. Corner -Center-  Middle of row"
400 PRINT"  each produce a different  but consistent"
410 PRINT"  pattern of change.":PRINT:COLOR 12,0
420 PRINT"  In the Full Game you have to get all the"
430 PRINT"  given frames occupied by Happy Androids."
440 PRINT"  They are not happy out of a frame.  [<>]"
450 COLOR 14,0:PRINT
460 PRINT"  Type   a 's' for the Simple Game."
470 PRINT"  Type any key for the Full Version."
480 GOSUB 130:DG=ASC(Q) ' get key
490 PRINT:PRINT"  Do you want to enter your own"
500 PRINT"  starting positions ? <y/n>";
510 GOSUB 130:DA=ASC(Q) ' get key
520 ' set up faces from android parts
530 FOR N=2 TO 7
540  F$(N)="":FOR N1=1 TO 8:READ T:F$(N)=F$(N)+CHR$(T):NEXT
550 NEXT
560 ' read 36 positions androids
570 FOR N=1 TO 9
580  FOR N1=1 TO 4:READ PA(N,N1):NEXT
590 NEXT
600 ' read solutions
610 FOR A=1 TO 31:FOR R=1 TO 4:READ SF$(A,R):NEXT:NEXT ' solutions fg
620 FOR A=1 TO 15:FOR R=1 TO 4:READ SS$(A,R):NEXT:NEXT ' solutions sg
630 ' enter your android positions
640 CLS:COLOR 15,0
650 IF DA=121 OR DA=89 THEN 660 ELSE 860 ' y Y
660 FOR N=1 TO 9:BC(N)=0:NEXT
670 PRINT "Type in Android positions"
680 PRINT "Type + when finished.":PRINT
690 PRINT "Androids at -";
700 GOSUB 100:IF ASC(Q)=43 THEN 730      ' +
710 BC(N)=1                              ' mark face in use
720 GOTO 700                             ' get next android
730 FOR N=1 TO 9:BF(N)=1:NEXT            ' reset to 1
740 CLS:WS=1                             ' WS skips L + A
750 IF DG=115 OR DG=83 THEN 1120         ' s S
760 FOR N=1 TO 9:BF(N)=0:NEXT            ' reset to 0
770 ' enter your frame positions
780 PRINT "Enter Frame positions"
790 PRINT "Type + when finished.":PRINT
800 PRINT "Frames are at -";
810 GOSUB 100
820 IF ASC(Q)=43 THEN CLS:GOTO 1120      ' print board
830 BF(N)=1                              ' mark frame in use
840 GOTO 810                             ' get next frame
850 ' get choices
860 NA=1:NF=0
870 FOR N=1 TO 9:BC(N)=0:BF(N)=0:NEXT
880 IF CH=1 THEN 2380                    ' player's   choice
890 IF CH=2 THEN CLS:GOTO 970            ' computer's choice
900 ' TT$=trials - full game or simple game
910 CLS
920 PRINT "<1> Player   selects the game"
930 PRINT "<2> Computer selects the game" 
940 PRINT "    Choose 1,2 ?"
950 GOSUB 130:CH=VAL(Q):IF CH<1 OR CH>2 THEN BEEP:GOTO 910
960 IF CH=1 THEN 2380 ELSE CLS       ' player selects simple or full game
970 IF DG=115 THEN 2360            ' computer selects simple game
980 C=INT(RND*31)+1:SR=1
990 A$=FG$(1,C):TT$=RIGHT$(A$,2)
1000 GOSUB 90 ' set BC to 1
1010 FOR N=1 TO 9:BF(N)=BC(N):NEXT
1020 FOR A=1 TO 9:BC(A)=0:NEXT
1030 A$=FG$(0,C)+"  "
1040 GOSUB 90                  ' reset faces (BC) to 1
1050 ' rotate 1 to 4 times
1060 IF SR=0 THEN 1070 ELSE RT=FIX(RND*4)+1
1070 FOR N=1 TO RT
1080  FOR A=1 TO 9:TF(RT(A))=BF(A):TC(RT(A))=BC(A):NEXT
1090  FOR A=1 TO 9:BC(A)=TC(A):BF(A)=TF(A):NEXT
1100 NEXT
1110 ' print board
1120 TN=0
1130 FOR F=1 TO 9
1140  IF BF(F)=1 THEN GOSUB 60 ' print frames
1150 NEXT
1160 FOR F=1 TO 9
1170  IF BC(F)=1 THEN GOSUB 70 ' print faces
1180 NEXT
1190 LOCATE 1,39
1200 IF DG=115 THEN PRINT "CLEAR THE GALLERY" ELSE PRINT "ANDROID GALLERY"
1210 LOCATE 3,39:PRINT "   7   8   9 "
1220 LOCATE 4,39:PRINT "   4   5   6 "
1230 LOCATE 5,39:PRINT "   1   2   3 "
1240 LOCATE 7,39:IF DA$<>"y" THEN PRINT "Can be completed in ";TT$;" turns."
1250 LOCATE 9,39:PRINT "Turn number   ";TN
1260 LOCATE 11,39:PRINT "L   = Learn game"
1270 LOCATE 12,39:PRINT "A   = Auto solve"
1280 LOCATE 13,39:PRINT "R   = Reboot game"
1290 LOCATE 14,39:PRINT "N   = New  game
1300 LOCATE 15,39:PRINT "Esc = Exit game"
1310 LOCATE 17,39:PRINT "Game #";C
1320 LOCATE 10,39:PRINT "Enter number ?":SW=0
1330 ' enter a number
1340 GOSUB 130 ' get key
1350 TN=TN+1:IF SW=1 THEN 1380 ELSE IF WS=1 THEN 1380
1360 IF ASC(Q)= 97 OR ASC(Q)=65 THEN 2520 ' a A auto solve
1370 IF ASC(Q)=108 OR ASC(Q)=76 THEN 1730 ' l L learn game
1380 IF ASC(Q)=114 OR ASC(Q)=82 THEN RUN  ' r R reboot
1390 IF ASC(Q)=110 OR ASC(Q)=78 THEN 640  ' n N new game
1400 IF ASC(Q)=27 THEN 3620               ' Esc exits
1410 IF ASC(Q)<49 OR ASC(Q)>57 THEN TN=TN-1:GOTO 1340
1420 F=VAL(Q):SW=1
1430 LOCATE 10,54:PRINT Q     ' number pressed
1440 LOCATE 9,53 :PRINT TN    ' turn number
1450 IF F>6 THEN F=F-6:GOTO 1470
1460 IF F<4 THEN F=F+6
1470 IF BC(F)=0 THEN 1340 
1480 EC=F:BC(F)=0:GOSUB 80    ' clear android when key pressed
1490 FOR N2=1 TO 4
1500  F=PA(EC,N2)
1510  IF F=0 THEN 1530
1520  IF BC(F)=0 THEN BC(F)=1:GOSUB 70 ELSE BC(F)=0:GOSUB 80
1530 NEXT
1540 ET=1:AC=1
1550 FOR N=1 TO 9
1560  IF BC(N)<>BF(N) THEN ET=0
1570  IF BC(N)=1 THEN AC=0
1580 NEXT
1590 IF AC=1 AND DG<>115 THEN 1690 ' s
1600 IF AC=1 AND DG=115  THEN 1630
1610 IF ET=0 THEN 1340
1620 ' riddle solved
1630 IF NS=1 THEN 1640 ELSE 1650
1640 FOR J=1 TO 3:SOUND 700,3:SOUND 500,3:NEXT
1650 LOCATE 17,39:PRINT "That's it !!! "
1660 LOCATE 18,39:PRINT "Hit key for new game"
1670 GOSUB 130:GOTO 640
1680 ' unable to win
1690 LOCATE 17,39:PRINT "You can't win now !!!"
1700 IF NS=1 THEN 1710 ELSE 1660
1710 SOUND 523.25, 18.2:GOTO 1660
1720 ' learn by typing solution
1730 IF DG=115 THEN EC$=SS$(C,RT) ELSE EC$=SF$(C,RT)
1740 LOCATE 20,3:PRINT "Type ---> ";EC$:TN=TN-1:GOTO 1340
1750 ' calculate TColumn + TRow
1760 TC=F:TR=1                  ' 7 8 9
1770 IF TC<4 THEN 1800          ' 4 5 6
1780 TC=TC-3:TR=TR+1            ' 1 2 3
1790 GOTO 1770
1800 TC=TC-1:TR=TR-1:RETURN
1810 ' calculate location of android
1820 X=(12*TC)+2                ' if 2=1 all androids move 1 step to the left
1830 IF TC=2  THEN X=X+0        ' if 0=1 androids in column 3 6 9
1840 Y=64*(TR*6)+1:L=X+Y:RETURN ' move 1 step to the right
1850 ' print frames
1860 ON F GOTO 1870,1880,1890,1900,1910,1920,1930,1940,1950
1870 X=1 :Y=3 :GOTO 1960
1880 X=1 :Y=15:GOTO 1960
1890 X=1 :Y=27:GOTO 1960
1900 X=7 :Y=3 :GOTO 1960
1910 X=7 :Y=15:GOTO 1960
1920 X=7 :Y=27:GOTO 1960
1930 X=13:Y=3 :GOTO 1960
1940 X=13:Y=15:GOTO 1960
1950 X=13:Y=27
1960 COLOR 14,0
1970 LOCATE X,Y   :PRINT "ÉÍÍÍÍÍÍÍÍ»"
1980 FOR N=1 TO 4
1990  LOCATE X+N,Y:PRINT "º        º"  ' 8 spaces
2000 NEXT
2010 LOCATE X+5,Y :PRINT "ÈÍÍÍÍÍÍÍÍ¼"
2020 RETURN
2030 ' print android
2040 GOSUB 40 ' calculate TColumn + TRow
2050 GOSUB 50 ' calculate location of android
2060 L=L+64:GOSUB 120              ' happy / angry hair
2070 IF BF(F)=1 THEN COLOR 10,0:PRINT F$(2) ELSE COLOR 12,0 :PRINT F$(7)
2080 L=L+64:GOSUB 120              ' ear eye nose eye ear
2090 PRINT F$(3)
2100 L=L+64:GOSUB 120              ' happy / angry mouth
2110 IF BF(F)=1 THEN PRINT F$(4) ELSE PRINT F$(6)
2120 L=L+64:GOSUB 120              ' foot
2130 PRINT F$(5):COLOR 15,0:RETURN
2140 ' clear android
2150 GOSUB 40:GOSUB 50             ' calculate position
2160 FOR N=1 TO 4
2170  L=L+64:GOSUB 120:PRINT STRING$(8,32)
2180 NEXT:RETURN
2190 ' init BC to 1
2200 L=LEN(A$)-2:FOR A=1 TO L:BC(VAL(MID$(A$,A,1)))=1:NEXT:RETURN
2210 ' number input routine
2220 GOSUB 130:N=VAL(Q)
2230 IF N>6 THEN N=N-6:GOTO 2250
2240 IF N<4 THEN N=N+6
2250 PRINT Q;",";:RETURN
2260 ' reset frames to 1
2270 FOR A=1 TO 9:BF(A)=1:NEXT:RETURN
2280 ' trs80 @ to gwbasic locate
2290 V=INT(L/64)+1:Z=(V-1)*64:Z=(L-Z)+1:LOCATE V,Z:RETURN
2300 ' get key pressed
2310 LSET Q=MKI$(0)
2320 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND
2330 IF ASC(Q)=27 THEN 3620        ' exit anytime
2340 RETURN
2350 ' computer selects a simple game
2360 C=INT(RND*15)+1:SR=1:GOTO 2470
2370 ' player selects simple or full game
2380 IF DG=115 THEN 2390 ELSE 2490
2390 CLS:INPUT "Choose simple game 1-15";C
2400 IF C<1 OR C>15 THEN BEEP:GOTO 2390
2410 IF SR=1 THEN 2460
2420 CLS:PRINT "Select rotations ? 1, 2, 3, 4 or"
2430 INPUT " 0 = stop asking ";RT
2440 IF RT>4 THEN BEEP:GOTO 2420
2450 IF RT=0 THEN SR=1 ELSE SR=0
2460 IF DG=115 THEN 2470 ELSE CLS:GOTO 990
2470 A$=SG$(C):TT$=RIGHT$(A$,2)
2480 GOSUB 90:GOSUB 110:CLS:GOTO 1060 ' go rotate
2490 CLS:INPUT "Choose full game 1-31";C
2500 IF C<1 OR C>31 THEN BEEP:GOTO 2490 ELSE 2410
2510 ' auto solve
2520 IF DG=115 THEN 2530 ELSE 2540 ' s
2530 EC$=SS$(C,RT):GOTO 2550
2540 EC$=SF$(C,RT)
2550 LOCATE 20,20:PRINT "Solution: ";EC$
2560 LOCATE 21,3 :PRINT "Press any key to continue:"
2570 SL=LEN(EC$):GOSUB 130:AC=SL
2580 FOR A=1 TO SL
2590  F$=MID$(EC$,A,1)
2600  F=VAL(F$):LOCATE 21,29+A:PRINT F$
2610  LOCATE 10,53:PRINT F  ' solution number
2620  LOCATE  9,53:PRINT A  ' turn number
2630  IF F>6 THEN F=F-6:GOTO 2650
2640  IF F<4 THEN F=F+6
2650  IF BC(F)=0 THEN 2740 
2660  EC=F:BC(F)=0:GOSUB 80 ' clear android when key pressed
2670  FOR N2=1 TO 4
2680   F=PA(EC,N2)
2690   IF F=0 THEN 2710
2700   IF BC(F)=0 THEN BC(F)=1:GOSUB 70 ELSE BC(F)=0:GOSUB 80
2710  NEXT:AC=AC-1
2720  IF AC=0 THEN 2740     ' done exit loop
2730  GOSUB 130
2740 NEXT:GOTO 1630
2750 ' columns 3 2 1
2760 DATA 3,6,9,2,5,8,1,4,7
2770 ' full games
2780 DATA 1,2345678913,1346,789 5,25,12345610 : ' 1 2 3
2790 DATA 25,134678911,3,159 3,134679,124579 1: ' 4 5 6
2800 DATA 124,3678910,5,1234678911,456,12310  : ' 7 8 9
2810 DATA 1379,5 9,9,1 8,12346789,5 5         : ' 10 11 12
2820 DATA 2,5 8,12358,12346789 7,5,2 4        : ' 13 14 15
2830 DATA 5,1379 9,2,1345678911,5,46 7        : ' 16 17 18
2840 DATA 258,2468 7,19,1 6,8,1238 7          : ' 19 20 21
2850 DATA 1,36789 8,124,3678910,19,37 8       : ' 22 23 24
2860 DATA 5,19 7,5,456 8,258,134679 9         : ' 25 26 27
2870 DATA 19,137910,258,12346789 3,357,159 8  : ' 28 29 30
2880 DATA 1,37 4                              : ' 31
2890 ' simple games
2900 DATA 13579 9,1 6,13789 5   : ' 1 2 3
2910 DATA 2468 4,135 5,1234678 4: ' 4 5 6
2920 DATA 138 5,2 9,137 4       : ' 7 8 9
2930 DATA 5 5,123456789 5,159 3 : ' 10 11 12
2940 DATA 37 6,1289 8,12358 3   : ' 13 14 15
2950 ' android parts
2960 DATA 32,223,191, 32, 32,218,223,32: 'f$(2) happy hair
2970 DATA 32,123,147, 47, 92,147,125,32: 'f$(3) ear eye nose eye ear
2980 DATA 32,222,220,220,220,220,221,32: 'f$(4) happy mouth
2990 DATA 32,220,220,254,254,220,220,32: 'f$(5) foot
3000 DATA 32,222,223,223,223,223,221,32: 'f$(6) angry mouth
3010 DATA 32, 32,218,254,254,191, 32,32: 'f$(7) angry hair
3020 ' ß¿  Úß happy hair
3030 ' {“/\“} ear eye nose eye ear
3040 ' ÞÜÜÜÜÝ happy mouth
3050 ' ÜÜþþÜÜ foot
3060 ' ÞßßßßÝ angry mouth
3070 '  Úþþ¿  angry hair
3080 REM
3090 ' 36 positions androids
3100 DATA 2,4,5,0,1,3,0,0,2,5,6,0
3110 DATA 0,1,7,0,2,8,4,6,3,9,0,0
3120 DATA 4,5,8,0,7,9,0,0,5,6,8,0
3130 ' full game solutions
3140 DATA 9874631649589,3698217283563,1236479461521,7412893827547:' 1
3150 DATA 35495,15835,75615,75295                        :' 2
3160 DATA 6392561521,2134527547,4718549589,8976583563    :' 3
3170 DATA 52837951825,54691753465,58237951825,56419357645:' 4
3180 DATA 326,142,748,986                                :' 5
3190 DATA 3,1,7,9                                        :' 6
3200 DATA 8741235695,6987415235,2369875415,4123695875    :' 7
3210 DATA 54675314965,58295178325,56435796145,52815978325:' 8
3220 DATA 5463715965,5821975325,5647395145,5289135785    :' 9
3230 DATA 159372648,357916824,951738462,753194286        :' 10
3240 DATA 15895264,75635428,95215846,35475682            :' 11
3250 DATA 15937,75319,35791,95173                        :' 12
3260 DATA 63653417,21251879,47457693,89859231            :' 13
3270 DATA 4176285,8792465,6934825,2318645                :' 14
3280 DATA 5417,5879,5639,5213                            :' 15
3290 DATA 546371982,582197364,564739128,528913746        :' 16
3300 DATA 63214742596,21478984532,47896368514,89632126578:' 17
3310 DATA 5463791,5821937,5647319,5289173            :' 18
3320 DATA 4659173,8253719,6451937,2857391            :' 19
3330 DATA 124735,748195,986375,362195                :' 20
3340 DATA 4145165,8785725,6965945,2325385            :' 21
3350 DATA 95414586,35878562,15696524,75232548        :' 22
3360 DATA 8741235695,6987415235,2369875415,4123695875:' 23
3370 DATA 19287328,37289128,91823782,73469146        :' 24
3380 DATA 5281928,5283728,5829182,5467346            :' 25
3390 DATA 52815739,54675913,58295173,56435197        :' 26
3400 DATA 465193746,825731982,645917364,285379128    :' 27
3410 DATA 1982371946,3782193764,9128739164,7328917346:' 28
3420 DATA 645,285,465,825                            :' 29
3430 DATA 37461946,19827382,73649164,91283728        :' 30
3440 DATA 9542,3548,1586,7526                        :' 31
3450 ' simple games solutions
3460 DATA 584261973,568427391,526849137,542683719:' 1
3470 DATA 986735,326195,142735,748195            :' 2
3480 DATA 71482,79846,93682,13246                :' 3
3490 DATA 2846,8246,4628,4682                    :' 4
3500 DATA 54617,58279,56493,52813                :' 5
3510 DATA 9586,3526,1542,7548                    :' 6
3520 DATA 47319,87319,67319,27319                :' 7
3530 DATA 693827319,213467319,417827319,879467319:' 8
3540 DATA 9542,3548,1586,7526                :' 9
3550 DATA 58246,56482,52864,54628            :' 10
3560 DATA 57319,51973,53791,59137            :' 11
3570 DATA 195,735,915,375                    :' 12
3580 DATA 738246,198246,372864,912864        :' 13
3590 DATA 19821973,73461973,91289137,37649137:' 14
3600 DATA 935,135,715,795                    :' 15
3610 ' exit
3620 KEY 5,"androids.bas":KEY 6,CHR$(34)+",a":KEY ON
3630 COLOR 7,0:CLS
3640 ' ANDROID PICTURE GALLERY BY M.K.COOK G8HBR
3650 ' Converted from TRS-80 to GW-Basic
3660 ' By Eric F. Tchong P43EC - Aruba
3670 ' April 26, 1991 - auto solver ---> june 26, 2004
