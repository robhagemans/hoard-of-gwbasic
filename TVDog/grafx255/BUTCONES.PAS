{
 ******************************************************************************
 * BUTCONES - Animation demo using XOR option.				      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F10 to toggle between 320 and 640 graphic modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM ButterflyCones;

USES
  Crt,
  Grafix;

VAR
  Graphics, X, Y, R1, R2, Y1, Y2, OldCX, OldCY, OldSX, OldSY: INTEGER;
  CX, CY, SX, SY, CO: INTEGER;
  Image: ARRAY [0..205] OF WORD;
  P: REAL;
  EndProgram, Loop, Tandy11: BOOLEAN;

CONST
  PI = 3.14159;

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
	      X := 320;
	      R1 := 240;
	      Loop := False;
	      HighGraphics;
	    END
	  ELSE
	     BEGIN
	       Graphics := 320;
	       X := 160;
	       R1 := 120;
	       Loop := False;
	       MediumGraphics;
	     END;
	END;
    END;

END;

{Mainline}
BEGIN

  BLoad('BUTTER.BIN', Image[0]);
  Graphics := 320;
  X := 160;
  R1 := 120;
  EndProgram := False;
  Loop := True;
  GetTandy11(Tandy11);
  MediumGraphics;

  WHILE EndProgram = False DO
    BEGIN
      Y := 99;
      R2 := 30;
      Y1 := 40;
      Y2 := 145;
      OldSX := 0;
      OldSY := 0;
      OldCX := 0;
      OldCY := 0;
      P := PI;
      WHILE Loop = True DO
	BEGIN
	  P := PI;
	  WHILE (P <= PI * 3) AND (Loop = True) DO
	    BEGIN
	      SX := Round(X - R1 * Cos(P));
	      SY := Round(Y1 - R2 * Sin(P));
	      CX := Round(R1 * Cos(P) + X);
	      CY := Round(R2 * Sin(P) + Y2);
	      CO := Round(P);
	      CO := CO AND 15;
	      ExtLineC(SX, SY, CX, CY, CO);
	      ExtPut(OldSX, OldSY, Image[0], PutXor);
	      ExtPut(SX, SY, Image[0], PutXor);
	      ExtPut(OldCX, OldCY, Image[0], PutXor);
	      ExtPut(CX, CY, Image[0], PutXor);
	      OldSX := SX;
	      OldSY := SY;
	      OldCX := CX;
	      OldCY := CY;
	      P := P + PI / 32;
	      CheckKey;
	    END;
	END;
      IF EndProgram = False THEN
	Loop := True;
    END;
  ExitGraphics;

END.
