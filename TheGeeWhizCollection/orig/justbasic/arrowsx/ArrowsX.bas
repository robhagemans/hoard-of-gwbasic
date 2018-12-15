' ArrowsX - freeware game program by Tom McIntire 12-27-05

'load images
  loadbmp "leds", "leds.bmp"
  loadbmp "arrows", "arrows.bmp"
  loadbmp "page", "ArrowsX.bmp"
  loadbmp "tips","tips.bmp"
  loadbmp "hist", "hist.bmp"
  loadbmp "about", "about.bmp"
  loadbmp "rules", "rules.bmp"

'load tips file
  dim tips$(500)
  open "tips.txt" for input as #1
    for i=1 to 500
      line input #1,tips$(i)
      if eof(#1) then tips$(0)=str$(i) : i=999
    next : close #1

'load ini file
  open "ArrowsX.ini" for random as #1 len=4
    field #1,4 as hist
    while lof(#1)=0
      hist=1700 : put #1,1 : hist=0
      for i=1 to 30 : put #1,i+1 : next
    wend
    get #1,1 : q$=str$(hist)
    game=val(left$(q$,1))
    sound=val(mid$(q$,2,1))
    tipsat=val(mid$(q$,3))

'load scores
  dim hist(30)
    for i=1 to 30 : get #1,i+1 : hist(i)=hist : next

'arrows tank
  dim grid(36,6)
  i=0 ' assign x & y coord
  for y=67 to 312 step 41
    for x=21 to 266 step 41 : i=i+1
      grid(i,1)=x : grid(i,2)=y
    next
  next
  for i=1 to 36 ' adjacents map
    grid(i,3)=i-1 ' left
    grid(i,4)=i+1 ' right
    grid(i,5)=i-6 ' above
    grid(i,6)=i+6 ' below
  next
  for i=1 to 31 step 6 : grid(i,3)=0 : next ' no left
  for i=6 to 36 step 6 : grid(i,4)=0 : next ' no right
  for i=1 to 6 : grid(i,5)=0 : next         ' no above
  for i=31 to 36 : grid(i,6)=0 : next       ' no below

'colors 1=cyan, 2=magenta, 3=yellow, 4=gray, 5=red, 6=green
  dim colr(48)
  for i=0 to 47 : colr(i+1)=int(i/8)+1 : next

'directions 1=W, 2=E, 3=N, 4=S, 5=NW, 6=NE, 7=SW, 8=SE
  dim aim(48) : k=1
  for i=1 to 48
    aim(i)=k : k=k+1 : if k=9 then k=1
  next

'open screen
  nomainwin
  UpperLeftX=30  : UpperLeftY=30
  WindowWidth=580 : WindowHeight=380
  open "ArrowsX" for graphics_nf_nsb as #win

'load leds
  #win "down" : #win, "fill brown"
  #win, "drawbmp leds 1 1"
  dim d$(10) : i=-1 ' led digits bmp names
  for x=1 to 240 step 24
    i=i+1 : d$(i)="d"+str$(i)
    #win, "getbmp ";d$(i);" ";x+1;" 1 25 39"
  next
  unloadbmp "leds"

'load arrows
  #win "down" : #win "fill brown"
  dim a$(48) ' 6x8 arrow bmp names
  a$(0)="a0" : i=0
  #win, "getbmp ";a$(0);" 1 1 40 40"
  #win, "drawbmp arrows 1 1"
    for y=1 to 246 step 41
      for x=1 to 328 step 41
        i=i+1 : a$(i)="a"+str$(i)
        #win, "getbmp ";a$(i);" ";x+1;" ";y+1;" 40 40"
      next
    next
  unloadbmp "arrows"

'set controls
  #win, "trapclose [quit]"
  #win, "when leftButtonDown [click]"
  #win, "when rightButtonDown [click]"

'mainline
  if sound and 4 then playmidi "music.mid", music
  #win, "drawbmp page 1 1"
  butn=game : gosub [game] : gosub [new]
  butn=4 : if sound and 2 then gosub [on] ' clicks
  butn=5 : if sound and 4 then gosub [on] ' music
  butn=6 : if sound and 1 then gosub [on] ' tips
[oops] if sound and 2 then beep
[loop] i=sound and 4 : oops=0
  while i
   if music then i=music<=midipos()
   if i then stopmidi : playmidi "music.mid", music : i=0
  wend
  if butn=10 then [quit]
  if butn>6 then [idle]
  #win, "getbmp page 1 1 571 380"
  #win, "drawbmp page 1 1"
  #win, "segment seg" ' discard old flush
  #win, "delsegment "; seg-1
  #win, "flush"
[again] if tips=0 then timer 8000, [tips]
[idle] wait
[quit] if sound and 4 then stopmidi
  timer 0 : close #win
  unloadbmp "tips"
  unloadbmp "hist"
  unloadbmp "about"
  unloadbmp "rules"
  unloadbmp "page"
  for i=1 to 48 : unloadbmp a$(i) : next
  q$=str$(game)+str$(sound)+str$(tipsat)
   hist=val(q$) : put #1,1 ' opts
  for i=1 to 30 : hist=hist(i) : put #1,i+1 : next ' scores
  close #1
  end

[tips]
  timer 0 : if block then [idle]
  if (sound and 1)=0 then [idle]
  if (sound and 2) then playwave "tips.wav", asynch
  #win, "drawbmp tips 295 158" : tips=1
  #win, "backcolor yellow"
  #win, "color black"
  #win, "place 340 200" : c=0
  for i=1 to 500
    if tips$(i)="*" then c=c+1
    if c=tipsat then c=i+1 : i=999
  next
  while tips$(c)<>"*"
    #win, "|";tips$(c) : c=c+1
  wend : tipsat=tipsat+1
  if c>=val(tips$(0)) then tipsat=1
  goto [again]

[click]
  timer 0 : i=(butn>6 or tips>0)
  if i then #win, "drawbmp page 1 1"
  if butn>6 then butn=0
  if tips then tips=0
  if sound and 2 then playwave "click.wav", asynch
  x=MouseX : y=MouseY : oops=0
  if x<266 and y>64 then gosub [move] else gosub [butn]
  block=0 : if oops then [oops] else [loop]

'subroutines

[new]
  max=val(mid$("124",game,1))*25
  count=0 : done=0 : score=0
  #win, "place 319 132" ' blank bar
  #win, "backcolor darkgray"
  #win, "color darkgray"
  #win, "down"
  #win, "boxfilled 518 142"
  for i=1 to 36 : grid(i,0)=0 :next ' clear grid
  i=4 ' pick 4 blank spots
  while i : k=int(rnd(0)*36)+1
    if grid(k,0)=0 then grid(k,0)=99 : i=i-1
  wend
  for i=1 to 36 ' randomize arrows in grid
    j=grid(i,0)-99 : k=0 ' skip blank spots
    while j
      k=int(rnd(0)*48)+1 ' possible random arrow #
      l=grid(i,3) : l=grid(l,0) : l=colr(l) ' get color left
      h=grid(i,5) : h=grid(h,0) : h=colr(h) ' get color above
      if colr(k)<>l and colr(k)<>h then j=0
    wend : grid(i,0)=k
    #win, "drawbmp ";a$(grid(i,0));" ";grid(i,1);" ";grid(i,2)
  next
  more$=""                  ' load more$ 
  for x=301 to 383 step 41
    k=int(rnd(0)*48)+1 : more$=more$+chr$(k)
    #win, "drawbmp ";a$(k);" ";x;" ";67
  next
[score] ' display
  s=460 : s$=str$(score)
  while len(s$)<4 : s$="0"+s$ : wend
  for c=1 to 4 : d=val(mid$(s$,c,1))
    #win, "drawbmp ";d$(d);" ";s;" 66" : s=s+24
  next : c=count
  while c
    c=val(mid$("842",game,1))*count
    #win, "place 319 132"
    #win, "backcolor green"
    #win, "color green"
    #win, "down"
    #win, "boxfilled ";318+c;" 142" : c=0
  wend
  #win, "place 465 127"
  #win, "backcolor brown"
  #win, "color black"
  #win, "|";count;"     "
  return

[move]
  if count=max then oops=1 : goto [move0]
  for i=1 to 36                 ' find grid position
    j=(x>grid(i,1) and x<grid(i,1)+40)
    k=(y>grid(i,2) and y<grid(i,2)+40)
    if j*k then j=i : i=40
  next
  if i<40 or grid(j,0)=0 then oops=1 : goto [move0]
  x=grid(j,1) : y=grid(j,2) : i=0 : g=j
  select case aim(grid(j,0))    ' move possible?
    case 1 ' W
      if x>61 then i=j-1
    case 2 ' E
      if x<225 then i=j+1
    case 3 ' N
      if y>107 then i=j-6
    case 4 ' S
      if y<271 then i=j+6
    case 5 ' NW
      if j-7>0 and x>61 and y>107 then i=j-7
    case 6 ' NE
      if j-5>0 and x<225 and y>107 then i=j-5
    case 7 ' SW
      if j+5<37 and y<271 and x>61 then i=j+5
    case 8 ' SE
      if j+7<37 and y<271 and x<225 then i=j+7
  end select
  if i then                     ' yes
    h=grid(i,0) : k=grid(g,0) : grid(i,0)=k : grid(g,0)=h
  else                          ' no
    grid(g,0)=0 : score=score+10
    if sound and 2 then playwave "score.wav"
  end if
  count=count+1 : gosub [score]
  for i=1 to 36                 ' update grid
    #win, "drawbmp ";a$(grid(i,0));" ";grid(i,1);" ";grid(i,2)
  next
  gosub [drops] : if q$>"" then gosub [more]
[move0] if count=max then gosub [sort]
  return

[drops]
  q$=""                         ' find color matches
  for i=1 to 36 : c=colr(grid(i,0)) : h=0
    while c
      j=grid(i,3) ' left
      while j : j=0
        h=h or (c=colr(grid(i-1,0)))
      wend
      j=grid(i,4) ' right
      while j : j=0
        h=h or (c=colr(grid(i+1,0)))
      wend
      j=grid(i,5) ' above
      while j : j=0
        h=h or (c=colr(grid(i-6,0)))
      wend
      j=grid(i,6) ' below
      while j : j=0
        h=h or (c=colr(grid(i+6,0)))
      wend
      c=0 : if h then q$=q$+chr$(i)
    wend
  next
  for i=1 to len(q$)            ' blank & show
    h=asc(mid$(q$,i)) : grid(h,0)=0 : score=score+10
    #win, "drawbmp ";a$(0);" ";grid(h,1);" ";grid(h,2)
    gosub [score]
    if sound and 2 then playwave "score.wav"
  next
  return

[more]
  q$="" : oops=0                ' find empty spots
  for i=1 to 36
    if grid(i,0)=0 then q$=q$+chr$(i)
  next
  for j=1 to len(q$)
    i=asc(mid$(q$,j))           ' next empty spot
    h=asc(more$)                ' next incoming arrow
    c=colr(h)                   ' its color
    l=grid(i,3) : l=grid(l,0) : l=colr(l) ' color left
    r=grid(i,4) : r=grid(r,0) : r=colr(r) ' color right
    a=grid(i,5) : a=grid(a,0) : a=colr(a) ' color above
    b=grid(i,6) : b=grid(b,0) : b=colr(b) ' color below
    x=(c<>l and c<>r and c<>a and c<>b)
    while x : grid(i,0)=h : oops=1
      #win, "drawbmp ";a$(h);" ";grid(i,1);" ";grid(i,2)
      k=int(rnd(0)*48)+1        ' new random arrow
      more$=right$(more$,2)+chr$(k) : i=1
      for x=301 to 383 step 41  ' shift left one pos
        k=asc(mid$(more$,i)) : i=i+1
        #win, "drawbmp ";a$(k);" ";x;" ";67
      next : x=0 : if sound and 2 then playwave "more.wav"
    wend
  next : if oops then [more]
  return

[butn]
  oops=(x<21 or x>555)+(y<11 or y>45)
  butn=0 : if oops then [butn0]
  for i=20 to 506 step 54 : butn=butn+1
    if x>i and x<i+49 then x=i : i=999
  next
  if i<999 then oops=1 : goto [butn0]
  if butn=10 then [butn0]
  if butn>6 then [show]
  if butn>3 then [sound]
  if butn>0 then [game]
[butn0]
  return

[game]
  game=butn
  for butn=1 to 3 : gosub [off] : next
  butn=game : gosub [on] : gosub [new]
  return

[sound]
  i=val(mid$("...241",butn,1)) 'sounds/music/tips
  if i=4 then if (sound and 4)=0 then playmidi "music.mid", music
  if i=4 then if (sound and 4) then stopmidi
  c=sound and i : sound=sound xor i
  if c then gosub [off] else gosub [on]
  return

[on]
  i=butn*54-26
  #win, "place ";i;" 22"
  #win, "color green"
  #win, "backcolor green"
  #win, "down"
  #win, "boxfilled ";i+9;" 31"
  return

[off]
  i=butn*54-26
  #win, "place ";i;" 22"
  #win, "color darkgray"
  #win, "backcolor darkgray"
  #win, "down"
  #win, "boxfilled ";i+9;" 31"
  return

[show]
  block=1
  if butn=7 then q$="hist"
  if butn=8 then q$="rules"
  if butn=9 then q$="about"
  #win, "drawbmp ";q$;" 290 158"
  if butn-7 then [show0]
  #win, "color black"
  #win, "backcolor white"
  #win, "font arial 8 bold"
  #win, "place 336 196"
  for i=1 to 10
    #win, "|";hist(i)
  next
  #win, "place 372 196"
  for i=11 to 20
    #win, "|";hist(i)
  next
  #win, "place 408 196"
  for i=21 to 30
    #win, "|";hist(i)
  next
  #win, "font arial 10 bold"
  #win, "backcolor brown"
[show0]
  return

[sort]
  if done then [sort0] else done=1
  if sound and 2 then playwave "finito.wav"
  f=game*10-9 : e=f+9
  if score<hist(e)then [sort0]
  hist(e)=score
[sort2] c=0
  for i=f to e-1 : x=hist(i) : y=hist(i+1)
    if y>x then hist(i)=y : hist(i+1)=x : c=1
  next : if c then [sort2]
[sort0]
  return

