' Drop'em - freeware game program by Tom McIntire 11-25-05

                             'load images

  loadbmp "chkon", "chkon.bmp"
  loadbmp "chkoff", "chkoff.bmp"
  loadbmp "mode", "modes.bmp"
  loadbmp "m1", "mode1.bmp"
  loadbmp "m2", "mode2.bmp"
  loadbmp "m3", "mode3.bmp"
  loadbmp "m4", "mode4.bmp"
  loadbmp "style", "style.bmp"
  loadbmp "sound", "sound.bmp"
  loadbmp "topten", "scores.bmp"
  loadbmp "about", "about.bmp"
  loadbmp "rules", "rules.bmp"
  loadbmp "halt", "cop.bmp"
  loadbmp "end", "end.bmp"
  dim do$(9) ' buttons on
    for i=1 to 9 : do$(i)="do"+str$(i)
      q$="do"+str$(i)+".bmp" : loadbmp do$(i), q$
    next
  dim rd$(5)
    for i=0 to 5 : rd$(i)="rd"+str$(i)
      q$="rd"+str$(i)+".bmp" : loadbmp rd$(i), q$
    next
  dim rr$(5)
    for i=0 to 5 : rr$(i)="rr"+str$(i)
      q$="rr"+str$(i)+".bmp" : loadbmp rr$(i), q$ 
    next
  dim rs$(5)
   for i=0 to 5 : rs$(i)="rs"+str$(i)
     q$="rs"+str$(i)+".bmp" : loadbmp rs$(i), q$ 
   next

                             ' load ini file

  open "Drop'em.ini" for random as #1 len=10
  field #1,10 as r$
    while lof(#1)=0
      r$="1110      " : put #1,1  ' options
      r$="0000000000" : put #1,2  ' cur drops+score
      for i=1 to  8 : put #1,i+2 : next  ' cur grid
      r$="0    ....."
      for i=1 to 40 : put #1,i+10 : next ' top10*4
    wend
  get #1,1
    sound=val(mid$(r$,1,1)) ' 1,2,4 = beep,click,music
    mode =val(mid$(r$,2,1)) ' 1,2,3,4 = a,b,c,d
    style=val(mid$(r$,3,1)) ' 1,2,3 = button types
    newin=val(mid$(r$,4,1)) ' 0=new,1=old
  get #1,2
    drops=val(mid$(r$,1,5)) ' current drops
    score=val(mid$(r$,6,5)) ' current score
    unscore=score
    undrops=drops
  dim grid(11,9)            ' 10x8 grid
    for i=1 to 8 : get #1,i+2
      for x=1 to 10         ' rec=3-10
        grid(x,i)=val(mid$(r$,x,1))
        ungrid(x,i)=grid(x,i)
      next
    next
  dim h$(40) ' history = 10 per mode score/name
    for i=1 to 40 : get #1,i+10 : h$(i)=r$ : next

                            ' init vars
  music$="music.mid"
  chirp$="drip.wav"
  id$=""    ' max 5 char
  id=0      ' >0 close #id on quit
  music=0   ' len of music.mid
  ladder=0  ' 1-9 picked on menu
  click=0   ' 1=left 2=right
  done=0    ' 0=no else yes
  undo=0    ' 0=no else yes
  done=0    ' >0 = end of game
  x=0 : y=0 ' global: grid coord
  i=0 : c=0 : h=0 : e=0 ' locals
  q$="" : x$="" : y$=""   ' locals

                            ' init screen

  nomainwin
  UpperLeftX=0  : UpperLeftY=15
  WindowWidth=640 : WindowHeight=436
  open "Drop'em" for graphics_nf_nsb as #win
  #win, "fill brown"
  gosub [new] : ladder=1
  #win, "getbmp play 0 15 480 420"
  #win, "flush"
  #win, "trapclose [quit]"
  #win, "when leftButtonDown [clickL]"
  #win, "when rightButtonDown [clickR]"
  #win, "when mouseMove [track]"
  if sound and 4 then playmidi music$, music

                            ' mainline
[oops] if sound and 1 then beep
[loop] i=sound and 4
  while i
   if music then i=music<=midipos()
   if i then stopmidi : playmidi music$, music : i=0
  wend
  click=0
  input q$
  goto [loop]
[track]
  gosub [ladder]
  goto [loop]
[clickR] click=1
  if done then [halt]
  if undo=0 then [oops]
  gosub [undo] : goto [loop]
[clickL] click=click+1
  gosub [ladder]
  if rung<0 then rung=0 : ladder=1 : goto [loop]
  if rung=0 and ladder=3 then gosub [mode]
  if rung=0 and ladder=4 then gosub [style]
  if rung=0 and ladder=5 then gosub [sound]
  if rung=0 and ladder=6 then gosub [info]
  if rung=0 and ladder=7 then gosub [info]
  if rung=0 and ladder=8 then gosub [info]
  if rung=0 and ladder=1 then [play]
  #win, "drawbmp play 0 15"
  if rung=2 then gosub [new]
  if rung=3 then gosub [abcd] ' mode switches
  if rung=4 then #win, "drawbmp style 172 116"
  if rung=5 then gosub [onoff] ' sound chk marks
  if rung=6 then gosub [topten]
  if rung=7 then #win, "drawbmp about 124 82"
  if rung=8 then #win, "drawbmp rules 92 102"
  if rung=9 then [quit]
  if rung or ladder then [loop] else [oops]
[play]
  if done then [halt]
  x=MouseX-12 : y=MouseY-12 : i=0
  x=int(x/48)+1 : y=int(y/48)+1 : c=grid(x,y)
  if c then i=i or c=grid(x-1,y) : i=i or c=grid(x+1,y)
  if c then i=i or c=grid(x,y-1) : i=i or c=grid(x,y+1)
  if i=0 then [oops]
  undrops=drops : unscore=score : undo=1
  for j=1 to 8 : for i=1 to 10
    ungrid(i,j)=grid(i,j)
  next : next : gosub [drop]
  if mode=1 then gosub [shift]
  if mode=2 then gosub [more]
  if mode=3 then gosub [more] : gosub [slew]
  if mode=4 then gosub [mega]
  gosub [show]
  gosub [winchk]
  goto [loop]

[halt]
  #win, "drawbmp halt 184 120"
  goto [oops]

[quit]
  if (sound and 4)*music then stopmidi
  if id then close #id
  close #win
  unloadbmp "chkon"
  unloadbmp "chkoff"
  unloadbmp "play"
  unloadbmp "mode"
  unloadbmp "m1"
  unloadbmp "m2"
  unloadbmp "m3"
  unloadbmp "m4"
  unloadbmp "style"
  unloadbmp "sound"
  unloadbmp "topten"
  unloadbmp "about"
  unloadbmp "rules"
  unloadbmp "halt"
  unloadbmp "end"
  for i=1 to 9 : unloadbmp do$(i) : next
  for i=0 to 5 : unloadbmp rd$(i) : next
  for i=0 to 5 : unloadbmp rr$(i) : next
  for i=0 to 5 : unloadbmp rs$(i) : next
  '         unload ini data
  r$=str$(sound)+str$(mode)+str$(style)+"1"
    put #1,1 ' options
  q$=str$(drops)+"     "
  r$=left$(q$,5)+str$(score) : put #1,2 ' score
  for i=1 to 8 : q$=str$(grid(1,i))
    for x=2 to 10 : q$=q$+str$(grid(x,i))
    next : r$=q$ : put #1,i+2
  next
  for i=1 to 40 : r$=h$(i) : put #1,i+10 : next
  close #1
  end

                            ' subroutines

[ladder]
  x=MouseX : y=MouseY : i=ladder : rung=0
  while x>509 and x<615 : x=0
    if y>84  and y<110 then i=1 ' play
    if y>119 and y<145 then i=2 ' new
    if y>154 and y<180 then i=3 ' mode
    if y>189 and y<215 then i=4 ' style
    if y>224 and y<250 then i=5 ' sound
    if y>259 and y<285 then i=6 ' topten
    if y>294 and y<320 then i=7 ' about
    if y>329 and y<355 then i=8 ' rules
    if y>364 and y<390 then i=9 ' exit
    rung=i
    while i-ladder
      q$="do"+str$(i) : ladder=i
      #win, "drawbmp ";q$;" 505 80"
    wend
  wend
  return

[new]
  while newin=0
    for y=1 to 8 : for x=1 to 10
      grid(x,y)=int(rnd(1)*5)+1 ' 1-5
    next : next : newin=1
    drops=0 : score=0
  wend : newin=0
  #win, "drawbmp do1 505 80"
  rung=0 : ladder=1 : done=0
  goto [show]

[undo]
  drops=undrops : score=unscore : undo=0
  for i=1 to 8 : for j=1 to 10
    grid(j,i)=ungrid(j,i)
  next : next
[show]
  gosub [score]
  x=432
  for c=10 to 1 step-1 : y=384
    for i=8 to 1 step-1 : y=y-48
     if style=1 then q$=rd$(grid(c,i))
     if style=2 then q$=rr$(grid(c,i))
     if style=3 then q$=rs$(grid(c,i))
     #win, "drawbmp ";q$;" ";x+12;" ";y+12
    next : x=x-48
  next
  if sound and 2 then playwave chirp$, asynch
  #win, "getbmp play 0 15 480 420"
  #win, "segment i" ' discard last flush
  #win, "delsegment "; i-1
  #win, "flush"
  return

[mode] ' pick = a,b,c,c
  x=MouseX : y=MouseY : i=mode
  if x>138 and x<187 and y>204 and y<253 then i=1
  if x>187 and x<236 and y>204 and y<253 then i=2
  if x>138 and x<187 and y>253 and y<302 then i=3
  if x>187 and x<236 and y>253 and y<302 then i=4
  if i-mode then rung=2
  mode=i
  return

[abcd] ' show mode switches
  #win, "drawbmp mode 127 81"
  q$="drawbmp m"+str$(mode)+" 138 204"
  #win, q$
  return

[style] ' pick = icon type
  x=MouseX : y=MouseY : i=(x>271 and x<320)
  if i*(y>126 and y<176) then style=1
  if i*(y>176 and y<226) then style=2
  if i*(y>229 and y<279) then style=3
  #win, "drawbmp play 0 15" : rung=-1
  gosub [show] : ladder=1
  #win, "drawbmp do1 505 80"
  return

[sound] ' pick = beep, click, music
  x=MouseX : y=MouseY : i=(x>160 and x<190)
  if i*(y>119 and y<150) then h=h xor 1
  if i*(y>166 and y<197) then h=h xor 2
  if i*(y>215 and y<245) then h=h xor 4
  sound=h
  gosub [onoff]
  input q$
[info]
  #win, "drawbmp play 0 15" : rung=-1
  ladder=1 : #win, "drawbmp do1 505 80"
  return

[onoff]
  #win, "drawbmp sound 124 103" : h=sound
  if h and 1 then #win, "drawbmp chkon 158 119"
  if h and 1=0 then #win, "drawbmp chkoff 158 119"
  if h and 2 then #win, "drawbmp chkon 158 167"
  if h and 2=0 then #win, "drawbmp chkoff 158 167"
  i=h and 4
  if i then #win, "drawbmp chkon 158 215"
  if i then if music=0 then playmidi music$, music
  if i=0 then #win, "drawbmp chkoff 158 215"
  if i=0 then if music then stopmidi : music=0
  sound=h
  return

[topten] ' show top ten
  #win, "drawbmp topten 124 82"
  #win, "place 172 118"
  q$=mid$("ABCD",mode,1)
  h=mode*10-10
  #win, "|Top 10 Scores for Mode ";q$
  y=142 : x=200
  for i=1 to 10
    #win,"place 192";" ";y
    #win,"|";mid$(str$(i+100),2)
    #win,"place 232";" ";y
    #win,"|";val(left$(h$(i+h),5))
    #win,"place 280";" ";y
    #win,"|";right$(h$(i+h),5) : y=y+17
  next
  return

[more]
  gosub [shift]
  if mode-3 then if grid(1,8)=0 then gosub [fill]
  e=0
  for i=10 to 1 step-1
    e=e or (grid(i,8)=0 and grid(i-1,8)>0)
  next : if e then [more]
  return

[slew]
  e=0
  for y=8 to 1 step-1
    for x=10 to 2 step-1 : c=grid(x-1,y)
      if c>0 and grid(x,y)=0 then grid(x,y)=c : grid(x-1,y)=0 : e=1
    next
  next : if e then [slew]
  return

[mega]
  gosub [more] : gosub [slew]
  if grid(1,8)=0 then [mega]
  return

[drop]
  h=-1*grid(x,y) : grid(x,y)=h
  for x=1 to 10 ' mark mates neg
    for y=1 to 8 : c=grid(x,y) : i=abs(c) : e=0
      if c<0 then
        if i=grid(x-1,y) then grid(x-1,y)=h : e=1
        if i=grid(x+1,y) then grid(x+1,y)=h : e=1
        if i=grid(x,y-1) then grid(x,y-1)=h : e=1
        if i=grid(x,y+1) then grid(x,y+1)=h : e=1
      end if
      if e then x=0
    next
  next : h=0
  for x=1 to 10 ' make all neg markers = zero
    for y=1 to 8 : c=grid(x,y)
      if c<0 then grid(x,y)=0 : h=h+1
    next
  next : drops=drops+h
  score=score+(h-1)*(h+1)
  for x=1 to 10 : e=0 ' down shift to fill gaps
    for y=8 to 1 step-1 : i= grid(x,y-1)
      if grid(x,y)=0 and i>0 then grid(x,y)=i : e=1
      if e then grid(x,y-1)=0
    next : if e then x=x-1
  next
  return

[shift] 'each column right to left to close gaps
  h=0
  for x=10 to 1 step-1 'shift
    e=0 : c=grid(x,8) : if c=0 and grid(x-1,8)>0 then e=x
    for i=e to 1 step-1 : h=1
      for y=1 to 8 : grid(i,y)=grid(i-1,y) : next
    next
  next : if h then [shift]
  return

[fill] ' left most column if empty
  for y=1 to 8
    grid(1,y)=int(rnd(1)*5)+1 ' 1-5
  next
  return

[score]
  #win, "place 505 25"
  #win, "|                             "
  #win, "|                             "
  #win, "|                             "
  #win, "place 520 25"
  #win, "| Mode = ";mid$("ABCD",mode,1)
  #win, "| Drops = ";drops
  #win, "| Score = ";score
  return

[winchk]
  done=1
  for y=1 to 8
    for x=1 to 10 : c=grid(x,y) : i=0
      while c
        if (c=grid(x-1,y) or c=grid(x+1,y)) then i=1
        if (c=grid(x,y-1) or c=grid(x,y+1)) then i=1
        c=0
      wend : if i then y=99 : x=99 : done=0
    next
  next : if done=0 then [winchk0]
  i=mode*10 : done=10
  while score>val(left$(h$(i),5)) and done>0
    i=i-1 : done=done-1
  wend : undo=0
  if done<10 then gosub [id] else gosub [zip]
[winchk0]
  return

[id]
  if id then close #id
  q$=" Rank = "+str$(done+1)
  textbox #id.txt, 4, 2, 110, 28 ' x,y,w,h
  button #id, q$, [endid], LR, 72, 2 'low/right x,y
  UpperLeftX = 196 : UpperLeftY = 194
  WindowWidth = 123 : WindowHeight = 86
  open "Name?" for window_nf as #id
  #id.txt, "!font Times_New_Roman 14";
  #id, "trapclose [endid]"
  id$=trim$(id$)
  #id.txt, id$ : id=1
  input q$
  [endid] id=0
  #id.txt, "!contents? id$"
  id$=id$+"     " : id$=left$(id$,5)
  close #id
  gosub [sort] : done=1
  return

[sort]
  e=mode*10 : f=e-9
  q$=str$(score)
    while len(q$)<5 : q$=q$+" " : wend
    h$(e)=q$+id$
[sort2] c=0
  for i=f to e-1 : x$=h$(i) : y$=h$(i+1)
    x=val(left$(x$,5)) : y=val(left$(y$,5))
    if y>x then h$(i)=y$ : h$(i+1)=x$ : c=1
  next : if c then [sort2]
  return

[zip]
  #win, "drawbmp end 156 148"
  done=1 : if sound and 1 then beep : beep
return
















