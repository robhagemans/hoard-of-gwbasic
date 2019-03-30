' IE Window Maximizer - (C) John White, 2002. All Rights Reserved.
' Written with William Yu`s Rapid-Q Basic Interpreter/Compiler.

$INCLUDE "RAPIDQ.INC"
$OPTIMIZE ON
$APPTYPE GUI
$TYPECHECK ON
$ESCAPECHARS ON

CONST rqClassName="TForm"        '-- Classname for all Rapid-Q programs
CONST myFormName="IE Window Maximizer"
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
CONST WM_HOTKEY=&H312

TYPE pPOINT
x AS LONG
y AS LONG
END TYPE

DECLARE FUNCTION FindWindow LIB "USER32.DLL" ALIAS "FindWindowA" (className AS STRING, windowName AS STRING) AS INTEGER
DECLARE FUNCTION GetCursorPos LIB "USER32.DLL" ALIAS "GetCursorPos" (point as pPOINT) AS LONG
DECLARE FUNCTION WindowFromPoint LIB "USER32.DLL" ALIAS "WindowFromPoint" (xpoint AS LONG, ypoint as long) AS LONG
DECLARE FUNCTION CloseWindow LIB "USER32.DLL" ALIAS "CloseWindow" (hwnd AS LONG) AS LONG
DECLARE FUNCTION MoveWindow LIB "USER32.DLL" ALIAS "MoveWindow" (hwnd AS LONG, x AS LONG, y AS LONG, w AS LONG, h AS LONG, paint AS LONG) AS LONG
DECLARE FUNCTION GetClassName LIB "USER32.DLL" ALIAS "GetClassNameA" (byval hwnd AS LONG, byref lpClassName AS STRING, nMaxCount AS LONG) AS LONG
DECLARE FUNCTION GetActiveWindow LIB "USER32.DLL" ALIAS "GetActiveWindow" () AS LONG
DECLARE FUNCTION GetForegroundWindow LIB "USER32.DLL" ALIAS "GetForegroundWindow" () AS LONG
DECLARE FUNCTION ShowWindow LIB "USER32.DLL" ALIAS "ShowWindow" (hwnd AS LONG, command AS LONG) AS LONG
DECLARE FUNCTION RegisterHotKey LIB "USER32.DLL" ALIAS "RegisterHotKey" (hWnd AS LONG, ID AS LONG, fsModifiers AS LONG, vk AS LONG) AS LONG
DECLARE FUNCTION UnRegisterHotKey LIB "USER32.DLL" ALIAS "UnregisterHotKey" (hWnd AS LONG, ID AS LONG) AS LONG

DECLARE SUB FormWndProc (hWnd&, uMsg&, wParam&, lParam&)
DECLARE SUB Check_Window ()
DECLARE SUB Cleanup ()
DECLARE SUB TimerOff ()
DECLARE SUB TimerOn ()
DECLARE SUB Blank_Window ()

DEFINT hWnd=FindWindow(rqClassName, myFormName)

IF hWnd THEN
ShowMessage ("IE Window Maximizer V1.05 is already running!")
Application.Terminate
END IF

DIM Window2 AS QFORM, sTimer AS QTIMER
DIM FInt AS INTEGER, FLong AS LONG, FWord AS WORD, FByte AS BYTE
DIM File AS QFILESTREAM, FLen AS INTEGER
DIM coords AS pPOINT
DIM buf AS STRING, Stg$ AS STRING
DIM Z AS INTEGER, actw AS LONG, CHA AS BYTE, CL AS BYTE

CL=0 : CHA=0 : buf=STRING$(50, CHR$(0))

SUB Blank_Window
ShowWindow (Application.Handle, 0)
END SUB

SUB TimerOver 
sTimer.Interval=1
'IF CL=0 THEN
Check_Window
'END IF
END SUB

SUB Check_Window (Sender AS QCANVAS)
CL=1
flong=GetCursorPos (coords)
'IF flong<>0 THEN
IF CHA=0 THEN
CHA=1 : actw=WindowFromPoint (coords.x, coords.y)
ELSEIF CHA=1 THEN
CHA=2 : actw=WindowFromPoint (0, 0)
ELSEIF CHA=2 THEN
CHA=3 : actw=GetForegroundWindow ()
ELSEIF CHA=3 THEN
CHA=0 : actw=GetActiveWindow ()
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
flong=INSTR(buf, "IEFrame")
IF flong>0 THEN
ShowWindow (actw, 3)
END IF
END IF
END IF

ELSE
'NO classname
END IF
ELSE
'GETCURPOS
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
ShowMessage("Quitting IE Window Maximizer V1.05")
Cleanup
ELSEIF FInt=0 THEN
TimerOff
'ShowMessage("IE Window Maximizer V1.05 has been Disabled")
ELSEIF FInt=65536 THEN
TimerOn
'ShowMessage("IE Window Maximizer V1.05 has been Enabled")
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
