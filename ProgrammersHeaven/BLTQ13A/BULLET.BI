'******* BULLET-1.03-22-Apr-93 *******
DECLARE FUNCTION BULLET% (SEG packinfo AS ANY)

CONST InitXB = 0, ExitXB = 1, AtExitXB = 2
CONST MemoryXB = 3, BreakXB = 4, BackupFileXB = 5, StatHandleXB = 6
CONST GetExtErrorXB = 7
CONST DVmonCXB = 9

CONST CreateDXB = 10, OpenDXB = 11, CloseDXB = 12, StatDXB = 13
CONST ReadDHXB = 14, FlushDHXB = 15, CopyDHXB = 16, ZapDHXB = 17

CONST CreateKXB = 20, OpenKXB = 21, CloseKXB = 22, StatKXB = 23
CONST ReadKHXB = 24, FlushKHXB = 25, CopyKHXB = 26, ZapKHXB = 27

CONST GetDescriptorXB = 30, GetRecordXB = 31
CONST AddRecordXB = 32, UpdateRecordXB = 33
CONST DeleteRecordXB = 34, UndeleteRecordXB = 35
CONST PackRecordsXB = 36

CONST FirstKeyXB = 40, EqualKeyXB = 41, NextKeyXB = 42
CONST PrevKeyXB = 43, LastKeyXB = 44, StoreKeyXB = 45, DeleteKeyXB = 46
CONST BuildKeyXB = 47, CurrentKeyXB = 48

CONST GetFirstXB = 60, GetEqualXB = 61, GetNextXB = 62
CONST GetPrevXB = 63, GetLastXB = 64, InsertXB = 65, UpdateXB = 66
CONST ReindexXB = 67

CONST LockXB = 80, UnlockXB = 81
CONST LockKeyXB = 82, UnlockKeyXB = 83, LockDataXB = 84, UnlockDataXB = 85
CONST DriveRemoteXB = 86, FileRemoteXB = 87, SetRetriesXB = 88

CONST DeleteFileDOS = 100, RenameFileDOS = 101, CreateFileDOS = 102
CONST OpenFileDOS = 103, SeekFileDOS = 104, ReadFileDOS = 105
CONST WriteFileDOS = 106, CloseFileDOS = 107
CONST AccessFileDOS = 108, ExpandFileDOS = 109, MakeDirDOS = 110

CONST cUNIQUE = 1, cCHAR = 2, cINTEGER = &H10, cLONG = &H20
CONST cNLS= &H4000, cSIGNED = &H8000

CONST ReadOnly = 0, WriteOnly = 1, ReadWrite = 2
CONST Compat = 0
CONST DenyReadWrite = &H10, DenyWrite = &H20, DenyRead = &H30, DenyNone = &H40
CONST NoInherit = &H80

TYPE AccessPack         'ACCESS TO/FROM KEY/DATA FILE
Func AS INTEGER         'ALSO USED FOR LOCKING FILES AT THE BYTE LEVEL
Stat AS INTEGER
Handle AS INTEGER       'OS handle
RecNo AS LONG           'long integer record number of key/data record
RecPtrOff AS INTEGER    'far pointer to record storage buffer
RecPtrSeg AS INTEGER
KeyPtrOff AS INTEGER    'far pointer to search key buffer
KeyPtrSeg AS INTEGER
NextPtrOff AS INTEGER   'far pointer to next key access pack
NextPtrSeg AS INTEGER
END TYPE  '22

TYPE BreakPack
Func AS INTEGER
Stat AS INTEGER
Mode AS INTEGER         '0=disable ctrl-C/Break,1=restore
END TYPE '6

TYPE CopyPack
Func AS INTEGER
Stat AS INTEGER
Handle AS INTEGER
FilenamePtrOff AS INTEGER       'far pointer to filenameZ for copy
FilenamePtrSeg AS INTEGER
END TYPE '10

TYPE CreateDataPack
Func AS INTEGER
Stat AS INTEGER
FilenamePtrOff AS INTEGER       'far pointer to filenameZ
FilenamePtrSeg AS INTEGER
NoFields AS INTEGER
FieldListPtrOff AS INTEGER      'far pointer to field list
FieldListPtrSeg AS INTEGER
FileID AS INTEGER
END TYPE '16

TYPE CreateKeyPack
Func AS INTEGER
Stat AS INTEGER
FilenamePtrOff AS INTEGER       'far pointer to filenameZ
FilenamePtrSeg AS INTEGER
KeyExpPtrOff AS INTEGER         'far pointer to key expressionZ
KeyExpPtrSeg AS INTEGER
XBlink AS INTEGER
KeyFlags AS INTEGER
CodePageID AS INTEGER
CountryCode AS INTEGER
CollatePtrOff AS INTEGER        'far pointer to collate table or 0:0
CollatePtrSeg AS INTEGER
END TYPE '24

TYPE FieldDescTYPE      'INTERNAL USE--used by DescriptorPack
FieldName AS STRING * 11  '(needs to be before DescriptorPack)
FieldType AS STRING * 1
FieldDA AS LONG         'unused (all unused fields are reserved)
FieldLength AS STRING * 1
FieldDC AS STRING * 1
A1 AS INTEGER           'unused
A2 AS INTEGER           'unused
filler AS STRING * 10   'unused
END TYPE '32

