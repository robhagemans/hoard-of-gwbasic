 '******************************************************************************
 '* HORSE -- Animation demo using PSET option.                                 *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press F1 to change foreground color                                        *
 '* Press F2 to change background color                                        *
 '* Press F3 to restart program                                                *
 '* Press F10 to toggle between 320 and 640 graphic modes                      *
 '* Press ESC to exit program                                                  *
 '******************************************************************************
 '$INCLUDE: 'GRAFQBS.INC' 
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 DIM H1(354), H2(354), H3(354), H4(354), H5(354)

 DEF SEG = VARSEG(H1(0))
 BLOAD "HORSE1.BIN", VARPTR(H1(0))
 DEF SEG = VARSEG(H2(0))
 BLOAD "HORSE2.BIN", VARPTR(H2(0))
 DEF SEG = VARSEG(H3(0))
 BLOAD "HORSE3.BIN", VARPTR(H3(0))
 DEF SEG = VARSEG(H4(0))
 BLOAD "HORSE4.BIN", VARPTR(H4(0))
 DEF SEG = VARSEG(H5(0))
 BLOAD "HORSE5.BIN", VARPTR(H5(0))

 CALL GetTandy11(Tandy11%)
 CALL MediumGraphics
 Graphics = 320
 FC = White
 BC = Blue
 X1 = 2
 X2 = 158

 ' 
 ' --- Prints Image Arrays Onto Screen ---
 ' 
Again:
 CALL SetPalette(15, FC)
 CALL SetBackColor(BC)

PutImage:
 FOR Q = X1 TO X2 STEP 52
   CALL ExtPut(Q + 54, 85, H1(0), PutPset)
 NEXT Q
 FOR Q = X1 TO X2 STEP 52
   CALL ExtPut(Q + 54, 85, H2(0), PutPset)
 NEXT Q
 FOR Q = X1 TO X2 STEP 52
   CALL ExtPut(Q + 54, 85, H3(0), PutPset)
 NEXT Q
 FOR Q = X1 TO X2 STEP 52
   CALL ExtPut(Q + 54, 85, H4(0), PutPset)
 NEXT Q
 FOR Q = X1 TO X2 STEP 52
   CALL ExtPut(Q + 54, 85, H5(0), PutPset)
 NEXT Q
 K$ = INKEY$
 K$ = RIGHT$(K$, 1)
 IF K$ = CHR$(27) THEN
   CALL ExitGraphics
   END
 END IF
 IF K$ = CHR$(68) AND Tandy11% = Tandy11.True% THEN
   IF Graphics = 320 THEN
     Graphics = 640
     X1 = 162
     X2 = 318
     CALL HighGraphics
     GOTO Again
   ELSE
     Graphics = 320
     X1 = 2
     X2 = 158
     CALL MediumGraphics
     GOTO Again
   END IF
 END IF
 IF K$ = CHR$(59) THEN GOSUB ChangeForColor
 IF K$ = CHR$(60) THEN GOSUB ChangeBackColor
 IF K$ = CHR$(61) THEN
    FC = White
    BC = Blue
    GOTO Again
 END IF
 GOTO PutImage

 ' 
 ' --- Change Colors ---
 ' 
ChangeForColor:
 FC = FC + 1
 IF FC > 15 THEN FC = 1
 IF FC = BC THEN GOTO ChangeForColor
 CALL SetPalette(15, FC)
 RETURN

ChangeBackColor:
 BC = BC + 1
 IF BC > 15 THEN BC = 0
 IF BC = FC THEN GOTO ChangeBackColor
 CALL SetBackColor(BC)
 RETURN
