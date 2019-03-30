'***********************************************************************
'                           Fast Parser 1.2
'              Copyright (C) 1992, 1993 by Daniel Corbier
'                         All rights reserved.
'
' This example will plot user defined equations in the regular
' cartesian coordinate system.
'
' It features:
'
' VarName$()    Allows Fast Parser to recognize the variable name
'               'x' in the user expressions.
'
' EqParse%()    Parses the expression before the loop is started.
'
' VarValue##()  Allows Fast Parser to make the connection between
'               the name 'x' and the actual value x.
'
' Evaluate##()  Evaluates the user expression.
'***********************************************************************

$Include"calc.inc"

Screen 9			'  Use screen 1 if you don't have EGA
Window (-10,-7.5)-(10,7.5)

Print "To accept the default equations, press [enter]"
Print

Input "Please input equation 1 of 3:  [sin(x)] ", Equation1$
If Equation1$="" then Equation1$ = "sin(x)"

Input "Please input equation 2 of 3:  [tan(x)] ", Equation2$
If Equation2$="" then Equation2$ = "tan(x)"

Input "Please input equation 3 of 3:  [x^2*sin(x)] ", Equation3$
If Equation3$="" then Equation3$ = "x^2*sin(x)"


'***  Here's the meat of this example  ***

VarName$(0) = "x"		' Defines  x  as a recognized variable name.

Eq1% = EqParse%( Equation1$ )	' You can parse several equations,
Eq2% = EqParse%( Equation2$ )   ' and then use them any time later
Eq3% = EqParse%( Equation3$ )   ' in your program.
				'
				' Eq1, 2 and 3 are simply pointers
				' to the parsed expressions.

For x=-10 to 10 step .05
	VarValue##(0) = x

	Pset(x, Evaluate##(Eq1%) ),9
	Pset(x, Evaluate##(Eq2%) ),10
	Pset(x, Evaluate##(Eq3%) ),11
Next