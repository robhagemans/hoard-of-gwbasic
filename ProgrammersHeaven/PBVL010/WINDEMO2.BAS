'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: WINDEMO2.BAS                                                   Ё
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

	APPTITLE &HE0, "WINDEMO2.BAS - A PB/VISION(tm) LITE DEMO - PRESS <ESC> TO QUIT"

	APP.GraphicsMode = 1

	APPINIT

	winFlags = %SHADOW

	Win1 = WINOPEN (22, 76, attr(15,9), 1, attr(15, 9), "WINDOW A", attr(15,8), 0)
	Win2 = WINOPEN (22, 76, attr(0,10), 1, attr(0, 10), "WINDOW B", attr(15,12), winFlags)
	Win3 = WINOPEN (22, 76, attr(7,1), 1, attr(7, 1), "WINDOW C", attr(0,14), winFlags)
	Win4 = WINOPEN (10, 35, attr(7,4), 1, attr(15,4), "WINDOW C", attr(15,13), winFlags)

	WINSHOW Win1, 2, 2, 21, 78
	WINSHOW Win2, 5, 5, 12, 24
	WINSHOW Win3, 7, 52, 12, 24
	WINSHOW Win4, 12, 23, 10, 35

	OPEN "VENDINFO.DIZ" FOR INPUT AS 1

	FOR X = 1 TO 21
		LINE INPUT #1, A$
		WINWRITELN win1, A$
		WINWRITELN win2, A$
		WINWRITELN win3, A$
	NEXT

	CLOSE 1

	row = 1
	col = 1

	WHILE INKEY$ = ""

		SELECT CASE row
			CASE 1
				cdirection = 1
			CASE 9
				rdirection = 0
				cdirection = -1
			CASE ELSE

		END SELECT

		col = col + cdirection

		SELECT CASE col
			CASE 1
				rdirection = -1
				cdirection = 0
			CASE 55
				cdirection = 0
				rdirection = 1
			CASE ELSE

		END SELECT

		row = row + rdirection

		IF (row = 1) AND (col = 1) THEN
			rdirection = 0
			cdirection = 0
		END IF

		WINREFRESHMODE 0		' <= DISABLE WINDOW REFRESHING

		WINVIEWPORT Win2, row, col	' <= ADJUST WINDOW VIEWPORT
		WINVIEWPORT Win3, row, col

		WINWRITECHAR win4, 65 + INT(RND*26)

		WINREFRESHMODE 1		' <= RE-ENABLE WINDOW REFRESHING

		WINREFRESH Win1			' <= UPDATE THE WINDOW(S)

	WEND

	WINCLOSE Win1
	WINCLOSE Win2				' <= CLOSE OUR WINDOWS
	WINCLOSE Win3

	APPCLOSE

	END
