'                   ___________________________________
'-------------------|PaddleWar v1.2 by Steele Software|-----------------------
'                   -----------------------------------
'
'WARNING: read the following only if you are immune to senseless blabber!
'
'       Thank you for downloading PaddleWar v1.2. I consider the version
'better than the original for many reasons:
'
'               Faster, smoother animation
'               Better menu
'               Easier to understand and learn from code
'               Better over-all game layout
'               CPU speed used to determine delay setting
'
'
'Required or recommended hardware:
'
'VGA monitor
'PC-speaker recommended..... HA! (for those quality sounds)
'
'
'
'        
'-----------------------------------------------------------------------------
'
DECLARE SUB SCREENBLANK ()
DECLARE SUB fprint (text$, X, Y, fcolor, sx, sy)
DECLARE SUB INSTRUCT ()
DECLARE SUB ENDPAGE ()
DECLARE SUB ENDSCREEN ()
DECLARE SUB DRAWBORDER ()
DECLARE SUB DELAY (H)
COMMON SHARED S%, D
SCREEN 13

'DIM's
'HINT: using a put command with XOR or whatever creates faster animation then
'let's say a draw/mask combination using subs
DIM ball(80)
CIRCLE (60, 60), 7, 4
PAINT (61, 61), 12, 4
GET (53, 53)-(67, 67), ball
CLS
DIM paddle(900)
LINE (80, 80)-(90, 120), 26, B
LINE (81, 81)-(89, 119), 27, B
LINE (82, 82)-(88, 118), 28, B
LINE (83, 83)-(87, 117), 29, B
LINE (84, 84)-(86, 116), 30, B
LINE (85, 85)-(85, 115), 31, B
GET (79, 79)-(91, 121), paddle
CLS
DIM TITLE(10000)
PSET (40, 100), 10
DRAW "U40F20D10G20U20D30"
PSET (65, 100), 10
DRAW "E35F35L12H20L5G20"
PSET (140, 100), 10
DRAW "U35R15F10D15G10L15"
PSET (175, 100), 10
DRAW "U35R15F10D15G10L15"
PSET (210, 100), 10
DRAW "U35L7R7D35R20H7"
PSET (240, 100), 10
DRAW "U35R20L20D15R15L15D20R25H7"
PSET (85, 150), 4
DRAW "TA20U40L15R15D40TA340U35TA20D30TA340U40"
PSET (140, 150), 4
DRAW "TA330U45TA30D13L15R15D32"
PSET (220, 150), 4
DRAW "TA350U40TA10L10R10TA350R20D20TA10L20TA50D30"
GET (39, 60)-(280, 151), TITLE

SCREEN 9
COLOR 15, 0: PRINT "PaddleWar v1.2"
PRINT "Free memory bytes:"; FRE(-1)  'Just wanna see how much
PRINT "Loading..."                   'I can stuff in...
SLEEP 2
LOCATE 8, 2
PRINT "Enter around 120 for a 120mhz machine,"
LOCATE 9, 2
PRINT "and around 20 for a 40mhz"
LOCATE 7, 2
INPUT "State computer speed:", K
LOCATE 10, 2
PRINT "Are you using QuickBasic?"
DO
SELECT CASE INKEY$
CASE IS = "Y"
D = K * 8
GOTO EXITLOOP
CASE IS = "y"
D = K * 8
GOTO EXITLOOP
CASE IS = "N"
D = K * 7.3
GOTO EXITLOOP
CASE IS = "n"
D = K * 7.3
GOTO EXITLOOP
CASE IS = ""
GOTO skipper
CASE ELSE
SOUND 2400, 1
skipper:
END SELECT
LOOP
EXITLOOP:
SCREEN 13
MENU:
CLS
PUT (40, 0), TITLE, PSET
LINE (20, 100)-(300, 180), 9, B
LINE (21, 101)-(299, 179), 1, B
LINE (22, 102)-(298, 178), 104, B
CD% = 1
DO

SELECT CASE INKEY$
CASE IS = CHR$(0) + "H"
CD% = CD% - 1
IF CD% = 0 THEN CD% = 1: SOUND 2400, 1
CASE IS = CHR$(0) + "P"
CD% = CD% + 1
IF CD% = 4 THEN CD% = 3: SOUND 2400, 1
CASE IS = CHR$(13)
GOTO MENUEND
END SELECT

