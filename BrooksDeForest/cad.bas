1 DIM N(2000):DIM X(2000):DIM Y(2000)
5 KEY OFF
10 FOR P=0 TO 15:PALETTE P,P:NEXT
11 P=0
14 SCREEN 0
15 COLOR 3,0,0:SCREEN 2:SCREEN 0:CLS:CLS
20 FOR C=0 TO 15
25 COLOR C
30 PRINT CHR$(177)CHR$(177);
35 NEXT
36 C=0
40 LOCATE 1,1:PRINT CHR$(176)CHR$(176)
45 LOCATE 1,35:PRINT "Palette for screen mode 0"
50 COLOR 3
55 LOCATE 3,70:PRINT "text"
60 LOCATE 4,70:PRINT "color"
65 LOCATE 5,70:PRINT "graphic"
70 LOCATE 6,70:PRINT "store"
75 LOCATE 7,70:PRINT "load"
80 LOCATE 8,70:PRINT "save"
85 LOCATE 9,70:PRINT "run"
86 LOCATE 15,70:PRINT "toggle"
87 LOCATE 16,70:PRINT "norm"
88 LOCATE 17,70:PRINT "reverse"
89 LOCATE 18,70:PRINT "turn"
90 LOCATE 10,70:PRINT "wipe"
91 LOCATE 11,70:PRINT "clean"
92 LOCATE 12,70:PRINT "mono"
93 LOCATE 13,70:PRINT "rgb"
94 LOCATE 14,70:PRINT "ink"
95 LOCATE 23,1:PRINT "Graphic control - - ";
100 IF C=0 THEN C=178
105 COLOR 2:PRINT CHR$(C)CHR$(C)"  "
110 COLOR 3
115 LOCATE 23,30:PRINT "Color on brush - - ";
120 IF P=0 THEN P=1
125 COLOR P:PRINT CHR$(177)CHR$(177)"  ";
130 LOCATE 3,1
131 X=1:Y=3
135 A$=INKEY$
145 IF A$="8" AND Y>2 THEN Y=Y-1
150 IF A$="2" AND Y<22 THEN Y=Y+1
155 IF A$="4" AND X>1 THEN X=X-1
160 IF A$="6" AND X<65 THEN X=X+1
165 IF A$=" " THEN C2=C
170 IF A$="C" THEN 500
175 A=SCREEN(Y,X):B=SCREEN(Y,X,1)
180 COLOR 7:LOCATE Y,X:PRINT CHR$(177)
185 COLOR B:LOCATE Y,X:PRINT CHR$(A)
190 IF C2<>0 THEN C2=0:COLOR P:LOCATE Y,X:PRINT CHR$(C)
191 IF ZX=1 THEN COLOR P:LOCATE Y,X:PRINT CHR$(C)
195 GOTO 135
500 LOCATE 23,1:PRINT "                                                                              "
505 LOCATE 23,1:INPUT "ENTER CONTROL CODE...",C$
506 IF I=0 THEN I=7
510 IF C$="TEXT" THEN COLOR I:LOCATE Y,X:INPUT "",O$
515 IF C$="COLOR" THEN LOCATE 23,1:PRINT "                                                                               ":LOCATE 23,1:INPUT "NEW COLOR (0-15)...",P
520 IF C$="GRAPHIC" THEN LOCATE 23,1:PRINT "                                                                               ":GOTO 900
525 IF C$="SAVE" THEN LOCATE 23,1:PRINT "                                                                         ":LOCATE 23,1:INPUT "FILENAME...",F$:OPEN "O",#1,F$:FOR Y=2 TO 22:FOR X=1 TO 65:A=SCREEN(Y,X):B=SCREEN(Y,X,1):WRITE #1,A,B:NEXT:NEXT:CLOSE
530 IF C$="LOAD" THEN LOCATE 23,1:PRINT "                                                                         ":LOCATE 23,1:INPUT "FILENAME...",F$:OPEN "I",#1,F$:FOR Y=2 TO 22:FOR X=1 TO 65:INPUT #1,A,B:COLOR B:LOCATE Y,X:PRINT CHR$(A):NEXT:NEXT:CLOSE
535 IF C$="WIPE" THEN C=32
540 IF C$="STORE" THEN LOCATE 23,1:PRINT "                                                                             ":GOTO 800
545 IF C$="RUN" THEN LOCATE 23,1:PRINT "                                                                           ":GOTO 700
546 IF C$="TURN" THEN LOCATE 23,1:PRINT "                                                                            ":GOTO 1000
550 IF C$="CLEAN" THEN LOCATE 23,1:PRINT "                                                                        ":FOR Y=2 TO 22:LOCATE Y,1:PRINT STRING$(66,32):NEXT
555 IF C$="MONO" THEN LOCATE 23,1:PRINT "                                                                             ":GOTO 601
560 IF C$="RGB" THEN LOCATE 23,1:PRINT "Please wait-RGB palette being installed.":FOR P=0 TO 15:PALETTE P,P:NEXT
565 IF C$="INK" THEN LOCATE 23,1:PRINT "                                                                          ":LOCATE 23,1:INPUT "Text ink (1-15)...",I
570 IF C$="TOGGLE" THEN LOCATE 23,1:PRINT "                                                                       ":LOCATE 23,1:PRINT "Graphics now set to toggle.":ZX=1:FOR W=1 TO 1000:NEXT
575 IF C$="NORM" THEN LOCATE 23,1:PRINT "                                                                              ":LOCATE 23,1:PRINT "Graphics are now back to normal mode.":FOR W=1 TO 1000:NEXT:ZX=0
580 IF C$="REVERSE" THEN LOCATE 23,1:PRINT "                                                                           ":LOCATE 23,1:PRINT "Reversing graphics-please wait...":P3=0:FOR P2=15 TO 1 STEP -1:P3=P3+1:PALETTE P2,P3:NEXT
600 LOCATE 23,1:PRINT "                                                                               ":COLOR 3:GOTO 95
601 LOCATE 23,1:PRINT "C.G.A graphics taking place..please wait."
605 RESTORE 650
610 FOR P2=0 TO 15
615 READ P3
620 PALETTE P2,P3
625 NEXT
630 GOTO 600
650 DATA 0,3,5,15,0,3,5,15,0,3,5,15,0,3,5,15,0,3,5,15,0,3,5,15,0
700 LOCATE 23,1:PRINT "PLEASE WAIT....."
705 N=0
710 FOR Y=2 TO 22:FOR X=1 TO 65
715 N=N+1:A=X(N):B=Y(N)
716 IF A<33 THEN 725
720 COLOR B:LOCATE Y,X:PRINT CHR$(A)
725 NEXT:NEXT
730 GOTO 600
800 LOCATE 23,1:PRINT "LAST SCREEN STORED AT LOCATION "N"."
801 N=0
805 FOR Y=2 TO 22
810 FOR X=1 TO 65
815 A=SCREEN(Y,X)
820 B=SCREEN(Y,X,1)
825 N=N+1:X(N)=A:Y(N)=B
830 NEXT:NEXT
835 GOTO 600
900 C2=177
905 LOCATE 23,1:PRINT CHR$(C2-1)" --"CHR$(C2)"-- "CHR$(C2+1)
910 A$=INKEY$
915 IF A$="=" AND C2<254 THEN C2=C2+1
920 IF A$="-" AND C2>33 THEN C2=C2-1
925 IF A$="P" THEN C=C2:C2=0:GOTO 600
930 IF A$="Q" THEN C2=0:GOTO 600
935 GOTO 905
1000 LOCATE 23,1:PRINT "Please wait....."
1005 FOR Y=2 TO 22:FOR X=1 TO 65
1010 A=SCREEN(Y,X):B=SCREEN(Y,X,1)
1015 IF A=177 THEN A=176:GOTO 1025
1020 IF A=176 THEN A=177:GOTO 1025 ELSE 1030
1025 COLOR B:LOCATE Y,X:PRINT CHR$(A)
1030 NEXT:NEXT:GOTO 600
