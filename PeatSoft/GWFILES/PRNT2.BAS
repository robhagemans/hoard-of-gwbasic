1000 '   Wild card print program
1010 CLS
1020 PRINT "----------------------------------------------"
1030 PRINT "    "
1040 PRINT "    PRNT2 - Wild card print program "
1050 PRINT "    "
1060 PRINT "    Prints listings of all files matching DOS type file "
1070 PRINT "    descriptions.  For example *.* would print all files on"
1080 PRINT "    disk.  .COM, .EXE and .OBJ files are ignored.  To use"
1090 PRINT "    this program just answer the questions.  Default values"
1100 PRINT "    are listed in [ ]'s."
1110 PRINT "    "
1120 PRINT "    If you find this program or other texttools from RPSoft"
1130 PRINT "    useful, a suggested donation of $25 to RPSoft, 1271 Palamos,"
1140 PRINT "    Sunnyvale, CA 94086 would be appreciated.  Permission is"
1150 PRINT "    granted to copy this program as long as this header is"
1160 PRINT "    not removed."
1170 PRINT "    "
1180 PRINT "    Copyright 1983 by RPSoft"
1190 PRINT "    "
1200 PRINT "----------------------------------------------"
1210 PRINT "     "
1220 DEFINT A-Z
1230 DIM FIN$(200),IPGN(200),ILIN(200)
1240 '
1250 PRINT "enter default drive [b] - ";
1260 K$=INKEY$:IF LEN(K$)<>1 THEN 1260
1270 IF K$=CHR$(13) THEN K$="b":GOTO 1340
1280 IF ASC(K$)<96 THEN K$=CHR$(ASC(K$)+32) ' to lower case
1290 PRINT K$
1300 IF K$<"a" OR K$>"d" THEN PRINT K$;" is an invalid drive name":GOTO 1250
1310 '
1320 '   get list of files
1330 '
1340 CLS:PRINT "files on drive: ";K$:PRINT:FILES K$+":*.*":PRINT
1350 INPUT "enter file description - /cr/ to end -";F$
1360 IF F$="" THEN 1610
1370 PR$=K$+":":IF LEN(F$)<=2 THEN 1390
1380 IF MID$(F$,2,1)<>":" THEN F$=PR$+F$ ELSE PR$=MID$(F$,1,2)
1390 SCREEN 0
1400 CLS:WIDTH 80:FILES F$
1410 PRINT :PRINT "pause while filenames are read ..."
1420 FOR DR=1 TO 24
1430 FOR DC=0 TO 65 STEP 13
1440 IF CHR$(SCREEN(DR,DC+1)) = " " THEN 1340
1450 AR=AR+1
1460 FIN$(AR)=PR$
1470 FOR L=1 TO 12
1480 C$=CHR$(SCREEN(DR,DC+L))
1490 IF L=9 THEN C$="."
1500 IF C$=" " THEN 1520
1510 FIN$(AR)=FIN$(AR)+C$
1520 NEXT L
1530 IF LEN(FIN$(AR))<4 THEN 1580
1540 L4$=RIGHT$(FIN$(AR),4)
1550 IF L4$=".COM" THEN AR=AR-1
1560 IF L4$=".EXE" THEN AR=AR-1
1570 IF L4$=".OBJ" THEN AR=AR-1
1580 NEXT DC
1590 NEXT DR
1600 GOTO 1350
1610 NIF=AR
1620 IF NIF=0 THEN PRINT "no files to list":GOTO 1340
1630 '
1640 PRINT "print first line of file on title page - [y] or n ? ";
1650 K$=INKEY$:IF LEN(K$)<>1 THEN 1650
1660 IF K$=CHR$(13) THEN K$="y":GOTO 1680
1670 IF ASC(K$)<96 THEN K$=CHR$(ASC(K$)+32) ' to lower case
1680 PRINT K$
1690 IF K$<>"y" AND K$<>"n" THEN PRINT K$;" is an invalid response ":GOTO 1640
1700 '
1710 '   sort list of filenames
1720 '
1730 PRINT :PRINT "pause while filenames are sorted ...":PRINT
1740 ISW=1
1750 WHILE ISW=1:ISW=0
1760  FOR I=2 TO NIF
1770   IF FIN$(I-1)>FIN$(I) THEN ISW=1:SWAP FIN$(I-1),FIN$(I)
1780  NEXT I
1790 WEND
1800 '
1810 '    printer setup
1820 '
1830 'LPRINT CHR$(29); ' set pitch to 12 on Okidata 84 printer
1840 LPI$="6"
1850 WIDTH "lpt1:",255
1860 IF LPI$="8" THEN LPRINT CHR$(27);"9";CHR$(18); ' 8 lines per inch
1870 NLS=66:LL=55
1880 IF LPI$="8" THEN NLS=88:LL=70
1890 '
1900 '
1910 '  print first page
1920 '
1930 FOR I=1 TO 5:LPRINT :NEXT I
1940 TD$=TIME$+" "+DATE$
1950 LPRINT TAB(10);TD$:LPRINT
1960 LPRINT TAB(10);"files contained in listing:":LPRINT
1970 FOR I=1 TO NIF
1980 LPRINT FIN$(I);:IF K$<>"y" THEN 2110
1990 '  print first line in file
2000 OPEN "I",#1,FIN$(I)
2010 IF EOF(1) THEN 2110
2020 LINE INPUT #1,L$:IF LEN(L$)=0 THEN 2110
2030 IF ASC(MID$(L$,1,1))=255 THEN 2110
2040 GOSUB 2710
2050 '  remove leading non-alpha characters
2060 FOR J=1 TO LEN(L$)-1
2070 C=ASC(MID$(L$,J,J)):IF C>64 AND C<123 THEN 2090
2080 NEXT J
2090 L=LEN(L$)-J+1:L1$=MID$(L$,J,L)
2100 LPRINT TAB(18);L1$;
2110 CLOSE #1
2120 '
2130 LPRINT "":NEXT I
2140 LN=8+NIF
2150 FMAX=NIF:NUMF=0
2160 '
2170 '   open next file and print it
2180 '
2190 NUMF=NUMF+1
2200 IF NUMF>1 THEN ILIN(NUMF-1)=LCNT ' save previous line count
2210 LCNT=0
2220 CLOSE #1
2230 IF NUMF>NIF THEN 2460
2240 OPEN "I",#1,FIN$(NUMF)
2250 PRINT "printing file ";FIN$(NUMF);" ..."
2260 GOSUB 2640:IPGN(NUMF)=PGNUM
2270 '
2280 '   read from file and print
2290 '
2300 IF EOF(1) THEN 2190
2310 LINE INPUT #1,L$
2320 IF LEN(L$)=0 THEN 2340
2330 IF ASC(MID$(L$,1,1))=255 THEN PRINT "invalid data in file":GOTO 2190
2340 IF MID$(L$,1,3)=".ej" THEN GOSUB 2640:GOTO 2300
2350 IF MID$(L$,1,1)=CHR$(12) THEN L$="<<line feed here>>"
2360 GOSUB 2710 '   remove tabs
2370 IF LEN(L$)=0 THEN L$="  "
2380 IF L$="  " AND LN>LL-10 THEN GOSUB 2640
2390 LCNT=LCNT+1
2400 LPRINT TAB(5);L$
2410 LN=LN+1:IF LN>LL THEN GOSUB 2640
2420 GOTO 2300
2430 '
2440 '  print index
2450 '
2460 GOSUB 2640
2470 LPRINT TAB(10);"Index to files";TAB(50);TD$
2480 LPRINT
2490 LPRINT TAB(10);"file";TAB(51);"page   #lines"
2500 FOR I=1 TO NIF
2510 LPRINT TAB(10);FIN$(I);"  ";STRING$(38-LEN(FIN$(I)),".");
2520 LPRINT USING "#####    ";IPGN(I),ILIN(I)
2530 LTOT=LTOT+ILIN(I)
2540 NEXT I
2550 LPRINT :LPRINT TAB(40);"   total lines - ";:LPRINT USING " ######";LTOT
2560 LN=4+NIF:GOSUB 2640
2570 LPRINT CHR$(27);"9";CHR$(0)
2580 STOP
2590 '
2600 '  subroutines
2610 '
2620 '  paging
2630 '
2640 PGNUM=PGNUM+1
2650 FOR I=LN TO NLS-3:LPRINT:NEXT I
2660 IF NUMF>NIF THEN RETURN
2670 LPRINT TAB(45);FIN$(NUMF);TAB(60);TD$;"  page";PGNUM
2680 LPRINT:LN=0:RETURN
2690 '
2700 '   remove tabs
2710 P0=INSTR(1,L$,CHR$(9)) : IF P0=0 THEN RETURN
2720 NIN=9-(P0 MOD 8):L$=MID$(L$,1,P0-1)+STRING$(NIN," ")+MID$(L$,P0+1,LEN(L$))
2730 GOTO 2710 '  any more tabs ?
EN RETURN
2720 NIN=9-(P0 MOD 8):L$=MID$(L$,1,P0-1)+STRING$(NIN," ")+MID$(L$,P0+1,LEN(L$))
2730 GOTO 2710