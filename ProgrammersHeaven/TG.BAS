DECLARE SUB TopGunProductions ()
DECLARE SUB TitleScreen ()
DECLARE SUB Instructions ()
DECLARE SUB AboutTopGunBlackJ ()

'                   THIS IS TOPGUN PRODUCTION'S FIRST PRODUCTION.      
'                 TOPGUN BLACKJACK v1.0 IS THE FIRST OF MANY VERSIONS
'                   TO COME. LOOK FOR MORE REVISIONS LIKE MUSIC, SOUNDS,
'                 MORE OPTIONS, COLOR AND MORE !!

'        -TG PRODUCTIONS




RANDOMIZE TIMER                 ' MAKE ALL CARD #S RANDOM
DIM CARD(11) AS STRING
DIM Total AS INTEGER
DIM Total2 AS INTEGER

CARD$(0) = "ACE"
CARD$(1) = "TWO"
CARD$(2) = "THREE"
CARD$(3) = "FOUR"
CARD$(4) = "FIVE"
CARD$(5) = "SIX"                 ' CARD VALUES
CARD$(6) = "SEVEN"
CARD$(7) = "EIGHT"
CARD$(8) = "NINE"
CARD$(9) = "TEN"
CARD$(10) = "JACK"
CARD$(11) = "QUEEN"
CARD$(A) = "KING"

A% = INT(RND * 12) + A

IF A% = 0 THEN Total = 1
IF A% = 1 THEN Total = 2
IF A% = 2 THEN Total = 3
IF A% = 3 THEN Total = 4
IF A% = 4 THEN Total = 5
IF A% = 5 THEN Total = 6
IF A% = 6 THEN Total = 7                        ' (PLAYER)
IF A% = 7 THEN Total = 8           ' TRANSLATE CARD VALUES FOR CARD 1
IF A% = 8 THEN Total = 9
IF A% = 9 THEN Total = 10
IF A% = 10 THEN Total = 10
IF A% = 11 THEN Total = 10
IF A% = A THEN Total = 10

A2% = INT(RND * 12) + A

IF A2% = 0 THEN Total2 = 1
IF A2% = 1 THEN Total2 = 2
IF A2% = 2 THEN Total2 = 3
IF A2% = 3 THEN Total2 = 4
IF A2% = 4 THEN Total2 = 5
IF A2% = 5 THEN Total2 = 6
IF A2% = 6 THEN Total2 = 7                        ' (PLAYER)
IF A2% = 7 THEN Total2 = 8           ' TRANSLATE CARD VALUES FOR CARD 2
IF A2% = 8 THEN Total2 = 9
IF A2% = 9 THEN Total2 = 10
IF A2% = 10 THEN Total2 = 10
IF A2% = 11 THEN Total2 = 10
IF A2% = A THEN Total2 = 10

A3% = INT(RND * 12) + A

IF A3% = 0 THEN Total3 = 1
IF A3% = 1 THEN Total3 = 2
IF A3% = 2 THEN Total3 = 3
IF A3% = 3 THEN Total3 = 4
IF A3% = 4 THEN Total3 = 5
IF A3% = 5 THEN Total3 = 6
IF A3% = 6 THEN Total3 = 7                        ' (DEALER)
IF A3% = 7 THEN Total3 = 8           ' TRANSLATE CARD VALUES FOR CARD 1
IF A3% = 8 THEN Total3 = 9
IF A3% = 9 THEN Total3 = 10
IF A3% = 10 THEN Total3 = 10
IF A3% = 11 THEN Total3 = 10
IF A3% = A THEN Total3 = 10

A4% = INT(RND * 12) + A

IF A4% = 0 THEN Total4 = 1
IF A4% = 1 THEN Total4 = 2
IF A4% = 2 THEN Total4 = 3
IF A4% = 3 THEN Total4 = 4
IF A4% = 4 THEN Total4 = 5
IF A4% = 5 THEN Total4 = 6
IF A4% = 6 THEN Total4 = 7                        ' (DEALER)
IF A4% = 7 THEN Total4 = 8           ' TRANSLATE CARD VALUES FOR CARD 2
IF A4% = 8 THEN Total4 = 9
IF A4% = 9 THEN Total4 = 10
IF A4% = 10 THEN Total4 = 10
IF A4% = 11 THEN Total4 = 10
IF A4% = A THEN Total4 = 10

