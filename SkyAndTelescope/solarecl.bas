10 REM      LOCAL CIRCUMSTANCES OF A
20 REM           SOLAR ECLIPSE
30 REM
40 DEFDBL A-Z
50 GOSUB 760: PRINT D$: PRINT
60 GOSUB 630
70 INPUT "Universal time (h,m)";HH,MM
80 IF HH=99 THEN 110
90 UT=HH+MM/60: REM  UT in hours
100 GOSUB 140: GOTO 70
110 END
120 REM     ****   SUBROUTINES  ****
130 REM
140 REM    Compute details at time UT
150 T=UT+DT/3600-T0: REM  "Element time"
160 X=FNX(T):        REM  x
170 Y=FNY(T):        REM  y
180 CD=FNC(T):       REM  cos(d)
190 SD=FNS(T):       REM  sin(d)
200 M=DR*FNM(T):     REM  mu
210 REM
220 REM  Now find H.A. in radians
230 H=M+LO-DT/13713
240 REM
250 REM  Now find xi, eta, zeta
260 X8=P9*SIN(H)
270 Y8=P8*CD-P9*SD*COS(H)
280 Z8=P8*SD+P9*CD*COS(H)
290 U0=X-X8:         REM  u
300 V0=Y-Y8:         REM  v
310 L1=FNL1(T):      REM  l1
320 L2=FNL2(T):      REM  l2
330 W1=L1-Z8*F1:     REM  L1
340 W2=L2-Z8*F2:     REM  L2
350 REM
360 REM   Magnitude
370 G1=SQR(U0*U0+V0*V0)
380 G=(W1-G1)/(W1+W2)
390 REM
400 REM   Position angle
410 PA=RD*ATN(U0/V0)
420 IF V0<0 THEN PA=PA+180
430 IF PA<0 THEN PA=PA+360
440 IF PA>360 THEN PA=PA-360
450 REM
460 REM   Sun's altitude
470 A8=SD*SIN(LA)
480 A8=A8+CD*COS(LA)*COS(H)
490 AL=RD*ATN(A8/SQR(1-A8*A8))
500 REM
505 REM
510 REM   Print out a line of data
520 REM
530 UT=T-DT/3600+T0: REM  "Element time" back to UT
540 UT=UT+.5/3600: REM  Round to whole second
550 HH=INT(UT): M3=60*(UT-HH): MM=INT(M3)
560 SS=INT(60*(M3-MM))
570 PA=INT(PA+.5): AR=INT(AL+.5): REM  Whole degrees
580 IF AL<0 THEN PRINT "Sun below horizon": GOTO 610
590 IF G<0 THEN PRINT "No eclipse at this time": GOTO 610
600 PRINT USING A2$;HH;MM;SS;PA;AR;G
610 RETURN
620 REM
630 REM    Geocentric Coordinates of Observer
640 REM
650 INPUT "North latitude (deg)   ";LA
660 INPUT "East longitude (deg)   ";LO
670 INPUT "Elevation (feet)       ";EL
680 LA=LA*DR: LO=LO*DR: REM  Lat, long in radians
690 EL=EL*12/39.37:     REM  Elevation in meters
700 U=ATN(.99664719#*TAN(LA))
710 P8=.99664719#*SIN(U)+EL*SIN(LA)/6378140#
720 P9=COS(U)+EL*COS(LA)/6378140#
730 REM   P8 = rho sin(phi'); P9 = rho cos(phi')
740 RETURN
750 REM
760 REM          Constants
770 PI=3.141592653589793#: DR=PI/180: RD=1/DR
780 A2$=" UT ##:##:##   PA ###   Alt ###   Mag #.###"
790 REM
800 REM
810 REM          Eclipse elements
820 D$="Total Solar Eclipse of July 11, 1991"
830 T0=16: REM   Reference time (hr)
840 DT=0:  REM   Delta-T (sec) in sense ET-UT
850 DEF FNX(T)=-1.75954169#+T*(+.56710171#+T*(+4.902E-05-T*9.60E-06))
860 DEF FNY(T)=+.42232901#+T*(-.13699808#+T*(-1.7527E-04+T*.0000025))
870 DEF FNS(T)=+.37643393#+T*(-8.389E-05+T*(-.0000001))
880 DEF FNC(T)=+.92644352#+T*(+3.404E-05+T*(+4E-08))
890 DEF FNM(T)=58.6389581#+T*(15.0000486#+T*(+1.65E-06-T*2E-08))
900 DEF FNL1(T)=.53024501#+T*(+1.0153E-04+T*(-1.278E-05))
910 DEF FNL2(T)=-.01606+T*(.000101+T*(-1.272E-05))
920 F1=.004599:  REM  tan(f1)
930 F2=.004576:  REM  tan(f2)
940 M1=.2618:    REM  mu' (radians/hr)
950 D1=-.000091: REM  d'  (radians/hr)
960 RETURN
1000 REM    For the partial and total phases of the July 11, 1991, 
1010 REM    solar eclipse, when you enter a series of Universal times, 
1020 REM    this program computes the position angle of the Moon's 
1030 REM    center from the Sun, the Sun's altitude, and the "magnitude"
1040 REM    of the eclipse (that is, the fraction of the solar disk 
1050 REM    diameter that is hidden).  When entering your longitude and 
1060 REM    longitude, use positive degrees for north latitude and 
1070 REM    *negative* degrees for west longitude.  The results of this
1080 REM    program agree exactly with those published by the U. S. Naval
1090 REM    Observatory in its eclipse circular.  The program was written
1100 REM    by Roger W. Sinnott.
