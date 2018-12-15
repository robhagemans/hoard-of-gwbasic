10 '  A Camera's Efficiency for Meteors
20 '
30 RD=180/3.14159
35 C=4*RD^2
40 L=0: W=0: Q=0
50 K=0.003667: ' Constant
60 N=1: '  Exponent for focal length
70 X=0: '  Closed/open ratio
80 INPUT "F/ratio ";FR
90 INPUT "Focal length (mm)"; FL
100 AP=FL/FR: ' Aperture in mm
110 PRINT "Select film/image format:"
120 PRINT "   (1) 35-mm"
130 PRINT "   (2) 120 square"
140 PRINT "   (3) 4 x 5"
150 PRINT "   (4) 8 x 10"
160 PRINT "   (5) Special area"
170 PRINT "   (6) Fisheye (180 deg)"
180 INPUT "Selection";Q
190 IF Q<1 OR Q>6 THEN GOTO 180
200 ON Q GOTO 210,220,230,240,250,260
210 L=36: W=24: GOTO 270
220 L=55: W=55: GOTO 270
230 L=119: W=94: GOTO 270
240 L=240: W=190: GOTO 270
250 INPUT "Sky area (sq deg)";S
255 GOTO 310
260 S=20626: GOTO 290
265 '
266 '  Compute sky area covered
267 '  by a rectangular film frame
270 S=C*ATN(0.5*L/FL)*ATN(0.5*W/FL)
280 IF S>50 THEN S=INT(S+0.5)
290 PRINT "Sky area (sq deg): ";S
300 '
310 '  Now, evaluate McKinley formula
320 E=K*AP^2*S/((1+X)*FL^N)
330 PRINT USING "Efficiency ####.#";E
340 PRINT
350 INPUT "Another (y or n)";Q$
360 IF Q$<>"n" THEN GOTO 40
370 END
380 '
390 '  Written by Roger W. Sinnott, this program calculates the relative
400 '  efficiency of any given camera lens and film format for capturing
410 '  meteors.  The efficiency is expressed as a number that ranges from
420 '  less than 10 for poor combinations (such as a 35-mm camera with a 
430 '  long telephoto lens) to more than 1,000 for highly specialized systems
440 '  such as the Baker Super-Schmidt.  The program was described in 
450 '  Sky & Telescope for February 1994, page 85.
