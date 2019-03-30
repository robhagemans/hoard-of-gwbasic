
DEFINT A-Z

REM $INCLUDE: 'BULLET.BI'
'bb_cai10.bas 31-May-92 chh
'--example using 8-char key, dups and
'--a second index of LONG INT (on SSN field), dups allowed for this example

'this code is for a simplistic database
'it uses a single DBF (true DBF-compat) and two related indexes
'the first index is on the first 5 chars of last name + first char first name
'second index is on the SSN, since it's a valid LONG INT we use that key type

'C>bc bb_cai10 /o;
'C>link bb_cai10,,nul,bullet;

UseDir$ = ".\"                  'all files use this directory except
                                'the reindex work file which uses the
                                'SET TMP= directory or the current directory
CLS
PRINT "BB_CAI10.BAS - 8-CHAR (DUPS) and LONG INT (DUPS), add/reindex example"
PRINT "--maintains *2* index files automatically, using NLS sorting."
PRINT ">> USING DIRECTORY "; UseDir$
PRINT

TYPE TestRecTYPE
Tag AS STRING * 1
FirstName AS STRING * 15        'a DBF C fieldtype
LastName AS STRING * 19         'C
SSN AS STRING * 9               'N (use C instead to use SUBSTR() on it)
BDate AS STRING * 8             'D
DeptNo AS STRING * 3            'C
Salary AS STRING * 9            'N
END TYPE '64                    'DBF III+ limit is 4000 bytes/128 fields
                                
DIM DFP AS DOSFilePack
DIM MP AS MemoryPack
DIM IP AS InitPack
DIM EP AS ExitPack
DIM CDP AS CreateDataPack
DIM CKP AS CreateKeyPack
DIM OP AS OpenPack
DIM AP(1 TO 2) AS AccessPack    '2 since we're maintaining 2 index files

DIM FieldList(1 TO 6) AS FieldDescTYPE
DIM TestRec AS TestRecTYPE
DIM ZSTR AS STRING * 1
DIM NameDAT AS STRING * 80      'DBF data file
DIM NameIX1 AS STRING * 80      'first index file
DIM NameIX2 AS STRING * 80      'second index file
DIM KX1 AS STRING * 136         'key expression for first index file
DIM KX2 AS STRING * 136         'key expression for second index file
DIM KeyBuffer AS STRING * 64

DIM First$(1 TO 26)
DIM Last$(1 TO 26)
GOSUB FillNamesIn

ZSTR = CHR$(0)
NameDAT = UseDir$ + "CHARTEST.DBF" + ZSTR
NameIX1 = UseDir$ + "CHARTEST.IX1" + ZSTR
NameIX2 = UseDir$ + "CHARTEST.IX2" + ZSTR

FieldList(1).FieldName = "FIRSTNAME" + ZSTR
FieldList(1).FieldType = "C"
FieldList(1).FieldLength = CHR$(15)
FieldList(1).FieldDC = CHR$(0)
FieldList(2).FieldName = "LASTNAME" + ZSTR + ZSTR
FieldList(2).FieldType = "C"
FieldList(2).FieldLength = CHR$(19)
FieldList(2).FieldDC = CHR$(0)
FieldList(3).FieldName = "SSN" + STRING$(7, 0)
FieldList(3).FieldType = "N"
FieldList(3).FieldLength = CHR$(9)
FieldList(3).FieldDC = CHR$(0)
FieldList(4).FieldName = "BDATE" + STRING$(5, 0)
FieldList(4).FieldType = "D"
FieldList(4).FieldLength = CHR$(8)
FieldList(4).FieldDC = CHR$(0)
FieldList(5).FieldName = "DEPTNO" + STRING$(4, 0)
FieldList(5).FieldType = "C"
FieldList(5).FieldLength = CHR$(3)
FieldList(5).FieldDC = CHR$(0)
FieldList(6).FieldName = "SALARY" + STRING$(4, 0)
FieldList(6).FieldType = "N"
FieldList(6).FieldLength = CHR$(9)
FieldList(6).FieldDC = CHR$(2)

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
DFP.FilenamePtrOff = VARPTR(NameIX2)
DFP.FilenamePtrSeg = VARSEG(NameIX2)
stat = BULLET(DFP)

level = 1000
CDP.Func = CreateDXB
CDP.FilenamePtrOff = VARPTR(NameDAT)
CDP.FilenamePtrSeg = VARSEG(NameDAT)
CDP.NoFields = 6
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

