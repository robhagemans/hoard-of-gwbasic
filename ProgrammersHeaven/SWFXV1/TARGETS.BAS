'Name      : Targets.bas ver 1.1
'Purpose   : Demonstraits using fx sounds in a Qbasic/QuickBASIC game.
'Date      : 1/24/97
'Finalized : 1/25/97
'Author    : Tim Truman
'Copyright (c) 1997  Nocturnal Creations. All Rights Reserved

'Changes from ver 1.0 :
'Allows speed setting. Change below to suit version of basic.

'Note: In order to run in QuickBASIC 4.5 you must load the QB.QLB library.
'      Example: QB /l QB.QLB

TYPE sprite
  x  AS INTEGER
  y  AS INTEGER
  xl AS INTEGER
  yl AS INTEGER
  w AS INTEGER
  h AS INTEGER
  c AS INTEGER
  mem1 AS INTEGER
  mem2 AS INTEGER
  alive AS INTEGER
END TYPE

DECLARE SUB DoBoss ()
DECLARE SUB Docollisions ()
DECLARE SUB Eraseimages ()
DECLARE SUB DoExplosions ()
DECLARE SUB DoLazer ()
DECLARE SUB DoScore ()
DECLARE SUB DoShip ()
DECLARE SUB DoStars ()
DECLARE SUB DoTarget ()
DECLARE SUB Mouse (func%)
DECLARE SUB playsfx (sfx$)
DECLARE SUB Showimages ()
DECLARE FUNCTION Bbox (x1%, y1%, w1%, h1%, x2%, y2%, w2%, h2%)


CONST True = -1
CONST False = 0

COMMON SHARED level%, levelflag%, score&, targetcounter%
COMMON SHARED mousex%, mousey%, mouseb%, Speed%

DIM SHARED c$(8)   'FM register information for 9 channels
c$(0) = "&hB0&h20&h23&h40&h43&h60&h63&h80&h83&hA0&HBD&HC0&HE0&HE3&hB0"
c$(1) = "&hB1&h21&h24&h41&h44&h61&h64&h81&h84&hA1&HBD&HC1&HE1&HE4&hB1"
c$(2) = "&hB2&h22&h25&h42&h45&h62&h65&h82&h85&hA2&HBD&HC2&HE2&HE5&hB2"
c$(3) = "&hB3&h28&h2B&h48&h4B&h68&h6B&h88&h8B&hA3&HBD&HC3&HE8&HEB&hB3"
c$(4) = "&hB4&h29&h2C&h49&h4C&h69&h6C&h89&h8C&hA4&HBD&HC4&HE9&HEC&hB4"
c$(5) = "&hB5&h2A&h2D&h4A&h4D&h6A&h6D&h8A&h8D&hA5&HBD&HC5&HEA&HED&hB5"
c$(6) = "&hB6&h30&h33&h50&h53&h70&h73&h90&h93&hA6&HBD&HC6&HF0&HF3&hB6"
c$(7) = "&hB7&h31&h34&h51&h54&h71&h74&h91&h94&hA7&HBD&HC7&HF1&HF4&hB7"
c$(8) = "&hB8&h32&h35&h52&h55&h72&h75&h92&h95&hA8&HBD&HC8&HF2&HF5&hB8"

DIM SHARED sfx$(25)                   'dim array to hold 26 sounds
OPEN "various.sfx" FOR INPUT AS #1    'open the .SFX file
FOR sfxnum% = 0 TO 25                 'load all sounds
 INPUT #1, sfx$(sfxnum%)              'load sound into string
NEXT                                  'next
CLOSE #1                              'close the file

DIM SHARED Mcode%(0 TO 56)           'array for machine code
DEF SEG = VARSEG(Mcode%(0))          'set array segment
offset% = VARPTR(Mcode%(0))          'set array address
FOR i% = 0 TO 56                     'read in machine code
 READ byte%
 POKE offset% + i%, byte%            'poke byte into array
NEXT

DIM SHARED shipimage%(0 TO 260)      'array for ship image
FOR i% = 0 TO 260                    'first element to last
 READ shipimage%(i%)                 'read element
NEXT

DIM SHARED ship AS sprite
DIM SHARED lazer AS sprite           'array for ship lazer
DIM SHARED target(4) AS sprite       'array for for targets
DIM SHARED expl(5) AS sprite         'array for for explosions

