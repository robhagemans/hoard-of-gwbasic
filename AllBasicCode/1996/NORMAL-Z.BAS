100  '**********************************************************************
110  '********                                                   ***********
120  '********           NORMAL DISTRIBUTION ROUTINES            ***********
130  '********                                                   ***********
140  '**********************************************************************
150  '            *   COPYRIGHT 1982 - CRAIG W. UTHE          *
160  '            *   WRITTEN 3/3/82 BY CRAIG W. UTHE         *
170  '            *                 * * * *                   *
180  '            *   ANY INDIVIDUAL MAY COPY THIS PROGRAM    *
190  '            *   AND MAKE MODIFICATIONS TO IT IF THAT    *
200  '            *   INDIVIDUAL ARRANGES TO CONTRIBUTE ONE   *
210  '            *   OTHER PROGRAM TO THE PHILA. AREA IBM    *
215  '            *   PC USER GROUP PUBLIC DOMAIN SOFTWARE    *
220  '            *   EXCHANGE LIBRARY.  HOWEVER, COPIES      *
230  '            *   ARE NOT ALLOWED TO BE SOLD, NOT IN      *
240  '            *   WHOLE NOR IN PART, NOT SEPARATELY       *
250  '            *   NOR JOINTLY WITH OTHER SOFTWARE.        *
260  '            *********************************************
270  '
280  '
1000 'MASTER-CONTROL ROUTINE
1010     CLS
1020     PRINT "This program computes areas under the normal distribution"
1030     PRINT "probability curve from the mean to a designated `Z' value."
1040     PRINT "This program also can compute `Z' values from a given area."
1050     PRINT
1060     PRINT "Just as in most statistical tables, only half the curve is
1070     PRINT "considered.  Z values must be between -4 and +4 (these"
1080     PRINT "limits are somewhat arbitrary) and area figures must be"
1090     PRINT "between 0 and 0.5 (actually .49997).  If out-of-range"
1100     PRINT "figures are input, the nearest range limit is assumed"
1110     PRINT "instead."
1120     PRINT
1130     PRINT "HIT ANY KEY TO START"
1140     SELECTION$ = INKEY$ : IF SELECTION$ = "" THEN GOTO 1140 'SAME LINE
1150     ' Area results (given Z) are accurate to the 5 displayed digits.
1160     ' Z values are accurate to 2 digits based on an input area,
1170     ' or the 3 displayed digits based on the program's approximation
1180     ' of that area.
1190     '
1200     ' This precision can be changed by changing the precision
1210     ' constants in the program from their 0.000001 setting.
1220     ' For higher precision, you might also want to change the
1230     ' variables to double, instead of single, precision form.
1240     ' With higher precision, you may wish to change the number
1250     ' of digits displayed, too.
1260     '
1270     ' Out of respect, please do not mutilate the structured
1280     ' programming approach that makes changes so easy and
1290     ' makes the program almost readable.  Of course you can
1300     ' easily use the subroutines in more elaborate programs.
1310     ' This program is fairly insignificant by itself.
1320     '
1330     SELECTION$ = "1" 'initialization
1340     WHILE (SELECTION$ = "1" OR SELECTION$ = "2")
1350         CLS : PRINT STRING$(60,42)
1360         PRINT : PRINT "MENU:"
1370         PRINT : PRINT "     <1> . . . . . . . . COMPUTE AREA FROM Z"
1380         PRINT : PRINT "     <2> . . . . . . . . COMPUTE Z VALUE FROM AREA"
1390         PRINT : PRINT "     <ANY OTHER KEY> . . EXIT PROGRAM"
1400         PRINT : PRINT STRING$(60,45)
1410         PRINT : PRINT "HIT ANY KEY IN INDICATED RANGE TO MAKE SELECTION:"
1420         SELECTION$ = INKEY$ : IF SELECTION$ = "" THEN GOTO 1420 'SAME LINE
1430         CLS : PRINT "THANK YOU."
1440         IF 0 = INSTR("12",SELECTION$)                                                       THEN : PRINT "I HOPE THE PROGRAM WAS USEFUL TO YOU.  BYE."                             : GOTO 1480 'WEND
1450         ON INSTR("12",SELECTION$) GOSUB 3000,2000
1460             'IE:  IF 1, GOSUB COMPUTE-Z-FROM-AREA ROUTINE
1470             '     IF 2, GOSUB COMPUTE-AREA-FROM-Z ROUTINE
1480         WEND
1490     END
1500 '
1510 '
2000 'COMPUTE-Z-FROM-AREA ROUTINE
2010     PRINT : PRINT STRING$(80,42) : PRINT
2020     QUIT% = 0
2030     WHILE NOT QUIT%
2040            PRINT "INPUT AREA VALUE FROM WHICH TO COMPUTE FREQUENCY."
2050            PRINT "(ENTRIES OVER 5.0 CAUSE RETURN TO MENU.)"
2060            INPUT "INPUT AREA VALUE (0 TO 0.49997): ",AREA
2070            IF AREA > 5 THEN QUIT% = -1 : GOTO 2230 'WEND
2080            HI.CALCULATED.AREA = .49997 : HI.Z = 4  '*** area < .49997
2090            LO.CALCULATED.AREA = 0      : LO.Z = 0  '*** area > 0
2100            IF AREA >= .49997 THEN CALCULATED.AREA = .49997 : Z = 4                                                 : GOTO 2170
2110            IF AREA <= 0 THEN CALCULATED.AREA = 0 : Z = 0 : GOTO 2170 'PRNT
2120            WHILE ABS(CALCULATED.AREA - AREA) > .000001
2130                    IF AREA > CALCULATED.AREA                                                          THEN LO.CALCULATED.AREA = CALCULATED.AREA : LO.Z = Z                            ELSE HI.CALCULATED.AREA = CALCULATED.AREA : HI.Z = Z
2140                    Z = (LO.Z + HI.Z) / 2
2150                    GOSUB 4000 'McLAUREN-METHOD-AREA-CALCULATION ROUTINE
2160                    WEND
2170            PRINT : PRINT "THE NORMAL-DISTRIBUTION Z-VALUE CORRESPONDING"
2180                    PRINT "TO A MEAN-TO-Z AREA OF ";
2190                    PRINT USING "#.#####"; CALCULATED.AREA;
2200                    PRINT " is:  ";
2210                    PRINT USING "#.###"; Z
2220            PRINT : PRINT STRING$(80,42) : PRINT
2230            WEND
2240     RETURN
2250 '
3000 'COMPUTE-AREA-FROM-Z ROUTINE
3010     PRINT : PRINT STRING$(80,42) : PRINT
3020     QUIT% = 0
3030     WHILE NOT QUIT%
3040            PRINT "INPUT Z VALUE FROM WHICH TO COMPUTE FREQUENCY."
3050            PRINT "(ENTRIES OVER 5.0 CAUSE RETURN TO MENU.)"
3060            INPUT "INPUT Z VALUE (-4.0 TO +4.0):  ", Z
3070            IF Z >= 5 THEN QUIT% = -1 : GOTO 3150 'WEND
3080            IF ABS(Z) >= 4 THEN CALCULATED.AREA = .49997 : Z.SGN% = SGN(Z)                                  : Z = 4 :GOTO 3100 'PRINT OUTPUT
3090            GOSUB 4000 'McLAUREN-METHOD-AREA-CALCULATION ROUTINE
3100            PRINT :PRINT "THE AREA UNDER THE NORMAL DISTRIBUTION CURVE"
3110                    PRINT "FROM THE MEAN TO Z = " Z.SGN%*Z " IS:  ";
3120                    PRINT USING "#.#####"; CALCULATED.AREA
3130            PRINT
3140            PRINT : PRINT STRING$(80,42) : PRINT
3150            WEND
3160     RETURN
3170 '
4000 'McLAUREN-METHOD-AREA-CALCULATION ROUTINE
4010     '
4020     Z.SGN% = SGN(Z) : Z = ABS(Z) : Z.SQR = Z*Z
4030     CALCULATED.AREA = Z * (1/SQR(2*3.141592654#))
4040     Z.CONSTANT = CALCULATED.AREA
4050     PRECISION.ERROR = 1 : INTERMEDIATE.TERM = 1 : I% = 1
4060     '
4070     WHILE ABS(PRECISION.ERROR) > .000001
4080            INTERMEDIATE.TERM = -(INTERMEDIATE.TERM * Z.SQR) / (2*I%)
4090            PRECISION.ERROR = Z.CONSTANT * (INTERMEDIATE.TERM / (2*I% + 1))
4100            CALCULATED.AREA = CALCULATED.AREA + PRECISION.ERROR
4110            I% = I% + 1
4120            WEND
4130            CALCULATED.AREA = CALCULATED.AREA - PRECISION.ERROR
4140     RETURN
