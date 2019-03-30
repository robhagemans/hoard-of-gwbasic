
DECLARE SUB windo ()
upkey$ = CHR$(0) + "H"
enter$ = CHR$(13)
downkey$ = CHR$(0) + "P"
se = 1
menu:
COLOR 15, 0
CLS
windo
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
LOCATE 3, 9: COLOR 2, 1: PRINT "Basic Pro, Issue 3, 104732,734"
menuu:
LOCATE 19, 9: COLOR 15, 1: PRINT "                                             "
IF se = 1 THEN des$ = "Reviews of the latest Qbasic games."
IF se = 2 THEN des$ = "Previews of upcoming games."
IF se = 3 THEN des$ = "Comments."
IF se = 4 THEN des$ = "Read about the included program."
IF se = 5 THEN des$ = "Your questions."
IF se = 6 THEN des$ = "View the news article."
IF se = 7 THEN des$ = "The best game created this week. "
IF se = 8 THEN des$ = "What will happen next issue? "
IF se = 9 THEN des$ = "About this Magazine."
IF se = 10 THEN des$ = "Quits Basic Pro."
LOCATE 19, 9: COLOR 15, 1: PRINT des$
LOCATE 6, 9: COLOR 7, 1: PRINT "1. Reviews"
LOCATE 7, 9: COLOR 7, 1: PRINT "2. Previews"
LOCATE 8, 9: COLOR 7, 1: PRINT "3. Our comments"
LOCATE 9, 9: COLOR 7, 1: PRINT "4. About the Included Program"
LOCATE 10, 9: COLOR 7, 1: PRINT "5. Questions"
LOCATE 11, 9: COLOR 7, 1: PRINT "6. News"
LOCATE 12, 9: COLOR 7, 1: PRINT "7. Game of the Week"
LOCATE 13, 9: COLOR 7, 1: PRINT "8. Next Issue"
LOCATE 14, 9: COLOR 7, 1: PRINT "9. About BP"
LOCATE 15, 9: COLOR 7, 1: PRINT "0. Quit"

IF se = 1 THEN LOCATE 6, 9: COLOR 15, 1: PRINT "1. Reviews"
IF se = 2 THEN LOCATE 7, 9: COLOR 15, 1: PRINT "2. Previews"
IF se = 3 THEN LOCATE 8, 9: COLOR 15, 1: PRINT "3. Our comments"
IF se = 4 THEN LOCATE 9, 9: COLOR 15, 1: PRINT "4. About the Included Program"
IF se = 5 THEN LOCATE 10, 9: COLOR 15, 1: PRINT "5. Questions"
IF se = 6 THEN LOCATE 11, 9: COLOR 15, 1: PRINT "6. News"
IF se = 7 THEN LOCATE 12, 9: COLOR 15, 1: PRINT "7. Game of the Week"
IF se = 8 THEN LOCATE 13, 9: COLOR 15, 1: PRINT "8. Next Issue"
IF se = 9 THEN LOCATE 14, 9: COLOR 15, 1: PRINT "9. About BP"
IF se = 10 THEN LOCATE 15, 9: COLOR 15, 1: PRINT "0. Quit"
DO
x$ = INKEY$

LOOP UNTIL x$ = upkey$ OR x$ = downkey$ OR x$ = enter$
IF x$ = upkey$ THEN se = se - 1
IF x$ = downkey$ THEN se = se + 1
IF se = 11 THEN se = 1
IF se = 0 THEN se = 10
IF x$ = enter$ THEN GOTO what
GOTO menuu


what:
IF se = 1 THEN GOTO reviews
IF se = 2 THEN GOTO previews
IF se = 3 THEN GOTO inter
IF se = 4 THEN GOTO game
IF se = 5 THEN GOTO ques
IF se = 6 THEN GOTO news
IF se = 7 THEN GOTO ads
IF se = 8 THEN GOTO tips
IF se = 9 THEN GOTO bout
IF se = 10 THEN COLOR 15, 0: END

