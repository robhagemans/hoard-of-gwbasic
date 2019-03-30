DEFINT A-Z
DECLARE SUB info ()
DECLARE SUB ReadPal ()
DECLARE SUB MeltSub ()
DECLARE SUB Spin (rot!)
DECLARE SUB Table ()
DECLARE SUB RotPal ()
DECLARE SUB GetKey ()
DECLARE SUB SprSub ()
DECLARE SUB Fire ()
DECLARE SUB SetScr ()
DECLARE SUB DrawHole ()
DECLARE SUB PPSET (x%, y%, c1%)
DECLARE SUB SetPal (c2%, Red%, Green%, Blue%)
COMMON SHARED UserFireInput, x, y, mx, my, c1, c2
COMMON SHARED Red, Green, Blue
COMMON SHARED RedChange, GreenChange, BlueChange
COMMON SHARED ReStart, Done, melt, Ani, UseFire, SprRot, k$, dir
COMMON SHARED imsx, imsy, ix, iy, cx, cy, rot!
COMMON SHARED MeltAmount

CONST TRUE = -1: FALSE = NOT TRUE

imsx = 20: imsy = 20        'variables for sprite rotation
cx = imsx / 2: cy = imsy / 2
ix = 160: iy = 200 - imsx

MeltAmount = 100            'How much to melt

'dim sprites
DIM SHARED Spr(222)                      'little circle thing
DIM SHARED SprMask(222)                  'its mask
DIM SHARED SprBkg(222)                   'its background
DIM SHARED FireBkg(222)                  'fires background
DIM SHARED image(imsx, imsy)             'spinning thing
DIM SHARED melt(2)                       'melt routine

DIM SHARED OldRed(255)       'arrays to save old palette
DIM SHARED OldBlue(255)
DIM SHARED OldGreen(255)

info

SCREEN 13: CLS : RANDOMIZE TIMER

UserFireInput = 10          'controls the speed that the fire changes
                           'the greater the slower the fire changes
ReadPal                    'Save old palette

SetScr                     'gets sprites draws screen

Red = 0: Green = 0: Blue = 0
FOR c = 90 TO 76 STEP -1   'set fire palette
  Red = Red + 3
  SetPal c, Red, 0, 0
NEXT

Red = 0: Green = 20: Blue = 0
FOR c = 75 TO 64 STEP -1   'set palette for sprite animation
  Green = Green + 2
  SetPal c, Red, Green, Blue
NEXT

Red = 30: Green = 0: Blue = 63 - imsx * 2
FOR c = 92 TO 92 + imsy    'set palette for sprite rotation
  Red = Red
  Green = Green
  Blue = Blue + 2
  SetPal c, Red, Green, Blue
NEXT

SetPal 91, 63, 63, 63      'set palette for letters

DEF SEG = &HA000           'define the segment for ppset routine
start:
RedChange = INT(RND * 2)   'controls red
GreenChange = INT(RND * 2) 'controls green
BlueChange = INT(RND * 2)  'controls blue
IF RedChange = 0 AND GreenChange = 0 AND BlueChange = 0 THEN GOTO start
                           'make sure the palette isn't all black
dir = -dir                 'controls the direction of the palette rotate


DO

IF UseFire = TRUE THEN Fire 'calls Fire routine
                          
IF Ani = TRUE THEN SprSub   'calls Sprite Animation routine (sort of slow)

RotPal                      'calls Palette Rotate routine for WormHole Effect

IF SprRot = TRUE THEN
  Spin ra!                  'calls Sprite Rotation routine (very slow)
  ra! = ra! + .1
END IF

GetKey                      'it does what it says

IF ReStart = TRUE THEN ReStart = FALSE: GOTO start
IF Done = TRUE THEN Done = FALSE: GOTO finish
IF melt = TRUE THEN MeltSub 'melts the background (this sub is not mine and
                            'I found it somewhere and I don't know whose
                            'it is, but it looks cool here.  So thanks to
                            'whoever wrote it.
LOOP
finish:

FOR c = 0 TO 255            'restores old palette
SetPal c, OldRed(c), OldGreen(c), OldBlue(c)
NEXT

DEF SEG
SCREEN 0, 0, 0, 0
WIDTH 80, 25
END

SUB DrawHole
CLS
x = 160
dir = 1
FOR s = 0 TO 450
  y = -(SQR(s) * 10) + 200
   IF c >= 62 THEN c = 0 ELSE c = c + 1
     CIRCLE (x, y), s, c + 1, , , 1 / 2
     CIRCLE (x, y + 1), s, c + 1, , , 1 / 2
     CIRCLE (x, y + 2), s, c + 1, , , 1 / 2
NEXT
END SUB

SUB Fire STATIC

IF first = 0 THEN

first = 1

CIRCLE (160, 100), 10, 76, 3.1, 6.25
GET (150, 90)-(170, 110), FireBkg

ELSE

FireDelay = FireDelay + 1
IF FireDelay MOD UserFireInput = 0 THEN FireDelay = 0
IF FireDelay = 0 THEN
PUT (150, 90), FireBkg, PSET
  FOR fy = 110 TO 90 STEP -1
  FOR fx = 170 TO 150 STEP -1
    p1 = POINT(fx, fy)
      IF p1 > 75 AND p1 < 84 THEN
        o = INT(RND * 5)
        p2 = POINT(fx, fy - 1)
          IF p2 < 64 THEN PPSET fx, fy - 1, p1 + o
      END IF
  NEXT
  NEXT
END IF

END IF
END SUB

