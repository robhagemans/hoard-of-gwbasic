10  ' dicegame.bas - FreeWare 2004
20 GOTO 160 ' begin
30 SAVE "dicegame.bas",A:LIST-110
40 GOTO 730 ' init die
50 GOTO 800 ' display die
60 GOTO 910 ' check for win, lose
70 GOTO 950 ' rotate cube
80 GOTO 1000 ' display die's value
90 GOTO 1080 ' introduction
100 GOTO 1200 ' delay .0625 sec
110 GOTO 1210 ' delay 1 sec
120 GOTO 1220 ' delay 2 sec
130 GOTO 1250 ' get key
140 GOTO 1290 ' print text centered
150 ' begin
160 A$=CHR$(220)+CHR$(223):KEY OFF:DEFSTR M,Q:Q=MKI$(0):DIM M(11)
170 M(1)="DICEGAME is a three-dimensional challenge."
180 M(2)="We play the game with a single die, and add points to"
190 M(3)="the running total by turning the die a quarter-turn"
200 M(4)="that is, moving one of the numbers a round the sides"
210 M(5)="to the top and adding the value on top to the total."
220 M(6)=" * The object -- a real challenge to your thinking powers *"
230 M(7)="is to either reach 31 or force me to go above 31."
240 M(8)="I'll try to do the same to you.":PRINT
250 M(9)=" ** Even die-hard gamesters will find DICEGAME a challenge **"
260 M(10)="for the rest of us, it will be a dicey problem!"
270 M(11)="Press any key to continue..."
280 ' introduction
290 GOSUB 1080
300 CLS:LOCATE 8,15:PRINT "Do you want to go first ?":GOSUB 130
310 F$=Q
320 CLS:RT=0:RESTORE:RANDOMIZE TIMER
330 ' initialize and display die and values
340 GOSUB 730:GOSUB 1000:COLOR 15,0
350 LOCATE 1,21:PRINT "Running Total:"
360 LOCATE 1,10:PRINT "Me:"
370 LOCATE 1,51:PRINT "You:"
380 LOCATE 1,13:PRINT CS             ' computer score
390 LOCATE 1,55:PRINT HS             ' his score
400 LOCATE 1,35:PRINT RT:COLOR 7,0   ' running total
410 IF F$="n" OR F$="N" THEN 570     ' Goto Comp's move. else, human's
420 ' human's move
430 LOCATE 4,27:COLOR 11,0:PRINT "Your Move":COLOR 12,0
440 LOCATE 1,35:PRINT RT:COLOR 11,0
450 LOCATE 15,15:PRINT STRING$(60,32)
460 LOCATE 15,15:INPUT "What number do you want on top";C$:COLOR 7,0
470 IF C$=CHR$(27) THEN CLS:GOTO 1320
480 C=VAL(C$):IF C=0 THEN CLS:GOTO 1320
490 IF C<1 OR C>6 THEN 460
500 IF C=A(1) OR C=A(6) THEN FOR G=1 TO 3:LOCATE 4,27:PRINT "*Illegal*":GOSUB 1200:LOCATE 4,27:PRINT "         ":GOSUB 1200:NEXT:GOTO 430
510 ' re-do display
520 GOSUB 950:RT=RT+C
530 GOSUB 910
540 IF L=-1 THEN CLS:LOCATE 8,28:PRINT "I win!":CS=CS+1:GOTO 930
550 IF L=1 THEN CLS:LOCATE 8,28:PRINT "You win!":HS=HS+1:GOTO 930
560 LOCATE 1,35:PRINT RT:GOSUB 1220
570 LOCATE 4,27:PRINT "My Move  "
580 LOCATE 15,15:PRINT STRING$(60,32)
590 LOCATE 15,20:PRINT "I turn the die to";
600 IF RT=30 AND A(1)<>1 AND A(6)<>1 THEN C=1:GOTO 660
610 IF RT=29 AND A(1)<>1 AND A(6)<>1 THEN C=1:GOTO 660 ' select 1
620 C=31-RT
630 IF C<=6 AND RT<31 AND A(1)<>C AND A(6)<>C THEN 660 ELSE C=22-RT:IF C<=6 AND RT<22 AND A(1)<>C AND A(6)<>C THEN 660 ELSE C=13-RT:IF C<=6 AND RT<13 AND A(1)<>C AND A(6)<>C THEN 660 ELSE C=4-RT:IF C<=6 AND RT<4 AND A(1)<>C AND A(6)<>C THEN 660
640 IF A(1)<>1 AND A(6)<>1 THEN C=1 ELSE C=2
650 ' move found by now
660 GOSUB 1210:PRINT C;:GOSUB 950 ' re-do display
670 GOSUB 1210
680 RT=RT+C:GOSUB 910
690 IF L=-1 THEN CLS:LOCATE 8,28:PRINT "You win!":HS=HS+1:GOTO 930
700 IF L=1  THEN CLS:LOCATE 8,28:PRINT "I win!"  :CS=CS+1:GOTO 930
710 GOTO 430
720 ' initialization of die for this game
730 A(1)=FIX(RND*6)+1:A(6)=7-A(1)
740 A(2)=FIX(RND*6)+1
750 IF A(2)=A(1) OR A(2)=A(6) THEN 740 ELSE A(5)=7-A(2)
760 A(3)=FIX(RND*6)+1
770 IF A(3)=A(1) OR A(3)=A(6) OR A(3)=A(2) OR A(3)=A(5) THEN 760 ELSE A(4)=7-A(3)
780 RT=RT+A(1)
790 ' now display die
800 LOCATE 12,23:PRINT STRING$(10,220)                 ' bottom
810 LOCATE  9,23:PRINT STRING$(10,223)                 ' upper 
820 LOCATE  6,27:PRINT STRING$(11,220)                 ' back
830 LOCATE 8,23 :PRINT A$:LOCATE 7,25:PRINT A$         ' left    /
840 LOCATE 8,34 :PRINT A$:LOCATE 7,36:PRINT CHR$(220)  ' right   /
850 LOCATE 12,34:PRINT CHR$(223):LOCATE 11,35:PRINT A$ ' right bottom /
860 FOR G=9 TO 12:LOCATE G,22:PRINT CHR$(219):NEXT     ' left  |
870 FOR G=9 TO 12:LOCATE G,33:PRINT CHR$(219):NEXT     ' right |
880 FOR G=7 TO 10:LOCATE G,37:PRINT CHR$(219):NEXT     ' back  |
890 RETURN
900 ' check for win, loss
910 L=-(RT=31)+(RT>31):RETURN
920 ' ask for another game
930 LOCATE 15,28:INPUT "Again";F$:IF F$<>"n" THEN 300 ELSE 1310
940 ' rotate cube
950 IF A(2)=C THEN G=A(2):A(2)=A(6):A(6)=A(5):A(5)=A(1):A(1)=G
960 IF A(5)=C THEN G=A(5):A(5)=A(6):A(6)=A(2):A(2)=A(1):A(1)=G
970 IF A(3)=C THEN G=A(3):A(3)=A(6):A(6)=A(4):A(4)=A(1):A(1)=G
980 IF A(4)=C THEN G=A(4):A(4)=A(6):A(6)=A(3):A(3)=A(1):A(1)=G
990 ' display die's value
1000 COLOR 15,0
1010 LOCATE 8,29 :PRINT A(1)
1020 LOCATE 11,28:PRINT A(2)
1030 LOCATE 10,34:PRINT A(3)
1040 LOCATE 11,19:PRINT A(4)
1050 LOCATE 9,39 :PRINT A(5)
1060 LOCATE 13,28:PRINT A(6)
1070 COLOR 7,0:RETURN
1080 CLS:GOSUB 800
1090 LOCATE 10,27:PRINT "DICE":LOCATE 11,27:PRINT "GAME"
1100 LOCATE 12,38:PRINT "TRS80   code by David Lewis"
1110 LOCATE 13,38:PRINT "GWBASIC code by Eric Tchong"
1120 GOSUB 1210:GOSUB 1210:T=11
1130 CLS:LOCATE 2,6:COLOR 15,0
1140 FOR I=1 TO 11
1150  GOSUB 140:IF I=1 OR I=5 OR I=8 OR I=10 THEN COLOR T,0:T=T+1:PRINT
1160 NEXT:COLOR 7,0
1170 GOSUB 130:RETURN
1180 ' delay .0625, 1, or 2 seconds
1190 W=.0625:GOTO 1230
1200 W=.5   :GOTO 1230
1210 W=1    :GOTO 1230
1220 W=2
1230 DELAY=W:START=TIMER:WHILE TIMER<START+DELAY:WEND:RETURN
1240 ' get key
1250 LSET Q=MKI$(0)
1260 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND
1270 IF ASC(Q)=27 THEN CLS:GOTO 1320 ELSE RETURN
1280 ' print in the center
1290 X=(80-LEN(M(I)))/2
1300 PRINT TAB(X) M(I):RETURN
1310 LOCATE 15,28:PRINT "So long."
1320 COLOR 7,0:KEY 5,"dicegame.bas":KEY 6,CHR$(34)+",a":KEY ON
1330 ' Dicegame by David Lewis, Box 88, Shady, NY 12479
1340 ' Converted to GWBASIC by Eric Tchong - May 7, 1990
