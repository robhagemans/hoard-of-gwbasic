DECLARE SUB DisplayAlien (Xalien!, Yalien!, NoAlien!)
DECLARE SUB ChooseAlien (NoAlien!)
DECLARE SUB pause (temps!)
DECLARE SUB DisGameOver ()
DECLARE SUB ExplosShip (Xship!, Yship!, SoundGame!)
DECLARE SUB EraseLaser (Xlaser!, Ylaser!)
DECLARE SUB MoveLaser (Xlaser!, Ylaser!)
DECLARE SUB DisplayLaser (Xlaser!, Ylaser!)
DECLARE SUB RefreshCadre (Score!, ShipBalls!, Life!)
DECLARE SUB DisplayCadre ()
DECLARE SUB DisAlien1 (Xalien!, Yalien!)
DECLARE SUB DisAlien2 (Xalien!, Yalien!)
DECLARE SUB DisAlien3 (Xalien!, Yalien!)
DECLARE SUB DisAlien4 (Xalien!, Yalien!)
DECLARE SUB DisAlien5 (Xalien!, Yalien!)
DECLARE SUB EraseAlien (LastX!, LastY!)
DECLARE SUB MoveAlien (Xalien!, Yalien!, StepAlien!, NoAlien!, SensAlienX, SensAlienY)
DECLARE SUB Entete (LimitSpeed, SoundGame)
DECLARE SUB MoveBall (Xball!, Yball!)
DECLARE SUB BallFire (Xship!, Yship!, Xball!, Yball!, ShipBalls!)
DECLARE SUB DisplayBall (Xball!, Yball!)
DECLARE SUB EraseBall (Xball!, Yball!)
DECLARE SUB DisplayDecor ()
DECLARE SUB ExplosAlien (Xball!, Yball!, SoundGame!)
DECLARE SUB DisplayShip (X!, Y!)
DECLARE SUB EraseShip (X!, Y!)

SCREEN 7

RANDOMIZE (1)

LimitSpeed = 1
SoundGame = 1

