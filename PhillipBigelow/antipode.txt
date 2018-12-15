5 REM antipode.bas
10 CLS
11 PRINT "                     ANTIPODE":PRINT
12 PRINT "A program to compute the antipode of any latitude and longitude on Earth"
13 PRINT "              Written by Phillip K. Bigelow":PRINT:PRINT:PRINT
14 PRINT "Enter data in degrees and parts of a degree (example: 34.075) (minutes":PRINT "and seconds are forbidden)":PRINT:PRINT
15 INPUT "Enter latitude of site (enter southern lats. as NEGATIVE)    ";A
20 INPUT "Enter longitude of site (enter western longs. as NEGATIVE)   ";B
30 PRINT:PRINT:PRINT:PRINT "__________________RESULTS____________________"
35 PRINT
40 IF A<0 THEN 100
50 IF A=0 THEN 110
60 IF A>0 THEN 120
100 LET Q=-A:PRINT "Latitude of antipode=",Q;"degrees N":GOTO 180
110 PRINT "Latitude of antipode=",A;"degrees":GOTO 180
120 PRINT "Latitude of antipode=",A;"degrees S":GOTO 180
121 REM
122 REM
123 REM
124 REM
180 IF A=90 THEN PRINT "Longitude is undefined at the poles":PRINT:GOTO 599
181 IF A=-90 THEN PRINT "Longitude is undefined at the poles":PRINT:GOTO 599
190 IF B<0 THEN 300
199 IF B=0 THEN PRINT "Longitude of antipode = 180 degrees":GOTO 599
200 IF B>0 THEN 400
201 REM Copyright Hell Creek Life, 2009 Phillip Bigelow
202 PRINT "Longitude of antipode=",L;"degrees W":PRINT:GOTO 599
210 PRINT "Longitude of antipode=",L;"degrees E":PRINT:GOTO 599
220 PRINT "Longitude of antipode=",L;"degrees E":PRINT:GOTO 599
300 LET B=-B:LET L=180-B:GOTO 220
400 LET L=180-B:GOTO 202
599 PRINT "_____________________________________________":PRINT
600 PRINT "                    MENU"
610 INPUT "Find another antipode (a), or exit to system/Windows (x)";JH$
620 IF JH$="a" THEN 10 ELSE SYSTEM
