{
  Procedures interface unit file for QuickPASCAL/Turbo PASCAL
}

UNIT	Grafix;

INTERFACE

USES
  Crt;

CONST
  PutPreset = 1;
  PutPset = 2;
  PutAnd = 3;
  PutOr = 4;
  PutXor = 5;

PROCEDURE Animate(X, Y, Speed: WORD; VAR Image: WORD);
PROCEDURE AudioOff;
PROCEDURE BLoad(FileName: STRING; VAR BLoadArea: WORD);
PROCEDURE ClearKey;
PROCEDURE ClearScreen;
PROCEDURE ColorEnable(Action: WORD);
PROCEDURE ColorOff;
PROCEDURE ColorOn;
PROCEDURE CurrentPoint(VAR X, Y: WORD);
PROCEDURE CursorAction(Action: WORD);
PROCEDURE CursorOff;
PROCEDURE CursorOn;
PROCEDURE CursorStatus(VAR Status, CursorSize:	WORD);
PROCEDURE DrawBox( X1, Y1, X2, Y2, Color: WORD);
PROCEDURE DrawBoxC(X1, Y1, X2, Y2: WORD);
PROCEDURE ExitGraphics;
PROCEDURE Ellipse(X, Y, A, B: WORD);
PROCEDURE EllipseC(X, Y, A, B, Color: WORD);
PROCEDURE ExtCircle( X, Y, Radius: WORD);
PROCEDURE ExtCircleC(X, Y, Radius, Color: WORD);
PROCEDURE ExtGet(X1, Y1, X2, Y2: WORD; VAR Image: WORD);
PROCEDURE ExtLine(X1, Y1, X2, Y2: WORD);
PROCEDURE ExtLineC(X1, Y1, X2, Y2, Color: WORD);
PROCEDURE ExtPaint( X, Y, Fill, Boundry: WORD);
PROCEDURE ExtPut(X, Y: WORD; VAR Image: WORD; Action: WORD);
PROCEDURE ExtSound(Frequency, Duration, Volume, Channel: WORD);
PROCEDURE FillBox(X1, Y1, X2, Y2, Color: WORD);
PROCEDURE FillBoxC(X1, Y1, X2, Y2: WORD);
PROCEDURE GetAspect(VAR XAspect, YAspect: WORD);
PROCEDURE GetBackColor(VAR BackColor: WORD);
FUNCTION  GetColor(ColorType: WORD): WORD;
PROCEDURE GetCursor(VAR Row, Column: WORD);
PROCEDURE GetInput(Prompt: STRING; VAR GS: STRING);
PROCEDURE GetPlotColor(VAR PlotColor: WORD);
PROCEDURE GetScreen(VAR Image: WORD);
FUNCTION  GetSystem(Action: WORD): WORD;
PROCEDURE GetTandy11(VAR Tandy11: BOOLEAN);
PROCEDURE GetTextColor(VAR TextColor: WORD);
PROCEDURE GetView(VAR MinX, MinY, MaxX, MaxY: WORD);
PROCEDURE GraphStatus(VAR Status: WORD);
PROCEDURE HalfCursor;
PROCEDURE HighGraphics;
FUNCTION  Left(S: STRING; L: WORD): STRING;
PROCEDURE LineRel(X, Y: WORD);
PROCEDURE LineRelC(X, Y, Color: WORD);
PROCEDURE LineTo(X, Y: WORD);
PROCEDURE LineToC(X, Y, Color: WORD);
PROCEDURE LowGraphics;
PROCEDURE MediumGraphics;
FUNCTION  Mid(S: STRING; P, L: WORD): STRING;
PROCEDURE MoveRel(X, Y: WORD);
PROCEDURE MoveTo(X, Y: WORD);
PROCEDURE Noise(NoiseType, Volume, Duration: WORD);
PROCEDURE NoiseBufOff;
PROCEDURE NoiseBufOn;
PROCEDURE NoiseOff;
PROCEDURE NormalCursor;
PROCEDURE PaletteUsing(VAR PalArray: WORD);
PROCEDURE Pause(Duration: WORD);
PROCEDURE PointColor(X, Y: WORD; VAR Color: WORD);
PROCEDURE PlotPoint(X, Y: WORD);
PROCEDURE PlotPointC(X, Y, Color: WORD);
PROCEDURE PrintString(GraphString: STRING);
PROCEDURE PrintStringX(GraphString: STRING);
PROCEDURE PrintStringA(Action, Strlen: WORD; VAR GraphString: STRING);
PROCEDURE PutScreen(VAR Image: WORD);
PROCEDURE ResetPalette;
PROCEDURE ResetView;
FUNCTION  Right(S: STRING; L: WORD): STRING;
PROCEDURE SetAspect(XAspect, YASpect: WORD);
PROCEDURE SetBackColor(BackColor: WORD);
PROCEDURE SetColor(ColorType, Color: WORD);
PROCEDURE SetCursor(Row, Column: WORD);
PROCEDURE SetPalette(PalReg, Color: WORD);
PROCEDURE SetPlotColor(PlotColor: WORD);
PROCEDURE SetSystem(Action: WORD);
PROCEDURE SetTextColor(TextColor: WORD);
PROCEDURE SetView(MinX, MinY, MaxX, MaxY: WORD);
PROCEDURE SoundBufOff;
PROCEDURE SoundBufOn;
PROCEDURE SoundOff;
PROCEDURE SpeakerOff;
PROCEDURE SpeakerOn;
PROCEDURE WaitKey;
PROCEDURE XorCircle(X, Y, Radius: WORD);
PROCEDURE XorCircleC(X, Y, Radius, Color: WORD);
PROCEDURE XorDrawBox(X1, Y1, X2, Y2, Color: WORD);
PROCEDURE XorDrawBoxC(X1, Y1, X2, Y2: WORD);
PROCEDURE XorEllipse(X, Y, A, B: WORD);
PROCEDURE XorEllipseC(X, Y, A, B, Color: WORD);
PROCEDURE XorFillBox(X1, Y1, X2, Y2, Color: WORD);
PROCEDURE XorFillBoxC(X1, Y1, X2, Y2: WORD);
PROCEDURE XorLine(X1, Y1, X2, Y2: WORD);
PROCEDURE XorLineC(X1, Y1, X2, Y2, Color: WORD);
PROCEDURE XorLineRel(X, Y: WORD);
PROCEDURE XorLineRelC(X, Y, Color: WORD);
PROCEDURE XorLineTo(X, Y: WORD);
PROCEDURE XorLineToC(X, Y, Color: WORD);
PROCEDURE XorPoint(X, Y: WORD);
PROCEDURE XorPointC(X, Y: WORD);
PROCEDURE SetDisplayPage(Page: WORD);
PROCEDURE GetDisplayPage(VAR Page: WORD);
PROCEDURE SetActivePage(Page: WORD);
PROCEDURE GetActivePage(VAR Page: WORD);
PROCEDURE PageCopy(Source, Destination: WORD);
PROCEDURE FastTimer(Speed: WORD);
PROCEDURE ResetTimer;
PROCEDURE GetTimer(VAR TimerValue: WORD);

