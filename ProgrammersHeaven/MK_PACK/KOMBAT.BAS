CLS
1 INPUT "Sorry, you need a password to play this game. ", password$














































































































5 IF password$ = "wolf3d" THEN GOTO 7 ELSE END
7 PRINT ""
8 INPUT "Do you want Sound ON or OFF"; sound$
CLS
9 PRINT ""
10 PRINT "                                  MORTAL KOMBAT"
20 PRINT ""
30 IF sound$ = "OFF" THEN PLAY "o3l4p4p4p4p4p4p4p4" ELSE PLAY "o2l2cabdeel1ep2o3l5cabdeel1e"
40 PRINT "Welcome to the Mortal Kombat tournament."
50 PRINT "This is a 2-Player game."
60 PRINT "Player#1 has a stronger offense."
70 PRINT "Player#2 has a stronger defense."
80 PRINT "They take turns punching and kicking each othher."
90 PRINT "Type capitol P to punch, and capitol K to kick."
100 PRINT "Keep on repeating until one player is in a swoon."
110 PRINT "Then the winning player will have a chance to Finish the losing"
120 PRINT "player."
130 PRINT ""
140 PLAY "l1p10"
150 PRINT "Here are the names of the characters you can be."
160 PLAY "o1l1p3"
170 PRINT "Johnny Cage"
180 PLAY "l1p3"
190 PRINT "Scorpion"
200 PLAY "l1p3"
210 PRINT "Sub-Zero"
220 PLAY "l1p3"
230 PRINT "Liu Kang"
240 PLAY "l1p3"
250 PRINT "Raiden"
260 PLAY "l1p3"
270 PRINT "Sonya"
280 PLAY "l1p3"
290 PRINT "Kano"
300 PLAY "l1p3"
310 PRINT ""
320 INPUT "Who is Player#1 "; name1$
330 INPUT "Who is Player#2 "; name2$
340 PRINT "Player 1, thank you for selecting "; name1$; "."
350 PRINT "Player 2, thank you for selecting "; name2$; "."
360 PLAY "l1p2p2p2p2"
370 PRINT ""
380 PRINT "                                "; name1$; "   VS.   "; name2$; "  "
390 IF sound$ = "OFF" THEN PLAY "o2l1p3p3p3p3p3p3p3p3" ELSE PLAY "o3l16aabbccddeeffggp7l2abcdcbadggfc"
391 life1 = 40
392 life2 = 50
400 PRINT ""
410 PRINT "It is "; name1$; "'s turn."
420 INPUT "Do you want to punch or kick your opponent "; atck$
430 IF atck$ = "P" THEN life2 = life2 - INT(RND * (9 - 3) + 3)
440 IF atck$ = "K" THEN life2 = life2 - INT(RND * (11 - 0) + 0)
450 IF life2 < 1 THEN GOTO 550
460 PRINT " "; name2$; " has "; life2; " life remaining."
470 PRINT ""
480 PRINT "It is "; name2$; "'s turn."
490 INPUT "Do you want to punch or kick your opponent "; atck$
500 IF atck$ = "P" THEN life1 = life1 - INT(RND * (7 - 2) + 2)
510 IF atck$ = "K" THEN life1 = life1 - INT(RND * (9 - 0) + 0)
520 IF life1 < 1 THEN GOTO 1050
530 PRINT " "; name1$; " has "; life1; " life remaining."
540 GOTO 400
550 PRINT ""
560 PRINT "                        FINISH HIM!!!   "
570 INPUT "Do you want to finish your opponent "; finish$
580 IF finish$ = "Yes" THEN GOTO 590 ELSE END
590 IF name1$ = "Johnny Cage" THEN GOTO 660
600 IF name1$ = "Scorpion" THEN GOTO 720
610 IF name1$ = "Sub-Zero" THEN GOTO 780
620 IF name1$ = "Liu Kang" THEN GOTO 830
630 IF name1$ = "Raiden" THEN GOTO 880
640 IF name1$ = "Sonya" THEN GOTO 950
650 IF name1$ = "Kano" THEN GOTO 1010
660 PRINT "And with that, Johnny Cage lowers his arm for the final"
670 PRINT "blow... a very powerful blow. Then he delivers an uppercut!"
680 PRINT "The uppercut has so much power that it literally knocks"
690 PRINT "his opponent's head off!! Blood sprays everywhere."
700 IF sound$ <> "OFF" THEN PLAY "o1l1a"
710 END
720 PRINT "Suddenly, Scorpion tears off his mask. Now revealed, is a "
730 PRINT "hideous skull with burning red eyes. Then giant flames"
740 PRINT "fly from between his jaws, incinerating his opponent to a"
750 PRINT "charred black skeleton."
760 IF sound$ <> "OFF" THEN PLAY "o1l1a"
770 END
780 PRINT "Suddenly, Sub-Zero grabs his opponent by the neck. Then he pulls,"
790 PRINT "hard. In result, his opponent's head is ripped off, with the"
800 PRINT "spine dangling down."
810 IF sound$ <> "OFF" THEN PLAY "o1l1a"
820 END
830 PRINT "Liu Kang then gives his opponent a powerful scissor kick,"
840 PRINT "followed by the most pewerful uppercut seen yet, which knocks"
850 PRINT "his opponent into the air and then he lands, hard."
860 IF sound$ <> "OFF" THEN PLAY "o1l1a"
870 END
880 PRINT "Then the thunder god extends his arms towards his opponent."
890 PRINT "Suddenly, electricity shoots out of his finger tips and wraps"
900 PRINT "around his opponent's head. With 90,000 volts running through"
910 PRINT "it, his opponent's head expands and explodes!! Blood is "
920 PRINT "everywhere."
930 IF sound$ <> "OFF" THEN PLAY "o1l1a"
940 END
950 PRINT "Sonya looks as if she is going to blow her opponent a last kiss,"
960 PRINT "but instead a fireball escapes from her mouth! It does a loop in"
970 PRINT "the air, and then heads straight for her opponent. It hits its "
980 PRINT "mark, and her opponent is burned to a blackened skeleton!"
990 IF sound$ <> "OFF" THEN PLAY "o1l1a"
1000 END
1010 PRINT "With one powerful stroke, Kano plunges his hand into his "
1020 PRINT "opponent's chest and pulls it out again, tearing out their heart!"
1030 IF sound$ <> "OFF" THEN PLAY "o1l1a"
1040 END
1050 PRINT ""
1060 PRINT "                           FINISH HIM!!"
1070 INPUT "Do you want to finish your opponent "; finish$
1080 IF finish$ = "Yes" THEN GOTO 1090 ELSE END
1090 IF name2$ = "Johnny Cage" THEN GOTO 660
1100 IF name2$ = "Scorpion" THEN GOTO 720
1110 IF name2$ = "Sub-Zero" THEN GOTO 780
1120 IF name2$ = "Liu Kang" THEN GOTO 830
1130 IF name2$ = "Raiden" THEN GOTO 880
1140 IF name2$ = "Sonya" THEN GOTO 950
1150 IF name2$ = "Kano" THEN GOTO 1010
1160 END

