10 PLAY "t220"
20 L$(1) = "l8o1 e "
30 L$(2) = "l8o1 g "
40 L$(3) = "l8o1 f "
50 H$(1) ="l32o3 defgab o4 cd"
60 H$(2) ="l32o4 edc o3 bagfe"
70 H$(3) = "l32 o3 dc o2bagfed"
80 H$(4)= "l32 o2 cdefgab o3c"
90 FOR K = 1 TO 3
100 IF K = 3 THEN PLAY "t220" ELSE PLAY "t180"
110 FOR I = 1 TO 12
120 IF K = 1 OR K = 3 THEN PLAY L$((I MOD 3)+1)
130 IF K = 2 OR K = 3 THEN PLAY H$((I MOD 4)+1)
140 IF INKEY$ > "" THEN 180     ' quit as soon as any key is pressed
150 NEXT
160 NEXT
170 GOTO 90
180 END
