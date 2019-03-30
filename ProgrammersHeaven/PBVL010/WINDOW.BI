' PB/VISION(tm) LITE - (c) Copyright 1994 DSE Software Publishing
' SHAREWARE EVALUATION VERSION

$DYNAMIC
DEFINT A-Z

' APP FLAGS

%TITLEBAR = &H100
%MENUBAR = &H8
%STATUSBAR = &H8000

' WINDOW FLAGS

%AUTOCLOSE = &H2000
%AUTOSCROLL = &H8000
%BOTTOMBAR = &H80
%CONTROL = &H200
%DRAGBAR = &H800
%HSCROLLBAR = &H20
%MINMAX = &H400
%NOHORZBORDER = &H2
%NOVERTBORDER = &H8
%NOCOLOR = &H1000
%NOHIDE = &H4000
%NOSELECT = &H40
%RESIZE = &H4
%SHADOW = &H1
%VSCROLLBAR = &H10

%ISWINDOW = &H1
%ISPOPMENU = &H2
%ISFORM = &H4
%ISPULLMENU = &H8

TYPE winTYPE
 row AS BYTE			' screen position where window is displayed
 col AS BYTE
 rows AS BYTE			' dimensions of the displayed text portion of window
 cols AS BYTE
 orows AS BYTE			' window text dimensions before re-sizing
 ocols AS BYTE
 vrow AS BYTE			' starting positions of viewport into window
 vcol AS BYTE
 vrows AS BYTE			' actual virtual dimensions of window
 vcols AS BYTE
 winattr AS BYTE		' default color attribute of window contents
 borderattr AS INTEGER		' attribute of window border
 titleattr AS BYTE		' attribute of window title
 border AS BYTE			' border style
 titleLen AS BYTE		' length of title string
 Title AS STRING * 40		' text of window title
 vbarPos AS BYTE		' window scrollbar guage (1% to 100%)
 hbarPos AS BYTE
 flags AS INTEGER		' flags used when window opened
 winmode AS BYTE		' INTERNAL - DO NOT CHANGE
 UserObject AS INTEGER		' User Object Pointer
 unused2 AS INTEGER		' FUTURE USE
 WI AS BYTE			' window position relative to top most window
 ObjPtr AS INTEGER		' handle of attached window object code
 internal1 AS BYTE		' current item position (if menu or form)
 signature AS INTEGER		' signature of window
 cpos AS INTEGER		' encoded window cursor position (see WINLOCATE)
 cattr AS BYTE			' current window print attribute (see WINCOLOR)
 bufferHandle AS INTEGER	' handle of window buffer
 changed AS BYTE		' flag indicating window needs to be refreshed
 unused3 AS INTEGER		' FUTURE USE
 listPtr AS INTEGER		' top of list (if list style routine)
 winProcOff AS INTEGER		' seg/off address of attached PB/VISION driver(s)
 winProcSeg AS INTEGER
 winUserfOff AS INTEGER		' seg/off address of attached user code
 winUserSeg AS INTEGER
 srows AS BYTE			' screen dimensions of the displayed of window
 scols AS BYTE
END TYPE

TYPE appTYPE
 attr AS BYTE			' fill-pattern color
 Pattern AS BYTE		' background fill-pattern
 titleattr AS BYTE		' color of program title (if enabled)
 Title AS STRING * 80		' text of program title (if enabled)
 menuAttr AS BYTE		' color of menu bar
 statusAttr AS BYTE		' color of status bar
 internal1 AS BYTE		' DO NOT CHANGE
 rows AS BYTE			' screen rows
 flags AS INTEGER		' aplication initialization flags
 graphicsMouse AS BYTE		' DO NOT CHANGE
 internal4 AS BYTE		' DO NOT CHANGE
 internal5 AS BYTE		' DO NOT CHANGE
 videoSeg AS INTEGER		' DO NOT CHANGE
 videoOff AS INTEGER		'	""
 videoHeight AS INTEGER		'	""
 videoWidth AS INTEGER		'	""
 videoLength AS INTEGER		'	""
 winRow AS BYTE			'	""
 winRows AS BYTE		'	""
 winOffset AS INTEGER		'	""
 forceRefresh AS BYTE		'	""
 titleRow AS BYTE		'	""
 menuRow AS BYTE		'	""
 graphicsMode AS BYTE		' 0 = text, 1 = graphics
END TYPE

TYPE menucolorTYPE
 kolor AS INTEGER
 borderattr AS INTEGER
 titleattr AS BYTE
 highlight AS INTEGER
 sepbar AS BYTE
 cursor AS BYTE
 border AS BYTE
 flags AS INTEGER
END TYPE

DECLARE FUNCTION attr% (BYVAL fore%, BYVAL back%)

DECLARE SUB appClose ()
DECLARE SUB appInit ()
DECLARE SUB appPause ()
DECLARE SUB appRefresh ()
DECLARE SUB appResume ()
DECLARE SUB appTitle (BYVAL kolor%, title$)
DECLARE FUNCTION VideoBoard% ()
DECLARE SUB winClose (BYVAL winHandle%)
DECLARE SUB winCLS (BYVAL winHandle%)
DECLARE SUB winColor (BYVAL winHandle%, BYVAL kolor%)
DECLARE FUNCTION winCopy% (BYVAL winHandle%)
DECLARE SUB winCursor (BYVAL winHandle%, BYVAL row%, BYVAL col%)
DECLARE SUB winDeleteLine (BYVAL winHandle%, BYVAL LineNo%)
DECLARE SUB winDrawBox (BYVAL winHandle%, BYVAL row%, BYVAL col%, BYVAL rows%, BYVAL cols%, BYVAL kolor%, BYVAL border%)
DECLARE SUB winFill (BYVAL winHandle%, BYVAL row%, BYVAL col%, BYVAL rows%, BYVAL cols%, BYVAL kolor%, BYVAL c%)
DECLARE SUB winGetInfo (BYVAL winHandle%, win AS winTYPE)
DECLARE SUB winGrab (BYVAL winHandle%)
DECLARE SUB winHide (BYVAL winHandle%)
DECLARE SUB winHotPrint (BYVAL winHandle%, BYVAL row%, BYVAL col%, BYVAL Attr1%, text$)
DECLARE SUB winInsertLine (BYVAL winHandle%, BYVAL LineNo%)
DECLARE SUB winInstallCode (BYVAL winHandle%, BYVAL segment%, BYVAL offset%)
DECLARE SUB winLocate (BYVAL winHandle%, BYVAL row%, BYVAL col%)
DECLARE SUB winLock (BYVAL handle%)
DECLARE SUB winMain (BYVAL winHandle%)
DECLARE SUB winMinimize (BYVAL winHandle%)
DECLARE SUB winMaximize (BYVAL winHandle%)
DECLARE SUB winNormalize (BYVAL winHandle%)
DECLARE SUB winModify (BYVAL winHandle%, BYVAL kolor%, BYVAL border%, BYVAL borderKolor%, BYVAL titleKolor%, BYVAL flags%)
DECLARE SUB winMove (BYVAL winHandle%, BYVAL row%, BYVAL col%)
DECLARE SUB winNext ()
DECLARE FUNCTION winOpen% (BYVAL rows%, BYVAL cols%, BYVAL kolor%, BYVAL border%, BYVAL borderKolor%, Title$, BYVAL titleKolor%, BYVAL flags%)
DECLARE FUNCTION winPopup% (BYVAL row%, BYVAL col%, BYVAL rows%, BYVAL cols%, BYVAL kolor%, BYVAL border%, BYVAL borderKolor%, Title$, BYVAL titleKolor%, BYVAL flags%)
DECLARE SUB winPos (BYVAL winHandle%, row%, col%)
DECLARE SUB winPrev ()
DECLARE SUB winPrint (BYVAL winHandle%, BYVAL row%, BYVAL col%, BYVAL kolor%, text$)
DECLARE SUB winPrintV (BYVAL winHandle%, BYVAL row%, BYVAL col%, BYVAL kolor%, text$)
DECLARE SUB winRecolor (BYVAL winHandle%, BYVAL kolor%)
DECLARE SUB winRefresh (BYVAL winHandle%)
DECLARE SUB winRefreshMode (BYVAL mode%)
DECLARE SUB winResize (BYVAL winHandle%, BYVAL rows%, BYVAL cols%)
DECLARE SUB winScrollBarGet (BYVAL winHandle%, vpos%, hpos%)
DECLARE SUB winScrollBarSet (BYVAL winHandle%, BYVAL vpos%, BYVAL hpos%)
DECLARE SUB winSet (BYVAL winHandle%)
DECLARE SUB winSetInfo (BYVAL winHandle%, win AS winTYPE)
DECLARE SUB winShow (BYVAL winHandle%, BYVAL row%, BYVAL col%, BYVAL rows%, BYVAL cols%)
DECLARE SUB winSwapColor (BYVAL winHandle%, BYVAL oldKolor%, BYVAL newKolor%)
DECLARE SUB winTitle (BYVAL winHandle%, BYVAL kolor%, Title$)
DECLARE SUB winViewPort (BYVAL winHandle%, BYVAL row%, BYVAL col%)
DECLARE FUNCTION winWho% (BYVAL row%, BYVAL col%, wrow%, wcol%)
DECLARE SUB winWrite (BYVAL winHandle%, text$)
DECLARE SUB winWriteChar (BYVAL winHandle%, BYVAL char%)
DECLARE SUB winWriteLn (BYVAL winHandle%, text$)

 DIM app AS appTYPE
 DIM tempWin AS winTYPE
 DIM refreshEnable AS INTEGER, lockWinP AS BYTE
 DIM WI AS INTEGER, WINGET AS INTEGER, topWinBufH AS INTEGER, currentWinH AS INTEGER
 DIM currentWinS AS INTEGER, currentWinO AS INTEGER
 DIM currentWinLen AS INTEGER, currentWinChars AS INTEGER, currentWinCols AS INTEGER
 DIM pbvvideoseg AS INTEGER, pbvvideooff AS INTEGER

$IF %ISPBU
 EXTERNAL app, tempWin
 EXTERNAL refreshEnable, lockWinP
 EXTERNAL WI, WINGET, topWinBufH, currentWinH, currentWinS, currentWinO, currentWinLen, currentWinChars, currentWinCols
 EXTERNAL pbvvideoseg, pbvvideooff
$ELSE
 PUBLIC app, tempWin
 PUBLIC refreshEnable, lockWinP
 PUBLIC WI, WINGET, topWinBufH, currentWinH, currentWinS, currentWinO, currentWinLen, currentWinChars, currentWinCols
 PUBLIC pbvvideoseg, pbvvideooff

 $LINK "PBVLITE.PBL"

$ENDIF
