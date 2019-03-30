
'QBXSBC FMIBNK.BAS
'read AdLib instrument BNK file and play some notes for each instrument
'5-May-1991

DEFINT A-Z

REM $INCLUDE: 'QBXIOL.BI'
REM $INCLUDE: 'QBXCTV.BI'
REM $INCLUDE: 'QBXFMI.BI'

TYPE BnkHdrTYPE
MajVer AS STRING * 1
MinVer AS STRING * 1
Signature AS STRING * 6
UsedSlots AS INTEGER
TotalSlots AS INTEGER
AbsNameOffset AS LONG
AbsDataOffset AS LONG
filler AS STRING * 8
END TYPE

TYPE InsNameTYPE
IndexNum AS INTEGER
UsedFlag AS STRING * 1
Instrument AS STRING * 8
Null AS STRING * 1
END TYPE

TYPE OperatorTYPE
KeyScaleLevel AS STRING * 1
FreqMult AS STRING * 1
FeedBack AS STRING * 1
Attack AS STRING * 1
Sustain AS STRING * 1
Sustaining AS STRING * 1
Decay AS STRING * 1
Release AS STRING * 1
zOutput AS STRING * 1
AmpVib AS STRING * 1
FreqVib AS STRING * 1
EnvScale AS STRING * 1
SnythMode AS STRING * 1
END TYPE

TYPE InsDataTYPE
Percussion AS STRING * 1
VoiceNum AS STRING * 1
Modulator AS OperatorTYPE
Carrier AS OperatorTYPE
ModulatorWF AS STRING * 1
CarrierWF AS STRING * 1
END TYPE

DIM SHARED BnkHdr AS BnkHdrTYPE
DIM SHARED InsData AS InsDataTYPE

'FMSetTimbre requires data in word form (2-bytes per)
DIM SHARED InsDataW(1 TO 28) AS INTEGER

CLS
BnkFile$ = "STANDARD.BNK"

PRINT "FMIBNK.BAS for QBXSBC"

stat = FMdetect(&H388)
IF stat THEN
   PRINT "FM chip not detected"
   STOP
END IF

stat = FMInit(Version)
IF stat THEN
   PRINT "No SOUND driver loaded"
   STOP
ELSE
   LOCATE 1, 25: PRINT "SOUND v"; LTRIM$(STR$(Version))
END IF

LOCATE 1, 38
PRINT "Cursor-SpaceBar-Esc-ñ"

OPEN BnkFile$ FOR BINARY AS #1

'read the header
GET #1, , BnkHdr

IF BnkHdr.Signature <> "ADLIB-" THEN
   PRINT "Not a BNK file"
   STOP
END IF

Instruments = BnkHdr.UsedSlots - 1
REDIM InsNames(0 TO Instruments) AS InsNameTYPE

'read all the instrument name records
GET #1, BnkHdr.AbsNameOffset + 1, InsNames(0)
FOR i = 1 TO BnkHdr.UsedSlots - 1
   GET #1, , InsNames(i)
NEXT

'display instrument names
LOCATE 2, 1
FOR i = 0 TO Instruments
   IF i MOD 8 = 0 THEN PRINT : LOCATE , 4
   PRINT InsNames(i).Instrument; " ";
NEXT

LOCATE 1, 61: PRINT "KBX:  0"
LOCATE 1, 71: PRINT "Index:"
LOCATE 2, 1
'play a scale for each instrument

i = 0
DO
   rowpos = i \ 8
   colpos = i MOD 8

   AbsPtr& = BnkHdr.AbsDataOffset + (1& * InsNames(i).IndexNum * LEN(InsData)) + 1
   LOCATE 1, 77: PRINT LTRIM$(STR$(InsNames(i).IndexNum))

   ThisRow = rowpos + 3
   ThisColumn = colpos * 9 + 4

   COLOR 15, 0: LOCATE ThisRow, ThisColumn
   PRINT InsNames(i).Instrument; " ";

   GET #1, AbsPtr&, InsData
   GOSUB Byte2Word
   GOSUB PlayTune
   COLOR 7, 0: LOCATE ThisRow, ThisColumn
   PRINT InsNames(i).Instrument; " ";

   SELECT CASE ikey
   CASE 0
      i = i + 1
   CASE ASC("+")
      FMGetKBXpose xpose
      xpose = xpose + 1
      IF xpose > 96 THEN xpose = 96
      FMSetKBXpose xpose
      LOCATE 1, 65: PRINT USING "###"; xpose
   CASE ASC("-")
      FMGetKBXpose xpose
      xpose = xpose - 1
      IF xpose < -96 THEN xpose = -96
      FMSetKBXpose xpose
      LOCATE 1, 65: PRINT USING "###"; xpose
   CASE 27
      EXIT DO
   CASE 1072
      i = i - 8
   CASE 1075
      i = i - 1
   CASE 1077
      i = i + 1
   CASE 1080
      i = i + 8
   CASE ELSE
   END SELECT
   IF i > Instruments THEN i = 0
   IF i < 0 THEN i = Instruments

LOOP

