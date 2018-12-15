10  ' factdivi.bas - FREEWARE
20 GOTO 60 ' begin
30 SAVE"factdivi":LIST-60
40 GOTO 850 ' clear line
50 ' begin
60 CLS:KEY OFF:L=300:DIM FA(L),EX(L),A(L),B(L):LM=1
70 L$(1)="#":L$(2)="##":L$(3)="###":L$(4)="####":L$(5)="#####":L$(6)="######"
80 PRINT "Calculate factors, divisors from number 1 to 999999"
90 PRINT "    =====> Enter or <1 exits programs <=====":PRINT
100 PRINT "Save results in the FACTDIVI.ASC diskfile <y/n> ?":PRINT
110 W$=INKEY$:IF W$="" THEN 110
120 IF W$="Y" OR W$="y" THEN COPY=1 ELSE COPY=0
130 IF COPY THEN OPEN "O",#1,"factdivi.asc"
140 INPUT "Number  ";N
150 IF N<1 THEN 920
160 IF N>999999! THEN GOSUB 40:GOTO 140 ELSE GOSUB 40 ' clear line
170 ' print if prime
180 P=1
190 P=P+1:IF P>3 THEN P=P+1
200 IF P*P>N THEN 880
210 IF N/P<>INT(N/P) THEN 190
220 TL=0:T=0:W=N
230 ' store factors in FA(T)
240 F=1
250 F=F+1
260 IF F>3 THEN F=F+1
270 IF F*F>N THEN F=N:GOTO 290
280 IF N/F<>INT(N/F) THEN 250
290 IF F>TL THEN TL=F:T=T+1:E=0:FA(T)=F
300 ' store exponents in EX(T)
310 E=E+1:EX(T)=E:N=N/F:IF N=1 THEN 340
320 GOTO 240	
330 ' send results to screen or ascii file
340 F$="":F$=F$+STR$(W)+" ="  
350 FOR K=1 TO T
360  F$=F$+STR$(FA(K)):EC=LEN(F$)
370  IF EX(K)=1 THEN 400 ' skip if exponent = 1
380  PRINT TAB(EC+LM-1) EX(K);:F$=F$+" "         ' print exponents
390  IF COPY THEN PRINT #1,TAB(EC+LM-1) EX(K);
400  IF K=T THEN 410 ELSE F$=F$+" *"             ' assemble factors
410 NEXT
420 PRINT:IF COPY THEN PRINT #1,""               ' CRLF
430 PRINT TAB(LM) F$:IF COPY THEN PRINT #1, TAB(LM) F$ ' print factors
440 ' check if number has only 2 factors
450 P=0
460 F=1
470 F=F+1: IF F>3 THEN F=F+1
480 IF F*F>N THEN F=N:GOTO 500
490 IF N/F<>INT(N/F) THEN 470
500 P=P+1:A(P)=F:N=N/F
510 IF N=1 THEN 520 ELSE GOTO 460
520 N=W:IF P=2 THEN 770 ' p=2 it has 2 factors
530 ' count digits
540 L=1:Z=N
550 E=INT(Z/10):IF E<>0 THEN L=L+1:Z=E:GOTO 550
560 ' can you square it
570 X=SQR(N):Z=(X+N/X)/2:IF INT(Z)<>Z THEN DV=0:GOTO 590 ELSE DV=-1
580 ' calculate divisors
590 A(1)=1:B(1)=N:X=2
600 FOR D=2 TO INT(SQR(N))
610  IF N/D=INT(N/D) THEN A(X)=D:B(X)=N/D:X=X+1
620 NEXT
630 ' show results
640 PRINT (X-1)*2+DV;"divisors"
650 IF COPY THEN PRINT #1,(X-1)*2+DV;"divisors"
660 FOR Y=1 TO X-1
670  PRINT USING L$(3);A(Y);:PRINT " * ";
680  IF COPY THEN PRINT #1,USING L$(3);A(Y);:PRINT #1," * ";
690  PRINT USING L$(L);B(Y);:PRINT "   ";
700  IF COPY THEN PRINT #1,USING L$(L);B(Y);:PRINT #1,"   ";
710  IF Y/5=INT(Y/5) THEN PRINT:IF COPY THEN PRINT #1,""
720 NEXT
730 IF (Y-1)/5=INT((Y-1)/5) THEN 740 ELSE PRINT
740 PRINT:IF COPY THEN PRINT #1,"":PRINT #1,""
750 GOTO 140
760 ' it has only 2 factors
770 X=SQR(N):Z=(X+N/X)/2:IF INT(Z)<>Z THEN DV=4 ELSE DV=3
780 PRINT DV;"divisors"
790 IF COPY THEN PRINT #1,N; DV;"divisors"
800 PRINT "  1 *";W;"   ";A(1);"*";A(2)
810 IF COPY THEN PRINT #1,"  1 *";W;"    ";A(1);"*";A(2)
820 PRINT:IF COPY THEN PRINT #1,""
830 GOTO 140
840 ' clear line
850 PRINT CHR$(30);:PRINT STRING$(79,32);:PRINT CHR$(30)
860 RETURN
870 ' it's a prime
880 PRINT N;"is a prime":PRINT
890 IF COPY THEN PRINT #1, N;"is a prime":PRINT #1,""
900 GOTO 140
910 ' exit
920 IF COPY THEN CLOSE #1
930 KEY 5,"factdivi.bas":KEY 6,CHR$(34)+",a":KEY ON:CLS
940 ' April 3, 2004 (Alejandro+Soli+Alberto * Venezuela)
