10 '         Function plotting program, adapted from:
20 '         Creative Computing: Vol 9(no.1), 202, 1983
30 '                           by: James Fuller
40 '                  Modified by: David Bush
50 DEFINT P
60 KEY OFF
70 XOFF=200
80 SCREEN 0:CLS
90 PRINT:PRINT:PRINT
100 PRINT "This program will plot the function located at line no. 270"
110 PRINT
120 PRINT "For example:"
130 COLOR 15,0
140 PRINT:PRINT "FN R(Q)=COS(Q)+COS(2*Q)+COS(5*Q)":COLOR 7,0
150 PRINT
160 PRINT "Do you wish a:"
170 PRINT
180 PRINT"       1) A Cartesian plot"
190 PRINT"       2) A Polar plot"
200 PRINT"       3) A Three dimensional plot"
210 PRINT:PRINT"       4) Recall a previously stored image
220 PRINT:INPUT"            Input 1, 2, 3 or 4 ";PLOT
230 PRINT
240 ' ------------------------------------------------------------------------
250 '           Function to Plot:
260 '
270 DEF FN R(Q)=2*COS(Q)-COS(2*Q)+ABS(SIN(5*Q))
280 '
290 '--------------------------------------------------------------------------
300 IF PLOT<1 OR PLOT>4 THEN 220
310 ON PLOT GOTO 320,320,950,1570
320 '          Set Scaling
330 CLS:PRINT:PRINT
340 INPUT"Function increment =";INX:PRINT
350 PRINT
360 PRINT" To expand or contract axes, enter a  scaling factor."
370 PRINT" 1 is normal (enter 2 for double scale, 0.5 for half scale).
380 PRINT
390 INPUT"X-Axis scaling factor = ";SCALE.X
400 PRINT
410 INPUT"Y-Axis scaling factor = ";SCALE.Y
420 PRINT
430 INPUT"To move the origin left or right, enter a number from -130 to 130. ";SHIFT.X
440 PRINT
450 INPUT"To move the origin up or down, enter a number from -90 to 90. ";SHIFT.Y
460 '
470 CLS:SCREEN 2
480 KEY(1) ON:KEY OFF:LOCATE 25,30
490 PRINT" * * Use <F1> to Save or Stop * * ";
500 ' - - - - - - - - -   DRAW AXES  - - - - - - - - - - -
510     Y.AXIS=96+SHIFT.Y:X.AXIS=139+SHIFT.X
520       LINE(1.2*X.AXIS+XOFF,0) - (1.2*X.AXIS+XOFF,191)
530       LINE(XOFF,Y.AXIS) - (1.2*278+XOFF,Y.AXIS)
540             FOR XR=X.AXIS TO 278 STEP 19*SCALE.X
550                 LINE(1.2*XR+XOFF,Y.AXIS-1) - (1.2*XR+XOFF,Y.AXIS+1):NEXT XR
560             FOR XL=X.AXIS TO 0 STEP -19*SCALE.X
570                 LINE(1.2*XL+XOFF,Y.AXIS-1) - (1.2*XL+XOFF,Y.AXIS+1):NEXT XL
580             FOR YD=Y.AXIS TO 191 STEP 15*SCALE.Y
590                 LINE(1.2*X.AXIS-1+XOFF,YD) - (1.2*X.AXIS+1+XOFF,YD):NEXT YD
600             FOR YU=Y.AXIS TO 0 STEP -15*SCALE.Y
610                 LINE(1.2*X.AXIS-1+XOFF,YU) - (1.2*X.AXIS+1+XOFF,YU):NEXT YU
620 '
630 ON PLOT GOTO 810,640
640 ' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
650 '                    ************************
660 '                    *      Polar Plot      *
670 '                    ************************
680 FOR G=0 TO 360 STEP INX
690   T=G/57.29579
700 ON KEY (1) GOSUB 1410
710     X=FN R(T)*COS(T)
720     Y=FN R(T)*SIN(T)
730       XX=X*(19*SCALE.X)+X.AXIS
740       YY=-Y*(15*SCALE.Y)+Y.AXIS
750         IF XX<0 OR XX>270 THEN 790
760         IF YY<0 OR YY>191 THEN 790
770       PSET(1.2*XX+XOFF,YY)
780     LINE -(1.2*XX+XOFF,YY)
790 NEXT G
800 GOTO 1420
810 ' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
820 '
830 '                   ****************************
840 '                   *      Cartesian plot      *
850 '                   ****************************
860 FOR G=0 TO 278 STEP INX
870 ON KEY (1) GOSUB 1410
880     X=(G-X.AXIS)/(19*SCALE.X)
890     Y=FN R(X)
900             YY=Y.AXIS-(Y*15*SCALE.Y)
910                     IF YY<0 OR YY>191 THEN 930
920             PSET(1.2*G+XOFF,YY)
930 NEXT G
940 GOTO 1420
950 ' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
960 '                  *************************************
970 '                  *      Three-Dimensional plot       *
980 '                  *************************************
990 CLS
1000 PRINT:PRINT
1010 PRINT"To expand or compress the plot vertically, enter a number
1020 INPUT"from -40 to 40 (20 is typical). ";N1
1030 PRINT
1040 PRINT"To move the plot up or down on the screen, enter a number"
1050 INPUT"from -50 to 150 (90 is typical). ";N2
1060 '
1070 REM  constants = A, B, SHIFT.X, SHIFT.Y, Y.AXIS, X.AXIS, G
1080 REM  FOR-NEXT variables = H,BB
1090 REM     dependent on H= AA, BB
1100 REM     dependent on H and BB = CC, D1, DD
1110 REM  plotting variables = X, X1, Y, Y1
1120 REM     dependent on BB and H = X, X1
1130 REM     dependent on DD and H = Y, Y1
1140 '
1150            A=144:B=2.25:SHIFT.X=N1:SHIFT.Y=.0327:Y.AXIS=160:X.AXIS=N2:G=199
1160 ' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1170 CLS:SCREEN 2
1180 KEY(1) ON:KEY OFF:LOCATE 25,25
1190 PRINT" * * Use <F1> to Save or Stop * * ";
1200 '
1210 FOR H= -A TO A STEP B
1220 AA=INT(.5+SQR(A^2-H^2))
1230 FOR BB=-AA TO AA
1240 ON KEY (1) GOSUB 1410
1250 CC=SQR(BB^2+H^2)*SHIFT.Y:D1=FN R(CC):DD=D1*SHIFT.X
1260 GOSUB 1300
1270 NEXT BB
1280 NEXT H
1290 GOTO 1420
1300 ' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1310 X=BB+(H/B)+Y.AXIS
1320 Y=DD-(H/B)+X.AXIS
1330 X1=INT(.8499999*X)
1340 Y1=INT(.9*(G-Y))
1350 IF Y1<0 OR Y1>190 THEN RETURN
1360 PSET(1.2*X1+XOFF,Y1)
1370 CN=0 'Erase background
1380 LINE(1.2*X1+XOFF,(Y1+1)) - (1.2*X1+XOFF,190),CN
1390 CN=1
1400 RETURN
1410 ' - - - - - - - - - - Save/Recall Images- - - - - - - - - - - - - - - - -
1420 LOCATE 25,1:PRINT SPACE$(70);
1430 LOCATE 25,25:PRINT"Save this plot(y/n) ?";
1440 GOSUB 1690
1450 IF R$="n" OR R$="N" THEN 1510
1460 ON ERROR GOTO 1700
1470 LOCATE 25,25:PRINT SPACE$(50);
1480 LOCATE 25,25:INPUT;"Name: ";N$
1490 DEF SEG=&HB800 'point segment at screen buffer
1500 BSAVE N$,0,&H4000
1510 '  ? Repeat
1520 LOCATE 25,25:PRINT SPACE$(30);
1530 LOCATE 25,25:PRINT" Another plot (y/n) ?";
1540 GOSUB 1690
1550 IF R$="y" OR R$="Y" THEN SCREEN 0:LOCATE 12,10:PRINT"Program Halts execution":LOCATE 14,10:PRINT"Redefine this function to change plot
1560 SCREEN 0:COLOR 7,0
1570 'Recall Stored Image
1580 ON ERROR GOTO 1750
1590 PRINT" Do you want a listing of files? ";:GOSUB 1690
1600 IF R$="y" OR R$="Y" THEN FILES"*.bas                                       1586
1610 KEY(3) ON:KEY(4) ON
1620 KEY OFF
1630 LOCATE 25,1:INPUT"name of image to display ";A$
1640 CLS:KEY OFF:SCREEN 2
1650 DEF SEG=&HB800  'point segment to screen buffer
1660 BLOAD A$,0
1670 LOCATE 25,1
1680 GOTO 1520
1690 R$=INKEY$:IF R$="" THEN 1690 ELSE RETURN
1700 ' -- -- -- -- -- -- Error Traps -- -- -- -- -- --
1710 IF ERR=64 THEN LOCATE 25,10:PRINT"Illegal filename-- hit <CR> to continue.";:INPUT;R$:RESUME 1460
1720 IF ERR=61 THEN LOCATE 25,10:PRINT"Disk Full -- insert another disk, hit <CR> when ready.";:INPUT R$;:RESUME 1500
1730 IF ERR=52 THEN MSG$="Can't open that file"
1740 LOCATE 25,1:PRINT MSG$;" -- hit <CR> to continue.";:INPUT;R$:LOCATE 25,1:PRINT SPACE$(50);:RESUME 1480
1750 IF ERR=53 THEN MSG$="File not found"
1760 IF ERR=54 THEN MSG$="Not a screen image file"
1770 IF ERR<53 OR ERR>54 THEN 1790
1780 LOCATE 25,1:PRINT MSG$;" -- hit <CR> to continue.";:INPUT;R$:LOCATE 25,1:PRINT SPACE$(50);:RESUME 1590
1790 ON ERROR GOTO 0
