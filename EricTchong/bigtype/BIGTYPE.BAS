10  ' bigtype.bas - FREEWARE 2004
20 GOTO 100 ' begin
30 SAVE"bigtype.bas":LIST-100
40 GOTO 140 ' send characters to screen
50 GOTO 550 ' print space
60 GOTO 560 ' print cursor
70 GOTO 580 ' initialize function keys
80 GOTO 960 ' get key input
90 ' Begin
100 CLS:KEY OFF:DIM A$(60):DEFSTR Q:Q=MKI$(0)
110 GOSUB 70   ' initialize function keys
120 GOTO 1030  ' initialize characters table
130 ' Send characters to screen
140 IF N=13 OR  N=28 OR N=60 THEN SW=4 ELSE SW=3
150 FOR P=1 TO SW
160  LOCATE V+P-1,F
170  PRINT MID$(A$(N),(P-1)*4+1,4);
180 NEXT
190 RETURN
200 ' Scan Keys
210 V=1:F=1:GOSUB 60:R=1:T=1:LOCATE 25,1:PRINT "Ln";R;"Pos";T;
220 GOSUB 80 ' get key
230 IF W=27 THEN 1000                ' Esc to exit
240 IF W=9 THEN CLS:GOTO 210         ' Tab to clear screen
250 IF W=8 AND V=1 AND F=1 THEN 210  ' Backspace at home position
260 IF W=8 THEN 460                  ' Backspace
270 IF W=13 THEN 530                 ' Enter
280 ' Filter keys
290 IF W>122 OR  W<32 THEN 220       ' 122=z 32=space
300 IF W>90  AND W<97 THEN 220       ' 90=Z  97=a
310 ' Assign N
320 IF W>=97 AND W<=122 THEN N=W-63:GOTO 350
330 N=W-31
340 ' Select character
350 GOSUB 40 ' send character to screen
360 F=F+5:T=T+1
370 IF T>16 THEN T=1:R=R+1
380 LOCATE 25,1:PRINT "Ln";R;"Pos";T;
390 IF R=7 THEN LOCATE 25,1:PRINT STRING$(78,32);
400 IF F>76 THEN V=V+4:F=1
410 IF V>24 THEN 440
420 GOSUB 60:GOTO 220
430 ' End of a page
440 GOSUB 80:CLS:GOTO 210
450 ' Backspace
460 IF V=5  AND F=1 THEN GOSUB 50:V=1 :F=76:R=1:T=16:GOTO 380
470 IF V=9  AND F=1 THEN GOSUB 50:V=5 :F=76:R=2:T=16:GOTO 380
480 IF V=13 AND F=1 THEN GOSUB 50:V=9 :F=76:R=3:T=16:GOTO 380
490 IF V=17 AND F=1 THEN GOSUB 50:V=13:F=76:R=4:T=16:GOTO 380
500 IF V=21 AND F=1 THEN GOSUB 50:V=17:F=76:R=5:T=16:GOTO 380
510 GOSUB 50:F=F-5:T=T-1:GOTO 380
520 ' Enter key
530 GOSUB 50:R=R+1:T=1:V=V+4:F=1:GOTO 380
540 ' Print Space or Cursor
550 N=1 :GOSUB 40:RETURN ' space
560 N=60:GOSUB 40:RETURN ' cursor
570 ' Initialize Functions Keys
580 ON KEY (1) GOSUB 680:KEY (1) ON ' F1 = White
590 ON KEY (2) GOSUB 690:KEY (2) ON ' F2 = Light Blue
600 ON KEY (3) GOSUB 700:KEY (3) ON ' F3 = Light Green
610 ON KEY (4) GOSUB 710:KEY (4) ON ' F4 = Light Cyan
620 ON KEY (5) GOSUB 720:KEY (5) ON ' F5 = Light Red
630 ON KEY (6) GOSUB 730:KEY (6) ON ' F6 = Light Magenta
640 ON KEY (7) GOSUB 740:KEY (7) ON ' F7 = Yellow
650 ON KEY (8) GOSUB 750:KEY (8) ON ' F8 = High-Intensity White
660 ON KEY (9) GOSUB 780:KEY (9) ON ' F9 = Color Message
670 RETURN
680 COLOR 7,0: LOCATE 25,20:PRINT "White               ";:GOTO 760
690 COLOR 9,0: LOCATE 25,20:PRINT "Blue                ";:GOTO 760
700 COLOR 10,0:LOCATE 25,20:PRINT "Green               ";:GOTO 760
710 COLOR 11,0:LOCATE 25,20:PRINT "Cyan                ";:GOTO 760
720 COLOR 12,0:LOCATE 25,20:PRINT "Red                 ";:GOTO 760
730 COLOR 13,0:LOCATE 25,20:PRINT "Magenta             ";:GOTO 760
740 COLOR 14,0:LOCATE 25,20:PRINT "Yellow              ";:GOTO 760
750 COLOR 15,0:LOCATE 25,20:PRINT "High-Intensity White";
760 GOSUB 60:LOCATE 25,1:PRINT "Ln";R;"Pos";T;:RETURN
770 ' Color message
780 RESTORE:CLS:V=1:F=1      :COLOR 7,0
790 FOR EQ=1 TO 44
800  IF EQ=6  THEN F=31      :COLOR 9,0
810  IF EQ=10 THEN F=56      :COLOR 10,0
820  IF EQ=15 THEN V=V+4:F=21:COLOR 11,0
830  IF EQ=19 THEN F=46      :COLOR 12,0
840  IF EQ=22 THEN V=V+4:F=1 :COLOR 13,0
850  IF EQ=29 THEN F=51      :COLOR 14,0
860  IF EQ=35 THEN V=V+4:F=16:COLOR 15,0
870  READ C:N=C:GOSUB 40:F=F+5
880 NEXT
890 LOCATE 25,15:PRINT "Programmed by Eric F. Tchong - San Nicolas - Aruba";
900 GOSUB 80:CLS:V=1:F=1:COLOR 7,0:RETURN
910 DATA 56,41,42,53,38,35,45,54,38,40,51,38,38,47
920 DATA 36,58,34,47,51,38,37
930 DATA 46,34,40,38,47,53,34,58,38,45,45,48,56
940 DATA 41,42,40,41,14,56,41,42,53,38
950 ' Get key input
960 LSET Q=MKI$(0)
970 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND
980 W=ASC(Q):RETURN
990 ' Exit
1000 KEY 5,"bigtype.bas":KEY 6,CHR$(34)+",a":KEY ON
1010 COLOR 7,0:CLS:END
1020 ' Short Instructions
1030 COLOR 15,0:PRINT "BIG CHARACTERS SCREEN-WRITER":PRINT
1040 COLOR 12,0:PRINT "<Esc> Exits program"
1050 PRINT "<Tab > Clears the Screen.":PRINT
1060 COLOR 14,0:PRINT "F1 - F8 Change Text Color "
1070 PRINT "F9      Color scheme":PRINT
1080 COLOR 10,0:PRINT "Press any key to continue..."
1090 GOSUB 80:CLS:COLOR 7,0
1100 ' Alphanumeric Keyboard Set and Common Symbols
1110 D$=CHR$(219):D2$=D$+D$:D3$=D2$+D$
1120 E$=CHR$(220):E2$=E$+E$:E3$=E2$+E$
1130 H$=CHR$(223):H2$=H$+H$:H3$=H2$+H$
1140 F$=CHR$(221):G$=CHR$(222):I$=CHR$(254):I2$=I$+I$
1150 A$(1)=STRING$(16,32)                               ' SP
1160 A$(2)="  "+D$+"   "+D$+"   "+E$+" "                ' !
1170 A$(3)=D$+" "+D$+STRING$(9,32)                      ' "
1180 A$(4)=G$+E2$+F$+D$+"  "+D$+G$+H2$+F$               ' #
1190 A$(5)=E$+D$+E2$+H$+I2$+E$+H$+D$+H2$                ' $
1200 A$(6)=STRING$(4,32)+H$+" "+E$+H$+E$+H$+" "+E$      ' %
1210 A$(7)=E$+H$+E$+" "+H$+E$+H$+E$+H$+E$+H$+E$         ' &
1220 A$(8)=" "+D$+"  "+STRING$(8,32)                    ' '
1230 A$(9)=" "+E$+H$+"  "+D$+"   "+H$+E$+" "            ' (
1240 A$(10)=" "+H$+E$+"   "+D$+"  "+E$+H$+" "           ' )
1250 A$(11)=E$+" "+E$+" "+E$+H$+E$+STRING$(5,32)        ' *
1260 A$(12)=" "+E$+"  "+H$+D$+H$+STRING$(5,32)          ' +
1270 A$(13)=STRING$(9,32)+E$+"  "+H$+STRING$(3,32)      ' ,
1280 A$(14)=STRING$(4,32)+STRING$(4,223)+STRING$(4,32)  ' -
1290 A$(15)=STRING$(8,32)+E$+STRING$(3,32)              ' .
1300 A$(16)="   "+E$+" "+E$+H$+" "+H$+"   "             ' /
1310 A$(17)=E$+H2$+E$+D$+"  "+D$+H$+E2$+H$              ' 0
1320 A$(18)=" "+E$+D$+STRING$(3,32)+D$+"  "+E$+D$+E$    ' 1
1330 A$(19)=H3$+D2$+H3$+D$+E3$                          ' 2
1340 A$(20)=H3$+D$+" "+H2$+D$+E3$+D$                    ' 3
1350 A$(21)=D$+"  "+D$+H3$+D$+STRING$(3,32)+D$          ' 4
1360 A$(22)=D$+STRING$(6,223)+E3$+E$+H$                 ' 5
1370 A$(23)=D$+H3$+D$+H2$+D2$+E2$+D$                    ' 6
1380 A$(24)=H3$+D$+" "+E$+H$+"  "+D$+"  "               ' 7
1390 A$(25)=D$+H2$+D2$+H2$+D2$+E2$+D$                   ' 8
1400 A$(26)=D$+H2$+D$+H3$+D$+E3$+D$                     ' 9
1410 A$(27)=STRING$(5,32)+H$+"   "+E$+"  "              ' :
1420 A$(28)=STRING$(5,32)+H$+"   "+E$+"  "+H$+"   "     ' ;
1430 A$(29)="  "+E$+" "+E$+H$+"   "+H$+E$+" "           ' <
1440 A$(30)=STRING$(4,32)+STRING$(8,223)+STRING$(4,32)  ' =
1450 A$(31)=" "+E$+STRING$(4,32)+H$+E$+" "+E$+H$+" "    ' >
1460 A$(32)=E$+H2$+E$+"  "+D$+STRING$(3,32)+E$+" "      ' ?
1470 A$(33)=E$+H2$+E$+D$+" "+E$+D$+H$+E3$               ' @
1480 A$(34)=E$+H2$+E$+D$+H2$+D2$+"  "+D$                ' A
1490 A$(35)=D$+H2$+E$+D$+H2$+D2$+E2$+H$                 ' B
1500 A$(36)=D$+H2$+D2$+STRING$(3,32)+D$+E2$+D$          ' C
1510 A$(37)=D$+H2$+E$+D$+"  "+D2$+E2$+H$                ' D
1520 A$(38)=D$+H3$+D$+H2$+" "+D$+E3$                    ' E
1530 A$(39)=D$+H3$+D$+H2$+" "+D$+STRING$(3,32)          ' F
1540 A$(40)=D$+H3$+D$+" "+E2$+D$+E2$+D$                 ' G
1550 A$(41)=D$+"  "+D2$+H2$+D2$+"  "+D$                 ' H
1560 A$(42)=" "+H$+D$+H$+"  "+D$+"  "+E$+D$+E$          ' I
1570 A$(43)=" "+H$+D$+H$+"  "+D$+" "+H$+E$+D$+" "       ' J
1580 A$(44)=D$+" "+E$+H$+D$+H$+E$+" "+D$+"  "+D$        ' K
1590 A$(45)=D$+STRING$(3,32)+D$+STRING$(3,32)+D$+E3$    ' L
1600 A$(46)=STRING$(5,219)+G$+F$+D2$+"  "+D$            ' M
1610 A$(47)=D$+E$+" "+D2$+H$+D3$+" "+H$+D$              ' N
1620 A$(48)=D$+H2$+D2$+"  "+D2$+E2$+D$                  ' O
1630 A$(49)=D$+H2$+D2$+H3$+D$+STRING$(3,32)             ' P
1640 A$(50)=D$+H2$+D2$+"  "+D2$+E$+H$+E$                ' Q
1650 A$(51)=D$+H2$+E$+D$+H2$+E$+D$+"  "+D$              ' R
1660 A$(52)=D$+STRING$(6,223)+D$+E3$+D$                 ' S
1670 A$(53)=H$+D$+H2$+" "+D$+F$+"  "+D$+F$+" "          ' T
1680 A$(54)=D$+"  "+D2$+"  "+D2$+E2$+D$                 ' U
1690 A$(55)=D$+"  "+D2$+"  "+D$+G$+E2$+F$               ' V
1700 A$(56)=D$+"  "+D2$+G$+F$+D$+G$+D2$+F$              ' W
1710 A$(57)=D$+"  "+D$+" "+D2$+" "+D$+"  "+D$           ' X
1720 A$(58)=D$+"  "+D$+G$+E2$+F$+" "+G$+F$+" "          ' Y
1730 A$(59)=H3$+D$+" "+E$+H$+" "+D$+E3$                 ' Z
1740 A$(60)=STRING$(8,32)+STRING$(4,220)+"    "         ' Cursor
1750 LOCATE 25,20:PRINT "White               ";
1760 GOTO 210
