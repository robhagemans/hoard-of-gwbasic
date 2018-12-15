100 REM             LIMITING MAGNITUDE OF A TELESCOPE
110 REM
120 INPUT "SCOPE APERTURE ";D        : REM  IN INCHES
130 INPUT "POWER ";MG                : REM  SCOPE'S MAGNIFICATION
140 INPUT "LIM MAG AT ZENITH ";MZ    : REM  FOR NAKED-EYE
150 INPUT "OBSERVER'S AGE ";AG       : REM  IN YEARS
160 INPUT "TELESCOPE TYPE (1-3) ";TT : REM  1=REFR, 2=REFL, 3=SCT
170 INPUT "CLEANLINESS (1-9) ";CL    : REM  1=FILTHY, 9=CLEAN
180 INPUT "COLOR INDEX OF STAR ";CI  : REM  B-V MAGNITUDE
190 INPUT "ZENITH DISTANCE ";Z       : REM  IN DEGREES
200 INPUT "EXTINCTION COEFF ";KV     : REM  IN V-BAND
210 INPUT "SEEING DISK RADIUS ";SE   : REM  IN ARC-SECONDS
220 INPUT "EXPERIENCE (1-9) ";EX     : REM  1=NOVICE, 9=VERY EXPER.
230 D=D*25.4                         : REM  CONVERT TO MM
240 IF TT=1 THEN DS=0                : REM  NO OBSTRUCTION
250 IF TT=2 THEN DS=0.15*D           : REM  NEWT SECONDARY DIAM
260 IF TT=3 THEN DS=0.35*D           : REM  TYPICAL DIAM OF SCHMIDT-
270 REM                                         CASS SECONDARY
280 Z=Z/57.296                       : REM  CONVERT TO RADIANS
290 CC=1.58E-10                      : REM  NIGHT-VISION CONSTANT
300 KK=0.0126                        : REM  NIGHT-VISION CONSTANT
310 K=1.2*KV                         : REM  CORRECT KV TO 5100 A
320 X=1.0/COS(Z)                     : REM  AIR MASS
330 IF TT=1 THEN FL=0.99^4           : REM  4 COATED SURFACES
340 IF TT=2 THEN FL=0.88^2           : REM  2 ALUMINIZED MIRRORS
350 IF TT=3 THEN FL=(0.99*0.88)^2    : REM  CORRECTOR & 2 MIRRORS
360 FD=1.0-(DS/D)^2                  : REM  ALLOW FOR OBSTRUCTION 
370 FO=0.99^4                        : REM  EYEPIECE (4 COATED
375 REM                                       AIR-GLASS SURFACES)
380 DE=7*EXP(-0.5*(AG/100)^2)        : REM  DIAM EYE PUPIL IN MM
390 DP=D/MG                          : REM  DIAM OF EXIT PUPIL
400 TH=2*SE*MG                       : REM  APPARENT DIAMETER OF 
410 REM                                       SEEING DISK (ARC-SEC)
420 REM          CORRECTIONS
430 FB=SQR(2)                        : REM  BINOCULAR VISION
440 FE=10^(0.4*K*X)                  : REM  ATMOSPHERIC EXTINCTION
450 FT=1/(FL*FD*FO-0.01*(9-CL))      : REM  TOTAL TRANSMISSION
460 REM                                       OF TELESCOPE
470 FP=1.0                           : REM  LIGHT OUTSIDE PUPIL
480 IF DE<DP THEN FP=(DP/DE)^2
490 FA=(DE/D)^2                      : REM  LIGHT-COLLECTING AREA
500 FM=MG^2                          : REM  SPREAD OF SKY PHOTONS
510 FR=1.0                           : REM  POINT SOURCE CAN
520 IF TH>900 THEN FR=SQR(TH/900)    : REM    APPEAR EXTENDED
530 FC=10^(0.4*(CI/2-1))             : REM  COLOR OF STAR
540 FS=1.0                           : REM  OBSERVER'S SENSITIVITY
550 REM
560 REM       CALCULATE SKY BRIGHTNESS
570 REM
580 IF MZ>=(7-K) THEN 620            : REM  
590 XX=0.2*(8.68-K-MZ)               : REM  FS ASSUMED = 1
600 BS=39.7*(10^XX-1)^2              : REM  SKY BRIGHTNESS FOR MZ
610 GOTO 650
620 BS=54                            : REM  BEST POSS. SKY BRIGHT-
630 FS=10^(0.4*(7-K-MZ))             : REM    NESS & GOOD EYESIGHT
640 REM
650 BS=BS*(Z*Z*0.5+1)                : REM  ZENITH HAS DARKEST SKY
660 B=BS/(FB*FT*FP*FA*FM*FC)         : REM  BACKGROUND BRIGHTNESS
670 REM                                       IN TELESCOPE  
690 REM       CALCULATE LIMITING MAGNITUDE
700 REM
710 I=CC*(1+SQR(KK*B))^2             : REM  Hecht (JOSA,v37,p59,1947)
720 IS=I*FB*FE*FT*FP*FA*FR*FC*FS     : REM  FOR NO SCOPE, NO AIR
730 M=-16.57-2.5*LOG(IS)/LOG(10)     : REM  INTENSITY TO V MAG
740 M=M+(EX-6)*0.16                  : REM  EMPIRICAL EXPERIENCE
750 REM                                       CORRECTION
760 PRINT "VISUAL LIMITING MAGNITUDE = ";M
770 END
800 REM
810 REM   This program by Bradley Schaefer calculates the 
820 REM   limiting stellar magnitude an observer can expect 
830 REM   to see with various types and sizes of telescopes,
840 REM   and under various conditions.  It is fully discussed
850 REM   in SKY & TELESCOPE magazine, November, 1989, page 522.
