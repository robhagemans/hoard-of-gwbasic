
'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บThese are subprograms and functions that I have found useful over the lastบ
'บfew years.  Most I have written, some I have modified from stuff I found  บ
'บon BBS's or the 'Net.  I have used all these at one time or another and   บ
'บthey all seem to work fine.  A couple, like Scroll, provide functions thatบ
'บnormally are accessible only by CALL INTERRUPT.  These routines are not   บ
'บextensively commented but they're pretty self-explanatory so feel free to บ
'บuse and abuse 'em.  Do what you will, I believe in freeware.  If you have บ
'บa comment or have ideas for useful routines you may e-mail me at          บ
'บmattu@ix.netcom.com or 75342.1777@compuserve.com.                         บ
'บHave fun!  Matthew R. Usner 06/27/96                                      บ
'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

DECLARE FUNCTION AttributeByte% (Fore%, Back%)
DECLARE FUNCTION Background% (Row%, Col%)
DECLARE FUNCTION Bin% (Bit$)
DECLARE FUNCTION BinarySearch% (Array$(), Find$)
DECLARE FUNCTION BinDec& (Binary$)
DECLARE FUNCTION Capitalize$ (Orig$)
DECLARE FUNCTION CountIn% (Search$, LookFor$)
DECLARE FUNCTION Crunch$ (Text$, CTC$)
DECLARE FUNCTION CurrentDirectory$ ()
DECLARE FUNCTION DateToJulian! (Dat$)
DECLARE FUNCTION DateValid% (Month%, Day%, Year%)
DECLARE FUNCTION DayOfTheWeek$ (Dat$)
DECLARE FUNCTION DecBin$ (Decimal&)
DECLARE FUNCTION EnglishDate$ (Dat$)
DECLARE FUNCTION Foreground% (Row%, Col%)
DECLARE FUNCTION GetChar$ ()
DECLARE FUNCTION InputString$ (Row%, Column%, InputString$, Foreground%, Background%, ValidCharacters$, ReturnMode%, EntryMode%, CaseMode%)
DECLARE FUNCTION InvertString$ (StringToInvert$)
DECLARE FUNCTION IsAlpha% (Text$)
DECLARE FUNCTION IsNumeric% (Text$)
DECLARE FUNCTION LeadZero$ (Number, NewLength%)
DECLARE FUNCTION LeapYear% (Year%)
DECLARE FUNCTION MonthName$ (Month%)
DECLARE FUNCTION Pad$ (Orig$, NewLength%, Side%, Char$)
DECLARE FUNCTION RandInt% (Lower, Upper)
DECLARE FUNCTION Replace$ (Text$, LookFor$, ReplaceWith$)
DECLARE FUNCTION Reverse$ (Text$)
DECLARE FUNCTION Rinstr% (Start%, Search$, LookFor$)
DECLARE FUNCTION RotateLeft$ (S$)
DECLARE FUNCTION RotateRight$ (S$)
DECLARE FUNCTION Squeeze$ (Orig$, Char$)
DECLARE FUNCTION Strip$ (Text$, Delete$)
DECLARE SUB ActivateCapsLock ()
DECLARE SUB ArrayAdd (Array(), StartElement%, EndElement%, Num)
DECLARE SUB ArraySet (Array(), StartElement%, EndElement%, Num)
DECLARE SUB Box (Row%, Column%, BoxWidth%, Height%, BoxColor%, BoxCharacter%, BorderType%, BorderColor%)
DECLARE SUB CenterString (StringToCenter$, Row%, Fore%, Back%)
DECLARE SUB ClearKeyboard ()
DECLARE SUB CopyFile (InFile$, OutFile$)
DECLARE SUB Directory (d$(), mask$, SortType%, FileCount%)
DECLARE SUB DisplayTime (Row%, Column%, Format%, Fore%, Back%)
DECLARE SUB Dissolve ()
DECLARE SUB Drop (Text$, Row%, Col%)
DECLARE SUB GetArguments (Arguments$(), MaxArguments%, ArgsFound%)
DECLARE SUB PrintAt (Row%, Col%, Fore%, Back%, StringToPrint$)
DECLARE SUB QuickSort (SortArray%(), Lower%, Upper%)
DECLARE SUB ReColor (StartRow%, StartCol%, EndRow%, EndCol%, ChangeAtt%, ReplaceAtt%)
DECLARE SUB RestoreScreen (FileName$)
DECLARE SUB Rise (Text$, Row%, Col%)
DECLARE SUB SaveScreen (FileName$)
DECLARE SUB SaveScreenToTextFile (FileName$)
DECLARE SUB Scroll (StartRow%, StartCol%, EndRow%, EndCol%, Direction%)
DECLARE SUB SetCursor (CursorType%)
DECLARE SUB Slide (Text$, LeftOrRight%, Row%, Col%, Delay)
DECLARE SUB Spread (Text$, Row%, Col%, Delay)
DECLARE SUB StuffBuf (Keys$)
DECLARE SUB teletype (Text$, Delay)
DECLARE SUB Warp ()
DECLARE SUB WipeArea (Row1%, Col1%, Row2%, Col2%)
DECLARE SUB WipeCol (Col%, Rows%)
DECLARE SUB WipeEOL ()
DECLARE SUB WipeEOP ()
DECLARE SUB WipeRow (StartCol%, EndCol%)
DECLARE SUB WipeSOL ()
DECLARE SUB WipeSOP ()

SUB ActivateCapsLock

'*******************************************************************************
'*  this subroutine makes sure CapsLock is activated (may not light up key)    *
'*******************************************************************************

    DEF SEG = &H40
    POKE &H17, (PEEK(&H17) OR 64)
    DEF SEG

    END SUB

SUB ArrayAdd (Array(), StartElement%, EndElement%, Num)

'*******************************************************************************
'*  adds Num to each one-dim. array element from StartElement to EndElement    *
'*  if StartElement and EndElement = 0, entire array is used                   *
'*******************************************************************************

    IF StartElement% = 0 AND EndElement% = 0 THEN
       StartElement% = LBOUND(Array)
       EndElement% = UBOUND(Array)
    END IF
    
    FOR X% = StartElement% TO EndElement%
        Array(X%) = Array(X%) + Num
    NEXT X%
    
    END SUB

SUB ArraySet (Array(), StartElement%, EndElement%, Num)

'*******************************************************************************
'*  sets each element in an 1-dim array to Num from StartElement to EndElement *
'*  if StartElement and EndElement = 0, entire array is used                   *
'*******************************************************************************

    IF StartElement% = 0 AND EndElement% = 0 THEN
       StartElement% = LBOUND(Array)
       EndElement% = UBOUND(Array)
    END IF
    
    FOR X% = StartElement% TO EndElement%
        Array(X%) = Num
    NEXT X%
    
    END SUB

FUNCTION AttributeByte% (Fore%, Back%)

'*******************************************************************************
'*  returns a screen attribute byte given the foreground and background colors *
'*******************************************************************************

    AttributeByte% = (Back% * 16) + Fore%
    
    END FUNCTION

FUNCTION Background% (Row%, Col%)

'*******************************************************************************
'*  returns background color at given screen location                          *
'*******************************************************************************

    IF (Row% < 1 OR Row% > 25) OR (Col% < 1 OR Col% > 80) THEN
       Background% = 128
       EXIT FUNCTION
    END IF
   
    Background% = ((SCREEN(Row%, Col%, 1)) AND 112) / 16

    END FUNCTION

FUNCTION Bin% (Bit$)

'*******************************************************************************
'*  converts binary string to integer ("10" converts to 2, which is 10 binary) *
'*******************************************************************************

    Temp& = 0
    Length% = LEN(Bit$)

    FOR X% = 1 TO Length%
        IF MID$(Bit$, Length% - X% + 1, 1) = "1" THEN
           Temp& = Temp& + 2 ^ (X% - 1)
        END IF
    NEXT X%

    IF Temp& > 32767 THEN
       Bin% = Temp& - 65536
    ELSE
       Bin% = Temp&
    END IF
    
    END FUNCTION

FUNCTION BinarySearch% (Array$(), Find$)

'*******************************************************************************
'*  locates Find$ in sorted array Array$ () and returns element number or -1   *
'*******************************************************************************

    BinarySearch% = -1              ' no matching element yet
    Min = LBOUND(Array$)            ' start at first element
    Max = UBOUND(Array$)            ' consider through last

    DO
       Try = (Max + Min) \ 2        ' start testing in middle

       IF Array$(Try) = Find$ THEN
          BinarySearch% = Try       ' return matching element
          EXIT DO
       END IF
 
       IF Array$(Try) > Find$ THEN  ' too high, cut in half
          Max = Try - 1
       ELSE
          Min = Try + 1             ' too low, cut other way
       END IF

    LOOP WHILE Max >= Min

    END FUNCTION

