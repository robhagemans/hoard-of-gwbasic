CLS
SCREEN 8
LOCATE 12, 26: PRINT "Welcome to darts version 2.0"
SLEEP 4
LOCATE 12, 20: PRINT "You get 3 shots to hit the center, good luck"
SLEEP 4
LOCATE 12, 13: PRINT "You get random targets, you never get the same, good luck"
SLEEP 4
CLS
LET a = INT(500 * RND(1))
LET b = INT(200 * RND(1))
CIRCLE (a, b), 50, 9
CIRCLE (a, b), 10, 4
CIRCLE (a, b), 100, 2
DRAW "c4U83d166u83r200l400r200"
LET f = a + b
PSET (a, b)
PRINT "enter your 2 angles"
INPUT c, d
PSET (c, d)
BEEP
IF c + d = f THEN PRINT "Nice shot!!!!!!!!!!!!" ELSE PRINT "you missed"
SLEEP 2
CLS
PRINT "try again? (y/n)"
INPUT a$
IF a$ = "n" THEN END
CLS
CIRCLE (a, b), 50, 9
CIRCLE (a, b), 10, 4
CIRCLE (a, b), 100, 2
DRAW "c4U83d166u83r200l400r200"
PSET (a, b)
PSET (c, d)
PRINT "Enter your 2 angles"
INPUT g, h
PSET (g, h)
BEEP
IF g + h = f THEN PRINT "Nice Shot!!!!!!" ELSE PRINT "you missed"
SLEEP 2
CLS
PRINT "try again? (y/n)"
INPUT a$
IF a$ = "n" THEN END
CLS
CIRCLE (a, b), 50, 9
CIRCLE (a, b), 10, 4
CIRCLE (a, b), 100, 2
DRAW "c4U83d166u83r200l400r200"
PSET (a, b)
PSET (g, h)
PSET (c, d)
PRINT "Enter your 2 shots"
INPUT i, j
PSET (i, j)
BEEP
IF i + j = f THEN PRINT "Nice Shot!!!!" ELSE PRINT "Game over you lost"
END

