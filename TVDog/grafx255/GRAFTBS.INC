'
'Subprogram interface file for TURBO BASIC
'

'Make sure default data type is integer
DEFINT A-Z

'Give color numbers meaningful names
Black% = 0
Blue% = 1
Green% = 2
Cyan% = 3
Red% = 4
Magenta% = 5
Brown% = 6
LightGray% = 7
DarkGray% = 8
LightBlue% = 9
LightGreen% = 10
LightCyan% = 11
LightRed% = 12
LightMagenta% = 13
Yellow% = 14
White% = 15

'Give put options meaningful names
PutPreset% = 1
PutPset% = 2
PutAnd% = 3
PutOr% = 4
PutXor% = 5

'Give Tandy11 driver status meaningful names
Tandy11.True% = 1
Tandy11.False% = 0

SUB Animate INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&H37,&HC5
  $INLINE &H5E,&HE,&H8B,&H3F,&HC5
  $INLINE &H5E,&HA,&H8B,&HF,&HC5
  $INLINE &H56,&H6,&HB8,&H1C,&HEE
  $INLINE &HCD,&H10,&H1F,&H5D

END SUB

SUB AudioOff INLINE

  $INLINE &HB8,&H80,&HEE,&HBB,&HA
  $INLINE &H0,&HCD,&H10

END SUB

SUB ClearKey

  WHILE INKEY$ <> ""
  WEND

END SUB

SUB ClearScreen INLINE

  $INLINE &HB8,&H0,&HEE,&HCD,&H10

END SUB

SUB ColorOff INLINE

  $INLINE &HB8,&H1,&HEE,&HBB,&H0
  $INLINE &H0,&HCD,&H10

END SUB

SUB ColorOn INLINE

  $INLINE &HB8,&H1,&HEE,&HBB,&H1
  $INLINE &H0,&HCD,&H10

END SUB

SUB CurrentPoint INLINE

  $INLINE &H55,&H89,&HE5,&HB8,&HA
  $INLINE &HEE,&HCD,&H10,&HC4,&H7E
  $INLINE &HA,&H26,&H89,&H1D,&HC4
  $INLINE &H7E,&H6,&H26,&H89,&HD
  $INLINE &H5D

END SUB

SUB CursorOff INLINE

  $INLINE &HB8,&H17,&HEE,&HBB,&H0
  $INLINE &H0,&HCD,&H10

END SUB

SUB CursorOn INLINE

  $INLINE &HB8,&H17,&HEE,&HBB,&H1
  $INLINE &H0,&HCD,&H10

END SUB

SUB CursorStatus INLINE

  $INLINE &H55,&H89,&HE5,&HB8,&H18
  $INLINE &HEE,&HCD,&H10,&HC4,&H7E
  $INLINE &HA,&H26,&H89,&H1D,&HC4
  $INLINE &H7E,&H6,&H26,&H89,&HD
  $INLINE &H5D

END SUB

SUB DrawBox INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&HF,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&H16,&H8B,&H1F,&HB8
  $INLINE &HE,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB DrawBoxC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H37,&HC5
  $INLINE &H5E,&H6,&H8B,&H3F,&HC5
  $INLINE &H5E,&H12,&H8B,&H1F,&HB8
  $INLINE &H22,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB LowGraphics

  CALL GetSystem(0, Status%)
  IF Status% <> &HDEAD THEN
    SCREEN 0, 0, 0
    WIDTH 80
    PRINT "GRAFIX Driver Not Loaded"
    PRINT "Press Any Key To Continue . . ."
    CALL WaitKey
    END
  END IF
  SCREEN 0, 0, 0
  WIDTH 80
  CALL SetSystem(13)

END SUB

SUB MediumGraphics

  CALL GetSystem(0, Status%)
  IF Status% <> &HDEAD THEN
    SCREEN 0, 0, 0
    WIDTH 80
    PRINT "GRAFIX Driver Not Loaded!"
    PRINT "Press Any Key To Continue . . ."
    CALL WaitKey
    END
  END IF
  SCREEN 0, 0, 0
  WIDTH 80
  CALL SetSystem(2)

