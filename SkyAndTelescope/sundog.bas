10 REM  SUNDOG.BAS by Rodney Kubesh
20 REM
30 SCREEN 9
40 WINDOW (-125,80)-(125,-10)
50 PI=3.14159
60 REM Choose solar elevation angle
70 INPUT "Solar elevation in degrees";SA
80 LN=COS(SA*PI/180)
90 LM=COS((90-SA)*PI/180)
95 REM Choose rays from various locations across solar disk
100 FOR J=1 TO 6
110 EL=SA-(J-1)*.1
115 REM Choose angle between ray and crystal face
120 FOR I=0 TO 90 STEP 2
130 N0=COS(EL*PI/180)
140 M0=COS((90-EL)*PI/180)
150 IF ABS(1!-M0*M0-N0*N0)<.000001 THEN L0=0!
160 GOTO 180
170 L0=(1!-M0*M0-N0*N0)^.5
180 REM First crystal face, introduce tilt
190 N=1!
200 NP=1.31
210 AN=I*PI/180!
220 GOSUB 460 
230 REM Tilt it back
240 AN=-AN
250 GOSUB 580
260 REM Next crystal face, 60 deg. tilt
270 N=NP: NP=1!
280 AN=-(60-I)*PI/180!
290 GOSUB 460
300 REM tilt it back
310 AN=-AN
320 GOSUB 580
330 IF IR%<>0 THEN GOTO 390
340 REM Plot point on image plane
350 XS=-200!*L0/N0
360 YS=200!*MS/N0
370 PSET (XS,YS)
380 PSET (-XS,YS)
390 NEXT I
400 NEXT J
405 REM Plot the Sun
410 SX=0: SY=200*LM/LN
420 CIRCLE (SX,SY),2
430 PAINT (SX,SY)
440 LINE (-125,0)-(125,0)
450 END
460 REM Tilt subroutine
470 IR%=0
480 MU=N/NP
490 LI=L0: NI=N0
500 PH=SIN(AN): HP=COS(AN)
510 L0=LI*HP+NI*PH
520 N0=NI*HP-LI*PH
530 LS=MU*L0 : MS=MU*M0
540 IN=MU*MU*(N0*N0-1!)+1!
550 IF IN>=0 THEN NS=IN^.5
560 IF IN<0 THEN IR%=1
570 RETURN
580 REM  Tiltback subroutine
590 LI=LS: NI=NS
600 PH=SIN(AN): HP=COS(AN)
610 L0=LI*HP+NI*PH
620 N0=NI*HP-LI*PH
630 M0=MS
640 RETURN
650 REM  ========================
660 REM  FROM "ASTRONOMICAL
670 REM  COMPUTING," SKY & TELE-
680 REM  SCOPE, JANUARY 1997
690 REM ========================