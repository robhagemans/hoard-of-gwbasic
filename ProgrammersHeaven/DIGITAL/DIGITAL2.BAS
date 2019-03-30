' Displaying graphics files.

'  programmed by Molnar \ Kucalaba Productions
'  ftp : ftp://users.aol.com/blood225
'  www : http://members.aol.com/mkwebsite


' ( See DIGITAL.BAS for loading GIFs are creating the graphics files. )


DECLARE SUB PalLoad (FileName$)
DEFINT A-Z
CLS
SCREEN 13

DIM ScreenBuffer(32001)
DIM SHARED Byte AS STRING * 1

DEF SEG = VARSEG(ScreenBuffer(0))
 BLOAD "sample.img", VARPTR(ScreenBuffer(0))
DEF SEG


PalLoad "sample.pal"

PUT (0, 0), ScreenBuffer

DO
LOOP WHILE INKEY$ = ""

SUB PalLoad (FileName$)
OPEN FileName$ FOR BINARY AS #1
 FOR Att% = 0 TO 255
  OUT &H3C8, Att%
   FOR RedGreenAndBlue% = 1 TO 3
    GET #1, , Byte
    Valew% = ASC(Byte)
    OUT &H3C9, Valew%
   NEXT RedGreenAndBlue%
 NEXT Att%
CLOSE #1
END SUB

