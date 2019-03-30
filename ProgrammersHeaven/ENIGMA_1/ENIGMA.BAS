10 CLS
20 REM Author C. Deavours, Mathematics Dept., Kean College of N.J., Union, N.J.
21 REM Transcribed from Annals for the History of Computing,
22 REM Volume 3, Number 3, by Mark Riordan  mrr@ripem.msu.edu  15 June 1993
23 REM Evidently right to use is granted, but only for non-commercial use.
30 PRINT TAB(8); "Simulation of German Army Enigma Cryptograph"
40 PRINT
50 PRINT "This program simulates the Enigma cipher machine which"
60 PRINT "was extensively used during World War II by all branches"
70 PRINT "of the German armed forces.  The cipher key consists of:"
80 PRINT TAB(15); "A. Rotor order"
90 PRINT TAB(15); "B. Alphabet ring settings"
100 PRINT TAB(15); "C. Plugboard connections"
110 PRINT TAB(15); "D. Rotor starting positions"
120 PRINT "To decipher a message use same starting settings as"
130 PRINT "for encipherment and enter cryptogram."
140 PRINT "Messages are enciphered letter by letter with the"
150 PRINT "current rotor positions displayed for user."
160 INPUT "Press Enter to continue"; ZZ
170 CLEAR 1500
180 LL = 27
190 DEFINT D, I-K, S, Z
200 DIM d(7, 25), r$(3), k(3), n(3), a$(3), t(3), f$(7)
210 FOR j = 0 TO 25: READ d(4, j): NEXT
220 DATA 12,2,12,24,13,17,3,9,17,23,5,12,14,11,14,21,17,13,3,1,25,23,9,14,15,9
230 t(1) = 0: t(2) = 10: t(3) = 20
240 REM Rotor wirings
250 r$(1) = "LWFTBAXJDSCKPRZQYOEHUGMIVN"
260 r$(2) = "AQCBORESDHPVFUKXNGWJTILMYZ"
270 r$(3) = "LASJYZKINDOHMTBVCGPQEFXRUW"
280 CLS : PRINT TAB(25); "Rotor Wirings"; TAB(50); "Rotor #"
290 PRINT "Input contact:"; TAB(20); "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
300 FOR i = 1 TO 3: PRINT "Output contact:"; TAB(20); r$(i); TAB(54); i: NEXT
310 PRINT "Reflecting rotor: (AM) (GJ) (HQ) (CO) (TU) (ER) (BD) (NY) (IZ) (KP) (LX) (SV) (FW)"
320 PRINT : PRINT "Enter rotor order (e.g. 3,1,2)": INPUT n(1), n(2), n(3)
330 REM Calculate displacements
340 FOR i = 1 TO 3: a$ = r$(n(i)): FOR j = 0 TO 25
350     d(i, j) = ASC(MID$(a$, j + 1, 1)) - 65 - j
360     IF d(i, j) < 0 THEN d(i, j) = d(i, j) + 26
370 NEXT: NEXT
380 FOR i = 1 TO 3: FOR j = 0 TO 25
390     h = j + d(i, j): IF h > 25 THEN h = h - 26
400     dc = 26 - d(i, j): IF dc = 26 THEN dc = 0
410     d(i + 4, h) = dc: NEXT: NEXT
420 GOSUB 920
430 PRINT : PRINT "Enter rotor starting positions (e.g. A,W,E):"
440 INPUT a$(1), a$(2), a$(3)
441 FOR i = 1 TO 3: ds = ASC(a$(i)): GOSUB 1200
442   IF z = 0 THEN PRINT "Must be alphabetic": GOTO 430
443   k(i) = ds
444   a$(i) = CHR$(ds + ASC("A"))
445 NEXT
450 PRINT "Ready.  Enter plaintext"
460 INPUT a$
470 L = LEN(a$)
480 GOSUB 820
490 FOR i = 1 TO L: z$ = MID$(a$, i, 1)
500   ds = ASC(z$): y = ds: GOSUB 1200
505   IF z = 0 THEN GOTO 790
506   z$ = CHR$(ds + ASC("A"))
507   REM MID$(a$, i, 1) = z$
510   k(1) = k(1) + 1: IF k(1) = 26 THEN k(1) = 0
520   LOCATE 7, 27: PRINT CHR$(k(1) + ASC("A")); " ";
530   IF k(1) = t(n(1)) THEN k(2) = k(2) + 1
540   IF flag = 1 THEN k(2) = k(2) + 1: k(3) = k(3) + 1: flag = 0
550   IF k(2) = 26 THEN k(2) = 0
560   IF k(3) = 26 THEN k(3) = 0
570   IF k(2) = t(n(2)) THEN flag = 1
580   PRINT CHR$(k(2) + ASC("A")); " ";
590   PRINT CHR$(k(3) + ASC("A"));
600   m = ASC(z$) - ASC("A")
610   IF nn <> 0 THEN GOSUB 1150
620   FOR j = 1 TO 3
630     m = m + k(j): IF m > 25 THEN m = m - 26
640     m = m + d(j, m): IF m > 25 THEN m = m - 26
650     m = m - k(j)
660     IF m < 0 THEN m = m + 26
670   NEXT
680   REM Reflecting rotor
690   m = m + d(4, m): IF m > 25 THEN m = m - 26
700   REM Reverse Rotors
710   FOR j = 1 TO 3
720     m = m + k(4 - j): IF m > 25 THEN m = m - 26
730     m = m + d(8 - j, m): IF m > 25 THEN m = m - 26
740     m = m - k(4 - j): IF m < 0 THEN m = m + 26
750   NEXT
760   IF nn <> 0 THEN GOSUB 1150
770   LOCATE 8, LL: PRINT CHR$(m + ASC("A")); : LL = LL + 1
780   ct = ct + 1: IF ct = 5 THEN LL = LL + 1: ct = 0
785   LOCATE 11, 1: INPUT "Hit Enter to continue"; ZZ$
790 NEXT
800 PRINT : PRINT "*** Press Enter to end program ***": END
810 REM Headings
820 CLS : PRINT TAB(20); "Enigma Simulation"
830 PRINT : PRINT "Rotor order:"; n(1); n(2); n(3)
840 PRINT "Ring settings:"; f$(1); f$(2); f$(3)
850 PRINT "Rotor starting positions: "; a$(1); a$(2); a$(3)
860 PRINT "Plugboard: "; p$
870 PRINT "Current rotor positions:"
890 PRINT "Ciphertext:"
900 RETURN
910 REM Ringsettings
920 PRINT "Enter ringsettings (e.g. W,X,T):"
930 INPUT f$(1), f$(2), f$(3)
940 f$(5) = f$(1): f$(6) = f$(2): f$(7) = f$(3)
950 REM Compute new coding cylinder displacements
960 FOR i = 1 TO 7: IF i = 4 THEN GOTO 1020
970   FOR j = 0 TO 25: d(0, j) = d(i, j): NEXT
980   ds = ASC(f$(i))
985   GOSUB 1200
986   IF z = 0 THEN PRINT "Must be alphabetic": GOTO 920
990   IF ds = 0 THEN GOTO 1020
1000   FOR k = ds TO 25: d(i, k) = d(0, k - ds): NEXT
1010   FOR k = 0 TO ds - 1: d(i, k) = d(0, 26 - ds + k): NEXT
1020 NEXT
1030 REM Plugboard
1040 FOR i = 0 TO 25: d(0, i) = 0: NEXT
1050 PRINT "Enter number of plugs to be used (0-13):"
1060 INPUT nn: IF nn = 0 THEN GOTO 1130
1062 PRINT "Enter the letter pairs (e.g. A,W):"
1070   FOR i = 1 TO nn: PRINT "Pair #"; i; "="
1080   INPUT pv$, pw$: pv$ = UCASE$(pv$): pw$ = UCASE$(pw$):
1082   p$ = p$ + "(" + pv$ + pw$ + ") "
1090   ds = ASC(pw$) - ASC(pv$): IF ds < 0 THEN ds = 26 + ds
1100   d(0, ASC(pv$) - 65) = ds: d(0, ASC(pw$) - 65) = 26 - ds
1110 NEXT
1130 RETURN
1140 REM Patchpanel
1150 m = m + d(0, m): IF m > 25 THEN m = m - 26
1160 RETURN
1200 REM Check DS for alphabetic.  Return z=1 if alphabetic, else z=0.
1201 REM Convert DS to the range 0-25, also.
1205 z = 1
1210 IF ds >= ASC("a") AND ds <= ASC("z") THEN
1220   ds = ds - ASC("a")
1230 ELSEIF ds >= ASC("A") AND ds <= ASC("Z") THEN
1240   ds = ds - ASC("A")
1250 ELSE z = 0
1260 END IF
1270 RETURN
1300 END

