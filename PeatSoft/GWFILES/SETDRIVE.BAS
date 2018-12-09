10 ' ********************************************************************
20 ' *  PROGRAM SETDRIVE.BAS                                            *
30 ' *                                                                  *
40 ' ********************************************************************
50 '
60 ' PROGRAM NAME: SETDRIVE.BAS    WRITTEN 17 AUG 1983    REV 13 SEP 1983
70 '
75 CLS
80 OPEN "A:DRIVE.DTA" FOR OUTPUT AS #1
90 PRINT "IDENTIFY DRIVE FOR DATA INPUT"
100 INPUT "SELECT (A/B)  ",DRIVE$
110 IF DRIVE$ <> "A" AND DRIVE$ <> "a" AND DRIVE$ <> "B" AND DRIVE$ <> "b" THEN BEEP: GOTO 90
130 PRINT "DRIVE SELECTED IS ", DRIVE$
140 INPUT "SELECTION OK? (Y/N) ",OK$
150 IF OK$ = "Y" OR OK$ = "y" THEN GOTO 200
160 GOTO 90
170 '
200 ' *******************************************************************
210 PRINT "IDENTIFY PRINTER USED - E FOR EPSON, I FOR IBM"
220 INPUT "INPUT PRINTER CODE SELECTED (E/I) ", PRNT$
230 IF PRNT$ <> "E" AND PRNT$ <> "e" AND PRNT$ <> "I" AND PRNT$ <> "i" THEN BEEP: GOTO 210
240 PRINT "PRINTER SELECTION IS  ", PRNT$
250 INPUT "INPUT SELECTION OK? (Y/N) ", OK$
260 IF OK$ = "Y" OR OK$ = "y" THEN GOTO 300
270 GOTO 210
280 '
290 ' *******************************************************************
300 WRITE #1, DRIVE$,PRNT$
310 PRINT "SELECTIONS RECORDED - PROGRAM ENDS"
320 CLOSE #1
330 END
**************************
300 WRITE #1, DRIVE