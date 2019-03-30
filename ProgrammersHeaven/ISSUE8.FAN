
 [Basix Internet BASIC Fanzine]- - - - - - - - - - - - - - - - - - - - - -,
,'  Issue 8 - The Mag for BASIC Programmers.....  created by Peter Cooper  `,
Ý`- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -/Ý
Ý                                                                           Ý
Ý  Welcome to the eighth issue of the BASIC Fanzine, once again there has   Ý
Ý been a slight delay in the appearance of this zine. The zine seems to     Ý
Ý appear bi-monthly at the moment. This is partially due to a lack of any   Ý
Ý articles code etc and also due to me.                                     Ý
Ý                                                                           Ý
Ý  This time around we have some great new code for you to drool over plus  Ý
Ý the continuation of the 3D Series.. The letters section is now back and   Ý
Ý there are a couple of reviews to read too.                                Ý
Ý                                                                           Ý
Ý  Whatever the new year brings you, may it be a good one and I hope you    Ý
Ý  enjoy reading the eighth issue of the zine.. Enjoy..                     Ý
Ý                                                                           ,
 `-------------------------------------------------------------------------'

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Contents Page 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

 Series \ Tutorials
 ~~~~~~~~~~~~~~~~~~
  1.1 -  3D Programming (part 2)  -  Continuing the series     - PB\(QB poss)
 
 Regulars
 ~~~~~~~~
  2.1 -  Letters                  - Your questions, views etc  - All
  2.2 -  References               - Lots of new web sites!     - All
  2.3 -  NEWS!                    - News from the Basic world  - N/A

 Code
 ~~~~
  3.1 -  Copy Routine             - Copying routine            - QB(asic)
  3.2 -  18BIT GFX in PB!!        - Exclusive 18 Bit Routines  - PB
  3.3 -  Font Placement           - Reading font data from ROM - QBasic

 Reviews
 ~~~~~~~
  4.1 -  LikED Review             - An alternative PB editor   - PB
  4.2 -  Site of the Issue!       - New series surfing the web - All

 Admin\The End
 ~~~~~~~~~~~~~
  5.1 -  Contact                  - Getting the zine, mailing  - All
  5.2 -  And in the end...        - Issue 8 is now over        - All

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [1.1] - 3D Programming (part 2) Ý  Written by Christian Garms
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    ---------------------------------------
  /                                      / |
 ----------------------------------------  |
 3D Graphics in BASIC - Part II.1: Epilog /
 ----------------------------------------
   
It sounds strange to begin with an epilog but I have to explain some real
important things about the listing PYRAMID.BAS in the last part:

1. You only have to calculate the edges of a polygon. In the case of the 
pyramid you only have to calculate FOUR (!!!) points. The rest will do the
LINEs. This is very good because it reduces the amount of calculations to
a minimum and also, of course, the amount of cpu usage.

2. You must have an exact represantation of your 3D object. In our case
of the pyramid this is very simple. There are only four points. The 
definition of the object is located in the DATAs. You need in general a
DATA statement for the points and a DATA statement for the connectivity list.
The connectivity list will instruct the program to draw the right lines to
the right points.
You must determine every edge exactly of any given 3d object you want to 
display. This is very time consuming and you can only create smaller objects
with a pencil and a paper sheet. For 'bigger' objects (more points) you need 
a special editor.


    -----------------------------------------------
  /                                              / |
 ------------------------------------------------  |
 3D Graphics in BASIC - Part II.2: 3D Animations  /
 ------------------------------------------------
   
In PYRAMID.BAS there is only one single picture of a simple object.

Boring, isn't ?

The real 3D effect will only show up if the object will be animated like 
rotating around an axis or moving in real time. So I want you to show
how to get this 'pyramid' into action.

But tons of theory first ...

To make understanding easier for this relative difficult subject because
this part is like "Formula Jones and The Raiders of the lost Arc" and you
could be easily get lost somewhere in the Amasinus I'll give you an
overview of what to do:

1. 3D animations - and of course, animations in general - need the double
buffering technique. That's a common used method of displaying and
generating pictures simultaneously on different screen (often done by
choosing different memory locations of the displaying screen and the
drawing screen).
If you would display and draw the picture on the same screen (the same
memory location), the picture might become flickery. With the double
buffering technique - and eventually waiting for the vertical retrace
interrupt - the animated graphics looks very smooth.

2. Rotating, Scaling and Moving of 3D points could be done with matrix
operations. Because matrix operations aren't a simply matter of fact at all
I'll explain it here in this article but limited for our purpose.
When you've worked through this stuff (it's a very thick formula thicket -
have you got your machet right by your hand ?) you will see the advantages
of this mathematical technique.


    -------------------------------------------------
  /                                                / |
 --------------------------------------------------  |
 3D Graphics in BASIC - Part II.3: Double Buffering /
 --------------------------------------------------

Double buffering is a simple matter of fact. You only need two screens or
pages in any location of the memory. The Video ram is mostly preferred
because of higher perfomance (you must not copy the pages to the video ram
from the memory anymore).
A general algorithm for the Double Buffering technique is as follows:

        1. Show the "display" page, hide the "draw" page
        2. Clear "draw" page
        3. Various Drawing operations in the "draw" page
        4. Wait for vertical rectrace
        5. Switch "display" and "draw" page

The listing II-3.1 is in example for a simple demo of double buffering.
The compiled program will show a rectangle that has four moving corners
with different speed and direction.

**************************************************************************
' Double Buffering Demo
' (C)) 1996 by Ch. Garms


' Type declarations

TYPE pixel
  x AS INTEGER
  y AS INTEGER
END TYPE


' Some Constants

%NOPE = 0
%UP = 1
%DOWN = 2
%PORT = 4
%STARBORD = 8


' Variable declarations

DEFINT a-z
DIM r(3) AS pixel	' rectangle points
DIM d(3) AS pixel	' direction increment / decrement


' Screen dimensions