IMPLEMENTATION

{$L GRAFPAS.OBJ}

PROCEDURE Animate(X, Y, Speed: WORD; VAR Image: WORD);	EXTERNAL;
PROCEDURE ClearScreen;EXTERNAL;
PROCEDURE ColorEnable(Action: WORD);  EXTERNAL;
PROCEDURE CurrentPoint(VAR X, Y: WORD);  EXTERNAL;
PROCEDURE CursorAction(Action: WORD);  EXTERNAL;
PROCEDURE CursorStatus(VAR Status, CursorSize:	WORD);	EXTERNAL;
PROCEDURE DrawBox( X1, Y1, X2, Y2, Color: WORD);  EXTERNAL;
PROCEDURE DrawBoxC(X1, Y1, X2, Y2: WORD);  EXTERNAL;
PROCEDURE Ellipse(X, Y, A, B: WORD);  EXTERNAL;
PROCEDURE EllipseC(X, Y, A, B, Color: WORD);  EXTERNAL;
PROCEDURE ExtCircle( X, Y, Radius: WORD);  EXTERNAL;
PROCEDURE ExtCircleC(X, Y, Radius, Color: WORD);  EXTERNAL;
PROCEDURE ExtGet(X1, Y1, X2, Y2: WORD; VAR Image: WORD);  EXTERNAL;
PROCEDURE ExtLine(X1, Y1, X2, Y2: WORD);  EXTERNAL;
PROCEDURE ExtLineC(X1, Y1, X2, Y2, Color: WORD);  EXTERNAL;
PROCEDURE ExtPaint( X, Y, Fill, Boundry: WORD);  EXTERNAL;
PROCEDURE ExtPut(X, Y: WORD; VAR Image: WORD; Action: WORD);  EXTERNAL;
PROCEDURE ExtSound(Frequency, Duration, Volume, Channel: WORD);  EXTERNAL;
PROCEDURE FastTimer(Speed: WORD); EXTERNAL;
PROCEDURE FillBox(X1, Y1, X2, Y2, Color: WORD);  EXTERNAL;
PROCEDURE FillBoxC(X1, Y1, X2, Y2: WORD);  EXTERNAL;
PROCEDURE GetActivePage(VAR Page: WORD); EXTERNAL;
PROCEDURE GetAspect(VAR XAspect, YAspect: WORD);  EXTERNAL;
FUNCTION  GetColor(ColorType: WORD): WORD;EXTERNAL;
PROCEDURE GetCursor(VAR Row, Column: WORD);  EXTERNAL;
PROCEDURE GetDisplayPage(VAR Page: WORD); EXTERNAL;
PROCEDURE GetScreen(VAR Image: WORD); EXTERNAL;
FUNCTION  GetSystem(Action: WORD): WORD;EXTERNAL;
PROCEDURE GetTimer(VAR TimerValue: WORD); EXTERNAL;
PROCEDURE GetView(VAR MinX, MinY, MaxX, MaxY: WORD);  EXTERNAL;
PROCEDURE LineRel(X, Y: WORD);	EXTERNAL;
PROCEDURE LineRelC(X, Y, Color: WORD);	EXTERNAL;
PROCEDURE LineTo(X, Y: WORD);  EXTERNAL;
PROCEDURE LineToC(X, Y, Color: WORD);  EXTERNAL;
PROCEDURE MoveRel(X, Y: WORD);	EXTERNAL;
PROCEDURE MoveTo(X, Y: WORD);  EXTERNAL;
PROCEDURE Noise(NoiseType, Volume, Duration: WORD);  EXTERNAL;
PROCEDURE PageCopy(Source, Destination: WORD); EXTERNAL;
PROCEDURE PaletteUsing(VAR PalArray: WORD);  EXTERNAL;
PROCEDURE Pause(Duration: WORD);  EXTERNAL;
PROCEDURE PointColor(X, Y: WORD; VAR Color: WORD);  EXTERNAL;
PROCEDURE PlotPoint(X, Y: WORD);  EXTERNAL;
PROCEDURE PlotPointC(X, Y, Color: WORD);  EXTERNAL;
PROCEDURE PrintStringA(Action, Strlen: WORD; VAR GraphString: STRING);	EXTERNAL;
PROCEDURE PutScreen(VAR Image: WORD); EXTERNAL;
PROCEDURE ResetPalette;EXTERNAL;
PROCEDURE ResetTimer; EXTERNAL;
PROCEDURE ResetView;EXTERNAL;
PROCEDURE SetActivePage(Page: WORD); EXTERNAL;
PROCEDURE SetAspect(XAspect, YASpect: WORD);  EXTERNAL;
PROCEDURE SetColor(ColorType, Color: WORD);  EXTERNAL;
PROCEDURE SetCursor(Row, Column: WORD);  EXTERNAL;
PROCEDURE SetDisplayPage(Page: WORD); EXTERNAL;
PROCEDURE SetPalette(PalReg, Color: WORD);  EXTERNAL;
PROCEDURE SetSystem(Action: WORD);  EXTERNAL;
PROCEDURE SetView(MinX, MinY, MaxX, MaxY: WORD);  EXTERNAL;
PROCEDURE SpeakerOff;EXTERNAL;
PROCEDURE SpeakerOn;EXTERNAL;
PROCEDURE XorCircle(X, Y, Radius: WORD);  EXTERNAL;
PROCEDURE XorCircleC(X, Y, Radius, Color: WORD);  EXTERNAL;
PROCEDURE XorDrawBox(X1, Y1, X2, Y2, Color: WORD);  EXTERNAL;
PROCEDURE XorDrawBoxC(X1, Y1, X2, Y2: WORD);  EXTERNAL;
PROCEDURE XorEllipse(X, Y, A, B: WORD);  EXTERNAL;
PROCEDURE XorEllipseC(X, Y, A, B, Color: WORD);  EXTERNAL;
PROCEDURE XorFillBox(X1, Y1, X2, Y2, Color: WORD);  EXTERNAL;
PROCEDURE XorFillBoxC(X1, Y1, X2, Y2: WORD);  EXTERNAL;
PROCEDURE XorLine(X1, Y1, X2, Y2: WORD);  EXTERNAL;
PROCEDURE XorLineC(X1, Y1, X2, Y2, Color: WORD);  EXTERNAL;
PROCEDURE XorLineRel(X, Y: WORD);  EXTERNAL;
PROCEDURE XorLineRelC(X, Y, Color: WORD);  EXTERNAL;
PROCEDURE XorLineTo(X, Y: WORD);  EXTERNAL;
PROCEDURE XorLineToC(X, Y, Color: WORD);  EXTERNAL;
PROCEDURE XorPoint(X, Y: WORD);  EXTERNAL;
PROCEDURE XorPointC(X, Y: WORD);  EXTERNAL;

