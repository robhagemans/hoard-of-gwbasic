'    WINDEMO4.BAS - ProWindows(tm) LITE Demo Program

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

	ReCycleMode 0            ' <= ENABLE "VIDEO RECYCLING"
	
	UseDrivers 0, 0, 1       ' <= INSTALL ANY NEEDED DRIVERS

REM  setBWmode 1              ' <= SWITCH TO MONOCHROME MODE

' === DEFINE THE "GLOBAL WINDOW OPTIONS"

	GlobalOptions = SELECTABLE
	
	FillScreen 1, 1, MAXROWS - 1, MAXCOLS, 23, 250, snow
	
	Notice                   ' <= COPYRIGHT NOTICE (SHAREWARE VERSION ONLY)
	Win1 = CurrentWindow     ' <= GET THE WINDOW'S HANDLE

	SoundMode = GLISANDO     ' <= TURN ON CHIRP NOISE

	FOR Handle = 1 TO 25
	
		kolor = attr(RAND(16), RAND(8))

		OpenWindow Handle, 5, 32, kolor, 1, 1, 0, SELECTABLE
		wcprint 1, "ProWindows(tm)"
		wcprint 2, "The World's Greatest Toolbox"
		wcprint 3, "for QuickBASIC & PDS 7.1"
		DisplayWindow Handle, RAND(20), RAND(50), 5, 32

	NEXT

	WHILE INKEY$ = ""
		Handle = RAND(25) + 1
		MainWindow Handle        ' <= BRING A WINDOW TO THE TOP
	WEND
	
	FOR Handle = WI TO 2 STEP -1
		CloseWindow wcbndx(Handle)    ' <= CLOSE WINDOWS IN ORDER OF LEVEL
	NEXT
	
	LOCATE 24, 1

