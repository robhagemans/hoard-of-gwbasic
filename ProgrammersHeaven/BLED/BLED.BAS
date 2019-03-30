DECLARE SUB WRITENEW (NEWOUT$, NWRITE%, SKIP.COMMENTS%)
DECLARE SUB GETCHAR (ROW%, COL%, PROMPT$, VLDANS$, RESULT$)
DECLARE SUB BRKWORDS (STRNG$, WORDS$(), NPARM%)
DECLARE SUB CREDITS ()
DECLARE SUB PRTHELP ()
DECLARE SUB EXPLAIN (STRNG$)
DECLARE SUB PRTSCRN (NUMFLDS%, ROW%(), COL%(), PROMPT$(), FLDSIZE%(), FLDTYPE$(), FLDVAL$(), HLP$())
DECLARE SUB GETSCRN (NUMFLDS%, ROW%(), COL%(), PROMPT$(), FLDSIZE%(), FLDTYPE$(), FLDVAL$(), HLP$())
DECLARE SUB WRMIS (EXPLN$, MISTAKE$)
DECLARE SUB FIRSTWORD (STRNG$, FIRST.WORD$, BS%)
DECLARE SUB CHKCONT (STRNG$, LINEON$, REMCHAR$, CONTINUED%)
DECLARE SUB NUMERIC (STRNG$, RESULT%)
DECLARE SUB GETTRANS (FILENO%, TRANS$, NTRANS%)
DECLARE SUB TRIM (STRNG$)
DECLARE SUB TRIMTRAIL (STRNG$)
DECLARE SUB CHKNARY (ELEMENT$, ARRAY$(), NUM.ENTRIES.TO.SEARCH%, IS.IN.ARA%, BEG%)
DECLARE SUB GETNXTCMD (FILENO%, CMD$, DOCCHAR$, STBLKTYPE$, ENDBLKTYPE$, STDES.NO%, ENDDES.NO%, STTARGET$, ENDTARGET$, INCREMENT%, PTR%, CMD.TYPE$, INS.BLKTYPE$, FIXED.NO%, BLK.DISP$)
DECLARE SUB FIRSTNB (STRNG$, BEG%, WHEREIS%)
DECLARE SUB CENTERBEG (STRNG$, LSIZE%, BEG%)
DECLARE SUB GETSTR (ROW%, COL%, PROMPT$, FLDSIZE%, RESULT$)
DECLARE SUB INQUOTES (STRNG$, BS%, INQUO%)
DECLARE SUB ENDNB (STRNG$, LST%)
DECLARE SUB WAITSECORKEY (SECONDS%)
DECLARE SUB READNXT (FILENO%, BUF$(), NUM.NBUF%, DOCCHAR$, CMD$)
DECLARE SUB PARSECMD (CMD$, STBLKTYPE$, ENDBLKTYPE$, STDES.NO%, ENDDES.NO%, STTARGET$, ENDTARGET$, INCREMENT%, PTR%, INCLUSIVE%, CMD.TYPE$, INS.BLKTYPE$, FIXED.NO%)
DECLARE SUB GETDISP (BUF$(), NUM.NBUF%, DOCCHAR$, BLK.DISP$, FILENO%)
DECLARE SUB LASTNB (STRNG$, BEG%, WHEREIS%)
DECLARE SUB ECHO (STRNG$, ROW%, COL%, FLDSIZE%)
DECLARE SUB GETNATNUM (ROW%, COL%, PROMPT$, FLDSIZE%, RESULT$)
DECLARE SUB CHKWRDS (BLKTYPE$, DES.NO%, TARGET$, NUWRD%, INCMT%, WRDS$(), BEG%, PTR%)
DECLARE SUB NOOTHER (STRNG$, ONLY$, RESULT%)
REM ****************************************************************
REM *         NOTICE:  DO NOT REMOVE THIS NOTICE                   *
REM *         BLED - (C) 1985-1993 by Ken Goosens                  *
REM *       5020 Portsmouth Road, Fairfax, VA 22032                *
REM ****************************************************************
REM 8 April 1986 enhanced to add comments to bled merge
REM 13 April 1986 fixed bug so could embed source code in comments
REM 1 June 1986 Added buffered output & increased default max lines
REM 25 Jan 1987 Support for preserving BLED and BLED SOURCE comments
REM 8 Mar 1987 Fixed 2 bugs concerning preserve option
REM 21 Mar 1987 Added beeps at end of a batch run
REM 27 Feb 1988 Correctly bug.  Reported size old file wrong
REM             Put 4th command parm in help
REM 20 Mar 1988 Enhanced to support metacommands
REM 6 June 1988 Support more METAVARIABLES and option to remove comments
REM *******************   DRIVER MODULE   **************************

DEFINT A-Z

NCNFG = 13
DIM CWRDS$(20), FROW(3), FCOL(3), FPROMPT$(3), FFLDSIZE(3), FFLDTYPE$(3)
DIM FFLDVAL$(3), FHLP$(3), CROW(NCNFG), CCOL(NCNFG), CPRO$(NCNFG)
DIM CFLDSIZE(NCNFG), CFLDTYPE$(NCNFG), CFLDVAL$(NCNFG), CHLP$(NCNFG)
DIM METANAME$(99), METAVAL$(99)          ' 06-06

GOSUB DOCMDLINE
GOSUB SETCONSTANTS
GOSUB GETCONFIG
LBLK = LEN(ENDBLK$)
TRANSBLK$ = SPACE$(LBLK)
OPEN "O", #4, WARNFILE$
MAXBTWLINES = VAL(MAXBTWLINES$)
REDIM MBUF$(MAXBTWLINES), TBUF$(MAXBTWLINES)
IF RUN.BATCH = 0 THEN GOSUB ASKMERGE

WHILE ANS$ <> "Q"
   X = INSTR(CMVAL$, ANS$)
   IF X > 1 THEN PRINT #4, "--[WARNINGS FOR FUNCTION "; ANS$; "]--"
   FILE.COMPARE = (ANS$ = "F")
   ON INSTR(CMVAL$, ANS$) GOSUB SETCONFIG, FILECOMPARE, DOLINEMERGE, DOMERGE
   NWRITE = -1
   CALL WRITENEW(X$, NWRITE,0)  ' 06-06
   CLOSE #3
   COLOR 7, 0
   ANS$ = "Q"
   IF RUN.BATCH = 0 THEN GOSUB ASKMERGE ELSE BEEP: BEEP: BEEP
WEND
CLOSE #4
LOCATE 24, 1: PRINT
      
END

REM  *********************    GOSUBS    **************************

ASKMERGE:

   LOCATE CMRO, 1
   PRINT SPACE$(79)
   CALL GETCHAR(CMRO, CMCO, CMPRO$, CMVAL$, ANS$)

RETURN

REM  ****              PREPATORY SUBROUTINES                  ****
REM  **********  DOCMDLINE, SETCONSTANTS, GETCONFIG **************

REM -----------------------[ DOCMDLINE ]------------------------------------------------

DOCMDLINE:

REM PROCESSES COMMAND LINE ARGUMENTS FROM DOS

  RUN.BATCH = INSTR(COMMAND$, "/B")
  LINE.MERGE = INSTR(COMMAND$, "/L")
  REG.MERGE = INSTR(COMMAND$, "/M")
  FILE.COMPARE = INSTR(COMMAND$, "/F")
  REMOVE.COMMENTS = INSTR(COMMAND$,"/RC")   ' 06-06

  IF (LINE.MERGE OR REG.MERGE OR FILE.COMPARE) THEN
     IF (LINE.MERGE AND REG.MERGE) OR (LINE.MERGE AND FILE.COMPARE) OR (REG.MERGE AND FILE.COMPARE) THEN
        X$ = "Can not use more than one of /F /L /M."
        GOSUB DOABORT
     END IF
  END IF
  IF REG.MERGE THEN ANS$ = "M" ELSE IF LINE.MERGE THEN ANS$ = "L" ELSE IF FILE.COMPARE THEN ANS$ = "F" ELSE ANS$ = ""
  IF RUN.BATCH AND ANS$ = "" THEN X$ = "Must specify one of /F /L /M to run batch.": GOSUB DOABORT
  CALL BRKWORDS(COMMAND$, CWRDS$(), I)
  NON.OPT = 1
  WHILE INSTR(CWRDS$(NON.OPT), "/") > 0
    NON.OPT = NON.OPT + 1
  WEND
  IF RUN.BATCH AND CWRDS$(NON.OPT + 2) = "" THEN
     X$ = "Must specify all three file arguments to run batch."
     GOSUB DOABORT
  END IF
  IF COMMAND$ = "" THEN CALL CREDITS

  IF CWRDS$(NON.OPT + 4) <> "" THEN CONFIGFILE$ = CWRDS$(NON.OPT + 4) ELSE CONFIGFILE$ = "BLED.CFG"
  IF CWRDS$(NON.OPT + 3) <> "" THEN WARNFILE$ = CWRDS$(NON.OPT + 3) ELSE WARNFILE$ = ""
  IF CWRDS$(NON.OPT + 2) <> "" THEN NEWFILE$ = CWRDS$(NON.OPT + 2) ELSE NEWFILE$ = "SC"
  IF CWRDS$(NON.OPT + 1) <> "" THEN BTCHCMDS$ = CWRDS$(NON.OPT + 1) ELSE BTCHCMDS$ = "SC"
  IF CWRDS$(NON.OPT) <> "" THEN ORIGFILE$ = CWRDS$(NON.OPT) ELSE ORIGFILE$ = "SC"

  LIMIT.RUN = INSTR(COMMAND$, "/T=")
  IF LIMIT.RUN = 0 THEN RETURN
  LIMIT.RUN = LIMIT.RUN + 1
  LAST.CHAR = INSTR(LIMIT.RUN, COMMAND$, "/")
  IF LAST.CHAR = 0 THEN LAST.CHAR = INSTR(LIMIT.RUN, COMMAND$, " ")
  IF LAST.CHAR = 0 THEN LAST.CHAR = LEN(COMMAND$) + 1
  MAX.LL = VAL(MID$(COMMAND$, LIMIT.RUN + 2, LAST.CHAR - LIMIT.RUN - 2))
REM  PRINT "MAX.LL=";MAX.LL;" GOT FROM ";COMMAND$;" starting at ";LIMIT.RUN+2;_
REM    " and grabbing ";LAST.CHAR-LIMIT.RUN-2;" chars"
REM   PRINT "Last char=";last.char: input xx$
RETURN

DOABORT:

REM PREMATURELY TERMINATE WITH CENTERED ERROR MESSAGE AND HELP

  BEEP
  X = LEN(X$) + 17
  IF X < 78 THEN K = (78 - X) / 2 ELSE K = 0
  PRINT SPACE$(K); X$; "  Aborting."
  CALL PRTHELP
  END

RETURN

REM --------------------------[ SETCONSTANTS ]-----------------------------

SETCONSTANTS:

