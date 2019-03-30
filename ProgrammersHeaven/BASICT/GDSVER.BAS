DECLARE SUB sidenote ()
DECLARE SUB box ()
DECLARE SUB tetx ()
DECLARE SUB shrink ()
DECLARE SUB shrinker ()
DECLARE SUB shap ()
DECLARE SUB shape ()
DECLARE SUB linec ()
DECLARE SUB lines ()
DECLARE SUB lineb ()
DECLARE SUB screenf ()
DECLARE SUB screens ()
DECLARE SUB screenb ()
DECLARE SUB screenr ()

DO
SCREEN 0
CLS
COLOR 2: PRINT , "   Stress Reliever Program"; "   "; "v 4.47"
COLOR 2: PRINT , "        Programmed by: Matt Arthur"
COLOR 4
LOCATE 5

PRINT "Choose a number, 1-15"
PRINT
PRINT " 1) Disco....."
PRINT " 2) Circles....."
PRINT " 3) Lines....."
PRINT " 4) Disco lines...."
PRINT " 5) Straight lines..."
PRINT " 6) Jumping lines..."
PRINT " 7) Your color choice..."
PRINT " 8) Expanding circle..."
PRINT " 9) Colorful  ex. circle....."
PRINT " 10) Shrinking circle......"
PRINT " 11) Shrinking circle2...."
PRINT " 12) Flashing boxes..."
PRINT " 13) Text......"
PRINT " 14) Quit...."
PRINT " 15) Sidenote..."

LOCATE 23: INPUT "Number ", number%
IF number% = 14 THEN END
CLS

SELECT CASE number%
     CASE 1
    screenr
     CASE 2
    screens
     CASE 3
    screenb
     CASE 4
    screenf
     CASE 5
    lineb
     CASE 6
    lines
     CASE 7
    linec
     CASE 8
    shape
     CASE 9
    shap
     CASE 10
    shrinker
     CASE 11
    shrink
     CASE 12
    box
     CASE 13
    tetx
     CASE 14
    LOCATE 11, 40: PRINT "Bye": LOCATE 12, 20
    CLS
    PRINT "Please remember, this program is public domain, but "
    PRINT , "please do not distribute it without a donation.  Thank you"
    PRINT "               for using it."
    INPUT "Press enter to continue", dummy$
     CASE 15
    sidenote
    INPUT "Press enter to continue", dummy$
END SELECT
IF number% = 14 THEN END
LOOP UNTIL number% = 14

SUB box
INPUT "Please enter the delay (200+ recommended): ", delay%
CLS
SCREEN 13
times% = 0
DO
shade% = INT(RND(1) * 256)
xpos1% = INT(RND(1) * 320)
xpos2% = INT(RND(1) * 320)
ypos1% = INT(RND(1) * 200)
ypos2% = INT(RND(1) * 200)

LINE (xpos1%, ypos1%)-(xpos2%, ypos2%), shade%, BF
IF times% > 100 THEN CLS : times% = 1
times% = times% + 1
FOR j = 1 TO delay%
NEXT j
LOOP UNTIL INKEY$ <> ""
END SUB

SUB lineb
CLS
count% = 0
INPUT "Please enter the delay (150+ recommended): ", delay%
CLS
SCREEN 13
DO
shade% = INT(RND(1) * 256)
xpos1% = INT(RND(1) * 320)
xpos2% = INT(RND(1) * 320)
ypos1% = INT(RND(1) * 200)
ypos2% = INT(RND(1) * 200)

LINE (xpos1%, ypos2%)-(xpos2%, ypos2%), shade%
IF count% > 150 THEN CLS : count% = 0
count% = count% + 1
FOR j = 1 TO 200
NEXT j
LOOP UNTIL INKEY$ <> ""
END SUB

SUB linec
INPUT "Please enter the color the screen saver will display:(1-256) ", shade%
CLS
SCREEN 13
DO
xpos1% = INT(RND(1) * 320)
xpos2% = INT(RND(1) * 320)
ypos1% = INT(RND(1) * 200)
ypos2% = INT(RND(1) * 200)

LINE (xpos1%, ypos2%)-(xpos2%, ypos1%), shade%
IF count% > 100 THEN CLS : count% = 0
count% = count% + 1
FOR j = 1 TO 200
NEXT j
LOOP UNTIL INKEY$ <> ""
END SUB

