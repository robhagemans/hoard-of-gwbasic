' DEMON.BAS     this program illustrates some of the ways that the routines
'               provided in the Libraries in this package, can enhance your
'               Extended QuickBASIC programs.
'
'   Author:     Christy Gemmell
'   For:        Assembly-Language Toolbox for QuickBASIC
'   Version:    5.55
'   Date:       25/7/1993
'
'   For MicroSoft QuickBASIC and BASIC 7 Professional Development System.
'   Assembler routines created with MicroSoft Macro Assembler MASM 6.10
'
'   Compile:    BC /E/Fs/O/S/X demon;
'   Link:       Link /E/F demon,,,altquick.lib;
'   IDE:        QBX demon.bas /L altquick.qlb
'
'   $DYNAMIC                             ' required for stringsort routine
'
'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      External Functions and Procedures.                                ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
'   The following prototypes refer to assembly-language procedures which
'   are in the library files ALTQUICK.LIB and ALTQUICK.QLB. One or other
'   of these libraries must be linked to the program which calls them.
'
    DECLARE FUNCTION Ansi% ()
    DECLARE FUNCTION Attribute% (BYVAL Fore%, BYVAL Back%)
    DECLARE FUNCTION BootDrive% ()
    DECLARE FUNCTION CapsLock% (BYVAL Switch%)
    DECLARE FUNCTION CDRom% ()
    DECLARE FUNCTION Cpu% ()
    DECLARE FUNCTION EmsError% ()
    DECLARE FUNCTION EmsFrame% ()
    DECLARE FUNCTION EmsOwned% (BYVAL Handle%)
    DECLARE FUNCTION EmsPages% (BYVAL Switch%)
    DECLARE FUNCTION EmsPresent% ()
    DECLARE FUNCTION EmsVersion% ()
    DECLARE FUNCTION FarPeek% (BYVAL Segment&, BYVAL OffSet&)
    DECLARE FUNCTION FreeSpace& (BYVAL DriveNo%)
    DECLARE FUNCTION HiByte% (BYVAL Number%)
    DECLARE FUNCTION KeyFlags% ()
    DECLARE FUNCTION KeyIn% ()
    DECLARE FUNCTION KeyStat% ()
    DECLARE FUNCTION LoByte% (BYVAL Number%)
    DECLARE FUNCTION MathsChip% ()
    DECLARE FUNCTION MouseInit% ()
    DECLARE FUNCTION NetTest% ()
    DECLARE FUNCTION NumLock% (BYVAL Switch%)
    DECLARE FUNCTION PeekWord& (BYVAL Segment&, BYVAL OffSet&)
    DECLARE FUNCTION PrinTest% (BYVAL Printr%)
    DECLARE FUNCTION RamDisk% ()
    DECLARE FUNCTION Rand% (BYVAL Lower%, BYVAL Higher%)
    DECLARE FUNCTION ScrLock% (BYVAL Switch%)
    DECLARE FUNCTION FileSize& (FileSpec$)
    DECLARE FUNCTION StatusLine% (Message$)
    DECLARE FUNCTION StringScan% (Trgt$, BYVAL Size%, BYVAL Strt%, BYVAL Addr%)
    DECLARE FUNCTION Verify% (BYVAL Default%, BYVAL Row%, Prompt$, BYVAL Attr%, BYVAL Mouse%)
    DECLARE FUNCTION WindowsUp% ()
    DECLARE FUNCTION WinMode% ()
    DECLARE FUNCTION WinVer% ()
    DECLARE FUNCTION XMSize% ()
    DECLARE SUB BackFill (BYVAL Row%, BYVAL Col%, BYVAL Rows%, BYVAL Cols%, BYVAL Attr%)
    DECLARE SUB Cipher (Text$, KeyWord$)
    DECLARE SUB ClearEnd (BYVAL Switch%, BYVAL Attr%)
    DECLARE SUB Curtains (BYVAL Speed%, BYVAL Attr%)
    DECLARE SUB DOSBox (BYVAL Switch%, BYVAL Y1%, BYVAL X1%, BYVAL Y2%, BYVAL X2%, BYVAL Attr%)
    DECLARE SUB EmsGet (BYVAL Segment%, BYVAL OffSet%, BYVAL Length%, BYVAL Page%, BYVAL Handle%, Done%)
    DECLARE SUB EmsPut (BYVAL Segment%, BYVAL OffSet%, BYVAL Length%, BYVAL Page%, BYVAL Handle%, Done%)
    DECLARE SUB EmsRelease (BYVAL Handle%)
    DECLARE SUB EmsRequest (BYVAL Pages%, Handle%)
    DECLARE SUB FastPrint (BYVAL Row%, BYVAL Col%, Message$, BYVAL Attr%)
    DECLARE SUB GraPrint (BYVAL xLoc%, BYVAL yLoc%, Text$, BYVAL Attr%, BYVAL Scale%)
    DECLARE SUB HelpMate (BYVAL Colour%, Title$, BYVAL Context%, Topic$)
    DECLARE SUB KeyFlush ()
    DECLARE SUB MisTake (BYVAL Row%, Message$, BYVAL Attr%, BYVAL Mouse%)
    DECLARE SUB MouseHide ()
    DECLARE SUB MouseNow (LeftButton%, RightButton%, xMouse%, yMouse%)
    DECLARE SUB MouseShow ()
    DECLARE SUB Pause (BYVAL Ticks%)
    DECLARE SUB PerCentBox (BYVAL Switch%, Message$, BYVAL Attr%, BYVAL PerCent%)
    DECLARE SUB PopUp (BYVAL Row%, BYVAL Col%, BYVAL Hght%, BYVAL Wdth%, BYVAL Attr%, BYVAL Brdr%, BYVAL Shdw%, BYVAL Zoom%)
    DECLARE SUB PrintSet (BYVAL Row%, BYVAL Col%, BYVAL Attr%, BYVAL Printr%, BYVAL Mouse%)
    DECLARE SUB ReSeed (BYVAL Seed&)
    DECLARE SUB Scroll (BYVAL Dir%, BYVAL Y1%, BYVAL X1%, BYVAL Y2%, BYVAL X2%, BYVAL Units%, BYVAL Attr%)
    DECLARE SUB ShutUp (BYVAL Speed%)
    DECLARE SUB StringSort (BYVAL Dir%, BYVAL Size%, BYVAL Addr%)
    DECLARE SUB VGALoad (File$)
    DECLARE SUB VGAPan (BYVAL X%, BYVAL Y%)
    DECLARE SUB VGASave (File$)

'   These are native QuickBASIC procedures which are in ALTQUICK.LIB/QLB
'
    DECLARE FUNCTION BinDec& (Binary$)
    DECLARE FUNCTION BitTest% (Number%, Bit%)
    DECLARE FUNCTION DateInput$ (Default$, Context%, Topic$, HotKey%)
    DECLARE FUNCTION DosVersion$ ()
    DECLARE FUNCTION FindFile$ (FileSpec$, Attr%, Mouse%)
    DECLARE FUNCTION GetFlag% (Flag%)
    DECLARE FUNCTION GrAttrib% (ForeGround%, BackGround%)
    DECLARE FUNCTION IsDir% (Test$)
    DECLARE FUNCTION LongDate$ (Dy%, Mnth%, Yr%)
    DECLARE FUNCTION RevInput$ (Max%, Visible%, Default$, Legal$, Ctx%, Topic$, Mask%, HotKey%)
    DECLARE SUB BarMenu (P1%, P2%, P3%, Menu$(), P5%, P6%, P7%, P8$, Mouse%, HotKeys%)
    DECLARE SUB CheckPrinter (Printr%)
    DECLARE SUB Panel (Row%, Col%, Rows%, Cols%, Border%, Attr%)
    DECLARE SUB SetFlag (Flag%, Setting%)
    DECLARE SUB SortFile (PathName$, OffSet%, FieldLen%, RecordLen%, Done%)
    DECLARE SUB VerMenu (P1%, P2%, P3%, P4%, P5%, P6$, Menu$(), P8%, P9%, P10%, P11%, P12$, Mouse%, HotKeys%)
    DECLARE SUB VideoMode (Colour%, MaxRes%, VideoRam%)

'   Local, program-specific, functions and procedures.
'
    DECLARE SUB Frame (Title$, Switch%)

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Initialisation.                                                   ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
    CONST FALSE = 0, TRUE = NOT FALSE

'   Allow plenty of stack space for function and procedure calls.
'
    CLS: CLEAR , , &H2000

'   Establish error trapping and point to error handler.
'
    ON ERROR GOTO Trap

'   Check video capabilities of the host system (default to MDA).
'
    Colour% = FALSE                             ' Default to monochrome
    MaxRes% = 0                                 ' Default to text only
    VideoRam% = 4                               ' Default to 4K buffer

    VideoMode Colour%, MaxRes%, VideoRam%       ' Find what's installed

'   Set display colours for colour and monochrome displays.
'
    IF Colour% THEN
       BarColour% = 48                          ' Black on Cyan
       HeadColour% = 31                         ' Bright White on Blue
       StatColour% = 48                         ' Black on Cyan
       TextColour% = 112                        ' Black on White
    ELSE
       BarColour% = 112                         ' Reverse video
       HeadColour% = 15                         ' Intense White on Black
       StatColour% = 112                        ' Reverse video
       TextColour% = 7                          ' White on Black
    END IF

'   Check the type of display adaptor installed.
'
    SELECT CASE MaxRes%
        CASE 13
             IF VideoRam% = 64 THEN
                Adaptor$ = "Multi-Colour Graphics Array"
             ELSE
                Adaptor$ = "Video Graphics Array"
             END IF
        CASE 7 TO 10
             Adaptor$ = "Enhanced Graphics Adaptor"
        CASE 3
             Adaptor$ = "Hercules Graphics Card"
        CASE 2
             Adaptor$ = "Colour Graphics Adaptor"
        CASE ELSE
             Adaptor$ = "Monochrome Display Adaptor"
    END SELECT

    Mouse% = MouseInit%                         ' See if a mouse is available

    DIM Menu$(0 TO 12)                          ' Dimension array for menus
    HotKeys% = FALSE                            ' Disable hotkeys in menus
    Printr% = 1                                 ' Use the first parallel port
    RootName$ = "DEMON"                         ' Used for help topic files
    DOS$ = "DOS " + DosVersion$                 ' Check current DOS version
    Lc$ = "abcdefghijklmnopqrstuvwxyz"          ' Lowercase letters
    Uc$ = UCASE$(Lc$)                           ' Uppercase letters
    Nu$ = "0123456789"                          ' Numerals
    VFln$ = "\._^$~!#%&-@`({})'"                ' Legal pathname characters

    DY$ = MID$(DATE$, 4, 2): DY% = VAL(DY$)     ' What day is this?
    MO$ = LEFT$(DATE$, 2): MO% = VAL(MO$)       ' What month is this?
    YR$ = RIGHT$(DATE$, 2): YR% = VAL(YR$)      ' What year is this?
    Now$ = DY$ + "/" + MO$ + "/" + YR$          ' Format it as DD/MM/YY

    ToDay$ = LongDate$(DY%, MO%, YR%)           ' Translate date into words

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Main Menu.                                                        ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
    ReSeed TIMER
D001:
    Head$ = "ASSEMBLY-LANGUAGE TOOLBOX FOR QuickBASIC"
    LOCATE , , 0: Frame Head$, 1: Bar% = 1
D002:
    IF MaxRes% < 1 THEN
       Menu$(0) = "WSFKME X"
    ELSE
       Menu$(0) = "WSFKMEGX"
    END IF
    Menu$(1) = "&Windows": Menu$(2) = "&Screen"
    Menu$(3) = "&Files": Menu$(4) = "&Keyboard"
    Menu$(5) = "&Memory": Menu$(6) = "&Examples"
    Menu$(7) = "&Graphics": Menu$(8) = "E&xit"
    Abort% = FALSE: HotKey% = FALSE
    IF Nxt% THEN
       IF Bar% = 1 THEN Bar% = 8
       IF Bar% = 9 THEN Bar% = 2
    END IF
    BarMenu 3, BarColour%, 8, Menu$(), Bar%, Nxt%, 1, RootName$, Mouse%, HotKeys%
    SELECT CASE Bar%
        CASE 1
             GOTO D100
        CASE 2
             GOTO D200
        CASE 3
             GOTO D300
        CASE 4
             GOTO D400
        CASE 5
             GOTO D500
        CASE 6
             GOTO D600
        CASE 7
             GOTO D700
        CASE 8
             GOTO D800
        CASE 9
             HelpMate 0, "", 0, ""
        CASE ELSE
             Ok% = Verify%(1, 9, "Exit program, are you sure", 0, Mouse%)
             IF Ok% THEN GOTO Egress
    END SELECT
