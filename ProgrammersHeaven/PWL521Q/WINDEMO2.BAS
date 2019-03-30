'    WINDEMO2.BAS - ProWindows(tm) LITE Demo Program

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

	Notice                   ' <= COPYRIGHT NOTICE (SHAREWARE VERSION ONLY)
	Win1 = CurrentWindow     ' <= GET THE WINDOW'S HANDLE

	CloneWindow Win1         ' <= CLONE "WIN1"
	Win2 = CurrentWindow     ' <= GET THE WINDOW'S HANDLE

	CloneWindow Win1         ' <= CLONE "WIN1"
	Win3 = CurrentWindow     ' <= GET THE WINDOW'S HANDLE

	DisplayWindow Win2, 13, 37, 12, 24      ' <= DISPLAY WINDOW #2
	DisplayWindow Win3, 8, 50, 12, 24       ' <= WINDOW #2

	row = 1: col = 1: WinSize = 3

	WHILE INKEY$ = ""

		SELECT CASE WinSize
			CASE 3
				size = 3
			CASE 12
				size = -3
			CASE ELSE
		END SELECT

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

		RefreshMode DISABLE           ' <= DISABLE WINDOW REFRESHING

		ReAlignWindow Win2, row, col  ' <= ADJUST WINDOW VIEWPORT
		ReAlignWindow Win3, row, col

		RefreshMode ENABLE            ' <= RE-ENABLE WINDOW REFRESHING

		RefreshWindow Win2            ' <= UPDATE THE WINDOW(S)

	WEND

	CloseWindow Win2         ' <= CLOSE OUR WINDOWS
	CloseWindow Win3

	   
	

