10 REM  CCDLIMIT.BAS CCD Limits
20 REM  by Bradley E. Schaefer
30 FOR I=1 TO 5 : READ WA(I) : NEXT I
40 DATA 0.365, 0.44, 0.55, 0.7, 0.9
50 FOR I=1 TO 5 : READ Q(I) : NEXT I
60 DATA 15.0, 25.0, 40.0, 56.0, 26.0
70 FOR I=1 TO 5 : READ MO(I) : NEXT I
80 DATA -10.93, -10.45, -11.05, -11.90, -12.70
90 REM  Input for position
100 RD=3.14159/180.0
110 INPUT "Zenith distance (deg.) : ";Z
120 AM=180.0 : REM Moon phase (deg.; 0=FM, 90=FQ/LQ, 180=NM)
130 ZM=180.0 : REM Zenith distance of Moon (deg.)
140 RM=180.0 : REM Angular distance to Moon (deg.)
150 ZS=180.0 : REM Zenith distance of Sun (deg.)
160 RS=180.0 : REM Angular distance to Sun (deg.)
170 REM  Input for the Site and Date
180 TS=1.0 : REM FWHM of seeing in V at zenith
190 RH=40.0 : REM relative humidity (%)
200 TE=15.0 : REM Air temperature (deg. C)
210 LA=30.0 : REM Latitude (deg.)
220 AL=1000.0 : REM Altitude above sea level (m)
230 M=2.0 : REM Month (1=Jan, 12=Dec)
240 Y=1998.0 : REM Year
250 REM  Input for the telescope and detector
260 D=20.32 : REM  Telescope aperture (cm)
270 TP=.91 : REM  Pixel size (")
280 DS=4.0 : REM  Diameter of secondary (cm)
290 NM=2 : REM  Number of mirrors (-)
300 NL=2 : REM  Number of lens/glass in path (-)
310 RN=15.0 : REM  Read noise of CCD (electrons)
320 INPUT "Enter V-band magnitude of star: ";MV
330 CI=.7 : REM  Color index [B-V] for star (mag)
340 INPUT "Exposure time (seconds): ";E
350 NR=1 : REM  Number of CCD readouts (-)
360 TA=1.0 : REM  Radius of photometry aperture (") [best : TA=~TS]
370 GOSUB 1000 : REM  Extinction subroutine
380 GOSUB 2000 : REM  Sky subroutine
390 REM  Calculate counts from star and sky
400 MA(1)=MV+2.35*CI-.6 : REM  U
410 MA(2)=MV+CI : REM  B
420 MA(3)=MV : REM  V
430 MA(4)=MV-.75*CI : REM  R
440 MA(5)=MV-1.6*CI : REM  I
450 GOSUB 3000 : REM  CT subroutine
460 REM  Calculate SNR (see PASP article for exact formula)
470 P=3.14159*(TA/TP)^2
480 IF P<1.0 THEN P=1.0
490 FOR I=1 TO 5
500 VA=NS(I)+P*NB(I)+P*NR*RN*RN
510 SN(I)=NS(I)/SQR(VA)
520 SI(I)=1.086/SN(I)
530 NEXT I
540 PRINT : PRINT "For star with U, B, V, R, I    ";
550 PRINT USING " #####.##"; MA(1), MA(2), MA(3), MA(4), MA(5)
560 PRINT " their respective SNR are      ";
570 PRINT USING " #####.##"; SN(1), SN(2), SN(3), SN(4), SN(5)
580 PRINT " with 1-sigma errors (mag.) of ";
590 PRINT USING " #####.##"; SI(1), SI(2), SI(3), SI(4), SI(5)
600 END
1000 REM Extinction Subroutine
1010 FOR I=1 TO 5: READ OZ(I): NEXT I
1020 DATA 0.000, 0.000, 0.031, 0.008, 0.000
1030 FOR I=1 TO 5: READ WT(I): NEXT I
1040 DATA 0.074, 0.045, 0.031, 0.020, 0.015
1050 LT=LA*RD
1060 RA=(M-3)*30.0*RD
1070 SL=LA/ABS(LA)
1080 REM  Airmass for each component
1090 ZZ=Z*RD
1100 XG=1/(COS(ZZ)+.0286*EXP(-10.5*COS(ZZ)))
1110 XA=1/(COS(ZZ)+.0123*EXP(-24.5*COS(ZZ)))
1120 XO=1/SQR(1.0-(SIN(ZZ)/(1.0+(20.0/6378.0)))^2)
1130 REM  UBVRI extinction for each component
1140 FOR I=1 TO 5
1150 KR=.1066*EXP(-1*AL/8200)*((WA(I)/.55)^-4)
1160 KA=.1*((WA(I)/.55)^-1.3)*EXP(-1*AL/1500)
1170 KA=KA*((1-.32/LOG(RH/100.0))^1.33)*(1+SL*SIN(RA))
1180 KO=OZ(I)*(3.0+.4*(LT*COS(RA)-COS(3*LT)))/3.0
1190 KW=WT(I)*.94*(RH/100.0)*EXP(TE/15)*EXP(-1*AL/8200)
1200 K(I)=KR+KA+KO+KW
1210 DM(I)=KR*XG+KA*XA+KO*XO+KW*XG
1220 NEXT I
1230 REM  Write results and return
1240 PRINT : PRINT "Airmass (gas, aerosol, ozone):   ";
1250 PRINT USING "####.## "; XG, XA, XO
1260 PRINT "Extinction Coefficients (UBVRI): ";
1270 PRINT USING "####.## "; K(1), K(2), K(3), K(4), K(5)
1280 PRINT "Total Extinction (UBVRI):        ";
1290 PRINT USING "####.## "; DM(1), DM(2), DM(3), DM(4), DM(5)
1300 RETURN
2000 REM  SKY Subroutine
2010 FOR I=1 TO 5: READ BO(I): NEXT I
2020 DATA 8.0E-14, 7.0E-14, 1.0E-13, 1.0E-13, 3.0E-13
2030 FOR I=1 TO 5: READ CM(I): NEXT I
2040 DATA 1.36, 0.91, 0.00, -0.76, -1.17
2050 FOR I=1 TO 5: READ MS(I): NEXT I
2060 DATA -25.96, -26.09, -26.74, -27.26, -27.55
2070 X=1/(COS(ZZ)+.025*EXP(-11*COS(ZZ))) : REM air mass
2080 XM=1/(COS(ZM*RD)+.025*EXP(-11*COS(ZM*RD))) : REM air mass Moon
2090 IF ZM>90.0 THEN XM=40.0
2100 XS=1/(COS(ZS*RD)+.025*EXP(-11*COS(ZS*RD))) : REM air mass Sun
2110 IF ZS>90.0 THEN XS=40.0
2120 FOR I=1 TO 5
2130 REM  Dark night sky brightness
2140 BN=BO(I)*(1+.3*COS(6.283*(Y-1992)/11))
2150 BN=BN*(.4+.6/SQR(1.0-.96*((SIN(ZZ))^2)))
2160 BN=BN*(10^(-.4*K(I)*X))
2170 REM  Moonlight brightness
2180 MM=-12.73+.026*ABS(AM)+4E-09*(AM^4) : REM moon mag in V
2190 MM=MM+CM(I) : REM Moon mag
2200 C3=10.0^(-.4*K(I)*XM)
2210 FM=6.2E+07*(RM^-2)+(10^(6.15-RM/40))
2220 FM=FM+(10^5.36)*(1.06+((COS(RM*RD))^2))
2230 BM=10^(-.4*(MM-MO(I)+43.27))
2240 BM=BM*(1-10^(-.4*K(I)*X))
2250 BM=BM*(FM*C3+440000.0*(1-C3))
2260 REM  Twilight brightness
2270 HS=90.0-ZS : REM Height of Sun
2280 BT=10^(-.4*(MS(I)-MO(I)+32.5-HS-(Z/(360*K(I)))))
2290 BT=BT*(100/RS)*(1.0-10.0^(-.4*K(I)))
2300 REM  Daylight brightness
2310 C4=10.0^(-.4*K(I)*XS)
2320 FS=6.2E+07*(RS^-2)+(10^(6.15-RS/40))
2330 FS=FS+(10^5.36)*(1.06+((COS(RS*RD))^2))
2340 BD=10^(-.4*(MS(I)-MO(I)+43.27))
2350 BD=BD*(1-10^(-.4*K(I)*X))
2360 BD=BD*(FS*C4+440000.0*(1-C4))
2370 REM  Total sky brightness
2380 IF BD>BT THEN GOTO 2410
2390 B(I)=BN+BD
2400 GOTO 2420
2410 B(I)=BN+BT
2420 IF ZM<90.0 THEN B(I)=B(I)+BM
2430 NEXT I
2440 PRINT "Sky brightness (UBVRI):";
2450 PRINT USING " ##.#^^^^"; B(1), B(2), B(3), B(4), B(5)
2460 RETURN
3000 REM  Subroutine CT
3010 FOR I=1 TO 5 : READ DL(I) : NEXT I
3020 DATA 0.068, 0.098, 0.089, 0.22, 0.24
3030 FOR I=1 TO 5 : READ RE(I) : NEXT I
3040 DATA 0.83, 0.86, 0.88, 0.87, 0.90
3050 FOR I=1 TO 5 : READ TR(I) : NEXT I
3060 DATA 0.970, 0.983, 0.987, 0.983, 0.980
3070 FOR I=1 TO 5 : READ TF(I) : NEXT I
3080 DATA 0.70, 0.70, 0.70, 0.70, 0.70
3090 REM  Seeing
3100 FOR I=1 TO 5
3110 X=1.0/(COS(Z/57.28))
3120 T1=(TS^2)*(X^1.2)*((WA(I)/.55)^-.4)
3130 T2=5.54*((3600.0*57.28*(WA(I)/10000.0)/D)^2)
3140 TT(I)=SQR(T1+T2) : REM  TOTAL SEEING FWHM (")
3150 NEXT I
3160 REM  Efficiencies
3170 FOR I=1 TO 5
3180 EF(I)=(Q(I)/100.0)*TF(I)*(RE(I)^NM)*(TR(I)^(2.0*NL))
3190 F(I)=1-EXP(-2.77*((TA/TT(I))^2)) : REM  Fraction in photometry aperture
3200 NEXT I
3210 A=(3.14159/4.0)*(D^2-DS^2) : REM  Light-collecting area
3220 REM  Source and sky counts
3230 FOR I=1 TO 5
3240 IN=10^(-.4*(MA(I)-MO(I)+DM(I)))
3250 PE=(WA(I)/10000.0)/(6.62E-27*2.997E+10)
3260 NS(I)=IN*F(I)*A*EF(I)*E*DL(I)*PE
3270 NB(I)=B(I)*A*EF(I)*E*DL(I)*PE*(TP^2)
3280 NEXT I
3290 PRINT : PRINT "Star counts in photometry aperture (UBVRI):";
3300 PRINT USING " #####."; NS(1), NS(2), NS(3), NS(4), NS(5)
3310 PRINT "Sky counts per pixel (UBVRI):       ";
3320 PRINT USING " #####."; NB(1), NB(2), NB(3), NB(4), NB(5)
3330 RETURN
9991 REM ==============================
9992 REM FROM "ASTRONOMICAL COMPUTING," 
9993 REM SKY & TELESCOPE, MAY 1998
9994 REM ==============================
