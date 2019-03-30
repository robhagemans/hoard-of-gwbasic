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
FOR i% = 440 TO 1000 STEP 5
SOUND i%, i% / 1000
NEXT i%
COLOR 4
PRINT "                     *** Virtual Magic ***"
COLOR 7
PRINT
PRINT " This is a battle game where two wizards attempt to beat each other"
PRINT "by discovering and casting spells."
PRINT
INPUT "What be thy name, wizard number one"; name1$
INPUT "And what be the title of wizard number two"; name2$
GOTO 1
LET life1 = 10
LET life2 = 10
2 PRINT "A spell is made up of three rune words.  Each rune word is made up"
PRINT "of three letters."
PRINT
COLOR 4
PRINT "PREPARE FOR MAGICAL COMBAT!!!"
COLOR 7
PRINT
LET life1 = 10
LET life2 = 10
3 CLS
LET spell = 0
COLOR 4
PRINT "Rune words:"
COLOR 7
PRINT
PRINT a$; ", "; b$; ", "; c$; ", "; d$; ", "; e$; ", "; f$; ", "; g$; ", "
PRINT h$; ", "; i$; ", "; j$; ", "; k$; ", "; l$; ", "; m$; ", "; n$; ", "
PRINT o$; ", "; p$; ", "; q$; ", "; r$; ", "; s$; ", "; t$; ", "; u$; ", "
PRINT v$; ", "; w$; ", "; x$; ", "; y$; ", "; z$; "."
PRINT
20 PRINT name1$
LET spell = 0
IF life1 > 10 THEN LET life1 = 10
IF life1 < 0 THEN GOTO 10
PRINT "LPs: "; life1
PRINT "Please enter a spell:"
INPUT one1$
INPUT two1$
INPUT three1$
PRINT
PRINT one1$; "-"; two1$; "-"; three1$; "!"
GOTO 4
5 PRINT
LET spell = 0
PRINT name2$
IF life2 > 10 THEN LET life2 = 10
IF life2 < 0 THEN GOTO 11
PRINT "LPs: "; life2
PRINT "Please enter a spell:"
INPUT one2$
INPUT two2$
INPUT three2$
PRINT
PRINT one2$; "-"; two2$; "-"; three2$; "!"
GOTO 6
7 INPUT "Press return to continue"; trash$
GOTO 3
1 LET a$ = "Ken"
LET b$ = "Wak"
LET c$ = "Yoo"
LET d$ = "Tog"
LET e$ = "Wir"
LET f$ = "Gnu"
LET g$ = "Poa"
LET h$ = "Rer"
LET i$ = "Coz"
LET j$ = "Arp"
LET k$ = "Oje"
LET l$ = "Til"
LET m$ = "Roc"
LET n$ = "Wod"
LET o$ = "Sho"
LET p$ = "Vas"
LET q$ = "Dop"
LET r$ = "Rof"
LET s$ = "Uss"
LET t$ = "Pos"
LET u$ = "Uch"
LET v$ = "Dir"
LET w$ = "Fla"
LET x$ = "Pud"
LET y$ = "Cal"
LET z$ = "Das"
GOTO 2
6 IF one2$ = a$ AND two2$ = b$ AND three2$ = c$ THEN LET spell = 1
IF one2$ = d$ AND two2$ = e$ AND three2$ = f$ THEN LET spell = 2
IF one2$ = a$ AND two2$ = c$ AND three2$ = e$ THEN LET spell = 3
IF one2$ = c$ AND two2$ = a$ AND three2$ = b$ THEN LET spell = 4
IF one2$ = p$ AND two2$ = r$ AND three2$ = o$ THEN LET spell = 5
IF one2$ = c$ AND two2$ = a$ AND three2$ = r$ THEN LET spell = 6
IF one2$ = g$ AND two2$ = u$ AND three2$ = n$ THEN LET spell = 7
IF one2$ = g$ AND two2$ = n$ AND three2$ = u$ THEN LET spell = 8
IF one2$ = d$ AND two2$ = o$ AND three2$ = c$ THEN LET spell = 9
IF one2$ = d$ AND two2$ = o$ AND three2$ = b$ THEN LET spell = 10
IF one2$ = x$ AND two2$ = x$ AND three2$ = x$ THEN LET spell = 11
IF one2$ = p$ AND two2$ = o$ AND three2$ = d$ THEN LET spell = 12
IF one2$ = z$ AND two2$ = i$ AND three2$ = p$ THEN LET spell = 13
IF one2$ = p$ AND two2$ = o$ AND three2$ = w$ THEN LET spell = 14
IF one2$ = o$ AND two2$ = l$ AND three2$ = d$ THEN LET spell = 15
IF one2$ = d$ AND two2$ = o$ AND three2$ = g$ THEN LET spell = 16
IF one2$ = a$ AND two2$ = l$ AND three2$ = e$ THEN LET spell = 17
IF one2$ = b$ AND two2$ = a$ AND three2$ = r$ THEN LET spell = 18
IF one2$ = a$ AND two2$ = r$ AND three2$ = k$ THEN LET spell = 19
IF one2$ = p$ AND two2$ = i$ AND three2$ = n$ THEN LET spell = 20
IF one2$ = l$ AND two2$ = o$ AND three2$ = t$ THEN LET spell = 21
IF one2$ = b$ AND two2$ = a$ AND three2$ = n$ THEN LET spell = 22
IF one2$ = v$ AND two2$ = a$ AND three2$ = n$ THEN LET spell = 23
IF one2$ = t$ AND two2$ = i$ AND three2$ = p$ THEN LET spell = 24
IF one2$ = a$ AND two2$ = l$ AND three2$ = p$ THEN LET spell = 25
IF one2$ = o$ AND two2$ = n$ AND three2$ = e$ THEN LET spell = 26
IF one2$ = t$ AND two2$ = w$ AND three2$ = o$ THEN LET spell = 27
IF one2$ = t$ AND two2$ = u$ AND three2$ = b$ THEN LET spell = 28
IF one2$ = h$ AND two2$ = o$ AND three2$ = e$ THEN LET spell = 29
IF one2$ = w$ AND two2$ = h$ AND three2$ = o$ THEN LET spell = 30
IF one2$ = b$ AND two2$ = s$ AND three2$ = e$ THEN LET spell = 31
IF one2$ = m$ AND two2$ = o$ AND three2$ = p$ THEN LET spell = 32
IF one2$ = k$ AND two2$ = i$ AND three2$ = t$ THEN LET spell = 33
IF one2$ = d$ AND two2$ = i$ AND three2$ = g$ THEN LET spell = 34
IF one2$ = x$ AND two2$ = y$ AND three2$ = z$ THEN LET spell = 35
IF one2$ = f$ AND two2$ = a$ AND three2$ = b$ THEN LET spell = 36
IF one2$ = r$ AND two2$ = o$ AND three2$ = d$ THEN LET spell = 37
IF one2$ = p$ AND two2$ = i$ AND three2$ = t$ THEN LET spell = 38
IF one2$ = o$ AND two2$ = h$ AND three2$ = p$ THEN LET spell = 39
IF one2$ = t$ AND two2$ = o$ AND three2$ = p$ THEN LET spell = 40
IF one2$ = t$ AND two2$ = a$ AND three2$ = b$ THEN LET spell = 41
IF one2$ = c$ AND two2$ = o$ AND three2$ = p$ THEN LET spell = 42
IF one2$ = r$ AND two2$ = o$ AND three2$ = d$ THEN LET spell = 43
IF one2$ = o$ AND two2$ = r$ AND three2$ = c$ THEN LET spell = 44
IF one2$ = o$ AND two2$ = r$ AND three2$ = k$ THEN LET spell = 45
IF one2$ = d$ AND two2$ = i$ AND three2$ = e$ THEN LET spell = 46
IF one2$ = s$ AND two2$ = y$ AND three2$ = k$ THEN LET spell = 47
IF one2$ = w$ AND two2$ = v$ AND three2$ = m$ THEN LET spell = 48
IF one2$ = u$ AND two2$ = f$ AND three2$ = d$ THEN LET spell = 49
IF one2$ = a$ AND two2$ = s$ AND three2$ = d$ THEN LET spell = 50
IF one2$ = q$ AND two2$ = w$ AND three2$ = e$ THEN LET spell = 51
IF one2$ = z$ AND two2$ = x$ AND three2$ = c$ THEN LET spell = 52
IF one2$ = j$ AND two2$ = k$ AND three2$ = l$ THEN LET spell = 53
IF one2$ = p$ AND two2$ = o$ AND three2$ = i$ THEN LET spell = 54
IF one2$ = m$ AND two2$ = n$ AND three2$ = b$ THEN LET spell = 55
IF one2$ = f$ AND two2$ = g$ AND three2$ = h$ THEN LET spell = 56
IF one2$ = j$ AND two2$ = f$ AND three2$ = k$ THEN LET spell = 57
IF one2$ = s$ AND two2$ = a$ AND three2$ = d$ THEN LET spell = 58
IF one2$ = n$ AND two2$ = i$ AND three2$ = t$ THEN LET spell = 59
IF one2$ = r$ AND two2$ = t$ AND three2$ = y$ THEN LET spell = 60
IF one2$ = o$ AND two2$ = a$ AND three2$ = r$ THEN LET spell = 61
IF one2$ = w$ AND two2$ = s$ AND three2$ = j$ THEN LET spell = 62
IF one2$ = q$ AND two2$ = e$ AND three2$ = t$ THEN LET spell = 63
IF one2$ = w$ AND two2$ = r$ AND three2$ = y$ THEN LET spell = 64
IF one2$ = e$ AND two2$ = t$ AND three2$ = u$ THEN LET spell = 65
IF one2$ = r$ AND two2$ = y$ AND three2$ = i$ THEN LET spell = 66
IF one2$ = t$ AND two2$ = u$ AND three2$ = o$ THEN LET spell = 67
IF one2$ = y$ AND two2$ = i$ AND three2$ = p$ THEN LET spell = 68
IF one2$ = a$ AND two2$ = d$ AND three2$ = g$ THEN LET spell = 69
IF one2$ = s$ AND two2$ = f$ AND three2$ = h$ THEN LET spell = 70
IF one2$ = d$ AND two2$ = g$ AND three2$ = j$ THEN LET spell = 71
IF one2$ = f$ AND two2$ = h$ AND three2$ = k$ THEN LET spell = 72
IF one2$ = g$ AND two2$ = j$ AND three2$ = l$ THEN LET spell = 73
IF one2$ = z$ AND two2$ = c$ AND three2$ = b$ THEN LET spell = 74
IF one2$ = x$ AND two2$ = v$ AND three2$ = n$ THEN LET spell = 75
IF one2$ = c$ AND two2$ = b$ AND three2$ = m$ THEN LET spell = 76
IF one2$ = c$ AND two2$ = d$ AND three2$ = s$ THEN LET spell = 77
IF one2$ = r$ AND two2$ = i$ AND three2$ = b$ THEN LET spell = 78
IF one2$ = l$ AND two2$ = a$ AND three2$ = p$ THEN LET spell = 79
IF one2$ = d$ AND two2$ = a$ AND three2$ = v$ THEN LET spell = 80
IF one2$ = b$ AND two2$ = m$ AND three2$ = p$ THEN LET spell = 81
IF one2$ = w$ AND two2$ = a$ AND three2$ = v$ THEN LET spell = 82
IF one2$ = w$ AND two2$ = h$ AND three2$ = o$ THEN LET spell = 83
IF one2$ = w$ AND two2$ = r$ AND three2$ = i$ THEN LET spell = 84
IF one2$ = d$ AND two2$ = o$ AND three2$ = c$ THEN LET spell = 85
IF one2$ = a$ AND two2$ = r$ AND three2$ = t$ THEN LET spell = 86
IF one2$ = r$ AND two2$ = e$ AND three2$ = x$ THEN LET spell = 87
IF one2$ = c$ AND two2$ = o$ AND three2$ = d$ THEN LET spell = 88
IF one2$ = f$ AND two2$ = e$ AND three2$ = d$ THEN LET spell = 89
IF one2$ = r$ AND two2$ = e$ AND three2$ = d$ THEN LET spell = 90
IF one2$ = n$ AND two2$ = s$ AND three2$ = a$ THEN LET spell = 91
IF one2$ = f$ AND two2$ = b$ AND three2$ = i$ THEN LET spell = 92
IF one2$ = n$ AND two2$ = i$ AND three2$ = a$ THEN LET spell = 93
IF one2$ = w$ AND two2$ = h$ AND three2$ = y$ THEN LET spell = 94
IF one2$ = n$ AND two2$ = e$ AND three2$ = t$ THEN LET spell = 95
IF one2$ = q$ AND two2$ = w$ AND three2$ = e$ THEN LET spell = 96
IF one2$ = w$ AND two2$ = e$ AND three2$ = r$ THEN LET spell = 97
IF one2$ = e$ AND two2$ = r$ AND three2$ = t$ THEN LET spell = 98
IF one2$ = r$ AND two2$ = t$ AND three2$ = y$ THEN LET spell = 99
IF one2$ = t$ AND two2$ = y$ AND three2$ = u$ THEN LET spell = 100
IF one2$ = "W" AND two2$ = "i" AND three2$ = "n" THEN LET spell = 101
COLOR 2
IF spell = 1 THEN PRINT "A ball of fire flies from your hand!"
IF spell = 1 THEN LET life1 = life1 - 2
IF spell = 2 THEN PRINT "A bolt of lightning leaps from your finger tips!"
IF spell = 2 THEN LET life1 = life1 - 1
IF spell = 3 THEN PRINT "Some of your wounds have healed!"
IF spell = 3 THEN LET life2 = life2 + 1
IF spell = 4 THEN PRINT "You have gained super strength!!!"
IF spell = 4 THEN LET life2 = 10
IF spell = 5 THEN PRINT "Your spell has back-fired on yourself!"
IF spell = 5 THEN LET life2 = life2 - 3
IF spell = 6 THEN PRINT "Your opponent bursts into flames!"
IF spell = 6 THEN LET life1 = life1 - 5
IF spell = 7 THEN PRINT "You have cast healing upon yourself!"
IF spell = 7 THEN LET life2 = life2 + 3
IF spell = 8 THEN PRINT "You have summoned a demon of death!!!"
IF spell = 8 THEN LET life1 = 1
IF spell = 9 THEN PRINT "A swarm of hornets has attacked your opponent!"
IF spell = 9 THEN LET life1 = life1 - 4
IF spell = 10 THEN PRINT "Virtual Magic is a great game!!!"
IF spell = 10 THEN LET life2 = 10
IF spell = 10 THEN LET life1 = 10
IF spell = 11 THEN PRINT "You have cast the spell of equality!"
IF spell = 11 THEN LET life1 = 5
IF spell = 11 THEN LET life2 = 5
IF spell = 12 THEN PRINT "A cobra is attacking your opponent!"
IF spell = 12 THEN LET life1 = life1 - 2
IF spell = 13 THEN PRINT "There is a huge explosion between you and your opponent!"
IF spell = 13 THEN LET life1 = life1 - 1
IF spell = 13 THEN LET life2 = life2 - 1
IF spell = 14 THEN PRINT "Try casting: Wak-Yoo-Tog."
IF spell = 15 THEN PRINT "Try casting: Dir-Pos-Wir."
IF spell = 16 THEN PRINT "Try casting: Vas-Rof-Sho."
IF spell = 17 THEN PRINT "You have summoned Dave the Brave!!!"
IF spell = 17 THEN LET life1 = 1
IF spell = 18 THEN PRINT "Suddenly it begins to rain frogs!"
IF spell = 19 THEN PRINT "Nothing happens."
IF spell = 20 THEN LET life1 = life1 - 3
IF spell = 21 THEN PRINT "IT'S THE END OF THE WORLD!!!"
IF spell = 21 THEN END
IF spell = 22 THEN PRINT "You have poisoned your opponent!!!"
IF spell = 22 THEN LET life1 = life1 - 3
IF spell = 23 THEN PRINT "What do you get when you cross a sheep with a kangaroo?"
IF spell = 23 THEN PRINT "Cast Pos-Coz-Vas for the answer."
IF spell = 24 THEN PRINT "A wooly jumper!"
IF spell = 25 THEN PRINT "Your opponent is strangled by an invisible entity!"
IF spell = 25 THEN LET life1 = life1 - 5
IF spell = 26 THEN PRINT "A spell never includes two or more identical rune words."
IF spell = 27 THEN PRINT "Suddenly you have very bad cramp!"
IF spell = 27 THEN LET life2 = life2 - 1
IF spell = 28 THEN PRINT "A great, black bat attacks your opponent!"
IF spell = 28 THEN LET life1 = life1 - 4
IF spell = 29 THEN PRINT "Elvis is alive!!!"
IF spell = 30 THEN PRINT "You have killed your opponent!!!"
IF spell = 30 THEN LET life1 = 0
IF spell = 31 THEN PRINT "Pulses of electricity run through your opponent's body!"
IF spell = 31 THEN LET life1 = life1 - 3
IF spell = 32 THEN PRINT "Your opponent is sucked into the ground!"
IF spell = 33 THEN LET life1 = life1 - 4
IF spell = 34 THEN PRINT "Rock hard and hard rock!!!"
IF spell = 34 THEN LET life1 = 2
IF spell = 35 THEN PRINT "You have cast a spell of holding!!!"
IF spell = 35 THEN GOTO 5
IF spell = 36 THEN PRINT "You have entered a time warp!!!"
IF spell = 36 THEN LET life1 = 10
IF spell = 36 THEN LET life2 = 10
IF spell = 37 THEN PRINT "KABOOM!!!!!!"
IF spell = 37 THEN LET life1 = 1
IF spell = 37 THEN LET life2 = 1
IF spell = 38 THEN PRINT "You have cast the spell of speed and may cast another spell!!!"
IF spell = 38 THEN GOTO 5
IF spell = 39 THEN LET life1 = life1 - 4
IF spell = 40 THEN PRINT "You have cast the spell of weakness!"
IF spell = 40 THEN LET life1 = life1 - 5
IF spell = 41 THEN PRINT "Your opponent starts drowning on air!!!"
IF spell = 41 THEN LET life1 = life1 - 7
IF spell = 42 THEN PRINT "Hdgwnconsan;o!!!"
IF spell = 43 THEN PRINT "I'm sorry but I don't feel like casting that spell."
IF spell = 44 THEN PRINT "Sorry. That spell is out of order."
IF spell = 45 THEN PRINT "Baboom!!!"
IF spell = 45 THEN LET life1 = life1 - 5
IF spell = 46 THEN PRINT "What?"
IF spell = 47 THEN BEEP
IF spell = 48 THEN PRINT "You have cast the spell of falling!!!"
IF spell = 48 THEN BEEP
IF spell = 48 THEN BEEP
IF spell = 48 THEN BEEP
IF spell = 48 THEN BEEP
IF spell = 48 THEN BEEP
IF spell = 48 THEN BEEP
IF spell = 48 THEN PRINT "Ha, ha!!!"
IF spell = 48 THEN LET life1 = life1 - 10
IF spell = 49 THEN PRINT "AAAAAAAAAAAAAAGGGGHHH!!!"
IF spell = 49 THEN LET life1 = life1 - 8
IF spell = 50 THEN PRINT "Wimp."
IF spell = 50 THEN BEEP
IF spell = 50 THEN LET life2 = 1
IF spell = 51 THEN PRINT "Your opponent's blood begins to boil!"
IF spell = 51 THEN LET life1 = life1 - 5
IF spell = 52 THEN PRINT "Your wounds have healed."
IF spell = 52 THEN LET life2 = 10
IF spell = 53 THEN CLS
IF spell = 54 THEN PRINT "Finish him!!!"
IF spell = 54 THEN LET life1 = 1
IF spell = 54 THEN GOTO 5
IF spell = 55 THEN PRINT "You have tilted the scales of Libra!"
IF spell = 55 THEN LET life1 = 1
IF spell = 55 THEN LET life2 = 10
IF spell = 56 THEN PRINT "You cast the spell of love and have fallen in love"
IF spell = 56 THEN PRINT "with your opponent and decided not to try and kill them."
IF spell = 56 THEN END
IF spell = 57 THEN PRINT "SYNTAX ERROR: IDIOT ATTEMPTING TO CAST SPELL>"
IF spell = 58 THEN PRINT "Your too dumb to be able to cast spell!!!"
IF spell = 59 THEN PRINT "What ever your do, don't cast Til-Shi-Pos!"
IF spell = 60 THEN PRINT "Laser beams flash from your eyes and kill your opponent!!!"
IF spell = 60 THEN LET life1 = 0
IF spell = 61 THEN PRINT "A thick poisonus fog surrounds your opponent!"
IF spell = 61 THEN LET life1 = life1 - 4
IF spell = 61 THEN GOTO 5
IF spell = 61 THEN PRINT "You freeze your opponent!"
IF spell = 61 THEN LET life1 = life1 - 3
IF spell = 62 THEN PRINT "Your opponent's heart misses a few beats!"
IF spell = 62 THEN LET life1 = life1 - 8
IF spell = 63 THEN PRINT "Suddenly you are compelled to nut your opponent!"
IF spell = 63 THEN LET life1 = life1 - 2
IF spell = 64 THEN PLAY VARPTR$(cccd)
IF spell = 65 THEN PRINT "A lemming falls from the sky and hits your opponent on the head!"
IF spell = 65 THEN LET life1 = life1 - 2
IF spell = 66 THEN PRINT "You summon a dragon and kill your opponent!!!"
IF spell = 66 THEN LET life1 = -10
IF spell = 67 THEN PRINT "You have cast the spell of suicide!!!"
IF spell = 67 THEN LET life2 = 0
IF spell = 68 THEN LET spell = 69
IF spell = 69 THEN PRINT "???"
IF spell = 70 THEN PRINT "W"
IF spell = 71 THEN PRINT "h"
IF spell = 71 THEN PRINT "a"
IF spell = 71 THEN PRINT "t"
IF spell = 71 THEN PRINT "?"
IF spell = 71 THEN PRINT "?"
IF spell = 71 THEN PRINT "?"
IF spell = 72 THEN PRINT "Your opponent is electrecuted!"
IF spell = 72 THEN LET life1 = life1 - 6
IF spell = 73 THEN PRINT "You have raised an undead warrior!"
IF spell = 73 THEN LET life1 = life1 - 5
IF spell = 74 THEN PRINT "Babababooom!!!"
IF spell = 74 THEN LET life1 = 2
IF spell = 75 THEN PRINT "You have cast the spell of mirror!"
IF spell = 75 THEN LET life2 = life1
IF spell = 76 THEN PRINT "You have created an enchanted weapon!"
IF spell = 76 THEN LET life1 = life1 - 6
IF spell = 77 THEN PRINT "Splat!"
IF spell = 77 THEN BEEP
IF spell = 77 THEN LET life1 = life1 - 4
IF spell = 78 THEN PRINT "Your hair has turned red!"
IF spell = 79 THEN PRINT "Don't move buddy!"
IF spell = 80 THEN PRINT "Ready,"
IF spell = 80 THEN PRINT "Steady,"
IF spell = 80 THEN PRINT "GO!!!"
IF spell = 80 THEN LET life1 = life1 - 7
IF spell = 81 THEN PRINT "The X-Files is rather good."
IF spell = 81 THEN LET life1 = 2
IF spell = 82 THEN PRINT "Babylon 5 is great!"
IF spell = 83 THEN PRINT "Zzzzap!"
IF spell = 83 THEN LET life1 = life1 - 5
IF spell = 84 THEN PRINT "You have turned your opponent into stone!"
IF spell = 84 THEN LET life1 = life1 - 9
IF spell = 85 THEN PRINT "Red lasers flash from your eyes!"
IF spell = 85 THEN LET life1 = life1 - 4
IF spell = 86 THEN PRINT "You have built a shield!"
IF spell = 86 THEN LET life2 = life2 + 4
IF spell = 87 THEN PRINT "You have gained magic armour!"
IF spell = 88 THEN LET life2 = life2 + 6
IF spell = 89 THEN PRINT "The ground swallows up your opponent!"
IF spell = 89 THEN LET life1 = life1 - 7
IF spell = 90 THEN PRINT "Lightning never strikes twice!"
IF spell = 91 THEN PRINT "Wierd-a-loony-fantastic-eye-boggling-mania!!!"
IF spell = 91 THEN LET life1 = 1
IF spell = 91 THEN LET life2 = 10
IF spell = 92 THEN PRINT "A tiger forms in the air and attacks your opponent!"
IF spell = 92 THEN LET life1 = life1 - 5
IF spell = 93 THEN PRINT "You'll be the death of your opponent one day!"
IF spell = 93 THEN LET life1 = life1 - life2
IF spell = 94 THEN PRINT "Fart the day of the right way!!!"
IF spell = 95 THEN PRINT
IF spell = 96 THEN PRINT
IF spell = 96 THEN LET life1 = life1 - 3
IF spell = 97 THEN PRINT "Your opponent comes out in red spots!"
IF spell = 97 THEN LET life1 = life1 - 1
IF spell = 98 THEN PRINT "A hideous monster appears and attacks your opponent!"
IF spell = 98 THEN LET life1 = life1 - 8
IF spell = 99 THEN PRINT "Happy Birthday!!!"
IF spell = 100 THEN PRINT "Do you know that this is the 100th spell?"
IF spell = 101 THEN PRINT "This cheat was made by David and Malcolm!!!!!!!"
IF spell = 101 THEN LET life1 = 1
IF spell = 101 THEN LET life2 = 10
COLOR 7
GOTO 7
4 IF one1$ = a$ AND two1$ = b$ AND three1$ = c$ THEN LET spell = 1
IF one1$ = d$ AND two1$ = e$ AND three1$ = f$ THEN LET spell = 2
IF one1$ = a$ AND two1$ = c$ AND three1$ = e$ THEN LET spell = 3
IF one1$ = c$ AND two1$ = a$ AND three1$ = b$ THEN LET spell = 4
IF one1$ = p$ AND two1$ = r$ AND three1$ = o$ THEN LET spell = 5
IF one1$ = c$ AND two1$ = a$ AND three1$ = r$ THEN LET spell = 6
IF one1$ = g$ AND two1$ = u$ AND three1$ = n$ THEN LET spell = 7
IF one1$ = g$ AND two1$ = n$ AND three1$ = u$ THEN LET spell = 8
IF one1$ = d$ AND two1$ = o$ AND three1$ = c$ THEN LET spell = 9
IF one1$ = d$ AND two1$ = o$ AND three1$ = b$ THEN LET spell = 10
IF one1$ = x$ AND two1$ = x$ AND three1$ = x$ THEN LET spell = 11
IF one1$ = p$ AND two1$ = o$ AND three1$ = d$ THEN LET spell = 12
IF one1$ = z$ AND two1$ = i$ AND three1$ = p$ THEN LET spell = 13
IF one1$ = p$ AND two1$ = o$ AND three1$ = w$ THEN LET spell = 14
IF one1$ = o$ AND two1$ = l$ AND three1$ = d$ THEN LET spell = 15
IF one1$ = d$ AND two1$ = o$ AND three1$ = g$ THEN LET spell = 16
IF one1$ = a$ AND two1$ = l$ AND three1$ = e$ THEN LET spell = 17
IF one1$ = b$ AND two1$ = a$ AND three1$ = r$ THEN LET spell = 18
IF one1$ = a$ AND two1$ = r$ AND three1$ = k$ THEN LET spell = 19
IF one1$ = p$ AND two1$ = i$ AND three1$ = n$ THEN LET spell = 20
IF one1$ = l$ AND two1$ = o$ AND three1$ = t$ THEN LET spell = 21
IF one1$ = b$ AND two1$ = a$ AND three1$ = n$ THEN LET spell = 22
IF one1$ = v$ AND two1$ = a$ AND three1$ = n$ THEN LET spell = 23
IF one1$ = t$ AND two1$ = i$ AND three1$ = p$ THEN LET spell = 24
IF one1$ = a$ AND two1$ = l$ AND three1$ = p$ THEN LET spell = 25
IF one1$ = o$ AND two1$ = n$ AND three1$ = e$ THEN LET spell = 26
IF one1$ = t$ AND two1$ = w$ AND three1$ = o$ THEN LET spell = 27
IF one1$ = t$ AND two1$ = u$ AND three1$ = b$ THEN LET spell = 28
IF one1$ = h$ AND two1$ = o$ AND three1$ = e$ THEN LET spell = 29
IF one1$ = w$ AND two1$ = h$ AND three1$ = o$ THEN LET spell = 30
IF one1$ = b$ AND two1$ = s$ AND three1$ = e$ THEN LET spell = 31
IF one1$ = m$ AND two1$ = o$ AND three1$ = p$ THEN LET spell = 32
IF one1$ = k$ AND two1$ = i$ AND three1$ = t$ THEN LET spell = 33
IF one1$ = d$ AND two1$ = i$ AND three1$ = g$ THEN LET spell = 34
IF one1$ = x$ AND two1$ = y$ AND three1$ = z$ THEN LET spell = 35
IF one1$ = f$ AND two1$ = a$ AND three1$ = b$ THEN LET spell = 36
IF one1$ = r$ AND two1$ = o$ AND three1$ = d$ THEN LET spell = 37
IF one1$ = p$ AND two1$ = i$ AND three1$ = t$ THEN LET spell = 38
IF one1$ = o$ AND two1$ = h$ AND three1$ = p$ THEN LET spell = 39
IF one1$ = t$ AND two1$ = o$ AND three1$ = p$ THEN LET spell = 40
IF one1$ = t$ AND two1$ = a$ AND three1$ = b$ THEN LET spell = 41
IF one1$ = c$ AND two1$ = o$ AND three1$ = p$ THEN LET spell = 42
IF one1$ = r$ AND two1$ = o$ AND three1$ = d$ THEN LET spell = 43
IF one1$ = o$ AND two1$ = r$ AND three1$ = c$ THEN LET spell = 44
IF one1$ = o$ AND two1$ = r$ AND three1$ = k$ THEN LET spell = 45
IF one1$ = d$ AND two1$ = i$ AND three1$ = e$ THEN LET spell = 46
IF one1$ = s$ AND two1$ = y$ AND three1$ = k$ THEN LET spell = 47
IF one1$ = w$ AND two1$ = v$ AND three1$ = m$ THEN LET spell = 48
IF one1$ = u$ AND two1$ = f$ AND three1$ = d$ THEN LET spell = 49
IF one1$ = a$ AND two1$ = s$ AND three1$ = d$ THEN LET spell = 50
IF one1$ = q$ AND two1$ = w$ AND three1$ = e$ THEN LET spell = 51
IF one1$ = z$ AND two1$ = x$ AND three1$ = c$ THEN LET spell = 52
IF one1$ = j$ AND two1$ = k$ AND three1$ = l$ THEN LET spell = 53
IF one1$ = p$ AND two1$ = o$ AND three1$ = i$ THEN LET spell = 54
IF one1$ = m$ AND two1$ = n$ AND three1$ = b$ THEN LET spell = 55
IF one1$ = f$ AND two1$ = g$ AND three1$ = h$ THEN LET spell = 56
IF one1$ = j$ AND two1$ = f$ AND three1$ = k$ THEN LET spell = 57
IF one1$ = s$ AND two1$ = a$ AND three1$ = d$ THEN LET spell = 58
IF one1$ = n$ AND two1$ = i$ AND three1$ = t$ THEN LET spell = 59
IF one1$ = r$ AND two1$ = t$ AND three1$ = y$ THEN LET spell = 60
IF one1$ = o$ AND two1$ = a$ AND three1$ = r$ THEN LET spell = 61
IF one1$ = w$ AND two1$ = s$ AND three1$ = j$ THEN LET spell = 62
IF one1$ = q$ AND two1$ = e$ AND three1$ = t$ THEN LET spell = 63
IF one1$ = w$ AND two1$ = r$ AND three1$ = y$ THEN LET spell = 64
IF one1$ = e$ AND two1$ = t$ AND three1$ = u$ THEN LET spell = 65
IF one1$ = r$ AND two1$ = y$ AND three1$ = i$ THEN LET spell = 66
IF one1$ = t$ AND two1$ = u$ AND three1$ = o$ THEN LET spell = 67
IF one1$ = y$ AND two1$ = i$ AND three1$ = p$ THEN LET spell = 68
IF one1$ = a$ AND two1$ = d$ AND three1$ = g$ THEN LET spell = 69
IF one1$ = s$ AND two1$ = f$ AND three1$ = h$ THEN LET spell = 70
IF one1$ = d$ AND two1$ = g$ AND three1$ = j$ THEN LET spell = 71
IF one1$ = f$ AND two1$ = h$ AND three1$ = k$ THEN LET spell = 72
IF one1$ = g$ AND two1$ = j$ AND three1$ = l$ THEN LET spell = 73
IF one1$ = z$ AND two1$ = c$ AND three1$ = b$ THEN LET spell = 74
IF one1$ = x$ AND two1$ = v$ AND three1$ = n$ THEN LET spell = 75
IF one1$ = c$ AND two1$ = b$ AND three1$ = m$ THEN LET spell = 76
IF one1$ = c$ AND two1$ = d$ AND three1$ = s$ THEN LET spell = 77
IF one1$ = r$ AND two1$ = i$ AND three1$ = b$ THEN LET spell = 78
IF one1$ = l$ AND two1$ = a$ AND three1$ = p$ THEN LET spell = 79
IF one1$ = d$ AND two1$ = a$ AND three1$ = v$ THEN LET spell = 80
IF one1$ = b$ AND two1$ = m$ AND three1$ = p$ THEN LET spell = 81
IF one1$ = w$ AND two1$ = a$ AND three1$ = v$ THEN LET spell = 82
IF one1$ = w$ AND two1$ = h$ AND three1$ = o$ THEN LET spell = 83
IF one1$ = w$ AND two1$ = r$ AND three1$ = i$ THEN LET spell = 84
IF one1$ = d$ AND two1$ = o$ AND three1$ = c$ THEN LET spell = 85
IF one1$ = a$ AND two1$ = r$ AND three1$ = t$ THEN LET spell = 86
IF one1$ = r$ AND two1$ = e$ AND three1$ = x$ THEN LET spell = 87
IF one1$ = c$ AND two1$ = o$ AND three1$ = d$ THEN LET spell = 88
IF one1$ = f$ AND two1$ = e$ AND three1$ = d$ THEN LET spell = 89
IF one1$ = r$ AND two1$ = e$ AND three1$ = d$ THEN LET spell = 90
IF one1$ = n$ AND two1$ = s$ AND three1$ = a$ THEN LET spell = 91
IF one1$ = f$ AND two1$ = b$ AND three1$ = i$ THEN LET spell = 92
IF one1$ = n$ AND two1$ = i$ AND three1$ = a$ THEN LET spell = 93
IF one1$ = w$ AND two1$ = h$ AND three1$ = y$ THEN LET spell = 94
IF one1$ = n$ AND two1$ = e$ AND three1$ = t$ THEN LET spell = 95
IF one1$ = q$ AND two1$ = w$ AND three1$ = e$ THEN LET spell = 96
IF one1$ = w$ AND two1$ = e$ AND three1$ = r$ THEN LET spell = 97
IF one1$ = e$ AND two1$ = r$ AND three1$ = t$ THEN LET spell = 98
IF one1$ = r$ AND two1$ = t$ AND three1$ = y$ THEN LET spell = 99
IF one1$ = t$ AND two1$ = y$ AND three1$ = u$ THEN LET spell = 100
IF one1$ = "W" AND two1$ = "i" AND three1$ = "n" THEN LET spell = 101
COLOR 2
IF spell = 1 THEN PRINT "A ball of fire flies from your hand!"
IF spell = 1 THEN LET life2 = life2 - 2
IF spell = 2 THEN PRINT "A bolt of lightning leaps from your finger tips!"
IF spell = 2 THEN LET life2 = life2 - 1
IF spell = 3 THEN PRINT "Some of your wounds have healed!"
IF spell = 3 THEN LET life1 = life1 + 1
IF spell = 4 THEN PRINT "You have gained super strength!!!"
IF spell = 4 THEN LET life1 = 10
IF spell = 5 THEN PRINT "Your spell has back-fired on yourself!"
IF spell = 5 THEN LET life1 = life1 - 3
IF spell = 6 THEN PRINT "Your opponent bursts into flames!"
IF spell = 6 THEN LET life2 = life2 - 5
IF spell = 7 THEN PRINT "You have cast healing upon yourself!"
IF spell = 7 THEN LET life1 = life1 + 3
IF spell = 8 THEN PRINT "You have summoned a demon of death!!!"
IF spell = 8 THEN LET life2 = 1
IF spell = 9 THEN PRINT "A swarm of hornets has attacked your opponent!"
IF spell = 9 THEN LET life2 = life2 - 4
IF spell = 10 THEN PRINT "Virtual Magic is a great game!!!"
IF spell = 10 THEN LET life1 = 10
IF spell = 10 THEN LET life2 = 10
IF spell = 11 THEN PRINT "You have cast the spell of equality!"
IF spell = 11 THEN LET life1 = 5
IF spell = 11 THEN LET life2 = 5
IF spell = 12 THEN PRINT "A cobra is attacking your opponent!"
IF spell = 12 THEN LET life2 = life2 - 2
IF spell = 13 THEN PRINT "There is a huge explosion between you and your opponent!"
IF spell = 13 THEN LET life1 = life1 - 1
IF spell = 13 THEN LET life2 = life2 - 1
IF spell = 14 THEN PRINT "Try casting: Wak-Yoo-Tog."
IF spell = 15 THEN PRINT "Try casting: Dir-Pos-Wir."
IF spell = 16 THEN PRINT "Try casting: Vas-Rof-Sho."
IF spell = 17 THEN PRINT "You have summoned Dave the Brave!!!"
IF spell = 17 THEN LET life2 = 1
IF spell = 18 THEN PRINT "Suddenly it begins to rain frogs!"
IF spell = 19 THEN PRINT "Nothing happens."
IF spell = 20 THEN LET life2 = life2 - 3
IF spell = 21 THEN PRINT "IT'S THE END OF THE WORLD!!!"
IF spell = 21 THEN END
IF spell = 22 THEN PRINT "You have poisoned your opponent!!!"
IF spell = 22 THEN LET life2 = life2 - 3
IF spell = 23 THEN PRINT "Whay do you get when you cross a sheep with a kangaroo?"
IF spell = 23 THEN PRINT "Cast Pos-Coz-Vas for the answer."
IF spell = 24 THEN PRINT "A wooly jumper!"
IF spell = 25 THEN PRINT "Your opponent is strangled by an invisible entity!"
IF spell = 25 THEN LET life2 = life2 - 5
IF spell = 26 THEN PRINT "A spell never includes two or more identical rune words."
IF spell = 27 THEN PRINT "Suddenly you have very bad cramp!"
IF spell = 27 THEN LET life1 = life1 - 1
IF spell = 28 THEN PRINT "A great, black bat attacks your opponent!"
IF spell = 28 THEN LET life2 = life2 - 4
IF spell = 29 THEN PRINT "Elvis is alive!!!"
IF spell = 30 THEN PRINT "You have killed your opponent!!!"
IF spell = 30 THEN LET life2 = 0
IF spell = 31 THEN PRINT "Pulses of electricity run through your opponent's body!"
IF spell = 31 THEN LET life2 = life2 - 3
IF spell = 32 THEN PRINT "Your opponent is sucked into the ground!"
IF spell = 33 THEN LET life2 = life2 - 4
IF spell = 34 THEN PRINT "Rock hard and hard rock!!!"
IF spell = 34 THEN LET life2 = 2
IF spell = 35 THEN PRINT "You have cast a spell of holding!!!"
IF spell = 35 THEN GOTO 20
IF spell = 36 THEN PRINT "You have entered a time warp!!!"
IF spell = 36 THEN LET life1 = 10
IF spell = 36 THEN LET life2 = 10
IF spell = 37 THEN PRINT "KABOOM!!!!!!"
IF spell = 37 THEN LET life1 = 1
IF spell = 37 THEN LET life2 = 1
IF spell = 38 THEN PRINT "You have cast the spell of speed and may cast another spell!!!"
IF spell = 38 THEN GOTO 20
IF spell = 39 THEN LET life2 = life2 - 4
IF spell = 40 THEN PRINT "You have cast the spell of weakness!"
IF spell = 40 THEN LET life2 = life2 - 5
IF spell = 41 THEN PRINT "Your opponent starts drowning on air!!!"
IF spell = 41 THEN LET life2 = life2 - 7
IF spell = 42 THEN PRINT "Hdgwnconsan;o!!!"
IF spell = 43 THEN PRINT "I'm sorry but I don't feel like casting that spell."
IF spell = 44 THEN PRINT "Sorry. That spell is out of order."
IF spell = 45 THEN PRINT "Baboom!!!"
IF spell = 45 THEN LET life2 = life2 - 5
IF spell = 46 THEN PRINT "What?"
IF spell = 47 THEN BEEP
IF spell = 48 THEN PRINT "You have cast the spell of falling!!!"
IF spell = 48 THEN BEEP
IF spell = 48 THEN BEEP
IF spell = 48 THEN BEEP
IF spell = 48 THEN BEEP
IF spell = 48 THEN BEEP
IF spell = 48 THEN BEEP
IF spell = 48 THEN PRINT "Ha, ha!!!"
IF spell = 48 THEN LET life2 = life2 - 10
IF spell = 49 THEN PRINT "AAAAAAAAAAAAAAGGGGHHH!!!"
IF spell = 49 THEN LET life2 = life2 - 8
IF spell = 50 THEN PRINT "Wimp."
IF spell = 50 THEN BEEP
IF spell = 50 THEN LET life1 = 1
IF spell = 51 THEN PRINT "Your opponent's blood begins to boil!"
IF spell = 51 THEN LET life2 = life2 - 5
IF spell = 52 THEN PRINT "Your wounds have healed."
IF spell = 52 THEN LET life1 = 10
IF spell = 53 THEN CLS
IF spell = 54 THEN PRINT "Finish him!!!"
IF spell = 54 THEN LET life2 = 1
IF spell = 54 THEN GOTO 20
IF spell = 55 THEN PRINT "You have tilted the scales of Libra!"
IF spell = 55 THEN LET life2 = 1
IF spell = 55 THEN LET life1 = 10
IF spell = 56 THEN PRINT "You cast the spell of love and have fallen in love"
IF spell = 56 THEN PRINT "with your opponent and don't want to try and kill them!!!"
IF spell = 56 THEN END
IF spell = 57 THEN PRINT "SYNTAX ERROR: IDIOT ATTEMPTING TO CAST SPELL>"
IF spell = 58 THEN PRINT "Your too dumb to be able to cast spell!!!"
IF spell = 59 THEN PRINT "What ever your do, don't cast Til-Shi-Pos!"
IF spell = 60 THEN PRINT "Laser beams flash from your eyes and kill your opponent!!!"
IF spell = 60 THEN LET life2 = 0
IF spell = 61 THEN PRINT "A thick poisonus fog surrounds your opponent!"
IF spell = 61 THEN LET life2 = life2 - 4
IF spell = 61 THEN GOTO 5
IF spell = 61 THEN PRINT "You freeze your opponent!"
IF spell = 61 THEN LET life2 = life2 - 3
IF spell = 62 THEN PRINT "Your opponent's heart misses a few beats!"
IF spell = 62 THEN LET life2 = life2 - 8
IF spell = 63 THEN PRINT "Suddenly you are compelled to nut your opponent!"
IF spell = 63 THEN LET life2 = life2 - 2
IF spell = 64 THEN PLAY VARPTR$(cccd)
IF spell = 65 THEN PRINT "A lemming falls from the sky and hits your opponent on the head!"
IF spell = 65 THEN LET life2 = life2 - 2
IF spell = 66 THEN PRINT "You summon a dragon and kill your opponent!!!"
IF spell = 66 THEN LET life2 = -10
IF spell = 67 THEN PRINT "You have cast the spell of suicide!!!"
IF spell = 67 THEN LET life1 = 0
IF spell = 68 THEN LET spell = 69
IF spell = 69 THEN PRINT "???"
IF spell = 70 THEN PRINT "W"
IF spell = 71 THEN PRINT "h"
IF spell = 71 THEN PRINT "a"
IF spell = 71 THEN PRINT "t"
IF spell = 71 THEN PRINT "?"
IF spell = 71 THEN PRINT "?"
IF spell = 71 THEN PRINT "?"
IF spell = 72 THEN PRINT "Your opponent is electrecuted!"
IF spell = 72 THEN LET life2 = life2 - 6
IF spell = 73 THEN PRINT "You have raised an undead warrior!"
IF spell = 73 THEN LET life2 = life2 - 5
IF spell = 74 THEN PRINT "Babababooom!!!"
IF spell = 74 THEN LET life2 = 2
IF spell = 75 THEN PRINT "You have cast the spell of mirror!"
IF spell = 75 THEN LET life1 = life2
IF spell = 76 THEN PRINT "You have created an enchanted weapon!"
IF spell = 76 THEN LET life2 = life2 - 6
IF spell = 77 THEN PRINT "Splat!"
IF spell = 77 THEN BEEP
IF spell = 77 THEN LET life2 = life2 - 4
IF spell = 78 THEN PRINT "Your hair has turned red!"
IF spell = 79 THEN PRINT "Don't move buddy!"
IF spell = 80 THEN PRINT "Ready,"
IF spell = 80 THEN PRINT "Steady,"
IF spell = 80 THEN PRINT "GO!!!"
IF spell = 80 THEN LET life2 = life2 - 7
IF spell = 101 THEN PRINT "This cheat was made by David and Malcolm!!!!!!!"
IF spell = 101 THEN LET life1 = 1
IF spell = 101 THEN LET life2 = 10
COLOR 7
GOTO 5
10 COLOR 9
PRINT name1$; " is dead!!!  Thus leaving "; name2$; " as the winner!!!"
COLOR 7
END
11 COLOR 9
PRINT name2$; " is dead!!!  Thus leaving "; name1$; " as the winner!!!"
COLOR 7
END

