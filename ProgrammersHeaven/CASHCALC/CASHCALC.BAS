CLS
PRINT "Cashcalc 2.0"
PRINT "By Addison Babcock"
PRINT "Calculates all possibilities of each coin from a given total"
SLEEP
CLS

INPUT "Enter total amount of money in pennies. ", Total!
IF Total < 0 THEN
  PRINT "You can't have negative pennies!"
  END
END IF

PRINT "Display results on screen (Y/N)? "
DO
  k$ = UCASE$(INKEY$)
LOOP UNTIL k$ = "Y" OR k$ = "N"
Disp$ = k$
k$ = ""

IF Disp$ = "Y" THEN
  PRINT "Pause after each possible answer (Y/N)? "
  DO
    k$ = UCASE$(INKEY$)
  LOOP UNTIL k$ = "Y" OR k$ = "N"
  Pause$ = k$
  k$ = ""
END IF

PRINT "Output results to a file (Y/N)? "
DO
  k$ = UCASE$(INKEY$)
LOOP UNTIL k$ = "Y" OR k$ = "N"
Output$ = k$
k$ = ""

IF Output$ = "Y" THEN
  INPUT "Enter full path ", File$
  OPEN File$ FOR OUTPUT AS #1
END IF

PRINT "Calculating..."

WHILE Total / 5 <> INT(Total / 5)
  Calcs = Calcs + 1
  P = P + 1
  Total = Total - 1
WEND

MaxQ = INT(Total / 25)
MaxD = INT(Total / 10)
MaxN = INT(Total / 5)
Calcs = Calcs + 3

WHILE Total >= 0

FOR Q = 0 TO MaxQ
  FOR D = 0 TO MaxD
    FOR N = 0 TO MaxN
      IF (Q * 25) + (D * 10) + (N * 5) = Total THEN
        IF Disp$ = "Y" THEN
          PRINT "Q: "; Q; " D: "; D; " N: "; N; " P: "; P
        END IF
        IF Output$ = "Y" THEN
          PRINT #1, "Q: "; Q; " D: "; D; " N: "; N; " P: "; P
        END IF
        IF Pause$ = "Y" THEN
          SLEEP
        END IF
        Posi = Posi + 1
      END IF
    Calcs = Calcs + 1
    NEXT
  NEXT
NEXT
P = P + 5
Total = Total - 5
MaxQ = INT(Total / 25)
MaxD = INT(Total / 10)
MaxN = INT(Total / 5)

WEND

PRINT "Total possibilities: "; Posi
PRINT "Total calculations: "; Calcs

IF Output$ = "Y" THEN
  PRINT #1, "Total possibilities: "; Posi
  PRINT #1, "Total calculations: "; Calcs
  CLOSE #1
END IF

PRINT ""
PRINT "Done."

