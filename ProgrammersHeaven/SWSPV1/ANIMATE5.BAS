'Animate5.bas
'Copyright(c) Tim Truman 1997
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Animate5 similiar to Animate4 except it demostrates a more
'complicated animation, a walking character over a tiled background.
'Two images per direction are used to give a more realistic look.
'Masks are used to prevent ghosting. These images used are in
'the "char1.spr" file.
'
'The background is composed of sprite images that are tiled to the screen.
'That is, one image is used over and over unitl the sceen is filled.
'Just like tiles used to cover a floor in house.
'
'Program expects "default.pal" and "char1.spr" to be in the current
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


Filename$ = "char1.spr"
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

' tile the images over the area of the screen
FOR x = minscreenx + 1 TO maxscreenx - imagewidth STEP imagewidth
  FOR y = minscreeny + 1 TO maxscreeny - imagewidth STEP imageheight
    PUT (x, y), images(8 * elmperimage), PSET     'use floor tile image
 NEXT
NEXT

imagex = 1                 'set image start
imagey = 90                'ditto

PRINT "Use arrow keys to move image. Press ESC to Quit."

DIM buffer(elmperimage * 2)                   'to hold background

DO                                            'animation loop
                                              'get background for later
 GET (imagex, imagey)-(imagex + imagewidth, imagey + imageheight), buffer(0)

 IF imagex MOD 4 = 0 THEN           'if image has moved 4 pixes then
   frameadv = (frameadv + 2) MOD 4  'goto next image, skip mask images
 END IF

 'access mask and display
 PUT (imagex, imagey), images((imagenum + 1 + frameadv) * elmperimage), AND
 'access image and lay over mask
 PUT (imagex, imagey), images((imagenum + frameadv) * elmperimage), XOR

 DO: k$ = INKEY$: LOOP UNTIL LEN(k$)          'wait for key presses

 DO: LOOP UNTIL INP(&H3DA) AND 8              'wait for vertical retrace

 PUT (imagex, imagey), buffer(0), PSET        'restore background
 
 SELECT CASE k$                               'process key

   CASE CHR$(0) + CHR$(77)                    'right arrow key
    imagenum = 0            'set to first image of charater facing right
    imagex = imagex + 1                       'increment x position
    'keep image within screen boundary
    IF imagex > maxscreenx - imagewidth THEN imagex = maxscreenx - imagewidth

   CASE CHR$(0) + CHR$(75)                    'left arrow key
    imagenum = 4            'set to first image of charater facing right
    imagex = imagex - 1                       'decrement x position
    'keep image within screen boundary
   IF imagex < minscreenx THEN imagex = minscreenx
 END SELECT


LOOP WHILE k$ <> CHR$(27)


WIDTH 80                                'reset screen
SCREEN 0




