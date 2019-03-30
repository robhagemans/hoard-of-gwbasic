'1997 - Copyright(c) A.L. Interactive ...yes Roey, thats - COPYRIGHT!
'al_interactive@compuserve.com
'http://ourworld.compuserve.com/homepages/al_interactive

'Requires VGA, 286 or higher processor <--Ooo First time I've had to say that!

'Mission :STARZ GAZE

'It is recommended that you read the Instructions (SGInst.TXT) first.

'Please prepare...
'Press F5 to begin...


Makespeed:
default$ = "yes"
snd$ = "OFF"
OPEN "C:\STARZG~1\SGSPD.STG" FOR INPUT AS #1
INPUT #1, speed
CLOSE #1
IF speed > 5 THEN GOTO AskQ:  ELSE GOTO work.out
AskQ:
CLS
PRINT "Your Speed Number is"; speed; "."
PRINT "Do you wish to change it? (Y/N)"
ASq2:
a$ = INKEY$
IF UCASE$(a$) = "Y" THEN GOTO work.out
IF UCASE$(a$) = "N" THEN GOTO Intro
GOTO ASq2
work.out:
TEST0:
CLS
COLOR 11
SCREEN 0, 0
WIDTH 80
LOCATE 1, 26: PRINT "A.L. Interactive Speed Maker"
LOCATE 2, 26: PRINT "----------------------------"
COLOR 12
LOCATE 3, 20: PRINT "(Based on the Mauri - Tech Speed Check)"
COLOR 7
LOCATE 6, 10: PRINT "For A.L. Interactive or Mauri - Tech Games it is compulsory"
LOCATE 7, 18: PRINT "to make sure the game's speed is acceptable."
LOCATE 9, 3: PRINT "We are asking you to help us configure the right speed for your Computer."
COLOR 10
LOCATE 17, 33: PRINT "Press any key..."
WHILE INKEY$ = "": WEND
test1:
CLS
COLOR 7
PRINT "In the box, type in a number."
PRINT "Press Return/Enter, and the screen will turn red for a certain amount of time."
PRINT "The amount of time the screen turns red is based on the size of the number."
PRINT "We want the screen to turn red for as close to one second as you can."
PRINT "It is useful to use a Stop Watch."
PRINT
COLOR 12
PRINT "NOTE: The number can be from 1000 to 900000 on fast computers."
PRINT
COLOR 11
LOCATE 10, 23: PRINT "Please enter the selected number:"
COLOR 9
LOCATE 11, 33: PRINT "ษอออออออออออป"
LOCATE 12, 33: PRINT "บ           บ"
LOCATE 13, 33: PRINT "ศอออออออออออผ"
COLOR 14
LOCATE 12, 34: INPUT "", S
COLOR , 4
CLS
FOR i = 1 TO S: NEXT i
COLOR , 0
CLS
COLOR 7
PRINT "Was the screen red for one second? (Y/N)"
wasit:
INPUT a$
IF UCASE$(a$) = "Y" THEN GOTO work.out2
IF UCASE$(a$) = "N" THEN GOTO test1
GOTO wasit
work.out2:
LET sspd = S
OPEN "c:\STARZG~1\SGSPD.STG" FOR OUTPUT AS #1
PRINT #1, sspd
CLOSE #1
FOR i = 1 TO sspd * 2: NEXT i
'GOTO NEW.GAME
Intro:
SCREEN 13
OPEN "C:\STARZG~1\SGSPD.STG" FOR INPUT AS #1
INPUT #1, speed
CLOSE #1
word = 1
LY = 60
LX = 160
LX2 = -150
LX3 = LX3 - 50
snd = 900
snd2 = 900
c = 1
New:
WHILE INKEY$ <> "": WEND
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
COLOR 12
IF word = 1 THEN LOCATE 15, 13: PRINT "The Interactive"
IF word = 2 THEN LOCATE 15, 13: PRINT "  Era is here! "
IF word = 3 THEN LOCATE 15, 13: PRINT "A.L. Interactive"
IF word = 4 THEN LOCATE 15, 13: PRINT "   Presents...  "
FOR a = 1 TO 300
IF word = 5 THEN IF a > 150 THEN GOTO explode
COLOR c
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
IF word = 5 THEN LET snd = snd + 10
IF word = 5 THEN IF snd$ = "ON" THEN SOUND snd, 1
IF word = 5 THEN LOCATE 15, 13: PRINT "  Starz Gaze"
COLOR 0
LINE (LX, LY)-(LX + LX2, LY + 70)
LINE (LX + LX2, LY + 70)-(LX + LX2, LY + 50)
LINE (LX, LY)-(LX + LX2, LY + 50)
LX2 = LX2 + 1
IF word = 5 THEN IF a > 150 THEN GOTO explode
c = INT(RND * 14) + 1
COLOR c
LINE (LX, LY)-(LX + LX2, LY + 70)
LINE (LX + LX2, LY + 70)-(LX + LX2, LY + 50)
LINE (LX, LY)-(LX + LX2, LY + 50)
IF word < 5 THEN FOR i = 1 TO speed / 240: NEXT i
IF word = 5 THEN FOR i = 1 TO 0: NEXT i

IF word = 5 THEN IF a > 150 THEN GOTO explode
NEXT a
FOR a = 1 TO 300
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
COLOR 0
snd2 = snd2 - 5
LINE (LX, LY)-(LX + LX2, LY + 70)
LINE (LX + LX2, LY + 70)-(LX + LX2, LY + 50)
LINE (LX, LY)-(LX + LX2, LY + 50)
LX2 = LX2 - 1
c = INT(RND * 14) + 1
COLOR c
LINE (LX, LY)-(LX + LX2, LY + 70)
LINE (LX + LX2, LY + 70)-(LX + LX2, LY + 50)
LINE (LX, LY)-(LX + LX2, LY + 50)
FOR i = 1 TO speed / 300: NEXT i
NEXT a
word = word + 1
GOTO New
explode:
snd = 900
FOR ex1 = 1 TO 80
IF snd$ = "ON" THEN SOUND snd, 1
snd = snd - 10
COLOR 0
LINE (LX, LY)-(LX + d, LY - d + 100)
LINE (LX, LY)-(LX + d, LY - d + 50)
LINE (LX, LY)-(LX + d, LY)
LINE (LX, LY)-(LX + d, LY + d - 50)
LINE (LX, LY)-(LX + d, LY + d - 100)
LINE (LX, LY)-(LX + c, LY - c - 100)
LINE (LX, LY)-(LX + c, LY - c - 50)
LINE (LX, LY)-(LX + c, LY)
LINE (LX, LY)-(LX + c, LY - c + 50)
LINE (LX, LY)-(LX + c, LY + c + 100)
LINE (LX, LY)-(LX - e + 120, LY - e)
LINE (LX, LY)-(LX - e + 60, LY - e)
LINE (LX, LY)-(LX, LY - e)
LINE (LX, LY)-(LX - e - 60, LY + e)
LINE (LX, LY)-(LX - e - 120, LY + e)
LINE (LX, LY)-(LX - B + 120, LY - B)
LINE (LX, LY)-(LX - B + 60, LY - B)
LINE (LX, LY)-(LX, LY - B)
LINE (LX, LY)-(LX + B - 60, LY + B)
LINE (LX, LY)-(LX + B - 120, LY + B)
B = B - 3
c = c - 3
d = d + 3
e = e + 3
COLOR 12
LINE (LX, LY)-(LX - B + 120, LY - B)
COLOR 10
LINE (LX, LY)-(LX - B + 60, LY - B)
COLOR 9
LINE (LX, LY)-(LX, LY - B)
COLOR 14
LINE (LX, LY)-(LX + B - 60, LY - B)
COLOR 10
LINE (LX, LY)-(LX + B - 120, LY - B)
COLOR 9
LINE (LX, LY)-(LX - e + 120, LY - e)
COLOR 14
LINE (LX, LY)-(LX - e + 60, LY - e)
COLOR 12
LINE (LX, LY)-(LX, LY - e)
COLOR 10
LINE (LX, LY)-(LX - e - 60, LY - e)
COLOR 14
LINE (LX, LY)-(LX - e - 120, LY - e)
COLOR 12
LINE (LX, LY)-(LX + c, LY - c - 100)
COLOR 10
LINE (LX, LY)-(LX + c, LY - c - 50)
COLOR 9
LINE (LX, LY)-(LX + c, LY)
COLOR 14
LINE (LX, LY)-(LX + c, LY - c + 50)
COLOR 10
LINE (LX, LY)-(LX + c, LY + c + 100)
COLOR 9
LINE (LX, LY)-(LX + d, LY - d - 100)
COLOR 14
LINE (LX, LY)-(LX + d, LY - d - 50)
COLOR 12
LINE (LX, LY)-(LX + d, LY)
COLOR 10
LINE (LX, LY)-(LX + d, LY - d + 50)
COLOR 14
LINE (LX, LY)-(LX + d, LY + d + 100)
FOR i = 1 TO 5: NEXT i
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
NEXT ex1
snd = 3000
DROID:
LY = 93
LX = 160
LX2 = 150
CLS
droid1:
FOR a = 1 TO 300
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
IF a = 150 THEN IF snd$ = "ON" THEN SOUND 3000, 1
IF a = 300 THEN IF snd$ = "ON" THEN SOUND 3000, 1
IF a = 1 THEN IF snd$ = "ON" THEN SOUND 3000, 1
COLOR 11
LINE (145, 80)-(175, 80)
LINE (145, 80)-(135, 90)
LINE (175, 80)-(185, 90)
LINE (135, 90)-(125, 90)
LINE (185, 90)-(195, 90)
LINE (135, 95)-(125, 95)
LINE (185, 95)-(195, 95)
LINE (195, 90)-(195, 95)
LINE (125, 90)-(125, 95)
LINE (135, 95)-(145, 105)
LINE (185, 95)-(175, 105)
LINE (175, 105)-(145, 105)
LINE (135, 90)-(150, 85)
LINE (170, 85)-(185, 90)
LINE (135, 95)-(145, 100)
LINE (185, 95)-(175, 100)

LINE (150, 85)-(170, 85)
LINE (145, 100)-(175, 100)

LINE (145, 80)-(150, 85)
LINE (175, 80)-(170, 85)

LINE (145, 105)-(145, 100)
LINE (175, 105)-(175, 100)

LINE (155, 80)-(155, 85)
LINE (165, 80)-(165, 85)
COLOR 10
CIRCLE (145, 93), 3
CIRCLE (173, 93), 3
COLOR 12
CIRCLE (160, 93), 1
COLOR 12
COLOR 0
LINE (LX, LY)-(LX + LX2, LY + 3)
LX2 = LX2 - 1
COLOR 12
LINE (LX, LY)-(LX + LX2, LY + 3)
FOR i = 1 TO speed / 300: NEXT i
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
NEXT a
FOR a = 1 TO 300
COLOR 11
LINE (145, 80)-(175, 80)
LINE (145, 80)-(135, 90)
LINE (175, 80)-(185, 90)
LINE (135, 90)-(125, 90)
LINE (185, 90)-(195, 90)
LINE (135, 95)-(125, 95)
LINE (185, 95)-(195, 95)
LINE (195, 90)-(195, 95)
LINE (125, 90)-(125, 95)
LINE (135, 95)-(145, 105)
LINE (185, 95)-(175, 105)
LINE (175, 105)-(145, 105)
LINE (135, 90)-(150, 85)
LINE (170, 85)-(185, 90)
LINE (135, 95)-(145, 100)
LINE (185, 95)-(175, 100)

LINE (150, 85)-(170, 85)
LINE (145, 100)-(175, 100)

LINE (145, 80)-(150, 85)
LINE (175, 80)-(170, 85)

LINE (145, 105)-(145, 100)
LINE (175, 105)-(175, 100)

