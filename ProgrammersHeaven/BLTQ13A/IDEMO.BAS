
DECLARE SUB DoHighlight (row%)
DECLARE SUB DisplayRecord (RecNo&, row%)
DECLARE SUB ShowDBFStruc (ask4%, ask$, ret$)
DECLARE SUB ShowFieldNames (StartField%)
DECLARE SUB ShowNewFields (newfield%)
DECLARE SUB ShowMainScreen (infile$)
DECLARE SUB ShowStartCL ()

DECLARE SUB DoGoHome ()
DECLARE SUB DoGoEnd ()
DECLARE SUB DoHorzScroll (dir%)
DECLARE SUB DoHorzSlide (kbkey%)
DECLARE SUB DoHorzSkip (dir%)
DECLARE SUB DoVertScroll (dir%)
DECLARE SUB DoVertSlide (kbkey%)
DECLARE SUB AdjustHorzSlide (FirstField%)
DECLARE SUB AdjustVertSlide (RecNo&)

DECLARE SUB DoInitHots ()
DECLARE FUNCTION DoInit% ()
DECLARE FUNCTION WaitForKey% ()
DECLARE FUNCTION GetRecord% (RecNo&)

DECLARE SUB WinClr (row%, col%, rows%, cols%, char%, fg%, bg%)
DECLARE SUB WinGet (row%, col%, rows%, cols%, ID%)
DECLARE SUB WinPrt (txt$, row%, col%, MaxChars%, FirstChar%, fg%, bg%)
DECLARE SUB WinPut (row%, col%, rows%, cols%, ID%)
DECLARE SUB WinSetMode (page%, row%, col%, cstart%, cend%, vmode%)
DECLARE SUB WinScroll (row%, col%, rows%, cols%, dir%, fg%, bg%)
DECLARE SUB WinShift (row%, col%, rows%, cols%, dir%, fg%, bg%)

DECLARE SUB MouseFunc (Func%, IM AS ANY, OM AS ANY)
DECLARE SUB MouseTurn (onoff%)
DECLARE FUNCTION SelectEvent% ()
DECLARE FUNCTION InKeyPick% (waitfor%)
DECLARE FUNCTION InMousePick% ()
DECLARE SUB InKeyResponse (row%, col%, maxlen%, retstr$)


REM $INCLUDE: 'BULLET.BI'
REM $INCLUDE: 'ZWINDO.BI'

DECLARE SUB INTERRUPTX (intnum%, ireg AS ANY, oreg AS ANY)

DEFINT A-Z

'interactive demo
'31-May-92 chh
'------------------
'instructions for QuickBASIC 4.5
'C>bc idemo /o;
'C>link idemo+zwindo+intrpt2,idemo.exe,nul,bullet;
'C>link /qu bullet.lib+zwindo+intrpt2,idemo.qlb,nul,bqlb45;

'-----------------
'instructions for PDS BASIC 7.1
'C>bc idemo /o/ot;
'C>link /noe/packc/far idemo+zwindo+intrpt2+smallerr+tscnionr,
'       idemo.exe,nul,bullet;
'C>link /qu bullet.lib+zwindo+intrpt2,idemo.qlb,nul,qbxqlb;

'----------------------------------------------------------------------------
'notes: INTRPT2.OBJ and ZWINDO.OBJ are provided as-is and are not a supported
'       part of the BULLET package. INTRPT2.OBJ is a replacement module for
'       the somewhat buggy INTERRUPT(X) code provided in the QB.LIB/QBX.LIB
'       files of QuickBASIC/BASIC 7.1. ZWINDO.OBJ is a cut-down direct-access
'       screen/video manager, included here only so that you can recompile
'       the IDEMO.BAS program.

'       This demo is an abbreviated full-interactive program. There is still
'       a lot that can (and needs to) be done. What you might want to add is
'       select/create indexes, set filters, oh, lots of things. In an effort
'       to keep the IDEMO.EXE included with BULLET package small the guts of
'       the program have not been done.

'       To use the program just C>idemo filename.dbf. You can use the provided
'       .DBF file or any .DBF file. To pan fields if the record is longer than
'       the display screen, use the left/right arrows. A mouse can be used on
'       the scroll bars/arrows, too. Esc exits to DOS. To browse the DBF use
'       the up/down arrows, page up/dn, home/end, or the mouse buttons along
'       the right AND bottom.

'       For more direct source example see the BB_*.BAS QB source files.

'----------
'event data

TYPE ButtonInfoTYPE
x0 AS INTEGER   'col
y0 AS INTEGER   'row
xs AS INTEGER   'cols
ys AS INTEGER   'rows
kv AS INTEGER   'key value
END TYPE

TYPE RegTypeX   'interface structure to INTERRUPTX
ax AS INTEGER
bx AS INTEGER
cx AS INTEGER
dx AS INTEGER
BP AS INTEGER
si AS INTEGER
DI AS INTEGER
flags AS INTEGER
ds AS INTEGER
es AS INTEGER
END TYPE

TYPE MouseTYPE  'interface structure to MOUSEFUNC
ax AS INTEGER
bx AS INTEGER
cx AS INTEGER
dx AS INTEGER
END TYPE

CONST MAXBUTTONS = 7
DIM SHARED ButtonSpots(1 TO MAXBUTTONS) AS ButtonInfoTYPE

DIM SHARED IM AS MouseTYPE      'mouse INT33 ins
DIM SHARED OM AS MouseTYPE      'outs
DIM SHARED xreg AS RegTypeX     'regs for interruptx call
DIM SHARED MouseSaved AS INTEGER'=0 then mouse state not saved
DIM SHARED IsMouse AS INTEGER   '=0 then mouse driver not available

'-----------
'window data

CONST MAXWINSAVES = 2           '0-based, window 0 reserved

DIM SHARED WSP AS WinSavePack
DIM SHARED WFP AS WinFillPack
DIM SHARED WPP AS WinPrintPack
DIM SHARED WCP AS WinCursorPack
DIM SHARED WCPorg AS WinCursorPack

DIM SHARED WinBuff(0 TO (MAXWINSAVES + 1) * 2000) AS INTEGER
DIM SHARED atxt$(1 TO 11)

'-----------
'bullet data

CONST MAXRECLEN = 4000          'limit DBF recs to 4000 bytes (o)

TYPE StrucTYPE                  'type used for DBF struc display
FieldName AS STRING * 11
FieldType AS STRING * 1
FieldLen AS INTEGER
FieldDC AS INTEGER
END TYPE

DIM SHARED DFP AS DOSFilePack
DIM SHARED MP AS MemoryPack
DIM SHARED IP AS InitPack
DIM SHARED EP AS ExitPack
DIM SHARED BP AS BreakPack
DIM SHARED RP AS RemotePack
DIM SHARED CDP AS CreateDataPack
DIM SHARED CKP AS CreateKeyPack
DIM SHARED SDP AS StatDataPack
DIM SHARED SKP AS StatKeyPack
DIM SHARED DP AS DescriptorPack
DIM SHARED OP AS OpenPack
DIM SHARED AP AS AccessPack

DIM SHARED StrucDBF(1 TO 255) AS StrucTYPE
'REDIM SHARED StrucDBF(1 TO 1) AS StrucTYPE 'will be resizing so make dynamic
                                           '--field descriptions for program
                                           
DIM SHARED TheRecord AS STRING * 4000   'any type DBF data record


'------------
'program data

CONST SSROW = 9 - 1                     'scroll screen row start
CONST SSROWS = 10                       'number of rows in scroll screen

TYPE FieldDisplayInfoTYPE
FirstField AS INTEGER                   'start field being displayed
FieldsDisplayed AS INTEGER              'number of fields being displayed
END TYPE

TYPE RecordDisplayInfoTYPE
CurrRecord AS LONG                      'highlighted recno (for ScrollBar loc)
TopRecord AS LONG                       'first scroll screen rec's number
BotRecord AS LONG                       'last scroll screen rec's number
TopKey AS STRING * 64                   'first scroll screen rec's key
BotKey AS STRING * 64                   'last scroll screen rec's key
END TYPE

