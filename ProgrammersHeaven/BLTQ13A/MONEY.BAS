DECLARE FUNCTION CnvSngStr$ (amount!)
DEFINT A-Z

'money.bas
'17-Aug-92 chh

'make a string out of money for a BULLET numeric type

TYPE PayrollTYPE
Tag AS STRING * 1
AnyField AS STRING * 25
Salary AS STRING * 9    'room for -12345.67
END TYPE
DIM PAY AS PayrollTYPE

CLS
money! = 123.456
mkm$ = CnvSngStr$(money!)
RSET PAY.Salary = mkm$
PRINT "        Original !:>"; money!; "<"
PRINT "       Converted $:>"; mkm$; "<"
PRINT "RSET in STRING * 9:>"; PAY.Salary; "<"
PRINT

money! = -1!
mkm$ = CnvSngStr$(money!)
RSET PAY.Salary = mkm$
PRINT "        Original !:>"; money!; "<"
PRINT "       Converted $:>"; mkm$; "<"
PRINT "RSET in STRING * 9:>"; PAY.Salary; "<"
PRINT

money! = 41245.13
mkm$ = CnvSngStr$(money!)
RSET PAY.Salary = mkm$
PRINT "        Original !:>"; money!; "<"
PRINT "       Converted $:>"; mkm$; "<"
PRINT "RSET in STRING * 9:>"; PAY.Salary; "<"
PRINT

FUNCTION CnvSngStr$ (amount!)

'make a string out of a single!
'make money so 2 places right of decimal

round! = SGN(amount!) * .005
money$ = STR$(amount! + round!)

dp = INSTR(money$, ".")
IF dp = 0 THEN
   dp = LEN(money$) + 1
   c$ = ".00"
ELSE
   c$ = LEFT$(MID$(money$, dp) + "0", 3)
END IF

CnvSngStr$ = LEFT$(money$, dp - 1) + c$

END FUNCTION

