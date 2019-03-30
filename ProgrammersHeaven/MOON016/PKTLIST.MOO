' PKTLIST -- a sample MoonRock program, by Rowan Crowe.
'
' Lists messages in any fidonet-style PKTs in the current directory.
'
' Last update: Wed 25-Oct-1995

begin def

#include mrc.h
#include ffblk.h

' A bundle is similar to a user type in QuickBASIC. Note the trailing
' dash which tells MRC to join the lines.

 bundle PKTHeader: OrigNode%, DestNode%, Year%, Month%, day%,_
                   hour%, minute%, second%, Baud%, PKTType%,_
                   OrigNet%, DestNet%, ProdCode1%, Pw$[8] null,_
                   QOrigZone%, QDestZone%, AuxNet%, CWvalidation%,_
                   ProdCode2%, CW%, OrigZone%, DestZone%,_
                   OrigPoint%, DestPoint%, f1&

 bundle PackedMsg: PKTType%, OrigNode%, DestNode%, OrigNet%,_
                   DestNet%, Attribute%, Cost%, f1&, f2&, f3&,_
                   f4&, f5&

 sub get0:
 sub printfield: (field$, fieldlen%)

 common get0$, handle%

 %ChunkSize = 512

begin code


'$outstream _tty_str_direct
' Uncomment the above line for faster (but not redirectable) screen
' output.


print "PktList v0.02 [DOS]; MoonRock demonstration program\n"

pktname$ = findfirst("*.pkt", 7)
while pktname$ <> ""
  handle% = fopen(pktname$)
  PKTHeader^ = fget(handle%)
  zz% = 0
  if PKTHeader.QOrigZone% <> 0 then
    zz% = PKTHeader.QOrigZone%
  endif
  if PKTHeader.OrigZone% <> 0 then
    zz% = PKTHeader.OrigZone%
  endif

  print "\n-- Scanning: " + pktname$ + ", Origin="
  if zz% <> 0 then           ' If extended zone information is present,
    print zz% + ":"           ' display it
  endif
  print PKTHeader.OrigNet% + "/" + PKTHeader.OrigNode% + "." + PKTHeader.OrigPoint% + "\n"

  PackedMsg^ = fget(handle%) ' Get bundle from file. Note that the
                             ' bundle is referenced as <name>^
  pktmsgcount& = 0
  while PackedMsg.PKTType% = 2
    msgcount& = msgcount& + 1
    pktmsgcount& = pktmsgcount& + 1

    call get0                  ' Get TO name
    msgto$ = get0$
    call get0                  ' Get FROM name
    msgfrom$ = get0$
    call get0                  ' Get SUBJECT
    call printfield(msgfrom$, 20)
    call printfield(msgto$, 20)
    call printfield(get0$, 35)
    print "\n"                 ' List To/From/Subj

    posi& = fpos(handle%)      ' Current file position -> posi&
    ptr% = 0

    in$ = null(%ChunkSize)     ' Create string of {%ChunkSize} nulls

    while ptr% = 0
      in$ = fget(handle%)      ' Get 90 bytes from PKT
      ptr% = cinstr(in$, 0)    ' Is there a null terminator in that string?
      if ptr% = 0 then
        posi& = posi& + %ChunkSize  ' No null present
      else
        posi& = posi& + ptr%
      endif
    wend

    fseek(handle%, posi&)
    PackedMsg.PKTType% = 0
    PackedMsg^ = fget(handle%) ' Get next message header and loop back.
  wend
  fclose(handle%)              ' Close PKT
  print "-- Messages in packet: " + pktmsgcount& + "\n"
  pktname$ = findnext          ' Find next PKT name
wend
print "\n-- Total messages:     " + msgcount& + "\n"
end

' *** SUBROUTINES ***


sub get0:

' Get a null terminated string from PKT

 posi& = fpos(handle%)         ' Get current position in file
 tmp$ = null(73)               ' Max size of null-string is 72
 tmp$ = fget(handle%)          ' Get 73 chars from file
 ptr% = cinstr(tmp$, 0)        ' Find the null
 if ptr% <> 0 then
   posi& = posi& + ptr%
   get0$ = left(tmp$, ptr%)    ' Trim the string
 else
   print "\nFATAL ERROR! Null string longer than 72 chars; possible damaged PKT.\n"
   end(%EXIT_FAIL)
 endif
 fseek(handle%, posi&)         ' Adjust file position to point after null
end sub


sub printfield: (field$, fieldlen%)

' Print field$, right padded with spaces to fieldlen%

  tmp$ = field$ + space(fieldlen%)
  print left(tmp$, fieldlen%) + " "

end sub
