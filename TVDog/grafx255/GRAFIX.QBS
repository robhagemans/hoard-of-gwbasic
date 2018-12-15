' 
'Subprogram interface file for QuickBASIC
' 

'$INCLUDE: 'GRAFQBS.INC' 

SUB AudioOff

  CALL SetSystem(10)

END SUB

SUB ClearKey
  WHILE INKEY$ <> ""
  WEND
END SUB

SUB ColorOff

  CALL ColorEnable(0)

END SUB

SUB ColorOn

  CALL ColorEnable(1)

END SUB

SUB CursorOff

  CALL CursorAction(0)

END SUB

SUB CursorOn

  CALL CursorAction(1)

END SUB

SUB LowGraphics

   IF GetSystem%(0) <> &HDEAD THEN
     SCREEN 0, 0, 0
     WIDTH 80
     PRINT "GRAFIX Driver Not Loaded!"
     PRINT "Press Any Key To Continue . . ."
     CALL WaitKey
     END
   END IF
   CALL SetSystem(13)

END SUB

SUB MediumGraphics

   IF GetSystem%(0) <> &HDEAD THEN
     SCREEN 0, 0, 0
     WIDTH 80
     PRINT "GRAFIX Driver Not Loaded!"
     PRINT "Press Any Key To Continue . . ."
     CALL WaitKey
     END
   END IF
   CALL SetSystem(2)

END SUB

SUB HighGraphics

  IF GetSystem%(0) <> &HDEAD THEN
     SCREEN 0, 0, 0
     WIDTH 80
     PRINT "GRAFIX Driver Not Loaded!"
     PRINT "Press Any Key To Continue . . ."
     CALL WaitKey
     END
  END IF
  Tandy11% = GetSystem(12)
  IF Tandy11% = Tandy11.False% THEN
     SCREEN 0, 0, 0
     WIDTH 80
     PRINT "TANDY11 Driver For 640x200x16 Color Graphics Mode Not Loaded!"
     PRINT "Press Any Key To Continue . . ."
     CALL WaitKey
     END
  END IF
  CALL SetSystem(11)

END SUB

SUB ExitGraphics

  CALL SetSystem(3)
  SCREEN 0, 0, 0
  WIDTH 80

END SUB

SUB GetBackColor (BackColor%)

  BackColor% = GetColor%(3)

END SUB

