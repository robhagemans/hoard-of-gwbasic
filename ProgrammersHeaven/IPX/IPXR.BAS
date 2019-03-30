'--------------------------------------------------------------------'
'             IPX Send And Receive in QuickBASIC 4.0                 '
'                          By David Rice                             '
'--------------------------------------------------------------------'
'
DECLARE SUB SocketListen ()
DECLARE SUB CloseSocket (Socket%)
DECLARE SUB SendPacket (CompleteCode%, InUseFlag%)
DECLARE SUB OpenSocket (Socket%, Status%, SocketNumberReturned%)
DECLARE SUB GetMyAddress (MyNetwork$, MyNode$, MyNetworkHex$, MyNodeHex$)
DECLARE FUNCTION SplitWordLo% (TheWord%)
DECLARE FUNCTION SplitWordHi% (TheWord%)
DECLARE FUNCTION IPXInstalled% ()
DECLARE FUNCTION TurnToHex$ (Variable$)
DEFINT A-Z
'
'           Choose the socket number to use. You MUST pick one
'        that no other program is using! Call Novell to see which
'        socket you may use.
'
CONST Socket = &H5555
CLS
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
	'Sequence    AS SINGLE
	DataGram    AS STRING * 546
	'DataGram    AS STRING * 542
END TYPE
'
TYPE FullNetAddress
	Network     AS STRING * 4
	Node        AS STRING * 6
END TYPE
'
'              Define the Send and Receive buffers.
'
DIM SHARED IPXS AS IPXHeader, IPXR AS IPXHeader
DIM SHARED ECBS AS ECBStructure, ECBR AS ECBStructure
DIM SHARED InReg AS RegTypeX, OutReg AS RegTypeX
DIM SHARED GetMyAdd AS FullNetAddress
'
IF IPXInstalled = 0 THEN
	PRINT "IPX.COM is not installed."
	END
END IF
'
ECBR.LinkAddressOff = 0
ECBR.LinkAddressSeg = 0
ECBR.ESRAddressOff = 0
ECBR.ESRAddressSeg = 0
ECBR.SockNum = Socket
ECBR.FragCount = &H1
ECBR.FragAddOfs = VARPTR(IPXR)
ECBR.FragAddSeg = VARSEG(IPXR)
ECBR.FragSize = LEN(IPXR)
'
'
CALL GetMyAddress(MyNetwork$, MyNode$, MyNetworkHex$, MyNodeHex$)
'
PRINT "My network address is: "; MyNetworkHex$, MyNodeHex$
'              Open the socket number HEX(5555)
'
CALL OpenSocket(Socket, Status, SocketNumberReturned)
'
'              Ask IPX.COM to listen for a packet.
'
CALL SocketListen
'
'              Wait for the packet to arrive.
'
PRINT "Listening. Hit Any Key To Stop."
PRINT
DO
	CompleteCode = ASC(ECBR.CompCode)
	InUseFlag = ASC(ECBR.InUse)
	IF INKEY$ <> "" THEN EXIT DO
LOOP UNTIL InUseFlag = 0
'
SNet$ = TurnToHex$(IPXR.SourNet)
SNode$ = TurnToHex$(IPXR.SourNode)
SSoc$ = TurnToHex$(IPXR.SourSock)
'
PRINT "Complete Code: "; HEX$(CompleteCode)
PRINT "In Use Flag: "; HEX$(InUseFlag)
PRINT "Source Network: "; SNet$
PRINT "Source Node: "; SNode$
PRINT "Source Socket: "; SSoc$
PRINT "Data: "; IPXR.DataGram
'
'           Now send a confirmation packet.
'
IPXS.Checksum = 0
IPXS.Length = LEN(IPXS)
IPXS.Control = CHR$(0)
IPXS.PacketType = CHR$(0)
IPXS.DestNet = IPXR.SourNet
IPXS.DestNode = IPXR.SourNode
IPXS.DestSocket = MKI$(Socket)
IPXS.SourSock = MKI$(&H740)
IPXS.DataGram = "Hello there Back At You!"
'
ECBS.LinkAddressOff = 0
ECBS.LinkAddressSeg = 0
ECBS.ESRAddressOff = 0
ECBS.ESRAddressSeg = 0
ECBS.SockNum = Socket
ECBS.ImmAdd = STRING$(6, &HFF)
ECBS.FragCount = &H1
ECBS.FragAddOfs = VARPTR(IPXS)
ECBS.FragAddSeg = VARSEG(IPXS)
ECBS.FragSize = LEN(IPXS)
'
CALL SendPacket(CompleteCode, InUseFlag)
PRINT "Complete Code: "; HEX$(CompleteCode); " In Use Flag: "; HEX$(InUseFlag)
'
CALL CloseSocket(Socket)

SUB CloseSocket (Socket%)
	InReg.BX = 1
	InReg.AX = 0
	InReg.DX = Socket
	CALL InterruptX(&H7A, InReg, OutReg)
END SUB

SUB GetMyAddress (MyNetwork$, MyNode$, MyNetworkHex$, MyNodeHex$)
	InReg.BX = 9
	InReg.ES = VARSEG(GetMyAdd)
	InReg.SI = VARPTR(GetMyAdd)
	CALL InterruptX(&H7A, InReg, OutReg)
	MyNetwork$ = GetMyAdd.Network
	MyNode$ = GetMyAdd.Node
	MyNetworkHex$ = TurnToHex$(MyNetwork$)
	MyNodeHex$ = TurnToHex$(MyNode$)
END SUB

SUB IPXCancel (CompleteCode%)
	InReg.BX = 6
	InReg.ES = VARSEG(ECBS)
	InReg.SI = VARPTR(ECBS)
	CALL InterruptX(&H7A, InReg, OutReg)
	CompleteCode = SplitWordLo%(OutReg.AX)
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
	CompleteCode = ASC(ECBR.CompCode)
	InUseFlag = ASC(ECBR.InUse)
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

