'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         PBWIZ  Copyright (c) 1991-1993  Thomas G. Hanlin III         |
'   |                                                                      |
'   |                      PowerBASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

' This is another simple demo of the PBWiz routines.  It allows you to
' view the files in an archive (.ARC, .ARJ, .LZH, .PAK, .ZIP, or .ZOO).

' Syntax:
'   ARCVIEW arcname[.ext] [/V]

' The file extension for the archive is optional, although you may want to
' specify it if there is a possibility that you have two archives of the
' same name but different extensions (e.g., FOO.ARJ and FOO.ZIP).  The /V
' option allows you to specify a full listing-- without it, you will get
' a "wide format" display containing just the file names in the archive.

   $DIM ARRAY

   DECLARE SUB CloseA ()
   DECLARE SUB FindFirstA (STRING, STRING, INTEGER)
   DECLARE SUB FindNextA (INTEGER)
   DECLARE FUNCTION GetCRCA$ ()
   DECLARE FUNCTION GetDateA$ ()
   DECLARE FUNCTION GetNameA$ ()
   DECLARE SUB GetSizeA (LONG, LONG)
   DECLARE FUNCTION GetTimeA$ ()

   DECLARE SUB GetComma (LONG, INTEGER)

   OPTION BINARY BASE 1

   $LINK "pbwiz.pbl"

   DEFINT A-Z

   Cmd$ = LTRIM$(RTRIM$(UCASE$(COMMAND$)))
   IF INSTR(Cmd$, "/?") THEN
      PRINT "ARCVIEW: View Archive Demo for PBWiz by Thomas G. Hanlin III"
      PRINT
      PRINT "Syntax:"
      PRINT "  ARCVIEW arcname[.ext] [/V]
      PRINT
      PRINT "Use /V for a full listing, as opposed to just a list of the files contained"
      PRINT "in the archive.  ARCVIEW currently supports ARC, ARJ, EXE, LZH, PAK, ZIP,"
      PRINT "and ZOO."
      END
   END IF
   tmp = INSTR(Cmd$, "/V")
   IF tmp THEN
      FullView = -1
      Cmd$ = LTRIM$(RTRIM$(LEFT$(Cmd$, tmp - 1) + MID$(Cmd$, tmp + 2)))
   END IF
   IF LEN(Cmd$) THEN
      Arc$ = Cmd$
   ELSE
      PRINT "Please specify the name of an archive."
      END
   END IF

   FindFirstA Arc$, "*.*", ErrCode
   IF ErrCode THEN
      PRINT "Unable to open archive "; CHR$(34); Arc$; CHR$(34)
      END
   END IF

   IF FullView THEN
      PRINT "Filename       Date       Time    CRC        Curr. Size    Orig. Size"
      PRINT "------------   --------   -----   --------   -----------   -----------"
   END IF

   DO
      FileName$ = GetNameA$
      IF FullView THEN
         PRINT FileName$; SPACE$(15 - LEN(FileName$));
         DateSt$ = LEFT$(GetDateA$, 6) + RIGHT$(GetDateA$, 2)
         TimeSt$ = LEFT$(GetTimeA$, 5)
         PRINT DateSt$; "   "; TimeSt$; "   "; GetCRCA$;
         GetSizeA OriginalSize&, CurrentSize&
         PrintComma CurrentSize&, 14
         PrintComma OriginalSize&, 14
         PRINT
      ELSE
         PRINT FileName$; SPACE$(16 - LEN(FileName$));
      END IF
      FindNextA ErrCode
   LOOP UNTIL ErrCode

   CloseA

   IF NOT FullView THEN PRINT

SUB PrintComma (Number&, FieldLen)
   N$ = LTRIM$(STR$(Number&))
   R$ = ""
   DO WHILE LEN(N$) > 3
      R$ = RIGHT$(N$, 3) + "," + R$
      N$ = LEFT$(N$, LEN(N$) - 3)
   LOOP
   IF LEN(N$) THEN R$ = N$ + "," + R$
   IF RIGHT$(R$, 1) = "," THEN R$ = LEFT$(R$, LEN(R$) - 1)
   IF LEN(R$) < FieldLen THEN
      R$ = SPACE$(FieldLen - LEN(R$)) + R$
   END IF
   PRINT R$;
END SUB
