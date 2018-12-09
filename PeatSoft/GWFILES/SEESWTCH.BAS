10 KEY OFF:CLS
20 PRINT"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
30 PRINT"°ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿°"
40 PRINT"°³                                   ³°"
50 PRINT"°³            7019-A.BAS             ³°"
60 PRINT"°³       SCROLL  DEMONSTRATION       ³°"
70 PRINT"°³                                   ³°"
80 PRINT"°³                                   ³°"
90 PRINT"°³ BROUGHT TO YOU BY THE MEMBERS OF  ³°"
100 PRINT"°³      ÜÜÜÜÜ ÜÜÜÜÜ ÜÜÜÜÜ ÜÜÜÜÜ      ³°"
110 PRINT"°³        Û   Û   Û Û     Û   Û      ³°"
120 PRINT"°³        Û   ÛÜÜÜÛ Û     Û   Û      ³°"
130 PRINT"°³        Û   Û     Û     Û   Û      ³°"
140 PRINT"°³      ÜÜÛÜÜ Û     ÛÜÜÜÜ ÛÜÜÜÛ      ³°"
150 PRINT"°³                                   ³°"
160 PRINT"°³      International PC Owners      ³°"
170 PRINT"°³                                   ³°"
180 PRINT"°³P.O. Box 10426, Pittsburgh PA 15234³°"
190 PRINT"°³                                   ³°"
200 PRINT"°ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ°"
210 PRINT"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
220 PRINT
230 PRINT "       PRESS ANY KEY TO CONTINUE
240 A$=INKEY$: IF A$="" THEN 240
250 CLS
1000 '***************************************************
1010 '***   SPC CORPORATION                           ***     Compliments of
1020 '***   PO BOX 9038                               ***    UTAH BLUE CHIPS
1030 '***   OGDEN, UT 84409                           ***   IBM PC Users Group
1040 '***                                             ***
1050 '***   THIS SOFTWARE IS AVAILABLE FOR COPY AND   ***     December 1982
1060 '***   USE IN THE PUBLIC DOMAIN.                 ***
1070 '***************************************************
1080 '******************************************************
1090 '***   READ AND DECODE THE SYSTEM OPTION SWITCHES   ***
1100 '******************************************************
1110 '**********************************
1120 '***   ESTABLISH OPTION MASKS   ***
1130 '**********************************
1140 MASK.DISK = &HC0
1150 MASK.DISK.IPL = &H1
1160 MASK.DISPLAY = &H30
1170 MASK.MEMORY.2 = &HF
1180 MASK.MEMORY.1 = &HC
1190 '*********************************
1200 '***   SET UP PORT ADDRESSES   ***
1210 '*********************************
1220 PORT.A = &H60
1230 PORT.B = &H61
1240 PORT.C = &H62
1250 '*****************************
1260 '***   READ THE SWITCHES   ***
1270 '*****************************
1280 OUT PORT.B,&H84 : 'SET CONTROL REGISTER TO READ SWITCHES
1290 SWITCH.1 = INP(PORT.A)
1300 SWITCH.2 = INP(PORT.C)
1310 OUT PORT.B,&H40 : 'SET CONTROL REGISTER TO READ KEYBOARD
1320 '*************************************************************************
1330 '**  DECODE SWITCH 1 FOR MEMORY SIZE, NUMBER OF DISKS, AND DISPLAY TYPE **
1340 '**  IF MEMORY SIZE =>65536 THEN CHECK SWITCH 2 FOR MEMORY SIZE.        **
1350 '*************************************************************************
1360 MEMORY.SIZE# = SWITCH.1 AND MASK.MEMORY.1
1370 MEMORY.SIZE# = (1# + MEMORY.SIZE#/ 2^2) * 16384#
1380 IF MEMORY.SIZE# < 65535# THEN 1400
1390 MEMORY.SIZE# = MEMORY.SIZE# + ( SWITCH.2 AND MASK.MEMORY.2 ) * 32768#
1400 IF MASK.DISK.IPL AND SWITCH.1 THEN						    NUMBER.OF.DISKS = 1 + (SWITCH.1 AND MASK.DISK) / 2^6
1410 DISPLAY.TYPE = ( SWITCH.1 AND MASK.DISPLAY ) /2^4
1420 '**********************************************
1430 '***   DISPLAY THE RESULTS IN HUMAN TERMS   ***
1440 '**********************************************
1450 DATA "RESERVED DISPLAY TYPE"
1460 DATA "A COLOR DISPLAY INTERFACE. 40 CHARACTERS BY 25 LINES."
1470 DATA "A COLOR DISPLAY INTERFACE. 80 CHARACTERS BY 25 LINES."
1480 DATA "AN IBM MONOCHROME DISPLAY. 80 CHARACTERS BY 25 LINES."
1490 FOR I=0 TO 3 : READ DISPLAY.OPTION$(I) : NEXT I
1500 CLS
1510 PRINT "Switch settings for this IBM Personal Computer indicate:"
1520 PRINT " ";DISPLAY.OPTION$(DISPLAY.TYPE)
1530 PRINT NUMBER.OF.DISKS;"- 5 1/4 INCH DISK DRIVES."
1540 PRINT MEMORY.SIZE#;"(";MEMORY.SIZE#/1024#;"K ) BYTES RANDOM ACCESS MEMORY."
NUMBER.OF.DISKS;"- 5 1/4 INCH DISK DRIVES."
1540 PRINT MEMORY