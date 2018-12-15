10 ' visifrac.bas - April 21, 2004 - Freeware
20 GOTO 230 ' begin
30 'SAVE "fraction":LIST -210
40 GOTO 1410 ' search for GCD
50 GOTO 1450 ' scan operation * / + -
60 GOTO 2060 ' analyse +
70 GOTO 3050 ' analyse -
80 GOTO 3770 ' wait key pressed
90 GOTO 3780 ' get key input
100 GOTO 4970 ' calculate length and exact position
110 GOTO 5420 ' print numerators   + -
120 GOTO 5500 ' print denominators + -
130 GOTO 5590 ' count digits
140 GOTO 5620 ' draw fraction lines ÄÄÄ ---
150 GOTO 6280 ' print numerators   * /
160 GOTO 6350 ' print denominators * /
170 GOTO 6430 ' get final answer
180 GOTO 6520 ' help info
190 GOTO 7400 ' scan repeating decimal input
200 GOTO 7630 ' clear line
210 GOTO 7660 ' scan fraction input
220 ' begin
230 DEFDBL G,T,N,Z,E,M:COLOR 7,0:KEY OFF:CLS
240 M1$="8":M2$="2":M3$="5":M4$="3":M5$="1"
250 M6$="4":M7$="2.708(3)":G(8)=8:T(8)=2:N(8)=5
260 RP=0:W$=MKI$(0):K$="+":O$(1)=" x":O$(2)=" :"
270 O$(3)=" +":O$(4)=" -"
280 PRINT "**************************************"
290 PRINT "* FOUR FUNCTION FRACTIONS CALCULATOR *"
300 PRINT "*       Programmed in GW-BASIC       *"
310 PRINT "*    Compiled with PowerBasic 3.2    *"
320 PRINT "*          by Eric F. Tchong         *"
330 PRINT "*        serenata@setarnet.aw        *"
340 PRINT "*               ARUBA                *"
350 PRINT "*   (C) May 1992  -  Freeware 2004   *"
360 PRINT "**************************************"
370 PRINT
380 PRINT "For instructions: press <Yy> ?"
390 GOSUB 90 ' get key input
400 IF F=89 OR F=121 THEN CLS:GOSUB 180 ' help info
410 CLS:PRINT "For a diskfile:   press <Yy> ?"
420 GOSUB 90 ' get key input
430 IF F=89 OR F=121 THEN COPY=1 ELSE COPY=0
440 IF COPY THEN 450 ELSE 500
450 CLS:PRINT "Enter a DOS filename ? ";
460 LINE INPUT Z$
470 IF LEFT$(Z$,1)=" " THEN Z$=MID$(Z$,2):GOTO 470
480 OPEN "O",#1,Z$
490 ' Select chain or variabel calculation
500 CLS
510 PRINT "1. Chain    calculation"
520 PRINT "2. Variabel calculation"
530 PRINT "3. Convert a repeating decimal"
540 PRINT "4. Exit this program ..":PRINT
550 INPUT "Choose 1, 2, 3, or 4 ";A:CLS
560 IF A<1 OR A>4 THEN CLS:GOTO 500
570 IF A=4 THEN 7060
580 IF A=3 THEN RP=1:GOTO 7090 ' repeating decimal
590 ' Display intermediate or final results only
600 PRINT "1. Display final results only."
610 PRINT "2. Display intermediate and final results.":PRINT
620 INPUT "Choose 1 or 2 ";B:CLS
630 IF B<1 OR B>2 THEN CLS:GOTO 600
640 ' Empty strings = recall memory, 0 = return to menu
650 FOR X=0 TO 7
660  G(X)=0 ' G(X) = whole number
670  T(X)=0 ' T(X) = numerator
680  N(X)=1 ' N(X) = denominator
690 NEXT
700 IF RP=1 THEN 7090 ' repeating decimal
710 IF N(8)=1 THEN T(8)=0
720 IF A=1 THEN M1$=STR$(G(8)):M2$=STR$(T(8)):M3$=STR$(N(8))
730 COLOR 7,0:PRINT
740 ' Get first fraction
750 LINE INPUT "1) W.N/D 0 menu ? ";B1$
760 IF B1$="0" THEN 500
770 B$=B1$:GOSUB 210 ' scan fractional input
780 IF NG=0 THEN 750
790 G1$=G$:T1$=T$:N1$=N$
800 IF G1$="" AND T1$="" THEN G1$=M1$:T1$=M2$:N1$=M3$:GOTO 830
810 IF G1$="0" THEN CLS:GOTO 500
820 M1$=G1$:M2$=T1$:M3$=N1$
830 G$="":T$="":N$=""
840 PRINT "   + - * /      ? ";K$
850 ' Obtain operation
860 R$=INKEY$:IF R$="" THEN 860
870 IF R$=CHR$(13) THEN R$=K$
880 K$=R$:PRINT CHR$(30);"   + - * /      ? ";K$
890 GOSUB 50 ' scan operation
900 IF C=0 THEN 860
910 ' Get second fraction
920 LINE INPUT "2) W.N/D        ? ";B2$
930 B$=B2$:GOSUB 210 ' scan fractional input
940 IF NG=0 THEN 920
950 G2$=G$:T2$=T$:N2$=N$
960 IF G2$="" AND T2$="" THEN G2$=M4$:T2$=M5$:N2$=M6$:GOTO 980
970 M4$=G2$:M5$=T2$:M6$=N2$
980 G$="":T$="":N$=""
990 ' Save first & second fraction
1000 G(0)=VAL(G1$):T(0)=VAL(T1$):N(0)=VAL(N1$)
1010 G(1)=VAL(G2$):T(1)=VAL(T2$):N(1)=VAL(N2$):PRINT
1020 ' Reduce fractions 4/8 = 1/2, 10/5 = 5/1
1030 TN=T(0):NN=N(0):GOSUB 40 ' search GCD
1040 T(0)=T(0)/GCD:N(0)=N(0)/GCD ' reduce
1050 TN=T(1):NN=N(1):GOSUB 40 ' search GCD
1060 T(1)=T(1)/GCD:N(1)=N(1)/GCD ' reduce
1070 ' Numerator > denominator 7 8/5 = 8 3/5
1080 IF T(0)>N(0) THEN G(0)=G(0)+INT(T(0)/N(0)):T(0)=T(0)-INT(T(0)/N(0))*N(0)
1090 IF T(1)>N(1) THEN G(1)=G(1)+INT(T(1)/N(1)):T(1)=T(1)-INT(T(1)/N(1))*N(1)
1100 ' 3 3/3 = 4
1110 IF T(0)=N(0) THEN G(0)=G(0)+1:T(0)=0:N(0)=1
1120 IF T(1)=N(1) THEN G(1)=G(1)+1:T(1)=0:N(1)=1
1130 ' T1 = 2 + 8 * 5 = 42   8 2/5
1140 ' T2 = 1 + 3 * 4 = 13   3 1/4
1150 T1=T(0)+G(0)*N(0):T2=T(1)+G(1)*N(1)
1160 ' If zero go Module 1 + -
1170 IF G(1)=0 AND T(1)=0 AND C=1 THEN G(2)=0:N(2)=1:COLOR 14,0:GOTO 3820
1180 ' Select * / + -
1190 ON C GOTO 1210,1300,1970,2850
1200 ' Start multiplication solving
1210 COLOR 14,0
1220 TN=T1*T2         ' TN = 42 * 13 = 546
1230 NN=N(0)*N(1)     ' NN =  5 *  4 = 20
1240 GOSUB 170        ' get final answer
1250 IF B=1 THEN 1380 ' go display final answer
1260 GOSUB 1500       ' analyse *
1270 ' Modules 1, 2, 3, 4 * /   Module 1 + -
1280 ON V GOTO 5660,5830,5980,6130,3820
1290 ' Start division solving
1300 COLOR 15,0
1310 IF G(1)=0 AND N(1)=1 THEN PRINT "Division by zero":GOTO 650
1320 TN=T1*N(1)       ' TN = 42 *  4 = 168
1330 NN=N(0)*T2       ' NN =  5 * 13 = 65
1340 GOSUB 170        ' get final answer
1350 IF B=1 THEN 1380 ' go display final answer
1360 GOTO 1260        ' analyse /
1370 ' Final results only
1380 G(2)=G(8):T(2)=T(8):N(2)=N(8)
1390 GOTO 3820
1400 ' Search for GCD
1410 M=TN:N=NN
1420 WHILE M:N=N-M*INT(N/M):SWAP M,N:WEND
1430 GCD=N:RETURN
1440 ' Scan operation * / + -
1450 IF R$<>"*" OR R$<>"/" OR R$<>"+" OR R$<>"-" THEN C=0
1460 IF R$="*" THEN C=1 ELSE IF R$="/" THEN C=2 ELSE IF R$="+" THEN C=3
1470 IF R$="-" THEN C=4
1480 IF C<1 OR C>4 THEN PRINT CHR$(30);"   What ??":RETURN ELSE RETURN
1490 ' Analyse if the * or / problem is of the V=1,2,3,4 or 5 form
1500 IF C=1 THEN 1520 ELSE 1550
1510 ' Multiplication
1520 T(2)=G(0)*N(0)+T(0):T(3)=G(1)*N(1)+T(1)
1530 N(3)=N(1):N(2)=N(0):GOTO 1580
1540 ' Division
1550 T(2)=G(0)*N(0)+T(0):N(3)=G(1)*N(1)+T(1)
1560 T(3)=N(1):N(2)=N(0):GOTO 1580
1570 ' Process * / problem
1580 TN=T(2):NN=N(3):GOSUB 40 ' search GCD
1590 GCD1=GCD
1600 TN=T(3):NN=N(2):GOSUB 40 ' search GCD
1610 GCD2=GCD:IF GCD1=1 AND GCD2=1 THEN 1770
1620 ' Reduce fractions
1630 T(4)=T(2)/GCD1:N(5)=N(3)/GCD1
1640 N(4)=N(2)/GCD2:T(5)=T(3)/GCD2
1650 T(6)=T(4)*T(5):N(6)=N(4)*N(5)
1660 IF T(6)<N(6) THEN 1870
1670 '    10 x 1/2   = 5   1 25/66 x 30 6/13 = 42
1680 ' 3 5/7 : 1 6/7 = 2   6 4/11  : 10/11   = 7
1690 IF N(6)=1 THEN 1700 ELSE 1740
1700 G(7)=T(6)
1710 V=4:RETURN
1720 ' 12 2/45 x 7 3/8 = 88 149/180
1730 ' 2 3/26  : 1 5/6 = 1 2/13     3/4 : 5/8 = 1 1/5   
1740 G(7)=INT(T(6)/N(6)):T(7)=T(6)-G(7)*N(6):N(7)=N(6)
1750 V=4:RETURN
1760 ' Can not reduce fractions
1770 T(4)=T(2)*T(3):N(4)=N(2)*N(3)
1780 ' 2 x 1/5 = 2/5   3/4 : 2 = 3/8
1790 IF T(0)=T(2) AND N(0)=N(2) AND T(1)=T(3) AND N(1)=N(3) THEN 1940
1800 IF T(4)<N(4) THEN 1810 ELSE 1840
1810 V=1:RETURN
1820 ' 3 x 2 = 3/1 x 2/1 = 6/1 = 6   5 7/9 x 6 8/11 = 38 86/99
1830 ' 999 : 6 1/2 = 153 9/13        7 3/4 : 2 1/3 = 3 9/28
1840 G(5)=INT(T(4)/N(4)):T(5)=T(4)-G(5)*N(4):N(5)=N(4)
1850 V=2:RETURN
1860 ' 4 1/2 : 45 = 1/10   2 4/9 : 3 2/3 = 2/3
1870 IF T(0)=T(2) AND N(0)=N(2) AND T(1)=T(3) AND N(1)=N(3) THEN 1900
1880 V=3:RETURN
1890 ' 2/5 x 7/24 = 1/5 x 7/12 = 7/60   2/5 x 3/4 = 1/5 x 3/2 = 3/10
1900 T(2)=T(4):T(3)=T(5):T(4)=T(6)
1910 N(2)=N(4):N(3)=N(5):N(4)=N(6)
1920 V=1:RETURN
1930 ' 7/8 x 3/4 = 21/32  2/5 x 1/19 = 2/95
1940 T(2)=T(4):N(2)=N(4)
1950 V=5:RETURN
1960 ' Start addition solving
1970 COLOR 11,0
1980 TN=T1*N(1)+T2*N(0) ' TN = 42 * 4 + 13 * 5 = 233
1990 NN=N(0)*N(1)       ' NN = 5 * 4 = 20
2000 GOSUB 170          ' get final answer
2010 IF B=1 THEN 1380   ' go display final answer
2020 GOSUB 60           ' analyse +
2030 ' Modules 1, 2, 3, 4, 5 + -   Module 8 +
2040 ON V GOTO 3820,3990,4130,4270,4410,650,650,4830
2050 ' Analyse if the + problem is of the V=1,2,3,4,5 or 8 form
2060 IF T(0)=0 OR T(1)=0 THEN 2360
2070 IF N(0)=N(1) AND T(0)+T(1)<N(0) THEN 2360
2080 IF N(0)=N(1) AND T(0)+T(1)=N(0) THEN 2460
2090 IF N(0)=N(1) AND T(0)+T(1)>N(0) THEN 2520
2100 ' 17 1/6 + 4 1/3 = 17 1/6 + 4 2/6 = 21 3/6 = 21 1/2
2110 TN=N(0):NN=N(1):GOSUB 40 ' search GCD
2120 G(2)=G(0):G(3)=G(1):G(4)=G(2)+G(3):LCM=N(0)/GCD*N(1)
2130 T(2)=LCM/N(0)*T(0):T(3)=LCM/N(1)*T(1):T(4)=T(2)+T(3)
2140 N(2)=LCM :N(3)=N(2):N(4)=N(3)
2150 TN=T(4):NN=N(4):GOSUB 40 ' search GCD
2160 IF GCD<>1 AND T(4)<N(4) THEN 2170 ELSE 2210
2170 G(5)=G(4):T(5)=T(4)/GCD:N(5)=N(4)/GCD
2180 V=5:RETURN
2190 ' 5 3/4 + 5 1/8 = 5 6/8  + 5 1/8  = 10 7/8
2200 ' 8 2/5 + 3 1/4 = 8 8/20 + 3 5/20 = 11 13/20
2210 IF T(4)<N(4) THEN 2220 ELSE 2250
2220 V=4:RETURN
2230 '  2 2/3 + 7 3/4 = 2 8/12 + 7 9/12 = 9 17/12 = 10 5/12
2240 ' 14 2/3 + 2 5/6 = 14 4/6 + 2 5/6  = 16 9/6  = 17 3/6 = 17 1/2
2250 G(5)=G(4)+INT(T(4)/N(4))
2260 T(5)=T(4)-(INT(T(4)/N(4))*N(4))
2270 N(5)=N(4)
2280 TN=T(5):NN=N(5):GOSUB 40 ' search GCD
2290 IF GCD<>1 THEN 2310
2300 V=5:RETURN
2310 G(6)=G(5):T(6)=T(5)/GCD:N(6)=N(5)/GCD
2320 V=8:RETURN
2330 ' 5 + 1 1/2 = 6 1/2   6 3/7 + 2 2/7 = 8 5/7   6 3/7 + 2 = 8 3/7
2340 '   1/78 + 3 7/78 =  3 8/78 =  3 4/49
2350 ' 7 1/78 + 3 7/78 = 10 8/78 = 10 4/39
2360 IF N(0)<N(1) THEN N(2)=N(1) ELSE N(2)=N(0)
2370 IF N(0)=N(1) THEN N(2)=N(0)
2380 G(2)=G(0)+G(1)
2390 T(2)=T(0)+T(1)
2400 TN=T(2):NN=N(2):GOSUB 40 ' search GCD
2410 IF GCD<>1 THEN 2430
2420 V=1:RETURN
2430 G(3)=G(2):T(3)=T(2)/GCD:N(3)=N(2)/GCD
2440 V=2:RETURN
2450 ' 7/9 + 2/9 = 9/9 = 1   3 1/2 + 2 1/2 = 5 2/2 = 6
2460 G(2)=G(0)+G(1):G(3)=G(2)+1
2470 T(2)=T(0)+T(1):T(3)=0
2480 N(2)=N(1):N(3)=1
2490 V=2:RETURN
2500 '    7/8 + 5/8    = 12/8    = 3/2   = 1 1/2
2510 ' 99/152 + 99/152 = 198/152 = 99/76 = 1 23/76
2520 G(2)=0:G(3)=0:IF G(0)=0 AND G(1)=0 THEN 2530 ELSE 2620
2530 T(2)=T(0)+T(1)
2540 N(2)=N(1)
2550 TN=T(2):NN=N(2):GOSUB 40 ' search GCD
2560 T(3)=T(2)/GCD:N(3)=N(2)/GCD  ' reduce
2570 G(4)=INT(T(3)/N(3))
2580 T(4)=T(3)-(G(4)*N(3))
2590 N(4)=N(3)
2600 V=3:RETURN
2610 ' 7 7/11 + 8 8/11 = 15 15/11 = 16 4/11
2620 G(2)=G(0)+G(1):T(2)=T(0)+T(1):N(2)=N(1)
2630 TN=T(2):NN=N(2):GOSUB 40 ' search GCD
2640 IF GCD<>1 THEN 2780
2650 G(3)=G(2)+INT(T(2)/N(2))
2660 T(3)=T(2)-(INT(T(2)/N(2))*N(2))
2670 N(3)=N(2)
2680 TN=T(3):NN=N(3):GOSUB 40 ' search GCD
2690 IF GCD=1 THEN 2700 ELSE 2740
2700 T(4)=0:N(4)=0
2710 V=2
2720 RETURN
2730 '
2740 G(4)=G(3)
2750 T(4)=T(3)/GCD:N(4)=N(3)/GCD ' reduce
2760 V=3:BEEP:RETURN
2770 ' 2 5/6 + 4 5/6 = 6 10/6 = 6 5/3 = 7 2/3
2780 G(3)=G(2)
2790 T(3)=T(2)/GCD:N(3)=N(2)/GCD ' reduce
2800 G(4)=G(3)+INT(T(3)/N(3))
2810 T(4)=T(3)-(INT(T(3)/N(3))*N(3))
2820 N(4)=N(3)
2830 V=3:RETURN
2840 ' Start subtraction solving
2850 COLOR 10,0
2860 T1=T(0)+G(0)*N(0):T2=T(1)+G(1)*N(1):TN=T1*N(1)-T2*N(0)
2870 IF TN<0 THEN 3000  ' go swap
2880 ' 3 1/2 - 3 1/2 = 0
2890 IF TN=0 THEN G(2)=0:T(2)=0:N(2)=1:GOTO 3820
2900 T1=T(0)+G(0)*N(0)  ' T1 = 2 + 8 * 5 = 42   8 2/5
2910 T2=T(1)+G(1)*N(1)  ' T2 = 1 + 3 * 4 = 13   3 1/4
2920 TN=T1*N(1)-T2*N(0) ' TN = 42 * 4 - 13 * 5 = 103
2930 NN=N(0)*N(1)       ' NN = 5 * 4 = 20
2940 GOSUB 170          ' get final answer
2950 IF B=1 THEN 1380   ' go display final answer
2960 GOSUB 70           ' analyse -
2970 ' Modules 1, 2, 3, 4, 5 + -   Modules 6, 7 -
2980 ON V GOTO 3820,3990,4130,4270,4410,4550,4690
2990 ' Change if subtraction is negative
3000 SWAP M1$,M4$:SWAP G(0),G(1)
3010 SWAP M2$,M5$:SWAP T(0),T(1)
3020 SWAP M3$,M6$:SWAP N(0),N(1)
3030 GOTO 2890
3040 ' Analyse if the - problem is of the V=1,2,3,4,5,6 or 7 form
3050 IF N(0)=N(1) AND T(0)>T(1) THEN 3640
3060 IF T(0)=T(1) AND N(0)=N(1) THEN 3740
3070 IF N(0)=N(1) AND T(0)<T(1) THEN 3390
3080 ' 10 1/2 - 2 = 8 1/2
3090 IF T(1)=0 THEN 3100 ELSE 3130
3100 G(2)=G(0)-G(1):T(2)=T(0):N(2)=N(0)
3110 V=1:RETURN
3120 ' 
3130 IF T(0)=0 THEN 3500
3140 IF G(0)=0 AND G(1)=0 THEN V=4
3150 TN=N(0):NN=N(1):GOSUB 40 ' search GCD
3160 LCM=N(0)/GCD*N(1)
3170 G(2)=G(0):T(2)=LCM/N(0)*T(0):N(2)=LCM
3180 G(3)=G(1):T(3)=LCM/N(1)*T(1):N(3)=N(2)
3190 G(4)=G(2)-G(3)              :N(4)=N(3)
3200 IF T(2)>T(3) THEN T(4)=T(2)-T(3):TN=T(4):NN=N(4):GOTO 3590
3210 IF V=3 AND T(2)>T(3) THEN T(4)=T(2)-T(3):GOTO 3550
3220 '  5 3/4 - 1 7/8 = 5 6/8 - 1 7/8 = 4 14/8 - 1 7/8 = 3 7/8
3230 G(4)=G(2)-1:T(4)=T(2)+N(2)
3240 G(5)=G(3):T(5)=T(3):N(5)=N(4)
3250 G(6)=G(4)-G(5):T(6)=T(4)-T(5):N(6)=N(5)
3260 TN=T(6):NN=N(6):GOSUB 40 ' search GCD
3270 IF GCD=1 AND T(6)<N(6) THEN 3280 ELSE 3310
3280 V=6:RETURN
3290 ' 6 7/8 - 2 1/4 = 6 7/8 - 2 2/8 = 4 5/8
3300 '   1/4 -   1/5 =  5/20 -  4/20 = 1/20
3310 IF GCD=1 AND T(6)>N(6) THEN 3320 ELSE 3350
3320 G(4)=G(2)-G(3):T(4)=T(2)-T(3)
3330 V=4:RETURN
3340 ' 6 3/4 - 2 11/12 = 6 9/12 - 2 11/12 = 5 21/12 - 2 11/12 = 3 10/12 = 3 5/6
3350 G(7)=G(6)
3360 T(7)=T(6)/GCD:N(7)=N(6)/GCD ' reduce
3370 V=7:RETURN
3380 ' 8 1/3 - 4 2/3 = 7 4/3 - 4 2/3 = 3 2/3
3390 G(2)=G(0)-1:T(2)=T(0)+N(0):N(2)=N(0)
3400 G(3)=G(1):T(3)=T(1):N(3)=N(1)
3410 G(4)=G(2)-G(3):T(4)=T(2)-T(3):N(4)=N(3)
3420 TN=T(4):NN=N(4):GOSUB 40 ' search GCD
3430 IF GCD=1 THEN 3440 ELSE 3460
3440 V=4:RETURN
3450 ' 4 1/8 - 5/8 = 3 9/8 - 5/8 = 3 4/8 = 3 1/2
3460 G(5)=G(4)
3470 T(5)=T(4)/GCD:N(5)=N(4)/GCD ' reduce
3480 V=5:RETURN
3490 ' 100 - 20 1/3 = 99 3/3 - 20 1/3 = 79 2/3
3500 G(2)=G(0)-1:T(2)=N(1):N(2)=T(2)
3510 G(3)=G(1):T(3)=T(1):N(3)=N(2)
3520 G(4)=G(2)-G(3):T(4)=T(2)-T(3):N(4)=N(3)
3530 V=4:RETURN
3540 '
3550 TN=T(4):NN=N(4):GOSUB 40 ' search GCD
3560 IF GCD=1 THEN 3570 ELSE 3590
3570 V=3:BEEP:RETURN
3580 ' 7 5/18 - 5 1/9 = 7 5/18 - 5 2/18 = 2 3/18 = 2 1/6
3590 GOSUB 40 ' search GCD
3600 IF GCD=1 THEN 3210
3610 T(5)=T(4)/GCD:N(5)=N(4)/GCD:G(5)=G(4)
3620 V=5:RETURN
3630 ' 6 3/7 - 4 2/7 = 2 1/7
3640 G(2)=G(0)-G(1):T(2)=T(0)-T(1):N(2)=N(1)
3650 TN=T(2):NN=N(2):GOSUB 40 ' search GCD
3660 IF GCD=1 THEN 3670 ELSE 3690
3670 V=1:RETURN
3680 ' 7 3/10 - 4 1/10 = 3 2/10 = 3 1/5
3690 G(3)=G(2)
3700 T(3)=T(2)/GCD:N(3)=N(2)/GCD ' reduce
3710 G(4)=0:T(4)=0
3720 V=2:RETURN
3730 ' 10 1/2 - 2 1/2 = 8
3740 G(2)=G(0)-G(1):T(2)=0:N(2)=1
3750 V=1:RETURN
3760 ' Wait for key pressed
3770 PRINT:PRINT "Press any key to continue ..."
3780 LSET W$=MKI$(0)
3790 WHILE CVI(W$)=0:MID$(W$,1)=INKEY$:WEND:F=ASC(W$)
3800 RETURN
3810 ' Module 1 + -
3820 IF G(1)=0 AND T(1)=0 AND N(1)=1 THEN SW=1
3830 D=2:GOSUB 100 ' calculate length and exact position
3840 GOSUB 110     ' print numerators + -
3850 FOR X=0 TO D
3860  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 3880
3870  IF G(X)=0 THEN 3890
3880  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
3890  IF T(X)=0 OR N(X)=1 THEN 3930
3900  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
3910  L=LF(X)
3920  GOSUB 140    ' draw fraction lines
3930  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
3940  IF X=1 THEN PRINT " =";: IF COPY THEN PRINT #1, " =";
3950 NEXT
3960 GOSUB 120     ' print denominators + -
3970 GOTO 650
3980 ' Module 2 + -
3990 D=3:GOSUB 100:GOSUB 110
4000 FOR X=0 TO D
4010  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4030
4020  IF G(X)=0 THEN 4040
4030  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4040  IF T(X)=0 OR N(X)=1 THEN 4080
4050  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4060  L=LF(X)
4070  GOSUB 140
4080  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4090  IF X=1 OR X=2 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4100 NEXT
4110 GOSUB 120:GOTO 650
4120 ' Module 3 +
4130 D=4:GOSUB 100:GOSUB 110
4140 FOR X=0 TO D
4150  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4170
4160  IF G(X)=0 THEN 4180
4170  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4180  IF T(X)=0 OR N(X)=1 THEN 4220
4190  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4200  L=LF(X)
4210  GOSUB 140
4220  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4230  IF X=1 OR X=2 OR X=3 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4240 NEXT
4250 GOSUB 120:GOTO 650
4260 ' Module 4 + -
4270 D=4:GOSUB 100:GOSUB 110
4280 FOR X=0 TO D
4290  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4310
4300  IF G(X)=0 THEN 4320
4310  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4320  IF T(X)=0 OR N(X)=1 THEN 4360
4330  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4340  L=LF(X)
4350  GOSUB 140
4360  IF X=0 OR X=2 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4370  IF X=1 OR X=3 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4380 NEXT
4390 GOSUB 120:GOTO 650
4400 ' Module 5 + -
4410 D=5:GOSUB 100:GOSUB 110
4420 FOR X=0 TO D
4430  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4450
4440  IF G(X)=0 THEN 4460
4450  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4460  IF T(X)=0 OR N(X)=1 THEN 4500
4470  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4480  L=LF(X)
4490  GOSUB 140
4500  IF X=0 OR X=2 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4510  IF X=1 OR X=3 OR X=4 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4520 NEXT
4530 GOSUB 120:GOTO 650
4540 ' Module 6 -
4550 D=6:GOSUB 100:GOSUB 110
4560 FOR X=0 TO D
4570  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4590
4580  IF G(X)=0 THEN 4600
4590  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4600  IF T(X)=0 OR N(X)=1 THEN 4640
4610  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4620  L=LF(X)
4630  GOSUB 140
4640  IF X=0 OR X=2 OR X=4 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4650  IF X=1 OR X=3 OR X=5 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4660 NEXT
4670 GOSUB 120:GOTO 650
4680 ' Module 7 -
4690 D=7:GOSUB 100:GOSUB 110
4700 FOR X=0 TO D
4710  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4730
4720  IF G(X)=0 THEN 4740
4730  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4740  IF T(X)=0 OR N(X)=1 THEN 4780
4750  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4760  L=LF(X)
4770  GOSUB 140
4780  IF X=0 OR X=2 OR X=4 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4790  IF X=1 OR X=3 OR X=5 OR X=6 THEN PRINT" =";:IF COPY THEN PRINT #1, " =";
4800 NEXT
4810 GOSUB 120:GOTO 650
4820 ' Module 8 +
4830 D=6:GOSUB 100:GOSUB 110
4840 FOR X=0 TO D
4850  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4870
4860  IF G(X)=0 THEN 4880
4870  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4880  IF T(X)=0 OR N(X)=1 THEN 4920
4890  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4900  L=LF(X)
4910  GOSUB 140
4920  IF X=0 OR X=2 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4930  IF X=1 OR X=3 OR X=4 OR X=5 THEN PRINT" =";:IF COPY THEN PRINT #1, " =";
4940 NEXT
4950 GOSUB 120:GOTO 650
4960 ' Calculate length of numerators
4970 FOR X=0 TO D
4980  Z=T(X)
4990  GOSUB 130 ' count digits
5000  LT(X)=L
5010 NEXT
5020 ' Calculate length of denominators
5030 FOR X=0 TO D
5040  Z=N(X)
5050  GOSUB 130 ' count digits
5060  LN(X)=L
5070 NEXT
5080 ' Calculate length of whole numbers and space of one fraction
5090 FOR X=0 TO D  ' numerator > denominator ?
5100  IF LT(X)>LN(X) THEN LF(X)=LT(X) ELSE LF(X)=LN(X)
5110 NEXT
5120 FOR X=0 TO D
5130  Z=G(X)
5140  GOSUB 130 ' count digits
5150  LG(X)=L
5160  IF G(X)=0 THEN LB(X)=LF(X):GOTO 5190
5170  LB(X)=LG(X)+LF(X)+1
5180  IF N(X)=1 THEN LB(X)=LB(X)-1
5190 NEXT
5200 ' Calculate exact positions of the numerators
5210 B(0)=LB(0)-LT(0)
5220 B(1)=LB(0)+LB(1)-LT(1)+3
5230 B(2)=LB(0)+LB(1)+LB(2)-LT(2)+6        ' module 1
5240 B(3)=LB(0)+LB(1)+LB(2)+LB(3)-LT(3)+9  ' module 2
5250 B(4)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)-LT(4)+12       ' module 3 + 4
5260 B(5)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)-LT(5)+15 ' module 5
5270 B(6)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)-LT(6)+18       ' module 6 + 8
5280 B(7)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)+LB(7)-LT(7)+21 ' module 7
5290 ' Calculate exact positions of the denominators
5300 O(0)=LB(0)-LN(0)
5310 O(1)=LB(0)+LB(1)-LN(1)+3
5320 O(2)=LB(0)+LB(1)+LB(2)-LN(2)+6        ' module 1
5330 O(3)=LB(0)+LB(1)+LB(2)+LB(3)-LN(3)+9  ' module 2
5340 O(4)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)-LN(4)+12       ' module 3 + 4
5350 O(5)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)-LN(5)+15 ' module 5
5360 O(6)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)-LN(6)+18       ' module 6 + 8
5370 O(7)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)+LB(7)-LN(7)+21 ' module 7
5380 ' 10 3/4 + - 0 = 10 3/4
5390 IF SW=1 THEN B(2)=B(2)+1:O(2)=O(2)+1:SW=0
5400 RETURN
5410 ' Print numerators + -
5420 FOR X=0 TO D
5430  IF C=1 AND V=4 AND T(X)>0 THEN 5450
5440  IF T(X)=0 OR N(X)=1 THEN 5460
5450  PRINT TAB(B(X)+1)T(X);:IF COPY THEN PRINT #1, TAB(B(X)+1)T(X);
5460 NEXT
5470 PRINT:IF COPY THEN PRINT #1, "" 
5480 RETURN
5490 ' Print denominators + -
5500 PRINT:IF COPY THEN PRINT #1, ""
5510 FOR X=0 TO D
5520  IF C=1 AND V=4 AND T(X)>0 THEN 5540
5530  IF N(X)=1 THEN 5550
5540  PRINT TAB(O(X)+1)N(X);:IF COPY THEN PRINT #1, TAB(O(X)+1)N(X);
5550 NEXT
5560 PRINT:PRINT:IF COPY THEN PRINT #1, :PRINT #1, ""
5570 RETURN
5580 ' Count the digits of the number
5590 L=1
5600 E=INT(Z/10):IF E<>0 THEN L=L+1:Z=E:GOTO 5600 ELSE RETURN
5610 ' Draw lines as big as the fraction is
5620 PRINT TAB(P+2)"";:PRINT STRING$(L,"Ä");
5630 IF COPY THEN PRINT #1, TAB(P+2)"";:PRINT #1, STRING$(L,"-");
5640 RETURN
5650 ' Module 1 * /
5660 D=4:GOSUB 100 ' calculate length and exact position
5670 GOSUB 150     ' print numerators * /
5680 FOR X=0 TO D
5690  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 5710
5700  IF G(X)=0 THEN 5720
5710  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
5720  IF T(X)=0 THEN 5760
5730  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
5740  L=LF(X)
5750  GOSUB 140    ' draw fraction lines
5760  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
5770  IF X=1 OR X=3 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
5780  IF X=2 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
5790 NEXT
5800 GOSUB 160     ' print denominators * /
5810 GOTO 650
5820 ' Module 2 * /
5830 D=5:GOSUB 100:GOSUB 150
5840 FOR X=0 TO D
5850  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 5870
5860  IF G(X)=0 THEN 5880
5870  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
5880  IF T(X)=0 THEN 5920
5890  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
5900  L=LF(X)
5910  GOSUB 140
5920  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
5930  IF X=2 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
5940  IF X=1 OR X=3 OR X=4 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
5950 NEXT
5960 GOSUB 160:GOTO 650
5970 ' Module 3 * /
5980 D=6:GOSUB 100:GOSUB 150
5990 FOR X=0 TO D
6000  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 6020
6010  IF G(X)=0 THEN 6030
6020  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
6030  IF T(X)=0 THEN 6070
6040  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
6050  L=LF(X)
6060  GOSUB 140
6070  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
6080  IF X=2 OR X=4 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
6090  IF X=1 OR X=3 OR X=5 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
6100 NEXT
6110 GOSUB 160:GOTO 650
6120 ' Module 4 * /
6130 D=7:GOSUB 100:GOSUB 150
6140 FOR X=0 TO D
6150  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 6170
6160  IF G(X)=0 THEN 6180
6170  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
6180  IF T(X)=0 THEN 6220
6190  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
6200  L=LF(X)
6210  GOSUB 140
6220  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
6230  IF X=2 OR X=4 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
6240  IF X=1 OR X=3 OR X=5 OR X=6 THEN PRINT" =";:IF COPY THEN PRINT #1, " =";
6250 NEXT
6260 GOSUB 160:GOTO 650
6270 ' Print numerators * /
6280 FOR X=0 TO D
6290  IF T(X)=0 THEN 6310
6300  PRINT TAB(B(X)+1)T(X);:IF COPY THEN PRINT #1, TAB(B(X)+1)T(X);
6310 NEXT
6320 PRINT:IF COPY THEN PRINT #1, ""
6330 RETURN
6340 ' Print denominators * /
6350 PRINT:IF COPY THEN PRINT #1, ""
6360 FOR X=0 TO D
6370  IF T(X)=0 THEN 6390
6380  PRINT TAB(O(X)+1)N(X);:IF COPY THEN PRINT #1, TAB(O(X)+1)N(X);
6390 NEXT
6400 PRINT:PRINT:IF COPY THEN PRINT #1, "":PRINT #1, ""
6410 RETURN
6420 ' Solve fraction problem
6430 IF NN=TN THEN G(8)=1 :N(8)=1:RETURN
6440 IF TN=0  THEN G(8)=0 :N(8)=1:RETURN
6450 IF NN=1  THEN G(8)=TN:N(8)=1:RETURN
6460 IF TN/NN=INT(TN/NN) THEN G(8)=TN/NN:N(8)=1:RETURN
6470 GOSUB 40 ' search GCD
6480 TN=TN/GCD:NN=NN/GCD ' reduce
6490 G(8)=INT(TN/NN):T(8)=TN-G(8)*NN:N(8)=NN
6500 RETURN
6510 ' Help info
6520 PRINT"THIS PROGRAM SHOWS YOU THE COMPLETE SOLUTION OF FRACTIONS"
6530 PRINT"If you don't need a diskfile, type <N/n> or press <Enter>"
6540 PRINT
6550 PRINT"1) W.N/D ? 8.2/5  or press <Enter> "
6560 PRINT"+ - * /  ? +      or press <Enter> "
6570 PRINT"2) W.N/D ? 3.1/4  or press <Enter> ":PRINT
6580 PRINT"By pressing 3 times <Enter> you will automatically get":PRINT
6590 PRINT"                    2         1"
6600 PRINT"the solution of  8 ÄÄÄ  +  3 ÄÄÄ  ?"
6610 PRINT"                    5         4"
6620 PRINT
6630 GOSUB 80 ' wait key
6640 CLS
6650 PRINT "   2         1"
6660 PRINT "8 ÄÄÄ  -  3 ÄÄÄ  = ?    press <Enter> - <Enter>"
6670 PRINT "   5         4":PRINT
6680 PRINT"1) W.N/D ? <Enter>
6690 PRINT"+ - * /  ? -
6700 PRINT"2) W.N/D ? <Enter>":PRINT
6710 PRINT "To see the product  press <Enter> * <Enter>":PRINT
6720 PRINT"1) W.N/D ? <Enter>
6730 PRINT"+ - * /  ? *
6740 PRINT"2) W.N/D ? <Enter>": PRINT
6750 PRINT "To see the quotient press <Enter> / <Enter>":PRINT
6760 PRINT"1) W.N/D ? <Enter>
6770 PRINT"+ - * /  ? /
6780 PRINT"2) W.N/D ? <Enter>":PRINT
6790 GOSUB 80 ' wait key
6800 CLS
6810 PRINT"W = Whole integer number"
6820 PRINT". = To separate number from the fraction"
6830 PRINT"N = Numerator"
6840 PRINT"/ = Fraction bar"
6850 PRINT"D = Denominator":PRINT
6860 PRINT"    7"
6870 PRINT"12 ÄÄÄ  Enter this as follows: 12.7/8 <Enter> "
6880 PRINT"    8                            ³"
6890 PRINT"                                 ³"
6900 PRINT"Notice the dot . >>ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ":PRINT
6910 PRINT"    3"
6920 PRINT"   ÄÄÄ  Enter: .3/4 <Enter> "
6930 PRINT"    4":PRINT:PRINT
6940 PRINT"This program memorizes your fractions!"
6950 PRINT"For quick results just type <Enter> + - * / <Enter>":PRINT
6960 PRINT"Enter a 0 (zero) to return to the menu"
6970 GOSUB 80 ' wait key
6980 CLS
6990 PRINT "Enter Repeating Decimals like these examples:":PRINT
7000 PRINT ".(6) .(24) .(09) .(36) .(26) .(142857) .(456) .(3)":PRINT
7010 PRINT ".7(6)  .70(8)  .08(09)  .21(456)  .654(69)  .13(7)":PRINT
7020 PRINT "2.708(3)  7.12(3)  4.23(138)  12.45.(67)  7.05(04)":PRINT
7030 GOSUB 80 ' wait key
7040 CLS:RETURN
7050 ' Exit
7060 IF COPY THEN CLOSE
7070 KEY 5,"fraction.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS:END
7080 ' Repeating decimal to fraction
7090 PRINT:COLOR 7,0:B=2
7100 LINE INPUT "Repeating decimal 0 menu ? ";B1$
7110 IF B1$="0" THEN B1$=M7$:RP=0:CLS:GOTO 500
7120 IF B1$="" THEN B1$=M7$
7130 B$=B1$:GOSUB 190
7140 IF NG=0 THEN 7100
7150 RT=LEN(T$):RN=LEN(N$):M7$=B$
7160 GOSUB 200 ' clear line
7170 IF G$="" AND T$=""  THEN 7210
7180 IF G$="" AND T$<>"" THEN 7260
7190 GOTO 7280
7200 ' Case 1  .(6) .(23) .(90) .(456) .(142857)
7210 G1$=N$:T1$="":N1$="1":G2$=""
7220 FOR C=1 TO RL:G2$=G2$+"9":NEXT
7230 T2$="":N2$="1":C=2
7240 GOTO 7340
7250 ' Case 2  .4(5) .70(8) .08(09) .21(456)
7260 G1$="":GOTO 7290
7270 ' Case 3  2.708(3) 7.12(3) 4.23(13) 1.5(20)
7280 G1$=G$
7290 Z=1:FOR C=1 TO RT:Z=Z*10:NEXT:N1$=STR$(Z)
7300 T1$=T$:G2$="":T2$=N$:DN$=""
7310 FOR C=1 TO RN:DN$=DN$+"9":NEXT
7320 FOR C=1 TO RT:DN$=DN$+"0":NEXT
7330 N2$=DN$:C=3
7340 IF C=3 THEN COLOR 11,0
7350 IF C=2 THEN COLOR 15,0
7360 PRINT B$;" = ";:IF COPY THEN PRINT #1,B$; " = ";
7370 M1$=G1$:M2$=T1$:M3$=N1$:M4$=G2$:M5$=T2$:M6$=N2$
7380 GOTO 1000
7390 ' Scan repeating decimal input
7400 L=LEN(B$)
7410 CD=0:CL=0:CR=0:CN=0
7420 IF LEFT$(B$,1)="(" OR LEFT$(B$,1)=")" THEN 7630 ' (1234   )654
7430 IF RIGHT$(B$,1)="." THEN 7630 ' 123.
7440 FOR I=1 TO L
7450  Z=ASC(MID$(B$,I,1))
7460  IF Z=46 THEN CD=CD+1 ' check .
7470  IF Z=40 THEN CL=CL+1 ' check (
7480  IF Z=41 THEN CR=CR+1 ' check )
7490  IF Z>58 THEN CN=CN+1 ' check : to ~
7500 NEXT
7510  IF CD=0 OR CD>1 OR CL>1 OR CR>1 OR CN>0 THEN 7630
7520 FOR I=1 TO L
7530  IF MID$(B$,I,2)="()" THEN 7630
7540 NEXT
7550 FOR I=1 TO L
7560  IF MID$(B$,I,1)="." THEN G$=MID$(B$,1,I-1):Q=I+1
7570  IF MID$(B$,I,1)="(" THEN T$=MID$(B$,Q,I-Q):N$=MID$(B$,I+1,L)
7580 NEXT
7590  IF RIGHT$ (N$,1)<>")" THEN 7630
7600  IF RIGHT$ (N$,1)= ")" THEN RL=LEN(N$)-1:N$=LEFT$(N$,RL)
7610 NG=1:RETURN
7620 ' Clear line
7630 NG=0:PRINT CHR$(30);:PRINT STRING$(79,32):PRINT CHR$(30);
7640 RETURN
7650 ' Scan fraction input
7660 L=LEN(B$)
7670 CD=0:CL=0
7680  IF LEFT$(B$,1)="/" OR RIGHT$(B$,1)="/"  THEN 7630 ' /1234 6541/
7690  IF RIGHT$(B$,1)="0." THEN 7630 ' 0.
7700  IF RIGHT$(B$,1)="." THEN 7630 ' 123.  .2356/4789
7710 FOR I=1 TO L
7720  Z=ASC(MID$(B$,I,1))
7730  IF Z<46 OR Z>57 THEN 7630 ' <space to -> or <: to þ>
7740  IF MID$(B$,I,1)="/" THEN 7930 ' /.
7750  IF MID$(B$,I,1)="." THEN 7990 ' ./
7760 NEXT
7770 FOR I=1 TO L
7780  Z=ASC(MID$(B$,I,1))
7790  IF Z=46 THEN CD=CD+1:IF CD=0 OR CD>1 THEN 7630 '...
7800  IF Z=47 THEN CL=CL+1:IF CL=0 OR CL>1 THEN 7630 '///
7810 NEXT
7820  IF CL=1 AND CD=0 THEN 7630 ' check 123/789
7830  IF CD=1 AND CL=0 THEN 7630 ' check .123
7840 FOR I=1 TO L
7850  IF MID$(B$,I,1)="." THEN G$=MID$(B$,1,I-1):Q=I+1
7860  IF MID$(B$,I,1)="/" THEN T$=MID$(B$,Q,I-Q):N$=MID$(B$,I+1,L)
7870 NEXT
7880 IF T$="" THEN G$=B$:N$="1"
7890 IF T$="0" THEN 7630 ' 1.0/7  .0/7
7900 IF N$="0" THEN 7630 ' .23/0
7910 NG=1:RETURN
7920  ' Check /1. /12. /123.45   23/1234.567
7930 EC=I+1
7940 FOR I=EC TO L
7950  IF MID$(B$,I,1)="." THEN 7630
7960 NEXT
7970 GOTO 7770
7980 ' Check ./   123./56
7990 EC=I+1:IF MID$(B$,I,1)="/" THEN 7630
8000 GOTO 7770
8010 ' Basic fractions calculations!
8020 ' 7 1/3  + 1 1/2 = 22/3  +  3/2 =  44/6  +   9/6  =  53/6  = 8  5/6
8030 ' 3 5/12 - 1 7/8 = 41/12 - 15/8 = 328/96 - 180/96 = 148/96 = 1 13/24
8040 ' 5 1/3  x 8 2/5 = 16/3  x 42/5 = 672/15  = 44 4/5
8050 ' 8/15 : 9 4/5 = 98/15 x 5/49 = 490/735 = 2/3