TYPE PosInfoTYPE
VertSlide AS INTEGER                    'current slide pos (0-7)
HorzSlide AS INTEGER                    'current slide pos (0-74)
TotalRows AS LONG                       'row or records in file
TotalCols AS INTEGER                    'cols or characters in record
ScreenRow AS INTEGER                    'current screen row (1-10)
END TYPE

DIM SHARED FDI AS FieldDisplayInfoTYPE
DIM SHARED RDI AS RecordDisplayInfoTYPE
DIM SHARED PI AS PosInfoTYPE

DIM SHARED TmpStr AS STRING * 256       'any type fixed-len string
DIM SHARED ZSTR AS STRING * 1           'zero-terminator
DIM SHARED LockFlag AS INTEGER          '=0 then do not use locks
DIM SHARED CurrIDX AS INTEGER           'current index in use (0,1-32)

DIM SHARED ISFG AS INTEGER              'info screen colors
DIM SHARED ISBG AS INTEGER
DIM SHARED ISFGB AS INTEGER
DIM SHARED HSFG AS INTEGER              'field name header colors
DIM SHARED HSBG AS INTEGER
DIM SHARED HSFGB AS INTEGER
DIM SHARED SSFG AS INTEGER              'scroll screen colors
DIM SHARED SSBG AS INTEGER
DIM SHARED SSFGB AS INTEGER


ZSTR = CHR$(0)
LockFlag = 0
CurrIDX = 0

ISFG = 7: ISBG = 0: ISFGB = 15          'info screen colors
HSFG = 15: HSBG = 0: HSFGB = 15         'field name header colors
SSFG = 2: SSBG = 0: SSFGB = 10          'scroll screen colors


'-----
'go4it

stat = DoInit

WinSetMode 0, 0, 0, -1, -1, 3  'page,row,col,cstart,cend,vmode
WinClr 0, 0, 25, 80, 32, ISFG, ISBG
WinClr SSROW, 0, SSROWS + 1, 80, 32, SSFG, SSBG

infile$ = COMMAND$
IF LEN(infile$) = 0 THEN
   ShowStartCL
   stat = -1
END IF

IF stat = 0 THEN

   'open DBF file

   TmpStr = infile$ + ZSTR
   OP.Func = OpenDXB
   OP.FilenamePtrOff = VARPTR(TmpStr)
   OP.FilenamePtrSeg = VARSEG(TmpStr)
   OP.ASmode = ReadWrite + DenyNone
   stat = BULLET(OP)

   IF stat = 0 THEN
      handleDBF = OP.Handle

      'check infile

      RP.Func = FileRemoteXB
      RP.Handle = OP.Handle
      stat = BULLET(RP)

      IF stat = 0 THEN

         'get stats/info on DBF

         SDP.Func = StatDXB
         SDP.Handle = handleDBF
         stat = BULLET(SDP)

         IF stat = 0 THEN

            'build the local decriptor info so this program knows what's what

            'REDIM StrucDBF(1 TO SDP.fields) AS StrucTYPE

            DP.Func = GetDescriptorXB
            DP.Handle = SDP.Handle

            FOR i = 1 TO SDP.fields
               DP.FieldNumber = i
               stat = BULLET(DP)
               IF stat = 0 THEN
                  StrucDBF(i).FieldName = DP.FD.FieldName
                  StrucDBF(i).FieldType = DP.FD.FieldType
                  StrucDBF(i).FieldLen = ASC(DP.FD.FieldLength)
                  StrucDBF(i).FieldDC = ASC(DP.FD.FieldDC)
               ELSE
                  EXIT FOR
               END IF
            NEXT

            ShowMainScreen infile$
            DoGoHome

         END IF 'stat DBF
      END IF 'open DBF
   END IF'remote drive

   'do main loop

   IF stat = 0 THEN

      MouseTurn 1

      'event loop

      DO

         kbkey = InKeyPick(0)
         IF IsMouse THEN
            mbkey = InMousePick
            IF mbkey THEN kbkey = mbkey
         END IF

         SELECT CASE kbkey
         CASE 0
         CASE 9       'TAB->
         CASE 1015    '<-TAB
         CASE 1059    'F1
         CASE 1060    'F2
         CASE 1061    'F3
            ask$ = "Enter key expression:"
            ShowDBFStruc 136, ask$, ret$
         CASE 1062    'F4
         CASE 1063    'F5
         CASE 1064    'F6
            ShowDBFStruc 0, ask$, ret$
         CASE 1065    'F7
         CASE 1066    'F8
         CASE 1067    'F9
         CASE 1068    'F10
         CASE 55, 1071          'home
            DoGoHome
         CASE 49, 1079          'end
            DoGoEnd
         CASE 56, 1072, 2090    'up arrow
            DoVertScroll -1
         CASE 50, 1080, 2091    'down arrow
            DoVertScroll 1
         CASE 57, 1073          'page up
            FOR i = 1 TO SSROWS - 1
               DoVertScroll -1
            NEXT
         CASE 51, 1081          'page down
            FOR i = 1 TO SSROWS - 1
               DoVertScroll 1
            NEXT
         CASE 2000 TO 2089      'up/down slider (mouse only)
            DoVertSlide kbkey
         CASE 2100 TO 2174      'left/right slider (mouse only)
            DoHorzSlide kbkey
         CASE 52, 1075, 2190    'left arrow
            DoHorzSkip -1
         CASE 54, 1077, 2191    'right arrow
            DoHorzSkip 1
         CASE 1115              'ctrl left arrow
            DoHorzScroll -1
         CASE 1116              'ctrl right arrow
            DoHorzScroll 1

         CASE 13      'Enter
         CASE 27      'Esc
            EXIT DO
         CASE ELSE
         END SELECT
      LOOP

   END IF 'main loop

END IF 'initXB

EP.Func = ExitXB
nix = BULLET(EP)

MouseTurn 0
WinClr 20, 0, 5, 80, 32, ISFG, ISBG
IF stat THEN
   txt$ = "IDEMO stat:" + STR$(stat) + ".  See documentation for explanation."
ELSE
   txt$ = "IDEMO stat: ok"
END IF
WinPrt txt$, 20, 0, LEN(txt$), 1, ISFG, ISBG
WCPorg.Func = CursorWIN
WCPorg.Mode = 1                 'reset startup video state
WCPorg.x0 = 0                   'as it was except locate to 24,0
WCPorg.y0 = 23
WCPorg.vmode = -1               'keep screen from clearing
stat = ZWINDO(WCPorg)
END

SUB AdjustHorzSlide (FirstField)

'set vertical slide to reflect field postion within record

WinPrt "Ä", SSROW + SSROWS + 1, 1 + PI.HorzSlide, 1, 1, ISFG, ISBG

rez = (SDP.fields * 100) \ 75

SELECT CASE FirstField
CASE 1
   PI.HorzSlide = 0
CASE SDP.fields
   PI.HorzSlide = 74
CASE ELSE
   PI.HorzSlide = (FirstField * 100) \ rez
   IF PI.HorzSlide < 0 THEN
      PI.HorzSlide = 0
   ELSEIF PI.HorzSlide > 74 THEN
      PI.HorzSlide = 74
   END IF
END SELECT
WinPrt "þ", SSROW + SSROWS + 1, 1 + PI.HorzSlide, 1, 1, ISFG, ISBG

END SUB

SUB AdjustVertSlide (RecNo&)

'set vertical slide to reflect postion within file
'only valid in non-index read

WinPrt "³", SSROW + 1 + PI.VertSlide, 79, 1, 1, ISFG, ISBG

rez& = SDP.Recs \ 8
SELECT CASE RecNo&
CASE 1&
   PI.VertSlide = 0
CASE SDP.Recs
   PI.VertSlide = 7
CASE ELSE
   PI.VertSlide = RecNo& \ rez&
   IF PI.VertSlide < 0 THEN
      PI.VertSlide = 0
   ELSEIF PI.VertSlide > 7 THEN
      PI.VertSlide = 7
   END IF
END SELECT
WinPrt "þ", SSROW + 1 + PI.VertSlide, 79, 1, 1, ISFG, ISBG

