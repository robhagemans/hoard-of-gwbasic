' UFPACK - Packs (reduces over all size) of EBBS-PC Userfiles
' Ed Parry
' Started: 05-18-1993
' Updated: 05-22-1993
'

$CPU 8086

SHARED size%
DIM uf$(50) 'userfile fields

ON ERROR GOTO ErrHandler

DEFINT A-Z
CLS

size   = 512 'bytes in each record
fields = 43  'fields per record
empties = 0  'empties counter
true    = -1 'constant TRUE
false   = NOT TRUE 'contant for FALSE
skip    = false 'default for skipping ufiles
target  = 1 'starting target record counter

COLOR 15,4

ta=20
LOCATE 2,20
LOCATE ,20:PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
LOCATE ,20:PRINT "³   EBBS-PC Userfile Pack Utility    ³"
LOCATE ,20:PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
LOCATE ,20:PRINT "³ Userfiles to Scan  :               ³"
LOCATE ,20:PRINT "³ Scanning Userfile  :               ³"
LOCATE ,20:PRINT "³ Empties Found      :               ³"
LOCATE ,20:PRINT "³ Userfiles Written  :               ³"
LOCATE ,20:PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

CALL OpnUsrOut 'OPEN new ufile
CALL OpnUsrIn 'OPEN current ufile

recs=LOF(2)/size 'total records to read
LOCATE 5,43
PRINT recs

FOR source=1 to recs
 LOCATE 6,43
 PRINT source
 GET #2,source
 FOR f=1 TO fields 'current field to read
  INPUT #2,uf$(f)
  IF LEN(uf$(1)) < 5 THEN empties=empties+1:skip=true:EXIT FOR
 NEXT f
 LOCATE 7,43
 PRINT empties
 IF skip=false THEN GOSUB WriteRecord
skip=false
NEXT source
CLOSE #2, #4

'juggle files
KILL "USERFILE.DAT"
NAME "USERFILE.TMP" AS "USERFILE.DAT"

'setup to sortuf
OPEN "SORTUF.FLG" FOR OUTPUT AS #1
CLOSE #1

END

WriteRecord:
 FOR t=1 TO fields
  PRINT #4,uf$(t)
 NEXT
 PUT #4, target
 LOCATE 8,43
 PRINT target
 IF target <> source THEN GOSUB RenameEmail
 target=target+1
RETURN

RenameEmail:
 a$=RIGHT$("000"+MID$(STR$(source),2),4) 'old email rec no.
 b$=RIGHT$("000"+MID$(STR$(target),2),4) 'new email rec no.
 em=1:oops=0
 DO WHILE oops=0
  c$=RIGHT$("00"+MID$(STR$(em),2),3) 'email no.
  oldfile$="EMAIL\"+a$+"."+c$
  newfile$="EMAIL\"+b$+"."+c$
  NAME oldfile$ AS newfile$
  em=em+1
 LOOP
RETURN

SUB OpnUsrIn STATIC 'source userfile
 OPEN "USERFILE.DAT" FOR RANDOM AS #2 LEN=size
END SUB

SUB OpnUsrOut STATIC 'target userfile
 OPEN "USERFILE.TMP" FOR RANDOM AS #4 LEN=size
END SUB

ErrHandler:
oops=ERR
RESUME NEXT

