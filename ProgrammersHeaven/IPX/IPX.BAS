'--------------------------------------------------------------------'
'                                                                    '
'                                                                    '
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
DECLARE SUB IPXCancel (CompleteCode%)
DECLARE SUB IPXSchedule (DelayTicks%)
DECLARE SUB IPXDisconnect (DNet$, DNode$, DSock$)
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
   DataGram    AS STRING * 546
END TYPE
'
TYPE FullNetAddress
   NetWork     AS STRING * 4
   Node        AS STRING * 6
   Socket      AS STRING * 2
END TYPE
'
TYPE RouterAddress
   Node        AS STRING * 6
END TYPE
'
DIM SHARED IPXS AS IPXHeader, IPXR AS IPXHeader
DIM SHARED ECBS AS ECBStructure, ECBR AS ECBStructure
DIM SHARED InReg AS RegTypeX, OutReg AS RegTypeX
DIM SHARED GetMyAdd AS FullNetAddress
DIM SHARED LTAdd AS FullNetAddress, Disconnect AS FullNetAddress
DIM SHARED GetImmAdd AS RouterAddress
'

SUB CloseSocket (Socket%)
   InReg.BX = 1
   InReg.AX = 0
   InReg.DX = Socket
   CALL InterruptX(&H7A, InReg, OutReg)
END SUB

SUB GetMyAddress (MyNetwork$, MyNode$, MyNetworkHex$, MyNodeHex$)
   InReg.BX = &H9
   InReg.ES = VARSEG(GetMyAdd)
   InReg.SI = VARPTR(GetMyAdd)
   CALL InterruptX(&H7A, InReg, OutReg)
   MyNetwork$ = GetMyAdd.NetWork
   MyNode$ = GetMyAdd.Node
   MyNetworkHex$ = TurnToHex$(MyNetwork$)
   MyNodeHex$ = TurnToHex$(MyNode$)
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

SUB IPXCancel (CompleteCode%)
   InReg.BX = 6
   InReg.ES = VARSEG(ECBS)
   InReg.SI = VARPTR(ECBS)
   CALL InterruptX(&H7A, InReg, OutReg)
   CompleteCode = SplitWordLo%(OutReg.AX)
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

SUB IPXMarker (Interval%)
   InReg.BX = 8
   CALL InterruptX(&H7A, InReg, OutReg)
   Interval = OutReg.AX
END SUB

SUB IPXSchedule (DelayTicks%)
   InReg.AX = DelayTicks%
   InReg.BX = 5
   InReg.ES = VARSEG(ECBS)
   InReg.SI = VARPTR(ECBS)
   CALL InterruptX(&H7A, InReg, OutReg)
   CompleteCode = ASC(ECBS.CompCode)
   InUseFlag = ASC(ECBS.InUse)
END SUB

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
   '
   '        Completion codes:
   '              00    received
   '              FC    canceled
   '              FD    packet overflow
   '              FF    socket was closed
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

