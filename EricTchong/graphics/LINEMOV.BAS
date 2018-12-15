10 ' linemov.bas
20 GOTO 70
30 SAVE "linemov.bas",A:LIST-70
40 GOTO 360 ' wait for key
50 GOTO 390 ' centered text
60 ' begin
70 SCREEN 9:CLS:DEFSTR M,Q:Q=MKI$(0)
80 WINDOW (-320,-240)-(319,239)
90 DEFDBL H,C,T:DEFINT X,Y
100 F=200:A=1.35:T0=2:H=.01:C=.5:T=0
110 M(1)="MOVING LINES idea from Hans Lauwerier"
120 M(2)="GWBasic, Quick- or PowerBasic"
130 M(3)="<Esc> exits program"
140 M(4)="Press key to start the show..."
150 FOR I=1 TO 4
160  GOSUB 50
170 IF I=3 THEN PRINT
180 NEXT
190 GOSUB 40:CLS
200 ' main program
210 LSET Q=MKI$(0)
220 WHILE CVI(Q)=0
230  X0=F*SIN(T-T0):Y0=F*SIN(A*(T-T0)+C)
240  X1=F*SIN(T):Y1=F*SIN(A*T+C)
250  X2=F*SIN(T+T0):Y2=F*SIN(A*(T+T0)+C)
260  LINE (X0,Y0)-(X1,Y1),0
270  LINE (X1,Y1)-(X2,Y2)
280  T=T+H:IF T>100 THEN 330
290  MID$(Q,1)=INKEY$:IF CVI(Q) THEN 300
300 WEND
310  IF ASC(Q)=27 THEN 330
320 GOTO 210
330 SCREEN 0,0,0:CLS
340 END
350 ' wait for key
360 LSET Q=MKI$(0)
370 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND:RETURN
380 ' centered text
390 X=(80-LEN(M(I)))/2
400 PRINT TAB(X) M(I):RETURN
