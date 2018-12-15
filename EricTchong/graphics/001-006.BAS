10 ' 001-006.bas - 6 graphics designs
20 GOTO 70 ' begin
30 SAVE"001-006.bas",A:LIST-160
40 GOTO 350 ' wait for key
50 GOTO 370 ' centered text
60 ' begin
70 CLS:KEY OFF:SCREEN 9
80 DEFSTR M,Q:Q=MKI$(0):DEF FNX(X)=INT(1.55*(50+X)+.5)
90 DIM X(25),Y(25),SX(3),SY(3),ZX(6),ZY(6),XX(5),YY(5),M(10)
100 M(1)="Graphics Designs in GWBASIC"
110 M(2)="Eric Tchong"
120 M(3)=" <1> diagonal web                "
130 M(4)=" <2> moiree effect               "
140 M(5)=" <3> triangles in perspective    "
150 M(6)=" <4> generates written six angles"
160 M(7)=" <5> diagonals for N-angle       "
170 M(8)=" <6> generates written squares   "
180 M(9)="Choose 1..6  -1 = stop program  "
190 FOR I=1 TO 9
200  GOSUB 50
210  IF I=2 OR I=8 THEN PRINT
220 NEXT
230 LOCATE 13,30:INPUT CH:IF CH=-1 THEN 330
240 IF CH<1 OR CH>6 THEN 230 ELSE CLS
250 ON CH GOTO 260,400,490,620,820,970
260 FOR X1=0 TO 320 STEP 40
270  FOR X2=0 TO 320 STEP 40
280   LINE (FNX(X1),0)-(FNX(X2),320),11 ' cyan
290  NEXT
300 NEXT
310 GOSUB 40
320 CLS:GOTO 190
330 SCREEN 0,0,0:KEY ON:END
340 ' wait for key
350 LSET Q=MKI$(0)
360 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND:RETURN
370 ' centered text
380 X=(80-LEN(M(I)))/2
390 PRINT TAB(X) M(I):RETURN
400 FOR J=0 TO 320 STEP 8
410   LINE (FNX(0),0)-(FNX(J),320),10          ' green
420   LINE (FNX(0),0)-(FNX(320),320-J),10
430  NEXT
440  FOR J=0 TO 320 STEP 8
450   LINE (FNX(320),320)-(FNX(0),320-J),10
460   LINE (FNX(320),320)-(FNX(J),0),10
470  NEXT
480 GOTO 310
490 X(0)=0:Y(0)=72
500 SX(1)= 6:SX(2)=20:SX(3)=12
510 SY(1)=12:SY(2)= 9:SY(3)=-6
520 FOR K=0 TO 11 STEP .5
530  FOR J=1 TO 3
540   X(J)=X(0)+K*SX(J)
550   Y(J)=Y(0)+K*SY(J)
560  NEXT
570  LINE (FNX(X(1)),Y(1))-(FNX(X(2)),Y(2)),11 ' cyan
580  LINE (FNX(X(2)),Y(2))-(FNX(X(3)),Y(3)),12 ' red
590  LINE (FNX(X(3)),Y(3))-(FNX(X(1)),Y(1)),14 ' yellow
600 NEXT
610 GOTO 310
620 R=160:U=160:V=160:H=.5:W=60*4*ATN(1)/180
630 FOR J=0 TO 6
640  W1=J*W
650  X(J)=INT(U+R*COS(W1)+H)
660  Y(J)=INT(V-R*SIN(W1)+H)
670 NEXT
680 FOR N=1 TO 20
690  FOR J=0 TO 5
700   LINE (FNX(X(J)),Y(J))-(FNX(X(J+1)),Y(J+1)),15 ' hi-white
710  NEXT
720  FOR K=0 TO 5
730   ZX(K)=INT((X(K)+X(K+1))/2+H)
740   ZY(K)=INT((Y(K)+Y(K+1))/2+H)
750  NEXT
760   ZX(6)=ZX(0):ZY(6)=ZY(0)
770  FOR J=0 TO 6
780    X(J)=ZX(J):Y(J)=ZY(J)
790  NEXT
800 NEXT
810 GOTO 310
820 A=160:B=A:PRINT
830 INPUT "                   How many angles  N<25  0=menu "; N
840 IF N=0 THEN 320 ELSE IF N>25 THEN 830
850 CLS:U=160:V=160:H=.5:W=(360/N)*4*ATN(1)/180
860 FOR J=0 TO N-1
870  W1=J*W
880  X(J)=INT(U+A*COS(W1)+H)
890  Y(J)=INT(V-B*SIN(W1)+H)
900 NEXT
910 FOR I=0 TO N-2
920  FOR J=I+1  TO N-1
930   LINE (FNX(X(I)),Y(I))-(FNX(X(J)),Y(J)),15 ' hi-white
940  NEXT
950 NEXT
960 GOSUB 40:CLS:GOTO 820
970 PRINT
980 INPUT "                   Type 1..20 written squares 0=menu ";K
990 IF K=0 THEN 320 ELSE IF K>20 THEN 980
1000 X(1)=0  :X(2)=320:X(3)=320:X(4)=0:X(5)=0
1010 Y(1)=320:Y(2)=320:Y(3)=0  :Y(4)=0:Y(5)=320:H=.5
1020 CLS
1030 FOR N=1 TO 40
1040  FOR J=1 TO 4
1050   LINE (FNX(X(J)),Y(J))-(FNX(X(J+1)),Y(J+1)),11 ' hi-white
1060  NEXT
1070  FOR J=1 TO 4
1080   XX(J)=X(J)+INT((X(J+1)-X(J))/K+H)
1090   YY(J)=Y(J)+INT((Y(J+1)-Y(J))/K+H)
1100  NEXT
1110  FOR J=1 TO 4
1120   X(J)=XX(J):Y(J)=YY(J)
1130  NEXT
1140  X(5)=X(1):Y(5)=Y(1)
1150 NEXT
1160 GOSUB 40:CLS:GOTO 970