A5% = INT(RND * 12) + A

IF A5% = 0 THEN Total5 = 1
IF A5% = 1 THEN Total5 = 2
IF A5% = 2 THEN Total5 = 3
IF A5% = 3 THEN Total5 = 4
IF A5% = 4 THEN Total5 = 5
IF A5% = 5 THEN Total5 = 6
IF A5% = 6 THEN Total5 = 7                        ' (PLAYER)
IF A5% = 7 THEN Total5 = 8           ' TRANSLATE CARD VALUES FOR CARD 3
IF A5% = 8 THEN Total5 = 9
IF A5% = 9 THEN Total5 = 10
IF A5% = 10 THEN Total5 = 10
IF A5% = 11 THEN Total5 = 10
IF A5% = A THEN Total5 = 10

A6% = INT(RND * 12) + A

IF A6% = 0 THEN Total6 = 1
IF A6% = 1 THEN Total6 = 2
IF A6% = 2 THEN Total6 = 3
IF A6% = 3 THEN Total6 = 4
IF A6% = 4 THEN Total6 = 5
IF A6% = 5 THEN Total6 = 6
IF A6% = 6 THEN Total6 = 7                        ' (PLAYER)
IF A6% = 7 THEN Total6 = 8           ' TRANSLATE CARD VALUES FOR CARD 4
IF A6% = 8 THEN Total6 = 9
IF A6% = 9 THEN Total6 = 10
IF A6% = 10 THEN Total6 = 10
IF A6% = 11 THEN Total6 = 10
IF A6% = A THEN Total6 = 10

A7% = INT(RND * 12) + A

IF A7% = 0 THEN Total7 = 1
IF A7% = 1 THEN Total7 = 2
IF A7% = 2 THEN Total7 = 3
IF A7% = 3 THEN Total7 = 4
IF A7% = 4 THEN Total7 = 5
IF A7% = 5 THEN Total7 = 6
IF A7% = 6 THEN Total7 = 7                        ' (PLAYER)
IF A7% = 7 THEN Total7 = 8           ' TRANSLATE CARD VALUES FOR CARD 5
IF A7% = 8 THEN Total7 = 9
IF A7% = 9 THEN Total7 = 10
IF A7% = 10 THEN Total7 = 10
IF A7% = 11 THEN Total7 = 10
IF A7% = A THEN Total7 = 10

A8% = INT(RND * 12) + A

IF A8% = 0 THEN Total8 = 1
IF A8% = 1 THEN Total8 = 2
IF A8% = 2 THEN Total8 = 3
IF A8% = 3 THEN Total8 = 4
IF A8% = 4 THEN Total8 = 5
IF A8% = 5 THEN Total8 = 6
IF A8% = 6 THEN Total8 = 7                        ' (DEALER)
IF A8% = 7 THEN Total8 = 8           ' TRANSLATE CARD VALUES FOR CARD 3
IF A8% = 8 THEN Total8 = 9
IF A8% = 9 THEN Total8 = 10
IF A8% = 10 THEN Total8 = 10
IF A8% = 11 THEN Total8 = 10
IF A8% = A THEN Total8 = 10

A9% = INT(RND * 12) + A

IF A9% = 0 THEN Total9 = 1
IF A9% = 1 THEN Total9 = 2
IF A9% = 2 THEN Total9 = 3
IF A9% = 3 THEN Total9 = 4
IF A9% = 4 THEN Total9 = 5
IF A9% = 5 THEN Total9 = 6
IF A9% = 6 THEN Total9 = 7                        ' (DEALER)
IF A9% = 7 THEN Total9 = 8           ' TRANSLATE CARD VALUES FOR CARD 4
IF A9% = 8 THEN Total9 = 9
IF A9% = 9 THEN Total9 = 10
IF A9% = 10 THEN Total9 = 10
IF A9% = 11 THEN Total9 = 10
IF A9% = A THEN Total9 = 10