END SUB

SUB DisplayRecord (RecNo&, row)

'display record at row

FirstChar = 1
offset = 1

'find byte offset of the first field displayed on screen
'offset starts at +1 to account for delete tag

i = 1
DO WHILE FDI.FirstField <> i
   offset = offset + StrucDBF(i).FieldLen
   i = i + 1
LOOP

'put the field data up: recno, delete tag, field data

fg = ISFG
bg = ISBG
col = 0
txt$ = RIGHT$("       " + LTRIM$(STR$(RecNo&)), 7)
WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg

fg = SSFG
bg = SSBG
IF ASC(TheRecord) = 42 THEN
   col = 7
   txt$ = "*"
   WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
END IF
col = 8

FOR i = FDI.FirstField TO FDI.FirstField + FDI.FieldsDisplayed - 1
   FieldLen = StrucDBF(i).FieldLen

   'pad field with spaces if field name > field length

   xchars = 0
   txt$ = LEFT$(StrucDBF(i).FieldName, INSTR(StrucDBF(i).FieldName, ZSTR) - 1)
   tl = LEN(txt$)
   IF FieldLen < tl THEN xchars = tl - FieldLen

   txt$ = MID$(TheRecord, offset + 1, FieldLen) + SPACE$(xchars)
   offset = offset + FieldLen
   SELECT CASE StrucDBF(i).FieldType
   CASE "B"     'special BULLET binary
                'of concern is the field len to be displayed since the
                'descriptor field length contains the size of the binary
                'field, 2 or 4 --- here we just use the fieldname size, 10
      txt2$ = SPACE$(10)
      IF FieldLen = 4 THEN
         RSET txt2$ = STR$(CVL(LEFT$(txt$, FieldLen)))
      ELSEIF FieldLen = 2 THEN
         RSET txt2$ = STR$(CVL(LEFT$(txt$, FieldLen)))
      ELSE
         RSET txt2$ = "*?*"
      END IF
      WinPrt txt2$, row, col, LEN(txt$), FirstChar, fg, bg
   CASE "C"     'character
      WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
   CASE "D"     'date
      txt$ = MID$(txt$, 5, 2) + "/" + MID$(txt$, 7, 2) + "/" + MID$(txt$, 3, 2)
      WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
   CASE "L"     'logical
      SELECT CASE UCASE$(LEFT$(txt$, 1))
      CASE " "
      CASE "T", "Y"
         txt$ = "T"
      CASE "F", "N"
         txt$ = "F"
      CASE ELSE
         txt$ = "?"
      END SELECT
      WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
   CASE "M"     'memo
      txt$ = "memo"
      WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
   CASE "N"     'numeric
      RSET txt$ = txt$
      WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
   CASE ELSE
   END SELECT
   col = col + FieldLen + xchars + 1
NEXT

END SUB

SUB DoGoEnd

'reset for end position

ShowFieldNames 1
WinClr SSROW + 1, 0, SSROWS, 79, 32, SSFG, SSBG

IF CurrIDX = 0 THEN
   startrec& = SDP.Recs - SSROWS + 1
   IF startrec& < 1 THEN startrec& = 1
   row = 0
   DoHorzSlide 2174
   FOR i& = startrec& TO startrec& + SSROWS - 1
      stat = GetRecord(i&)
      IF stat THEN EXIT FOR
      row = row + 1
      DisplayRecord i&, SSROW + row
   NEXT
   IF stat = 0 THEN
      RDI.CurrRecord = i& - 1
      RDI.TopRecord = startrec&
      RDI.BotRecord = RDI.CurrRecord
      PI.ScreenRow = 0
      DoHighlight row
      PI.ScreenRow = row
      AdjustVertSlide RDI.BotRecord
   END IF
ELSE
   'key order
END IF

END SUB

SUB DoGoHome

'reset for home position

ShowFieldNames 1
WinClr SSROW + 1, 0, SSROWS, 79, 32, SSFG, SSBG

IF CurrIDX = 0 THEN
   row = 0
   FOR i& = 1 TO SSROWS
      stat = GetRecord(i&)
      IF stat THEN EXIT FOR
      row = row + 1
      DisplayRecord i&, SSROW + row
   NEXT
   RDI.CurrRecord = 1&
   RDI.TopRecord = 1&
   RDI.BotRecord = i& - 1
   PI.ScreenRow = 0
   DoHighlight 1
   PI.ScreenRow = 1
   PI.TotalRows = SDP.Recs
   PI.TotalCols = SDP.RecLen
   AdjustHorzSlide 1
   AdjustVertSlide 1&
ELSE
   'key order
END IF

END SUB

SUB DoHighlight (row)

'highlight row (row relative scroll window, 1-10)
'first norm previous highlighted row, then do specified row and update PI

col = 7
rows = 1
cols = 72
char = 0
IF PI.ScreenRow THEN
   WinClr SSROW + PI.ScreenRow, col, rows, cols, char, SSFG, SSBG
   PI.ScreenRow = row
   WinClr SSROW + PI.ScreenRow, col, rows, cols, char, SSFGB, SSBG
ELSE
   PI.ScreenRow = row
   WinClr SSROW + PI.ScreenRow, col, rows, cols, char, SSFGB, SSBG
END IF
   
END SUB

SUB DoHorzScroll (dir)

'shift over a character at a time
'--currently does not update fields longer than scoll screen width
'if shift encapsulates entire field, new field brought to start
'this routine could use some cleanup
'(also, this routine called when Ctrl-arrow is used, not when plain arrow
'is, which makes it somewhat reverse the dBASE browse mode)

kbkey = PI.HorzSlide + 2100 + dir
IF kbkey >= 2100 AND kbkey <= 2174 THEN
   WinShift SSROW, 7, SSROWS + 1, 72, dir, SSFG, SSBG
   DoHorzSlide kbkey
END IF

END SUB

SUB DoHorzSkip (dir)

'update slider by whole field jumps
'reflect new field start

newfield = FDI.FirstField + dir
ShowNewFields newfield
AdjustHorzSlide FDI.FirstField

END SUB

SUB DoHorzSlide (kbkey)

'update slider
'reflect new field start

WinPrt "Ä", SSROW + SSROWS + 1, 1 + PI.HorzSlide, 1, 1, ISFG, ISBG
PI.HorzSlide = kbkey - 2100
WinPrt "þ", SSROW + SSROWS + 1, 1 + PI.HorzSlide, 1, 1, ISFG, ISBG

clf = FDI.FirstField + FDI.FieldsDisplayed - 1  'clf=current last field

IF clf <= SDP.fields THEN
   
   rez = (SDP.fields * 100) \ 75
   newfield = ((rez * PI.HorzSlide) \ 100) + 1

   IF newfield <> FDI.FirstField THEN ShowNewFields newfield

END IF

END SUB

FUNCTION DoInit

'free some memory for the OS, initialize BULLET,
'register ExitXB with _atexit, and get video state

exitstat = 0

MP.Func = MemoryXB
stat = BULLET(MP)
IF MP.Memory < 140000 THEN
    QBheap& = SETMEM(-150000)   'hog wild, 64K would do okay
    MP.Func = MemoryXB
    stat = BULLET(MP)
    IF MP.Memory < 140000 THEN exitstat = 8 'follow through with Init
END IF

IF stat = 0 THEN
   IP.Func = InitXB
   IF exitstat = 0 THEN
      IP.JFTmode = 1            'we may need lots of files open
   ELSE
      IP.JFTmode = 0            'but only if the memory is available
   END IF
   stat = BULLET(IP)
   IF stat = 0 THEN
      EP.Func = AtExitXB
      stat = BULLET(EP)         'doubtful that this would fail

      BP.Func = BreakXB
      BP.Mode = 0
      stat = BULLET(BP)

   END IF
END IF

