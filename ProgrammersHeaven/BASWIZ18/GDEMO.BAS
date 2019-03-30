'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         BASWIZ  Copyright (c) 1990-1991  Thomas G. Hanlin III        |
'   |                                                                      |
'   |                       The BASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DECLARE SUB BFont (BYVAL FontNr%)
   DECLARE SUB GetDisplay (Adapter%, Mono%)
   DECLARE SUB G1Banner (St$, X%, Y%, Xmul%, Ymul%)
   DECLARE SUB G1Border (BYVAL Colour%)
   DECLARE SUB G1Box (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%, BYVAL Fill%)
   DECLARE SUB G1Color (BYVAL Foregnd%, BYVAL Backgnd%)
   DECLARE SUB G1Ellipse (CenterX%, CenterY%, XRadius%, YRadius%)
   DECLARE SUB G1Line (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%)
   DECLARE SUB G1Locate (BYVAL Row%, BYVAL Column%)
   DECLARE SUB G1Mode (BYVAL ModeNr%)
   DECLARE SUB G1PaletteA (BYVAL PaletteNr%)
   DECLARE SUB G1Plot (BYVAL X%, BYVAL Y%)
   DECLARE SUB G1Polygon (X%, Y%, Radius%, Vertices%, Angle!)
   DECLARE SUB G1Write (St$)
   DECLARE SUB G1WriteLn (St$)
   DECLARE SUB G2Color (BYVAL Foregnd%, BYVAL Backgnd%)
   DECLARE SUB G2LoadPCX (File$, Image%(), ErrCode%)
   DECLARE SUB G2Locate (BYVAL Row%, BYVAL Column%)
   DECLARE SUB G2Mode (BYVAL ModeNr%)
   DECLARE SUB G2Put (X%, Y%, Image%())
   DECLARE SUB G2Write (St$)
   DECLARE SUB G2WriteLn (St$)
   DECLARE SUB G7Box (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%, BYVAL Fill%)
   DECLARE SUB G7Color (BYVAL Foreground%, BYVAL Background%)
   DECLARE SUB G7Locate (BYVAL Row%, BYVAL Column%)
   DECLARE SUB G7Mode (BYVAL Graphics%)
   DECLARE SUB G7Polygon (X%, Y%, Radius%, Vertices%, Angle!)
   DECLARE SUB G7Write (St$)
   DECLARE SUB G7WriteLn (St$)
   DECLARE SUB G13Box (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%, BYVAL Fill%)
   DECLARE SUB G13Color (BYVAL Foreground%, BYVAL Background%)
   DECLARE SUB G13Locate (BYVAL Row%, BYVAL Column%)
   DECLARE SUB G13Mode (BYVAL Graphics%)
   DECLARE SUB G13Polygon (X%, Y%, Radius%, Vertices%, Angle!)
   DECLARE SUB G13Write (St$)
   DECLARE SUB G13WriteLn (St$)

   DEFINT A-Z

   DEF FNR (X) = INT(RND * X)

   RANDOMIZE TIMER

   GetDisplay Adapter, Mono

   IF Adapter < 3 THEN
      PRINT "Sorry, but you must have a CGA, EGA or VGA display active to run this demo."
      END
   END IF

   G1Mode 1                          ' CGA 320x200 mode
   G1PaletteA 0                      ' Green, Red, Yellow palette

   BFont 1
   G1Color 1, 0
   G1Banner "BASWIZ", 0, 0, 3, 2
   BFont 0
   G1Color 3, 0
   G1Banner "Copyright (c)1990", 179, 5, 1, 1
   G1Banner "Thomas G. Hanlin", 182, 15, 1, 1

   BFont 2
   G1Color 2, 0
   G1Banner "This is the BASIC Wizard's Library.", 0, 40, 1, 1

   BFont 1
   G1Color 1, 0
   G1Banner "Flexible text handling is a natural", 0, 68, 1, 1
   G1Banner "aspect of graphics modes.  The BASWIZ", 0, 82, 1, 1
   G1Banner "library takes full advantage of that,", 0, 96, 1, 1
   G1Banner "with a selection of fonts and fast", 0, 110, 1, 1
   G1Banner "full-color text support.", 0, 124, 1, 1

   BFont 0
   G1Color 3, 0
   G1Banner "This is CGA mode SCREEN 1, by the way.", 0, 150, 1, 1

   BFont 2
   G1Color 2, 0
   G1Banner "Now let's see some graphics!", 0, 170, 1, 1

   G1Locate 25, 14
   G1Color 2, 3
   G1Write "Press a key"

   DO
   LOOP WHILE LEN(INKEY$)
   DO
      ky$ = INKEY$
   LOOP UNTIL LEN(ky$)
   IF ky$ = CHR$(27) THEN GOTO Done

   G1Color 0, 0
   G1Box 0, 30, 319, 189, 1
   G1Color 2, 0
   G1Box 0, 26, 319, 188, 0

   G1Color 1, 0
   G1Locate 23, 2
   G1Write "Dots, Lines, Boxes, Ellipses..."

   FOR Dot = 1 TO 200
      G1Color FNR(3) + 1, 0
      G1Plot FNR(316) + 2, FNR(140) + 28
   NEXT

   FOR Lin = 1 TO 10
      G1Color FNR(3) + 1, 0
      G1Line FNR(316) + 2, FNR(140) + 28, FNR(315) + 3, FNR(139) + 29
   NEXT

   FOR Box = 1 TO 10
      G1Color FNR(3) + 1, 0
      X = FNR(250) + 2
      Y = FNR(112) + 28
      G1Box X, Y, X + FNR(60) + 1, Y + FNR(25) + 1, FNR(2)
   NEXT

   FOR Ellipse = 1 TO 10
      G1Color FNR(3) + 1, 0
      X = FNR(215) + 40
      Y = FNR(85) + 60
      G1Ellipse X, Y, FNR(25) + 5, FNR(20) + 5
   NEXT

   DO
   LOOP WHILE LEN(INKEY$)
   DO
      ky$ = INKEY$
   LOOP UNTIL LEN(ky$)
   IF ky$ = CHR$(27) THEN GOTO Done

   G1Color 0, 0
   G1Box 1, 27, 318, 187, 1

   G1Color 1, 0
   G1Locate 23, 2
   G1Write "But why stop at the usual?"

   FOR Poly = 1 TO 12
      G1Color FNR(3) + 1, 0
      X = FNR(212) + 40
      Y = FNR(90) + 60
      G1Polygon X, Y, FNR(25) + 5, FNR(6) + 3, 3.14159 * RND
   NEXT

   DO
   LOOP WHILE LEN(INKEY$)
   DO
      ky$ = INKEY$
   LOOP UNTIL LEN(ky$)
   IF ky$ = CHR$(27) THEN GOTO Done

   G2Mode 1                          ' CGA 640x200 mode
   IF Adapter = 3 THEN               ' if CGA...
      G1Border 1                     '    set foreground color to blue
   END IF
   G2Locate 1, 1
   G2Color 1, 0
   G2WriteLn "There are a few additional routines of interest which are designed to work"
   G2WriteLn "only in SCREEN 2 mode at this time.  These are the picture readers, which"
   G2WriteLn "allow you to read in .MAC and .PCX pictures into a GET/PUT image.  Here's"
   G2WriteLn "a sample from GDEMO.PCX:"

   REDIM Image(1)
   G2LoadPCX "GDEMO.PCX", Image(), ErrCode
   G2Put 40, 40, Image()

   G2Locate 15, 1
   G2WriteLn "Of course, that's not the end of it!  There are many other routines that"
   G2WriteLn "are not included in this demonstration.  One of 'em in particular which you"
   G2WriteLn "may like is a routine to detect what kind of display adapter is attached and"
   G2WriteLn "whether the display is color or monochrome.  BasWiz can handle any type of"
   G2WriteLn "display, or even dual display systems!"
   G2WriteLn ""
   G2WriteLn "See BASWIZ.DOC for more details."

   G2Locate 25, 33
   G2Color 0, 1
   G2Write "Press any key"

   IF Adapter = 4 THEN                     ' if EGA...
      DO
      LOOP WHILE LEN(INKEY$)
      DO
         ky$ = INKEY$
      LOOP UNTIL LEN(ky$)
      IF ky$ = CHR$(27) THEN GOTO Done
      G7Mode 1                             ' ...put into low-res EGA mode
      G7Color 4, 2
      G7WriteLn "Ah, I see you have an EGA!  Of course,"
      G7Color 0, 3
      G7WriteLn "BASWIZ supports the various EGA modes"
      G7Color 7, 1
      G7WriteLn "as well as the Hercules, CGA and VGA."
      FOR Y = 0 TO 31
         G7Color Y AND 15, 0
         G7Box Y, Y + 64, 319 - Y, (64 - Y) + 120, (Y = 100)
         IF Y > 15 THEN
            G7Polygon Y * 15 - 194, 112, 5, FNR(6) + 3, .75 * 3.141593
            G7Color ((Y XOR 15) AND 15), 0
            G7Polygon Y * 15 - 194, 136, 5, FNR(6) + 3, 0
         END IF
      NEXT
      G7Locate 25, 14
      G7Color 15, 4
      G7Write "Press any key"
   ELSEIF Adapter = 6 THEN                     ' if VGA...
      DO
      LOOP WHILE LEN(INKEY$)
      DO
         ky$ = INKEY$
      LOOP UNTIL LEN(ky$)
      IF ky$ = CHR$(27) THEN GOTO Done
      G13Mode 1                            ' ...put into low-res VGA mode
      G13Color 4, 2
      G13WriteLn "Ah, I see you have a VGA!  Of course,"
      G13Color 0, 3
      G13WriteLn "BASWIZ supports the various VGA modes"
      G13Color 7, 1
      G13WriteLn "as well as Hercules, CGA and EGA."
      FOR Y = 0 TO 31
         G13Color Y + 16, 0
         G13Box Y, Y + 64, 319 - Y, (64 - Y) + 120, (Y = 100)
         IF Y > 15 THEN
            G13Polygon Y * 15 - 194, 112, 5, FNR(6) + 3, .75 * 3.141593
            G13Color 64 - Y, 0
            G13Polygon Y * 15 - 194, 136, 5, FNR(6) + 3, 0
         END IF
      NEXT
      G13Locate 25, 14
      G13Color 15, 4
      G13Write "Press any key"
   END IF

   DO
   LOOP WHILE LEN(INKEY$)
   DO
      ky$ = INKEY$
   LOOP UNTIL LEN(ky$)
   IF ky$ = CHR$(27) THEN GOTO Done

Done:
   G1Mode 0                          ' restore text mode
