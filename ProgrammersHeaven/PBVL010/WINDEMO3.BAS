'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: WINDEMO3.BAS                                                   Ё
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
$INCLUDE ".\EVENT.BI"

	DEFINT A-Z
	$DYNAMIC

	SHARED Win1%, Win2%, Win3%

	APPTITLE &HE0, "WINDEMO3.BAS - A PB/VISION(tm) LITE DEMO - PRESS <ESC> TO QUIT"

	APP.GraphicsMode = 1

	APPINIT

	winFlags = %SHADOW

	Win1 = WINOPEN(15, 46, &H47, 1, &H4F, "", &H4F, winFlags)
	Win2 = WINOPEN(15, 46, &H70, 1, &H70, "", &H70, winFlags)
	Win3 = WINOPEN(15, 46, &H17, 1, &H17, "", &H17, winFlags)
	Win4 = WINOPEN(15, 46, &HE, 1, &HE, "", &HC, winFlags)

	WINSHOW Win1, 2, 3, 15, 46              ' <= DISPLAY WINDOW
	WINSHOW Win2, 4, 13, 15, 46
	WINSHOW Win3, 6, 23, 15, 46
	WINSHOW Win4, 8, 33, 15, 46

	WHILE INKEY$ = ""

		Fore = Fore MOD 15 + 1		' <= CALCULATE NEW COLOR

		WINCOLOR Win2, attr(Fore, 7)	' <= CHANGE PRINT COLOR
		WINCOLOR Win4, attr(Fore, 0)

		WINREFRESHMODE 0

		WINWRITE Win4, "Hello, World!  "
		WINWRITELN Win3, STRING$(40, Fore + 64)
		WINWRITELN Win2, " PB/VISION(tm) - Software Development System"    ' <= PRINT TO THE WINDOW

		WINREFRESHMODE 1

		WINWRITE Win1, "Hello, World!  "

	WEND

	APPCLOSE