%MAXX = 639
%MAXY = 349


' Init the random generator with a different value

RANDOMIZE TIMER


' Sub: Switch Drawing / Displaying Screen

SUB switchscreen
  STATIC drawing, display

  IF drawing = display THEN
    drawing = 0
    display = 1
  ELSE
    SWAP drawing, display
  END IF
  WAIT &H3DA, 8	' wait for vertical retrace
  SCREEN 9, 0, drawing, display
END SUB


' Sub: Draw rectangle

SUB rectangle
  SHARED r()

  LINE ( r(0).x, r(0).y ) - ( r(1).x, r(1).y ), 11
  LINE ( r(1).x, r(1).y ) - ( r(2).x, r(2).y ), 11
  LINE ( r(2).x, r(2).y ) - ( r(3).x, r(3).y ), 11
  LINE ( r(3).x, r(3).y ) - ( r(0).x, r(0).y ), 11
END SUB


' Sub: Calculate new points

SUB newpoints
  SHARED r(), d()
  LOCAL i, bounds

  FOR i = 0 TO 3
    bounds = boundcheck( r(i), d(i) )
    SELECT CASE bounds
      CASE ( %UP OR %PORT )
        r(i).x = 0
        r(i).y = 0
        d(i).x = -d(i).x
        d(i).y = -d(i).y
      CASE ( %UP OR %STARBORD )
        r(i).x = %MAXX
        r(i).y = 0
        d(i).x = -d(i).x
        d(i).y = -d(i).y
      CASE ( %DOWN OR %PORT )
        r(i).x = 0
        r(i).y = %MAXY
        d(i).x = -d(i).x
        d(i).y = -d(i).y
      CASE ( %DOWN OR %STARBORD )
        r(i).x = %MAXX
        r(i).y = %MAXY
        d(i).x = -d(i).x
        d(i).y = -d(i).y
      CASE %UP
        r(i).x = ( -r(i).y * d(i).x ) / d(i).y + r(i).x
        r(i).y = 0
        d(i).y = -d(i).y
      CASE %DOWN
        r(i).x = ( ( %maxy - r(i).y ) * d(i).x ) / d(i).y + r(i).x
        r(i).y = %MAXY
        d(i).y = -d(i).y
      CASE %PORT
        r(i).y = d(i).x / d(i).y * -r(i).x + r(i).y
        r(i).x = 0
        d(i).x = -d(i).x
      CASE %STARBORD
        r(i).y = d(i).x / d(i).y * (%maxx - r(i).x) + r(i).y
        r(i).x = %MAXX
        d(i).x = -d(i).x
      CASE %NOPE
        INCR r(i).x, d(i).x
        INCR r(i).y, d(i).y
    END SELECT
  NEXT i
END SUB


' Function boundcheck:
' Check if pixel left the frontiers of the screen

FUNCTION boundcheck(pt AS pixel, dir AS pixel) AS INTEGER
  LOCAL work

  work = %NOPE
  SELECT CASE pt.y + dir.y
    CASE < 0
      INCR work, %UP
    CASE > %MAXY
      INCR work, %DOWN
  END SELECT
  SELECT CASE pt.x + dir.x
    CASE < 0
      INCR work, %PORT
    CASE > %MAXX
      INCR work, %STARBORD
  END SELECT
  boundcheck = work
END FUNCTION


' Initializing the 2D object and the directions increments/decrements
' Just a few random numbers ...

FOR i=0 TO 3
  r(i).x = %MAXX * RND(1)
  r(i).y = %MAXY * RND(1)
  WHILE d(i).x = 0
    d(i).x = 4 - 8 * RND(1)
  WEND
  WHILE d(i).y = 0
    d(i).y = 4 - 8 * RND(1)
  WEND
NEXT i


' Main Program
' Calling the SUBs and waiting for a key

WHILE NOT INSTAT
  switchscreen 			' Show screen
  CLS				' Clear the screen
  rectangle			' Drawing rectangle
  newpoints			' Calculate the new points
WEND
**************************************************************************
Listing II-3.1

If you change the main program to the one described in Listing II-3.2
then you will see why it's necessary to flip pages. The aninamtion of the
rectangle will become flickery. So that's why page flipping is important
for any type of animation.

**************************************************************************
' modified Main program
' actually it didn't flip the pages anymore ...

SCREEN 9
WHILE NOT INSTAT
  CLS				' Clear the screen
  rectangle			' Drawing rectangle
  newpoints                     ' Calculate the new points
WEND
**************************************************************************
Listing II-3.2: RECTANGLE.BAS


    -------------------------------------------------
  /                                                / |
 --------------------------------------------------  |
 3D Graphics in BASIC - Part II.4: 3D Object moving /
 --------------------------------------------------

Moving - or also called: translation - of an object is done by changing
the coordinates of the object. Let's start with a simple example: a point
in the 3D world. Moving the point could be done by:

        1. changing the points coordinates:

        obj.x = obj.x + t.x
        obj.y = obj.y + t.y
        obj.z = obj.z + t.z

        With (obj.x/obj.y/obj.z) = 3D point and (t.x/t.y/t.z) =
        translation vector. The translation vector describes how much a
        point is moved in any direction (x,y,z).

        or (very important !)

        2. changing the viewers coordinates:

        eye.x = eye.x + t.x
        eye.y = eye.y + t.y
        eye.z = eye.z + t.z

        With (eye.x/eye.y/eye.z) = viewers' point

The result will be the same: The point will be moved. That's the same
phenomon as if we watched the sunrise. Not the sun is going up but our
planet earth is rotating around his polar axis. We know that the earth is
moving but it looks like the sun is moving.
The listing II-4.1 is the modified example of the last part - PYRAMID.BAS.
Now it shows some motion. The pyramid is bouncing (in fact the viewpoint
is moving) to the viewer and away from him/her.

**************************************************************************
' ---------------------
'   Moving Pyramid
' based on PYRAMID.BAS
' (C) 1996 by Ch. Garms
' ---------------------


