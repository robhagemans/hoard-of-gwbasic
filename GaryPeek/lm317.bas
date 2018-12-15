10 CLS
20 PRINT "LM317 Calculations"
30 PRINT
40 PRINT "V = Enter the voltage, find the resistor from `ADJ' to ground (R2)"
50 PRINT "R = Enter the resistor from `ADJ' to ground (R2), find the voltage"
60 PRINT "T = Display a table of standard 5% AND 1% resistor values"
70 PRINT "    Enter R, V, T, or hit ESCape to quit"
80 IN$=INKEY$:IF IN$="" THEN 80
90 IF IN$=CHR$(27) THEN END
100 IF IN$="V" OR IN$="v" THEN GOSUB 500:GOSUB 200:GOTO 10
110 IF IN$="R" OR IN$="r" THEN GOSUB 500:GOSUB 400:GOTO 10
120 IF IN$="T" OR IN$="t" THEN GOSUB 800:GOTO 10
130 GOTO 80
190 REM -----
200 PRINT
210 INPUT "Enter voltage from 1.25 to 30 volts";V
220 IF V<1.25 OR V>30 THEN 200
230 R2=R1*((V/1.25)-1)
240 PRINT "For";V;"volts use a";R2;"ohm resistor for R2"
250 GOSUB 600:REM WAIT FOR KEY
260 RETURN
390 REM ----------
400 PRINT
410 INPUT "Enter resistor value from 0 to 5600 ohms";R2
420 IF R2<0 OR R2>5600 THEN 400
430 V=1.25*(1+(R2/R1))
440 PRINT "A";R2;"ohm resistor for R2 will produce";V;"volts"
450 GOSUB 600:REM WAIT FOR KEY
460 RETURN
490 REM ----------
500 PRINT
510 PRINT "Resistor from `VOUT' to `ADJ' pins (R1) is normally 240 ohms as in databook"
520 INPUT "Hit `ENTER' to default to 240, or enter a value from 100 to 500";R1
530 IF R1=0 THEN R1=240
540 IF R1<100 OR R1>500 THEN 500
550 RETURN
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