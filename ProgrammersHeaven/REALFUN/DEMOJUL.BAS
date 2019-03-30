'  julia set:  z -> z * z + c

'  declarations from compfun.lib
DECLARE SUB cmult (x1, y1, x2, y2, u, v)
DECLARE SUB cabs (x, y, r)
DEFINT I-N

' set defaults for 320 x 200 x 256 screen
iscr = 13: ncol = 256: SCREEN iscr: CLS
GOSUB setpal

' set parameter ranges
x1 = -2: x2 = 2: y1 = -1.25: y2 = 1.25
nx = 319: ny = 199: itermax = ncol
xc = -.75: yc = .1: zmax = 2

' determine pixel steps
dx = (x2 - x1) / nx: dy = (y2 - y1) / ny

' begin iterating
FOR j = 0 TO ny
  zy0 = j * dy + y1
  FOR i = 0 TO nx
     IF INKEY$ <> "" GOTO endd
     zx0 = i * dx + x1
     zx = zx0: zy = zy0
     FOR iter = 1 TO itermax

'  check size of z before iterating
CALL cabs(zx, zy, zr)
IF zr > zmax GOTO bigg
      
'  perform iteration
  CALL cmult(zx, zy, zx, zy, u, v)
  zx = u + xc: zy = v + yc
  NEXT iter
  k = 0: GOTO clrpix

bigg:  'modular coloring
  k = iter MOD (ncol - 1)
   
clrpix:  'color the pixel
  PSET (i, j), k
   
    NEXT i
  NEXT j

'  hang out and view the image until a key is pressed
stopp:
WHILE INKEY$ = "": WEND
STOP
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