A10% = INT(RND * 12) + A

IF A10% = 0 THEN Total10 = 1
IF A10% = 1 THEN Total10 = 2
IF A10% = 2 THEN Total10 = 3
IF A10% = 3 THEN Total10 = 4
IF A10% = 4 THEN Total10 = 5
IF A10% = 5 THEN Total10 = 6
IF A10% = 6 THEN Total10 = 7                        ' (DEALER)
IF A10% = 7 THEN Total10 = 8           ' TRANSLATE CARD VALUES FOR CARD 5
IF A10% = 8 THEN Total10 = 9
IF A10% = 9 THEN Total10 = 10
IF A10% = 10 THEN Total10 = 10
IF A10% = 11 THEN Total10 = 10
IF A10% = A THEN Total10 = 10

rt$ = CHR$(0) + "M"
lt$ = CHR$(0) + "K"      ' DEFINES ARROW KEYS
up$ = CHR$(0) + "H"
dn$ = CHR$(0) + "P"

YourTotal% = 0    ' YOUR CARD TOTAL

AboutTopGunBlackJ
TopGunProductions
1 TitleScreen

DO
A$ = INKEY$
LOOP UNTIL A$ = "1" OR A$ = "2" OR A$ = "3"
IF A$ = "1" THEN GOTO BlackJack
IF A$ = "2" THEN GOTO Rules
IF A$ = "3" THEN CLS : SYSTEM

Rules:
Instructions
GOTO 1

BlackJack:
SCREEN 12
CLS

COLOR 15: LOCATE 2, 35: PRINT "YOUR HAND"
LINE (266, 10)-(350, 36), 1, B
LINE (265, 9)-(351, 37), 9, B
LINE (264, 8)-(352, 38), 15, B     ' PLAYER BOX
LINE (263, 7)-(353, 39), 9, B
LINE (262, 6)-(354, 40), 1, B

LINE (5, 215)-(627, 245), 8, B
LINE (4, 214)-(628, 246), 7, B
LINE (3, 213)-(629, 247), 15, B     ' DRAWS INPUT BOX IN MIDDLE OF SCREEN
LINE (2, 212)-(630, 248), 7, B
LINE (1, 211)-(631, 249), 8, B

LOCATE 12, 4: COLOR 15: PRINT "YOUR TOTAL"
LINE (119, 165)-(153, 198), 8, B
LINE (118, 164)-(154, 199), 7, B
LINE (117, 163)-(155, 200), 15, B      ' PLAYER'S TOTAL BOX
LINE (116, 162)-(156, 201), 7, B
LINE (115, 161)-(157, 202), 8, B

LOCATE 28, 1: COLOR 15: PRINT "DEALERS TOTAL"
LINE (119, 425)-(153, 458), 8, B
LINE (118, 424)-(154, 459), 7, B        ' DEALER'S TOTAL BOX
LINE (117, 423)-(155, 460), 15, B
LINE (116, 422)-(156, 461), 7, B
LINE (115, 421)-(157, 462), 8, B


LOCATE 12, 25: COLOR 15: PRINT "YOUR MONEY"
LINE (290, 165)-(420, 198), 8, B
LINE (289, 164)-(421, 199), 7, B
LINE (288, 163)-(422, 200), 15, B      ' PLAYER'S MONEY BOX
LINE (287, 162)-(423, 201), 7, B
LINE (286, 161)-(424, 202), 8, B
LOCATE 12, 38: PRINT "COMING IN v2.0"


LINE (5, 60)-(85, 150), 8, B
LINE (4, 59)-(86, 151), 7, B
LINE (3, 58)-(87, 152), 15, B       ' PLAYERS FIRST CARD
LINE (2, 57)-(88, 153), 7, B
LINE (1, 56)-(89, 154), 8, B
LOCATE 7, 4: PRINT CARD$(A%)

