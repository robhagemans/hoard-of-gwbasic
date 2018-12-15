10 REM - THIS IS SCALES.BAS
20 CLS : A = 340: BT = 254: C = BT: DIV = 1: G = A: H1 = 7650: TICK = 127
30 M = 1016: PLU = 40: CI = 360
40 INPUT "Please Enter SCALE LENGTH in mm - "; S: S1 = S
50 IF S > 2000 THEN GOTO 400
60 IF S1 > 250 THEN S1 = S1 - 250: DIV = DIV + 1: GOTO 60
70 PRINT : PRINT "Do you want the scale in Degrees or Hours and Minutes?"
80 INPUT "        Please indicate 'd' for Degrees or 'h' for Hours... "; A$: PRINT
90 IF A$ = "h" OR A$ = "H" THEN CI = 288: QQ = 1
100 PRINT : PRINT : PRINT "Printing......."
110 PRINT : PRINT "NOTE: This will take up to 90 seconds to print."
120 S = S / DIV: SP = S * PLU: REM - Convert Scale Length to plotter units
130 REM - Clear, set into HP-GL/2 mode, and initialize the printer
140 LPRINT CHR$(27); "E": LPRINT CHR$(27); "%0B": LPRINT "IN;"
150 DEG = (SP / CI) * DIV: REM - Calculate the # of deg (or hrs) to print per column
160 LPRINT "SP1;": LPRINT "PW0;": REM - Select a pen and set the width
170 REM - Using the Scale Length per column, insert tick marks for the whole column
180 REM - there will be one Tick Mark for each degree
190 FOR Z = 1 TO DIV
200 A = A + Q
210 FOR I = 0 TO SP STEP DEG
220 LPRINT "PU;"
230 LPRINT "PA"; A + TICK; ","; C + I; ";"
240 LPRINT "PD;"
250 LPRINT "PA"; A + BT; ","; C + I; ";"
260 LPRINT "PU;"
270 P = P + 1: R = R + 1: T = T + 1
280 IF QQ = 1 THEN GOTO 330
290 IF T = 360 THEN T = 0
300 IF P = 5 THEN GOSUB 540
310 IF R = 10 THEN GOSUB 620
320 GOTO 360
330 IF T = 288 THEN T = 0
340 IF P = 4 THEN GOSUB 540
350 IF R = 12 THEN GOSUB 620
360 NEXT I
370 A = 340: Q = Q + M
380 NEXT Z
390 GOTO 420
400 PRINT : PRINT "Value is too high for this program,"
410 PRINT "       Please enter another SMALLER value": PRINT : GOTO 40:
420 REM - Draw registration dots at bottom of the scales
430 LPRINT "UL8,5,20,5,20,5,20,5,20;"
440 LPRINT "LT8;"
450 LPRINT "PU;"
460 LPRINT "PA"; G; ","; C - DEG; ";"
470 LPRINT "PD;"
480 LPRINT "PA"; H1; ","; C - DEG; ";"
490 LPRINT "PU;"
500 REM - Reset the Printer
510 LPRINT CHR$(27); "%0A": LPRINT CHR$(27); "E"
520 END
530 REM - "Make every fifth degree or 20th minute longer" SUB-ROUTINE
540 LPRINT "PU;"
550 LPRINT "PA"; A; ","; C + I; ";"
560 LPRINT "PD;"
570 LPRINT "PA"; A + BT; ","; C + I; ";"
580 LPRINT "PU;"
590 P = 0
600 RETURN
610 REM - "Number the scales with degrees or hours" SUB-ROUTINE
620 LPRINT "SD1,21,2,1,4,10,7,4148;"
630 IF DIV > 2 THEN LPRINT "DI0,-1;": LPRINT "LO16;": GOTO 650
640 LPRINT "LO18;"
650 LPRINT "DT*,1;"
660 LPRINT "PU;"
670 LPRINT "PA"; A; ","; C + I; ";"
680 IF QQ = 1 THEN LPRINT "LB"; (T / 12); "*;": GOTO 710
690 LPRINT "PD;"
700 LPRINT "LB"; T; "*;"
710 LPRINT "PU;"
720 R = 0
730 RETURN
900 REM  *********************************************
910 REM  THIS PROGRAM BY RONALD KOCELA PRODUCES LINEAR
920 REM  SETTING CIRCLE SCALES ON HP LASERJET PRINTERS
930 REM  FROM SKY & TELESCOPE, MARCH 1996, PAGE 84.
940 REM  *********************************************