REM *************************** Restart For Each Game ***********************
DO
     CALL Entete(LimitSpeed, SoundGame)
     ShipBalls = 5
     Score = 0
     Life = 5
     GameOver = 0

     REM ************************ Restart For Each Life ***********************
     DO
           SensAlienX = INT(RND * 2)
           SensAlienY = INT(RND * 2)

           Xship = 145
           Yship = 165
           ShootBall = 0
           TBallShip = 0
           Dead = 0

           Xalien = 0
           Yalien = 20
           ShootAlien = 0
           CALL ChooseAlien(NoAlien)
           StepAlien = 0
           Talien = 0

           REM ********************* Display all at the beginning ****************
           CLS
           CALL DisplayCadre
           CALL RefreshCadre(Score, ShipBalls, Life)
           CALL DisplayDecor
           CALL DisplayShip(Xship, Yship)

           DO
                 REM ****************** Ship Ball Mouvement *************************
                 IF (ShootBall = 1) AND (TShipBall > 5 * LimitSpeed) THEN
                       CALL MoveBall(Xball, Yball)
                       REM *************** Ball on top of the screen *******************
                       IF (Yball < -3) THEN
                             ShootBall = 0

                             CALL EraseBall(Xball, Yball)
                             CALL DisplayCadre
                             CALL RefreshCadre(Score, ShipBalls, Life)

                             REM ************ If Gun Empty : Game Over ********************
                             IF (ShipBalls = 0) THEN
                                   Dead = 1
                                   GameOver = 1
                                   COLOR 14
                                   LOCATE 10, 11
                                   PRINT "Your gun is empty !!"
                                   CALL DisGameOver
                             END IF

                       END IF
                       TShipBall = 0
                 END IF
                 TShipBall = TShipBall + 1

                 REM ****************** Alien Mouvement *****************************
                 IF (Talien > 40 * LimitSpeed) AND (Dead = 0) THEN
                       CALL MoveAlien(Xalien, Yalien, StepAlien, NoAlien, SensAlienX, SensAlienY)
                       StepAlien = StepAlien + 1
                       Talien = 0

                       REM *************** Alien Shooting ******************************
                       IF (ShootAlien = 0) THEN
                             IF (5 * RND(10) < 1) THEN
                                   ShootAlien = 1
                                   Xlaser = Xalien + 10
                                   Ylaser = Yalien + 20
                                   CALL DisplayLaser(Xlaser, Ylaser)
                                   FOR i = 1 TO 5
                                         IF (SoundGame = 1) THEN
                                               SOUND (1000 - 10 * i), .2
                                         END IF
                                   NEXT i
                             END IF
                       END IF
                 END IF
                 Talien = Talien + 1

                 REM ****************** Alien'Laser Mouvement ***********************
                 IF (Tlaser > 20 * LimitSpeed) AND (ShootAlien = 1) AND (Dead = 0) THEN
                       IF (Ylaser > 162) THEN
                             ShootAlien = 0
                             CALL EraseLaser(Xlaser, Ylaser)
                       ELSE
                             CALL MoveLaser(Xlaser, Ylaser)
                       END IF
                             Tlaser = 0
                 END IF
                 Tlaser = Tlaser + 1

                 REM ****************** Collision With Alien ************************
                 IF (ShootBall = 1) AND (Dead = 0) THEN
                       IF (Xball > Xalien) AND (Xball < Xalien + 29) THEN
                             IF (Yball > Yalien) AND (Yball < Yalien + 19) THEN
                                   ShootBall = 0
                                   CALL EraseBall(Xball, Yball)
                                   CALL ExplosAlien(Xalien, Yalien, SoundGame)
                                   ShipBalls = ShipBalls + 2
                                   Score = Score + 1
                                   CALL DisplayCadre
                                   CALL RefreshCadre(Score, ShipBalls, Life)
                                   CALL ChooseAlien(NoAlien)
                                   StepAlien = 0
                                   SensAlienX = INT(RND * 2)
                                   SensAlienY = INT(RND * 2)

                                   END IF
                       END IF
                 END IF

                 REM ****************** Collision With Ship *************************
                 IF (ShootAlien = 1) AND (Dead = 0) THEN
                       IF (Xlaser + 10 > Xship) AND (Xlaser < Xship + 29) THEN
                             IF (Ylaser + 15 > Yship) AND (Ylaser < Yship + 19) THEN
                                   CALL EraseLaser(Xlaser, Ylaser)
                                   CALL ExplosShip(Xship, Yship, SoundGame)
                                   Life = Life - 1
                                   CALL RefreshCadre(Score, ShipBalls, Life)
                                   ShootAlien = 0
                                   Dead = 1
                                   SLEEP 1
                                   REM ********* If No Life : Game Over **********************
                                   IF (Life = 0) THEN
                                         GameOver = 1
                                         CALL DisGameOver
                                   END IF
                             END IF
                       END IF
                 END IF

                 REM ********************** Ship's Control *****************************
                 IF (Dead = 0) THEN
                       Piton$ = ""
                       Piton$ = INKEY$
                       SELECT CASE Piton$
                             REM ******************* Go Left ************************************
                             CASE "4"
                                   IF (Xship > -8) THEN
                                         LastX = Xship
                                         LastY = Yship
                                         Xship = Xship - 8
                                         CALL EraseShip(LastX, LastY)
                                         CALL DisplayShip(Xship, Yship)
                                         IF (SoundGame = 1) THEN
                                               SOUND 300, .2
                                         END IF
                                   END IF
                             REM ******************* Go Right ***********************************
                             CASE "6"
                                   IF (Xship < 304) THEN
                                         LastX = Xship
                                         LastY = Yship
                                         Xship = Xship + 8
                                         CALL EraseShip(LastX, LastY)
                                         CALL DisplayShip(Xship, Yship)
                                         IF (SoundGame = 1) THEN
                                               SOUND 300, .2
                                         END IF
                                   END IF
                             REM ******************* Press Fire *********************************
                             CASE " "
                                   IF (ShootBall = 0) AND (ShipBalls > 0) THEN
                                         CALL BallFire(Xship, Yship, Xball, Yball, ShipBalls)
                                         CALL RefreshCadre(Score, ShipBalls, Life)
                                         ShootBall = 1
                                   END IF

                       END SELECT
                 END IF
           REM ************************* Until Press ESC (exit game) ****************
           LOOP UNTIL (Piton$ = CHR$(27)) OR (Dead = 1)
     LOOP UNTIL (Piton$ = CHR$(27)) OR (GameOver = 1)

