 '******************************************************************************
 '* SHIMWEEL - Circle and palette demo.                                        *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press F1 to restart program                                                *
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
 A = 110

 CALL GetTandy11(Tandy11%)
 CALL MediumGraphics

Again:
 RANDOMIZE TIMER
 CALL ClearScreen
 B = Graphics / 2
 FOR I = A TO 50 STEP -4
   C = INT(RND * 15) + 1
   CALL ExtCircleC(B, 100, I, C)
 NEXT I
 CALL GetAspect(X, Y)
 FOR I = 1 TO 92
   D = INT(RND * 15) + 1
   IF Graphics = 320 THEN
     CALL SetAspect(15, 1)
     CALL ExtCircleC(B, 100, I, D)
     CALL SetAspect(1, 15)
     CALL ExtCircleC(B, 100, I, D)
   ELSE
     CALL SetAspect(30, 1)
     CALL ExtCircleC(B, 100, I * 2, D)
     CALL SetAspect(1, 7)
     CALL ExtCircleC(B, 100, I, D)
   END IF
 NEXT I
 CALL SetAspect(X, Y)
 A# = TIMER + 30

Shimmer:
 A$ = INKEY$
 A$ = RIGHT$(A$, 1)
 IF A$ = CHR$(27) THEN
   CALL ExitGraphics
   END
 END IF
 IF A$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
   IF Graphics = 320 THEN
     Graphics = 640
     A = 220
     CALL HighGraphics
     GOTO Again
   ELSE
     Graphics = 320
     A = 110
     CALL MediumGraphics
     GOTO Again
   END IF
 END IF
 IF A$ = CHR$(59) OR TIMER > A# THEN GOTO Again
 CALL SetPalette(CINT(RND * 15) + 1, 0)
 CALL Pause(2)
 CALL ResetPalette
 GOTO Shimmer