LINE (99, 60)-(179, 150), 8, B
LINE (98, 59)-(180, 151), 7, B
LINE (97, 58)-(181, 152), 15, B    ' PLAYERS SECOND CARD
LINE (96, 57)-(182, 153), 7, B
LINE (95, 56)-(183, 154), 8, B
LOCATE 7, 16: PRINT CARD$(A2%)
Amount% = Total + Total2
LOCATE 12, 16: PRINT Amount%

LINE (5, 300)-(85, 390), 8, B
LINE (4, 299)-(86, 391), 7, B
LINE (3, 298)-(87, 392), 15, B         'DEALER'S FIRST CARD
LINE (2, 297)-(88, 393), 7, B
LINE (1, 296)-(89, 394), 8, B

LINE (99, 300)-(179, 390), 8, B
LINE (98, 299)-(180, 391), 7, B
LINE (97, 298)-(181, 392), 15, B       'DEALERS SECOND CARD
LINE (96, 297)-(182, 393), 7, B
LINE (95, 296)-(183, 394), 8, B
LOCATE 22, 16: PRINT CARD$(A4%)
Amount.Dealer% = Total4
LOCATE 28, 16: PRINT Amount.Dealer%

c = 1
first:
COLOR 15: LOCATE 15, 13: PRINT CHR$(16)
COLOR 2: LOCATE 15, 15: PRINT "HIT"
LOCATE 15, 35: PRINT "STAND"

DO
A$ = INKEY$
LOOP UNTIL A$ = CHR$(13) OR A$ = rt$
IF A$ = CHR$(13) THEN GOTO Hit
IF A$ = rt$ THEN GOTO rt

rt:
LOCATE 15, 13: PRINT " "
LOCATE 15, 33: COLOR 15: PRINT CHR$(16)
DO
A$ = INKEY$
LOOP UNTIL A$ = CHR$(13) OR A$ = lt$
IF A$ = CHR$(13) THEN GOTO Stand
IF A$ = lt$ THEN LOCATE 15, 33: PRINT " ": GOTO first

Stand:
SLEEP 1
GOTO DealerTurn

Hit:
IF c = 2 THEN GOTO Hit2
IF c = 3 THEN GOTO Hit3
LINE (193, 60)-(273, 150), 8, B
LINE (192, 59)-(274, 151), 7, B
LINE (191, 58)-(275, 152), 15, B       'PLAYER'S THIRD CARD
LINE (190, 57)-(276, 153), 7, B
LINE (189, 56)-(277, 154), 8, B
LOCATE 7, 28: COLOR 15: PRINT CARD$(A5%)
Amount% = Amount% + Total5
LOCATE 12, 16: PRINT Amount%
IF Amount% > 21 THEN SLEEP 1: LOCATE 15, 4: PRINT "                              ": COLOR 4: LOCATE 15, 25: PRINT "B     U     S     T    !   !  ! !": SLEEP 2: GOTO DealerTurn
c = c + 1
GOTO first

Hit2:
LINE (287, 60)-(367, 150), 8, B
LINE (286, 59)-(368, 151), 7, B
LINE (285, 58)-(369, 152), 15, B       ' PLAYER'S FOURTH CARD
LINE (284, 57)-(370, 153), 7, B
LINE (283, 56)-(371, 154), 8, B
LOCATE 7, 39: COLOR 15: PRINT CARD$(A6%)
Amount% = Amount% + Total6
LOCATE 12, 16: PRINT Amount%
IF Amount% > 21 THEN SLEEP 1: LOCATE 15, 4: PRINT "                                   ": COLOR 4: LOCATE 15, 25: PRINT "B     U     S     T    !   !  ! !": SLEEP 2: GOTO DealerTurn
c = c + 1
GOTO first