PROCEDURE AudioOff;

BEGIN

  SetSystem(10);

END;

PROCEDURE ColorOff;

BEGIN

  ColorEnable(0);

END;

PROCEDURE ColorOn;

BEGIN

  ColorEnable(1);

END;

PROCEDURE CursorOff;

BEGIN

  CursorAction(0);

END;

PROCEDURE CursorOn;

BEGIN

  CursorAction(1);

END;

PROCEDURE LowGraphics;

BEGIN

   IF GetSystem(0) <> $DEAD THEN
     BEGIN
       WriteLn('GRAFIX Driver Not Loaded');
       Halt(1);
     END
   ELSE
     SetSystem(13);

END;

PROCEDURE MediumGraphics;

BEGIN

   IF GetSystem(0) <> $DEAD THEN
     BEGIN
       WriteLn('GRAFIX Driver Not Loaded');
       Halt(1);
     END
   ELSE
     SetSystem(2);

END;

PROCEDURE HighGraphics;

VAR
  Tandy11: BOOLEAN;

BEGIN

   IF GetSystem(0) <> $DEAD THEN
     BEGIN
       WriteLn('GRAFIX Driver Not Loaded');
       Halt(1);
     END;
    GetTandy11(Tandy11);
    IF Tandy11 = False THEN
      BEGIN
	WriteLn('TANDY11 Driver For 640x200x16 Color Graphics Mode Not Loaded');
	Halt(1);
      END
     ELSE
       SetSystem(11);

