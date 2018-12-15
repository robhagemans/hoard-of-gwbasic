10 REM Compute Mass of Black Hole
20 REM Print Data for M vs C vs P Plot
30 REM C0 = orbital circumference, km
40 REM P0 = orbital period, seconds
50 REM G = gravitational constant
60 G=1.327E11
70 P=3.14159
80 OPEN "OUTPUT.TXT" FOR OUTPUT AS #1
90 FOR C0=1E5 TO 1E7 STEP 2E5
100 PRINT#1, "C0 is: "; C0
110 FOR P0=10 TO 1000 STEP 10
120 M=C0*C0*C0/(2*P*G*P0*P0)
130 PRINT#1, P0, M
140 NEXT P0
150 NEXT C0
160 CLOSE#1
170 REM  ========================
180 REM  FROM "ASTRONOMICAL
190 REM  COMPUTING," SKY & TELE-
200 REM  SCOPE, MAY 1996
210 REM ========================
220 END
