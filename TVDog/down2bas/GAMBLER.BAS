1 COMMON RH: IF RH=0 THEN SYSTEM
2 CLEAR: ON ERROR GOTO 3000
3 KEY (1) ON: ON KEY(1) GOSUB 2000
4 KEY (17) ON: KEY 17, CHR$(0)+CHR$(1): ON KEY(17) GOSUB 2500
5 DEF FNA(X) = INT(RND(1)*X+1): RANDOMIZE TIMER
10 WIDTH 40:COLOR 14,1,1:KEY OFF:CLS:LOCATE 2,15:PRINT"Welcome to":LOCATE 4,16:PRINT"GAMBLER!":LOCATE 6,12:PRINT"by Randy Hawkins":LOCATE 8,3:PRINT"(Press F1 to toggle sound on/off,":LOCATE 9,7:PRINT"or ESC to return to menu)":S=1
15 DIM N$(6),M(6),D(6),IO(6),LO$(6,3),L$(5,3),D$(6,3)
20 GOSUB 420
30 LOCATE 11,2:PRINT" How many are playing (up to 4)? ";
40 B$=INPUT$(1):N=VAL(B$):IF N<1 OR N>4 THEN 40 ELSE PRINT B$
50 PRINT:FOR I=1 TO N:PRINT"  Who is player #";I;:INPUT N$(I):M(I)=100:IO(I)=0:LO$(I,0)="":NEXT I:N$(I)="Computer":M(I)=100:IO(I)=0:N=N+1
60 PRINT:PRINT"  Do you need instructions (Y/N)? ";:B$=INPUT$(1):IF B$="y" OR B$="Y" THEN GOSUB 1370
70 FOR IP=1 TO N
80 CLS:LOCATE 3,1,0:COLOR 1,7:PRINT"Present Bankrolls                IOU's  ":COLOR 14,1,1:PRINT:FOR J=1 TO N:PRINT N$(J);TAB(20);"$";M(J);TAB(35);IO(J):NEXT J:GOSUB 200
85 PRINT:PRINT"It is ";N$(IP);"'s turn.":IF M(IP)>=0 THEN 100
90 IO(IP)=IO(IP)+1:M(IP)=M(IP)+100:IF M(IP)<0 THEN 90
95 PRINT"You must borrow money to continue to    play and pay it back to the bank ...    plus interest!":FOR TI=1 TO 2000:NEXT TI:GOTO 80
100 IF IO(IP)=0 OR M(IP)<110 THEN 130
110 PB=INT(M(IP)/100):IF PB>IO(IP) THEN PB=IO(IP)
120 IO(IP)=IO(IP)-PB:M(IP)=M(IP)-110*PB:PRINT"You can pay back";PB;"IOU note(s) at":PRINT"110 dollars each.":FOR TI=1 TO 2000:NEXT TI:GOTO 80
130 IF L$(IP,0)="XXX" THEN 160
135 LOCATE ,,1:PRINT:PRINT"You may buy up to";3-LEN(L$(IP,0));"lottery ticket(s).":PRINT"How many tickets will you buy? ";
140 IF IP=N THEN K=3-LEN(L$(IP,0)):B$=CHR$(48+K):GOTO 155
150 B$=INPUT$(1):IF B$<"0" OR B$>CHR$(51-LEN(L$(IP,0))) THEN 150
155 PRINT B$:IF B$<>"0" THEN FOR K=1 TO VAL(B$):GOSUB 260:L$(IP,0)=L$(IP,0)+"X":L$(IP,LEN(L$(IP,0)))=T$:M(IP)=M(IP)-10:FOR TI=1 TO 1000:NEXT TI,K
160 GOSUB 1470
170 GOSUB 290:COLOR 14,1
180 ON GN GOSUB 1020,810,460,1130,1170,1190,460,1200,1230,1240,460,750,1300,940,1020,710,810,1310,1320,750,460,1330,710,810,1340,1350,1330,810,460,940,1310,710,750,1360,810,710
190 NEXT IP:GOTO 70
200 HM=M(1):HN=1:FOR J=2 TO N:IF M(J)>HM THEN HM=M(J):HN=J
205 NEXT J
210 IF HM<1000 THEN RETURN
220 K=0:FOR J=1 TO N:IF M(J)=HM THEN K=K+1
225 NEXT J
230 IF K>1 THEN PRINT"Since there's a tie, keep going!":RETURN
240 PRINT:PRINT N$(HN);" wins this game":PRINT"with";HM;"dollars!":FOR I=100 TO 500 STEP 25:SOUND I,1:SOUND 50,1:NEXT I:FOR I=1 TO 20:SOUND 500,1:SOUND 50,1:NEXT I
250 PRINT:PRINT"Would you like to play again (Y/N)? ":B$=INPUT$(1):IF B$="y" OR B$="Y" THEN 2 ELSE 2500
260 T$=CHR$(48+FNA(5)):T1$=CHR$(48+FNA(6)):IF T1$<=T$ THEN 260
265 T$=T$+"-"+T1$:FOR I=1 TO N:IF L$(I,0)="" THEN 280
270 FOR J=1 TO LEN(L$(I,0)):IF T$=L$(I,J) THEN 260
275 NEXT J
280 NEXT I:PRINT:PRINT"You receive ticket number ";T$;".":IF S THEN BEEP:RETURN ELSE RETURN
290 RESTORE:CLS:COLOR 4,1:PRINT"ษอัออออออออออออออออหอัออออออออออออออออป":FOR J=1 TO 18:PRINT"บ ณ";:LOCATE ,20:PRINT"บ ณ";:LOCATE ,39:PRINT"บ":NEXT J:PRINT"ศอฯออออออออออออออออสอฯออออออออออออออออผ":COLOR 14,1
300 FOR X=2 TO 19:READ A$:LOCATE X,4:PRINT A$;:READ A$:LOCATE X,23:PRINT A$;:NEXT X
310 X1=2:X=2:LOCATE 22,1:PRINT N$(IP);",":PRINT"touch any key for your selection.";
315 IF INKEY$<>"" THEN 315
320 Y=X:Y1=X1:COLOR 0,1:LOCATE X,X1:PRINT CHR$(16);CHR$(11);:X=FNA(18)+1:X1=(FNA(2)-1)*19+2:IF FNA(2)=1 AND S THEN SOUND 500+FNA(600),1
325 IF IP=N AND FNA(30)=25 THEN 355
330 IF IP=N THEN 350
340 IF INKEY$<>"" THEN 355
350 COLOR 14,1:LOCATE Y,Y1:PRINT" ";CHR$(11);:GOTO 320
355 LOCATE 22,1:PRINT STRING$(80,32);:LOCATE 22,7-LEN(N$(IP))/2:COLOR 1,7:PRINT N$(IP);"'s selection has been made";
360 JJ=100:FOR I=1 TO 5+FNA(4):FOR J=1 TO JJ:NEXT J:JJ=JJ+100:LOCATE Y,Y1:COLOR 14,1:PRINT" ";CHR$(11);:IF S THEN SOUND 1100-JJ,1:
362 Y=X:Y1=X1:COLOR 0,1:LOCATE X,X1:PRINT CHR$(16);CHR$(11);:X1=X1+19:IF X1>22 THEN X1=2:X=X+1
365 IF X>19 THEN X=2
370 NEXT I
380 GN=Y*2+INT(Y1/16)-3:FOR I=1 TO 10:LOCATE Y,Y1:COLOR 0,1:PRINT CHR$(16);CHR$(11);:IF S THEN SOUND 250,1
385 FOR TI=1 TO 100:NEXT TI:COLOR 14,1:LOCATE Y,Y1:PRINT" ";CHR$(11);:FOR TI=1 TO 100:NEXT TI,I
390 DATA Poker Party,F O R T U N E !,Sweepstakes,Love A Neighbor,E-Z Come E-Z Go,Win A Few,Sweepstakes,Unlucky Seven,Lose a Few
395 DATA Even Steven,Sweepstakes,Daily Double,Pot Luck,High Roller,Poker Party,Lottery,F O R T U N E !,Jackpot,$100 Bonus,Off to the Races,Sweepstakes,Lose This Turn
400 DATA Lottery,F O R T U N E !,Tax Time,Bonanza,Lose This Turn,F O R T U N E !,Sweepstakes,High Roller,Jackpot,Lottery,Horse Race,Mad Money,F O R T U N E !,Lottery
420 R$="   "
425 D$(1,1)=R$:D$(1,2)=" "+CHR$(254)+" ":D$(1,3)=R$
430 D$(2,1)=CHR$(254)+"  ":D$(2,2)=R$:D$(2,3)="  "+CHR$(254)
435 D$(3,1)=D$(2,1):D$(3,2)=D$(1,2):D$(3,3)=D$(2,3)
440 D$(4,1)=CHR$(254)+" "+CHR$(254):D$(4,2)=R$:D$(4,3)=D$(4,1)
445 D$(5,1)=D$(4,1):D$(5,2)=D$(1,2):D$(5,3)=D$(4,1)
450 D$(6,1)=STRING$(3,254):D$(6,2)=R$:D$(6,3)=D$(6,1):RETURN
455 LOCATE ,5+X:PRINT" ";:LOCATE ,17+X:PRINT" ";:LOCATE ,29+X:PRINT" ":RETURN
460 X=0:CLS:PRINT TAB(9);"S W E E P S T A K E S":PRINT:COLOR 4,2:LOCATE ,5:PRINT"      G           H      ":GOSUB 455:LOCATE ,5:PRINT"A";:LOCATE ,17:PRINT"C";:LOCATE ,29:PRINT"E":GOSUB 455
465 LOCATE 12:X=6:GOSUB 455:LOCATE ,11:PRINT"B";:LOCATE ,23:PRINT"D";:LOCATE ,35:PRINT"F":GOSUB 455:LOCATE ,11:PRINT"      I           J      "
470 LOCATE 14,1:COLOR 14,1:PRINT"P=Pair";:LOCATE 15,1:PRINT"S=Straight"
480 COLOR 7,0:FOR X=1 TO 6:FOR Y=1 TO 3:LOCATE Y+7,X*6-2:PRINT D$(X,Y);:NEXT Y,X:COLOR 14,1
490 LOCATE 17,1:PRINT"Do you need SWEEPSTAKES instructions? ";:B$=INKEY$
500 B$=INPUT$(1)
510 IF B$="Y" OR B$="y" THEN 515 ELSE IF B$="N" OR B$="n" THEN 540 ELSE 500
515 LOCATE 17,1:PRINT"In SWEEPSTAKES everyone antes $10. Each player bets on the outcome of the roll  of 6 dice.  There are three types of    bets.":GOSUB 1470
520 LOCATE 17,1:PRINT"One way is to bet on where the highest  number rolled will appear.  If the high number appears in A,B,C,D,E or F you win$300.  Letters G,H,I and J cover two    spots.  If you bet G, you cover spots A"
525 PRINT"and C and can win $150."
530 GOSUB 1470:LOCATE 17,1:PRINT"Another bet is P for pairs.  If two dicenext to one another match, you win $200.The third bet is S for a straight.  If 3consecutive dice appear in numerical    order, you win $450.";STRING$(20,32);STRING$(40,32);
535 GOSUB 1470
540 LOCATE 17,1:PRINT STRING$(240,32);:LOCATE 17,30:PRINT"A-F $300":LOCATE 18,30:PRINT"G-J $150":LOCATE 19,32:PRINT"P $200":LOCATE 20,32:PRINT"S $450":FOR I=1 TO N:M(I)=M(I)-10:S$(I)="":NEXT I:LOCATE 24,10:PRINT"Place your bets!";
550 X=17:FOR J=IP TO N:LOCATE X,1:PRINT N$(J);" - ";:X=X+1:
560 IF J<>N THEN 570
565 B$=CHR$(64+FNA(11)):IF B$="K" THEN B$="P":GOTO 580 ELSE 580
570 B$=INPUT$(1):IF ASC(B$) > 96 THEN B$=CHR$(ASC(B$)-32)
575 IF (B$>"@" AND B$<"K") OR (B$="P") OR (B$="S") THEN 580 ELSE 570
580 FOR K=1 TO N:IF B$=S$(K) THEN 560
585 NEXT K:PRINT B$;:S$(J)=B$:NEXT J
590 IF IP=1 THEN HN=1:GOTO 620
595 FOR J=1 TO IP-1:LOCATE X,1:PRINT N$(J);" - ";:X=X+1
600 B$=INPUT$(1):IF ASC(B$) > 96 THEN B$=CHR$(ASC(B$)-32)
605 IF (B$>"@" AND B$<"K") OR (B$="P") OR (B$="S") THEN 610 ELSE 600
610 FOR K=1 TO N:IF B$=S$(K) THEN 600
615 NEXT K:PRINT B$;:S$(J)=B$:NEXT J:HN=1
620 LOCATE 8,1:PRINT STRING$(120,32):COLOR 7,0:FOR X=1 TO 6:D(X)=FNA(6):FOR J=1 TO 3:LOCATE J+7,X*6-2:PRINT D$(D(X),J);:NEXT J:IF S THEN SOUND 500+X*100,1
625 IF D(X)>HN THEN HN=D(X)
630 NEXT X:COLOR 14,1:FOR J=1 TO N:IF S$(J)<>"P" THEN 640
635 FOR K=1 TO 5:IF D(K)=D(K+1) THEN S$(J)="$200 for a pair!":M(J)=M(J)+200: GOTO 690 ELSE NEXT K:S$(J)="Sorry, no pairs":GOTO 690
640 IF S$(J)<>"S" THEN 660
645 FOR K=1 TO 4:IF D(K)=D(K+1)-1 AND D(K)=D(K+2)-2 THEN S$(J)="$450 for the straight!":M(J)=M(J)+450:GOTO 690
650 NEXT K:S$(J)="Sorry, no straight":GOTO 690
660 IF (S$(J)="G" AND (D(1)=HN OR D(3)=HN)) OR (S$(J)="H" AND (D(3)=HN OR D(5)=HN)) OR (S$(J)="I" AND (D(2)=HN OR D(4)=HN)) OR (S$(J)="J" AND (D(4)=HN OR D(6)=HN)) THEN S$(J)="$150 for bet on "+S$(J):M(J)=M(J)+150:GOTO 690
670 IF S$(J)<="@" OR S$(J)>="G" THEN 680
675 K=ASC(S$(J))-64:IF D(K)=HN THEN S$(J)="$300 on spot "+S$(J):M(J)=M(J)+300:GOTO 690 ELSE S$(J)="You lose with spot "+S$(J)
680 IF LEN(S$(J))=1 THEN S$(J)="Maybe next time!"
690 NEXT J:LOCATE 17,1:PRINT STRING$(200,32):X=17:FOR J=IP TO N:LOCATE X,1:PRINT N$(J);" - ";S$(J);:X=X+1:NEXT J:IF IP<>1 THEN FOR J=1 TO IP-1:LOCATE X,1:PRINT N$(J);" - ";S$(J);:X=X+1:NEXT J
700 GOSUB 1470:RETURN
710 CLS:PRINT TAB(12);"L O T T E R Y":PRINT:PRINT"If both the numbers on your ticket are  among the six numbers rolled, you will  receive $100 for that ticket.":PRINT"Here we go ..."
715 FOR J=1 TO N:LOCATE 13+J,1:PRINT N$(J);TAB(20);L$(J,1);TAB(26);L$(J,2);TAB(32);L$(J,3):NEXT J:GOSUB 1470
720 COLOR 7,0:FOR J=1 TO 6:D(J)=0:NEXT J:FOR J=1 TO 6:K=FNA(6):FOR I=1 TO 3:LOCATE 8+I,J*6-2:PRINT D$(K,I);:NEXT I:D(K)=1:NEXT J:COLOR 14,1
730 FOR J=1 TO N: FOR K=1 TO LEN(L$(J,0))-(L$(J,0)=""):LOCATE 13+J,14+K*6:FOR L=1 TO 500:NEXT L
732 IF D(VAL(LEFT$(L$(J,K),1)))<>1 OR D(VAL(RIGHT$(L$(J,K),1)))<>1 THEN 736
734 M(J)=M(J)+100:PRINT"$$$";:IF S THEN FOR I=700 TO 1000 STEP 30:SOUND I,1:NEXT I:GOTO 738 ELSE 738
736 PRINT"---";:IF S THEN SOUND 100,10
738 NEXT K
740 NEXT J:GOSUB 1470:FOR J=1 TO N:FOR K=0 TO 3:L$(J,K)="":NEXT K,J:RETURN
750 CLS:H$=" ษป๘":FOR J=1 TO 6:LOCATE J*3+1,2:COLOR J+1:PRINT J;TAB(11);H$:LOCATE J*3+1,1:PRINT N$(J);:M(J)=M(J)-20:D(J)=11:NEXT J:COLOR 14:FOR J=4 TO 19:LOCATE J,39:PRINT".":NEXT J
760 LOCATE 1,10:PRINT"H O R S E   R A C E S !":LOCATE 22,1:PRINT"Everyone has bet $20, winner gets $100.":GOSUB 1470
770 J=(J+1) AND 3:IF J=1 AND S THEN FOR I=1 TO 3:SOUND 20000,1:NEXT I
780 K=FNA(6):D(K)=D(K)+1:LOCATE K*3+1,D(K):COLOR K+1:PRINT H$;:COLOR 14: IF D(K)<36 THEN 770
790 LOCATE 22,1:PRINT STRING$(40,32):LOCATE 22,1:IF K<=N THEN R$=N$(K):M(K)=M(K)+100 ELSE R$="Horse number"+STR$(K)
800 R$=R$+" wins this race!":LOCATE 22,20-LEN(R$)/2:PRINT R$:GOSUB 1470:RETURN
810 M$="":CLS:LOCATE 4,9:PRINT"The fortune teller says:":K=1:M=10*FNA(5)+50
820 IF FNA(5)=5 THEN M$="hold a Sweepstakes":K=2:GOTO 890
830 IF FNA(5)=5 THEN M$="hold a Lottery":K=3:GOTO 890
840 IF FNA(2)=2 THEN M$="collect from ":K=-1:GOTO 850
845 M$="pay to "
850 J=FNA(N+1):IF J<>IP THEN 860
855 M$=M$+"everyone":M(IP)=M(IP)-K*N*M:FOR J=1 TO N:M(J)=M(J)+K*M:NEXT J:GOTO 880
860 IF J=N+1 THEN M$=M$+"the bank":M(IP)=M(IP)-K*M:GOTO 880
870 M$=M$+N$(J):M(IP)=M(IP)-K*M:M(J)=M(J)+K*M
880 M$=M$+STR$(M)+" dollars"
890 M$=STRING$(40,32)+N$(IP)+", "+M$+STRING$(40,32):FOR J=1 TO LEN(M$)-38:IF S THEN SOUND 900+(J AND 3)*100,2
900 LOCATE 8,1:PRINT MID$(M$,J,40);:FOR TI=1 TO 30:NEXT TI,J:M$=""
910 GOSUB 1470
920 IF K=2 THEN 460 ELSE IF K=3 THEN 710 ELSE RETURN
940 CLS:PRINT"H I G H   R O L L E R -- Everyone antes $20 and rolls two dice.  The highest    total takes the $100 prize.  To roll    dice, touch any key on your turn.":GOSUB 1470
950 FOR J=1 TO N:M(J)=M(J)-20:X=3+J*3:X1=(J-INT(J/2)*2)*3+12:LOCATE X,1:PRINT N$(J);:GOSUB 1450:D(J)=K:X1=X1+6:GOSUB 1450:D(J)=D(J)+K:FOR K=1 TO 1000:NEXT K:LOCATE X,1:PRINT STRING$(120,32):LOCATE X,1:PRINT N$(J);"'s total is";D(J):NEXT J
960 HN=D(1):HM=1:FOR J=2 TO N:IF D(J)>HN THEN HN=D(J):HM=J
970 NEXT J:K=0:FOR J=1 TO N:IF D(J)=HN THEN K=K+1
980 NEXT J:IF K=1 THEN LOCATE 21,1:PRINT N$(HM);" wins the pot!":M(HM)=M(HM)+100:GOSUB 1470:RETURN
990 LOCATE 21,1:PRINT"We've got a tie!  Those":PRINT"high rollers will roll again!":GOSUB 1470:LOCATE 6,1:FOR K=1 TO 3:PRINT STRING$(240,32):NEXT K
1000 FOR J=1 TO N:IF D(J)<HN THEN D(J)=0:GOTO 1015
1010 X=3+J*3:X1=(J-INT(J/2)*2)*3+12:LOCATE X,1:PRINT N$(J);:GOSUB 1450:D(J)=K:X1=X1+6:GOSUB 1450:D(J)=D(J)+K:FOR K=1 TO 1000:NEXT K:LOCATE X,1:PRINT STRING$(120,32):LOCATE X,1:PRINT N$(J);"'s total is";D(J)
1015 NEXT J:GOTO 960
1020 CLS:PRINT"P O K E R   P A R T Y -- Each player    pays $20 and rolls three dice.  The bestpoker hand (three of a kind > straight >pair) wins $100.  Touch any key to roll dice.":GOSUB 1470:FOR I=1 TO N:M(I)=M(I)-20:NEXT I:HM=0
1030 FOR I=1 TO N:X=I*3+4:LOCATE X,1:PRINT N$(I);:FOR M=1 TO 3:X1=10+M*6:J=I:GOSUB 1450:D(M)=K:NEXT M:P(I)=0:FOR TI=1 TO 350:NEXT TI:LOCATE X,1:PRINT STRING$(120,32)
1035 LOCATE X,1:PRINT N$(J);" rolled ";:PRINT USING"#/#/# -- ";D(1);D(2);D(3);
1040 IF D(1)=D(2) AND D(1)=D(3) THEN PRINT"Three of a kind!";:P(I)=30+D(1):GOTO 1100
1050 IF D(1)=D(2) THEN P(I)=10+D(1) ELSE IF D(1)=D(3) THEN P(I)=10+D(1) ELSE IF D(2)=D(3) THEN P(I)=10+D(2)
1060 IF P(I)>0 THEN PRINT"A pair!";:GOTO 1100
1070 FOR J=1 TO 3:IF (D(1)=D(2)+1 AND D(1)=D(3)+2) OR (D(1)=D(2)-1 AND D(1)=D(3)-2) THEN P(I)=20:GOTO 1080 ELSE HN=D(1): D(1)=D(2):D(2)=D(3):D(3)=HN:NEXT J
1080 HN=D(1):FOR J=2 TO 3:IF D(J)>HN THEN HN=D(J)
1085 NEXT J
1090 P(I)=P(I)+HN:IF P(I)>20 THEN PRINT"Straight!";:GOTO 1100
1095 PRINT"High roll of";P(I);
1100 IF P(I)>HM THEN HM=P(I)
1105 NEXT I
1110 K=0:FOR I=1 TO N:IF P(I)=HM THEN K=K+1:J=I
1115 NEXT I
1120 IF K=1 THEN LOCATE 22,1:PRINT N$(J);" wins the pot of $100!":M(J)=M(J)+100:GOSUB 1470:RETURN
1125 LOCATE 22,1:PRINT"We have a tie ... so let's all":PRINT"play another hand!":GOSUB 1470:LOCATE 6,1:PRINT STRING$(240,32);STRING$(240,32):HM=0:GOTO 1030
1130 CLS:K=0:M=FNA(5)*10+50
1140 J=FNA(N):IF J=IP THEN 1140
1150 M$="show that you are a good neighbor and give "+N$(J)+STR$(M)+" dollars."
1160 M(IP)=M(IP)-M:M(J)=M(J)+M:GOTO 890
1170 CLS:PRINT"E A S Y   C O M E   E A S Y   G O --    The bank will pay you 10 times the roll of 2 dice.  Touch any key to roll dice,":PRINT N$(IP);".":GOSUB 1470:J=IP:X=6:X1=15:GOSUB 1450:M=K:X1=21:GOSUB 1450:M=(M+K)*10:M(IP)=M(IP)+M
1180 LOCATE 12,11:PRINT"You win";M;"dollars!":GOSUB 1470:RETURN
1190 CLS:PRINT"W I N   A   F E W -- The bank will pay  you ten times the roll of one die.":PRINT"Touch any key to roll die, ";N$(IP);".":GOSUB 1470:J=IP:X=6:X1=18:GOSUB 1450:M=K*10:M(IP)=M(IP)+M:GOTO 1180
1200 CLS:PRINT"U N L U C K Y   S E V E N -- Roll two   dice. If the total is seven, you lose   $100. For any other total, you win $100.Touch any key to roll dice, ";N$(IP);".":GOSUB 1470:J=IP:X=6:X1=15
1205 GOSUB 1450:M=K:X1=21:GOSUB 1450:M=M+K
1210 IF M<>7 THEN M=100:M(IP)=M(IP)+M:GOTO 1180
1215 M=100:M(IP)=M(IP)-M
1220 LOCATE 12,10:PRINT"You lose";M;"dollars.":GOSUB 1470:RETURN
1230 CLS:PRINT"L O S E   A   F E W -- You must pay the bank ten times the roll of one die.":PRINT"Touch any key to roll die, ";N$(IP);".":GOSUB 1470:J=IP:X=6:X1=19:GOSUB 1450:M=K*10:M(IP)=M(IP)-M:GOTO 1220
1240 CLS:PRINT"E V E N   S T E V E N -- You may bet up to $90 and roll two dice.  If the total is even, you collect twice your bet.":PRINT"Touch any key to roll dice.":PRINT:PRINT N$(IP);", how much will you bet? ";
1245 IF IP=N THEN B$=STR$(FNA(4)+5):GOTO 1260
1250 B$=INPUT$(1):IF VAL(B$)<1 THEN 1250
1260 M=VAL(B$)*10:PRINT "$";M:GOSUB 1470
1270 X=9:X1=15:J=IP:GOSUB 1450:P=K:X1=21:GOSUB 1450:P=P+K
1280 LOCATE 14,10:IF INT(P/2)*2=P THEN PRINT"You win";2*M;"dollars!":M(IP)=M(IP)+2*M:GOTO 1290
1285 PRINT"You lose";M;"dollars.":M(IP)=M(IP)-M
1290 GOSUB 1470:RETURN
1300 CLS:M=10*FNA(5)+10:M(IP)=M(IP)-M:M$="why don't you sweeten the pot by giving the bank"+STR$(M)+" dollars.":K=0:GOTO 890
1310 CLS:M=FNA(5)*10+50:M$="you hit the jackpot! Collect"+STR$(M)+" dollars.":K=0:M(IP)=M(IP)+M:GOTO 890
1320 CLS:M(IP)=M(IP)+100:M$="please accept this $100 bonus!":K=0:GOTO 890
1330 CLS:M$="you just lost this turn.":K=0:GOTO 890
1340 CLS:M$="pay $100 tax to the bank.":M(IP)=M(IP)-100:K=0:GOTO 890
1350 CLS:M=FNA(5)*10:M(IP)=M(IP)+M*N:FOR J=1 TO N:M(J)=M(J)-M:NEXT J:M$="what a bonanza! Everyone pays you"+STR$(M)+" dollars!":K=0:GOTO 890
1360 CLS:M=FNA(5)*10:M(IP)=M(IP)-M*N:FOR J=1 TO N:M(J)=M(J)+M:NEXT J:M$="this ought to make you mad. Give everybody"+STR$(M)+" dollars.":K=0:GOTO 890
1370 CLS:PRINT"     This is the game of ";:COLOR 4,2:PRINT"GAMBLER!":COLOR 14,1:PRINT:PRINT"You and the PC are in a contest to see  who will build his $100 bankroll into   $1000 first.  Money is made and lost"
1380 PRINT"through a series of games of chance --":PRINT"from horse racing and dice games, to    lotteries and sweepstakes! If you shouldlose all your money, your IOU will be   accepted (as long as you pay it back    with interest)!  Good luck!"
1390 GOTO 1470
1450 COLOR 7,0:IF J=N THEN FOR L=1 TO FNA(50):K=FNA(6):LOCATE X,X1:PRINT D$(K,1);:LOCATE X+1,X1:PRINT D$(K,2);:LOCATE X+2,X1:PRINT D$(K,3);:NEXT L:COLOR 14,1:RETURN
1460 K=FNA(6):LOCATE X,X1:PRINT D$(K,1);:LOCATE X+1,X1:PRINT D$(K,2);:LOCATE X+2,X1:PRINT D$(K,3);:IF INKEY$="" THEN 1460 ELSE COLOR 14,1:RETURN
1470 LOCATE 24,6,0:PRINT"Touch ";:COLOR 23,4:PRINT" SPACE BAR ";:COLOR 14,1:PRINT" to continue";
1475 IF INKEY$<>"" THEN 1475
1480 IF INKEY$=" " THEN LOCATE 24,6:PRINT STRING$(29,32);:RETURN
1490 IF FNA(20)=1 AND S THEN SOUND 100+FNA(900),1
1500 GOTO 1480
2000 S=1-S:BEEP:RETURN
2500 WIDTH 80:CLS:LOCATE 12,28:PRINT"One moment please...":RUN "menu"
3000 RESUME NEXT

