' File Opener v1.0

' all hardware code by Mark K Kim
' interface written by Molnar \ Kucalaba Productions

' Everything is functional except the File Name box and graphical
' representations of the arrow boxes.  The arrow boxes do work, however.
' You can use either the mouse or keyboard.

' This whole routine was meant to be used in screen mode 12h.

' The limit for files to sort through is 350.

' It also takes a really long time to sort through and alphabetize the file
' names.  The method currently used is the Bubble Sort.  We're contemplating
' using a Quick Sort.  After all, it's Quick.

' This works in QBasic 1.1, and can be compiled successfully with QuickBASIC
' 4.5, but if you try to run it from within QuickBASIC 4.5, it always locks
' up at some point, "parsing line xxxx" we think it was.  At least that's what
' happens on our computers.


'        If you enjoyed this program, then you should visit
'
'             http://members.aol.com/vindaci/index.html
'                             a n d
'            http://members.aol.com/mkwebsite/index.html
'
'      Heck, visit there even if you didn't enjoy this program.



'$DYNAMIC

'DECLARE SUB Absolute (var1%, var2%, var3%, var4%, var5%, var6%, var7%, var8%, var9%, offset%)

         TYPE FileStruct
            attrib AS INTEGER
            filedate AS STRING * 10
            filetime AS STRING * 8
            filesize AS DOUBLE
         END TYPE

 TYPE OFType
   HighFile AS INTEGER  ' The highlighted file (File element number/pointer)
   HighDir AS INTEGER   ' The highlighted directory
   FileSpot AS INTEGER  ' The location of the arrow at the bottom of the fbox
   MaxFSpot AS INTEGER  ' The maximum number of columns of files
   DirSpot AS INTEGER   ' The location of the arrow.....dir box
   NumFiles AS INTEGER
   MaxDSpot AS INTEGER
   Time AS SINGLE       ' Timer buffer
   Flag AS INTEGER      ' Misc flag
   Opt AS STRING * 3
 END TYPE

 TYPE QBSucks
  Dat AS STRING * 12
 END TYPE


 DECLARE FUNCTION OpenFile$ (Option$)
 DECLARE FUNCTION getdrv% ()
 DECLARE FUNCTION getdir$ (Drive%)
 DECLARE FUNCTION dir.find$ ()                 'call next to get filenames
 DECLARE SUB Dir.init (path$, attrib%)         'call first to initialize
 DECLARE SUB dir.fileinfo (File AS FileStruct) 'call to get file information

 DECLARE SUB OFText (w%)
 DECLARE SUB MouseStatus (lb%, rb%, xMouse%, yMouse%)
 DECLARE SUB MouseShow ()
 DECLARE SUB MouseRange (X1%, Y1%, x2%, Y2%)
 DECLARE SUB MouseDriver (ax%, bx%, cx%, dx%)
 DECLARE SUB MouseHide ()
 DECLARE FUNCTION MouseInit% ()
 DECLARE FUNCTION WhereTheyClicked% ()
 DECLARE FUNCTION OFUpdate% (Funct%)
 DECLARE SUB OFDraw ()
 DECLARE SUB OFInit ()
 DECLARE SUB Alpha (Sort() AS ANY)

  CONST F.NOR = &H200  'constant for "normal" files (*files* displayed with DIR)
  CONST F.NON = &H100  'constant for files without any attribute
  CONST F.ARC = &H20   'constant for archive file attribute
  CONST F.DIR = &H10   'constant for directory file attribute
  CONST F.VOL = &H8    'constant for volume file attribute
  CONST F.SYS = &H4    'constant for system file attribute
  CONST F.HID = &H2    'constant for hidden file attribute (may return directory)
  CONST F.RDO = &H1    'constant for read-only file attribute
  CONST F.ANY = &H0    'constant for any of the above


 ' This buffer holds all file names when selecting.  String 0 is a string
 ' representation of how many files are found.
 DIM SHARED File(350) AS QBSucks
 DIM SHARED DirList(150) AS QBSucks
 DIM SHARED X%, y%
 DIM SHARED OF AS OFType

 DEFINT A-Z: DEF SEG = &HA000:
 DIM SHARED mouse$: mouse$ = SPACE$(57)
 CLS
 SCREEN 12
 FOR I% = 1 TO 57:  READ a$:  h$ = CHR$(VAL("&H" + a$))
 MID$(mouse$, I%, 1) = h$: NEXT I%
 DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
 DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
 DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
 DATA 8B,5E,06,89,17,5D,CA,08,00
 RESTORE
 ms% = MouseInit%
 IF NOT ms% THEN
   PRINT "Mouse not found"
   END
 END IF
 MouseShow
 MouseRange 0, 0, 630, 478


