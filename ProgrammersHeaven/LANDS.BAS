'

'        ллллллл  ллллллл          лл      лллллллл ллл   лл ллллллл

'              лл лл    лл         лл      лл    лл лллл  лл лл    лл

'            ллл  лл    лл  ллллл  лл      лллллллл лл лл лл лл    лл

'              лл лл    лл         лл      лл    лл лл  лллл лл    лл   

'        ллллллл  ллллллл          ллллллл лл    лл лл   ллл ллллллл

'

'                           Gizzmet productions

'

' This program makes a nice 3D landscape.

' You can change the variables a bit down to make a supercool-looking

' landscape.

'

' Please tell me what you think!

' Per Larsson     [eliott@kd.qd.se]

'

'

'

'

'



DECLARE SUB land.3d ()

DECLARE SUB initcolor ()

DECLARE SUB palman (ent!, r!, g!, b!)

DECLARE SUB smooth ()

DECLARE SUB greg ()

DIM SHARED Xsize%, Ysize%, Smoothing%, Water%, Pixelsize%, Scale, Height, Tilt, Landtype%, palettetype%







'************************************************************************************

'                                                                                   *

'     You can change the vaules below:                                              *

'                                                                                   *         

        Xsize% = 64         'Xsize of map                                           *

        Ysize% = 64         'Ysize of map                                           *

        Smoothing% = 2      'Amount of smoothing. For a funny ,fast map try 0!      *

        Water% = 2          'Amount of Water (not 0)                                *

        Pixelsize% = 2      'Size of pixels in first draw (not 0)                    *

                            '                                                       *  

        Scale = 2           'Size of 3D map, dosen't effect height (not 0)          *

        Height = 1          'Height of mountins (not 0)                             *

        Tilt = .2           'Tilted 3D map (0 gives untilted map)                   *

                            '                                                       *

        Landtype% = 1       'Type of 3D map                                         *

                            '1 = Solid map                                          *

                            '2 = Dotted map                                         *

                            '3 = Grid map                                       *

                            '(1 looks best whith low scaling 2 and 3 looks          *

                            'best on a small map with much scaling)                 *                                               

                            '                                                       *   

        palettetype% = 1    'Whith palette?                                         *

                            '1 = Nature (sea, grass and mountins)                   *

                            '2 = Gray (grayscale)                                   *

                            '3 = White (dosen't look THAT good!!!)                  *

'************************************************************************************





IF Landtype% > 3 OR Landtype% < 1 THEN Landtype% = 1

IF palettetype% > 3 OR palettetype% < 1 THEN palettetype% = 1

IF Pixelsize% < 1 THEN Pixelsize% = 1     'Correct invalid vaules



SCREEN 12

RANDOMIZE TIMER



initcolor                   'Inizialiting colors



greg                        'Make random map



FOR i = 1 TO Pixelsize%     'Black around map

 LINE (-1, -1)-(Xsize% + i, Ysize% + i), 0, B

NEXT i



FOR i = 1 TO Smoothing%

smooth                      'Smooth map

NEXT i



land.3d                     'Make 3D map







SUB greg

Water% = Water% + 1



FOR x = 0 TO Xsize% STEP Pixelsize%

 FOR y = 0 TO Ysize% STEP Pixelsize%

  vaul = INT(RND * Water%) + 1

  IF vaul = 1 THEN vaul = 15 ELSE vaul = 1

  LINE (x, y)-(x + Pixelsize% - 1, y + Pixelsize% - 1), vaul, BF

 NEXT y

NEXT x

END SUB



SUB initcolor

SELECT CASE palettetype%



 CASE IS = 1

 GOTO Nature



 CASE IS = 2

 GOTO Gray



 CASE IS = 3

 GOTO White

END SELECT





Nature:

palman 1, 0, 0, 32



FOR i = 2 TO 7

 palman i, 0, i * 2, 0

NEXT i



FOR i = 8 TO 15

 palman i, i, i, 0

NEXT i



palman 8, 8, 16, 0

GOTO ok





Gray:

FOR i = 1 TO 15

 palman i, i * 2, i * 2, i * 2

NEXT i

GOTO ok





White:

FOR i = 1 TO 15

 palman i, 63, 63, 63

NEXT i



ok:

END SUB



SUB land.3d

SELECT CASE Landtype%

 CASE IS = 1

 GOTO Solid



 CASE IS = 2

 GOTO Dotts



 CASE IS = 3

 GOTO Lines

END SELECT





Solid:

FOR y = 0 TO Ysize%

 FOR x = 0 TO Xsize%

  vaul = POINT(x, y)

  LINE ((x * Scale + y * Tilt) + Xsize% + 8, (y * Scale - vaul * Height) + Ysize% + 8)-((x * Scale + y * Tilt) + Xsize% + 8 + (Scale - 1), (y * Scale) + Ysize% + 8 + (Scale - 1)), vaul, BF

 NEXT x

NEXT y

GOTO ready



Dotts:

FOR y = 0 TO Ysize%

 FOR x = 0 TO Xsize%

  vaul = POINT(x, y)

  PSET ((x * Scale + y * Tilt) + Xsize% + 8, (y * Scale - vaul * Height) + Ysize% + 8), vaul

 NEXT x

NEXT y

GOTO ready



Lines:

FOR y = 0 TO Ysize%

 FOR x = 0 TO Xsize%

  vaul = POINT(x, y)

  vaul2 = POINT(x + 1, y)

  vaul3 = POINT(x, y + 1)

  LINE ((x * Scale + y * Tilt) + Xsize% + 8, (y * Scale - vaul * Height) + Ysize% + 8)-(((x + 1) * Scale + y * Tilt) + Xsize% + 8, (y * Scale - vaul2 * Height) + Ysize% + 8), vaul

  LINE ((x * Scale + y * Tilt) + Xsize% + 8, (y * Scale - vaul * Height) + Ysize% + 8)-((x * Scale + (y + 1) * Tilt) + Xsize% + 8, ((y + 1) * Scale - vaul3 * Height) + Ysize% + 8), vaul

 NEXT x

NEXT y

GOTO ready

  



ready:

END SUB



SUB palman (ent, r, g, b)

PALETTE ent, 65536 * b + 256 * g + r

END SUB



SUB smooth

FOR y = 0 TO Ysize%

 FOR x = 0 TO Xsize%

  c = (POINT(x - 1, y) + POINT(x + 1, y) + POINT(x, y - 1) + POINT(x, y + 1) + POINT(x, y) + POINT(x, y) + POINT(x + 1, y + 1) + POINT(x - 1, y + 1) + POINT(x + 1, y - 1) + POINT(x - 1, y - 1)) / 10

  IF c < 1 THEN c = 1

  PSET (x, y), c

 NEXT x

NEXT y

END SUB




