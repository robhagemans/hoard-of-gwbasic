100 REM
110 REM           SIMPLE SIMON TERMINAL PROGRAM
120 REM        UPDATED AND IMPROVED, JANUARY, 1988
130 REM                 BY RANDY HAWKINS
140 REM
145 COMMON RH: IF RH=0 THEN SYSTEM
150 CLEAR: SCREEN 0: WIDTH 80: COLOR 14,0: KEY OFF
160 CLS: GOSUB 610: LOCATE 1,1,1: ON ERROR GOTO 1120
170 '
180 'Open COM at Proper Baud Rate and Protocol
190 '
200 PRINT "Select Baud Rate and COM Port:": PRINT
210 PRINT "  1 -- Communications Port #1 (COM1) at 300 Baud"
220 PRINT "  2 -- Communications Port #2 (COM2) at 300 Baud"
230 PRINT "  3 -- Communications Port #1 (COM1) at 1200 Baud"
240 PRINT "  4 -- Communications Port #2 (COM2) at 1200 Baud"
250 PRINT: PRINT"Type the <NUMBER> of your selection --> ";
260 B$ = INPUT$(1): IF B$<"1" OR B$>"4" THEN 260 ELSE PRINT B$
270 IF B$ = "1" THEN B$ = "1:300"
280 IF B$ = "2" THEN B$ = "2:300"
290 IF B$ = "3" THEN B$ = "1:1200"
300 IF B$ = "4" THEN B$ = "2:1200"
310 PRINT: PRINT "Select Communications Protocol:": PRINT
320 PRINT "  1 -- 7 data bits, 1 stop bit, Even Parity"
330 PRINT "  2 -- 8 data bits, 1 stop bit, No Parity"
340 PRINT: PRINT "Type the <NUMBER> of your selection --> ";
350 P$ = INPUT$(1): IF P$<"1" OR P$>"2" THEN 350 ELSE PRINT P$
360 IF P$ = "1" THEN FF = 127 ELSE FF = 255
370 OPEN "COM" + B$ + ",N,8,1,CS,DS" AS #1
380 PRINT: PRINT "Ready to Initiate Communications..."
390 PRINT: INPUT "Number to Dial"; D$
400 PRINT #1, "ATDT"; D$: PRINT: GOSUB 530
410 '
420 'Check Keyboard, Transmit, and Check Receive Buffer
430 '
440 A$ = INKEY$
445 IF A$ <> "" THEN PRINT #1, A$;
450 IF LOC(1) = 0 THEN 440
455 IF LOC(1) > 32 THEN PRINT #1, CHR$(19);: P = 1
460 B$ = INPUT$(LOC(1),#1)
465 FOR A=1 TO LEN(B$): C$ = MID$(B$,A,1)
475 IF C$ = CHR$(8) THEN PRINT CHR$(29);CHR$(32);CHR$(29);
480 IF C$ <> CHR$(8) THEN PRINT CHR$(ASC(C$) AND FF);
485 NEXT A: IF P THEN PRINT #1, CHR$(17);
490 P = 0: GOTO 450
500 '
510 'Set Up Function Keys
520 '
530 KEY (1) ON
540 KEY (10) ON
550 ON KEY (1) GOSUB 680
560 ON KEY (10) GOSUB 1080
570 RETURN
580 '
590 'Message on Bottom of Screen
600 '
610 VIEW PRINT 1 TO 25: LOCATE 25,1:COLOR 15,1
620 PRINT "SIMON Terminal Program";TAB(29);"F1=XMODEM Receive";
630 PRINT TAB(52);"F10=Close Communication Port";
640 COLOR 14,0: VIEW PRINT 1 TO 23: LOCATE 23,1: RETURN
650 '
660 'XMODEM Receive Subroutine ... Get File Name
670 '
680 PRINT: INPUT "Store Data in What File Name"; F$
690 IF F$="" THEN PRINT #1, CHR$(24);: GOTO 1030
700 PRINT "Press CTRL-C to Abort Transmission"
710 KEY (1) OFF: KEY (10) OFF: RN=1: VIEW PRINT 1 TO 25
720 '
730 'Open File to Receive Data
740 '
750 OPEN F$ AS #2 LEN=128: FIELD #2, 128 AS PART$: COLOR 15,1
760 LOCATE 25,1,0: PRINT SPC(31);"One Moment Please";SPC(31);
770 PRINT #1, CHR$(21);: A=TIMER
780 WHILE (TIMER-A) < 5: WEND: IF EOF(1) THEN 770
790 '
800 'Get First Byte -- Another Block or Quit?
810 '
820 IF EOF(1) THEN 820 ELSE B$=INPUT$(1,#1)
830 IF B$=CHR$(4) THEN 1010 ELSE IF B$ <> CHR$(1) THEN 820
840 IF LOC(1) < 131 THEN 840 ELSE BLOCK$=INPUT$(131,#1)
850 '
860 'Check for Abort, Bad Block Number, and Bad Checksum
870 '
880 IF INKEY$=CHR$(3) THEN PRINT #1, CHR$(24);: GOTO 1010
890 IF ASC(MID$(BLOCK$,1,1)) + ASC(MID$(BLOCK$,2,1)) <> 255 THEN 770
900 CS=0: FOR A=3 TO 130: CS=(CS+ASC(MID$(BLOCK$,A,1))) AND 255
910 NEXT A: IF CS <> ASC(MID$(BLOCK$,131,1)) THEN 770
920 '
930 'Block OK ... Write to File
940 '
950 LSET PART$=MID$(BLOCK$,3,128): PUT #2, RN: LOCATE 25,20
960 PRINT "Total Number of Bytes Received = "; RN*128;
970 RN=RN+1: PRINT #1, CHR$(6);: GOTO 820
980 '
990 'All Done ... Return to Main Section
1000 '
1010 PRINT #1, CHR$(6);: CLOSE #2: GOSUB 610: LOCATE 23,1,1
1020 PRINT: PRINT "Transmission Complete"
1030 FOR A=1 TO 3: BEEP: BEEP: FOR B=1 TO 500: NEXT B,A
1040 GOSUB 530: RETURN
1050 '
1060 'Close Buffer and Exit
1070 '
1080 CLOSE #1: VIEW PRINT 1 TO 25: CLS
1085 LOCATE 12,28: PRINT "One moment please...": RUN "menu"
1090 '
1100 'Error Trap
1110 '
1120 PRINT "Error Code"; ERR; "in line"; ERL
1130 RESUME NEXT
