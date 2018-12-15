 '******************************************************************************
 '* LINES - Walking lines drawing demo.                                        *
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

 DEF FNRND (Maximum) = (RND * Maximum) + 1

 Lines = 150
 DIM LineX1(Lines), LineY1(Lines), LineX2(Lines), LineY2(Lines)
 Graphics = 320
 Delta1 = 31
 Delta2 = 16
 MaxX = 320
 MaxX1 = 319
 MaxY = 200
 MaxY1 = 199
 MaxColor = 15
 CALL GetTandy11(Tandy11%)
 CALL MediumGraphics

Again:
 CALL ClearScreen
 RANDOMIZE TIMER
 Tint = FNRND(MaxColor)
 IX = 0
 Cnt = 0

 X1 = FNRND(MaxX) - 1
 Y1 = FNRND(MaxY) - 1
 X2 = FNRND(MaxX) - 1
 Y2 = FNRND(MaxY) - 1

 DX1 = FNRND(Delta1) - Delta2
 DY1 = FNRND(Delta1) - Delta2
 DX2 = FNRND(Delta1) - Delta2
 DY2 = FNRND(Delta1) - Delta2

 DO
   FOR ChangeCnt = 1 TO FNRND(Lines)
     CALL ExtLineC(X1, Y1, X2, Y2, Tint)
     IX = (IX + 1) MOD Lines
     IF Cnt = Lines THEN
       CALL ExtLineC(LineX1(IX), LineY1(IX), LineX2(IX), LineY2(IX), Black)
     END IF

     LineX1(IX) = X1
     LineY1(IX) = Y1
     LineX2(IX) = X2
     LineY2(IX) = Y2

     IF Cnt < Lines THEN Cnt = Cnt + 1

     X1 = X1 + DX1
     IF (X1 < 0) OR (X1 > MaxX1) THEN
       DX1 = -DX1
       X1 = X1 + DX1
     END IF

     Y1 = Y1 + DY1
     IF (Y1 < 0) OR (Y1 > MaxY1) THEN
       DY1 = -DY1
       Y1 = Y1 + DY1
     END IF

     X2 = X2 + DX2
     IF (X2 < 0) OR (X2 > MaxX1) THEN
       DX2 = -DX2
       X2 = X2 + DX2
     END IF

     Y2 = Y2 + DY2
     IF (Y2 < 0) OR (Y2 > MaxY1) THEN
       DY2 = -DY2
       Y2 = Y2 + DY2
     END IF
   NEXT ChangeCnt

   DX1 = FNRND(Delta1) - Delta2
   DY1 = FNRND(Delta1) - Delta2
   DX2 = FNRND(Delta1) - Delta2
   DY2 = FNRND(Delta1) - Delta2

   Tint = FNRND(MaxColor) - 1
   K$ = INKEY$
   K$ = RIGHT$(K$, 1)
   IF K$ = CHR$(27) THEN
     CALL ExitGraphics
     END
   END IF
   IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
     IF Graphics = 320 THEN
       Graphics = 640
       MaxX = 640
       MaxX1 = 639
       CALL HighGraphics
       GOTO Again
     ELSE
       Graphics = 320
       MaxX = 320
       MaxX1 = 319
       CALL MediumGraphics
       GOTO Again
     END IF
   END IF
 LOOP

