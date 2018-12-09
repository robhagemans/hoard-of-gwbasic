1 'Name: Gargoyle Castle - PC version
2 'Author: Richard Kelly (newson@dosius.zzn.com)
3 'Language: QB/PDS
4 'ABC Category: Games
5 'Version: 1.00
6 'Release date: 10/20/2002
7 '
8 'Want my CoCo III port of this game?  E-Mail me!  :-)  BAS, ARC, or DSK
9 'format only;  I don't do DMK right now.  :-(
10 '
11 'Although the code, in its current form, will only run in QB-compatible
12 'interpreters and compilers, one should be able to get it running in
13 'GW-BASIC and BASICA without *too* much trouble ...  :-)
14 '
15 'Special thanks to "Captain CoCo", who brought this PD game to my attention
16 'by porting it to CoCos (T&D's update "Land of Unreason" later followed).
17 'The original code seems to have been written for a TRS-80 Model I.  I
18 'came to this conclusion because Capt. Coco's version of "Gargoyle" has
19 'POS commands and STRING$ commands written to work with 64-column screens.
20 CLEAR 999: RANDOMIZE TIMER
21 CLS : WIDTH 80: COLOR 15, 1: CLS : PRINT : PRINT
23 PRINT TAB(33); CHR$(34); "Gargoyle Castle"; CHR$(34): PRINT
24 PRINT TAB(27); "Original author: Kit Domenico": PRINT
25 PRINT TAB(17); "PC version and game introduction by Richard Kelly": PRINT : COLOR 8, 15: PRINT STRING$(80, 220): COLOR 15, 4
26 PRINT "       In this place, you  can appear to be going in  circles when you're not.  "
27 PRINT "  You'll find rooms  in places where  they shouldn't be.   The pathways you've  "
28 PRINT "  walked  through  can  disappear  without  explanation.  And  you  will  keep  "
29 PRINT "  finding objects you might be able to read,  but can never examine.   This is  "
30 PRINT "  the Curse Of The Gargoyle,  and finding all the treasures in the game is the  "
31 PRINT "  only way to break the spell." + STRING$(50, 32): COLOR 8, 15: PRINT STRING$(80, 220): COLOR 15, 1: PRINT
32 PRINT "  Use two-word commands such as TIE GARGOYLE, SCREW BULB, or OPEN URN.    Move"
33 PRINT TAB(13); "using the one-word commands N, S, E, and W.   Good luck.": PRINT
100 PRINT TAB(13); "Version 1.00.  This game is Public Domain.  (10/20/2002)": PRINT
105 READ IT: REM THIS IS THE NUMBER OF ITEMS ON THE NOUN LIST
108 DIM NA$(IT), NM$(IT), LO(IT)
110 FOR I = 1 TO IT: READ NA$(I), NM$(I), LO(I): NEXT I
120 PL = 6: PO = 1
160 READ LO
170 DIM CO(LO, 6), LI(LO), D$(LO)
180 FOR I = 0 TO LO
190 READ D$(I)
200 FOR J = 1 TO 6
210 READ CO(I, J)
220 NEXT J
225 READ LI(I)
230 NEXT I
460 LC = 5
480 SS$ = NM$(4)
490 PRINT TAB(32); : LINE INPUT "Press [RETURN]. "; A$: COLOR 7, 0
500 CLS
505 IF LI(LC) = 0 AND L = 0 THEN PRINT "It's dark in here!": GOTO 569
510 CLS : PRINT "I'm in " + D$(LC)
520 PRINT : PRINT "I can see ";
522 IF LO(32) = 99 AND LC = 28 THEN PRINT "that my armor pulls me straight to the bottom, and I'm drowned.": PRINT : LC = 0: GOTO 5300
525 VI = 0: WD = 0
530 FOR I = 1 TO IT
540 IF LO(I) <> LC THEN 545
542 GOSUB 29990: IF 80 - POS(X) < LEN(NA$(I)) + LEN(NM$(I)) THEN PRINT
543 PRINT NM$(I); NA$(I);
544 VI = VI + 1
545 NEXT I: IF VI = 0 THEN PRINT "that there are no items in sight";
550 PRINT "."
552 PRINT : PRINT "The exits are "; : WD = 0
554 IF CO(LC, 1) <> 0 THEN GOSUB 29990: PRINT "North";
555 IF CO(LC, 2) <> 0 THEN GOSUB 29990: PRINT "East";
556 IF CO(LC, 3) <> 0 THEN GOSUB 29990: PRINT "South";
557 IF CO(LC, 4) <> 0 THEN GOSUB 29990: PRINT "West";
558 IF CO(LC, 5) <> 0 THEN GOSUB 29990: PRINT "Up";
559 IF CO(LC, 6) <> 0 THEN GOSUB 29990: PRINT "Down";
560 PRINT "."
569 PRINT STRING$(80, "+");
570 A$ = ""
575 IF (LO(31) = LC OR LO(31) = 99) AND LO(32) <> 99 AND NM$(31) = "a vicious green and purple " THEN 2012
580 PRINT : INPUT "What should I do"; A$: B$ = LEFT$(A$, 1): C$ = MID$(A$, 2, 254): A$ = UCASE$(B$) + LCASE$(C$)
590 IF LEN(A$) = 1 THEN 1000
600 V$ = LEFT$(A$, 3)
610 FOR I = 1 TO LEN(A$)
620 IF RIGHT$(LEFT$(A$, I), 1) = " " THEN A$ = LEFT$(RIGHT$(A$, LEN(A$) - I), 3): GOTO 650
630 NEXT I
650 REM VERB LIST
660 IF V$ = "Go " OR V$ = "Wal" OR V$ = "Run" THEN 1000
670 IF V$ = "Get" OR V$ = "Tak" OR V$ = "Pic" THEN 2000
680 IF V$ = "Dro" OR V$ = "Put" THEN 2500
690 IF V$ = "Loo" THEN 500
700 IF V$ = "Inv" THEN 3000
710 IF V$ = "Rea" THEN 4000
720 IF V$ = "Unr" THEN 4300
725 IF V$ = "Bur" OR V$ = "Lig" THEN 4400
740 IF V$ = "Cli" THEN 4500
750 IF V$ = "Rub" THEN 4600
760 IF V$ = "Hel" THEN 4700
770 IF V$ = "Dig" THEN 4800
780 IF V$ = "Ope" THEN 5000
790 IF V$ = "Pol" THEN 5100
800 IF V$ = "Tie" THEN 5200
810 IF V$ = "Sco" THEN 5300
820 IF V$ = "Qui" THEN 5600
830 IF V$ = "Rem" THEN 5800
840 IF V$ = "Cov" THEN 5900
850 IF V$ = "Scr" THEN 6000
860 IF V$ = "Eat" THEN 6100
870 IF V$ = "Mel" THEN 6200
880 IF V$ = "Pla" THEN 6300
890 PRINT "Sorry, I don't know how to do that.": GOTO 570
1000 REM
1003 IF TR = 1 THEN LO(21) = 14: TR = 0
1004 IF L = 0 AND LI(LC) = 0 THEN PRINT "Moving in the dark can be dangerous!": GOSUB 29999
1005 NM$(5) = "a "
1006 NM$(4) = SS$
1007 IF LO(10) <> 99 OR NM$(10) <> "a lit " THEN L = 0
1009 A$ = LEFT$(A$, 3)
1010 IF A$ = "Nor" THEN A$ = "N"
1020 IF A$ = "Wes" THEN A$ = "W"
1030 IF A$ = "Sou" THEN A$ = "S"
1040 IF A$ = "Eas" THEN A$ = "E"
1041 IF A$ = "Dow" THEN A$ = "D"
1042 IF A$ = "Up" THEN A$ = "U"
1050 REM
1060 IF CO(LC, 1) <> 0 AND A$ = "N" THEN LC = CO(LC, 1): GOTO 1200
1070 IF CO(LC, 2) <> 0 AND A$ = "E" THEN LC = CO(LC, 2): GOTO 1200
1080 IF CO(LC, 3) <> 0 AND A$ = "S" THEN LC = CO(LC, 3): GOTO 1200
1090 IF CO(LC, 4) <> 0 AND A$ = "W" THEN LC = CO(LC, 4): GOTO 1200
1092 IF A$ = "U" AND CO(1, 5) <> 0 AND LC = 1 AND LO(6) <> 99 AND LO(6) <> 1 THEN PRINT "It's too high to reach.": GOTO 570
1094 IF A$ = "U" AND LO(6) = 99 THEN PRINT "I can't climb a ladder I'm carrying.": GOTO 570
1100 IF CO(LC, 5) <> 0 AND A$ = "U" THEN LC = CO(LC, 5): GOTO 1200
1110 IF CO(LC, 6) <> 0 AND A$ = "D" THEN LC = CO(LC, 6): GOTO 1200
1180 PRINT "Sorry, I can't go that direction."
1190 GOTO 570
1200 IF LO(6) = LC THEN CO(6, 6) = LC
1220 GOTO 500
2000 REM
2004 IF A$ = "soc" THEN 2040
2005 IF PO >= PL THEN PRINT "I have too much already!": GOTO 2040
2010 IF A$ <> "gar" THEN 2018
2011 IF LO(31) <> LC THEN PRINT "It isn't here": GOTO 570
2012 IF NM$(31) = "a vicious green and purple " AND LO(32) <> 99 THEN PRINT "A loose and vicious gargoyle attacks me.  I am dead.": LC = 0
2013 IF LC = 0 THEN 5300
2018 FOR I = 1 TO IT
2020 IF A$ <> LEFT$(NA$(I), 3) OR LO(I) <> LC THEN 2030
2022 IF A$ = "coa" AND MID$(NM$(30), 6, 1) = "g" AND LO(19) <> 99 THEN PRINT "You don't have anything to carry them in.": GOTO 570
2023 IF A$ = "coa" AND MID$(NM$(30), 6, 1) = "g" AND LO(19) = 99 AND MID$(NM$(19), 3, 1) = "F" THEN PRINT "Not while the urn is closed": GOTO 570
2024 IF A$ = "bir" AND (LO(9) <> 99 AND LO(9) <> LC) THEN PRINT "It flys away from me.": LO(22) = INT(RND * 6) + 1: GOSUB 29999: GOSUB 29999: GOTO 500
2025 IF A$ = "bir" THEN LO(22) = 0: NM$(9) = "* a crystal bird locked in a ": GOTO 500
2028 LO(I) = 99: PO = PO + 1: GOTO 500
2030 NEXT I
2040 PRINT "I can't pick that up."
2100 GOTO 570
2500 REM
2510 FOR I = 1 TO IT
2516 IF A$ = "urn" AND LO(30) = 99 THEN LO(30) = LC: PO = PO - 1
2518 IF A$ = "lad" AND LO(6) = 99 THEN CO(7, 6) = LC
2520 IF A$ = LEFT$(NA$(I), 3) AND LO(I) = 99 THEN LO(I) = LC: PO = PO - 1: GOTO 500
2530 NEXT I
2535 PRINT "You don't have that."
2540 GOTO 570
3000 REM
3001 PO = 0
3005 C = 0
3010 PRINT "I am carrying ";
3020 FOR I = 1 TO IT
3030 IF C = 0 AND LO(I) = 99 THEN PRINT NM$(I); NA$(I); ". ": C = C + 1: PO = PO + 1: GOTO 3045
3040 IF C > 0 AND LO(I) = 99 THEN PRINT UCASE$(LEFT$(NM$(I), 1)); MID$(NM$(I), 2, 254); NA$(I); ". ": C = C + 1: PO = PO + 1
3045 NEXT I: IF C = 0 THEN PRINT "nothing."
3060 GOTO 570
4000 REM
4005 IF L = 0 AND LI(LC) = 0 THEN PRINT "In the dark?": GOTO 4190
4010 IF A$ = "boo" AND (LO(2) = LC OR LO(2) = 99) THEN PRINT "I don't read german.": GOTO 570
4015 IF A$ = "scr" AND LEFT$(NM$(4), 4) = "a ti" AND (LO(4) = 99 OR LO(4) = LC) THEN PRINT "On the outside, it says 'rolled by scroll roller's union 207.'": GOTO 570
4020 IF A$ = "scr" AND NM$(4) = "an unrolled " AND (LO(4) = LC OR LO(4) = 99) THEN PRINT "It says, burn it up, Chuck.": GOTO 570
4030 IF A$ = "clo" AND NM$(7) = "a faintly lettered " AND (LO(7) = 99 OR LO(7) = LC) THEN PRINT "It says, in the closet, dummy.": GOTO 570
4040 IF A$ = "sig" AND LC = 26 THEN PRINT "It says, 'Stand by for more adventure.  Call your local distributor today.'": GOTO 570
4050 IF A$ = "pla" AND LC = 13 AND (L = 1 OR LI(13) = 1) THEN PRINT "Glowing letters say 'Drop *treasures here and say SCORE.'": GOTO 570
4190 PRINT "Sorry Charlie, can't do it."
4195 GOTO 570
4300 REM
4310 IF A$ <> "scr" THEN PRINT "I don't know how.": GOTO 570
4320 IF A$ = "scr" THEN LO(5) = LC: NM$(4) = "an unrolled ": SS$ = NM$(4): PRINT "A lighter fell out.": GOTO 570
4400 REM
4410 IF A$ <> "lig" AND A$ <> "fla" AND A$ <> "scr" THEN PRINT "Sorry, it won't light": GOTO 570
4420 IF A$ = "lig" AND (LO(5) = LC OR LO(5) = 99) THEN NM$(5) = "a lit ": L = 1: PRINT "The lighter flares.": GOSUB 29999: GOTO 500
4430 IF A$ = "scr" AND LO(4) <> LC AND LO(4) <> 99 THEN PRINT "It isn't here.": GOTO 570
4440 IF A$ = "scr" AND NM$(5) = "a lit " THEN NM$(4) = "a burning ": PRINT "The scroll burns brightly.": L = 1: GOTO 4470
4450 IF A$ = "fla" AND LO(10) = 99 THEN L = 1: NM$(10) = "a lit ": GOTO 500
4460 PRINT "What do you mean?": GOTO 570
4470 IF LC = 1 THEN PRINT "In the light, I see an opening in the ceiling.": CO(1, 5) = 7
4480 IF LC = 1 THEN CO(1, 5) = 7: CO(6, 6) = 7: CO(7, 5) = 6
4490 GOTO 570
4500 REM
4510 IF A$ <> "lad" THEN PRINT "I can't climb that.": GOTO 570
4525 IF LO(6) <> LC AND LO(6) <> 99 THEN PRINT "What ladder?": GOTO 570
4530 IF CO(LC, 5) = 0 THEN PRINT "I climbed it, but there was nothing there so I came back down.": GOTO 570
4540 A$ = "U": GOTO 1050
4600 REM
4605 FOR I = 1 TO IT
4606 IF A$ = LEFT$(NA$(I), 3) AND (LO(I) <> LC AND LO(I) <> 99) THEN PRINT "It's not here.": GOTO 570
4607 NEXT I
4610 IF A$ <> "rin" THEN PRINT "Nothing, sport.": GOTO 570
4620 IF LO(3) <> LC AND LO(3) <> 99 THEN PRINT "What ring?": GOTO 570
4625 IF LO(7) <> 99 AND LO(7) <> LC THEN PRINT "I have nothing to rub it with.": GOTO 570
4630 PRINT "The ring glows gold.": NM$(3) = "* a shimmering "
4640 NM$(7) = "a faintly lettered "
4650 GOTO 570
4700 REM
4710 PRINT "Help?  You're supposed to be helping me!": GOTO 570
4800 REM
4810 IF LO(8) <> 99 AND LO(20) <> 99 THEN PRINT "With what?": GOTO 570
4820 IF LC <> 5 AND LC <> 12 AND LC <> 14 AND LC <> 15 AND LC <> 24 AND LC <> 26 THEN PRINT "I can't dig here.": GOTO 570
4830 PRINT "Okay.  Here's a hole."
4840 IF LC = 5 THEN CO(27, 5) = 5: CO(5, 6) = 27: IF LO(22) = 90 THEN LO(22) = 27
4850 IF LC = 12 THEN CO(27, 5) = 12: CO(12, 6) = 27
4860 IF LC = 14 THEN CO(27, 5) = 14: CO(14, 6) = 27
4870 IF LC = 15 THEN CO(27, 5) = 15: CO(15, 6) = 27: IF LO(25) = 90 THEN LO(25) = 27
4880 IF LC = 24 THEN CO(27, 5) = 24: CO(24, 6) = 27: IF LO(23) = 90 THEN LO(23) = 27
4885 IF LC = 24 AND LO(15) = 90 THEN LO(15) = 24
4890 IF LC = 26 THEN CO(27, 5) = 26: CO(26, 6) = 27: IF LO(31) = 90 THEN LO(31) = 27
4900 GOTO 570
5000 REM
5005 IF A$ = "scr" THEN 4300
5010 IF A$ <> "cag" AND A$ <> "urn" THEN PRINT "It doesn't seem to open.": GOTO 570
5015 IF A$ = "cag" AND LO(9) <> 99 AND LO(9) <> LC THEN PRINT "What cage?": GOTO 570
5020 IF A$ = "cag" AND (LO(9) = 99 OR LO(9) = LC) THEN PRINT "The door opened.": NM$(9) = "an open "
5030 IF A$ = "urn" AND (LO(19) = 99 OR LO(19) = LC) THEN PRINT "It's open.": NM$(19) = "an open funerary ": IF LO(26) = 90 THEN LO(26) = LC
5035 PRINT "Something fell out."
5040 GOTO 570
5100 REM
5110 IF A$ <> "cro" AND A$ <> "rin" THEN PRINT "I can't polish such a thing": GOTO 570
5113 IF A$ = "rin" AND LO(3) <> LC AND LO(3) <> 99 THEN PRINT "What ring?": GOTO 570
5115 IF LO(16) <> LC AND LO(16) <> 99 THEN PRINT "I don't have any polish.": GOTO 570
5118 IF A$ = "cro" AND LO(23) <> LC AND LO(23) <> 99 THEN PRINT "What crown?": GOTO 570
5120 IF A$ = "rin" THEN PRINT "I don't need polish for this.  It's just a little dull.": GOTO 570
5130 IF NM$(16) = "an empty bottle of " THEN PRINT "Sorry, I'm out of polish.": GOTO 570
5140 IF A$ = "cro" AND NM$(16) = "a bottle full of " THEN NM$(23) = "* a glistening silver ": NM$(16) = "an empty bottle of "
5145 PRINT "It shines of silver.": GOTO 570
5200 REM
5210 IF A$ <> "gar" THEN PRINT "I am unable to tie that.": GOTO 570
5220 IF (LO(31) <> 99 AND LO(31) <> LC) OR (LO(17) <> 99 AND LO(17) <> LC) THEN PRINT "I'm sorry.  I cannot.": GOTO 570
5230 NM$(17) = "a knotted "
5235 LO(17) = 0
5240 NM$(31) = "* a rope bound "
5250 PRINT "It's friendly when it's tied up."
5260 GOTO 570
5300 REM
5305 SC = 0
5307 SM = 0
5310 FOR I = 1 TO IT
5320 IF LEFT$(NM$(I), 1) = "*" AND LO(I) = 13 THEN SC = SC + 1: GOTO 5330
5325 IF I <> 16 AND LO(I) <> 27 AND LO(I) <> 99 AND LO(I) <> 1 AND LO(I) <> 28 AND LO(I) <> 0 AND LO(I) <> 90 AND LO(I) <> 24 THEN SM = SM + 1
5330 NEXT I
5340 PRINT "You scored"; SC * 10; "points out of 100"; : IF SC = 10 THEN SM = 0
5350 IF SM = 0 THEN PRINT ".": GOTO 5370
5360 PRINT ", but I am penalizing you"; SM; "points for": PRINT "sloppiness."
5370 PRINT "And your Net Score is"; : IF SC * 10 - SM < 0 THEN PRINT " ";
5375 PRINT STR$(SC * 10 - SM); "."
5380 IF SM > 6 THEN PRINT "Clean up after yourself."
5390 IF SC * 10 - SM = 100 THEN PRINT "Congratulations!  A perfect score.": LC = 0
5400 IF SC * 10 - SM > 90 AND SC * 10 - SM < 100 THEN PRINT "Very, very good."
5490 IF LC = 0 THEN PRINT "The game is over": END: RUN
5500 GOTO 570
5600 REM
5610 PRINT "Do you want to quit"; : INPUT X$: X$ = UCASE$(X$)
5620 IF LEFT$(X$, 1) <> "Y" THEN 570
5630 LC = 0
5635 CLS
5640 GOTO 5300
5800 REM
5810 IF A$ <> "arm" THEN PRINT "I cannot remove that.": GOTO 570
5815 IF LO(32) <> 99 THEN PRINT "I am not wearing it.": GOTO 570
5820 LO(32) = LC
5830 PRINT "Ah, that feels better."
5840 GOTO 570
5900 REM
5910 IF A$ <> "boo" THEN PRINT "I can't cover that.": GOTO 570
5920 IF (LO(2) <> 99 AND LO(2) <> LC) OR (LO(11) <> 99 AND LO(11) <> LC) THEN PRINT "I can't yet.": GOTO 570
5930 LO(11) = 0: REM GET RID OF COVER
5940 NM$(2) = "* a complete gutenburg "
5945 NA$(2) = "bible"
5950 PRINT "That looks nice."
5960 GOTO 570
6000 REM
6010 IF A$ <> "bul" THEN PRINT "The only thing I can screw is a bulb.": GOTO 570
6020 IF (LO(13) <> 99 AND LO(13) <> 13) AND (LO(12) = 99 OR LO(12) = 13) THEN PRINT "That's the wrong kind of bulb!": GOTO 570
6030 REM SUCCESS
6040 LO(13) = 0
6045 LI(13) = 1
6050 NA$(14) = "lamp": NM$(14) = "* a tiffany "
6070 GOTO 500
6100 REM
6110 IF A$ <> "com" THEN PRINT "I can't eat that!": GOTO 570
6120 IF LO(15) = 99 OR LO(15) = LC THEN PRINT "Gag ...... Yurp!  Bad!": GOTO 570
6130 PRINT "Thank God, it isn't here!"
6140 GOTO 570
6200 REM
6210 IF A$ <> "ice" THEN PRINT "That won't melt": GOTO 570
6215 IF NA$(29) <> "ice" THEN PRINT "Only once!": GOTO 570
6220 IF (LO(29) <> LC AND LO(29) <> 99) OR (LO(30) <> LC AND LO(30) <> 99) THEN PRINT "I can't yet.": GOTO 570
6230 NM$(29) = "some thawed "
6240 NA$(29) = "water"
6250 NM$(30) = "some cold "
6260 PRINT "That did it.  The water flows."
6270 GOTO 570
6300 REM
6310 IF A$ <> "bul" AND A$ <> "tul" THEN PRINT "I can't plant that.": GOTO 570
6320 IF (LO(13) = 99 OR LO(13) = LC) AND NOT (LO(12) = 99 OR LO(12) = LC) THEN PRINT "Plant that bulb?": GOTO 570
6330 IF (LO(12) = 99 OR LO(12) = LC) AND (LO(15) = 99 OR LO(15) = LC) AND NA$(29) = "water" THEN 6350
6340 PRINT "I don't have everything I need.": GOTO 570
6350 IF LC <> 14 THEN PRINT "It won't grow here.": GOTO 570
6360 IF LO(20) <> 99 AND LO(20) <> LC AND LO(8) <> LC AND LO(8) <> 99 THEN PRINT "Not with these bare hands!!!": GOTO 570
6370 TR = 1: REM THIS IS THE TULIP READY COUNTER
6380 PRINT "Okay.  I buried that mess."
6390 LO(12) = 0: LO(15) = 0: LO(29) = 0
6400 GOTO 570
28002 REM              NA$(I),NM$(I),LO(I)
28004 REM ITEM COUNT
28005 DATA 32
28010 DATA"ruby","* a huge ",4
28020 DATA"book","an old ",3
28030 DATA"ring","a dull ",2
28040 DATA"scroll","a tightly rolled ",3
28050 DATA"lighter","a ",0
28060 DATA"ladder","a long ",4
28070 DATA"cloth","a fuzzy ",3
28080 DATA"shovel","an antique ",16
28090 DATA"cage","a wicker ",18
28100 DATA"flashlight","an unlit ",15
28110 DATA"bookcover","an empty ",11
28120 DATA"bulb","a tulip ",25
28130 DATA"bulb","a light ",27
28140 DATA"socket","an empty ",13
28150 DATA"compost","some well rotted ",90
28160 DATA"polish","a bottle full of ",13
28170 DATA"rope","a coiled ",21
28180 DATA"trash","a mound of ",21
28190 DATA"urn","a funerary ",15
28200 DATA"trowel","a garden ",1
28210 DATA"tulip","* a rainbow colored ",90
28220 DATA"bird","* a living crystal ",5
28230 DATA"crown","a discarded, blackened ",90
28240 DATA"D","D",90
28250 DATA"coins","* some triangular gold ",90
28260 DATA"pipe","* a platinum smoking ",90
28270 DATA"D","D",90
28280 DATA"D","D",90
28290 DATA"ice","some greenish ",26
28300 DATA"coals","some glowing ",18
28310 DATA"gargoyle","a vicious green and purple ",90
28320 DATA"armour","some VERY heavy ",99
29004 REM LOCATION COUNT
29005 DATA 28
29010 DATA "nowhere.",0,0,0,0,0,0,0
29020 DATA"a dim closet.",0,2,3,0,0,0,0
29030 DATA"a gathering room with wide benches down both sides.",5,0,4,1,0,0,1
29040 DATA"an old stone arms room.",1,4,0,0,0,0,1
29050 DATA"a dank and musty dungeon.",2,0,0,3,0,0,0
29060 DATA"a lush green meadow, with a tower to the south.  Not too far to the west it looks like there's a castle.  There's a deep moat west.",0,0,2,28,0,0,1
29070 DATA"a high tower looking out on the meadow.  Through a western portal, a     bridge leads to another castle.",0,0,0,8,0,7,1
29080 DATA"the top of the ladder.",0,0,0,0,0,0,0
29090 DATA"a bridge to a tower off to the west.",0,6,0,9,0,0,1
29100 DATA"a north-south corridor in the tower.",10,8,19,0,0,0,1
29110 DATA"a square room with a vaulted ceiling.",0,0,9,11,0,24,1
29120 DATA"a library full of ancient and wonderful books.",0,10,12,0,0,0,1
29130 DATA"a grassy roof-top with potted palms and a clear blue sky.",11,13,14,25,0,0,1
29140 DATA"a room with a tall golden throne, and a small plaster plaque set in the  floor.",0,0,0,12,0,0,0
29150 DATA"a beautiful flower garden, with beds of plants down both sides of a long walk.",12,0,15,0,0,0,1
29160 DATA"a tomb with a row of bronze markers for fallen scholars.",18,16,0,14,0,0,0
29170 DATA"a museum with broken and destroyed displays.",17,0,0,15,0,0,0
29180 DATA"an east-west corridor with porcelain tile walls.",0,22,16,18,0,0,0
29190 DATA"a torture chamber with a brazier in the corner.",0,17,15,0,0,0,0
29200 DATA"a square room with a vaulted ceiling.",9,20,0,0,0,0,1
29210 DATA"a twist in the hallway, with a terrazzo eagle in the floor.",0,0,22,19,0,0,1
29220 DATA"a bathroom with precious metal fixtures.",0,0,23,22,0,0,0
29230 DATA"a hallway with warriors in bas-relief in the wall stones.",20,21,23,17,0,0,1
29240 DATA"a bedroom fit for a king.  It says 'king' right on the curtain.",22,21,0,0,0,0,0
29250 DATA"a pit full of smelly garbage and foul refuse.",0,0,0,0,10,0,0
29260 DATA"a passage with a blinding glare to the west and a dark hole to the east.",0,12,0,26,0,0,1
29270 DATA"a wind swept icefield.  Storm clouds blot a faint red sun.  I can see a  caravan of ice beasts.  There's a sign half-buried in the ice.  Whoops, this is the wrong adventure.",0,25,0,0,0,0,1
29280 DATA"the bottom of a hole.",0,0,0,0,0,0,0
29290 DATA"the water of the moat.",0,5,0,0,0,0,1
29990 WD = WD + 1: IF WD > 1 THEN PRINT ", ";
29991 RETURN
29999 FOR T = 0 TO 19: TR = TIMER: WHILE TIMER = TR: WEND: NEXT: RETURN

