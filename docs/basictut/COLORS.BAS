10 'colors.bas
20 ' color demo program
30 'copyright 1987, steve estvanik
40 '---------------------------------
50 CLS
60 ' first show all possible colors, on black background
70 PRINT"            dark          light   dark, blinking  light,blinking"
80 PRINT"           ------        -------   -------------       --------"
90 FOR I = 0 TO 7
100     FOR J = 0 TO 3
110    COLOR I+J*8,0
120     LOCATE I+3, 15+J*15
130     PRINT I+ J*8
140 NEXT
150 NEXT
160 PRINT "press any key...";
170 X$=INPUT$(1)
180 ' now show all combinations of foreground and background
190 COLOR 7,0
200 FOR W = 80 TO 40 STEP -40
210 CLS
220 WIDTH W
230 FOR I = 0 TO 7
240    FOR J = 0 TO 31
250    COLOR J, I
260    IF W = 80 THEN PRINT " x"; ELSE PRINT "x";
270    NEXT
280 PRINT
290 NEXT
300 PRINT "press any key...";
310 X$=INPUT$(1)
320 COLOR 7,0
330 NEXT