END SUB

SUB HighGraphics

  CALL GetSystem(0, Status%)
  IF Status% <> &HDEAD THEN
    SCREEN 0, 0, 0
    WIDTH 80
    PRINT "GRAFIX Driver Not Loaded!"
    PRINT "Press Any Key To Continue . . ."
    CALL WaitKey
    END
  END IF
  CALL GetSystem(12, Tandy11%)
  IF Tandy11% = Tandy11.False% THEN
    SCREEN 0, 0, 0
    WIDTH 80
    PRINT "TANDY11 Driver For The 640x200x16 Color Graphics Mode Not Loaded!"
    PRINT "Press Any Key To Continue . . ."
    CALL WaitKey
    END
  END IF
  SCREEN 0, 0, 0
  WIDTH 80
  CALL SetSystem(11)

END SUB

SUB ExitGraphics

  CALL SetSystem(3)
  SCREEN 0, 0, 0
  WIDTH 80

END SUB

SUB ExtCircle INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H1F,&HB8
  $INLINE &HF,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB ExtCircleC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&H37,&HC5
  $INLINE &H5E,&HE,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&HA,&H8B,&H1F,&HB8
  $INLINE &H21,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB ExtGet INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&HF,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H16,&H8B,&H1F,&HC5
  $INLINE &H56,&H6,&HB8,&H15,&HEE
  $INLINE &HCD,&H10,&H1F,&H5D

END SUB

SUB ExtLine INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H37,&HC5
  $INLINE &H5E,&H6,&H8B,&H3F,&HC5
  $INLINE &H5E,&H12,&H8B,&H1F,&HB8
  $INLINE &HB,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB ExtLineC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&HF,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&H16,&H8B,&H1F,&HB8
  $INLINE &H1E,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB ExtPaint INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&H37,&HC5
  $INLINE &H5E,&HE,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H1F,&HB8
  $INLINE &H10,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB ExtPut INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&H37,&HC5
  $INLINE &H5E,&HE,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H1F,&HC5
  $INLINE &H56,&HA,&HB8,&H16,&HEE
  $INLINE &HCD,&H10,&H1F,&H5D

END SUB

SUB ExtSound INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&H37,&HC5
  $INLINE &H5E,&HE,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H1F,&HB8
  $INLINE &H81,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB FillBox INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&HF,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&H16,&H8B,&H1F,&HB8
  $INLINE &H11,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB FillBoxC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H37,&HC5
  $INLINE &H5E,&H6,&H8B,&H3F,&HC5
  $INLINE &H5E,&H12,&H8B,&H1F,&HB8
  $INLINE &H23,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB GetAspect INLINE

  $INLINE &H55,&H89,&HE5,&HB8,&H5
  $INLINE &HEE,&HCD,&H10,&HC4,&H7E
  $INLINE &HA,&H26,&H89,&H1D,&HC4
  $INLINE &H7E,&H6,&H26,&H89,&HD
  $INLINE &H5D

END SUB

SUB GetBackColor INLINE

  $INLINE &H55,&H89,&HE5,&HB8,&H3
  $INLINE &HEE,&HBB,&H3,&H0,&HCD
  $INLINE &H10,&HC4,&H7E,&H6,&H26
  $INLINE &H89,&HD,&H5D

END SUB

SUB GetCursor INLINE

  $INLINE &H55,&H89,&HE5,&HB8,&H1A
  $INLINE &HEE,&HCD,&H10,&HC4,&H7E
  $INLINE &HA,&H26,&H89,&HD,&HC4
  $INLINE &H7E,&H6,&H26,&H89,&H1D
  $INLINE &H5D

END SUB