LINE (155, 80)-(155, 85)
LINE (165, 80)-(165, 85)
COLOR 10
CIRCLE (145, 93), 3
CIRCLE (173, 93), 3
COLOR 12
CIRCLE (160, 93), 1
COLOR 12
COLOR 0
LINE (LX, LY)-(LX + LX2, LY + 3)
LX2 = LX2 + 1
COLOR 12
LINE (LX, LY)-(LX + LX2, LY + 3)
FOR i = 1 TO speed / 300: NEXT i
IF a > 150 THEN GOTO blind
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
NEXT a
blind:
FOR shine = 1 TO 50
IF snd$ = "ON" THEN SOUND 600, 1
COLOR 0
LINE (LX, LY)-(LX, LY - 20)
LINE (LX, LY)-(LX, LY + 20)
LINE (LX, LY)-(LX - 20, LY)
LINE (LX, LY)-(LX + 20, LY)
LINE (LX, LY)-(LX + 20, LY - 15)
LINE (LX, LY)-(LX - 20, LY + 15)
LINE (LX, LY)-(LX + 20, LY + 15)
LINE (LX, LY)-(LX - 20, LY - 15)
COLOR 12
LINE (LX, LY)-(LX, LY - 20)
LINE (LX, LY)-(LX, LY + 20)
LINE (LX, LY)-(LX - 20, LY)
LINE (LX, LY)-(LX + 20, LY)
LINE (LX, LY)-(LX + 20, LY - 15)
LINE (LX, LY)-(LX - 20, LY + 15)
LINE (LX, LY)-(LX + 20, LY + 15)
LINE (LX, LY)-(LX - 20, LY - 15)
COLOR 0
LINE (LX, LY)-(LX, LY - 15)
LINE (LX, LY)-(LX, LY + 15)
LINE (LX, LY)-(LX - 15, LY)
LINE (LX, LY)-(LX + 15, LY)
LINE (LX, LY)-(LX + 15, LY - 10)
LINE (LX, LY)-(LX - 15, LY + 10)
LINE (LX, LY)-(LX + 15, LY + 10)
LINE (LX, LY)-(LX - 15, LY - 10)
COLOR 4
LINE (LX, LY)-(LX, LY - 15)
LINE (LX, LY)-(LX, LY + 15)
LINE (LX, LY)-(LX - 15, LY)
LINE (LX, LY)-(LX + 15, LY)
LINE (LX, LY)-(LX + 15, LY - 10)
LINE (LX, LY)-(LX - 15, LY + 10)
LINE (LX, LY)-(LX + 15, LY + 10)
LINE (LX, LY)-(LX - 15, LY - 10)
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
NEXT shine
droid2:
LY = 93
LX = 145
y = 93
x = 173
LX2 = -50
LX1 = 50
FOR a = 1 TO 15
IF snd$ = "ON" THEN SOUND 100, 1
COLOR 11
LINE (145, 80)-(175, 80)
LINE (145, 80)-(135, 90)
LINE (175, 80)-(185, 90)
LINE (135, 90)-(125, 90)
LINE (185, 90)-(195, 90)
LINE (135, 95)-(125, 95)
LINE (185, 95)-(195, 95)
LINE (195, 90)-(195, 95)
LINE (125, 90)-(125, 95)
LINE (135, 95)-(145, 105)
LINE (185, 95)-(175, 105)
LINE (175, 105)-(145, 105)
LINE (135, 90)-(150, 85)
LINE (170, 85)-(185, 90)
LINE (135, 95)-(145, 100)
LINE (185, 95)-(175, 100)

LINE (150, 85)-(170, 85)
LINE (145, 100)-(175, 100)

LINE (145, 80)-(150, 85)
LINE (175, 80)-(170, 85)

LINE (145, 105)-(145, 100)
LINE (175, 105)-(175, 100)

LINE (155, 80)-(155, 85)
LINE (165, 80)-(165, 85)
COLOR 10
CIRCLE (145, 93), 3
CIRCLE (173, 93), 3
COLOR 12
CIRCLE (160, 93), 1
c = INT(RND * 14) + 1
COLOR c
LINE (LX, LY)-(LX + LX2, LY + 100)
LINE (x, y)-(x + LX1, y + 100)
FOR i = 1 TO speed / 10: NEXT i
COLOR 0
LINE (LX, LY)-(LX + LX2, LY + 100)
LINE (x, y)-(x + LX1, y + 100)
FOR i = 1 TO 1000: NEXT i
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
NEXT a
FOR i = 1 TO speed * 2: NEXT i
COLOR 14
LINE (195, 200)-(160, 93)
LINE (125, 200)-(160, 93)
snd = 500
FOR i = 1 TO 30: snd = snd + 10
IF snd$ = "ON" THEN SOUND snd, 1
NEXT i
snd = 1000
FOR ex1 = 1 TO 80
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
snd = INT(RND * 60) + 50
IF snd$ = "ON" THEN SOUND snd, 1
COLOR 0
LINE (160, 93)-(160 + d, 93 - d + 100)
LINE (160, 93)-(160 + d, 93 - d + 50)
LINE (160, 93)-(160 + d, 93)
LINE (160, 93)-(160 + d, 93 + d - 50)
LINE (160, 93)-(160 + d, 93 + d - 100)
LINE (160, 93)-(160 + c, 93 - c - 100)
LINE (160, 93)-(160 + c, 93 - c - 50)
LINE (160, 93)-(160 + c, 93)
LINE (160, 93)-(160 + c, 93 - c + 50)
LINE (160, 93)-(160 + c, 93 + c + 100)
LINE (160, 93)-(160 - e + 120, 93 - e)
LINE (160, 93)-(160 - e + 60, 93 - e)
LINE (160, 93)-(160, 93 - e)
LINE (160, 93)-(160 - e - 60, 93 + e)
LINE (160, 93)-(160 - e - 120, 93 + e)
LINE (160, 93)-(160 - B + 120, 93 - B)
LINE (160, 93)-(160 - B + 60, 93 - B)
LINE (160, 93)-(160, 93 - B)
LINE (160, 93)-(160 + B - 60, 93 + B)
LINE (160, 93)-(160 + B - 120, 93 + B)
B = B - 3
c = c - 3
d = d + 3
e = e + 3
COLOR 12
LINE (160, 93)-(160 - B + 120, 93 - B)
COLOR 10
LINE (160, 93)-(160 - B + 60, 93 - B)
COLOR 9
LINE (160, 93)-(160, 93 - B)
COLOR 14
LINE (160, 93)-(160 + B - 60, 93 - B)
COLOR 10
LINE (160, 93)-(160 + B - 120, 93 - B)
COLOR 9
LINE (160, 93)-(160 - e + 120, 93 - e)
COLOR 14
LINE (160, 93)-(160 - e + 60, 93 - e)
COLOR 12
LINE (160, 93)-(160, 93 - e)
COLOR 10
LINE (160, 93)-(160 - e - 60, 93 - e)
COLOR 14
LINE (160, 93)-(160 - e - 120, 93 - e)
COLOR 12
LINE (160, 93)-(160 + c, 93 - c - 100)
COLOR 10
LINE (160, 93)-(160 + c, 93 - c - 50)
COLOR 9
LINE (160, 93)-(160 + c, 93)
COLOR 14
LINE (160, 93)-(160 + c, 93 - c + 50)
COLOR 10
LINE (160, 93)-(160 + c, 93 + c + 100)
COLOR 9
LINE (160, 93)-(160 + d, 93 - d - 100)
COLOR 14
LINE (160, 93)-(160 + d, 93 - d - 50)
COLOR 12
LINE (160, 93)-(160 + d, 93)
COLOR 10
LINE (160, 93)-(160 + d, 93 - d + 50)
COLOR 14
LINE (160, 93)-(160 + d, 93 + d + 100)
FOR i = 1 TO 5: NEXT i
IF INKEY$ <> "" THEN CLS : GOTO TitleScreen
NEXT ex1
FOR dwn = 1 TO 200 STEP 3
LINE (0, dwn)-(319, dwn), 9, BF, B
FOR i = 1 TO speed \ 200: NEXT i
NEXT dwn
FOR dwn = 200 TO 1 STEP -6
LINE (0, 200)-(319, dwn), 0, BF, B
NEXT dwn
CLS
TitleScreen:
SCREEN 13
FOR c = 16 TO 31
COLOR c
S:
LINE (100, 20)-(225, 20)
LINE (100, 20)-(100, 35)
LINE (125, 30)-(125, 45)
LINE (105, 25)-(105, 30)
LINE (120, 35)-(120, 40)
LINE (100, 40)-(100, 45)

LINE (105, 25)-(125, 25)
LINE (105, 30)-(125, 30)
LINE (125, 30)-(125, 45)
LINE (100, 35)-(120, 35)
LINE (100, 40)-(120, 40)
LINE (100, 45)-(125, 45)

LINE (135, 25)-(135, 45)
LINE (140, 25)-(140, 45)

LINE (125, 25)-(135, 25)
LINE (140, 25)-(150, 25)
LINE (135, 45)-(140, 45)
a:
LINE (150, 25)-(150, 45)
LINE (155, 25)-(155, 30)
LINE (155, 35)-(155, 45)
LINE (170, 25)-(170, 30)
LINE (170, 35)-(170, 45)

LINE (155, 25)-(170, 25)
LINE (155, 30)-(170, 30)
LINE (155, 35)-(170, 35)
LINE (150, 45)-(155, 45)
LINE (170, 45)-(175, 45)
r:
LINE (180, 25)-(180, 30)
LINE (195, 25)-(195, 30)
LINE (180, 35)-(180, 45)
LINE (200, 25)-(200, 35)

LINE (180, 25)-(195, 25)
LINE (180, 30)-(195, 30)
LINE (180, 35)-(185, 35)
LINE (190, 35)-(200, 35)
LINE (175, 45)-(180, 45)
LINE (195, 45)-(200, 45)

LINE (185, 35)-(195, 45)
LINE (190, 35)-(200, 45)
Z:
LINE (225, 20)-(225, 25)
LINE (200, 40)-(200, 45)
LINE (225, 40)-(225, 45)

LINE (200, 25)-(220, 25)
LINE (200, 45)-(225, 45)
LINE (205, 40)-(225, 40)

LINE (220, 25)-(200, 40)
LINE (225, 25)-(205, 40)
COLOR 14
LOCATE 8, 15: PRINT "G   A   Z   E"
FOR i = 1 TO speed / 18: NEXT i
NEXT c
IF snd$ = "ON" THEN PLAY "<<a55 P2 a55 p2 a55 p2>>"
WHILE INKEY$ <> "": WEND
SCREEN 13
uc = 1
U = 1
SCAN:
'WHILE INKEY$ <> "": WEND
LX = 163
LY = 53
LX3 = 1
c = 9
C2 = 31
CD = 2
RESCAN:
FOR a = 1 TO 8
COLOR 0
LINE (LX, LY)-(LX + LX3, LY + LR)
CIRCLE (LX + LX3, LY + LR), 20
RANDOMIZE TIMER
LX3 = INT(RND * 720) + -360
LR = INT(RND * 200) + -111
IF c > 12 THEN LET c = 9
IF CD = 1 THEN IF C2 = 31 THEN LET CD = 2
IF CD = 2 THEN IF C2 = 16 THEN LET CD = 1
IF CD = 1 THEN C2 = C2 + 1
IF CD = 2 THEN C2 = C2 - 1

COLOR c
LINE (LX, LY)-(LX + LX3, LY + LR)
CIRCLE (LX + LX3, LY + LR), 20, c - 5
FOR i = 1 TO speed / 50: NEXT i
S2:
COLOR C2
LINE (100, 20)-(225, 20)
LINE (100, 20)-(100, 35)
LINE (125, 30)-(125, 45)
LINE (105, 25)-(105, 30)
LINE (120, 35)-(120, 40)
LINE (100, 40)-(100, 45)

LINE (105, 25)-(125, 25)
LINE (105, 30)-(125, 30)
LINE (125, 30)-(125, 45)
LINE (100, 35)-(120, 35)
LINE (100, 40)-(120, 40)
LINE (100, 45)-(125, 45)
T2:
LINE (135, 25)-(135, 45)
LINE (140, 25)-(140, 45)

LINE (125, 25)-(135, 25)
LINE (140, 25)-(150, 25)
LINE (135, 45)-(140, 45)
A2:
LINE (150, 25)-(150, 45)
LINE (155, 25)-(155, 30)
LINE (155, 35)-(155, 45)
LINE (170, 25)-(170, 30)
LINE (170, 35)-(170, 45)

LINE (155, 25)-(170, 25)
LINE (155, 30)-(170, 30)
LINE (155, 35)-(170, 35)
LINE (150, 45)-(155, 45)
LINE (170, 45)-(175, 45)
R2:
LINE (180, 25)-(180, 30)
LINE (195, 25)-(195, 30)
LINE (180, 35)-(180, 45)
LINE (200, 25)-(200, 35)

LINE (180, 25)-(195, 25)
LINE (180, 30)-(195, 30)
LINE (180, 35)-(185, 35)
LINE (190, 35)-(200, 35)
LINE (175, 45)-(180, 45)
LINE (195, 45)-(200, 45)

LINE (185, 35)-(195, 45)
LINE (190, 35)-(200, 45)
Z2:
LINE (225, 20)-(225, 25)
LINE (200, 40)-(200, 45)
LINE (225, 40)-(225, 45)

LINE (200, 25)-(220, 25)
LINE (200, 45)-(225, 45)
LINE (205, 40)-(225, 40)

LINE (220, 25)-(200, 40)
LINE (225, 25)-(205, 40)
COLOR 14
LOCATE 16, 11: PRINT "  Press any key..."
COLOR 14
LOCATE 8, 15: PRINT "G   A   Z   E"
IF INKEY$ <> "" THEN GOTO new.game
IF PW = 0 THEN GOTO SEQUENCE1
IF PW = 1 THEN GOTO SEQUENCE2
SEQUENCE1:
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 1 THEN PLAY "<<<a55>>>"
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 2 THEN PLAY "<a55>"
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 3 THEN PLAY "<<a55>>"
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 4 THEN PLAY "<a55>"
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 5 THEN PLAY "<<<a55>>>"
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 6 THEN PLAY "<a55>"
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 7 THEN PLAY "<<a55>>"
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 8 THEN PLAY "<a55>"

