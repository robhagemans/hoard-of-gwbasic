'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: WINDEMO4.BAS                                                   Ё
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

	DIM Handle%(1 TO 25)

	APPTITLE &HCF, "WINDEMO4.BAS - A PB/VISION(tm) LITE DEMO - PRESS <ESC> TO QUIT"

	APP.GraphicsMode = 1

	APPINIT

	winFlags = %SHADOW

	FOR H% = 1 TO 25

		kolor = INT(RND*256)

		Handle(H%) = WINOPEN (5, 32, kolor, 1, kolor, "", kolor, winFlags)

		WINPRINT Handle(H%), 2, 10, -1, "PB/VISION(tm)"
		WINPRINT Handle(H%), 3, 2, -1, "The World's Greatest Toolbox"
		WINPRINT Handle(H%), 4, 7, -1, "for PowerBASIC 3.0"

		WINSHOW Handle(H%), INT(RND*20)+1, INT(RND*47)+1, 5, 32

	NEXT

	WHILE INKEY$ = ""

		H% = INT(RND * 25) + 1		' <= PICK A RANDOM WINDOW HANDLE

		WINREFRESHMODE 0			' <= DISABLE REFRESH FOR A MOMENT

		WINMOVE Handle(H%), INT(RND*20)+1, INT(RND*47)+1

		WINREFRESHMODE 1			' <= TURN REFRESH BACK ON

		WINMAIN Handle(H%)			' <= BRING A WINDOW TO THE TOP

	WEND

	FOR H% = 1 TO 25
		WINCLOSE Handle(H%)			' <= CLOSE WINDOWS IN ORDER OF LEVEL
	NEXT

	APPCLOSE						' <= SHUT DOWN PB/VISION
