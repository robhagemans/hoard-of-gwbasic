'$DYNAMIC
DEFINT A-Z
DECLARE SUB Alert ()
DECLARE SUB Plot12 ()
DECLARE SUB Plot9 ()
DECLARE SUB Calculate ()
DECLARE SUB DefaultChoices ()
DECLARE SUB Influences ()
DECLARE SUB Plot ()
DECLARE SUB Menu ()
DECLARE SUB TestScreens ()
DECLARE SUB TitleScreen ()
DECLARE SUB Mcenter (LineNumber, Message$)
DECLARE SUB Parameters ()
DECLARE SUB SetUpScreen ()

CONST True = -1, False = NOT True
CONST Gravity = 0, Tornado = 1, LGravity = 2
CONST None = 0, Normal = 1, Special = 2, Shades = 3
CONST Animated = 0, SingleFrame = 1
CONST Pi = 1.570796

DIM SHARED Enter$, Escape$, UpArrow$, DownArrow$, LeftArrow$, RightArrow$
Enter$ = CHR$(13)
Escape$ = CHR$(27)
UpArrow$ = CHR$(0) + CHR$(72)
DownArrow$ = CHR$(0) + CHR$(80)
LeftArrow$ = CHR$(0) + CHR$(75)
RightArrow$ = CHR$(0) + CHR$(77)



REDIM SHARED Points9x(7, 70, 50), Points9y(7, 70, 50)
REDIM SHARED Points12x(130, 100), Points12y(130, 100)
DIM SHARED Infx(10), Infy(10), Infd(10), Direction(10) AS SINGLE, Typ(10)
DIM SHARED Xstep, Ystep, MaxAng AS SINGLE, NumInf
DIM SHARED MaxX, MaxY, ScreenMode
DIM SHARED Screen9, Screen12
DIM SHARED NumOpts, Options$(6), NumChoices(6), Choices$(6, 18)
DIM SHARED Choice(6)
DIM SHARED Ma, Mb


READ NumOpts
FOR A = 1 TO NumOpts
    READ Options$(A), NumChoices(A)
    FOR B = 1 TO NumChoices(A)
        READ Choices$(A, B)
    NEXT
NEXT
TimeDelay = 2000
DefaultChoices

TestScreens
IF NOT Screen9 AND NOT Screen12 THEN
    PRINT "Sorry, EGA or VGA required!"
    END
END IF
TitleScreen
Menu
CLS
COLOR 15
PRINT "Zeek thanks you very much for choosing his program."
COLOR 7
END

BadScreenMode:
    BadScreen = False
RESUME NEXT

DATA 6
DATA "X Step",4,"5","10","15","20"
DATA "Y Step",3,"5","10","20"
DATA "Maximum Angle of Rotation", 18,"10","20","30","40","50","60","70","80","90","100","110","120","130","140","150","160","170","180"
DATA "Type of Display",2,"Animated","High Resolution"
DATA "Type of Filling",4,"None(Fastest)","Normal(Fast)","Special(Slow)","Shades(Fast)"
DATA "Type of Gravity",2,"Normal(Slow)","Linear(Fast)"

REM $STATIC
SUB Alert
    PLAY "t240l15mbo4fp8fp8fp8"
END SUB