IF snd$ = "ON" THEN IF c = 10 THEN IF a = 1 THEN PLAY "<<c55>>"
IF snd$ = "ON" THEN IF c = 10 THEN IF a = 2 THEN PLAY "c55"
IF snd$ = "ON" THEN IF c = 10 THEN IF a = 3 THEN PLAY "<c55>"
IF snd$ = "ON" THEN IF c = 10 THEN IF a = 4 THEN PLAY "c55"
IF snd$ = "ON" THEN IF c = 10 THEN IF a = 5 THEN PLAY "<<c55>>"
IF snd$ = "ON" THEN IF c = 10 THEN IF a = 6 THEN PLAY "c55"
IF snd$ = "ON" THEN IF c = 10 THEN IF a = 7 THEN PLAY "<c55>"
IF snd$ = "ON" THEN IF c = 10 THEN IF a = 8 THEN PLAY "c55"

IF snd$ = "ON" THEN IF c = 11 THEN IF a = 1 THEN IF U = 1 THEN PLAY "<<<f55>>>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 2 THEN IF U = 1 THEN PLAY "<f55>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 3 THEN IF U = 1 THEN PLAY "<<f55>>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 4 THEN IF U = 1 THEN PLAY "<f55>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 5 THEN IF U = 1 THEN PLAY "<<<f55>>>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 6 THEN IF U = 1 THEN PLAY "<f55>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 7 THEN IF U = 1 THEN PLAY "<<<f55>>>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 8 THEN IF U = 1 THEN PLAY "<f55>"

IF snd$ = "ON" THEN IF c = 11 THEN IF a = 1 THEN IF U = 2 THEN PLAY "<<f55>>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 2 THEN IF U = 2 THEN PLAY "f55"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 3 THEN IF U = 2 THEN PLAY "<f55>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 4 THEN IF U = 2 THEN PLAY "f55"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 5 THEN IF U = 2 THEN PLAY "<<f55>>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 6 THEN IF U = 2 THEN PLAY "f55"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 7 THEN IF U = 2 THEN PLAY "<f55>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 8 THEN IF U = 2 THEN PLAY "f55"

IF snd$ = "ON" THEN IF c = 12 THEN IF a = 1 THEN IF U = 1 THEN PLAY "<<<g55>>>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 2 THEN IF U = 1 THEN PLAY "<g55>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 3 THEN IF U = 1 THEN PLAY "<<g55>>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 4 THEN IF U = 1 THEN PLAY "<g55>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 5 THEN IF U = 1 THEN PLAY "<<<g55>>>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 6 THEN IF U = 1 THEN PLAY "<g55>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 7 THEN IF U = 1 THEN PLAY "<<g55>>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 8 THEN IF U = 1 THEN PLAY "<g55>"

IF snd$ = "ON" THEN IF c = 12 THEN IF a = 1 THEN IF U = 2 THEN PLAY "<<g55>>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 2 THEN IF U = 2 THEN PLAY "g55"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 3 THEN IF U = 2 THEN PLAY "<g55>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 4 THEN IF U = 2 THEN PLAY "g55"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 5 THEN IF U = 2 THEN PLAY "<<g55>>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 6 THEN IF U = 2 THEN PLAY "g55"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 7 THEN IF U = 2 THEN PLAY "<g55>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 8 THEN IF U = 2 THEN PLAY "<<g55>>"
GOTO REP
SEQUENCE2:
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 1 THEN PLAY "<<a35>>"
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 4 THEN PLAY "<<a35>>"
IF snd$ = "ON" THEN IF c = 9 THEN IF a = 7 THEN PLAY "<<E35>>"
IF snd$ = "ON" THEN IF c = 10 THEN IF a = 1 THEN PLAY "<<F35>>"
IF snd$ = "ON" THEN IF c = 10 THEN IF a = 4 THEN PLAY "<<F35>>"
IF snd$ = "ON" THEN IF c = 10 THEN IF a = 7 THEN PLAY "<<F35>>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 1 THEN PLAY "<<D35>>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 4 THEN PLAY "<<D35>>"
IF snd$ = "ON" THEN IF c = 11 THEN IF a = 7 THEN PLAY "<<D35>>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 1 THEN PLAY "<<G35>>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 4 THEN PLAY "<<G35>>"
IF snd$ = "ON" THEN IF c = 12 THEN IF a = 7 THEN PLAY "<<G#35>>"
REP:
NEXT a
IF uc = 5 THEN LET U = 2
IF uc = 1 THEN LET U = 1
LET uc = uc + 1
IF uc > 8 THEN LET uc = 1
SEQ = SEQ + 1
IF SEQ = 16 THEN LET PW = 1
IF SEQ = 32 THEN LET PW = 0: LET SEQ = 0
c = c + 1
GOTO RESCAN
END
new.game:
OPEN "C:\STARZG~1\SGSPD.STG" FOR INPUT AS #1
INPUT #1, speed
CLOSE #1
SCREEN 13
CLS
FOR dot = 31 TO 40
COLOR 2: LOCATE 5, 1: PRINT "Establishing satellite Up-Link";
COLOR 10: LOCATE 5, dot: PRINT "."
COLOR 12: LOCATE 9, 1: PRINT "   E-Mail - Defence Systems Manager"
COLOR 12: LOCATE 11, 1: PRINT "   ============!NOTICE!============"
COLOR 15: LOCATE 16, 1: PRINT "   We are experiencing some satellite"
COLOR 15: LOCATE 17, 1: PRINT "  problems, flight console may react."
IF snd$ = "ON" THEN PLAY ">a55<"
FOR i = 1 TO speed / 23: NEXT i
NEXT dot
Swoop:
SCREEN 13
COLOR 10
LX1 = 319
LY1 = 199
lx11 = LX1
LY11 = LY1
LX2 = 319
LY2 = 1
LX22 = LX2
LY22 = LY2
LX3 = 0
LY3 = 1
lx33 = LX3
LY33 = LY3
LX4 = 0
LY4 = 199
LX44 = LX4
LY44 = LY4

LX5 = 160
LY5 = 0
lx55 = LX5
LY55 = LY5
LX6 = 160
LY6 = 0
LX66 = LX6
LY66 = LY6
LX7 = 160
LY7 = 199
lx77 = LX7
LY77 = LY7
LX8 = 160
LY8 = 199
LX88 = LX8
LY88 = LY8

FOR i = 1 TO 200
LET LY11 = LY11 - 1
LET LY22 = LY22 + 1
LET LY33 = LY33 + 1
LET LY44 = LY44 - 1
LET lx55 = lx55 + 1
LET LX66 = LX66 - 1
LET lx77 = lx77 + 1
LET LX88 = LX88 - 1

LINE (LX1, LY1)-(lx11, LY11), 10
LINE (LX2, LY2)-(LX22, LY22), 10
LINE (LX3, LY3)-(lx33, LY33), 10
LINE (LX4, LY4)-(LX44, LY44), 10
LINE (LX5, LY5)-(lx55, LY55), 10
LINE (LX6, LY6)-(LX66, LY66), 10
LINE (LX7, LY7)-(lx77, LY77), 10
LINE (LX8, LY8)-(LX88, LY88), 10

FOR t = 1 TO speed / 200: NEXT t
NEXT i
x1 = 2
y1 = 2
x2 = 318
y2 = 2
IF snd$ = "ON" THEN PLAY "<<b55>>"
FOR i = 1 TO 315
LINE (x1, y1)-(x1, y1 + 195), 0
LINE (x2, y2)-(x2, y2 + 195), 0
x1 = x1 + 1
x2 = x2 - 1
LINE (x1, y1)-(x1, y1 + 195), 2
LINE (x2, y2)-(x2, y2 + 195), 2
FOR t = 1 TO speed / 600: NEXT t
IF snd$ = "ON" THEN IF x1 = x2 THEN PLAY "<<b55>>"
NEXT i
IF snd$ = "ON" THEN PLAY "<<b55>>"
LINE (x1, y1)-(x1, y1 + 195), 0
LINE (x2, y2)-(x2, y2 + 195), 0
scrn:
IF snd$ = "ON" THEN PLAY "c4a50"
scrn2:
COLOR 10
LOCATE 2, 15: PRINT "Ship Computer"
LOCATE 4, 12: PRINT "Mission: Starz Gaze"
COLOR 2
LOCATE 9, 5: PRINT "(1) Weapons"
LOCATE 9, 27: PRINT "(2) Ship"
LOCATE 14, 5: PRINT "(3) Ship make"
LOCATE 14, 27: PRINT "(4) Begin"
COLOR 10
LOCATE 21, 10: PRINT "A.L. Interactive Systems"
FOR i = 1 TO 7000
a$ = INKEY$
sel = 0
IF a$ = "1" THEN GOTO newscrn: LET sel = 1
IF a$ = "2" THEN GOTO newscrn: LET sel = 2
IF a$ = "3" THEN GOTO newscrn: LET sel = 3
IF a$ = "4" THEN GOTO newscrn: LET sel = 4
NEXT i
fuzz:
RANDOMIZE TIMER
w = INT(RND * 7) + 1
x1 = 2
IF w = 1 THEN y1 = 40: vhold$ = "on"
IF w = 2 THEN y1 = 70: vhold$ = "on"
IF w = 3 THEN y1 = 125: vhold$ = "on"
IF w = 4 THEN y1 = 165: vhold$ = "on"
IF w = 5 THEN y1 = 150: vhold$ = "on"
IF w = 6 THEN y1 = 2: vhold$ = "on"
IF w = 7 THEN GOTO vhold1
GOTO con
vhold1:
LOCATE 23, 1
FOR i = 1 TO 10
PRINT
NEXT i
CLS
COLOR 10
LINE (2, 1)-(319, 1)
LINE (1, 199)-(319, 199)
LINE (1, 1)-(1, 199)
LINE (319, 1)-(319, 199)

vhold$ = "off"

con:
FOR i = 1 TO 190
RANDOMIZE TIMER
LINE (x1, y1)-(x1 + 314, y1), 0
IF w = 6 THEN y1 = y1 + 2
IF w = 6 THEN GOTO fuz2
RANDOMIZE TIMER
ww = INT(RND * 2) + 1
IF ww = 1 THEN LET y1 = y1 + 1
IF ww = 2 THEN LET y1 = y1 - 1
fuz2:
LINE (x1, y1)-(x1 + 314, y1), 2
FOR t = 1 TO speed / 600: NEXT t
NEXT i
LINE (x1, y1)-(x1 + 314, y1), 0
IF vhold$ = "off" THEN CLS
IF vhold$ = "off" THEN COLOR 10
IF vhold$ = "off" THEN LINE (2, 1)-(319, 1)
IF vhold$ = "off" THEN LINE (1, 199)-(319, 199)
IF vhold$ = "off" THEN LINE (1, 1)-(1, 199)
IF vhold$ = "off" THEN LINE (319, 1)-(319, 199)
GOTO scrn2
newscrn:
x1 = 2
y1 = 2
x2 = 318
y2 = 2
IF snd$ = "ON" THEN PLAY "<<b55>>"
FOR i = 1 TO 315
LINE (x1, y1)-(x1, y1 + 195), 0
LINE (x2, y2)-(x2, y2 + 195), 0
x1 = x1 + 1
x2 = x2 - 1
IF snd$ = "ON" THEN IF x1 = x2 THEN PLAY "<<b55>>"
LINE (x1, y1)-(x1, y1 + 195), 2
LINE (x2, y2)-(x2, y2 + 195), 2
FOR t = 1 TO speed / 600: NEXT t
NEXT i
LINE (x1, y1)-(x1, y1 + 195), 0
LINE (x2, y2)-(x2, y2 + 195), 0
IF snd$ = "ON" THEN PLAY "<<b55>>"
IF a$ = "1" THEN GOTO weapons
IF a$ = "2" THEN GOTO ship
IF a$ = "3" THEN GOTO shipmake
IF a$ = "4" THEN GOTO Redogame
IF a$ = "5" THEN GOTO scrn

