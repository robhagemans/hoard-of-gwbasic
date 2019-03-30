'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
'   |                                                                      |
'   |            See BASUPD.DOC for info on distribution policy            |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DEFINT A-Z

FUNCTION WeekDay (SerialNr#)
   tmp = CLNG(SerialNr#) MOD 7&
   SELECT CASE tmp
      CASE IS < 0: tmp = tmp + 7
      CASE IS = 0: tmp = 7
      CASE ELSE
   END SELECT
   WeekDay = tmp
END FUNCTION