' Compiler Instructions

$CPU 80386
$OPTIMIZE SPEED
$LIB GRAPH ON
$ERROR ALL ON
$COMPILE MEMORY


' Creating new TYPEs

TYPE vector
  x AS INTEGER
  y AS INTEGER
  z AS INTEGER
END TYPE

TYPE pixel
  x AS INTEGER
  y AS INTEGER
END TYPE


' Variable declarations

%MAXPT = 3                     	' max. points
%MAXLN = 5			' max. lines
DIM s(%MAXPT) AS pixel		' 2D coordinates of Pyramid
DIM eye AS vector		' viewpoint
DEFINT a-z


' Initializing screen constants

%MAXPOSX = 639			' max. X-coordinate of screen
%MAXPOSY = 349			' max. Y-coordinate of screen
%CENTERX = 320			' center of screen (X-position)
%CENTERY = 175			' center of screen (Y-position)


' Initializing Viewpoint

eye.x = 15
eye.y = 15
eye.z = 0


' Calculating the eye coordinates & transformation into screen pixels

SUB vec2pix( objpt AS vector, scrpix AS pixel )
  SHARED eye

  DECR objpt.x, eye.x
  DECR objpt.y, eye.y
  DECR objpt.z, eye.z

  scrpix.x = (objpt.x / objpt.z) * %MAXPOSX + %CENTERX
  scrpix.y = (objpt.y / objpt.z) * %MAXPOSY + %CENTERY
END SUB


' Switch screens:
' implementation for PB's SCREEN

SUB switchscreen
  STATIC display, drawing

  IF display = drawing THEN
    display = 0
    drawing = 1
  ELSE
    SWAP display, drawing
  END IF

  WAIT &H3DA, 8 		' wait for vertical retrace
  SCREEN 9, 0, display, drawing
  CLS
END SUB


' IMPORTANT: from here starts the nonrecycable code

' Main program

DIM pwork AS vector
WHILE NOT INSTAT
  FOR j = 40 TO 200 STEP 2
    switchscreen
    eye.z = j
    RESTORE objectdata
    FOR i = 0 TO %MAXPT
      READ pwork.x, pwork.y, pwork.z
      vec2pix pwork, s(i)
    NEXT i
    RESTORE connectdata
    FOR i = 0 TO %MAXLN
      READ pt1, pt2
      LINE (s(pt1).x,s(pt1).y) - (s(pt2).x,s(pt2).y)
    NEXT i
  NEXT j
  FOR j = 200 TO 40 STEP -2
    switchscreen
    eye.z = j
    RESTORE objectdata
    FOR i = 0 TO %MAXPT
      READ pwork.x, pwork.y, pwork.z
      vec2pix pwork, s(i)
    NEXT i
    RESTORE connectdata
    FOR i = 0 TO %MAXLN
      READ pt1, pt2
      LINE (s(pt1).x,s(pt1).y) - (s(pt2).x,s(pt2).y)
    NEXT i
  NEXT j
WEND

SCREEN 0


' Object Data & Connectivity list

objectdata:
DATA  30,  1,    1
DATA   1, 30,    1
DATA   1,  1,   30
DATA -30, -30, -30

connectdata:
DATA  0, 1, 0, 2, 0, 3, 1, 2, 1, 3, 2, 3
**************************************************************************
Listing II-4.1: MOVINPYR.BAS