IF stat = 0 THEN
   WCP.Func = CursorWIN
   WCP.Mode = 0                 'get startup video state
   stat = ZWINDO(WCP)           'returns 233 if InitXB not active
   WCPorg.page = WCP.page
   WCPorg.x0 = WCP.x0
   WCPorg.y0 = WCP.y0
   WCPorg.cstart = WCP.cstart
   WCPorg.cend = WCP.cend
   WCPorg.vmode = WCP.vmode

   'init mouse and hot spots

   MouseFunc 0, IM, OM
   IsMouse = OM.ax
   IF IsMouse THEN DoInitHots

   'init globals

   PI.VertSlide = 0
   PI.HorzSlide = 0

END IF
IF exitstat THEN stat = exitstat
DoInit = stat

END FUNCTION

SUB DoInitHots

'set the mouse hot spots

ButtonSpots(1).x0 = 79          'up/down slider
ButtonSpots(1).y0 = 9
ButtonSpots(1).xs = 1
ButtonSpots(1).ys = 8
ButtonSpots(1).kv = 2000        '2000=top, +1 for each lower y-pos

ButtonSpots(2).x0 = 1           'left/right slider
ButtonSpots(2).y0 = 19
ButtonSpots(2).xs = 75
ButtonSpots(2).ys = 1
ButtonSpots(2).kv = 2100        '2100=left, +1 for each higher x-pos

ButtonSpots(3).x0 = 79          'up arrow
ButtonSpots(3).y0 = 17
ButtonSpots(3).xs = 1
ButtonSpots(3).ys = 1
ButtonSpots(3).kv = 2090

ButtonSpots(4).x0 = 79          'down arrow
ButtonSpots(4).y0 = 18
ButtonSpots(4).xs = 1
ButtonSpots(4).ys = 1
ButtonSpots(4).kv = 2091

ButtonSpots(5).x0 = 77          'left arrow
ButtonSpots(5).y0 = 19
ButtonSpots(5).xs = 1
ButtonSpots(5).ys = 1
ButtonSpots(5).kv = 2190

ButtonSpots(6).x0 = 79          'right arrow
ButtonSpots(6).y0 = 19
ButtonSpots(6).xs = 1
ButtonSpots(6).ys = 1
ButtonSpots(6).kv = 2191

'put the Fkey hots here too (update MAXBUTTONS from 7)

ButtonSpots(MAXBUTTONS).x0 = 70 'Esc
ButtonSpots(MAXBUTTONS).y0 = 22
ButtonSpots(MAXBUTTONS).xs = 3
ButtonSpots(MAXBUTTONS).ys = 1
ButtonSpots(MAXBUTTONS).kv = 27

END SUB

SUB DoVertScroll (dir)

'move the highlight bar in direction,
' dir=-1 moves toward start of file,dir=1 moves toward end of file
'if at bottom of screen:
' norm highlight, scroll screen up, get next record and display, highlight
'if at top:
' norm highlight, scroll screen down, get prev record and display, highlight

col = 7         'used to re/set highlight
rows = 1
cols = 72
char = 0

SELECT CASE PI.ScreenRow
CASE SSROWS
   'at bottom
   IF dir < 0 THEN
      DoHighlight PI.ScreenRow + dir
      IF CurrIDX = 0 THEN RDI.CurrRecord = RDI.CurrRecord + dir
   ELSE
      IF CurrIDX = 0 THEN
         stat = GetRecord(RDI.BotRecord + 1)
         IF stat = 0 THEN
            RDI.CurrRecord = RDI.CurrRecord + 1
            RDI.TopRecord = RDI.TopRecord + 1
            RDI.BotRecord = RDI.BotRecord + 1
            WinClr SSROW + PI.ScreenRow, col, rows, cols, char, SSFG, SSBG
            WinScroll SSROW + 1, 0, SSROWS, 78, 1, SSFG, SSBG
            DisplayRecord RDI.BotRecord, SSROW + SSROWS
            DoHighlight PI.ScreenRow
            AdjustVertSlide RDI.CurrRecord
         END IF
      ELSE
         'get by current key
      END IF
   END IF

CASE 1
   'at top
   IF dir > 0 THEN
      DoHighlight PI.ScreenRow + dir
      IF CurrIDX = 0 THEN
         RDI.CurrRecord = RDI.CurrRecord + dir
      ELSE
         'get from ??
      END IF
   ELSE
      IF CurrIDX = 0 THEN
         stat = GetRecord(RDI.TopRecord - 1)
         IF stat = 0 THEN
            RDI.CurrRecord = RDI.CurrRecord - 1
            RDI.TopRecord = RDI.TopRecord - 1
            RDI.BotRecord = RDI.BotRecord - 1
            WinClr SSROW + PI.ScreenRow, col, rows, cols, char, SSFG, SSBG
            WinScroll SSROW + 1, 0, SSROWS, 78, -1, SSFG, SSBG
            DisplayRecord RDI.TopRecord, SSROW + 1
            DoHighlight PI.ScreenRow
            AdjustVertSlide RDI.CurrRecord
         END IF
      ELSE
         'get by current key
      END IF
   END IF

CASE ELSE
   DoHighlight PI.ScreenRow + dir
END SELECT

END SUB

SUB DoVertSlide (kbkey)

'update slider
'if in non-index then reflect current record number to slider position
'if index then just reflect top of or bottom of (GetFirst/Last)

WinPrt "³", SSROW + 1 + PI.VertSlide, 79, 1, 1, ISFG, ISBG
PI.VertSlide = kbkey - 2000
WinPrt "þ", SSROW + 1 + PI.VertSlide, 79, 1, 1, ISFG, ISBG

IF CurrIDX = 0 THEN

   'handle non-indexed access

   rez& = SDP.Recs \ 8
   newrec& = rez& * PI.VertSlide
   IF newrec& <= 0 OR PI.VertSlide = 0 THEN
      newrec& = 1
   ELSEIF newrec& > SDP.Recs OR PI.VertSlide = 7 THEN
      newrec& = SDP.Recs - SSROWS + 1
   END IF

   IF (newrec& > RDI.CurrRecord - rez& + 1) AND (newrec& < RDI.CurrRecord + rez& - 1) THEN
      'already within position
   ELSE
      WinClr SSROW + 1, 0, SSROWS, 79, 32, SSFG, SSBG
      row = 0
      FOR i& = newrec& TO newrec& + SSROWS - 1
         stat = GetRecord(i&)
         IF stat THEN EXIT FOR
         row = row + 1
         DisplayRecord i&, SSROW + row
      NEXT
      RDI.CurrRecord = newrec&
      RDI.TopRecord = newrec&
      RDI.BotRecord = i& - 1        'i from for/next loop of DisplayRecord
      RDI.TopKey = ZSTR
      RDI.BotKey = ZSTR
      DoHighlight 1
   END IF
ELSE

   'handle keyed access

END IF

END SUB

FUNCTION GetRecord (RecNo&)

'get the specified record to TheRecord
'used for non-keyed access

AP.Func = GetRecordXB
AP.Handle = SDP.Handle
AP.RecNo = RecNo&
AP.RecPtrOff = VARPTR(TheRecord)
AP.RecPtrSeg = VARSEG(TheRecord)
GetRecord = BULLET(AP)

END FUNCTION

FUNCTION InKeyPick (waitfor)

'get a key, if waitfor then wait until a key

DO
   kb$ = INKEY$
   kblen = LEN(kb$)
   SELECT CASE kblen
   CASE 0
     kbkey = 0
   CASE 1
      kbkey = ASC(kb$)
   CASE 2
      kbkey = 1000 + ASC(RIGHT$(kb$, 1))
   CASE ELSE
   END SELECT
LOOP UNTIL kbkey OR (waitfor = 0)
InKeyPick = kbkey

END FUNCTION

SUB InKeyResponse (row, col, maxlen, ret$)

'get user input through STDIN
'bytes adjusted +2 to account for CR/LF
'note: DOS limits input through STDIN from the keyboard to 127+2 characters
'      the +2 is for the CR/LF
'ret$ is stripped of the CR/LF

CONST STDIN = 0

WCP.Func = CursorWIN
WCP.Mode = 1
WCP.x0 = col
WCP.y0 = row
WCP.vmode = -1
stat = ZWINDO(WCP)

