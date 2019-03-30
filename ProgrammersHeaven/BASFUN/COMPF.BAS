'A module by, but NOT copyright Jan Steinar Haugland

'PUBLIC DOMAIN

'... but please don't remove references to Kerry Mitchel
'and myself when redistributing the source.

'THE FUNCTIONS AND SUBS IN THIS MODULE IS STOLEN DIRECTLY FROM
'KERRY MITCHEL, WHO GAVE ME PERMISSION TO DO SO WITH THE FOLLOWING
'TEXT:

'  <<
'  I release this into the public domain, and do so without warranty of any kind.
'  Void where prohibited by law.  Not for internal consumption.  Your mileage
'  may vary.
'
'  Kerry Mitchell
'  mitchell@acodkris.larc.nasa.gov
'  lkmitch@gn.ecn.purdue.edu
'  Compuserve 70152,1444
'  >>

'Thanks a lot, Kerry!

DefDbl A-Z

'The following is from the QuickBasic source, but is not
'relevant for (or legal in) Visual Basic. I leavie it in
'so someone could (shudder) reconvert it back to QBasic.

'DECLARE SUB cabs (x!, y!, z!)
'DECLARE SUB cdabs (x#, y#, z#)

'DECLARE SUB ccart (r!, t!, x!, y!)
'DECLARE SUB ccartd (r!, t!, x!, y!)
'DECLARE SUB cdcart (r#, t#, x#, y#)
'DECLARE SUB cdcartd (r#, t#, x#, y#)

'DECLARE SUB cpolar (x!, y!, r!, t!)
'DECLARE SUB cpolard (x!, y!, r!, t!)
'DECLARE SUB cdpolar (x#, y#, r#, t#)
'DECLARE SUB cdpolard (x#, y#, r#, t#)

'DECLARE SUB cmult (x1!, y1!, x2!, y2!, x3!, y3!)
'DECLARE SUB cdiv (x1!, y1!, x2!, y2!, x3!, y3!)

'DECLARE SUB cdmult (x1#, y1#, x2#, y2#, x3#, y3#)
'DECLARE SUB cddiv (x1#, y1#, x2#, y2#, x3#, y3#)

'DECLARE SUB cexp (x1!, y1!, x2!, y2!)
'DECLARE SUB clog (x1!, y1!, x2!, y2!)

'DECLARE SUB cdexp (x1#, y1#, x2#, y2#)
'DECLARE SUB cdlog (x1#, y1#, x2#, y2#)

'DECLARE SUB csin (x1!, y1!, x2!, y2!)
'DECLARE SUB ccos (x1!, y1!, x2!, y2!)
'DECLARE SUB ctan (x1!, y1!, x2!, y2!)

'DECLARE SUB cdsin (x1#, y1#, x2#, y2#)
'DECLARE SUB cdcos (x1#, y1#, x2#, y2#)
'DECLARE SUB cdtan (x1#, y1#, x2#, y2#)

'DECLARE SUB casin (x1!, y1!, x2!, y2!)
'DECLARE SUB cacos (x1!, y1!, x2!, y2!)
'DECLARE SUB catan (x1!, y1!, x2!, y2!)

'DECLARE SUB cdasin (x1#, y1#, x2#, y2#)
'DECLARE SUB cdacos (x1#, y1#, x2#, y2#)
'DECLARE SUB cdatan (x1#, y1#, x2#, y2#)

'DECLARE SUB csinh (x1!, y1!, x2!, y2!)
'DECLARE SUB ccosh (x1!, y1!, x2!, y2!)
'DECLARE SUB ctanh (x1!, y1!, x2!, y2!)

'DECLARE SUB cdsinh (x1#, y1#, x2#, y2#)
'DECLARE SUB cdcosh (x1#, y1#, x2#, y2#)
'DECLARE SUB cdtanh (x1#, y1#, x2#, y2#)

'DECLARE SUB casinh (x1!, y1!, x2!, y2!)
'DECLARE SUB cacosh (x1!, y1!, x2!, y2!)
'DECLARE SUB catanh (x1!, y1!, x2!, y2!)