' Keep all of that confusing stuff contained in one, simple routine


  ' All Files as default
  Fil$ = OpenFile$("")

  ' Just EXE files, etc
  'Fil$ = OpenFile$("exe")
 

  MouseHide
  CLS
  PRINT Fil$
  MouseShow
 

  END

REM $STATIC
SUB Alpha (Sort() AS QBSucks)
MaxSort% = VAL(Sort(0).Dat) - 1
DO
  Change% = 1
    FOR X% = 1 TO MaxSort%
      Pnt% = 1
        LOCATE 1, 1
        DO
          Val1% = ASC(MID$(UCASE$(Sort(X%).Dat), Pnt%, 1))
          Val2% = ASC(MID$(UCASE$(Sort(X% + 1).Dat), Pnt%, 1))
          Pnt% = Pnt% + 1
        LOOP UNTIL Val1% <> Val2%
      IF Val1% > Val2% THEN
        SWAP Sort(X%).Dat, Sort(X% + 1).Dat
        Change% = 0
      END IF
    NEXT
  MaxSort% = MaxSort% - 1
LOOP UNTIL Change% = 1
END SUB

DEFSNG A-Z
'Finds the detailed information about the most recently obtained file by
'the <dir.find$> function.
'INPUT & RETURN:
'* file is a FileTruct TYPE to store the information in, where the following
'  are returned:
'  * file.attrib holds the attribute of the file, or the error code if any
'    error has occured during the last <dir.find$> FUNCTION operation, where
'    the error codes are:
'    * &h02 = file not found
'    * &h03 = path not found
'    * &h12 = no more files
'    Whether an error has occured or not can be determined by checking the
'    name of the file returned -- if the name has no length (""), then an
'    error has occured (or no more files were to be found.)
'  * file.filedate$ holds the date of the file creation/revision.
'  * file.filetime$ holds the time of the file creation/revision.
'  * file.filesize$ holds the size of the file.
'    Size of a file may be a negative number of the file is several hundred
'    megabytes long, but a chance of that happening is miniscuously small.
'EXAMPLE:
'  'Make a place to store detailed information about the file.
'  DIM fileinfo AS FileStruct
'  'initialize and set pattern for the file search
'  dir.init "C:\DOS\*.*", F.ANY
'  'get the file name and store information in <fileinfo> SUB
'  filename$ = dir.find$
'  'get the detailed information from <dir.fileinfo> SUB
'  dir.fileinfo fileinfo
'  'print the information to the screen
'  PRINT "File name: "; dir.find$
'  PRINT "File date: "; fileinfo.filedate$
'  PRINT "File time: "; fileinfo.filetime$
'  PRINT "File size: "; fileinfo.filesize
'  PRINT "File attributes:"
'  IF fileinfo.attrib AND F.DIR THEN PRINT "Directory"
'  IF fileinfo.attrib AND F.HID THEN PRINT "Hidden"
'  IF fileinfo.attrib AND F.VOL THEN PRINT "Volume Label"
'  IF fileinfo.attrib AND F.ARC THEN PRINT "Archive"
'  IF fileinfo.attrib AND F.SYS THEN PRINT "System"
'  IF fileinfo.attrib AND F.RDO THEN PRINT "Read-Only"
'  END
SUB dir.fileinfo (File AS FileStruct)
 
  '== SHARED VARIABLE ==
  SHARED dirfileinfo AS FileStruct

  File = dirfileinfo

END SUB

