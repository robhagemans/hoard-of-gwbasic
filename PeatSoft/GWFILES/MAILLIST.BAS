100 '   MAILLIST        by Bob Noble
110 '                   IBM Personal Computer BASIC
120 '
130 '           Submitted to the Philadelphia IBM PC Users Club 6-30-82
140 '
150 '           This program creates, appends, edits, displays, and deletes
160 '           variable length records of 10 variable length fields in
170 '           "Mailling List" type files named by the user.
180 '
190 '           The biggest deficiency is the lack of an LPRINT routine for
200 '           printing hard copy. This is because I don't yet have a print-
210 '           er myself. I leave the addition of this function to other
220 '           programers, or until I get a printer.
230 '
240 '   Variables Used
250 '     FILE$ = Name of data file used
260 '     L$ = Name (Last Name of person)
270 '     F$ = First Name of person
280 '     A$ = 1st Next Line
290 '     B$ = 2nd Next Line (optional)
300 '     D$ = 3rd Next Line (optional)
310 '     E$ = 4th Next Line (optional)
320 '     G$ = 5th Next Line (optional)
330 '     C$ = City
340 '     S$ = State
350 '     Z$ = Zip Code
360 '
370 CLS: KEY OFF: LINE INPUT "Enter name of file to be used: ", FILE$
380 '
390 '   Main menu
400 '
410 CLS: PRINT "MAILLIST * * * MAIN MENU     File Open: "; FILE$
420 PRINT: PRINT "  1. Add Record(s)"
430 PRINT "  2. Edit Record(s)"
440 PRINT "  3. Display Record(s)"
450 PRINT "  4. Delete Record(s)"
460 PRINT "  5. Task Completed - Return to BASIC"
470 PRINT: INPUT "Make Selection (1-5): ", Q
480 IF Q=5 THEN CLOSE: CLS: KEY ON: END
490 ON Q GOTO 520, 990, 760, 1220
500 '
510 ' * * * * * Data Entry Module
520 OPEN FILE$ FOR APPEND AS #1
530 CLS: PRINT "MAILLIST *** DATA ENTRY     File Open: "; FILE$
540 LOCATE 19,10: PRINT "Note: If name is not a person, enter as last name and
550 PRINT "               press <ENTER> when `first name' prompt appears."
560 LOCATE 3,1: LINE INPUT "                   Last Name: ", L$
570 LINE INPUT "                  First Name: ", F$
580 LOCATE 22,10: PRINT "Note: Press `%' at `Next Line' prompt when ready to enter `city'."
590 LOCATE 5,1: LINE INPUT "                   Next Line: ", A$
600 LINE INPUT "                   Next Line: ", B$
610 IF B$ = "%" THEN D$ = "%": E$ = "%": G$ = "%": GOTO 670
620 LINE INPUT "                   Next Line: ", D$
630 IF D$ = "%" THEN E$ = "%": G$ = "%": GOTO 670
640 LINE INPUT "                   Next Line: ", E$
650 IF E$ = "%" THEN G$ = "%": GOTO 670
660 LINE INPUT "                   Next Line: ", G$
670 LINE INPUT "                        City: ", C$
680 LINE INPUT "                       State: ", S$
690 LINE INPUT "                         Zip: ", Z$
700 WRITE#1, L$,F$,A$,B$,D$,E$,G$,C$,S$,Z$
710 '
720 PRINT: LINE INPUT "Do you want to enter more data? (Y/N) ", Q$
730 IF LEFT$(Q$,1)="Y" OR LEFT$(Q$,1)="y" THEN 530 ELSE CLOSE: GOTO 410
740 '
750 ' * * * * * Display File
760 CLS: OPEN "I", 1, FILE$
770 PRINT "MAILLIST * * * Display Routine     File Open: "; FILE$
780 PRINT: PRINT "1. Display one record at a time."
790 PRINT "2. Scroll file."
800 PRINT: LINE INPUT "Make Selection (1 or 2): ", Q$
810 CLS
820 LOCATE 25: PRINT "Press <ENTER> to continue.": LOCATE 1
830 IF EOF(1) THEN 950
840 INPUT#1, L$,F$,A$,B$,D$,E$,G$,C$,S$,Z$
850 IF F$="" THEN PRINT L$: GOTO 870
860 PRINT F$ + " " + L$
870 PRINT A$
880 IF B$ <> "%" THEN PRINT B$
890 IF D$ <> "%" THEN PRINT D$
900 IF E$ <> "%" THEN PRINT E$
910 IF G$ <> "%" THEN PRINT G$
920 PRINT C$ + ", " + S$ + " " + Z$
930 IF Q$="2" THEN PRINT: GOTO 830
940 INPUT "",Q$: GOTO 830
950 PRINT "END OF FILE ": LOCATE 25,18: INPUT "return to main menu ",Q$
960 CLOSE: GOTO 410
970 '
980 ' * * * * * Edit File
990 CLS: OPEN "I", 1, FILE$
1000 OPEN "O", 2, "TEMPFIL"
1010 PRINT "MAILLIST * * * Edit Routine     File Open: "; FILE$
1020 PRINT: LINE INPUT "Enter last name of record to edit: ", L$
1030 IF LEN(L$) = 0 THEN PRINT "Something must be entered.": GOTO 1020
1040 '
1050 GOSUB 1630: ' * * * Search Subroutine
1060 '
1070 CLS: PRINT "MAILLIST * * * Edit Routine     File Open: "; FILE$
1080 GOSUB 1540: ' * * * Display record for field to edit
1090 PRINT: INPUT "Enter selection (0-10): ", Q
1100 IF Q=0 THEN WRITE #2, L1$,F$,A$,B$,D$,E$,G$,C$,S$,Z$: GOTO 1140
1110 LOCATE 17: PRINT "Make changes and move cursor to end of line, then press <ENTER>.": LOCATE 1
1120 ON Q GOSUB 1420,1430,1440,1450,1460,1470,1480,1490,1500,1510
1130 '
1140 GOSUB 1720: ' * * Subroutine to read-write remainder of file to TEMPFIL
1150 '
1160 GOSUB 1770: ' * Subroutine to initialize and copy TEMPFIL back to file
1170 '
1180 ' * * * * * Querry user for more editing
1190 LOCATE 19: LINE INPUT "Do you want to do more editing? (Y/N) ", Q$
1200 IF LEFT$(Q$,1)="Y" OR LEFT$(Q$,1)="y" THEN 990 ELSE 410
1210 '
1220 ' * * * * * Delete Record Routine
1230 CLS: PRINT "MAILLIST * * * Delete Record Routine     File Open: "; FILE$
1240 PRINT: LINE INPUT "Enter last name of record to delete: ", L$
1250 OPEN "I", 1, FILE$: OPEN "O", 2, "TEMPFIL"
1260 '
1270 GOSUB 1630: ' * * * Search subroutine
1280 '
1290 CLS: PRINT "MAILLIST * * * Delete Record Routine     File Open: "; FILE$
1300 GOSUB 1540: ' * Subroutine to display record
1310 PRINT: LINE INPUT "Enter `0' to delete record, or `1' to save: ", Q$
1320 IF Q$ = "0" THEN GOSUB 1720: ' * * * Write rest of FILE$ to TEMPFIL
1330 IF Q$="1" THEN WRITE #2,L$,F$,A$,B$,D$,E$,G$,C$,S$,Z$: GOSUB 1720: 'ditto
1340 GOSUB 1770: ' * * * Write TEMPFIL back to FILE$
1350 '
1360 ' * * * * * Querry user for more deletions
1370 PRINT: LINE INPUT "Do you want to delete another? ", Q$
1380 IF LEFT$(Q$,1) = "Y" OR LEFT$(Q$,1) = "y" THEN 1230 ELSE 410
1390 '
1400 ' * * * * * Subroutines to edit fields
1410 '
1420 LOCATE 4,5: LINE INPUT L$: GOSUB 1600: RETURN: ' *** Last Name
1430 LOCATE 5,5: LINE INPUT F$: GOSUB 1600: RETURN: ' *** First Name
1440 LOCATE 6,5: LINE INPUT A$: GOSUB 1600: RETURN: ' *** 1st `Next Line'
1450 LOCATE 7,5: LINE INPUT B$: GOSUB 1600: RETURN: ' *** 2nd `Next Line'
1460 LOCATE 8,5: LINE INPUT D$: GOSUB 1600: RETURN: ' *** 3rd `Next Line'
1470 LOCATE 9,5: LINE INPUT E$: GOSUB 1600: RETURN: ' *** 4th `Next Line'
1480 LOCATE 10,5: LINE INPUT G$: GOSUB 1600: RETURN: ' *** 5th `Next Line'
1490 LOCATE 11,5: LINE INPUT C$: GOSUB 1600: RETURN: ' *** City
1500 LOCATE 12,5: LINE INPUT S$: GOSUB 1600: RETURN: ' *** State
1510 LOCATE 13,5: LINE INPUT Q$: GOSUB 1600: RETURN: ' *** Zip Code
1520 '
1530 ' * * * * * Subroutine to Display Field Menu
1540 PRINT: PRINT " 0 = No Changes"
1550 PRINT " 1. "; L$: PRINT " 2. "; F$: PRINT " 3. "; A$: PRINT " 4. "; B$
1560 PRINT " 5. "; D$: PRINT " 6. "; E$: PRINT " 7. "; G$: PRINT " 8. "; C$
1570 PRINT " 9. "; S$: PRINT "10. "; Z$
1580 '
1590 ' * * * * * Subroutine to write edited record to file
1600 WRITE #2, L$, F$, A$, B$, D$, E$, G$, C$, S$, Z$: RETURN
1610 '
1620 ' * * * * * File Search Subroutine
1630 IF EOF(1) THEN 1670
1640 INPUT #1, L1$, F$, A$, B$, D$, E$, G$, C$, S$, Z$
1650 IF L$ = L1$ THEN RETURN
1660 WRITE #2, L1$, F$, A$, B$, D$, E$, G$, C$, S$, Z$: GOTO 1630
1670 PRINT: PRINT "ERROR Message. "; V$; " not found in "; FILE$
1680 PRINT: LINE INPUT "Press <ENTER> to return to main menu. ", Q$
1690 CLOSE: GOTO 410
1700 '
1710 ' * * * * * Subroutine to read-write remainder of file to TEMPFIL
1720 IF EOF(1) THEN CLOSE: RETURN
1730 INPUT #1, L$, F$, A$, B$, D$, E$, G$, C$, S$, Z$
1740 WRITE #2, L$, F$, A$, B$, D$, E$, G$, C$, S$, Z$: GOTO 1720
1750 '
1760 ' * * * * * Subrountine to initialize and copy TEMPFIL back to file
1770 OPEN "I", 1, "TEMPFIL": OPEN "O", 2, FILE$
1780 IF EOF(1) THEN CLOSE: KILL "TEMPFIL": RETURN
1790 INPUT #1, L$, F$, A$, B$, D$, E$, G$, C$, S$, Z$
1800 WRITE #2, L$, F$, A$, B$, D$, E$, G$, C$, S$, Z$: GOTO 1780
TURN
1790 INPUT #1, L$, F$, A$, B$, D$, E$, G$, C$, S$, Z$
1800 WRITE #2, L$, F$, A$, B$, 