weapons:
IF snd$ = "ON" THEN PLAY "c4a50"
weapons2:
COLOR 10
LOCATE 2, 15: PRINT "Ship Computer"
LOCATE 4, 12: PRINT "Mission: Starz Gaze"
LOCATE 6, 11: PRINT "Weapons: Laser Cannon"
COLOR 2
LOCATE 7, 2: PRINT "LWT (Laser Weapon Technology) was"
LOCATE 8, 2: PRINT "first developed in 2010, since then it"
LOCATE 9, 2: PRINT "has become more lethal."
LOCATE 10, 2: PRINT "It can be more powerful than a nuclear"
LOCATE 11, 2: PRINT "weapon, and it is so acurate"
LOCATE 12, 2: PRINT "it can pop a balloon from 10,000 human"
LOCATE 13, 2: PRINT "miles."
LOCATE 15, 2: PRINT "Laser #: LA97621"
LOCATE 16, 2: PRINT "Class: Restricted"
LOCATE 17, 2: PRINT "Origin: Un-known "
LOCATE 18, 2: PRINT "Licenced: No - Restricted Weapon"
LOCATE 19, 2: PRINT "Last Tested: 10/12/40, - Urgent Test."
COLOR 10
LOCATE 21, 10: PRINT "A.L. Interactive Systems"
FOR i = 1 TO 10000
IF INKEY$ <> "" THEN LET a$ = "5": GOTO newscrn
NEXT i
fuzz2:
RANDOMIZE TIMER
w = INT(RND * 7) + 1
x1 = 2
IF w = 1 THEN y1 = 40: vhold$ = "on"
IF w = 2 THEN y1 = 70: vhold$ = "on"
IF w = 3 THEN y1 = 125: vhold$ = "on"
IF w = 4 THEN y1 = 165: vhold$ = "on"
IF w = 5 THEN y1 = 150: vhold$ = "on"
IF w = 6 THEN y1 = 2: vhold$ = "on"
IF w = 7 THEN GOTO vhold2
GOTO con2
vhold2:
LOCATE 23, 1
FOR i = 1 TO 10
PRINT
NEXT i
CLS
COLOR 10
LINE (2, 1)-(319, 1)
LINE (1, 199)-(319, 199)
LINE (1, 1)-(1, 199)
LINE (319, 1)-(319, 199)
vhold$ = "off"
con2:
FOR i = 1 TO 190
RANDOMIZE TIMER
LINE (x1, y1)-(x1 + 314, y1), 0
IF w = 6 THEN y1 = y1 + 2
IF w = 6 THEN GOTO fuz3
RANDOMIZE TIMER
ww = INT(RND * 2) + 1
IF ww = 1 THEN LET y1 = y1 + 1
IF ww = 2 THEN LET y1 = y1 - 1
fuz3:
LINE (x1, y1)-(x1 + 314, y1), 2
FOR t = 1 TO speed / 600: NEXT t
NEXT i
LINE (x1, y1)-(x1 + 314, y1), 0
IF vhold$ = "off" THEN CLS
IF vhold$ = "off" THEN COLOR 10
IF vhold$ = "off" THEN LINE (2, 1)-(319, 1)
IF vhold$ = "off" THEN LINE (1, 199)-(319, 199)
IF vhold$ = "off" THEN LINE (1, 1)-(1, 199)
IF vhold$ = "off" THEN LINE (319, 1)-(319, 199)

GOTO weapons2
ship:
FOR dot = 32 TO 36
COLOR 2: LOCATE 10, 2: PRINT "Disconecting from host Up-Link";
COLOR 10: LOCATE 10, dot: PRINT "."
FOR i = 1 TO speed / 3: NEXT i
IF snd$ = "ON" THEN PLAY ">a55<"
NEXT dot
LOCATE 10, 2: PRINT "                                      "

FOR dot = 31 TO 35
COLOR 2: LOCATE 10, 2: PRINT "Switching to internal console";
COLOR 10: LOCATE 10, dot: PRINT "."
FOR i = 1 TO speed / 3: NEXT i
IF snd$ = "ON" THEN PLAY ">a55<"
NEXT dot
LOCATE 10, 2: PRINT "                                      "
rerun:
ad$ = "no"
IF snd$ = "ON" THEN PLAY "c4a50"
COLOR 10
LOCATE 2, 15: PRINT "Ship Computer"
LOCATE 4, 12: PRINT "Mission: Starz Gaze"
LOCATE 6, 15: PRINT "Ships Control"
COLOR 2
LOCATE 7, 11: PRINT "Enter the controls you"
LOCATE 8, 11: PRINT "wish the ship to have."
LOCATE 9, 14: PRINT "Press Q to quit."
LOCATE 10, 12: PRINT "Press * for default."
LOCATE 11, 12: PRINT "F1 = Sound On or Off"

right:
r$ = INKEY$
LOCATE 13, 2: PRINT "Right : ";
IF r$ <> "" THEN GOTO left
GOTO right
left:
IF r$ = "*" THEN LET default$ = "yes": GOTO showselection2:  ELSE LET default$ = "no"
IF r$ = CHR$(0) + ";" THEN CLS : LOCATE 10, 15: IF snd$ = "ON" THEN COLOR 12: PRINT "Sound Off.": LET snd$ = "OFF": SLEEP 2: GOTO ReConect:  ELSE IF snd$ = "OFF" THEN COLOR 10: LOCATE 10, 16: PRINT "Sound On": LET snd$ = "ON": SLEEP 2: GOTO ReConect
IF UCASE$(r$) = "Q" THEN LET default$ = "yes": GOTO showselection2
l$ = INKEY$
LOCATE 14, 2: PRINT "Left  : ";
IF l$ <> "" THEN GOTO fire
GOTO left
fire:
IF l$ = "*" THEN LET default$ = "yes": GOTO showselection2:  ELSE LET default$ = "no"
IF l$ = CHR$(0) + ";" THEN CLS : LOCATE 10, 15: IF snd$ = "ON" THEN COLOR 12: PRINT "Sound Off.": LET snd$ = "OFF": SLEEP 2: GOTO ReConect:  ELSE IF snd$ = "OFF" THEN COLOR 10: LOCATE 10, 16: PRINT "Sound On": LET snd$ = "ON": SLEEP 2: GOTO ReConect
IF UCASE$(l$) = "Q" THEN LET default$ = "yes": GOTO showselection2
f$ = INKEY$
LOCATE 15, 2: PRINT "Fire  : ";
IF f$ <> "" THEN GOTO showselection
GOTO fire
IF f$ = "*" THEN LET default$ = "yes":  GOTO showselection2:  ELSE LET default$ = "no"
IF f$ = CHR$(0) + ";" THEN CLS : LOCATE 10, 15: IF snd$ = "ON" THEN COLOR 12: PRINT "Sound Off.": LET snd$ = "OFF": SLEEP 2: GOTO ReConect:  ELSE IF snd$ = "OFF" THEN COLOR 10: LOCATE 10, 16: PRINT "Sound On": LET snd$ = "ON": SLEEP 2: GOTO ReConect
IF UCASE$(f$) = "Q" THEN LET default$ = "yes": GOTO showselection2
IF default$ = "yes" THEN LET r$ = "Right Arrow"
IF default$ = "yes" THEN LET l$ = "Left Arrow"
IF default$ = "yes" THEN LET f$ = "Space"
showselection:
wr$ = r$
wl$ = l$
wf$ = f$
IF wr$ = " " THEN LET wr$ = "Space"
IF wr$ = CHR$(0) + "K" THEN LET wr$ = "Access Denied - Select new.": LET ad$ = "yes"
IF wr$ = CHR$(0) + "M" THEN LET wr$ = "Access Denied - Select new.": LET ad$ = "yes"
IF wr$ = CHR$(0) + "H" THEN LET wr$ = "Access Denied - Select new.": LET ad$ = "yes"
IF wr$ = CHR$(0) + "P" THEN LET wr$ = "Access Denied - Select new.": LET ad$ = "yes"

IF wl$ = " " THEN LET wl$ = "Space"
IF wl$ = CHR$(0) + "K" THEN LET wl$ = "Access Denied - Select new.": LET ad$ = "yes"
IF wl$ = CHR$(0) + "M" THEN LET wl$ = "Access Denied - Select new.": LET ad$ = "yes"
IF wl$ = CHR$(0) + "H" THEN LET wl$ = "Access Denied - Select new.": LET ad$ = "yes"
IF wl$ = CHR$(0) + "P" THEN LET wl$ = "Access Denied - Select new.": LET ad$ = "yes"

IF wf$ = " " THEN LET wf$ = "Space"
IF wf$ = CHR$(0) + "K" THEN LET wf$ = "Access Denied - Select new.": LET ad$ = "yes"
IF wf$ = CHR$(0) + "M" THEN LET wf$ = "Access Denied - Select new.": LET ad$ = "yes"
IF wf$ = CHR$(0) + "H" THEN LET wf$ = "Access Denied - Select new.": LET ad$ = "yes"
IF wf$ = CHR$(0) + "P" THEN LET wf$ = "Access Denied - Select new.": LET ad$ = "yes"
showselection2:
IF default$ = "yes" THEN LET wr$ = "Right Arrow"
IF default$ = "yes" THEN LET wl$ = "Left Arrow"
IF default$ = "yes" THEN LET wf$ = "Space"
LOCATE 17, 2: PRINT "Right = "; wr$
LOCATE 18, 2: PRINT "left  = "; wl$
LOCATE 19, 2: PRINT "Fire  = "; wf$
IF ad$ = "yes" THEN SLEEP 1: GOTO rerun2
GOTO norerun
rerun2:
x1 = 2
y1 = 2
x2 = 318
y2 = 2
IF snd$ = "ON" THEN PLAY "<<b55>>"
FOR i = 1 TO 315
LINE (x1, y1)-(x1, y1 + 195), 0
LINE (x2, y2)-(x2, y2 + 195), 0
x1 = x1 + 1
x2 = x2 - 1
IF snd$ = "ON" THEN IF x1 = x2 THEN PLAY "<<b55>>"
LINE (x1, y1)-(x1, y1 + 195), 2
LINE (x2, y2)-(x2, y2 + 195), 2
FOR t = 1 TO speed / 600: NEXT t
NEXT i
IF snd$ = "ON" THEN PLAY "<<b55>>"
LINE (x1, y1)-(x1, y1 + 195), 0
LINE (x2, y2)-(x2, y2 + 195), 0
GOTO rerun
norerun:
LOCATE 20, 15: PRINT "OK?  <Y/N>";
COLOR 10
LOCATE 22, 10: PRINT "A.L. Interactive Systems"
LOCATE 20, 25: INPUT "", ask$
IF UCASE$(ask$) = "Y" THEN LET a$ = "5": GOTO ReConect
IF UCASE$(ask$) = "N" THEN GOTO rerun2
ReConect:
x1 = 2
y1 = 2
x2 = 318
y2 = 2
IF snd$ = "ON" THEN PLAY "<<b55>>"
FOR i = 1 TO 315
LINE (x1, y1)-(x1, y1 + 195), 0
LINE (x2, y2)-(x2, y2 + 195), 0
IF snd$ = "ON" THEN IF x1 = x2 THEN PLAY "<<b55>>"

x1 = x1 + 1
x2 = x2 - 1
LINE (x1, y1)-(x1, y1 + 195), 2
LINE (x2, y2)-(x2, y2 + 195), 2
FOR t = 1 TO speed / 600: NEXT t
NEXT i
IF snd$ = "ON" THEN PLAY "<<b55>>"
LINE (x1, y1)-(x1, y1 + 195), 0
LINE (x2, y2)-(x2, y2 + 195), 0
FOR dot = 32 TO 39
COLOR 2: LOCATE 10, 2: PRINT "Establishing satellite Up-Link";
COLOR 10: LOCATE 10, dot: PRINT "."
FOR i = 1 TO speed / 3: NEXT i
IF snd$ = "ON" THEN PLAY ">a55<"
NEXT dot
LOCATE 10, 2: PRINT "                                      "
COLOR 10
LINE (2, 1)-(319, 1)
LINE (1, 199)-(319, 199)
LINE (1, 1)-(1, 199)
LINE (319, 1)-(319, 199)

a$ = "5"
GOTO newscrn
shipmake:
FOR dot = 34 TO 39
COLOR 2: LOCATE 10, 2: PRINT "Downloading Relevant Information"
COLOR 10: LOCATE 10, dot: PRINT "."
FOR i = 1 TO speed / 2: NEXT i
IF snd$ = "ON" THEN PLAY ">a55<"
NEXT dot
LOCATE 10, 2: PRINT "                                      "
shipmake2:
IF snd$ = "ON" THEN PLAY "c4a50"
shipmake3:
COLOR 10
LOCATE 2, 15: PRINT "Ship Computer"
LOCATE 4, 12: PRINT "Mission: Starz Gaze"
LOCATE 6, 11: PRINT "Ship - Star Skater"
COLOR 2
LOCATE 8, 2: PRINT "Registration: SS-2322"
LOCATE 9, 2: PRINT "Last tested: 14/12/40"
LOCATE 10, 2: PRINT "Date to be re-tested: 14/12/90"
LOCATE 11, 2: PRINT "Laser Cannon: 1"
LOCATE 13, 2: PRINT "Extra Notes: Of-course with all shoot"
LOCATE 14, 2: PRINT "'em up games-You have the worst ship!"
COLOR 10
LOCATE 21, 10: PRINT "A.L. Interactive Systems"
FOR i = 1 TO 10000
IF INKEY$ <> "" THEN LET a$ = "5": GOTO newscrn
NEXT i
fuzz3:
RANDOMIZE TIMER
w = INT(RND * 7) + 1
x1 = 2
IF w = 1 THEN y1 = 40: vhold$ = "on"
IF w = 2 THEN y1 = 70: vhold$ = "on"
IF w = 3 THEN y1 = 125: vhold$ = "on"
IF w = 4 THEN y1 = 165: vhold$ = "on"
IF w = 5 THEN y1 = 150: vhold$ = "on"
IF w = 6 THEN y1 = 2: vhold$ = "on"
IF w = 7 THEN GOTO vhold3
GOTO con3
vhold3:
LOCATE 23, 1
FOR i = 1 TO 10
PRINT
NEXT i
CLS
COLOR 10
LINE (2, 1)-(319, 1)
LINE (1, 199)-(319, 199)
LINE (1, 1)-(1, 199)
LINE (319, 1)-(319, 199)
vhold$ = "off"
con3:
FOR i = 1 TO 190
RANDOMIZE TIMER
LINE (x1, y1)-(x1 + 314, y1), 0
IF w = 6 THEN y1 = y1 + 2
IF w = 6 THEN GOTO fuz4
RANDOMIZE TIMER
ww = INT(RND * 2) + 1
IF ww = 1 THEN LET y1 = y1 + 1
IF ww = 2 THEN LET y1 = y1 - 1
fuz4:
LINE (x1, y1)-(x1 + 314, y1), 2
FOR t = 1 TO speed / 600: NEXT t
NEXT i
LINE (x1, y1)-(x1 + 314, y1), 0
IF vhold$ = "off" THEN CLS
IF vhold$ = "off" THEN COLOR 10
IF vhold$ = "off" THEN LINE (2, 1)-(319, 1)
IF vhold$ = "off" THEN LINE (1, 199)-(319, 199)
IF vhold$ = "off" THEN LINE (1, 1)-(1, 199)
IF vhold$ = "off" THEN LINE (319, 1)-(319, 199)
GOTO shipmake3





