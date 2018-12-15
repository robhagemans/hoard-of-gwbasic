 '******************************************************************************
 '* KALEIDOS - Four Function Kaleioscope demo.                                 *
 '*                                                                            *
 '* Written for GRAFIX by:  Joseph A. Albrecht                                 *
 '*                                                                            *
 '* Press F1 to pause program                                                  *
 '* Press F2 to restart program                                                *
 '* Press ESC to exit program                                                  *
 '* ****************************************************************************
 '$INCLUDE: 'GRAFQBS.INC' 
 'The above line is for QuickBASIC.

 ''$INCLUDE "GRAFTBS.INC"
 'The above line is for TURBO BASIC. Remove the  ''  to compile the program.

 ''$INCLUDE "GRAFPBS.INC"
 'The above line is for PowerBASIC. Remove the  ''  to compile the program.

 RANDOMIZE TIMER
 Choice = INT(RND * 4) + 1
 L = 100
 M = 110
 N = 50
 CALL MediumGraphics

 WHILE (L = 100)
   CALL ClearScreen
   RANDOMIZE TIMER
   A = INT(RND * 15) + 1
   CALL SetPlotColor(A)
   X1 = INT(RND * 50) + 1
   X2 = INT(RND * 50) + 1
   Y1 = RND * X1
   Y2 = RND * X2
   WHILE Choice = PrevChoice
     Choice = INT(RND * 4) + 1
   WEND
   PrevChoice = Choice
   I& = TIMER + 30
   WHILE (I& > TIMER)
     Y1 = -Y1
     Y2 = -Y2
     GOSUB DoChoice
     X1 = -X1
     X2 = -X2
     GOSUB DoChoice
     Y1 = -Y1
     Y2 = -Y2
     GOSUB DoChoice
     X1 = -X1
     X2 = -X2
     GOSUB DoChoice
     IF INT(RND * 11) = 5 THEN
       RANDOMIZE TIMER
       XX = (RND * 11) - 5
       XY = (RND * 11) - 5
       YX = (RND * 11) - 5
       YY = (RND * 11) - 5
       A = INT(RND * 15) + 1
       CALL SetPlotColor(A)
     END IF
     X1 = (X1 + XX) MOD M
     Y1 = (Y1 + YX) MOD M
     X2 = (X2 + XY) MOD M
     Y2 = (Y2 + YY) MOD M
     K$ = INKEY$
     IF K$ <> "" THEN
       K = ASC(RIGHT$(K$, 1))
       IF K = 27 THEN
	 CALL ExitGraphics
	 END
       END IF
       IF K = 59 THEN
	 WHILE INKEY$ <> ""
	 WEND
	 WHILE INKEY$ = ""
	 WEND
       END IF
       IF K = 60 THEN I& = 0
       IF K = 61 THEN
	 IF AutoClear = 0 THEN
	   AutoClear = 1
	 ELSE
	   AutoClear = 0
	 END IF
       END IF
       IF K = 62 THEN
	 Choice = 1
	 I& = 0
       END IF
       IF K = 63 THEN
	 Choice = 2
	 I& = 0
       END IF
       IF K = 64 THEN
	 Choice = 3
	 I& = 0
       END IF
       IF K = 65 THEN
	 Choice = 4
	 I& = 0
       END IF
     END IF
   WEND
 WEND

DoChoice:
 SELECT CASE Choice
   CASE 1 'Lines
     A = (X1 + M) * 35 / 24
     B = Y1 + L
     C = (X2 + M) * 35 / 24
     D = Y2 + L
     CALL ExtLine(A, B, C, D)
     A = (Y1 + M) * 35 / 24
     B = X1 + L
     C = (Y2 + M) * 35 / 24
     D = X2 + L
     CALL ExtLine(A, B, C, D)
   CASE 2 'Boxes
     A = (X1 + M) * 35 / 24
     B = Y1 + L
     C = (X2 + M) * 35 / 24
     D = Y2 + L
     CALL DrawBoxC(A, B, C, D)
   CASE 3 'Lines & Boxes
     A = (X1 + M) * 35 / 24
     B = Y1 + L
     C = (X2 + M) * 35 / 24
     D = Y2 + L
     CALL ExtLine(A, B, C, D)
     A = (Y1 + M) * 35 / 24
     B = X1 + L
     C = (Y2 + M) * 35 / 24
     D = X2 + L
     CALL DrawBoxC(A, B, C, D)
   CASE 4 'Circles
     A = X1 + M + N
     B = Y1 + L
     C = ABS(X2)
     CALL ExtCircle(A, B, C)
 END SELECT
 RETURN

