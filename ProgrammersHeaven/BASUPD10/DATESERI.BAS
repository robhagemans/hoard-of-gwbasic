'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
'   |                                                                      |
'   |            See BASUPD.DOC for info on distribution policy            |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DEFINT A-Z

FUNCTION DateSerial# (YearNr, MonthNr, DayNr)
   IF YearNr < 179 THEN
      Y = YearNr + 1900
   ELSE
      Y = YearNr
   END IF
   IF MonthNr < 1 OR MonthNr > 12 OR DayNr < 1 OR DayNr > 31 OR Y < 1753 OR Y > 2078 THEN
      Result# = 123456789#
   ELSE
      SELECT CASE MonthNr
         CASE 1: Result# = 0#
         CASE 2: Result# = 31#
         CASE 3: Result# = 59#
         CASE 4: Result# = 90#
         CASE 5: Result# = 120#
         CASE 6: Result# = 151#
         CASE 7: Result# = 181#
         CASE 8: Result# = 212#
         CASE 9: Result# = 243#
         CASE 10: Result# = 273#
         CASE 11: Result# = 304#
         CASE 12: Result# = 334#
      END SELECT
      Result# = Result# + CDBL(DayNr) - 1#
      IF Y MOD 4 = 0 AND (Y MOD 100 > 0 OR Y MOD 400 = 0) THEN
         IF MonthNr > 2 THEN Result# = Result# + 1#
      END IF
      DO UNTIL Y <= 1753
         Y = Y - 1
         IF Y MOD 4 = 0 AND (Y MOD 100 > 0 OR Y MOD 400 = 0) THEN
            Result# = Result# + 1#
         END IF
         Result# = Result# + 365#
      LOOP
   END IF
   DateSerial# = Result# - 53688#
END FUNCTION
