{
 ******************************************************************************
 * LINES - Walking lines drawing demo.					      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F10 to toggle between 320 and 640 graphic modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM WalkingLines;

USES
  Crt,
  Grafix;

CONST
  Lines = 100;
  MaxColor = 15;

VAR
  Graphics, Delta1, Delta2, ChgCnt, MaxX, MaxX1, MaxY, MaxY1: INTEGER;
  ChangeCnt, Tint, IX, Cnt, X1, Y1, X2, Y2, DX1, DY1, DX2, DY2: INTEGER;
  Loop, EndProgram, Tandy11: BOOLEAN;
  LineX1: ARRAY[0..Lines] OF INTEGER;
  LineY1: ARRAY[0..Lines] OF INTEGER;
  LineX2: ARRAY[0..Lines] OF INTEGER;
  LineY2: ARRAY[0..Lines] OF INTEGER;


FUNCTION Rnd(Max: INTEGER): INTEGER;

BEGIN

  Rnd := Random(Max) + 1;

END;


PROCEDURE CheckKey;

VAR
  Ch: CHAR;

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
      IF (Ch = #68) AND (Tandy11 = True) THEN
	BEGIN
	  IF Graphics = 320 THEN
	    BEGIN
	      Graphics := 640;
	      MaxX := 640;
	      MaxX1 := 639;
	      Loop := False;
	      HighGraphics;
	    END
	  ELSE
	    BEGIN
	      Graphics := 320;
	      MaxX := 320;
	      MaxX1 := 319;
	      Loop := False;
	      MediumGraphics;
	    END;
	END;
    END;

END;

{Mainline}
BEGIN

  Graphics := 320;
  Delta1 := 31;
  Delta2 := 16;
  MaxX := 320;
  MaxX1 := 319;
  MaxY := 200;
  MaxY1 := 199;
  Loop := True;
  EndProgram := False;
  GetTandy11(Tandy11);
  MediumGraphics;

  WHILE EndProgram = False DO
    BEGIN
      ClearScreen;
      Randomize;
      Tint := Rnd(MaxColor);
      IX := 0;
      Cnt := 0;
      X1 := Rnd(MaxX) - 1;
      Y1 := Rnd(MaxY) - 1;
      X2 := Rnd(MaxX) - 1;
      Y2 := Rnd(MaxY) - 1;
      DX1 := Rnd(Delta1) - Delta2;
      DY1 := Rnd(Delta1) - Delta2;
      DX2 := Rnd(Delta1) - Delta2;
      DY2 := Rnd(Delta1) - Delta2;

      WHILE Loop = True DO
	BEGIN

	  FOR ChangeCnt := 1 TO Rnd(Lines) DO
	    BEGIN
	      ExtLineC(X1, Y1, X2, Y2, Tint);
	      IX := (IX + 1) Mod Lines;
	      IF Cnt = Lines THEN
		ExtLineC(LineX1[IX], LineY1[IX], LineX2[IX], LineY2[IX], Black);
	      LineX1[IX] := X1;
	      LineY1[IX] := Y1;
	      LineX2[IX] := X2;
	      LineY2[IX] := Y2;
	      IF Cnt < Lines THEN
		Cnt := Cnt + 1;

	      X1 := X1 + DX1;
	      IF (X1 < 0) OR (X1 > MaxX1) THEN
		BEGIN
		  DX1 := -DX1;
		  X1 := X1 + DX1;
		END;

	      Y1 := Y1 + DY1;
	      IF (Y1 < 0) OR (Y1 > MaxY1) THEN
		BEGIN
		  DY1 := -DY1;
		  Y1 := Y1 + DY1;
		END;

	      X2 := X2 + DX2;
	      IF (X2 < 0) OR (X2 > MaxX1) THEN
		BEGIN
		  DX2 := -DX2;
		  X2 := X2 + DX2;
		END;

	      Y2 := Y2 + DY2;
	      IF (Y2 < 0) OR (Y2 > MaxY1) THEN
		BEGIN
		  DY2 := -DY2;
		  Y2 := Y2 + DY2;
		END;
	    END;

	    DX1 := Rnd(Delta1) - Delta2;
	    DY1 := Rnd(Delta1) - Delta2;
	    DX2 := Rnd(Delta1) - Delta2;
	    DY2 := Rnd(Delta1) - Delta2;
	    Tint := Rnd(MaxColor) - 1;
	    CheckKey;

	END;

      IF EndProgram = False THEN
	Loop := True;

    END;

  ExitGraphics;

END.
