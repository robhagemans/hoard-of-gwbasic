'    WINDEMO1.BAS - ProWindows(tm) LITE Demo Program

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

	CLS
	
	InitPro                  ' <= INITIALIZE THE WINDOW MANAGER

	MouseInstalled = CheckMouse(buttons)    ' <= DETECT AND ENABLE THE MOUSE

	ReCycleMode 1            ' <= ENABLE "VIDEO RECYCLING"
	
	SetEventDelay 18         ' <= SET MAXIMUM EVENT DELAY TIME

	UseDrivers 0, 0, 1       ' <= INSTALL ANY NEEDED DRIVERS

REM  setBWmode 1              ' <= SWITCH TO MONOCHROME MODE

' === DEFINE THE "GLOBAL WINDOW OPTIONS"

	GlobalOptions = SELECTABLE + DRAGBAR + OFFBUTTON + RESIZEBUTTON + AUTOSCROLL

	FillScreen 1, 1, MAXROWS, MAXCOLS, 23, 250, SNOW

	Notice

' === OPEN AND TITLE A FEW WINDOWS

	OpenWindow 1, 10, 60, attr(7, 1), 1, 1, 1, GlobalOptions
	TitleWindow 1, " Window #1ÿ"

	OpenWindow 2, 10, 60, attr(7, 4), 1, 1, 1, GlobalOptions
	TitleWindow 1, " Window #2ÿ"

	OpenWindow 3, 3, 45, attr(15, 2), 1, 1, 1, SELECTABLE + DRAGBAR
	wcprint 1, "The World's Greatest QuickBASIC ToolBox"

' === PRINT SOME TEXT TO THE CURRENT WORKING WINDOW

	SetWindow 1          ' <= WORK ON WINDOW #2

	wprint 1, 2, "F3  - Display window #1"       ' <= PRINT TEXT TO WINDOW
	wprint 2, 2, "F4  - Display window #2"
	wprint 3, 2, "F5  - Move window #1"
	wprint 4, 2, "F6  - Move window #2"
	wprint 5, 2, "F7  - Re-size window #1"
	wprint 6, 2, "F8  - Re-size window #2"
	wprint 7, 2, "F9  - Hide window #1"
	wprint 8, 2, "F10 - Hide window #2"

	SetWindow 2

	wprint 1, 1, ""
	wprint 2, 1, "ÀÄÄÄ Click Up here to Hide"

	wprint 1, 30, ""
	wprint 2, 30, "ÀÄÄÄ Click Over here to Drag"

	wprint 7, 27, " Click Down here to Re-Size ÄÄÄ¿"
	wprint 8, 58, ""

	cwcprint 4, attr(15, 4), "Check out our demo of ProWindows(tm) PROFESSIONAL 3.1"
	cwcprint 5, attr(11, 4), "<Run DEMO.EXE from the DOS Prompt>"

	QuickKey 1, CHR$(0) + CHR$(61)     ' <= ASSIGN <F3> AS A "QUICK KEY"
	QuickKey 2, CHR$(0) + CHR$(62)     ' <= AND <F4>
	QuickKey 3, CHR$(0) + CHR$(63)     ' <= F5
	QuickKey 4, CHR$(0) + CHR$(64)     ' <= F6
	QuickKey 5, CHR$(0) + CHR$(65)     ' <= F7
	QuickKey 6, CHR$(0) + CHR$(66)     ' <= F8
	QuickKey 7, CHR$(0) + CHR$(67)     ' <= F9
	QuickKey 8, CHR$(0) + CHR$(68)     ' <= F10

	FillScreen MAXROWS, 1, 1, 23, 112, 32, SNOW  ' <= COLOR AREA FOR CLOCK

	SetCalendar 0, MAXROWS, 2, attr(11, 2), 1    ' <= PUT A CALENDAR ON SCREEN
	SetClock 0, MAXROWS, 15, attr(14, 2), 1      ' <= PUT A CLOCK ON SCREEN
	
	DisplayWindow 1, 5, 5, 25, 80      ' <= DISPLAY WINDOW #1
	DisplayWindow 2, 11, 17, 25, 80    ' <= AND #2
	DisplayWindow 3, 4, 30, 25, 80     ' <= AND #3

	MouseCursorOn       ' <= TURN ON THE MOUSE CURSOR (if available)
	
	IF MouseInstalled THEN
		PopWindow 14, 28, 5, 40, 112, 21, 0, 0
		wcprint 2, "Mouse Driver Installed"
		SLEEP 2
		RemoveWindow
	END IF

Main:

	DO   ' <= ENTER THE POLLING LOOP

		SELECT CASE GetEvent(0)  ' <= POLL THE EVENT MANAGER

			CASE 15, 16         ' <= WAS <CR> OR <ESC> PRESSED?
				IF MouseInstalled THEN
					MouseCursoroff
					termMouse      ' <= TERMINATE THE MOUSE DRIVER
					ResetVideo     ' <= RESET VIDEO (FOR GRAPHIC MOUSE)
				END IF
				END

			CASE 17             ' <= EVENT LOOP TIME-OUT
				
			CASE 18             ' <= WAS <F1> PRESSED?
				BEEP           ' <= "HELP" KEY IN PROFESSIONAL VERSION

			CASE 19             ' <= A "QUICK KEY" WAS PRESSED
				GOSUB DispatchQuickKey

			CASE ELSE           ' <= SKIP ANY OTHER EVENTS

		END SELECT

	LOOP


DispatchQuickKey:

	SELECT CASE GetEvent(19)
		CASE 1
			MainWindow 1
		CASE 2
			MainWindow 2
		CASE 3
			MoveWindow 1, RND * 15 + 1, RND * 20 + 1
		CASE 4
			MoveWindow 2, RND * 15 + 1, RND * 20 + 1
		CASE 5
			ResizeWindow 1, (RND * 8) + 3, (RND * 68) + 1
		CASE 6
			ResizeWindow 2, (RND * 8) + 3, (RND * 68) + 1
		CASE 7
			HideWindow 1
		CASE 8
			HideWindow 2
		CASE 9
			RefreshWindow 3     ' <= REFRESH WINDOW #3
		CASE ELSE
	END SELECT

	RETURN

