{
 ******************************************************************************
 * P-DEMO1 - Palette demo.						      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F1 to increase screen change speed				      *
 * Press F10 to toggle between 320 and 640 graphic modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM PaletteDemo1;

USES
  Crt,
  Grafix;

TYPE
  PaletteArray = ARRAY[0..15] OF WORD;

VAR
  Graphics, Distance, PauseVal, S, X, Y: INTEGER;
  P: INTEGER;
  Shape: ARRAY [0..1282] OF WORD;
  EndProgram, Loop, Tandy11: BOOLEAN;

CONST
   H0: PaletteArray = (00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15);
   H1: PaletteArray = (09,01,03,03,01,03,03,01,03,03,09,09,08,09,00,15);
   H2: PaletteArray = (12,00,00,00,15,15,15,15,15,15,04,12,12,12,00,15);
   H3: PaletteArray = (10,07,07,08,07,07,08,07,07,08,10,10,10,02,14,06);
   H4: PaletteArray = (11,14,14,14,14,14,14,06,06,06,11,03,11,11,04,01);

PROCEDURE ScreenSpeed;

BEGIN

  P := P - S;
  IF P < 0 THEN
    P := PauseVal;

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
	ScreenSpeed;
      IF (Ch = #68) AND (Tandy11 = True) THEN
	BEGIN
	  IF Graphics = 320 THEN
	    BEGIN
	      Graphics := 640;
	      Distance := 576;
	      Loop := False;
	      HighGraphics;
	    END
	  ELSE
	     BEGIN
	       Graphics := 320;
	       Distance := 256;
	       Loop := False;
	       MediumGraphics;
	     END;
	END;
    END;

END;

PROCEDURE DelayLoop;

BEGIN

  Pause(P);
  CheckKey;

END;

{Mainline}
BEGIN

  BLoad('P-DEMO1.BIN', Shape[0]);
  Graphics := 320;
  Distance := 256;
  PauseVal := 22;
  S := 4;
  EndProgram := False;
  Loop := True;
  GetTandy11(Tandy11);
  MediumGraphics;

  WHILE EndProgram = False DO
    BEGIN
      X := 0;
      REPEAT
	Y := 4;
	REPEAT
	  ExtPut(X, Y, Shape[0], PutXor);
	  Inc(Y, 64);
	UNTIL Y > 132;
	Inc(X, 64);
      UNTIL X > Distance;
      P := PauseVal;
      WHILE Loop = True DO
	BEGIN
	  IF Loop = True THEN
	    BEGIN
	      PaletteUsing(H0[0]);
	      DelayLoop;
	    END;
	  IF Loop = True THEN
	    BEGIN
	      PaletteUsing(H1[0]);
	      DelayLoop;
	    END;
	  IF Loop = True THEN
	    BEGIN
	      PaletteUsing(H2[0]);
	      DelayLoop;
	    END;
	  IF Loop = True THEN
	    BEGIN
	      PaletteUsing(H3[0]);
	      DelayLoop;
	    END;
	  IF Loop = True THEN
	    BEGIN
	      PaletteUsing(H4[0]);
	      DelayLoop;
	    END;
	END;
      IF EndProgram = False THEN
	 Loop := True;
    END;
  ExitGraphics;

END.
