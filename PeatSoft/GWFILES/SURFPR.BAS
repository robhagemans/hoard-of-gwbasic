10 DEFINT A-Z
20 I=0:J=0:BOX=0:X=0:Y=0:Z=0:REC=0:A$="":X$="":FS$="SURF87.EXE"
30 TRUE=-1:FALSE=0:B1=0:B2=0:B3=0:B4=0:ROW=0:COL=0:SURF$=SPACE$(32)+"SURFACE87"
40 DIM WORD(64),BYTE(128),FILE$(64),PCODE(20),PCODE$(32)
50 DEF SEG : POKE 106,0 : KEY OFF : KEY 10,""
60 FOR I=1 TO 32 : READ PCODE$(I) : NEXT
70 DATA soh,stx,etx,eot,enq,ack,bel,bs,ht,lf,vt,ff,cr,so,si,dle
80 DATA dc1,dc2,dc3,dc4,nak,syn,etb,can,em,sub,esc,fs,gs,rs,us,sp
90 GOTO 1000
100 ' open
110 ON ERROR GOTO 200
120 OPEN FS$ FOR INPUT AS #1
130 CLOSE #1
140 OPEN FS$ AS #1 LEN=128
150 FOR I=0 TO 63:FIELD #1,I*2 AS DUMMY$,2 AS FILE$(I) : NEXT
160 ON ERROR GOTO 0
170 RETURN
200 ' file error stuff
210 CLOSE
220 IF ERR=71 THEN PRINT "Disk not ready. Please try again." : RESUME
230 IF ERR=70 THEN PRINT "Disk is write protected. Please remove tab to write mods to disk." : RESUME
240 IF ERR=53 THEN PRINT "I can't find "+FS$+"." : GOSUB 250 : RESUME
245 GOTO 260
250 LINE INPUT "Please re-enter filename -->";FS$ : RETURN
260 IF ERR=75 OR ERR=76 THEN PRINT FS$+" has a PATH problem." : GOSUB 250 : RESUME
270 IF ERR=72 OR ERR=57 THEN PRINT "Sorry, can't seem to work with this disk" : ON ERROR GOTO 0 : END
280 ON ERROR GOTO 0
290 GOTO 500
300 'get record
310 ON ERROR GOTO 200
320 GET #1,REC
330 FOR I=0 TO 63 : WORD(I)=CVI(FILE$(I)) : NEXT
340 ON ERROR GOTO 0
350 RETURN
400 ' box b1,b2-b3,b4  --> top.row,top.col-bot.row,bot.col
405 ROW=CSRLIN:COL=POS(0)
410 LOCATE B1,B2,0 : PRINT CHR$(201); : PRINT STRING$(B4-B2-1,205);CHR$(187);
420 FOR BOX=B1+1 TO B3-1 : LOCATE BOX,B2 : PRINT CHR$(186);:LOCATE BOX,B4:PRINT CHR$(186); :NEXT
430 LOCATE B3,B2 : PRINT CHR$(200); : PRINT STRING$(B4-B2-1,205);CHR$(188);
440 LOCATE ROW,COL
450 RETURN
500 ' end
510 KEY 10,"SCREEN 0,0,0"+CHR$(13)
520 KEY ON
530 END
600 ' enter printer codes from keyboard.
610 LOCATE ,,1 : X=0 : ROW=CSRLIN : COL=POS(0)
620 I$="" : WHILE I$="" : I$=INKEY$ : WEND
630 IF I$=CHR$(0)+CHR$(68) THEN 700 ' finished
640 IF I$<>CHR$(0)+CHR$(83) THEN 650
645 X=X-1 : IF X<1 THEN X=0 : BEEP : LOCATE ROW,COL,1 : PRINT SPACE$(20); : LOCATE ROW,COL,1 : GOTO 620 ELSE 660
650 PCODE(X)=ASC(I$) : X=X+1 : IF X>15 THEN PRINT : PRINT "Only 16 allowed." : GOTO 700
660 LOCATE ROW,COL,1 : PRINT SPACE$(X*3+10); : LOCATE ROW,COL,1
670 FOR I=0 TO X-1 : IF PCODE(I)<33 THEN PRINT PCODE$(PCODE(I));" "; ELSE PRINT CHR$(PCODE(I));" ";
680 NEXT
690 GOTO 620
700 PRINT : PRINT "Is this correct (y/n)?"
710 I$=INKEY$ : IF I$="n" OR I$="N" THEN LOCATE ROW,COL : PRINT SPACE$(X*3+10);
720 IF I$="n" OR I$="N" THEN LOCATE ROW+1,COL : PRINT SPACE$(24); : LOCATE ROW,COL : GOTO 610
730 IF I$<>"y" AND I$<>"Y" THEN 710
740 RETURN
800 ' write a record
810 ON ERROR GOTO 200
820 FOR I=0 TO 63 : LSET FILE$(I)=MKI$(WORD(I)) : NEXT
830 PUT #1,REC
840 ON ERROR GOTO 0
850 RETURN
900 ' print codes in hex -- x=bytes,z=word(z)
910 A$=HEX$(WORD(Z)) : IF LEN(A$)=3 THEN B$="0"+LEFT$(A$,1) ELSE B$=LEFT$(A$,2)
920 PRINT B$+CHR$(32);
930 Y=X\2
940 FOR I=1 TO Y
950   A$=HEX$(WORD(I+Z))
960   IF LEN(A$)=1 THEN A$="000"+A$ ELSE IF LEN(A$)=2 THEN A$="00"+A$ ELSE IF LEN(A$)=3 THEN A$="0"+A$
970   PRINT RIGHT$(A$,2)+CHR$(32); : PRINT LEFT$(A$,2)+CHR$(32);
980 NEXT
990 Y=X MOD 2
995 IF Y=0 THEN ROW=CSRLIN : COL=POS(0) : LOCATE ROW,COL-3 : PRINT SPACE$(3);
996 PRINT
997 RETURN
1000 ' main
1010 CLS
1020 PRINT SURF$
1030 PRINT
1040 PRINT "                       Printer installation program"
1050 PRINT
1060 PRINT "                      (c) 1983 Martin R. Smith, Jr."
1070 PRINT
1080 PRINT "                        Press <enter> to continue.";
1090 LOCATE ,,1
1100 I$=INKEY$ : IF I$="" THEN 1100
1110 PRINT : PRINT : PRINT
1120 PRINT "Surface87 should work with most dot-matrix printers that have a bit-plot"
1130 PRINT "mode. It is set up to send 960 bytes to the EPSON(tm) series of printers"
1140 PRINT "with GRAFTRAX(tm) firmware."
1150 PRINT
1160 PRINT "In order to make it work with other printers, I need to know:"
1180 PRINT
1190 PRINT "         (1) The filename you have given SURF87."
1200 PRINT "         (2) The way your printer treats bit-plot bytes."
1210 PRINT "         (3) How to set the printer line-spacing to 8/72 inch."
1220 PRINT "         (4) How to make the printer treat the next 960 bytes as bit-plots."
1225 PRINT "         (5) How to return the line-spacing to normal."
1230 PRINT :PRINT "In order to begin, get your printer manual out and hit <enter>,"
1240 PRINT "or hit <x> to quit.";
1250 I$=INKEY$ : IF I$=CHR$(13) THEN 1300 ELSE IF I$="x" OR I$="X" THEN 500 ELSE 1250
1300 ' enter data
1310 CLS
1320 PRINT SURF$
1330 PRINT
1340 PRINT "Please enter the name you have given SURFACE87"
1350 LINE INPUT "<enter> alone will assume SURF87.EXE. -->";A$
1360 IF A$="" THEN 1380
1370 FS$=A$
1380 GOSUB 100
1400 REC=1 : GOSUB 300
1410 IF WORD(0)=&H5A4D THEN 1500
1420 PRINT "This is not an .EXE type file."
1430 PRINT "Please make sure you have HEX-CONVERTED your download and try again."
1440 GOTO 500
1500 REC=5 : GOSUB 300
1510 IF WORD(7)=&HFB4 AND WORD(56)=&H303C THEN 1600
1520 PRINT "I don't think this is SURFACE87."
1530 PRINT "This program modifies an existing file, and might cause problems"
1540 PRINT "with "+FS$+", so please check that you have specified the right"
1550 PRINT "file and try again."
1560 GOTO 500
1600 CLS
1610 PRINT SURF$ : PRINT SPACE$(32)+FS$ : PRINT
1620 PRINT "Dot matrix printers in bit-plot mode represent dots in two ways:"
1630 PRINT
1640 PRINT "      METHOD 1       PRINT HEAD WIRES         METHOD 2"
1650 PRINT "                           TOP"
1660 PRINT "       80h 128              o                  01h   1"
1670 PRINT "       40h  64              o                  02h   2"
1680 PRINT "       20h  32              o                  04h   4"
1690 PRINT "       10h  16              o                  08h   8"
1700 PRINT "       08h   8              o                  10h  16"
1710 PRINT "       04h   4              o                  20h  32"
1720 PRINT "       02h   2              o                  40h  64"
1730 PRINT "       01h   1              o                  80h 128"
1740 PRINT "                          BOTTOM"
1750 B1= 5:B2=45:B3= 7:B4=57:GOSUB 400
1760 B1= 5:B2= 5:B3= 7:B4=17:GOSUB 400
1770 B1= 5:B2= 5:B3=16:B4=17:GOSUB 400
1780 B1= 5:B2=45:B3=16:B4=57:GOSUB 400
1800 PRINT "Please enter the number of the method your printer uses. (1 or 2) ";
1810 LOCATE ,,1
1820 I$=INKEY$ : IF I$<>"1" AND I$<>"2" AND I$<>CHR$(27) THEN 1820
1830 IF I$=CHR$(27) THEN 500
1840 IF I$="1" THEN DOTHEAD=TRUE : DH$="TOP DOT = 128" ELSE DOTHEAD=FALSE : DH$="TOP DOT = 1"
1850 REC=61 : GOSUB 300
1860 IF DOTHEAD THEN WORD(0)=&H201:WORD(1)=&H804:WORD(2)=&H2010:WORD(3)=&H8040: GOTO 1900
1870 WORD(0)=&H4080:WORD(1)=&H1020:WORD(2)=&H408:WORD(3)=&H102
1900 CLS : PRINT SURF$ : PRINT SPACE$(32)+FS$ : PRINT SPACE$(32)+DH$ : PRINT
1910 PRINT "The next three items involve sending codes to the printer."
1920 PRINT
1930 PRINT "In order to make this as easy as possible, your keyboard will"
1940 PRINT "become a code generator.  Each key will be treated literally."
1950 PRINT
1970 PRINT "For example, say you need to send and ESCape to the printer."
1980 PRINT "Just hit the ESCape key, and I'll know what you mean."
1990 PRINT "If you need to send a number, hold down the ALT key, type"
2000 PRINT "the number on the numeric keypad, and then release the ALT key."
2010 PRINT "To send the letter 'A' or the letter '8', just type it in."
2020 PRINT
2030 PRINT "If you make a mistake, use the DEL key on the numeric keypad as a backspace."
2040 PRINT "When you are done, press the F10 - Function Key 10."
2050 PRINT
2060 PRINT "A table of ASCII codes for below 33 will be at the top of the"
2070 PRINT "screen to help."
2080 PRINT : PRINT "    Press <enter> when you are ready to begin."
2090 I$=INKEY$ : IF I$="" THEN 2090
2100 CLS : PRINT
2110 PRINT "   1 = soh    2 = stx    3 = etx    4 = eot    5 = enq    6 = ack    7 = bel "
2120 PRINT "   8 =  bs    9 =  ht   10 =  lf   11 =  vt   12 =  ff   13 =  cr   14 =  so "
2130 PRINT "  15 =  si   16 = dle   17 = dc1   18 = dc2   19 = dc3   20 = dc4   21 = nak "
2140 PRINT "  22 = syn   23 = etb   24 = can   25 =  em   26 = sub   27 = esc   28 =  fs "
2150 PRINT "  29 =  gs   30 =  rs   31 =  us   32 =  sp"
2160 B1=1:B2=1:B3=7:B4=78 : GOSUB 400
2170 PRINT
2180 PRINT "Enter your codes, using the DEL key as a backspace, the F10 key when done." : PRINT
2190 PRINT "First, I need the codes to set your printer to 8/72 inch."
2200 PRINT "Any other initial set-up code should go here."
2210 GOSUB 600
2220 IF X = 0 THEN 2310
2230 A$=HEX$(X) : IF LEN(A$)=1 THEN A$="0"+A$
2240 B$=HEX$(PCODE(0)) : CODE$="&H"+B$+A$
2250 WORD(8)=VAL(CODE$)
2260 FOR I=1 TO X STEP 2
2270   A$=HEX$(PCODE(I)) : IF LEN(A$)=1 THEN A$="0"+A$
2280   B$=HEX$(PCODE(I+1)) : CODE$="&h"+B$+A$
2290   WORD((I+1)\2+8)=VAL(CODE$)
2300 NEXT
2310 PRINT
2320 PRINT "Second, I need codes to print the next 960 bytes as bit plots."
2330 GOSUB 600
2340 IF X = 0 THEN 2430
2350 A$=HEX$(X) : IF LEN(A$)=1 THEN A$="0"+A$
2360 B$=HEX$(PCODE(0)) : CODE$="&H"+B$+A$
2370 WORD(24)=VAL(CODE$)
2380 FOR I=1 TO X STEP 2
2390   A$=HEX$(PCODE(I)) : IF LEN(A$)=1 THEN A$="0"+A$
2400   B$=HEX$(PCODE(I+1)) : CODE$="&h"+B$+A$
2410   WORD((I+1)\2+24)=VAL(CODE$)
2420 NEXT
2430 PRINT
2440 PRINT "Last, I need printer codes to reset things back to normal."
2445 PRINT "Then send two line feeds (chr$(10) or ^J) to advance paper to top of form."
2450 GOSUB 600
2460 IF X = 0 THEN 2550
2470 A$=HEX$(X) : IF LEN(A$)=1 THEN A$="0"+A$
2480 B$=HEX$(PCODE(0)) : CODE$="&H"+B$+A$
2490 WORD(16)=VAL(CODE$)
2500 FOR I=1 TO X STEP 2
2510   A$=HEX$(PCODE(I)) : IF LEN(A$)=1 THEN A$="0"+A$
2520   B$=HEX$(PCODE(I+1)) : CODE$="&h"+B$+A$
2530   WORD((I+1)\2+16)=VAL(CODE$)
2540 NEXT
2550 PRINT
2600 CLS
2610 PRINT SURF$
2620 PRINT : PRINT FS$
2630 PRINT : PRINT DH$
2640 PRINT : PRINT "Codes to set line space to 8/72 inch (in hex):"
2650 X=WORD(8) AND 255 : Z=8
2660 GOSUB 900
2670 PRINT : PRINT "Codes to set up 960 bit-plot bytes:"
2680 X=WORD(24) AND 255 : Z=24
2685 GOSUB 900
2690 PRINT : PRINT "Codes to reset printer:"
2700 X=WORD(16) AND 255 : Z=16
2710 GOSUB 900
2720 PRINT : PRINT "Does everything look correct (y/n)?"
2730 LOCATE ,,1
2740 I$=INKEY$ : IF I$="n" OR I$="N" THEN 1600
2750 IF I$<>"y" AND I$<>"Y" THEN 2740
2760 GOSUB 800
2770 CLOSE #1
2780 PRINT : PRINT FS$+" has been installed with new printer codes!"
2790 GOTO 500