level = 1100
KX1 = "SUBSTR(LASTNAME,1,5)+SUBSTR(FIRSTNAME,1,1)"
CKP.Func = CreateKXB
CKP.FilenamePtrOff = VARPTR(NameIX1)
CKP.FilenamePtrSeg = VARSEG(NameIX1)
CKP.KeyExpPtrOff = VARPTR(KX1)
CKP.KeyExpPtrSeg = VARSEG(KX1)
CKP.XBlink = HandDAT
CKP.KeyFlags = cCHAR
CKP.CodePageID = -1
CKP.CountryCode = -1
CKP.CollatePtrOff = 0
CKP.CollatePtrSeg = 0
stat = BULLET(CKP)
IF stat THEN GOTO Abend

level = 1102
KX2 = "SSN"
CKP.Func = CreateKXB
CKP.FilenamePtrOff = VARPTR(NameIX2)
CKP.FilenamePtrSeg = VARSEG(NameIX2)
CKP.KeyExpPtrOff = VARPTR(KX2)
CKP.KeyExpPtrSeg = VARSEG(KX2)
CKP.XBlink = HandDAT
CKP.KeyFlags = cLONG
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

level = 1112
OP.Func = OpenKXB
OP.FilenamePtrOff = VARPTR(NameIX2)
OP.FilenamePtrSeg = VARSEG(NameIX2)
OP.ASmode = ReadWrite + DenyNone
OP.xbHandle = HandDAT
stat = BULLET(OP)
IF stat THEN GOTO Abend
HandIX2 = OP.Handle

AP(1).Func = AddRecordXB
AP(1).Handle = HandDAT
AP(1).RecPtrOff = VARPTR(TestRec)
AP(1).RecPtrSeg = VARSEG(TestRec)
AP(1).KeyPtrOff = VARPTR(KeyBuffer)
AP(1).KeyPtrSeg = VARSEG(KeyBuffer)
AP(1).NextPtrOff = VARPTR(AP(2))
AP(1).NextPtrSeg = VARSEG(AP(2))
AP(2).Func = AddRecordXB
AP(2).Handle = HandDAT
AP(2).RecPtrOff = VARPTR(TestRec)
AP(2).RecPtrSeg = VARSEG(TestRec)
AP(2).KeyPtrOff = VARPTR(KeyBuffer)
AP(2).KeyPtrSeg = VARSEG(KeyBuffer)
AP(2).NextPtrOff = 0
AP(2).NextPtrSeg = 0

level = 1200
INPUT "Recs to add/reindex:"; Recs2Add&
PRINT "Adding"; Recs2Add&; "records...";

'these are not key values so just make them constant for this example

TestRec.Tag = " "
TestRec.BDate = "19331122"   'yes, everyone is the same age
TestRec.DeptNo = "001"       'yes, same dept too
TestRec.Salary = "125000.77" 'and even the same salary

GOSUB StartTimer
FOR recs& = 1 TO Recs2Add&
   RandLN = 1 + (25 * RND)
   RandFN = 1 + (25 * RND)
   TestRec.FirstName = First$(RandLN)
   TestRec.LastName = Last$(RandFN)
   TestRec.SSN = LTRIM$(STR$(100000000 + (899999999 * RND)))
   stat = BULLET(AP(1))
   IF stat THEN GOTO Abend
NEXT
GOSUB EndTimer
PRINT secs&; "secs."

level = 1210                            'could also reindex separately
PRINT "Reindexing BOTH index files... ";
AP(1).Func = ReindexXB
AP(2).Func = ReindexXB
AP(1).Handle = HandIX1
AP(2).Handle = HandIX2
GOSUB StartTimer
sidx = BULLET(AP(1))
IF sidx THEN stat = AP(sidx).stat
IF stat THEN PRINT "on index"; sidx: GOTO Abend
GOSUB EndTimer
PRINT secs&; "secs."

level = 1300
AP(1).Func = GetFirstXB
stat = BULLET(AP(1))
PRINT
PRINT "Using key expression: "; RTRIM$(KX1)
PRINT
PRINT "...the first 5 keys/recs for first index file "
CIX = 1: GOSUB DispRecord
FOR i = 1 TO 4
   IF stat THEN EXIT FOR
   AP(1).Func = GetNextXB
   stat = BULLET(AP(1))
   GOSUB DispRecord
NEXT
IF stat = 202 THEN stat = 0
IF stat THEN GOTO Abend
PRINT

