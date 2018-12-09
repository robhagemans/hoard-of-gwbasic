60000  '*******************************************
60010  '* Test shift key status by Lewis Rigdon   *
60020  '*_________________________________________*
60030  '*  These subroutines can be the object of *
60040  '*  a gosub to set or reset the num lock or*
60050  '*  the caps lock keys or to test their    *
60060  '*  statu.                                 *
60070  '*******************************************
60080 REM ***** PEEKS AND POKES FOR SHIFT LOCK KEYS *****
60090 DEF SEG=&H40:POKE &H17,(PEEK(&H17) AND &HFFBF):RETURN ' CAPS LOCK OFF
60100 DEF SEG=&H40:POKE &H17,(PEEK(&H17) OR  &H40):RETURN ' CAPS LOCK ON
60110 DEF SEG=&H40:POKE &H17,(PEEK(&H17) AND &HFFDF):RETURN ' NUM  LOCK OFF
60120 DEF SEG=&H40:POKE &H17,(PEEK(&H17) OR  &H20):RETURN ' NUM  LOCK ON
60130 REM ***** TEST FOR STATUS OF SHIFTS *****
60140 IF (PEEK(&H17) AND &H40) THEN PRINT"CAPS   LOCK ON" ELSE                               PRINT "CAPS   LOCK OFF"
60150 IF (PEEK(&H17) AND &H20) THEN PRINT"NUM    LOCK ON" ELSE                               PRINT "NUM    LOCK OFF"
60160 IF (PEEK(&H17) AND &H10) THEN PRINT"SCROLL LOCK ON" ELSE                               PRINT "SCROLL LOCK OFF"
CK OFF"
60160 IF (PEEK(&H17) AND &H10) THEN PRINT"SCROLL LOCK ON" ELSE                    