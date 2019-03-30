
rem
rem Here is a demonstration of buttons that does not require Windows
rem
rem Dumb terminal program
rem


  rem
  rem is there mouse
  rem
  mouseflag=mouseon


  rem
  REM
  REM LAYOUT SCREEN
  REM
  CLS

  rem
  rem make red bar at top
  rem
  color 7,4
  locate 1,1
  print space$(80);
  locate 2,1
  print space$(80);
  locate 3,1
  print space$(80);

  if mouseflag<>0 then

    rem
    rem make my push buttons
    rem
    CBUTTON "Exit",1068,0,"Push",0,1,1,8,3,7,1
    CBUTTON "Hangup",1059,0,"Push",0,71,1,10,3,7,1

    rem
    rem make and turn on correct radio buttons
    rem
    cbutton " Full Duplex",1060,0,"Radio",0,12,1,13,1,7,4
    cbutton " Half Duplex",1061,0,"Radio",0,12,2,13,1,7,4
    Radioon 1061
    cbutton " 8 data bits",1062,0,"Radio",0,27,1,13,1,7,4
    cbutton " 7 data bits",1063,0,"Radio",0,27,2,13,1,7,4
    Radioon 1062
    cbutton " 2400 baud",1064,0,"Radio",0,42,1,12,1,7,4
    cbutton " 1200 baud",1065,0,"Radio",0,42,2,12,1,7,4
    cbutton " 300 baud",1066,0,"Radio",0,42,3,12,1,7,4
    Radioon 1065

  else

    rem
    rem make my push buttons
    rem
    CBUTTON "F10-Exit",1068,0,"Push",0,1,1,10,3,7,4
    CBUTTON "F1-Hangup",1059,0,"Push",0,68,1,13,3,7,4

    rem
    rem make and turn on correct radio buttons
    rem
    cbutton " F2-Full",1060,0,"Radio",0,12,1,13,1,7,4
    cbutton " F3-Half",1061,0,"Radio",0,12,3,13,1,7,4
    Radioon 1061
    cbutton " F4-8 data",1062,0,"Radio",0,27,1,13,1,7,4
    cbutton " F5-7 data",1063,0,"Radio",0,27,2,13,1,7,4
    Radioon 1062
    cbutton " F6-2400",1064,0,"Radio",0,42,1,12,1,7,4
    cbutton " F7-1200",1065,0,"Radio",0,42,2,12,1,7,4
    cbutton " F8-300",1066,0,"Radio",0,42,3,12,1,7,4
    Radioon 1065
  end if

  rem
  rem default states
  rem
  fullhalf=1061
  bits$="8,"
  parity$="N,"
  speed$="1200,"
  stop$="1,"

  rem
  rem define scrollable area (so it doesn't scroll buttons)
  rem
  scrollarea 1,4,80,25
  color 7,0
  locate 4,1


  rem
  rem open communications port
  rem
   open "com2:"+speed$+parity$+bits$+stop$ for random as #1 len=2048

   rem
   rem misc.
   rem
   lf$=chr$(10)

100

rem
rem get input from communications port
rem
rem
rem Strip out LF characters
rem

  t = LOC(1)
  IF t > 0 THEN
    a$=input$(t,1)
    if len(a$)>0 then
nocr:
      if lastchar$=chr$(13)
        l=len(a$)
        t=instr(a$,lf$)
        if t>0 then
         if l>1 then
          a$=left$(a$,t-1)+right$(a$,l-t)
          goto nocr
         else
          goto 100
         end if
        end if
     end if
     PRINT a$;
     lastchar$=a$
    ELSE

      rem come here if some kind of comm error
    end if


  END IF



rem
rem get input from keyboard
rem

  b$ = INKEY$


  IF b$ <> "" THEN

    rem
    rem look for function keys
    rem

    if len(b$)>1 then

      if asc(right$(b$,1))=68 then

         rem
         rem F10 exit
         rem
         close #1
         stop

      elseif asc(right$(b$,1))=59 then

         rem
         rem F1- Hangup
         rem
         beep             :rem positive sign button was pushed
         print #1,"+++";
         for t=0 to 4000
         next t
         print #1,"ATH";chr$(13);

      elseif asc(right$(b$,1))=60 then
         rem
         rem make full duplex
         rem
         fullhalf=0
         Radiooff 1061
         Radioon 1060

      elseif asc(right$(b$,1))=61 then
         rem
         rem make half duplex
         rem
         fullhalf=1
         Radiooff 1060
         Radioon 1061

      elseif asc(right$(b$,1))=62 then
         rem
         rem make 8 data bits
         rem
         bits$="8,"
         parity$="N,"
         stop$="1,"
         Radiooff 1063
         Radioon 1062
         setcom 1,","+parity$+bits$+stop$

      elseif asc(right$(b$,1))=63 then
         rem
         rem make 7 data bits
         rem
         bits$="7,"
         Parity$="E,"
         stop$="1,"
         Radiooff 1062
         Radioon 1063
         setcom 1,","+parity$+bits$+stop$

      elseif asc(right$(b$,1))=64 then
         rem
         rem make 2400 baud
         rem
         speed$="2400,"
         Radiooff 1065
         Radiooff 1066
         Radioon 1064
         setcom 1,speed$

      elseif asc(right$(b$,1))=65 then
         rem
         rem make 1200 baud
         rem
         speed$="1200,"
         Radiooff 1064
         Radiooff 1066
         Radioon 1065
         setcom 1,speed$

      elseif asc(right$(b$,1))=66 then
         rem
         rem make 300 baud
         rem
         speed$="300,"
         Radiooff 1064
         Radiooff 1065
         Radioon 1066
         setcom 1,speed$


      end if

      goto 100

    else

      if fullhalf=0 then
         print b$;
      end if
      PRINT #1, b$;

    end if

  END IF

  GOTO 100





