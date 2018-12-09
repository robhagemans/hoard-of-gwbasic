10 ' PROGRAM NAME: PORTCOST.BAS   WRITTEN 17 AUG 1983   REV 14 SEP 1983
20 '
30 '  *******************************************************************
40 '
50  DIM COMP.NAME$(25), QTY(25)
55  DIM COST(25), PERCENT(25), SHARE.COST(25)
60 '
70 '  *******************************************************************
80 '  * DRIVER MODULE                                                   *
90 '  *                                                                 *
100 ' *******************************************************************
110 '
115 CLS
120 PRINT "PROGRAM PORTCOST.BAS EXECUTING"
140 OPEN "A:DRIVE.DTA" FOR INPUT AS #1
150 INPUT #1, DRIVE$,PRNT$
160 CLOSE #1
170 IF DRIVE$ = "A" OR DRIVE$ = "a" THEN GOSUB 300 ELSE GOSUB 400
175 '
180 '  SET UP DEFAULT CONDITIONS FOR IBM OR EPSON PRINTER
185 IF PRNT$ = "E" OR PRNT$ = "e" THEN GOSUB 2000 ELSE GOSUB 2100
190 '
195 GOSUB 500                           'PRIME READ
200 '
210 GOSUB 600                           'DATA READS
220 '
230 GOSUB 800                           'CALCULATE PERCENTAGES
240 '
250 GOSUB 900                           'CALCULATE AVERAGES
260 '
270 GOSUB 1000                          'PRINT REPORT
280 '
290 GOSUB 1900                          'EOJ HSKEEPING
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
700     COST(N) = ICOST
710     TOTAL.COST = TOTAL.COST + ICOST
720     TOTAL.SHARE.COUNT = TOTAL.SHARE.COUNT + IQTY
730     NEXT
740 CLOSE #2
745 N = N - 1
750 RETURN
800 ' *******************************************************************
810 ' * GOSUB 800                                                       *
820 ' * CALCULATE PERCENTS AND COST/SHARE                               *
830 ' *******************************************************************
840 '
850 FOR J = 1 TO N
860     PERCENT(J) = COST(J) / TOTAL.COST
870     PERCENT(J) = PERCENT(J) * 100
880     SHARE.COST(J) = COST(J) / QTY(J)
890     NEXT
895 RETURN
900 ' *******************************************************************
910 ' * GOSUB 900                                                       *
920 ' * CALCULATE AVERAGES                                              *
930 ' *******************************************************************
940 '
950 AVERAGE.PER.SHARE = TOTAL.COST / TOTAL.SHARE.COUNT
960 AVERAGE.PER.STOCK = TOTAL.COST / N
970 RETURN
1000 ' *******************************************************************
1010 ' * GOSUB 1000                                                      *
1020 ' * PRINT REPORT                                                    *
1030 ' *******************************************************************
1040 '
1050 GOSUB 1300                         'PRINT HEADERS
1060 FOR K = 1 TO N
1070    LPRINT TAB(10) USING "##,###"; QTY(K);
1080    LPRINT TAB(19) COMP.NAME$(K);
1090    LPRINT TAB(43) USING "###.##"; SHARE.COST(K);
1100    LPRINT TAB(50) USING "#,###,###.##"; COST(K);
1110    LPRINT TAB(68) USING "###.##"; PERCENT(K)
1130    NEXT
1140 '
1150 GOSUB 1700                         'PRINT TOTALS
1160 '
1170 RETURN
1300 ' *******************************************************************
1310 ' * GOSUB 1300                                                      *
1320 ' * PRINT HEADERS                                                   *
1330 ' *******************************************************************
1340 '
1350 LPRINT: LPRINT: LPRINT
1355 '                                   HEADER #1
1360 LPRINT TAB(24) FILE.TITLE$;
1370 LPRINT TAB(43) DATE.OF.RECORD$;
1380 LPRINT TAB(68) DATE$
1390 LPRINT
1395 '                                   HEADER #2
1400 LPRINT TAB(25) FILE.OWNER$
1410 LPRINT: LPRINT
1415 '                                   HEADER #3
1420 LPRINT TAB(12) "STOCK";
1430 LPRINT TAB(19) "STOCK";
1440 LPRINT TAB(44) "COST/";
1450 LPRINT TAB(58) "TOTAL";
1460 LPRINT TAB(66) "PERCENT"
1465 '                                   HEADER #4
1470 LPRINT TAB(13) "QTY";
1480 LPRINT TAB(19) "NAME";
1490 LPRINT TAB(44) "SHARE";
1500 LPRINT TAB(58) "COST";
1510 LPRINT TAB(66) "OF TTL"
1520 LPRINT: LPRINT
1530 '
1540 RETURN
1700 ' *******************************************************************
1710 ' * GOSUB 1700                                                      *
1720 ' * PRINT TOTALS                                                    *
1730 ' *******************************************************************
1740 '
1745 '                                  TOTAL LINE 1
1750 LPRINT TAB(10) "______";
1760 LPRINT TAB(52) "__________"
1765 '                                  TOTAL LINE 2
1770 LPRINT TAB(9) USING "###,###"; TOTAL.SHARE.COUNT;
1780 LPRINT TAB(19) "TOTALS";
1785 LPRINT TAB(49) USING "##,###,###.##"; TOTAL.COST
1790 LPRINT
1795 '                                  TOTAL LINE 3
1800 LPRINT TAB(19) "AVERAGE COST PER SHARE";
1810 LPRINT TAB(56) USING "###.##"; AVERAGE.PER.SHARE
1812 LPRINT
1815 '                                  TOTAL LINE 4
1820 LPRINT TAB(19) "AVERAGE COST PER SECURITY";
1830 LPRINT TAB(50) USING "#,###,###.##"; AVERAGE.PER.STOCK
1840 '
1850 RETURN
1900 ' *******************************************************************
1910 ' * GOSUB 1900                                                      *
1920 ' * EOJ HOUSEKEEPING                                                *
1930 ' *******************************************************************
1940 '
1950 PRINT "PROGRAM PROCESSING COMPLETED - PROGRAM ENDS"
1960 LPRINT CHR$(12);                   'SET PRINTER TO HEAD OF FORM
1995 RETURN
2000 '***********************************************************
2005 '*   SET EPSON PRINTER TO DEFAULT CONDITION                *
2010 '***********************************************************
2015 '
2020 LPRINT CHR$(27); CHR$(64);         'TURN OFF ALL SPCL PRINTER CODES
2025 RETURN
2100 '***********************************************************
2105 '*   SET IBM PRINTER TO DEFAULT CONDITIONS                 *
2110 '***********************************************************
2115 '
2120 LPRINT CHR$(20);                   'DOUBLE WIDTH CHAR OFF
2125 LPRINT CHR$(18);                   'COMPRESSED CHAR OFF
2130 LPRINT CHR$(27); CHR$(50);         'DEFAULT LINE SPACING (1/6")
2135 LPRINT CHR$(27); CHR$(55);         'CHAR SET #1 SELECTED
2140 LPRINT CHR$(27); CHR$(57);         'PAPER OUT SWITCH ENABLED
2145 LPRINT CHR$(27); CHR$(70);         'EMPHASIZED CHAR OFF
2150 LPRINT CHR$(27); CHR$(72);         'DOUBLE STRIKE OFF
2155 LPRINT CHR$(27); CHR$(79);         'IGNORE SKIPS OVER PERFS
2160 LPRINT CHR$(27); CHR$(85); CHR$(0);  'SELECT BIDIRECTIONAL PRINT
2165 LPRINT CHR$(27); CHR$(84);         'SUB/SUPERSCRIPT OFF
2170 LPRINT CHR$(27); CHR$(87); CHR$(0);  'DOUBLE WIDE CHAR OFF
2175 LPRINT CHR$(27); CHR$(45); CHR$(0);  'UNDERLINING OFF
2180 '
2185 RETURN
2190 '
2195 '***********************************************************
); CHR$(0);  'UNDERLINING OFF
2180 '
2185 RETURN
2190 '
2195 '********************************************************