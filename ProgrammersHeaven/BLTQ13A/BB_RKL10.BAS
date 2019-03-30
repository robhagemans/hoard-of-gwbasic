
DEFINT A-Z

REM $INCLUDE: 'BULLET.BI'
'bb_rkl10.bas 21-Aug-92 chh
'--lock single data record example
'C>bc bb_rkl10 /o;
'C>link bb_rkl10,,nul,bullet;

UseDir$ = ".\"                  'all files use this directory except   N/A
                                'the reindex work file which uses the
                                'SET TMP= directory or the current directory
CLS
PRINT "BB_RKL10.BAS - Single record lock test"
PRINT ">> USING DIRECTORY "; UseDir$
PRINT

TYPE TestRecTYPE
Tag AS STRING * 1
Codenumber AS STRING * 4
Codename AS STRING * 11
END TYPE '16               
                             
DIM DFP AS DOSFilePack
DIM MP AS MemoryPack
DIM IP AS InitPack
DIM EP AS ExitPack
DIM CDP AS CreateDataPack
DIM OP AS OpenPack
DIM AP AS AccessPack

DIM FieldList(1 TO 2) AS FieldDescTYPE
DIM TestRec AS TestRecTYPE
DIM ZSTR AS STRING * 1
DIM NameDAT AS STRING * 80

ZSTR = CHR$(0)
NameDAT = UseDir$ + "RKLTEST.DBB" + ZSTR
'no index file is used (or needed)

FieldList(1).FieldName = "CODENUMBER" + ZSTR
FieldList(1).FieldType = "C"
FieldList(1).FieldLength = CHR$(4)
FieldList(1).FieldDC = CHR$(0)
FieldList(2).FieldName = "CODENAME" + ZSTR + ZSTR
FieldList(2).FieldType = "C"
FieldList(2).FieldLength = CHR$(11)
FieldList(2).FieldDC = CHR$(0)

level = 100
MP.Func = MemoryXB
stat = BULLET(MP)
IF MP.Memory < 140000 THEN
    QBheap& = SETMEM(-150000)       'hog wild, 64K would do okay
    MP.Func = MemoryXB
    stat = BULLET(MP)
    IF MP.Memory < 140000 THEN stat = 8: GOTO Abend
END IF

level = 110
IP.Func = InitXB
IP.JFTmode = 0
stat = BULLET(IP)
IF stat THEN GOTO Abend

level = 120
EP.Func = AtExitXB
stat = BULLET(EP)

level = 130
DFP.Func = DeleteFileDOS
DFP.FilenamePtrOff = VARPTR(NameDAT)
DFP.FilenamePtrSeg = VARSEG(NameDAT)
stat = BULLET(DFP)

level = 1000
CDP.Func = CreateDXB
CDP.FilenamePtrOff = VARPTR(NameDAT)
CDP.FilenamePtrSeg = VARSEG(NameDAT)
CDP.NoFields = 2
CDP.FieldListPtrOff = VARPTR(FieldList(1))
CDP.FieldListPtrSeg = VARSEG(FieldList(1))
CDP.FileID = 3
stat = BULLET(CDP)
IF stat THEN GOTO Abend

level = 1010
OP.Func = OpenDXB
OP.FilenamePtrOff = VARPTR(NameDAT)
OP.FilenamePtrSeg = VARSEG(NameDAT)
OP.ASmode = ReadWrite + DenyNone
stat = BULLET(OP)
IF stat THEN GOTO Abend
HandDAT = OP.Handle

AP.Func = AddRecordXB
AP.Handle = HandDAT
AP.RecPtrOff = VARPTR(TestRec)
AP.RecPtrSeg = VARSEG(TestRec)
TestRec.Tag = " "
Recs2Add& = 100&

level = 1200
PRINT "Adding"; Recs2Add&; "records..."
FOR recs& = 1 TO Recs2Add&
   TestRec.Codenumber = STR$(recs&)
   TestRec.Codename = "rec for" + STR$(recs&)
   stat = BULLET(AP)
   IF stat THEN stat = AP.stat: GOTO Abend
NEXT
PRINT

level = 1300
PRINT "Locking record 5  stat:";
AP.Func = LockDataXB
AP.RecNo = 5
stat = BULLET(AP)
PRINT stat
PRINT

level = 1310
PRINT "Attempting to lock entire data file (this will fail)"
AP.Func = LockDataXB
AP.RecNo = 0
stat = BULLET(AP)
PRINT "Status on full-lock is:"; stat
PRINT

level = 1320
PRINT "Unlocking record 5  stat:";
AP.Func = UnlockDataXB
AP.RecNo = 5
stat = BULLET(AP)
PRINT stat
PRINT

PRINT "Okay."
EndIt:
EP.Func = ExitXB
stat = BULLET(EP)
END

Abend:
PRINT
PRINT "Unexpected error:"; stat; "at level"; level
GOTO EndIt

