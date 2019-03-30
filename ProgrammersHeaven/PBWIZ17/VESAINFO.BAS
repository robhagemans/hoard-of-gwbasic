'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         PBWIZ  Copyright (c) 1991-1993  Thomas G. Hanlin III         |
'   |                                                                      |
'   |                      PowerBASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   $DIM ARRAY

   DECLARE FUNCTION VesaChrHeight% ()
   DECLARE FUNCTION VesaChrWidth% ()
   DECLARE FUNCTION VesaColors& ()
   DECLARE FUNCTION VesaFindFirst% ()
   DECLARE FUNCTION VesaFindNext% ()
   DECLARE FUNCTION VesaIsText% ()
   DECLARE FUNCTION VesaIsMono% ()
   DECLARE FUNCTION VesaScrHeight% ()
   DECLARE FUNCTION VesaScrWidth% ()
   DECLARE SUB VesaVersion (INTEGER, INTEGER)

   $LINK "pbwiz.pbl"

   DEFINT A-Z

   VesaVersion MajorV, MinorV
   IF MajorV = 0 AND MinorV = 0 THEN
      PRINT "Sorry, but you do not have VESA support."
      END
   END IF

   VMode = VesaFindFirst
   DO UNTIL VMode = -1
      CLS
      PRINT "VESAINFO  Copyright (c) 1993  Thomas G. Hanlin III"
      PRINT "Demo program for PBWiz shows available VESA modes"
      PRINT
      PRINT "VESA Mode : &H"; HEX$(VMode)
      PRINT "Mode Type : ";
      IF VesaIsText THEN PRINT "Text "; ELSE PRINT "Graphics ";
      IF VesaIsMono THEN PRINT "(mono)" ELSE PRINT "(color)"
      PRINT "Resolution:"; VesaScrWidth; "x"; VesaScrHeight;
      IF VesaIsText THEN PRINT "chars" ELSE PRINT "pixels"
      PRINT "Char Size :"; VesaChrWidth; "x"; VesaChrHeight
      PRINT "Colors    :"; VesaColors&
      PRINT
      PRINT
      PRINT
      PRINT "-- press a key to view next available mode --"
      VMode = VesaFindNext
      DO
      LOOP WHILE LEN(INKEY$)
      DO
         ky$ = INKEY$
      LOOP UNTIL LEN(ky$)
      IF ky$ = CHR$(27) OR ky$ = CHR$(3) THEN EXIT DO
   LOOP