END
Redogame:
IF default$ = "yes" THEN LET r$ = "M"
IF default$ = "yes" THEN LET l$ = "K"
IF default$ = "yes" THEN LET f$ = " "
POINTS = 0
secs = 1
Level = 0
POINTS = 10000
Norm$ = "Yes"
top0:
SCREEN 13
CLS
d2 = 1
B = -1
c = -1
d = -1
e = -1
m1 = 2
lives = 2
ilives = 9
endl = 1
d4 = 2
blw = 1
d = 1
di2 = 2
x = 150
y = 100
x1 = 63
y1 = 163
x2 = 77
y2 = 163
x3 = 91
y3 = 163
x4 = 105
y4 = 163
hsc = 33
yy = 7
bx = x
by = y - 1
a1x = 12
a1y = 20
alx = a1x
h1x = a1x + 5
h1y = a1y
h2x = a1x + 5
h2y = a1y
h3x = a1x + 5
h3y = a1y
h4x = a1x + 5
h4y = a1y
h5x = a1x + 5
h5y = a1y
dd = 1
aly = a1y + 3
alx2 = a1x + 10
aly2 = a1y + 3
fcol = 1
fcol1 = 1
acol1 = 9
acol2 = 12
fire = 1
px1 = 0
py1 = 0
px2 = 0
py2 = 0
px4 = 0
py4 = 0
ff = 1
i = 1000
top1:
COLOR 11
LINE (1, 1)-(319, 1)
LINE (1, 150)-(319, 150)
LINE (1, 1)-(1, 150)
LINE (319, 1)-(319, 150)
COLOR 12
LINE (1, 155)-(319, 155)
LINE (1, 199)-(319, 199)
LINE (1, 155)-(1, 199)
LINE (319, 155)-(319, 199)
LINE (90, 155)-(90, 199)
COLOR 9
LOCATE 21, 2: PRINT "Lives:"
COLOR 12
LOCATE 23, 2: PRINT "Lives:"
COLOR 11
LOCATE 21, 15: COLOR 11: PRINT "Section": LOCATE 21, 23: COLOR 15: PRINT "\": LOCATE 21, 25: COLOR 14: PRINT "Level:"
COLOR 10
LOCATE 22, 15: PRINT "Points:"
OPEN "c:\STARZG~1\SGHIGH.STG" FOR INPUT AS #1
INPUT #1, hsname$
INPUT #1, HSCORE
CLOSE #1
COLOR 54
LOCATE 23, 14: PRINT HSCORE; "- "; hsname$

WHILE INKEY$ <> "": WEND
FOR a = 16 TO 31
COLOR a
LOCATE 10, 13: PRINT "Press any key..."
IF INKEY$ <> "" THEN GOTO pressed
FOR i = 1 TO 500: NEXT i
NEXT a
WHILE INKEY$ = "": WEND
pressed:
LOCATE 10, 13: PRINT "                "
FOR a = 31 TO 16 STEP -1
COLOR a
PSET (x, y): PSET (x - 1, y + 1): PSET (x + 1, y + 1): PSET (x - 2, y + 2): PSET (x + 2, y + 2): PSET (x - 3, y + 3): PSET (x + 3, y + 3): PSET (x - 2, y + 3): PSET (x - 1, y + 3): PSET (x, y + 3): PSET (x + 1, y + 3): PSET (x + 2, y + 3)
PSET (x - 2, y + 4): PSET (x + 2, y + 4)
PSET (x - 5, y + 3): PSET (x - 4, y + 3): PSET (x + 5, y + 3): PSET (x + 4, y + 3)
PSET (x - 4, y + 2): PSET (x + 4, y + 2): PSET (x, y - 1)
PSET (a1x + 4, a1y): PSET (a1x + 5, a1y): PSET (a1x + 6, a1y)
PSET (a1x + 5, a1y + 2)
PSET (a1x + 5, a1y + 1): PSET (a1x, a1y + 4): PSET (a1x + 5, a1y + 4): PSET (a1x + 10, a1y + 4):
PSET (a1x + 5, a1y + 1): PSET (a1x, a1y + 4): PSET (a1x + 5, a1y + 4): PSET (a1x + 10, a1y + 4):
PSET (a1x, a1y + 3): PSET (a1x + 1, a1y + 3): PSET (a1x + 2, a1y + 3): PSET (a1x + 3, a1y + 3): PSET (a1x + 4, a1y + 3): PSET (a1x + 5, a1y + 3)
PSET (a1x + 6, a1y + 3): PSET (a1x + 7, a1y + 3): PSET (a1x + 8, a1y + 3): PSET (a1x + 9, a1y + 3): PSET (a1x + 10, a1y + 3)
PSET (a1x, a1y + 2): PSET (a1x + 10, a1y + 2)
PSET (a1x + 5, a1y + 5)
PSET (a1x + 3, a1y - 1): PSET (a1x + 7, a1y - 1):
FOR i = 1 TO speed / 36: NEXT i
NEXT a
top2:
COLOR 11
LINE (1, 1)-(319, 1)
RANDOMIZE TIMER
IF secs <= 1 THEN PRESET (px1, py1)
IF secs <= 1 THEN PRESET (px1 - 1, py1)
IF secs <= 1 THEN PRESET (px1 + 1, py1)
IF secs <= 1 THEN PRESET (px1, py1 - 1)
IF secs <= 1 THEN PRESET (px1, py1 + 1)
px1 = INT(RND * 314) + 4
py1 = INT(RND * 145) + 4
COLOR 7
PSET (px1, py1)
COLOR 8
PSET (px1 - 1, py1)
COLOR 8
PSET (px1 + 1, py1)
COLOR 8
PSET (px1, py1 - 1)
COLOR 8
PSET (px1, py1 + 1)
no:
IF secs <= 2 THEN PRESET (px2, py2)
IF secs <= 2 THEN PRESET (px2 + 1, py2)
IF secs <= 2 THEN PRESET (px2 - 1, py2)
IF secs <= 2 THEN PRESET (px2, py2 + 1)
IF secs <= 2 THEN PRESET (px2, py2 - 1)
px2 = INT(RND * 314) + 4
py2 = INT(RND * 145) + 4
COLOR 12
PSET (px2, py2)
COLOR 4
PSET (px2 + 1, py2)
COLOR 4
PSET (px2 - 1, py2)
COLOR 4
PSET (px2, py2 + 1)
COLOR 4
PSET (px2, py2 - 1)
IF secs <= 3 THEN PRESET (px3, py3)
IF secs <= 3 THEN PRESET (px3 + 1, py3)
IF secs <= 3 THEN PRESET (px3 - 1, py3)
IF secs <= 3 THEN PRESET (px3, py3 + 1)
IF secs <= 3 THEN PRESET (px3, py3 - 1)
px3 = INT(RND * 314) + 4
py3 = INT(RND * 145) + 4
COLOR 10
PSET (px3, py3)
COLOR 2
PSET (px3 + 1, py3)
COLOR 2
PSET (px3 - 1, py3)
COLOR 2
PSET (px3, py3 + 1)
COLOR 2
PSET (px3, py3 - 1)
carryon2:
IF h3y > 100 THEN LET blw = 1: LET d2 = 1: PRESET (h1x, h1y): PRESET (h2x, h2y): PRESET (h3x, h3y): PRESET (h4x, h4y): PRESET (h5x, h5y): GOTO res
GOTO here5
res:
h1x = a1x + 5
h1y = a1y
h2x = a1x + 5
h2y = a1y
h3x = a1x + 5
h3y = a1y
h4x = a1x + 5
h4y = a1y
h5x = a1x + 5
h5y = a1y
here5:
IF blw = 1 THEN GOTO your.spacecraft
hit:
IF d2 = 2 THEN GOTO hyow
h1x = a1x + 5
h1y = a1y
h2x = a1x + 5
h2y = a1y
h3x = a1x + 5
h3y = a1y
h4x = a1x + 5
h4y = a1y
h5x = a1x + 5
h5y = a1y

hyow:
PRESET (h1x, h1y)
PRESET (h2x, h2y)
PRESET (h3x, h3y)
PRESET (h4x, h4y)
PRESET (h5x, h5y)
IF d = 1 THEN LET h1x = h1x - 13
IF d = 1 THEN LET h2x = h2x - 9
IF d = 1 THEN LET h3x = h3x
IF d = 1 THEN LET h4x = h4x + 9
IF d = 1 THEN LET h5x = h5x + 13
IF d = 1 THEN LET h1y = h1y + 11
IF d = 1 THEN LET h2y = h2y + 13
IF d = 1 THEN LET h3y = h3y + 11
IF d = 1 THEN LET h4y = h4y + 13
IF d = 1 THEN LET h5y = h5y + 11
IF d = 2 THEN LET h1x = h1x - 13
IF d = 2 THEN LET h2x = h2x - 9
IF d = 2 THEN LET h3x = h3x
IF d = 2 THEN LET h4x = h4x + 9
IF d = 2 THEN LET h5x = h5x + 12
IF d = 2 THEN LET h1y = h1y + 11
IF d = 2 THEN LET h2y = h2y + 13
IF d = 2 THEN LET h3y = h3y + 11
IF d = 2 THEN LET h4y = h4y + 13
IF d = 2 THEN LET h5y = h5y + 11
here4:
IF blw = 2 THEN d2 = 2
COLOR 15
PSET (h1x, h1y)
COLOR 7
PSET (h2x, h2y)
COLOR 15
PSET (h3x, h3y)
COLOR 7
PSET (h4x, h4y)
COLOR 12
PSET (h5x, h5y)
RANDOMIZE TIMER
your.spacecraft:
COLOR 9
PSET (x, y): PSET (x - 1, y + 1): PSET (x + 1, y + 1): PSET (x - 2, y + 2): PSET (x + 2, y + 2): PSET (x - 3, y + 3): PSET (x + 3, y + 3): PSET (x - 2, y + 3): PSET (x - 1, y + 3): PSET (x, y + 3): PSET (x + 1, y + 3): PSET (x + 2, y + 3)
PSET (x - 2, y + 4): PSET (x + 2, y + 4)
PSET (x - 5, y + 3): PSET (x - 4, y + 3): PSET (x + 5, y + 3): PSET (x + 4, y + 3)
PSET (x - 4, y + 2): PSET (x + 4, y + 2): PSET (x, y - 1)
alien.spacecraft:
COLOR 12
PSET (a1x + 4, a1y): PSET (a1x + 5, a1y): PSET (a1x + 6, a1y)
PSET (a1x + 5, a1y + 2)
PSET (a1x + 5, a1y + 1): PSET (a1x, a1y + 4): PSET (a1x + 5, a1y + 4): PSET (a1x + 10, a1y + 4):
PSET (a1x + 5, a1y + 1): PSET (a1x, a1y + 4): PSET (a1x + 5, a1y + 4): PSET (a1x + 10, a1y + 4):
PSET (a1x, a1y + 3): PSET (a1x + 1, a1y + 3): PSET (a1x + 2, a1y + 3): PSET (a1x + 3, a1y + 3): PSET (a1x + 4, a1y + 3): PSET (a1x + 5, a1y + 3)
PSET (a1x + 6, a1y + 3): PSET (a1x + 7, a1y + 3): PSET (a1x + 8, a1y + 3): PSET (a1x + 9, a1y + 3): PSET (a1x + 10, a1y + 3)
PSET (a1x, a1y + 2): PSET (a1x + 10, a1y + 2)
PSET (a1x + 5, a1y + 5)
PSET (a1x + 3, a1y - 1): PSET (a1x + 7, a1y - 1):
IF by < 14 THEN PRESET (bx, by): PRESET (bx, by + 1): PRESET (bx, by + 2):   PRESET (bx, by + 3): PRESET (bx, by + 5): PRESET (bx, by + 8): LET fire = 1
IF fire = 1 THEN GOTO speeds3
crap:
PRESET (bx, by)
PRESET (bx, by + 1)
PRESET (bx, by + 2)
PRESET (bx, by + 3)
PRESET (bx, by + 5)
PRESET (bx, by + 8)
LET by = by - 14
here:
COLOR 15
PSET (bx, by)
COLOR 14
PSET (bx, by + 1)
COLOR 14
PSET (bx, by + 2)
COLOR 6
PSET (bx, by + 3)
COLOR 6
PSET (bx, by + 5)
COLOR 6
PSET (bx, by + 8)
GOTO speeds2
speeds3:
LET by = y - 1
LET bx = x
speeds2:
MOVE:
keypress$ = INKEY$

