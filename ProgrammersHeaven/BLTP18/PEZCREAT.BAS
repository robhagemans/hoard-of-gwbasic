'$DIM ALL
DECLARE FUNCTION EzCreateDXB% (Filename AS STRING * 80, NoFields%, FieldInfo$())

DEFINT A-Z
$LINK "PBULLET.PBL"
$INCLUDE "PBULLET.BI"
$LINK "NOATEXIT.OBJ"

'10-Oct-94 -chh
'first test program for Bullet for PB3 (initial modifications from QB to PB3
'by j.fuller@genie.geis.com (James C. Fuller), August 1994)
'-
'this program really doesn't do anything but create a DBF data file
'-
'things to watch for are: VARSEG/VARPTR require fixed-length strings (use
'STRSEG/STRPTR for variable-length strings (handle-based strings)
'--
'To create an EXE: compile from PB.EXE

DIM DFP AS DOSFilePack
DIM MP AS MemoryPack
DIM IP AS InitPack
DIM EP AS ExitPack
DIM CDP AS CreateDataPack
DIM OP AS OpenPack
DIM DP AS DescriptorPack

dim i as integer
DIM level AS INTEGER
DIM stat AS INTEGER
DIM QBHeap AS LONG
DIM NoFields AS INTEGER
DIM FieldInfo(1:1) AS STRING
DIM HandDAT AS INTEGER

dim NameDAT as string * 80	'fixed-length required when using VARPTR/SEG
NameDAT = "EZ_TEST.DBF" + CHR$(0)

level = 100
MP.Func = %MemoryXB
stat = BULLET(MP)

IF MP.Memory < 49152 THEN
   QBheap& = SETMEM(-50000)  'this is not the best way to do this
   MP.Func = %MemoryXB	     'should only release 49152-MP.memory+fudge
   stat = BULLET(MP)         'close enough for right now
   IF MP.Memory < 49152 THEN stat = 8: GOTO Abend  'actually could use less
END IF


level = 110
IP.Func = %InitXB
IP.JFTmode = 0
stat = BULLET(IP)
IF stat THEN GOTO Abend

level = 120
EP.Func = %AtExitXB
stat = BULLET(EP)

level = 130
DFP.Func = %DeleteFileDOS
DFP.FilenamePtrOff = VARPTR(NameDAT)
DFP.FilenamePtrSeg = VARSEG(NameDAT)
stat = BULLET(DFP)

'this is the simplified method to create BULLET data files
'simple in that you just use a string array with each element of the array
'set to the corresponding field info for the DBF data record

level = 1000
NoFields = 4
REDIM FieldInfo$(1 TO NoFields)
FieldInfo$(1) = "LASTNAME,C,19,0"
FieldInfo$(2) = "FIRSTNAME,C,15,0"
FieldInfo$(3) = "BIRTHDATE,D,8,0"
FieldInfo$(4) = "SALARY,N,10,2"
stat = EzCreateDXB(NameDAT, NoFields, FieldInfo$())
IF stat THEN GOTO Abend

'just open it up and print out the field descriptors to the data file just reated

level = 1010
OP.Func = %OpenDXB
OP.FilenamePtrOff = VARPTR(NameDAT)
OP.FilenamePtrSeg = VARSEG(NameDAT)
OP.ASmode = %ReadWrite + %DenyNone
stat = BULLET(OP)
IF stat THEN GOTO Abend
HandDAT = OP.Handle

level = 1020
DP.Func = %GetDescriptorXB
DP.Handle = HandDAT
PRINT
PRINT "FieldName  T  L  D"
PRINT "---------  - -- --"
FOR i = 1 TO NoFields
   DP.FieldNumber = i
   stat = BULLET(DP)
   IF stat = 0 THEN
      PRINT DP.FD.FieldName; DP.FD.FieldType;
      PRINT ASC(DP.FD.FieldLength); ASC(DP.FD.FieldDC)
   ELSE
      EXIT FOR
   END IF
NEXT

PRINT
PRINT "Okay."
EndIt:
EP.Func = %ExitXB
stat = BULLET(EP)
END


