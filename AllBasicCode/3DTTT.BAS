10  '********************************************
20  '*                                          *
30  '*           3D TIC-TAC-TOE                 *
40  '*                                          *
50  '*       (C) 1982 Reza Beheshti             *
60  '*                                          *
70  '*  3504 Pence Ct.                          *
80  '*  Annandale, VA.  22003                   *
90  '*  (703) 560-4821                          *
100 '*                                          *
110 '********************************************
120 '
130 ' System requirments:
140 '
150 ' IBM PC 64K MEM. Min.
160 ' 1 Disk drive
170 ' Color/Graphic Board
180 ' 80 Column monitor (RGB Recommanded)
190 ' Run under "BASICA"
200 '
210 ' ------ ENJOY IT -----
220 '
230 '
240 '
250 '
260 SCREEN 1,0:KEY OFF
270 ON ERROR GOTO 3720
280 CLS:RANDOMIZE 12
290 DEFINT A-Y:DEFDBL Z:DIM AA(3000),A(514),NAM$(11),LOS(11),WIN(11),SCR(11)
300 COLOR 0,0:Y=1:N=0:T=0:W=0:X=0:INSTFL=0:DIFFL=0:WELFL=0
310 IF DIFFL<> 0 THEN 700
320 DIFFL=1
330 GOSUB 3700
340 DRAW "c1bl90bu30r30f3d20g3f3d25g3l30"
350 DRAW "u5r24e3u21l25u5r25u20l27u3"
360 DRAW "br60bd30r40u4l40d4"
370 DRAW "bu4br60nu25d28r30e4u45h4l30"
380 DRAW "bu4r32f7d47g7l36u61r4"
390 DRAW "c2bl120bd2e15r25f3d32g3f3d19g9"
400 DRAW"u24h3e3u20h4l9"
410 DRAW "br59bd26e15r36d9g10u4l40" '- shade
420 DRAW "bu29br55e15r34f7d60g11l8e7u49h7l35" ' d shade
430 PAINT(110,100),2 '3 shade
440 PAINT(100,110),1 ' 3 itself
450 PAINT(150,99),1  '- itself
460 PAINT(150,82),2  ' - shade
470 PAINT(187,82),1 ' d shade
480 PAINT(230,70),2  ' d itself
490 LOCATE 22,12,0:PRINT" TIC - TAC - TOE"
500 Y1=5:Y2=Y1+32:FL=1:GOSUB 980
510 GET(65,45)-(250,133),AA
520 FOR I=1 TO 800:NEXT
530 GOSUB 3700
540 PUT (65,45),AA,XOR
550 XX=65:YY=65
560 FOR KI=1 TO 3
570 FOR K=1 TO 3
580 PUT (XX,YY),AA:XX=XX+15:YY=YY-15:NEXT K
590 FOR I=1 TO 700:NEXT
600 XX=XX-15:YY=YY+15
610 GOSUB 3700
620 FOR K=1 TO 2
630 PUT (XX,YY),AA,XOR:XX=XX-15:YY=YY+15:NEXT K
640 NEXT KI
650 DIFFL=1
660 GOSUB 3700
670 CLS:LOCATE 12,7,0:PRINT"WELCOM TO 3D TIC-TAC-TOE"
680 LOCATE 24,3,0:PRINT "(C) 1982  Reza Beheshti"
690 FOR I=1 TO 2500:NEXT I
700 FOR I=1 TO 514:A(I)=0:NEXT I
710 GOSUB 1310
720 SCREEN 1,0,0:CLS
730 GOSUB 790
740 REM do human's move
750 REM see if tie game though
760 YZ=YZ+1:IF (YZ=9)*(V=1)+(YZ=33)*(V>1) THEN 3260
770 GOSUB 1660
780 GOTO 1750
790 COLOR 1,0
800 Y1=10:Y2=Y1+32:FL=1
810 GOSUB 980
820 Y1=50:Y2=Y1+32:FL=1
830 GOSUB 980
840 Y1=90:Y2=Y1+32:FL=1
850 GOSUB 980
860 Y1=130:Y2=Y1+32:FL=1
870 GOSUB 980
880 LOCATE 1,22,0:PRINT"1   2   3   4"
890 LOCATE 2,18,0:PRINT"1"
900 LOCATE 3,16:PRINT"2"
910 LOCATE 4,14:PRINT"3"
920 LOCATE 5,12:PRINT"4"
930 LOCATE 3,37:PRINT"(1)"
940 LOCATE 8,37:PRINT"(2)"
950 LOCATE 13,37:PRINT"(3)"
960 LOCATE 18,37:PRINT"(4)"
970 RETURN
980 LINE (160,Y1)-(272,Y1)
990 LINE -(205,Y2)
1000 LINE -(95,Y2)
1010 LINE -(160,Y1)
1020 IF FL=1 THEN PAINT (161,Y1+1),2,3
1030 LINE (188,Y1)-(123,Y2),3
1040 LINE (216,Y1)-(151,Y2),3
1050 LINE (244,Y1)-(179,Y2),3
1060 LINE (143,Y1+8)-(255,Y1+8),3
1070 LINE (126,Y1+16)-(238,Y1+16)
1080 LINE (110,Y1+24)-(222,Y1+24)
1090 RETURN
1100 END
1110 ' display X or O subroutine
1120 ULX=160                    'upper left coord. of board
1130 ULY=(BORD-1)*40+10            '
1140 ULY=ULY+(ROW-1)*8            'upper left coord. of box
1150 ULX=ULX+(COL-1)*28-(ROW-1)*16  '
1160 IF FG=0 GOTO 1220
1170 IF FG=2 GOTO 1270
1180 ' print an X
1190 LINE (ULX,ULY)-(ULX+11,ULY+8),3   ' ul-lr line
1200 LINE (ULX-16,ULY+8)-(ULX+27,ULY),3 ' ll-ur line
1210 RETURN
1220 ' Print an ellipse
1230 FOR P=1 TO 15
1240 COLOR  ,0:CIRCLE (ULX+5,ULY+4),8,1,,,.36
1250 CIRCLE (ULX+5,ULY+4),8,0,,,.36:NEXT P
1260 RETURN
1270 ' print the winning marks on screnn
1280 GOSUB 3700
1290 COLOR ,1:CIRCLE (ULX+5,ULY+4),8,0,,,.2
1300 RETURN
1310 SCREEN 0,0,0:COLOR 0,4,0
1320 WIDTH 80:CLS
1330 LOCATE 3,15,0:PRINT"WELCOME TO ":COLOR 1 :LOCATE 3,28
1340 PRINT"T I C  -  T A C  -  T O E"
1350 IF INSTFL<>0 THEN 1540
1360 COLOR 2:INSTFL=1
1370 PRINT:PRINT TAB(5)"My name is ";:COLOR 1:PRINT"WIZY ";
1380 COLOR 2:PRINT"and I will be your opponent"
1390 PRINT:INPUT"What is your name";NA$
1400 LOCATE 7,5,0:PRINT:PRINT"Do you need instructions ";NA$
1410 INPUT K$:K$=LEFT$(K$,1)
1420 IF K$="y" OR K$="n" OR K$="Y" OR K$="N" THEN 1460
1430 BEEP:PRINT "Please answer with a YES or NO":FOR I=1 TO 950:NEXT
1440 FOR J=8 TO 10:LOCATE J,1,0:PRINT"                                      ":NEXT J
1450 GOTO 1400
1460 IF K$="n" OR K$="N" THEN 1540
1470 PRINT:PRINT TAB(3)"3-D TIC-TAC-TOE is played on four boards. You must get 4 in"
1480 PRINT TAB(3)"a row to win. (Horizonal, Vertical, or Diagonally)"
1490 PRINT TAB(3)"There are 4 rows and 4 columns on each board, you enter your choice of"
1500 PRINT TAB(3)"box by a three digit number indicating the row, column, and board number"
1510 PRINT TAB(3)" i.e. [231] is row 2, column 3, on board 1"
1520 PRINT TAB(3)"You will play the 'X' and I will take 'O' and I let you play first"
1530 INSTFL=1
1540 LOCATE 18,3,0:PRINT"There are 2 versions available as follows:"
1550 PRINT TAB(5)"1) Moderately hard to beat"
1560 PRINT TAB(5)"2) Hardest to beat"
1570 LOCATE 21,3,0:PRINT NA$;" Which one would you like";:INPUT V
1580 IF V>0 AND V<3 THEN 1620
1590 BEEP:PRINT"Please chose 1 or 2 only":FOR I=1 TO 999:NEXT
1600 FOR K=21 TO 24:LOCATE K,1:PRINT"                                    ":NEXT
1610 GOTO 1570
1620 LOCATE 25,3,0:PRINT"One moment.."
1630 GOSUB 3360
1640 V=V+1:LOCATE 25,2,0:PRINT"Hit [ENTER] to start";:BEEP:INPUT XXX
1650 SCREEN 1,0,0:RETURN
1660 REM Input query starts here.
1670 CODE=0:LOCATE 23,3,0:INPUT"Which box [RCB]";BOX$
1680 GOSUB 1790   ' to subroutine for valid input check
1690 IF CODE=1 THEN 1670
1700 GOSUB 1980
1710 IF A(D)<>0 THEN 3600
1720 A(D)=1:FG=1:GOSUB 1110
1730 LOCATE 23,1,0:PRINT" I'm thinking .......       ":FOR I=1 TO 1500:NEXT I
1740 RETURN
1750 REM evaluate all moves
1760 GOSUB 2620
1770 GOSUB 2090                  ' do computers move
1780 GOTO 750                    ' to -> see if tie game though
1790 ' Subroutine to check VALID input from the player.
1800 LN=LEN(BOX$):IF LN=3 THEN 1840
1810 BEEP:LOCATE 23,24,0:BEEP:PRINT"Bad Input":FOR I=1 TO 1500:NEXT
1820 LOCATE 23,15,0:PRINT"                    "
1830 CODE=1:RETURN
1840 R$=MID$(BOX$,1,1):ROW=VAL(R$)
1850 C$=MID$(BOX$,2,1):COL=VAL(C$)
1860 B$=MID$(BOX$,3,1):BORD=VAL(B$)
1870 RER$=" ":CER$=" ":BER$=" "
1880 IF ROW<1 OR ROW>4 THEN RER$=" ROW   "
1890 IF COL<1 OR COL>4 THEN CER$=" COLUMN"
1900 IF BORD<1 OR BORD>4 THEN BER$=" BOARD "
1910 IF RER$=" " AND CER$=" " AND BER$=" " THEN RETURN
1920 CODE=1
1930 LOCATE 23,1,0
1940 BEEP:PRINT"Invalid  "+RER$+CER$+BER$+"    "
1950 FOR I=1 TO 2000:NEXT:LOCATE 24,1,0
1960 LOCATE 23,1,0:PRINT"                                 ":RETURN
1970 ' **** Subroutine to convert to RCB input
1980 CON1=(BORD-1)*16
1990 CON2=(COL-1)*4
2000 D=CON1+CON2+ROW
2010 RETURN
2020 ' ******* Subroutine to convert from RCB
2030 ZUM1=D/16:BORD=INT(ZUM1+.9899999)
2040 B1=BORD-1:B2=B1*16:B3=D-B2:ZUM1=B3/4:COL=INT(ZUM1+.9899999)
2050 B5=COL-1:B6=B5*4:ROW=B3-B6
2060 RETURN
2070 REM
2080 REM---main logic subroutines---
2090 REM make computer move.
2100 REM
2110 REM see if we have a must block condition
2120 IF (YZ<3)*(V>1)+(YZ=1) THEN 2560
2130 IF Q=0 THEN 2200
2140 FOR G=0 TO 3
2150 E=A(65+G+(Q-1)*4)
2160 REM find empty box to block with
2170 IF A(E)=0 THEN K=E : G=4
2180 NEXT G
2190 GOTO 2590
2200 REM clear box value array
2210 FOR I=1 TO 64 : A(450+I)=0:NEXT I
2220 REM if u=0 then cats game
2230 U=0
2240 REM compute value for each box as it appears in the win array
2250 FOR I=1 TO (-10*(V=1)-76*(V<>1)) STEP (1-3*(V=2))
2260 B=A(370+I)
2270 REM if value of win combo is zero then forget it
2280 IF B=0 THEN U=1:GOTO 2460
2290 REM get strategy value of this win combo in f
2300 F=0
2310 IF (B=1) + (B=5) THEN F=1
2320 IF B=2 THEN F=4
2330 IF B=3 THEN STOP
2340 IF B=10 THEN F=2
2350 IF F=0 THEN 2460
2360 U=1
2370 REM increment each box in win combo by win value
2380 E=(I-1)*4+65
2390 FOR G=0 TO 3
2400 REM get box number in c
2410 C=A(E+G)
2420 REM see if this box is used
2430 IF A(C) <> 0 THEN 2450
2440 A(450+C)=A(450+C)+F
2450 NEXT G
2460 NEXT I
2470 REM see if cats game
2480 IF (U=0)*(V<>2) THEN 3260
2490 REM get best box now
2500 L=0
2510 FOR I=1 TO 64
2520 IF A(450+I)>L THEN L=A(450+I):K=I
2530 NEXT I
2540 REM see if any move found. if not do a random move
2550 IF L>0 THEN 2590
2560 GOSUB 3660
2570 IF A(I)=0 THEN K=I:GOTO 2590
2580 GOTO 2560
2590 REM do computer move in k
2600 GOSUB 2970
2610 RETURN
2620 REM
2630 REM evaluate all moves
2640 REM
2650 Q=0:R=0
2660 REM skip first move on version 1
2670 IF (YZ<3)*(V>1) THEN 2870
2680 K1LL=0 'if set then we are to get out of do loop
2690 FOR I=1 TO (V<>1)*-76+(V=1)*-10
2700 IF K1LL=1 THEN 2840  'human won, we done! if wizy won .                        keep checking to make sure human didn't win first.
2710 E=(I-1)*4+65
2720 F=370+I
2730 C=0
2740 FOR J=0 TO 3
2750 C=C+A(A(J+E))
2760 NEXT J
2770 REM see if wizy lost
2780 A(F)=C
2790 IF C=4 THEN R=I:K1LL=1:GOTO 2840
2800 REM must block if human has three in a row
2810 IF C=3 THEN Q=I
2820 REM see if comy won
2830 IF C=15 THEN R=I:K1LL=2:GOTO 2840
2840 NEXT I
2850 IF K1LL=1 THEN 3230
2860 IF K1LL=2 THEN 2890
2870 RETURN
2880 REM wizy won. find empty box!
2890 FOR H=0 TO 3
2900 C=A(65+H+(R-1)*4)
2910 IF A(C)=0 THEN K=C:H=4
2920 NEXT H
2930 REM do wizy move
2940 GOSUB 2970
2950 REM wizy won.
2960 GOTO 3050
2970 REM
2980 REM do wizy move specify in k
2990 REM
3000 D=K:A(D)=5
3010 GOSUB 2020
3020 FG=0:GOSUB 1110
3030 LOCATE 23,1,0:PRINT"COMPY takes box ";ROW;COL;BORD:FOR I=1 TO 4000:NEXT
3040 GOSUB 3630:RETURN
3050 REM
3060 REM wizy won/lost
3070 REM
3080 FG=2:GOSUB 3300    ' subroutine to mark thru winning boxes
3090 LOCATE 23,1,0:PRINT"HURRAH I WON !!!";:X=X+1:FOR I=1 TO 9000:NEXT
3100 CLS:LOCATE 4,1,0:PRINT"Wins: ";W;" Losses: ";X;" Ties: ";T
3110 LOCATE 7,2,0:PRINT"Do you want to play again ";NA$
3120 INPUT AN$:AN$=LEFT$(AN$,1)
3130 IF AN$="y" OR AN$="Y" THEN 310
3140 IF AN$="n" OR AN$="N" THEN 3180
3150 BEEP:LOCATE 10,3,0:PRINT"Yes/No please":FOR I=1 TO 1500:NEXT
3160 LOCATE 10,3,0:PRINT"               "
3170 GOTO 3110
3180 CLS:LOCATE 9,1,0:PRINT"I liked playing with you..."
3190 PRINT:PRINT"See you soon!"
3200 LOCATE 23,1,0
3210 CLS:RUN "MENU.PGM"
3220 REM wizy lost
3230 FG=2:GOSUB 3300  ' *********  mark the winning boxes
3240 LOCATE 23,1,0:PRINT"BOO-HOO I LOST .....":W=W+1:FOR I=1 TO 9000:NEXT I
3250 GOTO 3100
3260 LOCATE 23,1,0:PRINT"Tie game ...":FOR I=1 TO 9000:NEXT I
3270 GOSUB 3630
3280 GOTO 3100
3290 REM
3300 REM mark thru wins
3310 REM
3320 FOR H=0 TO 3:D=A(65+H+(R-1)*4)
3330 GOSUB 2020  ' convert d to rcb
3340 F=2:GOSUB 1110  ' mark thru wins
3350 NEXT H:RETURN
3360 REM
3370 REM setup win array
3380 REM
3390 RESTORE
3400 FOR I=1 TO 10:FOR C=0 TO 3:READ A(65+C+(I-1)*4):NEXT C:NEXT I
3410 FOR I=57 TO 76:FOR C=0 TO 3
3420 READ A(65+C+(I-1)*4)
3430 NEXT C:NEXT I
3440 FOR I=1 TO 3:FOR C=1 TO 10:FOR E=0 TO 3
3450 A(E+65+(C+I*10-1)*4)=A(E+65+(C-1)*4)+16*I
3460 NEXT E:NEXT C:NEXT I
3470 FOR I=41 TO 56:FOR C=0 TO 3
3480 A(65+C+(I-1)*4)=C*16+I-40:NEXT C:NEXT I
3490 RETURN
3500 DATA 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,1,5,9,13,2
3510 DATA 6,10,14
3520 DATA 3,7,11,15,4,8,12,16,1,6,11,16,4,7,10,13,1,22,43,64
3530 DATA 5,22,39,56,9,26,43,60,13,26,39,52,2,22,42,62,14,26
3540 DATA 38,50
3550 DATA 3,23,43,63,15,27,39,51,4,23,42,61,8,23,38,53,12,27
3560 DATA 42,57,16,27,38,49
3570 DATA 1,21,41,61,1,18,35,52,4,19,34,49,4,24,44,64
3580 DATA 13,25,37,49,13,30,47,64,16,31,46,61,16,28,40,52
3590 REM
3600 LOCATE 23,1,0:BEEP:PRINT"Box already taken!":FOR I=1 TO 1500:NEXT I
3610 GOSUB 3630
3620 GOTO 1670
3630 ' subroutine to clean up line 23 on screen
3640 LOCATE 23,1,0:PRINT"                              "
3650 RETURN
3660 Z1=(RND*100)
3670 I=INT(Z1):IF I<1 OR I>64 THEN 3660
3680 RETURN
3690 REM Subroutine to play the music
3700 PLAY "MBL12T128O3CDEFGABFEDCBADO4C"
3710 RETURN
3720 REM error handling routine
3730 CLS
3740 IF ERR=53 THEN 3830
3750 IF ERR=61 THEN 3860
3760 IF ERR=70 THEN 3910
3770 IF ERR=71 THEN 3940
3780 IF ERR=73 THEN 3970
3790 XX=ERR
3800 PRINT:PRINT"UNEXPECTED error number [";XX;"]"
3810 PRINT:PRINT"Please look it up in your basic manual"
3820 PRINT" in Appendix A.":END
3830 PRINT" Seems like you have the wrong disk in drive 'A`"
3840 PRINT "Please double check it."
3850 GOTO 3990
3860 PRINT"Opps... Your disk space is full, please make "
3870 PRINT" sure you have the right diskette in drive 'A`"
3880 PRINT" or you have to erase some data from the diskette"
3890 PRINT" in drive 'A` before you could save any more data on it."
3900 GOTO 3990
3910 PRINT" Diskette write protection notch is covered and I can "
3920 PRINT"not record your score unless you remove it."
3930 GOTO 3990
3940 PRINT" Drive 'A` is not ready, please insert the right "
3950 PRINT "diskette in, or make sure the drive door is closed."
3960 GOTO 3990
3970 PRINT" Advanced BASIC is required. Please load BASICA and rerun"
3980 END
3990 PRINT:PRINT
4000 end
