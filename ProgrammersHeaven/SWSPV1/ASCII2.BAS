'ASCII2.BAS
'Copyright(c) 1997 Tim Truman
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'ASCII2 demostrates an animation technique.
'The Printfont subroutine has been modified to save the background .
'A new routine Stay has been added for small delays.
'
'Now the text can be animated in various ways. This example shows
'a marque display like the one in windows.

'Program expects "default.pal" and "ascii.spr" to be in the
'current working directory. For best results run this program in DOS mode.



DEFINT A-Z

TYPE HUES
  red AS INTEGER
  grn AS INTEGER
  blu AS INTEGER
END TYPE

DECLARE SUB PrintFont (text$, x, y, mode)
DECLARE SUB stay (Millisecs)


'the following variables must be global so the PrintFont
'routine can use them.
COMMON SHARED imagewidth, imageheight, elmperimage

CONST minscreenx = 0                     'video mode constants
CONST minscreeny = 0
CONST maxscreenx = 319
CONST maxscreeny = 199

SCREEN 13                                'change mode
                                         'load palette
palspec$ = "default.pal"                 'set palette specification
DIM Pal(255) AS HUES                     'dim array for palette
DEF SEG = VARSEG(Pal(0))                 'point to it
BLOAD palspec$, 0                        'load the goods
OUT &H3C8, 0                             'inform vga
FOR atrib = 0 TO 255                     'entire palette
 OUT &H3C9, Pal(atrib).red               'send red component
 OUT &H3C9, Pal(atrib).grn               'send grn component
 OUT &H3C9, Pal(atrib).blu               'send blu component
NEXT atrib                               'next attribute


Filename$ = "ASCII.spr"                   'specify sprite file
OPEN Filename$ FOR BINARY AS #1          'open file
filesize& = LOF(1)                       'get file size
CLOSE #1                                 'close the file
words = (filesize& - 7) \ 2 - 1          'BSAVE & BLOAD use 7 bytes
DIM SHARED images(words)                 'dim the target array
DEF SEG = VARSEG(images(0))              'point to it
BLOAD Filename$, 0                       'load the sprite file
imagewidth = images(0) \ 8               'calc Image width
imageheight = images(1)                  'calc Image height
elmperimage = ((imagewidth * imageheight) \ 2) + 3  'calc elements per image
NumOfImages = (words / elmperimage)                'calc number of images


'draw a background
 
FOR x = minscreenx TO maxscreenx                 'cover screen
 LINE (x, minscreeny)-(x, maxscreeny), c         'draw colored line
 c = ((c + 1) MOD 16) + 32                       'next color
NEXT

'marquee text

text$ = " ftp.aol.members/TimTruman      "  'Don't make this too big!
length = LEN(text$)         'get length of text$
x = 50                      'set start x
y = 70                      'set start y
PrintFont text$, x, y, 0 'initalize the print

DO
 
  firstchar$ = MID$(text$, 1, 1)      'get first character in string
  FOR char = 2 TO length              'rebuild string
    nextchar$ = MID$(text$, char, 1)
    newtext$ = newtext$ + nextchar$
  NEXT
  text$ = newtext$ + firstchar$     'add first character to end of string
  newtext$ = ""                     'reset
  PrintFont text$, x, y, 1          'retore background
  PrintFont text$, x, y, 0          'print
  stay (315)                        'need a small delay
  DO: LOOP UNTIL INP(&H3DA) AND 8   'wait for vertical retrace

LOOP UNTIL LEN(INKEY$)


WIDTH 80                               'reset screen
SCREEN 0

SUB PrintFont (text$, x, y, mode)

'routine expects images() array ,imagewidth, imageheight and elmpersprite
'variables to be global.
'text$ - text to be printed
'x     - x location
'y     - y location
'mode  - 0 = save background/print text. 1 = restore background

STATIC backbuffer()

IF mode = 0 THEN
 length = LEN(text$)                    'get characters to print
 IF length = 0 THEN EXIT SUB            'check length

 size = (elmperimage * 2) * length
 REDIM backbuffer(size)
 GET (x, y)-(x + (imagewidth * length), y + imageheight + 2), backbuffer

 FOR char = 0 TO length - 1             'print loop

   piece$ = MID$(text$, char + 1, 1)   'look at each piece of string
   ascii = ASC(piece$)                 'assign it's ASCII value
   
   IF ascii > 127 THEN EXIT SUB        'ascii.spr has only first 128
   ascii = (ascii * 2)  'skip masks

   
   'Now we need to apply some kern so the images will come out correctly.
   'some lower case letters in the font file have tails so we need to
   'drop them to there height is the same as the other charactors.
   

   SELECT CASE (piece$)                'adjust lower case
   CASE "g": kerny = kerny + 2         'ditto
   CASE "j": kerny = kerny + 2         'ditto
   CASE "p": kerny = kerny + 2         'ditto
   CASE "q": kerny = kerny + 2         'ditto
   CASE "y": kerny = kerny + 2         'ditto
   END SELECT

   IF x + kernx >= minscreenx AND x + kernx <= maxscreenx - imagewidth THEN 'its ok to print
     IF y + kerny >= minscreeny AND y + kerny <= maxscreeny - imageheight THEN
       PUT (x + kernx, y + kerny), images((ascii + 1) * elmperimage), AND   'put mask
       PUT (x + kernx, y + kerny), images(ascii * elmperimage), XOR         'put image
     END IF
   END IF
   

   'This will space out the fonts. Depending on the font size and width
   'of each image the kern will be different. This one is adjusted for
   'font.spr.

   SELECT CASE (piece$)               'x kern adjusment
   CASE "a" TO "z": kernx = kernx + imagewidth
   CASE "'": kernx = kernx + imagewidth - 4
   CASE " ": kernx = kernx + imagewidth - 2
   CASE ".": kernx = kernx + imagewidth - 5
   CASE "!": kernx = kernx + imagewidth - 4
   CASE ELSE: kernx = kernx + imagewidth + 1     'ditto
   END SELECT

   kerny = 0                           'reset

 NEXT

 
ELSEIF mode = 1 THEN

  PUT (x, y), backbuffer(0), PSET

END IF


END SUB

SUB stay (Millisecs)

'millisecs - number of milliseconds to delay.

'Stay calculates realitive system speed. Using stay will provide
'accurate delays on all machines.

STATIC syspeed&, Time2

IF syspeed& THEN                ' First time here -get relative system speed
  IF Millisecs THEN             ' Start Delay loop
    
     Factor& = (syspeed& * Millisecs) \ 55          'num of loops needed
   
     DO                                             ' delay loop
       Factor& = Factor& - 1                        ' Sub the num of loops
     LOOP UNTIL Time2 = PEEK(&H6C) OR Factor& = 0   ' make loop same as below

  END IF
ELSE                               ' Relative system speed processed here
  DEF SEG = &H40
  Time1 = PEEK(&H6C)

  DO
    Time2 = PEEK(&H6C)             ' get another
  LOOP UNTIL Time1 <> Time2        ' loop until new clock tick

  DO                               ' start here at new clock tick
    syspeed& = syspeed& - 1        ' Count the number of times looped
  LOOP UNTIL Time2 <> PEEK(&H6C) OR syspeed& = 0  'make same as loop above
   Time2 = 1255
   syspeed& = ABS(syspeed&)        'cant use this neg -reverse it

END IF


END SUB

