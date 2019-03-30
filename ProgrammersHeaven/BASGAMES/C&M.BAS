CLS
PRINT
COLOR 2
PRINT "     ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
PRINT "     บ                         ";
COLOR 30
PRINT "!!! DYNAMO GAMES !!!                       ";
COLOR 2
PRINT "บ   "; ""
PRINT "     ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
PRINT "     ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
PRINT "     บ   ";
COLOR 7
PRINT "This program is freeware so you may use it in any way you want   ";
COLOR 2
PRINT "บ"
PRINT "     ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
PRINT "     ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
PRINT "     บ ";
COLOR 7
PRINT "Dynamo Games was formed by a cross parallel universe collective    ";
COLOR 2
PRINT "บ"
PRINT "     บ ";
COLOR 7
PRINT "mind involving the minds of the Maruis de Carabas, Dr Kurt         ";
COLOR 2
PRINT "บ"
PRINT "     บ ";
COLOR 7
PRINT "Rausenstein, Albert Einstein, Branoch the Barabarian, Sir Lancelot,";
COLOR 2
PRINT "บ"
PRINT "     บ";
COLOR 7
PRINT " DJ Ultimate Peril, Julius Caesar, The Grim Reaper and a teenager   ";
COLOR 2
PRINT "บ"
PRINT "     บ ";
COLOR 7
PRINT "called David Storey.  Dynamo Games produces all sorts of games that";
COLOR 2
PRINT "บ"
PRINT "     บ ";
COLOR 7
PRINT "have been very popular throughout many other parallel universes and";
COLOR 2
PRINT "บ"
PRINT "     บ ";
COLOR 7
PRINT "will hopefully be enjoyed as much here.                            ";
COLOR 2
PRINT "บ"
PRINT "     บ   ";
COLOR 7
PRINT "DG's human representative David Storey can be e-mailed at        ";
COLOR 2
PRINT "บ"
PRINT "     บ            ";
COLOR 7
PRINT "Derek_Storey@compuserve.com                             ";
COLOR 2
PRINT "บ"
PRINT "     บ ";
COLOR 7
PRINT "or the Maruis de Carabas can sometimes be found at the GAMEDEV     ";
COLOR 2
PRINT "บ"
PRINT "     บ ";
COLOR 7
PRINT "forum.                                                             ";
COLOR 2
PRINT "บ"
PRINT "     บ   ";
COLOR 7
PRINT "Please give our programs to all your friends.  We appreciate new ";
COLOR 2
PRINT "บ"
PRINT "     บ ";
COLOR 7
PRINT "ideas and comments.  Enjoy the game!!!                             ";
COLOR 2
PRINT "บ"
PRINT "     ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
DO UNTIL INKEY$ <> ""
LOOP