GOTO D002

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Popup Window Demonstration.                                       ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D100:
    A$ = STRING$(1680, "°"): FastPrint 4, 1, A$, 30
    FastPrint 25, 1, SPACE$(80), StatColour%: A$ = ""
    FastPrint 25, 2, Adaptor$, StatColour%
    FastPrint 25, 62, "Active windows", StatColour%
    GOSUB D110
    FOR M% = 1 TO 3
        Area% = 0: O% = 0: B% = 1
        DO
            H% = Rand%(5, 10): W% = Rand%(14, 40)
            Area% = Area% + (H% + 1) * (W% + 1)
            IF Area% > 7200 THEN EXIT DO
            K% = Rand%(4, 24 - H%): J% = Rand%(1, 79 - W%)
            R% = Rand%(1, 4): S% = Rand%(1, 4)
            Attrib% = Attribute%(15, B%)
            PopUp K%, J%, H%, W%, Attrib%, R%, S%, -1
            FastPrint K%, J% + ((W% \ 2) - 5), "[ WINDOW ]", Attrib%
            GOSUB D110: O% = O% + 1: B% = B% + 1: IF B% > 6 THEN B% = 1
         LOOP UNTIL O% = 30
         IF (M% = 3) THEN SLEEP 3 ELSE SLEEP 1
         FOR I% = O% TO 1 STEP -1
             ShutUp -1: GOSUB D110
         NEXT I%
    NEXT M%
    PopUp 4, 15, 10, 30, 52, 4, 1, -1: GOSUB D110
    PopUp 3, 36, 13, 40, 47, 3, 1, -1: GOSUB D110
    PopUp 9, 10, 13, 40, 31, 2, 1, -1: GOSUB D110
    PopUp 12, 42, 11, 36, 67, 1, 1, -1: GOSUB D110
    PopUp 2, 31, 5, 20, 78, 2, 1, -1: GOSUB D110
    FastPrint 4, 34, "Presenting ...", 78
    SLEEP 3: KeyFlush: Attrib% = Attribute%(0, 7)
    PopUp 8, 20, 7, 40, Attrib%, 2, 1, -1: GOSUB D110
    FastPrint 8, 31, "[ QUICK  WINDOWS ]", Attrib%
    FastPrint 10, 29, "Windowing Routines for", Attrib%
    FastPrint 11, 30, "Microsoft QuickBASIC", Attrib%
    SLEEP 3: KeyFlush: Attrib% = Attribute%(0, 3)
    PopUp 17, 55, 7, 24, Attrib%, 1, 3, -1: GOSUB D110
    FastPrint 19, 66, "By", Attrib%
    FastPrint 20, 59, "Christy Gemmell", Attrib%
    FastPrint 21, 65, "and", Attrib%
    FastPrint 22, 58, "Singular Software", Attrib%
    SLEEP 3: KeyFlush: Attrib% = Attribute%(14, 1)
    PopUp 13, 2, 10, 23, Attrib%, 2, 4, 0: GOSUB D110
    FastPrint 15, 4, "A Library of screen", Attrib%
    FastPrint 16, 4, "handling procedures", Attrib%
    FastPrint 17, 4, "and functions which", Attrib%
    FastPrint 18, 4, "can be incorporated", Attrib%
    FastPrint 19, 4, "in your QuickBASIC", Attrib%
    FastPrint 20, 9, "programs.", Attrib%
    SLEEP 4: KeyFlush: Attrib% = Attribute%(15, 1)
    PopUp 16, 27, 5, 26, Attrib%, 2, 1, 0: GOSUB D110
    FastPrint 18, 30, "HOLD ONTO YOUR HATS", Attrib%
    SLEEP 2: KeyFlush: 
    FOR I% = 1 TO 9 
        ShutUp -1: GOSUB D110
    NEXT I%
    Attrib% = 112: PopUp 9, 16, 8, 50, Attrib%, 2, 2, 0: GOSUB D110
    RESTORE Blurb
    FOR I% = 10 TO 15: READ Me$: FastPrint I%, 19, Me$, Attrib%: NEXT
    SLEEP 6: KeyFlush: Scroll 1, 10, 17, 15, 64, 0, Attrib%
    FOR I% = 12 TO 13: READ Me$: FastPrint I%, 19, Me$, Attrib%: NEXT
    SLEEP 5: KeyFlush: IF Colour% THEN Attrib% = Attribute%(1, 2)
    PopUp 5, 5, 6, 35, Attrib%, 0, 1, -1: GOSUB D110
    SLEEP 3: ShutUp -1: GOSUB D110
    Scroll 1, 10, 17, 15, 64, 0, 112
    FOR I% = 12 TO 13: READ Me$: FastPrint I%, 19, Me$, 112: NEXT
    SLEEP 6: KeyFlush: IF Colour% THEN Attrib% = Attribute%(15, 6)
    PopUp 6, 5, 8, 35, Attrib%, 0, 2, -1: GOSUB D110
    FastPrint 6, 15, "[  No  Frame  ]", Attrib%
    SLEEP 1: KeyFlush: IF Colour% THEN Attrib% = Attribute%(11, 1)
    PopUp 7, 8, 8, 35, Attrib%, 1, 2, -1: GOSUB D110
    FastPrint 7, 17, "[ Frame Style 1 ]", Attrib%
    SLEEP 1: KeyFlush: IF Colour% THEN Attrib% = Attribute%(0, 2)
    PopUp 8, 11, 8, 35, Attrib%, 2, 2, -1: GOSUB D110
    FastPrint 8, 20, "[ Frame Style 2 ]", Attrib%
    SLEEP 1: KeyFlush: IF Colour% THEN Attrib% = Attribute%(0, 3)
    PopUp 9, 14, 8, 35, Attrib%, 3, 2, -1: GOSUB D110
    FastPrint 9, 23, "[ Frame Style 3 ]", Attrib%
    SLEEP 1: KeyFlush: IF Colour% THEN Attrib% = Attribute%(14, 4)
    PopUp 10, 17, 8, 35, Attrib%, 4, 2, -1: GOSUB D110
    FastPrint 10, 26, "[ Frame Style 4 ]", Attrib%
    SLEEP 1: KeyFlush: IF Colour% THEN Attrib% = Attribute%(12, 5)
    PopUp 11, 20, 8, 35, Attrib%, 5, 2, -1: GOSUB D110
    FastPrint 11, 29, "[ Frame Style 5 ]", Attrib%
    SLEEP 1: KeyFlush: IF Colour% THEN Attrib% = Attribute%(13, 6)
    PopUp 12, 23, 8, 35, Attrib%, 6, 2, -1: GOSUB D110
    FastPrint 12, 32, "[ Frame Style 6 ]", Attrib%
    SLEEP 1: KeyFlush: IF Colour% THEN Attrib% = Attribute%(15, 2)
    PopUp 13, 26, 8, 35, Attrib%, 7, 2, -1: GOSUB D110
    FastPrint 13, 35, "[ Frame Style 7 ]", Attrib%
    SLEEP 1: KeyFlush: IF Colour% THEN Attrib% = Attribute%(1, 3)
    PopUp 14, 29, 8, 35, Attrib%, 8, 2, -1: GOSUB D110
    FastPrint 14, 39, "[ Frame Style 8 ]", Attrib%
    SLEEP 4: KeyFlush: 
    FOR I% = 1 TO 9
        ShutUp -1: GOSUB D110
    NEXT I%
    Scroll 1, 10, 17, 15, 64, 0, 112
    FOR I% = 11 TO 13: READ Me$: FastPrint I%, 20, Me$, 112: NEXT
    SLEEP 6: KeyFlush
    FOR I% = 1 TO 15
        Label$ = "[ Colour:" + STR$(I%) + " ]"
        J% = Rand%(1, 51): K% = Rand%(1, 13)
        Attrib% = Attribute%(I%, 0)
        PopUp K% + 1, J% + 1, 7, 24, Attrib%, 4, 0, 0: GOSUB D110
        FastPrint K% + 1, J% + 6, Label$, Attrib%
        SLEEP 1: KeyFlush
    NEXT I%
    Attrib% = Attribute%(31, B%)
    PopUp 7, 20, 7, 24, Attrib%, 4, 2, 0: GOSUB D110
    FastPrint 7, 25, "[ Colour: 31 ]", Attrib%
    SLEEP 4: KeyFlush: FOR I% = 1 TO 16: ShutUp 0: GOSUB D110: NEXT
    Scroll 1, 10, 17, 15, 64, 0, 112
    FOR I% = 12 TO 13: READ Me$: FastPrint I%, 19, Me$, 112: NEXT
    SLEEP 6: KeyFlush: Attrib% = Attribute%(15, 1)
    PopUp 2, 2, 11, 30, Attrib%, 7, 0, 0: GOSUB D110
    SLEEP 3: KeyFlush: ShutUp 0: GOSUB D110
    Scroll 1, 10, 17, 15, 64, 0, 112
    FOR I% = 12 TO 13: READ Me$: FastPrint I%, 19, Me$, 112: NEXT
    SLEEP 6: KeyFlush: Attrib% = Attribute%(14, 5)
    PopUp 5, 5, 10, 30, Attrib%, 2, 1, 0: GOSUB D110
    FastPrint 9, 14, "Left Shadow", Attrib%
    SLEEP 2: KeyFlush: Attrib% = Attribute%(0, 2)
    PopUp 5, 45, 10, 30, Attrib%, 2, 2, 0: GOSUB D110
    FastPrint 9, 54, "Right Shadow", Attrib%
    SLEEP 2: KeyFlush: ShutUp 0: GOSUB D110: ShutUp 0: GOSUB D110
    Scroll 1, 10, 17, 15, 64, 0, 112
    FastPrint 12, 31, "Windows can be zoomed", 112
    FastPrint 13, 33, "onto the screen.", 112
    SLEEP 3: KeyFlush: Attrib% = Attribute%(0, 2)
    PopUp 2, 2, 15, 60, Attrib%, 2, 0, -1: GOSUB D110
    SLEEP 2: KeyFlush: Attrib% = Attribute%(0, 3)
    PopUp 13, 10, 10, 60, Attrib%, 3, 0, -1: GOSUB D110
    SLEEP 2: KeyFlush: Attrib% = Attribute%(14, 5)
    PopUp 7, 33, 10, 45, Attrib%, 1, 0, -1: GOSUB D110
    SLEEP 2: KeyFlush: Attrib% = Attribute%(15, 4)
    IF NOT Colour% THEN Attrib% = 112
    PopUp 7, 10, 12, 63, Attrib%, 2, 1, -1: GOSUB D110
    FastPrint 12, 32, "<<< W O W >>>", Attrib%
    SLEEP 3: KeyFlush: FOR I% = 1 TO 4: ShutUp -1: GOSUB D110: NEXT
    Scroll 1, 10, 17, 15, 64, 0, 112
    FOR I% = 10 TO 14: READ Me$: FastPrint I%, 19, Me$, 112: NEXT
    SLEEP 6: KeyFlush: Scroll 1, 10, 17, 15, 64, 0, 112
    FOR I% = 10 TO 15: READ Me$: FastPrint I%, 19, Me$, 112: NEXT
    SLEEP 6: KeyFlush: Scroll 1, 10, 17, 15, 64, 0, 112
    FOR I% = 10 TO 15: READ Me$: FastPrint I%, 19, Me$, 112: NEXT
    SLEEP 6: KeyFlush: Attrib% = Attribute%(0, 2)
    PopUp 3, 5, 15, 45, Attrib%, 4, 1, -1: GOSUB D110
    FastPrint 9, 14, "This is the first level ...", Attrib%
    SLEEP 2: KeyFlush: Attrib% = Attribute%(15, 4)
    PopUp 6, 29, 17, 50, Attrib%, 4, 1, -1: GOSUB D110
    FastPrint 12, 40, "This is the second level ...", Attrib%
    SLEEP 2: KeyFlush: Attrib% = Attribute%(0, 3)
    PopUp 9, 22, 15, 35, Attrib%, 4, 1, -1: GOSUB D110
    FastPrint 16, 26, "This is the third level ...", Attrib%
    SLEEP 2: KeyFlush: FastPrint 16, 26, "Now to go back ...         ", Attrib%
    SLEEP 1: ShutUp -1: GOSUB D110: SLEEP 1: ShutUp -1: GOSUB D110
    SLEEP 1: ShutUp -1: GOSUB D110: SLEEP 2
    Scroll 1, 10, 17, 15, 64, 0, 112: KeyFlush
    FOR I% = 10 TO 15: READ Me$: FastPrint I%, 19, Me$, 112: NEXT
    Ok% = Verify%(1, 9, "Are you enjoying this program", 0, Mouse%)
    Scroll 1, 10, 17, 15, 64, 0, 112
    IF Ok% THEN
       FastPrint 11, 28, "You sound very positive!", 112
    ELSE
       FastPrint 11, 28, "You sound very negative!", 112
    END IF
    SLEEP 2: KeyFlush: Scroll 1, 10, 17, 15, 64, 0, 112
    FOR I% = 10 TO 15: READ Me$: FastPrint I%, 19, Me$, 112: NEXT
    SLEEP 3: KeyFlush: SL% = StatusLine%("Want to carry on?")
    IF SL% = 78 OR SL% = 110 OR SL% = 27 THEN
       ShutUp -1: GOSUB D110
    ELSE
       A$ = STRING$(44, SL%)
       FOR I% = 10 TO 15: FastPrint I%, 19, A$, 112: NEXT
       SLEEP 6: KeyFlush: Scroll 1, 10, 17, 15, 64, 0, 112
       FOR I% = 10 TO 15: READ Me$: FastPrint I%, 19, Me$, 112: NEXT
       SLEEP 6: KeyFlush: Scroll 1, 10, 17, 15, 64, 0, 112
       Ready% = PrinTest%(Printr%)
       IF Ready% THEN
          FastPrint 11, 30, "PRINTER CONTROL MENU", 112
          FastPrint 13, 24, "The Toolbox contains versions for", 112
          FastPrint 14, 27, "two other popular printers.", 112
          FastPrint 25, 2, "Press <ESC> to Abort       ", StatColour%
          PrintSet 4, 51, 0, Printr%, Mouse%
          FastPrint 25, 1, SPACE$(80), StatColour%
          FastPrint 25, 2, Adaptor$, StatColour%
          FastPrint 25, 62, "Active windows", StatColour%
          GOSUB D110: SLEEP 5: KeyFlush
       END IF
       ShutUp -1: GOSUB D110
       PopUp 4, 15, 10, 30, 52, 4, 1, -1: GOSUB D110
       PopUp 3, 36, 13, 40, 47, 3, 1, -1: GOSUB D110
       PopUp 9, 10, 13, 40, 78, 2, 1, -1: GOSUB D110
       PopUp 12, 42, 11, 36, 67, 1, 1, -1: GOSUB D110
       PopUp 9, 16, 8, 52, 112, 2, 1, -1: GOSUB D110
       FastPrint 11, 20, "The video routines in the Toolbox Library", 112
       FastPrint 12, 20, "give you all you need to create powerful", 112
       FastPrint 13, 20, "and professional screen displays in your", 112
       FastPrint 14, 20, "QuickBASIC programs.", 112: SLEEP 9: KeyFlush
       FOR I% = 1 TO 5: ShutUp -1: GOSUB D110: SLEEP 1: KeyFlush: NEXT
       IF NOT Ready% THEN
          PopUp 10, 18, 5, 44, 96, 1, 2, 0: GOSUB D110
          Me$ = "Pity you didn't have a printer connected"
          FastPrint 12, 20, Me$, 96: SLEEP 5: KeyFlush: ShutUp 0: GOSUB D110
       END IF
    END IF
GOTO D001

D110:
    Wup% = WindowsUp%
    Me$ = RIGHT$("  " + LTRIM$(STR$(Wup%)), 3)
    FastPrint 25, 76, Me$, StatColour%
