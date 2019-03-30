' Window Sizer - (C) John White, 2002. All Rights Reserved.
' Written with William Yu`s Rapid-Q Basic Interpreter/Compiler.

$INCLUDE "RAPIDQ.INC"
$OPTIMIZE ON
$APPTYPE GUI
$TYPECHECK ON
$ESCAPECHARS ON

CONST rqClassName="TForm"        '-- Classname for all Rapid-Q programs
CONST myFormName="Window Sizer V2.05"
CONST SWP_NOSIZE=&H1
CONST SWP_NOMOVE=&H2
CONST SWP_NOZORDER=&H4
CONST MOD_ALT=1
CONST MOD_CTRL=2
CONST MOD_SHFT=4
CONST HWND_TOPMOST=-1
CONST HWND_NOTOPMOST=-2
CONST SWP_NOACTIVATE=&H10
CONST SWP_SHOWWINDOW=&H40
CONST GWL_STYLE=-16
CONST GWL_EXSTYLE=-20
CONST WS_MINIMIZEBOX=&H00020000
CONST WS_MAXIMIZEBOX=&H00010000
CONST WS_POPUP=&H80000000
CONST WS_CHILD=&H40000000
CONST WS_MINIMIZE=&H20000000
CONST WS_MAXIMIZE=&H01000000
CONST WS_CAPTION=&H00C00000
CONST WS_BORDER=&H00800000
CONST WS_DLGFRAME=&H00400000
CONST WS_SIZEBOX=&H00040000
CONST WINDOW_YLIMIT=566
CONST WM_HOTKEY=&H312

TYPE tRECT
left AS LONG
top AS LONG
right AS LONG
bottom AS LONG
END TYPE

TYPE pPOINT
x AS LONG
y AS LONG
END TYPE

DECLARE FUNCTION FindWindow LIB "USER32.DLL" ALIAS "FindWindowA" (className AS STRING, windowName AS STRING) AS INTEGER
DECLARE FUNCTION GetCursorPos LIB "USER32.DLL" ALIAS "GetCursorPos" (point as pPOINT) AS LONG
DECLARE FUNCTION SetWindowPos LIB "USER32.DLL" ALIAS "SetWindowPos"(hWnd AS LONG, hWndInsertAfter AS LONG, X AS LONG, Y AS LONG, cx AS LONG, cy AS LONG, wFlags AS LONG) AS LONG
DECLARE FUNCTION GetWindowRect LIB "USER32.DLL" ALIAS "GetWindowRect" (hwnd AS LONG, lpRect AS tRECT) AS LONG
DECLARE FUNCTION WindowFromPoint LIB "USER32.DLL" ALIAS "WindowFromPoint" (xpoint AS LONG, ypoint as long) AS LONG
DECLARE FUNCTION CloseWindow LIB "USER32.DLL" ALIAS "CloseWindow" (hwnd AS LONG) AS LONG
DECLARE FUNCTION MoveWindow LIB "USER32.DLL" ALIAS "MoveWindow" (hwnd AS LONG, x AS LONG, y AS LONG, w AS LONG, h AS LONG, paint AS LONG) AS LONG
DECLARE FUNCTION GetClassName LIB "USER32.DLL" ALIAS "GetClassNameA" (byval hwnd AS LONG, byref lpClassName AS STRING, nMaxCount AS LONG) AS LONG
DECLARE FUNCTION GetWindowLong LIB "USER32.DLL" ALIAS "GetWindowLongA" (hwnd AS LONG, nindex AS LONG) AS LONG
DECLARE FUNCTION SetWindowLong LIB "USER32.DLL" ALIAS "SetWindowLongA" (hwnd AS LONG, nindex AS LONG, newlong AS LONG) AS LONG
DECLARE FUNCTION GetActiveWindow LIB "USER32.DLL" ALIAS "GetActiveWindow" () AS LONG
DECLARE FUNCTION GetForegroundWindow LIB "USER32.DLL" ALIAS "GetForegroundWindow" () AS LONG
DECLARE FUNCTION ShowWindow LIB "USER32.DLL" ALIAS "ShowWindow" (hwnd AS LONG, command AS LONG) AS LONG
DECLARE FUNCTION RegisterHotKey LIB "USER32.DLL" ALIAS "RegisterHotKey" (hWnd AS LONG, ID AS LONG, fsModifiers AS LONG, vk AS LONG) AS LONG
DECLARE FUNCTION UnRegisterHotKey LIB "USER32.DLL" ALIAS "UnregisterHotKey" (hWnd AS LONG, ID AS LONG) AS LONG

DECLARE SUB FormWndProc (hWnd&, uMsg&, wParam&, lParam&)
DECLARE SUB Get_WSize ()
DECLARE SUB Check_WSize ()
DECLARE SUB Double_Check ()
DECLARE SUB Cleanup ()
DECLARE SUB TimerOff ()
DECLARE SUB TimerOn ()
DECLARE SUB Blank_Window ()

DEFINT hWnd=FindWindow(rqClassName, myFormName)

