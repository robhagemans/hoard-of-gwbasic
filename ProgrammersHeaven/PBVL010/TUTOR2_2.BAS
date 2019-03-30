'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³    FILE: TUTOR2_2.BAS                                                   ³
'³ PURPOSE: PB/VISION(tm) LITE Tutorial Example Program                    ³
'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
'³ For instant help on any PB/VISION(tm) keyword, place the cursor on that ³
'³ keyword and press <CTRL-F1>.  The PB/VISION(tm) index can be accessed   ³
'³ by pressing <SHIFT-F1> twice.  The file "PBVLITE.PBH" _must_ be in the  ³
'³ same directory as the PowerBASIC IDE (PB.EXE) for this feature to work  ³
'³ properly.                                                               ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

%ISPBU = 0

DEFINT A-Z
$DYNAMIC

$INCLUDE ".\WINDOW.BI"
$INCLUDE ".\EVENT.BI"           ' Event-driven programs require this

	APP.GRAPHICSMODE = 1                    ' adds graphical mapping
	APP.ATTR = &H80                         ' sets desktop color
	APP.PATTERN = 32                        ' sets desktop fill pattern

	APPTITLE &HF0, "TUTOR2_2.BAS - RESPONDING TO GENERIC KEYS"

	APPINIT

	AuntEdna = WINOPEN(10, 60, &H4F, 1, &H4F, "AUNT EDNA'S - PRESS <ESC> TO END", &HE0, %SHADOW)
	WINSHOW AuntEdna, 0, 0, 25, 80

	DO

		EventID = GETEVENT(0)

		IF EventID <> 17 THEN

			' ignore event #17

			WINWRITE AuntEdna, "Event" + STR$(EventID) + " - "

		END IF

		SELECT CASE EventID

			CASE 17                 ' "No Event" event

' Ä ş 2.2.1 - RESPONDING TO ALPHA-NUMERIC KEYS ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

			CASE 100
				IF (KEYGET < 256) AND (KEYGET > 0) THEN
					WINWRITELN AuntEdna, CHR$(34,KEYGET,34) + " was pressed."
				ELSE
					WINWRITELN AuntEdna, "some other key was pressed."
				END IF

' Ä ş 2.2.2 - RESPONDING TO BUILT-IN KEYBOARD EVENTS ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

			CASE 101                ' CR
				WINWRITELN AuntEdna, "<CR> was pressed."

			CASE 102                ' ESC
				EXIT DO

' Ä ş 2.2.3 - <F1> IS THE BUILT-IN "HELP" KEY ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

			CASE 103                ' F1
				WINWRITELN AuntEdna, "<F1> (Help) was pressed."

			CASE 104                ' TAB
				WINWRITELN AuntEdna, "<TAB> was pressed."

			CASE 105                ' SHIFT-TAB
				WINWRITELN AuntEdna, "<SHIFT-TAB> was pressed."

			CASE 106                ' ALT-TAB
				WINWRITELN AuntEdna, "<ALT-TAB> was pressed."

			CASE 107                ' CTRL-TAB
				WINWRITELN AuntEdna, "<CTRL-TAB> was pressed."

			CASE 108                ' ALT-SPACE
				WINWRITELN AuntEdna, "<ALT-SPACE> was pressed."

			CASE ELSE               ' Other events
				WINWRITELN AuntEdna, "Other event (don't worry about it yet)"

		END SELECT

	LOOP

	WINCLOSE AuntEdna

	APPCLOSE

	END

