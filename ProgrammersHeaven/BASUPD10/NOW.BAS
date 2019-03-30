'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
'   |                                                                      |
'   |            See BASUPD.DOC for info on distribution policy            |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DECLARE FUNCTION DateSerial# (YearNr%, MonthNr%, DayNr%)
   DECLARE FUNCTION TimeSerial# (HourNr%, MinuteNr%, SecondNr%)

   DEFINT A-Z

FUNCTION Now#
   d$ = DATE$
   t$ = TIME$
   y = CINT(VAL(RIGHT$(d$, 4)))
   m = CINT(VAL(LEFT$(d$, 2)))
   d = CINT(VAL(MID$(d$, 3, 2)))
   hr = CINT(VAL(LEFT$(t$, 2)))
   mi = CINT(VAL(MID$(t$, 3, 2)))
   se = CINT(VAL(MID$(t$, 7, 2)))
   Now# = DateSerial#(y, m, d) + TimeSerial#(hr, mi, se)
END FUNCTION
