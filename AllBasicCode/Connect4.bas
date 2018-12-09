1 'Name: Connect Four in a Row
2 'Author: Richard Kelly (Newson@37.com)
3 'Category: Games or Demos
4 'Date released: 07/14/01
5 '
6 'This is a text-based version of the old "Connect 4" game.  The computer is
7 'programmed to play against you, but the algorithm has many problems with
8 'it:  The computer doesn't "look ahead" far enough, sometimes it doesn't
9 'notice areas that are one move away from a diagonal win, and so on.
10 'I've re-done the algorithm from scratch twice already and it *still*
11 'doesn't work right, and it has a long way to go before it ever will.  I've
12 'gotten burned out on this project and I'm releasing it to the Public
13 'Domain for anyone else out there who wants to mess around with it.  Just
14 'so you know:  Z$ has each column labeled with a "priority number", so a
15 'column with a "1" will be played before a column with "2", ect..  Also,
16 'I expect that the algorithm will have to be re-written *again* in order to
17 'work right.  Sorry about that, and my apologies also for the lack of
18 'documentation.
19 '
20 'This runs on GW-BASIC, QB v1.1-v7.0, PowerBASIC, and FirstBASIC.
100 DIM A$(6), B$(0), M$(0): GOTO 660
109 'Has someone won?
110 WR = 0: WI = 0: O0 = 0: O1 = 0: O2 = 0: O3 = 0: FOR Y = 1 TO 3: FOR X = 1 TO 4: A$ = A$(Y): B$ = A$(Y + 1): C$ = A$(Y + 2): D$ = A$(Y + 3): WI = 1: IF MID$(A$, X, 4) = "1111" AND WR = 0 THEN WR = 1: GOSUB 1970
120 IF MID$(A$, X, 4) = "2222" AND WR = 0 THEN WR = 2: GOSUB 1970
130 WI = 2: IF MID$(A$, X, 1) + MID$(B$, X, 1) + MID$(C$, X, 1) + MID$(D$, X, 1) = "1111" AND WR = 0 THEN WR = 1: GOSUB 1970
140 IF MID$(A$, X, 1) + MID$(B$, X, 1) + MID$(C$, X, 1) + MID$(D$, X, 1) = "2222" AND WR = 0 THEN WR = 2: GOSUB 1970
150 WI = 3: IF MID$(D$, X, 1) + MID$(C$, X + 1, 1) + MID$(B$, X + 2, 1) + MID$(A$, X + 3, 1) = "1111" AND WR = 0 THEN WR = 1: GOSUB 1970
160 IF MID$(D$, X, 1) + MID$(C$, X + 1, 1) + MID$(B$, X + 2, 1) + MID$(A$, X + 3, 1) = "2222" AND WR = 0 THEN WR = 2: GOSUB 1970
170 WI = 4: IF MID$(A$, X, 1) + MID$(B$, X + 1, 1) + MID$(C$, X + 2, 1) + MID$(D$, X + 3, 1) = "1111" AND WR = 0 THEN WR = 1: GOSUB 1970
180 IF MID$(A$, X, 1) + MID$(B$, X + 1, 1) + MID$(C$, X + 2, 1) + MID$(D$, X + 3, 1) = "2222" AND WR = 0 THEN WR = 2: GOSUB 1970
190 NEXT X, Y: WI = 1: FOR Y = 4 TO 6: FOR X = 1 TO 4: IF MID$(A$(Y), X, 4) = "1111" AND WR = 0 THEN WR = 1: GOSUB 1970
200 IF MID$(A$(Y), X, 4) = "2222" AND WR = 0 THEN WR = 2: GOSUB 1970
210 NEXT X, Y: WI = 2
220 FOR Y = 1 TO 3: FOR X = 4 TO 7: R$ = MID$(A$(Y), X, 1) + MID$(A$(Y + 1), X, 1) + MID$(A$(Y + 2), X, 1) + MID$(A$(Y + 3), X, 1): IF R$ = "1111" AND WR = 0 THEN WR = 1: GOSUB 1970
230 IF R$ = "2222" AND WR = 0 THEN WR = 2: GOSUB 1970
240 NEXT X, Y: X = 0: Y = 0: WR = 0: WI = 0: RETURN
249 'The computer's turn.
250 COLOR 7, 0: LOCATE 20, 1: PRINT "This is the computer's move.     "
260 A = 0: IF MID$(A$(6), 4, 1) = " " THEN A = 4: GOTO 610
270 Z$ = "       ": FOR X = 1 TO 7: IF MID$(A$(1), X, 1) > " " THEN Y$ = "0": GOSUB 630: GOTO 520
278 'The computer looks for a winning move or a place where the player is
279 '    about win (marked as "1" for Y$).
280 OT = 0: FOR Y = 6 TO 1 STEP -1: IF MID$(A$(Y), X, 1) = " " AND OT = 0 THEN OT = Y
290 NEXT Y: Y = OT: Y$ = " ": A = X: IF Y > 3 THEN 320
300 A$ = MID$(A$(Y + 1), X, 1) + MID$(A$(Y + 2), X, 1) + MID$(A$(Y + 3), X, 1): IF A$ = "222" THEN 610
310 IF A$ = "111" THEN Y$ = "1": GOSUB 630
320 IF X > 4 THEN 350
330 A$ = MID$(A$(Y), X + 1, 3): IF A$ = "222" THEN 610
340 IF A$ = "111" THEN Y$ = "1": GOSUB 630
350 IF X < 4 THEN 380
360 A$ = MID$(A$(Y), X - 3, 3): IF A$ = "222" THEN 610
370 IF A$ = "111" THEN Y$ = "1": GOSUB 630
380 IF X = 1 OR X > 5 THEN 410
390 A$ = MID$(A$(Y), X - 1, 4): IF A$ = "2 22" THEN 610
400 IF A$ = "1 11" THEN Y$ = "1": GOSUB 630
410 IF X < 3 OR X = 7 THEN 440
420 A$ = MID$(A$(Y), X - 2, 4): IF A$ = "22 2" THEN 610
430 IF A$ = "11 1" THEN Y$ = "1": GOSUB 630
440 IF X < 4 THEN 510
450 IF Y < 4 THEN 490
460 A$ = MID$(A$(Y - 3), X - 3, 1) + MID$(A$(Y - 2), X - 2, 1) + MID$(A$(Y - 1), X - 1, 1): IF A$ = "222" THEN 610
470 IF A$ = "111" THEN Y$ = "1": GOSUB 630
480 IF Y > 3 THEN 510
490 A$ = MID$(A$(Y + 3), X - 3, 1) + MID$(A$(Y + 2), X - 2, 1) + MID$(A$(Y + 1), X - 1, 1): IF A$ = "222" THEN 610
500 IF A$ = "111" THEN Y$ = "1": GOSUB 630
509 'The routine continues on Line 1180.
510 GOTO 1180
519 'Sum up the computer player's decisions.  Now what are his options?
520 NEXT X: GOSUB 1980: A = INSTR(Z$, "1"): IF A > 0 THEN 610 ELSE 540
530 A = INT(RND * 7 + 1): IF MID$(Z$, A, 1) <> " " THEN 530 ELSE 610
538 'I'm pretty sure I never programmed in the routine that gave Y$ the values
539 '    "6" and "5", since the new algorithm never worked right.
540 A = INSTR(Z$, "6"): IF A > 0 THEN 610
550 A = INSTR(Z$, "5"): IF A > 0 THEN 610
560 A = INSTR(Z$, "4"): IF A > 0 THEN 610
570 A = INSTR(Z$, " "): IF A > 0 THEN 530
580 A = INSTR(Z$, "2"): IF A > 0 THEN 610
590 A = INSTR(Z$, "3"): IF A > 0 THEN 610
600 A = INT(RND * 7 + 1): IF MID$(A$(1), A, 1) <> " " THEN 600
610 'LOCATE 20,1:PRINT STRING$(38,32);
620 RETURN
630 Z$ = LEFT$(Z$, X - 1) + Y$ + RIGHT$(Z$, 7 - X): RETURN
640 LOCATE 18, LO + 1: PRINT "             ": RETURN
650 LOCATE 21, 1: PRINT STRING$(150, 32); : LOCATE 18, LO + 1: PRINT "1 2 3 4 5 6 7": RETURN
659 'This seems to be where the title screen is.
660 SCREEN 0, 0: WIDTH 40: COLOR 7, 0: LOCATE 1, 1, 0: CLS : M0$ = CHR$(218): FOR T = 1 TO 6: M0$ = M0$ + CHR$(196) + CHR$(194): NEXT: M0$ = M0$ + CHR$(196) + CHR$(191)
670 RANDOMIZE TIMER: M2$ = "": FOR T = 1 TO 7: M1$ = M1$ + CHR$(179) + CHR$(219): NEXT: M1$ = M1$ + CHR$(179): PLAY "MLT150L24"
680 M2$ = CHR$(195): FOR T = 1 TO 6: M2$ = M2$ + CHR$(196) + CHR$(197): NEXT: M2$ = M2$ + CHR$(196) + CHR$(180)
690 M3$ = CHR$(192): FOR T = 1 TO 6: M3$ = M3$ + CHR$(196) + CHR$(193): NEXT: M3$ = M3$ + CHR$(196) + CHR$(217)
700 LI = 12: GOSUB 1960: LO = 13: LOCATE 5, 1: PRINT "1 or 2 players?"
710 A$ = INKEY$: IF A$ = "1" THEN P3 = 1: GOTO 740
720 IF A$ = "2" THEN P3 = 2: GOTO 740
730 GOTO 710
740 LOCATE 5, 1: PRINT "Player 1, do you want to go first?"
750 A$ = INKEY$: IF A$ = "Y" OR A$ = "y" THEN PO = 0: GOTO 780
760 IF A$ = "N" OR A$ = "n" THEN PO = 1: GOTO 780
770 GOTO 750
780 LOCATE 5, 1: PRINT STRING$(40, 32);
790 P1 = 0: P2 = 0
800 GOSUB 1940: PR = PO: COLOR 0, 14: LOCATE 5, LO: PRINT M0$; : FOR T = 2 TO 10 STEP 2: LOCATE T + 4, LO: PRINT M1$; : LOCATE T + 5, LO: PRINT M2$; : NEXT: LOCATE 16, LO: PRINT M1$; : LOCATE 17, LO: PRINT M3$; : FOR T = 1 TO 6: A$(T) = STRING$(7, 32): NEXT: COLOR 7, 0
810 LOCATE 19, 1: PRINT "Player 1  ": LOCATE 20, 1: PRINT "Score:"; P1: LOCATE 19, 20: PRINT "Player 2  ": LOCATE 20, 20: PRINT "Score:"; P2
820 LOCATE 22, 1: PRINT "Press [SPACE] to play, [RETURN] to reset  score,  [HOME] to reset options, and              [ESC] to quit.";
830 A$ = INKEY$: IF A$ = CHR$(0) + "G" THEN RUN
840 IF A$ = CHR$(13) THEN P1 = 0: P2 = 0: GOTO 810
850 IF A$ = CHR$(27) THEN 1950
860 IF A$ = " " THEN GOSUB 650: GOTO 880
870 GOTO 830
880 PR = PR + 1: IF PR > 2 THEN PR = 1
890 GOSUB 1140: LOCATE 18, LO + 1: IF PR = 2 AND P3 = 1 THEN GOSUB 250: GOTO 930
900 LOCATE 20, 1: PRINT "Press a number to make your move."
910 GOSUB 1940: GOTO 1900
920 A = VAL(A$): IF MID$(A$(1), A, 1) <> " " THEN 1900
930 X = A: Y = 0: GOSUB 1160: A1 = AX: A2 = AY: IF PR = 1 THEN COLOR 4, 0 ELSE COLOR 1, 0
940 GOTO 960
949 'Drop the "checker".
950 LOCATE A2, A1: PRINT CHR$(220); : PLAY "N0": LOCATE A2, A1: PRINT " "; : PLAY "N0"
960 LOCATE AY, AX: PRINT CHR$(223); : PLAY "N0": LOCATE AY, AX: PRINT CHR$(219);
970 A1 = AX: A2 = AY: IF Y < 6 THEN IF MID$(A$(Y + 1), X, 1) = " " THEN AY = AY + 2: Y = Y + 1: PLAY "N0": GOTO 950
980 COLOR 7, 0: IF PR = 1 THEN MID$(A$(Y), X, 1) = "1" ELSE MID$(A$(Y), X, 1) = "2"
990 GOSUB 110: IF O0 > 0 THEN 1030
1000 IF INSTR(A$(1), " ") > 0 THEN 880
1009 'Tie game!
1010 LOCATE 20, 1: PRINT "The board is full, so the game is a tie.": PRINT : PRINT "Press any key to continue.": WHILE INKEY$ = "": WEND
1020 GOTO 1130
1029 'Someone won.
1030 X = O0: Y = O1: WI = O2: WR = O3: GOSUB 640: IF WR = 1 THEN P1 = P1 + 1: COLOR 16, 4 ELSE P2 = P2 + 1: COLOR 16, 1
1040 GOSUB 1160: ON WI GOTO 1050, 1070, 1110, 1090
1048 'The "blinking row" is drawn in COLOR 16 so it doesn't have to be updated
1049 'continuously.
1050 FOR T = 0 TO 6 STEP 2: LOCATE AY, AX + T: PRINT CHR$(219); : NEXT
1060 GOTO 1120
1070 FOR Y = 0 TO 6 STEP 2: LOCATE AY + Y, AX: PRINT CHR$(219); : NEXT
1080 GOTO 1120
1090 FOR T = 0 TO 6 STEP 2: LOCATE AY + T, AX + T: PRINT CHR$(219); : NEXT
1100 GOTO 1120
1110 FOR T = 0 TO 6 STEP 2: LOCATE AY + 6 - T, AX + T: PRINT CHR$(219); : NEXT
1120 COLOR 7, 0: LOCATE 20, 1: PRINT "Player"; WR; "wins the game.          ": LOCATE 22, 1: PRINT "Press any key to continue.": GOSUB 1940: WHILE INKEY$ = "": WEND
1130 LOCATE 20, 1: PRINT STRING$(78, 32); : GOTO 800
1140 COLOR 23, 0: IF PR = 1 THEN LOCATE 19, 10: PRINT CHR$(17); : LOCATE 19, 29: PRINT " "; : COLOR 7, 0: RETURN
1150 LOCATE 19, 10: PRINT " "; : LOCATE 19, 29: PRINT CHR$(17); : COLOR 7, 0: RETURN
1160 AY = (Y * 2) + 4: AX = (X * 2) + LO - 1: RETURN
1170 GOSUB 1960: GOTO 800
1180 IF X > 4 THEN 1250
1190 IF Y < 4 THEN 1230
1200 A$ = MID$(A$(Y - 3), X + 3, 1) + MID$(A$(Y - 2), X + 2, 1) + MID$(A$(Y - 1), X + 1, 1): IF A$ = "222" THEN 610
1210 IF A$ = "111" THEN Y$ = "1": GOSUB 630
1220 IF Y > 3 THEN 1250
1230 A$ = MID$(A$(Y + 3), X + 3, 1) + MID$(A$(Y + 2), X + 2, 1) + MID$(A$(Y + 1), X + 1, 1): IF A$ = "222" THEN 610
1240 IF A$ = "111" THEN Y$ = "1": GOSUB 630
1250 IF X = 1 OR X > 5 THEN 1320
1260 IF Y < 3 OR Y = 6 THEN 1290
1270 A$ = MID$(A$(Y + 1), X - 1, 1) + MID$(A$(Y - 1), X + 1, 1) + MID$(A$(Y - 2), X + 2, 1): IF A$ = "222" THEN 610
1280 IF A$ = "111" THEN Y$ = "1": GOSUB 630
1290 IF Y = 1 OR Y > 4 THEN 1320
1300 A$ = MID$(A$(Y - 1), X - 1, 1) + MID$(A$(Y + 1), X + 1, 1) + MID$(A$(Y + 2), X + 2, 1): IF A$ = "222" THEN 610
1310 IF A$ = "111" THEN Y$ = "1": GOSUB 630
1320 IF X < 3 OR X = 7 THEN 1390
1330 IF Y = 1 OR Y > 4 THEN 1360
1340 A$ = MID$(A$(Y + 2), X - 2, 1) + MID$(A$(Y + 1), X - 1, 1) + MID$(A$(Y - 1), X + 1, 1): IF A$ = "222" THEN 610
1350 IF A$ = "111" THEN Y$ = "1": GOSUB 630
1360 IF Y < 3 OR Y = 6 THEN 1390
1370 A$ = MID$(A$(Y - 2), X - 2, 1) + MID$(A$(Y - 1), X - 1, 1) + MID$(A$(Y + 1), X + 1, 1): IF A$ = "222" THEN 610
1380 IF A$ = "111" THEN Y$ = "1": GOSUB 630
1390 IF X < 3 OR X > 5 THEN 1440
1398 'Check to see if a win is possible by having an "open-ended" three-in-a-
1399 'row.  Marked as "4" in Y$.
1400 A$ = MID$(A$(Y), X - 2, 5): IF (A$ = " 2 2 " OR A$ = " 1 1 ") AND Y$ = " " THEN Y$ = "4": GOSUB 630
1410 IF Y < 3 OR Y > 4 THEN 1440
1420 A$ = MID$(A$(Y + 2), X - 2, 1) + MID$(A$(Y + 1), X - 1, 1) + MID$(A$(Y - 1), X + 1, 1) + MID$(A$(Y - 2), X + 2, 1): IF (A$ = " 22 " OR A$ = " 11 ") AND Y$ = " " THEN Y$ = "4": GOSUB 630
1430 A$ = MID$(A$(Y - 2), X - 2, 1) + MID$(A$(Y - 1), X - 1, 1) + MID$(A$(Y + 1), X + 1, 1) + MID$(A$(Y + 2), X + 2, 1): IF (A$ = " 22 " OR A$ = " 11 ") AND Y$ = " " THEN Y$ = "4": GOSUB 630
1440 IF Y = 1 THEN 1870
1450 Y = Y - 1: IF X < 4 THEN 1480
1458 'If a four-in-a-row is two moves away for the computer in this area, mark
1459 'Y$ as "2".  For the "enemy", mark it as a "3".
1460 A$ = MID$(A$(Y), X - 3, 3): IF A$ = "222" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1470 IF A$ = "111" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1480 IF X > 4 THEN 1510
1490 A$ = MID$(A$(Y), X + 1, 3): IF A$ = "222" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1500 IF A$ = "111" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1510 IF X = 1 OR X > 5 THEN 1540
1520 A$ = MID$(A$(Y), X - 1, 4): IF A$ = "2 22" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1530 IF A$ = "1 11" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1540 IF X < 3 OR X = 7 THEN 1570
1550 A$ = MID$(A$(Y), X - 2, 4): IF A$ = "22 2" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1560 IF A$ = "11 1" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1570 IF X < 4 THEN 1640
1580 IF Y < 4 THEN 1610
1590 A$ = MID$(A$(Y - 3), X - 3, 1) + MID$(A$(Y - 2), X - 2, 1) + MID$(A$(Y - 1), X - 1, 1): IF A$ = "222" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1600 IF A$ = "111" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1610 IF Y > 3 THEN 1640
1620 A$ = MID$(A$(Y + 3), X - 3, 1) + MID$(A$(Y + 2), X - 2, 1) + MID$(A$(Y + 1), X - 1, 1): IF A$ = "222" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1630 IF A$ = "111" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1640 IF X > 4 THEN 1710
1650 IF Y < 4 THEN 1680
1660 A$ = MID$(A$(Y - 3), X + 3, 1) + MID$(A$(Y - 2), X + 2, 1) + MID$(A$(Y - 1), X + 1, 1): IF A$ = "222" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1670 IF A$ = "111" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1680 IF Y > 3 THEN 1710
1690 A$ = MID$(A$(Y + 3), X + 3, 1) + MID$(A$(Y + 2), X + 2, 1) + MID$(A$(Y + 1), X + 1, 1): IF A$ = "222" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1700 IF A$ = "111" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1710 IF X = 1 OR X > 5 THEN 1780
1720 IF Y = 1 OR Y > 4 THEN 1750
1730 A$ = MID$(A$(Y - 1), X - 1, 1) + MID$(A$(Y + 1), X + 1, 1) + MID$(A$(Y + 2), X + 2, 1): IF A$ = "222" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1740 IF A$ = "111" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1750 IF Y < 3 OR Y = 6 THEN 1780
1760 A$ = MID$(A$(Y + 1), X - 1, 1) + MID$(A$(Y - 1), X + 1, 1) + MID$(A$(Y - 2), X + 2, 1): IF A$ = "222" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1770 IF A$ = "111" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1780 IF X < 3 OR X = 7 THEN 1850
1790 IF Y < 3 OR Y = 6 THEN 1820
1800 A$ = MID$(A$(Y - 2), X - 2, 1) + MID$(A$(Y - 1), X - 1, 1) + MID$(A$(Y + 1), X + 1, 1): IF A$ = "222" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1810 IF A$ = "111" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1820 IF Y = 1 OR Y > 4 THEN 1850
1830 A$ = MID$(A$(Y + 2), X - 2, 1) + MID$(A$(Y + 1), X - 1, 1) + MID$(A$(Y - 1), X + 1, 1): IF A$ = "222" AND (Y$ = " " OR Y$ = "4") THEN Y$ = "2": GOSUB 630
1840 IF A$ = "111" AND Y$ <> "1" THEN Y$ = "3": GOSUB 630
1850 Y = Y + 1: IF X > 4 THEN 1870
1860 A$ = MID$(A$(Y), X, 4): IF (A$ = " 22 " OR A$ = " 11 ") AND Y$ = " " THEN Y$ = "4": GOSUB 630
1870 GOTO 1890
1880 A$ = "": IF Y > 0 THEN A$ = A$(Y): RETURN ELSE RETURN
1890 GOTO 520
1900 A$ = INKEY$: IF A$ = CHR$(27) THEN LOCATE 20, 1: PRINT STRING$(38, 32); : GOTO 800
1910 IF A$ = CHR$(16) THEN IF P3 = 1 THEN P3 = 2 ELSE P3 = 1
1920 IF A$ < "1" OR A$ > "7" THEN 1900
1930 GOTO 920
1940 IF INKEY$ <> "" THEN 1940 ELSE RETURN
1950 WIDTH 80: CLEAR : END: RUN
1960 CLS : COLOR 7, 0: LOCATE 1, LI - 4: PRINT "Connect 4 in a Row ver. 0.8": LOCATE 3, LI + 1: PRINT "By Richard Kelly": RETURN
1970 O0 = X: O1 = Y: O2 = WI: O3 = WR: RETURN
1980 FOR X = 1 TO 7: IF MID$(Z$, X, 1) > " " AND MID$(Z$, X, 1) <> "4" AND MID$(Z$, X, 1) <> "2" THEN 2010
1990 OT = 0: FOR Y = 6 TO 1 STEP -1: IF MID$(A$(Y), X, 1) = " " AND OT = 0 THEN OT = Y
2000 NEXT Y: Y = OT: A = X
2010 NEXT X: RETURN