'Scans for files in a directory
'RETURN:
'* Name of the file/directory is returned.
'* A string with nothing in it ("") will be returned upon error. Error codes
'  are obtainable through <dir.fileinfo> SUB's attribute.
'* Returned error codes (returned by <dir.fileinfo> SUB):
'  * &h02 = file not found
'  * &h03 = path not found
'  * &h12 = no more files
'COMMENT:
'* If dir.find$ is called again, the name of the next file is returned. The
'  user can look for files in a different directory or attributes can restart
'  the search by calling on <dir.init> function again.
'* Details of the found file can be obtained by calling on <dir.fileinfo> SUB
'  right after finding the file.
'EXAMPLE:
'* There is an example on top of <dir.fileinfo> in commented form.
FUNCTION dir.find$
 
  '== SHARED VARIABLES ==
  SHARED dirfileinfo AS FileStruct
  SHARED dircount AS INTEGER
  SHARED dir.attrib AS INTEGER
  SHARED dir.path AS STRING
  SHARED DTAseg AS INTEGER, DTAoff AS INTEGER
  SHARED findfirst$
  SHARED findnext$

  IF dircount = -1 THEN
    pathseg% = VARSEG(dir.path)
    pathoff% = SADD(dir.path)
    asmseg% = VARSEG(findfirst$)
    asmoff% = SADD(findfirst$)
    DEF SEG = asmseg%
    CALL Absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, pathseg%, pathoff%, &HFF, asmoff%)
    DEF SEG
    dircount = 0
  ELSEIF dircount = 0 THEN pathseg% = 1 'simulate error
  ELSE
    '#iab.compatibility.varseg($)
    pathseg% = VARSEG(dir.path)
    pathoff% = SADD(dir.path)
    asmseg% = VARSEG(findnext$)
    asmoff% = SADD(findnext$)
    DEF SEG = asmseg%
    CALL Absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, pathseg%, pathoff%, asmoff%)
    DEF SEG
  END IF
  'check for errors
  IF pathseg% THEN  'error existance is returned through pathseg%
    dir.find$ = ""
    dirfileinfo.attrib = pathoff% 'error code is stored in pathoff%
    dirfileinfo.filedate = "00-00-0000"
    dirfileinfo.filetime = "00:00:00"
  ELSE

    DO
      'get attribute of the file found
      DEF SEG = DTAseg
      attrib% = PEEK(DTAoff + &H15)
      DEF SEG
      'exit conditions:
      IF ((dir.attrib AND &H200) = &H200) AND ((attrib% AND &H21) = (attrib% AND &H3F)) THEN EXIT DO
      IF ((dir.attrib AND &H100) = &H100) AND ((attrib% AND &H3F) = 0) THEN EXIT DO
      IF (dir.attrib AND &H3F) AND (attrib% AND &H3F) THEN EXIT DO
      IF (dir.attrib AND &H3F) = 0 THEN EXIT DO
      'find next until right attributes are found
      '#iab.compatibility.varseg($)
      pathseg% = VARSEG(dir.path)
      pathoff% = SADD(dir.path)
      asmseg% = VARSEG(findnext$)
      asmoff% = SADD(findnext$)
      DEF SEG = asmseg%
      CALL Absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, pathseg%, pathoff%, asmoff%)
      DEF SEG
      IF pathseg% THEN  'error existance is returned through pathseg%
        dir.find$ = ""
        dirfileinfo.attrib = pathoff% 'error code is stored in pathoff%
        dirfileinfo.filedate = "00-00-000"
        dirfileinfo.filetime = "00:00:00"
        EXIT FUNCTION
      END IF
    LOOP
    
    'get name of the file found
    FileName$ = SPACE$(13)
    FOR I% = 0 TO 12
      DEF SEG = DTAseg
      ch% = PEEK(DTAoff + &H1E + I%)
      DEF SEG = VARSEG(FileName$)
      POKE SADD(FileName$) + I%, ch%
      DEF SEG
    NEXT I%
    'find location of CHR$(0) and get only up to that point
    dir.find$ = LEFT$(FileName$, INSTR(FileName$, CHR$(0)))

    'get attribute of the file found
    DEF SEG = DTAseg
    dirfileinfo.attrib = PEEK(DTAoff + &H15)
    DEF SEG

    'get the file's date
    DEF SEG = DTAseg
    filedate& = (PEEK(DTAoff + &H19) AND &H7F) * &H100 + PEEK(DTAoff + &H18)
     IF (PEEK(DTAoff + &H19) AND &H80) THEN filedate& = filedate& OR &H8000
    fileyear$ = LTRIM$(STR$((filedate& AND &HFE00) / &H200 + 1980))
    filemonth$ = LTRIM$(STR$((filedate& AND &H1E0) / &H20))
     IF LEN(filemonth$) < 2 THEN filemonth$ = "0" + filemonth$  'align
    fileday$ = LTRIM$(STR$(filedate& AND &H1F))
     IF LEN(fileday$) < 2 THEN fileday$ = "0" + fileday$        'align
    DEF SEG
    dirfileinfo.filedate$ = filemonth$ + "-" + fileday$ + "-" + fileyear$

    'get the file's time
    DEF SEG = DTAseg
    filetime& = (PEEK(DTAoff + &H17) AND &H7F) * &H100 + PEEK(DTAoff + &H16)
     IF (PEEK(DTAoff + &H17) AND &H80) THEN filetime& = filetime& OR &H8000
    filehour& = (filetime& AND &H7800) / &H800
     IF (filetime& AND &H8000) THEN filehour& = filehour& OR &H10
    filehour$ = LTRIM$(STR$(filehour&))
     IF LEN(filehour$) < 2 THEN filehour$ = "0" + filehour$     'align
    filemin$ = LTRIM$(STR$((filetime& AND &H7E0) / &H20))
     IF LEN(filemin$) < 2 THEN filemin$ = "0" + filemin$        'align
    filesec$ = LTRIM$(STR$((filetime& AND &H1F) * 2))
     IF LEN(filesec$) < 2 THEN filesec$ = "0" + filesec$        'align
    DEF SEG
    dirfileinfo.filetime$ = filehour$ + ":" + filemin$ + ":" + filesec$

    DEF SEG = DTAseg
    filesize& = (PEEK(DTAoff + &H1D) AND &H7F) * &H1000000
    filesize& = filesize& + PEEK(DTAoff + &H1C) * &H10000
    filesize& = filesize& + PEEK(DTAoff + &H1B) * &H100&
    filesize& = filesize& + PEEK(DTAoff + &H1A) * &H1
    IF (PEEK(DTAoff + &H1D) AND &H80) THEN filesize& = filesize& OR &H8000
    dirfileinfo.filesize = filesize&
    DEF SEG
  END IF

  dircount = dircount + 1
