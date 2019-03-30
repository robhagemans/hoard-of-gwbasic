' Program--CHKSUM.BAS
' Demonstrates how to check if a credit card number is valid.

DEFINT A-Z
DECLARE FUNCTION ValidCard% (CreditCard$)

GetNumber:
  INPUT "Enter card number (Press <enter> to exit) ", A$
  IF LEN(A$) = 0 THEN END
  IF ValidCard%(A$) THEN
     PRINT "This is a valid card number"
  ELSE
     PRINT "Not a valid card number"
  END IF
  GOTO GetNumber

FUNCTION ValidCard% (CreditCard$)
' Input is a credit card number in the form of a string.
' Output is 0 if not valid, or -1 if valid.
  ValidCard% = 0                 ' Assume it is not a valid card.
  A$ = LTRIM$(RTRIM$(CreditCard$))  ' Remove lead/trail blanks.
  Sp$ = " "

StripSpace:                         ' Remove other blanks.
  A = INSTR(A$, Sp$)
  IF A THEN                         ' Move it over.
     A$ = LEFT$(A$, A - 1) + MID$(A$, A + 1)    
     GOTO StripSpace
  END IF
  CheckSum = 0                      ' Start with 0 for check sum.
  Multiplier = 2
  ' Process from right to left.
  FOR I = LEN(A$) - 1 TO 1 STEP -1  ' All digits except last one.
    A = ASC(MID$(A$, I, 1)) - 48    ' Get a single digit.
    IF A < 0 OR A > 9 THEN          ' If not 0-9,
       EXIT FUNCTION                '   then get out.
    END IF
    A = A * Multiplier
    Multiplier = 3 - Multiplier     ' Toggle multiplier
    IF A > 9 THEN
       Temp$ = LTRIM$(STR$(A))      ' Add numbers together.
       A = 0
       FOR J = 1 TO LEN(Temp$)
         A = A + ASC(MID$(Temp$, J, 1)) - 48' Faster than VAL.
       NEXT
    END IF
    CheckSum = CheckSum + A
  NEXT
  ' Now we subtract the checksum
  ' from the next higher multiple of 10.
  CheckSum = ((CheckSum + 9) \ 10) * 10 - CheckSum
  IF VAL(RIGHT$(A$, 1)) = CheckSum THEN
     ValidCard% = -1
  END IF
END FUNCTION