The listing II-4.1 has some nice features. It contains code that's
recycable (you mustn't reinvent the wheel !). For our purposes there are
two new SUBs:

        SUB switschscreen:
        This subroutine flips between two pages in the video mode 9
        (640x375x16 colours). This EGA resolution is more than enough
        for simple vector graphics.

        SUB vec2pix:
        Converts a vector (3D point) to a screen pixel. This SUB is
        resolution independant. You have to define only the viewpoint
        (setting eye.x/eye.y/eye.z) and the screen parameters %MAXPOSX,
        %MAXPOSY,%CENTERX,%CENTERY before your first call.


    ---------------------------------------------------
  /                                                  / |
 ----------------------------------------------------  |
 3D Graphics in BASIC - Part II.5: 3D Object rotating /
 ----------------------------------------------------

There isn't much to say about 3D rotating. Only formulas, formulas,
formulas. I think our friend Formula Jones won't be unhappy if we come to
the point right now:

        Rotating around the x-axis (Global coordinate system):
        x' = x*cos(alpha) - y*sin(alpha)
        y' = x*sin(alpha) + y*cos(alpha)
        z' = z

        Rotating around the y-axis (Global coordinate system):
        x' = x*cos(beta) + z*sin(beta)
        y' = y
        z' = -x*sin(beta) + z*cos(beta)

        Rotating around the z-axis (Global coordinate system):
        x' = x'
        y' = y*cos(gamma) - z*sin(gamma)
        z' = y*sin(gamma) + z*cos(gamma)

        With:
        (x/y/z)         = old point
        (x'/y'/z')      = new point
        alpha           = angle to rotate around x-axis clockwise
        beta            = angle to rotate around y-axis clockwise
        gamma           = angle to rotate around z-axis clockwise

I won't explain the origin of these formulas because that will not fit
into this article. If you're interrested you'll find this very complex
stuff in any "higher" math book.
Listing II-5.1 is an example of use. Our well known pyramid is now
rotating around his z- and x-axis. But the basic program can be easily
changed. If you want to rotate to any other axis then you have only to
change the calls. Just experimentate with this program !

**************************************************************************
' ---------------------
'   Rotating Pyramid
' based on PYRAMID.BAS
' (C) 1996 by Ch. Garms
' ---------------------


' Compiler Instructions

$CPU 80386
$OPTIMIZE SPEED
$LIB GRAPH ON
$ERROR ALL OFF
$FLOAT EMULATE


' Creating new TYPEs

TYPE vector
  x AS INTEGER
  y AS INTEGER
  z AS INTEGER
END TYPE

TYPE pixel
  x AS INTEGER
  y AS INTEGER
END TYPE


' Variable declarations

%MAXPT = 3                     		' max. points
%MAXLN = 5				' max. lines
%FACTOR = 16384
%ANGLE = 3600				' max. angles for sinus and cosinus
DIM s(%MAXPT) AS pixel
DIM sinus(%ANGLE) AS SHARED INTEGER	' array for sinus table
DIM cosinus(%ANGLE) AS SHARED INTEGER	' array for cosinus table
DIM eye AS SHARED vector		' viewpoint
DIM pwork AS vector
deg2rad! = 1800/3.14152695
DEFINT a-z


' Initializing Sinus table

FOR i = 0 TO %ANGLE
  sinus(i)   = CINT( SIN( i/deg2rad!) * %FACTOR )
  cosinus(i) = CINT( COS( i/deg2rad!) * %FACTOR )
NEXT i


' Screen constants

%MAXPOSX = 639				' max. X-coordinate of screen
%MAXPOSY = 349				' max. Y-coordinate of screen
%CENTERX = 320				' center of screen (X-position)
%CENTERY = 175				' center of screen (Y-position)


' Clipping constants

%LEFT     = 1
%RIGHT	  = 2
%UP       = 4
%DOWN     = 8
%TRUE	  = -1
%FALSE    = 0


' Initializing Viewpoint

eye.x = 0
eye.y = 0
eye.z = 150


' Rotating Point around X-Axis
'   objpt : vector in world coordinates (!)
'   alpha : angle to rotate around X-Axis (1 means 0.1 deg)

SUB rotatex( objpt AS vector, alpha AS INTEGER )
  SHARED sinus(), cosinus()
  DIM p AS vector

  p.x = (objpt.x * cosinus(alpha) - objpt.y * sinus(alpha)) / %FACTOR
  p.y = (objpt.x * sinus(alpha) + objpt.y * cosinus(alpha)) / %FACTOR

  objpt.x = p.x
  objpt.y = p.y
END SUB


' Rotating Point around Y-Axis
'   objpt : vector in world coordinates (!)
'   beta  : angle to rotate around Y-Axis (1 means 0.1 deg)

SUB rotatey( objpt AS vector, beta AS INTEGER )
  SHARED sinus(), cosinus()
  DIM p AS vector

  p.x = (objpt.x * cosinus(beta) + objpt.z * sinus(beta)) / %FACTOR
  p.z = (objpt.x * -sinus(beta) + objpt.z * cosinus(beta)) / %FACTOR

  objpt.x = p.x
  objpt.z = p.z
END SUB


' Rotating Point around Z-Axis
'   objpt : vector in world coordinates (!)
'   gamma : angle to rotate around Y-Axis (1 means 0.1 deg)

SUB rotatez( objpt AS vector, gamma AS INTEGER )
  SHARED sinus(), cosinus()
  DIM p AS vector

  p.y = (objpt.y * cosinus(gamma) - objpt.z * sinus(gamma)) / %FACTOR
  p.z = (objpt.y * sinus(gamma) + objpt.z * cosinus(gamma)) / %FACTOR

  objpt.y = p.y
  objpt.z = p.z
END SUB


' Calculating the eye coordinates & transformation into screen pixels
'   objpt : vector in world coordinates (!)
'   scrpix: pixel on screen
' The variable eye (TYPE vector) must be defined before calling this sub.

SUB vec2pix( objpt AS vector, scrpix AS pixel )
  SHARED eye

  DECR objpt.x, eye.x
  DECR objpt.y, eye.y
  DECR objpt.z, eye.z

  scrpix.x = (objpt.x / objpt.z) * %MAXPOSX + %CENTERX
  scrpix.y = (objpt.y / objpt.z) * %MAXPOSY + %CENTERY
END SUB


' Switch screens

SUB switchscreen
  STATIC display, drawing

  IF display = drawing THEN
    display = 0
    drawing = 1
  ELSE
    SWAP display, drawing
  END IF

  WAIT &H3DA, 8 ' wait for vertical retrace
  SCREEN 9, 0, display, drawing
  CLS
END SUB


' IMPORTANT: from here starts the nonrecycable code
' Main program

WHILE NOT INSTAT
  FOR j=0 TO %ANGLE STEP 15
    switchscreen
    RESTORE objectdata
    FOR i = 0 TO %MAXPT
      READ pwork.x, pwork.y, pwork.z
      rotatez pwork, j
      rotatey pwork, j
      vec2pix pwork, s(i)
    NEXT i
    RESTORE connectdata
    FOR i = 0 TO %MAXLN
      READ pt1, pt2
      LINE (s(pt1).x,s(pt1).y) - (s(pt2).x,s(pt2).y)
    NEXT i
  NEXT j
WEND

SCREEN 0


' Object Data & Connectivity list

objectdata:
DATA  30,  0,   0
DATA   0, 30,   0
DATA   0,  0,  30
DATA -30,-30, -30

connectdata:
DATA  0, 1, 0, 2, 0, 3, 1, 2, 1, 3, 2, 3
**************************************************************************
Listing II-5.1: ROTPYR.BAS

The listing II-5.1 has a very nice trick: The sinus and cosinus values are
converted to integers by multiplying with a constant factor (the factor
must be less than 32767) and stored in an integer array. That makes the
calculation of the 3D rotating faster than with floating point math. It is
not a great secret because it is a well used technique for vector graphics
since games like Elite on the C-64. Though the calculation aren't very
precise the screen resolution is so small that calculation errors won't
disturb much.

The listing II-5.1 simplifies the rotating. As you can see all formulas
rotate around an axis of the global coordinate system. But the pyramid is
rotating around a point in the center of the pyramid. The program achieves
this by equalising the center of the object and the center of the global
coordinate system. If a chosen scenery is more complex (e.g. two objects
who rotates differemt) then we come to a new coordinate system which I will
now introduce: The Object coordinate system.
That means: All points of a given object will be defined relative to the
center of the object. To display the object in the global cordinate system
(or: world coordinate system) we have only add the translation vector from
the center of the object to the center of the global corrdinate system to
all points of the object.

For example I will take the single point once more for explanation of this
complex subject:
The point is the center of the object. The relative object coordinate will
be (0/0/0) and the translation vector (x/y/z). To display the point into the
world coordinate system we simply add the translation vector to the object
coordinates so the derived global coordinte point is (x/y/z).

In general:

        world.x = obj.x + transl.x
        world.y = obj.y + transl.y
        world.z = obj.z + transl.z

        with:
        (world.x/world.y/world.z) = world coordinates of object point
        (obj.x/obj.y/obj.z) = object coordinates of object point
        (transl.x/transl.y/transl.z) = translation vector of object

That's the same as translating a 3D point in the world coordinate system.
Now we've defined our object within the object coordinate system we only
have to equalise the object center and the world center in our mind. For
the rotations we take the object coordinates not the world coordinates !
Than we can perform the rotations. To display the object we add the
translation vector of the object center to all object points and convert
the points to screen pixels.


    -------------------------------------------------------------------
  /                                                                   / |
 ---------------------------------------------------------------------  |
 3D Graphics in BASIC - Part II.6: Introductions to Matrix calculations /
 ----------------------------------------------------------------------

Matrix operations aren't a mystical thing. You have not to be a math
genius to understand what matrices are:

        "A Matrix is a represantion of a linear equation"

In other words: A Matrix isn't more than an array of values which contains
the suffixes of any linear equation like:

        a1*x + b1*y + c1*z = d1
        a2*x + b2*y + c2*z = d2
        a3*x + b3*y + c3*z = d3

The corresponding matrix looks as follows:

        |a1 b1 c1|   |d1|
        |a2 b2 c2| = |d2|
        |a3 b3 c3|   |d3|

For our purposes we didn't need more to know. As you have seen our 3D
operations are often performed by linear equations. E.g. translation of a
point is performed by adding the translation vector to a point. If we
write down this equation in a matrix form it will look like:

     Matrix1   Matrix2       Matrix3
        |x|   |1 0 0 t.x|   |x + t.x|
        |y|   |0 1 0 t.y| = |y + t.y|
        |z|   |0 0 1 t.z|   |z + t.z|
        |0|   |0 0 0 0  |   |0      |

That means we only multiply the 3D point (Matrix1) with an operator
(Matrix2) to translate the point. It looks like I want to complicate all.
But the advantage of matrix operations is that you can chain many
3D operations like rotation or translation to only one single matrix for
all points of any object. This will reduce the calculations enormous and
speed up 3D graphics dramatically for larger objects.

OK, guys. Next time I will continue you to explain the calculation with
matrix and go further with filled polygon graphics.
Hope to see you again here.


+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [2.1] - Letters Ý  Written by Various
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

 Letters have been pouring in for a while now and now it has been decided to
 publish a few:


 <From: Stephen Birchall <N.S.Birchall@lboro.ac.uk>>
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 >I've been given your name as the editor of Basic fanzine. The problem I
 >have is that we use Qbasic to teach students about I/O on the PC - to
 >achieve a 1mSec delay we can use a decrementing loop. However, this method
 >is not transportable between machines with different clock speeds.
 >So what I'm looking for is a QBasic routine that allows me to set delays at
 >1mSec level (the Timer only allows ~50mSec).
 >can you advise me as to where I can find this info ?
 
 This advice may seem useless to you but this sort of precision IO cannot
 really be implemented well in QBasic. QBasic is an interpreter and takes
 far longer than 1ms to execute one statement. C (although it is a rather
 horrid language) is much more suited to this, or ASM (my personal
 preference).  

 I do have some information about how to program the PC PIT clock chip to
 send out interrupts at specified intervals (1ms in your case), you may
 find it of use. I do not know how to implement ASM into QBasic properly
 but there is someone on the newsgroup who is an absolute master at this,
 if you cannot get the follow article to work properly then post a
 message to newsgroup:

 comp.lang.basic.misc

 <Please mail Stephen if you have a solution to this>

-----------

 <From: "Nicholas Aquilina">

 >Dear Sir,
 >I have checked out your page about the Basic Magazine. It is absolutely
 >full of good information and excellent programming techniques.
 >Is it possible to make a subscription form in order to be able to receive
 >the contents of the magazine by e-mail ?
 >Well, if not it is still great.

 Hi Nicholas, Thank you for the praise! =) I am afraid there is no such
 facility at the moment although Fanzine Interactive will hopefully be
 in place soon. A facility to enable you to use a form to be a member of
 the mailing list is a good idea and I will try to implement it. There is
 of course a mailing list for the fanzine maintained by Tony Relyea of
 Russian-Under Ware. Read details in Section [[[[[[[]]]]]]]]]]]]

