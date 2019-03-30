DECLARE FUNCTION DoBackup% (dfHandle%, kfHandle%)
DECLARE FUNCTION DoExpandFile% (kfHandle%)
DECLARE FUNCTION DoReindex% (kfHandle%)
DECLARE FUNCTION DoAdd% (kfHandle%)
DECLARE FUNCTION DoAddAll% (kfHandle%)
DECLARE FUNCTION DoClose% (dfHandle%, kfHandle%)
DECLARE FUNCTION DoCreateOpenDataFile% (dfHandle%)
DECLARE FUNCTION DoCreateOpenKeyFile% (dfHandle%, kfHandle%)
DECLARE FUNCTION DoExit% ()
DECLARE FUNCTION DoFirstThings% (dfHandle%, kfHandle%)
DECLARE FUNCTION DoGetEqual% (kfHandle%, match$)
DECLARE FUNCTION DoMemCheck% ()
DECLARE SUB DoPrint (kfHandle%, k$)
DECLARE FUNCTION DoShowFirst% (kfHandle%)
DECLARE FUNCTION DoShowNext% (kfHandle%)
DECLARE FUNCTION GetKeyInfo% (kfHandle%, kfKeyFlags%, kfKeyLen%)
DECLARE FUNCTION IsShareLoaded% ()

DEFINT A-Z

REM $INCLUDE: 'BULLET.BI'
'XB_SRC01.BAS 31-May-92 chh
'code example of a BULLET program that uses many of the BULLET routines--
'--though not really that well designed--an early ad-hoc design test bed

TYPE ScoreRecTYPE
tag AS STRING * 1       'MUST HAVE DELETE TAG SPACE DEFINED FOR BULLET USE
codename AS STRING * 6
score AS STRING * 4     'true DBF format has NUMERIC in ASCII, not binary form
END TYPE '11
DIM SHARED gScoreRec AS ScoreRecTYPE  'the only global variable

CONST MAXDF = 1         'max data files to be used concurrently (1-250)
CONST MAXKF = 1         'max key files to be used concurrently (1-250)
CONST MAXFD = 2         'max fields to be used concurrently (SUM of all!)
                        '          (this program has only 2 fields total)
                        'these values mainly for DoMemCheck here

                        'all variables are local to main and
                        'are passed if needed elsewhere rather
                        'than declaring then SHARED (why not)
                                   'because...
DIM SHARED dfHandle AS INTEGER    'DOS file handle to data file
DIM SHARED kfHandle AS INTEGER    'DOS file handle to key file

'note: if you run this program more than once without first deleting the
'two files this creates, then the program will end with a error 201 since
'the key file was created to all unique keys only (easy enough to change)
'--also, the Creating status will indicate error 80 (&H50) "Already exists"

CLS
PRINT "XSRC01.BAS"
PRINT "----------Key: CHARACTER, NLS, DUPLICATES ALLOWED"
stat = DoFirstThings(dfHandle, kfHandle)
PRINT "Using DOS handles:"; dfHandle; kfHandle
IF stat = 0 THEN
   INPUT "How may add loops (max=32000 loops, each loop is 14 recs)", a
   ts! = TIMER
   FOR i = 1 TO a
      stat = DoAddAll(dfHandle)
      IF stat THEN EXIT FOR
   NEXT
   te! = TIMER
   PRINT "add rec time"; te! - ts!
   IF stat = 0 THEN
      ts! = TIMER
      stat = DoReindex(kfHandle)
      te! = TIMER
      IF stat = 0 THEN
         stat = stat2
         PRINT "reindex time"; te! - ts!
         match$ = "SHARKY" + CHR$(0) + CHR$(0)
         stat = DoGetEqual(kfHandle, match$)
      END IF
   END IF
END IF
PRINT "status:"; stat;
SELECT CASE stat
CASE 202
   PRINT "Normal End Of File"
CASE 201
   PRINT "Keyfile created for UNIQUE keys and attempt to insert key that already exists"
   PRINT "Either allow duplicate keys (in CreateKXB) or delete key or delete file"
CASE ELSE
   PRINT "Look it up"
END SELECT
END

'data filename, number of fields
'(for each field) name, type, length, decimal count
DataFileInfo:
DATA ".\XSRC01.DBF"
DATA 2
DATA "CODENAME","C",6,0
DATA "SCORE","N",4,0

'key filename, key expression, key flags (see DOCs for flags)
KeyFileInfo:
DATA ".\XSRC01.DEX"
DATA "CODENAME"
DATA 2

