' DBLUF - Double UF size from 256 bytes to 512 bytes
'         Convert numeric levels to alpha
'	  Convert old MM DDD YY format to MM-DD-YYYY
' Ed Parry
' Started: 05-22-1993
' Updated: 05-22-1993
'

$CPU 8086
$FLOAT EMULATE

SHARED oldsize%, newsize%
DIM uf$(50) 'userfile fields

ON ERROR GOTO ErrHandler

DEFINT A-Z
CLS

oldsize   = 256 'old bytes in each record
oldfields = 27  'old fields per record
newsize   = 512 'new bytes in each record
newfields = 43  'new fields per record


true    = -1 'constant TRUE
false   = NOT TRUE 'contant for FALSE

COLOR 15,2

ta=20
LOCATE 2,20
LOCATE ,20:PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
LOCATE ,20:PRINT "³  EBBS-PC Update Userfile Utility   ³"
LOCATE ,20:PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
LOCATE ,20:PRINT "³ Userfiles to Update :              ³"
LOCATE ,20:PRINT "³ Userfiles Updated   :              ³"
LOCATE ,20:PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

CALL OpnUsrOut 'OPEN new ufile
CALL OpnUsrIn 'OPEN current ufile

recs=LOF(2)/oldsize 'total records to read
LOCATE 5,43
PRINT recs

FOR source=1 to recs
 GET #2,source
 FOR f=1 TO oldfields 'current field to read
  INPUT #2,uf$(f)
 NEXT f
 GOSUB WriteRecord
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
 GOSUB ConvertLevel
 GOSUB ConvertDate
 FOR t=1 TO newfields
  IF uf$(t)="" THEN uf$(t)="0"
  PRINT #4,uf$(t)
 NEXT
 PUT #4, source
 LOCATE 6,43
 PRINT source
RETURN

ConvertLevel:
 mblv=VAL(uf$(9))
 xflv=VAL(uf$(10))
 mblv$=""
 xflv$=""
 FOR i=0 to 15
  IF ((2^i) AND mblv) THEN mblv$=mblv$+CHR$(i+65)
 NEXT
 FOR i=0 to 15
  IF ((2^i) AND xflv) THEN xflv$=xflv$+CHR$(i+65)
 NEXT
 IF mblv=32767 THEN mblv$=mblv$+"PQRSTUVWXYZ"
 IF xflv=32767 THEN xflv$=xflv$+"PQRSTUVWXYZ"
 IF INSTR(mblv$,"Z")=0 THEN IF (mblv AND (2^10)) THEN mblv$=mblv$+"Z"
 mblv$=mblv$+"12345"
 IF (mblv AND (2^13)) THEN mblv$=mblv$+"6"
 IF (mblv AND (2^11)) THEN mblv$=mblv$+"7"
 IF (mblv AND (2^14)) THEN mblv$=mblv$+"8"
 IF (mblv > (2^14)) THEN mblv$=mblv$+"9"
 uf$(9)=mblv$
 uf$(10)=xflv$
RETURN

ConvertDate:' Converts date from old DD MMM YY to MM-DD-YYYY
 mon$="JanFebMarAprMayJunJulAugSepOctNovDec"
 i$=uf$(11)
 IF INSTR(i$,"-")=0 THEN
  d$=LEFT$(i$,2)                         'day
  e$=MID$(i$,4,3)
  c$=RIGHT$(i$,2)                        'year
  b=INT(INSTR(mon$,e$)/3+1)
  e$=MID$(STR$(b),2)                     'month
  IF VAL(e$) < 10 THEN e$="0"+e$
  i$=e$+"-"+d$+"-"+c$
  uf$(11)=i$
 END IF
RETURN

SUB OpnUsrIn STATIC 'source userfile
 OPEN "USERFILE.DAT" FOR RANDOM AS #2 LEN=oldsize
END SUB

SUB OpnUsrOut STATIC 'target userfile
 OPEN "USERFILE.TMP" FOR RANDOM AS #4 LEN=newsize
END SUB

ErrHandler:
oops=ERR
RESUME NEXT

