10  ' PGM NAME: DLTAPRNT.BAS      WRITTEN 9-4-1983     REV 9-16-1983
15 ' ******************************************************************
20 ' * MATRIX IDENTIFICATION AND DIMENSIONS                           *
25 ' ******************************************************************
30 '
35 DIM G$(80)
40 ' *****************************************************************
45 ' * MODULE 0                                                      *
50 ' * DRIVER MODULE                                                 *
55 ' *****************************************************************
60 '
65 CLS
70 PRINT "PROGRAM DLTAPRNT.BAS EXECUTING"
90 OPEN "A:DRIVE.DTA" FOR INPUT AS #1
100 INPUT #1, DRIVE$,PRNT$
110 CLOSE #1
120 IF DRIVE$ = "A" OR DRIVE$ = "a" THEN GOSUB 300 ELSE GOSUB 400
130 '
135 WIDTH "LPT1:",80            'SET LINE WIDTH TO 80
140 '  SET UP DEFAULT CONDITIONS FOR IBM OR EPSON PRINTER
150 IF PRNT$ = "E" OR PRNT$ = "e" THEN GOSUB 4200 ELSE GOSUB 4300
160 LPRINT CHR$(27); CHR$(48);          'SET FOR COMPRESSED LINES
165 '
170 GOSUB 1000                  'PRINT HDRS, PERFORM HOUSEKEEPING
175 '
180 END.NUM = END.NUM - REC.CNT
190 FOR I = 1 TO END.NUM
200         IF EOF(2) THEN GOTO 230
210         GOSUB 3000         'PROCESS INPUT RECORDS
220         NEXT
230 GOSUB 4000                 'PERFORM EOJ HOUSEKEEPING
240 END
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
380 OPEN "A:DLTAFILE.DTA" FOR INPUT AS #2
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
480 OPEN "B:DLTAFILE.DTA" FOR INPUT AS #2
490 RETURN
1000 ' ****************************************************************
1002 ' * GOSUB 1000                                                   *
1004 ' * PRELIMINARY OPERATIONS                                       *
1008 ' ****************************************************************
1010 '
1015 INPUT #2, I.FILE.TITLE$,I.FILE.OWNER$,I.FILE.UPDATE.DATE$
1020 HDG1$ = I.FILE.OWNER$
1025 GOSUB 2000                         'SET UP HEADINGS
1030 GOSUB 2500                         'SET UP END.NUM AND SKIP.NUM
1035 IF SKIP.NUM <> 0 THEN GOSUB 2700   'SKIP INITIAL RECORDS
1038 '   END PROCESSING IF RECORD COUNT LIMIT REACHED
1040 IF REC.CNT > END.NUM THEN GOTO 230
1044 HDG2$ = "PORTFOLIO CHANGES"
1046 HDG3$ = "DOLLAR CHANGES"
1048 HDG4$ = "PERCENT CHANGES (UNITS)"
1050 LPRINT
1052 LPRINT TAB(3) HDG1$; TAB(35) HDG2$; TAB(70) DATE$
1054 LPRINT
1056 LPRINT TAB(16) HDG3$; TAB(57) HDG4$
1058 LPRINT
1060 LPRINT TAB(6) HDRA$; TAB(16) HDRB$; TAB(28) "0"; TAB(36) HDRC$; TAB(46) HDRD$; TAB(57) "-10"; TAB(62) "-5"; TAB(68) "0"; TAB(72) "+5"; TAB(77) "+10"
1062 LPRINT TAB(8) "v"; TAB(18) "v"; TAB(28) "v"; TAB(38) "v"; TAB(48) "v"; TAB(58) "v"; TAB(63) "v"; TAB(68) "v"; TAB(73) "v"; TAB(78) "v"
1064 GWEEK$ = "      "
1065 G$(0) = " "
1066 FOR I = 1 TO 80
1068         IF PRNT$ = "E" THEN G$(I) = CHR$(157) ELSE G$(I) = CHR$(196)
1070         NEXT
1072 GOSUB 3500                 'WRITE REC WITH G$ ELEMENTS
1074 GOSUB 3600                 'CLEAR G$ ELEMENTS TO SPACES
1076 RETURN
2000 ' ****************************************************************
2005 ' * GOSUB 2000                                                   *
2010 ' * SET UP GRAPH HEADINGS                                        *
2015 ' ****************************************************************
2020 '
2025 PRINT "SELECT GRAPH SCALE FROM FOLLOWING:"
2030 PRINT "     1 - $0 TO $1000 RANGE"
2035 PRINT "     2 - $0 TO $2000 RANGE"
2040 PRINT "     3 - $0 TO $4000 RANGE"
2045 PRINT "     4 - $0 TO $8000 RANGE"
2050 INPUT "GRAPH SCALE SELECTED IS  ", GSCALE
2060 IF GSCALE <= 0 OR GSCALE > 4 THEN BEEP: GOTO 2025
2065 ON GSCALE GOSUB 2100, 2200, 2300, 2400     'SET PER GRAPH SCALE
2070 RETURN
2100 ' ****************************************************************
2105 ' * GOSUB 2100                                                   *
2110 ' * SET FOR 0 TO 1000 GRAPH SCALE                                *
2115 ' ****************************************************************
2120 '
2125 HDRA$ = "-1000"
2130 HDRB$ = " -500"
2135 HDRC$ = " +500"
2140 HDRD$ = "+1000"
2145 SCALE.FACTOR = .02
2150 RETURN
2200 ' ****************************************************************
2205 ' * GOSUB 2200                                                   *
2210 ' * SET FOR 0 TO 2000 GRAPH SCALE                                *
2215 ' ****************************************************************
2220 '
2225 HDRA$ = "-2000"
2230 HDRB$ = "-1000"
2235 HDRC$ = "+1000"
2240 HDRD$ = "+2000"
2245 SCALE.FACTOR = .01
2250 RETURN
2300 ' ****************************************************************
2305 ' * GOSUB 2300                                                   *
2310 ' * SET FOR 0 TO 4000 GRAPH SCALE                                *
2315 ' ****************************************************************
2320 '
2325 HDRA$ = "-4000"
2330 HDRB$ = "-2000"
2335 HDRC$ = "+2000"
2340 HDRD$ = "+4000"
2345 SCALE.FACTOR = 5.000001E-03
2350 RETURN
2400 ' ****************************************************************
2405 ' * GOSUB 2400                                                   *
2410 ' * SET FOR 0 TO 8000 GRAPH SCALE                                *
2415 ' ****************************************************************
2420 '
2425 HDRA$ = "-8000"
2430 HDRB$ = "-4000"
2435 HDRC$ = "+4000"
2440 HDRD$ = "+8000"
2445 SCALE.FACTOR = .0025
2450 RETURN
2500 ' ****************************************************************
2505 ' * GOSUB 2500                                                   *
2510 ' * SET END.NUM AND SKIP.NUM LIMITS                              *
2515 ' ****************************************************************
2520 '
2525 INPUT "INPUT LIMIT ON NUMBER OF RECS TO BE PROCESSED  ", END.NUM
2530 PRINT
2535 INPUT "SOME INITIAL RECORDS TO BE SKIPPED (Y/N)"; SKIP$
2540 PRINT
2545 IF SKIP$ <> "Y" AND SKIP$ <> "y" THEN GOTO 2570
2550 '
2555 INPUT "INPUT COUNT OF INITIAL RECORDS TO BE SKIPPED  ", SKIP.NUM
2560 GOTO 2580
2565 '
2570 SKIP.NUM = 0
2575 '
2580 RETURN
2700 ' ********************************************************
2705 ' * GOSUB 2700                                           *
2710 ' * SKIP NUMBER OF RECORDS SPECIFIED BY SKIP.NUM         *
2715 ' ********************************************************
2720 '
2730 FOR I = 1 TO SKIP.NUM
2735    IF EOF(2) THEN GOTO 230
2740    INPUT #2,I.DATE$,I.NEW.DOLLAR,I.DOLLAR.DLTA
2745    REC.CNT = REC.CNT + 1
2750    NEXT
2755 RETURN
3000 ' ****************************************************************
3002 ' * GOSUB 3000                                                   *
3004 ' * READ FILE, COMPILE GRAPH REC, AND WRITE GRAPH REC            *
3006 ' ****************************************************************
3007 '
3008 INPUT #2, I.DATE$,I.NEW.DOLLAR,I.DOLLAR.DLTA
3009 GWEEK$ = I.DATE$
3010 OLD.DOLLAR = I.NEW.DOLLAR - I.DOLLAR.DLTA
3012 GOSUB 3200                 'SET GRAPH PARAMETERS TO SCALE
3014 GOSUB 3300                 'PREPARE NEW GRAPH LINE
3016 PERCENT.NUMERATOR = I.DOLLAR.DLTA * 100
3018 IF OLD.DOLLAR <> 0 THEN PERCENT.DLTA = PERCENT.NUMERATOR / OLD.DOLLAR ELSE PERCENT.DLTA = 0
3020 GOSUB 3400                 'ROUND OFF PARAMETERS TO INTEGERS
3022 IF I.DOLLAR.DLTA = 0 THEN G$(21) = "*" ELSE GOSUB 3028
3024 GOSUB 3050                 'PLACE PERCENT DELTA ON G$ LINE
3025 GOSUB 3500                 'WRITE REC WITH G$ ELEMENTS
3026 GOSUB 3600                 'CLEAR G$ ELEMENTS TO SPACES
3027 RETURN
3028 I.DOLLAR.DLTA = I.DOLLAR.DLTA + 21
3030 IF I.DOLLAR.DLTA > 21 THEN GOSUB 3034 ELSE GOSUB 3042
3032 RETURN
3034 FOR N = 22 TO I.DOLLAR.DLTA
3036         G$(N) = "$"
3038         NEXT
3040 RETURN
3042 FOR N = I.DOLLAR.DLTA TO 20
3044         G$(N) = "#"
3046         NEXT
3048 RETURN
3050 PERCENT.DLTA = PERCENT.DLTA + 61
3051 G$(PERCENT.DLTA) = "*"
3052 RETURN
3200 ' ****************************************************************
3205 ' * GOSUB 3200                                                   *
3210 ' * SET GRAPH PARAMETERS TO SCALE                                *
3220 ' ****************************************************************
3225 '
3230 I.DOLLAR.DLTA = I.DOLLAR.DLTA * SCALE.FACTOR
3235 OLD.DOLLAR = OLD.DOLLAR * SCALE.FACTOR
3250 RETURN
3300 ' ****************************************************************
3305 ' * GOSUB 3300                                                   *
3310 ' * PREPARE G$ ELEMENTS FOR NEW REC                              *
3320 ' ****************************************************************
3325 '
3330 G$(1) = ":"
3335 G$(11) = ":"
3340 IF PRNT$ = "E" THEN G$(21) = CHR$(156) ELSE G$(21) = CHR$(179)
3345 G$(31) = ":"
3350 G$(41) = ":"
3355 G$(51) = ":"
3360 G$(56) = ":"
3365 IF PRNT$ = "E" THEN G$(61) = CHR$(156) ELSE G$(61) = CHR$(179)
3370 G$(66) = ":"
3375 G$(71) = ":"
3380 RETURN
3400 ' ****************************************************************
3405 ' * GOSUB 3400                                                   *
3410 ' * ROUND OFF PARAMETERS TO INTEGERS                             *
3420 ' ****************************************************************
3425 '
3430 I.DOLLAR.DLTA = CINT(I.DOLLAR.DLTA)
3435 PERCENT.DLTA = CINT(PERCENT.DLTA)
3440 RETURN
3500 ' ****************************************************************
3505 ' * GOSUB 3500                                                   *
3510 ' * WRITE LINE CONSISTING OF G$ ELEMENTS                         *
3515 ' ****************************************************************
3520 '
3525 LPRINT GWEEK$;G$(0);G$(1);G$(2);G$(3);G$(4);G$(5);G$(6);G$(7);G$(8);G$(9);G$(10);
3530 LPRINT G$(11);G$(12);G$(13);G$(14);G$(15);G$(16);G$(17);G$(18);G$(19);G$(20);
3535 LPRINT G$(21);G$(22);G$(23);G$(24);G$(25);G$(26);G$(27);G$(28);G$(29);G$(30);
3540 LPRINT G$(31);G$(32);G$(33);G$(34);G$(35);G$(36);G$(37);G$(38);G$(39);G$(40);
3545 LPRINT G$(41);G$(42);G$(43);G$(44);G$(45);G$(46);G$(47);G$(48);G$(49);G$(50);
3550 LPRINT G$(51);G$(52);G$(53);G$(54);G$(55);G$(56);G$(57);G$(58);G$(59);G$(60);
3555 LPRINT G$(61);G$(62);G$(63);G$(64);G$(65);G$(66);G$(67);G$(68);G$(69);G$(70);
3560 LPRINT G$(71)
3565 RETURN
3600 ' ****************************************************************
3605 ' * GOSUB 3600                                                   *
3610 ' * CLEAR G ELEMENTS TO SPACES                                   *
3615 ' ****************************************************************
3616 '
3618 GWEEK$ = "      "
3620 FOR GS = 1 TO 71
3630     G$(GS) = " "
3635     NEXT
3640 RETURN
4000 ' ****************************************************************
4005 ' * GOSUB 4000                                                   *
4010 ' * EOJ HOUSEKEEPING                                             *
4015 ' ****************************************************************
4020 '
4025 CLOSE #2
4027 LPRINT CHR$(12);
4030 PRINT "ALL DATA PROCESSED - PROGRAM ENDS"
4035 WIDTH "LPT1:",80
4040 ' RESTORE PRINTER TO DEFAULT CONFIGURATION
4045 IF PRNT$ = "E" THEN GOSUB 4200 ELSE GOSUB 4300
4070 RETURN
4099 ' ****************************************************************
4200 '*****************************************************************
4205 '*   SET EPSON PRINTER TO DEFAULT CONDITION                      *
4210 '*****************************************************************
4215 '
4220 LPRINT CHR$(27); CHR$(64);         'TURN OFF ALL SPCL PRINTER CODES
4225 RETURN
4300 '*****************************************************************
4305 '*   SET IBM PRINTER TO DEFAULT CONDITIONS                       *
4310 '*****************************************************************
4315 '
4320 LPRINT CHR$(20);                   'DOUBLE WIDTH CHAR OFF
4325 LPRINT CHR$(18);                   'COMPRESSED CHAR OFF
4330 LPRINT CHR$(27); CHR$(50);         'DEFAULT LINE SPACING (1/6")
4335 LPRINT CHR$(27); CHR$(55);         'CHAR SET #1 SELECTED
4340 LPRINT CHR$(27); CHR$(57);         'PAPER OUT SWITCH ENABLED
4345 LPRINT CHR$(27); CHR$(70);         'EMPHASIZED CHAR OFF
4350 LPRINT CHR$(27); CHR$(72);         'DOUBLE STRIKE OFF
4355 LPRINT CHR$(27); CHR$(79);         'IGNORE SKIPS OVER PERFS
4360 LPRINT CHR$(27); CHR$(85); CHR$(0);  'SELECT BIDIRECTIONAL PRINT
4365 LPRINT CHR$(27); CHR$(84);         'SUB/SUPERSCRIPT OFF
4370 LPRINT CHR$(27); CHR$(87); CHR$(0);  'DOUBLE WIDE CHAR OFF
4375 LPRINT CHR$(27); CHR$(45); CHR$(0);  'UNDERLINING OFF
4380 '
4385 RETURN
4390 '
4398 '*****************************************************************
$(0);  'UNDERLINING OFF
4380 '
4385 