
'QBXSBC CTVOUT.BAS
'voice output example for the SoundBlaster routines
'5-May-1991

DEFINT A-Z

REM $INCLUDE: 'QBXIOL.BI'
REM $INCLUDE: 'QBXCTV.BI'
REM $INCLUDE: 'QBXFMI.BI'

CLS
PRINT "CTVOUT.BAS for QBXSBC"
PRINT
PRINT "CTVport   stat:"; CTVport(&H220)
PRINT "CTVirq    stat:"; CTVirq(&H7)
stat = CTVdetect
PRINT "CTVdetect stat:"; stat
PRINT "CTVver    stat:"; CTVver(soft, hard);
PRINT "  S/W:"; RTRIM$(STR$(soft \ 256)); "."; LTRIM$(STR$(soft MOD 256));
PRINT "  H/W:"; RTRIM$(STR$(hard \ 256)); "."; LTRIM$(STR$(hard MOD 256))
IF stat THEN
   SELECT CASE stat
   CASE 1
      PRINT "SBC failed or is not installed"
   CASE 2
      PRINT "SBC I/O R/W failed"
   CASE 3
      PRINT "SBC DMA failed"
   CASE ELSE
      PRINT "Unexpected failure code"
   END SELECT
   SYSTEM
END IF

pathname$ = "WATSON.VOC"
PRINT
PRINT "playing voice file: "; pathname$

'open the voice file and get its length
stat = OpenDevice(pathname$ + CHR$(0), 2, handle, flen&)
IF stat THEN PRINT "Open:"; stat: STOP

'Get the voice data
'allocate a buffer large enough for the voice data
REDIM VocBuff(0 TO flen&) AS INTEGER
vseg = VARSEG(VocBuff(0))
voff = VARPTR(VocBuff(0))

stat = ReadDevice(handle, 0, flen&, vseg, voff)
IF stat THEN PRINT "Read:"; stat: STOP
stat = CloseDevice(handle)
IF stat THEN PRINT "Close:"; stat: STOP

'turn voice speaker on
stat = CTVspeaker(1)

'and play it (that simple)
stat = CTVoutput(vseg, voff + 26)

IF stat = 0 THEN

   PRINT
   PRINT "Will pause in 1 second. ";
   SLEEP 1
   stat = CTVpause

   PRINT "Press a key to continue output."
   SLEEP
   a$ = INKEY$
   stat = CTVcontinue

   'wait until it's done speaking (or do something else)
   DO
      stat = CTVstatus
   LOOP WHILE stat

END IF

stat = CTVuninstall
PRINT "done."

