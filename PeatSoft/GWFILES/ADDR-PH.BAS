100 CLS
110 A$=STRING$(80,205)
120 PRINT A$
130 PRINT TAB(21)"ADDRESSES AND PHONE NUMBERS 6005-A.BAS"
140 COLOR 23,0,0
150 PRINT :PRINT :PRINT TAB(38)"IPCO"
160 COLOR 7,0,0
170 PRINT :PRINT :PRINT TAB(29)"INTERNATIONAL PC OWNERS"
180 PRINT :PRINT :PRINT TAB(17)"p.o. box 10426, pittsburgh, pennsylvania 15234"
190 PRINT A$
200 PRINT :PRINT :PRINT :PRINT :PRINT
210 PRINT TAB(28)"PRESS ANY KEY TO CONTINUE"
220 A$=INKEY$:IF A$="" THEN 220
230 CLS
240 '    ***************************************************************
250 '    *                                                             *
260 '    *    FILING PROGRAM FOR NAMES, ADDRESSES AND PHONE NUMBERS    *
270 '    *                                                             *
280 '    *    The program uses a bubble sort to alphabetize and a      *
290 '    *     search loop to find a particular name.                  *
300 '    *                                                             *
310 '    ***************************************************************
320 '
330 '
340 DIM N$(20)
350 DIM A$(20)
360 DIM T$(20)
370   READ N                '*********************************
380   FOR I = 1 TO N        '*  ENTER THE DATA INTO 3 ARRAYS *
390     READ N$,A$,T$       '*                               *
400     N$(I) = N$          '*  AN ARRAY FOR THE NAMES       *
410     A$(I) = A$          '*               THE ADDRESSES   *
420     T$(I) = T$          '*               THE PHONE #     *
430  NEXT I                 '*********************************
440 '
450 '
460  FOR I = 2 TO N         '*****************************************
470   K = I                 '*                                       *
480   J = I-1               '*    THE BUBBLE SORT WHICH SORTS EACH   *
490   N$(0) = N$(K)         '*            ARRAY IN TANDEM            *
500   WHILE N$(J) > N$(K)   '*                                       *
510     SWAP N$(J), N$(K)   '*****************************************
520     SWAP A$(J), A$(K)
530     SWAP T$(J), T$(K)   ' NOTE: N$(0) is a sentinel value
540     K = J
550     J = J - 1
560   WEND
570  NEXT I
580 '
590 '
600 PRINT "FOR A LISTING OF ALL ENTRIES, ENTER A"  '***********************
610 PRINT "TO PRINT A PARTICULAR ENTRY, ENTER B"   '*                     *
620 PRINT "TO QUIT, ENTER C"                       '*     THIS IS THE     *
630 INPUT Z$                                       '*                     *
640 IF Z$ = "A" OR Z$ = "a" THEN GOSUB 700         '*         MENU        *
650 IF Z$ = "B" OR Z$ = "b" THEN GOSUB 800         '*                     *
660 IF Z$ = "C" OR Z$ = "c" THEN END               '***********************
670 GOTO 600
680 '
690 '
700 PRINT " "
710 FOR I = 1 TO N
720   PRINT N$(I)               '******************************************
730   PRINT A$(I)               '*                                        *
740   PRINT T$(I)               '*  THIS SUBROUTINE PRINTS THE LIST OF    *
750   PRINT " "                 '*       ENTRIES THAT HAVE BEEN           *
760 NEXT I                      '*            ALPHABETIZED                *
770 RETURN                      '*                                        *
780                             '******************************************
790 '
800 INPUT "WHOSE NUMBER ARE YOU LOOKING FOR"; S$   '***********************
810 I = 1                                          '*                     *
820 N$(N+1) = S$                                   '*   THE SEARCH LOOP   *
830 WHILE N$(I) <> S$                              '*                     *
840    I = I + 1                                   '***********************
850 WEND
860 IF I = N + 1 THEN GOTO 940
870 PRINT " "                    'NOTE: N$(N+1) is a sentinel which ends
880 PRINT N$(I)                  '      an unsuccessful search. You put
890 PRINT A$(I)                  '      whatever you are looking for at the
900 PRINT T$(I)                  '      very end of the array so the search is
910 PRINT " "                    '      sure to end. Otherwise you will search
920 RETURN                       '      off the end of the error and get an
930                              '      error message.
940 PRINT
950 PRINT
960 PRINT "NOT FOUND - remember that spacing and capitalization must be                                identical to that in the data statement":PRINT
970 GOTO 600
980 '          *************************************************************
990 '          *                                                           *
1000 '          *   ENTER THE DATA HERE --- BE SURE TO UPDATE THE NUMBER    *
1010 '          *                OF ENTRIES IN LINE #685                    *
1020 '          *                                                           *
1030 '          *************************************************************
1040 '
1050 '
1060 DATA 5
1070 DATA SMITH RAY, 6 HICKORY STICK APT HARRIS NY, 587-6687
1080 DATA TAMARINE BRIAN, 555 HARVARD STREET BOSTON MA 55138, 655-866-9887
1090 DATA BARTHOL MURRAY, 44123 TAM O`SHANTER DR. SUNNY CA 96664, 714-555-5660
1100 DATA ANESHANSELY DAN, SOMEWHERE IN ITHACA, ###########
1110 DATA JOHNSON RUTH, 441 EAST 25nd ST NY NY, 212-455-0338
1120 END
ATA ANESHANSELY DAN, SOMEWHERE IN ITHACA, ###########
1110 DATA JOHNSON 