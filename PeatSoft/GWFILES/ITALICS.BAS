10 CLS
20 A$=STRING$(80,205)
30 PRINT A$
40 PRINT TAB(26)"7013-A.BAS     ITALICS PRINTER"
50 COLOR 23,0,0
60 PRINT :PRINT :PRINT TAB(38)"IPCO"
70 COLOR 7,0,0
80 PRINT :PRINT :PRINT TAB(29)"INTERNATIONAL PC OWNERS"
90 PRINT :PRINT :PRINT TAB(17)"p.o. box 10426, pittsburgh, pennsylvania 15234"
100 PRINT A$
110 PRINT :PRINT :PRINT :PRINT :PRINT
120 PRINT TAB(28)"PRESS ANY KEY TO CONTINUE"
130 A$=INKEY$:IF A$="" THEN 130
140 CLS
1000 ' IPCO  Software Exchange Submission PRTITAL2 authored on November 15, 1982
1010 '
1020 '  by Michael Csontos, 3228 Livonia Center Road, Lima, New York 14485
1030 '
1040 PRINT "Do you have a  1.) high resolution":PRINT
1050 PRINT "                   80 character width":PRINT
1060 PRINT "         or a  2.) low resolution":PRINT
1070 PRINT "                   40 character width":PRINT
1080 PRINT "display?":PRINT
1090 INPUT "(1 or 2)";DISP
1100 IF DISP<1 OR DISP>2 OR INT(DISP)<>DISP THEN 1090
1110 ON DISP GOTO 1120,1520
1120 WIDTH 80:WIDTH "LPT1:",255:SCREEN 0,0,0:KEY OFF:CLS
1130 PRINT "This little program will print your ASCII text files in italics on an":PRINT
1140 PRINT "EPSON MX-80 printer.  It was inspired by the program MORSECOD on the":PRINT
1150 PRINT "CAPITOL PC VOL 2.32 disk from the (PC)^3 library after discovering how":PRINT
1160 PRINT "the correct code was produced for both upper and lower case characters.":PRINT
1170 PRINT "The conversion process {using (CHR$(ASC$(x$) OR 32) or 128 in this case}":PRINT
1180 PRINT "should be very useful for other applications such as generating a graphics":PRINT
1190 PRINT "keyboard.":PRINT
1200 INPUT "Enter the filespec of the file to be typed. (nnnnnnnn.eee) "; FILESPEC$
1210 CLS:LOCATE 25,1:PRINT "FILESPEC is " FILESPEC$:LOCATE 1,1:
1220 ON ERROR GOTO 1390
1230 PRINT "You have the choice of several print typefaces. They are:":PRINT
1240 PRINT "      1: double width emphasized  40 characters/line  40 lines/page
1250 PRINT "      2: double width compressed  66 characters/line  50 lines/page
1260 PRINT "      3: normal emphasized        80 characters/line  60 lines/page
1270 PRINT "      4: compressed              132 characters/line  80 lines/page
1280 PRINT "      5: tiny (script)           132 characters/line 120 lines/page
1290 PRINT:PRINT "Please select your choice (1-5) or press <Esc> to quit.";
1300 TYPEFACE$=INKEY$:IF TYPEFACE$=CHR$(27) THEN KEY ON:END ELSE IF TYPEFACE$="" THEN 1300 ELSE TYPEFACE=VAL(TYPEFACE$):IF TYPEFACE<1 OR TYPEFACE>5 OR INT(TYPEFACE)<>TYPEFACE THEN PRINT "Please press a number from 1 - 5 or press <Esc> to quit.":GOTO 1290
1310 PRINT TYPEFACE:PRINT
1320 LPRINT CHR$(27)"@"
1330 ON TYPEFACE GOTO 1340,1350,1360,1370,1380
1340 LPRINT CHR$(27)CHR$(69)CHR$(27)CHR$(87)CHR$(1)CHR$(27)CHR$(65)CHR$(18);:GOTO 1430'double width
1350 LPRINT CHR$(15)CHR$(27)CHR$(87)CHR$(1)CHR$(27)CHR$(65)CHR$(14);:GOTO 1430'double width compressed
1360 LPRINT CHR$(27)CHR$(69);:GOTO 1430'normal emphasized
1370 LPRINT CHR$(15)CHR$(27)CHR$(65)CHR$(9);:GOTO 1430' compressed
1380 LPRINT CHR$(15)CHR$(27)"S"CHR$(INT(RND*2))CHR$(27)"A"CHR$(6);:GOTO 1430'TINYPRNT
1390 IF ERR=27 THEN PRINT "Your printer is off or empty. Program will continue when problem is fixed.":RESUME
1400 IF ERR=24 THEN PRINT "Waiting for printer.":RESUME
1410 IF ERR=25 THEN PRINT "Printer off line or something. Waiting!":RESUME
1420 ON ERROR GOTO 0
1430 OPEN FILESPEC$ FOR INPUT AS #1
1440 IF EOF(1) THEN CLOSE:PRINT:PRINT "File finished!":PRINT:KEY ON:END
1450 LINE INPUT #1, TEXT$
1460 FOR N=1 TO LEN(TEXT$):LTR$=MID$(TEXT$,N,1)
1470 ITL$=CHR$(ASC(LTR$) OR 128)
1480 LPRINT ITL$;
1490 NEXT N
1500 LPRINT
1510 GOTO 1440
1520 WIDTH 40:WIDTH "LPT1:",255:SCREEN 0,0,0:KEY OFF:CLS
1530 PRINT "This little program will print your      ASCII text files in italics on an"
1540 PRINT "EPSON MX-80 printer.  It was inspired   by the program MORSECOD on the"
1550 PRINT "CAPITOL PC VOL 2.32 disk from the       (PC)^3 library after discovering how"
1560 PRINT "the correct code was produced for both  upper and lower case characters.":PRINT
1570 PRINT "The conversion process {using           (CHR$(ASC$(x$) OR 32) or 128 in this    case} should be very useful for other   applications such as generating a       graphics keyboard.":PRINT
1580 PRINT "Enter the filespec of the file          to be typed (nnnnnnnn.eee).":PRINT
1590 INPUT "FILESPEC";FILESPEC$
1600 CLS:LOCATE 25,1:PRINT "FILESPEC is " FILESPEC$:LOCATE 1,1:
1610 ON ERROR GOTO 1780
1620 PRINT "You have the choice of several print    typefaces. They are:":PRINT
1630 PRINT "1: double width emphasized                 40 characters/line  40 lines/page":PRINT
1640 PRINT "2: double width compressed                 66 characters/line  50 lines/page":PRINT
1650 PRINT "3: normal emphasized                       80 characters/line  60 lines/page":PRINT
1660 PRINT "4: compressed                              132 characters/line  80 lines/page":PRINT
1670 PRINT "5: tiny (script)                           132 characters/line 120 lines/page":PRINT
1680 PRINT:PRINT "Please select your choice (1-5)         or press <Esc> to quit.";
1690 TYPEFACE$=INKEY$:IF TYPEFACE$=CHR$(27) THEN KEY ON:END ELSE IF TYPEFACE$="" THEN 1690 ELSE TYPEFACE=VAL(TYPEFACE$):IF TYPEFACE<1 OR TYPEFACE>5 OR INT(TYPEFACE)<>TYPEFACE THEN PRINT "Please press a number from 1 - 5 or press <Esc> to quit.":GOTO 1680
1700 PRINT TYPEFACE:PRINT
1710 LPRINT CHR$(27)"@"
1720 ON TYPEFACE GOTO 1730,1740,1750,1760,1770
1730 LPRINT CHR$(27)CHR$(69)CHR$(27)CHR$(87)CHR$(1)CHR$(27)CHR$(65)CHR$(18);:GOTO 1820'double width
1740 LPRINT CHR$(15)CHR$(27)CHR$(87)CHR$(1)CHR$(27)CHR$(65)CHR$(14);:GOTO 1820'double width compressed
1750 LPRINT CHR$(27)CHR$(69);:GOTO 1820'normal emphasized
1760 LPRINT CHR$(15)CHR$(27)CHR$(65)CHR$(9);:GOTO 1820' compressed
1770 LPRINT CHR$(15)CHR$(27)"S"CHR$(INT(RND*2))CHR$(27)"A"CHR$(6);:GOTO 1820'TINYPRNT
1780 IF ERR=27 THEN PRINT "Your printer is off or empty. Program will continue when problem is fixed.":RESUME
1790 IF ERR=24 THEN PRINT "Waiting for printer.":RESUME
1800 IF ERR=25 THEN PRINT "Printer off line or something. Waiting!":RESUME
1810 ON ERROR GOTO 0
1820 OPEN FILESPEC$ FOR INPUT AS #1
1830 IF EOF(1) THEN CLOSE:PRINT:PRINT "File finished!":PRINT:KEY ON:END
1840 LINE INPUT #1, TEXT$
1850 FOR N=1 TO LEN(TEXT$):LTR$=MID$(TEXT$,N,1)
1860 ITL$=CHR$(ASC(LTR$) OR 128)
1870 LPRINT ITL$;
1880 NEXT N
1890 LPRINT
1900 GOTO 1830
1910 ' SAVE"prtital2",a
,N,1)
1860 ITL$=CHR$(A