PRINT " Thanks for trying Targets. "
PRINT " You should have recieved this version of Targets"
PRINT " with a shareware copy of 'FX' the Sound effects editor."
PRINT " If you don't have FX your missing out on trying a great program."
PRINT " FX makes adding sound effects to your Qbasic(r) programs easy. "
PRINT " If you would like a shareware copy of FX send me a note"
PRINT " at AOL:TimTruman,Internet:TimTruman@aol.com or CompuServe:74734,2203."
PRINT ""
PRINT "                     Targets Ver 1.0"
PRINT ""
PRINT " To play game :"
PRINT " Move mouse to move ship. Press left mouse button to fire."
PRINT " Press ESC to quit game."
PRINT " "
PRINT " Press any key to continue"
DO: LOOP UNTIL LEN(INKEY$)

SCREEN 7, , 1, 0

CLS

Mouse 0                              'initalize mouse
mousex% = 160: mousey% = 100         'mouse start
Mouse 4                              'set mouse position

ship.mem1 = 3                 'number of ship lives
ship.alive = True             'so ship will appear
ship.w = 25: ship.h = 32      'set width and height for collision detection
level% = 1                    'level start
Speed% = 3                    'About 3 for Qbasic and 6 for QuickBasic

playsfx sfx$(6)

DO
 Mouse 3
 DoStars
 DoShip
 DoTarget
 DoLazer
 PCOPY 1, 0
 Eraseimages
 DoExplosions
 Docollisions
LOOP UNTIL ship.mem1 = 0 OR INKEY$ = CHR$(27) OR level% = 20


SCREEN 7, , 0, 0
DoScore
LOCATE 10, 1
playsfx sfx$(5)               'play sound effect
PRINT "                Game Over         "
PRINT
PRINT "        Thanks for playing Targets."
PRINT
PRINT "        Press any key to continue. "
DO: LOOP UNTIL LEN(INKEY$)
SCREEN 0, 0, 0


'machine language for mouse
DATA &H55,&H89,&HE5,&H8B,&H5E,&H0C,&H8B,&H07,&H50,&H8B
DATA &H5E,&H0A,&H8B,&H07,&H50,&H8B,&H5E,&H08,&H8B,&H0F
DATA &H8B,&H5E,&H06,&H8B,&H17,&H5B,&H58,&H1E,&H07,&HCD
DATA &H33,&H53,&H8B,&H5E,&H0C,&H89,&H07,&H58,&H8B,&H5E
DATA &H0A,&H89,&H07,&H8B,&H5E,&H08,&H89,&H0F,&H8B,&H5E
DATA &H06,&H89,&H17,&H5D,&HCA,&H08,&H00


'ship image data
DATA &H20,&H20
DATA &H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000
DATA &H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000
DATA &H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000
DATA &H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000
DATA &H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000
DATA &H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000
DATA &H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000
DATA &H0000,&H0000,&H0080,&H0000,&H0080,&H0000,&H0080,&H0000,&H0000
DATA &H0000,&H0080,&H0000,&H0080,&H0000,&H0080,&H0000,&H0000,&H0100
DATA &H0040,&H0100,&H0040,&H0100,&H0040,&H0000,&H0080,&H0100,&H0040
DATA &H0100,&H0040,&H0100,&H0040,&H0000,&H0080,&H0100,&H0040,&H0100
DATA &H0040,&H0100,&H0040,&H0000,&H0080,&H0200,&H0020,&H0300,&H0060
DATA &H0300,&H0060,&H0100,&H00C0,&H0200,&H0020,&H0300,&H0060,&H0300
DATA &H0060,&H0100,&H00C0,&H0200,&H0020,&H0300,&H0060,&H0300,&H0060
DATA &H0100,&H00C0,&H0400,&H0000,&H0700,&H0070,&H0700,&H0070,&H0300
DATA &H00E0,&H0400,&H0000,&H0700,&H0070,&H0700,&H0070,&H0300,&H00E0
DATA &H0800,&H0088,&H0800,&H0088,&H0800,&H0088,&H0700,&H0070,&H0800
DATA &H0088,&H0800,&H0088,&H0800,&H0088,&H0700,&H0070,&H1000,&H0084
DATA &H1000,&H0084,&H1000,&H0084,&H0F00,&H0078,&H1001,&H4084,&H1001
DATA &H4084,&H1001,&H4084,&H0F00,&H0078,&H2101,&H4042,&H2101,&H4042
DATA &H2101,&H4042,&H1E00,&H00BC,&H4101,&H4041,&H4101,&H4041,&H4101
DATA &H4041,&H3E00,&H00BE,&H8101,&HC040,&H8101,&HC040,&H8101,&HC040
DATA &H7E00,&H00BF,&H0101,&H4040,&H0101,&H4040,&H0101,&H4040,&HFE00
DATA &H80BF,&H0302,&H2060,&H0302,&H2060,&H0302,&H2060,&HFC01,&HC09F
DATA &H0304,&H1060,&H0304,&H1060,&H0304,&H1060,&HFC03,&HE09F,&H030A
DATA &H2860,&H030A,&H2860,&H030A,&H2860,&HFC05,&HD09F,&H0311,&H4460
DATA &H0311,&H4460,&H0311,&H4460,&HFC0E,&HB89F,&H833F,&HFE60,&H833F
DATA &HFE60,&H833F,&HFE60,&H7C00,&H009F,&H7F00,&H00FF,&H7F00,&H00FF
DATA &H7F00,&H00FF,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000,&H0000

