'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: WINDEMO5.BAS                                                   Ё
'Ё PURPOSE: PB/VISION(tm) LITE Example Program                             Ё
'цддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
'Ё For instant help on any PB/VISION(tm) keyword, place the cursor on that Ё
'Ё keyword and press <CTRL-F1>.  The PB/VISION(tm) index can be accessed   Ё
'Ё by pressing <SHIFT-F1> twice.  The file "PBVLITE.PBH" _must_ be in the  Ё
'Ё same directory as the PowerBASIC IDE (PB.EXE) for this feature to work  Ё
'Ё properly.                                                               Ё
'юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

'       ==================================================
'       BE SURE TO RUN "DEMO.EXE" FOR INFORMATION ON OTHER
'       PowerBASIC 3.0 TOOLS FROM DSE SOFTWARE PUBLISHING.
'       ==================================================

%ISPBU = 0

$INCLUDE ".\WINDOW.BI"
$INCLUDE ".\MOUSE.BI"
$INCLUDE ".\EVENT.BI"

	DEFINT A-Z
	$DYNAMIC

	SHARED win1%

	APPTITLE &HCF, "WINDEMO6.BAS - A PB/VISION(tm) LITE DEMO - PRESS <ESC> TO QUIT"

	APP.GraphicsMode = 1
        APP.GraphicsMouse = 1

	APPINIT

	GottaMouse% = MOUSEINIT(buttons%)
	MOUSECURSORON

	winFlags = %DRAGBAR OR %SHADOW OR %RESIZE OR %MINMAX OR %VSCROLLBAR OR %HSCROLLBAR OR %AUTOSCROLL

	win1% = WINOPEN (50, 128, &H9F, 1, &H9F, "WINDOW WITH AUTO-SCROLL ENABLED", &H8F, winFlags)

	FOR row = 1 TO 50
        	FOR col = 1 TO 31
			WINPRINT win1%, row, col * 4 - 3 , -1, USING$("####", row + col)
		NEXT
	NEXT

	WINPRINT win1, 1, 1, -1, "Use cursor keys or mouse to scroll window."

	WINSHOW win1%, 0, 0, 18, 70

	DO
		eventNo = GetEvent(0)

		SELECT CASE eventNo

			CASE 102			' <= <ESC>
				EXIT LOOP

			CASE 217
				WINNORMALIZE win1%

			CASE ELSE

		END SELECT
	LOOP

	MOUSECURSOROFF
	APPCLOSE
	END