SUB GetInput (Prompt$, GS$)
  CALL CursorStatus(SaveCursor%, SaveSize%)
  CALL CursorOn
  CALL NormalCursor
  CALL PrintStringX(Prompt$)
  CALL GetCursor(R%, StartCol%)
  Tandy11% = GetSystem(12)
  IF Tandy11% = Tandy11.True% THEN
    Max% = 80 - StartCol% + 1
  ELSE
    Max% = 40 - StartCol% + 1
  END IF
  P% = 1
  Insert% = 0
  Temp$ = SPACE$(Max%)
  WHILE INKEY$ <> ""
  WEND
  DO
    K$ = ""
    WHILE K$ = ""
      K$ = INKEY$
    WEND
    K% = ASC(RIGHT$(K$, 1))
    WhatToDo% = 0
    IF LEN(K$) = 1 THEN
      SELECT CASE K%
	CASE 8	'Back Space
	  P% = P% - 1
	  IF P% < 1 THEN P% = 1
	  Temp$ = LEFT$(Temp$, P% - 1) + RIGHT$(Temp$, LEN(Temp$) - P%) + " "
	  WhatToDo% = 2
	CASE 13  'Enter
	  EXIT DO
	CASE 27  'Escape
	  Temp$ = SPACE$(Max%)
	  P% = 1
	  WhatToDo% = 2
	CASE 32 TO 126	'ASC 32 - 126
	  IF Insert% = 0 THEN
	    MID$(Temp$, P%, 1) = K$
	    WhatToDo% = 1
	    P% = P% + 1
	    IF P% > Max% THEN
	      P% = 1
	      WhatToDo% = 2
	    END IF
	  END IF
	  IF Insert% = 1 THEN
	    Temp$ = LEFT$(Temp$, P% - 1) + K$ + MID$(Temp$, P%, LEN(Temp$) - P%)
	    P% = P% + 1
	    IF P% > Max% THEN P% = 1
	    WhatToDo% = 2
	  END IF
	CASE ELSE
      END SELECT
    END IF
    IF LEN(K$) = 2 THEN
      SELECT CASE K%
	CASE 71  'Home
	  P% = 1
	CASE 75  'Cursor Left
	  P% = P% - 1
	  IF P% < 1 THEN P% = 1
	CASE 77  'Cursor Right
	  P% = P% + 1
	  IF P% > Max% THEN P% = Max%
	CASE 79  'End
	  FOR X% = Max% TO 1 STEP -1
	    IF MID$(Temp$, X%, 1) <> " " THEN EXIT FOR
	  NEXT X%
	  P% = X% + 1
	  IF P% = Max% + 1 THEN P% = Max%
	CASE 82  'Insert
	  IF Insert% = 0 THEN
	    Insert% = 1
	    CALL HalfCursor
	  ELSE
	    Insert% = 0
	    CALL NormalCursor
	  END IF
	CASE 83  'Delete
	  Temp$ = LEFT$(Temp$, P% - 1) + RIGHT$(Temp$, LEN(Temp$) - P%) + " "
	  WhatToDo% = 2
	CASE ELSE
      END SELECT
    END IF
    SELECT CASE WhatToDo%
      CASE 0
	CALL SetCursor(R%, (StartCol% + P% - 1))
      CASE 1
	CALL SetCursor(R%, (StartCol% + P% - 2))
	CALL PrintStringX(K$)
	CALL SetCursor(R%, (StartCol% + P% - 1))
      CASE 2
	CALL SetCursor(R%, StartCol%)
	CALL PrintStringX(Temp$)
	CALL SetCursor(R%, (StartCol% + P% - 1))
    END SELECT
  LOOP
  FOR X% = Max% TO 1 STEP -1
    IF MID$(Temp$, X%, 1) <> " " THEN EXIT FOR
  NEXT X%
  GS$ = LEFT$(Temp$, X%)
  R% = R% + 1
  IF R% > 25 THEN R% = 1
  CALL SetCursor(R%, 1)
  IF SaveCursor% = 0 THEN CALL CursorOff
  IF SaveCursor% = 1 THEN CALL CursorOn
  IF SaveSize% = 0 THEN CALL NormalCursor
  IF SaveSize% = 1 THEN CALL HalfCursor

END SUB

SUB GetPlotColor (PlotColor%)

  PlotColor% = GetColor%(1)

END SUB

SUB GetTextColor (TextColor%)

  TextColor% = GetColor%(2)

END SUB

SUB GraphStatus (Status%)

  Status% = GetSystem%(1)

END SUB

SUB HalfCursor

  CALL CursorAction(3)

END SUB

SUB NoiseBufOff

  CALL SetSystem(9)

END SUB

SUB NoiseBufOn

  CALL SetSystem(8)

END SUB

SUB NoiseOff

  CALL SetSystem(7)

END SUB

SUB NormalCursor

  CALL CursorAction(2)

END SUB

SUB PrintString (GS$)

  CALL PrintStringA(1, LEN(GS$), VARSEG(GS$), SADD(GS$))

END SUB

SUB PrintStringX (GS$)

  CALL PrintStringA(0, LEN(GS$), VARSEG(GS$), SADD(GS$))

END SUB

SUB SetBackColor (BackColor%)

  CALL SetColor(3, BackColor%)

END SUB

SUB SetPlotColor (PlotColor%)

  CALL SetColor(1, PlotColor%)

END SUB

SUB SetTextColor (TextColor%)

  CALL SetColor(2, TextColor%)

END SUB

SUB SoundBufOff

  CALL SetSystem(6)

END SUB

SUB SoundBufOn

  CALL SetSystem(5)

END SUB

SUB SoundOff

  CALL SetSystem(4)

END SUB

SUB WaitKey

  CALL ClearKey
  WHILE INKEY$ = ""
  WEND

END SUB

