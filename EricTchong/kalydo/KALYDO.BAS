10 ' Kalydo.bas - sept 20, 1995 - color version
20 KEY OFF:SCREEN 9:RANDOMIZE TIMER
30 CLS:W=-30:COLOR 15,0              ' W=-30 print center adjust
40 GOSUB 390:RESTORE
50 ' print horizontal lines
60 FOR X=16 TO 623
70  PSET(639-X,0)
80  PSET(X,349)
90 NEXT
100 ' print vertical lines
110 FOR Y=1 TO 349
120  PSET(16,Y):PSET(17,Y)           ' left
130  PSET(622,349-Y):PSET(623,349-Y) ' right
140 NEXT
150 FOR N=25 TO 1500:F=1
160  GOSUB 370:X=R+R+W
170  GOSUB 370:Y=R
180  GOSUB 220
190 NEXT
200 W$=INKEY$:IF W$="" THEN 200
210 IF W$=CHR$(27) THEN 440 ELSE 30  ' exit
220 IF POINT(X,Y)=1 THEN 300
230 FOR A=X TO X+1:EC=INT(RND*6)+10:COLOR EC,0
240  PSET(A,Y)                       ' left up block
250  PSET(A,349-Y)                   ' left down block
260  PSET(639-A,Y)                   ' right up block
270  PSET(639-A,349-Y)               ' right down block
280 NEXT:IF F=2 THEN RETURN
290 GOSUB 420:GOTO 230
300 FOR A=X TO X+1
310  PRESET(A,Y)               
320  PRESET(A,349-Y)
330  PRESET(639-A,Y)
340  PRESET(639-A,349-Y)
350 NEXT:IF F=2 THEN RETURN
360 GOSUB 420:GOTO 300
370 R=174+INT(RND*N/10)+1:RETURN     ' vertical heart line
380 DATA *,*,K,A,L,E,I,D,O,S,C,O,P,E,*,*
390 FOR B=1 TO 16
400  READ B$:LOCATE B+4,1:PRINT B$;:LOCATE B+4,80:PRINT B$;
410 NEXT:RETURN
420 F=2:X=X-W:T=X:X=Y+Y+W:Y=T/2:RETURN
430 ' exit
440 SCREEN 2:SCREEN 0:CLS
450 KEY 5,"Kalydo.bas":KEY 6,CHR$(34)+",a":KEY ON
