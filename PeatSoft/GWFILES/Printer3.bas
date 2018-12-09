10 'printer
20 'Program to deal with the IBM 80 cps printer (Epson MX80)
30 'Functions:  Setup printer modes
40 '            Print paginated listings of text files
50 '            Issue controls to printer
60 'Author:     Will Fastie
70 'Created:    12 Dec 1981
80 'Modified:   Bill Linhart    4-3-82, 7-13-82
90 'Source:     printer.bas
100 'NOTE:      Operates on current display device, current mode
110 '************* Constants ***************************
120 PROG$ = "PRINTER v1.03 7-13-82"
130 ESC$ = CHR$(27)
135 QUO$ = CHR$(34)
140 CLRLPT$ = CHR$(18) + CHR$(20) + ESC$ + "F" + ESC$ + "H"
150 PWIDTH = 80
160 '************* Initial Menu ************************
170 KEY OFF: CLS: SCREEN 0,0,0
180 PRINT PROG$: PRINT
190 PRINT "The printer must be ONLINE to "
200 PRINT "perform these functions."
210 PRINT
220 PRINT "Functions:";
230 PRINT TAB(13) ;"P - Print a text file"
240 PRINT TAB(13) ;"S - Setup printer"
250 PRINT TAB(13) ;"R - Reset printer"
260 PRINT TAB(13) ;"T - Advance paper to top"
270 PRINT TAB(13) ;"Q - Quit (return to DOS)"
280 PRINT TAB(13) ;"X - Exit to Basic"
290 MENSEL = CSRLIN + 1
300 PLOC = MENSEL: GOSUB 1270
310 INPUT "   Enter function:  ",X$: IF X$ = "" THEN BEEP: GOTO 300
320 GOSUB 1210
330 X = INSTR("PSRTQX",X$): IF X = 0 THEN BEEP: GOTO 300
340 ON X GOSUB 360, 770, 1080, 1120,1150, 1180
350 GOTO 160
360 '**************** Print paginated listing ********************
370 CLS
380 PRINT PROG$: PRINT
390 PRINT "Adjust the paper in the printer so that"
400 PRINT "the perforation is at the paper bail."
410 PRINT "Put the printer ONLINE.
420 PRINT
430 PRINT "Files MUST be ASCII text files."
434 PRINT "Create ASCII files by using..."      '7-13-82
435 PRINT "   SAVE" QUO$ "filename.ext" QUO$ ",A"  '7-13-82
440 PRINT
450 PRINT "No filename extension is assumed,"
460 PRINT "so enter the filename exactly."
470 PRINT "Depress ENTER key to return to menu."
480 PRINT "Press ESC key to abort printing."
490 PRINT
500 INPUT "File to print:  ", X$
510 IF LEN(X$) = 0 THEN RETURN
520 GOSUB 1210
530 WIDTH "lpt1:", PWIDTH
540 OPEN X$ FOR INPUT AS 1
550 PAGENR = 0
560 LINENR = 1
570 IF EOF (1) THEN 650
580 LINE INPUT #1, L$
590 IF LINENR = 1 THEN GOSUB 700
600 LPRINT L$
610 IF INKEY$ = ESC$ THEN 650
620 LINENR = LINENR + INT((LEN(L$)+79)/80)
630 IF LINENR > 54 THEN LINENR = 1
640 GOTO 570
650 '******************** Close file and return **********************
660 CLOSE
670 GOSUB 1120
680 GOTO 500
690 '******************** Subroutine to print page heading ***********
700 IF PAGENR <> 0 THEN LPRINT  CHR$(12);
710 PAGENR = PAGENR + 1
720 LPRINT: LPRINT
730 LPRINT CHR$(14); X$; " "; CHR$(20);
740 LPRINT "-- printed on ";DATE$;" at "; TIME$; " -- Page";PAGENR
750 LPRINT : LPRINT
760 RETURN
770 '******************** Setup Printer ******************************
780 CLS: PRINT PROG$
790 PRINT : PRINT  "Printer enhancements are:"
800 PRINT
810 PRINT "    DW - Double Width"
820 PRINT "    C  - Compressed Print"
830 PRINT "    E  - Emphasized Print"
840 PRINT "    DS - Double Strike"
850 PRINT
860 PRINT "Enter enhancements separated by spaces."
870 PRINT
880 PRINT "Examples:"
890 PRINT
900 PRINT "  C E    - Illegal"
910 PRINT "         - 10 cpi, normal"
920 PRINT "  E      - 10 cpi, bold"
930 PRINT "  DS C   - 16.5 cpi, double"
940 PRINT
950 INPUT "      Enter enhancements:  ",O$
960 X$=O$: GOSUB 1210: O$=X$
970 LPRINT CLRLPT$;
980 IF INSTR(O$,"DW") THEN LPRINT CHR$(14);
990 IF INSTR(O$,"C") THEN LPRINT CHR$(15);
1000 IF INSTR(O$,"E") THEN LPRINT ESC$;"E";
1010 IF INSTR(O$,"DS") THEN LPRINT EXC$;"G";
1020 PRINT
1030 PLOC = CSRLIN
1040 GOSUB 1270
1050 INPUT "Enter desired line width:  "; PWIDTH
1060 IF 1 > PWIDTH  OR PWIDTH > 132 THEN 1040
1070 RETURN
1080 '************************ Reset printer to defaults ****************
1090 LPRINT CLRLPT$;
1100 PWIDTH = 80
1110 RETURN
1120 '******************* Form feed to printer **************************
1130 LPRINT CHR$(12);
1140 RETURN
1150 '******************* Return to DOS *********************************
1160 CLS
1170 SYSTEM
1180 '******************* Exit to Basic *********************************
1190 CLS
1200 END
1210 '******************* Subroutine to UPPERFY a string (in X$) ********
1220 FOR X = 1 TO LEN(X$)
1230   XC$ = MID$(X$,X,1)
1240   IF "a" <= XC$ AND XC$ <= "z" THEN MID$(X$,X,1) = CHR$(ASC(XC$) - 32)
1250 NEXT X
1260 RETURN
1270 '*********** Subroutine to position at specified line and clear it
1280 LOCATE PLOC,1
1290 PRINT STRING$(40," ")'
1300 LOCATE PLOC,1
1310 RETURN
1320 '******************* Subroutine to wait for any keystroke **********
1330 PRINT "Depress any key to continue... ";
1340 GOSUB 1360
1350 RETURN
1360 '******************* Subroutine to get a keystroke into x$ *********
1370 X$ = INKEY$
1380 IF X$ = "" THEN 1370
1390 RETURN
******************* Subroutine to get a keystroke into x$ *********
137