LOOP UNTIL 0

SUB BallFire (Xship, Yship, Xball, Yball, ShipBalls)
     Xball = Xship + 15
     Yball = Yship - 3

     CALL DisplayBall(Xball, Yball)

     ShipBalls = ShipBalls - 1

     FOR i = 1 TO 5
           IF (SoundGame = 1) THEN
                 SOUND (1000 - 180 * i), .1
           END IF
     NEXT i

END SUB

SUB ChooseAlien (NoAlien)
     lastNo = NoAlien
     DO
           NoAlien = INT(5 * RND(5) + 1)
     LOOP UNTIL (NoAlien <> lastNo)
END SUB

SUB DisAlien1 (Xalien, Yalien)
     LINE (Xalien + 10, Yalien + 2)-(Xalien + 19, Yalien + 3), 14, BF
     LINE (Xalien + 7, Yalien + 4)-(Xalien + 22, Yalien + 4), 9
     LINE (Xalien + 2, Yalien + 5)-(Xalien + 27, Yalien + 5), 14
     LINE (Xalien, Yalien + 6)-(Xalien + 29, Yalien + 12), 14, BF
     LINE (Xalien + 1, Yalien + 13)-(Xalien + 28, Yalien + 13), 14
     LINE (Xalien + 4, Yalien + 14)-(Xalien + 24, Yalien + 14), 14
     LINE (Xalien + 10, Yalien + 15)-(Xalien + 19, Yalien + 15), 14
     LINE (Xalien + 13, Yalien + 16)-(Xalien + 16, Yalien + 19), 11, BF
     LINE (Xalien + 11, Yalien + 18)-(Xalien + 18, Yalien + 18), 13
     LINE (Xalien + 7, Yalien + 15)-(Xalien + 10, Yalien + 18), 4
     LINE (Xalien + 22, Yalien + 15)-(Xalien + 19, Yalien + 18), 4
     LINE (Xalien + 3, Yalien + 8)-(Xalien + 6, Yalien + 11), 8, BF
     LINE (Xalien + 13, Yalien + 8)-(Xalien + 16, Yalien + 11), 8, BF
     LINE (Xalien + 23, Yalien + 8)-(Xalien + 26, Yalien + 11), 8, BF
     LINE (Xalien + 1, Yalien + 1)-(Xalien + 4, Yalien + 4), 13
     LINE (Xalien, Yalien)-(Xalien + 2, Yalien), 5
     LINE (Xalien + 28, Yalien + 1)-(Xalien + 25, Yalien + 4), 13
     LINE (Xalien + 27, Yalien)-(Xalien + 29, Yalien), 5
END SUB

