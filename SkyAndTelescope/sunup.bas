10 '         Sunrise-Sunset
20 GOSUB 300
30 INPUT "Lat, Long (deg)";B5,L5
40 INPUT "Time zone (hrs)";H
50 L5=L5/360: Z0=H/24
60 GOSUB 1170: T=(J-2451545)+F
70 TT=T/36525+1: ' TT = centuries
80 '               from 1900.0
90 GOSUB 410: T=T+Z0
100 '
110 '       Get Sun's Position
120 GOSUB 910: A(1)=A5: D(1)=D5
130 T=T+1
140 GOSUB 910: A(2)=A5: D(2)=D5
150 IF A(2)<A(1) THEN A(2)=A(2)+P2
160 Z1=DR*90.833: ' Zenith dist.
170 S=SIN(B5*DR): C=COS(B5*DR)
180 Z=COS(Z1): M8=0: W8=0: PRINT
190 A0=A(1): D0=D(1)
200 DA=A(2)-A(1): DD=D(2)-D(1)
210 FOR C0=0 TO 23
220 P=(C0+1)/24
230 A2=A(1)+P*DA: D2=D(1)+P*DD
240 GOSUB 490
250 A0=A2: D0=D2: V0=V2
260 NEXT
270 GOSUB 820: '  Special msg?
280 END
290 '
300 '        Constants
310 DIM A(2),D(2)
320 P1=3.14159265: P2=2*P1
330 DR=P1/180: K1=15*DR*1.0027379
340 S$="Sunset at  "
350 R$="Sunrise at "
360 M1$="No sunrise this date"
370 M2$="No sunset this date"
380 M3$="Sun down all day"
390 M4$="Sun up all day"
400 RETURN
410 '     LST at 0h zone time
420 T0=T/36525
430 S=24110.5+8640184.813*T0
440 S=S+86636.6*Z0+86400*L5
450 S=S/86400: S=S-INT(S)
460 T0=S*360*DR
470 RETURN
480 '
490 '  Test an hour for an event
500 L0=T0+C0*K1: L2=L0+K1
510 H0=L0-A0: H2=L2-A2
520 H1=(H2+H0)/2: '  Hour angle,
530 D1=(D2+D0)/2: '  declination,
540 '                at half hour
550 IF C0>0 THEN 570
560 V0=S*SIN(D0)+C*COS(D0)*COS(H0)-Z
570 V2=S*SIN(D2)+C*COS(D2)*COS(H2)-Z
580 IF SGN(V0)=SGN(V2) THEN 800 
590 V1=S*SIN(D1)+C*COS(D1)*COS(H1)-Z
600 A=2*V2-4*V1+2*V0: B=4*V1-3*V0-V2
610 D=B*B-4*A*V0: IF D<0 THEN 800
620 D=SQR(D)
630 IF V0<0 AND V2>0 THEN PRINT R$;
640 IF V0<0 AND V2>0 THEN M8=1
650 IF V0>0 AND V2<0 THEN PRINT S$;
660 IF V0>0 AND V2<0 THEN W8=1
670 E=(-B+D)/(2*A)
680 IF E>1 OR E<0 THEN E=(-B-D)/(2*A)
690 T3=C0+E+1/120: ' Round off
700 H3=INT(T3): M3=INT((T3-H3)*60)
710 PRINT USING "##:##";H3;M3;
720 H7=H0+E*(H2-H0)
730 N7=-COS(D1)*SIN(H7)
740 D7=C*SIN(D1)-S*COS(D1)*COS(H7)
750 AZ=ATN(N7/D7)/DR
760 IF D7<0 THEN AZ=AZ+180
770 IF AZ<0 THEN AZ=AZ+360
780 IF AZ>360 THEN AZ=AZ-360
790 PRINT USING ",  azimuth ###.#";AZ
800 RETURN
810 '
820 '   Special-message routine
830 IF M8=0 AND W8=0 THEN 870
840 IF M8=0 THEN PRINT M1$
850 IF W8=0 THEN PRINT M2$
860 GOTO 890
870 IF V2<0 THEN PRINT M3$
880 IF V2>0 THEN PRINT M4$
890 RETURN
900 '
910 '   Fundamental arguments
920 '     (Van Flandern &
930 '     Pulkkinen, 1979)
940 L=.779072+.00273790931*T
950 G=.993126+.0027377785*T
960 L=L-INT(L): G=G-INT(G)
970 L=L*P2: G=G*P2
980 V=.39785*SIN(L)
990 V=V-.01000*SIN(L-G)
1000 V=V+.00333*SIN(L+G)
1010 V=V-.00021*TT*SIN(L)
1020 U=1-.03349*COS(G)
1030 U=U-.00014*COS(2*L)
1040 U=U+.00008*COS(L)
1050 W=-.00010-.04129*SIN(2*L)
1060 W=W+.03211*SIN(G)
1070 W=W+.00104*SIN(2*L-G)
1080 W=W-.00035*SIN(2*L+G)
1090 W=W-.00008*TT*SIN(G)
1100 '
1110 '    Compute Sun's RA and Dec
1120 S=W/SQR(U-V*V)
1130 A5=L+ATN(S/SQR(1-S*S))
1140 S=V/SQR(U):D5=ATN(S/SQR(1-S*S))
1150 R5=1.00021*SQR(U)
1160 RETURN
1165 '
1170 '     Calendar --> JD
1180 INPUT "Year, Month, Day";Y,M,D
1190 G=1: IF Y<1583 THEN G=0
1200 D1=INT(D): F=D-D1-.5
1210 J=-INT(7*(INT((M+9)/12)+Y)/4)
1220 IF G=0 THEN 1260
1230 S=SGN(M-9): A=ABS(M-9)
1240 J3=INT(Y+S*INT(A/7))
1250 J3=-INT((INT(J3/100)+1)*3/4)
1260 J=J+INT(275*M/9)+D1+G*J3
1270 J=J+1721027+2*G+367*Y
1280 IF F>=0 THEN 1300
1290 F=F+1: J=J-1
1300 RETURN
1310 '
1320 '   This program by Roger W. Sinnott calculates the times of sunrise
1330 '   and sunset on any date, accurate to the minute within several
1340 '   centuries of the present.  It correctly describes what happens in the 
1350 '   arctic and antarctic regions, where the Sun may not rise or set on
1360 '   a given date.  Enter north latitudes positive, west longitudes
1370 '   negative.  For the time zone, enter the number of hours west of
1380 '   Greenwich (e.g., 5 for EST, 4 for EDT).  The calculation is
1390 '   discussed in Sky & Telescope for August 1994, page 84.
  