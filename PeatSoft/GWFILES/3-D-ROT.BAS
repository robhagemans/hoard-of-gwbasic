10 KEY OFF:CLS
20 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
30 PRINT"∞⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø∞"
40 PRINT"∞≥                                   ≥∞"
50 PRINT"∞≥            4019-A.BAS             ≥∞"
60 PRINT"∞≥      3-DIMMENTIONAL ROTATION      ≥∞"
70 PRINT"∞≥                                   ≥∞"
80 PRINT"∞≥                                   ≥∞"
90 PRINT"∞≥ BROUGHT TO YOU BY THE MEMBERS OF  ≥∞"
100 PRINT"∞≥      ‹‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹‹      ≥∞"
110 PRINT"∞≥        €   €   € €     €   €      ≥∞"
120 PRINT"∞≥        €   €‹‹‹€ €     €   €      ≥∞"
130 PRINT"∞≥        €   €     €     €   €      ≥∞"
140 PRINT"∞≥      ‹‹€‹‹ €     €‹‹‹‹ €‹‹‹€      ≥∞"
150 PRINT"∞≥                                   ≥∞"
160 PRINT"∞≥      International PC Owners      ≥∞"
170 PRINT"∞≥                                   ≥∞"
180 PRINT"∞≥P.O. Box 10426, Pittsburgh PA 15234≥∞"
190 PRINT"∞≥                                   ≥∞"
200 PRINT"∞¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ∞"
210 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
220 PRINT
230 PRINT "       PRESS ANY KEY TO CONTINUE
240 A$=INKEY$: IF A$="" THEN 240
250 CLS
1000 ' * * *              3-Dimensional Rotation               * * *
1005 '
1010 ' This program allows you to rotate three dimensional figures on X,Y or Z
1015 ' axes.  Call or edit figures from disk or create new figures by entering
1020 ' point coordinates and connections.  Save figure data or screen on disk.
1025 '                           9811k
1030 '             ( GRAPHICS REQUIRED medium resolution)
1035 '
1040 '            80 column screen used for listing points
1045 '
1050 ' NOTE: This is an uncompiled source program, rotation of complex figures
1055 '       could take a few seconds.
1060 '
1065 ' Hints: First time users should expirement with the sample files.
1066 '        It is suggested that if you create a figure, you save it
1067 '        immediately with the (6) on the main menu.  The figure could
1068 '        be edited and rotated later.  This is to prevent losing data
1069 '        if your figure contains illegal variables.  You could also
1070 '        add a error traping routine.  Pressing (S) while the figure
1071 '        is displayed only takes a snapshot of the screen.  This
1072 '        would not allow future rotation like the (6).
1073 '
1074 ' Tutorial: Once the program is running in basicA it will display a
1075 '           menu.  Strike the (5) to load a sample figure.  Type "CUBE"
1076 '           or another file name.  Press any key.  When returned to the
1077 '           menu, press (1) to rotate.  Familiarize yourself with the
1078 '           rotation keys then enter the increament of rotation you
1079 '           want (ex. 45).  The figure you have chosen should be
1080 '           displayed.  Press (x), there will be a pause.  Pressing
1081 '           (Shift X) will rotate in the other direction.  You may also
1082 '           press (z),(y) or there shifts to rotate.  Press (L) the
1083 '           coordinates are list on an 80 chr. screen.  Press any key.
1084 '           Pressing (I) will allow you to change the Increament of
1085 '           rotation.  Press "ESC" to return to main menu.
1086 '
1087 '
1095 KEY OFF:CLEAR
1100 DIM X(NP),Y(NP),Z(NP),XT(NP),YT(NP),ZT(NP),NX(NP),NY(NP),C(NC*2),X1(0),Y1(0),Z1(0),C1(0)
1105 SCREEN 1,0:COLOR 0,1
1110 DEF SEG= &HB800
1115 ' * * * Main Menu
1120 CLS:WIDTH 40:LOCATE 3,15:PRINT "COMMAND MENU":PRINT:PRINT
1125 PRINT "     1)  Rotate Picture"
1130 PRINT "     2)  Load Picture From Disc (bload)"
1135 PRINT "     3)  Create Point Data"
1140 PRINT "     4)  Edit Point Data"
1145 PRINT "     5)  Load Point Data From Disc"
1150 PRINT "     6)  Save Point Data On Disc"
1155 PRINT "     7)  End Operations"
1160 LOCATE 15,1:INPUT "ENTER COMMAND";COMD$:IF ASC(COMD$)<49 OR ASC(COMD$)>55 THEN 1160
1165 COMD=VAL(COMD$):ON COMD GOTO 1175,1360,1700,1170,1610,1655,1320
1170 GOSUB 1910:GOSUB 1805:GOSUB 1910:GOSUB 1925:GOSUB 1830:GOTO 1115
1175 ' * * * Rotation Menu
1180 CLS:LOCATE 1,15:PRINT "ROTATION MENU":PRINT:PRINT
1185 XS=280:YS=192:ZS=300:XL=0:YL=0:ZL=0
1190 PRINT "[X]   Positive Rotation on X Axis"
1195 PRINT "[x]   Negative Rotation on X Asis"
1200 PRINT "[Y]   Positive Rotation on Y Axis"
1205 PRINT "[y]   Negative Rotation on Y Asis"
1210 PRINT "[Z]   Positive Rotation on Z Axis"
1215 PRINT "[z]   Negative Rotation on Z Asis"
1220 PRINT "[S]   Save Picture (bsave)"
1225 PRINT "[L]   List Pionts"
1230 PRINT "[I]   Change Increament"
1235 PRINT "[Esc] Return To Command Menu":LOCATE 20,1
1240 PRINT "The increament rotation is in degrres.":PRINT
1245 INPUT "Enter the increament of rotation";INCR
1250 IF NP<1 THEN CLS:LOCATE 10,1:PRINT "You need to enter point data.":GOSUB 1345:GOTO 1115 ELSE GOSUB 1390:GOTO 1540
1255 A$=""
1260 A$=INKEY$:IF A$="" THEN 1260
1265 IF A$="X" THEN A3=INCR:GOSUB 1390:GOTO 1510
1270 IF A$="x" THEN A3=-1*INCR:GOSUB 1390:GOTO 1510
1275 IF A$="Y" THEN A2=INCR:GOSUB 1390:GOTO 1475
1280 IF A$="y" THEN A2=-1*INCR:GOSUB 1390:GOTO 1475
1285 IF A$="Z" THEN A1=INCR:GOSUB 1390:GOTO 1440
1290 IF A$="z" THEN A1=-1*INCR:GOSUB 1390:GOTO 1440
1295 IF ASC(A$)=27 THEN GOTO 1115
1300 IF A$="S" OR A$="s" THEN GOTO 1325
1305 IF A$="L" OR A$="l" THEN CLS:GOSUB 1910:GOSUB 1925:GOSUB 1345:GOSUB 1390:WIDTH 40:GOTO 1540
1310 IF A$="I" OR A$="i" THEN GOTO 1380
1315 GOTO 1255
1320 END
1325 ' * * * Save the Screen Disk
1330 LOCATE 1,1:INPUT "Name of picture?";P$:IF LEN(P$)>8 THEN LOCATE 1,1:PRINT "The name may not excede eight characters.":GOSUB 1345:GOTO 1255
1335 LOCATE 1,1:PRINT SPACE$(39);
1340 BSAVE P$,0,&H4000:GOTO 1255
1345 ' * * * Prompt
1350 LOCATE 24,8:PRINT "PRESS ANY KEY TO CONTINUE";
1355 Q$=INKEY$:IF Q$="" THEN 1355 ELSE LOCATE 24,8:PRINT SPACE$(25);:RETURN
1360 ' * * * Load Screen from Disk
1365 CLS:DEF SEG= &HB800
1370 INPUT "Enter the name of the picture";A$:CLS
1375 BLOAD A$,0:GOSUB 1345:GOTO 1115
1380 ' * * * Change Rotation Increament
1385 LOCATE 1,1:INPUT; "ENTER THE NEW INCREAMENT";INCR:LOCATE 1,1:PRINT Z$:GOTO 1255
1390 ' * * * Center point of Object
1395 FOR J=1 TO NP
1400 IF X(J)<XS THEN XS=X(J)
1405 IF X(J)>XL THEN XL=X(J)
1410 IF Y(J)<YS THEN YS=Y(J)
1415 IF Y(J)>YL THEN YL=Y(J)
1420 IF Z(J)<ZS THEN ZS=Z(J)
1425 IF Z(J)>ZL THEN ZL=Z(J)
1430 NEXT J
1435 XC=(XS+XL) / 2:YC=(YS+YL)/2:ZC=(ZS+ZL)/2:RETURN
1440 ' * * * Z Axis Rotation
1445 R=A1/57.2958
1450 FOR I=1 TO NP:TEM=X(I)
1455 X(I)=(X(I)-XC)* COS(R)-(Y(I)-YC)*SIN (R)+XC
1460 Y(I)=(TEM-XC)* SIN (R)+(Y(I)-YC)*COS (R)+YC
1465 NEXT I
1470 GOTO 1540
1475 ' * * * Y Axis Rotation
1480 R=A2/57.2958
1485 FOR I=1 TO NP:TEM=X(I)
1490 X(I)=(Z(I)-ZC)* SIN(R)+(TEM-XC)*COS(R)+XC
1495 Z(I)=(Z(I)-ZC)*COS(R)-(TEM-XC)*SIN(R)+ZC
1500 NEXT I
1505 GOTO 1540
1510 ' * * * X Axis Rotation
1515 R=A3/57.2958
1520 FOR I=1 TO NP:TEM=Z(I)
1525 Z(I)=(Z(I)-ZC) * COS(R)+(Y(I)-YC)* SIN(R)+ZC
1530 Y(I)=(Y(I)-YC) * COS(R)-(TEM-ZC)* SIN(R)+YC
1535 NEXT I
1540 ' * * * Projection 3-Dim to 2-Dim Plane Intersection Points Based on Similar Triangles
1545 FOR I= 1 TO NP
1550 XT(I)=(X(I)*SZ)/(Z(I)+SZ)
1555 YT(I)=(Y(I)*SZ)/(Z(I)+SZ)
1560 NEXT I
1565 FOR I= 1 TO NP
1570 NX(I)=((SZ-Z(I))*XT(I))/SZ
1575 NY(I)=((SZ-Z(I))*YT(I))/SZ
1580 NEXT I:CLS
1585 ' * * * Connect Points with Lines
1590 FOR I=1 TO NC *2 STEP 2
1595 LINE (NX(C(I)),NY(C(I)))-(NX(C(I+1)),NY(C(I+1))),3
1600 NEXT I
1605 GOTO 1255
1610 CLEAR:CLS:FILES:PRINT:PRINT "Place disk with data on it in drive A."
1615 PRINT:INPUT "Enter the name of file";NAM$:IF LEN(NAM$)>8 THEN PRINT "A maximum of 8 charecters are allowed.":GOTO 1615
1620 CLS:LOCATE 8,14:PRINT "LOADING DATA":OPEN NAM$ FOR INPUT AS #1
1625 INPUT#1,NP,NC
1630 DIM X(NP),Y(NP),Z(NP),XT(NP),YT(NP),NX(NP),NY(NP),C(NC*2),X1(0),Y1(0),Z1(0),C1(0)
1635 FOR I=1 TO NP:INPUT#1,X(I),Y(I),Z(I):NEXT I
1640 FOR I=1 TO NC*2:INPUT#1,C(I):NEXT I
1645 SX=-150:SY=-100:SZ=-7000
1650 GOSUB 1345:CLOSE:GOTO 1115
1655 ' * * * Save Point Data on Disk
1660 CLS:PRINT "Place disk in drive A to save data."
1665 PRINT:INPUT "Enter the name of file";NAM$:IF LEN(NAM$)>8 THEN PRINT:PRINT "A maximum of 8 charecters are allowed.":GOTO 1665
1670 IF NP<1 THEN PRINT:PRINT "There is no data to save.":GOSUB 1345:GOTO 1115
1675 CLS:LOCATE 8,14:PRINT "SAVEING DATA":OPEN NAM$ FOR OUTPUT AS #1
1680 PRINT#1,NP;NC
1685 FOR I=1 TO NP:PRINT#1,X(I);Y(I);Z(I):NEXT I
1690 FOR I=1 TO NC*2:PRINT#1,C(I):NEXT I
1695 CLOSE:GOSUB 1345:GOTO 1115
1700 ' * * * Create Point Data
1705 CLS:PRINT "     INSTRUCTIONS TO CREATE PICTURE":PRINT
1710 PRINT "   The picture is created in two  steps.First you must identify each point usingits three coordinates (X,Y,Z). Then  youstate which pair of points are connectedby lines.":PRINT
1715 PRINT "   All entries should consist  of  posi-tive interges within the  screen  dimen-sions (320,200,320). Editing may be madefollowing entries or in a later step.":PRINT
1720 PRINT "   Screen coordinates consist of X, leftto right; Y, top to bottom; Z, front  toback."
1725 GOSUB 1345
1730 WIDTH 80
1735 LOCATE 22,1:INPUT;"Enter the total number of points in your three dimensial picture";NP
1740 ERASE X,Y,Z,XT,YT,NX,NY
1745 DIM X(NP),Y(NP),Z(NP),XT(NP),YT(NP),NX(NP),NY(NP)
1750 FOR I=1 TO NP
1755 GOSUB 1855:NEXT I
1760 LOCATE 22,1:PRINT SPACE$(79):LOCATE 22,1:INPUT;"Do you need to edit any of these points Y/N.";F$
1765 IF LEFT$(F$,1)="Y" OR LEFT$(F$,1)="y" THEN GOSUB 1805
1770 GOSUB 1910:LOCATE 22,1:PRINT SPACE$(79):LOCATE 22,1:INPUT;"Enter the total number of connections";NC
1775 ERASE C:DIM C(NC*2)
1780 FOR I=1 TO NC*2 STEP 2
1785 GOSUB 1865:NEXT I
1790 LOCATE 22,1:PRINT SPACE$(79):LOCATE 22,1:INPUT;"Do you need to edit any of these connections Y/N.";F$
1795 IF LEFT$(F$,1)="Y" OR LEFT$(F$,1)="y" THEN GOSUB 1830
1800 WIDTH 40:SCREEN 1,0:GOTO 1115
1805 ' * * * Edit Point Data
1810 LOCATE 22,1:PRINT SPACE$(79);:LOCATE 22,1:INPUT ;"Enter the existing point you wish to change (0-to continue";I:IF I=0 THEN 1820
1815 GOSUB 1855:GOTO 1805
1820 LOCATE 22,1:INPUT;"Do you want to add any additional points to your picture(Y,N)";F$:IF LEFT$(F$,1)="n" OR LEFT$(F$,1)="N" THEN RETURN
1825 GOSUB 1880:I=NP:GOSUB 1855:GOTO 1820
1830 ' * * * Edit Point Connections
1835 LOCATE 22,1:PRINT SPACE$(79);:LOCATE 22,1:INPUT;"Enter the existing connection point you wish to edit (0-to continue)";I:IF I=0 THEN 1845
1840 I=I*2-1:GOSUB 1865:I=(NC-1)*2:GOTO 1830
1845 LOCATE 22,1:PRINT SPACE$(79);:LOCATE 22,1:INPUT;"Do you want to add any additional connections to your picture(Y,N)";F$:IF LEFT$(F$,1)="n" OR LEFT$(F$,1)="N" THEN RETURN
1850 GOSUB 1895:I=NC*2-1:GOSUB 1865:GOTO 1845
1855 LOCATE 22,1:PRINT SPACE$(79):LOCATE 22,1:PRINT "Enter the three coordinates X,Y,Z for point #";I;:INPUT;X(I),Y(I),Z(I)
1860 L=FIX(((I-1)*20+1)/80)+1:LOCATE L,((I-1)*20+80-80*L)+1:PRINT SPACE$(19);:LOCATE L,((I-1)*20+80-80*L)+1:PRINT I;:PRINT CHR$(29)+")";INT(X(I));:PRINT CHR$(29);INT(Y(I));:PRINT CHR$(29);INT(Z(I));:RETURN
1865 LOCATE 22,1:PRINT SPACE$(79):LOCATE 22,1:PRINT "Enter the two points to be connected (#point1,#point2) connection #";(I+1)/2;:INPUT;C(I),C(I+1)
1870 IF C(I)<1 OR C(I+1)<1 OR C(I)>NP OR C(I+1)>NP THEN LOCATE 22,1:PRINT "There are no such points to connect, use the number of existing points.":GOTO 1865
1875 L=FIX((((I+1)/2-1)*16+1)/80)+PP+1:LOCATE L,(((I+1)/2-1)*16+80-80*(L-PP))+1:PRINT SPACE$(15);:LOCATE L,(((I+1)/2-1)*16+80-80*(L-PP))+1:PRINT (I+1)/2;:PRINT CHR$(29)+")";C(I);:PRINT CHR$(29);C(I+1);:RETURN
1880 ' * * * Set Up Point Data For Additional Point
1885 ERASE X1,Y1,Z1:DIM X1(NP),Y1(NP),Z1(NP):FOR I=1 TO NP:X1(I)=X(I):Y1(I)=Y(I):Z1(I)=Z(I):NEXT I:ERASE X,Y,Z,XT,YT,NX,NY:NP=NP+1
1890 DIM X(NP),Y(NP),Z(NP),XT(NP),YT(NP),NX(NP),NY(NP):FOR I=1 TO NP-1:X(I)=X1(I):Y(I)=Y1(I):Z(I)=Z1(I):NEXT I:RETURN
1895 ' * * * Set Up Point Connection Data For Additional Connection
1900 ERASE C1:DIM C1(NC*2+2):FOR I=1 TO NC*2:C1(I)=C(I):NEXT I:ERASE C:NC=NC+1
1905 DIM C(NC*2):FOR I=1 TO (NC-1)*2:C(I)=C1(I):NEXT I:RETURN
1910 ' * * * List point Data on CRT
1915 CLS:WIDTH 80:FOR I=1 TO NP:L=FIX(((I-1)*20+1)/80)+1:LOCATE L,((I-1)*20+80-80*L)+1:PRINT I;:PRINT CHR$(29)+")";INT(X(I));:PRINT CHR$(29);INT(Y(I));:PRINT CHR$(29);INT(Z(I));:NEXT I
1920 PP=CSRLIN:RETURN
1925 ' * * * List Point Connections on CRT
1930 FOR I=1 TO NC*2 STEP 2:L=FIX((((I+1)/2-1)*16+1)/80)+PP+1:LOCATE L,(((I+1)/2-1)*16+80-80*(L-PP))+1:PRINT (I+1)/2;:PRINT CHR$(29)+")";C(I);:PRINT CHR$(29);C(I+1);:NEXT I:RETURN
0)+PP+1:LOCATE L,(((I+1)/2-1)*16+80-80*(L-PP))+1:PRINT (I+1)/2;:PRINT CHR$(29)+")";C(I);:PRIN