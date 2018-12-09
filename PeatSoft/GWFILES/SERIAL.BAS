1 ' see  PC Magazine  Volume 1 Number 3  june/july 1982
10 REM program serial.  used to fakeout PC to allow use of serial printer in the                        same way the Print Screen function works for a parallel
20 '
30 ' It seems that in order for this program to run you must have the serial         cable connected to a printer or modem that is TURNED ON.  Otherwise the         open COMLINE$ in line 220 wont open.
40 '
50 ' Baud rates in line 220 can ONLY be 75, 110, 150, 300, 600, 1200, 1800, 2400     4800, or 9600
60 '
70 ' After running this program, you must exit to the system (DONT BOOT), then       re-enter BASIC for basic to recognize the new parameters.
80 '
90 'LLIST  and LPRINT  will work ;  and when you use the SYSTEM command to          return to DOS, Control PrtSc & up-shift PrtSc are enabled in PC-DOS rev 1.0     you could AUTOEXEC.BAT this routine ie..  1) DATE  2)BASIC SERIAL  3)BASIC
100 '
110 CLS:COLOR 0,7:PRINT TAB(32);"PROGRAM SERIAL";TAB(79):COLOR 7,0:LOCATE 3,1:      PRINT "Make sure your serial printer is connected to the Async RS-232 port":    PRINT "and the printer in turned on and `ON-LINE' ie. not in `local' mode"
115 REM
120 LOCATE 8,1:PRINT "Please enter the baud rate at which":PRINT "you wish to send data to the serial printer";TAB(79):PRINT SPC(79):PRINT "(baud rate can only be :  75,110,150,300,600,1200,1800,2400,4800,9600)";TAB(79);
130 LOCATE 9,50:LINE INPUT;"? ";BAUD$:BAUD$=LEFT$(BAUD$,4):IF BAUD$="" THEN BAUD!=300 :GOTO 200  ELSE BAUD!=VAL(BAUD$)
140 IF BAUD!=  75 OR BAUD!= 110 THEN 200
150 IF BAUD!= 150 OR BAUD!= 300 THEN 200
160 IF BAUD!= 600 OR BAUD!=1200 THEN 200
170 IF BAUD!=1800 OR BAUD!=2400 THEN 200
180 IF BAUD!=4800 OR BAUD!=9600 THEN 200
190 SOUND 45,12:GOTO 120  'illegal baud rate, re-enter
200 COMLINE$="COM1:"+STR$(BAUD!)+",N,8,1"
210 COMLINE$=LEFT$(COMLINE$,5)+MID$(COMLINE$,7)   ' to remove imbedded space                                                        after colen
220 OPEN COMLINE$ AS #1
230 WIDTH "com1:",80
240 DEF SEG=&H60
250 POKE &HD, &H40  'dos parallel printer vector change
260 POKE &HE, &H1
270 DEF SEG=&H40
280 POKE &H8, &HF8  'tell basic that there is a printer
290 POKE &H9, &H3
300 DEF SEG=&H0 : POKE &H100, &HFB  'restore the flages
310 REM an inconsistency exists in the rom bios concerning the meaning of the AH        register in the RS232 and the Parallel port subroutines therefore the           following line
320 POKE &H101, &HB4 : POKE &H102, &H1
330 REM  the next three lines simulate the printer port interrupt vector
340 POKE &H103, &HEA : POKE &H104, &H39
350 POKE &H105, &HE7 : POKE &H106, &H0
360 POKE &H107, &HF0
370 REM  now tell the interrupt handler to jump to  100H  for its new                    instruction sequence
380 POKE &H5C, &H0 : POKE &H5D, &H1
390 POKE &H5E, &H0 : POKE &H5F, &H0
400 CLS:BEEP:LOCATE 4,10:PRINT "The new parameters for serial printer operation  at";BAUD!;"baud":LOCATE,10:PRINT"have been set;": LOCATE 7,10:PRINT "Re-enter basic and use        up-shift PrtSc    in BASIC.":LOCATE 9,40:PRINT "up-shift or"
410 LOCATE ,40:PRINT"Control PrtSc     in PC-DOS":LOCATE ,61:PRINT "as required";:LOCATE 15,1
420 SYSTEM
4800 , OR 9600
r"
410 LOCATE ,40:PRINT"Control PrtSc     in PC-DOS":LOCATE ,61:PRINT "as required";:LOCATE 15,1
420 