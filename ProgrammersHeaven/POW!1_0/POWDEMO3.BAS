$string 32
$link "pow.pbl"
$include "pow.inc"


'POW! Demo of SBPLAYFILE and SBPLAYSTRING direct mode
'playback of digitized sample data - requires WELCOME.RAW,
'a raw sample file included with POW!

wr$="welcome.raw"
if dir$(wr$)="" then
	line input "Path to WELCOME.RAW: ";pth$
     if right$(pth$,1)<>"\" then pth$=pth$+"\"
     wr$=pth$+wr$
end if

sbreset
for t%=50 to 30 step -5
sbplayfile wr$,t%         'Play the entire file at varying speeds
next t%
if dir$(wr$)="" then end  'Quit if file not found
open "b",#1,wr$           'Open file for binary access
get$ 1,400,a$             'Throw away first 400 bytes
get$ 1,2300,a$            'Get 2300 byte portion
close 1
for t%=1 to 4
sbplaystring a$,20       'Play part of the file contained in string
next t%
sbplayfile wr$,20        'Play the entire file one last time