SUB DisAlien2 (Xalien, Yalien)
     LINE (Xalien, Yalien + 5)-(Xalien + 5, Yalien + 17), 1, BF
     LINE (Xalien, Yalien + 6)-(Xalien, Yalien + 16), 9
     LINE (Xalien + 5, Yalien + 6)-(Xalien + 5, Yalien + 16), 9
     LINE (Xalien + 24, Yalien + 5)-(Xalien + 29, Yalien + 17), 1, BF
     LINE (Xalien + 24, Yalien + 6)-(Xalien + 24, Yalien + 16), 9
     LINE (Xalien + 29, Yalien + 6)-(Xalien + 29, Yalien + 16), 9
     LINE (Xalien + 6, Yalien + 7)-(Xalien + 8, Yalien + 5), 14
     LINE (Xalien + 6, Yalien + 10)-(Xalien + 8, Yalien + 10), 14
     LINE (Xalien + 21, Yalien + 5)-(Xalien + 23, Yalien + 7), 14
     LINE (Xalien + 21, Yalien + 10)-(Xalien + 23, Yalien + 10), 14
     LINE (Xalien + 9, Yalien + 2)-(Xalien + 20, Yalien + 14), 9, BF
     LINE (Xalien + 7, Yalien + 1)-(Xalien + 22, Yalien + 1), 1
     LINE (Xalien + 9, Yalien)-(Xalien + 20, Yalien), 1
     LINE (Xalien + 10, Yalien + 15)-(Xalien + 19, Yalien + 15), 9
     LINE (Xalien + 13, Yalien + 16)-(Xalien + 16, Yalien + 19), 12, BF
     LINE (Xalien + 12, Yalien + 18)-(Xalien + 17, Yalien + 18), 10
     LINE (Xalien + 11, Yalien + 8)-(Xalien + 12, Yalien + 12), 4, BF
     LINE (Xalien + 17, Yalien + 8)-(Xalien + 18, Yalien + 12), 4, BF
END SUB

SUB DisAlien3 (Xalien, Yalien)
     CIRCLE (Xalien + 15, Yalien + 8), 10, 11, 1.571, 3.1416
     CIRCLE (Xalien + 14, Yalien + 8), 10, 11, 0, 1.571
     LINE (Xalien, Yalien + 9)-(Xalien + 29, Yalien + 9), 7
     LINE (Xalien + 1, Yalien + 10)-(Xalien + 28, Yalien + 11), 14, BF
     LINE (Xalien, Yalien + 12)-(Xalien + 29, Yalien + 13), 7, BF
     LINE (Xalien + 1, Yalien + 14)-(Xalien + 28, Yalien + 14), 7
     LINE (Xalien + 3, Yalien + 15)-(Xalien + 26, Yalien + 15), 7
     LINE (Xalien + 6, Yalien + 16)-(Xalien + 23, Yalien + 16), 7
     LINE (Xalien + 10, Yalien + 17)-(Xalien + 19, Yalien + 17), 7
     LINE (Xalien + 12, Yalien + 18)-(Xalien + 17, Yalien + 18), 5
     LINE (Xalien + 13, Yalien + 19)-(Xalien + 16, Yalien + 19), 12
     LINE (Xalien + 8, Yalien + 17)-(Xalien + 6, Yalien + 19), 9
     LINE (Xalien + 21, Yalien + 17)-(Xalien + 23, Yalien + 19), 9
     LINE (Xalien + 3, Yalien + 10)-(Xalien + 4, Yalien + 11), 4, BF
     LINE (Xalien + 9, Yalien + 10)-(Xalien + 11, Yalien + 11), 4, BF
     LINE (Xalien + 18, Yalien + 10)-(Xalien + 20, Yalien + 11), 4, BF
     LINE (Xalien + 25, Yalien + 10)-(Xalien + 26, Yalien + 11), 4, BF
     LINE (Xalien + 9, Yalien + 5)-(Xalien + 11, Yalien + 3), 15
     LINE (Xalien + 12, Yalien + 5)-(Xalien + 17, Yalien + 7), 2, BF
     LINE (Xalien + 14, Yalien + 8)-(Xalien + 15, Yalien + 8), 2
     LINE (Xalien + 10, Yalien + 7)-(Xalien + 10, Yalien + 8), 2
     LINE (Xalien + 19, Yalien + 7)-(Xalien + 19, Yalien + 8), 2
     PSET (Xalien + 13, Yalien + 6), 15
     PSET (Xalien + 16, Yalien + 6), 15
END SUB

