10  ' wordpuzz.bas - june 18, 2004
20 GOTO 110 ' begin
30 SAVE"wordpuzz":LIST-90
40 GOTO 1410 ' press a key
50 GOTO 1860 ' print @ to locate converter
60 GOTO 1880 ' clear line
70 GOTO 1940 ' print input words
80 GOTO 2100 ' check for a valid lc word
90 GOTO 2320 ' get key
100 ' Announce us
110 CLS:KEY OFF:RANDOMIZE TIMER:DEFSTR Q:Q=MKI$(0)
120 X=16:TW=80:EC=20:COLOR 11,0 ' locals
130 LOCATE 7,X:PRINT "WORD SEARCH PUZZLE GENERATOR"
140 PRINT:PRINT TAB(X) "by Eric Tchong - ARUBA - FREEWARE 2004"
150 COLOR 11,0:LOCATE 16,X:PRINT "For instructions <y/n> ?"
160 GOSUB 90 ' get key
170 IF ASC(Q)=78 OR ASC(Q)=110 OR ASC(Q)=13 THEN 320 ELSE CLS:PRINT:COLOR 15,0
180 PRINT TAB(X) "WORD SEARCH PUZZLE GENERATOR":PRINT:PRINT:COLOR 14,0
190 PRINT TAB(X) "This program takes a set of words and removes"
200 PRINT TAB(X) "all 'non-alphabetic characters out of them,"
210 PRINT TAB(X) "and incorporates them into a word search puzzle."
220 PRINT:COLOR 13,0
230 PRINT TAB(X) "When a particular word does not fit, the program"
240 PRINT TAB(X) "will ask you if it should start the whole puzzle."
250 PRINT TAB(X) "Type 'n' to remove that word.":PRINT:COLOR 11,0
260 PRINT TAB(X) "Try either giving less words or bigger dimensions"
270 PRINT TAB(X) "in your puzzle, when there are more words that"
280 PRINT TAB(X) "won't fit.":COLOR 12,0
290 LOCATE 18,X:PRINT "Press any key to continue...":COLOR 11,0
300 GOSUB 90:PRINT  ' get key
310 ' Get some facts
320 PRINT TAB(X)"";:INPUT "WIDTH of your puzzle <max=32>";W:MD=W:BR=W
330 IF W>32 THEN 320
340 IF W*2<=TW THEN 360
350 PRINT TAB(X) "That will not fit";TW;" columns.":GOTO 320
360 IF W<1 THEN 320
370 PRINT TAB(X)"";:INPUT "LENGTH of your puzzle        ";L:LT=L:IF L>W THEN MD=L
380 IF L<1 THEN 370
390 PRINT TAB(X)"";:INPUT "MAXIMUM words in this puzzle ";M:OVER=M:WD=M
400 IF M>=2 THEN 420
410 PRINT TAB(X)" SORRY; minimal 2 words. ":GOTO 390
420 DIM A$(L,W),W$(M),E$(M)
430 DIM W(M,3),DXY(8,2),DD(28)
440 PRINT TAB(X)"Type a HEADER for this puzzle:"
450 PRINT TAB(16); "("; TW; "characters maximum! )";
460 INPUT XY$:IF LEN(XY$)>TW THEN PRINT:GOTO 440
470 ' Input data
480 CLS:SC=400 ' 400 = 5 x 80      320 = 5 x 64
490 PRINT "OK enter a word after each question mark ?"
500 PRINT "To edit a previous word,   type a hyphen -"
510 PRINT "When you run out of words, type a period ."
520 FOR I=1 TO M
530  GOSUB 60
540  OVER=OVER-1:PRINT "Word ";I;" ---> Over:";OVER;" ";
550  INPUT T$:GOSUB 80
560  IF T$<>"-" THEN 590 ELSE I=I-1:OVER=OVER+1
570  SC=SC-EC:GOSUB 60
580  PRINT "Again "; W$(I); ". . . ";:GOTO 550
590  IF T$="." THEN M=I-1:GOTO 830
600  IF LEN(T$)=0 THEN GOSUB 60:PRINT "Input error; redo: ";
610  IF LEN(T$)=0 THEN 550 ELSE J=1
620  TE$=MID$(T$,J,1):IF TE$>="A" AND TE$<="Z" THEN 700
630  IF TE$<"A" OR TE$>"Z" THEN 660
640  T$=LEFT$(T$,J-1)+CHR$(ASC(MID$(T$,J,1)))+RIGHT$(T$,LEN(T$)-J)
650  GOTO 700
660  IF TE$=T$ THEN T$="":GOTO 600
670  IF J=LEN(T$) THEN T$=LEFT$(T$,J-1):GOTO 730
680  IF J=1 THEN T$=RIGHT$(T$,LEN(T$)-1): J=J-1:GOTO 700
690  T$=LEFT$(T$,J-1)+RIGHT$(T$,LEN(T$)-J):J=J-1
700  J=J+1:IF J<=LEN(T$) THEN 620
710  IF LEN(T$)>MD THEN 780
720   FOR IZ=1 TO I-1:IF W$(IZ)=T$ THEN 790
730   NEXT:GOSUB 50
740  PRINT STRING$(EC+2,32)
750  LOCATE V,Z:PRINT "-";T$;"-";:SC=SC+EC:FL=2
760  IF LEN(T$)+FL>EC THEN SC=SC+EC:FL=FL-EC:GOTO 760
770  GOTO 800
780  GOSUB 60:PRINT "Word is too long; redo: ";:GOTO 550
790  GOSUB 60:PRINT "Duplicate word  ; redo: ";:GOTO 550
800  W$(I)=T$:E$(I)=T$ ' Save original input in E$(I)
810 NEXT
820 ' Design Word Search Puzzle
830 CLS:PRINT "Let me design this in a moment ...."
840 ' Sort words
850 FOR I=1 TO M-1
860  FOR J=I+1 TO M
870   IF LEN(W$(I)) < LEN(W$(J)) THEN HZ$=W$(I):W$(I)=W$(J):W$(J)=HZ$
880  NEXT
890 NEXT
900 ' Read data
910 FOR I=1 TO 8:READ DXY(I,1),DXY(I,2):NEXT
920 FOR I=1 TO 28:READ DD(I):NEXT
930 DATA 0,1,1,1,1,0,1,-1,0,-1,-1,-1,-1,0,-1,1
940 DATA 2,4,6,8,2,4,6,8,2,4,6,8,2,4,6,8,2,4,6,8,2,4,6,8,1,3,5,7
950 ' Assemble words
960 FOR I=1 TO M
970  LN=LEN(W$(I))
980  NT=0
990  SD=DD(INT(RND*28)+1)
1000  SX=INT(RND*W)+1:X1=SX+(LN-1)*DXY(SD,1):IF X1<1 OR X1>W THEN 990
1010  SY=INT(RND*L)+1:X1=SY+(LN-1)*DXY(SD,2):IF X1<1 OR X1>L THEN 990
1020  NT=NT+1:IF NT<>W*L*2 THEN 1080
1030  PRINT "Does not fit '"; W$(I); "' in this puzzle."
1040  PRINT "To start over press <y/n> ? "
1050  A$=INKEY$:IF A$="" THEN 1050
1060  IF A$="Y" OR A$="y" OR A$=CHR$(13) THEN 960
1070  W$(I)="":GOTO 1180
1080  J=SY:K=SX
1090  FOR P=1 TO LN
1100   IF LEN(A$(J,K)) AND A$(J,K)<>MID$(W$(I),P,1) THEN 990
1110   J=J+DXY(SD,2):K=K+DXY(SD,1)
1120  NEXT
1130  J=SY:K=SX
1140  FOR P=1 TO LN:A$(J,K)=MID$(W$(I),P,1)
1150   J=J+DXY(SD,2):K=K+DXY(SD,1)
1160  NEXT
1170  W(I,1)=SX:W(I,2)=SY:W(I,3)=SD
1180 NEXT
1190 ' Add some random letters
1200 FOR I=1 TO L
1210  FOR J=1 TO W
1220   IF A$(I,J)="" THEN A$(I,J)=CHR$(INT(RND*26)+1+64)
1230  NEXT
1240 NEXT
1250 ' Sort again
1260 FOR I=1 TO M-1
1270  FOR J=I+1 TO M
1280   IF W$(I)<=W$(J) THEN 1330
1290   HZ$=W$(I):W$(I)=W$(J):W$(J)=HZ$
1300   FOR K=1 TO 3
1310    HZ=W(I,K):W(I,K)=W(J,K):W(J,K)=HZ
1320   NEXT
1330  NEXT
1340 NEXT
1350 ' Send to screen + diskfile
1360 LINE INPUT "Filename ? ";Z$
1370 IF LEFT$(Z$,1)=" " THEN Z$=MID$(Z$,2):GOTO 1370 ' Remove spaces
1380 OPEN "O",#1,Z$ 
1390 GOSUB 40:GOTO 1750
1400 ' Press a key
1410 PM$="Press any key to continue ... ":PRINT PM$
1420 GOSUB 90 ' get key
1430 T=(TW-2*W)/2:TS=(TW-2*W)/2
1440 PRINT #1,"":PRINT #1,""
1450 ' Header 1
1460 CLS
1470 PRINT    TAB((TW-LEN(XY$))/2);XY$:PRINT #1,TAB((TW-LEN(XY$))/2);XY$
1480 PRINT:PRINT:PRINT #1,"":PRINT #1,""
1490 FOR J=1 TO L
1500  PRINT    TAB(TS);:PRINT #1,TAB(TS);
1510   FOR K=1 TO W:IF A$(J,K)<>"." THEN 1540
1520    PRINT    ". ";:PRINT #1,". ";
1530    GOTO 1550
1540    PRINT A$(J,K); " ";:PRINT #1,A$(J,K); " ";
1550   NEXT
1560  PRINT:PRINT #1,""
1570 NEXT
1580 PRINT:PRINT #1,""
1590 PO=0
1600 PRINT"THE HIDDEM WORDS ARE:":PRINT #1,"THE HIDDEM WORDS ARE:"
1610 PRINT:PRINT #1,""
1620 FOR J=1 TO M
1630  IF LEN(W$(J))=0 THEN 1680
1640  IF POS(0)+LEN(W$(J))>TW-2 THEN PRINT	' screen position
1650  IF PO    +LEN(W$(J))>TW-2 THEN PRINT #1,"":PO=0
1660  PRINT W$(J),:PRINT #1,W$(J),
1670  PO=PO+EC
1680 NEXT
1690 PRINT:PRINT:PRINT #1,"":PRINT #1,""
1700 IF SW=1 THEN GOSUB 70
1710 RETURN
1720 IF LEFT$(X$,1)="j" OR LEFT$(X$,1)="J" THEN 1750
1730 GOTO 1900
1740 ' Header 2
1750 FOR I=1 TO L:FOR J=1 TO W:A$(I,J)=".":NEXT:NEXT
1760 FOR I=1 TO M
1770  LN=LEN(W$(I)):J=W(I,2):K=W(I,1)
1780  FOR P=1 TO LN
1790   A$(J,K)=MID$(W$(I),P,1)
1800   J=J+DXY(W(I,3),2):K=K+DXY(W(I,3),1)
1810  NEXT
1820 NEXT
1830 XY$="HERE ARE THE ANSWERS:":SW=1
1840 GOSUB 40:PRINT:GOTO 1900
1850 ' Print @ to Locate Converter
1860 V=INT(SC/TW)+1:Z=(V-1)*TW:Z=(SC-Z)+1:LOCATE V,Z:RETURN
1870 ' Clear line
1880 LOCATE 4,1:PRINT STRING$(79,32):LOCATE 4,1:RETURN
1890 ' Watch screen before leaving
1900 PRINT "Press <R> to restart, <any key> to quit..."
1910 GOSUB 90 ' get key
1920 IF ASC(Q)=82 OR ASC(Q)=114 THEN CLOSE:RUN ELSE 2350
1930 ' Print input of words
1940 PO=0:PRINT:PRINT #1,""
1950 PRINT "ORIGINAL INPUT":PRINT #1, "ORIGINAL INPUT"
1960 PRINT:PRINT #1,""
1970 FOR J=1 TO M
1980  IF LEN(E$(J))=0 THEN 2030
1990  IF POS(0)+LEN(E$(J))>TW-2 THEN PRINT	' screen position
2000  IF PO    +LEN(E$(J))>TW-2 THEN PRINT #1,"":PO=0
2010  PRINT E$(J),:PRINT #1,E$(J),
2020  PO=PO+EC
2030 NEXT
2040 IF OVER=0 THEN 2050 ELSE WD=WD-OVER-1
2050 PRINT:PRINT:PRINT #1,"":PRINT #1,""
2060 PRINT     "Width =";BR; "    Length =";LT;"    Total words =";WD
2070 PRINT #1, "Width =";BR; "    Length =";LT;"    Total words =";WD
2080 RETURN
2090 ' Check for a valid LC word
2100 IF T$="-" THEN RETURN
2110 IF T$="." THEN RETURN
2120 ' test for non-alphabetic words
2130 BL=LEN(T$)
2140 FOR A=1 TO BL
2150  Z=ASC(MID$(T$,A,1)):IF Z<65 OR Z>122 THEN A=99
2160 NEXT
2170 IF A=100 THEN RETURN ' non-alphabetic
2180 FOR A=1 TO BL
2190  Z=ASC(MID$(T$,A,1))
2200  FOR C=91 TO 96:IF Z=C THEN C=97
2210  NEXT
2220  IF C=98 THEN A=99
2230 NEXT
2240 IF A=100 THEN RETURN ' non-alphabetic
2250 ' word is all LC
2260 M$=""
2270 FOR A=1 TO BL
2280  Z=ASC(MID$(T$,A,1)):IF Z>96 THEN B=Z-32 ELSE B=Z
2290  M$=M$+CHR$(B)
2300 NEXT:T$=M$:RETURN
2310 ' get key
2320 LSET Q=MKI$(0)
2330 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND:RETURN
2340 ' exit
2350 CLOSE:KEY 5,"wordpuzz.bas":KEY 6,CHR$(34)+",a"
2360 COLOR 7,0:KEY ON:CLS
