$string 32
$link "pow.pbl"
$include "pow.inc"

'POW! Demo #9 - Repeater - uses foreground sampling and playback

cls:print
print "POW! Repeater (Talking Parrot Clone)"
print
input "Trigger Level (129-200), try 132: ";tl%
sz%=9000  'Sample length
sbreset
print:print "Talk into the microphone... any key to end."
do
	a%=sbsamplebyte
     if a%>=tl% then
     	s$=sbsample$(sz%,35)
          sbplaystring s$,int(50*rnd(1))+1
     end if
     if inkey$<>"" then end
loop


