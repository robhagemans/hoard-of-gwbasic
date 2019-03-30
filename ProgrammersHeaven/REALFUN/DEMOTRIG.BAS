DECLARE FUNCTION sind (x)
DECLARE FUNCTION cosd (x)
DECLARE FUNCTION tand (x)
DECLARE FUNCTION sinh (x)
DECLARE FUNCTION cosh (x)
DECLARE FUNCTION tanh (x)
DECLARE FUNCTION atan (y, x)
DEFINT I-N: CLS

PRINT "circular & hyperbolic trigonometric functions": PRINT
PRINT "degrees  radians     cos      sin      tan     cosh     sinh     tanh": PRINT
format$ = "   ###     #.###   ##.###   ##.###   ##.###   ##.###   ##.###   ##.###"
FOR i = 0 TO 180 STEP 10
  td = i: IF i = 90 THEN td = 89
  xc = cosd(td): yc = sind(td): zc = tand(td)
  tr = atan(yc, xc)
  xh = cosh(tr): yh = sinh(tr): zh = tanh(tr)
  PRINT USING format$; td; tr; xc; yc; zc; xh; yh; zh
  NEXT i


