' STARS.MOO

' Rowan Crowe, 3:635/727.1@fidonet
' rowan.crowe@p1.f727.n635.z3.fidonet.org
' rowan@jelly.freeway.DIALix.oz.au

' Unconditionally released to the public domain

' Requires MoonRock v0.16 or higher:
'   MRC stars /-c /-m

begin def

%Pixel = 101
dim x%[%Pixel]
dim y%[%Pixel]

sub ProcessPlane(start1%, end1%, speed1%)

common DirectionX%, FactorX%
common DirectionY%, FactorY%

%Escape = 27
%Down  = 80
%Up    = 72
%Left  = 75
%Right = 77

begin code

$outstream _tty_str_direct

DirectionX% = -1
FactorX% = -4
FactorY% = 0
DirectionY% = 0

setgraphmode(6)
gcls

for i% = 0 to %Pixel
  x%[i%] = rand(639)
  y%[i%] = rand(199)
next

exitnow% = FALSE
while exitnow% = FALSE

  call ProcessPlane(1, 20, 1)
  call ProcessPlane(21, 40, 2)
  call ProcessPlane(41, 60, 3)

  delay(1)
  k% = inkey
  select case k%
    case %Escape
      exitnow% = TRUE
    case 0
      k% = inkey
      select case k%
        case %Left
          FactorX% = FactorX% - 1
          if FactorX% > 4 then FactorX% = 4
          if FactorX% < -4 then FactorX% = -4
        case %Right
          FactorX% = FactorX% + 1
          if FactorX% > 4 then FactorX% = 4
          if FactorX% < -4 then FactorX% = -4
        case %Up
          FactorY% = FactorY% - 1
          if FactorY% > 4 then FactorY% = 4
          if FactorY% < -4 then FactorY% = -4
        case %Down
          FactorY% = FactorY% + 1
          if FactorY% > 4 then FactorY% = 4
          if FactorY% < -4 then FactorY% = -4
      end select
  end select
wend


sub ProcessPlane(start1%, end1%, speed1%)
for i% = start1% to end1%
  putpixel(x%[i%], y%[i%], 0)

  t% = FactorX% * speed1%
  x%[i%] = x%[i%] + t%

  t% = FactorY% * speed1%
  y%[i%] = y%[i%] + t%


  if x%[i%] <= -1 then
    x%[i%] = 639
    y%[i%] = rand(199)
  endif
  if x%[i%] >= 640 then
    x%[i%] = 0
    y%[i%] = rand(199)
  endif
  if y%[i%] <= -1 then
    y%[i%] = 199
    x%[i%] = rand(639)
  endif
  if y%[i%] >= 200 then
    y%[i%] = 0
    x%[i%] = rand(639)
  endif

  putpixel(x%[i%], y%[i%], 1)

next
end sub
