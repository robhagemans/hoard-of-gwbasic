'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         PBWIZ  Copyright (c) 1991-1993  Thomas G. Hanlin III         |
'   |                                                                      |
'   |                      PowerBASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   $DIM ARRAY
   $STACK 8192

   DECLARE SUB Evaluate (STRING, SINGLE, INTEGER)

   $LINK "pbwiz.pbl"

   DEFINT A-Z

   Expr$ = COMMAND$

   Evaluate Expr$, Result!, ErrCode

   SELECT CASE ErrCode
      CASE 0
         PRINT Expr$; " =";
         IF ABS(Result!) = Result! THEN
            PRINT Result!
         ELSE
            PRINT " "; Result!
         END IF
      CASE 1
         PRINT "Argument expected"
      CASE 2
         PRINT "Missing number"
      CASE 3
         PRINT "Unknown function"
      CASE 4
         PRINT "Unbalanced parentheses"
      CASE 5
         PRINT "Imaginary number"
      CASE 8
         PRINT "CALC  Copyright (c) 1991-1993  Thomas G. Hanlin III"
         PRINT
         PRINT "Syntax:"
         PRINT "   CALC expression"
         PRINT
         PRINT "Expressions may use the following operators:"
         PRINT "   +      add"
         PRINT "   /      divide"
         PRINT "   *      multiply"
         PRINT "   -      subtract"
         PRINT "   ^      raise to a power (** also works)"
         PRINT
         PRINT "A number of functions are also provided:"
         PRINT "   ABS    absolute value         INT    integer"
         PRINT "   ACOS   inverse cosine         LOG    natural log"
         PRINT "   ASIN   inverse sine           PI     3.141593"
         PRINT "   ATAN   inverse tangent        SIN    sine"
         PRINT "   COS    cosine                 SQR    square root"
         PRINT "   FRAC   fraction               TAN    tangent"
         PRINT
         PRINT "Trig functions expect angles in radians."
      CASE 9
         PRINT "Division by zero"
      CASE ELSE
         PRINT "Error"
   END SELECT
