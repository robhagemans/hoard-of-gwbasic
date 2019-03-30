'   $INCLUDE: 'QBSERIAL.DEC'

    DEFINT A-Z
    CLS
   
'   The following lines are used to retrieve the driver copyright

    X& = DriverCopyright
    WHILE (PEEK(X&))
        CP$ = CP$ + CHR$(PEEK(X&))
        X& = X& + 1
    WEND
    PRINT CP$
    PRINT

    CRLF$ = CHR$(13) + CHR$(10)
    Port = 1
    Length = 8
    Parity = 0
    Rate& = 9600
    HS = 0

'   Comm port initilization call format:

'   OpenComm Port%, IRQ%, Wordlen%, Parity%, Baudrate&, Handshake%, 0

    OpenComm Port, 0, Length, Parity, Rate&, HS, 0

    CarrierDetect 0         ' <-- Temporarilly disable UEVENT trip
                            '     to allow data to be transmitted without
                            '     presence of CD signal

    ON UEVENT GOSUB CarrierLoss
    UEVENT ON

'***************************************************************************
'   Your CODE goes here. Heres an example:

    ' To send data out

    Transmit "This is transmitted out the serial port." + CRLF$
    Transmit STRING$(25, CHR$(215)) + CRLF$

    'To get data from remote (or local) keyboard.

    Temp$ = "Enter data: "
    PRINT Temp$
    Transmit Temp$
    Transmit CRLF$
    GOSUB KeyboardInput
    PRINT
    Temp$ = "You entered: " + A$
    PRINT Temp$
    Transmit Temp$

    CarrierDetect 1         ' <-- Re-enable carrier detection. Carrier had
                            '     better be true or UEVENT willl occur on
                            '     next Transmit

    Transmit CRLF$

    DTRcontrol 0            ' <-- Turn OFF the DTR line
    SLEEP 1
    DTRcontrol 1            ' <-- Turn ON the DTR line
    SLEEP 1
    DTRcontrol 0
    SLEEP 1
    DTRcontrol 1

'   Your code ends here
'****************************************************************************

    'VERY important ending step - if you forget this, you CRASH sometime later.
    'But ONLY restore the vectors if you actually took them, otherwise
    'you'll cause a crash for other reasons.

RestoreInt:

    CloseComm
    END

CarrierLoss:

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
                ' Your code to handle Backspace key goes HERE ********
                ' Dont forget to send the Backspace sequence out to the
                ' Com port also with Transmit.
                ' I did not include it because I did not know how every one
                ' might handle it. I send a Chr$(8) + Chr$(32) + Chr$(8) to
                ' both the screen and Comm port.
            END IF
        END IF
        IF I$ = CHR$(13) THEN EXIT DO
        I$ = UCASE$(I$)
        IF I$ > CHR$(&H1F) THEN
            Transmit I$
            PRINT I$;   ' You may need to echo in a different way *******
                        ' Such as if you dont want direct screen writes.
            A$ = A$ + I$
            InCount = InCount + TookIn
        END IF
    LOOP
    RETURN