Hit3:
LINE (381, 60)-(461, 150), 8, B
LINE (380, 59)-(462, 151), 7, B
LINE (379, 58)-(463, 152), 15, B         ' PLAYER'S FIFTH CARD
LINE (378, 57)-(464, 153), 7, B
LINE (377, 56)-(465, 154), 8, B
LOCATE 7, 51: COLOR 15: PRINT CARD$(A7%)
Amount% = Amount% + Total7
LOCATE 12, 16: PRINT Amount%
IF Amount% > 21 THEN SLEEP 1: LOCATE 15, 4: PRINT "                                   ": COLOR 4: LOCATE 15, 25: PRINT "B     U     S     T    !   !  ! !": SLEEP 2: GOTO DealerTurn


DealerTurn:
d = 1
LOCATE 15, 4: PRINT "                                      ": LOCATE 15, 27: COLOR 4: PRINT "  S     T     A     N     D    "
SLEEP 1
LOCATE 15, 4: PRINT "                                                            ": COLOR 2: LOCATE 15, 25: PRINT "-- D E A L E R ' S    T U R N -- "
LOCATE 22, 4: COLOR 15: PRINT CARD$(A3%)
Amount.Dealer% = Total3 + Total4
LOCATE 28, 16: PRINT Amount.Dealer%
IF Amount.Dealer% > 16 THEN GOTO DealerStands


HitDealer:
IF d = 2 THEN GOTO HitDealer2
IF d = 3 THEN GOTO HitDealer3
SLEEP 1
LINE (193, 300)-(273, 390), 8, B
LINE (192, 299)-(274, 391), 7, B
LINE (191, 298)-(275, 392), 15, B            'DEALER'S THIRD CARD
LINE (190, 297)-(276, 393), 7, B
LINE (189, 296)-(277, 394), 8, B
LOCATE 22, 28: COLOR 15: PRINT CARD$(A8%)
Amount.Dealer% = Amount.Dealer% + Total8
LOCATE 28, 16: PRINT Amount.Dealer%
d = d + 1
IF Amount.Dealer% <= 16 THEN GOTO HitDealer
IF Amount.Dealer% > 16 AND Amount.Dealer% <= 21 THEN GOTO DealerStands
IF Amount.Dealer% > 21 THEN GOTO DealerOver

HitDealer2:
SLEEP 1
LINE (287, 300)-(367, 390), 8, B
LINE (286, 299)-(368, 391), 7, B
LINE (285, 298)-(369, 392), 15, B           ' DEALERS FOURTH CARD
LINE (284, 297)-(370, 393), 7, B
LINE (283, 296)-(371, 394), 8, B
LOCATE 22, 40: COLOR 15: PRINT CARD$(A9%)
Amount.Dealer% = Amount.Dealer% + Total9
LOCATE 28, 16: PRINT Amount.Dealer%
d = d + 1
IF Amount.Dealer% <= 16 THEN GOTO HitDealer
IF Amount.Dealer% > 16 AND Amount.Dealer% <= 21 THEN GOTO DealerStands
IF Amount.Dealer% > 21 THEN GOTO DealerOver

HitDealer3:
SLEEP 1
LINE (381, 300)-(461, 390), 8, B
LINE (380, 299)-(462, 391), 7, B
LINE (379, 298)-(463, 392), 15, B     ' DEALERS FIFTH CARD
LINE (378, 297)-(464, 393), 7, B
LINE (377, 296)-(465, 394), 8, B
LOCATE 22, 51: COLOR 15: PRINT CARD$(A10%)
Amount.Dealer% = Amount.Dealer% + Total10
LOCATE 28, 16: PRINT Amount.Dealer%
IF Amount.Dealer% > 21 THEN GOTO DealerOver


DealerStands:
SLEEP 1
IF Amount% > 21 THEN Amount$ = "BUST"
LOCATE 15, 4: PRINT "                                                     ": COLOR 15: LOCATE 15, 5: PRINT "YOUR TOTAL: ":
IF Amount% > 21 THEN LOCATE 15, 17: COLOR 4: PRINT Amount$: GOTO 4567
LOCATE 15, 16: COLOR 4: PRINT Amount%
4567
IF Amount.Dealer% > 21 THEN Amount.Dealer$ = "BUST"
LOCATE 15, 29: COLOR 15: PRINT "DEALER'S TOTAL: ":
IF Amount.Dealer% > 21 THEN LOCATE 15, 45: PRINT Amount.Dealer$
LOCATE 15, 45: COLOR 4: PRINT Amount.Dealer%
END

