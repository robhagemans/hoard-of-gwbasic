'
' File: GRPLOAD.BAS - GRP loading procedures and example
' Author ch!ckuaua (grizlyY2K@hotmail.com)
' Date (dd.mm.yyyy): 18.04.2000.
'
'   Here are the procedures and an example of using GRP in QB(asic). This can
' be slow if you extract large files, because they are extracted byte by
' byte... For more detailed info, read README.TXT
'
'
'
'


' ------ START OF NECESSARY CODE -----
' Of course, you must also have these procedures....
DECLARE FUNCTION GRPFileSingle! (FileNum!, FilePos!)   'Returns SINGLE from file
DECLARE FUNCTION GRPFileDouble# (FileNum!, FilePos!)   'Returns DOUBLE from file
DECLARE FUNCTION GRPFileLong& (FileNum!, FilePos!)     'Returns LONG from file
DECLARE FUNCTION GRPFileInteger% (FileNum!, FilePos!)  'Returns INTEGER from file
DECLARE FUNCTION GRPFileString$ (FileNum!, FilePos!, Length!)    'Returns STRING * length from file
DECLARE FUNCTION GRPFileByte$ (FileNum!, FilePos!)     'Returns STRING * 1 from file
DECLARE SUB GRPExtractFile (FileNum!, FileName$)       'Extracts a file from GRP
DECLARE FUNCTION GRPFileNum! (FileName$)               'Returns file handle

'GRP File header
TYPE GRPHeader
     ID        AS STRING * 4       '"GRPï"
     Version   AS INTEGER          'GRP Version
     NumDir    AS LONG             'reserved - usually 0
     NumFiles  AS LONG             'Number of files
END TYPE
'File header
TYPE File
     FileName  AS STRING * 12      'File name (XXXXXXX.XXX)
     FilePos   AS LONG             'File position in GRP
     FileLen   AS LONG             'File length
     FileNum   AS LONG             'File handle (number)
END TYPE

DIM SHARED GRPHeader AS GRPHeader                 'GRP header
DIM SHARED GRPFileHandle                          'The file handle of the opened GRP file
DIM SHARED byte AS STRING * 1                     'A single byte

' ---- END OF NECESSARY CODE ----


'
' Code for loading the header of a GRP file - this is not in a SUB because
' we cannot make a SHARED variable in a SUB...
'
GRPFile$ = "GRPEXAMP.GRP"

GRPFileHandle = FREEFILE
OPEN GRPFile$ FOR BINARY AS GRPFileHandle

'
' Verify GRP and Version
'
GET GRPFileHandle, 1, GRPHeader
IF GRPHeader.ID <> "GRPï" THEN PRINT "Not a valid GRP file !": END
IF GRPHeader.Version <> VAL("&H" + "01" + "00") THEN PRINT "Invalid GRP version !": END

'
' Get files headers
'
DIM SHARED FileHeader(GRPHeader.NumFiles - 1) AS File       'File header
DIM SHARED GRPFilePosition(GRPHeader.NumFiles - 1)          'File position counter

FOR a = 0 TO GRPHeader.NumFiles - 1
     GET GRPFileHandle, , FileHeader(a)
     GRPFilePosition(a) = 1
NEXT

'
' NEVER close GRPFileHandle until program is finished or until loading another
' GRP file
'




'
' A little DEMO...
'

CLS
ver$ = HEX$(GRPHeader.Version)
IF LEN(ver$) < 4 THEN maj$ = LEFT$(ver$, 1) ELSE maj$ = LEFT$(ver$, 2)
min$ = RIGHT$(ver$, 2)
PRINT "   GRP File: "; GRPFile$
PRINT "GRP Version: "; maj$; "."; min$
PRINT "      Files:"; GRPHeader.NumFiles
PRINT
PRINT "Num   File                   Bytes         Position in GRP"
PRINT "-------------------------------------------------------------"
FOR a = 0 TO GRPHeader.NumFiles - 1
     n$ = LTRIM$(RTRIM$(STR$(a)))
     IF LEN(n$) < 4 THEN n$ = STRING$(4 - LEN(n$), "0") + n$
     PRINT n$; ": "; FileHeader(a).FileName, FileHeader(a).FileLen, FileHeader(a).FilePos
