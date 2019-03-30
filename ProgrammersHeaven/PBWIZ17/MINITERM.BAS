'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         PBWIZ  Copyright (c) 1991-1993  Thomas G. Hanlin III         |
'   |                                                                      |
'   |                      PowerBASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

' This is another simple demo of the PBWiz routines.  It shows the telecomm
' routines in action.  Modem settings of 2400:N,8,1 are used.

' Syntax:
'   MINITERM [/COM1] [/COM2] [/COM3] [/COM4]

   $DIM ARRAY

   DECLARE FUNCTION TCInkey$ ()
   DECLARE FUNCTION TCInkey0% ()
   DECLARE FUNCTION TCInStat% ()
   DECLARE SUB TCDone ()
   DECLARE SUB TCDTR (INTEGER)
   DECLARE SUB TCInit (INTEGER, INTEGER)
   DECLARE SUB TCParms (STRING, INTEGER, INTEGER)
   DECLARE SUB TCSpeed (LONG)
   DECLARE SUB TCWrite (STRING)

   $LINK "pbwiz.pbl"

   DEFINT A-Z

   Cmd$ = LTRIM$(RTRIM$(UCASE$(COMMAND$)))
   IF ((LEN(Cmd$) = 0) OR INSTR(Cmd$, "/?")) THEN
      PRINT "MINITERM: Telecommunications Demo for PBWiz by Thomas G. Hanlin III"
      PRINT
      PRINT "Syntax:"
      PRINT "  MINITERM [/COM1] [/COM2] [/COM3] [/COM4]"
      PRINT
      PRINT "Use ALT-X to exit the demo."
      END
   END IF
   IF INSTR(Cmd$, "/COM1") THEN
      CPort = 1
   ELSEIF INSTR(Cmd$, "/COM2") THEN
      CPort = 2
   ELSEIF INSTR(Cmd$, "/COM3") THEN
      CPort = 3
   ELSEIF INSTR(Cmd$, "/COM4") THEN
      CPort = 4
   ELSE
      CPort = 1
   END IF

   TCInit CPort, ErrCode
   IF ErrCode THEN
      PRINT "Telecomm init error: "; ErrCode
      END
   END IF
   TCSpeed 2400&
   TCParms "N", 8, 1

   AltX$ = CHR$(0) + CHR$(45)
   CLS
   PRINT "MiniTerminal on COM"; CHR$(48 + CPort);": press ALT-X to exit."
   LOCATE 3, 1, 1

   DO
      GOSUB HandleCharsFromModem
      ch$ = INKEY$
      IF LEN(ch$) = 1 THEN TCWrite ch$
   LOOP UNTIL ch$ = AltX$

   TCDTR 0
   TCDone
   END

HandleCharsFromModem:
   WHILE TCInstat
      ch = TCInkey0%
      IF ch > 31 THEN               ' display text chars
          PRINT CHR$(ch);
       ELSEIF ch = 13 THEN          ' emulate <CR>
          LOCATE , 1
       ELSEIF ch = 10 THEN          ' emulate <LF>
          PRINT
       ELSEIF ch = 8 THEN           ' emulate <BS>
          IF POS(0) > 1 THEN
             LOCATE , POS(0) - 1
             PRINT " ";
             LOCATE , POS(0) - 1
          END IF
       END IF
    WEND
    RETURN
