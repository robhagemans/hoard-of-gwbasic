 '******************************************************************************
 '* CITY - Solid line box demo.                                                *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press ESC to exit program                                                  *
 '* Press F1 to pause program                                                  *
 '* Press F2 to restart                                                        *
 '* Press F3 to toggle sound on/off                                            *
 '* Press F10 to toggle between 320 and 640 graphics modes                     *
 '******************************************************************************
 '$INCLUDE: 'GRAFQBS.INC' 
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 Graphics = 320
 XO = 0
 CO = 0
 DoSound = 1
 CALL GetTandy11(Tandy11%)
 CALL AudioOff
 CALL MediumGraphics

Again:
 CALL ClearScreen
 CALL FillBox(0 + XO, 0, 319 + XO, 199, Red)
 CALL FillBox(30 + XO, 30, 290 + XO, 170, 0)
 CALL ExtLineC(30 + XO, 30, 1 + XO, 1, LightGray)
 CALL ExtLineC(290 + XO, 30, 319 + XO, 1, LightGray)
 CALL ExtLineC(30 + XO, 170, 1 + XO, 199, LightGray)
 CALL ExtLineC(290 + XO, 170, 319 + XO, 199, LightGray)
 CALL DrawBox(30 + XO, 30, 290 + XO, 170, LightGray)
 CALL DrawBox(0 + XO, 0, 319 + XO, 199, LightGray)
 CALL FillBox(120 + XO, 182, 199 + XO, 193, Black)
 CALL DrawBox(119 + XO, 182, 200 + XO, 193, LightGray)
 CALL SetCursor(24, 16 + CO)
 CALL PrintStringX(" The City ")
 RANDOMIZE TIMER

 DO
   X1 = RND * 250 + 35
   X2 = RND * 250 + 35
   X2 = (X1 - X2) / 3 + X2
   Y1 = RND * 110 + 55
   Y2 = 165
   C = INT(RND * 15 + 1)
   CALL FillBox(X1 + XO, Y1, X2 + XO, Y2, C)
   CALL DrawBox(X1 + XO, Y1, X2 + XO, Y2, 0)
   CALL DrawBox(X1 + XO + 1, Y1 + 1, X2 + XO - 1, Y2 - 1, 0)
   IA = ABS((X1 - X2) * (Y1 - Y2))
   S = (36400! - IA) / 360 + 37
   IF DoSound = 1 THEN
     CALL ExtSound(S, 2, 10, 0)
   ELSE
     CALL Pause(2)
   END IF
   K$ = INKEY$
   K$ = RIGHT$(K$, 1)
   IF K$ = CHR$(27) THEN
     CALL ExitGraphics
     END
   END IF
   IF K$ = CHR$(59) THEN CALL WaitKey
   IF K$ = CHR$(60) THEN GOTO Again
   IF K$ = CHR$(61) THEN
     IF DoSound = 0 THEN
       DoSound = 1
     ELSE
       DoSound = 0
     END IF
   END IF
   IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
     IF Graphics = 320 THEN
       Graphics = 640
       XO = 160
       CO = 20
       CALL HighGraphics
       GOTO Again
     ELSE
       Graphics = 320
       XO = 0
       CO = 0
       CALL MediumGraphics
       GOTO Again
     END IF
   END IF
LOOP

