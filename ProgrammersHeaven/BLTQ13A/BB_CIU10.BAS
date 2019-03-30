
DEFINT A-Z

REM $INCLUDE: 'BULLET.BI'
'bb_ciu10.bas 31-May-92 chh
'--example using 8-char key, dups and         
'--a second index of LONG INT (on SSN field), unique to check Update xaction

'this example shows the transaction-based feature of UpdateXB--it purposely
'inserts to the two index files, and then will do Updates of already existing
'SSN key, thus causing all the Updates to be backed-out except the
'very last (since the last is changed in a way that no current key matches)
'See BB_CIN10.BAS for more on transaxtion-based info

'this code is for a simplistic database
'it uses a single DBF (true DBF-compat) and two related indexes
'the first index is on the first 5 chars of last name + first char first name
'second index is on the SSN, since it's a valid LONG INT we use that key type

'C>bc bb_ciu10 /o;
'C>link bb_ciu10,,nul,bullet;

UseDir$ = ".\"                  'all files use this directory except
                                'the reindex work file which uses the
                                'SET TMP= directory or the current directory
CLS
PRINT "BB_CIU10.BAS - 8-CHAR (DUPS) and LONG INT (UNIQUE), UpdateXB example"
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
DIM SDP AS StatDataPack
DIM SKP AS StatKeyPack
DIM XEP AS XErrorPack

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
PRINT "free DGROUP:"; FRE(a$)

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
CKP.KeyFlags = cLONG + cSIGNED + cUNIQUE 'test transaction ability by forcing
CKP.CodePageID = -1                      'duplicate SSN numbers
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

AP(1).Func = InsertXB
AP(1).Handle = HandIX1
AP(1).RecPtrOff = VARPTR(TestRec)
AP(1).RecPtrSeg = VARSEG(TestRec)
AP(1).KeyPtrOff = VARPTR(KeyBuffer)
AP(1).KeyPtrSeg = VARSEG(KeyBuffer)
AP(1).NextPtrOff = VARPTR(AP(2))
AP(1).NextPtrSeg = VARSEG(AP(2))
AP(2).Func = InsertXB
AP(2).Handle = HandIX2
AP(2).RecPtrOff = VARPTR(TestRec)
AP(2).RecPtrSeg = VARSEG(TestRec)
AP(2).KeyPtrOff = VARPTR(KeyBuffer)
AP(2).KeyPtrSeg = VARSEG(KeyBuffer)
AP(2).NextPtrOff = 0
AP(2).NextPtrSeg = 0

level = 1200
'keep Recs to insert below 1000 since there SSN values generated in this
'example range from 100000000 to 1000000999

INPUT "(suggest no more than 1000) Recs to insert:"; Recs2Add&
PRINT "Inserting record:";
herecol = POS(0)

'these are not key values so just make them constant for this example

TestRec.Tag = " "
TestRec.BDate = "19331122"   'yes, everyone is the same age
TestRec.DeptNo = "001"       'yes, same dept too
TestRec.Salary = "125000.77" 'and even the same salary

'RANDOMIZE TIMER
level = 1200
GOSUB StartTimer
FOR Recs& = 1 TO Recs2Add&

   'we want to know what's being used so we can verify that all was restored

   TestRec.FirstName = First$(1 + Recs& MOD 25)
   TestRec.LastName = Last$(1 + Recs& MOD 25)
   TestRec.SSN = STR$(Recs&)

   stat = 0
   LOCATE , herecol
   PRINT Recs&;

   sidx = BULLET(AP(1))
   IF sidx = 0 AND AP(1).stat THEN
      'error on data record add portion of insert
      stat = AP(1).stat
      GOTO Abend                        'consider this a fatal error
   ELSEIF sidx THEN
      stat = AP(sidx).stat
      IF stat <> 201 THEN
         GOTO Abend                     'this too
      ELSE  'key already exists test    'a key already exists just skip
         'won't happen in this example since we have duplicates okay
         'for the first index file
         STOP
      END IF
   END IF

NEXT
GOSUB EndTimer
LOCATE , 60
PRINT "..."; secs&; "secs."


PRINT  'show the first 5 data record in recno order (original data)
PRINT "...the first 5 recs data file (original, before UpdateXB)"
CIX = 1
AP(1).Func = GetRecordXB
AP(1).Handle = HandDAT
FOR i = 1 TO 5
   AP(1).Recno = i
   stat = BULLET(AP(1))
   GOSUB DispRecord
NEXT
IF stat = 202 THEN stat = 0
IF stat THEN GOTO Abend
PRINT

PRINT
PRINT "...the last 5 recs data file "
AP(1).Func = GetRecordXB
FOR i = Recs2Add& TO Recs2Add& - 4 STEP -1
   AP(1).Recno = i
   stat = BULLET(AP(1))
   GOSUB DispRecord
NEXT
IF stat = 202 THEN stat = 0
IF stat THEN GOTO Abend
PRINT
PRINT "* Press any key to update";
DO: LOOP UNTIL LEN(INKEY$)
LOCATE , 1

