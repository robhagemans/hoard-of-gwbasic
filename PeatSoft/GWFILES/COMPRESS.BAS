10  '*****************************************************************
20  '***********                                           ***********
30  '***********       COMPRESS [Any BASIC Program]        ***********
40  '***********                                           ***********
50  '*****************************************************************
60   '         *   COPYRIGHT 1982  -  CRAIG W. UTHE        *
70   '         *   WRITTEN 3/13/82 BY CRAIG W. UTHE        *
80   '         *                 * * * *                   *
90   '         *   ANY INDIVIDUAL MAY COPY THIS PROGRAM    *
100  '         *   AND MAKE MODIFICATIONS TO IT IF THAT    *
110  '         *   INDIVIDUAL ARRANGES TO CONTRIBUTE ONE   *
120  '         *   OTHER PROGRAM TO THE IPCO SOFTWARE      *
130  '         *   EXCHANGE LIBRARY.  HOWEVER, COPIES      *
140  '         *   ARE NOT ALLOWED TO BE SOLD, NOT IN      *
150  '         *   WHOLE NOR IN PART, NOT SEPARATELY       *
160  '         *   NOR JOINTLY WITH OTHER SOFTWARE.        *
170  '         *********************************************
180  '
190  '
200   'This is a preprocessor for BASIC which deletes all
210   ' '-comments and extra spaces (except when in quotes).
220   'All '-comment-only lines are deleted.  Line numbers will
230   'be displayed as lines are compressed, except for deleted lines.
240   '
250   '**An early test-run on a very-structured program reduced the
260   '**program from 20,600 B to 9,600 B.  (ASCII format storage
270   '**was about 1 K greater for each.)  Apparently, COMPRESS
280   '**cut the size of the program to LESS than HALF!!!!
290   '**BUT, it takes a LONG time:  2 to 3 seconds/line
300   '
310   '
320   'BE SURE that the BASIC uncompressed file is stored as an
330   'ASCII file -- this program does not check for this!!!
340   '
500 'Mainflow-control routine
510     PRINT : PRINT "ENTER NAME OF FILE TO BE COMPRESSED."
520     PRINT "MUST have extention .BAS (Do not give extention)."
530     PRINT "Result will be stored in <filename>.CMP ."
540     PRINT "(MUST have been stored as ASCII file):";
550     INPUT FILENAME$
560     PRINT : PRINT "ENTER LINE NUMBER OF FIRST LINE TO BE COMPRESSED."
570     PRINT "COMPRESS starts compression after this number is"
580     PRINT "reached or passed.  You may respond with 0:";
590     INPUT START.LINE.NUMBER% : PRINT
600     OPEN FILENAME$+".BAS" FOR INPUT AS #1
610     OPEN FILENAME$+".CMP" FOR OUTPUT AS #2
620     WHILE NOT EOF(1)
630             OUTLINE$ = STRING$(255,0) : J% = 1
640             LINE INPUT#1, INLINE$
650             IF VAL(MID$(INLINE$,1, INSTR(INLINE$," "))) < START.LINE.NUMBER%                        THEN PRINT#2, INLINE$ : PRINT LEFT$(INLINE$,                                            INSTR(INLINE$, " ")) : GOTO 710
660             I% = 1
670             WHILE I% <= LEN(INLINE$)
680                     IF MID$(INLINE$,I%,1) = CHR$(34)                                                        THEN GOSUB 1000 ELSE GOSUB 2000                                                 '1000 = in-quotes rtn; 2000 = out-of-quotes rtn
690                     WEND
700             IF NOT MID$(OUTLINE$, (1 + INSTR(OUTLINE$," ")), 1) = "'"                               THEN PRINT#2, LEFT$(OUTLINE$,J%-1)                                                      : PRINT LEFT$(OUTLINE$, INSTR(OUTLINE$, " "))
710             WEND
720     BEEP : PRINT "COMPRESSED PROGRAM STORED AS "FILENAME$+".CMP" : END
730  '
1000 'In-quotes-preprocessing routine
1010    CHARS.TIL.NEXT.QUOTE% = INSTR(MID$(INLINE$,I%+1), CHR$(34))
1020    IF CHARS.TIL.NEXT.QUOTE% = 0                                                            THEN CHARS.TIL.NEXT.QUOTE% = LEN(INLINE$) - I%
1030    MID$(OUTLINE$,J%, CHARS.TIL.NEXT.QUOTE% + 1)                                            = MID$(INLINE$,I%, CHARS.TIL.NEXT.QUOTE% + 1)
1040    I% = I% + CHARS.TIL.NEXT.QUOTE% + 1
1050    J% = J% + CHARS.TIL.NEXT.QUOTE% + 1
1060    RETURN
1070 '
2000 'Out-of-quotes-preprocessing routine
2010    IF MID$(INLINE$, I%, 1) = "'"  THEN MID$(OUTLINE$,J%,1) = "'"                           : J% = J% + ABS(J% = (1+INSTR(OUTLINE$," ")))                                   : I% = I% + LEN(INLINE$) + 1   : GOTO 2050 'RETURN
2020    IF MID$(INLINE$, I%, 1) = " " AND MID$(INLINE$, I% + 1, 1) = " "                        THEN I% = I% + 1 : GOTO 2050 'RETURN
2030    'ELSE
2040            MID$(OUTLINE$, J%, 1) = MID$(INLINE$, I%, 1)                                            : J% = J% + 1 : I% = I% + 1
2050    RETURN
UTLI