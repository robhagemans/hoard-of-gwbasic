'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
'   |                                                                      |
'   |            See BASUPD.DOC for info on distribution policy            |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DEFINT A-Z

FUNCTION Hour (SerialNr#)
   Seconds& = CLNG((ABS(SerialNr#) - INT(ABS(SerialNr#))) * 86400#)
   Hours = Seconds& \ 3600&
   IF Hours = 24 THEN
      Hour = 0
   ELSE
      Hour = Hours
   END IF
END FUNCTION
