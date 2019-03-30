

     rem
     rem This program demonstrates the use of memory bitmaps.
     rem
     rem It prompts for the name of a bitmap file, reads in the file
     rem and then, using memory bitmaps for speed, moves a 'window'
     rem around the picture
     rem

     if ostype<>2 then
       print "Program designed for Windows only..."
       stop
     end if


     dim a&(256)
     maxcolor=system(17)
     screen 1000,maxcolor

     rem
     rem since we are going to store the picture in a memory bitmap
     rem it is more efficient if we do our own repainting
     rem
     on paint gosub 1000

     rem
     rem get the name of the file to display
     rem
     a$="text"+chr$(0)+"*.bmp"+chr$(0)+chr$(0)
     openfileread a$,"marble","","Load a Picture"

     a$=dialog$(102)
     if a$<>"1" then stop

     rem
     rem get here if legal file selected
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
     rem change our palette to have same colors as files
     rem
     rem (except windows in 16 color mode doesn't allow palette changes)
     rem
     if maxcolor>16 then
       a=bitmapc(ffname$,a&(0))
       if colors>236 then
	 for i=10 to 245
	   palette i,a&(i)
	 next i
       else
	for i=0 to colors
	 palette i,a&(i)
	next i
       end if
     end if

     rem
     rem create a bitmap to hold entire image
     rem
     createbitmap 1,0,pxsize,pysize


     rem
     rem select my memory bitmap and load it in
     rem
     selectbitmap 1
     loadbitmap sd$+ffname$,0,x,y,0,0,pxsize,pysize,0,xmult,ymult

     rem
     rem select screen as my output
     rem
     selectbitmap 0

     rem
     rem select a subset of memory image to display
     rem

     dx=0
     dy=0
     hx=pxsize/2
     hy=pysize/2
     dx=pxsize-hx
     dy=pysize-hy
     sy=0
     xoff=1
     yoff=1

     rem
     rem make my window size of picture to display
     rem
     position 1,1,dx-1,dy-1

     rem
     rem loop and display a portion of picture
     rem
50
     copybits 1,sx,sy,dx,dy,0,0,0,0

     rem
     rem delay for a while
     rem
     t=timer
75
     if timer-t<.1 then goto 75


     rem
     rem randomly move x and/or y direction
     rem
     i=int(rnd*10)
     if i>4 then
       if xoff>0 then
	 sx=sx+1
       else
	 sx=sx-1
       end if
       if sx<0 then
	 sx=1
	 xoff=1
       end if
       if sx>pxsize-hx then
	 sx=pxsize-hx
	 xoff=0
       end if
       goto 50
     else
       if yoff>0 then
	 sy=sy+1
       else
	 sy=sy-1
       end if
       if sy<0 then
	 sy=1
	 yoff=1
       end if
       if sy>pysize-hy then
	 sy=pysize-hy
	 yoff=0
       end if
       goto 50

     end if
     goto 50



rem
rem Since I update the screen often, I will do nothing in repaint.
rem

1000
     return


