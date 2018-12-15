10 CLS:KEY OFF:Z=80:SH=15:RANDOMIZE TIMER ' sort99sh.bas - March 11, 2004
20 DIM A$(Z),S$(Z),SL(Z),SR(Z):GOSUB 2680:PT$=CHR$(25):COLOR 12,0
30 PRINT "**************************"
40 PRINT "*     ANIMATION SORT     *"
50 PRINT "*         0 to 99        *" 
60 PRINT "*           by           *"
70 PRINT "*     Eric F. Tchong     *"
80 PRINT "*  serenata@setarnet.aw  *"
90 PRINT "*       N.C.C. 49-I      *"
100 PRINT "* San Nicolas ---- ARUBA *"
110 PRINT "**************************"
120 PRINT:PRINT:COLOR 14,0
130 PRINT "**************************"
140 PRINT "*  Screen <1> or <2> ?   *"
150 PRINT "*  Choose <?>            *"
160 PRINT "**************************":PRINT
170 CH$=INKEY$:IF CH$=""THEN 170
180 F=VAL(CH$):IF F<1 OR F>2 OR F<>INT(F) THEN CLS:GOTO 130
190 IF F=1 THEN SCREEN F:SWS=1:L=40:GOTO 220
200 IF F=2 THEN SCREEN F:SWS=1:L=80
210 ' Begin main program
220 CLS:W=L*8:IF F=1 AND NS>13 THEN NS=13
230 PRINT "* S I D E S O R T Platinum *":PRINT
240 PRINT " 1) Slow sort "
250 PRINT " 2) Bubble sort "
260 PRINT " 3) Shaker sort "
270 PRINT " 4) Delayed replacement sort "
280 PRINT " 5) Insertion sort "
290 PRINT " 6) Binary sort "
300 PRINT " 7) Shell sort "
310 PRINT " 8) Quicksort "
320 PRINT " 9) Screen set menu "
330 PRINT "10) Exit program "
340 PRINT:INPUT "Which choice ";CH
350 IF CH<1 OR CH>10 OR CH<>INT(CH) THEN 220
360 IF CH=9 THEN CLS:GOTO 130 ELSE IF CH=10 THEN 2160
370 CLS:GOSUB 520:LOCATE 10,1:NE=0:NC=0
380 ' Print data
390 FOR K=1 TO NS:A$(K)=S$(K):Z=W+(K-1)*3::GOSUB 2660:PRINT A$(K);:NEXT
400 ' User's info
410 LOCATE 13,1 :PRINT "Items ="NS      :LOCATE 13,24:PRINT "Finish ="
420 LOCATE 14,1 :PRINT "Comparisons ="NC:LOCATE 14,24:PRINT "Start  ="
430 LOCATE 15,1 :PRINT "Exchanges ="NE  :LOCATE 15,24:PRINT "Speed  =";SH
440 LOCATE 17,1 :PRINT "Slowmotion F3   Normal F4   Superfast F5"
450 LOCATE 18,1 :PRINT "    Slower F9   Faster F10  Turbo F8"
460 ON CH GOSUB 1040,900,1130,1300,1420,1670,1520,1860
470 LOCATE 21,1 :PRINT "Resort original list (y/n)"
480 RF$=INKEY$:IF RF$="" THEN 480 ELSE 490
490 IF RF$<>"y" AND RF$<>"Y" AND RF$<>"n" AND RF$<>"N" THEN RF$="y":GOTO 220
500 GOTO 220
510 ' Define quantity
520 IF RF$="Y" OR RF$="y" THEN 820
530 IF F=1 THEN 540 ELSE 570
540 INPUT "How many items <Max=13>";NS$:NS=VAL(NS$)
550 IF NS=0 THEN NS=13:GOTO 610
560 IF NS<2 OR NS>13 OR NS<>INT(NS) THEN 540 ELSE 610
570 INPUT "How many items <Max=26>";NS$:NS=VAL(NS$)
580 IF NS=0 THEN NS=26:GOTO 610
590 IF NS<2 OR NS>26 OR NS<>INT(NS) THEN 570
600 ' Make a choice 
610 PRINT:PRINT "(U)ser (C)omputer"
620 R1$=INKEY$:IF R1$="" THEN 620
630 IF R1$="U"  OR R1$="u" THEN 760
640 PRINT "(N)umbers or (L)etters "
650 R$=INKEY$:IF R$="" THEN 650
660 ' (C)omputer generates random numbers
670 IF R$="L" OR R$="l" THEN 680 ELSE 710
680 FOR K=1 TO NS
690   S$(K)=CHR$(INT(RND(1)*26+65))+CHR$(INT(RND(1)*26+65))
700 NEXT:GOTO 820
710 FOR K=1 TO NS
720   S$(K)=CHR$(INT(RND(1)*10+48))+CHR$(INT(RND(1)*10+48))
730   IF LEFT$(S$(K),1)=CHR$(48) THEN S$(K)=" "+RIGHT$(S$(K),1) 'no leading zero
740 NEXT:GOTO 820
750 ' (U)ser's input ---> remove leading zero
760 FOR K=1 TO NS
770   PRINT "Item #"K"=";
780   INPUT S$(K):IF LEN(S$(K))=1 THEN 790 ELSE 800
790   IF VAL(S$(K))<10 THEN S$(K)=" "+S$(K)
800   S$(K)=LEFT$(S$(K),2)
810 NEXT
820 RF$="N":CLS:RETURN
830 ' Wait for any key
840 LOCATE 21,1 :PRINT "Press any key ..."
850 IF INKEY$="" THEN 850
860 LOCATE 21,1 :PRINT "                 "
870 ' Print start time
880 LOCATE 14,33:B1$=TIME$:PRINT B1$:RETURN
890 ' Bubble Sort
900 LOCATE 1,1:PRINT "BUBBLE SORT"
910 GOSUB 840                                   ' Press to start
920 R=1                            
930 TEST=0
940 FOR I=1 TO NS-R
950   X=I:Y=I+1:GOSUB 2200                      ' Pointer
960   J=Y
970   IF A$(I)>A$(J) THEN TEST=1:GOSUB 2290     ' Switchem
980 NEXT:R=R+1:IF TEST=1 THEN 930
990 ' Job done
1000 GOSUB 2950                                  ' Calculate seconds
1010 LOCATE 20,1:PRINT "Done in";DN;"seconds"
1020 IF INKEY$="" THEN 1020 ELSE RETURN
1030 ' Slow Sort
1040 LOCATE 1,1:PRINT "SLOW SORT"
1050 GOSUB 840                                   ' Press to start
1060 FOR I=1 TO NS-1
1070   FOR J=I+1 TO NS
1080     X=I:Y=J:GOSUB 2200                      ' Pointer
1090     IF A$(I)>A$(J) THEN GOSUB 2290          ' Switchem
1100   NEXT
1110 NEXT:GOTO 1000                              ' Done
1120 ' Shaker sort
1130 LOCATE 1,1:PRINT "SHAKER SORT"
1140 GOSUB 840                                   ' Press to start
1150 LEFT=2:RIGHT=NS
1160 FOR PTR=RIGHT TO LEFT STEP -1               ' Bubble right to left
1170   PTR2=PTR:X=PTR-1:Y=PTR:GOSUB 2200         ' Pointer
1180   I=PTR2-1:J=Y
1190   IF A$(I)>A$(J) THEN S=PTR:GOSUB 2290      ' Switchem
1200 NEXT
1210 LEFT=S+1                                    ' Do not compare items
1220 FOR PTR=LEFT TO RIGHT                       ' Bubble left to right
1230   PTR2=PTR:X=PTR-1:Y=PTR:GOSUB 2200         ' Pointer
1240   I=PTR2-1:J=Y
1250   IF A$(I)>A$(J) THEN S=PTR:GOSUB 2290      ' Switchem
1260 NEXT
1270 RIGHT=S-1
1280 IF LEFT>RIGHT THEN 1000 ELSE 1160           ' Done
1290 ' Delayed Replacement Sort
1300 LOCATE 1,1:PRINT "DELAYED REPLACEMENT SORT"
1310 GOSUB 840                                   ' Press to start
1320 J=0:R=0:I=0
1330 I=I+1:IF I=NS THEN 1000                     ' Done
1340 J=I:R=J+1
1350 X=J:Y=R:GOSUB 2200                          ' Pointer
1360 IF A$(R)>=A$(J) THEN 1370 ELSE J=R
1370 R=R+1:IF R<=NS THEN 1350
1380 IF I=J THEN 1330
1390 GOSUB 2290                                  ' Switchem
1400 GOTO 1330
1410 ' Insertion Sort
1420 LOCATE 1,1:PRINT "INSERTION SORT"
1430 GOSUB 840                                   ' Press to start
1440 FOR PTR=2 TO NS
1450   PTR2=PTR
1460   X=PTR2-1:Y=PTR2:GOSUB 2200                ' Pointer
1470   IF A$(X)<=A$(Y) THEN 1500
1480   I=PTR2-1:J=PTR2:GOSUB 2290                ' Switchem
1490   PTR2=PTR2-1:GOTO 1460
1500 NEXT:GOTO 1000                              ' Done
1510 ' Shell Metzner Sort
1520 LOCATE 1,1:PRINT "SHELL SORT"
1530 GOSUB 840                                   ' Press to start
1540 GAP=NS
1550 GAP=INT(GAP/2)
1560 LOCATE 20,1:PRINT "Gap =";GAP
1570 IF GAP=0 THEN 1000                          ' Done
1580 P=NS-GAP:H=1
1590 I=H
1600 J=I+GAP:X=I:Y=J:GOSUB 2200                  ' Pointer
1610 IF A$(I)<=A$(J) THEN 1640
1620 GOSUB 2290                                  ' Switchem
1630 I=I-GAP:IF I>=1 THEN 1600
1640 H=H+1:IF H>P THEN 1550
1650 GOTO 1590
1660 ' Binary Sort
1670 LOCATE 1,1:PRINT "BINARY SORT"
1680 GOSUB 840                                   ' Press to start
1690 FOR PTR=2 TO NS
1700   X1=1:X2=PTR
1710   X3=X1+INT((X2-X1)/2)
1720   X=PTR:Y=X3:GOSUB 2200                     ' Pointer
1730   IF A$(PTR)<A$(X3) THEN 1760
1740   IF A$(PTR)>A$(X3) THEN 1780
1750   X2=X3
1760   IF X2=X3 THEN 1800
1770   X2=X3:GOTO 1710
1780   IF X1=X3 THEN 1800
1790   X1=X3:GOTO 1710
1800   GOSUB 3030                                ' Binary Switchem
1810 NEXT:GOTO 1000                              ' Done
1820 ' Quicksort (nonrecursive)
1830 ' SL is the array stack for the left  partition bound
1840 ' SR is the array stack for the right partition bound
1850 ' S  is the pointer to the next position in the stacks
1860 LOCATE 1,1:PRINT "QUICK SORT"
1870 GOSUB 840                                   ' Press to start
1880 ' Initialize the stacks with first and last to start
1890 S=1:SL(1)=0:SR(1)=NS
1900 LEFT=SL(S):RIGHT=SR(S):S=S-1                ' Pop top request stack
1910 ' Left = Left  bound of partition to be partitioned
1920 ' Right= Right bound of partition to be partitioned
1930 ' Now we will partition
1940   LP=LEFT:RP=RIGHT
1950   MV$=A$((LP+RP)/2)                         ' Select Middle Value
1960   IF A$(LP)<MV$ THEN LP=LP+1:GOTO 1960
1970   IF MV$<A$(RP) THEN RP=RP-1:GOTO 1970
1980 ' The last two lines selected an element in the
1990 ' upper half that belongs in the lower and in the
2000 ' lower half that belongs in the upper
2010           X=LP:Y=RP:GOSUB 2200              ' Pointer
2020           IF LP<=RP THEN 2030 ELSE 2070
2030           I=LP:J=RP
2040           IF A$(I)=A$(J) THEN 2060
2050           GOSUB 2290                        ' Switchem = Exchange
2060           LP=LP+1:RP=RP-1
2070     IF LP>RP THEN 2080 ELSE 1960
2080     IF LP<RIGHT THEN S=S+1:SL(S)=LP:SR(S)=RIGHT
2090 ' The last line pushed a partition request on the
2100 ' stack. Now we work on the other one.
2110     RIGHT=RP
2120   IF LEFT>=RIGHT THEN 2140 ELSE 1940
2130 ' Now we see if any requests are on the stack.
2140 IF S=0 THEN 1000 ELSE 1900                  ' Done
2150 ' Reset screen and exit sidesort
2160 IF F=1 THEN SCREEN 2:SCREEN 0
2170 IF F=2 THEN SCREEN 0
2180 GOTO 3510
2190 ' Pointer
2200 NC=NC+1:LOCATE 14,14:PRINT NC:IF FK=8 THEN RETURN
2210 Z=W+(X-1)*3-L:IF Z=277 OR Z=557 THEN 2250   ' Skip right arrow print
2220 GOSUB 2660
2230 PRINT PT$:IF D=7 THEN 2250               
2240 Z=W+(Y-1)*3-L:GOSUB 2660:PRINT PT$
2250 IF FK=5 THEN 2260 ELSE DELAY=1/SH:GOSUB 2930
2260 Z=W+(X-1)*3-L:GOSUB 2660:PRINT "  "
2270 Z=W+(Y-1)*3-L:GOSUB 2660:PRINT "  ":RETURN
2280 ' Move two items up                     (1-2)               
2290 IF FK=8 THEN 2610
2300 FOR K=0 TO 3
2310   Z=W+(I-1)*3-K*L :GOSUB 2660:PRINT "  "
2320   Z=Z-L           :GOSUB 2660:PRINT A$(I)
2330   IF FK=5 THEN 2340 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2930
2340   Z=W+(J-1)*3-K*L :GOSUB 2660:PRINT "  "
2350   Z=Z-L           :GOSUB 2660:PRINT A$(J)
2360 NEXT
2370 IF FK=5 THEN 2390 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2930
2380 ' Move right item one up                (3)
2390 Z=W+(J-1)*3-K*L   :GOSUB 2660:PRINT "  "
2400 Z=Z-L             :GOSUB 2660:PRINT A$(J):DF=J-I
2410 ' Switch two items                      (4-5)
2420 FOR K=1 TO DF
2430   Z=W+(I-1)*3+(K-1)*3-(4*L):GOSUB 2660:PRINT "  "
2440   Z=Z+3                    :GOSUB 2660:PRINT A$(I)
2450   IF FK=5 THEN 2470
2460   IF FK=3 THEN DELAY=1/SH:GOSUB 2930 ELSE DELAY=1/99:GOSUB 2930
2470   Z=W+(J-1)*3-(K-1)*3-(5*L):GOSUB 2660:PRINT "  "
2480   Z=Z-3                    :GOSUB 2660:PRINT A$(J)
2490 NEXT
2500 ' Move two items down                   (6-7)
2510 FOR K=4 TO 0 STEP -1
2520   Z=W+(J-1)*3-(K+1)*L:GOSUB 2660:PRINT "  "
2530   Z=Z+L              :GOSUB 2660:PRINT A$(I)
2540   IF FK=5 THEN 2550 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2930
2550   Z=W+(I-1)*3-(K+1)*L:GOSUB 2660:PRINT "  "
2560   Z=Z+L              :GOSUB 2660:PRINT A$(J)
2570 NEXT
2580 NE=NE+1:LOCATE 15,12:PRINT NE
2590 TEMP$=A$(I):A$(I)=A$(J):A$(J)=TEMP$:RETURN  ' swap
2600 ' Turbo
2610 Z=W+(I-1)*3:GOSUB 2660:PRINT "  "
2620            :GOSUB 2660:PRINT A$(J)
2630 Z=W+(J-1)*3:GOSUB 2660:PRINT "  "
2640            :GOSUB 2660:PRINT A$(I):GOTO 2580
2650 ' Convert print@ to locate subroutine - p43ec          
2660 D=INT(Z/L)+1:E=(D-1)*L:E=(Z-E)+1:LOCATE D,E:RETURN
2670 ' Initialize Function keys                             
2680 ON KEY (9)  GOSUB 2820:KEY (9)  ON ' slower      F9    
2690 ON KEY (10) GOSUB 2800:KEY (10) ON ' faster      F10   
2700 ON KEY (3)  GOSUB 2750:KEY (3)  ON ' slow motion F3    
2710 ON KEY (4)  GOSUB 2760:KEY (4)  ON ' normal      F4    
2720 ON KEY (5)  GOSUB 2770:KEY (5)  ON ' superfast   F5    
2730 ON KEY (8)  GOSUB 2780:KEY (8)  ON ' turbo       F8    
2740 RETURN
2750 FK=3:RETURN
2760 FK=4:RETURN
2770 FK=5:RETURN
2780 FK=8:RETURN
2790 ' Select pointer speed
2800 SH=SH+1:IF SH=31 THEN SH=30 ' Increase
2810 LOCATE 15,24:PRINT "Speed  =";SH:RETURN
2820 SH=SH-1:IF SH=0  THEN SH=1  ' Decrease
2830 GOTO 2810
2840 ' Demo switch of 9 and 0 in 99990
2850 ' ÚÄÄÄÄÄ 120 <------5------- 132 <ÄÄÄ¿3
2860 ' ³  ÚÄ> 160 -------4------> 172 <Ä¿ÄÙÄ¿
2870 ' ³  ³   200                 212   ³   ³
2880 '7³ 1³   240                 252   ³2  ³6
2890 ' ³  ³   280                 292   ³   ³
2900 ' ÀÄ>ÀÄÄ 320  323  326  329  332 ÄÄÙ<ÄÄÙ
2910 REM       9    9    9    9    0
2920 ' Variable time delay
2930 START=TIMER:WHILE TIMER<START+DELAY:WEND:RETURN
2940 ' Calculate seconds past
2950 LOCATE 13,33:B2$=TIME$:PRINT B2$
2960 B$=B1$:GOSUB 3000:H1$=H$:M1$=M$:S1$=S$
2970 B$=B2$:GOSUB 3000:H2$=H$:M2$=M$:S2$=S$
2980 H1=VAL(H1$):M1=VAL(M1$):S1=VAL(S1$):H2=VAL(H2$):M2=VAL(M2$):S2=VAL(S2$)
2990 NW=(H2*3600)+(M2*60)+S2:BG=(H1*3600)+(M1*60)+S1:DN=NW-BG:RETURN
3000 H$=MID$(B$,1,2):M$=MID$(B$,4,2):S$=MID$(B$,7,2):RETURN
3010 ' Binary sort screen output subroutine
3020 ' Move one item up
3030 J=PTR:I=X2:IF FK=8 THEN 3400
3040 DF=0:FOR PTR2=PTR TO X2+1 STEP -1:DF=DF+1:NEXT
3050 IF DF=0 THEN RETURN
3060 FOR K=0 TO 3
3070   IF FK=5 THEN 3080 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2930
3080   Z=W+(J-1)*3-K*L:GOSUB 2660:PRINT "  "
3090   Z=Z-L          :GOSUB 2660:PRINT A$(J)
3100 NEXT
3110 IF FK=5 THEN 3130 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2930
3120 ' Move item to the left
3130 FOR K=1 TO DF:IF FK=5 THEN 3150
3140   IF FK=3 THEN DELAY=1/SH:GOSUB 2930 ELSE DELAY=1/99:GOSUB 2930
3150   Z=W+(J-K)*3-4*L:GOSUB 2660:PRINT "  "
3160   Z=Z-3          :GOSUB 2660:PRINT A$(J)
3170 NEXT
3180 ' Move item down
3190 FOR K=3 TO 1 STEP -1
3200   IF FK=5 THEN 3210 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2930 ELSE DELAY=1/99:GOSUB 2930
3210   Z=W+(I-1)*3-(K+1)*L:GOSUB 2660:PRINT "  "
3220   Z=Z+L              :GOSUB 2660:PRINT A$(J)
3230 NEXT
3240 TEMP$=A$(J):IF FK=5 THEN 3260 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2930
3250 ' Move items to the right
3260 H$=A$(PTR)
3270 FOR PTR2=PTR TO X2+1 STEP -1
3280   A$(PTR2)=A$(PTR2-1)
3290   Z=W+(PTR2-1)*3-3:GOSUB 2660:PRINT "  "
3300   Z=Z+3           :GOSUB 2660:PRINT A$(PTR2)
3310 NEXT
3320 A$(X2)=H$
3330 IF FK=5 THEN 3350 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2930
3340 ' Move item into the list
3350 K=0
3360 Z=W+(I-1)*3-(K+1)*L:GOSUB 2660:PRINT "  "
3370 Z=Z+L              :GOSUB 2660:PRINT TEMP$
3380 NE=NE+1:LOCATE 15,12:PRINT NE:RETURN
3390 ' Turbo Binary Sort
3400 H$=A$(PTR)
3410 FOR PTR2=PTR TO X2+1 STEP -1
3420   A$(PTR2)=A$(PTR2-1)
3430 NEXT
3440 A$(X2)=H$
3450 IF FK<>8 THEN RETURN
3460 LOCATE 9,1
3470 FOR K=1 TO NS
3480   PRINT A$(K);" ";
3490 NEXT:GOTO 3380
3500 ' Exit friendly
3510 KEY 5,"sort99sh.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS:END
3520 ' Bubble Sort                80 Micro, October 1986 page 120
3530 ' Slow Sort                  80 Micro, October 1986 page 120
3540 ' Shaker Sort                http://homepages.unl.ac.uk/~chalkp/proj/algtutor/shakersort.html
3550 ' Delayed Replacement Sort   Visisort 80-U.S. Journal, page 50
3560 ' Insertion Sort             80 Micro, October 1986 page 122
3570 ' Shell Metzner Sort         Visisort 80-U.S. Journal, page 52
3580 ' Binary Sort                BASIC-subroutines, K. Tracton page 74
3590 ' Quicksort                  Microcomputing, November 1981 page 157