game:
COLOR 15, 0
windo
LOCATE 3, 9: COLOR 2, 1: PRINT "About the Included Program"
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
LOCATE 19, 9: COLOR 15, 1: PRINT "                                             "
COLOR 15, 1
LOCATE 6, 9: PRINT "The included program is an example of how to make 3d rotatable"
LOCATE 7, 9: PRINT "objects. It is somewhat documented. Created by Exodus."
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO menu
END

tips:
COLOR 15, 0
windo
LOCATE 3, 9: COLOR 2, 1: PRINT "Next Issue"
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
LOCATE 19, 9: COLOR 7, 1: PRINT "                                             "
LOCATE 6, 9: PRINT "Next Issue we will have a complete review on Polaris 3D,"
LOCATE 7, 9: PRINT "a few screen shots, and hopefuly a preview on HellFire 3D."
LOCATE 8, 9: PRINT "Please send any comments to 104732,734. "
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO menu


bout:
COLOR 15, 0
windo
LOCATE 3, 9: COLOR 2, 1: PRINT "About Basic Pro"
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
LOCATE 19, 9: COLOR 7, 1: PRINT "                                             "
LOCATE 6, 9: PRINT "Basic Pro is a free electronic magazine for Qbasic"
LOCATE 7, 9: PRINT "Every issue will include a built in game, reviews,"
LOCATE 8, 9: PRINT "previews, and much more. By MimicSoft."
COLOR 2, 1: LOCATE 10, 9: PRINT "E-mail us at: 104732,734@compuserve.com"
COLOR 7, 1: LOCATE 19, 9: COLOR 15, 1: PRINT "Press enter to return       "
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO menu
      
news:
COLOR 15, 0
windo
LOCATE 3, 9: COLOR 2, 1: PRINT "News"
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 7, 1
LOCATE 6, 9: PRINT "I am very pleased with the release of Sprite v2.0. It has"
LOCATE 7, 9: PRINT "many features, and a very easy interface anyone can learn."
LOCATE 8, 9: PRINT "I really recomend downloading and registering this program."
LOCATE 9, 9: PRINT "New features over v1.0 include: PCX loading, line, circle,"
LOCATE 10, 9: PRINT "and a whole bunch of new features. I really expect games in"
LOCATE 11, 9: PRINT "the future to have much more (and better) graphics. This "
LOCATE 12, 9: PRINT "program is why."

DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO menu

ques:
COLOR 7, 0
windo
LOCATE 3, 9: COLOR 2, 1: PRINT "Questions"
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
LOCATE 19, 9: COLOR 7, 1: PRINT "                                             "
LOCATE 6, 9: PRINT "The are no question this issue. If there are no questions"
LOCATE 7, 9: PRINT "next issue, i will replace this section."
LOCATE 19, 9: COLOR 15, 1: PRINT "Press enter to return       "


DO
x$ = INKEY$
LOOP UNTIL x$ = upkey$ OR x$ = downkey$ OR x$ = enter$


GOTO menu




inter:
COLOR 15, 0
windo
LOCATE 3, 9: COLOR 2, 1: PRINT "Our comments"
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
LOCATE 19, 9: COLOR 15, 1: PRINT "                                             "
COLOR 7, 1
LOCATE 6, 9: PRINT "Next Issue we hope to get a complete review on Polaris 3d"
LOCATE 7, 9: PRINT "and HellFire 3d. Both will hopefuly be good games. We will"
LOCATE 8, 9: PRINT "have screen shots, and mabey even an interactive demo. Also"
LOCATE 9, 9: PRINT "we might have some info on a new 3d marble madness type game"
LOCATE 10, 9: PRINT "called Chrome 4d. There seems to be alot of 3d games in the"
LOCATE 11, 9: PRINT "works. I can't wait to see them...."
LOCATE 13, 9: PRINT "If you have any game demos, send them to us. We will put"
LOCATE 14, 9: PRINT "it in this magazine as the built in game. Any type of game"
LOCATE 15, 9: PRINT "will do."
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO menu





