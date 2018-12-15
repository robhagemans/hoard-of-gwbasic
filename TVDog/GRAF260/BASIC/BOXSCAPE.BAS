 '******************************************************************************
 '* BOXSCAPE - Line box demo.                                                  *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press F1 to pause program                                                  *
 '* Press F2 to restart program                                                *
 '* Press F3 to toggle between slow and fast drawing modes                     *
 '* Press F10 to toggle between 320 and 640 graphic modes                      *
 '* Press ESC to exit program                                                  *
 '******************************************************************************
 '$INCLUDE: 'GRAFQBS.INC' 
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 Graphics = 320
 MaxX = 319
 Fast = 0
 CALL GetTandy11(Tandy11%)
 CALL MediumGraphics

Again:
 RANDOMIZE TIMER
 CALL ClearScreen

 DO
   X = INT(RND * 15 + 3)
   Y = INT(RND * 15 + 3)
   FOR A = 1 TO 5
     X1 = 0
     X2 = MaxX
     Y1 = 0
     Y2 = 199
     B = INT(RND * 15 + 1)
     WHILE B = BoxColor
       B = INT(RND * 15 + 1)
     WEND
     BoxColor = B
     IF A = 5 THEN BoxColor = 0
     DO WHILE X1 < MaxX AND Y1 < 199
       K$ = INKEY$
       K$ = RIGHT$(K$, 1)
       IF K$ = CHR$(27) THEN
	 CALL ExitGraphics
	 END
       END IF
       IF K$ = CHR$(59) THEN
	 CALL WaitKey
	 CALL ClearKey
       END IF
       IF K$ = CHR$(60) THEN GOTO Again
       IF K$ = CHR$(61) THEN Fast = NOT Fast
       IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
	 IF Graphics = 320 THEN
	   Graphics = 640
	   MaxX = 639
	   CALL HighGraphics
	   GOTO Again
	 ELSE
	   Graphics = 320
	   MaxX = 319
	   CALL MediumGraphics
	   GOTO Again
	 END IF
       END IF
       CALL DrawBox(X1, Y1, X2, Y2, BoxColor)
       IF NOT Fast THEN CALL Pause(1)
       X1 = X1 + Y
       Y1 = Y1 + X
       X2 = X2 - Y
       Y2 = Y2 - X
     LOOP
   NEXT A
 LOOP
