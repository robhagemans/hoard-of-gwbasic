'--------------------------------------------------------------------'
'                 CHAT for QuickBASIC using Riceware's               '
'                             IPX Library.                           '
'--------------------------------------------------------------------'
'
DEFINT A-Z
DECLARE SUB RelenquishControl ()
DECLARE SUB SocketListen ()
DECLARE SUB CloseSocket (Socket%)
DECLARE SUB SendPacket (CompleteCode%, InUseFlag%)
DECLARE SUB OpenSocket (Socket%, Status%, SocketNumberReturned%)
DECLARE SUB IPXMarker (Interval%)
DECLARE SUB GetMyAddress (MyNetwork$, MyNode$, MyNetworkHex$, MyNodeHex$)
DECLARE SUB IPXSchedule (DelayTicks%)
DECLARE SUB IPXDisconnect (DNet$, DNode$, DSock$)
DECLARE SUB IPXCancelR (CompleteCode%)
DECLARE SUB IPXCancelS (CompleteCode%)
DECLARE FUNCTION SplitWordLo% (TheWord%)
DECLARE FUNCTION SplitWordHi% (TheWord%)
DECLARE FUNCTION IPXInstalled% ()
DECLARE FUNCTION TurnToHex$ (Variable$)
DECLARE FUNCTION HexToBinary$ (Variable$)
'
'           Define the DOS Interrupt registers.
'
TYPE RegTypeX
   AX    AS INTEGER
   BX    AS INTEGER
   CX    AS INTEGER
   DX    AS INTEGER
   BP    AS INTEGER
   SI    AS INTEGER
   DI    AS INTEGER
   FLAGS AS INTEGER
   DS    AS INTEGER
   ES    AS INTEGER
END TYPE
'
'              This is the Event Control Block Structure.
'
TYPE ECBStructure
   LinkAddressOff AS INTEGER
   LinkAddressSeg AS INTEGER
   ESRAddressOff  AS INTEGER
   ESRAddressSeg  AS INTEGER
   InUse       AS STRING * 1
   CompCode    AS STRING * 1
   SockNum     AS INTEGER
   IPXWorkSpc  AS SINGLE
   DrvWorkSpc  AS STRING * 12
   ImmAdd      AS STRING * 6
   FragCount   AS INTEGER
   FragAddOfs  AS INTEGER
   FragAddSeg  AS INTEGER
   FragSize    AS INTEGER
END TYPE
'
'              This is the IPX Packet Structure.
'
TYPE FullNetAddress
   NetWork     AS STRING * 4
   Node        AS STRING * 6
   Socket      AS STRING * 2
END TYPE
'
TYPE IPXHeader
   Checksum    AS INTEGER
   Length      AS INTEGER
   Control     AS STRING * 1
   PacketType  AS STRING * 1
   DestNet     AS STRING * 4
   DestNode    AS STRING * 6
   DestSocket  AS STRING * 2
   SourNet     AS STRING * 4
   SourNode    AS STRING * 6
   SourSock    AS STRING * 2
   '
   '           Send / Receive one character at a time.
   '
   Datagram    AS STRING * 1
END TYPE
'
DIM SHARED IPXS AS IPXHeader, IPXR AS IPXHeader
DIM SHARED ECBS AS ECBStructure, ECBR AS ECBStructure
DIM SHARED InReg AS RegTypeX, OutReg AS RegTypeX
DIM SHARED Disconnect AS FullNetAddress
DIM SHARED CompleteCode, InUseFlag, Socket%(2)
'
IF IPXInstalled = 0 THEN
   PRINT "IPX.COM is not installed."
   END
END IF
'
CLS
'
'              Just dynamically assigned sockets I picked at
'              random. Gee, I hope no one else is using them!
'              Below is a quick way to open all sockets needed.
'
Socket(1) = &H6382: '          initial send
Socket(2) = &H6383: '          initial listen
Send = Socket(1)
Listen = Socket(2)
'
FOR Socket = Socket(1) TO Socket(2)
   CALL OpenSocket(Socket, Status%, SocketNumberReturned%)
   IF Status = &HFE THEN
      PRINT "No Send socket available. Change SHELL.CFG and try again."
      SYSTEM
   END IF
   '
   IF Status <> 0 THEN
      PRINT USING "Unknown error opening Socket ######. Status: ###### "; Socket; Status
      SYSTEM
   END IF
   PRINT USING "Opened Socket ######."; Socket
