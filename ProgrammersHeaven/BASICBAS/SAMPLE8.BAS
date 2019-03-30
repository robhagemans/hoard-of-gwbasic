

rem
rem Demonstration of graphics mode and mouse usage.
rem


rem
rem Go into graphics mode and find out how big window is
rem

    screen 1000
    maxx=system(10)-1
    maxy=system(11)-1


rem
rem turn mouse on
rem

    a=mouseon
    if a=0 then
      print "This program requires a mouse."
      input z
      stop
    end if


rem
rem loop and look for buttons
rem
rem  If left button pressed, color pixel where we are.
rem  If right button pressed, set pixel where we are to background color
rem

100

     if inkey$<>"" then stop

     x=mousex
     y=mousey
     b=mouseb

     right=b and 1
     if right>0 then
         pset (x,y)
         goto 100
     end if

     left=b and 2
     if left>0 then
       preset (x,y)
       goto 100
     end if

     goto 100



