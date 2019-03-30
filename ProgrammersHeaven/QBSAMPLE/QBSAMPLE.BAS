DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)

'QB4.5 code to record a sample from the
'Soundblaster's Mic/Line Input and then
'play it back.  It does not detect for a
'Soundblaster, it's assumed that one is
'available.

'This will be too slow in the IDE - run
'as a standalone .EXE file.

'(C) Copyright 1994 by Tim Gerchmez
'This code may be freely shared and
'distributed by any means desired.

bp% = &H220   'Soundblaster Base Port, change to &h240 or whatever
              'for different hardware configuration

CALL sbreset(bp%) 'Reset the Soundblaster card

CLS : PRINT
PRINT "Soundblaster Sample/Playback (direct, non-DMA)"
PRINT
INPUT "Length of Sample (1-32766)"; ls%
IF ls% < 1 OR ls% > 32766 THEN END
PRINT
PRINT "Speak into the Microphone or start input to"
PRINT "Line In jack.  Press a key to begin sampling."
SLEEP
PRINT : PRINT "Now Sampling..."

REDIM smp%(1 TO ls%)

FOR t% = 1 TO ls%
        smp%(t%) = samplebyte(bp%)
        FOR u% = 1 TO 25: NEXT u%  'Delay a little
NEXT t%

'Now play the sample back

CALL writedsp(&HD1, bp%)  'Turn speaker on
FOR t% = 1 TO ls%
        CALL writedsp(&H10, bp%)
        CALL writedsp(smp%(t%), bp%)
NEXT t%
CALL writedsp(&HD3, bp%)  'Turn speaker off

FUNCTION samplebyte% (bp%)

'Samples a byte from the SB's ADC, and returns
'the resultant byte.  Call with BP% = SB base port
'(normally &h220)


CALL writedsp(&H20, bp%) 'Command to sample one byte
datavail% = bp% + 14
dly:
        IF INP(datavail%) AND &H80 = 0 THEN GOTO dly
datread% = bp% + 10
bt% = INP(datread%)
samplebyte% = bt%

END FUNCTION

SUB sbreset (bp%)

'Resets the Soundblaster chip -
'call with bp% = Base Port (normally &h220)

dspreset% = bp% + 6
OUT dspreset%, 1
FOR t% = 1 TO 10
        a% = INP(dspreset%)  'Delay loop, give SB time to reset
NEXT t%
OUT dspreset%, 0
dspread% = bp% + 10
FOR t% = 1 TO 10
        a% = INP(dspread%)
NEXT t%

END SUB

SUB writedsp (byte%, bp%)

'Writes to the Soundblaster's DSP Command Channel -
'call with bp% = SB base port (normally &h220)
'byte% = byte to write to DSP

dspcmd% = bp% + 12
FOR t% = 1 TO 8
        q% = INP(dspcmd%) 'Delay to give SB time to process code
NEXT t%
OUT dspcmd%, byte%



END SUB

