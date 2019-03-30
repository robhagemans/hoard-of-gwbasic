DECLARE SUB smile ()
DECLARE SUB grafix ()
DECLARE SUB title ()
DECLARE SUB oneplayer ()
DECLARE SUB multiplayer ()

SCREEN 12
DIM SHARED bon%(16, 16)
RANDOMIZE TIMER

DIM SHARED xm%(4): DIM SHARED ym%(4): DIM SHARED dirm%(4): DIM SHARED tally%(4): DIM SHARED order%(4)
smile
grafix
title

END

SUB grafix
REM bonus
FOR c = 8 TO 2 STEP -2
  CIRCLE (8, 8), c, 6 + c
NEXT c
GET (0, 0)-(16, 16), bon%
END SUB

SUB multiplayer
CLS 0
DO:  INPUT "How many players"; players%: LOOP UNTIL players% > 1 AND players% < 5: CLS
SOUND 1000, 1: PRINT players%; " PLAYER GAME - press a key to start!": WHILE INKEY$ = "": WEND: SOUND 1000, 1: CLS
DO
  CLS
  LINE (0, 0)-(600, 400), 6, B
  REM Variables, variables, variables ...
  now = TIMER
  add = 0
  FOR c% = 1 TO players%
    order%(c%) = 0
  NEXT c%
  death% = players%
  xm%(1) = 50
  ym%(1) = 50
  xm%(2) = 550
  ym%(2) = 50
  xm%(3) = 50
  ym%(3) = 350
  xm%(4) = 550
  ym%(4) = 350
  dirm%(1) = 3
  dirm%(2) = 3
  dirm%(3) = 1
  dirm%(4) = 1
 
  REM Delete all rems to add shapes
  REM FOR c = 1 TO (RND * 10)
  REM   shape% = RND * 2
  REM  posx% = (RND * 480) + 60
  REM  posy% = (RND * 280) + 60
  REM  IF shape% = 0 THEN CIRCLE (posx%, posy%), 40, 10: PAINT (posx%, posy%), 10
  REM  IF shape% = 1 THEN LINE (posx%, posy%)-(posx% + 60, posy% + 20), 10, BF: PAINT (posx% + 1, posy% + 1), 10
  REM  IF shape% = 2 THEN LINE (posx%, posy%)-(posx% + 20, posy% + 60), 10, BF: PAINT (posx% + 1, posy% + 1), 10
  REM NEXT c

  DO
    REM Wait for timer
    WHILE (now + add) > TIMER: WEND: add = add + .01
    REM Handle user input
    a$ = ""
    a$ = INKEY$
    IF a$ = "z" THEN dirm%(1) = dirm%(1) - 1
    IF a$ = "x" THEN dirm%(1) = dirm%(1) + 1
    IF a$ = "1" THEN dirm%(2) = dirm%(2) - 1
    IF a$ = "2" THEN dirm%(2) = dirm%(2) + 1
    IF a$ = "b" THEN dirm%(3) = dirm%(3) - 1
    IF a$ = "n" THEN dirm%(3) = dirm%(3) + 1
    IF a$ = "." THEN dirm%(4) = dirm%(4) - 1
    IF a$ = "/" THEN dirm%(4) = dirm%(4) + 1

    REM Do calculations & update snakes
    FOR c2% = 1 TO players%
      IF dirm%(c2%) = 0 THEN dirm%(c2%) = 4
      IF dirm%(c2%) = 5 THEN dirm%(c2%) = 1
      IF dirm%(c2%) = 1 THEN ym%(c2%) = ym%(c2%) - 1
      IF dirm%(c2%) = 2 THEN xm%(c2%) = xm%(c2%) + 1
      IF dirm%(c2%) = 3 THEN ym%(c2%) = ym%(c2%) + 1
      IF dirm%(c2%) = 4 THEN xm%(c2%) = xm%(c2%) - 1
      IF order%(c2%) = 0 THEN
        IF POINT(xm%(c2%), ym%(c2%)) <> 0 THEN
          order%(c2%) = death%
          death% = death% - 1
          SOUND 50, 1
          ELSE PSET (xm%(c2%), ym%(c2%)), c2%
        END IF
      END IF
    NEXT c2%
  LOOP UNTIL death% < 2

  REM read out the scores
  CLS
  COLOR 14
  LOCATE 1, 25: PRINT "P L A Y E R   S C O R E S"
  LOCATE 2, 25: PRINT "-------------------------"
  FOR c3% = 1 TO players%
    COLOR c3%
    IF order%(c3%) = 0 THEN score% = (players% * 1) - 1
    IF order%(c3%) = 2 THEN score% = (players% * 1) - 2
    IF order%(c3%) = 3 THEN score% = (players% * 1) - 3
    IF order%(c3%) = 4 THEN score% = 0
    tally%(c3%) = tally%(c3%) + score%
    LOCATE c3% + 5, 27: PRINT "Player "; c3%; ": "; tally%(c3%)
  NEXT c3%
  PRINT : PRINT : COLOR 6: PRINT "Another go (y/n)?"
  DO: choice$ = INKEY$: LOOP UNTIL choice$ = "y" OR choice$ = "n"
  SOUND 1000, 1
LOOP UNTIL choice$ = "n"
CLS
END SUB

SUB oneplayer
CLS 0
lives = 1
level = 0
players = 2