CLS
BEEP
COLOR 9
PRINT
PRINT "                                  Cat & Mouse!"
PRINT
COLOR 7
INPUT "Would you like instructions (y/n)"; ins$
IF ins$ = "yes" THEN GOTO 1
IF ins$ = "y" THEN GOTO 1
IF ins$ = "Y" THEN GOTO 1
IF ins$ = "YES" THEN GOTO 1
5 RANDOMIZE TIMER
LET mx = INT(RND * 10)
LET my = INT(RND * 10)
LET w1x = INT(RND * 9)
LET w2x = INT(RND * 9)
LET w3x = INT(RND * 9)
LET w4x = INT(RND * 9)
LET w5x = INT(RND * 9)
LET w6x = INT(RND * 9)
LET w7x = INT(RND * 9)
LET w8x = INT(RND * 9)
LET w9x = INT(RND * 9)
LET w1y = INT(RND * 9)
LET w2y = INT(RND * 9)
LET w3y = INT(RND * 9)
LET w4y = INT(RND * 9)
LET w5y = INT(RND * 9)
LET w6y = INT(RND * 9)
LET w7y = INT(RND * 9)
LET w8y = INT(RND * 9)
LET w9y = INT(RND * 9)
LET cx = INT(RND * 10)
LET cy = INT(RND * 10)
LET x1x = INT(RND * 10)
LET x1y = INT(RND * 10)
LET x2x = INT(RND * 10)
LET x2y = INT(RND * 10)
LET x3x = INT(RND * 10)
LET x3y = INT(RND * 10)
LET x4x = INT(RND * 10)
LET x4y = INT(RND * 10)
2 COLOR 10
PRINT "Mouse turn"
LET lmx = mx
LET lmy = my
PRINT "You are in sector ("; mx; ","; my; ")."
INPUT "In which direction would you like to move"; mm$
IF mm$ = "N" THEN LET my = my + 1
IF mm$ = "NE" THEN LET my = my + 1
IF mm$ = "NE" THEN LET mx = mx + 1
IF mm$ = "NW" THEN LET my = my + 1
IF mm$ = "NW" THEN LET mx = mx - 1
IF mm$ = "S" THEN LET my = my - 1
IF mm$ = "SE" THEN LET my = my - 1
IF mm$ = "SE" THEN LET mx = mx + 1
IF mm$ = "SW" THEN LET my = my - 1
IF mm$ = "SW" THEN LET mx = mx - 1
IF mm$ = "E" THEN LET mx = mx + 1
IF mm$ = "W" THEN LET mx = mx - 1
IF mm$ = "n" THEN LET my = my + 1
IF mm$ = "nw" THEN LET my = my + 1
IF mm$ = "nw" THEN LET mx = mx + 1
IF mm$ = "nw" THEN LET my = my + 1
IF mm$ = "nw" THEN LET mx = mx - 1
IF mm$ = "s" THEN LET my = my - 1
IF mm$ = "SE" THEN LET my = my - 1
IF mm$ = "SE" THEN LET mx = mx + 1
IF mm$ = "SW" THEN LET my = my - 1
IF mm$ = "SW" THEN LET mx = mx - 1
IF mm$ = "e" THEN LET mx = mx + 1
IF mm$ = "w" THEN LET mx = mx - 1
IF mx < 0 THEN PRINT "You may go no further West."
IF mx < 0 THEN LET mx = 0
IF mx > 10 THEN PRINT "You may go no further East."
IF mx > 10 THEN LET mx = 10
IF my < 0 THEN PRINT "You may go no further South."
IF my < 0 THEN LET mx = 0
IF my > 10 THEN PRINT "You may go no further North."
IF my > 10 THEN LET mx = 10
IF mx = w1x AND my = w1y THEN GOTO 7
IF mx = w2x AND my = w2y THEN GOTO 7
IF mx = w3x AND my = w3y THEN GOTO 7
IF mx = w4x AND my = w4y THEN GOTO 7
IF mx = w5x AND my = w5y THEN GOTO 7
IF mx = w6x AND my = w6y THEN GOTO 7
IF mx = w7x AND my = w7y THEN GOTO 7
IF mx = w8x AND my = w8y THEN GOTO 7
IF mx = w9x AND my = w9y THEN GOTO 7
IF mx = x1x AND my = x1y THEN GOTO 3
IF mx = x2x AND my = x2y THEN GOTO 3
IF mx = x3x AND my = x3y THEN GOTO 3
IF mx = x4x AND my = x4y THEN GOTO 3
8 PRINT
PRINT
COLOR 11
PRINT "Cat turn"
LET lcx = cx
LET lcy = cy
PRINT "You are in sector ("; cx; ","; cy; ")."
INPUT "In which direction would you like to move"; cm$
PRINT
INPUT "How many sectors"; sec
IF sec > 2 THEN LET sec = 2
IF sec < 1 THEN LET sec = 1
PRINT
IF cm$ = "N" THEN LET cy = cy + sec
IF cm$ = "S" THEN LET cy = cy - sec
IF cm$ = "E" THEN LET cx = cx + sec
IF cm$ = "W" THEN LET cx = cx - sec
IF cm$ = "n" THEN LET cy = cy + sec
IF cm$ = "s" THEN LET cy = cy - sec
IF cm$ = "e" THEN LET cx = cx + sec
IF cm$ = "w" THEN LET cx = cx - sec
IF cx < 0 THEN PRINT "You may go no further West."
IF cx < 0 THEN LET cx = 0
IF cx > 10 THEN PRINT "You may go no further East."
IF cx > 10 THEN LET cx = 10
IF cy < 0 THEN PRINT "You may go no further South."
IF cy < 0 THEN LET cx = 0
IF cy > 10 THEN PRINT "You may go no further North."
IF cy > 10 THEN LET cx = 10
IF cx = mx AND cy = my THEN GOTO 4
IF cx = w1x AND cy = w1y THEN GOTO 6
IF cx = w2x AND cy = w2y THEN GOTO 6
IF cx = w3x AND cy = w3y THEN GOTO 6
IF cx = w4x AND cy = w4y THEN GOTO 6
IF cx = w5x AND cy = w5y THEN GOTO 6
IF cx = w6x AND cy = w6y THEN GOTO 6
IF cx = w7x AND cy = w7y THEN GOTO 6
IF cx = w8x AND cy = w8y THEN GOTO 6
IF cx = w9x AND cy = w9y THEN GOTO 6
GOTO 2
1 COLOR 14
PRINT
PRINT "Cat & Mouse is a two player game where one player plays the cat who is"
PRINT "trying to capture the mouse.  The mouse can only escape by finding one of"
PRINT "four exits in the maze."
PRINT
PRINT "You move using the four signs of the compass rose:"
PRINT
PRINT "                                 N"
PRINT "                                 |"
PRINT "                              W--+--E"
PRINT "                                 |"
PRINT "                                 S"
PRINT
COLOR 11
PRINT "The cat is quicker and may move one or two sectors per turn."
COLOR 10
PRINT "The mouse is more agile and can move NE SE NW and SW."
COLOR 7
PRINT
GOTO 5
3 COLOR 10
BEEP
PRINT "Well done Mouse!!!"
PRINT "You have escaped the maze and the clutches of the cat!"
PRINT
COLOR 14
PRINT "                         !!!!!"
PRINT "                         !   !"
PRINT "                         !   !"
PRINT "                         !   !"
PRINT "                         !!!!!"
PRINT
PRINT "                         !!!!!"
PRINT "                         !!!!!"
COLOR 7
PRINT
END
4 COLOR 11
BEEP
PRINT "Well done Cat!!!"
PRINT "You have caught the mouse and will enjoy a nice mouse sandwhich."
PRINT
COLOR 8
PRINT "                         |"
PRINT "                       --+--"
PRINT "                         |"
PRINT "                         |"
PRINT "                Here lies the mouse."
PRINT "                       R.I.P."
PRINT
COLOR 7
END
7 BEEP
PRINT "Sorry, there's a wall in your way!"
LET my = lmy
LET mx = lmx
GOTO 8
6 BEEP
PRINT "Sorry, there's a wall in your way!"
LET my = lmy
LET mx = lmx
GOTO 2

