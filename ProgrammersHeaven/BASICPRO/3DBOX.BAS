DECLARE SUB rot (b!, c!, a!)     'rotates vector b, c by and angle a
DECLARE SUB drawit ()            'handles drawing
SCREEN 12                        'changes screen mode to 640 x 480 x 16 colours
CONST xmax = 640
CONST ymax = 480
CONST xmid = xmax / 2
CONST ymid = ymax / 2
CONST pi = 3.141592654#
DIM SHARED DTR                   'this is needed to convert degrees to radians
DTR = pi / 180
DIM SHARED RTD                   'this is needed to convert radians to degrees
RTD = 180 / pi
DIM SHARED pnt(1 TO 8, 1 TO 3)   'defines array pnt
DIM SHARED vect(1 TO 12, 1 TO 2) 'defines vect vect
'*************************        cube coordinates            ***************
pnt(1, 1) = 50
pnt(1, 2) = -50
pnt(1, 3) = -50

pnt(2, 1) = -50
pnt(2, 2) = -50
pnt(2, 3) = -50

pnt(4, 1) = 50
pnt(4, 2) = 50
pnt(4, 3) = -50

pnt(3, 1) = -50
pnt(3, 2) = 50
pnt(3, 3) = -50

pnt(5, 1) = 50
pnt(5, 2) = -50
pnt(5, 3) = 50

pnt(6, 1) = -50
pnt(6, 2) = -50
pnt(6, 3) = 50

pnt(8, 1) = 50
pnt(8, 2) = 50
pnt(8, 3) = 50

pnt(7, 1) = -50
pnt(7, 2) = 50
pnt(7, 3) = 50

'***************************   defines two points to connect    **************
vect(1, 1) = 1
vect(1, 2) = 2

vect(2, 1) = 2
vect(2, 2) = 3

vect(3, 1) = 3
vect(3, 2) = 4

vect(4, 1) = 4
vect(4, 2) = 1

vect(5, 1) = 5
vect(5, 2) = 6

vect(6, 1) = 6
vect(6, 2) = 7

vect(7, 1) = 7
vect(7, 2) = 8

vect(8, 1) = 8
vect(8, 2) = 5

vect(9, 1) = 1
vect(9, 2) = 5

vect(10, 1) = 2
vect(10, 2) = 6

vect(11, 1) = 3
vect(11, 2) = 7

vect(12, 1) = 4
vect(12, 2) = 8

CALL drawit
LOCATE 1, 1: PRINT "Use number keys on key pad to rotate cube"
DO
a$ = INKEY$                   'get input from keyboard
IF a$ <> "" THEN
  a = VAL(a$)                 'changes variable a from a word to number
  IF a = 1 THEN               'checks for key "1"
    angx = -5: angy = 5
  ELSEIF a = 2 THEN           'checks for key "2"
    angx = 0: angy = 5
  ELSEIF a = 3 THEN           'checks for key "3"
    angx = 5: angy = 5
  ELSEIF a = 4 THEN           'etc...
    angx = -5: angy = 0
  ELSEIF a = 6 THEN
    angx = 5: angy = 0
  ELSEIF a = 7 THEN
    angx = -5: angy = -5
  ELSEIF a = 8 THEN
    angx = 0: angy = -5
  ELSEIF a = 9 THEN
    angx = 5: angy = -5
  ELSEIF a = 0 THEN
    angx = 0: angy = 0
  ELSE
    angx = 0: angy = 0
    GOTO here               'checks for anything else
  END IF
  FOR n = 1 TO UBOUND(pnt, 1) 'goes through each point in the object
    a$ = INKEY$               'stops program from "beeping"
    CALL rot(pnt(n, 1), pnt(n, 3), (angx))  'rotates the x and z of a point
    CALL rot(pnt(n, 2), pnt(n, 3), (angy))  'rotates the y and z of a point
  NEXT
  LINE (xmid - 100, ymid - 100)-(xmid + 100, ymid + 100), 0, BF  'clears a bit of the screen
  CALL drawit               'call the function drawit
here:
END IF
LOOP

SUB drawit
FOR n = 1 TO UBOUND(vect, 1)        'goes through each vect variable
  a = vect(n, 1)                    'first point in the vector
  b = vect(n, 2)                    'second point in the vector
  IF ((pnt(a, 3) + pnt(b, 3)) / 2) < 0 THEN  'if z point is further than 0 then
    col = 8                       'colour it 8
  ELSE
    col = 15                      'else colour it 15
  END IF
  c = 256                         'sets the perspective distance
  nx1 = pnt(a, 1)
  ny1 = pnt(a, 2)
  nx2 = pnt(b, 1)                 'works out the z projection into the screen
  ny2 = pnt(b, 2)
  x1 = (c * nx1) / (c - pnt(a, 3))
  y1 = (c * ny1) / (c - pnt(a, 3))
  x2 = (c * nx2) / (c - pnt(b, 3))
  y2 = (c * ny2) / (c - pnt(b, 3))
  LINE (xmid + x1, ymid + y1)-(xmid + x2, ymid + y2), col  'draws the line
NEXT
END SUB

SUB rot (b, c, a)
a = a * DTR                 'converts from degrees to radians
t = ATN(c / b)               'gets angle of vector
IF b < 0 THEN t = t + (180 * DTR)
mag = SQR((b * b) + (c * c))     'gets the length of the vector
a = t - a                    'takes off a from t
b = mag * COS(a)             'multiplies the length by the cos of the angle
c = mag * SIN(a)             'multiplies the length by the sine of the angle
END SUB

