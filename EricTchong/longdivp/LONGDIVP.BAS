10  ' longdivp.bas - FreeWare
20 GOTO 160 ' begin                     
30 SAVE"longdivp":LIST-160
40 GOTO 360 ' get key
50 GOTO 400 ' variable random select
60 GOTO 420 ' half second delay
70 GOTO 440 ' print at xx+1,yy+1 I
80 GOTO 450 ' print at xx+1,yy+1 II
90 GOTO 470 ' get a positive number
100 GOTO 490 ' save in X$
110 GOTO 510 ' copy X$ into Y$
120 GOTO 540 ' question mark
130 GOTO 1730 ' letter not found
140 GOTO 1940 ' save to ascii diskfile
150 ' begin
160 TC=40:TB=33:B=80:ML=4:CM=56:RW=2:MS=21:SS=18:KEY OFF
170 RANDOMIZE TIMER:L$=CHR$(45):LL$=L$:L=95:V=41:V$=")":BL$=CHR$(32)
180 DIM A$(18),D$(18),G$(18),DP(18),GM$(3),S$(26),DP$(2):EC$=MKI$(0)
190 MV$="Move? ":GM$(1)="Substitution":GM$(2)="Fill-in":GM$(3)="End":QM$="?"
200 DP$(0)="Current Solution"
210 DP$(1)="Original Puzzle ":DP$(2)="Answer          "
220 PR$=STRING$(SS,32)+"<A>nswer - <P>uzzle - <S>olution - <R>eplay"+STRING$(SS,32)
230 CLS:PRINT"Puzzles are saved to your ascii diskfile ?"
240 LINE INPUT "Enter a DOS filename ? ";Z$
250 IF LEFT$(Z$,1)=" " THEN Z$=MID$(Z$,2):GOTO 250
260 OPEN "O",#1,Z$
270 ' announce us
280 CLS:PRINT TAB(TC-2)"LONG":PRINT STRING$ (B,L$);:PRINT TAB(TC-4)"DIVISION"
290 PRINT:PRINT TAB(TB)"Puzz1e Selection":PRINT
300 FOR X=1 TO 3:PRINT TAB(TB-1) X;GM$(X):NEXT:PRINT:PRINT TAB(TB) "Type number":PRINT
310 GOSUB 40:IF I<1 OR I>3 THEN 310 ELSE IF I=3 THEN 2000
320 GM=I:PRINT GM$(GM):PRINT"Level ( 1 -";ML;")?"
330 GOSUB 40:IF I<1 OR I>ML THEN 330
340 LV=I:PRINT "Generating a level";LV;"puzzle...":GOTO 610
350 ' get key
360 LSET EC$=MKI$(0)
370 WHILE CVI(EC$)=0:MID$(EC$,1)=INKEY$:WEND
380 F=ASC(EC$):I$=CHR$(F):I=VAL(I$):RETURN
390 ' variable random select
400 R=INT(RND*RD)+1:RANDOMIZE TIMER:RETURN
410 ' half second delay
420 ET=TIMER+.5:WHILE TIMER<ET:WEND:RETURN
430 ' print at location xx,yy
440 XX=RM+X:YY=DP(X)
450 LOCATE XX+1,YY+1:RETURN
460 ' get a positive number
470 N#=0:RD=10:FOR X=1 TO T:GOSUB 50:N#=N#*10+R-1:NEXT
480 ' save in X$
490 X$=RIGHT$(STR$(N#),LEN(STR$(N#))-1):TR=LEN(X$):RETURN
500 ' copy X$ into Y$
510 Y$="":IF TR=1 THEN Y$=X$:RETURN
520 FOR Y=1 TO TR-1:Y$=Y$+MID$(X$,Y,1)+" ":NEXT:Y$=Y$+RIGHT$(X$,1):TR=TR*2-1:RETURN
530 ' question mark
540 NB=CH:OK=INT(CH/2):X=1:RD=CH
550 Y=INSTR(X,X$,QM$):IF Y THEN X=Y+1:NB=NB-1:IF X<=LEN(X$) THEN 550
560 IF NB>=OK THEN RETURN
570 FOR X=1 TO LEN(X$) STEP 2
580  IF MID$(X$,X,1)=QM$ THEN GOSUB 50:IF R=1 THEN MID$(X$,X)=MID$(Y$,X,1):NB=NB+1:NQ=NQ-1
590 NEXT:GOTO 560
600 ' get quotient
610 T=LV+1:GOSUB 90:IF TR<2 THEN 610 ELSE Q=N#:Q$=X$:LQ=TR:SW=0
620 ' get divisor
630 RD=LV+1:GOSUB 50:T=R+1:GOSUB 90:IF TR<2 THEN 630 ELSE DV=N#:DV$=X$:LI=TR
640 IF DV>32767 THEN RD=32767 ELSE RD=DV
650 ' get dividend
660 GOSUB 50:N#=Q*DV+R-1:GOSUB 100:DD#=N#:DD$=X$:LD=TR
670 FOR X=1 TO LQ
680  M=VAL(MID$(Q$,X,1))
690  IF M=0 THEN M(X)=M:M$(X)="" ELSE N#=M*DV:GOSUB 100:M(X)=N#:M$(X)=X$
700 NEXT:LS=LEN(M$(1)):PM(1)=0
710 S=VAL(LEFT$(DD$,LS)):IF S<M(1) THEN LS=LS+1:PM(1)=PM(1)+1:GOTO 710
720 N#=S-M(1):GOSUB 100:R$=X$:PR(1)=LS-TR
730 FOR X=2 TO LQ
740  LS=LS+1:R$=R$+MID$(DD$,LS,1):R=VAL(R$):IF M(X)>R THEN 740
750  R$(X-1)=R$:N#=R-M(X):GOSUB 100:R$=X$:PR(X)=LS-TR:PM(X)=LS-LEN(M$(X))
760 NEXT:R$(LQ)=R$
770 X$=Q$:TR=LQ:GOSUB 110
780 Q$=Y$:X$=DV$:TR=LI:GOSUB 110
790 DV$=Y$:LI=TR:X$=DD$:TR=LD:GOSUB 110:DD$=Y$:LD=TR
800 FOR X=1 TO LQ
810  IF M$(X)="" THEN 830
820  X$=M$(X):TR=LEN(X$):GOSUB 110:M$(X)=Y$:PM(X)=PM(X)*2
830  X$=R$(X):TR=LEN(X$):GOSUB 110:R$(X)=Y$:PR(X)=PR(X)*2
840 NEXT
850  A$(0)=Q$:A$(1)=LL$+STRING$(LD+1,L$):A$(2)=DV$+V$+DD$:ND=3
860 FOR X=1 TO LQ
870  IF M$(X)="" THEN SP=LD-LEN(R$(X))-PR(X):A$(ND-1)=R$(X)+STRING$(SP,32):GOTO 910
880  SP=LD-LEN(M$(X))-PM(X):A$(ND)=M$(X)+STRING$(SP,32):ND=ND+1
890  LM=LEN(M$(X)):A$(ND)=STRING$(LM,L$)+STRING$(SP,32):ND=ND+1
900  SP=LD-LEN(R$(X))-PR(X):A$(ND)=R$(X)+STRING$(SP,32):ND=ND+1
910 NEXT:ND=ND-1
920 RM=RW+2*(ML-LV)
930 FOR X=0 TO ND:DP(X)=CM-LEN(A$(X)):NEXT:VL$=""
940 ON GM GOSUB 1320,1470
950 BM=LEN(VL$):FOR X=0 TO ND:G$(X)=D$(X):NEXT:FF=0:MV=0:SV$="Solved: "
960 ' print problem
970 D=1 AND FF
980 CLS:PRINT GM$(GM):PRINT "Level -";LV
990 PRINT:PRINT:PRINT:PRINT "Best =";BM
1000 ON D+1 GOSUB 1690,1700
1010 ' peek at intermediate solutions
1020 IF SW=1 THEN 1030 ELSE 1060
1030 LOCATE 8,1:PRINT A$(0)   ' quotient
1040 LOCATE 9,1:PRINT A$(2)   ' divisor)dividend
1050 LOCATE 10,1:PRINT A$(ND) ' remainder
1060 YY=0:XX=MS-2:GOSUB 80:PRINT DP$(D);
1070 XX=MS+1:GOSUB 80:PRINT SV$;
1080 XX=MS-1:GOSUB 80:PRINT MV$;
1090 ' check player's response
1100 GOSUB 40:PRINT I$;:IF I$="\" THEN SW=1:GOTO 980
1110 IF I$="/" THEN FF=FF+1:GOTO 970
1120 IF I$=QM$ THEN XX=MS:GOSUB 80:PRINT "Unsolved in";MV;"moves";:XX=MS+1:GOSUB 80:PRINT PR$;:D=2:GOTO 1260
1130 XX=MS:GOSUB 80
1140 IF I$<"A" OR I$>"Z" THEN PRINT "Not a valid move. Is CAPS lock on?";:GOSUB 60:GOTO 970
1150 IF INSTR(VL$,I$)=0 THEN PRINT I$;" not in puzzle";:GOSUB 60:GOTO 970
1160 LT$=I$:PRINT LT$;" = ?";:GOSUB 40:PRINT CHR$(29);I$;:IF I$="R" THEN PRINT "eplace";:GOSUB 130:GOTO 970
1170 IF I$<"0" OR I$>"9" THEN PRINT " Invalid move";:GOSUB 60:GOTO 970
1180 MV=MV+1:PRINT CHR$(29);"Inserting ";I$;:GOSUB 60:ON GM GOSUB 1820,1890
1190 FOR X=0 TO ND
1200  IF G$(X)<>A$(X) THEN 970
1210 NEXT
1220 ' player finds a solution
1230 XX=MS:GOSUB 80:PRINT "Congratulations! -";MV;"moves";
1240 XX=MS+1:GOSUB 80:PRINT PR$;
1250 XX=5:GOSUB 80:PRINT "Score:";INT(BM/MV*100);"%";
1260 XX=MS-2:YY=0:GOSUB 80:PRINT DP$(D):GOSUB 140 ' save to diskfile
1270 ON D+1 GOSUB 1690,1700,1710
1280 ' check for R, A, P, or S
1290 GOSUB 40:IF I$="R" THEN 280 ELSE IF I$="A" THEN D=2 ELSE IF I$="P" THEN D=1 ELSE IF I$="S" THEN D=0 ELSE 1290
1300 GOTO 1260
1310 ' substitution
1320 FOR X=1 TO 26:S$(X)=CHR$(64+X):NEXT:RD=26 ' alphabet 65..90
1330 FOR X=0 TO 9
1340  GOSUB 50:IF S$(R)="" THEN 1340
1350  R$(X)=S$(R):S$(R)="":R(X)=0
1360 NEXT
1370 FOR X=0 TO ND
1380  D$(X)=A$(X):IF VAL(A$(X))=0 THEN 1420
1390  FOR Y=1 TO LEN(D$(X)) STEP 2
1400   R=ASC(MID$(D$(X),Y)):IF R>47 AND R<58 THEN MID$(D$(X),Y)=R$(R-48):R(R-48)=1
1410  NEXT
1420 NEXT
1430 FOR X=0 TO 9
1440  IF R(X) THEN VL$=VL$+R$(X)
1450 NEXT:RETURN
1460 ' fill-in
1470 NQ=0:CT=0:RD=3:FOR X=0 TO ND:D$(X)=A$(X):IF VAL(A$(X))=0 THEN 1520
1480 FOR Y=1 TO LEN(D$(X)) STEP 2
1490  R$=MID$(D$(X),Y):IF R$<"0" OR R$>"9" THEN 1510
1500  CT=CT+1:GOSUB 50:IF R>1 THEN MID$(D$(X),Y)=QM$:NQ=NQ+1
1510  NEXT
1520 NEXT
1530 IF RIGHT$(D$(2),1)=QM$ THEN NQ=NQ-1:MID$(D$(2),LEN(D$(2)))=RIGHT$(A$(2),1)
1540 X$=D$(0):Y$=A$(0):CH=INT(LQ/2)+1:GOSUB 120:D$(0)=X$
1550 X$=LEFT$(D$(2),LI):Y$=LEFT$(A$(2),LI):CH=INT(LI/2)+1:GOSUB 120:MID$(D$(2),1)=X$
1560 X$=D$(ND):Y$=A$(ND):CH=INT(LEN(D$(ND))/2)+1:GOSUB 120:D$(ND)=X$:OK=26-(4-LV)*5
1570 IF NQ<=OK THEN 1630 ELSE CH=NQ:GA=NQ-OK:RD=CH
1580 FOR X=3 TO ND-1
1590  IF ASC(D$(X))=L THEN 1620 ELSE Z=1
1600  Y=INSTR(Z,D$(X),QM$):IF Y=0 THEN 1620 ELSE Z=Y+1:GOSUB 50:IF R<=GA THEN MID$(D$(X),Y)=MID$(A$(X),Y,1):NQ=NQ-1
1610  IF Z<=LEN(D$(X)) THEN 1600
1620 NEXT:GOTO 1570
1630 SQ=65
1640 FOR X=0 TO ND
1650  IF ASC(D$(X))=L THEN 1670 ELSE Z=1
1660  Y=INSTR(Z,D$(X),QM$):IF Y THEN Z=Y+1:MID$(D$(X),Y)=CHR$(SQ):VL$=VL$+CHR$(SQ):SQ=SQ+1:IF Z<=LEN(D$(X)) THEN 1660
1670 NEXT:RETURN
1680 ' numbers or letters
1690 FOR X=0 TO ND:GOSUB 70:PRINT G$(X);:NEXT:RETURN ' player's
1700 FOR X=0 TO ND:GOSUB 70:PRINT D$(X);:NEXT:RETURN ' original
1710 FOR X=0 TO ND:GOSUB 70:PRINT A$(X);:NEXT:RETURN ' solution
1720 ' letter not found
1730 Z=8:SC=INSTR(Z,SV$,LT$)
1740 IF SC=0 THEN XX=MS:GOSUB 80:PRINT "Letter not solved";:GOSUB 60:RETURN
1750 SV$=LEFT$(SV$,SC-2)+RIGHT$(SV$,LEN(SV$)-SC)
1760 FOR X=0 TO ND
1770  IF VAL(A$(X))=0 THEN 1800 ELSE Z=1
1780  Y=INSTR(Z,D$(X),LT$)
1790  IF Y THEN Z=Y+1:MID$(G$(X),Y)=LT$:IF Z<=LEN(D$(X)) THEN 1780
1800 NEXT:RETURN
1810 ' substitution 2
1820 FOR X=0 TO ND
1830  IF VAL(A$(X))=0 THEN 1860 ELSE Z=1
1840  Y=INSTR(Z,D$(X),LT$)
1850  IF Y THEN Z=Y+1:MID$(G$(X),Y)=I$:IF Z<=LEN(D$(X)) THEN 1840
1860 NEXT
1870 Z=8:SC=INSTR(Z,SV$,LT$):IF SC THEN RETURN ELSE SV$=SV$+LT$+" ":RETURN
1880 ' fill-in 2
1890 FOR X=0 TO ND
1900  IF VAL(A$(X))=0 THEN 1920
1910  Y=INSTR(D$(X),LT$):IF Y THEN MID$(G$(X),Y)=I$:X=ND
1920 NEXT:GOTO 1870
1930 ' save to ascii diskfile
1940 PRINT #1,GM$(GM);"     Level -";LV;"     Best =";BM
1950 FOR X=0 TO ND:PRINT #1,TAB(DP(X)-22) D$(X):NEXT ' letters only
1960 PRINT #1,"":PRINT #1,""
1970 FOR X=0 TO ND:PRINT #1,TAB(DP(X)-22) A$(X):NEXT ' numbers only
1980 PRINT #1,"":PRINT #1,"":RETURN
1990 ' exit
2000 CLS:PRINT TAB(TC-10)"Thank you for playing.":PRINT:CLOSE #1
2010 KEY 5,"longdivp.bas":KEY 6,CHR$(34)+",a":KEY ON:END
2020 ' Reference 80 Micro - September 1986 - Brain Breakers by Harry Bee
2030 ' Save to ascii disk added by eric tchong
2040 ' Examples:
2050 ' Substitution     Level - 1      Best = 6
2060 '             Q Q                      3 3
2070 '         -------                  -------
2080 '       F F)X Q C                2 2)7 3 4
2090 '           K K                      6 6
2100 '           ---                      ---
2110 '             X C                    7 4
2120 '             K K                    6 6
2130 '             ---                    ---
2140 '               O                      8
2150 ' 
2160 ' Fill-in          Level - 2      Best = 5
2170 '           5 0 9                    5 0 9
2180 '     -----------            -------------
2190 '   8 A)B C 8 1 8            8 6)4 3 8 1 8
2200 '       4 D O                    4 3 0
2210 '       -----                    -----
2220 '           8 1 8                    8 1 8
2230 '           7 7 4                    7 7 4
2240 '           -----                    -----
2250 '             E 4                      4 4