'DECLARE SUB cdasinh (x1#, y1#, x2#, y2#)
'DECLARE SUB cdacosh (x1#, y1#, x2#, y2#)
'DECLARE SUB cdatanh (x1#, y1#, x2#, y2#)

'DECLARE FUNCTION acos! (x!)
'DECLARE FUNCTION asin! (x!)
'DECLARE FUNCTION atan! (y!, x!)
'DECLARE FUNCTION sinh! (x!)
'DECLARE FUNCTION cosh! (x!)
'DECLARE FUNCTION tanh! (x!)
'DECLARE FUNCTION asinh! (x!)
'DECLARE FUNCTION acosh! (x!)
'DECLARE FUNCTION atanh! (x!)
'DECLARE FUNCTION amod! (x!, b!)
'DECLARE FUNCTION amax! (x!, y!)
'DECLARE FUNCTION dmin# (dx#, dy#)
'DECLARE FUNCTION amin! (x!, y!)
'DECLARE FUNCTION dmax# (dx#, dy#)
'DECLARE FUNCTION dmod# (dx#, b#)
'DECLARE FUNCTION datan# (dy#, dx#)
'DECLARE FUNCTION dacos# (dx#)
'DECLARE FUNCTION dacosh# (dx#)
'DECLARE FUNCTION dasin# (dx#)
'DECLARE FUNCTION dasinh# (dx#)
'DECLARE FUNCTION datanh# (dx#)
'DECLARE FUNCTION dcosh# (dx#)
'DECLARE FUNCTION dsinh# (dx#)
'DECLARE FUNCTION dtanh# (dx#)
'DECLARE FUNCTION sind! (x!)
'DECLARE FUNCTION dsind# (dx#)
'DECLARE FUNCTION cosd! (x!)
'DECLARE FUNCTION dcosd# (dx#)
'DECLARE FUNCTION tand! (x!)
'DECLARE FUNCTION dtand# (dx#)
'DECLARE FUNCTION atnd! (x!)
'DECLARE FUNCTION datnd# (dx#)
'DECLARE FUNCTION atand! (y!, x!)
'DECLARE FUNCTION datand# (dy#, dx#)
'DECLARE FUNCTION acosd! (x!)
'DECLARE FUNCTION dacosd# (dx#)
'DECLARE FUNCTION asind! (x!)
'DECLARE FUNCTION dasind# (dx#)

'CLS : RANDOMIZE TIMER
'f$ = "###.#####   ###.#####   ###.#####   ###.#####   ###.########"
'FOR i = 1 TO 10
'  x1 = RND * 4 - 2: dx1# = x1: y1 = RND * 4 - 2: dy1# = y1
'  x2 = RND * 4 - 2: dx2# = x2: y2 = RND * 4 - 2: dy2# = y2
'  CALL cdtanh(dx1#, dy1#, dz1#, dz2#)
'  CALL cdatanh(dz1#, dz2#, dx2#, dy2#)
'  CALL ctanh(x1, y1, z1, z2)
'  CALL catanh(z1, z2, x2, y2)
'  e = SQR((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
'  de# = SQR((dx1# - dx2#) ^ 2 + (dy1# - dy2#) ^ 2)
'  PRINT USING f$; dx1#; dy1#; dx2#; dy2#; de#
'  'PRINT USING f$; x1; y1; x2; y2; e
'  NEXT i

