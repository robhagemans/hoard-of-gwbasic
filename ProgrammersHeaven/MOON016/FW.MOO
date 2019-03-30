' FW.MOO

' Rowan Crowe, 3:635/727.1@fidonet
' rowan.crowe@p1.f727.n635.z3.fidonet.org
' rowan@jelly.freeway.DIALix.oz.au

' Unconditionally released to the public domain

' Requires MoonRock v0.15 or higher:
'   MRC fw /-c /-m

begin def

%ElementCount = 200

dim x1%[%ElementCount]
dim y1%[%ElementCount]

dim dx1%[%ElementCount]
dim dy1%[%ElementCount]

dim x2%[%ElementCount]
dim y2%[%ElementCount]

dim dx2%[%ElementCount]
dim dy2%[%ElementCount]

sub Array1Init
sub Array2Init

common pc1%, pc2%

begin code

$outstream _tty_str_direct

cls

@mov ah, 01h
@mov cx, 2000h
@int 10h
                             ' disable cursor.

colour 15,1
print "               MoonRock demonstration program; press a key to exit.             "
colour ?,0

call Array1Init
for i% = 0 to %ElementCount
  x2%[i%] = 8000    ' invalidate
next

pc1% = 1
pc2% = 100

k% = -1
while k% = -1
  k% = inkey
  c% = 1
  endloop1% = TRUE
  endloop2% = TRUE
  for i% = 0 to %ElementCount
    c% = c% + 1
    if c% = 8 then c% = 9
    if c% = 16 then c% = 1
    colour c%

    tx% = x1%[i%] \ 100
    ty% = y1%[i%] \ 100
    if ty% < 25 then
      if tx% < 79 then
        if tx% >= 0 then
          if ty% > 0 then
            cput(tx%,ty%,32)
          endif
        endif
      endif
    endif
    x1%[i%] = x1%[i%] + dx1%[i%]
    y1%[i%] = y1%[i%] + dy1%[i%]
    tx% = x1%[i%] \ 100
    ty% = y1%[i%] \ 100

    offscreen1% = TRUE
    if ty% < 25 then
      if tx% < 79 then
        if tx% >= 0 then
          if ty% > 0 then
            offscreen1% = FALSE
            cput(tx%,ty%,4)
          endif
        endif
      endif
    endif

    dy1%[i%] = dy1%[i%] + 5
    if dx1%[i%] < 0 then
      dx1%[i%] = dx1%[i%] + 3
    else
      dx1%[i%] = dx1%[i%] - 3
    endif
    if offscreen1% = FALSE then endloop1% = FALSE


    tx% = x2%[i%] \ 100
    ty% = y2%[i%] \ 100
    if ty% < 25 then
      if tx% < 79 then
        if tx% >= 0 then
          if ty% > 0 then
             cput(tx%,ty%,32)
          endif
        endif
      endif
    endif
    x2%[i%] = x2%[i%] + dx2%[i%]
    y2%[i%] = y2%[i%] + dy2%[i%]
    tx% = x2%[i%] \ 100
    ty% = y2%[i%] \ 100

    offscreen2% = TRUE
    if ty% < 25 then
      if tx% < 79 then
        if tx% >= 0 then
          if ty% > 0 then
            offscreen2% = FALSE
            cput(tx%,ty%,7)
          endif
        endif
      endif
    endif

    dy2%[i%] = dy2%[i%] + 5
    if dx2%[i%] < 0 then
      dx2%[i%] = dx2%[i%] + 3
    else
      dx2%[i%] = dx2%[i%] - 3
    endif

    if offscreen2% = FALSE then endloop2% = FALSE
  next
  delay(1)
  pc% = pc% + 1
  if endloop1% = TRUE then
    pc1% = pc1% - 1
    if pc1% = 0 then
      pc1% = rand(20) + 10
      call Array1Init
    endif
  endif
  if endloop2% = TRUE then
    pc2% = pc2% - 1
    if pc2% = 0 then
      pc2% = rand(25) + 10
      call Array2Init
    endif
  endif

wend

colour 7
cls

@mov ah, 01h
@mov cx, 0607h
@int 10h
                             ' enable cursor
end(0)

sub Array1Init
tx% = rand(2000)
ty% = rand(500) + 1200
for i% = 0 to %ElementCount
  x1%[i%] = tx%
  y1%[i%] = ty%
  xpower% = rand(100) + 20
  dx1%[i%] = rand(200) + xpower%
  t% = rand(80) + 30
  dy1%[i%] = neg(t%)
next
end sub

sub Array2Init   ' left
tx% = 8000 - rand(2000)
ty% = rand(500) + 1500
for i% = 0 to %ElementCount
  x2%[i%] = tx%
  y2%[i%] = ty%
  xpower% = rand(100) + 20
  t% = rand(200) + xpower%
  dx2%[i%] = neg(t%)
  t% = rand(100) + 30
  dy2%[i%] = neg(t%)
next
end sub
