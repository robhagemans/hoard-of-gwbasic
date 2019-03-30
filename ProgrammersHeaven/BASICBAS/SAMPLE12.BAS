
rem
rem This program works under either DOS or Windows.
rem
rem It uses a standard file input dialog box to get the name of a file
rem to load and display on the screen.  It also allows the picture displayed
rem to be stored back to disk; either in regular or compressed format
rem



   REM windows name "Picture Loader"

     cls

      scolor=0
      screen 1000,scolor


  rem
  rem make array to hold bitmap info
  rem
      dim a&(256)


  rem
  rem enable mouse
  rem
     y=mouseon

  rem
  rem define my menu bar at top of screen
  rem
  mainmenu "File","","","","",""

  rem
  rem define menu items
  rem
  rem  the '&' symbol tells windows what keyboard shortcut will select this
  addsubmenu 1,"&Read",1059
  addsubmenu 1,"&Write",1060
  addsubmenu 1,"&Compressed Write",1061
  addsubmenu 1,"&Quit",1062
  menuitemgray 1060             : rem gray this item until something read
  menuitemgray 1061

100

   a$=inkey$
   if a$="" or len(a$)=1 then goto 100
   if a$=chr$(0)+chr$(62) then
     stop

   elseif a$=chr$(0)+chr$(59) then
     rem come here to read a file
     a$="text"+chr$(0)+"*.bmp"+chr$(0)+chr$(0)
     openfileread a$,"","","Load a Picture"


     rem
     rem dialog$(102) will be "1" if legal file name found
     rem

     if dialog$(102)="1" then



       rem
       rem Get File Name user has selected
       rem

       ffname$=dialog$(100)

       rem
       rem read bitmap header and get info on it
       rem
       a=bitmaph(ffname$,a&(0))
       x=0
       y=0
       pxsize=a&(1)
       pysize=a&(2)
       colors=a&(4)
       if colors=1 or colors=2 then
	 colors=1
       elseif colors=4 then
	 colors=16
       else
	 colors=256
       end if

       rem
       rem Now select palette resolution required to reproduce bitmap
       rem
       rem If you are going to do a STOREBITMAP after loading the bitmap
       rem you should usually define a palette the same as the resolution
       rem of the picture you are loading.  This is expecially true if you
       rem tell BasicBasic to convert colors on loading.  BasicBasic may
       rem use all palette entries available, thereby increasing the number
       rem of palette entries required to show the picture.
       rem
       rem Also, note, that Windows in standard VGA (16 color) does not allow
       rem palette changes.
       rem

       maxcolor=system(17)
       if colors>maxcolor then colors=maxcolor
       screen 1000,colors


       rem
       rem only if in Windows load colors from bitmap
       rem

       if ostype=2 and maxcolor>16 then
	 a=bitmapc(ffname$,a&(0))
	 if colors>236 then
	  for i=10 to 246
	    palette i,a&(i)
	  next i
	 else
	  for i=0 to colors
	   palette i,a&(i)
	  next i
	 end if
       end if

       rem
       rem if a small picture blow it up
       rem
       if pxsize<25 then
	 xmult=4
       elseif pxsize<50 then
	 xmult=2
       else
	 xmult=1
       end if

       if pysize<25 then
	 ymult=4
       elseif pysize<50 then
	 ymult=2
       else
	 ymult=1
       end if

       rem
       rem Set to always convert to closest color possible
       rem
       convert=0

       loadbitmap ffname$,0,x,y,0,0,pxsize,pysize,convert,xmult,ymult


       menuitemon 1060
       menuitemon 1061

     end if

   else if a$=chr$(0)+chr$(60) or a$=chr$(0)+chr$(61)

     if a$=chr$(0)+chr$(60) then
       smes$="Save Picture"
       compress=0
     else
       smes$="Save Picture Compressed"
       compress=1
     end if

     rem
     rem get name of file to save to
     rem
     a$="text"+chr$(0)+"*.bmp"+chr$(0)+chr$(0)
     openfilesave a$,"","",smes$


     if dialog$(102)="1" then

       rem
       rem if ok button "1" then store bitmap
       rem

       ffname$=dialog$(100)
       storebitmap 0,ffname$,0,0,pxsize,pysize,compress,0

     end if
   end if

   goto 100




