'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |        BASWIZ  Copyright (c) 1990-1991  Thomas G. Hanlin III         |
'   |                                                                      |
'   |                      The BASIC Wizard's Library                      |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DECLARE SUB G2Cls ()
   DECLARE SUB G2Write (St$)
   DECLARE SUB G2Locate (BYVAL Row%, BYVAL Column%)
   DECLARE SUB G2Mode (BYVAL ModeNr%)
   DECLARE SUB G2Plot (BYVAL X%, BYVAL Y%)

   ' Note: we don't use DEFINT because we need single precision!

   PI! = 3.141593
   TotalRadius! = 40

   G2Mode 1                       ' 640x200 CGA

   DO
      G2Cls
      G2Write "How many petals would you like (1-9) ? "
      DO
         ky$ = INKEY$
      LOOP UNTIL LEN(ky$)
      IF ky$ > "0" AND ky$ <= "9" THEN
         G2Write ky$
         Petals! = VAL(ky$)
         FOR Angle! = 0! TO PI * 2! STEP .01
            R! = 20 * COS(Petals! * Angle!)
            G2Plot CINT(R! * COS(Angle!) + 310), CINT(R! * SIN(Angle!) + 100)
         NEXT
         G2Locate 24, 1
         G2Write "Like to try another? "
         DO
            ky$ = INKEY$
         LOOP UNTIL LEN(ky$)
      END IF
   LOOP WHILE UCASE$(ky$) = "Y"
   G2Mode 0