DO
  level = level + 1
  PRINT "level "; level; " - press a key to start!"
  WHILE INKEY$ = "": WEND: CLS
  LOCATE 28, 6: PRINT "TIME left:": LOCATE 28, 17
  LINE (0, 0)-(600, 400), 2, B
  x = 50
  y = 50
  dir = 2
  now = TIMER
  add = 0

  FOR c = 1 TO level
    shape% = RND * 2#
    posx% = (RND * 480) + 60
    posy% = (RND * 280) + 60
    IF shape% = 0 THEN CIRCLE (posx%, posy%), 40, 10: PAINT (posx%, posy%), 10
    IF shape% = 1 THEN LINE (posx%, posy%)-(posx% + 60, posy% + 20), 10, BF: PAINT (posx% + 1, posy% + 1), 10
    IF shape% = 2 THEN LINE (posx%, posy%)-(posx% + 20, posy% + 60), 10, BF: PAINT (posx% + 1, posy% + 1), 10
  NEXT c

  DO
    WHILE (now + add) > TIMER: WEND: add = add + (.01 / level)
    left% = add: LOCATE 28, 17: PRINT 30 - left%
    a$ = ""
    a$ = INKEY$
    IF a$ = "a" THEN dir = 1
    IF a$ = "z" THEN dir = 2
    IF a$ = "e" THEN dir = 3
    IF a$ = "r" THEN dir = 4
    IF dir = 1 THEN y = y - 1
    IF dir = 2 THEN y = y + 1
    IF dir = 3 THEN x = x - 1
    IF dir = 4 THEN x = x + 1
    IF POINT(x, y) <> 0 THEN
      lives = lives - 1
      SOUND 50, 1
      ELSE PSET (x, y), 3
    END IF
  LOOP UNTIL lives = 0 OR a$ = "q" OR left% = 30
  CLS
LOOP UNTIL lives = 0 OR a$ = "q"
END SUB

SUB smile
DIM smiley%(71, 71)
x% = 320
y% = 240
xs% = 1
ys% = 1
CLS
CIRCLE (35, 35), 35, 14
PAINT (35, 35), 14
CIRCLE (24, 25), 5, 0
CIRCLE (46, 25), 5, 0
PAINT (24, 25), 0
PAINT (46, 25), 0
CIRCLE (35, 40), 20, 0, 3.141592654#, 0
GET (0, 0)-(70, 70), smiley%
CLS
DO
y% = y% + ys%
x% = x% + xs%
PUT (x%, y%), smiley%, PSET
IF x% > 550 THEN xs% = xs% + 1: xs% = xs% * (-1): SOUND 500, 1
IF x% < 20 THEN xs% = xs% + 1: xs% = xs% * (-1): SOUND 500, 1
IF y% > 390 THEN ys% = ys% + 1: ys% = ys% * (-1): SOUND 500, 1
IF y% < 20 THEN ys% = ys% + 1: ys% = ys% * (-1): SOUND 500, 1
LOOP UNTIL INKEY$ <> ""
END SUB

SUB title
DO
  choice$ = ""
  CLS
  COLOR 4
  FOR c = 1 TO 10
    now = TIMER + .1
    WHILE TIMER < now: WEND
    SOUND c * 100, 1
    LINE (c + 90, 10)-(c + 10, 35): LINE (c + 10, 35)-(c + 65, 70): LINE (c + 65, 70)-(c + 35, 80): LINE (c + 35, 80)-(c + 15, 90)
    LINE (c + 110, 90)-(c + 115, 10): LINE (c + 115, 10)-(c + 185, 90): LINE (c + 185, 90)-(c + 190, 10)
    LINE (c + 210, 90)-(c + 240, 10): LINE (c + 240, 10)-(c + 290, 85): LINE (c + 220, 40)-(c + 270, 30)
    LINE (c + 310, 10)-(c + 310, 90): LINE (c + 310, 55)-(c + 390, 30): LINE (c + 310, 55)-(c + 365, 90)
    LINE (c + 490, 10)-(c + 420, 20): LINE (c + 420, 20)-(c + 410, 90): LINE (c + 410, 90)-(c + 490, 90): LINE (c + 410, 50)-(c + 440, 50)
    LINE (c + 590, 10)-(c + 510, 35): LINE (c + 510, 35)-(c + 565, 70): LINE (c + 565, 70)-(c + 535, 80): LINE (c + 535, 80)-(c + 515, 90)
  NEXT c
  LINE (180, 200)-(430, 425), 1, BF
  COLOR 2
  LOCATE 8, 37: PRINT "v1.2"
  LOCATE 9, 29: PRINT "B Y   J . B R E W E R"
  COLOR 14
  LOCATE 14, 25: PRINT "1 - one player challenge."
  LOCATE 17, 25: PRINT "2 - multiplayer player match."
  LOCATE 20, 25: PRINT "3 - see 'smiley' again."
  LOCATE 23, 25: PRINT "4 - reset scores."
  LOCATE 26, 25: PRINT "5- quit."
  DO
    choice$ = INKEY$
  LOOP UNTIL choice$ = "1" OR choice$ = "2" OR choice$ = "3" OR choice$ = "4" OR choice$ = "5"
  SOUND 1000, 1
  IF choice$ = "1" THEN oneplayer
  IF choice$ = "2" THEN multiplayer
  IF choice$ = "3" THEN smile
  IF choice$ = "4" THEN
    CLS
    COLOR 4
    PRINT "ARE YOU SURE THAT YOU WANT TO RESET ALL SCORES?"
    DO: choice$ = INKEY$: LOOP UNTIL choice$ = "y" OR choice$ = "n"
    IF choice$ = "y" THEN
      FOR c% = 1 TO 4
        tally%(c%) = 0
      NEXT c%
    END IF
    SOUND 1000, 1
  END IF
  IF choice$ = "5" THEN END
LOOP
END SUB

