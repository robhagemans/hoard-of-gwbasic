 '******************************************************************************
 '* T-BIRD - Line drawing demo for the 160x200x16 color graphics mode.         *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press ESC to exit program                                                  *
 '******************************************************************************
 '$INCLUDE: 'GRAFQBS.INC'
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 CALL LowGraphics
 DIM LC(14)
 FOR I = 0 TO 13
   READ LC(I)
 NEXT I

Again:
 CALL ClearScreen
 L = 0
 K = 156
 FOR J = 80 TO K
   FOR I = 0 TO J
     A$ = INKEY$
     IF A$ = CHR$(27) THEN GOTO EndProgram
     CALL SetPlotColor(LC(L))
     CALL ExtLine(I, J, K - I, K - J)
     CALL ExtLine(K - I, J, I, K - J)
     CALL ExtLine(J, I, K - J, K - I)
     CALL ExtLine(K - J, I, J, K - I)
     L = (L + 1) MOD 14
   NEXT I
 NEXT J
 X# = TIMER + 10
 A$ = ""
 WHILE (TIMER < X#) AND (A$ = "")
   A$ = INKEY$
 WEND
 IF A$ = CHR$(27) THEN GOTO EndProgram
 GOTO Again

EndProgram:
 CALL ExitGraphics
 END

 DATA 0,15,3,3,3,3,3,4,3,4,3,3,15,0

