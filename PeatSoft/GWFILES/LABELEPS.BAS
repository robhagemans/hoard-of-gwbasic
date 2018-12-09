1 '  (PC)^3 Software Submission LABELEPS authored on November 8, 1982 by
2 '
3 '  Michael Csontos, 3228 Livonia Center Road, Lima, New York 14485.
4 '
10 WIDTH 80:SCREEN 0,0,0:COLOR 7,0,0:CLS
20 PRINT:PRINT " This is an extension of a program from (PC)^3 software
30 PRINT:PRINT "library disk VOL 2.16.  The original program was designed
40 PRINT:PRINT "to printing of lables from the screen to a IDS-225 printer.
50 PRINT:PRINT " I have modified it for the EPSON printer, and extended it
60 PRINT:PRINT "so the address can be edited either before or after some
70 PRINT:PRINT "labels have been printed.  This may be useful if you want
80 PRINT:PRINT "a large number of labels from only a few addresses or other
90 PRINT:PRINT "information.
100 PRINT:PRINT " By playing with this program you will also learn some of the
110 PRINT:PRINT "strange ways the INPUT command works with the screen RAM!
120 PRINT:PRINT:PRINT "Press any key to continue."
130 X$=INKEY$:IF X$="" THEN 130
140 REM LABEL ROUTINE FOR IDS-225 PRINTER   V 7.82 BY NORMAN A. ADAMS
150 CLS:KEY OFF
160 REM Label print routine
170 FOR J = 0 TO 4:READ IN$(J):NEXT J
180 DATA Name,Address,City,State,Zip
190 FOR K = 0 TO 4:PRINT IN$(K)"? ";:LINE INPUT A$(K)
200 NEXT K
210 PRINT:PRINT "The label will appear as follows:"
220 PRINT
230 PRINT STRING$(79," ");:LOCATE ,1:PRINT TAB(2) A$(0)
240 PRINT STRING$(79," ");:LOCATE ,1:PRINT TAB(2) A$(1)
250 PRINT STRING$(79," ");:LOCATE ,1:PRINT TAB(2) A$(2);CHR$(44);SPC(1) A$(3) SPC(2) A$(4)
260 PRINT:PRINT STRING$(79," ");:LOCATE ,1:INPUT "Send label to printer? (enter y or n) ";Z$
270 IF Z$="y" OR Z$="Y" THEN 280 ELSE LOCATE 25,1:PRINT "You may reenter above inputs by pressing <End> then <enter>.";:LOCATE 1,1:RESTORE:GOTO 170
280 LIN=CSRLIN:LOCATE 25,1:PRINT STRING$(79," ");:LOCATE LIN,1
290 PRINT:PRINT STRING$(79," ");:LOCATE ,1:INPUT "Enter number of labels to be printed: ";N
300 FOR T = 1 TO N
310 LPRINT CHR$(27)"F";          'emphacized mode off
320 LPRINT CHR$(15);             'compressed on
330 LPRINT CHR$(27)"G";          'double strike
340 LPRINT CHR$(27)"W"CHR$(1);   'double width
350 LPRINT CHR$(27)"A"CHR$(18);  '18/72" lines
360 LPRINT
370 LPRINT A$(0)
380 LPRINT A$(1)
390 LPRINT A$(2)", "A$(3)"  "A$(4)
400 LPRINT
410 LPRINT
420 NEXT T
430 PRINT:PRINT STRING$(79," ");:LOCATE ,1:INPUT "More labels";Z$
440 IF Z$="y" OR Z$="Y" THEN LOCATE CSRLIN-4:GOTO 280
450 PRINT:PRINT STRING$(79," ");:LOCATE ,1:INPUT "Another label";Z$
460 IF Z$="y" OR Z$="Y" THEN LOCATE 25,1:PRINT "You may reenter above inputs by pressing <End> then <enter>.";:LOCATE 1,1:RESTORE:GOTO 170
470 KEY ON:CLS:END
480 ' SAVE"LABELeps.BAS",A
er above inputs by pressing <End> then <enter>.";:LOCATE 1,1:RESTORE:GOTO 170
470 KEY ON:CLS:END
480 ' SAVE"LABELeps.BA