END FUNCTION

'Initializes the "dir" family functions (dir.init, dir.find$, dir.fileinfo)
'COMMENT:
'* This function is also used to "reset" the search "patterns" used by
'  <dir.find$>.
'INPUT:
'* path.o$ is the file parameter to scan for. Wildcards okay.
'* attrib.o% is the attribute to look for, where:
'  * &h200 is for "normal" files that are displayed from DOS by simple "DIR"
'    command. This call is handled through the function.
'  * &h100 is for files without any attributes. This call is also handled
'    through the function.
'  * &h20 is for archive files. This is handled by DOS (sort of).
'  * &h10 if for directories. This is also handled by DOS (once again, sort
'    of).
'  * &h8 is for file that stands for the volume label. This could be used on
'    the root directory of each drive to find out the name of the drive, but
'    the information may not always be accurate in that there is a second
'    copy of volume label in the boot sector which is the "real thing". The
'    file with the volume attribute is sort of like "shadow" of the real
'    thing. However, any major or proper program will modify both volume
'    labels.
'  * &h4 is for files with system attribute. Handled by DOS. System files
'    also appear to be hidden.
'  * &h2 is for files with hidden attribute. Handled by DOS.
'  * &h1 is for read-only files. Handled by DOS.
'  * &h0 is for any of the above files. Handled by the function.
'  Combination of these attributes can be made (ie - &h06 for hidden system
'    files.)
'  When a file name is returned through <dir.find$> function, file with ANY
'    of the above specs will be returned. For instance, if the user specifies
'    a hidden file, a file with hidden attribute AND any other ones will be
'    returned. (That's why I made the "normal" attribute)
SUB Dir.init (path.o$, attrib.o%)

  '== SHARED VARIABLES ==
  'general
  SHARED dirfileinfo AS FileStruct
  SHARED dircount AS INTEGER
  'control variables
  SHARED dir.attrib AS INTEGER
  SHARED dir.path AS STRING
  'machine language routines
  SHARED DTAseg AS INTEGER, DTAoff AS INTEGER
  SHARED findfirst$
  SHARED findnext$

  '== INITIALIZATION ==
  dircount = -1
  dir.attrib = attrib.o%
  dir.path = path.o$ + CHR$(0)

  '== get DTA address ==
  'initialize machine language code to get DTA address
  asm$ = ""
  asm$ = asm$ + CHR$(&H55)                           'push bp          DTA
  asm$ = asm$ + CHR$(&H89) + CHR$(&HE5)              'mov bp, sp       DTA
  asm$ = asm$ + CHR$(&HB4) + CHR$(&H2F)              'mov ah, 2f       DTA
  asm$ = asm$ + CHR$(&HCD) + CHR$(&H21)              'int 21           DTA
  asm$ = asm$ + CHR$(&H89) + CHR$(&HD8)              'mov ax, bx       DTA
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)  'mov bx, [bp+08]  DTA
  asm$ = asm$ + CHR$(&H8C) + CHR$(&H7)               'mov [bx], es     DTA
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)  'mov bx, [bp+06]  DTA
  asm$ = asm$ + CHR$(&H89) + CHR$(&H7)               'mov [bx], ax     DTA
  asm$ = asm$ + CHR$(&H5D)                           'pop bp           DTA
  asm$ = asm$ + CHR$(&HCA) + CHR$(&H12) + CHR$(&H0)  'retf 0012        DTA
  'get segment and offsets
  asmseg% = VARSEG(asm$)
  asmoff% = SADD(asm$)
  'execute
  DEF SEG = asmseg%
  CALL Absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, DTAseg, DTAoff, asmoff%)
  DEF SEG

  '== FIND FIRST ==
  'initialize machine language code
  findfirst$ = ""
  findfirst$ = findfirst$ + CHR$(&H55)                           'push bp          F1st
  findfirst$ = findfirst$ + CHR$(&H89) + CHR$(&HE5)              'mov bp, sp       F1st
  findfirst$ = findfirst$ + CHR$(&HB4) + CHR$(&H4E)              'mov ah, 4e       F1st
  findfirst$ = findfirst$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HA)  'mov bx, [bp+0a]  F1st
  findfirst$ = findfirst$ + CHR$(&H8E) + CHR$(&H1F)              'mov ds, [bx]     F1st
  findfirst$ = findfirst$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)  'mov bx, [bp+08]  F1st
  findfirst$ = findfirst$ + CHR$(&H8B) + CHR$(&H17)              'mov dx, [bx]     F1st
  findfirst$ = findfirst$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)  'mov bx, [bp+06]  F1st
  findfirst$ = findfirst$ + CHR$(&H8B) + CHR$(&HF)               'mov cx, [bx]     F1st
  findfirst$ = findfirst$ + CHR$(&HCD) + CHR$(&H21)              'int 21           F1st
  findfirst$ = findfirst$ + CHR$(&HB9) + CHR$(&H0) + CHR$(&H0)   'mov cx, 0000     F1st
  findfirst$ = findfirst$ + CHR$(&H80) + CHR$(&HD1) + CHR$(&H0)  'adc cl, 00       F1st
  findfirst$ = findfirst$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HA)  'mov bx, [bp+0a]  F1st
  findfirst$ = findfirst$ + CHR$(&H89) + CHR$(&HF)               'mov [bx], cx     F1st
  findfirst$ = findfirst$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)  'mov bx, [bp+08]  F1st
  findfirst$ = findfirst$ + CHR$(&H89) + CHR$(&H7)               'mov [bx], ax     F1st
  findfirst$ = findfirst$ + CHR$(&H5D)                           'pop bp           F1st
  findfirst$ = findfirst$ + CHR$(&HCA) + CHR$(&H12) + CHR$(&H0)  'retf 0012        F1st

  '== FIND NEXT ==
  'initialize machine language code
  findnext$ = ""
  findnext$ = findnext$ + CHR$(&H55)                           'push bp          FNxt
  findnext$ = findnext$ + CHR$(&H89) + CHR$(&HE5)              'mov bp, sp       FNxt
  findnext$ = findnext$ + CHR$(&HB4) + CHR$(&H4F)              'mov ah, 4f       FNxt
  findnext$ = findnext$ + CHR$(&HCD) + CHR$(&H21)              'int 21           FNxt
  findnext$ = findnext$ + CHR$(&HB9) + CHR$(&H0) + CHR$(&H0)   'mov cx, 0000     FNxt
  findnext$ = findnext$ + CHR$(&H80) + CHR$(&HD1) + CHR$(&H0)  'adc cl, 00       FNxt
  findnext$ = findnext$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)  'mov bx, [bp+08]  FNxt
  findnext$ = findnext$ + CHR$(&H89) + CHR$(&HF)               'mov [bx], cx     FNxt
  findnext$ = findnext$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)  'mov bx, [bp+06]  FNxt
  findnext$ = findnext$ + CHR$(&H89) + CHR$(&H7)               'mov [bx], ax     FNxt
  findnext$ = findnext$ + CHR$(&H5D)                           'pop bp           FNxt
  findnext$ = findnext$ + CHR$(&HCA) + CHR$(&H12) + CHR$(&H0)  'retf 0012        FNxt

