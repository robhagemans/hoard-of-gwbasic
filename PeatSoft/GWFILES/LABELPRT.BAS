10 '                    MAKE SURE DIRECTRY.BIN IS ON THE DEFAULT DRIVE!
20 '
30 '     ** Written by Howard Glosser
40 '     ** from Jan. 1984 issue of SOFTALK magazine. pp 124-128.
50 '
60 '     ** MODIFIED FOR LABEL PRINTING (ON EPSON MX w/GT & FX) **
70 '     ** by Steven Maller (70436,7145) 1-19-84 **
80 '
90 '     **** Store DIRECTORY subroutine in string ****
100 CLS
110 LOCATE 13,20 : COLOR 25 : PRINT "TURN ON YOUR PRINTER!"
120 LPRINT CHR$(27);"@";
130 COLOR 7
140 CLS
150 KEY OFF
160 DEF SEG
170 SUBRT$=STRING$(159,32)
180 SUBLC%=VARPTR(SUBRT$)
190 GOSUB 610
200 BLOAD"DIRECTRY.BIN",DIRECT
210 '    ** Define constants necessary in program **
220 DIM DIRLST$(111)
230 FCB$=STRING$(33,32)
240 DTA$=STRING$(33,32)
250 FILLER$=STRING$(12,32)
260 MARK$ = STRING$(10,205)
270 COUNT%=0
280 '    ** Set DIRLST$(0) to blanks **
290 FOR LOOP%=0 TO 111:DIRLST$(LOOP%)=FILLER$:NEXT
300 CLS
310 '          ** Select drive for reading directory **
320     LOCATE 1,10 : PRINT MARK$; : PRINT " * * * ";
330     COLOR 10:PRINT "DISK-LABEL PRINTING PROGRAM";
340     COLOR 7 : PRINT " * * * " MARK$
350     LOCATE 10,10 : FOR Q = 1 TO 6 : PRINT MARK$; : NEXT
360     LOCATE 12,20 : COLOR 18 : PRINT "Make sure your printer is ready...";
370     COLOR 7
380     LOCATE 3,10,1
390     PRINT"Specify drive letter for directory (A B C D): ";
400 '
410 GOSUB 630:DRV$=KY$
420 '    ** Find out if drive letter is valid **
430 HIT%=INSTR("ABCD",DRV$)
440 IF HIT%=0 THEN SOUND 50,7:GOTO 380 ELSE PRINT DRV$
450 '    ** Call to DIRECTRY subroutine **
460 LOCATE ,,0:GOSUB 610
470 CALL DIRECT(DRV$,FCB$,DTA$,DIRLST$(0),COUNT%)
480 '    ** List results of DIRECTRY call **
490 GOSUB 730
500 LOCATE 5,10
510 PRINT"Directory on drive "DRV$" contains"COUNT%"entries."
520 PRINT
530 FOR LOOP%=0 TO COUNT%-1:LPRINT DIRLST$(LOOP%)SPC(1);:NEXT :LPRINT
540 LPRINT CHR$(12);
550 PLAY "MBMLL8O4CDG"
560 PRINT:PRINT TAB(10) "Press ESCAPE to QUIT or any other key to continue"
570 GOSUB 630:CN$=KY$
580 IF ASC(CN$)=27 THEN 780
590 GOTO 270
600 '    ** Retrieve location of subroutine **
610 DIRECT=PEEK(SUBLC%+1)+PEEK(SUBLC%+2)*256
620 RETURN
630 '    ** KEYIN subroutine **
640 KY$=INKEY$: IF KY$="" THEN 640
650 '   ** Check for Escape key **
660 IF ASC(KY$) = 27 THEN 780
670 '    ** Check for small or capital letters **
680 IF KY$<CHR$(97) OR KY$>CHR$(122) THEN 710
690 '    ** Change lowercase to uppercase **
700 KY$=CHR$(ASC(KY$)-32)
710 RETURN
720 '    ** Printer instructions for Tiny Print **
730 WIDTH "LPT1:",63
740 LPRINT CHR$(15);CHR$(27);"S1";CHR$(27);"A";CHR$(4);CHR$(27);"Q";CHR$(77);
750 LPRINT CHR$(27);"l";CHR$(12);CHR$(27);"C";CHR$(18);CHR$(27);"N";CHR$(2);
760 RETURN
770 '
780 LPRINT CHR$(27);"@" ;: WIDTH"lpt1:",80
790 CLS : SYSTEM
      