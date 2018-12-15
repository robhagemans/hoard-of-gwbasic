10 REM                PERPETUAL GREGORIAN CALENDAR
12 REM
14 DIM C$(42), D$(31), E(12)
16 FOR I=1 TO 31: READ D$(I): NEXT I
18 FOR I=1 TO 12: READ E(I):  NEXT I
20 DATA "  1","  2","  3","  4","  5","  6","  7","  8","  9"," 10"
22 DATA " 11"," 12"," 13"," 14"," 15"," 16"," 17"," 18"," 19"," 20"
24 DATA " 21"," 22"," 23"," 24"," 25"," 26"," 27"," 28"," 29"," 30"," 31"
26 DATA 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
28 PRINT:  INPUT "MONTH, YEAR";M,Y:  IF Y<100 THEN Y=Y+1900
30 PRINT:  PRINT " SU MO TU WE TH FR SA":  PRINT
32 J=367*Y-INT(7*(Y+INT((M+9)/12))/4)+INT(275*M/9)+1721031
34 K=0:  IF M<=2 THEN K=-1
36 J=J-INT(3*(INT((Y+K)/100)+1)/4)
38 K=E(M):  IF M<>2 THEN 48
40 W=INT(Y-100*INT(Y/100)):  X=INT(Y-4*INT(Y/4)):  Z=INT(Y-400*INT(Y/400))
42 IF X<>0 THEN 48
44 IF W=0 AND Z<>0 THEN 48
46 K=29
48 X=J-7*INT(J/7)
50 FOR I=1 TO 42: C$(I)="   ":   NEXT I
52 FOR I=1 TO K:  C$(I+X)=D$(I): NEXT I
54 FOR I=1 TO 6:  J=7*I
56 PRINT C$(J-6);C$(J-5);C$(J-4);C$(J-3);C$(J-2);C$(J-1);C$(J)
58 NEXT I
60 PRINT:  INPUT "ANOTHER";A$:  IF A$="Y" THEN 28
62 END
63 REM  ---------------------------------------------------------------
64 REM  APPEARED IN ASTRONOMICAL COMPUTING, SKY & TELESCOPE, JULY, 1985
65 REM  ---------------------------------------------------------------