END SUB

FUNCTION getdir$ (Drive%)

  Drive% = Drive% + 1
  'initialize assembly code
  asm$ = ""
  asm$ = asm$ + CHR$(&H55)                                  'push bp
  asm$ = asm$ + CHR$(&H89) + CHR$(&HE5)                     'mov bp, sp
  asm$ = asm$ + CHR$(&HB4) + CHR$(&H47)                     'mov ah, 47h
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HA)         'mov bx, [bp+0ah]
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H17)                     'mov dx, [bx]
  asm$ = asm$ + CHR$(&H1E)                                  'push ds
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)         'mov bx, [bp+08h]
  asm$ = asm$ + CHR$(&H8E) + CHR$(&H1F)                     'mov ds, [bx]
  asm$ = asm$ + CHR$(&H56)                                  'push si
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)         'mov bx, [bp+06h]
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H37)                     'mov si, [bx]
  asm$ = asm$ + CHR$(&HCD) + CHR$(&H21)                     'int 21h
  asm$ = asm$ + CHR$(&H5E)                                  'pop si
  asm$ = asm$ + CHR$(&H1F)                                  'pop ds
  asm$ = asm$ + CHR$(&HBA) + CHR$(&H0) + CHR$(&H0)          'mov dx, 0000h
  asm$ = asm$ + CHR$(&H80) + CHR$(&HD2) + CHR$(&H0)         'adc dl, 00h
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HA)         'mov bx, [bp+0a]
  asm$ = asm$ + CHR$(&H89) + CHR$(&H17)                     'mov [bx], dx
  asm$ = asm$ + CHR$(&H5D)                                  'pop  bp
  asm$ = asm$ + CHR$(&HCA) + CHR$(&H12) + CHR$(&H0)         'retf 0012h

  'string to store directory information
  directory$ = SPACE$(65)
  dirseg% = VARSEG(directory$)  'get segment address
  diroff% = SADD(directory$)    'get offset address

  'execute
  DEF SEG = VARSEG(asm$)
  CALL Absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, Drive%, dirseg%, diroff%, SADD(asm$))
  directory$ = LEFT$(directory$, INSTR(directory$, CHR$(0)))
  IF LEFT$(directory$, 1) <> "\" THEN directory$ = "\" + directory$

  IF Drive% THEN directory$ = ""

  getdir$ = directory$

