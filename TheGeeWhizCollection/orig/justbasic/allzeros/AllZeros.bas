' AllZeros - freeware game program by Tom McIntire 11-04-05

                  ' images
  loadbmp "rd0", "rd0.bmp" : loadbmp "rd1", "rd1.bmp" ' shapes=1
  loadbmp "rd2", "rd2.bmp" : loadbmp "rd3", "rd3.bmp"
  loadbmp "sq0", "sq0.bmp" : loadbmp "sq1", "sq1.bmp" ' shapes=2
  loadbmp "sq2", "sq2.bmp" : loadbmp "sq3", "sq3.bmp"
  loadbmp "tr0", "tr0.bmp" : loadbmp "tr1", "tr1.bmp" ' shapes=3
  loadbmp "tr2", "tr2.bmp" : loadbmp "tr3", "tr3.bmp"
  loadbmp "won", "won.bmp" : loadbmp "grades", "grades.bmp"
  loadbmp "rules", "rules.bmp" : loadbmp "about", "about.bmp"
  loadbmp "arrow", "arrow.bmp" : loadbmp "graybox", "graybox.bmp"
  loadbmp "shapes", "shapes.bmp" : loadbmp "sounds", "sounds.bmp"
  loadbmp "chkon", "chkon.bmp" : loadbmp "chkoff", "chkoff.bmp"
  loadbmp "p1", "pict1.bmp" : loadbmp "p2", "pict2.bmp"
  loadbmp "p3", "pict3.bmp" : loadbmp "p4", "pict4.bmp"
  loadbmp "p5", "pict5.bmp"

                  ' constants/literals
  music$="music.mid"
  dim grid$(9)
  grid$(0)="110001100311023331222302320122331112"
  grid$(1)="331112320122222302023331100311110001"
  grid$(2)="332011322201102300113330120301222011"
  grid$(3)="222011120301113330102300322201332011"
  grid$(4)="012220111230011333211132221322203332"
  grid$(5)="203332221322211132011333111230012220"
  grid$(6)="012220111230011333211132221322203332"
  grid$(7)="203332223322233302013003111233012223"
  grid$(8)="111322313332330310320111222310023330"
  grid$(9)="220100231113333133130023113222133320"
  dim g(6,6) ' grid values = 0-3

                  ' global variables
  grade=3    ' values = 1-5
  shapes=3   ' grid buttons type
  sound=0    ' 1=beep 2=click 4=music 8=won
  music=0    ' length of music.mid
  dm=0       ' do menu id's = 1-5
  won=0      ' flag 0/1
  count=0    ' clicks on grid
  oops=0     ' <0 rollovers
  undo$=""   ' x,y of each grid click
  play$=""   ' pointers into grid$

                  ' local variables
  i=0 : c=0
  hx=0     ' hold x
  hy=0     ' hold y

                  ' initialize
  open "AllZeros.ini" for random as #1 len=4
  field #1,1 as grade, 1 as shapes, 2 as sound
    while lof(#1)=0
      grade=3 : shapes=3 : sound = 0
      put #1,1
    wend : get #1,1
  for x=1 to 50
   c=rnd(1)*10 : play$=play$+chr$(c)
  next
  nomainwin
  UpperLeftX = 140  : UpperLeftY = 20
  WindowWidth = 370 : WindowHeight = 380
  menu #main, &Game,_
              &Undo, [undo],_
              &New, [new],_
              &Restart, [restart],_
              &Quit, [quit]
  menu #main, &Options,_
              &Grade, [grades],_
              &Shape, [shapes],_
              &Sound, [sounds]
  menu #main, &Help,_
              &Rules, [rules],_
              &About, [about]
  open "AllZeros" for graphics_nf_nsb as #main
  #main, "font arial black 16"
  #main, "setfocus"
  #main, "trapclose [quit]"
  #main, "when leftButtonDown [click]"
  if sound and 4 then playmidi music$, music
  goto [new]

                  ' mainline
[beep] if sound and 1 then beep
[ok] if dm then close #dm : dm=0
[loop] i=sound and 4
  while i
   if music then i=music<=midipos()
   if i then stopmidi : playmidi music$,music : i=0
  wend
  #main, "place 230 48"
  if dm=0 then #main, "|Clicks = "+str$(count)+"    "
  #main, "flush"
  if won then gosub [won] : goto [new]
  wait
[quit] if dm then close #dm : dm=0
  close #main
  put #1,1 : close #1
  if music then if sound and 4 then stopmidi
  unloadbmp "rd0" : unloadbmp "rd1"
  unloadbmp "rd2" : unloadbmp "rd3"
  unloadbmp "sq0" : unloadbmp "sq1"
  unloadbmp "sq2" : unloadbmp "sq3"
  unloadbmp "tr0" : unloadbmp "tr1"
  unloadbmp "tr2" : unloadbmp "tr3"
  unloadbmp "won" : unloadbmp "grades"
  unloadbmp "rules" : unloadbmp "about"
  unloadbmp "arrow" : unloadbmp "graybox"
  unloadbmp "shapes" : unloadbmp "sounds"
  unloadbmp "chkon" : unloadbmp "chkoff"
  unloadbmp "p1" : unloadbmp "p2"
  unloadbmp "p3" : unloadbmp "p4"
  unloadbmp "p5"
  end

                  ' grid play
[click]
  if MouseX<60 or MouseX>300 then [beep]
  if MouseY<80 or MouseY>320 then [beep]
  if dm then [ok]
  x=int((MouseX-20)/40) : y=int((MouseY-40)/40)
  while x*y>0 and x<7 and y<7
   if sound and 2 then playwave "click.wav", async
   undo$=chr$(x)+chr$(y)+undo$ 
   gosub [play] : count=count+1
   i=0 : for x=1 to 6 : for y=1 to 6 : i=i+g(x,y) : next : next
   x=0 : if i=0 then won=count
  wend
  goto [ok]

                  ' Game menu
[undo] if count<1 then [beep]
  if sound and 2 then playwave "click.wav", async
  count=count-1
  hx=asc(undo$) : undo$=mid$(undo$,2)
  hy=asc(undo$) : undo$=mid$(undo$,2)
  x=hx : y=hy : gosub [play]
  x=hx : y=hy : gosub [play]
  x=hx : y=hy : gosub [play]
  goto [loop]

[new]
  i=asc(play$) : play$=mid$(play$,2)+chr$(i)
  if i=asc(play$) then [new] ' repeat?
  game$=grid$(i) : i=grade
  if i=1 then #main, "drawbmp p1 0 0"
  if i=2 then #main, "drawbmp p2 0 0"
  if i=3 then #main, "drawbmp p3 0 0"
  if i=4 then #main, "drawbmp p4 0 0"
  if i=5 then #main, "drawbmp p5 0 0"
  gosub [game]
  gosub [page]
  goto [loop]

[restart]
  gosub [page]
  goto [loop]

                  ' Options menu
[grades]
  UpperLeftX = 200 : UpperLeftY = 120
  WindowWidth = 256 : WindowHeight = 266
  button #dm, " OK ", [ok], LR, 46, 20
  open "Grade" for graphics_nf_nsb as #dm : dm=3
  #dm, "when leftButtonDown [level]"
  #dm, "drawbmp grades 0 0"
[grades2] hy=grade*32-18
  #dm, "drawbmp arrow ";80;" ";hy
  #dm, "flush"
  goto [new]
[level] x=MouseX : y=MouseY
  if y<18 or y>206 then [grades2]
  if x<120 or x>230 then [grades2]
  if y<174 then grade=5
  if y<142 then grade=4
  if y<110 then grade=3
  if y<78 then grade=2
  if y<46 then grade=1
  #dm "drawbmp graybox ";80;" ";hy
  goto [grades2]

[shapes] if dm then close #dm
  UpperLeftX = 200 : UpperLeftY = 120
  WindowWidth = 256 : WindowHeight = 266
  bmpbutton #dm, "rd1.bmp", [shape1], UL, 20, 28
  bmpbutton #dm, "sq2.bmp", [shape2], UL, 20, 90
  bmpbutton #dm, "tr3.bmp", [shape3], UL, 20, 158
  open "Shape" for graphics_nf_nsb as #dm : dm=2
  #dm, "drawbmp shapes 0 0"
  #dm, "flush"
  goto [loop]
[shape1] shapes=1 : goto [shape0]
[shape2] shapes=2 : goto [shape0]
[shape3] shapes=3
[shape0] close #dm : dm=0
  gosub [game] : goto [new]

[sounds] if dm then close #dm
  UpperLeftX = 200 : UpperLeftY = 120
  WindowWidth = 256 : WindowHeight = 266
  button #dm, " OK ", [ok], LR, 46, 20
  open "Sound" for graphics_nf_nsb as #dm : dm=4
  #dm, "when leftButtonDown [sound?]"
  #dm, "drawbmp sounds 0 0"
[sound0] i=1
  for y=12 to 156 step 48
   if sound and i then
    #dm, "drawbmp chkon ";30;" ";y
   else
    #dm, "drawbmp chkoff ";30;" ";y
   end if
   i=i*2
  next
  #dm, "flush"
  goto [loop]
[sound?]
  x=MouseX<30 or MouseX>62 : y=MouseY
  if y>12 and y<44 then i=1   ' beep
  if y>60 and y<92 then i=2   ' click
  if y>108 and y<140 then i=4 ' music
  if y>156 and y<188 then i=8 ' won
  x=x or i=0
    if x*(sound and 1) then beep
    if x then [sound0]
    sound=sound xor i
    if i-4 then [sound0] else i=sound and 4
    if music*(i=0) then stopmidi : goto [sound0]
    playmidi music$, music
  goto [sound0]

                  ' Help menu
[rules] if dm then close #dm
  UpperLeftX = 200 : UpperLeftY = 120
  WindowWidth = 256 : WindowHeight = 266
  button #dm, " OK ", [ok], LR, 46, 20
  open "Rules" for graphics_nf_nsb as #dm : dm=1
  #dm, "drawbmp rules 0 0"
  #dm, "flush"
  goto [loop]

[about] if dm then close #dm
  UpperLeftX = 200 : UpperLeftY = 120
  WindowWidth = 256 : WindowHeight = 266
  button #dm, " OK ", [ok], LR, 46, 20
  open "About" for graphics_nf_nsb as #dm : dm=1
  #dm, "drawbmp about 0 0"
  #dm, "flush"
  goto [loop]

                  ' subroutines
[play]
  i=g(x,y)-1 : if i<0 then i=3 'center
  g(x,y)=i : gosub [show] : c=0
  if x>1 then                  'left of
    x=x-1 : i=g(x,y)-1 : if i<0 then i=3 : c=c or 1
    g(x,y)=i : gosub [show] : x=x+1
    end if
  if x<6 then                  'right of
    x=x+1 : i=g(x,y)-1 : if i<0 then i=3 : c=c or 1
    g(x,y)=i : gosub [show] : x=x-1
    end if
  if y>1 then                  'above
    y=y-1 : i=g(x,y)-1 : if i<0 then i=3 : c=c or 1
    g(x,y)=i : gosub [show] : y=y+1
    end if
  if y<6 then                  'below
    y=y+1 : i=g(x,y)-1 : if i<0 then i=3 : c=c or 1
    g(x,y)=i : gosub [show] : y=y-1
    end if
    oops=oops+c
  return

[game]
  i=1             ' load grid from game$
  for y=1 to 6 : for x=1 to 6
    g(x,y)=val(mid$(game$,i,1)) : i=i+1
  next : next
  i=grade         ' dink grid per grade
  for y=1 to 6 : for x=1 to 6 :c=g(x,y)
    if i=2 then if c=3 then c=1
    if i=3 then if c=1 then c=2
    if i=4 then if c>1 then c=c-1
    if i=5 then if c then c=2
    g(x,y)=c
  next : next
  for y=1 to 6 : for x=1 to 6 : i=grade
    if i=4 and x=4 and y=4 then gosub [bump]
    if i=5 and x=y then gosub [bump]
  next : next
  game$=""       ' rebuild game$ 
  for y=1 to 6 : for x=1 to 6
    game$=game$+str$(g(x,y))
  next : next
  return

[bump]
  i=g(x,y)-1 : if i<0 then i=3 'center
  g(x,y)=i
  if x>1 then                  'left of
    x=x-1 : i=g(x,y)-1 : if i<0 then i=3
    g(x,y)=i : x=x+1
    end if
  if x<6 then                  'right of
    x=x+1 : i=g(x,y)-1 : if i<0 then i=3
    g(x,y)=i : x=x-1
    end if
  if y>1 then                  'above
    y=y-1 : i=g(x,y)-1 : if i<0 then i=3
    g(x,y)=i : y=y+1
    end if
  if y<6 then                  'below
    y=y+1 : i=g(x,y)-1 : if i<0 then i=3
    g(x,y)=i : y=y-1
    end if
  return

[page]
  i=1 : count=0 : won=0 : oops = 0 : undo$=""
  for y=1 to 6 : for x=1 to 6
    g(x,y)=val(mid$(game$,i,1))
    gosub [show] : i=i+1
  next : next
  return

[show]
  select case shapes
  case 1
    if g(x,y)=0 then #main, "drawbmp rd0 ";x*40+20;" ";y*40+40
    if g(x,y)=1 then #main, "drawbmp rd1 ";x*40+20;" ";y*40+40
    if g(x,y)=2 then #main, "drawbmp rd2 ";x*40+20;" ";y*40+40
    if g(x,y)=3 then #main, "drawbmp rd3 ";x*40+20;" ";y*40+40
  case 2
    if g(x,y)=0 then #main, "drawbmp sq0 ";x*40+20;" ";y*40+40
    if g(x,y)=1 then #main, "drawbmp sq1 ";x*40+20;" ";y*40+40
    if g(x,y)=2 then #main, "drawbmp sq2 ";x*40+20;" ";y*40+40
    if g(x,y)=3 then #main, "drawbmp sq3 ";x*40+20;" ";y*40+40
  case 3
    if g(x,y)=0 then #main, "drawbmp tr0 ";x*40+20;" ";y*40+40
    if g(x,y)=1 then #main, "drawbmp tr1 ";x*40+20;" ";y*40+40
    if g(x,y)=2 then #main, "drawbmp tr2 ";x*40+20;" ";y*40+40
    if g(x,y)=3 then #main, "drawbmp tr3 ";x*40+20;" ";y*40+40
  end select
  return

[won] if dm then close #dm
  UpperLeftX = 20+180 : UpperLeftY = 40+80
  WindowWidth = 256 : WindowHeight = 266
  if sound and 8 then playwave "won.wav", async
  button #dm, " OK ", [ok], LR, 46, 20
  open "Winner!" for graphics_nf_nsb as #dm : dm=5
  #dm, "drawbmp won 30 20"
  i=oops : #dm, "place 46 190"
    if i<grade then #dm, "|Whoopee!" : i=0
    if i>2*grade then #dm, "|Finally!" : i=0
    if i then #dm, "|Congratulations."
    #dm, "flush"
  return
