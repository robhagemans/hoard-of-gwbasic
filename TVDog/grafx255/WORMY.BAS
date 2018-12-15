 '******************************************************************************
 '* WORMY - Circle drawing demo.                                               *
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

 Graphics = 320
 CALL GetTandy11(Tandy11%)
 CALL MediumGraphics

AGAIN:
 CALL ClearScreen
 IF Graphics = 320 THEN
   CALL SetCursor(1, 18)
 ELSE
   CALL SetCursor(1, 38)
 END IF
 CALL PrintString("WORMY")
 C# = 0
 FOR X# = .1 TO 1.1 STEP .002
   GOSUB CheckKey
   C# = C# + .1
   IF Graphics = 320 THEN
     X% = X# * 200
     Y% = SIN(X# * 24) * (X# * 50) + 100
     Radius% = X# * 40
     C% = C#
     CALL ExtCircleC(X%, Y%, Radius%, C%)
   ELSE
     X% = X# * 400
     Y% = SIN(X# * 24) * (X# * 50) + 100
     Radius% = X# * 75
     C% = C#
     CALL ExtCircleC(X%, Y%, Radius%, C%)
   END IF
   IF C# > 15 THEN C# = 0
 NEXT X#
 X# = TIMER + 10
 A$ = ""
 WHILE (TIMER < X#) AND (A$ = "")
   A$ = INKEY$
 WEND
 IF A$ = CHR$(27) GOTO EndProgram
 GOTO AGAIN

CheckKey:
 K$ = INKEY$
 K$ = RIGHT$(K$, 1)
 IF K$ = CHR$(27) THEN GOTO EndProgram
 IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
   IF Graphics = 320 THEN
     Graphics = 640
     CALL HighGraphics
     RETURN AGAIN
   ELSE
     Graphics = 320
     CALL MediumGraphics
     RETURN AGAIN
   END IF
 END IF
 RETURN

EndProgram:
 CALL ExitGraphics
 END

