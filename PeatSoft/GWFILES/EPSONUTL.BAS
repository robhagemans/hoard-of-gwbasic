10 KEY OFF:CLS
20 SCREEN 0
30 WIDTH 40
40 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
50 PRINT"∞⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø∞"
60 PRINT"∞≥                                   ≥∞"
70 PRINT"∞≥            7037-A.BAS             ≥∞"
80 PRINT"∞≥      EPSON PRINTER OPTIONS        ≥∞"
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
1000 CLS
1010 PRINT"IBM/EPSON PRINTER OPTION MENU"
1020 PRINT:PRINT"Choose from the following options:"
1030 PRINT
1040 PRINT"0)END PROGRAM
1050 PRINT"1)REGULAR CHARACTERS(default)
1060 PRINT"2)COMPRESSED CHARACTERS
1070 PRINT"3)REGULAR MODE(default)
1080 PRINT"4)EMPHASIZED MODE-REGULAR CHARACTERS ONLY"
1090 PRINT"5)DOUBLE-STRIKE MODE"
1100 PRINT"6)EMPHASIZED DOUBLE-STRIKE MODE"
1110 PRINT"7)NORMAL LINE SPACING (DEFAULT)"
1120 PRINT"8)COMPRESSED LINE SPACING"
1130 PRINT"9)SILENCE PAPER-OUT BUZZER"
1140 PRINT
1150 INPUT"WHICH OPTION DO YOU WISH?";ANS
1160 IF ANS<0 OR ANS>9 THEN BEEP:GOTO 1150
1170 IF ANS=0 THEN 1310
1180 ON ANS GOSUB 1220,1230,1240,1250,1260,1270,1280,1290,1300
1190 PRINT"DONE..."
1200 FOR DELAY=1 TO 1000:NEXT
1210 GOTO 1000
1220 LPRINT CHR$(18);:RETURN
1230 LPRINT CHR$(15);:RETURN
1240 LPRINT CHR$(27);"F";CHR$(27);"H";:RETURN
1250 LPRINT CHR$(27);"E";:RETURN
1260 LPRINT CHR$(27);"G";:RETURN
1270 LPRINT CHR$(27);"E";CHR$(27);"G";:RETURN
1280 LPRINT CHR$(27);"2";:RETURN
1290 LPRINT CHR$(27);"0";:RETURN
1300 LPRINT CHR$(27);"8";:RETURN
1310 END
);"G";: