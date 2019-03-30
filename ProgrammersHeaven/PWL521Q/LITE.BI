
' ProWindows(tm) LITE 5.20 (Unregistered)
' Copyright 1988-1992 DSE Software Publishing

CONST AUTOCLOSE% = 512
CONST AUTOSCROLL% = 8192
CONST BEEPER% = 2
CONST CLICKER% = 1
CONST DISABLE% = 0
CONST DRAGBAR% = 4
CONST ENABLE% = 1
CONST FLAT% = 128
CONST GLISANDO% = 3
CONST HORZSCROLLBAR% = 8
CONST NOCOMPRESS% = 256
CONST OFFBUTTON% = 1
CONST RESIZEBUTTON% = 2
CONST SELECTABLE% = 64
CONST VERTSCROLLBAR% = 16

TYPE wincb
 row AS INTEGER
 col AS INTEGER
 rows AS INTEGER
 cols AS INTEGER
 attr AS INTEGER
 Border AS INTEGER
 Shadow AS INTEGER
 Zoom AS INTEGER
 ptr AS INTEGER
 cbytes AS INTEGER
 abytes AS INTEGER
END TYPE

TYPE vircb
 row AS INTEGER
 col AS INTEGER
 rows AS INTEGER
 cols AS INTEGER
 vrow AS INTEGER
 vcol AS INTEGER
 vrows AS INTEGER
 vcols AS INTEGER
 attr AS INTEGER
 Border AS INTEGER
 Shadow AS INTEGER
 Zoom AS INTEGER
 WI AS INTEGER
 Options AS INTEGER
 TitlePos AS INTEGER
 Title AS STRING * 20
 buttons AS INTEGER
 LastButton AS INTEGER
 VertPos AS INTEGER
 HorzPos AS INTEGER
 Signature AS INTEGER
END TYPE

TYPE InkeyRec
 Length AS INTEGER
 ShiftState AS INTEGER
 KeyChar AS STRING * 1
 KeyValue AS INTEGER
 AltChar AS STRING * 1
 AltValue AS INTEGER
 ExtChar AS STRING * 2
 ExtValue AS INTEGER
END TYPE

TYPE EventCoords
 event AS INTEGER
 row AS INTEGER
 col AS INTEGER
END TYPE

TYPE cursorTYPE
 row AS INTEGER
 col AS INTEGER
 attr AS INTEGER
END TYPE

DECLARE FUNCTION attr% (f%, b%)
DECLARE FUNCTION BinAttr% (Fore%, Back%, High%, Blink%)
DECLARE FUNCTION BWattr% (Attrib%)
DECLARE FUNCTION CheckMouse% (buttons%)
DECLARE FUNCTION DoubleClick% (DelayTime%)
DECLARE FUNCTION FREEWINDOW% ()
DECLARE FUNCTION GetEvent% (mode%)
DECLARE FUNCTION GetMouse% (row%, col%)
DECLARE FUNCTION GetMousePress% (button%, presses%, row%, col%)
DECLARE FUNCTION GetMouseRelease% (button%, presses%, row%, col%)
DECLARE FUNCTION GetUserCoords% (rw%, cl%, size%, row%, col%)
DECLARE FUNCTION GetVirtualPtr% (winHandle%)
DECLARE FUNCTION IsBWmode% ()
DECLARE FUNCTION Mouse% (button%, cmd%)
DECLARE FUNCTION RAND% (Limit%)
DECLARE FUNCTION ScanQuickKeys% (K$)
DECLARE FUNCTION ScreenMode% ()
DECLARE FUNCTION VideoBoard% ()
DECLARE FUNCTION VideoPage% ()
DECLARE FUNCTION VideoPageLength% ()
DECLARE FUNCTION WhatWindow% (row%, col%)

DECLARE SUB ClearWindow ()
DECLARE SUB Click ()
DECLARE SUB CloneWindow (winHandle%)
DECLARE SUB CloseWindow (winHandle%)
DECLARE SUB ColorScreen (row%, col%, rows%, cols%, Attrib%, SNOW%)
DECLARE SUB Copyright (row%, col%)
DECLARE SUB csprint (row%, col%, qattr%, StrDat$)
DECLARE SUB cwcprint (row%, qattr%, StrDat$)
DECLARE SUB cwprint (row%, col%, qattr%, StrDat$)
DECLARE SUB DisplayWindow (winHandle%, row%, col%, rows%, cols%)
DECLARE SUB DrawBox (row%, col%, rows%, cols%, qattr%, brdrsel%)
DECLARE SUB FillBuffer (Segment%, Offset%, size%, char%, Attrib%)
DECLARE SUB FillScreen (row%, col%, rows%, cols%, Attrib%, char%, SNOW%)
DECLARE SUB ForceWindow (winHandle%)
DECLARE SUB GetScreen (row%, col%, rows%, cols%, Segment%, Offset%, SNOW%)
DECLARE SUB GetVideoInfo (Segment%, Offset%, rows%, cols%)
DECLARE SUB GetWindowMouse (button%, frow%, fcol%, frows%, fcols%, row%, col%)
DECLARE SUB GrabWindow (winHandle%)
DECLARE SUB HideWindow (winHandle%)
DECLARE SUB HotPrint (row%, col%, Attr1%, Text$, Attr2%, HotChar$)
DECLARE SUB InitPro ()
DECLARE SUB InitVideo ()
DECLARE SUB MainWindow (winHandle%)
DECLARE SUB MakeWindow (row%, col%, rows%, cols%, qattr%, brdrsel%, Shadow%, Zoom%, SNOW%)
DECLARE SUB MouseCursoroff ()
DECLARE SUB MouseCursorOn ()
DECLARE SUB MoveWindow (winHandle%, row%, col%)
DECLARE SUB Notice ()
DECLARE SUB nprint (row%, col%, qattr%, UsingMask$, Number#)
DECLARE SUB OpenWindow (winHandle%, rows%, cols%, Attrib%, Border%, Shadow%, Zoom%, Options%)
DECLARE SUB PopSound ()
DECLARE SUB PopWindow (row%, col%, rows%, cols%, qattr%, brdrsel%, Shadow%, Zoom%)
DECLARE SUB PreInit ()
DECLARE SUB PutScreen (row%, col%, rows%, cols%, Segment%, Offset%, SNOW%)
DECLARE SUB QuickKey (Location%, Keypress$)
DECLARE SUB ReAlignWindow (winHandle%, row%, col%)
DECLARE SUB ReCycleMode (mode%)
DECLARE SUB RefreshAllWindows ()
DECLARE SUB RefreshMain ()
DECLARE SUB RefreshMode (mode%)
DECLARE SUB RefreshWindow (winHandle%)
DECLARE SUB RemoveSound ()
DECLARE SUB RemoveWindow ()
DECLARE SUB ResetVideo ()
DECLARE SUB ResizeWindow (winHandle%, rows%, cols%)
DECLARE SUB ScrollScreen (row%, col%, rows%, cols%, Attrib%, slines%, sdir%)
DECLARE SUB SeedRand (Value%)
DECLARE SUB SetBWmode (mode%)
DECLARE SUB SetCalendar (Handle%, row%, col%, Attrib%, status%)
DECLARE SUB SetClock (Handle%, row%, col%, Attrib%, status%)
DECLARE SUB SetEventDelay (ticks%)
DECLARE SUB SetMonitorColor (Kolor%)
DECLARE SUB SetMouse (row%, col%)
DECLARE SUB SetMouseMode (newmode%)
DECLARE SUB SetMouseWindow (row%, col%, rows%, cols%)
DECLARE SUB SetShadow (mode%, Attrib%)
DECLARE SUB SetUserCoords (Position%, row%, col%, rows%, cols%)
DECLARE SUB SetVideoInfo (Segment%, Offset%, rows%, cols%)
DECLARE SUB SetWindow (winHandle%)
DECLARE SUB SetZoomSpeed (miliseconds%)
DECLARE SUB SetZoomStyle (FadeMode%)
DECLARE SUB ShowWindow (row%, col%, rows%, cols%, vrow%, vcol%)
DECLARE SUB sprint (row%, col%, Attrib%, StrDat$, SNOW%)
DECLARE SUB termMouse ()
DECLARE SUB TitleWindow (DirPos%, Title$)
DECLARE SUB UnAttr (Attrib%, Fore%, Back%)
DECLARE SUB UnBinAttr (Attrib%, Fore%, Back%, High%, Blink%)
DECLARE SUB UseDrivers (menus%, forms%, cursors%)
DECLARE SUB vprint (row%, col%, Attrib%, StrDat$, SNOW%)
DECLARE SUB wcprint (row%, StrDat$)
DECLARE SUB winCLS (winHandle%)
DECLARE SUB winColor (winHandle%, Fore%, Back%)
DECLARE SUB winDeleteLine (winHandle%)
DECLARE SUB winInsertLine (winHandle%)
DECLARE SUB winLocate (winHandle%, row%, col%)
DECLARE SUB winPos (winHandle%, row%, col%)
DECLARE SUB winPrint (winHandle%, Text$)
DECLARE SUB winPrintCR (winHandle%)
DECLARE SUB winPrintCRLF (winHandle%)
DECLARE SUB winPrintLF (winHandle%)
DECLARE SUB winPrintLn (winHandle%, Text$)
DECLARE SUB winPrintNum (winHandle%, format$, Value#)
DECLARE SUB wlocate (row%, col%)
DECLARE SUB wprint (row%, col%, StrDat$)

COMMON SHARED /cursorDATA/ cursor() AS cursorTYPE, CurCursor AS cursorTYPE, curvcb AS vircb, cursorOffset AS INTEGER
COMMON SHARED /DialogData/ Keyboard AS InkeyRec, WindowEvent AS INTEGER, WindowHandle AS INTEGER, MenuItem AS INTEGER, KeyBuffer$
COMMON SHARED /MouseEvents/ DataEvent AS EventCoords, UserEvent AS EventCoords
COMMON SHARED /QuickKey/ QuickKeys AS INTEGER, QuickKeyEvent AS INTEGER
COMMON SHARED /VideoData/ MAXROWS AS INTEGER, MAXCOLS AS INTEGER, VIDEOSEGMENT AS INTEGER, VIDEOOFFSET AS INTEGER
COMMON SHARED /VLSdata/ VirMem() AS INTEGER, vcb() AS vircb, wcbndx() AS INTEGER, CurrentWindow AS INTEGER, UpdateMode AS INTEGER, GlobalOptions AS INTEGER, FreezeFrame AS INTEGER, VideoRecycle AS INTEGER
COMMON SHARED /WindowData/ wcb() AS wincb, scrn() AS INTEGER, WI AS INTEGER, SoundMode AS INTEGER, SNOW AS INTEGER, CreateMode AS INTEGER, ERRNO AS INTEGER
COMMON SHARED /wprintData/ WindowSeg AS INTEGER, WindowOff AS INTEGER, WindowSize AS INTEGER, WindowSig AS INTEGER