'sample data for data file
'codename,score
SampleData:
DATA "SHARKY",100
DATA "Sharki",47
DATA "BRande",48
DATA "BRANDI",95
DATA "BWANA",66
DATA "SaysSo",87
DATA "SAYSNO",50
DATA "SEXIMA",69
DATA "BERLIN",55
DATA "MUNICH",44
DATA "FURTH",77
DATA "Goanna",61
DATA "Spock1",67
DATA "SPOCK2",99
DATA "",0

FUNCTION DoAdd (dfHandle)

'add a new entry into the database, locking all bytes in the key and data
'files if SHARE.EXE is loaded preventing other processes from accessing
'the two files while we're making changes to them

DIM AP AS AccessPack
DIM AnyKeyBuffer AS STRING * 64

ShareLoaded = IsShareLoaded

AP.Func = LockXB                    'first lock the key file and data file
AP.Handle = dfHandle
AP.RecPtrOff = VARPTR(gScoreRec)    'point to the data record
AP.RecPtrSeg = VARSEG(gScoreRec)
AP.KeyPtrOff = VARPTR(AnyKeyBuffer) 'point to the key buffer
AP.KeyPtrSeg = VARSEG(AnyKeyBuffer)
AP.NextPtrOff = 0                   'point to the next key file (none)
AP.NextPtrSeg = 0

LOCATE , 1
statLock = 0
IF ShareLoaded THEN
   AP.Handle = kfHandle             'want the kfHandle for the xaction lock
   PRINT "Initiating locks";
   stat = BULLET(AP)
   IF stat THEN statLock = AP.stat
   AP.Handle = dfHandle
END IF

stat = statLock
IF stat = 0 THEN                    'and now do the add
   'AP.Handle = kfHandle
   'AP.Func = InsertXB                  'both key and the data record
                                        '!not for this example, using ReindexXB
   AP.Func = AddRecordXB            'of just data record
   PRINT " - adding rec: "; gScoreRec.codename;
   stat = BULLET(AP)

   'since for InsertXB (and UpdateXB and LockXB) return not the
   'error status but rather the key file position number (since we
   'can Insert/Update/Lock up to 32 key files plus a data file at one
   'time) we must explicity check for the error status in AP.stat
   '(can still check AP.Stat even if not a xaction-based routine!)
   stat = AP.stat
   IF stat = 0 THEN PRINT " recno:"; AP.RecNo;
END IF

IF ShareLoaded AND (statLock = 0) THEN
   AP.Func = UnlockXB                  'if lock was successful must unlock
   AP.Handle = kfHandle
   PRINT " - released locks";
   stat = BULLET(AP)
   IF stat THEN stat = AP.stat
   PRINT stat
END IF
DoAdd = stat

END FUNCTION

FUNCTION DoAddAll (dfHandle)

'read the DATA codename and score and add it to the data file
'and insert its key to the key file

'done for each of the sample data items in SampleData:

'dfHandle is not needed because it is known to BULLET from the Open()

RESTORE SampleData
DO
   READ cname$, score$                  'score$ as string because DBF format
   IF LEN(cname$) = 0 THEN EXIT DO      'specifies all data in DBF files be
                                        'in ASCII format
   gScoreRec.codename = cname$
   RSET gScoreRec.score = score$        'right-justify score in field
   stat = DoAdd(dfHandle)               'insert gScoreRec and its key
LOOP UNTIL stat
DoAddAll = stat

END FUNCTION

FUNCTION DoBackup (dfHandle, kfHandle)

'backup the current files

DIM CP AS CopyPack
DIM BUname AS STRING * 64

BUname = ".\XSRC01.D!F" + CHR$(0)
CP.Func = BackupFileXB
CP.Handle = dfHandle
CP.FilenamePtrOff = VARPTR(BUname)
CP.FilenamePtrSeg = VARSEG(BUname)
stat = BULLET(CP)

IF stat = 0 THEN
   BUname = ".\XSRC01.D!X" + CHR$(0)
   CP.Func = BackupFileXB
   CP.Handle = kfHandle
   CP.FilenamePtrOff = VARPTR(BUname)
   CP.FilenamePtrSeg = VARSEG(BUname)
   stat = BULLET(CP)
END IF
DoBackup = stat

END FUNCTION

FUNCTION DoClose (dfHandle, kfHandle)

'close key file first, then data file

DIM HP AS HandlePack

