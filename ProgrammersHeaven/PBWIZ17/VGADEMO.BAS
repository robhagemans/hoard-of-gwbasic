'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         PBWIZ  Copyright (c) 1991-1993  Thomas G. Hanlin III         |
'   |                                                                      |
'   |                      PowerBASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   $DIM ARRAY

   DECLARE SUB GetDisplay (INTEGER, INTEGER)
   DECLARE SUB G13Box (INTEGER, INTEGER, INTEGER, INTEGER, INTEGER)
   DECLARE SUB G13Color (INTEGER, INTEGER)
   DECLARE SUB G13Locate (INTEGER, INTEGER)
   DECLARE SUB G13Mode (INTEGER)
   DECLARE SUB G13Polygon (INTEGER, INTEGER, INTEGER, INTEGER, SINGLE)
   DECLARE SUB G13Write (STRING)
   DECLARE SUB G13WriteLn (STRING)
   DECLARE SUB GN0Cls ()
   DECLARE SUB GN0Color (INTEGER, INTEGER)
   DECLARE SUB GN0Locate (INTEGER, INTEGER)
   DECLARE SUB GN0Mode (INTEGER)
   DECLARE SUB GN0ShowBMP (STRING, INTEGER, INTEGER, INTEGER)
   DECLARE SUB GN0Write (STRING)
   DECLARE SUB GN0WriteLn (STRING)

   $LINK "pbwiz.pbl"

   DEFINT A-Z

   RANDOMIZE TIMER

   GetDisplay Adapter, Mono

   IF Adapter <> 6 THEN
      PRINT "Sorry.  VGADEMO requires a VGA to run."
      END
   END IF

   G13Mode 1                 ' ...put into low-res VGA mode
   G13Color 4, 2
   G13WriteLn "PBWiz gives you access to 256-color VGA"
   G13Color 0, 3
   G13WriteLn "modes from  320x200 to 360x480  on any "
   G13Color 7, 1
   G13WriteLn "standard VGA.   This is 320x200.   The "
   G13Color 5, 8
   G13WriteLn "360x480 mode is shown on the next page."
   G13WriteLn ""
   G13Color 4, 14
   G13WriteLn "Full text & graphics support included. "
   FOR Y = 0 TO 31
      G13Color Y + 16, 0
      G13Box Y, Y + 64, 319 - Y, (64 - Y) + 120, (Y = 100)
      IF Y > 15 THEN
         G13Polygon Y * 15 - 194, 112, 5, INT(RND * 6 + 1) + 2, .75 * 3.141593
         G13Color 64 - Y, 0
         G13Polygon Y * 15 - 194, 136, 5, INT(RND * 6 + 1) + 2, 0
      END IF
   NEXT
   G13Locate 25, 14
   G13Color 15, 4
   G13Write "Press any key"

   DO
   LOOP WHILE LEN(INKEY$)
   DO
      ky$ = INKEY$
   LOOP UNTIL LEN(ky$)

   GN0Mode 1

   GN0Cls
   GN0Color 50, 0
   GN0WriteLn "This is a 256-color 360 x 480 graphics mode"
   GN0WriteLn "which works on any normal VGA.  It provides"
   GN0WriteLn "nearly 3x the screen area of the standard"
   GN0WriteLn "320 x 200  VGA high-color mode."
   GN0WriteLn ""
   GN0WriteLn "You can read and write Windows bitmaps"
   GN0WriteLn "(.BMP picture files) in 256 colors, too."

   GN0ShowBMP "GDEMO.BMP", 76, 100, ErrCode

   GN0Locate 60, 6
   GN0Write "Press any key"

   DO
   LOOP WHILE LEN(INKEY$)
   DO
   LOOP UNTIL LEN(INKEY$)

   GN0Mode 0                 ' restore text mode