END;


PROCEDURE ExitGraphics;

BEGIN

  SetSystem(3);

END;

PROCEDURE GetBackColor(VAR BackColor: WORD);

BEGIN

  BackColor := GetColor(3);

END;

PROCEDURE GetPlotColor(VAR PlotColor: WORD);

BEGIN

  PlotColor := GetColor(1);

END;

PROCEDURE GetTextColor(VAR TextColor: WORD);

BEGIN

  TextColor := GetColor(2);

END;

PROCEDURE GraphStatus(VAR Status: WORD);

BEGIN

  Status := GetSystem(1);

END;

PROCEDURE HalfCursor;

BEGIN

  CursorAction(3);

END;

PROCEDURE NoiseBufOff;

BEGIN

  SetSystem(9);

END;

PROCEDURE NoiseBufOn;

BEGIN

  SetSystem(8);

END;

PROCEDURE NoiseOff;

BEGIN

  SetSystem(7);

END;

PROCEDURE NormalCursor;

BEGIN

  CursorAction(2);

END;


PROCEDURE SetBackColor(BackColor: WORD);

BEGIN


  SetColor(3, BackColor);

END;

PROCEDURE SetPlotColor(PlotColor: WORD);

BEGIN


  SetColor(1, PlotColor);

END;

PROCEDURE SetTextColor(TextColor: WORD);

