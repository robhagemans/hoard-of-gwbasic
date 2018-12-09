10 ' **************************************
20 ' *       Verify ISBN Checksums        *
30 ' *                                    *
40 ' *   Useful for data entry routines   *
50 ' *      involving International       *
60 ' *       Standard Book Numbers        *
70 ' *                                    *
80 ' *  By Frank Cox   FidoNet 1:140/53   *
90 ' *         September 1, 1991          *
100 '**************************************
110 INPUT "Input ISBN Number";A$
120 FOR X = 1 TO LEN(A$)
130 IF MID$(A$,X,1) >="0" AND MID$(A$,X,1) <="9" THEN B$=B$+MID$(A$,X,1)
140 NEXT X
150 IF RIGHT$(A$,1) = "X" OR RIGHT$(A$,1) = "x" THEN B$=B$ + "X"
160 FOR X= 1 TO LEN(B$)-1
170 CS = CS + VAL(MID$(B$,X,1)) * X
180 NEXT X
190 IF RIGHT$(B$,1) = "X" THEN M = 10 ELSE M = VAL(RIGHT$(B$,1))
200 IF CS MOD 11 = M THEN PRINT "OK" ELSE PRINT "Error"
