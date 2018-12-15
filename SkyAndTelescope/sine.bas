 10 ' ----- set up dimensions (in pixels) of display -----
 11  DX = 310
 12  DY = 199
 13  CLS
 14  SCREEN 2
 15  KEY OFF
 17  PRINT "This program generates the Julia sets of the function"
 18  PRINT "lambda*sin(X + iY), where lambda = P + iQ and i * i = -1,"
 19  PRINT "in a portion of the complex plane with origin (in upper"
 20  PRINT "left corner) ACORNER,BCORNER and size SIDEX,SIDEY."
 21  PRINT "To get acquainted with this function set:"
 22  PRINT "lambda = 1, 0    corner = -7, -7    size = 14, 14"
 23  PRINT "To reproduce the images on page 137 of the August S&T set,"
 24  PRINT "Right image: lambda = 1, 0.1  corner = -3, -3  size 6, 6"
 25  PRINT "Left image:  lambda = 1, 0.8  corner = -3, -3  size 6, 6"
 26  PRINT "More details are in Chapter 3 of 'The Science of Fractal"
 27  PRINT "Images,' Heinz-Otto Peitgen and Dietmas Saupe editors,"
 28  PRINT "Springer -Verlag, 1988."
 29  PRINT "Good luck,"
 30  PRINT "David H. Smith July, 1989"
 31  PRINT ""
 32  PRINT ""
 33  PRINT "P.S. This program takes about an hour to run on a 6 MHz 286"
 34  PRINT "machine equipped with a 287 coprocessor running Quick Basic."
 35  PRINT "If you are running GW Basic expect it to take 10-times longer."
 36  PRINT "A color graphics card is essential."
 85  INPUT "enter value of lambda"; P, Q
 90  INPUT "enter corner of region to be displayed"; ACORNER, BCORNER
 100 INPUT "enter size of region"; SIDEX, SIDEY
 105 CLS
 106 SCREEN 1
 107 COLOR 0, 2
 110  GAPX = SIDEX / DX
 115  GAPY = SIDEY / DY
 210 '----- start main loops -----
 220 FOR X = 1 TO DX
 230   FOR Y = 1 TO DY
 260     AZ = (X * GAPX) + ACORNER
 270     BZ = (Y * GAPY) + BCORNER
 300     COUNT = 0
 302     EPBZ = EXP(BZ)
 303     EMBZ = 1 / EPBZ
 304     COSH = (EPBZ + EMBZ) / 2!
 305     SINH = (EPBZ - EMBZ) / 2!
 310     REAL = SIN(AZ) * COSH
 315     IMAG = COS(AZ) * SINH
 320     REALZ = P * REAL - Q * IMAG
 325     IMAGZ = Q * REAL + P * IMAG
 326     IMAGZ2 = IMAGZ * IMAGZ
 330     ABSZ = SQR(IMAGZ2)
 340     COUNT = COUNT + 1
 350    '
 360    '---- check for divergence or count = 30 -----
 370     IF ((ABSZ > 30) OR (COUNT = 30)) THEN 430
 380        AZ = REALZ
 390        BZ = IMAGZ
 400        GOTO 302
 410    '
 420     '----- set pixel color according to count -----
 430     COLOUR = 1 + COUNT MOD 3
 550     IF (COUNT = 30) THEN COLOUR = 0
 560     '
 600     '----- turn pixel on -----
 610     PSET (X, Y), COLOUR
 620     '
 630   NEXT Y
 640 NEXT X
 700 END
 800 REM  ************************************************
 810 REM  FOR MORE INFORMATION ON THIS PROGRAM, SEE THE 
 820 REM  ARTICLE "COMPUTER CHAOS AT HOME" IN THE AUGUST, 
 830 REM  1989, ISSUE OF SKY & TELESCOPE, PAGE 139.
 840 REM  ************************************************
