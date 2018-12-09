1 k = 2
10 REM ufo
15 CLS
16 COLOR 15, 0
17 RANDOMIZE TIMER
18 n = INT(RND * 8 + 1)
20 a$ = "мммм" + CHR$(8) + CHR$(8) + CHR$(8) + CHR$(8) + CHR$(8) + CHR$(8) + "мммм"
30 x = 12: y = 31
31 r = INT(RND * 15 + 1)
32 c = INT(RND * 60 + 1)
33 u = INT(RND * 15 + 1)
34 v = INT(RND * 60 + 1)
35 w = INT(RND * 15 + 1)
36 e = INT(RND * 60 + 1)
40 COLOR 7, 0: LOCATE r, c: PRINT "   лллллллллллл "
41 LOCATE r + 1, c: PRINT " лллллллллллллллл"
42 LOCATE u, v: PRINT "   лллллллллллл "
43 LOCATE u + 1, v: PRINT " лллллллллллллллл"
44 LOCATE w, e: PRINT "   лллллллллллл "
45 LOCATE w + 1, e: PRINT " лллллллллллллллл"
FOR t = 1 TO 79
COLOR k, 0
LOCATE 23, t: PRINT "л";
NEXT t
49 LOCATE x, y
50 RANDOMIZE TIMER
55 COLOR 9, 0
60 PRINT a$
70 IF y <= 1 OR y >= 64 OR x <= 1 OR x >= 23 THEN 100
80 IF y = 20 OR y = 40 OR y = 60 OR x = 12 THEN n = INT(RND * 8 + 1)
100 IF y <= 1 THEN n = 1
110 IF y >= 64 THEN n = 2
120 IF x <= 1 THEN n = 3
130 IF x >= 22 THEN n = 4
140 IF y <= 1 AND x <= 1 THEN n = 5
150 IF y <= 1 AND x >= 22 THEN n = 6
160 IF y >= 64 AND x <= 1 THEN n = 7
170 IF y >= 64 AND x >= 22 THEN n = 8
180 FOR t = 1 TO 1000: NEXT t
190 LOCATE x, y: PRINT "               "
200 IF n = 1 THEN y = y + 1
210 IF n = 2 THEN y = y - 1
220 IF n = 3 THEN x = x + 1
230 IF n = 4 THEN x = x - 1
240 IF n = 5 THEN y = y + 1: x = x + 1
250 IF n = 6 THEN y = y + 1: x = x - 1
260 IF n = 7 THEN y = y - 1: x = x + 1
270 IF n = 8 THEN y = y - 1: x = x - 1
275 COLOR 0, 0
280 b$ = INKEY$: IF b$ <> "" THEN 300
285 c = c + 1: IF c >= 64 THEN CLS : c = 1: r = INT(RND * 15 + 1)
286 v = v + 1: IF v >= 64 THEN CLS : v = 1: u = INT(RND * 15 + 1)
287 e = e + 1: IF e >= 64 THEN CLS : e = 1: w = INT(RND * 15 + 1)
288 i = i + 1: IF i >= 100 THEN GOSUB 510: i = 0
290 GOTO 40
300 FOR t = 1 TO 1000: NEXT t
305 COLOR 8, 0
310 CLS
320 PRINT "       лллллллллллллллллллллллллллл"
330 PRINT "      лллллллллллллллллллллллллллллл"
340 PRINT "     лллллл        лллл        лллллл"
350 PRINT "    ллллллл        лллл        ллллллл"
360 PRINT "   лллллллл        лллл        лллллллл"
370 PRINT "  ллллллллл        лллл        ллллллллл"
380 PRINT "  ллллллллл        лллл        ллллллллл"
390 PRINT "  ллллллллл        лллл        ллллллллл"
400 PRINT "   лллллллллллллллллллллллллллллллллллл"
410 PRINT "    лллллллллллллллллллллллллллллллллл"
420 PRINT "     лллллллллллллллллллллллллллллллл"
430 PRINT "      лллллллллллллллллллллллллллллл"
440 PRINT "       лллллллл            лллллллл"
450 PRINT "        лллллллллллллллллллллллллл"
460 PRINT "         лллллллллллллллллллллллл"
470 PRINT "          лллллллллллллллллллллл"
480 PRINT "           лллллллллллллллллллл"
490 PRINT "            лллллллллллллллллл"
495 COLOR 15, 0: PRINT "                 BELIEVE!"
500 END
510 s = 2100
519 FOR h = x TO 21
520 LOCATE h - 1, y: PRINT "              "
530 LOCATE h, y: COLOR 9, 0: PRINT a$
b$ = INKEY$: IF b$ <> "" THEN 300
540 FOR t = 1 TO 1000: NEXT t
s = s - 100: SOUND s, 1
545 x = x + 1
550 NEXT h
560 LOCATE 21, y: PRINT "              "
570 FOR h = 7 TO 20
575 ON ERROR GOTO 1
580 LOCATE x, y + h: COLOR 8, 0: PRINT CHR$(1)
590 LOCATE x, y: COLOR 9, 0: PRINT a$
b$ = INKEY$: IF b$ <> "" THEN 300
600 FOR t = 1 TO 1000: NEXT t
605 LOCATE x, y + h: PRINT " "
610 NEXT h
620 LOCATE 21, y + 16: PRINT " "
630 FOR h = x TO 12 STEP -1
640 IF x <> 22 THEN LOCATE h + 1, y: PRINT "              "
650 LOCATE h, y: PRINT a$
b$ = INKEY$: IF b$ <> "" THEN 300
660 FOR t = 1 TO 1000: NEXT t
670 x = x - 1
680 NEXT h
690 CLS
700 RETURN
