10 ' squaroot.bas - Freeware April 23, 2004
20 GOTO 70 ' begin
30 GOTO 910 ' isolate and count digits
40 GOTO 950 ' draw lines to screen
50 GOTO 960 ' draw lines to diskfile
60 GOTO 980 ' test for correct number
70 CLS:KEY OFF:B=20:DEFDBL E,G,M,N,V,Z,U,R,Q,A,T:COLOR 11,0
80 DIM A$(B),A(B),UK(B),TU(B),VL(B),U(B),R(B),LTU(B),LVL(B),V(B),UL(B)
90 PRINT TAB(6)"    Üßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß"
100 PRINT TAB(6)"Ü  Û   Ûßß ßßÛ Ûßß ÛßÛ ßßÛ ÛßÛ ÛßÛ  Û"
110 PRINT TAB(6)"Û  Û   ßßÛ Ûßß ÛßÛ ßßÛ ßßÛ Û Û ÛßÛ  Û"
120 PRINT TAB(6)"ßÜÜß   ÜÜÛ ÛÜÜ ÛÜÛ ÜÜÛ ÜÜÛ ÛÜÛ ÛÜÛ  Û":PRINT
130 PRINT TAB(7)"û 1 to 9 999 999 999 999 999":PRINT:COLOR 12,0
140 PRINT TAB(5)"By Eric F. Tchong, San Nicolas - Aruba":COLOR 13,0
150 PRINT TAB(6)"Enter memorizes last number & repeats":COLOR 14,0
160 PRINT TAB(7)"Do you need a diskfile <y/n or enter> ?"
170 M$="52693081":COLOR 11,0
180 P$=INKEY$:IF P$="" THEN 180 ELSE CLS
190 IF P$="y" OR P$="Y" THEN COPY=1 ELSE COPY=0
200 IF COPY THEN 210 ELSE 240
210 LINE INPUT "Enter a DOS filename ? "; Z$:CLS
220 IF LEFT$(Z$,1)=" " THEN Z$=MID$(Z$,2):GOTO 220
230 OPEN "O",#1,Z$
240 INPUT "Number: -1 stop ";G$:IF G$="" THEN G$=M$ ELSE M$=G$
250 GOSUB 60:IF NG=0 THEN 240
260 LM=25:RM=L+LM+5                     ' Left and Right Margin
270 ' Build groups                        52 69 30 81
280 IF L/2=INT(L/2) THEN GR=L/2:CH=2 ELSE GR=INT(L/2)+1:CH=1
290 IF CH=1 THEN A$(1)=MID$(G$,1,1):T=2 ELSE A$(1)=MID$(G$,1,2):T=3
300 FOR X=2 TO GR
310  A$(X)=MID$(G$,T,2):T=T+2
320 NEXT:N=VAL(G$)
330 FOR X=1 TO GR
340  R(X)=VAL(A$(X))
350 NEXT
360 ' Double Precision Square Root subroutine
370 IF N=0 THEN PRINT TAB(25)"û 0 = 0":PRINT:GOTO 240
380 Z=SQR(N)                           ' Prime value of  û
390 E=Z:Z=(N/Z+Z)/2:IF Z<>E THEN 390   ' Adjust value
400 ' Fix for Quick- en GwBasic
410 IF G$="9999999999999999" THEN G=99999999#:M=99999999.99999999#:GOTO 440
420 G=INT(Z):M=Z
430 ' Separate each digit                9527
440 Z=G:GOSUB 30:LG=L:QN=1
450 ' Reverse and save in U(QN)          7259
460 FOR X=L TO 1 STEP -1
470  U(QN)=A(X):QN=QN+1
480 NEXT
490 QN=QN-1:T=0
500 ' Calculate UK(X), UL(X)             7  72  725  7259
510 FOR X=1 TO L
520  UK(X)=T*10+U(X):T=UK(X):UL(X)=T
530 NEXT
540 ' Calculate TU(X)                     
550 TU(1)=U(1)*U(1)                    ' 49
560 FOR X=2 TO L
570  T=UK(X-1)*20:TU(X)=(T+U(X))*U(X)  ' 284  7225  130581
580 NEXT
590 ' Calculate V(X)
600 V(1)=R(1)-TU(1)                    ' 3  
610 FOR X=2 TO L
620  VL(X-1)=V(X-1)*100+R(X)           ' 369  8530  130581
630  V(X)=VL(X-1)-TU(X)                ' 3    85    1305
640 NEXT
650 ' Calculate the lengths of LTU(X) and LVL(X)
660 FOR X=1 TO QN
670  Z=TU(X):GOSUB 30:LTU(X)=L         ' 2  3  4  6
680  Z=VL(X):GOSUB 30:LVL(X)=L         ' 3  4  6
690 NEXT
700 ' û 123456 LR(1)=2> LTU(1)=1         special case
710 Z=R(1):GOSUB 30:LR(1)=L
720 IF CH=2 AND LR(1)>LTU(1) THEN EC=1 ELSE EC=0
730 ' Show the solution
740 IF CH=1 THEN SW=1 ELSE SW=0
750 IF LEN(G$)<3 THEN QN=2
760 PRINT:PRINT TAB(LM+1) CHR$(251);" ";G$;" =";M:IF COPY THEN PRINT #1,"":PRINT #1, TAB(LM+1) CHR$(251);" ";G$;" =";M
770 LC=LTU(1)+2+EC                     ' LC=4
780 FOR X=1 TO QN-1:LC=LC+2            ' look at 69 30 81
790  IF X=1 THEN PRINT TAB(2+EC+LM) TU(X):L=LTU(X)+EC:P=L+1+SW:GOSUB 40:IF COPY THEN PRINT #1, TAB(2+EC+LM) TU(X):GOSUB 50
800  IF LEN(G$)<3 THEN 850
810  PRINT TAB(LC-LVL(X)+LM) VL(X):IF COPY THEN PRINT #1, TAB(LC-LVL(X)+LM) VL(X)
820  PRINT TAB(LC-LTU(X+1)+LM) TU(X+1);:IF COPY THEN PRINT #1, TAB(LC-LTU(X+1)+LM) TU(X+1);
830  PRINT TAB(RM) UL(X)*20+U(X+1);"x";U(X+1):IF COPY THEN PRINT #1, TAB(RM) UL(X)*20+U(X+1);"x";U(X+1)
840  L=LVL(X):P=(LC-L)+1:GOSUB 40:IF COPY THEN GOSUB 50 
850 NEXT
860 IF LEN(G$)<3 THEN QN=1:LC=LC-2     ' Remainder V(QN)=0 
870 Z=V(QN):GOSUB 30
880 PRINT TAB(LC-L+LM) V(QN):IF COPY THEN PRINT #1, TAB(LC-L+LM) V(QN):PRINT #1,""
890 PRINT:GOTO 240
900 ' Isolate digits and count the length
910 L=1
920 E=INT(Z/10):A(L)=Z-10*E:IF E<>0 THEN L=L+1:Z=E:GOTO 920 ELSE RETURN
930 ' Draw Lines
940 ' Change - to Ä alt + 0196 if your wordprocessor prints Ä and not Ž
950 PRINT TAB(P+LM)"";: PRINT STRING$ (L,"Ä"):RETURN
960 PRINT #1, TAB(P+LM)"";:PRINT #1, STRING$ (L,"-"):RETURN
970 ' Test for correct number 
980 L=LEN(G$):T=0:IF L>16 THEN 1080
990 IF LEFT$(G$,1)="0" AND L>1 THEN 1080
1000 IF G$="-1" THEN 1110
1010 FOR X=1 TO L
1020  Z=ASC(MID$(G$,X,1)):IF MID$(G$,X,1)="." THEN T=2:GOTO 1040
1030  IF Z<48 OR Z>57 THEN 1080
1040 NEXT
1050 IF T>1 THEN 1080
1060 NG=1:RETURN
1070 ' Clear line
1080 NG=0:BEEP
1090 PRINT CHR$(30);:PRINT STRING$(79,32):PRINT CHR$(30);:RETURN
1100 ' Quit nicely
1110 KEY 5,"squaroot.bas":KEY 6,CHR$(34)+",a":KEY ON
1120 COLOR 7,0:CLS:END
1130 ' Example at startup of this program
1140 ' R(1) =52      û 52693081 = 7259
1150 ' TU(1)=49        49        
1160 '                 ÄÄ
1170 ' V(1) =3          369                   VL(1)=369
1180 ' TU(2)=284        284       142 x 2
1190 '                  ÄÄÄ
1200 ' V(2) =85          8530                 VL(2)=8530
1210 ' TU(3)=7225        7225     1445 x 5
1220 '                   ÄÄÄÄ
1230 ' V(3) =1305        130581               VL(3)=130581
1240 ' TU(4)=130581      130581   14509 x 9
1250 '                   ÄÄÄÄÄÄ
1260 ' V(QN)=0                0
1270 ' Use only QB 4.5 to compile