-----------

 <From: "WINDOWS" <Remy.Lepescheux@wanadoo.fr>>

 >Hello, I'm french and i want to know if gfa basic windows exist for pc?

 I have only ever seen GFA Basic for the PC. There is a GFABASIC for Windows
 also. Contact the manufacturer. If there is no hope then try the gfa-basic
 newsgroup  alt.lang.gfa-basic

 <If you can help Remy at all then please email him>


+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [2.2] - References (The Pit Stop in BASIC) Ý  Written by Fanzine Internal
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

 Welcome to References, the one place where you find the greatest BASIC
 sites whether they be link sites or sites full of info and code :)
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

  -) Basix BASIC Fanzine on Web
        http://www.trenham.demon.co.uk/fanzine/

  -) PowerBASIC
        http://www.powerbasic.com/
        Providing Quality Products

  -) qbasic.com
        http://www.qbasic.com/
        Lots of Source code available for download + more!

  -) QBASIC Three Dee Engines :)
        http://www.trenham.demon.co.uk/threed/

  -) The Official BASIC Ring
        http://www.professionals.com/~peterp/

  -) ABC
      [United States]
        http://charlie.simplenet.com/abc/abchome.html
      [European]
        http://pitel-lnx.ibk.fnt.hvu.nl/~excel/pbabc.html

  -) PowerBasic Archives
        http://pitel-lnx.ibk.fnt.hvu.nl/~excel/pb.html


