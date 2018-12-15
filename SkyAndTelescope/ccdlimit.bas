10 '    Program to compute the signal-to-noise ratio
20 '    for a stellar image in a CCD camera.
30 '    Written by Anthony Mallama, September 1992.
40 '
50 DIM SN(5): PI=3.14159
60 S0=2000000: ' Star-signal constant (the number of
70 '             electrons per second for a 0-magnitude
80 '             star and a 1-inch scope)
90 SB=18:       ' Sky brightness in mag per sq arc second
100 PS=1.5:    ' Pixel size in arc seconds of sky
110 DD=3:      ' Detection diameter in arc seconds
120 RN=100:    ' Readout noise in electrons per pixel
130 TH=70:     ' Thermal electrons/pixel/sec 
140 AP=8:      ' Aperture of telescope in inches
150 ET=100:    ' Time before a readout in seconds
160 PRINT'
170 PRINT "Signal-to-noise ratios for stellar CCD images,"
180 PRINT "based on:"
190 PRINT USING "  A) #####.# inch aperture scope";AP
200 PRINT USING "  B) #####.# mag per sq arcsec of sky";SB
210 PRINT USING "  C) ####### arcsec detection circle";DD
220 PRINT USING "  D) ####### sec longest single exp.";ET
230 PRINT USING "  E) #####.# arcsec-per-pixel scale";PS
240 PRINT USING "  F) ####### elec/pixel readout noise";RN
250 PRINT USING "  G) ####### thermal elec/pixel/sec";TH
260 PRINT USING "  H) ####### star-signal constant";S0
270       PRINT "  Q)         Quit"
280 PRINT
290 INPUT "Choose a letter or type '/' to continue";P$
300 IF P$="A" OR P$="a" THEN INPUT AP
310 IF P$="B" OR P$="b" THEN INPUT SB
320 IF P$="C" OR P$="c" THEN INPUT DD
330 IF P$="D" OR P$="d" THEN INPUT ET
340 IF P$="E" OR P$="e" THEN INPUT PS
350 IF P$="F" OR P$="f" THEN INPUT RN
360 IF P$="G" OR P$="g" THEN INPUT TH
370 IF P$="H" OR P$="h" THEN INPUT S0
380 IF P$="Q" OR P$="q" THEN 720
390 IF P$="/" THEN GOTO 410
400 GOTO 160
410 PRINT
420 AR=PI*(DD/2)^2: 'Detection area in square arcsec
430 PX=AR/PS^2:     'Detection area in pixels
440 IF PX>1 GOTO 500
450     PRINT "Warning:  Detection area is less"
460     PRINT "than 1 pixel. Increase size."
470     PRINT
480     INPUT "Press <Enter> to continue";X$
490     GOTO 160
500 EN=DD/10 ' Fraction of star's total image encircled
510 '          by the detection or measurement area
520   IF EN>1 THEN EN=1
530 PRINT " Mag.  1 sec  10s  100s ";
540 PRINT "1000s 10000s"
550 FOR M=10 TO 20
560   L=1/(10^(M/2.5)): ' Luminosity
570   PRINT USING " ##.#"; M;
580 FOR I=1 TO 5
590   S=10^(I-1): '        Exposure time in seconds
600   SG=L*S*S0*EN*AP^2: '            Signal total
610   SK=S*S0*AR*AP^2/10^(SB/2.5): '  Sky total   
620   TT=TH*PX*S: '                   Thermal total
630   N=S/ET: '              Total number of frames
640   IF N<>INT(N) THEN N=INT(N)+1
650   SN(I)=SG/SQR(SG+TT+SK+N*PX*RN^2)
660 NEXT I
670 PRINT USING "######";SN(1);SN(2);SN(3);SN(4);SN(5)
680 NEXT M
690 PRINT
700 INPUT "Press <Enter> to continue";X$
710 GOTO 160
720 END
730 '
740 '    This program computes the signal-to-noise (SNR) ratio expected 
750 '    when a CCD camera is used under specific conditions and 
760 '    with a given telescope.  Since an SNR of at least 3 is needed 
770 '    for reliable visiblity of a star image, the program can be 
780 '    used to estimate the magnitude limit reached.  It was written
790 '    by Anthony Mallama and appeared in Sky & Telescope for 
800 '    February 1993, page 84.
