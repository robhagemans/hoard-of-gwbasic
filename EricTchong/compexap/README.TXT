EXTRA INSTRUCTIONS FOR COMPEXPA.BAS !

Before expanding a basfile do these 2 steps first:

	1) renum your file with the command: RENUM 50,,50
	2) save this as an ascii file -----> SAVE"filename.bas",a


Before compressing an ascii basfile check this first:

	- in a REM or ' line you should never have a : character
	- PRINT "whatever and should always end with " <--- strange
things happen if you don't have the " at then end
	- make sure your file is as small as possible. So RENUM is OK
and NOT renum 50,,50

Abobe quirks I have discovered when I expanded or compressed the
fraction.bas file. See results in zip file...

Enjoy!
Eric Tchong
