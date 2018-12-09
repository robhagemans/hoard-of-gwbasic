10 ' PROGRAM NAME: PORTMRKT.BAS   WRITTEN 27 AUG 1983   REV 14 SEP 1983
20 '
30 '  *******************************************************************
40 '
50  DIM COMP.NAME$(25), QTY(25), PRICE(25), DELTA(25)
55  DIM TARGET(25)
60 '
70 '  *******************************************************************
80 '  * DRIVER MODULE                                                   *
90 '  *                                                                 *
100 ' *******************************************************************
110 '
115 CLS
120 PRINT "PROGRAM PORTMRKT.BAS EXECUTING"
140 OPEN "A:DRIVE.DTA" FOR INPUT AS #1
150 INPUT #1, DRIVE$,PRNT$
160 CLOSE #1
170 IF DRIVE$ = "A" OR DRIVE$ = "a" THEN GOSUB 300 ELSE GOSUB 400
180 '
190 GOSUB 500                           'PRIME READ
200 '
210 GOSUB 600                           'DATA READS
220 '
230 GOSUB 800                           'INPUT PRICE/DELTA PER SHARE
235 '
240 WIDTH "LPT1:",132
242 '  SET UP DEFAULT CONDITIONS FOR IBM OR EPSON PRINTER
245 IF PRNT$ = "E" OR PRNT$ = "e" THEN GOSUB 2800 ELSE GOSUB 2900
248 '
250 LPRINT CHR$(15);                    'SET COMPRESSED CHAR ON
255 '
260 GOSUB 1000                          'PRINT REPORT
265 '
270 GOSUB 2200                          'CHECK/CORRECT REPORT OUTPUT
280 '
290 GOSUB 2700                          'EOJ HSKEEPING
295 '
298 END
300 ' *******************************************************************
310 ' * GOSUB 300                                                       *
320 ' * GET DATA FROM DRIVE A                                           *
330 ' *******************************************************************
340 '
350 PRINT "INSERT DATA DISKETTE IN DRIVE A"
355 PRINT "SET PRINTER TO TOP OF PAGE"
360 PRINT "VERIFY THAT PRINTER IS ON"
365 PRINT "STRIKE ANY KEY WHEN READY"
370 A$ = INKEY$: IF A$ = "" THEN 370
380 OPEN "A:HOLDLIST.DTA" FOR INPUT AS #2
390 RETURN
400 ' *******************************************************************
410 ' * GOSUB 400                                                       *
420 ' * GET DATA FROM DRIVE B                                           *
430 ' *******************************************************************
440 '
450 PRINT "INSERT DATA DISKETTE IN DRIVE B"
455 PRINT "SET PRINTER TO TOP OF PAGE"
460 PRINT "VERIFY THAT PRINTER IS ON"
465 PRINT "STRIKE ANY KEY WHEN READY"
470 A$ = INKEY$: IF A$ = "" THEN 470
480 OPEN "B:HOLDLIST.DTA" FOR INPUT AS #2
490 RETURN
500 ' *******************************************************************
510 ' * GOSUB 500                                                       *
520 ' * PRIME READ MODULE                                               *
530 ' *******************************************************************
540 '
550 INPUT #2, FILE.TITLE$,FILE.OWNER$,RECORD.COUNT,DATE.OF.RECORD$,UPDATE.DATE$
560 RETURN
600 ' *******************************************************************
610 ' * GOSUB 600                                                       *
620 ' * READ IN ALL INPUT DATA                                          *
630 ' *******************************************************************
640 '
650 FOR N = 1 TO RECORD.COUNT
660     IF EOF(2) THEN GOTO 740
670     INPUT #2, INAME$, IQTY, ICOST, ITARGET
680     COMP.NAME$(N) = INAME$
690     QTY(N) = IQTY
700     TARGET(N) = ITARGET
720     TOTAL.SHARE.COUNT = TOTAL.SHARE.COUNT + IQTY
730     NEXT
740 CLOSE #2
745 N = N - 1
750 RETURN
800 ' *******************************************************************
810 ' * GOSUB 800                                                       *
820 ' * INPUT CURRENT PRICE/CHANGES PER SHARE                           *
830 ' *******************************************************************
840 '
845 INPUT "INPUT DATE FOR REPORT (DD MONTH YYYY) ", REPORT.DATE$
850 '
855 PRINT "INPUT CURRENT PRICE PER SHARE (A)"
860 PRINT "      AND"
870 PRINT "      PER SHARE PRICE CHANGE (B)"
880 PRINT "      FOR FOLLOWING:"
890 PRINT
900 '
910 FOR J = 1 TO N
920     PRINT COMP.NAME$(J)
930     INPUT "A = ", PRICE(J)
940     INPUT "B = ", DELTA(J)
950     NEXT
960 '
970 INPUT "DO YOU WISH TO CORRECT AN INPUT (Y/N)? ", C$
980 IF C$ = "Y" OR C$ = "y" THEN GOSUB 2500
990 RETURN
1000 ' *******************************************************************
1010 ' * GOSUB 1000                                                      *
1020 ' * PRINT REPORT                                                    *
1030 ' *******************************************************************
1040 '
1050 GOSUB 1300                         'PRINT HEADERS
1055 '
1060 FOR K = 1 TO N
1070    TTL.DELTA = DELTA(K) * QTY(K)
1080    TTL.PRICE = PRICE(K) * QTY(K)
1090    GRND.TTL.DELTA = GRND.TTL.DELTA + TTL.DELTA
1100    GRND.TTL.PRICE = GRND.TTL.PRICE + TTL.PRICE
1110    LPRINT TAB(12) USING "##,###"; QTY(K);
1120    LPRINT TAB(24) COMP.NAME$(K);
1130    LPRINT TAB(50) USING "###.###"; PRICE(K);
1140    LPRINT TAB(63) USING "##.###"; DELTA(K);
1150    LPRINT TAB(75) USING "###,###.##"; TTL.DELTA;
1160    LPRINT TAB(90) USING "#,###,###.##"; TTL.PRICE;
1170    LPRINT TAB(108) USING "###.###"; TARGET(K);
1180    IF PRICE(K) = TARGET(K) OR PRICE(K) > TARGET(K) THEN LPRINT TAB(122) "****" ELSE LPRINT TAB(122) "    "
1200    NEXT
1210 '
1220 GOSUB 1700                         'PRINT TOTALS
1230 '
1235 LPRINT CHR$(12);                   'PRINTER HOF COMMAND
1240 '
1250 RETURN
1300 ' *******************************************************************
1310 ' * GOSUB 1300                                                      *
1320 ' * PRINT HEADERS                                                   *
1330 ' *******************************************************************
1340 '
1345 LPRINT
1350 LPRINT: LPRINT
1355 '                                   HEADER #1
1360 LPRINT TAB(42) "PORTFOLIO EVALUATION - ";
1370 LPRINT TAB(65) REPORT.DATE$;
1380 LPRINT TAB(110) DATE$
1390 LPRINT
1395 '                                   HEADER #2
1400 LPRINT TAB(52) FILE.OWNER$
1410 LPRINT: LPRINT
1415 '                                   HEADER #3
1420 LPRINT TAB(12) "ACCOUNT";
1430 LPRINT TAB(24) "SECURITY";
1440 LPRINT TAB(50) "CURRENT";
1450 LPRINT TAB(62) "PER SHARE";
1460 LPRINT TAB(78) "TOTAL";
1465 LPRINT TAB(91) "CURRENT";
1470 LPRINT TAB(109) "SELL";
1472 LPRINT TAB(121) "TARGET"
1475 '                                   HEADER #4
1480 LPRINT TAB(12) "QUANTITY";
1485 LPRINT TAB(24) "NAME";
1490 LPRINT TAB(50) "PRICE";
1500 LPRINT TAB(63) "CHANGE";
1510 LPRINT TAB(78) "CHANGE";
1520 LPRINT TAB(91) "TOTAL VALUE";
1530 LPRINT TAB(109) "TARGET";
1540 LPRINT TAB(121) "REACHED"
1550 LPRINT: LPRINT
1560 '
1570 RETURN
1700 ' *******************************************************************
1710 ' * GOSUB 1700                                                      *
1720 ' * PRINT TOTALS                                                    *
1730 ' *******************************************************************
1740 '
1745 '                                  TOTAL LINE 1
1750 LPRINT:LPRINT
1770 LPRINT TAB(11) USING "###,###"; TOTAL.SHARE.COUNT;
1780 LPRINT TAB(24) "TOTALS";
1785 LPRINT TAB(72) USING "##,###,###.##"; GRND.TTL.DELTA;
1800 LPRINT TAB(89) USING "##,###,###.##"; GRND.TTL.PRICE
1840 '
1850 RETURN
2200 ' *******************************************************************
2210 ' * GOSUB 2200                                                      *
2220 ' * CHECK/CORRECT PRINTED REPORT                                    *
2230 ' *******************************************************************
2240 '
2250 PRINT "CHECK PRINTED REPORT "
2260 INPUT "DO YOU WISH TO CORRECT AND REPRINT (Y/N)? ", Q$
2270 IF Q$ <> "Y" AND Q$ <> "y" THEN GOTO 2350
2280 '
2290 GOSUB 2500                         'CORRECT INPUTS
2300 '
2310 GOSUB 1000                         'PRINT REPORT
2315 '
2320 GOTO 2250
2330 '
2350 RETURN
2500 ' *******************************************************************
2510 ' * GOSUB 2500                                                      *
2520 ' * CORRECT INPUT                                                   *
2530 ' *******************************************************************
2535 '
2540 GRND.TTL.DELTA = 0
2545 GRND.TTL.PRICE = 0
2550 '
2555 PRINT "INPUT NUMBER OF STOCK TO BE CORRECTED"
2560 PRINT "      OR"
2570 PRINT "      0 TO END CORRECTIONS"
2580 INPUT CORRECTION.NUM
2590 IF CORRECTION.NUM = 0 THEN GOTO 2685
2600 IF CORRECTION.NUM < 1 OR CORRECTION.NUM > N THEN BEEP: GOTO 2550
2610 PRINT COMP.NAME$(CORRECTION.NUM)
2620 PRINT "ORIGINAL PRICE ENTERED WAS ", PRICE(CORRECTION.NUM)
2630 INPUT "NEW PRICE TO BE ENTERED IS "; PRICE(CORRECTION.NUM)
2640 PRINT "ORIGINAL PRICE CHANGE ENTERED WAS ", DELTA(CORRECTION.NUM)
2650 INPUT "NEW PRICE CHANGE TO BE ENTERED IS "; DELTA(CORRECTION.NUM)
2660 GOTO 2540
2670 '
2680 '
2685 PRINT "VERIFY THAT PRINTER IS ON"
2690 RETURN
2700 ' *******************************************************************
2710 ' * GOSUB 2700                                                      *
2720 ' * EOJ HOUSEKEEPING                                                *
2730 ' *******************************************************************
2740 '
2750 PRINT "PROGRAM PROCESSING COMPLETED - PROGRAM ENDS"
2770 LPRINT CHR$(18);                   'SET COMPRESSED CHAR OFF
2780 WIDTH "LPT1:",80
2795 RETURN
2800 '***********************************************************
2805 '*   SET EPSON PRINTER TO DEFAULT CONDITION                *
2810 '***********************************************************
2815 '
2820 LPRINT CHR$(27); CHR$(64);         'TURN OFF ALL SPCL PRINTER CODES
2825 RETURN
2900 '***********************************************************
2905 '*   SET IBM PRINTER TO DEFAULT CONDITIONS                 *
2910 '***********************************************************
2915 '
2920 LPRINT CHR$(20);                   'DOUBLE WIDTH CHAR OFF
2925 LPRINT CHR$(18);                   'COMPRESSED CHAR OFF
2930 LPRINT CHR$(27); CHR$(50);         'DEFAULT LINE SPACING (1/6")
2935 LPRINT CHR$(27); CHR$(55);         'CHAR SET #1 SELECTED
2940 LPRINT CHR$(27); CHR$(57);         'PAPER OUT SWITCH ENABLED
2945 LPRINT CHR$(27); CHR$(70);         'EMPHASIZED CHAR OFF
2950 LPRINT CHR$(27); CHR$(72);         'DOUBLE STRIKE OFF
2955 LPRINT CHR$(27); CHR$(79);         'IGNORE SKIPS OVER PERFS
2960 LPRINT CHR$(27); CHR$(85); CHR$(0);  'SELECT BIDIRECTIONAL PRINT
2965 LPRINT CHR$(27); CHR$(84);         'SUB/SUPERSCRIPT OFF
2970 LPRINT CHR$(27); CHR$(87); CHR$(0);  'DOUBLE WIDE CHAR OFF
2975 LPRINT CHR$(27); CHR$(45); CHR$(0);  'UNDERLINING OFF
2980 '
2985 RETURN
2990 '
2995 '***********************************************************
); CHR$(0);  'UNDERLINING OFF
2980 '
2985 RETURN
2990 '
2995 '***