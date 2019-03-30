$link "pow.pbl"
$include "pow.inc"

'POW! Demo #8 - .POW library sample playback
'Once again, compile to a standalone .EXE and run
'from DOS, as we're using background DMA routines.
'You'll require the TEST.POW file that came with
'POW! for this one.

q%=pbvhost
shift right q%,5
if q% and 1 then
	print:print "Please run from a standalone .EXE only."
     end
end if

if sbdetect=0 then
	print "Soundblaster required!":end
end if


e$=environ$("BLASTER")

if e$<>"" then
	bp%=instr(e$,"A")  'Base port
	if bp%<>0 then
     	bp$="&h"+mid$(e$,bp%+1,3)
          sbsetbase val(bp$)
     end if
     i%=instr(e$,"I")   'Interrupt number
     if i%<>0 then
     	i$=mid$(e$,i%+1,1)
          sbsetint val(i$)
     end if
     d%=instr(e$,"D")   'DMA number
     if d%<>0 then
     	d$=mid$(e$,d%+1,1)
          sbsetdma val(d$)
     end if
end if


sv$="test.pow"
if dir$(sv$)="" then
	line input "Path to TEST.POW: ";pth$
     if right$(pth$,1)<>"\" then pth$=pth$+"\"
     sv$=pth$+sv$
     if dir$(sv$)="" then end
end if

cls
print:print ".POW File Sample Playback":print
print "Press keys 1-8 to play back the corresponding"
print ".POW sample, or ESC to end."
sbreset 'Reset the SB's DAC
keyloop:
	a$=inkey$:if a$="" then goto keyloop
     if a$=chr$(27) then sbreset:end
     if a$>="1" and a$<="8" then
     	sm%=val(a$)
          sbplaypow sv$,sm%  'Pretty easy eh?
     end if
     goto keyloop