Sub cdatanh (x1#, y1#, x2#, y2#)

' complex inverse hyperbolic tangent
u1# = 1# + x1#: v1# = y1#: u2# = 1# - x1#: v2# = -y1#
Call cddiv(u1#, v1#, u2#, v2#, u3#, v3#)
Call cdlog(u3#, v3#, u1#, v1#)
x2# = u1# / 2#: y2# = v1# / 2#

End Sub

Sub cdcart (r#, t#, x#, y#)

'  determine cartesian coordinates from polar
x# = r# * Cos(t#): y# = r# * Sin(t#)

End Sub

Sub cdcartd (r#, t#, x#, y#)

'  determine cartesian coordinates from polar in degrees
x# = r# * dcosd(t#): y# = r# * dsind(t#)

End Sub

Sub cdcos (x1#, y1#, x2#, y2#)

' complex cosine
x2# = Cos(x1#) * dcosh(y1#): y2# = -Sin(x1#) * dsinh(y1#)

End Sub

Sub cdcosh (x1#, y1#, x2#, y2#)

' complex hyperbolic cosine
x2# = dcosh(x1#) * Cos(y1#): y2# = dsinh(x1#) * Sin(y1#)

End Sub

Sub cddiv (x1#, y1#, x2#, y2#, x3#, y3#)

'  divide complex number 1 by complex number 2
denom# = x2# * x2# + y2# * y2#
z1# = x2# / denom#: z2# = -y2# / denom#
Call cdmult(x1#, y1#, z1#, z2#, x3#, y3#)

End Sub

Sub cdacosh (x1#, y1#, x2#, y2#)

' complex inverse hyperbolic cosine
u1# = x1# * x1# - y1# * y1# - 1#: v1# = 2# * x1# * y1#
Call cdpolar(u1#, v1#, r#, t#)
r# = Sqr(r#): t# = t# / 2#: u1# = r# * Cos(t#): v1# = r# * Sin(t#)
u2# = x1# + u1#: v2# = y1# + v1#
Call cdlog(u2#, v2#, x2#, y2#)

End Sub

Sub cdasin (x1#, y1#, x2#, y2#)

' complex arcsine
u1# = 1# - x1# * x1# + y1# * y1#: v1# = -2# * x1# * y1#
Call cdpolar(u1#, v1#, r#, t#)
r# = Sqr(r#): t# = t# / 2#: u1# = r# * Cos(t#): v1# = r# * Sin(t#)
u2# = -y1# + u1#: v2# = x1# + v1#
Call cdlog(u2#, v2#, u1#, v1#)
x2# = v1#: y2# = -u1#

End Sub

Sub cdasinh (x1#, y1#, x2#, y2#)

' complex inverse hyperbolic sine
u1# = x1# * x1# - y1# * y1# + 1#: v1# = 2# * x1# * y1#
Call cdpolar(u1#, v1#, r#, t#)
r# = Sqr(r#): t# = t# / 2#: u1# = r# * Cos(t#): v1# = r# * Sin(t#)
u2# = x1# + u1#: v2# = y1# + v1#
Call cdlog(u2#, v2#, x2#, y2#)

End Sub

Sub cdatan (x1#, y1#, x2#, y2#)

' complex arctangent
u1# = 1# - y1#: v1# = x1#: u2# = 1# + y1#: v2# = -x1#
Call cddiv(u1#, v1#, u2#, v2#, u3#, v3#)
Call cdlog(u3#, v3#, u1#, v1#)
x2# = v1# / 2#: y2# = -u1# / 2#

End Sub

Sub cdexp (x1#, y1#, x2#, y2#)

'  complex exponential
r# = Exp(x1#)
x2# = r# * Cos(y1#): y2# = r# * Sin(y1#)

End Sub

Sub cdiv (x1, y1, x2, y2, x3, y3)

'  divide complex number 1 by complex number 2
denom = x2 * x2 + y2 * y2
z1 = x2 / denom: z2 = -y2 / denom
Call cmult(x1, y1, z1, z2, x3, y3)

End Sub

Sub cdlog (x1#, y1#, x2#, y2#)

'  complex logarithm
'find polar coordinates
Call cdpolar(x1#, y1#, r#, t#)
If r# = 0 Then r# = .000000001
x2# = Log(r#): y2# = t#

End Sub

Sub cdmult (x1#, y1#, x2#, y2#, x3#, y3#)
' CHECK FOR OVERFLOW HERE!
'  multiply 2 complex numbers
x3# = x1# * x2# - y1# * y2#: y3# = x1# * y2# + x2# * y1#

End Sub

Sub cdpolar (x#, y#, r#, t#)

'  convert cartesian to polar coordinates
t# = datan#(y#, x#)
r# = Sqr(x# * x# + y# * y#)

End Sub

Sub cdpolard (x#, y#, r#, t#)

'  convert cartesian to polar coordinates in degrees
t# = datand#(y#, x#)
r# = Sqr(x# * x# + y# * y#)

End Sub

Sub cdsin (x1#, y1#, x2#, y2#)

'  complex sine
x2# = Sin(x1#) * dcosh(y1#): y2# = Cos(x1#) * dsinh(y1#)

End Sub

Sub cdsinh (x1#, y1#, x2#, y2#)

' complex hyperbolic sine
x2# = dsinh(x1#) * Cos(y1#): y2# = dcosh(x1#) * Sin(y1#)

End Sub

Sub cdtan (x1#, y1#, x2#, y2#)

' complex tangent
u1# = Tan(x1#): v1# = dtanh(y1#)
u2# = 1#: v2# = -u1# * v1#
Call cddiv(u1#, v1#, u2#, v2#, x2#, y2#)

End Sub

Sub cdtanh (x1#, y1#, x2#, y2#)

' complex hyperbolic tangent
u1# = dtanh(x1#): v1# = Tan(y1#)
u2# = 1#: v2# = u1# * v1#
Call cddiv(u1#, v1#, u2#, v2#, x2#, y2#)

End Sub

Sub cexp (x1, y1, x2, y2)

'  complex exponential
r = Exp(x1)
x2 = r * Cos(y1): y2 = r * Sin(y1)

End Sub

Sub clog (x1, y1, x2, y2)

'  complex logarithm
'find polar coordinates
Call cpolar(x1, y1, r, t)
If r = 0 Then r = .000000001
x2 = Log(r): y2 = t

End Sub

Sub cmult (x1, y1, x2, y2, x3, y3)

'  multiply 2 complex numbers
x3 = x1 * x2 - y1 * y2: y3 = x1 * y2 + x2 * y1

End Sub

Static Function cosd (x)

d2r = Atn(1) / 45
cosd = Cos(x * d2r)

End Function

Static Function cosh (x)

cosh = (Exp(x) + Exp(-x)) / 2

End Function

Sub cpolar (x, y, r, t)

'  convert cartesian to polar coordinates
t = atan(y, x)
r = Sqr(x * x + y * y)

End Sub

Sub cpolard (x, y, r, t)

'  convert cartesian to polar coordinates in degrees
t = atand(y, x)
r = Sqr(x * x + y * y)

End Sub

Sub csin (x1, y1, x2, y2)

'  complex sine
x2 = Sin(x1) * cosh(y1): y2 = Cos(x1) * sinh(y1)

End Sub

Sub csinh (x1, y1, x2, y2)

' complex hyperbolic sine
x2 = sinh(x1) * Cos(y1): y2 = cosh(x1) * Sin(y1)

End Sub

Sub ctan (x1, y1, x2, y2)

' complex tangent
u1 = Tan(x1): v1 = tanh(y1)
u2 = 1: v2 = -u1 * v1
Call cdiv(u1, v1, u2, v2, x2, y2)

End Sub

Sub ctanh (x1, y1, x2, y2)

' complex hyperbolic tangent
u1 = tanh(x1): v1 = Tan(y1)
u2 = 1: v2 = u1 * v1
Call cdiv(u1, v1, u2, v2, x2, y2)

End Sub

Static Function dacos# (dx#)

dy# = Sqr(1# - dx# * dx#)
dacos# = datan#(dy#, dx#)

End Function

Static Function dacosd# (dx#)

dy# = Sqr(1# - dx# * dx#)
dacosd# = datand(dy#, dx#)

End Function

Static Function dacosh# (dx#)

dacosh# = Log(dx# + Sqr(dx# * dx# - 1#))

End Function

Static Function dasin# (dx#)

dy# = Sqr(1# - dx# * dx#)
dasin# = datan#(dx#, dy#)

End Function

Static Function dasind# (dx#)

dy# = Sqr(1# - dx# * dx#)
dasind# = datand(dx#, dy#)

End Function

Static Function dasinh# (dx#)

dasinh# = Log(dx# + Sqr(dx# * dx# + 1#))

End Function

Static Function datan# (dy#, dx#)

dpio2# = 2# * Atn(1#)

If dx# = 0# Then
  datan# = Sgn(dy#) * dpio2#
  Exit Function
ElseIf dy# = 0# Then
  datan# = (1# - Sgn(dx#)) * dpio2#
  Exit Function
End If

dt = Atn(dy# / dx#)
If dx# > 0# Then
  datan# = dt
Else
  datan# = dt + Sgn(dy#) * 2# * dpio2#
End If

End Function

Static Function datand# (dy#, dx#)

dpio2# = 90#: r2d# = 45# / Atn(1#)

If dx# = 0# Then
  datand# = Sgn(dy#) * dpio2#
  Exit Function
ElseIf dy# = 0# Then
  datand# = (1# - Sgn(dx#)) * dpio2#
  Exit Function
End If

dt = Atn(dy# / dx#) * r2d#
If dx# > 0# Then
  datand# = dt
Else
  datand# = dt + Sgn(dy#) * 2# * dpio2#
End If

End Function

Static Function datanh# (dx#)

datanh# = .5 * Log((1# + dx#) / (1# - dx#))

End Function

Static Function datnd# (dx#)

r2d# = 45# / Atn(1#)
datnd# = Atn(dx#) * r2d#

End Function

Static Function dcosd# (dx#)

d2r# = Atn(1#) / 45#
dcosd# = Cos(dx# * d2r#)

End Function

Static Function dcosh# (dx#)

dcosh# = (Exp(dx#) + Exp(-dx#)) / 2#

End Function

Static Function dmax# (dx#, dy#)

dmax# = dy#
If dx# > dy# Then dmax# = dx#

End Function

Static Function dmin# (dx#, dy#)

dmin# = dy#
If dx# < dy# Then dmin# = dx#

End Function

Static Function dmod# (dx#, b#)

dmod# = dx# - b# * Fix(dx# / b#)

End Function

Static Function dsind# (dx#)

d2r# = Atn(1#) / 45#
dsind# = Sin(dx# * d2r#)

End Function

Static Function dsinh# (dx#)

dsinh# = (Exp(dx#) - Exp(-dx#)) / 2#

End Function

Static Function dtand# (dx#)

d2r# = Atn(1#) / 45#
dtand# = Tan(dx# * d2r#)

End Function

Static Function dtanh# (dx#)

dtanh# = (Exp(dx#) - Exp(-dx#)) / (Exp(dx#) + Exp(-dx#))

End Function

Static Function sind (x)

d2r = Atn(1) / 45
sind = Sin(x * d2r)

End Function

Static Function sinh (x)

sinh = (Exp(x) - Exp(-x)) / 2

End Function

Static Function tand (x)

d2r = Atn(1) / 45
tand = Tan(x * d2r)

End Function

Static Function tanh (x)

tanh = (Exp(x) - Exp(-x)) / (Exp(x) + Exp(-x))

End Function

Static Function acos (x)

y = Sqr(1 - x * x)
acos = atan(y, x)

End Function

Static Function acosd (x)

y = Sqr(1 - x * x)
acosd = atand(y, x)

End Function

Static Function acosh (x)

acosh = Log(x + Sqr(x * x - 1))

End Function

Static Function amax (x, y)

amax = y
If x > y Then amax = x

End Function

Static Function amin (x, y)

amin = y
If x < y Then amin = x

End Function

Static Function amod (x, b)

amod = x - b * Fix(x / b)

End Function

Static Function asin (x)

y = Sqr(1 - x * x)
asin = atan(x, y)

End Function

Static Function asind (x)

y = Sqr(1 - x * x)
asind = atand(x, y)

End Function

Static Function asinh (x)

asinh = Log(x + Sqr(x * x + 1))

End Function

Static Function atan (y, x)

pio2 = 2 * Atn(1)

If x = 0 Then
  atan = Sgn(y) * pio2
  Exit Function
ElseIf y = 0 Then
  atan = (1 - Sgn(x)) * pio2
  Exit Function
End If

t = Atn(y / x)
If x > 0 Then
  atan = t
Else
  atan = t + Sgn(y) * 2 * pio2
End If

End Function

Static Function atand (y, x)

pio2 = 90: r2d = 45 / Atn(1)

If x = 0 Then
  atand = Sgn(y) * pio2
  Exit Function
ElseIf y = 0 Then
  atand = (1 - Sgn(x)) * pio2
  Exit Function
End If

t = Atn(y / x) * r2d
If x > 0 Then
  atand = t
Else
  atand = t + Sgn(y) * 2 * pio2
End If

End Function

Static Function atanh (x)

atanh = .5 * Log((1 + x) / (1 - x))

End Function

Static Function atnd (x)

r2d = 45 / Atn(1)
atnd = Atn(x) * r2d

End Function

Sub cabs (x, y, z)

' magnitude of a complex number
z = Sqr(x * x + y * y)

End Sub

Sub cacos (x1, y1, x2, y2)

' complex arccosine
u1 = x1 * x1 - y1 * y1 - 1: v1 = 2 * x1 * y1
Call cpolar(u1, v1, r, t)
r = Sqr(r): t = t / 2: u1 = r * Cos(t): v1 = r * Sin(t)
u2 = x1 + u1: v2 = y1 + v1
Call clog(u2, v2, u1, v1)
x2 = v1: y2 = -u1

End Sub

Sub cacosh (x1, y1, x2, y2)

' complex inverse hyperbolic cosine
u1 = x1 * x1 - y1 * y1 - 1: v1 = 2 * x1 * y1
Call cpolar(u1, v1, r, t)
r = Sqr(r): t = t / 2: u1 = r * Cos(t): v1 = r * Sin(t)
u2 = x1 + u1: v2 = y1 + v1
Call clog(u2, v2, x2, y2)

End Sub

Sub casin (x1, y1, x2, y2)

' complex arcsine
u1 = 1 - x1 * x1 + y1 * y1: v1 = -2 * x1 * y1
Call cpolar(u1, v1, r, t)
r = Sqr(r): t = t / 2: u1 = r * Cos(t): v1 = r * Sin(t)
u2 = -y1 + u1: v2 = x1 + v1
Call clog(u2, v2, u1, v1)
x2 = v1: y2 = -u1

End Sub

Sub casinh (x1, y1, x2, y2)

' complex inverse hyperbolic sine
u1 = x1 * x1 - y1 * y1 + 1: v1 = 2 * x1 * y1
Call cpolar(u1, v1, r, t)
r = Sqr(r): t = t / 2: u1 = r * Cos(t): v1 = r * Sin(t)
u2 = x1 + u1: v2 = y1 + v1
Call clog(u2, v2, x2, y2)

End Sub

Sub catan (x1, y1, x2, y2)

' complex arctangent
u1 = 1 - y1: v1 = x1: u2 = 1 + y1: v2 = -x1
Call cdiv(u1, v1, u2, v2, u3, v3)
Call clog(u3, v3, u1, v1)
x2 = v1 / 2: y2 = -u1 / 2

End Sub

Sub catanh (x1, y1, x2, y2)

' complex inverse hyperbolic tangent
u1# = 1 + x1
v1# = y1:
u2# = 1 - x1
v2# = -y1
Call cdiv(u1#, v1#, u2#, v2#, u3#, v3#)
Call clog(u3#, v3#, u1#, v1#)
x2 = u1# / 2
y2 = v1# / 2

End Sub

Sub ccart (r, t, x, y)

'  determine cartesian coordinates from polar
x = r * Cos(t)
y = r * Sin(t)

End Sub

Sub ccartd (r, t, x, y As Double)

'  determine cartesian coordinates from polar in degrees
x = r * cosd(t): y = r * sind(t)

End Sub

Sub ccos (x1, y1, x2, y2)

' complex cosine
x2 = Cos(x1) * cosh(y1): y2 = -Sin(x1) * sinh(y1)

End Sub

Sub ccosh (x1, y1, x2, y2)

' complex hyperbolic cosine
x2 = cosh(x1) * Cos(y1): y2 = sinh(x1) * Sin(y1)

End Sub

Sub cdabs (x#, y#, z#)

' magnitude of a complex number
z# = Sqr(x# * x# + y# * y#)

End Sub

Sub cdacos (x1#, y1#, x2#, y2#)

' complex arccosine
u1# = x1# * x1# - y1# * y1# - 1#: v1# = 2# * x1# * y1#
Call cdpolar(u1#, v1#, r#, t#)
r# = Sqr(r#): t# = t# / 2#: u1# = r# * Cos(t#): v1# = r# * Sin(t#)
u2# = x1# + u1#: v2# = y1# + v1#
Call cdlog(u2#, v2#, u1#, v1#)
x2# = v1#: y2# = -u1#

End Sub

