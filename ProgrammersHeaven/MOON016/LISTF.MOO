' LISTF.MOO

' Demonstrates a simple scrolling list function.

' Last update: Mon 22-Jan-1996

begin def

#include mrc.h
#include ffblk.h

Sub UpdateScreen
Sub Up
Sub Down
Sub DrawWindow1 (tx%, ty%, bx%, by%)
Sub UpdateFuzzy

%Down      = 80
%Up        = 72
%PageDown  = 81
%PageUp    = 73
%Home      = 71
%End       = 79
%Escape    = 27

dim list$[1000]

strsegsize 64k

common ScPtr%, ElPtr%, ElementCnt%, ScreenBottom%, fuzzy$

begin code

$outstream _tty_str_direct

ScPtr% = 0    ' top of screen
ElPtr% = 0    ' currently selected element

ScreenBottom% = scrlen - 6

in$ = cmdline
in$ = ltrim(in$)
in$ = rtrim(in$)
if in$ <> "" then in$ = in$ + "\\"
in$ = in$ + "*.*"

ElementCnt% = -1
print "\n"
f$ = findfirst(in$,7)
while f$ <> ""
  ElementCnt% = ElementCnt% + 1
  list$[ElementCnt%] = lcase(f$)
  a% = freemem(0) shr 10
  print "\rReading directory. [Free: " + a% + "K]"
  f$ = findnext
wend
if ElementCnt% = -1 then
  goto done
endif

cls

@mov ah, 01h
@mov cx, 2000h
@int 10h
' Disable cursor.

colour 3, 1
t% = scrlen
for i% = 0 to t%
  mcursor 0, i%
  print repstr("²", 79)
next
colour 10, 0
t% = scrlen - 2
call DrawWindow1 (2, 1, 18, t%)
colour 15, 4
mcursor 3, 1
print space(14)
colour ?, 0

colour 14
t% = ScreenBottom% shr 1 - 1
t2% = t% + 4
call DrawWindow1(25, t%, 68, t2%)
t% = t% + 1
mcursor 26, t%
colour 10, 1
print "  LISTF: MoonRock demonstration program  "
t% = t% + 1
mcursor 26, t%
print "         -- Press ESC to exit --         "
colour ?,0

fuzzy$ = ""

call UpdateScreen

while exitnow% = FALSE
  k% = inkey
  select case k%
    case -1               ' no key pressed
      timeslice
    case 0                ' extended key pressed
      ekey% = inkey
      select case ekey%
        case %Down
          call Down
          call UpdateScreen
        case %Up
          call Up
          call UpdateScreen
        case %End
          ElPtr% = ElementCnt%
          ScPtr% = ElementCnt% - ScreenBottom%
          if ScPtr% < 0 then ScPtr% = 0
          call UpdateScreen
        case %Home
          ElPtr% = 0
          ScPtr% = 0
          call UpdateScreen
        case %PageDown
          for z% = 1 to ScreenBottom%
            call Down
          next
          call UpdateScreen
        case %PageUp
          for z% = 1 to ScreenBottom%
            call Up
          next
          call UpdateScreen
      end select
    case %Escape
      exitnow% = TRUE
    case else
      if k% > 32 then
        if k% < 127 then
          if len(fuzzy$) < 12 then
            c$ = chr(k%)
            fuzzy$ = fuzzy$ + lcase(c$)
            call UpdateFuzzy
            call UpdateScreen
          endif
        endif
      endif
      if k% = 8 then
        if len(fuzzy$) > 0 then
          l% = len(fuzzy$) - 1
          fuzzy$ = left(fuzzy$, l%)
          call UpdateFuzzy
          if fuzzy$ = "" then
            ElPtr% = 0
            ScPtr% = 0
          endif
          call UpdateScreen
        endif
      endif
  end select
wend

done:
colour 15
cls

@mov ah, 01h
@mov cx, 0607h
@int 10h
' Enable cursor

end(%EXIT_SUCCESS)

Sub DrawWindow1 (tx%, ty%, bx%, by%)
' top left, bottom right
mcursor tx%, ty%
width% = bx% - tx% - 2
print "É" + repstr("Í", width%) + "»\n"
t% = by% - ty% - 2
ty% = ty% + 1
for i% = 1 to t%
  mcursor tx%, ty%
  ty% = ty% + 1
  print "º" + space(width%) + "º "
next
mcursor tx%, ty%
print "È" + repstr("Í", width%) + "¼ "
ty% = ty% + 1
tx% = tx% + 1
Width% = Width% + 2
mcursor tx%, ty%
print space(width%)
end sub

Sub UpdateScreen
t% = ScPtr% + ScreenBottom%
yp% = 2
for i% = ScPtr% to t%
  mcursor 4, yp%
  yp% = yp% + 1
  colour 7, 0
  if i% = ElPtr% then
    colour 14, 1
    print list$[i%]
    c% = len(list$[i%])
    c% = 12 - c%
    print space(c%)
    colour 7, 0
    print "\n"
  else
    c% = len(list$[i%])
    c% = 12 - c%
    print list$[i%] + space(c%) + "\n"
  endif
  if i% > ElementCnt% then exit for
next
end sub


Sub Down
if ElPtr% < ElementCnt% then
  t% = ElPtr% - ScPtr%
  if t% = ScreenBottom% then ScPtr% = ScPtr% + 1
  ElPtr% = ElPtr% + 1
endif
end sub


Sub Up
if ElPtr% > 0 then
  ElPtr% = ElPtr% - 1
  t% = ElPtr% - ScPtr%
  if t% = -1 then ScPtr% = ScPtr% -1
endif
end sub


Sub UpdateFuzzy
for i% = 0 to ElementCnt%
  if instr(list$[i%], fuzzy$) <> 0 then
    ElPtr% = i%
    ScPtr% = i% - ScreenBottom%
    if ScPtr% < 0 then ScPtr% = 0
    exit for
  endif
next
mcursor 3, 1
colour 14, 4
t$ = space(12) + fuzzy$
t% = len(t$) - 12
print mid(t$, t%) + " "
end sub
