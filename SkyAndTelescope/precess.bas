10 REM    Rigorous Precession
20 REM      (J2000.0)
30 DEFDBL A-Z
40 Q1$="## ## ##.###"
50 Q2$="## ## ##.##"
60 Q3$="##.####": Q4$="##.###"
70 P1=4#*ATN(1#): R1=P1/180#
80 E0=2000#: A$="A"
90 CLS
100 INPUT "Initial epoch (yr)";IE
110 INPUT "Final epoch (yr)  ";FE
120 IF ABS(IE-FE)<=500 THEN 150
130 PRINT "Time span too long"
140 GOTO 110
150 CLS: GOSUB 660
155 IF A$="n" OR A$="N" THEN 210
160 PRINT "Initial epoch ";IE
170 PRINT "  R.A. (h,m,s)";
180 GOSUB 530: A=V
190 PRINT "  Dec. (d,m,s)";
200 GOSUB 530: D=V
210 MA=0: MD=0: GOSUB 970
220 A2=A1: D2=D1
225 IF A$="n" OR A$="N" THEN 270
230 PRINT "Proper motion in"
240 INPUT "  R.A. (sec/yr)   ";M1
250 INPUT "  Dec. (arcsec/yr)";M2
260 PRINT
270 MA=M1: MD=M2: GOSUB 970
280 V=A1: GOSUB 590
290 PRINT "Final epoch ";FE
300 PRINT "  R.A. (h,m,s): ";
310 PRINT USING Q1$;V1;V2;V3
320 V=D1: GOSUB 590
330 PRINT "  Dec. (d,m,s): ";S$;
340 PRINT USING Q2$;V1;V2;V3
350 A3=(A1-A2)*3600/NY
360 D3=(D1-D2)*3600/NY
370 PRINT "Proper motion in"
380 PRINT "  R.A. (sec/yr):   ";
390 PRINT USING Q3$;A3
400 PRINT "  Dec. (arcsec/yr):";
410 PRINT USING Q4$;D3
420 PRINT
430 PRINT "Select one:"
440 PRINT "  (A)nother star"
450 PRINT "  (N)ew final epoch"
460 PRINT "  (Q)uit"
470 INPUT A$
480 IF A$="a" OR A$="A" THEN 150
490 IF A$="n" OR A$="N" THEN 110
500 IF A$="q" OR A$="Q" THEN 520
510 GOTO 470
520 END
530 REM  INPUT SEXAGESIMAL
540 S=1: INPUT V$,V2,V3
550 IF LEFT$(V$,1)="-" THEN S=-1
560 V1=ABS(VAL(V$))
570 V=S*(V1+V2/60+V3/3600)
580 RETURN
590 REM  OUTPUT SEXAGESIMAL
600 S$="+": IF V<0 THEN S$="-"
610 V=ABS(V): V1=INT(V)
620 VM=60*(V-V1): V2=INT(VM)
630 V3=60*(VM-V2)
640 RETURN
650 REM
660 REM  Precession parameters
670 NY=FE-IE
680 T0=(IE-E0)/100: T1=NY/100
690 T2=T1*T1:       T3=T1*T1*T1
700 H1=2306.2181#:  H2=1.39656
710 H3=-0.000139:   H4=0.30188
720 H5=-0.000345:   H6=0.017998
730 K1=1.09468:     K2=0.000066
740 K3=0.018203
750 L1=2004.3109#:  L2=-0.8533
760 L3=-0.000217:   L4=-0.42665
770 L5=-0.000217:   L6=-0.041833
780 W=  (H1 +H2*T0 +H3*T0*T0)*T1
790 ZT= W +(H4 +H5*T0)*T2 +H6*T3
800 ZD= W +(K1 +K2*T0)*T2 +K3*T3
810 TH= (L1 +L2*T0 +L3*T0*T0)*T1
820 TH= TH+(L4 +L5*T0)*T2 +L6*T3
830 ZT=ZT*R1/3600: ZD=ZD*R1/3600
840 TH=TH*R1/3600
850 REM  ZT,ZD,TH = Euler angles
860 REM
870 REM  Rotation matrix
880 S1=SIN(ZT): C1=COS(ZT)
890 S2=SIN(ZD): C2=COS(ZD)
900 S3=SIN(TH): C3=COS(TH)
910 XX=C1*C3*C2-S1*S2
920  YX=-S1*C3*C2-C1*S2: ZX=-S3*C2
930 XY=C1*C3*S2+S1*C2
940  YY=-S1*C3*S2+C1*C2: ZY=-S3*S2
950 XZ=C1*S3: YZ=-S1*S3: ZZ=C3
960 RETURN
970 REM  Proper-motion correction
980 A0=(A+MA*NY/3600)*15*R1
990 D0=(D+MD*NY/3600)*R1
1000 REM
1010 REM  Spherical--> rectangular
1020 SA=SIN(A0): CA=COS(A0)
1030 SD=SIN(D0): CD=COS(D0)
1040 X0=CA*CD: Y0=SA*CD: Z0=SD
1050 REM   3-D transformation
1060 X1=X0*XX+Y0*YX+Z0*ZX
1070 Y1=X0*XY+Y0*YY+Z0*ZY
1080 Z1=X0*XZ+Y0*YZ+Z0*ZZ
1090 REM  Rectangular--> spherical
1100 A1=ATN(Y1/X1)
1110 IF X1<0 THEN A1=A1+P1
1120 IF A1<0 THEN A1=A1+2*P1
1130 A1=A1/(R1*15): REM Final R.A.
1140 D1=ATN(Z1/SQR(X1*X1+Y1*Y1))
1150 D1=D1/R1: REM  Final Dec.
1160 RETURN
2000 REM
2010 REM    This program for pre-
2020 REM  cessing a star's coor-
2030 REM  dinates is described in
2040 REM  Sky & Telescope for 
2050 REM  October, 1991, page 408.
2060 REM  It was written by 
2070 REM  Zbigniew S. Krzeminski.
