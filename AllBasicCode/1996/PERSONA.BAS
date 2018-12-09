100 ' PERSONA.BAS by TOM DEFELICE, BOX 701, LEOMINSTER,MA. 01453
110 SCREEN 0,1,0,0: COLOR 4,7,7: WIDTH 40: KEY OFF: CLS: COLOR ,,7
120 LOCATE 5,15: PRINT "PERSONA": LOCATE 20,16: PRINT "Instructions (y/n) ? ";
130 Q$=INKEY$: IF Q$="" THEN GOTO 130
135 IF Q$="N" OR Q$="n" THEN GOTO 200
140 CLS: LOCATE 2,16: PRINT "PERSONA": PRINT :PRINT " Persona is a psychological quiz.": PRINT : PRINT "I will ask you a number of questions."
150 PRINT : PRINT "I will also list three responses for":PRINT :PRINT "each question. You must enter the number": PRINT "of the response that you agree with":COLOR 0:PRINT :PRINT " most.": COLOR 4
160 PRINT: PRINT "After answering all the questions,I will":PRINT "do a psychological profile on you.": PRINT :PRINT "Hit any key to start";
170 Q$=INKEY$: IF Q$="" THEN GOTO 170
200 COLOR 14,8,8:FOR X= 1 TO 32: READ W$,X$,Y$,Z$
210 CLS: LOCATE 3,7: PRINT "Question #" X
220 LOCATE 8,2: PRINT W$:PRINT : PRINT TAB(2) X$: PRINT :PRINT TAB(2) Y$: PRINT :PRINT TAB(2) Z$: PRINT
230 A$=INKEY$: IF A$="" THEN GOTO 230
231 IF A$<"1" OR A$>"9" THEN A$="": GOTO 230
235 PRINT TAB(10) A$
240 ON VAL(A$) GOSUB 310,320,330,340,350,360,370,380,390
290 NEXT X: WIDTH 80:CLS
291 ON INT(RND*3)+1 GOTO 292,293,294
292 PRINT "             MY ANALASIS": GOTO 6000
293 PRINT "             YOUR PERSONALITY": GOTO 6000
294 PRINT "             THE TEST SHOWS"
299 GOTO 6000
310 A=A+1: RETURN
320 B=B+1: RETURN
330 C=C+1: RETURN
340 D=D+1: RETURN
350 E=E+1: RETURN
360 F=F+1: RETURN
370 G=G+1: RETURN
380 H=H+1: RETURN
390 I=I+1: RETURN
5000 DATA "You win $5,000,000 in a lottery. The    first thing you do is","3 - Give half away to family & friends","5 - Quit your job and move to Hawaii","1 - Figure out how much you owe the IRS"
5010 DATA "You come home unexpectedly from work    and find your spouse in bed with your   best friend. You ","8 - Get angry at them","3 - Forgive them","5 - Join them"
5020 DATA "Given a choice you would rather be ","3 - A Doctor", "7 - An Actor","8 - A Professional Soldier"
5030 DATA "Your idea of a fun Saturday Night is","1 - Staying home and watching TV","7 - Going to a concert","2 - Going to a boxing match"
5040 DATA "You feel the best way to succeed is to","1 - Work Harder than others","8 - Be shrewd & calculating","7 - Come up with innovative ideas"
5050 DATA "At a party, a guest makes a loud rude   remark to another person. You","2 - Tell the host about it","1 - Try to make a joke about it","8 - Tell the rude guest to stop it"
5070 DATA "You are happiest when you are","7 - Alone","9 - With friends","2 - Doing something challenging"
5080 DATA "A fellow employee makes a mistake and   blames you. You","2 - Confront him then & there"," 6 - Tell him later he should tell the          truth"," 4 - Go to your boss privately and tell        him the truth"
5090 DATA "You usually eat dinner","1 - At the same time everyday"," 2 - When you finised what you've been            working at","9 - When you can join others"
5100 DATA "You're favorite kind of movie is","5 - A comedy","7 - A love story","8 - A western"
5105 DATA "I never met a man","9 - I didn't like","4 - I could trust","8 - I couldn't beat"
5110 DATA "When criticized by others you","6 - Accept it without question","2 - Dismiss it","1 - Analyze the criticism"
5120 DATA "You join a Country Club that you later  find is restricted. You","5 - Don't really care","9 - Resign in disgust","1 - Try to change the policy"
5130 DATA "When you play a game, you","8 - Do anything to win","5 - Enjoy yourself even if you lose","1 - Play methodically & hope to win
5140 DATA"You were given back too much change at  the check out. You","4 - Say nothing & keep it","6 - Tell the clerk & return it"," 2 - Complain to the manager about the       mistake"
5150 DATA "You would most like to be remembered as","9 - Warm & caring","4 - Rich","8 - Always being right"
5160 DATA "Your attitude towards life is","1 - You must obey the rules","2 - Others must follow my lead","5 - Live and let live"
5170 DATA "Your most admirable attribute is","9 - Loyalty to others","8 - perserverance","5 - A sense of humor"
5180 DATA "When asked to donate to a fund to save  the whales, you say","3 - Yes","1 - I gave at the Office","4 - Let them save themselves"
5190 DATA "When you make a mistake you","4 - Try to hide it","5 - Admit it","6 - Hope no one notices"
5200 DATA "What impresses you most about others is","7 - Their looks","5 - Their sense of humor","4 - Their money"
5210 DATA "When things look bad, don't worry.      They'll","5 - Get better","4 - Get worse","1 - Stay that way"
5220 DATA "If at first you don't succeed ","2 - Try again","4 - Give up","1 - Ask for advice"
5230 DATA "The best way to do something is","6 - The right way","5 - The easiest way","8 - My way"
5240 DATA"You are most attracted to people who are","7 - Attractive","1 - Intelligent","3 - Commited to a cause
5250 DATA "You would rather read","9 - A letter from a friend","1 - A book on psychology","6 - An essay on social problems"
5260 DATA "If you have one quality that makes you  most attractive to the opposite sex,    it's","9 - Being attractive & outgoing","3 - Affectionate & uninhibited"," 8 - A person with a good deal of talent     & career potential"
5270 DATA "If you were ever to write a book, you   would prefer it to be","1 - Scholarly","6 - Inspirational","8 - Autobiographical
5280 DATA "When you encounter an arguementative    person you","8 - Argue back","6 - Tactfully avoid a confrontation"," 9 - Find the basis for their                belligerence"
5290 DATA "If you ever run for public office, your most valuable political quality would be","1 - Specialized knowledge & abilities","2 - Perserverance & dedication to duty"," 8 - A capacity for leadership & voter       appeal"
5300 DATA "You are remodeling a room. You'll get   most pleasure from","5 - Seeing the job finished","7 - Planning the project","2 - Doing the work itself"
5310 DATA "In selecting your wardrobe, you tend    toward","5 - Whatever strikes your fancy","9 - What appeals to the opposite sex"," 1 - Simple, unpretentious and practical                        clothing"
6000 LOCATE 3
6010 IF A>5 THEN GOTO 6040
6020 IF A<3 THEN PRINT "You are not a very practical person":GOTO 6200
6030 PRINT "    You have a practical side that doesn't always show": GOTO 6200
6040 PRINT "    You are a ";: IF A>6 THEN PRINT "very, ";
6050 PRINT "very practical person"
6200 PRINT : IF B>3 THEN PRINT "        You have a zest for doing the";
6210 IF (B>=4 AND B<6) THEN PRINT " impossible";: GOTO 6230
6220 IF B>6 THEN PRINT " difficult"
6230 PRINT : IF C>2 THEN PRINT "        You can be generous ";
6240 IF C>3 THEN PRINT "to a fault" ELSE PRINT
6250 PRINT : IF D>2 THEN PRINT "        You have a negative side";
6260 IF D>3 THEN PRINT " and a tendency to be a bit nasty" ELSE PRINT
6270 IF E>3 THEN PRINT "        You tend to take things in an easy going way"
6280 IF E>5 THEN PRINT "          maybe too much so.";
6290 IF E>6 THEN PRINT "But that's why you're so likeable" ELSE PRINT
6300 PRINT :IF F>3 THEN PRINT "        You can be very honest & trusting ";
6310 IF F>5 THEN PRINT " which might get you into trouble" ELSE PRINT
6320 PRINT : IF G>3 THEN PRINT "        You have an artistic side to you"
6330 IF G>4 THEN PRINT "                with a touch of panache"
6340 IF H>3 THEN PRINT "        You can be strong willed at times. ";
6350 IF H>5 THEN PRINT " A bit pushy to. ";
6360 IF H>6 THEN PRINT " I don't think you have many friends." ELSE PRINT
6370 IF I>3 THEN PRINT "       You like people."
6380 IF I>4 THEN PRINT "           and they certainly like you.
8000 REM
9000 GOTO 65000
65000 ' Return to Magazette
65001 LOCATE 25,1:PRINT SPACE$(79);:LOCATE 25,1:PRINT "  Press ESC key to continue ";:ANS$=INPUT$(1):IF ASC(ANS$)<>27 THEN 65001
65002 IF ADDR.%<>0 THEN RUN DRIVE$+":"+"START"
65005 END
