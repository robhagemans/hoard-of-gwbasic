{
 ******************************************************************************
 * RNDBOXES - Random solid line box demo.				      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F1 to pause							      *
 * Press F2 to clear screen						      *
 * Press F3 to toggle between fast and slow drawing modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM RandomBoxes;

USES
  Crt,
  Grafix;

VAR
  Graphics, MXSize, MYSize, MaxX, MaxY, MaxColor, XSize, YSize, X, Y: INTEGER;
  BoxColor: INTEGER;
  EndProgram, Loop, Fast: BOOLEAN;

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
      IF Ch = #59 THEN
	WaitKey;
      IF Ch = #60 THEN
	ClearScreen;
      IF Ch = #61 THEN
	IF Fast = True THEN
	  Fast := False
	ELSE
	  Fast := True;
    END;

END;

{Mainline}
BEGIN

  MXSize := 80;
  MYSize := 50;
  MaxX := 319 - MXSize;
  MaxY := 199 - MYSize;
  MaxColor := 15;
  Fast := False;
  EndProgram := False;
  Loop := True;
  MediumGraphics;
  WHILE EndProgram = False DO
    BEGIN
      Randomize;
      WHILE Loop = True DO
	BEGIN
	  X := Rnd(MaxX);
	  Y := Rnd(MaxY);
	  XSize := Rnd(MXSize);
	  YSize := Rnd(MYSize);
	  BoxColor := Rnd(MaxColor);
	  FillBox(X, Y, X + XSize, Y + YSize, BoxColor);
	  DrawBox(X, Y, X + XSize, Y + YSize, 0);
	  IF Fast = True THEN
	    Pause(1);
	  CheckKey;
	END;
      IF EndProgram = False THEN
	Loop := True;
    END;
  ExitGraphics;

END.
