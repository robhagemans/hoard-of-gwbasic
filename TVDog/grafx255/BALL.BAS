 '******************************************************************************
 '* BALL - Bouncing ball animation demo using XOR option.                      *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press ESC to exit program                                                  *
 '* Press F3 to toggle sound on/off                                            *
 '* Press F5 to toggle clipping mode                                           *
 '* Press F10 to toggle between 320 and 640 graphics modes                     *
 '******************************************************************************
 '$INCLUDE: 'GRAFQBS.INC' 
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 DIM Ball(115), B(280), Notes(84)
 Graphics = 320
 XOffset = 0
 Clip = 0
 DoSound = 1
 CALL GetTandy11(Tandy11%)
 CALL AudioOff
 CALL MediumGraphics

 FOR I = 1 TO 84
   READ Notes(I)
 NEXT
 FOR X = 20 TO 280 STEP 4
   B(X) = 159 - CINT(ABS(SIN(X * .07853981#) * X) \ 2)
 NEXT X

Again:
 CALL ResetView
 CALL ClearScreen
 CALL SetBackColor(LightGray)
 CALL ExtCircleC(160, 100, 10, DarkGray)
 CALL ExtPaint(160, 100, DarkGray, DarkGray)
 CALL ExtGet(150, 90, 170, 110, Ball(0))
 CALL ClearScreen
 CALL DrawBox(18 + XOffset, 0, 302 + XOffset, 179, Red)
 CALL DrawBox(19 + XOffset, 1, 301 + XOffset, 178, Red)
 IF Clip = 1 THEN
   CALL DrawBox(79 + XOffset, 74, 241 + XOffset, 151, Blue)
   CALL DrawBox(78 + XOffset, 73, 242 + XOffset, 152, Blue)
   CALL SetView(80 + XOffset, 75, 240 + XOffset, 150)
 END IF
 CALL FillBox(160 + XOffset, 2, 190 + XOffset, 177, LightBlue)
 CALL FillBox(191 + XOffset, 2, 222 + XOffset, 177, LightRed)
 CALL FillBox(223 + XOffset, 2, 253 + XOffset, 177, Yellow)

 L = 6
 X2 = 20
 Y2 = 150
 CALL ExtPut(X2 + XOffset, Y2, Ball(0), PutXor)

 DO
  FOR D = 0 TO 1
    S = 20 + D * 260
    E = 280 - D * 260
    FOR X = S TO E STEP 4 - 8 * D
      Y = B(X)
      N = (210 - Y2) \ 5
      CALL ExtPut(X2 + XOffset, Y2, Ball(0), PutXor%)
      CALL ExtPut(X + XOffset, Y, Ball(0), PutXor%)
      A = 21 / L * .875
      IF DoSound = 1 THEN
	CALL ExtSound(Notes(N), A, 10, 0)
      ELSE
	CALL Pause(A)
      END IF
      X2 = X
      Y2 = Y
      K$ = INKEY$
      K$ = RIGHT$(K$, 1)
      IF K$ = CHR$(27) THEN
	CALL ExitGraphics
	END
      END IF
      IF K$ = CHR$(61) THEN
	IF DoSound = 0 THEN
	  DoSound = 1
	ELSE
	  DoSound = 0
	END IF
      END IF
      IF K$ = CHR$(63) THEN
	IF Clip = 1 THEN
	  Clip = 0
	ELSE
	  Clip = 1
	END IF
	GOTO Again
      END IF
      IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
	IF Graphics = 320 THEN
	  Graphics = 640
	  XOffset = 160
	  CALL HighGraphics
	  GOTO Again
	ELSE
	  Graphics = 320
	  XOffset = 0
	  CALL MediumGraphics
	  GOTO Again
	END IF
      END IF
    NEXT X
    L = L + 3
    IF L > 21 THEN L = 6
  NEXT D
 LOOP

 DATA 65,69,73,78,82,87,93,98,104,110,116,123,131,139,147,156,165,175,185,196
 DATA 208,220,233,247,262,277,294,311,330,349,370,392,415,440,466,494,523,554
 DATA 587,622,659,698,740,784,831,880,932,988,1047,1109,1175,1245,1319,1397
 DATA 1480,1568,1661,1760,1865,1976,2091,2217,2349,2489,2637,2794,2960,3136
 DATA 3322,3520,3729,3951,4186,4435,4699,4978,5274,5587,5919,6271,6645,7040
 DATA 7459,7902

