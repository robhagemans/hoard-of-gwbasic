'
'                        -[ 3D VECTOR GRAPHICS ]-
'
'       I'm gonna tell you now, which is the easiest and fastest way
'       to create 2D/3D Vectors, VectorBalls, Plotters. My QB source
'       is quite easy to convert for assembler. With basic, this is
'       quite fast, but with assembler this is really fast! With filled
'       of coz. But assembler later...let's Rock'N Roll!
'
'       3d Vector matrises
'
'Move:
'               T(Dx,Dy,Dz) =   [ 1  0  0  0 ]
'                               [ 0  1  0  0 ]
'                               [ 0  0  1  0 ]
'                               [ Dx Dy Dz 1 ]
'
'Scale:
'               S(Sx,Sy,Sz) =   [ Sx 0  0  0 ]
'                               [ 0  Sy 0  0 ]
'                               [ 0  0  Sz 0 ]
'                               [ 0  0  0  1 ]
'               R?(Y,X) FUNC(DEGREE)
'      
'       Z -Rotating:
'               RZ(1,1) COS(THETA)
'               RZ(1,2) SIN(THETA)
'               RZ(2,1) -SIN(THETA)
'               RZ(2,2) COS(THETA)
'
'       X -Rotating:
'               RX(2,2) COS(THETA)
'               RX(2,3) SIN(THETA)
'               RX(3,2) -SIN(THETA)
'               RX(3,3) COS(THETA)
'
'       Y -Rotating:
'               RY(1,1) COS(THETA)
'               RY(1,3) -SIN(THETA)
'               RY(3,1) SIN(THETA)
'               RY(3,3) COS(THETA)
'
'       Horizontal Turning:
'               Sh(a,b) = [ 1 0 0 0 ]
'                         [ 0 1 0 0 ]
'                         [ a b 1 0 ]
'                         [ 0 0 0 1 ]
'
'
'      [ OBJECTS ]
'      Building object is tought job. Here is example datas for cube.
'
'                            X,Y,Z
'                       DATA 0,0,0
'                       DATA 1,0,0
'                       DATA 1,1,0
'                       DATA 0,1,0
'                       DATA 0,0,1
'                       DATA 1,0,1
'                       DATA 1,1,1
'                       DATA 0,1,1
'
'      [ PLOTTERS / VECTORBALLS ]
'      Creating vectorballs and plotters are quite same than normal
'      vectors. With plotter, we draw only the points. No lines.
'      Plotter is little faster too. Vectorballs are one kind of
'      plotter too. But now points are sprites. My routine is written
'      with QBasic. So, don't expect too much. With assembler, this
'      routine is faster than light, even with fill we reach the speed
'      of realtime. Here is my matrise routine. You can use this rou-
'      tine with normal 2D/3D vectors, Vectorball, Plotter. Just change
'      DRAWOBJ Sub-program. With vectors use LINE command. With Plotter
'      use PSET command and with Vectorballs use PUT command with XOR.
'      Coordinates are simple. FIG(1,1) is the X coordinate of the first
'      line. FIG(1,2) is Y coordinate of this same line. So, if we want
'      to draw line, between 2 vectorpoints, type:
'
'               PSET (FIG(1, 1), FIG(1, 2)), 15  'Star point. Color 15
'               LINE -(FIG(2, 1), FIG(2, 2)), 15 'Continue to X,Y coor-
'                                                'dinate of second line.
'
'      If you wanna fill object, use PAINT command, and calculate the
'      coordinate from the current place and degree of object.
'       Good luck.
'
'***************************************************************************
'*  ALLFIT VECTOR ROUTINE BY BLACKBIRD (C) 1993. *FREEWARE*                *
'***************************************************************************
OPTION BASE 1
DIM T(4, 4), RY(4, 4), PER(4, 4)                ' Set variables
DIM A(4, 4), RESVECT(4), V(4), FIG(4, 2)
DIM VEKTORI(4), UUSIVEKTORI(4), PROVEKTORI(4)
DECLARE SUB MULTIPLYVEC (A(), V(), RESVECT())   ' Set Sub-Programs
DECLARE SUB DRAWFIG (FIG())
HALFY = 100             ' Define origo
HALFX = 160
ROTATION = 5            ' Rotate with 5 degrees
RANDOMIZE TIMER
KULMIA = 8              ' How many vertics?
X.POSITION = 0          'X-Coordinate of object
Y.POSITION = 0          'Y-Coordinate of object
Z.POSITION = 10         'Z-Coordinate of object
DIM KUVIO(KULMIA, 3), KUVA(KULMIA, 2)
CLS
SCREEN 7                ' EGA 320x200x16        (VGA can be used also)

D = 6                   ' Watch point from origo. (Z-coordinate)
FOR LOOPPI1 = 1 TO KULMIA       'Read Object data
	FOR LOOPPI2 = 1 TO 3
		READ KUVIO(LOOPPI1, LOOPPI2)
	NEXT LOOPPI2
NEXT LOOPPI1
'    X,Y,Z      Object data for cube
DATA 0,0,0
DATA 1,0,0
DATA 1,1,0
DATA 0,1,0
DATA 0,0,1
DATA 1,0,1
DATA 1,1,1
DATA 0,1,1

