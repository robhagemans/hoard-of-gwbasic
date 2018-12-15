10 REM       FOUCAULT MIRROR TEST AT FOUR ZONES
20 REM
30 DIM A(4,9)
40 INPUT "Mirror's diameter   ";W
50 INPUT "Radius of curvature";RR
60 R=W/2
70 Z1=.3: Z2=.6: Z3=.8: Z4=.95: REM  ZONES
80 X1=Z1*R: X2=Z2*R: X3=Z3*R: X4=Z4*R
90 L=.000022: REM  WAVELENGTH IN INCHES
100 INPUT "Four zonal measurements";V1,V2,V3,V4
110 F1=(X1/(2*RR*RR*L))*(X1*X1/RR-V1)
120 F2=(X2/(2*RR*RR*L))*(X2*X2/RR-V2)
130 F3=(X3/(2*RR*RR*L))*(X3*X3/RR-V3)
140 F4=(X4/(2*RR*RR*L))*(X4*X4/RR-V4)
150 A1=(X1)^7: B1=(X1)^5: C1=(X1)^3: D1=X1
160 A2=(X2)^7: B2=(X2)^5: C2=(X2)^3: D2=X2
170 A3=(X3)^7: B3=(X3)^5: C3=(X3)^3: D3=X3
180 A4=(X4)^7: B4=(X4)^5: C4=(X4)^3: D4=X4
190 M(1,1)=A1: M(1,2)=B1: M(1,3)=C1: M(1,4)=D1
200 M(2,1)=A2: M(2,2)=B2: M(2,3)=C2: M(2,4)=D2
210 M(3,1)=A3: M(3,2)=B3: M(3,3)=C3: M(3,4)=D3
220 M(4,1)=A4: M(4,2)=B4: M(4,3)=C4: M(4,4)=D4
230 M(1,5)=F1: M(2,5)=F2: M(3,5)=F3: M(4,5)=F4
240 N=4: GOSUB 480: H=0: L=0
250 A=M(1,5): B=M(2,5): C=M(3,5): D=M(4,5)
260 D=-A*R^6/4-B*R^4/3-C*R^2/2
270 GOSUB 570: LINE (H0,YC)-(H0+1,YC)
280 FOR I=0 TO 1.001 STEP .05
290 X=I*R:  Y=A*X^8/8+B*X^6/6+C*X^4/4+D*X^2/2
300 LINE -(H0+I*W1,YC-Y*W1)
310 REM PRINT "Zone ";I;TAB(20);"Surface error ";Y
320 IF Y>HI THEN HI=Y
330 IF Y<LO THEN LO=Y
340 NEXT I
350 PRINT
360 PRINT USING "Coefficient D:  ###.####";D
370 PRINT USING "Surface error:  ###.###";HI-LO
380 PRINT USING "Wavefront error:###.###";2*(HI-LO)
390 PRINT
400 INPUT "Want to try a different D (y or n)";Q$
410 IF Q$<>"y" AND Q$<>"Y" THEN 440
420 INPUT "New value for D";D
430 HI=0: LO=0: GOTO 270
440 END
450 REM   Solve 4 linear equations for 4 unknowns
460 REM       (BYTE, August, 1983, page 396)
470 DE=1
480 Y=N+1: FOR X=1 TO N: Y=Y+1: M(X,Y)=1: NEXT X
490 FOR G=1 TO N
500 J=2*N+1: DV=M(G,G): DE=DE*DV
510 FOR H=1 TO J: M(G,H)=M(G,H)/DV: NEXT H
520 FOR S=1 TO N
530 Q=M(S,G): IF S=G THEN 550
540 FOR T=1 TO J: M(S,T)=M(S,T)-M(G,T)*Q: NEXT T
550 NEXT S: NEXT G
560 RETURN
570 REM         PREPARE CHART
580 CLS: SCREEN 9 : Y1=85: Y2=95: YC=90
590 W1=400: H0=100: H1=110: H3=H0+W1
600 P1=H0+W1*Z1:P2=H0+W1*Z2:P3=H0+W1*Z3:P4=H0+W1*Z4
610 LINE (H0,10)-(H0,170): LINE (H0,YC)-(H3,YC)
620 LINE (H0,10)-(H1,10): LINE (H0,50)-(H1,50)
630 LINE (H0,130)-(H1,130): LINE (H0,170)-(H1,170)
640 LINE (P1,Y1)-(P1,Y2): LINE (P2,Y1)-(P2,Y2)
650 LINE (P3,Y1)-(P3,Y2): LINE (P4,Y1)-(P4,Y2)
660 LINE (H3,Y1)-(H3,Y2)
670 LOCATE 1,1: PRINT "+0.2 wave"
680 LOCATE 4,1: PRINT "+0.1 wave"
690 LOCATE 7,1: PRINT "   0 wave"
700 LOCATE 10,1: PRINT "-0.1 wave"
710 LOCATE 13,1: PRINT "-0.2 wave"
720 LOCATE 14,13: PRINT "Center"
730 LOCATE 14,61: PRINT "Edge"
740 RETURN
800 REM
810 REM  For IBM PCs with VGA graphics, this 
820 REM  program analyzes the results of a 
830 REM  Foucault knife-edge test of a parab-
840 REM  oloidal telescope mirror, giving the
850 REM  surface and wavefront error in wave-
860 REM  lengths of light.  Written by Roger
870 REM  Sinnott, it is discussed in Sky & 
880 REM  Telescope magazine for February, 1990,
890 REM  page 195.