BEGIN


  SetColor(2, TextColor);

END;


PROCEDURE SoundBufOff;

BEGIN

  SetSystem(6)

END;

PROCEDURE SoundBufOn;

BEGIN

  SetSystem(5)

END;

PROCEDURE SoundOff;

BEGIN

  SetSystem(4)

END;

PROCEDURE ClearKey;

VAR
  Ch: CHAR;

BEGIN

  WHILE KeyPressed DO
    Ch := ReadKey;

END; {ClearKey}

PROCEDURE WaitKey;

VAR
  Ch: CHAR;

BEGIN

  ClearKey;
  REPEAT
  UNTIL KeyPressed;
  Ch := ReadKey;

END; {WaitKey}

PROCEDURE BLoad(FileName: STRING; VAR BLoadArea: WORD);

VAR
   LoadFile: FILE;
   Count: WORD;
   Buffer: ARRAY [1..7] OF BYTE;

BEGIN

  Assign(LoadFile, FileName);
  Reset(LoadFile, 7);
  IF IOResult <> 0 THEN
    BEGIN
      ExitGraphics;
      WriteLn('File "', FileName, '" Not Found');
      Halt(1);
    END;
  BlockRead(LoadFile, Buffer, 1, Count);
  BlockRead(LoadFile, BLoadArea, FileSize(LoadFile) - 1, Count);
  Close(LoadFile);

END;

PROCEDURE PrintString(GraphString: STRING);

BEGIN

   PrintStringA(1, Length(GraphString), GraphString);

END;

PROCEDURE PrintStringX(GraphString: STRING);

BEGIN

   PrintStringA(0, Length(GraphString), GraphString);

END;

FUNCTION Left(S: STRING; L: WORD): STRING;

BEGIN

  Left := Copy(S, 1, L);

END;

FUNCTION Right(S: STRING; L: WORD): STRING;

BEGIN

  Right := Copy(S, Length(S) - L + 1, L);

END;

FUNCTION Mid(S: STRING; P, L: WORD): STRING;

BEGIN

  Mid := Copy(S, P, L);

END;

PROCEDURE GetInput (Prompt: STRING; VAR GS: STRING);

VAR
  SaveCursor, SaveSize, I, P, R, StartCol, Max, Insert, WhatToDo: WORD;
  Tandy11: BOOLEAN;
  K, L: CHAR;
  Temp, Work: STRING[80];