RETURN

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Screen control functions.                                         ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D200:
    Menu$(0) = "F#SC#B"
    Menu$(1) = "&Fast screen printing"
    Menu$(3) = "&Selective scrolling"
    Menu$(4) = "&Clear to the end"
    Menu$(6) = "&Background colours"
    VerMenu 4, 3, BarColour%, 1, 6, "SCREEN CONTROL", Menu$(), Choice%, Nxt%, Bar%, 1, RootName$, Mouse%, HotKeys%
    IF Nxt% THEN GOTO D002
    SELECT CASE Choice%
        CASE 1
             GOTO D210
        CASE 3
             GOTO D220
        CASE 4
             GOTO D230
        CASE 6
             GOTO D240
        CASE ELSE
    END SELECT
GOTO D002

'   Screen print demonstration
'
D210:
    A$ = STRING$(1680, "®"): B$ = STRING$(1680, "¯")
    FOR I% = 1 TO 255
        FastPrint 4, 1, A$, I%: FastPrint 4, 1, B$, I%
        IF INKEY$ = CHR$(27) THEN EXIT FOR
    NEXT I%
    IF I% = 256 THEN
       A$ = "": B$ = "": C$ = STRING$(1680, "°"): Attrib% = 30
       FastPrint 4, 1, C$, Attrib%: C$ = ""
       IF Colour% THEN Attrib% = 48 ELSE Attrib% = 112
       PopUp 12, 21, 7, 40, Attrib%, 1, 4, -1
       Panel 12, 21, 7, 40, 5, Attrib%
       FastPrint 15, 33, "<<< W O W >>>", Attrib%
       SLEEP 5: KeyFlush: ShutUp -1
    END IF
GOTO D200

'   Selective scrolling demonstration
'
D220:
    Panel 4, 1, 21, 80, 1, TextColour%
    IF Colour% THEN BackGround% = 7 ELSE BackGround% = 0
    Clr% = 1: IF Mouse% THEN MouseShow
    DO
       Scroll 0, 4, 21, 7, 60, 1, Attribute%(0, Clr%)
       Scroll 2, 9, 6, 19, 20, 1, Attribute%(0, Clr%)
       Scroll 3, 9, 61, 19, 75, 1, Attribute%(0, Clr%)
       Scroll 1, 21, 21, 24, 60, 1, Attribute%(0, Clr%)
       COLOR Clr%, BackGround%
       LOCATE 19, 25: PRINT "SCROLLING UP";
       Scroll 0, 9, 23, 19, 38, 1, Attribute%(Clr%, BackGround%)
       LOCATE 9, 43: PRINT "SCROLLING DOWN";
       Scroll 1, 9, 41, 19, 58, 1, Attribute%(Clr%, BackGround%)
       Pause 1: Clr% = Clr% + 1
       IF Clr% = BackGround% THEN Clr% = Clr% + 1
       IF Clr% > 7 THEN Clr% = 1
       IF Mouse% THEN
          MouseNow LeftButton%, RightButton%, xMouse%, yMouse%
          IF LeftButton% THEN
             IF yMouse% > 15 AND yMouse% < 24 THEN
                Z$ = CHR$(32): EXIT DO
             END IF
          END IF
       END IF
       Z$ = INKEY$
    LOOP UNTIL Z$ = CHR$(27)
    IF Mouse% THEN
       CALL MouseHide: IF Z$ <> CHR$(27) THEN GOTO D002
    END IF
GOTO D200

'   Clear to end of line or screen
'
D230:
    Panel 4, 1, 24, 80, 1, TextColour%
    IF Colour% THEN Attrib% = 15 ELSE Attrib% = 112
    FastPrint 22, 30, "Press a key to do it", TextColour%
    FastPrint 10, 3, "Clear end of line >", TextColour%
    LOCATE 10, 22, 1: R$ = INPUT$(1): ClearEnd 0, Attrib%
    FastPrint 15, 3, "Clear end of screen >", TextColour%
    LOCATE 15, 24, 1: R$ = INPUT$(1): ClearEnd 1, Attrib%
    LOCATE , , 0: Frame Head$, 0
GOTO D200

D240:
    FastPrint 25, 1, SPACE$(80), StatColour%
    FastPrint 25, 3, "Press any key, <Esc> to abort", StatColour%
    RANDOMIZE TIMER: IF Mouse% THEN MouseShow
    DO
       Row% = Rand%(5, 20): Col% = Rand%(2, 62): Rows% = Rand%(1, 16)
       IF Row% + Rows% > 23 THEN Rows% = 24 - Row%
       Cols% = Rand%(1, 60): IF Col% + Cols% > 78 THEN Cols% = 79 - Col%
       Attrib% = Rand%(0, 255): BackFill Row%, Col%, Rows%, Cols%, Attrib%
       DO
          IF Mouse% THEN
             MouseNow LeftButton%, RightButton%, xMouse%, yMouse%
             IF LeftButton% THEN
                IF yMouse% > 15 AND yMouse% < 24 THEN
                   Z$ = CHR$(27)
                   EXIT DO
                ELSE
                   Z$ = CHR$(32)
                   EXIT DO
                END IF
             END IF
          END IF
          Z$ = INKEY$
       LOOP UNTIL Z$ <> ""
    LOOP UNTIL Z$ = CHR$(27)
    Frame Head$, 0: IF Mouse% THEN MouseHide:
    IF Z$ <> CHR$(27) THEN GOTO D002
GOTO D200

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      File Functions.                                                   ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D300:
    Menu$(0) = "WH#S"
    Menu$(1) = "&Where's that file?"
    Menu$(2) = "&How big is that file?"
    Menu$(4) = "&Sort that file"
    Abort% = FALSE
    VerMenu 4, 9, BarColour%, 1, 4, "FILE FUNCTIONS", Menu$(), Choice%, Nxt%, Bar%, 1, RootName$, Mouse%, HotKeys%
    IF Nxt% THEN GOTO D002
    SELECT CASE Choice%
        CASE 1
             GOTO D310
        CASE 2
             GOTO D320
        CASE 4
             GOTO D330
        CASE ELSE
    END SELECT
GOTO D002

'   File Finder
'
D310:
    Panel 4, 1, 21, 80, 1, TextColour%
    RESTORE Finder
    FOR I% = 1 TO 13
        READ Me$: FastPrint 5 + I%, 14, Me$, TextColour%
    NEXT I%
    Scroll 1, 19, 2, 21, 79, 0, TextColour%
    PopUp 19, 19, 4, 44, 96, 4, 4, -1
    Panel 19, 19, 4, 44, 5, 96: HotKey% = FALSE
    FastPrint 20, 28, "Enter name of file to find", 96
    LOCATE 21, 21: Legal$ = Uc$ + Lc$ + Nu$ + VFln$ + ":*?"
    PathName$ = RevInput$(40, 0, "", Legal$, 1, "REVINPUT", 0, HotKey%)
    ShutUp -1
    IF HotKey% THEN
       Abort% = TRUE
    ELSE
       PathName$ = RTRIM$(LTRIM$(PathName$))
       Found$ = FindFile$(PathName$, 0, Mouse%)
       IF Found$ <> "" THEN
          Found$ = LTRIM$(RTRIM$(Found$))
          OT% = 40 - (LEN(Found$) \ 2)
          FastPrint 20, OT%, Found$, TextColour%
       END IF
    END IF
GOTO D300

D320:
    Panel 4, 1, 21, 80, 1, TextColour%
    RESTORE Size
    FOR I% = 1 TO 12
        READ Me$: FastPrint 5 + I%, 8, Me$, TextColour%
    NEXT I%
    Scroll 1, 18, 3, 23, 78, 0, TextColour%: HotKey% = FALSE
    LOCATE 20, 20: Legal$ = Uc$ + Lc$ + Nu$ + VFln$ + "*?"
    PathName$ = RevInput$(64, 40, "", Legal$, 1, "REVINPUT", 0, HotKey%)
    IF HotKey% THEN
       Abort% = TRUE
    ELSE
       PathName$ = LTRIM$(RTRIM$(PathName$))
       IF PathName$ = "" THEN PathName$ = "*.*"
       IF IsDir%(PathName$) THEN PathName$ = PathName$ + "\*.*"
       FastPrint 20, 8, SPACE$(64), TextColour%
       FastPrint 20, 8, PathName$, TextColour%
       Bytes& = FileSize&(PathName$)
       IF Bytes& > 0 THEN
          Me$ = "Size = " + LTRIM$(RTRIM$(STR$(Bytes&))) + " bytes"
          FastPrint 22, 40 - (LEN(Me$) \ 2), Me$, TextColour%
       ELSE
          MisTake 9, "No match found!", 0, Mouse%
       END IF
    END IF
GOTO D300

'   File sorter.
'
D330:
    Panel 4, 1, 21, 80, 1, TextColour%
    RESTORE Sorts
    FOR I% = 1 TO 10
        READ Me$: FastPrint 4 + I%, 8, Me$, TextColour%
    NEXT I%
    IF FileSize&("SAMPLE.DAT") < 1 THEN
       MisTake 9, "Can't find SAMPLE data file to sort!", 0, Mouse%
    ELSE
       IF Colour% THEN Attrib% = 32 ELSE Attrib% = 112
       PopUp 16, 3, 8, 74, Attrib%, 1, 4, -1
       Panel 16, 3, 8, 74, 5, Attrib%
       FastPrint 16, 36, " SAMPLE.DAT ", Attrib%
       OPEN "SAMPLE.DAT" FOR INPUT AS #1
       FOR I% = 1 TO 6
           LINE INPUT #1, A$: OL% = LEN(A$)
           Me$ = LEFT$(A$, OL% - 2)
           FastPrint 16 + I%, 40 - (OL% \ 2) + 1, Me$, Attrib%
       NEXT I%
       CLOSE 1: SL% = StatusLine%("To begin sorting ...")
       SortFile "SAMPLE.DAT", 1, 10, OL% + 2, Done%
       IF Done% THEN
          OPEN "SAMPLE.DAT" FOR INPUT AS #1
          FOR I% = 1 TO 6
              LINE INPUT #1, A$: OL% = LEN(A$)
              Me$ = LEFT$(A$, OL% - 2)
              FastPrint 16 + I%, 40 - (OL% \ 2) + 1, Me$, Attrib%
          NEXT I%
          CLOSE 1
          SL% = StatusLine%("File successfully sorted"): ShutUp -1
       ELSE
          ShutUp -1
          FastPrint 21, 30, "Unable to sort file", TextColour%
       END IF
    END IF
GOTO D300

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Keyboard functions and procedures.                                ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D400:
    Menu$(0) = "AKT#M"
    Menu$(1) = "&ASCII and scan codes"
    Menu$(2) = "&Keyboard shift flags"
    Menu$(3) = "&Typeahead buffer"
    Menu$(5) = "&Mouse position and status"
    VerMenu 4, 16, BarColour%, 1, 5, "KEYBOARD AND MOUSE", Menu$(), Choice%, Nxt%, Bar%, 1, RootName$, Mouse%, HotKeys%
    IF Nxt% THEN GOTO D002
    SELECT CASE Choice%
        CASE 1
             GOTO D410
        CASE 2
             GOTO D420
        CASE 3
             GOTO D430
        CASE 5
             GOTO D440
        CASE ELSE
    END SELECT
GOTO D002

'   Indexes to the font table in ROM-BIOS, then translates the pixel
'   values of the character specified by a keypress, into a large-
'   scale representation of that character.
'
D410:
    Panel 4, 1, 21, 80, 1, TextColour%
    Fore$ = STRING$(2, "Û"): Back$ = STRING$(2, "°")
    FastPrint 6, 31, "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿", TextColour%
    FOR Row% = 7 TO 14
        FastPrint Row%, 31, "³" + STRING$(16, "°") + "³", TextColour%
    NEXT Row%
    FastPrint 15, 31, "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ", TextColour%
    FastPrint 25, 1, SPACE$(80), StatColour%
    FastPrint 25, 3, "Press any key, or <Esc> to abort", StatColour%
    LOCATE 21, 40, 1: Abort% = FALSE: CALL KeyFlush
    DO
        Character% = KeyIn%: IF Character% = 27 THEN EXIT DO
        FastPrint 21, 40, " ", TextColour%
        FastPrint 16, 10, SPACE$(60), TextColour%
        SELECT CASE Character%
            CASE 0 TO 127
                 FOR Row% = 1 TO 8
                     Pixel% = FarPeek%(&HF000, &HFA6D + (Character% * 8) + Row%)
                     IF Pixel% = 0 THEN
                        FastPrint Row% + 6, 32, STRING$(16, "°"), TextColour%
                     ELSE
                        Col% = 32
                        FOR Column% = 7 TO 0 STEP -1
                            IF Pixel% < 2 ^ Column% THEN
                               FastPrint Row% + 6, Col%, Back$, TextColour%
                            ELSE
                               FastPrint Row% + 6, Col%, Fore$, TextColour%
                               Pixel% = Pixel% - 2 ^ Column%
                            END IF
                            Col% = Col% + 2
                        NEXT Column%
                     END IF
                 NEXT Row%
            CASE ELSE
                 IF Character% < 0 THEN
                    Me$ = SPACE$(16)
                 ELSE
                    Me$ = STRING$(16, Character%)
                 END IF
                 FOR Row% = 1 TO 8
                     FastPrint Row% + 6, 32, Me$, TextColour%
                 NEXT Row%
        END SELECT
        IF Character% < 0 THEN
           Me$ = "Scan Code " + LTRIM$(RTRIM$(STR$(ABS(Character%))))
        ELSE
           Me$ = "ASCII Code " + LTRIM$(RTRIM$(STR$(Character%)))
        END IF
        FastPrint 16, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    LOOP WHILE 1
    LOCATE , , 0: Frame Head$, 0
GOTO D400

