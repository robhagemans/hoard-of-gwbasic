{
 ******************************************************************************
 * ARTY - Symetrical line drawing demo.					      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F1 to pause program						      *
 * Press F2 to redraw image						      *
 * Press F10 to toggle between 320 and 640 graphics modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM Arty;

USES
  Crt,
  Grafix;

CONST
  Lines = 100;
  MaxColor = 15;
  MaxY = 199;

VAR
  L, X1, Y1, X2, Y2, MaxX, ColorCount, IncrementCount, Graphics: INTEGER;
  C1, C2, C3, C4, DeltaX1, DeltaY1, DeltaX2, DeltaY2, StartX, StartY: INTEGER;
  MaxDelta: INTEGER;
  Tandy11, EndProgram, Loop: BOOLEAN;
  LX1: ARRAY [0..Lines] OF INTEGER;
  LY1: ARRAY [0..Lines] OF INTEGER;
  LX2: ARRAY [0..Lines] OF INTEGER;
  LY2: ARRAY [0..Lines] OF INTEGER;

PROCEDURE SelectNewColors;

BEGIN

  C1 := Random(MaxColor) + 1;
  C2 := Random(MaxColor) + 1;
  C3 := Random(MaxColor) + 1;
  C4 := Random(MaxColor) + 1;
  ColorCount := (Random(5) + 1) * 3;

END;

PROCEDURE Initialize;

VAR
  I: INTEGER;

BEGIN

  ClearScreen;
  Randomize;
  IF Graphics = 320 THEN
    BEGIN
      MaxX := 319;
      MaxDelta := 7;
    END
  ELSE
    BEGIN
      MaxX := 639;
      MaxDelta := 9;
    END;
  L := 1;
  IncrementCount := 0;
  StartX := MaxX Div 2;
  StartY := MaxY Div 2;
  FOR I := 1 TO Lines DO
    BEGIN
      LX1[I] := StartX;
      LY1[I] := StartY;
      LX2[I] := StartX;
      LY2[I] := StartY;
    END;
   X1 := StartX;
   Y1 := StartY;
   X2 := StartX;
   Y2 := StartY;
   SelectNewColors;

END;

PROCEDURE CheckKey;

VAR
  Ch : CHAR;

BEGIN

   Ch := #255;
   IF KeyPressed THEN
     Ch := ReadKey;
   IF Ch = #27 THEN
     BEGIN
       Loop := False;
       EndProgram := True;
     END;
   IF Ch = #00 THEN
     BEGIN
       Ch := ReadKey;
       IF Ch = #59 THEN
	 WaitKey;
       IF Ch = #60 THEN
	 Initialize;
       IF (Ch = #68) AND (Tandy11 = True) THEN
	 BEGIN
	   IF Graphics = 320 THEN
	     BEGIN
	       Graphics := 640;
	       Loop := False;
	       HighGraphics;
	       Initialize;
	     END
	   ELSE
	     BEGIN
	       Graphics := 320;
	       Loop := False;
	       MediumGraphics;
	       Initialize;
	     END;
	 END;
     END;

END;

PROCEDURE AdjustX1;

VAR
  TestX1: INTEGER;

BEGIN

  TestX1 := DeltaX1 + X1;
  IF (TestX1 < 1) OR (TestX1 > MaxX) THEN
    BEGIN
      TestX1 := X1;
      DeltaX1 := -DeltaX1;
    END;
  X1 := TestX1;

END;

PROCEDURE AdjustY1;

VAR
  TestY1: INTEGER;

BEGIN

  TestY1 := DeltaY1 + Y1;
  IF (TestY1 < 1) OR (TestY1 > MaxY) THEN
    BEGIN
      TestY1 := Y1;
      DeltaY1 := -DeltaY1;
    END;
  Y1 := TestY1;

END;

PROCEDURE AdjustX2;

VAR
  TestX2: INTEGER;

BEGIN

  TestX2 := DeltaX2 + X2;
  IF (TestX2 < 1) OR (TestX2 > MaxX) THEN
    BEGIN
      TestX2 := X2;
      DeltaX2 := -DeltaX2;
    END;
  X2 := TestX2;

END;

PROCEDURE AdjustY2;

VAR
  TestY2: INTEGER;

BEGIN

  TestY2 := DeltaY2 + Y2;
  IF (TestY2 < 1) OR (TestY2 > MaxY) THEN
    BEGIN
      TestY2 := Y2;
      DeltaY2 := -DeltaY2;
    END;
  Y2 := TestY2;

END;

PROCEDURE SelectNewDeltaValues;

BEGIN

  DeltaX1 := Random(MaxDelta) - (MaxDelta Div 2);
  DeltaY1 := Random(MaxDelta) - (MaxDelta Div 2);
  DeltaX2 := Random(MaxDelta) - (MaxDelta Div 2);
  DeltaY2 := Random(MaxDelta) - (MaxDelta Div 2);
  IncrementCount := (Random(4) + 1) * 2;

END;

PROCEDURE UpdateLine;

BEGIN

  Inc(L, 1);
  IF L > Lines THEN
    L := 1;
  Dec(ColorCount, 1);
  Dec(IncrementCount, 1);

END;

PROCEDURE DrawCurrentLine;

BEGIN

  ExtLineC(X1, Y1, X2, Y2, C1);
  ExtLineC(MaxX - X1, Y1, MaxX - X2, Y2, C2);
  ExtLineC(X1, MaxY - Y1, X2, MaxY - Y2, C3);
  ExtLineC(MaxX - X1, MaxY - Y1, MaxX - X2, MaxY - Y2, C4);

END;

PROCEDURE EraseCurrentLine;

BEGIN

  ExtLineC(LX1[L], LY1[L], LX2[L], LY2[L], 0);
  ExtLineC(MaxX - LX1[L], LY1[L], MaxX - LX2[L], LY2[L], 0);
  ExtLineC(LX1[L], MaxY - LY1[L], LX2[L], MaxY - LY2[L], 0);
  ExtLineC(MaxX - LX1[L], MaxY - LY1[L], MaxX - LX2[L], MaxY - LY2[L], 0);
  LX1[L] := X1;
  LY1[L] := Y1;
  LX2[L] := X2;
  LY2[L] := Y2;

END;

{Mainline}
BEGIN

  Graphics := 320;
  Loop := True;
  EndProgram := False;
  GetTandy11(Tandy11);
  MediumGraphics;

  WHILE EndProgram = False DO
    BEGIN
      Initialize;
      WHILE Loop = True DO
	BEGIN
	  EraseCurrentLine;
	  IF ColorCount = 0 THEN
	    SelectNewColors;
	  IF IncrementCount = 0 THEN
	    SelectNewDeltaValues;
	  AdjustX1;
	  AdjustY1;
	  AdjustX2;
	  AdjustY2;
	  IF Random(5) = 3 THEN
	    BEGIN
	      X1 := (X1 + X2) Div 2;
	      Y2 := (Y1 + Y2) Div 2;
	    END;
	  DrawCurrentLine;
	  UpdateLine;
	  CheckKey;
	END;
      IF EndProgram = False THEN
	Loop := True;
    END;

  ExitGraphics;

END.
