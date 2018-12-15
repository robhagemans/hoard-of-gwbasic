10 ' morse.bas - FreeWare 2005
20 GOTO 50 ' begin
30 SAVE"morse",A:LIST-50
40 ' begin
50 CLS:KEY OFF:DIM BL(256):DEFSTR M,Q,Z
60 BL(96)=256:SIL=32767:F=600:WPM=20  ' locals
70 M="CQ CQ CQ DE P43EC P43EC  <":Z=M:T$=CHR$(17)+"ды"
80 Z(1)="SAMUEL F.B. MORSE WAS AN AMERICAN INVENTOR AND PAINTER."
90 Z(2)="MOST FAMOUS FOR INVENTING THE ELECTRIC TELEGRAPH AND MORSE CODE."
100 Z(3)=Z(1)+" "+Z(2)
110 FOR I=97 TO 122:READ AL:BL(I)=AL:BL(I-32)=AL:NEXT
120 FOR I=33 TO 64 :READ AL:BL(I)=AL:NEXT:COLOR 7,0
130 ' assemble P43EC
140 DIM M(15)
150 M(1) ="   "+CHR$(219)+CHR$(223)+CHR$(219)+" "
160 M(2) =CHR$(219)+" "+CHR$(219)+ " "
170 M(3) =CHR$(223)+CHR$(223)+CHR$(219)+"  "
180 M(4) =CHR$(219)+CHR$(223)+CHR$(223)+" "
190 M(5) =CHR$(219)+CHR$(223)+CHR$(223)+"  "
200 M(6) ="   "+CHR$(219)+CHR$(223)+CHR$(223)+" "
210 M(7) =CHR$(223)+CHR$(223)+CHR$(219)+" "
220 M(8) =CHR$(223)+CHR$(223)+CHR$(219)+"  "
230 M(9) =CHR$(219)+CHR$(223)+"  "
240 M(10)=CHR$(219)
250 M(11)="   "+CHR$(223)
260 M(12)="     "+CHR$(223)+" "
270 M(13)=CHR$(223)+CHR$(223)+CHR$(223)+"  "
280 M(14)=CHR$(223)+CHR$(223)+CHR$(223)+" "
290 M(15)=CHR$(223)+CHR$(223)+CHR$(223)
300 FOR I=1 TO 15
310  PRINT M(I); ' print P43EC
320  IF I/5=INT(I/5) THEN PRINT
330 NEXT
340 COLOR 11,0:PRINT"** MORSE CODE GENERATOR **"
350 COLOR 12,0:PRINT"  Programmed in GW-BASIC"
360 PRINT "      by Eric Tchong":PRINT:COLOR 15,0
370 ' menu
380 PRINT "<   SK      >  AR          +   Understood"
390 PRINT "`   Error   @  Attention   *   Wait"
400 PRINT T$+" Repeat  \  Speed Menu  [ ] Quit":PRINT
410 PRINT "% Switch dit + dah blocks ON/OFF"
420 PRINT "^   Info about Samuel Morse":PRINT
430 COLOR 7,0:PRINT "Code   speed now at: ";WPM;"wpm..."
440 INPUT "Change speed (0=20) ";WPM:IF WPM=0 THEN WPM=20
450 PRINT "Code   speed set at: ";WPM;"wpm...":PRINT
460 IF WPM<13 THEN CWPM=13 ELSE CWPM=WPM
470 DIT=21.84/CWPM:DAH=3*DIT
480 IF WPM>=13 THEN ELE=DIT ELSE ELE=DIT*((CWPM/WPM-1)*13+2)/2
490 ' get text
500 COLOR 11,0:PRINT "Enter your text:":PRINT:COLOR 7,0
510 LINE INPUT Q
520 IF Q="[" OR Q="]" THEN CLS:END
530 IF Q="%" THEN IF SW=0 THEN SW=1:PRINT "print dits, dahs ON":GOTO 590
540 IF Q="%" THEN IF SW=1 THEN SW=0:PRINT "print dits, dahs OFF":GOTO 590
550 IF Q="^" THEN Q=Z(3):PRINT:PRINT Z(1):PRINT Z(2):GOTO 590
560 IF Q="\" THEN COLOR 15,0:CLS:Q=M:GOTO 380
570 IF Q=""  THEN Q=M:PRINT:PRINT Q ELSE M=Q
580 ' text, dits+dahs, sound
590 FOR L=1 TO LEN(Q):COLOR 14,0
600  IF (MID$(Q,L,1))=">" THEN PRINT "AR ";:GOTO 660
610  IF (MID$(Q,L,1))="<" THEN PRINT "SK ";:GOTO 660
620  IF (MID$(Q,L,1))=" " THEN SOUND SIL,ELE*6:COLOR 7,0:PRINT:GOTO 780
630  IF SW=1 THEN PRINT (MID$(Q,L,1));" ";:GOTO 660
640  PRINT (MID$(Q,L,1));:COLOR 7,0
650 ' Convert a number to morse code
660   NR=ASC(MID$(Q,L,1)):AL=BL(NR):K=AL:T=0
670   IF K<=1 THEN 710 ELSE T=T+1:P=K MOD 2
680   IF P=1 THEN A$(T)="3" ELSE A$(T)="1"
690   K=(K-P)/2:GOTO 670
700 ' sound
710   FOR I=T TO 1 STEP -1:D=VAL(A$(I))
720    IF D=1 THEN SOUND F,DIT:SOUND SIL,DIT
730    IF D=3 THEN SOUND F,DAH:SOUND SIL,DIT
740    COLOR 13,0:IF SW=0 THEN 760
750    PRINT STRING$(D,CHR$(220));CHR$(32);
760    COLOR 7,0
770   NEXT:SOUND SIL,ELE*2
780 NEXT
790 PRINT:PRINT:Q=M:GOTO 510
800 ' morse data
810 DATA 5,24,26,12,2,18,14       : REM a b c d e f g
820 DATA 16,4,23,13,20,7,6,15,22  : REM h i j k l m n o p
830 DATA 29,10,8,3,9,17,11        : REM q r s t u v w
840 DATA 25,27,28                 : REM x y z
850 DATA 1,82,1,1,1,1,94,109,109  : REM ! " # $ % & ' ( )
860 DATA 40,34,115,97,85,50       : REM  * + , - . /
870 DATA 63,47,39,35,33           : REM 0 1 2 3 4
880 DATA 32,48,56,60,62           : REM 5 6 7 8 9
890 DATA 120,106                  : REM : ;
900 DATA 69,49,42,76,52           : REM < = > ? @
910 ' dits and dahs from binary info 0=dit 1=dah
920 ' 0 0 0 1 0 1   < SK
930 '   1 0 0 0 1   =
940 '   0 1 0 1 0   > AR
950 ' 0 0 1 1 0 0   ?
960 '   1 0 1 0 0   @ attention
970 '   0 0 0 1 0   + understood
