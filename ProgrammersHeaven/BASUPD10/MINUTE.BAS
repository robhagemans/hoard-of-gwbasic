'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
'   |                                                                      |
'   |            See BASUPD.DOC for info on distribution policy            |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DEFINT A-Z

FUNCTION Minute (SerialNr#)
   Seconds& = CLNG((ABS(SerialNr#) - INT(ABS(SerialNr#))) * 86400#)
   Hours = Seconds& \ 3600&
   Minute = (Seconds& - Hours * 3600&) \ 60&
END FUNCTION
