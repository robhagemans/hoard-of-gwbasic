10 ' basidraw.bas - FreeWare 2005 - Eric Tchong
20 GOTO 70 ' begin
30 SAVE "basidraw.bas",A:LIST-70
40 GOTO 660 ' wait for key
50 GOTO 690 ' centered text
60 ' begin
70 DEFSTR M,Q:Q=MKI$(0):DEFINT X,Y,I,N    ' locals
80 ON ERROR GOTO 0
90 DIM M(16):X=0:Y=0:E=X:F=Y:SW=2:SCREEN 1:KEY OFF
100 M(1) ="Drawing program commands:"
110 M(2) ="<D>raw <E>rase <M>ove  <Backspace> CLS"
120 M(3) ="<S>ave to    basdraw.txt"
130 M(4) ="<R>ead from  basdraw.txt"
140 M(5) ="<Enter> read *.txt files"
150 M(6) ="Arrow keys for  Up Down Left Right"
160 M(7) ="<7> 0,0    <8> 159,0   <9> 319,0  "
170 M(8) ="<4> 0,99   <5> 159,99  <6> 319,99 "
180 M(9) ="<1> 0,199  <2> 159,199 <3> 319,199"
190 M(10)="<Page Up> 10 pos Up <Page Dn> 10 pos Dn"
200 M(11)="<Ctrl+left  arrow> 10 pos left "
210 M(12)="<Ctrl+right arrow> 10 pos right"
220 M(13)="<Esc> ends program"
230 M(14)="Press any key to start"
240 M(15)="":M(16)="Press a key to restart program."
250 CLS:LOCATE 2,1
260 FOR I=1 TO 14
270  GOSUB 50:IF I=1 OR I=5 OR I=6 OR I=9 OR I=12 THEN PRINT
280 NEXT:GOSUB 40:CLS
290 ' main
300 LSET Q=MKI$(0)
310 WHILE CVI(Q)=0
320  IF POINT(X,Y)=0 THEN PSET(X,Y):PRESET(X,Y) ELSE PRESET(X,Y):PSET(X,Y)
330  IF SW=2 THEN 350
340  IF SW=1 THEN PSET(X,Y) ELSE PRESET(X,Y)
350  MID$(Q,1)=INKEY$:D=ASC(Q):IF CVI(Q) THEN 360
360 WEND
370 IF D=27 THEN 730                   ' Esc
380 IF D=100 OR D=68 THEN SW=1         ' Draw
390 IF D=101 OR D=69 THEN SW=0         ' Erase
400 IF D=109 OR D=77 OR D=32 THEN SW=2 ' Move or spacebar
410 IF D=115 OR D=83 THEN 710          ' Save basdraw.txt file
420 IF D=114 OR D=82 THEN 910          ' Read basdraw.txt file
430 IF D=13 THEN 920                   ' Enter read disk files
440 IF D= 8 THEN 720                   ' Backspace clear screen
450 IF D=57 THEN X=319:Y=0  :E=X:F=Y   ' 9 = Right Up
460 IF D=56 THEN X=159:Y=0  :E=X:F=Y   ' 8 = Up center
470 IF D=55 THEN X=0:Y=0    :E=X:F=Y   ' 7 = Left Up
480 IF D=54 THEN X=319:Y=99 :E=X:F=Y   ' 6 = Right center
490 IF D=53 THEN X=159:Y=99 :E=X:F=Y   ' 5 = Center
500 IF D=52 THEN X=0:Y=99   :E=X:F=Y   ' 4 = Left center
510 IF D=51 THEN X=319:Y=199:E=X:F=Y   ' 3 = Right Down
520 IF D=50 THEN X=159:Y=199:E=X:F=Y   ' 2 = Down center
530 IF D=49 THEN X=0:Y=199  :E=X:F=Y   ' 1 = Left Down
540 IF CVI(Q)=18688 THEN Y=Y-10        ' Page Up
550 IF CVI(Q)=20736 THEN Y=Y+10        ' Page Down
560 IF CVI(Q)=29696 THEN X=X+10        ' Ctrl + R
570 IF CVI(Q)=29440 THEN X=X-10        ' Ctrl + L
580 IF CVI(Q)=18432 THEN Y=Y-1         ' Up    arrow
590 IF CVI(Q)=20480 THEN Y=Y+1         ' Down  arrow
600 IF CVI(Q)=19712 THEN X=X+1         ' Right arrow
610 IF CVI(Q)=19200 THEN X=X-1         ' Left  arrow
620 IF X<0 THEN X=0 ELSE IF X>319 THEN X=319
630 IF Y<0 THEN Y=0 ELSE IF Y>199 THEN Y=199
640 GOTO 300
650 ' wait for key
660 LSET Q=MKI$(0)
670 WHILE CVI(Q)=0:MID$(Q,1)=INKEY$:WEND:RETURN
680 ' centered text -  screen 1
690 T=(40-LEN(M(I)))/2:PRINT TAB(T) M(I):RETURN
700 ' save to diskfiles
710 OPEN "O",#1,"basdraw.txt":GOTO 750
720 SW=3:GOTO 740
730 SW=4
740 OPEN "O",#1,"bku.txt"
750 N=0:E=X:F=Y
760 FOR X=0 TO 319
770  FOR Y=0 TO 199
780   IF POINT(X,Y)<>0 THEN N=N+1     ' count pixels
790  NEXT
800 NEXT
810 PRINT #1,N
820 FOR X=0 TO 319
830  FOR Y=0 TO 199
840   IF POINT(X,Y)<>0 THEN PRINT #1,X;Y;
850  NEXT
860 NEXT:CLOSE #1:X=E:Y=F:IF SW=4 THEN 890
870 IF SW=3 THEN CLS:X=0:Y=0
880 GOTO 300
890 SCREEN 2:SCREEN 0,0,0:CLS:END
900 ' read disk files
910 OPEN "I",#1,"basdraw.txt":GOTO 1050
920 CLS:FILES "*.txt"
930 PRINT:X=0:Y=0
940 PRINT "Type filename ? ";:LINE INPUT Z$
950 FL$=Z$                        ' from Listgold.bas
960 IF LEFT$(FL$,1)=" " THEN FL$=MID$(FL$,2):GOTO 960
970 ET=LEN(FL$):F2$="":EC$=""
980 FOR I=1 TO ET
990  EC$=MID$(FL$,I,1):IF EC$="."THEN 1020
1000  F2$=F2$+EC$
1010 NEXT
1020 Z$=F2$+".txt"
1030 ON ERROR GOTO 1110
1040 OPEN "I",#1,Z$
1050 INPUT #1,N:CLS
1060 FOR I=1 TO N
1070  INPUT #1,X,Y:PSET(X,Y)
1080 NEXT
1090 CLOSE #1:X=E:Y=F:GOTO 300
1100 ON ERROR GOTO 0
1110 CLOSE:BEEP:CLS:M(15)="":M(15)=Z$+"? not found."
1120 LOCATE 11,1:I=15:GOSUB 50:PRINT:I=16:GOSUB 50
1130 GOSUB 40:RUN