HP.Func = CloseKXB
HP.Handle = kfHandle
stat = BULLET(HP)

HP.Func = CloseDXB
HP.Handle = dfHandle
stat2 = BULLET(HP)
IF stat = 0 THEN stat = stat2
DoClose = stat

END FUNCTION

FUNCTION DoCreateOpenDataFile (dfHandle)

'Create (if needed) and open data file

'Rtn: dfHandle DOS file handle

'--Demonstrates ability to specify data file format at run-time without
'hard-coding it at compile-time. This info could easily be specified
'interactively from the user, an external file, etc.

'FieldName MUST BE ZERO-FILLED TO CHARACTER POSITION 11
'technically, only A-Z and _ are allowed in DBF fieldnames
'also, all info should be in UPPER-CASE

DIM CDP AS CreateDataPack
DIM OP AS OpenPack

DIM XBdf AS STRING * 64         'used only for create (must be FIXED-LENGTH)
DIM NoFields AS INTEGER         'used only for create

RESTORE DataFileInfo
READ d$                         'filename
XBdf = d$ + CHR$(0)             'MUST ZERO-TERMINATE filename (0T)
READ NoFields                   'number of fields to process

'FieldList() is a temporary TYPEd array, needed only to create the data file
'--can be discarded after use. FieldDescTYPE defined in BULLET.BI.

REDIM FieldList(1 TO NoFields) AS FieldDescTYPE

FOR i = 1 TO NoFields
   READ FldName$, FldType$, FldLen, FldDC
   FieldList(i).FieldName = FldName$ + STRING$(10, 0)  'must zero-fill name
   FieldList(i).FieldType = FldType$
   FieldList(i).FieldLength = CHR$(FldLen)
   FieldList(i).FieldDC = CHR$(FldDC)
NEXT
CDP.Func = CreateDXB
CDP.FilenamePtrOff = VARPTR(XBdf)           'point to data filename
CDP.FilenamePtrSeg = VARSEG(XBdf)
CDP.NoFields = NoFields
CDP.FieldListPtrOff = VARPTR(FieldList(1))  'point to first field descriptor
CDP.FieldListPtrSeg = VARSEG(FieldList(1))
CDP.FileID = 3                              'standard DBF file ID

PRINT "Creating "; RTRIM$(XBdf); " stat:";
stat = BULLET(CDP)
PRINT stat

IF stat = 0 OR stat = &H50 THEN             'if created okay OR already exists
   OP.Func = OpenDXB                        'open it
   OP.FilenamePtrOff = VARPTR(XBdf)
   OP.FilenamePtrSeg = VARSEG(XBdf)
   OP.ASmode = &H42                         'DENY NONE (SHARE R/W ACCESS)
   PRINT " Opening "; RTRIM$(XBdf); " stat:";
   stat = BULLET(OP)
   PRINT stat
   dfHandle = OP.Handle                     'DOS file handle for data file
END IF
DoCreateOpenDataFile = stat

END FUNCTION

FUNCTION DoCreateOpenKeyFile (dfHandle, kfHandle)

'dfHandle is the DOS file handle for the open data file
'that this key file (to now be created) indexes

DIM CKP AS CreateKeyPack
DIM OP AS OpenPack

DIM XBkf AS STRING * 64         'key filename (must be FIXED-LENGTH)
DIM XBkx AS STRING * 104        'key expression (must be FIXED-LENGTH)
DIM XBkFlags AS INTEGER         'key type flags (see CreateKXB in CZHELP)

RESTORE KeyFileInfo
READ d$                              'filename
XBkf = d$ + CHR$(0)                  'MUST ZERO-TERMINATE filename
READ d$                              'key expression
XBkx = d$ + CHR$(0)                  'MUST ZERO-TERMINATE key expression (0T)
READ XBkFlags
CKP.Func = CreateKXB
CKP.FilenamePtrOff = VARPTR(XBkf)    'filename
CKP.FilenamePtrSeg = VARSEG(XBkf)
CKP.KeyExpPtrOff = VARPTR(XBkx)      'key expression
CKP.KeyExpPtrSeg = VARSEG(XBkx)
CKP.XBlink = dfHandle                'key file indexes this data file
CKP.KeyFlags = XBkFlags
CKP.CountryCode = -1
CKP.CodePageID = -1                  'uses default OS's NLS
CKP.CollatePtrOff = 0                'uses default OS's collate table
CKP.CollatePtrSeg = 0

PRINT "Creating "; RTRIM$(XBkf); " stat:";
stat = BULLET(CKP)
PRINT stat