SUB Calculate

    Xstep = Choice(1) * 5
   
    SELECT CASE Choice(2)
    CASE 1
        Ystep = 5
    CASE 2
        Ystep = 10
    CASE 3
        Ystep = 20
    END SELECT
    MaxAng = (Choice(3) * 10) / 90 * Pi
   
    IF Choice(4) = 1 THEN
        MaxScreen = 7: MaxX = 319: MaxY = 199
    ELSE
        MaxScreen = 0: MaxX = 639: MaxY = 479
        FOR A = 0 TO NumInf
            Infx(A) = Infx(A) * 2
            Infy(A) = Infy(A) * 2.4
            Infd(A) = Infd(A) * 2
        NEXT
    END IF



    SetUpScreen
    Mcenter 25, "Press ESC to Abort"
    COLOR 14 + 16
    Mcenter 3, "Please Wait:Calculating..."
    COLOR 15
    MRows = INT(MaxX / Xstep + 3)
    FOR Sc = 0 TO MaxScreen
        OffsetX = Sc * ((Xstep - (Xstep / 7)) / 7)
        OffsetY = Sc * ((Ystep - (Ystep / 7)) / 7)

        A = 0: B = 0
        FOR Xw = -Xstep TO MaxX + 1 STEP Xstep
            FOR Yw = -Ystep TO MaxY + Ystep STEP Ystep
                Xoffset = 0: Yoffset = 0: X = Xw + OffsetX: Y = Yw + OffsetY
          
                FOR An = 0 TO NumInf - 1
                    Xd! = X - Infx(An)
                    Yd! = Y - Infy(An)
                    Distance! = SQR(Xd! * Xd! + Yd! * Yd!)
                    IF Distance! < Infd(An) THEN
                        IF Typ(An) = Gravity THEN
                            IF Choice(6) = 1 THEN
                                Dx = Infx(An) - X
                                Xoffset = Xoffset + (Direction(An) * (Dx - Dx * SIN(Pi * Distance! / Infd(An))))
                                Dy = Infy(An) - Y
                                Yoffset = Yoffset + (Direction(An) * (Dy - Dy * SIN(Pi * Distance! / Infd(An))))
                            ELSE
                                Df! = (Infd(An) - Distance!) / Infd(An)
                                Xoffset = Xoffset + Direction(An) * (Infx(An) - X) * Df!
                                Yoffset = Yoffset + Direction(An) * (Infy(An) - Y) * Df!
                            END IF
                        ELSE
                           
                           
                            Ag! = Direction(An) * MaxAng * (1 - COS(Pi * (Infd(An) - Distance!) / Infd(An)))
                            Xoffset = Xoffset + Xd! * COS(Ag!) - Yd! * SIN(Ag!) + Infx(An) - X
                            Yoffset = Yoffset + Xd! * SIN(Ag!) + Yd! * COS(Ag!) + Infy(An) - Y
                        END IF
                    END IF
                NEXT

                IF Choice(4) = 1 THEN
                    Points9x(Sc, A, B) = X + Xoffset
                    Points9y(Sc, A, B) = Y + Yoffset
                ELSE
                    Points12x(A, B) = X + Xoffset
                    Points12y(A, B) = Y + Yoffset
                END IF
                B = B + 1
            NEXT
            A$ = INKEY$
            IF A$ = Escape$ THEN EXIT SUB
           
            Mb = B
            B = 0: A = A + 1
            A$ = "Screen " + MID$(STR$(Sc + 1), 2) + " of " + MID$(STR$(MaxScreen + 1), 2) + " is " + MID$(STR$(INT(A / MRows * 100 + .5)), 2) + "% complete.  "
            LOCATE 12, 1: PRINT SPACE$(80)
            Mcenter 12, A$
        NEXT
        Ma = A
    NEXT
    Plot

END SUB

SUB DefaultChoices
    Choice(1) = 2
    Choice(2) = 2
    Choice(3) = 9
    Choice(4) = 1
    Choice(5) = 2
    Choice(6) = 1
END SUB

