'Firestorm version 1.3
DECLARE SUB config ()
DECLARE SUB logo ()
DECLARE SUB suave ()
DECLARE SUB tee ()
DECLARE SUB title ()
COMMON SHARED lines AS INTEGER
COMMON SHARED smoothdeg AS INTEGER
COMMON SHARED pausetime AS INTEGER
COMMON SHARED backdrop AS STRING
DIM SHARED pall AS INTEGER
DIM SHARED l AS INTEGER
DIM SHARED t AS INTEGER
CALL logo
CALL title
SCREEN 12
FOR i = 0 TO 63
        PALETTE 2, i
        COLOR 2
        LOCATE 12, 29: PRINT "Hit 'b' to begin or"
        LOCATE 14, 20: PRINT "'c' to go to the configuration screen"
NEXT
TIMER ON
time1 = TIMER
DO
        iwonder$ = INKEY$
        time2 = TIMER
        IF time2 - time1 > 15 THEN iwonder$ = "b"
        SELECT CASE LCASE$(iwonder$)
                CASE "b"
                        OPEN "fire.dat" FOR INPUT AS #1
                        INPUT #1, lines, smoothdeg, pausetime, backdrop$
                        CLOSE #1
                CASE "c"
                        CLEAR
                        CALL config
                        iwonder$ = "c"
        END SELECT
LOOP WHILE iwonder$ <> "b" AND iwonder$ <> "c"
SCREEN 13
CLS
r = 31
FOR i = 0 TO 127
PALETTE i, 0
NEXT
IF backdrop$ = "on " THEN
        FOR i = 1 TO 200
                hot = i / 200
                LINE (1, 200 - i)-(320, 200 - i), CINT(127 * hot)
        NEXT
END IF
FOR i = 127 TO 1 STEP -1
        g = g + 63 / 128
        r = r - 31 / 128
        z = r + r
        v = r + r + g
        z = CINT(v) + 256 * CINT(z)
        PALETTE i, z
NEXT
c = 0
DO
menu$ = INKEY$
IF menu$ = CHR$(13) THEN EXIT DO
c = c + 1
RANDOMIZE TIMER
x = INT(RND * (320 - 1 + 1) + 1)
RANDOMIZE TIMER
y = INT(RND * (198 - 1 + 1) + 1)
percy = 1 - (y / 200)
        pally = INT((112 * percy) + 15)
        FOR i = 0 TO -15 STEP -1
                PSET (x, y + i), pally + 1 + i
        NEXT
LOOP UNTIL c > lines
BEEP
CALL suave
DO
        GOSUB first
        r = 31
        g = 0
        FOR ease = 127 TO 1 STEP -.5
                menu$ = INKEY$
                pal = CINT(ease)
                GOSUB neckst
                g = g + 63 / 256
                r = r - 31 / 256
                t = r1 + r2 + g1
                u = r3 + r4 + g2
                v = r5 + r6 + g3
                IF CINT(t) > 63 THEN
                        t = 63
                ELSEIF CINT(u) > 62 THEN
                        u = 63
                ELSEIF CINT(v) > 62 THEN
                        v = 63
                END IF
                x = 65536 * CINT(t)
                y = 256 * CINT(u)
                z = CINT(v)
                PALETTE pal, x + y + z
        NEXT
        SLEEP pausetime
        menu$ = INKEY$
LOOP UNTIL menu$ <> ""
FOR i = 127 TO 1 STEP -1
        PALETTE i, 0
NEXT
END
first:
        RANDOMIZE TIMER
        n1 = INT(RND * 2)
        RANDOMIZE TIMER
        n2 = INT(RND * 2)
        RANDOMIZE TIMER
        n3 = INT(RND * 2)
        RANDOMIZE TIMER
        n4 = INT(RND * 2)
        RANDOMIZE TIMER
        n5 = INT(RND * 2)
        RANDOMIZE TIMER
        n6 = INT(RND * 2)
        RANDOMIZE TIMER
        n7 = INT(RND * 2)
        RANDOMIZE TIMER
        n8 = INT(RND * 2)
        RANDOMIZE TIMER
        n9 = INT(RND * 2)
