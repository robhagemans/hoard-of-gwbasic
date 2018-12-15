{
 ******************************************************************************
 * HORSE -- Animation demo using PSET option.				      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F1 to change foreground color					      *
 * Press F2 to change background color					      *
 * Press F3 to restart program						      *
 * Press F10 to toggle between 320 and 640 graphic modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM Horse;

USES
  Crt,
  Grafix;

VAR
  Graphics, FC, BC, Q, X1, X2: INTEGER;
  EndProgram, Loop, Tandy11: BOOLEAN;
  H1: ARRAY [0..354] OF WORD;
  H2: ARRAY [0..354] OF WORD;
  H3: ARRAY [0..354] OF WORD;
  H4: ARRAY [0..354] OF WORD;
  H5: ARRAY [0..354] OF WORD;

PROCEDURE ChangeForColor;

BEGIN

  REPEAT
    FC := FC + 1;
    IF FC > 15 THEN
      FC := 1;
  UNTIL FC <> BC;
  SetPalette(15, FC);

END;

PROCEDURE ChangeBackColor;

BEGIN

  REPEAT
    BC := BC + 1;
    IF BC > 15 THEN
      BC := 0;
  UNTIL BC <> FC;
  SetBackColor(BC);

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
	ChangeForColor;
      IF Ch = #60 THEN
	ChangeBackColor;
      IF Ch = #61 THEN
	BEGIN
	  FC := White;
	  BC := Blue;
	  Loop := False;
	END;
      IF (Ch = #68) AND (Tandy11 = True) THEN
	BEGIN
	  IF Graphics = 320 THEN
	    BEGIN
	      Graphics := 640;
	      X1 := 162;
	      X2 := 318;
	      Loop := False;
	      HighGraphics;
	    END
	  ELSE
	     BEGIN
	       Graphics := 320;
	       X1 := 2;
	       X2 := 158;
	       Loop := False;
	       MediumGraphics;
	     END;
	END;
    END;

END;

{Mainline}
BEGIN

  BLoad('HORSE1.BIN', H1[0]);
  BLoad('HORSE2.BIN', H2[0]);
  BLoad('HORSE3.BIN', H3[0]);
  BLoad('HORSE4.BIN', H4[0]);
  BLoad('HORSE5.BIN', H5[0]);

  Graphics := 320;
  X1 := 2;
  X2 := 158;
  FC := White;
  BC := Blue;
  EndProgram := False;
  Loop := True;
  GetTandy11(Tandy11);
  MediumGraphics;

  WHILE EndProgram = False DO
    BEGIN
      SetPalette(15, FC);
      SetBackColor(BC);
      WHILE Loop = True DO
	BEGIN
	  Q := X1;
	  REPEAT
	    ExtPut(Q + 54, 85, H1[0], PutPset);
	    Q := Q + 52;
	  UNTIL Q > X2;
	  Q := X1;
	  REPEAT
	    ExtPut(Q + 54, 85, H2[0], PutPset);
	    Q := Q + 52;
	  UNTIL Q > X2;
	  Q := X1;
	  REPEAT
	    ExtPut(Q + 54, 85, H3[0], PutPset);
	    Q := Q + 52;
	  UNTIL Q > X2;
	  Q := X1;
	  REPEAT
	    ExtPut(Q + 54, 85, H4[0], PutPset);
	    Q := Q + 52;
	  UNTIL Q > X2;
	  Q := X1;
	  REPEAT
	    ExtPut(Q + 54, 85, H5[0], PutPset);
	    Q := Q + 52;
	  UNTIL Q > X2;
	  CheckKey;
	END;
      IF EndProgram = False THEN
	Loop := True;
    END;
  ExitGraphics;

END.
