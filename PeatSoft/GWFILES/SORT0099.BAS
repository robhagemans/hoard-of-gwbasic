10 CLS:KEY OFF:Z=80:SH=15:RANDOMIZE TIMER ' sort0099.bas - April 4, 2003
20 DIM A$(Z),S$(Z),SL(Z),SR(Z):GOSUB 2670:PT$=CHR$(25):COLOR 12,0
30 PRINT "**************************"
40 PRINT "*     ANIMATION SORT     *"
50 PRINT "*        00 to 99        *" 
60 PRINT "*           by           *"
70 PRINT "*     Eric F. Tchong     *"
80 PRINT "*  serenata@setarnet.aw  *"
90 PRINT "*       N.C.C. 49-I      *"
100 PRINT "* San Nicolas ---- ARUBA *"
110 PRINT "**************************":PRINT:PRINT:COLOR 14,0
120 PRINT "**************************"
130 PRINT "*  Screen <1> or <2> ?   *"
140 PRINT "*  Choose <?>            *"
150 PRINT "**************************":PRINT
160 CH$=INKEY$:IF CH$=""THEN 160
170 F=VAL(CH$):IF F<1 OR F>2 OR F<>INT(F) THEN CLS:GOTO 120
180 IF F=1 THEN SCREEN F:SWS=1:L=40:GOTO 210
190 IF F=2 THEN SCREEN F:SWS=1:L=80
200 ' Begin main program
210 CLS:W=L*8:IF F=1 AND NS>13 THEN NS=13
220 PRINT "* S I D E S O R T Platinum *":PRINT
230 PRINT "1) Slow sort................"
240 PRINT "2) Bubble sort.............."
250 PRINT "3) Delayed replacement sort."
260 PRINT "4) Insertion sort..........."
270 PRINT "5) Binary sort.............."
280 PRINT "6) Shell-Metzner sort......."
290 PRINT "7) Quicksort................"
300 PRINT "8) Return screen set menu..."
310 PRINT "9) Exit program............."
320 PRINT:PRINT "Which choice ?"
330 CH$=INKEY$:IF CH$=""THEN 330
340 CH=VAL(CH$):IF CH<1 OR CH>9 OR CH<>INT(CH) THEN 210
350 IF CH=8 THEN CLS:GOTO 120 ELSE IF CH=9 THEN 2050
360 CLS:GOSUB 510:LOCATE 10,1:NE=0:NC=0
370 ' Print data
380 FOR K=1 TO NS:A$(K)=S$(K):Z=W+(K-1)*3::GOSUB 2640:PRINT A$(K);:NEXT
390 ' User's info
400 LOCATE 13,1 :PRINT "Items ="NS      :LOCATE 13,24:PRINT "Finish ="
410 LOCATE 14,1 :PRINT "Comparisons ="NC:LOCATE 14,24:PRINT "Start  ="
420 LOCATE 15,1 :PRINT "Exchanges ="NE  :LOCATE 15,24:PRINT "Speed  =";SH
430 LOCATE 17,1 :PRINT "Slowmotion F3   Normal F4   Superfast F5"
440 LOCATE 18,1 :PRINT "    Slower F9   Faster F10  Turbo F8"
450 ON CH GOSUB 1040,870,1140,1270,1540,1380,1740
460 LOCATE 21,1 :PRINT "Resort original list (y/n)"
470 RF$=INKEY$:IF RF$="" THEN 470 ELSE 480
480 IF RF$<>"y" AND RF$<>"Y" AND RF$<>"n" AND RF$<>"N" THEN RF$="y":GOTO 210
490 GOTO 210
500 ' Define quantity
510 IF RF$="Y" OR RF$="y" THEN 790
520 IF F=1 THEN 530 ELSE 560
530 INPUT "How many items <Max=13>";NS$:NS=VAL(NS$)
540 IF NS=0 THEN NS=13:GOTO 600
550 IF NS<2 OR NS>13 OR NS<>INT(NS) THEN 530 ELSE 600
560 INPUT "How many items <Max=26>";NS$:NS=VAL(NS$)
570 IF NS=0 THEN NS=26:GOTO 600
580 IF NS<2 OR NS>26 OR NS<>INT(NS) THEN 560
590 ' Make a choice 
600 PRINT:PRINT "(U)ser (C)omputer"
610 R1$=INKEY$:IF R1$="" THEN 610
620 IF R1$="U"  OR R1$="u" THEN 740
630 PRINT "(N)umbers or (L)etters "
640 R$=INKEY$:IF R$="" THEN 640
650 ' (C)omputer generates random numbers
660 IF R$="L" OR R$="l" THEN 670 ELSE 700
670 FOR K=1 TO NS
680   S$(K)=CHR$(INT(RND(1)*26+65))+CHR$(INT(RND(1)*26+65))
690 NEXT:GOTO 790
700 FOR K=1 TO NS
710   S$(K)=CHR$(INT(RND(1)*10+48))+CHR$(INT(RND(1)*10+48))
720 NEXT:GOTO 790
730 ' (U)ser's input
740 FOR K=1 TO NS
750   PRINT "Item #"K"=";
760   INPUT S$(K)
770   S$(K)=LEFT$(S$(K),2)
780 NEXT
790 RF$="N":CLS:RETURN
800 ' Wait for any key
810 LOCATE 21,1 :PRINT "Press any key ..."
820 K$=INKEY$:IF K$="" THEN 820
830 LOCATE 21,1 :PRINT "                 ":RETURN
840 ' Print start time
850 LOCATE 14,33:B1$=TIME$:PRINT B1$:RETURN
860 ' Bubble Sort
870 LOCATE 1,1:PRINT "BUBBLE SORT"
880 GOSUB 810                                   ' Wait
890 GOSUB 850                                   ' Start
900 R=1                            
910 TEST=0
920 FOR I=1 TO NS-R
930   X=I:Y=I+1:GOSUB 2090                      ' Pointer
940   J=Y
950   IF A$(I)>A$(J) THEN TEST=1:GOSUB 2190     ' Switchem
960 NEXT:R=R+1:IF TEST=1 THEN 910
970 ' Job done                                  ' Done
980 GOSUB 2860                                  ' Calculate seconds
990 LOCATE 20,1
1000 PRINT "Done in";DN;"seconds"
1010 GOSUB 810                                   ' Wait
1020 RETURN
1030 ' Slow Sort
1040 LOCATE 1,1:PRINT "SLOW SORT"
1050 GOSUB 810                                   ' Wait
1060 GOSUB 850                                   ' Start
1070 FOR I=1 TO NS-1
1080   FOR J=I+1 TO NS
1090     X=I:Y=J:GOSUB 2090                      ' Pointer
1100     IF A$(I)>A$(J) THEN GOSUB 2190          ' Switchem
1110   NEXT
1120 NEXT:GOTO 980                               ' Done
1130 ' Delayed Replacement Sort
1140 LOCATE 1,1:PRINT "DELAYED REPLACEMENT SORT"
1150 GOSUB 810                                   ' Wait
1160 GOSUB 850                                   ' Start
1170 J=0:R=0:I=0
1180 I=I+1:IF I=NS THEN 980                      ' Done
1190 J=I:R=J+1
1200 X=J:Y=R:GOSUB 2090                          ' Pointer
1210 IF A$(R)>=A$(J) THEN 1220 ELSE J=R
1220 R=R+1:IF R<=NS THEN 1200
1230 IF I=J THEN 1180
1240 GOSUB 2190                                  ' Switchem
1250 GOTO 1180
1260 ' Insertion Sort
1270 LOCATE 1,1:PRINT "INSERTION SORT"
1280 GOSUB 810                                   ' Wait
1290 GOSUB 850                                   ' Start
1300 FOR PTR=2 TO NS
1310   PTR2=PTR
1320   X=PTR2-1:Y=PTR2:GOSUB 2090                ' Pointer
1330   IF A$(X)<=A$(Y) THEN 1360
1340   I=PTR2-1:J=PTR2:GOSUB 2190                ' Switchem
1350   PTR2=PTR2-1:GOTO 1320
1360 NEXT:GOTO 980                               ' Done
1370 ' Shell Metzner Sort
1380 LOCATE 1,1:PRINT "SHELL-METZNER SORT"
1390 GOSUB 810                                   ' Wait
1400 GOSUB 850                                   ' Start
1410 GAP=NS
1420 GAP=INT(GAP/2)
1430 LOCATE 20,1:PRINT "Gap =";GAP
1440 IF GAP=0 THEN 980                           ' Done
1450 P=NS-GAP:H=1
1460 I=H
1470 J=I+GAP:X=I:Y=J:GOSUB 2090                  ' Pointer
1480 IF A$(I)<=A$(J) THEN 1510
1490 GOSUB 2190                                  ' Switchem
1500 I=I-GAP:IF I>=1 THEN 1470
1510 H=H+1:IF H>P THEN 1420
1520 GOTO 1460
1530 ' Binary Sort
1540 LOCATE 1,1:PRINT "BINARY SORT"
1550 GOSUB 810                                   ' Wait
1560 GOSUB 850                                   ' Start
1570 FOR PTR=2 TO NS
1580   X1=1:X2=PTR
1590   X3=X1+INT((X2-X1)/2)
1600   X=PTR:Y=X3:GOSUB 2090                     ' Pointer
1610   IF A$(PTR)<A$(X3) THEN 1640
1620   IF A$(PTR)>A$(X3) THEN 1660
1630   X2=X3
1640   IF X2=X3 THEN 1680
1650   X2=X3:GOTO 1590
1660   IF X1=X3 THEN 1680
1670   X1=X3:GOTO 1590
1680   GOSUB 2940                                ' Binary Switchem
1690 NEXT:GOTO 980                               ' Done
1700 ' Quicksort (nonrecursive)
1710 ' SL is the array stack for the left  partition bound
1720 ' SR is the array stack for the right partition bound
1730 ' S  is the pointer to the next position in the stacks
1740 LOCATE 1,1:PRINT "QUICK SORT"
1750 GOSUB 810                                   ' Wait
1760 GOSUB 850                                   ' Start
1770 ' Initialize the stacks with first and last to start
1780 S=1:SL(1)=0:SR(1)=NS
1790 LEFT=SL(S):RIGHT=SR(S):S=S-1                ' Pop top request stack
1800 ' Left = Left  bound of partition to be partitioned
1810 ' Right= Right bound of partition to be partitioned
1820 ' Now we will partition
1830   LP=LEFT:RP=RIGHT
1840   MV$=A$((LP+RP)/2)                         ' Select Middle Value
1850   IF A$(LP)<MV$ THEN LP=LP+1:GOTO 1850
1860   IF MV$<A$(RP) THEN RP=RP-1:GOTO 1860
1870 ' The last two lines selected an element in the
1880 ' upper half that belongs in the lower and in the
1890 ' lower half that belongs in the upper
1900           X=LP:Y=RP:GOSUB 2090              ' Pointer
1910           IF LP<=RP THEN 1920 ELSE 1960
1920           I=LP:J=RP
1930           IF A$(I)=A$(J) THEN 1950
1940           GOSUB 2190                        ' Switchem = Exchange
1950           LP=LP+1:RP=RP-1
1960     IF LP>RP THEN 1970 ELSE 1850
1970     IF LP<RIGHT THEN S=S+1:SL(S)=LP:SR(S)=RIGHT
1980 ' The last line pushed a partition request on the
1990 ' stack. Now we work on the other one.
2000     RIGHT=RP
2010   IF LEFT>=RIGHT THEN 2030 ELSE 1830
2020 ' Now we see if any requests are on the stack.
2030 IF S=0 THEN 980 ELSE 1790                   ' Done
2040 ' Reset screen and exit sidesort
2050 IF F=1 THEN SCREEN 2:SCREEN 0
2060 IF F=2 THEN SCREEN 0
2070 GOTO 3430
2080 ' Pointer
2090 NC=NC+1:LOCATE 14,14:PRINT NC:IF FK=8 THEN RETURN
2100 Z=W+(X-1)*3-L:IF Z=277 OR Z=557 THEN 2140   ' Skip right arrow print
2110 GOSUB 2640
2120 PRINT PT$:IF D=7 THEN 2140               
2130 Z=W+(Y-1)*3-L:GOSUB 2640:PRINT PT$
2140 IF FK=5 THEN 2150 ELSE DELAY=1/SH:GOSUB 2840
2150 Z=W+(X-1)*3-L:GOSUB 2640:PRINT "  "
2160 Z=W+(Y-1)*3-L:GOSUB 2640:PRINT "  ":RETURN
2170 GOTO 2170
2180 ' Move two items up                     (1-2)               
2190 IF FK=8 THEN 2510
2200 FOR K=0 TO 3
2210   Z=W+(I-1)*3-K*L :GOSUB 2640:PRINT "  "
2220   Z=Z-L           :GOSUB 2640:PRINT A$(I)
2230   IF FK=5 THEN 2240 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2840
2240   Z=W+(J-1)*3-K*L :GOSUB 2640:PRINT "  "
2250   Z=Z-L           :GOSUB 2640:PRINT A$(J)
2260 NEXT
2270 IF FK=5 THEN 2290 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2840
2280 ' Move right item one up                (3)
2290 Z=W+(J-1)*3-K*L   :GOSUB 2640:PRINT "  "
2300 Z=Z-L             :GOSUB 2640:PRINT A$(J);:DF=J-I
2310 ' Switch two items                      (4-5)
2320 FOR K=1 TO DF
2330   Z=W+(I-1)*3+(K-1)*3-(4*L):GOSUB 2640:PRINT "  "
2340   Z=Z+3                    :GOSUB 2640:PRINT A$(I)
2350   IF FK=5 THEN 2370
2360   IF FK=3 THEN DELAY=1/SH:GOSUB 2840 ELSE DELAY=1/99:GOSUB 2840
2370   Z=W+(J-1)*3-(K-1)*3-(5*L):GOSUB 2640:PRINT "  "
2380   Z=Z-3                    :GOSUB 2640:PRINT A$(J)
2390 NEXT
2400 ' Move two items down                   (6-7)
2410 FOR K=4 TO 0 STEP -1
2420   Z=W+(J-1)*3-(K+1)*L:GOSUB 2640:PRINT "  "
2430   Z=Z+L              :GOSUB 2640:PRINT A$(I)
2440   IF FK=5 THEN 2450 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2840
2450   Z=W+(I-1)*3-(K+1)*L:GOSUB 2640:PRINT "  "
2460   Z=Z+L              :GOSUB 2640:PRINT A$(J)
2470 NEXT
2480 NE=NE+1:LOCATE 15,12:PRINT NE
2490 TEMP$=A$(I):A$(I)=A$(J):A$(J)=TEMP$:RETURN  ' swap
2500 ' Turbo
2510 Z=W+(I-1)*3:GOSUB 2640:PRINT "  "
2520            :GOSUB 2640:PRINT A$(J)
2530 Z=W+(J-1)*3:GOSUB 2640:PRINT "  "
2540            :GOSUB 2640:PRINT A$(I):GOTO 2480
2550 ' Demo switch of 9 and 0 in 99990
2560 ' ÚÄÄÄÄÄ 120 <------5------- 132 <ÄÄÄ¿3
2570 ' ³  ÚÄ> 160 -------4------> 172 <Ä¿ÄÙÄ¿
2580 ' ³  ³   200                 212   ³   ³
2590 '7³ 1³   240                 252   ³2  ³6
2600 ' ³  ³   280                 292   ³   ³
2610 ' ÀÄ>ÀÄÄ 320  323  326  329  332 ÄÄÙ<ÄÄÙ
2620 REM       9    9    9    9    0
2630 ' Convert print@ to locate subroutine - p43ec          
2640 D=INT(Z/L)+1:E=(D-1)*L:E=(Z-E)+1:LOCATE D,E
2650 RETURN
2660 ' Initialize Function keys                             
2670 ON KEY (9)  GOSUB 2810:KEY (9)  ON ' slower      F9    
2680 ON KEY (10) GOSUB 2790:KEY (10) ON ' faster      F10   
2690 ON KEY (3)  GOSUB 2740:KEY (3)  ON ' slow motion F3    
2700 ON KEY (4)  GOSUB 2750:KEY (4)  ON ' normal      F4    
2710 ON KEY (5)  GOSUB 2760:KEY (5)  ON ' superfast   F5    
2720 ON KEY (8)  GOSUB 2770:KEY (8)  ON ' turbo       F8    
2730 RETURN
2740 FK=3:RETURN
2750 FK=4:RETURN
2760 FK=5:RETURN
2770 FK=8:RETURN
2780 ' Select pointer speed
2790 SH=SH+1:IF SH=31 THEN SH=30 ' Increase
2800 LOCATE 15,24:PRINT "Speed  =";SH:RETURN
2810 SH=SH-1:IF SH=0  THEN SH=1  ' Decrease
2820 GOTO 2800
2830 ' Variable time delay
2840 START=TIMER:WHILE TIMER<START+DELAY:WEND:RETURN
2850 ' Calculate seconds past
2860 LOCATE 13,33:B2$=TIME$:PRINT B2$
2870 B$=B1$:GOSUB 2910:H1$=H$:M1$=M$:S1$=S$
2880 B$=B2$:GOSUB 2910:H2$=H$:M2$=M$:S2$=S$
2890 H1=VAL(H1$):M1=VAL(M1$):S1=VAL(S1$):H2=VAL(H2$):M2=VAL(M2$):S2=VAL(S2$)
2900 NW=(H2*3600)+(M2*60)+S2:BG=(H1*3600)+(M1*60)+S1:DN=NW-BG:RETURN
2910 H$=MID$(B$,1,2):M$=MID$(B$,4,2):S$=MID$(B$,7,2):RETURN
2920 ' Binary sort screen output subroutine
2930 ' Move one item up
2940 J=PTR:I=X2:IF FK=8 THEN 3320
2950 DF=0:FOR PTR2=PTR TO X2+1 STEP -1:DF=DF+1:NEXT
2960 IF DF=0 THEN RETURN
2970 FOR K=0 TO 3
2980   IF FK=5 THEN 2990 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2840
2990   Z=W+(J-1)*3-K*L:GOSUB 2640:PRINT "  "
3000   Z=Z-L          :GOSUB 2640:PRINT A$(J)
3010 NEXT
3020 IF FK=5 THEN 3040 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2840
3030 ' Move item to the left
3040 FOR K=1 TO DF:IF FK=5 THEN 3060
3050   IF FK=3 THEN DELAY=1/SH:GOSUB 2840 ELSE DELAY=1/99:GOSUB 2840
3060   Z=W+(J-K)*3-4*L:GOSUB 2640:PRINT "  "
3070   Z=Z-3          :GOSUB 2640:PRINT A$(J)
3080 NEXT
3090 ' Move item down
3100 FOR K=3 TO 1 STEP -1
3110   IF FK=5 THEN 3120 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2840 ELSE DELAY=1/99:GOSUB 2840
3120   Z=W+(I-1)*3-(K+1)*L:GOSUB 2640:PRINT "  "
3130   Z=Z+L              :GOSUB 2640:PRINT A$(J)
3140 NEXT
3150 TEMP$=A$(J):IF FK=5 THEN 3170 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2840
3160 ' Move items to the right
3170 H$=A$(PTR)
3180 FOR PTR2=PTR TO X2+1 STEP -1
3190   A$(PTR2)=A$(PTR2-1)
3200   Z=W+(PTR2-1)*3-3:GOSUB 2640:PRINT "  "
3210   Z=Z+3           :GOSUB 2640:PRINT A$(PTR2)
3220 NEXT
3230 A$(X2)=H$
3240 IF FK=5 THEN 3260 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2840
3250 ' Move item into the list
3260 K=0
3270 Z=W+(I-1)*3-(K+1)*L:GOSUB 2640:PRINT "  "
3280 Z=Z+L              :GOSUB 2640:PRINT TEMP$
3290 NE=NE+1:LOCATE 15,12:PRINT NE
3300 RETURN
3310 ' Turbo Binary Sort
3320 H$=A$(PTR)
3330 FOR PTR2=PTR TO X2+1 STEP -1
3340   A$(PTR2)=A$(PTR2-1)
3350 NEXT
3360 A$(X2)=H$
3370 IF FK<>8 THEN RETURN
3380 LOCATE 9,1
3390 FOR K=1 TO NS
3400   PRINT A$(K);" ";
3410 NEXT:GOTO 3290
3420 ' Exit friendly
3430 KEY 5,"sort0099.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS:END
3440 ' Bubble Sort                80 Micro, October 1986 page 120
3450 ' Slow Sort                  80 Micro, October 1986 page 120
3460 ' Delayed Replacement Sort   Visisort 80-U.S. Journal, page 50
3470 ' Insertion Sort             80 Micro, October 1986 page 122
3480 ' Shell Metzner Sort         Visisort 80-U.S. Journal, page 52
3490 ' Binary Sort                BASIC-subroutines, K. Tracton page 74
3500 ' Quicksort                  Microcomputing, November 1981 page 157
