DECLARE SUB LostLife (Xballe, Yballe, SoundGame)
DECLARE SUB GameOver (SoundGame)
DECLARE SUB SoundWall (SoundGame)
DECLARE SUB SoundRoof (SoundGame)
CONST PI = 3.1415926#
DECLARE SUB RefreshCadre (Score!, Life!)
DECLARE SUB DisplayCadre ()
DECLARE SUB Entete (LimitSpeed!, SoundGame!)
DECLARE SUB DisplayBalle (X!, Y!)
DECLARE SUB EraseBalle (X!, Y!)
DECLARE SUB ErasePlate (Xplate!, Yplate!)
DECLARE SUB DisplayPlate (Xplate!, Yplate!)
DECLARE SUB pause (temps!)

LimitSpeed = 1
SoundGame = 1

DO
     game = 1
     sortie = 0
     Xballe = 158
     Yballe = 12
     Xplate = 149
     Yplate = 190
     SidePlate = 20
     AngleBalle = 1.5
     Score = 0
     Life = 5

     SCREEN 7
     CLS

     CALL Entete(LimitSpeed, SoundGame)
     CALL DisplayCadre
     CALL DisplayPlate(Xplate, Yplate)
     CALL RefreshCadre(Score, Life)
     i = 0
     DO
           REM *********************************Speed of Balle*********************
           IF (i > 10 * LimitSpeed) THEN
                 IF (AngleBalle > 2 * PI) THEN
                         AngleBalle = AngleBalle - 2 * PI
                 END IF

                 REM ******************************Right wall*************************
                 IF (Xballe > 315) AND ((AngleBalle >= 3 * PI / 2) OR (AngleBalle <= PI / 2)) THEN
                         AngleBalle = 3 * PI - AngleBalle
                         CALL SoundWall(SoundGame)
                 END IF

                 REM ******************************Left wall**************************
                 IF (Xballe < 4) AND ((AngleBalle >= PI / 2) AND (AngleBalle <= 3 * PI / 2)) THEN
                         AngleBalle = 3 * PI - AngleBalle
                         CALL SoundWall(SoundGame)
                 END IF

                 REM ******************************The roof***************************
                 IF (Yballe < 12) AND (AngleBalle >= PI) THEN
                         AngleBalle = -AngleBalle + 2 * PI
                         Score = Score + 1
                         CALL SoundRoof(SoundGame)
                         CALL RefreshCadre(Score, Life)
                         LINE (1, 8)-(318, 8), 14
                         CALL pause(50 * LimitSpeed)
                         LINE (1, 8)-(318, 8), 4
                 END IF

                 REM******************************The floor***************************
                 IF (AnleBalle < PI) THEN
                       IF (Yballe > 186) AND (Yballe < 190) THEN
                               REM **********************Collision with plate****************
                               IF (Xplate - Xballe < 3) AND (Xplate - Xballe > -SidePlate - 3) THEN
                                     IF (SoundGame = 1) THEN
                                           SOUND (300), 1
                                     END IF
                                     AngleBalle = 3 * PI / 2 + ATN((Xballe - Xplate - SidePlate / 2) / (SidePlate / 2))
                               END IF
                       END IF

                       REM***************************Miss the ball***********************
                       IF (Yballe >= 190) THEN
                             Life = Life - 1
                             CALL RefreshCadre(Score, Life)
                             CALL LostLife(Xballe, Yballe, SoundGame)
                             IF (Life = 0) THEN
                                   CALL GameOver(SoundGame)
                                   game = 0
                             ELSE
                                   REM*********************Reset the variables*****************
                                   Xballe = 159
                                   Yballe = 12
                                   Xplate = 149
                                   Yplate = 190
                                   AngleBalle = 1.5
                                   CLS
                                   CALL DisplayCadre
                                   CALL DisplayPlate(Xplate, Yplate)
                                   CALL RefreshCadre(Score, Life)
                             END IF
                       END IF
                 END IF

                 REM *****************************Move the ball***********************
                 LastX = Xballe
                 LastY = Yballe
                 Xballe = Xballe + COS(AngleBalle)
                 Yballe = Yballe + SIN(AngleBalle)
                 CALL EraseBalle(LastX, LastY)
                 CALL DisplayBalle(Xballe, Yballe)
                 i = 0
           END IF

           Piton$ = INKEY$

           REM ********************************Move plate at left******************
           IF (Piton$ = "4") AND (Xplate > 1) THEN
                 CALL ErasePlate(Xplate, Yplate)
                 Xplate = Xplate - 10
                 CALL DisplayPlate(Xplate, Yplate)
           END IF

           REM ********************************Move plate at right*****************
           IF (Piton$ = "6") AND (Xplate < 319 - SidePlate) THEN
                 CALL ErasePlate(Xplate, Yplate)
                 Xplate = Xplate + 10
                 CALL DisplayPlate(Xplate, Yplate)
           END IF

           REM ********************************Exit game if press ESC**************
           IF Piton$ = CHR$(27) THEN
                 game = 0
           END IF

           i = i + 1
     LOOP UNTIL game = 0
