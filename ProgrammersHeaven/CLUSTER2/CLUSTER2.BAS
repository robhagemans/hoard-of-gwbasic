$COMPILE EXE "CLUSTER2.EXE"
'+---------------------------------------------------------------------------+
'| Clusters.bas  --  predicts/reports cluster usages & disk space wasted     |
'|                   based on the cluster sizes used by various operating    |
'|                   systems and how much space is currently in use          |
'|---------------------------------------------------------------------------|
'|Revision History                                                           |
'|---------------------------------------------------------------------------|
'|When        What                                                           |
'| 5 Nov 95   Initial coding and release                                     |
'|19 Nov 95   Fixed problem with counting one too many clusters for          |
'|            each file.  Also fixed the problem with a divide by zero error |
'|            if a drive had only directories (no files) in the root.        |
'|                                                                           |
'|            Added:                                                         |
'|              - the ability to do 512byte clusters (HPFS and NTFS)         |
'|              - Capability to process one drive without zeroing the totals |
'|                                                                           |
'|14 Jun 96   Started Code for version 2.0                                   |
'|              - More detailed reporting                                    |
'|              - just for the fun of it                                     |
'|              - cleaner interface                                          |
'|              - uses modified windowing routines                           |
'|                                                                           |
'+---------------------------------------------------------------------------+
$STACK 32766
$OPTION CNTLBREAK ON
$LIB IPRINT ON
defint a-z

%False = 0
%True = NOT(%False)
%FLAGS = 0                    ' constants for CPU registers -- we will be
%AX    = 1                    ' calling some DOS routines later
%BX    = 2
%CX    = 3
%DX    = 4
%SI    = 5
%DI    = 6
%BP    = 7
%DS    = 8
%ES    = 9

$INCLUDE "..\lib\PB3BOXES.INC"
%ClustSizes = 6

TYPE DTAData                  ' all the information we want about a file
	Reserved AS STRING * 21     ' is in this data structure in DOS memory
  Attr     AS BYTE
  FileTime AS WORD
  FileDate AS WORD
  Size     AS DWORD
  TheName  AS STRING * 13
  TheRest  AS STRING * 21
END TYPE

TYPE DirDataType
  DirName    AS STRING * 35
  FileCount  AS LONG
  BytesAlloc AS QUAD
  BytesUsed  AS QUAD
END TYPE

SHARED Box1Color%, Box1High%, Box2Color%, Box2High%, Box3Color%, Box3High%
SHARED DirCount%, TempFile$, TempFileNum%, DirNames$(), ReportData&()
SHARED DrvCluster&
DIM DirNames$(0:6000)
DIM DirData AS SHARED DirDataType
DIM ReportData&(1:%ClustSizes,1:5)
'
'  Each primary record in the ReportData& array has 5 elements:
'    ReportData&(x%,1) = Cluster Size
'    ReportData&(x%,2) = Total Clusters Allocated
'    ReportData&(x%,3) = Total Bytes Allocated
'    ReportData&(x%,4) = Total Bytes Used
'    ReportData&(x%,5) = Total Bytes Wasted
'
ReportData&(1,1) = 512        ' initialize the records with default sizes
ReportData&(2,1) = 2048
ReportData&(3,1) = 4096
ReportData&(4,1) = 8192
ReportData&(5,1) = 16384
ReportData&(6,1) = 32768

MainBack% = MakeAttr%(%White,%Black)
IF pbvScrnMode = 7 THEN       ' Monochrome Monitor
  MainHigh%  = MakeAttr%(%BrightWhite, %Blue)
  Box1Color% = MakeAttr%(%Black,%White)
  Box1High%  = MakeAttr%(%BrightWhite,%White)
  Box1High2% = MakeAttr%(%BrightWhite,%White)
  Box2Color% = MakeAttr%(%White,%Black)
  Box2High%  = MakeAttr%(%BrightWhite,%Black)
  Box2High2% = MakeAttr%(%BrightWhite,%Black)
  Box3Color% = MakeAttr%(%Black,%White)
  Box3High%  = MakeAttr%(%White,%Black)
  Box3High2% = MakeAttr%(%White,%Black)