NEXT
'
'                 Check for broadcasts on Socket #1. This is the
'                 initial SEND socket: if this program is being
'                 run on another computer, it will be sending on
'                 Socket(1), so THIS computer will LISTEN on #1
'                 and SEND on #2. The other computer will be
'                 listening on #2. Maybe.
'
IPXS.Checksum = 0: '                    Will be set by IPX.COM
IPXS.Length = LEN(IPXS): '              Size, with all fragments
IPXS.Control = CHR$(0): '               Set by IPX.COM
IPXS.PacketType = CHR$(0): '            Zero equals "unknown"
IPXS.DestNet = STRING$(4, &H0): '       default network
IPXS.DestNode = STRING$(6, &HFF): '     broadcast FFFFFFFFFFFF
IPXS.DestSocket = MKI$(Socket(1)): '    Broadcast on the send socket
IPXS.SourSock = MKI$(&H740): '          Random. Not needed.
IPXS.Datagram = CHR$(26): '             The data to send. 1 character.
'
ECBS.ESRAddressOff = 0: '               No event service request
ECBS.ESRAddressSeg = 0: '               No event service request
ECBS.SockNum = Socket(1): '             Broadcast on the send socket
ECBS.ImmAdd = STRING$(6, &HFF): '       Nearest Network
ECBS.FragCount = 1: '                   One fragment
ECBS.FragAddOfs = VARPTR(IPXS): '       Offset of IPX send block
ECBS.FragAddSeg = VARSEG(IPXS): '       Segment of IPX send block
ECBS.FragSize = LEN(IPXS): '            Length of IPX send block
'
'                 Send the packet. This call will return immediately,
'                 and IPX.COM will do its best to deliver the packet
'                 while in the background. When first called, this
'                 routine sets the Event Control Block's INUSE flag
'                 to 255 (&HFF). The DO-LOOP waits for the INUSE
'                 flag to go to zero, while surrendering time to
'                 the Network Interface Card's Device Driver.
'
CALL SendPacket(SendCompleteCode, SendInUseFlag)
PRINT "Broadcast packet was sent."
'
DO
   CALL RelenquishControl
   SendInUseFlag = ASC(ECBS.InUse)
LOOP WHILE SendInUseFlag = &HFF
'
'                 If the INUSE flag went from &HFF to something
'                 other than zero, there was an error; probably
'                 a hardware error.
'
IF SendInUseFlag <> 0 THEN
   PRINT "Send error: "; HEX$(SendInUseFlag)
   FOR S = 1 TO 2
      CALL CloseSocket(Socket(S))
   NEXT
   SYSTEM