LOCATE 24, 1
STOP
SYSTEM

Byte2Word:
InsDataW(1) = ASC(InsData.Modulator.KeyScaleLevel)
InsDataW(2) = ASC(InsData.Modulator.FreqMult)
InsDataW(3) = ASC(InsData.Modulator.FeedBack)
InsDataW(4) = ASC(InsData.Modulator.Attack)
InsDataW(5) = ASC(InsData.Modulator.Sustain)
InsDataW(6) = ASC(InsData.Modulator.Sustaining)
InsDataW(7) = ASC(InsData.Modulator.Decay)
InsDataW(8) = ASC(InsData.Modulator.Release)
InsDataW(9) = ASC(InsData.Modulator.zOutput)
InsDataW(10) = ASC(InsData.Modulator.AmpVib)
InsDataW(11) = ASC(InsData.Modulator.FreqVib)
InsDataW(12) = ASC(InsData.Modulator.EnvScale)
InsDataW(13) = ASC(InsData.Modulator.SnythMode)
InsDataW(14) = ASC(InsData.Carrier.KeyScaleLevel)
InsDataW(15) = ASC(InsData.Carrier.FreqMult)
InsDataW(16) = ASC(InsData.Carrier.FeedBack)
InsDataW(17) = ASC(InsData.Carrier.Attack)
InsDataW(18) = ASC(InsData.Carrier.Sustain)
InsDataW(19) = ASC(InsData.Carrier.Sustaining)
InsDataW(20) = ASC(InsData.Carrier.Decay)
InsDataW(21) = ASC(InsData.Carrier.Release)
InsDataW(22) = ASC(InsData.Carrier.zOutput)
InsDataW(23) = ASC(InsData.Carrier.AmpVib)
InsDataW(24) = ASC(InsData.Carrier.FreqVib)
InsDataW(25) = ASC(InsData.Carrier.EnvScale)
InsDataW(26) = ASC(InsData.Carrier.SnythMode)
InsDataW(27) = ASC(InsData.ModulatorWF)
InsDataW(28) = ASC(InsData.CarrierWF)

LOCATE 23, 1
IF InsData.Percussion = CHR$(1) THEN
   PRINT "  PERCUSSION"
ELSE
   PRINT "  MELODIC   "
END IF
PRINT "  VOICE"; ASC(InsData.VoiceNum);

LOCATE 22, 20
PRINT "KSL FqM FBk  AR  SL  SS  DR  RR  OL  AV  FV  ES  FM  WF"
LOCATE 23, 14: PRINT "ModOp:";
FOR ii = 1 TO 13
   PRINT USING "### "; InsDataW(ii);
NEXT
PRINT USING "###"; InsDataW(27)

LOCATE 24, 14: PRINT "CarOp:";
IF InsData.Percussion = CHR$(0) OR (InsData.Percussion = CHR$(1) AND ASC(InsData.VoiceNum) = 6) THEN
   FOR ii = 14 TO 25
      PRINT USING "### "; InsDataW(ii);
   NEXT
   PRINT USING "  - ###"; InsDataW(28);
ELSE
   FOR ii = 14 TO 26
      PRINT "  - ";
   NEXT
   PRINT "  -";
END IF

RETURN

PlayTune:
FMFlush
FMSetState 0
FMSetRelTimeStart 0, 1
FMSetActVoice ASC(InsData.VoiceNum)
FMSetMode ASC(InsData.Percussion)
stat = FMSetRelVolume(1, 1, 0, 1)
stat = FMSetTempo(100, 0, 1)
vseg = VARSEG(InsDataW(1))
voff = VARPTR(InsDataW(1))
FMSetWaveformParm 1
stat = FMSetVoiceTimbre(vseg, voff, 0, 1)
RESTORE
READ Pitch, Duration, Delay
DO UNTIL Pitch = 100
   stat = FMPlayNote(Pitch, Duration, Delay)
   READ Pitch, Duration, Delay
LOOP
FMSetState 1
DO
  FMGetState State
  ikey$ = INKEY$
LOOP WHILE State <> 0 AND ikey$ = ""
IF State = 0 THEN ikey$ = CHR$(0) + CHR$(77)
IF LEN(ikey$) = 2 THEN
   ikey = 1000 + ASC(MID$(ikey$, 2, 1))
ELSE
   ikey = ASC(ikey$ + CHR$(0))
END IF
DO: LOOP WHILE INKEY$ <> ""

RETURN

REM SONG #1
DATA 0, 1, 2
DATA 2, 1, 2
DATA 4, 3, 4
DATA 7, 1, 4
DATA 7, 1, 1
DATA 4, 3, 4
DATA 0, 1, 4
DATA 4, 3, 2
DATA 2, 1, 2
DATA 0, 2, 1

REM SONG #2
DATA 0,1,2,4,1,2,7,1,2,12,3,2,2,3,4,5,1,4,9,1,2,12,3,2
DATA 11,3,4,9,1,4,7,1,2,5,1,1,2,1,2,4,1,1,9,1,2,7,3,2
DATA 100, 100, 100

