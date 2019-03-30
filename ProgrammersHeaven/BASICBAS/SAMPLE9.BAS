

    rem
    rem THIS PROGRAM DEMONSTRATES THE USE OF INVISIBLE BUTTONS
    rem
    rem If a mouse is present invisible buttons are used to direct
    rem the program to the right area of code.
    rem
    rem If a mouse is not present invisible buttons are used to allow the
    rem up and down arrow to be used to direct the program.
    rem
    rem This program works the same under DOS or Windows.
    rem

    fc=7
    bc=1
    color fc,bc
    cls
    x=mouseon


    IF X<>0 THEN
      rem
      rem Come here if we have a mouse
      rem Define 2 areas as invisible buttons.  These buttons are centered
      rem over two areas of the screen we are using as input areas.
      rem INPUT statements are terminated when a button is pushed.
      rem Then we do an INKEY$ function to get button keycode.
      rem
      CBUTTON "Input 1",1059,0,"Invisible",0,30,5,20,1,7,1
      CBUTTON "Input 2",1060,0,"Invisible",0,30,7,20,1,7,4
      cbutton "input 3",1061,0,"Invisible",0,30,9,20,1,7,1
      CBUTTON "EXIT",1068,0,"PUSH",0,60,14,8,3,7,4

    ELSE
      rem
      rem Come here if we have no mouse
      rem We are defining invisible buttons using the keycodes for
      rem up/down arrow.  This will allow these keys to terminate
      rem an INPUT statement.
      rem
      CBUTTON "UP ARROW",1072,0,"INVISIBLE",0,0,0,0,0,0,0
      cbutton "DOWN ARROW",1080,0,"INVISIBLE",0,0,0,0,0,0,0
      CBUTTON "F10-EXIT",1068,0,"PUSH",0,60,14,10,3,7,1

    END IF


50
    rem
    rem layout screen
    rem

    locate 2,21
    color fc+8,bc
    print "Invisible Button Demonstration Program";
    color fc,bc
    locate 5,19
    print "      Name: ";
    locate 5,30
'    color bc,fc
    print space$(20);
    locate 7,19
    color fc,bc
    print "   Address: ";
    locate 7,30
    color bc,fc
    print space$(20);
    color fc,bc



rem
rem Get input for name
rem

100
    locate 5,30
'    color bc,fc
    savename$=name$
    input "", name$
    if name$="" then name$=savename$
    locate 5,30
    l=len(name$)
    if l<20 then
      name$=name$+space$(20-l)
    end if
    print name$;
    color fc,bc

    rem
    rem check for any buttons (invisible or otherwise)
    rem
    a$=inkey$
    if len(a$)>1 then
      a=asc(right$(a$,1))
      if a=59 or a=72 then goto 100
      if a=60 or a=80 then goto 200
      stop
    end if



rem
rem get input for address
rem

200
    locate 7,30
    color bc,fc
    saveaddress$=address$
    input "", address$
    if address$="" then address$=saveaddress$
    locate 7,30
    l=len(address$)
    if l<20 then
      address$=address$+space$(20-l)
    end if
    print address$;
    color fc,bc
    a$=inkey$
    if len(a$)>1 then
      a=asc(right$(a$,1))
      if a=59 or a=72 then goto 100
      if a=60 or a=80 then goto 200
      stop
    end if
    goto 100



