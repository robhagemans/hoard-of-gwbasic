1000 '   program to print columns of text side by side
1010 CLS
1020 PRINT "----------------------------------------------"
1030 PRINT "    "
1040 PRINT "    XUP - prints columns of text side by side "
1050 PRINT "    "
1060 PRINT "    Prints text in a variable number of columns.  The program"
1070 PRINT "    prompts for input and output filenames, column width, number"
1080 PRINT "    of columns, and the number of lines per page."
1090 PRINT "    "
1100 PRINT "    If you find this program or other texttools from RPSoft"
1110 PRINT "    useful, a suggested donation of $25 to RPSoft, 1271 Palamos,"
1120 PRINT "    Sunnyvale, CA 94086 would be appreciated.  Permission is"
1130 PRINT "    granted to copy this program as long as this header is"
1140 PRINT "    not removed."
1150 PRINT "    "
1160 PRINT "    Copyright 1983 by RPSoft"
1170 PRINT "    "
1180 PRINT "----------------------------------------------"
1190 PRINT "     "
1200 DIM L$(500)
1210 WIDTH "lpt1:",180
1220 INPUT "enter input, output filenames - ";FIN$,FOUT$
1230 INPUT "enter #columns, col width, #lines - ";NCOLS,CWID,NPC
1240 OPEN "I",#1,FIN$
1250 OPEN "O",#2,FOUT$
1260 '
1270 '   read input file
1280 '
1290 IF EOF(1) THEN 1370
1300 NLS=NLS+1
1310 LINE INPUT #1,L$:GOSUB 1510:L$(NLS)=L$
1320 IF NLS=NCOLS*NPC THEN 1370
1330 GOTO 1290
1340 '
1350 '   write output file
1360 '
1370 NPGS=NPGS+1
1380 PRINT "writing page ";:PRINT USING "###";NPGS;:PRINT " ..."
1390 FOR LN=1 TO NPC
1400 FOR CNUM=0 TO NCOLS-1
1410 LP=LN+CNUM*NPC:IF LP>NLS THEN 1430
1420 PRINT #2,TAB(CNUM*CWID+1);L$(LP);
1430 NEXT CNUM:PRINT #2," "
1440 NEXT LN:PRINT #2,CHR$(12)
1450 IF EOF(1) THEN 1480
1460 NLS=0 : GOTO 1290
1470 '
1480 PRINT "normal end -";NPGS;" pages written":CLOSE #1:CLOSE#2:STOP
1490 '
1500 '   subroutine to remove tabs
1510 P0=INSTR(1,L$,CHR$(9)) : IF P0=0 THEN RETURN
1520 NIN=9-(P0 MOD 8):L$=MID$(L$,1,P0-1)+STRING$(NIN," ")+MID$(L$,P0+1,LEN(L$))
1530 GOTO 1510 '  any more tabs ?
EN RETURN
1520 NIN=9-(P0 MOD 8):L$=MI