IF CD% = 1 THEN
fprint "PLAY PADDLEWAR v1.2", 70, 120, 12, 1, 2
fprint "VIEW INSTRUCTIONS", 80, 150, 4, 1, 2
fprint "EXIT", 140, 177, 4, 1, 2
END IF

IF CD% = 2 THEN
fprint "PLAY PADDLEWAR v1.2", 70, 120, 4, 1, 2
fprint "VIEW INSTRUCTIONS", 80, 150, 12, 1, 2
fprint "EXIT", 140, 177, 4, 1, 2
END IF

IF CD% = 3 THEN
fprint "PLAY PADDLEWAR v1.2", 70, 120, 4, 1, 2
fprint "VIEW INSTRUCTIONS", 80, 150, 4, 1, 2
fprint "EXIT", 140, 177, 12, 1, 2
END IF

LOOP
MENUEND:
SCREENBLANK
IF CD% = 3 THEN ENDSCREEN
IF CD% = 2 THEN
CLS
LINE (1, 1)-(319, 199), 9, B
LINE (2, 2)-(318, 198), 9, B
LINE (3, 3)-(317, 197), 9, B
fprint "INSTRUCTIONS", 95, 20, 12, 1.2, 1.2
fprint "        The object of the game is to  ", 5, 35, 7, .85, .8
fprint "keep the ball from passing your       ", 5, 45, 7, .85, .8
fprint "paddle. The more the ball bounces off ", 5, 55, 7, .85, .8
fprint "your paddle the more points you get.  ", 5, 65, 7, .85, .8
fprint "if the ball exits into space you lose", 5, 75, 7, .85, .8
fprint "a life. The speed of the ball increas ", 5, 85, 7, .85, .8
fprint "es as you continue on in the game.", 5, 95, 7, .85, .8
fprint "CONTROLS", 5, 125, 15, .85, .8
fprint "                     up               ", 5, 145, 7, .85, .8
fprint "         P  pause   down              ", 5, 155, 7, .85, .8
fprint "You get a free life at 2000 and 4000pt", 5, 175, 15, .85, .8
SLEEP 0
SCREENBLANK
GOTO MENU
END IF
'values
CLS
L% = 3
GOING:
IF L% = 0 THEN ENDPAGE
F = 0
XA% = 28
YA% = 110
XB% = 15
YB% = 100
CLS
fprint "PaddleWar", 50, 28, 4, 2.6, 1.5
DIR = 2
PUT (XA%, YA%), ball, XOR
PUT (XB%, YB%), paddle, XOR
'stars
DO
RANDOMIZE TIMER
XC% = (RND * 300) + 10
YC% = (RND * 160) + 30
COL = INT(RND * 3) + 1
IF COL = 1 THEN CC% = 7
IF COL = 2 THEN CC% = 8
IF COL = 3 THEN CC% = 15
PSET (XC%, YC%), CC%
F = F + 1
LOOP UNTIL F >= 90

DRAWBORDER
COLOR 10: LOCATE 2, 2: PRINT "SCORE-"; S%
COLOR 10: LOCATE 2, 30: PRINT "LIVES-"; L%
SLEEP 2

DO
D = D - .1
IF D <= -1 THEN D = 0
IF L% = 0 THEN SCREENBLANK: ENDSCREEN
DRAWBORDER
COLOR 10: LOCATE 2, 2: PRINT "SCORE-"; S%
COLOR 10: LOCATE 2, 30: PRINT "LIVES-"; L%
IF S% = 2000 THEN PLAY "MBT255L15O6CO4GEDC": L% = L% + 1: S% = S% + 100
IF S% = 4000 THEN PLAY "MBT255L15O6CO4GEDC": L% = L% + 1: S% = S% + 100

SELECT CASE INKEY$
CASE IS = CHR$(0) + "H"
DIR2 = 1
CASE IS = CHR$(0) + "P"
DIR2 = 2
CASE IS = "p"
SLEEP 0
CASE IS = "P"
SLEEP 0
END SELECT

