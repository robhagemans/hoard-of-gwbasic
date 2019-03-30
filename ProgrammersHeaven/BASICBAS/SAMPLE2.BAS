
rem
rem This program displays the amount of memory available.
rem
rem Under windows the WINDOWS SIZE command sizes the window
rem

  rem windows size 35,13,47,18


rem
rem set where to display on screen
rem
  basey=12
  basex=34


  cls


  ot=0
100

rem
rem if any key pressed stop
rem
  a$=inkey$
  if a$<>"" then stop


rem
rem display free memory
rem
  t=freemem
  if t<>ot then
    color 0,7
    locate basey+1,basex+2
    print freemem
    ot=t
  end if

rem
rem add some random sparkle
rem

200
  x=rnd
  x=int(x*13)
  y=rnd
  y=int(y*5)
  x=x+1
  y=y+1
  if y=1 and (x>2 or x<11) then goto 200
  c=rnd
  c=int(c*16)
  color c,0
  locate basey+y,basex+x
  print chr$(219);
  goto 100


