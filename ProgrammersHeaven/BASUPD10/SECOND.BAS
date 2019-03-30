'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
'   |                                                                      |
'   |            See BASUPD.DOC for info on distribution policy            |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DEFINT A-Z

FUNCTION Second (SerialNr#)
   Seconds& = CLNG((ABS(SerialNr#) - INT(ABS(SerialNr#))) * 86400#)
   Hours = Seconds& \ 3600&
   Seconds& = Seconds& - Hours * 3600&
   Minutes = Seconds& \ 60&
   Second = Seconds& - Minutes * 60&
END FUNCTION
