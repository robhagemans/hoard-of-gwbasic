'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         BASWIZ  Copyright (c) 1990-1992  Thomas G. Hanlin III        |
'   |                                                                      |
'   |                       The BASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DECLARE FUNCTION FEOF% (Handle%)
   DECLARE FUNCTION FReadLn$ (BYVAL Handle%)
   DECLARE SUB FDone ()
   DECLARE SUB FInit (Handles%, ErrCode%)
   DECLARE SUB FOpen (File$, FMode$, BufferLen%, Handle%, ErrCode%)
   DECLARE SUB GetDisplay (Adapter%, Mono%)
   DECLARE SUB WClear (BYVAL Handle%)
   DECLARE SUB WCollapse (Handle%)
   DECLARE SUB WColor (BYVAL Handle%, BYVAL Fore%, BYVAL Back%)
   DECLARE SUB WCopy (BYVAL FromHandle%, BYVAL ToHandle%)
   DECLARE SUB WDone ()
   DECLARE SUB WExplode (Handle%)
   DECLARE SUB WFixColor (BYVAL Convert%)
   DECLARE SUB WFrame (BYVAL Handle%, BYVAL Frame%, BYVAL Fore%, BYVAL Back%)
   DECLARE SUB WGetVSize (BYVAL Handle%, Rows%, Columns%)
   DECLARE SUB WHidden (BYVAL Handle%, Hidden%)
   DECLARE SUB WHide (BYVAL Handle%, BYVAL Hide%)
   DECLARE SUB WInit (Rows%, Columns%, ErrCode%)
   DECLARE SUB WLocate (BYVAL Handle%, BYVAL Row%, BYVAL Column%)
   DECLARE SUB WOpen (Rows%, Columns%, SRow1%, SCol1%, SRow2%, SCol2%, Handle%, ErrCode%)
   DECLARE SUB WPlace (BYVAL Handle%, BYVAL Row%, BYVAL Column%)
   DECLARE SUB WShadow (BYVAL Handle%, Shadow$, BYVAL Fore%, BYVAL Back%)
   DECLARE SUB WSize (BYVAL Handle%, BYVAL Rows%, BYVAL Columns%)
   DECLARE SUB WTitle (BYVAL Handle%, Title$, BYVAL Fore%, BYVAL Back%)
   DECLARE SUB WUpdate ()
   DECLARE SUB WView (BYVAL Handle%, BYVAL Row%, BYVAL Column%)
   DECLARE SUB WWrite (BYVAL Handle%, St$)
   DECLARE SUB WWriteLn (BYVAL Handle%, St$)


   DECLARE FUNCTION Center$ (St$)

   DEFINT A-Z
   Rows = 25: Columns = 80                         ' define display size
   WInit Rows, Columns, ErrCode                    ' initialize VWS
   IF ErrCode THEN                                 ' stop if we couldn't...
      PRINT "Sorry, insufficient memory to run Demo."
      END
   END IF
   FInit 15, ErrCode                               ' initialize file handler
   FOpen "WDEMO.DAT", "RT", 256, TextFile, ErrCode ' open file for Read, Text
   IF ErrCode THEN
      PRINT "Unable to access WDEMO.DAT file."
      FDone
      END
   END IF

   IF INSTR(COMMAND$, "/B") THEN
      Mono = -1
   ELSE
      GetDisplay Adapter, Mono
   END IF
   WFixColor Mono

   Handle0 = 0                                     ' use background handle
   St$ = "Demonstration of The BASIC Wizard's Library"
   WWriteLn Handle0, Center$(St$)
   WWriteLn Handle0, ""
   St$ = "Copyright (c) 1990-1992  Thomas G. Hanlin III"
   WWriteLn Handle0, Center$(St$)
   WWriteLn Handle0, ""
   WWriteLn Handle0, ""
   DO UNTIL FEOF(TextFile)                         ' read text from file and
      WWriteLn Handle0, FReadLn$(TextFile)         ' ...print it to the
   LOOP                                            ' ...virtual screen
   FDone                                           ' terminate file handler
   WLocate Handle0, 25, 1
   St$ = "Press the space bar for a virtual window demonstration."
   WWrite Handle0, Center$(St$)
   WUpdate                                         ' update the display
   DO
   LOOP UNTIL INKEY$ = " "

   ' ------------ This sets up the second demo screen --------------

   WOpen Rows, Columns, 7, 5, 22, 45, Handle1, ErrCode
   IF ErrCode THEN
      PRINT "I'm sorry, there's not enough memory available!"
      WDone
      END
   END IF
   WCopy Handle0, Handle1                          ' copy text to new window
   WColor Handle0, 0, 2                            ' recolor the background
   WClear Handle0                                  ' clear it
   WLocate Handle0, 1, 1                           ' home the cursor
   WWriteLn Handle0, " This is Window #0, the background screen"
   WColor Handle0, 15, 2
   WLocate Handle0, 14, 48
   WWriteLn Handle0, "This is a slow-motion demo!"
   WColor Handle0, 0, 2
   WLocate Handle0, 25, 1
   WWrite Handle0, Center$("Press the <ESC> key to exit")
   WFrame Handle1, 2, 14, 3                        ' set frame (double lines)
   WTitle Handle1, " Window #1 ", 5, 3             ' set title
   WExplode Handle1                                ' "explode" it on

   Rows2 = 10: Columns2 = 40
   Row2 = 9: Col2 = 35
   WOpen Rows2, Columns2, Row2, Col2, 17, 70, Handle2, ErrCode
   IF ErrCode THEN
      PRINT "I'm sorry, there's not enough memory available!"
      WDone
      END
   END IF
   WFrame Handle2, 1, 4, 1                         ' set frame (single lines)
   WTitle Handle2, " Window #2 ", 14, 1            ' set title
   WShadow Handle2, CHR$(255), 8, 0                ' set shadow
   WColor Handle2, 7, 1                            ' set colors
   WClear Handle2                                  ' clear to new colors
   WWriteLn Handle2, "Adding virtual windows to"
   WWriteLn Handle2, "your programs uses only about"
   WWriteLn Handle2, "5K RAM, plus extra memory for"
   WWriteLn Handle2, "each window (around 4K for a"
   WWriteLn Handle2, "full 25x80 virtual screen,"
   WWriteLn Handle2, "which is larger than you'll"
   WWriteLn Handle2, "need for most windows)."
   WWriteLn Handle2, ""
   WWriteLn Handle2, ""
   WWrite Handle2, "                  Look Ma, No Hands!"
   WExplode Handle2                                ' "explode" it on

   St$ = "Just a little BASIC Wizardry..."         ' a tiny one-line window!
   Rows = 1: Columns = LEN(St$) + 1
   WOpen Rows, Columns, 3, 38, 3, 37 + LEN(St$), Handle3, ErrCode
   IF ErrCode THEN
      PRINT "I'm sorry, there's not enough memory available!"
      WDone
      END
   END IF
   WColor Handle3, 15, 4                           ' set color
   WWrite Handle3, St$                             ' no <CR><LF> or it scrolls

   WOpen 2, 10, 16, 14, 17, 23, Handle4, ErrCode
   IF ErrCode THEN
      PRINT "I'm sorry, there's not enough memory available!"
      WDone
      END
   END IF
   WFrame Handle4, 1, 0, 7                         ' set frame (single lines)
   WColor Handle4, 0, 7                            ' set colors
   WClear Handle4                                  ' clear to new colors
   WHide Handle4, 1                                ' hide the window
   WWriteLn Handle4, "  Windows"
   WWrite Handle4, " Can HIDE"

   WUpdate                                         ' pop on the micro windows

   ' ------------- The second screen is on- let's animate it! ------------

   Counter1H = 0                     ' for Window #1
   Direction1H = 1
   Counter1V = 0
   Direction1V = 0
   Counter2A = 0                     ' for Window #2
   Counter2B = 0
   Direction2 = 1
   DO
      ' The following four statements do the main work.  The rest mostly -----
      ' calculates the information for the next step in the animation. -------
      WView Handle1, 1 + Counter1V, 1 + Counter1H                ' set viewport
      WPlace Handle2, Row2 - Counter2B, Col2 + Counter2B         ' screen pos'n
      WSize Handle2, Rows2 - Counter2B, Columns2 - Counter2B * 2 ' window size
      WUpdate                                                    ' display it
      Counter2A = Counter2A + 1
      IF (Counter2A AND 1) = 0 THEN
         Counter2A = 0
         Counter2B = Counter2B + Direction2
         IF Counter2B < 1 OR Counter2B > 5 THEN
            Direction2 = -Direction2
         END IF
      END IF
      Counter1H = Counter1H + Direction1H
      Counter1V = Counter1V + Direction1V
      IF Counter1H < 0 THEN
         Counter1H = 0
         Direction1H = 0
         Direction1V = -1
      ELSEIF Counter1H > 39 THEN
         Counter1H = 39
         Direction1H = 0
         Direction1V = 1
      ELSEIF Counter1V < 0 THEN
         Counter1V = 0
         Direction1V = 0
         Direction1H = 1
         WHidden Handle4, Hidden
         WHide Handle4, NOT Hidden
      ELSEIF Counter1V > 9 THEN
         Counter1V = 9
         Direction1V = 0
         Direction1H = -1
      END IF
      DEF SEG = 0                    ' delay a while so we can see
      t = PEEK(&H46C)                ' what's going on
      WHILE t = PEEK(&H46C): WEND
      t = PEEK(&H46C)
      WHILE t = PEEK(&H46C): WEND
   LOOP UNTIL INKEY$ = CHR$(27)      ' continue until <ESC> is pressed

   ' -------------- All done, time to terminate and exit -----------------

   WCollapse Handle3                 ' collapse windows in mixed order
   WCollapse Handle1
   WCollapse Handle2
   WCollapse Handle4
   WDone                             ' terminate VWS
   junk& = SETMEM(999999)            ' give QB its memory back
   END

FUNCTION Center$ (St$)         ' ------ used for centering lines on the screen
   WGetVSize 0, Rows, Columns                ' get size of display
   IF LEN(St$) > Columns THEN
      Center$ = LEFT$(St$, Columns)          ' truncate if string is too long
   ELSE
      Center$ = SPACE$((Columns - LEN(St$) + 1) \ 2) + St$  ' center it
   END IF
END FUNCTION
