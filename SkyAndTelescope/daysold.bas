10 REM DAYSOLD.BAS
20 INPUT "Enter your birthday (M,D,Y)";M,D,Y
30 REM Compute Julian Day Number
40 J=-INT(7*(INT((M+9)/12)+Y)/4)
50 S=SGN(M-9)
60 A=ABS(M-9)
70 J1=INT(Y+S*INT(A/7))
80 J1=-INT((INT(J1/100)+1)*3/4)
90 J=J+INT(275*M/9)+D+J1
100 J=J+1721028+367*Y
110 INPUT "Enter desired age in days ";A9
120 IF A9=0 THEN 280
130 REM Compute calendar date from new JD number
140 J2=J+A9+1
150 A1=INT((J2/36524.25)-51.12264)
160 A=J2+1+A1-INT(A1/4)
170 B=A+1524
180 C=INT((B/365.25)-0.3343)
190 D=INT(365.25*C)
200 E=INT((B-D)/30.61)
210 D=B-D-INT(30.61*E)
220 M=E-1
230 Y=C-4716
240 IF E>13.5 THEN M=M-12
250 IF M<2.5 THEN Y=Y+1
260 PRINT USING "You will be ##### days old on ##/##/####";A9;M;D;Y
270 GOTO 110
280 END
900 REM  ---------------------------
910 REM  APPEARED IN COMPUTERS IN
920 REM  ASTRONOMY, SKY & TELESCOPE,
930 REM  NOVEMBER 2001, PAGE 63
940 REM  ---------------------------
