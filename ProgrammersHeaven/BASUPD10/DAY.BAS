'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
'   |                                                                      |
'   |            See BASUPD.DOC for info on distribution policy            |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DEFINT A-Z

FUNCTION Day (SerialNr#)
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
      DayNr = 31
   ELSE
      TDate& = TDate& + 1&
      MonthNr = 1
      IF YearNr MOD 4 = 0 AND YearNr MOD 100 > 0 OR YearNr MOD 400 = 0 THEN
         MonthDay$ = "313232332323"
      ELSE
         MonthDay$ = "303232332323"
      END IF
      tmp = ASC(MID$(MonthDay$, MonthNr, 1)) - 20
      DO WHILE TDate& > tmp
         TDate& = TDate& - tmp
         MonthNr = MonthNr + 1
         tmp = ASC(MID$(MonthDay$, MonthNr, 1)) - 20
      LOOP
      DayNr = TDate&
   END IF
   Day = DayNr
END FUNCTION
