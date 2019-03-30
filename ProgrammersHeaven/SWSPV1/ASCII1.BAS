'ASCII1.BAS
'Copyright(c) 1997 Tim Truman
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Demonstrates using sprite files for graphics text or 'fonts'.
'The images in "Ascii.spr" duplicate the first 128 characters
'of the ASCII set and have mask images so they can be printed
'over backgrounds.

'The fonts I made in the "font.spr" are kind of lame and not perfect
'but the premise is a good one. Who wants to use MODE 13 text ? It's ugly,
'wrecks the background and you can't print then exactly where you want.
'Plus when you use the Print statement you can't print all
'the ASCII characters.

'Did you know you can access most of all the ASCII characters and
'place them in strings ? You can do it like this:
'Press CTRL and P on the keyboard. A  ^P  will appear in Qbasic
'below right before the N and line number info. Now hold the ALT key
'and type in the ASCII number of the character would like on the
'numeric keypad. Release the ALT and the character will appear at the
'cursor. Not all ASCII characters can be printed in this fasion
'but most can.    See how I use them below.

'Program expects "default.pal" and "ascii.spr" to be in the
'current working directory.



DEFINT A-Z

TYPE HUES
  red AS INTEGER
  grn AS INTEGER
  blu AS INTEGER
END TYPE

DECLARE SUB PrintFont (text$, x, y)

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


'unrem the text you would like to see

'text$ = "	"   'ASCII characters below 33
'text$ = "!#$%&'()*,-./0123456789:;<=>? "
'text$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
'text$ = "[\]^_`abcdefghijklmnopqrstuvwxyz{|}~" + CHR$(127)
'text$ = " hello there"
'text$ = " Please register Sprite! It's only $5 dollars."
text$ = "                 Sprite 2.0 is great !"

x = 10
y = 70
PrintFont text$, x, y

DO: LOOP UNTIL LEN(INKEY$)


WIDTH 80                               'reset screen
SCREEN 0

SUB PrintFont (text$, x, y)

'routine expects images() array ,imagewidth, imageheight and elmpersprite
'variables to be global.



length = LEN(text$)                    'get characters to print
IF length = 0 THEN EXIT SUB            'check length

FOR char = 0 TO length - 1             'print loop

   piece$ = MID$(text$, char + 1, 1)   'look at each piece of string
   ASCII = ASC(piece$)                 'assign it's ASCII value
   
   ASCII = (ASCII * 2)  'skip masks

   
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

  
   PUT (x + kernx, y + kerny), images((ASCII + 1) * elmperimage), AND'put mask
   PUT (x + kernx, y + kerny), images(ASCII * elmperimage), XOR  'put image
   'PRINT ascii

   'this will space out the fonts. Depending on the font size and width
   'of each image the kern will be different.this one is adjusted for
   'font.spr.

   SELECT CASE (piece$)               'x kern adjusment
   'CASE "a": kernx = kernx + imagewidth - 2
   'CASE "l": kernx = kernx + imagewidth - 5
   CASE "a" TO "z": kernx = kernx + imagewidth
   CASE "'": kernx = kernx + imagewidth - 4
   CASE " ": kernx = kernx + imagewidth - 2
   CASE ".": kernx = kernx + imagewidth - 5
   CASE "!": kernx = kernx + imagewidth - 4
   CASE ELSE: kernx = kernx + imagewidth + 1     'ditto
   END SELECT

   kerny = 0                           'reset

NEXT



END SUB

