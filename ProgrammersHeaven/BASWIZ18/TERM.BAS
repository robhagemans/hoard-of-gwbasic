'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         BASWIZ  Copyright (c) 1990-1991  Thomas G. Hanlin III        |
'   |                                                                      |
'   |                       The BASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DECLARE FUNCTION FGetSize& (BYVAL Handle%)
   DECLARE FUNCTION TCInkey$ ()
   DECLARE FUNCTION TCInStat% ()
   DECLARE FUNCTION WMenuPopUp% (Handle%, PickList$(), HiFore%, LoFore%)
   DECLARE SUB FClose (Handle%)
   DECLARE SUB FOpen (File$, FMode$, BufferLen%, Handle%, ErrCode%)
   DECLARE SUB GetDisplay (Adapter%, Mono%)
   DECLARE SUB StartXmodemSend (Handle%, Protocol$, Baud$, MaxRec%, Record%, EstTime$, ErrCode%)
   DECLARE SUB TCDone ()
   DECLARE SUB TCDTR (BYVAL State%)
   DECLARE SUB TCInit (Port%, InSize%, OutSize%, ErrCode%)
   DECLARE SUB TCParms (Parity$, WordLength%, StopBits%)
   DECLARE SUB TCSpeed (Bps&)
   DECLARE SUB TCWrite (St$)
   DECLARE SUB WClear (BYVAL Handle%)
   DECLARE SUB WClose (BYVAL Handle%)
   DECLARE SUB WColor (BYVAL Handle%, BYVAL Fore%, BYVAL Back%)
   DECLARE SUB WCursor (BYVAL Handle%, BYVAL CSize%)
   DECLARE SUB WDone ()
   DECLARE SUB WFixColor (BYVAL Convert%)
   DECLARE SUB WFrame (BYVAL Handle%, BYVAL Frame%, BYVAL Fore%, BYVAL Back%)
   DECLARE SUB WGetColor (BYVAL Handle%, Fore%, Back%)
   DECLARE SUB WGetLocate (BYVAL Handle%, Row%, Column%)
   DECLARE SUB WInit (Rows%, Columns%, ErrCode%)
   DECLARE SUB WInput (Handle%, Valid$, ExitCode$, ExtExitCode$, MaxLength%, St$, ExitKey$)
   DECLARE SUB WLocate (BYVAL Handle%, BYVAL Row%, BYVAL Column%)
   DECLARE SUB WOpen (Rows%, Columns%, SRow1%, SCol1%, SRow2%, SCol2%, Handle%, ErrCode%)
   DECLARE SUB WPlace (BYVAL Handle%, BYVAL Row%, BYVAL Column%)
   DECLARE SUB WSize (BYVAL Handle%, BYVAL Rows%, BYVAL Columns%)
   DECLARE SUB WTitle (BYVAL Handle%, Title$, BYVAL Fore%, BYVAL Back%)
   DECLARE SUB WUpdate ()
   DECLARE SUB WWrite (BYVAL Handle%, St$)
   DECLARE SUB WWriteLn (BYVAL Handle%, St$)
   DECLARE SUB XmodemSend (Handle%, Protocol$, MaxRec%, Record%, ErrCount%, ErrCode%)

   DEFINT A-Z

   Rows = 25: Columns = 80                     ' assume 25x80
   GetDisplay Adapter, Mono                    ' get display type
   IF INSTR(COMMAND$, "/43") THEN              ' if /43 switch used...
      IF Adapter = 4 OR Adapter = 6 THEN       ' ...and EGA or VGA...
         WIDTH , 43                            ' ...set 43x80 mode
         Rows = 43
      END IF
   END IF
   IF INSTR(COMMAND$, "/B") THEN Mono = -1
   WFixColor Mono                              ' colors --> mono (if need be)

   WInit Rows, Columns, ErrCode                ' initialize window handler
   IF ErrCode THEN
      PRINT "Error: insufficient memory"
      END
   END IF
   MainWin = 0                                 ' background window handle
   Win = MainWin                               ' same, for ANSIprint routine
   WColor MainWin, 7, 0
   WClear MainWin
   WWriteLn MainWin, "BASWIZ tiny terminal program.  Use Alt-X to exit."
   WWriteLn MainWin, "PgUp to send a file, PgDn to receive one."
   WWriteLn MainWin, ""
   WCursor MainWin, 2                          ' turn on the cursor

   IF INSTR(COMMAND$, "/COM4") THEN            ' if /COM4 switch used...
      CommPort = 4                             ' ...set to COM4
   ELSEIF INSTR(COMMAND$, "/COM3") THEN        ' if /COM3 switch used...
      CommPort = 3                             ' ...set to COM3
   ELSEIF INSTR(COMMAND$, "/COM2") THEN        ' if /COM2 switch used...
      CommPort = 2                             ' ...set to COM2
   ELSE
      CommPort = 1                             ' ...otherwise assume COM1
   END IF
   TCInit CommPort, 1024, 128, ErrCode         ' initialize comm handler
   IF ErrCode THEN
      PRINT "Error: insufficient memory"
      TCDone
      WDone
      END
   END IF

   IF INSTR(COMMAND$, "/300") THEN             ' if /300 switch used...
      Baud$ = "300"                            ' ...speed is 300 bps
   ELSEIF INSTR(COMMAND$, "/1200") THEN        ' if /1200 switch used...
      Baud$ = "1200"                           ' ...speed is 1200 bps
   ELSE
      Baud$ = "2400"                           ' ...else speed is 2400 bps
   END IF
   TCSpeed VAL(Baud$)                          ' set speed
   TCParms "N", 8, 1                           ' no parity, 8 bit words, 1 stop

   Music = (INSTR(COMMAND$, "/QUIET") = 0)     ' handle "ANSI" music setting

   Change = -1                                 ' set screen update flag
   DO
      IF Change THEN                           ' if something changed...
         WUpdate                               ' ...update the display
         Change = 0                            ' ...clear screen update flag
      END IF
      IF TCInStat% THEN                        ' if we've received something...
         St$ = ""
         DO                                    ' ...get and "display" it
            St$ = St$ + TCInkey$
         LOOP WHILE TCInStat%
         GOSUB ANSIprint
         Change = -1                           ' ...set screen update flag
      END IF
      DO                                       ' if a key was pressed...
         ky$ = INKEY$                          ' ...get it
         IF LEN(ky$) = 1 THEN TCWrite ky$      ' ...send it to the comm port
      LOOP WHILE LEN(ky$) = 1
      IF LEN(ky$) = 2 THEN                     ' handle Alt keys
         SELECT CASE ASC(RIGHT$(ky$, 1))       '
            CASE 73: GOSUB SendFile            ' PgUp   (send file)
            CASE 81: GOSUB RecvFile            ' PgDn   (receive file)
            CASE 45: TermDone = -1             ' Alt-X  (exit the program)
            CASE ELSE                          '
         END SELECT                            '
      END IF                                   '
   LOOP UNTIL TermDone

   TCDTR 0                                     ' drop the DTR (hang up)
   TCDone                                      ' terminate comm handler
   WDone                                       ' terminate window handler
   END                                         ' terminate program



