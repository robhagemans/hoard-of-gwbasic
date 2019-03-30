'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: TUTOR1_1.BAS                                                   Ё
'Ё PURPOSE: PB/VISION(tm) LITE Tutorial Example Program                    Ё
'цддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
'Ё For instant help on any PB/VISION(tm) keyword, place the cursor on that Ё
'Ё keyword and press <CTRL-F1>.  The PB/VISION(tm) index can be accessed   Ё
'Ё by pressing <SHIFT-F1> twice.  The file "PBVLITE.PBH" _must_ be in the  Ё
'Ё same directory as the PowerBASIC IDE (PB.EXE) for this feature to work  Ё
'Ё properly.                                                               Ё
'юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

' д Ч 1.1.1 - TELLING POWERBASIC THAT THIS IS A PROGRAM, NOT A UNIT дддддд

	%ISPBU = 0                      ' This means it is a program, not a .PBU

' д Ч 1.1.2 - MAKING OUR PROGRAMS WORK A WHOLE LOT FASTER дддддддддддддддд

	DEFINT A-Z                      ' Use high-speed integer variables
	$DYNAMIC                        ' Use dynamic memory allocation

' д Ч 1.1.3 - INCLUDING THE ROUTINE DEFINITIONS дддддддддддддддддддддддддд

	$INCLUDE ".\WINDOW.BI"          ' Every program requires this line

' д Ч 1.1.4 - TURNING ON PB/VISION ддддддддддддддддддддддддддддддддддддддд

	APPINIT                                 ' Initialize PB/VISION desktop

	LOCATE 12, 30:  PRINT "Hello, World!"   ' just say "hi"

	WHILE INKEY$ = "": WEND                 ' Poll the keyboard

' д Ч 1.1.5 - TURNING OFF PB/VISIONддддддддддддддддддддддддддддддддддддддд

	APPCLOSE                        ' Close PB/VISION and remove desktop

	END

