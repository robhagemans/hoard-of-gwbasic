DECLARE FUNCTION atan (y, x)
DECLARE FUNCTION atand (y, x)
DECLARE FUNCTION datan# (dy#, dx#)
DECLARE FUNCTION datand# (dy#, dx#)

CLS : PRINT "enter any 2 numbers x and y"
INPUT "x, y"; dx#, dy#: x = dx#: y = dy#

PRINT : PRINT "single precision:"
t = atan(y, x)
PRINT "angle = "; t; " radians"
PRINT "     - or -"
t = atand(y, x)
PRINT "angle = "; t; " degrees"

PRINT : PRINT "double precision:"
dt# = datan#(dy#, dx#)
PRINT "angle = "; dt#; " radians"
PRINT "     - or -"
dt# = datand#(dy#, dx#)
PRINT "angle = "; dt#; " degrees"

