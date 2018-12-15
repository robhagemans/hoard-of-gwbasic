{
 *****************************************************************************
 * P-DEMO2 - Palette demo.						     *
 *									     *
 * Written for GRAFIX by:  Joseph A. Albrecht				     *
 *									     *
 * Press F10 to toggle between 320 and 640 graphic modes		     *
 * Press ESC to exit program						     *
 *****************************************************************************
}

PROGRAM PaletteDemo2;

USES
  Crt,
  Grafix;

TYPE
  PaletteArray = ARRAY[0..15] OF WORD;

CONST
   H0: PaletteArray = (00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00);
   H1: PaletteArray = (00,01,08,08,08,07,03,08,00,00,00,00,00,00,00,00);
   H2: PaletteArray = (00,01,08,08,06,10,03,08,00,00,00,00,00,00,00,00);
   H3: PaletteArray = (00,01,08,08,10,03,03,08,00,00,00,00,00,00,00,00);
   H4: PaletteArray = (00,01,06,14,06,10,03,04,00,00,00,00,00,00,00,00);
   H5: PaletteArray = (00,01,14,06,10,03,04,14,00,00,00,00,00,00,00,00);
   H6: PaletteArray = (00,01,06,14,06,10,14,14,00,00,00,00,00,00,00,00);
   H7: PaletteArray = (00,01,14,06,10,03,04,14,00,00,00,00,00,00,00,00);
   H8: PaletteArray = (00,01,06,14,06,10,03,04,03,00,00,14,00,00,00,00);
   H9: PaletteArray = (00,01,14,06,10,03,04,14,00,09,00,00,06,00,00,00);
   H10: PaletteArray = (00,01,06,14,06,10,14,14,00,00,01,00,00,04,00,00);
   H11: PaletteArray = (00,01,14,06,10,03,04,14,00,10,00,00,00,00,05,00);
   H12: PaletteArray = (00,01,06,14,06,10,03,04,03,00,00,00,00,00,00,09);

VAR
  Image: ARRAY[0..16006] OF WORD;
  C1: ARRAY[1..2] OF INTEGER;
  C2: ARRAY[1..3] OF INTEGER;
  J, L, N, T, X, Y, Z, S1, NoTimes, Times, Graphics: INTEGER;
  Tandy11: BOOLEAN;

PROCEDURE CheckKey;

VAR
  Ch: CHAR;

BEGIN

  Ch := #255;
  IF KeyPressed THEN
    Ch := ReadKey;
  IF Ch = #27 THEN
    BEGIN
      AudioOff;
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
	      HighGraphics;
	      PaletteUsing(H0[0]);
	      ExtPut(0, 0, Image[0], PutXor);
	      ExtPut(320, 0, Image[0], PutXor);
	    END
	  ELSE
	    BEGIN
	      Graphics := 320;
	      MediumGraphics;
	      PaletteUsing(H0[0]);
	      ExtPut(0, 0, Image[0], PutXor);
	    END;
	END;
    END;

END;

PROCEDURE MakeNoise;

BEGIN

 Noise(5, 8, 12);
 CheckKey;

END;

PROCEDURE GetZ;

BEGIN

  Z := Random(3) + 1;
  Pause(2);
  CheckKey;

END;

PROCEDURE GenerateSound;

BEGIN

 ExtSound(S1, 10, 7, 0);
 ExtSound(S1 + 5, 10, 7, 1);
 ExtSound(S1 + 10, 10, 7, 2);
 Inc(S1, 5);
 CheckKey;

END;

PROCEDURE LightCoils1;

BEGIN

  PaletteUsing(H2[0]);
  Pause(3);
  CheckKey;

END;

PROCEDURE LightCoils2;

BEGIN

  PaletteUsing(H3[0]);
  Pause(3);
  CheckKey;

END;

PROCEDURE LightPosts;

BEGIN

  SetPalette(Green, Brown);
  SetPalette(Cyan, Yellow);
  J := 1;
  FOR T := 1 TO 2 DO
    BEGIN
      Y := 193;
      WHILE Y >= 58 DO
	BEGIN
	  X := 42;
	  WHILE X <= 278 DO
	    BEGIN
	      ExtPaint(X, Y, C1[J], Blue);
	      IF Graphics = 640 THEN
		ExtPaint(X + 320, Y, C1[J], Blue);
	      Inc(X, 236);
	    END;
	  Dec(Y, 14);
	END;
      GenerateSound;
      SetPlotColor(C1[J]);
      ExtLine(68, 42, 72, 42);
      ExtLine(250, 42, 253, 42);
      IF Graphics = 640 THEN
	BEGIN
	  ExtLine(388, 42, 392, 42);
	  ExtLine(570, 42, 573, 42);
	END;
      J := (J Mod 2) + 1;
    END;
  CheckKey;

END;

PROCEDURE LightGlobes;

BEGIN

  PaletteUsing(H4[0]);
  Pause(3);
  PaletteUsing(H5[0]);
  Pause(3);
  GenerateSound;
  PaletteUsing(H6[0]);
  Pause(3);
  PaletteUsing(H7[0]);
  Pause(3);
  GenerateSound;
  CheckKey;

END;

PROCEDURE LightArcs;

BEGIN

  MakeNoise;
  PaletteUsing(H4[0]);
  GetZ;
  SetPalette(DarkGray, C2[Z]);
  PaletteUsing(H5[0]);
  GetZ;
  SetPalette(LightBlue, C2[Z]);
  PaletteUsing(H6[0]);
  GetZ;
  SetPalette(LightGreen, C2[Z]);
  PaletteUsing(H7[0]);
  GetZ;
  SetPalette(LightBlue, C2[Z]);
  CheckKey;

END;

PROCEDURE LightEmAll;

BEGIN

  FOR T := 1 TO 5 DO
    BEGIN
      Noise(5, L, 18);
      PaletteUsing(H8[0]);
      Pause(3);
      PaletteUsing(H9[0]);
      Pause(3);
      PaletteUsing(H10[0]);
      Pause(3);
      PaletteUsing(H11[0]);
      Pause(3);
      PaletteUsing(H12[0]);
      Pause(3);
      Inc(L, 1);
      CheckKey;
    END;

END;

{Mainline}
BEGIN

  Graphics := 320;
  C1[1] := Green;
  C1[2] := Cyan;
  C2[1] := Blue;
  C2[2] := Cyan;
  C2[3] := Yellow;
  GetTandy11(Tandy11);
  BLoad('P-DEMO2.BIN', Image[0]);
  MediumGraphics;
  Randomize;
  AudioOff;
  SpeakerOn;
  PaletteUsing(H0[0]);
  ExtPut(0, 0, Image[0], PutXor);
  IF Graphics = 640 THEN
    ExtPut(320, 0, Image[0], PutXor);

{MainLoop}
  WHILE True DO
    BEGIN
      S1 := 120;
      FOR N := 1 TO 7 DO
	BEGIN
	  LightCoils1;
	  GenerateSound;
	  LightCoils2;
	  GenerateSound;
	END;
      FOR N := 1 TO 7 DO
	BEGIN
	  LightPosts;
	  LightCoils1;
	  LightCoils2;
	  GenerateSound;
	END;
      FOR N := 1 TO 4 DO
	LightGlobes;
      FOR N := 1 TO 5 DO
	BEGIN
	  LightArcs;
	  GenerateSound;
	END;
      Randomize;
      Times := 0;
      NoTimes := Random(7) + 1;
      WHILE Times < NoTimes DO
	BEGIN
	  L := 6;
	  LightEmAll;
	  Inc(Times);
	END;
    END;

END.

