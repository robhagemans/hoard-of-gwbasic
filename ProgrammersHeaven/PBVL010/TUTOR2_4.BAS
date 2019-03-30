'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: TUTOR2_4.BAS                                                   Ё
'Ё PURPOSE: PB/VISION(tm) LITE Tutorial Example Program                    Ё
'цддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
'Ё For instant help on any PB/VISION(tm) keyword, place the cursor on that Ё
'Ё keyword and press <CTRL-F1>.  The PB/VISION(tm) index can be accessed   Ё
'Ё by pressing <SHIFT-F1> twice.  The file "PBVLITE.PBH" _must_ be in the  Ё
'Ё same directory as the PowerBASIC IDE (PB.EXE) for this feature to work  Ё
'Ё properly.                                                               Ё
'юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

%ISPBU = 0

DEFINT A-Z
$DYNAMIC

$INCLUDE ".\WINDOW.BI"
$INCLUDE ".\EVENT.BI"
$INCLUDE ".\MOUSE.BI"                           ' mouse programs require this

	%cmQuit = 1001                          ' add a "quit" event

	APP.GRAPHICSMODE = 1                    ' adds graphical mapping
	APP.ATTR = &H9F                         ' sets desktop color
	APP.PATTERN = 250                       ' sets desktop fill pattern

' д Ч 2.4.1 - SELECTING THE MOUSE CURSOR STYLE ддддддддддддддддддддддддддд

	APP.GRAPHICSMOUSE = 1

	APPTITLE &HF0, "TUTOR2_4.BAS - RODENT CONTROLLED WINDOWS"

	APPINIT

' д Ч 2.4.2 - MAKING PROGRAMS MOUSE AWARE дддддддддддддддддддддддддддддддд

	gottaRodent = MOUSEINIT(buttons)        ' initialize the critter
	MOUSECURSORON                           ' show the mouse cursor

' д Ч 2.4.3 - MAKING WINDOWS MOUSE AWARE ддддддддддддддддддддддддддддддддд

	flags = %SHADOW OR %DRAGBAR OR %RESIZE

	AuntEdna = WINOPEN(10, 45, &H1B, 1, &H1F, "AUNT EDNA'S RODENT CONTROLED WINDOW", &HE0, flags)
	UncleBob = WINPOPUP(2, 4, 10, 45, &H4A, 1, &H4F, "UNCLE BOB'S RODENT CONTROLED WINDOW", &HB0, flags)
	CousinWillie = WINPOPUP(10, 30, 10, 45, &H7E, 1, &H7F, "COUSIN WILLIE'S WINDOW", &HA0, flags)

	WINSHOW AuntEdna, 0, 0, 25, 80

	HOTKEYADD &H2D00, %cmQuit               ' <ALT-X> event

	DO
		EventID = GETEVENT(0)

		SELECT CASE EventID

			CASE 17                 ' "No Event" event

			CASE 102, %cmQuit       ' <ESC> or <ALT-X>
				EXIT DO

' д Ч 2.4.4 - RESPONDING TO USE EVENTS дддддддддддддддддддддддддддддддддддд

			CASE 202
				WINWRITELN WINGET, "I'm on top of the world. (event #202)"

			CASE 206                ' "move" event
				WINWRITELN WINGET, "Hey, you really move me. (event #206)"

			CASE 207                ' "resize" event
				WINWRITELN WINGET, "I'm not as big as I used to be. (event #207)"

			CASE ELSE               ' Other events

		END SELECT


	LOOP

	WINCLOSE AuntEdna

	APPCLOSE

	END


