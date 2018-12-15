{
 ******************************************************************************
 * PUT-1 - 'Put' function demo.						      *
 *									      *
 * Written for GRAFIX by:  Joseph A. Albrecht				      *
 *									      *
 * Press F10 to toggle between 320 and 640 graphic modes		      *
 * Press ESC to exit program						      *
 ******************************************************************************
}

PROGRAM PutDemo1;

USES
  Crt,
  Grafix;

VAR
  Graphics, BoxStep, BoxWidth, B, C, I, J, K, M, N, P, X, Y, X1: INTEGER;
  Box: ARRAY[0..138] OF WORD;
  Color: ARRAY [0..15] OF STRING[10];
  Method: ARRAY [1..5] OF STRING[6];
  Ch: CHAR;
  EndProgram, Loop, Tandy11, NextColor: BOOLEAN;

PROCEDURE ShowPreset;

BEGIN

 ExtPut(X, Y, Box[0], PutPreset);

END;

PROCEDURE ShowPset;

BEGIN

  ExtPut(X, Y, Box[0], PutPset);

END;

PROCEDURE ShowAnd;

BEGIN

  ExtPut(X, Y, Box[0], PutAnd);

END;

PROCEDURE ShowOr;

BEGIN

  ExtPut(X, Y, Box[0], PutOr);

END;

PROCEDURE ShowXor;

BEGIN

  ExtPut(X, Y, Box[0], PutXor);

END;

PROCEDURE PrintNames;

BEGIN

  SetCursor(N * 2 + 6, 2);
  PrintStringX(Method[N]);
  FOR P := 1 TO 12 - Length(Method[N]) DO
    PrintStringX('.');
  PrintString(Chr(N + 48));

END;

PROCEDURE DrawBoxes;

BEGIN

  IF Graphics = 320 THEN
    BEGIN
      FillBox(129, 4, 319, 195, Black);
      DrawBox(129, 4, 319, 195, Red);
    END
  ELSE
    BEGIN
      FillBox(129, 4, 639, 195, Black);
      DrawBox(129, 4, 639, 195, Red);
    END;
   SetPlotColor(Red);
   ExtLine(4, 24, 124, 24);
   IF Graphics = 320 THEN
     X1 := 137
   ELSE
     X1 := 172;
   X := X1;
   Y := 12;
   K := 0;
   FOR I := 1 TO 4 DO
     BEGIN
       FOR J := 1 TO 4 DO
	 BEGIN
	   FillBox(X, Y, X + BoxWidth, Y + 31, K);
	   IF K = 0 THEN
	     DrawBox(X, Y, X + BoxWidth, Y + 31, DarkGray);
	    X := X + BoxStep;
	    Inc(K);
	 END;
       X := X1;
       Y := Y + 48;
     END;

END;

PROCEDURE SwitchGraphics;

BEGIN

  IF Tandy11 = True THEN
    BEGIN
      Loop := False;
      IF Graphics = 320 THEN
	BEGIN
	  Graphics := 640;
	  BoxStep := 120;
	  BoxWidth := 62;
	  HighGraphics;
	END
      ELSE
	BEGIN
	  Graphics := 320;
	  BoxStep := 48;
	  BoxWidth := 31;
	  MediumGraphics;
	END;
    END;

END;

PROCEDURE ExitProgram;

BEGIN

  ExitGraphics;
  Halt(0);

END;

{Mainline}
BEGIN

  Color[0] := 'BLACK';
  Color[1] := 'BLUE';
  Color[2] := 'GREEN';
  Color[3] := 'CYAN';
  Color[4] := 'RED';
  Color[5] := 'MAGENTA';
  Color[6] := 'BROWN';
  Color[7] := 'LT GREY';
  Color[8] := 'GREY';
  Color[9] := 'LT BLUE';
  Color[10] := 'LT GREEN';
  Color[11] := 'LT CYAN';
  Color[12] := 'LT RED';
  Color[13] := 'LT MAGENTA';
  Color[14] := 'YELLOW';
  Color[15] := 'WHITE';

  Method[1] := 'PRESET';
  Method[2] := 'PSET';
  Method[3] := 'AND';
  Method[4] := 'OR';
  Method[5] := 'XOR';

  Graphics := 320;
  BoxStep := 48;
  BoxWidth := 31;
  EndProgram := False;
  Loop := True;
  NextColor := False;
  GetTandy11(Tandy11);
  MediumGraphics;