SUB GetInput (Prompt$, GS$)

  CALL CursorStatus(SaveCursor%, SaveSize%)
  CALL CursorOn
  CALL NormalCursor
  CALL PrintStringX(Prompt$)
  CALL GetCursor(R%, StartCol%)
  CALL GetSystem(12, Tandy11%)
  IF Tandy11% = Tandy11.True% THEN
    Maximum% = 80 - StartCol% + 1
  ELSE
    Maximum% = 40 - StartCol% + 1
  END IF
  P% = 1
  Inserts% = 0
  Temp$ = SPACE$(Maximum%)
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
        CASE 8  'Back Space
          P% = P% - 1
          IF P% < 1 THEN P% = 1
          Temp$ = LEFT$(Temp$, P% - 1) + RIGHT$(Temp$, LEN(Temp$) - P%) + " "
          WhatToDo% = 2
        CASE 13  'Enter
          EXIT LOOP
        CASE 27  'Escape
          Temp$ = SPACE$(Maximum%)
          P% = 1
          WhatToDo% = 2
        CASE 32 TO 126  'ASC 32 - 126
          IF Inserts% = 0 THEN
            MID$(Temp$, P%, 1) = K$
            WhatToDo% = 1
            P% = P% + 1
            IF P% > Maximum% THEN
              P% = 1
              WhatToDo% = 2
            END IF
          END IF
          IF Inserts% = 1 THEN
            Temp$ = LEFT$(Temp$, P% - 1) + K$ + MID$(Temp$, P%, LEN(Temp$) - P%)
            P% = P% + 1
            IF P% > Maximum% THEN P% = 1
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
          IF P% > Maximum% THEN P% = Maximum%
        CASE 79  'End
          FOR X% = Maximum% TO 1 STEP -1
            IF MID$(Temp$, X%, 1) <> " " THEN EXIT FOR
          NEXT X%
          P% = X% + 1
          IF P% = Maximum% + 1 THEN P% = Maximum%
        CASE 82  'Insert
          IF Inserts% = 0 THEN
            Inserts% = 1
            CALL HalfCursor
          ELSE
            Inserts% = 0
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
  FOR X% = Maximum% TO 1 STEP -1
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

SUB GetPlotColor INLINE

  $INLINE &H55,&H89,&HE5,&HB8,&H3
  $INLINE &HEE,&HBB,&H1,&H0,&HCD
  $INLINE &H10,&HC4,&H7E,&H6,&H26
  $INLINE &H89,&HD,&H5D

END SUB

SUB GetSystem INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H7E
  $INLINE &HA,&H26,&H8B,&H1D,&HB8
  $INLINE &H80,&HEE,&HCD,&H10,&HC4
  $INLINE &H7E,&H6,&H26,&H89,&H5
  $INLINE &H5D

END SUB

SUB GetTextColor INLINE

  $INLINE &H55,&H89,&HE5,&HB8,&H3
  $INLINE &HEE,&HBB,&H2,&H0,&HCD
  $INLINE &H10,&HC4,&H7E,&H6,&H26
  $INLINE &H89,&HD,&H5D

END SUB

SUB GraphStatus INLINE

  $INLINE &H55,&H89,&HE5,&HB8,&H80
  $INLINE &HEE,&HBB,&H1,&H0,&HCD
  $INLINE &H10,&HC4,&H7E,&H6,&H26
  $INLINE &H89,&H5,&H5D

END SUB

SUB HalfCursor INLINE

  $INLINE &HB8,&H17,&HEE,&HBB,&H3
  $INLINE &H0,&HCD,&H10

END SUB

SUB LineRel INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &HA,&H26,&H8B,&H37,&HC4
  $INLINE &H5E,&H6,&H26,&H8B,&H3F
  $INLINE &HB8,&HD,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB LineRelC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HB8
  $INLINE &H20,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB LineTo INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &HA,&H26,&H8B,&H37,&HC4
  $INLINE &H5E,&H6,&H26,&H8B,&H3F
  $INLINE &HB8,&HC,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB LineToC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HB8
  $INLINE &H1F,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB MoveRel INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &HA,&H26,&H8B,&H37,&HC4
  $INLINE &H5E,&H6,&H26,&H8B,&H3F
  $INLINE &HB8,&H9,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB MoveTo INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &HA,&H26,&H8B,&H37,&HC4
  $INLINE &H5E,&H6,&H26,&H8B,&H3F
  $INLINE &HB8,&H8,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB Noise INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HA,&H8B,&HF,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&HE,&H8B,&H1F,&HB8
  $INLINE &H82,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB NoiseBufOff INLINE

  $INLINE &HB8,&H80,&HEE,&HBB,&H9
  $INLINE &H0,&HCD,&H10

