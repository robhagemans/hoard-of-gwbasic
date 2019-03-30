' CMD.MOO

' Demonstrates simple commandline parsing.

' Compile and test it with a commandline like:

' "CMD hello,goodbye   /no  ;hi"


begin def

  dim cmdparm$[40]              ' Dimension for 40 parameters

  sub CmdLineParse: (cltmp$)

  common clcount%, Term$

begin code

Term$ = " ,/;"                   ' Terminators
call CmdLineParse (cmdline)      ' Parse the commandline

if clcount% = -1 then
  print "No commandline parameters entered."
else
  for i% = 0 to clcount%
    print cmdparm$[i%] + " "     ' Print parsed parameters
  next
endif
end


sub CmdLineParse: (cltmp$)
clcount% = 0                     ' Number of parameters found
while cltmp$ <> ""
  ptr% = sinstr(cltmp$, Term$)   ' Search for next terminator
  if ptr% <> 0 then

    if ptr% > 1 then
      ptr2% = ptr% - 1
      cmdparm$[clcount%] = left(cltmp$, ptr2%)
      clcount% = clcount% + 1
    endif

    ptr2% = ptr% + 1
    cltmp$ = mid(cltmp$, ptr2%)

  else

    cmdparm$[clcount%] = cltmp$
    clcount% = clcount% + 1
    cltmp$ = ""

  endif

wend
clcount% = clcount% - 1
end sub

