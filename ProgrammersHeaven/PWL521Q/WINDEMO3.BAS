'    WINDEMO3.BAS - ProWindows(tm) LITE Demo Program

REM $DYNAMIC        ' <= SET UP QUICKBASIC FOR DYNAMIC MEMORY USAGE
DEFINT A-Z          ' <= DEFAULT TO INTEGERS

REM $INCLUDE: 'LITE.BI'       ' <= REQUIRED FOR WINDOW CALLS

' === DEFINE A FEW CONSTANTS

CONST WINMEMSIZE% = 8191      ' <= VIRTUAL WINDOW MEMORY SIZE
CONST SCRNMEMSIZE% = 4096     ' <= SCREEN BUFFER MEMORY SIZE
CONST MAXWINDOWS% = 30        ' <= MAXIMUM NUMBER OF WINDOWS

	CLEAR , , 4096           ' <= SET ASIDE ADDITIONAL "STACK" SPACE

	LOCATE 1, 1

	PreInit                  ' <= PRE-INITIALIZE THE WINDOW MANAGER

' === DIMENSION GLOBAL ARRAYS WITH ABOVE DEFINED CONSTANTS
										 
	REDIM SHARED VirMem(WINMEMSIZE) AS INTEGER    ' <= VIRTUAL MEMORY
	REDIM SHARED scrn(SCRNMEMSIZE) AS INTEGER     ' <= SCREEN MEMORY
	REDIM SHARED vcb(MAXWINDOWS) AS vircb         ' <= VIRTUAL WINDOW INFO
	REDIM SHARED wcb(MAXWINDOWS) AS wincb         ' <= DISPLAYED WINDOW INFO
	REDIM SHARED cursor(MAXWINDOWS) AS cursorTYPE ' <= CURSOR CONTROL ARRAY
	REDIM SHARED wcbndx(MAXWINDOWS) AS INTEGER    ' <= LIST OF HANDLES
	
	InitPro                  ' <= INITIALIZE THE WINDOW MANAGER

	ReCycleMode 1            ' <= ENABLE "VIDEO RECYCLING"
	
	SetEventDelay 18         ' <= SET MAXIMUM EVENT DELAY TIME

	UseDrivers 0, 0, 1       ' <= INSTALL ANY NEEDED DRIVERS

REM  setBWmode 1              ' <= SWITCH TO MONOCHROME MODE

' === DEFINE THE "GLOBAL WINDOW OPTIONS"

	GlobalOptions = SELECTABLE
	
	FillScreen 1, 1, MAXROWS, MAXCOLS, 23, 250, SNOW

	Notice

	' === OPEN A FEW WINDOWS

	OpenWindow 1, 15, 46, attr(15, 4), 1, 1, 1, GlobalOptions
	OpenWindow 2, 15, 46, attr(0, 7), 1, 1, 1, GlobalOptions
	OpenWindow 3, 15, 56, attr(7, 1), 1, 1, 1, GlobalOptions
	OpenWindow 4, 15, 46, attr(15, 2), 1, 1, 1, GlobalOptions

	DisplayWindow 1, 2, 4, 15, 46      ' <= DISPLAY WINDOW #1
	DisplayWindow 2, 4, 13, 15, 46     ' <= #2
	DisplayWindow 3, 6, 23, 15, 46     ' <= #3
	DisplayWindow 4, 8, 33, 15, 46     ' <= #4

	WHILE 1

		IF INKEY$ <> "" THEN          ' <= END IF KEY PRESSED

			FOR Handle = 1 TO 4
				CloseWindow Handle  ' <= CLOSE THE WINDOW
			NEXT
			END

		END IF

		Fore = Fore MOD 15 + 1        ' <= CALCULATE NEW COLOR

		winColor 2, Fore, 7           ' <= CHANGE PRINT COLOR
		winColor 4, Fore, 0

		winPrintLn 2, " ProWindows(tm) - The #1 QuickBASIC Toolbox"    ' <= PRINT TO THE WINDOW
		winPrintLn 2, "Check out our demo of ProWindows(tm) PROFESSIONAL 3.1"
		winPrintLn 2, "<Run DEMO.EXE from the DOS Prompt>"

		winPrint 4, "Hello, World!  "
		
	WEND



