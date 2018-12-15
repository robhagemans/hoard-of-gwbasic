10 ' fraction.bas - April 21, 2004 - Freeware
20 GOTO 230 ' begin
30 SAVE "fraction":LIST-210
40 GOTO 1410 ' search for GCD
50 GOTO 1440 ' scan operation * / + -
60 GOTO 2040 ' analyse +
70 GOTO 3020 ' analyse -
80 GOTO 3740 ' wait key pressed
90 GOTO 3750 ' get key input
100 GOTO 4870 ' calculate length and exact position
110 GOTO 5320 ' print numerators   + -
120 GOTO 5400 ' print denominators + -
130 GOTO 5490 ' count digits
140 GOTO 5520 ' draw fraction lines ÄÄÄ ---
150 GOTO 6150 ' print numerators   * /
160 GOTO 6220 ' print denominators * /
170 GOTO 6300 ' get final answer
180 GOTO 6390 ' help info
190 GOTO 7220 ' scan repeating decimal input
200 GOTO 7450 ' clear line
210 GOTO 7480 ' scan fraction input
220 ' begin
230 DEFDBL G,T,N,Z,E,M:DEFSTR Q:Q=MKI$(0)
240 M1$="8":M2$="2":M3$="5":M4$="3":M5$="1"
250 M6$="4":M7$="2.708(3)":G(8)=8:T(8)=2:N(8)=5
260 RP=0:K$="+":O$(1)=" x":O$(2)=" :"
270 O$(3)=" +":O$(4)=" -":KEY OFF:CLS
280 PRINT "**************************************"
290 PRINT "* FOUR FUNCTION FRACTIONS CALCULATOR *"
300 PRINT "*       Programmed in GW-BASIC       *"
310 PRINT "*    Compiled with PowerBasic 3.2    *"
320 PRINT "*          by Eric F. Tchong         *"
330 PRINT "*        serenata@setarnet.aw        *"
340 PRINT "*               ARUBA                *"
350 PRINT "*   (C) May 1992  -  Freeware 2004   *"
360 PRINT "**************************************"
370 PRINT:PRINT "For instructions: press <Yy> ?"
380 GOSUB 90 ' get key input
390 IF F=89 OR F=121 THEN CLS:GOSUB 180 ' help info
400 CLS:PRINT "For a diskfile:   press <Yy> ?"
410 GOSUB 90 ' get key input
420 IF F=89 OR F=121 THEN COPY=1 ELSE COPY=0
430 IF COPY THEN 440 ELSE 480
440 CLS:PRINT "Enter a DOS filename ? ";:LINE INPUT Z$
450 IF LEFT$(Z$,1)=" " THEN Z$=MID$(Z$,2):GOTO 450
460 OPEN "O",#1,Z$
470 ' select chain or variabel calculation
480 CLS:PRINT "1. Chain    calculation"
490 PRINT "2. Variabel calculation"
500 PRINT "3. Convert a repeating decimal"
510 PRINT "4. Exit this program ..":PRINT
520 INPUT "Choose 1, 2, 3, or 4 ";A:CLS
530 IF A<1 OR A>4 THEN CLS:GOTO 480
540 IF A=4 THEN 6880
550 IF A=3 THEN RP=1:GOTO 6910 ' repeating decimal
560 ' display intermediate or final results only
570 PRINT "1. Display final results only."
580 PRINT "2. Display intermediate and final results.":PRINT
590 INPUT "Choose 1 or 2 ";B:CLS
600 IF B<1 OR B>2 THEN CLS:GOTO 570
610 ' empty strings = recall memory, 0 = return to menu
620 FOR X=0 TO 7
630  G(X)=0 ' G(X) = whole number
640  T(X)=0 ' T(X) = numerator
650  N(X)=1 ' N(X) = denominator
660 NEXT
670 IF RP=1 THEN 6910 ' repeating decimal
680 IF N(8)=1 THEN T(8)=0
690 IF A=1 THEN M1$=STR$(G(8)):M2$=STR$(T(8)):M3$=STR$(N(8))
700 COLOR 7,0:PRINT
710 ' get first fraction
720 LINE INPUT "1) W.N/D 0 menu ? ";B1$
730 IF B1$="0" THEN 480
740 B$=B1$:GOSUB 210 ' scan fractional input
750 IF NG=0 THEN 720
760 G1$=G$:T1$=T$:N1$=N$
770 IF G1$="" AND T1$="" THEN G1$=M1$:T1$=M2$:N1$=M3$:GOTO 800
780 IF G1$="0" THEN CLS:GOTO 480
790 M1$=G1$:M2$=T1$:M3$=N1$
800 G$="":T$="":N$=""
810 PRINT "   + - * /      ? ";K$
820 ' obtain operation
830 GOSUB 90 ' get key input
840 IF F=13 THEN LSET Q=K$:GOSUB 50:GOTO 910 ' * / + -
850 IF F=42 THEN C=1:GOTO 910 ' *
860 IF F=47 THEN C=2:GOTO 910 ' /
870 IF F=43 THEN C=3:GOTO 910 ' +
880 IF F=45 THEN C=4:GOTO 910 ' -
890 IF F<42 OR F>47 OR F=44 OR F=46 THEN 900
900 PRINT CHR$(30);"   What ??":GOTO 830
910 K$=Q:PRINT CHR$(30);"   + - * /      ? ";K$
920 ' get second fraction
930 LINE INPUT "2) W.N/D        ? ";B2$
940 B$=B2$:GOSUB 210 ' scan fractional input
950 IF NG=0 THEN 930
960 G2$=G$:T2$=T$:N2$=N$
970 IF G2$="" AND T2$="" THEN G2$=M4$:T2$=M5$:N2$=M6$:GOTO 990
980 M4$=G2$:M5$=T2$:M6$=N2$
990 G$="":T$="":N$=""
1000 ' save first & second fraction
1010 G(0)=VAL(G1$):T(0)=VAL(T1$):N(0)=VAL(N1$)
1020 G(1)=VAL(G2$):T(1)=VAL(T2$):N(1)=VAL(N2$):PRINT
1030 ' reduce fractions 4/8 = 1/2, 10/5 = 5/1
1040 TN=T(0):NN=N(0):GOSUB 40    ' search GCD
1050 T(0)=T(0)/GCD:N(0)=N(0)/GCD ' reduce
1060 TN=T(1):NN=N(1):GOSUB 40    ' search GCD
1070 T(1)=T(1)/GCD:N(1)=N(1)/GCD ' reduce
1080 ' numerator > denominator 7 8/5 = 8 3/5
1090 IF T(0)>N(0) THEN G(0)=G(0)+INT(T(0)/N(0)):T(0)=T(0)-INT(T(0)/N(0))*N(0)
1100 IF T(1)>N(1) THEN G(1)=G(1)+INT(T(1)/N(1)):T(1)=T(1)-INT(T(1)/N(1))*N(1)
1110 ' 3 3/3 = 4
1120 IF T(0)=N(0) THEN G(0)=G(0)+1:T(0)=0:N(0)=1
1130 IF T(1)=N(1) THEN G(1)=G(1)+1:T(1)=0:N(1)=1
1140 ' T1 = 2 + 8 * 5 = 42   8 2/5
1150 ' T2 = 1 + 3 * 4 = 13   3 1/4
1160 T1=T(0)+G(0)*N(0):T2=T(1)+G(1)*N(1)
1170 ' if zero go module 1 + -
1180 IF G(1)=0 AND T(1)=0 AND C=1 THEN G(2)=0:N(2)=1:COLOR 14,0:GOTO 3790
1190 ' select * / + -
1200 ON C GOTO 1220,1310,1950,2820
1210 ' start multiplication solving
1220 COLOR 14,0
1230 TN=T1*T2         ' TN = 42 * 13 = 546
1240 NN=N(0)*N(1)     ' NN =  5 *  4 = 20
1250 GOSUB 170        ' get final answer
1260 IF B=1 THEN 1390 ' go display final answer
1270 GOSUB 1480       ' analyse *
1280 ' modules 1, 2, 3, 4 * /   module 1 + -
1290 ON V GOTO 5560,5730,5870,6010,3790
1300 ' start division solving
1310 COLOR 15,0
1320 IF G(1)=0 AND N(1)=1 THEN PRINT "Division by zero":GOTO 620
1330 TN=T1*N(1)       ' TN = 42 *  4 = 168
1340 NN=N(0)*T2       ' NN =  5 * 13 = 65
1350 GOSUB 170        ' get final answer
1360 IF B=1 THEN 1390 ' go display final answer
1370 GOTO 1270        ' analyse /
1380 ' final results only
1390 G(2)=G(8):T(2)=T(8):N(2)=N(8):GOTO 3790
1400 ' search for GCD
1410 M=TN:N=NN
1420 WHILE M:N=N-M*INT(N/M):SWAP M,N:WEND:GCD=N:RETURN
1430 ' scan operation * / + -
1440 IF K$="*" THEN C=1 ELSE IF K$="/" THEN C=2
1450 IF K$="+" THEN C=3 ELSE IF K$="-" THEN C=4
1460 RETURN
1470 ' analyse if the * or / problem is of the V=1,2,3,4 or 5 form
1480 IF C=1 THEN 1500 ELSE 1530
1490 ' multiplication
1500 T(2)=G(0)*N(0)+T(0):T(3)=G(1)*N(1)+T(1)
1510 N(3)=N(1):N(2)=N(0):GOTO 1560
1520 ' division
1530 T(2)=G(0)*N(0)+T(0):N(3)=G(1)*N(1)+T(1)
1540 T(3)=N(1):N(2)=N(0):GOTO 1560
1550 ' process * / problem
1560 TN=T(2):NN=N(3):GOSUB 40 ' search GCD
1570 GCD1=GCD
1580 TN=T(3):NN=N(2):GOSUB 40 ' search GCD
1590 GCD2=GCD:IF GCD1=1 AND GCD2=1 THEN 1750
1600 ' reduce fractions
1610 T(4)=T(2)/GCD1:N(5)=N(3)/GCD1
1620 N(4)=N(2)/GCD2:T(5)=T(3)/GCD2
1630 T(6)=T(4)*T(5):N(6)=N(4)*N(5)
1640 IF T(6)<N(6) THEN 1850
1650 '    10 x 1/2   = 5   1 25/66 x 30 6/13 = 42
1660 ' 3 5/7 ö 1 6/7 = 2   6 4/11  ö 10/11   = 7
1670 IF N(6)=1 THEN 1680 ELSE 1720
1680 G(7)=T(6)
1690 V=4:RETURN
1700 ' 12 2/45 x 7 3/8 = 88 149/180
1710 ' 2 3/26  ö 1 5/6 = 1 2/13     3/4 ö 5/8 = 1 1/5   
1720 G(7)=INT(T(6)/N(6)):T(7)=T(6)-G(7)*N(6):N(7)=N(6)
1730 V=4:RETURN
1740 ' can not reduce fractions
1750 T(4)=T(2)*T(3):N(4)=N(2)*N(3)
1760 ' 2 x 1/5 = 2/5   3/4 ö 2 = 3/8
1770 IF T(0)=T(2) AND N(0)=N(2) AND T(1)=T(3) AND N(1)=N(3) THEN 1920
1780 IF T(4)<N(4) THEN 1790 ELSE 1820
1790 V=1:RETURN
1800 ' 3 x 2 = 3/1 x 2/1 = 6/1 = 6   5 7/9 x 6 8/11 = 38 86/99
1810 ' 999 ö 6 1/2 = 153 9/13        7 3/4 ö 2 1/3 = 3 9/28
1820 G(5)=INT(T(4)/N(4)):T(5)=T(4)-G(5)*N(4):N(5)=N(4)
1830 V=2:RETURN
1840 ' 4 1/2 ö 45 = 1/10   2 4/9 ö 3 2/3 = 2/3
1850 IF T(0)=T(2) AND N(0)=N(2) AND T(1)=T(3) AND N(1)=N(3) THEN 1880
1860 V=3:RETURN
1870 ' 2/5 x 7/24 = 1/5 x 7/12 = 7/60   2/5 x 3/4 = 1/5 x 3/2 = 3/10
1880 T(2)=T(4):T(3)=T(5):T(4)=T(6)
1890 N(2)=N(4):N(3)=N(5):N(4)=N(6)
1900 V=1:RETURN
1910 ' 7/8 x 3/4 = 21/32  2/5 x 1/19 = 2/95
1920 T(2)=T(4):N(2)=N(4)
1930 V=5:RETURN
1940 ' start addition solving
1950 COLOR 11,0
1960 TN=T1*N(1)+T2*N(0) ' TN = 42 * 4 + 13 * 5 = 233
1970 NN=N(0)*N(1)       ' NN = 5 * 4 = 20
1980 GOSUB 170          ' get final answer
1990 IF B=1 THEN 1390   ' go display final answer
2000 GOSUB 60           ' analyse +
2010 ' modules 1, 2, 3, 4, 5 + -   module 8 +
2020 ON V GOTO 3790,3960,4090,4220,4350,620,620,4740
2030 ' analyse if the + problem is of the V=1,2,3,4,5 or 8 form
2040 IF T(0)=0 OR T(1)=0 THEN 2340
2050 IF N(0)=N(1) AND T(0)+T(1)<N(0) THEN 2340
2060 IF N(0)=N(1) AND T(0)+T(1)=N(0) THEN 2440
2070 IF N(0)=N(1) AND T(0)+T(1)>N(0) THEN 2500
2080 ' 17 1/6 + 4 1/3 = 17 1/6 + 4 2/6 = 21 3/6 = 21 1/2
2090 TN=N(0):NN=N(1):GOSUB 40 ' search GCD
2100 G(2)=G(0):G(3)=G(1):G(4)=G(2)+G(3):LCM=N(0)/GCD*N(1)
2110 T(2)=LCM/N(0)*T(0):T(3)=LCM/N(1)*T(1):T(4)=T(2)+T(3)
2120 N(2)=LCM :N(3)=N(2):N(4)=N(3)
2130 TN=T(4):NN=N(4):GOSUB 40 ' search GCD
2140 IF GCD<>1 AND T(4)<N(4) THEN 2150 ELSE 2190
2150 G(5)=G(4):T(5)=T(4)/GCD:N(5)=N(4)/GCD
2160 V=5:RETURN
2170 ' 5 3/4 + 5 1/8 = 5 6/8  + 5 1/8  = 10 7/8
2180 ' 8 2/5 + 3 1/4 = 8 8/20 + 3 5/20 = 11 13/20
2190 IF T(4)<N(4) THEN 2200 ELSE 2230
2200 V=4:RETURN
2210 '  2 2/3 + 7 3/4 = 2 8/12 + 7 9/12 = 9 17/12 = 10 5/12
2220 ' 14 2/3 + 2 5/6 = 14 4/6 + 2 5/6  = 16 9/6  = 17 3/6 = 17 1/2
2230 G(5)=G(4)+INT(T(4)/N(4))
2240 T(5)=T(4)-(INT(T(4)/N(4))*N(4))
2250 N(5)=N(4)
2260 TN=T(5):NN=N(5):GOSUB 40 ' search GCD
2270 IF GCD<>1 THEN 2290
2280 V=5:RETURN
2290 G(6)=G(5):T(6)=T(5)/GCD:N(6)=N(5)/GCD
2300 V=8:RETURN
2310 ' 5 + 1 1/2 = 6 1/2   6 3/7 + 2 2/7 = 8 5/7   6 3/7 + 2 = 8 3/7
2320 '   1/78 + 3 7/78 =  3 8/78 =  3 4/49
2330 ' 7 1/78 + 3 7/78 = 10 8/78 = 10 4/39
2340 IF N(0)<N(1) THEN N(2)=N(1) ELSE N(2)=N(0)
2350 IF N(0)=N(1) THEN N(2)=N(0)
2360 G(2)=G(0)+G(1)
2370 T(2)=T(0)+T(1)
2380 TN=T(2):NN=N(2):GOSUB 40 ' search GCD
2390 IF GCD<>1 THEN 2410
2400 V=1:RETURN
2410 G(3)=G(2):T(3)=T(2)/GCD:N(3)=N(2)/GCD
2420 V=2:RETURN
2430 ' 7/9 + 2/9 = 9/9 = 1   3 1/2 + 2 1/2 = 5 2/2 = 6
2440 G(2)=G(0)+G(1):G(3)=G(2)+1
2450 T(2)=T(0)+T(1):T(3)=0
2460 N(2)=N(1):N(3)=1
2470 V=2:RETURN
2480 '    7/8 + 5/8    = 12/8    = 3/2   = 1 1/2
2490 ' 99/152 + 99/152 = 198/152 = 99/76 = 1 23/76
2500 G(2)=0:G(3)=0:IF G(0)=0 AND G(1)=0 THEN 2510 ELSE 2600
2510 T(2)=T(0)+T(1)
2520 N(2)=N(1)
2530 TN=T(2):NN=N(2):GOSUB 40 ' search GCD
2540 T(3)=T(2)/GCD:N(3)=N(2)/GCD  ' reduce
2550 G(4)=INT(T(3)/N(3))
2560 T(4)=T(3)-(G(4)*N(3))
2570 N(4)=N(3)
2580 V=3:RETURN
2590 ' 7 7/11 + 8 8/11 = 15 15/11 = 16 4/11
2600 G(2)=G(0)+G(1):T(2)=T(0)+T(1):N(2)=N(1)
2610 TN=T(2):NN=N(2):GOSUB 40 ' search GCD
2620 IF GCD<>1 THEN 2750
2630 G(3)=G(2)+INT(T(2)/N(2))
2640 T(3)=T(2)-(INT(T(2)/N(2))*N(2))
2650 N(3)=N(2)
2660 TN=T(3):NN=N(3):GOSUB 40 ' search GCD
2670 IF GCD=1 THEN 2680 ELSE 2710
2680 T(4)=0:N(4)=0
2690 V=2:RETURN
2700 '
2710 G(4)=G(3)
2720 T(4)=T(3)/GCD:N(4)=N(3)/GCD ' reduce
2730 V=3:RETURN
2740 ' 2 5/6 + 4 5/6 = 6 10/6 = 6 5/3 = 7 2/3
2750 G(3)=G(2)
2760 T(3)=T(2)/GCD:N(3)=N(2)/GCD ' reduce
2770 G(4)=G(3)+INT(T(3)/N(3))
2780 T(4)=T(3)-(INT(T(3)/N(3))*N(3))
2790 N(4)=N(3)
2800 V=3:RETURN
2810 ' start subtraction solving
2820 COLOR 10,0
2830 T1=T(0)+G(0)*N(0):T2=T(1)+G(1)*N(1):TN=T1*N(1)-T2*N(0)
2840 IF TN<0 THEN 2970  ' go swap
2850 ' 3 1/2 - 3 1/2 = 0
2860 IF TN=0 THEN G(2)=0:T(2)=0:N(2)=1:GOTO 3790
2870 T1=T(0)+G(0)*N(0)  ' T1 = 2 + 8 * 5 = 42   8 2/5
2880 T2=T(1)+G(1)*N(1)  ' T2 = 1 + 3 * 4 = 13   3 1/4
2890 TN=T1*N(1)-T2*N(0) ' TN = 42 * 4 - 13 * 5 = 103
2900 NN=N(0)*N(1)       ' NN = 5 * 4 = 20
2910 GOSUB 170          ' get final answer
2920 IF B=1 THEN 1390   ' go display final answer
2930 GOSUB 70           ' analyse -
2940 ' modules 1, 2, 3, 4, 5 + -   modules 6, 7 -
2950 ON V GOTO 3790,3960,4090,4220,4350,4480,4610
2960 ' change if subtraction is negative
2970 SWAP M1$,M4$:SWAP G(0),G(1)
2980 SWAP M2$,M5$:SWAP T(0),T(1)
2990 SWAP M3$,M6$:SWAP N(0),N(1)
3000 GOTO 2860
3010 ' analyse if the - problem is of the V=1,2,3,4,5,6 or 7 form
3020 IF N(0)=N(1) AND T(0)>T(1) THEN 3610
3030 IF T(0)=T(1) AND N(0)=N(1) THEN 3710
3040 IF N(0)=N(1) AND T(0)<T(1) THEN 3360
3050 ' 10 1/2 - 2 = 8 1/2
3060 IF T(1)=0 THEN 3070 ELSE 3100
3070 G(2)=G(0)-G(1):T(2)=T(0):N(2)=N(0)
3080 V=1:RETURN
3090 ' 
3100 IF T(0)=0 THEN 3470
3110 IF G(0)=0 AND G(1)=0 THEN V=4
3120 TN=N(0):NN=N(1):GOSUB 40 ' search GCD
3130 LCM=N(0)/GCD*N(1)
3140 G(2)=G(0):T(2)=LCM/N(0)*T(0):N(2)=LCM
3150 G(3)=G(1):T(3)=LCM/N(1)*T(1):N(3)=N(2)
3160 G(4)=G(2)-G(3)              :N(4)=N(3)
3170 IF T(2)>T(3) THEN T(4)=T(2)-T(3):TN=T(4):NN=N(4):GOTO 3560
3180 IF V=3 AND T(2)>T(3) THEN T(4)=T(2)-T(3):GOTO 3520
3190 '  5 3/4 - 1 7/8 = 5 6/8 - 1 7/8 = 4 14/8 - 1 7/8 = 3 7/8
3200 G(4)=G(2)-1:T(4)=T(2)+N(2)
3210 G(5)=G(3):T(5)=T(3):N(5)=N(4)
3220 G(6)=G(4)-G(5):T(6)=T(4)-T(5):N(6)=N(5)
3230 TN=T(6):NN=N(6):GOSUB 40 ' search GCD
3240 IF GCD=1 AND T(6)<N(6) THEN 3250 ELSE 3280
3250 V=6:RETURN
3260 ' 6 7/8 - 2 1/4 = 6 7/8 - 2 2/8 = 4 5/8
3270 '   1/4 -   1/5 =  5/20 -  4/20 = 1/20
3280 IF GCD=1 AND T(6)>N(6) THEN 3290 ELSE 3320
3290 G(4)=G(2)-G(3):T(4)=T(2)-T(3)
3300 V=4:RETURN
3310 ' 6 3/4 - 2 11/12 = 6 9/12 - 2 11/12 = 5 21/12 - 2 11/12 = 3 10/12 = 3 5/6
3320 G(7)=G(6)
3330 T(7)=T(6)/GCD:N(7)=N(6)/GCD ' reduce
3340 V=7:RETURN
3350 ' 8 1/3 - 4 2/3 = 7 4/3 - 4 2/3 = 3 2/3
3360 G(2)=G(0)-1:T(2)=T(0)+N(0):N(2)=N(0)
3370 G(3)=G(1):T(3)=T(1):N(3)=N(1)
3380 G(4)=G(2)-G(3):T(4)=T(2)-T(3):N(4)=N(3)
3390 TN=T(4):NN=N(4):GOSUB 40 ' search GCD
3400 IF GCD=1 THEN 3410 ELSE 3430
3410 V=4:RETURN
3420 ' 4 1/8 - 5/8 = 3 9/8 - 5/8 = 3 4/8 = 3 1/2
3430 G(5)=G(4)
3440 T(5)=T(4)/GCD:N(5)=N(4)/GCD ' reduce
3450 V=5:RETURN
3460 ' 100 - 20 1/3 = 99 3/3 - 20 1/3 = 79 2/3
3470 G(2)=G(0)-1:T(2)=N(1):N(2)=T(2)
3480 G(3)=G(1):T(3)=T(1):N(3)=N(2)
3490 G(4)=G(2)-G(3):T(4)=T(2)-T(3):N(4)=N(3)
3500 V=4:RETURN
3510 '
3520 TN=T(4):NN=N(4):GOSUB 40 ' search GCD
3530 IF GCD=1 THEN 3540 ELSE 3560
3540 V=3:RETURN
3550 ' 7 5/18 - 5 1/9 = 7 5/18 - 5 2/18 = 2 3/18 = 2 1/6
3560 GOSUB 40 ' search GCD
3570 IF GCD=1 THEN 3180
3580 T(5)=T(4)/GCD:N(5)=N(4)/GCD:G(5)=G(4)
3590 V=5:RETURN
3600 ' 6 3/7 - 4 2/7 = 2 1/7
3610 G(2)=G(0)-G(1):T(2)=T(0)-T(1):N(2)=N(1)
3620 TN=T(2):NN=N(2):GOSUB 40 ' search GCD
3630 IF GCD=1 THEN 3640 ELSE 3660
3640 V=1:RETURN
3650 ' 7 3/10 - 4 1/10 = 3 2/10 = 3 1/5
3660 G(3)=G(2)
3670 T(3)=T(2)/GCD:N(3)=N(2)/GCD ' reduce
3680 G(4)=0:T(4)=0
3690 V=2:RETURN
3700 ' 10 1/2 - 2 1/2 = 8
3710 G(2)=G(0)-G(1):T(2)=0:N(2)=1
3720 V=1:RETURN
3730 ' wait for key pressed
3740 PRINT:PRINT "Press any key to continue ..."
3750 LSET Q=MKI$(0)
3760 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND
3770 F=ASC(Q):RETURN
3780 ' module 1 + -
3790 IF G(1)=0 AND T(1)=0 AND N(1)=1 THEN SW=1
3800 D=2:GOSUB 100 ' calculate length and exact position
3810 GOSUB 110     ' print numerators + -
3820 FOR X=0 TO D
3830  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 3850
3840  IF G(X)=0 THEN 3860
3850  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
3860  IF T(X)=0 OR N(X)=1 THEN 3900
3870  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
3880  L=LF(X)
3890  GOSUB 140    ' draw fraction lines
3900  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
3910  IF X=1 THEN PRINT " =";: IF COPY THEN PRINT #1, " =";
3920 NEXT
3930 GOSUB 120     ' print denominators + -
3940 GOTO 620
3950 ' module 2 + -
3960 D=3:GOSUB 100:GOSUB 110
3970 FOR X=0 TO D
3980  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4000
3990  IF G(X)=0 THEN 4010
4000  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4010  IF T(X)=0 OR N(X)=1 THEN 4050
4020  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4030  L=LF(X)
4040  GOSUB 140
4050  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4060  IF X=1 OR X=2 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4070 NEXT:GOSUB 120:GOTO 620
4080 ' module 3 +
4090 D=4:GOSUB 100:GOSUB 110
4100 FOR X=0 TO D
4110  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4130
4120  IF G(X)=0 THEN 4140
4130  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4140  IF T(X)=0 OR N(X)=1 THEN 4180
4150  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4160  L=LF(X)
4170  GOSUB 140
4180  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4190  IF X=1 OR X=2 OR X=3 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4200 NEXT:GOSUB 120:GOTO 620
4210 ' module 4 + -
4220 D=4:GOSUB 100:GOSUB 110
4230 FOR X=0 TO D
4240  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4260
4250  IF G(X)=0 THEN 4270
4260  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4270  IF T(X)=0 OR N(X)=1 THEN 4310
4280  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4290  L=LF(X)
4300  GOSUB 140
4310  IF X=0 OR X=2 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4320  IF X=1 OR X=3 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4330 NEXT:GOSUB 120:GOTO 620
4340 ' module 5 + -
4350 D=5:GOSUB 100:GOSUB 110
4360 FOR X=0 TO D
4370  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4390
4380  IF G(X)=0 THEN 4400
4390  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4400  IF T(X)=0 OR N(X)=1 THEN 4440
4410  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4420  L=LF(X)
4430  GOSUB 140
4440  IF X=0 OR X=2 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4450  IF X=1 OR X=3 OR X=4 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4460 NEXT:GOSUB 120:GOTO 620
4470 ' module 6 -
4480 D=6:GOSUB 100:GOSUB 110
4490 FOR X=0 TO D
4500  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4520
4510  IF G(X)=0 THEN 4530
4520  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4530  IF T(X)=0 OR N(X)=1 THEN 4570
4540  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4550  L=LF(X)
4560  GOSUB 140
4570  IF X=0 OR X=2 OR X=4 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4580  IF X=1 OR X=3 OR X=5 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4590 NEXT:GOSUB 120:GOTO 620
4600 ' module 7 -
4610 D=7:GOSUB 100:GOSUB 110
4620 FOR X=0 TO D
4630  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4650
4640  IF G(X)=0 THEN 4660
4650  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4660  IF T(X)=0 OR N(X)=1 THEN 4700
4670  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4680  L=LF(X)
4690  GOSUB 140
4700  IF X=0 OR X=2 OR X=4 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4710  IF X=1 OR X=3 OR X=5 OR X=6 THEN PRINT" =";:IF COPY THEN PRINT #1, " =";
4720 NEXT:GOSUB 120:GOTO 620
4730 ' module 8 +
4740 D=6:GOSUB 100:GOSUB 110
4750 FOR X=0 TO D
4760  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4780
4770  IF G(X)=0 THEN 4790
4780  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4790  IF T(X)=0 OR N(X)=1 THEN 4830
4800  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4810  L=LF(X)
4820  GOSUB 140
4830  IF X=0 OR X=2 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4840  IF X=1 OR X=3 OR X=4 OR X=5 THEN PRINT" =";:IF COPY THEN PRINT #1, " =";
4850 NEXT:GOSUB 120:GOTO 620
4860 ' calculate length of numerators
4870 FOR X=0 TO D
4880  Z=T(X)
4890  GOSUB 130 ' count digits
4900  LT(X)=L
4910 NEXT
4920 ' calculate length of denominators
4930 FOR X=0 TO D
4940  Z=N(X)
4950  GOSUB 130 ' count digits
4960  LN(X)=L
4970 NEXT
4980 ' calculate length of whole numbers and space of one fraction
4990 FOR X=0 TO D  ' numerator > denominator ?
5000  IF LT(X)>LN(X) THEN LF(X)=LT(X) ELSE LF(X)=LN(X)
5010 NEXT
5020 FOR X=0 TO D
5030  Z=G(X)
5040  GOSUB 130 ' count digits
5050  LG(X)=L
5060  IF G(X)=0 THEN LB(X)=LF(X):GOTO 5090
5070  LB(X)=LG(X)+LF(X)+1
5080  IF N(X)=1 THEN LB(X)=LB(X)-1
5090 NEXT
5100 ' calculate exact positions of the numerators
5110 B(0)=LB(0)-LT(0)
5120 B(1)=LB(0)+LB(1)-LT(1)+3
5130 B(2)=LB(0)+LB(1)+LB(2)-LT(2)+6        ' module 1
5140 B(3)=LB(0)+LB(1)+LB(2)+LB(3)-LT(3)+9  ' module 2
5150 B(4)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)-LT(4)+12       ' module 3 + 4
5160 B(5)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)-LT(5)+15 ' module 5
5170 B(6)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)-LT(6)+18       ' module 6 + 8
5180 B(7)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)+LB(7)-LT(7)+21 ' module 7
5190 ' calculate exact positions of the denominators
5200 O(0)=LB(0)-LN(0)
5210 O(1)=LB(0)+LB(1)-LN(1)+3
5220 O(2)=LB(0)+LB(1)+LB(2)-LN(2)+6        ' module 1
5230 O(3)=LB(0)+LB(1)+LB(2)+LB(3)-LN(3)+9  ' module 2
5240 O(4)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)-LN(4)+12       ' module 3 + 4
5250 O(5)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)-LN(5)+15 ' module 5
5260 O(6)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)-LN(6)+18       ' module 6 + 8
5270 O(7)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)+LB(7)-LN(7)+21 ' module 7
5280 ' 10 3/4 + - 0 = 10 3/4
5290 IF SW=1 THEN B(2)=B(2)+1:O(2)=O(2)+1:SW=0
5300 RETURN
5310 ' print numerators + -
5320 FOR X=0 TO D
5330  IF C=1 AND V=4 AND T(X)>0 THEN 5350
5340  IF T(X)=0 OR N(X)=1 THEN 5360
5350  PRINT TAB(B(X)+1)T(X);:IF COPY THEN PRINT #1, TAB(B(X)+1)T(X);
5360 NEXT
5370 PRINT:IF COPY THEN PRINT #1, "" 
5380 RETURN
5390 ' print denominators + -
5400 PRINT:IF COPY THEN PRINT #1, ""
5410 FOR X=0 TO D
5420  IF C=1 AND V=4 AND T(X)>0 THEN 5440
5430  IF N(X)=1 THEN 5450
5440  PRINT TAB(O(X)+1)N(X);:IF COPY THEN PRINT #1, TAB(O(X)+1)N(X);
5450 NEXT
5460 PRINT:PRINT:IF COPY THEN PRINT #1, :PRINT #1, ""
5470 RETURN
5480 ' count the digits of the number
5490 L=1
5500 E=INT(Z/10):IF E<>0 THEN L=L+1:Z=E:GOTO 5500 ELSE RETURN
5510 ' draw lines as big as the fraction is
5520 PRINT TAB(P+2)"";:PRINT STRING$(L,"Ä");
5530 IF COPY THEN PRINT #1, TAB(P+2)"";:PRINT #1, STRING$(L,"-");
5540 RETURN
5550 ' module 1 * /
5560 D=4:GOSUB 100 ' calculate length and exact position
5570 GOSUB 150     ' print numerators * /
5580 FOR X=0 TO D
5590  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 5610
5600  IF G(X)=0 THEN 5620
5610  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
5620  IF T(X)=0 THEN 5660
5630  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
5640  L=LF(X)
5650  GOSUB 140    ' draw fraction lines
5660  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
5670  IF X=1 OR X=3 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
5680  IF X=2 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
5690 NEXT
5700 GOSUB 160     ' print denominators * /
5710 GOTO 620
5720 ' module 2 * /
5730 D=5:GOSUB 100:GOSUB 150
5740 FOR X=0 TO D
5750  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 5770
5760  IF G(X)=0 THEN 5780
5770  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
5780  IF T(X)=0 THEN 5820
5790  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
5800  L=LF(X)
5810  GOSUB 140
5820  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
5830  IF X=2 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
5840  IF X=1 OR X=3 OR X=4 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
5850 NEXT:GOSUB 160:GOTO 620
5860 ' module 3 * /
5870 D=6:GOSUB 100:GOSUB 150
5880 FOR X=0 TO D
5890  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 5910
5900  IF G(X)=0 THEN 5920
5910  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
5920  IF T(X)=0 THEN 5960
5930  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
5940  L=LF(X)
5950  GOSUB 140
5960  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
5970  IF X=2 OR X=4 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
5980  IF X=1 OR X=3 OR X=5 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
5990 NEXT:GOSUB 160:GOTO 620
6000 ' module 4 * /
6010 D=7:GOSUB 100:GOSUB 150
6020 FOR X=0 TO D
6030  IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 6050
6040  IF G(X)=0 THEN 6060
6050  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
6060  IF T(X)=0 THEN 6100
6070  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
6080  L=LF(X)
6090  GOSUB 140
6100  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
6110  IF X=2 OR X=4 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
6120  IF X=1 OR X=3 OR X=5 OR X=6 THEN PRINT" =";:IF COPY THEN PRINT #1, " =";
6130 NEXT:GOSUB 160:GOTO 620
6140 ' print numerators * /
6150 FOR X=0 TO D
6160  IF T(X)=0 THEN 6180
6170  PRINT TAB(B(X)+1)T(X);:IF COPY THEN PRINT #1, TAB(B(X)+1)T(X);
6180 NEXT
6190 PRINT:IF COPY THEN PRINT #1, ""
6200 RETURN
6210 ' print denominators * /
6220 PRINT:IF COPY THEN PRINT #1, ""
6230 FOR X=0 TO D
6240  IF T(X)=0 THEN 6260
6250  PRINT TAB(O(X)+1)N(X);:IF COPY THEN PRINT #1, TAB(O(X)+1)N(X);
6260 NEXT
6270 PRINT:PRINT:IF COPY THEN PRINT #1, "":PRINT #1, ""
6280 RETURN
6290 ' solve fraction problem
6300 IF NN=TN THEN G(8)=1 :N(8)=1:RETURN
6310 IF TN=0  THEN G(8)=0 :N(8)=1:RETURN
6320 IF NN=1  THEN G(8)=TN:N(8)=1:RETURN
6330 IF TN/NN=INT(TN/NN) THEN G(8)=TN/NN:N(8)=1:RETURN
6340 GOSUB 40 ' search GCD
6350 TN=TN/GCD:NN=NN/GCD ' reduce
6360 G(8)=INT(TN/NN):T(8)=TN-G(8)*NN:N(8)=NN
6370 RETURN
6380 ' help info
6390 PRINT"THIS PROGRAM SHOWS YOU THE COMPLETE SOLUTION OF FRACTIONS"
6400 PRINT"If you don't need a diskfile, type <N/n> or press <Enter>"
6410 PRINT
6420 PRINT"1) W.N/D ? 8.2/5  or press <Enter> "
6430 PRINT"+ - * /  ? +      or press <Enter> "
6440 PRINT"2) W.N/D ? 3.1/4  or press <Enter> ":PRINT
6450 PRINT"By pressing 3 times <Enter> you will automatically get":PRINT
6460 PRINT"                    2         1"
6470 PRINT"the solution of  8 ÄÄÄ  +  3 ÄÄÄ  ?"
6480 PRINT"                    5         4"
6490 PRINT:GOSUB 80:CLS ' wait key
6500 PRINT "   2         1"
6510 PRINT "8 ÄÄÄ  -  3 ÄÄÄ  = ?    press <Enter> - <Enter>"
6520 PRINT "   5         4":PRINT
6530 PRINT"1) W.N/D ? <Enter>"
6540 PRINT"+ - * /  ? -"
6550 PRINT"2) W.N/D ? <Enter>":PRINT
6560 PRINT "To see the product  press <Enter> * <Enter>":PRINT
6570 PRINT"1) W.N/D ? <Enter>"
6580 PRINT"+ - * /  ? *"
6590 PRINT"2) W.N/D ? <Enter>": PRINT
6600 PRINT "To see the quotient press <Enter> / <Enter>":PRINT
6610 PRINT"1) W.N/D ? <Enter>"
6620 PRINT"+ - * /  ? /"
6630 PRINT"2) W.N/D ? <Enter>":PRINT
6640 GOSUB 80:CLS ' wait key
6650 PRINT"W = Whole integer number"
6660 PRINT". = To separate number from the fraction"
6670 PRINT"N = Numerator"
6680 PRINT"/ = Fraction bar"
6690 PRINT"D = Denominator":PRINT
6700 PRINT"    7"
6710 PRINT"12 ÄÄÄ  Enter this as follows: 12.7/8 <Enter> "
6720 PRINT"    8                            ³"
6730 PRINT"                                 ³"
6740 PRINT"Notice the dot . >>ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ":PRINT
6750 PRINT"    3"
6760 PRINT"   ÄÄÄ  Enter: .3/4 <Enter> "
6770 PRINT"    4":PRINT:PRINT
6780 PRINT"This program memorizes your fractions!"
6790 PRINT"For quick results just type <Enter> + - * / <Enter>":PRINT
6800 PRINT"Enter a 0 (zero) to return to the menu"
6810 GOSUB 80:CLS ' wait key
6820 PRINT "Enter Repeating Decimals like these examples:":PRINT
6830 PRINT ".(6) .(24) .(09) .(36) .(26) .(142857) .(456) .(3)":PRINT
6840 PRINT ".7(6)  .70(8)  .08(09)  .21(456)  .654(69)  .13(7)":PRINT
6850 PRINT "2.708(3)  7.12(3)  4.23(138)  12.45.(67)  7.05(04)":PRINT
6860 GOSUB 80:CLS:RETURN
6870 ' exit
6880 IF COPY THEN CLOSE
6890 KEY 5,"fraction.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS:END
6900 ' repeating decimal to fraction
6910 PRINT:COLOR 7,0:B=2
6920 LINE INPUT "Repeating decimal 0 menu ? ";B1$
6930 IF B1$="0" THEN B1$=M7$:RP=0:CLS:GOTO 480
6940 IF B1$="" THEN B1$=M7$
6950 B$=B1$:GOSUB 190
6960 IF NG=0 THEN 6920
6970 RT=LEN(T$):RN=LEN(N$):M7$=B$
6980 GOSUB 200 ' clear line
6990 IF G$="" AND T$=""  THEN 7030
7000 IF G$="" AND T$<>"" THEN 7080
7010 GOTO 7100
7020 ' case 1  .(6) .(23) .(90) .(456) .(142857)
7030 G1$=N$:T1$="":N1$="1":G2$=""
7040 FOR C=1 TO RL:G2$=G2$+"9":NEXT
7050 T2$="":N2$="1":C=2
7060 GOTO 7160
7070 ' case 2  .4(5) .70(8) .08(09) .21(456)
7080 G1$="":GOTO 7110
7090 ' case 3  2.708(3) 7.12(3) 4.23(13) 1.5(20)
7100 G1$=G$
7110 Z=1:FOR C=1 TO RT:Z=Z*10:NEXT:N1$=STR$(Z)
7120 T1$=T$:G2$="":T2$=N$:DN$=""
7130 FOR C=1 TO RN:DN$=DN$+"9":NEXT
7140 FOR C=1 TO RT:DN$=DN$+"0":NEXT
7150 N2$=DN$:C=3
7160 IF C=3 THEN COLOR 11,0
7170 IF C=2 THEN COLOR 15,0
7180 PRINT B$;" = ";:IF COPY THEN PRINT #1,B$; " = ";
7190 M1$=G1$:M2$=T1$:M3$=N1$:M4$=G2$:M5$=T2$:M6$=N2$
7200 GOTO 1010
7210 ' scan repeating decimal input
7220 L=LEN(B$)
7230 CD=0:CL=0:CR=0:CN=0
7240 IF LEFT$(B$,1)="(" OR LEFT$(B$,1)=")" THEN 7450 ' (1234   )654
7250 IF RIGHT$(B$,1)="." THEN 7450 ' 123.
7260 FOR I=1 TO L
7270  Z=ASC(MID$(B$,I,1))
7280  IF Z=46 THEN CD=CD+1 ' check .
7290  IF Z=40 THEN CL=CL+1 ' check (
7300  IF Z=41 THEN CR=CR+1 ' check )
7310  IF Z>58 THEN CN=CN+1 ' check : to ~
7320 NEXT
7330  IF CD=0 OR CD>1 OR CL>1 OR CR>1 OR CN>0 THEN 7450
7340 FOR I=1 TO L
7350  IF MID$(B$,I,2)="()" THEN 7450
7360 NEXT
7370 FOR I=1 TO L
7380  IF MID$(B$,I,1)="." THEN G$=MID$(B$,1,I-1):W=I+1
7390  IF MID$(B$,I,1)="(" THEN T$=MID$(B$,W,I-W):N$=MID$(B$,I+1,L)
7400 NEXT
7410  IF RIGHT$ (N$,1)<>")" THEN 7450
7420  IF RIGHT$ (N$,1)= ")" THEN RL=LEN(N$)-1:N$=LEFT$(N$,RL)
7430 NG=1:RETURN
7440 ' clear line
7450 NG=0:PRINT CHR$(30);:PRINT STRING$(79,32):PRINT CHR$(30);
7460 RETURN
7470 ' scan fraction input
7480 L=LEN(B$)
7490 CD=0:CL=0
7500  IF LEFT$(B$,1)="/" OR RIGHT$(B$,1)="/"  THEN 7450 ' /1234 6541/
7510  IF RIGHT$(B$,1)="0." THEN 7450 ' 0.
7520  IF RIGHT$(B$,1)="." THEN 7450 ' 123.  .2356/4789
7530 FOR I=1 TO L
7540  Z=ASC(MID$(B$,I,1))
7550  IF Z<46 OR Z>57 THEN 7450 ' <space to -> or <: to þ>
7560  IF MID$(B$,I,1)="/" THEN 7750 ' /.
7570  IF MID$(B$,I,1)="." THEN 7810 ' ./
7580 NEXT
7590 FOR I=1 TO L
7600  Z=ASC(MID$(B$,I,1))
7610  IF Z=46 THEN CD=CD+1:IF CD=0 OR CD>1 THEN 7450 '...
7620  IF Z=47 THEN CL=CL+1:IF CL=0 OR CL>1 THEN 7450 '///
7630 NEXT
7640  IF CL=1 AND CD=0 THEN 7450 ' check 123/789
7650  IF CD=1 AND CL=0 THEN 7450 ' check .123
7660 FOR I=1 TO L
7670  IF MID$(B$,I,1)="." THEN G$=MID$(B$,1,I-1):W=I+1
7680  IF MID$(B$,I,1)="/" THEN T$=MID$(B$,W,I-W):N$=MID$(B$,I+1,L)
7690 NEXT
7700 IF T$="" THEN G$=B$:N$="1"
7710 IF T$="0" THEN 7450 ' 1.0/7  .0/7
7720 IF N$="0" THEN 7450 ' .23/0
7730 NG=1:RETURN
7740 ' check /1. /12. /123.45   23/1234.567
7750 EC=I+1
7760 FOR I=EC TO L
7770  IF MID$(B$,I,1)="." THEN 7450
7780 NEXT
7790 GOTO 7590
7800 ' check ./   123./56
7810 EC=I+1:IF MID$(B$,I,1)="/" THEN 7450
7820 GOTO 7590
7830 ' basic fractions calculations!
7840 ' 7 1/3  + 1 1/2 = 22/3  +  3/2 =  44/6  +   9/6  =  53/6  = 8  5/6
7850 ' 3 5/12 - 1 7/8 = 41/12 - 15/8 = 328/96 - 180/96 = 148/96 = 1 13/24
7860 ' 5 1/3  x 8 2/5 = 16/3  x 42/5 = 672/15  = 44 4/5
7870 ' 8/15 ö 9 4/5 = 98/15 x 5/49 = 490/735 = 2/3