IF ff = 2 THEN IF ilives < 0 THEN LET endl = 2: LET who = 2
IF ff = 2 THEN IF lives < 0 THEN LET endl = 2: LET who = 1
IF ff = 1 THEN IF ilives < 0 THEN LET endl = 2: LET who = 2
IF ff = 1 THEN IF lives < 0 THEN LET endl = 2: LET who = 1

IF alx > x - 11 THEN IF alx < x + 11 THEN IF aly > y - 2 THEN IF aly < y + 5 THEN LET lives = lives - 1: IF snd$ = "ON" THEN SOUND 700, 1: SOUND 600, 1
IF alx2 > x - 11 THEN IF alx2 < x + 11 THEN IF aly2 > y - 2 THEN IF aly2 < y + 5 THEN LET lives = lives - 1:  IF snd$ = "ON" THEN SOUND 700, 1: SOUND 600, 1
IF h1x > x - 11 THEN IF h1x < x + 11 THEN IF h1y > y - 2 THEN IF h1y < y + 5 THEN LET lives = lives - 1:  IF snd$ = "ON" THEN SOUND 700, 1: SOUND 600, 1
IF h2x > x - 11 THEN IF h2x < x + 11 THEN IF h2y > y - 2 THEN IF h2y < y + 5 THEN LET lives = lives - 1:  IF snd$ = "ON" THEN SOUND 700, 1: SOUND 600, 1
IF h3x > x - 11 THEN IF h3x < x + 11 THEN IF h3y > y - 2 THEN IF h3y < y + 5 THEN LET lives = lives - 1:  IF snd$ = "ON" THEN SOUND 700, 1: SOUND 600, 1
IF h4x > x - 11 THEN IF h4x < x + 11 THEN IF h4y > y - 2 THEN IF h4y < y + 5 THEN LET lives = lives - 1:  IF snd$ = "ON" THEN SOUND 700, 1: SOUND 600, 1
IF h5x > x - 11 THEN IF h5x < x + 11 THEN IF h5y > y - 2 THEN IF h5y < y + 5 THEN LET lives = lives - 1:  IF snd$ = "ON" THEN SOUND 700, 1: SOUND 600, 1

IF bx >= a1x - 2 THEN IF bx <= a1x + 12 THEN IF by >= a1y - 4 THEN IF by <= a1y + 9 THEN LET blw = 2: ilives = ilives - 1: LET POINTS = POINTS + 10000: IF snd$ = "ON" THEN SOUND 200, 1: SOUND 100, 1



COLOR 11
LOCATE 21, 32: COLOR 11: PRINT secs: LOCATE 21, 35: COLOR 15: PRINT "\": LOCATE 21, 36: COLOR 14: PRINT Level + 1
IF POINTS > HSCORE THEN LET Norm$ = "no"
IF Norm$ = "Yes" THEN COLOR 10
IF Norm$ = "Yes" THEN LOCATE 22, 23: PRINT POINTS
IF Norm$ = "no" THEN COLOR hsc
IF Norm$ = "no" THEN LOCATE 22, 23: PRINT POINTS
IF Norm$ = "no" THEN hsc = hsc + 1
IF hsc > 61 THEN LET hsc = 33
COLOR 9
LOCATE 21, 9: PRINT lives
COLOR 12
LOCATE 23, 9: PRINT ilives

IF default$ = "yes" THEN IF keypress$ = " " THEN fire = 2:   IF snd$ = "ON" THEN SOUND 1000, 1:  IF snd$ = "ON" THEN SOUND 990, 1: fire = 2
IF lives > 0 THEN IF default$ = "yes" THEN IF keypress$ = CHR$(0) + "K" THEN LET m1 = 2: GOTO dir1
IF lives > 0 THEN IF default$ = "yes" THEN IF keypress$ = CHR$(0) + "M" THEN LET m2 = 2: GOTO dir2
IF lives = 0 THEN IF default$ = "yes" THEN IF keypress$ = CHR$(0) + "M" THEN LET m1 = 2: GOTO dir1
IF lives = 0 THEN IF default$ = "yes" THEN IF keypress$ = CHR$(0) + "K" THEN LET m2 = 2: GOTO dir2
IF default$ = "no" THEN IF keypress$ = f$ THEN fire = 2:  IF snd$ = "ON" THEN SOUND 1000, 1:  IF snd$ = "ON" THEN SOUND 990, 1: fire = 2
IF lives > 0 THEN IF default$ = "no" THEN IF keypress$ = l$ THEN LET m1 = 2: GOTO dir1
IF lives > 0 THEN IF default$ = "no" THEN IF keypress$ = r$ THEN LET m2 = 2: GOTO dir2
IF lives = 0 THEN IF default$ = "no" THEN IF keypress$ = r$ THEN LET m1 = 2: GOTO dir1
IF lives = 0 THEN IF default$ = "no" THEN IF keypress$ = l$ THEN LET m2 = 2: GOTO dir2
IF UCASE$(keypress$) = "Q" THEN CLS : GOTO Swoop
IF keypress$ = CHR$(0) + ";" THEN IF snd$ = "OFF" THEN LET snd$ = "ON"
IF keypress$ = CHR$(0) + ";" THEN IF snd$ = "ON" THEN LET snd$ = "OFF"

RANDOMIZE TIMER
fuzz = INT(RND * 40) + 1
IF fuzz = 5 THEN GOTO fuzz5
GOTO nofuzz
fuzz5:
xx2 = 2
RANDOMIZE TIMER
wp = INT(RND * 3) + 1
IF wp = 1 THEN LET yy2 = 30
IF wp = 2 THEN LET yy2 = 50
IF wp = 3 THEN LET yy2 = 70
FOR i = 1 TO 50
RANDOMIZE TIMER
LINE (xx2, yy2)-(xx2 + 314, yy2), 0
RANDOMIZE TIMER
ww = INT(RND * 2) + 1
IF ww = 1 THEN LET yy2 = yy2 + 1
IF ww = 2 THEN LET yy2 = yy2 - 1
LINE (xx2, yy2)-(xx2 + 314, yy2), 2
FOR t = 1 TO speed / 600: NEXT t
NEXT i
LINE (xx2, yy2)-(xx2 + 314, yy2), 0
nofuzz:
IF m1 = 2 THEN GOTO dir1
IF m2 = 2 THEN GOTO dir2
GOTO top2

dir1:
COLOR 9
PRESET (x, y): PRESET (x - 1, y + 1): PRESET (x + 1, y + 1): PRESET (x - 2, y + 2): PRESET (x + 2, y + 2): PRESET (x - 3, y + 3): PRESET (x + 3, y + 3): PRESET (x - 2, y + 3): PRESET (x - 1, y + 3): PRESET (x, y + 3): PRESET (x + 1, y + 3): PRESET (x + 2, y + 3)
PRESET (x - 2, y + 4): PRESET (x + 2, y + 4):
PRESET (x - 5, y + 3): PRESET (x - 4, y + 3): PRESET (x + 5, y + 3): PRESET (x + 4, y + 3)
PRESET (x - 4, y + 2): PRESET (x + 4, y + 2): PRESET (x, y - 1)
LET x = x - 6
PSET (x, y): PSET (x - 1, y + 1): PSET (x + 1, y + 1): PSET (x - 2, y + 2): PSET (x + 2, y + 2): PSET (x - 3, y + 3): PSET (x + 3, y + 3): PSET (x - 2, y + 3): PSET (x - 1, y + 3): PSET (x, y + 3): PSET (x + 1, y + 3): PSET (x + 2, y + 3)
PSET (x - 2, y + 4): PSET (x + 2, y + 4)
PSET (x - 5, y + 3): PSET (x - 4, y + 3): PSET (x + 5, y + 3): PSET (x + 4, y + 3)
PSET (x - 4, y + 2): PSET (x + 4, y + 2): PSET (x, y - 1)
LET m2 = 1
GOTO speeds
dir2:
COLOR 9
PRESET (x, y): PRESET (x - 1, y + 1): PRESET (x + 1, y + 1): PRESET (x - 2, y + 2): PRESET (x + 2, y + 2): PRESET (x - 3, y + 3): PRESET (x + 3, y + 3): PRESET (x - 2, y + 3): PRESET (x - 1, y + 3): PRESET (x, y + 3): PRESET (x + 1, y + 3): PRESET (x + 2, y + 3)
PRESET (x - 2, y + 4): PRESET (x + 2, y + 4):
PRESET (x - 5, y + 3): PRESET (x - 4, y + 3): PRESET (x + 5, y + 3): PRESET (x + 4, y + 3)
PRESET (x - 4, y + 2): PRESET (x + 4, y + 2): PRESET (x, y - 1)
LET x = x + 6
PSET (x, y): PSET (x - 1, y + 1): PSET (x + 1, y + 1): PSET (x - 2, y + 2): PSET (x + 2, y + 2): PSET (x - 3, y + 3): PSET (x + 3, y + 3): PSET (x - 2, y + 3): PSET (x - 1, y + 3): PSET (x, y + 3): PSET (x + 1, y + 3): PSET (x + 2, y + 3)
PSET (x - 2, y + 4): PSET (x + 2, y + 4)
PSET (x - 5, y + 3): PSET (x - 4, y + 3): PSET (x + 5, y + 3): PSET (x + 4, y + 3)
PSET (x - 4, y + 2): PSET (x + 4, y + 2): PSET (x, y - 1)
LET m1 = 1
GOTO speeds
speeds:
IF x < 7 THEN GOTO del
IF x > 293 THEN GOTO del
IF y < 3 THEN GOTO del
IF y > 194 THEN GOTO del
GOTO jump
del:
PRESET (x, y): PRESET (x - 1, y + 1): PRESET (x + 1, y + 1): PRESET (x - 2, y + 2): PRESET (x + 2, y + 2): PRESET (x - 3, y + 3): PRESET (x + 3, y + 3): PRESET (x - 2, y + 3): PRESET (x - 1, y + 3): PRESET (x, y + 3): PRESET (x + 1, y + 3): PRESET (x + 2, y + 3)
PRESET (x - 2, y + 4): PRESET (x + 2, y + 4):
PRESET (x - 5, y + 3): PRESET (x - 4, y + 3): PRESET (x + 5, y + 3): PRESET (x + 4, y + 3)
PRESET (x - 4, y + 2): PRESET (x + 4, y + 2): PRESET (x, y - 1)
jump:
IF x < 7 THEN LET x = 293
IF x > 293 THEN LET x = 11
RANDOMIZE TIMER
IF DONE = 1 THEN GOTO miss
LET alzr = INT(RND * 1) + 1
IF alzr = 1 THEN LET DONE = 1
IF alzr = 1 THEN IF snd$ = "ON" THEN SOUND 600, 1:  IF snd$ = "ON" THEN SOUND 590, 1
miss:
PRESET (alx, aly): PRESET (alx - 1, aly - 1): PRESET (alx - 2, aly - 2): PRESET (alx2, aly2): PRESET (alx2 - 1, aly2 - 1): PRESET (alx2 - 2, aly2 - 2)
PRESET (alx, aly): PRESET (alx + 1, aly - 1): PRESET (alx + 2, aly - 2): PRESET (alx2, aly2): PRESET (alx2 + 1, aly2 - 1): PRESET (alx2 + 2, aly2 - 2)
PRESET (a1x + 4, a1y): PRESET (a1x + 5, a1y): PRESET (a1x + 6, a1y)
PRESET (a1x + 5, a1y + 2)
PRESET (a1x + 5, a1y + 1): PRESET (a1x, a1y + 4): PRESET (a1x + 5, a1y + 4): PRESET (a1x + 10, a1y + 4):
PRESET (a1x + 5, a1y + 1): PRESET (a1x, a1y + 4): PRESET (a1x + 5, a1y + 4): PRESET (a1x + 10, a1y + 4):
PRESET (a1x, a1y + 3): PRESET (a1x + 1, a1y + 3): PRESET (a1x + 2, a1y + 3): PRESET (a1x + 3, a1y + 3): PRESET (a1x + 4, a1y + 3): PRESET (a1x + 5, a1y + 3)
PRESET (a1x + 6, a1y + 3): PRESET (a1x + 7, a1y + 3): PRESET (a1x + 8, a1y + 3): PRESET (a1x + 9, a1y + 3): PRESET (a1x + 10, a1y + 3)
PRESET (a1x, a1y + 2): PRESET (a1x + 10, a1y + 2)
PRESET (a1x + 5, a1y + 5)
PRESET (a1x + 3, a1y - 1): PRESET (a1x + 7, a1y - 1):

