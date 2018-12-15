
10 REM "LIFETIME" BY TERRANCE LUKAS 4/2/77
12 REM FROM NOVEMBER 1977 KILOBAUD MAGAZINE
15 PRINT:PRINT:GOSUB 3000
20 PRINT"This program determines your life expectancy."
25 GOSUB 3000:PRINT:PRINT:PRINT
60 PRINT"The following, though not validated, is based on the best"
70 PRINT"scientific evidence available today.  While scientists still"
80 PRINT"don't know all of the variables causing long life, they are"
90 PRINT"aware of some of the phenomena that seem to be correlated with"
100 PRINT"longevity.  This program is based on that data and starts with"
110 PRINT"individuals at least 20 years old."
130 DIM BA(101)
140 PRINT:INPUT"What is your age in years";AY
160 IF AY<20 THEN PRINT"Sorry, you must be at least 20.":END
170 PRINT:INPUT "What is your sex";S$
180 S$=CHR$(ASC(LEFT$(S$,1)) AND &HDF)
190 FOR I=0 TO 101:READ BA(I):NEXT
220 C=AY-20
230 IF LEFT$(S$,1)="F" THEN C=C+51
240 DATA 69.9, 70, 70.1, 70.2, 70.3, 70.4, 70.5, 70.6, 70.7, 70.8
250 DATA 70.9, 70.9, 71, 71.1, 71.2, 71.3, 71.4, 71.5, 71.6, 71.7
260 DATA 71.8, 71.9, 72, 72.2, 72.3, 72.5, 72.6, 72.8, 73, 73.2
270 DATA 73.4, 73.6, 73.8, 74.1, 74.3, 74.6, 74.9, 75.2, 75.5, 75.8
280 DATA 76.2, 76.5, 76.9, 77.3, 77.7, 78.1, 78.6, 79, 79.5, 79.9
290 DATA 80.4, 77, 77, 77.1, 77.1, 77.2, 77.2, 77.3, 77.3, 77.4
300 DATA 77.4, 77.5, 77.5, 77.5, 77.6, 77.6, 77.7, 77.8, 77.8, 77.9
310 DATA 78, 78, 78.1, 78.2, 78.3, 78.4, 78.5, 78.6, 78.7, 78.9
320 DATA 79, 79.1, 79.3, 79.4, 79.6, 79.7, 79.9, 80.1, 80.3, 80.5
330 DATA 80.7, 80.9, 81.2, 81.4, 81.6, 81.9, 82.2, 82.4, 82.7, 83
340 DATA 83.3, 83.6
350 PRINT:PRINT"Your base life expectancy is"; BA(C);"years."
360 PRINT:T=BA(C)
370 GOSUB 3000
380 PRINT"PART I:	HEREDITY"
390 GOSUB 3000
400 PRINT
410 PRINT"Did at least two of your grandparents live to age 80 or"
420 INPUT "more";A$
430 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN PRINT TAB(10);T;"+0=";T:GOTO 460
440 PRINT TAB(10);T;"+2=";T+2
450 T=T+2
460 PRINT
470 INPUT "What is/was your mother's age";A
490 IF A<80 THEN PRINT TAB(10);T;"+0=";T:GOTO 510
500 PRINT TAB(10);T;"+1.5=";T+1.5:T=T+1.5
510 PRINT
520 INPUT "What is/was your father's age";A
540 IF A<80 THEN PRINT TAB(10);T;"+0=";T:GOTO 560
550 PRINT TAB(10);T;"+2=";T+2:T=T+2
560 PRINT:PRINT"Did any of your grandparents, parents, brothers or sisters die"
580 INPUT"of a heart attack or stroke before age 50";A$
610 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN PRINT TAB(10);T;"-0=";T:GOTO 640
620 PRINT TAB(10);T;"-4=";T-4
630 T=T-4
640 PRINT:PRINT"Did any of the above die of a heart attack or stroke before age"
670 INPUT "60";A$
680 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN PRINT TAB(10);T;"-0=";T:GOTO 710
690 PRINT TAB(10);T;"-2=";T-2
700 T=T-2
710 PRINT:PRINT"What is the total number of cases of diabetes, thyroid"
730 PRINT"disorder, breast cancer (women), digestive system cancer,"
740 PRINT"asthma, emphysema, and/or chronic bronchitis found in your"
750 INPUT "parents and grandparents";A
770 PRINT TAB(10);T;" - 3x";A;"=";T-3*A
780 T=T-3*A:PRINT
790 GOSUB 3000
800 PRINT"PART II:	HEALTH AND DIET"
810 GOSUB 3000
830 PRINT:INPUT "How many pounds overweight are you";A
850 IF A=0 THEN B=0:GOTO 870
860 B=A/10
870 PRINT TAB(10);T;"-";B;"=";T-B
880 T=T-B
890 PRINT:INPUT"How many packs of cigarettes do you smoke a day";A
920 IF A=0 THEN B=0:GOTO 1000
930 IF A<1 THEN B=2:GOTO 1000
940 IF A=1 THEN B=4:GOTO 1000
950 IF A<1.5 THEN B=5.5:GOTO 1000
960 IF A<2 THEN B=7:GOTO 1000
970 IF A=2 THEN B=8:GOTO 1000
980 IF A<3 THEN B=10:GOTO 1000
990 IF A=>4 THEN B=12
1000 PRINT TAB(10);T;"-";B;"=";T-B
1010 T=T-B
1030 PRINT:INPUT "How many drinks do you have a day";A
1050 IF A=0 THEN PRINT TAB(10);T;"-1=";T-1:T=T-1:GOTO 1080
1060 IF A<2 THEN PRINT TAB(10);T;"+3=";T+3:T=T+3:GOTO 1080
1070 IF A>2 THEN PRINT TAB(10);T;"-8=";T-8:T=T-8:GOTO 1080
1080 REM continue
1110 PRINT:PRINT"Moderate drinking (up to two drinks per day) reduces stress and"
1120 PRINT"aids digestion.  Heavy drinking, however, produces"
1130 PRINT"physiological damage.  As for non-drinkers, they may have"
1140 PRINT"rather rigid value systems and may undergo stress in"
1150 PRINT"maintaining them.":PRINT
1170 PRINT:PRINT"Do you exercise moderately -- jog, bike ride, take long walks,"
1190 INPUT "swim -- at least 2 or 3 times a week";A$
1210 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN PRINT TAB(10);T;"+0=";T:GOTO 1230
1220 PRINT TAB(10);T;"+3=";T+3:T=T+3
1230 PRINT:INPUT"How many hours do you sleep each day";A
1260 IF A<9 THEN PRINT TAB(10);T;"-0=";T:GOTO 1290
1270 IF A=9 THEN PRINT TAB(10);T;"-4=";T-4:T=T-4:GOTO 1290
1280 IF A=>10 THEN PRINT TAB(10);T;"-6=";T-6:T=T-6
1290 PRINT : PRINT
1320 PRINT:PRINT"Adults that sleep too much use too many hours in nonphysical"
1340 PRINT"activity and may be unhappy and sleep as an escape or may be"
1350 PRINT"ill.  Depressed people have shorter life expectancies.":PRINT
1360 IF S$="F" AND AY <=30 OR S$<>"F" AND AY <=40 THEN 1490
1380 IF S$<>"F" THEN 1440
1390 PRINT:PRINT"Do you have a breast examination and pap smear at least once a"
1400 INPUT "year";A$
1410 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN PRINT TAB(10);T;"+0=";T:GOTO 1420
1415 PRINT TAB(10);T;"+2=";T+2:T=T+2
1420 PRINT:GOTO 1490
1440 PRINT:PRINT"Do you have a physical and proctoscopic examination at least"
1450 INPUT "once a year";A$
1460 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN PRINT TAB(10);T;"+0=";T:GOTO 1480
1470 PRINT TAB(10);T;"+2=";T+2:T=T+2
1480 PRINT
1490 GOSUB 3000
1500 PRINT"PART III:	EDUCATION AND OCCUPATION":GOSUB 3000
1520 PRINT:PRINT"Starting from first grade, what are the total number of"
1530 INPUT "years that you attended school";A
1560 IF A<12 THEN PRINT TAB(10);T;"-2=";T-2:GOTO 1600
1570 IF A<14 THEN PRINT TAB(10);T;"+0=";T:GOTO 1600
1580 IF A<17 THEN PRINT TAB(10);T;"+1=";T+1:T=T+1:GOTO 1600
1590 IF A=>17 THEN PRINT TAB(10);T;"+3=";T+3:T=T+3
1600 PRINT
1625 PRINT:PRINT"Although attending school does not make you live longer, more"
1630 PRINT"education correlates with increased income, opportunity and"
1640 PRINT"access to better health care.":PRINT
1650 PRINT
1660 INPUT"Is your occupation classified as professional";A$
1680 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN 1730
1690 PRINT:INPUT"Are you a musician, architect, or pharmacist";A$
1710 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN PRINT TAB(10);T;"+2=";T+2:T=T+2:GOTO 1780
1720 PRINT TAB(10);T;"-1=";T-1:T=T-1:GOTO 1780
1730 PRINT:INPUT"Do you work in rugged heavy work or as a cook, chef or baker";A$
1750 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN 1770
1760 PRINT TAB(10);T;"-2=";T-2:T=T-2:GOTO 1780
1770 PRINT TAB(10);T;"+0=";T
1780 PRINT
1805 PRINT:PRINT"Professionals usually live longer except for musicians,"
1810 PRINT"architects, and pharmacists.  Why this is true is unknown at"
1820 PRINT"the present time.  You have a greater chance of being involved"
1830 PRINT"in an accident if you work at rugged heavy labor.  People who"
1840 PRINT"work at jobs associated with overeating also have a lower life"
1850 PRINT"expectancy.":PRINT
1880 PRINT
1890 INPUT "Is your annual income over $40,000";A$
2000 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN PRINT TAB(10);T;"-0=";T:GOTO 2020
2010 PRINT TAB(10);T;"-2=";T-2:T=T-2
2020 PRINT
2045 PRINT
2050 PRINT"People with higher incomes usually experience more stress"
2060 PRINT"earning them and consume more rich food."
2070 PRINT
2080 INPUT "Is your job active or sedentary";A$
2100 IF LEFT$(A$,1)="A" OR LEFT$(A$,1)="a" THEN PRINT TAB(10);T;"+3=";T+3:T=T+3:GOTO 2120
2110 PRINT TAB(10);T;"-3=";T-3:T=T-3
2120 PRINT
2130 IF AY<61 THEN 2180
2140 INPUT "Are you still working";A$
2150 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN PRINT TAB(10);T;"+0=";T:GOTO 2170
2160 PRINT TAB(10);T;"+2=";T+2:T=T+2
2170 PRINT
2180 GOSUB 3000
2190 PRINT"PART IV:	LIFESTYLE":GOSUB 3000
2220 PRINT:INPUT "Do you live in a rural or an urban area";A$
2240 IF LEFT$(A$,1)="R" OR LEFT$(A$,1)="r" THEN PRINT TAB(10);T;"+1=";T+1:T=T+1:GOTO 2260
2250 PRINT TAB(10);T;"-1=";T-1:T=T-1
2260 PRINT
2270 INPUT"Are you married or living with someone on a permanent basis";A$
2300 IF LEFT$(A$,1)="Y" OR LEFT$(A$,1)="y" THEN PRINT TAB(10);T;"+3=";T+3:T=T+3:GOTO 2360
2310 A=AY-25
2315 IF A<=0 THEN A=0:GOTO 2350
2320 PRINT:PRINT"How many of the past";A;
2330 INPUT "years were you single";A
2340 A=A/10
2350 PRINT TAB(10);T;"-";A;"=";T-A:T=T-A
2360 PRINT
2370 PRINT"On a scale of 0 to 3, how much of a calm, passive person are"
2380 INPUT "you (3 is the most calm)";A
2400 PRINT TAB(10);T;"+";A;"=";T+A:T=T+A
2410 PRINT
2420 PRINT"On a scale of 0 to 5, how much of an aggressive, intense and"
2430 PRINT"competitive person are you (5 is the most aggressive, intense,"
2440 INPUT "and or competitive";A
2460 PRINT TAB(10);T;"-";A;"=";T-A:T=T-A
2470 PRINT
2480 PRINT"Do you use your car's seat belts and follow speed limits"
2490 INPUT "regularly";A$
2510 IF LEFT$(A$,1)="N" OR LEFT$(A$,1)="n" THEN PRINT TAB(10);T;"+0=";T:GOTO 2530
2520 PRINT TAB(10);T;"+1=";T+1:T=T+1
2530 PRINT
2540 PRINT"On the following scale how would you rate yourself?"
2545 PRINT
2550 PRINT"      HAPPY: 3  2  1  0 -1 -2 -3 :UNHAPPY"
2560 PRINT TAB(12);:INPUT A
2580 IF A=>0 THEN PRINT TAB(10);T;"+";A;"=";T+A:T=T+A:GOTO 2600
2590 PRINT TAB(10);T;"+";A;"=";T+A:T=T+A
2600 PRINT:PRINT
2610 GOSUB 3000
2620 PRINT"      YOUR LIFE EXPECTANCY IS";T;"YEARS"
2630 GOSUB 3000
2640 PRINT:PRINT:PRINT
2999 END
3000 FOR X=1 TO 59:PRINT"-";:NEXT:PRINT"-":RETURN


;T;"YEARS"
2630 GOSU