RETURN
neckst:
        IF n1 = 0 THEN
                g1 = g
        ELSE
                g1 = 0
        END IF
        IF n2 = 0 THEN
                g2 = g
        ELSE
                g2 = 0
        END IF
        IF n3 = 0 THEN
                g3 = g
        ELSE
                g3 = 0
        END IF
        IF n4 = 0 THEN
                r1 = r
        ELSE
                r1 = 0
        END IF
        IF n5 = 0 THEN
                r2 = r
        ELSE
                r2 = 0
        END IF
        IF n6 = 0 THEN
                r3 = r
        ELSE
                r3 = 0
        END IF
        IF n7 = 0 THEN
                r4 = r
        ELSE
                r4 = 0
        END IF
        IF n8 = 0 THEN
                r5 = r
        ELSE
                r5 = 0
        END IF
        IF n9 = 0 THEN
                r6 = r
        ELSE
                r6 = 0
        END IF
RETURN

SUB config
SCREEN 12
CLS
OPEN "fire.dat" FOR INPUT AS #1
INPUT #1, lines, smoothdeg, pausetime, backdrop$
CLOSE #1
sec = (lines / 200) + (smoothdeg * 85)
GOSUB father
COLOR 7
LOCATE 12, 27: PRINT "Degree of smoothness:"
LOCATE 12, 49: PRINT smoothdeg
LOCATE 14, 16: PRINT "Number of seconds to pause between colors:"
LOCATE 14, 59: PRINT pausetime
LOCATE 16, 28: PRINT "Backdrop painting"
LOCATE 16, 48: PRINT backdrop$
DO
        RANDOMIZE TIMER
        pal = INT(RND * 63 + 1)
        PALETTE 3, pal
        COLOR 3
        LOCATE 1, 26: PRINT "F I R E S T O R M Ver. 1.3"
        COLOR 15
        LOCATE 3, 29: PRINT "Configuration Screen"
        COLOR 15
        LOCATE 10, 28: PRINT "Number of lines:"
        COLOR 14
        LOCATE 10, 44: PRINT USING "######"; lines
        menu$ = INKEY$
        SELECT CASE menu$
                CASE CHR$(0) + CHR$(75)
                        IF lines > 0 THEN lines = lines - 200: sec = sec - 1: GOSUB father:
                CASE CHR$(0) + CHR$(77)
                        lines = lines + 200
                        sec = sec + 1
                        GOSUB father
        END SELECT
        COLOR 15
        LOCATE 25, 24: PRINT "Approximate waiting time:"
        COLOR 14
        LOCATE 25, 50: PRINT USING "##:"; min
        IF sec2 < 10 THEN
                LOCATE 25, 53: PRINT USING "0#"; sec2
        ELSE
                LOCATE 25, 53: PRINT USING "##"; sec2
        END IF
LOOP UNTIL menu$ = CHR$(13)
DO
        RANDOMIZE TIMER
        pal = INT(RND * 63 + 1)
        PALETTE 3, pal
        COLOR 3
        LOCATE 1, 26: PRINT "F I R E S T O R M Ver. 1.3"
        COLOR 7
        LOCATE 10, 28: PRINT "Number of lines:"
        LOCATE 10, 45: PRINT lines
        COLOR 15
        LOCATE 12, 27: PRINT "Degree of smoothness:"
        COLOR 14
        LOCATE 12, 49: PRINT smoothdeg
        menu$ = INKEY$
        SELECT CASE menu$
                CASE CHR$(0) + CHR$(75)
                        IF smoothdeg > 0 THEN smoothdeg = smoothdeg - 1: sec = sec - 85: GOSUB father:
                CASE CHR$(0) + CHR$(77)
                        smoothdeg = smoothdeg + 1
                        sec = sec + 85
                        GOSUB father
        END SELECT
        COLOR 15
        LOCATE 25, 24: PRINT "Approximate waiting time:"
        COLOR 14
        LOCATE 25, 50: PRINT USING "##:"; min
        IF sec2 < 10 THEN
                LOCATE 25, 53: PRINT USING "0#"; sec2
        ELSE
                LOCATE 25, 53: PRINT USING "##"; sec2
        END IF
LOOP UNTIL menu$ = CHR$(13)
DO
        RANDOMIZE TIMER
        pal = INT(RND * 63 + 1)
        PALETTE 3, pal
        COLOR 3
        LOCATE 1, 26: PRINT "F I R E S T O R M Ver. 1.3"
        COLOR 7
        LOCATE 12, 27: PRINT "Degree of smoothness:"
        LOCATE 12, 49: PRINT smoothdeg
        COLOR 15
        LOCATE 14, 16: PRINT "Number of seconds to pause between colors:"
        COLOR 14
        LOCATE 14, 59: PRINT USING "##"; pausetime
        menu$ = INKEY$
        SELECT CASE menu$
                CASE CHR$(0) + CHR$(75)
                        IF pausetime > 0 THEN pausetime = pausetime - 1:
                CASE CHR$(0) + CHR$(77)
                        pausetime = pausetime + 1
        END SELECT
