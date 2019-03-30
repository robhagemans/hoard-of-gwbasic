
             MOUSE ROUTINES FOR QUICK BASIC AND COMPILED BASIC
                 Copyright (c) 1997, Javier Osvaldo Marin
                          All rights reserved

If you use it library in one of your programs, put a credit notice somewhere
with my name on it. And write me for e-mail or mail to the given address at
the end of this document.
If you have any suggestion or critic please contact me.

  List of subroutines:
  -------------------

MostrarMouse
------------
DECLARE SUB MostrarMouse

Show the mouse pointer.
Example:
CALL MostrarMouse()

SacarMouse
----------
DECLARE SUB SacarMouse

Hides the mouse pointer
Example:
CALL SacarMouse()

EstadoMouse
-----------
DECLARE SUB EstadoMouse (x%, y%, botones%)

Gets the current mouse coords and buttons states.
x% is the horizontal coord.
y% is the vertical coord.

The button states are coded in the last three bits as the follow table:

  0       0       0   ---- free
  1       1       1   ---- pressed
  ³       ³       ³
right    left   middle
button  button  button

LimitarMouse
------------
DECLARE SUB LimitarMouse (x%, y%, x1%, y1%)

Confines the mouse to a rectangle.
x% is the left limit.
y% is the top limit.
x1% is the right limit.
y1% is the bottom limit.

Example:
CALL LimitarMouse(10, 30, 70, 50)

MoverMouse
----------
DECLARE SUB MoverMouse (x%, y%)

Change the logical mouse coords.
x% is the new horizontal coord.
y% is the new vertival coord.

MouseActivo
-----------
DECLARE FUNCTION MouseActivo%

Check if there is a mouse driver installed.

If a mouse driver is installed return a non zero number.
If no mouse driver is installed return 0.

Example:
IF MouseActivo% THEN
        PRINT "Mouse driver detected"
ELSE
        PRINT "No mouse driver detected"
ENDIF

TipoMouse
---------
DECLARE FUNCTION TipoMouse%

Return the mouse buttons count (2 or 3).

Example:
IF MouseActivo% THEN
        PRINT TipoMouse%;" buttons mouse driver detected"
ELSE
        PRINT "No mouse driver detected"
ENDIF


---------------------------------------------------------------------------
Javier Osvaldo Marin
Wenceslao Nu¤ez 2170
Rivadavia (Mendoza)
Argentina
Zip Code: 5577
e-mail: marinsoft@yahoo.com
