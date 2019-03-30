'LAND.BAS by Marshall Drew-Brook

DECLARE FUNCTION distance! (a!, b!)
DECLARE FUNCTION palcalc& (r%, g%, b%)
RANDOMIZE TIMER
DEFINT A-Z

SCREEN 13

FOR tmp = 1 TO 63
 PALETTE tmp, palcalc&((63 - tmp) \ 2, 0, tmp \ 6)
NEXT
FOR tmp = 1 TO 63
 PALETTE tmp + 63, palcalc&((63 - tmp) \ 6, (63 - tmp) \ 6, (63 - tmp) \ 6)
NEXT
FOR tmp = 1 TO 63
 PALETTE tmp + 126, palcalc&(0, (63 - tmp) \ 6, 0)
NEXT

y = 85

FOR x = 0 TO 319

 y = y + INT(RND * 3 - 1)

 FOR t = 0 TO y
  a! = x
  b! = t
  c = INT(distance!(ABS(160 - a!), ABS(100 - b!)))
  c = c \ 3 + 1
  PSET (x, t), c
 NEXT

 FOR t = y + 1 TO 199 STEP 2
  a! = x
  b! = t
  c = (t - y) \ 2 + 64
  IF c > 126 THEN c = 126
  PSET (x, t), c
  PSET (x, t + 1), c
  IF t < y + 126 AND RND > .95 THEN
   c = (t - y) \ 2 + 127
   LINE (x - 3, t - 2)-(x - 1, t), c, BF
   LINE (x - 4, t - 1)-(x - 4, t), c
   LINE (x, t - 1)-(x, t), c
   PSET (x - 2, t - 3), c
   PSET (x - 2, t + 1), c
  END IF
 NEXT

NEXT

DEF SEG = &HA000
BSAVE "land.scr", 0, 64000
DEF SEG
nul$ = SPACE$(7)
g$ = SPACE$(16000)
OPEN "land.scr" FOR BINARY AS #1
OPEN "land.dat" FOR BINARY AS #2
GET #1, , nul$
GET #1, , g$
PUT #2, , g$
GET #1, , g$
PUT #2, , g$
GET #1, , g$
PUT #2, , g$
GET #1, , g$
PUT #2, , g$
CLOSE
KILL "land.scr"

FUNCTION distance! (a!, b!)
 distance! = SQR(a! * a! + b! * b!)
END FUNCTION

FUNCTION palcalc& (r, g, b)
 palcalc& = b * 65536 + g * 256 + r
END FUNCTION

