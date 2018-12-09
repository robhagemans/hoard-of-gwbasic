1 ' This program was uploaded to the Capital PC Users Group Software Exchange
2 ' Host system by  Alex Hobbs of Raleigh NC on 11-12-82 at 17:20
50 KEY OFF
1000 GOTO 5000
1010 C$=INKEY$:IF C$="" THEN GOTO 1010
1020 C=ASC(RIGHT$(C$,1)):IF LEN(C$)=1 AND (C<48 OR C>57) AND C <> 32 AND C <> 13 THEN GOTO 1010
1030 RETURN     
1040 GET (CX-10,CY-8)-(CX+10,CY+8),UCUR:PUT(CX-10,CY-8),CUR,XOR:RETURN
1050 PUT (CX-10,CY-8),UCUR,PSET:ECOL=POINT(CX,CY):RETURN
1060 GOSUB 1050:T=C-71
1070 CX=CX+RX*DX(T)
1080 IF CX<10 THEN CX=10:BEEP ELSE IF CX>299 THEN CX=299:BEEP
1090 CY=CY+RY*DY(T)
1100 IF CY<8 THEN CY=8:BEEP ELSE IF CY>183 THEN CY=183:BEEP
1110 ON SKETCH GOTO 1345, 1390,1355, 1365, 1415, 1375, 1040, 1040, 1480, 1040
1120 T=C-48:IF T=0 THEN RX=PIC(0)/2:RY=PIC(1):RETURN
1130 RX=(8*(T)-4)/3:RY=2*(T)-1:RETURN
1140 COLOR BACK:GOSUB 1010:IF C<>32 THEN RETURN 5020
1150 BACK=BACK+1:IF BACK>15 THEN BACK=0
1160 GOTO 1140
1170 GET (124,90)-(195,107),HOLD
1180 COLOR,PAL
1190 LINE (124,90)-(147,107),1,BF:LINE(148,90)-(171,107),2,BF:LINE(172,90)-(195,107),3,BF
1200 GOSUB 1010:IF C<>32 THEN PUT (124,90),HOLD,PSET:RETURN 5020
1210 PAL=1-PAL:GOTO 1180
1220 GET (124,90)-(195,107),HOLD
1230 LINE (124,90)-(195,107),COL,BF
1240 GOSUB 1010:IF C<>32 THEN PUT (124,90),HOLD,PSET:RETURN 5020
1250 COL=COL+1:IF COL>3 THEN COL=0
1260 GOTO 1230
1270 GET (124,90)-(195,107),PIC
1280 LINE(124,90)-(195,107),BND,BF
1290 GOSUB 1010:IF C<>32 THEN PUT (124,90),PIC,PSET:RETURN 5020
1300 BND=BND+1:IF BND>3 THEN BND=0
1310 GOTO 1280
1320 COL=BND:RETURN
1330 ON C-58 GOTO 1340, 1380,1350,1362,1410,1370,1220,1270,1470,1560
1340 GOSUB 1050
1345 LX=CX:LY=CY:PSET(CX,CY),BND:GOSUB 1040:RETURN
1350 GOSUB 1050
1355 LINE (LX,LY)-(CX,CY),BND:GOSUB 1040       
1360 OX=LX:OY=LY:LX=CX:LY=CY:RETURN
1362 GOSUB 1050
1365 LINE (LX,LY)-(CX,CY),BND:GOTO 1040
1370 GOSUB 1050
1375 LINE (LX,LY)-(CX,CY),BND,B:GOSUB 1040:RETURN
1380 GOSUB 1050
1390 TX=ABS(CX-LX):TY=6*ABS(CY-LY)/5:CIRCLE(LX,LY),SQR(TX*TX+TY*TY),BND:GOTO 1040
1410 GOSUB 1050
1415 PAINT (CX,CY),COL,BND:GOSUB 1040:RETURN
1430 ON C-103 GOTO 1670,1630,8000,1820,1440,1440,1140,1170,1570,1850
1440 BEEP:RETURN
1470 GOSUB 1050
1480 IF CX+PIC(0)/2>320 THEN BEEP:GOTO 1040
1490 TY=PIC(1):IF CY+PIC(1)>200 THEN PIC(1)=200-CY
1500 ON PMODE GOSUB 1520,1530,1540,1550
1510 PIC(1)=TY:GOTO 1040
1520 PUT(CX,CY),PIC,PSET:RETURN
1530 PUT(CX,CY),PIC,XOR:RETURN
1540 PUT(CX,CY),PIC,OR:RETURN
1550 PUT(CX,CY),PIC,AND:RETURN
1560 GOSUB 1050:GET(LX,LY)-(CX,CY),PIC:GOSUB 1040:RETURN
1570 GET(124,90)-(195,107),HOLD
1580 T$="PSETXOR  OR AND "
1590 LOCATE 13,19:PRINT " ";MID$(T$,4*PMODE-3,4);" ";
1600 GOSUB 1010:IF C<>32 THEN PUT (124,90),HOLD,PSET:RETURN 5020
1610 PMODE=PMODE+1:IF PMODE>4 THEN PMODE=1
1620 GOTO 1590
1621 SKETCH=C-83:RETURN
1630 TYPE$="loaded":GOSUB 1710
1640 IF NAMEF$="" THEN RETURN
1650 DEF SEG=&HB800:BLOAD DRIVE$+":"+NAMEF$+".PIC",0                  
1660 GOTO 1040
1670 TYPE$="saved":GOSUB 1710
1680 IF NAMEF$="" THEN RETURN ELSE ON ERROR GOTO 1700
1690 GOSUB 1050:DEF SEG=&HB800:BSAVE DRIVE$+":"+NAMEF$+".PIC",0,&H4000:GOTO 1040
1700 LOCATE 1,1:PRINT "Unable to save picture ";:GOSUB 1010:PUT(0,0),HOLD,PSET:GOSUB 1040:RETURN 5020
1710 GET (0,0)-(319,7),HOLD
1720 LOCATE 1,1:PRINT SPACE$(39);:LOCATE 1,1
1730 PRINT"name of picture to be ";TYPE$;
1740 LINE INPUT": ";NAMEF$
1750 IF NAMEF$="" GOTO 1810
1760 NAMEF$=LEFT$(NAMEF$,8)
1770 LOCATE 1,1:PRINT SPACE$(39);:LOCATE 1,1
1780 LINE INPUT;" Drive picture is on (default=A): ";DRIVE$
1790 IF DRIVE$="" THEN DRIVE$="A"
1800 IF DRIVE$="a" OR DRIVE$="A" OR DRIVE$="B" OR DRIVE$="b" OR  DRIVE$="D" OR DRIVE$= "d" GOTO 1810 ELSE GOTO 1770
1810 PUT (0,0),HOLD,PSET:RETURN
1820 GET (0,0)-(319,31),HOLD:GOSUB 1770
1825 ON ERROR GOTO 1835
1830 LOCATE 1,1:FILES DRIVE$+":*.PIC":GOTO 1840
1835 LOCATE 1,1:PRINT "Picture not found ";
1840 GOSUB 1010:PUT(0,0),HOLD,PSET:RETURN 5020
1850 GOSUB 1050:LOCATE (CY+4)/8,(CX+4)/8:LINE INPUT "";T$:GOTO 1040
2000 ON C-93 GOTO 2100,2200,2300,2400,1440,2500,1440,2600,1440,2700
2100 T=BND:BND=ECOL:GOSUB 1340:BND=T:RETURN
2200 T=BND:BND=ECOL:GOSUB 1380:BND=T:RETURN
2300 T=BND:BND=ECOL:LX=OX:LY=OY:GOSUB 1362:BND=T:RETURN
2400 T=BND:BND=ECOL:GOSUB 1362:BND=T:RETURN
2500 T=BND:BND=ECOL:GOSUB 1370:BND=T:RETURN
2600 GOSUB 1050:LINE (LX,LY)-(CX,CY),COL,BF:GOSUB 1040:RETURN
2700 CLS:GOSUB 1040:RETURN
5000 GOSUB 5070
5010 GOSUB 1010
5020 IF C>=48 AND C<=57 THEN GOSUB 1120
5030 IF C>=59 AND C<=68 THEN GOSUB 1330
5040 IF C>=71 AND C<=81 THEN GOSUB 1060
5045 IF C>=84 AND C<=93 THEN GOSUB 1621
5047 IF C>=94 AND C<=103 THEN GOSUB 2000
5050 IF C>=104 AND C<=113 THEN GOSUB 1430
5060 GOTO 5010
5070 DEFINT A-Z
5080 DIM HLPD(8001),PIC(8001),CUR(52),UCUR(52),DX(10),DY(10),HOLD(1281)
5100 BACK=0:PAL=1:COL=3:BND=3:PMODE=2:SKETCH=10
5105 GOSUB 6000
5110 KEY OFF:SCREEN 1,0:COLOR BACK,PAL
5130 CLS:GET (0,0)-(0,0),PIC
5140 LINE (0,8)-(6,8):LINE(14,8)-(20,8)
5150 LINE(10,0)-(10,4):LINE(10,12)-(10,16)
5160 GET (0,0)-(20,16),CUR
5180 CLS:CX=159:CY=99:GOSUB 1040:GOSUB 1340:C=57:GOSUB 1120
5190 DATA -1,-1,0,-1,1,-1,0,0,-1,0,0,0,1,0,0,0,-1,1,0,1,1,1
5200 FOR I=0 TO 10:READ DX(I),DY(I):NEXT
5210 FOR I=1 TO 10:KEY I,"":NEXT
5220 RETURN
6000 CLS:PRINT "                    TABLET"
6001 PRINT
6002 PRINT
6003 PRINT "This program can be used with the IBM Color Graphics Adapter"
6004 PRINT "and Advanced Basic, to produce picture (.PIC) files, in color"
6005 PRINT
6006 PRINT "To get instructions, press ALT-F3 any time"
6007 LOCATE 25,1:PRINT "(Press any key) to start the program";
6008 GOTO 1010
7000 CLS:WIDTH 80:PRINT "                TABLET:    INSTRUCTIONS:":PRINT:PRINT"- Use numeric keypad to move graphics cursor."
7001 PRINT :PRINT"- Press number to set distance of cursor move."
7002 PRINT :PRINT "- Use 'F' Keys to perform graphics functions."
7003 PRINT
7004 PRINT:PRINT "    F KEYS MAY BE USED IN 4 MODES:":PRINT
7005 PRINT "        - Alone:  perform basic graphics functions."
7006 PRINT "        - Shift:  causes basic function to perform each"
7007 PRINT "                  time cursor is moved."
7008 PRINT "        - Ctrl :  same as basic function, but erase."
7009 PRINT "        - Alt  :  perform over-all screen and system"
7010 PRINT "                  functions."
7020 LOCATE 25,1:PRINT "press any key to see next page.";
7021 C$=INKEY$:IF C$="" THEN 7021
7030 CLS:PRINT "           TABLET:    ";
7031 PRINT "  BASIC GRAPHICS FUNCTIONS:  (F key functions)"
7033 PRINT:PRINT "    1    POINT  - etches a point and sets the reference point"
7034 PRINT       "    2    CIRCLE - draws a circle around the reference point"
7035 PRINT       "    3    CONNECT - draws a line to reference point,"
7036 PRINT       "                  and resets the reference point."
7037 PRINT       "    4    LINE   - draws a line to reference point."
7038 PRINT       "    5    PAINT  - paints the area at cursor with color"
7039 PRINT       "                  defined in F7.  Boundaries of paint "
7040 PRINT       "                  are defined by the color from F8."
7041 PRINT       "    6    BOX    - draws a box from reference point corner"
7042 PRINT       "                  to cursor point corner."
7043 PRINT       "    7    PCOLOR - color to use for paint in F5."
7044 PRINT       "    8    LCOLOR - color of lines and points drawn."
7045 PRINT       "                  Also, color of boundary for F5."
7046 PRINT       "    9    FIGURE - Place copy from F10 in space whose"
7047 PRINT       "                  upper left corner is cursor position."
7048 PRINT       "   10    COPY   - Take a copy of screen portion whose "
7049 PRINT       "                  upper left corner is reference point"
7050 PRINT       "                  and lower left corner is cursor point."
7051 PRINT       "                  This copy may be placed anywhere on "
7052 PRINT       "                  screen with F9."
7053 LOCATE 25,1:PRINT "press any key to see next page...";
7054 C$=INKEY$:IF C$="" THEN 7054
7060 CLS:PRINT "        TABLET:  SCREEN AND SYSTEM FUNCTIONS:  (ALT Fkeys)"
7061 PRINT:PRINT "   1     SAVE - saves the screen on disk (.PIC file)"
7062 PRINT:PRINT "   2     LOAD - loads a .PIC file from disk to screen."
7063 PRINT:PRINT "   3     HELP - displays this explanation"
7064 PRINT:PRINT "   4     FILES- displays all .PIC file names on a given disk."
7065 PRINT:PRINT "   7  BACKGRND- select screen background color"
7066 PRINT:PRINT "   8  PALETTE - select color choice."
7067 PRINT:PRINT "   9    PMODE - select action to use with 'PUT' for F9"
7068 PRINT       "                (see page 4-200 of BASIC manual)."
7069 PRINT:PRINT "  10    TEXT  - print text on screen in color from F8"
7070 PRINT:PRINT:PRINT"(For 7,8, and 9 - present setting is displayed"
7071 PRINT            " on screen. Roll past choices by pressing     "
7072 PRINT            " space bar, then ENTER to set new choice.)"
7079 LOCATE 25,1:PRINT "press any key to go back to graphics...";
7080 C$=INKEY$:IF C$="" THEN 7080
7090 CLS:SCREEN 1,0:COLOR BACK,PAL
7100 PUT (0,0),HLPD:RETURN
8000 GET (0,0)-(319,199),HLPD
8001 GOTO 7000
$="" THEN