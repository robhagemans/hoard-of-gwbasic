10 REM - THIS IS FACECIRC.BAS
20 CLS
30 REM - Constants
40 A = 4080: C = 5100: HF = 180: PLU = 40: E = 80: FA = 1: FB = 10: FC = 350
50 K = .017453293#: REM - This is PI/180
60 INPUT "Please Enter the Outside DIAMETER in MM - "; DIA: OR1 = DIA / 2: PRINT : PRINT
70 IR1 = OR1 - 3: PRINT : PRINT
80 IR2 = IR1 - 2: IR3 = IR1 - 1
90 REM - Radius is converted to plotter units (PLU)
100 OR2 = OR1 * PLU: IR4 = IR1 * PLU: IR5 = IR2 * PLU: IR6 = IR3 * PLU
110 PRINT : PRINT "Do you want the scale in Degrees or Hours and Minutes?"
120 INPUT "        Please indicate 'd' for Degrees or 'h' for Hours... "; A$: PRINT
130 IF A$ = "h" OR A$ = "H" THEN QQ = 1
140 REM - Clear, set into HP-GL/2 mode, and initialize the printer
150 LPRINT CHR$(27); "E": LPRINT CHR$(27); "%0B": LPRINT "IN;"
160 REM - Select a pen and set the width
170 LPRINT "SP1;": LPRINT "PW.1;"
180 PRINT : PRINT : PRINT "Printing......."
190 PRINT : PRINT "NOTE: This will take up to 70 seconds to print."
200 REM - Plot outside and inside circles
210 LPRINT "PA"; A; ","; C; ";": LPRINT "CI"; OR2; : LPRINT "PU;"
220 LPRINT "PA"; A; ","; C; ";": LPRINT "CI"; IR4; : LPRINT "PU;"
230 REM - Put in the Degrees or Hours
240 IF QQ = 1 THEN FA = 1.25
250 FOR I = -HF TO HF STEP FA
260 LPRINT "PU;"
270 LPRINT "PA"; A + SIN(I * K) * IR4; ","; C + COS(I * K) * IR4; ";"
280 LPRINT "PD;"
290 LPRINT "PA"; A + SIN(I * K) * OR2; ","; C + COS(I * K) * OR2; ";"
300 LPRINT "PU;"
310 NEXT I
320 REM - Put in longer tick marks
330 IF QQ = 1 THEN FB = 15
340 FOR I = -HF TO HF STEP FB
350 LPRINT "PU;"
360 LPRINT "PA"; A + SIN(I * K) * IR5; ","; C + COS(I * K) * IR5; ";"
370 LPRINT "PD;"
380 LPRINT "PA"; A + SIN(I * K) * OR2; ","; C + COS(I * K) * OR2; ";"
390 LPRINT "PU;"
400 NEXT I
410 REM - Put in shorter tick marks
420 FOR I = -HF TO HF STEP 5
430 LPRINT "PU;"
440 LPRINT "PA"; A + SIN(I * K) * IR6; ","; C + COS(I * K) * IR6; ";"
450 LPRINT "PD;"
460 LPRINT "PA"; A + SIN(I * K) * OR2; ","; C + COS(I * K) * OR2; ";"
470 LPRINT "PU;"
480 NEXT I
490 REM - Select Font and Label
500 LPRINT "SD1,21,2,1,4,8,7,4148;"
510 IF QQ = 1 THEN GOTO 530
520 IF OR1 < 45 THEN LPRINT "DV1;"
530 LPRINT "DT*,1;"
540 LPRINT "SS;"
550 LPRINT "LO16;"
560 IF QQ = 1 THEN FC = 345: FB = 15
570 FOR J = 0 TO FC STEP FB
580 LPRINT "PU;"
590 IF QQ = 1 THEN GOTO 610
600 IF OR1 < 45 THEN LPRINT "PA"; A + SIN(J * K) * (IR5 + E); ","; C + COS(J * K) * (IR5 + E); ";": GOTO 620
610 LPRINT "PA"; A + SIN(J * K) * IR5; ","; C + COS(J * K) * IR5; ";"
620 LPRINT "DI"; COS(-J * K); ","; SIN(-J * K); ";"
630 IF J = 90 THEN LPRINT "DI0,-1;"
640 IF J = 180 THEN LPRINT "DI-1,0;"
650 IF J = 270 THEN LPRINT "DI0,1;"
660 IF QQ = 1 THEN LPRINT "LB"; INT(J / 15); "*;": GOTO 680
670 LPRINT "LB"; INT(J); "*;"
680 LPRINT "PU;"
690 NEXT J
700 REM - Reset the printer
710 LPRINT CHR$(27); "%0A": LPRINT CHR$(27); "E"
720 END
900 REM  ***********************************************
910 REM  THIS PROGRAM BY RONALD KOCELA PRODUCES CIRCULAR
920 REM  SETTING CIRCLES ON HP LASERJET PRINTERS.
930 REM  FROM SKY & TELESCOPE, MARCH 1996, PAGE 84.
940 REM  ***********************************************