TYPE DescriptorPack
Func AS INTEGER
Stat AS INTEGER
Handle AS INTEGER
FieldNumber AS INTEGER  'field number to get info on, or if 0 then
FD AS FieldDescTYPE     'search for FD.FieldName
END TYPE '40

TYPE DOSFilePack
Func AS INTEGER
Stat AS INTEGER
FilenamePtrOff AS INTEGER       'far pointer to filenameZ
FilenamePtrSeg AS INTEGER
Handle AS INTEGER
ASmode AS INTEGER
Bytes AS INTEGER
SeekOffset AS LONG              'also bytes to expand file by
Method AS INTEGER
BufferPtrOff AS INTEGER         'far pointer to read/write buffer
BufferPtrSeg AS INTEGER
Attr AS INTEGER
NewNamePtrOff AS INTEGER        'far pointer to new filenameZ for rename
NewNamePtrSeg AS INTEGER
END TYPE '30

TYPE DVmonPack          'DEBUG ENGINE ONLY
Func AS INTEGER
Stat AS INTEGER
Mode AS INTEGER         '0=off,1=on,2=put up base screen only
Handle AS INTEGER       'handle to monitor
VS AS INTEGER           'video buffer segment (4000 bytes at least)
END TYPE '10

TYPE ExitPack
Func AS INTEGER
Stat AS INTEGER
END TYPE '4

TYPE HandlePack
Func AS INTEGER
Stat AS INTEGER
Handle AS INTEGER
END TYPE '6

TYPE InitPack
Func AS INTEGER
Stat AS INTEGER
JFTmode AS INTEGER
DOSver AS INTEGER
Version AS INTEGER
ExitPtrOff AS INTEGER      'far pointer to ExitXB routine
ExitPtrSeg AS INTEGER
END TYPE '14

TYPE MemoryPack
Func AS INTEGER
Stat AS INTEGER
Memory AS LONG          'largest free block of memory
END TYPE '8

TYPE OpenPack
Func AS INTEGER
Stat AS INTEGER
Handle AS INTEGER               'returned OS handle of file opened
FilenamePtrOff AS INTEGER       'far pointer to filenameZ
FilenamePtrSeg AS INTEGER
ASmode AS INTEGER               'access-sharing mode
xbHandle AS INTEGER     'if opening key file this is its related xb handle
END TYPE '14

TYPE RemotePack
Func AS INTEGER
Stat AS INTEGER
Handle AS INTEGER       'handle/drive depending on routine
IsRemote AS INTEGER     '0=local,1=remote
Flags AS INTEGER        'DX register as returned by DOS
IsShare AS INTEGER      '0=SHARE.EXE not loaded
END TYPE '12

TYPE SetRetriesPack
Func AS INTEGER
Stat AS INTEGER
Mode AS INTEGER         '0=set DOS default else use Pauses/Retries below
Pause AS INTEGER        '0-65535 loop counter between retries
Retries As INTEGER      '0-65535 retries to access locked file
END TYPE '10

TYPE StatDataPack
Func AS INTEGER
Stat AS INTEGER
Handle AS INTEGER       'XB data file
FileType AS STRING * 1  '1=XB data
Dirty AS STRING * 1     '0=not changed
Recs AS LONG            'records
RecLen AS INTEGER       'record length
Fields AS INTEGER       'fields per record ()
f1 AS STRING * 1        'reserved (1=update DVmon)
LUyear AS STRING * 1    'binary, year file last updated
LUmonth AS STRING * 1   'month
LUday AS STRING * 1     'day
HereSeg AS INTEGER      'this file's control segment
filler AS STRING * 10
END TYPE '32

TYPE StatKeyPack
Func AS INTEGER
Stat AS INTEGER
Handle AS INTEGER       'key file
FileType AS STRING * 1  '0=key
Dirty AS STRING * 1     '0=not changed
Keys AS LONG            'keys
KeyLen AS INTEGER       'key length
XBlink AS INTEGER       'XB data file link
XBrecno AS LONG         'record number of current key
HereSeg AS INTEGER      'this file's control segment
CodePageID AS INTEGER
CountryCode AS INTEGER
CollateTableSize AS INTEGER
KeyFlags AS INTEGER
filler AS STRING * 2
END TYPE '32

TYPE StatHandlePack             'SHP
Func AS INTEGER
Stat AS INTEGER
Handle AS INTEGER               'OS handle to gather stats on
ID AS INTEGER                   'ID 0=key file,1=DBF data, -1 not BULLET
FilenamePtrOff AS INTEGER       'far pointer to filenameZ of handle
FilenamePtrSeg AS INTEGER
END TYPE '12

TYPE XErrorPack                 'XEP
Func AS INTEGER
Stat AS INTEGER                 'extended error
Class AS INTEGER                'error class
Action AS INTEGER               'suggested action
Location AS INTEGER             'error location
END TYPE '10

'<End of BULLET.BI>