END FUNCTION

FUNCTION getdrv%

  'initialize assembly code
  asm$ = ""
  asm$ = asm$ + CHR$(&H55)                                  'push bp
  asm$ = asm$ + CHR$(&H89) + CHR$(&HE5)                     'mov bp, sp
  asm$ = asm$ + CHR$(&HB4) + CHR$(&H19)                     'mov ah, 19h
  asm$ = asm$ + CHR$(&HCD) + CHR$(&H21)                     'int 21h
  asm$ = asm$ + CHR$(&HB4) + CHR$(&H0)                      'mov ah, 00h
  asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)         'mov bx, [bp+06h]
  asm$ = asm$ + CHR$(&H89) + CHR$(&H7)                      'mov [bx], ax
  asm$ = asm$ + CHR$(&H5D)                                  'pop bp
  asm$ = asm$ + CHR$(&HCA) + CHR$(&H12) + CHR$(&H0)         'retf 0012h

  'execute
  DEF SEG = VARSEG(asm$)
  CALL Absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, Drive%, SADD(asm$))

  getdrv% = Drive%

END FUNCTION

DEFLNG A-Z
SUB MouseDriver (ax%, bx%, cx%, dx%)
  DEF SEG = VARSEG(mouse$)
  mouse% = SADD(mouse$)
  CALL Absolute(ax%, bx%, cx%, dx%, mouse%)
END SUB

SUB MouseHide
 ax% = 2
 MouseDriver ax%, 0, 0, 0
END SUB

FUNCTION MouseInit%
  ax% = 0
  MouseDriver ax%, 0, 0, 0
  MouseInit% = ax%
END FUNCTION

SUB MousePut (X%, y%)
  ax% = 4
  cx% = X%
  dx% = y%
  MouseDriver ax%, 0, cx%, dx%
END SUB

SUB MouseRange (X1%, Y1%, x2%, Y2%)
  ax% = 7
  cx% = X1%
  dx% = x2%
MouseDriver ax%, 0, cx%, dx%
  ax% = 8
  cx% = Y1%
  dx% = Y2%
  MouseDriver ax%, 0, cx%, dx%
END SUB

SUB MouseShow
  ax% = 1
  MouseDriver ax%, 0, 0, 0
END SUB

SUB MouseStatus (lb%, rb%, xMouse%, yMouse%)
  ax% = 3
  MouseDriver ax%, bx%, cx%, dx%
  lb% = ((bx% AND 1) <> 0)
  rb% = ((bx% AND 2) <> 0)
  xMouse% = cx%
  yMouse% = dx%
END SUB

DEFINT A-Z
SUB OFDraw

  ' Display all file names and boxes and bull crap like that

MouseHide

LOCATE 7, 36: PRINT "Open File"
LINE (60, 90)-(580, 370), 15, B ' whole box

LOCATE 12, 30: PRINT "Files                       Dir \ Drives"
LINE (90, 190)-(435, 338), 15, B ' file box

OFText 2
LINE (456, 190)-(552, 338), 15, B ' dirs box

LOCATE 13, 71: PRINT ""
LOCATE 21, 71: PRINT ""
LINE (558, 190)-(570, 338), 15, B ' dir arrow box


LOCATE 23, 12: PRINT "-                                       -"
LINE (88, 345)-(437, 365), 15, B ' arrow box

LOCATE 9, 10: PRINT "File Name : " + "*.";
IF OF.Opt = STRING$(3, " ") THEN PRINT "*" ELSE PRINT OF.Opt
LINE (163, 124)-(570, 144), 15, B

 
  OFText 1
  MouseShow

END SUB

SUB OFInit

