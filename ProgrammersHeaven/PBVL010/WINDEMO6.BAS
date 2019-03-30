'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³    FILE: WINDEMO6.BAS                                                   ³
'³ PURPOSE: PB/VISION(tm) LITE Example Program                             ³
'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
'³ For instant help on any PB/VISION(tm) keyword, place the cursor on that ³
'³ keyword and press <CTRL-F1>.  The PB/VISION(tm) index can be accessed   ³
'³ by pressing <SHIFT-F1> twice.  The file "PBVLITE.PBH" _must_ be in the  ³
'³ same directory as the PowerBASIC IDE (PB.EXE) for this feature to work  ³
'³ properly.                                                               ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

'       ==================================================
'       BE SURE TO RUN "DEMO.EXE" FOR INFORMATION ON OTHER
'       PowerBASIC 3.0 TOOLS FROM DSE SOFTWARE PUBLISHING.
'       ==================================================

%ISPBU = 0

%cmNextWindow = 1001
%cmCloseWindow = 1002

$INCLUDE ".\WINDOW.BI"
$INCLUDE ".\MOUSE.BI"
$INCLUDE ".\EVENT.BI"

	DEFINT A-Z
	$DYNAMIC

	DIM CtrlBox AS MENUCOLORTYPE		' for the window control box

	APP.GraphicsMode = 1			' enable graphics mapping
        APP.GraphicsMouse = 1			' enabled graphics mouse

	APPTITLE &HCF, "WINDEMO1.BAS - A PB/VISION(tm) LITE DEMO - PRESS <ESC> TO QUIT"

        APPINIT 				' initialize the desktop

	GottaMouse% = MOUSEINIT(buttons%)	' initialize the rodent
	MOUSECURSORON				' make it visible

	' assign window flags to a single variable to make code easier to read

	myWinFlags = %DRAGBAR OR %SHADOW OR %CONTROL OR %RESIZE OR %MINMAX

        ' open a bunch of windows

	A = WINOPEN (15, 40, &H9F, 1, &H9F, "WINDOW A", &H8F, %VSCROLLBAR OR %HSCROLLBAR OR %DRAGBAR)
	B = WINOPEN (10, 40, &HA7, 1, &HA8, "WINDOW B", &HCF, myWinFlags)
	C = WINOPEN (10, 40, &HF1, 1, &HF1, "WINDOW C", &H8F, myWinFlags)
	D = WINOPEN (10, 40, &HCF, 1, &HCF, "WINDOW EVENT", &HB0, %DRAGBAR OR %SHADOW)

	' add title and slightly modify the DOS output window

	WINTITLE 1, &HE0, "DOS WINDOW (HANDLE = 1)"
	WINMODIFY 1, -1, -1, -1, -1, %DRAGBAR OR %SHADOW

	WINSHOW 1, 11, 36, 10, 40		' display DOS window
	WINSHOW A, 5, 5, 20, 40			' display all of the rest
	WINSHOW B, 8, 25, 10, 30
	WINSHOW C, 5, 40, 10, 30
	WINSHOW D, 2, 2, 10, 40

	HOTKEYADD &H6100, %cmCloseWindow		' trap CTRL-F4
	HOTKEYADD &H4000, %cmNextWindow

	DO
		eventNo = GetEvent(0)

		SELECT CASE eventNo

                	CASE 0			' filter out 'null' events
			CASE 17			' filter out clock ticks

			CASE 102		' detect <ESC> key
				EXIT LOOP	' exit this routine

			CASE 108, 203		' window control box click
				CtrlBox.kolor = &HDADF		' define WINCTRLBOX window
				CtrlBox.borderattr = &HDF
				CtrlBox.titleattr = &H8F
				CtrlBox.highlight = &HF4F0
				CtrlBox.sepbar = &HD0
				CtrlBox.border = 1
				CtrlBox.Flags = %CONTROL OR %SHADOW

                        	WINCTRLBOX WINGET, CtrlBox

			CASE 208, 211		' scroll bar events
				WINSCROLLBARGET WINGET, VPOS, HPOS
				WINWRITELN WINGET, "Horizontal =" + STR$(HPOS) + "%, Vertical =" + STR$(VPOS%) + "%"

                        CASE %cmCloseWindow	' CTRL-F4 pressed
				WINCLOSE WINGET

			CASE %cmNextWindow	' F6 pressed
				WINNEXT

			CASE ELSE		' any other event
				WINWRITELN D, "Event" + STR$(eventNo) + " in window handle" + STR$(WINGET)

		END SELECT
	LOOP

	MOUSECURSOROFF				' hide the rodent
	APPCLOSE				' close the desktop
	END					' end the program
