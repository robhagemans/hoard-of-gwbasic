5 REM "tern-plt.bas"
6 CLS
10 SCREEN 0:WIDTH 80:PRINT "        TERNARY DIAGRAM PLOTTING PROGRAM"
15 PRINT "           written by Phillip K. Bigelow":PRINT:PRINT
16 PRINT "NOTE: to save the image to your clipboard, hold down the ALT key"
17 PRINT "while pressing the PRINT SCREEN key.  After exiting to Windows,"
18 PRINT "PASTE the image into your favorite image processor.":PRINT:PRINT:PRINT
20 PRINT "Make sure all three percentages add up to 100%.":PRINT
21 INPUT "How many points do you need to plot ", OP
22 PRINT:PRINT "LABLES FOR THE VERTICES: Use two-letter abbreviations if possible.":PRINT:INPUT "What label do you want to use for the top vertex  ";ZZ$
23 INPUT "What label do you want to use for the lower right vertex   ";YY$
24 INPUT "What label do you want to use for the lower left vertex   ";GG$
25 INPUT "Do you want the plotted points to be small <s> or big <b>  ";H$
28 DIM B(OP):DIM BB(OP):DIM BBB(OP)
29 FOR K=1 TO OP
30 CLS:PRINT "Point Count #";K
40 PRINT "Enter ";GG$;" percentage (lower left vertex)  ":INPUT B(K):REM H
50 PRINT "Enter ";ZZ$;" percentage (top vertex) ":INPUT BB(K):REM P
60 PRINT "Enter ";YY$;" percentage (lower right vertex) ":INPUT BBB(K):REM Q:CLS
62 LET T=(B(K)+BB(K)+BBB(K))
65 IF T<>100 THEN BEEP:IF T<>100 THEN BEEP
66 IF T<>100 THEN PRINT "Entry error!  The three percentages must total 100%! Try again. Press <enter>.":IF T<>100 THEN INPUT X
67 IF T<>100 THEN 30
90 NEXT K
100 KEY OFF:CLS:SCREEN 7:COLOR 1, 15
101 LOCATE 25, 27
102 PRINT YY$
103 LOCATE 1, 1
104 LOCATE 3, 13
105 PRINT ZZ$
106 LOCATE 1, 1
107 LOCATE 21, 1
108 PRINT GG$
109 LOCATE 1, 1
238 REM This trangle _IS_ equalateral.
254 REM
258 REM
259 REM
260 REM draw the triangle.
261 PSET (1,197)
270 DRAW "r200"
280 LINE (101, 24)-(201, 197)
351 LINE (1, 197)-(101, 24)
352 REM
353 REM
359 REM
530 REM
531 REM
532 REM
533 REM Copyright Hell Creek Life, 2009 Phillip Bigelow
534 FOR K=1 TO OP
535 LET T=(B(K)+BB(K)+BBB(K))
536 LET D1=(B(K)/T)*173.153
537 LET D2=(BB(K)/T)*173.153
538 LET D3=(BBB(K)/T)*173.153
541 REM
542 REM
543 REM
544 REM compute the coordinates of 1st value
545 LET D1A=D1*.8650311293#:REM gives the length of line A of triangle
546 LET CD1A=151-D1A: REM gives the corrected coordinates of A
547 LET D1B=SQR((D1)^2-(D1A)^2):REM gives the length of line B of triangle
548 LET CD1B=110.5+D1B:REM gives the corrected coordinates of B
551 REM
552 REM
553 REM
554 REM compute the coordinates of 2nd value
555 LET CD2B=197-D2:REM gives the corrected coordinates of B
558 REM
559 REM
560 REM
561 REM compute the coordinates of 3rd value
562 LET D3B=D3*.5017181932#:REM gives length of line B of triangle
563 LET CD3B=110.5+D3B:REM gives the corrected coordinates of B
564 LET D3A=SQR((D3)^2-(D3B)^2):REM gives the length of line A of triangle
565 LET CD3A=51+D3A:REM gives the corrected coordinates of A
568 REM
569 REM
570 REM
576 REM Plot the ternary point
577 IF CD1A<CD2A AND CD1B<CD2B THEN 600
578 IF CD1A>CD2A AND CD1B<CD2B THEN 600
579 IF CD1A>CD2A AND CD1B>CD2B THEN 700
580 IF CD1A<CD2A AND CD1B>CD2B THEN 800
581 REM
600 LET ADJ=CD2B-CD1B
601 LET OPP=ADJ*.57735
602 LET PP=CD1A+OPP
603 IF H$="s" THEN COLOR 9, 15:IF H$="s" THEN CIRCLE (PP, CD2B), 0
604 IF H$="b" THEN COLOR 9, 15:IF H$="b" THEN CIRCLE (PP, CD2B), 1
605 GOTO 1000
700 LET ADJ=CD1B-CD2B
701 LET OPP=ADJ*.57735
702 LET PP=CD1A-OPP
703 IF H$="s" THEN COLOR 9, 15:IF H$="s" THEN CIRCLE (PP, CD2B), 0
704 IF H$="b" THEN COLOR 9, 15:IF H$="b" THEN CIRCLE (PP, CD2B), 1
705 GOTO 1000
800 LET OPP=CD1B-CD2B
820 LET ADJ=OPP/.57735
830 LET PP=CD1A-ADJ
840 IF H$="s" THEN COLOR 9, 15:IF H$="s" THEN CIRCLE (PP, CD2B), 0
841 IF H$="b" THEN COLOR 9, 15:IF H$="b" THEN CIRCLE (PP, CD2B), 1
1000 NEXT K
2001 COLOR 1, 15
2002 INPUT "press `enter/return' to clear screen ",G$
2003 CLS
2004 PRINT:PRINT "To plot more data, type `run'"
2005 PRINT "and press `return' key."
2006 PRINT "To exit program, type"
2007 PRINT "`system' and then press `return'"
2008 PRINT "key.":PRINT:PRINT
