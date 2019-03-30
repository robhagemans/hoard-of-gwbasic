'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: TUTOR3_3.BAS                                                   Ё
'Ё PURPOSE: PB/VISION(tm) LITE Tutorial Example Program                    Ё
'цддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
'Ё For instant help on any PB/VISION(tm) keyword, place the cursor on that Ё
'Ё keyword and press <CTRL-F1>.  The PB/VISION(tm) index can be accessed   Ё
'Ё by pressing <SHIFT-F1> twice.  The file "PBVLITE.PBH" _must_ be in the  Ё
'Ё same directory as the PowerBASIC IDE (PB.EXE) for this feature to work  Ё
'Ё properly.                                                               Ё
'юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

%ISPBU = 0

$INCLUDE "WINDOW.BI"
$INCLUDE "MOUSE.BI"
$INCLUDE "EVENT.BI"

	DEFINT A-Z
	$DYNAMIC

	%cmColorChange = 1001

	SHARED windowColor%

	APPTITLE &HCF, "TUTOR3_3.BAS - A PB/VISION(tm) LITE DEMO - PRESS <ESC> TO QUIT"

	APP.GraphicsMode = 1
	APP.GraphicsMouse = 1

	APPINIT

	GottaMouse% = MOUSEINIT(buttons%)
	MOUSECURSORON

	win1 = WINPOPUP (12, 0, 10, 40, &H9F, 1, &H9F, "OUTPUT WINDOW", &H8F, %DRAGBAR OR %SHADOW OR %NOHORZBORDER OR %NOVERTBORDER)

' - Ч 3.3.1 - MAKING THE CODE MORE READABLE дддддддддддддддддддддддддддддд

	PENWINDOW.INIT

	DO
		EventNo = GETEVENT(0)

		SELECT CASE EventNo

			CASE 102                        ' <ESC> event
				EXIT LOOP

			CASE %cmColorChange
				WINRECOLOR win1, windowColor%
				WINCOLOR win1, windowColor%
				WINWRITE win1, " Window color change... "

			CASE ELSE

		END SELECT

	LOOP

	MOUSECURSOROFF
	APPCLOSE
	END


SUB PENWINDOW.INIT

	windowColor% = &H9F

	handle = WINOPEN (6, 61, &H70, 1, &H7F, "PENWINDOW.ROUTINE() WINDOW", &HE0, %DRAGBAR OR %SHADOW)

	WINDRAWBOX handle%, 1, 1, 3, 54, &H7F70, 1
	WINDRAWBOX handle%, 1, 55, 3, 7, &H7F70, 1
	WINPRINT handle%, 4, 2, -1, "Foreground"
	WINPRINT handle%, 6, 2, -1, "Background"

	WINSHOW handle%, 2, 0, 25, 80

	WININSTALLCODE handle%, CODESEG(PENWINDOW.ROUTINE), CODEPTR(PENWINDOW.ROUTINE)

	PENWINDOW.ROUTINE handle%, 202, 999, 999	' dummy call

END SUB


FUNCTION PENWINDOW.ROUTINE% (BYVAL handle%, BYVAL EventNo%, BYVAL row%, BYVAL col%)

	DIM fore AS BYTE
	DIM back AS BYTE

	fore = windowColor% AND &HF		' decode old window color
	back = (windowColor% AND &HF0) \ 16

	SELECT CASE EventNo%

		CASE 102
			WINCLOSE handle
			EventNo = 0

' - Ч RESPONDING TO WINDOW CLICKS (EVENT #202) ддддддддддддддддддддддддддд

		CASE 202

			SELECT CASE col

				CASE 13 TO 60, 999

					c = (col - 13) \ 3

					SELECT CASE row

						CASE 4
							fore = c
						CASE 6
							back = c
						CASE 999

						CASE ELSE
							EXIT FUNCTION
					END SELECT

					windowColor% = attr(fore, back)

					WINREFRESHMODE 0

					FOR b = 0 TO 15
						WINFILL handle, 4, b * 3 + 13, 3, 3, attr(15 - b, b), 32
					NEXT

					WINPRINT handle, 5, 2, -1, STRING$(59, 196)
					WINPRINT handle, 4, fore * 3 + 14, attr(15 - fore, fore), "Ч"
					WINPRINT handle, 6, back * 3 + 14, attr(15 - back, back), "Ч"
					WINPRINT handle, 2, 56, -1, "&H" + RIGHT$("00" + HEX$(windowColor%), 2)
					WINPRINT handle, 2, 3, windowColor%, SPACE$(50)
					WINPRINT handle, 2, 20, windowColor%, "SAMPLE TEXT"

					WINREFRESHMODE 1

					WINREFRESH handle

' - Ч RETURNING A MODIFIED EVENT CODE дддддддддддддддддддддддддддддддддддд

					EventNo = %cmColorChange

			END SELECT

		CASE 203
			WINCLOSE handle%

		CASE ELSE

	END SELECT

	PENWINDOW.ROUTINE% = EventNo

END FUNCTION

