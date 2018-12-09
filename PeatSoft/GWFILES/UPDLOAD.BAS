5  'UPDLOAD
10 'DTSS DUMB TERMINAL AND DOWN LOAD PROGRAM
20 ' Modified IMB dumb terminal example program; by Art Schneider Jan 16,82
22 '   File transfer program to & from IBM PC and DTSS Time Share computer
30 SCREEN 0,0
40 ' SEE PAGE F-4 IN BASIC BOOK  this program was modified for file transfer
50 '
60 '
70 KEY OFF : CLS: CLOSE
80 '
90 DEFINT A-Z
95 KEY 5,"old "                   'DTSS edit commands
97 KEY 7,"tex rep PRINT,"
99 KEY 8,"PRINT#FF/,,ALL"
100 KEY 10,"UNSAVE " : KEY 4,"tap"
101 KEY 9,"TEX REP &,+,ALL"
110 FALSE=0 : TRUE = NOT FALSE
112 K=0 : PUN$ = "PUN"+CHR$(13)
114 P$ = "ABCDE" :CR = FALSE : CTC$ = CHR$(3)
116 X1$ = "": AB$="ABORT" : DN=FALSE
120 XOFF$=CHR$(19) : XON$=CHR$(17)
130  NW$ = "tap" + CHR$(13)
132 COLOR 15,0 : PRINT TAB(15);"DTSS down load up load and dumb terminal program"
134 COLOR 7,0 : PRINT TAB(15);"to down load  have disk in drive.  "
136 PRINT TAB(15);"Connect with DTSS; call up file with OLD name.
138 PRINT TAB(15);"Start down load with PUN & then give disk:name" ; " <<<<"
140 PRINT TAB(15);"when asked. " : PRINT
141 PRINT TAB(15);"Start up-load with  tap  on key 4"; " <<<<"
142 PRINT TAB(15); "dial up & press return about 3 times"
144 M$=INKEY$
146 IF M$<> CHR$(13) THEN 144
160 OPEN "com1:300,E,7,1" AS #1
180 OPEN "scrn:" FOR OUTPUT AS 2
200 LOCATE ,,1
400 PAUSE =FALSE :ON ERROR GOTO 9000
450 KEY ON
500 'send keyboard input to com line
510 B$=INKEY$: IF B$<>"" THEN PRINT#1,B$;:PRINT #2,B$;:IF B$ = CHR$(13) THEN CR=TRUE: K=0
512 IF B$=CTC$ THEN PRINT #1, CHR$(0) 'break DTSS
515 IF CR=TRUE AND B$<>"" THEN P$=RIGHT$(P$+B$,4) : IF P$=PUN$ OR P$=NW$ THEN 1000 ELSE K=K+1 : IF K>=5 THEN K=0 : CR=FALSE
520 '
530 IF EOF(1) THEN 510
570 IF LOC(1)>128 THEN PAUSE=TRUE : PRINT #1,XOFF$;
590 C$= INPUT$(LOC(1),#1) :A$=""
600 ' x linefeed
620 FOR I = 1 TO LEN(C$)
630 A1$=MID$(C$,I,1) :AX=ASC(A1$) : IF AX <> 10 THEN A$=A$+A1$
640 NEXT I
650 PRINT #2,A$;: IF LOC(1)>0 THEN 570
690 IF PAUSE THEN PAUSE=FALSE : PRINT #1,XON$;
710 GOTO 510
990 'DOWN LOAD rutine here after  PUN  input
1000 'PUN doun load sub
1010 PRINT #1, XOFF$
1015 IF P$ = NW$ THEN 3000      'up-load sub
1020 COLOR 15,0
1030 INPUT "IBM   disk:File-Name.BAS  ";F$
1040 COLOR 7,0
1042 IF F$ =AB$ THEN PRINT #1,XON$ :GOTO 510
1050 OPEN F$ FOR OUTPUT AS #3
1060 PRINT #1,XON$
1101 PRINT "file open"
1200 IF LOC(1)>128 THEN PAUSE=TRUE : PRINT #1,XOFF$;
1300 A$ = INPUT$(LOC(1),#1) :C$=""
1400 FOR I = 1 TO LEN(A$)
1500 A1$ = MID$(A$,I,1) : AX = ASC(A1$)
1600 IF AX =13  THEN C$ = C$+A1$
1620 IF AX >31 AND AX<126  THEN C$ = C$+A1$
1650 IF AX =19 THEN DN =TRUE : GOTO 1800
1700 NEXT I
1800 PRINT#2,C$; : PRINT #3,C$; :IF DN THEN 2000   ELSE IF LOC(1) > 0 THEN 1200
1850 IF PAUSE THEN PAUSE=FALSE: PRINT #1, XON$;
1900 GOTO 1200
2000 IF NOT PAUSE THEN PRINT #1,XOFF$;
2100 CLOSE #3
2200 COLOR 15,0
2300 PRINT "File ";F$;" transfered"
2400 COLOR 7,0
2450 FOR JJ = 1 TO 5 : SOUND RND*1000 +37 ,6 : NEXT JJ
2500 P$ ="abcde" :CR=FALSE :DN=FALSE:K=0:PAUSE=FALSE :PRINT #1, XON$;: GOTO 510
3000 ' up load sub
3050 COLOR 15,0
3100 INPUT "Send IBM file.... d:name.ext";IBF$
3150 ON ERROR GOTO 5000
3200 IF IBF$ = AB$ THEN PRINT #1, XON$; : GOTO 510
3250 OPEN IBF$ FOR INPUT AS #3
3300 PRINT "File...."; IBF$; " open for transfer."
3350 PRINT #1, XON$; : COLOR 7,0
3360 ON ERROR GOTO 9000
3400 IF EOF(3) THEN 2000
3500 LINE INPUT #3,L$
3550 PRINT #1,L$  : PRINT #2,L$
3700 'send keyboard input to com line
3720 B$=INKEY$: IF B$<>"" THEN PRINT#1,B$;:PRINT #2,B$;
3740 IF B$=CTC$ THEN PRINT #1, CHR$(0) 'break DTSS
3760 IF EOF(1) THEN 3400
3780 IF LOC(1)>128 THEN PAUSE=TRUE : PRINT #1,XOFF$;
3800 C$= INPUT$(LOC(1),#1) :A$=""
3810 ' x linefeed
3820 FOR I = 1 TO LEN(C$)
3830 A1$=MID$(C$,I,1) :AX=ASC(A1$) : IF AX <> 10 THEN A$=A$+A1$
3840 NEXT I
3850 PRINT #2,A$;: IF LOC(1)>0 THEN 3780
3860 IF PAUSE THEN PAUSE=FALSE : PRINT #1,XON$;
3900 GOTO 3400
5000 IF ERR = 53 OR ERR = 64 THEN PRINT "I can`t open " IBF$ : RESUME 3100
5100 IF ERR = 68 OR ERR = 71 THEN PRINT "Check disk " : RESUME 3100
5200 ON ERROR GOTO 9000
9000 RESUME
9990 END
UME 3100
5100 IF ERR = 68 OR ERR = 71 THEN PRINT "Check disk " : RESUME 3