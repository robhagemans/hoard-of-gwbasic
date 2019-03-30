

rem
rem This program is for WINDOWS use only.
rem
rem This program displays a digital clock, using a large font. For people
rem with a pathological aversion to being late this clock allows you to
rem 'offset' the time by some number of minutes.
rem
rem Startup position and our time offset our saved to a startup file
rem so we will always start up correctly.
rem
rem We use the POSITION command to size our window.
rem We use the CREATEFONT command to make our font.  Our requirements are
rem    that it be 60 pixels high.
rem
rem We are going to let BasicBasic to repaint screen where necessary.
rem

   rem windows size 30,9,50,11

   REM windows name "Mark's Clock"

   screen 1000
   mode=system(7)

   createfont 1,60,0,0,0,0,0,0,0,0,0,0,0,0,"Arial"
   createfont 2,14,0,0,0,0,0,0,0,0,0,0,0,0,""
   selectfont 1
   xsize=dlen("00:00:00")
   rem
   rem See if we have written out initialization parameters
   rem
   l=len(dir$("marks.stu"))
   if l>0 then
    open "marks.stu" for input as #1
    input #1,leftx,topy,offset
    close #1
   else
    leftx=0
    topy=0
   end if

   rem
   rem size window
   rem

   position leftx,topy,xsize+1-(xsize/9),60


   rem
   rem make background red
   rem

   line (0,0)-(xsize+1-(xsize/9),60),4,bf
   color 7,4 : rem this command would not be so flexible if we were
                rem in another graphics mode (e.g. 8).


   gosub makebuttons
   mouseflag=mouseon


   t$=""
   quartersec=5


rem
rem Now we enter a perpetual loop to update time
rem

100
   tt$=time$

   if left$(tt$,5)<>t$ then
     t$=left$(tt$,5)
     gosub drawhourmin
   end if

   sec=val(right$(tt$,2))
   sec=int(sec/15)
   if sec<>quartersec then
     if quartersec=5 then
       for quartersec=0 to sec
          gosub drawsec
       next quartersec
     else
       quartersec=sec
       gosub drawsec
     end if
   end if

   rem
   rem check for button push
   rem
   a$=inkey$
   if len(a$)>1 then
    if asc(right$(a$,1))=59 or asc(right$(a$,1))=60 then
     rem + pushed
     if asc(right$(a$,1))=59 then
       offset=offset+1
       if offset>30 then offset=30
     else
       offset=offset-1
       if offset<-30 then offset=-30
     end if
     ix=xsize-((xsize/8)*2)
     iy=40
     ix=ix-10
     iy=iy-10
     line (ix,iy)-(ix+20,iy+20),4,BF
     selectfont 2
     locate iy,ix
     print str$(offset);
     selectfont 1
     gosub drawhourmin
     open "marks.stu" for output as #1
     print #1, x,y,offset
     close #1
    end if
   end if
   goto 100



rem
rem routine to draw hour/min
rem
rem on input tt$ has 5 chars for hour/min
rem

drawhourmin:

   ttt$=left$(tt$,5)
   if offset<>0 then
     h=val(left$(ttt$,2))
     m=val(right$(ttt$,2))
     m=m+offset
     if m>59 then
       m=m-60
       h=h+1
       if h=24 then h=0
     elseif m<0 then
       m=m+60
       h=h-1
       if h<0 then h=23
     end if
     m$=str$(m)
     l=len(m$)
     m$=right$(m$,l-1)

     if len(m$)<2 then m$="0"+m$
     if len(m$)>2 then m$=right$(m$,2)
     h$=str$(h)
     l=len(h$)
     h$=right$(h$,l-1)
     if len(h$)<2 then h$="0"+h$
     if len(h$)>2 then h$=right$(h$,2)
     ttt$=h$+":"+m$
   end if
   locate 0,0
   print ttt$;
   return


rem
rem draw second
rem
rem quartersec  has 1/4 min
rem

drawsec:

     x=xsize-((xsize/8)*2)
     y=40
     if quartersec=0 then
       circle (x,y),10,12
       paint (x,y),12
       circle (x,y),10,7,-.01,-3.1416/2
       paint (x+2,y-2),7
     elseif quartersec=1 then
       circle (x,y),10,6,-4.7124,-.01
       paint (x+2,y+2),6
     elseif quartersec=2 then
       circle (x,y),10,5,-3.1416,-4.7124
       paint (x-2,y+2),5
     elseif quartersec=3 then
       circle (x,y),10,3,-3.1416/2,-3.1416
       paint (x-2,y-2),3
       gosub checkposition
     end if
     return



rem
rem check and see if window position has changed.  If so write new
rem position to my initialization file
rem

checkposition:
    x=system(8)
    y=system(9)
    if x<>leftx or y<>topy then
      open "marks.stu" for output as #1
      print #1, x,y,offset
      close #1
    end if
    return




makebuttons:
   rem
   rem define buttons
   rem

     px=xsize-((xsize/8)*3)+4
     py=10
     CBUTTON "+",1059,0,"Push",0,px+5,py,16,14,7,1
     cbutton "-",1060,0,"Push",0,px+25,py,16,14,7,1
     return

