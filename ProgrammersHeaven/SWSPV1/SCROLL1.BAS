'Scroll1.bas
'Copyright(c) Tim Truman 1997
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Scroll1 shows how scrolling a sprite can make a cool effect.
'In this case the "tile1.spr" file is used.
'
'Program expects "default.pal" and "tile1.spr" to be in the current
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

DIM work1(elmperimage * 2)   'arrays for scrolling image
DIM work2(elmperimage * 2)


x = 160          'x position
y = 100          'y position
i = 0            'image numer
scrollmode = 5   '1 - 5

PUT (x, y), images(i * elmperimage), PSET     'use floor tile image

'DO: LOOP UNTIL LEN(INKEY$)
DO

 DO: LOOP UNTIL INP(&H3DA) AND 8   'wait for vertical retrace
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


 CASE 4 'move north west
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

 CASE 5 ' move north east
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

 LOOP UNTIL LEN(INKEY$)

WIDTH 80                                'reset screen
SCREEN 0