+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [2.3] - NEWS! (Read all about it) Ý  Written by Fanzine Internal
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

 =FAQ?=----
 
 [The new fully reconditioned BASIC FAQ will be hitting the newsgroups near]
 [you soon! The project, run and led by Rick Elbers, has been progressing  ]
 [well and a full BASIC FAQ is nearly ready.It covers most topics you would]
 [expect to find in an FAQ plus a few more!]

 This news article was written before recent events which seem to have given
 the FAQ an uncertain future. More news as we get it.

 =PowerBASIC News=----

 PowerBASIC has stepped up a few pegs investing in an on-site webboard for
 users and people interested in PowerBASIC. You can post your questions,
 complaints and ideas there. The board is available under:

                        http://www.powerbasic.com/

 Go join in the discussion.

 =More PowerBASIC News!=----

 PowerBASIC also has its own newsgroup, the creator of the group Peter
 Cooper said:
        ' PowerBASIC is an extremely popular company and I feel that they
  need a newsgroup of their own. The Webboard is a great idea but nothing
  can beat the way of USENET '

 The newsgroup is available as   alt.lang.powerbasic  . If this newsgroup
 is not available on your server then it would be appreciated if you could
 bug the news-admin to add it as to spread the group worldwide.

 =New ABC Packet=----

 William Yu has released another quality ABC packet for all of you source
 leeches to drool over. The packet (dated January '97) is available at
 the ABC sites.

 =Fanzine Pages Being Reconditioned=----

 The Fanzine Pages are now undergoing heavy reconstruction and conditioning.
 We are hoping to have 'Fanzine Interactive' online soon plus copies of all
 the zines in HTML format. For the current time all issues of the fanzines
 are available to download but there are no extended features. News will
 be posted when the site is nearing perfection!

 =Ben Ashley Stumbles Back to Newsgroup=----

 Ben Ashley (http://www.flag.demon.co.uk) aka Moo-Juice, comes back to
 comp.lang.basic.misc.

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [3.1] - Copy Routine Ý  Written by Moritz Mhlenhoff 
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

' This is a copy-routine I wrote for one of my install-progs
' It features a status bar and shows the finished percentage.
' I think the code is easy to understand.
DIM piece AS INTEGER   ' piece is the amount of bytes copied in a rush
                       ' the bigger the piece, the faster the copying of
                       ' big files. piece can be 0-32000 bytes
DIM length AS LONG     ' lenght is the amount of bytes still to copy
CLS
INPUT "Enter the name of file to copy   : "; d1$
INPUT "Enter the target path + file name: "; d2$
OPEN d1$ FOR BINARY AS #1
OPEN d2$ FOR OUTPUT AS #2
lenght = LOF(1)
totallenght = LOF(1)
piece = 10000
CLS
LOCATE 3, 4: PRINT "Percent finished:"
LOCATE 4, 4: PRINT STRING$(50, 177)
rest = lenght
DO
 IF piece > lenght THEN piece = lenght
 t$ = INPUT$(piece, #1)
 PRINT #2, t$;
 kop = kop + piece
 pro = CINT(kop / totallenght * 100)
 LOCATE 3, 35: PRINT pro; "%"
 LOCATE 4, 4: PRINT STRING$((pro / 2), 178)
 lenght = lenght - piece
LOOP UNTIL lenght < 1

Thanks for that code Moritz! :) Length.. :)

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [3.2] - 18Bit GFX in PB Ý  Written by Daniel Garlans 
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

 This program was written by Daniel Garlans (garlans@mindspring.com) and
 packaged together with the PAL routine by Peter Cooper.

'Fake Color Mode - 320x400 256 color emulating...320x133 18bit mode :)
'defint a-z
print "Preparing FakeMode"
mode18bit
cls18bit
for a=0 to 365
for b=0 to 590
pset18 a,b,63,63,63
next b
next a

!mov ah,&H03
!int &H10

sub pset18(x,y,r,g,b)
';efint a-z
 
 'Fake-18bit  modeX routine...
 dim page as integer
 dim pagebit as integer
 page = X and 3 'Find the modex Plane to write to
 pagebit=1
 shift left pagebit, page 'a whole heck of a lot faster than 2^page :)
 poke &H3C4, 2  'Tell the vidcard which register:index I'm gonna mess with
 poke &H3C5, pagebit 'Tell the vidcard which page I want to write to
  def seg=&HA000 'go into the vidcard memory
 incr y,3
 offsetr&=(100)*y + (x / 4)  'Get the offset for the RED portion
                             '(for the fakerez)
 offsetg&=(100)*(y+1) + (x / 4)  'Get the offset for the GREEN portion
 offsetb&=(100)*(y+2) + (x / 4)  'Get the offset for the BLUE portion
 poke offsetr&,r
 poke offsetg&,g+64
 poke offsetb&,b+128
end sub

sub mode18bit

 !mov ax,&H0013
 !int &H10
 OUT &H3D4, &H11 : OUT &H3D5,INP(&H3D5) AND &H7F
 OUT &H3C2, &HE7
 OUT &H3D4, &H0: OUT &H3D5, &H6C
 OUT &H3D4, &H1: OUT &H3D5, &H63
 OUT &H3D4, &H2: OUT &H3D5, &H6D
 OUT &H3D4, &H3: OUT &H3D5, &H0
 OUT &H3D4, &H4: OUT &H3D5, &H64
 OUT &H3D4, &H5: OUT &H3D5, &H0
 OUT &H3D4, &H6: OUT &H3D5, &H6C
 OUT &H3D4, &H7: OUT &H3D5, &HF0
 OUT &H3D4, &H8: OUT &H3D5, &H0
 OUT &H3D4, &H9: OUT &H3D5, &H60
 OUT &H3D4, &H10: OUT &H3D5, &H5B
 OUT &H3D4, &H11: OUT &H3D5, &H8C
 OUT &H3D4, &H12: OUT &H3D5, &H57
 OUT &H3D4, &H13: OUT &H3D5, &H32
 OUT &H3D4, &H14: OUT &H3D5, &H0
 OUT &H3D4, &H15: OUT &H3D5, &H58
 OUT &H3D4, &H16: OUT &H3D5, &H65
 OUT &H3D4, &H17: OUT &H3D5, &HE3
 OUT &H3C4, &H1: OUT &H3C5, &H1
 OUT &H3C4, &H4: OUT &H3C5, &H6
 OUT &H3CE, &H5: OUT &H3CF, &H40
 OUT &H3CE, &H6: OUT &H3CF, &H5
 OUT &H3CE, &H6: OUT &H3CF, &H5
 for a=0 to 63
  setpal a,     a, 0 ,0 'set up the pallete
  setpal a+64,  0, a, 0
  setpal a+128, 0, 0, a
 next a
end sub

sub cls18bit
 def seg=&HA000
 for a=0 to 64000
  poke a,0
 next a
end sub

SUB SetPal(BYVAL Col AS BYTE,BYVAL R AS BYTE,BYVAL G AS BYTE,BYVAL B AS BYTE)
	!mov    dx,&H3c8
        !mov    al,col
        !out    dx,al
        !inc    dx
        !mov    al,r
        !out    dx,al
        !mov    al,g
        !out    dx,al
        !mov    al,b
        !out    dx,al
END SUB


+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [3.3] - Font Placement  Ý  Written by Byron Smith and Peter Cooper
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

 About 6 months ago Peter released some very basic code for reading fonts
 from the font ram for placement onto the screen. Byron Smith (unol@sat.net)
 took this many steps further and optimised the code greatly.

 Here is that code, there may be some problems with word wrapping if you are
 viewing this on the newsgroup..

DECLARE SUB fontput (z1%, y1%, in$, c%)
DECLARE SUB fontput1 (z1%, y1%, in$, c%)
DECLARE SUB fontput2 (z1%, y1%, in$, c%)

RANDOMIZE TIMER
SCREEN 12
CLS
PAINT (1, 1), 1
fontput 0, 0, "The old algorithm...", 2
fontput 258, 8, "FontPut Demo", 0
fontput 260, 10, "FontPut Demo", 15
fontput 20, 30, "I dont expect you to use this procedure but it uses a technique unknown", 15
fontput 20, 50, "to many programmers. It reads direct from the font area in ROM, instead", 15
fontput 25, 70, "of using the method used by many programmers in which they PRINT their", 15
fontput 30, 90, "text and then use the POINT command... so you can use this method in", 15
fontput 20, 110, "place of that old method, look at the fontput procedure.. Cheers {:o)", 15
fontput 20, 150, "Peter Cooper", 14
A$ = INPUT$(1)
CLS
fontput 1, 1, "PRESS ANY KEY TO EXIT!", 12
A$ = INKEY$
DO
x% = INT((550 - 0 + 1) * RND + 0)
y% = INT((470 - 1 + 1) * RND + 1)
c% = INT((15 - 1 + 1) * RND + 1)
fontput x%, y%, "Hello there!", c%
LOOP UNTIL INKEY$ <> ""
SCREEN 13
CLS
FOR c% = 30 TO 16 STEP -1
fontput 130, 80, "Cheers!", c%
FOR d% = 1 TO 1000
FOR d2% = 1 TO 40
NEXT d2%
NEXT d%
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
NEXT c%
LOCATE 25, 1: PRINT "Press any key to continue";
WHILE LEN(INKEY$) = 0: WEND

SCREEN 12
CLS
PAINT (1, 1), 1
fontput2 0, 0, "The ", 2
fontput2 32, 0, "NEW ", 10
fontput2 64, 0, "algorithm...", 2
fontput2 258, 8, "FontPut Demo", 0
fontput2 260, 10, "FontPut Demo", 15
fontput2 20, 30, "I dont expect you to use this procedure but it uses a technique unknown", 15
fontput2 20, 50, "to many programmers. It reads direct from the font area in ROM, instead", 15
fontput2 25, 70, "of using the method used by many programmers in which they PRINT their", 15
fontput2 30, 90, "text and then use the POINT command... so you can use this method in", 15
fontput2 20, 110, "place of that old method, look at the fontput procedure.. Cheers {:o)", 15
fontput2 20, 150, "Peter Cooper", 14
A$ = INPUT$(1)
CLS
fontput2 1, 1, "PRESS ANY KEY TO EXIT!", 12
A$ = INKEY$
DO
x% = INT((550 - 0 + 1) * RND + 0)
y% = INT((470 - 1 + 1) * RND + 1)
c% = INT((15 - 1 + 1) * RND + 1)
fontput2 x%, y%, "Hello there!", c%
LOOP UNTIL INKEY$ <> ""
SCREEN 13
CLS
FOR c% = 30 TO 16 STEP -1
fontput2 130, 80, "Cheers!", c%
FOR d% = 1 TO 1000
FOR d2% = 1 TO 40
NEXT d2%
NEXT d%
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
NEXT c%

SUB fontput (z1%, y1%, in$, c%)
DEF SEG = &HFFA6
o1% = z1%
FOR l% = 1 TO LEN(in$)
        l$ = MID$(in$, l%, 1)
        FOR y% = y1% TO y1% + 7
                x% = PEEK(&HE + (ASC(l$) * 8) + (y% - y1%))
                FOR z% = 0 TO 7
                        IF x% AND (2 ^ (7 - z%)) THEN PSET (z1%, y%), c%
                        z1% = z1% + 1
                NEXT z%
                z1% = z1% - 8
        NEXT y%
        z1% = z1% + 8
NEXT l%
DEF SEG
END SUB

'Author: Byron Smith <unol@sat.net, http://www.sat.net/~unol>, 13-NOV-1996
SUB fontput1 (z1%, y1%, in$, c%)
  DEF SEG = -90
  FOR b% = 1 TO LEN(in$): FOR m% = 0 TO 7
    d% = 128 * PEEK(14 + 8 * ASC(MID$(in$, b%, 1)) + m%)
    LINE (z1% + 8 * b% - 9, y1% + m%)-(z1% + 8 * b% - 2, y1% + m%), c%, , d%
  NEXT m%, b%
END SUB

'Author: Byron Smith <unol@sat.net, http://www.sat.net/~unol>, 25-JAN-1997
'Update: Draws two characters at once using LINE.
SUB fontput2 (z1%, y1%, in$, c%)
  DEF SEG = -90
  tmp$ = in$ + " "
  FOR b% = 1 TO LEN(tmp$) - 1 STEP 2: FOR m% = 0 TO 7
  d& = 256& * PEEK(14 + 8 * ASC(MID$(tmp$, b%, 1)) + m%)  'join the next line
             + PEEK(14 + 8 * ASC(MID$(tmp$, b% + 1, 1)) + m%)
  d% = d& + (d& > 32767) * 65536
  LINE (z1% + 8 * b% - 8, y1% + m%)-(z1% + 8 * b% + 7, y1% + m%), c%, , d%
  NEXT m%, b%
END SUB

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [4.1] - LikED Review Ý  Written by Daniel Garlans (White Shade\DuoTech)
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

 Liked is a powerful editor written by Leif Claesson (Liket/Goto10 or TPCF),
 a  Swede  who happens to program demos in PowerBasic.  He apparently didn't
 like the Powerbasic editor, (which I agree with), so he wrote LikED in PB3.
 Liked's interface is pretty straightforward,  you start with a blank screen
 where  you start typing your code.  HelpPC is supported,  (HelpPC is a very
 good  index-reference  program with all sorts of Interrupt,  ASM help,  and
 almost  anything you could ask about in the PC).  A  menu  screen gives you
 all the options,  just like PowerBasic's editor does.  Compiling  uses  the
 same  keys  as  the regular editor,  and requires that you have the PBC.EXE
 compiler  in  a directory for Liked to use.  Most "common" editing commands
 are supported as well.

 Besides  the  basics,  liked  also supports an almost scripting-like set of
 commands.  It  has  options  to  run before and after compiling,  automatic
 appending,  size  showing and more.  There is no mouse support,  but  Liked
 doesn't really need it.  Also, support for TASM linking is included.

 So,  Basically,  if  you're tired of the regular PowerBasic 3.2 editor, try
 Liked... 
 You can get liked at: http://home1.swipnet.se/~w-18147/liket.htm
 btw, the author does not know that this exists :)


