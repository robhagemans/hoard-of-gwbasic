10 ' generdiv.bas - Freeware April 23, 2004
20 GOTO 90
30 GOTO 570 ' get manual input
40 GOTO 1260 ' count digits and get length
50 GOTO 1290 ' draw lines
60 GOTO 1310 ' wait for key input
70 GOTO 1350 ' send results to screen or diskfile
80 GOTO 1420 ' clear line
90 CLS:KEY OFF:B=25                       
100 DEFDBL D,M,Z,N,E,T:RANDOMIZE TIMER
110 DIM A(B),CT(B),TU(B),LTU(B),TV(B),NDT(B),QU(B),TG(B),LTG(B),L$(B),N$(B)
120 SP$=STRING$(8,32):M1=117932!:M2=62:W$=MKI$(0)
130 PRINT "******************************"
140 PRINT "*  LONG DIVISIONS GENERATOR  *"
150 PRINT "*  Eric Tchong ------ Aruba  *"
160 PRINT "******************************"
170 PRINT:PRINT "Do you want a diskfile <y/n>?":GOSUB 60
180 IF P=89 OR P=121 THEN COPY=1 ELSE COPY=0
190 IF COPY THEN CLS:GOTO 200 ELSE 240
200 LINE INPUT "Enter a DOS filename ? ";Z$:CLS
210 IF LEFT$(Z$,1)=" " THEN Z$=MID$(Z$,2):GOTO 210
220 OPEN "O",#1,Z$
230 ' Announce us
240 CLS:PRINT"LONG DIVISIONS GENERATOR":PRINT
250 PRINT"1) Manual operation"
260 PRINT"2) Auto   operation"
270 PRINT"3) Quit program...."
280 PRINT:PRINT"Choose <1-3>"
290 GOSUB 60
300 IF P=49 THEN O=1 ELSE IF P=50 THEN O=2 ELSE IF P=51 THEN 1440
310 IF O<1 OR O>2 THEN GOSUB 80:GOTO 240 ELSE GOSUB 80
320 CLS:ON O GOTO 340,460
330 ' Manual input
340 PRINT"Numbers < 9999999....":PRINT
350 FOR SUM=1 TO 3
360  PRINT "Sum ";SUM;:INPUT "Dividend <-1 Menu> ";DT
370  IF DT>9999999! OR DT<>INT(DT) THEN BEEP:GOSUB 80:GOTO 360
380  IF DT=-1 THEN 240 ELSE IF DT=0 THEN DT=M1
390  GOSUB 80:PRINT "Sum ";SUM;:INPUT "Divisor <-1 Menu> ";DL
400  IF DL>9999999! THEN GOSUB 80:GOTO 390
410  IF DL=-1 THEN 240 ELSE IF DL=0 THEN DL=M2
420  M1=DT:M2=DL:GOSUB 80:GOSUB 30
430 NEXT
440 CLS:GOSUB 70:TL=0:GOTO 350
450 ' Automatic divisions generator
460 CLS
470 FOR SUM=1 TO 2
480  DT=INT(RND*999)+1:DL=INT(RND*999)+1
490  DT=DT*DL:GOSUB 30
500 NEXT
510 DT=INT(RND*999999!)+1:DL=INT(RND*9999)+1
520 GOSUB 30:GOSUB 70:TL=0
530 PRINT "Press <any key> or M = Menu";:M1=DT:M2=DL
540 GOSUB 60
550 IF P=77 OR P=109 THEN 240 ELSE 460
560 ' Get all results
570 IF DT<DL THEN SWAP DT,DL
580 ' Calculate lengths of divisor 1024 LDL=4, quotient 8759 LDQ=4
590 Z=DL:GOSUB 40:LDL=L:DQ=INT(DT/DL)
600 ' Separate each digit of quotient         2091
610 Z=DQ:GOSUB 40:LDQ=L:QN=1
620 ' Reverse and save in QU(QN)              1902
630 FOR X=L TO 1 STEP -1
640  QU(QN)=A(X):QN=QN+1
650 NEXT:QN=QN-1                            ' QN=4
660 ' TU(1) = 62, TU(2) = 558, TU(3) = 0, TU(4) = 124
670 FOR X=1 TO QN
680  TU(X)=DL*QU(X)
690 NEXT
700 ' Separate each digit of dividend         239711
710 Z=DT:GOSUB 40:LDT=L:QT=1
720 ' Reverse and save in CT(QT)              117932
730 FOR X=L TO 1 STEP -1
740  CT(QT)=A(X):QT=QT+1
750 NEXT                                    ' QT=6
760 ' LTU(1) = 62, length = 2
770 Z=TU(1):GOSUB 40:LTU(1)=L
780 ' Calculate new dividend                  first  pass NDT = 11
790 NDT=0                                   ' second pass NDT = 117
800 FOR X=1 TO L
810  NDT(X)=CT(X)*(10^(L-X))
820  NDT=NDT+NDT(X)
830 NEXT
840 ' NDT=117, SW=1
850 IF NDT>TU(1) THEN 890
860 ' NDT=11 < TU(1)=62
870 IF NDT<TU(1) THEN L=L+1:LTU(1)=L:SW=1:GOTO 790
880 ' LN=3 length NDT=117
890 Z=NDT:GOSUB 40:LN=L
900 ' TV(1) = 117 - 62 = 55
910 ' TV(2) = 559 - 558 = 1
920 ' TV(3) =  13 - 0  = 13
930 ' TV(4) = 132 - 124 = 8
940 ' TG(1) = 55 * 10 + 9 = 559
950 ' TG(2) =  1 * 10 + 3 =  13
960 ' TG(3) = 13 * 10 + 2 = 132
970 ' TG(4) = 0
980 TV(1)=NDT-TU(1)                         ' 55
990 FOR W=1 TO QN-1
1000  L=L+1
1010  TG(W)=TV(W)*10+CT(L)                   ' 559  13  132
1020  TV(W+1)=TG(W)-TU(W+1)                  ' 1    13  8
1030 NEXT
1040 ' Calculate lengths of TG(Y) and TU(Y)
1050 FOR Y=1 TO QN-1:Z=TG(Y):GOSUB 40:LTG(Y)=L:NEXT
1060 FOR Y=2 TO QN  :Z=TU(Y):GOSUB 40:LTU(Y)=L:NEXT
1070 ' Save each sum in N$(X)
1080 ' N$(1)=STR$(DL)+" /"+STR$(DT)+" \"+STR$(DQ)+SP$:FR=LEN(N$(1)):LC=LDL+LTU(1)+3
1090 LC=LDL+3+(LDT-LDQ):N$(1)=STRING$(LC,32)+STR$(DQ)+SP$:FR=LEN(N$(1))
1100 ' T=1:P=LDL+4:L=LDT
1110 N$(2)=STRING$(LDL+2,32)+CHR$(218)+STRING$(LDT+1,"Ä")+SP$ ' April 25, 2001 
1120 N$(3)=STR$(DL)+ " ³"+STR$(DT)+SP$:LC=LDL+LTU(1)+3
1130 IF SW=1 THEN L=(LC-LTU(1)+1):N$(4)=STRING$(L,32)+STR$(TU(1))+STRING$(FR-L-LTU(1),32):L=LN
1140 IF SW=0 THEN L=(LC-LTU(1))  :N$(4)=STRING$(L,32)+STR$(TU(1))+STRING$(FR-L-LTU(1)-1,32):L=LN
1150 T=4:P=(LC-L)+1:GOSUB 50
1160 FOR Y=1 TO QN-1:LC=LC+1:IF TU(Y+1)=0 THEN 1200   
1170  T=T+1:L=(LC-LTG(Y))  :N$(T)=STRING$(L,32)+STR$(TG(Y))  +STRING$(FR-L-LTG(Y)-1,32)
1180  T=T+1:L=(LC-LTU(Y+1)):N$(T)=STRING$(L,32)+STR$(TU(Y+1))+STRING$(FR-L-LTU(Y+1)-1,32)
1190  L=LTG(Y):P=(LC-L)+1:GOSUB 50
1200 NEXT
1210 Z=TV(QN):GOSUB 40:LTV=L:T=T+1:L=LC-L:IF T>TL THEN TL=T
1220 N$(T)=STRING$(L,32)+STR$(TV(QN))+STRING$(FR-L-LTV-1,32):SW=0
1230 FOR X=T+1 TO B:N$(X)=STRING$(FR,32):NEXT
1240 FOR X=1 TO B:L$(X)=L$(X)+N$(X):NEXT:RETURN
1250 ' Isolate digits or count length of digits
1260 L=1
1270 E=INT(Z/10):A(L)=Z-10*E:IF E<>0 THEN L=L+1:Z=E:GOTO 1270 ELSE RETURN
1280 ' Draw lines
1290 T=T+1:N$(T)=STRING$(P,32)+STRING$(L,"Ä")+STRING$(FR-P-L,32):RETURN
1300 ' Wait for a key input
1310 LSET W$=MKI$(0)
1320 WHILE CVI(W$)=0:MID$(W$,1)=INKEY$:WEND
1330 P=ASC(W$):RETURN
1340 ' Send results to screen or diskfile
1350 FOR X=1 TO TL+1
1360  PRINT L$(X)
1370  IF COPY THEN PRINT #1, L$(X)
1380 NEXT
1390 ' Empty strings
1400 FOR X=1 TO B:L$(X)="":N$(X)="":NEXT:RETURN
1410 ' Clear line
1420 PRINT CHR$(30);:PRINT STRING$(79,32):PRINT CHR$(30);:RETURN
1430 ' Exit
1440 KEY 5,"generdiv.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS
1450 ' Assemble each sum in N$(X) and save it in L$(X)
1460 ' DL=62  DT=117932
1470 ' N$(1)                             1902  DQ
1480 ' N$(2)                         ÚÄÄÄÄÄÄÄ  line
1490 ' N$(3)  NDT    = 117        62 ³ 117932   
1500 ' N$(4)  TU(1)  = 62               62
1510 ' N$(5)                           ÄÄÄ
1520 ' N$(6)  TV(1)  = 55               559    TG(1) = 559
1530 ' N$(7)  TU(2)  = 558              558
1540 ' N$(8)                            ÄÄÄ
1550 ' N$(9)  TV(2)  = 1     TV(3)=13     132  TG(3) = 132
1560 ' N$(10) TU(4)  = 124                124  TU(3) = 0
1570 ' N$(11)                             ÄÄÄ
1580 ' N$(12) TV(QN) = 8                    8