LOOP UNTIL menu$ = CHR$(13)
DO
        RANDOMIZE TIMER
        pal = INT(RND * 63 + 1)
        PALETTE 3, pal
        COLOR 3
        LOCATE 1, 26: PRINT "F I R E S T O R M Ver. 1.3"
        COLOR 7
        LOCATE 14, 16: PRINT "Number of seconds to pause between colors:"
        LOCATE 14, 59: PRINT USING "##"; pausetime
        COLOR 15
        LOCATE 16, 28: PRINT "Backdrop painting"
        COLOR 14
        LOCATE 16, 48: PRINT backdrop$
        menu$ = INKEY$
        SELECT CASE menu$
                CASE CHR$(0) + CHR$(75)
                        IF LCASE$(LEFT$(backdrop$, 2)) = "on" THEN backdrop$ = "off": sec = sec - 2: GOSUB father:
                CASE CHR$(0) + CHR$(77)
                        IF LCASE$(LEFT$(backdrop$, 2)) = "of" THEN backdrop$ = "on ": sec = sec + 2: GOSUB father:
        END SELECT
        COLOR 15
        LOCATE 25, 24: PRINT "Approximate waiting time:"
        COLOR 14
        LOCATE 25, 50: PRINT USING "##:"; min
        IF sec2 < 10 THEN
                LOCATE 25, 53: PRINT USING "0#"; sec2
        ELSE
                LOCATE 25, 53: PRINT USING "##"; sec2
        END IF
LOOP UNTIL menu$ = CHR$(13)
COLOR 7
LOCATE 16, 28: PRINT "Backdrop painting"
LOCATE 16, 48: PRINT backdrop$
COLOR 15
LOCATE 18, 26: INPUT "Save settings on exit"; saver$
IF LCASE$(LEFT$(saver$, 1)) = "y" THEN
        OPEN "fire.dat" FOR OUTPUT AS #1
        WRITE #1, lines, smoothdeg, pausetime, backdrop$
        CLOSE #1
END IF
GOSUB endofsub
father:
min = 0
sec2 = sec
        DO
                IF sec2 >= 60 THEN
                        min = min + 1
                        sec2 = sec2 - 60
                END IF
        LOOP UNTIL sec2 < 60
RETURN
endofsub:
END SUB

SUB logo
SCREEN 12
WINDOW (-500, -500)-(500, 500)
pi = 3.141592645#:
DO UNTIL b = 14
b = b + 1
        bl = 65536 * b
        r = 1 * b
        g = 256 * b
x = g + bl + r
pal = pal + 1
PALETTE pal, x
LOOP
pal = 0: b = 0
DO UNTIL pal > 13
z = 50 - (a / 25)
CIRCLE (z, z), 200, pal, pi * (2 / 3), pi * (5 / 3)
IF b = 8 THEN
        pal = pal + .3
        b = 0
