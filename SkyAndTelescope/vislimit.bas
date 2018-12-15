10 REM VISLIMIT.BAS Visual Limits
20 REM by Bradley E. Schaefer
30 FOR I=1 TO 5 : READ WA(I) : NEXT I
40 DATA 0.365, 0.44, 0.55, 0.7, 0.9
50 FOR I=1 TO 5 : READ MO(I) : NEXT I
60 DATA -10.93, -10.45, -11.05, -11.90, -12.70
70 RD=3.14159/180.0
80 REM  Input for Moon and Sun
90 AM=180.0 : REM Moon phase (deg.; 0=FM, 90=FQ/LQ, 180=NM)
100 ZM=180.0 : REM Zenith distance of Moon (deg.)
110 RM=180.0 : REM Angular distance to Moon (deg.)
120 ZS=180.0 : REM Zenith distance of Sun (deg.)
130 RS=180.0 : REM Angular distance to Sun (deg.)
140 REM  Input for the Site, Date, Observer
150 RH=40.0 : REM relative humidity (%)
160 TE=15.0 : REM Air temperature (deg. C)
170 LA=30.0 : REM Latitude (deg.)
180 AL=1000.0 : REM Altitude above sea level (m)
190 M=2.0 : REM Month (1=Jan, 12=Dec)
200 Y=1998.0 : REM Year
210 SN=1.0 : REM Snellen Ratio (20/20=1.0, good 20/10=2.0)
220 INPUT "Zenith distance (deg.): ";Z
230 GOSUB 1000 : REM Extinction
240 GOSUB 2000 : REM Sky
250 REM  Visual limiting magnitude
260 BL=B(3)/1.11E-15 : REM in nanolamberts
270 IF BL>1500.0 THEN GOTO 300
280 C1=10.0^-9.8: C2=10.0^-1.9
290 GOTO 310
300 C1=10.0^-8.350001 : C2=10.0^-5.9
310 TH=C1*((1.0+SQR(C2*BL))^2.0) : REM in foot-candles
320 MN=-16.57-2.5*(LOG(TH)/LOG(10))-DM(3)+5.0*(LOG(SN)/LOG(10))
330 PRINT : REM  Write results and stop program
340 PRINT USING "Visual Sky Brightness (nL): ######"; BL
350 PRINT USING "Visual Limiting Magnitude:  ###.##"; MN
360 END
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
1170 KA=KA*((1-.32/LOG(RH/100.0))^1.33)*(1+0.33*SL*SIN(RA))
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
2290 BT=BT*(100/RS)*(1.0-10.0^(-.4*K(I)*X))
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
9991 REM ==============================
9992 REM FROM "ASTRONOMICAL COMPUTING," 
9993 REM SKY & TELESCOPE, MAY 1998
9994 REM ==============================
