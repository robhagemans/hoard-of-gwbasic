10 '          MOON EFFECTS by Bradley E. Schaefer
20 DEFDBL A-Z
30 P2=2*3.14159: ' Radians in a full circle
40 INPUT "Year, month, day";Y,M,D
50 YY=Y-INT((12-M)/10)
60 MM=M+9: IF MM>=12 THEN MM=MM-12
70 K1=INT(365.25*(YY+4712))
80 K2=INT(30.6*MM+.5)
90 K3=INT(INT((YY/100)+49)*.75)-38
100 J=K1+K2+D+59: '  JD for dates in Julian calendar
110 IF J>2299160# THEN J=J-K3: ' For Gregorian calendar
120 '  J is the Julian date at 12h UT on day in question
130 '
140 '  Calculate illumination (synodic) phase
150 V=(J-2451550.1#)/29.530588853#: GOSUB 400: IP=V
160    AG=IP*29.53: ' Moon's age in days
170    IP=IP*P2: '    Convert phase to radians
180 '
190 '  Calculate distance from anomalistic phase
200 V=(J-2451562.2#)/27.55454988#: GOSUB 400: DP=V
210    DP=DP*P2: '  Convert to radians
220    DI=60.4-3.3*COS(DP)-.6*COS(2*IP-DP)-.5*COS(2*IP)
230 '
240 '  Calculate latitude from nodal (draconic) phase
250 V=(J-2451565.2#)/27.212220817#: GOSUB 400: NP=V
260    NP=NP*P2: ' Convert to radians
270    LA=5.1*SIN(NP)
280 '
290 '  Calculate longitude from sidereal motion
300 V=(J-2451555.8#)/27.321582241#: GOSUB 400: RP=V
310    LO=360*RP+6.3*SIN(DP)+1.3*SIN(2*IP-DP)+.7*SIN(2*IP)
320 '
330 PRINT USING "Moon's age from new (days):   ###";AG
340 PRINT USING "Distance (Earth radii):       ###";DI
350 PRINT USING "Ecliptic latitude (degrees):  ###";LA
360 PRINT USING "Ecliptic longitude (degrees): ###";LO
370 PRINT: INPUT "Continue (y or n)";Q$
380 IF Q$<>"N" AND Q$<>"n" THEN GOTO 40
390 END
400 '      Normalize values to range 0 to 1
410 V=V-INT(V): IF V<0 THEN V=V+1
420 RETURN
430 '
440 '    This program helps anyone who needs to know the Moon's 
450 '    phase (age), distance, and position along the ecliptic on
460 '    any date within several thousand years in the past or future.
470 '    To illustrate its application, Bradley Schaefer applied it 
480 '    to a number of famous events influenced by the Moon in 
490 '    World War II.  His article appeared in Sky & Telescope for
500 '    April 1994, page 86.
   