SUB lines
count% = 0
INPUT "Please enter the delay (200+ recommended):  ", delay%
SCREEN 13
CLS
DO

shade% = INT(RND(1) * 256)
xpos1% = INT(RND(1) * 320)
xpos2% = INT(RND(1) * 320)
ypos1% = INT(RND(1) * 200)
ypos2% = INT(RND(1) * 200)

LINE (xpos1%, ypos2%)-(xpos2%, ypos1%), shade%
IF count% > 100 THEN CLS : count% = 0
count% = count% + 1
FOR j = 1 TO 200
NEXT j
LOOP UNTIL INKEY$ <> ""
END SUB

SUB screenb
CLS
INPUT "Please enter the delay (150-750 recomended)", delay%
SCREEN 13
count% = 0

DO
shade% = INT(RND(1) * 256)
xpos1% = INT(RND(1) * 320)
xpos2% = INT(RND(1) * 320)
ypos1% = INT(RND(1) * 200)
ypos2% = INT(RND(1) * 200)
LINE (xpos1%, ypos1%)-(xpos2%, ypos2%), shade%, B
LINE (xpos2% + 27, ypos2%)-(xpos1%, ypos1% + 26), shade%, B
IF count% > 150 THEN CLS : count% = 0
FOR j = 1 TO delay%
NEXT j
count% = count% + 1
LOOP UNTIL INKEY$ <> ""
END SUB

SUB screenf
INPUT "Please enter delay (750+ recomended): ", delay%
SCREEN 13
count% = 0
CLS
DO
shade% = INT(RND(1) * 256)
tpos1% = INT(RND(1) * 320)
tpos2% = INT(RND(1) * 320)
rpos1% = INT(RND(1) * 200)
rpos2% = INT(RND(1) * 200)
xpos1% = INT(RND(1) * 320)
xpos2% = INT(RND(1) * 320)
ypos1% = INT(RND(1) * 200)
ypos2% = INT(RND(1) * 200)
LINE (xpos1%, ypos1%)-(xpos2%, ypos2%), shade%, B
LINE (xpos2% + 27, ypos2%)-(xpos1%, ypos1% + 26), shade%, B
LINE (tpos1%, rpos2%)-(tpos2%, rpos1%), 0, BF
count% = count% + 1
IF count% > 125 THEN CLS : count% = 0
FOR j = 1 TO delay%
NEXT j
LOOP UNTIL INKEY$ <> ""

END SUB

SUB screenr
CLS
INPUT "Please enter the delay (25+ recomended): ", delay%
SCREEN 13
count% = 0
DO
radis% = INT(RND(1) * 75)
shade% = INT(RND(1) * 256)
xpos1% = INT(RND(1) * 320)
ypos1% = INT(RND(1) * 200)

CIRCLE (xpos1%, ypos1%), radis%, shade%
FOR j = 1 TO delay%
NEXT j
count% = count% + 1
IF count% > 7 THEN CLS : count% = 0

LOOP UNTIL INKEY$ <> ""
END SUB

SUB screens
CLS
INPUT "Please enter the delay (50-300 recomended): ", delay%
SCREEN 13
count% = 0
DO
radis% = INT(RND(1) * 75)
shade% = INT(RND(1) * 256)
xpos% = INT(RND(1) * 320)
ypos% = INT(RND(1) * 200)

CIRCLE (xpos%, ypos%), radis%, shade%
FOR j = 1 TO delay%
NEXT j
count% = count% + 1
IF count% > 200 THEN CLS : count% = 0

LOOP UNTIL INKEY$ <> ""
END SUB

SUB shap
INPUT "Please enter the delay for this subprogram: (77+ recommended): ", delay%
SCREEN 13
radis% = 3
DO
shade1% = INT(RND(1) * 256)
shade2% = INT(RND(1) * 256)
CIRCLE (150, 95), radis%, shade1%
CIRCLE (150, 95), radis% - 2, shade2%
radis% = radis% + 1
IF radis% > 230 THEN CLS : radis% = 3
FOR j = 1 TO delay%
NEXT j
LOOP UNTIL INKEY$ <> ""
END SUB

SUB shape
INPUT "Please enter the color of the circle (1-256): ", shade%
radis% = 2
SCREEN 13
DO
LOCATE 13, 40
CIRCLE (150, 95), radis%, shade%
radis% = radis% + 1
FOR j = 1 TO 200
NEXT j
IF radis% > 230 THEN CLS : radis% = 1
LOOP UNTIL INKEY$ <> ""
END SUB