END SUB

SUB NoiseBufOn INLINE

  $INLINE &HB8,&H80,&HEE,&HBB,&H8
  $INLINE &H0,&HCD,&H10

END SUB

SUB NoiseOff INLINE

$INLINE &HB8,&H80,&HEE,&HBB,&H7
$INLINE &H0,&HCD,&H10

END SUB

SUB NormalCursor INLINE

  $INLINE &HB8,&H17,&HEE,&HBB,&H2
  $INLINE &H0,&HCD,&H10

END SUB

SUB PaletteUsing INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H56,&H6,&HB8,&H13,&HEE
  $INLINE &HCD,&H10,&H1F,&H5D

END SUB

SUB Pause INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H7E
  $INLINE &H6,&H26,&H8B,&H1D,&HB8
  $INLINE &H83,&HEE,&HCD,&H10,&H5D

END SUB

SUB PlotPoint INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &HA,&H26,&H8B,&H37,&HC4
  $INLINE &H5E,&H6,&H26,&H8B,&H3F
  $INLINE &HB8,&H6,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB PlotPointC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HB8
  $INLINE &H1D,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB PointColor INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HB8
  $INLINE &H7,&HEE,&HCD,&H10,&HC5
  $INLINE &H5E,&H6,&H89,&H7,&H1F
  $INLINE &H5D

END SUB

SUB PrintString INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HA1
  $INLINE &H0,&H0,&HC5,&H7E,&H6
  $INLINE &H8B,&HD,&H81,&HE1,&HFF
  $INLINE &H7F,&H8B,&H55,&H2,&HBB
  $INLINE &H1,&H0,&H8E,&HD8,&HB8
  $INLINE &H1B,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB PrintStringX INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HA1
  $INLINE &H0,&H0,&HC5,&H7E,&H6
  $INLINE &H8B,&HD,&H81,&HE1,&HFF
  $INLINE &H7F,&H8B,&H55,&H2,&HBB
  $INLINE &H0,&H0,&H8E,&HD8,&HB8
  $INLINE &H1B,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB


SUB ResetPalette INLINE

  $INLINE &HB8,&H14,&HEE,&HCD,&H10

END SUB

SUB SetAspect INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H7E
  $INLINE &HA,&H26,&H8B,&H1D,&HC4
  $INLINE &H7E,&H6,&H26,&H8B,&HD
  $INLINE &HB8,&H4,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB SetBackColor INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H7E
  $INLINE &H6,&H26,&H8B,&HD,&HBB
  $INLINE &H3,&H0,&HB8,&H2,&HEE
  $INLINE &HCD,&H10,&H5D

END SUB

SUB SetCursor INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H7E
  $INLINE &HA,&H26,&H8B,&HD,&HC4
  $INLINE &H7E,&H6,&H26,&H8B,&H1D
  $INLINE &HB8,&H19,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB SetPalette INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H7E
  $INLINE &HA,&H26,&H8B,&H1D,&HC4
  $INLINE &H7E,&H6,&H26,&H8B,&HD
  $INLINE &HB8,&H12,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB SetPlotColor INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H7E
  $INLINE &H6,&H26,&H8B,&HD,&HBB
  $INLINE &H1,&H0,&HB8,&H2,&HEE
  $INLINE &HCD,&H10,&H5D

END SUB

SUB SetSystem INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H7E
  $INLINE &H6,&H26,&H8B,&H1D,&HB8
  $INLINE &H80,&HEE,&HCD,&H10,&H5D

END SUB

