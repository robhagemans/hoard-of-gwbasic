
DEFINT A-Z

REM $INCLUDE: 'BULLET.BI'
'bb_lau10.BAS 31-May-92 chh
'--add/reindex/update using 32-bit long integer key, unique to current files
'1) this code uses a non-standard binary field as a sort field
'2) this code is for raw speed tests--it's straight inline
'C>bc bb_lau10 /o;
'C>link bb_lau10,,nul,bullet;

UseDir$ = ".\"                  'all files use this directory except
                                'the reindex work file which uses the
                                'SET TMP= directory or the current directory
CLS
PRINT "BB_UPD10.BAS - LONG INT, SIGNED, UNIQUE UpdateXB test program (Update)"
PRINT "--uses non-standard data files with binary field values, not DBF"
PRINT ">> USING DIRECTORY "; UseDir$
PRINT

TYPE TestRecTYPE
Tag AS STRING * 1
Codenumber AS LONG              'this is the key field (a BINARY type) and
Codename AS STRING * 11         'is not readable by standard dBASE III DBMSs
END TYPE '16                    '--it's used here for speed
                                'that's it for comments, simple stuff follows
DIM DFP AS DOSFilePack
DIM MP AS MemoryPack
DIM IP AS InitPack
DIM EP AS ExitPack
DIM CDP AS CreateDataPack
DIM CKP AS CreateKeyPack
DIM OP AS OpenPack
DIM AP AS AccessPack

DIM FieldList(1 TO 2) AS FieldDescTYPE
DIM TestRec AS TestRecTYPE
DIM ZSTR AS STRING * 1
DIM NameDAT AS STRING * 80
DIM NameIX1 AS STRING * 80
DIM KX1 AS STRING * 136
DIM KeyBuffer AS STRING * 64
DIM CurrKey AS STRING * 64

ZSTR = CHR$(0)
NameDAT = UseDir$ + "BINTEST.DBB" + ZSTR   '.DBB since extended DBF type
NameIX1 = UseDir$ + "BINTEST.IX1" + ZSTR

FieldList(1).FieldName = "CODENUMBER" + ZSTR
FieldList(1).FieldType = "B"
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
DFP.FilenamePtrOff = VARPTR(NameIX1)
DFP.FilenamePtrSeg = VARSEG(NameIX1)
stat = BULLET(DFP)

level = 1000
CDP.Func = CreateDXB
CDP.FilenamePtrOff = VARPTR(NameDAT)
CDP.FilenamePtrSeg = VARSEG(NameDAT)
CDP.NoFields = 2
CDP.FieldListPtrOff = VARPTR(FieldList(1))
CDP.FieldListPtrSeg = VARSEG(FieldList(1))
CDP.FileID = &HFF  '<<== NON-standard DBF file ID
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

level = 1100
KX1 = "CODENUMBER" + ZSTR
CKP.Func = CreateKXB
CKP.FilenamePtrOff = VARPTR(NameIX1)
CKP.FilenamePtrSeg = VARSEG(NameIX1)
CKP.KeyExpPtrOff = VARPTR(KX1)
CKP.KeyExpPtrSeg = VARSEG(KX1)
CKP.XBlink = HandDAT
CKP.KeyFlags = cLONG + cSIGNED + cUNIQUE
CKP.CodePageID = -1
CKP.CountryCode = -1
CKP.CollatePtrOff = 0
CKP.CollatePtrSeg = 0
stat = BULLET(CKP)
IF stat THEN GOTO Abend

level = 1110
OP.Func = OpenKXB
OP.FilenamePtrOff = VARPTR(NameIX1)
OP.FilenamePtrSeg = VARSEG(NameIX1)
OP.ASmode = ReadWrite + DenyNone
OP.xbHandle = HandDAT
stat = BULLET(OP)
IF stat THEN GOTO Abend
HandIX1 = OP.Handle

AP.Func = AddRecordXB
AP.Handle = HandDAT
AP.RecPtrOff = VARPTR(TestRec)
AP.RecPtrSeg = VARSEG(TestRec)
AP.KeyPtrOff = VARPTR(KeyBuffer)
AP.KeyPtrSeg = VARSEG(KeyBuffer)
AP.NextPtrOff = 0
AP.NextPtrSeg = 0
TestRec.Tag = " "
TestRec.Codename = "xxxSAMExxxx"
INPUT "Recs to add/reindex:"; Recs2Add&

level = 1200
low& = 1
high& = low& + Recs2Add& - 1
PRINT "Adding"; Recs2Add&; "records ( keys "; low&; "to"; high&; ")...";
GOSUB StartTimer
FOR recs& = low& TO high&
   TestRec.Codenumber = recs&   'key field will be same as record number
   stat = BULLET(AP)            'codename field same for all records
   IF stat THEN GOTO Abend      'in this test
NEXT
GOSUB EndTimer
PRINT secs&; "secs."

level = 1210
PRINT "Reindexing...";
AP.Func = ReindexXB
AP.Handle = HandIX1
GOSUB StartTimer
sidx = BULLET(AP)
stat = AP.stat
IF stat THEN GOTO Abend
GOSUB EndTimer
PRINT secs&; "secs."

