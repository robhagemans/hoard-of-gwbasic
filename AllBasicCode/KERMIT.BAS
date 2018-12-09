1	' A short, receive-only Kermit program, suitable for bootstrapping a
2	' real Kermit program.  Assumes no parity, refuses to do 8th bit
3	' prefixing or repeat-count compression, and depends upon remote
4	' system to take care of timeouts.  Can receive multiple
5	' files; can receive binary files(?).  Written in Microsoft Basic,
6	' tested on the IBM PC and the DEC Rainbow.
7	'
8	' F. da Cruz, November 1985
9	'
100     RESET : RESET : RESET ' Seems to help sometimes...
110     ON ERROR GOTO 9000
120     DEFINT A-Z ' Use all integers for speed.
131	'
141	' All lines with numbers not ending in 0 can be removed.
151	'
161   '	X  = 1 ' For diagnostic output
171   '	XX = 1 ' For super-verbose diagnostics
181	'
191	IF XX = 1 THEN X = 1
1000	'
1001	' Initialize N and PREV (current and previous packet number),
1002	' the Send packet buffer (with a NAK for packet 0),
1003    ' and open the communication port 1200-baud no-parity no-modem.
1004	' See your Basic manual for details about OPEN COM options.
1005	'
1010    N = 0 : PREV = -1 : SNDBUF$ = CHR$(1)+"# N3"+CHR$(13)
1020    OPEN "COM1:1200,N,8,,CS,DS" AS #1
1999    '
2000    ' Get remote's Send-Initate parameters then ACK with our own,
2001	' namely 40-character packets, 10-sec timeout, no padding,
2002	' CR packet terminator, "#" Ctrl-prefix, no 8th-bit quoting,
2003	' and single-character checksum.  Ignore remote parameters
2004	' except for packet terminator (EOL$) and Ctrl-prefix (CTL$).
2005	'
2010	PRINT "Waiting..."
2020    GOSUB 5000				' Wait for a valid packet.
2030    IF TYPE$ <> "S" THEN GOTO 8000		' Wrong type, fail.
2040	IF LEN(PKTDAT$) > 4 THEN EOL=ASC(MID$(PKTDAT$,5,1))-32 ELSE EOL=13
2050    IF LEN(PKTDAT$) > 5 THEN CTL=ASC(MID$(PKTDAT$,6,1)) ELSE CTL=ASC("#")
2061	IF X THEN PRINT " Send-Init OK, EOL=";EOL;", CTL=";CTL
2070    TYPE$ = "Y" : L = 8 : D$ = "H* @-#N1"
2080    GOSUB 6000				' Send ACK with own parameters.
2999    '
3000    ' Get a File Header packet.  If a B packet comes, we're all done.
3010    GOSUB 5000				' Wait for valid packet.
3020	IF TYPE$ = "B" THEN GOSUB 7500 : GOTO 9900 ' Done.
3030    IF TYPE$ <> "F" THEN D$ = TYPE$+" Packet in [FB] State" : GOTO 8000
3040    PRINT "Receiving "; MID$(PKTDAT$,1,L)   ' Print Message
3050    OPEN MID$(PKTDAT$,1,L) FOR OUTPUT AS #2 ' Open the file (errors fatal)
3060    GOSUB 7500                              ' Open OK, Ack the F packet
3999    '
4000    ' Get Data packets.  If a Z packet comes, the file is complete.
4010    GOSUB 5000	 		       	' Get a valid packet.
4020    IF TYPE$ = "Z" THEN CLOSE #2 : GOSUB 7500 : PRINT "(OK)" : GOTO 3000
4030    IF TYPE$ <> "D" THEN D$ = TYPE$+" Packet in [DZ] State" : GOTO 8000
4040    PRINT #2, MID$(PKTDAT$,1,P); 	  	' Good data, record in file.
4060    GOSUB 7500		       		' Ack the data.
4070    GOTO 4000		       		' Go back for more.
4999    '
5000    ' Get a valid packet with the desired sequence number.
5010    GOSUB 7000 		       		' Read and decode a packet.
5020    FOR TRY = 1 TO 5	       		' Try 5 times, then give up.
5030      IF N <> PREV AND TYPE$ <> "Q" THEN RETURN ' Good!
5040      PRINT #1, SNDBUF$; 			' Not good, so resend previous,
5050      PRINT "%";				' and display special blip.
5060      GOSUB 7000				' Read another packet.
5070    NEXT TRY
5080    TYPE$ = "E" : D$ = "Timed Out" : RETURN ' Failed after 5 tries.
5999    '
6000    ' Send a packet with data D$ of length L, type T$, sequence #N.
6010    SNDBUF$ = CHR$(1)+CHR$(L+35)+CHR$(N+32)+TYPE$+D$+" "+CHR$(EOL)
6020    CHKSUM = 0
6030    FOR I = 2 TO L+4		' Compute the checksum
6040      CHKSUM = CHKSUM + ASC(MID$(SNDBUF$,I,1))
6050    NEXT I
6060    CHKSUM = (CHKSUM + ((CHKSUM AND 192) \ 64)) AND 63
6070    MID$(SNDBUF$,L+5) = CHR$(CHKSUM + 32) ' Insert the checksum
6080    PRINT #1, SNDBUF$;		' Send the packet
6091    IF X THEN PRINT ">>";MID$(SNDBUF$,1,L+5);"<<"
6100    RETURN
6999    '
7000    ' Routine to Read and Decode a Packet.
7010    FOR TRY = 1 TO 3		' Try 3 times...
7020      LINE INPUT #1, RCVBUF$	' Read a "line" (up to a CR)
7030      I = INSTR(RCVBUF$,CHR$(1))	' Look for the SOH (^A)
7041	  IF X THEN PRINT "<<";RCVBUF$;">>, SOH at"; I; ", Try #"; TRY
7050      IF I > 0 THEN GOTO 7100	' Got SOH, must be a real packet.
7060    NEXT TRY			' No SOH, try again.
7070    TYPE$ = "Q" : D$ = "Timed Out" : RETURN	' No real packet
7100    CHK = ASC(MID$(RCVBUF$,I+1,1)) : L = CHK - 35		  ' Length
7110    T = ASC(MID$(RCVBUF$,I+2,1)) : N = T - 32 : CHK = CHK + T ' Number
7120    TYPE$ = MID$(RCVBUF$,I+3,1) : CHK = CHK + ASC(TYPE$)      ' Type
7130    P = 0 : FLAG = 0 : PKTDAT$ = STRING$(100,32)		  ' Data
7141    IF X THEN PRINT " L =";L;"N =";N"T = '";TYPE$;"'"
7200    FOR J = I+4 TO I+3+L		' For all data characters...
7210      T = ASC(MID$(RCVBUF$,J,1))	' Get a data character
7220      CHK = CHK + T			' Add it to the checksum
7231      IF XX THEN PRINT "-";(MID$(RCVBUF$,J,1));
7240	  IF TYPE$ = "S" THEN 7300	' Don't decode the S packet!
7250        IF FLAG = 0 AND T = CTL THEN FLAG = 1 : GOTO 7400
7260	    T7 = T AND 127		' Use only 7 bits for Ctrl range check
7270        IF FLAG THEN FLAG = 0 : IF T7 > 62 AND T7 < 96 THEN T = T XOR 64
7300      P = P + 1			' Real data character position
7310      MID$(PKTDAT$,P,1) = CHR$(T)	' Insert data character in buffer
7400    NEXT J
7411    IF XX THEN PRINT " packet data://";MID$(PKTDAT$,1,P);"//"
7420    CHK = (CHK + ((CHK AND 192) \ 64)) AND 63
7430    T = ASC(MID$(RCVBUF$,J,1)) : CHKSUM = T - 32
7441	IF X THEN PRINT " chksum=";CHK;", packet=";CHKSUM;"'";CHR$(T);"'"
7450    IF CHKSUM <> CHK THEN TYPE$ = "Q"      ' Compare the checksums.
7460    RETURN				       ' Return with packet type.
7499	'
7500	' Routine to send an ACK and increment the packet number...
7510    D$ = ""                                ' Nothing in Data field.
7520    TYPE$ = "Y" : L = LEN(D$) : GOSUB 6000 ' Send the packet.
7530    PREV = N : N = (N + 1) AND 63          ' Next sequence number, mod 64.
7540    IF N = 0 THEN PRINT "!"; ELSE IF (N AND 4)=0 THEN PRINT "."; ' Blips.
7550    RETURN
7999    '
8000	' Error packet sender...
8010    IF D$ = "" THEN D$ = "Error"
8020    L = LEN(D$) : TYPE$ = "E" : GOTO 6000 ' Go send it, return from there.
8999	'
9000	' Error handler, nothing fancy...
9010    D$ = "Error Number" + STR$(ERR) + " at Line" + STR$(ERL)
9020    PRINT CHR$(7);D$
9030	GOSUB 8000 ' Send error packet, and fall through to...
9900	'
9910	' Normal exit point
9920    CLOSE #1, #2
9930	PRINT CHR$(7);"(Done)"
9999    END
