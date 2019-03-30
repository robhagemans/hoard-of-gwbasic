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

1 CLS
PRINT
PRINT
COLOR 14
PRINT "                         ****            ****"
PRINT "                        *               *"
PRINT "                        * hampionship   * hallenge!"
PRINT "                        *               *"
PRINT "                         ****            ****"
PRINT
PRINT "                                 Version 1.6"
PRINT
PRINT
PRINT
COLOR 7
PRINT "PBM Game Simulator"
PRINT "Just follow the on screen instructions to run a game."
PRINT
PRINT
INPUT "What is team number one called"; team1$
INPUT "What is team number two called"; team2$
RANDOMIZE TIMER
PRINT
PRINT
PRINT "Please put in each player's number."
PRINT
LET position$ = "Attack 11"
GOSUB 500
LET aname11$ = name$
LET askill11 = skill
LET aanger11 = anger
LET position$ = "Attack 21"
GOSUB 500
LET aname21$ = name$
LET askill21 = skill
LET aanger21 = anger
LET position$ = "Attack 31"
GOSUB 500
LET aname31$ = name$
LET askill31 = skill
LET aanger31 = anger
LET position$ = "Mid-field 11"
GOSUB 500
LET mname11$ = name$
LET mskill11 = skill
LET manger11 = anger
LET position$ = "Mid-field 21"
GOSUB 500
LET mname21$ = name$
LET mskill21 = skill
LET manger21 = anger
LET position$ = "Mid-field 31"
GOSUB 500
LET mname31$ = name$
LET mskill31 = skill
LET manger31 = anger
LET position$ = "Mid-field 41"
GOSUB 500
LET mname41$ = name$
LET mskill41 = skill
LET manger41 = anger
LET position$ = "Mid-field 51"
GOSUB 500
LET mname51$ = name$
LET mskill51 = skill
LET manger51 = anger
LET position$ = "Defence 11"
GOSUB 500
LET dname11$ = name$
LET dskill11 = skill
LET danger11 = anger
LET position$ = "Defence 21"
GOSUB 500
LET dname21$ = name$
LET dskill21 = skill
LET danger21 = anger
LET position$ = "Goals"
GOSUB 500
LET gname11$ = name$
LET gskill11 = skill
LET ganger11 = anger
LET position$ = "Attack 12"
GOSUB 500
LET aname12$ = name$
LET askill12 = skill
LET aanger12 = anger
LET position$ = "Attack 22"
GOSUB 500
LET aname22$ = name$
LET askill22 = skill
LET aanger22 = anger
LET position$ = "Attack 32"
GOSUB 500
LET aname32$ = name$
LET askill32 = skill
LET aanger32 = anger
GOSUB 500
LET position$ = "Mid-field 12"
GOSUB 500
LET mname12$ = name$
LET mskill12 = skill
LET manger12 = anger
LET position$ = "Mid-field 22"
GOSUB 500
LET mname22$ = name$
LET mskill22 = skill
LET manger22 = anger
LET position$ = "Mid-field 32"
GOSUB 500
LET mname32$ = name$
LET mskill32 = skill
LET manger32 = anger
LET position$ = "Mid-field 42"
GOSUB 500
LET mname42$ = name$
LET mskill42 = skill
LET manger42 = anger
LET position$ = "Mid-field 52"
GOSUB 500
LET mname52$ = name$
LET mskill52 = skill
LET manger52 = anger
LET position$ = "Defence 11"
GOSUB 500
LET dname12$ = name$
LET dskill12 = skill
LET danger12 = anger
LET position$ = "Defence 21"
GOSUB 500
LET dname22$ = name$
LET dskill22 = skill
LET danger22 = anger
LET position$ = "Goals"
GOSUB 500
LET gname12$ = name$
LET gskill12 = skill
LET ganger12 = anger
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT "The Game:"
PRINT
PRINT team1$; " vs "; team2$
PRINT
IF INT(RND * 50) + mskill41 > mskill12 + INT(RND * 50) AND askill11 + INT(RND * 50) + mskill51 > dskill12 + INT(RND * 50) AND askill11 + INT(RND * 50) + mskill41 > dskill22 AND askill11 + INT(RND * 50) > gskill12 THEN LET mscore11 = mscore11 + 1
IF INT(RND * 50) + mskill51 > mskill22 + INT(RND * 50) AND askill21 + INT(RND * 50) + mskill41 > dskill12 + INT(RND * 50) AND askill21 + INT(RND * 50) + mskill51 > dskill22 AND askill21 + INT(RND * 50) > gskill12 THEN LET mscore21 = mscore21 + 1
IF INT(RND * 50) + mskill41 > mskill32 + INT(RND * 50) AND askill31 + INT(RND * 50) + mskill51 > dskill12 + INT(RND * 50) AND askill31 + INT(RND * 50) + mskill41 > dskill22 AND askill31 + INT(RND * 50) > gskill12 THEN LET mscore31 = mscore31 + 1
IF INT(RND * 50) + mskill52 > mskill11 + INT(RND * 50) AND askill12 + INT(RND * 50) + mskill42 > dskill11 + INT(RND * 50) AND askill12 + INT(RND * 50) + mskill52 > dskill21 AND askill12 + INT(RND * 50) > gskill11 THEN LET mscore12 = mscore12 + 1
IF INT(RND * 50) + mskill42 > mskill21 + INT(RND * 50) AND askill22 + INT(RND * 50) + mskill52 > dskill11 + INT(RND * 50) AND askill22 + INT(RND * 50) + mskill42 > dskill21 AND askill22 + INT(RND * 50) > gskill11 THEN LET mscore22 = mscore22 + 1
IF INT(RND * 50) + mskill52 > mskill31 + INT(RND * 50) AND askill32 + INT(RND * 50) + mskill42 > dskill11 + INT(RND * 50) AND askill32 + INT(RND * 50) + mskill52 > dskill21 AND askill32 + INT(RND * 50) > gskill11 THEN LET mscore32 = mscore32 + 1
IF INT(RND * 50) + mskill41 > mskill12 + INT(RND * 50) AND askill11 + INT(RND * 50) + mskill51 > dskill12 + INT(RND * 50) AND askill11 + INT(RND * 50) + mskill41 > dskill22 AND askill11 + INT(RND * 50) > gskill12 THEN LET mscore11 = mscore11 + 1
IF INT(RND * 50) + mskill51 > mskill22 + INT(RND * 50) AND askill21 + INT(RND * 50) + mskill41 > dskill12 + INT(RND * 50) AND askill21 + INT(RND * 50) + mskill51 > dskill22 AND askill21 + INT(RND * 50) > gskill12 THEN LET mscore21 = mscore21 + 1
IF INT(RND * 50) + mskill41 > mskill32 + INT(RND * 50) AND askill31 + INT(RND * 50) + mskill51 > dskill12 + INT(RND * 50) AND askill31 + INT(RND * 50) + mskill41 > dskill22 AND askill31 + INT(RND * 50) > gskill12 THEN LET mscore31 = mscore31 + 1
IF INT(RND * 50) + mskill52 > mskill11 + INT(RND * 50) AND askill12 + INT(RND * 50) + mskill42 > dskill11 + INT(RND * 50) AND askill12 + INT(RND * 50) + mskill52 > dskill21 AND askill12 + INT(RND * 50) > gskill11 THEN LET mscore12 = mscore12 + 1
IF INT(RND * 50) + mskill42 > mskill21 + INT(RND * 50) AND askill22 + INT(RND * 50) + mskill52 > dskill11 + INT(RND * 50) AND askill22 + INT(RND * 50) + mskill42 > dskill21 AND askill22 + INT(RND * 50) > gskill11 THEN LET mscore22 = mscore22 + 1
IF INT(RND * 50) + mskill52 > mskill31 + INT(RND * 50) AND askill32 + INT(RND * 50) + mskill42 > dskill11 + INT(RND * 50) AND askill32 + INT(RND * 50) + mskill52 > dskill21 AND askill32 + INT(RND * 50) > gskill11 THEN LET mscore32 = mscore32 + 1
IF aanger11 > INT(RND * 100) - (ascore12) THEN LET ahack11 = 1
IF aanger21 > INT(RND * 100) - (ascore22) THEN LET ahack21 = 1
IF aanger31 > INT(RND * 100) - (ascore32) THEN LET ahack31 = 1
IF aanger12 > INT(RND * 100) - (ascore11) THEN LET ahack12 = 1
IF aanger22 > INT(RND * 100) - (ascore21) THEN LET ahack22 = 1
IF aanger32 > INT(RND * 100) - (ascore31) THEN LET ahack32 = 1
IF manger11 > INT(RND * 100) - (ascore12) THEN LET mhack11 = 1
IF manger21 > INT(RND * 100) - (ascore22) THEN LET mhack21 = 1
IF manger31 > INT(RND * 100) - (ascore32) THEN LET mhack31 = 1
IF manger41 > INT(RND * 100) - (ascore12) THEN LET mhack41 = 1
IF danger11 > INT(RND * 100) - (ascore12) THEN LET dhack11 = 1
IF danger21 > INT(RND * 100) - (ascore22) THEN LET dhack21 = 1
IF danger31 > INT(RND * 100) - (ascore32) THEN LET dhack31 = 1
IF manger12 > INT(RND * 100) - (ascore11) THEN LET mhack12 = 1
IF manger22 > INT(RND * 100) - (ascore21) THEN LET mhack22 = 1
IF manger32 > INT(RND * 100) - (ascore31) THEN LET mhack32 = 1
IF manger42 > INT(RND * 100) - (ascore11) THEN LET mhack42 = 1
IF danger11 > INT(RND * 100) - (ascore12) THEN LET dhack11 = 1
IF danger21 > INT(RND * 100) - (ascore22) THEN LET dhack21 = 1
IF danger12 > INT(RND * 100) - (ascore11) THEN LET dhack12 = 1
IF danger22 > INT(RND * 100) - (ascore21) THEN LET dhack22 = 1
IF danger32 > INT(RND * 100) - (ascore32) THEN LET dhack32 = 1
IF ahack11 = 1 THEN LET askill12 = akill12 - 10
IF ahack11 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET aseen11 = 1
IF ahack21 = 1 THEN LET askill22 = askill22 - 10
IF ahack21 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET aseen21 = 1
IF ahack31 = 1 THEN LET askill32 = askill32 - 10
IF ahack31 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET aseen31 = 1
IF ahack12 = 1 THEN LET askill11 = askill11 - 10
IF ahack12 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET aseen12 = 1
IF ahack22 = 1 THEN LET askill21 = askill21 - 10
IF ahack22 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET aseen22 = 1
IF ahack32 = 1 THEN LET askill31 = askill31 - 10
IF ahack32 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET aseen32 = 1
IF mhack11 = 1 THEN LET askill12 = askill12 - 10
IF mhack11 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET mseen11 = 1
IF mhack21 = 1 THEN LET askill22 = askill22 - 10
IF mhack21 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET mseen21 = 1
IF mhack31 = 1 THEN LET askill32 = askill32 - 10
IF mhack31 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET mseen31 = 1
IF mhack41 = 1 THEN LET askill12 = askill12 - 10
IF mhack41 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET mseen41 = 1
IF mhack52 = 1 THEN LET askill31 = askill31 - 10
IF mhack52 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET mseen51 = 1
IF mhack12 = 1 THEN LET askill11 = mskill11 - 10
IF mhack12 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET mseen12 = 1
IF mhack22 = 1 THEN LET askill21 = askill21 - 10
IF mhack22 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET mseen22 = 1
IF mhack32 = 1 THEN LET askill31 = askill31 - 10
IF mhack32 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET mseen32 = 1
IF mhack42 = 1 THEN LET askill11 = askill11 - 10
IF mhack42 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET mseen42 = 1
IF mhack52 = 1 THEN LET mskill21 = mskill21 - 10
IF mhack52 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET mseen52 = 1
IF dhack11 = 1 THEN LET askill22 = askill22 - 10
IF dhack11 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET dseen11 = 1
IF dhack21 = 1 THEN LET askill22 = askill22 - 10
IF dhack21 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET dseen21 = 1
IF dhack12 = 1 THEN LET askill21 = askill21 - 10
IF dhack12 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET dseen12 = 1
IF dhack22 = 1 THEN LET askill21 = askill21 - 10
IF dhack22 = 1 AND INT(RND * 3) = INT(RND * 3) THEN LET dseen22 = 1
LET askill11 = (askill11 / 3) * 2
LET askill21 = (askill21 / 3) * 2
LET askill31 = (askill31 / 3) * 2
LET askill12 = (askill12 / 3) * 2
LET askill22 = (askill22 / 3) * 2
LET askill32 = (askill32 / 3) * 2
IF INT(RND * 50) + mskill41 > mskill12 + INT(RND * 50) AND askill11 + INT(RND * 50) + mskill51 > dskill12 + INT(RND * 50) AND askill11 + INT(RND * 50) + mskill41 > dskill22 AND askill11 + INT(RND * 50) > gskill12 THEN LET mscore11 = mscore11 + 1
IF INT(RND * 50) + mskill51 > mskill22 + INT(RND * 50) AND askill21 + INT(RND * 50) + mskill41 > dskill12 + INT(RND * 50) AND askill21 + INT(RND * 50) + mskill51 > dskill22 AND askill21 + INT(RND * 50) > gskill12 THEN LET mscore21 = mscore21 + 1
IF INT(RND * 50) + mskill41 > mskill32 + INT(RND * 50) AND askill31 + INT(RND * 50) + mskill51 > dskill12 + INT(RND * 50) AND askill31 + INT(RND * 50) + mskill41 > dskill22 AND askill31 + INT(RND * 50) > gskill12 THEN LET mscore31 = mscore31 + 1
IF INT(RND * 50) + mskill52 > mskill11 + INT(RND * 50) AND askill12 + INT(RND * 50) + mskill42 > dskill11 + INT(RND * 50) AND askill12 + INT(RND * 50) + mskill52 > dskill21 AND askill12 + INT(RND * 50) > gskill11 THEN LET mscore12 = mscore12 + 1
IF INT(RND * 50) + mskill42 > mskill21 + INT(RND * 50) AND askill22 + INT(RND * 50) + mskill52 > dskill11 + INT(RND * 50) AND askill22 + INT(RND * 50) + mskill42 > dskill21 AND askill22 + INT(RND * 50) > gskill11 THEN LET mscore22 = mscore22 + 1
IF INT(RND * 50) + mskill52 > mskill31 + INT(RND * 50) AND askill32 + INT(RND * 50) + mskill42 > dskill11 + INT(RND * 50) AND askill32 + INT(RND * 50) + mskill52 > dskill21 AND askill32 + INT(RND * 50) > gskill11 THEN LET mscore32 = mscore32 + 1
IF aseen11 = 1 THEN LET ascore11 = 0
IF aseen21 = 1 THEN LET ascore21 = 0
IF aseen31 = 1 THEN LET ascore31 = 0
IF aseen12 = 1 THEN LET ascore12 = 0
IF aseen22 = 1 THEN LET ascore22 = 0
IF aseen32 = 1 THEN LET ascore32 = 0
PRINT
LET score1 = ascore11 + ascore21 + ascore31 + mscore11 + mscore21 + mscore31
LET score2 = ascore12 + ascore22 + ascore32 + mscore12 + mscore22 + mscore32
IF score1 < 0 THEN LET score1 = 0
IF score2 < 0 THEN LET score2 = 0
PRINT
PRINT
PRINT team1$; " scorers"
IF ascore11 > 0 THEN PRINT aname11$
IF ascore21 > 0 THEN PRINT aname21$
IF ascore31 > 0 THEN PRINT aname31$
IF mscore11 > 0 THEN PRINT mname11$
IF mscore21 > 0 THEN PRINT mname21$
IF mscore31 > 0 THEN PRINT mname31$
PRINT
PRINT team2$; " scorers"
IF ascore12 > 0 THEN PRINT aname12$
IF ascore22 > 0 THEN PRINT aname22$
IF ascore32 > 0 THEN PRINT aname32$
IF mscore12 > 0 THEN PRINT mname12$
IF mscore22 > 0 THEN PRINT mname22$
IF mscore32 > 0 THEN PRINT mname32$
PRINT
PRINT
PRINT
PRINT "Final Score:"
PRINT team1$; score1
PRINT team2$; score2
IF score1 > score2 THEN LET winner = 1
IF score1 < score2 THEN LET winner = 2
IF score1 = score2 THEN LET winner = 0
IF winner = 0 THEN GOTO 4
PRINT
GOTO 3
4 IF askill11 + INT(RND * 50) > gskill12 + INT(RND * 50) THEN LET Penalty1 = 1
IF askill21 + INT(RND * 50) > gskill12 + INT(RND * 50) THEN LET Penalty1 = Penalty1 + 1
IF askill31 + INT(RND * 50) > gskill12 + INT(RND * 50) THEN LET Penalty1 = Penalty1 + 1
IF askill12 + INT(RND * 50) > gskill11 + INT(RND * 50) THEN LET Penalty2 = 1
IF askill22 + INT(RND * 50) > gskill11 + INT(RND * 50) THEN LET Penalty2 = Penalty2 + 1
IF askill32 + INT(RND * 50) > gskill11 + INT(RND * 50) THEN LET Penalty2 = Penalty2 + 1
IF Penalty1 > Penalty2 THEN LET winner = 1
IF Penalty1 > Penalty2 THEN LET Penalty = 1
IF Penalty1 < Penalty2 THEN LET winner = 2
IF Penalty1 < Penalty2 THEN LET Penalty = 1
IF Penalty1 = Penalty2 THEN GOTO 4
3 PRINT
IF winner = 1 THEN PRINT team1$; " won";
IF Penalty = 1 AND winner = 1 THEN PRINT " after penalties"
IF winner = 2 THEN PRINT team2$; " won";
IF Penalty = 1 AND winner = 2 THEN PRINT " after penalties"
PRINT
IF asore11 > ascore21 AND ascore11 > ascore31 THEN LET man1$ = aname11$
IF ascore21 > ascore11 AND ascore21 > ascore31 THEN LET man1$ = aname21$
IF ascore31 > ascore21 AND ascore31 > ascore11 THEN LET man1$ = aname31$
IF ascore11 = 0 AND ascore21 = 0 AND ascore31 = 0 THEN LET man1$ = aname21$
PRINT
IF ascore12 > ascore22 AND ascore12 > ascore32 THEN LET man2$ = aname12$
IF ascore22 > ascore12 AND ascore22 > ascore32 THEN LET man2$ = aname22$
IF ascore32 > ascore22 AND ascore32 > ascore12 THEN LET man2$ = aname22$
IF ascore12 = 0 AND ascore22 = 0 AND ascore32 = 0 THEN LET man2$ = aname22$
PRINT
PRINT
PRINT
INPUT "Do you want to print a resuls sheet"; sheet$
IF sheet$ = "yes" THEN GOTO 2
IF sheet$ = "YES" THEN GOTO 2
IF sheet$ = "Y" THEN GOTO 2
IF sheet$ = "y" THEN GOTO 2
IF sheet$ = "Yes" THEN GOTO 2
PRINT
PRINT
INPUT "Do you want to run another game"; again$
IF again$ = "yes" THEN GOTO 1
IF again$ = "YES" THEN GOTO 1
IF again$ = "Y" THEN GOTO 1
IF again$ = "y" THEN GOTO 1
IF again$ = "Yes" THEN GOTO 1
END
2 PRINT
PRINT "Check that your printer is turned on."
PRINT
PRINT "Printing..."
PRINT
LPRINT
LPRINT "                         ****            ****"
LPRINT "                        *               *"
LPRINT "                        * hampionship   * hallenge!"
LPRINT "                        *               *"
LPRINT "                         ****            ****"
LPRINT
LPRINT "                                 Version 1.6"
LPRINT
LPRINT
LPRINT "Match report:  "; team1$; " vs "; team2$
LPRINT
IF ascore11 > 0 THEN LPRINT mname11$; " scored "; mscore11;
IF ascore11 = 1 THEN LPRINT " goal for "; team1$
IF ascore11 > 1 THEN LPRINT " goals for "; team1$
IF ascore21 > 0 THEN LPRINT mname21$; " scored "; mscore21;
IF ascore21 = 1 THEN LPRINT " goal for "; team1$
IF ascore21 > 1 THEN LPRINT " goals for "; team1$
IF ascore31 > 0 THEN LPRINT mname31$; " scored "; mscore31;
IF ascore31 = 1 THEN LPRINT " goal for "; team1$
IF ascore31 > 1 THEN LPRINT " goals for "; team1$
IF mscore11 > 0 THEN LPRINT mname11$; " scored "; mscore11;
IF mscore11 = 1 THEN LPRINT " goal for "; team1$
IF mscore11 > 1 THEN LPRINT " goals for "; team1$
IF mscore21 > 0 THEN LPRINT mname21$; " scored "; mscore21;
IF mscore21 = 1 THEN LPRINT " goal for "; team1$
IF mscore21 > 1 THEN LPRINT " goals for "; team1$
IF mscore31 > 0 THEN LPRINT mname31$; " scored "; mscore31;
IF mscore31 = 1 THEN LPRINT " goal for "; team1$
IF mscore31 > 1 THEN LPRINT " goals for "; team1$
IF ascore12 > 0 THEN LPRINT aname12$; " scored "; ascore12;
IF ascore12 = 1 THEN LPRINT " goal for "; team2$
IF ascore12 > 1 THEN LPRINT " goals for "; team2$
IF ascore22 > 0 THEN LPRINT aname22$; " scored "; ascore22;
IF ascore22 = 1 THEN LPRINT " goal for "; team2$
IF ascore22 > 1 THEN LPRINT " goals for "; team2$
IF ascore32 > 0 THEN LPRINT aname32$; " scored "; ascore32;
IF ascore32 = 1 THEN LPRINT " goal for "; team2$
IF ascore32 > 1 THEN LPRINT " goals for "; team2$
IF mscore12 > 0 THEN LPRINT mname12$; " scored "; mscore12;
IF mscore12 = 1 THEN LPRINT " goal for "; team2$
IF mscore12 > 1 THEN LPRINT " goals for "; team2$
IF mscore22 > 0 THEN LPRINT mname22$; " scored "; mscore22;
IF mscore22 = 1 THEN LPRINT " goal for "; team2$
IF mscore22 > 1 THEN LPRINT " goals for "; team2$
IF mscore32 > 0 THEN LPRINT mname32$; " scored "; mscore32;
IF mscore32 = 1 THEN LPRINT " goal for "; team2$
IF mscore32 > 1 THEN LPRINT " goals for "; team2$
LPRINT
IF aseen11 = 1 THEN LPRINT aname11$; " was spotted hacking "; aname12$
IF aseen21 = 1 THEN LPRINT aname21$; " was spotted hacking "; aname22$
IF aseen31 = 1 THEN LPRINT aname31$; " was spotted hacking "; aname32$
IF aseen12 = 1 THEN LPRINT aname12$; " was spotted hacking "; aname11$
IF aseen22 = 1 THEN LPRINT aname22$; " was spotted hacking "; aname21$
IF aseen32 = 1 THEN LPRINT aname32$; " was spotted hacking "; aname31$
IF mseen11 = 1 THEN LPRINT mname11$; " was spotted hacking "; aname12$
IF mseen21 = 1 THEN LPRINT mname21$; " was spotted hacking "; aname22$
IF mseen31 = 1 THEN LPRINT mname31$; " was spotted hacking "; aname32$
IF mseen41 = 1 THEN LPRINT mname41$; " was spotted hacking "; aname42$
IF mseen51 = 1 THEN LPRINT mname51$; " was spotted hacking "; aname52$
IF mseen12 = 1 THEN LPRINT mname12$; " was spotted hacking "; aname11$
IF mseen22 = 1 THEN LPRINT mname22$; " was spotted hacking "; aname21$
IF mseen32 = 1 THEN LPRINT mname32$; " was spotted hacking "; aname31$
IF mseen42 = 1 THEN LPRINT mname42$; " was spotted hacking "; aname11$
IF mseen52 = 1 THEN LPRINT mname52$; " was spotted hacking "; aname31$
IF dseen11 = 1 THEN LPRINT dname11$; " was spotted hacking "; aname21$
IF dseen21 = 1 THEN LPRINT dname21$; " was spotted hacking "; aname21$
IF dseen12 = 1 THEN LPRINT dname12$; " was spotted hacking "; aname22$
IF dseen22 = 1 THEN LPRINT dname22$; " was spotted hacking "; aname22$
LPRINT
LPRINT
LPRINT "Final Score:"
LPRINT team1$; "   "; score1
LPRINT team2$; "   "; score2
LPRINT
IF winner = 1 THEN LPRINT team1$; " won";
IF Penalty = 1 AND winner = 1 THEN LPRINT " after penalties"
IF winner = 2 THEN LPRINT team2$; " won";
IF Penalty = 1 AND winner = 2 THEN LPRINT " after penalties"
LPRINT
LPRINT
LPRINT team1$; "'s man of the match was "; man1$
LPRINT team2$; "'s man of the match was "; man2$
LPRINT
LPRINT
LPRINT
PRINT
INPUT "Would you like another results sheet printed out"; more$
IF more$ = "yes" THEN GOTO 2
IF more$ = "YES" THEN GOTO 2
IF more$ = "Y" THEN GOTO 2
IF more$ = "y" THEN GOTO 2
IF more$ = "Yes" THEN GOTO 2
END
500 PRINT
PRINT position$
INPUT number
PRINT
IF number = 1 THEN LET name$ = "R Douglas"
IF number = 1 THEN LET skill = 75
IF number = 1 THEN LET anger = 10
IF number = 2 THEN LET name$ = "I Couty"
IF number = 2 THEN LET skill = 75
IF number = 2 THEN LET anger = 10
IF number = 3 THEN LET name$ = "B Whittaker"
IF number = 3 THEN LET skill = 75
IF number = 3 THEN LET anger = 10
IF number = 4 THEN LET name$ = "S Walker"
IF number = 4 THEN LET skill = 75
IF number = 4 THEN LET anger = 10
IF number = 5 THEN LET name$ = "P Garside"
IF number = 5 THEN LET skill = 75
IF number = 5 THEN LET anger = 10
IF number = 6 THEN LET name$ = "N Clatton"
IF number = 6 THEN LET skill = 75
IF number = 6 THEN LET anger = 10
IF number = 7 THEN LET name$ = "P Alnoman"
IF number = 7 THEN LET skill = 75
IF number = 7 THEN LET anger = 10
IF number = 8 THEN LET name$ = "R Hopper"
IF number = 8 THEN LET skill = 75
IF number = 8 THEN LET anger = 10
IF number = 9 THEN LET name$ = "D Walker"
IF number = 9 THEN LET skill = 75
IF number = 9 THEN LET anger = 10
IF number = 10 THEN LET name$ = "J Glondinnine"
IF number = 10 THEN LET skill = 75
IF number = 10 THEN LET anger = 10
IF number = 11 THEN LET name$ = "G Lerwill"
IF number = 11 THEN LET skill = 75
IF number = 11 THEN LET anger = 10
IF number = 12 THEN LET name$ = "M Sefton"
IF number = 12 THEN LET skill = 75
IF number = 12 THEN LET anger = 10
IF number = 13 THEN LET name$ = "D Griggs"
IF number = 13 THEN LET skill = 75
IF number = 13 THEN LET anger = 10
IF number = 14 THEN LET name$ = "M Lobban"
IF number = 14 THEN LET skill = 75
IF number = 14 THEN LET anger = 10
IF number = 15 THEN LET name$ = "M Bannister"
IF number = 15 THEN LET skill = 75
IF number = 15 THEN LET anger = 10
IF number = 16 THEN LET name$ = "D Trethewey"
IF number = 16 THEN LET skill = 75
IF number = 16 THEN LET anger = 10
IF number = 17 THEN LET name$ = "J Simmons"
IF number = 17 THEN LET skill = 75
IF number = 17 THEN LET anger = 10
IF number = 18 THEN LET name$ = "J Tily"
IF number = 18 THEN LET skill = 75
IF number = 18 THEN LET anger = 10
IF number = 19 THEN LET name$ = "H McLintock"
IF number = 19 THEN LET skill = 75
IF number = 19 THEN LET anger = 10
IF number = 20 THEN LET name$ = "D Hart"
IF number = 20 THEN LET skill = 75
IF number = 20 THEN LET anger = 10
IF number = 21 THEN LET name$ = "D Foster"
IF number = 21 THEN LET skill = 75
IF number = 21 THEN LET anger = 10
IF number = 22 THEN LET name$ = "C Beck"
IF number = 22 THEN LET skill = 75
IF number = 22 THEN LET anger = 10
IF number = 23 THEN LET name$ = "A Bennett"
IF number = 23 THEN LET skill = 75
IF number = 23 THEN LET anger = 10
IF number = 24 THEN LET name$ = "R Honey"
IF number = 24 THEN LET skill = 75
IF number = 24 THEN LET anger = 10
IF number = 25 THEN LET name$ = "A Spezght"
IF number = 25 THEN LET skill = 75
IF number = 25 THEN LET anger = 10
IF number = 26 THEN LET name$ = "G Hollindale"
IF number = 26 THEN LET skill = 75
IF number = 26 THEN LET anger = 10
IF number = 27 THEN LET name$ = "A Beavis"
IF number = 27 THEN LET skill = 75
IF number = 27 THEN LET anger = 10
IF number = 28 THEN LET name$ = "J Kitchin"
IF number = 28 THEN LET skill = 75
IF number = 28 THEN LET anger = 10
IF number = 29 THEN LET name$ = "G Lawrence"
IF number = 29 THEN LET skill = 75
IF number = 29 THEN LET anger = 10
IF number = 30 THEN LET name$ = "A Samules"
IF number = 30 THEN LET skill = 75
IF number = 30 THEN LET anger = 10
IF number = 31 THEN LET name$ = "I Hollindale"
IF number = 31 THEN LET skill = 75
IF number = 31 THEN LET anger = 10
IF number = 32 THEN LET name$ = "J Jones"
IF number = 32 THEN LET skill = 75
IF number = 32 THEN LET anger = 10
IF number = 33 THEN LET name$ = "G Pinto"
IF number = 33 THEN LET skill = 75
IF number = 33 THEN LET anger = 10
IF number = 34 THEN LET name$ = "J Simpson"
IF number = 34 THEN LET skill = 75
IF number = 34 THEN LET anger = 10
IF number = 35 THEN LET name$ = "N Elkin"
IF number = 35 THEN LET skill = 75
IF number = 35 THEN LET anger = 10
IF number = 36 THEN LET name$ = "T Ackroyd"
IF number = 36 THEN LET skill = 75
IF number = 36 THEN LET anger = 10
IF number = 37 THEN LET name$ = "T Crane"
IF number = 37 THEN LET skill = 75
IF number = 37 THEN LET anger = 10
IF number = 38 THEN LET name$ = "M Aitken"
IF number = 38 THEN LET skill = 75
IF number = 38 THEN LET anger = 10
IF number = 39 THEN LET name$ = "R Wadey"
IF number = 39 THEN LET skill = 75
IF number = 39 THEN LET anger = 10
IF number = 40 THEN LET name$ = "T Jefferson"
IF number = 40 THEN LET skill = 75
IF number = 40 THEN LET anger = 10
IF number = 41 THEN LET name$ = "E Barber"
IF number = 41 THEN LET skill = 75
IF number = 41 THEN LET anger = 10
IF number = 42 THEN LET name$ = "T Jason"
IF number = 42 THEN LET skill = 75
IF number = 42 THEN LET anger = 10
IF number = 43 THEN LET name$ = "M Rerts"
IF number = 43 THEN LET skill = 75
IF number = 43 THEN LET anger = 10
IF number = 44 THEN LET name$ = "M Machin"
IF number = 44 THEN LET skill = 75
IF number = 44 THEN LET anger = 10
IF number = 45 THEN LET name$ = "F Wadey"
IF number = 45 THEN LET skill = 75
IF number = 45 THEN LET anger = 10
IF number = 46 THEN LET name$ = "M Tworth"
IF number = 46 THEN LET skill = 75
IF number = 46 THEN LET anger = 10
IF number = 47 THEN LET name$ = "P Brown"
IF number = 47 THEN LET skill = 75
IF number = 47 THEN LET anger = 10
IF number = 48 THEN LET name$ = "A Barker"
IF number = 48 THEN LET skill = 75
IF number = 48 THEN LET anger = 10
IF number = 49 THEN LET name$ = "H Binns"
IF number = 49 THEN LET skill = 75
IF number = 49 THEN LET anger = 10
IF number = 50 THEN LET name$ = "T Land"
IF number = 50 THEN LET skill = 75
IF number = 50 THEN LET anger = 10
IF number = 51 THEN LET name$ = "A Barber"
IF number = 51 THEN LET skill = 75
IF number = 51 THEN LET anger = 10
IF number = 52 THEN LET name$ = "C Cooper"
IF number = 52 THEN LET skill = 75
IF number = 52 THEN LET anger = 10
IF number = 53 THEN LET name$ = "A Inkley"
IF number = 53 THEN LET skill = 75
IF number = 53 THEN LET anger = 10
IF number = 54 THEN LET name$ = "A Read"
IF number = 54 THEN LET skill = 75
IF number = 54 THEN LET anger = 10
IF number = 55 THEN LET name$ = "N Hall"
IF number = 55 THEN LET skill = 75
IF number = 55 THEN LET anger = 10
IF number = 56 THEN LET name$ = "D Maiden"
IF number = 56 THEN LET skill = 75
IF number = 56 THEN LET anger = 10
IF number = 57 THEN LET name$ = "J Edmondson"
IF number = 57 THEN LET skill = 75
IF number = 57 THEN LET anger = 10
IF number = 58 THEN LET name$ = "K Rees"
IF number = 58 THEN LET skill = 75
IF number = 58 THEN LET anger = 10
IF number = 59 THEN LET name$ = "S Buchanan"
IF number = 59 THEN LET skill = 75
IF number = 59 THEN LET anger = 10
IF number = 60 THEN LET name$ = "I Exton"
IF number = 60 THEN LET skill = 75
IF number = 60 THEN LET anger = 10
IF number = 61 THEN LET name$ = "M Chamberlain"
IF number = 61 THEN LET skill = 75
IF number = 61 THEN LET anger = 10
IF number = 62 THEN LET name$ = "R Martin"
IF number = 62 THEN LET skill = 75
IF number = 62 THEN LET anger = 10
IF number = 63 THEN LET name$ = "J Page"
IF number = 63 THEN LET skill = 75
IF number = 63 THEN LET anger = 10
IF number = 64 THEN LET name$ = "A M"
IF number = 64 THEN LET skill = 75
IF number = 64 THEN LET anger = 10
IF number = 65 THEN LET name$ = "R Borer"
IF number = 65 THEN LET skill = 75
IF number = 65 THEN LET anger = 10
IF number = 66 THEN LET name$ = "K Holland"
IF number = 66 THEN LET skill = 75
IF number = 66 THEN LET anger = 10
IF number = 67 THEN LET name$ = "M Page"
IF number = 67 THEN LET skill = 75
IF number = 67 THEN LET anger = 10
IF number = 68 THEN LET name$ = "A Keightley"
IF number = 68 THEN LET skill = 75
IF number = 68 THEN LET anger = 10
IF number = 69 THEN LET name$ = "T Harrison"
IF number = 69 THEN LET skill = 75
IF number = 69 THEN LET anger = 10
IF number = 70 THEN LET name$ = "P Piddleson"
IF number = 70 THEN LET skill = 75
IF number = 70 THEN LET anger = 10
IF number = 71 THEN LET name$ = "M Murray"
IF number = 71 THEN LET skill = 75
IF number = 71 THEN LET anger = 10
IF number = 72 THEN LET name$ = "C Scales"
IF number = 72 THEN LET skill = 75
IF number = 72 THEN LET anger = 10
IF number = 73 THEN LET name$ = "A Chima"
IF number = 73 THEN LET skill = 75
IF number = 73 THEN LET anger = 10
IF number = 74 THEN LET name$ = "B Hollindale"
IF number = 74 THEN LET skill = 75
IF number = 74 THEN LET anger = 10
IF number = 75 THEN LET name$ = "G Gamblin"
IF number = 75 THEN LET skill = 75
IF number = 75 THEN LET anger = 10
IF number = 76 THEN LET name$ = "T Strom"
IF number = 76 THEN LET skill = 75
IF number = 76 THEN LET anger = 10
IF number = 77 THEN LET name$ = "M Morton"
IF number = 77 THEN LET skill = 70
IF number = 77 THEN LET anger = 10
IF number = 78 THEN LET name$ = "D Morton"
IF number = 78 THEN LET skill = 75
IF number = 78 THEN LET anger = 10
IF number = 79 THEN LET name$ = "D Lindsay"
IF number = 79 THEN LET skill = 75
IF number = 79 THEN LET anger = 10
IF number = 80 THEN LET name$ = "C Chapman"
IF number = 80 THEN LET skill = 75
IF number = 80 THEN LET anger = 10
IF number = 81 THEN LET name$ = "G Stone"
IF number = 81 THEN LET skill = 75
IF number = 81 THEN LET anger = 10
IF number = 82 THEN LET name$ = "N Glendinning"
IF number = 82 THEN LET skill = 75
IF number = 82 THEN LET anger = 10
IF number = 83 THEN LET name$ = "A Owens"
IF number = 83 THEN LET skill = 75
IF number = 83 THEN LET anger = 10
IF number = 84 THEN LET name$ = "A Hicks"
IF number = 84 THEN LET skill = 75
IF number = 84 THEN LET anger = 10
IF number = 85 THEN LET name$ = "D Reader"
IF number = 85 THEN LET skill = 75
IF number = 85 THEN LET anger = 10
IF number = 86 THEN LET name$ = "L Cooksey"
IF number = 86 THEN LET skill = 75
IF number = 86 THEN LET anger = 10
IF number = 87 THEN LET name$ = "I Wright"
IF number = 87 THEN LET skill = 75
IF number = 87 THEN LET anger = 10
IF number = 88 THEN LET name$ = "A Earnes"
IF number = 88 THEN LET skill = 75
IF number = 88 THEN LET anger = 10
IF number = 89 THEN LET name$ = "J Pinder"
IF number = 89 THEN LET skill = 75
IF number = 89 THEN LET anger = 10
IF number = 90 THEN LET name$ = "M Beavis"
IF number = 90 THEN LET skill = 75
IF number = 90 THEN LET anger = 10
IF number = 91 THEN LET name$ = "T Forsyth"
IF number = 91 THEN LET skill = 75
IF number = 91 THEN LET anger = 10
IF number = 92 THEN LET name$ = "G Nilsson"
IF number = 92 THEN LET skill = 75
IF number = 92 THEN LET anger = 10
IF number = 93 THEN LET name$ = "A Atmore"
IF number = 93 THEN LET skill = 75
IF number = 93 THEN LET anger = 10
IF number = 94 THEN LET name$ = "B Smith"
IF number = 94 THEN LET skill = 75
IF number = 94 THEN LET anger = 10
IF number = 95 THEN LET name$ = "P Denne"
IF number = 95 THEN LET skill = 75
IF number = 95 THEN LET anger = 10
IF number = 96 THEN LET name$ = "A Whitelaw"
IF number = 96 THEN LET skill = 75
IF number = 96 THEN LET anger = 10
IF number = 97 THEN LET name$ = "T Stanley"
IF number = 97 THEN LET skill = 75
IF number = 97 THEN LET anger = 10
IF number = 98 THEN LET name$ = "L Fayers"
IF number = 98 THEN LET skill = 75
IF number = 98 THEN LET anger = 10
IF number = 99 THEN LET name$ = "G Hughes"
IF number = 99 THEN LET skill = 75
IF number = 99 THEN LET anger = 10
IF number = 100 THEN LET name$ = "D Turner"
IF number = 100 THEN LET skill = 75
IF number = 100 THEN LET anger = 10
IF number = 101 THEN LET name$ = "M Kane"
IF number = 101 THEN LET skill = 75
IF number = 101 THEN LET anger = 10
IF number = 102 THEN LET name$ = "M Alton"
IF number = 102 THEN LET skill = 75
IF number = 102 THEN LET anger = 10
IF number = 103 THEN LET name$ = "J Dent"
IF number = 103 THEN LET skill = 75
IF number = 103 THEN LET anger = 10
IF number = 104 THEN LET name$ = "P Alnoman"
IF number = 104 THEN LET skill = 75
IF number = 104 THEN LET anger = 10
IF number = 105 THEN LET name$ = "N Foster"
IF number = 105 THEN LET skill = 75
IF number = 105 THEN LET anger = 10
IF number = 106 THEN LET name$ = "J Nesic"
IF number = 106 THEN LET skill = 75
IF number = 106 THEN LET anger = 10
IF number = 107 THEN LET name$ = "R Du Sautoy"
IF number = 107 THEN LET skill = 75
IF number = 107 THEN LET anger = 10
IF number = 108 THEN LET name$ = "D Lomas"
IF number = 108 THEN LET skill = 75
IF number = 108 THEN LET anger = 10
IF number = 109 THEN LET name$ = "D Simmonds"
IF number = 109 THEN LET skill = 75
IF number = 109 THEN LET anger = 10
IF number = 110 THEN LET name$ = "S Wilson"
IF number = 110 THEN LET skill = 75
IF number = 110 THEN LET anger = 10
IF number = 111 THEN LET name$ = "J Kelly"
IF number = 111 THEN LET skill = 75
IF number = 111 THEN LET anger = 10
IF number = 112 THEN LET name$ = "I Miles"
IF number = 112 THEN LET skill = 75
IF number = 112 THEN LET anger = 10
IF number = 113 THEN LET name$ = "J Pattle"
IF number = 113 THEN LET skill = 75
IF number = 113 THEN LET anger = 10
IF number = 114 THEN LET name$ = "S Milner"
IF number = 114 THEN LET skill = 75
IF number = 114 THEN LET anger = 10
IF number = 115 THEN LET name$ = "M Thursby"
IF number = 115 THEN LET skill = 75
IF number = 115 THEN LET anger = 10
IF number = 116 THEN LET name$ = "Jason"
IF number = 116 THEN LET skill = 75
IF number = 116 THEN LET anger = 10
IF number = 117 THEN LET name$ = "Neuhaus"
IF number = 117 THEN LET skill = 75
IF number = 117 THEN LET anger = 10
IF number = 118 THEN LET name$ = "T Stokes"
IF number = 118 THEN LET skill = 75
IF number = 118 THEN LET anger = 10
IF number = 119 THEN LET name$ = "D Taylor"
IF number = 119 THEN LET skill = 75
IF number = 119 THEN LET anger = 10
IF number = 120 THEN LET name$ = "D McDonald"
IF number = 120 THEN LET skill = 75
IF number = 120 THEN LET anger = 10
IF number = 121 THEN LET name$ = "S Griffin"
IF number = 121 THEN LET skill = 75
IF number = 121 THEN LET anger = 4
IF number = 122 THEN LET name$ = "J Lincoln"
IF number = 122 THEN LET skill = 85
IF number = 122 THEN LET anger = 20
IF number = 123 THEN LET name$ = "J Jason"
IF number = 123 THEN LET skill = 60
IF number = 123 THEN LET anger = 40
IF number = 124 THEN LET name$ = "D Kirk"
IF number = 124 THEN LET skill = 53
IF number = 124 THEN LET anger = 10
IF number = 125 THEN LET name$ = "A Desmond"
IF number = 125 THEN LET skill = 90
IF number = 125 THEN LET anger = 34
IF number = 126 THEN LET name$ = "D Henry"
IF number = 126 THEN LET skill = 97
IF number = 126 THEN LET anger = 23
IF number = 127 THEN LET name$ = "E Hanley"
IF number = 127 THEN LET skill = 70
IF number = 127 THEN LET anger = 10
IF number = 128 THEN LET name$ = "D McKay"
IF number = 128 THEN LET skill = 90
IF number = 128 THEN LET anger = 13
IF number = 129 THEN LET name$ = "E King"
IF number = 129 THEN LET skill = 54
IF number = 129 THEN LET anger = 2
IF number = 130 THEN LET name$ = "H Coltie"
IF number = 130 THEN LET skill = 67
IF number = 130 THEN LET anger = 22
IF number = 131 THEN LET name$ = "L Matthews"
IF number = 131 THEN LET skill = 91
IF number = 131 THEN LET anger = 49
IF number = 132 THEN LET name$ = "J Douglas"
IF number = 132 THEN LET skill = 75
IF number = 132 THEN LET anger = 45
IF number = 133 THEN LET name$ = "J Grey"
IF number = 133 THEN LET skill = 73
IF number = 133 THEN LET anger = 20
IF number = 134 THEN LET name$ = "C McAndrews"
IF number = 134 THEN LET skill = 66
IF number = 134 THEN LET anger = 17
IF number = 135 THEN LET name$ = "J Wright"
IF number = 135 THEN LET skill = 84
IF number = 135 THEN LET anger = 23
IF number = 136 THEN LET name$ = "D Bailey"
IF number = 136 THEN LET skill = 87
IF number = 136 THEN LET anger = 33
IF number = 137 THEN LET name$ = "A Arrowsmith"
IF number = 137 THEN LET skill = 77
IF number = 137 THEN LET anger = 39
IF number = 138 THEN LET name$ = "M Thompson"
IF number = 138 THEN LET skill = 80
IF number = 138 THEN LET anger = 23
IF number = 139 THEN LET name$ = "C Ashdown"
IF number = 139 THEN LET skill = 93
IF number = 139 THEN LET anger = 10
IF number = 140 THEN LET name$ = "C Bagshaw"
IF number = 140 THEN LET skill = 76
IF number = 140 THEN LET anger = 13
IF number = 141 THEN LET name$ = "A Baird"
IF number = 141 THEN LET skill = 87
IF number = 141 THEN LET anger = 43
IF number = 142 THEN LET name$ = "A Barr"
IF number = 142 THEN LET skill = 79
IF number = 142 THEN LET anger = 32
IF number = 143 THEN LET name$ = "A Begley"
IF number = 143 THEN LET skill = 95
IF number = 143 THEN LET anger = 43
IF number = 144 THEN LET name$ = "B Caldow"
IF number = 144 THEN LET skill = 65
IF number = 144 THEN LET anger = 12
IF number = 145 THEN LET name$ = "K Cairnie"
IF number = 145 THEN LET skill = 67
IF number = 145 THEN LET anger = 23
IF number = 146 THEN LET name$ = "M Denver"
IF number = 146 THEN LET skill = 87
IF number = 146 THEN LET anger = 32
IF number = 147 THEN LET name$ = "R Donnely"
IF number = 147 THEN LET skill = 91
IF number = 147 THEN LET anger = 23
IF number = 148 THEN LET name$ = "C Edgar"
IF number = 148 THEN LET skill = 67
IF number = 148 THEN LET anger = 31
IF number = 149 THEN LET name$ = "J Dyce"
IF number = 149 THEN LET skill = 82
IF number = 149 THEN LET anger = 20
IF number = 150 THEN LET name$ = "I Durie"
IF number = 150 THEN LET skill = 78
IF number = 150 THEN LET anger = 12
IF number = 151 THEN LET name$ = "A Foxwell"
IF number = 151 THEN LET skill = 78
IF number = 151 THEN LET anger = 43
IF number = 152 THEN LET name$ = "S Forth"
IF number = 152 THEN LET skill = 85
IF number = 152 THEN LET anger = 10
IF number = 153 THEN LET name$ = "J Foster"
IF number = 153 THEN LET skill = 93
IF number = 153 THEN LET anger = 17
IF number = 154 THEN LET name$ = "W Grandison"
IF number = 154 THEN LET skill = 80
IF number = 154 THEN LET anger = 23
IF number = 155 THEN LET name$ = "D Hallybone"
IF number = 155 THEN LET skill = 94
IF number = 155 THEN LET anger = 32
IF number = 156 THEN LET name$ = "D Hogg"
IF number = 156 THEN LET skill = 66
IF number = 156 THEN LET anger = 20
IF number = 157 THEN LET name$ = "P Hollis"
IF number = 157 THEN LET skill = 90
IF number = 157 THEN LET anger = 23
IF number = 158 THEN LET name$ = "G Hood"
IF number = 158 THEN LET skill = 75
IF number = 158 THEN LET anger = 43
IF number = 159 THEN LET name$ = "F Hope"
IF number = 159 THEN LET skill = 75
IF number = 159 THEN LET anger = 17
IF number = 160 THEN LET name$ = "T Hurny"
IF number = 160 THEN LET skill = 67
IF number = 160 THEN LET anger = 24
IF number = 161 THEN LET name$ = "T Husband"
IF number = 161 THEN LET skill = 98
IF number = 161 THEN LET anger = 34
IF number = 162 THEN LET name$ = "J Hutchison"
IF number = 162 THEN LET skill = 76
IF number = 162 THEN LET anger = 23
IF number = 163 THEN LET name$ = "K Jessop"
IF number = 163 THEN LET skill = 75
IF number = 163 THEN LET anger = 38
IF number = 164 THEN LET name$ = "G Douglas"
IF number = 164 THEN LET skill = 89
IF number = 164 THEN LET anger = 23
IF number = 165 THEN LET name$ = "W Kinnell"
IF number = 165 THEN LET skill = 75
IF number = 165 THEN LET anger = 24
IF number = 166 THEN LET name$ = "C Knight"
IF number = 166 THEN LET skill = 57
IF number = 166 THEN LET anger = 12
IF number = 167 THEN LET name$ = "R Campbell"
IF number = 167 THEN LET skill = 87
IF number = 167 THEN LET anger = 12
IF number = 168 THEN LET name$ = "M Miller"
IF number = 168 THEN LET skill = 98
IF number = 168 THEN LET anger = 2
IF number = 169 THEN LET name$ = "R Lambe"
IF number = 169 THEN LET skill = 60
IF number = 169 THEN LET anger = 34
IF number = 170 THEN LET name$ = "D Liggett"
IF number = 170 THEN LET skill = 79
IF number = 170 THEN LET anger = 23
IF number = 171 THEN LET name$ = "B McBeth"
IF number = 171 THEN LET skill = 87
IF number = 171 THEN LET anger = 31
IF number = 172 THEN LET name$ = "J McAnena"
IF number = 172 THEN LET skill = 94
IF number = 172 THEN LET anger = 50
IF number = 173 THEN LET name$ = "R MacBride"
IF number = 173 THEN LET skill = 87
IF number = 173 THEN LET anger = 20
IF number = 174 THEN LET name$ = "T MacDonald"
IF number = 174 THEN LET skill = 63
IF number = 174 THEN LET anger = 10
IF number = 175 THEN LET name$ = "G McKenzie"
IF number = 175 THEN LET skill = 67
IF number = 175 THEN LET anger = 11
IF number = 176 THEN LET name$ = "A McMasters"
IF number = 176 THEN LET skill = 89
IF number = 176 THEN LET anger = 23
IF number = 1177 THEN LET name$ = "M Mathwin"
IF number = 177 THEN LET skill = 76
IF number = 177 THEN LET anger = 7
IF number = 178 THEN LET name$ = "P Miller"
IF number = 178 THEN LET skill = 80
IF number = 178 THEN LET anger = 22
IF number = 179 THEN LET name$ = "N Morrison"
IF number = 179 THEN LET skill = 82
IF number = 179 THEN LET anger = 45
IF number = 180 THEN LET name$ = "K Nesbitt"
IF number = 180 THEN LET skill = 90
IF number = 180 THEN LET anger = 10
IF number = 181 THEN LET name$ = "J Olton"
IF number = 181 THEN LET skill = 67
IF number = 181 THEN LET anger = 32
IF number = 182 THEN LET name$ = "D Philson"
IF number = 182 THEN LET skill = 90
IF number = 182 THEN LET anger = 2
IF number = 183 THEN LET name$ = "D Prince"
IF number = 183 THEN LET skill = 98
IF number = 183 THEN LET anger = 1
IF number = 184 THEN LET name$ = "A Prest"
IF number = 184 THEN LET skill = 72
IF number = 184 THEN LET anger = 3
IF number = 185 THEN LET name$ = "M Ralston"
IF number = 185 THEN LET skill = 91
IF number = 185 THEN LET anger = 34
IF number = 186 THEN LET name$ = "E Quinn"
IF number = 186 THEN LET skill = 86
IF number = 186 THEN LET anger = 43
IF number = 187 THEN LET name$ = "B Raab"
IF number = 187 THEN LET skill = 67
IF number = 187 THEN LET anger = 6
IF number = 188 THEN LET name$ = "A Rait"
IF number = 188 THEN LET skill = 89
IF number = 188 THEN LET anger = 23
IF number = 189 THEN LET name$ = "P Radcliffe"
IF number = 189 THEN LET skill = 85
IF number = 189 THEN LET anger = 23
IF number = 190 THEN LET name$ = "A Rayer"
IF number = 190 THEN LET skill = 90
IF number = 190 THEN LET anger = 9
IF number = 191 THEN LET name$ = "T Rasbash"
IF number = 191 THEN LET skill = 65
IF number = 191 THEN LET anger = 43
IF number = 192 THEN LET name$ = "R Redpath"
IF number = 192 THEN LET skill = 98
IF number = 192 THEN LET anger = 7
IF number = 193 THEN LET name$ = "M Reeve"
IF number = 193 THEN LET skill = 94
IF number = 193 THEN LET anger = 43
IF number = 194 THEN LET name$ = "J Reville"
IF number = 194 THEN LET skill = 84
IF number = 194 THEN LET anger = 40
IF number = 195 THEN LET name$ = "B Sanger"
IF number = 195 THEN LET skill = 75
IF number = 195 THEN LET anger = 23
IF number = 196 THEN LET name$ = "C Sabine"
IF number = 196 THEN LET skill = 55
IF number = 196 THEN LET anger = 43
IF number = 197 THEN LET name$ = "K Singer"
IF number = 197 THEN LET skill = 79
IF number = 197 THEN LET anger = 45
IF number = 198 THEN LET name$ = "D Sherwood"
IF number = 198 THEN LET skill = 90
IF number = 198 THEN LET anger = 23
IF number = 199 THEN LET name$ = "M Shaw"
IF number = 199 THEN LET skill = 60
IF number = 199 THEN LET anger = 34
IF number = 200 THEN LET name$ = "A Smith"
IF number = 200 THEN LET skill = 67
IF number = 200 THEN LET anger = 20
IF number = 201 THEN LET name$ = "S Slyth"
IF number = 201 THEN LET skill = 93
IF number = 201 THEN LET anger = 26
IF number = 202 THEN LET name$ = "H Aitken"
IF number = 202 THEN LET skill = 81
IF number = 202 THEN LET anger = 27
IF number = 203 THEN LET name$ = "H Smith"
IF number = 203 THEN LET skill = 89
IF number = 203 THEN LET anger = 23
IF number = 204 THEN LET name$ = "B Smith"
IF number = 204 THEN LET skill = 91
IF number = 204 THEN LET anger = 43
IF number = 205 THEN LET name$ = "E Spittal"
IF number = 205 THEN LET skill = 75
IF number = 205 THEN LET anger = 12
IF number = 206 THEN LET name$ = "R Spacey"
IF number = 206 THEN LET skill = 86
IF number = 206 THEN LET anger = 37
IF number = 207 THEN LET name$ = "A Spain"
IF number = 207 THEN LET skill = 74
IF number = 207 THEN LET anger = 33
IF number = 208 THEN LET name$ = "J Spinks"
IF number = 208 THEN LET skill = 67
IF number = 208 THEN LET anger = 31
IF number = 209 THEN LET name$ = "G Stewart"
IF number = 209 THEN LET skill = 90
IF number = 209 THEN LET anger = 3
IF number = 210 THEN LET name$ = "S Samson"
IF number = 210 THEN LET skill = 49
IF number = 210 THEN LET anger = 48
IF number = 211 THEN LET name$ = "R Swan"
IF number = 211 THEN LET skill = 70
IF number = 211 THEN LET anger = 23
IF number = 212 THEN LET name$ = "I Todman"
IF number = 212 THEN LET skill = 45
IF number = 212 THEN LET anger = 69
IF number = 213 THEN LET name$ = "D Todd"
IF number = 213 THEN LET skill = 93
IF number = 213 THEN LET anger = 24
IF number = 214 THEN LET name$ = "C Trainer"
IF number = 214 THEN LET skill = 99
IF number = 214 THEN LET anger = 21
IF number = 215 THEN LET name$ = "T Spike"
IF number = 215 THEN LET skill = 90
IF number = 215 THEN LET anger = 23
IF number = 216 THEN LET name$ = "A Walker"
IF number = 216 THEN LET skill = 84
IF number = 216 THEN LET anger = 12
IF number = 217 THEN LET name$ = "W Wood"
IF number = 217 THEN LET skill = 98
IF number = 217 THEN LET anger = 11
IF number = 218 THEN LET name$ = "C Hawks"
IF number = 218 THEN LET skill = 76
IF number = 218 THEN LET anger = 15
IF number = 219 THEN LET name$ = "T Wishart"
IF number = 219 THEN LET skill = 98
IF number = 219 THEN LET anger = 12
IF number = 220 THEN LET name$ = "J Nicholson"
IF number = 220 THEN LET skill = 80
IF number = 220 THEN LET anger = 15
IF number = 221 THEN LET name$ = "G Black"
IF number = 221 THEN LET skill = 76
IF number = 221 THEN LET anger = 24
IF number = 222 THEN LET name$ = "J Cleese"
IF number = 222 THEN LET skill = 75
IF number = 222 THEN LET anger = 35
IF number = 223 THEN LET name$ = "N Bayard"
IF number = 223 THEN LET skill = 65
IF number = 223 THEN LET anger = 2
IF number = 224 THEN LET name$ = "P Growther"
IF number = 224 THEN LET skill = 64
IF number = 224 THEN LET anger = 45
IF number = 210 THEN LET name$ = "A Perkins"
IF number = 210 THEN LET skill = 50
IF number = 210 THEN LET anger = 18
IF number = 226 THEN LET name$ = "R Hyde"
IF number = 226 THEN LET skill = 66
IF number = 226 THEN LET anger = 30
IF number = 227 THEN LET name$ = "H Wilson"
IF number = 227 THEN LET skill = 45
IF number = 227 THEN LET anger = 40
IF number = 228 THEN LET name$ = "G McAlistair"
IF number = 228 THEN LET skill = 81
IF number = 228 THEN LET anger = 11
IF number = 229 THEN LET name$ = "N Campbell"
IF number = 229 THEN LET skill = 50
IF number = 229 THEN LET anger = 35
IF number = 230 THEN LET name$ = "L Douglas"
IF number = 230 THEN LET skill = 64
IF number = 230 THEN LET anger = 35
IF number = 231 THEN LET name$ = "K Coltman"
IF number = 231 THEN LET skill = 90
IF number = 231 THEN LET anger = 30
IF number = 232 THEN LET name$ = "H Collins"
IF number = 232 THEN LET skill = 73
IF number = 232 THEN LET anger = 35
IF number = 233 THEN LET name$ = "R Ness"
IF number = 233 THEN LET skill = 97
IF number = 233 THEN LET anger = 49
IF number = 234 THEN LET name$ = "P Johnson"
IF number = 234 THEN LET skill = 85
IF number = 234 THEN LET anger = 5
IF number = 235 THEN LET name$ = "P Harrison"
IF number = 235 THEN LET skill = 30
IF number = 235 THEN LET anger = 10
IF number = 236 THEN LET name$ = "P Joseph"
IF number = 236 THEN LET skill = 65
IF number = 236 THEN LET anger = 33
IF number = 237 THEN LET name$ = "S Hewison"
IF number = 237 THEN LET skill = 70
IF number = 237 THEN LET anger = 10
IF number = 238 THEN LET name$ = "R Leinfeller"
IF number = 238 THEN LET skill = 60
IF number = 238 THEN LET anger = 10
IF number = 239 THEN LET name$ = "M Coppins"
IF number = 239 THEN LET skill = 85
IF number = 239 THEN LET anger = 2
IF number = 240 THEN LET name$ = "P Taglione"
IF number = 240 THEN LET skill = 90
IF number = 240 THEN LET anger = 25
IF number = 241 THEN LET name$ = "A Johnson"
IF number = 241 THEN LET skill = 95
IF number = 241 THEN LET anger = 37
IF number = 242 THEN LET name$ = "T Heathcote"
IF number = 242 THEN LET skill = 90
IF number = 242 THEN LET anger = 19
IF number = 243 THEN LET name$ = "M Cunliffe"
IF number = 243 THEN LET skill = 80
IF number = 243 THEN LET anger = 15
IF number = 244 THEN LET name$ = "M Cooper"
IF number = 244 THEN LET skill = 65
IF number = 244 THEN LET anger = 12
IF number = 245 THEN LET name$ = "F Rice"
IF number = 245 THEN LET skill = 75
IF number = 245 THEN LET anger = 20
IF number = 246 THEN LET name$ = "D Stouhgton"
IF number = 246 THEN LET skill = 87
IF number = 246 THEN LET anger = 20
IF number = 247 THEN LET name$ = "S McGavin"
IF number = 247 THEN LET skill = 60
IF number = 247 THEN LET anger = 30
IF number = 248 THEN LET name$ = "P Townsend"
IF number = 248 THEN LET skill = 85
IF number = 248 THEN LET anger = 30
IF number = 249 THEN LET name$ = "C Skynner"
IF number = 249 THEN LET skill = 74
IF number = 249 THEN LET anger = 41
IF number = 250 THEN LET name$ = "R Pascoe"
IF number = 250 THEN LET skill = 62
IF number = 250 THEN LET anger = 13
IF number = 251 THEN LET name$ = "B Montana"
IF number = 251 THEN LET skill = 65
IF number = 251 THEN LET anger = 27
IF number = 252 THEN LET name$ = "G Arnold"
IF number = 252 THEN LET skill = 70
IF number = 252 THEN LET anger = 20
IF number = 253 THEN LET name$ = "R Donaldson"
IF number = 253 THEN LET skill = 89
IF number = 253 THEN LET anger = 34
IF number = 254 THEN LET name$ = "B Smith"
IF number = 254 THEN LET skill = 45
IF number = 254 THEN LET anger = 38
IF number = 255 THEN LET name$ = "A Ward"
IF number = 255 THEN LET skill = 78
IF number = 255 THEN LET anger = 6
IF number = 256 THEN LET name$ = "G Newman"
IF number = 256 THEN LET skill = 94
IF number = 256 THEN LET anger = 22
IF number = 257 THEN LET name$ = "A Peterson"
IF number = 257 THEN LET skill = 67
IF number = 257 THEN LET anger = 34
IF number = 258 THEN LET name$ = "J McAndrews"
IF number = 258 THEN LET skill = 70
IF number = 258 THEN LET anger = 20
IF number = 259 THEN LET name$ = "H Stewart"
IF number = 259 THEN LET skill = 94
IF number = 259 THEN LET anger = 43
IF number = 260 THEN LET name$ = "R Grisham"
IF number = 260 THEN LET skill = 84
IF number = 260 THEN LET anger = 20
IF number = 261 THEN LET name$ = "J Littlewood"
IF number = 261 THEN LET skill = 60
IF number = 261 THEN LET anger = 23
IF number = 262 THEN LET name$ = "R Spencer"
IF number = 262 THEN LET skill = 90
IF number = 262 THEN LET anger = 21
IF number = 263 THEN LET name$ = "I Grisham"
IF number = 263 THEN LET skill = 80
IF number = 263 THEN LET anger = 47
IF number = 264 THEN LET name$ = "D Rertson"
IF number = 264 THEN LET skill = 54
IF number = 264 THEN LET anger = 2
IF number = 265 THEN LET name$ = "M Carney"
IF number = 265 THEN LET skill = 77
IF number = 265 THEN LET anger = 43
IF number = 266 THEN LET name$ = "S Duncan"
IF number = 266 THEN LET skill = 45
IF number = 266 THEN LET anger = 2
IF number = 267 THEN LET name$ = "S Butcher"
IF number = 267 THEN LET skill = 99
IF number = 267 THEN LET anger = 22
IF number = 268 THEN LET name$ = "A Pettengale"
IF number = 268 THEN LET skill = 87
IF number = 268 THEN LET anger = 22
IF number = 269 THEN LET name$ = "P Lincoln"
IF number = 269 THEN LET skill = 47
IF number = 269 THEN LET anger = 1
IF number = 270 THEN LET name$ = "G Booth"
IF number = 270 THEN LET skill = 45
IF number = 270 THEN LET anger = 10
IF number = 271 THEN LET name$ = "G Price"
IF number = 271 THEN LET skill = 70
IF number = 271 THEN LET anger = 30
IF number = 272 THEN LET name$ = "E Abnett"
IF number = 272 THEN LET skill = 87
IF number = 272 THEN LET anger = 2
IF number = 273 THEN LET name$ = "D Barter"
IF number = 273 THEN LET skill = 99
IF number = 273 THEN LET anger = 24
IF number = 274 THEN LET name$ = "C Bund"
IF number = 274 THEN LET skill = 65
IF number = 274 THEN LET anger = 5
IF number = 275 THEN LET name$ = "A Baylis"
IF number = 275 THEN LET skill = 67
IF number = 275 THEN LET anger = 32
IF number = 276 THEN LET name$ = "D Edlington"
IF number = 276 THEN LET skill = 96
IF number = 276 THEN LET anger = 23
IF number = 277 THEN LET name$ = "S Cornford"
IF number = 277 THEN LET skill = 67
IF number = 277 THEN LET anger = 23
IF number = 278 THEN LET name$ = "S Hill"
IF number = 278 THEN LET skill = 85
IF number = 278 THEN LET anger = 8
IF number = 279 THEN LET name$ = "P Faragher"
IF number = 279 THEN LET skill = 70
IF number = 279 THEN LET anger = 10
IF number = 280 THEN LET name$ = "A Johnston"
IF number = 280 THEN LET skill = 98
IF number = 280 THEN LET anger = 43
IF number = 281 THEN LET name$ = "G Lanning"
IF number = 281 THEN LET skill = 96
IF number = 281 THEN LET anger = 45
IF number = 282 THEN LET name$ = "A Kibblewhite"
IF number = 282 THEN LET skill = 56
IF number = 282 THEN LET anger = 34
IF number = 283 THEN LET name$ = "J Masters"
IF number = 283 THEN LET skill = 74
IF number = 283 THEN LET anger = 44
IF number = 284 THEN LET name$ = "A Rilstone"
IF number = 284 THEN LET skill = 74
IF number = 284 THEN LET anger = 12
IF number = 285 THEN LET name$ = "A Walton"
IF number = 285 THEN LET skill = 34
IF number = 285 THEN LET anger = 3
IF number = 286 THEN LET name$ = "K Tinworth"
IF number = 286 THEN LET skill = 85
IF number = 286 THEN LET anger = 44
IF number = 287 THEN LET name$ = "L Webb"
IF number = 287 THEN LET skill = 99
IF number = 287 THEN LET anger = 15
IF number = 288 THEN LET name$ = "T Wilson"
IF number = 288 THEN LET skill = 98
IF number = 288 THEN LET anger = 37
IF number = 289 THEN LET name$ = "R Atkinson"
IF number = 289 THEN LET skill = 65
IF number = 289 THEN LET anger = 24
IF number = 290 THEN LET name$ = "D Beuttner"
IF number = 290 THEN LET skill = 96
IF number = 290 THEN LET anger = 24
IF number = 291 THEN LET name$ = "A Dixon"
IF number = 291 THEN LET skill = 80
IF number = 291 THEN LET anger = 30
IF number = 292 THEN LET name$ = "A Currie"
IF number = 292 THEN LET skill = 87
IF number = 292 THEN LET anger = 34
IF number = 293 THEN LET name$ = "S Jason"
IF number = 293 THEN LET skill = 97
IF number = 293 THEN LET anger = 34
IF number = 294 THEN LET name$ = "M Kite"
IF number = 294 THEN LET skill = 70
IF number = 294 THEN LET anger = 44
IF number = 295 THEN LET name$ = "K Webster"
IF number = 295 THEN LET skill = 75
IF number = 295 THEN LET anger = 10
IF number = 296 THEN LET name$ = "P Beaven"
IF number = 296 THEN LET skill = 90
IF number = 296 THEN LET anger = 10
IF number = 297 THEN LET name$ = "D Walker"
IF number = 297 THEN LET skill = 60
IF number = 297 THEN LET anger = 36
IF number = 298 THEN LET name$ = "A Pearce"
IF number = 298 THEN LET skill = 80
IF number = 298 THEN LET anger = 6
IF number = 299 THEN LET name$ = "D Hill"
IF number = 299 THEN LET skill = 79
IF number = 299 THEN LET anger = 3
IF number = 300 THEN LET name$ = "S Brown"
IF number = 300 THEN LET skill = 80
IF number = 300 THEN LET anger = 18
IF number = 301 THEN LET name$ = "R Moss"
IF number = 301 THEN LET skill = 83
IF number = 301 THEN LET anger = 19
IF number = 302 THEN LET name$ = "S Ramsay"
IF number = 302 THEN LET skill = 68
IF number = 302 THEN LET anger = 49
IF number = 303 THEN LET name$ = "K Stansfield"
IF number = 303 THEN LET skill = 63
IF number = 303 THEN LET anger = 27
IF number = 304 THEN LET name$ = "G Anderson"
IF number = 304 THEN LET skill = 45
IF number = 304 THEN LET anger = 12
IF number = 305 THEN LET name$ = "N Ingham"
IF number = 305 THEN LET skill = 67
IF number = 305 THEN LET anger = 36
IF number = 306 THEN LET name$ = "G Green"
IF number = 306 THEN LET skill = 87
IF number = 306 THEN LET anger = 14
IF number = 307 THEN LET name$ = "J Rogers"
IF number = 307 THEN LET skill = 79
IF number = 307 THEN LET anger = 6
IF number = 308 THEN LET name$ = "M Gingell"
IF number = 308 THEN LET skill = 76
IF number = 308 THEN LET anger = 43
IF number = 309 THEN LET name$ = "D Parker"
IF number = 309 THEN LET skill = 87
IF number = 309 THEN LET anger = 31
IF number = 310 THEN LET name$ = "B Rinson"
IF number = 310 THEN LET skill = 79
IF number = 310 THEN LET anger = 23
IF number = 311 THEN LET name$ = "G Smith"
IF number = 311 THEN LET skill = 69
IF number = 311 THEN LET anger = 34
IF number = 312 THEN LET name$ = "J Goldberg"
IF number = 312 THEN LET skill = 88
IF number = 312 THEN LET anger = 11
IF number = 313 THEN LET name$ = "B Kennedy"
IF number = 313 THEN LET skill = 88
IF number = 313 THEN LET anger = 2
IF number = 314 THEN LET name$ = "C Gynn"
IF number = 314 THEN LET skill = 70
IF number = 314 THEN LET anger = 10
IF number = 315 THEN LET name$ = "D Fraser"
IF number = 315 THEN LET skill = 80
IF number = 315 THEN LET anger = 12
IF number = 316 THEN LET name$ = "A Evans"
IF number = 316 THEN LET skill = 55
IF number = 316 THEN LET anger = 5
IF number = 317 THEN LET name$ = "D Anderson"
IF number = 317 THEN LET skill = 60
IF number = 317 THEN LET anger = 13
IF number = 318 THEN LET name$ = "P Kelsall"
IF number = 318 THEN LET skill = 80
IF number = 318 THEN LET anger = 34
IF number = 319 THEN LET name$ = "K Garner"
IF number = 319 THEN LET skill = 76
IF number = 319 THEN LET anger = 23
IF number = 320 THEN LET name$ = "S O'Neill"
IF number = 320 THEN LET skill = 89
IF number = 320 THEN LET anger = 12
IF number = 321 THEN LET name$ = "N Ryan"
IF number = 321 THEN LET skill = 80
IF number = 321 THEN LET anger = 30
IF number = 322 THEN LET name$ = "R Taylor"
IF number = 322 THEN LET skill = 66
IF number = 322 THEN LET anger = 10
IF number = 323 THEN LET name$ = "M Pratt"
IF number = 323 THEN LET skill = 86
IF number = 323 THEN LET anger = 44
IF number = 324 THEN LET name$ = "T Frey"
IF number = 324 THEN LET skill = 79
IF number = 324 THEN LET anger = 2
IF number = 310 THEN LET name$ = "E Shackell"
IF number = 310 THEN LET skill = 80
IF number = 310 THEN LET anger = 34
IF number = 326 THEN LET name$ = "G Manning"
IF number = 326 THEN LET skill = 74
IF number = 326 THEN LET anger = 29
IF number = 327 THEN LET name$ = "M Morris"
IF number = 327 THEN LET skill = 80
IF number = 327 THEN LET anger = 15
IF number = 328 THEN LET name$ = "G Wood"
IF number = 328 THEN LET skill = 94
IF number = 328 THEN LET anger = 20
IF number = 329 THEN LET name$ = "C Anderson"
IF number = 329 THEN LET skill = 70
IF number = 329 THEN LET anger = 1
IF number = 330 THEN LET name$ = "J Ashe"
IF number = 330 THEN LET skill = 80
IF number = 330 THEN LET anger = 1
IF number = 331 THEN LET name$ = "N Monroe"
IF number = 331 THEN LET skill = 87
IF number = 331 THEN LET anger = 23
IF number = 332 THEN LET name$ = "J Eldrin"
IF number = 332 THEN LET skill = 86
IF number = 332 THEN LET anger = 19
IF number = 333 THEN LET name$ = "K Wilkes"
IF number = 333 THEN LET skill = 69
IF number = 333 THEN LET anger = 10
IF number = 334 THEN LET name$ = "A Holt"
IF number = 334 THEN LET skill = 84
IF number = 334 THEN LET anger = 12
IF number = 335 THEN LET name$ = "M Thompson"
IF number = 335 THEN LET skill = 83
IF number = 335 THEN LET anger = 21
IF number = 336 THEN LET name$ = "J Smith"
IF number = 336 THEN LET skill = 78
IF number = 336 THEN LET anger = 13
IF number = 337 THEN LET name$ = "S Naylor"
IF number = 337 THEN LET skill = 80
IF number = 337 THEN LET anger = 24
IF number = 338 THEN LET name$ = "S Andrews"
IF number = 338 THEN LET skill = 73
IF number = 338 THEN LET anger = 3
IF number = 339 THEN LET name$ = "R Thraves"
IF number = 339 THEN LET skill = 84
IF number = 339 THEN LET anger = 17
IF number = 340 THEN LET name$ = "J Manning"
IF number = 340 THEN LET skill = 87
IF number = 340 THEN LET anger = 23
IF number = 341 THEN LET name$ = "T Rotsler"
IF number = 341 THEN LET skill = 74
IF number = 341 THEN LET anger = 10
IF number = 342 THEN LET name$ = "T Shaw"
IF number = 342 THEN LET skill = 98
IF number = 342 THEN LET anger = 12
IF number = 343 THEN LET name$ = "B Dickson"
IF number = 343 THEN LET skill = 85
IF number = 343 THEN LET anger = 30
IF number = 344 THEN LET name$ = "E Hall"
IF number = 344 THEN LET skill = 87
IF number = 344 THEN LET anger = 34
IF number = 345 THEN LET name$ = "M Chippett"
IF number = 345 THEN LET skill = 91
IF number = 345 THEN LET anger = 14
IF number = 346 THEN LET name$ = "R Smith"
IF number = 346 THEN LET skill = 64
IF number = 346 THEN LET anger = 12
IF number = 347 THEN LET name$ = "R Pentelow"
IF number = 347 THEN LET skill = 75
IF number = 347 THEN LET anger = 23
IF number = 348 THEN LET name$ = "S Mana"
IF number = 348 THEN LET skill = 84
IF number = 348 THEN LET anger = 16
IF number = 349 THEN LET name$ = "T Wilson"
IF number = 349 THEN LET skill = 86
IF number = 349 THEN LET anger = 24
IF number = 350 THEN LET name$ = "G Lesley"
IF number = 350 THEN LET skill = 66
IF number = 350 THEN LET anger = 11
IF number = 351 THEN LET name$ = "M Osborne"
IF number = 351 THEN LET skill = 97
IF number = 351 THEN LET anger = 5
IF number = 352 THEN LET name$ = "J Nelson"
IF number = 352 THEN LET skill = 86
IF number = 352 THEN LET anger = 24
IF number = 353 THEN LET name$ = "B Kirk"
IF number = 353 THEN LET skill = 86
IF number = 353 THEN LET anger = 4
IF number = 354 THEN LET name$ = "A Brown"
IF number = 354 THEN LET skill = 65
IF number = 354 THEN LET anger = 43
IF number = 355 THEN LET name$ = "A Darling"
IF number = 355 THEN LET skill = 89
IF number = 355 THEN LET anger = 10
IF number = 356 THEN LET name$ = "C Simpson"
IF number = 356 THEN LET skill = 89
IF number = 356 THEN LET anger = 30
IF number = 357 THEN LET name$ = "M Ramsay"
IF number = 357 THEN LET skill = 84
IF number = 357 THEN LET anger = 6
IF number = 358 THEN LET name$ = "L Edwards"
IF number = 358 THEN LET skill = 98
IF number = 358 THEN LET anger = 2
IF number = 359 THEN LET name$ = "D Bailey"
IF number = 359 THEN LET skill = 97
IF number = 359 THEN LET anger = 6
IF number = 360 THEN LET name$ = "B Hendrix"
IF number = 360 THEN LET skill = 89
IF number = 360 THEN LET anger = 14
IF number = 361 THEN LET name$ = "H Jacobs"
IF number = 361 THEN LET skill = 92
IF number = 361 THEN LET anger = 4
IF number = 362 THEN LET name$ = "K McDonald"
IF number = 362 THEN LET skill = 85
IF number = 362 THEN LET anger = 24
IF number = 363 THEN LET name$ = "I Timpson"
IF number = 363 THEN LET skill = 80
IF number = 363 THEN LET anger = 23
IF number = 364 THEN LET name$ = "J Booth"
IF number = 364 THEN LET skill = 92
IF number = 364 THEN LET anger = 10
IF number = 365 THEN LET name$ = "N Wilson"
IF number = 365 THEN LET skill = 88
IF number = 365 THEN LET anger = 6
IF number = 366 THEN LET name$ = "J Redpath"
IF number = 366 THEN LET skill = 75
IF number = 366 THEN LET anger = 50
IF number = 367 THEN LET name$ = "B McGregor"
IF number = 367 THEN LET skill = 80
IF number = 367 THEN LET anger = 13
IF number = 368 THEN LET name$ = "M Henderson"
IF number = 368 THEN LET skill = 90
IF number = 368 THEN LET anger = 35
IF number = 369 THEN LET name$ = "C Thompson"
IF number = 369 THEN LET skill = 87
IF number = 369 THEN LET anger = 24
IF number = 370 THEN LET name$ = "N Cathie"
IF number = 370 THEN LET skill = 88
IF number = 370 THEN LET anger = 26
IF number = 371 THEN LET name$ = "B Hardcastle"
IF number = 371 THEN LET skill = 90
IF number = 371 THEN LET anger = 20
IF number = 372 THEN LET name$ = "J Dignall"
IF number = 372 THEN LET skill = 87
IF number = 372 THEN LET anger = 14
IF number = 373 THEN LET name$ = "P Oz"
IF number = 373 THEN LET skill = 76
IF number = 373 THEN LET anger = 31
IF number = 374 THEN LET name$ = "F Hutchison"
IF number = 374 THEN LET skill = 85
IF number = 374 THEN LET anger = 43
IF number = 375 THEN LET name$ = "T Dickson"
IF number = 375 THEN LET skill = 89
IF number = 375 THEN LET anger = 21
IF number = 376 THEN LET name$ = "K Dickins"
IF number = 376 THEN LET skill = 86
IF number = 376 THEN LET anger = 35
IF number = 377 THEN LET name$ = "A Black"
IF number = 377 THEN LET skill = 87
IF number = 377 THEN LET anger = 12
IF number = 378 THEN LET name$ = "S Volpi"
IF number = 378 THEN LET skill = 98
IF number = 378 THEN LET anger = 12
IF number = 379 THEN LET name$ = "M Tierney"
IF number = 379 THEN LET skill = 83
IF number = 379 THEN LET anger = 11
IF number = 380 THEN LET name$ = "D Badd"
IF number = 380 THEN LET skill = 78
IF number = 380 THEN LET anger = 24
IF number = 381 THEN LET name$ = "F Beddall"
IF number = 381 THEN LET skill = 94
IF number = 381 THEN LET anger = 27
IF number = 382 THEN LET name$ = "N Suddell"
IF number = 382 THEN LET skill = 67
IF number = 382 THEN LET anger = 10
IF number = 383 THEN LET name$ = "S Holland"
IF number = 383 THEN LET skill = 79
IF number = 383 THEN LET anger = 28
IF number = 384 THEN LET name$ = "P Rowe"
IF number = 384 THEN LET skill = 99
IF number = 384 THEN LET anger = 10
IF number = 385 THEN LET name$ = "N Davies"
IF number = 385 THEN LET skill = 80
IF number = 385 THEN LET anger = 15
IF number = 386 THEN LET name$ = "T Dickson"
IF number = 386 THEN LET skill = 93
IF number = 386 THEN LET anger = 32
IF number = 387 THEN LET name$ = "N Stone"
IF number = 387 THEN LET skill = 85
IF number = 387 THEN LET anger = 42
IF number = 388 THEN LET name$ = "P Hatch"
IF number = 388 THEN LET skill = 90
IF number = 388 THEN LET anger = 21
IF number = 389 THEN LET name$ = "L Foster"
IF number = 389 THEN LET skill = 76
IF number = 389 THEN LET anger = 32
IF number = 390 THEN LET name$ = "J Derwill"
IF number = 390 THEN LET skill = 87
IF number = 390 THEN LET anger = 21
IF number = 391 THEN LET name$ = "D Daler"
IF number = 391 THEN LET skill = 76
IF number = 391 THEN LET anger = 43
IF number = 392 THEN LET name$ = "P Kidd"
IF number = 392 THEN LET skill = 87
IF number = 392 THEN LET anger = 4
IF number = 393 THEN LET name$ = "J Wilcox"
IF number = 393 THEN LET skill = 98
IF number = 393 THEN LET anger = 43
IF number = 394 THEN LET name$ = "A Soh"
IF number = 394 THEN LET skill = 90
IF number = 394 THEN LET anger = 21
IF number = 395 THEN LET name$ = "E Bagley"
IF number = 395 THEN LET skill = 76
IF number = 395 THEN LET anger = 21
IF number = 396 THEN LET name$ = "G Betts"
IF number = 396 THEN LET skill = 90
IF number = 396 THEN LET anger = 32
IF number = 397 THEN LET name$ = "T Dickson"
IF number = 397 THEN LET skill = 54
IF number = 397 THEN LET anger = 21
IF number = 398 THEN LET name$ = "A McCormick"
IF number = 398 THEN LET skill = 76
IF number = 398 THEN LET anger = 21
IF number = 399 THEN LET name$ = "A Smithies"
IF number = 399 THEN LET skill = 97
IF number = 399 THEN LET anger = 43
IF number = 400 THEN LET name$ = "Lee Stock"
IF number = 400 THEN LET skill = 93
IF number = 400 THEN LET anger = 21
RETURN

