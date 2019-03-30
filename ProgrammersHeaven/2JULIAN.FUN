'PowerBASIC function to convert a Date to a Julian number
'CopyRight 1991 by Dave Navarro, Jr.
'Last Revision: June 3, 1991

'Julian - Returns a julian number for a given date

FUNCTION Julian&(Dat$) PUBLIC
  Mmonth%=VAL(LEFT$(Dat$,2))
  IF Mmonth%<3 THEN
     mx%=1
   ELSE
     mx%=0
  END IF
  Mday%=VAL(MID$(Dat$,4,2))
  Myear%=VAL(MID$(Dat$,7))
  IF Myear%<100 THEN INCR MYear%,1900
  Mc&=INT((Myear%-Mx%)/100)
  Ma&=INT(365.25*(Myear%-Mx%))
  Ma&=INT(Ma&-(.75*Mc&))
  Mc&=INT(367*(((Mmonth%-2)/12)+Mx%))
  Julian&=Mday%+Ma&+Mc&
END FUNCTION

