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
COLOR 14
PRINT "                         *** Virtual Farm ***"
COLOR 2
PRINT "                              Version 1.3"
PRINT
COLOR 7
PRINT " You've just inherited Old McDonald's Virtual Farm, but can you"
PRINT "make enough money to be able to keep the farm and retire?"
PRINT
INPUT "Are you ready to begin"; trash$
LET award = 2060
LET c = 20
LET p = 20
LET s = 200
LET h = 5
LET po = 18
LET f = 800
LET cr = 200
LET date = 2050
1 RANDOMIZE TIMER
CLS
LET cp = INT(RND * 25)
LET pp = INT(RND * 17)
LET sp = INT(RND * 15)
LET hp = INT(RND * 50)
LET pop = INT(RND * 10)
PRINT "You currently have:"
PRINT
PRINT "Date: "; date
PRINT
COLOR 6
PRINT "Cattle: "; c
COLOR 12
PRINT "Pigs: "; p
COLOR 15
PRINT "Sheep: "; s
COLOR 8
PRINT "Horses: "; h
COLOR 9
PRINT "Poultry: "; po
COLOR 7
PRINT "TOTAL: "; c + p + s + h + po
PRINT
PRINT "Credits: "; cr
PRINT "Food cubes: "; f
PRINT
INPUT "Do you wish to see the price lists for animals"; lists$
IF lists$ = "yes" THEN GOTO 2
IF lists$ = "Yes" THEN GOTO 2
IF lists$ = "y" THEN GOTO 2
IF lists$ = "Y" THEN GOTO 2
IF lists$ = "YES" THEN GOTO 2
3 INPUT "How much cattle do you wish to sell"; cs
INPUT "How many pigs do you wish to sell"; ps
INPUT "How many sheep do you wish to sell"; ss
INPUT "How many horses do you wish to sell"; hs
INPUT "How much poultry do you wish to sell"; spo
PRINT
INPUT "Would you like to buy any animals"; buy$
IF buy$ = "yes" THEN GOTO 10
IF buy$ = "YES" THEN GOTO 10
IF buy$ = "Y" THEN GOTO 10
IF buy$ = "y" THEN GOTO 10
11 INPUT "How many food cubes would you like to buy"; fb
LET check = check + 1
IF check > 5 THEN GOTO 4
5 LET c = c - cs + cb
LET p = p - ps + pb
LET s = s - ss + sb
LET h = h - hs + hb
LET po = po - spo + pob
LET f = f + fb
LET cr = cr + (cs * cp) + (ps * pp) + (ss * sp) + (hs * hp) + (spo * pop) - fb - (cb * cp) - (pb * pp) - (sb * sp) - (hb * hp) - (pob * pop)
LET c = c + INT(c / 2)
LET p = p + (INT(p / 2) * 3)
LET s = s + (INT(s / 2) * 2)
LET h = h + INT(h / 2)
LET po = po + (INT(p / 2) * 3)
LET f = f - (c + p + s + h + po) - 1
IF f < c + p + s + h + po THEN GOTO 6
LET cp = 0
LET pp = 0
LET sp = 0
LET hp = 0
LET pop = 0
LET date = date + 1
IF date = award THEN GOTO 7
GOTO 1
2 PRINT "Current prices for farm animals"
PRINT
PRINT "Cow: "; cp
PRINT "Pig: "; pp
PRINT "Sheep: "; sp
PRINT "Horse: "; hp
PRINT "Bird: "; pop
PRINT
GOTO 3
4 LET check = 0
LET BSC = INT(RND * 100)
IF BSC < 75 THEN GOTO 5
CLS
COLOR 4
PRINT "There has been a mad cow disease scare and you must burn all of"
PRINT "your cattle."
LET c = 0
LET cs = 0
LET cb = 0
COLOR 7
GOTO 5
INPUT "Press any key continue"; trash$
6 CLS
COLOR 4
PRINT "You have run out of food cubes and your animals have died."
COLOR 7
END
7 CLS
LET award = award + 10
COLOR 14
PRINT "    -End of Decade Evaulation-"
PRINT
COLOR 7
PRINT "Credits in account: "; cr
PRINT "Total livestock: "; c + s + p + po + h
PRINT "Food cubes: "; f
PRINT
COLOR 14
IF cr > 10000 THEN PRINT "Congratulations! You may retire now if you wish."
COLOR 7
IF cr < 10000 THEN GOTO 8
INPUT "Do you wish to retire now"; retire$
IF retire$ = "yes" THEN GOTO 9
IF retire$ = "YES" THEN GOTO 9
IF retire$ = "Y" THEN GOTO 9
IF retire$ = "y" THEN GOTO 9
8 PRINT "Press any key to return to game"; trash$
GOTO 1
9 END
10 INPUT "How much cattle do you wish to buy"; cb
INPUT "How many pigs do you wish to buy"; pb
INPUT "How many sheep do you wish to buy"; sb
INPUT "How many horses do you wish to buy"; hb
INPUT "How much poultry do you wish to buy"; pob
GOTO 11

