1 '                        T h e   S q u a r e  (tm)
2 '                        -------------------
3 '
4 '    Copyright (c) 1983 by:   David N. Smith,
5 '                             44 Ole Musket Lane,
6 '                             Danbury, Ct. 06810
7 '                             CompuServe: 73145,153
8 '
9 '    The Square is distributed following the "freeware" concept:
10 '
11 '   1) you may copy it freely for personal use but not for profit, nor as
12 '      a part of a package which is sold.  Give it away and encourage
13 '      others to do so also.
14 '
15 '   2) contributions of $20 can be made if you find the program
16 '      entertaining.
17 '
18 '   If you send a postage paid, self addressed, diskette mailer to the
19 '   address above, the author will send a diskette with the program and
20 '   documentation.
21 '
22 '   If you send a postage paid, self addressed, diskette mailer with your
23 '   contribution of $20, the author will send a COMPILED version of The
24 '   Square.  The compiled version is significantly faster.
25 '
26 '   See accompanying file SQUARE.SUM for more information.
27 '
30 CLEAR ,,2048
31 DEFINT A-Z
32 '
33 ' constants
34 SCORE=0   '  moves since scrambled
35 LEVEL=0   ' level of difficulty (0,1)
36 BLOBS$=CHR$(219)+CHR$(219)+CHR$(219)
37 CUROFF=0: CURON=1
39 SCRAMBLED=0 ' was sqaure scrambled by program?
40 RUNNING=0   ' have initialized
41 DIR=1       ' direction of move (+1 or -1)
43 REDISPLAY=1' redisplay sqaure? (1=yes, 0=no)
44 '
45 X$=TIME$+"":  X=VAL(MID$(X$,7,2)): X=X*100+VAL(MID$(X$,4,2))
48 RANDOMIZE X
49 '
50 DARROW$=CHR$(25)
51 DARROW2$=DARROW$+DARROW$
52 DARROW3$=DARROW2$+DARROW$
53 RARROW$=CHR$(26): RARROW3$=RARROW$+RARROW$+RARROW$
54 '
56 KEY OFF: CLS
59 DEF SEG=0
60 IF (PEEK(&H410) AND &H30) <> &H30 THEN MONO=0 ELSE MONO=1
62 IF MONO=0 THEN SCREEN 0,1,0,0: COLOR  7,0,0: WIDTH 40: CLS
65 IF MONO=1 THEN COLOR  7,0
100 '
101 ' *******************
102 '
108 DIM SQ(36) ' sq(6,6)
120 DIM CH$(4)
122 CH$(1)=CHR$(176): CH$(2)=CHR$(206): CH$(3)=CHR$(221): CH$(4)=CHR$(219)
130 MAXNMOVES=100:  NMOVES=0:  DIM MOVES(100)
136 DIM ICOLOR(4): ICOLOR(1)=1: ICOLOR(2)=2: ICOLOR(3)=4: ICOLOR(4)=15
138 '
139 'saved status
140 DIM SAVESQ(36), STATUS(10)
142 STATUSSAVED=0
197 '
290 ' **********************************
295 '                 initialization
300 RUNNING=0
305 GOSUB 6000   ' initialize the square
310 GOSUB 5000   ' display logo
320 GOSUB 6500   ' ask level of difficulty
325 REDISPLAY=1
330 GOSUB 1000   ' display square
360 GOSUB 4100   ' scramble the square
370 RUNNING=1
380 REDISPLAY=0
490 '
495 ' **********************************
499 '                   main loop
500 WHILE  1=1
510    GOSUB 1000  ' display square
520    GOSUB 8000  ' see if it's in solution
530    GOSUB 3000  ' read a command
540    GOSUB 2000  ' perform operation
590 WEND           ' loop
660 STOP
990 ' **********************************
998 '
999 ' display square
1000 IF REDISPLAY=0 THEN RETURN
1005 IF MONO=0 THEN GOTO 1500
1010 REDISPLAY=0
1015 CLS
1017 LOCATE 1,70: IF LEVEL=0 THEN PRINT"Hard" ELSE PRINT "Harder"
1018 COLOR 7:  S$=SPACE$(36)
1050 FOR J=1 TO 6
1065    IF LEVEL=1 THEN LOCATE J*3-2,15: PRINT STR$(J)+" "+RARROW$
1070    FOR I=1 TO 6
1080       X$=CH$(SQ(J+I*6-6)): MARK=MARK+1
1100       MID$(S$, (I*6)-5,6)=X$+X$+X$+X$+X$+" "
1120    NEXT I
1135    LOCATE J*3-1, 21: IF LEVEL=0 THEN PRINT S$+STR$(J)+RARROW$ ELSE PRINT S$
1145    LOCATE J*3-0, 21: PRINT S$
1180 NEXT J
1190 IF LEVEL=1 THEN LOCATE 19,16: PRINT "1 "+RARROW$
1200 LOCATE 20, 18
1210 IF LEVEL=0  THEN PRINT DARROW3$ +"  A     B     C     D     E     F "+DARROW3$
1215 IF LEVEL<>0 THEN PRINT DARROW2$+"A     B     C     D     E     F     A "+DARROW2$
1220 RETURN
1499 ' COLOR DISPLAY    ----------------------
1500 CLS
1502 LOCATE 1,32: IF LEVEL=0 THEN PRINT"Hard" ELSE PRINT "Harder"
1505 COLOR 15,0: REDISPLAY=0
1550 FOR Y=1 TO 6
1570    FOR X=1 TO 6
1575       IC=SQ(Y+X*6-6): COLOR ICOLOR(IC),0,0
1590       LOCATE Y*3-1,10+X*4-4: PRINT BLOBS$
1610       LOCATE Y*3,  10+X*4-4: PRINT BLOBS$
1630    NEXT X
1640    COLOR  7,0,0
1650    IF LEVEL=0 THEN LOCATE Y*3,  5: PRINT STR$(Y) +" "+ RARROW$    ELSE LOCATE Y*3-2,4: PRINT STR$(Y) +" "+ RARROW$
1680 NEXT Y
1690 IF LEVEL=1 THEN LOCATE 19,5 : PRINT "1 "+RARROW$
1700 LOCATE 20, 18
1710 IF LEVEL=0  THEN PRINT "     "+DARROW3$ +"  A   B   C   D   E   F  "+DARROW3$
1720 IF LEVEL<>0 THEN PRINT"    "+ DARROW3$+" A   B   C   D   E   F   A "+DARROW3$
1730 RETURN
1990 ' ****************************
1996 ' perform operation: +A, -3, -c, d, 6, ...
1997 ' inputs: OP$
1998 '
2000 IF OP$>="A" AND OP$<="Z" THEN OP$=CHR$( ASC(OP$)+ASC("a")-ASC("A") )
2005 IF OP$="l" OR OP$="q" OR OP$="r" OR OP$="s" THEN GOSUB 2850 ' doit or not?
2010 IF OP$="" THEN RETURN
2015 IF OP$="l" THEN GOTO 320
2018 IF OP$="m" THEN GOSUB 10000: RETURN
2020 IF OP$="q" THEN GOTO 2900
2025 IF OP$="r" THEN REDISPLAY=1: GOSUB 6000: GOTO 2600
2030 IF OP$="s" THEN REDISPLAY=1: GOSUB 1000: GOSUB 4100: GOTO 2600
2040 IF OP$="u" THEN GOTO 2700
2100 IF OP$="?" THEN  GOSUB 5500: REDISPLAY=1: RETURN
2110 IF OP$="/" THEN  GOSUB 5500: REDISPLAY=1: RETURN
2120 IF OP$="+" THEN DIR=+1: GOTO 2600
2130 IF OP$="!" THEN REDISPLAY=1: IF LEVEL=1 THEN LEVEL=0: RETURN ELSE LEVEL=1: RETURN
2140 IF OP$="-" THEN DIR=-1: GOTO 2600
2150 IF OP$=" " THEN REDISPLAY=1: RETURN
2220 ' must be a row or column slide
2240 IF (OP$<"1" OR OP$>"6") AND (OP$<"a" OR  OP$>"f") THEN BEEP: GOTO 2600
2260 IF NMOVES=MAXNMOVES THEN FOR I=1 TO MAXNMOVES/2: MOVES(I)=MOVES(I+MAXNMOVES/2): NEXT I: NMOVES=MAXNMOVES/2
2270 NMOVES=NMOVES+1
2280 MOVES(NMOVES)=ASC(OP$)*DIR
2300 SCORE=SCORE+1
2310 REDISPLAY=1
2320 GOSUB 7000
2330 DIR=1
2599 ' see if another character has been typed
2600 FOR I=1 TO 10
2610    OP$=INKEY$: IF OP$ <> ""  GOTO 2000
2620 NEXT I
2630 RETURN
2699 '   undo a move (and unscore it too)
2700 IF NMOVES=0 THEN BEEP: GOTO 2600
2710 IF NMOVES > MAXNMOVES THEN BEEP: GOTO 2600
2720 I=MOVES(NMOVES): IF I<0 THEN DIR=1: I=-I ELSE DIR=-1
2740 OP$=CHR$(I): REDISPLAY=1: GOSUB 7000: NMOVES=NMOVES-1: SCORE=SCORE-1: DIR=1
2800 GOTO 2600
2849 ' ask before doing something drastic
2850 IF SCRAMBLED=0 THEN RETURN
2855 IF MONO=1 THEN LOCATE 22,1 ELSE LOCATE 23,1
2860 PRINT " "+OP$+" resets the game; type `y' or 'n'   "
2870 X$=INKEY$: IF X$="" THEN GOTO 2870
2880 IF X$<>"y" AND X$<>"Y" AND X$<>"n" AND X$<>"N" THEN GOTO 2850
2885 IF X$="n" OR X$="N" THEN OP$=""
2890 RETURN
2898 '
2899 ' stopping
2900 CLS: LOCATE 12,15: IF MONO=0 THEN COLOR  12+16  ELSE COLOR 15+16
2920 PRINT "G O O D B Y E"
2925 IF MONO=0 THEN COLOR  12     ELSE COLOR 15
2930 LOCATE 15,10: PRINT "Thank you for playing"
2945 IF MONO=0 THEN COLOR  15     ELSE COLOR 7
2950 LOCATE 22,1: KEY ON
2960 STOP
2990 ' *********************************
2997 '
2998 '  enter a command
2999 '
3000 IF MONO=1 THEN LOCATE 22,1: X$=SPACE$(20)   ELSE LOCATE 23,1: X$="  "
3010 PRINT "  Enter command (or ?)"+X$+"  ("+MID$(STR$(SCORE),2)+" moves)    "
3020 I=1: OP$=""
3030 WHILE OP$=""
3035    OP$=INKEY$: I=I+1: IF I>(300-NMOVES) THEN GOTO 3052
3050 WEND
3052 IF LEN(OP$)>=2 THEN STOP
3055 IF OP$<>"" THEN RETURN
3060 IF RANDOMLY=0 OR SCRAMBLED=0 THEN GOTO 3020
3065 I=INT(12*RND)+1: IF I<=6 THEN GOSUB 7800 ELSE J=I-6: GOSUB 7600
3070 FOR II=1 TO 2: PLAY "ml t255 l64 n10n12n10n12n10n12n10n12n10n12n10": NEXT
3075 GOTO 3020
3990 ' *********************************
3996 '
3998 '       scramble
3999 '
4000 LOCATE 22,1: PRINT "scramble the square now? ('y' or 'n')"
4020 X$=INKEY$: IF X$="" THEN GOTO 4020
4025 IF X$="?" THEN GOSUB 5500: CLS: GOTO 4000
4030 LOCATE 22,1: PRINT "                                     "
4050 IF X$<>"y" AND X$<>"n" AND X$<>"Y" AND X$<>"n" THEN GOTO 4000
4060 IF X$="n" OR X$<>"N" THEN RETURN
4099 ' entry point here (scramble without prompting)
4100 IF MONO=1 THEN LOCATE 22,1 ELSE LOCATE 23,1
4105 PRINT " Square being scrambled ...          "
4107 K=30
4110 FOR K=1 TO K
4120    I=INT(12*RND)+1: SOUND 100,.2: DIR=-1
4125    IF I<=6 THEN GOSUB 7800: IF LEVEL=1 THEN I=I+1: IF I>6 THEN I=1: GOSUB 7800 ELSE GOSUB 7800
4130    IF I>6  THEN J=I-6: GOSUB 7600: IF LEVEL=1 THEN J=J+1: IF J>6 THEN J=1: GOSUB 7600 ELSE GOSUB 7600
4150 NEXT K
4160 'REDISPLAY=1
4170 SCORE=0: SCRAMBLED=1: NMOVES=0: DIR=1
4195 PLAY "ml t255 l64 ccddeeffggaabb"
4200 RETURN
4992 ' *********************************
4993 ' *********************************
4996 '    logo
5000 IF MONO=0 THEN 5200
5002 CLS
5005 LOCATE 3,1
5016 PRINT " *****  *   *  *****"
5018 PRINT "   *    *   *  *              IBM Personal Computer"
5020 PRINT "   *    *****  ***                Recreational"
5022 PRINT "   *    *   *  *                    Program"
5024 PRINT "   *    *   *  *****              Version 1.0c"
5028 LOCATE 10,1
5030 PRINT "    *****    *****    *     *     ***    ******    ******* (tm)"
5031 PRINT "   *     *  *     *   *     *    *   *   *     *   *"
5032 PRINT "   *        *     *   *     *    *   *   *     *   *"
5033 PRINT "    *****   *     *   *     *   *     *  ******    ****"
5034 PRINT "         *  *     *   *     *   *******  *   *     *"
5035 PRINT "   *     *  *     *   *     *  *       * *    *    *"
5036 PRINT "    *****    ********  *****   *       * *     *   *******"
5038 LOCATE 18,1
5040 PRINT "            Copyright (c) 1983 by David N. Smith"
5050 LOCATE 21,1
5055 PRINT "  HIT SPACE BAR TO CONTINUE"
5057 PRINT "  (Press M to change display type)"
5060 PRINT "  Hit ? for instructions at ANY time."
5065 X$=INKEY$ :  IF X$="" THEN GOTO 5065
5068 IF X$="?" THEN GOSUB 5500
5070 IF X$="m" OR X$="M" THEN GOSUB 10000: GOTO 5000
5075 IF X$="r" OR X$="R" THEN RANDOMLY=1: GOTO 5065
5090 RETURN
5199 'color display (40 column)
5200 CLS: LOCATE 5,5: PRINT "T H E"
5225 LOCATE 9,5: PRINT "S Q U A R E  (tm)"
5238 LOCATE 14,5: PRINT "Copyright (c) 1983 by David N. Smith
5240 LOCATE 15,5: PRINT "Version 1.0c"
5250 LOCATE 18,1: PRINT "  HIT SPACE BAR TO CONTINUE"
5260 PRINT "  (Press M to change display device)
5262 PRINT "  Hit ? for instructions at ANY time."
5265 X$=INKEY$ :  IF X$="" THEN GOTO 5265
5267 COLOR  7,0,0
5268 IF X$="?" THEN GOSUB 5500
5270 IF X$="m" OR X$="M" THEN GOSUB 10000: GOTO 5200
5290 RETURN
5492 ' *********************************
5495 '
5496 '    help
5500 CLS:  OP$="": REDISPLAY=1
5510 IF MONO=0 THEN INDENT$=" " ELSE INDENT$=SPACE$(20)
5902 PRINT INDENT$+"     C O M M A N D   S U M M A R Y"
5903 PRINT " "
5904 PRINT INDENT$+"a to f  Slide corresponding column(s)"
5906 PRINT INDENT$+"1 to 6  Slide corresponding row(s)"
5907 PRINT " "
5908 PRINT INDENT$+"-       Reverse direction of next
5909 PRINT INDENT$+"         row or column slide command."
5910 PRINT INDENT$+"        Examples:  -b  -6  -f  -1"
5911 PRINT " "
5912 PRINT INDENT$+"l       Reset level of difficulty."
5913 PRINT INDENT$+"m       To/From Monochrome Display
5914 PRINT INDENT$+"q       Quit; Don't play any longer."
5915 PRINT INDENT$+"r       Reset; put into solution."
5916 PRINT INDENT$+"s       Scramble again (differently)"
5917 PRINT INDENT$+"u       Undo the last move."
5919 PRINT INDENT$+"/ or ?  Display command summary"
5920 PRINT " "
5924 PRINT INDENT$+"Any other key causes a beep and is"
5926 PRINT INDENT$+"otherwise ignored."
5928 PRINT INDENT$
5929 IF MONO=0 THEN COLOR 12 ELSE COLOR 15
5932 PRINT " Hit any key to continue."
5933 COLOR 7
5934 OP$=INKEY$: IF OP$="" THEN GOTO 5934
5940 CLS
5980 RETURN
5990 ' ********************
5995 '
5997 ' initialize the square
5998 '
6000 FOR I=1 TO 3: FOR J=1 TO 3: SQ(I+J*6-6)=1: NEXT J: NEXT I
6050 FOR I=4 TO 6: FOR J=1 TO 3: SQ(I+J*6-6)=2: NEXT J: NEXT I
6060 FOR I=1 TO 3: FOR J=4 TO 6: SQ(I+J*6-6)=3: NEXT J: NEXT I
6070 FOR I=4 TO 6: FOR J=4 TO 6: SQ(I+J*6-6)=4: NEXT J: NEXT I
6075 SCORE=0: SCRAMBLED=0: NMOVES=0
6100 RETURN
6490 ' ******************************
6495 ' ask level of difficulty
6500 CLS
6505 LOCATE  8,10: PRINT "  Type a space for a Hard puzzle"
6515 LOCATE 12,10: PRINT "  Type an 'r' for a race against time"
6518 LOCATE 16,10: PRINT "  Hit any other key for a Harder puzzle"
6523 LOCATE 20,10: PRINT "  Hit ? for instructions at ANY time."
6530 X$=INKEY$: IF X$="" THEN GOTO 6530
6535 GOSUB 6000
6540 CLS: LEVEL=1
6555 IF X$="m" OR X$="M" THEN GOSUB 10000: GOTO 6500
6557 IF X$="r" OR X$="R" THEN RANDOMLY=1: LEVEL=0: RETURN
6560 IF X$=" " THEN LEVEL=0
6565 IF X$="?" THEN GOSUB 5500: GOTO 6500
6570 RETURN
6990 '*****************************
6995 '
6996 ' process command to rotate a column or row
6997 '
7000 IF OP$ >= "1" AND OP$ <= "6"  THEN GOTO 7100  ' row move
7010 IF OP$ <  "a" OR  OP$ >  "f"  THEN RETURN     ' error
7050 ' rotate a row
7060 J=ASC(OP$)-ASC("a")+1: GOSUB 7600  ' rotate row 'j'
7075 J=J-1: IF J=0 THEN J=6
7080 IF LEVEL=1 THEN GOSUB 7600 ' rotate row 'j'
7090 RETURN
7100 ' rotate a column
7110 I=ASC(OP$)-ASC("1")+1: GOSUB 7800  ' rotate row 'j'
7130 I=I-1: IF I=0 THEN I=6
7140 IF LEVEL=1 THEN GOSUB 7800 ' rotate column j
7150 RETURN
7590 ' ******************************
7595 ' rotate a row (7600)    or column (7800)
7600 IF DIR=-1 THEN X=SQ(1+J*6-6): FOR I=2 TO 6: SQ(I-1+J*6-6)=SQ(I+J*6-6): NEXT I: SQ(6+J*6-6)=X
7610 IF DIR=1  THEN X=SQ(6+J*6-6): FOR I=1 TO 5: SQ(7-I+J*6-6)=SQ(6-I+J*6-6): NEXT I: SQ(1+J*6-6)=X
7620 ICOL=0: JROW=J: GOSUB 9000 ' redisplay it
7650 RETURN
7799 ' rotate a column
7800 IF DIR=-1 THEN X=SQ(I+1*6-6): FOR J=2 TO 6: SQ(I+(J-1)*6-6)=SQ(I+J*6-6): NEXT J: SQ(I+6*6-6)=X
7810 IF DIR=1  THEN X=SQ(I+6*6-6): FOR J=1 TO 5: SQ(I+(7-J)*6-6)=SQ(I+(6-J)*6-6): NEXT J: SQ(I+1*6-6)=X
7820 JROW=0: ICOL=I: GOSUB 9000 ' redisplay it
7890 RETURN
7997 '****
7999 ' see if square has been solved and make noise if so.
8000 IF SCRAMBLED=0 THEN RETURN
8010 II=SQ(1+1*6-6)
8020 FOR I=1 TO 3: FOR J=1 TO 3: IF II<>SQ(I+J*6-6) THEN RETURN: ELSE: NEXT J: NEXT I
8030 II=SQ(4+1*6-6)
8040 FOR I=4 TO 6: FOR J=1 TO 3: IF II<>SQ(I+J*6-6) THEN RETURN: ELSE: NEXT J: NEXT I
8050 II=SQ(1+4*6-6)
8060 FOR I=1 TO 3: FOR J=4 TO 6: IF II<>SQ(I+J*6-6) THEN RETURN: ELSE: NEXT J: NEXT I
8070 II=SQ(4+4*6-6)
8080 FOR I=4 TO 6: FOR J=4 TO 6: IF II<>SQ(I+J*6-6) THEN RETURN: ELSE: NEXT J: NEXT I
8088 IF MONO=0 THEN COLOR 4
8090 PRINT "            Y O U   W I N ! ! !      "
8100 FOR J=1 TO 10
8105    FOR I=600 TO 1100 STEP 100:  SOUND I,.15: SOUND I-150,.15: NEXT I
8125    FOR I=1200 TO 600 STEP -200: SOUND I,.15: SOUND I-150,.15: NEXT I
8145 NEXT J
8150 SOUND 50,0: CLS
8235 IF MONO=1 THEN COLOR 15+16  ELSE COLOR  3+16        ' blinking display
8238 IF MONO=0 THEN INDENT$="        " ELSE INDENT$=SPACE$(27)
8240 PRINT INDENT$+"Y   Y    OO    U  U"
8241 PRINT INDENT$+" Y Y    O  O   U  U"
8242 PRINT INDENT$+"  Y     O  O   U  U"
8243 PRINT INDENT$+"  Y     O  O   U  U"
8244 PRINT INDENT$+"  Y      OO     UU"
8245 PRINT ""
8246 PRINT ""
8247 PRINT INDENT$+"W   W  III  N   N   !!!"
8248 PRINT INDENT$+"W   W   I   NN  N   !!!"
8249 PRINT INDENT$+"W   W   I   N N N   !!!"
8250 PRINT INDENT$+"W W W   I   N  NN"
8251 PRINT INDENT$+" W W   III  N   N    !"
8252 PRINT ""
8253 PRINT ""
8255 COLOR 7
8260 LOCATE 16,1
8265 PRINT "Hit space bar to see square"
8270 PRINT "Hit:   ? for help"
8275 PRINT "       s to scramble square again"
8280 PRINT "       q to quit"
8290 SCRAMBLED=0
8300 RETURN
8995 '****************************
8997 ' update one column or rwo
9000 'IF RUNNING=0  THEN RETURN
9040 REDISPLAY=0: IF MONO=0 THEN GOTO 9200
9100 COLOR  7,0:  IF ICOL>0 THEN GOTO 9150
9103 ' update mono column
9105 FOR I=1 TO 6
9110    X$=CH$(SQ(I+JROW*6-6)): X$=X$+X$+X$+X$+X$
9120    LOCATE I*3-1, 21+JROW*6-6: PRINT X$
9130    LOCATE I*3-0, 21+JROW*6-6: PRINT X$
9140 NEXT I
9145 RETURN
9150 ' update mono row
9155 FOR J=1 TO 6
9160    X$=CH$(SQ(ICOL+J*6-6)): X$=X$+X$+X$+X$+X$
9170    LOCATE ICOL*3-1, 21+J*6-6: PRINT X$
9180    LOCATE ICOL*3-0, 21+J*6-6: PRINT X$
9190 NEXT J
9195 RETURN
9197 ' ----- mono display -----
9200 ' update color column
9202 IF ICOL>0 THEN GOTO 9255
9205 FOR I=1 TO 6
9210    IC=SQ(I+JROW*6-6): COLOR ICOLOR(IC),0,0
9220    LOCATE I*3-1, 10+JROW*4-4: PRINT BLOBS$
9230    LOCATE I*3-0, 10+JROW*4-4: PRINT BLOBS$
9240 NEXT I
9242 COLOR 15,0
9245 RETURN
9250 ' update color row
9255 FOR J=1 TO 6
9257    IC=SQ(ICOL+J*6-6): COLOR ICOLOR(IC),0,0
9270    LOCATE ICOL*3-1, 10+J*4-4: PRINT BLOBS$
9280    LOCATE ICOL*3-0, 10+J*4-4: PRINT BLOBS$
9290 NEXT J
9292 COLOR 15,0
9295 RETURN
9980 '******************************
9990 ' COLOR MONITOR-MONOCHROME MONITOR SWITCH    EMD 11-81
10000 CLS
10010 PRINT
10020 PRINT"   For Color display press-C"
10030 PRINT"   For Monochrome press   -M"
10040 PRINT"   For no change press any other key."
10050 K$=INKEY$:IF K$="" GOTO 10050
10060 IF K$="C" OR K$="c" THEN GOSUB 10190
10070 IF K$="M" OR K$="m" THEN GOSUB 10110
10080 CLS
10090 REDISPLAY=1
10100 RETURN
10110 '************** switch to monochrome ************
10120 DEF SEG=0: POKE &H410,(PEEK(&H410) OR &H30)
10140 DEF SEG:  LOCATE ,,1,12,13
10155 SCREEN 0: WIDTH 80: COLOR  7,0: MONO=1
10170 RETURN
10180 '**************************
10190 REM switch to color/graphics adapter
10200 DEF SEG=0: POKE &H410,(PEEK(&H410) AND &HCF) OR &H20
10220 DEF SEG: LOCATE ,,1,6,7
10240 SCREEN 0: WIDTH 40: MONO=0
10260 RETURN
