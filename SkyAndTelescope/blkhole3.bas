10 REM Compute Black-Hole Accelergram
20 P = 3.14159
30 A$="##.### ##.### ##.### ##.###"
40 OPEN "OUTPUT.TXT" FOR OUTPUT AS #1
50 FOR I=0 TO 1000
60 REM Generate random circumference
70 C=2!*P*RND
80 REM Generate random angle
90 T=2!*P*RND: R=C/(2!*P)
100 X1=R*COS(T): Y1=R*SIN(T)
110 REM Determine vector length
120 R=R-.001/(C*C*C)
130 IF R<0 THEN R=0
140 X2=R*COS(T): Y2=R*SIN(T)
150 D=SQR((X2-X1)*(X2-X1)+(Y2-Y1)*(Y2-Y1))
160 REM Don't plot vectors too small to see
170 REM Print end-points for plot package
180 IF D<.001 THEN GOTO 200
190 PRINT#1, USING A$;X1;Y1;X2;Y2
200 NEXT I
210 CLOSE#1
220 REM  ========================
230 REM  FROM "ASTRONOMICAL
240 REM  COMPUTING," SKY & TELE-
250 REM  SCOPE, MAY 1996
260 REM ========================
270 END
