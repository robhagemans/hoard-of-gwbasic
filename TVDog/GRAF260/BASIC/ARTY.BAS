 '******************************************************************************
 '* ARTY - Symetrical line drawing demo.                                       *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press F1 to pause program                                                  *
 '* Press F2 to redraw image                                                   *
 '* Press F10 to toggle between 320 and 640 graphics modes                     *
 '* Press ESC to exit program                                                  *
 '******************************************************************************
 '$INCLUDE: 'GRAFQBS.INC'
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 Lines = 100
 DIM LX1(Lines), LY1(Lines), LX2(Lines), LY2(Lines)
 Graphics = 320
 MaxColor = 15
 CALL GetTandy11(Tandy11%)
 CALL MediumGraphics

MainLoop:
 GOSUB Initialize
 DO
   GOSUB EraseCurrentLine
   IF ColorCount = 0 THEN GOSUB SelectNewColors
   IF IncrementCount = 0 THEN GOSUB SelectNewDeltaValues
   GOSUB AdjustX1
   GOSUB AdjustY1
   GOSUB AdjustX2
   GOSUB AdjustY2
   IF INT(RND * 5) = 3 THEN
     X1 = (X1 + X2) \ 2
     Y2 = (Y1 + Y2) \ 2
   END IF
   GOSUB DrawCurrentLine
   GOSUB UpdateLine
   K$ = INKEY$
   K$ = RIGHT$(K$, 1)
   IF K$ = CHR$(27) THEN
     CALL ExitGraphics
     END
   END IF
   IF K$ = CHR$(59) THEN CALL WaitKey
   IF K$ = CHR$(60) THEN GOSUB Initialize
   IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
     IF Graphics = 320 THEN
       Graphics = 640
       CALL HighGraphics
       GOSUB Initialize
     ELSE
       Graphics = 320
       CALL MediumGraphics
       GOSUB Initialize
     END IF
   END IF
 LOOP

Initialize:
 CALL ClearScreen
 RANDOMIZE TIMER
 IF Graphics = 320 THEN
   MaxX = 319
   MaxDelta = 7
 ELSE
   MaxX = 639
   MaxDelta = 9
 END IF
 MaxY = 199
 L = 1
 IncrementCount = 0
 StartX = MaxX \ 2
 StartY = MaxY \ 2
 FOR I = 1 TO Lines
   LX1(I) = StartX
   LY1(I) = StartY
   LX2(I) = StartX
   LY2(I) = StartY
 NEXT I
 X1 = StartX
 Y1 = StartY
 X2 = StartX
 Y2 = StartY
 GOSUB SelectNewColors
 RETURN

AdjustX1:
 TestX1 = DeltaX1 + X1
 IF (TestX1 < 1) OR (TestX1 > MaxX) THEN
   TestX1 = X1
   DeltaX1 = -DeltaX1
 END IF
 X1 = TestX1
 RETURN

AdjustY1:
 TestY1 = DeltaY1 + Y1
 IF (TestY1 < 1) OR (TestY1 > MaxY) THEN
   TestY1 = Y1
   DeltaY1 = -DeltaY1
 END IF
 Y1 = TestY1
 RETURN

AdjustX2:
 TestX2 = DeltaX2 + X2
 IF (TestX2 < 1) OR (TestX2 > MaxX) THEN
   TestX2 = X2
   DeltaX2 = -DeltaX2
 END IF
 X2 = TestX2
 RETURN

AdjustY2:
 TestY2 = DeltaY2 + Y2
 IF (TestY2 < 1) OR (TestY2 > MaxY) THEN
   TestY2 = Y2
   DeltaY2 = -DeltaY2
 END IF
 Y2 = TestY2
 RETURN

SelectNewColors:
 C1 = INT(RND * MaxColor + 1)
 C2 = INT(RND * MaxColor + 1)
 C3 = INT(RND * MaxColor + 1)
 C4 = INT(RND * MaxColor + 1)
 ColorCount = INT(RND * 5 + 1) * 3
 RETURN

SelectNewDeltaValues:
 DeltaX1 = INT(RND * MaxDelta) - (MaxDelta \ 2)
 DeltaY1 = INT(RND * MaxDelta) - (MaxDelta \ 2)
 DeltaX2 = INT(RND * MaxDelta) - (MaxDelta \ 2)
 DeltaY2 = INT(RND * MaxDelta) - (MaxDelta \ 2)
 IncrementCount = INT(RND * 4 + 1) * 2
 RETURN

UpdateLine:
 L = L + 1
 IF L > Lines THEN L = 1
 ColorCount = ColorCount - 1
 IncrementCount = IncrementCount - 1
 RETURN

DrawCurrentLine:
 CALL ExtLineC(X1, Y1, X2, Y2, C1)
 CALL ExtLineC(MaxX - X1, Y1, MaxX - X2, Y2, C2)
 CALL ExtLineC(X1, MaxY - Y1, X2, MaxY - Y2, C3)
 CALL ExtLineC(MaxX - X1, MaxY - Y1, MaxX - X2, MaxY - Y2, C4)
 RETURN

EraseCurrentLine:
 CALL ExtLineC(LX1(L), LY1(L), LX2(L), LY2(L), 0)
 CALL ExtLineC(MaxX - LX1(L), LY1(L), MaxX - LX2(L), LY2(L), 0)
 CALL ExtLineC(LX1(L), MaxY - LY1(L), LX2(L), MaxY - LY2(L), 0)
 CALL ExtLineC(MaxX - LX1(L), MaxY - LY1(L), MaxX - LX2(L), MaxY - LY2(L), 0)
 LX1(L) = X1
 LY1(L) = Y1
 LX2(L) = X2
 LY2(L) = Y2
 RETURN

