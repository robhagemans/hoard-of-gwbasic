10 'santa paravia and fiumaccio  version 6.3
20 ' Copyright (c) 1979, instant software, inc. (P)
100 CLEAR 700: KEY OFF: SCREEN 0: WIDTH 80: RANDOMIZE TIMER: DEFINT A-J, M-Q, T, V-W
101 Y(0) = 1400: CFGD = 15: CBKG = 0
110 DEF FNRNDF (MAXVAL) = INT(RND * MAXVAL) + 1
111 DEF FNLO$ (A$) = CHR$(ASC(A$) + (A$ <= "Z" AND A$ >= "A") * -32)'add 32 ifuppercase
112 DEF FNHI$ (A$) = CHR$(ASC(A$) + (A$ <= "z" AND A$ >= "a") * 32)'sub 32 if lowercase
120 ISX = 2: ISY = 3'x,y scales for graphic display
200 DATA "Sir ","Baron ","Count ","Marquis ","Duke ","Grand Duke ","Prince ","* H.R.H. King "
210 DATA "Lady ","Baroness ","Countess ","Marquise ","Duchess ","Grand Duchess ","Princess ","* H.R.H. Queen "
220 DATA "Santa Paravia","Fiumaccio","Torricella","Molinetto","Fontanile","Romagna"
299 ' set up matrices
300 COLOR CFGD, CBKG: CLS : PRINT : PRINT TAB(20); "    Santa Paravia and Fiumaccio"'center on screen
305 PRINT TAB(10); "Copyright (c) 1979,         Instant Software, Inc.  (P)"
306 PRINT TAB(15); "Converted to IBM PC BASIC by Dick and Jane"
310 PRINT : FOR A = 1 TO 16: READ A$: NEXT
311 WHILE INKEY$ <> "": WEND
315 A$ = "": S = TIMER: WHILE (TIMER - S) < 2 AND A$ = "": A$ = INKEY$: WEND
316 CLS : IF A$ = CHR$(13) THEN CFGD = 7
319 COLOR CFGD, CBKG
320 INPUT "How many people want to play ?(Type a number between 1 and 6)"; F
323 IF F < 1 OR F > 6 THEN CLS : GOTO 320
330 FOR A = 1 TO F: READ T$(A)
340 CLS : PRINT : PRINT "Who is the ruler of "; T$(A);
350  INPUT N$(A)
355 MID$(N$(A), 1, 1) = FNHI$(MID$(N$(A), 1, 1)): FOR I = 2 TO LEN(N$(A)): MID$(N$(A), I, 1) = FNLO$(MID$(N$(A), I, 1)): NEXT
360  N$(A) = N$(A) + " of " + T$(A)
370 CLS : INPUT "Are they a M)an or a W)oman?"; A$
380 IF A$ <> "m" AND A$ <> "w" THEN 370
390 IF LEFT$(A$, 1) = "w" THEN V(A) = 8
400 G(A) = 25: H(A) = 10: I(A) = 5: J(A) = 2: O(A) = 1420 + FNRNDF(35)
410 K(A) = 1000: L(A) = 10000: R(A) = 5000: T(A) = 1: U(A) = 1
420 N(A) = 4: P(A) = 25: Q(A) = 5: M(A) = 25: S(A) = 2000
430 NEXT
440 FOR A = 1 TO F
450  RESTORE
460  B = V(A) + T(A)
470   FOR C = 1 TO B
480   READ T$(A)
490  NEXT C
500 NEXT A
510 PRINT : INPUT "Do you wish instructions? "; A$
520 IF A$ = "n" THEN 540
530 IF A$ = "y" THEN GOSUB 9999
540 CLS : PRINT "1. Apprentice  2. Journeyman  3. Master  4. Grand Master"
550 INPUT "Enter level of play desired: "; U
560 IF U(0) < 1 THEN U(0) = 1
570 IF U(0) > 4 THEN U(0) = 4
580 U(0) = U(0) + 5
599 ' control routine
600 E = E + 1
610 IF T(E) = -1 THEN E = E + 1'if t(e)=-1!=E+1
619 ' test for end of game after death
620 IF (T(1) < 1) AND (T(2) < 1) AND (T(3) < 1) AND (T(4) < 1) AND (T(5) < 1) AND (T(6) < 1) THEN GOTO 11000
630 IF E > F THEN E = 0: Y(0) = Y(0) + 1: GOTO 600
640 IF Y(0) > O(E) THEN 600
645 IF Y(0) = O(E) THEN 1100
650 GOSUB 2000
660 GOSUB 2600
670 GOSUB 4000
680 GOSUB 3000
690 GOSUB 5000
700 GOSUB 6000
710 GOSUB 7000
990 GOTO 600
999 ' comparison routine
1000 CLS
1010 PRINT "Nobles Soldiers Clergy Merchants Serfs    Land   Treasury"
1020 PRINT : FOR A = 1 TO F: PRINT T$(A); N$(A)
1030 PRINT N(A); TAB(8); P(A); TAB(17); Q(A); TAB(24); M(A); TAB(34); S(A); TAB(43); L(A); TAB(50); K(A)
1040 NEXT
1050 PRINT : PRINT "  (Press enter)"; : GOSUB 9000
1060 RETURN
1099 ' obituary
1100 CLS : PRINT : PRINT "Very sad news": PRINT
1110 PRINT T$(E); N$(E); " has just died"
1120 T(E) = -1: Y = FNRNDF(8)
1130 IF Y(0) > 1450 THEN PRINT "of old age after a long reign": GOTO 1190
1140 IF Y < 4 THEN PRINT "of pneumonia after a cold winter in a drafty castle"
1150 IF Y = 5 THEN PRINT "in a smallpox epidemic"
1160 IF Y = 4 THEN PRINT "of typhoid after drinking contaminated water"
1170 IF Y = 6 THEN PRINT "after being attacked by robbers while traveling"
1180 IF Y > 6 THEN PRINT "of food poisoning"
1190 PRINT
1200 PRINT "(Press enter)"; : GOSUB 9000: IF F = 1 THEN 11000
1210 GOSUB 5000
1220 GOSUB 1000
1290 GOTO 600
1299 ' minor subroutines
1300 I! = INT(I!): RETURN
1310 C! = INT(C!): RETURN
1320 S! = INT(S!): RETURN
1330 K(E) = INT(K(E)): RETURN
1500 Z = FNRNDF(A) * S(E) / 100: Z% = Z: PRINT Z%; "serfs born this year": S(E) = S(E) + Z%: RETURN
1510 Z = FNRNDF(A) * S(E) / 100: Z% = Z: PRINT Z%; "serfs die this year": S(E) = S(E) - Z%: RETURN
1999 ' agricultural calculations
2000 W = (FNRNDF(5) + FNRNDF(6)) / 2 - .5'-.5 because of PC rounding: w=5.5 = 6
2010 ON W GOTO 2020, 2040, 2060, 2080, 2100
2020 W$ = "Drought -- famine threatens"
2030 GOTO 2110
2040 W$ = "Bad weather -- poor harvest"
2050 GOTO 2110
2060 W$ = "Normal weather -- average harvest"
2070 GOTO 2110
2080 W$ = "Good weather -- fine harvest"
2090 GOTO 2110
2100 W$ = "Excellent weather -- great harvest"
2109 'rats eat grain
2110 R = FNRNDF(50)
2120 R(E) = (R(E) * 100 - R(E) * R) / 100
2129 'grain harvest
2130 X = L(E): Y = (S(E) - D(E) * 100) * 5: IF Y < 0 THEN Y = 0'x is land avail, y is can work
2140 IF Y < 1 THEN Y = 2: GOTO 2210
2200 Y! = D! / H!: IF Y > 2 THEN Y = 2
2210 IF Y < .8 THEN Y = .8
2220 L = L * Y: L = INT(L * 10): L = L / 10
2229 'price of grain
2230 Z = 6 - W' price is inverse to weather
2240 G = (Z * 3 + FNRNDF(5) + FNRNDF(5)) / 5 * Y * 20
2290 RETURN
2299 ' display harvest (alternate entry - 2340)
2300 PRINT
2310 PRINT "Rats ate "; R; "%  of your grain reserves"
2320 PRINT W$; " ("; H!; "steres )"
2340 PRINT : IF K(E) < 32766 THEN GOSUB 1330
2350 PRINT "Grain        Grain       Price of   Price of   Treasury"
2360 PRINT "Reserve      Demand      Grain      Land"
2370 PRINT R(E); TAB(14); D!; TAB(26); G; TAB(37); L; TAB(48); K(E)
2380 PRINT "steres       steres      1000 st.   hectare    gold florins"
2390 RETURN
2399 ' taxes
2400 J = (J(E) * 300 - 500) * T(E): ON J(E) GOTO 2410, 2430, 2450, 2470
2410 J$ = "very fair"
2420 GOTO 2475
2430 J$ = "moderate"
2440 GOTO 2475
2450 J$ = "harsh"
2460 GOTO 2475
2470 J$ = "outrageous"
2475 Y = 150 - G(E) - H(E) - I(E): IF Y < 1 THEN Y = 1
2479 'calculate tax yield
2480 C! = (N(E) * 180 + Q(E) * 75 + M(E) * 20) * (Y / 100) + U(E) * 100
2490 S! = (N(E) * 50 + M(E) * 25 + U(E) * 10) * (Y / 100) * (5 - J(E)) / 2
2500 I! = N(E) * 250 + U(E) * 20 + (10 * J(E) * N(E)) * (Y / 100)
2510 C! = C! * G(E) / 100: IF C! < 32760 THEN GOSUB 1310
2520 S! = S! * H(E) / 100: IF S! < 32760 THEN GOSUB 1320
2530 I! = I! * I(E) / 100: IF I! < 32760 THEN GOSUB 1300
2540 PRINT "State Revenues:"; J + C! + S! + I!; "gold florins"
2542 PRINT "Customs Duty", "Sales Tax", "Income Tax", "Justice"
2546 PRINT G(E); "%", H(E); "%", I(E); "%", J$
2550 PRINT C!, S!, I!, J; "fl."
2590 RETURN
2599 ' manage harvest
2600 CLS : PRINT : PRINT T$(E); N$(E)
2610 GOSUB 2300
2620 PRINT
2630 PRINT "1. Buy grain   2. Sell grain   3. Buy land   4. Sell land"
2640 INPUT "(INPUT 0 to continue)"; I!: PRINT
2650 IF I! > 4 THEN CLS : GOTO 2630
2660 IF I! < 1 THEN RETURN
2670 ON I! GOTO 2700, 2750, 2800, 2850
2700 PRINT : INPUT "How much grain do you want to buy"; I!
2710 K(E) = K(E) - (I! * G / 1000): R(E) = R(E) + I!
2720 CLS : PRINT : PRINT T$(E); N$(E): GOSUB 2340
2730 GOTO 2620
2750 INPUT "How much grain do you wish to sell"; I!
2760 IF I! > R(E) THEN PRINT "You don't have it": PRINT : GOTO 2750
2770 K(E) = K(E) + (I! * G / 1000): R(E) = R(E) - I!
2780 GOTO 2720
2800 INPUT "How many hectares do you want to buy"; I!
2810 L(E) = L(E) + I!: K(E) = K(E) - (I! * L)
2820 GOTO 2720
2850 INPUT "How many hectares do you want to sell"; I!
2860 IF I! > (L(E) - 5000) THEN PRINT "You can't sell that much": GOTO 2850
2870 L(E) = L(E) - I!: K(E) = K(E) + (I! * L)
2880 GOTO 2720
2999 ' display taxes
3000 CLS : PRINT : PRINT T$(E); N$(E)
3010 PRINT : GOSUB 2400
3020 PRINT : PRINT "1. Customs duty  2. Sales tax  3. Wealth tax  4. Justice"
3030 PRINT "(Type tax number for changes, 0 to continue)"; : GOSUB 9000: I = VAL(A$): PRINT
3040 IF I > 4 THEN CLS : GOTO 3020
3050 IF I < 1 THEN 3200
3060 ON I GOTO 3070, 3110, 3140, 3170
3070 INPUT "New customs duty (0 to 100)"; I
3080 IF I > 100 THEN I = 100
3090 IF I < 0 THEN I = 0
3100 G(E) = I: GOTO 3000
3110 INPUT "New sales tax (0 to 50)"; I
3120 IF (I > 50) OR (I < 0) THEN I = 5
3130 H(E) = I: GOTO 3000
3140 INPUT "New wealth tax (0 to 25)"; I
3150 IF (I < 0) OR (I > 25) THEN I = 0
3160 I(E) = I: GOTO 3000
3170 PRINT "Justice: 1. Very fair  2. Moderate  3. Harsh  4. Outrageous"; : GOSUB 9000: I = VAL(A$)
3180 IF (I > 4) OR (I < 1) THEN I = 1
3190 J(E) = I: GOTO 3000
3200 K(E) = K(E) + C! + S! + I! + J
3209 ' interest charge
3210 IF K(E) < 0 THEN K(E) = K(E) * 1.5
3219 ' Bankruptcy test
3220 IF K(E) < (-10000 * T(E)) THEN 8000
3990 RETURN
3999 ' population
4000 PRINT
4010 INPUT "How much grain will you release for consumption (-1 to go back)"; G!
4015 IF G! < 0 THEN CLS : GOSUB 2720: GOTO 4000
4020 IF G! < (R(E) / 5) THEN PRINT "You must release at least"; R(E) / 5; "--20% of your reserves": GOTO 4010
4030 IF G! > (R(E) - (R(E) / 5)) THEN PRINT "You must keep at least 20%--release up to"; R(E) - R(E) / 5: GOTO 4010
4035 R(E) = R(E) - G!: CLS : PRINT : PRINT T$(E); N$(E): PRINT
4040 Z = G! / D! - 1: IF Z > 0 THEN Z = Z / 2
4050 IF Z > .25 THEN Z = Z / 10 + .25
4060 Z% = 50 - G(E) - H(E) - I(E): IF Z% < 0 THEN Z% = Z% * J(E)
4070 Z% = Z% / 10: IF Z% > 0 THEN Z% = Z% + 3 - J(E)
4080 Z = Z + (Z% / 10): IF Z > .5 THEN Z = .5
4100 IF G! < (D! - 1) THEN 4500
4110 A = 7: GOSUB 1500
4120 A = 3: GOSUB 1510
4130 IF (G(E) + H(E)) < 35 THEN M(E) = M(E) + FNRNDF(4)
4140 IF I(E) < (D! + D! * .3) THEN 4300' at least 30% more than demand to get incoming
4200 Z% = S(E) / 1000
4210 Z = (G! - D!) / D! * 10' bigger demand less chance of more moving in
4220 Z = Z * Z% * FNRNDF(25) + FNRNDF(40): IF Z > 32000 THEN Z = 32000
4230 Z% = Z: Z = FNRNDF(Z%)' and finally 1 to possible max of 32000
4240 PRINT Z; "serfs move to the city": S(E) = S(E) + Z: U(E) = U(E) + .5' economic health
4250 Z% = Z / 5: Z = FNRNDF(Z%): IF Z > 50 THEN Z = 50
4260 M(E) = M(E) + Z' get random 1/5 of serfs (up to 50 max) (merchants?)
4270 N(E) = N(E) + 1' if serfs move in get 1 (noble?)
4280 Q(E) = Q(E) + 2' get 2 (clergy?)
4299 'injustice penalty
4300 IF J(E) < 3 THEN 4490
4310 J! = S(E) / 100 * (J(E) - 2) * (J(E) - 2)
4320 J! = FNRNDF(J!)
4330 S(E) = S(E) - J!
4340 PRINT J!; "serfs flee harsh justice"
4490 GOTO 4900
4499 ' food shortage
4500 X = (D! - G!) / D! * 100 - 9: X% = X: IF X > 65 THEN X = 65: M(E) = M(E) / 2
4505 IF X < 0 THEN X% = 0: X = 0
4510 A = 3: GOSUB 1500
4520 A = X% + 8: GOSUB 1510: IF Z% > 1000 THEN U(E) = U(E) / 2
4530 GOTO 4300
4900 Z = A(E) * 75: K(E) = K(E) + Z: IF Z > 0 THEN PRINT "Your market earned"; Z; "florins rent"
4910 IF S(E) < 32766 THEN S! = S(E): GOSUB 1320: S(E) = S!
4920 Z = D(E) * (55 + FNRNDF(250)): IF Z > 0 THEN K(E) = K(E) + Z: PRINT "Your woolen mill earned"; Z; "florins"' excess serfs NOT used in woolen mill profits
4930 Z = P(E) * 3: PRINT "You paid your soldiers"; Z; "florins": K(E) = K(E) - Z
4939 ' invasion
4940 IF (L(E) / 1000) > P(E) THEN 8100
4945 IF (L(E) / 500) > (P(E) * 2.4) THEN 8100
4950 FOR A = 1 TO F: IF A = E THEN 4970
4960 IF P(A) < (P(E) * 2.4) THEN 8100
4970 NEXT
4980 PRINT "(Press enter)"; : GOSUB 9000
4990 RETURN
4999 ' draw map
5000 CLS
5010 L% = (L(E) / 1000): IF L% < 10 THEN X = 80: Y = 27: GOTO 5100' land
5020 IF L% < 30 THEN X = 80: Y = 27 - (L% - 10): GOTO 5100
5030 IF L% < 50 THEN X = 60: Y = 27 - (L% - 30): GOTO 5100
5040 IF L% < 70 THEN X = 40: Y = 27 - (L% - 50): GOTO 5100
5050 IF L% < 90 THEN X = 20: Y = 27 - (L% - 70): GOTO 5100
5060 IF L% < 110 THEN X = 1: Y = 27 - (L% - 90): GOTO 5100
5070 X = 1: Y = 7
5100 SCREEN 1: LINE (X * ISX, Y * ISY)-(128 * ISX, 48 * ISY), , B'**land area
5120 IF (P(E) - 5) < (L(E) / 1000) THEN 5160'guard tower 5130 LINE(X*ISX,Y*ISY)-((X+6)*ISX+ISX-1,(Y+5)*ISY+ISY-1),,BF
5132 FOR A = 0 TO 3
5133 LINE ((X + A * 2) * ISX, (Y - 1) * ISY)-((X + A * 2) * ISX + ISX - 1, (Y - 1) * ISY + ISY - 1), , BF
5134 NEXT A
5140 IF (P(E) / 2) < (L(E) / 1000) THEN 5160
5150 LINE ((X + 7) * ISX, (Y) * ISY)-((X + 10) * ISX + ISX - 1, (Y + 5) * ISY + ISY - 1), , BF'add on box
5151 LINE ((X + 3) * ISX, (Y + 2) * ISY)-((X + 3) * ISX + ISX - 1, (Y + 2) * ISY + ISY - 1), 0, BF'window
5152 LINE ((X + 7) * ISX, (Y + 4) * ISY)-((X + 7) * ISX + ISX - 1, (Y + 4) * ISY + ISY - 1), 0, BF'window
5156 LINE (X * ISX, (Y - 2) * ISY)-((X + 2) * ISX + ISX - 1, (Y - 1) * ISY + ISY - 1), , BF'left turret
5157 LINE ((X + 1) * ISX, (Y - 2) * ISY)-((X + 1) * ISX + ISX - 1, (Y - 2) * ISY + ISY - 1), 0, BF'left turret notch
5158 LINE ((X + 8) * ISX, (Y - 2) * ISY)-((X + 10) * ISX + ISX - 1, (Y - 1) * ISY + ISY - 1), , BF'right turret
5159 LINE ((X + 9) * ISX, (Y - 2) * ISY)-((X + 9) * ISX + ISX - 1, (Y - 2) * ISY + ISY - 1), 0, BF'right turret notch
5160 Z = C(E) + 1: IF Z > 7 THEN Z = 7'cathedral
5170 ON Z GOTO 5250, 5240, 5230, 5220, 5210, 5200, 5180
5180 LINE (96 * ISX, 30 * ISY)-(110 * ISX + ISX - 1, 30 * ISY + ISY - 1), , BF'adds floor(alltall)
5181 LINE (102 * ISX, 30 * ISY)-(102 * ISX + ISX - 1, 30 * ISY + ISY - 1), 0, BF'raise doors
5182 LINE (104 * ISX, 30 * ISY)-(104 * ISX + ISX - 1, 30 * ISY + ISY - 1), 0, BF
5200 LINE (96 * ISX, 24 * ISY)-(99 * ISX + ISX - 1, 29 * ISY + ISY - 1), , BF'left side
5210 LINE (107 * ISX, 24 * ISY)-(110 * ISX + ISX - 1, 29 * ISY + ISY - 1), , BF'right side
5220 LINE (103 * ISX, 22 * ISY)-(103 * ISX + ISX - 1, 24 * ISY + ISY - 1), , BF'cross (vert)
5221 LINE (102 * ISX, 23 * ISY)-(104 * ISX + ISX - 1, 23 * ISY + ISY - 1), , BF' (horiz)
5230 LINE (102 * ISX, 25 * ISY)-(104 * ISX + ISX - 1, 25 * ISY + ISY - 1), , BF'box under cross
5231 LINE (101 * ISX, 26 * ISY)-(105 * ISX + ISX - 1, 26 * ISY + ISY - 1), , BF
5240 LINE (100 * ISX, 27 * ISY)-(106 * ISX + ISX - 1, 29 * ISY + ISY - 1), , BF'chunk
5241 LINE (102 * ISX, 29 * ISY)-(102 * ISX + ISX - 1, 29 * ISY + ISY - 1), 0, BF'doors
5242 LINE (104 * ISX, 29 * ISY)-(104 * ISX + ISX - 1, 29 * ISY + ISY - 1), 0, BF
5250 Z = B(E) * 2: IF Z = 0 THEN 5300'castle
5251 IF Z <= 10 THEN GOTO 5260
5252 LINE (80 * ISX, 33 * ISY)-(80 * ISX + ISX - 1, 33 * ISY + ISY - 1), , BF'two decorative turrets
5253 LINE (82 * ISX, 33 * ISY)-(82 * ISX + ISX - 1, 33 * ISY + ISY - 1), , BF
5254 LINE (96 * ISX, 33 * ISY)-(96 * ISX + ISX - 1, 33 * ISY + ISY - 1), , BF
5255 LINE (98 * ISX, 33 * ISY)-(98 * ISX + ISX - 1, 33 * ISY + ISY - 1), , BF
5256 LINE (81 * ISX, 32 * ISY)-(81 * ISX + ISX - 1, 32 * ISY + ISY - 1), , BF
5257 LINE (97 * ISX, 32 * ISY)-(97 * ISX + ISX - 1, 32 * ISY + ISY - 1), , BF
5260 IF Z <= 8 THEN GOTO 5270 ELSE Z = 9
5261 LINE (87 * ISX, 31 * ISY)-(91 * ISX + ISX - 1, 33 * ISY + ISY - 1), , BF'box
5262 LINE (88 * ISX, 33 * ISY)-(88 * ISX + ISX - 1, 33 * ISY + ISY - 1), 0, BF'door
5263 LINE (90 * ISX, 32 * ISY)-(90 * ISX + ISX - 1, 32 * ISY + ISY - 1), 0, BF'window
5264 LINE (88 * ISX, 30 * ISY)-(88 * ISX + ISX - 1, 30 * ISY + ISY - 1), , BF'turret
5265 LINE (90 * ISX, 30 * ISY)-(90 * ISX + ISX - 1, 30 * ISY + ISY - 1), , BF
5266 LINE (89 * ISX, 29 * ISY)-(89 * ISX + ISX - 1, 29 * ISY + ISY - 1), , BF
5270 LINE ((89 - Z) * ISX, 34 * ISY)-((89 + Z) * ISX + ISX - 1, 36 * ISY + ISY - 1), , BF'base
5280 FOR A = (90 - Z) TO (90 + Z) STEP 2
5281 LINE (A * ISX, 35 * ISY)-(A * ISX + ISX - 1, 35 * ISY + ISY - 1), 0, BF
5282 NEXT A
5283 LINE (89 * ISX, 36 * ISY)-(89 * ISX + ISX - 1, 36 * ISY + ISY - 1), 0, BF
5300 Z = S(E) - D(E) * 100: IF Z < 1 THEN Z = 1'production (serfs & mills)
5305 Z = Z * 5 / L(E) * 10 + 1: IF Z > 10 THEN Z = 10' (land)
5310 Z = (Z / 10) * (46 - Y): Z = INT(47 - Z)' (???)
5320 LINE (119 * ISX, Z * ISY)-(127 * ISX + ISX - 1, Z * ISY + ISY - 1), , BF'bodies
5321 LINE (122 * ISX, Z * ISY)-(123 * ISX + ISX - 1, Z * ISY + ISY - 1), 0, BF
5322 LINE (125 * ISX, Z * ISY)-(125 * ISX + ISX - 1, Z * ISY + ISY - 1), 0, BF
5330 FOR A = 119 TO 127 STEP 2
5331 LINE (A * ISX, (Z + 1) * ISY)-(A * ISX + ISX - 1, (Z + 1) * ISY + ISY - 1), , BF'feet
5332 NEXT A
5333 LINE (118 * ISX, (Z - 1) * ISY)-(118 * ISX + ISX - 1, (Z - 1) * ISY + ISY - 1), , BF'heads 5334 LINE(127*ISX,(Z-1)*ISY)-(127*ISX+ISX-1,(Z-1)*ISY+ISY-1),,BF
5400 Z = A(E) * 2: IF Z = 0 THEN 5500'marketplaces
5410 IF Z > (126 - X) THEN Z = 126 - X
5420 FOR A = X TO X + Z STEP 2
5421 LINE (A * ISX, 39 * ISY)-((A + 1) * ISX + ISX - 1, 39 * ISY + ISY - 1), , BF'horiz
5422 LINE ((A + 1) * ISX, 40 * ISY)-((A + 1) * ISX + ISX - 1, 41 * ISY + ISY - 1), , BF'vert
5423 NEXT A
5500 Z = D(E): IF Z = 0 THEN 5900'mills
5510 IF Z > (126 - X) THEN Z = 126 - X
5520 LINE ((126 - Z) * ISX, 45 * ISY)-(127 * ISX + ISX - 1, 47 * ISY + ISY - 1), , BF
5530 FOR A = 127 - Z TO 126 STEP 2
5531 LINE (A * ISX, 46 * ISY)-(A * ISX + ISX - 1, 46 * ISY + ISY - 1), 0, BF'windows
5532 NEXT A
5900 LOCATE 17, 35: PRINT " Year";
5910 LOCATE 18, 35: PRINT Y(0);
5930 LOCATE 23, 1: PRINT T$(E); N$(E);
5940 LOCATE 25, 1: PRINT "(- to go back, other key to continue)"; : GOSUB 9000
5945 SCREEN 0: WIDTH 80: COLOR CFGD, CBKG
5950 IF A$ <> "-" THEN RETURN ELSE IF K(E) < 0 THEN K(E) = K(E) / 1.5
5960 K(E) = K(E) - C! - S! - I! - J: GOSUB 3000: GOTO 5000
5990 RETURN
5999 ' investments
6000 CLS : PRINT : PRINT T$(E); N$(E): PRINT "State Purchases": PRINT
6010 PRINT "1. Marketplace 1000 florins"
6020 PRINT "2. Woolen mill 2000 florins"
6030 PRINT "3. Palace (partial) 3000 florins"
6040 PRINT "4. Cathedral (partial) 5000 florins"
6050 PRINT "5. Equip one platoon of 20 500 florins"
6051 PRINT " serfs as soldiers"
6060 PRINT : PRINT "You have"; K(E); "gold florins": PRINT
6070 PRINT "To continue, type 0; to compare standings, type 6; - to go back"
6080 PRINT "Your choice?"; : GOSUB 9000: IF A$ = "-" THEN GOSUB 5000: GOTO 6000 ELSE I = VAL(A$)
6090 CLS : IF I < 1 THEN RETURN
6100 IF I > 5 THEN GOSUB 1000: GOTO 6000
6110 ON I GOTO 6200, 6120, 6300, 6400, 6500
6120 D(E) = D(E) + 1' woolen mill
6130 K(E) = K(E) - 2000
6140 U(E) = U(E) + .25' economic health -- 8000/unit
6150 GOTO 6000
6200 A(E) = A(E) + 1' market place
6210 M(E) = M(E) + 5' 5 merchants
6220 K(E) = K(E) - 1000
6230 U(E) = U(E) + .1' 10000/unit
6250 GOTO 6000
6300 B(E) = B(E) + 1' palace piece 6310 N(E)=N(E)+FNRNDF(2) ' adds 1 or 2 nobles
6320 K(E) = K(E) - 3000
6330 U(E) = U(E) + .5' 6000/unit
6350 GOTO 6000
6400 C(E) = C(E) + 1' cathedral
6410 Q(E) = Q(E) + FNRNDF(6)' adds up to 6 clergy
6420 K(E) = K(E) - 5000
6430 U(E) = U(E) + 1' 5000/unit -- cheapest economic health (except for immigrants)
6450 GOTO 6000
6500 P(E) = P(E) + 20' soldiers, no economic health, cuts serfs
6510 S(E) = S(E) - 20
6520 K(E) = K(E) - 500
6550 GOTO 6000
6999 ' calculate new title
7000 Z = 0
7010 A = A(E): GOSUB 7500'a=market places
7020 A = B(E): GOSUB 7500'b=castle parts
7030 A = C(E): GOSUB 7500'c=cathedral parts
7040 A = D(E): GOSUB 7500'd=woolen mills
7050 A = K(E) / 5000: GOSUB 7500'k=treasury
7060 A = L(E) / 6000: GOSUB 7500'l=land
7070 A = M(E) / 50: GOSUB 7500'm=merchants
7080 A = N(E) / 5: GOSUB 7500'n=nobles
7090 A = P(E) / 50: GOSUB 7500'p=soldiers
7100 A = Q(E) / 10: GOSUB 7500'q=clergy
7110 A = S(E) / 2000: GOSUB 7500's=serfs
7120 A = U(E) / 5: GOSUB 7500'u=economic health--incoming serfs (.5)/Woolen mills (.25/m)/Market places (.1/p)/Palaces (.5/p)/Cathedrals(1/p)/not kill 1000 serfs at once (divide by 2 each time)/incoming serfs (.5/yr)
7130 A = Z / U(0) - J(E) + 1: A = INT(A): IF A > 8 THEN A = 8'new title=## of points/(difficulty level+5)-justice+1(minimum title #)
7140 IF (Y(0) + 2) = O(E) THEN T(E) = T(E) + 1' if die in 2 years, bump up your title
7150 IF T(E) >= A THEN 7490
7160 T(E) = A
7170 RESTORE
7180 FOR B = 1 TO (T(E) + V(E)): READ T$(E): NEXT
7190 IF T(E) = 8 THEN 7600
7490 RETURN
7500 IF A > 10 THEN A = 10
7520 A = INT(A)
7530 Z = Z + A
7540 RETURN
7599 ' king or queen
7600 CLS : PRINT : PRINT "Game Over "; T$(E); N$(E); " Wins"
7605 PRINT : PRINT "(Press enter)"; : GOSUB 9000
7610 GOTO 11000
7999 ' bankruptcy
8000 CLS : PRINT : PRINT T$(E); N$(E); " is BANKRUPT!!!!!"
8010 PRINT : PRINT "Creditors have seized much of your assets"
8020 PRINT
8030 PRINT "(Press enter)"; : GOSUB 9000
8040 A(E) = 0: B(E) = 0: C(E) = 0: D(E) = 0: L(E) = 6000: U(E) = 1: K(E) = 100: M(E) = M(E) / 2: R(E) = 4000
8050 RETURN
8099 ' invasion (from 4940)
8100 Z = 0: FOR A = 1 TO F
8110 IF A = E THEN 8200
8120 IF P(A) < (1.2 * (L(A) / 1000)) THEN 8200
8140 IF P(A) > P(Z) THEN Z = A
8200 NEXT
8205 IF Z = 0 THEN T$(0) = " Baron ": N$(0) = "Peppone of Monterana": A! = FNRNDF(9000) + 1000: GOTO 8220
8210 A! = P(Z) * 1000 - L(Z) / 3
8220 IF A! > (L(E) - 5000) THEN A! = (L(E) - 5000) / 2
8230 PRINT T$(Z); N$(Z); " invades and seizes"; A!
8240 PRINT "hectares of land!"
8250 L(Z) = L(Z) + A!: L(E) = L(E) - A!
8260 Z = FNRNDF(40): IF Z > (P(E) - 15) THEN Z = P(E) - 15
8270 PRINT T$(E); N$(E); " loses"; Z; " soldiers in battle"
8280 P(E) = P(E) - Z: PRINT "(Press enter)"; : GOSUB 9000
8290 RETURN
9000 A$ = INKEY$: IF A$ = "" THEN 9000 ELSE A$ = FNLO$(A$): RETURN
9999  REM instructions
10000 CLS : PRINT "Santa Paravia and Fiumaccio"
10010 PRINT " You are the ruler of a 15th century Italian city-state."
10020 PRINT "If you rule well, you will receive higher titles. The"
10030 PRINT "first player to become a king or queen wins. Life expectancy"
10040 PRINT "then was brief, so you may not live long enough to win."
10050 PRINT " The computer will draw a map of your state. The size"
10060 PRINT "of the area in the wall grows as you buy more land. The"
10070 PRINT "size of the guard tower in the upper left corner shows"
10080 PRINT "the adequacy of your defenses. If it shrinks, equip more"
10090 PRINT "soldiers! If the horse and plowman is touching the top wall,"
10100 PRINT "all your land is in production. Otherwise you need more"
10110 PRINT "serfs, who will migrate to your state if you distribute"
10120 PRINT "more grain than the minumum demand. If you distribute less"
10130 PRINT "grain, some of your people will starve, and you will have"
10140 PRINT "a high death rate. High taxes raise money, but slow down"
10150 PRINT "economic growth. (Press enter to begin game)";
10160 GOSUB 9000
10170 CLS : RETURN
10999 ' end game
11000 GOSUB 5000: GOSUB 1000
11010 PRINT : PRINT "Game is over. Press enter for new game."
11020 GOSUB 9000
11030 RUN