level = 1310
AP(1).Func = GetLastXB
stat = BULLET(AP(1))
PRINT "...the last 5 keys/recs for first index file "
CIX = 1: GOSUB DispRecord
FOR i = 1 TO 4
   IF stat THEN EXIT FOR
   AP(1).Func = GetPrevXB
   stat = BULLET(AP(1))
   GOSUB DispRecord
NEXT
IF stat THEN GOTO Abend
PRINT
PRINT "* Press any key to see first/last 5 for SECOND index file";
DO: LOOP UNTIL LEN(INKEY$)
LOCATE , 1

level = 1302
AP(2).Func = GetFirstXB
stat = BULLET(AP(2))
PRINT SPACE$(79);
LOCATE , 1
PRINT "Using key expression: "; RTRIM$(KX2)
PRINT
PRINT "...the first 5 keys/recs for second index file "
CIX = 2: GOSUB DispRecord
FOR i = 1 TO 4
   IF stat THEN EXIT FOR
   AP(2).Func = GetNextXB
   stat = BULLET(AP(2))
   GOSUB DispRecord
NEXT
IF stat = 202 THEN stat = 0
IF stat THEN GOTO Abend
PRINT

level = 1312
AP(2).Func = GetLastXB
stat = BULLET(AP(2))
PRINT "...the last 5 keys/recs for second index file "
CIX = 2: GOSUB DispRecord
FOR i = 1 TO 4
   IF stat THEN EXIT FOR
   AP(2).Func = GetPrevXB
   stat = BULLET(AP(2))
   GOSUB DispRecord
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
   CASE 1100
      PRINT "first index file create."
   CASE 1102
      PRINT "second index file create."
   CASE 1110
      PRINT "first index file open."
   CASE 1112
      PRINT "second index file open."
   CASE ELSE
      PRINT "index file unknown."
   END SELECT
CASE IS <= 1299
   SELECT CASE level
   CASE 1200
      PRINT "adding records."
   CASE 1210
      PRINT "reindexing."
   CASE ELSE
      PRINT "adding unknown."
   END SELECT
CASE IS <= 1399
   SELECT CASE level
   CASE 1300
      PRINT "first index file GetFirst/Next."
   CASE 1302
      PRINT "second index file GetFirst/Next."
   CASE 1310
      PRINT "first index file GetLast/Prev."
   CASE 1312
      PRINT "second index file GetLast/Prev."
   CASE ELSE
      PRINT "Get/unknown."
   END SELECT
CASE ELSE
   PRINT "unknown."
END SELECT
GOTO EndIt

'----------
DispRecord:
t$ = SPACE$(79)
MID$(t$, 1, 6) = RIGHT$("     " + LTRIM$(STR$(AP(CIX).Recno)), 6)
MID$(t$, 7, 1) = TestRec.Tag
t2$ = RTRIM$(TestRec.LastName) + ", " + RTRIM$(TestRec.FirstName)
MID$(t$, 8, 30) = t2$
t2$ = MID$(TestRec.SSN, 1, 3) + "-" + MID$(TestRec.SSN, 4, 2) + "-" + MID$(TestRec.SSN, 6, 4)
MID$(t$, 40, 11) = t2$
t2$ = MID$(TestRec.BDate, 5, 2) + "/" + MID$(TestRec.BDate, 7, 2) + "/" + MID$(TestRec.BDate, 3, 2)
MID$(t$, 53, 8) = t2$
MID$(t$, 63, 3) = TestRec.DeptNo
MID$(t$, 68, 9) = TestRec.Salary
PRINT t$
RETURN

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

FillNamesIn:
FOR i = 1 TO 26
   READ F$
   First$(i) = F$ + SPACE$(15)  'space-fill names
NEXT
FOR i = 1 TO 26
   READ L$
   Last$(i) = L$ + SPACE$(19)
NEXT
RETURN

DATA "Arturo","Bebe","Clarisa","Diamond","Eve","Franklin","Gweny","Horatio"
DATA "Iggie","Jammal","Kevin","Legs","Michelle","Nova","Obar","Pepi","Quartz"
DATA "Raul","Santa","Thomas","Uve","Vue","Winchester","Xeba","Yve","Zanzi"

DATA "Abelson","ABELSON","Charlieson","Deltason","Epsilson","Foxson","Gamson","Hydra"
DATA "Manson","Jumpson","Kiloson","Loxson", "Moonson","Noson","Octson"
DATA "Pepson","Quarterson","Renoson","Salvoson","Tooson","Underson","Vulcanson"
DATA "Weaverson","Xanson","ZENDASON","Zendason"

