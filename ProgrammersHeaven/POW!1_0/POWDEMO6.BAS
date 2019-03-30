$link "pow.pbl"
$include "pow.inc"

'POW! Demo #6 - This demonstrates DMA (background) sound sampling
'and playback routines.

q%=pbvhost
shift right q%,5
if q% and 1 then
	print:print "Please run from a standalone .EXE only."
     end
end if


if sbdetect=0 then
	print "Soundblaster required!":end
end if


'This first section demonstrates how to read the BLASTER environment
'variable set by the user in AUTOEXEC.BAT when he/she first installed
'their Soundblaster card.  This is then used to set POW! library
'defaults.

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

cls
print:print "POW! Demo #6 - Background Sampling and Playback"
print:print "Speak into the microphone of your Soundblaster or"
print "begin input to the Line In jack and...":print
print "Press a Key to Begin Sampling..."
sleep:a$=inkey$
sbreset 'Reset the SB's DAC
redim holdsample%(1:8192)  'We'll take a 16K sample at 6000 Hz.
sbarrayrecord 16384,6000,holdsample%(1) 'This happens in the background, so...
while sbcheckdma=0:wend   'Wait til it's done.
print:print "Done sampling... Press a key to play it back!"
while inkey$<>"":wend  'Clear keyboard buffer
sleep:a$=inkey$
sbarrayplay 16384,6000,holdsample%(1)
print
print "Playing and Saving as SAMPLE.VOC... ";  'Note that the save
                                               'happens DURING the playback
sbarraysave "sample.voc",16384,6000,holdsample%(1)
while sbcheckdma=0:wend  'Wait til playback is done
print "Done."

'Now go on to POWDEMO7 and we'll load and use SAMPLE.VOC!
'Feel free to re-run and re-record if desired.  Old file will
'be overwritten by SBARRAYSAVE.
