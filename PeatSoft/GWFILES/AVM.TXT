10 REM ANIMAL VEGETABLE MINERAL
20 REM Written by A.Sill
30 REM FOR WROX PRESS
40 REM (c) 1992
50 REM
60 DIM AVG$(5000)
70 SCREEN 9: CLS
80 A$ = "ANIMAL VEGETABLE MINERAL"
90 COLOR 2
100 LOCATE 2, (80 - LEN(A$)) / 2: PRINT A$
110 COLOR 10
120 COLOR 10: LOCATE 5, 1: PRINT "    Animal Vegetable Mineral is probably one of the simplest and earliest       programs to feature artificial intelligence. It asks you questions about an"
130 PRINT "animal, vegetable or a mineral which you have thought of. It then learns as the program continues - a feat not matched very often. The program is VERY simple   and very short, and is a great example of the use and power of arrays."
140 PRINT "    Press Q to quit at a (Y)es or (N)o prompt."
150 RAND = 0
160 LOCATE 20, 33: COLOR 12: PRINT "Press any key"
170 A$ = ""
180 A$ = INKEY$: RAND = RAND + .1: IF A$ = "" THEN 180
190 RAND = RAND - VAL(RIGHT$(TIME$, 2))
200 RANDOMIZE RAND
210 REM
220 N = 1: B = 1
230 AVG$(1) = "a carrot"
240 CLS
250 PRINT "Think of an Animal, Vegetable or a Mineral ";
260 FOR A = 1 TO 2000: IF (A / 400) = INT(A / 400) THEN PRINT ".";
270 NEXT A
280 IF AVG$(2 * N) <> "" THEN GOTO 430
290 PRINT : PRINT "Is it "; AVG$(N); " ?"
300 PRINT " (Y)es or (N)o ?"
310 A$ = INKEY$: IF A$ = "" THEN GOTO 310
320 IF A$ = "Y" OR A$ = "y" THEN PRINT : PRINT "   Phew - I got one right for once !": WHILE INKEY$ = "": WEND: GOTO 240
330 IF A$ = "Q" OR A$ = "q" THEN GOTO 520
340 IF A$ = "N" OR A$ = "n" THEN GOTO 360
350 GOTO 310
360 AVG$(2 * N) = AVG$(N)
370 PRINT : INPUT "Then what is it "; G$
380 AVG$(2 * N + 1) = G$
390 PRINT : PRINT "Give me a question that would be true for ";
400 PRINT AVG$(2 * N + 1); ", but false for "; AVG$(2 * N)
410 PRINT : INPUT "    : "; AVG$(N)
420 GOTO 240
430 PRINT : PRINT AVG$(N);
440 PRINT " (Y)es or (N)o ?"
450 B$ = INKEY$: IF B$ = "" THEN GOTO 450
460 IF B$ = "Q" OR B$ = "q" THEN GOTO 520
470 IF B$ = "Y" OR B$ = "y" OR B$ = "N" OR B$ = "n" THEN GOTO 480 ELSE GOTO 450
480 N = 2 * N + ABS(B$ = "Y" OR B$ = "y")
490 IF FRE(0) > 1000 THEN GOTO 280
500 PRINT "Ohhh no I'm getting confused - too much data !!!!"
510 WHILE INKEY$ = "": WEND
520 REM ********* RETURN TO MENU POSER
530 CLS
540 COLOR 12: PRINT : PRINT : PRINT "          Do you want to 1. Run again or": PRINT "                         2. Return to DOS ?."
550 LOCATE 3, 26: COLOR 7: PRINT "1"
560 LOCATE 4, 26: PRINT "2"
570 A$ = INKEY$: IF A$ = "" THEN GOTO 570
580 IF A$ = "1" THEN CLEAR : RUN
590 IF A$ = "2" THEN CLS : SYSTEM
600 GOTO 570