DFP.Func = ReadFileDOS
DFP.Handle = STDIN
DFP.Bytes = maxlen + 2
IF DFP.Bytes > LEN(TmpStr) THEN DFP.Bytes = LEN(TmpStr)

DFP.BufferPtrOff = VARPTR(TmpStr)
DFP.BufferPtrSeg = VARSEG(TmpStr)
stat = BULLET(DFP)
IF stat = 0 THEN
   ret$ = LEFT$(TmpStr, DFP.Bytes)
   t = INSTR(ret$, CHR$(13))
   IF t > 1 THEN ret$ = LEFT$(ret$, t - 1) ELSE ret$ = ""
ELSE
   ret$ = ""
END IF

WCP.x0 = 0
WCP.y0 = 25
WCP.vmode = -1
stat = ZWINDO(WCP)

END SUB

FUNCTION InMousePick

'if mouse left button down and cursor is on a event button then
'set gActiveButton and return 13 else just return 0

'bx=button status
'cx=horz cursor coor
'dx=vert cursor coor

MouseFunc 3, IM, OM

'txt$ = STR$(OM.cx \ 8) + STR$(OM.dx \ 8) + "   "
'WinPrt txt$, 24, 0, LEN(txt$), 1, ISFG, ISBG

match = 0
IF OM.bx = 1 THEN
   mx = OM.cx \ 8
   my = OM.dx \ 8

   FOR i = 1 TO MAXBUTTONS
      x0 = ButtonSpots(i).x0
      y0 = ButtonSpots(i).y0
      x1 = x0 + ButtonSpots(i).xs - 1
      y1 = y0 + ButtonSpots(i).ys - 1
      
      'check for match in horz and vert positions
      'return button's key value

      IF mx >= x0 AND mx <= x1 THEN
         IF my >= y0 AND my <= y1 THEN
            match = ButtonSpots(i).kv
            SELECT CASE i
            CASE 1 'up/down slider
               match = match + (my - y0)
            CASE 2 'left/right slider
               match = match + (mx - x0)
            CASE ELSE
            END SELECT

            'txt$ = STR$(match)
            'WinPrt txt$, 24, 10, LEN(txt$), 1, ISFG, ISBG

            EXIT FOR
         END IF
      END IF
   NEXT

END IF
InMousePick = match

END FUNCTION

SUB MouseFunc (Func, IM AS MouseTYPE, OM AS MouseTYPE)

'mouse function routine

IF (IsMouse = 0 AND Func > 0) AND (Func <> 21) THEN EXIT SUB

xreg.es = -1    'IM.ax used to pass ES segment register if needed
SELECT CASE Func
CASE 0   'MOUSE RESET AND STATUS
         'set: nothing
         'rtn: ax=status (0=not found/not reset)
         '     bx=buttons
   DEF SEG = 0
   ms& = 256& * PEEK(207) + PEEK(206)
   IF ms& > 32767 THEN ms& = ms& - 65536
   MouseSeg = ms&
   MouseOff = PEEK(204) + 256 * PEEK(205)
   DEF SEG = MouseSeg
   MouseExists = (MouseSeg <> 0 OR MouseOff <> 0) AND PEEK(MouseOff) <> &HCF
   DEF SEG
   IF MouseExists THEN
      xreg.ax = 0
   ELSE OM.ax = 0
      EXIT SUB
   END IF
CASE 1   'SHOW CURSOR
         'set: nothing
         'rtn: nothing
   xreg.ax = 1
CASE 2   'HIDE CURSOR
         'set: nothing
         'rtn: nothing
   xreg.ax = 2
CASE 3   'GET BUTTON STATUS AND MOUSE POS
         'set: nothing
         'rtn: bx=button status
         '     cx=horz cursor coor
         '     dx=vert cursor coor
   xreg.ax = 3
CASE 4   'SET MOUSE CURSOR POS
         'set: cx=new horz cursor pos
         '     dx=new vert cursor pos
         'rtn: nothing
   xreg.ax = 4
   xreg.cx = IM.cx
   xreg.dx = IM.dx
CASE 5   'GET BUTTON PRESS INFO
         'set: bx=button
         'rtn: ax=button status
         '     bx=number of button presses
         '     cx=horz cursor coor at last press
         '     dx=vert cursor coor at last press
   xreg.ax = 5
   xreg.bx = IM.bx
CASE 6   'GET BUTTON RELEASE INFO
         'set: bx=button
         'rtn: ax=button status
         '     bx=number of button releases
         '     cx=horz cursor coor at last release
         '     dx=vert cursor coor at last release
   xreg.ax = 6
   xreg.bx = IM.bx
CASE 7   'SET MIN AND MAX HORZ CURSOR POS
         'set: cx=min pos
         '     dx=max pos
         'rtn: nothing
   xreg.ax = 7
   xreg.cx = IM.cx
   xreg.dx = IM.dx
CASE 8   'SET MIN AND MAX VERT CURSOR POS
         'set: cx=min pos
         '     dx=max pos
         'rtn: nothing
   xreg.ax = 8
   xreg.cx = IM.cx
   xreg.dx = IM.dx
CASE 9   'SET GRAPHICS CURSOR BLOCK
         'set: ax=segment of cursor mask (NEVER DEFAULT)
         '     bx=horz cursor hot spot
         '     cx=vert cursor hot spot
         '     dx=pointer to screen
         'rtn: nothing
   xreg.ax = 9
   xreg.bx = IM.bx
   xreg.cx = IM.cx
   xreg.dx = IM.dx
   xreg.es = IM.ax
CASE 10  'SET TEXT CURSOR
         'set: bx=cursor select
         '     cx=screen mask value or scan line start
         '     dx=cursor mask value or scan line start
         'rtn: nothing
   xreg.ax = 10
   xreg.bx = IM.bx
   xreg.cx = IM.cx
   xreg.dx = IM.dx
CASE 11  'READ MOUSE MOTION COUNTERS
         'set: nothing
         'rtn: cx=horz mickey count
         '     dx=vert mickey count
   xreg.ax = 11
CASE 12  'SET INTERRUPT SUBROUTINE CALL MASK AND ADDRESS
         'set: ax=segment of subroutine (NEVER DEFAULT)
         '     cx=call mask.........bit 0-cursor pos changed
         '     dx=offset of subroutine '1-left button pressed
         'rtn: nothing                 '2-left button released
   xreg.ax = 12                        '3-right button pressed
   xreg.cx = IM.cx                     '4-right button released
   xreg.dx = IM.dx                     '5-15 not used
   xreg.es = IM.ax
CASE 13  'LIGHT PEN EMULATION MODE ON
         'set: nothing
         'rtn: nothing
   xreg.ax = 13
CASE 14  'LIGHT PEN EMULATION MODE OFF
         'set: nothing
         'rtn: nothing
   xreg.ax = 14
CASE 15  'SET MICKEY/PIXEL RATIO
         'set: cx=horz mickey to pixel ratio
         '     dx=vert mickey to pixel ratio
         'rtn: nothing
   xreg.ax = 15
   xreg.cx = IM.cx
   xreg.dx = IM.dx
CASE 16  'CONDITIONAL OFF
         'set: ax=left x (slightly different than regular calling registers)
         '     bx=upper y
         '     cx=right x
         '     dx=lower y
         'rtn: nothing
   xreg.ax = 16
   xreg.cx = IM.ax
   xreg.dx = IM.bx
   xreg.si = IM.cx
   xreg.DI = IM.dx
CASE 17, 18
CASE 19  'SET DOUBLE-SPEED THRESHOLD
         'set: dx=threshold speed in mickeys/seconds
         'rtn: nothing
   xreg.ax = 19
   xreg.dx = IM.dx
CASE 20  'SWAP INTERRUPT ROUTINES
         'set: ax=segment of subroutine (NEVER DEFAULT)
         '     cx=call mask (as in func 12 above)
         '     dx=offset of subroutine        ***********************
         'rtn: bx=segment of old subroutine   *Rtn values valid only*
         '     cx=call mask of old subroutine *if previous interrupt*
         '     dx=offset of old subroutine    *was created          *
   xreg.ax = 20                              '***********************
   xreg.cx = IM.cx
   xreg.dx = IM.dx
   xreg.es = IM.ax
   INTERRUPTX &H33, xreg, xreg
   OM.ax = 0
   OM.bx = xreg.es
   OM.cx = xreg.cx
   OM.dx = xreg.dx
   EXIT SUB
