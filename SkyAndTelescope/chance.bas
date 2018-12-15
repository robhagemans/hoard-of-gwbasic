10 '        Poisson Distribution
20 '          by Mark Gingrich
30 MP=.1
40 A1$="Probability (and odds) of..."
50 A2$="# events       fewer than"
60 A3$="exactly           greater than"
70 A4$="   (n)          n events "
80 A5$="n events            n events  "
90 A6$ = "-------------------------"
100 A7$="              "
110 '
120 '  Get input and print header
130 PRINT:PRINT
140 INPUT "Event rate (lambda)";L
150 INPUT "Interval (t)";T
160 IF EXP(-L*T)>0 THEN 190
170    PRINT "Sorry, out of range"
180    GOTO 420
190 PRINT:PRINT SPC(29); A1$
200 PRINT:PRINT A2$;A7$;A3$
210 PRINT A4$;A7$;A5$
220 PRINT A6$;A6$;A6$
230 '
240 '  Initialize loop variables
250 N=0
260 MU=L*T
270 PF=0: ' Prob of fewer than n
280 PE=100*EXP(-MU): ' Prob of exactly n
290 '
300 '  Compute Probabilities (and odds)
310 '
320 PG=100-PF-PE: ' Prob of greater than n
330 IF PG>99.999 THEN 380
340    PRINT USING "   ##"; N;
350    P=PF: C=13: GOSUB 440
360    P=PE: C=34: GOSUB 440
370    P=PG: C=55: GOSUB 440: PRINT
380 N=N+1
390 PF=PF+PE
400 PE=PE*MU/N
410 IF PG>=MP THEN 320
420 END
430 '
440 '  Print probability (and odds)
450 PRINT TAB(C);
460 IF P>.001 AND P<99.999 THEN 480
470    PRINT "      - - -";: GOTO 560
480 PRINT USING "###.#% (";P;
490 IF P>50 THEN 530
500    PRINT " 1 :";
510    V=((100-P)/P)
520    GOSUB 580: GOTO 550
530 V=(P/(100-P))
540 GOSUB 580: PRINT ": 1 ";
550 PRINT ")";
560 RETURN
570 '
580 '   Format odds
590 IF V>=9.5 THEN 620
600    PRINT USING " #.# ";V;
610    GOTO 630
620 PRINT INT(V+.5);
630 RETURN
640 '
650 '  Poisson statistics are used to
660 '  predict how likely it is for bunches or
670 '  gaps to occur in a stream of random
680 '  events, such as appearances of bright
690 '  comets, novae, cosmic rays, meteors, or
700 '  even the way stars are sprinkled across
710 '  a section of sky.  By comparing this
720 '  program's output to actual
730 '  observations, it is often possible to
740 '  decide whether the events of a given
750 '  class do, in fact, have a random
760 '  distribution in time or space.  Mark
770 '  Gingrich explores this subject in his
780 '  article, "Great Comets, Novae, and Lady
790 '  Luck," in Sky & Telescope for June
800 '  1995, pages 86-89.