IF stat = &H50 THEN stat = 0         'key file already exists, no problem

IF stat = 0 THEN                     'open the key file
   OP.Func = OpenKXB
   OP.ASmode = &H42                  'DENY NONE (SHARE R/W ACCESS)
   OP.xbHandle = dfHandle            'key file's link to the data file--
   OP.FilenamePtrOff = VARPTR(XBkf)  '--MUST be handle to open data file
   OP.FilenamePtrSeg = VARSEG(XBkf)
   PRINT " Opening "; RTRIM$(XBkf); " stat:";
   stat = BULLET(OP)
   PRINT stat
   kfHandle = OP.Handle              'DOS handle for this key file
END IF

DoCreateOpenKeyFile = stat

END FUNCTION

FUNCTION DoExit

'shutdown

DIM EP AS ExitPack

EP.Func = ExitXB
stat = BULLET(EP)
DoExit = stat

END FUNCTION

FUNCTION DoExpandFile (kfHandle)

DIM DFP AS DOSFilePack

DFP.Func = ExpandFileDOS
DFP.Handle = kfHandle
DFP.SeekOffset = 512&
stat = BULLET(DFP)
DoExpandFile = stat

END FUNCTION

FUNCTION DoFirstThings (dfHandle, kfHandle)

'init BULLET, check (and get if needed) memory,
'check if SHARE.EXE is installed (for record-locking),
'create the data and key files (if they don't exist), open them

DIM IP AS InitPack
DIM EP AS ExitPack

stat = DoMemCheck                            'check available OS memory
IF stat = 0 THEN
   IP.Func = InitXB
   IP.JFTmode = 1                            'expand for max 250 open files
   stat = BULLET(IP)
   PRINT "xb_ExitXB @ "; HEX$(IP.ExitPtrSeg); ":"; HEX$(IP.ExitPtrOff)
   EP.Func = AtExitXB
   stat2 = BULLET(EP)
   IF stat = 0 THEN
      stat = DoCreateOpenDataFile(dfHandle)     'create/open the DBF datafile
      IF stat = 0 THEN                          'create/open the key file
         stat = DoCreateOpenKeyFile(dfHandle, kfHandle)
      END IF
   END IF
END IF
DoFirstThings = stat

END FUNCTION

FUNCTION DoGetEqual (kfHandle, match$)

'get an exact match or position 'key pointer' to where it would have been
'for GetNext() or GetPrev() to start at a certain point

DIM AP AS AccessPack
DIM AnyKeyBuffer AS STRING * 64

AP.Func = GetEqualXB
AP.stat = 0
AP.Handle = kfHandle
AnyKeyBuffer = match$
AP.RecPtrOff = VARPTR(gScoreRec)        'gScoreRec is GLOBAL!
AP.RecPtrSeg = VARSEG(gScoreRec)        'because QB doesn't pass generic
AP.KeyPtrOff = VARPTR(AnyKeyBuffer)     'TYPEd variables unless you put the
AP.KeyPtrSeg = VARSEG(AnyKeyBuffer)     'TYPE in the parameter list (which
stat = BULLET(AP)   'makes it hard-coded, not generic)
DoGetEqual = stat

END FUNCTION

FUNCTION DoMemCheck

'make sure OS has enough memory available to it to satisify BULLET
'this only ensures that at this point there's enough OS memory available--
'--if you're using another library that makes calls to the OS for memory
'then that memory may be taken away (not likely to happen but be aware)
'--if debugging in environment make sure you don't restart the program
'without first completing through to the DoClose, else too many files will
'eventually occur, possibly with the side effect of an Error 8

'This is done because at startup BASIC by default uses all memory below
'the 640K mark (but not any UMB memory which BULLET can use). We can tell
'BASIC to release memory it owns by using SETMEM().

'BULLET allocates memory on an as-needed basis, specifically when a file
'is actually opened. When a file is closed that memory used by it is released
'back to the OS (operating system).

CONST NEM = 8           'error number returned if not enough memory avail

                        'the CONST used below pertain to this example program
                        'only--in yours make any necessay adjustments, or
                        'better still, develop your own memory required
                        'formula based on the one below--

CONST RAM4PACK = 40000  'bytes to reserve for PackDXB/ReindexKXB (minimum)
CONST RAM4MORE = 33000  '32K more will be tried/used if available

DIM MP AS MemoryPack

