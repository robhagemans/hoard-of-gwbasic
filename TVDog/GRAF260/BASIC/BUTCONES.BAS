 '******************************************************************************
 '* BUTCONES - Animation demo using XOR option.                                *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press F10 to toggle between 320 and 640 graphic modes                      *
 '* Press ESC to exit program                                                  *
 '******************************************************************************
 '$INCLUDE: 'GRAFQBS.INC' 
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 DIM Image(205)
 Graphics = 320
 X = 160
 R1 = 120
 DEF SEG = VARSEG(Image(0))
 BLOAD "BUTTER.BIN", VARPTR(Image(0))
 DEF SEG
 CALL GetTandy11(Tandy11%)
 CALL MediumGraphics

Again:
 PI# = 3.14159
 Y = 99
 R2 = 30
 Y1 = 40
 Y2 = 145
 OldSX = 0
 OldSY = 0
 OldCX = 0
 OldCY = 0

 DO
   FOR P# = PI# TO 3 * PI# STEP PI# / 32
     SX = X - R1 * COS(P#)
     SY = Y1 - R2 * SIN(P#)
     CX = R1 * COS(P#) + X
     CY = R2 * SIN(P#) + Y2
     CO = P# MOD 15
     CALL ExtLineC(SX, SY, CX, CY, CO)
     CALL ExtPut(OldSX, OldSY, Image(0), PutXor)
     CALL ExtPut(SX, SY, Image(0), PutXor)
     CALL ExtPut(OldCX, OldCY, Image(0), PutXor)
     CALL ExtPut(CX, CY, Image(0), PutXor)
     OldSX = SX
     OldSY = SY
     OldCX = CX
     OldCY = CY
     K$ = INKEY$
     K$ = RIGHT$(K$, 1)
     IF K$ = CHR$(27) THEN
       CALL ExitGraphics
       END
     END IF
     IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
       IF Graphics = 320 THEN
	 Graphics = 640
	 X = 320
	 R1 = 240
	 CALL HighGraphics
	 GOTO Again
       ELSE
	 Graphics = 320
	 X = 160
	 R1 = 120
	 CALL MediumGraphics
	 GOTO Again
       END IF
     END IF
   NEXT P#
 LOOP
