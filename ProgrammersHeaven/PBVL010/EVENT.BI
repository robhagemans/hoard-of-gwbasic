' PB/VISION(tm) LITE - (c) Copyright 1994 DSE Software Publishing
' SHAREWARE EVALUATION VERSION

$DYNAMIC
DEFINT A-Z

DECLARE FUNCTION GETEVENT% (BYVAL cmd%)
DECLARE SUB HOTKEYADD (BYVAL scancode%, BYVAL eventNo%)
DECLARE SUB HOTKEYTOGGLE (BYVAL scancode%, BYVAL mode%)
DECLARE SUB TimerInstallCode (BYVAL segment%, BYVAL offset%)
DECLARE SUB winCtrlBox (BYVAL winHandle%, menucolor AS menucolorTYPE)
DECLARE SUB winLockAll (BYVAL handle%)
DECLARE FUNCTION winLockState% ()
DECLARE SUB winLockRestore (saveVar%)

 DIM EventDelay AS INTEGER, ForceEvent AS INTEGER
 DIM KEYGET AS INTEGER, HelpContext AS INTEGER

$IF %ISPBU
 EXTERNAL ForceEvent, KEYGET, HelpContext
$ELSE
 PUBLIC ForceEvent, KEYGET, HelpContext
$ENDIF


