'зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
'Ё                                                                           Ё
'Ё  Utility to toggle the CAPS lock status on or off.                        Ё
'Ё  Copyright (c) 1995 by PowerBASIC, Inc.  All Rights Reserved.             Ё
'Ё                                                                           Ё
'юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

$COMPILE EXE
DEFINT A - Z

PRINT "CAPS v1.0 Ч Toggle CAPS LOCK status"
PRINT "Copyright (c) 1995 by PowerBASIC, Inc.  All Rights Reserved."
PRINT ""

Cmd$ = UCASE$( COMMAND$ )
IF ( Cmd$ = "ON" ) OR ( Cmd$ = "+" ) THEN
  Stat = 1
ELSEIF ( Cmd$ = "OFF" ) OR ( Cmd$ = "-" ) THEN
  Stat = 0
ELSE
  PRINT "Usage:  CAPS on|off|+|-"
  END 1
END IF

DEF SEG = 0
  X = PEEK( &H417 )  'get keyboard toggles
  IF Stat THEN
    X = X OR &B01000000
    PRINT "CAPS LOCK is now ON"
  ELSE
    X = X AND &B10111111
    PRINT "CAPS LOCK is now OFF"
  END IF
  POKE &H417, X      'set keyboard toggles
DEF SEG
