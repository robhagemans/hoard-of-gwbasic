10 REM Compute Black-Hole Tidal Force Upon Body
20 REM G = Grav. constant
30 REM M = Mass, solar masses
40 REM L = separation, km
50 REM C = circumference, km
60 REM A = difference in acceleration, km/sec**2
70 C=100000
80 G=1.327E11
90 P=3.14159
100 M=303
110 FOR L=.002 TO .004 STEP .001
120 A=16*P*P*P*G*M*L/(C*C*C)
130 REM Convert to meters and g units
140 L1=L*1000: A=(A*1000)/9.81
150 PRINT USING "Length: ###.# meters, Tidal Force: ###.# g";L1;A
160 NEXT L
170 REM  ========================
180 REM  FROM "ASTRONOMICAL
190 REM  COMPUTING," SKY & TELE-
200 REM  SCOPE, MAY 1996
210 REM ========================
220 END