ELSE
  MainHigh%  = makeAttr%(%BrightWhite,%Blue)
  Box1Color% = MakeAttr%(%BrightWhite,%Blue)
  Box1High%  = MakeAttr%(%Yellow,%Blue)
  Box1High2% = MakeAttr%(%BrightCyan,%Blue)
  Box2Color% = MakeAttr%(%Black,%Cyan)
  Box2High%  = MakeAttr%(%Blue,%Cyan)
  Box2High2% = MakeAttr%(%Yellow,%Cyan)
  Box3Color% = MakeAttr%(%Black,%Green)
  Box3High%  = MakeAttr%(%BrightWhite,%Green)
  Box3High2% = MakeAttr%(%Yellow,%Green)
END IF

'
' Here, we save the current screen, draw our own, then get started
'
CALL BoxInit(5)
SaveCsrX% = POS(d%)
SaveCsrY% = CSRLIN

CALL MakeBox(1,1,25,80,MainBack%,0)
CALL QFILL(2,1,24,80,177,MainBack%)
CALL QFILL(1,1,1,80,32,MainHigh%)
CALL PrtBox(1,1,"Clusters V2.0 (c)1995-96",MainHigh%)
CALL PrtBox(1,46,"Bud Durland - bdurland@northnet.org",MainHigh%)

CALL Greeting

BeginAgain:
'
' Get the drive/directory to process
'
VIEW TEXT (1,1)-(80,25)
IF LEN(StartDir$) = 0 THEN StartDir$ = LEFT$(CURDIR$,2)
CALL MakeBox(5,20,8,40,Box2Color%,1)
CALL PrtBox(1,0,"Enter Drive or Directory to process",-1)
CALL LineEdit(8,30,StartDir$,Box2High%,"",CHR$(13,27),ExitKey%,20,50)
CALL RemoveBox
IF ExitKey% = 27 THEN GOTO WrapUp

'
'  Fixup the user's input, then load the directory names
'
IF LEN(StartDir$) = 0 THEN StartDir$ = LEFT$(CURDIR$,2)
IF INSTR(StartDir$,":") = 0 THEN StartDir$ = LEFT$(CURDIR$,2)
StartDir$ = UCASE$(RTRIM$(StartDir$, ANY " \/")) + "\"
CALL GetDriveInfo(StartDir$, DrvCluster&, DrvClustCnt&)
CALL LoadDirNames(StartDir$)

'
' Create a screen for displaying the stats
'
CALL MakeBox(3,4,23,74,Box2Color%,1)
a$ = "Scanning Drive " + LEFT$(DirNames$(0),2) + " Curren Cluster Size " + STR$(DrvCluster&)
CALL PrtBox(1,1,a$,-1)
CALL PrtBox(4,1,"Clust         Clust          Kbyte          KByte         KByte  %Slack",Box2High%)
CALL PrtBox(5,1,"Size          Alloc          Alloc           Used        Wasted   space",Box2High%)
CALL PrtBox(6,1,"อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ",Box2High%)

CALL PrtBox(14,0,"HPFS & NTFS (any size)   =    512 byte Clusters",-1)
CALL PrtBox(15,0,"FAT/VFAT    0MB -  128MB =   2048 byte Clusters",-1)
CALL PrtBox(16,0,"FAT/VFAT  129MB -  256MB =   4096 byte Clusters",-1)
CALL PrtBox(17,0,"FAT/VFAT  257MB -  512MB =   8192 byte Clusters",-1)
CALL PrtBox(18,0,"FAT/VFAT  513MB - 1.02GB =  16284 byte Clusters",-1)
CALL PrtBox(19,0,"FAT/VFAT 1.02GB - 2.04GB =  32768 byte Clusters",-1)

'
'  Now go through each directory, getting information on each file
'  it contains.  Display the data; and accumulate information about
'  each directory for storage in a temporary file
'
TempFileNum% = AllocTempFile%           ' func returns handle of a temp file
IF TempFileNum% = 0 THEN
  a$ = "Failed to allocate a temporary file" + CHR$(10) + _
       "Clusters cannot continue"
	CALL MsgBox(a$,"",MainHigh%)
  CALL RemoveBox
  END
