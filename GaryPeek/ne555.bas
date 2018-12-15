10 CLS
20 PRINT "555 Timer Calculations for Typical Astable Oscillator"
30 PRINT
50 PRINT "R = Enter the resistor and capacitor values, find the period and frequency"
60 PRINT "T = Display a table of standard 5% AND 1% resistor values"
70 PRINT "    Enter R, T, or hit ESCape to quit"
80 IN$=INKEY$:IF IN$="" THEN 80
90 IF IN$=CHR$(27) THEN END
110 IF IN$="R" OR IN$="r" THEN GOSUB 200:GOTO 10
120 IF IN$="T" OR IN$="t" THEN GOSUB 800:GOTO 10
130 GOTO 80
190 REM -----
200 PRINT
210 INPUT "Enter RA in ohms (resistor from + to pin 7) ";RA
220 IF RA<0 THEN 210
230 INPUT "Enter RB in ohms (resistor from pin 7 to pins 2 and 6) ";RB
240 IF RB<0 THEN 230
250 INPUT "Enter C in microfarads (capacitor from pins 2 and 6 to ground) ";C
260 IF C<0 THEN 250
270 F=1.44/((RA+(2*RB))*(C/1000000))
280 P=1/F
290 HP=.693*(RA+RB)*(C/1000000):LP=.693*(RB)*(C/1000000)
300 PRINT:PRINT "For RA =";RA;"ohms, RB =";RB;"ohms, and C =";C;"microfarads"
310 PRINT "Frequency ";:PRINT USING "########.####";F
320 PRINT "Period in seconds ";:PRINT USING "####.##########";P
330 PRINT "Time high in seconds ";:PRINT USING "####.##########";HP
340 PRINT "Time low in seconds ";:PRINT USING "####.##########";LP
350 PRINT "Percentage of time high  ";:PRINT USING "##.###";P*25/LP
360 PRINT "Percentage of time low  ";:PRINT USING "##.###";P*25/HP
370 GOSUB 600:REM WAIT FOR KEY
380 RETURN
590 REM -----
600 PRINT:PRINT
610 PRINT "Hit any key to continue";
620 IN$=INKEY$:IF IN$="" THEN 620
630 RETURN
770 REM ----------
790 REM DISPLAY TABLE OF STANDARD RESISTOR VALUES
800 PRINT
810 PRINT "Standard 5% resistor base values (divide or multiply by 10 for other values)"
820 RESTORE 1500
830 FOR VALUE=1 TO 24
840 READ R
850 PRINT USING "##";R;:PRINT " ";
860 NEXT VALUE
870 REM ---
880 PRINT:PRINT
890 PRINT "Standard 1% resistor base values (divide or multiply by 10 for other values)"
900 RESTORE 2000
910 COL=0
920 FOR VALUE=1 TO 96
930 READ R
940 PRINT USING "###";R;:PRINT " ";
950 COL=COL+1
960 IF COL=19 THEN COL=0:PRINT
970 NEXT VALUE
980 GOTO 600
990 REM ----------
1000 REM 5% RESISTOR VALUES
1500 DATA 10,11,12,13,15,16,18,20,22,24,27,30,33,36,39
1510 DATA 43,47,51,56,62,68,75,82,91
1980 REM -----
1990 REM 1% RESISTOR VALUES
2000 DATA 100,102,105,107,110,113,115,118,121,124,127
2010 DATA 130,133,137,140,143,147,150,154,158,162,165,169
2020 DATA 174,178,182,187,191,196,200,205,210,215
2030 DATA 221,226,232,237,243,249,255,261,267,274,280
2040 DATA 287,294,301,309,316,324,332,340,348,357,365,374,383,392
2050 DATA 402,412,422,432,442,453,464,475,487,499
2060 DATA 511,523,536,549,562,576,590,604,619,634,649,665,681,698
2070 DATA 715,732,750,768,787,806,825,845,866,887,909,931,953,976
