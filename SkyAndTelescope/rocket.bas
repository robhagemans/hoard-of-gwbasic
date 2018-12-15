10 REM ROCKET.BAS by Brian Tung
20 REM
30 DEFDBL A-Z
40 A=1.032: REM Earth gravity in light-years per year squared
50 INPUT "Distance in light-years (0-100 million)"; D
60 IF D>=0 AND D<=100000000 THEN 80
70 PRINT "Distance must be between 0 and 100 million l-y": GOTO 50
80 D1=D/2
90 T=SQR(D1*D1+(2*D1/A))
100 X=A*T
110 M=1: REM Lines 110-180 compute inverse sinh
120 IF X<0 THEN M=-1
130 S=LOG(ABS(X)+1)
140 S1=S+1
150 X1=(EXP(S)-EXP(-S))/2-ABS(X)
160 S1=X1/(EXP(S)+EXP(-S))/2
170 S=S-S1
180 IF ABS(S1)>.0000001 THEN 150
190 T1=1/A*S*M
200 V=A*T/SQR(1+(A*T)*(A*T))
210 PRINT USING "Time on Earth: #########.### years"; 2*T
220 PRINT USING "Time on board: #########.### years"; 2*T1
230 Z$ = "Top speed: #.###"
240 IF D<1 THEN 280
250 Z1=INT(2*LOG(D)/LOG(10))
260 IF D>=1 AND D<10000000 THEN Z$=Z$+STRING$(Z1,"#")
270 IF D>=10000000 THEN Z$=Z$+"#############"
280 Z$=Z$+" c"
290 PRINT USING Z$; V
300 END 
900 REM  ---------------------------
910 REM  APPEARED IN COMPUTERS IN
920 REM  ASTRONOMY, SKY & TELESCOPE,
930 REM  FEBRUARY 2002, PAGE 66
940 REM  ---------------------------