reviews:
COLOR 15, 0
windo
LOCATE 3, 9: COLOR 2, 1: PRINT "Reviews"
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
review:
LOCATE 19, 9: COLOR 15, 1: PRINT "                                             "
IF se = 1 THEN des$ = "See the review on Ninja Fighter.                     "
IF se = 2 THEN des$ = "See the review on Raycast 3D.                        "
IF se = 3 THEN des$ = "See the review on TG Backjack.                       "
IF se = 4 THEN des$ = "See the review on Dragon's Brood.                    "
IF se = 5 THEN des$ = "Could be the best sprite editor ever made.... "
IF se = 6 THEN des$ = "Exits Reviews                                        "
LOCATE 19, 9: COLOR 15, 1: PRINT des$
LOCATE 6, 9: COLOR 7, 1: PRINT "1. Ninja Fighter"
LOCATE 7, 9: COLOR 7, 1: PRINT "2. Raycast 3D"
LOCATE 8, 9: COLOR 7, 1: PRINT "3. TG Blackjack"
LOCATE 9, 9: COLOR 7, 1: PRINT "4. Dragon's Brood"
LOCATE 10, 9: COLOR 7, 1: PRINT "5. Sprite v2.0"
LOCATE 11, 9: COLOR 7, 1: PRINT "6. Go to menu"

IF se = 1 THEN LOCATE 6, 9: COLOR 15, 1: PRINT "1. Ninja Fighter"
IF se = 2 THEN LOCATE 7, 9: COLOR 15, 1: PRINT "2. Raycast 3D"
IF se = 3 THEN LOCATE 8, 9: COLOR 15, 1: PRINT "3. TG Blackjack"
IF se = 4 THEN LOCATE 9, 9: COLOR 15, 1: PRINT "4. Dragon's Brood"
IF se = 5 THEN LOCATE 10, 9: COLOR 15, 1: PRINT "5. Sprite v2.0"
IF se = 6 THEN LOCATE 11, 9: COLOR 15, 1: PRINT "6. Go to menu"
  
DO
x$ = INKEY$
LOOP UNTIL x$ = upkey$ OR x$ = downkey$ OR x$ = enter$
IF x$ = upkey$ THEN se = se - 1
IF x$ = downkey$ THEN se = se + 1
IF se = 7 THEN se = 1
IF se = 0 THEN se = 6
IF x$ = enter$ THEN GOTO revsel
GOTO review


revsel:
COLOR 15, 0
windo
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 17, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"

IF se = 1 THEN GOTO nf
IF se = 2 THEN GOTO rc
IF se = 3 THEN GOTO bj
IF se = 4 THEN GOTO db
IF se = 5 THEN GOTO nt
IF se = 6 THEN GOTO menu


nf:
COLOR 2, 1
LOCATE 6, 9: PRINT "Ninja Fighter  by Armegaddon Software(106756,3057) "
COLOR 15, 1
LOCATE 8, 9: PRINT "Sound: ~"
LOCATE 9, 9: PRINT "Graphics: 2.5"
LOCATE 10, 9: PRINT "Control: 2.5"
LOCATE 11, 9: PRINT "Fun Factor: 2.5"
LOCATE 13, 9: PRINT "Ninja Fighter is a simple ASCII fighter for qbasic. It"
LOCATE 14, 9: PRINT "has great control, but the graphics are very simple. "
LOCATE 15, 9: PRINT "If more work had been put into the visuals, it could of "
LOCATE 16, 9: PRINT "been a very good game. "
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO reviews

rc:
COLOR 2, 1
LOCATE 6, 9: PRINT "Raycast 3D Engine   by Exodus(104732,734)"
COLOR 15, 1
LOCATE 8, 9: PRINT "Sound: 1.0"
LOCATE 9, 9: PRINT "Graphics: 4.0"
LOCATE 10, 9: PRINT "Control: 3.0"
LOCATE 11, 9: PRINT "Fun Factor: 3.5"
LOCATE 13, 9: PRINT "Raycast 3D is a 3d doom-like engine. It is well done"
LOCATE 14, 9: PRINT "for being written enirely is qbasic. Although it could "
LOCATE 15, 9: PRINT "use a speed up(it is pretty slow). This is a must"
LOCATE 16, 9: PRINT "download."
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO reviews