FUNCTION BinDec& (Binary$) STATIC

'*******************************************************************************
'*  converts binary string to decimal equivalent                               *
'*******************************************************************************
    
    Decimal& = 0
    Power% = 0
    Binary$ = UCASE$(Binary$)
    
    FOR I% = LEN(Binary$) TO 1 STEP -1
        Digit% = ASC(MID$(Binary$, I%, 1)) - 48
        IF Digit% < 0 OR Digit% > 1 THEN
           Decimal& = 0
           EXIT FOR
        END IF
        Decimal& = Decimal& + Digit% * 2 ^ (Power%)
        Power% = Power% + 1
    NEXT I%
    
    BinDec& = Decimal&

    END FUNCTION

SUB Box (Row%, Column%, BoxWidth%, Height%, BoxColor%, BoxCharacter%, BorderType%, BorderColor%)

'*******************************************************************************
'*  displays a box of definable attributes on the screen                       *
'*******************************************************************************

    StartRow% = Row%

    SELECT CASE BorderType%

'      no border

       CASE 0
          UpperLeft$ = CHR$(BoxCharacter%)
          UpperRight$ = CHR$(BoxCharacter%)
          LowerLeft$ = CHR$(BoxCharacter%)
          LowerRight$ = CHR$(BoxCharacter%)
          Vertical$ = CHR$(BoxCharacter%)
          Horizontal$ = CHR$(BoxCharacter%)

'      single border

       CASE 1
          UpperLeft$ = CHR$(218)
          UpperRight$ = CHR$(191)
          LowerLeft$ = CHR$(192)
          LowerRight$ = CHR$(217)
          Vertical$ = CHR$(179)
          Horizontal$ = CHR$(196)

'      double border

       CASE 2
          UpperLeft$ = CHR$(201)
          UpperRight$ = CHR$(187)
          LowerLeft$ = CHR$(200)
          LowerRight$ = CHR$(188)
          Vertical$ = CHR$(186)
          Horizontal$ = CHR$(205)

    END SELECT

    InnerWidth% = BoxWidth% - 2
    InnerHeight% = Height% - 2
    InnerFilling$ = STRING$(InnerWidth%, CHR$(BoxCharacter%))
    BoxTopBottom$ = STRING$(InnerWidth%, Horizontal$)

    COLOR BorderColor%, BoxColor%
    LOCATE StartRow%, Column%
    PRINT UpperLeft$ + BoxTopBottom$ + UpperRight$;
    StartRow% = StartRow% + 1

    FOR FillLoop% = 1 TO InnerHeight%
        LOCATE StartRow%, Column%
        PRINT Vertical$ + InnerFilling$ + Vertical$;
        StartRow% = StartRow% + 1
    NEXT FillLoop%

    LOCATE StartRow%, Column%
    PRINT LowerLeft$ + BoxTopBottom$ + LowerRight$;
            
    END SUB

FUNCTION Capitalize$ (Orig$)

'*******************************************************************************
'*  capitalizes the first letter of each word in a string after first          *
'*  converting the whole thing to lower case                                   *
'*******************************************************************************

'   if original is null, return null
    IF Orig$ = "" THEN
       Capitalize$ = ""
       EXIT FUNCTION
    END IF

    New$ = LCASE$(Orig$)

'   capitalize the first character                            
    MID$(New$, 1, 1) = UCASE$(MID$(New$, 1, 1))

'   process string, capitalizing anything that follows a space
    FOR X% = 1 TO (LEN(New$) - 1)
        IF MID$(New$, X%, 1) = " " THEN
           MID$(New$, (X% + 1), 1) = UCASE$(MID$(New$, (X% + 1), 1))
        END IF
    NEXT X%

    Capitalize$ = New$

    END FUNCTION

SUB CenterString (StringToCenter$, Row%, Fore%, Back%)

'*******************************************************************************
'*  this subroutine centers a line of text on the screen                       *
'*******************************************************************************

    COLOR Fore%, Back%
    LOCATE Row%, 40 - INT(LEN(StringToCenter$) / 2)
    PRINT StringToCenter$;

    END SUB

SUB ClearKeyboard

'*******************************************************************************
'*  clears the keyboard buffer to help prevent accidental keystrokes           *
'*******************************************************************************

    FOR X% = 1 TO 15
        A$ = INKEY$
    NEXT X%
    
    END SUB

SUB CopyFile (InFile$, OutFile$) STATIC

'*******************************************************************************
'*  copies file InFile$ to file OutFile$                                       *
'*******************************************************************************

    File1% = FREEFILE
    OPEN InFile$ FOR BINARY AS #File1%
 
    File2% = FREEFILE
    OPEN OutFile$ FOR BINARY AS #File2%

    BytesRemaining& = LOF(File1%)

    DO
       IF BytesRemaining& > 4096 THEN
          ThisPass = 4096
       ELSE
          ThisPass = BytesRemaining&
       END IF
       Buffer$ = SPACE$(ThisPass)
       GET #File1%, , Buffer$
       PUT #File2%, , Buffer$
       BytesRemaining& = BytesRemaining& - ThisPass
    LOOP WHILE BytesRemaining&

    CLOSE File1#, File2#

    END SUB

FUNCTION CountIn% (Search$, LookFor$)

'*******************************************************************************
'*  Returns the number of times that a substring is found within a string.     *
'*******************************************************************************

    Count% = 0

'   exit if searching in or looking for a null string
    IF Search$ = "" OR LookFor$ = "" THEN
       CountIn% = Count%
       EXIT FUNCTION
    END IF

'   find first occurrence
    X% = INSTR(Search$, LookFor$)

'   proc. string, incrementing count and start pos each time sub is found
    DO WHILE X% > 0
       Count% = Count% + 1
       Last% = X%
       X% = INSTR((Last% + 1), Search$, LookFor$)
    LOOP

    CountIn% = Count%

    END FUNCTION

FUNCTION Crunch$ (Text$, CTC$)

'*******************************************************************************
'*  Text$ = "this    is    a    test", CTC$ = " " returns "this is a test"     *
'*******************************************************************************

    Temp$ = ""
    X% = 1

    WHILE X% <= LEN(Text$)
       C$ = MID$(Text$, X%, 1)
       Temp$ = Temp$ + C$
       IF C$ = CTC$ THEN
          WHILE MID$(Text$, X%, 1) = CTC$
             X% = X% + 1
          WEND
       ELSE
          X% = X% + 1
       END IF
    WEND

    Crunch$ = Temp$
    
    END FUNCTION

FUNCTION CurrentDirectory$

'*******************************************************************************
'*  returns current directory (i.e. C:\WINDOWS)                                *
'*******************************************************************************

    SHELL "CD >CD.TXT"
    
    F% = FREEFILE

    OPEN "I", F%, "CD.TXT"
    LINE INPUT #F%, CD$
    CLOSE F%

    KILL "CD.TXT"

    CurrentDirectory$ = CD$
    
    END FUNCTION

FUNCTION DateToJulian (Dat$)

