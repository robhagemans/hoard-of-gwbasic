'*****************************************************************************
'                            Fast Parser 1.2
'              Copyright (C) 1992, 1993 by Daniel Corbier.
'			   All Rights Reserved.
'*****************************************************************************
$Float Procedure

'$Link"calc21.pbu"    '  PowerBASIC 2.1    Choose one of these 2 lines
$Link"calc30.pbu"     '  PowerBASIC 3.0

$STACK       16000   ' You may reduce the stack in most cases.

Public VarValue##(), VarName$(), EqError%

Declare Sub      FastParserInit()
Declare Function Eval##( STRING )
Declare Function EqParse%( STRING )
Declare Function Evaluate##( INTEGER )
Declare Function Bin##( STRING )
Declare Function Oct##( STRING )
Declare Function Hex##( STRING )
Declare Function MatchParenth%( INTEGER, STRING )
Declare Sub      TrigMode( INTEGER )
Declare Sub      UserFunction( STRING )
Declare Sub      ReleaseEq()
Declare Sub      ReleaseLastEq()

Call FastParserInit