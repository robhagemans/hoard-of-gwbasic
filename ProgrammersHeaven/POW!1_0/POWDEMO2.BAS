$string 32
$link "pow.pbl"
$include "pow.inc"


cls:print
print "POW! Library for PowerBASIC 3.0
print "(C) Copyright 1994 by Tim Gerchmez"
print:print "Demo Program #2":print"---------------":print
print "This program demonstrates the SBCMF routines, which"
print "use SBFMDRV.COM to play .CMF files in the background."
print "SBFMDRV.COM must be loaded before running this demo."
print

if sbcmfdetect=0 then
	print:print "Please load SBFMDRV.COM, then rerun this program."
     print:end
end if
line input ".CMF Directory (ENTER alone for current): ";c$
olddir$=curdir$
if c$="" then goto looppoint
chdir c$

looppoint:
print
files "*.CMF"
print
line input "CMF File to Play (.CMF not required): ";fl$
if fl$="" then chdir olddir$:end
fl$=ucase$(fl$)
if right$(fl$,4)<>".CMF" then fl$=fl$+".CMF"
if dir$(fl$)="" then print "No File ";fl$:goto looppoint
redim ary%(1:32767)
sbcmfplay fl$,ary%(1)
spd%=0:xpz%=0
print:print "Playing ";fl$;" -"
print
print "Press P to Pause Song"
print "Press R to Resume Song"
print "Press C to Cancel Song"
print "Press +/= to Increase Speed"
print "Press - to Decrease Speed
print "Press U to Transpose Up"
print "Press D to Transpose Down"
print "Press SPACE to return to defaults"
print "Press ENTER for another Song"
print "Press ESC to end program"
inlooppoint:
if sbcmfcheck=0 then
     while inkey$<>"":wend
	print:print "Playback Ended - Press a Key..."
     sleep:a$=inkey$
     goto looppoint
end if
a$=inkey$:if a$="" then goto inlooppoint
if a$=" " then
	spd%=0:xpz%=0
     sbcmfsetspeed spd%
     sbcmftranspose xpz%
     goto inlooppoint
end if
if a$="+" or a$="=" then
	if spd%<64 then spd%=spd%+4
     sbcmfsetspeed spd%
     goto inlooppoint
end if
if a$="-" then
	if spd%>-64 then spd%=spd%-4
     sbcmfsetspeed spd%
     goto inlooppoint
end if
if lcase$(a$)="u" then
	if xpz%<13 then
     	xpz%=xpz%+1
          sbcmftranspose xpz%
     	goto inlooppoint
     end if
end if
if lcase$(a$)="d" then
	if xpz%>-13 then
     	xpz%=xpz%-1
          sbcmftranspose xpz%
          goto inlooppoint
     end if
end if
if lcase$(a$)="p" then
	sbcmfpause:goto inlooppoint
end if
if lcase$(a$)="r" then
	sbcmfresume:goto inlooppoint
end if
if lcase$(a$)="c" then
	sbcmfcancel:goto inlooppoint
end if
if a$=chr$(13) then goto looppoint
if a$=chr$(27) then
	sbcmfcancel
     chdir olddir$
     end
end if
goto inlooppoint