SUB Influences
    SetUpScreen
    Mcenter 3, "Keys Used for Chosing Influences"
    Mcenter 25, "Press any key to continue..."
    COLOR 15
    Mcenter 6, "Use Arrow Keys to Choose the Center of the Influence, then:"
    Mcenter 8, "Press U for Upward Influence"
    Mcenter 10, "Press D for Downward Influence"
    Mcenter 12, "Press L for Left Tornado"
    Mcenter 14, "Press R for Right Tornado"
    Mcenter 16, "After the Type is Selected, Use the Arrow Keys to"
    Mcenter 18, "Adjust the Size of the Blip and Then Press the Spacebar"
    Mcenter 20, "Press Enter When All of the Influences Have Been Selected, or"
    Mcenter 22, "Press ESC At Any Time for the Main Menu"
    A$ = INPUT$(1)
    IF A$ = Escape$ THEN EXIT SUB
    SCREEN 7, , 0, 0
    NumInf = 0
    Xloc = 160
    Yloc = 100
    DO
        DO
            PCOPY 0, 1
            DRAW "C14BM" + STR$(Xloc) + "," + STR$(Yloc) + ";bu1nu3bd2nd3bu1bl1nl3br2r3C15"
            DO
                GOSUB GetKey
                IF A$ = " " THEN
                    Alert
                END IF
            LOOP WHILE A$ = " "
            PCOPY 1, 0
            IF A$ = Enter$ OR A$ = Escape$ THEN EXIT SUB
        LOOP UNTIL INSTR("UDLR", A$) <> 0
        Infx(NumInf) = Xloc
        Infy(NumInf) = Yloc
        IF A$ = "U" OR A$ = "D" THEN
            Typ(NumInf) = Gravity
            IF A$ = "D" THEN
                Direction(NumInf) = 1
            ELSE
                Direction(NumInf) = -1
            END IF
        ELSE
            Typ(NumInf) = Tornado
            IF A$ = "L" THEN
                Direction(NumInf) = 1
            ELSE
                Direction(NumInf) = -1
            END IF
        END IF
        DO
            PCOPY 0, 1
            DRAW "BM" + STR$(Xloc) + "," + STR$(Yloc) + ";bu1nu3bd2nd3bu1bl1nl3br2r3"
            Distance = SQR(ABS(Infx(NumInf) - Xloc) ^ 2 + ABS(Infy(NumInf) - Yloc) ^ 2)
            CIRCLE (Infx(NumInf), Infy(NumInf)), Distance
            DO
                GOSUB GetKey
                IF A$ = Enter$ THEN A$ = " "
                IF INSTR("UDLR", A$) <> 0 THEN
                    Alert
                END IF
            LOOP WHILE INSTR("UDLR", A$) <> 0
            PCOPY 1, 0
        LOOP UNTIL A$ = " " OR A$ = Escape$
        IF A$ <> Escape$ THEN
            Infd(NumInf) = Distance
            CIRCLE (Infx(NumInf), Infy(NumInf)), Distance
            PCOPY 0, 1
            NumInf = NumInf + 1
            IF NumInf = 11 THEN EXIT SUB
        END IF
        
    LOOP





GetKey:
    DO
        DO
            A$ = INKEY$
        LOOP UNTIL A$ <> ""
        A$ = UCASE$(A$)
        Bad = False
        SELECT CASE A$
        CASE LeftArrow$
            Xloc = Xloc - 5
            IF Xloc < 0 THEN Xloc = 319
        CASE RightArrow$
            Xloc = Xloc + 5
            IF Xloc > 319 THEN Xloc = 0
        CASE DownArrow$
            Yloc = Yloc + 5
            IF Yloc > 199 THEN Yloc = 0
        CASE UpArrow$
            Yloc = Yloc - 5
            IF Yloc < 0 THEN Yloc = 199
        CASE " ", "U", "D", "L", "R", Enter$, Escape$
        CASE ELSE
            Alert
            Bad = True
        END SELECT
    LOOP WHILE Bad
RETURN
END SUB

SUB Mcenter (LineNumber, Message$)
    LOCATE LineNumber, INT((80 - LEN(Message$)) / 2)
    PRINT Message$;
END SUB

SUB Menu
    DO
        SetUpScreen
        Mcenter 3, "Main Menu"
        Mcenter 25, "Please select an option, or press ESC to quit."
        COLOR 15
        Yloc = 10
        Mcenter Yloc, "1. Adjust Parameters"
        Mcenter Yloc + 2, "2. Select Influences"
        Mcenter Yloc + 4, "3. Calculate and Plot Screen(s)"
        DO
            DO
                A$ = INKEY$
            LOOP UNTIL A$ <> ""
            SELECT CASE A$
            CASE "1"
                Parameters
                EXIT DO
            CASE "2"
                Influences
                EXIT DO
            CASE "3"
                Calculate
                EXIT DO
            CASE Escape$
                EXIT SUB
            CASE ELSE
                Alert
            END SELECT
        LOOP
    LOOP


END SUB

