 '*****************************************************************************
 '* P-DEMO2 - Palette demo.                                                   *
 '*                                                                           *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                *
 '*                                                                           *
 '* Press F10 to toggle between 320 and 640 graphic modes                     *
 '* Press ESC to exit program                                                 *
 '*****************************************************************************
 '$INCLUDE: 'GRAFQBS.INC' 
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 DIM H0(15), H1(15), H2(15), H3(15), H4(15), H5(15), H6(15), H7(15), H8(15), H9(15)
 DIM H10(15), H11(15), H12(15), Image%(16006)

 FOR N = 0 TO 7
   READ H0(N)
 NEXT N
 FOR N = 0 TO 7
   READ H1(N)
 NEXT N
 FOR N = 0 TO 7
   READ H2(N)
 NEXT N
 FOR N = 0 TO 7
   READ H3(N)
 NEXT N
 FOR N = 0 TO 7
   READ H4(N)
 NEXT N
 FOR N = 0 TO 7
   READ H5(N)
 NEXT N
 FOR N = 0 TO 7
   READ H6(N)
 NEXT N
 FOR N = 0 TO 7
   READ H7(N)
 NEXT N
 FOR N = 0 TO 15
   READ H8(N)
 NEXT N
 FOR N = 0 TO 15
   READ H9(N)
 NEXT N
 FOR N = 0 TO 15
   READ H10(N)
 NEXT N
 FOR N = 0 TO 15
   READ H11(N)
 NEXT N
 FOR N = 0 TO 15
   READ H12(N)
 NEXT N

 Graphics = 320
 C1(1) = Green
 C1(2) = Cyan
 C2(1) = Blue
 C2(2) = Cyan
 C2(3) = Yellow
 DEF SEG = VARSEG(Image%(0))
 BLOAD "P-DEMO2.BIN", VARPTR(Image%(0))
 DEF SEG
 CALL GetTandy11(Tandy11%)
 CALL AudioOff
 CALL MediumGraphics

Again:
 RANDOMIZE TIMER
 CALL PaletteUsing(H0(0))
 CALL ExtPut(0, 0, Image%(0), PutXor%)
 IF Graphics = 640 THEN CALL ExtPut(320, 0, Image%(0), PutXor%)

MainLoop:
 S1 = 120
 FOR N = 1 TO 7
   GOSUB LightCoils1
   GOSUB MakeSound
   GOSUB LightCoils2
   GOSUB MakeSound
 NEXT N
 FOR N = 1 TO 7
   GOSUB LightPosts
   GOSUB LightCoils1
   GOSUB LightCoils2
   GOSUB MakeSound
 NEXT N
 FOR N = 1 TO 4
   GOSUB LightGlobes
 NEXT N
 FOR N = 1 TO 5
   GOSUB LightArcs
   GOSUB MakeSound
 NEXT N
 RANDOMIZE TIMER
 TIMES = 0
 NO.TIMES = INT(RND * 7 + 1)
 WHILE TIMES < NO.TIMES
   L = 6
   GOSUB LightEmAll
   TIMES = TIMES + 1
 WEND
 GOTO MainLoop

MakeSound:
 CALL ExtSound(S1, 10, 7, 0)
 CALL ExtSound(S1 + 5, 10, 7, 1)
 CALL ExtSound(S1 + 10, 10, 7, 2)
 S1 = S1 + 5
 GOSUB CheckKey
 RETURN

LightCoils1:
 CALL PaletteUsing(H2(0))
 CALL Pause(3)
 GOSUB CheckKey
 RETURN

LightCoils2:
 CALL PaletteUsing(H3(0))
 CALL Pause(3)
 GOSUB CheckKey
 RETURN

