'QBasic FADEing - The real thing.
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'From Manny Najera of Flash Games
'--------------------------------
'   http://www.flashgames.com
'--------------------------------

'How To Use This Stuff
'---------------------
'To fade out, just use PALETTE.FADEOUT.
'PALETTE.FADEIN will work after you fadeout.
'If you mess around with the pData array in
'between, it won't work correctly.  All the
'other subs you don't have to worry about.
'The FLICKERING?  Its not as bad as before.
'Live with it.  It happens to the best of us.
'Use this code NOW!  I'm tired of looking at
'those fake fades.

DEFINT A-Z      ' always defint a-z!

'Just add this into your program.
'---------------------------------

TYPE PaletteType
Red AS INTEGER
Green AS INTEGER
Blue AS INTEGER
END TYPE
DECLARE SUB Palette.Set (nColor%, pInfo AS PaletteType)
DECLARE SUB Palette.Get (nColor%, pInfo AS PaletteType)
DECLARE SUB Palette.Fadeout ()
DECLARE SUB Palette.FadeIn ()
DIM SHARED Pal AS PaletteType
DIM SHARED pData(0 TO 255, 1 TO 3)

'---------------------------------

SCREEN 13
FOR I = 0 TO 200
LINE (0, I)-(319, I), I
NEXT I
SLEEP
Palette.Fadeout
SLEEP
Palette.FadeIn

SUB Palette.FadeIn
DIM tT(1 TO 3)
FOR I = 1 TO 64
WAIT &H3DA, 8, 8
  FOR O = 0 TO 255
    Palette.Get O, Pal
    tT(1) = Pal.Red
    tT(2) = Pal.Green
    tT(3) = Pal.Blue
    IF tT(1) < pData(O, 1) THEN tT(1) = tT(1) + 1
    IF tT(2) < pData(O, 2) THEN tT(2) = tT(2) + 1
    IF tT(3) < pData(O, 3) THEN tT(3) = tT(3) + 1
    Pal.Red = tT(1)
    Pal.Green = tT(2)
    Pal.Blue = tT(3)
    Palette.Set O, Pal
  NEXT O
NEXT I

END SUB

SUB Palette.Fadeout
DIM tT(1 TO 3)
FOR I = 0 TO 255
  Palette.Get I, Pal
  pData(I, 1) = Pal.Red
  pData(I, 2) = Pal.Green
  pData(I, 3) = Pal.Blue
NEXT I
FOR I = 1 TO 64
WAIT &H3DA, 8, 8
  FOR O = 0 TO 255
    Palette.Get O, Pal
    tT(1) = Pal.Red
    tT(2) = Pal.Green
    tT(3) = Pal.Blue
    IF tT(1) > 0 THEN tT(1) = tT(1) - 1
    IF tT(2) > 0 THEN tT(2) = tT(2) - 1
    IF tT(3) > 0 THEN tT(3) = tT(3) - 1
    Pal.Red = tT(1)
    Pal.Green = tT(2)
    Pal.Blue = tT(3)
    Palette.Set O, Pal
  NEXT O
NEXT I
END SUB

SUB Palette.Get (nColor%, pInfo AS PaletteType)
OUT &H3C6, &HFF
OUT &H3C7, nColor%
pInfo.Red = INP(&H3C9)
pInfo.Green = INP(&H3C9)
pInfo.Blue = INP(&H3C9)
END SUB

SUB Palette.Set (nColor%, pInfo AS PaletteType)
OUT &H3C6, &HFF
OUT &H3C8, nColor%
OUT &H3C9, pInfo.Red
OUT &H3C9, pInfo.Green
OUT &H3C9, pInfo.Blue
END SUB