Abend:
PRINT
PRINT "Error:"; stat; "at level"; level; "while performing ";
SELECT CASE level
CASE  = 999
   SELECT CASE level
   CASE 100
      PRINT "heap memory release request of 50K."
   CASE 110
      PRINT "BULLET initialization."
   CASE 120
      PRINT "registering of ExitXB with _atexit."
   CASE ELSE
      PRINT "Preliminaries unknown."
   END SELECT
CASE  <= 1099
   SELECT CASE level
   CASE 1000
      PRINT "data file create."
   CASE 1010
      PRINT "data file open."
   CASE 1020
      PRINT "data get descriptors."
   CASE ELSE
      PRINT "data file unknown, or DOS error."
   END SELECT
CASE ELSE
   PRINT "unknown."
END SELECT
GOTO EndIt

FUNCTION EzCreateDXB (Filename AS STRING * 80, NoFields AS INTEGER, FieldInfo() AS STRING)

'example of using modular programming to customize the BULLET API
 'FieldInfo$() is a var-len string array with each element made up as:
 ' FieldInfo$(i) = "FIELDNAME,FIELDTYPE,FIELDLEN,FIELDDC" as in:
 ' FieldInfo$(1) = "LASTNAME,C,19,0"
 ' FieldInfo$(2) = "FIRSTNAME,C,15,0"
 ' FieldInfo$(3) = "BIRTHDATE,D,8,0"
 ' FieldInfo$(4) = "SALARY,N,10,2"
 '   and so on

REDIM FieldList(1 TO NoFields) AS FieldDescTYPE

DIM CDP AS CreateDataPack

DIM TmpStr AS STRING * 32

dim i AS INTEGER
dim stat AS INTEGER
dim fldname AS STRING
dim fldtype AS STRING
dim fldlength AS INTEGER
dim flddc AS INTEGER
dim cptr AS INTEGER
dim nptr AS INTEGER

FOR i = 1 TO NoFields
   GOSUB ParseInfo
   IF stat THEN EXIT FOR
   FieldList(i).FieldName = fldname$
   FieldList(i).FieldType = fldtype$
   FieldList(i).FieldLength = CHR$(fldlength)
   FieldList(i).FieldDC = CHR$(flddc)
NEXT

IF stat = 0 THEN
   CDP.Func = %CreateDXB
   CDP.FilenamePtrOff = VARPTR(Filename)
   CDP.FilenamePtrSeg = VARSEG(Filename)
   CDP.NoFields = NoFields
   CDP.FieldListPtrOff = VARPTR(FieldList(1))
   CDP.FieldListPtrSeg = VARSEG(FieldList(1))
   CDP.FileID = 3
   stat = BULLET(CDP)
END IF

EzCreateDXB = stat
EXIT FUNCTION

'--------
ParseInfo:
stat = 0
cptr = 1
nptr = 0
TmpStr = LTRIM$(RTRIM$(FieldInfo$(i))) + CHR$(0)
nptr = INSTR(cptr, TmpStr, ",")
IF nptr > cptr THEN
   fldname$ = LTRIM$(RTRIM$(MID$(TmpStr, cptr, nptr - cptr))) + STRING$(11,0)
   cptr = nptr + 1
   nptr = INSTR(cptr, TmpStr, ",")
   IF nptr > cptr THEN
      fldtype$ = LTRIM$(RTRIM$(MID$(TmpStr, cptr, nptr - cptr)))
      cptr = nptr + 1
      nptr = INSTR(cptr, TmpStr, ",")
      IF nptr > cptr THEN
         fldlength = VAL(MID$(TmpStr, cptr, nptr - cptr))
         cptr = nptr + 1
         nptr = INSTR(cptr, TmpStr, CHR$(0))
         IF nptr > cptr THEN
            flddc = VAL(MID$(TmpStr, cptr, nptr - cptr))
         END IF
      END IF
   END IF
END IF
IF nptr <= cptr THEN stat = 243  '(for lack of a better error code...)

'may want to verify that fldname$,fldtype$,fldlength,flddc are within limits

RETURN
end function



