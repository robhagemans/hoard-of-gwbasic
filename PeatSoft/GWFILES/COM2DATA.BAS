1000 '******************************************
1010 '* PROGRAM COM2DATA  Version 1.0          *
1020 '*                                        *
1030 '* (1983) by David Whitman                *
1040 '*                                        *
1050 '* Reads a .COM format file and produces  *
1060 '* a file of DATA statements, which may   *
1070 '* be merged into a BASIC program.        *
1080 '******************************************
1090 '
1095 'print title page
1100   GOSUB 5000
1110 '
1120 'set up error trapping, declare all integers
1130  ON ERROR GOTO 6000: DEFINT A-Z
1140 '
1150 'open input file
1160   LOCATE 1,1: GOSUB 4000: INPUT "Name of COM file? [.com] ",C$
1170   IF C$ = "" THEN BEEP: GOTO 1160
1180   'if no extension, add default
1190     IF INSTR(C$,".") = 0                                                               THEN IN$ = C$ + ".com"                                                          ELSE IN$ = C$: C$ = LEFT$(C$,INSTR(C$,".")-1)
1191   'test if file exists
1192     OPEN IN$ FOR INPUT AS #1: CLOSE #1
1193   'and open it
1200     OPEN IN$ AS #1 LEN=1: FIELD #1, 1 AS BYTE$
1210 '
1220 'open output file
1230   LOCATE 3,1: GOSUB 4000: PRINT "Name for DATA file? ["; C$; ".dat] ";
1240   INPUT "", D$
1250   'default to input name with extension .dat
1260      IF D$ = "" THEN D$ = C$ + ".dat"
1270   OPEN D$ FOR OUTPUT AS #2
1280 '
1290 'get starting line number
1291 GOSUB 4000
1300  LOCATE 5,1: INPUT "Starting line number? [1000] ", L$
1310  'scan for non-numeric digits, bitch if so
1320  FOR I = 1 TO LEN(L$)
1330    N$ = MID$(L$,I,1)
1340    IF INSTR("0123456789", N$) = 0                                                     THEN LOCATE 5,1: BEEP: PRINT SPACE$(79): GOTO 1300
1350    NEXT I
1360  IF L$ = ""                                                                        THEN LINENUM = 1000                                                             ELSE LINENUM = VAL(L$)
1370  IF LINENUM <= 0 THEN LOCATE 5,1: BEEP: PRINT SPACE$(79): GOTO 1300
1380 '
1390 'set display width and number of data entrys per line
1400 'users with 40 column displays, edit appropriately
1410   WIDTH.OF.DISPLAY = 80: ENTRYS.PER.LINE = 10
1430 '
1440 'whew! now do it.
1444 CLS: GOSUB 4000: GOSUB 4000
1445 LOCATE 10, (WIDTH.OF.DISPLAY-7)/2: COLOR 16,7: PRINT"*WORKING*": COLOR 7,0
1450 ENTRYS.USED = 0: NUMBYTES = 0
1455 GET 1
1460 WHILE NOT EOF(1)
1490   'and send it to output file
1500    GOSUB 1550
1506    GET 1
1510   WEND
1520 '
1530 'Clean up
1535 'if any data not written yet, lop off trailing comma and write it.
1540  IF ENTRYS.USED > 0 THEN PRINT#2, LEFT$(BUFFER$,LEN(BUFFER$)-1)
1543 FOR I = 1 TO 3: SOUND 500*I,3: NEXT: SOUND 550,5: SOUND 800,3
1544 CLS
1545 SYSTEM
1550 '******************************************
1560 '* SUBROUTINE OUTPUT                      *
1570 '*                                        *
1580 '* Builds up DATA statements in buffer.   *
1590 '* Dumps buffer to output file when full. *
1600 '******************************************
1610 '
1620 'set up if necessary
1630  IF ENTRYS.USED = 0                                                                 THEN BUFFER$ = STR$(LINENUM) + " DATA"
1640 '
1650 'add new value to buffer
1660  H$ = RIGHT$("0" + HEX$(ASC(BYTE$)),2)
1670  BUFFER$ = BUFFER$ + " &H" + H$
1680 '
1690 'Is the line full yet?  Dump if so.
1700  ENTRYS.USED = ENTRYS.USED + 1
1710  IF ENTRYS.USED < ENTRYS.PER.LINE THEN BUFFER$ = BUFFER$ + ",": GOTO 1750
1720     PRINT#2, BUFFER$
1730     ENTRYS.USED = 0
1740     LINENUM = LINENUM + 10
1750  RETURN
1760 ON ERROR GOTO 0
4000 'one liner to make noise #1
4010 FOR I = 1 TO 3: SOUND 1000*I,1: NEXT I: RETURN
5000 '**********************
5010 '* SUBROUTINE TITLE   *
5020 '* Prints title page. *
5030 '**********************
5040 '
5050 SCREEN 0,0,0: WIDTH 80: KEY OFF: CLS: LOCATE 6,1,0
5060 PRINT TAB(18) "É";STRING$(45,"Í");"»"
5070 PRINT TAB(18) "º                                             º"
5080 PRINT TAB(18) "º          COM2DATA   version 1.0             º"
5090 PRINT TAB(18) "º                                             º"
5091 PRINT TAB(18) "º          (1983) by David Whitman            º"
5094 PRINT TAB(18) "º                                             º"
5097 PRINT TAB(18) "º  Machine language file conversion utility.  º"
5160 PRINT TAB(18) "º                                             º"
5170 PRINT TAB(18) "È";STRING$(45,"Í");"¼"
5180 LOCATE 23,27: PRINT "Hit any key to continue..."
5185 GOSUB 4000 'noise #1
5190 I$ = INKEY$: IF I$ = "" THEN 5190
5200 CLS
5210 RETURN
6000 '*****************
6010 '* Error handler *
6020 '*****************
6030 '
6040 IF ERR <> 53 THEN 6100
6050    COLOR 0,7: BEEP: LOCATE 2,1
6060    PRINT IN$; " not found.  Press Esc to exit, anything else to continue."
6070    IN$ = INKEY$: IF IN$ = "" THEN 6070
6075    IF IN$ = CHR$(27) THEN SYSTEM
6080    LOCATE ,1: COLOR 7,0: PRINT SPACE$(79)
6085    LOCATE 1,1: PRINT SPACE$(79): LOCATE ,1: RESUME 1160
6090 '
6100 IF ERR <> 6 OR ERL <> 1360 THEN 6200
6110    BEEP: LOCATE 5,1: PRINT SPACE$(79): LOCATE ,1: RESUME 1300
6200 ON ERROR GOTO 0
F ERR <> 6 OR ERL <> 1360 T