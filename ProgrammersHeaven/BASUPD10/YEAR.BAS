'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
'   |                                                                      |
'   |            See BASUPD.DOC for info on distribution policy            |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DEFINT A-Z

FUNCTION Year (SerialNr#)
   TDate& = CLNG(SerialNr#) + 53688
   YearNr = 1753
   DO WHILE TDate& >= 365&
      IF YearNr MOD 4 = 0 AND YearNr MOD 100 > 0 OR YearNr MOD 400 = 0 THEN
         TDate& = TDate& - 366&
      ELSE
         TDate& = TDate& - 365&
      END IF
      YearNr = YearNr + 1
   LOOP
   IF TDate& < 0& THEN
      YearNr = YearNr - 1
   END IF
   Year = YearNr
END FUNCTION
