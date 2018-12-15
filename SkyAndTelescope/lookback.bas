10 REM  LOOKBACK.BAS - Lookback Time
20 REM  by Thomas A. Weil
30 RM = 3700 / 2.7-1
40 INPUT "Will you enter the (A)ge of the universe or the (H)ubble parameter"; AH$
50 IF AH$ = "H" OR AH$ = "h" GOTO 90
60 IF AH$ <> "A" AND AH$ <> "a" GOTO 40
70 INPUT "Enter age of the universe NOW in billions of years"; TN
80 TN = TN * 1E+09: GOTO 110
90 INPUT "Enter Hubble parameter in km/sec/Mpc"; HN
100 TN = (2 / 3) / (HN / 9.7781E+11)
110 INPUT "Enter (T)ime THEN or (R)edshift of the light we see NOW"; TR$
120 IF TR$ = "R" OR TR$ = "r" GOTO 190
130 IF TR$ <> "T" AND TR$ <> "t" GOTO 110
140 INPUT "Enter age of the universe THEN in billions of years"; TT
150 TT = TT * 1E+09: SC = (TN / TT) ^ (2 / 3): RS = SC - 1: IF RS < RM GOTO 230
160 SM = RM + 1: TM = TN / (SM ^ 1.5)
170 PRINT : PRINT USING "You can't look back to a time earlier than ####### years"; TM
180 PRINT : GOTO 110
190 INPUT "Enter redshift value for the light we see NOW"; RS
200 SC = RS + 1: TT = TN / (SC ^ 1.5): IF RS < RM GOTO 230
210 PRINT : PRINT USING "Redshift value too large; nothing at redshift beyond ##### can be seen"; RM
220 GOTO 160
230 PRINT : PRINT USING "Age of the universe NOW  = ###.#### billion years"; TN / 1E+09
240 PRINT USING "Age of the universe THEN = ###.#### billion years"; TT / 1E+09
250 TV = TN - TT
260 PRINT USING "Light travel time        = ###.#### billion years"; TV / 1E+09
270 SC = (TN / TT) ^ (2 / 3)
280 PRINT USING "Scale of the universe NOW versus THEN = ####.###"; SC
290 RS = SC - 1
300 PRINT USING "Redshift of the light we see NOW      = ####.###"; RS
310 DT = 3 * TT * ((TN / TT) ^ (1 / 3) - 1)
320 PRINT USING "Distance of object THEN = ##.### billion light-years"; DT / 1E+09
330 DN = DT * SC
340 PRINT USING "Distance of object NOW  = ##.### billion light-years"; DN / 1E+09
350 ST = 2 * ((TN / TT) ^ (1 / 3) - 1)
360 PRINT USING "Speed away from us THEN = ##.### x speed of light"; ST
370 SN = 2 * ((TN / TT) ^ (1 / 3) - 1) / (TN / TT) ^ (1 / 3)
380 PRINT USING "Speed away from us NOW  = ##.### x speed of light"; SN
390 HT = (2 / 3) / TT * 9.7781E+11
400 PRINT USING "Hubble parameter THEN = #######.# km/sec/megaparsec"; HT
410 HN = (2 / 3) / TN * 9.7781E+11
420 PRINT USING "Hubble parameter NOW  = #######.# km/sec/megaparsec"; HN
500 REM  ========================
510 REM  FROM "ASTRONOMICAL
520 REM  COMPUTING," SKY & TELE-
530 REM  SCOPE, SEPTEMBER 1997
540 REM ========================
550 END
