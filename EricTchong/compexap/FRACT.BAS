10 ' fraction.bas - April 21, 2004 - Freeware
20 GOTO 230 ' begin
30 SAVE "fraction":LIST-210
40 GOTO 1080 ' search for GCD
50 GOTO 1100 ' scan operation * / + -
60 GOTO 1550 ' analyse +
70 GOTO 2220 ' analyse -
80 GOTO 2770 ' wait key pressed
90 GOTO 2780 ' get key input
100 GOTO 3560 ' calculate length and exact position
110 GOTO 3830 ' print numerators   + -
120 GOTO 3890 ' print denominators + -
130 GOTO 3960 ' count digits
140 GOTO 3990 ' draw fraction lines ÄÄÄ ---
150 GOTO 4460 ' print numerators   * /
160 GOTO 4510 ' print denominators * /
170 GOTO 4570 ' get final answer
180 GOTO 4650 ' help info
190 GOTO 5110 ' scan repeating decimal input
200 GOTO 5250 ' clear line
210 GOTO 5270 ' scan fraction input
220 ' begin
230 DEFDBL G,T,N,Z,E,M:DEFSTR Q:Q=MKI$(0):M1$="8":M2$="2":M3$="5":M4$="3":M5$="1"
240 M6$="4":M7$="2.708(3)":G(8)=8:T(8)=2:N(8)=5:RP=0:K$="+":O$(1)=" x":O$(2)=" :"
250 O$(3)=" +":O$(4)=" -":KEY OFF:CLS:PRINT "**************************************"
260 PRINT "* FOUR FUNCTION FRACTIONS CALCULATOR *":PRINT "*       Programmed in GW-BASIC       *"
270 PRINT "*    Compiled with PowerBasic 3.2    *":PRINT "*          by Eric F. Tchong         *"
280 PRINT "*        serenata@setarnet.aw        *":PRINT "*               ARUBA                *"
290 PRINT "*   (C) May 1992  -  Freeware 2004   *":PRINT "**************************************"
300 PRINT:PRINT "For instructions: press <Yy> ?":GOSUB 90 ' get key input
310 IF F=89 OR F=121 THEN CLS:GOSUB 180 ' help info
320 CLS:PRINT "For a diskfile:   press <Yy> ?":GOSUB 90 ' get key input
330 IF F=89 OR F=121 THEN COPY=1 ELSE COPY=0
340 IF COPY THEN 350 ELSE 380
350 CLS:PRINT "Enter a DOS filename ? ";:LINE INPUT Z$
360 IF LEFT$(Z$,1)=" " THEN Z$=MID$(Z$,2):GOTO 360
370 OPEN "O",#1,Z$:' select chain or variabel calculation
380 CLS:PRINT "1. Chain    calculation":PRINT "2. Variabel calculation"
390 PRINT "3. Convert a repeating decimal":PRINT "4. Exit this program ..":PRINT
400 INPUT "Choose 1, 2, 3, or 4 ";A:CLS:IF A<1 OR A>4 THEN CLS:GOTO 380
410 IF A=4 THEN 4910
420 IF A=3 THEN RP=1:GOTO 4930 ' repeating decimal
430 ' display intermediate or final results only
440 PRINT "1. Display final results only.":PRINT "2. Display intermediate and final results.":PRINT
450 INPUT "Choose 1 or 2 ";B:CLS:IF B<1 OR B>2 THEN CLS:GOTO 440
460 ' empty strings = recall memory, 0 = return to menu
470 FOR X=0 TO 7:G(X)=0 ' G(X) = whole number
480  T(X)=0 ' T(X) = numerator
490  N(X)=1 ' N(X) = denominator
500 NEXT:IF RP=1 THEN 4930 ' repeating decimal
510 IF N(8)=1 THEN T(8)=0
520 IF A=1 THEN M1$=STR$(G(8)):M2$=STR$(T(8)):M3$=STR$(N(8))
530 COLOR 7,0:PRINT:' get first fraction
540 LINE INPUT "1) W.N/D 0 menu ? ";B1$:IF B1$="0" THEN 380
550 B$=B1$:GOSUB 210 ' scan fractional input
560 IF NG=0 THEN 540
570 G1$=G$:T1$=T$:N1$=N$:IF G1$="" AND T1$="" THEN G1$=M1$:T1$=M2$:N1$=M3$:GOTO 600
580 IF G1$="0" THEN CLS:GOTO 380
590 M1$=G1$:M2$=T1$:M3$=N1$
600 G$="":T$="":N$="":PRINT "   + - * /      ? ";K$:' obtain operation
610 GOSUB 90 ' get key input
620 IF F=13 THEN LSET Q=K$:GOSUB 50:GOTO 690 ' * / + -
630 IF F=42 THEN C=1:GOTO 690 ' *
640 IF F=47 THEN C=2:GOTO 690 ' /
650 IF F=43 THEN C=3:GOTO 690 ' +
660 IF F=45 THEN C=4:GOTO 690 ' -
670 IF F<42 OR F>47 OR F=44 OR F=46 THEN 680
680 PRINT CHR$(30);"   What ??":GOTO 610
690 K$=Q:PRINT CHR$(30);"   + - * /      ? ";K$:' get second fraction
700 LINE INPUT "2) W.N/D        ? ";B2$:B$=B2$:GOSUB 210 ' scan fractional input
710 IF NG=0 THEN 700
720 G2$=G$:T2$=T$:N2$=N$:IF G2$="" AND T2$="" THEN G2$=M4$:T2$=M5$:N2$=M6$:GOTO 740
730 M4$=G2$:M5$=T2$:M6$=N2$
740 G$="":T$="":N$="":' save first & second fraction
750 G(0)=VAL(G1$):T(0)=VAL(T1$):N(0)=VAL(N1$):G(1)=VAL(G2$):T(1)=VAL(T2$):N(1)=VAL(N2$):PRINT
760 ' reduce fractions 4/8 = 1/2, 10/5 = 5/1
770 TN=T(0):NN=N(0):GOSUB 40    ' search GCD
780 T(0)=T(0)/GCD:N(0)=N(0)/GCD ' reduce
790 TN=T(1):NN=N(1):GOSUB 40    ' search GCD
800 T(1)=T(1)/GCD:N(1)=N(1)/GCD ' reduce
810 ' numerator > denominator 7 8/5 = 8 3/5
820 IF T(0)>N(0) THEN G(0)=G(0)+INT(T(0)/N(0)):T(0)=T(0)-INT(T(0)/N(0))*N(0)
830 IF T(1)>N(1) THEN G(1)=G(1)+INT(T(1)/N(1)):T(1)=T(1)-INT(T(1)/N(1))*N(1)
840 ' 3 3/3 = 4
850 IF T(0)=N(0) THEN G(0)=G(0)+1:T(0)=0:N(0)=1
860 IF T(1)=N(1) THEN G(1)=G(1)+1:T(1)=0:N(1)=1
870 ' T1 = 2 + 8 * 5 = 42   8 2/5
880 ' T2 = 1 + 3 * 4 = 13   3 1/4
890 T1=T(0)+G(0)*N(0):T2=T(1)+G(1)*N(1):' if zero go module 1 + -
900 IF G(1)=0 AND T(1)=0 AND C=1 THEN G(2)=0:N(2)=1:COLOR 14,0:GOTO 2800
910 ' select * / + -
920 ON C GOTO 930,1000,1470,2080:' start multiplication solving
930 COLOR 14,0:TN=T1*T2         ' TN = 42 * 13 = 546
940 NN=N(0)*N(1)     ' NN =  5 *  4 = 20
950 GOSUB 170        ' get final answer
960 IF B=1 THEN 1070 ' go display final answer
970 GOSUB 1140       ' analyse *
980 ' modules 1, 2, 3, 4 * /   module 1 + -
990 ON V GOTO 4030,4160,4260,4360,2800:' start division solving
1000 COLOR 15,0:IF G(1)=0 AND N(1)=1 THEN PRINT "Division by zero":GOTO 470
1010 TN=T1*N(1)       ' TN = 42 *  4 = 168
1020 NN=N(0)*T2       ' NN =  5 * 13 = 65
1030 GOSUB 170        ' get final answer
1040 IF B=1 THEN 1070 ' go display final answer
1050 GOTO 970        ' analyse /
1060 ' final results only
1070 G(2)=G(8):T(2)=T(8):N(2)=N(8):GOTO 2800:' search for GCD
1080 M=TN:N=NN:WHILE M:N=N-M*INT(N/M):SWAP M,N:WEND:GCD=N:RETURN
1090 ' scan operation * / + -
1100 IF K$="*" THEN C=1 ELSE IF K$="/" THEN C=2
1110 IF K$="+" THEN C=3 ELSE IF K$="-" THEN C=4
1120 RETURN
1130 ' analyse if the * or / problem is of the V=1,2,3,4 or 5 form
1140 IF C=1 THEN 1160 ELSE 1170
1150 ' multiplication
1160 T(2)=G(0)*N(0)+T(0):T(3)=G(1)*N(1)+T(1):N(3)=N(1):N(2)=N(0):GOTO 1180:' division
1170 T(2)=G(0)*N(0)+T(0):N(3)=G(1)*N(1)+T(1):T(3)=N(1):N(2)=N(0):GOTO 1180:' process * / problem
1180 TN=T(2):NN=N(3):GOSUB 40 ' search GCD
1190 GCD1=GCD:TN=T(3):NN=N(2):GOSUB 40 ' search GCD
1200 GCD2=GCD:IF GCD1=1 AND GCD2=1 THEN 1320
1210 ' reduce fractions
1220 T(4)=T(2)/GCD1:N(5)=N(3)/GCD1:N(4)=N(2)/GCD2:T(5)=T(3)/GCD2:T(6)=T(4)*T(5):N(6)=N(4)*N(5)
1230 IF T(6)<N(6) THEN 1400
1240 '    10 x 1/2   = 5   1 25/66 x 30 6/13 = 42
1250 ' 3 5/7 ö 1 6/7 = 2   6 4/11  ö 10/11   = 7
1260 IF N(6)=1 THEN 1270 ELSE 1300
1270 G(7)=T(6):V=4:RETURN
1280 ' 12 2/45 x 7 3/8 = 88 149/180
1290 ' 2 3/26  ö 1 5/6 = 1 2/13     3/4 ö 5/8 = 1 1/5   
1300 G(7)=INT(T(6)/N(6)):T(7)=T(6)-G(7)*N(6):N(7)=N(6):V=4:RETURN
1310 ' can not reduce fractions
1320 T(4)=T(2)*T(3):N(4)=N(2)*N(3):' 2 x 1/5 = 2/5   3/4 ö 2 = 3/8
1330 IF T(0)=T(2) AND N(0)=N(2) AND T(1)=T(3) AND N(1)=N(3) THEN 1450
1340 IF T(4)<N(4) THEN 1350 ELSE 1380
1350 V=1:RETURN
1360 ' 3 x 2 = 3/1 x 2/1 = 6/1 = 6   5 7/9 x 6 8/11 = 38 86/99
1370 ' 999 ö 6 1/2 = 153 9/13        7 3/4 ö 2 1/3 = 3 9/28
1380 G(5)=INT(T(4)/N(4)):T(5)=T(4)-G(5)*N(4):N(5)=N(4):V=2:RETURN
1390 ' 4 1/2 ö 45 = 1/10   2 4/9 ö 3 2/3 = 2/3
1400 IF T(0)=T(2) AND N(0)=N(2) AND T(1)=T(3) AND N(1)=N(3) THEN 1430
1410 V=3:RETURN
1420 ' 2/5 x 7/24 = 1/5 x 7/12 = 7/60   2/5 x 3/4 = 1/5 x 3/2 = 3/10
1430 T(2)=T(4):T(3)=T(5):T(4)=T(6):N(2)=N(4):N(3)=N(5):N(4)=N(6):V=1:RETURN
1440 ' 7/8 x 3/4 = 21/32  2/5 x 1/19 = 2/95
1450 T(2)=T(4):N(2)=N(4):V=5:RETURN
1460 ' start addition solving
1470 COLOR 11,0:TN=T1*N(1)+T2*N(0) ' TN = 42 * 4 + 13 * 5 = 233
1480 NN=N(0)*N(1)       ' NN = 5 * 4 = 20
1490 GOSUB 170          ' get final answer
1500 IF B=1 THEN 1070   ' go display final answer
1510 GOSUB 60           ' analyse +
1520 ' modules 1, 2, 3, 4, 5 + -   module 8 +
1530 ON V GOTO 2800,2930,3020,3110,3200,470,470,3470
1540 ' analyse if the + problem is of the V=1,2,3,4,5 or 8 form
1550 IF T(0)=0 OR T(1)=0 THEN 1800
1560 IF N(0)=N(1) AND T(0)+T(1)<N(0) THEN 1800
1570 IF N(0)=N(1) AND T(0)+T(1)=N(0) THEN 1870
1580 IF N(0)=N(1) AND T(0)+T(1)>N(0) THEN 1900
1590 ' 17 1/6 + 4 1/3 = 17 1/6 + 4 2/6 = 21 3/6 = 21 1/2
1600 TN=N(0):NN=N(1):GOSUB 40 ' search GCD
1610 G(2)=G(0):G(3)=G(1):G(4)=G(2)+G(3):LCM=N(0)/GCD*N(1)
1620 T(2)=LCM/N(0)*T(0):T(3)=LCM/N(1)*T(1):T(4)=T(2)+T(3):N(2)=LCM :N(3)=N(2):N(4)=N(3)
1630 TN=T(4):NN=N(4):GOSUB 40 ' search GCD
1640 IF GCD<>1 AND T(4)<N(4) THEN 1650 ELSE 1680
1650 G(5)=G(4):T(5)=T(4)/GCD:N(5)=N(4)/GCD:V=5:RETURN
1660 ' 5 3/4 + 5 1/8 = 5 6/8  + 5 1/8  = 10 7/8
1670 ' 8 2/5 + 3 1/4 = 8 8/20 + 3 5/20 = 11 13/20
1680 IF T(4)<N(4) THEN 1690 ELSE 1720
1690 V=4:RETURN
1700 '  2 2/3 + 7 3/4 = 2 8/12 + 7 9/12 = 9 17/12 = 10 5/12
1710 ' 14 2/3 + 2 5/6 = 14 4/6 + 2 5/6  = 16 9/6  = 17 3/6 = 17 1/2
1720 G(5)=G(4)+INT(T(4)/N(4)):T(5)=T(4)-(INT(T(4)/N(4))*N(4)):N(5)=N(4)
1730 TN=T(5):NN=N(5):GOSUB 40 ' search GCD
1740 IF GCD<>1 THEN 1760
1750 V=5:RETURN
1760 G(6)=G(5):T(6)=T(5)/GCD:N(6)=N(5)/GCD:V=8:RETURN
1770 ' 5 + 1 1/2 = 6 1/2   6 3/7 + 2 2/7 = 8 5/7   6 3/7 + 2 = 8 3/7
1780 '   1/78 + 3 7/78 =  3 8/78 =  3 4/49
1790 ' 7 1/78 + 3 7/78 = 10 8/78 = 10 4/39
1800 IF N(0)<N(1) THEN N(2)=N(1) ELSE N(2)=N(0)
1810 IF N(0)=N(1) THEN N(2)=N(0)
1820 G(2)=G(0)+G(1):T(2)=T(0)+T(1):TN=T(2):NN=N(2):GOSUB 40 ' search GCD
1830 IF GCD<>1 THEN 1850
1840 V=1:RETURN
1850 G(3)=G(2):T(3)=T(2)/GCD:N(3)=N(2)/GCD:V=2:RETURN
1860 ' 7/9 + 2/9 = 9/9 = 1   3 1/2 + 2 1/2 = 5 2/2 = 6
1870 G(2)=G(0)+G(1):G(3)=G(2)+1:T(2)=T(0)+T(1):T(3)=0:N(2)=N(1):N(3)=1:V=2:RETURN
1880 '    7/8 + 5/8    = 12/8    = 3/2   = 1 1/2
1890 ' 99/152 + 99/152 = 198/152 = 99/76 = 1 23/76
1900 G(2)=0:G(3)=0:IF G(0)=0 AND G(1)=0 THEN 1910 ELSE 1950
1910 T(2)=T(0)+T(1):N(2)=N(1):TN=T(2):NN=N(2):GOSUB 40 ' search GCD
1920 T(3)=T(2)/GCD:N(3)=N(2)/GCD  ' reduce
1930 G(4)=INT(T(3)/N(3)):T(4)=T(3)-(G(4)*N(3)):N(4)=N(3):V=3:RETURN
1940 ' 7 7/11 + 8 8/11 = 15 15/11 = 16 4/11
1950 G(2)=G(0)+G(1):T(2)=T(0)+T(1):N(2)=N(1):TN=T(2):NN=N(2):GOSUB 40 ' search GCD
1960 IF GCD<>1 THEN 2050
1970 G(3)=G(2)+INT(T(2)/N(2)):T(3)=T(2)-(INT(T(2)/N(2))*N(2)):N(3)=N(2)
1980 TN=T(3):NN=N(3):GOSUB 40 ' search GCD
1990 IF GCD=1 THEN 2000 ELSE 2020
2000 T(4)=0:N(4)=0:V=2:RETURN
2010 '
2020 G(4)=G(3):T(4)=T(3)/GCD:N(4)=N(3)/GCD ' reduce
2030 V=3:RETURN
2040 ' 2 5/6 + 4 5/6 = 6 10/6 = 6 5/3 = 7 2/3
2050 G(3)=G(2):T(3)=T(2)/GCD:N(3)=N(2)/GCD ' reduce
2060 G(4)=G(3)+INT(T(3)/N(3)):T(4)=T(3)-(INT(T(3)/N(3))*N(3)):N(4)=N(3):V=3:RETURN
2070 ' start subtraction solving
2080 COLOR 10,0:T1=T(0)+G(0)*N(0):T2=T(1)+G(1)*N(1):TN=T1*N(1)-T2*N(0):IF TN<0 THEN 2200  ' go swap
2090 ' 3 1/2 - 3 1/2 = 0
2100 IF TN=0 THEN G(2)=0:T(2)=0:N(2)=1:GOTO 2800
2110 T1=T(0)+G(0)*N(0)  ' T1 = 2 + 8 * 5 = 42   8 2/5
2120 T2=T(1)+G(1)*N(1)  ' T2 = 1 + 3 * 4 = 13   3 1/4
2130 TN=T1*N(1)-T2*N(0) ' TN = 42 * 4 - 13 * 5 = 103
2140 NN=N(0)*N(1)       ' NN = 5 * 4 = 20
2150 GOSUB 170          ' get final answer
2160 IF B=1 THEN 1070   ' go display final answer
2170 GOSUB 70           ' analyse -
2180 ' modules 1, 2, 3, 4, 5 + -   modules 6, 7 -
2190 ON V GOTO 2800,2930,3020,3110,3200,3290,3380:' change if subtraction is negative
2200 SWAP M1$,M4$:SWAP G(0),G(1):SWAP M2$,M5$:SWAP T(0),T(1):SWAP M3$,M6$:SWAP N(0),N(1):GOTO 2100
2210 ' analyse if the - problem is of the V=1,2,3,4,5,6 or 7 form
2220 IF N(0)=N(1) AND T(0)>T(1) THEN 2680
2230 IF T(0)=T(1) AND N(0)=N(1) THEN 2750
2240 IF N(0)=N(1) AND T(0)<T(1) THEN 2490
2250 ' 10 1/2 - 2 = 8 1/2
2260 IF T(1)=0 THEN 2270 ELSE 2290
2270 G(2)=G(0)-G(1):T(2)=T(0):N(2)=N(0):V=1:RETURN
2280 ' 
2290 IF T(0)=0 THEN 2570
2300 IF G(0)=0 AND G(1)=0 THEN V=4
2310 TN=N(0):NN=N(1):GOSUB 40 ' search GCD
2320 LCM=N(0)/GCD*N(1):G(2)=G(0):T(2)=LCM/N(0)*T(0):N(2)=LCM:G(3)=G(1):T(3)=LCM/N(1)*T(1):N(3)=N(2)
2330 G(4)=G(2)-G(3)              :N(4)=N(3)
2340 IF T(2)>T(3) THEN T(4)=T(2)-T(3):TN=T(4):NN=N(4):GOTO 2640
2350 IF V=3 AND T(2)>T(3) THEN T(4)=T(2)-T(3):GOTO 2600
2360 '  5 3/4 - 1 7/8 = 5 6/8 - 1 7/8 = 4 14/8 - 1 7/8 = 3 7/8
2370 G(4)=G(2)-1:T(4)=T(2)+N(2):G(5)=G(3):T(5)=T(3):N(5)=N(4)
2380 G(6)=G(4)-G(5):T(6)=T(4)-T(5):N(6)=N(5):TN=T(6):NN=N(6):GOSUB 40 ' search GCD
2390 IF GCD=1 AND T(6)<N(6) THEN 2400 ELSE 2430
2400 V=6:RETURN
2410 ' 6 7/8 - 2 1/4 = 6 7/8 - 2 2/8 = 4 5/8
2420 '   1/4 -   1/5 =  5/20 -  4/20 = 1/20
2430 IF GCD=1 AND T(6)>N(6) THEN 2440 ELSE 2460
2440 G(4)=G(2)-G(3):T(4)=T(2)-T(3):V=4:RETURN
2450 ' 6 3/4 - 2 11/12 = 6 9/12 - 2 11/12 = 5 21/12 - 2 11/12 = 3 10/12 = 3 5/6
2460 G(7)=G(6):T(7)=T(6)/GCD:N(7)=N(6)/GCD ' reduce
2470 V=7:RETURN
2480 ' 8 1/3 - 4 2/3 = 7 4/3 - 4 2/3 = 3 2/3
2490 G(2)=G(0)-1:T(2)=T(0)+N(0):N(2)=N(0):G(3)=G(1):T(3)=T(1):N(3)=N(1)
2500 G(4)=G(2)-G(3):T(4)=T(2)-T(3):N(4)=N(3):TN=T(4):NN=N(4):GOSUB 40 ' search GCD
2510 IF GCD=1 THEN 2520 ELSE 2540
2520 V=4:RETURN
2530 ' 4 1/8 - 5/8 = 3 9/8 - 5/8 = 3 4/8 = 3 1/2
2540 G(5)=G(4):T(5)=T(4)/GCD:N(5)=N(4)/GCD ' reduce
2550 V=5:RETURN
2560 ' 100 - 20 1/3 = 99 3/3 - 20 1/3 = 79 2/3
2570 G(2)=G(0)-1:T(2)=N(1):N(2)=T(2):G(3)=G(1):T(3)=T(1):N(3)=N(2)
2580 G(4)=G(2)-G(3):T(4)=T(2)-T(3):N(4)=N(3):V=4:RETURN
2590 '
2600 TN=T(4):NN=N(4):GOSUB 40 ' search GCD
2610 IF GCD=1 THEN 2620 ELSE 2640
2620 V=3:RETURN
2630 ' 7 5/18 - 5 1/9 = 7 5/18 - 5 2/18 = 2 3/18 = 2 1/6
2640 GOSUB 40 ' search GCD
2650 IF GCD=1 THEN 2350
2660 T(5)=T(4)/GCD:N(5)=N(4)/GCD:G(5)=G(4):V=5:RETURN
2670 ' 6 3/7 - 4 2/7 = 2 1/7
2680 G(2)=G(0)-G(1):T(2)=T(0)-T(1):N(2)=N(1):TN=T(2):NN=N(2):GOSUB 40 ' search GCD
2690 IF GCD=1 THEN 2700 ELSE 2720
2700 V=1:RETURN
2710 ' 7 3/10 - 4 1/10 = 3 2/10 = 3 1/5
2720 G(3)=G(2):T(3)=T(2)/GCD:N(3)=N(2)/GCD ' reduce
2730 G(4)=0:T(4)=0:V=2:RETURN
2740 ' 10 1/2 - 2 1/2 = 8
2750 G(2)=G(0)-G(1):T(2)=0:N(2)=1:V=1:RETURN
2760 ' wait for key pressed
2770 PRINT:PRINT "Press any key to continue ..."
2780 LSET Q=MKI$(0):WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND:F=ASC(Q):RETURN
2790 ' module 1 + -
2800 IF G(1)=0 AND T(1)=0 AND N(1)=1 THEN SW=1
2810 D=2:GOSUB 100 ' calculate length and exact position
2820 GOSUB 110     ' print numerators + -
2830 FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 2850
2840  IF G(X)=0 THEN 2860
2850  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
2860  IF T(X)=0 OR N(X)=1 THEN 2890
2870  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
2880  L=LF(X):GOSUB 140    ' draw fraction lines
2890  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
2900  IF X=1 THEN PRINT " =";: IF COPY THEN PRINT #1, " =";
2910 NEXT:GOSUB 120     ' print denominators + -
2920 GOTO 470:' module 2 + -
2930 D=3:GOSUB 100:GOSUB 110:FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 2950
2940  IF G(X)=0 THEN 2960
2950  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
2960  IF T(X)=0 OR N(X)=1 THEN 2990
2970  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
2980  L=LF(X):GOSUB 140
2990  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
3000  IF X=1 OR X=2 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
3010 NEXT:GOSUB 120:GOTO 470:' module 3 +
3020 D=4:GOSUB 100:GOSUB 110:FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 3040
3030  IF G(X)=0 THEN 3050
3040  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
3050  IF T(X)=0 OR N(X)=1 THEN 3080
3060  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
3070  L=LF(X):GOSUB 140
3080  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
3090  IF X=1 OR X=2 OR X=3 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
3100 NEXT:GOSUB 120:GOTO 470:' module 4 + -
3110 D=4:GOSUB 100:GOSUB 110:FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 3130
3120  IF G(X)=0 THEN 3140
3130  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
3140  IF T(X)=0 OR N(X)=1 THEN 3170
3150  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
3160  L=LF(X):GOSUB 140
3170  IF X=0 OR X=2 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
3180  IF X=1 OR X=3 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
3190 NEXT:GOSUB 120:GOTO 470:' module 5 + -
3200 D=5:GOSUB 100:GOSUB 110:FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 3220
3210  IF G(X)=0 THEN 3230
3220  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
3230  IF T(X)=0 OR N(X)=1 THEN 3260
3240  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
3250  L=LF(X):GOSUB 140
3260  IF X=0 OR X=2 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
3270  IF X=1 OR X=3 OR X=4 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
3280 NEXT:GOSUB 120:GOTO 470:' module 6 -
3290 D=6:GOSUB 100:GOSUB 110:FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 3310
3300  IF G(X)=0 THEN 3320
3310  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
3320  IF T(X)=0 OR N(X)=1 THEN 3350
3330  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
3340  L=LF(X):GOSUB 140
3350  IF X=0 OR X=2 OR X=4 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
3360  IF X=1 OR X=3 OR X=5 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
3370 NEXT:GOSUB 120:GOTO 470:' module 7 -
3380 D=7:GOSUB 100:GOSUB 110:FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 3400
3390  IF G(X)=0 THEN 3410
3400  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
3410  IF T(X)=0 OR N(X)=1 THEN 3440
3420  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
3430  L=LF(X):GOSUB 140
3440  IF X=0 OR X=2 OR X=4 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
3450  IF X=1 OR X=3 OR X=5 OR X=6 THEN PRINT" =";:IF COPY THEN PRINT #1, " =";
3460 NEXT:GOSUB 120:GOTO 470:' module 8 +
3470 D=6:GOSUB 100:GOSUB 110:FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 3490
3480  IF G(X)=0 THEN 3500
3490  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
3500  IF T(X)=0 OR N(X)=1 THEN 3530
3510  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
3520  L=LF(X):GOSUB 140
3530  IF X=0 OR X=2 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
3540  IF X=1 OR X=3 OR X=4 OR X=5 THEN PRINT" =";:IF COPY THEN PRINT #1, " =";
3550 NEXT:GOSUB 120:GOTO 470:' calculate length of numerators
3560 FOR X=0 TO D:Z=T(X):GOSUB 130 ' count digits
3570  LT(X)=L:NEXT:' calculate length of denominators
3580 FOR X=0 TO D:Z=N(X):GOSUB 130 ' count digits
3590  LN(X)=L:NEXT:' calculate length of whole numbers and space of one fraction
3600 FOR X=0 TO D  ' numerator > denominator ?
3610  IF LT(X)>LN(X) THEN LF(X)=LT(X) ELSE LF(X)=LN(X)
3620 NEXT:FOR X=0 TO D:Z=G(X):GOSUB 130 ' count digits
3630  LG(X)=L:IF G(X)=0 THEN LB(X)=LF(X):GOTO 3650
3640  LB(X)=LG(X)+LF(X)+1:IF N(X)=1 THEN LB(X)=LB(X)-1
3650 NEXT:' calculate exact positions of the numerators
3660 B(0)=LB(0)-LT(0):B(1)=LB(0)+LB(1)-LT(1)+3:B(2)=LB(0)+LB(1)+LB(2)-LT(2)+6        ' module 1
3670 B(3)=LB(0)+LB(1)+LB(2)+LB(3)-LT(3)+9  ' module 2
3680 B(4)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)-LT(4)+12       ' module 3 + 4
3690 B(5)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)-LT(5)+15 ' module 5
3700 B(6)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)-LT(6)+18       ' module 6 + 8
3710 B(7)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)+LB(7)-LT(7)+21 ' module 7
3720 ' calculate exact positions of the denominators
3730 O(0)=LB(0)-LN(0):O(1)=LB(0)+LB(1)-LN(1)+3:O(2)=LB(0)+LB(1)+LB(2)-LN(2)+6        ' module 1
3740 O(3)=LB(0)+LB(1)+LB(2)+LB(3)-LN(3)+9  ' module 2
3750 O(4)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)-LN(4)+12       ' module 3 + 4
3760 O(5)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)-LN(5)+15 ' module 5
3770 O(6)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)-LN(6)+18       ' module 6 + 8
3780 O(7)=LB(0)+LB(1)+LB(2)+LB(3)+LB(4)+LB(5)+LB(6)+LB(7)-LN(7)+21 ' module 7
3790 ' 10 3/4 + - 0 = 10 3/4
3800 IF SW=1 THEN B(2)=B(2)+1:O(2)=O(2)+1:SW=0
3810 RETURN
3820 ' print numerators + -
3830 FOR X=0 TO D:IF C=1 AND V=4 AND T(X)>0 THEN 3850
3840  IF T(X)=0 OR N(X)=1 THEN 3860
3850  PRINT TAB(B(X)+1)T(X);:IF COPY THEN PRINT #1, TAB(B(X)+1)T(X);
3860 NEXT:PRINT:IF COPY THEN PRINT #1, "" 
3870 RETURN
3880 ' print denominators + -
3890 PRINT:IF COPY THEN PRINT #1, ""
3900 FOR X=0 TO D:IF C=1 AND V=4 AND T(X)>0 THEN 3920
3910  IF N(X)=1 THEN 3930
3920  PRINT TAB(O(X)+1)N(X);:IF COPY THEN PRINT #1, TAB(O(X)+1)N(X);
3930 NEXT:PRINT:PRINT:IF COPY THEN PRINT #1, :PRINT #1, ""
3940 RETURN
3950 ' count the digits of the number
3960 L=1
3970 E=INT(Z/10):IF E<>0 THEN L=L+1:Z=E:GOTO 3970 ELSE RETURN
3980 ' draw lines as big as the fraction is
3990 PRINT TAB(P+2)"";:PRINT STRING$(L,"Ä");
4000 IF COPY THEN PRINT #1, TAB(P+2)"";:PRINT #1, STRING$(L,"-");
4010 RETURN
4020 ' module 1 * /
4030 D=4:GOSUB 100 ' calculate length and exact position
4040 GOSUB 150     ' print numerators * /
4050 FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4070
4060  IF G(X)=0 THEN 4080
4070  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4080  IF T(X)=0 THEN 4110
4090  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4100  L=LF(X):GOSUB 140    ' draw fraction lines
4110  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4120  IF X=1 OR X=3 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4130  IF X=2 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
4140 NEXT:GOSUB 160     ' print denominators * /
4150 GOTO 470:' module 2 * /
4160 D=5:GOSUB 100:GOSUB 150:FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4180
4170  IF G(X)=0 THEN 4190
4180  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4190  IF T(X)=0 THEN 4220
4200  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4210  L=LF(X):GOSUB 140
4220  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4230  IF X=2 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
4240  IF X=1 OR X=3 OR X=4 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4250 NEXT:GOSUB 160:GOTO 470:' module 3 * /
4260 D=6:GOSUB 100:GOSUB 150:FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4280
4270  IF G(X)=0 THEN 4290
4280  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4290  IF T(X)=0 THEN 4320
4300  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4310  L=LF(X):GOSUB 140
4320  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4330  IF X=2 OR X=4 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
4340  IF X=1 OR X=3 OR X=5 THEN PRINT " =";:IF COPY THEN PRINT #1, " =";
4350 NEXT:GOSUB 160:GOTO 470:' module 4 * /
4360 D=7:GOSUB 100:GOSUB 150:FOR X=0 TO D:IF G(X)=0 AND T(X)=0 AND N(X)=1 THEN 4380
4370  IF G(X)=0 THEN 4390
4380  PRINT G(X);:IF COPY THEN PRINT #1, G(X);
4390  IF T(X)=0 THEN 4420
4400  IF LT(X)>LN(X) THEN P=B(X) ELSE P=O(X)
4410  L=LF(X):GOSUB 140
4420  IF X=0 THEN PRINT O$(C);:IF COPY THEN PRINT #1, O$(C);
4430  IF X=2 OR X=4 THEN PRINT O$(1);:IF COPY THEN PRINT #1, O$(1);
4440  IF X=1 OR X=3 OR X=5 OR X=6 THEN PRINT" =";:IF COPY THEN PRINT #1, " =";
4450 NEXT:GOSUB 160:GOTO 470:' print numerators * /
4460 FOR X=0 TO D:IF T(X)=0 THEN 4480
4470  PRINT TAB(B(X)+1)T(X);:IF COPY THEN PRINT #1, TAB(B(X)+1)T(X);
4480 NEXT:PRINT:IF COPY THEN PRINT #1, ""
4490 RETURN
4500 ' print denominators * /
4510 PRINT:IF COPY THEN PRINT #1, ""
4520 FOR X=0 TO D:IF T(X)=0 THEN 4540
4530  PRINT TAB(O(X)+1)N(X);:IF COPY THEN PRINT #1, TAB(O(X)+1)N(X);
4540 NEXT:PRINT:PRINT:IF COPY THEN PRINT #1, "":PRINT #1, ""
4550 RETURN
4560 ' solve fraction problem
4570 IF NN=TN THEN G(8)=1 :N(8)=1:RETURN
4580 IF TN=0  THEN G(8)=0 :N(8)=1:RETURN
4590 IF NN=1  THEN G(8)=TN:N(8)=1:RETURN
4600 IF TN/NN=INT(TN/NN) THEN G(8)=TN/NN:N(8)=1:RETURN
4610 GOSUB 40 ' search GCD
4620 TN=TN/GCD:NN=NN/GCD ' reduce
4630 G(8)=INT(TN/NN):T(8)=TN-G(8)*NN:N(8)=NN:RETURN
4640 ' help info
4650 PRINT"THIS PROGRAM SHOWS YOU THE COMPLETE SOLUTION OF FRACTIONS"
4660 PRINT"If you don't need a diskfile, type <N/n> or press <Enter>"
4670 PRINT:PRINT"1) W.N/D ? 8.2/5  or press <Enter> ":PRINT"+ - * /  ? +      or press <Enter> "
4680 PRINT"2) W.N/D ? 3.1/4  or press <Enter> ":PRINT
4690 PRINT"By pressing 3 times <Enter> you will automatically get":PRINT
4700 PRINT"                    2         1":PRINT"the solution of  8 ÄÄÄ  +  3 ÄÄÄ  ?"
4710 PRINT"                    5         4":PRINT:GOSUB 80:CLS ' wait key
4720 PRINT "   2         1":PRINT "8 ÄÄÄ  -  3 ÄÄÄ  = ?    press <Enter> - <Enter>"
4730 PRINT "   5         4":PRINT:PRINT"1) W.N/D ? <Enter>":PRINT"+ - * /  ? -"
4740 PRINT"2) W.N/D ? <Enter>":PRINT:PRINT "To see the product  press <Enter> * <Enter>":PRINT
4750 PRINT"1) W.N/D ? <Enter>":PRINT"+ - * /  ? *":PRINT"2) W.N/D ? <Enter>": PRINT
4760 PRINT "To see the quotient press <Enter> / <Enter>":PRINT:PRINT"1) W.N/D ? <Enter>"
4770 PRINT"+ - * /  ? /":PRINT"2) W.N/D ? <Enter>":PRINT:GOSUB 80:CLS ' wait key
4780 PRINT"W = Whole integer number":PRINT". = To separate number from the fraction"
4790 PRINT"N = Numerator":PRINT"/ = Fraction bar":PRINT"D = Denominator":PRINT:PRINT"    7"
4800 PRINT"12 ÄÄÄ  Enter this as follows: 12.7/8 <Enter> ":PRINT"    8                            ³"
4810 PRINT"                                 ³":PRINT"Notice the dot . >>ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ":PRINT
4820 PRINT"    3":PRINT"   ÄÄÄ  Enter: .3/4 <Enter> ":PRINT"    4":PRINT:PRINT
4830 PRINT"This program memorizes your fractions!"
4840 PRINT"For quick results just type <Enter> + - * / <Enter>":PRINT
4850 PRINT"Enter a 0 (zero) to return to the menu":GOSUB 80:CLS ' wait key
4860 PRINT "Enter Repeating Decimals like these examples:":PRINT
4870 PRINT ".(6) .(24) .(09) .(36) .(26) .(142857) .(456) .(3)":PRINT
4880 PRINT ".7(6)  .70(8)  .08(09)  .21(456)  .654(69)  .13(7)":PRINT
4890 PRINT "2.708(3)  7.12(3)  4.23(138)  12.45.(67)  7.05(04)":PRINT:GOSUB 80:CLS:RETURN
4900 ' exit
4910 IF COPY THEN CLOSE
4920 KEY 5,"fraction.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS:END:' repeating decimal to fraction
4930 PRINT:COLOR 7,0:B=2
4940 LINE INPUT "Repeating decimal 0 menu ? ";B1$:IF B1$="0" THEN B1$=M7$:RP=0:CLS:GOTO 380
4950 IF B1$="" THEN B1$=M7$
4960 B$=B1$:GOSUB 190:IF NG=0 THEN 4940
4970 RT=LEN(T$):RN=LEN(N$):M7$=B$:GOSUB 200 ' clear line
4980 IF G$="" AND T$=""  THEN 5010
4990 IF G$="" AND T$<>"" THEN 5030
5000 GOTO 5040:' case 1  .(6) .(23) .(90) .(456) .(142857)
5010 G1$=N$:T1$="":N1$="1":G2$="":FOR C=1 TO RL:G2$=G2$+"9":NEXT:T2$="":N2$="1":C=2:GOTO 5070
5020 ' case 2  .4(5) .70(8) .08(09) .21(456)
5030 G1$="":GOTO 5050:' case 3  2.708(3) 7.12(3) 4.23(13) 1.5(20)
5040 G1$=G$
5050 Z=1:FOR C=1 TO RT:Z=Z*10:NEXT:N1$=STR$(Z):T1$=T$:G2$="":T2$=N$:DN$=""
5060 FOR C=1 TO RN:DN$=DN$+"9":NEXT:FOR C=1 TO RT:DN$=DN$+"0":NEXT:N2$=DN$:C=3
5070 IF C=3 THEN COLOR 11,0
5080 IF C=2 THEN COLOR 15,0
5090 PRINT B$;" = ";:IF COPY THEN PRINT #1,B$; " = ";
5100 M1$=G1$:M2$=T1$:M3$=N1$:M4$=G2$:M5$=T2$:M6$=N2$:GOTO 750:' scan repeating decimal input
5110 L=LEN(B$):CD=0:CL=0:CR=0:CN=0:IF LEFT$(B$,1)="(" OR LEFT$(B$,1)=")" THEN 5250 ' (1234   )654
5120 IF RIGHT$(B$,1)="." THEN 5250 ' 123.
5130 FOR I=1 TO L:Z=ASC(MID$(B$,I,1)):IF Z=46 THEN CD=CD+1 ' check .
5140  IF Z=40 THEN CL=CL+1 ' check (
5150  IF Z=41 THEN CR=CR+1 ' check )
5160  IF Z>58 THEN CN=CN+1 ' check : to ~
5170 NEXT:IF CD=0 OR CD>1 OR CL>1 OR CR>1 OR CN>0 THEN 5250
5180 FOR I=1 TO L:IF MID$(B$,I,2)="()" THEN 5250
5190 NEXT:FOR I=1 TO L:IF MID$(B$,I,1)="." THEN G$=MID$(B$,1,I-1):W=I+1
5200  IF MID$(B$,I,1)="(" THEN T$=MID$(B$,W,I-W):N$=MID$(B$,I+1,L)
5210 NEXT:IF RIGHT$ (N$,1)<>")" THEN 5250
5220  IF RIGHT$ (N$,1)= ")" THEN RL=LEN(N$)-1:N$=LEFT$(N$,RL)
5230 NG=1:RETURN
5240 ' clear line
5250 NG=0:PRINT CHR$(30);:PRINT STRING$(79,32):PRINT CHR$(30);:RETURN
5260 ' scan fraction input
5270 L=LEN(B$):CD=0:CL=0:IF LEFT$(B$,1)="/" OR RIGHT$(B$,1)="/"  THEN 5250 ' /1234 6541/
5280  IF RIGHT$(B$,1)="0." THEN 5250 ' 0.
5290  IF RIGHT$(B$,1)="." THEN 5250 ' 123.  .2356/4789
5300 FOR I=1 TO L:Z=ASC(MID$(B$,I,1)):IF Z<46 OR Z>57 THEN 5250 ' <space to -> or <: to þ>
5310  IF MID$(B$,I,1)="/" THEN 5450 ' /.
5320  IF MID$(B$,I,1)="." THEN 5470 ' ./
5330 NEXT
5340 FOR I=1 TO L:Z=ASC(MID$(B$,I,1)):IF Z=46 THEN CD=CD+1:IF CD=0 OR CD>1 THEN 5250 '...
5350  IF Z=47 THEN CL=CL+1:IF CL=0 OR CL>1 THEN 5250 '///
5360 NEXT:IF CL=1 AND CD=0 THEN 5250 ' check 123/789
5370  IF CD=1 AND CL=0 THEN 5250 ' check .123
5380 FOR I=1 TO L:IF MID$(B$,I,1)="." THEN G$=MID$(B$,1,I-1):W=I+1
5390  IF MID$(B$,I,1)="/" THEN T$=MID$(B$,W,I-W):N$=MID$(B$,I+1,L)
5400 NEXT:IF T$="" THEN G$=B$:N$="1"
5410 IF T$="0" THEN 5250 ' 1.0/7  .0/7
5420 IF N$="0" THEN 5250 ' .23/0
5430 NG=1:RETURN
5440 ' check /1. /12. /123.45   23/1234.567
5450 EC=I+1:FOR I=EC TO L:IF MID$(B$,I,1)="." THEN 5250
5460 NEXT:GOTO 5340:' check ./   123./56
5470 EC=I+1:IF MID$(B$,I,1)="/" THEN 5250
5480 GOTO 5340:' basic fractions calculations!
5490 ' 7 1/3  + 1 1/2 = 22/3  +  3/2 =  44/6  +   9/6  =  53/6  = 8  5/6
5500 ' 3 5/12 - 1 7/8 = 41/12 - 15/8 = 328/96 - 180/96 = 148/96 = 1 13/24
5510 ' 5 1/3  x 8 2/5 = 16/3  x 42/5 = 672/15  = 44 4/5
5520 ' 8/15 ö 9 4/5 = 98/15 x 5/49 = 490/735 = 2/3
