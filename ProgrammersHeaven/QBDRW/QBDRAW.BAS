DECLARE SUB PalLoad (PalFile$)
DECLARE SUB OpenPic2 (Pic1%())
DECLARE FUNCTION OpenPic1! (FileName$)
CLS
SCREEN 13
TYPE PalType
 r AS INTEGER
 g AS INTEGER
 B AS INTEGER
END TYPE
DIM SHARED DimSize AS INTEGER
DIM SHARED pall(256) AS PalType
DIM SHARED pal(768)

'*********************************************
' QB draw source code loader | (C) Lior Zur, 1997
'*********************************************
' Contact: zur@inter.net.il
'*********************************************
' The code above is required !
' in order to load picture, you
' use two sub programs. Call the first,
' to get all the info about the picture
' such as version, array size and more.
'**** be aware of: ****
' - Put the file name when
'   calling this function WITHOUT .PIC !!
' - This function leaves the file open !!
' - This function also closes any opened file !!
'**********************
' Then, you have to declare array in the
' size of DimSize - the integer that the
' first function brought as the array size data.
' Then, call the secend sub (OpenPic2) to complete
' loading the picture into the array you declared.
' The array must be integer !
'******************************
' the first function gives you error codes, if something's wrong. Here they
' are:
'******************************
'-1 there is no such file !
'-2 not QB draw file !
'-3 file made by later version
' 0 everything is fine !
'******************************
'also, there is the sub PalLoad to load palettes.

PalLoad "draw"

n = OpenPic1("welcome")    '-+
IF n = 0 THEN              ' |
DIM lior%(DimSize)         ' +----- that code requered to open image.
OpenPic2 lior%()           ' |
END IF                     '-+

PUT (1, 1), lior%       'Now, put the picture !



FUNCTION OpenPic1 (FileName$)
CLOSE
OPEN FileName$ + ".PIC" FOR BINARY AS #1
   IF LOF(1) = 0 THEN
          CLOSE #1
          KILL FileName$ + ".PIC"
          OpenPic1 = -1
          EXIT FUNCTION
   END IF
DIM LiorByte AS STRING * 1
 FOR i% = 1 TO 6
  GET #1, , LiorByte
  Id$ = Id$ + LiorByte
 NEXT i%
IF Id$ <> "QBDRAW" THEN
  CLOSE #1
  OpenPic1 = -2
  EXIT FUNCTION
END IF
DIM ver AS INTEGER
GET #1, , ver
IF ver > 1 THEN
  CLOSE #1
  OpenPic1 = -3
  EXIT FUNCTION
END IF
DIM Xis AS INTEGER
DIM Yis AS INTEGER
GET #1, , Xis
GET #1, , Yis
GET #1, , DimSize
OpenPic = 0
END FUNCTION

SUB OpenPic2 (Pic1%())
FOR i = 0 TO DimSize
 GET #1, , Pic1%(i)
NEXT i
CLOSE #1
END SUB

SUB PalLoad (PalFile$)
 CLOSE
 OPEN PalFile$ + ".PAL" FOR BINARY AS #1
   IF LOF(1) = 0 THEN
          CLOSE #1
          KILL PalFile$ + ".PAL"
          EXIT SUB
   END IF
  CLOSE #1
 OPEN PalFile$ + ".PAL" FOR INPUT AS #1
  FOR i = 1 TO 768
   INPUT #1, pal(i)
  NEXT i
 CLOSE #1
 num = 1
 an = 1
  DO
   pall(an).r = pal(num)
   num = num + 1
   pall(an).g = pal(num)
   num = num + 1
   pall(an).B = pal(num)
   num = num + 1
   an = an + 1
  LOOP UNTIL num > 768
 OUT &H3C7, 0: OUT &H3C8, 0
 FOR a% = 1 TO 256 * 3:
  OUT &H3C9, pal(a%)
 NEXT a%
END SUB

