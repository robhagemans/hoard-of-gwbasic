'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         BASWIZ  Copyright (c) 1990-1992  Thomas G. Hanlin III        |
'   |                                                                      |
'   |                       The BASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DECLARE FUNCTION RAND% (Range%)

   DECLARE SUB GetDisplay (Adapter%, Mono%)
   DECLARE SUB G12Cls ()
   DECLARE SUB G12Color (BYVAL Foreground%, BYVAL Background%)
   DECLARE SUB G12Mode (BYVAL Graphics%)
   DECLARE SUB G12Plot (BYVAL X%, BYVAL Y%)

   CONST MaxX = 639
   CONST MaxY = 479
   CONST MaxColor = 15

   DEFINT A-Z

   RANDOMIZE TIMER

   GetDisplay Adapter, Mono

   IF Adapter < 6 THEN
      PRINT "Sorry, but you must have a VGA display active to run this demo."
      END
   END IF

   X = RAND(MaxX \ 2)
   Y = RAND(MaxY \ 2)
   C = RAND(MaxColor - 1) + 1

   G12Mode 1
   G12Color C, 0

   DO
      ky$ = INKEY$
      IF LEN(ky$) THEN
         SELECT CASE UCASE$(ky$)
            CASE "C": G12Cls
            CASE "P": WHILE INKEY$ = "": WEND
            CASE ELSE
         END SELECT
      ELSE
         G12Plot X, Y
         G12Plot MaxX - X, Y
         G12Plot MaxX - X, MaxY - Y
         G12Plot X, MaxY - Y
         SELECT CASE RAND(3)
            CASE 0: X = X - 1: IF X < 0 THEN X = MaxX \ 2
            CASE 1: X = X + 1: IF X > MaxX \ 2 THEN X = 0
            CASE ELSE
         END SELECT
         SELECT CASE RAND(3)
            CASE 0: Y = Y - 1: IF Y < 0 THEN Y = MaxY \ 2
            CASE 1: Y = Y + 1: IF Y > MaxY \ 2 THEN Y = 0
            CASE ELSE
         END SELECT
         IF RAND(20) = 1 THEN
            C = RAND(MaxColor - 1) + 1
            G12Color C, 0
         END IF
      END IF
   LOOP UNTIL ky$ = CHR$(27)

   G12Mode 0



FUNCTION RAND (Range)
   RAND = INT(Range * RND)
END FUNCTION
