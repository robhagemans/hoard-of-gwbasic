'Animate3.BAS
'Copyright(c) 1997 Tim Truman
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Animate3 demonstrates text book sprite animation.
'1. save background
'2. draw image
'3. change location
'4. erase old image
'5. restore background
'6. back to 1
'This example uses sprite file "car.spr". It contains a special image
'called a mask. A mask image is used in conjunction with a the actual image
'to retain the background around the image. This prevents 'ghosting', that
'black square you get when you place an image over a background using the
'PSET action verb with the PUT statement.
'
'Masks of an image can easily be made in sprite. Make a copy of the
'image you want to mask. Click on the copy and select 'Mask' from the
'edit menu. Tada... instant mask.
'
'You will probably notice a little flicker. This can be minimized by
'using delays or waiting for the vertical retrace period to occur in the
'video hardware. How do you know when that occurs ? Unrem the line right
'after getting the keyboard input. ...That's better.

'Program expects "default.pal" and "car.spr" to be in the current
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


Filename$ = "car.spr"                    'specify sprite file
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

imagex = 160          'current sprite position
imagey = 100          'ditto

DIM buffer(elmperimage * 2)                      'to hold background
                                                 'create a background
FOR x = minscreenx TO maxscreenx                 'cover screen
 LINE (x, minscreeny)-(x, maxscreeny), c         'draw colored line
 c = (c + 1) MOD 256                             'next color
NEXT

PRINT "Use arrow keys to move image. Press ESC to Quit."

DO                                            'animation loop
                                               'get background for later
 GET (imagex, imagey)-(imagex + imagewidth, imagey + imageheight), buffer(0)
 PUT (imagex, imagey), images(1 * elmperimage), AND 'access mask and display
 PUT (imagex, imagey), images(0 * elmperimage), XOR 'acess image and lay over mask
 
 DO: k$ = INKEY$: LOOP UNTIL LEN(k$)          'wait for key presses

 'unrem next line to prevent flicker
 'DO: LOOP UNTIL INP(&H3DA) AND 8              'wait for vertical retrace

 PUT (imagex, imagey), buffer(0), PSET        'restore background
  
 SELECT CASE k$                               'process key

   CASE CHR$(0) + CHR$(77)                    'right arrow key
    imagex = imagex + 1                       'increment x position
    'keep image within screen boundary
    IF imagex > maxscreenx - imagewidth THEN imagex = maxscreenx - imagewidth

   CASE CHR$(0) + CHR$(75)                    'left arrow key
    imagex = imagex - 1                       'decrement x position
    'keep image within screen boundary
    IF imagex < minscreenx THEN imagex = minscreenx

   CASE CHR$(0) + CHR$(72)                    'up arrow key
    imagey = imagey - 1                       'decrement y position
    'keep image within screen boundary
    IF imagey < minscreeny THEN imagey = minscreeny
  
   CASE CHR$(0) + CHR$(80)                    'down arrow key
    imagey = imagey + 1                       'increment y position
    'keep image within screen boundary
    IF imagey > maxscreeny - imagewidth THEN imagey = maxscreeny - imagewidth
 END SELECT


LOOP WHILE k$ <> CHR$(27)


WIDTH 80                               'reset screen
SCREEN 0