SUB DisAlien4 (Xalien, Yalien)
     LINE (Xalien + 10, Yalien)-(Xalien + 19, Yalien), 7
     LINE (Xalien + 8, Yalien + 1)-(Xalien + 21, Yalien + 1), 7
     LINE (Xalien + 5, Yalien + 2)-(Xalien + 24, Yalien + 2), 7
     LINE (Xalien + 4, Yalien + 3)-(Xalien + 25, Yalien + 6), 7, BF
     LINE (Xalien + 4, Yalien + 4)-(Xalien + 25, Yalien + 4), 8
     LINE (Xalien + 10, Yalien + 7)-(Xalien + 19, Yalien + 13), 8, BF
     LINE (Xalien + 8, Yalien + 14)-(Xalien + 21, Yalien + 15), 7, BF
     LINE (Xalien + 11, Yalien + 16)-(Xalien + 18, Yalien + 16), 7
     LINE (Xalien + 13, Yalien + 17)-(Xalien + 16, Yalien + 19), 12, BF
     LINE (Xalien + 12, Yalien + 18)-(Xalien + 17, Yalien + 18), 5, BF
     LINE (Xalien + 5, Yalien + 7)-(Xalien, Yalien + 12), 9
     LINE (Xalien + 6, Yalien + 18)-(Xalien, Yalien + 12), 9
     LINE (Xalien + 4, Yalien + 16)-(Xalien + 4, Yalien + 19), 9
     LINE (Xalien + 24, Yalien + 7)-(Xalien + 29, Yalien + 12), 9
     LINE (Xalien + 23, Yalien + 18)-(Xalien + 29, Yalien + 12), 9
     LINE (Xalien + 25, Yalien + 16)-(Xalien + 25, Yalien + 19), 9
     LINE (Xalien + 11, Yalien + 8)-(Xalien + 11, Yalien + 11), 14
     LINE (Xalien + 12, Yalien + 10)-(Xalien + 13, Yalien + 12), 14, BF
     LINE (Xalien + 18, Yalien + 8)-(Xalien + 18, Yalien + 11), 14
     LINE (Xalien + 17, Yalien + 10)-(Xalien + 16, Yalien + 12), 14, BF
END SUB

SUB DisAlien5 (Xalien, Yalien)
     CIRCLE (Xalien + 3, Yalien + 4), 3, 2
     LINE (Xalien + 1, Yalien + 3)-(Xalien + 5, Yalien + 5), 10, BF
     CIRCLE (Xalien + 26, Yalien + 4), 3, 2
     LINE (Xalien + 28, Yalien + 3)-(Xalien + 24, Yalien + 5), 10, BF
     CIRCLE (Xalien + 3, Yalien + 15), 3, 2
     LINE (Xalien + 1, Yalien + 14)-(Xalien + 5, Yalien + 16), 10, BF
     CIRCLE (Xalien + 26, Yalien + 15), 3, 2
     LINE (Xalien + 28, Yalien + 14)-(Xalien + 24, Yalien + 16), 10, BF
     LINE (Xalien + 5, Yalien + 7)-(Xalien + 5, Yalien + 12), 11
     LINE (Xalien + 6, Yalien + 6)-(Xalien + 6, Yalien + 13), 12
     LINE (Xalien + 24, Yalien + 7)-(Xalien + 24, Yalien + 12), 11
     LINE (Xalien + 23, Yalien + 6)-(Xalien + 23, Yalien + 13), 12
     LINE (Xalien + 7, Yalien + 8)-(Xalien + 22, Yalien + 9), 12, BF
     LINE (Xalien + 9, Yalien + 4)-(Xalien + 20, Yalien + 13), 10, BF
     LINE (Xalien + 10, Yalien + 14)-(Xalien + 19, Yalien + 15), 10, BF
     LINE (Xalien + 11, Yalien + 16)-(Xalien + 18, Yalien + 16), 10
     LINE (Xalien + 13, Yalien + 17)-(Xalien + 16, Yalien + 19), 12, BF
     LINE (Xalien + 12, Yalien + 18)-(Xalien + 17, Yalien + 18), 5
     LINE (Xalien + 10, Yalien + 1)-(Xalien + 10, Yalien + 3), 2
     LINE (Xalien + 13, Yalien)-(Xalien + 16, Yalien + 3), 2, BF
     LINE (Xalien + 19, Yalien + 1)-(Xalien + 19, Yalien + 3), 2
     LINE (Xalien + 10, Yalien + 7)-(Xalien + 11, Yalien + 12), 1, BF
     LINE (Xalien + 14, Yalien + 6)-(Xalien + 15, Yalien + 13), 1, BF
     LINE (Xalien + 19, Yalien + 7)-(Xalien + 18, Yalien + 12), 1, BF
