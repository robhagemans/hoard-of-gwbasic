    DEFINT A-Z
'   $INCLUDE: 'QBSERIAL.DEC'

'   This is only an example base for doing a door. It just demonstrates
'   how to obtain certain PCBoard parameters and apply them to QBserial.
'   It is not guarenteed to work if added on to. It was written while
'   PCBoard 14.0 was current. Certain parameter may have changed in PCBoard
'   since then.

    CRLF$ = CHR$(13) + CHR$(10)

'   Pick up name of config file with COMMAND$, then open and parse the file
'   extracting what you need. You'll recognize the parameters. Substitute
'   new names for parameters you door needs. Some of these (perhaps all?)
'   you can leave intact and use.
    
    IF FileExists(COMMAND$ + CHR$(0)) THEN
        OPEN COMMAND$ FOR INPUT ACCESS READ SHARED AS #1
        WHILE NOT EOF(1)
            LINE INPUT #1, A$
            A$ = UCASE$(A$)
            IF INSTR(A$, "FILES=") THEN
                X = INSTR(A$, "=")
                Files$ = MID$(A$, X + 1)
            ELSEIF INSTR(A$, "INTRO=") THEN
                X = INSTR(A$, "=")
                Intro$ = MID$(A$, X + 1)
            ELSEIF INSTR(A$, "CARRIER=") THEN
                X = INSTR(A$, "=")
                CarrierDetect$ = MID$(A$, X + 1)
            ELSEIF INSTR(A$, "HANDSHAKE=") THEN
                X = INSTR(A$, "=")
                Handshake$ = MID$(A$, X + 1)
            END IF
        WEND
        CLOSE #1
    ELSE
        PRINT "SYSOP: Configuration file cannot be found. Program returning"
        END
    END IF

    PCBoardDat$ = "PCBoard.Dat"
    PCBoardSys$ = "PCBoard.Sys"

    IF FileNotFound(PCBoardSys$ + CHR$(0)) THEN
        PRINT "SYSOP: Cannot find PCBoard.Sys, are you in the right DIR?"
        END
    END IF
    IF FileNotFound(PCBoardDat$ + CHR$(0)) THEN
        PRINT "SYSOP: Cannot find PCBoard.Dat, are you in the right DIR?"
        END
    END IF

    SELECT CASE Handshake$      ' Set the proper Handshake
        CASE "XON"
            HS = 1
        CASE "CTS"
            HS = 2
        CASE "BOTH"
            HS = 3
        CASE ELSE
            HS = 0
    END SELECT

'   Extract parameters from PBOARDS.SYS & PCBOARD.DAT
'   Callers$ = Location of the callers log (with node number tacked on)
'   Port = The comm port number
'   CurrentBaud$ = The current baud rate or LOCAL
'   Node = Current Node (if used)

    OPEN PCBoardSys$ FOR RANDOM ACCESS READ SHARED AS #7 LEN = 128
    FIELD #7, 128 AS Board$
    GET #7, 1
    OPEN PCBoardDat$ FOR INPUT AS #1
    LINE INPUT #1, A$
    FOR Lp = 1 TO 28
        INPUT #1, A$
    NEXT Lp
    INPUT #1, Callers$
    CLOSE #1
    Node = ASC(MID$(Board$, 112, 1))
    IF Node THEN
        Callers$ = Callers$ + MID$(STR$(Node), 2)
    END IF
    CurrentBaud$ = LTRIM$(RTRIM$(UCASE$(MID$(Board$, 19, 5))))
    Port = VAL(MID$(Board$, 126, 1))

'   Comm port initilization call format:

'   OpenComm Port%, IRQ%, Wordlen%, Parity%, Baudrate&, Handshake%, 0

'   NOTICE: The Baudrate, Parity & Wordlength ARE NOT CHANGED!! (Passed as 0)
'   WHY? Because why change them when they are already set the way you
'   want them.

    IF CurrentBaud$ = "LOCAL" THEN
        OpenComm 0, 0, 0, 0, 0, 0, 0, 0 'This NEEDS to be here like this
                                        'so calls to Transmit will return
                                        'properly when in local. No data is
                                        'transmitted when in this condition
    ELSE
        OpenComm Port, 0, 0, 0, 0, 0, HS, 0
    END IF
         
'   Enable Carrier Detect trap ONLY if NOT in Local and NOT disabled by the
'   Sysop

    IF CarrierDetect$ <> "NO" AND MID$(CurrentBaud$, 1, 4) <> "LOCA" THEN
        ON UEVENT GOSUB SysopClose
        UEVENT ON
    END IF

'***************************************************************************
'   Your CODE goes here. Heres an example:

    ' To send data out

    Temp$ = "This is transmitted out the serial port." + CRLF$
    Transmit Temp$

    'To get data from remote (or local) keyboard.

    Temp$ = "Enter data: "
    PRINT Temp$
    Transmit Temp$
    Transmit CRLF$
    GOSUB KeyboardInput
    Temp$ = "You entered: " + A$
    PRINT Temp$
    Transmit Temp$
    Transmit CRLF$

'   Your code ends here
'****************************************************************************

    'VERY important ending step - if you forget this, you CRASH sometime later.
    'But ONLY restore the vectors if you actually took them, otherwise
    'you'll cause a crash for other reasons.

RestoreInt:

    IF MID$(CurrentBaud$, 1, 4) <> "LOCA" THEN
        CloseComm
    END IF
    END

SysopClose:

    CLS
    Temp$ = "Loss of Carrier has been detected."
    PRINT Temp$
    GOTO RestoreInt

    'Keyboard input scan. Fetches characters from the remote keyboard.
    'Echo's characters as enetered. Returns on carriage return.

KeyboardInput:

    A$ = ""
    InCount = 0
    ClearInputBuffer
    DO
        DO
            Hit$ = INKEY$
            IF Hit$ <> "" THEN EXIT DO
        LOOP UNTIL DataWaiting
        I$ = ""
        IF Hit$ = "" THEN
            DO WHILE DataWaiting
                I$ = I$ + CHR$(ReadChar)
            LOOP
        ELSE
            I$ = Hit$
        END IF
        TookIn = LEN(I$)
        IF I$ = CHR$(8) THEN
            IF InCount THEN
                ' Your code to handle Backspace key ********
                ' Dont forget to send the Backspace sequence out to the
                ' Com port also with Transmit
            END IF
        END IF
        IF I$ = CHR$(13) THEN EXIT DO
        I$ = UCASE$(I$)
        IF I$ > CHR$(&H1F) AND I$ < CHR$(&H7F) THEN
            Transmit I$
            PRINT I$;   ' You may need to echo in a different way *******
            A$ = A$ + I$
            InCount = InCount + TookIn
        END IF
    LOOP
    RETURN