END IF
'
'                 Now go into listen mode. If there is another
'                 computer out there, it will be listening AND
'                 sending a broadcast. We do not set up IPXR.
'
ECBR.ESRAddressOff = 0: '               No event service request
ECBR.ESRAddressSeg = 0: '               No event service request
ECBR.SockNum = Socket(2): '             Our LISTEN socket
ECBR.FragCount = 1: '                   One fragment
ECBR.FragAddOfs = VARPTR(IPXR): '       Offset of IPX listen block
ECBR.FragAddSeg = VARSEG(IPXR): '       Segment of IPX listen block
ECBR.FragSize = LEN(IPXR): '            Length of IPX listen block
'
CALL SocketListen
'
'                 Wait for the packet to arrive. If one does,
'                 the INUSE flag will go from &HFE to &H00.
'                 Every three seconds, send a broadcast.
'
PRINT "Listening. Hit any key to quit."
Ti# = TIMER
DO
   ListenInUseFlag = ASC(ECBR.InUse)
   IF ListenInUseFlag = 0 THEN EXIT DO
   IF INKEY$ <> "" THEN EXIT DO
   '
   '              After waiting for three seconds, we have the
   '              program cancel the listen and any send packet
   '              that might be out there from this computer.
   '
   IF TIMER >= (Ti# + 3) THEN
      '
      '           Cancel the listen and send.
      '
      CALL IPXCancelR(CompleteCode%)
      CALL IPXCancelS(CompleteCode%)
      '
      '           Now we swap sockets. Trickie, ain't it? In this
      '           way, a conversation will take no longer than
      '           6 and 1/18 seconds to start, worst case. Most
      '           conversations (~90%) will occur at 3 1/18 seconds.
      '
      IF Send = Socket(1) THEN
         Send = Socket(2)
         Listen = Socket(1)
      ELSE
         Send = Socket(1)
         Listen = Socket(2)
      END IF
      '
      '           Since the Listen Event Control Block is already
      '           set up to point to the Listen IPX header, all
      '           we need to do is tell it to use the new socket.
      '
      ECBR.SockNum = Listen
      CALL SocketListen
      '
      '           Since the Send Event Control Block is already
      '           set up to point to the Send IPX header, all
      '           we need to do is tell it to use the new socket.
      '
      IPXS.DestSocket = MKI$(Send)
      ECBS.SockNum = Send
      Ti# = TIMER
      CALL SendPacket(SendCompleteCode, SendInUseFlag)
      PRINT "Cyclical broadcast packet was sent. ";
      PRINT USING "Sending on ##### and Listening on #####"; Send; Listen
      '
      '           Surrender time to the device driver / NIC.
      '
      DO
         CALL RelenquishControl
         SendInUseFlag = ASC(ECBS.InUse)
      LOOP WHILE SendInUseFlag = &HFF
   END IF
LOOP
'
'                 The Listen INUSE flag will remain &HFE until a
'                 packet is received. Therefore, if we are here,
'                 it must be from an EXIT DO. Since only a user's
'                 keystroke could put us here, that means the
'                 user wanted to quit the listen loop and exit.
'
IF ListenInUseFlag <> 0 THEN
   PRINT "User canceled listen."
   FOR S = 1 TO 2
      CALL CloseSocket(Socket(S))
   NEXT
   SYSTEM
END IF
'
'                 If we got this far, it means a packet was received.
'                 Get the source address of the packet. From now on
'                 we will send to this node, and NOT broadcast.
'
SNet$ = TurnToHex$(IPXR.SourNet)
SNode$ = TurnToHex$(IPXR.SourNode)
SSoc$ = TurnToHex$(IPXR.SourSock)
'
'                 If we got the packet on socket #1, we set up
'                 all future listens to socket #1, and sends on
'                 socket #2. If the converse is true, we do the
'                 opposite, naturally. Cleaver, ain't it?
'
IF IPXR.SourSock = MKI$(Socket(1)) THEN
   Send = Socket(2)
   Listen = Socket(1)
ELSE
   Send = Socket(1)
   Listen = Socket(2)
END IF
'
'                 Tell the other computer that we saw it, by
'                 sending a carriage return.
'
IPXS.Datagram = CHR$(13): '             The data to send. 1 character.
IPXS.DestSocket = MKI$(Send): '         New SEND socket
ECBS.SockNum = Send: '                  Our SEND socket
'
CALL SendPacket(SendCompleteCode, SendInUseFlag)
PRINT "Acknowledgement broadcast packet was sent."
'
DO
   CALL RelenquishControl
   SendInUseFlag = ASC(ECBS.InUse)
LOOP WHILE SendInUseFlag = &HFF
'
'                    Set the Destination Address into variables.
'
PRINT
LOCATE , , 1, 0, 7
DNode$ = IPXR.SourNode
DNet$ = IPXR.SourNet
DIAdd$ = ECBR.ImmAdd
'
PRINT "Received chat request. Node: "; TurnToHex$(IPXR.SourNode)
PRINT "Hit ESC to quit the chat."
'
PRINT
DO
   '
   '           Get user input if any. User imput may only occur
   '           when the Send Event Control Block is not in use.
   '
   SendInUseFlag = ASC(ECBS.InUse)
   IF SendInUseFlag = 0 THEN
      '
      '        Checks the keyboard buffer.
      '
      A$ = INKEY$
      '
      '        If not blank, there was a key press.
      '
      IF A$ <> "" THEN
         IF A$ = CHR$(27) THEN
            '
            '
            '        Does the user want to exit the program? Looks like
            '        it, so let the other computer know that fact. Send
            '        an ESC character.
            '
            IPXS.Checksum = 0
            IPXS.Length = LEN(IPXS)
            IPXS.Control = CHR$(0)
            IPXS.PacketType = CHR$(0)
            IPXS.DestNet = DNet$
            IPXS.DestNode = DNode$
            IPXS.DestSocket = MKI$(Send)
            IPXS.SourSock = MKI$(1)
            IPXS.Datagram = CHR$(27)
            '
            ECBS.SockNum = Send
            ECBS.ImmAdd = DIAdd$
            ECBS.FragCount = 1
            ECBS.FragAddOfs = VARPTR(IPXS)
            ECBS.FragAddSeg = VARSEG(IPXS)
            ECBS.FragSize = LEN(IPXS)
            ' 
            CALL SendPacket(CompleteCode, SendInUseFlag)
            SendInUseFlag = ASC(ECBS.InUse)
            DO
               CALL RelenquishControl
               SendInUseFlag = ASC(ECBS.InUse)
            LOOP WHILE SendInUseFlag = &HFF
            '
            '           Tell the other computer's device that
            '           you no longer want to talk.
            '
            CALL IPXDisconnect(DNet$, DNode$, DSock$)
            EXIT DO
         END IF
         '
         '              Did the user hit the backspace key?
         '
         IF A$ = CHR$(8) THEN
            '
            '           Send a LeftCursor, a space, and another
            '           LeftCursor.
            '
            Message$ = CHR$(29) + " " + CHR$(29)
            FOR A = 1 TO 3
               IPXS.Datagram = MID$(Message$, A, 1)
               CALL SendPacket(CompleteCode, SendInUseFlag)
               SendInUseFlag = ASC(ECBS.InUse)
               DO
                  CALL RelenquishControl
                  SendInUseFlag = ASC(ECBS.InUse)
               LOOP WHILE SendInUseFlag = &HFF
            NEXT
            PRINT Message$;
         ELSE
            '
            '           Otherwise, send what the user entered.
            '
            IPXS.Checksum = 0
            IPXS.Length = LEN(IPXS)
            IPXS.Control = CHR$(0)
            IPXS.PacketType = CHR$(0)
            IPXS.DestNet = DNet$
            IPXS.DestNode = DNode$
            IPXS.DestSocket = MKI$(Send)
            IPXS.SourSock = MKI$(1)
            IPXS.Datagram = A$
            '
            ECBS.SockNum = Send
            ECBS.ImmAdd = DIAdd$
            ECBS.FragCount = 1
            ECBS.FragAddOfs = VARPTR(IPXS)
            ECBS.FragAddSeg = VARSEG(IPXS)
            ECBS.FragSize = LEN(IPXS)
            '
            CALL SendPacket(CompleteCode, SendInUseFlag)
            SendInUseFlag = ASC(ECBS.InUse)
            DO
               CALL RelenquishControl
               SendInUseFlag = ASC(ECBS.InUse)
            LOOP WHILE SendInUseFlag = &HFF
            PRINT A$;
         END IF
      END IF
   END IF
   '
   '              Now listen for a packet
   '
   ListenInUseFlag = ASC(ECBR.InUse)
   '
   '              Will be zero if a packet has been received.
   '              Otherwise, the other user has not sent anything.
   '
   IF ListenInUseFlag = 0 THEN
      IF IPXR.Datagram = CHR$(27) THEN
         PRINT "Other User Ended Chat"
         EXIT DO
      ELSE
         '
         '        Print what the other computer user sent.
         '
         PRINT IPXR.Datagram;
      END IF
      '
      ECBR.SockNum = Listen
      ECBR.FragCount = 1
      ECBR.FragAddOfs = VARPTR(IPXR)
      ECBR.FragAddSeg = VARSEG(IPXR)
      ECBR.FragSize = LEN(IPXR)
      CALL SocketListen
   END IF
LOOP
'
'                    If we are here, it means we hit ESC or the
'                    other person did. Close the two sockets.
'
FOR S = 1 TO 2
   CALL CloseSocket(Socket(S))
   PRINT USING "Closed Socket ######."; Socket(S)
NEXT

SUB CloseSocket (Socket%)
   InReg.BX = 1
   InReg.AX = 0
   InReg.DX = Socket
   CALL InterruptX(&H7A, InReg, OutReg)
END SUB

FUNCTION HexToBinary$ (Variable$)
   IF Variable$ = "" THEN
      HexToBinary$ = ""
   ELSE
      A = LEN(Variable$) MOD 2
      IF A = 1 THEN
         HexToBinary$ = ""
      ELSE
         Temp$ = ""
         FOR A = 1 TO LEN(Variable$) STEP 2
            Temp! = VAL("&H" + MID$(Variable$, A, 2))
            Temp$ = Temp$ + CHR$(Temp!)
         NEXT
         HexToBinary$ = Temp$
      END IF
   END IF
END FUNCTION

SUB IPXCancelR (CompleteCode%)
   InReg.BX = 6
   InReg.ES = VARSEG(ECBR)
   InReg.SI = VARPTR(ECBR)
   CALL InterruptX(&H7A, InReg, OutReg)
   CompleteCode = SplitWordLo%(OutReg.AX)
   '
   '                    FC = was canceled
END SUB

SUB IPXCancelS (CompleteCode%)
   InReg.BX = 6
   InReg.ES = VARSEG(ECBS)
   InReg.SI = VARPTR(ECBS)
   CALL InterruptX(&H7A, InReg, OutReg)
   CompleteCode = SplitWordLo%(OutReg.AX)
   '
   '                    FC = was canceled
END SUB

SUB IPXDisconnect (DNet$, DNode$, DSock$)
   Disconnect.NetWork = DNet$
   Disconnect.Node = DNode$
   Disconnect.Socket = DSock$
   InReg.BX = &HB
   InReg.ES = VARSEG(Disconnect)
   InReg.SI = VARPTR(Disconnect)
   CALL InterruptX(&H7A, InReg, OutReg)
END SUB

FUNCTION IPXInstalled%
   InReg.AX = &H7A00
   CALL InterruptX(&H2F, InReg, OutReg)
   AL = SplitWordLo(OutReg.AX)
   IF AL = &HFF THEN IPXInstalled = 1 ELSE IPXInstalled = 0
END FUNCTION

SUB OpenSocket (Socket%, Status%, SocketNumberReturned%)
   InReg.BX = 0
   InReg.AX = 0
   InReg.DX = Socket
   CALL InterruptX(&H7A, InReg, OutReg)
   Status = SplitWordLo(OutReg.AX)
   SocketNumberReturned = OutReg.DX
   '
   '           Completion status
   '                    00 successful
   '                    FF open already
   '                    FE socket table is full
END SUB

SUB RelenquishControl
   DEFINT A-Z
   InReg.AX = 0
   InReg.BX = &HA
   CALL InterruptX(&H7A, InReg, OutReg)
END SUB

SUB SendPacket (CompleteCode%, InUseFlag%)
   InReg.BX = 3
   InReg.ES = VARSEG(ECBS)
   InReg.SI = VARPTR(ECBS)
   CALL InterruptX(&H7A, InReg, OutReg)
   CompleteCode = ASC(ECBS.CompCode)
   InUseFlag = ASC(ECBS.InUse)
   '
   '        Error codes:
   '              00    sent
   '              FC    canceled
   '              FD    malformed packet
   '              FE    no listener (undelivered)
   '              FF    hardware failure
END SUB

SUB SocketListen
   InReg.BX = 4
   InReg.ES = VARSEG(ECBR)
   InReg.SI = VARPTR(ECBR)
   CALL InterruptX(&H7A, InReg, OutReg)
   CompleteCode = ASC(ECBR.CompCode)
   InUseFlag = ASC(ECBR.InUse)
   '
   '        Completion codes:
   '              00    received
   '              FC    canceled
   '              FD    packet overflow
   '              FF    socket was closed
   '              FE    Listening
END SUB

FUNCTION SplitWordHi (TheWord%)
   SplitWordHi = (TheWord% AND &HFF00) / 256
END FUNCTION

FUNCTION SplitWordLo (TheWord%)
   SplitWordLo = (TheWord% AND &HFF)
END FUNCTION

FUNCTION TurnToHex$ (Variable$)
   Temp$ = ""
   FOR Byte = 1 TO LEN(Variable$)
      Value! = ASC(MID$(Variable$, Byte, 1))
      IF Value! < 15 THEN
         Temp$ = Temp$ + "0" + HEX$(Value!)
      ELSE
         Temp$ = Temp$ + HEX$(Value!)
      END IF
   NEXT
   TurnToHex$ = Temp$
END FUNCTION