FOR LOOPPI1 = 1 TO 4            ' Read matrise
	FOR LOOPPI2 = 1 TO 4
		READ LUKU
		RY(LOOPPI1, LOOPPI2) = LUKU
		RZ(LOOPPI1, LOOPPI2) = LUKU
		T(LOOPPI1, LOOPPI2) = LUKU
		PER(LOOPPI1, LOOPPI2) = LUKU
		RX(LOOPPI1, LOOPPI2) = LUKU
		SH(LOOPPI1, LOOPPI2) = LUKU
		S(LOOPPI1, LOOPPI2) = LUKU
	NEXT LOOPPI2
NEXT LOOPPI1
' Rotating matrise data
DATA 1,0,0,0                   
DATA 0,1,0,0
DATA 0,0,1,0
DATA 0,0,0,1

PER(3, 4) = 1 / D
PER(4, 4) = 0

S(4, 3) = Z.POSITION            ' Set positions
S(4, 1) = X.POSITION
S(4, 2) = Y.POSITION
LOOPPI = 0
DO
LOOPPI = LOOPPI + ROTATION      ' Let's roll!
IF LOOPPI >= 355 THEN LOOPPI = 0
	THETA = LOOPPI * (3.14159 / 180)
	RX(1, 1) = COS(THETA)     ' Here is formulas for X-Rotating.
	RX(3, 1) = SIN(THETA)
	RX(1, 3) = -SIN(THETA)
	RX(3, 3) = COS(THETA)
	LOOPPI2 = 0
	DO
	LOOPPI2 = LOOPPI2 + 1
		LOOPPI3 = 0
		DO
		LOOPPI3 = LOOPPI3 + 1
			VEKTORI(LOOPPI3) = KUVIO(LOOPPI2, LOOPPI3)
		LOOP UNTIL LOOPPI3 = 3
		VEKTORI(4) = 1
		CALL MULTIPLYVEC(RX(), VEKTORI(), UUSIVEKTORI())
		GOSUB MAKE.COORDS     ' Calculate matrise
	LOOP UNTIL LOOPPI2 = KULMIA
	CALL DRAWFIG(KUVA())    ' Plot object
LOOP UNTIL INKEY$ <> ""


END
MAKE.COORDS:
		CALL MULTIPLYVEC(S(), UUSIVEKTORI(), VEKTORI())
		CALL MULTIPLYVEC(PER(), VEKTORI(), PROVEKTORI())
		KUVA(LOOPPI2, 1) = PROVEKTORI(1) / PROVEKTORI(4)
		KUVA(LOOPPI2, 2) = PROVEKTORI(2) / PROVEKTORI(4)
		KUVA(LOOPPI2, 1) = HALFY * KUVA(LOOPPI2, 1) + HALFX
		KUVA(LOOPPI2, 2) = -HALFY * KUVA(LOOPPI2, 2) + HALFY
RETURN

SUB DRAWFIG (FIG()) STATIC
	IF SCREENI = 1 THEN SCREENI = 0 ELSE SCREENI = 1
	IF SCREENI = 1 THEN SCREENI2 = 0 ELSE SCREENI2 = 1
	SCREEN 7, , SCREENI, SCREENI2       ' Swap pages for UnBlinking
	LINE (0, 0)-(320, 200), 0, BF       ' animation
	SCREEN 7, , SCREENI, SCREENI
	PSET (FIG(1, 1), FIG(1, 2)), 15
	LINE -(FIG(2, 1), FIG(2, 2)), 15
	LINE -(FIG(3, 1), FIG(3, 2)), 15
	LINE -(FIG(4, 1), FIG(4, 2)), 15
	LINE -(FIG(1, 1), FIG(1, 2)), 15

	PSET (FIG(5, 1), FIG(5, 2)), 15
	LINE -(FIG(6, 1), FIG(6, 2)), 15
	LINE -(FIG(7, 1), FIG(7, 2)), 15
	LINE -(FIG(8, 1), FIG(8, 2)), 15
	LINE -(FIG(5, 1), FIG(5, 2)), 15

	PSET (FIG(1, 1), FIG(1, 2)), 15
	LINE -(FIG(5, 1), FIG(5, 2)), 15
       
	PSET (FIG(2, 1), FIG(2, 2)), 15
	LINE -(FIG(6, 1), FIG(6, 2)), 15
       
	PSET (FIG(4, 1), FIG(4, 2)), 15
	LINE -(FIG(8, 1), FIG(8, 2)), 15
       
	PSET (FIG(3, 1), FIG(3, 2)), 15
	LINE -(FIG(7, 1), FIG(7, 2)), 15
	
END SUB

SUB MULTIPLYVEC (A(), V(), RESVECT()) STATIC
	LOOPPI = 0
	DO
	LOOPPI = LOOPPI + 1     ' Calculate new orbit
		RESVECT(LOOPPI) = V(1) * A(1, LOOPPI) + V(2) * A(2, LOOPPI) + V(3) * A(3, LOOPPI) + V(4) * A(4, LOOPPI)
	LOOP UNTIL LOOPPI = 4
END SUB

