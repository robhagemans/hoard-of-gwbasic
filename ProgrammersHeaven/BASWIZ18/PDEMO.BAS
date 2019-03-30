'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         BASWIZ  Copyright (c) 1990-1991  Thomas G. Hanlin III        |
'   |                                                                      |
'   |                       The BASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DECLARE SUB G11Mode (BYVAL Graphics%)
   DECLARE SUB GN2Display ()
   DECLARE SUB GN2Font (BYVAL FontNr%)
   DECLARE SUB GN2Line (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%)
   DECLARE SUB GN2Locate (BYVAL Row%, BYVAL Column%)
   DECLARE SUB GN2Mode (ModeNr%)
   DECLARE SUB GN2Print (Device$)
   DECLARE SUB GN2PrintL (Device$)
   DECLARE SUB GN2Write (St$)

   DEFINT A-Z

   ' set laser printer if they entered LASER or HP on the command line
   Laser = (INSTR(COMMAND$, "LASER") OR INSTR(COMMAND$, "HP"))

   GN2Mode 1                                ' init printer graphics mode
   GN2Font 0                                ' init printer graphics font

   GN2Line 0, 0, 479, 639                   ' line from top left to lower right
   GN2Line 479, 639, 479, 0                 ' draw box around entire page
   GN2Line 479, 0, 0, 0
   GN2Line 0, 0, 0, 639
   GN2Line 0, 639, 479, 639

   GN2Locate 5, 5                           ' set text cursor position
   GN2Write "Simple BasWiz Printer Test"    ' write text

   G11Mode 1                                ' set SCREEN 11 (VGA 640x480 x2)
   GN2Display                               ' display the page (preview page)

   IF Laser THEN                            ' depending on LASER setting...
      GN2PrintL "PRN"                       ' _print on HP-type laser printer
   ELSE                                     ' ...OR...
      GN2Print "PRN"                        ' _on Epson-type dot matrix printer
   END IF

   GN2Mode 0                                ' close printer graphics mode
   G11Mode 0                                ' restore text screen mode

   END