END IF
b = b + 1
a = a + 1
LOOP
PALETTE 15, 0
COLOR 15
'NEW MOON PRODUCTIONS; Each letter is 12X30; letter space = 5; word space = 10
'N
LINE (-250, -285)-STEP(0, 30)
LINE (-250, -255)-STEP(12, -30)
LINE (-238, -285)-STEP(0, 30)
'E
LINE (-233, -285)-STEP(0, 30)
LINE (-233, -255)-STEP(12, 0)
LINE (-233, -270)-STEP(10, 0)
LINE (-233, -285)-STEP(12, 0)
'W
LINE (-216, -255)-STEP(0, -30)
LINE (-216, -285)-STEP(6, 15)
LINE (-210, -270)-STEP(6, -15)
LINE (-204, -285)-STEP(0, 30)
'M
LINE (-184, -285)-STEP(0, 30)
LINE (-184, -255)-STEP(6, -15)
LINE (-178, -270)-STEP(6, 15)
LINE (-172, -255)-STEP(0, -30)
'O
CIRCLE (-161, -270), 11, , , , 2
'O
CIRCLE (-143, -270), 11, , , , 2
'N
LINE (-133, -285)-STEP(0, 30)
LINE (-133, -255)-STEP(12, -30)
LINE (-121, -285)-STEP(0, 30)
'P
LINE (-101, -285)-STEP(0, 30)
CIRCLE (-101, -263), 10, , (pi * 3) / 2, pi / 2, .6
'R
LINE (-87, -285)-STEP(0, 30)
CIRCLE (-87, -263), 10, , (pi * 3) / 2, pi / 2, .6
LINE (-87, -270)-STEP(11, -15)
'O
CIRCLE (-65, -270), 11, , , , 2
'D
LINE (-54, -285)-STEP(0, 30)
CIRCLE (-54, -270), 11, , pi * 3 / 2, pi / 2
'U
CIRCLE (-32, -277), 7, , pi, pi * 2
LINE (-38, -277)-STEP(0, 21)
LINE (-26, -277)-STEP(0, 21)
'C
CIRCLE (-15, -270), 11, , pi / 2.7, pi * 3 / 1.8, 2
'T
LINE (-1, -285)-STEP(0, 30)
LINE (-7, -255)-STEP(12, 0)
'I
LINE (10, -285)-STEP(0, 30)
'O
CIRCLE (21, -270), 11, , , , 2
'N
LINE (32, -285)-STEP(0, 30)
LINE (32, -255)-STEP(11, -30)
LINE (43, -285)-STEP(0, 30)
'S
CIRCLE (55, -265), 5.5, , pi * .2, pi * 3 / 2.3, .9
CIRCLE (54, -278), 5.5, , pi * 1.2, pi / 2, .85
h = 0
DO
g = 256 * h
r = 1 * h
bl = 65536 * h
    h = h + 1
PALETTE 15, g
FOR i = 1 TO 1000
NEXT
LOOP UNTIL h > 21
SLEEP 5
'moon fading
DO
        st = st - 1
        t = st
        pall = 0:
        DO
                CALL tee
                DO
                        g = 256 * l
                        r = 1 * l
                        bl = 65536 * l
                        pall = pall + 1
                        PALETTE pall, g + bl + r
                LOOP WHILE t = 12330
        LOOP UNTIL t > 13
LOOP UNTIL st < -13
'letters fading
h = 45
DO UNTIL h = 1
        h = h - 1
g = 256 * h
r = 1 * h
bl = 65536 * h
PALETTE 15, g
FOR i = 1 TO 500
NEXT
LOOP
CLS
END SUB

SUB suave
c = 0
DIM col(8)
DO WHILE c < smoothdeg
c = c + 1
FOR x1 = 1 TO 160
        x2 = 320 - x1
        FOR y1 = 198 TO 1 STEP -1
                col(0) = POINT(x1, y1)
                col(1) = POINT(x1 + 1, y1)
                col(2) = POINT(x1, y1 + 1)
                col(3) = POINT(x1, y1 - 1)
                tot = 0
                FOR fun = 0 TO 3
                        tot = tot + col(fun)
                NEXT
                ave = tot / 4
                col(4) = POINT(x2, y1)
                col(5) = POINT(x2 - 1, y1)
                col(6) = POINT(x2, y1 + 1)
                col(7) = POINT(x2, y1 - 1)
                tot2 = 0
                FOR fun2 = 4 TO 7
                        tot2 = tot2 + col(fun2)
                NEXT
                ave2 = tot2 / 4
                PSET (x2, y1), ave2
                PSET (x1, y1), ave
        NEXT
NEXT
LOOP
END SUB

SUB tee
t = t + 1
IF t < 0 THEN
        l = 0
ELSE
        l = t
END IF
IF pall > 13 THEN
        pall = 13
END IF
END SUB

SUB title
SCREEN 13
CLS
FOR i0 = 1 TO 63
        i = i0
        PALETTE i, i
NEXT
FOR i = 128 TO 155
        PALETTE i, 0
NEXT
count1 = 160
FOR i = 1000 TO 980 STEP -7
        count1 = count1 - 5
        CIRCLE (160, 935), i, count1
NEXT
FOR i = 128 TO 155
        PALETTE i, (i - 126) * 65793
NEXT
c = 0
DO
        c = c + 1
        RANDOMIZE TIMER
        starx = INT(RND * 320)
        RANDOMIZE TIMER
        stary = INT(RND * 90)
        PSET (starx, stary), 155
        PSET (starx, 200 - stary), 155