'   Keyboard shift flags.
'
D420:
    Panel 4, 1, 21, 80, 1, TextColour%
    ShiftFlags% = KeyFlags%: Flag$ = STRING$(16, "0")
    FOR I% = 15 TO 0 STEP -1
        IF BitTest%(ShiftFlags%, I%) THEN
           MID$(Flag$, 16 - I%, 1) = "1"
        END IF
    NEXT I%
    FastPrint 5, 40, "Keyboard Status Word at 0040:0017", TextColour%
    FastPrint 7, 40, "Bit settings (1 = set)", TextColour%
    FastPrint 5, 3, " F E D C B A 9 8 7 6 5 4 3 2 1 0", TextColour%
    FastPrint 6, 3, "ÚÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄ¿", TextColour%
    FastPrint 7, 3, "³", TextColour%: Col% = 4
    FOR I% = 1 TO 16
        FastPrint 7, Col%, MID$(Flag$, I%, 1) + "³", TextColour%
        Col% = Col% + 2
    NEXT I%
    FastPrint 8, 3, "ÀÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÙ", TextColour%
    FastPrint 9, 3, " ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ÀÄÁÄ", TextColour%
    FastPrint 10, 3, " ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ÀÄÄÄÄÄ", TextColour%
    FastPrint 11, 3, " ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ", TextColour%
    FastPrint 12, 3, " ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 13, 3, " ³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 14, 3, " ³ ³ ³ ³ ³ ³ ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 15, 3, " ³ ³ ³ ³ ³ ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 16, 3, " ³ ³ ³ ³ ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 17, 3, " ³ ³ ³ ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 18, 3, " ³ ³ ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 19, 3, " ³ ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 20, 3, " ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 21, 3, " ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 22, 3, " ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 23, 3, " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 25, 1, SPACE$(80), StatColour%
    FastPrint 25, 3, "Press <Esc> to abort", StatColour%
    RESTORE Shift
    FOR I% = 1 TO 15
        READ Me$: FastPrint I% + 8, 40, Me$, TextColour%
    NEXT I%
    IF Mouse% THEN MouseShow
    DO
        ShiftFlags% = KeyFlags%
        FOR I% = 15 TO 0 STEP -1
            IF BitTest%(ShiftFlags%, I%) THEN
               MID$(Flag$, 16 - I%, 1) = "1"
            ELSE
               MID$(Flag$, 16 - I%, 1) = "0"
            END IF
        NEXT I%
        Col% = 4
        FOR I% = 1 TO 16
            FastPrint 7, Col%, MID$(Flag$, I%, 1) + "³", TextColour%
            Col% = Col% + 2
        NEXT I%
        CL% = CapsLock%(2)
        IF CL% THEN
           FastPrint 25, 65, "CAPS", 14
        ELSE
           FastPrint 25, 65, "    ", StatColour%
        END IF
        NL% = NumLock%(2)
        IF NL% THEN
           FastPrint 25, 70, "NUM", 14
        ELSE
           FastPrint 25, 70, "   ", StatColour%
        END IF
        SL% = ScrLock%(2)
        IF SL% THEN
           FastPrint 25, 74, "SCRL", 14
        ELSE
           FastPrint 25, 74, "    ", StatColour%
        END IF
        IF Mouse% THEN
           MouseNow LeftButton%, RightButton%, xMouse%, yMouse%
           IF LeftButton% THEN
              IF yMouse% > 15 AND yMouse% < 24 THEN
                 Z$ = CHR$(32): EXIT DO
              END IF
           END IF
        END IF
        Z$ = INKEY$
    LOOP UNTIL Z$ = CHR$(27)
    Frame Head$, 0
    IF Mouse% THEN
       CALL MouseHide: IF Z$ <> CHR$(27) THEN GOTO D002
    END IF
GOTO D400

'   Keyboard typeahead buffer.
'
D430:
    COLOR 7, 0: Panel 4, 1, 21, 80, 1, 14
    RESTORE KeyBuff: READ Items%
    FOR I% = 1 TO Items%
        READ Row%, Col%, Me$: LOCATE Row%, Col%, 0: PRINT Me$;
    NEXT I%
    LOCATE 11, 68: COLOR 11
    Start% = &H400 + FarPeek%(&H40, &H80)
    Finish% = &H400 + FarPeek%(&H40, &H82)
    PRINT RIGHT$("0000" + HEX$(Start%), 4); " ";
    PRINT RIGHT$("0000" + HEX$(Finish%), 4);
    DO
        Hd% = &H400 + FarPeek%(&H40, &H1A)
        Tl% = &H400 + FarPeek%(&H40, &H1C)
        LOCATE 11, 4: COLOR 11
        PRINT RIGHT$("0000" + HEX$(Hd%), 4); " ";
        PRINT RIGHT$("0000" + HEX$(Tl%), 4);
        COLOR 13: LOCATE 9, 17: PRINT SPACE$(48);
        LOCATE 9, 17 + ((Hd% - &H41E) \ 2) * 3: PRINT CHR$(25);
        COLOR 12: LOCATE 13, 17: PRINT SPACE$(48);
        LOCATE 13, 17 + ((Tl% - &H41E) \ 2) * 3: PRINT CHR$(24);
        FOR I% = 0 TO 15
            C% = FarPeek%(&H40, &H1E + (I% * 2))
            S% = FarPeek%(&H40, &H1E + (I% * 2) + 1)
            IF C% < 32 THEN Ky$ = "  " ELSE Ky$ = CHR$(C%) + " "
            LOCATE 11, 17 + (I% * 3): COLOR 14: PRINT Ky$;
            LOCATE 14, 17 + (I% * 3): COLOR 9
            PRINT RIGHT$("0" + HEX$(C%), 2);
            LOCATE 15, 17 + (I% * 3): COLOR 10
            PRINT RIGHT$("0" + HEX$(S%), 2);
        NEXT I%
        IF Hd% >= Tl% THEN
           Kys% = 16 - ((Hd% - Tl%) \ 2)
        ELSE
           Kys% = (Tl% - Hd%) \ 2
        END IF
        LOCATE 14, 76: IF Kys% = 16 THEN Kys% = 0
        PRINT RIGHT$(" " + LTRIM$(RTRIM$(STR$(Kys%))), 2);
        IF Kys% = 15 THEN
           LOCATE 15, 67: COLOR 28: PRINT "BUFFER FULL";
           SLEEP 2: KeyFlush: LOCATE , 67: PRINT SPACE$(11);
        END IF
    LOOP UNTIL FarPeek%(&H40, (Tl% - &H400) - 2) = 27
    COLOR 7, 0: LOCATE 20, 1, 0
    Dummy$ = INPUT$(Kys%)
GOTO D400

'   Report mouse cursor position and status.
'
D440:
    IF Mouse% THEN
       Panel 4, 1, 21, 80, 1, TextColour%
       CALL MouseShow
       DO
          MouseNow LeftButton%, RightButton%, xMouse%, yMouse%
          Me$ = "x=" + LTRIM$(RTRIM$(STR$(xMouse%))) + "  "
          FastPrint 12, 31, Me$, TextColour%
          Me$ = "y=" + LTRIM$(RTRIM$(STR$(yMouse%))) + "  "
          FastPrint 12, 41, Me$, TextColour%
          IF LeftButton% THEN
             IF yMouse% > 15 AND yMouse% < 24 THEN
                EXIT DO
             ELSE
                Me$ = "Left button pressed"
             END IF
          ELSE
             Me$ = "                   "
          END IF
          FastPrint 14, 31, Me$, TextColour%
          IF RightButton% THEN
             Me$ = "Right button pressed"
          ELSE
             Me$ = "                    "
          END IF
          FastPrint 15, 31, Me$, TextColour%: Z$ = INKEY$
       LOOP UNTIL Z$ = CHR$(27)
       CALL MouseHide
       IF Z$ <> CHR$(27) THEN GOTO D002
    ELSE
       MisTake 9, "Mouse driver not installed", 0, Mouse%
    END IF
GOTO D400

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Memory-related functions and procedures.                          ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D500:
    IF EmsPresent% THEN Menu$(0) = "F#E" ELSE Menu$(0) = "F# "
    Menu$(1) = "Operating system &Flags"
    Menu$(3) = "&Expanded memory services"
    Abort% = FALSE
    VerMenu 4, 26, BarColour%, 1, 3, "MEMORY", Menu$(), Choice%, Nxt%, Bar%, 1, RootName$, Mouse%, HotKeys%
    IF Nxt% THEN GOTO D002
    SELECT CASE Choice%
        CASE 1
             GOTO D510
        CASE 3
             GOTO D520
        CASE ELSE
    END SELECT
GOTO D002

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      System Flags.                                                     ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D510:
    DIM CoOrd%(16, 2): Context% = 1: Topic$ = "FLAGS"
    Panel 4, 1, 21, 80, 1, TextColour%: RESTORE Flags
    FOR I% = 6 TO 21
        READ Me$: FastPrint I%, 6, Me$, TextColour%
    NEXT I%
    Panel 7, 51, 16, 27, 0, 0
    Panel 6, 50, 16, 27, 7, 48
    FastPrint 7, 53, "CURRENT FLAG SETTINGS", 48
    FastPrint 8, 50, "Ç" + STRING$(25, "Ä") + "¶", 48
    FastPrint 8, 50, "Ç", 55
    FOR I% = 10 TO 17
        READ Me$: FastPrint I%, 52, Me$, 48
    NEXT I%
    FOR I% = 1 TO 16
        READ CoOrd%(I%, 1), CoOrd%(I%, 2): F% = GetFlag%(I%)
        F$ = LTRIM$(RTRIM$(STR$(F%))): F$ = RIGHT$("   " + F$, 3)
        FastPrint CoOrd%(I%, 1), CoOrd%(I%, 2), F$, 48
    NEXT I%
    FastPrint 19, 52, "Enter Flag Number:", 48
    FastPrint 25, 3, SPACE$(78), StatColour%
    FastPrint 25, 3, "Press <ESC> to Abort", StatColour%
    DO
       LOCATE 19, 73: HotKey% = FALSE
       Number$ = RevInput$(2, 0, Number$, Nu$, 1, "REVINPUT", 0, HotKey%)
       IF HotKey% THEN
          Abort% = TRUE
       ELSE
          Number% = VAL(Number$)
          IF Number% < 1 OR Number% > 16 THEN
             BEEP
          ELSE
             Number$ = LTRIM$(RTRIM$(STR$(Number%)))
             Number$ = RIGHT$("  " + Number$, 2)
             FastPrint 19, 73, Number$, 48
             Setting% = GetFlag%(Number%)
             Setting$ = RIGHT$("   " + LTRIM$(RTRIM$(STR$(Setting%))), 3)
             LOCATE CoOrd%(Number%, 1), CoOrd%(Number%, 2)
             Setting$ = RevInput$(3, 0, Setting$, Nu$, 1, "REVINPUT", 0, HotKey%)
             IF HotKey% THEN
                Abort% = TRUE
             ELSE
                Setting% = VAL(Setting$)
                IF Setting% < 0 OR Setting% > 255 THEN
                   BEEP
                ELSE
                   SetFlag Number%, Setting%
                END IF
                Setting% = GetFlag%(Number%)
                Setting$ = RIGHT$("   " + LTRIM$(RTRIM$(STR$(Setting%))), 3)
                FastPrint CoOrd%(Number%, 1), CoOrd%(Number%, 2), Setting$, 48
             END IF
          END IF
       END IF
    LOOP UNTIL Abort%
    ERASE CoOrd%: Frame Head$, 0
GOTO D500

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Expanded Memory services.                                         ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D520:
    Panel 4, 1, 21, 80, 1, TextColour%: Handle% = FALSE
    FastPrint 6, 23, "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿", TextColour%
    FastPrint 7, 23, "³  EXPANDED MEMORY DEMONSTRATION  ³", TextColour%
    FastPrint 8, 23, "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ", TextColour%
    Version% = EmsVersion%: PageFrame% = EmsFrame%
    EmsTotal% = EmsPages%(0): EmsFree% = EmsPages%(1)
    LIM$ = LTRIM$(RTRIM$(STR$(Version%))): L% = LEN(LIM$)
    IF L% > 1 THEN LIM$ = LEFT$(LIM$, L% - 1) + "." + RIGHT$(LIM$, 1)
    Me$ = "You have" + STR$(EmsTotal% * 16) + " KiloBytes of LIM " + LIM$ + " Expanded Memory installed."
    FastPrint 10, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    Me$ = "The Page Frame segment is at address " + HEX$(PageFrame%) + " Hex,"
    FastPrint 11, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    Me$ = "and there are" + STR$(EmsFree%) + " pages (" + LTRIM$(RTRIM$(STR$(EmsFree% * 16))) + "KB) free."
    FastPrint 12, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    IF EmsFree% < 4 THEN
       Me$ = "Sorry, that's not enough for this demonstration."
       FastPrint 15, 40 - (LEN(Me$) \ 2), Me$, TextColour%: GOTO D525
    END IF
    SLEEP 1: KeyFlush: Me$ = "Requesting four pages for this demonstration,"
    FastPrint 14, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    EmsRequest 4, Handle%: IF Handle% = 0 THEN GOTO D529
    Pages% = EmsOwned%(Handle%): IF Pages% < 4 THEN GOTO D529
    Me$ = "they have been assigned to Handle" + STR$(Handle%) + "."
    FastPrint 15, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    Me$ = "Saving this screen to page 1": SLEEP 1: KeyFlush
    FastPrint 17, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    IF Colour% THEN Segment% = &HB800 ELSE Segment% = &HB000
    SLEEP 1: KeyFlush: Me$ = "Drawing and saving three other screens ...."
    FastPrint 17, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    EmsPut Segment%, 0, 4000, 1, Handle%, Done%
    IF NOT Done% THEN GOTO D529
    SLEEP 1: KeyFlush: FastPrint 25, 1, SPACE$(80), StatColour%
    Page% = 2: Row% = 11: Col% = 35
    RESTORE Numbers
    DO
        READ Columns%, BackGround%: IF NOT Colour% THEN BackGround% = 0
        Attr% = Attribute%(15, BackGround%)
        BackFill 4, 1, 21, 80, Attr%
        Scroll 1, 9, 2, 23, 79, 0, Attr%
        FastPrint 10, 36, "P A G E", Attr%
        FOR I% = 1 TO Columns%
            READ Item$: IF Item$ = "F" THEN Item$ = "12345678"
            FOR J% = 1 TO LEN(Item$)
                Rows% = VAL(MID$(Item$, J%, 1))
                FastPrint Row% + Rows%, Col% + I%, CHR$(219), Attr%
            NEXT J%
        NEXT I%
        EmsPut Segment%, 0, 4000, Page%, Handle%, Done%
        Page% = Page% + 1: IF NOT Done% THEN EXIT DO
        SLEEP 1: KeyFlush
    LOOP UNTIL Page% > 4
    IF NOT Done% THEN GOTO D529
    EmsGet Segment%, 0, 4000, 1, Handle%, Done%
    IF NOT Done% THEN GOTO D529
    Me$ = "Now I'll let YOU bring 'em back again ...."
    FastPrint 19, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    FastPrint 22, 24, "Press a key when you're ready >", TextColour%
    LOCATE 22, 56, 1: Page% = 4: IF KeyIn% = 27 THEN GOTO D525
    DO
       EmsGet Segment%, 0, 4000, Page%, Handle%, Done%
       IF NOT Done% THEN EXIT DO
       FastPrint 25, 63, "Press a key >", StatColour%
       LOCATE 25, 77: KeyPress% = KeyIn%
       Page% = Page% - 1
    LOOP WHILE Page% > 1
    IF Done% THEN EmsGet Segment%, 0, 4000, 1, Handle%, Done%
    LOCATE , , 0: IF NOT Done% THEN GOTO D529
    Me$ = "The demonstration was completely successful, which proves that"
    FastPrint 17, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    Me$ = "your Expanded Memory is in good working order."
    FastPrint 18, 40 - (LEN(Me$) \ 2), Me$, TextColour%
