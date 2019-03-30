' LOCK.MOO -- Demonstrates MoonRock file locking

' Compile with:
'    MRC LOCK /R

' Run this program simultaneously in two separate tasks and note how
' locks are handled.

' NOTE: SHARE.EXE or equivalent support must be present.

begin def

#include mrc.h

begin code


shareretry% = 10

handle% = fopen("temp$$$$.$$$")
if doserr <> 0 then
  print "Open failed: DOS returned error #" + doserr + "\n"
  end(%EXIT_FAIL)
endif

trylock:
flock(handle%,0,0ffffffffh)
if doserr <> 0 then
  tmp% = doserr
  select case tmp%
    case 133
      shareretry% = shareretry% - 1
      if shareretry% = 0 then
        print "\nSharing violation unresolvable: aborting.\n"
        end(%EXIT_FAIL)
      endif
      print "\nSharing violation, retry " + shareretry%
      delay(18)           ' Delay one second
      goto trylock:
    case else
      print "Unknown DOS error: #" + doserr + "\n"
      end(%EXIT_FAIL)
  end select
endif

print "\nFile is now locked: press a key"
k% = -1
while k% = -1
  k% = inkey
wend
funlock(handle%,0,0ffffffffh)
print "\nFile is now unlocked.\n"