BEGIN
  CursorStatus(SaveCursor, SaveSize);
  CursorOn;
  NormalCursor;
  PrintStringX(Prompt);
  GetCursor(R, StartCol);
  GetTandy11(Tandy11);
  IF (Tandy11 = True) THEN
    Max := (80 - StartCol + 1)
  ELSE
    Max := (40 - StartCol + 1);
  P := 1;
  Insert := 0;
  FOR I := 1 TO Max DO
    Temp[I] := ' ';
  Temp[0] := Chr(Max);
  ClearKey;
  REPEAT
    REPEAT
    UNTIL KeyPressed;
    L :=  ReadKey;
    IF L = #00 THEN
      K := ReadKey
    ELSE
      K := L;
    WhatToDo := 0;
    IF L <> #00 THEN
      CASE K OF
	#08: {Back Space}
	   BEGIN
	     P := P - 1;
	     IF P < 1 THEN
		P := 1;
	     Temp := Left(Temp, P - 1) + Right(Temp, Length(Temp) - P) + ' ';
	     WhatToDo := 2;
	   END;
	#27: {Escape}
	  BEGIN
	    FOR I := 1 TO Max DO
	      Temp[I] := ' ';
	    Temp[0] := Chr(Max);
	    P := 1;
	    WhatToDo := 2;
	  END;
	#32..#126: {ASCII 32 - 126}
	  BEGIN
	    IF Insert = 0 THEN
	      BEGIN
		Temp[P] := K;
		WhatToDo := 1;
		Inc(P);
		IF P > Max THEN
		  BEGIN
		    P := 1;
		    WhatToDo := 2;
		  END;
	      END;
	    IF Insert = 1 THEN
	      BEGIN
		Temp := Left(Temp, P - 1) + K + Mid(Temp, P, Length(Temp) - P);
		Inc(P);
		IF P > Max THEN
		  P := 1;
		WhatToDo := 2;
	      END;
	  END;
      END;
    IF L = #00 THEN
      CASE K OF
	#71: {Home}
	  P := 1;
	#75: {Cursor Left}
	  BEGIN
	    Dec(P);
	    IF P < 1 THEN P := 1;
	  END;
	#77: {Cursor Right}
	  BEGIN
	    Inc(P);
	    IF P > Max THEN P := Max;
	  END;
	#79: {End}
	  BEGIN
	    I := Max + 1;
	    REPEAT
	      Dec(I);
	    UNTIL Temp[I] <> ' ';
	    P := I + 1;
	    IF P = Max + 1 THEN P := Max;
	  END;
	#82: {Insert}
	  BEGIN
	    IF Insert = 0 THEN
	      BEGIN
		Insert := 1;
		HalfCursor;
	      END
	    ELSE
	      BEGIN
		Insert := 0;
		NormalCursor;
	      END;
	  END;
	#83: {Delete}
	  BEGIN
	    Temp := Left(Temp, P - 1) + Right(Temp, Length(Temp) - P) + ' ';
	    WhatToDo := 2;
	  END;
    END;
    CASE WhatToDo OF
      0: SetCursor(R, (StartCol + P - 1));
      1:
	BEGIN
	  SetCursor(R, (StartCol + P - 2));
	  PrintStringX(K);
	  SetCursor(R, (StartCol + P - 1));
	END;
      2:
	BEGIN
	  SetCursor(R, StartCol);
	  PrintStringX(Temp);
	  SetCursor(R, (StartCol + P - 1));
	END;
    END;
  UNTIL K = #13;
  I := Max + 1;
  REPEAT
    Dec(I);
  UNTIL Temp[I] <> ' ';
  GS := Left(Temp, I);
  Inc(R);
  IF R > 25 THEN
    R := 1;
  SetCursor(R, 1);
  IF SaveCursor = 0 THEN
     CursorOff;
  IF SaveCursor = 1 THEN
    CursorOn;
  IF SaveSize = 0 THEN
    NormalCursor;
  IF SaveSize = 1 THEN
    HalfCursor;

END;

PROCEDURE GetTandy11(VAR Tandy11: BOOLEAN);

BEGIN

  IF GetSystem(12) = 1 THEN
    Tandy11 := True
  ELSE
    Tandy11 := False;

END;

END.
