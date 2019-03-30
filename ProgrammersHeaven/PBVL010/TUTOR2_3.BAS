'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: TUTOR2_3.BAS                                                   Ё
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
$INCLUDE ".\EVENT.BI"                   ' Event-driven programs require this

' д Ч 2.3.1 - DEFINING SOME CUSTOM EVENT CODES дддддддддддддддддддддддддд

	%cmF3 = 1001
	%cmF4 = 1002
	%cmAltX = 1003
	%cmPookie = 1004

	APP.GRAPHICSMODE = 1                    ' adds graphical mapping
	APP.ATTR = &H9F                         ' sets desktop color
	APP.PATTERN = 250                       ' sets desktop fill pattern

	APPTITLE &HF0, "TUTOR2_3.BAS - PRESS <ALT-X> TO END THIS PROGRAM"

	APPINIT

	AuntEdna = WINOPEN(10, 40, &H1B, 1, &H1F, "AUNT EDNA'S WINDOW", &HE0, %SHADOW)
	UncleBob = WINPOPUP(2, 4, 10, 40, &H4A, 1, &H4F, "UNCLE BOB'S WINDOW", &HB0, %SHADOW)
	CousinWillie = WINPOPUP(10, 35, 10, 40, &H7E, 1, &H7F, "COUSIN WILLIE'S WINDOW", &HA0, %SHADOW)

	WINSHOW AuntEdna, 0, 0, 25, 80

	WINHOTPRINT AuntEdna, 2, 2, &H1F1E, "Press ~<F3>~ to say 'Hello!'"
	WINHOTPRINT AuntEdna, 4, 2, &H1F1E, "Press ~<F4>~ to changed windows."
	WINHOTPRINT AuntEdna, 6, 2, &H1F1E, "Press ~<ALT-X>~ to end the program."
	WINHOTPRINT AuntEdna, 8, 2, &H1F1E, "Press ~<ALT-P>~ to say 'Hi!' to Pookie."

' д Ч 2.3.2 - ADDING THE CUSTOM EVENTS ддддддддддддддддддддддддддддддддддд

	HOTKEYADD &H3D00, %cmF3                 ' <F3>
	HOTKEYADD &H3E00, %cmF4                 ' <F4>
	HOTKEYADD &H2D00, %cmAltX               ' <ALT-X>
	HOTKEYADD &H1900, %cmPookie             ' <ALT-P>

	DO

		EventID = GETEVENT(0)

		SELECT CASE EventID

' д Ч 2.3.3 - RESPONDING TO CUSTOM EVENTS ддддддддддддддддддддддддддддддддддддддддддд

			CASE %cmF3              ' <F3>
				WINWRITE WINGET, "Hello, Window!  "

			CASE %cmF4              ' <F4>
				WINNEXT

			CASE %cmAltX            ' <ALT-X>
				EXIT DO

			CASE %cmPookie
				WINWRITELN WINGET, "Hi Pookie!"

			CASE 17                 ' no event

			CASE ELSE               ' Other events

		END SELECT

	LOOP

	WINCLOSE AuntEdna

	APPCLOSE

	END