D525:
    IF Handle% THEN
       SLEEP 1: KeyFlush: EmsRelease Handle%
       Me$ = "We released all pages assigned to handle" + STR$(Handle%) + " before finishing,"
       FastPrint 20, 40 - (LEN(Me$) \ 2), Me$, TextColour%
       Me$ = "otherwise no other program would have been able to use them."
       FastPrint 21, 40 - (LEN(Me$) \ 2), Me$, TextColour%
    END IF
    SLEEP 2: KeyFlush
GOTO D500

D529:
    Me$ = "An EMM error" + STR$(EmsError%) + " has just occurred ..."
    MisTake 12, Me$, 0, Mouse%
GOTO D525

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Miscellaneous functions and procedures.                           ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D600:
    Menu$(0) = "DHEFP"
    Menu$(1) = "&Date entry and validation"
    Menu$(2) = "&Hardware equipment list"
    Menu$(3) = "&Encryption of text"
    Menu$(4) = "&Fast string sorting"
    Menu$(5) = "&Percentage box"
    Abort% = FALSE
    VerMenu 4, 34, BarColour%, 1, 5, "EXAMPLES", Menu$(), Choice%, Nxt%, Bar%, 1, RootName$, Mouse%, HotKeys%
    IF Nxt% THEN GOTO D002
    SELECT CASE Choice%
        CASE 1
             GOTO D610
        CASE 2
             GOTO D620
        CASE 3
             GOTO D630
        CASE 4
             GOTO D640
        CASE 5
             GOTO D650
        CASE ELSE
    END SELECT
GOTO D002

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Long Date Routine.                                                ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D610:
    IF Colour% THEN Attrib% = 48 ELSE Attrib% = 112
    HotKey% = FALSE: IF ToDay$ = "" THEN ToDay$ = SPACE$(20)
    Context% = 1: Topic$ = "LONGDATE": WW% = LEN(ToDay$)
    WT% = 41 - (WW% \ 2): PopUp 8, 24, 9, 34, Attrib%, 1, 4, -1
    Panel 8, 24, 9, 34, 5, Attrib%
    FastPrint 9, 33, "Today's date is:", Attrib%
    FastPrint 10, WT%, ToDay$, Attrib%
    Ok% = Verify%(1, 12, "Is this correct", 0, Mouse%)
    IF NOT Ok% THEN
       FastPrint 12, 32, "Enter correct date", Attrib%
       Panel 13, 36, 3, 10, 9, Attrib%
       Temp$ = "": LOCATE 14, 37
       Temp$ = DateInput$(Temp$, 1, "DATINPUT", HotKey%)
       IF HotKey% THEN
          Abort% = TRUE
       ELSE
          Now$ = Temp$: MO% = VAL(MID$(Temp$, 4, 2))
          DY% = VAL(LEFT$(Temp$, 2)): YR% = VAL(RIGHT$(Temp$, 2))
          ToDay$ = LongDate$(DY%, MO%, YR%): OL% = LEN(ToDay$)
          IF OL% > 0 THEN
             FastPrint 25, 41, SPACE$(40), StatColour%
             FastPrint 25, 79 - OL%, ToDay$, StatColour%
          END IF
       END IF
    END IF
    ShutUp -1
GOTO D600

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Equipment List.                                                   ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D620:
    Panel 4, 1, 21, 80, 1, TextColour%
    Cols$ = "80": Video$ = "colour": REDIM Model(0 TO 8) AS STRING
    RESTORE HWare: FOR I% = 0 TO 8: READ Model(I%): NEXT
    Equipment% = PeekWord&(&H40, &H10): Flag$ = STRING$(16, "0")
    Computer% = FarPeek%(&HF000, &HFFFE)
    Computer% = Computer% - &HF8: IF Computer% < 0 THEN Computer% = 0
    FastPrint 5, 38, "IBM " + Model(Computer%) + " or compatible", TextColour%
    Chip% = Cpu%: CoPro% = MathsChip%
    SELECT CASE Chip%
        CASE IS < 0
             Me$ = " an Intel 80C" + LTRIM$(RTRIM$(STR$(ABS(Chip%))))
        CASE 20, 30
             Me$ = " a NEC V" + LTRIM$(RTRIM$(STR$(Chip%)))
        CASE 88 TO 486
             Me$ = " an Intel 80" + LTRIM$(RTRIM$(STR$(Chip%)))
        CASE ELSE
             Me$ = " an unknown"
    END SELECT
    Me$ = "with" + Me$ + " microprocessor"
    FastPrint 6, 38, Me$, TextColour%
    FOR I% = 15 TO 0 STEP -1
        IF BitTest%(Equipment%, I%) THEN
           MID$(Flag$, 16 - I%, 1) = "1"
        END IF
    NEXT I%
    FastPrint  5, 3, " F E D C B A 9 8 7 6 5 4 3 2 1 0", TextColour%
    FastPrint  6, 3, "ÚÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄ¿", TextColour%
    FastPrint  7, 3, "³", TextColour%: Col% = 4
    FOR I% = 1 TO 16
        FastPrint 7, Col%, MID$(Flag$, I%, 1) + "³", TextColour%
        Col% = Col% + 2
    NEXT I%
    FastPrint  7, 38, "ROM BIOS Equipment Flag at 0040:0010", TextColour%
    FastPrint  8, 3, "ÀÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÙ", TextColour%
    FastPrint  9, 3, " ³ ³   ³ ³ ³ ³   ³ ³ ³ ³ ³ ³ ³ ³", TextColour%
    FastPrint 10, 3, " ³ ³   ³ ³ ³ ³   ³ ³ ³ ³ ³ ³ ³ ÀÄ", TextColour%
    FastPrint 11, 3, " ³ ³   ³ ³ ³ ³   ³ ³ ³ ³ ³ ³ ÀÄÄÄ", TextColour%
    FastPrint 12, 3, " ³ ³   ³ ³ ³ ³   ³ ³ ³ ³ ÀÄÁÄÄÄÄÄ", TextColour%
    FastPrint 13, 3, " ³ ³   ³ ³ ³ ³   ³ ³ ÀÄÁÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 14, 3, " ³ ³   ³ ³ ³ ³   ÀÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 15, 3, " ³ ³   ³ ÀÄÁÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 16, 3, " ³ ³   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 17, 3, " ÀÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ", TextColour%
    FastPrint 10, 38, "Floppy drives installed?", TextColour%
    IF MID$(Flag$, 16, 1) = "1" THEN Me$ = "Yes" ELSE Me$ = "No"
    FastPrint 10, 68, Me$, TextColour%
    FastPrint 11, 38, "Maths coprocessor installed?", TextColour%
    IF MID$(Flag$, 15, 1) = "1" THEN Me$ = "Yes" ELSE Me$ = "No"
    IF CoPro% > 0 THEN 
       IF Chip% = 486 THEN
          Me$ = "80487"
       ELSE
          Me$ = "80" + LTRIM$(RTRIM$(STR$(CoPro%)))
       END IF
    END IF
    FastPrint 11, 68, Me$, TextColour%
    FastPrint 12, 38, "Original PC motherboard RAM", TextColour%
    IF Computer% = 1 THEN
       Ram% = (BinDec&(MID$(Flag$, 13, 2)) + 1) * 16
       Me$ = RIGHT$("  " + LTRIM$(RTRIM$(STR$(Ram%))), 2) + "KB"
    ELSE
       Me$ = "n/a"
    END IF
    FastPrint 12, 68, Me$, TextColour%
    FastPrint 13, 38, "Initial Video mode", TextColour%
    Mode% = BinDec&(MID$(Flag$, 11, 2))
    IF Mode% = 1 THEN Cols$ = "40"
    IF Mode% = 7 THEN Video$ = "mono"
    FastPrint 13, 58, Cols$ + " column " + Video$, TextColour%
    FastPrint 14, 38, "Number of floppy drives", TextColour%
    Mode% = BinDec&(MID$(Flag$, 9, 2)) + 1
    Me$ = LTRIM$(RTRIM$(STR$(Mode%))): FastPrint 14, 68, Me$, TextColour%
    FastPrint 15, 38, "Number of serial ports", TextColour%
    Mode% = BinDec&(MID$(Flag$, 5, 3))
    Me$ = LTRIM$(RTRIM$(STR$(Mode%))): FastPrint 15, 68, Me$, TextColour%
    FastPrint 16, 38, "Games adaptor installed?", TextColour%
    IF MID$(Flag$, 3, 1) = "1" THEN Me$ = "Yes" ELSE Me$ = "No"
    FastPrint 16, 68, Me$, TextColour%
    FastPrint 17, 38, "Number of parallel printers", TextColour%
    Mode% = BinDec&(LEFT$(Flag$, 2))
    Me$ = LTRIM$(RTRIM$(STR$(Mode%))): FastPrint 17, 68, Me$, TextColour%
    Mode% = BootDrive%: Me$ = "Boot drive is " + CHR$(Mode% + 64) + ":"
    FastPrint 19, 4, Me$, TextColour%: Mode% = CDRom%: 
    IF Mode% THEN
       Me$ = "A CD-ROM is installed as drive " + CHR$(Mode% + 64) + ":"
       FastPrint 19, 38, Me$, TextColour%
    END IF
    Mode% = EmsPages%(0)
    IF Mode% THEN
       Me$ = LTRIM$(STR$(Mode% * 16)) + " KB of Expanded Memory"
       FastPrint 20, 4, Me$, TextColour%
    END IF
    Mode% = XMSize%
    IF Mode% THEN
       Me$ = LTRIM$(STR$(Mode%)) + " KB of Extended Memory"
       FastPrint 20, 38, Me$, TextColour%
    END IF
    Mode% = Ansi%
    IF Mode% THEN
       Me$ = "ANSI console driver installed"
       FastPrint 21, 4, Me$, TextColour%
    END IF
    Mode% = WinMode%
    IF Mode% THEN
       SELECT CASE Mode%
           CASE 1 
                M1$ = "Real"
           CASE 2
                M1$ = "Standard"
           CASE 3
                M1$ = "Enhanced"
           CASE ELSE
       END SELECT 
       Mode% = WinVer%: 
       AH% = HiByte%(Mode%): AL% = LoByte%(Mode%)
       Me$ = "Windows" + STR$(AH%) + "." + LTRIM$(STR$(AL%))
       Me$ = Me$ + " is running in " + M1$ + " mode"
       FastPrint 22, 4, Me$, TextColour%
    END IF
    Mode% = RamDisk%
    IF Mode% THEN
       Me$ = "Drive " + CHR$(Mode%) + ": is a RAM disk"
       FastPrint 23, 4, Me$, TextColour%
    END IF
    Mode% = NetTest%
    IF Mode% THEN
       FastPrint 23, 38, "Novell Network shell is loaded", TextColour%
    END IF
    FastPrint 25, 1, SPACE$(80), StatColour%
    FastPrint 25, 3, "Press a key to continue", StatColour%
    IF Mouse% THEN MouseShow
    DO
       IF Mouse% THEN
          MouseNow LeftButton%, RightButton%, xMouse%, yMouse%
          IF LeftButton% THEN
             IF yMouse% > 15 AND yMouse% < 24 THEN
                Z$ = "": EXIT DO
             END IF
          END IF
       END IF
       Z$ = INKEY$
    LOOP WHILE Z$ = ""
    Frame Head$, 0: ERASE Model
    IF Mouse% THEN
       CALL MouseHide: IF Z$ = "" THEN GOTO D002
    END IF
GOTO D600

