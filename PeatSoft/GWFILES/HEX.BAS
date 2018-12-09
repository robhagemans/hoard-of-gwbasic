100 '
101 ' Binary-to-hex-and-back-again conversion program for the IBM PC
102 '
103 ' Copyright (C) 1982 J. P. Garbers.  All rights reserved.
104 '
105 '
110 LN$="\"+SPACE$(78)+"\"
120 DEF SEG = 64 : KSTATE = PEEK(23) : POKE 23,32 : DEF SEG  ' set NUM LOCK state, saving current state for later
130 TROFF : ON ERROR GOTO 10000
140 DEF FNA(X$) = 40 - LEN(X$)/2
150 DIM PRO$(6)
170 EXPERT = 0 ' rem expert 1 needs no CR after menu choice, expert 0 wants CR
200 GOSUB 2000 ' do the ego module
210 WHILE NOT DONE : GOSUB 3000 : WEND  ' process menu requests
220 GOTO 9900 ' end stuff
2000 ' ego module
2010 COLOR 7,0 : KEY OFF : CLS : LOCATE 12,1 : COLOR 0,7
2020 PRINT " The following program is brought to you by a grant from Userview Corporation.  ";
2025 COLOR 7,0
2030 FOR TIME = 1 TO 1500 : IF INKEY$<>"" THEN TIME = 1500
2040 NEXT TIME : IF EXPERT THEN RETURN ELSE GOSUB 2300 ' title line and cls
2050 INPUT "Would you like instructions";INST$: IF INST$="" THEN INST$="N"
2060 IF LEFT$(INST$,1)<>"Y" AND LEFT$(INST$,1)<>"y" THEN RETURN
2070 LOCATE 8,1
2080 PRINT "This program allows you to convert binary files from one format to"
2085 PRINT "another.   HEX format files may be easily  transmitted over  phone"
2090 PRINT "lines  and  information  services since  they consist  entirely of"
2095 PRINT "readable characters, but they cannot be used directly as commands."
2100 PRINT "COM  and EXE files may be used  directly as DOS commands,  but are"
2105 PRINT "difficult to send and receive without special software."
2110 PRINT
2115 PRINT "    You can use this program  to convert COM and EXE files to HEX"
2120 PRINT "format files to send your files to someone else, and also use"
2125 PRINT "it to convert HEX files you've received to executable format."
2130 PRINT : CV = CSRLIN : GOSUB 2200 : LOCATE CV, 1
2135 PRINT "You'll tell this program what you want to do by selecting choices"
2140 PRINT "from menus.  To make a selection, press the numbered key corres-"
2145 PRINT "ponding to your choice and it will light up.  You may change your"
2150 PRINT "mind by pressing a different number, and the new choice will light"
2155 PRINT "up.  When the correct choice is lit up, press ENTER.  You may also"
2160 PRINT "press ESC to return to the previous menu."
2165 PRINT
2170 PRINT "As you get used to the program, you may wish to use 'expert mode'."
2175 PRINT "In expert mode you don't have to press ENTER after making your"
2180 PRINT "numbered choice, so make sure you press the right key the first"
2185 PRINT "time.":PRINT
2190 GOSUB 2200 : RETURN
2200 ' wait for keypress
2210 LOCATE 24,4:COLOR 0,7
2220 PRINT "Press the SPACE BAR to continue, or ESC to stop using this program.";
2225 PAUSE$=""
2230 WHILE PAUSE$="": PAUSE$=INKEY$: WEND: COLOR 7,0
2235 IF ASC(PAUSE$)=27 THEN 9900 ' stopped in the middle
2240 LOCATE 24,1:PRINT SPACE$(79);: RETURN
2300 ' title line
2310 CLS : IF QUIET THEN RETURN ELSE COLOR 0,7 : PRINT
2320 PRINT USING LN$; "      Binary-to-hex-and-back-again conversion program for the IBM PC";
2330 PRINT USING LN$; "          Copyright (C) 1982 J. P. Garbers.  All rights reserved.";
2340 PRINT: COLOR 7,0 : RETURN
2400 ' convert cap$ to caps
2410 FOR I = 1 TO LEN(CAP$):E$=MID$(CAP$,I,1):IF E$>="a" AND E$<="z" THEN MID$(CAP$,I,1) = CHR$(ASC(E$)-32)
2420 NEXT I : RETURN
3000 '
3001 ' Main menu
3002 '
3020 NC = 5 : TITLE$="Main Menu"
3030 PRO$(1) = "Convert to COM or EXE format (make command file)"
3035 PRO$(2) = "Convert to HEX format (make transmittable file)"
3040 PRO$(3) = "List the files on your diskette"
3045 IF EXPERT THEN PRO$(4)="Turn expert mode OFF" ELSE PRO$(4) = "Turn expert mode ON"
3047 PRO$(5) = "Stop using this program"
3050 GOSUB 8000 : IF CHOICE = 69 THEN 9900
3060 ON CHOICE GOSUB 4000, 5000, 6000, 7000, 7500
3070 RETURN
4000 '
4001 ' Convert to binary format
4002 '
4010 GOSUB 2300
4020 PRINT : PRINT "Enter name of file to convert to executable format.  If you do not specify an"
4025 PRINT "extension, .HEX will be assumed."
4030 PRINT "-> "; : LINE INPUT INFILE$
4040 IF INSTR(INFILE$,".")=0 THEN INFILE$=INFILE$+".HEX"
4050 OPEN "I", 1, INFILE$ ' open it up
4060 CAP$=LEFT$(INFILE$, INSTR(INFILE$,".")-1)+".COM":GOSUB 2400:OUTFILE$=CAP$
4070 PRINT "Enter full name of output file (press ENTER alone to use "; OUTFILE$;")"
4080 PRINT "-> "; : LINE INPUT FAME$ : IF LEN(FAME$) THEN OUTFILE$=FAME$
4085 CAP$=OUTFILE$:GOSUB 2400:OUTFILE$=CAP$
4090 LOCATE CSRLIN-1,4 : PRINT OUTFILE$
4100 OPEN "R", 2, OUTFILE$, 1 : FIELD 2, 1 AS O$
4110 NBYTES = 0 : CKSUM = 0 : PRINT : PRINT "Working";
4120 WHILE NOT EOF(1)
4125 LINE INPUT #1, IN$ : IF LEN(IN$)=0 THEN 4180
4130 IF ASC(IN$)=59 THEN GOSUB 4250: GOTO 4180 ' remark handler
4140 FOR I = 1 TO LEN(IN$) STEP 2 : BT = VAL("&H"+MID$(IN$,I,2))
4150 NBYTES = NBYTES + 1 : CKSUM = (CKSUM + BT) MOD 2048 : IF NBYTES MOD 32 = 0 THEN PRINT ".";
4160 LSET O$= CHR$(BT) : PUT 2 : NEXT I
4180 WEND
4190 CLOSE : PRINT : PRINT : PRINT OUTFILE$; " created,"; NBYTES; "bytes recorded."
4200 GOSUB 2200 : RETURN
4250 ' handle imbedded remarks
4255 IF LEFT$(IN$, 9) <> ";checksum" THEN 4270
4258 PRINT:PRINT :PRINT "Checksum mark found... ";
4260 CK = VAL(RIGHT$(IN$,LEN(IN$)-9))
4265 IF CK = CKSUM THEN PRINT "Checksum verified." ELSE PRINT "Checksum incorrect."
4270 RETURN
4290 RETURN ' go back to the wend
5000 '
5001 ' Convert to hex format
5002 '
5010 GOSUB 2300
5020 PRINT : PRINT "Enter full name of file to convert to .HEX format, including the extension."
5030 PRINT "-> "; : LINE INPUT INFILE$
5040 OPEN "I", 1, INFILE$ : CLOSE 1 ' test to see if it's there
5045 OPEN "R", 1, INFILE$, 1 : FIELD 1, 1 AS I$
5050 NBYTES = 0 : CKSUM = 0
5060 IF INSTR(INFILE$,".")=0 THEN INFILE$=INFILE$+"."
5070 CAP$=LEFT$(INFILE$,INSTR(INFILE$,".")-1)+".HEX":GOSUB 2400:OUTFILE$=CAP$
5080 PRINT "Enter full name of output HEX file (press ENTER alone to use "; OUTFILE$;")"
5090 PRINT "-> "; : LINE INPUT FAME$ : IF LEN(FAME$) THEN OUTFILE$=FAME$
5095 LOCATE CSRLIN-1, 4 : PRINT OUTFILE$
5100 OPEN "O", 2, OUTFILE$
5105 PRINT : PRINT "Working";
5110 GET 1
5120 WHILE NOT EOF(1)
5130 PRINT #2, RIGHT$("0"+HEX$(ASC(I$)), 2);
5135 CKSUM = (CKSUM + ASC(I$)) MOD 2048 ' keep checksum running
5140 NBYTES = NBYTES + 1 : IF NBYTES MOD 32 = 0 THEN PRINT #2,:PRINT ".";
5150 GET 1 : WEND  : PRINT #2,
5155 PRINT #2, ";checksum "; CKSUM
5160 CLOSE : PRINT :PRINT: PRINT OUTFILE$; " created,"; NBYTES; "bytes recorded."
5990 GOSUB 2200 : RETURN
6000 '
6001 ' files listing
6002 '
6020 NC = 3 : TITLE$="Diskette file listing"
6030 PRO$(1) = "List files on drive A" : PRO$(2) = "List files on drive B"
6035 PRO$(3) = "Return to main menu"
6040 GOSUB 8000 : IF CHOICE = 69 OR CHOICE = 3 THEN RETURN
6050 GOSUB 2300 : PRINT
6060 INPUT "What sort of files (i.e. COM, EXE, HEX)?  Press ENTER alone for all files"; EXT$
6065 IF LEN(EXT$)=0 THEN EXT$="*" ELSE IF LEN(EXT$)>3 THEN EXT$=LEFT$(EXT$,3)
6070 CAP$=EXT$ : GOSUB 2400 : EXT$=CAP$
6075 PRINT: IF EXT$="*" THEN PRINT "Files"; ELSE PRINT ".";EXT$;" files:";
6080 PRINT " on drive "; CHR$(64+CHOICE); ":" : PRINT
6190 FILES CHR$(64+CHOICE)+":*."+EXT$
6200 GOSUB 2200 : GOTO 6000
7000 '
7001 ' swap expert mode
7002 '
7010 EXPERT = 1 - EXPERT
7020 LOCATE 23, 10:PRINT "Expert mode is now "; : IF EXPERT THEN PRINT "on." ELSE PRINT "off."
7030 FOR I = 1 TO 1000: NEXT I : RETURN
7500 '
7501 ' end of program
7502 '
7510 CLOSE : DONE = -1: RETURN
8000 '
8001 ' menu processor
8010 GOSUB 2300 : LOCATE 7, FNA(TITLE$) : COLOR 1,7 : PRINT TITLE$ : COLOR 7,0
8020 LONGEST = 0 : FOR I = 1 TO NC : IF LEN(PRO$(I))>LONGEST THEN LONGEST = LEN(PRO$(I))
8030 NEXT I : CHOICE = 0 : XP = 38-LONGEST/2
8040 FOR I = 1 TO NC : LOCATE 8+I*2, XP :IF CHOICE = I THEN COLOR 8,1 ELSE COLOR 7,0
8050 PRINT CHR$(48+I);". "; PRO$(I) : NEXT I : COLOR 7,0
8085 LOCATE 21, 5: IF EXPERT THEN PRINT "EXPERT MODE: Press "; ELSE PRINT "Press ";
8090 IF NC = 2 THEN PRINT "1 or 2 "; ELSE FOR I = 1 TO NC-1 : PRINT CHR$(48+I);", "; : NEXT I : PRINT "or"; NC;
8095 IF EXPERT THEN PRINT "to make your choice." ELSE PRINT "to light up your choice, then press ENTER."
8100 COLOR 7,0: CM$="" : WHILE CM$="" : CM$=INKEY$ : WEND
8105 IF ASC(CM$)=27 THEN CHOICE = 69 : RETURN
8110 CM = ASC(CM$) - ASC("0") :IF CM >=1 AND CM <=NC THEN CHOICE = CM
8115 IF (EXPERT OR CM$=CHR$(13)) AND (CHOICE>0) THEN RETURN ELSE 8040
9900 '
9901 ' closing frame
9902 '
9910 CLS
9920 LOCATE 12,8:PRINT "End of program.  Press the key marked 'F2' to run it again."
9925 KEY 2, "RUN"+CHR$(13) : KEY ON ' make sure that boast holds
9930 LOCATE 22,1 : DEF SEG = 64 : POKE 23, KSTATE 'recover former KB state
9940 END
10000 '
10001 ' error handling stuff
10002 '
10010 IF ERL = 6190 THEN LOCATE CSRLIN-2, 1 : PRINT "No ."; EXT$; " files on this diskette.": RESUME NEXT
10020 IF ERL = 5040 OR ERL = 4050 THEN PRINT : PRINT "Unable to open input file." : CLOSE : RESUME 2200
10030 IF ERL = 5100 OR ERL = 4100 THEN PRINT : PRINT "Unable to open output file." : CLOSE : RESUME 2200
10999 CLS : LOCATE 12, 10: PRINT "Unexpected error #"; ERR; "at line"; ERL: ON ERROR GOTO : END
file." : CLOSE : RESUME 2200
10999 CLS : LOCATE 12, 10: PRINT "Unexpected error #"; ERR; "at line"; ERL: ON ERROR GOTO : EN