IF d = 1 THEN IF aly2 > 130 THEN PRESET (alx, aly): PRESET (alx - 1, aly - 1): PRESET (alx - 2, aly - 2): PRESET (alx2, aly2): PRESET (alx2 - 1, aly2 - 1): PRESET (alx2 - 2, aly2 - 2): LET alzr = 3
IF d = 2 THEN IF aly2 > 130 THEN PRESET (alx, aly): PRESET (alx + 1, aly - 1): PRESET (alx + 2, aly - 2): PRESET (alx2, aly2): PRESET (alx2 + 1, aly2 - 1): PRESET (alx2 + 2, aly2 - 2): LET alzr = 3

IF a1x < 11 THEN LET d = 1: a1y = a1y + 5: POINTS = POINTS - 1000
IF a1x > 293 THEN LET d = 2: a1y = a1y + 5: POINTS = POINTS - 1000
IF a1y > 150 THEN GOTO hedies

IF Level = 0 THEN IF d = 1 THEN LET a1x = a1x + 2: LET POINTS = POINTS - 50
IF Level = 0 THEN IF d = 2 THEN LET a1x = a1x - 2: LET POINTS = POINTS - 50

IF Level = 1 THEN IF d = 1 THEN LET a1x = a1x + 3: LET POINTS = POINTS - 50
IF Level = 1 THEN IF d = 2 THEN LET a1x = a1x - 3: LET POINTS = POINTS - 50

IF Level = 2 THEN IF d = 1 THEN LET a1x = a1x + 4: LET POINTS = POINTS - 50
IF Level = 2 THEN IF d = 2 THEN LET a1x = a1x - 4: LET POINTS = POINTS - 50

IF Level = 3 THEN IF d = 1 THEN LET a1x = a1x + 5: LET POINTS = POINTS - 50
IF Level = 3 THEN IF d = 2 THEN LET a1x = a1x - 5: LET POINTS = POINTS - 50

IF Level = 4 THEN IF d = 1 THEN LET a1x = a1x + 6: LET POINTS = POINTS - 50
IF Level = 4 THEN IF d = 2 THEN LET a1x = a1x - 6: LET POINTS = POINTS - 50

IF Level = 5 THEN IF d = 1 THEN LET a1x = a1x + 7: LET POINTS = POINTS - 50
IF Level = 5 THEN IF d = 2 THEN LET a1x = a1x - 7: LET POINTS = POINTS - 50

IF Level = 6 THEN IF d = 1 THEN LET a1x = a1x + 8: LET POINTS = POINTS - 50
IF Level = 6 THEN IF d = 2 THEN LET a1x = a1x - 8: LET POINTS = POINTS - 50

IF Level = 7 THEN IF d = 1 THEN LET a1x = a1x + 9: LET POINTS = POINTS - 50
IF Level = 7 THEN IF d = 2 THEN LET a1x = a1x - 9: LET POINTS = POINTS - 50

IF Level = 8 THEN IF d = 1 THEN LET a1x = a1x + 10: LET POINTS = POINTS - 50
IF Level = 8 THEN IF d = 2 THEN LET a1x = a1x - 10: LET POINTS = POINTS - 50

IF Level = 9 THEN IF d = 1 THEN LET a1x = a1x + 11: LET POINTS = POINTS - 50
IF Level = 9 THEN IF d = 2 THEN LET a1x = a1x - 11: LET POINTS = POINTS - 50

IF Level = 10 THEN IF d = 1 THEN LET a1x = a1x + 12: LET POINTS = POINTS - 50
IF Level = 10 THEN IF d = 2 THEN LET a1x = a1x - 12: LET POINTS = POINTS - 50

IF ilives = 0 THEN LET a1y = a1y + 3: LET ff = 2

COLOR 12
PSET (a1x + 4, a1y): PSET (a1x + 5, a1y): PSET (a1x + 6, a1y)
PSET (a1x + 5, a1y + 2)
PSET (a1x + 5, a1y + 1): PSET (a1x, a1y + 4): PSET (a1x + 5, a1y + 4): PSET (a1x + 10, a1y + 4):
PSET (a1x + 5, a1y + 1): PSET (a1x, a1y + 4): PSET (a1x + 5, a1y + 4): PSET (a1x + 10, a1y + 4):
PSET (a1x, a1y + 3): PSET (a1x + 1, a1y + 3): PSET (a1x + 2, a1y + 3): PSET (a1x + 3, a1y + 3): PSET (a1x + 4, a1y + 3): PSET (a1x + 5, a1y + 3)
PSET (a1x + 6, a1y + 3): PSET (a1x + 7, a1y + 3): PSET (a1x + 8, a1y + 3): PSET (a1x + 9, a1y + 3): PSET (a1x + 10, a1y + 3)
PSET (a1x, a1y + 2): PSET (a1x + 10, a1y + 2)
PSET (a1x + 5, a1y + 5)
PSET (a1x + 3, a1y - 1): PSET (a1x + 7, a1y - 1):
IF ff = 2 THEN GOTO Cut
IF d = 1 THEN IF aly2 > 130 THEN PRESET (alx, aly): PRESET (alx - 1, aly - 1): PRESET (alx - 2, aly - 2): PRESET (alx2, aly2): PRESET (alx2 - 1, aly2 - 1): PRESET (alx2 - 2, aly2 - 2): LET alzr = 3
IF d = 2 THEN IF aly2 > 130 THEN PRESET (alx, aly): PRESET (alx + 1, aly - 1): PRESET (alx + 2, aly - 2): PRESET (alx2, aly2): PRESET (alx2 + 1, aly2 - 1): PRESET (alx2 + 2, aly2 - 2): LET alzr = 3

IF d = 1 THEN IF alx > 311 THEN GOTO del2
IF d = 2 THEN IF alx < 6 THEN GOTO del2
IF d = 1 THEN IF alx2 > 311 THEN GOTO del2
IF d = 2 THEN IF alx2 < 6 THEN GOTO del2

IF alzr >= 2 THEN GOTO speeds5
IF alzr >= 2 THEN GOTO speeds5
PRESET (alx, aly)
IF d = 1 THEN PRESET (alx - 1, aly - 1)
IF d = 1 THEN PRESET (alx - 2, aly - 2)
IF d = 2 THEN PRESET (alx + 1, aly - 1)
IF d = 2 THEN PRESET (alx + 2, aly - 2)
PRESET (alx2, aly2)
IF d = 1 THEN PRESET (alx2 - 1, aly2 - 1)
IF d = 1 THEN PRESET (alx2 - 2, aly2 - 2)
IF d = 2 THEN PRESET (alx2 + 1, aly2 - 1)
IF d = 2 THEN PRESET (alx2 + 2, aly2 - 2)

LET aly = aly + 5
IF d = 1 THEN LET alx = alx + 4
IF d = 2 THEN LET alx = alx - 6
LET aly2 = aly2 + 5
IF d = 1 THEN LET alx2 = alx2 + 6
IF d = 2 THEN LET alx2 = alx2 - 4
COLOR 15
PSET (alx, aly)

COLOR 10
IF d = 1 THEN PSET (alx - 1, aly - 1)
IF d = 2 THEN PSET (alx + 1, aly - 1)
COLOR 2
IF d = 1 THEN PSET (alx - 2, aly - 2)
IF d = 2 THEN PSET (alx + 2, aly - 2)
COLOR 15
PSET (alx2, aly2)
COLOR 10
IF d = 1 THEN PSET (alx2 - 1, aly2 - 1)
IF d = 2 THEN PSET (alx2 + 1, aly2 - 1)
COLOR 2
IF d = 1 THEN PSET (alx2 - 2, aly2 - 2)
IF d = 2 THEN PSET (alx2 + 2, aly2 - 2)
GOTO speeds6
del2:
PRESET (alx, aly)
IF d = 1 THEN PRESET (alx - 1, aly - 1)
IF d = 1 THEN PRESET (alx - 2, aly - 2)
IF d = 2 THEN PRESET (alx + 1, aly - 1)
IF d = 2 THEN PRESET (alx + 2, aly - 2)
PRESET (alx2, aly2)
IF d = 1 THEN PRESET (alx2 - 1, aly2 - 1)
IF d = 1 THEN PRESET (alx2 - 2, aly2 - 2)
IF d = 2 THEN PRESET (alx2 + 1, aly2 - 1)
IF d = 2 THEN PRESET (alx2 + 2, aly2 - 2)
speeds5:
PRESET (alx, aly): PRESET (alx - 1, aly - 1): PRESET (alx - 2, aly - 2): PRESET (alx2, aly2): PRESET (alx2 - 1, aly2 - 1): PRESET (alx2 - 2, aly2 - 2): LET alzr = 3
PRESET (alx, aly): PRESET (alx + 1, aly - 1): PRESET (alx + 2, aly - 2): PRESET (alx2, aly2): PRESET (alx2 + 1, aly2 - 1): PRESET (alx2 + 2, aly2 - 2): LET alzr = 3
LET aly = a1y + 3
LET alx = a1x
LET aly2 = a1y + 3
LET alx2 = a1x + 10
Cut:
LET DONE = 0
IF DONE = 1 THEN GOTO mis1
speeds6:
IF DONE = 1 THEN GOTO mis1
mis1:
FOR i = 1 TO speed / 78: NEXT i
IF endl = 2 THEN IF who = 1 THEN GOTO youdie
IF endl = 2 THEN IF who = 2 THEN GOTO hedies
GOTO mis2
youdie:
ca1 = 19
cb1 = 19
cc1 = 19
FOR ex1 = 1 TO 80
IF ca1 > 60 THEN LET ca1 = 19: cb1 = 19: cc1 = 19:
COLOR 0
LINE (x, y)-(x + d, y - d + 100)
LINE (x, y)-(x + d, y - d + 50)
LINE (x, y)-(x + d, y)
LINE (x, y)-(x + d, y + d - 50)
LINE (x, y)-(x + d, y + d - 100)

LINE (x, y)-(x + c, y - c - 100)
LINE (x, y)-(x + c, y - c - 50)
LINE (x, y)-(x + c, y)
LINE (x, y)-(x + c, y - c + 50)
LINE (x, y)-(x + c, y + c + 100)

LINE (x, y)-(x - e + 120, y - e)
LINE (x, y)-(x - e + 60, y - e)
LINE (x, y)-(x, y - e)
LINE (x, y)-(x - e - 60, y + e)
LINE (x, y)-(x - e - 120, y + e)

LINE (x, y)-(x - B + 120, y - B)
LINE (x, y)-(x - B + 60, y - B)
LINE (x, y)-(x, y - B)
LINE (x, y)-(x + B - 60, y + B)
LINE (x, y)-(x + B - 120, y + B)
CIRCLE (x, y), d + 15
B = B - 3
c = c - 3
d = d + 3
e = e + 3

'RANDOMIZE TIMER
'ca1 = INT(RND * 20) + 61
'RANDOMIZE TIMER
'cb1 = INT(RND * 20) + 61
'RANDOMIZE TIMER
'cc1 = INT(RND * 20) + 61
ca1 = ca1 + 1
cb1 = cb1 + 1
cc1 = cc1 + 1

COLOR ca1
LINE (x, y)-(x - B + 120, y - B)
COLOR cb1
LINE (x, y)-(x - B + 60, y - B)
COLOR cc1
LINE (x, y)-(x, y - B)
COLOR cb1
LINE (x, y)-(x + B - 60, y - B)
COLOR ca1
LINE (x, y)-(x + B - 120, y - B)

COLOR cc1
LINE (x, y)-(x - e + 120, y - e)
COLOR ca1
LINE (x, y)-(x - e + 60, y - e)
COLOR cb1
LINE (x, y)-(x, y - e)
COLOR ca1
LINE (x, y)-(x - e - 60, y - e)
COLOR cb1
LINE (x, y)-(x - e - 120, y - e)

COLOR cb1
LINE (x, y)-(x + c, y - c - 100)
COLOR cc1
LINE (x, y)-(x + c, y - c - 50)
COLOR ca1
LINE (x, y)-(x + c, y)
COLOR cc1
LINE (x, y)-(x + c, y - c + 50)
COLOR cb1
LINE (x, y)-(x + c, y + c + 100)