DealerOver:
LOCATE 15, 4: PRINT "                                                            ": LOCATE 15, 20: COLOR 4: PRINT "D  E  A  L  E  R     B  U  S  T  S ! ! !"

SUB AboutTopGunBlackJ

CLS
SCREEN 11
PRINT "                              TOPGUN BLACKJACK v1.0"
PRINT
PRINT "         Welcome to TOPGUN BLACKJACK v1.0!  This is the first version I"
PRINT "  created.  It's not very fancy at v1.0 but I plan to make about 5 or 6"
PRINT "  more versions after this.  Also, In this first version, there is not much"
PRINT "  you can do, and not much graphics.  In this, you can only HIT and STAND,"
PRINT "  and also the ACES are only allowed to be worth ONE, but in the later versions,"
PRINT "  I plan to have graphics for the cards, sounds, you will be able to SPLIT,"
PRINT "  DOUBLE DOWN and much more!  Thanks for downloading this game, and watch for"
PRINT "  better and revised versions in the future months !"
PRINT
PRINT "                                 HAVE FUN ! !"
PRINT
PRINT
PRINT "       -  TOPGUN PRODUCTIONS"
DO
A$ = INKEY$
LOOP UNTIL A$ = CHR$(13)

END SUB

SUB Instructions

CLS
DO
Instructions:
SCREEN 9
COLOR 15
LOCATE 2, 38: PRINT "RULES"
LINE (285, 10)-(346, 30), 8, B
LINE (284, 9)-(347, 31), 7, B
LINE (283, 8)-(348, 32), 15, B
LINE (282, 7)-(349, 33), 7, B
LINE (281, 6)-(350, 34), 8, B

LINE (1, 20)-(280, 20), 15: LINE (350, 20)-(640, 20), 15

LOCATE 5, 8
PRINT "THE OBJECT OF BLACKJACK IS TO GET THE CLOSEST TO 21 AS YOU CAN WITHOUT"
PRINT "GOING OVER IT. YOU START OFF WITH 2 CARDS, FROM THERE YOU CAN EITHER HIT OR"
PRINT "STAND (IN THIS VERSION)(IN LATER VERSIONS, YOU WILL HAVE MORE OPTIONS)."
PRINT "HITTING GIVES YOU ANOTHER CARD, STAND LETS YOU HAVE NO MORE CARDS."
LOCATE 12, 8
PRINT "THE DEALER:"
PRINT "          HAS TO HIT ON ANYTHING 16 OR UNDER. 17 OR OVER, HE STANDS."
LOCATE 17, 25: COLOR 1
PRINT " ++|PUSH ENTER TO CONTINUE|++"

A$ = INKEY$
LOOP UNTIL A$ = CHR$(13)
CLS

END SUB

SUB TitleScreen

CLS
SCREEN 12: COLOR 15
LOCATE 4, 33: PRINT "T  O  P  G  U  N"
LOCATE 6, 29: PRINT "B  L  A  C  K  J  A  C  K "
SLEEP 1: COLOR 5: LOCATE 7, 39: PRINT "v1.0"

SLEEP 1: COLOR 2
LOCATE 15, 30: PRINT "1) PLAY TOPGUN BLACKJACK"
COLOR 4
LOCATE 17, 30: PRINT "2) INSTRUCTIONS/RULES"
COLOR 5
LOCATE 19, 30: PRINT "3) EXIT GAME"

END SUB

SUB TopGunProductions

CLS
SCREEN 12
c = 0
DO
FOR A% = 1 TO 14
LOCATE 13, 33
COLOR A%
PRINT "TOPGUN PRODUCTIONS": LOCATE 14, 38: PRINT "PRESENT"
NEXT
c = c + 1: LOOP UNTIL c = 70
CLS
SLEEP 1

END SUB

