' IconSpin - freeware game program by Tom McIntire 11-17-05

                            ' images
  dim icon$(18) ' 32x32
    for i=1 to 18
      loadbmp "icon", "icon1.bmp"
      icon$(i)="icon"+str$(i)
      z$="icon"+str$(i)+".bmp"
      loadbmp icon$(i), z$
    next
  loadbmp "grid", "grid.bmp"
  loadbmp "knob0", "knob0.bmp"
  loadbmp "knob1", "knob1.bmp"
  loadbmp "rules", "rules.bmp"
  loadbmp "about", "about.bmp"
  loadbmp "chkon", "chkon.bmp"
  loadbmp "chkoff", "chkoff.bmp"
  loadbmp "sounds", "sounds.bmp"
  loadbmp "spins", "spins.bmp"
  loadbmp "demo", "demo.bmp"

                            ' globals

  sound=11          ' 1=beep 2=click 4=music 8=won
  music=0           ' length of music.mid
  dm=0              ' do menu handle if on else 0
  spin=0            ' 0,-1,1 = pivot: not,left,right
  clicks=0          ' counter
  won=0             ' -1=yes 0=no
  demo=0            ' 1=next 0=auto
  par=9             ' spins limit
  spinX=0 : spinY=0 ' pivot point
  knob=0            ' 1-25 rel pos
  knobX=0 : knobY=0 ' grid positions
  knobX$=""         ' 73 114 155 196 237
    for i=73 to 237 step 41 : knobX$=knobX$+chr$(i) : next
  knobY$=""         ' 51 92 133 174 215
    for i=51 to 215 step 41 : knobY$=knobY$+chr$(i) : next
  music$="music.mid"
  new$="ABCDEF"     ' pointers into icon$()
  rset$=space$(36)  ' restart copy of rows$()
  dim rows$(6)      ' 6 per of set A-R
  dim demo(36,36)   ' unspin knobX,knobY

                            ' locals

  i=0 : j=0 : c=0 : r=0 : x=0 : y=0
  c$="" : c1$="" : c2$="" : c3$="" : c4$=""
  t1$="" : t2$=""

                            ' initialize

  open "IconSpin.ini" for random as #1 len=4
  field #1,2 as par, 2 as sound
    while lof(#1)=0
      par=9 : sound = 11
      put #1,1
    wend : get #1,1
  nomainwin
  UpperLeftX=160  : UpperLeftY=60
  WindowWidth=330 : WindowHeight=360
  menu #win, &Game,_
             &New, [new],_
             &Restart, [restart],_
             &Demo, [demo],_
             &Quit, [quit]
  menu #win, &Options,_
             &Spins, [par],_
             &Sound, [sounds]
  menu #win, &Help,_
             &Rules, [rules],_
             &About, [about]
  open "IconSpin" for graphics_nf_nsb as #win
  #win, "trapclose [quit]"
  #win, "when leftButtonDown [left]"
  #win, "when rightButtonDown [right]"
  #win, "when mouseMove [move]"
  if sound and 4 then playmidi music$,music
  #win, "drawbmp grid 37 15"
  goto [new]

                            ' mainline

[beep] if sound and 1 then beep
[ok] if dm then close #dm : dm=0
[loop] i=sound and 4
  while i
   if music then i=music<=midipos()
   if i then stopmidi : playmidi music$, music : i=0
  wend
  spin=0
  if dm=0 and won=0 then gosub [clicks]
  if won=0 then gosub [win?]
  #win, "flush"
  if won then wait : goto [ok]
  wait
[quit]                      ' close all
  put #1,1 : close #1
  if dm then close #dm : dm=0
  if music*(sound and 4) then stopmidi
  close #win
  for i=1 to 18 : unloadbmp icon$(i) : next
  unloadbmp "grid"
  unloadbmp "knob0"
  unloadbmp "knob1"
  unloadbmp "rules"
  unloadbmp "about"
  unloadbmp "chkon"
  unloadbmp "chkoff"
  unloadbmp "sounds"
  unloadbmp "spins"
  unloadbmp "demo"
  end                       ' end of progam

[right] ' mouse buttons
  spin=1
[left]
  spin=spin+1
  if dm then [loop]
  i=knobX*knobY
  if i*(sound and 2) then playwave "click.wav", async
  if i=0 then [beep]
  if won then [beep]
  clicks=clicks+1
  gosub [spin] : gosub [show]
  goto [loop]

[move] ' mouse movement
  if dm then [loop]
  if won then [loop]
    gosub [knob]
  goto [loop]

[new] ' init grid
  t1$="" : rset$="" : clicks=0 : won=0
  while len(t1$)<6
    i=int(rnd(0)*18)     ' 0-17
    c$=chr$(i+65)        ' A-R
    if instr(t1$,c$)=0 then t1$=t1$+c$
  wend
  for i=1 to 6 : t2$="" ' load rows$
    for j=1 to 6 : t2$=t2$+mid$(t1$,i,1) : next
    rows$(i)=t2$
  next
  for knob=1 to par ' random spins
    spin=int(rnd(0)*2)+1
    c=int(rnd(0)*5)+1
      knobX=asc(mid$(knobX$,c))
      j=1:if spin=2 then j=-1
      demo(knob,0)=knobX*j
    c=int(rnd(0)*5)+1
      knobY=asc(mid$(knobY$,c))
      demo(knob,1)=knobY
    gosub [spin]
  next ' save for restart
  for i=1 to 6 : rset$=rset$+rows$(i) : next
  gosub [page]
  goto [loop]

[restart] ' reload same grid
  clicks=0 : won=0
  gosub [repage]
  goto [loop]

[demo] ' how to win
  if dm then close #dm
  UpperLeftX = 460 : UpperLeftY = 116
  WindowWidth = 126 : WindowHeight = 153
  button #dm, " Next ", [next], LR, 87, 88
  button #dm, " Auto ", [auto], LR, 87, 50
  button #dm, " Exit ", [ok], LR, 87, 12
  open "Demo" for graphics_nf_nsb as #dm : dm=5
  #dm, "trapclose [ok]"
  #dm, "drawbmp demo 0 0"
  #dm, "flush"
  demo=1 : won=0
  gosub [repage] : knob=par
  for clicks=0 to par-1
    gosub [clicks] : i=demo(knob,0)
    if i<0 then #win, "place 84 294" : #win, "|Left"
    if i>0 then #win, "place 208 294" : #win, "|Right"
    knobX=abs(i) : knobY=demo(knob,1)
    #win, "drawbmp knob1 ";knobX;" ";knobY ' green
    #win, "flush"
    if demo then wait
  [next] ' from [auto]
    #win, "drawbmp knob0 ";knobX;" ";knobY ' yellow
    spin=2 : if demo(knob,0)<0 then spin=1
    gosub [spin] : gosub [page] : knob=knob-1
    if sound and 2 then playwave "click.wav", async
    if demo=0 then
      i=time$("milliseconds")
      while time$("milliseconds")<i+500 : wend
      end if
    #win, "flush"
  next
  goto [ok]
[auto]
  demo=0
  goto [next]

                            ' Options menu

[par] ' set 9 18 or 36
  if dm then close #dm
  UpperLeftX = 198 : UpperLeftY = 116
  WindowWidth = 256 : WindowHeight = 266
  button #dm, "  9 ",  [par9], LR, 198, 190
  button #dm, " 18 ", [par18], LR, 198, 140
  button #dm, " 36 ", [par36], LR, 198, 90
  open "Spins" for graphics_nf_nsb as #dm : dm=3
  #dm, "drawbmp spins 0 0"
  #dm, "flush"
  goto [loop]
[par36] par=36 : goto [par1]
[par18] par=18 : goto [par1]
[par9] par=9
[par1]
  close #dm : dm=0
  goto [new]

[sounds] ' set beep click music won
  if dm then close #dm
  UpperLeftX = 198 : UpperLeftY = 116
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

[rules]
  if dm then close #dm
  UpperLeftX = 198 : UpperLeftY = 116
  WindowWidth = 256 : WindowHeight = 266
  button #dm, " OK ", [ok], LR, 46, 14
  open "Rules" for graphics_nf_nsb as #dm : dm=1
  #dm, "drawbmp rules 0 0"
  #dm, "flush"
  goto [loop]

[about]
  if dm then close #dm
  UpperLeftX = 198 : UpperLeftY = 116
  WindowWidth = 256 : WindowHeight = 266
  button #dm, " OK ", [ok], LR, 52, 22
  open "About" for graphics_nf_nsb as #dm : dm=2
  #dm, "drawbmp about 0 0"
  #dm, "flush"
  goto [loop]

                            ' subroutines

[repage] j=1
  for i=1 to 6
   rows$(i)=mid$(rset$,j,6) : j=j+6
  next
[page] i=0
  for y=0 to 205 step 41 : i=i+1 : j=1
    for x=0 to 205 step 41
      c=asc(mid$(rows$(i),j))-64         '1-18
      #win, "drawbmp "+icon$(c)+" ";x+42;" ";y+20
      j=j+1
    next
  next
[alloff]                    ' all knobs off
  for y=51 to 215 step 41
    for x=73 to 240 step 41
      #win, "drawbmp knob0 ";x;" ";y
    next
  next
return

[knob]                      ' turn on/off
  x=MouseX : y=MouseY : i=0 : j=0
   for r=50 to 216 step 41 ' y = 51 92 133 174 215
    for c=72 to 238 step 41 ' x = 73 114 155 196 237
      if x>c and x<c+13 then i=c+1
      if y>r and y<r+13 then j=r+1
      if i*j then r=999 : c=999
    next
  next : c=1 : r=0
  while i*j : c=knobX*knobY ' over button
    if c=0 then #win, "drawbmp knob1 ";i;" ";j : r=1
    knobX=i : knobY=j : i=0 : c=0
  wend
  while c : c=knobX*knobY   ' off button
    if c then #win, "drawbmp knob0 ";knobX;" ";knobY : r=1
    c=0 : knobX=0 : knobY=0
  wend : if r then #win, "flush"
  return

[spin]                      ' left or right
  c=instr(knobX$,chr$(knobX)) ' col
  i=instr(knobY$,chr$(knobY)) ' row
  c1$=mid$(rows$(i),c,1) : c2$=mid$(rows$(i),c+1,1)
  c3$=mid$(rows$(i+1),c,1) : c4$=mid$(rows$(i+1),c+1,1)
  if spin=1 then t1$=c2$+c4$ : t2$=c1$+c3$
  if spin=2 then t1$=c3$+c1$ : t2$=c4$+c2$ 
  rows$(i)=left$(rows$(i),c-1)+t1$+mid$(rows$(i),c+2)
  rows$(i+1)=left$(rows$(i+1),c-1)+t2$+mid$(rows$(i+1),c+2)
  return

[show]                      ' all icons
  i=0
  for y=0 to 205 step 41 : i=i+1 : j=1
    for x=0 to 205 step 41
      c=asc(mid$(rows$(i),j))-64         '1-18
      #win, "drawbmp "+icon$(c)+" ";x+42;" ";y+20
      j=j+1
    next
  next
  return

[clicks]                    ' show pace
  #win, "place 41 294"
  #win, "|                                                              "
  #win, "place 154 294"
  if clicks>9 then #win, "place 150 294"
  #win, "| ";clicks;" "
  return

[win?]                      ' won=-1 if so
  for i=1 to 6
    c=asc(mid$(rows$(i),1))
    for j=2 to 6
      if c-asc(mid$(rows$(i),j)) then j=9 : i=9
    next
  next : won=(i=7) : i=won*(sound and 8)
  if i then playwave "won.wav", asynch
  #win, "place 178 294"
  if won then #win, "|Congratulations!"
return

