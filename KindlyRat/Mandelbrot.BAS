10 REM Mr. LEUNG Chi Kit
20 REM The Hong Kong Taoist Association Ching Chung Secondary School
30 REM
40 REM repaired/reworked by KindlyRat 16 Feb 2005
50 REM
60 LEFT = 150 : TOP = 380 : W = 360 : M = .833
70 R = 2.64 : S = 2 * R / W
80 RECEN = 0 : IMCEN = 0
90 SCREEN 9 : CLS
100 FOR Y = 0 TO W
110 FOR X = 0 TO W
120 REC = S * (X - W / 2) + RECEN : IMC = S * (Y - W / 2) + IMCEN
130 RE = REC : IM = IMC
140 RE2 = RE * RE : IM2 = IM * IM : J = 0
150 WHILE RE2 + IM2 <= 256 AND J < 15
160 IM = 2 * RE * IM + IMC
170 RE = RE2 - IM2 + REC
180 RE2 = RE * RE : IM2 = IM * IM : J = J + 1
190 WEND
200 IF J < 3 THEN GOTO 270
210 IF J >= 3 AND J < 6 THEN COLOR 14 : REM YELLOW
220 IF J >= 6 AND J < 9 THEN COLOR 1 : REM BLUE
230 IF J >= 9 AND J < 12 THEN COLOR 2 : REM GREEN
240 IF J >= 12 AND J < 15 THEN COLOR 15 : REM WHITE
250 IF J >= 15 THEN COLOR 12 : REM RED
260 PSET (X + LEFT, (TOP - Y)*M)
270 NEXT X
280 NEXT Y
290 COLOR 15 : REM WHITE
300 LINE (LEFT, (TOP - W / 2) * M) - (W + LEFT, (TOP - W / 2) * M)
310 LINE (W / 2 + LEFT, (TOP - W) * M) - (W / 2 + LEFT, TOP * M)
320 END