END SUB

SUB DisGameOver
     LOCATE 12, 13
     COLOR 12
     PRINT "G A M E   O V E R"
     SLEEP
END SUB

SUB DisplayBall (Xball, Yball)
     CIRCLE (Xball, Yball), 3, 15
     LINE (Xball - 2, Yball - 2)-(Xball + 2, Yball + 2), 15, BF
     LINE (Xball + 1, Yball)-(Xball + 2, Yball + 1), 0, BF
END SUB

SUB DisplayCadre
     SCREEN 7
     COLOR 15, 0
     LOCATE 1, 2
     PRINT "Score : "
     LOCATE 1, 17
     PRINT "Gun : "
     LOCATE 1, 32
     PRINT "Life : "

END SUB

SUB DisplayDecor
     LINE (0, 183)-(319, 199), 4, BF

     REM horizontal
     LINE (0, 184)-(319, 184), 12
     LINE (0, 188)-(319, 188), 12
     LINE (0, 193)-(319, 193), 12

     REM oblique
     FOR i = 0 TO 20
           LINE (160 - 15 * i + 0, 183)-(160 - 25 * i + 0, 199), 12
           LINE (160 + 15 * i + 0, 183)-(160 + 25 * i + 0, 199), 12
     NEXT i



END SUB

SUB DisplayLaser (Xlaser, Ylaser)
     LINE (Xlaser, Ylaser + 1)-(Xlaser + 2, Ylaser + 14), 5, BF
     LINE (Xlaser + 7, Ylaser + 1)-(Xlaser + 9, Ylaser + 14), 5, BF

     LINE (Xlaser + 1, Ylaser)-(Xlaser + 1, Ylaser + 15), 13
     LINE (Xlaser + 8, Ylaser)-(Xlaser + 8, Ylaser + 15), 13

END SUB

SUB DisplayShip (X, Y)
     REM *******************The three wells**********************************
     CIRCLE (X + 5, Y + 14), 4, 7
     CIRCLE (X + 15, Y + 14), 4, 7
     CIRCLE (X + 25, Y + 14), 4, 7

     REM *******************Inside the wells*********************************
     LINE (X + 4, Y + 13)-(X + 6, Y + 15), 8, BF
     LINE (X + 14, Y + 13)-(X + 16, Y + 15), 8, BF
     LINE (X + 24, Y + 13)-(X + 26, Y + 15), 8, BF

     REM *******************The body*****************************************
     LINE (X, Y + 10)-(X + 30, Y + 10), 11
     LINE (X + 2, Y + 7)-(X + 28, Y + 9), 11, BF
     LINE (X + 3, Y + 6)-(X + 27, Y + 6), 11
     LINE (X + 6, Y + 5)-(X + 24, Y + 5), 11

     REM *******************The gun******************************************
     LINE (X + 12, Y + 1)-(X + 18, Y + 4), 7, BF
     LINE (X + 11, Y)-(X + 19, Y), 4

     REM *******************The windows*************************************
     LINE (X + 8, Y + 6)-(X + 10, Y + 9), 1, BF
     LINE (X + 14, Y + 6)-(X + 16, Y + 9), 1, BF
     LINE (X + 20, Y + 6)-(X + 22, Y + 9), 1, BF
END SUB

