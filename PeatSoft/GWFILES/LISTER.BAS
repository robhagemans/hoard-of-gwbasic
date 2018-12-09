10 '  LISTER ,to list BASIC programs saved on disk in the ASCII format.
20 '
30 '  SOURCE: "Creative Computing" -- Sept 82 Issue -- pg. 180-185
40 '           Paul F Doering
50 '
60 '  MODIFIED: Disk file I/O and other improvements by Lee Anderson 9/01/82.
70 '
80 ' File names that do not have a . qualifier will be appended with .BAS
90 ' BASIC/BASICA programs must have been saved in the ,A format.
100 '
110 ' The file name field has special processing for indicators saying that
120 ' the file name points to a list of files to be listed and if selected
130 ' pages are to be listed.
140 '
150 ' Special processing for file name.
160 ' 1. File name only - process it to the printer.
170 ' 2. File name preceded by the char <.
180 '    The supplied file name contains a list of files to be listed.
190 ' 3. First char on line is a *. Process the following characters for
200 '    a starting page (p1) and an ending page (p2) to be listed.
210 '    EXAMPLE: *5-8  FILE WILL LIST PAGES 5 THRU 8 OF THE FILE.
220 '    A blank character must separate the file name from the page # info.
230 ON ERROR GOTO 0
240 SCREEN 0: KEY OFF: CLS: DEFINT A-Z: WIDTH 80
250 DIM PREFER$(20)
260 DIM FKEY$(12), MONTH$(12)
270 FOR J = 1 TO 12: READ MONTH$(J): NEXT J
280 DATA Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
290 TODAY$ = MID$(DATE$,4,3) + MONTH$(VAL(MID$(DATE$,1,2))) + "-" + MID$(DATE$,9,2)
300 '  Set initial parameters.
310 L.MGN = 8: R.MGN = 75: B.MGN = 8: LN.SPA = 1: PG.LEN = 66: PG.WID = 80
320 DBL.WID = 20
330 FLNM$ = "": HEADER$ = "": INDENT$ = SPACE$(8)
340 '  Initialize the printer, complain if it's off line.
350 ON ERROR GOTO 2040
360 LPRINT CHR$(24); CHR$(27); CHR$(18);: WIDTH "lpt1:",80
370 ON ERROR GOTO 0
380 'Define F-Keys
390 KEY 1,"Lt margin at :"
400 KEY 2,"Rt margin at :"
410 KEY 3,"Bottom blanks:"
420 KEY 4,"Width (max's):"
430 KEY 5,"Single spaced"+CHR$(13)
440 KEY 6,"Double spaced"+CHR$(13)
450 KEY 7,"Program Name: "
460 KEY 8,"Header: "
470 KEY 9,"Review"+CHR$(13)
480 KEY 10,"Begin"+ CHR$(13)
490 KEY ON: LOCATE 23,1
500 '  Call attention to F-Keys.
510 ARROWS$ = STRING$(20,"-")
520 PRINT ARROWS$;: COLOR 0,7
530 PRINT "Use F-Keys to set listing format ";: COLOR 7,0
540 PRINT ARROWS$
550 FOR I= 0 TO 11
560 READ FKEY$(I)
570 NEXT I
580 DATA Lt,Rt,Bo,Wi,Si,Do,Pr,He,Re,Be,xx,XX
590 'Set up list of prefered breakpoints.
600 FOR IP = 0 TO 20
610 READ Z$
620 IF Z$ <> "END" THEN PREFER$(IP) = Z$: NEXT IP
630 IP = IP-1
640 DATA " ELSE"," THEN",": "," PRINT"
650 DATA " IF "," '"," OR "," AND "," REM",";"
660 DATA "="," ","+","$",",", END
670 '  Loop for adjusting runtime parameters
680 LINE INPUT Z$
690 FOR I = 0 TO 11
700 IF LEFT$(Z$,2) = FKEY$(I) GOTO 720 ELSE NEXT I
710 GOTO 680
720 ON I+1 GOTO 740,750,760,870,800,810,830,780,990,1100,2270,2270
730 '  Margin - setting routines.
740 GOSUB 2210: L.MGN = NUMBA: GOTO 680
750 GOSUB 2210: R.MGN = NUMBA: GOTO 680
760 GOSUB 2210: B.MGN = NUMBA: GOTO 680
770 '  Establish page header.
780 HEADER$ = ", " + MID$(Z$,9): GOTO 680
790 '  Single or double spaced out.put
800 LN.SPA = 1: GOTO 680
810 LN.SPA = 2: GOTO 680
820 '  Get name of program to be listed.
830 FLNM$ = MID$(Z$,15)
840 IF LEFT$(FLNM$,1) = " " THEN FLNM$ = MID$(FLNM$,2): GOTO 840
850 GOTO 680
860 ' Pass man-page-width parameter to the MX80 printer.
870 GOSUB 2210
880 IF NUMBA <= 132 GOTO 910
890 PRINT "Maxium page width is limited to 132 characters"
900 GOTO 680
910 IF NUMBA > 80 AND NUMBA < 133 THEN LPRINT CHR$(20); CHR$(15); :WIDTH "lpt1:",132 ELSE WIDTH "lpt1:",80
920 IF NUMBA > 66 AND NUMBA < 81 THEN LPRINT CHR$(18); CHR$(20);
930 DBL.WID = 20
940 IF NUMBA > 40 AND NUMBA < 67 THEN LPRINT CHR$(15);: DBL.WID = 14
950 IF NUMBA < 41 THEN LPRINT CHR$(18);: DBL.WID = 14
960 PG.WID = NUMBA
970 GOTO 680
980 '  Display the current parameters.
990 PRINT: PRINT "Left margin at";L.MGN
1000 PRINT "Right margin at"; R.MGN
1010 PRINT MID$(STR$(B.MGN),2);" blank lines at page bottom"
1020 PRINT "Maximum page width is";PG.WID
1030 IF LN.SPA = 2 THEN PRINT "Double"; ELSE PRINT "Single";
1040 PRINT " line spacing"
1050 PRINT "Program name: ": IF FLNM$ = "" THEN GOSUB 2250 ELSE PRINT FLNM$
1060 PRINT "Header: ": IF HEADER$ = "" THEN GOSUB 2250 ELSE PRINT HEADER$
1070 PRINT
1080 GOTO 680
1090 '  Check parameter before actually trying to list the program.
1100 IF FLNM$ <> "" GOTO 1140
1110 INPUT "Program name: ",FLNM$
1120 IF LEFT$(FLNM$,1) = " " THEN FLNM$ = MID$(FLNM$,2): GOTO 1120
1130 ' Special processing for file name.
1140 P1% = 0
1150 P2% = 9999!
1160 IF MID$(FLNM$,1,1) <> "*" GOTO 1230
1170 N% = INSTR(FLNM$," ")
1180 N2% = INSTR(FLNM$,"-")
1190 IF N% < N2% THEN N2% = 0
1200 IF N2% = 0 OR N2%+1 = N% THEN NC% = N% - 2: P2% = 9999 ELSE NC% = N2%-2: P2% = VAL(MID$(FLNM$,N2%+1,N%-N2%-1))
1210 P1% = VAL(MID$(FLNM$,2,NC%))
1220 FLNM$ = MID$(FLNM$,N%+1)
1230 IF LEFT$(FLNM$,1) = " " THEN FLNM$ = MID$(FLNM$,2): GOTO 1230
1240 IF LEFT$(FLNM$,1) = "<" THEN CMF$ = MID$(FLNM$,2): CMFSW = 1 ELSE CMFSW = 0: GOTO 1330
1250 '  File to be listed are in a file.
1260 ON ERROR GOTO 2100
1270 OPEN CMF$ FOR INPUT AS #2
1280 ON ERROR GOTO 0
1290 IF EOF(2) GOTO 2290
1300 LINE INPUT #2, FLNM$
1310 PRINT "Processing file "; FLNM$
1320 ' Check a few more parameters.
1330 LN.LEN = R.MGN - L.MGN + 1
1340 N = INSTR(FLNM$,".")
1350 IF N = 0 THEN FLNM$ = FLNM$ + ".BAS"
1360 TTL$ = SPACE$(L.MGN) + FLNM$ + HEADER$ + ", " + TODAY$+ "  " + LEFT$(TIME$,5)
1370 J = LN.LEN - LEN(TTL$) - 10
1380 IF J => 1 GOTO 1420
1390 PRINT "You are trying to fit a"; LEN(TTL$)+10; " char title into a"; LN.LEN; "char line."
1400 PRINT "Make adjustments in the margins or header."
1410 GOTO 1450
1420 IF L.MGN<1 OR L.MGN>R.MGN-20 OR R.MGN<L.MGN+20 OR R.MGN>PG.WID THEN PRINT "Page width, Rt or Lt margin conflicts.";: GOTO 1450
1430 IF B.MGN>5 GOTO 1470
1440 PRINT "Bottom margin less than 5."
1450 BEEP: PRINT " CAN'T BEGIN. TRY AGAIN.": GOTO 990
1460 '  Open the disc file, complain if not possible to do it.
1470 ON ERROR GOTO 2100
1480 OPEN FLNM$ FOR INPUT AS #1
1490 ON ERROR GOTO 2070
1500 '  Title the first page with the header and the date.
1510 PG.NUM = 1: IF PG.NUM < P1% GOTO 1560
1520 LPRINT
1530 LPRINT CHR$(DBL.WID); TTL$
1540 LPRINT: LPRINT
1550 '  Format the header to appear at upper right on later pages.
1560 TTL$ = SPACE$(J)+TTL$
1570 '  Get the next BASIC line, quit if end of file.
1580 LN.CNT = 4
1590 IF EOF(1) GOTO 2270
1600 LINE INPUT #1, IN$: IF IN$ = "" GOTO 1600
1610 '  Right-justify the line number.
1620 IN$ = SPACE$(6-INSTR(IN$," "))+IN$
1630 ' Break the BASIC line into printer lines.
1640 FOR J = 0 TO 9
1650 '  Lets look to see if blank line needed before comment statement.
1660 IF MID$(IN$,7,1) = "'" THEN CCMT = 1 ELSE CCMT = 0: GOTO 1680
1670 IF PCMT <>1 THEN LN$(J) = "": J = J + 1
1680 PCMT = CCMT
1690 '  It's easy if the whole line fits at once.
1700 IF LEN(IN$) <= LN.LEN THEN LN$(J) = IN$: GOTO 1860
1710 '  Else, check for preferred breakpoints.
1720 FOR K = 0 TO IP
1730 SITE = 0: K$ = PREFER$(K)
1740 HI.SITE = SITE: IF SITE < 9 THEN SITE = 9
1750 SITE = INSTR(SITE+1,IN$,K$)
1760 IF SITE > 0 AND SITE <= LN.LEN GOTO 1740
1770 IF HI.SITE = 0 THEN NEXT K
1780 IF HI.SITE = 0 THEN HI.SITE = LN.LEN
1790 '  HI.SITE mow points to the rightmost, best breakpoint.
1800 '  Split the line there and indent all but the first one.
1810 LN$(J) = LEFT$(IN$,HI.SITE)
1820 IN$ = MID$(IN$,HI.SITE+1)
1830 IN$ = INDENT$+IN$
1840 NEXT J
1850 '  Will the pack of printer lines fit on this page?
1860 IF LN.CNT < PG.LEN - B.MGN - LN.SPA*(J+1) GOTO 1960
1870 '  No, so begin a new one, complete with header and page number.
1880 PG.NUM = PG.NUM + 1
1890 LN.CNT = 4
1900 IF PG.NUM > P2% GOTO 2270
1910 IF PG.NUM < P1% GOTO 2010
1920 LPRINT CHR$(12)
1930 LPRINT CHR$(DBL.WID); TTL$; ", PAGE";PG.NUM
1940 LPRINT: LN.CNT = 4
1950 '  Everything is guaranteed to fit. Print it all.
1960 IF PG.NUM < P1% GOTO 2010
1970 FOR L = 0 TO J: LPRINT CHR$(DBL.WID); TAB(L.MGN);LN$(L)
1980 IF LN.SPA = 2 THEN LPRINT
1990 NEXT L
2000 '  Update the line count for this page, and cycle again.
2010 LN.CNT = LN.CNT+(J+1)*LN.SPA
2020 GOTO 1590
2030 '  The operator-alert for an off-line printer:
2040 PRINT: BEEP: PRINT "The line printer isn't ready. Check it....": PRINT
2050 RESUME 360
2060 '  Printer device timeout error.
2070 IF ERR = 24 THEN RESUME
2080 GOTO 2190
2090 '  The operator-alert for a lack of a ready disc:
2100 IF ERR <> 53 GOTO 2150
2110 BEEP: PRINT "*** File ";
2120 IF ERL = 1270 THEN PRINT CMF$; ELSE PRINT FLNM$;
2130 PRINT " not found. Try again."
2140 IF CMFSW = 1 THEN RESUME 1290 ELSE RESUME 680
2150 IF ERR = 67 THEN BEEP: PRINT "*** Too many files.": RESUME 680
2160 IF ERR = 70 THEN BEEP: PRINT "*** Disc is write protected. Try again.": RESUME 680
2170 IF ERR = 71 THEN BEEP: PRINT "*** Check disc drive. It's not ready.": RESUME 1480
2180 IF ERR = 72 THEN BEEP: PRINT "*** Disc media error. Try again.": RESUME 680
2190 PRINT "ERR =";ERR; " ERL =";ERL; " Cause unknown.": BEEP: BEEP: STOP
2200 '  Subroutine to decode a numeric parameter input.
2210 NUMBA = VAL(MID$(Z$,15))
2220 IF NUMBA = 0 THEN BEEP: PRINT "<< NUMBER REQUIRED >>"
2230 RETURN
2240 '  Soubroutine to note the lack of a file name or header.
2250 COLOR 0,7: PRINT " NONE SPECIFIED ";: COLOR 7,0: PRINT: RETURN
2260 '  End of file on the file being listed.
2270 CLOSE #1:LPRINT CHR$(12): IF CMFSW = 1 GOTO 1290
2280 '  Orderly exit. reset the printer & F-Keys, then exit.
2290 LPRINT CHR$(18); CHR$(20): WIDTH "lpt1:",80: BEEP: CLS
2300 KEY OFF
2310 KEY 1,"List "
2320 KEY 2,"Run"+CHR$(13)
2330 KEY 3,"Load"+CHR$(34)
2340 KEY 4,"Save"+CHR$(34)
2350 KEY 5,"Edit "
2360 KEY 6,CHR$(34)+",a"
2370 KEY 7,"Lprint "
2380 KEY 8,"Cls"+CHR$(13)
2390 KEY 9,"System"+CHR$(13)
2400 KEY 10,"Screen"+CHR$(13)
2410 KEY ON
2420 ON ERROR GOTO 0
2430 END
EY 8,"Cls"+CHR$(13)
2390 KEY 9,"System"+CHR$(13)
2400 KEY 10,"Screen"+CHR$(13)
2410