100 CLS
110 A$=STRING$(80,205)
120 PRINT A$
130 PRINT TAB(30)"PROVERBS  7004-A.BAS"
140 COLOR 23,0,0
150 PRINT :PRINT :PRINT TAB(38)"IPCO"
160 COLOR 7,0,0
170 PRINT :PRINT :PRINT TAB(29)"INTERNATIONAL PC OWNERS"
180 PRINT :PRINT :PRINT TAB(17)"p.o. box 10426, pittsburgh, pennsylvania 15234"
190 PRINT A$
200 PRINT :PRINT :PRINT :PRINT :PRINT
210 PRINT TAB(28)"PRESS ANY KEY TO CONTINUE"
220 A$=INKEY$:IF A$="" THEN 220
230 CLS
240 ' THIS IS A LITTLE PROGRAM THAT ALLOWS YOU TO NEATLY TYPE OUT PROVERBS
250 ' OR QUOTATIONS TO AN MX-80 OR IBM PRINTER IN ANY FORMAT YOU LIKE
260 '           (You can enter your own quotations as data statements
270 '              at the end of the program if you don`t like mine !)
280 INPUT "select a page length  ",PAGELENGTH
290 INPUT "select a line width  ",LINEWIDTH
300 PRINT
310 PRINT
320 READ A$
330 READ B$
340 IF B$ = "z" THEN GOTO 550
350 NB = LEN(B$)
360 FOR J = 1 TO NB
370   X$ = MID$(B$,J,1)
380   IF X$ = " " GOTO 420
390 NEXT J
400 A$ = A$ +  " "  + B$
410 GOTO 330
420 BP$ = LEFT$(B$,J-1)
430 B$ = RIGHT$(B$,NB-J)
440 IF LEN(A$) + LEN(BP$) > LINEWIDTH THEN GOTO 470
450 A$ = A$ + " " + BP$
460 GOTO 350
470 L$ = A$
480 A$ = BP$
490 Y = (80 - LINEWIDTH)/2
500 PRINT TAB(Y) L$
510 LPRINT TAB(Y) L$
520 COUNT = COUNT + 1
530 IF COUNT = PAGELENGTH THEN PRINT :PRINT: COUNT = 0
540 GOTO 460
550 PRINT TAB(Y) A$
560 LPRINT TAB(Y) A$
570 ' from Yiddish Proverbs (H.J. Ayalti, ed.) Schocken Books, NY, 1965
580 DATA "*"
590 DATA "`For example' is no proof * "
600 DATA "Half a truth is a whole lie * "
610 DATA "A wise man hears one word and understands two * "
620 DATA "A fool is his own informer * "
630 DATA "A lock is only meant for honest men * "
640 DATA "All children are clever when they are small, but most of them grow no wiser * "
650 DATA "All brides are beautiful, all the dead are holy * "
660 DATA "When a lion sleeps, let him sleep * "
670 DATA "A man who's too good for the world is no good to his wife * "
680 DATA "The girl who can't dance says the band can't play * "
690 DATA "He that is fated to drown will drown - in a spoonful of water * "
700 DATA "If things don't get better, depend on it, they will get worse * "
710 DATA "If you can't bite, don't show your teeth * "
720 DATA "He that cannot endure the bad, will not endure to see the good * "
730 DATA "Talk too much and you talk about yourself * "
740 DATA "If you dance at every wedding, you will weep at every death * "
750 DATA "Before you marry, make sure you know whom you are going to divorce * "
760 DATA "Better a good enemy than a bad friend * "
770 DATA "Hell shared with a sage is better than paradise with a fool * "
780 DATA "If the ass had horns and the ox knew his strength, the world would be done for * "
790 DATA "Better to lose with a wise man than win with a fool * "
800 DATA "A wise man hides his wisdom, a fool reveals his folly * "
810 DATA "A man is what he is, not what he used to be * "
820 DATA "He is a giant who has many dwarfs about him * "
830 DATA "Passion is a master * "
840 DATA "Love is sweet, but tastes best with bread * "
850 DATA "It is easier to spot faults in others than virtues in oneself * "
860 DATA "Don't sell the skin off the bear that's still in the woods * "
870 DATA "You can't pull two hides off one ox * "
880 DATA "One doesn't live off joy, nor die of sorrow * "
890 DATA "God gave limbs to the fool and let him run * "
900 DATA "Beware of your friends, not your enemies * "
910 DATA "Don't be afraid when you have no other choice * "
920 DATA "What you have, hold; what you know, keep to yourself; what you can, do* "
930 DATA "Each man has a quirk all his own * "
940 DATA "Dumplings in a dream are not dumplings but a dream * "
950 DATA "Love is like butter, it goes well with bread * "
960 DATA "You don't stumble because you are weak, but because you think yourself strong * "
970 DATA "It is easy to poke the fire with another's hands * "
980 DATA "If you have learning, you'll never lose your way * "
990 DATA "Many complain of their looks, but none of their brains * "
1000 DATA "Poverty is no disgrace, but no great honor either * "
1010 DATA "Convenient to learn the barbers trade on the other fellows beard * "
1020 DATA "If charity cost no money and benevolence caused no heartache, the world would be full of philanthropists * "
1030 DATA "Trying to please costs you dear * "
1040 DATA "You don't need a calendar to die * "
1050 DATA "Two things are a burden: a fool among wise men and a wise man among fools * "
1060 DATA "Let a fool throw a stone in a well and ten wise men can't get it out * "
1070 DATA "If grandma had whiskers, she'd be grandpa * "
1080 DATA "If praying did any good, they'd be hiring men to pray * "
1090 DATA "We know the time of our setting out, but not the time of our return * "
1100 DATA "Laugh and everybody sees you, cry and you cry alone * "
1110 DATA "What saddens a wise man gladdens a fool * "
1120 DATA "A man's worst enemy can't wish him what he thinks up for himself * "
1130 DATA "What good is the cow that gives plenty of milk and then kicks over the pail? * "
1140 DATA "They are madly in love - he with himself, she with herself * "
1150 DATA "z"
k and then kicks over the pail? * "
1140 DATA "They are madly in love - he with himself,