' File Opener v1.0
' all hardware code by Mark K Kim
' interface written by Molnar \ Kucalaba Productions

' This is the root program.  This form can be taken any direction you want.
' FOPEN2.BAS is a highly specialized form for screen mode 12h.


DECLARE SUB absolute (var1%, var2%, var3%, var4%, var5%, var6%, var7%, var8%, var9%, offset%)

 TYPE FileStruct
    attrib AS INTEGER
    filedate AS STRING * 10
    filetime AS STRING * 8
    filesize AS DOUBLE
 END TYPE


 DECLARE FUNCTION OpenFile$ (Option$)
 DECLARE FUNCTION getdrv% ()
 DECLARE FUNCTION getdir$ (Drive%)
 DECLARE FUNCTION dir.find$ ()                 'call next to get filenames
 DECLARE SUB Dir.init (path$, attrib%)         'call first to initialize
 DECLARE SUB dir.fileinfo (File AS FileStruct) 'call to get file information

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
 ' represntation of how many files are found.
 DIM SHARED File(100) AS STRING * 12
 CLS

' Keep all of that confusing stuff contained in one, simple routine

  Fil$ = OpenFile$("*.exe")

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
    CALL absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, pathseg%, pathoff%, &HFF, asmoff%)
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
    CALL absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, pathseg%, pathoff%, asmoff%)
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
      CALL absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, pathseg%, pathoff%, asmoff%)
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
  CALL absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, DTAseg, DTAoff, asmoff%)
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
  CALL absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, Drive%, dirseg%, diroff%, SADD(asm$))
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
  CALL absolute(dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, dummy%, Drive%, SADD(asm$))

  getdrv% = Drive%

END FUNCTION

' OpenFile, the main routine
' Returns the file they selected, or a null string if none
' Options$ is like "*.*" or "*.EXE" or "*.MKJ", etc
FUNCTION OpenFile$ (Option$)
 
  ' Store the current drive and path
  cd% = getdrv: swp% = cd%: path$ = getdir$(swp%)
  Total$ = CHR$(cd% + 65) + ":" + path$
 
  ' Init the dir scan
  Total$ = LEFT$(Total$, LEN(Total$) - 1)
  dir$ = Total$ + "\" + Option$
 
  Dir.init dir$, F.NOR
  DIM info AS FileStruct
 
  ' Store all matching files into the File() buffer
  DO
    I% = I% + 1
    FileName$ = dir.find$
    dir.fileinfo info
     IF FileName$ <> "" THEN
       File(I%) = FileName$
     ELSE
      EXIT DO
     END IF
  LOOP
   
   I% = I% - 1

   FOR X% = 1 TO I%
    PRINT File(X%)
   NEXT


END FUNCTION