LOOP UNTIL c = 50
CIRCLE (320, 0), 20, 155
PAINT (319, 1), 155
CIRCLE (320, 200), 20, 155
PAINT (319, 199), 155
f:
FOR i0 = 1 TO 63 STEP .5
        c = c + 1
        IF c = 1 THEN
                WINDOW (0, 0)-(320, 200)
        ELSE
                WINDOW
                c = 0
        END IF
        i = CINT(i0)
        RANDOMIZE TIMER
        fx1 = INT(RND * (10 - 0 + 1) + 0)
        RANDOMIZE TIMER
        fy1 = INT(RND * (60 - 20 + 1) + 20)
        LINE (fx1, fy1)-STEP(0, 10), i
        RANDOMIZE TIMER
        fx2 = INT(RND * (30 - 10 + 1) + 10)
        RANDOMIZE TIMER
        fy2 = INT(RND * (25 - 20 + 1) + 20)
        LINE (fx2, fy2)-STEP(0, 5), i
        RANDOMIZE TIMER
        fx3 = INT(RND * (30 - 10 + 1) + 10)
        RANDOMIZE TIMER
        fy3 = INT(RND * (45 - 40 + 1) + 40)
        LINE (fx3, fy3)-STEP(0, 5), i
i:
        i = CINT(i0)
        RANDOMIZE TIMER
        ix1 = INT(RND * (50 - 40 + 1) + 40)
        RANDOMIZE TIMER
        iy1 = INT(RND * (60 - 20 + 1) + 20)
        LINE (ix1, iy1)-STEP(0, 10), i
r:
        i = CINT(i0)
        RANDOMIZE TIMER
        rx1 = INT(RND * (70 - 60 + 1) + 60)
        RANDOMIZE TIMER
        ry1 = INT(RND * (60 - 20 + 1) + 20)
        LINE (rx1, ry1)-STEP(0, 10), i
        RANDOMIZE TIMER
        rx2 = INT(RND * (80 - 70 + 1) + 70)
        RANDOMIZE TIMER
        ry2 = INT(RND * (25 - 20 + 1) + 20)
        LINE (rx2, ry2)-STEP(10, 10), i
        RANDOMIZE TIMER
        rx3 = INT(RND * (90 - 80 + 1) + 80)
        RANDOMIZE TIMER
        ry3 = INT(RND * (40 - 35 + 1) + 35)
        LINE (rx3, ry3)-STEP(-10, 10), i
        RANDOMIZE TIMER
        rx4 = INT(RND * (80 - 70 + 1) + 70)
        RANDOMIZE TIMER
        ry4 = INT(RND * (60 - 50 + 1) + 50)
        LINE (rx4, ry4)-STEP(10, 10), i
e:
        i = CINT(i0)
        RANDOMIZE TIMER
        ex1 = INT(RND * (110 - 100 + 1) + 100)
        RANDOMIZE TIMER
        ey1 = INT(RND * (60 - 20 + 1) + 20)
        LINE (ex1, ey1)-STEP(0, 10), i
        RANDOMIZE TIMER
        ex2 = INT(RND * (130 - 110 + 1) + 110)
        RANDOMIZE TIMER
        ey2 = INT(RND * (25 - 20 + 1) + 20)
        LINE (ex2, ey2)-STEP(0, 5), i
        RANDOMIZE TIMER
        ex3 = INT(RND * (130 - 110 + 1) + 110)
        RANDOMIZE TIMER
        ey3 = INT(RND * (45 - 40 + 1) + 40)
        LINE (ex3, ey3)-STEP(0, 5), i
        RANDOMIZE TIMER
        ex4 = INT(RND * (130 - 110 + 1) + 110)
        RANDOMIZE TIMER
        ey4 = INT(RND * (65 - 60 + 1) + 60)
        LINE (ex4, ey4)-STEP(0, 5), i
s:
        i = CINT(i0)
        RANDOMIZE TIMER
        sx1 = INT(RND * (170 - 160 + 1) + 160)
        RANDOMIZE TIMER
        sy1 = INT(RND * (30 - 20 + 1) + 20)
        LINE (sx1, sy1)-STEP(-20, 13.3), i
        RANDOMIZE TIMER
        sx2 = INT(RND * (150 - 140 + 1) + 140)
        RANDOMIZE TIMER
        sy2 = INT(RND * (43.3 - 33.3 + 1) + 33.3)
        LINE (sx2, sy2)-STEP(20, 13.4), i
        RANDOMIZE TIMER
        sx3 = INT(RND * (170 - 160 + 1) + 160)
        RANDOMIZE TIMER
        sy3 = INT(RND * (56.7 - 46.7 + 1) + 46.7)
        LINE (sx3, sy3)-STEP(-20, 13.3), i
