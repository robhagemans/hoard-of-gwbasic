' XFMAINT - Packs xfer control files, sorts filename's, corrects
'           filesize errors, updates xferfile.dat file data.
' Ed Parry
' Started: 05-19-1993
' Updated: 05-28-1993
'

$CPU 8086
$OPTIMIZE SIZE
$STATIC


DIM xf$(1:500,1:6) 'max files per section/fields
DIM path$(1:30)  'max number of paths

SHARED size%, mx%, oops%, path$, xf$(), recs%, true%, false%

DEFINT A-Z
CLS

ON ERROR GOTO ErrorHandler 'resume/next all errors!

size     = 128      'bytes in each record
fields   = 6        'fields per record
true     = -1       'constant TRUE
false    = NOT TRUE 'contant for FALSE
skip     = false    'default for skipping xfiles
msect$   = "Z"      'last section default
section  = 1        'starting section counter default

COLOR 15,5

oops=0
OPEN "EBBSCFG.DAT" FOR INPUT AS #1
 IF oops THEN
  PRINT "EBBSCFG.DAT file not found. ";
  PRINT "This file is required for the XFMAINT module."
  BEEP
  END 'end if no config file
 END IF
 WHILE ((NOT EOF(1)) AND (INSTR(i$,"SectA")=0))
  LINE INPUT #1,i$
 WEND 'find the xfer paths first
 FOR i=1 to 26
  LINE INPUT #1, path$(i) 'get path's
  LINE INPUT #1, temp$ 'throw away xfer section names
 NEXT
 CLOSE #1
 FOR i=1 TO 26 'parse paths
  path$(i)=MID$(path$(i),INSTR(path$(i),"=")+2)
 NEXT

LOCATE 5,20
LOCATE ,20:PRINT"ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
LOCATE ,20:PRINT"³ EBBS-PC Xferfile Maintenance Utility ³"
LOCATE ,20:PRINT"ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
LOCATE ,20:PRINT"³ Sections to Scan   :                 ³"
LOCATE ,20:PRINT"³ Scanning Section   :                 ³"
LOCATE ,20:PRINT"³ Present Status     :                 ³"
LOCATE ,20:PRINT"ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

LOCATE 8,43
PRINT "A-"msect$

ReadRecords:
 path$=path$(section)
 LOCATE 9,43
 PRINT CHR$(64+section)
 LOCATE 10,43
 PRINT "Read   "
 ERASE xf$
 oops=0
 CALL Open.Xfer.In  'OPEN current xfile
 IF oops=53 THEN CLOSE #2:GOTO SetNextSection
 recs=LOF(2)/size 'total records to read
 REDIM xf$(1 TO recs,1 TO 6)
 FOR s=1 to recs
  GET #2,s
   FOR f=1 TO fields 'current field to read
     LINE INPUT #2,xf$(s,f)
   NEXT f
 NEXT s
 CLOSE #2
 LOCATE 10,43
 PRINT "Fix Size"
 CALL FixFileSize

SortRecords:
 LOCATE 10,43
 PRINT "Sort    "
 CALL ShellSort 'sort em by filename

WriteRecords:
 counter=1
 CALL Open.Xfer.Out
 LOCATE 10,43
 PRINT "Write   "
 FOR s=1 TO recs
  IF LEN(xf$(s,1)) > 4 THEN
   FOR f=1 TO fields
    PRINT #4,xf$(s,f)
   NEXT f
   PUT #4,counter
   counter=counter+1
  END IF
 NEXT s
 CLOSE #4

SetNextSection:
 section=section+1
 IF section < (ASC(msect$)+1)-64 THEN GOTO ReadRecords
 LOCATE 10,43
 PRINT "Done!"
END

SUB FixFileSize STATIC 'adjust filesize field
 FOR s=1 to recs
  IF LEN(xf$(s,1)) > 4 THEN
   oops=0
   OPEN path$+"\"+xf$(s,1) FOR INPUT AS #6
    IF oops<>53 THEN xf$(s,2) = MID$(STR$(LOF(6)),2)
   CLOSE #6
  END IF
 NEXT
END SUB

SUB Open.Xfer.In STATIC 'source XFERFILE
 OPEN path$+"\XFERFILE.DAT" FOR RANDOM AS #2 LEN=size
END SUB

SUB Open.Xfer.Out STATIC 'target XFERFILE
 KILL path$+"\XFERFILE.BAK" 'lose old backup
 NAME path$+"\XFERFILE.DAT" AS path$+"\XFERFILE.BAK" 'backup current
 OPEN path$+"\XFERFILE.DAT" FOR RANDOM AS #4 LEN=size 'reopen new
END SUB

SUB ShellSort STATIC
 'Set comparison offset to half the number of records in SortArray:
 mx = recs
 offset = mx \ 2
 DO WHILE offset > 0  'Loop until offset gets to zero.
  limit = mx - offset
  DO
   switch = FALSE      'Assume no switches at this offset.
   'Compare elements and switch ones out of order:
   FOR row = 1 TO limit
    IF xf$(row,1) > xf$(row + offset,1) THEN
      FOR x=1 to 6 'tag along rest of array
       SWAP xf$(row,x), xf$(row + offset,x)
      NEXT
     switch = row
    END IF
   NEXT row
   'Sort on next pass only to where last switch was made:
   limit = switch - offset
   LOOP WHILE switch
    'No switches at last offset, try one half as big:
    offset = offset \ 2
  LOOP
END SUB

ErrorHandler:
 oops=ERR
RESUME NEXT
