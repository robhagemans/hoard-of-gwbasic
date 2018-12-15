10 REM  SUPERNUM.BAS
20 REM  by Rodney Kubesh
30 OPEN "BOW.DAT" FOR OUTPUT AS #1
40 CLS
50 PI=3.14159
60 A0=1.5707288# : A1=-.2121144
70 A2=.074261 : A3=-.0187293
80 N=1.3318 : REM Refractive index
90 RA=250 : REM Drop radius in microns
100 L=.6563 : REM Wavelength in microns
110 FOR J=450 TO 550
120 REM Choose angle of incidence for ray A
130 I=J*.1*PI/180
140 AN=SIN(I)/N
150 REM Snell's Law gives angle of refraction
160 R=PI/2-(1-AN)^.5*(A0+A1*AN+A2*AN^2+A3*AN^3)
170 TH=4*R-2*I
180 LOCATE 12,15
190 PRINT "Computing intensity for emergence angle = ";
200 PRINT USING "###.##"; TH*180/PI
210 REM D and S are path lengths outside the drop for ray A
220 D=1-COS(I)
230 X0=-COS(4*R-I) : Y0=-SIN(4*R-I)
240 X1=X0 : X2=X0-1 : X3=X0-2
250 Y1=Y0-1/TAN(TH)
260 Y2=Y0
270 Y3=Y0-2*TAN(TH)
280 S1=(Y2-Y1)/(X2-X1)
290 S2=(Y3-Y0)/(X3-X0)
300 I2=I
310 X=(Y0-Y1+S1*X1-S2*X0)/(S1-S2)
320 Y=(X-X1)*S1+Y1
330 S=((Y-Y0)^2+(X-X0)^2)^.5
340 REM Find total path length
350 P1=RA*(D+S+4*N*COS(R))
360 IN=59.5
370 REM Choose possible angles of incidence for ray B
380 IN=IN+.05
390 I=IN*PI/180
400 AN=SIN(I)/N
410 R=PI/2-(1-AN)^.5*(A0+A1*AN+A2*AN^2+A3*AN^3)
420 REM Find companion rays emerging in same direction
430 TL=ABS(TH-4*R+2*I)
440 IF TL>.001 GOTO 380
450 TH=4*R-2*I
460 REM Path lengths D and S for ray B
470 D=1-COS(I)
480 X0=-COS(4*R-I) : Y0=-SIN(4*R-I)
490 X3=X0-2
500 Y3=Y0-2*TAN(TH)
510 S1=(Y2-Y1)/(X2-X1)
520 S2=(Y3-Y0)/(X3-X0)
530 X=(Y0-Y1+S1*X1-S2*X0)/(S1-S2)
540 Y=(X-X1)*S1+Y1
550 S=((Y-Y0)^2+(X-X0)^2)^.5
560 REM Total path length for ray B
570 P2=RA*(D+S+4*N*COS(R))
580 REM Find difference in path length
590 PD=P1-P2
600 PH=2*PI*PD/L-PI/2
610 REM Find amplitude
620 AM=COS(PH/2)
630 REM Print emergence angle and intensity
640 PRINT#1, USING "###.###"; TH*180/PI; AM^2
650 NEXT J
660 CLOSE#1
670 END
900 REM  ---------------------------
910 REM  APPEARED IN ASTRONOMICAL
920 REM  COMPUTING, SKY & TELESCOPE,
930 REM  SEPTEMBER 1998, PAGE 70
940 REM  ---------------------------