'   Text Encryption.
'
D630:
    Panel 4, 1, 21, 80, 1, TextColour%
    Done% = FALSE: Abort% = FALSE: HotKey% = FALSE
    Text$ = "": Code$ = ""
    RESTORE Crypt
    FOR I% = 1 TO 5
        READ Me$: FastPrint 6 + I%, 11, Me$, TextColour%
    NEXT I%
    IF Colour% THEN Attrib% = 32 ELSE Attrib% = 112
    DO WHILE Text$ = ""
       PopUp 17, 19, 4, 44, Attrib%, 2, 2, -1
       FastPrint 18, 27, "Enter string to be encrypted", Attrib%
       LOCATE 19, 21
       Text$ = RevInput$(40, 0, "", "", 1, "REVINPUT", -1, HotKey%)
       ShutUp -1: IF HotKey% THEN Abort% = TRUE: EXIT DO
       Text$ = LTRIM$(RTRIM$(Text$))
       IF Text$ = "" THEN
          MisTake 9, "You can't encrypt an empty string!", 0, Mouse%
       END IF
    LOOP
    IF NOT Abort% THEN
       IF Colour% THEN Attrib% = 78 ELSE Attrib% = 112
       DO WHILE Code$ = ""
          PopUp 17, 19, 4, 44, Attrib%, 2, 2, -1
          FastPrint 18, 25, "Enter string to encrypt it with", Attrib%
          LOCATE 19, 21
          Code$ = RevInput$(40, 0, "", "", 1, "REVINPUT", -1, HotKey%)
          ShutUp -1: IF HotKey% THEN Abort% = TRUE: EXIT DO
          Code$ = LTRIM$(RTRIM$(Code$))
          IF Code$ = "" THEN
             MisTake 12, "An empty string is no use!", 0, Mouse%
          END IF
       LOOP
       IF NOT Abort% THEN
          Cipher Text$, Code$: Me$ = "Encrypted string >  " + Text$
          FastPrint 14, 11, Me$, TextColour%
          IF Colour% THEN Attrib% = 48 ELSE Attrib% = 112
          DO
             DO
                PopUp 19, 19, 4, 44, Attrib%, 2, 2, -1
                FastPrint 20, 27, "Enter key string once again", Attrib%
                LOCATE 21, 21
                DeCode$ = RevInput$(40, 0, "", "", 1, "REVINPUT", -1, HotKey%)
                ShutUp -1: IF HotKey% THEN Abort% = TRUE: EXIT DO
                DeCode$ = LTRIM$(RTRIM$(DeCode$))
                IF DeCode$ = "" THEN
                   MisTake 12, "An empty string is no use!", 0, Mouse%
                END IF
             LOOP WHILE DeCode$ = ""
             IF Abort% THEN
                Done% = TRUE
             ELSE
                Me$ = Text$: Cipher Me$, DeCode$
                Me$ = "Decrypted string >  " + Me$
                FastPrint 16, 11, Me$, TextColour%
                IF Code$ = DeCode$ THEN
                   FastPrint 19, 33, "That's the one!", TextColour%
                   Done% = TRUE
                ELSE
                   Me$ = "Whoops, that's not right"
                   IF MisMatch% THEN
                      Me$ = Me$ + " either"
                   END IF
                   MisTake 9, Me$ + "!", 0, Mouse%
                   MisMatch% = TRUE
                END IF
             END IF
          LOOP UNTIL Done%
       END IF
    END IF
GOTO D600

'   Demonstrate string array sorting and scan routines.
'
D640:
    Room% = TRUE: Me$ = "Not enough memory for sort array"
    ON ERROR GOTO D645
    REDIM Array(1 TO 1000) AS STRING
    ON ERROR GOTO Trap
    IF NOT Room% THEN GOTO D600
    RESTORE Strings: IF Colour% THEN COLOR 0, 7
    Panel 4, 1, 21, 80, 1, TextColour%
    FOR Row% = 6 TO 7
        READ Me$: LOCATE Row%, 3: PRINT Me$
    NEXT Row%
    FOR I% = 1 TO 1000
        FOR J% = 1 TO Rand%(5, 11)
            Array(I%) = Array(I%) + CHR$(Rand%(0, 25) + 65)
        NEXT J%
    NEXT I%
    LOCATE 7, 50: PRINT "done!"
    LOCATE 9, 3: PRINT "Unsorted array"
    FOR I% = 1 TO 3
        Me$ = "Element " + RIGHT$("    " + LTRIM$(RTRIM$(STR$(I%))), 4)
        LOCATE 10 + I%, 3: PRINT Me$; " "; Array(I%)
    NEXT I%
    LOCATE 14, 3: PRINT "  .": Row% = 15
    FOR I% = 998 TO 1000
        Me$ = "Element " + RIGHT$("    " + LTRIM$(RTRIM$(STR$(I%))), 4)
        LOCATE Row%, 3: PRINT Me$; " "; Array(I%): Row% = Row% + 1
    NEXT I%
    PopUp 19, 13, 5, 53, BarColour%, 4, 4, 0
    READ Me$: FastPrint 21, 15, Me$, BarColour%
    LOCATE 21, 62: Legal$ = "AaDd"
    A$ = UCASE$(RevInput$(1, 0, "A", Legal$, 1, "REVINPUT", 0, HotKey%))
    ShutUp 0: IF Colour% THEN COLOR 0, 7
    IF HotKey% THEN Abort% = TRUE: GOTO D642
    IF A$ = "D" THEN
       Direction% = 1: A$ = "descending"
    ELSE
       Direction% = 0: A$ = "ascending"
    END IF
    LOCATE 19, 3: PRINT "Sorting the array into "; A$; " order ....";
    First% = LBOUND(Array): Last% = UBOUND(Array)
    X! = TIMER
    StringSort Direction%, 1000, VARPTR(Array(First%))
    Y! = TIMER
    PRINT " done!": LOCATE 9, 41: PRINT "Sorted array"
    FOR I% = 1 TO 3
        Me$ = "Element " + RIGHT$("    " + LTRIM$(RTRIM$(STR$(I%))), 4)
        LOCATE 10 + I%, 41: PRINT Me$; " "; Array(I%)
    NEXT I%
    LOCATE 14, 41: PRINT "  .": Row% = 15
    FOR I% = 998 TO 1000
        Me$ = "Element " + RIGHT$("    " + LTRIM$(RTRIM$(STR$(I%))), 4)
        LOCATE Row%, 41: PRINT Me$; " "; Array(I%): Row% = Row% + 1
    NEXT I%
    LOCATE 20, 3: PRINT USING "The sort took ###.### seconds"; Y! - X!
    Ok% = Verify%(1, 16, "Search array", 0, Mouse%): IF NOT Ok% THEN GOTO D642
D641:
    PopUp 12, 17, 8, 46, BarColour%, 3, 4, -1: HotKey% = 0
    FastPrint 14, 20, "Enter a string to insert into the array", BarColour%
    LOCATE 15, 30: A$ = RevInput$(20, 0, "", "", 1, "REVINPUT", 0, HotKey%)
    IF HotKey% THEN Abort% = TRUE: ShutUp -1: GOTO D642
    A$ = LTRIM$(RTRIM$(A$))
    Me$ = "Enter element to insert it into (1-" + LTRIM$(RTRIM$(STR$(Last%))) + ") "
    FastPrint 16, 40 - (LEN(Me$) \ 2), Me$, BarColour%
    LOCATE 17, 38: Temp$ = RevInput$(4, 0, "", Nu$, 1, "REVINPUT", 0, HotKey%)
    ShutUp -1: IF Colour% THEN COLOR 0, 7
    IF HotKey% THEN
       Abort% = TRUE: GOTO D642
    ELSE
       S% = VAL(Temp$)
       IF S% < First% OR S% > Last% THEN
          MisTake 9, "OUT OF RANGE!", 0, Mouse%
          GOTO D641
       ELSE
          Array(S%) = A$
          IF S% < 4 THEN
             LOCATE 10 + S%, 54: PRINT SPACE$(12);
             LOCATE 10 + S%, 54: PRINT A$;
          ELSEIF S% > 997 THEN
             LOCATE S% - 983, 54: PRINT SPACE$(12);
             LOCATE S% - 983, 54: PRINT A$;
          END IF
       END IF
    END IF
    LOCATE 21, 3: PRINT "Scanning array for " + A$ + " .... ";
    X! = TIMER
    Match% = StringScan%(A$, 1000, First%, VARPTR(Array$(First%)))
    Y! = TIMER
    PRINT "found it at element"; Match%
    LOCATE 22, 3: PRINT USING "The search took ###.### seconds"; Y! - X!
D642:
    ERASE Array: IF Colour% THEN COLOR 7, 0
GOTO D002

D645:
    MisTake 9, Me$, 0, Mouse%
    Room% = FALSE
RESUME NEXT

'   Display a popup window with a percentage bar measuring the progress
'   of a function or procedure.
'
D650:
    PerCentBox 1, "Passing the time away", 0, 0
    StartTime& = TIMER
    DO
        ThisTime& = TIMER - StartTime&
        Percentage% = (ThisTime& / 30) * 100
        PerCentBox 2, "", 0, Percentage%
        IF INKEY$ = CHR$(27) THEN EXIT DO
    LOOP UNTIL ThisTime& > 30
    PerCentBox 3, "", 0, 0
GOTO D600

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Graphics examples.                                                ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D700:
    VideoMode Colour%, MaxRes%, VideoRam%
    IF MaxRes% > 8 THEN
       Menu$(0) = "CP#SR"
    ELSEIF MaxRes% AND MaxRes% <> 3 THEN
       Menu$(0) = "C #  "
    ELSE
       Menu$(0) = "  #  "
    END IF
    Menu$(1) = "Graphics &characters"
    Menu$(2) = "Video &panning"
    Menu$(4) = "&Save screen to file"
    Menu$(5) = "&Restore screen"
    VerMenu 4, 47, BarColour%, 1, 5, "GRAPHICS", Menu$(), Choice%, Nxt%, Bar%, 1, RootName$, Mouse%, HotKeys%
    IF Nxt% THEN GOTO D002
    SELECT CASE Choice%
        CASE 1
             GOTO D710
        CASE 2
             GOTO D720
        CASE 4, 5
             GOTO D730
        CASE ELSE
    END SELECT
GOTO D002

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Graphics characters.                                              ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D710:
    SELECT CASE MaxRes%
        CASE 2                                  ' Colour Graphics Adaptor
             Mode = 1
             SCREEN 1                           ' 320 x 200   4-colour
        CASE 9                                  ' Enhanced Graphics Adaptor
             Mode = 2
             SCREEN 9                           ' 640 x 350  16-colour
             WINDOW SCREEN (0, 0)-(319, 199)
        CASE 13
             IF VideoRam% > 64 THEN
                Mode = 3                        ' Video Graphics Array
                SCREEN 12                       ' 640 X 480  16-colour
                WINDOW SCREEN (0, 0)-(319, 199)
             ELSE
                Mode = 4                        ' Multicolour Graphics Array
                SCREEN 13                       ' 320 x 200 256-colour
             END IF
        CASE ELSE
             MisTake 9, "Incompatible Video Card!", 0, Mouse%
             GOTO D002
    END SELECT

    REDIM Hue(1 TO 4) AS INTEGER
    PLAY "mft240o3l8d#fgl8b-p8l8gl2b-"          ' Hoop-la!
    RESTORE Title
    PLAY "mbl8t255o3bo4cdo3bo4co3abgaf#t120gbt200dp8"
    FOR I% = 1 TO 4: READ Hue(I%): NEXT
    READ Count%, X1%, Y1%, X2%, Y2%
    LINE (X1%, Y1%)-(X2%, Y2%), Hue(Mode)
    FOR I% = 1 TO Count%
        READ X%, Y%: LINE -(X%, Y%), Hue(Mode)
    NEXT I%
    LINE (0, 165)-(259, 165), Hue(Mode)
    IF Mode = 1 THEN
       Road$ = CHR$(&H22) + CHR$(11) + CHR$(&H88) + CHR$(44)
       Tree$ = CHR$(&H11) + CHR$(&H88) + CHR$(&H44) + CHR$(&H22)
       PAINT (5, 5), 2, Hue(Mode)
       PAINT (310, 100), 1, Hue(Mode)
       PAINT (250, 163), Road$, Hue(Mode)
       PAINT (10, 100), 1, Hue(Mode)
       LINE (0, 165)-(319, 165), 0
    ELSE
       PAINT (5, 5), 9, Hue(Mode)
       PAINT (310, 100), Hue(Mode), Hue(Mode)
       PAINT (250, 163), 8, Hue(Mode)
       PAINT (10, 100), Hue(Mode), Hue(Mode)
       LINE (0, 165)-(319, 165), 0
    END IF
    PSET (57, 113), Hue(Mode)
    FOR I% = 1 TO 4: READ Hue(I%): NEXT
    READ Count%, X1%, Y1%, X2%, Y2%
    LINE (X1%, Y1%)-(X2%, Y2%), Hue(Mode)
    FOR I% = 1 TO Count%
        READ X%, Y%: LINE -(X%, Y%), Hue(Mode)
    NEXT I%
    CIRCLE (127, 109), 45, Hue(Mode), 1.35, 3.1, .3
    CIRCLE (166, 102), 35, Hue(Mode), 1, 2.8, .43
    CIRCLE (214, 95), 32, Hue(Mode), 1.1, 2.8, .39
    CIRCLE (259, 94), 38, Hue(Mode), .7, 2.6, .48
    CIRCLE (296, 96), 33, Hue(Mode), .1, 1.92, .45
    IF Mode = 1 THEN
       PAINT (215, 90), Tree$, Hue(Mode)
    ELSE
       PAINT (215, 90), Hue(Mode), Hue(Mode)
    END IF
    PSET (83, 108), Hue(Mode)
    FOR I% = 1 TO 4: READ Hue(I%): NEXT
    READ Count%, X1%, Y1%, X2%, Y2%
    LINE (X1%, Y1%)-(X2%, Y2%), Hue(Mode)
    FOR I% = 1 TO Count%
        READ X%, Y%: LINE -(X%, Y%), Hue(Mode)
    NEXT I%
    LINE (270, 72)-(276, 86), Hue(Mode), BF
    PAINT (260, 95), Hue(Mode), Hue(Mode)
    IF Mode = 1 THEN
       LINE (215, 86)-(260, 73), 0: LINE -(305, 86), 0
       LINE (226, 88)-(246, 93), 1, BF: LINE (274, 88)-(294, 93), 1, BF
       LINE (255, 88)-(265, 98), 2, BF: LINE (271, 70)-(272, 71), 0, BF
       LINE (274, 70)-(275, 71), 0, BF
    ELSE
       LINE (215, 86)-(260, 73), 4: LINE -(305, 86), 4
       LINE (226, 88)-(246, 93), 26, BF: LINE (274, 88)-(294, 93), 26, BF
       LINE (255, 88)-(265, 98), 6, BF: LINE (271, 70)-(272, 71), 6, BF
       LINE (274, 70)-(275, 71), 6, BF: LINE (319, 98)-(220, 98), 8
       LINE -(186, 99), 8: LINE -(159, 101), 8: LINE -(210, 100), 8
       LINE -(319, 100), 8: PAINT (300, 99), 8, 8
    END IF
    PLAY "t255o4cdecdo3bo4co3abgt120f#at200dp8"
    FOR I% = 1 TO 4: READ Hue(I%): NEXT
    LINE (320, 102)-(285, 102), Hue(Mode)
    CIRCLE (292, 102), 6, Hue(Mode), .8, 3.1415, .7
    CIRCLE (302, 102), 9, Hue(Mode), .8, 2.5, .75
    CIRCLE (318, 102), 16, Hue(Mode), .6, 2.7, .85
    IF Mode = 1 THEN
       LINE (320, 94)-(307, 93), 1
       PAINT (310, 95), Tree$, Hue(Mode), CHR$(&HAA)
       GraPrint 256, 78, "A", GrAttrib%(0, 3), 1
       LINE (76, 6)-(244, 32), 3, BF: LINE (76, 32)-(244, 52), 1, BF
    ELSE
       PAINT (310, 100), Hue(Mode), Hue(Mode)
       IF Mode = 2 THEN
          GraPrint 495, 136, "Club-PC", GrAttrib%(1, -1), 1
       ELSEIF Mode = 3 THEN
          GraPrint 495, 190, "Club-PC", GrAttrib%(1, -1), 1
       ELSE
          GraPrint 248, 78, "CPC", GrAttrib%(27, -1), 1
       END IF
       LINE (76, 6)-(244, 32), 14, BF: LINE (76, 32)-(244, 52), 15, BF
    END IF
    Me$ = "GRAPHICS": I% = 1: X% = 80: Y% = 9
    IF Mode = 1 THEN
       Clr% = GrAttrib%(0, 3): Box% = 0
    ELSE
       Clr% = GrAttrib%(1, -1): Box% = 1
    END IF
    DO
        LINE (X%, Y%)-(X% + 20, Y% + 20), Box%, B
        IF Mode = 2 THEN
           GraPrint ((X% * 2) + 8), (Y% * 1.4) + 3, MID$(Me$, I%, 1), Clr%, 3
        ELSEIF Mode = 3 THEN
           GraPrint ((X% * 2) + 8), (Y% * 2.4) + 3, MID$(Me$, I%, 1), Clr%, 3
        ELSE
           GraPrint X% + 3, Y% + 3, MID$(Me$, I%, 1), Clr%, 2
        END IF
        I% = I% + 1: X% = X% + 20
    LOOP UNTIL I% > 8
    Me$ = "CHARACTERS": I% = 1: X% = 78: Y% = 32
    IF Mode = 1 THEN
       Clr% = GrAttrib%(2, 1)
    ELSE
       Clr% = GrAttrib%(7, -1)
    END IF
    DO
        IF Mode = 2 THEN
           GraPrint ((X% * 2) + 8), (Y% * 1.6) + 3, MID$(Me$, I%, 1), Clr%, 3
        ELSEIF Mode = 3 THEN
           GraPrint ((X% * 2) + 9), (Y% * 2.4) + 3, MID$(Me$, I%, 1), Clr%, 3
        ELSE
           GraPrint X% + 5, Y% + 3, MID$(Me$, I%, 1), Clr%, 2
        END IF
        I% = I% + 1: X% = X% + 16
    LOOP UNTIL I% > 10
    IF Mode = 1 THEN
       LINE (5, 60)-(175, 145), 0, BF: LINE (4, 59)-(176, 146), 3, B
    END IF
    I% = 1: READ Count%
    DO
        READ X%, Y%, Me$, Fore%, Back%, Scale%
        IF Mode = 2 THEN
           GraPrint X% * 2, (Y% * 1.6), Me$, GrAttrib%(Fore%, -1), Scale%
        ELSEIF Mode = 3 THEN
           GraPrint X% * 2, (Y% * 2) + 30, Me$, GrAttrib%(Fore%, -1), Scale%
        ELSE
           GraPrint X%, Y%, Me$, GrAttrib%(Fore%, Back%), Scale%
        END IF
        I% = I% + 1
    LOOP UNTIL I% > Count%
    I% = 1: READ Count%
    DO
        READ X%, Y%, Me$, Fore%, Back%, Scale%
        IF Mode = 2 THEN
           GraPrint X% * 3, (Y% * 1.4), Me$, GrAttrib%(Fore%, -1), Scale%
        ELSEIF Mode = 3 THEN
           GraPrint X% * 3, Y% * 1.92, Me$, GrAttrib%(Fore%, -1), Scale%
        ELSE
           GraPrint X%, Y%, Me$, GrAttrib%(Fore%, Back%), Scale%
        END IF
        I% = I% + 1
    LOOP UNTIL I% > Count%
    PLAY "mft255ef#gdef#gef#g#aef#g#ag#abo4co3bo4cdeco3af#gdgbt120g"
    I% = 1: READ Count%
    DO
        READ X%, Y%, Me$, Fore%, Back%, Scale%
        IF Mode = 2 THEN
           GraPrint X% * 2, Y% * 1.6, Me$, GrAttrib%(Fore%, -1), 2
        ELSEIF Mode = 3 THEN
           GraPrint X% * 2, Y% * 2.2, Me$, GrAttrib%(Fore%, -1), 2
        ELSE
           GraPrint X%, Y%, Me$, GrAttrib%(Fore%, Back%), Scale%
        END IF
        I% = I% + 1
    LOOP UNTIL I% > Count%
    DO: LOOP UNTIL KeyIn% = 32
    SCREEN 0: WIDTH 80