IF hWnd THEN
ShowMessage ("Window Sizer V2.05 is already running!")
Application.Terminate
END IF

DIM Window2 AS QFORM, sTimer AS QTIMER, rect0 AS tRECT
DIM coords AS pPOINT, File AS QFILESTREAM
DIM Stg$ AS STRING, buf AS STRING
DIM FInt AS INTEGER, FLong AS LONG, FWord AS WORD, FByte AS BYTE
DIM Z AS INTEGER, FLen AS INTEGER, actw AS LONG
DIM CL AS BYTE, CHK AS BYTE, CHA AS BYTE
DIM TOPGAP AS LONG, BOTTOMGAP AS LONG, LEFTGAP AS LONG, RIGHTGAP AS LONG
DIM WWIDTH AS LONG, WHEIGHT AS LONG, OLDX AS LONG, OLDY AS LONG
DIM WINTOP AS INTEGER, WINLEFT AS INTEGER, WINRIGHT AS INTEGER, WINBOTTOM AS INTEGER
DIM OLDTOP AS INTEGER, OLDLEFT AS INTEGER, OLDRIGHT AS INTEGER, OLDBOTTOM AS INTEGER
DIM CURTOP AS INTEGER, CURLEFT AS INTEGER, CURRIGHT AS INTEGER, CURBOTTOM AS INTEGER

CURTOP=0 : CURLEFT=0 : CURRIGHT=800 : CURBOTTOM=600 : OLDX=600 : OLDY=4
CL=0 : CHA=0 : CHK=0 : buf=STRING$(50, CHR$(0))

SUB Blank_Window
ShowWindow (Application.Handle, 0)
END SUB

SUB TimerOver 
sTimer.Interval=1
'IF CL=0 THEN
Get_WSize
'END IF
END SUB

SUB Check_WSize
IF WINLEFT<0 THEN MoveWindow (actw, 0, WINTOP, WWIDTH, WHEIGHT, TRUE)

IF WINTOP<0 THEN MoveWindow (actw, WINLEFT, 0, WWIDTH, WHEIGHT, TRUE)

IF WINRIGHT>800 THEN
RIGHTGAP=WINRIGHT-800
IF WINLEFT>=RIGHTGAP THEN
MoveWindow (actw, WINLEFT-RIGHTGAP, WINTOP, WWIDTH, WHEIGHT, TRUE)
ELSE
SetWindowPos (actw, 0, WINLEFT, WINTOP, WWIDTH-RIGHTGAP, WHEIGHT, SWP_NOMOVE OR SWP_NOZORDER)
END IF
END IF

IF WINBOTTOM>WINDOW_YLIMIT THEN
BOTTOMGAP=WINBOTTOM-WINDOW_YLIMIT
IF WINTOP>=BOTTOMGAP THEN
MoveWindow (actw, WINLEFT, WINTOP-BOTTOMGAP, WWIDTH, WHEIGHT, TRUE)
ELSE
SetWindowPos (actw, 0, WINLEFT, WINTOP, WWIDTH, WHEIGHT-BOTTOMGAP, SWP_NOMOVE OR SWP_NOZORDER)
END IF
END IF

END SUB

SUB Double_Check
flong=GetWindowRect (actw, rect0)
IF flong=TRUE THEN
WINLEFT=rect0.left : WINTOP=rect0.top : WINRIGHT=rect0.right : WINBOTTOM=rect0.bottom
WWIDTH=WINRIGHT-WINLEFT : WHEIGHT=WINBOTTOM-WINTOP
Check_WSize
END IF
flong=GetWindowRect (actw, rect0)
IF flong=TRUE THEN
WINLEFT=rect0.left : WINTOP=rect0.top : WINRIGHT=rect0.right : WINBOTTOM=rect0.bottom
WWIDTH=WINRIGHT-WINLEFT : WHEIGHT=WINBOTTOM-WINTOP
Check_WSize
END IF
END SUB

