'Orbs Screensaver Ver. 1.1

'1996 New Moon

'Read the contents of the whatsnew SUB to find out whatsnew.

DECLARE SUB ender ()
DECLARE SUB randomco ()
DECLARE SUB orange ()
DECLARE SUB intro ()
DIM SHARED maincolor
CALL intro
COLOR 2
LOCATE 21, 30: PRINT "Choose your color"
TIMER ON
time1 = TIMER
DO
time2 = TIMER
tyme = INT(10 - (time2 - time1))
IF tyme = 1 THEN
        s$ = "."
ELSE
        s$ = "s"
END IF
LOCATE 22, 30: PRINT "You have"; tyme; "second"
LOCATE 22, 47: PRINT s$
menu$ = INKEY$
IF tyme = 0 THEN EXIT DO
LOOP WHILE menu$ = ""
IF menu$ = "" THEN
        maincolor = 10
ELSE
        maincolor = (VAL(menu$))
END IF
SCREEN 13
WINDOW (0, 0)-(400, 400)
SELECT CASE maincolor
        CASE 2
                CALL orange
        CASE 9
                CALL randomco
        CASE 10
                CALL randomco
        CASE ELSE
                FOR i = 1 TO 63
                        r = i
                        gr = 256 * i
                        bl = 65536 * i
                        SELECT CASE maincolor
                                CASE 1
                                        newco = r
                                CASE 3
                                        newco = r + gr
                                CASE 4
                                        newco = gr
                                CASE 5
                                        newco = gr + bl
                                CASE 6
                                        newco = bl
                                CASE 7
                                        newco = bl + r
                                CASE 8
                                        newco = bl + gr + r
                        END SELECT
                        PALETTE i, newco
                NEXT
        DO
                co = 0:
                RANDOMIZE TIMER
                x = INT(RND * (400 - 0 + 1) + 0)
                RANDOMIZE TIMER
                y = INT(RND * (400 - 0 + 1) + 0)
                FOR r = 63 TO 1 STEP -1
                        CIRCLE (x, y), r, co
                        PAINT (x, y), co
                        co = co + 1
                NEXT
        LOOP UNTIL INKEY$ <> ""
END SELECT
FOR i = 1 TO 63
PALETTE i, 0
NEXT
CALL ender

SUB ender
CLS
SCREEN 12
FOR logocolor = 1 TO 15
pal = pal + 4
white = 65793 * pal
PALETTE logocolor, white
NEXT
FOR wordcolor = 1 TO 37
IF wordcolor > 15 THEN
        wcolor = 15
ELSE
        wcolor = wordcolor
END IF
COLOR wcolor
LOCATE 15, 27: PRINT "1"
IF wordcolor > 16 THEN
        wcolor = 15
ELSEIF wordcolor < 1 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 1
END IF
COLOR wcolor
LOCATE 15, 28: PRINT "9"
IF wordcolor > 17 THEN
        wcolor = 15
ELSEIF wordcolor < 2 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 2
END IF
COLOR wcolor
LOCATE 15, 29: PRINT "9"
IF wordcolor > 18 THEN
        wcolor = 15
ELSEIF wordcolor < 3 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 3
END IF
COLOR wcolor
LOCATE 15, 30: PRINT "6"
IF wordcolor > 19 THEN
        wcolor = 15
ELSEIF wordcolor < 4 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 4
END IF
COLOR wcolor
LOCATE 15, 32: PRINT "N"
IF wordcolor > 20 THEN
        wcolor = 15
ELSEIF wordcolor < 5 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 5
END IF
COLOR wcolor
LOCATE 15, 33: PRINT "e"
IF wordcolor > 21 THEN
        wcolor = 15
ELSEIF wordcolor < 6 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 6
END IF
COLOR wcolor
LOCATE 15, 34: PRINT "w"
IF wordcolor > 22 THEN
        wcolor = 15
ELSEIF wordcolor < 7 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 7
END IF
COLOR wcolor
LOCATE 15, 36: PRINT "M"
IF wordcolor > 23 THEN
        wcolor = 15
ELSEIF wordcolor < 8 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 8
END IF
COLOR wcolor
LOCATE 15, 37: PRINT "o"
IF wordcolor > 24 THEN
        wcolor = 15
ELSEIF wordcolor < 9 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 9
END IF
COLOR wcolor
LOCATE 15, 38: PRINT "o"
IF wordcolor > 25 THEN
        wcolor = 15
ELSEIF wordcolor < 10 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 10
END IF
COLOR wcolor
LOCATE 15, 39: PRINT "n"
IF wordcolor > 26 THEN
        wcolor = 15
ELSEIF wordcolor < 11 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 11
END IF
COLOR wcolor
LOCATE 15, 41: PRINT "P"
IF wordcolor > 27 THEN
        wcolor = 15
ELSEIF wordcolor < 12 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 12
END IF
COLOR wcolor
LOCATE 15, 42: PRINT "r"
IF wordcolor > 28 THEN
        wcolor = 15
ELSEIF wordcolor < 13 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 13
END IF
COLOR wcolor
LOCATE 15, 43: PRINT "o"
IF wordcolor > 29 THEN
        wcolor = 15
