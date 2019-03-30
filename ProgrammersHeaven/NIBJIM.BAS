' this is my little nibbles type snake engine
' you can make some great, simple games with it if you
' use your imagination ... mazes - cutoff games - whatever
' what you have here is a game that asks you to avoid objects
' while snake keeps speeding up
' use arrow keys and escape to exit
' uploade to ABC code packet by author
' Jim Emptage 75504.2526@compuserve.com

DECLARE SUB speedref ()
DEFINT A-Z
COMMON SHARED tcnt%, speed%
SCREEN 13
DEF SEG = 0                                       ' Set NumLock to off
keyflags = PEEK(1047)
IF (keyflags AND 32) = 32 THEN
  POKE 1047, 0
END IF
DEF SEG

' traps keys while other stuff is happening!
'   0 = keyboard flag for regular keys
' 128 = keyboard flag for keys on the
'       dedicated cursor keypad
'  75 = scan code for LEFT arrow key
'
KEY 15, CHR$(128) + CHR$(75)                      ' Trap LEFT key on  numloc off
ON KEY(15) GOSUB left                             ' the dedicated
KEY(15) ON                                        ' cursor keypad.

KEY 16, CHR$(128) + CHR$(77)
ON KEY(16) GOSUB right
KEY(16) ON

KEY 17, CHR$(128) + CHR$(72)
ON KEY(17) GOSUB up
KEY(17) ON

KEY 18, CHR$(128) + CHR$(80)
ON KEY(18) GOSUB down
KEY(18) ON

KEY 19, CHR$(0) + CHR$(17)
ON KEY(19) GOSUB ww
KEY(19) ON

KEY 20, CHR$(0) + CHR$(31)
ON KEY(20) GOSUB ss
KEY(20) ON

KEY 21, CHR$(0) + CHR$(30)
ON KEY(21) GOSUB aa
KEY(21) ON

KEY 22, CHR$(0) + CHR$(32)
ON KEY(22) GOSUB dd
KEY(22) ON
TYPE man                  'store points visited by snake
  x AS INTEGER            'along with the colors of the point
  y AS INTEGER
  c AS INTEGER
END TYPE
begin:
WHILE INKEY$ <> "": WEND
CLS
scnt = 0
www = 0
p = 0
sx = 100                       'start points
sy = 100
s = 0
z = 0
slen = 250                     ' length of snake
speed% = 10                    ' higer number ... slower speed
CALL speedref
RANDOMIZE TIMER
DO
  bx = 25 + (RND * 275)
  by = 25 + (RND * 150)
  IF ABS(bx - 100) > 20 OR ABS(by - 100) > 20 THEN
    CIRCLE (bx, by), 8, 20
    PAINT (bx, by), 20, 20                'draw some circles away
                                          'from start point
    CIRCLE (bx, by), 8, 13
    PAINT (bx, by), 13, 13
    z = z + 1
  END IF
LOOP UNTIL z = 5
FOR x = 0 TO 320               ' make some background
FOR y = 0 TO 200
clr = 180 + (ABS(ABS(x - 160) - ABS(y - 100)) MOD 50)
IF POINT(x, y) = 0 THEN PSET (x, y), clr
NEXT
NEXT
LINE (5, 5)-(315, 195), 13, B

REDIM player(slen) AS man

WHILE INKEY$ <> "": WEND
v$ = ""
DO
  IF p <> 0 THEN
    IF www = 0 THEN t1& = TIMER: www = 1
    IF s < slen THEN s = s + 1
    SELECT CASE p
      CASE 1
        sx = sx - 1                   'control snake
      CASE 2
        sx = sx + 1
      CASE 3
        sy = sy - 1
      CASE 4
        sy = sy + 1
    END SELECT
    IF POINT(sx, sy) = 13 OR POINT(sx, sy) = 14 THEN  'ends game if
      GOTO overandout                                 'color 13 or 14 hit
                                                      'by snake
    END IF
    player(s).c = POINT(sx, sy)    'store color of existing point
    PSET (sx, sy), 14              'then draw head of snake
   
    IF s = slen THEN
      PSET (player(1).x, player(1).y), player(1).c   ' when snake tail
      player(slen).x = sx                               ' passes put the
      player(slen).y = sy                               ' original pixel color
                                                        ' back
      FOR m = 1 TO slen - 1
        player(m) = player(m + 1)
      NEXT
      GOTO 66
    END IF
   
     
    player(s).x = sx
    player(s).y = sy
66
    
  END IF
  FOR aa% = 1 TO tcnt%: NEXT: scnt = scnt + 1
  IF scnt = slen THEN
  scnt = 0
  IF tcnt% > 100 THEN tcnt% = tcnt% * .9
  END IF
v$ = INKEY$
44
LOOP UNTIL v$ <> ""
IF v$ = CHR$(27) THEN
END
ELSE
v$ = ""
WHILE INKEY$ <> "": WEND
GOTO 44
END IF
overandout:
t2& = TIMER
t3& = ABS(t1& - t2&)
PRINT "Game Over"
PRINT
PRINT "You Lived: "; t3&; " seconds"
WHILE INKEY$ <> "": WEND
ch$ = INPUT$(1)
GOTO begin
                   'control key sub routines
left:              'arrow keys used
IF p <> 2 THEN p = 1            ' a d w s   keys still available for second snake
RETURN             ' or whatever you want to add
right:
IF p <> 1 THEN p = 2
RETURN
up:
IF p <> 4 THEN p = 3
RETURN
down:
IF p <> 3 THEN p = 4
RETURN
aa:
RETURN
dd:
RETURN
ss:
RETURN
ww:
RETURN

SUB speedref
DEF SEG = &H40
tcnt% = 0
cnt% = 0
rtt& = -1
DO
  tcnt% = tcnt% + 1
  Lo& = PEEK(&H6C) + 256& * PEEK(&H6D)
  Hi& = PEEK(&H6E) + 256& * PEEK(&H6F)
  rt& = (65536 * Hi&) + Lo&
  IF rt& <> rtt& THEN
    cnt% = cnt% + 1
    rtt& = rt&
  END IF
LOOP UNTIL cnt% = speed%

DEF SEG

END SUB

