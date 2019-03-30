'***********************************************************************
'                           Fast Parser 1.2
'              Copyright (C) 1992, 1993 by Daniel Corbier
'                         All rights reserved.
'
' This example features:
'
' UserFunction()  Allows the user to define a function.
'
' Eval##()  Evaluates the user expression.  It is a little bit easier
'           to implement than Evaluate##(), and is appropriate where
'           the speed of a loop is not important.
'
' EqError%  Returns an error number if an invalid expression is entered.
'***********************************************************************
$Include"calc.inc"

Print "At the prompt, you can either enter:"
Print "an expression like 'sin(3)+(5-6)^2)'"
Print "a variable assignment like 'length = 20'"
Print "or a function assignment like 'inv(x) = 1/x'"

Do
	Print
	Input "Expression:  ", Expr$

	If instr(Expr$,"(") > 0 and instr(Expr$,"(") < instr(Expr$,"=") then
		Call UserFunction( Expr$ )

	   ElseIf instr(Expr$,"=") > 0 then      ' Assign a variable value
		EqualSign%            = instr(Expr$,"=")
		VarName$(variable%)   = left$(Expr$,EqualSign%-1)
		VarValue##(variable%) = Eval##(mid$(Expr$,EqualSign%+1))
		Incr variable%

	   Else
		Answer## = Eval##( Expr$ )
	End If

	Select Case EqError%
		Case 0:	 Print Answer##

		Case 1:  Print "Undefined function"
		Case 2:  Print "Mismatched parenthesis"
		Case 3:  Print "Undefined variable"
		Case 4:  Print "Invalid binary number"
		Case 5:  Print "Invalid octal number"
		Case 6:  Print "Invalid hexadecimal number"
		Case 7:  Print "Factorial overflow"
		Case 9:  Print "Invalid expression"
		Case 10: Print "Function definition space is full"
	End Select
Loop while Expr$ <> ""