FUNCTION Bbox (x1%, y1%, w1%, h1%, x2%, y2%, w2%, h2%)
'Checks for collisions using the bounding box method.
'Expects constants True and False to be defined in Main.
'Returns True if collision , False if no collision.


IF (x1% >= x2% + w2%) OR (x2% > x1% + w1%) OR (y1% > y2% + h2%) OR (y2% > y1% + h1%) THEN
 Bbox = False
ELSE
 Bbox = True
END IF


END FUNCTION

SUB Docollisions



'check for target hits with lazer
FOR i = 0 TO UBOUND(target)
IF target(i).alive = True THEN
  IF Bbox(lazer.x, lazer.y, lazer.w, lazer.h, target(i).x, target(i).y, target(i).w, target(i).h) THEN
    playsfx sfx$(1)               'play sound effect
    lazer.alive = False
    target(i).alive = False
    score& = score& + 20
    DoScore
    FOR e = 0 TO UBOUND(expl)
     IF expl(e).alive = False THEN
      expl(e).alive = True
      expl(e).x = target(i).x
      expl(e).y = target(i).y
      EXIT FOR
     END IF
    NEXT
  END IF
 END IF
NEXT

'check for target hits with ship
FOR i = 0 TO UBOUND(target)
 IF target(i).alive = True THEN
  IF Bbox(ship.x, ship.y + ship.h / 2, ship.w, ship.h, target(i).x, target(i).y, target(i).w, target(i).h) THEN
    ship.alive = False
    target(i).alive = False
    playsfx sfx$(4)               'play sound effect
    FOR n = 1 TO 15
    FOR e = 0 TO UBOUND(expl)
     IF expl(e).alive = False THEN
      expl(e).alive = True
      expl(e).x = ship.x + RND * 20
      expl(e).y = ship.y + RND * 20
      EXIT FOR
     END IF
   NEXT
   NEXT
  END IF
 END IF
NEXT


END SUB

SUB DoExplosions

FOR i = 0 TO UBOUND(expl)
IF expl(i).alive THEN
  
   IF expl(i).mem1 < 14 THEN
    expl(i).mem1 = expl(i).mem1 + 1
    CIRCLE (expl(i).x, expl(i).y), expl(i).mem1, 15
   END IF
   IF expl(i).mem1 > 3 THEN
    expl(i).mem2 = expl(i).mem2 + 1
    CIRCLE (expl(i).x, expl(i).y), expl(i).mem2, 0
   END IF
   IF expl(i).mem2 = 15 THEN
     expl(i).alive = False
     expl(i).mem1 = 0:   expl(i).mem2 = 0
     IF ship.alive = False THEN DoScore
   END IF

END IF

NEXT
END SUB

SUB DoLazer

 IF mouseb% = 1 THEN    'Fire weapon
  IF lazer.alive = False THEN
   lazer.alive = True
   lazer.x = mousex% + 6
   lazer.y = 178
   lazer.w = 24
   lazer.h = 5
   playsfx sfx$(0)               'play sound effect
  END IF
 END IF


IF lazer.alive THEN
  lazer.xl = lazer.x   'save last position for erase
  lazer.yl = lazer.y

  LINE (lazer.x, lazer.y)-(lazer.x, lazer.y - lazer.h), 14, BF
  LINE (lazer.x + 20, lazer.y)-(lazer.x + 20, lazer.y - lazer.h), 14, BF

  lazer.y = lazer.y - 3

  IF lazer.y < 20 THEN lazer.alive = False  'lazer off screen

END IF

END SUB

SUB DoScore

