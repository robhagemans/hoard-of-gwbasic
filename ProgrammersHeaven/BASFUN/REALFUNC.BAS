DECLARE FUNCTION amod! (x!, b!)
DECLARE FUNCTION dmod# (dx#, b#)

DECLARE FUNCTION amin! (x!, y!)
DECLARE FUNCTION dmin# (dx#, dy#)

DECLARE FUNCTION amax! (x!, y!)
DECLARE FUNCTION dmax# (dx#, dy#)

DECLARE FUNCTION sind! (x!)
DECLARE FUNCTION cosd! (x!)
DECLARE FUNCTION tand! (x!)

DECLARE FUNCTION dsind# (dx#)
DECLARE FUNCTION dcosd# (dx#)
DECLARE FUNCTION dtand# (dx#)

DECLARE FUNCTION asin! (x!)
DECLARE FUNCTION acos! (x!)
'DECLARE FUNCTION atn (x!) (intrinsic)
DECLARE FUNCTION atan! (y!, x!)

DECLARE FUNCTION asind! (x!)
DECLARE FUNCTION acosd! (x!)
DECLARE FUNCTION atnd! (x!)
DECLARE FUNCTION atand! (y!, x!)

DECLARE FUNCTION dasin# (dx#)
DECLARE FUNCTION dacos# (dx#)
'DECLARE FUNCTION atn (dx#) (intrinsic)
DECLARE FUNCTION datan# (dy#, dx#)

DECLARE FUNCTION dasind# (dx#)
DECLARE FUNCTION dacosd# (dx#)
DECLARE FUNCTION datnd# (dx#)
DECLARE FUNCTION datand# (dy#, dx#)

DECLARE FUNCTION sinh! (x!)
DECLARE FUNCTION cosh! (x!)
DECLARE FUNCTION tanh! (x!)

DECLARE FUNCTION dsinh# (dx#)
DECLARE FUNCTION dcosh# (dx#)
DECLARE FUNCTION dtanh# (dx#)

DECLARE FUNCTION asinh! (x!)
DECLARE FUNCTION acosh! (x!)
DECLARE FUNCTION atanh! (x!)

DECLARE FUNCTION dasinh# (dx#)
DECLARE FUNCTION dacosh# (dx#)
DECLARE FUNCTION datanh# (dx#)

CLS : RANDOMIZE TIMER
FOR i = 1 TO 10
  x1 = INT(RND * 20 - 10): dx1# = x1
  x2 = INT(RND * 20 - 10): IF x2 = 0 THEN x2 = 1
  dx2# = x2
  y = amod(x1, x2): dy# = dmod#(dx1#, dx2#)
  PRINT USING "###.#####   ###.#####   ###.#####   ###.#####"; x1; x2; y; dy#
  NEXT i

FUNCTION acos (x) STATIC

y = SQR(1 - x * x)
acos = atan(y, x)

END FUNCTION

FUNCTION acosd (x) STATIC

y = SQR(1 - x * x)
acosd = atand(y, x)

END FUNCTION

FUNCTION acosh (x) STATIC

acosh = LOG(x + SQR(x * x - 1))

END FUNCTION

FUNCTION amax (x, y) STATIC

amax = y
IF x > y THEN amax = x

END FUNCTION

FUNCTION amin (x, y) STATIC

amin = y
IF x < y THEN amin = x

END FUNCTION

FUNCTION amod (x, b) STATIC

amod! = x - b * FIX(x / b)

END FUNCTION

FUNCTION asin (x) STATIC

y = SQR(1 - x * x)
asin = atan(x, y)

END FUNCTION

FUNCTION asind (x) STATIC

y = SQR(1 - x * x)
asind = atand(x, y)

END FUNCTION

FUNCTION asinh (x) STATIC

asinh = LOG(x + SQR(x * x + 1))

END FUNCTION

FUNCTION atan (y, x) STATIC

pio2 = 2 * ATN(1)

IF x = 0 THEN
  atan = SGN(y) * pio2
  EXIT FUNCTION
ELSEIF y = 0 THEN
  atan = (1 - SGN(x)) * pio2
  EXIT FUNCTION
END IF

t = ATN(y / x)
IF x > 0 THEN
  atan = t
ELSE
  atan = t + SGN(y) * 2 * pio2
END IF

END FUNCTION

FUNCTION atand (y, x) STATIC

pio2 = 90: r2d = 45 / ATN(1)

IF x = 0 THEN
  atand = SGN(y) * pio2
  EXIT FUNCTION
ELSEIF y = 0 THEN
  atand = (1 - SGN(x)) * pio2
  EXIT FUNCTION
END IF

t = ATN(y / x) * r2d
IF x > 0 THEN
  atand = t
ELSE
  atand = t + SGN(y) * 2 * pio2
END IF

END FUNCTION

FUNCTION atanh (x) STATIC