SUB SetTextColor INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H7E
  $INLINE &H6,&H26,&H8B,&HD,&HBB
  $INLINE &H2,&H0,&HB8,&H2,&HEE
  $INLINE &HCD,&H10,&H5D

END SUB

SUB SoundBufOff INLINE

  $INLINE &HB8,&H80,&HEE,&HBB,&H6
  $INLINE &H0,&HCD,&H10

END SUB

SUB SoundBufOn INLINE

  $INLINE &HB8,&H80,&HEE,&HBB,&H5
  $INLINE &H0,&HCD,&H10

END SUB

SUB SoundOff INLINE

  $INLINE &HB8,&H80,&HEE,&HBB,&H4
  $INLINE &H0,&HCD,&H10

END SUB

SUB SpeakerOff INLINE

  $INLINE &HB8,&H2,&H80,&HCD,&H1A

END SUB

SUB SpeakerOn INLINE

  $INLINE &HB0,&H9F,&HE6,&HC0,&HB0
  $INLINE &HBF,&HE6,&HC0,&HB0,&HDF
  $INLINE &HE6,&HC0,&HB8,&H3,&H80
  $INLINE &HCD,&H1A

END SUB

SUB WaitKey

  CALL ClearKey
  WHILE INKEY$ = ""
  WEND

END SUB

SUB XorPoint INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &HA,&H26,&H8B,&H37,&HC4
  $INLINE &H5E,&H6,&H26,&H8B,&H3F
  $INLINE &HB8,&H24,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB XorPointC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HB8
  $INLINE &H25,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorLine INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H37,&HC5
  $INLINE &H5E,&H6,&H8B,&H3F,&HC5
  $INLINE &H5E,&H12,&H8B,&H1F,&HB8
  $INLINE &H26,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorLineC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&HF,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&H16,&H8B,&H1F,&HB8
  $INLINE &H27,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorLineTo INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &HA,&H26,&H8B,&H37,&HC4
  $INLINE &H5E,&H6,&H26,&H8B,&H3F
  $INLINE &HB8,&H28,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB XorLineToC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HB8
  $INLINE &H29,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorLineRel INLINE

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &HA,&H26,&H8B,&H37,&HC4
  $INLINE &H5E,&H6,&H26,&H8B,&H3F
  $INLINE &HB8,&H2A,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB XorLineRelC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HB8
  $INLINE &H2B,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorDrawBox INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&HF,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&H16,&H8B,&H1F,&HB8
  $INLINE &H2C,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorDrawBoxC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H37,&HC5
  $INLINE &H5E,&H6,&H8B,&H3F,&HC5
  $INLINE &H5E,&H12,&H8B,&H1F,&HB8
  $INLINE &H2D,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorFillBox INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&HF,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&H16,&H8B,&H1F,&HB8
  $INLINE &H2E,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorFillBoxC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H37,&HC5
  $INLINE &H5E,&H6,&H8B,&H3F,&HC5
  $INLINE &H5E,&H12,&H8B,&H1F,&HB8
  $INLINE &H2F,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorCircle INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&H37,&HC5
  $INLINE &H5E,&HA,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H1F,&HB8
  $INLINE &H30,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorCircleC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&H37,&HC5
  $INLINE &H5E,&HE,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&HA,&H8B,&H1F,&HB8
  $INLINE &H31,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB Ellipse INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&H37,&HC5
  $INLINE &H5E,&HE,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H1F,&HB8
  $INLINE &H32,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB EllipseC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H16,&H8B,&H37,&HC5
  $INLINE &H5E,&H12,&H8B,&H3F,&HC5
  $INLINE &H5E,&HA,&H8B,&HF,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&HE,&H8B,&H1F,&HB8
  $INLINE &H33,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorEllipse INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H12,&H8B,&H37,&HC5
  $INLINE &H5E,&HE,&H8B,&H3F,&HC5
  $INLINE &H5E,&H6,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H1F,&HB8
  $INLINE &H34,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB XorEllipseC INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&H16,&H8B,&H37,&HC5
  $INLINE &H5E,&H12,&H8B,&H3F,&HC5
  $INLINE &H5E,&HA,&H8B,&HF,&HC5
  $INLINE &H5E,&H6,&H8B,&H17,&HC5
  $INLINE &H5E,&HE,&H8B,&H1F,&HB8
  $INLINE &H35,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB SetView INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H5E,&HE,&H8B,&HF,&HC5
  $INLINE &H5E,&HA,&H8B,&H37,&HC5
  $INLINE &H5E,&H6,&H8B,&H3F,&HC5
  $INLINE &H5E,&H12,&H8B,&H1F,&HB8
  $INLINE &H36,&HEE,&HCD,&H10,&H1F
  $INLINE &H5D

