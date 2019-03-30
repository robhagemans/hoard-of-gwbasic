'Scroll2.bas
'Copyright(c) Tim Truman 1997
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Scroll2 shows how scrolling a sprite and tiling it to the
'entire screen can be dazzling . In this case the "examples.spr"
'file is used. Try experimenting with different sprite files.
'
'Program expects "default.pal" and "examples.spr" to be in the current
'working directory. For best results run this program in DOS mode.

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


Filename$ = "examples.spr"
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

DIM work1(elmperimage * 2)   'arrays for scrolling image
DIM work2(elmperimage * 2)
DIM work3(elmperimage * 2)

x = imagewidth + 14     'upper corner to start
y = imageheight         'ditto
i = 53                  'image numer to use
scrollmode = 0          'scrool mode (0 - 5)

PUT (x, y), images((i + adv) * elmperimage), PSET   'put image

DO                                           'animation loop

 
 
 SELECT CASE scrollmode

 CASE 0   'move west

 GET (x, y)-(x, y + imageheight - 1), work2(0)
 GET (x + 1, y)-(x + imagewidth - 1, y + imageheight - 1), work1(0)
 PUT (x + imagewidth - 1, y), work2(0), PSET
 PUT (x, y), work1(0), PSET

 CASE 1   'move north

 GET (x, y)-(x + imagewidth - 1, y), work2(0)
 GET (x, y + 1)-(x + imagewidth - 1, y + imageheight - 1), work1(0)
 PUT (x, y + imagewidth - 1), work2(0), PSET
 PUT (x, y), work1(0), PSET

 CASE 2   'move east

 GET (x + imagewidth - 1, y)-(x + imagewidth - 1, y + imageheight - 1), work2(0)
 GET (x, y)-(x + imagewidth - 2, y + imageheight - 1), work1(0)
 PUT (x, y), work2(0), PSET
 PUT (x + 1, y), work1(0), PSET

 CASE 3   'move south

 GET (x, y + imageheight - 1)-(x + imagewidth - 1, y + imageheight - 1), work2(0)
 GET (x, y)-(x + imagewidth - 1, y + imageheight - 2), work1(0)
 PUT (x, y), work2(0), PSET
 PUT (x, y + 1), work1(0), PSET

 CASE 4   'move north west
  'north
  GET (x, y)-(x + imagewidth - 1, y), work2(0)
  GET (x, y + 1)-(x + imagewidth - 1, y + imageheight - 1), work1(0)
  PUT (x, y + imagewidth - 1), work2(0), PSET
  PUT (x, y), work1(0), PSET
  'west
  GET (x, y)-(x, y + imageheight - 1), work2(0)
  GET (x + 1, y)-(x + imagewidth - 1, y + imageheight - 1), work1(0)
  PUT (x + imagewidth - 1, y), work2(0), PSET
  PUT (x, y), work1(0), PSET

 CASE 5   'move north east
  'north
  GET (x, y)-(x + imagewidth - 1, y), work2(0)
  GET (x, y + 1)-(x + imagewidth - 1, y + imageheight - 1), work1(0)
  PUT (x, y + imagewidth - 1), work2(0), PSET
  PUT (x, y), work1(0), PSET
  'east
  GET (x + imagewidth - 1, y)-(x + imagewidth - 1, y + imageheight - 1), work2(0)
  GET (x, y)-(x + imagewidth - 2, y + imageheight - 1), work1(0)
  PUT (x, y), work2(0), PSET
  PUT (x + 1, y), work1(0), PSET

 END SELECT


 'get the scrolled image in upper left corner of screen
 GET (x, y)-(x + imagewidth - 1, y + imageheight - 1), work3(0)

 'this will smooth out the effect
 DO: LOOP UNTIL INP(&H3DA) AND 8   'wait for vertical retrace

 'and tile it over the most of the screen
 FOR tx = minscreenx + x TO maxscreenx - imagewidth - x STEP imagewidth
  FOR ty = minscreeny + y TO maxscreeny - imageheight - y STEP imageheight
     PUT (tx, ty), work3(0), PSET     'use floor tile image
  NEXT
 NEXT
 

LOOP UNTIL LEN(INKEY$)

WIDTH 80                                'reset screen
SCREEN 0