dups = 0
PRINT " Updating record:";
herecol = POS(0)

GOSUB StartTimer
FOR Recs& = 1 TO Recs2Add&

   AP(1).Func = GetRecordXB     'get the next data record
   AP(1).Handle = HandDAT
   AP(1).Recno = Recs&
   'AP(2).Recno = Recs&          'UpdateXB always uses AP(1).Recno as recno

   stat = BULLET(AP(1))

   'leave first index as is (UpdateXB won't modify the first
   '                         index file because the key field doesn't change)
   'TestRec.FirstName = First$(2 + Recs& MOD 24) 'change IX1 key field by using
   'TestRec.LastName = Last$(2 + Recs& MOD 24)   'next key's value

   'change the second index's key and show how the first is restored
   'since this SSN already exists (except for the very last record updated)
   '--the change is a simple "current + 1" which equal the following...
   '...this just to easily show the xaction control

   TestRec.SSN = STR$(Recs& + 1)                'for SSN key field, too

   stat = 0
   LOCATE , herecol
   PRINT Recs&;

   level = 1250
   AP(1).Func = UpdateXB
   'AP(2).Func = UpdateXB                'UpdateXB always uses AP(1).Func
   AP(1).Handle = HandIX1
   sidx = BULLET(AP(1))
   IF sidx = 0 AND AP(1).stat THEN
      'error on data record add portion of insert
      stat = AP(1).stat
      GOTO Abend                        'consider this a fatal error
   ELSEIF sidx THEN
      stat = AP(sidx).stat
      IF stat <> 201 THEN
         GOTO Abend                     'this too
      ELSE  'key already exists test    'a key already exists
         dups = dups + 1                'for this example--it backs out the
         PRINT "   SSN dups/Updates backed-out:"; dups;
         stat = 0
      END IF
   END IF

NEXT
GOSUB EndTimer
LOCATE , 60
PRINT "..."; secs&; "secs."
PRINT
PRINT "DUPS cnt="; dups;
GOSUB ShowStats

PRINT
PRINT "* Press any key to see first/last 5 record";
DO: LOOP UNTIL LEN(INKEY$)
LOCATE , 1

CIX = 1
level = 1290
PRINT "...the first 5 recs data file (after UpdateXB)"
AP(1).Func = GetRecordXB
AP(1).Handle = HandDAT
FOR i = 1 TO 5
   AP(1).Recno = i
   stat = BULLET(AP(1))
   GOSUB DispRecord
NEXT
IF stat = 202 THEN stat = 0
IF stat THEN GOTO Abend
PRINT

level = 1292
PRINT
PRINT "...the last 5 recs data file "
AP(1).Func = GetRecordXB
FOR i = Recs2Add& TO Recs2Add& - 4 STEP -1
   AP(1).Recno = i
   stat = BULLET(AP(1))
   GOSUB DispRecord
NEXT
IF stat = 202 THEN stat = 0
IF stat THEN GOTO Abend
PRINT
PRINT "Note that only the very last SSN update took effect (the first of the last 5)."
PRINT "All the others were backed-out and restored to the original state. Okay."
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
      PRINT "inserting records."
   CASE 1250
      PRINT "updating records."
   CASE ELSE
      PRINT "getting unknown."
   END SELECT
CASE IS <= 1399
   SELECT CASE level
   CASE ELSE
      PRINT "Get/unknown."
   END SELECT
CASE ELSE
   PRINT "unknown."
END SELECT
GOTO EndIt

'----------
ShowStats:
SDP.Func = StatDXB
SDP.Handle = HandDAT
stat = BULLET(SDP)
IF stat = 0 THEN
   PRINT "Records:"; SDP.Recs;
   SKP.Func = StatKXB
   SKP.Handle = HandIX1
   stat = BULLET(SKP)
   IF stat = 0 THEN
      PRINT " IX1:keys:"; SKP.Keys;
      SKP.Func = StatKXB
      SKP.Handle = HandIX2
      stat = BULLET(SKP)
      IF stat = 0 THEN
         PRINT " IX2:keys:"; SKP.Keys
      ELSE
         PRINT "*IX2:StatKXB"; stat
      END IF
   ELSE
      PRINT "*IX1:StatKXB"; stat
   END IF
ELSE
   PRINT "*DBF:StatDXB"; stat
END IF
RETURN

DispRecord:
t$ = SPACE$(79)
MID$(t$, 1, 6) = RIGHT$("     " + LTRIM$(STR$(AP(CIX).Recno)), 6)
MID$(t$, 7, 1) = TestRec.Tag
t2$ = RTRIM$(TestRec.LastName) + ", " + RTRIM$(TestRec.FirstName)
MID$(t$, 8, 30) = t2$
t2$ = MID$(TestRec.SSN, 1, 3) + "-" + MID$(TestRec.SSN, 4, 2) + "-" + MID$(TestRec.SSN, 6, 4)
MID$(t$, 40, 9) = t2$
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

