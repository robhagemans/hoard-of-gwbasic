10 '***** Disk Handler *****  from the October, 1983 issue of SofTalk, p.71.
20 '
30 'FIND or SET the default drive in a BASIC program.
40 '
50 'Written by Howard Glosser
60 'DEF SEG=&H1700. Use DEF SEG &HF00 for machine with LESS then 96K.
70 '
80 'This builds and checks the subroutine.
90 '
100 CLS
110 DEF SEG=&H1700' Use DEF SEG &HF00 for machine with LESS then 96K.
120 FOR MEM%=0 TO 66
130 READ DT%
140 POKE MEM%,DT%
150 CHECKSUM%=CHECKSUM%+DT%
160 NEXT
170 READ DT%
180 IF CHECKSUM%=DT% THEN 230
190 PRINT"Error in DATA Statements - Check lines 290 - 370":END
200 '
210 '******* This Saves the routine
220 '
230 BSAVE"DISKHAND.BIN",0,&H43
240 PRINT"Diskhandler routine created."
250 END
260 '
270 '***** DATA Statements to build routine
280 '
290 DATA &H55,&H8B,&HEC,&H8B,&H76,&H8,&H8B,&H14
300 DATA &H83,&HFA,&H1,&H74,&H8,&H83,&HFA,&H2
310 DATA &H74,&H10,&H90,&HEB,&H2A,&H90,&HB4,&H19
320 DATA &HCD,&H21,&HFE,&HC0,&H32,&HE4,&HC,&H40
330 DATA &HEB,&H15,&H90,&H8B,&H76,&H6,&H8B,&H7C
340 DATA &H1,&H8B,&H15,&H80,&HF2,&H40,&HFE,&HCA
350 DATA &HB4,&HE,&HCD,&H21,&HEB,&H9,&H90,&H8B
360 DATA &H7E,&H6,&H8B,&H75,&H1,&H88,&H4,&H5D
370 DATA &HCA,&H4,&H0,&H1D35
380 END' of program.
