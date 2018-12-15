10 COMMON RH: IF RH=0 THEN SYSTEM
15 CLEAR: DIM Q$(8),A$(8),N(8): ON ERROR GOTO 650
20 KEY (17) ON: KEY 17, CHR$(0)+CHR$(1): ON KEY(17) GOSUB 600
25 RANDOMIZE TIMER:DEF FNR(X)=INT(RND(1)*X)+1:KEY OFF
30 SCREEN 0:WIDTH 40:COLOR 14,1,1:CLS:LOCATE 4,13,0:PRINT"Show and Tell":LOCATE 6,8:PRINT"A Game by Randy Hawkins"
40 PRINT:PRINT"You will be shown the answers to nine":PRINT"questions for a few seconds.  Try to"
50 PRINT"memorize each answer and its position":PRINT"on the screen.  As each question is"
60 PRINT"presented, enter the number of the":PRINT"correct answer.  Good luck!":PRINT:PRINT"Press <any key> to begin the game..."
70 DEF SEG=0: POKE 1050,PEEK(1052): WHILE INKEY$="": WEND: CLS
80 FOR A=1 TO FNR(4):READ T$:FOR B=0 TO 8:READ Q$(B),A$(B):NEXT B,A
90 FOR A=1 TO 25:B=FNR(9)-1:C=FNR(9)-1:SWAP Q$(B),Q$(C):SWAP A$(B),A$(C):NEXT A
100 PRINT STRING$(40,205):LOCATE 2,1:PRINT"Show and Tell           by Randy Hawkins":LOCATE 3,1:PRINT STRING$(40,205):COLOR 4,0:LOCATE 4,2:PRINT STRING$(38,32);
110 FOR A=0 TO 8:LOCATE A+5,2:PRINT A+1;"... ";A$(A);TAB(40):NEXT A:LOCATE 14,2:PRINT STRING$(38,32):COLOR 14,1:PRINT STRING$(40,205);:X=TIMER
120 IF X+5>TIMER THEN 120 ELSE COLOR 4,0:FOR A=0 TO 8:LOCATE A+5,8:PRINT STRING$(31,32);:NEXT A
130 COLOR 14,1:LOCATE 20,2:PRINT STRING$(38,205);:LOCATE 24,2:PRINT STRING$(38,205);
140 FOR A=0 TO 8:N(A)=A:NEXT A:FOR A=1 TO 25:B=FNR(9)-1:C=FNR(9)-1:SWAP N(B),N(C):NEXT A:A=0
150 A=A+1:IF A>8 THEN A=0
160 IF N(A)<0 THEN 150
170 COLOR 14,1:LOCATE 17,21-LEN(T$)/2:PRINT T$:LOCATE 18,21-(LEN(Q$(N(A)))+1)/2:PRINT Q$(N(A));"?":LOCATE 22,4:PRINT"Press the <NUMBER> of your answer";
180 H$=INKEY$:IF H$<"1" OR H$>"9" THEN 180
190 LOCATE 22,1:PRINT STRING$(40,32)
200 B=VAL(H$)-1:LOCATE B+5,2:COLOR 4,0:PRINT B+1;"... ";A$(B);:COLOR 14,1:T=T+1:IF B=N(A) THEN 250
210 H$="Sorry! That's wrong!":FOR C=1 TO 10:LOCATE 22,21-C:PRINT LEFT$(H$,C);RIGHT$(H$,C);:SOUND 500-C*20,1:SOUND 500-C*20-30,1:NEXT C
220 X=TIMER
230 IF X+3>TIMER THEN 230 ELSE LOCATE B+5,8:COLOR 4,0:PRINT STRING$(28,32);:COLOR 14,1
240 LOCATE 17,1:PRINT STRING$(40,32):LOCATE 18,1:PRINT STRING$(40,32):LOCATE 22,1:PRINT STRING$(40,32):GOTO 150
250 H$=STRING$(15,32)+"You got it!":FOR C=1 TO 26:LOCATE 22,1:PRINT RIGHT$(H$,C):SOUND 100+C*50,1:NEXT C
260 R=R+1:N(A)=-1:IF R<9 THEN 220 ELSE X=TIMER
270 IF X+3>TIMER THEN 270
280 LOCATE 17,1:PRINT STRING$(40,32):PRINT STRING$(40,32):LOCATE 22,1:PRINT STRING$(40,32)
290 LOCATE 17,11:PRINT"9 questions answered":LOCATE 18,13:PRINT"in only";T;"tries!":LOCATE 22,11:PRINT"Play again (Y or N)?"
300 H$=INKEY$:IF H$="Y" OR H$="y" THEN 15
310 IF H$="N" OR H$="n" THEN 600
320 GOTO 300
330 '
340 'Data Set #1
350 '
360 DATA Where do you,go to sleep,in your bed,put your TV antenna,on the roof,go to see a ball game,in the Astrodome
370 DATA keep your car,in the garage,grow vegetables,in the garden,go to meet Dracula,in Transylvania
380 DATA land an Apollo spaceship,on the moon,hang a picture,on the wall,bake a cake,in the oven
390 '
400 'Data Set #2
410 '
420 DATA When do you,go to sleep,every night,eat a meal,three times a day,pay income tax,before April 15
430 DATA celebrate Christmas,December 25,go to the beach,in the summertime,answer the phone,when the phone rings
440 DATA change the oil in your car,every 6000 miles,go to the doctor,when you are sick,have a leap year,once every four years
450 '
460 'Data Set #3
470 '
480 DATA What do you,eat with spaghetti,Meatballs,get mixing dirt and water,Mud,wear on your head,Straw Hat
490 DATA keep in your wallet,Money,use to write a letter,Pencil,use to play computer games,Tandy 1000
500 DATA use as fish bait,Worms,use to blow your nose,Tissue,find on a used car lot,Old Cars
510 '
520 'Data Set #4
530 '
540 DATA Who is,the president,Ronald Reagan,the Tonight Show host,Johnny Carson,Disneyland's Mascot,Mickey Mouse
550 DATA the world's strongest man,Superman,the meanest man in Dallas,J. R. Ewing,the discoverer of America,Christopher Columbus
560 DATA the worst football announcer,Howard Cosell,married to Prince Charles,Princess Diana,the king of Rock and Roll,Elvis Presley
570 '
580 'Return to Main Menu
590 '
600 WIDTH 80: COLOR 14,1,1: CLS
610 LOCATE 12,28: PRINT "One moment please...": RUN "menu"
620 '
630 'Error Trap
640 '
650 RESUME NEXT
