10 ' starmov.bas
20 GOTO 70
30 SAVE "starmov.bas",A:LIST-70
40 GOTO 390 ' wait for key
50 GOTO 420 ' centered text
60 ' begin
70 DEFSTR M,Q:Q=MKI$(0):SCREEN 12:CLS:KEY OFF
80 DIM X(7),Y(7),ST%(496):XM=320:YM=240:PI=4*ATN(1) ' locals
90 M(1)="MOVING STARS idea from Hans Lauwerier"
100 M(2)="Quick- or PowerBasic"
110 M(3)="<Esc> exits program"
120 M(4)="Press key to start the show..."
130 FOR I=1 TO 4
140  GOSUB 50
150 IF I=3 THEN PRINT
160 NEXT
170 GOSUB 40
180 ' a star
190 FOR K=0 TO 6
200  X(K)=40+16*COS(2*K*PI/7)
210  Y(K)=40+12*SIN(2*K*PI/7)
220 NEXT
230 FOR K=0 TO 6:L=(K+4) MOD 7
240  LINE (X(K),Y(K))-(X(L),Y(L)),14
250 NEXT
260 GET (20,20)-(60,60),ST%:CLS:K=0
270 ' main program
280 LSET Q=MKI$(0)
290 WHILE CVI(Q)=0
300  X=XM+240*COS(K*PI/25):Y=YM+180*SIN(K*PI/30)
310  PUT (X,Y),ST%:PUT (2*XM-X,Y),ST%
320  MID$(Q,1)=INKEY$:IF CVI(Q) THEN 340
330  K=K+1:IF K=2000 THEN 370
340 WEND
350 IF ASC(Q)=27 THEN 370
360 GOTO 280
370 SCREEN 0,0,0:CLS:END
380 ' wait for key
390 LSET Q=MKI$(0)
400 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND:RETURN
410 ' centered text
420 X=(80-LEN(M(I)))/2
430 PRINT TAB(X) M(I):RETURN
