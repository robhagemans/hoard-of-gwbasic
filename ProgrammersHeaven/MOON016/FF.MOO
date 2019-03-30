' FF.MOO by Rowan Crowe

' Demonstrates FINDFIRST/FINDNEXT functions.
' Displays a simple directory listing.

' Last modified 05-Jan-1996

begin def

#include ffblk.h

strsegsize 5k              ' We only need a small string seg for this.

begin code

$outstream _tty_str_direct
                           ' Direct screen writes for faster output.
                           ' Comment above line for DOS screen output.

cmd$ = cmdline             ' get commandline
cmd$ = ltrim(cmd$)         ' trim leading spaces
cmd$ = ucase(cmd$)         ' convert to uppercase
if cmd$ <> "" then
  print "  Filespec = '" + cmd$ + "'\n\n"
  b$ = findfirst (cmd$, 7)
  while b$ <> ""
    fcount% = fcount% + 1
    b$ = lcase(b$) + space(12)
    print left(b$, 12) + "        "
    b$ = findnext
  wend
  if fcount% > 0 then print "\n\n"
  print "  " + fcount% + " file"
  if fcount% <> 1 then print "s"
  print " found.\n"
else
  print "Specify filespec in commandline.\n"
endif
end