LightPosts:
 CALL SetPalette(Green, Brown)
 CALL SetPalette(Cyan, Yellow)
 J = 1
 FOR T = 1 TO 2
   FOR Y = 193 TO 58 STEP -14
     FOR X = 42 TO 278 STEP 236
       CALL ExtPaint(X, Y, C1(J), Blue)
       IF Graphics = 640 THEN CALL ExtPaint(X + 320, Y, C1(J), Blue)
     NEXT X
   NEXT Y
   GOSUB MakeSound
   CALL SetPlotColor(C1(J))
   CALL ExtLine(68, 42, 72, 42)
   CALL ExtLine(250, 42, 253, 42)
   IF Graphics = 640 THEN
     CALL ExtLine(388, 42, 392, 42)
     CALL ExtLine(570, 42, 573, 42)
   END IF
   J = J MOD 2 + 1
 NEXT T
 GOSUB CheckKey
 RETURN

LightGlobes:
 CALL PaletteUsing(H4(0))
 CALL Pause(3)
 CALL PaletteUsing(H5(0))
 CALL Pause(3)
 GOSUB MakeSound
 CALL PaletteUsing(H6(0))
 CALL Pause(3)
 CALL PaletteUsing(H7(0))
 CALL Pause(3)
 GOSUB MakeSound
 GOSUB CheckKey
 RETURN

LightArcs:
 GOSUB MakeNoise
 CALL PaletteUsing(H4(0))
 GOSUB GetZ
 CALL SetPalette(DarkGray, C2(Z))
 CALL PaletteUsing(H5(0))
 GOSUB GetZ
 CALL SetPalette(LightBlue, C2(Z))
 CALL PaletteUsing(H6(0))
 GOSUB GetZ
 CALL SetPalette(LightGreen, C2(Z))
 CALL PaletteUsing(H7(0))
 GOSUB GetZ
 CALL SetPalette(LightBlue, C2(Z))
 GOSUB CheckKey
 RETURN

GetZ:
 Z = INT(RND * 3) + 1
 CALL Pause(2)
 GOSUB CheckKey
 RETURN

MakeNoise:
 CALL Noise(5, 8, 12)
 GOSUB CheckKey
 RETURN

LightEmAll:
 FOR T = 1 TO 5
   CALL Noise(5, L, 18)
   CALL PaletteUsing(H8(0))
   CALL Pause(3)
   CALL PaletteUsing(H9(0))
   CALL Pause(3)
   CALL PaletteUsing(H10(0))
   CALL Pause(3)
   CALL PaletteUsing(H11(0))
   CALL Pause(3)
   CALL PaletteUsing(H12(0))
   CALL Pause(3)
   L = L + 1
   GOSUB CheckKey
 NEXT T
 RETURN

CheckKey:
 K$ = INKEY$
 K$ = RIGHT$(K$, 1)
 IF K$ = CHR$(27) THEN
   CALL ExitGraphics
   CALL AudioOff
   END
 END IF
 IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
   IF Graphics = 320 THEN
     Graphics = 640
     CALL HighGraphics
     RETURN Again
   ELSE
     Graphics = 320
     CALL MediumGraphics
     RETURN Again
   END IF
 END IF
 RETURN

 DATA 00,00,00,00,00,00,00,00
 DATA 00,01,08,08,08,07,03,08
 DATA 00,01,08,08,06,10,03,08
 DATA 00,01,08,08,10,03,03,08
 DATA 00,01,06,14,06,10,03,04
 DATA 00,01,14,06,10,03,04,14
 DATA 00,01,06,14,06,10,14,14
 DATA 00,01,14,06,10,03,04,14
 DATA 00,01,06,14,06,10,03,04,03,00,00,14,00,00,00,00
 DATA 00,01,14,06,10,03,04,14,00,09,00,00,06,00,00,00
 DATA 00,01,06,14,06,10,14,14,00,00,01,00,00,04,00,00
 DATA 00,01,14,06,10,03,04,14,00,10,00,00,00,00,05,00
 DATA 00,01,06,14,06,10,03,04,03,00,00,00,00,00,00,09

