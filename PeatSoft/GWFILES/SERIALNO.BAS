10 CLS
20 A$=STRING$(80,205)
30 PRINT A$
40 PRINT TAB(19)"7012-A.BAS    SERIAL NUMBER CARD GENERATOR"
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
1000 '     IPCO Software Exchange submission S-NBINGO
1010 '
1020 '     written on September 13, 1982 by
1030 '
1040 '     Michael Csontos, 3228 Livonia Center Road, Lima, New York 14485
1050 '
1060 KEY OFF:SCREEN 0,0,0:COLOR 7,0,0:WIDTH 80:CLS:REVISE=0:RANDOMIZE(VAL(RIGHT$(TIME$,2)))
1070 PRINT " Sorry, this is not a game!":PRINT
1080 PRINT " This program will produce lists of numbers, like serial numbers, sequentially":PRINT
1090 PRINT "in columns and pages from whatever starting number to whatever ending number":PRINT
1100 PRINT "you select.   The number can be formatted to include letters or fixed numbers,":PRINT
1110 PRINT "e.g.: "CHR$(34)"S/N B-123-####-45  "CHR$(34)" where the #### block can be sequenced":PRINT
1120 PRINT "through any range of four digit numbers.":PRINT
1130 PRINT " This was written to provide a checklist of phonograph record numbers for use":PRINT
1140 PRINT "in avoiding duplication when buying used records.  It might be useful in other":PRINT
1150 PRINT "collections where the items can be identified by numbers. It can also generate":PRINT
1160 PRINT "a serial number checklist for a manufacturing operation, or the s/n labels.":PRINT
1170 PRINT "The larger typefaces available might make tickets or even bingo cards!":PRINT
1180  PRINT "Press any key to continue."
1190 X$=INKEY$:IF X$="" THEN 1190 ELSE CLS
1200 ON ERROR GOTO 1840
1210 IF REVISE=0 OR REVISE=1 THEN 1220 ELSE 1320
1220 PRINT "You have the choice of several print typefaces. They are:":PRINT
1230 PRINT "      1: double width emphasized  40 characters/line  40 lines/page
1240 PRINT "      2: double width compressed  66 characters/line  50 lines/page
1250 PRINT "      3: normal emphasized        80 characters/line  60 lines/page
1260 PRINT "      4: compressed              132 characters/line  80 lines/page
1270 PRINT "      5: tiny (script)           132 characters/line 120 lines/page
1280 PRINT:PRINT "Please select your choice (1-5) or press <Esc> to quit.";
1290 TYPEFACE$=INKEY$:IF TYPEFACE$=CHR$(27) THEN 1760 ELSE IF TYPEFACE$="" THEN 1290 ELSE TYPEFACE=VAL(TYPEFACE$):IF TYPEFACE<1 OR TYPEFACE>5 OR INT(TYPEFACE)<>TYPEFACE THEN PRINT "Please press a number from 1 to 5 or press <Esc> to quit.":GOTO 1280
1300 IF TYPEFACE=1 THEN CHRLN=40:LNPG=40 ELSE IF TYPEFACE=2 THEN CHRLN=66:LNPG=50 ELSE IF TYPEFACE=3 THEN CHRLN=80:LNPG=60 ELSE IF TYPEFACE=4 THEN CHRLN=132:LNPG=80 ELSE IF TYPEFACE=5 THEN CHRLN=132:LNPG=120
1310 PRINT TYPEFACE:PRINT
1320 IF REVISE=0 OR REVISE=2 THEN 1330 ELSE 1370
1330 PRINT " You must select a format for the numbers. Since most serial numbers contain    letters and fixed digits, enter these and show the positions for the numbers    you want sequenced by # symbols. For example "CHR$(34)"LM-####  "CHR$(34)".":PRINT
1340 PRINT " The quotation marks are necessary and the spaces you leave within them will    determine the spacing of the columns. (See the PRINT USING instruction in your  BASIC manual.)":PRINT
1350 INPUT "What is your s/n format";SNFORM$
1360 IF SNFORM$="" THEN PRINT "You must enter something here or this program will do nothing for you!":GOTO 1350
1370 IF REVISE=0 OR REVISE=3 THEN 1380 ELSE 1390
1380 PRINT:INPUT "What is the starting number for your s/n series";STARTNUM
1390 IF REVISE=0 OR REVISE=4 THEN 1400 ELSE 1410
1400 PRINT:INPUT "What is the ending number for your s/n series";ENDNUM
1410 NCOLS=INT(CHRLN/LEN(SNFORM$)):IF NCOLS=(CHRLN/LEN(SNFORM$)) THEN NCOLS=NCOLS-1
1420 NLINES=INT((ENDNUM-STARTNUM)/NCOLS)+1
1430 NPAGES=NLINES/LNPG:PRINT:PRINT "Your list will be "NPAGES" pages long. If you don't like that, you may revise:":PRINT
1440 PRINT "1: typeface; 2: format; 3: start number; 4: end number; 5: nothing; <Esc>: quit":PRINT
1450 PRINT "Please press the key of your choice (1-5 or <Esc>).":PRINT
1460 REVISE$=INKEY$:IF REVISE$=""THEN 1460 ELSE IF REVISE$=CHR$(27) THEN 1760 ELSE REVISE=VAL(REVISE$)
1470 IF REVISE<1 OR REVISE>5 THEN PRINT "Please press an integer from 1 to 5 or <Esc>.":GOTO 1460 ELSE IF REVISE=5 THEN 1500
1480 IF REVISE=1 THEN PRINT "typeface was "TYPEFACE:PRINT:ELSE IF REVISE=2 THEN PRINT "format was "CHR$(34)SNFORM$CHR$(34):PRINT:ELSE IF REVISE=3 THEN PRINT "start number was "STARTNUM:PRINT:ELSE IF REVISE=4 THEN PRINT "end number was"ENDNUM:PRINT
1490 GOTO 1210
1500 PRINT "You may have a heading of up to 50 characters on each page."
1510 IF LEN(HEADING$)>0 THEN PRINT "Present heading:":PRINT HEADING$ ELSE PRINT
1520 INPUT "Heading";HEADING$
1530 IF LEN(HEADING$)>50 THEN PRINT "Too long. Try again.":GOTO 1500
1540 PRINT:PRINT "Printer ready?";
1550 X$=INKEY$:IF X$="" THEN 1550 ELSE IF X$=CHR$(27) THEN 1760 ELSE PRINT " "X$:PRINT:IF X$="y" OR X$="Y" THEN GOTO 1580
1560 IF X$="N" OR X$="n" THEN PRINT "Please press Y when ready or press <Esc> to quit.":PRINT:GOTO 1550
1570 PRINT "Please press Y or N or press <Esc> to quit.":GOTO 1540
1580 LPRINT CHR$(27)"@"CHR$(27)"C"CHR$(0)CHR$(11);:WIDTH "LPT1:",255'clear and set 11in form
1590 PAGENUM=1:IF NPAGES>1 THEN NLINES=LNPG
1600 Z$=HEADING$:W$="PAGE":V$=SPACE$(50-LEN(HEADING$)):U=INT(NPAGES)+1:IF NPAGES=INT(NPAGES) THEN U=NPAGES
1610 LPRINT CHR$(27)CHR$(70)CHR$(27)CHR$(84)CHR$(14)CHR$(15)CHR$(27)CHR$(71)"  " CHR$(27)CHR$(45)CHR$(1) Z$ CHR$(27)CHR$(45)CHR$(0) V$ W$ PAGENUM "OF" U CHR$(18)CHR$(27)CHR$(72)
1620 GOSUB 1780'setup printer
1630 PRINT "Pressing <Esc> will stop the program at end of line being printed.":PRINT
1640 LPRINT
1650 FOR N=0 TO NLINES-1
1660 LPRINT SPC(CHRLN-LEN(SNFORM$)*NCOLS-1);
1670 FOR M=0 TO NCOLS-1
1680 LPRINT USING SNFORM$;STARTNUM+N+M*NLINES;
1690 X$=INKEY$:IF X$="" THEN 1700 ELSE IF X$=CHR$(27) THEN 1770 ELSE 1690
1700 NEXT M
1710 LPRINT
1720 NEXT N
1730 STARTNUM=STARTNUM+NCOLS*NLINES:PAGENUM=PAGENUM+1
1740 NPAGES=NPAGES-1:IF NPAGES<=0 THEN 1760 ELSE IF NPAGES<=1 THEN NLINES=INT((ENDNUM-STARTNUM)/NCOLS)+1
1750 LPRINT CHR$(12);:GOTO 1610
1760 ON ERROR GOTO 0:CLS:KEY ON:END
1770 PRINT "You may revise or quit. Your options are:":PRINT:GOTO 1440
1780 ON TYPEFACE GOTO 1790,1800,1810,1820,1830
1790 LPRINT CHR$(27)CHR$(69)CHR$(27)CHR$(87)CHR$(1)CHR$(27)CHR$(65)CHR$(18);:RETURN'double width
1800 LPRINT CHR$(15)CHR$(27)CHR$(87)CHR$(1)CHR$(27)CHR$(65)CHR$(14);:RETURN'double width compressed
1810 LPRINT CHR$(27)CHR$(69);:WIDTH "LPT1:",80:RETURN'normal emphasized
1820 LPRINT CHR$(15)CHR$(27)CHR$(65)CHR$(9);:RETURN' compressed
1830 LPRINT CHR$(15)CHR$(27)"S"CHR$(INT(VAL(RIGHT$(TIME$,1))/5))CHR$(27)"A"CHR$(6);:RETURN'TINYPRNT
1840 IF ERR=5 AND ERL=1680 THEN PRINT "Your format is not satisfactory. Please revise it. Present format: "CHR$(34)SNFORM$CHR$(34):REVISE=2:RESUME 1210
1850 IF ERR=27 AND ERL=1580 THEN PRINT "Your printer is off or empty. Program will continue when problem is fixed.":RESUME
1860 IF ERR=24 THEN PRINT "Waiting for printer.":RESUME
1870 IF ERR=25 THEN PRINT "Printer off line or something. Waiting!":RESUME
1880 ON ERROR GOTO 0
1890 '    SAVE"s-nbingo",a

1870 IF ERR=25 THEN PRINT "Printer off line or something. Waiting!":RESUME
1880 ON ERROR GOTO 0
1890 '    SAVE"s-nbin