IF ship.alive = False THEN
  samp! = TIMER
  DO: LOOP UNTIL ABS(TIMER - samp!) > 1
  ship.mem1 = ship.mem1 - 1
  ship.alive = True
END IF


IF targetcounter% > 39 THEN
  targetcounter% = 0
  levelflag% = True
END IF

IF levelflag% = True THEN
  FOR i = 0 TO UBOUND(target)
   test% = test% + target(i).alive
  NEXT
   IF test% = 0 THEN
    levelflag% = False
    level% = level% + 1
    playsfx sfx$(3)               'play sound effect
   END IF
END IF


LOCATE 1, 1: PRINT "Score"; score&; " Level "; level%; " Lives "; ship.mem1
 
END SUB

SUB DoShip

 IF mousex% > 287 THEN mousex% = 287      'keep image on screen
 IF mousey% > 167 THEN mousey% = 167      'ditto
 ship.x = mousex%: ship.y = 160:
 IF ship.alive THEN
  PUT (ship.x, ship.y), shipimage%(0), PSET
 END IF

END SUB

SUB DoStars


STATIC bgcolor, fgcolor, velocity
STATIC ns AS INTEGER, oldstarx()  AS INTEGER, oldstary() AS INTEGER
STATIC starx() AS INTEGER, stary() AS INTEGER, starspeed() AS INTEGER

IF ns = 0 THEN        ' First time here initialize values
 ns = 10
 DIM oldstarx(ns)   AS INTEGER
 DIM oldstary(ns)   AS INTEGER
 DIM starx(ns)      AS INTEGER
 DIM stary(ns)      AS INTEGER
 DIM starspeed(ns)  AS INTEGER

 FOR c = 0 TO ns
   stary(c) = (RND * 170) + 20
   starx(c) = RND * 319
   starspeed(c) = (RND * 2) + 1
 NEXT
    
END IF


FOR c = 0 TO ns

 IF oldstary(c) >= 199 THEN   'need a new star
   stary(c) = 20
   starx(c) = RND * 319
   starspeed(c) = (RND * 2) + 1
   oldstary(c) = stary(c)
 END IF
 oldstary(c) = stary(c)      '  save position to erase oldstar
 oldstarx(c) = starx(c)
 stary(c) = stary(c) + starspeed(c)  ' move star
 PSET (starx(c), stary(c)), 7  ' write star to screen
 PSET (oldstarx(c), oldstary(c)), 0

NEXT


END SUB

SUB DoTarget

FOR i = 0 TO UBOUND(target)

IF target(i).alive = False AND levelflag% = False THEN 'generate a new target
  target(i).alive = True
  target(i).x = (RND * 240) + 40
  target(i).y = (RND * 90) + 20
  target(i).c = 0
  target(i).mem1 = -6
  target(i).mem2 = -1
  target(i).w = 1
  target(i).h = 6
  targetcounter% = targetcounter% + 1
  playsfx sfx$(2)
END IF

IF target(i).alive = True THEN
target(i).xl = target(i).x: target(i).yl = target(i).y
target(i).c = (target(i).c + 1) MOD Speed%
IF target(i).c = 0 THEN
  target(i).mem1 = target(i).mem1 + 1
  target(i).mem2 = target(i).mem2 + 1
  IF target(i).mem1 = 0 THEN target(i).mem1 = -6
  IF target(i).mem2 = 0 THEN target(i).mem2 = -6
  target(i).w = target(i).w + 1
  IF target(i).w > 10 THEN
   target(i).w = 10
   SELECT CASE level%                             'movement patterns
   CASE 1, 2
   target(i).y = target(i).y + 2
   CASE 3
   target(i).x = target(i).x - 1
   target(i).y = target(i).y + 2
   CASE 4
   target(i).x = target(i).x + 1
   target(i).y = target(i).y + 2
   CASE 5
   IF target(i).mem1 MOD 2 THEN target(i).x = target(i).x - 2
   IF target(i).x MOD 2 = 0 THEN target(i).y = target(i).y + 3
   CASE 6
   IF target(i).mem1 MOD 2 THEN target(i).x = target(i).x + 2
   IF target(i).x MOD 2 = 0 THEN target(i).y = target(i).y + 3
   CASE 7
   target(i).x = target(i).x - target(i).mem1
   target(i).y = target(i).y + 2
   CASE 8
   target(i).x = target(i).x + target(i).mem1
   target(i).y = target(i).y + 2
   CASE 9
   target(i).x = target(i).x + target(i).mem1
   target(i).y = target(i).y - target(i).mem1
   CASE 10
   target(i).x = target(i).x - target(i).mem1
   target(i).y = target(i).y - target(i).mem1
   CASE 11, 12
   target(i).y = target(i).y - 3
   CASE 13, 14
   target(i).y = target(i).y - target(i).mem2 + 1
   CASE 15, 16
   target(i).y = target(i).y + 4
   CASE 17, 18
   IF target(i).mem1 MOD 4 THEN target(i).x = target(i).x + 4
   IF target(i).x MOD 2 = 0 THEN target(i).y = target(i).y + 6
   CASE 19, 20
   IF target(i).mem1 MOD 2 THEN target(i).x = target(i).x - 4
   IF target(i).x MOD 2 = 0 THEN target(i).y = target(i).y + 6

  END SELECT

  IF target(i).y > 199 - target(i).h OR target(i).y < 15 THEN target(i).alive = False
  IF target(i).x < -10 OR target(i).x > 319 THEN target(i).alive = False
 END IF
