'  newton's method for z^n = 1

'  declarations from compfun library
DECLARE FUNCTION amin (x, y)
DECLARE SUB cabs (x, y, r)
DECLARE SUB rpower (x, y, p, u, v)
DEFINT I-N

' set defaults for 320 x 200 x 256 screen
iscr = 13: ncol = 256: SCREEN iscr: CLS
GOSUB setpal

' set parameters
x1 = -2: x2 = 2: y1 = -1.25: y2 = 1.25
nx = 319: ny = 199: itermax = ncol
n = 4: omn = 1 - n: oon = 1 / n

' determine pixel steps & convergence tolerance
dx = (x2 - x1) / nx: dy = (y2 - y1) / ny
tol = amin(ABS(dx), ABS(dy))

' begin iterating
FOR j = 0 TO ny
  yc = j * dy + y1
  FOR i = 0 TO nx
     IF INKEY$ <> "" GOTO endd
     xc = i * dx + x1
     zx = xc: zy = yc
     FOR iter = 1 TO itermax

'  check for convergence
CALL rpower(zx, zy, omn, u, v)
xd = oon * (u - zx): yd = oon * (v - zy)
CALL cabs(xd, yd, d)
IF d < tol GOTO small
      
'  perform iteration
  zx = zx + xd: zy = zy + yd
  NEXT iter
  k = 1

small:  'modular coloring
  k = iter MOD (ncol - 1)
   
clrpix:  'color the pixel
  PSET (i, j), k
   
    NEXT i
  NEXT j

'  hang out and view the image until a key is pressed
stopp:
WHILE INKEY$ = "": WEND
endd: END

setpal:
OPEN "pastel.map" FOR INPUT AS #1
FOR i = 0 TO 255
  INPUT #1, ir&, ig&, ib&
  ir& = ir& / 4: ig& = ig& / 4: ib& = ib& / 4
  l& = 65536 * ib& + 256 * ig& + ir&
  PALETTE i, l&
  NEXT i
CLOSE #1
RETURN