END IF
FOR DirPtr% = 0 TO DirCount%
  TheDir$ = DirNames$(DirPtr%)
  DirFileCnt& = 0
  CALL PrtBox(2,1,"Dir: ",-1)           ' keep the user entertained
  j$ = TheDir$
  IF LEN(TheDir$) > 65 THEN
  	j$ = LEFT$(TheDir$,30) + "...." + RIGHT$(TheDir$,30)
  END IF
  CALL PrtEOL(2,6,TheDir$,Box2High2%)
  TheFile$ = DIR$(TheDir$+"*.*",55)     ' use attr of 55 to get all files
  WHILE LEN(TheFile$) > 0
    INCR FileCnt&,1
    INCR DirFileCnt&,1
    z? = ATTRIB(TheDir$ + TheFile$)
    IF (TheFile$ = ".") OR (TheFile$ = "..") OR _   ' the entries "." and ".."
       (BIT(z?,4)) THEN                             ' are special, and don't
      TheFile$ = DIR$                               ' count here, bit 4 set
      DECR DirFileCnt&                              ' means this file is a
      ITERATE                                       ' dir; don't count it
    END IF

    fSize& = GetFileSize&(TheDir$ + TheFile$)
    FOR x% = 1 TO %ClustSizes                       ' Compute file stats
      Cluster& = ReportData&(x%,1)
    	TotalFSize&& = TotalFSize&& + k&

      ClustAloc& = (fSize& \ Cluster&)              ' get number of whole clust
      f& = fSize& MOD Cluster&                      ' adjust if there is a
      IF f& > 0 THEN INCR ClustAloc&,1              ' partial cluster also
      fWaste& = (ClustAloc& * Cluster&) - fSize&

      ReportData&(x%,2) = ReportData&(x%,2) + ClustAloc&
      ReportData&(x%,3) = ReportData&(x%,3) + (ClustAloc& * Cluster&)
      ReportData&(x%,4) = ReportData&(x%,4) + fSize&
      ReportData&(x%,5) = ReportData&(x%,5) + fWaste&

      IF Cluster& = DrvCluster& THEN
        INCR DirData.BytesAlloc, (ClustAloc& * Cluster&)
        INCR DirData.BytesUsed, fSize&
      END IF

      a$ = SPACE$(72)
      MID$(a$,1,7) = USING$(" ##,###", ReportData&(x%,1))
      MID$(a$,10,10) = USING$(" #,###,###", ReportData&(x%,2))
      MID$(a$,25,10) = USING$(" #,###,###", ReportData&(x%,3) \ 1024)
      MID$(a$,40,10) = USING$(" #,###,###", ReportData&(x%,4) \ 1024)
      MID$(a$,54,10) = USING$(" #,###,###", ReportData&(x%,5) \ 1024)

      IF ReportData&(x%,3) > 0 THEN
      	a! = 100 - CFIX((ReportData&(x%,4) / ReportData&(x%,3)) * 100)
      	MID$(a$,66,10) = USING$("###.##", a!)
      END IF
      IF Cluster& = DrvCluster& THEN
      	CALL PrtBox(6+x%,1,a$,Box2high2%)
      ELSE
        CALL PrtBox(6+x%,1,a$,-1)
      END IF

    NEXT x%

    TheFile$ = DIR$

  WEND
  DirData.DirName = TheDir$
  DirData.FileCount = DirFileCnt&

  PUT$ #TempFileNum%, DirData
  DirData.DirName = ""
  DirData.FileCount = 0
  DirData.BytesAlloc = 0
  DirData.Bytesused = 0

NEXT DirPtr%

CALL PrtBox(21,0,"Press 'D' to see current usage by directory; any other to continue",Box2High2%)
WHILE NOT INSTAT:WEND
a$ = INKEY$
IF UCASE$(a$) = "D" THEN CALL ShowDirDetails
CALL PrtEOL(21,1,"",-1)
CALL RemoveBox
a$ = MsgBox$("Would you like to process another drive? Y/N","YN", Box3Color%)
IF a$ = "N" THEN GOTO WrapUp

msg$ = "Zero totals before processing?" + CHR$(10) + "Press Y or N"
a$ = MsgBox$(msg$, "YN", Box3Color%)
IF a$ = "Y" THEN
	FOR x% = 1 TO %ClustSizes
    FOR y% = 2 TO 5
    	ReportData&(x%,y%) = 0
    NEXT y%
  NEXT x%
END IF

CLOSE TempFileNum%
CALL NukeBoxes(1)
GOTO BeginAgain

WrapUp:
CLOSE

IF LEN(DIR$(TempFile$)) > 0 THEN KILL TempFile$
CALL NukeBoxes(0)
VIEW TEXT (1,1) - (80,25)
LOCATE SaveCsrY%, SaveCsrX%

END


