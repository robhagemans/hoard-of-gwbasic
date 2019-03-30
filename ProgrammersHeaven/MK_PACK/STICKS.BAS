CLS
10 REM this program plays a game called match sticks.
20 PRINT "Match Sticks requires 2 players."
30 PRINT "The object of the game is to avoid picking the last"
40 PRINT "of 21 match sticks. The play begins by Player 1 "
50 PRINT "choosing between 1 and 3 match sticks. Player 2"
60 PRINT "selects 1 to 3 match sticks from the sticks remaining."
70 PRINT "The game continues in a similar fashion until only one"
80 INPUT "match stick remains for the loosing player. Do you get it "; get$
82 IF get$ = "no" THEN GOTO 10
90 sticks = 21
100 WHILE sticks <> 1
110 player = 1
115 PRINT "There are "; sticks; " Match Sticks remaining, in case you wanted to know."
120 INPUT "Player # 1: Please select 1 to 3 Matches, and hurry. ", entry
130 WHILE entry > 3 OR entry < 1 OR sticks - entry < 1
131 PRINT "You have made an error. Your entry should be between 1 and 3, and"
132 PRINT "it should not take all remaining match sticks, duh."
133 INPUT "Please re-enter your selection ", entry
134 WEND
135 sticks = sticks - entry
150 IF sticks = 1 THEN player = 1: GOTO 190
160 PRINT "There are "; sticks; " Match Sticks remaining, in case you wanted to know."
170 INPUT "Player # 2: Please select 1 to 3 Matches, Sweetie Pie ", entry
180 WHILE entry > 3 OR entry < 1 OR sticks - entry < 1
181 PRINT "You have made an error. Your entry should be between 1 and 3, and"
182 PRINT "it should not take all remaining match sticks, duh."
183 INPUT "Please re-enter your selection ", entry
184 WEND
185 sticks = sticks - entry
186 IF sticks = 1 THEN player = 2
190 WEND
200 IF player = 1 THEN PRINT " PLAYER # 1 KICKED PLAYER # 2'S BUTT!!! PLAYER # 2: YOU STINK!"
220 IF player = 2 THEN PRINT " HOLY COW!! PLAYER # 2 DEMOLISHED PLAYER # 1!!!SORRY, PLAYER # 1, BUT YOU STINK!"
240 INPUT " Do you wish to play again "; answer$
250 IF answer$ = "yes" GOTO 90 ELSE INPUT "Are you too chicken to play again? ", again$
255 IF again$ = "no" THEN GOTO 90 ELSE INPUT " I hope I, your very best coputer friend, wasn't too mean to you. Was I?", mean$
256 IF mean$ = "yes" THEN PRINT "WELL, TOO BAD, YOU JERK!!!" ELSE PRINT "Good. I love you too."
260 PRINT "GAME  OVER"
270 END



