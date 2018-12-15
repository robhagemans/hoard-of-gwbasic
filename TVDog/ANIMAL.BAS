10 CLS:COLOR 2:PLAY "mf","mf","mf"
20 CLS:PRINT:PRINT "               Talk to  the Animals"
30 PRINT "                by Leslie Bricusse"
40 PRINT "     `PLAY' translation by Charles Robertson":LOCATE ,,0:COLOR 3:PRINT
50 PRINT "Sing Along ?";:X=ASC(INPUT$(1)):X=X AND 1:IF X=0 THEN PLAY "mb"
60 LOCATE ,1,0
70 PLAY "v10t200","v11t200","v12t200"
80 PRINT "If we could ";
90 PLAY "o3 c+4 d4 e4","o2 p2.","o2 p2."
100 PRINT "Talk To The ";
110 PLAY "o3 f2 f4 e4","o2 p4 a2.","o2 d1"
120 PRINT "An-i-mals, ";
130 PLAY "o3 f4 e4 d2","o2 b-1","o2 d2 p4 <f4"
140 PRINT "just im-";
150 PLAY "o3 p2 f4  g4","o2 p4 b4 >c4","o1 g2 a2"
160 PRINT "ag-ine it,":COLOR 4
170 PLAY "o3 f4  e4  d2","o3 d-2 d2","o1 b-2 b4 >g4"
180 PRINT "Chat-ting to a ";
190 PLAY "o3 e4 d+4  e4 f4","o3 p1","o2 c4 <b4 >c4 d4"
200 PRINT "chimp in chim-pan-";
210 PLAY "o3 g4 e4 g4 >c4","o3 p1","o2 e4 c4 d2"
220 PRINT "zee,":COLOR 5
230 PLAY "o3 g1","o3 e1","o2 c2 <g4 >d4"
240 PRINT "Im-ag-ine ";
250 PLAY "o3 p4 c4 d4 e4","o2 p1","o2 c4 e4 d4 c4"
260 PRINT "talk-ing to a ";
270 PLAY "o3 f4 e4 f4 e4","o2 a2 b-2","o2 d2 d2"
280 PRINT "ti-ger, ";
290 PLAY "o3 f4 d4 e4 f4","o2 b2 p2","o1 g2 a4 b4"
300 PRINT "chat-ting to a ";
310 PLAY "o3 g4 f+4 g4 f+4","o3 e2 d+2","o2 c2 <b2"
320 PRINT "chee-tah,":COLOR 6
330 PLAY "o3 g4 e4 f4 g4","o3 d2 p2","o1 b-2 a4 >c+4"
340 PRINT "What a neat a-";
350 PLAY "o3 a4 g+4 a4 b4","o3 c2 d2","o2 d2 f+4 g+4"
360 PRINT "chieve-ment it would ";
370 PLAY "o4 c4 d4 <b4 a4","o3 e2 c2","o2 a2 d4 f+4"
380 PRINT "be.":COLOR 7
390 PLAY "o3 g1","o2 b4 b4 >c+4 e4","o1 mlg8mn>f8 f4 e4 c+4"
400 PRINT "If we could ";
410 PLAY "o3 p4 c+4 d4 e4","o3 mlf8mn<b8 p4 p2","o2 d4 p4 p2"
420 PRINT "Talk To The ";
430 PLAY "o3 f2 f4 e4","o2 p4 a2.","o2 d1"
440 PRINT "An-i-mals, ";
450 PLAY "o3 f4 e4 d2","o2 b-1","o2 d2 p4 <f4"
460 PRINT "learn their ";
470 PLAY "o3 p2 f4  g4","o2 p4 b4 >c4","o1 g2 a2"
480 PRINT "lan-gua-ges,":COLOR 9
490 PLAY "o3 f4  e4  d2","o3 d-2 d2","o1 b-2 b4 >g4"
500 PRINT "May-be take an ";
510 PLAY "o3 e4 d+4  e4 f4","o3 p1","o2 c4 <b4 >c4 d4"
520 PRINT "an-i-mal de-";
530 PLAY "o3 g4 e4 g4 >c4","o3 p1","o2 e4 c4 d2"
540 PRINT "gree,":COLOR 10
550 PLAY "o3 g1","o3 e1","o2 c2 <g4 >d4"
560 PRINT "We'd stud-y ";
570 PLAY "o3 p4 c4 d4 e4","o2 p1","o2 c4 e4 d4 c4"
580 PRINT "el-e-phant and ";
590 PLAY "o3 f4 e4 f4 e4","o2 a2 b-2","o2 d2 d2"
600 PRINT "ea-gle, ";
610 PLAY "o3 f4 d4 e4 f4","o2 b2 p2","o1 g2 a4 b4"
620 PRINT "buf-fa-lo and ";
630 PLAY "o3 g4 f+4 g4 f+4","o3 e2 d+2","o2 c2 <b2"
640 PRINT "bea-gle,":COLOR 11
650 PLAY "o3 g4 e4 f4 g4","o3 d2 p2","o1 b-2 a4 >c+4"
660 PRINT "Al-li-ga-tor, ";
670 PLAY "o3 a4 g+4 a4 b4","o3 c2 d2","o2 d2 f+4 g+4"
680 PRINT "guin-ea pig and ";
690 PLAY "o4 c4 d4 <b4 a4","o3 e2 c2","o2 a2 d4 f+4"
700 PRINT "flea.":COLOR 12
710 PLAY "o3 g4 f+8  g8 a-4 a-4","o2 b4 p4  >c4 ml c4","o1 mlg8mn>f8 p4 g-4 ml <a-4"
720 PRINT "We would con-";
730 PLAY "o2 b8mn>g8 f+4 g4 a4","o2 p1","o1 g4 p4 p2"
740 PRINT "verse in ";
750 PLAY "o3 b-2. a4","o3 p4 ml f4 mn e4 e-4","o2 g2 c4 f+4"
760 PRINT "po-lar bear and ";
770 PLAY "o3 b-4 >d4 c4 <b-4","o3 d2 e2","o2 g2 c2"
780 PRINT "py-thon,":COLOR 13
790 PLAY "o3 a4 >c4 p2","o3 f4 a4 p2","o2 f2 f8 e8 d8 d-8"
800 PRINT "And we would ";
810 PLAY "o3 p4 f4 g4 mle-8mna8","o2 p1","o2 c4 a4 g4 f+4"
820 PRINT "curse in ";
830 PLAY "o3 b-2. a4","o3 p4 f4 e4 e-4","o2 g2 c4 f+4"
840 PRINT "flu-ent kan-ga-";
850 PLAY "o3 b-4 >d4 c4 <b4","o3 d2 e4 g+4","o2 g2 c2"
860 PRINT "roo.":COLOR 14
870 PLAY "o4 c1","o3 a1","o2 f+4 ml<g+16a16mna8 mlb16>c16mnc8 mle16f16mnf8"
880 PRINT "If peo-ple ";
890 PLAY "o3 p4 g+4 a4 b4","o3 p4 p4  e-4 d4","o2 mlg+16mna16 p8 e4 f4 g+4"
900 PRINT "asked us, ";
910 PLAY "o4 c2. <b4","o3 e2.  p4","o2 a4 e4 <a2"
920 PRINT "Can you speak rhi-";
930 PLAY "o4 c4 e4 d4 c4","o3 a4 g4 f+2","o2 a2 d2"
940 PRINT "noc-er-os?":COLOR 15
950 PLAY "o3 b8 >c8 d4 p2","o3 g8  p8 b4 p2","o2 g2  g8 f+8 e8 e-8"
960 PRINT "We'd say, Of ";
970 PLAY "o3 p4 b4 >c4 <b4","o3 p2 f2","o2 d8 p8 g4 g+2"
980 PRINT "cours-er-os!",,
990 PLAY "o4 d8 d8 d4 p2","o3 f+8 f+8 f4 a8 a8 b8 a8","o2 mla16mn>c16 ml<a16mn>c16 ml<a8mn>c8 p2"
1000 PRINT "Can't ";
1010 PLAY "o4 d4 p4 <a2","o3 f+4 p4 f+2","o2 mla8mn>c8 p4 c4 <a4"
1020 PRINT "you?":COLOR 1
1030 PLAY "o3 mlf8mn>d8 <f8 f8 f4 f4","o3 c4 c8 c8 c4 c4","o2 d4 d8 d8 d4 d4"
1040 PRINT "If we con-";
1050 PLAY "o3 mlf16mng16 p8 c+4 d4 e4","o2 p1","o2 mlg16mnb16 p8 p4 p2"
1060 PRINT "ferred with our ";
1070 PLAY "o3 f2 f4 e4","o2 p4 a2.","o2 d1"
1080 PRINT "fur-ry friends, ";
1090 PLAY "o3 f4 e4 d2","o2 b-1","o2 d2 p4 <f4"
1100 PRINT "man to ";
1110 PLAY "o3 p2 f4  g4","o2 p4 b4 >c4","o1 g2 a2"
1120 PRINT "an-i-mal,":COLOR 2
1130 PLAY "o3 f4  e4  d2","o3 d-2 d2","o1 b-2 b4 >g4"
1140 PRINT "Think of all the ";
1150 PLAY "o3 e4 d+4  e4 f4","o3 p1","o2 c4 <b4 >c4 d4"
1160 PRINT "things we could dis-";
1170 PLAY "o3 g4 e4 g4 >c4","o3 p1","o2 e4 c4 d2"
1180 PRINT "cuss.":COLOR 5
1190 PLAY "o3 g1","o3 e1","o2 c2 <g4 >d4"
1200 PRINT "If we could ";
1210 PLAY "o3 p4 c4 d4 e4","o2 p1","o2 c4 e4 d4 c4"
1220 PRINT "walk with the ";
1230 PLAY "o3 f2 f4 e4","o2 p4 a2.","o2 d1"
1240 PRINT "an-i-mals, ";
1250 PLAY "o3 f4 e4 d2","o2 b1","o1 g2. >f4"
1260 PRINT "talk with the ";
1270 PLAY "o3 g2 g4 f+4","o2 p4 b4 b-2","o2 g2 f2"
1280 PRINT "an-i-mals,":COLOR 4
1290 PLAY "o3 g4 f4 e2","o2 a1","o2 c+2. >g4"
1300 PRINT "Grunt and ";
1310 PLAY "o3 a2 a2","o3 e2 d2","o2 f4 c4 f4 c4"
1320 PRINT "squeak and ";
1330 PLAY "o3 b2 b2","o3 d2 d2","o2 a4 e4 g+4 e4"
1340 PRINT "squawk with the ";
1350 PLAY "o4 c4 p4 c4 <b4","o3 e4 p4 e2","o1 mla8mn>g8 a4 g4"
1360 PRINT "an-i-mals,":COLOR 3
1370 PLAY "o4 c4 <b4 a2","o3 d1","o2 f+2. f+4"
1380 PRINT "And ";
1390 PLAY "o3 p2 d2","o2 f1","o2 d1"
1400 PRINT "they could ";
1410 PLAY "o3 f2 a2","o3 c1","o2 mlf2mnd2"
1420 PRINT "squeak and ";
1430 PLAY "o4 c2 <b2","o3 g2  p2","o2 e2  p2"
1440 PRINT "squawk and ";
1450 PLAY "o3 a2  b2","o3 f+2 p2","o2 e-2 p2"
1460 PRINT "speak and ";
1470 PLAY "o4 c2 <b2","o3 f2  p2","o2 d2  p2"
1480 PRINT "talk to ";
1490 PLAY "o3 a2 b2","o3 f2 p2","o1 g2 p2"
1500 PRINT "us."
1510 PLAY "o4 ml c1","o3 e4 e4 f4 g4","o2 c1"
1520 PLAY "o4 mn c1","o3 p4 f4 g4 a4","o2 mlc2mna2"
1530 PLAY "o4 d+2 d+4. d+8","o3 f+2 f+4. f+8","o2 b2 b4. b8"
1540 PLAY "o4 e2 p2","o3 g2       <c4 p4","o2 mlc4>c4 <<c4 p4"
