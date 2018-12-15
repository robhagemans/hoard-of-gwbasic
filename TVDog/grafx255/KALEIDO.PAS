{
 ******************************************************************************
 * KALEIDO - Kaleioscope line drawing demo.				      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F1 to pause program						      *
 * Press F2 to clear the screen						      *
 * Press F10 to toggle between 320 and 640 graphic modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM Kaleideoscope;

USES
  Grafix,
  Crt;

VAR
  MX, MY, M, MaxDelta, MaxColor, X1, Y1, X2, Y2, Graphics: INTEGER;
  LC, XV1, XV2, YV1, YV2, XA, XB, YA, YB: INTEGER;
  Leave, Tandy11: BOOLEAN;
  Ch : CHAR;

FUNCTION Rnd (Max: INTEGER): INTEGER;

BEGIN

  Rnd := Random(Max) + 1;

END;

{Mainline}
BEGIN

  MX := 160;
  MY := 100;
  M := 100;
  MaxDelta := 7;
  MaxColor := 15;
  Graphics := 320;
  MediumGraphics;
  GetTandy11(Tandy11);
  Leave := False;
  WHILE (M = 100) DO
    BEGIN
      Randomize;
      ClearScreen;
      X1 := Rnd(M) + 1;
      X2 := Rnd(M) + 1;
      Y1 := Rnd(X1);
      Y2 := Rnd(X2);
      WHILE (M = 100) DO
	BEGIN
	  LC := Rnd(MaxColor); {Insure good color separation}
	  LC := Rnd(MaxColor);
          SetPlotColor(LC);
	  XV1 := Rnd(11) - 5;
	  XV2 := Rnd(11) - 5;
	  YV1 := Rnd(11) - 5;
	  YV2 := Rnd(11) - 5;
	  WHILE (Rnd(10) > 1) DO
	    BEGIN
	      XA := (X1 * 9) Div MaxDelta;
	      XB := (X2 * 9) Div MaxDelta;
	      YA := (Y1 * 9) Div MaxDelta;
	      YB := (Y2 * 9) Div MaxDelta;
	      ExtLine(MX + XB, MY - Y2, MX + XA, MY - Y1);
	      ExtLine(MX - YB, MY + X2, MX - YA, MY + X1);
	      ExtLine(MX - XB, MY - Y2, MX - XA, MY - Y1);
	      ExtLine(MX - YB, MY - X2, MX - YA, MY - X1);
	      ExtLine(MX - XB, MY + Y2, MX - XA, MY + Y1);
	      ExtLine(MX + YB, MY - X2, MX + YA, MY - X1);
	      ExtLine(MX + XB, MY + Y2, MX + XA, MY + Y1);
	      ExtLine(MX + YB, MY + X2, MX + YA, MY + X1);
	      X1 := Abs((X1 + XV1) Mod M);
	      Y1 := Abs((Y1 + YV1) Mod M);
	      X2 := Abs((X2 + XV2) Mod M);
	      Y2 := Abs((Y2 + YV2) Mod M);
	    END;
	  Ch := #255;
	  IF KeyPressed THEN
	    Ch := ReadKey;
	  IF Ch = #27 THEN
	    BEGIN
	      ExitGraphics;
	      M := 0;
	      Leave := True;
	    END;
	IF Ch = #00 THEN
	  BEGIN
	    Ch := ReadKey;
	    IF Ch = #59 THEN WaitKey;
	    IF Ch = #60 THEN M := 0;
	    IF ((Ch = #68) AND (Tandy11 = True)) THEN
	      BEGIN
		M := 0;
		IF Graphics = 320 THEN
		  BEGIN
		    Graphics := 640;
		    MX := 320;
		    MaxDelta := 4;
		    HighGraphics;
		  END
		ELSE
		  BEGIN
		    Graphics := 320;
		    MX := 160;
		    MaxDelta := 7;
		    MediumGraphics;
		  END;
	      END;
	  END;
      END;
      IF Leave = False THEN M := 100;
    END;

END.
