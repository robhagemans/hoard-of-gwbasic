10 '             THE GREEN FLASH
20 '
30 INPUT "Height of observer in feet";H
40 INPUT "Zenith dist. of occulting edge (deg)";Z0
50 INPUT "Aerosol extinction (mag/air mass)";KD
60 INPUT "Occult bottom (B) or top (T) of Sun";Q$
70    TB=1: IF Q$="T" OR Q$="t" THEN TB=-1
80 PRINT: GOSUB 1590
90 DS=1:        '  Sun's distance in a.u.
100 RS=1:       '  Sun's radius in solar radii
110 TS=5700:    '  Sun's temperature (Kelvin)
120 D=0:        '  Sun's declination in degrees
130 MP=1:       '  Planet's mass in Earth masses
140 PE=1:       '  Planet's rotation period in days
150 R0=1:       '  Planet's radius in Earth radii
160 L=40:       '  Observer's latitude in degrees
170 P=1:        '  Sea-level pressure, bars
180 T0=10:      '  Air temperature in degrees Celsius
190 OZ=3:       '  Ozone layer thickness (mm at STP)
200 HS=12:      '  Ozone ht. (miles above sea level)
210 AA=-1.3:    '  Aerosol exponent (unitless)
220 AH=1:       '  Aerosol scale height (miles)
230 PP(1)=78:   '  Nitrogen percentage by volume
240 PP(2)=22:   '  Oxygen percentage
250 PP(3)=0:    '  Carbon dioxide
260 PP(4)=0:    '  Hydrogen
270 PP(5)=0:    '  Helium
280 PP(6)=0:    '  Methane
290 PP(7)=0:    '  Ammonia
300 PP(8)=0:    '  Argon
310 '
330 '        Convert input data to cgs units
340 DS=DS*1.496E+13: RS=RS*6.96E+10: ' cm
350 R0=R0*6.378E+8:  H=H*30.48:      ' cm
360 HS=HS*1.609E+5: AH=AH*1.609E+5:  ' cm
370 D=D*PI/180: L=L*PI/180: Z0=Z0*PI/180: ' radians
380 MP=MP*5.976E+27: ' grams
390 PE=PE*24*3600:   ' seconds
400 T0=T0+273.1:     ' degrees Kelvin
410 '
420 '      Calculate average molecular weight
430 MW=0
440 FOR IG=1 TO 8: MW=MW+MX(IG)*PP(IG)*.01: NEXT IG
450 '
460 '      Calculate atmospheric parameters
470 G=6.67E-8*MP*(R0^-2):' Acceleration of gravity
480 S=8.31E+7*T0/(G*MW): ' Atmospheric scale height
490 LA=-.4*T0/S:         ' Adiabatic lapse rate
500 '
510 '             Choose a color
520 FOR IC=1 TO 11
530   W=(IC*500+2500)*1E-8
540   '      Calculate index of refraction
550   N0=0
560   FOR IG=1 TO 8
570     NS=(A(IG)*.00001)*(1+(B(IG)*1E-11)/(W^2))
580     N0=N0+NS*PP(IG)*.01*P*273.1/T0
590   NEXT IG
600   N=1+N0*EXP(-H/S): '  At observer
610   N0=N0+1:          '  At sea level
620   '
630   '  Calc. refraction and air mass for each color
640   GOSUB 1510: '  Refraction subroutine
650   IF RF>RX THEN RX=RF
660   IF RF<RN THEN RN=RF
670   R(IC)=RF:  XR=AM
680   '
690   '  Calc. air transmission at occulting object
700   KR=1.13E-11*((N-1)^2)*(W^-4)
710   KA=KD*((W/.000055)^AA): CZ=COS(Z0)
720   XA=1/(CZ+.8*SQR(AH/R0)*EXP(-.38*CZ*SQR(R0/AH)))
730   KO=KS(IC)*OZ/3
740   XO=1/SQR(1-(SIN(Z0)/(1+((HS-H)/R0)))^2)
750   KX=KR*XR+KA*XA+KO*XO: IF KX>90 THEN KX=90
760   TR(IC)=10^(-.4*KX)
770   '
780   '  Calculate Sun's flux above atmosphere
790   BB=.0000374*(W^-5)/(EXP(1.43/(W*TS))-1)
800   FA(IC)=((RS/DS)^2)*BB*1E-8: '  in erg/cm2/s/A
810 NEXT IC
820 '
830 '   Pick relevant time range for calculations
840 CZ=COS(Z0+RN+TB*RS/DS)
850 HC=(CZ-SIN(D)*SIN(L))/(COS(D)*COS(L))
860 HA=ATN(SQR(1-HC*HC)/HC): IF HC<0 THEN HA=HA+PI
870 T1=HA*PE*.5/PI:  '  Time when lowest disk sets
880 CZ=COS(Z0+RX+TB*RS/DS)
890 HC=(CZ-SIN(D)*SIN(L))/(COS(D)*COS(L))
900 HA=ATN(SQR(1-HC*HC)/HC): IF HC<0 THEN HA=HA+PI
910 T2=HA*PE*.5/PI:  '  Time when highest disk sets
920 DT=(T2-T1)/50:   '  Choose a time increment
930 T0=T1-DT:        '  Define a fiducial time
940 PRINT " Time    x      y    V mag.  Color"
950 '
960 '   *****   Main loop starts here  *****
970 FOR IT=-1 TO 48
980    T=T1+IT*DT: '  Choose a time
990    TT=T-T0:    '  Seconds from start time
1000 '
1010 '          Cycle through wavelengths
1020 FOR IC=1 TO 11
1030   '  Calc. altitude of solar disk for that color
1040   HA=2*PI*T/PE: '  Hour angle of Sun
1050   CZ=SIN(D)*SIN(L)+COS(D)*COS(L)*COS(HA)
1060   ZA=ATN(SQR(1-CZ*CZ)/CZ): IF CZ<0 THEN ZA=ZA+PI
1070   ZA=ZA-R(IC): '  Zenith distance of Sun
1080   ' 
1090   '   Calculate the fraction of disk visible
1100   CC=(ZA-Z0)*TB*DS/RS
1110   IF CC>1 THEN CC=1: '  If nothing visible
1120   TH(IC)=ATN(SQR(1-CC*CC)/CC)
1130   IF CC<0 THEN TH(IC)=TH(IC)+PI
1140   FR=(TH(IC)-CC*SIN(TH(IC)))/PI
1150   '
1160   '   Calculate visible flux from Sun
1170   F(IC)=FA(IC)*TR(IC)*FR
1180 NEXT IC
1190 '
1200 '   (Could print out flux, F(IC) [ergs/cm2/s/A],
1210 '   as well as the Sun's stellar magnitude,
1220 '   M(IC)=-2.5*LOG(F(IC))/B0-(M0(IC)+20),
1230 '   as a function of the color IC, where
1240 '   1=3000A, 2=3500A, 3=4000A, ... , 11=8000A.)
1250 '
1260 XX=0: YY=0: ZZ=0
1270 FOR IC=1 TO 11
1280   XX=XX+X1(IC)*F(IC): '  X from CIE standard
1290   YY=YY+Y1(IC)*F(IC): '  Y from CIE standard
1300   ZZ=ZZ+Z1(IC)*F(IC): '  Z from CIE standard
1310 NEXT IC
1320 IF XX+YY+ZZ=0 THEN 1480
1330 X=XX/(XX+YY+ZZ): '  x
1340 Y=YY/(XX+YY+ZZ): '  y
1350 IF Y<=.01 THEN 1480: '  If invisible to eye
1360 PH=ATN((.333-X)/(Y-.333)):  ' Angle from white
1370 IF (Y-.333)<0 THEN PH=PH+PI:' in color diagram
1380 CO$="Violet"
1390   IF PH<4.229 THEN CO$= "  Blue"
1400   IF PH<2.580 THEN CO$= " Green"
1410   IF PH<1.106 THEN CO$= "Yellow"
1420   IF PH<0.359 THEN CO$= "Orange"
1430   IF PH<0.000 THEN CO$= "   Red"
1440 V=-2.5*LOG(.034*YY/2.54E-10)/B0: '  Visual mag.
1450 PRINT USING "##.##  ";TT;
1460 PRINT USING "##.##  ##.## ###.#  ";X;Y;V;
1470 PRINT CO$
1480 NEXT IT
1490 END
1500 '
1510 '      Refraction subroutine (quick version)
1520 N=1+(N0-1)*EXP(-H/S):    '  At observer
1530 BS=R0*SIN(Z0)/(R0+.5*S): BE=ATN(BS/SQR(1-BS*BS))
1540 R5=N*BS: RF=ATN(R5/SQR(1-R5*R5))-BE: CZ=COS(Z0)
1560 AM=1/(CZ+.8*SQR(S/R0)*EXP(-.38*CZ*SQR(R0/S)))
1570 RETURN
1580 '
1590 '        Constants and data statements
1600 RX=-1: RN=1
1610 PI=3.14159: B0=LOG(10): '  Pi and log-10 factor
1620 DIM A(8),B(8),PP(8),MX(8),KS(11),M0(11),X1(11)
1630 DIM Y1(11),Z1(11),R1(11),G1(11),B1(11),M(11)
1640 DIM R(11),TR(11),F(11),FA(11),LF(11),TH(11)
1650 FOR I=1 TO 8: READ A(I): NEXT I
1660 DATA 29.1, 26.6, 43.9, 13.6, 3.5, 43, 37, 27.9
1670 FOR I=1 TO 8: READ B(I): NEXT I
1680 DATA 7.7, 5.1, 6.4, 7.5, 2.3, 6.0, 12.0, 5.6
1690 FOR I=1 TO 8: READ MX(I): NEXT I
1700 DATA 28, 32, 44, 2, 4, 16, 17, 39.9
1710 FOR I=1 TO 11: READ KS(I): NEXT I
1720 DATA 3.2, .005, 0, .001, .012, .031, .044
1730 DATA .023, .008, .005, .001
1740 FOR I=1 TO 11: READ M0(I): NEXT I
1750 DATA 1.19, 0.95, 0.52, 0.46, 0.74, 1.06, 1.33
1760 DATA 1.6, 1.88, 2.1, 2.3
1770 FOR I=1 TO 11: READ X1(I): NEXT I
1780 DATA 0, 0, .014, .336, .005, .433, 1.062
1790 DATA .283, .011, 0, 0
1800 FOR I=1 TO 11: READ Y1(I): NEXT I
1810 DATA  0, 0, .0004, .038, .323, .995, .631
1820 DATA  .107, .004, .0001, 0
1830 FOR I=1 TO 11: READ Z1(I): NEXT I
1840 DATA 0, 0, .068, 1.773, .272, .009, 0,0,0,0,0
1850 FOR I=1 TO 11: READ R1(I): NEXT I
1860 DATA 0, 0, .025, -.039, -1.16, .097
1870 DATA .847, .989, 1, 0, 0
1880 FOR I=1 TO 11: READ G1(I): NEXT I
1890 DATA 0, 0, -.011, .0218, 1.39, .905, .154
1900 DATA .011, 0, 0, 0
1910 FOR I=1 TO 11: READ B1(I): NEXT I
1920 DATA 0, 0, .986, 1.017, .778, -.0025
1930 DATA -.0012, 0, 0, 0, 0
1940 RETURN
2000 '
2010 '    GFLASH.BAS -- This program by Dr. Bradley
2020 '    E. Schaefer predicts how the "green flash" 
2030 '    should look to an observer watching the 
2040 '    setting Sun.  Inputs can be varied to see 
2050 '    the effect of different atmospheric conditions
2060 '    and elevation above sea level.  The program
2070 '    is discussed in detail in Sky & Telescope, 
2080 '    February 1992, page 200.
