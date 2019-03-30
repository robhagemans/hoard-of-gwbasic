$link "pow.pbl"
$include "pow.inc"


'POW! Demo number 4 - speech driver interface
'
'Compile this program to a standalone .EXE, then
'exit the IDE, load the SBTALKER program (SBTALKER /DBLASTER),
'and run this program from the DOS command line.  If you have
'EMS memory, SBTALKER should only take about 14K or so of main
'DOS memory.  Unload with SBTALKER /U.


q%=pbvhost
shift right q%,5
if q% and 1 then
	print:print "Please run from a standalone .EXE only."
     end
end if

if sbspeech=0 then print:print "SB Speech driver required - please load and rerun this demo.":stop

sbsay "Hello there how are you.  This is a test of ess bee speech and ess bee say in the pow toolbox."
sbsay "These roo teens provide you with an inter face to the speech driver, which you are experiencing right now."
sbsay "Hope you enjoy using the pow library for power basic."
stop