IF DIR2 = 1 THEN
PUT (XB%, YB%), paddle, XOR
YB% = YB% - 1
IF YB% = 34 THEN YB% = 35: DIR2 = 0
PUT (XB%, YB%), paddle, XOR
END IF

IF DIR2 = 2 THEN
PUT (XB%, YB%), paddle, XOR
YB% = YB% + 1
IF YB% = 152 THEN YB% = 151: DIR2 = 0
PUT (XB%, YB%), paddle, XOR
END IF

IF DIR = 1 THEN
PUT (XA%, YA%), ball, XOR
XA% = XA% + 1
YA% = YA% - 1
IF XA% >= 302 THEN DIR = 3: SOUND 300, .5
IF YA% <= 32 THEN DIR = 2: SOUND 300, .5
PUT (XA%, YA%), ball, XOR
DELAY D
END IF

IF DIR = 2 THEN
PUT (XA%, YA%), ball, XOR
XA% = XA% + 1
YA% = YA% + 1
IF XA% >= 302 THEN DIR = 4: SOUND 300, .5
IF YA% >= 181 THEN DIR = 1: SOUND 300, .5
PUT (XA%, YA%), ball, XOR
DELAY D
END IF

IF DIR = 3 THEN
PUT (XA%, YA%), ball, XOR
XA% = XA% - 1
YA% = YA% - 1
IF YA% > YB% - 7 AND YA% < YB% + 40 AND XA% = XB% + 13 THEN S% = S% + 100: DIR = 1: SOUND 400, 1
IF XA% <= 10 THEN L% = L% - 1: D = D + 300: GOTO GOING
IF YA% <= 32 THEN DIR = 4: SOUND 300, .5
PUT (XA%, YA%), ball, XOR
DELAY D
END IF

IF DIR = 4 THEN
PUT (XA%, YA%), ball, XOR
XA% = XA% - 1
YA% = YA% + 1
IF YA% > YB% - 7 AND YA% < YB% + 40 AND XA% = XB% + 13 THEN S% = S% + 100: DIR = 2: SOUND 400, 1
IF XA% <= 10 THEN L% = L% - 1: D = D + 300: GOTO GOING
IF YA% >= 181 THEN DIR = 3: SOUND 300, .5
PUT (XA%, YA%), ball, XOR
DELAY D
END IF
LOOP

SUB DELAY (H)
FOR DEL = 1 TO H STEP 1: NEXT DEL
END SUB

SUB DRAWBORDER
LINE (3, 30)-(317, 30), 9
LINE (4, 31)-(316, 31), 1
LINE (5, 32)-(315, 32), 104
LINE (3, 198)-(317, 198), 9
LINE (4, 197)-(316, 197), 1
LINE (5, 196)-(315, 196), 104
LINE (318, 30)-(318, 198), 9
LINE (317, 31)-(317, 197), 1
LINE (316, 32)-(316, 196), 104
END SUB

