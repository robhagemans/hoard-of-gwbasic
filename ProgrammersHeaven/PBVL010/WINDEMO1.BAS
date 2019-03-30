'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: WINDEMO1.BAS                                                   Ё
'Ё PURPOSE: PB/VISION(tm) LITE Example Program                             Ё
'цддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
'Ё For instant help on any PB/VISION(tm) keyword, place the cursor on that Ё
'Ё keyword and press <CTRL-F1>.  The PB/VISION(tm) index can be accessed   Ё
'Ё by pressing <SHIFT-F1> twice.  The file "PBVLITE.PBH" _must_ be in the  Ё
'Ё same directory as the PowerBASIC IDE (PB.EXE) for this feature to work  Ё
'Ё properly.                                                               Ё
'юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

'	==================================================
'	BE SURE TO RUN "DEMO.EXE" FOR INFORMATION ON OTHER
'       PowerBASIC 3.0 TOOLS FROM DSE SOFTWARE PUBLISHING.
'	==================================================

%ISPBU = 0

$INCLUDE ".\WINDOW.BI"
$INCLUDE ".\MOUSE.BI"
$INCLUDE ".\EVENT.BI"

	DEFINT A-Z
	$DYNAMIC

	%cmNextWindow = 1001
	%cmCloseWindow = 1002

	DIM CtrlBoxColor AS MenuColorTYPE

	APPTITLE &HCF, "WINDEMO5.BAS - A PB/VISION(tm) DEMO - PRESS <ESC> TO QUIT"

	app.GraphicsMode = 1
	app.GraphicsMouse = 1

	APPINIT

	GottaMouse% = MOUSEINIT(buttons%)
	MOUSECURSORON

	winFlags = %DRAGBAR OR %SHADOW OR %CONTROL OR %RESIZE OR %MINMAX

	A = WINOPEN (15, 40, &H9F, 1, &H9F, "WINDOW A", &H8F, winFlags)
	B = WINOPEN(10, 40, &HA7, 1, &HA8, "WINDOW B", &HCF, winFlags)
	C = WINOPEN(10, 40, &HF1, 1, &HF1, "WINDOW C", &H8F, winFlags)
	D = WINOPEN (10, 40, &HCF, 1, &HCF, "WINDOW EVENT", &HB0, winFlags)

	WINSHOW A, 6, 5, 20, 40
	WINSHOW B, 0, 0, 10, 30
	WINSHOW C, 4, 40, 10, 30
	WINSHOW D, 2, 2, 10, 40

	WINWRITELN D, "Press <ALT-SPACE>"

	HOTKEYADD &H6100, %cmCloseWindow		' trap CTRL-F4
	HOTKEYADD &H4000, %cmNextWindow

	DO
		eventNo = GetEvent(0)

		SELECT CASE eventNo

                	CASE 0			' filter 'null' events
			CASE 17			' filter timer ticks

			CASE 102		' <= <ESC>
				EXIT LOOP

			CASE 203, 108		' CLICK or ALT-SPACE
				CtrlBoxColor.kolor = &HDADF
				CtrlBoxColor.borderattr = &HDF
				CtrlBoxColor.titleattr = &H8F
				CtrlBoxColor.highlight = &HF4F0
				CtrlBoxColor.sepbar = &HD0
				CtrlBoxColor.border = 1
				CtrlBoxColor.Flags = %CONTROL OR %SHADOW
				WINCTRLBOX WINGET, CtrlBoxColor

			CASE 208, 211
				WINSCROLLBARGET WINGET, VPOS, HPOS
				WINWRITELN WINGET, "Horizontal =" + STR$(HPOS) + "%, Vertical =" + STR$(VPOS%) + "%"

                        CASE 217
				WINNORMALIZE WINGET

                        CASE %cmCloseWindow	' CTRL-F4 pressed
				WINCLOSE WINGET

			CASE %cmNextWindow	' F6 pressed
				WINNEXT

			CASE ELSE
				WINWRITELN D, "Event" + STR$(eventNo) + " in window handle" + STR$(WINGET)

		END SELECT
	LOOP

	MOUSECURSOROFF
	APPCLOSE
	END


