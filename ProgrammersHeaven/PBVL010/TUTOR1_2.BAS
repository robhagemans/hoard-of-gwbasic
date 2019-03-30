'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: TUTOR1_2.BAS                                                   Ё
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

	APPINIT

' д Ч 1.2.1 to 1.2.6 - OPENING A NEW WINDOW ддддддддддддддддддддддддддддддд

	AuntEdna = WINOPEN(10, 40, &H10, 1, &H1F, "AUNT EDNA'S HOUSE", &HE0, %SHADOW)

' д Ч 1.2.7 - DISPLAYING AN OPEN WINDOW ддддддддддддддддддддддддддддддддддд

	WINSHOW AuntEdna, 0, 0, 25, 80

' д Ч 1.2.8 - ANOTHER WAY OF OPENING AND DISPLAYING A WINDOW дддддддддддддд

	UncleBob = WINPOPUP(15, 40, 5, 30, &H47, 1, &H4F, "UNCLE BOB'S HOUSE", &HF0, %SHADOW)

' д Ч 1.2.9 - PRINTING TEXT IN A WINDOW ддддддддддддддддддддддддддддддддддд

	WINPRINT AuntEdna, 5, 10, &H1E, "Hello Aunt Edna"
	WINPRINT UncleBob, 2, 2, -1, "Yo! Uncle Bob"

	WHILE INKEY$ = "": WEND

' д Ч 1.2.10 - CLOSING A WINDOW ддддддддддддддддддддддддддддддддддддддддддд

	WINCLOSE AuntEdna
	WINCLOSE UncleBob

	APPCLOSE

	END

