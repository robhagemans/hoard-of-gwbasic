CLS
10 PRINT ""
15 INPUT "Do you want 2 player mode or 1 player mode "; mode
20 PRINT "Welcome to the Street Fighter II: Champion Edition Tournament!"
25 PLAY "o3l4abcdefggaggaddedaccag"
26 INPUT "Do you want to skip the introduction "; skip$
27 IF skip$ = "Yes" THEN GOTO 370
30 PRINT "In this nationaly-televised fighting tournament,"
40 PRINT "eight fighters from across the globe meet to see which has "
50 PRINT "the strength, skill, power, and all-out courage to be "
60 PRINT "proclaimed as the World Warrior!"
70 PRINT ""
75 PLAY "o3l4abcdabcabaccabcda"
80 PRINT ""
90 PRINT "From the U.S.A., trained by martial arts master Sheng Long, Ken!"
100 PLAY "o5l2abcdeffg"
110 PRINT "From Russia, former wrestler who now wrestles bears for fun, Zangief!"
120 PLAY "o1l4abba"
130 PRINT "From Japan, also trained by Sheng Long, Ryu!"
140 PLAY "o3l4acba"
150 PRINT "From the U.S.A., former heavyweight boxer, Balrog!"
160 PLAY "o2l4acbac"
170 PRINT "From China, entering the tournament so she can avenge her father's death by"
180 PRINT "M. Bison, Chun Li!"
190 PLAY "o5l4bcbccba"
200 PRINT "From India, he has the ability to blow flames from his mouth, Dhalsim!"
210 PLAY "o2l6edcbaabcde"
220 PRINT "From Brazil, the half-man, half-beast, Blanka!"
230 PLAY "o1l4bcddcbcdd"
240 PRINT "From Spain, who improves his skills by fighting bulls with his steel claws"
250 PRINT "he wears on his hands, Vega!"
260 PLAY "o5l8ddecddaabbccddaaggddaabbccbbcdefggaaa"
270 PRINT "From Japan, the sumo wrestler, E. Honda!"
280 PLAY "o2l2baabc"
290 PRINT "From the U.S.A., U.S. Airforce Pilot, Guile!"
300 PLAY "o3l4aabbl6cdel4aabbl6cdeaa"
310 PRINT "From Thailand, former World Warrior, kickboxer Sagat!"
320 PLAY "o3l4acegl8gfedcbaa"
330 PRINT "And from Thailand, current World Warrior, the dictator who seems obsessed"
340 PRINT "on being the world leader, M. Bison!"
350 PLAY "o1l1dcbaaa"
360 PRINT ""
370 PRINT ""
375 IF mode = 2 THEN GOTO 3150
380 INPUT "Who do you want to be? (Please spell name correctly with capitals) ", character$
390 PRINT "Thank you for selecting "; character$; " as your character."
400 PRINT ""
410 PRINT ""
420 PRINT "The rules are "; character$; " will travel around the globe to fight the"
430 PRINT "eleven other challengers. You will have to pick a number between so-and-so"
440 PRINT "and so-and-so. If you get it right, your opponent will be defeated."
450 PRINT "If you get it wrong, your opponent will hit you once. "
460 PRINT "If "; character$; " gets hit 3 times, he/she will be defeated."
470 PRINT ""
480 PRINT ""
490 IF character$ = "Ryu" THEN INPUT "Your special moves are: Fireball, Tornado Kick, and Dragon Punch. Which       one do you want "; move$
500 IF character$ = "E. Honda" THEN INPUT "Your special moves are: Sumo Headbutt, and Hundred Hand Slap. Which one do       you want "; move$
510 IF character$ = "Blanka" THEN INPUT "Your special moves are: Roll Attack, and Electricity. Which one do you want "; move$
520 IF character$ = "Guile" THEN INPUT "Your special moves are: Knee Thrust, Sonic Boom, and Flash Kick. Which one    do you want "; move$
530 IF character$ = "Balrog" THEN INPUT "Your special moves are: Power Punch, and Sliding Uppercut. Which one do you    want "; move$
540 IF character$ = "Vega" THEN INPUT "Your special moves are: Flying Slash, Rolling Slash. Which one do you want "; move$
550 IF character$ = "Ken" THEN INPUT "Your special moves are: Fireball, Tornado Kick, and Dragon Punch. Which one do    you want "; move$
560 IF character$ = "Chun Li" THEN INPUT "Your special moves are: Flying Bird Kick, and Lightning Kick. Which one do you    want "; move$
570 IF character$ = "Zangief" THEN INPUT "Your special moves are: Spinning Punch, and Spinning Pile Driver. Which one do    you want "; move$
580 IF character$ = "Dhalsim" THEN INPUT "Your special moves are: Yoga Fire, and Yoga Flame. Which one do you want "; move$
590 IF character$ = "Sagat" THEN INPUT "Your special moves are: Tiger Fireball, and Tiger Uppercut. Which one do you      want "; move$
600 IF character$ = "M. Bison" THEN INPUT "Your special moves are: Flying Double Kick, and Flaming Torpedo. Which one do you    want "; move$
610 PRINT ""
620 PRINT ""
630 PRINT "         LET THE FIGHTS BEGIN!!!"
635 PLAY "o3l4aabbl7cdel4aabbl7cdel4aabbl7cdel4aaa"
640 LET life = 3
650 PRINT ""
660 IF character$ = "Ryu" THEN GOTO 750
670 PRINT "               "; character$; "   VS.   Ryu"
690 INPUT "Please select a number between 1 and 3.", number
700 WHILE number < 2 OR number > 2
710 PRINT "Sorry. Ryu hits "; character$; " !"
720 life = life - 1
725 INPUT "Please re-enter selection.", number
726 IF life = 0 THEN END
730 WEND
740 IF number = 2 THEN PRINT "Great! "; character$; " defeats Ryu!"
750 PRINT ""
760 LET life = 3
770 IF character$ = "E. Honda" THEN GOTO 860
780 PRINT "                "; character$; "   VS.   E. Honda"
790 INPUT "Please select a number between 1 and 3.", number
800 WHILE number < 3 OR number > 3
810 PRINT "Incorrect. E. Honda hits "; character$; " !"
820 life = life - 1
825 INPUT "Please re-enter selection.", number
826 IF life = 0 THEN END
830 WEND
850 IF number = 3 THEN PRINT "Terrific! "; character$; " whips E. Honda with "; move$; " !"
860 LET life = 3
870 PRINT ""
880 IF character$ = "Blanka" THEN GOTO 980
890 PRINT "                "; character$; "   VS.   Blanka"
900 INPUT "Please select a number between 1 and 4. ", number
910 WHILE number < 1 OR number > 1
920 PRINT "Sorry, sucker. Blanka hits "; character$; " !"
930 life = life - 1
935 IF life = 0 THEN END
940 INPUT "Please re-enter your selection. ", number
950 WEND
970 IF number = 1 THEN PRINT "Ouch! Blanka is defeated by "; character$; "'s "; move$; " !"
980 LET life = 3
990 PRINT ""
1000 IF character$ = "Guile" THEN GOTO 1100
1010 PRINT "                 "; character$; "   VS.   Guile"
1020 INPUT "Please select a number between 1 and 5. ", number
1030 WHILE number < 3 OR number > 3
1040 PRINT "Nope. Guile hits "; character$; " with the Sonic Boom!"
1050 life = life - 1
1060 INPUT "Please re-enter your selection. ", number
1070 IF life = 0 THEN END
1080 WEND
1090 IF number = 3 THEN PRINT "Awesome! "; character$; " defeats Guile!"
1100 LET life = 3
1110 PRINT ""
1120 IF character$ = "Balrog" THEN GOTO 1220
1130 PRINT "                 "; character$; "   VS.   Balrog"
1140 INPUT "Please select a number between 1 and 6. ", number
1150 WHILE number < 2 OR number > 2
1160 PRINT "Wrong. Balrog sinks his gloves into the face of "; character$; " !"
1170 life = life - 1
1180 INPUT "Please re-enter your selection. ", number
1190 IF life = 0 THEN END
1200 WEND
1210 IF number = 2 THEN PRINT "Holy Cow! "; character$; " destroyed Balrog!"
1220 LET life = 3
1230 PRINT ""
1240 IF character$ = "Vega" THEN GOTO 1340
1250 PRINT "          "; character$; "   VS.   Vega"
1260 INPUT "Please select a number from 1 to 7. ", number
1270 WHILE number < 6 OR number > 6
1280 PRINT "Ooch. "; character$; " just got clawed in the face by Vega's steel claws!"
1290 life = life - 1
1300 INPUT "Please re-enter your selection. ", number
1310 IF life = 0 THEN END
1320 WEND
1330 IF number = 6 THEN PRINT "And "; character$; " finishes Vega off with the "; move$; " !"
1340 PRINT ""
1350 PRINT "   |   |  ----    |    ----       -----    |    -- --   ----"
1360 PRINT "   |---| |----|   |   |--           |      |   |  |  | |--  "
1370 PRINT "   |   | |    |   |__ |             |      |   |     | |____"
1380 PLAY "o3l3abcdgffal9abcdefgl3aabbcdal6defl3o4ggo3fo4ggo3l7fedcbaa"
1390 PRINT ""
1400 PRINT ""
1410 PRINT "AND NOW, STRAIGHT FROM HAWAII, COME THE HONALULU BELLY DANCERS!"
1420 PLAY "o3l7abcdefgaacfa"
1430 PRINT ""
1440 PRINT "Just Kidding."
1450 PLAY "o2l2cbo1l1a"
1460 PRINT ""
1470 PRINT ""
1480 PRINT "Well, Jim Kline here. It seems that "; character$; " is doing really well!"
1490 PRINT "The action has really been heating up. With the "; move$; " "; character$; "'s really been"
1500 PRINT "kicking some butt! I wonder if he/she will ever make it to that guy... what was it's name?"
1510 PRINT ""
1520 PRINT ""
1530 PLAY "o3l3abcddefaacdeeac"
1540 PRINT "                   AND NOW BACK TO THE FIGHTS!!"
1550 PLAY "o4l4 defaa"
1560 PRINT ""
1570 LET life = 3
1580 PRINT ""
1590 IF character$ = "Ken" THEN GOTO 1690
1600 PRINT "               "; character$; "   VS.   Ken"
1610 INPUT "Please select a number between 1 and 7. ", number
1620 WHILE number < 4 OR number > 4
1630 PRINT "And "; character$; " is nailed!"
1640 life = life - 1
1650 INPUT "Please re-enter selection. ", number
1660 IF life = 0 THEN END
1670 WEND
1680 IF number = 4 THEN PRINT "Man! "; character$; " really wasted Ken!"
1690 LET life = 3
1700 PRINT ""
1710 IF character$ = "Chun Li" THEN GOTO 1810
1720 PRINT "               "; character$; "   VS.   Chun Li"
1730 INPUT "Please select a number from 1 to 8. ", number
1740 WHILE number < 6 OR number > 6
1750 PRINT "Man, that had to hurt. A powerful kick by Chun Li!"
1760 life = life - 1
1770 INPUT "Please re-enter your selection. ", number
1780 IF life = 0 THEN GOTO 1570
1790 WEND
1800 IF number = 6 THEN PRINT "Can you imagine that! "; character$; " just beat up a girl!"
1810 LET life = 3
1820 PRINT ""
1830 IF character$ = "Zangief" THEN GOTO 1930
1840 PRINT "               "; character$; "   VS.   Zangief"
1850 INPUT "Please enter a number between 1 and 9.  ", number
1860 WHILE number < 3 OR number > 3
1870 PRINT "Ouch! And Zangief nails "; character$; " with a Spinning Piledriver!"
1880 life = life - 1
1890 INPUT "Please re-enter your selection. ", number
1900 IF life = 0 THEN GOTO 1570
1910 WEND
1920 IF number = 3 THEN PRINT "And Zangief is smashed by a "; move$; " !"
1930 LET life = 3
1940 PRINT ""
1950 IF character$ = "Dhalsim" THEN GOTO 2050
1960 PRINT "               "; character$; "   VS.   Dhalsim"
1970 INPUT "Please pick a number between 1 and 9. ", number
1980 WHILE number < 5 OR number > 5
1990 PRINT "Oh, man. "; character$; " really got burned by Dhalsim's Yoga Flame!"
2000 life = life - 1
2010 INPUT "Please re-enter your choice. ", number
2020 IF life = 0 THEN GOTO 1570
2030 WEND
2040 IF number = 5 THEN PRINT "Ouch. What a powerful "; move$; " Dhalsim got in the face!"
2050 LET life = 3
2060 PRINT ""
2070 IF character$ = "Sagat" THEN GOTO 2170
2080 PRINT "               "; character$; "   VS.   Sagat"
2090 INPUT "Please select a number between 1 and 10. ", number
2100 WHILE number < 10 OR number > 10
2110 PRINT "And Sagat delivers a powerful Tiger Uppercut to "; character$; "'s chin !"
2120 life = life - 1
2130 INPUT "Please re-enter your selection. ", number
2140 IF life = 0 THEN GOTO 1570
2150 WEND
2160 IF number = 10 THEN PRINT "And Sagat is Defeated!!"
2170  LET life = 3
2180 PRINT ""
2190 IF character$ = "M. Bison" THEN GOTO 2330
2200 PRINT "               "; character$; "   VS.   M. Bison"
2210 INPUT "Please select a number between 1 and 11. ", number
2220 WHILE number < 7 OR number > 7
2230 PRINT "And "; character$; " is severely burned by M. Bison's Flaming Torpedo!"
2240 life = life - 1
2250 INPUT "Please re-enter your selection. ", number
2260 IF life = 0 THEN GOTO 1570
2270 WEND
2280 IF number = 7 THEN PRINT "Well, that's the end of Mr. Nazi!"
2330 LET life = 5
2340 PRINT ""
2350 PRINT ""
2360 PRINT " Well, it seems that "; character$; " has won the tournament and "
2370 PRINT " has become the World War...Wait a minute!"
2375 PLAY "o1l9abcdefbb"
2380 PRINT "Another guy has just entered the tournament!!"
2390 PRINT "Could it be...? It is! The person who has entered the "
2400 PRINT "tournament is the infamous ninja, Reptile!"
2410 PRINT "It seems "; character$; " will have to fight him."
2420 PRINT "But I'm warning you, "; character$; ". This guy kills for fun!"
2430 PLAY "o3l7aabbccddeeffaa"
2440 PRINT ""
2450 PRINT "Rules: You have 5 chances to guess the number between 1 and 30."
2460 PRINT "We will tell you if the number is higher or lower than the one"
2470 PRINT "you just guessed. Good Luck!"
2480 PRINT ""
2490 PRINT "                   "; character$; "   VS.   REPTILE"
2500 PLAY "o3l8abacadaeafaggg"
2510 INPUT "Please select a number between 1 and 30. ", number
2520 WHILE number < 13
2530 PRINT "And "; character$; "'s left side is cut severely by Reptile's sword!!"
2540 INPUT "The number is higher. Please re-enter selection. ", number
2550 life = life - 1
2560 IF life = 0 GOTO 1570
2570 WEND
2580 WHILE number > 13
2590 PRINT "Oh my gosh!! Reptile just stabbed "; character$; "!! I don't know if"
2600 PRINT " "; character$; " is going to make it!"
2610 INPUT "The number is lower. Please select again. ", number
2620 life = life - 1
2630 IF life = 0 THEN GOTO 1570
2640 WEND
2650 IF number = 13 THEN PRINT "HOLY COW!! THE UNDEFEATED REPTILE IS NOW DEAD!!!"
2700 PRINT ""
2710 PRINT ""
2715 PLAY "o5l9aacdbbadcaab"
2720 PRINT "And so, after killing the ninja Reptile, "; character$; " was proclaimed"
2730 PRINT "the new World Warrior, and everywhere his name was known as the name of"
2740 PRINT "the greatest warrior of all time."
2750 PRINT ""
2755 PLAY "o3l4aabcdaabdefdco1l1aaa"
2760 PRINT ""
2770 PRINT "                       CREDITS  "
2780 PRINT ""
2790 PRINT "Designer...................................... Eric Walker"
2800 PRINT "Programmer1................................... Eric Walker"
2810 PRINT "Art........................................... Eric Walker"
2820 PRINT "Programmer2................................... Eric Walker"
2830 PRINT "Characters......................................... Capcom"
2840 PRINT "Reptile............................................ Midway"
2850 PRINT "Music......................................... Eric Walker"
2860 PLAY "o2l5aaffeebdcal9ccddbbal4abca"
2870 PRINT ""
2880 PRINT ""
2890 PRINT "  -----  |   |  ----        ----  --  |  ---_ "
2900 PRINT "    |    |---| |---        |---  |  | | |    |"
2910 PRINT "    |    |   | |____       |____ |  |_| |___-|"
2920 PRINT ""
2930 PLAY "o1l1aal4gg"
2940 PRINT ""
2950 PRINT "Uh, Oh. Someone else has just entered the tournament!!"
2960 PLAY "o1l2aabb"
2970 PRINT "  Just Kidding."
2980 PLAY "o4l9bbccddeeddggp10"
2990 PRINT ""
3000 PRINT ""
3010 PRINT "                             THE END"
3020 IF character$ = "Ken" THEN PLAY "o5l2abcdeffg"
3030 IF character$ = "Zangief" THEN PLAY "o1l4abba"
3040 IF character$ = "Ryu" THEN PLAY "o3l4acba"
3050 IF character$ = "Balrog" THEN PLAY "o2l4acbac"
3060 IF character$ = "Chun Li" THEN PLAY "o5l4bcbccba"
3070 IF character$ = "Dhalsim" THEN PLAY "o2l6edcbaabcde"
3080 IF character$ = "Blanka" THEN PLAY "o1l4bcddcbcdd"
3090 IF character$ = "Vega" THEN PLAY "o5l8ddecddaabbccddaaggddaabbccbbcdefggaaa"
3100 IF character$ = "E. Honda" THEN PLAY "o2l2baabc"
3110 IF character$ = "Guile" THEN PLAY "o3l4aabbl6cdel4aabbl6cdeaa"
3120 IF character$ = "Sagat" THEN PLAY "o3l4acegl8gfedcbaa"
3130 IF character$ = "M. Bison" THEN PLAY "o1l1dcbaaa"
3140 END
3150 PRINT "Player#1 has a stronger offense,"
3160 PRINT "while Player#2 has a stronger defense."
3170 PRINT "They take turns punching and kicking each other."
3180 PRINT "Type capitol P to punch, and capitol K to kick."
3190 PRINT "Keep on in this manner until one player is dead."
3200 PRINT ""
3210 INPUT "Who, out of all the Street Fighters, is Player#1 "; nme1$
3220 INPUT "Who, out of all the Street Fighters, is Player#2 "; nme2$
3230 PRINT ""
3240 PRINT "                 "; nme1$; "   VS.   "; nme2$; "       "
3250 PLAY "o4l6abcdefggl16fcdbaal1al4o3ddcbad"
3260 PRINT ""
3270 life1 = 40
3280 life2 = 50
3290 PRINT "It is "; nme1$; "'s turn."
3300 INPUT "Do you want to punch or kick your opponent "; atck$
3310 IF atck$ = "P" THEN life2 = life2 - INT(RND * (9 - 3) + 3)
3320 IF atck$ = "K" THEN life2 = life2 - INT(RND * (11 - 0) + 0)
3330 IF life2 < 1 THEN GOTO 3440
3340 PRINT "And "; nme2$; " has "; life2; " life remaining."
3350 PRINT ""
3360 PRINT "It is "; nme2$; "'s turn."
3370 INPUT "Do you want to punch or kick your opponent "; atck$
3380 IF atck$ = "P" THEN life1 = life1 - INT(RND * (7 - 2) + 2)
3390 IF atck$ = "K" THEN life1 = life1 - INT(RND * (9 - 0) + 0)
3400 IF life1 < 1 THEN GOTO 3590
3410 PRINT "And "; nme1$; " has "; life1; " life remaining."
3420 PRINT ""
3430 IF life1 <> 0 OR life2 <> 0 THEN GOTO 3290
3440 PRINT ""
3450 IF nme1$ = "Ken" THEN PRINT "And with Ken's skill by Sheng Long, "; nme2$; " is defeated!"
3460 IF nme1$ = "Ryu" THEN PRINT "And with a Dragon Punch, Ryu defeats his opponent!"
3470 IF nme1$ = "E. Honda" THEN PRINT "Whoa! E. Honda's Hundred Hand Slap made short work of "; nme2$; "!"
3480 IF nme1$ = "Blanka" THEN PRINT "And the beast, Blanka, wins!!"
3490 IF nme1$ = "Guile" THEN PRINT "With the mighty Flash Kick, Guile wins!!"
3500 IF nme1$ = "Balrog" THEN PRINT "Balrog's boxing gloves are now smeared with "; nme2$; "'s blood!"
3510 IF nme1$ = "Vega" THEN PRINT "Vega's sharp claws have been put to use!"
3520 IF nme1$ = "Chun Li" THEN PRINT "Looks like Chun Li is the strongest woman in the world, after all!"
3530 IF nme1$ = "Zangief" THEN PRINT "With a Spinning Pile Driver, Zangief grinds "; nme2$; " into the pavement!!"
3540 IF nme1$ = "Dhalsim" THEN PRINT "Dhalsim really burned up "; nme2$; " with Yoga Fire!"
3550 IF nme1$ = "Sagat" THEN PRINT "The kickboxer Sagat really kicked "; nme2$; "'s butt!"
3560 IF nme1$ = "M. Bison" THEN PRINT "With the Flying Double Kick, M. Bison made a mess out of "; nme2$; "!"
3570 PLAY "o3l6aabbcdacgl16al8bl16ddacbddcbcddo2l5ddegfcb"
3580 END
3590 PRINT ""
3595 IF nme2$ = "Ken" THEN PRINT "And with Ken's skill by Sheng Long, "; nme1$; " is defeated!"
3600 IF nme2$ = "Ryu" THEN PRINT "And with a Dragon Punch, Ryu defeats his opponent!"
3610 IF nme2$ = "E. Honda" THEN PRINT "Whoa! E. Honda's Hundred Hand Slap made short work of "; nme1$; "!"
3620 IF nme2$ = "Blanka" THEN PRINT "And the beast, Blanka, wins!!"
3630 IF nme2$ = "Guile" THEN PRINT "With the mighty Flash Kick, Guile wins!"
3640 IF nme2$ = "Balrog" THEN PRINT "Balrog's boxing gloves are now smeared with "; nme1$; "'s blood!"
3650 IF nme2$ = "Vega" THEN PRINT "Vega's sharp claws have been put to use!"
3660 IF nme2$ = "Chun Li" THEN PRINT "Looks like Chun Li is the strongest woman in the world, after all!"
3670 IF nme2$ = "Zangief" THEN PRINT "With a Spinning Pile Driver, Zangief grinds "; nme1$; " into the pavement!!"
3680 IF nme2$ = "Dhalsim" THEN PRINT "Dhalsim really burned up "; nme1$; " with Yoga Fire!"
3690 IF nme2$ = "Sagat" THEN PRINT "The kickboxer Sagat really kicked "; nme1$; "'s butt!"
3700 IF nme2$ = "M. Bison" THEN PRINT "With the Flying Double Kick, M. Bison really made a mess out of "; nme1$; "!"
3710 PLAY "o3l6aabbcdacgl16al8bl16ddacbddcbcddo2l5ddegfcb"
3720 END