'*******************************************************************************
'*  converts gregorian-style mm/dd/yyyy date to julian date                    *
'*******************************************************************************

    Month% = VAL(MID$(Dat$, 1, 2))
    Day% = VAL(MID$(Dat$, 4, 2))
    Year% = VAL(MID$(Dat$, 7, 4))

    SELECT CASE Month%
       CASE IS > 2
          Month% = Month% - 3
       CASE IS <= 2
          Month% = Month% + 9
          Year% = Year% - 1
    END SELECT

    A = 146097# * FIX(FIX(Year% / 100) / 4)
    B = FIX(1461# * (Year% MOD 100) / 4)
    C = FIX((153# * Month% + 2) / 5) + Day% + 1721119

    DateToJulian = A + B + C

    END FUNCTION

FUNCTION DateValid% (Month%, Day%, Year%)

'*******************************************************************************
'*  returns 1 if date given is a legal date                                    *
'*******************************************************************************

    SELECT CASE Month%                   'verify date within month
       
       CASE 4, 6, 9, 11                  'months that should
          SELECT CASE Day%               'only  have
             CASE 1 TO 30                '30 days
             CASE ELSE                   'otherwise
                DateValid% = 0           'not valid
                EXIT FUNCTION
          END SELECT

       CASE 1, 3, 5, 7, 8, 10, 12        'months that
          SELECT CASE Day%               'should have
             CASE 1 TO 31                '31 days
             CASE ELSE                   'otherwise
                DateValid% = 0           'not valid
                EXIT FUNCTION
          END SELECT
                  
       CASE 2                            'February
          SELECT CASE Year% MOD 4        'account for leap years
             CASE 0                      'a leap year
                SELECT CASE Day%
                   CASE 1 TO 29          'may have 29 days
                    CASE ELSE                        '
                       DateValid% = 0    'not valid
                       EXIT FUNCTION
                END SELECT
             CASE ELSE                   'not a leap year
                SELECT CASE Day%
                   CASE 1 TO 28          'only 28 days acceptable
                   CASE ELSE
                      DateValid% = 0
                      EXIT FUNCTION
                END SELECT
          END SELECT
                                         
       CASE ELSE                         'anything else
          DateValid% = 0                 'is invalid date entry
          EXIT FUNCTION
    
    END SELECT
    
    DateValid% = 1                       'Date passes all tests

    END FUNCTION

FUNCTION DayOfTheWeek$ (Dat$)

'*******************************************************************************
'*  returns day of week given date in form mm/dd/yyyy                          *
'*******************************************************************************

    JulianDate = DateToJulian(Dat$)

    SELECT CASE JulianDate - (FIX(JulianDate / 7) * 7) + 1

       CASE 0, 7
          DayOfTheWeek$ = "Monday"
       CASE 1
          DayOfTheWeek$ = "Tuesday"
       CASE 2
          DayOfTheWeek$ = "Wednesday"
       CASE 3
          DayOfTheWeek$ = "Thursday"
       CASE 4
          DayOfTheWeek$ = "Friday"
       CASE 5
          DayOfTheWeek$ = "Saturday"
       CASE 6
          DayOfTheWeek$ = "Sunday"

    END SELECT

    END FUNCTION

FUNCTION DecBin$ (Decimal&) STATIC

'*******************************************************************************
'*  converts decimal number to binary string                                   *
'*******************************************************************************

    BinNum$ = ""
    H$ = HEX$(Decimal&)

    FOR I% = 1 TO LEN(H$)

        Digit% = INSTR("0123456789ABCDEF", MID$(H$, I%, 1)) - 1
        IF Digit% < 0 THEN
           BinNum$ = ""
           EXIT FOR
        END IF

        J% = 8
        K% = 4

        DO
           BinNum$ = BinNum$ + RIGHT$(STR$((Digit% \ J%) MOD 2), 1)
           J% = J% - (J% \ 2)
           K% = K% - 1
           IF K% = 0 THEN
              EXIT DO
           END IF
        LOOP WHILE J%

    NEXT I%

    DecBin$ = BinNum$

    END FUNCTION

SUB Directory (d$(), mask$, SortType%, FileCount%)

'*******************************************************************************
'*  places pertinent directory info in array D$(), one entry per element.      *
'*  quicksorts by name, extension, size, date or time ascending or descending  *
'*******************************************************************************

    SHELL "DIR " + mask$ + ">DIRLIST.TXT"

    F% = FREEFILE
    OPEN "I", F%, "DIRLIST.TXT"

'   get past opening garbage
    FOR X% = 1 TO 5
        INPUT #F%, DirLine$
    NEXT X%
   
'   read in directory file information
    FileCount% = 0
    LINE INPUT #F%, DirLine$
   
    WHILE LEFT$(DirLine$, 8) <> "        "
      
       IF MID$(DirLine$, 16, 5) <> "<DIR>" THEN

          FileCount% = FileCount% + 1
         
          IF SortType% = 7 OR SortType% = 8 THEN
             TempDate$ = MID$(DirLine$, 35, 2) + MID$(DirLine$, 29, 2) + MID$(DirLine$, 32, 2)
             MID$(DirLine$, 29, 6) = TempDate$
          END IF
         
          IF SortType% = 9 OR SortType% = 10 THEN
             TempTime$ = MID$(DirLine$, 38, 6)
             MID$(DirLine$, 38, 6) = RIGHT$(TempTime$, 1) + LEFT$(TempTime$, 5)
          END IF

          d$(FileCount%) = MID$(DirLine$, 1, 43)
      
       END IF
      
       LINE INPUT #F%, DirLine$
   
    WEND
    
    CLOSE #F%
    KILL "DIRLIST.TXT"

'   no files matching pattern
    IF d$(1) = "" THEN
       EXIT SUB
    END IF

'   sort directory, if desired - 1,3,5,7,9=ascending, 2,4,6,8,10 descending

    SELECT CASE SortType%
    
       CASE 0                  ' no sort
          EXIT SUB
   
       CASE 1, 2               ' sort by filename (ascending/descending)
          Start% = 1
          Length% = 8          ' filename is characters 1-8
          
       CASE 3, 4               ' sort by extension (ascending/descending)
          Start% = 10
          Length% = 3          ' extension is characters 10-12
       
       CASE 5, 6               ' sort by file size (ascending/descending)
          Start% = 13
          Length% = 14         ' file size is characters 13-26

       CASE 7, 8               ' sort by last save date (ascending/descending)
          Start% = 29
          Length% = 6          ' save date is characters 29-36, reorder 29-34
          
       CASE 9, 10              ' sort by last save time (ascending/descending)
          Start% = 38
          Length% = 6          ' last save time is characters 38-43
          
    END SELECT

'   quicksort

    DIM SortStackLow%(128)
    DIM SortStackHigh%(128)
    
    StackPointer% = 1

    SortStackLow%(StackPointer%) = 1
    SortStackHigh%(StackPointer%) = FileCount%
    StackPointer% = StackPointer% + 1

    DO

       StackPointer% = StackPointer% - 1
       Low% = SortStackLow%(StackPointer%)
       High% = SortStackHigh%(StackPointer%)

       DO

         I% = Low%
         J% = High%
         Mid% = (Low% + High%) \ 2
         Compare$ = MID$(d$(Mid%), Start%, Length%)
       
         DO

            SELECT CASE SortType%

'              ascending sort order
               CASE 1, 3, 5, 7, 9
                  DO WHILE MID$(d$(I%), Start%, Length%) < Compare$
                     I% = I% + 1
                  LOOP

                  DO WHILE MID$(d$(J%), Start%, Length%) > Compare$
                     J% = J% - 1
                  LOOP

'              descending sort order
               CASE 2, 4, 6, 8, 10
                  DO WHILE MID$(d$(I%), Start%, Length%) > Compare$
                     I% = I% + 1
                  LOOP

                  DO WHILE MID$(d$(J%), Start%, Length%) < Compare$
                     J% = J% - 1
                  LOOP

            END SELECT
               
            IF I% <= J% THEN
               SWAP d$(I%), d$(J%)
               I% = I% + 1
               J% = J% - 1
            END IF

         LOOP WHILE I% <= J%

         IF J% - Low% < High% - I% THEN
            IF I% < High% THEN
               SortStackLow%(StackPointer%) = I%
               SortStackHigh%(StackPointer%) = High%
               StackPointer% = StackPointer% + 1
            END IF
            High% = J%
         ELSE
            IF Low% < J% THEN
               SortStackLow%(StackPointer%) = Low%
               SortStackHigh%(StackPointer%) = J%
               StackPointer% = StackPointer% + 1
            END IF
            Low% = I%
         END IF

       LOOP WHILE Low% < High%

    LOOP WHILE StackPointer% <> 1

'   reassemble date or time information, if necessary

    IF SortType% = 7 OR SortType% = 8 THEN
       FOR X% = 1 TO FileCount%
           TempDate$ = MID$(d$(X%), 29, 6)
           MID$(d$(X%), 29, 8) = MID$(TempDate$, 3, 2) + "-" + RIGHT$(TempDate$, 2) + "-" + LEFT$(TempDate$, 2)
       NEXT X%
    END IF

    IF SortType% = 9 OR SortType% = 10 THEN
       FOR X% = 1 TO FileCount%
           TempTime$ = MID$(d$(X%), 38, 6)
           MID$(d$(X%), 38, 6) = RIGHT$(TempTime$, 5) + LEFT$(TempTime$, 1)
       NEXT X%
    END IF

    END SUB

SUB DisplayTime (Row%, Column%, Format%, Fore%, Back%)

'*******************************************************************************
'*  displays time in 12 or 24 hour format                                      *
'*******************************************************************************

    LOCATE Row%, Column%
    COLOR Fore%, Back%

    SELECT CASE Format%

       CASE 0

          Hour% = VAL(LEFT$(TIME$, 2))

          SELECT CASE Hour%

             CASE IS > 12
                Hour% = Hour% - 12
                Hour$ = STR$(Hour%)
                Hour$ = RIGHT$(Hour$, LEN(Hour$) - 1)
                Hour$ = RIGHT$("  " + Hour$, 2)
                PRINT Hour$ + RIGHT$(TIME$, 6) + " P.M.";

             CASE IS = 12
                PRINT TIME$ + " P.M.";

             CASE IS = 0
                Hour% = 12
                PRINT "12" + RIGHT$(TIME$, 6) + " A.M.";

             CASE IS < 12
                Hour$ = STR$(Hour%)
                Hour$ = RIGHT$(Hour$, LEN(Hour$) - 1)
                Hour$ = RIGHT$("  " + Hour$, 2)
                PRINT Hour$ + RIGHT$(TIME$, 6) + " A.M.";

          END SELECT
          
       CASE 1

          PRINT TIME$;

    END SELECT

    END SUB

SUB Dissolve

'*******************************************************************************
'*  use instead of cls for an interesting way to clear the screen              *
'*******************************************************************************

    DIM ScreenPos%(2000)
    FOR X% = 1 TO 2000
        ScreenPos%(X%) = X%
    NEXT X%

    FOR X% = 1 TO 2000
        SWAP ScreenPos%(X%), ScreenPos%(INT(RND(1) * 2000) + 1)
    NEXT X%

    FOR X% = 1 TO 2000
        R% = ScreenPos%(X%) \ 80 + 1
        IF R% = 0 THEN R% = 1
        IF R% > 25 THEN R% = 25
        C% = ABS(ScreenPos%(X%) - (80 * R%))
        IF C% = 0 THEN C% = 1
        LOCATE R%, C%
        PRINT " ";
    NEXT X%

    LOCATE 1, 80: PRINT " ";   ' cheap temporary fix

    END SUB

SUB Drop (Text$, Row%, Col%)

'*******************************************************************************
'*  prints text vertically on the screen, dropping from the specified row and  *
'*  column position.  If the length of the text would continue past row 24,    *
'*  printing will stop at that point                                           *
'*******************************************************************************

    R% = Row%

    FOR X% = 1 TO LEN(Text$)
        LOCATE R%, Col%
        PRINT MID$(Text$, X%, 1);
        R% = R% + 1
'       don't go past bottom of screen
        IF R% = 26 THEN
           EXIT FOR
        END IF
    NEXT X%
    
    END SUB

FUNCTION EnglishDate$ (Dat$)

'*******************************************************************************
'*  Returns English date from mm/dd/yyyy date                                  *
'*******************************************************************************

    Day$ = MID$(Dat$, 4, 2)
    IF VAL(Day$) < 10 THEN
       Day$ = MID$(Dat$, 5, 1)
    END IF

    Month% = VAL(MID$(Dat$, 1, 2))
    EnglishDate$ = DayOfTheWeek$(Dat$) + ", " + MonthName$(Month%) + " " + Day$ + ", " + RIGHT$(Dat$, 4)

    END FUNCTION

FUNCTION Foreground% (Row%, Col%)

'*******************************************************************************
'*  returns foreground color at given screen location                          *
'*******************************************************************************

    IF (Row% < 1 OR Row% > 25) OR (Col% < 1 OR Col% > 80) THEN
       Foreground% = 128
       EXIT FUNCTION
    END IF

    ab% = SCREEN(Row%, Col%, 1)
    Foreground% = (ab% AND 128) / 8 + (ab% AND 15)

    END FUNCTION

SUB GetArguments (Arguments$(), MaxArguments%, ArgsFound%) STATIC

'*******************************************************************************
'*  this procedure parses command line and extracts arguments                  *
'*******************************************************************************

    True% = -1
    False% = 0

    ArgsFound% = 0
    In% = False%

    CommandLine$ = COMMAND$
    CommandLineLength% = LEN(CommandLine$)

    FOR Character% = 1 TO CommandLineLength%

        Char$ = MID$(CommandLine$, Character%, 1)

        IF Char$ <> " " AND Char$ <> CHR$(9) THEN

           IF NOT In% THEN
              IF ArgsFound% = MaxArguments% THEN
                 EXIT FOR
              END IF
              ArgsFound% = ArgsFound% + 1
              In% = True%
           END IF

           Arguments$(ArgsFound%) = Arguments$(ArgsFound%) + Char$

        ELSE

           In% = False%
    
        END IF

    NEXT Character%

    END SUB

FUNCTION GetChar$

'*******************************************************************************
'*  returns keystroke                                                          *
'*******************************************************************************

    A$ = ""
    WHILE A$ = ""
       A$ = INKEY$
    WEND
    GetChar$ = A$

    END FUNCTION

FUNCTION InputString$ (Row%, Column%, InputField$, Foreground%, Background%, ValidCharacters$, ReturnMode%, EntryMode%, CaseMode%)

'*******************************************************************************
'*   this function inputs a string of the desired length and desired characters*
'*   at the selected row, column and color                                     *
'*******************************************************************************

'   parameter list:
'   Row% - line# on screen to input string
'   Column% - column on screen to input string
'   InputField$ - the original string to edit
'   Foreground% - character color of input field
'   Background% - background color of input field
'   ValidCharacters$ - list of allowable input characters: "" = all allowed
'   ReturnMode% - way to return string:
'      1: return entire field as-is
'      2: return field less any trailing blanks
'      3: return field less any leading blanks
'      4: return field less both leading and trailing blanks
'      5: return field with all blanks removed
'      6: left justify and kill blanks between 1st and last char
'      7: right justify and kill inner blanks
'   EntryMode% - way to terminate input:
'      1: terminates only when enter is pressed
'      2: terminates after cursor goes past last character in field
'   CaseMode% - forces uppercase, lowercase or no preference
'      1: accept as entered
'      2: forces upper case
'      3: forces lower case
      
    True% = 1                             ' logical true
    False% = 0                            ' logical false

    EnterKey$ = CHR$(13)                  ' signifies end of entry
    Escape$ = CHR$(27)                    ' emergency exit from function
    EraseToEOF$ = CHR$(20)                ' ^T erase from cursor to EOF
    RestoreField$ = CHR$(18)              ' ^R restore original field
    EraseField$ = CHR$(25)                ' ^Y erase entire field
    BackSpace$ = CHR$(8)                  ' dragging, destructive backspace
    RightArrow$ = "M"                     ' input cursor right
    LeftArrow$ = "K"                      ' input cursor left
    InsertKey$ = "R"                      ' insert mode toggle
    DeleteKey$ = "S"                      ' character delete
    HomeKey$ = "G"                        ' input cursor start of field
    EndKey$ = "O"                         ' input cursor after last char

    InputFinished% = False%               ' set to true on enter or escape
    InsertMode% = False%                  ' start off in insert off mode

    OriginalField$ = InputField$          ' for ^R restore original field
    Length% = LEN(InputField$)            ' total input field length
    CurrentColumn% = Column%              ' cursor at first entry column
    CursorPosition% = 1                   ' 1st position in entry string
    EndColumn% = Column% + Length% - 1    ' last column in entry string

    COLOR Foreground%, Background%        ' set specified colors
    LOCATE Row%, Column%, 0               ' locate cursor
    PRINT InputField$;                    ' display original field
    LOCATE Row%, Column%, 1, 6, 7         ' locate at first character

    WHILE InputFinished% = False%         ' main loop

       InputKey$ = INKEY$                 ' get a keystroke if present
       EditKey$ = MID$(InputKey$, 2, 1)   ' editing key pressed?

       IF EditKey$ <> "" THEN

          SELECT CASE EditKey$

             CASE RightArrow$
                IF CurrentColumn% <= EndColumn% THEN
                   CurrentColumn% = CurrentColumn% + 1
                   CursorPosition% = CursorPosition% + 1
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE LeftArrow$
                IF CurrentColumn% > Column% THEN
                   CurrentColumn% = CurrentColumn% - 1
                   CursorPosition% = CursorPosition% - 1
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE InsertKey$
                IF InsertMode% = True% THEN
                   LOCATE Row%, CurrentColumn%, 1, 6, 7
                   InsertMode% = False%
                ELSE
                   LOCATE Row%, CurrentColumn%, 1, 3, 7
                   InsertMode% = True%
                END IF

             CASE DeleteKey$
                IF CurrentColumn% <= EndColumn% THEN
                   FOR Index% = CursorPosition% TO Length% - 1
                       MID$(InputField$, Index%, 1) = MID$(InputField$, Index% + 1, 1)
                   NEXT Index%
                   MID$(InputField$, Length%, 1) = " "
                   LOCATE Row%, Column%, 0
                   PRINT InputField$;
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE HomeKey$
                IF CursorPosition% > 1 THEN
                   CurrentColumn% = Column%
                   CursorPosition% = 1
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE EndKey$
                IF CursorPosition% < Length% THEN
                   FOR Index% = Length% TO 1 STEP (-1)
                       IF MID$(InputField$, Index%, 1) <> " " THEN
                          EXIT FOR
                       END IF
                   NEXT Index%
                   CursorPosition% = Index% + 1
                   CurrentColumn% = Column% + Index%
                   LOCATE Row%, CurrentColumn%, 1
                END IF

          END SELECT

       ELSE

          SELECT CASE InputKey$

             CASE Escape$
                InputString$ = InputKey$
                EXIT FUNCTION

             CASE BackSpace$
                IF CurrentColumn% > Column% THEN
                   N$ = ""
                   FOR Index% = 1 TO CursorPosition% - 2
                       N$ = N$ + MID$(InputField$, Index%, 1)
                   NEXT Index%
                   FOR Index% = CursorPosition% TO Length%
                       N$ = N$ + MID$(InputField$, Index%, 1)
                   NEXT Index%
                   InputField$ = LEFT$(N$ + SPACE$(Length%), Length%)
                   CurrentColumn% = CurrentColumn% - 1
                   CursorPosition% = CursorPosition% - 1
                   LOCATE Row%, Column%, 0
                   PRINT InputField$;
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE EraseField$
                InputField$ = SPACE$(Length%)
                LOCATE Row%, Column%, 0
                PRINT InputField$;
                CursorPosition% = 1
                CurrentColumn% = Column%
                LOCATE Row%, Column%, 1

             CASE EraseToEOF$
                IF CurrentColumn% <= EndColumn% THEN
                   MID$(InputField$, CursorPosition%, Length% - CursorPosition% + 1) = SPACE$(Length% - CursorPosition% + 1)
                   LOCATE Row%, Column%
                   PRINT InputField$;
                   LOCATE Row%, CurrentColumn%, 1
                END IF

             CASE RestoreField$
                InputField$ = OriginalField$
                LOCATE Row%, Column%, 0
                PRINT InputField$;
                CursorPosition% = 1
                CurrentColumn% = Column%
                LOCATE Row%, Column%, 1

             CASE EnterKey$
                InputFinished% = True%

             CASE ELSE

                ValidKey% = False%
'               null string for valid characters means all input accepted        
                IF ValidCharacters$ = "" OR INSTR(ValidCharacters$, UCASE$(InputKey$)) > 0 THEN
                   ValidKey% = True%
                END IF
                
                IF ValidKey% = True% AND InputKey$ <> "" AND CurrentColumn% <= EndColumn% THEN
                                          
                   SELECT CASE CaseMode%
                      CASE 1
                         ' do nothing, accept as entered
                      CASE 2
                         InputKey$ = UCASE$(InputKey$)
                      CASE 3
                         InputKey$ = LCASE$(InputKey$)
                   END SELECT

                   SELECT CASE InsertMode%
                      CASE True%
                         InputField$ = LEFT$(InputField$, CursorPosition% - 1) + InputKey$ + RIGHT$(InputField$, Length% - CursorPosition% + 1)
                         InputField$ = LEFT$(InputField$, Length%)
                         LOCATE Row%, Column%
                         PRINT InputField$;
                      CASE False%
                         PRINT InputKey$;
                         MID$(InputField$, CursorPosition%, 1) = InputKey$
                   END SELECT

                   CursorPosition% = CursorPosition% + 1
                   CurrentColumn% = CurrentColumn% + 1
                   LOCATE Row%, CurrentColumn%, 1

'                  check entry mode to see if end of field entry terminates entry
                   IF CurrentColumn% > EndColumn% AND EntryMode% = 2 THEN
                      InputFinished% = True%
                   END IF

                END IF

          END SELECT

       END IF

    WEND

'   return entered string appropriately

    SELECT CASE ReturnMode%

       CASE 1     ' return entire field
          InputString$ = InputField$

       CASE 2     ' return field less any trailing blanks
          InputString$ = RTRIM$(InputField$)

       CASE 3     ' return field less any leading blanks
          InputString$ = LTRIM$(InputField$)

       CASE 4     ' return field less both leading and trailing blanks
          InputString$ = LTRIM$(RTRIM$(InputField$))

       CASE 5     ' return field with all blanks removed
          N$ = ""
          FOR Index% = 1 TO Length%
              IF MID$(InputField$, Index%, 1) <> " " THEN
                 N$ = N$ + MID$(InputField$, Index%, 1)
              END IF
          NEXT Index%
          InputString$ = N$

       CASE 6     ' left justify and kill blanks between 1st and last char
          N$ = ""
          FOR Index% = 1 TO Length%
              IF MID$(InputField$, Index%, 1) <> " " THEN
                 N$ = N$ + MID$(InputField$, Index%, 1)
              END IF
          NEXT Index%
          InputString$ = RIGHT$(N$ + SPACE$(Length%), Length%)

       CASE 7     ' right justify and kill inner blanks
          N$ = ""
          FOR Index% = 1 TO Length%
              IF MID$(InputField$, Index%, 1) <> " " THEN
                 N$ = N$ + MID$(InputField$, Index%, 1)
              END IF
          NEXT Index%
          InputString$ = RIGHT$(SPACE$(Length%) + N$, Length%)

    END SELECT

    END FUNCTION

FUNCTION InvertString$ (StringToInvert$)

'*******************************************************************************
'*  "12345"  returns "54321"                                                   *
'*******************************************************************************

    IF StringToInvert$ = "" THEN
       InvertString$ = ""
       EXIT FUNCTION
    END IF
    
    New$ = ""
    
    FOR X% = LEN(StringToInvert$) TO 1 STEP (-1)
        New$ = New$ + MID$(StringToInvert$, X%, 1)
    NEXT X%
    
    InvertString$ = New$
    
    END FUNCTION

FUNCTION IsAlpha% (Text$)

'*******************************************************************************
'*  Returns 1 if the text contains only letters and spaces, otherwise 0        *
'*******************************************************************************

'   if null, return 1
    IF Text$ = "" THEN
       IsAlpha% = 1
       EXIT FUNCTION
    END IF

'   define allowed characters
    Allowed$ = " ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                             
    FOR X% = 1 TO LEN(Text$)
                                             
        C$ = UCASE$(MID$(Text$, X%, 1))

        IF INSTR(Allowed$, C$) = 0 THEN
           IsAlpha% = 0
           EXIT FUNCTION
        END IF

    NEXT X%

'   string passed
    IsAlpha% = 1

    END FUNCTION

FUNCTION IsNumeric% (Text$)

'*******************************************************************************
'*  Returns 1 if the text contains only digits and +-. otherwise 0             *
'*******************************************************************************

'   if null, return 1
    IF Text$ = "" THEN
       IsNumeric% = 0
       EXIT FUNCTION
    END IF

'   define allowed characters
    Allowed$ = "0123456789.+-"
                                             
    FOR X% = 1 TO LEN(Text$)
                                             
        C$ = UCASE$(MID$(Text$, X%, 1))

        IF INSTR(Allowed$, C$) = 0 THEN
           IsNumeric% = 0
           EXIT FUNCTION
        END IF

    NEXT X%

'   string passed
    IsNumeric% = 1

    END FUNCTION

FUNCTION LeadZero$ (Number, NewLength%)

'*******************************************************************************
'*  converts a number to a string and pads it on the left with leading zeros   *
'*  up to the desired length.                                                  *
'*  If used on a negative number, the minus sign will be included when         *
'*  calculating the new length.                                                *
'*    Examples: LeadZero$(5,5)  -->  "00005"                                   *
'*              LeadZero$(-5,5) -->  "-0005"                                   *
'*******************************************************************************

'   convert number to string
    New$ = LTRIM$(STR$(Number))

    L% = LEN(New$)

'   if string is = or longer than new length, retrun original
    IF NewLength% <= L% THEN
       LeadZero$ = New$
       EXIT FUNCTION
    END IF

'   remove minus sign if number is negative
    IF Number < 0 THEN
       New$ = RIGHT$(New$, (L% - 1))
    END IF

    Diff% = NewLength% - L%

'   pad string with leading zeroes
    New$ = STRING$(Diff%, "0") + New$

'   add minus sign if necessary
    IF Number < 0 THEN
       New$ = "-" + New$
    END IF
                               
    LeadZero$ = New$

    END FUNCTION

FUNCTION LeapYear% (Year%)

'*****************************************************************************
'* returns True (-1) if the specified year is a leap year                    *
'*****************************************************************************

    LY% = (Year% MOD 4 = 0) AND (Year% MOD 100 <> 0)
    LY% = LY% OR (Year% MOD 400 = 0)
    LeapYear% = LY%

    END FUNCTION

FUNCTION MonthName$ (Month%)

'*******************************************************************************
'*  prints a string at desired location, with attributes                       *
'*******************************************************************************

    SELECT CASE Month%

       CASE 1
          MonthName$ = "January"
       CASE 2
          MonthName$ = "February"
       CASE 3
          MonthName$ = "March"
       CASE 4
          MonthName$ = "April"
       CASE 5
          MonthName$ = "May"
       CASE 6
          MonthName$ = "June"
       CASE 7
          MonthName$ = "July"
       CASE 8
          MonthName$ = "August"
       CASE 9
          MonthName$ = "September"
       CASE 10
          MonthName$ = "October"
       CASE 11
          MonthName$ = "November"
       CASE 12
          MonthName$ = "December"
       CASE ELSE
          MonthName$ = "INVALID"
              
    END SELECT

    END FUNCTION

FUNCTION Pad$ (Orig$, NewLength%, Side%, Char$)

'*******************************************************************************
'*  Pads a string with a specified character on the specified side(s) up to    *
'*  the new length.                                                            *
'*  The Side% argument is expressed:  <0 = Left, 0 = Center, >0 = Right        *
'*  Examples:  Pad$("Hello!",10,1," ") --> "Hello!    "                        *
'*             Pad$("$500",10,-1,"*")  --> "******$500"                        *
'*             Pad$("WOW",20,0,"!")    --> "!!!!!!!!WOW!!!!!!!!!"              *
'*******************************************************************************

'   if char$ is null, default to space
    IF Char$ = "" THEN
       C$ = " "
    ELSE
       C$ = Char$
    END IF

    L% = LEN(Orig$)

'   if already = to new length, return the original
    IF L% = NewLength% THEN
       Pad$ = Orig$
       EXIT FUNCTION
    END IF

'   create string of pad characters
    Padx$ = STRING$(NewLength%, C$)

    SELECT CASE Side%

'      pad left
       CASE IS < 0
          Pad$ = RIGHT$(Padx$ + Orig$, NewLength%)

'      pad right
       CASE IS > 0
          Pad$ = LEFT$(Orig$ + Padx$, NewLength%)

'      pad center
       CASE ELSE
          IF L% > NewLength% THEN
               C$ = Orig$
'              trim 1 char off alternating sides until string is new length
               DO WHILE L% > NewLength%
                    L% = L% - 1
                    IF L% MOD 2 = 0 THEN
                         C$ = RIGHT$(C$, L%)
                    ELSE
                         C$ = LEFT$(C$, L%)
                    END IF
               LOOP
               Pad$ = C$
          ELSE
               Diff% = NewLength% - L
               L% = Diff% \ 2
               R% = Diff% - L
               Pad$ = STRING$(L%, C$) + Orig$ + STRING$(R%, C$)
          END IF

    END SELECT

    END FUNCTION

SUB PrintAt (Row%, Col%, Fore%, Back%, StringToPrint$)

'*******************************************************************************
'*  prints a string at desired location, with attributes                       *
'*******************************************************************************

    LOCATE Row%, Col%
    COLOR Fore%, Back%
    PRINT StringToPrint$;

    END SUB

SUB QuickSort (SortArray%(), Lower%, Upper%)

'*******************************************************************************
'*  non-recursive quicksort algorithm                                          *
'*  the data type for SortArray and Compare need to be changed if array to be  *
'*  sorted is non - integer                                                    *
'*******************************************************************************

    DIM SortStackLow%(128)
    DIM SortStackHigh%(128)
    
    StackPointer% = 1

    SortStackLow%(StackPointer%) = Lower%
    SortStackHigh%(StackPointer%) = Upper%
    StackPointer% = StackPointer% + 1

    DO

       StackPointer% = StackPointer% - 1
       Low% = SortStackLow%(StackPointer%)
       High% = SortStackHigh%(StackPointer%)

       DO

         I% = Low%
         J% = High%
         Mid% = (Low% + High%) \ 2
         Compare% = SortArray%(Mid%)

         DO

            DO WHILE SortArray%(I%) < Compare%
               I% = I% + 1
            LOOP

            DO WHILE SortArray%(J%) > Compare%
               J% = J% - 1
            LOOP

            IF I% <= J% THEN
               SWAP SortArray%(I%), SortArray%(J%)
               I% = I% + 1
               J% = J% - 1
            END IF

         LOOP WHILE I% <= J%

         IF J% - Low% < High% - I% THEN
            IF I% < High% THEN
               SortStackLow%(StackPointer%) = I%
               SortStackHigh%(StackPointer%) = High%
               StackPointer% = StackPointer% + 1
            END IF
            High% = J%
         ELSE
            IF Low% < J% THEN
               SortStackLow%(StackPointer%) = Low%
               SortStackHigh%(StackPointer%) = J%
               StackPointer% = StackPointer% + 1
            END IF
            Low% = I%
         END IF

       LOOP WHILE Low% < High%

    LOOP WHILE StackPointer% <> 1

    END SUB

FUNCTION RandInt% (Lower, Upper) STATIC

'*******************************************************************************
'*  returns a pseudorandom number between lower and upper inclusive            *
'*******************************************************************************

    RandInt% = INT(RND * (Upper - Lower + 1)) + Lower

    END FUNCTION

SUB ReColor (StartRow%, StartCol%, EndRow%, EndCol%, ChangeAtt%, ReplaceAtt%)

'*******************************************************************************
'*  changes fore/back colors in given area of screen - assumes color monitor   *
'*  if ChangeAtt% < 0, all attributes are changed to ReplaceAtt%
'*******************************************************************************

    DEF SEG = &HB800 ' i'm assuming color here, use &HB000 for mono

    FOR Row% = StartRow% TO EndRow%
        FOR Col% = StartCol% TO EndCol%
           IF ChangeAtt% < 0 THEN
              POKE (Row% - 1) * 160 + ((Col% - 1) * 2) + 1, ReplaceAtt%
           ELSE
              IF PEEK((Row% - 1) * 160 + ((Col% - 1) * 2) + 1) = ChangeAtt% THEN
                 POKE (Row% - 1) * 160 + ((Col% - 1) * 2) + 1, ReplaceAtt%
              END IF
           END IF
        NEXT Col%
    NEXT Row%

    DEF SEG

    END SUB

FUNCTION Replace$ (Text$, LookFor$, ReplaceWith$)

'*******************************************************************************
'*  replaces specified char/text in string with chosen replacement char/text   *
'*  Using "" as ReplaceWith$ effectively eliminates (squeezes out) LookFor$    *
'*******************************************************************************

'   check for null original string, not in at all, or equal
    IF (Text$ = "") OR (INSTR(Text$, LookFor$) < 1) OR (Text$ = ReplaceWith$) OR LEN(Text$) < LEN(LookFor$) THEN
       Replace$ = Text$
       EXIT FUNCTION
    END IF

    New$ = ""

    LengthOfReplacement% = LEN(ReplaceWith$)
    LengthOfText% = LEN(Text$)
    LengthOfStringToLookFor% = LEN(LookFor$)

    I% = 1
    WHILE I% <= LengthOfText% - LengthOfStringToLookFor% + 1
        IF MID$(Text$, I%, LengthOfStringToLookFor%) = LookFor$ THEN
           New$ = New$ + ReplaceWith$
           I% = I% + LengthOfStringToLookFor%
        ELSE
           New$ = New$ + MID$(Text$, I%, 1)
           I% = I% + 1
        END IF
        PRINT New$
    WEND

    Replace$ = New$
    
    END FUNCTION

SUB RestoreScreen (FileName$)

'*******************************************************************************
'*  Restores a screen saved by SaveScreen()                                    *
'*******************************************************************************

'   display controller port
    ScreenType& = PEEK(&H63) + PEEK(&H64) * 256

'   mono or color?
    IF ScreenType& = &H3B4 THEN
       ScreenType& = &HB000                       '  mono
    ELSE
       ScreenType& = &HB800                       '  color
    END IF

'   restore screen from disk
    DEF SEG = ScreenType&
    BLOAD FileName$, 0
    DEF SEG

    END SUB

FUNCTION Reverse$ (Text$)

'*******************************************************************************
'*  ABCDE returns EDCBA                                                        *
'*******************************************************************************

    Temp$ = ""
    
    FOR X% = LEN(Text$) TO 1 STEP (-1)
        Temp$ = Temp$ + MID$(Text$, X%, 1)
    NEXT X%
    
    Reverse$ = Temp$
    
    END FUNCTION

FUNCTION Rinstr% (Start%, Search$, LookFor$)

'*******************************************************************************
'*  "Reverse INSTR".  Returns the character position of the LAST occurrence    *
'*  of a substring within another. If the Start argument is greater than zero, *
'*  search$ is truncated to (Start-1) before the search begins.  The Start     *
'*  argument is useful for subsequent calls to Rinstr, i.e., to find the second*
'*  to last occurrence, etc.                                                   *
'*  Example:   Rinstr(0,"Peter Piper","er")  --> 10                            *
'*             Rinstr(10,"Peter Piper","er") --> 4  (Searches "Peter Pip")     *
'*******************************************************************************

'   if either argument is null, return 0
    IF Search$ = "" OR LookFor$ = "" THEN
       Rinstr% = 0
       EXIT FUNCTION
    END IF

'   return 0 if Start% > length of Search$ or is negative
    IF Start% > LEN(Search$) OR Start < 0 THEN
     Rinstr% = 0
     EXIT FUNCTION
    END IF

'   truncate if start pos is > 0, otherwise use original search string
    IF Start% > 0 THEN
       S$ = LEFT$(Search$, Start% - 1)
    ELSE
       S$ = Search$
    END IF

    Last% = 0
'   get first occurrence
    X% = INSTR(S$, LookFor$)

'   go thru string, increasing start pos each time substring is found
    WHILE X% > 0
       Last% = X%
       X% = INSTR((Last% + 1), S$, LookFor$)
    WEND

    Rinstr% = Last%

    END FUNCTION

SUB Rise (Text$, Row%, Col%)

'*******************************************************************************
'*  Prints text vertically on the screen, rising from the specified row and    *
'*  column position.  If the length of the text would continue above row 1,    *
'*  printing will stop at that point                                           *
'*******************************************************************************

    R% = Row%

    FOR X% = 1 TO LEN(Text$)
        LOCATE R%, Col%
        PRINT MID$(Text$, X%, 1);
        R% = R% - 1
        IF R% = 0 THEN EXIT FOR
    NEXT X%

    END SUB

FUNCTION RotateLeft$ (S$)

'*******************************************************************************
'*  "1234567890" returns "2345678901"                                          *
'*******************************************************************************

   IF LEN(S$) < 1 THEN
      RotateLeft$ = "INVALID"
   ELSE
      RotateLeft$ = RIGHT$(S$, LEN(S$) - 1) + LEFT$(S$, 1)
   END IF

   END FUNCTION

FUNCTION RotateRight$ (S$)

'*******************************************************************************
'*  "1234567890" returns "0123456789"                                          *
'*******************************************************************************

   IF LEN(S$) < 1 THEN
      RotateRight$ = "INVALID"
   ELSE
      RotateRight$ = RIGHT$(S$, 1) + LEFT$(S$, LEN(S$) - 1)
   END IF
   
   END FUNCTION

SUB SaveScreen (FileName$)

'*******************************************************************************
'*  saves current text screen to the specified binary file. If file already    *
'*  exists, it will be overwritten.  SCREEN 0 (text mode) only                 *
'*******************************************************************************

'   display controller port
    ScreenType& = PEEK(&H63) + PEEK(&H64) * 256

'   mono or color?
    IF ScreenType& = &H3B4 THEN    ' mono
       ScreenType& = &HB000
    ELSE
       ScreenType& = &HB800        ' color
    END IF

'   save screen to disk
    DEF SEG = ScreenType&
    BSAVE FileName$, 0, 4000
    DEF SEG

    END SUB

SUB SaveScreenToTextFile (FileName$)

'*******************************************************************************
'*  saves text screen w/o attributes to an ASCII text file                     *
'*******************************************************************************

    F% = FREEFILE
    OPEN "O", F%, FileName$

'   display controller port
    ScreenType& = PEEK(&H63) + PEEK(&H64) * 256

'   mono or color?
    IF ScreenType& = &H3B4 THEN    ' mono
       ScreenType& = &HB000
    ELSE
       ScreenType& = &HB800        ' color
    END IF

'   save screen to disk
    DEF SEG = ScreenType&
    
    FOR Row% = 1 TO 25
        SL$ = ""
        FOR Col% = 1 TO 80
            SL$ = SL$ + CHR$(PEEK((Row% - 1) * 160 + ((Col% - 1) * 2)))
            LOCATE Row%, Col%
        NEXT Col%
        PRINT #F%, SL$
    NEXT Row%

    DEF SEG
        
    CLOSE F%
    
    END SUB

SUB Scroll (StartRow%, StartCol%, EndRow%, EndCol%, Direction%)

'*******************************************************************************
'*  scrolls a given area of the screen up (direction=1) or down (dir <>1) once *
'*******************************************************************************

    DEF SEG = &HB800 ' use &HB000 for mono

    IF Direction% = 1 THEN
       SRow% = StartRow% + 1
       ERow% = EndRow%
       Inc% = 1
    ELSE
       SRow% = EndRow% - 1
       ERow% = StartRow%
       Inc% = (-1)
    END IF

    FOR Row% = SRow% TO ERow% STEP Inc%
        FOR Col% = StartCol% TO EndCol%
            CharacterAddress% = (Row% - 1) * 160 + ((Col% - 1) * 2)
            CharacterToScroll% = PEEK(CharacterAddress%)
            IF Direction% = 1 THEN
               MoveToAddress% = CharacterAddress% - 160
            ELSE
               MoveToAddress% = CharacterAddress% + 160
            END IF
            POKE MoveToAddress%, CharacterToScroll%
            POKE MoveToAddress% + 1, PEEK(CharacterAddress% + 1) 'attribute       
            POKE CharacterAddress%, 32
        NEXT Col%
    NEXT Row%

    DEF SEG
    
    END SUB

SUB SetCursor (CursorType%)

'*******************************************************************************
'*  set cursor - 0=none, 1 = underscore, 2 = block cursor                      *
'*******************************************************************************

    SELECT CASE CursorType%
       CASE 0                        'None - turn it off
          LOCATE , , 0
       CASE 1                        'Insert - underscore cursor
          LOCATE , , 1, 7
       CASE 2                        'Overwrite - block cursor
          LOCATE , , 1, 0, 7
    END SELECT

    END SUB

SUB Slide (Text$, LeftOrRight%, Row%, Col%, Delay)

'****************************************************************************
'*  Slides text onto the screen to the left or right starting at the        *
'*  specified row and column. Direction is determined by the argument       *
'*  LeftOrRight%, where a zero value equals left, non-zero equals right.    *
'*  Delay is measured in 100ths of a second.                                *
'****************************************************************************

'   convert delay to single precision
    d! = Delay

'   minimum 1/20th sec delay
    IF d! < 1 THEN
       d! = 5
    END IF

'   convert delay to 100ths of a second
    d! = d! / 100
    
    FOR X% = 1 TO LEN(Text$)

'       slide to the left
        IF LeftOrRight% = 0 THEN

'          check column for illegal value (<1)  
           IF (Col% - X% + 1) < 1 THEN
                EXIT FOR
           END IF

'          print 1 char at a time, from left to right
           LOCATE Row%, Col% - X% + 1
           PRINT LEFT$(Text$, X%);
    
        ELSE

'          slide from right to left, 1 char at a time
           LOCATE Row%, Col%
           PRINT RIGHT$(Text$, X%);

        END IF

'       current value of TIMER
        CurrentTimer! = TIMER
'       delay appropriate time
        WHILE TIMER < (CurrentTimer! + d!)
        WEND

'       stop delaying if a key is pressed
        IF INKEY$ <> "" THEN
           d! = 0
        END IF

    NEXT X%

    END SUB

SUB Spread (Text$, Row%, Col%, Delay)

'*******************************************************************************
'*  Spreads text on the screen in both directions starting from the specified  *
'*  coordinates.  Delay is measured in 100ths of a second                      *
'*******************************************************************************

'   convert delay to single precision
    d! = Delay

'   always have at least 1/20 sec. delay
    IF d! < 1 THEN
       d! = 5
    END IF

'   change to 100ths
    d! = d! / 100

'   if null, get out
    IF Text$ = "" THEN
       EXIT SUB
    END IF
    
    Txt$ = Text$

'   make text length even if not already so
    IF LEN(Txt$) MOD 2 = 1 THEN
       Txt$ = Txt$ + " "
    END IF

'   divide text into left and right sides
    LeftSide$ = LEFT$(Txt$, LEN(Txt$) \ 2)
    RightSide$ = RIGHT$(Txt$, LEN(Txt$) \ 2)

    FOR X% = 1 TO LEN(RightSide$)

        LOCATE Row%, Col%
        PRINT RIGHT$(RightSide$, X%);

'       print a letter from the left side
        IF (Col% - X%) >= 1 THEN
          LOCATE Row%, Col% - X%
          PRINT LEFT$(LeftSide$, X%);
        END IF

        CurrentTimer! = TIMER
        WHILE TIMER < (CurrentTimer! + d!)
        WEND    'Wait for timer to increase by d!

        IF INKEY$ <> "" THEN
           d! = 0        'if a key is pressed, stop delaying
        END IF
        
    NEXT X%

    END SUB

FUNCTION Squeeze$ (Orig$, Char$)

'*******************************************************************************
'*  removes all occurrences of a substring from within a string                *
'*  example: Squeeze$("Peter Piper","er") --> "Pet Pip"                        *
'*******************************************************************************

    IF Orig$ = "" OR Char$ = "" THEN
       Squeeze$ = Orig$
       EXIT FUNCTION
    END IF

    New$ = Orig$

    DO WHILE INSTR(New$, Char$) > 0
       X% = INSTR(New$, Char$)
       L$ = LEFT$(New$, X% - 1)
       R$ = MID$(New$, X% + LEN(Char$))
       New$ = L$ + R$
    LOOP
                                         
    Squeeze$ = New$

    END FUNCTION

FUNCTION Strip$ (Text$, Delete$)

'*******************************************************************************
'*  any characters in Text$ that are in Delete$ will be removed from Text$     *
'*******************************************************************************

'   check for null Text$ or Delete$
    IF Text$ = "" OR Delete$ = "" THEN
       Strip$ = Text$
       EXIT FUNCTION
    END IF
    
    Temp$ = ""

'   build new string, less delete characters
    FOR X% = 1 TO LEN(Text$)
        Char$ = MID$(Text$, X%, 1)
        IF INSTR(Delete$, Char$) = 0 THEN
           Temp$ = Temp$ + Char$
        END IF
    NEXT X%
    
    Strip$ = Temp$
    
    END FUNCTION

SUB StuffBuf (Keys$) STATIC

'*******************************************************************************
'*    Inserts Keys$ into the keyboard buffer just as if it had been            *
'*    entered from the keyboard.  Note that only fifteen characters may        *
'*    be inserted or the machine may lock up.                                  *
'*******************************************************************************
  
    Work$ = LEFT$(Keys$, 15)                  '15 characters maximum
    Length% = LEN(Work$)

    DEF SEG = 0
    POKE &H41A, &H1E                          'buffer head
    POKE &H41C, &H1E + Length% * &H2          'buffer tail

    FOR X% = 1 TO Length%                     'POKE each char one by one
        POKE &H41C + X% * &H2, ASC(MID$(Work$, X%))
    NEXT X%

    DEF SEG

    Work$ = ""

    END SUB

SUB teletype (Text$, Delay)

'*******************************************************************************
'*  Prints text one character at a time beginning at the current cursor        *
'*  location.  Delay between each character being printed is measured in       *
'*  1/100ths second (delay of 100 = 1 second).  If a value of zero or less     *
'*  is specified, the delay defaults to 5/100ths of a second.  If a key is     *
'*  pressed during the SUB, remainder of string is printed with no delay       *
'*******************************************************************************

    d! = Delay

'   if no delay, assign default
    IF d! < 1 THEN
       d! = 5
    END IF

'   change delay to 100ths second
    d! = d! / 100

'   print text 1 char at a time, with a "click" after non-space characters

    FOR X% = 1 TO LEN(Text$)
  
        T$ = MID$(Text$, X%, 1)
        PRINT T$;
        IF T$ <> " " THEN
           SOUND 20000, 1
        END IF

'       get current value of TIMER
        CurrentTimer! = TIMER

'       delay appropriate time
        WHILE TIMER < (CurrentTimer! + d!)
        WEND

'       stop delaying if a key is pressed
        IF INKEY$ <> "" THEN
           d! = 0
        END IF

    NEXT X%

    END SUB

SUB Warp

'*******************************************************************************
'*  starfield screen saver (hi-res, must repaint screen 0)                     *
'*******************************************************************************

    DIM Sine%(360), Cosine%(360)
    DIM StarAngle%(100), StarDistance%(100)
    DIM OldStarX%(100), OldStarY%(100)
    DIM StarTransX%(100), StarTransY%(100)
    DIM StarSpeed%(100)
    NumStars% = 100

    FOR N% = 0 TO 360
        Sine%(N%) = SIN(N% / 57.2958) * 10
        Cosine%(N%) = COS(N% / 57.2958) * 10
    NEXT N%

    FOR N% = 1 TO NumStars%
        StarAngle%(N%) = INT((360 - 1 + 1) * RND + 1)
        StarDistance%(N%) = INT((1000 - 1 + 1) * RND + 1)
        StarSpeed%(N%) = INT((100 - 1 + 1) * RND + 1)
    NEXT N%

    SCREEN 13
    WINDOW (-10000, -10000)-(10000, 10000)

    DO

       FOR N% = 1 TO NumStars%
           StarDistance%(N%) = (StarDistance%(N%) + StarSpeed%(N%)) MOD 1000
           StarTransX%(N%) = (Cosine%(StarAngle%(N%))) - (Sine%(StarAngle%(N%))) * StarDistance%(N%)
           StarTransY%(N%) = (Sine%(StarAngle%(N%))) + (Cosine%(StarAngle%(N%))) * StarDistance%(N%)
       NEXT N%

       FOR N% = 1 TO NumStars%
           PSET (OldStarX%(N%), OldStarY%(N%)), 0
           PSET (StarTransX%(N%), StarTransY%(N%)), StarDistance%(N%) \ 68 + 17
           OldStarX%(N%) = StarTransX%(N%)
           OldStarY%(N%) = StarTransY%(N%)
       NEXT N%

       Key$ = INKEY$
      
    LOOP UNTIL Key$ <> "" OR MID$(Key$, 2, 1) <> ""
   
    SCREEN 0

    END SUB

SUB WipeArea (Row1%, Col1%, Row2%, Col2%)

'*******************************************************************************
'*  clears an area of the screen                                               *
'*******************************************************************************

    Sp$ = SPACE$(Col2% - Col1% + 1)

    FOR X% = Row1% TO Row2%
        LOCATE X%, Col1%
        PRINT Sp$;
    NEXT X%

'   place cursor at top left of area
    LOCATE Row1%, Col1%

    END SUB

SUB WipeCol (Col%, Rows%)

'*******************************************************************************
'*  clears a column on the screen, taking into account 50-line display (Rows%) *                                              *
'*******************************************************************************

    R% = CSRLIN
    C% = POS(0)
    
    LOCATE 1, Col%
    
    FOR X% = 1 TO Rows%
        LOCATE X%, Col%
        PRINT " ";
    NEXT X%

'   restore original cursor position
    LOCATE R%, C%

    END SUB

SUB WipeEOL

'*******************************************************************************
'*  clears display from cursor position to end of current line                 *
'*******************************************************************************

    R% = CSRLIN
    C% = POS(0)
    
    PRINT SPACE$(80 - C% + 1);
    
    LOCATE R%, C%
    
    END SUB

SUB WipeEOP

'*******************************************************************************
'*  clears display from cursor to end of display, inclusive                    *
'*******************************************************************************

    R% = CSRLIN
    C% = POS(0)

    PRINT SPACE$(80 - C% + 1);
    
    FOR X% = R% + 1 TO 25
        LOCATE X%, 1
        PRINT SPACE$(80);
    NEXT X%
        
    LOCATE R%, C%
    
    END SUB

SUB WipeRow (StartCol%, EndCol%)

'*******************************************************************************
'*  clears a row on the screen between StartCol and EndCol inclusive           *
'*******************************************************************************

    IF (StartCol% < 1 OR StartCol% > 80) OR (EndCol% < 1 OR EndCol% > 80) THEN
       EXIT SUB
    END IF
    
    R% = CSRLIN
    C% = POS(0)
    
    LOCATE R%, 1
    PRINT SPACE$(EndCol% - StartCol% + 1);

'   restore original cursor position
    LOCATE R%, C%
    
    END SUB

SUB WipeSOL

'*******************************************************************************
'*  clears display from start of current line to cursor position inclusive     *
'*******************************************************************************

    R% = CSRLIN
    C% = POS(0)
    
    LOCATE R%, 1
    PRINT SPACE$(C%);
    
    LOCATE R%, C%
    
    END SUB

SUB WipeSOP

'*******************************************************************************
'*  clears display from start of display to cursor, inclusive                  *
'*******************************************************************************

    R% = CSRLIN
    C% = POS(0)
    
    FOR X% = 1 TO R% - 1
        LOCATE X%, 1
        PRINT SPACE$(80);
    NEXT X%
    
    LOCATE R%, 1
    PRINT SPACE$(C%);
    
    LOCATE R%, C%
    
    END SUB