SUB shrink
CLS
INPUT "Please enter the delay (207+ recommended): ", delay%
CLS
SCREEN 13
radis% = 105
DO
shade% = INT(RND(1) * 256)
xpos% = INT(RND(1) * 250)
ypos% = INT(RND(1) * 250)
CIRCLE (xpos%, ypos%), radis%, shade%
IF radis% < 3 THEN CLS : radis% = 105
radis% = radis% - 1
FOR j = 1 TO delay%
NEXT j
LOOP UNTIL INKEY$ <> ""
END SUB

SUB shrinker
CLS
INPUT "Please enter the delay for this program (77+ recommended): ", delay%
CLS
SCREEN 13
radis% = 205
DO
shade% = INT(RND(1) * 256)
CIRCLE (150, 95), radis%, shade%
IF radis% < 3 THEN CLS : radis% = 205
radis% = radis% - 1
FOR j = 1 TO delay%
NEXT j
LOOP UNTIL INKEY$ <> ""
END SUB

SUB sidenote
LOCATE 8, 30: PRINT "On a side note, the recommendations"
LOCATE 9, 30: PRINT "for delay speeds are only my favorites."
LOCATE 10, 30: PRINT "Your speeds may, and probably will be"
LOCATE 11, 30: PRINT "different.  Just remember, the higher the"
LOCATE 12, 30: PRINT "delay, the slower it goes."

END SUB

SUB tetx
CLS
LOCATE 3, 15: PRINT "This allows you to read about the stress"
LOCATE 4, 15: PRINT "  relief programs before running them."
LOCATE 6
PRINT "#1, the 'disco', is circles flashing a random size and color at"
PRINT "random places.  This clears the screen after a certain number, to"
PRINT "produce the strobe light effect.  This could also be used as a screen"
PRINT "saver."
PRINT
PRINT "#2, the 'circles' is, again, circles a random size and color at"
PRINT "random places.  It too clears the screen, but to prevent the layered"
PRINT "effect.  It too could be used as a screen saver."
PRINT
PRINT "#3, the 'lines' consists of boxes a random size placed at random places"
PRINT "and colors on the screen.  To prevent layering it too clears after a"
PRINT "set number appear.  "
PRINT
PRINT "#4, the 'disco lines' is #3 with no screen eraser.  Instead, randomly"
PRINT "generated black boxes flash over the screen, 'erasing' the colored "
PRINT "boxes"
PRINT
INPUT "Press enter to continue.", dummy$
CLS
LOCATE 3
PRINT "#5, the straight lines, is just that.  Random lines  appear horizont-"
PRINT "ally in random colors.  After a set number, the screen clears."
PRINT
PRINT "#6, the 'jumping lines' is random lines of a random color appearing"
PRINT "randomly on the screen.  It is similar to the Windows screen saver. "
PRINT
PRINT "#7, your color choice, is the jumping lines in a color of your choice."
PRINT "It also allows you to experiment with your favorite color."
PRINT
PRINT "#8, the expanding circle, is a circle that expands in the color "
PRINT "you enter.  It is very relaxing to watch."
PRINT
PRINT "#9, the colorful expanding circle is a circle that grows larger"
PRINT "with random colors and then clears when it reaches a set size."
PRINT
PRINT "#10, the shrinking circle, is simply #9 in reverse.  This is, to me,"
PRINT "relaxing too watch."
PRINT
PRINT "#11, the second shrinking circle, is randomly placed and randomly"
PRINT "colored circles appearing on the screen.  Each circle that is placed"
PRINT "on the screen is one size smaller than the circle before."
PRINT
INPUT "Press enter to continue.", dummy$
CLS : LOCATE 5
PRINT "#12.  You are reading it now."
PRINT
PRINT "#13, Quit, needs no explanation (hopefully)."
PRINT
PRINT "              If you enjoyed this program"
PRINT "or found it useful, please send a donation to the programmer,"
PRINT , , "Matt Arthur"
PRINT , , "6700 Boothe ln"
PRINT , , "Rocheport, Mo"
PRINT , , "65279"
PRINT
PRINT , "I hope you like(d) this program.  I may come out with new versions"
PRINT , "so watch the bulletin boards.  Matt Arthur, programmer at large."


END SUB

