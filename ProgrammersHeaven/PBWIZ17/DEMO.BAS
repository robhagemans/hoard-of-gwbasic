'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         PBWIZ  Copyright (c) 1991-1993  Thomas G. Hanlin III         |
'   |                                                                      |
'   |                      PowerBASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   $DIM ARRAY

   DECLARE FUNCTION CommPorts% ()
   DECLARE FUNCTION Floppies% ()
   DECLARE SUB GetDisplay (INTEGER, INTEGER)
   DECLARE SUB GetDOSv (INTEGER, INTEGER)
   DECLARE SUB GetEMSm (INTEGER, INTEGER)
   DECLARE SUB GetEMSv (INTEGER, INTEGER)
   DECLARE FUNCTION GetExtM& ()
   DECLARE SUB GetXMSm (LONG, LONG)
   DECLARE SUB GetXMSv (INTEGER, INTEGER)
   DECLARE FUNCTION PCDate$ ()
   DECLARE FUNCTION PCType% ()
   DECLARE SUB PopWindow (INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, STRING)
   DECLARE FUNCTION Processor% ()
   DECLARE FUNCTION PrtPorts% ()
   DECLARE SUB XQPrint (STRING, INTEGER, INTEGER, INTEGER)

   $LINK "pbwiz.pbl"

   DEFINT A-Z


'  ----- Pick the colors to use -----------------------------------------------


   GetDisplay Adapter, Mono

   IF Mono THEN
      Attr = CalcAttr (7, 0)
   ELSE
      Attr = CalcAttr (7, 1)
   END IF


'  ----- Clear the screen and pop up the window -------------------------------


   CLS

   Fore = 15
   IF Mono THEN
      Back = 0
   ELSE
      Back = 1
   END IF
   Attr = CalcAttr(Fore, Back)
   Frame = 1
   Grow = 15
   Shade = 0
   Title$ = "PBWiz Demo"
   PopWindow 2, 2, 23, 77, Frame, Attr, Grow, Shade, 10, Title$


'  ----- Add a text note inside the window ------------------------------------


   Row = 3
   XQPrint "This is an admittedly trivial demo for the PBWiz library.  I'll", Row, 3, Attr
   Row = Row + 1
   XQPrint "improve it drastically in later versions.  However, for now it will", Row, 3, Attr
   Row = Row + 1
   XQPrint "provide an example of how to access the PBWiz routines.", Row, 3, Attr
   Row = Row + 2


'  ----- Display processor type -----------------------------------------------


   SELECT CASE Processor
      CASE 1: St$ = "8088"
      CASE 2: St$ = "80186"
      CASE 3: St$ = "80286"
      CASE 4: St$ = "80386"
      CASE 5: St$ = "80486"
      CASE ELSE: St$ = "80?86"
   END SELECT
   XQPrint "Processor: " + St$, Row, 3, Attr
   Row = Row + 1


'  ----- Display DOS version --------------------------------------------------


   GetDOSv MajorV, MinorV
   DOSv$ = STR$(MajorV) + "." + RIGHT$("0" + LTRIM$(STR$(MinorV)), 2)
   St$ = ""
   IF MajorV > 9 THEN St$ = "   OS/2 Compatibility Box"
   IF DRDOS THEN St$ = " (DR DOS)"
   XQPrint "DOS version:" + DOSv$ + St$, Row, 3, Attr
   Row = Row + 1


'  ----- Display basic equipment info -----------------------------------------


   XQPrint "Floppy drives:" + STR$(Floppies), Row, 3, Attr
   Row = Row + 1


'  ----- Display video adapter type -------------------------------------------


   SELECT CASE Adapter
      CASE 1: St$ = "MDA"
      CASE 2: St$ = "Hercules"
      CASE 3: St$ = "CGA"
      CASE 4: St$ = "EGA"
      CASE 5: St$ = "MCGA"
      CASE 6: St$ = "VGA"
   END SELECT
   IF Mono THEN
      St$ = St$ + " on a monochrome monitor"
   ELSE
      St$ = St$ + " on a color monitor"
   END IF
   XQPrint "Display: " + St$, Row, 3, Attr
   Row = Row + 1


'  ----- Display BIOS date and type -------------------------------------------


   XQPrint "ROM BIOS date: " + PCDate$, Row, 3, Attr
   Row = Row + 1

   SELECT CASE PCType
      CASE 251, 254, 255: St$ = "PC/XT"
      CASE 253: St$ = "PCjr"
      CASE 252: St$ = "PC AT": ATtype = -1
      CASE 250: St$ = "PS/2 Model 30"
      CASE 249: St$ = "PC Convertible"
      CASE 248: St$ = "PS/2 Model 70 or 80": ATtype = -1
      CASE 45, 154: St$ = "Compaq Portable"
      CASE ELSE: St$ = "unknown"
   END SELECT
   XQPrint "Computer type: " + St$, Row, 3, Attr
   Row = Row + 1


'  ----- Display extended and expanded memory info ----------------------------


   IF ATtype THEN
      XQPrint "Extended memory (BIOS):" + STR$(GetExtM&) + " Kbytes", Row, 3, Attr
      Row = Row + 1
   END IF

   IF ATtype THEN
      GetXMSv MajorV, MinorV
      GetXMSm LargeBlock&, TotalFree&
      IF MajorV OR MinorV THEN
         St$ = STR$(MajorV) + "." + RIGHT$("0" + LTRIM$(STR$(MinorV)), 2)
         XQPrint "Extended memory (XMS):", Row, 3, Attr
         Row = Row + 1
         XQPrint "   Version:" + St$, Row, 3, Attr
         Row = Row + 1
         XQPrint "   Free   :" + STR$(TotalFree&) + " Kbytes", Row, 3, Attr
         Row = Row + 1
      END IF
   END IF

   GetEMSm TotalPages, FreePages
   IF TotalPages THEN
      GetEMSv MajorV, MinorV
      St$ = STR$(MajorV) + "." + RIGHT$("0" + LTRIM$(STR$(MinorV)), 2)
      XQPrint "Expanded memory:", Row, 3, Attr
      Row = Row + 1
      XQPrint "   Version:" + St$, Row, 3, Attr
      Row = Row + 1
      XQPrint "   Total  :" + STR$(TotalPages * 16) + " Kbytes", Row, 3, Attr
      Row = Row + 1
      XQPrint "   Free   :" + STR$(FreePages * 16) + " Kbytes", Row, 3, Attr
      Row = Row + 1
   END IF

   St$ = STR$(CommPorts)
   XQPrint "COM ports:" + St$, Row, 3, Attr
   Row = Row + 1

   St$ = STR$(PrtPorts)
   XQPrint "LPT ports:" + St$, Row, 3, Attr
   Row = Row + 1


'  ----- Make sure the DOS prompt doesn't get in the way ----------------------


   LOCATE 24, 1, 1