CASE 21  'GET MOUSE DRIVER STATE STORAGE REQUIREMENTS
         'set: nothing
         'rtn: bx=buffer size in bytes
   IF MouseExists THEN xreg.ax = 21 ELSE OM.bx = 0: EXIT SUB
CASE 22  'SAVE MOUSE DRIVER STATE
         'set: ax=segment of buffer
         '     dx=offset of buffer
         'rtn: nothing
   xreg.ax = 22
   xreg.dx = IM.dx
   xreg.es = IM.ax
CASE 23  'RESTORE MOUSE DRIVER STATE
         'set: ax=segment of buffer
         '     dx=offset of buffer
         'rtn: nothing
   xreg.ax = 23
   xreg.dx = IM.dx
   xreg.es = IM.ax
CASE 24  'SET ALTERNATE SUBROUTINE CALL MASK AND ADDRESS
         'set: ax=segment of user subroutine
         '     cx=call mask.........bit 0-cursor pos changed
         '     dx=offset of subroutine '1-left button pressed
         'rtn: ax=error status (-1)    '2-left button released
   xreg.ax = 24                        '3-right button pressed
   xreg.cx = IM.cx                     '4-right button released
   xreg.dx = IM.dx                     '5-shift key down w/button
   xreg.es = IM.ax                     '6-ctrl key down w/button
                                       '7-alt key down w/button
                                       '8-15 not used
CASE 25  'GET USER ALTERNATE INTERRUPT ADDRESS
         'set: cx=user interrupt call mask
         'rtn: ax=error status (-1)
         '     bx=segment of user subroutine
         '     cx=call mask of user interrupt
         '     dx=offset of subroutine
   xreg.ax = 25
   xreg.cx = IM.cx
CASE 26  'SET MOUSE SENSITIVITY
         'set: bx=horz mickey sensitivity (0 to 100)  these all
         '     cx=vert mickey sensitivity (0 to 100)   have default
         '     dx=threshold for double speed (0 to 100) values=50
         'rtn: nothing
   xreg.ax = 26
   xreg.bx = IM.bx
   xreg.cx = IM.cx
   xreg.dx = IM.dx
CASE 27  'GET MOUSE SENSITIVITY
         'set: nothing
         'rtn: bx=horz mickey sensitivity (0 to 100)
         '     cx=vert mickey sensitivity (0 to 100)
         '     dx=threshold for double speed (0 to 100)
   xreg.ax = 27
CASE 28  'SET MOUSE INTERRUPT RATE (InPort mouse ONLY)
         'set: bx=rate number (0 (0/sec) to 4 (200/sec))
         'rtn: nothing
   xreg.ax = 28
   xreg.bx = IM.bx
CASE 29  'SET CRT PAGE NUMBER
         'set: bx=CRT page for mouse cursor display
         'rtn: nothing
   xreg.ax = 29
   xreg.bx = IM.bx
CASE 30  'GET CRT PAGE NUMBER
         'set: nothing
         'rtn: bx=CRT page for current mouse cursor display
   xreg.ax = 30
CASE 31  'DISABLE MOUSE DRIVER
         'set: nothing
         'rtn: ax=error status (-1)
         '     bx=segment of old int 33h
         '     dx=offset of old int 33h
   xreg.ax = 31
   INTERRUPTX &H33, xreg, xreg
   OM.ax = xreg.ax
   OM.bx = xreg.es
   OM.cx = 0
   OM.dx = xreg.bx
   EXIT SUB
CASE 32  'ENABLE MOUSE DRIVER
         'set: nothing
         'rtn: nothing
   xreg.ax = 32
CASE 33  'SOFTWARE RESET
         'set: nothing
         'rtn: ax=-1 (or 33 if mouse drive not installed)
         '     bx=2 (if ax=-1. Must=2 for a valid reset)
   xreg.ax = 33
CASE 34  'SET LANGUAGE FOR MESSAGES (International MOUSE.xxx ONLY)
         'set: bx=language number
         'rtn: nothing
   xreg.ax = 34
   xreg.bx = IM.bx
CASE 35  'GET LANGUAGE NUMBER
         'set: nothing
         'rtn: bx=language number
   xreg.ax = 35
CASE 36  'GET DRIVER VERSION,MOUSE TYPE,AND IRQ NUMBER
         'set: nothing
         'rtn: bx=mouse driver version number
         '        bh=major
         '        bl=minor
         '     cx=mouse type and IRQ number
         '        ch=mouse type (1=bus,2=serial,3=InPort,4=PS/2,5=HP)
         '        cl=IRQ number (0=PS/2, 2-5 or 7=mouse IRQ)
   xreg.ax = 36
CASE ELSE
   OM.ax = 0
   OM.bx = 0
   OM.cx = 0
   OM.dx = 0
   EXIT SUB
END SELECT

INTERRUPTX &H33, xreg, xreg
OM.ax = xreg.ax
OM.bx = xreg.bx
OM.cx = xreg.cx
OM.dx = xreg.dx

END SUB

SUB MouseTurn (onoff)

'turn the mouse cursor on/off

IF onoff THEN
   MouseFunc 1, IM, OM  'show
ELSE
   MouseFunc 2, IM, OM  'hide
END IF

END SUB

SUB ShowDBFStruc (ask4, ask$, ret$)

'display .DBF structure for first 60 fields, any others are not shown
'uses a new screen
'if ask4 then prompts ask$ for input to ret$

MaxFldRows = 20
row = 0
col = 0
FirstChar = 1
fg = ISFG
bg = ISBG

WinGet 0, 0, 25, 80, 0
WinClr 0, 0, 25, 80, 32, fg, bg

txt$ = " #  FieldName  T  Len  DC"
WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
row = row + 1
txt$ = "ÄÄ  ÄÄÄÄÄÄÄÄÄ  Ä  ÄÄÄ  ÄÄ"
WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
row = row + 1

FOR i = 1 TO SDP.fields
   IF i <= MaxFldRows THEN
      txt$ = RIGHT$(" " + STR$(i), 2)
      WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
      txt$ = StrucDBF(i).FieldName
      WinPrt txt$, row, col + 4, LEN(txt$), FirstChar, fg, bg
      txt$ = StrucDBF(i).FieldType
      WinPrt txt$, row, col + 15, LEN(txt$), FirstChar, fg, bg
      txt$ = RIGHT$("  " + STR$(StrucDBF(i).FieldLen), 3)
      WinPrt txt$, row, col + 18, LEN(txt$), FirstChar, fg, bg
      txt$ = RIGHT$(" " + STR$(StrucDBF(i).FieldDC), 2)
      WinPrt txt$, row, col + 23, LEN(txt$), FirstChar, fg, bg
      row = row + 1
   ELSEIF i <= MaxFldRows * 2 THEN
      IF i = MaxFldRows + 1 THEN
         row = 0
         col = 28
         txt$ = " #  FieldName  T  Len  DC"
         WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
         row = row + 1
         txt$ = "ÄÄ  ÄÄÄÄÄÄÄÄÄ  Ä  ÄÄÄ  ÄÄ"
         WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
         row = row + 1
      END IF
      txt$ = RIGHT$(" " + STR$(i), 2)
      WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
      txt$ = StrucDBF(i).FieldName
      WinPrt txt$, row, col + 4, LEN(txt$), FirstChar, fg, bg
      txt$ = StrucDBF(i).FieldType
      WinPrt txt$, row, col + 15, LEN(txt$), FirstChar, fg, bg
      txt$ = RIGHT$("  " + STR$(StrucDBF(i).FieldLen), 3)
      WinPrt txt$, row, col + 18, LEN(txt$), FirstChar, fg, bg
      txt$ = RIGHT$(" " + STR$(StrucDBF(i).FieldDC), 2)
      WinPrt txt$, row, col + 23, LEN(txt$), FirstChar, fg, bg
      row = row + 1
   ELSEIF i <= MaxFldRows * 3 THEN
      IF i = (MaxFldRows * 2) + 1 THEN
         row = 0
         col = 55
         txt$ = " #  FieldName  T  Len  DC"
         WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
         row = row + 1
         txt$ = "ÄÄ  ÄÄÄÄÄÄÄÄÄ  Ä  ÄÄÄ  ÄÄ"
         WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
         row = row + 1
      END IF
      txt$ = RIGHT$(" " + STR$(i), 2)
      WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
      txt$ = StrucDBF(i).FieldName
      WinPrt txt$, row, col + 4, LEN(txt$), FirstChar, fg, bg
      txt$ = StrucDBF(i).FieldType
      WinPrt txt$, row, col + 15, LEN(txt$), FirstChar, fg, bg
      txt$ = RIGHT$("  " + STR$(StrucDBF(i).FieldLen), 3)
      WinPrt txt$, row, col + 18, LEN(txt$), FirstChar, fg, bg
      txt$ = RIGHT$(" " + STR$(StrucDBF(i).FieldDC), 2)
      WinPrt txt$, row, col + 23, LEN(txt$), FirstChar, fg, bg
      row = row + 1
   ELSE
      txt$ = "--More fields not shown--"
      WinPrt txt$, 24, col, LEN(txt$), FirstChar, ISFG, ISBG
      row = row + 1
      EXIT FOR
   END IF
