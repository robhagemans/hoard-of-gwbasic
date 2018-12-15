 '******************************************************************************
 '* NOVAMAX - Line drawing and palette demo.                                   *
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

 DIM Palettes(30)
 Graphics = 320
 A = Blue
 B = Green
 C = Cyan
 D = Red
 MaxX = 319
 M = 160
 CALL GetTandy11(Tandy11%)
 CALL MediumGraphics

Again:
 RANDOMIZE TIMER
 FOR J = 0 TO MaxX STEP 2
   CALL ExtLineC(J, 199, M, 100, A)
   GOSUB CheckKey
 NEXT J
 FOR J = 0 TO MaxX STEP 2
   CALL ExtLineC(J, 0, M, 100, B)
   GOSUB CheckKey
 NEXT J
 FOR J = 0 TO 199 STEP 2
   CALL ExtLineC(M, 100, MaxX, J, C)
   GOSUB CheckKey
 NEXT J
 FOR J = 0 TO 199 STEP 2
   CALL ExtLineC(M, 100, 0, J, D)
   GOSUB CheckKey
 NEXT J
 CALL SetPalette(CINT(RND * 2) + 1, CINT(RND * 15) + 1)
 FOR J = 0 TO MaxX STEP 4
   CALL ExtLineC(J, 199, M, 100, D)
   GOSUB CheckKey
 NEXT J
 FOR J = 0 TO MaxX STEP 4
   CALL ExtLineC(J, 0, M, 100, C)
   GOSUB CheckKey
 NEXT J
 FOR J = 0 TO 199 STEP 4
   CALL ExtLineC(M, 100, MaxX, J, B)
   GOSUB CheckKey
 NEXT J
 FOR J = 0 TO 199 STEP 4
   CALL ExtLineC(M, 100, 0, J, A)
   GOSUB CheckKey
 NEXT J
 FOR J = 0 TO MaxX STEP 8
   CALL ExtLineC(J, 199, M, 100, C)
   GOSUB CheckKey
 NEXT J
 FOR J = 0 TO MaxX STEP 8
   CALL ExtLineC(J, 0, M, 100, D)
   GOSUB CheckKey
 NEXT J
 FOR J = 0 TO 199 STEP 8
   CALL ExtLineC(M, 100, MaxX, J, A)
   GOSUB CheckKey
 NEXT J
 FOR J = 0 TO 199 STEP 8
   CALL ExtLineC(M, 100, 0, J, B)
 NEXT J
 FOR K = 1 TO 30
   Palettes(K) = K MOD 15
   GOSUB CheckKey
 NEXT K
 FOR K = 15 TO 1 STEP -1
   CALL PaletteUsing(Palettes(K))
   CALL Pause(3)
   GOSUB CheckKey
 NEXT K
 GOTO Again

CheckKey:
 K$ = INKEY$
 K$ = RIGHT$(K$, 1)
 IF K$ = CHR$(27) THEN
   CALL ExitGraphics
   END
 END IF
 IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
   IF Graphics = 320 THEN
     Graphics = 640
     MaxX = 639
     M = 320
     CALL HighGraphics
     RETURN Again
   ELSE
     Graphics = 320
     MaxX = 319
     M = 160
     CALL MediumGraphics
     RETURN Again
   END IF
 END IF
 RETURN