COLOR ca1
LINE (x, y)-(x + d, y - d - 100)
COLOR cb1
LINE (x, y)-(x + d, y - d - 50)
COLOR cc1
LINE (x, y)-(x + d, y)
COLOR cb1
LINE (x, y)-(x + d, y - d + 50)
COLOR ca1
LINE (x, y)-(x + d, y + d + 100)
FOR i = 1 TO speed / 100: NEXT i
CIRCLE (x, y), d + 15
NEXT ex1
GOTO dead
hedies:
'IF dd = 2 THEN GOTO youdie
FOR ex1 = 1 TO 80
COLOR 0
LINE (a1x, a1y)-(a1x + d, a1y - d + 100)
LINE (a1x, a1y)-(a1x + d, a1y - d + 50)
LINE (a1x, a1y)-(a1x + d, a1y)
LINE (a1x, a1y)-(a1x + d, a1y + d - 50)
LINE (a1x, a1y)-(a1x + d, a1y + d - 100)
LINE (a1x, a1y)-(a1x + c, a1y - c - 100)
LINE (a1x, a1y)-(a1x + c, a1y - c - 50)
LINE (a1x, a1y)-(a1x + c, a1y)
LINE (a1x, a1y)-(a1x + c, a1y - c + 50)
LINE (a1x, a1y)-(a1x + c, a1y + c + 100)
LINE (a1x, a1y)-(a1x - e + 120, a1y - e)
LINE (a1x, a1y)-(a1x - e + 60, a1y - e)
LINE (a1x, a1y)-(a1x, a1y - e)
LINE (a1x, a1y)-(a1x - e - 60, a1y + e)
LINE (a1x, a1y)-(a1x - e - 120, a1y + e)
LINE (a1x, a1y)-(a1x - B + 120, a1y - B)
LINE (a1x, a1y)-(a1x - B + 60, a1y - B)
LINE (a1x, a1y)-(a1x, a1y - B)
LINE (a1x, a1y)-(a1x + B - 60, a1y + B)
LINE (a1x, a1y)-(a1x + B - 120, a1y + B)
B = B - 3
c = c - 3
d = d + 3
e = e + 3
RANDOMIZE TIMER
ca1 = INT(RND * 31) + 18
RANDOMIZE TIMER
cb1 = INT(RND * 31) + 18
RANDOMIZE TIMER
cc1 = INT(RND * 31) + 18
COLOR ca1
LINE (a1x, a1y)-(a1x - B + 120, a1y - B)
COLOR cb1
LINE (a1x, a1y)-(a1x - B + 60, a1y - B)
COLOR cc1
LINE (a1x, a1y)-(a1x, a1y - B)
COLOR cb1
LINE (a1x, a1y)-(a1x + B - 60, a1y - B)
COLOR ca1
LINE (a1x, a1y)-(a1x + B - 120, a1y - B)

COLOR cc1
LINE (a1x, a1y)-(a1x - e + 120, a1y - e)
COLOR ca1
LINE (a1x, a1y)-(a1x - e + 60, a1y - e)
COLOR cb1
LINE (a1x, a1y)-(a1x, a1y - e)
COLOR ca1
LINE (a1x, a1y)-(a1x - e - 60, a1y - e)
COLOR cc1
LINE (a1x, a1y)-(a1x - e - 120, a1y - e)

COLOR cb1
LINE (a1x, a1y)-(a1x + c, a1y - c - 100)
COLOR cc1
LINE (a1x, a1y)-(a1x + c, a1y - c - 50)
COLOR ca1
LINE (a1x, a1y)-(a1x + c, a1y)
COLOR cc1
LINE (a1x, a1y)-(a1x + c, a1y - c + 50)
COLOR cb1
LINE (a1x, a1y)-(a1x + c, a1y + c + 100)
COLOR ca1
LINE (a1x, a1y)-(a1x + d, a1y - d - 100)
COLOR cb1
LINE (a1x, a1y)-(a1x + d, a1y - d - 50)
COLOR cc1
LINE (a1x, a1y)-(a1x + d, a1y)
COLOR cb1
LINE (a1x, a1y)-(a1x + d, a1y - d + 50)
COLOR ca1
LINE (a1x, a1y)-(a1x + d, a1y + d + 100)
FOR i = 1 TO speed / 100: NEXT i
CIRCLE (a1x, a1y), d
NEXT ex1
shut2:
FOR dwn = 1 TO 200 STEP 3
LINE (0, dwn)-(319, dwn), 9, BF, B
FOR i = 1 TO speed / 150: NEXT i
NEXT dwn
FOR dwn = 200 TO 1 STEP -6
LINE (0, 200)-(319, dwn), 0, BF, B
NEXT dwn
LET secs = secs + 1
IF secs = 5 THEN LET Level = Level + 1
IF secs > 0 THEN IF secs < 5 THEN GOTO cutout
IF Level = 1 THEN LET POINTS = POINTS * 2: GOTO lvlcompl
IF Level = 2 THEN LET POINTS = POINTS * 2: GOTO lvlcompl
IF Level = 3 THEN LET POINTS = POINTS * 2: GOTO lvlcompl
IF Level = 4 THEN LET POINTS = POINTS * 2: GOTO lvlcompl
IF Level = 5 THEN LET POINTS = POINTS * 2: GOTO lvlcompl
IF Level = 6 THEN LET POINTS = POINTS * 2: GOTO lvlcompl
IF Level = 7 THEN LET POINTS = POINTS * 2: GOTO lvlcompl
IF Level = 8 THEN LET POINTS = POINTS * 2: GOTO lvlcompl
IF Level = 9 THEN LET POINTS = POINTS * 2: GOTO lvlcompl
IF Level = 10 THEN LET POINTS = POINTS * 2: GOTO lvlcompl
cutout:
IF secs = 1 THEN LET POINTS = POINTS + 8000
IF secs = 2 THEN LET POINTS = POINTS + 16000
IF secs = 3 THEN LET POINTS = POINTS + 32000
IF secs = 4 THEN LET POINTS = POINTS + 64000
GOTO top0
mis2:
GOTO top2
dead:
FOR a = 16 TO 31
COLOR a
LOCATE 11, 17: PRINT "Game Over"
FOR i = 1 TO speed / 36: NEXT i
NEXT a
FOR a = 31 TO 16 STEP -1
COLOR a
LOCATE 11, 17: PRINT "Game Over"
FOR i = 1 TO speed / 36: NEXT i
NEXT a
shut:
FOR dwn = 1 TO 200 STEP 3
LINE (0, dwn)-(319, dwn), 9, BF, B
FOR i = 1 TO speed / 150: NEXT i
NEXT dwn
FOR dwn = 200 TO 1 STEP -6
LINE (0, 200)-(319, dwn), 0, BF, B
NEXT dwn
CLS
GOTO Highscore.Check
lvlcompl:
CLS
bonusgame:
colors = 0
able = 0
mental:
WHILE INKEY$ <> "": WEND
FOR radius = 1 TO 100
IF able = 1 THEN IF INKEY$ <> "" THEN GOTO bonusgame1
RANDOMIZE TIMER
x = INT(RND * 360) + 1
y = INT(RND * 200) + 1
COLOR colors
CIRCLE (x, y), radius
colors = colors + 1
IF colors > 14 THEN LET colors = 0
NEXT radius
times = times + 1
IF times > 10 THEN GOTO tunnel
GOTO mental
tunnel:
'CLS
colors = 16
FOR radius = 1 TO 200
IF able = 1 THEN IF INKEY$ <> "" THEN GOTO bonusgame1
COLOR colors
CIRCLE (160, 100), radius
colors = colors + 1
IF colors > 31 THEN LET colors = 16
FOR i = 1 TO speed / 400: NEXT i
NEXT radius
writing:
how = 1
colors = 16
FOR colors = 16 TO 31
IF able = 1 THEN IF INKEY$ <> "" THEN GOTO bonusgame1
COLOR colors
LOCATE 13, 14: PRINT "Level Complete"
NEXT colors
FOR colors = 31 TO 16 STEP -1
IF able = 1 THEN IF INKEY$ <> "" THEN GOTO bonusgame1
COLOR colors
LOCATE 13, 14: PRINT "Level Complete"
NEXT colors
colors = 16
FOR colors = 16 TO 31
IF able = 1 THEN IF INKEY$ <> "" THEN GOTO bonusgame1
COLOR colors
LOCATE 13, 14: PRINT "Level Complete"
NEXT colors
FOR colors = 31 TO 16 STEP -1
IF able = 1 THEN IF INKEY$ <> "" THEN GOTO bonusgame1
COLOR colors
LOCATE 13, 14: PRINT "Level Complete"
NEXT colors
FOR radius = 200 TO 1 STEP -1
IF able = 1 THEN IF INKEY$ <> "" THEN GOTO bonusgame1
COLOR 0
CIRCLE (160, 100), radius
colors = colors + 1
FOR i = 1 TO speed / 360: NEXT i
NEXT radius
colors = 0
times = 0
able = 1
GOTO mental
bonusgame1:
LET secs = 1
ilives = 9
lives = 2
GOTO top0
Highscore.Check:
OPEN "c:\STARZG~1\SGHIGH.STG" FOR INPUT AS #1
INPUT #1, Check$
INPUT #1, Checks
CLOSE #1
IF POINTS > Checks THEN GOTO New.Highscore
GOTO Swoop
New.Highscore:
COLOR 15
SCREEN 13
here2:
res2:
S = 200
top:
c = 31
FOR radius = 1 TO S
COLOR c
CIRCLE (160, 100), radius
IF c > 61 THEN LET c = 30
c = c + 1
FOR i = 1 TO speed / 2000: NEXT i
NEXT radius
S = S - 20
c = 16
FOR radius = 1 TO S
COLOR c
CIRCLE (160, 100), radius
IF c > 30 THEN LET c = 15
c = c + 1
FOR i = 1 TO speed / 2000: NEXT i
NEXT radius
S = S - 20
IF S < 1 THEN GOTO OOoo2
GOTO top
OOoo2:
CLS
c = 16
x = 1
FOR y = 1 TO 200
COLOR c
LINE (x, y)-(x + 320, y)
IF c > 30 THEN LET col = 2
IF c < 17 THEN LET col = 1
IF col = 1 THEN c = c + 1
IF col = 2 THEN c = c - 1
NEXT y
y = 1
x = 1
d = 16
OOoo3:
FOR x = d TO d + 32
COLOR c
LINE (x, y)-(x, y + 200)
IF c > 30 THEN LET col = 2
IF c < 17 THEN LET col = 1
IF col = 1 THEN c = c + 1
IF col = 2 THEN c = c - 1
IF x > 320 THEN GOTO shows
NEXT x
c = 17
d = d + 64
GOTO OOoo3
shows:
COLOR 14: LOCATE 2, 14: PRINT "New High Score"
COLOR 11: LOCATE 4, 13: PRINT "Enter Your Name:"
COLOR 12: LOCATE 6, 10: PRINT "Use the arrow keys and"
COLOR 12: LOCATE 7, 13: PRINT "Space to select."
COLOR 12: LOCATE 8, 13: PRINT "Delete to remove"
COLOR 12: LOCATE 9, 12: PRINT "Insert to confirm."

Letter1 = 65
c = 34
COLOR 10
LINE (140, 105)-(170, 125), , B
LOCATE 19, 18: PRINT "     "
showletter:
IF Letter1 < 65 THEN LET Letter1 = 90
IF Letter1 > 90 THEN LET Letter1 = 65
Letter1 = Letter1
letter2 = Letter1 - 1
letter3 = Letter1 - 2
letter4 = Letter1 + 2
letter5 = Letter1 + 1

IF Letter1 = 65 THEN LET letter2 = 0
IF Letter1 = 65 THEN LET letter3 = 0
IF Letter1 = 66 THEN LET letter3 = 0

IF Letter1 = 90 THEN LET letter5 = 0
IF Letter1 = 90 THEN LET letter4 = 0
IF Letter1 = 89 THEN LET letter4 = 0
IF c > 61 THEN LET c = 34
COLOR c - 2
LOCATE 15, 12: PRINT CHR$(letter3)
COLOR c - 1
LOCATE 15, 16: PRINT CHR$(letter2)
COLOR c
LOCATE 15, 20: PRINT CHR$(Letter1)
COLOR c + 1
LOCATE 15, 24: PRINT CHR$(letter5)
COLOR c + 2
LOCATE 15, 28: PRINT CHR$(letter4)
DO
what.letter$ = INKEY$
IF what.letter$ = CHR$(0) + "M" THEN LET Letter1 = Letter1 + 1: LET c = c + 1: GOTO showletter
IF what.letter$ = CHR$(0) + "K" THEN LET Letter1 = Letter1 - 1: LET c = c + 1: GOTO showletter
IF what.letter$ = " " THEN LET sl = sl + 1: GOTO LetterSelected
IF what.letter$ = CHR$(0) + "S" THEN LET sl = 0: LOCATE 19, 18: PRINT "     ": SLetter1 = 0: SLetter2 = 0: SLetter3 = 0: SLetter4 = 0: SLetter5 = 0
IF what.letter$ = CHR$(0) + "R" THEN GOTO ChosenName
LOOP
LetterSelected:
IF sl = 1 THEN LET SLetter1 = Letter1
IF sl = 2 THEN LET SLetter2 = Letter1
IF sl = 3 THEN LET SLetter3 = Letter1
IF sl = 4 THEN LET SLetter4 = Letter1
IF sl = 5 THEN LET SLetter5 = Letter1
hname$ = CHR$(SLetter1) + CHR$(SLetter2) + CHR$(SLetter3) + CHR$(SLetter4) + CHR$(SLetter5)
COLOR 14
LOCATE 19, 18: PRINT hname$
GOTO showletter
ChosenName:
FOR c = 31 TO 15 STEP -1
COLOR c
LOCATE 19, 18: PRINT hname$
FOR i = 1 TO speed / 10: NEXT i
NEXT c
OPEN "c:\STARZG~1\SGHIGH.STG" FOR OUTPUT AS #1
PRINT #1, hname$
PRINT #1, POINTS
CLOSE #1
CLS
GOTO Swoop

