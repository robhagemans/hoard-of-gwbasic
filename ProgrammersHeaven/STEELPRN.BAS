' Description : SteelPrint! - Custom text print subroutine for
'               VGA Mode 13
' Written by  : Andrew L. Ayers
' Date        : 08/01/96
'
' This little routine allows you to place a "steel-like" text
' string on the mode 13 screen.
'
' You may use this routine in any manner you like, as long
' as you give credit in an appropriate manner.
'
DECLARE SUB SteelPrint (x%, y%, text$)
'
SCREEN 13
'
CALL SteelPrint(5, 12, "SteelPrint! by Andrew L. Ayers")
'
DO: LOOP UNTIL INKEY$ <> ""

SUB SteelPrint (x%, y%, text$)
  '
  starty% = (y% * 8) - 4
  endy% = (y% * 8) - 9
  startx% = ((x% - 1) * 8)
  endx% = ((x% - 1) * 8) + (LEN(text$) * 8)
  colr% = 32
  '
  COLOR 15: LOCATE y%, x%: PRINT text$
  '
  FOR y1% = starty% TO endy% STEP -1
    y2% = (starty% - 1) + ((starty% - 1) - y1%)
    FOR x% = startx% TO endx%
      IF POINT(x%, y1%) THEN PSET (x%, y1%), colr%
      IF POINT(x%, y2%) THEN PSET (x%, y2%), colr%
    NEXT x%
    colr% = colr% - 2
  NEXT y1%
  '
END SUB
