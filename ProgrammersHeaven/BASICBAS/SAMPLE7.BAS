

rem
rem This program demonstrates some simple graphics techniques
rem
rem This program runs under DOS or Windows
rem
rem


  rem
  rem place to store graphics figures with GET statement
  rem

  dim figure(100)


  rem
  rem go into graphics mode
  rem

  seterrlevel 5
  err=0
  screen 12
  if err>0 then
    screen 2
    if err>0 then
      print "Graphics mode not available."
    end if
  end if
  seterrlevel 7


  rem
  rem Set some variables
  rem

   firstbit=1
   charxsize=font(7)
   charysize=font(1)

   topy=system(2)
   topx=system(1)

   topcolor=15






  rem
  REM
  REM LAYOUT SCREEN
  REM
  CLS

  line (0,0)-(topx-1,charysize*5+2),4,bf






         rem
         rem circle demo
         rem

         gosub cleararea
         x=topx/2
         y=(topy+(charysize*6))/2
         circle (x,y),topx/6,topcolor
         gosub delay
         paint (x,y),1,topcolor




         rem
         rem square demo
         rem

         gosub cleararea
         for i%=1 to 10
            x1=int(200*rnd)
            x1=x1+topx/2-100
            y1=int(100*rnd)
            y1=y1+(topy+(charysize*6))/2-50
            x2=int(200*rnd)
            x2=x2+topx/2-100
            y2=int(100*rnd)
            y2=y2+(topy+(charysize*6))/2-50
            c=int(15*rnd)
            if i%=3 or i%=5 then
              line (x1,y1)-(x2,y2),c,BF
            else
              line (x1,y1)-(x2,y2),c,B
            end if
         next i%






         rem
         rem pie demo
         rem It is the CIRCLE command that supports drawing of pie shaped areas
         rem

         gosub cleararea
         x=topx/2
         y=(topy+(charysize*6))/2
         circle (x,y),topx/6,topcolor,-1,-3
         gosub delay
         paint (x-4,y-4),1,topcolor
         gosub delay
         circle (x,y),topx/6,topcolor,-3,-5
         gosub delay
         paint (x-12,y+2),4,topcolor
         gosub delay
         circle (x,y),topx/6,topcolor,-5,-1
         gosub delay
         paint (x+12,y+5),2,topcolor



         rem
         rem line demo
         rem

         gosub cleararea
         for i%=1 to 300
            x1=int(200*rnd)
            x1=x1+topx/2-100
            y1=int(100*rnd)
            y1=y1+(topy+(charysize*6))/2-50
            x2=int(200*rnd)
            x2=x2+topx/2-100
            y2=int(100*rnd)
            y2=y2+(topy+(charysize*6))/2-50
            c=int(15*rnd)
            line (x1,y1)-(x2,y2),c
         next i%




         rem
         rem dot demo
         rem

         gosub cleararea
         for i%=1 to 300
            x=int(200*rnd)
            x=x+topx/2-100
            y=int(100*rnd)
            y=y+(topy+(charysize*6))/2-50
            c=int(15*rnd)
            pset (x,y),c
         next i%


         rem
         rem motion demo
         rem
         gosub cleararea
         x=topx/2
         y=(topy+(charysize*6))/2
         circle (x,y),10,topcolor
         circle (x,y),4,topcolor-1
         get (x-10,y-10)-(x+10,y+10),figure(0)
         gosub cleararea
         for ix=0 to topx step 10
           line (ix,charysize*7)-(ix,topy),topcolor
         next ix
         oldix=9999
         for ix=0 to topx-20 step 2
           put (ix,y),figure(0),XOR
           if oldix<9999 then
             put (oldix,y),figure,XOR
           end if
           oldix=ix
           for i=1 to 30:next i
         next ix

cls
stop




rem
rem delay 1/2 second
rem

delay:
     t=timer
delay5:
     if timer-t<.5 then goto delay5
     return




rem
rem erase display area
rem

cleararea:

     by=charysize*6
     line (0,by)-(topx,topy),0,bf
     return

