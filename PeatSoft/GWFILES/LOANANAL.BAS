10 KEY OFF:CLS
20 SCREEN 0
30 WIDTH 40
40 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
50 PRINT"∞⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø∞"
60 PRINT"∞≥                                   ≥∞"
70 PRINT"∞≥            6016-A.BAS             ≥∞"
80 PRINT"∞≥      LOAN SAVINGS SOLUTIONS       ≥∞"
90 PRINT"∞≥                                   ≥∞"
100 PRINT"∞≥                                   ≥∞"
110 PRINT"∞≥ BROUGHT TO YOU BY THE MEMBERS OF  ≥∞"
120 PRINT"∞≥      ‹‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹‹      ≥∞"
130 PRINT"∞≥        €   €   € €     €   €      ≥∞"
140 PRINT"∞≥        €   €‹‹‹€ €     €   €      ≥∞"
150 PRINT"∞≥        €   €     €     €   €      ≥∞"
160 PRINT"∞≥      ‹‹€‹‹ €     €‹‹‹‹ €‹‹‹€      ≥∞"
170 PRINT"∞≥                                   ≥∞"
180 PRINT"∞≥      International PC Owners      ≥∞"
190 PRINT"∞≥                                   ≥∞"
200 PRINT"∞≥P.O. Box 10426, Pittsburgh PA 15234≥∞"
210 PRINT"∞≥                                   ≥∞"
220 PRINT"∞¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ∞"
230 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
240 PRINT
250 PRINT "       PRESS ANY KEY TO CONTINUE
260 A$=INKEY$: IF A$="" THEN 260
270 WIDTH 80
280 CLS
1000 CLS:KEY OFF
1010 V=1:W=0:T=7:X=0:Z=0:L=0:R=0:U=0
1020 PRINT TAB(12);:COLOR 0,7:PRINT"            Have you made a copy?            ";
1030 COLOR 7,0
1040 FOR L=1 TO 7:PRINT TAB(12);:COLOR 0,7:PRINT "  ";:COLOR 7:PRINT TAB(14) "=";
1050 FOR R=1 TO 8
1060 IF W=0 THEN W=1 ELSE W=0
1070 IF L<5 THEN 1090
1080 IF W=1 THEN 1110 ELSE 1100
1090 IF W=0 THEN 1110
1100 FOR U=1 TO T:PRINT "%";:NEXT U:GOTO 1120
1110 FOR U=1 TO V:PRINT "$";:NEXT U
1120 PRINT "=";:NEXT R
1130 V=V+1:T=T-1:PRINT TAB(55);:COLOR 0,7:PRINT "  ";:COLOR 7:NEXT L:PRINT
1140 PRINT TAB(12);:COLOR 0,7:PRINT"         -- USE - ONLY - `BASICA' --         ";
1150 COLOR 7:PRINT:PRINT
1160 PRINT "File: `LOANSVGS.SOL': That is, LOAN SaVinGS SOLutions."
1170 PRINT "**** COPYRIGHT 1982 * Joe Marvin Jeffers * ALL RIGHTS RESERVED ****"
1180 PRINT "           New users should read the INSTRUCTIONS first.":PRINT
1190 P=0:I=0:Y=0:M=0:E=0:M1=0:F=0:E1=0:P1=0:Y1=0:Q=0:Q1=0:A=0:EYE2=0:P2=0:K=0
1200 B=0:C=0:Y2=0:C1=0:S=0:J=0:I1=0:J1=0:M2=0:M3=0:C2=0:C3=0:C4=0:Y3=0:Y4=0:N=0
1210 H=0
1220 PRINT"|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|"
1230 PRINT"| NOW DO THIS:  Select one of these four choices:                 |"
1240 PRINT"|                                                                 |"
1250 PRINT"| To read the INSTRUCTIONS ------------- Press `1', then `Enter'. |"
1260 PRINT"|             >>> to DISPLAY results --- Press `4', then `Enter'. |"
1270 PRINT"|             >>> to PRINT results ----- Press `7', then `Enter'. |"
1280 PRINT"| To solve MONTHLY PAYMENTS (only) ----- Press `9', then `Enter'. |"
1290 PRINT"|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|"
1300 PRINT
1310 INPUT "MAKE YOUR SELECTION [1, 4, 7, 9, (or 0, to stop)]: ";X
1320 IF X=0 THEN STOP:GOTO 1300
1330 IF X=9 THEN 8940
1340 PRINT:IF X<3 THEN X=1:GOTO 1370
1350 IF X>5 THEN X=7:GOTO 2330
1360 X=4:GOTO 4470
1370 CLS                                 'USER SELECTION IS CODIFIED.
1380 COLOR 0,7
1390 PRINT "COST AND TIME COMPARISONS FOR LOAN PAYMENTS IN ADVANCE";
1400 COLOR 7:PRINT:PRINT
1410 PRINT "The two major routines of this program prepare schedules of loan"
1420 PRINT "payments both with and without extra payments to principal.  They"
1430 PRINT "show the surprisingly large saving which results from modest extra"
1440 PRINT "monthly payments.  However, these figures must be compared with the"
1450 PRINT "interest which may be earned in other available investments.  Use"
1460 PRINT"of this program will give you a good basis for investment decisions."
1470 PRINT
1480 PRINT "The DISPLAY ROUTINE (#4) is designed for use without a printer, or"
1490 PRINT "when you want screen-displayed results.  If a printer is connected,"
1500 PRINT "you can put on paper any displayed results with the `PRINT SCREEN'"
1510 PRINT "(PrtSc) key.  The PRINT ROUTINE (#7) is used only to print results"
1520 PRINT "on paper.  Both routines are used alike and offer the same options."
1530 PRINT "Please try them all to see which ones suit you best."
1540 PRINT
1550 PRINT "The options are numbered (2, 5, & 8) and are described on a later"
1560 PRINT "display.  After choosing an option (by keying its number and the"
1570 PRINT "Enter key) you will be asked to `input' the loan values."
1580 PRINT
1590 PRINT "* * * * To continue reading, press the `F5' key (FAR LEFT) * * * *"
1600 STOP
1610 CLS
1620 PRINT "The PRINCIPAL, TERM of the loan in YEARS, and the INTEREST rate per"
1630 PRINT "YEAR, must be entered.  The MONTHLY PAYMENT and the EXTRA paid per"
1640 PRINT "month are both OPTIONAL.  If you enter `0' for the EXTRA per month,"
1650 PRINT "you will get a complete schedule of regular payments, but the right"
1660 PRINT "half of the page (or display) will be blank.  Try it both ways."
1670 PRINT
1680 PRINT "If you enter `0' as the MONTHLY PAYMENT, the calculated payment"
1690 PRINT "will be used.  It is always calculated anyway.  If you enter your"
1700 PRINT "own payment figure, please be sure it is correct.  In fact, please"
1710 PRINT "be careful of ALL input figures.  A few cents error in the monthly"
1720 PRINT "payment can change the total cost of a mortgage loan by $100."
1730 PRINT "Try your own payment figures. If they are right, they will be okay."
1740 PRINT "Small errors also will be accepted, but an error which makes the"
1750 PRINT "result unusable will put an explanation & suggestion on the screen."
1760 PRINT
1770 PRINT "You will find it easier to use `0' as input for MONTHLY PAYMENTS."
1780 PRINT "If you get unexpected results, you may have made a simple keying"
1790 PRINT "error in your PRINCIPAL, INTEREST, or TERM entries.  Any such error"
1800 PRINT "also will cause the calculated MONTHLY PAYMENT to be wrong."
1810 PRINT
1820 PRINT "  * * * * * * To continue reading, press the `F5' key * * * * * *"
1830 STOP
1840 CLS
1850 PRINT"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
1860 PRINT"  1 | INSTRUCTIONS (FOR NEW USERS)||  0 | STOP (DISCONTINUE)"
1870 PRINT"****|*****************************||****|**************************"
1880 COLOR 15:PRINT "  4 ";:COLOR 7:PRINT "| ";:COLOR 15:PRINT "DISPLAY ";
1890 PRINT "ROUTINE";:COLOR 7:PRINT "             || ";:COLOR 15:PRINT " 7";
1900 COLOR 7:PRINT " | ";:COLOR 15:PRINT "PRINT ROUTINE";:COLOR 7:PRINT
1910 PRINT"====|=============================||====|=========================="
1920 PRINT"  2 | Displays paymt/mo and 1 mo  ||  2 | Prints paymt/mo and 1 mo"
1930 PRINT"O   | paymt each 5 yrs. COMPLETE. ||O   | paymt each yr.  COMPLETE."
1940 PRINT"P---|-----------------------------||P---|--------------------------"
1950 PRINT"T 5 | Solves & displays paymt/mo, ||T 5 | Solves & prints paymt/mo,"
1960 PRINT"I   | final payment months, and   ||I   | final payment months, and"
1970 PRINT"O   | summary if wanted.  BRIEF.  ||O   | summary if wanted. BRIEF."
1980 PRINT"N---|-----------------------------||N---|--------------------------"
1990 PRINT"  8 | Solves & displays paymt/mo. ||  8 | Solves & prints paymt/mo."
2000 PRINT"    | Displays ALL payments in    ||    | Prints ALL payments in"
2010 PRINT"    | groups.  DETAILED LIST.     ||    | groups.  DETAILED LIST."
2020 PRINT"----|=============================||====|=========================="
2030 PRINT"  9 | Quick & easy way to find monthly payments only.  Subroutine. "
2040 PRINT"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
2050 PRINT"(To stop, the `0'is unnecessary; merely press the `Enter' key.  If"
2060 PRINT"you change your mind, `F5' continues, while `F2' starts a new RUN.)"
2070 PRINT "     * * * * * * To continue, press the `F5'key * * * * * *":PRINT
2080 STOP
2090 CLS
2100 PRINT "     Before entering loan figures, you will be asked if you plan"
2110 PRINT "     to sell the mortgaged property, and if so, in how many years."
2120 PRINT "     Also, after entering the loan figures, and if you specify"
2130 PRINT "     extra monthly payments to principal, you will be asked if you"
2140 PRINT "     plan to stop the extra payments after a number of years.  If"
2150 PRINT "     you choose either or both of these options, the program will"
2160 PRINT "     adjust and provide results to fit your choices."
2170 PRINT " SAMPLE ENTRIES to get you started (in order of input):"
2180 PRINT " 1st trial run: 4  2  Y  12  80000  11  30    0    100  Y  3  44"
2190 PRINT " 2nd trial run: 7  2  Y  15  80000  11  30    0    100  Y 12  50"
2200 PRINT " 3rd trial run: 4  2  N      80000  11  30  761.9  100  N     50"
2210 PRINT "     Jot down these figures (or press `Print Screen').":PRINT
2220 PRINT "Loans often are arranged to pay a `30 yr' term in 29 yrs & 11 mos."
2230 PRINT"MONTHS AS DECIMAL FRACTIONS OF A YEAR may aid odd-length term entry:"
2240 PRINT "1      2      3      4      5      6      7      8      9     10     11"
2250 PRINT "0.084  0.167  0.25   0.334  0.417  0.5    0.584  0.667  0.75  0.834  0.917"
2260 PRINT "     A FINAL NOTE:  DETAIL OPTION (8) is useful in showing total"
2270 PRINT "     interest you pay yearly, for INCOME TAX purposes."
2280 PRINT "            >> This Page Concludes the INSTRUCTIONS <<"
2290 PRINT "       * * * * * * To continue, press the F5 key * * * * * *"
2300 STOP
2310 CLS
2320 GOTO 1190
2330 PRINT:'filename: LOANSVGS.SOL *** COPYRIGHT 1982 Joe Marvin Jeffers ***
2340 CLS
2350 PRINT "* * * * * * * * * * * * INSTRUCTION * * * * * * * * * * * *"
2360 PRINT"You chose the program to PRINT results.  Press the number of"
2370 PRINT"your choice, then press the Enter key.  HERE ARE YOUR OPTIONS:"
2380 PRINT"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
2390 PRINT"2.  >>> COMPLETE SUMMARY.  Payment figures for the first month of"
2400 PRINT"    each year.  First the monthly payment is calculated, then the"
2410 PRINT"    chart printed, and finally a recapitulation of results shown."
2420 PRINT"-------------------------------------------------------------------"
2430 PRINT"5.  >>> BRIED SUMMARY.  Payment per mo. is printed.  Input needed:"
2440 PRINT"    Principal, Interest, & Term (years).  You may neter Extra/mo. &"
2450 PRINT"    wait up to 40 seconds (depending of the term) for a summary."
2460 PRINT"-------------------------------------------------------------------"
2470 PRINT"8.  >>> DETAILED LIST.  Every payment is printed on paper in groups"
2480 PRINT"    of one to all.  Total interest is shown for each group."
2490 PRINT"    When prompted, choose the number of months to print each time."
2500 PRINT"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
2510 PRINT:M=0:M1=0:E=0:Y5=0:Y6=41:Y10=0:Y11=0:X7=0:X8=0:X5=0:D=0:D2=0:D3=0
2520 D1=0:D7=0:B3=0:A3=0:A4=0:B8=0:B9=0
2530 INPUT "MAKE YOUR SELECTION NOW {2, 5, 8, (or 0, to stop)}:         ";Z
2540 IF Z=0 THEN STOP:GOTO 2530
2550 IF Z<4 THEN Z=2:GOTO 2570
2560 IF Z<7 THEN Z=5 ELSE Z=8
2570 PRINT
2580 PRINT "If you plan to SELL in a few years, you can STOP mortgage payments"
2590 INPUT "at that time and get a summary.  Will you sell (Y or N)     "; Y8$
2600 IF Y8$=CHR$(110) THEN 2630
2610 IF Y8$=CHR$(78) THEN 2630
2620 INPUT "Enter number of years you plan to keep the property.        "; Y6
2630 PRINT
2640 PRINT "PRINCIPAL AMOUNT of the loan.  Key the figures, then `Enter' key."
2650 INPUT "(Example:  For $45000.00, enter 45000)                          ";P
2660 PRINT
2670 PRINT "INTEREST RATE/YEAR.  Enter the percentage & press `Enter' key."
2680 INPUT "(Example:  For 13 3/4%, enter 13.75; for 9%, enter 9)           ";I
2690 PRINT
2700 PRINT "TERM in YEARS of the loan.  Key the figures and `Enter'."
2710 INPUT "(Example:  For 30 years, enter 30)                              ";Y
2720 K=I/1200:N=Y*12:P1=P:P2=P
2730 M=P*K*(1+K)^N/((1+K)^N-1):PRINT:LPRINT
2740 LPRINT "COST & TIME COMPARISONS FOR LOAN PAYMENTS MADE IN ADVANCE":LPRINT
2750 LPRINT "CALCULATED MONTHLY PAYMENT IS: "M
2760 PRINT "MONTHLY PAYMENT.  Your figure or `0' (preferred), & `Enter'."
2770 PRINT "{PAYMENT SHOULD BE: $"M"(Enter "M" or 0}";:PRINT  TAB(65);:INPUT M1
2780 PRINT:LPRINT
2790 PRINT "EXTRA PER MONTH you will pay.  Enter amount or `0', & `Enter'."
2800 INPUT "(Example:  For $110.00 per month, enter 110)                    ";E
2810 PRINT: IF E=0 THEN 2900
2820 INPUT "Will you STOP EXTRA PAYMENTS during this loan (Y or N)       "; Y7$
2830 IF Y7$=CHR$(78) THEN 2880
2840 IF Y7$=CHR$(110) THEN 2880
2850 IF Y7$=CHR$(89) THEN 2870
2860 IF Y7$<>CHR$(121) THEN 2880
2870 INPUT "Enter number of years EXTRA PAYMENTS will be paid.           "; Y5
2880 PRINT "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
2890 IF M1>0 AND E>0 THEN 2950
2900 IF M1=0 AND E=0 THEN 2920
2910 IF E=0 THEN 2940 ELSE 2930
2920 LPRINT"TERMS: LOAN AMT    INT/YR    TERM (YRS)":GOTO 2970
2930 LPRINT"TERMS: LOAN AMT    INT/YR    TERM (YRS)    EXTRA/MO":GOTO 2980
2940 LPRINT"TERMS: LOAN AMT    INT/YR    TERM (YRS)    PAYMT/MO":GOTO 2990
2950 LPRINT"TERMS: LOAN AMT    INT/YR    TERM (YRS)    PAYMT/MO      EXTRA.MO"
2960 LPRINT "      $"P;:LPRINT TAB(19) I;"%",Y,"$";M1,"$";E:GOTO 3000
2970 LPRINT "      $"P;:LPRINT TAB(19) I;"%",Y:GOTO 3020
2980 LPRINT "      $"P;:LPRINT TAB(19) I;"%",Y,"$";E:GOTO 3000
2990 LPRINT "      $"P;:LPRINT TAB(19) I;"%",Y,"$";M1:GOTO 3020
3000 LPRINT:LPRINT "SCHEDULE FOR REGULAR PAYMENTS";
3010 LPRINT SPC(7) "SCHEDULE WITH EXTRA PAYMENTS":LPRINT:GOTO 3070
3020 LPRINT:LPRINT "SCHEDULE FOR REGULAR PAYMENTS":LPRINT
3030 IF Z<>5 THEN 3070
3040 PRINT:PRINT "PAYMENT ($";M;") HAS BEEN PRINTED.":PRINT
3050 PRINT "IF YOU WANT A SUMMARY, PRESS `F5'; IF NOT, PRESS `F2'."
3060 STOP
3070 IF M1=0 THEN M1=M
3080 IF M1=M THEN 3150
3090 IF M1>0 THEN M2=M1-M
3100 M3=ABS(M2)
3110 IF M3<.6 THEN 3140
3120 IF M3>M2 THEN 6780
3130 IF ME=<M2 THEN 7250
3140 M=M1
3150 LPRINT TAB(9) "REMAIN.";:LPRINT TAB(18) "AMOUNT";:LPRINT TAB(28) "TOTAL";
3160 IF E=0 OR F>0 THEN LPRINT:GOTO 3200
3170 LPRINT TAB(37) "REMAIN.";
3180 IF E=0 OR F>0 THEN LPRINT:GOTO 3200
3190 LPRINT TAB(47) "AMOUNT";:LPRINT TAB(57) "TOTAL";:LPRINT TAB(67) "EXTRA"
3200 LPRINT "YR";:LPRINT TAB(4) "MO";
3210 LPRINT TAB(9) "BAL. ";:LPRINT TAB(18) "TO INT";:LPRINT TAB(28) "TO INT";
3220 IF E=0 OR F>0 THEN LPRINT:GOTO 3260
3230 LPRINT TAB(37) "BAL. ";
3240 IF E=0 OR F>0 THEN LPRINT:GOTO 3260
3250 LPRINT TAB(47) "TO INT";:LPRINT TAB(57)"TO INT";:LPRINT TAB(67) "TO PRIN."
3260 LPRINT
3270 IF H=1 THEN 3440
3280 IF Z<>5 THEN 3310
3290 PRINT:PRINT "Please wait up to 40 seconds for the summary to be prepared."
3300 PRINT "A message will be displayed when the job is finished."
3310 IF Z<>8 THEN 3510
3320 PRINT
3330 PRINT "You may change to a faster SUMMARY at ANY time DURING processing."
3340 PRINT "Press `F9'.  If screen is asking for INPUT,also press `Enter'."
3350 PRINT "Later you may return to DETAILED listing by pressing `F9' again."
3360 PRINT
3370 PRINT ">>>> Key the NUMBER OF MONTHS you want to print, then `Enter':";
3380 KEY (9) ON
3390 INPUT "   ";J
3400 ON KEY (9) GOSUB 7560
3410 KEY (9) OFF
3420 IF J=0 THEN STOP:GOTO 3370
3430 IF H=1 THEN 3150
3440 H=0
3450 IF J>480 THEN J=480
3460 J=480-J
3470 J1=0
3480 O=0:O1=0
3490 J=J+1
3500 J1=J1+1
3510 KEY(9) ON
3520 ON KEY(9) GOSUB 7560
3530 KEY(9) STOP
3540 IF (Y1*12)+C=>Y6*12 THEN 7740
3550 I1=P1*K
3560 O=O+I1
3570 Q=P1:P1=P1-(M-I1):Q1=P1
3580 IF Q1=>Q THEN 6940
3590 A=A+I1
3600 IF M=>P1+I1 THEN 4210
3610 IF E=0 OR F>0 THEN 3770
3620 EYE2=P2*K
3630 O1=O1+EYE2
3640 IF Y1=0 THEN 3690
3650 IF Y5=0 THEN 3690
3660 IF (Y1*12)+C<Y5*12 THEN 3690
3670 P2=P2-(M-EYE2)
3680 GOTO 3700
3690 P2=P2-(M-EYE2)-E
3700 B=B+EYE2
3710 IF (Y1*12)+C=>Y6*12 THEN 7740
3720 IF Y5=0 THEN 3740
3730 IF (Y1*12)+C=>Y5*12 THEN 3770
3740 D=D+1:D1=D MOD 12
3750 IF D1=0 THEN X5=X5+1
3760 E1=E1+E
3770 C=(C+1) MOD 12
3780 IF C=0 THEN Y1=Y1+1:Y4=Y4+1
3790 IF F=>1 THEN 3810
3800 IF M>=P2+EYE2+E THEN 4180
3810 IF Y11=1 THEN 3830
3820 PRINT:PRINT "Yr. Months (Processing; pause at any time with key `F9'.)"
3830 IF Y11=0 THEN 3860
3840 IF Y1=Y10 THEN 3870
3850 Y10=Y1
3860 PRINT USING "##";Y10;:PRINT "-";
3870 IF C=3 OR C=6 THEN PRINT USING "##";C;
3880 IF C=9 THEN PRINT C,
3890 Y11=1:IF Y1>Y THEN 7100
3900 IF Z=5 AND S=2 THEN S=3
3910 IF Y1=0 AND C=1 THEN 3950
3920 IF S=1 OR F=2 THEN 3950
3930 IF Z=8 THEN 3950
3940 IF Z=2 AND C=0 THEN 3950 ELSE 3510
3950 LPRINT USING "## ";Y1;:LPRINT USING "## ";C;
3960 LPRINT USING "######.## ";P1;:LPRINT USING "####.## ";I1;
3970 IF F>0 THEN S=S+1
3980 IF S=2 THEN Y2=Y1:C1=C
3990 IF S=>3 OR E=0 THEN 4020
4000 LPRINT USING "#######.## ";A;
4010 GOTO 4060
4020 LPRINT USING "#######.## ";A
4030 IF (Y1*12)+C=>Y6*12 AND E=0 THEN 7970
4040 IF (Y1*12)+C=>Y6*12 THEN 7760
4050 IF S=>1 OR E=0 THEN 4080
4060 LPRINT USING "######.## ";P2;:LPRINT USING "####.## ";EYE2;
4070 LPRINT USING "#######.## ";B;:LPRINT USING "######.##";E1
4080 IF F=2 THEN 4240
4090 IF Z<>8 THEN 3510
4100 IF J1=12 THEN H=1
4110 IF J1=12 THEN 4130
4120 IF J<480 THEN 3490
4130 LPRINT:LPRINT "REG. INTEREST PAID THESE"J1;"MONTHS:"O;
4140 IF O1=0 THEN LPRINT:GOTO 4160
4150 LPRINT "-- INT., EXTRA SCHED:"O1
4160 LPRINT:IF J=480 THEN 3360
4170 GOTO 3470
4180 IF P2<0 THEN P2=0
4190 F=1:S=1
4200 GOTO 3810
4210 IF P1<0 THEN P1=0
4220 F=2
4230 GOTO 3770
4240 LPRINT:IF Y1<Y-1 THEN 7420
4250 LPRINT "TOTAL COST OF REGULARLY PAID LOAN: ";
4260 LPRINT USING "$$##########.##";A+P
4270 IF E=0 THEN PRINT:PRINT "RUN is finished."
4280 IF E=0 THEN PRINT"               *** Press `F5' to RUN another loan. ***"
4290 IF E=0 THEN STOP:CLS:GOTO 1190
4300 LPRINT "TOTAL COST OF LOAN WITH EXTRA PAYMENTS: ";
4310 LPRINT USING "#######.##";P+B
4320 LPRINT TAB(20) "DIFFERENCE (SAVING): ";
4330 LPRINT USING "#######.##";(A+P)-(P+B);
4340 GOTO 6500
4350 PRINT:PRINT "** WAIT FOR SEVERAL MORE LINES TO PRINT **":PRINT:LPRINT
4360 LPRINT
4370 LPRINT "THE AMOUNT (FUTURE VALUE) YOU MAY EXPECT BY INVESTING THE EXTRA"
4380 LPRINT "PAYMENTS, $";E;"/mo, FOR THE SAME PERIOD,";D2;"yrs &";D3;"mos, IN"
4390 LPRINT"ANOTHER INVESTMENT AT";I;"% COMPOUNDED MONTHLY WOULD BE:    ";
4400 LPRINT USING "$$######.##";Y3
4410 LPRINT:GOTO 8100
4420 PRINT "RUN is finished.              *** Press `F5' for another RUN. ***"
4430 STOP
4440 CLS
4450 GOTO 1190
4460 'filename: LOANSVGS.SOL *** COPYRIGHT 1982 Joe Marvin Jeffers ***"
4470 CLS:X=4
4480 PRINT "* * * * * * * * * * * * INSTRUCTION * * * * * * * * * * * *"
4490 PRINT"You chose the program to DISPLAY results.  Press the number of"
4500 PRINT"your choice, then press the Enter key.  HERE ARE YOUR OPTIONS:"
4510 PRINT"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
4520 PRINT"2.  >>> COMPLETE SUMMARY.  Payment figures for the first month of"
4530 PRINT"    each 5th year.  The monthly payment is calculated, then the"
4540 PRINT"    chart displayed, and finally a recapitulation of results shown."
4550 PRINT"-------------------------------------------------------------------"
4560 PRINT"5.  >>> BRIEF SUMMARY.  Payment per mo. displayed.  Input needed:"
4570 PRINT"    Principal, Interest, & Term (years).  You may enter Extra/mo &"
4580 PRINT"    wait up to 40 seconds (depending on the term) for a summary."
4590 PRINT"-------------------------------------------------------------------"
4600 PRINT"8.  >>> DETAILED LIST.  EVERY PAYMENT is displayed in groups of 1"
4610 PRINT"    to all.  Total INTEREST is shown for each group of months."
4620 PRINT"    When prompted, choose the no. of months to display and ENTER."
4630 PRINT"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
4640 PRINT:M=0:M1=0:E=0:Y5=0:Y6=41:Y10=0:X7=0:X8=0:X5=0:D=0:D2=0:D3=0:B3=0
4650 Y11=0:D1=0:D7=0:A3=0:A4=0:B8=0:B9=0
4660 INPUT "MAKE YOUR SELECTION NOW {2, 5, 8, (OR 0, TO STOP)}        ";Z
4670 IF Z=0 THEN STOP:GOTO 4660
4680 PRINT
4690 PRINT "If you plan to SELL in a few years, you can STOP mortgage payments"
4700 INPUT "at that time and get a summary.  Will you sell (Y or N)   "; Y8$
4710 IF Y8$=CHR$(78) THEN 4740
4720 IF Y8$=CHR$(110) THEN 4740
4730 INPUT "Enter number of years you plan to keep the property.      "; Y6
4740 IF Z<4 THEN Z=2:GOTO 4760
4750 IF Z<7 THEN Z=5 ELSE Z=8
4760 PRINT
4770 PRINT "PRINCIPAL AMOUNT of the loan. Key the figures, then `Enter' key."
4780 INPUT "(Example:  For $45000.00, enter 45000)                          ";P
4790 PRINT
4800 PRINT "INTEREST RATE/YEAR.  Enter the percentage & press `Enter' key."
4810 INPUT "(Example:  For 13 3/4%, enter 13.75; for 9%, enter 9)           ";I
4820 PRINT
4830 PRINT "TERM in YEARS of the loan. Key in the figures and `Enter'."
4840 INPUT"(Example:  For 30 years, enter 30)                              ";Y
4850 K=I/1200:N=Y*12:P1=P:P2=P
4860 M=P*K*(1+K)^N/((1+K)^N-1):PRINT
4870 PRINT "MONTHLY PAYMENT.  Your figure or `0' (preferred), and `Enter'."
4880 PRINT "{PAYMENT SHOULD BE: $"M"(Enter "M" or 0)}";:PRINT TAB(65);:INPUT M1
4890 PRINT
4900 PRINT "EXTRA PER MONTH you will pay.  Enter amount or `0', and `Enter'."
4910 INPUT"(Example:  fOR $110.00 per month, enter 110)                    ";E
4920 CLS
4930 PRINT"****   ****   ****   ****   ****   ****   ****   ****   ****   ****   ****"
4940 PRINT
4950 IF E=0 THEN 5030
4960 INPUT "Will you STOP EXTRA PAYMENTS during this loan (Y or N)    "; Y7$
4970 IF Y7$=CHR$(78) THEN 5020
4980 IF Y7$=CHR$(110) THEN 5020
4990 IF Y7$=CHR$(89) THEN 5010
5000 IF Y7$<>CHR$(121) THEN 5020
5010 INPUT "Enter number of years EXTRA PAYMENTS will be paid.        "; Y5
5020 PRINT
5030 COLOR 0,7
5040 PRINT "COST & TIME COMPARISONS FOR LOAN PAYMENTS MADE IN ADVANCE";
5050 COLOR 23:PRINT "         WORKING";:COLOR 7,0:PRINT
5060 PRINT "Calculated Monthly Payment is: $";:COLOR 9:PRINT M;
5070 COLOR 7:PRINT SPC(96) "(Please wait for: `RUN";
5080 PRINT "                                                          is finished' message.)";
5090 IF M1>0 AND E>0 THEN 5150
5100 IF M1=0 AND E=0 THEN 5120
5110 IF E=0 THEN 5140 ELSE 5130
5120 PRINT "TERMS: LOAN AMT    INT/YR    TERM (YRS)":GOTO 5170
5130 PRINT "TERMS: LOAN AMT    INT/YR    TERM (YRS)    EXTRA/MO":GOTO 5180
5140 PRINT "TERMS: LOAN AMT    INT/YR    TERM (YRS)    PAYMT/MO":GOTO 5190
5150 PRINT "TERMS: LOAN AMT    INT/YR    TERM (YRS)    PAYMT/MO      EXTRA/MO"
5160 PRINT"       $"P;:PRINT TAB(19) I;"%",Y,"$";:COLOR 23:PRINT M1,:COLOR 7:PRINT "$";E:GOTO 5200
5170 PRINT "      $"P;:PRINT TAB(19) I;"%",Y:GOTO 5220
5180 PRINT "      $"P;:PRINT TAB(19) I;"%",Y,"$";E:GOTO 5200
5190 PRINT "      $"P;:PRINT TAB(19) I;"%",Y,"$";:COLOR 23:PRINT M1:COLOR 7:GOTO 5220
5200 COLOR 1:PRINT "SCHEDULE FOR REGULAR PAYMENTS";:COLOR 7:PRINT SPC(7);
5210 COLOR 1:PRINT"SCHEDULE WITH EXTRA PAYMENTS";:COLOR 7:PRINT:PRINT:GOTO 5270
5220 IF Z><5 THEN 5260
5230 PRINT:PRINT "If you want a summary, PRESS `F5'; if not, PRESS `F2'."
5240 STOP
5250 PRINT:PRINT "Please wait up to 40 seconds for the summary to be prepared."
5260 PRINT:COLOR 1:PRINT "SCHEDULE FOR REGULAR PAYMENTS":COLOR 7:PRINT:PRINT
5270 IF Z<>8 THEN 5320
5280 PRINT "(You may change to a faster SUMMARY at ANY time DURING processing."
5290 PRINT "Press `F9'.  If screen is asking for INPUT, also press `Enter'."
5300 PRINT "Later you may return to DETAILED listing by pressing `F9' again.)"
5310 PRINT
5320 IF M1=0 THEN M1=M
5330 IF M1=M THEN 5400
5340 IF M1>0 THEN M2=M1-M
5350 M3=ABS(M2)
5360 IF M3<.6 THEN 5390
5370 IF M3>M2 THEN 6780
5380 IF M3=<M2 THEN 7250
5390 M=M1
5400 PRINT TAB(9) "REMAIN.";:PRINT TAB(18) "AMOUNT";:PRINT TAB(28) "TOTAL";
5410 IF E=0 OR F>0 THEN PRINT:GOTO 5450
5420 PRINT TAB(37) "REMAIN.";
5430 IF E=0 OR F>0 THEN PRINT:GOTO 5450
5440 PRINT TAB(47) "AMOUNT";:PRINT TAB(57) "TOTAL";:PRINT TAB(67) "EXTRA"
5450 PRINT "YR";:PRINT TAB(4) "MO";
5460 PRINT TAB(9)"BAL. ";:PRINT TAB(18) "TO INT";:PRINT TAB(28) "TO INT";
5470 IF E=0 OR F>0 THEN PRINT:GOTO 5510
5480 PRINT TAB(37) "BAL. ";
5490 IF E=0 OR F>0 THEN PRINT:GOTO 5510
5500 PRINT TAB(47) "TO INT";:PRINT TAB(57)"TO INT";:PRINT TAB(67)"TO PRIN."
5510 IF H=1 THEN 5610
5520 IF Z<>8 THEN 5680
5530 PRINT ">>>>"
5540 PRINT ">>>> Key the NUMBER OF MONTHS you wish to show, then `Enter': ";
5550 KEY(9) ON
5560 INPUT "   ";J
5570 ON KEY(9) GOSUB 7560
5580 KEY(9) OFF
5590 IF J=0 THEN 7540
5600 IF H=1 THEN 5400
5610 H=0
5620 IF J>480 THEN J=480
5630 J=480-J
5640 J1=0
5650 O=0:O1=0
5660 J=J+1
5670 J1=J1+1
5680 KEY(9) ON
5690 ON KEY(9) GOSUB 7560
5700 KEY(9) STOP
5710 IF (Y1*12)+C=>Y6*12 THEN 7740
5720 I1=P1*K
5730 O=O+I1
5740 Q=P1:P1=P1-(M-I1):Q1=P1
5750 IF Q1=>Q THEN 6940
5760 A=A+I1
5770 IF M=>P1+I1 THEN 6340
5780 IF E=0 OR F>0 THEN 5940
5790 EYE2=P2*K
5800 O1=O1+EYE2
5810 IF Y1=0 THEN 5860
5820 IF Y5=0 THEN 5860
5830 IF (Y1*12)+C<Y5*12 THEN 5860
5840 P2=P2-(M-EYE2)
5850 GOTO 5870
5860 P2=P2-(M-EYE2)-E
5870 B=B+EYE2
5880 IF (Y1*12)+C=>Y6*12 THEN 7740
5890 IF Y5=0 THEN 5910
5900 IF (Y1*12)+C=>Y5*12 THEN 5940
5910 D=D+1:D1=D MOD 12
5920 IF D1=0 THEN X5=X5+1
5930 E1=E1+E
5940 C=(C+1) MOD 12
5950 IF C=0 THEN Y1=Y1+1:Y4=Y4+1
5960 IF F=>1 THEN 5980
5970 IF M=>P2+EYE2+E THEN 6300
5980 IF Y1>Y+1 THEN 7100
5990 IF Z=5 AND S=2 THEN S=3
6000 IF S=1 OR F=2 THEN 6060
6010 IF Z=8 THEN 6060
6020 IF Y1=0 AND C=1 THEN 6060
6030 IF Z=5 THEN 6210
6040 IF Y4<5 THEN 5680
6050 Y4=0
6060 PRINT USING "## ";Y1;:PRINT USING "## ";C;
6070 PRINT USING "######.## ";P1;:PRINT USING "####.## ";I1;
6080 IF F>0 THEN S=S+1
6090 IF S=2 THEN Y2=Y1:C1=C
6100 IF S=>3 OR E=0 THEN 6130
6110 PRINT USING "#######.## ";A;
6120 GOTO 6170
6130 PRINT USING "#######.## ";A
6140 IF (Y1*12)+C=>Y6*12 AND E=0 THEN 7820
6150 IF (Y1*12)+C=>Y6*12 THEN 7760
6160 IF S=>1 OR E=0 THEN 6210
6170 PRINT USING "######.## ";P2;:PRINT USING "####.## ";EYE2;
6180 PRINT USING "#######.## ";B;
6190 IF Y9=1 THEN 7680
6200 PRINT USING "######.##";E1
6210 IF F=2 THEN 6370
6220 IF Z<>8 THEN 5680
6230 IF J1=12 THEN H=1:GOTO 6250
6240 IF J<480 THEN 5660
6250 PRINT "REG. INTEREST PAID THESE"J1;"MONTHS:"O;
6260 IF O1=0 THEN PRINT:GOTO 6280
6270 PRINT "-- INT., EXTRA SCHED:"O1
6280 PRINT:IF J=480 THEN 5540
6290 GOTO 5640
6300 IF P2<0 THEN P2=0
6310 Y9=1
6320 F=1:S=1
6330 GOTO 5980
6340 IF P1<0 THEN P1=0
6350 F=2
6360 GOTO 5940
6370 PRINT :IF Y1<Y-1 THEN 7420
6380 PRINT "TOTAL COST OF REGULARLY PAID LOAN: ";
6390 PRINT USING "$$##########.##";A+P
6400 IF E<>0 THEN 6460
6410 PRINT
6420 PRINT "  RUN is finished.        *** PRESS `F5' to RUN another loan. ***"
6430 STOP
6440 CLS
6450 GOTO 1190
6460 PRINT "TOTAL COST OF LOAN WITH EXTRA PAYMENTS: ";
6470 PRINT USING "#######.##";P+B
6480 PRINT TAB(20) "DIFFERENCE (SAVING): ";
6490 COLOR 9:PRINT USING "#######.##";(A+P)-(P+B);:COLOR 7
6500 PRINT
6510 PRINT "       >>> When ready, ENTER your estimated average federal"
6520 PRINT "income tax bracket (needed to solve for any after-tax advantage)."
6530 INPUT "For example, if you will be in the 50% bracket, enter 50."; A4
6540 A3=A4/100
6550 IF Y2=0 AND Y5=0 THEN D2=Y1:D3=C:GOTO 6620
6560 IF Y2=0 AND Y5=>Y6 THEN D2=Y1:D3=C:GOTO 6620
6570 IF Y2=0 THEN D2=X5:D3=D1:GOTO 6620
6580 IF Y5=0 THEN D2=Y2:D3=C1:GOTO 6620
6590 IF Y6=>Y5 AND Y2=>Y5 THEN D2=X5:D3=D1:GOTO 6620
6600 IF Y5=>Y2 AND Y6=>Y2 THEN D2=Y2:D3=C1:GOTO 6620
6610 D2=Y1:D3=C:GOTO 6620
6620 IF D7=1 THEN D7=0:IF X=4 THEN 7950 ELSE 8090
6630 C2=(D2*12)+D3
6640 FOR C3=C2 TO 1 STEP -1
6650 C4=E*(1+K)^C3
6660 Y3=Y3+C4
6670 NEXT C3
6680 IF X=7 THEN 4350
6690 PRINT">> THE AMOUNT (FUTURE VALUE) YOU MAY EXPECT BY INVESTING THE EXTRA"
6700 PRINT "PAYMENTS, $";E;"/mo, FOR THE SAME PERIOD,";D2;"yrs &";D3;"mos, IN"
6710 PRINT "ANOTHER INVESTMENT AT";I;"% COMPOUNDED MONTHLY WOULD BE: $"Y3
6720 COLOR 7
6730 GOTO 8100
6740 PRINT "RUN is finished.        *** Press `F5' for another RUN. ***"
6750 STOP
6760 CLS
6770 GOTO 1190
6780 PRINT
6790 PRINT"|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|"
6800 PRINT"|                                                                 |"
6810 PRINT"| ";:COLOR 31:PRINT "***";:COLOR 7:PRINT " CORRECTION MESSAGE ";
6820 COLOR 31:PRINT "***";:COLOR 7:PRINT "  The monthly payment you entered ";
6830 PRINT "is  |"
6840 PRINT"| too low; it does not match other entries.  The correct payment  |"
6850 PRINT"| is on the `calculated mo. paymt.' line above.  You may continue |"
6860 PRINT"| (PRESS `F5', but the RUN may be interrupted again if the error  |"
6870 PRINT"| is too great.  To start over, PRESS `F2' and correct or use the |"
6880 PRINT"| `0' entry.  Check your PRINCIPAL, TERM, and INTEREST entries!   |"
6890 PRINT"|                                                                 |"
6900 PRINT"|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|"
6910 PRINT
6920 STOP
6930 IF X>5 THEN 3140 ELSE 5390
6940 PRINT
6950 PRINT"|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|"
6960 PRINT"|                                                                 |"
6970 PRINT"| *** ";:COLOR 16,7:PRINT"CORRECTION MESSAGE";:COLOR 7:PRINT " *** ";
6980 PRINT "The monthly payment you entered is   |"
6990 PRINT"| so low that it does not pay the interest charge.  As a result,  |"
7000 PRINT"| the PRINCIPAL increases each month!  To continue would be a     |"
7010 PRINT"| disaster.  If you are certain of the payment, then check the    |"
7020 PRINT"| PRINCIPAL, TERM, and INTEREST entries.  One or more of them has |"
7030 PRINT"| to be incorrect.  Or take the easy way and enter `0' for the    |"
7040 PRINT"| payment.  Please try again.  Press `F2' for another start.      |"
7050 PRINT"|                                                                 |"
7060 PRINT"|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|"
7070 PRINT
7080 STOP
7090 GOTO 1000
7100 PRINT
7110 PRINT"|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|"
7120 PRINT"|                                                                 |"
7130 PRINT"| *** ";:COLOR 16,7:PRINT"CORRECTION MESSAGE";:COLOR 7:PRINT" *** ";
7140 COLOR 7,0
7150 PRINT "Sorry, your monthly payment is not   |"
7160 PRINT"| adequate.  As a result, a year or more is added to the term of  |"
7170 PRINT"| the loan.  Next time, enter `0' and use the computer-supplied   |"
7180 PRINT"| monthly payment figure.  Then check ALL of your input figures   |"
7190 PRINT"| for accuracy.  (Cooperate and graduate!)  Press `F2'.           |"
7200 PRINT"|                                                                 |"
7210 PRINT"|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|"
7220 PRINT
7230 STOP
7240 GOTO 1000
7250 PRINT
7260 PRINT"|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|"
7270 PRINT"|                                                                 |"
7280 PRINT"| ";:COLOR 31:PRINT "***";:COLOR 7:PRINT " CORRECTION MESSAGE ";
7290 COLOR 31:PRINT "***";:COLOR 7:PRINT " Your monthly payment is too high, ";
7300 PRINT "   |"
7310 PRINT"| which means that either the PRINCIPAL, TERM, INTEREST RATE, or  |"
7320 PRINT"| MONTHLY PAYMENT itself is not right.  The correct payment       |"
7330 PRINT"| is on the `calculated mo. paymt.' line above.  You may continue |"
7340 PRINT"| (PRESS `F5'), risking another interruption if the error is too  |"
7350 PRINT"| large.  Or start over (PRESS `F2') and use corrected amounts or |"
7360 PRINT"| the `0' entry for the computer-supplied monthly payment.        |"
7370 PRINT"|                                                                 |"
7380 PRINT"|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|"
7390 PRINT
7400 STOP
7410 IF X>5 THEN 3140 ELSE 5390
7420 PRINT
7430 PRINT"|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|"
7440 PRINT"|                                                                 |"
7450 PRINT"| *** ";:COLOR 16,7:PRINT"CORRECTION MESSAGE";:COLOR 7:PRINT" *** ";
7460 PRINT "Sorry, the computer's conscience     |"
7470 PRINT"| will not allow continuation.  The MONTHLY PAYMENT is so large   |"
7480 PRINT"| it pays off the loan at least a year ahead of schedule.         |"
7490 PRINT"| Allow the computer to help.  Try again (PRESS `F2'), and enter  |"
7500 PRINT"| `0' for the MONTHLY PAYMENT.  Then see how easy it is!          |"
7510 PRINT"|                                                                 |"
7520 PRINT"|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|"
7530 PRINT
7540 STOP
7550 GOTO 1000
7560 PRINT
7570 KEY(9) OFF
7580 INPUT "Key 2 or 5 to SUMMARIZE; key 8 to DETAIL; 0 to STOP; & Enter: ";Z
7590 IF Z=0 THEN 7540
7600 IF Z>3 AND Z<7 THEN Z=5
7610 IF Z>6 THEN Z=8
7620 IF Z<4 THEN Z=2
7630 IF X=7 THEN LPRINT
7640 IF X=7 THEN Y11=0
7650 IF Z=8 AND X=7 THEN 3360
7660 IF X=7 THEN 3530 ELSE 5520
7670 RETURN
7680 COLOR 9
7690 PRINT USING "######.##";E1;
7700 COLOR 7,0
7710 PRINT
7720 Y9=0
7730 GOTO 6210
7740 IF E=0 AND X=7 THEN 3950
7750 IF E=0 THEN 6060
7760 PRINT
7770 PRINT "       >>> When ready, ENTER your estimated average federal"
7780 PRINT "income tax bracket (needed to solve for any after-tax advantage)."
7790 INPUT "For example, if you will be in the 50% bracket, enter 50."; A4
7800 A3=A4/100
7810 IF X=7 THEN 7970
7820 PRINT "Regular Payments Remaining Balance:";
7830 PRINT USING "$$#######.##";P1;
7840 PRINT "  If sold at end of year";Y6;"."
7850 IF E=0 THEN PRINT:GOTO 6740
7860 IF M=>P2+EYE2+E THEN P2=0
7870 PRINT "  Extra Schedule Remaining Balance:";
7880 COLOR 1:PRINT USING "#########.##";P2:COLOR 7,0
7890 PRINT "            Loan Balance Reduction:";
7900 COLOR 10:PRINT USING "#########.##";P1-P2;
7910 COLOR 7,0
7920 PRINT " Total Extra Payments to Principal:    ";
7930 COLOR 18:PRINT USING "#####.##";E1;:COLOR 7,0
7940 D7=1:GOTO 6550
7950 PRINT "  For"D2"years and"D3"months.":GOTO 6630
7960 IF E=0 THEN 3950
7970 LPRINT:LPRINT "Regular Payments Remaining Balance:";
7980 LPRINT USING "$$#######.##";P1;
7990 LPRINT "  If sold at end of year";Y6;"."
8000 IF E=0 THEN PRINT:GOTO 4420
8010 IF M=>P2+EYE2+E THEN P2=0
8020 LPRINT "  Extra Schedule Remaining Balance:";
8030 LPRINT USING "#########.##";P2
8040 LPRINT "            Loan Balance Reduction:";
8050 LPRINT USING "#########.##";P1-P2
8060 LPRINT " Total Extra Payments to Principal:   ";
8070 LPRINT USING "######.##";E1;
8080 D7=1:GOTO 6550
8090 LPRINT "  For"D2"years and"D3"months.":GOTO 6630
8100 X6=((Y1*12)+C)-((D2*12)+D3)
8110 X7=X6
8120 IF X7=<0 THEN 8250
8130 FOR X8=X7 TO 1 STEP -1
8140 Y3=Y3+(K*Y3)
8150 NEXT X8
8160 X9=(X7/12)-INT(X7/12)
8170 X9=CINT(X9*12)
8180 X7=INT(X7/12)
8190 IF X=4 THEN 8230
8200 LPRINT "PLUS ADDED"I"% INTEREST FOR"X7"YEARS AND"X9"MONTHS TOTALS: ";
8210 LPRINT USING "$$######.##";Y3
8220 LPRINT:GOTO 8250
8230 PRINT "PLUS ADDED"I"% INTEREST FOR"X7"YEARS AND"X9"MONTHS TOTALS: ";
8240 COLOR 10:PRINT USING "$$#########.##";Y3;:COLOR 7,0:PRINT
8250 B3=((I-3)/I)*(Y3-E1)+E1:IF X=7 THEN 8300
8260 PRINT ">>>"I"% MAY NOT BE AVAILABLE IN A SAFE ALTERNATE INVESTMENT."
8270 PRINT USING"FOR ##.###";I-3;:PRINT USING" %, USE ##.###";I-3;:PRINT" /"I"X ("Y3"-"E1") +"E1"=";
8280 COLOR 10:PRINT USING "$$######.##";B3;:COLOR 7,0
8290 GOTO 8530
8300 LPRINT">>>"I"% MAY NOT BE AVAILABLE IN A SAFE ALTERNATE INVESTMENT.  FOR"
8310 LPRINT USING"##.###";I-3;:LPRINT USING" %, USE _(###.###";I-3;:LPRINT" /"I") X ("Y3"-"E1") +"E1"=";:LPRINT TAB(63);
8320 LPRINT USING "$$######.##";B3
8330 LPRINT
8340 IF P1-P2>(B3-E1) THEN 8380
8350 LPRINT
8360 LPRINT "This case reveals NO advantage in extra payments to principal."
8370 GOTO 4420
8380 LPRINT
8390 B8=((P1-P2)-((A-B)*(1-A3)))-((Y3-E1)*(1-A3))
8400 B9=((P1-P2)-((A-B)*(1-A3)))-((B3-E1)*(1-A3))
8410 LPRINT "SAMPLE TAX RESULTS FOLLOW (using"A4"% as the tax bracket):"
8420 LPRINT "The net, after tax, advantage in making extra payments to"
8430 LPRINT "principal in this case, compared to an alternate investment:"
8440 LPRINT:LPRINT TAB(20) ">>> at";:LPRINT USING"###.###";I;:LPRINT "% is:";
8450 LPRINT USING "$$######.##";B8
8460 LPRINT TAB(20) ">>> at";:LPRINT USING"###.###";I-3;:LPRINT "% is:";
8470 LPRINT USING "$$######.##";B9
8480 LPRINT
8490 PRINT "TO EXAMINE THE METHOD FOR FINDING TAX RESULTS, PRESS `M' & ENTER."
8500 INPUT "TO AVOID IT, PRESS THE SPACE BAR AND `ENTER'."; M$
8510 IF M$=CHR$(77) OR M$=CHR$(109) THEN 8720
8520 GOTO 4420
8530 IF P1-P2>(B3-E1) THEN PRINT:GOTO 8570
8540 PRINT
8550 PRINT "This case reveals NO advantage in extra payments to principal."
8560 GOTO 6420
8570 B8=((P1-P2)-((A-B)*(1-A3)))-((Y3-E1)*(1-A3))
8580 B9=((P1-P2)-((A-B)*(1-A3)))-((B3-E1)*(1-A3))
8590 PRINT
8600 PRINT "SAMPLE TAX RESULTS FOLLOW:"
8610 PRINT "The net, after tax, advantage in making extra payments to"
8620 PRINT "principal in this case, compared to an alternate investment:"
8630 PRINT TAB(20) ">>> at";:COLOR 10:PRINT USING "###.###";I;
8640 COLOR 7,0:PRINT"% is: ";:COLOR 10:PRINT USING "$$#####.##";B8;:COLOR 7,0
8650 PRINT TAB(20) ">>> at";:COLOR 10:PRINT USING "###.###";I-3;
8660 COLOR 7,0:PRINT "% is: ";:COLOR 10:PRINT USING"$$#####.##";B9;:COLOR 7,0
8670 PRINT
8680 PRINT "TO EXAMINE THE METHOD FOR FINDING TAX RESULTS, PRESS `M' & ENTER."
8690 INPUT "TO AVOID IT, PRESS THE SPACE BAR AND `ENTER'."; M$
8700 IF M$=CHR$(77) OR M$=CHR$(109) THEN 8720
8710 GOTO 6740
8720 CLS
8730 PRINT "FEDERAL INCOME TAX COMPARISON METHOD:  Assume 50% tax bracket."
8740 PRINT "First, subtract half of the difference between total interest paid"
8750 PRINT "on the two schedules (WITH & WITHOUT extra payments to principal)"
8760 PRINT "from the difference between the last remaining balances of the two"
8770 PRINT "schedules,if any.  Further reduce this result by subtracting half"
8780 PRINT "the difference of the total alternate investment accumulation at"
8790 PRINT "the higher percentage and the total extra payments to principal."
8800 PRINT "Then repeat this last reduction on the first result with the"
8810 PRINT "alternate accumulation at the lower rate.  (The other halves in"
8820 PRINT "the above statements are lost to the tax.)  Yours looks this way:"
8830 PRINT
8840 PRINT "("P1"-"P2") - (("A"-"B") X ( 1 -"A3"))"
8850 PRINT "- (("B3"-"E1") X ( 1 -"A3")) ="B9
8860 PRINT
8870 PRINT "The two after tax results are ONLY GUIDES.  The method assumes all"
8880 PRINT"interest paid is deductible, and that all interest earned is taxed."
8890 PRINT "Neither is true.  Also it should be noted that the alternate"
8900 PRINT "investment -- when shown to be superior -- actually must be made"
8910 PRINT "(not just thought about!) for this comparison to be valid.  This"
8920 PRINT "program's examples can help, but USERS MUST MAKE THE DECISIONS."
8930 GOTO 6420
8940 CLS
8950 COLOR 0,7:PRINT" LOAN PAYMENT SOLUTION ";:COLOR 7:PRINT" ENTER (";:COLOR 18:PRINT "SEPARATELY";:COLOR 7:PRINT ") THE LOAN AMOUNT (PRINCIPAL),"
8960 PRINT "INTEREST % PER YEAR, AND TERM (NUMBER OF YEARS).  EXAMPLE: ? 80000 ? 11.75 ? 30"
8970 P=0:K=0:N=0:M=0
8980 INPUT;P:PRINT " ";:IF P=0 THEN 9050
8990 INPUT;K:PRINT " ";:INPUT;N:PRINT TAB(32);
9000 IF P=0 THEN 9050
9010 K=K/1200:N=N*12
9020 M=P*K*(1+K)^N/((1+K)^N-1)
9030 PRINT "PAYMENT PER MONTH = $";:COLOR 0,7:PRINT M;:COLOR 7:PRINT:PRINT
9040 PRINT "ENTER FIGURES FOR ANOTHER LOAN.  IF DONE, ENTER: 0":GOTO 8980
9050 P=0:K=0:N=0:M=0
9060 PRINT:GOTO 1190
9070 END
40 PRINT "ENTER FIGURES 