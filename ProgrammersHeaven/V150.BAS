


'I've added a laser, used by hitting [SPACE].  There are also floating
'blocks which you can zap with the laser, which will give you points
'(there are points now, too).  Plus, if you can find the special pillar,
'you'll get lots of points (whee!).
'
'There's also a map, accessible by hitting [M].  And collision
'detection.  And sound, which can be turned on/off (use [S]).
'
'I'm NOT suggesting this become the standard version of Ray Caster from
'now on; I just think you might have fun with this variation.
'
'The lines are rather long, so you'll have to go through it and correct
'the line-length thing.
'
'Mr. Cooper: did you notice that the map in MakeWorld and the real world
'you move through are flipped around?  Study the MakeWorld map, then run
'the program; you'll see that everything's switched around.  All you have
'to do is swap X and Y variables in the k% = ASC(...) line, if you'd
'like.
'
'Enjoy!

'---------- BEGIN INCLUDED CODE ----------
' ===================================================================
'                      Ray Zapper World version 1.00  (Ray World 1.5)
' ===================================================================
'  Written by:  Peter Cooper  (peco@trenham.demon.co.uk)
'                              http://www.trenham.demon.co.uk/
'               Brent P. Newhall (bnewhall@gmu.edu)
'  Status:      Public Domain
'  Original:    14th August
'  History:     Originally v1.01 of Ray Tracer World (14th August)

' Laser, block people, krazy kolumn, points, map, sound, and collision
'   detection added by Brent P. Newhall (bnewhall@gmu.edu)

' Quickie instructions: you can zap the floating blocks, and they'll
'   disappear.  Every time zap a block, you get 100 points.  Find the
'   krazy kolumn, and get 500 points.  [SPACE]=fire, [M]=Map.

' DECLARATIONS ======

COMMON SHARED px%, py%, sa%, SoundOn%
DECLARE SUB setupvariables ()
DECLARE SUB screensetup ()
DECLARE SUB makeworld ()
DECLARE SUB maketables ()
DECLARE SUB drawmap ()
DECLARE SUB crosshairs ()
DECLARE SUB printpoints (points%)
DECLARE SUB printsound ()
DIM SHARED st%(0 TO 360)
DIM SHARED ct%(0 TO 360)
DIM SHARED a$(1 TO 15)

' CALL SUBS ======

setupvariables
makeworld
maketables
screensetup

