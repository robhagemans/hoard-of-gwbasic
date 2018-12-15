{
 ******************************************************************************
 * SHIMWEEL - Circle and palette demo.					      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F1 to restart program						      *
 * Press F10 to toggle between 320 and 640 graphic modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM ShimmerWheel;

USES
  Crt,
  Dos,
  Grafix;

VAR
  A, C, D, I, Graphics: INTEGER;
  X, Y: WORD;
  LoopTime: LONGINT;
  EndProgram, Loop, Tandy11: BOOLEAN;
  Ch: CHAR;

FUNCTION Timer: LONGINT;

VAR
  Hours, Minutes, Seconds, Sec100: WORD;

BEGIN

  GetTime(Hours, Minutes, Seconds, Sec100);
  Timer := ((Hours * 3600) + (Minutes * 60) + Seconds);

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
	Loop := False;
      IF (Ch = #68) AND (Tandy11 = True) THEN
	BEGIN
	  IF Graphics = 320 THEN
	    BEGIN
	      Graphics := 640;
	      A := 220;
	      Loop := False;
	      HighGraphics;
	    END
	  ELSE
	    BEGIN
	      Graphics := 320;
	      A := 110;
	      Loop := False;
	      MediumGraphics;
	    END;
	END;
    END;

END;

{Mainline}
BEGIN

  Graphics := 320;
  A := 110;
  EndProgram := False;
  Loop := True;
  GetTandy11(Tandy11);
  MediumGraphics;

  WHILE EndProgram = False DO
    BEGIN
      Randomize;
      ClearScreen;
      I := A;
      WHILE I >= 50 DO
	BEGIN
	  C := Random(15) + 1;
	  ExtCircleC(Graphics DIV 2, 100, I, C);
	  Dec(I, 4);
	END;
      GetAspect(X, Y);
      FOR I := 1 TO 92 DO
	BEGIN
	  IF Graphics = 320 THEN
	    BEGIN
	      D := Random(15) + 1;
	      SetAspect(15, 1);
	      ExtCircleC(Graphics DIV 2, 100, I, D);
	      SetAspect(1, 15);
	      ExtCircleC(Graphics DIV 2, 100, I, D);
	    END
	  ELSE
	    BEGIN
	      D := Random(15) + 1;
	      SetAspect(30, 1);
	      ExtCircleC(Graphics DIV 2, 100, I SHL 1, D);
	      SetAspect(1, 7);
	      ExtCircleC(Graphics DIV 2, 100, I, D);
	    END;
	END;
      SetAspect(X, Y);
      LoopTime := Timer + 30;
      WHILE (Loop = True) AND (LoopTime > Timer) DO
	BEGIN
	  CheckKey;
	  SetPalette(Random(15) + 1, 0);
	  Pause(2);
	  ResetPalette;
	END;
      IF EndProgram = False THEN
	Loop := True;
    END;
  ExitGraphics;

END.