END IF

SELECT CASE level%
CASE 1, 3, 5, 7, 9, 11, 13, 15, 17, 19
 LINE (target(i).x, target(i).y)-(target(i).x + target(i).w, target(i).y + target(i).h), 9, B
CASE 2, 4, 6, 8, 10, 12, 14, 16, 18, 20
 CIRCLE (target(i).x + target(i).w / 2, target(i).y), target(i).w, 9, target(i).mem1, target(i).mem2
END SELECT

END IF

NEXT

END SUB

SUB Eraseimages

  IF ship.alive THEN
   PUT (ship.x, ship.y), shipimage%(0)
  END IF

  LINE (lazer.xl, lazer.yl)-(lazer.xl, lazer.yl - lazer.h), 0, BF
  LINE (lazer.xl + 20, lazer.yl)-(lazer.xl + 20, lazer.yl - lazer.h), 0, BF

  FOR i = 0 TO UBOUND(target)
   SELECT CASE level%
   CASE 1, 3, 5, 7, 9, 11, 13, 15, 17, 19
   LINE (target(i).x, target(i).y)-(target(i).x + target(i).w, target(i).y + target(i).h), 0, B
   CASE 2, 4, 6, 8, 10, 12, 14, 16, 18, 20
   CIRCLE (target(i).x + target(i).w / 2, target(i).y), target(i).w, 0, target(i).mem1, target(i).mem2
   END SELECT
   IF target(i).alive THEN test% = test + 1
  NEXT
  IF test% = 0 THEN DoScore   'test for level change


END SUB

SUB Mouse (func%)


DEF SEG = VARSEG(Mcode%(0))          'set array segment
offset% = VARPTR(Mcode%(0))          'get array address


SELECT CASE func%

CASE 0  'reset mouse driver
 
  ax% = 0: bx% = 0: cx% = 0: dx% = 0
  CALL Absolute(ax%, bx%, cx%, dx%, offset%)
  IF ax% = 0 THEN
   ' PRINT "No mouse detected!"
   ' PRINT "Sorry, this program requires a mouse."
   ' END
  ELSE
    'PRINT "Mouse found"
  END IF


CASE 1    'mouse cursor on
  ax% = 1: bx% = 0: cx% = 0: dx% = 0
  CALL Absolute(ax%, bx%, cx%, dx%, offset%)

CASE 2    'mouse cursor off
  ax% = 2: bx% = 0: cx% = 0: dx% = 0
  CALL Absolute(ax%, bx%, cx%, dx%, offset%)

CASE 3    'get mouse statsus

  ax% = 3: bx% = 0: cx% = 0: dx% = 0
  CALL Absolute(ax%, bx%, cx%, dx%, offset%)
  mouseb% = bx%
  mousex% = cx% / 2
  mousey% = dx%


END SELECT

DEF SEG

END SUB

SUB playsfx (sfx$)


'Plays the sfx$ that is sent to it.
'Sub routine expects the c$() array (channel info) to be global.

chan% = VAL(MID$(sfx$, 61, 4))
FOR in = 1 TO 60 STEP 4
  reg$ = MID$(c$(chan%), in, 4): reg% = VAL(reg$)
  dat$ = MID$(sfx$, in, 4): dat% = VAL(dat$)
  OUT &H388, reg%: FOR d% = 1 TO 6: b% = INP(&H388): NEXT
  OUT &H389, dat%: FOR d% = 1 TO 35: b% = INP(&H388): NEXT
NEXT


END SUB