stat = 0                'this is a simple formula for memory required (MIN)
memreq& = 1& * (1264& * MAXKF) + (144& * MAXDF) + (32& * MAXFD) + RAM4PACK

needed& = memreq& + RAM4MORE         'reduce by what's needed+try 32K more
MP.Func = MemoryXB
stat = BULLET(MP)
IF MP.Memory < needed& THEN
    QBheap& = SETMEM(-needed&)       'ask for what we need
    stat = BULLET(MP)
    IF MP.Memory < memreq& THEN stat = NEM   'settle for min request
END IF

PRINT "Total QB heap memory available:"; SETMEM(0)
PRINT "OS memory available ( < 640K) :"; MP.Memory; " (not including UMBs)"
DoMemCheck = stat

END FUNCTION

SUB DoPrint (kfHandle, k$)

'print the key (k$) and the data record (gScoreRec)

'key is passed as a FIXED-LENGTH but is a VAR-LEN string in the parm list
'this because that what QB 4.x needs

stat = GetKeyInfo(kfHandle, kfKeyFlags, kfKeyLen)
IF stat = 0 THEN
   IF (kfKeyFlags AND 2) THEN           'character key
      IF (kfKeyFlags AND 1) = 0 THEN
         kfKeyLen = kfKeyLen - 2        'remove enumerator if non-unique
         IF kfKeyLen < 1 THEN STOP
      END IF
      PRINT "key: "; LEFT$(k$, kfKeyLen); "  rec: "; gScoreRec.codename; gScoreRec.score

   ELSEIF (kfKeyFlags AND 16) THEN      'integer key

      PRINT "key: "; CVI(k$), "  rec: "; gScoreRec.codename; gScoreRec.score

   END IF
END IF
END SUB

FUNCTION DoReindex (kfHandle)

'backup and reindex the key file

DIM AP AS AccessPack

AP.Func = ReindexXB
AP.Handle = kfHandle
stat = BULLET(AP)
IF stat THEN stat = AP.stat
DoReindex = stat

END FUNCTION

FUNCTION DoShowFirst (kfHandle)

'get the first key and load its data record into ScoreRec
'print it to the screen

DIM AP AS AccessPack
DIM AnyKeyBuffer AS STRING * 64

AP.Func = GetFirstXB                    'yes,this code is exactly the same
AP.stat = 0                             'as DoShowNext() except for AP.Func
AP.Handle = kfHandle
AnyKeyBuffer = ""
AP.RecPtrOff = VARPTR(gScoreRec)        'see DoGetEqual()
AP.RecPtrSeg = VARSEG(gScoreRec)
AP.KeyPtrOff = VARPTR(AnyKeyBuffer)
AP.KeyPtrSeg = VARSEG(AnyKeyBuffer)
stat = BULLET(AP)
k$ = AnyKeyBuffer
IF stat = 0 THEN DoPrint kfHandle, k$
DoShowFirst = stat
                                        
END FUNCTION

FUNCTION DoShowNext (kfHandle)

'get the next key and load its data record into ScoreRec
'print it to the screen

DIM AP AS AccessPack
DIM AnyKeyBuffer AS STRING * 64

AP.Func = GetNextXB
AP.stat = 0
AP.Handle = kfHandle
AnyKeyBuffer = ""
AP.RecPtrOff = VARPTR(gScoreRec)        'see DoGetEqual()
AP.RecPtrSeg = VARSEG(gScoreRec)
AP.KeyPtrOff = VARPTR(AnyKeyBuffer)
AP.KeyPtrSeg = VARSEG(AnyKeyBuffer)
stat = BULLET(AP)
k$ = AnyKeyBuffer
IF stat = 0 THEN DoPrint kfHandle, k$
DoShowNext = stat

END FUNCTION

FUNCTION GetKeyInfo (kfHandle, kfKeyFlags, kfKeyLen)

'a little routine to get some formatting info used for printing, etc.

DIM SKP AS StatKeyPack

SKP.Func = StatKXB
SKP.Handle = kfHandle
stat = BULLET(SKP)
IF stat = 0 THEN
   kfKeyLen = SKP.KeyLen
   kfKeyFlags = SKP.KeyFlags
END IF
GetKeyInfo = stat

END FUNCTION

FUNCTION IsShareLoaded

DIM RP AS RemotePack

RP.Func = DriveRemoteXB
RP.Handle = 0                           'actually drive (0=default drive)
stat = BULLET(RP)
IsShareLoaded = RP.IsShare              '-1 if loaded, else 0

END FUNCTION

