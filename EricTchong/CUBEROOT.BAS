10 ' cuberoot.bas - Freeware April 23, 2004
20 GOTO 70 ' begin
30 GOTO 1120 ' isolate and count digits
40 GOTO 1160 ' draw lines to screen
50 GOTO 1170 ' draw lines to diskfile
60 GOTO 1190 ' test for a valid number
70 CLS:KEY OFF:B=20:DEFDBL D,E,G,M,N,Z,U,R,Q,A,T,V:COLOR 11,0
80 DIM A$(B),A(B),UK(B),TU(B),VL(B),U(B),R(B),LTU(B),LVL(B),V(B),UL(B)
90 PRINT "     €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"
100 PRINT "€ 3 €  €ﬂ€ €ﬂ€ ﬂﬂ€ € € €ﬂ€ €ﬂ€ €ﬂ€ €ﬂ€ €ﬂﬂ ﬂﬂ€ €ﬂ€"
110 PRINT "€   €    € €ﬂ€ ﬂﬂ€ €‹€   € €ﬂ€ € € ﬂﬂ€ €ﬂ€ ﬂﬂ€ ﬂﬂ€"
120 PRINT " ﬂ‹ﬂ     € €‹€ ‹‹€   €   € €‹€ €‹€ ‹‹€ €‹€ ‹‹€ ‹‹€":PRINT
130 PRINT "   Cube Root from 1 to 9 999 999 999 999 999":COLOR 12,0:PRINT
140 PRINT TAB(5)"By Eric F. Tchong,  San Nicolas **** Aruba":COLOR 13,0
150 PRINT TAB(6)"<Enter> repeats last number * -1 to Exit":COLOR 14,0
160 PRINT TAB(7)"Do you want a diskfile <y/n or enter>?"
170 M$="78347809639":COLOR 11,0
180 P$=INKEY$:IF P$="" THEN 180 ELSE CLS
190 IF P$="y" OR P$="Y" THEN COPY=1 ELSE COPY=0
200 IF COPY THEN 210 ELSE 240
210 LINE INPUT "Enter a DOS filename ? "; Z$:CLS
220 IF LEFT$(Z$,1)=" " THEN Z$=MID$(Z$,2):GOTO 220
230 OPEN "O",#1,Z$
240 INPUT "Number: -1 stop ";G$:IF G$="" THEN G$=M$ ELSE M$=G$
250 GOSUB 60:IF NG=0 THEN 240
260 LM=16:RM=L+LM+5 ' Left and Right Margins
270 ' Build groups  78 347 809 639
280 IF L=1 THEN GR=1:A$(1)=G$:FG=1:GOTO 350
290 IF L/3=INT(L/3) THEN GR=L/3 ELSE GR=INT(L/3)+1
300 Z=INT((L-.5)/3):M=L-3*Z:FG=M
310 A$(1)=MID$(G$,1,M):T=M+1
320 FOR X=2 TO GR
330  A$(X)=MID$(G$,T,3):T=T+3
340 NEXT
350 N=VAL(G$):DN=N:R=3
360 FOR X=1 TO GR
370  R(X)=VAL(A$(X))
380 NEXT
390 ' Double Precision Cube Root Subroutine
400 IF N=0 THEN PRINT:PRINT TAB(15)"3 ˚ 0 = 0":PRINT:GOTO 240
410 D=DN^(1/R)
420 FOR X=1 TO 3: DM=1
430  FOR Y=1 TO R-1
440   DM=DM*D
450  NEXT 
460  D=D-D/R+DN/R/DM
470 NEXT
480 M=D:G=INT(M)
490 ' Separate each digit        9724
500 Z=G:GOSUB 30:LG=L:QN=1
510 ' Reverse and save in U(QN)  4279
520 FOR X=L TO 1 STEP -1
530  U(QN)=A(X):QN=QN+1
540 NEXT
550 QN=QN-1:T=0
560 ' Calculate UK(X), UL(X)     4  42  427  4279
570 FOR X=1 TO L
580  UK(X)=T*10+U(X):T=UK(X):UL(X)=T
590 NEXT
600 ' Calculate TU(X)
610 TU(1)=U(1)*U(1)*U(1)       ' 64
620 FOR X=2 TO L
630  T=(UK(X-1)*UK(X-1)*300)+(UK(X-1)*U(X)*30)+(U(X)*U(X))
640  TU(X)=T*U(X)                ' 10088  3766483  493326639
650 NEXT
660 ' Calculate V(X)
670 V(1)=R(1)-TU(1)            ' 14
680 FOR X=2 TO L
690  VL(X-1)=V(X-1)*1000+R(X)  ' 14347  4259809  493326639
700  V(X)=VL(X-1)-TU(X)        ' 14     4259     493326
710 NEXT
720 ' Calculate lengths of LTU(X) and LVL(X)
730 FOR X=1 TO QN
740  Z=TU(X):GOSUB 30:LTU(X)=L ' 2  5  7  9
750  Z=VL(X):GOSUB 30:LVL(X)=L ' 5  7  9
760 NEXT
770 ' LR(1)=2> LTU(1)=1          special case
780 Z=R(1):GOSUB 30:LR(1)=L
790 IF LR(1)>LTU(1) THEN EC=1 ELSE EC=0
800 ' Show the solution
810 IF LEN(G$)<4 THEN QN=2
820 IF FG=3 THEN SW=0
830 IF FG=2 THEN SW=1
840 IF FG=1 THEN SW=2
850 PRINT:PRINT TAB(LM-1) "3 ˚ ";G$;" =";M
860 IF COPY THEN PRINT #1,"" :PRINT #1, TAB(LM-1) "3 ˚ ";G$;" =";M
870 LC=LTU(1)+2+EC               ' LC=4
880 FOR X=1 TO QN-1:LC=LC+3      ' point to 347 809 639
890  IF X=1 THEN PRINT TAB(2+EC+LM) TU(X):L=LTU(X)+EC:P=L+SW:GOSUB 40:IF COPY THEN PRINT #1, TAB(2+EC+LM) TU(X):GOSUB 50 
900  IF LEN(G$)<=3 THEN 1060
910  PRINT TAB(LC-LVL(X)+LM) VL(X);:IF COPY THEN PRINT #1, TAB(LC-LVL(X)+LM) VL(X);
920  Q=UK(X)*UK(X)*300:A=UK(X)*U(X+1)*30:T=U(X+1)*U(X+1):V=Q+A+T
930  Z=UK(X):GOSUB 30:M1=L:Z=Q:GOSUB 30:M2=L:RQ=2*M1+12+M2
940  Z=A:GOSUB 30:RA=L:Z=T:GOSUB 30:RT=L:Z=V:GOSUB 30:RV=L
950  PRINT TAB(RM) UK(X);"x";UK(X);"x 300 =";Q
960  IF COPY THEN PRINT #1, TAB(RM) UK(X);"x";UK(X);"x 300 =";Q
970  PRINT TAB(RM) UK(X);"x";U(X+1);"x 30 =";TAB(RQ-RA+RM)A
980  IF COPY THEN PRINT #1, TAB(RM) UK(X);"x";U(X+1);"x 30 =";TAB(RQ-RA+RM)A
990  PRINT TAB(RM) U(X+1);"x";U(X+1);"=";TAB(RQ-RT+RM)T
1000  IF COPY THEN PRINT #1, TAB(RM) U(X+1);"x";U(X+1);"=";TAB(RQ-RT+RM)T
1010  PRINT TAB(LC-LTU(X+1)+LM) TU(X+1);
1020  IF COPY THEN PRINT #1, TAB(LC-LTU(X+1)+LM) TU(X+1);
1030  PRINT TAB(RM) U(X+1);"x";TAB(RQ-RV+RM)V
1040  IF COPY THEN PRINT #1, TAB(RM) U(X+1);"x";TAB(RQ-RV+RM)V
1050  L=LVL(X):P=(LC-L)+1:GOSUB 40:IF COPY THEN GOSUB 50
1060 NEXT
1070 IF LEN(G$)<4 THEN QN=1:LC=LC-3 ' Remainder V(QN)=0
1080 Z=V(QN):GOSUB 30
1090 PRINT TAB(LC-L+LM) V(QN):IF COPY THEN PRINT #1, TAB(LC-L+LM) V(QN):PRINT #1,"" 
1100 PRINT:GOTO 240
1110 ' Isolate digits and count the length
1120 L=1
1130 E=INT(Z/10):A(L)=Z-10*E:IF E<>0 THEN L=L+1:Z=E:GOTO 1130 ELSE RETURN
1140 ' Draw lines
1150 ' Change - to alt + 0196 if you get ƒ and not é
1160 PRINT TAB(P+LM)"";: PRINT STRING$ (L,"ƒ"):RETURN
1170 PRINT #1, TAB(P+LM)"";:PRINT #1, STRING$ (L,"-"):RETURN
1180 ' Test for a valid number
1190 L=LEN(G$):T=0:IF L>16 THEN 1290
1200 IF LEFT$(G$,1)="0" AND L>1 THEN 1290
1210 IF G$="-1" THEN 1320
1220 FOR X=1 TO L
1230  Z=ASC(MID$(G$,X,1)):IF MID$(G$,X,1)="." THEN T=2:GOTO 1250
1240  IF Z<48 OR Z>57 THEN 1290
1250 NEXT
1260 IF T>1 THEN 1290
1270 NG=1:RETURN
1280 ' Clear line
1290 NG=0:BEEP
1300 PRINT CHR$(30);:PRINT STRING$(79,32):PRINT CHR$(30);:RETURN
1310 ' Quit nicely
1320 KEY 5,"cuberoot.bas":KEY 6,CHR$(34)+",a":KEY ON
1330 COLOR 7,0:CLS:END
1340 ' Example in this program
1350 ' R(1) =78 Cube Root 78347809639 = 4279
1360 ' TU(1)=64           64
1370 '                    ƒƒ
1380 ' V(1) =14           14347         4 x 4 x 300 = 4800
1390 ' VL(1)=14347                      4 x 2 x 30 =   240
1400 '                                  2 x 2 =          4
1410 ' TU(2)=10088        10088         2 x           5044
1420 '                    ƒƒƒƒƒ
1430 ' V(2) =4259          4259809      42 x 42 x 300 = 529200
1440 ' VL(2)=4259809                    42 x 7 x 30 =     8820
1450 '                                  7 x 7 =             49
1460 ' TU(3)=3766483       3766483      7 x             538069
1470 '                     ƒƒƒƒƒƒƒ
1480 ' V(3) =493326         493326639   427 x 427 x 300 = 54698700
1490 ' VL(3)=493326639                  427 x 9 x 30 =      115290
1500 '                                  9 x 9 =                 81
1510 ' TU(4)=493326639      493326639   9 x               54814071
1520 '                      ƒƒƒƒƒƒƒƒƒ
1530 ' V(QN)=0                      0
