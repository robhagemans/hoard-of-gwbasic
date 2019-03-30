DECLARE SUB lose ()
DECLARE SUB win ()
CLS
SCREEN 8
LOCATE 12, 26: PRINT "Welcome to Darts version 1.1 "
PLAY "aceecdaed"
CLS
LOCATE 12, 5: PRINT "the object of the game is to hit the exact center!!! you only get 3 shots!"
PLAY "accedd"
2 CLS
CIRCLE (320, 90), 200, 9
CIRCLE (320, 90), 100, 7
CIRCLE (320, 90), 50, 3
CIRCLE (320, 90), 15, 4
CIRCLE (320, 90), 150, 1
DRAW "c4U83d166u83r200l400r200"
LOCATE 1, 1: PRINT "Please enter your 2 angles"
LOCATE 2, 1: INPUT a, b
PSET (a, b)
BEEP
IF a + b = 410 THEN LOCATE 3, 1: PRINT "Nice Shot Ace!!!!!!": PLAY "accede": CALL win
IF a + b <> 410 THEN LOCATE 3, 1: PRINT "You missed!!!!!!":
LOCATE 4, 1: PRINT "ready for your next try? (y/n)"
INPUT a$
IF a$ = "n" THEN END
CLS
CIRCLE (320, 90), 200, 9
CIRCLE (320, 90), 100, 7
CIRCLE (320, 90), 50, 3
CIRCLE (320, 90), 15, 4
CIRCLE (320, 90), 150, 1
DRAW "c4U83d166u83r200l400r200"
PSET (a, b)
LOCATE 1, 1: PRINT "Please enter your 2 angles"
LOCATE 2, 1: INPUT c, d
PSET (c, d)
BEEP
IF c + d = 410 THEN PLAY "accedde": CALL win
IF c + d <> 410 THEN PRINT "you missed try again (y/n)?"
INPUT a$
IF a$ = "n" THEN END
CLS
CIRCLE (320, 90), 200, 9
CIRCLE (320, 90), 100, 7
CIRCLE (320, 90), 50, 3
CIRCLE (320, 90), 15, 4
CIRCLE (320, 90), 150, 1
DRAW "c4U83d166u83r200l400r200"
PSET (a, b)
PSET (c, d)
LOCATE 1, 1: PRINT "Please enter your 2 angles"
LOCATE 2, 1: INPUT e, f
PSET (e, f)
BEEP
IF e + f = 410 THEN PLAY "accedde": CALL win
IF e + f <> 410 THEN PRINT "you missed try again (y/n)?"
INPUT a$
IF a$ = "n" THEN END
LOCATE 3, 1: PRINT "That was your last shot game over!": CALL lose
END

SUB lose
CLS
LOCATE 12, 13: PRINT "You lost, you really need to improve your gaming skill!!!!"
PLAY "<<<<<<<<<<AD"
END SUB

SUB win
CLS
SCREEN 8
LOCATE 12, 22: PRINT "well you hit the center, game over!!!!"
END
END SUB

