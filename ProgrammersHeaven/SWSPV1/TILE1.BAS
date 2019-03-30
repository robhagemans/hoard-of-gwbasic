'Tile1.bas
'Copyright(c) Tim Truman 1997
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Tile1 shows how tiling a screen can make interesting backgrounds.
'Programs uses tile1.spr. Tiles are 21x21 in size.
'Press any key during the program to cycle through the different backgrounds.
'
'Program expects "default.pal" and "tile1.spr" to be in the current
'working directory.


DEFINT A-Z

TYPE HUES
  red AS INTEGER
  grn AS INTEGER
  blu AS INTEGER
END TYPE

CONST minscreenx = 0                     'video mode constants
CONST minscreeny = 0
CONST maxscreenx = 319
CONST maxscreeny = 199

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


Filename$ = "tile1.spr"
OPEN Filename$ FOR BINARY AS #1         'open file
filesize& = LOF(1)                      'get file size
CLOSE #1                                'close the file
words = (filesize& - 7) \ 2 - 1         'BSAVE & BLOAD use 7 bytes for header
DIM SHARED images(words)                 'dim the image array
DEF SEG = VARSEG(images(0))              'point to it
BLOAD Filename$, 0                      'Bload the sprite file
imagewidth = images(0) \ 8               'calculate image width
imageheight = images(1)                  'calculate image height
elmperimage = ((imagewidth * imageheight) \ 2) + 3  'calc elements per image
NumOfImages = (words / elmperimage)      'calculate number of images

' create the background

FOR i = 0 TO NumOfImages - 1
FOR x = minscreenx + 1 TO maxscreenx - imagewidth STEP imagewidth
  FOR y = minscreeny + 1 TO maxscreeny - imagewidth STEP imageheight
    PUT (x, y), images(i * elmperimage), PSET     'use floor tile image
 NEXT
NEXT
DO: LOOP UNTIL LEN(INKEY$)
NEXT


WIDTH 80                                'reset screen
SCREEN 0