REM ASSIGNS CONSTANTS USED IN PROGRAM

  HI.VALUE# = 99999999
  ONE = 1
  TWO = 2
  SEVENTYTWO = 72

  INSERTING$ = "* INSERTING new line(s)"
  DELETING$ = "* DELETING old line(s)"
  REPLACING$ = "* REPLACING old line(s) by new"
  FIRSTDIF$ = "* ------[ first line different ]------"

  CMPRO$ = "C)onfigure, F)ile compare, L)ine# merge, M)erge, Q)uit (C,F,L,M,Q): "
  CMRO = 21
  CMCO = 4
  CMVAL$ = "CFLMQ"

  EDPRO$ = "E)dit, R)un, Q)uit (E,R,Q): "
  EDRO = 23
  EDCO = 18
  EDVAL$ = "ERQ"

  CFRO = 23
  CFCO = 20
  CFPRO$ = "E)dit, S)ave, Q)uit (E,S,Q): "
  CFVAL$ = "ESQ"

  THREE = 3
  FOUR = 4
  FROW(1) = 7
  FROW(2) = 9
  FROW(3) = 11
  FCOL(1) = 10
  FCOL(2) = 10
  FCOL(3) = 10
  FFLDSIZE(1) = 40
  FFLDSIZE(2) = 40
  FFLDSIZE(3) = 40
  FFLDTYPE$(1) = "S"
  FFLDTYPE$(2) = "S"
  FFLDTYPE$(3) = "S"
  IN.MERGE = -1
  METAROW = 13                   ' 03-20
  M1COL = 5                      ' 03-20
  METACOL = 24                   ' 03-20
  METACMND$ = "$"                ' 03-20

  FOR I = 1 TO NCNFG
    READ CROW(I), CCOL(I), CPRO$(I), CFLDSIZE(I), CFLDTYPE$(I), CFLDVAL$(I), CHLP$(I)
  NEXT

DATA  01,18,"BATCH LINE EDITOR - CONFIGURATION   Ver 2.2",00,L,   ,
DATA  03,12,"Source EXTENSION:"                  ,03,S,BAS,"Default extension for source file to be edited (e.g. BAS)"
DATA  04,12,"Merge EXTENSION:"                   ,03,S,MRG,"Default extension for file of changes to source (e.g. MRG)"
DATA  05,12,"Source remarks begin with:"         ,03,S,"'","Logically ignore rest of physical line beyond this"
DATA  06,12,"END OF BLOCK Phrase:"               ,20,S,ENDBLOCK,"Phrase used in BLED for the end of a block"
DATA  07,12,"Documentation BEGINS with: "        ,01,S,*  ,"Character that documentation lines begin with in BLED merge file"
DATA  08,12,"Alphanumeric LABELS END with:"      ,01,S,":","Character on end of an alphanumeric label (e.g. ':' in 'GETOUT:')"
DATA  09,12,"BLED COMMANDS BEGIN with:"          ,01,S,   ,"Character starting BLED commands in merge file (default none)"
DATA  10,12,"IGNORE CASE in Labels?"             ,01,S,Y  ,"Lower/upper case are same in labels (e.g. 'LABEL1' and 'label1')"
DATA  11,12,"CONTINUED LINES END with:"          ,01,S,_  ,"Character used to continue logical line onto next line"
DATA  12,12,"Write WARNINGS to:"                 ,30,S,WARNING,"File to write warning messages to"
DATA  13,12,"Max # physical lines btw line #'s:" ,04,N,400,"In file compare, max # physical lines between two line numbers"
DATA  14,12,"Preserve BLED comments (Y/N):"      ,01,S,Y  ,"Convert BLED comments to/from source BLED comments"
RETURN

REM -------------------------[ GETCONFIG ]---------------------------------

GETCONFIG:

REM   GETS CONFIGURATION PARAMETERS

   ON ERROR GOTO NOCONFIG
   OPEN "I", #1, CONFIGFILE$

READIN:
     ON ERROR GOTO 0
     LINE INPUT #1, DESOURCE$
     LINE INPUT #1, DEMERGES$
     LINE INPUT #1, REMCHAR$
     LINE INPUT #1, ENDBLK$
     LINE INPUT #1, DOCCHAR$
     LINE INPUT #1, END.LABEL$
     LINE INPUT #1, BLEDCMD$
     LINE INPUT #1, IGNORECASE$
     LINE INPUT #1, LINEON$
     LINE INPUT #1, X$
     IF WARNFILE$ = "" THEN WARNFILE$ = X$
     LINE INPUT #1, MAXBTWLINES$
     LINE INPUT #1, X$
     PRESERVE.COMMENTS = (LEFT$(X$, 1) <> "N")
     BLED.SOURCE.COMMENT$ = REMCHAR$ + "<" + DOCCHAR$ + ">"
     CLOSE #1
     METALINE$ = DOCCHAR$ + METACMND$      ' 03-20
   RETURN

USEDEFAULTS:
     ON ERROR GOTO 0
     DESOURCE$ = "BAS"
     DEMERGES$ = "MRG"
     REMCHAR$ = "'"
     ENDBLK$ = "ENDBLOCK"
     DOCCHAR$ = "*"
     END.LABEL$ = ":"
     BLEDCMD$ = ""
     IGNORECASE$ = "Y"
     LINEON$ = "_"
     IF WARNFILE$ = "" THEN WARNFILE$ = "WARNING"
     MAXBTWLINES$ = "400"
     PRESERVE.COMMENTS = 0
     METALINE$ = DOCCHAR$ + METACMND$      ' 03-20
   RETURN

NOCONFIG:
   X$ = "Config file " + CONFIGFILE$ + " missing/bad.  Using QuickBASIC defaults."
   CALL EXPLAIN(X$)
   RESUME USEDEFAULTS

REM -----------------------------------------------------------------------

REM *****                MAIN   ROUTINES                       ****
REM **********  SETCONFIG,FILECOMPARE,DOLINEMERGE,DOMERGE      ****

REM -----------------------[ SETCONFIG ]-----------------------------------

SETCONFIG:

REM      ALLOWS USER TO RECONFIGURE

   CFLDVAL$(2) = DESOURCE$
   CFLDVAL$(3) = DEMERGES$
   CFLDVAL$(4) = REMCHAR$
   CFLDVAL$(5) = ENDBLK$
   CFLDVAL$(6) = DOCCHAR$
   CFLDVAL$(7) = END.LABEL$
   CFLDVAL$(8) = BLEDCMD$
   CFLDVAL$(9) = IGNORECASE$
   CFLDVAL$(10) = LINEON$
   CFLDVAL$(11) = WARNFILE$
   OLDWARN$ = WARNFILE$
   CFLDVAL$(12) = MAXBTWLINES$
   CFLDVAL$(13) = MID$("NY", 1 - PRESERVE.COMMENTS, 1)

   CALL PRTSCRN(NCNFG, CROW(), CCOL(), CPRO$(), CFLDSIZE(), CFLDTYPE$(), CFLDVAL$(), CHLP$())
   CO = 1: CALL QPRINT(SPACE$(79), FRO, CO)
RESETCNFG:
     ANS$ = "E"
     CALL GETCHAR(CFRO, CFCO, CFPRO$, CFVAL$, ANS$)
     WHILE ANS$ = "E"
       CALL GETSCRN(NCNFG, CROW(), CCOL(), CPRO$(), CFLDSIZE(), CFLDTYPE$(), CFLDVAL$(), CHLP$())
       LOCATE CFRO, 1: PRINT SPACE$(79)
       ANS$ = "": CALL GETCHAR(CFRO, CFCO, CFPRO$, CFVAL$, ANS$)
     WEND

 DESOURCE$ = CFLDVAL$(2)
 BTCHCMDS$ = CFLDVAL$(3)
 REMCHAR$ = CFLDVAL$(4)
 ENDBLK$ = CFLDVAL$(5)
 DOCCHAR$ = CFLDVAL$(6)
 END.LABEL$ = CFLDVAL$(7)
 BLEDCMD$ = CFLDVAL$(8)
 IGNORECASE$ = CFLDVAL$(9)
 LINEON$ = CFLDVAL$(10)
 WARNFILE$ = CFLDVAL$(11)
 MAXBTWLINES$ = CFLDVAL$(12)
 PRESERVE.COMMENTS = (LEFT$(CFLDVAL$(13), 1) <> "N")
 BLED.SOURCE.COMMENT$ = REMCHAR$ + "<" + DOCCHAR$ + ">"
 IF WARNFILE$ <> OLDWARN$ THEN CLOSE #4: OPEN "O", #4, WARNFILE$
 IF ANS$ = "Q" THEN RETURN
 IF ANS$ <> "S" THEN RETURN
     OPEN "O", #1, CONFIGFILE$
     FOR I = 1 TO NCNFG
       IF CFLDTYPE$(I) <> "L" THEN PRINT #1, CFLDVAL$(I)
     NEXT
     CLOSE #1
     GOTO RESETCNFG

RETURN

REM -----------------------[ FILECOMPARE ]---------------------------------

FILECOMPARE:

