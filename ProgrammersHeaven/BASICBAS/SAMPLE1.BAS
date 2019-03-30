

rem
rem Example of Program to print HELLO on screen.
rem
rem This program has waits for input before stopping.
rem We are waiting for input because in Windows, when program stops
rem the window is erased and we couldn't see the Hello.
rem
rem This program uses a function unique to BasicBasic.  This is the
rem function OSTYPE.  This function returns a 1 if DOS or a 2 if running
rem under Windows.
rem



    print "Hello!"

    if ostype=1 then
      print
      print "Press any key to continue..."
    end if

    do while inkey$=""
    loop



