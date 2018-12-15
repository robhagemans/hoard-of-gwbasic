{
 ******************************************************************************
 * CITY - Solid line box demo.						      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press ESC to exit program						      *
 * Press F1 to pause program						      *
 * Press F2 to restart							      *
 * Press F3 to toggle sound on/off					      *
 * Press F10 to toggle between 320 and 640 graphics modes		      *
 ******************************************************************************
}

PROGRAM City;

USES
  Crt,
  Grafix;

VAR
  Graphics, IA, C, S, XO, CO, X1, Y1, X2, Y2: INTEGER;
  EndProgram, Loop, Tandy11, DoSound: BOOLEAN;

PROCEDURE CheckKey;

VAR
  Ch: CHAR;

BEGIN

  Ch := #255;
  IF KeyPressed THEN
    Ch := Readkey;
  IF Ch = #00 THEN
    Ch := Readkey;
  IF Ch = #27 THEN
    BEGIN
      ExitGraphics;
      Halt(0);
    END;
  IF Ch = #59 THEN
    WaitKey;
  IF Ch = #60 THEN
    Loop := False;
  IF Ch = #61 THEN
    IF DoSound = True THEN
      DoSound := False
    ELSE
      DoSound := True;
  IF (Ch = #68) AND (Tandy11 = True) THEN
    BEGIN
      IF Graphics = 320 THEN
	BEGIN
	  Graphics := 640;
	  XO := 160;
	  CO := 20;
	  Loop := False;
	  HighGraphics;
	END
      ELSE
	BEGIN
	  Graphics := 320;
	  XO := 0;
	  CO := 0;
	  Loop := False;
	  MediumGraphics;
	END;
    END;

END;

{Mainline}
BEGIN

  Graphics := 320;
  XO := 0;
  CO := 0;
  DoSound := True;
  EndProgram := False;
  Loop := True;
  GetTandy11(Tandy11);
  AudioOff;
  MediumGraphics;

WHILE EndProgram = False DO
  BEGIN
    ClearScreen;
    FillBox(0 + XO, 0, 319 + XO, 199, Red);
    FillBox(30 + XO, 30, 290 + XO, 170, 0);
    ExtLineC(30 + XO, 30, 1 + XO, 1, LightGray);
    ExtLineC(290 + XO, 30, 319 + XO, 1, LightGray);
    ExtLineC(30 + XO, 170, 1 + XO, 199, LightGray);
    ExtLineC(290 + XO, 170, 319 + XO, 199, LightGray);
    DrawBox(30 + XO, 30, 290 + XO, 170, LightGray);
    DrawBox(0 + XO, 0, 319 + XO, 199, LightGray);
    FillBox(120 + XO, 182, 199 + XO, 193, Black);
    DrawBox(119 + XO, 182, 200 + XO, 193, LightGray);
    SetCursor(24, 16 + CO);
    PrintStringX(' The City ');
    Randomize;
    WHILE Loop = True DO
      BEGIN
	X1 := Random(250) + 35;
	X2 := Random(250) + 35;
	X2 := (X1 - X2) DIV 4 + X2;
	Y1 := Random(110) + 55;
	Y2 := 165;
	C := Random(15) + 1;
	FillBox(X1 + XO, Y1, X2 + XO, Y2, C);
	DrawBox(X1 + XO, Y1, X2 + XO, Y2, 0);
	DrawBox(X1 + XO + 1, Y1 + 1, X2 + XO - 1, Y2 - 1, 0);
	IA := Abs((X1 - X2) * (Y1 - Y2));
	S := (Round(36400.0) - IA) DIV 360 + 37;
	IF DoSound = True THEN
	  ExtSound(S, 2, 10, 0)
	ELSE
	  Pause(2);
	CheckKey;
      END;
    Loop := True;
  END;

END.
