10 REM - IMPACT CRATER DIMENSIONS
20 CLS : PI=3.14159
30 CR1=18: CD1=9
40 PRINT "Terrestrial Impact Crater"
50 INPUT "  Impactor diameter (m)";ID
60 INPUT "  Impactor density (kg/m^3)";IR
70 INPUT "  Impactor velocity (km/s)";IK
80 INPUT "  Graze angle (deg. from horiz.)";GA
90 IV=IK*1000: VI=PI*ID*ID*ID/6
100 GF=(SIN(GA/180*PI))^.33
110 MI=IR*VI: KE=.5*MI*IV*IV
120 KT=KE/4.2E+12: REM impactor KE in kT TNT
130 PRINT: PRINT "Impactor Parameters"
140 PRINT USING "  Volume ##.##^^^^ m^3"; VI
150 PRINT USING "    Mass ##.##^^^^ kg"; MI
160 PRINT USING "      KE ##.##^^^^ J"; KE
170 PRINT USING "         ##.##^^^^ kT TNT"; KT
180 CD=2*CR1*KT^.3*GF: CA=CD*1.25
190 CZ=CD1*KT^.3*GF: CL=CZ*1.25
200 CV=.5*PI*CD*CD/4*CZ
210 CE=2.15*CD
220 PRINT: PRINT "Crater Parameters"
230 PRINT "  Diameter --"
240 PRINT USING "    Actual   ###### m"; CD
250 PRINT USING "    Apparent ###### m"; CA
260 PRINT "  Depth --"
270 PRINT USING "    Actual    ##### m"; CZ
280 PRINT USING "    Apparent  ##### m"; CL
290 PRINT USING "  Target removed ##.##^^^^ m^3"; CV
300 PRINT USING "  Ejecta spread     ###### m"; CE
310 REM  ========================
320 REM  FROM "ASTRONOMICAL
330 REM  COMPUTING," SKY & TELE-
340 REM  SCOPE, NOVEMBER 1996
350 REM ========================
360 END