END SUB

SUB GetView INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HB8
  $INLINE &H37,&HEE,&HCD,&H10,&H89
  $INLINE &HD8,&HC5,&H5E,&H12,&H89
  $INLINE &H7,&HC5,&H5E,&HE,&H89
  $INLINE &HF,&HC5,&H5E,&HA,&H89
  $INLINE &H37,&HC5,&H5E,&H6,&H89
  $INLINE &H3F,&H1F,&H5D

END SUB

SUB ResetView INLINE

$INLINE &HB8,&H38,&HEE,&HCD,&H10

END SUB

SUB GetTandy11 INLINE

  $INLINE &H55,&H89,&HE5,&HB8,&H80
  $INLINE &HEE,&HBB,&HC,&H0,&HCD
  $INLINE &H10,&HC4,&H5E,&H6,&H26
  $INLINE &H89,&H7,&H5D

END SUB

SUB GetScreen INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H56,&H6,&HB8,&H39,&HEE
  $INLINE &HCD,&H10,&H1F,&H5D

END SUB

SUB PutScreen INLINE

  $INLINE &H55,&H89,&HE5,&H1E,&HC5
  $INLINE &H56,&H6,&HB8,&H3A,&HEE
  $INLINE &HCD,&H10,&H1F,&H5D

END SUB

SUB SetActivePage INLINE PUBLIC

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &H6,&H26,&H8B,&H1F,&HB8
  $INLINE &H3D,&HEE,&HCD,&H10,&H5D

END SUB

SUB SetDisplayPage INLINE PUBLIC

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &H6,&H26,&H8B,&H1F,&HB8
  $INLINE &H3B,&HEE,&HCD,&H10,&H5D

END SUB

SUB GetActivePage INLINE PUBLIC

  $INLINE &H55,&H89,&HE5,&HB8,&H3E
  $INLINE &HEE,&HCD,&H10,&HC4,&H7E
  $INLINE &H6,&H26,&H89,&H1D,&H5D

END SUB

SUB GetDisplayPage INLINE PUBLIC

  $INLINE &H55,&H89,&HE5,&HB8,&H3C
  $INLINE &HEE,&HCD,&H10,&HC4,&H7E
  $INLINE &H6,&H26,&H89,&H1D,&H5D

END SUB

SUB PageCopy INLINE PUBLIC

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &HA,&H26,&H8B,&H37,&HC4
  $INLINE &H5E,&H6,&H26,&H8B,&H3F
  $INLINE &HB8,&H3F,&HEE,&HCD,&H10
  $INLINE &H5D

END SUB

SUB FastTimer INLINE PUBLIC

  $INLINE &H55,&H89,&HE5,&HC4,&H5E
  $INLINE &H6,&H26,&H8B,&H1F,&HB8
  $INLINE &H84,&HEE,&HCD,&H10,&H5D

END SUB

SUB ResetTimer INLINE PUBLIC

  $INLINE &HB8,&H85,&HEE,&HCD,&H10

END SUB

SUB GetTimer INLINE PUBLIC

  $INLINE &H55,&H89,&HE5,&HB8,&H86
  $INLINE &HEE,&HCD,&H10,&HC4,&H7E
  $INLINE &H6,&H26,&H89,&H1D,&H5D

END SUB