SendFile:
   Change = -1
   WOpen 6, 77, 5, 20, 6, 30, SendWin, ErrCode
   WTitle SendWin, "Send File", 7, 0
   WFrame SendWin, 2, 7, 0
   REDIM Pick$(1 TO 2)
   Pick$(1) = " Xmodem"
   Pick$(2) = " Xmodem 1K"
   SELECT CASE WMenuPopUp(SendWin, Pick$(), 0, 7)
      CASE 1
         Protocol$ = "Xmodem"
         RecLen = 128
      CASE 2
         Protocol$ = "Xmodem-1K"
         RecLen = 1024
      CASE ELSE
         WClose SendWin
         RETURN
   END SELECT
   WPlace SendWin, 5, 10
   WSize SendWin, 2, 60
   WClear SendWin
   WLocate SendWin, 1, 1
   File$ = ""
   WWriteLn SendWin, "File to send:"
   WCursor SendWin, 2
   WInput SendWin, "", CHR$(13) + CHR$(27), "", 80, File$, ExitKey$
   WCursor SendWin, 0
   File$ = UCASE$(LTRIM$(RTRIM$(File$)))
   IF LEN(File$) = 0 OR ExitKey$ = CHR$(27) THEN
      WClose SendWin
      RETURN
   END IF
   FOpen File$, "R", 1024, Handle, ErrCode
   IF ErrCode THEN
      WWriteLn MainWin, "--- Unable to open file " + File$
      WClose SendWin
      RETURN
   END IF
   T = INSTR(File$, ":")
   IF T THEN
      Path$ = LEFT$(File$, T)
      File$ = MID$(File$, T + 1)
   ELSE
      Path$ = ""
   END IF
   DO
      T = INSTR(File$, "\")
      IF T THEN
         Path$ = Path$ + LEFT$(File$, T)
         File$ = MID$(File$, T + 1)
      END IF
   LOOP WHILE T
   WPlace SendWin, 5, 20
   WSize SendWin, 6, 40
   WClear SendWin
   WLocate SendWin, 1, 1
   WTitle SendWin, Protocol$ + " Send", 7, 0
   WWriteLn SendWin, "File Path  : " + Path$
   WWriteLn SendWin, "File Name  : " + File$
   WWriteLn SendWin, "Xfer time  :"
   WWriteLn SendWin, "File Size  :" + STR$(FGetSize&(Handle))
   WWriteLn SendWin, "Bytes Sent : 0"
   WWrite SendWin, "Status Msg : Waiting for NAK"
   WUpdate
   StartXmodemSend Handle, Protocol$, Baud$, MaxRec, Record, EstTime$, ErrCode
   IF ErrCode THEN
      WWriteLn MainWin, "--- No response from other computer."
      FClose Handle
      WClose SendWin
      RETURN
   END IF
   WTitle SendWin, Protocol$ + " Send", 7, 0
   WLocate SendWin, 3, 14
   WWrite SendWin, EstTime$
   WLocate SendWin, 6, 14
   WWrite SendWin, SPACE$(30)
   WUpdate
   DO
      XmodemSend Handle, Protocol$, MaxRec, Record, ErrCount, ErrCode
      SELECT CASE ErrCode
         CASE -11
            WWriteLn MainWin, "--- Transfer aborted"
         CASE -10
            WWriteLn MainWin, "--- Transfer done"
         CASE -6
            WWriteLn MainWin, "--- Too many errors.  Aborted."
         CASE -5 TO -1
            WLocate SendWin, 6, 14
            WWrite SendWin, "Error in block.  Retrying."
         CASE 0
            WLocate SendWin, 5, 13
            WWrite SendWin, STR$((Record - 1) * RecLen)
            WLocate SendWin, 6, 14
            WWrite SendWin, SPACE$(30)
         CASE IS > 0
            WWriteLn MainWin, "--- Error reading file"
         CASE ELSE
            WWriteLn MainWin, "--- Unknown error, code = " + STR$(ErrCode)
      END SELECT
      WUpdate
   LOOP UNTIL ErrCode <= -6 OR ErrCode > 0
   FClose Handle
   WClose SendWin
   RETURN



RecvFile:
   Change = -1
   WWriteLn MainWin, "*** File receive is not yet implemented ***"
   RETURN



   REM $INCLUDE: 'ansi.bas'
