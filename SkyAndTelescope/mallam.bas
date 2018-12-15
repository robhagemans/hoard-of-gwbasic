10 REM  PRECESSION OF A SATELLITE'S ORBIT DUE TO J2
20 REM
30 GOSUB 260: J=0 
40 INPUT "Planet's name"; P$
50 FOR K=1 TO 9
60 IF P$=PL$(K) THEN J=K
70 NEXT
80 IF J=0 THEN 40
90 REM
100 INPUT "Altitude of the satellite orbit (km)"; A
110 INPUT "Inclination to the equator (degrees)"; I
120 I=I/RD: REM  Convert to radians
130 REM
140 K1=R(J)*R(J) * (R(J)+A)^-3.5 * SQR(GM(J))
150 N=-1.5*K1*J2(J)*COS(I)
160 P=.75*K1*J2(J) * (5*COS(I)*COS(I)-1)
170 N=N*RD*S: P=P*RD*S: REM  Radians/sec to deg/day
180 REM
190 PRINT "Precession of the node: "
200 PRINT "   ";N;"deg/day,  ";N*Y;"deg/yr"
210 PRINT
220 PRINT "Precession of pericenter:  "
230 PRINT "   ";P;"deg/day,  ";P*Y;"deg/yr"
240 REM
250 END
260 REM     READ IN DATA
270 DIM  PL$(9), GM(9), J2(9), R(9)
280 RD=180/3.14159265#: REM  Radians to degrees
290 Y=365.2422: REM  Days per year
300 S=86400: REM  Seconds per day
310 REM 
320 DATA "MERCURY","VENUS","EARTH","MOON","MARS"
330 DATA "JUPITER","SATURN","URANUS","NEPTUNE"
340 FOR J=1 TO 9: READ PL$(J): NEXT
350 REM
360 REM    PLANETARY GM'S (KM^3/S^2)
370 DATA  22032, 324860, 398600, 4902, 42828
380 DATA  125680000, 37931000, 5793900, 6835000
390 FOR J=1 TO 9: READ GM(J): NEXT
400 REM
410 REM    PLANETARY J2'S
420 DATA 0.00006, 0.0000186, 0.001083, 0.0002027
430 DATA 0.00196,0.014736,0.016480,0.003345,0.0043
440 FOR J=1 TO 9: READ J2(J): NEXT
450 REM
460 REM    PLANETARY RADII (KM)
470 DATA  2440, 6050, 6378, 1738, 3398
480 DATA  71492, 60268, 25559, 24760
490 FOR J=1 TO 9: READ R(J): NEXT
500 RETURN
510 REM
520 REM  This program by Anthony Mallama predicts how
530 REM  a satellite in a low orbit around the Earth
540 REM  or any other planet will change due to the 
550 REM  planet's equatorial bulge.  It is described
560 REM  fully in Sky & Telescope, May, 1990, page 543.
