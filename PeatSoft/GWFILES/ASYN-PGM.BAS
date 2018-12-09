50 REM * PUBLIC DOMAIN SOFTWARE*
60 REM THIS COMMUNICATIONS PROGRAM IS ADAPTED FROM AN EXAMPLE IN THE
70 REM IBM BASIC MANUAL pp F-4,F-5. IT CAN BE USED TO DOWNLOAD PROGRAMS.
100 'COM3.BAS VER 1.7 C.W. BRANDON 01/27/1982
105 'Adapter from example pgm in IBM BASIC Manual pp F-4
120 'set screen to monochrome and width to 80
130 SCREEN 0,0: WIDTH 80
140 'turn off SOFT KEY disply, CLS and CLOSE any OPEN files
150 KEY OFF: CLS: CLOSE
155 FOR I= 1 TO 10:KEY I,"":NEXT I
160 'Define all numeric variables as integer for speed
170 DEFINT A-Z
180 'define true and false
190 FALSE = 0: TRUE = NOT FALSE
191 ON ERROR GOTO 9000
195 ECH$="N"  'set for full duplex mode
196 GOSUB 12000
200 'open comm to file #1 as 300 baud,even parity 7 bit, 1 stop
210 OPEN "COM1:300,E,7,1" AS #1
215 'open file 3 for disk output
216 OPEN "O",#3,"OUTFILE.TXT"
220 'open screen as file 2
230 OPEN "SCRN:" FOR OUTPUT AS #2
235 PRINT "Ready to operate"
240 'turn on cursor
250 LOCATE,,1
260 DISK = FALSE
280 'get keyboard input and examine it
290 B$ = INKEY$:IF B$ = "" THEN GOTO 310
293 IF LEN(B$) > 1 THEN GOTO 11000 ELSE IF B$ = CHR$(8) THEN LOCATE ,POS(0)-1,1:PRINT " ";:LOCATE ,POS(0)-1,1
295 PRINT #1,B$;:IF ECH$="Y" OR ECH$="y" THEN PRINT #2,B$;
300 'if no chars in comm buffer, check key in
310 IF EOF(1) THEN 290
320 'read contents of comm buffer
330 A$ = INPUT$(LOC(1),#1)
340 'edit the input buffer
350 FOR I = 1 TO LEN(A$)
353 NCHAR = ASC(MID$(A$,I,1))
355  IF (NCHAR<31 AND NCHAR<>13 AND NCHAR<>10) OR NCHAR=127 THEN GOTO 370
357  IF DISK = TRUE THEN PRINT #3,CHR$(NCHAR);
360  IF NCHAR = 10 THEN NCHAR = 32
365 PRINT CHR$(NCHAR);
370 NEXT I
380 'check for more input
395 IF LOC(1) > 0 THEN GOTO 330
400 'if not check for keyboard input again
410 GOTO 290
9000 'error handling routine
9020 IF ERR = 68 THEN LOCATE 1,1,1:PRINT "This program requires the ASYNC COMM ADAPTER.":END
9030 IFF ERR = 24 THEN LOCATE 1,1,1:PRINT "A DEVICE TIMEOUT error has occurred. Check modem and press ENTER when ready.";
9031 DV$=INKEY$:IF DV$ = "" THEN GOTO 9031
9032 IF LEN(DV$) < 2 THEN RESUME 100
9035 IF ASC(MID$(DV$,2,1)) = 68 THEN GOTO 10000 ELSE RESUME 100
9040 IF ERR = 61 THEN PRINT:COLOR 0,7:PRINT "*** disk full -- file closed ***";:COLOR 7,0:PRINT:DISK = FALSE:DF$=" ":GOSUB 13000:RESUME NEXT
9050 RESUME
10000 'exit routine
10010 CLOSE
10020 SYSTEM
11000 'function key routine
11020 FK = ASC(MID$(B$,2,1))
11030 IF FK = 68 THEN GOTO 10000
11040 IF FK = 59 THEN DISK = TRUE:DF$="D":GOSUB 13000
11050 IF FK = 60 THEN DISK = FALSE:DF$=" ":GOSUB 13000
11060 GOTO 310
12000 'initialization sequence
12015 CLS
12020 LOCATE 1,1,1
12030 PRINT TAB(17) "TERMINAL PROGRAM WITH DISK SAVE OPTION Ver. 1.7"
12040 PRINT:PRINT
12050 PRINT "To begin saving received data to disk - press F1"
12060 PRINT
12070 PRINT "To stop saving received data to disk - press F2"
12080 PRINT
12090 PRINT "To end program and return to DOS    - press F10
12100 PRINT:PRINT
12103 PRINT "A file will be opened to save received"
12104 PRINT "data under the name 'OUTFILE.TXT."
12105 PRINT:PRINT
12110 PRINT "Press ENTER to begin.";
12112 DV$=INKEY$:IF DV$="" THEN GOTO 12112
12115 IF LEN(DV$) < 2 THEN GOTO 12120
12117 IF ASC(MID$(DV$,2,1)) = 68 THEN GOTO 10000 ELSE GOTO 12120
12120 CLS
12130 LOCATE 25,1,0:COLOR 0,7:PRINT TAB(5)"F1 = SAVE TO DISK    F2 = STOP SAVE TO DISK    F10 = QUIT PROGRAM  ";:COLOR 7,0
12140 LOCATE 1,1,1
12150 RETURN
13000 'disk save signal on screen routine
13020 RC = CSRLIN 'record current line
13030 CC = POS(0) 'record current column
13040 LOCATE 25,78
13050 PRINT DF$
13060 LOCATE RC,CC 'restore postion of cursor
13070 RETURN