atanh = .5 * LOG((1 + x) / (1 - x))

END FUNCTION

FUNCTION atnd (x) STATIC

r2d = 45 / ATN(1)
atnd = ATN(x) * r2d

END FUNCTION

FUNCTION cosd (x) STATIC

d2r = ATN(1) / 45
cosd = COS(x * d2r)

END FUNCTION

FUNCTION cosh (x) STATIC

cosh = (EXP(x) + EXP(-x)) / 2

END FUNCTION

FUNCTION dacos# (dx#) STATIC

dy# = SQR(1# - dx# * dx#)
dacos# = datan#(dy#, dx#)

END FUNCTION

FUNCTION dacosd# (dx#) STATIC

dy# = SQR(1# - dx# * dx#)
dacosd# = datand(dy#, dx#)

END FUNCTION

FUNCTION dacosh# (dx#) STATIC

dacosh# = LOG(dx# + SQR(dx# * dx# - 1#))

END FUNCTION

FUNCTION dasin# (dx#) STATIC

dy# = SQR(1# - dx# * dx#)
dasin# = datan#(dx#, dy#)

END FUNCTION

FUNCTION dasind# (dx#) STATIC

dy# = SQR(1# - dx# * dx#)
dasind# = datand(dx#, dy#)

END FUNCTION

FUNCTION dasinh# (dx#) STATIC

dasinh# = LOG(dx# + SQR(dx# * dx# + 1#))

END FUNCTION

FUNCTION datan# (dy#, dx#) STATIC

dpio2# = 2# * ATN(1#)

IF dx# = 0# THEN
  datan# = SGN(dy#) * dpio2#
  EXIT FUNCTION
ELSEIF dy# = 0# THEN
  datan# = (1# - SGN(dx#)) * dpio2#
  EXIT FUNCTION
END IF

dt = ATN(dy# / dx#)
IF dx# > 0# THEN
  datan# = dt
ELSE
  datan# = dt + SGN(dy#) * 2# * dpio2#
END IF

END FUNCTION

FUNCTION datand# (dy#, dx#) STATIC

dpio2# = 90#: r2d# = 45# / ATN(1#)

IF dx# = 0# THEN
  datand# = SGN(dy#) * dpio2#
  EXIT FUNCTION
ELSEIF dy# = 0# THEN
  datand# = (1# - SGN(dx#)) * dpio2#
  EXIT FUNCTION
END IF

dt = ATN(dy# / dx#) * r2d#
IF dx# > 0# THEN
  datand# = dt
ELSE
  datand# = dt + SGN(dy#) * 2# * dpio2#
END IF

END FUNCTION

FUNCTION datanh# (dx#) STATIC

datanh# = .5# * LOG((1# + dx#) / (1# - dx#))

END FUNCTION

FUNCTION datnd# (dx#) STATIC

r2d# = 45# / ATN(1#)
datnd# = ATN(dx#) * r2d#

END FUNCTION

FUNCTION dcosd# (dx#) STATIC

d2r# = ATN(1#) / 45#
dcosd# = COS(dx# * d2r#)

END FUNCTION

FUNCTION dcosh# (dx#) STATIC

dcosh# = (EXP(dx#) + EXP(-dx#)) / 2#

END FUNCTION

FUNCTION dmax# (dx#, dy#) STATIC

dmax# = dy#
IF dx# > dy# THEN dmax# = dx#

END FUNCTION

FUNCTION dmin# (dx#, dy#) STATIC

dmin# = dy#
IF dx# < dy# THEN dmin# = dx#

END FUNCTION

FUNCTION dmod# (dx#, b#) STATIC

dmod# = dx# - b# * FIX(dx# / b#)

END FUNCTION

FUNCTION dsind# (dx#) STATIC

d2r# = ATN(1#) / 45#
dsind# = SIN(dx# * d2r#)

END FUNCTION

FUNCTION dsinh# (dx#) STATIC

dsinh# = (EXP(dx#) - EXP(-dx#)) / 2#

END FUNCTION

FUNCTION dtand# (dx#) STATIC

d2r# = ATN(1#) / 45#
dtand# = TAN(dx# * d2r#)

END FUNCTION

FUNCTION dtanh# (dx#) STATIC

dtanh# = (EXP(dx#) - EXP(-dx#)) / (EXP(dx#) + EXP(-dx#))

END FUNCTION

FUNCTION sind (x) STATIC

d2r = ATN(1) / 45
sind = SIN(x * d2r)

END FUNCTION

FUNCTION sinh (x) STATIC

sinh = (EXP(x) - EXP(-x)) / 2

END FUNCTION

FUNCTION tand (x) STATIC

d2r = ATN(1) / 45
tand = TAN(x * d2r)

END FUNCTION

FUNCTION tanh (x) STATIC

tanh = (EXP(x) - EXP(-x)) / (EXP(x) + EXP(-x))

END FUNCTION

