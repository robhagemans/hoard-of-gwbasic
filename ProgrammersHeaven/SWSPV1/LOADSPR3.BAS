'Loadspr3.bas
'Copyright(c) Tim Truman 1997
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Loadspr3 displays "sqeeter2.spr" like tiles to replicate the original
'PCX image. You'll notice that this loads instantly. If you have ever
'used a PCX loader in QBasic you know how slow it can it be.
'The "sqeeter2.spr" file is the PCX file "sqeeter.pcx"
'saved as a sprite file.
'
'Program expects "default.pal" and "sqeeter2.spr" to be in the current
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
BLOAD "default.pal", 0                   'load the palette
OUT &H3C8, 0                             'inform vga
FOR atrib = 0 TO 255                     'entire palette
 OUT &H3C9, Pal(atrib).red               'send red component
 OUT &H3C9, Pal(atrib).grn               'send grn component
 OUT &H3C9, Pal(atrib).blu               'send blu component
NEXT atrib                               'next attribute

'set up arrays and varables for first file. In this case catapil1.spr.

Filename$ = "sqeeter2.spr"
OPEN Filename$ FOR BINARY AS #1         'open file
filesize& = LOF(1)                      'get file size
CLOSE #1                                'close the file
words = (filesize& - 7) \ 2 - 1         'BSAVE & BLOAD use 7 bytes for header
DIM SHARED images(words)               'dim the image array
DEF SEG = VARSEG(images(0))            'point to it
BLOAD Filename$, 0                      'Bload the sprite file
imagewidth = images(0) \ 8            'calculate image width
imageheight = images(1)               'calculate image height
ElmPerImage = ((imagewidth * imageheight) \ 2) + 3  'calc elements per image
NumOfImages = (words / ElmPerImage)      'calculate number of images


xsprites = 319 \ imagewidth            'calc how many fit across
xend = imagewidth * xsprites           'last x position
Ysprites = 199 \ imageheight           'calc how many fit high
yend = imageheight * Ysprites          'last y pos

xstart = 24


FOR i = 0 TO NumOfImages - 1                      'first to last

  PUT (x + xstart, y), images(i * ElmPerImage), PSET  'show image
  x = x + imagewidth
  IF x = xend THEN
    y = y + imageheight
    x = 0
  END IF
  
NEXT                                              'next image




DO: LOOP UNTIL LEN(INKEY$)                     'wait for key press

WIDTH 80                                          'reset screen
SCREEN 0