t:
        i = CINT(i0)
        RANDOMIZE TIMER
        tx1 = INT(RND * (205 - 175 + 1) + 175)
        RANDOMIZE TIMER
        ty1 = INT(RND * (25 - 20 + 1) + 20)
        LINE (tx1, ty1)-STEP(0, 5), i
        RANDOMIZE TIMER
        tx2 = INT(RND * (195 - 185 + 1) + 185)
        RANDOMIZE TIMER
        ty2 = INT(RND * (40 - 30 + 1) + 30)
        LINE (tx2, ty2)-STEP(0, 30), i
o:
        i = CINT(i0)
        RANDOMIZE TIMER
        ox1 = INT(RND * (222.5 - 227.5 + 1) + 227.5)
        RANDOMIZE TIMER
        oy1 = INT(RND * (45 - 45 + 1) + 45)
        CIRCLE (ox1, oy1), 25, i, , , 2
r2:
        i = CINT(i0)
        RANDOMIZE TIMER
        r2x1 = INT(RND * (255 - 245 + 1) + 245)
        RANDOMIZE TIMER
        r2y1 = INT(RND * (60 - 20 + 1) + 20)
        LINE (r2x1, r2y1)-STEP(0, 10), i
        RANDOMIZE TIMER
        r2x2 = INT(RND * (265 - 255 + 1) + 255)
        RANDOMIZE TIMER
        r2y2 = INT(RND * (25 - 20 + 1) + 20)
        LINE (r2x2, r2y2)-STEP(10, 10), i
        RANDOMIZE TIMER
        r2x3 = INT(RND * (275 - 265 + 1) + 265)
        RANDOMIZE TIMER
        r2y3 = INT(RND * (40 - 35 + 1) + 35)
        LINE (r2x3, r2y3)-STEP(-10, 10), i
        RANDOMIZE TIMER
        r2x4 = INT(RND * (265 - 255 + 1) + 255)
        RANDOMIZE TIMER
        r2y4 = INT(RND * (60 - 50 + 1) + 50)
        LINE (r2x4, r2y4)-STEP(10, 10), i
m:
        i = CINT(i0)
        RANDOMIZE TIMER
        mx1 = INT(RND * (290 - 280 + 1) + 280)
        RANDOMIZE TIMER
        my1 = INT(RND * (60 - 20 + 1) + 20)
        LINE (mx1, my1)-STEP(0, 10), i
        RANDOMIZE TIMER
        mx2 = INT(RND * (290 - 285 + 1) + 285)
        RANDOMIZE TIMER
        my2 = INT(RND * (30 - 20 + 1) + 20)
        LINE (mx2, my2)-STEP(10, 5), i
        RANDOMIZE TIMER
        mx3 = INT(RND * (300 - 295 + 1) + 295)
        RANDOMIZE TIMER
        my3 = INT(RND * (35 - 25 + 1) + 25)
        LINE (mx3, my3)-STEP(10, -5), i
        RANDOMIZE TIMER
        mx4 = INT(RND * (320 - 310 + 1) + 310)
        RANDOMIZE TIMER
        my4 = INT(RND * (60 - 20 + 1) + 20)
        LINE (mx4, my4)-STEP(0, 10), i
NEXT
WINDOW
TIMER ON
time1 = TIMER
DO
        time2 = TIMER
        RANDOMIZE TIMER
        pal1 = INT(RND * (63 - 1 + 1) + 1)
        RANDOMIZE TIMER
        pal2 = INT(RND * (63 - 1 + 1) + 1)
        PALETTE pal1, pal2
        IF time2 - time1 > 30 THEN EXIT DO:
LOOP WHILE INKEY$ = ""
fade2 = 64
DO
        fade2 = fade2 - 16
        fade = fade2
        FOR fader = 63 TO 0 STEP -1
                colo = fade - 1
                        IF colo < 0 THEN colo = 0:
                PALETTE fader, colo
                fade = fade - 1
        NEXT
LOOP UNTIL fade2 < 0
FOR i = 120 TO 155
        PALETTE i, 0
NEXT
END SUB