+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [4.2] - Site of the Issue! Ý  Written by Peter Cooper
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

 Welcome to the new series, site of the issue where we strive to find the
 best QBasic site around. Of course this will change each week for variety
 but we hope to find you the best BASIC content around!

 This issue  qbasic.com  is the clear winner.

 Qbasic.Com
 ~~~~~~~~~~
   Qbasic.com is a well laid out, well managed site from Avatar. There is
   an awful lot of code to be downloaded, from Palette tricks to 3d engines
   to games. Theer are some good games for download too, for example,
   BattleCraft which is a Warcraft style sim in QBasic!

   It seems Avatar has put a lot of work into the site, buying the domain
   etc and the site receives a great deal of hits per day. It's a booming
   success!

   From the site you can also order a CD which contains all of the code on
   the site and also 'much more!'. Compilers can also be downloaded from
   the site which gives 'wanna-be' programmers a giant head start. Tutorials
   are also available for beginners but even some of the more advanced
   programmers can learn a lot!

   This is a definately must-visit site. You might not think the pages are
   gleaming with HTML technology, but it's 'content'. Leap in, and have a go!

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [5.1] - Contact Ý  Written by  Fanzine Internal
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

 The Basix Fanzine is always ready for new articles, code, letters and so on.
 We are always appreciative of anything you send which could be of use, come
 and try!

 Send your contributions to:

        fanzine@trenham.demon.co.uk

 Many thanks...

 Also! Remember the Basix Fanzine does have a mailing list..

 To join the mailing list   :
         arelyea@vt.edu 
 with the following line in the subject header:
      subscribe basix-fanzine
 Any text in the body of the message will be ignored. The mailing list is
 run by Mr. Relyea and the Basix Fanzine claims no responsibility for any
 problems  with  the  mailing list.  Tom Lawrences HTML Fanzine is of his
 responsibility  and again the Basix Fanzine claims no responsibility for
 any problems.

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 [5.2] - And in the end... Ý  Written by Peter Cooper
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

 'And in the end.. the love you take is equal to the love you make'
        - The Beatles

 Interesting words from John Lennon there, perhaps it could be twisted to a
 programmers point of view..

 'And at the end.. the code you break is equal to the code you make!'

 <grin> Maybe not.

 It's been an interesting issue. As you may have noticed the format has
 changed a bit and there are some new fresh articles. This fanzine also
 seems to be nearly on time! Not much to say for the end, it's now much
 warmer out than from this time last fanzine and the BASIC scene has
 changed a bit.. My personal recommendation (as you already know) this
 issue goes to:

                       http://www.qbasic.com/

 The site is quite good, the style may not be to everyones taste but there
 is definately some good content. You will find a lot to use there. Although
 my raycasting program does seem to have someone else down as author.. <grin>
 Read the review of the site in section 4.2:

 Remember, keep coding, and send in what you would like in the fanzine, even
 ads for your homepages! We need your input!

9th February 1997

