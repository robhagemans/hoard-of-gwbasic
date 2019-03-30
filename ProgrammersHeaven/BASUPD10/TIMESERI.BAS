'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
'   |                                                                      |
'   |            See BASUPD.DOC for info on distribution policy            |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DEFINT A-Z

FUNCTION TimeSerial# (HourNr, MinuteNr, SecondNr)
   TimeSerial# = CDBL(HourNr * 3600# + MinuteNr * 60# + CDBL(SecondNr)) / 86400#
END FUNCTION