DO
  FOR t% = sa% TO sa% + 59 STEP 1
    MonstK% = 0
    xb = st%(t% MOD 360) / 100              'get inc
    yb = ct%(t% MOD 360) / 100              'get inc
    bx = px%                                'decimal copy
    by = py%                                'decimal copy
    l% = 0                                  'reset length
    DO
      bx = bx + xb
      by = by + yb
      l% = l% + 1
      k% = ASC(MID$(a$(CINT(bx / 10)), CINT(by / 10), 1)) - 48
      IF k% > 10 THEN ' Not a wall
        a = CINT(bx / 10) * 10
        b = CINT(by / 10) * 10
        IF ABS(bx - a) < 1 AND ABS(by - b) < 1 THEN ' Check middle ofblock
          MonstK% = k% - 16
          MonstX% = (t% - sa%) * 5
          MonstDD% = (1000 / l%)
        END IF
        k% = 0
      END IF
    LOOP UNTIL k% <> 0
    X% = (t% - sa%) * 5
    dd% = (1000 / l%)
    LINE (X% + 10, 12)-(X% + 15, 99 - dd%), 3, BF ' Ceiling
    LINE (X% + 10, 101 + dd%)-(X% + 15, 200), 2, BF ' Floor
    LINE (X% + 10, 100 - dd%)-(X% + 15, 100 + dd%), k%, BF
    LINE (X% + 10, 100 - dd%)-(X% + 15, 100 - dd%), 0 ' Line above
    LINE (X% + 10, 100 + dd%)-(X% + 15, 100 + dd%), 0 ' Line below
    IF MonstK% > 0 THEN ' Got something beyond a wall, too
      IF MonstK% < 20 THEN ' Just a floating block
        MonstDD% = MonstDD% / 3
      ELSE ' A kolumn!
        IF NOT found% THEN
          found% = -1 ' Found a kolumn for first time!
          points% = points% + 500
        END IF
        MonstK% = MonstK% - 20
      END IF
      LINE (MonstX% + 10, 100 - MonstDD%)-(MonstX% + 15, 100 + MonstDD%), MonstK%, BF
      LINE (MonstX% + 10, 100 - MonstDD%)-(MonstX% + 15, 100 - MonstDD%), 8' Upper
      LINE (MonstX% + 10, 100 + MonstDD%)-(MonstX% + 15, 100 + MonstDD%), 8' Lower
    END IF
  NEXT t%
  LINE (10, 0)-(310, 11), 0, BF
  LOCATE 1, 32
  PRINT "Ray Zapper v1.00"
  crosshairs
  printsound
  printpoints points%
  PCOPY 0, 1
  DO
    ina$ = INKEY$
  LOOP UNTIL ina$ <> ""
  ina$ = UCASE$(ina$)
  IF LEFT$(ina$, 1) = CHR$(0) THEN
    in2$ = RIGHT$(ina$, 1)
    IF in2$ = "M" THEN ' [LEFT]
      sa% = sa% + 5
      IF sa% > 360 THEN sa% = sa% - 360
    ELSEIF in2$ = "K" THEN ' [RIGHT]
      sa% = (sa% + 355) MOD 360
    ELSEIF in2$ = "H" THEN ' [UP]
      oldpx% = px%
      oldpy% = py%
      px% = px% + (st%((sa% + 30) MOD 360) / 30)
      py% = py% + (ct%((sa% + 30) MOD 360) / 30)
      IF ASC(MID$(a$(CINT(px% / 10)), CINT(py% / 10), 1)) - 48 > 0 THEN
        IF SoundOn% THEN SOUND 100, 1 ' Going through a wall!
        px% = oldpx%
        py% = oldpy%
      END IF
    ELSEIF in2$ = "P" THEN ' [DOWN]
      oldpx% = px%
      oldpy% = py%
      px% = px% - (st%((sa% + 30) MOD 360) / 30)
      py% = py% - (ct%((sa% + 30) MOD 360) / 30)
      IF ASC(MID$(a$(CINT(px% / 10)), CINT(py% / 10), 1)) - 48 > 0 THEN
        IF SoundOn% THEN SOUND 100, 1 ' Going through a wall!
        px% = oldpx%
        py% = oldpy%
      END IF
    ELSEIF in2$ = "G" THEN ' [HOME]
      px% = 15
      py% = 15
      sa% = 0
    END IF
  ELSEIF ina$ = "M" THEN
    drawmap
  ELSEIF ina$ = "S" THEN
    IF SoundOn% THEN SoundOn% = 0 ELSE SoundOn% = -1
  ELSEIF ina$ = " " THEN
    t% = sa% + 29
    xb = st%(t% MOD 360) / 100              'get inc
    yb = ct%(t% MOD 360) / 100              'get inc
    bx = px%                                'decimal copy
    by = py%                                'decimal copy
    l% = 0                                  'reset length
    DO
      bx = bx + xb
      by = by + yb
      l% = l% + 1
      k% = ASC(MID$(a$(CINT(bx / 10)), CINT(by / 10), 1)) - 48
      IF k% > 10 THEN
        IF k% - 16 < 20 THEN
          a = CINT(bx / 10) * 10' + 5
          b = CINT(by / 10) * 10' + 5
          IF NOT (ABS(bx - a) < 4 AND ABS(by - b) < 4) THEN
            k% = 0 ' Outside bounds
          END IF
        END IF
      END IF
    LOOP UNTIL k% <> 0
    CIRCLE (159, 100), (1000 / l%) / 7, 12
    PAINT (159, 100), 12
    CIRCLE (159, 100), (1000 / l%) / 7, 4
    CIRCLE (159, 100), (1000 / l%) / 14, 4
    LINE (159, 100)-(280, 200), 4: LINE (159, 100)-(281, 200), 4
    crosshairs
    PCOPY 0, 1
    IF SoundOn% THEN
      SOUND 2000, .2: SOUND 3000, .2
      SOUND 2000, .2: SOUND 3000, .2
      SOUND 2000, .2: SOUND 3000, .2
    END IF
    IF k% > 10 THEN
      a = CINT(bx / 10)
      b = CINT(by / 10)
      b$ = LEFT$(a$(a), b - 1)
      c$ = RIGHT$(a$(a), LEN(a$(1)) - b)
      a$(a) = b$ + "0" + c$
      points% = points% + 100
      IF k% - 16 > 20 THEN points% = 0
    END IF
  END IF
