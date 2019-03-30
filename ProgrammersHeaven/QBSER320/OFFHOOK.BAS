    DEFINT A-Z

    DECLARE SUB Response ()
    DECLARE FUNCTION Value% (Char$)

'   This example program is used to take the modem OFF-HOOK and leave it that
'   way. This program was designed to work with a PCBoard BBS system and
'   the port (and perhaps IRQ) information is retrieved from a system file
'   called PCBOARD.DAT. In order to experiment with this program in a
'   non-PCBoard environment, simply remove the lines marked "NO PCBOARD START"
'   until "NO PCBOARD END". Then Add the following variables before the
'   OpenComm statement:
'
'   Port        The port number (1, 2, 3, 4, or any other address)
'   Rate&       The baud rate you want to use (2400, 9600, etc)
'   OffHook$    A string with your modem's off hook command (ATH1)

'   $INCLUDE: 'QBSERIAL.DEC'

    CLS
    IRQ = 0
    PRINT "Modem OFFHOOK, ver 1.0"
    PRINT

' Print Driver Copyright

    X& = DriverCopyright
    WHILE (PEEK(X&))
        CP$ = CP$ + CHR$(PEEK(X&))
        X& = X& + 1
    WEND
    PRINT CP$
    PRINT

'----------NO PCBOARD START--------------------------------------------------
    OPEN "PCBOARD.DAT" FOR INPUT AS #1

    FOR Lp = 1 TO 52
        INPUT #1, Port$
    NEXT
    INPUT #1, Speed$            'Get Port Speed from PCBOARD.DAT
    INPUT #1, X$
    INPUT #1, X$
    INPUT #1, OffHook$          'Get OFF-HOOK string from PCBOARD.DAT
    Rate& = VAL(Speed$)
    IF Port$ = "NONE" THEN
        PRINT "No Modem."
        END
    END IF
    Port = VAL(MID$(Port$, 4))      'Get port used
    IF Port > 2 THEN                'If port isnt 1 or 2, then you need IRQ
        SEEK #1, 1                  'and Base Address
        FOR Lp = 1 TO 159
            INPUT #1, IRQ$          'get IRQ
        NEXT
        INPUT #1, Port$             'get BASE ADDRESS of port

        ' Convert (ascii) HEX value of port to useable decimal value

        Port = (Value(MID$(Port$, 1, 1)) * 256) + (Value(MID$(Port$, 2, 1)) * 16) + Value(MID$(Port$, 3, 1))
        IRQ = VAL(IRQ$)
    END IF
'----------NO PCBOARD END----------------------------------------------------

    CRLF$ = CHR$(13) + CHR$(10)
    Length = 8
    Parity = 0
    HS = 0

    OpenComm Port, IRQ, Length, Parity, Rate&, HS, 0

    CarrierDetect 0     ' <-- NEEDED TO TALK TO MODEM W/NO CARRIER!!

    ClearInputBuffer
    transmit "AT" + CRLF$
    PRINT "Transmitting: AT"
    Response
    PRINT

    SLEEP 1

    ClearInputBuffer
    transmit "AT" + CRLF$
    PRINT
    PRINT "Transmitting: AT"
    Response
    PRINT

    SLEEP 1

    ClearInputBuffer
    transmit OffHook$ + CRLF$
    PRINT
    PRINT "Transmitting: " + OffHook$
    Response
    PRINT

    SLEEP 2

    DTRcontrol 1            ' DONT turn off DTR, doing so may let modem
                            ' hang up, and we dont want this to happen
    CloseComm

    END

' Read data comming from the modem. SUB will not return until an OK is
' detected. SUB will time-out if an OK is not detected in 4 seconds.                                                    
SUB Response
    Start! = TIMER
    PRINT "Response: ";
    I$ = ""
    DO
        IF DataWaiting THEN
            X$ = CHR$(ReadChar)
            PRINT X$;
            I$ = I$ + X$
        END IF
        IF TIMER - Start! > 4 THEN
            PRINT "COMMUNICATIONS TIMEOUT!!"
            EXIT DO
        END IF
    LOOP UNTIL INSTR(I$, "OK")
END SUB

FUNCTION Value (Char$)
    SELECT CASE Char$
        CASE "0" TO "9"
            Value = VAL(Char$)
            EXIT FUNCTION
        CASE "A" TO "F"
            Value = ASC(Char$) - 55
    END SELECT
END FUNCTION

