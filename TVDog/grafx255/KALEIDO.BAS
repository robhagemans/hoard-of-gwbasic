 '******************************************************************************
 '* KALEIDO - Kaleioscope line drawing demo.                                   *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press F1 to pause program                                                  *
 '* Press F2 to clear the screen                                               *
 '* Press F10 to toggle between 320 and 640 graphic modes                      *
 '* Press ESC to exit program                                                  *
 '* ****************************************************************************
 '$INCLUDE: 'GRAFQBS.INC'
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 DEF FNRND (Maximum) = INT(RND * Maximum) + 1

 Graphics = 320
 MX = 160
 MY = 100
 M = 100
 MaxDelta = 7
 MaxColor = 15
 CALL GetTandy11(Tandy11%)
 CALL MediumGraphics

Again:
 DO
   RANDOMIZE TIMER
   CALL ClearScreen
   X1 = FNRND(M) + 1
   X2 = FNRND(M) + 1
   Y1 = FNRND(X1)
   Y2 = FNRND(X2)
   DO
     LC = FNRND(MaxColor) 'Ensure good color separation
     LC = FNRND(MaxColor)
     CALL SetPlotColor(LC)
     XV1 = FNRND(11) - 5
     XV2 = FNRND(11) - 5
     YV1 = FNRND(11) - 5
     YV2 = FNRND(11) - 5
     DO WHILE (FNRND(10) > 1)
       XA = (X1 * 9) \ MaxDelta
       XB = (X2 * 9) \ MaxDelta
       YA = (Y1 * 9) \ MaxDelta
       YB = (Y2 * 9) \ MaxDelta
       CALL ExtLine(MX + XB, MY - Y2, MX + XA, MY - Y1)
       CALL ExtLine(MX - YB, MY + X2, MX - YA, MY + X1)
       CALL ExtLine(MX - XB, MY - Y2, MX - XA, MY - Y1)
       CALL ExtLine(MX - YB, MY - X2, MX - YA, MY - X1)
       CALL ExtLine(MX - XB, MY + Y2, MX - XA, MY + Y1)
       CALL ExtLine(MX + YB, MY - X2, MX + YA, MY - X1)
       CALL ExtLine(MX + XB, MY + Y2, MX + XA, MY + Y1)
       CALL ExtLine(MX + YB, MY + X2, MX + YA, MY + X1)
       X1 = ABS((X1 + XV1) MOD M)
       Y1 = ABS((Y1 + YV1) MOD M)
       X2 = ABS((X2 + XV2) MOD M)
       Y2 = ABS((Y2 + YV2) MOD M)
     LOOP
     K$ = INKEY$
     K$ = RIGHT$(K$, 1)
     IF K$ = CHR$(27) THEN
       CALL ExitGraphics
       END
     END IF
     IF K$ = CHR$(59) THEN CALL WaitKey
     IF K$ = CHR$(60) THEN GOTO Again
     IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
       IF Graphics = 320 THEN
	 Graphics = 640
	 MX = 320
	 MaxDelta = 4
	 CALL HighGraphics
	 GOTO Again
       ELSE
	 Graphics = 320
	 MX = 160
	 MaxDelta = 7
	 CALL MediumGraphics
	 GOTO Again
       END IF
     END IF
   LOOP
 LOOP

