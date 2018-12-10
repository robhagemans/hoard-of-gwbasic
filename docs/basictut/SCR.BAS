10 ' first keep apage & vpage the same
20 KEY OFF
30 FOR I = 0 TO 3
40 SCREEN 0,0,I,I
50 CLS
60 LOCATE I*5+1, J* 10 +5
70 COLOR I+2, 0
80 PRINT "we're in screen ";I
90 INPUT X
100 NEXT
110 SCREEN 0,0,0,0
120 PRINT "now we'll try writing without changing screens"
130 INPUT X
140 FOR I = 0 TO 3
150 SCREEN 0,0,I,0
160 CLS
170 COLOR I+2, 0
180 FOR J = 1 TO 20
190 LOCATE J, 5+ I * 3
200 PRINT "more on screen ..................... ";I
210 NEXT
220 NEXT
230 SCREEN 0,0,0,0
240 PRINT "done writing, let's see what we have..."
250 INPUT X
260 FOR I = 1 TO 3
270 SCREEN 0,0,I,I
280 INPUT X
290 NEXT
