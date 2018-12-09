10 REM
20 REM  ***********************************************************************
30 REM  *                                                                     *
40 REM  *                                                                     *
50 REM  *                                                                     *
60 REM  *                                                                     *
70 REM  *                          DEFKEY                                     *
80 REM  *                      A TOTAL KEYBOARD                               *
90 REM  *                   RE-DEFINITION PROGRAM                             *
100 REM *                                                                     *
110 REM *                                                                     *
120 REM *                       CREATED BY                                    *
130 REM *                                                                     *
140 REM *                     CHARLIE TOMBERG                                 *
150 REM *                                                                     *
160 REM *                      5 HOOKER LANE                                  *
170 REM *                    COS COB, CT. 06807                               *
180 REM *                      (203)869-6707                                  *
190 REM *                      (203)869-6707                                  *
200 REM *                                                                     *
210 REM *                                                                     *
220 REM *                                                                     *
230 REM *                                                                     *
240 REM *                                                                     *
250 REM ***********************************************************************
260 REM
270 REM
280 REM THE ALLIANGE LIVED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
290 REM A PRODUCT OF C.M.T. LABORATORIES  GREENWICH, CONNECTICUT
300 REM
310 REM
320 REM
330 REM
340 DEFINT I-Z:DEFSTR A-H
350 KEY OFF
360 DIM INDEX(200), AINDEX(150)
370 REM READS ALT VALUES INTI INDEX(X)
380 GOSUB 1340
390 REM INITIALIZES VARIABLES
400 GOSUB 1680
410 CLS : LOCATE 5,20
420 PRINT "****************************************"
430 LOCATE 6,20 : PRINT "*                                      *"
440 LOCATE 7,20 : PRINT "*                                      *"
450 LOCATE 8,20 :PRINT  "*                                      *"
460 LOCATE 8,20 : PRINT "*                                      *"
470 LOCATE 9,20 : PRINT "*            WELCOME TO                *"
480 LOCATE 10,20 : PRINT "*                                      *"
490 LOCATE 11,20 : PRINT "*              DEFKEY                  *"
500 LOCATE 12,20 : PRINT "*                                      *"
510 LOCATE 13,20 : PRINT "*                                      *"
520 LOCATE 14,20 : PRINT "*          A TOTAL KEYBOARD            *"
530 LOCATE 15,20 : PRINT "*       RE-DEFINITION  PROGRAM         *"
540 LOCATE 17,20 : PRINT "*     CREATED BY CHARLIE TOMBERG       *"
550 LOCATE 16,20 : PRINT "*                                      *"
560 LOCATE 18,20 : PRINT "*           JANUARY, 1984              *"
570 LOCATE 19,20 : PRINT "*                                      *"
580 LOCATE 20,20 : PRINT "*                                      *"
590 LOCATE 21,20 : PRINT "****************************************"
600 OPEN "O", #1, "DEFKEY.ANS"
610 CLS
620 LOCATE 16,45 : PRINT "(ENTER `HELP' OR <CR> FOR HELP)"
630 LOCATE 15,20: INPUT "ENTER KEY TO BE DEFINED. (ENTER `EXIT' TO END) ";AKEY
640 IF AKEY="END" OR AKEY="EXIT" OR AKEY="BYE" OR AKEY="DONE" OR AKEY="STOP" THEN 1120
650 IF AKEY="HELP" OR AKEY="" THEN 660 ELSE 770
660 REM PRINTS OUT SPECIAL KEYS
670 CLS : LOCATE 1,28: PRINT "SPECIAL KEYS": PRINT
680 FOR IND=1 TO 150 : IF AINDEX(IND)<> "" THEN PRINT AINDEX(IND),
690 NEXT IND
700 PRINT :PRINT: PRINT "1) TO DEFINE A SPECIAL KEY, ENTER THE KEY'S NAME EXACTLY AS GIVEN ABOVE.": PRINT "   NOTE : `aF1' REFERS TO `ALT-F1' ,`CF1' TO `CTRL-F1' AND `SF1` TO `SHIFT-F1'."
710 PRINT "          `FK' STANDS FOR `FUNCTION KEY'. " : PRINT
720 PRINT "2) TO DEFINE A STANDARD KEY, SIMPLY ENTER THAT CHARACTER.": PRINT
730 PRINT "3) TO DEFINE AN ALT-KEY SEQUENCE, ENTER AN  A BEFORE THE CHARACTER."
740 PRINT "    EXAMPLE:   AB   WOULD DEFINE THE  ALT-B  SEQUENCE."
750 LOCATE 25,15 : PRINT "****** HIT ANY KEY TO CONTINUE **********"; : A$=INPUT$(1) :CLS
760 GOTO 610
770 LOCATE 18,20 : INPUT "ENTER NEW DEFINITION  ( <CR> FOR HELP ) "; ANSI.KEY
780 IF ANSI.KEY="" THEN 790 ELSE 920
790 REM HELP ON NEW DEFINITION REQUESTED
800 CLS: LOCATE 1,26: PRINT "DEFINITION HELP" : PRINT
810 PRINT "1) DEFINITIONS MAY EITHER BE IN THE FORM OF SIMPLE STRINGS "
820 PRINT "   OR OF SIMPLE ASCII EXPRESSIONS." : PRINT
830 PRINT "   EXAMPLE OF A SIMPLE STRING :   ENTER  `HAVE A NICE DAY'  ."
840 PRINT "                                  NOTE : NO QUOTATION MARKS ARE REQUIRED."
850 PRINT : PRINT : PRINT: PRINT
860 PRINT "2) IF YOU CHOOSE TO ENTER AN ASCII EXPRESSION, YOU MUST ENTER THE"
870 PRINT "   LETTERS `ASC' BEFORE THE ASCII CODE NUMBER YOU WISH TO USE."
880 PRINT
890 PRINT "   FOR EXAMPLE, YOU MIGHT ENTER  `ASC068' TO ASSIGN AN UPERCASE"
900 PRINT "   `D' TO A KEY, SINCE 068 IS THE ASCII CODE FOR A `D'.
910 PRINT : PRINT : LOCATE 23,15 : PRINT "********** HIT ANY KEY TO CONTINUE ***********" : A$=INPUT$(1) : CLS :GOTO 770
920 CLS
930 IF LEFT$(ANSI.KEY,3)="ASC" AND VAL(MID$(ANSI.KEY,5,1))>0 THEN 940 ELSE 960
940 REM ASCII VALUE ENTERED AS DEFINITION
950 ANSI.KEY=CHR$(VAL(RIGHT$(ANSI.KEY,LEN(ANSI.KEY)-3)))
960 IF LEN(AKEY)>1 AND LEFT$(AKEY,1)="A" THEN 970 ELSE 1010
970 REM KEY NOW DEFINDED USING "ALT"
980 AKEY=RIGHT$(AKEY,1) :GOSUB 1200
990 PRINT #1,CHR$(27)"[0;"ASKEY.CODE";"CHR$(34);ANSI.KEY;CHR$(34)"p";
1000 GOTO 1110
1010 IF LEN(AKEY)>2 THEN 1020 ELSE 1070
1020 REM SPECIAL KEYS CASE
1030 REM FINDS PROPER EXTENDED CODE
1040 GOSUB 1560
1050 PRINT #1,CHR$(27)"[0;"ASKEY.CODE";"CHR$(34);ANSI.KEY;CHR$(34)"p";
1060 GOTO 1110
1070 REM KEY DEFINED WITHOUT "ALT"
1080 VAL.ASCII=ASC(AKEY):ASKEY.CODE =MID$(STR$(VAL.ASCII),2)
1090 PRINT #1,CHR$(27)"["ASKEY.CODE";"CHR$(34);ANSI.KEY;CHR$(34)"p";
1100 REM RE-INITIALIZES VARIABLES AND GETS NEXT KEY
1110  GOSUB 1680 : GOTO 610
1120 CLOSE
1130 CLS
1140 SYSTEM
1150 REM
1160 REM _______________________  LOGICAL END OF PROGRAM ______________________
1170 REM
1180 REM
1190 REM
1200 REM ********** SUBROUTINE RETURNS ALT VALUES *****************************
1210 REM INPUTS :  AKEY     OUTPUTS : ASKEY.CODE
1220 REM
1230 REM
1240 REM
1250 ASKEY.CODE =MID$(STR$(INDEX(ASC(AKEY))),2)
1260 RETURN
1270 REM
1280 REM
1290 REM
1300 REM **********************************************************************
1310 REM
1320 REM
1330 REM
1340 REM ********* SUBROUTINE READS ALT VALUES INTO INDEX(X) AND AINDEX(X) *****
1350 REM
1360 REM
1370 REM
1380 READ CHAR
1390 WHILE CHAR <> "*"
1400    READ INDEX(ASC(CHAR))
1410    READ CHAR
1420 WEND
1430 REM
1440 REM READS VALUES INTO AINDEX(X)
1450 READ ASPECIALKEY
1460 WHILE ASPECIALKEY <> "*"
1470    READ NUMBER
1480    AINDEX(NUMBER)=ASPECIALKEY
1490    READ ASPECIALKEY
1500 WEND
1510 RETURN
1520 REM
1530 REM *********************************************************************
1540 REM
1550 REM
1560 REM ********** SUBROUTINE RETURNS CODES FOR SPECIAL KEYS ****************
1570 REM INPUTS : AKEY  OUTPUTS : ASKEY.CODE
1580 REM
1590 REM
1600 ISDONE=0
1610 FOR I=1 TO 150
1620     IF AINDEX(I)=AKEY THEN ASKEY.CODE = MID$(STR$(I),2) : ISDONE=1
1630 NEXT
1640 IF ISDONE=0 THEN PRINT :LOCATE 13,20:BEEP: PRINT " SPECIAL KEY NOT FOUND. PLEASE TRY AGAIN.": FOR TIME=1 TO 2000: NEXT TIME
1650 RETURN
1660 REM
1670 REM
1680 REM ***************** SUBROUTINE INITIALIZES VARIABLES *******************
1690 AKEY="" : A$="" : ANSI.KEY= "" : CHAR ="" :
1700 CODE="" : IND =0 : ISDONE =0 : NUMBER =0 : VAL.ASCII =0 : ASKEY.CODE ="" : ASPECIALKEY="" : TIME =0
1710 RETURN
1720 REM *********************************************************************
1730 REM
1740 REM
1750 REM ******************** DATA FOR INDEX(X)
1760 REM
1770  DATA Q,16,W,17,E,18,R,19,T,20,Y,21,U,22,I,23,O,24,P,25
1780 DATA A,30,S,31,D,32,F,33,G,34,H,35,J,36,K,37,L,38
1790 DATA Z,44,X,45,C,46,V,47,B,48,N,49,M,50
1800 DATA "1",120,"2",121,"3",122,"4",123,"5",124,"6",125,"7",126,"8",127,"9",128,"0",129,"-",130,"=",131
1810 DATA "*"
1820 REM ******************** DATA FOR AINDEX(X)
1830 DATA "SHIFT TAB", 15,"FK1",59,"FK2",60,"FK3",61,"FK4",62,"FK5",63,"FK6",64,"FK7",65,"FK8",66,"FK9",67,"FK10",68
1840 DATA "HOME",71,"CURSOR UP",72,"PG UP",73,"CURSOR LEFT",75,"CURSOR RIGHT",77
1850 DATA "END",79,"CURSOR DOWN",80,"PG DN",81,"INS",82,"DEL",83
1860 DATA "SF1",84,"SF2",85,"SF3",86,"SF4",87,"SF5",88,"SF6",89,"SF7",90,"SF8",91,"SF9",92,"SF10",93
1870 DATA "CF1",94,"CF2",95,"CF3",96,"CF4",97,"CF5",98,"CF6",99,"CF7",100,"CF8",101,"CF9",102,"CF10",103
1880 DATA "aF1",104,"aF2",105,"aF3",106,"aF4",107,"aF5",108,"aF6",109,"aF7",110,"aF8",111,"aF9",112,"aF10",113
1890 DATA "CTRL-PRTSC",114,"CTRL-CURSOR LEFT",115,"CTRL-CURSOR RIGHT",116,"CTRL-END",117
1900 DATA "CTRL-PG DN",118,"CTRL-HOME",119,"CTRL-PG UP",132
1910 DATA "*"
1920 END