NEXT
IF ask4 THEN
   WinPrt ask$, 23, 0, LEN(ask$), FirstChar, ISFG, ISBG
   InKeyResponse 23, LEN(ask$) + 1, ask4, ret$
ELSE
   txt$ = "Press a key to continue..."
   WinPrt txt$, 24, 0, LEN(txt$), FirstChar, ISFG, ISBG
   kbkey = WaitForKey
END IF
WinPut 0, 0, 25, 80, 0

'----------------------
'put up the header line (huh, whaduya mean use go-subs?)

'OutHdrLine:
'txt$ = " #  FieldName  T  Len  DC"
'WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
'row = row + 1
'txt$ = "ÄÄ  ÄÄÄÄÄÄÄÄÄ  Ä  ÄÄÄ  ÄÄ"
'WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
'row = row + 1
'RETURN
'
''----------------------
''put up the detail line
'
'OutDetailLine:
'txt$ = RIGHT$(" " + STR$(i), 2)
'WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
'txt$ = StrucDBF(i).FieldName
'WinPrt txt$, row, col + 4, LEN(txt$), FirstChar, fg, bg
'txt$ = StrucDBF(i).FieldType
'WinPrt txt$, row, col + 15, LEN(txt$), FirstChar, fg, bg
'txt$ = RIGHT$("  " + STR$(StrucDBF(i).FieldLen), 3)
'WinPrt txt$, row, col + 18, LEN(txt$), FirstChar, fg, bg
'txt$ = RIGHT$(" " + STR$(StrucDBF(i).FieldDC), 2)
'WinPrt txt$, row, col + 23, LEN(txt$), FirstChar, fg, bg
'row = row + 1
'RETURN
'
END SUB

SUB ShowFieldNames (StartField)

'put up field names, starting at StartField, for as many as will fit on screen

row = SSROW
col = 0
MaxChars = 80
FirstChar = 1
fg = ISFG
bg = ISBG
WinClr row, col, 1, 80, 32, fg, bg

txt$ = "Recno-- "
WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
col = col + LEN(txt$)

fg = HSFG
bg = HSBG

'put up the field names, if field name is longer than field size, okay,
'if field size is longer than field name then add extension characters

LastCol = col
cnt = 0
FOR i = StartField TO SDP.fields
   xchars = 0
   txt$ = LEFT$(StrucDBF(i).FieldName, INSTR(StrucDBF(i).FieldName, ZSTR) - 1)
   tl = LEN(txt$)
   IF StrucDBF(i).FieldLen > tl THEN xchars = StrucDBF(i).FieldLen - tl
   LastCol = LastCol + tl + xchars + 1
   txt$ = txt$ + STRING$(xchars, "-") + " "

   'check if entire field fits, if so okay
   'if not, and not first field then exit w/o putting up fieldname
   'if first field (or start field) then put it up but truncate
   'if more fields exist or only partial field a double right-arrow is added

   IF LastCol < 79 THEN
      WinPrt txt$, row, col, LEN(txt$), FirstChar, fg, bg
      col = col + LEN(txt$)
      cnt = cnt + 1
   ELSE
      IF i = StartField THEN
         WinPrt txt$, row, col, (79 - col), FirstChar, fg, bg
         col = 79
         cnt = 1
      END IF
      txt$ = "¯"
      WinPrt txt$, row, col, 1, FirstChar, fg, bg
      EXIT FOR
   END IF
NEXT

'update field display info

FDI.FirstField = StartField
FDI.FieldsDisplayed = cnt

END SUB

SUB ShowMainScreen (infile$)

'put up the main screen

row = 0: col = 0
MaxChars = 80: FirstChar = 1
fg = ISFG: ISBG = 0
atxt$(1) = "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
atxt$(2) = "³Ver:       DOS:       SHARE:            Locking:        Elap time:       secs ³"
atxt$(3) = "³DBF:                                                                          ³"
atxt$(4) = "³Recs:          RecLen:         Flds:      Last Update:   /  /     Dirty:      ³"
atxt$(5) = "³IX:       KX:                                                                 ³"
atxt$(6) = "³KY:                                                                  EW:      ³"
atxt$(7) = "³Keys:          KeyLen:     KeyFlags:                NLS:          Dirty:      ³"
atxt$(8) = "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
FL = 1
FOR i = FL TO 8
   WinPrt atxt$(i), row, col, MaxChars, FirstChar, fg, bg
   row = row + 1
NEXT

col = 0
fg = HSFG: bg = HSBG
atxt$(1) = SPACE$(80)
WinPrt atxt$(1), row, col, MaxChars, FirstChar, fg, bg
row = row + 1

col = 79
fg = ISFG: bg = ISBG
atxt$(1) = "þ"
atxt$(2) = "³"
atxt$(3) = "³"
atxt$(4) = "³"
atxt$(5) = "³"
atxt$(6) = "³"
atxt$(7) = "³"
atxt$(8) = "³"
atxt$(9) = ""
atxt$(10) = ""
FOR i = FL TO 10
   WinPrt atxt$(i), row, col, MaxChars, FirstChar, fg, bg
   row = row + 1
NEXT

col = 0
atxt$(1) = " þÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ  "
WinPrt atxt$(1), row, col, MaxChars, FirstChar, fg, bg
row = row + 1

fg = ISFG: bg = ISBG
atxt$(1) = "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
atxt$(2) = "³F1-       F3-Select IX   F5-             F7-          F9-                     ³"
atxt$(3) = "³F2-       F4-            F6-Disp Struc   F8-          F10-            ESC Quit³"
atxt$(4) = "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
atxt$(5) = "IDEMO for BULLET                                                  Mode: BROWSE  "
FOR i = FL TO 5
   WinPrt atxt$(i), row, col, MaxChars, FirstChar, fg, bg
   row = row + 1
NEXT

txt$ = RIGHT$(STR$(IP.version \ 100), 1) + "." + RIGHT$("0" + LTRIM$(STR$(IP.version MOD 100)), 2)
WinPrt txt$, 1, 6, 4, 1, ISFGB, ISBG

txt$ = RIGHT$(STR$(IP.DOSver \ 256), 1) + "." + RIGHT$("0" + LTRIM$(STR$(IP.DOSver AND 255)), 2)
WinPrt txt$, 1, 17, 4, 1, ISFGB, ISBG

IF RP.IsShare THEN txt$ = "installed" ELSE txt$ = "not inst "
WinPrt txt$, 1, 30, 9, 1, ISFGB, ISBG

