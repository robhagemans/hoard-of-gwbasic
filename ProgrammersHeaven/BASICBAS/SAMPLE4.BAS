
rem
rem Now let's use one of BasicBasic's more advanced features.
rem
rem If you don't have a mouse use F10 to access the menu.
rem
rem This program is a simple example of using menu's.
rem
rem In this case we display the current time and the user can select
rem the color of the background using a menu.  The current color
rem will be 'grayed' so it cannot be selected.
rem


  y=mouseon

  rem
  rem define my menu bar at top of screen
  rem
  mainmenu "&Color","","","","",""

  rem
  rem define menu items
  rem
  rem  the '&' symbol tells windows what keyboard shortcut will select this
  addsubmenu 1,"&Black",1059
  addsubmenu 1,"&Red",1060
  addsubmenu 1,"&Blue",1061
  addsubmenu 1,"",0
  addsubmenu 1,"&Quit",1062

  bcolor=1
  color 7,bcolor
  cls

  rem
  rem gray menu option for current color
  rem
  menuitemgray 1061

100

  rem
  rem get and display time
  rem
  t$=time$
  if t$<>oldt$ then
    oldt$=t$
    locate 12,35,0
    print t$;
  end if
  a$=inkey$
  if a$="" then goto 100


  rem
  rem Come here if key pressed.  If menu item is selected it will look like
  rem a key pressed!
  rem

  if len(a$)=1 then goto 100

  if right$(a$,1)=chr$(59) then
    rem
    rem change to black
    rem
    menuitemon 1060
    menuitemon 1061
    menuitemgray 1059
    bcolor=0
    color 7,bcolor
    cls
    oldt$=""

  elseif right$(a$,1)=chr$(60) then
    rem
    rem change to red
    rem
    menuitemon 1059
    menuitemon 1061
    menuitemgray 1060
    bcolor=4
    color 7,bcolor
    cls
    oldt$=""

  elseif right$(a$,1)=chr$(61) then
    rem
    rem change to white
    rem
    menuitemon 1059
    menuitemon 1060
    menuitemgray 1061
    bcolor=1
    color 7,bcolor
    cls
    oldt$=""

  elseif right$(a$,1)=chr$(62) then

    color 15,0
    cls
    stop

  end if

  goto 100




