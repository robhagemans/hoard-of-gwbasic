10 ' turtgrph.bas - FreeWare 2005
20 GOTO 90 ' begin
30 SAVE "turtgrph.bas",A:LIST-90
40 GOTO 470  ' wait for key
50 GOTO 500  ' centered text
60 GOTO 1330 ' graphics
70 GOTO 1710 ' assemble WEG$
80 ' begin 
90 SCREEN  9:CLS:DEFSTR M,Q:Q=MKI$(0):DIM M(12):PI=4*ATN(1)
100 M(1)="TURTLE GRAPHICS idea from Hans Lauwerier"
110 M(2)="Runs best in Quick- or Powerbasic - Eric Tchong"
120 M(3)="Press any key to return to this screen"
130 M(4)="<1> von Koch's line              "
140 M(5)="<2> Mandelbrot's archipel        "
150 M(6)="<3> variation on von Koch's line "
160 M(7)="<4> islands of von Koch          "
170 M(8)="<5> islands of von Koch as a tile"
180 M(9)="<6> a wall of fractal tiles      "
190 M(10)="<7> line of Minkowski            "
200 M(11)="<8> square of Sierpinski         "
210 M(12)="Choose 1..8   -1 = stop program "
220 ' main
230 FOR I=1 TO 12
240  GOSUB 50:IF I=3 OR I=11 THEN PRINT
250 NEXT
260 LOCATE 15,29:INPUT CH
270 IF CH=-1 THEN SCREEN 0,0,0:CLS:END
280 IF CH<1 OR CH>8 THEN 260
290 CLS:ON CH GOTO 310,520,770,890,1040,1200,1430,1590
300 ' von Koch's line                            <1>
310 WINDOW (-4,-3)-(4,3)
320 CLS:INPUT "Choose 1..6   0 = menu ";NMAX:CLS
330 IF NMAX=0 THEN GOTO 230
340 IF NMAX<1 OR NMAX>6 THEN 320
350 AXIOM$="F":WEG$=AXIOM$:PROD$="F+F--F+F":NMAX=NMAX-1
360 X=-3:Y=-.5:H=6/3^NMAX
370 GOSUB 70 ' assemble WEG$
380 A=COS(PI/3):B=SIN(PI/3)
390 P=1:T=0:PSET(X,Y)
400 FOR I=1 TO LEN(WEG$)
410  S$=MID$(WEG$,I,1)
420  IF S$="+" THEN P1=A*P-B*T:T1= B*P+A*T:P=P1:T=T1
430  IF S$="-" THEN P1=A*P+B*T:T1=-B*P+A*T:P=P1:T=T1
440  IF S$="F" THEN X=X+H*P:Y=Y+H*T:LINE-(X,Y)
450 NEXT:GOSUB 40:GOTO 320
460 ' wait for key
470 LSET Q=MKI$(0)
480 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND:RETURN
490 ' centered text
500 X=(80-LEN(M(I)))/2:PRINT TAB(X) M(I):RETURN
510 ' Mandelbrot's archipel                      <2>
520 WINDOW (-4,-3)-(4,3):NMAX=2
530 X=-1:Y=-1:PHI=0:H=.06
540 AXIOM$="F+F+F+F":WEG$=AXIOM$
550 PROD1$="F-f+FF-F-FF-Ff-FF+f-FF+F+FF+Ff+FFF"
560 PROD2$="ffffff"
570 FOR N=1 TO NMAX
580  W$=""
590  FOR I=1 TO LEN(WEG$)
600   S$=MID$(WEG$,I,1)
610   IF S$="F" THEN T$=PROD1$
620   IF S$="f" THEN T$=PROD2$
630   IF S$="+" OR S$="-" THEN T$=S$
640   W$=W$+T$
650  NEXT
660  WEG$=W$
670 NEXT
680 PSET(X,Y)
690 FOR I=1 TO LEN(WEG$)
700  S$=MID$(WEG$,I,1)
710  IF S$="+" THEN PHI=PHI+PI/2
720  IF S$="-" THEN PHI=PHI-PI/2
730  IF S$="F" THEN X=X+H*COS(PHI):Y=Y+H*SIN(PHI):LINE -(X,Y)
740  IF S$="f" THEN X=X+H*COS(PHI):Y=Y+H*SIN(PHI):PSET (X,Y),0
750 NEXT:GOSUB 40:CLS:GOTO 230
760 ' quadratic variation of von Koch's line     <3> 
770 WINDOW (-.6,-.3)-(.6,.6)
780 NMAX=4:X=-.5:Y=0:PHI=0:H=.0125
790 AXIOM$="F":WEG$=AXIOM$:PROD$="F+F-F-F+F"
800 GOSUB 70 ' assemble WEG$
810 PSET(X,Y)
820 FOR I=1 TO LEN(WEG$)
830  S$=MID$(WEG$,I,1)
840  IF S$="+" THEN PHI=PHI+PI/2
850  IF S$="-" THEN PHI=PHI-PI/2
860  IF S$="F" THEN X=X+H*COS(PHI):Y=Y+H*SIN(PHI):LINE -(X,Y)
870 NEXT:GOSUB 40:CLS:GOTO 230
880 ' snowflake, islands of Von Koch            <4> 
890 WINDOW (-2.4,-1.8)-(2.4,1.8):NMAX=4
900 H=2/3^NMAX:X=-1:Y=-SQR(3)
910 AXIOM$="F+F+F+F+F+F":WEG$=AXIOM$:PROD$="F+F--F+F"
920 GOSUB 70 ' assemble WEG$
930 A=COS(PI/3):B=SIN(PI/3)
940 FOR J=0 TO 4
950  H=.7*H:X=.7*X:Y=.7*Y:P=1:T=0:PSET (X,Y)
960  FOR I=1 TO LEN(WEG$)
970   S$=MID$(WEG$,I,1)
980   IF S$="+" THEN P1=A*P-B*T:T1= B*P+A*T:P=P1:T=T1
990   IF S$="-" THEN P1=A*P+B*T:T1=-B*P+A*T:P=P1:T=T1
1000   IF S$="F" THEN X=X+H*P:Y=Y+H*T:LINE -(X,Y)
1010  NEXT
1020 NEXT:GOSUB 40:CLS:GOTO 230
1030 ' islands of von Koch as a tile             <5>
1040 WINDOW (-2.4,-1.8)-(2.4,1.8):NMAX=4
1050 A=2/SQR(5):B=1/SQR(5):X=-1:Y=1:H=2*B^NMAX
1060 AXIOM$="FRFRFRF":WEG$=AXIOM$:PROD$="-FLFRF+"
1070 GOSUB 70 ' assemble WEG$
1080 A=2/SQR(5):B=1/SQR(5):P=1:T=0:PSET(X,Y),4
1090 FOR I=1 TO LEN(WEG$)
1100  S$=MID$(WEG$,I,1)
1110  IF S$="L" THEN P1=-T:T1=P :P=P1:T=T1:
1120  IF S$="R" THEN P1=T :T1=-P:P=P1:T=T1
1130  IF S$="+" THEN P1=A*P-B*T:T1= B*P+A*T:P=P1:T=T1
1140  IF S$="-" THEN P1=A*P+B*T:T1=-B*P+A*T:P=P1:T=T1
1150  IF S$="F" THEN X=X+H*P:Y=Y+H*T:LINE -(X,Y),4
1160 NEXT
1170 PAINT (0,0),4:LINE (-1,-1)-(1,1),14,B
1180 GOSUB 40:CLS:GOTO 230
1190 ' a wall of fractal tiles                   <6>
1200 WINDOW (-22,-20)-(26,16):NMAX=4:RANDOMIZE TIMER
1210 A=2/SQR(5):B=1/SQR(5):H=4*B^NMAX
1220 AXIOM$="FRFRFRF":WEG$=AXIOM$:PROD$="-FLFRF+"
1230 GOSUB 70 ' assemble WEG$
1240 FOR IH=-4 TO 4
1250  FOR IV=-3 TO 3
1260   COL=1+INT(RND*14)
1270   X=4*IH:Y=4*IV
1280   GOSUB 60 ' graphics
1290   PAINT (4*IH+1,4*IV-1),COL
1300  NEXT
1310 NEXT:GOSUB 40:CLS:GOTO 230
1320 ' graphics
1330 P=1:T=0:PSET(X,Y),COL
1340 FOR I=1 TO LEN(WEG$)
1350  S$=MID$(WEG$,I,1)
1360  IF S$="L" THEN P1=-T:T1=P :P=P1:T=T1
1370  IF S$="R" THEN P1=T :T1=-P:P=P1:T=T1
1380  IF S$="+" THEN P1=A*P-B*T:T1= B*P+A*T:P=P1:T=T1
1390  IF S$="-" THEN P1=A*P+B*T:T1=-B*P+A*T:P=P1:T=T1
1400  IF S$="F" THEN X=X+H*P:Y=Y+H*T:LINE -(X,Y),COL
1410 NEXT:RETURN
1420 ' line of Minkowski                         <7>
1430 WINDOW (-4,-3)-(4,3)
1440 PRINT"Choose order 1..4   0 = menu"
1450 INPUT"order = ",NMAX:CLS
1460 IF NMAX=0 THEN CLS:GOTO 230
1470 IF NMAX<1 OR NMAX>4 THEN 1440
1480 X=-3:Y=0:H=6/4^NMAX
1490 AXIOM$="F":WEG$=AXIOM$:PROD$="F-F+F+FF-F-F+F"
1500 GOSUB 70 ' assemble WEG$
1510 P=1:T=0:PSET (X,Y)
1520 FOR I=1 TO LEN(WEG$)
1530  S$=MID$(WEG$,I,1)
1540  IF S$="+" THEN P1=-T:T1=P :P=P1:T=T1
1550  IF S$="-" THEN P1=T :T1=-P:P=P1:T=T1
1560  IF S$="F" THEN X=X+H*P:Y=Y+H*T:LINE -(X,Y)
1570 NEXT:GOSUB 40:CLS:GOTO 1440
1580 ' square of Sierpinski                      <8>
1590 WINDOW (-4,-3)-(4,3):NMAX=3
1600 X=-1.5:Y=-1.5:H=.12
1610 AXIOM$="F+F+F+F":WEG$=AXIOM$:PROD$="FF+F+F+F+FF"
1620 GOSUB 70 ' assemble WEG$
1630 PSET (X,Y):P=1:T=0
1640 FOR I=1 TO LEN(WEG$)
1650  S$=MID$(WEG$,I,1)
1660  IF S$="+" THEN P1=-T:T1=P: P=P1:T=T1
1670  IF S$="-" THEN P1=T :T1=-P:P=P1:T=T1
1680  IF S$="F" THEN X=X+H*P:Y=Y+H*T:LINE -(X,Y)
1690 NEXT:GOSUB 40:CLS:GOTO 230
1700 ' assemble WEG$
1710 FOR N=1 TO NMAX
1720  W$=""
1730  FOR I=1 TO LEN(WEG$)
1740   S$=MID$(WEG$,I,1)
1750   IF S$="F" THEN T$=PROD$ ELSE T$=S$
1760   W$=W$+T$
1770  NEXT
1780  WEG$=W$
1790 NEXT:RETURN
