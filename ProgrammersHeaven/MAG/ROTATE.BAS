'     simple polygone routine
'  rotates a box, whilst making it shrink and grow
'       a bit ugly at the moment
'
SCREEN 9
GO:
angle2% = 360
size% = 50: way$ = "UP"
FOR anglething% = 1 TO 360
angle2% = angle2% - 1
IF way$ = "UP" THEN size% = size% + 1 ELSE size% = size% - 1
IF size% > 200 THEN way$ = "DOWN"
IF size% < 50 THEN way$ = "UP"
DRAW "C15 BM100, 100 S =" + VARPTR$(size%)
DRAW "D1 TA =" + VARPTR$(anglething%)
DRAW "D1 TA =" + VARPTR$(angle2%)
DRAW "U1 TA =" + VARPTR$(anglething%)
DRAW "NU1 TA  =" + VARPTR$(angle2%)
DRAW "R1 D1 NL1 U1 TA =" + VARPTR$(anglething%)
DRAW "U1 TA =" + VARPTR$(angle2%)
DRAW "L1 TA =" + VARPTR$(anglething%)
DRAW "D1 TA =" + VARPTR$(angle2%)
DRAW "D1 TA =" + VARPTR$(anglething%)
DRAW "U1 TA =" + VARPTR$(angle2%)
DRAW "R1 TA =" + VARPTR$(anglething%)
DRAW "BD1 TA =" + VARPTR$(anglething%)
DRAW "U1 TA =" + VARPTR$(angle2%)
DRAW " U1 "
SLEEP
LINE (4, 4)-(156, 156), 0, BF
LOCATE 20, 1: PRINT "ANGLE ="; anglething%; ", "; angle2%; "SIZE = "; size%
NEXT anglething%
angle2% = 360
GOTO GO

