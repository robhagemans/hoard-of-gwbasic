'***********************************************************************
'                           Fast Parser 1.2
'              Copyright (C) 1992, 1993 by Daniel Corbier
'                         All rights reserved.
'
' This program plots 3D surfaces.
'
' The x axis is horizontal, the y axis is vertical, and the z axis
' is perpendicular to the screen.  The surface is plotted in perspective.
'
' Keep in mind that this simple projection cannot properly display all
' the equations that you can give it, and there is no hidden surface
' removal.
'
'***********************************************************************
$Include"calc.inc"

Screen 9                      ' Change to Screen 2 if the monitor is CGA
Window (-10,-10)-(10,10)

VarName$(0) = "x"             ' This is how you define variable names
VarName$(1) = "y"

Print "At the prompt, enter your own equation, or press [enter] for default."

For count% = 1 to 16

	Read DataEq$
	Print "Enter f(x,y): ["; DataEq$ ;"]  ";
	Line Input Eq$
	If len(Eq$) = 0 then Eq$ = DataEq$

	Print Eq$

	Ptr% = EqParse%(Eq$)     ' The expression is parsed ahead of time

	For x=-10 to 10
		For y=-10 to 10 step .5
			i$=inkey$
			if len(i$) then End

			VarValue##(0) = x
			VarValue##(1) = y
			z = Evaluate##(Ptr%)    ' z = f(x,y)
			xx = x*10/(z+13)
			yy = y*10/(z+13)
			if y=-10 then pset(xx,yy) else line -(xx,yy)
		Next
	Next

	For y=-10 to 10
		For x=-10 to 10 step .5
			i$=inkey$
			if len(i$) then End

			VarValue##(0) = x
			VarValue##(1) = y
			z = Evaluate##(Ptr%)
			xx = x*10/(z+13)
			yy = y*10/(z+13)
			if x=-10 then pset(xx,yy) else line -(xx,yy)
		Next
	Next

	Locate 23 : Print "Press any key for the next graph"
	I$=input$(1)
	Cls

Next count%

DATA sqrt(abs(x*y))
DATA exp(x/10)*sin(y)
DATA x*sin(y)/4
DATA 2*( (x>0)*sin(x) + (y>0)*cos(y) )
DATA sin(x)*x*y/10

DATA rnd(x)*y
DATA abs(rnd(x)*y)
DATA rnd(x)*y^2

DATA (y>0)*x^2/2^y + (y<0)*2*cos(y)
DATA (x>0)*x^2/2^y + (y<0)*2*cos(y)

DATA exp(x/15) xor sin(y)
DATA exp(sin(x)*y/4)
DATA exp(sin(x)*y/4)*cos(y)

DATA x mod 5
DATA exp(x mod 5)
DATA exp(x xor y)