GOTO D001

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Video Panning.                                                    ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D720:
    IF (MaxRes% = 13 AND VideoRam% > 64) OR MaxRes% > 9 THEN
       SCREEN 9: LINE (0, 0)-(639, 349), 9, BF
       VIEW SCREEN (40, 25)-(600, 325), 0, 15
       CIRCLE (319, 174), 150, 14: PAINT (319, 174), 14, 14
       X% = 0: Y% = 0
       DO
          KeyPress% = KeyIn%: Pan% = TRUE
          SELECT CASE KeyPress%
              CASE -75
                   IF X% > 0 THEN X% = X% - 1
              CASE -77
                   IF X% < 79 THEN X% = X% + 1
              CASE -72
                   IF Y% > 0 THEN Y% = Y% - 1
              CASE -80
                   IF Y% < 22 THEN Y% = Y% + 1
              CASE ELSE
                   Pan% = FALSE
          END SELECT
          IF Pan% THEN VGAPan X%, Y% * 5
       LOOP UNTIL KeyPress% = 27
       SCREEN 0: WIDTH 80
    ELSE
       MisTake 9, "Incompatible Video Card!", 0, Mouse%
    END IF
GOTO D001

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Video Save and Restore.                                           ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D730:
    SELECT CASE MaxRes%
        CASE 7
             xMax% = 319: yMax% = 199: SaveSize& = 32000
        CASE 8
             xMax% = 639: yMax% = 199: SaveSize& = 64000
        CASE 9, 10
             xMax% = 639: yMax% = 349: SaveSize& = 112000
        CASE 11, 12
             xMax% = 639: yMax% = 479: SaveSize& = 153600
        CASE 13
             IF VideoRam% > 64 THEN
                xMax% = 639: yMax% = 479: SaveSize& = 153600
                MaxRes% = 12
             ELSE
                xMax% = 319: yMax% = 199: SaveSize& = 64000
             END IF
        CASE ELSE
             MisTake 9, "Incompatible Video Card!", 0, Mouse%
             GOTO D002
    END SELECT
    IF Choice% = 4 THEN
       IF FreeSpace&(0) > SaveSize& THEN
          SCREEN MaxRes%: RESTORE Escher
          LINE (0, 0)-(xMax%, yMax%), 6, BF
          VIEW (32, 4)-(xMax% - 32, yMax% - 4), 0, 5
          WINDOW SCREEN (0, 0)-(255, 191)
          FOR I% = 1 TO 40
              READ A%, B%, C%, D%: LINE (A%, B%)-(C%, D%), 1
          NEXT I%
          PAINT (56, 20), 1, 1: PAINT (136, 64), 1, 1
          PAINT (120, 80), 1, 1: PAINT (192, 88), 14, 1
          PAINT (76, 48), 14, 1: PAINT (124, 60), 14, 1
          PAINT (68, 12), 2, 1: PAINT (80, 84), 2, 1
          PAINT (92, 128), 2, 1: PAINT (36, 156), 12, 1
          PAINT (36, 168), 1, 1: PAINT (84, 178), 14, 1
          PAINT (88, 118), 12, 1: PAINT (144, 86), 12, 1
          VGASave "ESCHER.IMG": KeyPress% = KeyIn%
       ELSE
          MisTake 9, "Insufficient disk space!", 0, Mouse%
       END IF
    ELSE
       IF FileSize&("ESCHER.IMG") > 0 THEN
          SCREEN MaxRes%
          VGALoad "ESCHER.IMG"
          KeyPress% = KeyIn%
       ELSE
          MisTake 9, "Screen Image file not found!", 0, Mouse%
       END IF
    END IF
    SCREEN 0: WIDTH 80
GOTO D001

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Program Exit.                                                     ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D800:
    Menu$(0) = "ED#A"
    Menu$(1) = "&Exit program"
    Menu$(2) = "&DOS shell"
    Menu$(4) = "&About DEMON"
    VerMenu 4, 59, BarColour%, 1, 4, "EXIT", Menu$(), Choice%, Nxt%, Bar%, 1, RootName$, Mouse%, HotKeys%
    IF Nxt% THEN GOTO D002
    SELECT CASE Choice%
        CASE 1
             GOTO D810
        CASE 2
             GOTO D820
        CASE 4
             PopUp 9, 14, 9, 53, BarColour%, 1, 4, -1
             Panel 9, 14, 9, 53, 5, BarColour%
             FastPrint 9, 35, " D E M O N ", BarColour%
             RESTORE About
             READ Me$: FastPrint 11, 40 - (LEN(Me$) \ 2), Me$, BarColour%
             READ Me$: FastPrint 12, 40 - (LEN(Me$) \ 2), Me$, BarColour%
             READ Me$: FastPrint 13, 40 - (LEN(Me$) \ 2), Me$, BarColour%
             Panel 14, 34, 3, 12, 5, BarColour%
             FastPrint 15, 38, " OK ", 14: Ky% = FALSE
             IF Mouse% THEN
                xHot% = 37 * 8: yHot% = 13 * 8
                CALL MouseShow
             END IF
             DO
                IF KeyStat% THEN
                   Ky% = KeyIn%
                   IF Ky% = 13 THEN
                      Panel 14, 34, 3, 12, 9, BarColour%
                   END IF   
                ELSEIF Mouse% THEN
                   MouseNow LeftButton%, RightButton%, xMouse%, yMouse%
                   IF LeftButton% THEN
                      IF yMouse% > yHot% AND yMouse% < yHot% + 16 THEN
                         IF xMouse% > xHot% AND xMouse% < xHot% + 48 THEN
                            Panel 14, 34, 3, 12, 9, BarColour%
                            Ky% = 13
                         END IF
                      END IF
                      DO
                          MouseNow LeftButton%, RightButton%, xMouse%, yMouse%
                      LOOP WHILE LeftButton%
                   END IF
                END IF
             LOOP UNTIL Ky% = 13
             IF Mouse% THEN MouseHide
             ShutUp -1
        CASE ELSE
    END SELECT
GOTO D002

'   Program Exit
'
D810:
    IF Colour% THEN
       Scroll 1, 1, 1, 25, 80, 0, Attribute%(15, 1)
       COLOR , , 1: Attrib% = 32
    ELSE
       FOR I% = 1 TO 24
           FastPrint I%, 1, STRING$(80, "°"), 7
       NEXT I%
       Attrib% = 112
    END IF
    PopUp 3, 2, 9, 44, Attrib%, 3, 2, -1: RESTORE Credits
    FOR I% = 4 TO 9
        READ Me$: FastPrint I%, 4, Me$, Attrib%
    NEXT I%
    SLEEP 5: KeyFlush
    IF Colour% THEN Attrib% = 48 ELSE Attrib% = 112
    PopUp 10, 29, 11, 50, Attrib%, 2, 1, -1
    FOR I% = 11 TO 19
        READ Me$: FastPrint I%, 31, Me$, Attrib%
    NEXT I%
    SLEEP 10: ShutUp -1: SLEEP 1: ShutUp -1: SLEEP 1
    CALL KeyFlush: CLS
GOTO Egress

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Operating System Shell.                                           ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
D820:
    FastPrint 21, 2, SPACE$(78), 31
    Me$ = "Enter the command 'EXIT' when you are ready to return."
    FastPrint 21, 40 - (LEN(Me$) \ 2), Me$, 31
    LOCATE 13, 1, 1: ON ERROR GOTO D821
    PopUp 5, 4, 15, 74, 15, 3, 0, -1
    DOSBox 1, 6, 5, 18, 75, 7
    SHELL
    DOSBox 0, 0, 0, 0, 0, 0
    LOCATE 3, 1, 0: ShutUp -1
    FastPrint 21, 2, SPACE$(78), TextColour%
    ON ERROR GOTO Trap
    GOTO D800
D821:
    ON ERROR GOTO Trap
    DOSBox 0, 0, 0, 0, 0, 0
    LOCATE 3, 1, 0: ShutUp -1
    FastPrint 21, 2, SPACE$(78), TextColour%
    IF ERR = 5 THEN
       MisTake 9, "Cannot load secondary Command Processor", 0, Mouse%
       RESUME D800
    END IF

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      Error Trap.                                                       ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
Trap:
    Fatal% = TRUE
    SELECT CASE ERR
        CASE 7, 14
             Me$ = "Out of memory"
        CASE 27
             Me$ = "PRINTER NOT READY": Fatal% = FALSE
        CASE 61, 67
             Me$ = "Out of disk space"
        CASE 71
             Me$ = "DISK DRIVE NOT READY": Fatal% = FALSE
        CASE 72
             Me$ = "Disk media error"
        CASE ELSE
             A$ = STR$(ERR): Me$ = "A type" + A$ + " Error has just occurred"
    END SELECT
    IF Fatal% THEN
       Me$ = Me$ + ", aborting to DOS ..."
       SL% = StatusLine%(Me$)
       RESUME Egress
    ELSE
       ML% = LEN(Me$): MT% = 40 - (ML% \ 2)
       IF Colour% THEN Attrib% = 78 ELSE Attrib% = 112
       PopUp 9, 20, 7, 42, Attrib%, 3, 2, -1
       FastPrint 10, MT%, Me$, Attrib% + 128: BEEP
       Me$ = "Please correct this error if possible"
       FastPrint 12, 22, Me$, Attrib%
       FastPrint 13, 30, "Press a key when ready", Attrib%
       FastPrint 14, 32, "or <ESC> to Abort.", Attrib%
       Character% = KeyIn%: ShutUp -1
       IF Character% = 27 THEN RESUME Egress
       RESUME
    END IF
