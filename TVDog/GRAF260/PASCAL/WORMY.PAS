{
 ******************************************************************************
 * WORMY - Circle drawing demo.						      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F10 to toggle between 320 and 640 graphic modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM Wormy;

USES
  Crt,
  Dos,
  Grafix;

VAR
  Graphics, X, Y, C, Radius: INTEGER;
  H, M, S, S100: WORD;
  LoopTime: LONGINT;
  XR, YR, CR: REAL;
  Loop, Tandy11: BOOLEAN;

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
       ExitGraphics;
       Halt(0);
     END;
  IF Ch = #00 THEN
    BEGIN
      Ch := ReadKey;
      IF (Ch = #68) AND (Tandy11 = True) THEN
	BEGIN
	  IF Graphics = 320 THEN
	    BEGIN
	      Graphics := 640;
	      Loop := False;
	      HighGraphics;
	    END
	  ELSE
	     BEGIN
	       Graphics := 320;
	       Loop := False;
	       MediumGraphics;
	     END;
	END;
    END;

END;

{Mainline}
BEGIN

  Graphics := 320;
  Loop := True;
  GetTandy11(Tandy11);
  MediumGraphics;
  While True DO
    BEGIN
      ClearScreen;
      IF Graphics = 320 THEN
	SetCursor(1, 18)
      ELSE
	SetCursor(1, 38);
      PrintString('WORMY');
      CR := 0;
      XR := 0.1;
      WHILE (XR <= 1.1) AND (Loop = True) DO
	BEGIN
	  CR := CR + 0.1;
	  IF Graphics = 320 THEN
	    BEGIN
	      X := Round(XR * 200);
	      Y := Round(Sin(XR * 24) * (XR * 50) + 100);
	      Radius := Round(XR * 40);
	      C := Round(CR);
	      ExtCircleC(X, Y, Radius, C);
	    END
	  ELSE
	    BEGIN
	      X := Round(XR * 400);
	      Y := Round(Sin(XR * 24) * (XR * 50) + 100);
	      Radius := Round(XR * 75);
	      C := Round(CR);
	      ExtCircleC(X, Y, Radius, C);
	    END;
	    IF CR > 15 THEN
	      CR := 0;
	  XR := XR + 0.002;
	  CheckKey;
	END;
      IF XR >= 1.1 THEN
	BEGIN
	  LoopTime := Timer + 10;
	  REPEAT
	  UNTIL (Timer > LoopTime) OR (KeyPressed);
	END;
      Loop := True;
    END;

END.
