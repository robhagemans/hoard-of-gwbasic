'Virtual Accountant is a program that draws graphs for you accounts over a
'year but has not been completed.  You need to get the computer to draw the
'graph onto the chart, maybe getting it too go red when it declines and green
'when it increases.  Do want you want and send it to me you've finished. I'll
'post it on forum when it's finished.
'
'
'
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
PRINT "                 *** Virtual Accountant ***"
PRINT
PRINT "Good day, I am Winston your virtual accounts manager.  You can use me"
PRINT "to create graphs reviewing your financial year."
PRINT
INPUT "Which year would you like to review"; year
PRINT
PRINT "Please put in how much money you had saved at the end of each month."
INPUT "January:  "; jan
INPUT "Febuary:  "; feb
INPUT "March:    "; mar
INPUT "April:    "; apr
INPUT "May:      "; may
INPUT "June:     "; jun
INPUT "July:     "; jul
INPUT "August:   "; aug
INPUT "Sepember: "; sep
INPUT "October:  "; oct
INPUT "November: "; nov
INPUT "December: "; dec
PRINT
INPUT "Are you ready for your graph"; trash$
CLS
PRINT
PRINT "Financial overview of the year "; year
SCREEN 1
Axis$ = "R80 L200 U100"
DRAW "C2 X" + VARPTR$(Axis$)
PRINT
PRINT "1000"
PRINT "900"
PRINT "800"
PRINT "700"
PRINT "600"
PRINT "500"
PRINT "400"
PRINT "300"
PRINT "200"
PRINT "100"
PRINT "0   "
PRINT
PRINT "       J F M A M J J A S O N D "; ""
PRINT
LET average = (jan + feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec) / 12
PRINT "Monthly average: "; average

