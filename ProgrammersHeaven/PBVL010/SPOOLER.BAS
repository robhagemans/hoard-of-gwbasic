'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё    FILE: SPOOLER.BAS                                                    Ё
'Ё PURPOSE: PB/VISION(tm) LITE Example Program                             Ё
'цддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
'Ё PURPOSE: Demonstrates how the "TimerInstallCode()" routine can be used  Ё
'Ё          as the engine for a printer spooler.                           Ё
'цддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
'Ё For instant help on any PB/VISION(tm) keyword, place the cursor on that Ё
'Ё keyword and press <CTRL-F1>.  The PB/VISION(tm) index can be accessed   Ё
'Ё by pressing <SHIFT-F1> twice.  The file "PBVLITE.PBH" _must_ be in the  Ё
'Ё same directory as the PowerBASIC IDE (PB.EXE) for this feature to work  Ё
'Ё properly.                                                               Ё
'юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

'       ==================================================
'	BE SURE TO RUN "DEMO.EXE" FOR INFORMATION ON OTHER
'       PowerBASIC 3.0 TOOLS FROM DSE SOFTWARE PUBLISHING.
'       ==================================================

%ISPBU = 0

$INCLUDE ".\WINDOW.BI"
$INCLUDE ".\EVENT.BI"
$INCLUDE ".\MOUSE.BI"

	$STACK 8192

	DEFINT A-Z
	$DYNAMIC

	%EndOfFile = 1001

	SHARED SH%, A, B, C, D, SpoolFile

	SPOOLER.INIT		' initialize the demo interface
	SPOOLER.RUN		' run the interface
	SPOOLER.DONE		' terminate program

	END

SUB SPOOLER.INIT

	filename$ = COMMAND$		' read file name from command line

	IF LEN(filename$) = 0 THEN
		CLS
		PRINT "Syntax: SPOOL filename.txt
		END
	ELSE
        	SpoolFile = FREEFILE
		OPEN filename$ FOR INPUT AS SpoolFile
	END IF

	app.GraphicsMouse = 1
	app.GraphicsMode = 1

	APPTITLE &H70, "SPOOLER.BAS - HOW TO DO PRINT SPOOLING FROM PB/VISION(tm)

	APPINIT

	GottaMouse% = MOUSEINIT(buttons%)	' initizlize mouse
	MOUSECURSORON                 		' turn it on

	A = WINPOPUP (3,  5, 10, 40, &H9F, 1, &H9F, "SPOOLER.BAS", &HE0, %DRAGBAR OR %SHADOW)
	B = WINPOPUP (5, 10, 10, 40, &HA7, 1, &HA8, "SPOOLER.BAS", &HCF, %DRAGBAR OR %SHADOW)
	C = WINPOPUP (7, 15, 10, 40, &HF1, 1, &HF1, "SPOOLER.BAS", &H9F, %DRAGBAR OR %SHADOW)
	D = WINPOPUP (9, 20, 10, 40, &HCF, 1, &HCF, "SPOOLER.BAS", &HB0, %DRAGBAR OR %SHADOW)

	WINWRITELN D, "Spooling " + filename$

	TIMERINSTALLCODE CODESEG(SpoolRoutine), CODEPTR(SpoolRoutine)

END SUB

SUB SPOOLER.RUN

	DO
		eventNo = GetEvent(0)

		SELECT CASE eventNo

			CASE 102
				CLOSE #SpoolFile
				EXIT SUB

			CASE %EndOfFile
				WINWRITELN D, "End of file"
				TIMERINSTALLCODE 0, 0
				CLOSE #SpoolFile

		END SELECT

	LOOP

END SUB

SUB SPOOLER.DONE
	MOUSECURSOROFF
	APPCLOSE
	END
END SUB

FUNCTION SpoolRoutine% (BYVAL UpdateOk%) PUBLIC

	IF EOF(SpoolFile) THEN
		SpoolRoutine = %EndOfFile
		EXIT FUNCTION
	END IF

	LINE INPUT #SpoolFile, text$

	LPRINT text$

END FUNCTION
