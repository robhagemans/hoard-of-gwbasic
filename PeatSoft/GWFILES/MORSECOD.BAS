10 KEY OFF:CLS
20 SCREEN 0
30 WIDTH 40
40 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
50 PRINT"∞⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø∞"
60 PRINT"∞≥                                   ≥∞"
70 PRINT"∞≥            5017-A.BAS             ≥∞"
80 PRINT"∞≥            MORSE CODE             ≥∞"
90 PRINT"∞≥                                   ≥∞"
100 PRINT"∞≥                                   ≥∞"
110 PRINT"∞≥ BROUGHT TO YOU BY THE MEMBERS OF  ≥∞"
120 PRINT"∞≥      ‹‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹‹      ≥∞"
130 PRINT"∞≥        €   €   € €     €   €      ≥∞"
140 PRINT"∞≥        €   €‹‹‹€ €     €   €      ≥∞"
150 PRINT"∞≥        €   €     €     €   €      ≥∞"
160 PRINT"∞≥      ‹‹€‹‹ €     €‹‹‹‹ €‹‹‹€      ≥∞"
170 PRINT"∞≥                                   ≥∞"
180 PRINT"∞≥      International PC Owners      ≥∞"
190 PRINT"∞≥                                   ≥∞"
200 PRINT"∞≥P.O. Box 10426, Pittsburgh PA 15234≥∞"
210 PRINT"∞≥                                   ≥∞"
220 PRINT"∞¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ∞"
230 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
240 PRINT
250 PRINT "       PRESS ANY KEY TO CONTINUE
260 A$=INKEY$: IF A$="" THEN 260
270 WIDTH 80
280 CLS
1000 RANDOMIZE VAL(RIGHT$(TIME$,2))
1010 COLOR 7,0,0
1020 KEY OFF:COLOR 7,0,0:CLS:SCREEN 0,1
1030 COLOR 9,0,0:PRINT CHR$(213)+STRING$(37,205)+CHR$(184);
1040 FOR X=2 TO 23:LOCATE X,1:PRINT STRING$(1,179):LOCATE X,39:PRINT STRING$(1,179);:NEXT X:PRINT CHR$(212)+STRING$(37,205)+CHR$(190);
1050 LOCATE 3,15:COLOR 15:PRINT "MORSE CODE"
1060 LOCATE 22,8:COLOR 17:PRINT "PRESS ANY KEY TO CONTINUE"
1070 COLOR 4:LOCATE 9,9:PRINT CHR$(213)+STRING$(20,205)+CHR$(184):FOR X=10 TO 15:LOCATE X,9:PRINT STRING$(1,179):LOCATE X,30:PRINT STRING$ (1,179):NEXT X:LOCATE 15,9:PRINT CHR$(212)+STRING$(20,205)+CHR$(190)
1080 COLOR 9:LOCATE 11,15:PRINT "Practice":LOCATE 13,15 :PRINT "and Drill"
1090 Q$=INKEY$:IF Q$="" THEN 1090 ELSE 1100
1100 KEY OFF:CLS:COLOR 0,7
1110 CLS:COLOR ,,15:RANDOMIZE(T)
1120 INPUT "Enter  diffculty    (1-10)";O:PRINT
1130 INPUT "(1) Learning   (2) Testing";W:PRINT CHR$(7):CLS
1140 DIM A$(26), B$(26) ,HH(24)
1150 DATA .-,-...,-.-.,-..,.,..-.,--.,....,..,.---,-.-,.-..,--,-.,---,.--.,--.-,.-.,...,-,..-,...-,.--,-..-,-.--,--..
1160 FOR Z=1 TO 26:READ B$(Z):NEXT Z
1170 F=FIX(RND*17+4+.9999):IF W<>1 THEN COLOR ,,4:LOCATE 10,17:PRINT "TESTING"
1180 FOR Z=1 TO F
1190 H=FIX(RND*10+.9999):HH(Z)=H:IF W=1 THEN PRINT B$(H),CHR$(H+64)
1200 L=LEN (B$(H))
1210 FOR N=1 TO O*100+100:NEXT N
1220 FOR Y=1 TO L
1230 IF MID$(B$(H),Y,1)="-" THEN D=6 ELSE D=2
1240 SOUND 350,D:FOR G=1 TO D*O*25+100:NEXT G
1250 NEXT Y,Z:IF W=1 THEN 1270
1260 CLS:COLOR ,,15:FOR X=1 TO F:PRINT CHR$(HH(X)+64),B$(HH(X)):NEXT X
1270 LOCATE 24,1:INPUT "PRESS ENTER TO RUN";D$:PRINT CHR$(7):CLS
1280 FOR X= 1 TO 900:NEXT:GOTO 1170
)+64),B$(HH(X)):NEXT X
1270 LOCATE 24,1:INPUT "PRESS ENTER TO RUN";D$:PRINT CHR$(7):CLS
1280 FOR X= 1 TO 900:NEXT:GOTO