REM     COMPARES TWO FILES, PRODUCES MERGE FILE FOR LINE MERGING

  IN.MERGE = 0
  FPROMPT$(1) = "OLD Version:"
  FPROMPT$(2) = "NEW Version:"
  FPROMPT$(3) = "MERGES (to OLD to make NEW):"
  FHLP$(1) = "Old version of file that has been changed"
  FHLP$(2) = "New, modified version of file"
  FHLP$(3) = "Create file of changes to old version needed to make new version"
  TOPTITLE$ = "COMPARING FILES - Generating Merge"
  GOSUB GETFILES
  IF FANS$ = "Q" THEN RETURN

   HEADER$ = DOCCHAR$ + " ------------[ BLED merge (c) Ken Goosens ]-------------"
   CALL WRITENEW(HEADER$, NWRITE,O) '06-06
   HEADER$ = DOCCHAR$ + " Merge this against " + ORIGFILE$ + " to produce " + BTCHCMDS$
   CALL WRITENEW(HEADER$, NWRITE,0) ' 06-06
   CALL GETFDATE(ORIGFILE$ + CHR$(0), MM, DD, YY)
   FDATE$ = MID$(STR$(MM), 2) + "-" + MID$(STR$(DD), 2) + "-" + MID$(STR$(YY), 2)
   FSIZE$ = MID$(STR$(LOF(1)), 2) + " bytes"                 ' 02-27-88
   HEADER$ = DOCCHAR$ + " " + ORIGFILE$ + ":  Date " + FDATE$ + "  Size " + FSIZE$
   CALL WRITENEW(HEADER$, NWRITE,0) ' 06-06
   HEADER$ = DOCCHAR$ + " ------------[ Created " + DATE$ + " " + TIME$ + " ]------------"
   CALL WRITENEW(HEADER$, NWRITE, 0) ' 06-06

   TRANS# = 0
   MAST# = 0
   GOSUB READLINETRANS
   GOSUB READLINEOLD
   WHILE MAST# < HI.VALUE# OR TRANS# < HI.VALUE#
      IF TRANS# < MAST# THEN
         CALL WRITENEW(INSERTING$, NWRITE, 0) ' 06-06
         WHILE TRANS# < MAST#
            GOSUB COMPARENUTRANS
            CALL WRITENEW(NUTRANS$, NWRITE, REMOVE.COMMENTS) ' 06-06
            GOSUB READLINETRANS
         WEND
      END IF
      IF MAST# < TRANS# THEN
         CALL WRITENEW(DELETING$, NWRITE,0) ' 06-06
         WHILE MAST# < TRANS#
            PREV# = MAST#
            FW$ = MID$(STR$(MAST#), 2)
            CALL WRITENEW(FW$, NWRITE, 0)  ' 06-06
            WHILE PREV# = MAST#
               GOSUB READLINEOLD
            WEND
         WEND
      END IF
      IF TRANS# = MAST# AND MAST# < HI.VALUE# THEN
         PREV# = TRANS#
         J = 0
         WHILE PREV# = TRANS# AND J < MAXBTWLINES
            J = J + 1
            TBUF$(J) = NUTRANS$
            GOSUB READLINETRANS
         WEND
         I = 0
         WHILE PREV# = MAST# AND I < MAXBTWLINES: I = I + 1
            MBUF$(I) = TRANS$
            GOSUB READLINEOLD
         WEND
         GOSUB CHKEXCEED
         IF M$ <> "" THEN
            N$ = "Logical line exceeds maximum physical lines.  Reconfigure"
            CALL WRMIS(M$, N$)
         ELSE
            GOSUB CHKDIF
            IF ARE.DIFF THEN
               CALL WRITENEW(REPLACING$, NWRITE, 0) ' 06-06
               GOSUB COMPARETBUF
               FOR I = 1 TO K - 1
                  CALL WRITENEW(TBUF$(I), NWRITE, REMOVE.COMMENTS) ' 06-06
               NEXT
               GOSUB WRITEDIF
               FOR I = K TO MAX
                  CALL WRITENEW(TBUF$(I), NWRITE, REMOVE.COMMENTS) ' 06-06
               NEXT
               FOR I = MAX + 1 TO MAXMAX
                  CALL WRITENEW(TBUF$(I), NWRITE, REMOVE.COMMENTS) ' 06-06
               NEXT
            END IF
         END IF
      END IF
   WEND
   CLOSE #1, #2
   IN.MERGE = -1

RETURN

WRITEDIF:

   IF MAXMAX > 1 THEN CALL WRITENEW(FIRSTDIF$, NWRITE, 0)  ' 06-06

   RETURN

CHKEXCEED:

   M$ = ""
   IF I = UBOUND(MBUF$) THEN M$ = "[File " + ORIGFILE$ + "]" ELSE IF J = UBOUND(TBUF$) THEN M$ = "[File " + BTCHCMDS$ + "]"

RETURN

CHKDIF:

IF I = J THEN ARE.DIFF = 0 ELSE ARE.DIFF = -1
IF I <= J THEN MAX = I ELSE MAX = J
MAXMAX = J
K = 0
CHKAG:
  K = K + 1
  IF K <= MAX THEN
     IF TBUF$(K) = MBUF$(K) THEN
        GOTO CHKAG
     ELSE
        ARE.DIFF = -1
     END IF
  END IF
GETOUTCHKDIF:

RETURN

COMPARENUTRANS:

   IF NOT PRESERVE.COMMENTS THEN RETURN
   CALL FIRSTWORD(NUTRANS$, FW$, BEGIN.AT)
   IF LEFT$(FW$, 4) = BLED.SOURCE.COMMENT$ THEN
      NUTRANS$ = LEFT$(NUTRANS$, BEGIN.AT - 1) + DOCCHAR$ + RIGHT$(NUTRANS$, LEN(NUTRANS$) - BEGIN.AT - 3)
   END IF
RETURN

COMPARETBUF:

   IF NOT PRESERVE.COMMENTS THEN RETURN
   FOR I = 1 TO MAXMAX
     CALL FIRSTWORD(TBUF$(I), FW$, BEGIN.AT)
     IF LEFT$(FW$, 4) = BLED.SOURCE.COMMENT$ THEN
        TBUF$(I) = LEFT$(TBUF$(I), BEGIN.AT - 1) + DOCCHAR$ + RIGHT$(TBUF$(I), LEN(TBUF$(I)) - BEGIN.AT - 3)
     END IF
   NEXT
     
RETURN

REM -----------------------[ DOLINEMERGE ]---------------------------------

DOLINEMERGE:

REM               MERGES BASED ON LINE NUMBER LABELS

  TOPTITLE$ = "MERGING using Line Number Labels"
  GOSUB STANDARDFILES
  IF FANS$ = "Q" THEN RETURN
  LOCATE METAROW, M1COL
  COLOR 7, 0
  PRINT "LAST Metacommand: ";            ' 03-20
  COLOR 0, 7
  METACOL = POS(0)                       ' 03-20


   TRANS# = 0
   MAST# = 0
   GOSUB READLINETRANS
   GOSUB READLINEOLD
   WHILE TRANS# < HI.VALUE# OR MAST# < HI.VALUE#
      WHILE TRANS# < MAST# AND J < MAXBTWLINES
        PREV# = TRANS#
        J = 0
        WHILE PREV# = TRANS#
         IF ONLY.LINENO THEN
            M$ = TRANS$
            N$ = "Line number to be deleted not found."
            CALL WRMIS(M$, N$)
         ELSE
            J = J + 1
            TBUF$(J) = NUTRANS$
         END IF
         GOSUB READLINETRANS
       WEND
        FOR I = 1 TO J: CALL WRITENEW(TBUF$(I), NWRITE, REMOVE.COMMENTS): NEXT '06-06
      WEND
      WHILE MAST# < TRANS#
         PREV# = MAST#
         WHILE PREV# = MAST#
           CALL WRITENEW(TRANS$, NWRITE, REMOVE.COMMENTS) ' 06-06
           GOSUB READLINEOLD
         WEND
      WEND
      IF TRANS# = MAST# AND MAST# < HI.VALUE# THEN
         PREV# = TRANS#
         J = 0
         WHILE PREV# = TRANS# AND J < MAXBTWLINES
            GOSUB CHKWRITE
            GOSUB READLINETRANS
         WEND
         FOR I = 1 TO J
            CALL WRITENEW(TBUF$(I), NWRITE, REMOVE.COMMENTS) ' 06-06
         NEXT
         WHILE PREV# = MAST#
            GOSUB READLINEOLD
         WEND
      END IF
   WEND
   CLOSE #1, #2

RETURN

CHKWRITE:

IF NOT ONLY.LINENO THEN J = J + 1: TBUF$(J) = NUTRANS$

RETURN

READLINEOLD:

   IF EOF(1) THEN
      MAST# = HI.VALUE#
   ELSE
      GOSUB READOLDREC
      CALL FIRSTWORD(TRANS$, FW$, BEGIN.AT)
      IF FW$ = "" THEN
         PREV.MAST = 0
         RETURN
      ELSE
         CONTINUED.MAST = PREV.MAST
         CALL CHKCONT(TRANS$, LINEON$, REMCHAR$, PREV.MAST)
         IF CONTINUED.MAST = 0 THEN
            CALL NUMERIC(FW$, NATNO)
            IF NATNO OR (VAL(FW$)>0 AND RIGHT$(FW$,1)=END.LABEL$) THEN
               PREV# = MAST#
               MAST# = VAL(FW$)
               IF MAST# <= PREV# THEN
                  N$ = "Source line " + FW$ + " occurs after line#" + STR$(PREV#)
                  CALL WRMIS(TRANS$, N$)
               ELSE
                  LOG.LINES = LOG.LINES + 1
                  IF MAX.LL > 0 THEN
                     IF LOG.LINES > MAX.LL THEN
                        COLOR 7, 0
                        PRINT
                        PRINT "              Sample MERGE created from "; MAX.LL; " lines"
                        END
                     END IF
                  END IF
               END IF
            END IF
         END IF
      END IF
   END IF
REM IF (MAST# >= 9000 AND MAST# <= 9600) THEN_
REM   X$="mast-out="+STR$(mast#)+" continued="+STR$(continued.mast)+" curr cont="+STR$(prev.mast)+" numeric="+STR$(natno):_
REM    Y$="":CALL WRMIS (X$,Y$)
RETURN

READLINETRANS:

    ONLY.LINENO = 0
    IF EOF(FILENO%) THEN
       IF FILENO% = 2 THEN
          TRANS# = HI.VALUE#
       ELSE
          CLOSE 5
          FILENO% = 2
          GOTO READLINETRANS
       END IF
    ELSE
       CALL GETTRANS(FILENO%, NUTRANS$, NTRANS)
       CALL FIRSTWORD(NUTRANS$, FW$, BEGIN.AT)
       IF FW$ = "" THEN
          PREV.CONT = 0
          RETURN
       ELSE
          IF (LEFT$(FW$, 1) = DOCCHAR$ AND IN.MERGE) THEN
             GOSUB CHKMETA
             GOSUB CHKPRESERVE
             GOTO READLINETRANS
          ELSE
             CONTINUED.LINE = PREV.CONT
             CALL CHKCONT(NUTRANS$, LINEON$, REMCHAR$, PREV.CONT)
             IF CONTINUED.LINE = 0 THEN
                CALL NUMERIC(FW$, NATNO)
                IF NATNO OR (VAL(FW$)>0 AND RIGHT$(FW$,1)=END.LABEL$) THEN
                   PREV# = TRANS#
                   TRANS# = VAL(FW$)
                   IF TRANS# <= PREV# THEN
                      N$ = "Merge line# " + FW$ + " occurs after line#" + STR$(PREV#)
                      CALL WRMIS(NUTRANS$, N$)
                   ELSE
                      X$ = NUTRANS$
                      CALL TRIM(X$)
                      IF X$ = FW$ THEN
                         ONLY.LINENO = -1
                      END IF
                   END IF
                END IF
             END IF
          END IF
       END IF
    END IF
RETURN

CHKMETA:
   IF FW$ <> METALINE$ THEN RETURN
   CALL UPCASE(NUTRANS$)
   CALL BRKWORDS(NUTRANS$, CWRDS$(), NWORDS)
   START.WORD = 2
DOMETA:
   VALID.META = 0
   IF CWRDS$(START.WORD) = "SET" THEN
      IF START.WORD + 3 > NWORDS OR CWRDS$(START.WORD + 2) <> "=" OR CWRDS$(START.WORD + 3) = "" THEN
         CALL WRMIS(NUTRANS$, "SET without '=' or missing value")
         RETURN
      ELSE
         VALID.META = -1
         X$ = "SET " + CWRDS$(START.WORD + 1) + " " + CWRDS$(START.WORD + 2) + " " + CWRDS$(START.WORD + 3)
         GOSUB PRINTLAST
         CALL CHKNARY(CWRDS$(START.WORD + 1), METANAME$(), NMETA, FOUND, 1)
         IF FOUND = 0 THEN
           IF NMETA < UBOUND(METANAME$) THEN
              NMETA = NMETA + 1
              FOUND = NMETA
              METANAME$(NMETA) = CWRDS$(START.WORD + 1)
           END IF
         END IF
         METAVAL$(NMETA) = CWRDS$(START.WORD + 3)
         RETURN
      END IF
   END IF
   IF CWRDS$(START.WORD) = "INCLUDE" THEN
      VALID.META = -1
      IF START.WORD + 1 > NWORDS OR CWRDS$(START.WORD + 1) = "" THEN
         CALL WRMIS(NUTRANS$, "INCLUDE with no file specified")
         RETURN
      ELSE
         CALL EXIST(CWRDS$(START.WORD + 1) + CHR$(0), FOUND)
         IF FOUND = 0 THEN
            X$ = "Include file <" + CWRDS$(START.WORD + 1) + "> missing"
            CALL WRMIS(NUTRANS$, X$)
            RETURN
         END IF
         FILENO% = 5
         OPEN CWRDS$(START.WORD + 1) FOR INPUT AS #5
         X$ = "INCLUDE " + CWRDS$(START.WORD + 1)
         GOSUB PRINTLAST
         RETURN READLINETRANS
      END IF
   END IF
   IF CWRDS$(START.WORD) = "IF" THEN
      IF START.WORD + 4 > NWORDS OR CWRDS$(START.WORD + 4) <> "THEN" THEN
         CALL WRMIS(NUTRANS$, "IF without THEN")
         RETURN
      ELSE
         X$ = LEFT$(MID$(NUTRANS$,INSTR(NUTRANS$,"IF")),50)
         GOSUB PRINTLAST
         VALID.META = -1
         CALL CHKNARY(CWRDS$(START.WORD + 1), METANAME$(), NMETA, FOUND, 1)
         IF FOUND < 1 THEN
            CALL WRMIS(NUTRANS$, "IF has undefined metavariable <" + CWRDS$(START.WORD + 1) + ">")
            RETURN
         ELSE
            IF CWRDS$(START.WORD + 3) = "" THEN
               CALL WRMIS("IF lacks comparison value", NUTRANS$)
               RETURN
            ELSE
               ANTECEDENT = (METAVAL$(FOUND) = CWRDS$(START.WORD + 3))
            END IF
         END IF
         IF CWRDS$(START.WORD + 5) = "BLOCK" THEN IN.BLOCK = -1
         IF ANTECEDENT THEN
            IF IN.BLOCK THEN
               RETURN
            ELSE
               START.WORD = START.WORD + 5
               GOTO DOMETA
            END IF
         ELSE
            IF IN.BLOCK THEN
               OPTIONAL.END$ = "ELSE"
               GOSUB SKIPBLOCK
            ELSE
               CALL CHKNARY("ELSE", CWRDS$(), NWORDS, FOUND, START.WORD + 6)
               IF FOUND > 0 AND START.WORD + 5 < NWORDS THEN
                  START.WORD = FOUND + 1
                  GOTO DOMETA
               ELSE
                  'CALL WRMIS(NUTRANS$, "Warning: IF without matching ELSE")
                  RETURN
               END IF
            END IF
         END IF
      END IF
      RETURN
   END IF
   IF CWRDS$(START.WORD) = "ELSE" THEN
      IF NOT IN.BLOCK THEN
         CALL WRMIS (NUTRANS$,"ELSE not within BLOCK")
      ELSE
         VALID.META = -1
         X$ = "ELSE"
         GOSUB PRINTLAST
         IF ANTECEDENT THEN
            OPTIONAL.END$ = CHR$(26)
            GOSUB SKIPBLOCK
         END IF
      END IF
      RETURN
   END IF
   IF CWRDS$(START.WORD) = "END" THEN
      IF NOT IN.BLOCK THEN
         CALL WRMIS(NUTRANS$,"END IF with no IF BLOCK")
      ELSE
         X$ = "END IF"
         GOSUB PRINTLAST 
         IN.BLOCK = 0
      END IF
      RETURN
   END IF
   CALL WRMIS(NUTRANS$, "Unknown meta command")
   RETURN

PRINTLAST:
'print "metacol,mrow=";metacol,mrow:input xx$
   CALL QPRINT(SPACE$(79 - METACOL), METAROW, METACOL)
   CALL QPRINT(X$, METAROW, METACOL)
   RETURN

SKIPBLOCK:  ' Skips lines until end of block encountered
   GOTENDIF = EOF(FILENO%)
   WHILE NOT GOTENDIF
      CALL GETTRANS (FILENO%,NUTRANS$,NTRANS)
      CALL UPCASE (NUTRANS$)
      CALL BRKWORDS (NUTRANS$,CWRDS$(),I)
      IF (I > 1 AND CWRDS$(1) = METALINE$ AND _
         (CWRDS$(2) = "END" OR CWRDS$(2) = OPTIONAL.END$ OR CWRDS$(2) = ENDBLK$)) THEN
            GOTENDIF = -1
      ELSE
         IF EOF(FILENO%) THEN
            GOTENDIF = -1
            CALL WRMIS(NUTRANS$,"BLOCK IF-THEN-ELSE with no END IF")
         END IF
      END IF
   WEND
   IF CWRDS$(2) = "END" THEN IN.BLOCK = 0
RETURN
           
CHKPRESERVE:
REM print "chkpreserve: preserve?=";preserve.comments
  IF NOT PRESERVE.COMMENTS THEN RETURN
  IF INSTR(NUTRANS$, "-[ first") > 0 THEN RETURN
'print "<";nutrans$;">"
'print "cont? line=";continued.line;" prev=";prev.cont:input xx$
  NUTRANS$ = LEFT$(NUTRANS$, BEGIN.AT - 1) + BLED.SOURCE.COMMENT$ + RIGHT$(NUTRANS$, LEN(NUTRANS$) - BEGIN.AT)
  IF PREV.CONT = -1 THEN CALL WRITENEW(NUTRANS$, NWRITE, REMOVE.COMMENTS) ELSE RETURN EXIT2LEVELS ' 06-06
REM print "<";nutrans$;">"

RETURN
EXIT2LEVELS:
   RETURN

REM -----------------------[ DOMERGE ]-------------------------------------

DOMERGE:

REM        GENERAL BLED MERGE BASED ON BLOCK and BLOCK DISPOSITION

  TOPTITLE$ = "MERGING - General BLED"
  GOSUB STANDARDFILES
  IF FANS$ = "Q" THEN RETURN
  
  CALL GETNXTCMD(FILENO%, CMD$, DOCCHAR$, STBLKTYPE$, ENDBLKTYPE$, STDES.NO%, ENDDES.NO%, STTARGET$, ENDTARGET$, INCREMENT%, PTR%, CMD.TYPE$, INS.BLKTYPE$, FIXED.NO%, BLK.DISP$)
  
  WHILE CMD.TYPE$ <> ""
REM     PRINT "domerge: CMD$=";CMD$;" TYPE=";CMD.TYPE$;" INS BLKTYPE=";INS.BLKTYPE$
     IF CMD.TYPE$ = "I" THEN IF INS.BLKTYPE$ = "L" THEN GOSUB WRNTIMES ELSE GOSUB WRTBLOCK ELSE LINE.DISP$ = "K":                                                       PTR.INCREMENT% = 1:        TARGET$ = STTARGET$:        BLOCK.TYPE$ = STBLKTYPE$: _
            DESIRED.PTR = STDES.NO%: GOSUB ADVANCE: LINE.DISP$ = BLK.DISP$:  BLOCK.TYPE$ = ENDBLKTYPE$:        DESIRED.PTR = ENDDES.NO%:        TARGET$ = ENDTARGET$:        PTR.INCREMENT% = INCREMENT%:        GOSUB ADVANCE
     CALL GETNXTCMD(FILENO%, CMD$, DOCCHAR$, STBLKTYPE$, ENDBLKTYPE$, STDES.NO%, ENDDES.NO%, STTARGET$, ENDTARGET$, INCREMENT%, PTR%, CMD.TYPE$, INS.BLKTYPE$, FIXED.NO%, BLK.DISP$)

  WEND
  CLOSE #1, #2
  
RETURN

ADVANCE:
      REM DECIDES HOW TO ADVANCE THROUGH OLD FILE
      REM PASS BLOCK.TYPE$

      IF BLOCK.TYPE$ = "L" THEN GOSUB READTOLINE ELSE IF BLOCK.TYPE$ = "S" THEN GOSUB READTOSTRING ELSE IF BLOCK.TYPE$ = "LABEL" OR BLOCK.TYPE$ = "LABEL#" THEN GOSUB READTOLABEL ELSE M$ = "WARNING: ILLEGAL BLOCK TYPE ": _
                                                             W$ = BLOCK.TYPE$: CALL WRMIS(M$, W$)
RETURN
         
READTOLINE:

   REM READS UPTO LINE DESIRED.PTR IN OLD

   WHILE PTR% < DESIRED.PTR AND NOT EOF(1)
      GOSUB READOLD
      PTR% = PTR% + PTR.INCREMENT%
      IF LINE.DISP$ = "K" THEN CALL WRITENEW(TRANS$, NWRITE, REMOVE.COMMENTS) ' 06-06
   WEND
RETURN

READTOSTRING:

   REM READS UPTO A STRING IN OLD

   TRANS$ = TARGET$
   IF NOT EOF(1) THEN GOSUB READOLD
   WHILE INSTR(TRANS$, TARGET$) = 0
      PTR% = PTR% + 1
      IF LINE.DISP$ = "K" THEN CALL WRITENEW(TRANS$, NWRITE, REMOVE.COMMENTS) ' 06-06
      IF NOT EOF(1) THEN GOSUB READOLD ELSE M$ = "WARNING: STRING " + TARGET$ + " NOT FOUND":                          W$ = "":         CALL WRMIS(M$, W$):         TRANS$ = TARGET$
   WEND
   PREV.OLD$ = TRANS$

RETURN

READTOLABEL:

   REM READS UPTO A LABEL IN OLD
 
   IF IGNORECASE THEN CALL UPCASE(TARGET$)
   IF BLOCK.TYPE$ = "LABEL" AND RIGHT$(TARGET$, 1) <> END.LABEL$ THEN TARGET$ = TARGET$ + END.LABEL$
   IF NOT EOF(1) THEN GOSUB READOLD:           GOSUB GETFIRSTWORD ELSE FIRST.WORD$ = TARGET$:             TRANS$ = ""
   WHILE FIRST.WORD$ <> TARGET$
      PTR% = PTR% + 1
      IF LINE.DISP$ = "K" THEN CALL WRITENEW(TRANS$, NWRITE, REMOVE.COMMENTS) ' 06-06
      IF NOT EOF(1) THEN GOSUB READOLD:                 GOSUB GETFIRSTWORD ELSE M$ = "WARNING: LABEL " + TARGET$ + " NOT FOUND":                  W$ = "":         CALL WRMIS(M$, W$):         FIRST.WORD$ = TARGET$
   WEND
   PREV.OLD$ = TRANS$

RETURN

GETFIRSTWORD:

   CALL FIRSTWORD(TRANS$, FIRST.WORD$, BEGIN.AT)
   IF IGNORECASE THEN CALL UPCASE(FIRST.WORD$)

RETURN

READOLD:

   REM FETCHES NEXT UNPROCESSED RECORD FROM OLD

   IF PTR% <= NREAD THEN TRANS$ = PREV.OLD$ ELSE GOSUB READOLDREC

RETURN

READOLDREC:

   LINE INPUT #1, TRANS$
   NREAD = NREAD + 1
   LOCATE MROW, MCOL: PRINT NREAD;

RETURN

WRNTIMES:
   REM WRITES EXACTLY N RECORDS FROM TRANSACTION FILE

   WHILE FIXED.NO% > 0 AND NOT EOF(FILENO%)           ' 2.0
      GOSUB READTRANS
      FIXED.NO% = FIXED.NO% - 1
      CALL WRITENEW(NUTRANS$, NWRITE, REMOVE.COMMENTS) ' 06-06
   WEND
RETURN

READTRANS:

   REM FETCHES NEXT DATA (NON-COMMAND) RECORD FROM TRANSACTION FILE
   REM NOTE: WILL NOT SKIP OVER ANY LINES

   CALL GETTRANS(FILENO%, NUTRANS$, NTRANS)       ' 2.0
   CALL FIRSTNB(NUTRANS$, ONE, BS): IF BS < 1 THEN BS = 1
   LSET TRANSBLK$ = MID$(NUTRANS$, BS, LBLK)
REM   print "RT BS=";BS;" trans=";trans$;" transblk=<";transblk$;"> endblk=<";endblk$;">"

RETURN

WRTBLOCK:

   REM INSERT ROUTINE WHEN BLOCK

   IF NOT EOF(FILENO%) THEN GOSUB READTRANS         ' 2.0
   WHILE TRANSBLK$ <> ENDBLK$ AND NOT EOF(FILENO%)  ' 2.0
      CALL WRITENEW(NUTRANS$, NWRITE, REMOVE.COMMENTS) ' 06-06
      GOSUB READTRANS
   WEND

RETURN

REM --------------------[ SHARED ROUTINES ]-----------------------------

GETFILES:

REM PROMPTS FOR 3 FILE NAMES NEEDED

   GOSUB CHKEXTENSIONS
   FFLDVAL$(1) = ORIGFILE$
   FFLDVAL$(2) = BTCHCMDS$
   FFLDVAL$(3) = NEWFILE$
   CALL PRTSCRN(THREE, FROW(), FCOL(), FPROMPT$(), FFLDSIZE(), FFLDTYPE$(), FFLDVAL$(), FHLP$())
   CALL CENTERBEG(TOPTITLE$, SEVENTYTWO, BEG)
   CALL QPRINT(TOPTITLE$, FOUR, BEG)
   IF RUN.BATCH THEN FANS$ = "R": GOTO GOTFILES

     CO = 1: CALL QPRINT(SPACE$(79), FRO, CO)
     FANS$ = "E"
     CALL GETCHAR(EDRO, EDCO, EDPRO$, EDVAL$, FANS$)
     WHILE FANS$ = "E"
       CALL GETSCRN(THREE, FROW(), FCOL(), FPROMPT$(), FFLDSIZE(), FFLDTYPE$(), FFLDVAL$(), FHLP$())
       LOCATE EDRO, 1: PRINT SPACE$(79)
       FANS$ = "": CALL GETCHAR(EDRO, EDCO, EDPRO$, EDVAL$, FANS$)
     WEND

GOTFILES:
   IF FANS$ <> "Q" THEN
      GOSUB PREPARECOUNTS
      ORIGFILE$ = FFLDVAL$(1)
      BTCHCMDS$ = FFLDVAL$(2)
      NEWFILE$ = FFLDVAL$(3)
      GOSUB OPENFILES
      PRINT #4, "--[USING FILES "; ORIGFILE$; " "; BTCHCMDS$; " "; NEWFILE$; "]--"
   END IF

RETURN

CHKEXTENSIONS:

   IF INSTR(ORIGFILE$, ".") = 0 THEN ORIGFILE$ = ORIGFILE$ + "." + DESOURCE$
   IF INSTR(BTCHCMDS$, ".") = 0 THEN IF FILE.COMPARE THEN BTCHCMDS$ = BTCHCMDS$ + "." + DESOURCE$ ELSE BTCHCMDS$ = BTCHCMDS$ + "." + DEMERGES$
   IF INSTR(NEWFILE$, ".") = 0 THEN IF FILE.COMPARE THEN NEWFILE$ = NEWFILE$ + "." + DEMERGES$ ELSE NEWFILE$ = NEWFILE$ + "." + DESOURCE$

RETURN

PREPARECOUNTS:

  COLOR 0, 7
  LOCATE 24, 1
  PRINT SPACE$(79);
  LOCATE 24, 4: PRINT "SOURCE:";
  LOCATE 24, 23: PRINT "CHANGES:";
  LOCATE 24, 42: PRINT "NEW:";
  LOCATE 24, 60: PRINT "WARNINGS:";

  TROW = 24
  TCOL = 31
  WROW = 24
  WCOL = 46
  MROW = 24
  MCOL = 11
  WROW = 24
  WCOL = 69

RETURN

STANDARDFILES:

  FHLP$(1) = "Text file to be edited (e.g. source code in TEST.BAS)"
  FHLP$(2) = "Merges (edits, changes) to be applied (e.g. TEST.MRG)"
  FHLP$(3) = "Save changes made in this file (e.g. old + merges -> TESTNEW.BAS)"
  FPROMPT$(1) = "SOURCE File:"
  FPROMPT$(2) = " MERGE File:"
  FPROMPT$(3) = "   NEW File:"
  GOSUB GETFILES

RETURN

OPENFILES:

  ON ERROR GOTO ERROPEN
  FF$ = ORIGFILE$
  OPEN "I", #1, FF$
  FF$ = BTCHCMDS$
  FILENO% = 2
  OPEN "I", #2, FF$
  FF$ = NEWFILE$
  OPEN "O", #3, FF$
  ON ERROR GOTO 0

  NREAD = 0
  NWRITE = 0
  NTRANS = 0
  PTR% = 1

RETURN

ERROPEN:
   X$ = "Error" + STR$(ERR) + " opening file " + FF$
   CALL EXPLAIN(X$)
   FLDSIZ = 30
   RO = 23: CO = 1: CALL QPRINT(SPACE$(79), RO, CO)
   CO = 13: PROMPT$ = "Enter file name (<rtn> quits): "
   FFF$ = ""
   CALL GETSTR(RO, CO, PROMPT$, FLDSIZ, FFF$)
   IF FFF$ = "" THEN RESUME QUITMERGE ELSE FF$ = FFF$: GOSUB PREPARECOUNTS: RESUME
QUITMERGE: FANS$ = "Q": RETURN

REM *****************   SHARED CALLED SUBROUTINES   *****************

SUB BRKWORDS (STRNG$, WORDS$(), NPARMS) STATIC

REM PASS STRNG$  - A STRING TO BE BROKEN INTO WORDS (SPACE
REM                 DELIMITED STRINGS)
REM      WORDS$  - AN ARRAY TO PUT WORDS IN

REM DEFINT A-Z
ONE = 1
LST = LEN(STRNG$)
X$ = STRNG$ + " !"
CALL FIRSTNB(X$, ONE, BS)
NPARMS = 0
MAXPARMS = UBOUND(WORDS$)
WHILE BS <= LST
  NPARMS = NPARMS + 1
  CALL LASTNB(X$, BS, ES)
  IF NPARMS > MAXPARMS THEN BS = LST + 1 ELSE WORDS$(NPARMS) = MID$(X$, BS, ES - BS + 1):       BS = ES + 1:   CALL FIRSTNB(X$, BS, BS)
WEND
END SUB

SUB CENTERBEG (STRNG$, LSIZE%, BEG%) STATIC

REM COMPUTERS CENTERED POSITION OF STRNG$ IN FIELD OF SIZE LSIZE%
REM PASS STRNG$   - STRING TO BE CENTERED
REM      LSIZE%   - LENGTH OF FIELD TO CENTER
REM GET  BEG%     - STARTING POSITION OF STRNG$ IN LSIZE%.  RETURNS
REM                 1 IF STRNG$ TOO BIG TO FIT

   REM DEFINT A-Z
   X = LEN(STRNG$)
   IF X > LSIZE% THEN BEG% = 1 ELSE BEG% = (LSIZE% - X) / 2

END SUB

SUB CHKCONT (STRNG$, LINEON$, REMCHAR$, CONTINUED%) STATIC

REM CHECKS WHETHER LINE STRNG$ CONTINUES LOGICALLY TO NEXT LINE

DEFINT A-Z
REM IF DEB=0 THEN DEB = INSTR(STRNG$,"9150 IF")
REM IF DEB>0 THEN IF INSTR(STRNG$,"9510 US") THEN DEB = 0
CONTINUED% = 0
ONE = 1
BS = 1
LS = LEN(STRNG$)
LCO = INSTR(STRNG$, LINEON$)
IF LCO = 0 THEN GOTO GETOUTCHKCONT
CHKREM:
    X = INSTR(BS, STRNG$, REMCHAR$)
    IF X = 0 THEN X$ = STRNG$: GOTO ALLSTRNG ELSE CALL FIRSTNB(STRNG$, ONE, XX):                IF X = XX THEN GOTO GETOUTCHKCONT
    CALL INQUOTES(STRNG$, X, INQUO)
    IF INQUO > 0 THEN BS = INQUO + 1: IF BS <= LS THEN GOTO CHKREM
    X$ = LEFT$(STRNG$, X - 1)
ALLSTRNG:
    CALL ENDNB(X$, ES)
    CONTINUED% = (MID$(X$, ES, 1) = LINEON$)
REM    IF CONTINUED% <> 0 THEN PRINT "es=";es;" checking char <";MID$(X$,ES,1);">  CONT?=";CONTINUED%
GETOUTCHKCONT:
REM IF DEB>0 THEN_
REM   PRINT "CONT?=";CONTINUED%;" for >";STRNG$;"<":_
REM   PRINT "LCO=";LCO;" REM POS =";X;" INQUO=";INQUO;" BS= ";BS;" ES=";ES;:INPUT XX$:PRINT
END SUB

SUB CHKNARY (ELEMENT$, ARRAY$(), NUM.ENTRIES.TO.SEARCH%, IS.IN.ARA%, BEG%) STATIC
      IS.IN.ARA% = BEG%
      CALL UPCASE(ELEMENT$)
      MAX.TRIES% = NUM.ENTRIES.TO.SEARCH% + 1
      ARRAY$(MAX.TRIES%) = ELEMENT$
      WHILE ARRAY$(IS.IN.ARA%) <> ELEMENT$
         IS.IN.ARA% = IS.IN.ARA% + 1
      WEND
      IF IS.IN.ARA% = MAX.TRIES% THEN IS.IN.ARA% = 0
END SUB

SUB CHKWRDS (BLKTYPE$, DES.NO%, TARGET$, NUWRD%, INCMT%, WRDS$(), BEG%, PTR%) STATIC

REM DEFINT A-Z
REM PASS WRDS$      - ARRAY OF WORDS
REM      BEG%        - FIRST ELEMENT OF ARRAY TO EXAMINE
REM      PTR%        - CURRENT LINE # OF SOURCE FILE
REM GET  BLKTYPE$  - HOW BLOCK DEFINED (LINE,STRING,LABEL)
REM      DES.NO%     - DESIRED LINE NUMBER FOR LINE BLOCK TYPE
REM      TARGET$    - TARGET STRING FOR STRING/LABEL BLOCK TYPE
REM      INCMT%      - FLAG SET TO 0 WHEN BLOCK EXTENDS TO END-OF-FILE,
REM                     OTHERWISE 1
REM      NUWRD%      - LAST WORD POSITION THIS ROUTINE EXAMINED
REM PRINT "SUB CHKWRDS RECEIVED BEG=";BEG%;" PTR=";PTR%
TARGET$ = ""
INCMT% = 1
DES.NO% = 0
IF BEG% < 1 THEN BEG% = 1: PRINT "UPPED BEG%"
REM IF PTR%<10 THEN PTR%=10:PRINT "UPPED PTR%"
WD$ = WRDS$(BEG%)
FLET$ = LEFT$(WD$, 1)
IF FLET$ <> "L" AND FLET$ <> "S" THEN BLKTYPE$ = "L":     NUWRD% = BEG% ELSE NUWRD% = BEG% + 1:  IF WD$ = "LABEL" OR WD$ = "LABEL#" THEN BLKTYPE$ = "LABEL":       TARGET$ = WRDS$(NUWRD%) ELSE IF FLET$ = "S" THEN BLKTYPE$ = "S":           TARGET$ =  _
WRDS$(NUWRD%) ELSE BLKTYPE$ = "L"
WD$ = WRDS$(NUWRD%)
L2$ = LEFT$(WD$, 2)
RES$ = MID$(WD$, 3)
IF BLKTYPE$ = "L" THEN IF L2$ = "*+" THEN CALL NUMERIC(RES$, POSNUM):            IF POSNUM THEN DES.NO% = VAL(RES$) + PTR% ELSE M$ = "NON-NUMERIC IN LINE NUMBER FIELD":                          CALL WRMIS(M$, WD$) ELSE IF L2$ = "*" THEN DES.NO% =  _
PTR% ELSE CALL NUMERIC(WD$, POSNUM):               IF POSNUM THEN DES.NO% = VAL(WD$) ELSE IF WD$ = "END" THEN INCMT% = 0 ELSE M$ = "NON-NUMERIC IN LINE NUMBER FIELD":                                                                        CALL WRMIS( _
M$, WD$)
IF BLKTYPE$ <> "L" AND TARGET$ = "" THEN M$ = "STRING/LABEL MISSING":       CALL WRMIS(M$, WD$)
REM PRINT "CHKWRDS RETURNED DESNO=";DES.NO%;" NUWRD=";NUWRD%
END SUB

SUB CREDITS STATIC

REM PUTS UP CREDITS WHEN PROGRAM INVOKED

REM DEFINT A-Z
SEC = 3
CLS
KEY OFF

RO = 1: CO = 12: X$ = "BLED - A SOURCE CODE MERGE UTILITY  ver 2.2  May 16, 1989"'03-20-88
CALL QPRINT(X$, RO, CO)
RO = 3: CO = 3: X$ = "Copyright (c) 1985-88  Ken Goosens, 5020 Portsmouth Rd, Fairfax, VA 22032"
CALL QPRINT(X$, RO, CO)
RO = 6: CO = 2: X$ = "You are granted a limited license to use and distribute this program provided"
CALL QPRINT(X$, RO, CO)
RO = 8: CO = 10: X$ = "1.  you do not alter or remove this notice"
CALL QPRINT(X$, RO, CO)
RO = 10: CO = 10: X$ = "2.  you receive no fee or charge for this program"
CALL QPRINT(X$, RO, CO)
RO = 12: CO = 10: X$ = "3.  modifications are distributed only as a merge to this program"
CALL QPRINT(X$, RO, CO)
RO = 14: CO = 10: X$ = "4.  you assume all liability for using this program"
CALL QPRINT(X$, RO, CO)
LOCATE 16, 1: CALL PRTHELP
CALL WAITSECORKEY(SEC)

END SUB

SUB ECHO (STRNG$, ROW%, COL%, FLDSIZE%) STATIC

REM ROUTINE FOR CLEARING A SPACE AND PRINTING MESSAGE

CALL QPRINT(SPACE$(FLDSIZE%), ROW%, COL%)
CALL QPRINT(STRNG$, ROW%, COL%)

END SUB

SUB ENDNB (STRNG$, LST%) STATIC

REM LOCATES LAST NON-BLANK CHARACTER IN STRNG$.  0 IF NONE.

REM PASS STRNG$ - STRING TO BE SEARCHED
REM GET  LST%   - POSITION IN STRNG$ OF LAST NON-BLANK

   X$ = "!" + STRNG$
   LST% = LEN(X$)
   WHILE MID$(X$, LST%, 1) = " "
     LST% = LST% - 1
   WEND
   LST% = LST% - 1

END SUB

SUB EXPERR (STRNG$) STATIC

REM EXPLAIN AN ERROR

REM DEFINT A-Z
BEEP

CALL EXPLAIN(STRNG$)
SEC = 2
CALL WAITSECORKEY(SEC)
BEEP

END SUB

SUB EXPLAIN (STRNG$) STATIC

REM CONTROLS MESSAGE IN INVERSE VIDEO ON LINE 24

REM DEFINT A-Z
RO = 24
CO = 3
PGE = 0
ATTR = (7 AND 7) * 16
X$ = LEFT$(STRNG$, 75)
CALL XQPRINT(" " + X$ + SPACE$(75 - LEN(X$)), RO, CO, ATTR, PGE)
COLOR 7, 0

END SUB

SUB FIRSTNB (STRNG$, BEG%, WHEREIS%) STATIC

REM PASS STRNG$  - A STRING TO BE SEARCHED
REM      BEG%     - POSITION TO BEGIN SEARCH
REM GET  WHEREIS% - POSITION IN STRNG$ OF FIRST NON-BLANK AT
REM                  BEG% OR LATER.  RETURNS 0 IF NO NON-BLANK.

REM DEFINT A-Z
REM LOCATE 24,70:PRINT "FIRSTNB  ";
X$ = STRNG$ + "!"
WHEREIS% = BEG%
IF WHEREIS% < 1 THEN WHEREIS% = 1
WHILE MID$(X$, WHEREIS%, 1) = " "
   WHEREIS% = WHEREIS% + 1
WEND
IF WHEREIS% > LEN(STRNG$) THEN WHEREIS% = 0

END SUB

SUB FIRSTWORD (STRNG$, FIRST.WORD$, BS) STATIC

REM RETURNS FIRST WORD IN STRNG$
REM PASS STRNG$   - STRING TO BE SEARCHED
REM GET  FIRST.WORD$ - FIRST WORD IN STRNG$

REM DEFINT A-Z

ONE = 1
CALL FIRSTNB(STRNG$, ONE, BS)
IF BS > 0 THEN CALL LASTNB(STRNG$, BS, ES):    FIRST.WORD$ = MID$(STRNG$, BS, ES - BS + 1) ELSE FIRST.WORD$ = ""

END SUB

SUB GETCHAR (ROW%, COL%, PROMPT$, VLDANS$, RESULT$) STATIC

REM ROUTINE TO GET SINGLE CHARACTER
REM LOCATE 24,70:PRINT "GETCHAR ";
REM DEFINT A-Z
CR$ = CHR$(13)
FLDSIZE% = 1
CALL QPRINT(PROMPT$ + RESULT$, ROW%, COL%)
X% = COL% + LEN(PROMPT$)
LOCATE ROW%, X%, 1, 6, 7
X$ = INPUT$(1)
IF X$ = CR$ THEN X$ = RESULT$: IF X$ = "" THEN X$ = CHR$(0)
CALL UPCASE(X$)
IF VLDANS$ <> "" THEN WHILE INSTR(VLDANS$, X$) = 0:      BEEP:      X$ = INPUT$(1): CALL UPCASE(X$):    WEND
RESULT$ = X$: PRINT RESULT$;

END SUB

SUB GETDISP (BUF$(), NUM.NBUF%, DOCCHAR$, BLK.DISP$, FILENO%) STATIC

REM PASS BUF$      - ARRAY CONTAINING BUFFERED BLED COMMANDS
REM      NUM.NBUF%  - NUMBER OF UNUSED ELEMENTS IN BUF$
REM      DOCCHAR$   - FIRST CHAR OF REMARK LINE IN MERGE FILE (1ST WORD)
REM GET  BLK.DISP$  - DISPOSITION OF BLOCK

REM DEFINT A-Z
REM PRINT "GETDISP ENTERED NUM.NBUF=";NUM.NBUF%
ONE = 1
  CALL READNXT(FILENO%, BUF$(), NUM.NBUF%, DOCCHAR$, CMD$)
  CALL FIRSTNB(CMD$, ONE, BS)
  IF BS > 0 THEN BLK.DISP$ = MID$(CMD$, BS, 1) ELSE BLK.DISP$ = "K"
  IF INSTR("DRK", BLK.DISP$) = 0 THEN BLK.DISP$ = "K":      NUM.NBUF% = NUM.NBUF% + 1:   BUF$(NUM.NBUF%) = CMD$ ELSE IF BLK.DISP$ = "R" THEN BLK.DISP$ = "D":                    NUM.NBUF% = NUM.NBUF% + 1:      CALL LASTNB(CMD$, BS, ES):       IF ES < _
 LEN(CMD$) THEN BUF$(NUM.NBUF%) = "I " + MID$(CMD$, ES + 1) ELSE N$ = "REPLACE command must be followed by 'BLOCK' or # of lines":               CALL WRMIS(CMD$, N$)
           
END SUB

SUB GETNATNUM (ROW%, COL%, PROMPT$, FLDSIZE%, RESULT$) STATIC

REM ROUTINE TO INPUT ONLY NATURAL NUMBER (> OR = 0)
REM LOCATE 24,70:PRINT "GETNATNUM ";

REM DEFINT A-Z
RESTART:
  CALL GETSTR(ROW%, COL%, PROMPT$, FLDSIZE%, RESULT$)
  CALL NUMERIC(RESULT$, NONNEG%)
IF NOT NONNEG% THEN BEEP: GOTO RESTART

END SUB

SUB GETNXTCMD (FILENO%, CMD$, DOCCHAR$, STBLKTYPE$, ENDBLKTYPE$, STDES.NO%, ENDDES.NO%, STTARGET$, ENDTARGET$, INCREMENT%, PTR%, CMD.TYPE$, INS.BLKTYPE$, FIXED.NO%, BLK.DISP$) STATIC

REM FETCHES NEXT COMMAND, PARSES, AND SETS ALL PARMS FOR PROCESSING

REM DEFINT A-Z
DIM BUF$(10)
REM PRINT "GETNXTCMD ENTERED"
CALL READNXT(FILENO%, BUF$(), NUM.NBUF%, DOCCHAR$, CMD$)    ' 2.0

IF CMD$ = "" THEN CMD.TYPE$ = "" ELSE CALL PARSECMD(CMD$, STBLKTYPE$, ENDBLKTYPE$, STDES.NO%, ENDDES.NO%, STTARGET$, ENDTARGET$, INCREMENT%, PTR%, INCLUSIVE%, CMD.TYPE$, INS.BLKTYPE$, FIXED.NO%):                         IF CMD.TYPE$ = "B" THEN CALL  _
GETDISP(BUF$(), NUM.NBUF%, DOCCHAR$, BLK.DISP$, FILENO%): IF INCLUSIVE% THEN NUM.NBUF% = NUM.NBUF% + 1:     BUF$(NUM.NBUF%) = BLK.DISP$:        NUM.NBUF% = NUM.NBUF% + 1:      BUF$(NUM.NBUF%) = "BLOCK FROM LINE * TO *+1"

REM PRINT "GETNXTCMD: CMD=";CMD$;" CMD TYPE=";CMD.TYPE$;" BLOCK DISP=";BLK.DISP$
END SUB

SUB GETSCRN (NUMFLDS%, ROW%(), COL%(), PROMPT$(), FLDSIZE%(), FLDTYPE$(), FLDVAL$(), HLP$()) STATIC

REM DOES FULL SCREEN DATA ENTRY FOR TABLE DRIVEN SCREEN

REM DEFINT A-Z
NUL$ = ""
TOPGETSCRN:
  FOR I = 1 TO NUMFLDS%
    CALL EXPLAIN(HLP$(I))
    X = INSTR("LSN", FLDTYPE$(I))
    IF X > 1 THEN IF X = 2 THEN CALL GETSTR(ROW%(I), COL%(I), PROMPT$(I), FLDSIZE%(I), FLDVAL$(I)) ELSE CALL GETNATNUM(ROW%(I), COL%(I), PROMPT$(I), FLDSIZE%(I), FLDVAL$(I))
  NEXT I

END SUB

SUB GETSTR (ROW%, COL%, PROMPT$, FLDSIZE%, RESULT$) STATIC

REM INPUT ROUTINE TO GET A STRING
REM LOCATE 24,70:PRINT "GETSTR  ";

X% = FLDSIZE% + 1: IF X% < 8 THEN X% = 8
CALL QPRINT(PROMPT$ + SPACE$(X%), ROW%, COL%)
X% = COL% + LEN(PROMPT$) + 1
CALL ECHO(RESULT$, ROW%, X%, FLDSIZE%)
LOCATE ROW%, X%
INPUT "", X$
IF X$ <> "" THEN RESULT$ = X$: CALL ECHO(RESULT$, ROW%, X%, FLDSIZE%)

END SUB

SUB GETTRANS (FILENO%, TRANS$, NTRANS%) STATIC     ' 2.0

REM FETCHES TRANSACTION RECORD
REM PASS NTRANS% - VALUE OF 0 TO INITIALIZE COUNTER, OTHERWISE > 0
REM GET  TRANS%  - NEW TRANSACTION RECORD

   REM DEFINT A-Z

   LINE INPUT #FILENO%, TRANS$                      ' 2.0
   IF NTRANS% < 1 THEN LOCTRANS = 0: NTRANS% = 1
   LOCTRANS = LOCTRANS% + 1
   LOCATE 24, 31: PRINT LOCTRANS%;

END SUB

SUB INQUOTES (STRNG$, BS%, INQUO%) STATIC

REM CHECKS WHETHER CHARACTER AT POSITION BS% IN STRNG$
REM        IS INSIDE A PAIR OF QUOTES.  RETURNS POSITION OF RIGHT QUOTE
REM        IF INSIDE, 0 IF NOT INSIDE

REM DEFINT A-Z
QUOTE$ = CHR$(34)
BEG = 1
INQUO% = 0
CHKQAGAIN:
  FQUO = INSTR(BEG, STRNG$, QUOTE$)
  IF FQUO = 0 THEN GOTO GETOUTINQUOTES
  IF BS% <= FQUO THEN GOTO GETOUTINQUOTES
  SQUO = INSTR(FQUO + 1, STRNG$, QUOTE$)
  IF SQUO = 0 THEN GOTO GETOUTINQUOTES
  IF BS% < SQUO THEN INQUO% = SQUO: GOTO GETOUTINQUOTES
  BEG = SQUO + 1
GOTO CHKQAGAIN
  
GETOUTINQUOTES:
REM PRINT "INQUOTES: LOOKING AT POS ";BS%;"<";MID$(STRNG$,BS%,1);"> SENDING INQUO=";INQUO%
END SUB

SUB KEEPONLY (L$, GOODSTRNG$) STATIC

REM KEEPS IN L$ ONLY THOSE CHARACTERS IN GOODSTRNG$, I.E.
REM     REMOVES FROM L$ ALL INSTANCES OF CHARACTERS NOT IN GOODSTRNG$

REM PASS L$         - STRING TO BE ALTERED
REM      GOODSTRNG$ - LIST OF CHARACTERS TO KEEP
REM GET  L$         - ORIGINAL MINUS CHARS NOT IN GOODSTRNG$

REM DEFINT A-Z
J = 0
FOR I = 1 TO LEN(L$)
  IF INSTR(GOODSTRNG$, MID$(L$, I, 1)) THEN J = J + 1:    MID$(L$, J, 1) = MID$(L$, I, 1)
NEXT I
L$ = LEFT$(L$, J)

END SUB

SUB LASTNB (STRNG$, BEG%, WHEREIS%) STATIC

REM PASS STRNG$   - A STRING TO BE SEARCHED
REM      BEG%      - POSITION TO BEGIN SEARCH
REM GET  WHEREIS%  - LAST POSITION IN STRNG$ OF ANY WORD BEGINNING AT
REM                   BEG% OR LATER.  RETURNS BEG%-1 IF NO WORD AT BEG%.

REM DEFINT A-Z
REM LOCATE 24,70:PRINT "LASTNB  ";
B = BEG%
IF B < 1 THEN B = 1
IF B > LEN(STRNG$) THEN X$ = " " ELSE X$ = MID$(STRNG$, B) + " "
WHEREIS% = INSTR(X$, " ") - 1 + B - 1

END SUB

SUB NOOTHER (STRNG$, ONLY$, RESULT%) STATIC

REM PASS STRNG$  - A STRING TO BE SEARCHED
REM      ONLY$   - A LIST OF THE ONLY CHARACTERS TO BE IN STRNG$
REM GET  RESULT%  - TRUE OF ONLY CHARACTERS IN STRNG$ ARE THOSE IN ONLY$
REM                   OR ARE LEADING OR TRAILING BLANKS

REM DEFINT A-Z

RESULT% = -1
IF LEN(STRNG$) < 1 THEN GOTO GETOUTNOOTHER
ONE = 1
CALL FIRSTNB(STRNG$, ONE, BS)
CALL LASTNB(STRNG$, BS, ES)

FOR I = BS TO ES
   IF INSTR(ONLY$, MID$(STRNG$, I, 1)) = 0 THEN
      RESULT% = 0
      I = ES + 1
   END IF
NEXT I

IF STRNG$ <> MID$(STRNG$, 1, ES) + SPACE$(LEN(STRNG$) - ES) THEN RESULT% = 0

GETOUTNOOTHER:
END SUB

SUB NUMERIC (STRNG$, RESULT%) STATIC

REM PASS STRNG$  - A STRING TO BE SEARCHED
REM GET  RESULT%  - TRUE IF STRNG$ CONTAINS ONLY NON-NEGATIVE DIGITS
REM                  OR LEADING OR TRAILING BLANKS

REM DEFINT A-Z
IF STRNG$ = SPACE$(LEN(STRNG$)) THEN RESULT% = 0: GOTO GETOUTNUMERIC
NUM$ = "0123456789"
CALL NOOTHER(STRNG$, NUM$, RESULT%)
GETOUTNUMERIC:
END SUB

SUB PARSECMD (CMD$, STBLKTYPE$, ENDBLKTYPE$, STDES.NO%, ENDDES.NO%, STTARGET$, ENDTARGET$, INCREMENT%, PTR%, INCLUSIVE%, CMD.TYPE$, INS.BLKTYPE$, FIXED.NO%) STATIC

REM DEFINT A-Z
DIM WRDS$(10)
REM BREAKS COMMAND LINE INTO WORDS AND CHECKS FOR PROPER SYNTAX

REM PASS CMD$     - BLED COMMAND LINE
REM      PTR%     - CURRENT LINE POSITION IN ORIGINAL SOURCE FILE
REM GET  STBLKTYPE$  - BLOCK TYPE DEFINING START BLOCK
REM     ENDBLKTYPE#  - BLOCK TYPE DEFINING END BLOCK
REM      STDES.NO%   - LINE NUMBER OF SOURCE THAT BEGINS BLOCK
REM     ENDDES.NO%   - LINE NUMBER OF SOURCE THAT ENDS BLOCK
REM      STTARGET$   - STRING/LABEL DEFINING START OF BLOCK
REM     ENDTARGET$   - STRING/LABEL DEFINING END OF BLOCK
REM     INCREMENT%   - COUNTER FOR ADVANCING READS (0 IF TO END,
REM                       NORMALLY AND OTHERWISE 1)
REM     CMD.TYPE$    - TYPE OF COMMAND (Insert, Block)
REM     INS.BLKTYPE$ - TYPE OF INSERT BLOCK (Blocked, or Lines)
REM     FIXED.NO%    - Fixed number of lines to insert

CALL BRKWORDS(CMD$, WRDS$(), IX)

CMD.TYPE$ = LEFT$(WRDS$(1), 1)
IF INSTR("IB", CMD.TYPE$) = 0 THEN
   EXP$ = "BLED COMMAND MUST BEGIN WITH 'I' OR 'B'"
   CALL WRMIS(EXP$, CMD$)
   GOTO GETOUT
END IF
IF CMD.TYPE$ = "I" AND WRDS$(2) = "" THEN WRDS$(2) = "B"
IF CMD.TYPE$ = "I" THEN
   IF LEFT$(WRDS$(2), 1) <> "B" THEN
      INS.BLKTYPE$ = "L"
      CALL NUMERIC(WRDS$(2), POSNUM)
      IF POSNUM THEN
         FIXED.NO% = VAL(WRDS$(2))
         GOTO GETOUT
      ELSE
         EXP$ = "INSERT command should specify # of lines to include"
         CALL WRMIS(EXP$, CMD$)
         GOTO GETOUT
      END IF
   ELSE
      INS.BLKTYPE$ = "B"
      GOTO GETOUT
   END IF
END IF
IF LEFT$(WRDS$(2), 1) = "F" THEN NXT.WRD = 3 ELSE NXT.WRD = 2
CALL CHKWRDS(STBLKTYPE$, STDES.NO%, STTARGET$, NXT.WRD, INCREMENT%, WRDS$(), NXT.WRD, PTR%)
NXT.WRD = NXT.WRD + 1
FL$ = LEFT$(WRDS$(NXT.WRD), 1)
IF INSTR("UT", FL$) = 0 THEN
   INCLUSIVE% = 0
ELSE
   NXT.WRD = NXT.WRD + 1
   IF FL$ = "U" OR WRDS$(NXT.WRD - 1) = "TO" THEN
      INCLUSIVE% = 0
   ELSE
      INCLUSIVE% = -1
   END IF
END IF
CALL CHKWRDS(ENDBLKTYPE$, ENDDES.NO%, ENDTARGET$, NXT.WRD, INCREMENT%, WRDS$(), NXT.WRD, PTR%)
GETOUT:
REM PRINT "PARSECMD: INCLUSIVE=";INCLUSIVE%
END SUB

SUB PRTHELP STATIC

REM PRINTS HELP (DOCUMENTATION) SCREEN

PRINT
PRINT "Apply a  merge:  BLED[/B/L/M/RC]  {source} {merges} {new file} {warn file}" ' 06-06
PRINT "Create a merge:  BLED[/F/B/RC]  {old version} {new vers} {merges} {warn file}" ' 06-06
PRINT "Options: B=run batch  F=file compare  L=line# merge  M=merge RC=remove comments" ' 06-06
PRINT

END SUB

SUB PRTSCRN (NUMFLDS%, ROW%(), COL%(), PROMPT$(), FLDSIZE%(), FLDTYPE$(), FLDVAL$(), HLP$()) STATIC

REM PRINTS TABLE DRIVEN SCREEN

REM DEFINT A-Z
CLS
FOR I = 1 TO NUMFLDS%
  CALL QPRINT(PROMPT$(I), ROW%(I), COL%(I))
  X% = COL%(I) + LEN(PROMPT$(I)) + 1
  CALL ECHO(FLDVAL$(I), ROW%(I), X%, FLDSIZE%(I))
NEXT I

END SUB

SUB READNXT (FILENO%, BUF$(), NUM.NBUF%, DOCCHAR$, CMD$) STATIC' 2.0

REM PROCESSES REQUEST FOR NEXT BLED COMMAND
REM PASS BUF$     - BUFFER ARRAY
REM      NUM.NBUF% - NUMBER ACTIVE ENTRIES IN BUFFER
REM      DOCCHAR$  - FIRST CHAR OF DOCUMENTATION LINE
REM GET  CMD$     - BLED COMMAND LINE

REM DEFINT A-Z
ONE = 1
CMD$ = ""
FW$ = ""
IF NUM.NBUF% > 0 THEN
   CMD$ = BUF$(NUM.NBUF%)
   NUM.NBUF% = NUM.NBUF% - 1
   GOTO GETOUTREADNXT
END IF
WHILE (CMD$ = SPACE$(LEN(CMD$)) OR LEFT$(FW$, 1) = DOCCHAR$) AND NOT EOF(FILENO%)' 2.0
   CALL GETTRANS(FILENO%, CMD$, ONE)              ' 2.0
   CALL FIRSTWORD(CMD$, FW$, BEGIN.AT)
WEND
IF EOF(FILENO%) AND LEFT$(FW$, 1) = DOCCHAR$ THEN CMD$ = ""
IF CMD$ = SPACE$(LEN(CMD$)) THEN
   IF EOF(1) THEN
      CMD$ = ""
   ELSE
      CMD$ = "BLOCK FROM LINE * THRU END"
      NUM.NBUF% = NUM.NBUF% + 1
      BUF$(NUM.NBUF%) = "KEEP"
   END IF
END IF
GETOUTREADNXT:
REM PRINT "FROM READNXT: CMD IS {";CMD$;"}  DOCCHAR=";DOCCHAR$
END SUB

SUB REALNUM (STRNG$, RESULT%) STATIC

REM CHECKS WHETHER STRNG$ IS A VALID REAL NUMBER
REM PASS STRNG$  - STRING TO BE CHECKED
REM GET  RESULT% - TRUE IF REAL

REM DEFINT A-Z
X$ = STRNG$ + "."
LENGTH = LEN(STRNG$)
J = 1
WHILE INSTR("+- ", MID$(X$, J, 1))
  J = J + 1
WEND
IF J > LENGTH THEN RESULT% = 0: EXIT SUB

X = INSTR(X$, ".")
FRONT$ = MID$(STRNG$, J, X - J)
IF X > LENGTH THEN BACK$ = "" ELSE BACK$ = MID$(STRNG$, X + 1)

CALL NUMERIC(FRONT$, FRNNAT%)
CALL NUMERIC(BACK$, BNNAT%)
RESULT% = (FRNNAT% AND BNNAT%)

END SUB

SUB REMOVE (L$, BADSTRNG$) STATIC

REM REMOVES FROM L$ ALL INSTANCES OF CHARACTERS IN BADSTRNG$

REM PASS L$        - STRING TO BE ALTERED
REM      BADSTRNG$ - LIST OF CHARACTERS TO REMOVE
REM GET  L$        - ORIGINAL MINUS BADSTRNG$

REM DEFINT A-Z
J = 0
FOR I = 1 TO LEN(L$)
  IF INSTR(BADSTRNG$, MID$(L$, I, 1)) = 0 THEN J = J + 1:    MID$(L$, J, 1) = MID$(L$, I, 1)
NEXT I
L$ = LEFT$(L$, J)

END SUB

SUB TRANSLATE (L$, GOT$, WANT$) STATIC

REM REPLACES IN L$ ALL INSTANCES OF CHARACTER IN GOT$ BY CORRESPONDING
REM   CHARACTER IN WANT$

REM PASS L$     - STRING TO BE ALTERED
REM      GOT$   - LIST OF CHARACTERS WANTED REPLACED
REM      WANT$  - WHAT REPLACE BY
REM GET  L$     - ALTERED STRING

REM DEFINT A-Z
FOR I = 1 TO LEN(L$)
  PO = INSTR(GOT$, MID$(L$, I, 1))
  IF PO THEN MID$(L$, I, 1) = MID$(WANT$, PO, 1)
NEXT I

END SUB

SUB TRIM (STRNG$) STATIC

REM REMOVES LEADING AND TRAILING BLANKS FROM STRNG$

REM DEFINT A-Z
ONE = 1
CALL FIRSTNB(STRNG$, ONE, STRT)
IF STRT < 1 THEN STRT = 1: LST = 0 ELSE CALL ENDNB(STRNG$, LST)
STRNG$ = MID$(STRNG$, STRT, LST - STRT + 1)

END SUB

SUB TRIMTRAIL (STRNG$)

CALL ENDNB (STRNG$, LST)
STRNG$ = LEFT$(STRNG$,LST)

END SUB

SUB WAITSECORKEY (SECONDS%) STATIC

REM PAUSE ROUTINE BASED ON CLOCK
REM SEND SECONDS% - MAXIMUM # SECONDS TO WAIT
REM WILL QUIT IF ANY KEY PRESSED

CURSEC! = (VAL(MID$(TIME$, 4, 2)) * 60 + VAL(MID$(TIME$, 7, 2)))
DONE! = CURSEC! + SECONDS%
WHILE CURSEC! < DONE! AND INKEY$ = ""
   CURSEC! = (VAL(MID$(TIME$, 4, 2)) * 60 + VAL(MID$(TIME$, 7, 2)))
WEND

END SUB

SUB WRITENEW (NEWOUT$, NWRITE%, SKIP.COMMENTS) STATIC

REM WRITES NEWOUT$ TO NEW FILE

REM DEFINT A-Z
   DIM OBUF$(100)
   IF NWRITE% < 0 THEN
      FOR I = 1 TO NUM.IN.BUF
         PRINT #3, OBUF$(I)
      NEXT
      NUM.IN.BUF = 0
      EXIT SUB
   END IF
   IF NUM.IN.BUF = 100 THEN
      FOR I = 1 TO 100
         PRINT #3, OBUF$(I)
      NEXT
      NUM.IN.BUF = 0
   END IF
   SKIP.LINE = FALSE                                        ' 06-06
   IF SKIP.COMMENTS THEN                                    ' 06-06
      QB.META = INSTR(NEWOUT$,"$INC") > 0                         ' 06-06
      IF NOT QB.META THEN                                         ' 06-06
         CALL FIRSTWORD (NEWOUT$,FW$,BEGIN.AT)                    ' 06-06
         SKIP.LINE = (FW$ = "REM" OR LEFT$(FW$,1) = "'")          ' 06-06
         IF NOT SKIP.LINE THEN                                    ' 06-06
            X = INSTR(NEWOUT$,"'")                                ' 06-06
            IF X > 0 THEN                                         ' 06-06
               CALL INQUOTES (NEWOUT$,X,INQUO)                    ' 06-06
               IF INQUO = 0 THEN                                  ' 06-06
                  NEWOUT$ = LEFT$(NEWOUT$,X-1)                    ' 06-06
                  CALL TRIMTRAIL (NEWOUT$)                        ' 06-06
                  IF RIGHT$(NEWOUT$,LEN(FW$)) = FW$ THEN          ' 06-06
                     NEWOUT$ = NEWOUT$ + " '"                     ' 06-06
                  END IF                                          ' 06-06
               END IF                                             ' 06-06
            END IF                                          ' 06-06
         END IF                                             ' 06-06
      END IF                                                ' 06-06
   END IF                                                   ' 06-06
   IF NOT SKIP.LINE THEN                                    ' 06-06
      NUM.IN.BUF = NUM.IN.BUF + 1                           ' 06-06
      OBUF$(NUM.IN.BUF) = NEWOUT$                           ' 06-06
   END IF                                                   ' 06-06
   NWRITE% = NWRITE% + 1
   LOCATE 24, 46: PRINT NWRITE;

END SUB

SUB WRMIS (EXPLN$, MISTAKE$) STATIC

REM PASS EXPLN$    - ERROR MESSAGE
REM      MISTAKE#  - THE MISTAKE CAUSING THE ERROR
REM      WARNFILE$ - FILE TO WRITE MESSAGES TO
REM GET            - LOG MISTAKE & EXPLANATION TO FILE F$

REM DEFINT A-Z

PRINT #4, MISTAKE$
PRINT #4, EXPLN$
NWARN = NWARN + 1
LOCATE 24, 69: PRINT NWARN;

END SUB