NEXT
PRINT "-------------------------------------------------------------"


GRPExtractFile 2, "README.2"

'
' This procedure can be rather slow because it extracts the file byte by byte
'
SUB GRPExtractFile (FileNum, FileName$)
IF FileName$ = "" THEN FileName$ = LTRIM$(RTRIM$(FileHeader(FileNum).FileName))
f = FREEFILE
OPEN FileName$ FOR BINARY AS f
FOR a = 0 TO FileHeader(FileNum).FileLen - 1
     GET GRPFileHandle, FileHeader(FileNum).FilePos + a, byte
     PUT f, , byte
NEXT
END SUB

'
' Gets a single byte from a file
'
FUNCTION GRPFileByte$ (FileNum, FilePos)
IF FilePos = -1 THEN FilePos = GRPFilePosition(FileNum)
GET GRPFileHandle, FileHeader(FileNum).FilePos + FilePos, byte
GRPFileByte$ = byte
GRPFilePosition(FileNum) = GRPFilePosition(FileNum) + 1
END FUNCTION

'
' Gets a double precision floating point number from a file
'
FUNCTION GRPFileDouble# (FileNum, FilePos)
IF FilePos = -1 THEN FilePos = GRPFilePosition(FileNum)
GET GRPFileHandle, FileHeader(FileNum).FilePos + FilePos, GRPFileDouble#
GRPFilePosition(FileNum) = GRPFilePosition(FileNum) + 8
END FUNCTION

'
' Gets an integer from a file
'
FUNCTION GRPFileInteger% (FileNum, FilePos)
IF FilePos = -1 THEN FilePos = GRPFilePosition(FileNum)
GET GRPFileHandle, FileHeader(FileNum).FilePos + FilePos, GRPFileInteger%
GRPFilePosition(FileNum) = GRPFilePosition(FileNum) + 2
END FUNCTION

'
' Gets an long integer number from a file
'
FUNCTION GRPFileLong& (FileNum, FilePos)
IF FilePos = -1 THEN FilePos = GRPFilePosition(FileNum)
GET GRPFileHandle, FileHeader(FileNum).FilePos + FilePos, GRPFileLong&
GRPFilePosition(FileNum) = GRPFilePosition(FileNum) + 4
END FUNCTION

'
' Returns the file handle/number of FileName$, -1 if the file does not exist
'
FUNCTION GRPFileNum (FileName$)
FileName$ = UCASE$(LTRIM$(RTRIM$(FileName$)))
result = -1
FOR a = 0 TO GRPHeader.NumFiles - 1
     IF LTRIM$(RTRIM$((FileHeader(a).FileName))) = FileName$ THEN result = a: EXIT FOR
NEXT
GRPFileNum = result
END FUNCTION

'
' Gets a single precision floating point number from a file
'
FUNCTION GRPFileSingle! (FileNum, FilePos)
IF FilePos = -1 THEN FilePos = GRPFilePosition(FileNum)
GET GRPFileHandle, FileHeader(FileNum).FilePos + FilePos, GRPFileSingle!
GRPFilePosition(FileNum) = GRPFilePosition(FileNum) + 4

END FUNCTION

'
' Gets a string from a file
'
FUNCTION GRPFileString$ (FileNum, FilePos, Length)
IF FilePos = -1 THEN FilePos = GRPFilePosition(FileNum)
FOR a = 0 TO Length - 1
     GET GRPFileHandle, FileHeader(FileNum).FilePos + FilePos + a, byte
     r$ = r$ + byte
NEXT
GRPFilePosition(FileNum) = GRPFilePosition(FileNum) + Length
GRPFileString$ = r$
END FUNCTION