OF.DirSpot = 1
OF.FileSpot = 1

  FOR X% = 1 TO 150
   File(X%).Dat = ""
   DirList(X%).Dat = ""
  NEXT
 
  ' Store the current drive and path
  Option$ = UCASE$(OF.Opt)
  cd% = getdrv: swp% = cd%: path$ = getdir$(swp%)
  Total$ = CHR$(cd% + 65) + ":" + path$

  LOCATE 11, 12: PRINT Total$; SPACE$(50)
  
  ' Init the dir scan
  Total$ = LEFT$(Total$, LEN(Total$) - 1)
  IF RIGHT$(Total$, 1) <> "\" THEN Total$ = Total$ + "\"
  dir$ = Total$ + "*.*"
  Dir.init dir$, F.NOR
  DIM info AS FileStruct

  ' Store all matching files into the File() buffer,
  F% = 1: dir% = 1
  DO
    FileName$ = dir.find$
    dir.fileinfo info
     IF FileName$ <> "" THEN
  
      IF info.attrib AND F.ARC THEN
         FileName$ = LEFT$(FileName$, LEN(FileName$) - 1)
         IF RIGHT$(FileName$, 3) = OF.Opt OR OF.Opt = "   " THEN
          File(F%).Dat = FileName$
          F% = F% + 1
         END IF
      END IF
      IF info.attrib AND F.DIR THEN
         DirList(dir%).Dat = FileName$
         dir% = dir% + 1
      END IF
     ELSE
      EXIT DO
     END IF
  LOOP
  OF.MaxDSpot = dir%
  OF.MaxFSpot = F% / 9 + 1
  OF.NumFiles = F%
  File(0).Dat = STR$(F% - 1)
  DirList(0).Dat = STR$(dir% - 1)
  Alpha File()
  Alpha DirList()
END SUB

SUB OFText (w%)
MouseHide

SELECT CASE w%

 CASE 1:
  With% = 14: Hite% = 13
  Shown% = 0
  DO
    LOCATE Hite%, With%
    IF Shown% + OF.FileSpot = OF.HighFile THEN COLOR 14 ELSE COLOR 15
     PRINT File(Shown% + OF.FileSpot).Dat
    Shown% = Shown% + 1
    Hite% = Hite% + 1
    IF Hite% = 22 THEN
     Hite% = 13
     With% = With% + 14
    END IF
    IF With% = 56 THEN EXIT DO
  LOOP
  COLOR 15

 CASE 2:

FOR XX% = 1 TO 9
 LOCATE 12 + XX%, 58
 IF OF.HighDir = XX% + OF.DirSpot THEN COLOR 14 ELSE COLOR 15
  PRINT DirList(OF.DirSpot + XX%).Dat
NEXT
LINE (456, 190)-(552, 338), 15, B ' dirs box
COLOR 15

END SELECT

MouseShow
END SUB

FUNCTION OFUpdate% (Funct%)

SELECT CASE Funct%
  CASE 1: Row! = (X% - 90) / 115: Col! = (y% - 190) / 16.4444444444#
          Row! = INT(Row!): Col! = INT(Col!)
          OF.HighFile = Col! + (9 * Row!) + OF.FileSpot
          OF.HighDir = 0
          IF OF.Flag = -1 THEN
            IF OF.Time > TIMER THEN
              OFUpdate% = 1: EXIT FUNCTION
            ELSE
             OF.Flag = 0
            END IF
           ELSE
            DO
                 MouseStatus lb%, rb%, X%, y%
            LOOP UNTIL lb% = 0
            OF.Time = TIMER + .3
            OF.Flag = -1
           END IF
           OFText 1: OFText 2

  CASE 2: Col! = (y% - 190) / 16.44444444444#
          OF.HighDir = INT(Col!) + OF.DirSpot + 1
          OF.HighFile = 0
          IF OF.Flag = -1 THEN
            IF OF.Time > TIMER THEN
              IF DirList(OF.HighDir).Dat <> STRING$(12, " ") THEN
               LINE (91, 191)-(434, 337), 0, BF ' file box
               CHDIR DirList(OF.HighDir).Dat
               OF.HighDir = 0
               OFInit
               OFDraw
              END IF
            ELSE
              OF.Flag = 0
            END IF
           ELSE
              DO
                    MouseStatus lb%, rb%, X%, y%
              LOOP UNTIL lb% = 0
           
            OF.Time = TIMER + .3
            OF.Flag = -1
           END IF
          OFText 2: OFText 1
  CASE 3: IF OF.DirSpot > 1 THEN OF.DirSpot = OF.DirSpot - 1: OFDraw
  CASE 4: IF OF.DirSpot + 10 < OF.MaxDSpot THEN OF.DirSpot = OF.DirSpot + 1: OFDraw
  CASE 5:
          IF OF.FileSpot > 1 THEN
           OF.FileSpot = OF.FileSpot - 9
           OFDraw
          END IF
  CASE 6:
          IF (OF.FileSpot - 1) / 9 < OF.MaxFSpot - 4 THEN
           OF.FileSpot = OF.FileSpot + 9
           OFDraw
          END IF
END SELECT

END FUNCTION

