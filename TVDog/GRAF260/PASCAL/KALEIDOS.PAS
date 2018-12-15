{
 ******************************************************************************
 * KALEIDOS - Four Function Kaleioscope demo.				      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F1 to pause program						      *
 * Press F2 to restart program						      *
 * Press ESC to exit program						      *
 * ****************************************************************************
}

PROGRAM Kaleideoscopes;

USES
  Grafix,
  Crt,
  Dos;

VAR
  X1, Y1, X2, Y2, XX, YY, XY, YX, L, M, N, Choice, PrevChoice: INTEGER;
  I: LONGINT;
  Ch: CHAR;

FUNCTION Timer: LONGINT;

VAR
  Hours, Minutes, Seconds, Sec100: WORD;

BEGIN

  GetTime(Hours, Minutes, Seconds, Sec100);
  Timer := ((Hours * 3600) + (Minutes * 60) + Seconds)

END;

FUNCTION Rnd(Max: INTEGER): INTEGER;

BEGIN

  Rnd := Random(Max);

END;

Procedure ClearKey;

VAR
  Ch: CHAR;

BEGIN

  WHILE KeyPressed DO
    Ch := ReadKey;

END;

Procedure WaitKey;

VAR
  Ch: CHAR;

BEGIN

  ClearKey;
  REPEAT
  UNTIL KeyPressed;
  Ch := ReadKey;

END;

Procedure ExitPgm;

BEGIN

  ExitGraphics;
  Halt(0)

END;

Procedure DoChoice;

BEGIN

  CASE Choice OF
    1:
      BEGIN
	ExtLine((X1 + M) * 35 DIV 24, Y1 + L, (X2 + M) * 35 DIV 24, Y2 + L);
	ExtLine((Y1 + M) * 35 DIV 24, X1 + L, (Y2 + M) * 35 DIV 24, X2 + L);
      END;
    2:
      BEGIN
	DrawBoxC((X1 + M) * 35 DIV 24, Y1 + L, (X2 + M) * 35 DIV 24, Y2 + L);
      END;
    3:
      BEGIN
	ExtLine((X1 + M) * 35 DIV 24, Y1 + L, (X2 + M) * 35 DIV 24, Y2 + L);
	DrawBoxC((Y1 + M) * 35 DIV 24, X1 + L, (Y2 + M) * 35 DIV 24, X2 + L);
      END;
    4:
      BEGIN
	ExtCircle(X1 + M + N, Y1 + L, Abs(X2));
      END;
  END;

END;


BEGIN {Mainline}

  MediumGraphics;
  Randomize;
  Choice := Rnd(4) + 1;
  PrevChoice := Choice;
  L := 100;
  M := 110;
  N := 50;

  WHILE (1 = 1) DO
    BEGIN
      ClearScreen;
      Randomize;
      SetPlotColor(Rnd(15) + 1);
      X1 := Rnd(50) + 1;
      X2 := Rnd(50) + 1;
      Y1 := Rnd(X1);
      Y2 := Rnd(X2);
      WHILE Choice = PrevChoice DO
	Choice := Rnd(4) + 1;
      PrevChoice := Choice;
      I := Timer + 30;
      WHILE (I > Timer) DO
	BEGIN
	  Y1 := -Y1;
	  Y2 := -Y2;
	  DoChoice;
	  X1 := -X1;
	  X2 := -X2;
	  DoChoice;
	  Y1 := -Y1;
	  Y2 := -Y2;
	  DoChoice;
	  X1 := -X1;
	  X2 := -X2;
	  DoChoice;
	  IF Rnd(11) = 5 THEN
	    BEGIN
	      Randomize;
	      XX := Rnd(11) - 5;
	      XY := Rnd(11) - 5;
	      YX := Rnd(11) - 5;
	      YY := Rnd(11) - 5;
	      SetPlotColor(Rnd(15) + 1);
	    END;
	  X1 := (X1 + XX) MOD M;
	  Y1 := (Y1 + YX) MOD M;
	  X2 := (X2 + XY) MOD M;
	  Y2 := (Y2 + YY) MOD M;
	  Ch := #255;
	  IF KeyPressed THEN
	    BEGIN
	      Ch := ReadKey;
	      IF Ch = #27 THEN
		ExitPgm;
	      IF Ch = #00 THEN
		BEGIN
		  Ch := ReadKey;
		  IF Ch = #59 THEN
		    WaitKey;
		  IF Ch = #60 THEN
		    I := 0;
		END;
	    END;
	END;
   END;

END.