SUB Parameters STATIC
    DIM StartTime AS SINGLE
    SetUpScreen
    Mcenter 3, "Parameter Adjust Menu"
    Mcenter 23, "Use Arrow Keys and Space Bar to Change Choices"
    Mcenter 24, "Press D for the Default Choices"
    Mcenter 25, "Press ESC to Return to the Main Menu"
    Xloc = 8
    Yloc = 6
    FOR A = 1 TO NumOpts
        LOCATE Yloc + (A - 1) * 2, Xloc
        PRINT Options$(A);
        PRINT STRING$(50 - POS(0), "."); "["; SPACE$(17); "]"
    NEXT
    COLOR 15
    IF FirstTime = 0 THEN
        CurrentChoice = 1
        FirstTime = 1
    END IF
    DO
        GOSUB UpdateChoices
        CurrentLine = Yloc + (CurrentChoice - 1) * 2
        DO
            LOCATE CurrentLine, 51 + ((17 - LEN(Choices$(CurrentChoice, Choice(CurrentChoice)))) / 2)
            PRINT Choices$(CurrentChoice, Choice(CurrentChoice));
           
            GOSUB ShortPause
            IF A$ = "" THEN
                LOCATE CurrentLine, 51
                PRINT SPACE$(17)
                GOSUB ShortPause
            END IF
        LOOP UNTIL A$ <> ""
        A$ = UCASE$(A$)
        SELECT CASE A$
        CASE "D"
            DefaultChoices
        CASE Escape$, Enter$
            EXIT SUB
        CASE UpArrow$
            CurrentChoice = CurrentChoice - 1
            IF CurrentChoice < 1 THEN CurrentChoice = NumOpts
        CASE DownArrow$
            CurrentChoice = CurrentChoice + 1
            IF CurrentChoice > NumOpts THEN CurrentChoice = 1
        CASE " "
            Choice(CurrentChoice) = Choice(CurrentChoice) + 1
            IF Choice(CurrentChoice) > NumChoices(CurrentChoice) THEN
                Choice(CurrentChoice) = 1
            END IF
            IF CurrentChoice = 5 AND Choice(5) = 4 AND Choice(4) = 2 THEN
                Choice(2) = 1
            END IF
            IF CurrentChoice = 4 THEN
                NumInf = 0
            END IF
        CASE ELSE
            Alert
        END SELECT
        IF NOT Screen12 THEN
            IF Choice(4) = 2 THEN
                Choice(4) = 1
            END IF
        END IF
        IF Choice(4) = 1 AND Choice(5) = 4 THEN
            Choice(5) = 1
        END IF

    LOOP



    END
        
UpdateChoices:
    FOR A = 1 TO NumOpts
        LOCATE Yloc + (A - 1) * 2, 51: PRINT SPACE$(17);
        LOCATE Yloc + (A - 1) * 2, 51 + ((17 - LEN(Choices$(A, Choice(A)))) / 2)
        PRINT Choices$(A, Choice(A));
    NEXT
RETURN
ShortPause:
    StartTime = TIMER
    DO
        A$ = INKEY$
    LOOP UNTIL TIMER - StartTime > .2 OR A$ <> ""
RETURN
END SUB

SUB Plot
    IF Choice(4) = 1 THEN
        Plot9
    ELSE
        Plot12
    END IF

END SUB