bj:
COLOR 2, 1
LOCATE 6, 9: PRINT "Blackjack v1.0  by Topgun(103630,2152)"
COLOR 15, 1
LOCATE 8, 9: PRINT "Sound: 1.0"
LOCATE 9, 9: PRINT "Graphics: 2.5"
LOCATE 10, 9: PRINT "Control: 3.0"
LOCATE 11, 9: PRINT "Fun Factor: 3.5"
LOCATE 13, 9: PRINT "I have played many attepts at Qbasic Blackjack, but i"
LOCATE 14, 9: PRINT "think this one has to be the best.  Easy control and "
LOCATE 15, 9: PRINT "simple (but well done) graphics make this one a classic."
LOCATE 16, 9: PRINT "I recommend downloading this one."
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO reviews

db:
COLOR 2, 1
LOCATE 6, 9: PRINT "Dragon's Brood  by Justin Mathews(75162,2211)"
COLOR 15, 1
LOCATE 8, 9: PRINT "Sound: ~"
LOCATE 9, 9: PRINT "Visuals: 2.5 "
LOCATE 10, 9: PRINT "Control: 3.0"
LOCATE 11, 9: PRINT "Fun Factor: 3.5"
LOCATE 13, 9: PRINT "I would love to see more text games of this quality. Each"
LOCATE 14, 9: PRINT "room in the game is described with stunning detail. A more"
LOCATE 15, 9: PRINT "interactive enviorment could of made the game better. Worth"
LOCATE 16, 9: PRINT "the download."
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO reviews

nt:
COLOR 2, 1
LOCATE 6, 9: PRINT "Sprite v2.0  by Tim Truman(74734,2203)"
COLOR 15, 1
LOCATE 8, 9: PRINT "Sound: ~"
LOCATE 9, 9: PRINT "Visuals: 4.0 "
LOCATE 10, 9: PRINT "Control: 4.0"
LOCATE 11, 9: PRINT "Usefulness: 4.5"
LOCATE 13, 9: PRINT "This is the best sprite editor I have seen. Many features, "
LOCATE 14, 9: PRINT "including pcx loading, and an easy interface make this a must"
LOCATE 15, 9: PRINT "download. I expect to see the visuals in future game much better"
LOCATE 16, 9: PRINT "since the release of this incredible program."
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO reviews


      
previews:
COLOR 15, 0
CLS
windo
LOCATE 3, 9: COLOR 2, 1: PRINT "Previews"
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
preview:
LOCATE 19, 9: COLOR 15, 1: PRINT "                                             "
IF se = 1 THEN des$ = "The newest 3d engine in the works."
IF se = 2 THEN des$ = "HellFire 3D - we can't wait to see this..."
IF se = 3 THEN des$ = "Chrome 4D?"
IF se = 4 THEN des$ = "A cool starwars game... "
IF se = 5 THEN des$ = "Sprite maker."
IF se = 6 THEN des$ = "Exits Reviews"
LOCATE 19, 9: COLOR 15, 1: PRINT des$
LOCATE 6, 9: COLOR 7, 1: PRINT "1. Polaris 3D"
LOCATE 7, 9: COLOR 7, 1: PRINT "2. HellFire 3D"
LOCATE 8, 9: COLOR 7, 1: PRINT "3. Chrome 4D"
LOCATE 9, 9: COLOR 7, 1: PRINT "4. StarWars: Scavenger"
LOCATE 10, 9: COLOR 7, 1: PRINT "5. Go to menu"

IF se = 1 THEN LOCATE 6, 9: COLOR 15, 1: PRINT "1. Polaris 3D"
IF se = 2 THEN LOCATE 7, 9: COLOR 15, 1: PRINT "2. HellFire 3D"
IF se = 3 THEN LOCATE 8, 9: COLOR 15, 1: PRINT "3. Chrome 4D"
IF se = 4 THEN LOCATE 9, 9: COLOR 15, 1: PRINT "4. StarWars: Scavenger"
IF se = 5 THEN LOCATE 10, 9: COLOR 15, 1: PRINT "5. Go to menu"

DO
x$ = INKEY$
LOOP UNTIL x$ = upkey$ OR x$ = downkey$ OR x$ = enter$
IF x$ = upkey$ THEN se = se - 1
IF x$ = downkey$ THEN se = se + 1
IF se = 6 THEN se = 1
IF se = 0 THEN se = 5
IF x$ = enter$ THEN GOTO prevsel
GOTO preview


