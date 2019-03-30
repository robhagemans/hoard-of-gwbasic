DECLARE SUB cabs (x!, y!, z!)
DECLARE SUB cdabs (x#, y#, z#)

DECLARE SUB ccart (r!, t!, x!, y!)
DECLARE SUB ccartd (r!, t!, x!, y!)
DECLARE SUB cdcart (r#, t#, x#, y#)
DECLARE SUB cdcartd (r#, t#, x#, y#)

DECLARE SUB cpolar (x!, y!, r!, t!)
DECLARE SUB cpolard (x!, y!, r!, t!)
DECLARE SUB cdpolar (x#, y#, r#, t#)
DECLARE SUB cdpolard (x#, y#, r#, t#)

DECLARE SUB cmult (x1!, y1!, x2!, y2!, x3!, y3!)
DECLARE SUB cdiv (x1!, y1!, x2!, y2!, x3!, y3!)

DECLARE SUB cdmult (x1#, y1#, x2#, y2#, x3#, y3#)
DECLARE SUB cddiv (x1#, y1#, x2#, y2#, x3#, y3#)

DECLARE SUB cexp (x1!, y1!, x2!, y2!)
DECLARE SUB clog (x1!, y1!, x2!, y2!)

DECLARE SUB cdexp (x1#, y1#, x2#, y2#)
DECLARE SUB cdlog (x1#, y1#, x2#, y2#)

DECLARE SUB csin (x1!, y1!, x2!, y2!)
DECLARE SUB ccos (x1!, y1!, x2!, y2!)
DECLARE SUB ctan (x1!, y1!, x2!, y2!)

DECLARE SUB cdsin (x1#, y1#, x2#, y2#)
DECLARE SUB cdcos (x1#, y1#, x2#, y2#)
DECLARE SUB cdtan (x1#, y1#, x2#, y2#)

DECLARE SUB casin (x1!, y1!, x2!, y2!)
DECLARE SUB cacos (x1!, y1!, x2!, y2!)
DECLARE SUB catan (x1!, y1!, x2!, y2!)

DECLARE SUB cdasin (x1#, y1#, x2#, y2#)
DECLARE SUB cdacos (x1#, y1#, x2#, y2#)
DECLARE SUB cdatan (x1#, y1#, x2#, y2#)

DECLARE SUB csinh (x1!, y1!, x2!, y2!)
DECLARE SUB ccosh (x1!, y1!, x2!, y2!)
DECLARE SUB ctanh (x1!, y1!, x2!, y2!)

DECLARE SUB cdsinh (x1#, y1#, x2#, y2#)
DECLARE SUB cdcosh (x1#, y1#, x2#, y2#)
DECLARE SUB cdtanh (x1#, y1#, x2#, y2#)

DECLARE SUB casinh (x1!, y1!, x2!, y2!)
DECLARE SUB cacosh (x1!, y1!, x2!, y2!)
DECLARE SUB catanh (x1!, y1!, x2!, y2!)

DECLARE SUB cdasinh (x1#, y1#, x2#, y2#)
DECLARE SUB cdacosh (x1#, y1#, x2#, y2#)
DECLARE SUB cdatanh (x1#, y1#, x2#, y2#)

DECLARE FUNCTION acos! (x!)
DECLARE FUNCTION asin! (x!)
DECLARE FUNCTION atan! (y!, x!)
DECLARE FUNCTION sinh! (x!)
DECLARE FUNCTION cosh! (x!)
DECLARE FUNCTION tanh! (x!)
DECLARE FUNCTION asinh! (x!)
DECLARE FUNCTION acosh! (x!)
DECLARE FUNCTION atanh! (x!)
DECLARE FUNCTION amod! (x!, b!)
DECLARE FUNCTION amax! (x!, y!)
DECLARE FUNCTION dmin# (dx#, dy#)
DECLARE FUNCTION amin! (x!, y!)
DECLARE FUNCTION dmax# (dx#, dy#)
DECLARE FUNCTION dmod# (dx#, b#)
DECLARE FUNCTION datan# (dy#, dx#)
DECLARE FUNCTION dacos# (dx#)
DECLARE FUNCTION dacosh# (dx#)
DECLARE FUNCTION dasin# (dx#)
DECLARE FUNCTION dasinh# (dx#)
DECLARE FUNCTION datanh# (dx#)
DECLARE FUNCTION dcosh# (dx#)
DECLARE FUNCTION dsinh# (dx#)
DECLARE FUNCTION dtanh# (dx#)
DECLARE FUNCTION sind! (x!)
DECLARE FUNCTION dsind# (dx#)
DECLARE FUNCTION cosd! (x!)
DECLARE FUNCTION dcosd# (dx#)
DECLARE FUNCTION tand! (x!)
DECLARE FUNCTION dtand# (dx#)
DECLARE FUNCTION atnd! (x!)
DECLARE FUNCTION datnd# (dx#)
DECLARE FUNCTION atand! (y!, x!)
DECLARE FUNCTION datand# (dy#, dx#)
DECLARE FUNCTION acosd! (x!)
DECLARE FUNCTION dacosd# (dx#)
DECLARE FUNCTION asind! (x!)
DECLARE FUNCTION dasind# (dx#)

CLS : RANDOMIZE TIMER
f$ = "###.#####   ###.#####   ###.#####   ###.#####   ###.########"
FOR i = 1 TO 10
  x1 = RND * 4 - 2: dx1# = x1: y1 = RND * 4 - 2: dy1# = y1
  x2 = RND * 4 - 2: dx2# = x2: y2 = RND * 4 - 2: dy2# = y2
  CALL cdtanh(dx1#, dy1#, dz1#, dz2#)
  CALL cdatanh(dz1#, dz2#, dx2#, dy2#)
  CALL ctanh(x1, y1, z1, z2)
  CALL catanh(z1, z2, x2, y2)
  e = SQR((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
  de# = SQR((dx1# - dx2#) ^ 2 + (dy1# - dy2#) ^ 2)
  PRINT USING f$; dx1#; dy1#; dx2#; dy2#; de#
  'PRINT USING f$; x1; y1; x2; y2; e
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

SUB cabs (x, y, z)

' magnitude of a complex number
z = SQR(x * x + y * y)

END SUB

SUB cacos (x1, y1, x2, y2)

' complex arccosine
u1 = x1 * x1 - y1 * y1 - 1: v1 = 2 * x1 * y1
CALL cpolar(u1, v1, r, t)
r = SQR(r): t = t / 2: u1 = r * COS(t): v1 = r * SIN(t)
u2 = x1 + u1: v2 = y1 + v1
CALL clog(u2, v2, u1, v1)
x2 = v1: y2 = -u1

END SUB

SUB cacosh (x1, y1, x2, y2)

' complex inverse hyperbolic cosine
u1 = x1 * x1 - y1 * y1 - 1: v1 = 2 * x1 * y1
CALL cpolar(u1, v1, r, t)
r = SQR(r): t = t / 2: u1 = r * COS(t): v1 = r * SIN(t)
u2 = x1 + u1: v2 = y1 + v1
CALL clog(u2, v2, x2, y2)

END SUB

SUB casin (x1, y1, x2, y2)

' complex arcsine
u1 = 1 - x1 * x1 + y1 * y1: v1 = -2 * x1 * y1
CALL cpolar(u1, v1, r, t)
r = SQR(r): t = t / 2: u1 = r * COS(t): v1 = r * SIN(t)
u2 = -y1 + u1: v2 = x1 + v1
CALL clog(u2, v2, u1, v1)
x2 = v1: y2 = -u1

END SUB

SUB casinh (x1, y1, x2, y2)

' complex inverse hyperbolic sine
u1 = x1 * x1 - y1 * y1 + 1: v1 = 2 * x1 * y1
CALL cpolar(u1, v1, r, t)
r = SQR(r): t = t / 2: u1 = r * COS(t): v1 = r * SIN(t)
u2 = x1 + u1: v2 = y1 + v1
CALL clog(u2, v2, x2, y2)

END SUB

SUB catan (x1, y1, x2, y2)

' complex arctangent
u1 = 1 - y1: v1 = x1: u2 = 1 + y1: v2 = -x1
CALL cdiv(u1, v1, u2, v2, u3, v3)
CALL clog(u3, v3, u1, v1)
x2 = v1 / 2: y2 = -u1 / 2

END SUB

SUB catanh (x1, y1, x2, y2)

' complex inverse hyperbolic tangent
u1 = 1 + x1: v1 = y1: u2 = 1 - x1: v2 = -y1
CALL cdiv(u1, v1, u2, v2, u3, v3)
CALL clog(u3, v3, u1, v1)
x2 = u1 / 2: y2 = v1 / 2

END SUB

SUB ccart (r, t, x, y)

'  determine cartesian coordinates from polar
x = r * COS(t): y = r * SIN(t)

END SUB

SUB ccartd (r, t, x, y)

'  determine cartesian coordinates from polar in degrees
x = r * cosd(t): y = r * sind(t)

END SUB

SUB ccos (x1, y1, x2, y2)

' complex cosine
x2 = COS(x1) * cosh(y1): y2 = -SIN(x1) * sinh(y1)

END SUB

SUB ccosh (x1, y1, x2, y2)

' complex hyperbolic cosine
x2 = cosh(x1) * COS(y1): y2 = sinh(x1) * SIN(y1)

END SUB

SUB cdabs (x#, y#, z#)

' magnitude of a complex number
z# = SQR(x# * x# + y# * y#)

END SUB

SUB cdacos (x1#, y1#, x2#, y2#)

' complex arccosine
u1# = x1# * x1# - y1# * y1# - 1#: v1# = 2# * x1# * y1#
CALL cdpolar(u1#, v1#, r#, t#)
r# = SQR(r#): t# = t# / 2#: u1# = r# * COS(t#): v1# = r# * SIN(t#)
u2# = x1# + u1#: v2# = y1# + v1#
CALL cdlog(u2#, v2#, u1#, v1#)
x2# = v1#: y2# = -u1#

END SUB

SUB cdacosh (x1#, y1#, x2#, y2#)

' complex inverse hyperbolic cosine
u1# = x1# * x1# - y1# * y1# - 1#: v1# = 2# * x1# * y1#
CALL cdpolar(u1#, v1#, r#, t#)
r# = SQR(r#): t# = t# / 2#: u1# = r# * COS(t#): v1# = r# * SIN(t#)
u2# = x1# + u1#: v2# = y1# + v1#
CALL cdlog(u2#, v2#, x2#, y2#)

END SUB

SUB cdasin (x1#, y1#, x2#, y2#)

' complex arcsine
u1# = 1# - x1# * x1# + y1# * y1#: v1# = -2# * x1# * y1#
CALL cdpolar(u1#, v1#, r#, t#)
r# = SQR(r#): t# = t# / 2#: u1# = r# * COS(t#): v1# = r# * SIN(t#)
u2# = -y1# + u1#: v2# = x1# + v1#
CALL cdlog(u2#, v2#, u1#, v1#)
x2# = v1#: y2# = -u1#

END SUB

SUB cdasinh (x1#, y1#, x2#, y2#)

' complex inverse hyperbolic sine
u1# = x1# * x1# - y1# * y1# + 1#: v1# = 2# * x1# * y1#
CALL cdpolar(u1#, v1#, r#, t#)
r# = SQR(r#): t# = t# / 2#: u1# = r# * COS(t#): v1# = r# * SIN(t#)
u2# = x1# + u1#: v2# = y1# + v1#
CALL cdlog(u2#, v2#, x2#, y2#)

END SUB

SUB cdatan (x1#, y1#, x2#, y2#)

' complex arctangent
u1# = 1# - y1#: v1# = x1#: u2# = 1# + y1#: v2# = -x1#
CALL cddiv(u1#, v1#, u2#, v2#, u3#, v3#)
CALL cdlog(u3#, v3#, u1#, v1#)
x2# = v1# / 2#: y2# = -u1# / 2#

END SUB

SUB cdatanh (x1#, y1#, x2#, y2#)

' complex inverse hyperbolic tangent
u1# = 1# + x1#: v1# = y1#: u2# = 1# - x1#: v2# = -y1#
CALL cddiv(u1#, v1#, u2#, v2#, u3#, v3#)
CALL cdlog(u3#, v3#, u1#, v1#)
x2# = u1# / 2#: y2# = v1# / 2#

END SUB

SUB cdcart (r#, t#, x#, y#)

'  determine cartesian coordinates from polar
x# = r# * COS(t#): y# = r# * SIN(t#)

END SUB

SUB cdcartd (r#, t#, x#, y#)

'  determine cartesian coordinates from polar in degrees
x# = r# * dcosd(t#): y# = r# * dsind(t#)

END SUB

SUB cdcos (x1#, y1#, x2#, y2#)

' complex cosine
x2# = COS(x1#) * dcosh(y1#): y2# = -SIN(x1#) * dsinh(y1#)

END SUB

SUB cdcosh (x1#, y1#, x2#, y2#)

' complex hyperbolic cosine
x2# = dcosh(x1#) * COS(y1#): y2# = dsinh(x1#) * SIN(y1#)

END SUB

SUB cddiv (x1#, y1#, x2#, y2#, x3#, y3#)

'  divide complex number 1 by complex number 2
denom# = x2# * x2# + y2# * y2#
z1# = x2# / denom#: z2# = -y2# / denom#
CALL cdmult(x1#, y1#, z1#, z2#, x3#, y3#)

END SUB

SUB cdexp (x1#, y1#, x2#, y2#)

'  complex exponential
r# = EXP(x1#)
x2# = r# * COS(y1#): y2# = r# * SIN(y1#)

END SUB

SUB cdiv (x1, y1, x2, y2, x3, y3)

'  divide complex number 1 by complex number 2
denom = x2 * x2 + y2 * y2
z1 = x2 / denom: z2 = -y2 / denom
CALL cmult(x1, y1, z1, z2, x3, y3)

END SUB

SUB cdlog (x1#, y1#, x2#, y2#)

'  complex logarithm
'find polar coordinates
CALL cdpolar(x1#, y1#, r#, t#)
IF r# = 0 THEN r# = .000000001#
x2# = LOG(r#): y2# = t#

END SUB

SUB cdmult (x1#, y1#, x2#, y2#, x3#, y3#)

'  multiply 2 complex numbers
x3# = x1# * x2# - y1# * y2#: y3# = x1# * y2# + x2# * y1#

END SUB

SUB cdpolar (x#, y#, r#, t#)

'  convert cartesian to polar coordinates
t# = datan#(y#, x#)
r# = SQR(x# * x# + y# * y#)

END SUB

SUB cdpolard (x#, y#, r#, t#)

'  convert cartesian to polar coordinates in degrees
t# = datand#(y#, x#)
r# = SQR(x# * x# + y# * y#)

END SUB

SUB cdsin (x1#, y1#, x2#, y2#)

'  complex sine
x2# = SIN(x1#) * dcosh(y1#): y2# = COS(x1#) * dsinh(y1#)

END SUB

SUB cdsinh (x1#, y1#, x2#, y2#)

' complex hyperbolic sine
x2# = dsinh(x1#) * COS(y1#): y2# = dcosh(x1#) * SIN(y1#)

END SUB

SUB cdtan (x1#, y1#, x2#, y2#)

' complex tangent
u1# = TAN(x1#): v1# = dtanh(y1#)
u2# = 1#: v2# = -u1# * v1#
CALL cddiv(u1#, v1#, u2#, v2#, x2#, y2#)

END SUB

SUB cdtanh (x1#, y1#, x2#, y2#)

' complex hyperbolic tangent
u1# = dtanh(x1#): v1# = TAN(y1#)
u2# = 1#: v2# = u1# * v1#
CALL cddiv(u1#, v1#, u2#, v2#, x2#, y2#)

END SUB

SUB cexp (x1, y1, x2, y2)

'  complex exponential
r = EXP(x1)
x2 = r * COS(y1): y2 = r * SIN(y1)

END SUB

SUB clog (x1, y1, x2, y2)

'  complex logarithm
'find polar coordinates
CALL cpolar(x1, y1, r, t)
IF r = 0 THEN r = 1E-09
x2 = LOG(r): y2 = t

END SUB

SUB cmult (x1, y1, x2, y2, x3, y3)

'  multiply 2 complex numbers
x3 = x1 * x2 - y1 * y2: y3 = x1 * y2 + x2 * y1

END SUB

FUNCTION cosd (x) STATIC

d2r = ATN(1) / 45
cosd = COS(x * d2r)

END FUNCTION

FUNCTION cosh (x) STATIC

cosh = (EXP(x) + EXP(-x)) / 2

END FUNCTION

SUB cpolar (x, y, r, t)

'  convert cartesian to polar coordinates
t = atan(y, x)
r = SQR(x * x + y * y)

END SUB

SUB cpolard (x, y, r, t)

'  convert cartesian to polar coordinates in degrees
t = atand(y, x)
r = SQR(x * x + y * y)

END SUB

SUB csin (x1, y1, x2, y2)

'  complex sine
x2 = SIN(x1) * cosh(y1): y2 = COS(x1) * sinh(y1)

END SUB

SUB csinh (x1, y1, x2, y2)

' complex hyperbolic sine
x2 = sinh(x1) * COS(y1): y2 = cosh(x1) * SIN(y1)

END SUB

SUB ctan (x1, y1, x2, y2)

' complex tangent
u1 = TAN(x1): v1 = tanh(y1)
u2 = 1: v2 = -u1 * v1
CALL cdiv(u1, v1, u2, v2, x2, y2)

END SUB

SUB ctanh (x1, y1, x2, y2)

' complex hyperbolic tangent
u1 = tanh(x1): v1 = TAN(y1)
u2 = 1: v2 = u1 * v1
CALL cdiv(u1, v1, u2, v2, x2, y2)

END SUB

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