SUB Plot12
    SetUpScreen
    SCREEN 12, , 0, 0
    IF Choice(5) = 4 THEN
        C1 = 0: Direction = 1
        FOR A = 0 TO 15
            PALETTE A, A * 4.2
        NEXT
    END IF
    FOR B = 0 TO Mb - 1
        FOR A = 0 TO Ma - 2
            LINE (Points12x(A, B), Points12y(A, B))-(Points12x(A + 1, B), Points12y(A + 1, B)), 14
        NEXT
    NEXT
    FOR A = 0 TO Ma - 1
        FOR B = 0 TO Mb - 2
            LINE (Points12x(A, B), Points12y(A, B))-(Points12x(A, B + 1), Points12y(A, B + 1)), 14
        NEXT
    NEXT
    C = 0
    IF Choice(5) <> 1 THEN
        FOR A = 0 TO Ma - 2
            FOR B = 0 TO Mb - 2
                IF Choice(5) = 4 THEN
                    Xc = INT(.5 + (Points12x(A, B) + Points12x(A + 1, B) + Points12x(A + 1, B + 1) + Points12x(A, B + 1)) / 4)
                    Yc = INT(.5 + (Points12y(A, B) + Points12y(A + 1, B) + Points12y(A + 1, B + 1) + Points12y(A, B + 1)) / 4)
                    IF Xc < 0 THEN Xc = 0 ELSE IF Xc > 639 THEN Xc = 630
                    IF Yc < 0 THEN Yc = 0 ELSE IF Yc > 479 THEN Yc = 479
                    PAINT (Xc, Yc), C1, 14
                    C1 = C1 + Direction: IF C1 < 0 OR C1 > 15 THEN Direction = -Direction: C1 = C1 + Direction
                END IF
                IF Choice(5) = 2 AND C THEN
                    Xc = INT(.5 + (Points12x(A, B) + Points12x(A + 1, B) + Points12x(A + 1, B + 1) + Points12x(A, B + 1)) / 4)
                    Yc = INT(.5 + (Points12y(A, B) + Points12y(A + 1, B) + Points12y(A + 1, B + 1) + Points12y(A, B + 1)) / 4)
                    IF Xc < 0 THEN Xc = 0 ELSE IF Xc > 639 THEN Xc = 630
                    IF Yc < 0 THEN Yc = 0 ELSE IF Yc > 479 THEN Yc = 479
                    PAINT (Xc, Yc), 14, 14
                END IF
                IF Choice(5) = 3 AND C THEN
                    Fdx = Points12x(A + 1, B) - Points12x(A, B)
                    Fdy = Points12y(A + 1, B) - Points12y(A, B)
                    Sdx = Points12x(A + 1, B + 1) - Points12x(A, B + 1)
                    Sdy = Points12y(A + 1, B + 1) - Points12y(A, B + 1)
                    P = SQR(CLNG(Fdx) * CLNG(Fdx) + CLNG(Fdy) * CLNG(Fdy))
                    P1 = SQR(CLNG(Sdx) * CLNG(Sdx) + CLNG(Sdy) * CLNG(Sdy))
                    IF P1 > P THEN P = P1
                    IF P <> 0 THEN
                        FOR Al! = 0 TO 1 STEP 1 / P
                            Xs = Points12x(A, B) + Fdx * Al!
                            Ys = Points12y(A, B) + Fdy * Al!
                            Xe = Points12x(A, B + 1) + Sdx * Al!
                            Ye = Points12y(A, B + 1) + Sdy * Al!
                            Xd = Xe - Xs
                            Yd = Ye - Ys
                            Da = SQR(Xd * Xd + Yd * Yd)
                            IF Da <> 0 THEN
                                FOR Al1! = 0 TO 1 STEP 1 / Da
                                    LINE (Xs + Xd * Al1!, Ys + Yd * Al1!)-STEP(1, 1), 14, BF
                                NEXT
                            END IF
                        NEXT
                    END IF
                END IF
                C = NOT C
            NEXT
        NEXT
    END IF
    IF Choice(5) = 4 THEN
        C1 = 0: Direction = 1
        FOR A = 0 TO Ma - 2
            FOR B = 0 TO Mb - 2
                LINE (Points12x(A, B), Points12y(A, B))-(Points12x(A + 1, B), Points12y(A + 1, B)), C1
                LINE -(Points12x(A + 1, B + 1), Points12y(A + 1, B + 1)), C1
                LINE -(Points12x(A, B + 1), Points12y(A, B + 1)), C1
                LINE -(Points12x(A, B), Points12y(A, B)), C1
                C1 = C1 + Direction: IF C1 < 0 OR C1 > 15 THEN Direction = -Direction: C1 = C1 + Direction
            NEXT
        NEXT
    END IF
   
    DO
        A$ = INKEY$
    LOOP UNTIL A$ <> ""



END SUB