SUB Entete (LimitSpeed, SoundGame)
     CLS
     COLOR 15
     FOR i = 1 TO 200
           X = RND * 320
           Y = RND * 200

           col = INT(RND * 4)

           SELECT CASE col
                 CASE 0
                       col = 15
                 CASE 1
                       col = 7
                 CASE 2
                       col = 8
                 CASE 3
                       col = 11
           END SELECT

           PSET (X, Y), col
     NEXT i

     COLOR 5
     LOCATE 2, 13
     PRINT "ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
     LOCATE 3, 11
     PRINT "ÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄ"
     LOCATE 5, 11
     PRINT "ÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄ"
     LOCATE 6, 13
     PRINT "ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"


     COLOR 12
     LOCATE 4, 13
     PRINT "S K Y     S C R A P"

     COLOR 8
     LOCATE 13, 11
     PRINT "1. Start a new game"
     LOCATE 15, 11
     PRINT "2. Sound   ("
     LOCATE 17, 11
     PRINT "3. Speed   ("
     LOCATE 19, 11
     PRINT "4. Exit"

     LOCATE 15, 23
     IF (SoundGame = 1) THEN
           PRINT "ON ) "
     ELSE
           PRINT "OFF )"
     END IF
     LOCATE 17, 22
     PRINT LimitSpeed; ") "


     COLOR 1
     LOCATE 22, 10
     PRINT "By Etienne Boutin, 1999"
     LOCATE 23, 12
     PRINT "No right reserved !"

     DO
           choix$ = INKEY$

           SELECT CASE choix$
                 CASE "2"
                       IF (SoundGame = 1) THEN
                             SoundGame = 0
                       ELSE
                             FOR j = 1 TO 25
                                   SOUND (100 * j + 100), .1
                             NEXT j
                             SoundGame = 1
                       END IF

                       COLOR 8
                       LOCATE 15, 23
                       IF (SoundGame = 1) THEN
                             PRINT "ON ) "
                       ELSE
                             PRINT "OFF )"
                       END IF

                 CASE "3"
                       IF (LimitSpeed > 29) THEN
                             LimitSpeed = 1
                       ELSE
                             LimitSpeed = LimitSpeed + 1
                       END IF

                       COLOR 8
                       LOCATE 17, 22
                       PRINT LimitSpeed; ") "

                 CASE "4"
                       CLS
                       SCREEN 2
                       END
           END SELECT
           CALL pause(500 * LimitSpeed)
     LOOP UNTIL choix$ = "1"

END SUB

SUB EraseAlien (LastX, LastY)
     LINE (LastX, LastY)-(LastX + 29, LastY + 19), 0, BF
END SUB

SUB EraseBall (Xball, Yball)
     CIRCLE (Xball, Yball), 3, 0
     LINE (Xball - 2, Yball - 2)-(Xball + 2, Yball + 2), 0, BF
END SUB

SUB EraseLaser (Xlaser, Ylaser)
     LINE (Xlaser, Ylaser)-(Xlaser + 10, Ylaser + 15), 0, BF
END SUB

SUB EraseShip (X, Y)
     LINE (X, Y)-(X + 30, Y + 17), 0, BF
END SUB

SUB ExplosAlien (X, Y, SoundGame)
     FOR i = 1 TO 20
           rnd1 = RND(10)
           rnd2 = RND(10)
           rnd3 = RND(10)

           CIRCLE (X + 15 + 40 * rnd1 - 20, Y + 10 + 25 * rnd2 - 12), 8 * rnd3, 4
           CIRCLE (X + 15 + 30 * rnd1 - 15, Y + 10 + 20 * rnd2 - 10), 5 * rnd3, 12
           CIRCLE (X + 15 + 15 * rnd1 - 8, Y + 10 + 10 * rnd2 - 5), 3 * rnd3, 14

           IF (SoundGame = 1) THEN
                 SOUND (4000 - 60 * i), .1
                 SOUND (500 + 100 * i), .1
           END IF
     NEXT i
     FOR i = 1 TO 20
           IF (SoundGame = 1) THEN
                 SOUND (500 + 5 * i * i), .2
           END IF
     NEXT i
     LINE (X - 15, Y - 10)-(X + 45, Y + 30), 0, BF

END SUB

