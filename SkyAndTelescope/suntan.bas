10 '                 Suntan Program
20 '
30 GOSUB 920: ' Initialize data arrays
40 '
50 INPUT "Latitude in degrees";L:   LA=L/57.296
60 INPUT "Month (1-12)";M
70 INPUT "Hours from local noon";T:  T=ABS(T)
80 DS=.408*SIN(.523*(M-3.7)): ' Decl. of Sun (radians)
90 HA=.262*T: '            Hour angle of Sun (radians)
100 CZ=SIN(LA)*SIN(DS)+COS(LA)*COS(DS)*COS(HA)
110   IF CZ<=0 THEN 70
120 ZS=ATN(SQR(1-CZ*CZ)/CZ): '  Sun's zenith dist. (rad)
130 '
140 '   OPTION -- These two lines could replace 50-120:
150 '        INPUT "Altitude of Sun (deg)";AL
160 '        ZS=(90-AL)/57.296
170 '
180 INPUT "Height above sea level (feet)";HH:  H=HH/3280
190 INPUT "Aerosol extinction (V mag/airmass)";KK
200 BE=KK/2.36
210 INPUT "Surface albedo (%)";S1: SA=S1/100
220 '
230 '         Other adjustable parameters
240 '
250 ET=3600: ' Exposure time (seconds)
260 ZP=ZS: '   Angle (rad), zenith to surface normal
270 SS=0: '    Angle (rad), Sun to surface normal
280 TW=1: '    UV frac. transmitted by window, lotion...
290 F1=1: '    Fraction of sky that is clear
300 F2=1: '    Fraction of ground in sunlight
310 SH=1: '    Is Sun being shaded? (no=1, yes=0)
320 N=1: '     Normalization for skin type
330 RE=6378: ' Earth radius (km)
340 OL=0: '    Ozone loss (%)
350 HO=23: '   Height of ozone layer (km)
360 HG=8.2: '  Gas scale height (km)
370 HA=1.5: '  Aerosol scale height (km)
380 DS=1: '    Distance from Sun (a.u.)
390 '
400 '      Thickness of ozone layer
410 '
420 RA=30*(M-3.7)/57.296
430 DO=(1-OL/100)*(3+.4*(LA*COS(RA)-COS(3*LA)))
440 ' 
450 '      Airmass for each component
460 '
470 XO=(1-(SIN(ZS)/(1+((HO-H)/RE)))^2)^-.5
480 XG=1/(COS(ZS)+.01*SQR(HG)*EXP(-30*COS(ZS)/SQR(HG)))
490 XA=1/(COS(ZS)+.01*SQR(HA)*EXP(-30*COS(ZS)/SQR(HA)))
500 '
510 '      Do for each wavelength
520 '
530 PRINT "Wavelength   Ozone    Air    Action   Dose"
540 PRINT "(angstroms)  trans.  trans.  spectr.      "
550 ED=0
560 FOR J=1 TO 20
570 W=.275+J*.005: '  Wavelength (microns)
580 '
590 '      Brightness of sunlight, diffuse sky light,
600 '                  and ground light
610 KO=OZ(J)*(DO/3)
620 KG=.0107*EXP(-H/HG)*(W^-4)
630 KA=BE*(W^-1.3)
640 OT=10^(-.4*(KO*XO))
650 TA=10^(-.4*(KG*XG+KA*XA))
660 D=.5*(COS(ZS)^.33)
670 IS=FS(J)*OT*TA*TW*SH*COS(SS)*(DS^-2)
680 ID=FS(J)*OT*(1-TA)*D
690 ID=FS(J)*OT*(1-TA)*D*TA*SA+ID
700 ID=FS(J)*OT*((1-TA)^2)*SA*(D^2)+ID
710 ID=ID*TW*F1*(COS(ZS/2)^2)*(DS^-2)
720 IG=FS(J)*OT*SA*(TA+D*(1-TA))
730 IG=IG*TW*F2*(SIN(ZS/2)^2)*(DS^-2)
740 I=IS+ID+IG: ' Total flux on skin (erg/cm^2/sec/A)
750 '
760 '  Find effective dose by numerical integration
770 '      The "minimum erythema dose" at 2900A
780 '      is 2.3E6 erg/cm^2 (Parrish)
790 '
800 EF=I*ET*(AS(J)*N)*50/2.3E6
810 ED=ED+EF
820 PRINT USING F1$;W*10000;OT;TA;AS(J);EF
830 NEXT J
840 ' 
850 '             Report result
860 '
870 PRINT
880 PRINT USING "Total effective dose: ##.###";ED
890 PRINT USING "   (exposure time ##.## hr)";ET/3600
895 PRINT USING "Burning starts after ##.## hr";ET/(3600*ED)
899 '
900 END
910 '
920 '             Set up data arrays
930 '
940 F1$=   "  #####    ##.#### ##.####   ##.##   ##.###"
950 DIM OZ(20),FS(20),AS(20)
960 FOR J=1 TO 20: READ OZ(J): NEXT J
970 FOR J=1 TO 20: READ FS(J): NEXT J
980 FOR J=1 TO 20: READ AS(J): NEXT J
990 RETURN
1000 '
1010 '         OZ array (ozone effect)
1020 DATA 34, 25, 18, 9, 3.2, 1.8, .9, .46, .24, .17
1030 DATA .06, .05, .02, .01, .002, .001, 0, 0, 0, 0
1040 '
1050 '  FS array (solar flux at 1 A.U. in erg/cm^2/sec/A)
1060 DATA 24, 31, 38, 45, 52, 58, 64, 70, 75, 79
1070 DATA 83, 87, 91, 93, 95, 97, 99, 104, 107, 104
1080 '
1090 '  AS array (action spectrum, McKinley & Diffey)
1100 DATA 1, 1, 1, 1, .65, .22, .074, .025, .0086, .003
1110 DATA .0014, .0012, .00097, .00081, .00068, .00057
1120 DATA .00048, .0004, .00034, .00029
1200 '
1210 '   Bradley E. Schaefer's program takes into account many factors,
1220 '   including the ozone content of the atmosphere, and calculates
1230 '   the risk of getting a sunburn at any month of the year, at any
1240 '   hour of the day, and at any latitude on Earth. He explained how
1250 '   to interpret the results in the July 1993 issue of Sky & Telescope,
1260 '   page 83.