SUB Get_WSize (Sender AS QCANVAS)
CL=1 : OLDTOP=WINTOP : OLDLEFT=WINLEFT : OLDRIGHT=WINRIGHT : OLDBOTTOM=WINBOTTOM
flong=GetCursorPos (coords)
'IF flong<>0 THEN
IF CHA=0 THEN
CHA=1 : actw=WindowFromPoint (coords.x, coords.y)
ELSEIF CHA=1 THEN
CHA=2 : actw=WindowFromPoint (0, 0)
ELSEIF CHA=2 THEN
CHA=3 : actw=GetForegroundWindow ()
ELSEIF CHA=3 THEN
CHA=4 : actw=GetActiveWindow ()
ELSEIF CHA=4 THEN
CHA=0 : actw=WindowFromPoint (0, -5)
END IF
IF actw<>0 THEN
flong=GetClassName (actw, buf, 50)
IF flong<>0 THEN
flong=INSTR(buf, "SysListView32")
IF flong>0 THEN
'IS DESKTOP
ELSE
flong=GetClassName (actw, buf, 50)
IF flong>0 THEN
flong=GetWindowRect (actw, rect0)
IF flong=TRUE THEN
WINLEFT=rect0.left : WINTOP=rect0.top : WINRIGHT=rect0.right : WINBOTTOM=rect0.bottom
WWIDTH=WINRIGHT-WINLEFT : WHEIGHT=WINBOTTOM-WINTOP
flong=GetWindowLong (actw, GWL_STYLE)
IF flong<>0 THEN
flong=(flong AND WS_SIZEBOX)
IF flong=WS_SIZEBOX THEN
Check_WSize : Double_Check
ELSE
flong=(flong AND WS_MINIMIZEBOX)
IF flong=WS_MINIMIZEBOX THEN
Check_WSize : Double_Check
ELSE
flong=(flong AND WS_MAXIMIZEBOX)
IF flong=WS_MAXIMIZEBOX THEN
Check_WSize : Double_Check
ELSE
flong=(flong AND WS_MINIMIZE)
IF flong=WS_MINIMIZE THEN
Check_WSize : Double_Check
ELSE
flong=(flong AND WS_MAXIMIZE)
IF flong=WS_MAXIMIZE THEN
Check_WSize : Double_Check
ELSE
flong=(flong AND WS_POPUP)
IF flong=WS_POPUP THEN
Check_WSize : Double_Check
ELSE
flong=(flong AND WS_CHILD)
IF flong=WS_CHILD THEN
Check_WSize : Double_Check
ELSE
flong=(flong AND WS_BORDER)
IF flong=WS_BORDER THEN
Check_WSize : Double_Check
ELSE
flong=(flong AND WS_DLGFRAME)
IF flong=WS_DLGFRAME THEN
Check_WSize : Double_Check
ELSE

END IF
END IF
END IF
END IF
END IF
END IF
END IF
END IF
END IF
flong=INSTR(buf, "Notepad")
IF flong>0 THEN
Check_WSize : Double_Check
END IF
flong=INSTR(buf, "OpusApp")
IF flong>0 THEN
Check_WSize : Double_Check
END IF
flong=INSTR(buf, "IEFrame")
IF flong>0 THEN
Check_WSize : Double_Check
END IF
flong=INSTR(buf, "#32770")
IF flong>0 THEN
Check_WSize : Double_Check
END IF

ELSE
'GETWINLONG
END IF
ELSE
'GETWINDRECT
END IF
ELSE
'NO classname
END IF
ELSE
'NOT DESKTOP
END IF
ELSE
'no class
END IF
ELSE
'WNDWFROMPOINT
END IF
'ELSE
'GETCURPOS
'END IF
CL=0
END SUB

SUB TimerOff
sTimer.Enabled=0
END SUB

SUB TimerOn
sTimer.Enabled=1
END SUB

SUB Cleanup
UnRegisterHotKey(Window2.Handle, 0)
UnRegisterHotKey(Window2.Handle, 1)
UnRegisterHotKey(Window2.Handle, 2)
Application.Terminate
END SUB

SUB FormWndProc (hWnd&, uMsg&, wParam&, lParam&)
IF uMsg&=WM_HOTKEY THEN
FInt=lParam& AND &H11110000
IF (FInt=1114112 OR FInt=1048576) THEN
ShowMessage("Quitting Window Sizer V2.05")
Cleanup
ELSEIF FInt=0 THEN
TimerOff
'ShowMessage("Window Sizer V2.05 has been Disabled")
ELSEIF FInt=65536 THEN
TimerOn
'ShowMessage("Window Sizer V2.05 has been Enabled")
END IF
END IF
END SUB

Window2.Top=0 : Window2.Left=0 : Window2.Width=0 : Window2.Height=0
Window2.BorderStyle=0 : Window2.WindowState=0 : Window2.FormStyle=0
Window2.Color=&H000000 : Window2.Caption=myFormName : Window2.Visible=0
Window2.WndProc=FormWndProc : Window2.OnShow=Blank_Window

actw=window2.handle

sTimer.Interval=1 : sTimer.Enabled=1 : sTimer.OnTimer=TimerOver

IF RegisterHotKey(Window2.Handle, 0, MOD_CTRL OR MOD_ALT, 81)=0 THEN
IF RegisterHotKey(Window2.Handle, 0, MOD_CTRL OR MOD_ALT, 88)=0 THEN
ShowMessage("Could not allocate a QUIT HotKey.")
END IF
END IF

IF RegisterHotKey(Window2.Handle, 1, MOD_CTRL OR MOD_ALT, 69)=0 THEN
IF RegisterHotKey(Window2.Handle, 1, MOD_CTRL OR MOD_ALT, 79)=0 THEN
ShowMessage("Could not allocate a DISABLE HotKey.")
END IF
END IF

IF RegisterHotKey(Window2.Handle, 2, MOD_CTRL OR MOD_ALT, 68)=0 THEN
IF RegisterHotKey(Window2.Handle, 2, MOD_CTRL OR MOD_ALT, 70)=0 THEN
ShowMessage("Could not allocate a ENABLE HotKey.")
END IF
END IF

DO : DoEvents : LOOP

'Window2.ShowModal
