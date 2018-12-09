10 ' PROGRAM NAME: DLTAPLOT.BAS       WRITTEN 7-16-83       REV 09-17-83
40 '
45 ' **********************************************************
50 ' * DRIVER MODULE                                          *
55 ' **********************************************************
65 '
70  CLS
75  KEY OFF
80  PRINT "PROGRAM DLTAPLOT.BAS EXECUTING"
82  PRINT
85  INPUT "PRINTER CONNECTED TO SYSTEM (Y/N)"; YPRINT$
90  REC.CNT = 0
95  OPEN "A:DRIVE.DTA" FOR INPUT AS #1
100 INPUT #1, DRIVE$,PRNT$
105 CLOSE #1
110 IF DRIVE$ = "A" OR DRIVE$ = "a" THEN GOSUB 300 ELSE GOSUB 400
115 IF YPRINT$ <> "Y" AND YPRINT$ <> "y" THEN GOTO 135
120 WIDTH "LPT1:",80
125 '  SET UP DEFAULT CONDITIONS FOR IBM OR EPSON PRINTER
130 IF PRNT$ = "E" OR PRNT$ = "e" THEN GOSUB 4100 ELSE GOSUB 4200
132 '
135 GOSUB 500                           'SELECT GSCALE
140 '
145 GOSUB 600                           'SELECT HSCALE
150 '
155 GOSUB 700                           'SET END.NUM AND SKIP.NUM LIMITS
160 '
165 GOSUB 800                           'READ FIRST (IDENTIFICATION) REC
170 '
175 IF SKIP.NUM <> 0 THEN GOSUB 900     'SKIP INITIAL RECORDS
180 '
185 CLS
190 GOSUB 1000                          'SET UP HEADERS AND AXES
195 '
200 IF REC.CNT < END.NUM THEN GOSUB 1500 ELSE GOTO 215    'PROCESS 1ST DATA REC
202 '
205 GOSUB 1700                          'PLOT BALANCE OF RECORDS
210 '
215 GOSUB 4000                          'EOJ HOUSEKEEPING
220 '
225 END
300 ' *******************************************************************
310 ' * GOSUB 300                                                       *
320 ' * GET DATA FROM DRIVE A                                           *
330 ' *******************************************************************
340 '
350 PRINT "INSERT DATA DISKETTE IN DRIVE A"
352 IF YPRINT$ <> "Y" AND YPRINT$ <> "y" THEN GOTO 365
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
452 IF YPRINT$ <> "Y" AND YPRINT$ <> "y" THEN GOTO 465
455 PRINT "SET PRINTER TO TOP OF PAGE"
460 PRINT "VERIFY THAT PRINTER IS ON"
465 PRINT "STRIKE ANY KEY WHEN READY"
470 A$ = INKEY$: IF A$ = "" THEN 470
480 OPEN "B:DLTAFILE.DTA" FOR INPUT AS #2
490 RETURN
500 ' **********************************************************
505 ' * GOSUB 500                                              *
510 ' * SELECT GSCALE                                          *
515 ' **********************************************************
520 '
525 PRINT "SELECT VERTICAL SCALE FROM FOLLOWING:"
530 PRINT "     1 - $0 TO $800 RANGE"
535 PRINT "     2 - $0 TO $1600 RANGE"
540 PRINT "     3 - $0 TO $4000 RANGE"
545 PRINT "     4 - $0 TO $8000 RANGE"
550 PRINT "     5 - $0 TO $16000 RANGE"
555 PRINT "     6 - $0 TO $32000 RANGE"
560 PRINT "     7 - $0 TO $64000 RANGE"
565 PRINT "     8 - $0 TO $128000 RANGE"
570 INPUT "VERTICAL SCALE SELECTED IS  ", GSCALE
575 IF GSCALE <= 0 OR GSCALE > 8 THEN BEEP: GOTO 525
577 '
580 ON GSCALE GOSUB 1200, 1225, 1250, 1275, 1300, 1325, 1350, 1375
590 '
595 RETURN
600 ' **********************************************************
605 ' * GOSUB 600                                              *
610 ' * SELECT HSCALE                                          *
615 ' **********************************************************
620 '
625 PRINT "SET HORIZONTAL SCALE - "
630 PRINT "    SELECT FROM 3 TO 10"
635 INPUT "    SCALE SELECTED IS  ", HSCALE
640 IF HSCALE < 3 OR HSCALE > 10 THEN BEEP: GOTO 625
660 '
665 RETURN
700 ' **********************************************************
705 ' * GOSUB 700                                              *
710 ' * SET END.NUM AND SKIP.NUM LIMITS                        *
715 ' **********************************************************
720 '
725 INPUT "INPUT LIMIT ON NUMBER OF RECS TO BE PROCESSED  ", END.NUM
730 PRINT
735 INPUT "SOME INITIAL RECORDS TO BE SKIPPED (Y/N)"; SKIP$
740 PRINT
745 IF SKIP$ <> "Y" AND SKIP$ <> "y" THEN GOTO 770
750 '
755 INPUT "INPUT COUNT OF INITIAL RECORDS TO BE SKIPPED  ", SKIP.NUM
760 GOTO 780
765 '
770 SKIP.NUM = 0
775 '
780 RETURN
800 ' ********************************************************
805 ' * GOSUB 800                                            *
810 ' * READ FIRST (IDENTIFICATION) RECORD                   *
815 ' ********************************************************
820 '
825 IF EOF(2) THEN GOTO 215
830     INPUT #2, I.FILE.TITLE$, I.FILE.OWNER$, I.FILE.UPDATE.DATE$
835 HDG1$ = I.FILE.OWNER$
870 RETURN
900 ' ********************************************************
905 ' * GOSUB 900                                            *
910 ' * SKIP NUMBER OF RECORDS SPECIFIED BY SKIP.NUM         *
915 ' ********************************************************
920 '
925 FOR I = 1 TO SKIP.NUM
930    IF EOF(2) THEN GOTO 215
935    INPUT #2, I.DATE, I.TDLR, I.DDLR
940    REC.CNT = REC.CNT + 1
945    NEXT
950 RETURN
1000 ' ********************************************************
1002 ' * GOSUB 1000                                           *
1004 ' * SET UP HEADERS AND AXES                              *
1006 ' ********************************************************
1008 '
1010 SCREEN 2,,0,0
1014 LOCATE 6,1
1016 PRINT "D"
1018 LOCATE 7,1
1020 PRINT "E"
1022 LOCATE 8,1
1024 PRINT "L"
1026 LOCATE 9,1
1028 PRINT "T"
1030 LOCATE 10,1
1032 PRINT "A"
1040 '
1042 LOCATE 25,70
1044 PRINT "PERIOD"
1050 '
1052 LOCATE 1,1
1054 PRINT HDG1$
1060 '
1062 LOCATE 1,30
1064 PRINT "PORTFOLIO VALUE CHANGES"
1070 '
1072 LOCATE 1,65
1074 PRINT DATE$
1080 '
1082 LOCATE 3,30
1084 PRINT "MAX DELTA "
1090 '
1092 LOCATE 3,40
1094 PRINT SF.HDR$
1100 '
1105 LINE (20,20)-(20,190)
1110 '   SET COL 20 TICK MARKS (EVERY 5TH ROW)
1115 FOR A = 20 TO 190 STEP 5
1120    LINE (18,A)-(22,A)
1125    NEXT A
1130 LINE (20,180)-(620,180)
1135 '   SET ROW 20 TICK MARKS (INTERVAL SPECIFIED BY HSCALE)
1140 FOR B = 20 TO 620 STEP HSCALE
1145    LINE (B,178)-(B,182)
1150    NEXT B
1155 '
1195 RETURN
1200 ' ********************************************************
1205 ' GOSUB 1200 - GSCALE = 1
1210 SF = .2
1215 SF.HDR$ = "$800"
1220 RETURN
1225 ' ********************************************************
1230 ' GOSUB 1225 - GSCALE = 2
1235 SF = .1
1240 SF.HDR$ = "$1,600"
1245 RETURN
1250 ' ********************************************************
1255 ' GOSUB 1250 - GSCALE = 3
1260 SF = .04
1265 SF.HDR$ = "$4,000"
1270 RETURN
1275 ' ********************************************************
1280 ' GOSUB 1275 - GSCALE = 4
1285 SF = .02
1290 SF.HDR$ = "$8,000"
1295 RETURN
1300 ' ********************************************************
1305 ' GOSUB 1300 - GSCALE = 5
1310 SF = .01
1315 SF.HDR$ = "$16,000"
1320 RETURN
1325 ' ********************************************************
1330 ' GOSUB 1325 - GSCALE = 6
1335 SF = 5.000001E-03          '.005 SCALE FACTOR
1340 SF.HDR$ = "$32,000"
1345 RETURN
1350 ' ********************************************************
1355 ' GOSUB 1350 - GSCALE = 7
1360 SF = .0025
1365 SF.HDR$ = "$64,000"
1370 RETURN
1375 ' ********************************************************
1380 ' GOSUB 1375 - GSCALE = 8
1385 SF = .00125
1390 SF.HDR$ = "$128,000"
1395 RETURN
1400 ' ********************************************************
1405 ' * GOSUB 1400                                           *
1410 ' * PRINT GRAPH POINTS AND INTERCONNECT W/LINES          *
1415 ' ********************************************************
1420 '
1425 LINE (OLD.C,OLD.R)-(NEW.C,NEW.R)
1430 OLD.C = NEW.C
1435 OLD.R = NEW.R
1440 NEW.C = NEW.C + HSCALE
1445 RETURN
1500 ' ********************************************************
1505 ' * GOSUB 1500                                           *
1510 ' * PROCESS FIRST DATA RECORD                            *
1515 ' ********************************************************
1520 '
1525 IF EOF(2) THEN GOTO 215
1530     INPUT #2, I.DATE, I.TDLR, I.DDLR
1535 REC.CNT = REC.CNT + 1
1540 OLD.C = 20
1545 OLD.R = 180
1550 NEW.C = OLD.C + HSCALE
1555 DDLR = I.DDLR * SF
1560 DDLR = CINT(DDLR)
1565 NEW.R = OLD.R - DDLR
1575 GOSUB 1400              'PRINT GRAPH POINTS AND INTERCONNECT W/LINES
1580 RETURN
1700 ' *********************************************************
1705 ' * GOSUB 1700                                            *
1710 ' * PLOT PORTFOLIO DOLLAR TOTALS AGAINST WEEKS            *
1715 ' *********************************************************
1720 '
1725 END.NUM = END.NUM - REC.CNT
1730 FOR I = 1 TO END.NUM
1735     IF EOF(2) THEN GOTO 1770
1740     INPUT #2, I.DATE, I.TDLR, I.DDLR
1750     DDLR = I.DDLR * SF
1755     DDLR = CINT(DDLR)
1760     NEW.R = OLD.R - DDLR
1765     GOSUB 1400              'PRINT GRAPH POINTS AND INTERCONNECT W/LINES
1768     NEXT
1769 '
1770 CLOSE #2
1780 SOUND 1760,9:SOUND 1046.5,9:SOUND 659.26,9:SOUND 440,9:SOUND 261.63,9:SOUND 164.81,9:SOUND 32767,9
1790 R$ = INKEY$: IF R$ = "" THEN 1790
1792 '
1795 RETURN
4000 ' **********************************************************
4005 ' * GOSUB 4000                                             *
4010 ' * EOJ HOUSEKEEPING                                       *
4015 ' **********************************************************
4020 '
4025 SCREEN 0,0,0,0
4030 PRINT "ALL DATA PROCESSED - PROGRAM ENDS"
4060 KEY ON
4065 RETURN
4100 '***********************************************************
4105 '*   SET EPSON PRINTER TO DEFAULT CONDITION                *
4110 '***********************************************************
4115 '
4120 LPRINT CHR$(27); CHR$(64);         'TURN OFF ALL SPCL PRINTER CODES
4125 RETURN
4200 '***********************************************************
4205 '*   SET IBM PRINTER TO DEFAULT CONDITIONS                 *
4210 '***********************************************************
4215 '
4220 LPRINT CHR$(20);                   'DOUBLE WIDTH CHAR OFF
4225 LPRINT CHR$(18);                   'COMPRESSED CHAR OFF
4230 LPRINT CHR$(27); CHR$(50);         'DEFAULT LINE SPACING (1/6")
4235 LPRINT CHR$(27); CHR$(55);         'CHAR SET #1 SELECTED
4240 LPRINT CHR$(27); CHR$(57);         'PAPER OUT SWITCH ENABLED
4245 LPRINT CHR$(27); CHR$(70);         'EMPHASIZED CHAR OFF
4250 LPRINT CHR$(27); CHR$(72);         'DOUBLE STRIKE OFF
4255 LPRINT CHR$(27); CHR$(79);         'IGNORE SKIPS OVER PERFS
4260 LPRINT CHR$(27); CHR$(85); CHR$(0);  'SELECT BIDIRECTIONAL PRINT
4265 LPRINT CHR$(27); CHR$(84);         'SUB/SUPERSCRIPT OFF
4270 LPRINT CHR$(27); CHR$(87); CHR$(0);  'DOUBLE WIDE CHAR OFF
4275 LPRINT CHR$(27); CHR$(45); CHR$(0);  'UNDERLINING OFF
4280 '
4285 RETURN
4290 '
4295 '***********************************************************
); CHR$(0);  'UNDERLINING OFF
4280 '
4285 RETURN
4290 '
4295 '************************