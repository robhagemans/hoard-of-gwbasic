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
PRINT "                 *** Virtual Exploration ***"
PRINT
PRINT "Buy ships to find planets to produce fuel to power ships to find"
PRINT "planets to sell to produce money to find cheats to cheat. Got it?"
PRINT
LET ships = 3
LET planets = 1
LET fuel = 20000
LET credits = 2000
1 RANDOMIZE TIMER
PRINT
PRINT "SHIPS: "; ships
PRINT "PLANETS: "; planets
PRINT "FUEL UNITS: "; fuel
PRINT "CREDITS: "; credits
PRINT
INPUT "CHEAT CODE"; cheat$
INPUT "How many planets do you wish to sell"; sp
INPUT "How many fuel units do you wish to sell"; sf
INPUT "How many fuel units do you wish to buy"; bf
INPUT "How many ships do you wish to buy"; bs
IF credits < 0 THEN LET credits = 0
LET planets = planets - sp
LET credits = credits + (sp * 200)
LET fuel = fuel + bf - sf
LET credits = credits - (bf * 2)
LET credits = credits + (sf * 2)
LET ships = ships + bs
LET credits = credits - (bs * 100)
LET ex = 0
IF cheat$ = "able to cheat" THEN LET ships = ships + 100
IF cheat$ = "hacker" THEN LET planets = planets + 100
IF cheat$ = "cheater" THEN LET fuel = fuel + 500000
IF cheat$ = "rich man" THEN LET credits = credits + 500000
IF cheat$ = "research" THEN LET ex = 1000
LET ex = ex + (ships * 10) + 20
IF fuel < (ships * 50) THEN GOTO 2
IF credits < 0 THEN LET credits = 0
3 IF ex >= INT(RND * 30) + 30 THEN GOTO 4
5 LET fuel = fuel + (planets * 100)
IF credits > 5000000 THEN PRINT "CHEAT CODE = able to cheat"
IF fuel > 5000000000# THEN PRINT "CHEAT CODE = rich man"
IF ships > 1000 THEN PRINT "CHEAT CODE = cheater"
IF planets > 1000 THEN PRINT "CHEAT CODE = research"
IF planets > 5000000 THEN GOTO 7
GOTO 1
2 PRINT "You do not have enough fuel."
LET fuel = 0
LET ex = 0
GOTO 3
4 LET find = INT(RND * ships)
PRINT "You have found "; find; " new planets."
LET planets = planets + find
GOTO 5
7 PRINT "WHAT?!?!?!?! You have conquered the entire galaxy!!!"
PRINT "         *** Virtual Congratulations ***"
PRINT
END