ELSEIF wordcolor < 14 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 14
END IF
COLOR wcolor
LOCATE 15, 44: PRINT "d"
IF wordcolor > 30 THEN
        wcolor = 15
ELSEIF wordcolor < 15 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 15
END IF
COLOR wcolor
LOCATE 15, 45: PRINT "u"
IF wordcolor > 31 THEN
        wcolor = 15
ELSEIF wordcolor < 16 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 16
END IF
COLOR wcolor
LOCATE 15, 46: PRINT "c"
IF wordcolor > 32 THEN
        wcolor = 15
ELSEIF wordcolor < 17 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 17
END IF
COLOR wcolor
LOCATE 15, 47: PRINT "t"
IF wordcolor > 33 THEN
        wcolor = 15
ELSEIF wordcolor < 18 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 18
END IF
COLOR wcolor
LOCATE 15, 48: PRINT "i"
IF wordcolor > 34 THEN
        wcolor = 15
ELSEIF wordcolor < 19 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 19
END IF
COLOR wcolor
LOCATE 15, 49: PRINT "o"
IF wordcolor > 35 THEN
        wcolor = 15
ELSEIF wordcolor < 20 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 20
END IF
COLOR wcolor
LOCATE 15, 50: PRINT "n"
IF wordcolor > 36 THEN
        wcolor = 15
ELSEIF wordcolor < 21 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 21
END IF
COLOR wcolor
LOCATE 15, 51: PRINT "s"
NEXT
FOR wordcolor = 37 TO 0 STEP -1
IF wordcolor > 36 THEN
        wcolor = 15
ELSEIF wordcolor < 21 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 21
END IF
COLOR wcolor
LOCATE 15, 27: PRINT "1"
IF wordcolor > 35 THEN
        wcolor = 15
ELSEIF wordcolor < 20 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 20
END IF
COLOR wcolor
LOCATE 15, 28: PRINT "9"
IF wordcolor > 34 THEN
        wcolor = 15
ELSEIF wordcolor < 19 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 19
END IF
COLOR wcolor
LOCATE 15, 29: PRINT "9"
IF wordcolor > 33 THEN
        wcolor = 15
ELSEIF wordcolor < 18 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 18
END IF
COLOR wcolor
LOCATE 15, 30: PRINT "6"
IF wordcolor > 32 THEN
        wcolor = 15
ELSEIF wordcolor < 17 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 17
END IF
COLOR wcolor
LOCATE 15, 32: PRINT "N"
IF wordcolor > 31 THEN
        wcolor = 15
ELSEIF wordcolor < 16 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 16
END IF
COLOR wcolor
LOCATE 15, 33: PRINT "e"
IF wordcolor > 30 THEN
        wcolor = 15
ELSEIF wordcolor < 15 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 15
END IF
COLOR wcolor
LOCATE 15, 34: PRINT "w"
IF wordcolor > 29 THEN
        wcolor = 15
ELSEIF wordcolor < 14 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 14
END IF
COLOR wcolor
LOCATE 15, 36: PRINT "M"
IF wordcolor > 28 THEN
        wcolor = 15
ELSEIF wordcolor < 13 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 13
END IF
COLOR wcolor
LOCATE 15, 37: PRINT "o"
IF wordcolor > 27 THEN
        wcolor = 15
ELSEIF wordcolor < 12 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 12
END IF
COLOR wcolor
LOCATE 15, 38: PRINT "o"
IF wordcolor > 26 THEN
        wcolor = 15
ELSEIF wordcolor < 11 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 11
END IF
COLOR wcolor
LOCATE 15, 39: PRINT "n"
IF wordcolor > 25 THEN
        wcolor = 15
ELSEIF wordcolor < 10 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 10
END IF
COLOR wcolor
LOCATE 15, 41: PRINT "P"
IF wordcolor > 24 THEN
        wcolor = 15
ELSEIF wordcolor < 9 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 9
END IF
COLOR wcolor
LOCATE 15, 42: PRINT "r"
IF wordcolor > 23 THEN
        wcolor = 15
ELSEIF wordcolor < 8 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 8
END IF
COLOR wcolor
LOCATE 15, 43: PRINT "o"
IF wordcolor > 22 THEN
        wcolor = 15
ELSEIF wordcolor < 7 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 7
END IF
COLOR wcolor
LOCATE 15, 44: PRINT "d"
IF wordcolor > 21 THEN
        wcolor = 15
ELSEIF wordcolor < 6 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 6
END IF
COLOR wcolor
LOCATE 15, 45: PRINT "u"
IF wordcolor > 20 THEN
        wcolor = 15
ELSEIF wordcolor < 5 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 5
END IF
COLOR wcolor
LOCATE 15, 46: PRINT "c"
IF wordcolor > 19 THEN
        wcolor = 15
ELSEIF wordcolor < 4 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 4
END IF
COLOR wcolor
LOCATE 15, 47: PRINT "t"
IF wordcolor > 18 THEN
        wcolor = 15
ELSEIF wordcolor < 3 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 3
END IF
COLOR wcolor
LOCATE 15, 48: PRINT "i"
IF wordcolor > 17 THEN
        wcolor = 15
