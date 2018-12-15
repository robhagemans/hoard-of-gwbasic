{
 ******************************************************************************
 * NOVAMAX - Line drawing and palette demo.				      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F10 to toggle between 320 and 640 graphic modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM Novamax;

USES
  Crt,
  Grafix;

VAR
  Palettes: ARRAY[1..30] OF WORD;
  A, B, C, D, J, M, MaxX, Graphics: INTEGER;
  EndProgram, Loop, Tandy11: BOOLEAN;

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
       IF (Ch = #68) AND (Tandy11 = True) THEN
	 BEGIN
	   IF Graphics = 320 THEN
	     BEGIN
	       Graphics := 640;
	       MaxX := 639;
	       M := 320;
	       Loop := False;
	       HighGraphics;
	     END
	   ELSE
	     BEGIN
	       Graphics := 320;
	       MaxX := 319;
	       M := 160;
	       Loop := False;
	       MediumGraphics;
	     END;
	 END;
     END;

END;

{Mainline}
BEGIN

  Graphics := 320;
  EndProgram := False;
  Loop := True;
  MaxX := 319;
  M := 160;
  A := Blue;
  B := Green;
  C := Cyan;
  D := Red;
  GetTandy11(Tandy11);
  MediumGraphics;

  J := 1;
  WHILE J <= 30 DO
    BEGIN
      Palettes[J] := J Mod 15;
      Inc(J, 1);
    END;

  WHILE EndProgram = False DO
    BEGIN
      RANDOMIZE;
      CheckKey;
      J := 0;
      WHILE (J <= MaxX) AND (Loop = True) DO
	BEGIN
	  ExtLineC(J, 199, M, 100, A);
	  Inc(J, 2);
	END;
      CheckKey;
      J := 0;
      WHILE (J <= MaxX) AND (Loop = True) DO
	BEGIN
	  ExtLineC(J, 0, M, 100, B);
	  Inc(J, 2);
	END;
      CheckKey;
      J := 0;
      WHILE (J <= 199) AND (Loop = True) DO
	BEGIN
	  ExtLineC(M, 100, MaxX, J, C);
	  Inc(J, 2);
	END;
      CheckKey;
      J := 0;
      WHILE (J <= 199) AND (Loop = True) DO
	BEGIN
	  ExtLineC(M, 100, 0, J, D);
	  Inc(J, 2);
	END;
      IF Loop = True THEN
	SetPalette(Random(2) + 1, Random(15) + 1);
      CheckKey;
      J := 0;
      WHILE (J <= MaxX) AND (Loop = True) DO
	BEGIN
	  ExtLineC(J, 199, M, 100, D);
	  Inc(J, 4);
	END;
      CheckKey;
      J := 0;
      WHILE (J <= MaxX) AND (Loop = True) DO
	BEGIN
	  ExtLineC(J, 0, M, 100, C);
	  Inc(J, 4);
	END;
      CheckKey;
      J := 0;
      WHILE (J <= 199) AND (Loop = True) DO
	BEGIN
	  ExtLineC(M, 100, MaxX, J, B);
	  Inc(J, 4);
	END;
      CheckKey;
      J := 0;
      WHILE (J <= 199) AND (Loop = True) DO
	BEGIN
	  ExtLineC(M, 100, 0, J, A);
	  Inc(J, 4);
	END;
      CheckKey;
      J := 0;
      WHILE (J <= MaxX) AND (Loop = True) DO
	BEGIN
	  ExtLineC(J, 199, M, 100, C);
	  Inc(J, 8);
	END;
      CheckKey;
      J := 0;
      WHILE (J <= MaxX) AND (Loop = True) DO
	BEGIN
	  ExtLineC(J, 0, M, 100, D);
	  Inc(J, 8);
	END;
      CheckKey;
      J := 0;
      WHILE (J <= 199) AND (Loop = True) DO
	BEGIN
	  ExtLineC(M, 100, MaxX, J, A);
	  Inc(J, 8);
	END;
      CheckKey;
      J := 0;
      WHILE (J <= 199) AND (Loop = True) DO
	BEGIN
	  ExtLineC(M, 100, 0, J, B);
	  Inc(J, 8);
	END;
      CheckKey;
      J := 15;
      WHILE (J > 1) AND (Loop = True) DO
	BEGIN
	  PaletteUsing(Palettes[J]);
	  Dec(J, 1);
	  Pause(3);
	END;
      IF EndProgram = False THEN
	Loop := True;
   END;
   ExitGraphics;

END.
