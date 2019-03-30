'Loadspr1.bas
'Copyright(c) Tim Truman 1997
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Loadspr1 demonstrates accessing and displaying images in multiple
'image sprite files.
'
'Program expects "default.pal" and "examples.spr" to be in the current
'working directory.

DEFINT A-Z

TYPE HUES
  red AS INTEGER
  grn AS INTEGER
  blu AS INTEGER
END TYPE

SCREEN 13                                'change mode

DIM Pal(255) AS HUES                     'dim array for palette
DEF SEG = VARSEG(Pal(0))                 'point to it
BLOAD "default.pal", 0                   'load the palette data
OUT &H3C8, 0                             'inform vga
FOR atrib = 0 TO 255                     'entire palette
 OUT &H3C9, Pal(atrib).red               'send red component
 OUT &H3C9, Pal(atrib).grn               'send grn component
 OUT &H3C9, Pal(atrib).blu               'send blu component
NEXT atrib                               'next attribute


Filename$ = "Examples.spr"
OPEN Filename$ FOR BINARY AS #1         'open file
filesize& = LOF(1)                      'get file size
CLOSE #1                                'close the file
words = (filesize& - 7) \ 2 - 1         'BSAVE & BLOAD use 7 bytes for header
DIM SHARED image(words)                 'dim the image array
DEF SEG = VARSEG(image(0))              'point to it
BLOAD Filename$, 0                      'Bload the sprite file
Imagewidth = image(0) \ 8               'calculate image width
Imageheight = image(1)                  'calculate image height
ElmPerImage = ((Imagewidth * Imageheight) \ 2) + 3  'calc elements per image
NumOfImages = (words / ElmPerImage)      'calculate number of images


FOR i = 0 TO NumOfImages - 1                      'first to last
  PUT (140, 40), image(i * ElmPerImage), PSET     'show image
  LOCATE 15, 10: PRINT "Image number"; i          'display image number
  DO: LOOP UNTIL LEN(INKEY$)                      'wait for key press
NEXT                                              'next image
  

WIDTH 80                                          'reset screen
SCREEN 0

