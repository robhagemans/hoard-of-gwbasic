10 KEY OFF:CLS
20 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
30 PRINT"∞⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø∞"
40 PRINT"∞≥                                   ≥∞"
50 PRINT"∞≥            1016-A.BAS             ≥∞"
60 PRINT"∞≥               CLERK               ≥∞"
70 PRINT"∞≥                                   ≥∞"
80 PRINT"∞≥                                   ≥∞"
90 PRINT"∞≥ BROUGHT TO YOU BY THE MEMBERS OF  ≥∞"
100 PRINT"∞≥      ‹‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹‹      ≥∞"
110 PRINT"∞≥        €   €   € €     €   €      ≥∞"
120 PRINT"∞≥        €   €‹‹‹€ €     €   €      ≥∞"
130 PRINT"∞≥        €   €     €     €   €      ≥∞"
140 PRINT"∞≥      ‹‹€‹‹ €     €‹‹‹‹ €‹‹‹€      ≥∞"
150 PRINT"∞≥                                   ≥∞"
160 PRINT"∞≥      International PC Owners      ≥∞"
170 PRINT"∞≥                                   ≥∞"
180 PRINT"∞≥P.O. Box 10426, Pittsburgh PA 15234≥∞"
190 PRINT"∞≥                                   ≥∞"
200 PRINT"∞¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ∞"
210 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
220 PRINT
230 PRINT "       PRESS ANY KEY TO CONTINUE
240 A$=INKEY$: IF A$="" THEN 240
250 CLS
1000 REM(***************************************************************)
1010 REM(*                                                             *)
1020 REM(*     PROGRAM:     CLERK                                      *)
1030 REM(*                                                             *)
1040 REM(*     AUTHOR:          CARLOS A. LUJAN S.                     *)
1050 REM(*                                                             *)
1060 REM(*     DATE:              FEBRUARY, 1983                       *
1070 REM(*                                                             *)
1080 REM(*     ABSTRACT:                                               *)
1090 REM(*       This program is designed to function as a card        *)
1100 REM(*     catalog system. It provides an ordered list of items    *)
1110 REM(*     according to their author, title and subject.           *)
1130 REM(*                                                             *)
1140 REM(*     ACKNOWLEDGMENT:                                         *)
1150 REM(*       This is an improved version of the LIBRARIAN program  *)
1160 REM(*     writen by Alfred Fant, and published in Microcomputing, *)
1170 REM(*     december 1982.                                          *)
1180 REM(*       While the original program only permited one file     *)
1190 REM(*     -a library file- this one allows you to create as many  *)
1200 REM(*     files as you want, e.g., books, programs, papers, etc.. *)
1210 REM(*       Each file can contain a maximum of 998 items instead  *)
1220 REM(*     of the 98 maximum that was allowed before.              *)
1230 REM(*       Other changes have been made to improve speed and     *)
1240 REM(*     user friendliness.                                      *)
1250 REM(*                                                             *)
1260 REM(*       This program is menu driven and is written for the    *)
1270 REM(*     IBM-PC in ADVANCED BASIC.                               *)
1280 REM(*                                                             *)
1290 REM(***************************************************************)
1300 '
1310 '
1320 '                  Program Clerk
1330 '                #################
1340 '
1350  CLS: KEY OFF: PRINT: PRINT
1360  PRINT "DO YOU WANT INSTRUCTIONS (Y/N) ?"
1370    Z$=INKEY$: IF Z$="" GOTO 1370
1380    IF Z$="Y" OR Z$="y" THEN GOSUB 3650
1390  CLS: PRINT: PRINT
1400  PRINT "IN WHICH DRIVE DO YOU HAVE THE FILES' DISKETTE ?"
1410    Z$=INKEY$: IF Z$=""  GOTO 1410
1420    DRIVE$= Z$ + ":"
1430  OPEN DRIVE$+"FILEDAT" FOR APPEND AS #2:CLOSE #2      'Create FILEDAT the                                               first time you use that diskette.
1440 '
1450  CLS: PRINT:  PRINT
1460  PRINT "LIST OF EXISTING FILES:
1470  PRINT "***********************": PRINT
1480    OPEN "I",#2, DRIVE$+"FILEDAT"
1490    WHILE NOT EOF(2)
1500      INPUT#2,DAT$: PRINT TAB(10) DAT$
1510    WEND
1520  CLOSE #2
1530 '
1540  PRINT: PRINT "DO YOU WANT TO OPEN A NEW FILE (Y/N) ? "
1550    Z$= INKEY$: IF Z$= ""  GOTO 1550
1560    IF Z$="Y" OR Z$="y" THEN GOSUB 3490                                                                 ELSE INPUT "NAME OF EXISTING FILE:  ",FILE$
1570 '
1580 '
1590    CLS
1600    OPEN DRIVE$+FILE$ AS 1 LEN=63
1610    FIELD 1, 3 AS F$, 20 AS A$, 20 AS T$, 20 AS S$
1620 '
1630  PRINT "YOU ARE EDITING THE FILE : ";
1640  COLOR 9:  PRINT FILE$:  COLOR 7:  PRINT
1650  PRINT "MENU.          1 ) LIST ALL ITEMS"
1660  PRINT "               2 ) NEW ITEM"
1670  PRINT "               3 ) SEARCHES (any combination)
1680  PRINT "               4 ) DELETE ITEM (give author and title)
1690  PRINT "               5 ) ANOTHER FILE"
1700  PRINT "               6 ) STOP"
1710  PRINT
1720  PRINT "CHOICE: "
1730  Z$=INKEY$: IF Z$="" GOTO 1730
1740  CHOICE= VAL(Z$)
1750  ON CHOICE GOSUB 2020,1790,1960,3180,1770,4110
1760  GOTO 1590
1770  RESET : GOTO 1440               'another file
1780  '
1790  '            CHOICE=1 NEW ITEM SUBROUTINE
1800  '            ****************************
1810  I=0 : LOOP=1
1820  GET 1,1
1830  S=CVI(F$)
1840  WHILE LOOP=1
1850    I=I+1
1860    GET 1,I
1870    IF A$=SPACE$(20) OR S=I THEN LOOP=0
1880  WEND
1890  IF S=I THEN PRINT "LIBRARY IS FULL" : RESET : RETURN
1900  INPUT "AUTHOR "; AU$ : LSET A$=AU$
1910  INPUT "TITLE  "; TI$ : LSET T$=TI$
1920  INPUT "SUBJECT"; SU$ : LSET S$=SU$
1930  PUT 1,I
1940  RESET : RETURN
1950  '
1960  '              CHOICE=2 SEARCHES SUBROUTINE
1970  '              ****************************
1980     CLS
1990     INPUT "    AUTHOR"; AU$
2000     INPUT "    TITLE "; TI$
2010     INPUT "    SUBJECT"; SU$
2020     PRINT
2030     PRINT "HARD COPY (Y/N) ?"
2040     Z$=INKEY$: IF Z$="" GOTO 2040
2050     CLS
2060     IF Z$="Y" OR Z$="y"   THEN P=1: LPRINT TAB(7) "Author" TAB(32) "Title"           TAB(55) "subject"    ELSE P=0:  PRINT TAB(7) "Author" TAB(32) "Title"           TAB(55) "subject"
2070     IF AU$=""  AND TI$=""  AND SU$=""  THEN MENU=1
2080     IF AU$<>"" AND TI$=""  AND SU$=""  THEN MENU=2
2090     IF AU$<>"" AND TI$<>"" AND SU$=""  THEN MENU=3
2100     IF AU$=""  AND TI$<>"" AND SU$<>"" THEN MENU=4
2110     IF AU$=""  AND TI$=""  AND SU$<>"" THEN MENU=5
2120     IF AU$=""  AND TI$<>"" AND  SU$="" THEN MENU=6
2130     Z$=SPACE$(20) : LSET Z$=AU$
2140     Y$=SPACE$(20) : LSET Y$=TI$
2150     X$=SPACE$(20) : LSET X$=SU$
2152     AU$="":  TI$="": SU$=""
2160     ON MENU GOSUB 2220,2380,2540,2700,2870,3030
2170     PRINT "" : PRINT "     Press any key to continue"
2180     B$=INKEY$ : IF B$="" THEN 2180
2190     GOTO 1590
2200  REM
2210  REM
2220  REM MENU=1 SUBROUTINE
2230     I=0
2240     GET 1,1
2250     B$=SPACE$(20)
2260     S=CVI(F$)
2270     WHILE S<> I
2280       I=I+1
2290       GET 1,I
2300       IF A$<>B$ THEN B=1 ELSE B=0
2310       IF P=1 AND B=1 THEN LPRINT A$;"     ";T$;"     ";S$
2320       IF P=0 AND B=1 THEN  PRINT A$;"     ";T$;"     ";S$
2330     WEND
2340     RESET
2350     RETURN
2360  REM
2370  REM
2380  REM MENU=2 SUBROUTINE
2390     I=0
2400     GET 1,1
2410     B$=SPACE$(20)
2420     S=CVI(F$)
2430     WHILE S <> I
2440       I=I+1
2450       GET 1,I
2460       IF A$<>B$ THEN B=1 ELSE B=0
2470       IF P=1 AND B=1 AND A$=Z$ THEN LPRINT A$;"     ";T$;"     ";S$
2480       IF P=0 AND B=1 AND A$=Z$ THEN  PRINT A$;"     ";T$;"     ";S$
2490    WEND
2500    RESET
2510    RETURN
2520  REM
2530  REM
2540  REM MENU=3 SUBROUTINE
2550     I=0
2560     GET 1,1
2570     B$=SPACE$(20)
2580     S=CVI(F$)
2590     WHILE S <> I
2600       I=I+1
2610       GET 1,I
2620       IF A$<>S$ THEN B=1
2630       IF P=1 AND B=1 AND A$=Z$ AND T$=Y$ THEN LPRINT A$;"     ";T$;                   "     ";S$
2640       IF P=0 AND B=1 AND A$=Z$ AND T$=Y$ THEN  PRINT A$;"     ";T$;                   "     ";S$
2650     WEND
2660     RESET
2670     RETURN
2680 REM
2690 REM
2700 REM MENU=4 SUBROUTINE
2710    I=0
2720    GET 1,1
2730    B$=SPACE$(20)
2740    S=CVI(F$)
2750    WHILE S <> I
2760      I=I+1
2770      GET 1,I
2780      IF A$<>B$ THEN B=1 ELSE B=0
2790      IF P=1 AND B=1 AND T$=Y$ AND S$=X$ THEN LPRINT A$;"     ";T$;                   "     ";S$
2800      IF P=0 AND B=1 AND T$=Y$ AND S$=X$ THEN  PRINT A$;"     ";T$;                   "     ";S$
2810    WEND
2820    RESET
2830    RETURN
2840  REM
2850  REM
2860  REM
2870  REM MENU=5 SUBROUTINE
2880     I=0
2890     GET 1,1
2900     B$=SPACE$(20)
2910     S=CVI(F$)
2920     WHILE S <> I
2930       I=I+1
2940       GET 1,I
2950       IF A$<>B$ THEN B=1 ELSE B=0
2960       IF P=1 AND B=1 AND S$=X$ THEN LPRINT A$;"     ";T$;"     ";S$
2970       IF P=0 AND B=1 AND S$=X$ THEN  PRINT A$;"     ";T$;"     ";S$
2980     WEND
2990     RESET
3000     RETURN
3010  REM
3020  REM
3030  REM MENU=6 SUBROUTINE
3040     I=0
3050     GET 1,1
3060     B$=SPACE$(20)
3070     S=CVI(F$)
3080     WHILE S<> I
3090       I=I+1
3100       GET 1,I
3110       IF A$<>B$ THEN B=1 ELSE B=0
3120       IF P=1 AND B=1 AND T$=Y$ THEN LPRINT A$;"     ";T$;"     ";S$
3130       IF P=0 AND B=1 AND T$=Y$ THEN  PRINT A$;"     ";T$;"     ";S$
3140     WEND
3150     RESET
3160     RETURN
3170 '
3180 '              CHOICE=3 : DELETE BOOK SUBROUTINE
3190 '              *********************************
3200    PRINT "ARE YOU SURE (Y/N) ? "
3210    B$=INKEY$: IF B$=""  GOTO 3210
3220    WHILE B$="Y" OR B$="y"
3230      INPUT "AUTHOR  "; AU$ : LSET A$=AU$
3240      INPUT "TITLE   "; TI$ : LSET T$=TI$
3250      I=0 : II=0 : SP$=SPACE$(20)
3260      Y$=SPACE$(20) : LSET Y$=TI$
3270      Z$=SPACE$(20) : LSET Z$=AU$
3280      I=0 : II=0
3290      GET 1,1
3300      S=CVI(F$)
3310      WHILE S <> I
3320        I=I+1
3330        GET 1,I
3340        IF A$=Z$ AND T$=Y$ THEN PRINT "DELETE: ";A$;"     ";T$;"     ";S$
3350        IF A$=Z$ AND T$=Y$ THEN II=I : I=S
3360        IF II<>0 THEN LSET A$=SP$ : LSET T$=SP$ : LSET S$=SP$
3370      WEND
3380      PUT 1,II
3390      B$="N"
3400    WEND
3410    RESET
3420    PRINT "" : PRINT "     Press any key to continue"
3430    B$=INKEY$ : IF B$="" THEN 3430
3440    RETURN
3450 '
3460 '
3470 '                  NEW FILE SUBROUTINE
3480 '                  *******************
3490    INPUT "NAME OF THE NEW FILE:  ",FILE$
3500    CLS:  OPEN DRIVE$+FILE$ AS 1 LEN=63
3510    FIELD 1,3 AS F$, 20 AS A$,20 AS T$, 20 AS S$
3520    INPUT "FILE SIZE IN NUMBER OF ITEMS: ",SIZE
3530    LSET F$=MKI$(SIZE)
3540    PUT 1,1
3550    LSET A$=SPACE$(20)
3560    FOR  I=2 TO SIZE
3570      PUT 1,I
3580    NEXT I
3590    OPEN DRIVE$+"FILEDAT" FOR APPEND AS #2
3600    PRINT#2,FILE$
3610    RESET
3620    RETURN
3630 '
3640 '
3650 REM        INSTRUCTIONS SUBROUTINE
3660 REM        ***********************
3670 CLS: PRINT TAB(30) "INSTRUCTIONS":PRINT TAB(30) "************"
3680 PRINT: PRINT
3690 PRINT"FILES:
3700 PRINT"   You may create as many files as you want. Each file will contain
3710 PRINT"a series of items, e.g., a file LIBRARY with a list of your books,
3720 PRINT"a file PROGRAMS with a list of your programs, etc..
3730 PRINT"Every time that you start a session, you are asked which drive you
3740 PRINT"want to work with. That's the drive where your files' diskette is.
3750 PRINT"
3760 PRINT"NEW FILE:
3770 PRINT"   If you choose to open a new file, you will be asked to define
3780 PRINT"the size of the file in terms of items. Once you have defined the
3790 PRINT"maximum number of items for that file, you will not be able to
3800 PRINT"change it, so don't choose a number to small. On the other hand,
3810 PRINT"the bigger the file, the slower the operation of the program.
3820 PRINT"Therefore, be wise in choosing the maximum number of items.
3828 PRINT: PRINT TAB(25)"" ;
3830    COLOR 9: PRINT "Press any key to continue": COLOR 7
3840    B$=INKEY$ : IF B$="" THEN 3840
3850    CLS
3860 PRINT"NEW ITEM:
3870 PRINT"   You use that choice to add items to the file being edited."
3880 PRINT"
3890 PRINT"SEARCH:
3900 PRINT"   You may search an item, or series of items, by the author, title,
3910 PRINT"or subject, or by any combination of entries, e.g., by author, by
3920 PRINT"author and title, by title and subject, etc..
3930 PRINT"   If you want to search by author, give the author, but leave in
3932 PRINT"blank title and subject. You will get a list of all items that share
3934 PRINT"that same author.
3942 PRINT"   Only two combinations are not supported: search by author and
3944 PRINT"subject and by author,title and subject.
3950 PRINT"
3960 PRINT"DELETE ITEM:
3970 PRINT"   To delete an item, you have to specify the author and title.
3980 PRINT"
3990 PRINT"ANOTHER FILE:
4000 PRINT"   If you want to create or work with another file, just use the
4010 PRINT"ANOTHER FILE choice.
4020 PRINT"
4030 PRINT"STOP:
4040 PRINT"   Use this choice to end the session.
4068 PRINT: PRINT TAB(25) "";
4070    COLOR 9: PRINT TAB(25) "Press any key to continue": COLOR 7
4080    B$=INKEY$ : IF B$="" THEN 4080
4090    CLS
4100 RETURN
4110 REM CHOICE=5 : STOP SUBROUTINE
4120 CLOSE: KEY ON
4130 END
  B$=INKEY$ : IF B$="" THEN 4080
4090    CLS
4100 RETURN
4110 REM CHOICE=5 : STOP SUBROUTINE
4120 CLOSE: KEY ON
4130 END
