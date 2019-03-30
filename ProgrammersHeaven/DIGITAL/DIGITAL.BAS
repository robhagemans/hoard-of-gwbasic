' A lot of people keep asking us, "How do I put digitized graphics in
' my game?"  Here is the answer we are providing.  It's up to you to
' get your own pictures, manage your palettes wisely, and determine
' the proper amount of disk space to use for smaller pictures.  This
' program will load a 256 color GIF (The GIF routines are from Wrox Press,
' authors of "The Revolutionary Guide to QBasic", a great book) and save
' the entire image to disk.  This program *could* just copy the screen
' segment to disk, but we load it into an array for ease of use when
' you want to save a smaller slice of the screen.  We really shouldn't have
' to have made this program.  We're sure that anyone that puts any amount
' of effort into figuring out how to do this could reach the solution
' quickly, but nobody that emails us seems to want to do that, they just
' want the answer.  So this will probably be the last example code we
' create.

'  programmed by Molnar \ Kucalaba Productions
'  ftp : ftp://users.aol.com/blood225
'  www : http://members.aol.com/mkwebsite

' ( See DIGITAL2.BAS for loading and displaying the files created with this
' program. )



DEFINT A-Z
DECLARE SUB WritePal (FileName$)
DECLARE SUB MemToDisk (Segment&, Offset&, FileName$)
DIM SHARED Byte AS STRING * 1
DIM Prefix(4095), Suffix(4095), OutStack(4095), shiftout%(8)
DIM Ybase AS LONG, powersof2(11) AS LONG, WorkCode AS LONG
 
FOR A% = 0 TO 7: shiftout%(8 - A%) = 2 ^ A%: NEXT A%
FOR A% = 0 TO 11: powersof2(A%) = 2 ^ A%: NEXT A%
INPUT "Type in Path and Filename..."; A$
IF A$ = "" THEN INPUT "GIF file"; A$: IF A$ = "" THEN END
IF INSTR(A$, ".") = 0 THEN A$ = A$ + ".gif"
OPEN A$ FOR BINARY AS #1
A$ = "      ": GET #1, , A$
IF A$ <> "GIF87a" THEN PRINT "Not a GIF87a file.": END
GET #1, , TotalX: GET #1, , TotalY: GOSUB GetByte
NumColors = 2 ^ ((A% AND 7) + 1): NoPalette = (A% AND 128) = 0
GOSUB GetByte: Background = A%
GOSUB GetByte: IF A% <> 0 THEN PRINT "Bad screen descriptor.": END
IF NoPalette = 0 THEN P$ = SPACE$(NumColors * 3): GET #1, , P$
DO
    GOSUB GetByte
    IF A% = 44 THEN
        EXIT DO
    ELSEIF A% <> 33 THEN
        PRINT "Unknown extension type.": END
    END IF
    GOSUB GetByte
    DO: GOSUB GetByte: A$ = SPACE$(A%): GET #1, , A$: LOOP UNTIL A% = 0
LOOP
GET #1, , XStart: GET #1, , YStart: GET #1, , XLength: GET #1, , YLength
XEnd = XStart + XLength: YEnd = YStart + YLength: GOSUB GetByte
IF A% AND 128 THEN PRINT "Can't handle local colormaps.": END
Interlaced = A% AND 64: PassNumber = 0: PassStep = 8
GOSUB GetByte
ClearCode = 2 ^ A%
EOSCode = ClearCode + 1
FirstCode = ClearCode + 2: NextCode = FirstCode
StartCodeSize = A% + 1: CodeSize = StartCodeSize
StartMaxCode = 2 ^ (A% + 1) - 1: MaxCode = StartMaxCode
 
BitsIn = 0: BlockSize = 0: BlockPointer = 1
X% = XStart: Y% = YStart: Ybase = Y% * 320&
 
SCREEN 13: DEF SEG = &HA000
IF NoPalette = 0 THEN
    OUT &H3C7, 0: OUT &H3C8, 0
    FOR A% = 1 TO NumColors * 3: OUT &H3C9, ASC(MID$(P$, A%, 1)) \ 4: NEXT A%
