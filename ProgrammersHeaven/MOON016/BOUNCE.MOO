''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''                                                                    '''
''' BOUNCE.MOO                 *** released to the public domain ***   '''
'''                                                                    '''
''' Originally by Rowan Crowe, Wednesday, 03-Jan-1996                  '''
'''   3:635/727.1@fidonet                                              '''
'''   rowan@jelly.freeway.DIALix.oz.au                                 '''
'''                                                                    '''
''' Fairly cute but useless demonstration program bounces several      '''
''' independent "balls" around the screen area.                        '''
'''                                                                    '''
''' %BallCount may be modified. Limits are 1 to about 8000 (!) balls.  '''
'''                                                                    '''
''' Requires MoonRock compiler:                                        '''
'''   MRC bounce/-m/-c                                                 '''
'''                                                                    '''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

begin DEF

%BallCount = 25              ' number of balls on screen

dim x%[%BallCount]           ' current ball x position
dim y%[%BallCount]           ' current ball y position

dim dx%[%BallCount]          ' direction to travel: -1, 0, 1
dim dy%[%BallCount]          '      "     "    "     "

begin CODE

$outstream _tty_str_direct

colour ?,0
cls

@mov ah, 01h
@mov cx, 2000h
@int 10h
                             ' disable cursor.

for i% = 0 to %BallCount
  x%[i%] = rand(7900) \ 100  ' scale 0-79  (nb: '\' = integer division)
  y%[i%] = rand(2300) \ 100  ' scale 0-23

  dx%[i%] = 0
  while dx%[i%] = 0
    t% = rand(32000) - 16000
    dx%[i%] = sgn(t%)        ' -1, 0, +1
  wend

  dy%[i%] = 0
  while dy%[i%] = 0
    t% = rand(32000) - 16000
    dy%[i%] = sgn(t%)        ' -1, 0, +1
  wend
next

k% = -1
while k% = -1

  c% = 7
  for i% = 0 to %BallCount
    mcursor x%[i%],y%[i%]
    print " "                ' clear last position

    x%[i%] = x%[i%] + dx%[i%]
    y%[i%] = y%[i%] + dy%[i%]

    mcursor x%[i%],y%[i%]
    colour c%
    c% = c% + 1
    if c% = 8 then c% = 0
    print "\h04"             ' diamond "ball"

    if x%[i%] > 77 then
      t% = rand(5000) - 4000
      if t% < 0 then
        dx%[i%] = 0
      else
        dx%[i%] = -1
      endif
    endif
    if x%[i%] < 1 then
      t% = rand(5000) - 4000
      if t% < 0 then
        dx%[i%] = 0
      else
        dx%[i%] = 1
      endif
    endif
    if y%[i%] > 23 then
      t% = rand(5000) - 4000
      if t% < 0 then
        dy%[i%] = 0
      else
        dy%[i%] = -1
      endif
    endif
    if y%[i%] < 1 then
      t% = rand(5000) - 4000
      if t% < 0 then
        dy%[i%] = 0
      else
        dy%[i%] = 1
      endif
    endif

  next

  colour 14,1
  mcursor 8,11
  print "  MoonRock demonstration program -- press any key to exit  "
  colour ?,0
  delay(1)

  k% = inkey

wend
if k% = 0 then k% = inkey    ' eat up extended keypress
colour 7,0
cls
@mov ah, 01h
@mov cx, 0607h
@int 10h
                             ' enable cursor
end
