' ==================== Browser 1.0 =======================
' by Victor Yiu (1:106/30), July 1993.  Released into Public Domain.
'
'              *** LOAD WITH /AH SWITCH ***
' This program is a binary file viewer, in hex and ascii,
' made to look like Calvin French's HEXVIEW, PCTools' View,
' Norton's DiskEdit, and numerous others.  It uses my public-
' domain SuperHex library, written in optimized assembly -- so
' it is FAST!
'
'       BC BROWSER /O;
'       LINK /FARC /PACKC:64000 BROWSER+C:\QB\NOCOM,,,C:\QB\BCOM45+SUPERHEX;
'            ^ (include "/EX" if you won't use LZEXE or PKLITE)
'
' Compared to Clavin's HEXVIEW:
'   o  Mine can open files up to 128k
'   o  Mine is 5 million times faster (faster than PCTools or Norton)
'   o  Has a built-in text filter
'   o  Acceptable on an 4.77 MHz XT!
'   o  Compiles to only 25K with LZEXE or PKLITE!
'
' Next version will include search and editing features.
'
' Speed comparison (on a 10MHz XT)*:
'       Calvin French's HEXVIEW:   .55 K/sec
'             PCTool's 4.x Edit:     3 K/sec
'         Victor's SuperHEX (!):    20 K/sec   --->  WOW!
'
'  * I didn't do timing on my 486 because it was too darn fast!
'
' By the way -- try loading a file from the floppy -- it's fun!
' ============================================================

DEFINT A-Z      ' $DYNAMIC

CONST Block = 8192, PageSize = 16 * 21, LastDataLine = 23
CONST DataFG = 7, DataBG = 1, Attrib = DataFG + DataBG * 16
CONST False = 0, True = NOT False

DECLARE SUB AdjustLastBytes (Row%)
DECLARE SUB CheckPointer (Num&)
DECLARE SUB DrawInterface ()
DECLARE SUB DrawScreen ()
DECLARE SUB LoadFile (LOFile&)
DECLARE SUB PrintHex (Num&)
DECLARE SUB ShowHex (Posit&)
DECLARE FUNCTION GetAdapterSeg% ()
DECLARE FUNCTION Signed% (Num&)

DECLARE SUB Scroll (BYVAL GoUp, BYVAL Attrib)
DECLARE SUB MemCopy (BYVAL SegFrom, BYVAL OffFrom, BYVAL SegTo, BYVAL OffTo, BYVAL Leng)
DECLARE SUB SuperHex (BYVAL VidSeg, BYVAL Row, BYVAL OffsetHex, BYVAL OffsetASCii, BYVAL segment, BYVAL Offset, BYVAL BackColor, BYVAL FilterOn)
' VidSeg     = Video segment of adapter (B800 for color, B000 for mono)
' Row        = Row to display data (1-25)
' OffsetHex  = Column to display the hex digits (1-)
' OffsetASCii= Column to display the characters themselves (1-)
' Segment    = Segment of source data
' Offset     = Offset of source data
' BackColor  = Background color in a packed byte:
'                (BackGround * 16) + ForeGround

IF LEN(COMMAND$) = 0 THEN
    PRINT "Syntax:"
    PRINT "   BROWSER <filename>"
    END
END IF

DIM SHARED VidSegment, Pointer&, LastBox, LOFile&, FilterOn

OPEN COMMAND$ FOR BINARY AS #1
LOFile& = LOF(1)
IF (LOFile& + 3000 > FRE(-1)) OR (LOFile& > 131000) THEN PRINT "File too big.": END
IF LOFile& = 0 THEN CLOSE : PRINT COMMAND$; " does not exist.": KILL COMMAND$: END

DIM SHARED Array&(LOFile& \ 4& + 4)
Pointer& = 0: LastBox = 4: Null$ = CHR$(0)

CLS
VidSegment = GetAdapterSeg
DrawInterface
LOCATE 12, 33: COLOR 31, 3
PRINT " Loading file ... "; : COLOR 7

LoadFile LOFile&

IF LOFile& - 16 < PageSize THEN
    LOCATE 12, 33: COLOR , 1
    PRINT SPACE$(40);
END IF

DrawScreen
DO
    DO: I$ = INKEY$
    LOOP UNTIL LEN(I$)
    IF LEN(I$) = 1 THEN I$ = UCASE$(I$)

    SELECT CASE I$
        CASE Null$ + "Q", CHR$(13), " "   ' PageDown
            Pointer& = Pointer& + PageSize
            CheckPointer Pointer&
        CASE Null$ + "I"        ' PageUp
            Pointer& = Pointer& - PageSize
            CheckPointer Pointer&
        CASE Null$ + "P"        ' Down
            IF Pointer& + PageSize < LOFile& THEN
                Scroll 0, LastDataLine
                Pointer& = Pointer& + 16
                ShowHex Pointer&
   
                Temp& = Pointer& + PageSize - 16
                LOCATE LastDataLine, 3: COLOR 14
                PrintHex Temp&

                SuperHex VidSegment, LastDataLine, 10, 62, Signed(VARSEG(Array&(0)) + Temp& \ 16), VARPTR(Array&(0)), Attrib, FilterOn
                IF LOFile& - Temp& < 15 THEN AdjustLastBytes LastDataLine
            END IF
        CASE Null$ + "H"        ' Up
            IF Pointer& >= 16 THEN
                Scroll -1, LastDataLine
                Pointer& = Pointer& - 16
                ShowHex Pointer&

                LOCATE 3, 3: COLOR 14
                PrintHex Pointer&
                SuperHex VidSegment, 3, 10, 62, Signed(VARSEG(Array&(0)) + Pointer& \ 16), VARPTR(Array&(0)), Attrib, FilterOn
            END IF
        CASE Null$ + "G"        ' Home
            Pointer& = 0
            DrawScreen
        CASE Null$ + "O"        ' End
            Pointer& = LOFile&
            CheckPointer Pointer&
        CASE "F"                ' toggle filter
            FilterOn = NOT FilterOn
            DrawScreen

            LOCATE 25, 58: COLOR 4, 3
            IF FilterOn THEN PRINT CHR$(251);  ELSE PRINT " ";
        CASE ELSE
    END SELECT
