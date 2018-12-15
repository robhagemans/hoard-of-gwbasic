 '******************************************************************************
 '* PUT-1 - 'Put' function demo.                                               *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press F10 to toggle between 320 and 640 graphic modes                      *
 '* Press ESC to exit program                                                  *
 '******************************************************************************
 '$INCLUDE: 'GRAFQBS.INC' 
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 DIM Box(138), C$(15), M$(5)

 FOR N = 0 TO 15
   READ C$(N)
 NEXT N
 FOR N = 1 TO 5
   READ M$(N)
 NEXT N

 Graphics = 320
 BoxStep = 48
 BoxWidth = 31
 CALL GetTandy11(Tandy11%)
 CALL MediumGraphics

Again:
 CALL ClearScreen
 CALL SetTextColor(Yellow)
 GOSUB DrawBoxes
 CALL SetTextColor(Brown)
 CALL SetCursor(5, 5)
 CALL PrintString("ACTION:")
 FOR N = 1 TO 5
   GOSUB PrintNames
 NEXT N
 CALL SetTextColor(LightCyan)
 CALL PrintString(" ")
 CALL PrintString(" Enter number " + CHR$(24))
 CALL PrintString(" ")
 CALL PrintString("       or")
 CALL PrintString(" ")
 CALL PrintString(" press <Return>")
 CALL PrintString(" ")
 CALL PrintStringX(" for next color")

MainLoop:
 CALL SetTextColor(Yellow)
 CALL SetCursor(2, 1)
 CALL PrintStringX(SPACE$(16))
 CALL SetCursor(2, 2)
 CALL PrintStringX("Color (0-F) ")
 C = -1
 CALL ClearKey
 WHILE C < 0 OR C > 15
   A$ = INKEY$
   A$ = RIGHT$(A$, 1)
   IF A$ = CHR$(68) THEN GOSUB SwitchGraphics
   A$ = UCASE$(A$)
   SELECT CASE A$
     CASE "A" TO "F"
       C = ASC(A$) - 55
     CASE "0" TO "9"
       C = ASC(A$) - 48
     CASE CHR$(27)
       GOTO EndProgram
     CASE ELSE
       C = -1
   END SELECT
 WEND
 CALL SetCursor(2, 1)
 CALL PrintStringX(SPACE$(16))
 GOSUB DrawBoxes
 IF Graphics = 320 THEN
   CALL FillBox(0, 0, 15, 15, C)
   CALL ExtGet(0, 0, 15, 15, Box(0))
   CALL ExtPut(0, 0, Box(0), PutXor)
 ELSE
   CALL FillBox(0, 0, 30, 15, C)
   CALL ExtGet(0, 0, 30, 15, Box(0))
   CALL ExtPut(0, 0, Box(0), PutXor)
 END IF
 IF C = 0 THEN
   CALL SetTextColor(DarkGray)
 ELSE
   CALL SetTextColor(C)
 END IF
 CALL SetCursor(2, (8 - LEN(C$(C)) \ 2))
 CALL PrintStringX(C$(C))
 CALL ClearKey

 N = 0
 DO UNTIL N >= 1 AND N <= 5
   A$ = ""
   WHILE A$ = ""
     A$ = INKEY$
   WEND
   A$ = RIGHT$(A$, 1)
   N = VAL(A$)
   IF A$ = CHR$(13) THEN GOTO NextAction
   IF A$ = CHR$(27) THEN GOTO EndProgram
   IF A$ = CHR$(68) THEN GOSUB SwitchGraphics
 LOOP

NextAction:
 IF A$ = CHR$(13) THEN
   CALL SetCursor(2, 3)
   CALL PrintStringX(SPACE$(10))
   GOTO MainLoop
 END IF
 CALL SetTextColor(Yellow)
 FOR B = 1 TO 3
   CALL SetCursor(N * 2 + 6, 2)
   CALL PrintStringX(SPACE$(14))
   CALL Pause(8)
   GOSUB PrintNames
   CALL Pause(8)
 NEXT B
 IF Graphics = 320 THEN X1 = 145 ELSE X1 = 188
 X = X1
 Y = 20
 K = 0
 FOR I = 1 TO 4
   FOR J = 1 TO 4
     ON N GOSUB ShowPreset, ShowPset, ShowAnd, ShowOr, ShowXor
      X = X + BoxStep
      K = K + 1
   NEXT J
     X = X1
     Y = Y + 48
 NEXT I
 M = 0
 DO UNTIL M >= 1 AND M <= 5
   A$ = ""
   WHILE A$ = ""
     A$ = INKEY$
   WEND
   A$ = RIGHT$(A$, 1)
   M = VAL(A$)
   IF A$ = CHR$(13) THEN GOTO NextAction1
   IF A$ = CHR$(27) THEN GOTO EndProgram
   IF A$ = CHR$(68) THEN GOSUB SwitchGraphics
 LOOP

NextAction1:
 CALL SetTextColor(Brown)
 GOSUB PrintNames
 GOSUB DrawBoxes
 N = M
 GOTO NextAction

ShowPreset:
 CALL ExtPut(X, Y, Box(0), PutPreset)
 RETURN

ShowPset:
 CALL ExtPut(X, Y, Box(0), PutPset)
 RETURN

ShowAnd:
 CALL ExtPut(X, Y, Box(0), PutAnd)
 RETURN

ShowOr:
 CALL ExtPut(X, Y, Box(0), PutOr)
 RETURN

ShowXor:
 CALL ExtPut(X, Y, Box(0), PutXor)
 RETURN

PrintNames:
 CALL SetCursor(N * 2 + 6, 2)
 CALL PrintStringX(M$(N))
 FOR P = 1 TO 12 - LEN(M$(N))
   CALL PrintStringX(".")
 NEXT P
 CALL PrintString(STR$(N))
 RETURN

DrawBoxes:
 IF Graphics = 320 THEN
   CALL FillBox(129, 4, 319, 195, Black)
   CALL DrawBox(129, 4, 319, 195, Red)
 ELSE
   CALL FillBox(129, 4, 639, 195, Black)
   CALL DrawBox(129, 4, 639, 195, Red)
 END IF
 CALL SetPlotColor(Red)
 CALL ExtLine(4, 24, 124, 24)
 IF Graphics = 320 THEN X1 = 137 ELSE X1 = 172
 X = X1
 Y = 12
 K = 0
 FOR I = 1 TO 4
   FOR J = 1 TO 4
     CALL FillBox(X, Y, X + BoxWidth, Y + 31, K)
     IF K = 0 THEN CALL DrawBox(X, Y, X + BoxWidth, Y + 31, DarkGray)
     X = X + BoxStep
     K = K + 1
   NEXT J
   X = X1
   Y = Y + 48
 NEXT I
 RETURN

SwitchGraphics:
  IF Tandy11% = Tandy11.False% THEN RETURN
  IF Graphics = 320 THEN
    Graphics = 640
    BoxStep = 120
    BoxWidth = 62
    CALL HighGraphics
    RETURN Again
  ELSE
    Graphics = 320
    BoxStep = 48
    BoxWidth = 31
    CALL MediumGraphics
    RETURN Again
  END IF

EndProgram:
 CALL ExitGraphics
 END

 DATA BLACK,BLUE,GREEN,CYAN,RED,MAGENTA,BROWN,LT GREY,GREY
 DATA LT BLUE,LT GREEN,LT CYAN,LT RED,LT MAGENTA,YELLOW,WHITE
 DATA PRESET,PSET,AND,OR,XOR
