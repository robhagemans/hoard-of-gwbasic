100 '
110 'Banner Printer Program
120 'by Randy Hawkins
130 '
135 COMMON RH: IF RH=0 THEN SYSTEM ELSE CLEAR
140 SCREEN 1: COLOR 1,1: KEY OFF: CLS: ON ERROR GOTO 850
145 KEY (17) ON: KEY 17, CHR$(0)+CHR$(1): ON KEY (17) GOSUB 740
150 PRINT CHR$(201); STRING$(38,205); CHR$(187);
160 PRINT CHR$(186);"  Randy's Super-Duper Banner Printer  ";CHR$(186);
170 PRINT CHR$(200); STRING$(38,205); CHR$(188)
180 LOCATE 5,1:PRINT "This program will allow you to enter"
190 PRINT "a message of almost any length (less"
200 PRINT "than 256 characters).  The message will"
210 PRINT "be printed 8-inches high horizontally"
220 PRINT "on your printer.  You may enter graphic"
230 PRINT "characters by using the ALT key and the"
240 PRINT "numeric keypad."
250 PRINT: PRINT"Type in your message, then press ENTER:"
260 PRINT: LINE INPUT "",M$
270 '
280 'Remind user to prepare printer
290 '
300 CLS: LINE (112,50)-(192,70),3,B
310 LINE (114,70)-(190,74),3,B
320 LINE (112,50)-(122,35)
340 LINE -(202,35)
350 LINE -(192,50)
360 LINE (202,35)-(202,55)
370 LINE -(192,70)
380 LINE (190,74)-(200,60)
390 LINE (126,20)-(186,45),3,BF
400 FOR A=120 TO 140 STEP 10
410 CIRCLE (A,65),1
420 NEXT A
430 LINE (160,63)-(185,67),3,BF
440 LOCATE 14,8
450 PRINT CHR$(250);"Is the printer power on?"
460 LOCATE 16,8: PRINT CHR$(250);"Is the paper positioned"
470 LOCATE 17,9: PRINT "at the top of the page?"
480 LOCATE 19,8: PRINT CHR$(250);"Is the printer ON-LINE?"
490 LOCATE 22,8: PRINT "Press ANY KEY when ready."
500 DEF SEG=0: POKE 1050,PEEK(1052): WHILE INKEY$="": WEND
510 '
520 'Print banner one-letter-at-a-time
530 '
540 CLS: LOCATE 12,17: PRINT "WORKING"
550 LINE (120,80)-(190,102),3,B
560 PAINT (121,81),2,3
570 PAINT (140,91),2,3
580 PAINT (148,89),2,3
590 FOR A=1 TO LEN(M$)
600 COLOR (A AND 7)
610 LOCATE 1,1: PRINT MID$(M$,A,1)
620 FOR B=0 TO 7
630 FOR C=1 TO 2
640 LPRINT STRING$(8,32);
650 FOR D=7 TO 0 STEP -1
660 '
670 'To change character printed, change value 88 below
680 '
690 IF POINT(B,D) THEN LPRINT STRING$(8,88); ELSE LPRINT STRING$(8,32);
700 NEXT D: LPRINT "": NEXT C,B,A
710 '
720 'Banner finished, print another?
730 '
740 COLOR 1: CLS: LOCATE 12,10
750 PRINT "Do you want to create"
760 LOCATE 14,10: PRINT "another banner (Y/N)?"
770 DEF SEG=0: POKE 1050, PEEK(1052)
780 A$=INPUT$(1): IF A$="Y" OR A$="y" THEN 140
790 IF A$<>"N" AND A$<>"n" THEN 780
800 SCREEN 0: WIDTH 80: COLOR 2,0,0: CLS
810 LOCATE 12,28: PRINT "One moment please...": RUN "menu"
820 '
830 'Error Trap
840 '
850 RESUME NEXT