SUB Plot9
    SHARED TimeDelay
    SetUpScreen
    Alert
    Mcenter 3, "Animated Viewing Instructions"
    Mcenter 25, "Press any key to continue..."
    COLOR 15
    Mcenter 10, "While Viewing, Use the Following Keys:"
    Mcenter 12, "Left Arrow - Slow Down Display"
    Mcenter 14, "Right Arrow - Speed Up Display"
    Mcenter 16, "ESC - Quit To Main Menu At Any Time"
    A$ = INPUT$(1)
    FOR Sc = 0 TO 7
        SCREEN 7, , Sc, Sc
        FOR B = 0 TO Mb - 1
            FOR A = 0 TO Ma - 2
                LINE (Points9x(Sc, A, B), Points9y(Sc, A, B))-(Points9x(Sc, A + 1, B), Points9y(Sc, A + 1, B)), 14
            NEXT
        NEXT
        FOR A = 0 TO Ma - 1
            FOR B = 0 TO Mb - 2
                LINE (Points9x(Sc, A, B), Points9y(Sc, A, B))-(Points9x(Sc, A, B + 1), Points9y(Sc, A, B + 1)), 14
            NEXT
        NEXT
        C = 0
        IF Choice(5) = 2 OR Choice(5) = 3 THEN
            FOR A = 0 TO Ma - 2
                FOR B = 0 TO Mb - 2
                    IF Choice(5) = 2 AND C THEN
                        Xc = INT(.5 + (Points9x(Sc, A, B) + Points9x(Sc, A + 1, B) + Points9x(Sc, A + 1, B + 1) + Points9x(Sc, A, B + 1)) / 4)
                        Yc = INT(.5 + (Points9y(Sc, A, B) + Points9y(Sc, A + 1, B) + Points9y(Sc, A + 1, B + 1) + Points9y(Sc, A, B + 1)) / 4)
                        IF Xc < 0 THEN Xc = 0 ELSE IF Xc > 319 THEN Xc = 319
                        IF Yc < 0 THEN Yc = 0 ELSE IF Yc > 199 THEN Yc = 199
                        PAINT (Xc, Yc), 14, 14
                    END IF
                    IF Choice(5) = 3 AND C THEN
                        Fdx = Points9x(Sc, A + 1, B) - Points9x(Sc, A, B)
                        Fdy = Points9y(Sc, A + 1, B) - Points9y(Sc, A, B)
                        Sdx = Points9x(Sc, A + 1, B + 1) - Points9x(Sc, A, B + 1)
                        Sdy = Points9y(Sc, A + 1, B + 1) - Points9y(Sc, A, B + 1)
                        P = SQR(CLNG(Fdx) * CLNG(Fdx) + CLNG(Fdy) * CLNG(Fdy))
                        P1 = SQR(CLNG(Sdx) * CLNG(Sdx) + CLNG(Sdy) * CLNG(Sdy))
                        IF P1 > P THEN P = P1
                        IF P <> 0 THEN
                            FOR Al! = 0 TO 1 STEP 1 / P
                                Xs = Points9x(Sc, A, B) + Fdx * Al!
                                Ys = Points9y(Sc, A, B) + Fdy * Al!
                                Xe = Points9x(Sc, A, B + 1) + Sdx * Al!
                                Ye = Points9y(Sc, A, B + 1) + Sdy * Al!
                                Xd = Xe - Xs
                                Yd = Ye - Ys
                                Da = SQR(Xd * Xd + Yd * Yd)
                                IF Da <> 0 THEN
                                    FOR Al1! = 0 TO 1 STEP 1 / Da
                                        LINE (Xs + Xd * Al1!, Ys + Yd * Al1!)-STEP(1, 1), 14, BF
                                    NEXT
                                END IF
                            NEXT
                        END IF
                    END IF
                    C = NOT C
                    A$ = INKEY$
                    IF A$ = Escape$ THEN EXIT SUB
                NEXT
            NEXT
        END IF
    NEXT
    Sc = 0
    DO
        SCREEN 7, , Sc, Sc: Sc = (Sc + 1) MOD 8
        FOR A = 1 TO TimeDelay
        NEXT
        A$ = INKEY$
        IF A$ <> "" THEN
            SELECT CASE A$
            CASE LeftArrow$
                TimeDelay = TimeDelay - 100
            CASE RightArrow$
                TimeDelay = TimeDelay + 100
            CASE Escape$
                EXIT SUB
            CASE ELSE
            END SELECT
        END IF
    LOOP
    Plot



END SUB

SUB SetUpScreen
    SCREEN 0
    WIDTH 80, 25
    CLS
    COLOR 14
    Mcenter 1, "Warp Field Animator"
    Mcenter 2, "By Rich Geldreich"
END SUB

SUB TestScreens
    SHARED BadScreen
    ON ERROR GOTO BadScreenMode
    BadScreen = False
    Screen9 = True
    FOR A = 0 TO 7
        SCREEN 9, , A, 0
        IF BadScreen THEN
            Screen9 = False
        END IF
    NEXT
    BadScreen = False
    Screen12 = True
    SCREEN 12, , 0, 0
    IF BadScreen THEN
        Screen12 = False
    END IF
    ON ERROR GOTO 0
END SUB

SUB TitleScreen
    SCREEN 0
    WIDTH 80, 25
    COLOR 14
    CLS
    Mcenter 11, "Warp Field Animator"
    Mcenter 12, "Version 1.0"
    Mcenter 13, "By Rich Geldreich December 3, 1991"
    Mcenter 14, "Another One of Zeek's Creations!"
    Mcenter 25, "Press any key to continue..."
    A$ = INPUT$(1)
END SUB