ELSEIF wordcolor < 2 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 2
END IF
COLOR wcolor
LOCATE 15, 49: PRINT "o"
IF wordcolor > 16 THEN
        wcolor = 15
ELSEIF wordcolor < 1 THEN
        wcolor = 0
ELSE
        wcolor = wordcolor - 1
END IF
COLOR wcolor
LOCATE 15, 50: PRINT "n"
IF wordcolor > 15 THEN
        wcolor = 15
ELSE
        wcolor = wordcolor
END IF
COLOR wcolor
LOCATE 15, 51: PRINT "s"
NEXT
DO
FOR i = 1 TO 60
white = 65793 * i
PALETTE 2, white
COLOR 2
LOCATE 15, 27: PRINT "1996 New Moon Productions"
NEXT
FOR i = 60 TO 0 STEP -1
white = 65793 * i
PALETTE 3, white
COLOR 3
LOCATE 15, 27: PRINT "1996 New Moon Productions"
NEXT
LOOP UNTIL INKEY$ <> ""
COLOR 1
END SUB

SUB intro
CLS
SCREEN 12
FOR i = 1 TO 15
PALETTE i, 0
NEXT
COLOR 1
LOCATE 1, 35: PRINT "1) Red"
COLOR 8
LOCATE 3, 35: PRINT "2) Orange"
COLOR 3
LOCATE 5, 35: PRINT "3) Yellow"
COLOR 4
LOCATE 7, 35: PRINT "4) Green"
COLOR 5
LOCATE 9, 35: PRINT "5) Cyan"
COLOR 6
LOCATE 11, 35: PRINT "6) Blue"
COLOR 7
LOCATE 13, 35: PRINT "7) Purple"
COLOR 2
LOCATE 15, 35: PRINT "8) White"
FOR g = 1 TO 31
b = b + 2
RANDOMIZE TIMER
c1 = INT(RND * (7 - 1 + 1) + 1)
COLOR c1
LOCATE 17, 35: PRINT "9) Random"
FOR brighten = 1 TO 8
r = b
bl = b * 65536
gr = b * 256
o = g * 258
       SELECT CASE brighten
                CASE 1
                        ette = r
                CASE 2
                        ette = r + bl + gr
                CASE 3
                        ette = r + gr
                CASE 4
                        ette = gr
                CASE 5
                        ette = gr + bl
                CASE 6
                        ette = bl
                CASE 7
                        ette = r + bl
                CASE 8
                        ette = o
        END SELECT
PALETTE brighten, ette
NEXT
NEXT
END SUB

SUB orange
WINDOW (0, 0)-(200, 200)
FOR i = 1 TO 31
        o = 258 * i
        PALETTE i, o
NEXT
        DO
                FOR i = 1 TO 1000
                NEXT
                co = 0:
                RANDOMIZE TIMER
                x = INT(RND * (200 - 0 + 1) + 0)
                RANDOMIZE TIMER
                y = INT(RND * (200 - 0 + 1) + 0)
                FOR r = 31 TO 1 STEP -1
                        CIRCLE (x, y), r, co
                        PAINT (x, y), co
                        co = co + 1
                NEXT
        LOOP UNTIL INKEY$ <> ""
END SUB

SUB randomco
SCREEN 13
WINDOW (0, 0)-(400, 400)
FOR i = 1 TO 63
PALETTE i, i * (257 + 65536)
FOR e = 1 TO 500
NEXT
COLOR i
LOCATE 12, 15: PRINT "Please wait."
NEXT
SLEEP 3
FOR i = 63 TO 1 STEP -1
PALETTE i, i * (257 + 65536)
COLOR i
FOR e = 1 TO 500
NEXT
LOCATE 12, 15: PRINT "Please wait."
NEXT
CLS
DO
go = go + 1
pal = 0:
RANDOMIZE TIMER
cc = INT(RND * (7 - 1 + 1) + 1)
FOR x = 1 TO 63
r = x
bl = x * 65536
g = x * 256
        SELECT CASE cc
                CASE 1
                        e = r
                CASE 2
                        e = r + bl
                CASE 3
                        e = g
                CASE 4
                        e = bl
                CASE 5
                        e = g + bl
                CASE 6
                        e = bl + g + r
                CASE 7
                        e = r + g
        END SELECT
pal = pal + 1
IF go < 40 THEN e = 0:
PALETTE pal, e
NEXT
pal = 0
RANDOMIZE TIMER
q = INT(RND * (400 - 0 + 1) + 0)
RANDOMIZE TIMER
h = INT(RND * (400 - 0 + 1) + 0)
FOR x = 63 TO 1 STEP -1
CIRCLE (q, h), x, pal
PAINT (q, h), pal
pal = pal + 1
NEXT
LOOP UNTIL INKEY$ <> ""
END SUB

SUB whatsnew

'This is the first released version of my Orbs screensaver. The previous
'versions are:

'Orbs 0.5           

'New in this version:

'More colors
'Increased user control over the colors
'A timer, so you can start it and leave it right away, and it will start
'itself

END SUB

