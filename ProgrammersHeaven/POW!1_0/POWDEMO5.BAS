$link "pow.pbl"
$include "pow.inc"


'Strum a harp using soundblaster.
'We'll use all 9 voices for this.
'Quick attack,slow release.
'50 millisecond delay between each
'note on the "harp."

strum:
sbfmclear 'Clear the Soundblaster
for t%=0 to 2 'Strum it 3 times, with vibrato, changing harmonic each time.
              'This produces a suitably heavenly sound.
	for u%=1 to 9 'Change parameters for all channels
		call	sbfmparms(u%,0,1,0,t%)
	next u%
	sbfmnote 1,345,4,240,4,1,0:sbdelay 50
	sbfmnote 2,431,4,240,4,1,0:sbdelay 50
	sbfmnote 3,515,4,240,4,1,0:sbdelay 50
	sbfmnote 4,688,4,240,4,1,0:sbdelay 50
	sbfmnote 5,345,6,240,4,1,0:sbdelay 50
	sbfmnote 6,431,6,240,4,1,0:sbdelay 50
	sbfmnote 7,515,6,240,4,1,0:sbdelay 50
	sbfmnote 8,688,6,240,4,1,0:sbdelay 50
	sbfmnote 9,345,8,240,4,1,0:sbdelay 50
	sbdelay 250
next t%