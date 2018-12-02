10 CLS:KEY OFF:Z=80:SH=15:RANDOMIZE TIMER ' sidesort.bas - April 4, 2003
20 DIM A$(Z),S$(Z),SL(Z),SR(Z):GOSUB 2750:PT$=CHR$(25):COLOR 12,0
30 PRINT "**************************"
40 PRINT "* ANIMATED SORT ROUTINES *"
50 PRINT "*          by            *"
60 PRINT "*     Eric F. Tchong     *"
70 PRINT "*  serenata@setarnet.aw  *"
80 PRINT "*       N.C.C. 49-I      *"
90 PRINT "* San Nicolas ---- ARUBA *"
100 PRINT "**************************":PRINT:PRINT:COLOR 14,0
110 PRINT "**************************"
120 PRINT "*  Screen <1> or <2> ?   *"
130 PRINT "*  Choose <?>            *"
140 PRINT "**************************":PRINT
150 CH$=INKEY$:IF CH$=""THEN 150
160 F=VAL(CH$):IF F<1 OR F>2 OR F<>INT(F) THEN CLS:GOTO 110
170 IF F=1 THEN SCREEN F:SWS=1:L=40:GOTO 200
180 IF F=2 THEN SCREEN F:SWS=1:L=80
190 ' Begin main program
200 CLS:W=L*8-1:IF F=1 AND NS>40 THEN NS=40
210 PRINT "* S I D E S O R T  XP GOLD *":PRINT
220 PRINT "1) Slow sort................"
230 PRINT "2) Bubble sort.............."
240 PRINT "3) Delayed replacement sort."
250 PRINT "4) Insertion sort..........."
260 PRINT "5) Binary sort.............."
270 PRINT "6) Shell-Metzner sort......."
280 PRINT "7) Quicksort................"
290 PRINT "8) Return screen set menu..."
300 PRINT "9) Exit program............."
310 PRINT:PRINT "Which choice ?"
320 CH$=INKEY$:IF CH$=""THEN 320
330 CH=VAL(CH$):IF CH<1 OR CH>9 OR CH<>INT(CH) THEN 200
340 IF CH=8 THEN CLS:GOTO 110 ELSE IF CH=9 THEN 2150
350 CLS:GOSUB 500:LOCATE 10,1:NE=0:NC=0
360 ' Print data
370 FOR K=1 TO NS:A$(K)=S$(K):Z=W+K:GOSUB 2730:PRINT A$(K);:NEXT
380 ' User's info
390 LOCATE 13,1 :PRINT "Items ="NS      :LOCATE 13,24:PRINT "Finish ="
400 LOCATE 14,1 :PRINT "Comparisons ="NC:LOCATE 14,24:PRINT "Start  ="
410 LOCATE 15,1 :PRINT "Exchanges ="NE  :LOCATE 15,24:PRINT "Speed  =";SH
420 LOCATE 17,1 :PRINT "Slowmotion F3   Normal F4   Superfast F5"
430 LOCATE 18,1 :PRINT "    Slower F9   Faster F10  Turbo F8"
440 ON CH GOSUB 1140,970,1240,1370,1640,1480,1840
450 LOCATE 21,1 :PRINT "Resort original list (y/n)"
460 RF$=INKEY$:IF RF$="" THEN 460 ELSE 470
470 IF RF$<>"y" AND RF$<>"Y" AND RF$<>"n" AND RF$<>"N" THEN RF$="y":GOTO 200
480 GOTO 200
490 ' Define quantity
500 IF RF$="Y" OR RF$="y" THEN 750
510 IF F=1 THEN 520 ELSE 550
520 INPUT "How many items <Max=40>";NS$:NS=VAL(NS$)
530 IF NS=0 THEN NS=40:GOTO 590
540 IF NS<2 OR NS>40 OR NS<>INT(NS) THEN 520 ELSE 590
550 INPUT "How many items <Max=80>";NS$:NS=VAL(NS$)
560 IF NS=0 THEN NS=80:GOTO 590
570 IF NS<2 OR NS>80 OR NS<>INT(NS) THEN 550
580 ' Make a choice 
590 PRINT:PRINT "(U)ser (S)amples (C)omputer"
600 R1$=INKEY$:IF R1$="" THEN 600
610 IF R1$="U" OR R1$="u" THEN 700
620 IF R1$="S" OR R1$="s" THEN 770
630 PRINT "(N)umbers or (L)etters "
640 R$=INKEY$:IF R$="" THEN 640
650 ' (C)omputer generates random letters or numbers
660 FOR K=1 TO NS
670   IF LEFT$(R$,1)="L" OR LEFT$(R$,1)="l" THEN S$(K)=CHR$(INT(RND(1)*26+65)) ELSE S$(K)=CHR$(INT(RND(1)*10+48))
680 NEXT:GOTO 750
690 ' (U)sers input
700 IF F=1 THEN PRINT:PRINT "Enter a string <=40 ":GOTO 720
710 PRINT:PRINT "Enter a string <=80 "
720 PRINT STRING$(NS,".");
730 LINE INPUT Z$:NS=LEN(Z$)
740 FOR K=1 TO NS:S$(K)=MID$(Z$,K,1):NEXT K
750 RF$="N":CLS:RETURN
760 ' (S)amples
770 CLS:SE$(1)="0123456789":PRINT "1þ";SE$(1)
780 SE$(2)="9876543210":PRINT "2þ";SE$(2)
790 SE$(3)="8094357261":PRINT "3þ";SE$(3):PRINT
800 SE$(4)="ABCDEFGHIJKLMNOPQRSTUVWXYZ":PRINT "4þ";SE$(4)
810 SE$(5)="ZYXWVUTSRQPONMLKJIHGFEDCBA":PRINT "5þ";SE$(5):PRINT
820 SE$(6)="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789":PRINT "6þ";SE$(6):PRINT
830 SE$(7)="9876543210987654321098765432109876543210":PRINT "7þ";SE$(7)
840 SE$(8)="@?>=ZYXWVUTSRQPONMLKJIHGFEDCBA9876543210":PRINT "8þ";SE$(8)
850 SE$(9)="QWERTYUIOPASDFGHJKLZXCVBNM9630852741+-*/":PRINT "9þ";SE$(9)
860 PRINT:PRINT "Choose <1..9>"
870 EC$=INKEY$:IF EC$="" THEN 870
880 EC=VAL(EC$):IF EC<1 OR EC>9 OR EC<>INT(EC) THEN 770
890 Z$=SE$(EC):NS=LEN(Z$):GOTO 740
900 ' Wait for any key
910 LOCATE 21,1 :PRINT "Press any key ..."
920 K$=INKEY$:IF K$="" THEN 920
930 LOCATE 21,1 :PRINT "                 ":RETURN
940 ' Print start time
950 LOCATE 14,33:B1$=TIME$:PRINT B1$:RETURN
960 ' Bubble Sort
970 LOCATE 1,1:PRINT "BUBBLE SORT"
980 GOSUB 910                                   ' Wait
990 GOSUB 950                                   ' Start
1000 R=1                            
1010 TEST=0
1020 FOR I=1 TO NS-R
1030   X=I:Y=I+1:GOSUB 2190                      ' Pointer
1040   J=Y
1050   IF A$(I)>A$(J) THEN TEST=1:GOSUB 2280     ' Switchem
1060 NEXT I:R=R+1:IF TEST=1 THEN 1010
1070 ' Job done                                  ' Done
1080 GOSUB 2940                                  ' Calculate seconds
1090 LOCATE 20,1
1100 PRINT "Done in";DN;"seconds"
1110 GOSUB 910                                   ' Wait
1120 RETURN
1130 ' Slow Sort
1140 LOCATE 1,1:PRINT "SLOW SORT"
1150 GOSUB 910                                   ' Wait
1160 GOSUB 950                                   ' Start
1170 FOR I=1 TO NS-1
1180   FOR J=I+1 TO NS
1190     X=I:Y=J:GOSUB 2190                      ' Pointer
1200     IF A$(I)>A$(J) THEN GOSUB 2280          ' Switchem
1210   NEXT J
1220 NEXT I:GOTO 1080                            ' Done
1230 ' Delayed Replacement Sort
1240 LOCATE 1,1:PRINT "DELAYED REPLACEMENT SORT"
1250 GOSUB 910                                   ' Wait
1260 GOSUB 950                                   ' Start
1270 J=0:R=0:I=0
1280 I=I+1:IF I=NS THEN 1080                     ' Done
1290 J=I:R=J+1
1300 X=J:Y=R:GOSUB 2190                          ' Pointer
1310 IF A$(R)>=A$(J) THEN 1320 ELSE J=R
1320 R=R+1:IF R<=NS THEN 1300
1330 IF I=J THEN 1280
1340 GOSUB 2280                                  ' Switchem
1350 GOTO 1280
1360 ' Insertion Sort
1370 LOCATE 1,1:PRINT "INSERTION SORT"
1380 GOSUB 910                                   ' Wait
1390 GOSUB 950                                   ' Start
1400 FOR PTR=2 TO NS
1410   PTR2=PTR
1420   X=PTR2-1:Y=PTR2:GOSUB 2190                ' Pointer
1430   IF A$(X)<=A$(Y) THEN 1460
1440   I=PTR2-1:J=PTR2:GOSUB 2280                ' Switchem
1450   PTR2=PTR2-1:GOTO 1420
1460 NEXT PTR:GOTO 1080                          ' Done
1470 ' Shell Metzner Sort
1480 LOCATE 1,1:PRINT "SHELL-METZNER SORT"
1490 GOSUB 910                                   ' Wait
1500 GOSUB 950                                   ' Start
1510 GAP=NS
1520 GAP=INT(GAP/2)
1530 LOCATE 20,1:PRINT "Gap =";GAP
1540 IF GAP=0 THEN 1080                          ' Done
1550 P=NS-GAP:H=1
1560 I=H
1570 J=I+GAP:X=I:Y=J:GOSUB 2190                  ' Pointer
1580 IF A$(I)<=A$(J) THEN 1610
1590 GOSUB 2280                                  ' Switchem
1600 I=I-GAP:IF I>=1 THEN 1570
1610 H=H+1:IF H>P THEN 1520
1620 GOTO 1560
1630 ' Binary Sort
1640 LOCATE 1,1:PRINT "BINARY SORT"
1650 GOSUB 910                                   ' Wait
1660 GOSUB 950                                   ' Start
1670 FOR PTR=2 TO NS
1680   X1=1:X2=PTR
1690   X3=X1+INT((X2-X1)/2)
1700   X=PTR:Y=X3:GOSUB 2190                     ' Pointer
1710   IF A$(PTR)<A$(X3) THEN 1740
1720   IF A$(PTR)>A$(X3) THEN 1760
1730   X2=X3
1740   IF X2=X3 THEN 1780
1750   X2=X3:GOTO 1690
1760   IF X1=X3 THEN 1780
1770   X1=X3:GOTO 1690
1780   GOSUB 3020                                ' Binary Switchem
1790 NEXT PTR:GOTO 1080                          ' Done
1800 ' Quicksort (nonrecursive)
1810 ' SL is the array stack for the left  partition bound
1820 ' SR is the array stack for the right partition bound
1830 ' S  is the pointer to the next position in the stacks
1840 LOCATE 1,1:PRINT "QUICK SORT"
1850 GOSUB 910                                   ' Wait
1860 GOSUB 950                                   ' Start
1870 ' Initialize the stacks with first and last to start
1880 S=1:SL(1)=0:SR(1)=NS
1890 LEFT=SL(S):RIGHT=SR(S):S=S-1                ' Pop top request from stack
1900 ' Left = Left  bound of partition to be partitioned
1910 ' Right= Right bound of partition to be partitioned
1920 ' Now we will partition
1930   LP=LEFT:RP=RIGHT
1940   MV$=A$((LP+RP)/2)                         ' Select Middle Value
1950   IF A$(LP)<MV$ THEN LP=LP+1:GOTO 1950
1960   IF MV$<A$(RP) THEN RP=RP-1:GOTO 1960
1970 ' The last two lines selected an element in the
1980 ' upper half that belongs in the lower and in the
1990 ' lower half that belongs in the upper
2000           X=LP:Y=RP:GOSUB 2190              ' Pointer
2010           IF LP<=RP THEN 2020 ELSE 2060
2020           I=LP:J=RP
2030           IF A$(I)=A$(J) THEN 2050
2040           GOSUB 2280                        ' Switchem = Exchange
2050           LP=LP+1:RP=RP-1
2060     IF LP>RP THEN 2070 ELSE 1950
2070     IF LP<RIGHT THEN S=S+1:SL(S)=LP:SR(S)=RIGHT
2080 ' The last line pushed a partition request on the
2090 ' stack. Now we work on the other one.
2100     RIGHT=RP
2110   IF LEFT>=RIGHT THEN 2130 ELSE 1930
2120 ' Now we see if any requests are on the stack.
2130 IF S=0 THEN 1080 ELSE 1890                  ' Done
2140 ' Reset screen and exit sidesort
2150 IF F=1 THEN SCREEN 2:SCREEN 0
2160 IF F=2 THEN SCREEN 0
2170 GOTO 3510
2180 ' Pointer
2190 NC=NC+1:LOCATE 14,14:PRINT NC:IF FK=8 THEN RETURN
2200 Z=W-L+X:IF Z=279 OR Z=559 THEN 2240         ' Don't print an arrow
2210 GOSUB 2730                                  ' at 279 or 559 !!! in
2220 PRINT PT$:IF D=7 THEN 2240                  ' Insertion or Quicksort
2230 Z=W-L+Y:GOSUB 2730:PRINT PT$                ' mode. (March 26, 2003)
2240 IF FK=5 THEN 2250 ELSE DELAY=1/SH:GOSUB 2920
2250 Z=W-L+X:GOSUB 2730:PRINT " "
2260 Z=W-L+Y:GOSUB 2730:PRINT " ":RETURN
2270 ' Move two items up                     (1-2)               
2280 IF FK=8 THEN 2600
2290 FOR K=0 TO 3
2300   Z=W+I-K*L:GOSUB 2730:PRINT " "
2310   Z=Z-L    :GOSUB 2730:PRINT A$(I)
2320   IF FK=5 THEN 2330 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2920
2330   Z=W+J-K*L:GOSUB 2730:PRINT " "
2340   Z=Z-L    :GOSUB 2730:PRINT A$(J)
2350 NEXT
2360 IF FK=5 THEN 2380 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2920
2370 ' Move right item one up                (3)
2380 Z=W+J-K*L:GOSUB 2730:PRINT " "
2390 Z=Z-L    :GOSUB 2730:PRINT A$(J):DF=J-I
2400 ' Switch two items                      (4-5)
2410 FOR K=1 TO DF
2420   Z=W+I+K-(4*L+1):GOSUB 2730:PRINT " "
2430   Z=Z+1          :GOSUB 2730:PRINT A$(I)
2440   IF FK=5 THEN 2460
2450   IF FK=3 THEN DELAY=1/SH:GOSUB 2920 ELSE DELAY=1/99:GOSUB 2920
2460   Z=W+J-K-(5*L-1):GOSUB 2730:PRINT " "
2470   Z=Z-1          :GOSUB 2730:PRINT A$(J)
2480 NEXT
2490 ' Move two items down                   (6-7)
2500 FOR K=4 TO 0 STEP -1
2510   Z=W+J-(K+1)*L:GOSUB 2730:PRINT " "
2520   Z=Z+L        :GOSUB 2730:PRINT A$(I)
2530   IF FK=5 THEN 2540 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2920
2540   Z=W+I-(K+1)*L:GOSUB 2730:PRINT " "
2550   Z=Z+L        :GOSUB 2730:PRINT A$(J)
2560 NEXT
2570 NE=NE+1:LOCATE 15,12:PRINT NE
2580 TEMP$=A$(I):A$(I)=A$(J):A$(J)=TEMP$:RETURN  ' swap
2590 ' Turbo
2600 Z=W+I:GOSUB 2730:PRINT " "
2610       GOSUB 2730:PRINT A$(J)
2620 Z=W+J:GOSUB 2730:PRINT " "
2630       GOSUB 2730:PRINT A$(I):GOTO 2570
2640 ' Demo switch of 9 and 0 in 99990
2650 ' ÚÄÄÄÄÄ 160 <------5------- 164 <ÄÄÄ¿3
2660 ' ³  ÚÄ> 240 -------4------> 244 <Ä¿ÄÙÄ¿
2670 ' ³  ³   320                 324   ³   ³
2680 '7³ 1³   400                 404   ³2  ³6
2690 ' ³  ³   480                 484   ³   ³
2700 ' ÀÄ>ÀÄÄ 560  561  562  563  564 ÄÄÙ<ÄÄÙ
2710 REM       9    9    9    9    0
2720 ' Convert print@ to locate subroutine - p43ec          
2730 D=INT(Z/L)+1:E=(D-1)*L:E=(Z-E)+1:LOCATE D,E:RETURN     
2740 ' Initialize Function keys                             
2750 ON KEY (9)  GOSUB 2890:KEY (9)  ON ' slower      F9    
2760 ON KEY (10) GOSUB 2870:KEY (10) ON ' faster      F10   
2770 ON KEY (3)  GOSUB 2820:KEY (3)  ON ' slow motion F3    
2780 ON KEY (4)  GOSUB 2830:KEY (4)  ON ' normal      F4    
2790 ON KEY (5)  GOSUB 2840:KEY (5)  ON ' superfast   F5    
2800 ON KEY (8)  GOSUB 2850:KEY (8)  ON ' turbo       F8    
2810 RETURN
2820 FK=3:RETURN
2830 FK=4:RETURN
2840 FK=5:RETURN
2850 FK=8:RETURN
2860 ' Select pointer speed
2870 SH=SH+1:IF SH=31 THEN SH=30 ' Increase
2880 LOCATE 15,24:PRINT "Speed  =";SH:RETURN
2890 SH=SH-1:IF SH=0  THEN SH=1  ' Decrease
2900 GOTO 2880
2910 ' Variable time delay
2920 START=TIMER:WHILE TIMER<START+DELAY:WEND:RETURN
2930 ' Calculate seconds past
2940 LOCATE 13,33:B2$=TIME$:PRINT B2$
2950 B$=B1$:GOSUB 2990:H1$=H$:M1$=M$:S1$=S$
2960 B$=B2$:GOSUB 2990:H2$=H$:M2$=M$:S2$=S$
2970 H1=VAL(H1$):M1=VAL(M1$):S1=VAL(S1$):H2=VAL(H2$):M2=VAL(M2$):S2=VAL(S2$)
2980 NW=(H2*3600)+(M2*60)+S2:BG=(H1*3600)+(M1*60)+S1:DN=NW-BG:RETURN
2990 H$=MID$(B$,1,2):M$=MID$(B$,4,2):S$=MID$(B$,7,2):RETURN
3000 ' Binary sort screen output subroutine
3010 ' Move one item up
3020 J=PTR:I=X2:IF FK=8 THEN 3400
3030 DF=0:FOR PTR2=PTR TO X2+1 STEP -1:DF=DF+1:NEXT
3040 IF DF=0 THEN RETURN
3050 FOR K=0 TO 3
3060   IF FK=5 THEN 3070 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2920
3070   Z=W+J-K*L:GOSUB 2730:PRINT " "
3080   Z=Z-L    :GOSUB 2730:PRINT A$(J)
3090 NEXT
3100 IF FK=5 THEN 3120 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2920
3110 ' Move item to the left
3120 FOR K=1 TO DF:IF FK=5 THEN 3140
3130   IF FK=3 THEN DELAY=1/SH:GOSUB 2920 ELSE DELAY=1/99:GOSUB 2920
3140   Z=W+J-K-(4*L-1):GOSUB 2730:PRINT " "
3150   Z=Z-1          :GOSUB 2730:PRINT A$(J)
3160 NEXT
3170 ' Move item down
3180 FOR K=3 TO 1 STEP -1
3190   IF FK=5 THEN 3200 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2920 ELSE DELAY=1/99:GOSUB 2920
3200   Z=W+I-(K+1)*L:GOSUB 2730:PRINT " "
3210   Z=Z+L        :GOSUB 2730:PRINT A$(J)
3220 NEXT
3230 TEMP$=A$(J):IF FK=5 THEN 3250 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2920
3240 ' Move items to the right
3250 H$=A$(PTR)
3260 FOR PTR2=PTR TO X2+1 STEP -1
3270   A$(PTR2)=A$(PTR2-1)
3280   Z=W+(PTR2-1):GOSUB 2730:PRINT " "
3290   Z=Z+1       :GOSUB 2730:PRINT A$(PTR2)
3300 NEXT PTR2
3310 A$(X2)=H$
3320 IF FK=5 THEN 3340 ELSE IF FK=3 THEN DELAY=1/SH:GOSUB 2920
3330 ' Move item into the list
3340 K=0
3350 Z=W+I-(K+1)*L:GOSUB 2730:PRINT " "
3360 Z=Z+L        :GOSUB 2730:PRINT TEMP$
3370 NE=NE+1:LOCATE 15,12:PRINT NE
3380 RETURN
3390 ' Turbo Binary Sort
3400 H$=A$(PTR)
3410 FOR PTR2=PTR TO X2+1 STEP -1
3420   A$(PTR2)=A$(PTR2-1)
3430 NEXT PTR2
3440 A$(X2)=H$
3450 IF FK<>8 THEN RETURN
3460 LOCATE 9,1
3470 FOR K=1 TO NS
3480   PRINT A$(K);
3490 NEXT:GOTO 3370
3500 ' Exit friendly
3510 KEY 5,"sidesort.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS:END
3520 ' Bubble Sort                80 Micro, October 1986 page 120
3530 ' Slow Sort                  80 Micro, October 1986 page 120
3540 ' Delayed Replacement Sort   Visisort 80-U.S. Journal page 50
3550 ' Insertion Sort             80 Micro, October 1986 page 122
3560 ' Shell Metzner Sort         Visisort 80-U.S. Journal, page 52
3570 ' Binary Sort                BASIC-subroutines, K. Tracton page 74
3580 ' Quicksort                  Microcomputing, November 1981 page 157
