
rem
rem BUTTONS!!!!
rem
rem This program creates and utilizes buttons in BasicBasic.  While the
rem buttons it creates are used for an unusual purpose, the programming
rem methods shown will be useful to any button program.  This program
rem works the same under DOS or Windows.
rem


    rem
    rem  make windows window my size and give it a name
    rem

    rem windows size 29,9,45,15
    rem windows name "Button Move"

    cls

    rem
    rem if no mouse this doesn't run
    rem
    a=mouseon
    if a<>-1 then
      beep
      print "Mouse required to run this program."
      stop
    end if


    rem
    rem some general inits
    rem
    buttonfore=7
    buttonback=4
    borderfore=7
    borderback=1 
    boardtop=10
    boardleft=30
    topy=3
    topx=3
    maxbuttons=8
    totalx= (boardleft+(topx+2)*3)-(boardleft-1)+1

    dim board(topx+1,topy+1)   : rem keeps pointer to text for button
    dim boardc(topx+1,topy+1)  : rem keeps button foreground color
    dim text$(maxbuttons)      : rem keeps text

    rem
    rem define text
    rem
    text$(0)="Bas"
    text$(1)="ic "
    text$(2)="is "
    text$(3)="you"
    text$(4)="r b"
    text$(5)="est"
    text$(6)="val"
    text$(7)="ue "




      rem
      rem flag border as occupied
      rem

      for x=0 to topx+1
         board(x,0)=1
         board(x,topy+1)=1
      next x
      for y=0 to topy+1
         board(0,y)=1
         board(topx+1,y)=1
      next y


      rem
      rem place my buttons on board
      rem

         rem
         rem first skip randomly into random number generator using
         rem  seconds of clock
         rem
         t$=time$
         t=val(right$(t$,2))
         for i=1 to t
             x=rnd
         next i

      for i=59 to 66
        place10:
              x=int(rnd*3)+1
              y=int(rnd*3)+1
              if board(x,y)<>0 then goto place10
              board(x,y)=i
      next i


      rem
      rem place button colors
      rem
      boardc(1,1)=0
      boardc(1,2)=4
      boardc(1,3)=5
      boardc(2,1)=6
      boardc(2,2)=0
      boardc(2,3)=4
      boardc(3,1)=5
      boardc(3,2)=6
      boardc(3,3)=0


    rem
    rem
    rem  color background
    rem
    color borderfore,borderback
      for y=boardtop-1 to boardtop+topy+2
         locate y,boardleft-1,0
         print space$(totalx);
      next y


    rem
    rem display exit and help buttons
    rem
           CBUTTON "Exit",1068,0,"Push",0,boardleft+(topy*3)+1,boardtop-1,6,1,buttonfore,4
           CBUTTON "Help",1067,0,"Push",0,boardleft-1,boardtop-1,6,1,buttonfore,4


    rem
    rem display buttons of puzzle.
    rem

    for x=1 to topx
      for y=1 to topy
         num=board(x,y)
         if num<>0 then
           CBUTTON text$(num-59),num+1000,0,"Push",0,(x*3)+boardleft,y+boardtop,3,1,buttonfore,boardc(x,y)
         end if
      next y
    next x


rem
rem start of main program input loop
rem

100
    a$=inkey$
    if a$="" then goto 100
    if len(a$)=1 then goto 100

    rem
    rem get here if extended keycode returned
    rem
    num=asc(right$(a$,1))

    if num=68 then
      rem
      rem 1068 is what we defined our exit button to be
      rem
      stop

    elseif num=67 then
      rem
      rem help button pressed if here
      rem
      a$="Basic is your best value"
      ll=len(a$)
      a$=space$(totalx-1)+a$
      ll=len(a$)
      color borderfore,borderback
      for i=1 to ll
         locate boardtop+5,boardleft-1,0
         b$=left$(a$,totalx)
         print b$;
         l=len(a$)
         a$=right$(a$,l-1)+" "
         t=timer
       t100:
         if timer-t<.05 then goto t100
      next i
      locate boardtop+5,boardleft-1,0
      print space$(11);
      goto 100

    end if

    if num<59 or num>66 then goto 100

    rem
    rem If we get here then one of our puzzle buttons pressed
    rem
    rem button keycode selected is in num
    rem find which square contains this button
    rem
      bx=0
      by=0
      for x=1 to topx
         for y=1 to topy
           if board(x,y)=num then bx=x:by=y
         next y
      next x
      if bx=0 then beep:goto 100: rem oops, something wrong if can't find key

      rem
      rem see if adjacent square is empty
      rem
      for x=-1 to 1 step 1
         for y=-1 to 1 step 1
           if abs(x)<>abs(y) then
             if board(bx+x,by+y)=0 then goto gotempty
           end if
         next y
      next x

      beep     : rem no empty square around this one
      goto 100


rem
rem have empty square move to it
rem

gotempty:

  dbutton num+1000
  board(bx,by)=0
  board(bx+x,by+y)=num
  newx=(bx+x)*3
  newy=(by+y)
  CBUTTON text$(num-59),num+1000,0,"Push",0,newx+boardleft,newy+boardtop,3,1,buttonfore,boardc(bx+x,by+y)

     goto 100

