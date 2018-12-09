1 REM                          MISSILE
2 REM                    By Kenneth Green
3 REM             Go click on Run above and then start.
4 REM
5 REM
6 REM
7 REM
8 REM --------------------Program Below--------------------------------------
9 x1 = 0: x2 = 0
10 CLS : SCREEN 0
15 tr = 1
20 PRINT "                   MISSILE"
25 PRINT "                   -------"
30 PRINT : PRINT : PRINT : PRINT "By Kenneth Green"
35 PRINT : PRINT : PRINT "This game lets you type a one": PRINT "number coordinate to lock on and destroy"
36 PRINT "your enemy."
38 PRINT "You can have as many tries as you want,": PRINT "it says your tries after you win."
39 PRINT "To end the game, type 0 as your": PRINT "coordinate.": PRINT "The enemy is in a different": PRINT "spot every time!"
40 INPUT "Press <Enter> to start this game."; go$
45 RANDOMIZE TIMER
50 x1 = RND(1) * 10
55 x2 = RND(1) * 10
60 x3 = x2 * x1 + 130
70 x4 = RND * 200
80 IF x4 < 120 THEN 70
99 SCREEN 1
100 LINE (100, 185)-(109, 150), , BF: REM ***MOUNTAIN***
105 LINE (50, 185)-(60, 170), , B: REM ****YOU****
107 LOCATE 5, 5: PRINT "YOU"
135 LOCATE 5, 20: PRINT "ENEMY"
140 LINE (x3, 180)-(x3 + 5, 185), , B: REM ****ENEMY****
142 LINE (x4, 180)-(x4 + 5, 185), , B: REM ***ENEMY 2***
143 LINE (0, 185)-(300, 185)
145 IF tr = 7 THEN 700
150 LOCATE 1, 1: INPUT "Number between 1 and 300, or 0 to end:"; g
155 IF g = 0 THEN 520
156 FOR tn = 10 TO 46 STEP 2
160 LINE (52, 183)-((g / 2) + 55, 80)
163 SOUND 100 + tn, 1
165 FOR tym = 1 TO 500: NEXT tym
166 LINE ((g / 2) + 55, 80)-(g + 3, 185)
170 LINE (g + 2, 180)-(g + 3, 184), , BF
175 NEXT tn
180 IF g = x3 THEN 500
190 IF g < x3 + 3 AND g > x3 - 3 THEN 500
191 IF g < x4 + 3 AND g > x4 - 3 THEN 500
195 IF g > 49 AND g < 56 THEN 600
200 LOCATE 2, 1: PRINT "Missed"
202 tr = tr + 1
205 FOR tm = 1 TO 60000: NEXT tm
206 LOCATE 2, 1: PRINT "      "
210 SCREEN 2: GOTO 99
500 FOR ex = 1 TO 9: CIRCLE (g + 2, 184), ex: SOUND 100, 1: FOR ti = 1 TO 5000: NEXT ti: NEXT ex
505 FOR m = 1 TO 95000: NEXT m
506 SCREEN 0
510 PRINT "YOU WON. You took "; tr;
515 IF tr = 1 THEN PRINT "try!"
517 IF tr > 1 THEN PRINT "tries."
518 IF tr = 1 THEN PRINT "You are ranked General."
519 IF tr = 2 THEN PRINT "You are ranked Leutenant Commander."
520 IF tr = 3 THEN PRINT "You are ranked First Leutenant."
521 IF tr = 4 THEN PRINT "You are ranked Sargent."
522 IF tr = 5 THEN PRINT "You are ranked Captain."
523 IF tr = 6 THEN PRINT "You are ranked Cadet."
539 INPUT "Do you want to play again(Y/N)"; ag$
530 IF ag$ = "Y" OR ag$ = "y" OR ag$ = "YES" OR ag$ = "Yes" OR ag$ = "yes" THEN 10
550 END
600 FOR ep = 1 TO 8: CIRCLE (53, 182), ep: SOUND 100, 1: FOR ty = 1 TO 7000: NEXT ty: NEXT ep
605 FOR tym = 1 TO 80000: NEXT tym
606 SCREEN 0
610 PRINT "You destroyed yourself."
620 PRINT : PRINT : PRINT
630 INPUT "Again(Y/N)"; an$
640 IF an$ = "y" OR an$ = "yes" OR an$ = "YES" OR an$ = "Y" THEN 10
650 END
700 LINE (x3, 180)-(x3 - 55, 50): LINE (x3 - 55, 50)-(55, 180)
710 LINE (x4, 180)-(x4 - 55, 50): LINE (x4 - 55, 50)-(55, 180)
720 FOR c3 = 1 TO 25: SOUND c3 + 100, 1
730 FOR tm = 1 TO 200: NEXT tm: CIRCLE (55, 180), c3: NEXT c3
740 LOCATE 3, 10: PRINT "The enemies have destroyed your base!"
750 GOTO 539

