$link "pow.pbl"
$include "pow.inc"

'POW! Demo #7 - Let's reload the SAMPLE.VOC file we created with
'POWDEMO6 and mess around with it a bit.  Compile this to a standalone
'.EXE file and run from the DOS prompt.

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


sv$="sample.voc"
if dir$(sv$)="" then
	line input "Path to SAMPLE.VOC: ";pth$
     if right$(pth$,1)<>"\" then pth$=pth$+"\"
     sv$=pth$+sv$
     if dir$(sv$)="" then end
end if

sbreset 'Reset the SB's DAC
redim holdsample%(1:8192)
sbarrayload sv$,ln%,sr%,holdsample%(1)  'Load the .VOC

'OK let's make some word salad... care for some roquefort
'with that? ... press any key to cancel this mess.

randomize timer
do
	sr%=int(8000*rnd(1))+4000
     sp%=int(8192*rnd(1))+1
     dly%=int(1000*rnd(1))+1
     sbarrayplay 16385-(sp%*2),sr%,holdsample%(sp%)
     sbdelay dly%
loop while inkey$=""
sbreset
