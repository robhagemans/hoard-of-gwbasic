

'pg = 1
SCREEN 9, , pg, 1 - pg
pg = 1 - pg
CLS
DO
 
 'a$ = "  This   is   a    line   of   text    wrapped   along   a   sine   wave"
 a1$ = "  ....... .    . .......  .....  .......  .....     .      .... ..... .   . ....."
 a2$ = "     .    .    .    .    .          .    .         . .    .       .   ..  . ."
 a3$ = "     .    ......    .     ....      .     ....    .....    ...    .   . . . ..."
 a4$ = "     .    .    .    .         .     .         .   .   .       .   .   .  .. ."
 a5$ = "     .    .    .    .         .     .         .   .   .       .   .   .  .. ."
 a6$ = "     .    .    . ....... .....   ....... .....    .   .   ....  ..... .   . ....."
 FOR i = 1 TO 1280 STEP 4
  FOR x = 1 TO 320
   y = SIN((x - i) / 10) * 18 + 20
   'y = TAN((x - i) / 10) * 8 + 21

   IF MID$(a1$, x, 1) = "." THEN PSET (x, y - 1), 15: PSET (y - 1, x), 15
   IF MID$(a2$, x, 1) = "." THEN PSET (x, y), 15: PSET (y, x), 15
   IF MID$(a3$, x, 1) = "." THEN PSET (x, y + 1), 15: PSET (y + 1, x), 15
   IF MID$(a4$, x, 1) = "." THEN PSET (x, y + 2), 15: PSET (y + 2, x), 15
   IF MID$(a5$, x, 1) = "." THEN PSET (x, y + 3), 15: PSET (y + 3, x), 15
   IF MID$(a6$, x, 1) = "." THEN PSET (x, y + 4), 15: PSET (y + 4, x), 15
   'LOCATE y, x, 0: PRINT MID$(a2$, x, 1)
   'LOCATE y - 1, x, 0: PRINT MID$(a1$, x, 1)
   'LOCATE y + 1, x, 0: PRINT MID$(a3$, x, 1)
   'LOCATE y + 2, x, 0: PRINT MID$(a4$, x, 1)
   'LOCATE y + 3, x, 0: PRINT MID$(a5$, x, 1)
  NEXT
  a1$ = " " + a1$
  a2$ = " " + a2$
  a3$ = " " + a3$
  a4$ = " " + a4$
  a5$ = " " + a5$
  a6$ = " " + a6$
  'a1$ = MID$(a1$, 2)
  'a2$ = MID$(a2$, 2)
  'a3$ = MID$(a3$, 2)
  'a4$ = MID$(a4$, 2)
  'a5$ = MID$(a5$, 2)
  'FOR q = 1 TO 10000
  'NEXT
  

SCREEN 9, , pg, 1 - pg
pg = 1 - pg
  CLS
  WAIT &H3DA, 8
  IF UCASE$(INKEY$) = "Q" THEN COLOR 7: END
 NEXT
LOOP

