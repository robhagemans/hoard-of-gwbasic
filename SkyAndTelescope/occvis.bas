10 '              Visibility of an Occultation
20 INPUT "Moon's sunlit percentage";SF
30 INPUT "Zenith distance of star (degrees)";Z
40 INPUT "Height of Sun above horizon";HS
50 INPUT "Cusp angle (<0 for bright side) in deg";C
60 BV=.7:  ' Star's color index, B-V (in mags.)
70 K=.3 :  ' Vis. extinction coeff. (mag./airmass)
80 BC=0:   ' Brightness from light pollution (nL)
90 SE=1:   ' Seeing disk diameter at zenith (arcsec)
100 FV=20: ' Moon fraction in field of view (%)
110 D=6:   ' Telescope aperture (inches)
120 M=150: ' Magnification
130 TR=80: ' Telescope throughput (%)
140 AG=30: ' Observer's age (years)
150 RS=1:  ' Snellen ratio (20/20=1, 20/40=0.5,...)
160 EX=5:  ' Experience (1-9; 5=average, 9=expert)
170 MS=8.61:  ' Star's visual magnitude
180 PRINT "Choose program mode --"
190 PRINT "   (1) Minimum aperture"
200 PRINT "   (2) Limiting magnitude"
210 INPUT Q$: IF Q$<>"1" AND Q$<>"2" THEN 210
220 IF Q$="2" THEN 270
230 D=.5: '    Find minimum telescope aperture
240 D=D+.1: M=25*D: GOSUB 290: IF MS>ML THEN 240
250 PRINT "Aperture should be at least" ;D;" inches"
260 GOTO 280
270 GOSUB 290: PRINT "Limiting magnitude is ";ML
280 END
290 '  Routine to find lim. mag. for given conditions
300 XX=COS(Z/57.295): ' First, estimate corrections
310 X=1/(XX+.025*EXP(-11*XX)): ' Airmass of Moon
320 ZE=SQR(2.89*X*SE^2+(17.9/D)^2):'2nd moment of image
330 F1=10^(.4*K*X):  ' Extinction
340 F2=1.41:         ' Binocular vision
350 F3=100/TR:       ' Transmission of scope
360 DE=4:          '  Guess that pupil is 4mm
370 F4=(25.4*D/(M*DE))^2: ' Light outside pupil
380    IF F4<1 THEN F4=1
390 F5=(DE/(25.4*D))^2: ' Light gathering power
400 XX=1-EXP(-.026*DE^2)
410 YY=1-EXP(-.026*(25.4*D/M)^2)
420 F6=(25.4*D/(DE*M))^2*XX/YY:'Stiles-Crawford effect
430    IF F6>1 THEN F6=1
440 F7=(1+.03*(M*ZE/100)^2)/RS^2: ' Resolving the star
450 FI=F1*F2*F3*F4*F5*F6*F7:' Corr. for intensities
460 FB=M^2*F2*F3*F4*F5*F6:'Corr. for surface brightness
470 '     Calculate brightness of Moon
480 CP=SF/50-1
490 IF CP=0 THEN PH=3.14159/2: GOTO 520
500 PH=ATN(SQR(1-CP*CP)/CP): ' Lunar phase (0 is full)
510    IF CP<0 THEN PH=PH+3.14159
520 DM=1.49*PH+.043*(PH^4)-12.73 : ' Moon's magnitude
530 IM=10^(-.4*(DM+16.57)): ' Intensity of Moon
540 BM=5.67E+12*IM/(F1*SF): ' Moon brightness (nL)
550 SP=3.14159-PH: ' Earth's phase from Moon
560 XX=1.49*SP+.043*(SP^4)-12.73
570 BE=1.1E+07*10^(-.4*(XX+16.57))/F1: ' Earthshine
580 '     Calculate glare brightness
590 XX=(COS(C/57.295))^2+(1-SF/100+SIN(C/57.295))^2
600 YY=(1-.4*EXP(-1*C/30))
610 IF YY<.6 THEN YY=.6
620 TH=.25*SQR(XX)*YY: ' Effective distance to Moon
630 B1=6.25E+07*IM*(F1-1)/(TH*F1)^2:'Scattering in air
640 B2=4.63E+07*IM*(FV/100)/(TH^2*F1):'Scat. in eye
650 B3=443000*IM/(TH^3*D*F1): ' Diffraction
660 B4=2.6E+08*IM*EXP(-1*(TH/.4)^2)/F1: ' By mirror
670 BG=B1+B2+B3+B4: ' Glare brightness
680 '      Calculate effective background brightness
690 XX=1-.96*(SIN(Z/57.295))^2
700 BN=180*(.4+.6/SQR(XX))/F1: ' Night sky
710 XX=10^(PH/1.571-1.1):  IF XX<1 THEN XX=1
720 BT=XX*10^(8.45+.4*HS)*(F1-1)/F1: '  Twilight sky
730 PM=10^5.36*(1.06+(COS(PH))^2): '  Mie scattering
740 PA=10^(1.65+1.43*PH): '  Aerosol scattering
750 XX=-.4*K/(SQR(1-.96*(SIN((90-HS)/57.295))^2))
760 BD=11700*10^XX*(PM+PA)*(F1-1)/F1: '  Daytime sky
770 BS=BN+BT+BC: ' Sky brightness
780 IF BD<BT THEN BS=BN+BD+BC
790 XX=.5*(1+C/ABS(C)): ' +1 if dark limb
800 YY=.5*(1-C/ABS(C)): ' +1 if bright limb
810 BA=BS+XX*(BE+BG)+YY*BM: ' Apparent brightness
820 '     Condition of the observer's eye
830 R1=380*10^(.3*(BA/FB)^-.29): 'Night resolution
840 R2=42*10^(8.28*(BA/FB)^-.29): 'Day-vision resol.
850 RE=900/RS: IF R1<900 THEN RE=R1/RS
860 IF R2<900 AND R2<R1 THEN RE=R2/RS
870 XX=1.85*(IM*.000929*FV/F1)/(1.122^(M*TH))
880 YY=EXP(-.16*(.000001*BA/FB+XX)^.4)
890 ZZ=7*EXP(-.5*(25/100)^2):'Standard obsvr is age 25
900 DS=ZZ*YY: IF DS<2 THEN DS=2: 'Stand. pupil size
910 ZZ=7*EXP(-.5*(AG/100)^2): ' Dark pupil for obsvr
920 DE=ZZ*YY: IF DE<2 THEN DE=2: 'Pupil size of obsvr
930 '     Recalculate correction factors
940 F4=(25.4*D/(M*DE))^2: ' Light outside pupil
950    IF F4<1 THEN F4=1
960 F5=(DS/(25.4*D))^2:   ' Light-gathering power
970 XX=1-EXP(-.026*DS^2)
980 YY=1-EXP(-.026*(25.4*D/M)^2)
990 F6=(25.4*D/(DS*M))^2*XX/YY:'Stiles-Crawford effect
1000    IF F6>1 THEN F6=1
1010 F7=(1+.03*(M*ZE/RE)^2)/RS^2:'Resolving the star
1020 F8=10^(-.4*(1-.5*BV)):      'Color corr (night)
1030 IF BA>1480 THEN F8=1:       'Color corr (day)
1040 FI=F1*F2*F3*F4*F5*F6*F7*F8: 'Corr for intensities
1050 FB=M^2*F2*F3*F4*F5*F6*F8: 'For surface brightness
1060 '      Calculate limiting magnitude
1070 B=BA/FB: ' Perceived brightness
1080 ID=4.46E-09*(1+SQR(1.26E-06*B))^2: 'Day vision
1090 IN=1.59E-10*(1+SQR(.0126*B))^2:    'Night vision
1100 I=ID: IF IN<ID THEN I=IN: 'Limiting illum.(ft-cd)
1110 ML=-16.57-2.5*LOG(I*FI)/LOG(10): ' Limiting mag
1120 ML=ML+.16*(EX-6): ' Correct for experience
1130 ML=ML-1.2: ' Correct for steady visibility
1140 RETURN
1150 '
1160 '    OCCVIS.BAS -- This program by Dr. Bradley 
1170 '    E. Schaefer computes the visibility of a 
1180 '    star near the Moon.  It is intended as a guide
1190 '    to observers of lunar occultations.  For a 
1200 '    detailed explanation of the program's use, see
1210 '    Sky & Telescope, January 1993, page 89.
