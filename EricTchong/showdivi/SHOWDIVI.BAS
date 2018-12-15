10  ' Showdivi.bas - FreeWare 2004
20 GOTO 90 ' begin
30 SAVE"showdivi.bas":LIST-90
40 GOTO 1300 ' isolate and count
50 GOTO 1330 ' draw lines
60 GOTO 1390 ' test for valid number
70 GOTO 1510 ' get key
80 ' begin
90 CLS:KEY OFF:B=16
100 DEFDBL D,M,Z,N,E,T :M1$="117932" :M2$="62":LM=19:K1$=M1$:K2$=M2$
110 DIM A(B),CT(B),TU(B),LTU(B),TV(B),NDT(B),QU(B),TG(B),LTG(B)
120 DEFSTR W:W=MKI$(0)
130 PRINT "****************************"
140 PRINT "*    SHOW LONG DIVISION    *"
150 PRINT "*    by: Eric F. Tchong    *"
160 PRINT "*   serenata@setarnet.aw   *"
170 PRINT "*      FreeWare  2004      *"
180 PRINT "****************************"
190 PRINT:PRINT "Make showdivi.asc file y/n?"
200 GOSUB 70:CLS
210 IF ASC(W)=121 OR ASC(W)=89 THEN COPY=1 ELSE COPY=0 ' y Y
220 IF COPY THEN OPEN "O",#1,"showdivi.asc"
230 CLS:PRINT"  <1>        1902"
240 PRINT"           ÄÄÄÄÄÄ"
250 PRINT"      62 ) 117932":PRINT
260 PRINT"  <2> 62 / 117932 \ 1902"
270 PRINT"            62"
280 PRINT"           ÄÄÄ":PRINT
290 PRINT"  <3> Exit":PRINT
300 INPUT"  Select 1, 2, 3 ";CH
310 IF CH=3 THEN 1530 ELSE IF CH=1 THEN ST=1 ELSE IF CH=2 THEN ST=0
320 IF CH<1 OR CH>3 THEN 230
330 CLS
340 ' Get dividend DT = 117932
350 INPUT "Dividend -1 menu ";G$:IF G$="" THEN G$=M1$ ELSE M1$=G$
360 GOSUB 60:IF NG=0 THEN NG=1:GOTO 350
370 DT$=G$:DT=VAL(DT$):K1$=G$
380 ' Get divisor  DL = 62
390 INPUT "Divisor  -1 menu ";G$:IF G$="" THEN G$=M2$ ELSE M2$=G$
400 GOSUB 60:IF NG=0 THEN NG=1:GOTO 390
410 DL$=G$:DL=VAL(DL$):K2$=G$
420 IF DL=0 THEN BEEP:PRINT:PRINT "Division by zero":GOTO 390
430 IF DT<DL THEN PRINT:PRINT TAB(LM) DT;"ö";DL;"=";DT/DL:GOTO 1370
440 ' Calculate length of divisor LDL = 2
450 Z=DL:GOSUB 40:LDL=L        
460 ' DQ = 1902
470 DQ=INT(DT/DL)
480 ' Separate each digit of quotient     2091
490 Z=DQ:GOSUB 40:LDQ=L:QN=1
500 ' Reverse and save in QU(QN)          1902
510 FOR X=L TO 1 STEP -1
520  QU(QN)=A(X):QN=QN+1
530 NEXT:QN=QN-1                        ' QN=4
540 ' TU(1) = 62, TU(2) = 558, TU(3) = 0, TU(4) = 124
550 FOR X=1 TO QN
560  TU(X)=DL*QU(X)
570 NEXT 
580 ' Separate each digit of dividend     239711
590 Z=DT:GOSUB 40:LDT=L:QT=1
600 ' Reverse and save in CT(QN)          117932
610 FOR X=L TO 1 STEP -1
620  CT(QT)=A(X):QT=QT+1
630 NEXT:QT=QT-1                        ' QT=6
640 ' LTU(1)=2 length TU(1)=62
650 Z=TU(1):GOSUB 40:LTU(1)=L
660 ' Calculate new dividend              first  pass NDT=11
670 NDT=0                               ' second pass NDT=117
680 FOR X=1 TO L
690  NDT(X)=CT(X)*(10^(L-X))
700  NDT=NDT+NDT(X)
710 NEXT
720 ' NDT=117 SW=1
730 IF NDT>TU(1) THEN 770
740 ' NDT=11 < TU(1)=62 
750 IF NDT<TU(1) THEN L=L+1:LTU(1)=L:SW=1:GOTO 670
760 ' LN=3 length NDT=117
770 Z=NDT:GOSUB 40:LN=L
780 ' TV(1) = 117 - 62 = 55
790 ' TV(2) = 559 - 558 = 1
800 ' TV(3) =  13 -  0 = 13
810 ' TV(4) = 132 - 124 = 8
820 ' TG(1) = 55 x 10 + 9 = 559
830 ' TG(2) =  1 x 10 + 3 =  13
840 ' TG(3) = 13 x 10 + 2 = 132
850 ' TG(4) = 0
860 TV(1)=NDT-TU(1)                     ' 55
870 FOR Y=1 TO QN-1:L=L+1       
880  TG(Y)=TV(Y)*10+CT(L)               ' 559  13  132
890  TV(Y+1)=TG(Y)-TU(Y+1)              ' 1    13  8
900 NEXT:PRINT		
910 ' Calculate lengths of TG(Y) and TU(Y)
920 FOR Y=1 TO QN-1
930  Z=TG(Y):GOSUB 40:LTG(Y)=L
940 NEXT 
950 FOR Y=2 TO QN
960  Z=TU(Y):GOSUB 40:LTU(Y)=L
970 NEXT 
980 ' Send results to screen or diskfile
990 IF ST THEN 1030
1000 PRINT:PRINT TAB(LM) DL;"/";DT;"\";DQ
1010 IF COPY THEN PRINT #1,"":PRINT #1,TAB(LM) DL;"/";DT;"\";DQ
1020 GOTO 1090
1030 LC=LDL+3+(LDT-LDQ)
1040 PRINT:PRINT TAB(LM+LC);DQ:IF COPY THEN PRINT #1,"":PRINT #1,TAB(LM+LC);DQ
1050 LC=LDL+4
1060 PRINT TAB(LM+LC) STRING$(LDT,"Ä") ' line
1070 IF COPY THEN PRINT #1,TAB(LM+LC) STRING$(LDT,"-")
1080 PRINT TAB(LM) DL;")";DT:IF COPY THEN PRINT #1,TAB(LM) DL;")";DT
1090 LC=LDL+LTU(1)+4                     ' LC = 12
1100 IF SW=1 THEN PRINT TAB(LC-LTU(1)+LM) TU(1):L=LN
1110 IF SW=1 AND COPY THEN PRINT #1, TAB(LC-LTU(1)+LM) TU(1):GOTO 1150
1120 IF SW=0 THEN PRINT TAB(LC-LTU(1)+LM-1) TU(1):L=LN
1130 IF SW=0 AND COPY THEN PRINT #1, TAB(LC-LTU(1)+LM-1) TU(1):L=LN
1140 ' ÄÄÄÄ or ----
1150 P=(LC-L+LM):GOSUB 50
1160 ' Skip when TU(Y+1)=0 TU(3)=0 thus skip also TG(2)=13
1170 FOR Y=1 TO QN-1 :LC=LC+1            ' point to  9  3  2
1180  IF TU(Y+1)=0 THEN 1240                     
1190  PRINT TAB(LC-LTG(Y)+LM-1) TG(Y)
1200  IF COPY THEN PRINT #1, TAB(LC-LTG(Y)+LM-1) TG(Y)
1210  PRINT TAB(LC-LTU(Y+1)+LM-1) TU(Y+1)
1220  IF COPY THEN PRINT #1, TAB(LC-LTU(Y+1)+LM-1) TU(Y+1)
1230  L=LTG(Y):P=(LC-L+LM):GOSUB 50
1240 NEXT
1250 ' TV(QN) = remainder 8
1260 Z=TV(QN):GOSUB 40:PRINT TAB(LC-L+LM-1) TV(QN) 
1270 IF COPY THEN PRINT #1, TAB(LC-L+LM-1) TV(QN):PRINT #1,""
1280 PRINT:SW=0:GOTO 350
1290 ' Isolate digits and count the length of the number
1300 L=1 
1310 E=INT(Z/10):A(L)=Z-10*E:IF E<>0 THEN L=L+1:Z=E:GOTO 1310 ELSE RETURN
1320 ' Draw lines ÄÄÄÄ or ----
1330 PRINT TAB(P)"";: PRINT STRING$(L,"Ä")
1340 IF COPY THEN PRINT #1, TAB(P)"";:PRINT #1, STRING$(L,"-")
1350 RETURN
1360 ' Print when DT<DL
1370 IF COPY THEN PRINT #1,"":PRINT #1, TAB(LM) DT;":";DL;"=";DT/DL:GOTO 1280 ELSE 1280
1380 ' Test for a valid number
1390 L=LEN(G$):T=0:IF L>16 THEN 1480
1400 IF LEFT$(G$,1)="0" AND L>1 THEN 1480
1410 IF G$="-1" THEN G$="":M1$=K1$:M2$=K2$:GOTO 230
1420 FOR X=1 TO L
1430  Z=ASC(MID$(G$,X,1)):IF MID$(G$,X,1)="." THEN T=2:GOTO 1450
1440  IF Z<48 OR Z>57 THEN 1480
1450 NEXT
1460 IF T>1 THEN 1480
1470 NG=1:RETURN
1480 NG=0:PRINT:BEEP:RETURN
1490 ' get key
1500 LSET W=MKI$(0)
1510 WHILE CVI(W)=0:MID$(W,1)=INKEY$:WEND:RETURN
1520 ' Exit
1530 IF COPY THEN CLOSE #1
1540 KEY 5,"showdivi.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS
1550 ' Example in this program
1560 ' DL=62  DT=117932
1570 '                        1902   DQ
1580 '                      ÄÄÄÄÄÄ   line
1590 ' NDT  = 117      62 ) 117932               62 / 117932 \ 1902
1600 ' TU(1)= 62             62                        62
1610 '                      ÄÄÄ                       ÄÄÄ
1620 ' TV(1)= 55             559     TG(1)=559
1630 ' TU(2)= 558            558
1640 '                       ÄÄÄ
1650 ' TV(2)= 1    TV(3)=13    132   TG(3)=132
1660 ' TU(4)= 124              124   TU(3)=0
1670 '                         ÄÄÄ
1680 ' TV(QN)=8                  8