{Again}
  WHILE EndProgram = False DO
    BEGIN
      ClearScreen;
      SetTextColor(Yellow);
      DrawBoxes;
      SetTextColor(Brown);
      SetCursor(5, 5);
      PrintString('ACTION:');
      FOR N := 1 TO 5 DO
	PrintNames;
      SetTextColor(LightCyan);
      PrintString(' ');
      PrintString(' Enter number ' + Chr(24));
      PrintString(' ');
      PrintString('       or');
      PrintString(' ');
      PrintString(' press <Return>');
      PrintString(' ');
      PrintStringX(' for next color');

{MainLoop}
      WHILE Loop = True DO
	BEGIN
	  SetTextColor(Yellow);
	  SetCursor(2, 1);
	  PrintStringX('                ');
	  SetCursor(2, 2);
	  PrintStringX('Color (0-F) ');
	  C := -1;
	  ClearKey;
	  Ch := #255;
	  WHILE (C < 0) OR (C > 15) DO
	    BEGIN
	      Ch := ReadKey;
	      IF Ch = #00 THEN
		Ch := ReadKey;
	      IF Ch = #68 THEN
		BEGIN
		  SwitchGraphics;
		  C := 0;
		END;
	      Ch := UpCase(Ch);
	      CASE Ch OF
		'A'..'F': C := Ord(Ch) - 55;
		'0'..'9': C := Ord(Ch) - 48;
		#27: ExitProgram;
	      ELSE
		C := -1;
	      END;
	    END;
	  IF Loop = True THEN
	    BEGIN
	      SetCursor(2, 1);
	      PrintStringX('                ');
	      DrawBoxes;
	      IF Graphics = 320 THEN
		BEGIN
		  FillBox(1, 1, 16, 16, C);
		  ExtGet(1, 1, 16, 16, Box[0]);
		  ExtPut(1, 1, Box[0], PutXor);
		END
	      ELSE
		BEGIN
		  FillBox(1, 1, 31, 16, C);
		  ExtGet(1, 1, 31, 16, Box[0]);
		  ExtPut(1, 1, Box[0], PutXor);
		END;
	      IF C = 0 THEN
		SetTextColor(DarkGray)
	      ELSE
		SetTextColor(C);
	      SetCursor(2, (8 - Length(Color[C]) DIV 2));
	      PrintStringX(Color[C]);
	      ClearKey;
	      N := 0;
	      Ch := #255;
	      WHILE ((N < 1) OR (N > 5)) DO
		BEGIN
		  Ch := ReadKey;
		  IF Ch = #0 THEN
		    Ch := ReadKey;
		  N := Ord(Ch) - 48;
		  IF Ch = #13 THEN
		    BEGIN
		      SetCursor(2, 3);
		      PrintStringX('          ');
		      NextColor := True;
		      N := 1;
		    END;
		  IF Ch = #27 THEN
		    ExitProgram;
		  IF Ch = #68 THEN
		    SwitchGraphics;
		    N := 1;
		END;
	    END;

{NextAction}
	  WHILE (Loop = True) AND (NextColor = False) DO
	    BEGIN
	      SetTextColor(Yellow);
	      FOR B := 1 TO 3 DO
		 BEGIN
		   SetCursor(N * 2 + 6, 2);
		   PrintStringX('              ');
		   Pause(8);
		   PrintNames;
		   Pause(8);
		 END;
	      IF Graphics = 320 THEN
		X1 := 145
	      ELSE
		X1 := 188;
	      X := X1;
	      Y := 20;
	      K := 0;
	      FOR I := 1 TO 4 DO
		BEGIN
		  FOR J := 1 TO 4 DO
		    BEGIN
		      CASE N OF
			 1: ShowPreset;
			 2: ShowPset;
			 3: ShowAnd;
			 4: ShowOr;
			 5: ShowXor;
		      END;
		      X := X + BoxStep;
		      Inc(K);
		    END;
		  X := X1;
		  Y := Y + 48;
		END;
		M := 0;
		Ch := #255;
		ClearKey;
		WHILE (M < 1) OR (M > 5) DO
		  BEGIN
		    Ch := ReadKey;
		    IF Ch = #00 THEN
		      Ch := ReadKey;
		     M := Ord(Ch) - 48;
		     IF Ch = #13 THEN
		       BEGIN
			 NextColor := True;
			 Loop := False;
			 M := 1;
		       END;
		     IF Ch = #27 THEN
		       ExitProgram;
		     IF Ch = #68 THEN
		       BEGIN
			 SwitchGraphics;
			 M := 1;
		       END;
		  END;
	      SetTextColor(Brown);
	      PrintNames;
	      DrawBoxes;
	      N := M;
	      IF Loop = True THEN
		NextColor := False;
	    END;
	  NextColor := False;
	END;
      Loop := True;
    END;

END.