SUB LoadDirNames(StartHere$) LOCAL PUBLIC
'+----------------------------------------------------------------------------+
'|Scans for all the subdirs in a directory tree.                              |
'|	DirPtr% is a pointer to which directory we are currently scanning for     |
'|	more directories.  Each time we find one, we put the name of the new      |
'|	directory on the end of the list, and increase DirCount% by one.  Thus,   |
'|	DirCount% becomes a moving target, and we will just continually move      |
'|	down farther and farther untill all directories have been search to their |
'|  deepest level.                                                            |
'|                                                                            |
'|After we've found all the directories, (DirCount doesn't stay ahead of      |
'|	DirPtr%), we'll sort the list, and exit.                                  |
'|                                                                            |
'|The scan starts at whatever directory is specified in DirNames$(0).  If     |
'| that element is blank, the root directory of the current drive is used     |
'+----------------------------------------------------------------------------+

CALL MakeBox(6,10,10,60,Box3Color%,1)
CALL BoxTitle(2,"Loading Directory Names",-1)
CALL SetViewText(0,0)

DirPtr% = -1
DirCount% = 0
DirNames$(0) = StartHere$

WHILE DirCount% > DirPtr%
	INCR DirPtr%,1
	TheDir$ = DirNames$(DirPtr%)
  IF LEN(TheDir$) < 55 THEN
    PRINT TheDir$;" ";
  ELSE
    PRINT LEFT$(TheDir$,25);"....";RIGHT$(TheDir$,25);" ";
  END IF
  ix% = POS(g%)
  iy% = CSRLIN
'+----------------------------------------------------------------------------+
'| Use an attribute value of 23.  This will make DIR$ return directory names  |
'| and "normal" files, as well has hidden and system directories              |
'+----------------------------------------------------------------------------+
  Spin$ = "|/-\"
  SpinPtr% = 1
	x$ = DIR$(TheDir$+"*.*",23)
	WHILE x$ <> ""
		TheFile$ = TheDir$ + x$
    LOCATE iy%,ix%
    PRINT MID$(Spin$,SpinPtr%,1);
    INCR SpinPtr%,1
    IF SpinPtr% > LEN(Spin$) THEN SpinPtr% = 1
'+----------------------------------------------------------------------------+
'| Check the attribute of the returned file name.  If bit 4 is set, then the  |
'| file is a directory.  If it's a directory, then increase the DirCount% and |
'| store this directory name.                                                 |
'+----------------------------------------------------------------------------+
    z? = ATTRIB(TheFile$)
		IF BIT(z?,4) THEN
			INCR DirCount%,1
			TheFile$ = RTRIM$(TheFile$, ANY CHR$(0,32,92,47)) + "\"  'remove /\ too
			DirNames$(DirCount%) = TheFile$
		END IF
		x$ = DIR$
	WEND
  LOCATE iy%,ix%
  PRINT " "
  IF DirCount% => UBOUND(DirNames$) THEN EXIT LOOP
WEND

PRINT "Sorting..."
ARRAY SORT DirNames$() FOR DirCount%+1	' sort directory names
CALL RemoveBox

END SUB

SUB ShowDirDetails
'ีอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ This sub will show the current usage details for each directory       ณ
'ณ that was just scanned                                                 ณ
'ิอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ
ByTotal&& = 0
AlcTotal&& = 0
UseTotal&& = 0
DirTotal&& = 0

PUT$ #TempFileNum%, ""
SEEK #TempFileNum%,0

CALL ClearBox(-1,-1)
CALL PrtBox(3,0,"Please wait while report is formatted",-1)
DIM HUGE Report$(DirCount%)
FOR xx& = 1 TO DirCount%
  IF EOF(TempFileNum%) THEN EXIT FOR
  GET #TempFileNum%,,DirData
  a$ = SPACE$(72)
  b$ = RTRIM$(DirData.DirName, ANY CHR$(32,0))
  IF LEN(b$) = 0 THEN EXIT FOR
  IF LEN(b$) > 30 THEN
    c$ = RIGHT$(b$,1)
    FOR k% = (LEN(b$)-1) TO 1 STEP -1
      c$ = MID$(b$,k%,1) + c$
      IF MID$(b$,k%,1) = "\" THEN EXIT FOR
    NEXT k%
    k% = INSTR(4,b$,"\")
    b$ = LEFT$(b$,k%) + "...." + c$
  END IF
  MID$(a$,1,30) = b$
  MID$(a$,32,7) = USING$(" ##,###", DirData.FileCount)
  MID$(a$,40,10) = USING$(" #,###,###", (DirData.BytesAlloc \ 1024))
  MID$(a$,53,10) = USING$(" #,###,###", (DirData.BytesUsed \ 1024))

  IF DirData.BytesAlloc > 0 THEN
    a! = 100 - CFIX((DirData.BytesUsed / DirData.BytesAlloc) * 100)
    MID$(a$,65,6) = USING$("###.##", a!)
  END IF

  Report$(xx&) = a$

NEXT xx&


  CALL ClearBox(-1,-1)
  CALL PrtBox(1,1,"Directory",Box2High%)
  CALL PrtBox(1,33,"  File     Kbytes       KBytes  %Slack",Box2High%)
  CALL PrtBox(2,33," Count      Alloc         Used   Space",Box2High%)
  CALL PrtBox(3,1,STRING$(72,205),Box2high%)
  CALL MakeBox(6,4,20,74,Box2Color%,1)
  CALL ScrollList((DirCount%), Report$(), %False)
  CALL RemoveBox

END SUB

FUNCTION GetFileSize&(BYVAL TheFile$) LOCAL PUBLIC
'+---------------------------------------------------------------------------+
'| Returns the size (in bytes) of the specified file.  Will preserve the     |
'| current DOS DTA. (see below)                                              |
'+---------------------------------------------------------------------------+

  DIM MyDTA as DtaData
  CALL FindOldDta(OldSeg??, OldOff??)	          ' so we can go back
  a$ = SPACE$(LEN(MyDTA))
  NewSeg?? = BITS??(STRSEG(a$))
  NewOff?? = BITS??(STRPTR(a$))
  CALL SetNewDta(NewSeg??, NewOff??)

  REG %AX, &H4E00
  Victim$ = TheFile$ + CHR$(0)
  REG %CX, &H16		' find all files and sub dirs
  REG %DS, STRSEG(Victim$)
  REG %DX, STRPTR(Victim$)
  CALL INTERRUPT &H21

  RetCode?? = REG(%Flags)
  IF BIT(RetCode??,0) THEN                      ' error flag set
    GetFileSize& = -1
  ELSE
    LSET MyDta = a$
    GetFileSize& = MyDta.Size
  END IF

' Reset the old DTA
  CALL SetNewDTA(OldSeg??, OldOff??)
END FUNCTION


'+--------------------------------------------------------------------------+
'| The DTA (disk transfer address) is a data structure in DOS memory that   |
'| holds information about the last file DOS was asked to look for.  DOS    |
'| allows a program to determine where the DTA is, and to set it's own area |
'| for the DTA.                                                             |
'|                                                                          |
'| PowerBASIC uses the DTA when you use the DIR$ function.   The first      |
'| time you use it, you specify a file name: a$ = DIR$("*.*").  After that, |
'| you DOS uses information leftover in the DTA to find the next file when  |
'| you use b$ = DIR$.  Everytime you specify a file, even with wildcards,   |
'| the search starts over.                                                  |
'|                                                                          |
'| In this program, that could be a pain -- our main loop is searching      |
'| through all the file in a directory {x$ = DIR$(TheDir$+"*.*",23)} to     |
'| get the names, then CALLing a sub to get the file size.  It's important  |
'| that the SUB not distrub the DTA, or the program would never get past    |
'| the first file in a directory!                                           |
'|                                                                          |
'| So, these two routines allow us to find & preserve the old DTA data,     |
'| while temporarily substituting a different one for doing the size check  |
'+--------------------------------------------------------------------------+


SUB FindOldDTA(TheSeg??, TheOffSet??) LOCAL PUBLIC
'+------------------------------------------------------------------------+
'|Determines where the current DTA is, and returns it's segment/offset    |
'+------------------------------------------------------------------------+
 REG %AX, &H2F00          'Use DOS service INT 21/function 2F, to
 CALL INTERRUPT &H21      'Find where the current DTA is
 TheSeg?? = REG(%ES)       'Segment of location of default DTA
 TheOffset??  = REG(%BX)   'Offset into the segment for default DTA
END SUB


SUB SetNewDTA(BYVAL TheSeg??, BYVAL TheOffSet??) LOCAL PUBLIC
'+------------------------------------------------------------------------+
'|Installs a new DTA address for DOS to use                               |
'+------------------------------------------------------------------------+
 REG %AX, &H1A00              'Use another Dos Service (21/1A) to set the DTA
 REG %DS, TheSeg??             'Load the segment of it's location
 REG %DX, TheOffSet??          '  and the offset
 CALL INTERRUPT &H21          'Call the DOS service
END SUB

SUB GetDriveInfo(BYVAL TheDrive$, DrvCluster&, ClusterCnt&) LOCAL PUBLIC
'+--------------------------------------------------------------------------+
'| This sub will determine some of the geometry of the drive -- the sector  |
'| size, and the number of sectors per cluster.  From that, we can compute  |
'| the cluster size for this drive                                          |
'+--------------------------------------------------------------------------+

  dd$ = UCASE$(TheDrive$)
  drv% = ASC(dd$) - 64                  ' unlike BIOS functions, A is drive 1
  IF (drv% < 1) OR (drv% > 26) THEN     ' exit if bad disk name
    DrvCluster& = -1
    EXIT SUB
  END IF

  REG %AX, &H3600             ' DOS Function call - INT 21H/36
  REG %DX, drv%               ' Drive to check
  CALL INTERRUPT &H21         ' Call DOS Int


  Sectors&     = REG(%AX)        ' Sectors per cluster
  SectorSize&  = REG(%CX)        ' Sector size in bytes
  TClusters&   = REG(%DX) 	     ' Total Clusters on disk
  DrvCluster&  = Sectors& * SectorSize&

  IF TClusters& > 0 THEN
  	ClusterCnt& = TClusters&
  ELSE
  	ClusterCnt&  = 65536 - TClusters&
  END IF

END SUB

FUNCTION AllocTempFile% LOCAL PUBLIC
'+--------------------------------------------------------------------------+
'| Allocates a temporary file;  if successful, returns handle of opened     |
'| file.  If not, returns 0                                                 |
'+--------------------------------------------------------------------------+
ON LOCAL ERROR GOTO ATFErr

' use temp dir defined in Autoexec, if any.  otherwise, use current DIR
  a$ = ENVIRON$("TEMP")
  IF LEN(a$) = 0 THEN a$ = CURDIR$

' Assign file name and delete it if it exists
  TempFile$ = RTRIM$(a$, ANY " /\") + "\$$CLUS$$.TMP"
  IF LEN(DIR$(TempFile$)) > 0 THEN KILL TempFile$

' Open the file, and return the handle
  x% = FREEFILE
  OPEN TempFile$ FOR BINARY AS x%

ATFDone:

  AllocTempFile% = x%
  EXIT FUNCTION

ATFErr:

  x% = 0
  RESUME ATFDone

END FUNCTION

SUB Greeting LOCAL PUBLIC

  RESTORE GreetData
  DIM Text$(1:100)
  FOR x% = 1 TO 100
    READ a$
    IF a$ = "/END/" THEN
      DECR x%,1
      EXIT FOR
    END IF
    Text$(x%) = a$
  NEXT x%

  CALL MakeBox(3,5,21,70,Box1Color%,1)
  CALL ScrollList(x%, Text$(), %True)
  CALL RemoveBox

END SUB

GreetData:

DATA  "Thanks for using CLUSTERS"
DATA  " "
DATA  "This program will examine the sizes of the files stored on"
DATA  "the drive you specify.  It will then calculate how much of"
DATA  "the disk space allocated to it is 'slack'.  The README.TXT"
DATA  "file that accompanies this program explains slack space,"
DATA  "what causes it and how to reduce it.  CLUSTERS will calculate"
DATA  "the disk allocation and slack space for all the possible"
DATA  "cluster sizes, and will highlight whichever one the specified"
DATA  "disk drive is currently using."
DATA  " "
DATA  "After examining all of the files, CLUSTERS will ask if you would"
DATA  "like to see a detailed listing, arranged by directory.  This"
DATA  "lets you pinpoint directories that are very wasteful of space"
DATA  "(such as icon directories), and take appropriate action.  In"
DATA  "the list, as in all CLUSTERS displays, 1Kbyte = 1024 bytes"
DATA  " "
DATA  "Please note that CLUSTERS will report a different number for"
DATA  "the amount disk space used than some other DOS utilities.  This"
DATA  "is because it only examine files; CLUSTERS does not account for"
DATA  "the amount of disk space taken up by the actual directory"
DATA  "listings themselves."
DATA  " "
DATA  "Also, if you are using an HPFS or NTFS partitions, CLUSTERS"
DATA  "will erroneously report the cluster size as whatever is"
DATA  "appropriate for the partition size;  This is because the"
DATA  "operating system 'lies' to DOS programs when they ask about"
DATA  "the geometry of the disk.  HPFS and NTFS partitions always"
DATA  "use 512byte partitions and are *very* efficient"
DATA  " "
DATA  "Press ESC to continue"
DATA  "/END/"


$LINK "..\LIB\PB3BOXES.PBL"
