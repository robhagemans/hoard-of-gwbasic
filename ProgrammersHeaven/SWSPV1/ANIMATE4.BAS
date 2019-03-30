'Animate 4.bas
'Copyright(c) Tim Truman 1997
'
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Animate4 shows how playing images in sequence can produce
'some very cool animations. This program uses "SUN1.SPR". I first
'created a circle and made 11 copies of it, the most images available
'when creating 64x64 images in sprite. Then I added the detail to
'each image. Using the Animate feature in Sprite helped a lot.
'
'Program expects "default.pal" and "sun1.spr" to be in the current
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


Filename$ = "sun1.spr"
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


DO                                                'animation loop

FOR i = 0 TO NumOfImages - 1                      'first to last
  PUT (140, 40), image(i * ElmPerImage), PSET     'show image
  LOCATE 15, 10: PRINT "Image number"; i          'display image number
  samp! = TIMER                                   'delay
  DO: LOOP UNTIL ABS(TIMER - samp!) > .1
NEXT                                              'next image
LOOP UNTIL LEN(INKEY$)                            'loop unitl keypress

WIDTH 80                                          'reset screen
SCREEN 0

