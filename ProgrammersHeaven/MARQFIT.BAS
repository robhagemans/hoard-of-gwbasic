1 ' PROGRAM MARQFIT.BAS -- a non-linear least squares fitting
2 ' routine using the marquardt algorithm
5 ' (c) 1985 W. Schreiner, M. Kramer, S. Krischer, & Y. Langsam
20  '-------------- initialize program settings ---------------
30  REV = 2.1 : PI = 3.14159265#
40  ON ERROR GOTO 19000 : RETCOD = 0 :KEY OFF
60  DEF SEG=64:POKE 23,(PEEK(23) OR 64): DEF SEG 'set caps lock
65  ' The values MXVAR%, MXOBS% and MDI% can be changed-
70  ' be sure to change the DIM sizes correspondingly
80  MXVAR% = 30:MXOBS% = 500 : MDI% = MXVAR% * (MXVAR% + 1) / 2
90  DIM X(500),DTA(500),WGT(500),FXP(500),FYP(500),XP(500)
100 DIM YP(500),C(465),A(465),B(30),DPARM(30),PARM(30),                                 KFIX(30),DERIV(30),G(30),GRAD(30)
110 DEF FNLGT(X) = LOG(X)/LOG(10)
120 ON KEY(1) GOSUB 10200 : ON KEY(2) GOSUB 10300
130 ON KEY(3) GOSUB 10310 : ON KEY(4) GOSUB 10400
140 KEY(1) ON : KEY(2) ON : KEY(3) ON : KEY(4) ON
160   FG=2:BG=0:FG1=14:BG1=0:FG2=4:BG2=0 ' color attributes
165 FOR I = 1 TO MXOBS% : WGT(I) = 1 : NEXT
190 ' ---------------plot routine initialization
200 PLOTSET% = 0 ' plot definition flag
210 XTOTAL.PIX = 639: YTOTAL.PIX = 199
220 ' (for lo_res use XTOTAL.PIX = 319)
230 ' XMIN.PIX is lower left hand xmin in pixel coords;
240 ' YMIN.PIX is lower left hand ymin in pixel coords;
250 ' XMIN and YMIN are the same but in USER coordinates
260 XMIN.PIX=CINT(.11*XTOTAL.PIX): XMAX.PIX=.94*XTOTAL.PIX
270 YMAX.PIX=CINT(.07*YTOTAL.PIX)-2: YMIN.PIX=YTOTAL.PIX-12
280 DELTAX.PIX = XMAX.PIX-XMIN.PIX+1
290 DELTAY.PIX = YMIN.PIX-YMAX.PIX+1
310 ' functions to convert X & Y in user coords --> pixel coords
320 DEF FNSX(N)=XMIN.PIX + CINT((N-XMIN)*DELTAX.PIX/(XMAX-XMIN))
330 DEF FNSY(N)=YMIN.PIX - CINT((N-YMIN)*DELTAY.PIX/(YMAX-YMIN))
335 ' ------------------------start up--------------------------
340 IPFLG = 0    ' pause-in-fitting flag
350 ISVFL =  - 1 ' data saved flag
360 CLS : LOCATE 10 : COLOR FG2,BG2 :                                               PRINT TAB(15) "MARQUARDT LEAST SQUARES - REV ";REV:
365 COLOR FG,BG : FOR I = 1 TO 1700: NEXT:LOCATE 20
370 INPUT "USE DATA ON DRIVE (ENTER LETTER):";DRV$:                                 DRV$ =LEFT$(DRV$,1) : IF DRV$ <> "" THEN DRV$=DRV$+":"
380  GOTO 420
390 ' -----------------------   menu  --------------------------
400 PRINT "PRESS ANY KEY TO CONTINUE":WHILE INKEY$ = "":WEND
410 RETCOD = 0 ' reset error flag
420 F1%=0:SCREEN 0 :CLS: GOSUB 10000: COLOR FG2,BG: LOCATE 1,20
425 PRINT "MENU OPTIONS:": COLOR FG,BG : PRINT:COLOR FG1,BG1
430 PRINT TAB(6) "GENERAL:";:COLOR FG,BG
435 PRINT TAB(21) "1- ENTER TITLE " 'line  800
440 PRINT  TAB(21) "2- PRINTER ";   'line  850
450 IF PFLG% = 0 THEN PRINT "ON/";:COLOR FG1,BG1:PRINT  "OFF":                      COLOR FG,BG ELSE COLOR FG1,BG1: PRINT "ON";: COLOR FG,BG :                      PRINT  "/OFF"
460  PRINT  TAB(21) "3- SOLVE "      'line  900
470  PRINT  TAB(21) "4- PLOT "       'line  15000
480  PRINT  TAB(21) "5- QUIT "       'line  1300
490  PRINT  : COLOR FG1,BG1:PRINT  "     ENTER DATA:";:                              COLOR FG,BG:PRINT TAB(21) "6- MANUAL" 'line 1400
500  PRINT  TAB(21) "7- UREAD"       'line 1800
510  PRINT
520  COLOR FG1,BG1:PRINT  "     MODIFY DATA:";:COLOR FG,BG:                          PRINT TAB(21) "8- EDIT"         'line 2000
530  PRINT  TAB(21) "9- SCALE"       'line  2200
540  PRINT  TAB(20) "10- ZERO"       'line  2400
550  PRINT:COLOR FG1,BG1:PRINT "     PARAMETERS:";:COLOR FG,BG:                      PRINT TAB(20) "11- ENTER/REVIEW/CHANGE"     'line 2500
570  PRINT  "                   12- FIX"         'line  2800
580  PRINT  "                   13- FREE"        'line  3000
590  PRINT
600  COLOR FG1,BG1:PRINT  "     DATA & PARAM: ";:COLOR FG,BG:                        PRINT "14- LIST "     ' line 3200
610  PRINT  "                   15- SAVE ON DISK" 'line 3400
620  PRINT  "                   16- READ FROM DISK" 'line 3600
630  COLOR 15,BG: INPUT; "ENTER CHOICE";KMND:COLOR FG,BG:PRINT
650  ON KMND+1 GOTO 420,800,850,900,15000,1300,1400,1800,2000,                       2200,2400,2500,2800,3000,3200,3400,3600
660  PRINT  "*** ERROR *** ";KMND;" INVALID COMMAND": GOTO 400
800 'enter a title for documentation ---------------------------
810 INPUT "ENTER TITLE: ";TITL$:LOCATE 25,1:PRINT TITL$;SPC(11)
820  GOTO 420
850 'toggle printer on/off -------------------------------------
860 PFLG% = 1 - PFLG%: GOTO 420
900 'solve the mrqdt non-linear lst sq fit problem -------------
920 ITER% = 0 : IF IPFLG <  > 0 THEN ITER% = NITER%
930 IPFLG = 0:ISVFL = 0 : CLS : GOSUB 10000
940 INPUT "HOW MANY ITERATIONS?  ";MXITER%
950 IF MXITER% < 0 THEN MXITER% = 0
960 GOSUB 6000 ' go fit !
970 IPFLG =  - 1 : NITER% = NITER% + ITER%
990 PRINT:PRINT: PRINT TITL$ :PRINT NITER%;" ITERATIONS": PRINT
1000 IF PFLG% = 1 THEN LPRINT:LPRINT TITL$                                            :LPRINT NITER%;" iterations "
1010 GOSUB 9000
1020 IF FLG%=1 THEN PRINT:PRINT "CHOLESKY NEGATIVE DIAGONAL--";                            "UNABLE TO  SOLVE WITH SUPPLIED INITIAL PARAMETERS"
1030 PRINT  : PRINT  "PRESS ANY KEY FOR FITTING STATISTICS"
1040 WHILE INKEY$ = "" : WEND
1050 GOSUB 1100 : PRINT : GOTO 400 'print statistics and return
1070 'print fit statistics -------------------------------------
1100 PRINT  : PRINT  "SOME FITTING STATISTICS:"
1110 PRINT "SIGMA= ";SIG;" R= ";R;: PRINT TAB( 41);                                                                    "WGT'D SUM OF SQ. = ";WSS
1120 CHI2 =  INT (10 * CHI2) / 10
1130 PRINT  "CHI SQUARED= ";CHI2;" / ";NF;" DEG OF FREEDOM"
1140 PRINT  "# OF CALLS TO SUM OF SQ=";NSSC;:                                             PRINT TAB( 41);"# OF DERIV CALLS=";NDC:                                         PRINT  "# INC IN LAMBDA=";INCR;" LAMBDA= ";LAMBDA
1150 IF PFLG% <> 1 THEN RETURN
1160 LPRINT : LPRINT  "SOME FITTING STATISTICS:"
1170 LPRINT  "SIGMA= ";SIG;" R= ";R;:                                                 LPRINT TAB( 41);"WGT'D SUM OF SQ. = ";WSS
1180 LPRINT  "CHI SQUARED= ";CHI2;" / ";NF;" DEG OF FREEDOM"
1190 LPRINT "# OF CALLS TO SUM OF SQ=";NSSC;:                                        LPRINT   TAB( 41);"# OF DERIV CALLS=";NDC:                                      LPRINT  "# INC IN LAMBDA=";INCR;" LAMBDA= ";LAMBDA
1200 RETURN
1300 'quit -----------------------------------------------------
1310  IF ISVFL <  > 0 THEN 1360
1320  INPUT "PRESENT DATA NOT SAVED. SAVE IT?? (Y/N)";T1$
1330  IF  LEFT$ (T1$,1) = "Y" THEN 3400 'go save
1340  IF  LEFT$ (T1$,1) <> "N" THEN 420
1360  DEF SEG=64:POKE 23,(PEEK(23) AND 191):DEF SEG 'clear caps
1370  CLS: END
1400  'manual data entry ---------------------------------------
1410  PRINT  "MANUAL DATA ENTRY - ": PRINT  "   (, TO EXIT)"
1412 ' set flags to indicate data points that currently exist
1415 FOR K=1 TO NOBS%:XP(K)=1:NEXT :                                                  FOR K = NOBS%+1 TO MXOBS%:XP(K)=0:NEXT
1420 PRINT  "POINT    X,MEASUREMENT"
1425 PRINT  "===== ====,==========="
1430 FOR I = 1 TO MXOBS%
1440    PRINT  I;: INPUT " ";T1$,T2$
1450    IF T1$ = "" THEN NOBS% = I - 1: GOTO 1480
1460    X(I) =  VAL (T1$):DTA(I) =  VAL (T2$) :XP(I) = 1
1470 NEXT
1480 INPUT "WEIGHTS-ENTER 'NO','STAT' OR 'EXPLICIT'?";T1$
1490 IF T1$ = "NO" THEN FOR I=1 TO NOBS%:WGT(I)=1:NEXT:GOTO 1580
1500 IF T1$ = "STAT" THEN                                                              FOR I = 1 TO NOBS%: WGT(I)=SQR (DTA(I)): NEXT : GOTO 1580
1510 IF T1$ <  > "EXPLICIT" GOTO 1480
1520 PRINT  : PRINT  "POINT     X      Y      WEIGHT":                                        PRINT  "=====   =====  =====    ======"
1530 FOR I = 1 TO NOBS%
1540     PRINT  I;"     ";X(I);"    ";DTA(I);"     ";WGT(I);
1550     INPUT "New Weight=";WGT$:IF WGT$="" THEN 1570
1560     WGT(I) = VAL(WGT$)
1570 NEXT
1580 NOBS% = 0 : PRINT  "NOW ORDERING & REVIEWING DATA"
1600 FOR I = 1 TO MXOBS%
1610    IF XP(I) = 0 GOTO 1650  'zero it if pt is to be deleted
1620    NOBS% = NOBS% + 1
1630    X(NOBS%) = X(I):DTA(NOBS%) = DTA(I):WGT(NOBS%) = WGT(I)
1640    IF I <  > NOBS% THEN XP(I) = 0
1650 NEXT
1680 IPFLG = 0:ISVFL = 0 : GOTO 420
1800 'user defined read routine --------------------------------
1810 PRINT "NO USER DEFINED ROUTINE IMPLEMENTED"
1820 GOTO 400
2000 'edit data ------------------------------------------------
2005 FOR K=1 TO NOBS%:XP(K)=1:NEXT
2010 FOR K = NOBS%+1 TO MXOBS%:XP(K)=0:NEXT
2015 PRINT "ENTER 'W' TO CHANGE ONLY WEIGHTS,";:                                                      INPUT "'D' TO CHANGE DATA & WEIGHTS";T1$
2020 IF T1$ = "W" GOTO 1480
2030 PRINT "ENTER DATA PT RANGE FOR EDITING (N1,N2)"
2040 INPUT "(, TO EXIT)";T1$,T2$
2050 IF T1$ = "" GOTO 1580
2060 I =  VAL (T1$):J =  VAL (T2$)
2070 IF I<1 OR J>MXOBS% THEN PRINT "INVALID RANGE":GOTO 2030
2080 FOR K = I TO J
2090     PRINT  "CURRENT VALUE OF X,DTA,WGT FOR PT #";K;" =":                               PRINT X(K);"  ";DTA(K);"  ";WGT(K)
2100     PRINT  "ENTER NEW VALUE FOR X(";K;")"
2105     PRINT "(ENTER 'D' TO DELETE PT, OR 'enter' ";:                                  INPUT "TO LEAVE UNCHANGED)";T1$
2110     IF T1$ = "D" THEN XP(K) = 0: GOTO 2150
2120     IF T1$ = "" THEN 2150
2130     X(K) =  VAL (T1$) : XP(K) = 1
2140     INPUT "ENTER NEW VALUES FOR DTA,WGT ";DTA(K),WGT(K)
2150 NEXT
2160 GOTO 2030
2200 'scale x,dta,wgt --------------------------------------
2210 INPUT "ENTER X-COORDINATE SCALE FACTOR";XSCALE
2220 INPUT "ENTER DATA POINT SCALE FACTOR";DSCALE
2230 INPUT "ENTER WEIGHT SCALE FACTOR";WSCALE
2240 FOR I = 1 TO NOBS%
2250 X(I)=X(I)*XSCALE:DTA(I)=DTA(I)*DSCALE:WGT(I)=WGT(I)*WSCALE
2280 NEXT
2290 IPFLG = 0:ISVFL = 0 : GOTO 420
2400 'zero data & parameters -----------------------------------
2410 FOR I=1 TO MXOBS%:X(I)=0:DTA(I)=0:WGT(I)=0:NEXT:NOBS% = 0
2420 FOR I=1 TO MXVAR%:PARM(I)=0:DPARM(I) = 0: NEXT :NPRM% = 0
2430 IPFLG = 0:ISVFL =  - 1 : GOTO 420
2500 'enter/review/change param --------------------------------
2510 CLS:GOSUB 9000 : IF NPRM% < 1 THEN 2580
2530 PRINT  "CHANGE PARAMETERS? ENTER:   'A' TO CHANGE ALL":                        PRINT TAB(29)"'S' TO SELECTIVELY CHANGE (or add parameters)"
2540 PRINT TAB(29) "press RETURN to leave unchanged";:INPUT T1$
2550 IF T1$ = "" GOTO 420
2560 IF T1$ = "S" THEN 2700
2570 IF T1$ <  > "A" THEN 2530
2580 PRINT "ENTER PARAMETERS ONE AT A TIME.":                                            PRINT "   (NULL TO EXIT)"
2590 FOR I = 1 TO MXVAR%
2600     PRINT  I;"- "; : INPUT T$ : PRINT
2610     IF T$ = "" THEN NPRM% = I - 1: GOTO 2660
2620     IF  LEFT$ (T$,1) = "." OR LEFT$ (T$,1) = "-" THEN 2640
2630     IF  LEFT$ (T$,1) < "0" OR  LEFT$ (T$,1) > "9" THEN                                 PRINT T$ "INVALID, RETYPE": GOTO 2600
2640     PARM(I) =  VAL (T$)
2650 NEXT
2660 IF NPRM% <  = 0 GOTO 420
2670 FOR I = 1 TO NPRM%:DPARM(I) = 0: NEXT
2680 IPFLG = 0 : ISVFL = 0 : GOTO 420
2700 '----- change some of the param
2710 PRINT "ENTER PARM#, AND VALUE": PRINT SPC(10)"(, TO EXIT)"
2720 INPUT T1$,T2$: IF T1$ = "" THEN  GOSUB 9000: GOTO 400
2730 IF VAL(T1$) = NPRM%+1 THEN NPRM%=NPRM%+1
2740 IF  VAL (T1$) < 1 OR  VAL (T1$) > NPRM% THEN                                        PRINT "INVALID PARM#. RANGE IS 1-";NPRM%+1: GOTO 2720
2750 IF  LEFT$ (T2$,1) = "." OR LEFT$ (T2$,1) = "-" THEN 2770
2760 IF  LEFT$ (T2$,1) < "0" OR  LEFT$ (T2$,1) > "9" THEN                                PRINT T2$ "INVALID, RETYPE": GOTO 2720
2770 PARM( VAL (T1$)) =  VAL (T2$)
2780  GOTO 2720
2800 'fix some parameters -------------------------------------
2810 GOSUB 9000
2820 IF NPRM% < 1 THEN 400
2830 INPUT "ENTER PARM# TO BE FIXED (NULL TO EXIT)";I
2840 IF I = 0 GOTO 2870
2850 IF I<1 OR I>NPRM% THEN PRINT "INVALID PARM#. RANGE IS 1-"                          ;NPRM%: GOTO 2800
2860 KFIX(I) = 1 : F1% = 1 : GOTO 2830
2870 IF F1% = 0 GOTO 400 'NOTHING CHANGED
2880 GOSUB 9000 : IPFLG = 0:ISVFL = 0 : GOTO 400
3000 'free some previously fixed param.-------------------------
3010 GOSUB 9000 : IF NPRM% < 1 THEN 400
3030 INPUT "ENTER PARM# TO BE FREED (NULL TO EXIT)";I
3040 IF I = 0 GOTO 3070
3050 IF I < 1 OR I > NPRM% THEN                                                          PRINT  "INVALID PARM#. RANGE IS 1-";NPRM%: GOTO 3000
3060 KFIX(I) = 0 : F1% = 1 : GOTO 3030
3070 IF F1% = 0 GOTO 400
3080 GOSUB 9000 : IPFLG = 0:ISVFL = 0 : GOTO 400
3200 'print data and param values ------------------------------
3210 CLS:GOSUB 10000:PRINT "MARQUARDT LEAST SQUARES - REV ";REV
3220 PRINT  TITL$: PRINT  NITER%;" ITERATIONS": PRINT
3230 IF PFLG%=1 THEN LPRINT TITL$:LPRINT NITER%;" ITERATIONS"
3240 GOSUB 9000 : GOSUB 1100 'print parameters and statistics
3260 PRINT:PRINT NOBS%;" DATA POINTS BEING FITTED":                                    PRINT SPC(18)"(X,DTA,WGT,FMM)"
3270 IF PFLG%=1 THEN LPRINT:LPRINT NOBS%;                                           " DATA POINTS BEING FITTED":LPRINT SPC(18) "(X,DTA,WGT,FMM)"
3280 IF NOBS% <  = 0 GOTO 3360
3290 PFORM$ = "##.##^^^^   "
3300 FOR I = 1 TO NOBS%
3310 IF BRKFLG% THEN BRKFLG% = 0:PRINT "BREAK IN LISTING":                              GOTO 400
3320 GOSUB 20000:FMM = FUNCTN - DTA(I)
3330 PRINT USING PFORM$;X(I),DTA(I),WGT(I),FMM
3340 IF PFLG%=1 THEN LPRINT USING PFORM$;X(I),DTA(I),WGT(I),FMM
3350 NEXT
3360 GOTO 400
3400 'save data  & parameters ---------------------------------
3410 PRINT  "THESE ARE YOUR CURRENT FILES" : FILES DRV$ + "*.*"
3430 PRINT  : INPUT "SAVE DATA AS DISK FILE NAMED ";T1$
3435 IF MID$(T1$,2,1) <> ":" THEN T1$ = DRV$ + T1$
3440 OPEN "O",2,T1$ : IF RETCOD <> 0 THEN CLOSE 2 : GOTO 400
3460 WRITE #2, TITL$ : WRITE #2, NOBS%
3470 FOR I = 1 TO NOBS%: WRITE #2, X(I),DTA(I),WGT(I): NEXT
3480 WRITE #2, NPRM%
3485 FOR I = 1 TO NPRM%:WRITE #2, PARM(I),DPARM(I),KFIX(I):NEXT
3490 CLOSE 2: IPFLG = 0:ISVFL =  - 1 : GOTO 420
3600 'read data & param from disk -----------------------------
3610 PRINT "THESE ARE YOUR CURRENT FILES" : FILES DRV$ + "*.*"
3630 PRINT:INPUT "READ DATA & PARAM FROM DISK FILE NAMED ";T1$
3635 IF MID$(T1$,2,1) <> ":" THEN T1$ = DRV$ + T1$
3640 OPEN "I",3,T1$ : IF RETCOD <> 0 THEN CLOSE 3 : GOTO 400
3660 INPUT #3, TITL$ : INPUT #3, NOBS%
3670 FOR I = 1 TO NOBS%: INPUT #3, X(I),DTA(I),WGT(I): NEXT
3680 INPUT #3, NPRM%
3685 FOR I = 1 TO NPRM%:INPUT #3, PARM(I),DPARM(I),KFIX(I):NEXT
3690 CLOSE 3
3700 IPFLG = 0:ISVFL =  - 1:GOSUB 9000:PRINT
3705 LOCATE 25,1:PRINT TITL$;:LOCATE 21 : PRINT  : GOTO 400
4000 'subroutine to compute chi-squared ------------------------
4010 CHI2 = 0
4020 FOR I = 1 TO NOBS%
4030    IF WGT(I) = 0 THEN 4060
4040    GOSUB 20000
4050    CHI2 = CHI2 + ((FUNCTN - DTA(I)) / WGT(I)) ^ 2
4060 NEXT
4070 RETURN
4500 'subroutine obtains CHOLESKY backward solution of matrix A
4510 G(1) = G(1) / A(1)
4520 IF NFIT% <  = 1 THEN 4630
4530 L = 1
4540 FOR I = 2 TO NFIT%
4550     K = I - 1
4560     FOR J = 1 TO K
4570        L = L + 1 : G(I) = G(I) - A(L) * G(J)
4590     NEXT
4600     L = L + 1 : G(I) = G(I) / A(L)
4620 NEXT
4630 MDI% = NFIT% * (NFIT% + 1) / 2
4640 G(NFIT%) = G(NFIT%) / A(MDI%)
4650 IF NFIT% <  = 1 THEN  RETURN
4660 FOR K1 = 2 TO NFIT%
4670     I = NFIT% + 2 - K1
4680     K = I - 1 : L = I * K / 2
4700     FOR J = 1 TO K
4710        G(J) = G(J) - G(I) * A(L + J)
4720     NEXT
4730     G(K) = G(K) / A(L)
4740 NEXT
4750 RETURN
5000 'subroutine to perform CHOLESKI decomposition of matrix a
5010 FLG% = 0
5020 FOR J = 1 TO NFIT%
5030     L = J * (J + 1) / 2
5040     IF J <  = 1 THEN 5120
5050     FOR I = J TO NFIT%
5060        K1 = I * (I - 1) / 2 + J  : F = A(K1) : K2 = J - 1
5090        FOR K = 1 TO K2:F = F - A(K1 - K) * A(L - K): NEXT
5100        A(K1) = F
5110     NEXT
5120     IF A(L) > 0 THEN 5160
5130     FLG% = 1 : PRINT "CHOLSKI-NEG DIAG J,L,A(L)= ";J,L,A(L)
5150     RETURN
5160     F =  SQR (A(L))
5170     FOR I = J TO NFIT%
5180        K2 = I * (I - 1) / 2 + J :  A(K2) = A(K2) / F
5200     NEXT
5210 NEXT
5220 RETURN
5500 'subroutine to calculate the weighted sum of squares ------
5510 WSS = 0 : NSSC = NSSC + 1
5520 FOR I = 1 TO NOBS%
5530     GOSUB 20000
5540     WSS = WSS + (WGT(I) * (FUNCTN - DTA(I))) ^ 2
5550 NEXT
5570 RETURN
5700 'subroutine to calculate the sum of squares ---------------
5710 SS = 0 : NSSC = NSSC + 1
5720 FOR I = 1 TO NOBS%
5730     GOSUB 20000 : SS = SS + (FUNCTN - DTA(I)) ^ 2
5750 NEXT
5770 RETURN
5900 'subroutine to calculate the sum of DTA(I)^2 --------------
5910 R = 0
5920 FOR I = 1 TO NOBS% : R = R + DTA(I) ^ 2 : NEXT
5950 RETURN
5990 'subroutine to do the main mathematics of the fitting -----
6000 NFIT% = 0:NX% = 0
6010 IF NPRM% < 1 THEN RETURN 2500
6020 FOR I = 1 TO NPRM%
6030     IF KFIX(I) = 0 GOTO 6070
6040     NX% = NX% + 1
6050     DPARM(NX%) = 0!
6060     GOTO 6090
6070     NFIT% = NFIT% + 1
6080     B(NFIT%) = PARM(I)
6090 NEXT
6100 IF NFIT% <= 0 THEN NITER% = ITER% : RETURN 420
6140 'perform MARQUARDT fitting --------------------------------
6150 IF NOBS% >= NFIT% THEN 6180
6160 PRINT  "# OF DATA PTS (NOBS%= ";NOBS%;")";" IS LESS THAN";                             TAB( 41);"# OF PARAM. TO BE FIT (NFIT%= ";NFIT%;")"
6165 PRINT  "MODEL IS UNDETERMINED"; CHR$ (7)
6170 NITER% = ITER% : RETURN 400
6180 PRCSN = 2.5E-07 : LAMBDA = .01 : LMIN = 1E+20 : PHI = 1
6190 MDI% = NFIT% * (NFIT% + 1) / 2
6200 NSSC = 0 : NDC = 0 : NITER% = 0 : INCR = 0
6210 GOSUB 5500 ' Choleski decomposition
6220 PRINT "WGT'D SSQ = ";WSS
6225 IF PFLG%=1 THEN LPRINT "WGT'D SSQ = ";WSS
6230 GOTO 6280
6240 'NEXT ITERATION -------------------------------------------
6250 NITER% = NITER% + 1
6260 IF (NITER% > 4 AND LAMBDA < LMIN) THEN LMIN = LAMBDA
6270 LOCATE ,13: PRINT  WSS : IF PFLG% = 1 THEN LPRINT WSS;" ";
6280 IF NITER% >= MXITER%                                                               THEN PRINT  MXITER%;" ITERATIONS - PAUSE": GOTO 6920
6290 IF BRKFLG%                                                                         THEN BRKFLG% = 0 : PRINT "OPERATOR INTERRUPT": GOTO 6920
6300 COLOR FG2,BG2 : PRINT  "COMPUTING ";: COLOR FG1,BG1
6305 PRINT " ITERATION #";NITER% + 1;: COLOR FG,BG:PRINT
6310 '------- DECREASE LAMBDA
6320 LAMBDA = .31622777# * LAMBDA : INCR = 0
6340 '------- CALCULATE A=JTJ AND JTF
6350 FOR I = 1 TO MDI%:A(I) = 0: NEXT
6360 FOR I = 1 TO NFIT%:GRAD(I) = 0: NEXT
6370 FOR I = 1 TO NOBS%
6380     GOSUB 21000
6390     FMM = (F - DTA(I)) * WGT(I)
6400     J = 0
6410     FOR K = 1 TO NPRM%
6420        IF KFIX(K)=0 THEN J = J+1:DERIV(J) = DERIV(K)*WGT(I)
6430     NEXT
6440     FOR J = 1 TO NFIT%
6450        GRAD(J) = GRAD(J) + DERIV(J) * FMM
6460        L = J * (J - 1) / 2
6470        FOR K=1 TO J: A(L+K)=A(L+K)+DERIV(J)*DERIV(K): NEXT
6480     NEXT
6490  NEXT
6500  NDC = NDC + 1
6510 '------ SAVE "A" MATRIX AND CURRENT PARAMETER VALUES "B"
6520 FOR I = 1 TO MDI%:C(I) = A(I): NEXT
6530 FOR I = 1 TO NFIT%:DERIV(I) = B(I): NEXT
6540 '------ DOCTOR "A" MATRIX DIAGONAL ELEMENTS TO BE:
6550 '       A = A(1+LAMBDA) + PHI*LAMBDA
6560 DA = PHI * LAMBDA
6570 FOR J = 1 TO NFIT%
6580     G(J) =  - GRAD(J)
6590     L = J * (J + 1) / 2
6600     A(L) = C(L) * (1 + LAMBDA) + DA
6610     K = J - 1
6620     IF K > 0 THEN  FOR I = 1 TO K:A(L - I) = C(L - I): NEXT
6630 NEXT
6650 GOSUB 5000  'Cholesky decomposition
6660 IF FLG% <> 0 GOTO 6840
6680 GOSUB 4500   'calculate g (the change in parameters)
6690 '------ FIND NEW PARAMETERS B = D+G
6700 '      (N0 COUNTS THE # OF ZERO ELEMENTS IN G)
6710 N0 = 0 : I = 0
6720 FOR J = 1 TO NPRM%
6730     IF KFIX(J) <  > 0 GOTO 6780
6740     I = I + 1
6750     B(I) = DERIV(I) + G(I)
6760     IF  ABS (G(I)) <= ABS (PRCSN*DERIV(I)) THEN N0 = N0 + 1
6770     PARM(J) = B(I)
6780  NEXT
6790  IF NO = NFIT% GOTO 6890
6800  OLDWSS = WSS : GOSUB 5500  'update the wss
6820  IF WSS < OLDWSS GOTO 6250  'next iteration
6830 '------ last step too big; increase lambda
6840 IF LAMBDA < PRCSN THEN LAMBDA = PRCSN
6850 INCR = INCR + 1
6860 LAMBDA = 10! * LAMBDA
6870 IF LAMBDA <  = 100000! * LMIN GOTO 6560
6880 '------ convergence reached
6890 RI = LAMBDA / LMIN
6900 CLS : GOSUB 10000 : PRINT  "      CONVERGENCE  REACHED "
6905 PRINT  "# OF PARAMS FIT = ";NFIT%
6907 PRINT  "# OF PARAMS CONVERGED = ";N0
6910 PRINT  "LAMBDA/L(MIN) = ";RI
6920 NF = NOBS% - NFIT%
6930 IF NF <  = 0 GOTO 6990
6940 GOSUB 5700   'calc sum of squares
6950 SIG =  SQR (SS / NF)
6960 GOSUB 5900   'calc sum of dta^2
6970 R =  SQR (SS / R) * 100!
6980 GOSUB 4000   'compute chi-squared
6990 IF NITER% <= 0 GOTO 7130
7000 FOR J = 1 TO MDI%:A(J) = C(J): NEXT : GOSUB 5000
7010 IF FLG% = 0 GOTO 7060
7020 FOR J = 1 TO NPRM%
7030     IF KFIX(J) = 0 THEN PARM(J) = 999.0001
7040 NEXT
7050 GOTO 7130
7060 K = 0
7070 FOR I4 = 1 TO NPRM%
7080     IF KFIX(I4) <> 0 GOTO 7120
7090     K4 = K4 + 1
7100     FOR J = 1 TO NFIT%:G(J) = 0!: NEXT :G(K4) = 1!
7110     GOSUB 4500:DPARM(I4) =  SQR ( ABS (G(K4))) * SIG
7120 NEXT
7130 RETURN
9000 'list the current values of the parameters ----------------
9010 IF NPRM% < 1 THEN  PRINT  "NO PARAM ENTERED": RETURN
9020 PRINT
9025 PRINT NPRM%; " FITTING PARAMETERS & THEIR ERRORS" : PRINT
9030 IF PFLG%= 1 THEN LPRINT : LPRINT NPRM%;                                                       " FITTING PARAMETERS AND THEIR ERRORS":LPRINT
9040 FOR I = 1 TO NPRM%
9050     IF PFLG% = 0 GOTO 9080
9060     LPRINT  I;") ";PARM(I);
9070     IF KFIX(I) = 0 THEN  LPRINT  " +- ";DPARM(I)                                                   ELSE LPRINT "  (FIXED)  "
9080     PRINT  I;") ";PARM(I);
9090     IF KFIX(I) = 0 THEN  PRINT  " +- "; DPARM(I)                                                   ELSE PRINT "  (FIXED)  "
9100 NEXT
9110 PRINT : RETURN
9999 ' ----------- FUNCTION KEY and HELP SUBROUTINES -----------
10000 'display "help" / title line -----------------------------
10005 XCURSOR = CSRLIN : YCURSOR = POS(0) : LOCATE 25,1
10010 IF SHOWTITLE THEN COLOR FG2,BG:PRINT  TITL$;                                    ELSE COLOR FG2,BG : PRINT " 1- SHOW FUNCTION KEYS";                             "   2- SHOW TITLE   3- BREAK   4- QUICK-PLOT";:COLOR FG,BG
10020 LOCATE XCURSOR,YCURSOR : RETURN
10200 SHOWTITLE=0: GOSUB 10000: RETURN 'display "HELP" line---F1
10300 SHOWTITLE = -1: GOSUB 10000: RETURN 'display title -----F2
10310 BRKFLG% = 1 : RETURN  'user interrupt (break function) -F3
10400 CLS : PRINT TAB(15); "QUICK PLOT" ' --------------------F4
10410 PRINT TAB(10); " Y "; YSTYL$; " VS."; " X ";XSTYL$;" PLOT"
10420 IF PLOTSET% = 0 THEN                                                              PRINT "PLOT NOT DEFINED - FIRST USE MENU OPTION #4" :                          PRINT"PRESS ANY KEY TO CONTINUE":WHILE INKEY$="":WEND:                         RETURN
10430 GOSUB 16000   'scale data log or linear
10440 GOSUB 16300   'calculate fitting function
10450 IF XNEG THEN                                                                       PRINT "WARNING: NEGATIVE X VALUE. X LOG PLOT INVALID":                          XNEG=0:GOTO 10470
10460 GOSUB 16500 ' PLOT
10470 SCREEN 0 : RETURN
15000 'Plot data points and fitting function -------------------
15010 'Plot data points and fitting function -------------------
15020 CLS
15030 IF NPRM% < 1 AND NOBS% < 1 THEN PRINT  TAB(20),                                            "NO DATA POINTS OR PARAMETERS ENTERED":GOTO 400
15040 FOR I = 1 TO NPRM%
15050    IF PARM(I) < > 0 THEN GOTO 15080
15060 NEXT
15070 PRINT "     WARNING: all parameters are currently = 0"
15080 RESPLOT = 0   'FLAG to indicate plot for residuals
15090 IF NOBS% < 1 THEN GOTO 15170
15100 PRINT TAB(15),"CHOOSE PLOT:":PRINT
15110 PRINT " 1- PLOT DATA AND FITTING FUNCTION"
15120 PRINT " 2- PLOT RESIDUALS [ABS(FIT MINUS MEASUREMENT)]"
15130 PRINT " 3- PLOT RESIDUALS [% FIT MINUS MEASUREMENT]"
15140 INPUT "ENTER CHOICE:";KMND
15150 IF KMND = 2 THEN RESPLOT = 1 : PCNT% = 0
15160 IF KMND = 3 THEN RESPLOT = 1 : PCNT% = 1
15170 PRINT TAB(15),"CHOOSE GRAPH STYLE:"
15180 PRINT "1-  Y LINEAR VS. X LINEAR"
15185 PRINT "2-  Y LINEAR VS. X LOG"
15190 IF RESPLOT = 1 GOTO 15210
15200 PRINT "3-  Y LOG VS. X LINEAR":PRINT "4-  Y LOG VS. X LOG"
15210 OLDSTYL%=GSTYL%:PRINT:INPUT "ENTER CHOICE:";GSTYL%
15220 IF GSTYL% = 0 THEN 400
15230 IF GSTYL% <> OLDSTYL% THEN PLOTSET% = 0
15240 XSTYL$="LINEAR"
15245 IF (GSTYL%=2 OR GSTYL%=4) THEN XSTYL$="LOG"
15250 YSTYL$="LINEAR"
15255 IF (GSTYL%=3 OR GSTYL%=4) THEN YSTYL$="LOG"
15260 CLS:PRINT TAB(15);" Y ";YSTYL$;" VS.";" X ";XSTYL$;" PLOT"
15270 IF NOBS% <1 THEN 15460
15280 ' GO SCALE THE DATA INTO PLOTTING ARRAY
15290 GOSUB 16000  'scale determine minimum and maximum of DTA
15300 IF XNEG THEN                                                                       PRINT "WARNING: NEGATIVE X VALUE. X LOG PLOT INVALID":                          XNEG=0:GOTO 15170
15320 PRINT : PRINT  "DATA POINTS: "
15330 PRINT  "X VALUES range from: ";XP(1);" to ";XP(NOBS%)
15340 PRINT  "Y VALUES range from: ";MINDTA;" to ";MAXDTA
15350 IF PLOTSET% = 0  THEN 15420
15360 PRINT "Current graph boundaries are:"
15370 PRINT "       xmin = ";XMIN;"  xmax = ";XMAX
15380 PRINT "       ymin = ";YMIN;"  ymax = ";YMAX
15390 PRINT:PRINT                                                                     " Do you wish to change any of the graph boundaries (Y/N)"
15400 INPUT "(null to leave unchanged)";T1$
15410 IF T1$ = "" OR T1$ = "N" THEN 15460
15420 PRINT:INPUT "ENTER GRAPH XMIN,XMAX,YMIN,YMAX ";                                             XMIN,XMAX,YMIN,YMAX
15425 IF XMIN = 0 AND XMAX = 0 GOTO 420
15430 PRINT:PRINT "ENTER xinterval,yinterval";                                                           "(THE # OF INTERVALS ON THE x,y AXIS)";
15435 INPUT XINTERVAL, YINTERVAL
15440 PLOTSET% = 1
15450 IF RESPLOT = 1 OR NPRM%=0                                                          THEN XINC = 2*(XMAX-XMIN)/MXOBS%:GOTO 15720
15460 PRINT:PRINT "PLOT OF FITTED FUNCTION";                                                              "(FROM CURRENT VALUE OF PARAMETERS):"
15470 IF NOBS% < 1 AND PLOTSET% = 0 GOTO 15530
15480 PRINT "The function will be plotted in the range ";                                                                      XMIN; " to ";XMAX
15490 INPUT "ENTER X INCREMENT for plotting the function";XINC
15500 IF XINC <=0 THEN PRINT "INVALID ENTRY":GOTO 15480
15510 IF (XMAX-XMIN)/XINC > MXOBS% THEN PRINT                                          "too many points, must be fewer than ";MXOBS%: GOTO 15480
15520 GOTO 15570
15530 PRINT "       NO DATA CURRENTLY ENTERED"
15540 PRINT:PRINT "ENTER XMIN,XMAX AND X-INCREMENT"
15550 INPUT "for evaluating fitting function";XMIN,XMAX,XINC
15560 IF (XMAX-XMIN)/XINC > MXOBS% THEN PRINT                                          "too many points, must be fewer than ";MXOBS%: GOTO 15530
15570 GOSUB 16300 ' evaluate function
15580 PRINT:PRINT "MINIMUM of fitted function= ";MINYP
15590 PRINT "MAXIMUM of fitted function= ";MAXYP
15600 PRINT:PRINT "current graph boundaries are:"
15610 PRINT "       xmin = ";XMIN;"  xmax = ";XMAX
15620 PRINT "       ymin = ";YMIN;"  ymax = ";YMAX
15630 IF NOBS%<1 THEN 15670
15640 PRINT
15645 PRINT "do you wish to change THESE GRAPH BOUNDARIES?(Y/N)"
15650 INPUT "(null to leave unchanged)";T1$
15660 IF T1$ = "" OR T1$ = "N" THEN 15720
15670 PRINT:PRINT "ENTER NEW YAXIS BOUNDARY VALUES -- YMIN,YMAX"
15680 INPUT "(ENTER , TO CHANGE ALL GRAPH BOUNDARIES)";T1$,T2$
15690 IF T1$ = "" THEN 15420
15700 YMIN = VAL(T1$):YMAX = VAL(T2$)
15710 PRINT: PRINT "ENTER xinterval,yinterval";                                                    " (THE # OF INTERVALS ON THE x,y AXIS)"
15715 INPUT XINTERVAL, YINTERVAL
15720 GOSUB 16500 'go and plot
15730 SCREEN 0 : GOTO 420   'finished plotting
16000 'Scale data & find the minima and maxima of data in YP(I)
16010 XNEG = 0
16020 MINDTA = 9.999999E+37: MAXDTA = -9.999999E+37
16030 FOR I = 1 TO NOBS%
16040 XP(I) = X(I): YP(I) = DTA(I)
16050 IF RESPLOT <> 1 THEN 16090
16060 NORM = DTA(I):IF NORM = 0 THEN NORM = 1E-10
16070 GOSUB 20000: YP(I) = FUNCTN - DTA(I) 'yes - calc residuals
16080 IF PCNT% <>0 THEN YP(I) = YP(I)/NORM ' plot % residual?
16090 IF (GSTYL%=1 OR GSTYL%=3) GOTO 16110 ' xlog plot?
16100 IF X(I)>0 THEN XP(I) = FNLGT(XP(I)) ELSE XNEG = 1 : RETURN
16110 IF (GSTYL%=1 OR GSTYL%=2) GOTO 16130 ' ylog plot?
16120 IF DTA(I)>0 THEN YP(I)=FNLGT(YP(I)) ELSE YP(I) = YMIN
16130 IF YP(I) >= MAXDTA THEN MAXDTA = YP(I)
16140 IF YP(I) <= MINDTA THEN MINDTA = YP(I)
16150 NEXT
16160 RETURN
16290 'calculate function using current parm values -----------
16300 PRINT:PRINT "CALCULATING FUNCTION...."
16305 IF NPRM% < 1 THEN RETURN
16310 I=0: KK=0: MINYP = 9.9E+37: MAXYP = -9.9E+37
16320 FOR XPT=XMIN TO XMAX STEP XINC
16330     KK=KK+1: FXP(KK) = XPT
16340     X(I) = XPT :IF (GSTYL%=1 OR GSTYL%=3) GOTO 16360
16350     X(I)=10^XPT ' FOR X-LOG PLOT
16360     GOSUB 20000
16370     FYP(KK) = FUNCTN 'FOR NON-LOG Y PLOT
16380     IF (GSTYL%=1 OR GSTYL%=2) GOTO 16400
16390     IF FUNCTN > 0 THEN FYP(KK)=FNLGT(FUNCTN)                                                      ELSE FYP(KK) = YMIN
16400     IF FYP(KK) >= MAXYP THEN MAXYP = FYP(KK)
16410     IF FYP(KK) <= MINYP THEN MINYP = FYP(KK)
16420 NEXT XPT
16430 KMAX = KK
16440 RETURN
16500 'plotting subroutine -- first axes and tick marks --------
16510 DELTAX = XMAX-XMIN: DELTAY = YMAX-YMIN: LETWID=8: LETHGT=8
16515 'hi-res screen & choose color 2 -for pc & 100% compatibles
16520 SCREEN 2:DEF SEG = &H0: OUT &H3D9,2
16530 LINE (XMIN.PIX,YMIN.PIX) - (XMAX.PIX,YMAX.PIX),,B
16540 IF XINTERVAL < 1 THEN XINTERVAL = 5
16550 ' X TICKS
16560 MINCOL = 0
16570 FOR TICK = 0 TO XINTERVAL
16580     TICKPLACE = XMIN.PIX + CINT(DELTAX.PIX*TICK/XINTERVAL)
16590     LINE(TICKPLACE,YMIN.PIX-2) - (TICKPLACE,YMIN.PIX+2)
16600     LINE(TICKPLACE,YMAX.PIX-2) - (TICKPLACE,YMAX.PIX+2)
16610     TICCOL = INT(TICKPLACE/LETWID)-1
16620     VAL.LAB = XMIN + (TICK/XINTERVAL)*DELTAX
16630     IF (GSTYL%=2 OR GSTYL%=4) THEN VAL.LAB = 10^VAL.LAB
16640     TICLAB = VAL.LAB:GOSUB 18000
16650     TICCOL = TICCOL - LEN(FORMAT$)/2 + 2
16660     IF TICCOL + LEN(FORMAT$) > 80 THEN 16700
16670     IF TICCOL < MINCOL GOTO 16700
16680     LOCATE 25,TICCOL: MINCOL = TICCOL + LEN(FORMAT$)
16690     PRINT USING FORMAT$;TICLAB;
16700 NEXT TICK
16710 IF YINTERVAL < 1 THEN YINTERVAL = 5
16720 ' Y TICKS
16730 OLDROW = 26
16740 FOR TICK = 0 TO YINTERVAL
16750     TICKPLACE = YMIN.PIX - CINT(DELTAY.PIX*TICK/YINTERVAL)
16760     LINE(XMIN.PIX-2,TICKPLACE) - (XMIN.PIX+2,TICKPLACE)
16770     LINE(XMAX.PIX-2,TICKPLACE) - (XMAX.PIX+2,TICKPLACE)
16780     TICROW = INT (TICKPLACE/LETHGT) + 1
16790     IF TICROW >= OLDROW-1 THEN GOTO 16860
16800     VAL.LAB = YMIN + (TICK/YINTERVAL) * DELTAY
16810     IF (GSTYL%=3 OR GSTYL%=4) THEN VAL.LAB = 10^VAL.LAB
16820     TICLAB = VAL.LAB :GOSUB 18000
16830     TICCOL = 8 - LEN(FORMAT$):IF TICCOL < 1 THEN TICCOL=1
16840     LOCATE TICROW,TICCOL : OLDROW = TICROW
16850     PRINT USING FORMAT$;TICLAB;
16860 NEXT TICK
17000 'plot points and function --------------------------------
17010 FOR I = 1 TO NOBS%
17020    CIRCLE (FNSX(XP(I)),FNSY(YP(I))),4
17030 NEXT
17040 IF RESPLOT = 1 OR NPRM% < 1 GOTO 17120 ' no function plot
17050 IWENT%=0
17060 FOR K = 1 TO KMAX
17070    XPT = FNSX(FXP(K)): YPT = FNSY(FYP(K))
17080    IF XPT<0 OR XPT>XTOTAL.PIX OR YPT<0 OR YPT>YTOTAL.PIX                              THEN 17110 ' pt out of range
17090    IF IWENT% = 0 THEN PSET (XPT,YPT) : IWENT%= 1
17100    LINE -(XPT,YPT)
17110 NEXT K
17120 GTITL$ = TITL$: PCNT$ = "": IF PCNT% = 1 THEN PCNT$="(%)"
17130 IF RESPLOT = 1 THEN GTITL$ = GTITL$+" - RESIDUALS"+PCNT$
17140 LOCATE 1,50-LEN(GTITL$):PRINT GTITL$;
17150 WHILE INKEY$ = "" : WEND : RETURN
18000 'subroutine to format a label for axis -------------------
18020 FORMAT$="#"
18030 IF TICLAB=0 THEN RETURN
18040 ORDER=INT(LOG(ABS(TICLAB))/2.30258)
18050 IF ABS(ORDER)>=4 THEN FORMAT$ = "##.#^^^^" : RETURN
18060 IF ORDER<0 THEN FORMAT$=FORMAT$+".": GOTO 18080
18070 FORMAT$=FORMAT$+STRING$(ORDER+1,"#")+"."
18080 T=TICLAB
18090 TOL=ABS(TICLAB/100000!)
18100  FP=ABS(T-FIX(T)): IF 1-FP<FP THEN FP=1-FP
18110 WHILE FP>TOL
18120   T=T*10: TOL=TOL*10
18130   FP=ABS(T-FIX(T)): IF 1-FP<FP THEN FP=1-FP
18140   FORMAT$=FORMAT$+"#"
18150 WEND
18160 RETURN
19000 'error trap ----------------------------------------------
19010 IF RETCOD = 0 THEN RETCOD = -1 :ERRCNT = 1: GOTO 19030
19020 ERRCNT = ERRCNT + 1 ' error flagged again in same routine
19030 IF ERR=5 THEN PRINT "ILLEGAL FUNCTION CALL"
19040 IF ERR=6 THEN PRINT "OVERFLOW ERROR"
19050 IF ERR=53 OR ERR=54 THEN PRINT "FILE NOT FOUND"
19060 IF ERR=61 THEN PRINT "DISK FULL ERROR"
19070 IF ERR=70 OR ERR=71                                                                THEN PRINT "DISK NOT READY OR WRITE PROTECTED"
19080 PRINT "ERROR #";ERR;" ON LINE NUMBER ";ERL
19090 IF ERRCNT > 5 THEN PRINT:PRINT                                                         "ROUTINE TERMINATING DUE TO ERROR COUNT ": GOTO 400
19100 PRINT "PRESS ANY KEY TO CONTINUE...":WHILE INKEY$="":WEND
19110 RESUME NEXT
20000 'subroutine to evaluate the function chosen to be fit
20005 'The function code here is for the video game problem
20010 FUNCTN = PARM(1) * (1 - EXP(-PARM(2) * X(I)))
20020 RETURN
20050 '
21000 'subroutine to evaluate the derivative of the function
21005 'with respect to each parameter. Only 2 parameters here.
21010 GOSUB 20000
21020 F = FUNCTN
21030 DERIV(1) = F / PARM(1)
21040 DERIV(2) = X(I) * (PARM(1)-F)
21050 RETURN
                                                                   