'This QuickBASIC 4.5 program will decompress and show most 256
'color pictures in the GIF87a format.
'Interlaced pictures & pictures with local colormaps won't be handled
'properly without modifying this program.

'It isn't the fastest or most featured, but it gets the job done!
'Hope that helps somebody out there!


DEFINT A-Z

DECLARE FUNCTION Getbit ()
DECLARE FUNCTION ReadCode (CodeSize)
DECLARE SUB Plot (A)

CONST True = -1, False = 0

DIM ByteBuffer AS STRING * 1
DIM Powers(8), Prefix(4096), Suffix(4096), Outcode(1024)
DIM MaxCodes(12), Powers2(16), Pal(255) AS LONG
DIM SHARED Xstart, Xend

FOR A = 1 TO 8: Powers(A) = 2 ^ (A - 1): NEXT
DATA 4,8,16,&h20,&h40,&h80,&h100,&h200,&h400,&h800,&h1000,8192

FOR A = 0 TO 11: READ MaxCodes(A): NEXT
DATA 1,3,7,15,31,63,127,255

FOR A = 1 TO 8: READ CodeMask(A): NEXT
DATA 1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384

FOR A = 0 TO 14: READ Powers2(A): NEXT

PRINT
PRINT "GIF Decompressor"
PRINT "By Rich Geldreich 1991"
PRINT "For any questions, comments, or complaints, I can be contacted at..."
PRINT "410 Market St."
PRINT "Gloucester City, New Jersey 08030"
PRINT "(609)-456-0721"

INPUT "Filename"; F$
IF LTRIM$(RTRIM$(F$)) = "" THEN END

IF INSTR(F$, ".") = 0 THEN
    F$ = F$ + ".GIF"
END IF


OPEN F$ FOR BINARY AS #1 LEN = 1
IF LOF(1) = 0 THEN PRINT "File not found!": CLOSE : KILL F$: END

FOR A = 1 TO 6
    GET #1, , ByteBuffer: A$ = A$ + ByteBuffer
NEXT
IF A$ <> "GIF87a" THEN
    PRINT "Warning, the "; A$; " protocol is being used in this file."
    LINE INPUT "Proceed anyway(Y/N)?"; A$
    IF UCASE$(A$) <> "Y" THEN END
END IF

GET #1, , TotalX
GET #1, , TotalY

GET #1, , ByteBuffer: A = ASC(ByteBuffer)
BitsPixel = (A AND 7) + 1

GET #1, , ByteBuffer: Background = ASC(ByteBuffer)
GET #1, , ByteBuffer

IF ASC(ByteBuffer) <> 0 THEN
    PRINT "Bad file."
    END
END IF

FOR A = 0 TO 2 ^ BitsPixel - 1
    GET #1, , ByteBuffer: Red = ASC(ByteBuffer)
    GET #1, , ByteBuffer: Green = ASC(ByteBuffer)
    GET #1, , ByteBuffer: Blue = ASC(ByteBuffer)
    Pal(A) = (Red \ 4) + (Green \ 4) * 256 + (Blue \ 4) * 65536
NEXT

GET #1, , ByteBuffer
IF ByteBuffer <> "," THEN
    PRINT "Bad file."
    END
END IF

GET #1, , Xstart
GET #1, , Ystart
GET #1, , Xlength
GET #1, , Ylength
Xend = Xlength + Xstart - 1: Yend = Ylength + Ystart - 1

GET #1, , ByteBuffer
A = ASC(ByteBuffer)
IF (A AND 128) = 128 THEN
    PRINT "Local colormap encountered."
    END
ELSEIF (A AND 64) = 64 THEN
    PRINT "Image is interlaced!"
    END
END IF

GET #1, , ByteBuffer
CodeSize = ASC(ByteBuffer): ClearCode = Powers2(CodeSize)
EOFCode = ClearCode + 1: FirstFree = ClearCode + 2
FreeCode = FirstFree: CodeSize = CodeSize + 1
InitCodeSize = CodeSize: Maxcode = MaxCodes(CodeSize - 2)
Bitmask = CodeMask(BitsPixel)

GET #1, , ByteBuffer
BlockLength = ASC(ByteBuffer) + 1: Bitsin = 8
OutCount = 0
X = Xstart: Y = Ystart

ON ERROR GOTO NoVGA
SCREEN 13
ON ERROR GOTO 0

LINE (0, 0)-(319, 199), Background, BF
PALETTE USING Pal(0)


DO
    Code = ReadCode(CodeSize)
    IF Code <> EOFCode THEN
        IF Code = ClearCode THEN
            CodeSize = InitCodeSize
            Maxcode = MaxCodes(CodeSize - 2): FreeCode = FirstFree
            Code = ReadCode(CodeSize): CurCode = Code
            OldCode = Code: FinChar = Code AND Bitmask
            Plot FinChar
        ELSE
            CurCode = Code: InCode = Code
            IF Code >= FreeCode THEN
                CurCode = OldCode
                Outcode(OutCount) = FinChar
                OutCount = OutCount + 1
            END IF
            IF CurCode > Bitmask THEN
                DO
                    Outcode(OutCount) = Suffix(CurCode)
                    OutCount = OutCount + 1
                    CurCode = Prefix(CurCode)
                LOOP UNTIL CurCode <= Bitmask
            END IF
            FinChar = CurCode AND Bitmask
            Outcode(OutCount) = FinChar
            OutCount = OutCount + 1
            FOR I = OutCount - 1 TO 0 STEP -1
                Plot Outcode(I)
            NEXT
            OutCount = 0
            Prefix(FreeCode) = OldCode: Suffix(FreeCode) = FinChar
            OldCode = InCode: FreeCode = FreeCode + 1
            IF FreeCode >= Maxcode THEN
                IF CodeSize < 12 THEN
                    CodeSize = CodeSize + 1: Maxcode = Maxcode * 2
                END IF
            END IF
        END IF
    END IF
    A$ = INKEY$
LOOP UNTIL Code = EOFCode OR A$ <> ""
BEEP
IF A$ = "" THEN A$ = INPUT$(1)
END

'This subroutine gets called when a VGA adapter isn't found.
NoVGA:
    PRINT "Sorry, this program requires a VGA adapter."
    PRINT "See ya when you get more $$$!"
END


'This subprogram gets one bit from the data stream.
FUNCTION Getbit STATIC
    SHARED ByteBuffer AS STRING * 1, Powers(), Bitsin, BlockLength, Num
    Bitsin = Bitsin + 1
    IF Bitsin = 9 THEN
        GET #1, , ByteBuffer
        TempChar = ASC(ByteBuffer)
        Bitsin = 1
        Num = Num + 1
        IF Num = BlockLength THEN
            BlockLength = TempChar + 1
            GET #1, , ByteBuffer
            TempChar = ASC(ByteBuffer)
            Num = 1
        END IF
    END IF
    IF (TempChar AND Powers(Bitsin)) = 0 THEN Getbit = 0 ELSE Getbit = 1
END FUNCTION

'This subprogram plots one pixel on the display.
SUB Plot (A) STATIC
    PSET (X, Y), A
    X = X + 1
    IF X > Xend THEN
        X = Xstart
        Y = Y + 1
    END IF
END SUB

'This subprogram reads one LZW code from the data stream.
FUNCTION ReadCode (CodeSize)
    SHARED Powers2()
    Code = 0
    FOR Aa = 0 TO CodeSize - 1
        Code = Code + Getbit * Powers2(Aa)
    NEXT
    ReadCode = Code
END FUNCTION