END IF
LINE (0, 0)-(319, 199), Background, BF
DO
    GOSUB GetCode
    IF Code <> EOSCode THEN
        IF Code = ClearCode THEN
            NextCode = FirstCode
            CodeSize = StartCodeSize
            MaxCode = StartMaxCode
            GOSUB GetCode
            CurCode = Code: LastCode = Code: LastPixel = Code
            IF X% < 320 THEN POKE X% + Ybase, LastPixel
            X% = X% + 1: IF X% = XEnd THEN GOSUB NextScanLine
        ELSE
            CurCode = Code: StackPointer = 0
            IF Code > NextCode THEN EXIT DO
            IF Code = NextCode THEN
                CurCode = LastCode
                OutStack(StackPointer) = LastPixel
                StackPointer = StackPointer + 1
            END IF
 
            DO WHILE CurCode >= FirstCode
                OutStack(StackPointer) = Suffix(CurCode)
                StackPointer = StackPointer + 1
                CurCode = Prefix(CurCode)
            LOOP
 
            LastPixel = CurCode
            IF X% < 320 THEN POKE X% + Ybase, LastPixel
            X% = X% + 1: IF X% = XEnd THEN GOSUB NextScanLine
 
            FOR A% = StackPointer - 1 TO 0 STEP -1
                IF X% < 320 THEN POKE X% + Ybase, OutStack(A%)
                X% = X% + 1: IF X% = XEnd THEN GOSUB NextScanLine
            NEXT A%
 
            IF NextCode < 4096 THEN
                Prefix(NextCode) = LastCode
                Suffix(NextCode) = LastPixel
                NextCode = NextCode + 1
                IF NextCode > MaxCode AND CodeSize < 12 THEN
                    CodeSize = CodeSize + 1
                    MaxCode = MaxCode * 2 + 1
                END IF
            END IF
            LastCode = Code
        END IF
    END IF
LOOP UNTIL DoneFlag OR Code = EOSCode
GOTO LeaveProc

GetByte: A$ = " ": GET #1, , A$: A% = ASC(A$): RETURN
 
NextScanLine:
    IF Interlaced THEN
        Y% = Y% + PassStep
        IF Y% >= YEnd THEN
            PassNumber = PassNumber + 1
            SELECT CASE PassNumber
            CASE 1: Y% = 4: PassStep = 8
            CASE 2: Y% = 2: PassStep = 4
            CASE 3: Y% = 1: PassStep = 2
            END SELECT
        END IF
    ELSE
        Y% = Y% + 1
    END IF
    X% = XStart: Ybase = Y% * 320&: DoneFlag = Y% > 199
RETURN
GetCode:
    IF BitsIn = 0 THEN GOSUB ReadBufferedByte: LastChar = A%: BitsIn = 8
    WorkCode = LastChar \ shiftout%(BitsIn)
    DO WHILE CodeSize > BitsIn
        GOSUB ReadBufferedByte: LastChar = A%
        WorkCode = WorkCode OR LastChar * powersof2(BitsIn)
        BitsIn = BitsIn + 8
    LOOP
    BitsIn = BitsIn - CodeSize
    Code = WorkCode AND MaxCode
RETURN
ReadBufferedByte:
    IF BlockPointer > BlockSize THEN
        GOSUB GetByte: BlockSize = A%
        A$ = SPACE$(BlockSize): GET #1, , A$
        BlockPointer = 1
    END IF
    A% = ASC(MID$(A$, BlockPointer, 1)): BlockPointer = BlockPointer + 1
RETURN
LeaveProc:
CLOSE
'----- End of GIF routine ------


' Hey, pay attention and we'll show you a trick for getting around using
' DIM SHARED for buffers that are used in SUBs.
DIM ScreenBuffer(32001) AS INTEGER

GET (0, 0)-(319, 199), ScreenBuffer

MemToDisk VARSEG(ScreenBuffer(0)), VARPTR(ScreenBuffer(0)), "sample.img" '
WritePal "sample.pal"

CLS
SCREEN 0
WIDTH 80
PRINT "Neccesary files successfully created."
SYSTEM

SUB MemToDisk (Segment&, Offset&, FileName$)
DEF SEG = Segment&
 BSAVE FileName$, Offset&, 64002
 ' We assume you are wise enough to use integers
DEF SEG

' Or you could do this, our preferred method :

' DEF SEG = &HA000
'  BSAVE FIleName$, 0, 64000
' DEF SEG

' Why is that better?  Because...

'  1)  No need to ever load anything into memory.
'  2)  Saves you 2 bytes.  (The 1st integer in a GET array is X and Y length)
'  3)  It just is.

END SUB

SUB WritePal (FileName$)
' WritePal : Creates a 768-byte palette file.
OPEN FileName$ FOR BINARY AS #1
FOR Att% = 0 TO 255
 OUT &H3C7, Att%
  FOR RedGreenAndBlue% = 1 TO 3
   Buffer% = INP(&H3C9)
   Byte = CHR$(Buffer%)
   PUT #1, , Byte
  NEXT RedGreenAndBlue%
NEXT Att%
CLOSE #1
END SUB

