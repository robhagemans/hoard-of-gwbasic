CLS
INPUT "Do you want Sound ON or OFF"; sound$
CLS
10 PRINT "                        4  PLAYER  DODGEBALL"
20 PRINT ""
30 IF sound$ <> "OFF" THEN PLAY "o3l2aabcadbceffefdcl16aagdcbeadffcbdeedee"
40 PRINT "The rules are:"
50 PRINT "Player#1 goes first. He choses which player he is goiong"
60 PRINT "to throw at. Then Player#2 goes. Eventually, one Player will"
70 PRINT "be knocked out of the game. It keeps on going until all but one"
80 PRINT "Player is knocked out. That one wins."
90 PRINT ""
100 INPUT "Who is Player#1 "; name1$
110 INPUT "Who is Player#2 "; name2$
120 INPUT "Who is Player#3 "; name3$
130 INPUT "Who is Player#4 "; name4$
140 PRINT ""
150 PRINT "Each player starts out with 25 hit points."
160 life1 = 25
170 life2 = 25
180 life3 = 25
190 life4 = 25
200 PRINT "                         LET THE GAMES BEGIN!!"
210 IF sound$ <> "OFF" THEN PLAY "o3l5al16bl5cl1c"
220 PRINT ""
225 IF life1 < 1 THEN GOTO 420
230 PRINT "It is "; name1$; "'s turn."
240 INPUT "Who do you want to throw at? (if everyone else is out, type None)", throw$
250 IF throw$ = name2$ THEN GOTO 260 ELSE GOTO 310
260 PRINT "And "; name2$; " is hit!"
270 life2 = life2 - INT(RND * (10 - 0) + 0)
280 IF life2 < 1 THEN PRINT "And "; name2$; " is out!!"
290 PRINT " "; name2$; " has "; life2; " hit points remaining."
300 GOTO 420
310 IF throw$ = name3$ THEN GOTO 320 ELSE GOTO 370
320 PRINT "And "; name3$; " is hit!"
330 life3 = life3 - INT(RND * (10 - 0) + 0)
340 IF life3 < 1 THEN PRINT "And "; name3$; " is out!"
350 PRINT " "; name3$; " has "; life3; " hit points remaining."
360 GOTO 420
370 IF throw$ = name4$ THEN GOTO 380 ELSE GOTO 420
380 PRINT "And "; name4$; " is hit!"
390 life4 = life4 - INT(RND * (10 - 0) + 0)
400 IF life4 < 1 THEN PRINT "And "; name4$; " is out!"
410 PRINT " "; name4$; " has "; life4; " hit points remaining."
420 PRINT ""
425 IF throw$ = "None" THEN GOTO 1060
430 IF life2 < 1 THEN GOTO 610
440 PRINT "It is "; name2$; "'s turn."
450 INPUT "Who do you want to throw at? (if everyone else is out, type None) ", throw$
460 IF throw$ = name1$ THEN GOTO 470 ELSE GOTO 510
470 PRINT "And "; name1$; " is hit!"
480 life1 = life1 - INT(RND * (10 - 0) + 0)
490 IF life1 < 1 THEN PRINT "And "; name1$; " is out!"
500 PRINT " "; name1$; " has "; life1; " hit points remaining."
510 IF throw$ = name3$ THEN GOTO 520 ELSE GOTO 560
520 PRINT "And "; name3$; " is hit!"
530 life3 = life3 - INT(RND * (10 - 0) + 0)
540 IF life4 < 1 THEN PRINT "And "; name3$; " is out!"
550 PRINT " "; name3$; " has "; life3; " hit points remaining."
560 IF throw$ = name4$ THEN GOTO 570 ELSE GOTO 610
570 PRINT "And "; name4$; " is hit!"
580 life4 = life4 - INT(RND * (10 - 0) + 0)
590 IF life4 < 1 THEN PRINT "And "; name4$; " is out!"
600 PRINT " "; name4$; " has "; life4; " hit points remaining."
610 PRINT ""
620 IF throw$ = "None" THEN GOTO 1090
630 IF life3 < 1 THEN GOTO 810
640 PRINT "It is "; name3$; "'s turn."
650 INPUT "Who do you want to throw at? (if everyone else is out, type None) ", throw$
660 IF throw$ = name1$ THEN GOTO 670 ELSE GOTO 710
670 PRINT "And "; name1$; " is hit!"
680 life1 = life1 - INT(RND * (10 - 0) + 0)
690 IF life1 < 1 THEN PRINT "And "; name1$; " is out!"
700 PRINT " "; name1$; " has "; life1; " hit points remaining."
710 IF throw$ = name2$ THEN GOTO 720 ELSE GOTO 760
720 PRINT "And "; name2$; " is hit!"
730 life2 = life2 - INT(RND * (10 - 0) + 0)
740 IF life2 < 1 THEN PRINT "And "; name2$; " is out!"
750 PRINT " "; name2$; " has "; life2; " hit points remaining."
760 IF throw$ = name4$ THEN GOTO 770 ELSE GOTO 810
770 PRINT "And "; name4$; " is hit!"
780 life4 = life4 - INT(RND * (10 - 0) + 0)
790 IF life4 < 1 THEN PRINT "And "; name4$; " is out!"
800 PRINT " "; name4$; " has "; life4; " hit points remaining."
810 PRINT ""
820 IF throw$ = "None" THEN GOTO 1120
830 IF life4 < 1 THEN GOTO 1020
840 PRINT "It is "; name4$; "'s turn."
850 INPUT "Who do you want to throw at? (if everyone else is out, type None) ", throw$
860 IF throw$ = name1$ THEN GOTO 870 ELSE GOTO 920
870 PRINT "And "; name1$; " is hit!"
890 life1 = life1 - INT(RND * (10 - 0) + 0)
900 IF life1 < 1 THEN PRINT "And "; name1$; " is out!"
910 PRINT " "; name1$; " has "; life1; " hit points remaining."
920 IF throw$ = name2$ THEN GOTO 930 ELSE GOTO 970
930 PRINT "And "; name2$; " is hit!"
940 life2 = life2 - INT(RND * (10 - 0) + 0)
950 IF life2 < 1 THEN PRINT "And "; name2$; " is out!"
960 PRINT " "; name2$; " has "; life2; " hit points remaining."
970 IF throw$ = name3$ THEN GOTO 980 ELSE GOTO 1020
980 PRINT "And "; name3$; " is hit!"
990 life3 = life3 - INT(RND * (10 - 0) + 0)
1000 IF life3 < 1 THEN PRINT "And "; name3$; " is out!"
1010 PRINT " "; name3$; " has "; life3; " hit points remaining."
1020 PRINT ""
1030 IF throw$ = "None" THEN GOTO 1150
1040 GOTO 225
1050 PRINT ""
1060 PRINT " "; name1$; " is the supreme ruler!"
1070 IF sound$ <> "OFF" THEN PLAY "o3l16aabbcaabbcaabbcdefacbfgfg"
1080 GOTO 1170
1090 PRINT " "; name2$; " cremated everyone else!"
1100 IF sound$ <> "OFF" THEN PLAY "o4l5aal2bl5aal1c"
1110 GOTO 1170
1120 PRINT " "; name3$; " is the master of dodgeball players!"
1130 IF sound$ <> "OFF" THEN PLAY "o4l7gfcbaeddedcbal16o4cfgp3aacbp5ab"
1140 GOTO 1170
1150 PRINT " "; name4$; " wins with "; life4; " hit points left!"
1160 IF sound$ <> "OFF" THEN PLAY "o4l2aabbcdgfbp3l4bl2p3l4bl2p3l2a"
1170 PLAY "o1l1p4p4p4p4p4p4"
CLS
INPUT "Do you wish to play again (y or n)"; play$
IF play$ = "y" THEN GOTO 10 ELSE END