SUB GetKey
k$ = INKEY$
IF k$ = "4" THEN mx = mx - 1
IF k$ = "6" THEN mx = mx + 1
IF k$ = "2" THEN my = my + 1
IF k$ = "8" THEN my = my - 1
IF k$ = " " THEN ReStart = TRUE
IF UCASE$(k$) = "Q" THEN Done = TRUE
IF UCASE$(k$) = "M" THEN
    IF melt = FALSE THEN melt = TRUE: EXIT SUB
    IF melt = TRUE THEN melt = FALSE
END IF
IF UCASE$(k$) = "F" THEN
    IF UseFire = FALSE THEN UseFire = TRUE: EXIT SUB
    IF UseFire = TRUE THEN UseFire = FALSE
END IF
IF UCASE$(k$) = "S" THEN
    IF Ani = FALSE THEN Ani = TRUE: EXIT SUB
    IF Ani = TRUE THEN Ani = FALSE
END IF
IF UCASE$(k$) = "R" THEN
    IF SprRot = FALSE THEN SprRot = TRUE: EXIT SUB
    IF SprRot = TRUE THEN SprRot = FALSE
END IF
END SUB

SUB info
CLS
PRINT "Hole.bas by Matt Bross"
PRINT "Homepage-->http://www.geocities.com/SoHo/7067/"
PRINT "Email----->oh_bother@geocities.com"
PRINT ""
PRINT "Use as you like as long as I am given some credit"
PRINT ""
PRINT "I know that the wormhole effect is very like the one by Lucifer Productions"
PRINT "But I swear not a line of code was stolen"
PRINT ""
PRINT "controls"
PRINT "--------"
PRINT "space bar-change hole color/direction"
PRINT "S/s-starts/stops flicker-free screen 13 sprite animation"
PRINT "R/r-starts/stops sprite rotation"
PRINT "M/m-starts/stops melting routine"
PRINT "F/f-starts/stops fire routine"
PRINT "Num Pad controls sprite in Sprite animation"
PRINT "Make sure your NUM LOCK is on"
PRINT "Q/q-quits"
DO: LOOP UNTIL INKEY$ <> ""
END SUB

SUB MeltSub
FOR t = 0 TO MeltAmount
MeltX = INT(RND * 318)
MeltY = INT(RND * 199)

GET (MeltX, MeltY)-(MeltX + 1, MeltY), melt
PUT (MeltX, MeltY + 1), melt, PSET
NEXT
END SUB

SUB PPSET (x, y, c)
POKE y * 320& + x, c
END SUB

SUB ReadPal
FOR c = 0 TO 255
OUT &H3C7, c
OldRed(c) = INP(&H3C9)
OldGreen(c) = INP(&H3C9)
OldBlue = (c) = INP(&H3C9)
NEXT
END SUB

SUB RotPal STATIC
IF dir = -1 THEN a = 1: b = 64: s = 1
IF dir = 1 THEN a = 64: b = 1: s = -1
  FOR i = a TO b STEP s
   SetPal i, Red, Green, Blue
     Red = Red + RedChange
     Green = Green + GreenChange
     Blue = Blue + BlueChange
   IF Red >= 63 THEN Red = 0
   IF Green >= 63 THEN Green = 0
   IF Blue >= 63 THEN Blue = 0
  NEXT
END SUB

SUB SetPal (c, Red, Green, Blue)
  OUT &H3C8, c
  OUT &H3C9, Red
  OUT &H3C9, Green
  OUT &H3C9, Blue
END SUB

SUB SetScr

CLS
FOR a = 0 TO imsx
LINE (0, a)-(imsx, a), a + 92
NEXT
LINE (0, 0)-(imsx, imsy), 0, B

FOR sy = 0 TO imsy
FOR sx = 0 TO imsx
image(sx, sy) = POINT(sx, sy)
NEXT: NEXT

CLS
LINE (20, 0)-(40, 20), 255, BF
CIRCLE (30, 10), 10, 0: PAINT (30, 10), 0
GET (20, 0)-(40, 20), SprMask

CLS
FOR r = 10 TO 0 STEP -1
CIRCLE (10, 10), r, r + 65: PAINT (10, 10), r + 65
NEXT
GET (0, 0)-(20, 20), Spr

DrawHole

x = 0: y = 0
GET (x, y)-(x + 20, y + 20), SprBkg
END SUB

SUB Spin (rot!)

half! = 135.085
FOR sy = 0 TO imsy
FOR sx = 0 TO imsx
  a = sy - cy
  b = sx - cx
        dis! = SQR((sx - cx) ^ 2 + (sy - cy) ^ 2)
      IF b = 0 THEN
        an! = rot! + half! / 2
        IF sy <= cy THEN an! = an! + half!
        PPSET CINT(ix + (SIN(an!) * dis!)), CINT(iy + (COS(an!) * dis!)), image(sx, sy)
      ELSE
        an! = ATN(a / b)
        an! = an! + rot!
          IF sx >= cx THEN an! = an! + half!
        PPSET CINT(ix + SIN(an!) * dis!), CINT(iy + COS(an!) * dis!), image(sx, sy)
      END IF
NEXT
NEXT
END SUB

SUB SprSub STATIC

IF x < 0 THEN x = 0
IF y < 0 THEN y = 0
IF x > 299 THEN x = 299
IF y > 179 THEN y = 179

WAIT &H3DA, 8
PUT (x, y), SprBkg, PSET
  x = x + mx
  y = y + my
    IF x < 0 THEN x = 0
    IF y < 0 THEN y = 0
    IF x > 299 THEN x = 299
    IF y > 179 THEN y = 179
  GET (x, y)-(x + 20, y + 20), SprBkg
PUT (x, y), SprMask, AND
PUT (x, y), Spr, OR

GetKey

END SUB

