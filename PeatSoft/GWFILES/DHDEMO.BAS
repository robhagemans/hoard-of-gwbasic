10 'This program demonstrates Disk Handler
20 'from the October Issue of SofTalk, p. 72.
30 'Written by Howard Glosser
40 'Define SEGMENT and Load DISKHAND.BIN
50 'CLEAR,32768 ' This line is necessary only for 64K machines.
60 DEF SEG=&H1700 ' Use DEF SEG=&HF00 with machines with less then 96K.
70 BLOAD "DISKHAND.BIN",0
80 DISK%=0
90 CLS
100 LOCATE 1,5:PRINT" ** Disk Handler Demonstration **":PRINT
110 '
120 'Find Default Drive
130 '
140 FIND%=1:SET%=2:DISKPARM$=SPACE$(1)
150 PRINT"Find the Default Drive"
160 DISKOPT%=FIND%
170 PRINT"*** Subroutine Call"
180 CALL DISK% (DISKOPT%,DISKPARM$):SAVDRV$=DISKPARM$
190 PRINT"Got back and DEFAULT DRIVE is "CHR$(34)DISKPARM$ CHR$(34)
200 PRINT
210 '
220 'Set default drive
230 '
240 PRINT"Now let's set a new default drive":LOCATE ,,1:BEEP:PRINT
250 PRINT"Specify NEW default drive letter (A B C D:";:GOSUB 460
260 DISKPARM$=KY$:DISKOPT%=SET%
270 PRINT"*** Subroutine Call"
280 CALL DISK% (DISKOPT%,DISKPARM$)
290 PRINT"Return from subroutine and new default should be set"
300 '
310 ' ** Find out if it really changed
320 '
330 PRINT
340 PRINT"Find out if default drive really changed"
350 DISKOPT%=FIND%
360 PRINT"*** Subroutine Call"
370 CALL DISK% (DISKOPT%,DISKPARM$)
380 IF DISKPARM$<>SAVDRV$ THEN 420
390 SOUND 50,7:COLOR 0,7
400 PRINT"Default drive NOT changed. Invalid or same drive letter specified!"
410 COLOR 6,1:GOTO 440
420 PRINT"It's changed! The default drive is now "CHR$(34)DISKPARM$ CHR$(34)
430 SOUND 500,1:SOUND 400,1
440 END
450 '
460 '  **** Key-In Routine
470 '
480 KY$=INKEY$:IF KY$="" THEN 480
490 '
500 ' Check for small or capital letters
510 '
520 IF KY$<CHR$(97) OR KY$>CHR$(122) THEN 570
530 '
540 '  ** Change lowercase to uppercase
550 '
560 KY$=CHR$(ASC(KY$)-32)
570 '
580 PRINT KY$
590 RETURN
600 END' of program.
