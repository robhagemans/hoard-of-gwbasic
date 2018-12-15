100 REM **********************************************************************
110 REM FILE NAME  - DUATCOM.BAS
120 REM
130 REM WRITTEN BY - GARY PEEK                   COPYRIGHT (c) 1990, 91, 92,
140 REM              3201 HIGHGATE                                   93, 94
150 REM              ST. CHARLES, MO.  63301
160 REM              314 946-5272
170 REM
180 REM LAST UPDATE - change below!
190 REM
200 REM DESCRIPTION - A SERIAL COMMUNICATIONS PROGRAM FOR DUAT
210 REM               INCLUDES FILE CAPTURE, AUTODIALING
220 REM               WHEN USING INTERPRETER USE GWBASIC DUATCOM /C:10000
230 REM
240 REM **********************************************************************
250 KEY OFF:FOR A=1 TO 10:KEY A,"":NEXT
260 WIDTH "LPT1:",255
270 DEF SEG=0:POKE &H478,1:POKE &H479,1:POKE &H47A,1:POKE &H47B,1:DEF SEG
280 LOCATE ,,0
290 ON ERROR GOTO 400
300 OPEN "DUATCOM.CNF" FOR INPUT AS 1
310 INPUT #1,DUMMY$,PORT$,BAUD$,COLOUR$
320 CLOSE #1
330 ON ERROR GOTO 0
340 GOTO 1000
350 REM -----
400 RESUME 410
410 ON ERROR GOTO 0
415 COLOUR$="MONOCHROME":COLOR 7,0
420 CLS:PRINT "DUATCOM":PRINT
430 PRINT "Configuration File Not Found,"
440 PRINT "Searching For Modem on COM1 or COM2 only ...":PRINT
450 T=TIMER
460 IF TIMER<T+1 THEN 460
470 PORT$="COM1":BAUD$="2400":GOSUB 600:IF FOUND THEN 900
480 PORT$="COM2":BAUD$="2400":GOSUB 600:IF FOUND THEN 900
490 PORT$="COM1":BAUD$="1200":GOSUB 600:IF FOUND THEN 900
500 PORT$="COM2":BAUD$="1200":GOSUB 600:IF FOUND THEN 900
510 PORT$="COM1":BAUD$="300":GOSUB 600:IF FOUND THEN 900
520 PORT$="COM2":BAUD$="300":GOSUB 600:IF FOUND THEN 900
530 SOUND 500,10
540 PRINT:PRINT "Modem Not Found on COM1 or COM2, DUATCOM May Not Work."
550 PRINT:PRINT "Hit Any Key to Continue."
560 IN$=INKEY$:IF IN$="" THEN 560
570 GOTO 1000
580 REM -----
600 PRINT "Checking ";PORT$;" at ";BAUD$;" Baud"
610 FOUND=0:L$=""
620 ON ERROR GOTO 820:REM SEE IF COM PORT HARDWARE RESPONDS
630 COMM$=PORT$+":"+BAUD$+",N,8,1,CS,DS,CD"
640 CLOSE:OPEN COMM$ AS #1
650 ON ERROR GOTO 0
660 PRINT #1,"AT":REM SEND "ATTENTION" TO MODEM
670 T=TIMER
680 IF TIMER<T+1 THEN 680:REM WAIT FOR RESONSE FROM MODEM
690 T=TIMER
700   IF NOT EOF(1) THEN 730
710     IF TIMER>T+.25 THEN 770:REM IF NO MORE CHARACTERS ARE THERE
720   GOTO 700
730   ON ERROR GOTO 760:REM SOMETIMES A DEVICE I/O ERROR ON FIRST CHARACTER
740   L$=L$+INPUT$(1,#1)
750 GOTO 690
760 RESUME 690:REM LOOK FOR REST OF CHARACTERS IF DEVICE I/O ERROR
770 IF INSTR(L$,"OK")=0 THEN 790:REM LOOK FOR CORRECT MODEM RESPONSE
780 FOUND=-1
790 ON ERROR GOTO 0
800 CLOSE:RETURN
810 REM -----
820 IF ERR=24 THEN RESUME 860:REM DEVICE TIMEOUT
830 IF ERR=68 THEN RESUME 860:REM DEVICE UNAVAILABLE
840 IF ERR=57 THEN RESUME 860:REM DEVICE I/O ERROR
850 PRINT:PRINT "ERROR";ERR;" ON LINE ";ERL:PRINT:SOUND 500,10:END
860 ON ERROR GOTO 0
870 RETURN
880 REM -----
900 PRINT BAUD$;" Baud Modem Found at ";PORT$
910 T=TIMER
920 IF TIMER<T+3 THEN 920
930 GOSUB 3000:REM WRITE CONFIGURATION FILE
940 REM ----------------------------------------------------------------------
1000 CAPTURE=0:FILE$="DUATCOM.CAP"
1010 GOSUB 2200:REM GET COLORS
1020 COLOR FORE,BACK
1030 REM -----
1100 CLS
1110 PRINT "ษออออออออออออออออออออออออออออออออออป"
1120 PRINT "บ    DUAT Communication Program    บ"
1130 PRINT "บ            10/19/94              บ"
1140 PRINT "ฬออออออออออออออออออออออออออออออออออน"
1150 PRINT "บ            Main Menu             บ"
1160 PRINT "บ  F1  Connect to DUAT Services    บ"
1170 PRINT "บ  F2  Print a Captured File       บ"
1180 PRINT "บ  F3  Select Program Colors       บ"
1190 PRINT "บ  F4  Select Modem Port/Baud Rate บ"
1200 PRINT "บ  F5  Read Program Information    บ"
1210 PRINT "บ F10  EXIT Program                บ"
1220 PRINT "ศออออออออออออออออออออออออออออออออออผ"
1230 LOCATE ,,0
1240 B$=INKEY$:IF B$="" THEN 1240
1250 IF B$=CHR$(0)+CHR$(59) THEN GOSUB 3500:GOTO 1100
1260 IF B$=CHR$(0)+CHR$(60) THEN GOSUB 1500:GOTO 1100
1270 IF B$=CHR$(0)+CHR$(61) THEN GOSUB 2000:GOTO 1100
1280 IF B$=CHR$(0)+CHR$(62) THEN GOSUB 2500:GOTO 1100
1290 IF B$=CHR$(0)+CHR$(63) THEN GOSUB 6000:GOTO 1100
1300 IF B$=CHR$(0)+CHR$(68) THEN COLOR 7,0:CLS:END
1310 GOTO 1240
1320 REM ---------------------------------------------------------------------
1500 CLS
1505 PRINT "ษออออออออออออออออออออออออออออออออออออออออออออออออออออป"
1510 PRINT "บ               Print a Captured File                บ"
1515 PRINT "ฬออออออออออออออออออออออออออออออออออออออออออออออออออออน"
1520 PRINT "บ  Just Hit ENTER to Print Default File DUATCOM.CAP  บ"
1525 PRINT "บ  or Enter File Name to Print:                      บ"
1530 PRINT "ศออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
1540 LOCATE 5,33,1:LINE INPUT F$:LOCATE ,,0
1550 IF F$="" THEN F$="DUATCOM.CAP"
1560 ON ERROR GOTO 1650
1570 OPEN F$ FOR INPUT AS #1
1580 CLS:PRINT "Printing ";F$:PRINT
1590 ON ERROR GOTO 1750
1600 IF EOF(1) THEN CLOSE #1:RETURN
1610 LINE INPUT #1,L$
1620 LPRINT L$
1630 GOTO 1600
1640 REM -----
1650 RESUME 1660
1660 ON ERROR GOTO 0
1665 SOUND 500,10
1670 PRINT:PRINT:PRINT "That File Cannot Be Found"
1680 PRINT "Hit ESCape to Exit Or Any Other Key to Continue"
1690 IN$=INKEY$:IF IN$="" THEN 1690
1700 IF IN$=CHR$(27) THEN RETURN
1710 GOTO 1500
1740 REM -----
1750 RESUME 1760
1760 ON ERROR GOTO 0
1765 SOUND 500,10
1770 PRINT:PRINT "There is a Problem With the Printer...":PRINT
1780 PRINT "Correct the Problem, Then Hit ESCape to Exit"
1790 PRINT "Or Any Other Key to Continue Printing"
1800 IN$=INKEY$:IF IN$="" THEN 1800
1810 IF IN$=CHR$(27) THEN CLOSE #1:RETURN
1820 CLS:PRINT "Printing ";F$:PRINT
1830 ON ERROR GOTO 1750
1840 GOTO 1620
1850 REM ---------------------------------------------------------------------
2000 COLOR FORE,BACK:CLS
2010 PRINT "ษออออออออออออออออออออออออออออออออออป"
2020 PRINT "บ      Select Program Colors       บ"
2030 PRINT "ฬอออออออออออออออหออออออออออออออออออน"
2040 PRINT "บ F1  Color     บ  F2  Monochrome  บ"
2060 PRINT "ฬอออออออออออออออฮออออออออออออออออออน"
2070 PRINT "บ F9  Save/Exit บ  F10 Exit        บ"
2080 PRINT "ศอออออออออออออออสออออออออออออออออออผ"
2090 LOCATE ,,0
2100 B$=INKEY$:IF B$="" THEN 2100
2110 IF B$=CHR$(0)+CHR$(59) THEN COLOUR$="COLOR":GOSUB 2200:GOTO 2000
2120 IF B$=CHR$(0)+CHR$(60) THEN COLOUR$="MONOCHROME":GOSUB 2200:GOTO 2000
2150 IF B$=CHR$(0)+CHR$(67) THEN GOSUB 3000:RETURN
2160 IF B$=CHR$(0)+CHR$(68) THEN RETURN
2170 GOTO 2100
2180 REM -----
2200 IF COLOUR$="COLOR" THEN FORE=15:BACK=1:HFORE=15:HBACK=4
2210 IF COLOUR$="MONOCHROME" THEN FORE=7:BACK=0:HFORE=0:HBACK=7
2230 RETURN
2490 REM ---------------------------------------------------------------------
2500 CLS
2510 PRINT "ษอออออออออออออออออออออออออออออออออป"
2520 PRINT "บ Select Modem Port and Baud Rate บ"
2530 PRINT "ฬออออออออออออออออหออออออออออออออออน"
2540 PRINT "บ COM1:          บ  COM2:         บ"
2550 PRINT "บ F1   300 Baud  บ  F2   300 Baud บ"
2560 PRINT "บ F3  1200 Baud  บ  F4  1200 Baud บ"
2570 PRINT "บ F5  2400 Baud  บ  F6  2400 Baud บ"
2575 PRINT "บ F7  9600 Baud  บ  F8  9600 Baud บ"
2580 PRINT "ฬออออออออออออออออฮออออออออออออออออน"
2590 PRINT "บ F9  Save/Exit  บ  F10  Exit     บ"
2600 PRINT "ศออออออออออออออออสออออออออออออออออผ"
2610 LOCATE 13,1:PRINT "Current Configuration:"
2620 LOCATE 14,1:PRINT PORT$+" at "+BAUD$+" Baud  "
2630 LOCATE ,,0
2640 B$=INKEY$:IF B$="" THEN 2640
2650 IF B$=CHR$(0)+CHR$(59) THEN PORT$="COM1":BAUD$="300":GOTO 2620
2655 IF B$=CHR$(0)+CHR$(60) THEN PORT$="COM2":BAUD$="300":GOTO 2620
2660 IF B$=CHR$(0)+CHR$(61) THEN PORT$="COM1":BAUD$="1200":GOTO 2620
2665 IF B$=CHR$(0)+CHR$(62) THEN PORT$="COM2":BAUD$="1200":GOTO 2620
2670 IF B$=CHR$(0)+CHR$(63) THEN PORT$="COM1":BAUD$="2400":GOTO 2620
2675 IF B$=CHR$(0)+CHR$(64) THEN PORT$="COM2":BAUD$="2400":GOTO 2620
2680 IF B$=CHR$(0)+CHR$(65) THEN PORT$="COM1":BAUD$="9600":GOTO 2620
2685 IF B$=CHR$(0)+CHR$(66) THEN PORT$="COM2":BAUD$="9600":GOTO 2620
2710 IF B$=CHR$(0)+CHR$(67) THEN GOSUB 3000:RETURN
2720 IF B$=CHR$(0)+CHR$(68) THEN RETURN
2730 GOTO 2640
2740 REM ------------------------------
3000 ON ERROR GOTO 3200
3010 OPEN "DUATCOM.CNF" FOR OUTPUT AS #1
3020 PRINT #1,"DUATCOM CONFIGURATION FILE"
3030 PRINT #1,PORT$
3040 PRINT #1,BAUD$
3050 PRINT #1,COLOUR$
3060 CLOSE #1
3070 ON ERROR GOTO 0:RETURN
3080 REM -----
3200 RESUME 3210
3210 CLOSE #1:SOUND 500,10
3220 PRINT:PRINT "Unable to Write Configuration File,"
3230 PRINT "Disk is Full or Write-Protected."
3240 PRINT:PRINT "Hit Any Key to Continue."
3250 IN$=INKEY$:IF IN$="" THEN 3250
3260 GOTO 3070
3270 REM ----------------------------------------------------------------------
3500 CLS
3520 ON ERROR GOTO 4900
3530 COMM$=PORT$+":"+BAUD$+",N,8,1,CS,DS,CD"
3540 CLOSE:OPEN COMM$ AS #1
3650 PRINT #1,"":REM SEND SOMETHING TO MODEM
3660 T=TIMER
3670 IF TIMER<T+.5 THEN 3670:REM WAIT FOR RESONSE FROM MODEM
3680 T=TIMER
3690   IF NOT EOF(1) THEN 3720
3700     IF TIMER>T+.25 THEN 4100:REM IF NO MORE CHARACTERS ARE THERE
3710   GOTO 3690
3720   ON ERROR GOTO 3750:REM SOMETIMES A DEVICE I/O ERROR ON FIRST CHARACTER
3730   A$=INPUT$(1,#1)
3740 GOTO 3680
3750 RESUME 3680:REM LOOK FOR REST OF CHARACTERS IF DEVICE I/O ERROR
4090 REM ------------------
4100 ON ERROR GOTO 0
4110 CLS:VIEW PRINT
4120 FOR A=1 TO 24:PRINT SPACE$(80):NEXT A
4130 COLOR HFORE,HBACK:LOCATE 25,1
4140 PRINT " F1=DTC F2=CONTEL F3=Z/L F4=Help F5=Name F6=D/T F7=Cap F8=End F9=Menu F10=Exit  ";
4150 VIEW PRINT 1 TO 24
4160 COLOR FORE,BACK:LOCATE 1,1
4170 PRINT "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
4180 PRINT "บ   The Following Functions Can be Selected During Communication:    บ"
4190 PRINT "ฬออออออออออออออออออออออออออออออหอออออออออออออออออออออออออออออออออออออน"
4200 PRINT "บ F1  Dial DTC DUAT            บ  F2  Dial Contel DUAT               บ"
4210 PRINT "บ F3  Zulu/Local Conversion    บ  F4  HELP With These Functions      บ"
4220 PRINT "บ F5  Select Capture File Name บ  F6  Name Capture File as Date/Time บ"
4230 PRINT "บ F7  Begin File Capture       บ  F8  End File Capture               บ"
4240 PRINT "บ F9  Re-Display This Menu     บ F10  EXIT Communication Mode        บ"
4250 PRINT "ฬออออออออออออออออออออออออออออออสอออออออออออออออออออออออออออออออออออออน"
4260 PRINT "บ              Date ";DATE$;"   Local Time ";TIME$;"                 บ"
4270 PRINT "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
4280 PRINT:PRINT
4290 COLOR HFORE,HBACK:PRINT " Now in Communication Mode- "
4300 COLOR FORE,BACK::PRINT:LOCATE ,,1
4310 ON ERROR GOTO 4800
4320 REM -------------
4400 IF EOF(1) THEN 4500
4410 A=ASC(INPUT$(1,#1)):A=(A AND &H7F):A$=CHR$(A)
4420 IF A$=CHR$(8) THEN A$=CHR$(29)+" "+CHR$(29)
4430 IF A$=CHR$(10) THEN 4450
4440 PRINT A$;
4450 IF CAPTURE=0 THEN 4500
4460 PRINT #2,A$;
4470 REM -----
4500 B$=INKEY$:IF B$="" THEN 4400
4510 IF B$=CHR$(0)+CHR$(59) THEN PRINT #1,"ATDT18002453828":GOTO 4400:REM dtc
4520 IF B$=CHR$(0)+CHR$(60) THEN PRINT #1,"ATDT18007679989":GOTO 4400:REM contel
4530 IF B$=CHR$(0)+CHR$(61) THEN GOTO 5300:REM TIME CONVERSION
4540 IF B$=CHR$(0)+CHR$(62) THEN GOTO 7000:REM HELP
4550 IF B$=CHR$(0)+CHR$(63) THEN 5000:REM NAME CAPTURE FILE
4560 IF B$<>CHR$(0)+CHR$(64) THEN 4590:REM NAME CAPTURE FILE AS DATE/TIME
4570 FILE$=LEFT$(DATE$,2)+MID$(DATE$,4,2)+LEFT$(TIME$,2)+MID$(TIME$,4,2)+".CAP"
4580 SOUND 1000,1:GOTO 5130:REM jump to print message
4590 IF B$<>CHR$(0)+CHR$(65) THEN 4620:REM OPEN CAPTURE FILE
4600 CAPTURE=1:CLOSE #2:OPEN FILE$ FOR OUTPUT AS 2:SOUND 1000,1
4610 PRINT:PRINT "Beginning File Capture - Writing to ";FILE$:GOTO 4400
4620 IF B$<>CHR$(0)+CHR$(66) THEN 4650:REM CLOSE CAPTURE FILE
4630 CAPTURE=0:SOUND 1000,1:PRINT #2, CHR$(26);:CLOSE #2
4640 PRINT:PRINT "Ending File Capture":GOTO 4400
4650 IF B$=CHR$(0)+CHR$(67) THEN 4100:REM RE-DISPLAY MENU
4660 IF B$<>CHR$(0)+CHR$(68) THEN 4710:REM EXIT
4670 PRINT #1,"+++";:S=TIMER:CLS
4680 SS=TIMER:IF SS<S+2 THEN 4680
4690 PRINT #1,"ATH":CLOSE #1:RETURN
4700 REM --------
4710 PRINT #1,B$;
4720 GOTO 4400
4730 REM ------- DEVICE I/O ERROR -------
4800 IF ERR=57 THEN SOUND 2000,.5:PRINT:PRINT "DEVICE I/O ERROR":RESUME
4810 REM ------- COM BUFFER OVERFLOW ERROR -------
4820 IF ERR=69 THEN SOUND 2000,.5:PRINT:PRINT "COM BUFFER OVERFLOW":RESUME
4830 PRINT:PRINT "ERROR";ERR;" ON LINE ";ERL:PRINT:SOUND 500,10:END
4840 REM
4850 REM ------- DEVICE TIMEOUT OR DEVICE UNAVAILABLE ERROR -------
4900 IF ERR=24 OR ERR=68 THEN RESUME 4920
4910 PRINT:PRINT "ERROR";ERR;" ON LINE ";ERL:PRINT:SOUND 500,10:END
4920 ON ERROR GOTO 0
4930 PRINT:PRINT"              MODEM NOT RESPONDING ON THAT PORT         "
4940 SOUND 500,10:PRINT "                   Hit any key to continue"
4950 IN$=INKEY$:IF IN$="" THEN 4950
4960 GOTO 600
4970 REM ------- SELECT FILE NAME -------
5000 PRINT:PRINT "The Current Capture File Name is ";FILE$ 
5010 PRINT "Enter New Name of Capture File (filename.ext)             ";
5015 FOR A=1 TO 12:PRINT CHR$(29);:NEXT A
5020 LINE INPUT F$
5030 IF F$="" THEN FILE$="DUATCOM.CAP":GOTO 5130
5040 IF LEN(F$)>12 THEN 5100
5050 FOR L=1 TO LEN(F$):Z=ASC(MID$(F$,L,1)):REM check for good file name
5060 IF Z>=48 AND Z<=57 THEN 5110
5070 IF Z>=65 AND Z<=90 THEN 5110
5080 IF Z>=97 AND Z<=122 THEN 5110
5090 IF Z=45 OR Z=46 OR Z=95 THEN 5110:REM hyphen,period,underscore
5100 SOUND 500,10:GOTO 5130
5110 NEXT L
5120 SOUND 1000,1:FILE$=F$
5130 PRINT:PRINT "The Capture File Name is Now ";FILE$
5140 PRINT "Hit F7 When Ready to Begin File Capture"
5150 GOTO 4400
5160 REM ------ TIME CONVERSION ------
5300 ON ERROR GOTO 0
5310 OLDROW=CSRLIN:OLDCOL=POS(0)
5320 COLOR HFORE,HBACK:LOCATE ,,0
5330 LOCATE 1,54:PRINT "      Time Conversion      ";
5340 LOCATE 2,54:PRINT " (Z)ulu"+CHR$(26)+"local (L)ocal"+CHR$(26)+"zulu ";
5350 IN$=INKEY$:IF IN$="" THEN 5350
5360 IF IN$=CHR$(27) OR IN$=CHR$(13) THEN 5810
5370 IF IN$="Z" OR IN$="z" THEN ZL=1:GOTO 5400
5380 IF IN$="L" OR IN$="l" THEN ZL=2:GOTO 5400
5390 GOTO 5350
5400 LOCATE 2,54:PRINT "(E)ast (C)ent (M)ount (P)ac";
5410 IN$=INKEY$:IF IN$="" THEN 5410
5420 IF IN$=CHR$(27) OR IN$=CHR$(13) THEN 5810
5430 IF IN$="E" OR IN$="e" THEN ECMP=1:GOTO 5480
5440 IF IN$="C" OR IN$="c" THEN ECMP=2:GOTO 5480
5450 IF IN$="M" OR IN$="m" THEN ECMP=3:GOTO 5480
5460 IF IN$="P" OR IN$="p" THEN ECMP=4:GOTO 5480
5470 GOTO 5410
5480 LOCATE 2,54:PRINT "  (S)tandard   (D)aylight  ";
5490 IN$=INKEY$:IF IN$="" THEN 5490
5500 IF IN$=CHR$(27) OR IN$=CHR$(13) THEN 5810
5510 IF IN$="S" OR IN$="s" THEN SD=1:GOTO 5540
5520 IF IN$="D" OR IN$="d" THEN SD=2:GOTO 5540
5530 GOTO 5480
5540 IF ECMP=1 AND SD=1 THEN OFFSET=5:LOCAL$="EST"
5550 IF ECMP=2 AND SD=1 THEN OFFSET=6:LOCAL$="CST"
5560 IF ECMP=3 AND SD=1 THEN OFFSET=7:LOCAL$="MST"
5570 IF ECMP=4 AND SD=1 THEN OFFSET=8:LOCAL$="PST"
5580 IF ECMP=1 AND SD=2 THEN OFFSET=4:LOCAL$="EDT"
5590 IF ECMP=2 AND SD=2 THEN OFFSET=5:LOCAL$="CDT"
5600 IF ECMP=3 AND SD=2 THEN OFFSET=6:LOCAL$="MDT"
5610 IF ECMP=4 AND SD=2 THEN OFFSET=7:LOCAL$="PDT"
5620 LOCATE 2,54
5630 IF ZL=1 THEN PRINT " Enter Zulu:  (HHMM)       ";CHR$(29);
5640 IF ZL=2 THEN PRINT " Enter Local: (HHMM)       ";CHR$(29);
5650 LOCATE 2,75,1:LINE INPUT T$
5660 IF T$="" THEN 5810
5670 IF LEN(T$)<>4 THEN 5620
5680 T$=LEFT$(T$,2)+":"+RIGHT$(T$,2)
5690 H=VAL(LEFT$(T$,2)):M$=RIGHT$(T$,2)
5700 IF ZL=1 THEN 5730
5710 H=H+OFFSET:IF H>23 THEN H=H-24
5720 GOTO 5740
5730 H=H-OFFSET:IF H<0 THEN H=H+24
5740 H$=RIGHT$(STR$(H),LEN(STR$(H))-1)
5750 IF LEN(H$)<2 THEN H$="0"+H$
5760 TT$=H$+":"+M$
5770 LOCATE 2,54
5780 IF ZL=1 THEN PRINT "  "+T$+" Zulu = "+TT$+" "+LOCAL$+"   ";
5790 IF ZL=2 THEN PRINT "  "+T$+" "+LOCAL$+" = "+TT$+" Zulu   ";
5800 COLOR FORE,BACK:GOTO 5840
5810 COLOR FORE,BACK
5820 LOCATE 1,54:PRINT "                           ";
5830 LOCATE 2,54:PRINT "                           ";
5840 LOCATE OLDROW,OLDCOL,1
5850 GOTO 4300
5860 REM ------ INFO ------
6000 CLS
6010 COLOR HFORE,HBACK:PRINT " DUATCOM ":COLOR FORE,BACK:PRINT
6020 PRINT "DUATCOM was designed for the easy use of text only DUAT services. Unlike"
6030 PRINT "most communication programs, it includes only the features needed for the"
6040 PRINT "basic use of DUAT, along with other features specific to DUAT. This makes"
6050 PRINT "DUATCOM easier to use and smaller than a full feature program. Features"
6060 PRINT "include the choice of either COM1 or COM2, one of several baud rates,"
6070 PRINT "automatic dialing of the DUAT venders, and the ability to save DUAT data"
6080 PRINT "to a file that can later be printed and studied."
6090 PRINT
6110 PRINT "Communication parameters are 8 bits, 1 stop bit, and no parity. Bit 7"
6115 PRINT "is removed from received characters but transmitted characters are full"
6120 PRINT "8 bits. Communication errors are noted by beeps while data is being"
6125 PRINT "received, however the program ignores these errors and continues."
6130 PRINT
6140 PRINT "DUATCOM  copyright (c) 1990, 1991, 1992, 1993, 1994, 1995, 1996"
6145 PRINT "written by gary peek, 3201 highgate, st. charles, mo. 63301  (314) 946-5272"
6160 PRINT
6170 PRINT "This program may be used and distributed freely for non-commercial purposes,"
6175 PRINT "or it may be sold and distributed for profit, provided that at least 50% of"
6180 PRINT "all profits be donated to the Aircraft Owners and Pilots Association Air"
6185 PRINT "Safety Foundation, and that the author be notified of such use for profit."
6190 PRINT:COLOR HFORE,HBACK:PRINT " Hit any key to continue ";:COLOR FORE,BACK
6200 IN$=INKEY$:IF IN$="" THEN 6200
6210 RETURN
6220 REM ------ HELP WITH FUNCTIONS ------
7000 CLS:LOCATE ,,0
7010 PRINT "F1 and F2  Dial DUAT:":PRINT
7020 PRINT "These function keys will send the commands to the modem"
7030 PRINT "to automatically dial one of the DUAT services for you."
7040 PRINT "(You can still give the modem a command manually.)"
7050 PRINT
7060 PRINT "F3  Zulu/Local Conversion:"
7070 PRINT "This function allows you to convert times back and forth"
7080 PRINT "from Zulu to one of the 4 local times in the contiguous"
7090 PRINT "48 states and also account for daylight savings time."
7100 PRINT
7110 PRINT "F5  Select Capture File Name:":PRINT
7120 PRINT "This function allows you to specifically name a file"
7130 PRINT "that you can use to capture the information being"
7140 PRINT "displayed on the screen. Naming a file specifically"
7150 PRINT "will help you remember its purpose, e.g., MYTRIP.WX"
7160 PRINT "This name can have up to 8 characters, a period, and"
7170 PRINT "a 3 character `extension' (filename.ext). This program"
7180 PRINT "initially sets the capture file name to DUATCOM.CAP" 
7190 PRINT "and if you simply hit `ENTER' when asked to change the"
7200 PRINT "name it will be set back to DUATCOM.CAP"
7210 PRINT:COLOR HFORE,HBACK:PRINT " Hit any key to continue ";:COLOR FORE,BACK
7220 IN$=INKEY$:IF IN$="" THEN 7220
7230 CLS
7240 PRINT "F6  Name Capture File as Date/Time:":PRINT
7250 PRINT "This function will automatically name the capture file"
7260 PRINT "using part of the computer's date and time. The file"
7270 PRINT "name is built in this manner - `01312359.CAP' where 01"
7280 PRINT "is the month, 31 is the day, 23 is the current hour"
7290 PRINT "(24 hour clock), 59 is the current minutes, and CAP is"
7300 PRINT "the extension for `capture'. Since seconds are not used"
7310 PRINT "to build the file name, it is possible to write over"
7320 PRINT "a previously created file if you capture another one"
7330 PRINT "less than one minute after capturing the previous one."
7340 PRINT:PRINT
7350 PRINT "F7  Begin File Capture:"
7360 PRINT "This will begin storing what you see displayed on the"
7370 PRINT "screen into the capture file."
7380 PRINT
7390 PRINT "F8  End File Capture:"
7400 PRINT "And this will end that function."
7410 PRINT:PRINT:COLOR HFORE,HBACK:PRINT " Hit any key to continue ";:COLOR FORE,BACK
7420 IN$=INKEY$:IF IN$="" THEN 7420
7430 CLS
7440 PRINT "F9  Re-Display This Menu:":PRINT
7450 PRINT "This will re-display the menu of functions after it"
7460 PRINT "has scrolled off the screen due to DUAT information"
7470 PRINT "being displayed on the screen."
7480 PRINT:PRINT
7490 PRINT "F10  EXIT Communications Mode:":PRINT
7500 PRINT "This function will TERMINATE CONNECTION with DUAT,"
7510 PRINT "end the file capture mode, and return you to the"
7520 PRINT "initial screen. It is best to exit DUAT from the DUAT"
7530 PRINT "menu before exiting the communications mode."
7540 PRINT:PRINT:COLOR HFORE,HBACK:PRINT " Hit any key to continue ";:COLOR FORE,BACK
7550 IN$=INKEY$:IF IN$="" THEN 7550
7560 GOTO 4100
7570 REM ------ END OF PROGRAM ------
