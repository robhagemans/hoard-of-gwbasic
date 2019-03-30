
'QBXSBC CTVIN.BAS
'voice input example for the SoundBlaster routines
'5-May-1991

DEFINT A-Z

REM $INCLUDE: 'QBXIOL.BI'
REM $INCLUDE: 'QBXCTV.BI'
REM $INCLUDE: 'QBXFMI.BI'

TYPE CVheaderTYPE
FileID AS STRING * 20
DataStart AS INTEGER
Version AS INTEGER
VoiceID AS INTEGER
END TYPE '26
DIM HDR AS CVheaderTYPE

HDR.FileID = "Creative Voice File" + CHR$(26)
HDR.DataStart = 26
HDR.Version = 1 * 256 + 0
HDR.VoiceID = &H1133

CLS
PRINT "CTVIN.BAS for QBXSBC"
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

'12000 samples/second, 5 seconds of recording
SampleRate = 12000
MaxTime = 2
bytes& = 1& * SampleRate * MaxTime

'allocate a buffer large enough for the 5 seconds of voice data
'and 26 extra bytes for the header (VOXKIT compatible header)
'we can then use VOXKIT to silence-pack and then 4-bit pack

REDIM vocbuff(0 TO (bytes& + 26) \ 2) AS INTEGER
vseg = VARSEG(vocbuff(0))
voff = VARPTR(vocbuff(0))

PRINT
INPUT "Press <Enter> to begin recording", a$

'turn voice speaker off
stat = CTVspeaker(0)

'and record (that simple)
stat = CTVinput(SampleRate, bytes&, vseg, voff + 26)

IF stat = 0 THEN

   PRINT "Your on!"
   'wait until sampling done (RECORDING!)
   DO
      stat = CTVstatus
   LOOP WHILE stat

END IF

stat = CTVuninstall
PRINT "done."

INPUT "Press ENTER to begin playback"; a$
PRINT "CTVspeaker on  stat:"; CTVspeaker(1)
PRINT "CTVoutput      stat:"; CTVoutput(vseg, voff + 26)
DO
   stat = CTVstatus
LOOP WHILE stat
PRINT "CTVuninstall   stat:"; CTVuninstall

DO: LOOP WHILE INKEY$ <> ""

INPUT "Save to filename:", pathname$
IF LEN(pathname$) THEN

   'Create the voice file (must not already exist)
   stat = CreateFile(pathname$ + CHR$(0), 0)
   IF stat THEN PRINT "Create:"; stat: STOP

   'Open it
   stat = OpenDevice(pathname$ + CHR$(0), 2, handle, flen&)
   IF stat THEN PRINT "Open:"; stat: STOP

   'Write header data
   stat = WriteDevice(handle, 0, LEN(HDR), VARSEG(HDR), VARPTR(HDR))
   IF stat THEN PRINT "Write:"; stat

   'Write voice data
   stat = WriteDevice(handle, LEN(HDR), bytes&, vseg, voff + 26)
   IF stat THEN PRINT "Write:"; stat

   'Close it
   stat = CloseDevice(handle)
   IF stat THEN PRINT "Close:"; stat: STOP

   PRINT "done."

END IF

