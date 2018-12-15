{
 ******************************************************************************
 * BOXSCAPE - Line box demo.						      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F1 to pause program						      *
 * Press F2 to restart program						      *
 * Press F3 to toggle between slow and fast drawing modes		      *
 * Press F10 to toggle between 320 and 640 graphic modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM BoxScape;

USES
  Crt,
  Grafix;

VAR
  Graphics, MaxX, BoxColor, A, B, X, Y, X1, Y1, X2, Y2: INTEGER;
  EndProgram, Loop, Fast, Tandy11: BOOLEAN;

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
      IF Ch = #59 THEN
	BEGIN
	  WaitKey;
	  ClearKey;
	END;
      IF Ch = #60 THEN
	Loop := False;
      IF Ch = #61 THEN
	IF Fast = True THEN
	  Fast := False
	ELSE
	  Fast := True;
      IF (Ch = #68) AND (Tandy11 = True) THEN
	BEGIN
	  IF Graphics = 320 THEN
	    BEGIN
	      Graphics := 640;
	      MaxX := 639;
	      Loop := False;
	      HighGraphics;
	    END
	  ELSE
	     BEGIN
	       Graphics := 320;
	       MaxX := 319;
	       Loop := False;
	       MediumGraphics;
	     END;
	END;
    END;

END;

{Mainline}
BEGIN

  Graphics := 320;
  MaxX := 319;
  Fast := False;
  EndProgram := False;
  Loop := True;
  GetTandy11(Tandy11);
  MediumGraphics;

  WHILE EndProgram = False DO
    BEGIN
      Randomize;
      ClearScreen;
      WHILE Loop = True DO
	BEGIN
	  X := Random(15) + 3;
	  Y := Random(15) + 3;
	  A := 1;
	  WHILE (A <= 5) AND (Loop = True) DO
	    BEGIN
	      X1 := 0;
	      X2 := MaxX;
	      Y1 := 0;
	      Y2 := 199;
	      B := Random(15) + 1;
	      WHILE B = BoxColor DO
		B := Random(15) + 1;
	      BoxColor := B;
	      IF A = 5 THEN
		BoxColor := 0;
	      WHILE (X1 < MaxX) AND (Y1 < 199) AND (Loop = True) DO
		BEGIN
		  DrawBox(X1, Y1, X2, Y2, BoxColor);
		  IF Fast = False THEN
		    Pause(1);
		  X1 := X1 + Y;
		  Y1 := Y1 + X;
		  X2 := X2 - Y;
		  Y2 := Y2 - X;
		  CheckKey;
		END;
	      Inc(A);
	    END;
	END;
      IF EndProgram = False THEN
	Loop := True;
    END;
  ExitGraphics;

END.
