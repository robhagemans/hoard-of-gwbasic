{
 ******************************************************************************
 * BALL - Bouncing ball animation demo using XOR option.		      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press ESC to exit program						      *
 * Press F3 to toggle sound on/off					      *
 * Press F5 to toggle clipping mode					      *
 * Press F10 to toggle between 320 and 640 graphics modes		      *
 ******************************************************************************
}

PROGRAM BouncingBall;

USES
  Crt,
  Grafix;

TYPE
  Note = ARRAY [1..84] OF INTEGER;

VAR
  Graphics, XOffset, Clip, D, E, J, K, L, N, S, X, X2, Y, Y2: INTEGER;
  Tandy11, Loop, EndProgram, DoSound: BOOLEAN;
  BALL: ARRAY [0..115] OF WORD;
  B: ARRAY [0..280] OF INTEGER;

CONST
  Notes:
    Note =
      (65,69,73,78,82,87,93,98,104,110,116,123,131,139,147,156,165,175,185,196,
       208,220,233,247,262,277,294,311,330,349,370,392,415,440,466,494,523,554,
       587,622,659,698,740,784,831,880,932,988,1047,1109,1175,1245,1319,1397,
       1480,1568,1661,1760,1865,1976,2091,2217,2349,2489,2637,2794,2960,3136,
       3322,3520,3729,3951,4186,4435,4699,4978,5274,5587,5919,6271,6645,7040,
       7459,7902);

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
      IF Ch = #61 THEN
	IF DoSound = True THEN
	  DoSound := False
	ELSE
	  DoSound := True;
      IF Ch = #63 THEN
	BEGIN
	  Loop := False;
	  IF Clip = 1 THEN
	    Clip := 0
	  ELSE
	    Clip := 1;
	END;
      IF (Ch = #68) AND (Tandy11 = True) THEN
	BEGIN
	  IF Graphics = 320 THEN
	    BEGIN
	      Graphics := 640;
	      XOffset := 160;
	      Loop := False;
	      HighGraphics;
	    END
	  ELSE
	     BEGIN
	       Graphics := 320;
	       XOffset := 0;
	       Loop := False;
	       MediumGraphics;
	     END;
	END;
    END;

END;

{Mainline}
BEGIN

  Graphics := 320;
  XOffset := 0;
  Clip := 0;
  DoSound := True;
  Loop := True;
  EndProgram := False;
  GetTandy11(Tandy11);
  FOR X := 0 TO 280 DO
    B[X] := 0;
  X := 20;
  WHILE X <= 280 DO
    BEGIN
      B[X] := Round(159 - (Abs(Sin(X * 0.07853981) * X) / 2));
      Inc(X, 4);
    END;
  MediumGraphics;

WHILE EndProgram = False DO
  BEGIN
    ResetView;
    ClearScreen;
    SetBackColor(LightGray);
    ExtCircleC(160, 100, 10, DarkGray);
    ExtPaint(160, 100, DarkGray, DarkGray);
    ExtGet(150, 90, 170, 110, Ball[0]);
    ClearScreen;
    DrawBox(18 + XOffset, 0, 302 + XOffset, 179, Red);
    DrawBox(19 + XOffset, 1, 301 + XOffset, 178, Red);
    IF Clip = 1 THEN
      BEGIN
	DrawBox(79 + XOffset, 74, 241 + XOffset, 151, Blue);
	DrawBox(78 + XOffset, 73, 242 + XOffset, 152, Blue);
	SetView(80 + XOffset, 75, 240 + XOffset, 150);
      END;
    FillBox(160 + XOffset, 2, 190 + XOffset, 177, LightBlue);
    FillBox(191 + XOffset, 2, 222 + XOffset, 177, LightRed);
    FillBox(223 + XOffset, 2, 253 + XOffset, 177, Yellow);
    L := 6;
    X2 := 20;
    Y2 := 150;
    ExtPut(X2 + XOffset, Y2, Ball[0], PutXor);
    WHILE Loop = True DO
     BEGIN
       FOR D := 0 TO 1 DO
	 BEGIN
	   S := (20 + (D * 260));
	   E := (280 - (D * 260));
	   X := S;
	   J := S;
	   K := E;
	   IF D = 1 THEN
	     BEGIN
	       K := S;
	       J := E;
	     END;
	   WHILE (J <= K) AND (Loop = True) DO
	     BEGIN
	       Y := B[X];
	       ExtPut(X2 + XOffset, Y2, Ball[0], PutXor);
	       ExtPut(X + XOffset, Y, Ball[0], PutXor);
	       N := (210 - Y2) Div 5;
	       IF DoSound = True THEN
		 ExtSound(Notes[N], Round(21.0 / L * 0.875), 10, 0)
	       ELSE
		 Pause(Round(21.0 / L * 0.875));
	       X2 := X;
	       Y2 := Y;
	       X := X + (4 - (8 * D));
	       IF D = 0 THEN
		 J := X
	       ELSE
		 K := X;
	       CheckKey;
	     END;
	   L := L + 3;
	   IF L > 21 THEN
	     L := 6;
	 END;
     END;
     IF EndProgram = False THEN
       Loop := True;
  END;
  ExitGraphics;

END.
