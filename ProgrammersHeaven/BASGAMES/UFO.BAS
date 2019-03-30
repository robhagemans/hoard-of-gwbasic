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

COLOR 2
CLS
BEEP
PRINT "                    UFO Escape"
PRINT
PRINT "You have been captured by aliens and must escape their UFO."
PRINT "You can go north, south, east and west."
PRINT
LET room = 1
COLOR 7
1 IF room = 9 THEN GOTO 6
RESTORE 7
7 DATA You are outside your hiber-pod., You are in a long tunnel., There is a giant computer here., There are more hiber-pods here., The walls are covered in a strange alien writing., There are some empty hiber-pods here., There is a flashing red light here.
FOR x = 1 TO room: READ desc$: NEXT x
PRINT
PRINT
PRINT desc$
PRINT "EXITS: "
RESTORE 2
2 DATA 0,0,0,-3,-2,2,0,-3
FOR x = 1 TO room: READ N: NEXT x
IF N <> 0 THEN PRINT "North"
RESTORE 3
3 DATA 3,0,2,2,3,0,0,0
FOR x = 1 TO room: READ S: NEXT x
IF S <> 0 THEN PRINT "South"
RESTORE 4
4 DATA 1,1,0,0,0,1,1,1
FOR x = 1 TO room: READ E: NEXT x
IF E <> 0 THEN PRINT "East"
RESTORE 5
5 DATA 0,-1,-1,0,0,0,-1,-1
FOR x = 1 TO room: READ W: NEXT x
IF W <> 0 THEN PRINT "West"
PRINT
INPUT "Which way do you go"; move$
IF LEFT$(move$, 1) = "N" THEN LET room = room + N
IF LEFT$(move$, 1) = "n" THEN LET room = room + N
IF LEFT$(move$, 1) = "S" THEN LET room = room + S
IF LEFT$(move$, 1) = "s" THEN LET room = room + S
IF LEFT$(move$, 1) = "E" THEN LET room = room + E
IF LEFT$(move$, 1) = "e" THEN LET room = room + E
IF LEFT$(move$, 1) = "W" THEN LET room = room + W
IF LEFT$(move$, 1) = "w" THEN LET room = room + W
IF LEFT$(move$, 1) = "N" AND N = 0 THEN PRINT "I told you that you couldn't go North!"
IF LEFT$(move$, 1) = "n" AND N = 0 THEN PRINT "I told you that you couldn't go North!"
IF LEFT$(move$, 1) = "S" AND S = 0 THEN PRINT "I told you that you couldn't go South!"
IF LEFT$(move$, 1) = "s" AND S = 0 THEN PRINT "I told you that you couldn't go South!"
IF LEFT$(move$, 1) = "E" AND E = 0 THEN PRINT "I told you that you couldn't go East!"
IF LEFT$(move$, 1) = "e" AND E = 0 THEN PRINT "I told you that you couldn't go East!"
IF LEFT$(move$, 1) = "W" AND W = 0 THEN PRINT "I told you that you couldn't go West!"
IF LEFT$(move$, 1) = "w" AND W = 0 THEN PRINT "I told you that you couldn't go West!"
PRINT
GOTO 1
6 CLS
COLOR 14
BEEP
PRINT
PRINT
PRINT "You see a big, red button with BEAM DOWN written on it so you press it..."
PRINT "There is a bright flash of light and suddenly you appear outside the UFO."
PRINT
PRINT "Well done!!! You have escaped the UFO!!!"
PRINT
PRINT
COLOR 7
END

