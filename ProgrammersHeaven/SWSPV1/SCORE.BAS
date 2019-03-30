'Score.bas
'Copyright(c) Tim Truman 1997
'
'This program may not be distributed without the
'Shareware version of SPRITE 2.0. You may however freely use
'the concepts and code present here in your own programs.
'
'Score demonstrates using sprite images to display number values. I used
'this routine to display gamescores my games.
'
'Program expects "default.pal" and "num1.spr"  to be in the current
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
BLOAD "default.pal", 0                   'load the goods
OUT &H3C8, 0                             'inform vga
FOR atrib = 0 TO 255                     'entire palette
 OUT &H3C9, Pal(atrib).red               'send red component
 OUT &H3C9, Pal(atrib).grn               'send grn component
 OUT &H3C9, Pal(atrib).blu               'send blu component
NEXT atrib                               'next attribute

'set up arrays and varables for first file. In this case catapil1.spr.

Filename$ = "nums1.spr"
OPEN Filename$ FOR BINARY AS #1         'open file
filesize& = LOF(1)                      'get file size
CLOSE #1                                'close the file
words = (filesize& - 7) \ 2 - 1         'BSAVE & BLOAD use 7 bytes for header
DIM SHARED images(words)               'dim the image array
DEF SEG = VARSEG(images(0))            'point to it
BLOAD Filename$, 0                      'Bload the sprite file
imagewidth = images(0) \ 8            'calculate image width
Imageheight = images(1)               'calculate image height
elmPerimage = ((imagewidth * Imageheight) \ 2) + 3  'calc elements per image
NumOfImages = (words / elmPerimage)      'calculate number of images


xscore = 100         'print locations for score
yscore = 70
xstep = imagewidth   'width between images
startframe = 0       'starting frame where the first number digit begins
                     'in the sprite file. In the case of nums1.spr it
                     'is the first image (frame 0).
                     

DO

 LOCATE 1, 1
 PRINT "Enter a value between 1 and 99999 "
 INPUT "Enter 0 to end  :", gamescore&
 CLS

 onedigit = (gamescore& \ 1) MOD 10
 tendigit = (gamescore& \ 10) MOD 10
 hdigit = (gamescore& \ 100) MOD 10
 tdigit = (gamescore& \ 1000) MOD 10
 ttdigit = (gamescore& \ 10000) MOD 10

 PUT (xscore, yscore), images(startframe + (ttdigit * elmPerimage)), PSET
 PUT (xscore + xstep, yscore), images(startframe + (tdigit * elmPerimage)), PSET
 PUT (xscore + (xstep * 2), yscore), images(startframe + (hdigit * elmPerimage)), PSET
 PUT (xscore + (xstep * 3), yscore), images(startframe + (tendigit * elmPerimage)), PSET
 PUT (xscore + (xstep * 4), yscore), images(startframe + (onedigit * elmPerimage)), PSET


LOOP UNTIL gamescore& = 0                     'wait for key press

WIDTH 80                                          'reset screen
SCREEN 0