LOOP UNTIL 0

SUB DisplayBalle (X, Y)
     CIRCLE (X, Y), 2, (15)
     LINE (X - 1, Y - 1)-(X + 1, Y + 1), 15, BF
END SUB

SUB DisplayCadre
     SCREEN 7
     COLOR 15, 0
     LOCATE 1, 2
     PRINT "Score : "
     LOCATE 1, 32
     PRINT "Life : "

     LINE (0, 8)-(0, 189), 4
     LINE (319, 8)-(319, 189), 4
     LINE (0, 8)-(319, 8), 4

END SUB

SUB DisplayPlate (Xplate, Yplate)
     LINE (Xplate, Yplate)-(Xplate + 20, Yplate + 2), 3, BF
END SUB

SUB Entete (LimitSpeed, SoundGame)
     COLOR 3
     LOCATE 10, 12
     PRINT "P O N G     P L U S"
     COLOR 2
     LOCATE 11, 10
     PRINT "ÀÄÍÍÍÍÍÍØÍÎÍØÍÍÍÍÍÍÄÙ"

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

     Xballe = 158
     Yballe = 45
     i = 0
     DO
           LastX = Xballe
           LastY = Yballe
           Xballe = 158 + 150 * SIN(i / 50)
           Yballe = 60 + 20 * COS(i / 5) * COS(i / 50) - 35 * COS(i / 25)

           CALL EraseBalle(LastX, LastY)
           CALL DisplayBalle(Xballe, Yballe)

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
           i = i + 1
     LOOP UNTIL choix$ = "1"
     CLS
END SUB

SUB EraseBalle (X, Y)
     CIRCLE (X, Y), 2, (16 * RND(16))
END SUB

SUB ErasePlate (Xplate, Yplate)
     LINE (Xplate, Yplate)-(Xplate + 20, Yplate + 2), 0, BF
END SUB

SUB GameOver (SoundGame)
     LOCATE 10, 12
     PRINT "G A M E     O V E R"
     SLEEP
END SUB

SUB LostLife (Xballe, Yballe, SoundGame)
     FOR i = 1 TO 500
           angle = 2 * PI * 10 * RND(10)
           lamda = 20 * RND(50)
           RndColor = INT(10 * RND(4))
           SELECT CASE RndColor
                 CASE 1
                       ColorSpark = 4
                 CASE 2
                       ColorSpark = 12
                 CASE 3
                       ColorSpark = 14
                 CASE 4
                       ColorSpark = 15
           END SELECT

           LINE (Xballe + 10 * SIN(i / 20), Yballe - i / 10)-(Xballe + i / 10 * COS(i / 20) + lamda * COS(angle), Yballe + lamda * SIN(angle) - i / 5), ColorSpark
           IF (SoundGame = 1) THEN
                 SOUND (1200 - 2 * i + 150 * RND(50)), .1
           ELSE
                 SOUND 0, .1
           END IF
     NEXT i
     SLEEP

END SUB

SUB pause (temps)

       FOR i = 0 TO temps
       NEXT i

END SUB

SUB RefreshCadre (Score, Life)
     COLOR 9, 0
     LOCATE 1, 9
     PRINT Score
     LOCATE 1, 38
     PRINT Life
END SUB

SUB SoundPlate (SoundGame)
     IF (SoundGame = 1) THEN
           SOUND 300, 1
     END IF
END SUB

SUB SoundRoof (SoundGame)
     IF (SoundGame = 1) THEN
           SOUND 600, 1
     END IF
END SUB

SUB SoundWall (SoundGame)
     IF (SoundGame = 1) THEN
           SOUND 450, 1
     END IF
END SUB