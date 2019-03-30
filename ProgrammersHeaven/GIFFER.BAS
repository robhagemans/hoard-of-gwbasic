'
' 07-05-93. 13:57:41 GIFFER.TBB
'This is , again, a real neat source by Rich Geldreich.
'Translated to PB3 by Thaddy de Koning.
'Yep, it works in screen 13!
'So pb has no screen 13?
'A small interrupt call to the videointerrupt does the job.
'It can be modified to run even faster, but it's pretty fast as it is.
'You DON'T need to link it with the graphics lib, because none of the
'graphics commands are used.

'Cheap, no frills GIF decompressor for the VGA's 320x200x256 mode.
'By Rich Geldreich 1992 (Public domain, use as you wish.)
$LIB ALL OFF
$OPTIMIZE SPEED
'$CPU 80386

DEFINT A-Z
DIM Prefix(4095), Suffix(4095), OutStack(4095), ShiftOut(8)
DIM Ybase AS word, Powersof2(11) AS integer, WorkCode AS integer

FOR A = 0 TO 7
  ShiftOut(8 - A) = 2 ^ A
NEXT

FOR A = 0 TO 11
  Powersof2(A) = 2 ^ A
NEXT

A$ = COMMAND$
IF A$ = "" THEN
  INPUT "GIF file"; A$
  IF A$ = "" THEN
    END
  END IF
END IF

IF INSTR(A$, ".") = 0 THEN
  A$ = A$ + ".gif"
END IF

OPEN A$ FOR BINARY AS #1
GET$ #1,6, A$
IF A$ <> "GIF87a" THEN
  PRINT "Not a GIF87a file."
  END
END IF
GET #1, , TotalX
GET #1, , TotalY

GOSUB GetByte

NumColors = 2 ^ ((a AND 7) + 1)
NoPalette = (a AND 128) = 0
GOSUB GetByte
Background = a
GOSUB GetByte
IF a <> 0 THEN
  PRINT "Bad screen descriptor."
  END
END IF

IF NoPalette = 0 THEN
  P$ = SPACE$(NumColors * 3)
  GET #1, , P$
END IF

DO
  GOSUB GetByte
  IF a = 44 THEN
    EXIT DO
  ELSEIF a <> 33 THEN
    PRINT "Unknown extension type."
    END
  END IF
  GOSUB GetByte
  DO
    GOSUB GetByte
	 GET$ #1,a , A$
  LOOP UNTIL a = 0
LOOP
GET #1, , XStart
GET #1, , YStart
GET #1, , XLength
GET #1, , YLength
XEnd = XStart + XLength
YEnd = YStart + YLength
GOSUB GetByte
IF a AND 128 THEN
  PRINT "Can't handle local colormaps."
  END
END IF
Interlaced = a AND 64
PassNumber = 0
PassStep = 8
GOSUB GetByte
ClearCode = 2 ^ a
EOSCode = ClearCode + 1
FirstCode = ClearCode + 2
NextCode = FirstCode
StartCodeSize = a + 1
CodeSize = StartCodeSize
StartMaxCode = 2 ^ (a + 1) - 1
MaxCode = StartMaxCode
BitsIn = 0
BlockSize = 0
BlockPointer = 1
X = XStart
Y = YStart
Ybase = Y * 320&

'kick into screen 13

Reg 1,&h0013
call interrupt &h10

DEF SEG = &HA000
IF NoPalette = 0 THEN
  OUT &H3C7, 0
  OUT &H3C8, 0
  FOR A = 1 TO NumColors * 3
    OUT &H3C9, ASC(MID$(P$, A, 1)) \ 4
  NEXT
END IF

DO
  GOSUB GetCode
  IF Code <> EOSCode THEN
    IF Code = ClearCode THEN
      NextCode = FirstCode
      CodeSize = StartCodeSize
      MaxCode = StartMaxCode
      GOSUB GetCode
      CurCode = Code
      LastCode = Code
      LastPixel = Code
      IF X < 320 THEN
        POKE X + Ybase, LastPixel
      END IF
		INCR X
      IF X = XEnd THEN
        GOSUB NextScanLine
      END IF
    ELSE
      CurCode = Code
      StackPointer = 0
      IF Code > NextCode THEN           'bad GIF if this happens
        EXIT DO
      END IF
      IF Code = NextCode THEN
        CurCode = LastCode
        OutStack(StackPointer) = LastPixel
		  INCR StackPointer
      END IF
      DO WHILE CurCode >= FirstCode
        OutStack(StackPointer) = Suffix(CurCode)
		  INCR StackPointer
        CurCode = Prefix(CurCode)
      LOOP
      LastPixel = CurCode
      IF X < 320 THEN
        POKE X + Ybase, LastPixel
      END IF
		INCR X
      IF X = XEnd THEN
        GOSUB NextScanLine
      END IF
      FOR A = StackPointer - 1 TO 0 STEP -1
        IF X < 320 THEN
          POKE X + Ybase, OutStack(A)
        END IF
		  INCR X
        IF X = XEnd THEN
          GOSUB NextScanLine
        END IF
      NEXT
      IF NextCode < 4096 THEN
        Prefix(NextCode) = LastCode
        Suffix(NextCode) = LastPixel
		  INCR NextCode
        IF NextCode > MaxCode AND CodeSize < 12 THEN
			 INCR CodeSize
			 SHIFT LEFT MAXCODE,1
			 INCR MAXCODE
        END IF
      END IF
      LastCode = Code
    END IF
  END IF
LOOP UNTIL DoneFlag OR Code = EOSCode
BEEP

A$ = INPUT$(1)

reg 1,&h0003
call interrupt &h10
END

GetByte:
GET #1,, a?
a=a?
RETURN

NextScanLine:
IF Interlaced THEN
  Y = Y + PassStep
  IF Y >= YEnd THEN
	 INCR PassNumber
    SELECT CASE PassNumber
    CASE 1
      Y = 4
      PassStep = 8
    CASE 2
      Y = 2
      PassStep = 4
    CASE 3
      Y = 1
      PassStep = 2
    END SELECT
  END IF
ELSE
  INCR Y
END IF
X = XStart
Ybase = Y * 320&
DoneFlag = Y > 199
RETURN
GetCode:
IF BitsIn = 0 THEN
  GOSUB ReadBufferedByte
  LastChar = A
  BitsIn = 8
END IF
WorkCode = LastChar \ ShiftOut(BitsIn)
DO WHILE CodeSize > BitsIn
  GOSUB ReadBufferedByte
  LastChar = A
  WorkCode = WorkCode OR LastChar * Powersof2(BitsIn)
  INCR BitsIn,8
LOOP
BitsIn = BitsIn - CodeSize
Code = WorkCode AND MaxCode
RETURN
ReadBufferedByte:
IF BlockPointer > BlockSize THEN
  GOSUB GetByte
  BlockSize = A
  GET$ #1,blocksize , A$
  BlockPointer = 1
END IF
A = ASC(MID$(A$, BlockPointer, 1))
INCR BlockPointer
RETURN