LOOP UNTIL I$ = CHR$(27)

COLOR 7, 0: CLS
PRINT "Thanks for trying Browser 1.0!"
PRINT
END

REM $STATIC
SUB AdjustLastBytes (Row)

    Remov = 16 - (LOFile& AND 15)
    LOCATE Row, 58 - Remov * 3
    PRINT SPACE$(Remov * 3 + 1);
    LOCATE , 78 - Remov
    PRINT SPACE$(Remov);

END SUB

SUB CheckPointer (Num&)

IF Num& + PageSize - 15 > LOFile& THEN
    Num& = LOFile& + 15 - PageSize
END IF

IF Num& < 0 THEN Num& = 0
DrawScreen

END SUB

SUB DrawInterface

COLOR 14, 12
PRINT " Browser 1.0  þ  by Victor Yiu, July 1993  þ  Idea from Calvin French's HEXVIEW "
COLOR 15, 1
PRINT CHR$(218); CHR$(196); CHR$(180);
COLOR 15, 3: PRINT " "; COMMAND$; " "; : COLOR 15, 1
PRINT CHR$(195); STRING$(80 - POS(0), 196); CHR$(191)

FOR Lin = 3 TO LastDataLine
    LOCATE Lin, 1: PRINT CHR$(179); SPACE$(78);

    IF Lin = 3 THEN
        PRINT CHR$(24);
    ELSEIF Lin = LastDataLine THEN
        PRINT CHR$(25);
    ELSE
        PRINT CHR$(176);
    END IF
NEXT

LOCATE 4, 80, 0: PRINT CHR$(219);
LOCATE 24, 1: PRINT CHR$(192); CHR$(196); CHR$(180);
COLOR 13: PRINT "       (     )/"; LTRIM$(STR$(LOF(1)));
COLOR 15: PRINT " "; CHR$(195); STRING$(80 - POS(1), 196); CHR$(217);

LOCATE 25, 1: COLOR 14, 3
PRINT " Adjust Viewport "; : COLOR 15
PRINT "[PgUp/PgDn] [Up/Down] [Home/End]         [F]=Filter [Esc]=Quit ";

END SUB

SUB DrawScreen
STATIC NotOnePage, L    ' 1=True, 2=False, 0=first call

IF NotOnePage = 0 THEN
    IF LOFile& - 16 < PageSize THEN
        NotOnePage = 1
        L = (LOFile& - 1) \ 16 + 3
    ELSE
        NotOnePage = 2
        L = LastDataLine
    END IF
END IF

ShowHex Pointer&
COLOR 14

Temp& = Pointer&
FOR Row = 0 TO L - 3
    SuperHex VidSegment, Row + 3, 10, 62, Signed(VARSEG(Array&(0)) + Temp& \ 16), VARPTR(Array&(0)), Attrib, FilterOn

    LOCATE Row + 3, 3, 0
    PrintHex Temp&

    Temp& = Temp& + 16
NEXT

IF Temp& > LOFile& THEN AdjustLastBytes L

END SUB

FUNCTION GetAdapterSeg
    DEF SEG = 0
    ColorM = (PEEK(&H410) AND 48) <> 48
    DEF SEG 'Monocrome--^                       ^
            'Color Graphics Adapter or better --|

    IF ColorM THEN GetAdapterSeg = &HB800 ELSE GetAdapterSeg = &HB000
END FUNCTION

SUB LoadFile (LOFile&)

Dummy& = FRE("")

TempStor$ = SPACE$(Block)
Start& = VARSEG(Array&(0))

FOR LoadUp = 1 TO LOFile& \ Block
    GET #1, , TempStor$
    MemCopy VARSEG(TempStor$), SADD(TempStor$), Signed(Start&), VARPTR(Array&(0)), Block
    Start& = Start& + Block \ 16
    ShowHex LoadUp * 1& * Block
NEXT

TempStor$ = SPACE$(LOFile& MOD Block)
GET #1, , TempStor$
MemCopy VARSEG(TempStor$), SADD(TempStor$), Signed(Start&), 0, LEN(TempStor$)
    ' *** SSEG to VARSEG for QB/QBASIC users!
END SUB

SUB PrintHex (Num&)

    'PRINT MID$(HEX$(Num& + &H100000), 2);
    PRINT RIGHT$("0000" + HEX$(Num&), 5);

END SUB

SUB ShowHex (Posit&) STATIC

COLOR 15, 1
LOCATE 24, 5
PRINT USING "######"; Posit&;
LOCATE , 12
PrintHex Posit&

LOCATE LastBox, 80
PRINT CHR$(176);
LastBox = Posit& * 18 \ LOFile& + 4
LOCATE LastBox, 80
PRINT CHR$(219);

END SUB

FUNCTION Signed (Num&)

    IF Num& > 32767 THEN
        Signed = Num& - 65536
    ELSE
        Signed = Num&
    END IF

END FUNCTION

