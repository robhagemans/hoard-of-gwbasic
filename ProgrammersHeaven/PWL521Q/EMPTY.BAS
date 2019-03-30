'    EMPTY.BAS - ProWindows(tm) Starter Shell for User Programs

REM $DYNAMIC      
DEFINT A-Z

REM $INCLUDE: 'LITE.BI'     

CONST WINMEMSIZE% = 8191      ' <= WINDOW MEMORY SIZE
CONST SCRNMEMSIZE% = 4096     ' <= SCREEN MEMORY SIZE
CONST MAXWINDOWS% = 30        ' <= MAX NUMBER OF WINDOWS

	CLEAR , , 4096

	LOCATE 1, 1

	PreInit                  ' <= PRE-INITIALIZE THE WINDOW MANAGER

	REDIM SHARED VirMem(WINMEMSIZE) AS INTEGER    ' <= VIRTUAL MEMORY
	REDIM SHARED scrn(SCRNMEMSIZE) AS INTEGER     ' <= SCREEN MEMORY
	REDIM SHARED vcb(MAXWINDOWS) AS vircb         ' <= VIRTUAL WINDOW INFO
	REDIM SHARED wcb(MAXWINDOWS) AS wincb         ' <= DISPLAYED WINDOW INFO
	REDIM SHARED cursor(MAXWINDOWS) AS cursorTYPE ' <= CURSOR CONTROL ARRAY
	REDIM SHARED wcbndx(MAXWINDOWS) AS INTEGER    ' <= LIST OF HANDLES

	CLS
	
	InitPro                  ' <= INITIALIZE THE WINDOW MANAGER
	
	ReCycleMode 1            ' <= ENABLE "VIDEO RECYCLING"
	
	SetEventDelay 18         ' <= SET EVENT DELAY TIME (1 SECOND)

	UseDrivers 0, 0, 1       ' <= INSTALL CURSOR DRIVER

	FillScreen 1, 1, MAXROWS, MAXCOLS, 23, 250, SNOW

	Notice

	MouseInstalled = CheckMouse(buttons)
	MouseCursorOn

Main:

	DO

		SELECT CASE GetEvent(0)  ' <= POLL THE EVENT MANAGER

			CASE 16             ' <= WAS <ESC> PRESSED?
				IF MouseInstalled THEN
					MouseCursoroff
					termMouse
					ResetVideo
				END IF
				END

			CASE 17             ' <= EVENT TIME-OUT

			CASE ELSE           ' <= SKIP OTHER EVENTS

		END SELECT

	LOOP

