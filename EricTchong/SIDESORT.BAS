10 CLS:KEY OFF:Z=80:SH=15:RANDOMIZE TIMER ' sidesort.bas - March 16, 2004
20 DIM A$(Z),S$(Z),SL(Z),SR(Z):GOSUB 2870:PT$=CHR$(25):COLOR 12,0
30 PRINT "**************************"
40 PRINT "* ANIMATED SORT ROUTINES *"
50 PRINT "*          by            *"
60 PRINT "*     Eric F. Tchong     *"
70 PRINT "*  serenata@setarnet.aw  *"
80 PRINT "*       N.C.C. 49-I      *"
90 PRINT "* San Nicolas ---- ARUBA *"
100 PRINT "**************************"
110 PRINT:PRINT:COLOR 14,0
120 PRINT "**************************"
130 PRINT "*  Screen <1> or <2> ?   *"
140 PRINT "*  Choose <?>            *"
150 PRINT "**************************":PRINT
160 CH$=INKEY$:IF CH$=""THEN 160
170 F=VAL(CH$):IF F<1 OR F>2 OR F<>INT(F) THEN CLS:GOTO 120
180 IF F=1 THEN SCREEN F:SWS=1:L=40:GOTO 210
190 IF F=2 THEN SCREEN F:SWS=1:L=80
200 ' Begin main program
210 CLS:W=L*8-1:IF F=1 AND NS>40 THEN NS=40
220 PRINT "* S I D E S O R T  XP GOLD *":PRINT
230 PRINT " 1) Slow sort"
240 PRINT " 2) Bubble sort"
250 PRINT " 3) Shaker sort"
260 PRINT " 4) Delayed replacement sort"
270 PRINT " 5) Insertion sort"
280 PRINT " 6) Binary sort"
290 PRINT " 7) Shell sort"
300 PRINT " 8) Quicksort"
310 PRINT " 9) Return screen set menu"
320 PRINT "10) Exit program"
330 PRINT:INPUT "Which choice ";CH
340 IF CH<1 OR CH>10 OR CH<>INT(CH) THEN 210
350 IF CH=9 THEN CLS:GOTO 120 ELSE IF CH=10 THEN 2270
360 CLS:GOSUB 510:LOCATE 10,1:NE=0:NC=0
370 ' Print data
380 FOR K=1 TO NS:A$(K)=S$(K):Z=W+K:GOSUB 2850:PRINT A$(K);:NEXT
390 ' User's info
400 LOCATE 13,1 :PRINT "Items ="NS      :LOCATE 13,24:PRINT "Finish ="
410 LOCATE 14,1 :PRINT "Comparisons ="NC:LOCATE 14,24:PRINT "Start  ="
420 LOCATE 15,1 :PRINT "Exchanges ="NE  :LOCATE 15,24:PRINT "Speed  =";SH
430 LOCATE 17,1 :PRINT "Slowmotion F3   Normal F4   Superfast F5"
440 LOCATE 18,1 :PRINT "    Slower F9   Faster F10  Turbo F8"
450 ON CH GOSUB 1150,990,1240,1410,1530,1780,1630,1970
460 LOCATE 21,1 :PRINT "Resort original list (y/n)"
470 RF$=INKEY$:IF RF$="" THEN 470 ELSE 480
480 IF RF$<>"y" AND RF$<>"Y" AND RF$<>"n" AND RF$<>"N" THEN RF$="y":GOTO 210
490 GOTO 210
500 ' Define quantity
510 IF RF$="Y" OR RF$="y" THEN 760
520 IF F=1 THEN 530 ELSE 560
530 INPUT "How many items <Max=40>";NS$:NS=VAL(NS$)
540 IF NS=0 THEN NS=40:GOTO 600
550 IF NS<2 OR NS>40 OR NS<>INT(NS) THEN 530 ELSE 600
560 INPUT "How many items <Max=80>";NS$:NS=VAL(NS$)
570 IF NS=0 THEN NS=80:GOTO 600
580 IF NS<2 OR NS>80 OR NS<>INT(NS) THEN 560
590 ' Make a choice 
600 PRINT:PRINT "(U)ser (S)amples (C)omputer"
610 R1$=INKEY$:IF R1$="" THEN 610
620 IF R1$="U" OR R1$="u" THEN 710
630 IF R1$="S" OR R1$="s" THEN 780
640 PRINT "(N)umbers or (L)etters "
650 R$=INKEY$:IF R$="" THEN 650
660 ' (C)omputer generates random letters or numbers
670 FOR K=1 TO NS
680   IF LEFT$(R$,1)="L" OR LEFT$(R$,1)="l" THEN S$(K)=CHR$(INT(RND(1)*26+65)) ELSE S$(K)=CHR$(INT(RND(1)*10+48))
690 NEXT:GOTO 760
700 ' (U)sers input
710 IF F=1 THEN PRINT:PRINT "Enter a string <=40 ":GOTO 730
720 PRINT:PRINT "Enter a string <=80 "
730 PRINT STRING$(NS,".");
740 LINE INPUT Z$:NS=LEN(Z$)
750 FOR K=1 TO NS:S$(K)=MID$(Z$,K,1):NEXT
760 RF$="N":CLS:RETURN
770 ' (S)amples
780 CLS:IF RF$="N" THEN RETURN
790 SE$(1)="0123456789":PRINT "1þ";SE$(1)
800 SE$(2)="9876543210":PRINT "2þ";SE$(2)
810 SE$(3)="8094357261":PRINT "3þ";SE$(3):PRINT
820 SE$(4)="ABCDEFGHIJKLMNOPQRSTUVWXYZ":PRINT "4þ";SE$(4)
830 SE$(5)="ZYXWVUTSRQPONMLKJIHGFEDCBA":PRINT "5þ";SE$(5):PRINT
840 SE$(6)="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789":PRINT "6þ";SE$(6):PRINT
850 SE$(7)="9876543210987654321098765432109876543210":PRINT "7þ";SE$(7)
860 SE$(8)="@?>=ZYXWVUTSRQPONMLKJIHGFEDCBA9876543210":PRINT "8þ";SE$(8)
870 SE$(9)="QWERTYUIOPASDFGHJKLZXCVBNM9630852741+-*/":PRINT "9þ";SE$(9)
880 PRINT:PRINT "Choose <1..9>"
890 EC$=INKEY$:IF EC$="" THEN 890
900 EC=VAL(EC$):IF EC<1 OR EC>9 OR EC<>INT(EC) THEN 780
910 Z$=SE$(EC):NS=LEN(Z$):GOTO 750
920 ' Wait for any key
930 LOCATE 21,1 :PRINT "Press any key ..."
940 K$=INKEY$:IF K$="" THEN 940
950 LOCATE 21,1 :PRINT "                 "
960 ' Print start time
970 LOCATE 14,33:B1$=TIME$:PRINT B1$:RETURN
980 ' Bubble Sort
990 LOCATE 1,1:PRINT "BUBBLE SORT"
1000 GOSUB 930                                   ' Press to start
1010 R=1                            
1020 TEST=0
1030 FOR I=1 TO NS-R
1040   X=I:Y=I+1:GOSUB 2310                      ' Pointer
1050   J=Y
1060   IF A$(I)>A$(J) THEN TEST=1:GOSUB 2400     ' Switchem
1070 NEXT:R=R+1:IF TEST=1 THEN 1020
1080 ' Job done                                  ' Done
1090 GOSUB 3060                                  ' Calculate seconds
1100 LOCATE 20,1
1110 PRINT "Done in";DN;"seconds"
1120 IF INKEY$="" THEN 1120
1130 RETURN
1140 ' Slow Sort
1150 LOCATE 1,1:PRINT "SLOW SORT"
1160 GOSUB 930                                   ' Press to start
1170 FOR I=1 TO NS-1
1180   FOR J=I+1 TO NS
1190     X=I:Y=J:GOSUB 2310                      ' Pointer
1200     IF A$(I)>A$(J) THEN GOSUB 2400          ' Switchem
1210   NEXT
1220 NEXT:GOTO 1090                              ' Done
1230 ' Shaker sort
1240 LOCATE 1,1:PRINT "SHAKER SORT"
1250 GOSUB 930                                   ' Press to start
1260 LEFT=2:RIGHT=NS
1270 FOR PTR=RIGHT TO LEFT STEP -1               ' Bubble right to left
1280   PTR2=PTR:X=PTR-1:Y=PTR:GOSUB 2310         ' Pointer
1290   I=PTR2-1:J=Y
1300   IF A$(I)>A$(J) THEN S=PTR:GOSUB 2400      ' Switchem
1310 NEXT
1320 LEFT=S+1                                    ' Do not compare items
1330 FOR PTR=LEFT TO RIGHT                       ' Bubble left to right
1340   PTR2=PTR:X=PTR-1:Y=PTR:GOSUB 2310         ' Pointer
1350   I=PTR2-1:J=Y
1360   IF A$(I)>A$(J) THEN S=PTR:GOSUB 2400      ' Switchem
1370 NEXT
1380 RIGHT=S-1
1390 IF LEFT>RIGHT THEN 1090 ELSE 1270           ' Done
1400 ' Delayed Replacement Sort
1410 LOCATE 1,1:PRINT "DELAYED REPLACEMENT SORT"
1420 GOSUB 930                                   ' Press to start
1430 J=0:R=0:I=0
1440 I=I+1:IF I=NS THEN 1090                     ' Done
1450 J=I:R=J+1
1460 X=J:Y=R:GOSUB 2310                          ' Pointer
1470 IF A$(R)>=A$(J) THEN 1480 ELSE J=R
1480 R=R+1:IF R<=NS THEN 1460
1490 IF I=J THEN 1440
1500 GOSUB 2400                                  ' Switchem
1510 GOTO 1440
1520 ' Insertion Sort
1530 LOCATE 1,1:PRINT "INSERTION SORT"
1540 GOSUB 930                                   ' Press to start
1550 FOR PTR=2 TO NS
1560   PTR2=PTR
1570   X=PTR2-1:Y=PTR2:GOSUB 2310                ' Pointer
1580   IF A$(X)<=A$(Y) THEN 1610
1590   I=PTR2-1:J=PTR2:GOSUB 2400                ' Switchem
1600   PTR2=PTR2-1:GOTO 1570
1610 NEXT:GOTO 1090                              ' Done
1620 ' Shell Sort
1630 LOCATE 1,1:PRINT "SHELL SORT"
1640 GOSUB 930                                   ' Press to start
1650 GAP=NS
1660 GAP=INT(GAP/2)
1670 LOCATE 20,1:PRINT "Gap =";GAP
1680 IF GAP=0 THEN 1090                          ' Done
1690 P=NS-GAP:H=1
1700 I=H
1710 J=I+GAP:X=I:Y=J:GOSUB 2310                  ' Pointer
1720 IF A$(I)<=A$(J) THEN 1750
1730 GOSUB 2400                                  ' Switchem
1740 I=I-GAP:IF I>=1 THEN 1710
1750 H=H+1:IF H>P THEN 1660
1760 GOTO 1700
1770 ' Binary Sort
1780 LOCATE 1,1:PRINT "BINARY SORT"
1790 GOSUB 930                                   ' Press to start
1800 FOR PTR=2 TO NS
1810   X1=1:X2=PTR
1820   X3=X1+INT((X2-X1)/2)
1830   X=PTR:Y=X3:GOSUB 2310                     ' Pointer
1840   IF A$(PTR)<A$(X3) THEN 1870
1850   IF A$(PTR)>A$(X3) THEN 1890
1860   X2=X3
1870   IF X2=X3 THEN 1910
1880   X2=X3:GOTO 1820
1890   IF X1=X3 THEN 1910
1900   X1=X3:GOTO 1820
1910   GOSUB 3140                                ' Binary Switchem
1920 NEXT:GOTO 1090                              ' Done
1930 ' Quicksort (nonrecursive)
1940 ' SL is the array stack for the left  partition bound
1950 ' SR is the array stack for the right partition bound
1960 ' S  is the pointer to the next position in the stacks
1970 LOCATE 1,1:PRINT "QUICK SORT"
1980 GOSUB 930                                   ' Press to start
1990 ' Initialize the stacks with first and last to start
2000 S=1:SL(1)=0:SR(1)=NS
2010 LEFT=SL(S):RIGHT=SR(S):S=S-1                ' Pop top request from stack
2020 ' Left = Left  bound of partition to be partitioned
2030 ' Right= Right bound of partition to be partitioned
2040 ' Now we will partition
2050   LP=LEFT:RP=RIGHT
2060   MV$=A$((LP+RP)/2)                         ' Select Middle Value
2070   IF A$(LP)<MV$ THEN LP=LP+1:GOTO 2070
2080   IF MV$<A$(RP) THEN RP=RP-1:GOTO 2080
2090 ' The last two lines selected an element in the
2100 ' upper half that belongs in the lower and in the
2110 ' lower half that belongs in the upper
2120           X=LP:Y=RP:GOSUB 2310              ' Pointer
2130           IF LP<=RP THEN 2140 ELSE 2180
2140           I=LP:J=RP
2150           IF A$(I)=A$(J) THEN 2170
2160           GOSUB 2400                        ' Switchem = Exchange
2170           LP=LP+1:RP=RP-1
2180     IF LP>RP THEN 2190 ELSE 2070
2190     IF LP<RIGHT THEN S=S+1:SL(S)=LP:SR(S)=RIGHT
2200 ' The last line pushed a partition request on the
2210 ' stack. Now we work on the other one.
2220     RIGHT=RP
2230   IF LEFT>=RIGHT THEN 2250 ELSE 2050
2240 ' Now we see if any requests are on the stack.
2250 IF S=0 THEN 1090 ELSE 2010                  ' Done
2260 ' Reset screen and exit sidesort
2270 IF F=1 THEN SCREEN 2:SCREEN 0
2280 IF F=2 THEN SCREEN 0
2290 GOTO 3630
2300 ' Pointer
2310 NC=NC+1:LOCATE 14,14:PRINT NC:IF FK=8 THEN RETURN
2320 Z=W-L+X:IF Z=279 OR Z=559 THEN 2360         ' Don't print an arrow
2330 GOSUB 2850                                  ' at 279 or 559 !!! in
2340 PRINT PT$:IF D=7 THEN 2360                  ' Insertion or Quicksort
2350 Z=W-L+Y:GOSUB 2850:PRINT PT$                ' mode. (March 26, 2003)
2360 IF FK=5 THEN 2370 ELSE DELAY=1/SH:GOSUB 3040
2370 Z=W-L+X:GOSUB 2850:PRINT " "
2380 Z=W-L+Y:GOSUB 2850:PRINT " ":RETURN
2390 ' Move two items up                     (1-2)               
2400 IF FK=8 THEN 2720
2410 FOR K=0 TO 3
2420   Z=W+I-K*L:GOSUB 2850:PRINT " "
2430   Z=Z-L    :GOSUB 2850:PRINT A$(I)
2440   IF FK=5 THEN 2450 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 3040
2450   Z=W+J-K*L:GOSUB 2850:PRINT " "
2460   Z=Z-L    :GOSUB 2850:PRINT A$(J)
2470 NEXT
2480 IF FK=5 THEN 2500 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 3040
2490 ' Move right item one up                (3)
2500 Z=W+J-K*L:GOSUB 2850:PRINT " "
2510 Z=Z-L    :GOSUB 2850:PRINT A$(J):DF=J-I
2520 ' Switch two items                      (4-5)
2530 FOR K=1 TO DF
2540   Z=W+I+K-(4*L+1):GOSUB 2850:PRINT " "
2550   Z=Z+1          :GOSUB 2850:PRINT A$(I)
2560   IF FK=5 THEN 2580
2570   IF FK=3 THEN DELAY=1/SH:GOSUB 3040 ELSE DELAY=1/99:GOSUB 3040
2580   Z=W+J-K-(5*L-1):GOSUB 2850:PRINT " "
2590   Z=Z-1          :GOSUB 2850:PRINT A$(J)
2600 NEXT
2610 ' Move two items down                   (6-7)
2620 FOR K=4 TO 0 STEP -1
2630   Z=W+J-(K+1)*L:GOSUB 2850:PRINT " "
2640   Z=Z+L        :GOSUB 2850:PRINT A$(I)
2650   IF FK=5 THEN 2660 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 3040
2660   Z=W+I-(K+1)*L:GOSUB 2850:PRINT " "
2670   Z=Z+L        :GOSUB 2850:PRINT A$(J)
2680 NEXT
2690 NE=NE+1:LOCATE 15,12:PRINT NE
2700 TEMP$=A$(I):A$(I)=A$(J):A$(J)=TEMP$:RETURN  ' swap
2710 ' Turbo
2720 Z=W+I:GOSUB 2850:PRINT " "
2730       GOSUB 2850:PRINT A$(J)
2740 Z=W+J:GOSUB 2850:PRINT " "
2750       GOSUB 2850:PRINT A$(I):GOTO 2690
2760 ' Demo switch of 9 and 0 in 99990
2770 ' ÚÄÄÄÄÄ 120 <------5------- 132 <ÄÄÄ¿3
2780 ' ³  ÚÄ> 160 -------4------> 172 <Ä¿ÄÙÄ¿
2790 ' ³  ³   200                 212   ³   ³
2800 '7³ 1³   240                 252   ³2  ³6
2810 ' ³  ³   280                 292   ³   ³
2820 ' ÀÄ>ÀÄÄ 320  323  326  329  332 ÄÄÙ<ÄÄÙ
2830 REM       9    9    9    9    0
2840 ' Convert print@ to locate subroutine - p43ec          
2850 D=INT(Z/L)+1:E=(D-1)*L:E=(Z-E)+1:LOCATE D,E:RETURN     
2860 ' Initialize Function keys                             
2870 ON KEY (9)  GOSUB 3010:KEY (9)  ON ' slower      F9    
2880 ON KEY (10) GOSUB 2990:KEY (10) ON ' faster      F10   
2890 ON KEY (3)  GOSUB 2940:KEY (3)  ON ' slow motion F3    
2900 ON KEY (4)  GOSUB 2950:KEY (4)  ON ' normal      F4    
2910 ON KEY (5)  GOSUB 2960:KEY (5)  ON ' superfast   F5    
2920 ON KEY (8)  GOSUB 2970:KEY (8)  ON ' turbo       F8    
2930 RETURN
2940 FK=3:RETURN
2950 FK=4:RETURN
2960 FK=5:RETURN
2970 FK=8:RETURN
2980 ' Select pointer speed
2990 SH=SH+1:IF SH=31 THEN SH=30 ' Increase
3000 LOCATE 15,24:PRINT "Speed  =";SH:RETURN
3010 SH=SH-1:IF SH=0  THEN SH=1  ' Decrease
3020 GOTO 3000
3030 ' Variable time delay
3040 START=TIMER:WHILE TIMER<START+DELAY:WEND:RETURN
3050 ' Calculate seconds past
3060 LOCATE 13,33:B2$=TIME$:PRINT B2$
3070 B$=B1$:GOSUB 3110:H1$=H$:M1$=M$:S1$=S$
3080 B$=B2$:GOSUB 3110:H2$=H$:M2$=M$:S2$=S$
3090 H1=VAL(H1$):M1=VAL(M1$):S1=VAL(S1$):H2=VAL(H2$):M2=VAL(M2$):S2=VAL(S2$)
3100 NW=(H2*3600)+(M2*60)+S2:BG=(H1*3600)+(M1*60)+S1:DN=NW-BG:RETURN
3110 H$=MID$(B$,1,2):M$=MID$(B$,4,2):S$=MID$(B$,7,2):RETURN
3120 ' Binary sort screen output subroutine
3130 ' Move one item up
3140 J=PTR:I=X2:IF FK=8 THEN 3520
3150 DF=0:FOR PTR2=PTR TO X2+1 STEP -1:DF=DF+1:NEXT
3160 IF DF=0 THEN RETURN
3170 FOR K=0 TO 3
3180   IF FK=5 THEN 3190 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 3040
3190   Z=W+J-K*L:GOSUB 2850:PRINT " "
3200   Z=Z-L    :GOSUB 2850:PRINT A$(J)
3210 NEXT
3220 IF FK=5 THEN 3240 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 3040
3230 ' Move item to the left
3240 FOR K=1 TO DF:IF FK=5 THEN 3260
3250   IF FK=3 THEN DELAY=1/SH:GOSUB 3040 ELSE DELAY=1/99:GOSUB 3040
3260   Z=W+J-K-(4*L-1):GOSUB 2850:PRINT " "
3270   Z=Z-1          :GOSUB 2850:PRINT A$(J)
3280 NEXT
3290 ' Move item down
3300 FOR K=3 TO 1 STEP -1
3310   IF FK=5 THEN 3320 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 3040 ELSE DELAY=1/99:GOSUB 3040
3320   Z=W+I-(K+1)*L:GOSUB 2850:PRINT " "
3330   Z=Z+L        :GOSUB 2850:PRINT A$(J)
3340 NEXT
3350 TEMP$=A$(J):IF FK=5 THEN 3370 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 3040
3360 ' Move items to the right
3370 H$=A$(PTR)
3380 FOR PTR2=PTR TO X2+1 STEP -1
3390   A$(PTR2)=A$(PTR2-1)
3400   Z=W+(PTR2-1):GOSUB 2850:PRINT " "
3410   Z=Z+1       :GOSUB 2850:PRINT A$(PTR2)
3420 NEXT
3430 A$(X2)=H$
3440 IF FK=5 THEN 3460 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 3040
3450 ' Move item into the list
3460 K=0
3470 Z=W+I-(K+1)*L:GOSUB 2850:PRINT " "
3480 Z=Z+L        :GOSUB 2850:PRINT TEMP$
3490 NE=NE+1:LOCATE 15,12:PRINT NE
3500 RETURN
3510 ' Turbo Binary Sort
3520 H$=A$(PTR)
3530 FOR PTR2=PTR TO X2+1 STEP -1
3540   A$(PTR2)=A$(PTR2-1)
3550 NEXT
3560 A$(X2)=H$
3570 IF FK<>8 THEN RETURN
3580 LOCATE 9,1
3590 FOR K=1 TO NS
3600   PRINT A$(K);
3610 NEXT:GOTO 3490
3620 ' Exit friendly
3630 KEY 5,"sidesort.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS:END
3640 ' Bubble Sort                80 Micro, October 1986 page 120
3650 ' Slow Sort                  80 Micro, October 1986 page 120
3660 ' Shaker Sort                http://homepages.unl.ac.uk/~chalkp/proj/algtutor/shakersort.html
3670 ' Delayed Replacement Sort   Visisort 80-U.S. Journal, page 50
3680 ' Insertion Sort             80 Micro, October 1986 page 122
3690 ' Shell Metzner Sort         Visisort 80-U.S. Journal, page 52
3700 ' Binary Sort                BASIC-subroutines, K. Tracton page 74
3710 ' Quicksort                  Microcomputing, November 1981 page 157