SUB ExplosShip (Xship, Yship, SoundGame)
     FOR i = 1 TO 30
           rnd1 = RND(10)
           rnd2 = RND(10)
           rnd3 = RND(10)

           CIRCLE (Xship + 30 * rnd1, Yship + 17), 10 + 20 * rnd2, 4, 0, 3.1416, rnd3
           CIRCLE (Xship + 30 * rnd2, Yship + 17), 3 + 15 * rnd3, 12, 0, 3.1416, rnd2
           CIRCLE (Xship + 30 * rnd3, Yship + 17), 1 + 10 * rnd1, 14, 0, 3.1416, rnd1

           IF (SoundGame = 1) THEN
                 SOUND (4000 - 120 * i), .2
                 SOUND (1000 + 10 * i * i), .2
           END IF
     NEXT i
     FOR i = 1 TO 50
           IF (SoundGame = 1) THEN
                 SOUND (1000 + 500 * SIN(i / 5) - 10 * i), .2
           END IF
           LINE (Xship + 15, Yship + 17)-(Xship - 20 + 70 * RND(10), Yship - 50 + 40 * RND(10)), 14 + RND(1)
     NEXT i

END SUB

SUB MoveAlien (Xalien, Yalien, StepAlien, NoAlien, SensAlienX, SensAlienY)
     LastX = Xalien
     LastY = Yalien
     SensX = (2 * SensAlienX - 1)
     SensY = (2 * SensAlienY - 1)
     SELECT CASE NoAlien
           REM ***************** Alien #1 ****************************************
           CASE 1
                 Xalien = 144 + SensX * 170 * COS(StepAlien / 12)
                 Yalien = 75 + SensY * 55 * SIN(StepAlien / 31)
                 CALL EraseAlien(LastX, LastY)
                 CALL DisAlien1(Xalien, Yalien)

           REM ***************** Alien #2 ****************************************
           CASE 2
                 Xalien = 144 - SensX * 150 * COS(StepAlien / 17)
                 Yalien = 75 + SensY * 45 * SIN(StepAlien / 8) + SensY * 15 * COS(StepAlien / 3)
                 CALL EraseAlien(LastX, LastY)
                 CALL DisAlien2(Xalien, Yalien)

           REM ***************** Alien #3 ****************************************
           CASE 3
                 Xalien = 144 + SensX * 160 * COS(StepAlien / 8)
                 Yalien = 75 + SensY * 50 * SIN(StepAlien / 8)
                 CALL EraseAlien(LastX, LastY)
                 CALL DisAlien3(Xalien, Yalien)

           REM ***************** Alien 4 *****************************************
           CASE 4
                 Xalien = 144 - SensX * 120 * COS(StepAlien / 15) - SensX * 50 * COS(StepAlien / 45)
                 Yalien = 75 + SensY * 60 * COS(StepAlien / 8)
                 CALL EraseAlien(LastX, LastY)
                 CALL DisAlien4(Xalien, Yalien)

           REM ***************** Alien 5 *****************************************
           CASE 5
                 Xalien = 144 + SensX * 60 * COS(StepAlien / 6) + SensX * 100 * COS(StepAlien / 80)
                 Yalien = 75 + SensY * 40 * SIN(StepAlien / 6)
                 CALL EraseAlien(LastX, LastY)
                 CALL DisAlien5(Xalien, Yalien)

     END SELECT
END SUB

SUB MoveBall (Xball, Yball)
     LastX = Xball
     LastY = Yball
     Yball = Yball - 3
     CALL EraseBall(LastX, LastY)
     CALL DisplayBall(Xball, Yball)
END SUB

SUB MoveLaser (Xlaser, Ylaser)
     LastY = Ylaser
     Ylaser = Ylaser + 5
     CALL EraseLaser(Xlaser, LastY)
     CALL DisplayLaser(Xlaser, Ylaser)
END SUB

SUB pause (temps)
     FOR i = 1 TO temps
     NEXT i
END SUB

SUB RefreshCadre (Score, ShipBalls, Life)
     COLOR 9, 0
     LOCATE 1, 9
     PRINT Score
     LOCATE 1, 22
     PRINT ShipBalls
     LOCATE 1, 38
     PRINT Life
END SUB