LOOP UNTIL ina$ = CHR$(27)
SCREEN 0: WIDTH 80, 25: SYSTEM
'--------- END INCLUDED CODE ----------
'
'Brent P. Newhall
'------------------------------------------------------------------
'"Our greatest weakness lies in giving up.  The most certain way to
'succeed is always to try just one more time." -- Thomas A. Edison

SUB crosshairs

' Draw the crosshairs

LINE (159, 95)-(159, 97), 15
LINE (159, 103)-(159, 105), 15
LINE (154, 100)-(156, 100), 15
LINE (162, 100)-(164, 100), 15

END SUB

SUB drawmap

FOR j% = 1 TO 15
  FOR I% = 1 TO LEN(a$(1))
    k% = ASC(MID$(a$(j%), I%, 1)) - 48
    IF k% - 16 > 20 THEN ' Hide krazy kolumns
      LINE (I% * 10 + 10, j% * 10 + 10)-(I% * 10 + 20, j% * 10 + 19), 0, BF
    ELSEIF k% > 10 THEN ' Block people
      LINE (I% * 10 + 10, j% * 10 + 10)-(I% * 10 + 20, j% * 10 + 19), 0, BF
      CIRCLE (I% * 10 + 15, j% * 10 + 15), 2, k% - 16
      PAINT (I% * 10 + 15, j% * 10 + 15), k% - 16
    ELSE ' Walls
      LINE (I% * 10 + 10, j% * 10 + 10)-(I% * 10 + 20, j% * 10 + 19), k%, BF
    END IF
  NEXT I%
NEXT j%

PSET (py% + 20, px% + 20), 15 ' Draw you as a pixel
a = px% + (st%((sa% + 50) MOD 360) / 50)
b = py% + (ct%((sa% + 50) MOD 360) / 50)
PSET (b + 20, a + 20), 3 ' Draw direction you're pointing a little away in
                         ' cyan
LOCATE 1, 32: PRINT "Hit any key.... ";
PCOPY 0, 1
DO: LOOP UNTIL INKEY$ <> ""

END SUB

SUB maketables

' Peters boring _yawn_ table creation
FOR tmp1% = 0 TO 360
  st%(tmp1%) = SIN(tmp1% * .0174) * 100
  ct%(tmp1%) = COS(tmp1% * .0174) * 100
  IF tmp1% MOD 100 = 0 THEN PRINT ; ".";
NEXT tmp1%

END SUB

SUB makeworld

' Peter Coopers demonstration level. Change it if you wish! Each number is
' a color number
a$(1) = "1919191919191919"
a$(2) = "9000000001000001"
a$(3) = "1000000409000009"
a$(4) = "9010000000000001"
a$(5) = "1020000D00000009"
a$(6) = "9030000000000001"
a$(7) = "1000078009000009"
a$(8) = "9150087001000001"
a$(9) = "10600000J9000009"
a$(10) = "9W91910001000001"
a$(11) = "9091919001000C09"
a$(12) = "9091919091000001"
a$(13) = "90919190910E0009"
a$(14) = "9000G00091000001"
a$(15) = "9191919191919191"

END SUB

SUB printpoints (points%)

IF points% < 0 THEN points% = 0
LOCATE 1, 60: PRINT "Points:"; points%;

END SUB

SUB printsound

LOCATE 1, 5: PRINT CHR$(14);
IF NOT SoundOn% THEN
  CIRCLE (19, 5), 5, 4
  LINE (16, 8)-(22, 2), 4
END IF

END SUB

SUB screensetup

SCREEN 8, , 0, 1
CLS
WINDOW SCREEN (1, 1)-(320, 200)
FOR X% = 1 TO 200
  LINE (1, X%)-(10, X%), (X% / 200) * 15
  LINE (310, X%)-(320, X%), (X% / 200) * 15
NEXT X%
LOCATE 1, 32
PRINT "Ray Caster v1.01"

END SUB

SUB setupvariables

px% = 15        ' Players X start position  (10 = 1 big square)
py% = 15        ' Players Y start position  (10 = 1 big square)
sa% = 0         ' Starting Angle
SoundOn% = -1   ' Sound is on

END SUB

