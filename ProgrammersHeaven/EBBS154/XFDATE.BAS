'Convert DD MMM YY to MM-DD-YYYY date format
'Ed Parry
'930522
'Converts the DD MMM 93 format to DOS standard MM-DD-YYYY format

$CPU 8086

defint a-z

dim a$(10)

color 11,0

mon$="JanFebMarAprMayJunJulAugSepOctNovDec"
xp$="\XFER\XF "
xp=LEN(xp$)
CLS
PRINT
PRINT "EBBS-PC - Converts Xfer control file dates:"
PRINT
PRINT "From the old DD MMM YY format to the DOS MM-DD-YYYY format."
PRINT

MAIN:
 FOR xfer=65 to ASC("O")
  MID$(xp$,xp,1)=CHR$(xfer)
  PRINT "Section "xp$" : ";
  GOSUB OpnXfer
  records=LOF(2)\128

ReadRecord:
 FOR jj=1 to records
  GET #2,jj
  FOR i=1 to 6
   LINE INPUT#2,a$(i)
  NEXT i
  IF a$(1)>" " THEN
   i$=a$(3):GOSUB Datnum
   a$(3)=i$
   GOSUB WriteRecord
  END IF
 NEXT jj
 PRINT "Done!"
CLOSE #2

NEXT xfer
END

WriteRecord:
 GOSUB OpnXfer
 FOR ix=1 TO 6
  PRINT#2,a$(ix)
 NEXT
 PUT #2,jj
RETURN

DatNum:' Converts date from DD MMM YY to MM-DD-YYYY
 IF INSTR(i$,"-") =0 THEN
  d$=LEFT$(i$,2)                         'day
  e$=MID$(i$,4,3)
  c$=RIGHT$(i$,2)                        'year
  b=INT(INSTR(mon$,e$)\3+1)
  e$=MID$(STR$(b),2)                     'month
  IF VAL(e$) < 10 THEN e$="0"+e$
  i$=e$+"-"+d$+"-"+c$
 END IF
RETURN

OpnXfer:
 CLOSE #2:OPEN xp$+"\XFERFILE.DAT" FOR RANDOM AS #2 LEN=128
RETURN
