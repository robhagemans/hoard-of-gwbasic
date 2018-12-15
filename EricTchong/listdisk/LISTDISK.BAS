10 ' Lister, to list BASIC program saved in ,A format. FREEWARE June 2004
20 GOTO 80 ' begin
30 SAVE"listdisk.bas":LIST-70
40 GOTO 1640 ' get numeric parameter
50 GOTO 1680 ' none specified
60 GOTO 1700 ' get key
70 ' Begin
80 Q$=MKI$(0):ON ERROR GOTO 0:CLS:KEY OFF ' Listdisk.Bas - March 11, 2003
90 ' Announce us
100 COLOR 14,0
110 PRINT " ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ"
120 PRINT "Û                                                        Û"
130 PRINT "Û A Lister for GwBasic programs:  saved in ASCII format. Û"
140 PRINT "Û File is listed to screen and saved as a txt disk-file. Û"
150 PRINT "Û Edit and print the file with your super wordprocessor. Û"
160 PRINT "Û                                                        Û"
170 PRINT " ฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ "
180 PRINT:COLOR 13,0
190 PRINT "      ษออออออออออออออออออออออออออออออออออออออออออออป"
200 PRINT "      บ Left  Margin is fixed at 1                 บ"
210 PRINT "      บ Right Margin is set   at 94 ( 80 .. 132 )  บ"
220 PRINT "      บ Enter filename: extension .bas is optional บ"
230 PRINT "      ศออออออออออออออออออออออออออออออออออออออออออออผ"
240 PRINT:COLOR 12,0
250 PRINT "             ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ"
260 PRINT "             ณ Press any key to continue... ณ"
270 PRINT "             ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู"
280 GOSUB 60:CLS:DEFINT A-Z
290 DIM PREFER$(20):TODAY$=DATE$:COLOR 7,0:FILES "*.bas"
300 ' Set initial parameters.
310 LMGN=1:RMGN=94:BMGN=5:LNSPA=1:PGLEN=66
320 FLNM$="":HEADER$="":INDENT$=SPACE$(8)
330 ' Define F-keys.
340 KEY 1,"Preview"+CHR$(13)
350 KEY 2,"Rt margin at :"
360 KEY 3,"Files"+CHR$(13)
370 KEY 4,"Exit"+CHR$(13)
380 KEY 5,"Single spaced"+CHR$(13)
390 KEY 6,"Double spaced"+CHR$(13)
400 KEY 7,"P'gram name: "
410 KEY 8,"Header: "
420 KEY 9,"Review"+CHR$(13)
430 KEY 10," Begin"
440 KEY ON:LOCATE 23,1
450 ' Call attention to F-keys.
460 ARROW$=STRING$(20,"-"):COLOR 0,11
470 PRINT ARROW$;
480 PRINT " Use F-keys to set the listing format ";:COLOR 11,0:PRINT ARROW$
490 RESTORE:FOR I=0 TO 9:READ FKEY$(I):NEXT
500 DATA Pr,Rt,Fi,Ex,Si,Do,P',He,Re," B"
510 ' Set up list of preferred breakpoints. 0 to 13 Sites.
520 FOR IP=0 TO 20:READ Z$:PREFER$(IP)=Z$:NEXT:IP=IP-1
530 DATA " ELSE ", " THEN ", ": ", " PRINT "    : ' 0  1  2  3
540 DATA " IF ", "  '", " OR ", " AND ",  ";"   : ' 4  5  6  7  8
550 DATA "=", " ", "+", "*", ","                : ' 9  10 11 12 13
560 DATA "", "", "", "", "", "", ""             : ' 14 15 16 17 18 19 20
570 ' Loop for adjusting runtime parameters.
580 LINE INPUT Z$
590 FOR I=0 TO 9
600  IF LEFT$(Z$,2)=FKEY$(I) THEN 620
610 NEXT:GOTO 580
620 ON I+1 GOTO 640,650,680,890,720,730,750,700,910,1010
630 ' Preview, Right margin-setting routine, list files
640 COLOR 12,0:PRINT"Press <Esc> to exit screen listing":COLOR 11,0:SW=0:GOTO 1020
650 GOSUB 40:RMGN=NUMBA
660 IF RMGN <80 OR RMGN>132 THEN BEEP:PRINT "Use only a value from 80 to 132...":RMGN=94
670 PRINT:GOTO 580
680 PRINT:FILES "*.bas":GOTO 580
690 ' Establish page header.
700 HEADER$=MID$(Z$,9):GOTO 580
710 ' Single- or double-space output.
720 LNSPA=1:GOTO 580
730 LNSPA=2:GOTO 580
740 ' Get name of program to be listed.
750 FLNM$=MID$(Z$,13)
760 IF LEFT$(FLNM$,1)=" " THEN FLNM$=MID$(FLNM$,2):GOTO 760
770 ET=LEN(FLNM$):FLNM2$="":EC$=""
780 FOR I=1 TO ET
790  EC$=MID$(FLNM$,I,1):IF EC$="." THEN 840
800  FLNM2$=FLNM2$+EC$
810 NEXT
820 ' Save filename as a txt file
830 FLNM$= FLNM2$ + ".bas"
840 FLNM2$=FLNM2$ + ".txt"
850 ' If there's no header yet, fake it with the file name.
860 IF HEADER$="" THEN HEADER$=CHR$(34)+FLNM$+CHR$(34)
870 GOTO 580
880 ' Exit Lister
890 FLNM$="Listdisk.bas":CLS:GOTO 1730
900 ' Display the current parameters.
910 PRINT:PRINT"Left  margin at";LMGN
920 PRINT "Right margin at";RMGN:PRINT
930 IF LNSPA=2 THEN PRINT "Double"; ELSE PRINT "Single";
940 PRINT " line spacing"
950 PRINT "Program name: ";: IF FLNM$="" THEN GOSUB 50 ELSE PRINT FLNM$
960 PRINT "Header: ";: IF HEADER$="" THEN GOSUB 50 ELSE PRINT HEADER$
970 PRINT
980 GOTO 580
990 ' Check parameters before actually trying to list the program.
1000 ' List to screen or disk
1010 SW=1
1020 LNLEN=RMGN-LMGN+1
1030 ' Open the disk file, complain if not possible to do it.
1040 ON ERROR GOTO 1600
1050 OPEN FLNM$ FOR INPUT AS #1
1060 IF SW=1 THEN OPEN "O",#2,FLNM2$
1070 ON ERROR GOTO 0
1080 ' Title the first page with the header and -if available- the date.
1090 PRINT
1100 PRINT    TAB(LMGN); HEADER$;:PRINT    ", listed "; TODAY$
1110 IF SW=1 THEN 1120 ELSE 1130
1120 PRINT #2,TAB(LMGN); HEADER$;:PRINT #2,", listed "; TODAY$
1130 PRINT:IF SW=1 THEN PRINT #2,""
1140 ' Get the next BASIC line, quit if end of file.
1150 PGNUM=1:LNCNT=3
1160 IF EOF(1) THEN CLOSE:GOTO 580
1170 LINE INPUT #1, DISK$:IF DISK$="" THEN 1170
1180 ' Right-justify the line number.
1190 DISK$=SPACE$(6-INSTR(DISK$," "))+DISK$
1200 ' CMNTSW governs the blank line ahead of comment lines.
1210 IF MID$(DISK$,7,1)<>"'" THEN CMNTSW=0
1220 ' Break the BASIC line into printer lines.
1230 FOR J=0 TO 9
1240  IF CMNTSW=0 AND MID$(DISK$,7,1)="'" THEN LN$(J)="":J=J+1:CMNTSW=1
1250 ' It's easy if the whole line fits at once.
1260  IF LEN(DISK$)<=LNLEN THEN LN$(J)=DISK$:GOTO 1430
1270 ' Else, check for preferred breakpoints.
1280  FOR K=0 TO IP
1290   SITE=0:K$=PREFER$(K)
1300   HISITE=SITE: IF SITE<13 THEN SITE=13  ' 13 was 9 before
1310   SITE=INSTR(SITE+1,DISK$,K$)
1320   IF SITE>0 AND SITE<=LNLEN THEN 1300
1330   IF HISITE=0 THEN 1340 ELSE 1350
1340  NEXT K
1350  IF HISITE=0 THEN HISITE=LNLEN
1360 ' HISITE now points to the rightmost, best breakpoint.
1370 ' Split the line there and indent all but the first one.
1380  LN$(J)=LEFT$(DISK$,HISITE)
1390  DISK$=MID$(DISK$,HISITE+1)
1400  DISK$=INDENT$+DISK$
1410 NEXT J
1420 ' If the first BASIC line is a comment, then skip blank line
1430 IF CMNTSW=1 AND LNCNT=3 THEN Z=1 ELSE Z=0
1440 IF Z=1 AND J=0 THEN Z=0
1450 ' Everything is guaranteed to fit. Print it all.
1460 FOR L=Z TO J
1470  LNCNT=LNCNT+1
1480  PRINT    TAB(LMGN); LN$(L):IF SW=1 THEN PRINT #2,TAB(LMGN); LN$(L)
1490  IF LNSPA=2 THEN LNCNT=LNCNT+1:PRINT:IF SW=1 THEN PRINT #2,""
1500 NEXT
1510 ' Pressing <Esc> exits screen list
1520 IF SW=1 THEN 1160
1530 GOSUB 60:IF ASC(Q$)=27 THEN CLOSE:PRINT:SW=0:GOTO 580
1540 ' Cycle again
1550 GOTO 1160
1560 ' The operator-alert for an off-line printer
1570 PRINT:BEEP:PRINT "The line printer isn't ready. Check it...":PRINT
1580 PRINT:GOTO 1610
1590 ' The operator-alert for a lack of disk data:
1600 CLOSE:PRINT:BEEP:PRINT "The file ";FLNM$; " can not be found..."
1610 PRINT "Press any key to restart..."
1620 GOSUB 60:RUN
1630 ' Subroutine to decode a numeric parameter input.
1640 NUMBA=VAL (MID$(Z$,15))
1650 IF NUMBA=0 THEN BEEP:PRINT "<< Number required >>"
1660 RETURN
1670 ' Subroutine to note the lack of a file or a header.
1680 COLOR 0,11:PRINT " None specified  ";:COLOR 11,0:PRINT :RETURN
1690 ' Get key pressed
1700 LSET Q$=MKI$(0)
1710 WHILE CVI(Q$)=0:MID$(Q$,1)=INKEY$:WEND:RETURN
1720 ' Orderly exit. Reset the printer & F-keys, then exit.
1730 PRINT:BEEP:CLOSE:KEY OFF:COLOR 7,0
1740 KEY 1,"LIST ":KEY 2,"RUN"+CHR$(13):KEY 3,"LOAD"+CHR$(34):KEY 4,"SAVE"+CHR$(34):KEY 5,FLNM$:KEY 6,CHR$(34)+",a"
1750 KEY 7,"TRON"+CHR$(13):KEY 8,"TROFF"+CHR$(13):KEY 9,"KEY ":KEY 10,"SCREEN 0,0,0"+CHR$(13)
1760 KEY ON:KEY LIST:PRINT:END
1770 ' Program by Paul F. Doering - Creative Computing, Sept 1982
1780 ' Program originally written for a cassette-based IBM PC & Epson MX-80
1790 ' Rewritten for PC computers by Eric F. Tchong - Aruba - April 13, 1992
1800 '
1810 ' ----> You will get a FOR without NEXT error if you do
1820 '       not use the letters in NEXT K and NEXT J <-----
