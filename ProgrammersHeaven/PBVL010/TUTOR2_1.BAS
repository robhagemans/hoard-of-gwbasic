'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: TUTOR2_1.BAS                                                   Ё
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

' д Ч 2.1.1 - INCLUDING THE "EVENT DRIVER" ROUTINES ддддддддддддддддддддддд

$INCLUDE "EVENT.BI"

	APP.GRAPHICSMODE = 1                    ' adds graphical mapping
	APP.ATTR = &H80                         ' sets desktop color
	APP.PATTERN = 32                        ' sets desktop fill pattern

	APPTITLE &HF0, "TUTOR2_1.BAS - AN EVENT-DRIVEN PROGRAM"

	APPINIT

	AuntEdna = WINOPEN(10, 40, &H47, 1, &H4F, "AUNT EDNA'S - PRESS <ESC> TO END", &HE0, %SHADOW)
	WINSHOW AuntEdna, 0, 0, 25, 80

	WINPRINT AuntEdna, 5, 13, &H4F, "Hello Aunt Edna"

	DO      ' entering the "event loop

' д Ч 2.1.2 - CALLING "GETEVENT() дддддддддддддддддддддддддддддддддддддддд

		EventID = GETEVENT(0)

		SELECT CASE EventID

			CASE 17                 ' "No Event" event
				WINWRITE AuntEdna, "waiting...  "

			CASE 102                ' <ESC> key event
				EXIT DO

			CASE ELSE               ' Other events

		END SELECT

	LOOP

' д Ч LEAVING THE "EVENT LOOP" дддддддддддддддддддддддддддддддддддддд

	WINCLOSE AuntEdna

	APPCLOSE

	END

