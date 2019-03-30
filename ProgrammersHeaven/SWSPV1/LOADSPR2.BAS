'Loadspr2.bas
'Copyright(c) Tim Truman 1997
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Loadspr2 demonstrates accessing and displaying images in sprite files
'of different sizes.
'
'Program expects "default.pal" , "catapil1.spr" and "sqeeter1.spr"
'to be in the current working directory.

DEFINT A-Z

TYPE HUES
  red AS INTEGER
  grn AS INTEGER
  blu AS INTEGER
END TYPE

SCREEN 13                                'change mode

DIM Pal(255) AS HUES                     'dim array for palette
DEF SEG = VARSEG(Pal(0))                 'point to it
BLOAD "default.pal", 0                   'load the goods
OUT &H3C8, 0                             'inform vga
FOR atrib = 0 TO 255                     'entire palette
 OUT &H3C9, Pal(atrib).red               'send red component
 OUT &H3C9, Pal(atrib).grn               'send grn component
 OUT &H3C9, Pal(atrib).blu               'send blu component
NEXT atrib                               'next attribute

'set up arrays and varables for first file. In this case catapil1.spr.

Filename$ = "catapil1.spr"
OPEN Filename$ FOR BINARY AS #1         'open file
filesize& = LOF(1)                      'get file size
CLOSE #1                                'close the file
words = (filesize& - 7) \ 2 - 1         'BSAVE & BLOAD use 7 bytes for header
DIM SHARED images1(words)               'dim the image array
DEF SEG = VARSEG(images1(0))            'point to it
BLOAD Filename$, 0                      'Bload the sprite file
Imagewidth1 = images1(0) \ 8            'calculate image width
Imageheight1 = images1(1)               'calculate image height
ElmPerImage1 = ((Imagewidth1 * Imageheight1) \ 2) + 3  'calc elements per image
NumOfImages1 = (words / ElmPerImage1)      'calculate number of images


'set up arrays and varables for second file. In this case sqeeter1.spr.

Filename$ = "sqeeter1.spr"
OPEN Filename$ FOR BINARY AS #1         'open file
filesize& = LOF(1)                      'get file size
CLOSE #1                                'close the file
words = (filesize& - 7) \ 2 - 1         'BSAVE & BLOAD use 7 bytes for header
DIM SHARED images2(words)                 'dim the image array
DEF SEG = VARSEG(images2(0))              'point to it
BLOAD Filename$, 0                      'Bload the sprite file
Imagewidth2 = images2(0) \ 8             'calculate image width
Imageheight2 = images2(1)                 'calculate image height
ElmPerImage2 = ((Imagewidth2 * Imageheight2) \ 2) + 3  'calc elements per image
NumOfImages2 = (words / ElmPerImage2)      'calculate number of images


imagenum1 = 0  'show sprite 1 in first file
PUT (80, 40), images1(imagenum1 * ElmPerImage1), PSET

imagenum2 = 1  'show sprite 2 in second file
PUT (160, 40), images2(imagenum2 * ElmPerImage2), PSET

'imagenum1 and imagenum2 can be changed to show any sprite in the sprite
'file. Don't specify a imagenum that is greater than the number of images
'contained in the file or you will get an 'subscript out of range' error.


DO: LOOP UNTIL LEN(INKEY$)                     'wait for key press

WIDTH 80                                          'reset screen
SCREEN 0