prevsel:
COLOR 15, 0
CLS
windo
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"

IF se = 1 THEN GOTO hexx
IF se = 2 THEN GOTO fire
IF se = 3 THEN GOTO ch
IF se = 4 THEN GOTO sw
IF se = 5 THEN GOTO menu


sw:
COLOR 2, 1
LOCATE 6, 9: PRINT "StarWars: Scavenger  by Kixass(106064,3220)"
COLOR 15, 1
LOCATE 8, 9: PRINT "Percent done: Unknown"
LOCATE 9, 9: PRINT "Date out(subjext to change): Unknown "
LOCATE 11, 9: PRINT "I found this in a starwars game that came out on 3/12/97."
LOCATE 12, 9: PRINT "If this new game is anything like the one i found it will be"
LOCATE 13, 9: PRINT "awesome. Expect awesome graphics and a good storyline."
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO previews

hexx:
COLOR 2, 1
LOCATE 6, 9: PRINT "Polaris 3D - Created by Exodus(104732,734)"
COLOR 15, 1
LOCATE 8, 9: PRINT "Percent done: 50%"
LOCATE 9, 9: PRINT "Date out(subjext to change): Unknown "
LOCATE 11, 9: PRINT "Although it will have many new features, it is something"
LOCATE 12, 9: PRINT "like Raycast 3d. It will be faster, include an easy sprite"
LOCATE 13, 9: PRINT "system, and will run faster. The levels are also external"
LOCATE 14, 9: PRINT "files. Will run in realtime, and include a level editor."
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO previews

fire:
COLOR 2, 1
LOCATE 6, 9: PRINT "HellFire 3D - Created by Digitizer(101447,2373)"
COLOR 15, 1
LOCATE 8, 9: PRINT "Percent done: Unknown"
LOCATE 9, 9: PRINT "Date out(subjext to change): Unknown"
LOCATE 11, 9: PRINT "This we be a 3d version of the series known"
LOCATE 12, 9: PRINT "as HellFire. Look for more in our next issue."
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO previews

ch:
COLOR 2, 1
LOCATE 6, 9: PRINT "Chrome 4D - Created by Exodus(104732,734)"
COLOR 15, 1
LOCATE 8, 9: PRINT "Percent done: 25%"
LOCATE 9, 9: PRINT "Date out(subjext to change): unknown"
LOCATE 11, 9: PRINT "Little is known about this project except that it will"
LOCATE 12, 9: PRINT "be a marble madness type game. Look for more on this in"
LOCATE 13, 9: PRINT "out next issue."
DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO previews

ads:
COLOR 15, 0
windo
LOCATE 3, 9: COLOR 2, 1: PRINT "Game of the Week"
COLOR 15, 1: LOCATE 5, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
COLOR 15, 1: LOCATE 16, 6: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
LOCATE 19, 9: COLOR 15, 1: PRINT "                                             "
LOCATE 6, 9: PRINT "Raycast 3D  by Exodus of MimicSoft(104732,734)."
LOCATE 7, 9: PRINT "Power Rating: şşşşşşş (7)"
LOCATE 9, 9: PRINT "With sunning 3d effects, realtime movement, and Joystick"
LOCATE 10, 9: PRINT "support, Raycast 3D is a good example of what Qbasic can"
LOCATE 11, 9: PRINT "do. This is a must download. It even includes the Qbasic"
LOCATE 12, 9: PRINT "compatable source code. The runner up for Game of the Week "
LOCATE 13, 9: PRINT "is Sprite v2.0."
LOCATE 17, 9: COLOR 15, 1: PRINT "Press enter to continue "
LOCATE 19, 9: COLOR 15, 1: PRINT "The power rating is based on a 1 to 10 scale, 10 being the best."

DO
x$ = INKEY$
LOOP UNTIL x$ = enter$
GOTO menu

SUB windo
FOR a = 4 TO 23
COLOR 8, 8
LOCATE a, 8
PRINT "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
NEXT a
FOR a = 2 TO 22
COLOR 1, 0
LOCATE a, 6
PRINT "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ"
NEXT a

END SUB