SUB ENDPAGE
CLS
IF S% = 0 THEN
fprint "WHAT HAPPENED", 40, 20, 15, 2, 2
fprint "did you fall asleep at the keyboard", 0, 40, 7, .9, 1
fprint "is it plugged in", 80, 50, 7, 1, 1
fprint "were you hitting the keys hard enough", 0, 60, 7, .85, 1
fprint "anyway.... you scored zero", 40, 70, 7, 1, 1
fprint "but dont worry... I am sure you will", 0, 90, 7, .86, 1
fprint "get the hang of it", 65, 100, 7, 1, 1
fprint "TRY AGAIN", 85, 150, 12, 1.6, 1.6
END IF
IF S% >= 100 AND S% <= 500 THEN
fprint "Well.... you didnt do so great. It", 10, 40, 7, .92, 1
fprint "looks like you need a little more", 10, 50, 7, .9, 1
fprint "practice. You should.....", 50, 60, 7, 1, 1
fprint "TRY AGAIN", 85, 110, 12, 1.6, 1.6
COLOR 9
LOCATE 19, 12
PRINT "You're Score:"
COLOR 10
LOCATE 19, 26
PRINT S%
SLEEP 0
END IF
IF S% > 500 AND S% <= 1000 THEN
fprint "Good.. I guess you have been", 15, 40, 7, 1, 1
fprint "practicing or my game is too easy.", 10, 50, 7, .9, 1
fprint "I still think you can do better", 5, 60, 7, 1, 1
fprint "that means.....", 90, 70, 7, 1, 1
fprint "TRY AGAIN", 85, 120, 12, 1.6, 1.6
COLOR 9
LOCATE 19, 12
PRINT "You're Score:"
COLOR 10
LOCATE 19, 26
PRINT S%
SLEEP 0
END IF
IF S% > 1000 AND S% <= 1900 THEN
fprint "Very good.... It look like youre", 20, 40, 7, .9, 1
fprint "becoming quite the pong player.", 20, 50, 7, .9, 1
fprint "I guess you just missed the extra", 10, 60, 7, .9, 1
fprint "life score at 2000pts.", 55, 70, 7, .9, 1
fprint "I bet you can do very very good", 15, 80, 7, .9, 1
fprint "if you......", 120, 90, 7, 1, 1
fprint "TRY AGAIN", 85, 140, 12, 1.6, 1.6
COLOR 9
LOCATE 19, 11
PRINT "You're Score:"
COLOR 10
LOCATE 19, 25
PRINT S%
SLEEP 0
END IF
IF S% > 1900 AND S% <= 3900 THEN
fprint "Very very good. You are an", 30, 40, 7, 1, 1
fprint "excellent pong player. There is", 25, 50, 7, .9, 1
fprint "another free life at the 4000pt mark", 0, 60, 7, .9, 1
fprint "all you need to do is pass it....", 25, 70, 7, .9, 1
fprint "TRY AGAIN", 85, 120, 12, 1.6, 1.6
COLOR 9
LOCATE 19, 11
PRINT "You're Score:"
COLOR 10
LOCATE 19, 25
PRINT S%
SLEEP 0
END IF
IF S% > 3900 THEN
fprint "Great. Super. Excellent. You", 25, 40, 7, 1, 1
fprint "have beaten my game. I guess", 20, 50, 7, 1, 1
fprint "you got a free life at the", 30, 60, 7, 1, 1
fprint "4000pt mark. I guess you deserve", 13, 70, 7, .9, 1
fprint "an ending animation sequence....", 20, 80, 7, .9, 1
RANDOMIZE TIMER
WHILE INKEY$ = ""
CE% = (RND * 12) + 1
COLOR CE%
LOCATE 19, 11
PRINT "You're Score:"
COLOR CE% + 5
LOCATE 19, 25
PRINT S%
WEND
END IF
SCREENBLANK
ENDSCREEN
END SUB

SUB ENDSCREEN
SCREEN 9
LOCATE 24, 7
COLOR 15
PRINT "                                                                    "
LOCATE 24, 7
PRINT "********************************************************************"
DELAY 3000
LOCATE 24, 7
PRINT "********************************************************************"
DELAY 3000
LOCATE 24, 7
PRINT "*****---------------------------------------------------------******"
DELAY 3000
LOCATE 24, 7
PRINT "*****|        Thanks for downloading PaddleWar V1.2          |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****|                                                       |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****| This game was created by entirely by Steele Software. |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****| I don't mind you taking my graphics, or anything else |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****| on this game (this was made for fun as well as an     |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****| example for pong-type games). Have Fun!               |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****|                                                       |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****| Visit me at my web site........                       |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****|                                                       |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****|                                                       |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****|                      www.______                       |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****|                                                       |******"
DELAY 3000
LOCATE 24, 7
PRINT "*****|_______________________________________________________|******"
DELAY 3000
LOCATE 24, 7
PRINT "********************************************************************"
DELAY 3000
LOCATE 24, 7
PRINT "********************************************************************"
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
SLEEP 5
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
LOCATE 24, 7
PRINT "                                                                    "
DELAY 3000
SLEEP 2
END
END SUB

