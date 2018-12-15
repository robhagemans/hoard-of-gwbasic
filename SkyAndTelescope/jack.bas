10 '     Orbit of Jack
11 '
12 DEFDBL A-Z
20 SR=5/7
30 X0=320
40 Y0=175
50 CLS
60 PI=3.14159
70 INPUT "Days in A's year ";YA
80 INPUT "Mass of A ";K
90 INPUT "Jack's initial velocity ";VY
100 CLS
110 M=70
120 W=2*PI/YA
130 RA=200
140 X=100
150 Y=0
160 T=0
170 VX=0
180 SCREEN 9
190 LINE(1,Y0)-(630,Y0)
200 LINE(X0-1,Y0+1)-(X0+1,Y0+1)
201 LINE(X0-1,Y0-1)-(X0+1,Y0-1)
210 AX=RA*COS(W*T)
220 AY=RA*SIN(W*T)
230 T=T+1
240 R3=(X^2+Y^2)^1.5
250 Z3=((X-AX)^2+(Y-AY)^2)^1.5
260 VX=VX-M*X/R3+K*(AX-X)/Z3
270 VY=VY-M*Y/R3+K*(AY-Y)/Z3
280 X=X+VX
290 Y=Y+VY
300 PSET (X0+PX,Y0-PY*SR),0
310 PSET (X0+QX,Y0-QY*SR),6
320 PSET (X0+X,Y0-Y*SR)
330 PSET (X0+AX,Y0-AY*SR)
340 PX=AX
350 PY=AY
360 QX=X
370 QY=Y
380 IF Y<0 THEN SB=0
390 IF Y>0 AND SB=0 THEN 410
400 GOTO 210
410 SB=1
420 R$=INKEY$
430 IF R$<>"" THEN 500
450 PB=T-TA
460 TA=T
470 LOCATE 24,30
480 PRINT "Jack's period is ";PB;" days";
490 GOTO 210
500 END
510 '
520 '   Written by Caxton Foster, this program displays the motion of
530 '   two planets around a central star in a hypothetical solar system.
540 '   The inner planet is called Jack; it is considered to have negligible
550 '   mass, but you can specify its starting velocity (a number from 0 to
560 '   1.6 works best -- if the velocity is greater than 1.6, Jack escapes
570 '   the solar system).  The outer planet moves in a circular orbit, and
580 '   you can specify its period (typically 300 to 2,000 "days") and mass
590 '   (10 or less).  No matter what period you select, its orbit is a
600 '   circular one with a radius twice that of Jack's starting orbit.
610 '   (Thus, Kepler's laws apply to Jack, but not to this arbitrary outer
620 '   planet.)  The program runs on IBM PCs or clones with VGA color
630 '   graphics.  By playing around with input values it is possible to
640 '   make Jack's orbit have resonance, show apsidal motion, or put it on a
650 '   near-collision course with planet A that ejects Jack from the solar
660 '   system.  The program is discussed on page 660 of the September 1994
670 '   issue of Sky & Telescope.
  