DEFSNG A-Z
' OpenFile, the main routine
' Returns the file they selected, or a null string if none
' Options$ is the default file type to display.  A null Option$
' filters all files into the File box.
FUNCTION OpenFile$ (Option$)
 
  OF.Opt = UCASE$(Option$)
  OF.DirSpot = 1

  OFInit
   
  'F% = F% - 1
 
  OFDraw

  DO
    MouseStatus lb%, rb%, X%, y%
    KeyB$ = INKEY$
    IF KeyB$ <> "" THEN
     SELECT CASE KeyB$
       CASE CHR$(0) + "H":
                        IF OF.HighFile <> 0 THEN
                         IF OF.HighFile > 1 THEN
                          IF OF.HighFile = OF.FileSpot THEN OF.FileSpot = OF.FileSpot - 9
                          OF.HighFile = OF.HighFile - 1
                         END IF
                         OFText 1
                        END IF
                        IF OF.HighDir <> 0 THEN
                         IF OF.HighDir > 2 THEN
                          IF OF.HighDir = OF.DirSpot + 1 THEN OF.DirSpot = OF.DirSpot - 1
                          OF.HighDir = OF.HighDir - 1
                         END IF
                         OFText 2
                        END IF
       CASE CHR$(0) + "P":
                        IF OF.HighFile <> 0 THEN
                         IF OF.HighFile < OF.NumFiles - 1 THEN
                          IF OF.HighFile - OF.FileSpot = 26 THEN OF.FileSpot = OF.FileSpot + 9
                          OF.HighFile = OF.HighFile + 1
                         END IF
                         OFText 1
                        END IF
                        IF OF.HighDir <> 0 THEN
                         IF OF.HighDir < OF.MaxDSpot - 1 THEN
                           IF OF.HighDir = OF.DirSpot + 9 THEN OF.DirSpot = OF.DirSpot + 1
                           OF.HighDir = OF.HighDir + 1
                         END IF
                         OFText 2
                        END IF
       CASE CHR$(0) + "M":
                          IF OF.HighFile <> 0 THEN
                            IF OF.HighFile + 9 <= OF.NumFiles THEN
                             IF (OF.HighFile - 1) \ 9 > (OF.FileSpot \ 9) + 1 THEN OF.FileSpot = OF.FileSpot + 9
                             IF File(OF.HighFile + 9).Dat <> "            " THEN OF.HighFile = OF.HighFile + 9
                            END IF
                            OFText 1
                          END IF

      CASE CHR$(0) + "K":
                          IF OF.HighFile <> 0 THEN
                            IF OF.HighFile - 9 >= 1 THEN
                             IF (OF.HighFile - 1) \ 9 < (OF.FileSpot \ 9) + 1 THEN OF.FileSpot = OF.FileSpot - 9
                             OF.HighFile = OF.HighFile - 9
                            END IF
                          
                            OFText 1
                          END IF

       CASE CHR$(13):
                      IF OF.HighDir = 0 THEN
                       OpenFile$ = File(OF.HighFile).Dat: EXIT FUNCTION
                      ELSE
                       LINE (91, 191)-(434, 337), 0, BF ' file box
                       CHDIR DirList(OF.HighDir).Dat
                       OF.HighDir = 2
                       OFInit
                       OFDraw
                      END IF
       
        CASE CHR$(9):
                     IF OF.HighDir = 0 THEN
                      OF.HighDir = 2
                      OF.HighFile = 0
                     ELSE
                      OF.HighDir = 0
                      OF.HighFile = 1
                     END IF
                     : OFText 1: OFText 2
       CASE CHR$(27): EXIT FUNCTION
      END SELECT

    END IF
    IF lb% = -1 THEN
     ' Return a function for the program to carry out
     Funct% = WhereTheyClicked%
    
     ' If they clicked a valid point, carry out each function
     IF Funct% <> 0 THEN V% = OFUpdate(Funct%)
    
     IF V% = 1 THEN
      IF File(OF.HighFile).Dat <> STRING$(12, " ") THEN
       OpenFile$ = File(OF.HighFile).Dat
       EXIT FUNCTION
      END IF
     END IF

    END IF
  LOOP

END FUNCTION

DEFINT A-Z
FUNCTION WhereTheyClicked%
' 1 = on a file name
' 2 = on a directory
' 3 = up, dir select
' 4 = down, dir select
' 5 = left, dir select
' 6 = right, dir select

IF X% > 90 AND X% < 435 THEN
 IF y% > 190 AND y% < 338 THEN WhereTheyClicked% = 1
END IF
IF X% > 456 AND X% < 552 THEN
 IF y% > 190 AND y% < 338 THEN WhereTheyClicked% = 2
END IF
IF X% > 558 AND X% < 570 THEN
 IF y% > 190 AND y% < 210 THEN WhereTheyClicked% = 3
 IF y% > 320 AND y% < 338 THEN WhereTheyClicked% = 4
END IF
IF y% > 345 AND y% < 365 THEN
 IF X% > 88 AND X% < 104 THEN WhereTheyClicked% = 5
 IF X% > 420 AND X% < 437 THEN WhereTheyClicked% = 6
END IF
LINE (88, 345)-(437, 365), 15, B ' arrow box
END FUNCTION

