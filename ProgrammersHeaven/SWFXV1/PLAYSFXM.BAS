'Name      : Playsfxm.bas
'Purpose   : Loads and plays a sound effect from an .SFX file using Main
'Date      : 1/22/97
'Finalized :
'Author    : Tim Truman
'Copyright (c) 1997  Nocturnal Creations. All Rights Reserved
'
'Feel free to use this code in your distributed programs. Perhaps you could
'mention the FX program in your own? Thanks.

DECLARE SUB playsfx (sfx$)

CLS

DIM SHARED c$(8)   'FM register information for 9 channels
c$(0) = "&hB0&h20&h23&h40&h43&h60&h63&h80&h83&hA0&HBD&HC0&HE0&HE3&hB0"
c$(1) = "&hB1&h21&h24&h41&h44&h61&h64&h81&h84&hA1&HBD&HC1&HE1&HE4&hB1"
c$(2) = "&hB2&h22&h25&h42&h45&h62&h65&h82&h85&hA2&HBD&HC2&HE2&HE5&hB2"
c$(3) = "&hB3&h28&h2B&h48&h4B&h68&h6B&h88&h8B&hA3&HBD&HC3&HE8&HEB&hB3"
c$(4) = "&hB4&h29&h2C&h49&h4C&h69&h6C&h89&h8C&hA4&HBD&HC4&HE9&HEC&hB4"
c$(5) = "&hB5&h2A&h2D&h4A&h4D&h6A&h6D&h8A&h8D&hA5&HBD&HC5&HEA&HED&hB5"
c$(6) = "&hB6&h30&h33&h50&h53&h70&h73&h90&h93&hA6&HBD&HC6&HF0&HF3&hB6"
c$(7) = "&hB7&h31&h34&h51&h54&h71&h74&h91&h94&hA7&HBD&HC7&HF1&HF4&hB7"
c$(8) = "&hB8&h32&h35&h52&h55&h72&h75&h92&h95&hA8&HBD&HC8&HF2&HF5&hB8"


DIM sfx$(25)                           'dim array to hold the 26 sounds
OPEN "Various.sfx" FOR INPUT AS #1     'open the .SFX file
FOR fxnum% = 0 TO 25                   'load all sounds
 INPUT #1, sfx$(fxnum%)                'load sound into string
NEXT                                   'next
CLOSE #1                               'close the file


FOR sfxnum% = 0 TO 25
  
  chan% = VAL(MID$(sfx$(sfxnum%), 61, 4))
  FOR in = 1 TO 60 STEP 4
    reg$ = MID$(c$(chan%), in, 4): reg% = VAL(reg$)
    dat$ = MID$(sfx$(sfxnum%), in, 4): dat% = VAL(dat$)
    OUT &H388, reg%: FOR d% = 1 TO 6: b% = INP(&H388): NEXT
    OUT &H389, dat%: FOR d% = 1 TO 35: b% = INP(&H388): NEXT
  NEXT

  LOCATE 5, 1: PRINT "Playing Sound effect"; sfxnum%
  LOCATE 6, 1: PRINT "Press any key to hear next sound."
  DO: LOOP UNTIL LEN(INKEY$)           'wait for key press

NEXT

SUB playsfx (sfx$)

chan = VAL(MID$(sfx$, 61, 4))
FOR in = 1 TO 60 STEP 4
  reg$ = MID$(c$(chan), in, 4): reg = VAL(reg$)
  dat$ = MID$(sfx$, in, 4): dat = VAL(dat$)
  OUT &H388, reg: FOR i1 = 1 TO 6: p = INP(&H388): NEXT
  OUT &H389, dat: FOR i1 = 1 TO 35: p = INP(&H388): NEXT
NEXT

END SUB

