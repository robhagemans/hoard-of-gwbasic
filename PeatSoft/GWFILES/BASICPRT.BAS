10 REM==================================================================
20 REM==============  Print a BASIC source program   ===================
30 REM===   This program prints a source listing of a BASIC program ====
40 REM===   and prints all remarks statements (REM) in emphasized  =====
50 REM===   font.  ALSO, certain printer control statements are    =====
60 REM===   recognized when they are the only comment on a REM stmt=====
70 REM===      For example:                                        =====
80 REM===         REM $s4     will space 4 lines on the printer    =====
90 REM===         REM $pa     will eject to top of next page       =====
100 REM==================================================================
110 REM $s1                                 '
120 ON ERROR GOTO 900                       '
130 TIMEOUT.COUNT=0                         '
140 PTIME$ = TIME$
150 CLS : KEY OFF                           ' Clear screen
160 LOCATE 12,10 : PRINT "Note:  Drive B and filetype of BAS is assumed"
170 LOCATE 13,10 : PRINT "Also:  Pgm must have been saved using ASCII option"
180 LOCATE 10,10 : COLOR 0,7                ' Center query for file name
190 LINE INPUT " Enter the name of the BASIC source program: ";AAA$
200 COLOR 7,0
210 GOSUB 380
220 OPEN "b:"+AAA$+".bas" FOR INPUT AS 1
230 LC = -1
240 IF EOF(1) THEN 290
250   LINE INPUT#1,REC$
260   GOSUB 770     ' check for enough vertical space
270   GOSUB 500     ' check for print control and print line if required
280 GOTO 240
290 CLOSE 1
300 CLS : KEY ON : LPRINT CHR$(12)     ' Final page skip
310 END
320 REM $S3
330 REM==================================================================
340 REM======================  SUBROUTINE  ==============================
350 REM=========  Convert lower case letters to upper case  =============
360 REM==================================================================
370 REM $s1                                 '
380 FOR I = 1 TO LEN(AAA$)
390   AA$ = MID$(AAA$,I,1)
400     IF ASC(AA$)=>97 AND ASC(AA$)<= 122 THEN AA$ = CHR$(ASC(AA$)-32)
410     MID$(AAA$,I,1) = AA$
420 NEXT I
430 FOR I = 1 TO 8-LEN(AAA$)
440   AAA$ = AAA$+" "
450 NEXT I
460 RETURN
470 REM $pa
480 REM==================================================================
490 REM=========================  SUBROUTINE  ===========================
500 REM============= Check for special printer control rem's  ===========
510 REM==================================================================
520 REM $s1                                 '
530   FOR I = 1 TO 8
540      AA$ = MID$(REC$,I,3)
550      IF AA$="REM" THEN GOTO 580
560   NEXT I
570   GOTO 730
580   AA$ = MID$(REC$,I+4,1)
590   PC$= CHR$(27)+CHR$(69)           '  Turn ON emphasized for rem stmt
600   IF AA$ <> "$" THEN 730           '  Check for REM $ format
602   AA$=MID$(REC$,I+5,1)             '  If so, pick up next character
610   IF AA$ <> "S" AND AA$ <> "s" THEN 700 'Check for Line Space cmd
620   AA = VAL(MID$(REC$,I+6,1))
630   IF AA<1 OR AA>9 THEN RETURN           '
640   FOR I = 1 TO AA
650      LPRINT " "
660      LC = LC-1
670   NEXT I
680   PC$= CHR$(27)+CHR$(70)           '  Turn OFF emphasized font
690   RETURN
700     IF AA$<>"p" AND AA$<>"P" THEN 730   ' Check for page eject
710     GOSUB 840                           ' Issue page eject
720     RETURN                              '
730   LPRINT PC$;REC$
740   PC$=CHR$(27)+CHR$(70)
750   RETURN
760 REM $S3
770 REM==================================================================
780 REM=========================  SUBROUTINE  ===========================
790 REM================  Check for vertical spacing   ===================
800 REM==================================================================
810 REM $s1                                 '
820 IF LC > 0 THEN 880
830 IF LC < 0 THEN 850
840   LPRINT CHR$(12)          ' skip to top of page
850  LC = 55
860 LPRINT CHR$(14)+CHR$(27)+CHR$(71)+DATE$+STRING$(4,32)+"PGM: "+AAA$+STRING$(4,32)+PTIME$
870 LPRINT CHR$(27)+CHR$(72)+CHR$(27)+CHR$(20)+" ":LPRINT" " : LPRINT " "
880 LC = LC-1
890 RETURN
900 REM $pa                                     '
910 REM ===============================================================
920 REM ==  Error trapping routine, intended primarily to handle  =====
930 REM ==  device timeout on the printer when too much page      =====
940 REM ==  ejecting is done.                                     =====
950 REM ===============================================================
960 REM $s1                                 '
970    IF ERR <> 24 THEN 1030                   '
980    TIMEOUT.COUNT=TIMEOUT.COUNT+1           ' Incr number of timeouts
990    IF TIMEOUT.COUNT<10 THEN RESUME NEXT    ' give it 10
1000      CLS : BEEP : BEEP                  '
1010      PRINT "Program aborted due to too many device timeouts"
1020      END                                '
1030    CLS : BEEP :BEEP                     '
1040    PRINT "Program aborted due to error code = ";ERR
1050    END                                  '
                  '
1040    PRINT "Program aborted due to error code = ";ERR
1050    END                