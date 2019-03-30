'  Here's the 3D corridor.  See if you can make it into a proper maze.
'
'                           ЪЫЫЫЫЫЫЫЫ ЪЫЫЫЫЫЫЫЫ
'                           АДДДДДїЫЫ іЫЫ    іЫЫ
'                                ЪЫЫ  іЫЫ    АїЫЫ
'                              ЪЫЫЫ   іЫЫ     АїЫЫ
'                              АДїЫЫ  іЫЫ     ЪЫЫ
'                                АїЫЫ іЫЫ    ЪЫЫ
'       THо                 ЪЫЫЫЫЫЫЫЫ іЫЫЫЫЫЫЫЫ
'                           АДДДДДДДЩ АДДДДДДДЩ      HiT <F5> NOW
'         DiGiTiZов           ЬЬЬ  Ь  Ь   Ь  ЬЬ 
'                            Ы    ЫЬЫ ЫЯЬЯЫ ЫЬ             KоќS
'                            ЯЬЬЫ Ы Ы Ы   Ы ЯЬЬ           Q = Quit
'                                   В В В        Arrow keys = Move
'                                   і і\і                 A = Look up
'                                   Б Б Б                 Z = Look down
'                                                         C = Center view
'                                Q б A S I C              + = run faster
'                                                         - = run slower

                     '   *** initilize variables ***

SCREEN 13 'screen mode

  j = -10
  speed = 5   'start speed
  sector = 1  'start sector
  '             *** start position ***
                      x = 141   ' facing right/left
                      y = 75    ' looking up/down
                      B = 22    ' distance along corridoor

  VIEW (0, 0)-(300, 150)   ' setup screen coordinates



        '                   *************
GO:     '                   *** start ***
        '                   *************
  vario = INT(speed / 2)
  IF a$ <> "" THEN CLS 'clear screen.   smaller = faster
  a$ = INKEY$                                      '********** keys ********
  IF a$ = CHR$(0) + "K" THEN x = x + speed         '** left               **
  IF a$ = CHR$(0) + "M" THEN x = x - speed         '** right              **
  IF a$ = "a" OR a$ = "A" THEN y = y + speed       '** look up            **
  IF a$ = "z" OR a$ = "Z" THEN y = y - speed       '** look down          **
  IF a$ = "s" OR a$ = "S" THEN j = j + 1           '** look up            **
  IF a$ = "x" OR a$ = "X" THEN j = j - 1           '** look down          **
  IF a$ = "=" THEN speed = speed + 1               '** run faster         **
  IF a$ = "-" THEN speed = speed - 1               '** run slower         **
  IF a$ = "c" OR a$ = "C" THEN y = 75              '** center view        **
  IF a$ = CHR$(0) + "H" THEN B = B + vario         '** walk forward       **
  IF a$ = CHR$(0) + "P" THEN B = B - vario         '** walk backward      **
  IF a$ = "q" OR a$ = "Q" THEN END                 '** quit               **
  t = y - B             'debug line                '************************
  IF t < 1 THEN t = 1   'ditto
  IF B < 1 THEN B = 1   'ditto
  IF B > 60 THEN B = 60  ' distance of corridoor
 
  IF speed < 2 THEN speed = 2   'debug line
  IF speed > 100 THEN speed = 100
  IF vario < 1 THEN vario = 1

  IF x > 410 AND sector = 1 THEN x = -52: B = 60 - B: sector = 2 'code to make
  IF x > 410 AND sector = 2 THEN x = -52: B = 60 - B: sector = 1 'you turn
                                                                 'round +
  IF x < -53 AND sector = 1 THEN x = 409: B = 60 - B: sector = 2 'change
  IF x < -53 AND sector = 2 THEN x = 409: B = 60 - B: sector = 1 'sector.

  IF j > 15 THEN j = 15
  IF j < -14 THEN j = -14

 
GOSUB DR       'goto draw screen and come back after
GOTO GO        'goto start

        '                 *******************
DR:     '                 *** draw screen ***
        '                 *******************

  IF sector = 1 THEN endwall = 6
  IF sector = 2 THEN endwall = 1

  LINE (x - B + 1, y - B + 1)-(x + B - 1, y + B - 1), endwall, BF'draw end wall
  LINE (x - B, y - B)-(x + B, y + B), 15, B  'draw end wall

  LINE (1, j)-(x - B, y - B), 15             'draw walls
  LINE (1, 149 + j)-(x - B, y + B), 15
  LINE (299, j)-(x + B, y - B), 15
  LINE (299, 149 + j)-(x + B, y + B), 15

                                               

  LINE (0, 0)-(300, 150), 15, B            'draw border
                                                  
'  IF y <= 127 THEN PAINT (148, 149), 25, 15  'floor colour
'  IF y >= 26 THEN PAINT (148, 1), 8, 15      'ceiling colour

  LOCATE 20, 2                   ' print variables
  COLOR 32
  PRINT "x"; x; "y"; y; "dist"; B; "SECTOR"; sector; "speed"; speed
  LOCATE 21, 2
  PRINT " j"; j

  RETURN  ' go back