SUB fprint (text$, X, Y, fcolor, sx, sy)
A = LEN(text$)
FOR I = 1 TO A
SELECT CASE LCASE$(MID$(text$, I, 1))
 CASE "a"
 LINE (X, Y)-(X, Y - 5 * sy), fcolor
 LINE -(X + 4 * sx, Y - 8 * sy), fcolor
 LINE -(X + 5 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 5 * sy), fcolor
 LINE -(X + 7 * sx, Y), fcolor
 LINE (X, Y - 4 * sy)-(X + 7 * sx, Y - 4 * sy), fcolor
 X = X + 10 * sx
 CASE "b"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 8 * sy), fcolor
 LINE -(X + 8 * sx, Y - 8 * sy), fcolor
 LINE -(X + 8 * sx, Y - 5 * sy), fcolor
 LINE -(X + 7 * sx, Y - 4 * sy), fcolor
 LINE -(X, Y - 4 * sy), fcolor
 LINE (X + 8 * sx, Y - 3 * sy)-(X + 8 * sx, Y - 1 * sy), fcolor
 LINE -(X + 7 * sx, Y), fcolor
 LINE -(X, Y), fcolor
 LINE (X + 7 * sx, Y - 4 * sy)-(X + 8 * sx, Y - 3 * sy), fcolor
 X = X + 10 * sx
 CASE "c"
 LINE (X, Y - 1 * sy)-(X, Y - 7 * sy), fcolor
 LINE -(X + 1 * sx, Y - 8 * sy), fcolor
 LINE -(X + 6 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 7 * sy), fcolor
 LINE (X, Y - 1 * sy)-(X + 1 * sx, Y), fcolor
 LINE -(X + 6 * sx, Y), fcolor
 LINE -(X + 7 * sx, Y - 1 * sy), fcolor
 X = X + 10 * sx
 CASE "d"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE -(X + 6 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 7 * sy), fcolor
 LINE -(X + 7 * sx, Y - 1 * sy), fcolor
 LINE -(X + 6 * sx, Y), fcolor
 LINE -(X, Y), fcolor
 X = X + 10 * sx
 CASE "e"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 8 * sy), fcolor
 LINE (X, Y)-(X + 7 * sx, Y), fcolor
 LINE (X, Y - 4 * sy)-(X + 4 * sx, Y - 4 * sy), fcolor
 X = X + 10 * sx
 CASE "f"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 8 * sy), fcolor
 LINE (X, Y - 4 * sy)-(X + 4 * sx, Y - 4 * sy), fcolor
 X = X + 10 * sx
 CASE "g"
 LINE (X + 5 * sx, Y - 3 * sy)-(X + 6 * sx, Y - 3 * sy), fcolor
 LINE -(X + 7 * sx, Y - 2 * sy), fcolor
 LINE -(X + 7 * sx, Y - 1 * sy), fcolor
 LINE -(X + 6 * sx, Y), fcolor
 LINE -(X + 1 * sx, Y), fcolor
 LINE -(X, Y - 1 * sy), fcolor
 LINE -(X, Y - 7 * sy), fcolor
 LINE -(X + 1 * sx, Y - 8 * sy), fcolor
 LINE -(X + 6 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 7 * sy), fcolor
 X = X + 10 * sx
 CASE "h"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE (X + 7 * sx, Y)-(X + 7 * sx, Y - 8 * sy), fcolor
 LINE (X, Y - 4 * sy)-(X + 7 * sx, Y - 4 * sy), fcolor
 X = X + 10 * sx
 CASE "i"
 LINE (X, Y)-(X + 6 * sx, Y), fcolor
 LINE (X, Y - 8 * sy)-(X + 6 * sx, Y - 8 * sy), fcolor
 LINE (X + 3 * sx, Y)-(X + 3 * sx, Y - 8 * sy), fcolor
 X = X + 9 * sx
 CASE "j"
 LINE (X, Y - 2 * sy)-(X, Y - 1 * sy), fcolor
 LINE -(X + 1 * sx, Y), fcolor
 LINE -(X + 6 * sx, Y), fcolor
 LINE -(X + 7 * sx, Y - 1 * sy), fcolor
 LINE -(X + 7 * sx, Y - 8 * sy), fcolor
 X = X + 10 * sx
 CASE "k"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE (X, Y - 4 * sy)-(X + 7 * sx, Y - 8 * sy), fcolor
 LINE (X, Y - 4 * sy)-(X + 7 * sx, Y), fcolor
 X = X + 10 * sx
 CASE "l"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE (X, Y)-(X + 6 * sx, Y), fcolor
 X = X + 9 * sx
 CASE "m"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE -(X + 3 * sx, Y - 5 * sy), fcolor
 LINE -(X + 4 * sx, Y - 5 * sy), fcolor
 LINE -(X + 7 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y), fcolor
 X = X + 10 * sx
 CASE "n"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y), fcolor
 LINE -(X + 7 * sx, Y - 8 * sy), fcolor
 X = X + 10 * sx
 CASE "o"
 LINE (X, Y - 2 * sy)-(X, Y - 6 * sy), fcolor
 LINE -(X + 1 * sx, Y - 7 * sy), fcolor
 LINE -(X + 2 * sx, Y - 8 * sy), fcolor
 LINE -(X + 5 * sx, Y - 8 * sy), fcolor
 LINE -(X + 6 * sx, Y - 7 * sy), fcolor
 LINE -(X + 7 * sx, Y - 6 * sy), fcolor
 LINE -(X + 7 * sx, Y - 2 * sy), fcolor
 LINE -(X + 6 * sx, Y - 1 * sy), fcolor
 LINE -(X + 5 * sx, Y), fcolor
 LINE -(X + 2 * sx, Y), fcolor
 LINE -(X + 1 * sx, Y - 1 * sy), fcolor
 LINE -(X, Y - 2 * sy), fcolor
 X = X + 10 * sx
 CASE "p"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE -(X + 6 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 7 * sy), fcolor
 LINE -(X + 7 * sx, Y - 5 * sy), fcolor
 LINE -(X + 6 * sx, Y - 4 * sy), fcolor
 LINE -(X, Y - 4 * sy), fcolor
 X = X + 10 * sx
 CASE "q"
 LINE (X, Y - 3 * sy)-(X, Y - 6 * sy), fcolor
 LINE -(X + 2 * sx, Y - 8 * sy), fcolor
 LINE -(X + 5 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 6 * sy), fcolor
 LINE -(X + 7 * sx, Y - 3 * sy), fcolor
 LINE -(X + 5 * sx, Y - 1 * sy), fcolor
 LINE -(X + 2 * sx, Y - 1 * sy), fcolor
 LINE -(X, Y - 3 * sy), fcolor
 LINE (X + 3 * sx, Y - 3 * sy)-(X + 5 * sx, Y), fcolor
 X = X + 10 * sx
 CASE "r"
 LINE (X, Y)-(X, Y - 8 * sy), fcolor
 LINE -(X + 6 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 7 * sy), fcolor
 LINE -(X + 7 * sx, Y - 5 * sy), fcolor
 LINE -(X + 6 * sx, Y - 4 * sy), fcolor
 LINE -(X, Y - 4 * sy), fcolor
 LINE (X + 2 * sx, Y - 4 * sy)-(X + 7 * sx, Y), fcolor
 X = X + 10 * sx
 CASE "s"
 LINE (X, Y - 2 * sy)-(X + 2 * sx, Y), fcolor
 LINE -(X + 5 * sx, Y), fcolor
 LINE -(X + 7 * sx, Y - 2 * sy), fcolor
 LINE -(X + 5 * sx, Y - 4 * sy), fcolor
 LINE -(X + 2 * sx, Y - 4 * sy), fcolor
 LINE -(X, Y - 6 * sy), fcolor
 LINE -(X + 2 * sx, Y - 8 * sy), fcolor
 LINE -(X + 5 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 6 * sy), fcolor
 X = X + 10 * sx
 CASE "t"
 LINE (X, Y - 8 * sy)-(X + 6 * sx, Y - 8 * sy), fcolor
 LINE (X + 3 * sx, Y - 8 * sy)-(X + 3 * sx, Y), fcolor
 X = X + 9 * sx
 CASE "u"
 LINE (X, Y - 8 * sy)-(X, Y - 1 * sy), fcolor
 LINE -(X + 1 * sx, Y), fcolor
 LINE -(X + 6 * sx, Y), fcolor
 LINE -(X + 7 * sx, Y - 1 * sy), fcolor
 LINE -(X + 7 * sx, Y - 8 * sy), fcolor
 X = X + 10 * sx
 CASE "v"
 LINE (X, Y - 8 * sy)-(X + 3 * sx, Y), fcolor
 LINE -(X + 6 * sx, Y - 8 * sy), fcolor
 X = X + 9 * sx
 CASE "w"
 LINE (X, Y - 8 * sy)-(X, Y), fcolor
 LINE -(X + 3 * sx, Y - 3 * sy), fcolor
 LINE -(X + 4 * sx, Y - 3 * sy), fcolor
 LINE -(X + 7 * sx, Y), fcolor
 LINE -(X + 7 * sx, Y - 8 * sy), fcolor
 X = X + 10 * sx
 CASE "x"
 LINE (X, Y - 8 * sy)-(X + 7 * sx, Y), fcolor
 LINE (X, Y)-(X + 7 * sx, Y - 8 * sy), fcolor
 X = X + 10 * sx
 CASE "y"
 LINE (X, Y - 8 * sy)-(X + 3 * sx, Y - 5 * sy), fcolor
 LINE -(X + 3 * sx, Y), fcolor
 LINE (X + 3 * sx, Y - 5 * sy)-(X + 6 * sx, Y - 8 * sy), fcolor
 X = X + 9 * sx
 CASE "z"
 LINE (X, Y - 8 * sy)-(X + 7 * sx, Y - 8 * sy), fcolor
 LINE -(X, Y), fcolor
 LINE -(X + 7 * sx, Y), fcolor
 X = X + 10 * sx
 CASE "1"
 LINE (X, Y - 6 * sy)-(X + 2 * sx, Y - 8 * sy), fcolor
 LINE -(X + 3 * sx, Y - 8 * sy), fcolor
 LINE -(X + 3 * sx, Y), fcolor
 LINE (X, Y)-(X + 6 * sx, Y), fcolor
 X = X + 9 * sx
 CASE "2"
 LINE (X + 7 * sx, Y)-(X, Y), fcolor
 LINE -(X + 7 * sx, Y - 6 * sy), fcolor
 LINE -(X + 5 * sx, Y - 8 * sy), fcolor
 LINE -(X + 2 * sx, Y - 8 * sy), fcolor
 LINE -(X, Y - 6 * sy), fcolor
 X = X + 10 * sx
 CASE "3"
 LINE (X, Y - 1 * sy)-(X + 1 * sx, Y), fcolor
 LINE -(X + 6 * sx, Y), fcolor
 LINE -(X + 7 * sx, Y - 1 * sy), fcolor
 LINE -(X + 7 * sx, Y - 7 * sy), fcolor
 LINE -(X + 6 * sx, Y - 8 * sy), fcolor
 LINE -(X + 1 * sx, Y - 8 * sy), fcolor
 LINE -(X, Y - 7 * sy), fcolor
 LINE (X + 7 * sx, Y - 4 * sy)-(X + 3 * sx, Y - 4 * sy), fcolor
 X = X + 10 * sx
 CASE "4"
 LINE (X, Y - 8 * sy)-(X, Y - 4 * sy), fcolor
 LINE -(X + 7 * sx, Y - 4 * sy), fcolor
 LINE (X + 6 * sx, Y - 8 * sy)-(X + 6 * sx, Y), fcolor
 X = X + 10 * sx
 CASE "5"
 LINE (X, Y)-(X + 5 * sx, Y), fcolor
 LINE -(X + 7 * sx, Y - 2 * sy), fcolor
 LINE -(X + 7 * sx, Y - 3 * sy), fcolor
 LINE -(X + 6 * sx, Y - 4 * sy), fcolor
 LINE -(X, Y - 4 * sy), fcolor
 LINE -(X, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 8 * sy), fcolor
 X = X + 10 * sx
 CASE "6"
 LINE (X + 7 * sx, Y - 7 * sy)-(X + 6 * sx, Y - 8 * sy), fcolor
 LINE -(X + 1 * sx, Y - 8 * sy), fcolor
 LINE -(X, Y - 7 * sy), fcolor
 LINE -(X, Y - 1 * sy), fcolor
 LINE -(X + 1 * sy, Y), fcolor
 LINE -(X + 6 * sx, Y), fcolor
 LINE -(X + 7 * sx, Y - 1 * sy), fcolor
 LINE -(X + 7 * sx, Y - 3 * sy), fcolor
 LINE -(X + 6 * sx, Y - 4 * sy), fcolor
 LINE -(X, Y - 4 * sy), fcolor
 X = X + 10 * sx
 CASE "7"
 LINE (X, Y - 8 * sy)-(X + 7 * sx, Y - 8 * sy), fcolor
 LINE -(X, Y), fcolor
 X = X + 10 * sx
 CASE "8"
 LINE (X, Y - 5 * sy)-(X, Y - 7 * sy), fcolor
 LINE -(X + 1 * sx, Y - 8 * sy), fcolor
 LINE -(X + 6 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 7 * sy), fcolor
 LINE -(X + 7 * sx, Y - 5 * sy), fcolor
 LINE -(X + 6 * sx, Y - 4 * sy), fcolor
 LINE -(X + 1 * sx, Y - 4 * sy), fcolor
 LINE -(X, Y - 3 * sy), fcolor
 LINE -(X, Y - 1 * sy), fcolor
 LINE -(X + 1 * sx, Y), fcolor
 LINE -(X + 6 * sx, Y), fcolor
 LINE -(X + 7 * sx, Y - 1 * sy), fcolor
 LINE -(X + 7 * sx, Y - 3 * sy), fcolor
 LINE -(X + 6 * sx, Y - 4 * sy), fcolor
 X = X + 10 * sx
 CASE "9"
 LINE (X, Y - 5 * sy)-(X, Y - 7 * sy), fcolor
 LINE -(X + 1 * sx, Y - 8 * sy), fcolor
 LINE -(X + 6 * sx, Y - 8 * sy), fcolor
 LINE -(X + 7 * sx, Y - 7 * sy), fcolor
 LINE -(X + 7 * sx, Y), fcolor
 LINE (X + 7 * sx, Y - 4 * sy)-(X + 1 * sx, Y - 4 * sy), fcolor
 LINE -(X, Y - 5 * sy), fcolor
 X = X + 10 * sx
 CASE "0"
 LINE (X, Y - 2 * sy)-(X, Y - 6 * sy), fcolor
 LINE -(X + 1 * sx, Y - 7 * sy), fcolor
 LINE -(X + 2 * sx, Y - 8 * sy), fcolor
 LINE -(X + 5 * sx, Y - 8 * sy), fcolor
 LINE -(X + 6 * sx, Y - 7 * sy), fcolor
 LINE -(X + 7 * sx, Y - 6 * sy), fcolor
 LINE -(X + 7 * sx, Y - 2 * sy), fcolor
 LINE -(X + 6 * sx, Y - 1 * sy), fcolor
 LINE -(X + 5 * sx, Y), fcolor
 LINE -(X + 2 * sx, Y), fcolor
 LINE -(X + 1 * sx, Y - 1 * sy), fcolor
 LINE -(X, Y - 2 * sy), fcolor
 LINE (X + 1 * sx, Y - 1 * sy)-(X + 6 * sx, Y - 7 * sy), fcolor
 X = X + 10 * sx
 CASE "."
 LINE (X, Y)-(X, Y - 1 * sy), fcolor
 LINE -(X + 1 * sx, Y - 1 * sy), fcolor
 LINE -(X + 1 * sx, Y), fcolor
 LINE -(X, Y), fcolor
 'PAINT (x + 1, y + 1), fcolor
 X = X + 6 * sx
 CASE " "
 X = X + 10 * sx
 CASE ELSE
 LOCATE 5, 1: COLOR 3: PRINT "Sorry not done yet"
 END SELECT
NEXT I
END SUB

SUB SCREENBLANK
XD% = 0
XF% = 320
DO
XD% = XD% + 2
LINE (XD%, 0)-(XD%, 200), 0
XF% = XF% - 2
LINE (XF%, 0)-(XF%, 200), 0
DELAY D * 2
DELAY D * 2
LOOP UNTIL XF% = 158
XD% = XD% - 1
XF% = XF% - 1
DO
XD% = XD% - 2
LINE (XD%, 0)-(XD%, 200), 0
XF% = XF% + 2
LINE (XF%, 0)-(XF%, 200), 0
DELAY D * 2
DELAY D * 2
LOOP UNTIL XF% >= 319
SLEEP 1

END SUB