Egress:
    Attr% = SCREEN(20, 1, 1)
    Curtains 25, 255: Curtains 25, 31: Curtains 25, Attr%
    LOCATE 20, 1, 1: ClearEnd 1, Attr%
END

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³     Program specific functions and procedures.                         ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
'   Draws or refreshes the main display screen. If switch is zero, only the
'   status line is refreshed.
'
SUB Frame (Title$, Switch%) STATIC
    SHARED StatColour%, HeadColour%, TextColour%, ToDay$
    IF Switch% THEN
       Scroll 1, 1, 1, 3, 80, 0, HeadColour%
       IF Title$ <> "" THEN
          FastPrint 1, 40 - (LEN(Title$) \ 2), Title$, HeadColour%
       END IF
       FastPrint 2, 1, STRING$(80, "Ä"), HeadColour%
       Panel 4, 1, 21, 80, 1, TextColour%
    END IF
    FastPrint 25, 1, SPACE$(80), StatColour%
    FastPrint 25, 4, "Press <F1> for Help, <ESC> to Abort", StatColour%
    IF ToDay$ <> "" THEN
       FastPrint 25, 78 - LEN(ToDay$), ToDay$, StatColour%
    END IF
END SUB

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³     Data Division.                                                     ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
Blurb:
    DATA "The Library modules on this disk provide you"
    DATA "with all the facilities necessary for you to"
    DATA "implement a full range of window features in"
    DATA "your programs.  With just one statement, for"
    DATA "instance, you can 'Pop-up' a window onto the"
    DATA "screen."
    DATA "The window can be a simple rectangle, in any"
    DATA "the QuickBASIC background colors, such as .."
    DATA "Alternatively it may have a border in one of"
    DATA "eight styles ...."
    DATA "The border itself may be in any one of the"
    DATA "QuickBASIC foreground colors. It can blink"
    DATA "if you want it to ..."
    DATA "The window, too, can be presented in several"
    DATA "different ways. It can be flat..."
    DATA "or it can have a black shadow underneath, to"
    DATA "give a three-dimensional effect..."
    DATA "Once you have a window on the screen, simply"
    DATA "use FASTPRINT, also in the ALTQUICK Library,"
    DATA "to put text into it, in any colour you like."
    DATA "You can also use the SCROLL routine from the"
    DATA "same source, to clear the window's contents."
    DATA "All the functions in the Library are written"
    DATA "in fast assembly language, but this does not"
    DATA "prevent them from being very easy to use."
    DATA "This for instance, is the call to create the"
    DATA "present window ....."
    DATA "   PopUp 8, 14, 8, 52, 112, 2, 0, -1"
    DATA "Before opening a window, the function stores"
    DATA "the screen beneath it in an internal buffer."
    DATA "When you close a window, the screen contents"
    DATA "are restored to their original location. Use"
    DATA "the statement 'ShutUp -1' to close the last"
    DATA "window opened.  For example ...."
    DATA "The Library includes several functions which"
    DATA "apply windowing techniques. The HELP screen,"
    DATA "which is available at the front menu, is one"
    DATA "example. Another is the VERIFY BOX which you"
    DATA "can use to collect a Yes/No response from an"
    DATA "operator, without redrawing the display."
    DATA "Another utility is the STATUS LINE MESSAGE,"
    DATA "which can be used to pause execution of the"
    DATA "program until the operator presses a key."
    DATA "You can display any prompt message you like"
    DATA "and the function will return the ASCII code"
    DATA "of the key which was pressed."
    DATA "I often use StatusLine in conjunction with a"
    DATA "routine which checks if the printer is ready"
    DATA "or not.  This gives the user a chance to fix"
    DATA "the printer,  if it is just out of paper, or"
    DATA "to abandon printing, if it is a more serious"
    DATA "problem. PrinTest is included here too."

Flags:
    DATA "The ASSEMBLY-LANGUAGE TOOLBOX includes a"
    DATA "pair  of functions which give you access"
    DATA "to  the  INTRA-APPLICATION COMMUNICATION"
    DATA "AREA (IAC),  an area of memory which has"
    DATA "been reserved,  by DOS, so that programs"
    DATA "can communicate with each other. The IAC"
    DATA "is 16 bytes long and is located,  in low"
    DATA "RAM at addresses 0000:04F0 - 04FF (Hex)."
    DATA "Once set, an IAC flag retains it's value"
    DATA "until  you reset it,  or the computer is"
    DATA "rebooted."
    DATA "Since QuickBASIC programs, compiled with"
    DATA "the /O switch to run stand-alone, cannot"
    DATA "pass variables to chain modules, you can"
    DATA "use  this feature to implement a limited"
    DATA "form of parameter passing."
    DATA "1.4F0h       9.4F8h", "2.4F1h      10.4F9h"
    DATA "3.4F2h      11.4FAh", "4.4F3h      12.4FBh"
    DATA "5.4F4h      13.4FCh", "6.4F5h      14.4FDh"
    DATA "7.4F6h      15.4FEh", "8.4F7h      16.4FFh"
    DATA 10, 59, 11, 59, 12, 59, 13, 59, 14, 59, 15, 59
    DATA 16, 59, 17, 59, 10, 72, 11, 72, 12, 72, 13, 72
    DATA 14, 72, 15, 72, 16, 72, 17, 72

Finder:
    DATA "This function allows you to find out if a particular"
    DATA "file is present on any disk drive in the system."," "
    DATA "Enter the name of the file which you want to locate,"
    DATA "including the drive letter and directory pathname if"
    DATA "required.  You can use an ambiguous name,  including"
    DATA "the wildcard characters (* and ?).  In this case the"
    DATA "function will pop up a directory window containing a"
    DATA "list of all files that match. You can select the one"
    DATA "you are interested in,  by high-lighting it with the"
    DATA "cursor arrow keys and pressing <RETURN>. The routine"
    DATA "returns a string containing the full pathname of the"
    DATA "file which you have selected."

Sorts:
    DATA "SORTFILE sorts ASCII text files. You supply the name, which may"
    DATA "include a directory pathname, and the start position and length"
    DATA "of the field which the file is to be sorted on.", " "
    DATA "The program first checks the size of the file and the amount of"
    DATA "free disk space to see if the it can be sorted in memory, this"
    DATA "requires space for two copies of the file on disk. If it is too"
    DATA "large, the file is sorted in place so that no extra disk space"
    DATA "is required. Using this method, which is far slower, the file"
    DATA "may be of any size up to 4 Gigabytes."

Size:
    DATA "THIS PROGRAM REPORTS THE SIZE OF FILES WHICH YOU SPECIFY"
    DATA "--------------------------------------------------------", " "
    DATA "The filename can include a directory path and may be ambiguous,"
    DATA "using the wildcard characters '*' and '?'. The program will"
    DATA "return the size of the file, in bytes, or, if more than one"
    DATA "match is found, the total size of all the files. If a size of"
    DATA "zero is returned, the file does not exist (at least not in the"
    DATA "directory specified).", " "
    DATA "Type in the pathname required (no more than 64 characters) or"
    DATA "Enter an empty string to quit."

KeyBuff:
    DATA 19, 6, 4, "Head Tail", 6, 33, "Keyboard Buffer"
    DATA  6, 67, "Buffer Area", 8, 4, "041A 041C"
    DATA  8, 17, "1E 20 22 24 26 28 2A 2C 2E 30 32 34 36 38 3A 3C"
    DATA  8, 68, "0480 0482", 10, 3, "ÚÄÄÄÄÂÄÄÄÄ¿"
    DATA 10, 16, "ÚÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄ¿"
    DATA 10, 67, "ÚÄÄÄÄÂÄÄÄÄ¿",11, 3,"³         ³", 11, 16, "³"
    DATA 11, 64, "³", 11, 67, "³         ³", 12, 3, "ÀÄÄÄÄÁÄÄÄÄÙ"
    DATA 12, 16, "ÀÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÙ"
    DATA 12, 67, "ÀÄÄÄÄÁÄÄÄÄÙ", 14, 3, "ASCII Codes"
    DATA 14, 67, "Waiting", 15, 3, "Scan Codes"

HWare:
    DATA "Unknown computer type", "PC", "PC/XT", "PCjr"
    DATA "PC/AT, PS/2", "PC/XT", "PS/2 Model 30"
    DATA "PC Convertible", "PS/2 Model 80"

Shift:
    DATA "Left & Right SHIFT keys pressed", "CTRL key pressed"
    DATA "ALT key pressed", "SCROLL LOCK active"
    DATA "NUM LOCK active", "CAPS LOCK active"
    DATA "INSERT key status", "Left CTRL key pressed"
    DATA "Left ALT key pressed", "SYS REQ key pressed"
    DATA "PAUSE (or CTRL-NUM LOCK) active", "SCROLL LOCK pressed"
    DATA "NUM LOCK pressed", "CAPS LOCK pressed"
    DATA "INSERT key pressed"

Numbers:
    DATA 8, 1, 125678, 125678, 158, 158, 158, 158, 123458, 123458
    DATA 8, 4, 1278, 1278, 18, 148, 148, 148, F, 1235678
    DATA 8, 5, 12345, 12345, 5, 5, 45678, 45678, 5, 5
    DATA 8, 6, 12348, 12348, 148, 148, 148, 148, 145678, 145678

Crypt:
    DATA "This routine requires that you supply two strings of
    DATA "characters. The first is the text to be encrypted, and"
    DATA "the second is one or more keywords which are used to"
    DATA "encipher the text. Thereafter, the text cannot be"
    DATA "decrypted until you supply the same key string again."

Strings:
    DATA "Building a 1000 element, variable-length, string array"
    DATA "in memory and filling it with random data .... "
    DATA "Sort into Ascending or Descending order (A/D) [ ]"

Path:
    DATA "By default, the Toolbox Help system looks for its'"
    DATA "topic files in a subdirectory called HELP, beneath"
    DATA "the currently-logged directory.  You can, however,"
    DATA "direct it to look elsewhere for files by setting a"
    DATA "HELP variable in the DOS environment table;",""
    DATA "e.g.  SET HELP=C:\BASIC\TOOLBOX\HELP",""
    DATA "Alternatively, you can use the QuickBASIC ENVIRON"
    DATA "statement within your program, to point HELPMATE to"
    DATA "the appropriate pathname. Remember, 'though, that"
    DATA "this method only remains in effect as long as the"
    DATA "current program is running."
    DATA "The current HELP environment pathname is"
    DATA "Enter replacement or press <Esc> to leave unchanged"

Title:
    DATA 1, 2, 2, 2, 29, 0, 92, 23, 95
    DATA 64, 98, 104, 101, 135, 103, 102, 106, 65, 112, 30, 115
    DATA 10, 119, 5, 122, 3, 125, 5, 128, 10, 131, 30, 136, 65, 142
    DATA 221, 165, 320, 165, 320, 156, 35, 125, 27, 122, 35, 119
    DATA 65, 112, 102, 106, 135, 103, 149, 102, 162, 101, 195, 98
    DATA 240, 92, 272, 90, 304, 92, 320, 94
    DATA 0, 6, 6, 167, 8, 320, 94, 304, 92
    DATA 272, 90, 240, 92, 195, 98, 162, 101, 149, 102, 135, 103
    DATA 102, 106, 82, 109
    DATA 3, 7, 7, 90, 6, 220, 85, 220, 98
    DATA 300, 98, 300, 86, 305, 86, 260, 73, 215, 86, 220, 86
    DATA 0, 6, 6, 167

    DATA 6
    DATA 15, 65, "Toolbox Users", 15, -1, 1
    DATA 15, 75, "register now at...", 15, -1, 1
    DATA 15, 95, "Club-PC BBS", 15, -1, 1
    DATA 15, 105, "1217 Crescent Drive", 15, -1, 1
    DATA 15, 115, "Smithfield VA 23430", 15, -1, 1
    DATA 15, 134, "Tel. (804) 357-0357", 15, -1, 1
    DATA 2
    DATA 8, 172, "for TOOLBOX support", 14, 0, 2
    DATA 8, 172, "    TOOLBOX", 13, -1, 2
    DATA 2
    DATA 39, 192, "Press the SPACE BAR to continue", 11, 0, 1
    DATA 39, 192, "          SPACE BAR", 15, -1, 1

Escher:
    DATA 68,4,200,76,52,12,112,44,128,52,172,76,128,52,68,84,112,44,84,60
    DATA 128,68,99,84,68,36,97,52,128,68,154,84,128,68,128,116,128,52,128
    DATA 68,68,4,52,12,172,76,142,90,142,76,142,108,142,108,200,76,200,76
    DATA 200,92,200,92,68,164,128,116,84,140,52,12,52,154,52,154,68,164
    DATA 68,164,68,100,68,36,68,84,84,45,84,76,84,109,84,140,68,100,97,116
    DATA 84,124,112,108,68,84,128,116,84,76,112,92,112,77,112,108,84,119
    DATA 92,114,142,86,151,82,180,66,186,62,186,62,236,90,236,90,68,184
    DATA 68,184,16,154,16,154,52,133,16,154,16,160,16,160,68,190,68,190
    DATA 68,184,68,190,236,96,236,96,236,90

About:
    DATA "Assembly-Language Toolbox demonstration program"
    DATA "(C)1992 Christy Gemmell and Singular Software"
    DATA "Release 5.55  July 1993"

Credits:
    DATA "   The Assembly-Language Toolbox for   "
    DATA "          Microsoft QuickBASIC         "
    DATA "    Professional Edition, Release 5    "
    DATA "                                       "
    DATA " also available for QuickBASIC 4.5 and "
    DATA "          Visual BASIC for DOS         "

    DATA "The Professional Edition contains source code,"
    DATA "object files, stand-alone and Quick libraries"
    DATA "and a complete set of documentation. To order"
    DATA "contact:              James J. Kreyling"
    DATA "                      CPC Consulting Company"
    DATA "                      1217 Crescent Drive,"
    DATA "                      Smithfield  VA 23430"
    DATA "        or through... Club-PC BBS (8-N-1)"
    DATA "Tel (804) 357-9190    BBS (804) 357-0357"

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³      (C) 1993 By Christy Gemmell and Singular Software.                ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
