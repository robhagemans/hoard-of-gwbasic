' CryoGram - freeware game program by Tom McIntire 12-07-05

  loadbmp "about", "about.bmp"
  loadbmp "rules", "rules.bmp"
  loadbmp "screen", "screen.bmp"
  loadbmp "char", "char.bmp"
  loadbmp "bingo", "bingo.bmp"
  loadbmp "sound", "sound.bmp"
  loadbmp "wizard", "wizard.bmp"
  loadbmp "chkon", "chkon.bmp"
  loadbmp "chkoff", "chkoff.bmp"
  loadbmp "load", "load.bmp"

                                ' initialize
  music$="music.mid"
  chirp$="chirp.wav"
  click$="click.wav"
  char$=" !"+chr$(34)+"_'(),-./:;?............"
  char$=char$+"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  open "CryoGram.ini" for random as #1 len=4
    field #1,4 as ini
    while lof(#1)=0
      ini=11  : put #1,1
      ini=1   : put #1,2
    wend
    get #1,1 : sound=ini
    get #1,2 : gram=ini
    done=(lof(#1)-8)/4
  dim done(999) ' tank sized for max
    for i=1 to done
      get #1,i+2 : done(ini)=1 : next
  open "CryoGram.txt" for random as #2 len=192
    field #2,192 as txt$
    total=lof(#2)/192
  dim pool(26,2)  ' x,y pos of pick-pool char
    x=81 : y=32   ' pos of A
    for i=1 to 26
      pool(i,1)=x : pool(i,2)=y : x=x+18
    next
  dim freq(26)    ' alias counts
  dim grid(192,3) ' used,x-y,picked
    x=27 : y=73   ' pos of #1
    for i=1 to 192
      grid(i,1)=x : grid(i,2)=y
      x=x+18 : if x>600 then x=27 : y=y+60
    next
  dim char(52) ' / ( ) ? ! : ; , ' . - " spc ... A-Z
  dim code(26) ' 1-26 randomized by new

  nomainwin                      ' define menu
  UpperLeftX=1  : UpperLeftY=1
  WindowWidth=640 : WindowHeight=480
  menu #win, &Game,_
             &Load, [load],_
             &New, [new],_
             &Restart, [renew],_
             &Solve, [solve],_
             &Quit, [quit]
  menu #win, &Options,_
             &Sound, [sound],_
             &Wizard, [wizard]
  menu #win, &Help,_
             &Rules, [rules],_
             &About, [about]
  open "CryoGram" for graphics_nf_nsb as #win
  #win, "autoresize"
  #win, "color darkgray"         ' draw gray box
  #win, "backcolor lightgray"
  #win, "place 0 0" : #win, "down"
  #win, "boxfilled 19 26"
  #win, "getbmp graybox 0 0 19 26"
  #win, "color black"
  #win, "backcolor white"
  #win, "drawbmp char 0 0" : x=7 ' load punct marks
    for i=1 to 26
      #win, "getbmp char(";i;") ";x;" 7 19 26" : x=x+18
    next
  #win, "drawbmp screen 0 0" : x=81
    for i=27 to 52               ' fetch letters A-M
      #win, "getbmp char(";i;") ";x;" 32 19 26" : x=x+18
    next
  #win, "flush"                  ' event controls
  #win, "trapclose [quit]"
  #win, "when leftButtonDown [pick1]"
  #win, "when rightButtonDown [pick2]"
  if sound and 4 then playmidi music$, music
  goto [old]

                                 ' mainline
[oops] if sound and 1 then playwave chirp$, asynch
[ok] if dm then close #dm : dm=0 : goto [halt]
[loop] i=sound and 4
  #win, "getbmp scrn 0 0 640 480"
  #win, "drawbmp scrn 0 0"
  #win, "segment i"
  #win, "flush"
  #win, "delsegment ";i-1
[halt] i=sound and 4
  while i
   if music then i=music<=midipos()
   if i then stopmidi : playmidi music$, music : i=0
  wend
  pick=0
  input q$
  goto [loop]

[quit]                      ' close all ***********************
  ini=sound : put #1,1
  ini=gram  : put #1,2
  close #1 : close #2
  if dm then close #dm
  close #win
  if (sound and 4)*music then stopmidi
  unloadbmp "about"
  unloadbmp "rules"
  unloadbmp "screen"
  unloadbmp "char"
  unloadbmp "graybox"
  unloadbmp "bingo"
  unloadbmp "sound"
  unloadbmp "wizard"
  unloadbmp "chkoff"
  unloadbmp "chkon"
  unloadbmp "load"
  end

[pick2] pick=1
[pick1] pick=pick+1
  if sound and 2 then playwave click$, asynch
  if bingo then [oops]
  x=MouseX : y=MouseY : c=0
  for i=1 to 26
    if x>pool(i,1) and y>pool(i,2) then
      if x<pool(i,1)+18 and y<pool(i,2)+25 then c=i
    end if
  next
  while c*picked ' unpick
    #win, "drawbmp char(";picked+26;") ";pickX;" ";pickY
    pool(picked,0)=1 : picked=0
  wend
  if pick=2 then [undo]
  if picked then [drop]
  if pool(c,0)=0 then [oops] ' blank
  x=pool(c,1) : y=pool(c,2) : pool(c,0)=0 ' picked
  pickX=x : pickY=y : picked=c
  #win, "getbmp picked ";x;" ";y;" 19 26"
  #win, "down" : #win, "color red"
  #win, "place ";x+2;" ";y+2
  #win, "size 2"
  #win, "box ";x+19;" ";y+25
  #win, "color black"
  goto [loop]
[drop]
  for i=1 to 192 : l=grid(i,2) : c=grid(i,1)
    if x>c and x<c+18 and y>l and y<l+52 then g=i : i=999
  next : j=grid(g,0)
  if j=0 then [oops]         ' blank
  if i<200 then [oops]       ' off grid
  if grid(g,3) then [oops]   ' occupied
  x=c : y=l : dropX=x : dropY=y
  c=picked : picked=0 : pool(c,0)=0 ' used
  #win, "drawbmp char(1) ";pickX;" ";pickY
  for i=1 to 192
    if j=grid(i,0) then
      x=grid(i,1) : y=grid(i,2) : grid(i,3)=c
      #win, "drawbmp picked ";x; " ";y
    end if
  next : if bingo then [loop]
  for i=1 to 192 : c=grid(i,0)
    if c then if c-64-grid(i,3) then i=900
  next : g=i<900 : bingo=g
  while g : g=0                       ' yeah!
    #win, "drawbmp bingo 73 24" : done=done+1
    i=done(gram) : done(gram)=1
    if i=0 then ini=gram : put #1,done+2
    input Q$
  wend
  goto [loop]
[undo]
  for i=1 to 192 : l=grid(i,2) : c=grid(i,1)
    if x>c and x<c+18 and y>l and y<l+52 then g=i : i=999
  next : j=grid(g,0)
  if grid(g,3)=0 then [oops] ' not occupied
  if i<200 then [oops]       ' off grid
  x=grid(g,1) : y=grid(g,2)  ' get image
    #win, "getbmp picked ";x;" ";y;" 19 26"
  x=grid(g,3)*18+63          ' put back in pool
    #win, "drawbmp picked ";x;" 32"
    pool(grid(g,3),0)=1      ' now available
  for i=1 to 192
    if j=grid(i,0) then
      x=grid(i,1) : y=grid(i,2) : grid(i,3)=0
      #win, "drawbmp graybox ";x; " ";y
    end if
  next
  goto [loop]

                                ' Game menu
[load]
  if dm then close #dm
  UpperLeftX = 198 : UpperLeftY = 116
  WindowWidth = 252 : WindowHeight = 200
  button #dm, " OK ", [loadOK], UL, 107, 137
  open "Load" for graphics_nf_nsb as #dm : dm=5
  #dm, "when leftButtonDown [load?]"
  #dm, "drawbmp load 0 0"
  q$=str$(total)+"   " : q$=left$(q$,4)
  #dm, "place 34 46" : print #dm, "|";q$
  q$=str$(done)+"   " : q$=left$(q$,4) ' solved
  #dm, "place 34 100" : print #dm, "|";q$ 
  i=total-done
  q$=str$(i)+"   " : q$=left$(q$,4) ' unsolved
  #dm, "place 34 154" : print #dm, "|";q$
  #dm, "getbmp load 0 0 252 200"
  g=gram
[load0]
  #dm, "drawbmp load 0 0" : q$=str$(g)
  while len(q$)<3 : q$="0"+q$ : wend
  #dm, "color green"
  if done(g) then #dm, "color red"
  #dm, "size 2"
  for x=171 to 211 step 20
    c=asc(q$)-47 : q$=mid$(q$,2) : y=c*14+2
    #dm, "place ";x;" ";y : #dm, "down"
    #dm, "box ";x+14;" ";y+15
  next
  #dm, "color black"
  #dm, "flush"
  wait
[loadOK]
  close #dm : dm=0
  #win, "drawbmp scrn 0 0"
  goto [old]
[load?]
  c=MouseX : l=MouseY : i=-1
  for x=170 to 210 step 20
    for y=16 to 142 step 14 : i=i+1
      if c>x and c<x+14 and l>y and l<y+15 then
        l=y : c=x : y=999 : x=999
      end if
    next
  next : q$=str$(g)
  while len(q$)<3 : q$="0"+q$ : wend
  if c=170 then q$=str$(i)+right$(q$,2)
  if c=190 then q$=left$(q$,1)+str$(i-10)+right$(q$,1)
  if c=210 then q$=left$(q$,2)+str$(i-20)
  g=val(q$) : i=(g>total or g<1)
    while i : g=gram : i=0
      if sound and 1 then playwave chirp$, asynch
    wend : gram=g
  goto [load0]

[new] gram=gram+1
  if gram>total then gram=1
[old]  ' next in sequence
  get #2,gram
  for i=1 to 26 : code(i)=i : next ' alphabet
    for i= 1 to 100                ' shuffle
      x=int(rnd(0)*26)+1 : y=code(1)
      if y-x then code(1)=code(x):code(x)=y
    next : code$=""
  for i=1 to 26                    ' aliases
    code$=code$+chr$(code(i)+64)
  next
[renew]
  for i=1 to 26 : pool(i,0)=1 : next  ' reset availables
  for i=1 to 192                      ' empty used & picked
   grid(i,0)=0 : grid(i,3)=0
  next
  #win, "drawbmp screen 0 0"          ' refresh screen
  for i=1 to 26 : freq(i)=0 : next    ' reset frequencies
  i=1 : j=1 : bingo=0
  for y=73 to 434 step 60             ' display puzzle
    for x=27 to 585 step 18
      q$=mid$(txt$,i,1) : c=instr(char$,q$) : g=c
      while g>1 : g=0
        if c>26 then
          #win, "drawbmp graybox ";x;" ";y
          grid(j,0)=asc(q$) : l=instr(code$,q$)
          c=l+26 : freq(l)=freq(l)+1
          #win, "drawbmp char(";c;") ";x;" ";y+26
        else
          #win, "drawbmp char(";c;") ";x;" ";y
          #win, "drawbmp char(";c;") ";x;" ";y+26
        end if
      wend : i=i+1 : j=j+1
     next
  next
  goto [loop]

[solve]          ' show solution
  for i=1 to 192 : c=grid(i,0) : x=grid(i,1) : y=grid(i,2)
    if c then #win, "drawbmp char(";c-38;") ";x;" ";y
  next : bingo=1
  goto [loop]


                                 ' Options menu

[sound] ' set chirp click music
  if dm then close #dm
  UpperLeftX = 198 : UpperLeftY = 116
  WindowWidth = 256 : WindowHeight = 232
  button #dm, " OK ", [soundOK], UL, 14, 170
  open "Sound" for graphics_nf_nsb as #dm : dm=4
  #dm, "when leftButtonDown [sound?]"
  #dm, "drawbmp sound 0 0"
[sound0] i=1
  for y=12 to 108 step 48
   if sound and i then
    #dm, "drawbmp chkon ";15;" ";y
   else
    #dm, "drawbmp chkoff ";15;" ";y
   end if
   i=i*2
  next
  #dm, "flush"
  input q$
  goto [sound0]
[sound?]
  x=MouseX<15 or MouseX>47 : y=MouseY
  if y>12 and y<44 then i=1   ' chirp
  if y>60 and y<92 then i=2   ' click
  if y>108 and y<140 then i=4 ' music
  x=x or i=0
    if x*(sound and 1) then beep
    if x then [sound0]
    sound=sound xor i
    if i-4 then [sound0] else i=sound and 4
    if music*(i=0) then stopmidi : goto [sound0]
    playmidi music$, music : goto [sound0]
[soundOK]
  #win, "drawbmp scrn 0 0"
  goto [ok]

[wizard]
  if dm then close #dm
  UpperLeftX = 127 : UpperLeftY = 82
  WindowWidth = 386 : WindowHeight = 353
  button #dm, " OK ", [ok], LR, 56, 12
  open "Wizard" for graphics_nf_nsb as #dm : dm=1
  #dm, "drawbmp wizard 0 0" : i=1
  #dm, "place 282 23"
  #dm, "|";gram
  for x=16 to 240 step 56 : y=60
    for l=1 to 5
      #dm, "color black"
      #dm, "place ";x;" ";y
      #dm, "|";chr$(i+64)
      #dm, "color darkred"
      #dm, "place ";x+18;" ";y
      #dm, "|";freq(i)
      i=i+1 : y=y+20
    next
  next : y=60 : x=296
  #dm, "color black"
  #dm, "place ";x;" ";y
  #dm, "|";chr$(i+64)
  #dm, "color darkred"
  #dm, "place ";x+18;" ";y
  #dm, "|";freq(i)
  #dm, "flush"
  #dm, "color black"
  goto [halt]


                                 ' Help menu
[rules]
  if dm then close #dm
  UpperLeftX = 190 : UpperLeftY = 116
  WindowWidth = 264 : WindowHeight = 267
  button #dm, " OK ", [ok], LR, 22, 8
  open "Rules" for graphics_nf_nsb as #dm : dm=1
  #dm, "drawbmp rules 0 0"
  #dm, "flush"
  goto [halt]

[about]
  if dm then close #dm
  UpperLeftX = 190 : UpperLeftY = 116
  WindowWidth = 264 : WindowHeight = 267
  button #dm, " OK ", [ok], LR, 52, 22
  open "About" for graphics_nf_nsb as #dm : dm=2
  #dm, "drawbmp about 0 0"
  #dm, "flush"
  goto [halt]