AP.Handle = HandIX1
AP.RecPtrOff = VARPTR(TestRec)
AP.RecPtrSeg = VARSEG(TestRec)
AP.KeyPtrOff = VARPTR(KeyBuffer)
AP.KeyPtrSeg = VARSEG(KeyBuffer)
AP.NextPtrOff = 0
AP.NextPtrSeg = 0
TestRec.Tag = " "
INPUT "Records to update:"; Recs2Upd&
IF Recs2Upd& > Recs2Add& THEN Recs2Upd& = Recs2Add&

level = 1250
PRINT "Updating first"; Recs2Upd&; "recs (modifying sign of each key)...";
GOSUB StartTimer
AP.Func = GetFirstXB
cnt& = 0&               'count updates since we skip if error 201 occurs...
DO                      '...it won't in this test since all numbers are +
   stat = BULLET(AP)
   IF stat = 0 THEN
      CurrKey = KeyBuffer            'save current key to reposition later
      IF TestRec.Codenumber > 0 THEN
         TestRec.Codenumber = -TestRec.Codenumber
      ELSE
         TestRec.Codenumber = TestRec.Codenumber * -1
      END IF
      TestRec.Codename = "***UPDATED*"
      AP.Func = UpdateXB
      stat = BULLET(AP)
      IF stat = 0 AND AP.stat = 0 THEN

         'must repostion to previous key to continue with GetNextXBs
         'stat will return with key not found as expected, it's been
         'changed to a negative value, no problem, GetNextXB knows...

         KeyBuffer = CurrKey
         AP.Func = GetEqualXB
         stat = BULLET(AP)

         AP.Func = GetNextXB
         cnt& = cnt& + 1
      ELSE
         IF AP.stat <> 201 THEN
            stat = AP.stat: GOTO Abend
         ELSE
            stat = 0   'if we had negative numbers already then changing the
         END IF        'sign would result in it matching a key already in the
      END IF           'index (this is a very simple test program)
   ELSE
      IF stat = 202 THEN stat = 0
      EXIT DO
   END IF
LOOP UNTIL cnt& >= Recs2Upd&
GOSUB EndTimer
PRINT secs&; "secs."
PRINT "updated:"; cnt&; "keys."

level = 1300
PRINT "  The first 5 keys/recs"
AP.Func = GetFirstXB
stat = BULLET(AP)
PRINT AP.Recno, TestRec.Codenumber; TestRec.Codename
FOR i = 1 TO 4
IF stat THEN EXIT FOR
   AP.Func = GetNextXB
   stat = BULLET(AP)
   PRINT AP.Recno, TestRec.Codenumber; TestRec.Codename
NEXT
IF stat = 202 THEN stat = 0
IF stat THEN GOTO Abend
PRINT

level = 1310
PRINT "  The last 5 keys/recs"
AP.Func = GetLastXB
stat = BULLET(AP)
PRINT AP.Recno, TestRec.Codenumber; TestRec.Codename
FOR i = 1 TO 4
   IF stat THEN EXIT FOR
   AP.Func = GetPrevXB
   stat = BULLET(AP)
   PRINT AP.Recno, TestRec.Codenumber; TestRec.Codename
NEXT
IF stat THEN GOTO Abend

PRINT "Okay."
EndIt:
EP.Func = ExitXB
stat = BULLET(EP)
END


Abend:
PRINT
PRINT "Error:"; stat; "at level"; level; "while performing ";
SELECT CASE level
CASE IS = 999
   SELECT CASE level
   CASE 100
      PRINT "a memory request of 150K."
   CASE 110
      PRINT "BULLET initialization."
   CASE 120
      PRINT "registering of ExitXB with _atexit."
   CASE ELSE
      PRINT "Preliminaries unknown."
   END SELECT
CASE IS <= 1099
   SELECT CASE level
   CASE 1000
      PRINT "data file create."
   CASE 1010
      PRINT "data file open."
   CASE ELSE
      PRINT "data file unknown."
   END SELECT
CASE IS <= 1199
   SELECT CASE level
   CASE 1000
      PRINT "index file create."
   CASE 1010
      PRINT "index file open."
   CASE ELSE
      PRINT "index file unknown."
   END SELECT
CASE IS <= 1299
   SELECT CASE level
   CASE 1200
      PRINT "adding."
   CASE 1210
      PRINT "reindexing."
   CASE 1250
      PRINT "updating."
   CASE ELSE
      PRINT "unknown."
   END SELECT
CASE IS <= 1399
   SELECT CASE level
   CASE 1300
      PRINT "GetFirst/Next."
   CASE 1310
      PRINT "GetLast/Prev."
   CASE ELSE
      PRINT "Get/unknown."
   END SELECT
CASE ELSE
   PRINT "unknown."
END SELECT
GOTO EndIt

'----------
StartTimer:
DEF SEG = &H40
lb1 = PEEK(&H6C)
hb1 = PEEK(&H6D)
lb2 = PEEK(&H6E)
DEF SEG
stime& = CVL(CHR$(lb1) + CHR$(hb1) + CHR$(lb2) + ZSTR)
RETURN

EndTimer:
DEF SEG = &H40
lb1 = PEEK(&H6C)
hb1 = PEEK(&H6D)
lb2 = PEEK(&H6E)
DEF SEG
etime& = CVL(CHR$(lb1) + CHR$(hb1) + CHR$(lb2) + ZSTR)
secs& = ((etime& - stime&) * 10) \ 182
RETURN

