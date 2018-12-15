 '******************************************************************************
 '* RNDBOXES - Random solid line box demo.                                     *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press F1 to pause                                                          *
 '* Press F2 to clear screen                                                   *
 '* Press F3 to toggle between fast and slow drawing modes                     *
 '* Press ESC to exit program                                                  *
 '******************************************************************************
 '$INCLUDE: 'GRAFQBS.INC'
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 DEF FNRND (Maximum) = INT(RND * Maximum) + 1

 MXSize = 80
 MYSize = 50
 MaxX = 319 - MXSize
 MaxY = 199 - MYSize
 MaxColor = 15
 Fast = -1
 CALL MediumGraphics

Again:
 RANDOMIZE TIMER
 DO
   K$ = INKEY$
   K$ = RIGHT$(K$, 1)
   IF K$ = CHR$(27) THEN
     CALL ExitGraphics
     END
   END IF
   IF K$ = CHR$(59) THEN CALL WaitKey
   IF K$ = CHR$(60) THEN CALL ClearScreen
   IF K$ = CHR$(61) THEN Fast = NOT Fast
   X = FNRND(MaxX)
   Y = FNRND(MaxY)
   XSize = FNRND(MXSize)
   YSize = FNRND(MYSize)
   BoxColor = FNRND(MaxColor)
   CALL FillBox(X, Y, X + XSize, Y + YSize, BoxColor)
   CALL DrawBox(X, Y, X + XSize, Y + YSize, 0)
   IF NOT Fast THEN CALL Pause(1)
 LOOP