IF LockFlag = 0 THEN txt$ = "off" ELSE txt$ = "on"
IF RP.IsShare = 0 THEN txt$ = "n/a"
WinPrt txt$, 1, 50, 3, 1, ISFGB, ISBG
IF RP.IsRemote = 0 THEN t$ = " - local " ELSE t$ = " - remote"
WinPrt infile$ + t$, 2, 6, 73, 1, ISFGB, ISBG

'SDP.recs,reclen,fields,dirty,LUyear...
txt$ = STR$(SDP.Recs)
WinPrt txt$, 3, 6, 8, 1, ISFGB, ISBG
txt$ = STR$(SDP.RecLen)
WinPrt txt$, 3, 23, 5, 1, ISFGB, ISBG
txt$ = STR$(SDP.fields)
WinPrt txt$, 3, 37, 4, 1, ISFGB, ISBG
txt$ = STR$(ASC(SDP.LUmonth))
txt$ = RIGHT$("0" + LTRIM$(STR$(ASC(SDP.LUmonth))), 2)
WinPrt txt$, 3, 56, 5, 1, ISFGB, ISBG
txt$ = RIGHT$("0" + LTRIM$(STR$(ASC(SDP.LUday))), 2)
WinPrt txt$, 3, 59, 5, 1, ISFGB, ISBG
txt$ = RIGHT$("0" + LTRIM$(STR$(ASC(SDP.LUyear))), 2)
WinPrt txt$, 3, 62, 5, 1, ISFGB, ISBG
IF ASC(SDP.Dirty) = 0 THEN txt$ = "no" ELSE txt$ = "yes"
WinPrt txt$, 3, 74, 5, 1, ISFGB, ISBG

EXIT SUB

OutLines:
FOR i = FL TO LL
   WinPrt atxt$(i), row, col, MaxChars, FirstChar, fg, bg
   row = row + 1
NEXT
RETURN

END SUB

SUB ShowNewFields (newfield)

'refresh scroll screen to reflect newfield start

IF newfield <= 0 THEN              'OR PI.HorzSlide = 0 THEN
   newfield = 1
ELSEIF newfield > SDP.fields THEN  'OR PI.HorzSlide = 74 THEN
   newfield = SDP.fields
END IF

WinClr SSROW + 1, 0, SSROWS, 79, 32, SSFG, SSBG
ShowFieldNames newfield

row = 0
FOR i& = RDI.TopRecord TO RDI.TopRecord + SSROWS - 1
   stat = GetRecord(i&)
   IF stat THEN EXIT FOR
   row = row + 1
   DisplayRecord i&, SSROW + row
NEXT
DoHighlight PI.ScreenRow

END SUB

SUB ShowStartCL

row = 0: col = 0
MaxChars = 80: FirstChar = 1
fg = ISFG: ISBG = 0
atxt$(1) = "IDEMO is an interactive demo program for the BULLET b-tree/DBF file manager"
atxt$(2) = "libraries for DOS compilers. IDEMO requires that you supply the filename of"
atxt$(3) = "the .DBF file to browse."
atxt$(4) = " "
atxt$(5) = "Use:  C>idemo pathname.DBF"
FOR i = 1 TO 5
   WinPrt atxt$(i), row, col, MaxChars, FirstChar, fg, bg
   row = row + 1
NEXT

END SUB

FUNCTION WaitForKey

'wait for a keypress or mouse button press
'return the ASCII key code (1000+x for extended keys, 13 for mouse button)
'flushes KB buffer

DO
   kb$ = INKEY$
   kblen = LEN(kb$)
   SELECT CASE kblen
   CASE 0
      kbkey = 0
      IF IsMouse THEN
         MouseFunc 3, IM, OM
         IF OM.bx THEN kbkey = 13
      END IF
   CASE 1
      kbkey = ASC(kb$)
   CASE 2
      kbkey = 1000 + ASC(RIGHT$(kb$, 1))
   CASE ELSE
   END SELECT
LOOP UNTIL kbkey
DO: LOOP WHILE LEN(INKEY$)
WaitForKey = kbkey

END FUNCTION

SUB WinClr (row, col, rows, cols, char, fg, bg)

'clear a window with char using attr
'if char=0 then only attributes changed

WFP.Func = FillWIN
WFP.Mode = 0                    'default screen
WFP.page = 0
WFP.x0 = col
WFP.y0 = row
WFP.xsize = cols
WFP.ysize = rows
WFP.attrchar = 256& * ((bg * 16) + fg) + char
MouseTurn 0
nix = ZWINDO(WFP)
MouseTurn 1

END SUB

SUB WinGet (row, col, rows, cols, ID)

'store the window area into the buffer

IF ID < 0 OR ID > MAXWINSAVES THEN STOP

WSP.Func = SaveWIN
WSP.Mode = 0                    'default screen
WSP.page = 0
WSP.x0 = col
WSP.y0 = row
WSP.xsize = cols
WSP.ysize = rows
WSP.BuffPtrOff = VARPTR(WinBuff(ID * 2000))
WSP.BuffPtrSeg = VARSEG(WinBuff(ID * 2000))
MouseTurn 0
nix = ZWINDO(WSP)
MouseTurn 1

END SUB

SUB WinPrt (txt$, row, col, MaxChars, FirstChar, fg, bg)

'print the text string
'row/col are 0-based
'either print MaxChars or until 0-term
'first character printed is specified by StartChar

TmpStr = txt$ + ZSTR

WPP.Func = PrintWIN
WPP.Mode = 0                    'default screen
WPP.page = 0
WPP.x0 = col
WPP.y0 = row
WPP.xsize = MaxChars
WPP.xoffset = FirstChar - 1     'ZWINDO's xoffset is 0-based
WPP.attr = (bg * 16) + fg
WPP.TextPtrOff = VARPTR(TmpStr)
WPP.TextPtrSeg = VARSEG(TmpStr)
MouseTurn 0
nix = ZWINDO(WPP)
MouseTurn 1

END SUB

SUB WinPut (row, col, rows, cols, ID)

'restore the buffer to the window area

IF ID < 0 OR ID > MAXWINSAVES THEN STOP

WSP.Func = BackWIN
WSP.Mode = 0                    'default screen
WSP.page = 0
WSP.x0 = col
WSP.y0 = row
WSP.xsize = cols
WSP.ysize = rows
WSP.BuffPtrOff = VARPTR(WinBuff(ID * 2000))
WSP.BuffPtrSeg = VARSEG(WinBuff(ID * 2000))
MouseTurn 0
nix = ZWINDO(WSP)
MouseTurn 1

END SUB

SUB WinScroll (row, col, rows, cols, dir, fg, bg)

'scroll the window and clear the first/last row

trows = rows - 1
IF dir > 0 THEN
   WinGet row + 1, col, trows, cols, 1
   WinPut row, col, trows, cols, 1
   WinPrt SPACE$(cols), row + rows - 1, col, cols, 1, fg, bg
ELSEIF dir < 0 THEN
   WinGet row, col, trows, cols, 1
   WinPut row + 1, col, trows, cols, 1
   WinPrt SPACE$(cols), row, col, cols, 1, fg, bg
ELSE
   WinClr row, col, rows, cols, 32, fg, bg
END IF

END SUB

SUB WinSetMode (page, row, col, cstart, cend, vmode)

'set video mode using BIOS, move cursor off-screen

WCP.Func = CursorWIN
WCP.Mode = 1
WCP.page = page
WCP.x0 = 0
WCP.y0 = 25
WCP.cstart = cstart
WCP.cend = cend
WCP.vmode = vmode
MouseTurn 0
nix = ZWINDO(WCP)
MouseTurn 1

END SUB

SUB WinShift (row, col, rows, cols, dir, fg, bg)

tcols = cols - 1
IF dir > 0 THEN
   WinGet row, col + 1, rows, tcols, 1
   WinPut row, col, rows, tcols, 1
   WinClr row, col + cols - 1, rows, 1, 32, fg, bg
ELSEIF dir < 0 THEN
   WinGet row, col, rows, tcols, 1
   WinPut row, col + 1, rows, tcols, 1
   WinClr row, col, rows, 1, 32, fg, bg
ELSE
   WinClr row, col, rows, cols, 32, fg, bg
END IF

END SUB

