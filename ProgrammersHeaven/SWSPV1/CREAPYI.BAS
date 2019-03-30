'Creapyi.bas
'Copyright(c) Tim Truman 1997
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Requires :  Mouse
'
'Move the mouse around the screen and the eyes will follow.
'
'Notes:
'Eye images were cut and edited from a pcx file loaded into sprite.
'The PCX palette was Matched to the "default.pal".
'The first image was copied 3 times for a total of 4 eyes.
'The 2nd eye image was TURNed 90 once, the 3rd twice and the 4th 3 times.
'To correct for the image distortion cause by Mode 13's square pixels
'the 2nd and 4th frames were SQUISHed Y and STRECHed X into shape.
'
'Program expects "default.pal" and "creapyi.spr" to be in the current
'working directory. Requires a mouse.


DEFINT A-Z

TYPE HUES                     'define the type for hues.
  red AS INTEGER
  grn AS INTEGER
  blu AS INTEGER
END TYPE

DECLARE SUB mouse (func)     'declare the mouse Subroutine

'make the mouse variables global
COMMON SHARED mousex, mousey, mouseb

                                     'need this for the mouse in Qbasic.
DIM SHARED Mcode%(0 TO 56)           'array for machine code
DEF SEG = VARSEG(Mcode%(0))          'set array segment
offset% = VARPTR(Mcode%(0))          'set array address
FOR i% = 0 TO 56                     'read in machine code
 READ byte%
 POKE offset% + i%, byte%            'poke byte into array
NEXT


SCREEN 13             'Mode 13 of course

                                         'load palette after screen mode is set.
DIM Pal(255) AS HUES                     'dim array for palette
DEF SEG = VARSEG(Pal(0))                 'point to it
BLOAD "default.pal", 0                     'Use the grey scale palette
OUT &H3C8, 0                             'inform vga
FOR atrib = 0 TO 255                     'entire palette
  OUT &H3C9, Pal(atrib).red              'send red component
  OUT &H3C9, Pal(atrib).grn              'send grn component
  OUT &H3C9, Pal(atrib).blu              'send blu component
NEXT atrib                               'next attribute

Filename$ = "creapyi.spr"                'specify the file name
OPEN Filename$ FOR BINARY AS #1          'open file
filesize& = LOF(1)                       'get file size
CLOSE #1                                 'close the file
words = (filesize& - 7) \ 2 - 1          'BSAVE & BLOAD use 7 bytes
DIM SHARED image(words)                  'dim the image array
DEF SEG = VARSEG(image(0))               'point to it
BLOAD Filename$, 0                       'Bload load images to array
Imagewidth = image(0) \ 8                'calc Image width
Imageheight = image(1)                   'calc Image height
elmperimage = ((Imagewidth * Imageheight) \ 2) + 3  'calc elements per image
NumOfImages = (words / elmperimage)      'calc number of images


mouse 0    'initialize the mouse
mouse 1    'show the mouse

PRINT "click a mouse button to end "

DO
   mouse 3    'get mouse stats
   SELECT CASE mousex
   CASE 0 TO 160
     IF mousey > 140 THEN            'show eyes looking down
       PUT (130, 80), image(3 * elmperimage), PSET
       PUT (170, 80), image(3 * elmperimage), PSET
     ELSEIF mousey < 60 THEN         'show eyes lookin up
       PUT (130, 80), image(1 * elmperimage), PSET
       PUT (170, 80), image(1 * elmperimage), PSET
     ELSE                            'show eyes looking left
       PUT (130, 80), image(0), PSET
       PUT (170, 80), image(0), PSET
     END IF

   CASE 161 TO 320
     IF mousey > 140 THEN            'show eyes looking down
       PUT (130, 80), image(3 * elmperimage), PSET
       PUT (170, 80), image(3 * elmperimage), PSET
     ELSEIF mousey < 60 THEN         'show eyes lookin up
       PUT (130, 80), image(1 * elmperimage), PSET
       PUT (170, 80), image(1 * elmperimage), PSET
     ELSE                            'show eyes looking right
       PUT (130, 80), image(2 * elmperimage), PSET
       PUT (170, 80), image(2 * elmperimage), PSET
     END IF
   END SELECT

LOOP UNTIL mouseb

SCREEN 0, 0, 0       'reset screen
WIDTH 80

'machine language for mouse
DATA &H55,&H89,&HE5,&H8B,&H5E,&H0C,&H8B,&H07,&H50,&H8B
DATA &H5E,&H0A,&H8B,&H07,&H50,&H8B,&H5E,&H08,&H8B,&H0F
DATA &H8B,&H5E,&H06,&H8B,&H17,&H5B,&H58,&H1E,&H07,&HCD
DATA &H33,&H53,&H8B,&H5E,&H0C,&H89,&H07,&H58,&H8B,&H5E
DATA &H0A,&H89,&H07,&H8B,&H5E,&H08,&H89,&H0F,&H8B,&H5E
DATA &H06,&H89,&H17,&H5D,&HCA,&H08,&H00

SUB mouse (func%)
DEF SEG = VARSEG(Mcode%(0))          'set array segment
offset% = VARPTR(Mcode%(0))          'get array address


SELECT CASE func%

CASE 0  'reset mouse driver

  ax% = 0: bx% = 0: cx% = 0: dx% = 0
  CALL Absolute(ax%, bx%, cx%, dx%, offset%)
  IF ax% = 0 THEN
   ' PRINT "No mouse detected!"
   ' PRINT "Sorry, this program requires a mouse."
   ' END
  ELSE
    'PRINT "Mouse found"
  END IF


CASE 1    'mouse cursor on
  ax% = 1: bx% = 0: cx% = 0: dx% = 0
  CALL Absolute(ax%, bx%, cx%, dx%, offset%)

CASE 2    'mouse cursor off
  ax% = 2: bx% = 0: cx% = 0: dx% = 0
  CALL Absolute(ax%, bx%, cx%, dx%, offset%)

CASE 3    'get mouse statsus

  ax% = 3: bx% = 0: cx% = 0: dx% = 0
  CALL Absolute(ax%, bx%, cx%, dx%, offset%)
  mouseb% = bx%
  mousex% = cx% / 2
  mousey% = dx%


END SELECT

DEF SEG


END SUB

