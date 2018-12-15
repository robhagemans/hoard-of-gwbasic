10 REM       RONCHI.BAS
20 REM
30 INPUT "Mirror diameter    ";D
40 INPUT "Radius of curvature";R
50 INPUT "Grating frequency  ";F
60 PRINT "Grating distance Delta"
70 PRINT "  from the mirror's 
80 PRINT "  center of curvature"
90 INPUT "  (+ is outside)   ";DL
100 W=1/(2*F): REM  Line width
120 CLS
130 SCREEN 2
140 X0=300: Y0=100: C=300
150 K=.42
160 CIRCLE (X0,Y0),C/2
170 FOR I=1 TO 10000
180 X=D*(RND(1)-.5)
190 Y=D*(RND(1)-.5)
200 REM   X and Y are the ray's
210 REM   coordinates on the face
220 REM   of the mirror
230 S2=X*X+Y*Y
240 IF SQR(S2)>D/2 THEN 390
250 Z=R+S2/R
260 L=R+DL-Z
270 U=L*X/Z
280 REM   Now, test to see if the
290 REM   ray is blocked (FL=0)
300 REM   or transmitted (FL=1)
310 REM   by the grating
320   FL=0: REM  Reset flag
330   T=INT(ABS(U/W)+.5)
340   IF T/2=INT(T/2) THEN FL=1
350   IF FL=0 THEN 390
360 XP=X0+X*C/D
370 YP=Y0+Y*K*C/D
380 PSET(XP,YP): REM  Plot point
390 NEXT I
400 LOCATE 1,1
410   PRINT "Diameter =   ";D
420 LOCATE 2,1
430   PRINT "R of C =     ";R
440 LOCATE 3,1
450   PRINT "Ronchi freq =";F
460 LOCATE 4,1
470   PRINT "Delta =      ";DL
480 END
490 REM ************************************
500 REM   APPEARED IN ASTRONOMICAL COMPUTING
510 REM   SKY & TELESCOPE - APRIL 1991 ISSUE
520 REM ************************************