'****************************************************************************
'*
'*      'SVGAPB' A Super VGA Graphics Librarys for use with 
'*      Power Basic Inc's Power BASIC 3.00c and later
'*      Copyright 1993-1996 by Stephen L. Balkum and Daniel A. Sill
'*
'*      Power BASIC is a registered trademark of Power BASIC Inc.
'*
'*    **************** UNREGISTERED SHAREWARE VERSION **********************
'*    * FOR EVALUATION ONLY. NOT FOR RESALE IN ANY FORM. SOFTWARE WRITTEN  *
'*    * USING THIS UNREGISTERED SHAREWARE GRAPHICS LIBRARY MAY NOT BY SOLD *
'*    * OR USED FOR ANY PURPOSE OTHER THAN THE EVALUATION OF THIS LIBRARY. *
'*    **********************************************************************
'*
'*    **************** NO WARRANTIES AND NO LIABILITY **********************
'*    * Stephen L. Balkum and Daniel A. Sill provide no warranties, either *
'*    * expressed or implied, of merchant ability, or fitness, for a       *
'*    * particular use or purpose of this SOFTWARE and documentation.      *
'*    * In no event shall Stephen L. Balkum or Daniel A. Sill be held      *
'*    * liable for any damages resulting from the use or misuse of the     *
'*    * SOFTWARE and documentation.                                        *
'*    **********************************************************************
'*
'*    ************** U.S. GOVERNMENT RESTRICTED RIGHTS *********************
'*    * Use, duplication, or disclosure of the SOFTWARE and documentation  *
'*    * by the U.S. Government is subject to the restrictions as set forth *
'*    * in subparagraph (c)(1)(ii) of the Rights in Technical Data and     *
'*    * Computer Software clause at DFARS 252.227-7013.                    *
'*    * Contractor/manufacturer is Stephen L. Balkum and Daniel A. Sill,   *
'*    * P.O. Box 7704, Austin, Texas 78713-7704                            *
'*    **********************************************************************
'*
'*    **********************************************************************
'*    * By using this SOFTWARE or documentation, you agree to the above    *
'*    * terms and conditions.                                              *
'*    **********************************************************************
'*
'****************************************************************************


    $INCLUDE "SVGAPB.BI"
    $INCLUDE "SVGADEMO.BI"

    DEFINT A-Z
    
    
    SUB DO2D (RET$)
    
    DIM POINTARRY(0 TO 8) AS P2DType

    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 11: 2D functions"
    PALSET PAL(0), 0, 255

    '*************************************************************************
    '* SET UP THE 'STAR' PATTERN OF POINTS
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    CNTX = GETMAXX \ 2
    CNTY = ((GETMAXY - 32) \ 2) + 32
    SPCNG = GETMAXX \ 30
    POINTARRY(0).X = 0
    POINTARRY(0).Y = -SPCNG * 6
    POINTARRY(1).X = SPCNG * 2
    POINTARRY(1).Y = -SPCNG * 2
    POINTARRY(2).X = SPCNG * 6
    POINTARRY(2).Y = 0
    POINTARRY(3).X = SPCNG * 2
    POINTARRY(3).Y = SPCNG * 2
    POINTARRY(4).X = 0
    POINTARRY(4).Y = SPCNG * 6
    POINTARRY(5).X = -SPCNG * 2
    POINTARRY(5).Y = SPCNG * 2
    POINTARRY(6).X = -SPCNG * 6
    POINTARRY(6).Y = 0
    POINTARRY(7).X = -SPCNG * 2
    POINTARRY(7).Y = -SPCNG * 2
    POINTARRY(8).X = 0
    POINTARRY(8).Y = -SPCNG * 6

    '*************************************************************************
    '* SHOW D2TRANSLATE
    '*************************************************************************
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "D2TRANSLATE (Points,XTrans,YTrans,InAry,OutAry)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    D2TRANSLATE 9, CNTX, CNTY, POINTARRY(0).X, PLOTARRY(0).X
    SHOWSTAR
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    XTRANS = 0
    YTRANS = 0
    FOR J = 0 TO SPCNG * 2
        XTRANS = XTRANS + 2
        YTRANS = YTRANS + 2
        D2TRANSLATE 9, CNTX + XTRANS, CNTY + YTRANS, POINTARRY(0).X, PLOTARRY(0).X
        SHOWSTAR
        SDELAY 2
    NEXT J
    FOR J = 0 TO SPCNG * 2
        XTRANS = XTRANS - 2
        YTRANS = YTRANS - 2
        D2TRANSLATE 9, CNTX + XTRANS, CNTY + YTRANS, POINTARRY(0).X, PLOTARRY(0).X
        SHOWSTAR
        SDELAY 2
    NEXT J
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW D2SCALE
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, 31
    FILLVIEW 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "D2SCALE (Points,XScale,YScale,InAry,OutAry)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    D2TRANSLATE 9, CNTX, CNTY, POINTARRY(0).X, PLOTARRY(0).X
    SHOWSTAR
    FOR J = 256 TO 380 STEP 4
        D2SCALE 9, J, J, POINTARRY(0).X, PLOTARRY(0).X
        D2TRANSLATE 9, CNTX, CNTY, PLOTARRY(0).X, PLOTARRY(0).X
        SHOWSTAR
        SDELAY 2
        NEXT J
    X = J
    FOR J = X TO 256 STEP -4
        D2SCALE 9, J, J, POINTARRY(0).X, PLOTARRY(0).X
        D2TRANSLATE 9, CNTX, CNTY, PLOTARRY(0).X, PLOTARRY(0).X
        SHOWSTAR
        SDELAY 2
    NEXT J
    X = J
    FOR J = X TO 128 STEP -4
        D2SCALE 9, J, J, POINTARRY(0).X, PLOTARRY(0).X
        D2TRANSLATE 9, CNTX, CNTY, PLOTARRY(0).X, PLOTARRY(0).X
        SHOWSTAR
        SDELAY 2
    NEXT J
    X = J
    FOR J = X TO 256 STEP 4
        D2SCALE 9, J, J, POINTARRY(0).X, PLOTARRY(0).X
        D2TRANSLATE 9, CNTX, CNTY, PLOTARRY(0).X, PLOTARRY(0).X
        SHOWSTAR
        SDELAY 2
    NEXT J
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW D2ROTATE (ABOUT THE CENTER OF THE OBJECT)
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, 31
    FILLVIEW 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "D2ROTATE (Points,XOrigin,YOrigin,Angle,InAry,OutAry)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    A$ = "Lets do it about the center of the object."
    DRWSTRING 1, 7, 0, A$, 10, 32
    SETVIEW 0, 32, GETMAXX, GETMAXY
    D2TRANSLATE 9, CNTX, CNTY, POINTARRY(0).X, PLOTARRY(0).X
    SHOWSTAR
    FOR J = 0 TO 180
        D2ROTATE 9, 0, 0, J, POINTARRY(0).X, PLOTARRY(0).X
        D2TRANSLATE 9, CNTX, CNTY, PLOTARRY(0).X, PLOTARRY(0).X
        SHOWSTAR
        SDELAY 2
    NEXT J
    FOR J = 180 TO 0 STEP -2
        D2ROTATE 9, 0, 0, J, POINTARRY(0).X, PLOTARRY(0).X
        D2TRANSLATE 9, CNTX, CNTY, PLOTARRY(0).X, PLOTARRY(0).X
        SHOWSTAR
        SDELAY 2
    NEXT J
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW D2ROTATE (ABOUT AN ARBITRARY POINT)
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, 48
    FILLVIEW 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "D2ROTATE (Points,XOrigin,YOrigin,Angle,InAry,OutAry)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    A$ = "Lets do it about an arbitrary point."
    DRWSTRING 1, 7, 0, A$, 10, 32
    SETVIEW 0, 32, GETMAXX, GETMAXY
    D2TRANSLATE 9, CNTX, CNTY, POINTARRY(0).X, PLOTARRY(0).X
    SHOWSTAR
    FOR J = 0 TO 360 STEP 2
        D2ROTATE 9, 0, SPCNG * 6, J, POINTARRY(0).X, PLOTARRY(0).X
        D2TRANSLATE 9, CNTX, CNTY, PLOTARRY(0).X, PLOTARRY(0).X
        SHOWSTAR
        SDELAY 2
    NEXT J
    SETVIEW 0, 0, GETMAXX, GETMAXY
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        EXIT SUB
    END IF
    END SUB
    
    
    SUB DO3D (RET$)
    
    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 12: 3D functions"
    PALSET PAL(0), 0, 255

    '*************************************************************************
    '* SET UP THE 'HOUSE' PATTERN OF POINTS
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    CNTX = GETMAXX \ 2
    CNTY = ((GETMAXY - 32) \ 2) + 32
    CNTZ = 0
    SPCNG = GETMAXX \ 6
    POINTARRY3D(0).X = -SPCNG
    POINTARRY3D(0).Y = -SPCNG * 2
    POINTARRY3D(0).Z = 0
    POINTARRY3D(1).X = SPCNG
    POINTARRY3D(1).Y = -SPCNG * 2
    POINTARRY3D(1).Z = 0
    POINTARRY3D(2).X = SPCNG
    POINTARRY3D(2).Y = -SPCNG * 2
    POINTARRY3D(2).Z = SPCNG * 2
    POINTARRY3D(3).X = -SPCNG
    POINTARRY3D(3).Y = -SPCNG * 2
    POINTARRY3D(3).Z = SPCNG * 2
    POINTARRY3D(4).X = -SPCNG
    POINTARRY3D(4).Y = SPCNG * 2
    POINTARRY3D(4).Z = 0
    POINTARRY3D(5).X = SPCNG
    POINTARRY3D(5).Y = SPCNG * 2
    POINTARRY3D(5).Z = 0
    POINTARRY3D(6).X = SPCNG
    POINTARRY3D(6).Y = SPCNG * 2
    POINTARRY3D(6).Z = SPCNG * 2
    POINTARRY3D(7).X = -SPCNG
    POINTARRY3D(7).Y = SPCNG * 2
    POINTARRY3D(7).Z = SPCNG * 2
    POINTARRY3D(8).X = 0
    POINTARRY3D(8).Y = -SPCNG * 2
    POINTARRY3D(8).Z = SPCNG * 3
    POINTARRY3D(9).X = 0
    POINTARRY3D(9).Y = SPCNG * 2
    POINTARRY3D(9).Z = SPCNG * 3
    POINTARRY3D(10).X = 0
    POINTARRY3D(10).Z = 0
    POINTARRY3D(10).Y = 0
    POINTARRY3D(11).X = SPCNG * 4
    POINTARRY3D(11).Z = 0
    POINTARRY3D(11).Y = 0
    POINTARRY3D(12).X = 0
    POINTARRY3D(12).Z = 0
    POINTARRY3D(12).Y = SPCNG * 4
    POINTARRY3D(13).X = 0
    POINTARRY3D(13).Z = SPCNG * 4
    POINTARRY3D(13).Y = 0

    '*************************************************************************
    '* SHOW D3PROJECT
    '*************************************************************************
    PI! = 4 * ATN(1) / 180
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "D3PROJECT (Points,ProjParams,InAry,OutAry)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    HEIGHT = GETMAXY * 8
    Radius = GETMAXX * 30
    J = 110
    PROJ.EYEX = FIX(-Radius * COS(J * PI!))
    PROJ.EYEY = FIX(-Radius * SIN(J * PI!))
    PROJ.EYEZ = HEIGHT
    PROJ.SCRD = ((Radius ^ 2 + HEIGHT ^ 2) ^ .5) \ 2
    PROJ.THETA = J
    PROJ.PHI = CINT(ATN(HEIGHT / -Radius) / PI!)
    BYTECOPY POINTARRY3D(0).X, PLAYARRY(0).X, 84
    R = D3PROJECT(14, PROJ.EYEX, PLAYARRY(0).X, PLOTARRY(0).X)
    BYTECOPY PLOTARRY(0).X, OPLOTARRY(0).X, 56
    SHOWHOUSE
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    FOR J = 112 TO 470 STEP 3
        PROJ.EYEX = FIX(-Radius * COS(J * PI!))
        PROJ.EYEY = FIX(-Radius * SIN(J * PI!))
        PROJ.THETA = J
        R = D3PROJECT(14, PROJ.EYEX, PLAYARRY(0).X, PLOTARRY(0).X)
        SHOWHOUSE
        SDELAY 2
    NEXT J
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW D3TRANSLATE
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, 31
    FILLVIEW 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "D3TRANSLATE (Points,XTrans,YTrans,ZTrans,InAry,OutAry)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    FOR J = 2 TO 300 STEP 6
        D3TRANSLATE 10, J, J, 0, POINTARRY3D(0).X, PLAYARRY(0).X
        R = D3PROJECT(10, PROJ.EYEX, PLAYARRY(0).X, PLOTARRY(0).X)
        SHOWHOUSE
        SDELAY 2
    NEXT J
    X = J
    FOR J = X TO 2 STEP -6
        D3TRANSLATE 10, J, J, 0, POINTARRY3D(0).X, PLAYARRY(0).X
        R = D3PROJECT(10, PROJ.EYEX, PLAYARRY(0).X, PLOTARRY(0).X)
        SHOWHOUSE
        SDELAY 2
    NEXT J
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW D3SCALE
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, 31
    FILLVIEW 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "D3SCALE (Points,XScale,YScale,ZScale,InAry,OutAry)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    FOR J = 256 TO 380 STEP 4
        D3SCALE 10, J, J, J, POINTARRY3D(0).X, PLAYARRY(0).X
        R = D3PROJECT(10, PROJ.EYEX, PLAYARRY(0).X, PLOTARRY(0).X)
        SHOWHOUSE
        SDELAY 2
        NEXT J
    X = J
    FOR J = X TO 256 STEP -4
        D3SCALE 10, J, J, J, POINTARRY3D(0).X, PLAYARRY(0).X
        R = D3PROJECT(10, PROJ.EYEX, PLAYARRY(0).X, PLOTARRY(0).X)
        SHOWHOUSE
        SDELAY 2
    NEXT J
    X = J
    FOR J = X TO 128 STEP -4
        D3SCALE 10, J, J, J, POINTARRY3D(0).X, PLAYARRY(0).X
        R = D3PROJECT(10, PROJ.EYEX, PLAYARRY(0).X, PLOTARRY(0).X)
        SHOWHOUSE
        SDELAY 2
    NEXT J
    X = J
    FOR J = X TO 256 STEP 4
        D3SCALE 10, J, J, J, POINTARRY3D(0).X, PLAYARRY(0).X
        R = D3PROJECT(10, PROJ.EYEX, PLAYARRY(0).X, PLOTARRY(0).X)
        SHOWHOUSE
        SDELAY 2
    NEXT J
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW D2ROTATE (ABOUT THE ORIGIN)
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, 31
    FILLVIEW 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "D3ROTATE (Points,XOrigin,YOrigin,ZOrigin,ZAngle,YAngle,XAngle,InAry,OutAry) "
    DRWSTRING 1, 7, 0, A$, 10, 16
    A$ = "Lets do it about the origin."
    DRWSTRING 1, 7, 0, A$, 10, 32
    SETVIEW 0, 32, GETMAXX, GETMAXY
    FOR J = 0 TO 360 STEP 3
        D3ROTATE 10, 0, 0, 0, 0, J, J, POINTARRY3D(0).X, PLAYARRY(0).X
        R = D3PROJECT(10, PROJ.EYEX, PLAYARRY(0).X, PLOTARRY(0).X)
        SHOWHOUSE
        SDELAY 2
    NEXT J
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    END SUB

    
    SUB DOPCX (RET$)
    
    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 8: PCX functions"

    '*************************************************************************
    '* SHOW PCX GET INFO
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0

LP:
    A$ = "Please provide the name and full path (if not in the current drive/directory)"
    B$ = "of a PCX file you would like to see..."
    C$ = "Filename:"
    DRWSTRING 1, 7, 0, A$, 10, 64
    DRWSTRING 1, 7, 0, B$, 10, 80
    DRWSTRING 1, 7, 0, C$, 10, 96
    FILENAME$ = "_"
    LENGTH = 0
    EXT = 0
    WHILE EXT = 0
        DRWSTRING 1, 15, 0, FILENAME$, 82, 96
        A$ = ""
        WHILE LEN(A$) < 1 OR LEN(A$) > 1
            A$ = INKEY$
        WEND
        A = ASC(A$)
        IF A > 31 AND A < 128 THEN
            FILENAME$ = LEFT$(FILENAME$, LENGTH) + A$ + "_"
            LENGTH = LENGTH + 1
        ELSE
            IF A = 8 AND LENGTH > 0 THEN
                DRWSTRING 1, 15, 0, STRING$(LENGTH + 1, 32), 82, 96
                LENGTH = LENGTH - 1
                FILENAME$ = LEFT$(FILENAME$, LENGTH) + "_"
            ELSEIF A = 13 THEN
                EXT = 1
            END IF
        END IF
    WEND
    FILENAME$ = LEFT$(FILENAME$, LENGTH)
    IF LEN(FILENAME$) < 1 THEN
        EXIT SUB '* OOPS! NO NAME GIVEN SO LET'S JUST BAIL OUT!
    END IF
    SHOWPCX RET$, FILENAME$
    IF RET$ = "S" OR RET$ = "Q" THEN
        FILLSCREEN 0
        EXIT SUB
    END IF
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "Would you like to see another (Y/N) ?"
    DRWSTRING 1, 7, 0, A$, 10, 64
    EXT = 0
    SOUND 700, .75
    WHILE EXT = 0
        A$ = ""
        WHILE A$ = ""
            A$ = INKEY$
        WEND
        IF A$ = "Y" OR A$ = "y" THEN
            GOTO LP
        ELSEIF A$ = "N" OR A$ = "n" THEN
            EXT = 1
        ELSE
            SOUND 100, 5
        END IF
    WEND
    FILLSCREEN 0
    END SUB

    
    SUB DOJOYSTICK (RET$)
    
    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 10: Joystick functions"
    PALSET PAL(0), 0, 255
    FILLSCREEN 0
    SETVIEW 0, 0, GETMAXX, GETMAXY

    '*************************************************************************
    '* CHECK TO SEE IF WE HAVE A JOYSTICK SO WE CAN DO THE JOYSTICK DEMO
    '*************************************************************************
    JOYSTICK = WHICHJOYSTICK
    IF JOYSTICK < 1 THEN
        SOUND 100, 5
        DRWSTRING 1, 7, 0, TITLE$, 10, 0
        A$ = "Sorry, No Joystick Detected...Can Not Do The Joystick Demo."
        DRWSTRING 1, 7, 0, A$, 10, 16
        WHILE INKEY$ = ""
        WEND
        FILLSCREEN 0
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW JOYSTICKINFO (HERE WE DO SOME JOYSTICK CALIBRATION)
    '*************************************************************************
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "JOYSTICKINFO (JAX,JAY,JAButs,JBX,JBY,JBButs)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 0, GETMAXX, GETMAXY
    SELECT CASE JOYSTICK
        CASE = 1
            A$ = "Please Move Joystick A As Far As It Will Go In All Directions"
        CASE = 2
            A$ = "Please Move Joystick B As Far As It Will Go In All Directions"
        CASE = 3
            A$ = "Please Move Both Joystick A And B As Far As They Will Go In All Directions"
    END SELECT
    DRWSTRING 1, 7, 0, A$, 10, 32
    A$ = "And Then Press A Key..."
    DRWSTRING 1, 7, 0, A$, 10, 48
    SOUND 700, .75
    GETMAXXA = -1
    MAXYA = -1
    MINXA = 10000
    MINYA = 10000
    GETMAXXB = -1
    MAXYB = -1
    MINXB = 10000
    MINYB = 10000
    A$ = ""
    WHILE A$ = ""
        JOYSTICKINFO JAX, JAY, JAButs, JBX, JBY, JBButs
        IF JAX > GETMAXXA THEN
            GETMAXXA = JAX
        END IF
        IF JAX < MINXA THEN
            MINXA = JAX
        END IF
        IF JAY > MAXYA THEN
            MAXYA = JAY
        END IF
        IF JAY < MINYA THEN
            MINYA = JAY
        END IF
        IF JBX > GETMAXXB THEN
            GETMAXXB = JBX
        END IF
        IF JBX < MINXB THEN
            MINXB = JBX
        END IF
        IF JBY > MAXYB THEN
            MAXYB = JBY
        END IF
        IF JBY < MINYB THEN
            MINYB = JBY
        END IF
        A$ = INKEY$
    WEND

    '*************************************************************************
    '* CALCULATE THE CENTER AND STUFF...
    '*************************************************************************
    SPCNG = GETMAXX \ 7
    DIST = SPCNG * 2
    X1 = SPCNG \ 2
    Y1 = SPCNG \ 2 + 32
    X2 = X1 + DIST
    Y2 = Y1 + DIST
    X4 = GETMAXX - SPCNG
    Y4 = Y2
    X3 = X4 - DIST
    Y3 = Y1
    CNTAX = (X2 - X1) / 2 + X1
    CNTAY = (Y2 - Y1) / 2 + Y1
    CNTBX = (X4 - X3) / 2 + X3
    CNTBY = (Y4 - Y3) / 2 + Y3
    RANGEXA = GETMAXXA - MINXA
    RANGEYA = MAXYA - MINYA
    RANGEXB = GETMAXXB - MINXB
    RANGEYB = MAXYB - MINYB
    JABAX = (X2 - X1) \ 4 + X1 - 16
    JABAY = (SPCNG \ 4) + Y2 - 6
    JABBX = X2 - (X2 - X1) \ 4 - 16
    JABBY = (SPCNG \ 4) + Y2 - 6
    JBBAX = (X4 - X3) \ 4 + X3 - 16
    JBBAY = (SPCNG \ 4) + Y4 - 6
    JBBBX = X4 - (X4 - X3) \ 4 - 16
    JBBBY = (SPCNG \ 4) + Y4 - 6

    '*************************************************************************
    '* LETS MOVE IT (OR THEM) AROUND
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, 64
    FILLVIEW 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    IF (JOYSTICK AND 1) = 1 THEN
        DRWBOX 1, 15, X1 - 1, Y1 - 1, X2 + 1, Y2 + 1
        DRWBOX 1, 15, X1 - 1, Y2 + 1, X2 + 1, Y2 + SPCNG \ 2
        DRWLINE 1, 15, (X2 - X1) \ 2 + X1, Y2 + 1, (X2 - X1) \ 2 + X1, Y2 + SPCNG \ 2
        OAX = CNTAX
        OAY = CNTAY
        DRWLINE 1, 10, CNTAX, CNTAY, OAX, OAY
    ELSE
        DRWBOX 1, 8, X1 - 1, Y1 - 1, X2 + 1, Y2 + 1
        DRWBOX 1, 8, X1 - 1, Y2 + 1, X2 + 1, Y2 + SPCNG \ 2
        DRWLINE 1, 8, (X2 - X1) \ 2 + X1, Y2 + 1, (X2 - X1) \ 2 + X1, Y2 + SPCNG \ 2
    END IF
    IF (JOYSTICK AND 2) = 2 THEN
        DRWBOX 1, 15, X3 - 1, Y3 - 1, X4 + 1, Y4 + 1
        DRWBOX 1, 15, X3 - 1, Y4 + 1, X4 + 1, Y4 + SPCNG \ 2
        DRWLINE 1, 15, (X4 - X3) \ 2 + X3, Y4 + 1, (X4 - X3) \ 2 + X3, Y4 + SPCNG \ 2
        OBX = CNTBX
        OBY = CNTBY
        DRWLINE 1, 10, CNTBX, CNTBY, OBX, OBY
    ELSE
        DRWBOX 1, 8, X3 - 1, Y3 - 1, X4 + 1, Y4 + 1
        DRWBOX 1, 8, X3 - 1, Y4 + 1, X4 + 1, Y4 + SPCNG \ 2
        DRWLINE 1, 8, (X4 - X3) \ 2 + X3, Y4 + 1, (X4 - X3) \ 2 + X3, Y4 + SPCNG \ 2
    END IF
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "JOYSTICKINFO (JAX,JAY,JAButs,JBX,JBY,JBButs)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    A$ = ""
    WHILE A$ = ""
        JOYSTICKINFO JAX, JAY, JAButs, JBX, JBY, JBButs
        IF (JOYSTICK AND 1) = 1 THEN
            SETVIEW X1, Y1, X2, Y2
            JAX = JAX - MINXA
            JAX = JAX / RANGEXA * DIST + X1
            JAY = JAY - MINYA
            JAY = JAY / RANGEYA * DIST + Y1
            DRWLINE 1, 0, CNTAX, CNTAY, OAX, OAY
            OAX = JAX
            OAY = JAY
            DRWLINE 1, 10, CNTAX, CNTAY, OAX, OAY
            SETVIEW 0, 0, GETMAXX, GETMAXY
            IF (JAButs AND 1) = 1 THEN
                DRWSTRING 1, 10, 0, "ButA", JABAX, JABAY
            ELSE
                DRWSTRING 1, 8, 0, "ButA", JABAX, JABAY
            END IF
            IF (JAButs AND 2) = 2 THEN
                DRWSTRING 1, 10, 0, "ButB", JABBX, JABBY
            ELSE
                DRWSTRING 1, 8, 0, "ButB", JABBX, JABBY
            END IF
        END IF
        IF (JOYSTICK AND 2) = 2 THEN
            SETVIEW X3, Y3, X4, Y4
            JBX = JBX - MINXB
            JBX = JBX / RANGEXB * DIST + X3
            JBY = JBY - MINYB
            JBY = JBY / RANGEYB * DIST + Y3
            DRWLINE 1, 0, CNTBX, CNTBY, OBX, OBY
            OBX = JBX
            OBY = JBY
            DRWLINE 1, 10, CNTBX, CNTBY, OBX, OBY
            SETVIEW 0, 0, GETMAXX, GETMAXY
            IF (JBButs AND 1) = 1 THEN
                DRWSTRING 1, 10, 0, "ButA", JBBAX, JBBAY
            ELSE
                DRWSTRING 1, 8, 0, "ButA", JBBAX, JBBAY
            END IF
            IF (JBButs AND 2) = 2 THEN
                DRWSTRING 1, 10, 0, "ButB", JBBBX, JBBBY
            ELSE
                DRWSTRING 1, 8, 0, "ButB", JBBBX, JBBBY
            END IF
        END IF
        A$ = INKEY$
    WEND
    RET$ = A$
    IF RET$ = "q" THEN
        RET$ = "Q"
    END IF
    IF RET$ = "s" THEN
        RET$ = "S"
    END IF
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    SETVIEW 0, 0, GETMAXX, GETMAXY
    END SUB

    
    SUB DOMOUSE (RET$)
    
    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 9: Mouse functions"
    FILLSCREEN 0
    PALSET PAL(0), 0, 255
    SETVIEW 0, 0, GETMAXX, GETMAXY

    '*************************************************************************
    '* CHECK TO SEE IF WE HAVE A MOUSE SO WE CAN DO THE MOUSE DEMO
    '*************************************************************************
    MOUSE = WHICHMOUSE
    IF MOUSE < 1 THEN
        SOUND 100, 5
        DRWSTRING 1, 7, 0, TITLE$, 10, 0
        A$ = "Sorry, No Mouse Detected...Can Not Do The Mouse Demo."
        DRWSTRING 1, 7, 0, A$, 10, 16
        WHILE INKEY$ = ""
        WEND
        FILLSCREEN 0
        EXIT SUB
    ELSE
        Colr = 16
        FOR I = 0 TO GETMAXX \ 2
            DRWCIRCLE 1, Colr, GETMAXX \ 4 + I, GETMAXY \ 2, GETMAXY \ 5
            Colr = Colr + 2
            IF Colr > 255 THEN
                Colr = 16
            END IF
        NEXT I
    END IF

    '*************************************************************************
    '* SHOW MOUSESHOW
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, 31
    FILLVIEW 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "MOUSESHOW ()"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    MOUSEENTER '*MUST BE CALLED FIRST TO ENABLE MOUSE FUNCTIONS
    MOUSESHOW
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        MOUSEEXIT '*MUST BE CALLED TO DISABLE MOUSE FUNCTIONS
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW MOUSESTATUS
    '*************************************************************************
    MOUSEHIDE
    SETVIEW 0, 0, GETMAXX, 31
    FILLVIEW 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "MOUSESTATUS (Xloc,Yloc,MButs)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    MOUSESHOW
    SETVIEW 0, 32, GETMAXX, GETMAXY
    A$ = ""
    SOUND 700, .75
    WHILE A$ = ""
        MOUSESTATUS X, Y, MButs
        IF (MButs AND 1) = 1 THEN
            LB = 1
        ELSE
            LB = 0
        END IF
        IF (MButs AND 2) = 2 THEN
            RB = 1
        ELSE
            RB = 0
        END IF
        IF (MButs AND 4) = 4 THEN
            CB = 1
        ELSE
            CB = 0
        END IF
        D$ = "X=" + STR$(X)
        L = LEN(D$)
        IF L < 10 THEN
            D$ = D$ + STRING$(8 - L, 32)
        END IF
        D$ = D$ + "Y=" + STR$(Y)
        L = LEN(D$)
        IF L < 20 THEN
            D$ = D$ + STRING$(16 - L, 32)
        END IF
        D$ = D$ + "LB=" + STR$(LB) + "  CB=" + STR$(CB) + "  RB=" + STR$(RB)
        DRWSTRING 1, 15, 8, D$, 10, 32
        A$ = INKEY$
    WEND
    RET$ = A$
    IF RET$ = "q" THEN
        RET$ = "Q"
    END IF
    IF RET$ = "s" THEN
        RET$ = "S"
    END IF
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        MOUSEEXIT '*MUST BE CALLED TO DISABLE MOUSE FUNCTIONS
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW MOUSEHIDE
    '*************************************************************************
    MOUSEHIDE
    SETVIEW 0, 0, GETMAXX, 31
    FILLVIEW 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "MOUSEHIDE ()"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    A$ = ""
    SOUND 700, .75
    WHILE A$ = ""
        MOUSESTATUS X, Y, MButs
        IF (MButs AND 1) = 1 THEN
            LB = 1
        ELSE
            LB = 0
        END IF
        IF (MButs AND 2) = 2 THEN
            RB = 1
        ELSE
            RB = 0
        END IF
        IF (MButs AND 4) = 4 THEN
            CB = 1
        ELSE
            CB = 0
        END IF
        D$ = "X=" + STR$(X)
        L = LEN(D$)
        IF L < 10 THEN
            D$ = D$ + STRING$(8 - L, 32)
        END IF
        D$ = D$ + "Y=" + STR$(Y)
        L = LEN(D$)
        IF L < 20 THEN
            D$ = D$ + STRING$(16 - L, 32)
        END IF
        D$ = D$ + "LB=" + STR$(LB) + "  CB=" + STR$(CB) + "  RB=" + STR$(RB)
        DRWSTRING 1, 15, 8, D$, 10, 32
        A$ = INKEY$
    WEND
    MOUSESHOW
    RET$ = A$
    IF RET$ = "q" THEN
        RET$ = "Q"
    END IF
    IF RET$ = "s" THEN
        RET$ = "S"
    END IF
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        MOUSEEXIT '*MUST BE CALLED TO DISABLE MOUSE FUNCTIONS
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW MOUSERANGESET
    '*************************************************************************
    MOUSEHIDE
    SETVIEW 0, 0, GETMAXX, 48
    FILLVIEW 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "MOUSERANGESET (X1,Y1,X2,Y2)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 0, GETMAXX, GETMAXY
    SPCNG = (GETMAXY - 32) \ 3
    X1 = SPCNG
    Y1 = 32 + SPCNG
    X2 = GETMAXX - SPCNG
    Y2 = GETMAXY - SPCNG
    DRWBOX 1, 15, X1, Y1, X2, Y2
    MOUSESHOW
    MOUSERANGESET X1, Y1, X2, Y2
    GETKEY RET$
    MOUSERANGESET 0, 0, GETMAXX, GETMAXY
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        MOUSEEXIT '*MUST BE CALLED TO DISABLE MOUSE FUNCTIONS
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    
    '*************************************************************************
    '* SHOW MOUSECURSORSET USE THE MAGNIFIER
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, 31
    FILLVIEW 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "MOUSECURSORSET (MouseCursor?)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    MOUSECURSORSET MAGMOUSECURSOR(0)
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        MOUSEEXIT '*MUST BE CALLED TO DISABLE MOUSE FUNCTIONS
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW MOUSECURSORSET USE THE BIG ARROW
    '*************************************************************************
    SETVIEW 0, 32, GETMAXX, GETMAXY
    MOUSECURSORSET BIGMOUSECURSOR(0)
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        MOUSEEXIT '*MUST BE CALLED TO DISABLE MOUSE FUNCTIONS
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW MOUSECURSORSET USE THE STOPWATCH
    '*************************************************************************
    MOUSECURSORSET STWMOUSECURSOR(0)
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        MOUSEEXIT '*MUST BE CALLED TO DISABLE MOUSE FUNCTIONS
        FILLSCREEN 0
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW MOUSECURSORDEFAULT
    '*************************************************************************
    MOUSEHIDE
    SETVIEW 0, 0, GETMAXX, 31
    FILLVIEW 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "MOUSECURSORDEFAULT ()"
    DRWSTRING 1, 7, 0, A$, 10, 16
    MOUSESHOW
    SETVIEW 0, 32, GETMAXX, GETMAXY
    MOUSECURSORDEFAULT
    GETKEY RET$
    MOUSEEXIT '*MUST BE CALLED TO DISABLE MOUSE FUNCTIONS
    FILLSCREEN 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    END SUB

    
    SUB SHOWPCX (RET$, FILENAME$)
    
    '*************************************************************************
    '* THIS ROUTINE IS CALLED BY DOPCX
    '*************************************************************************
    TITLE$ = "DEMO 8: PCX functions"

    '*************************************************************************
    '* SHOW PCX GET INFO
    '*************************************************************************
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "PCXGETINFO(FileName$,PCXXSize,PCXYSize,NumColors,Palette)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    PCXFILENAME$ = FILENAME$
    OK = PCXGETINFO(PCXFILENAME$, XSIZE, YSIZE, NUMCOL, PCXPAL(0))
    MINCOLOR = 0
    MAXCOLOR = 0
    MINCOLORBRITENESS& = (255^2) * 3
    MAXCOLORBRITENESS& = 0
    IF OK = 1 THEN
        '*********************************************************************
        '* WE NEED TO CHECK THE PCX COLOR PALETTE ENTRIES TO SEE IF ANY COLORS
        '* ARE GREATER THE SIX BITS IN LENGTH AS THE VGA COLOR PALETTE
        '* REGISTERS ARE ONLY SIX BITS WIDE. WE ALSO LOOK FOR THE BRIGHTEST
        '* AND DARKEST COLORS TO USE AS OUR TEXT AND BACKGROUND COLORS
        '*********************************************************************
        FIXIT = 0
        FOR I = 0 TO NUMCOL - 1
            IF PCXPAL(I).R > 63 THEN
                FIXIT = 1
            END IF
            IF PCXPAL(I).G > 63 THEN
                FIXIT = 1
            END IF
            IF PCXPAL(I).B > 63 THEN
                FIXIT = 1
            END IF
            COLORBRIGHTNESS& = PCXPAL(I).R^2 + PCXPAL(I).G^2 + PCXPAL(I).B^2
            '* FIND THE DARKEST COLOR FOR THE BACKGROUND
            IF COLORBRIGHTNESS& < MINCOLORBRITENESS& THEN  
                MINCOLORBRITENESS& = COLORBRIGHTNESS&
                MINCOLOR = I
            END IF
            '* FIND THE BRIGHTEST COLOR FOR THE TEXT
            IF COLORBRIGHTNESS& > MAXCOLORBRITENESS& THEN
                MAXCOLORBRITENESS& = COLORBRIGHTNESS&      
                MAXCOLOR = I
            END IF
        NEXT I
        '*********************************************************************
        '* IF THE PCX USES 8 BIT COLOR THEN WE SHIFT EACH COLOR ENTRY RIGHT
        '* BY 2 BITS (THIS REDUCES IT TO 6 BITS OF COLOR)
        '*********************************************************************
        IF FIXIT = 1 THEN
            FOR A = 0 TO NUMCOL
                SHIFT RIGHT PCXPAL(A).R, 2
                SHIFT RIGHT PCXPAL(A).G, 2
                SHIFT RIGHT PCXPAL(A).B, 2
            NEXT A
        END IF
        '*********************************************************************
        '* IF THE PCX HAS A PALETTE OF 128 COLORS OR LESS THEN WE CAN USE
        '* OUR OWN COLORS FOR THE TEXT AND BACKGROUND
        '*********************************************************************
        IF NUMCOL < 128 THEN
            MINCOLOR = 254
            PCXPAL(MINCOLOR).R = 0   '* THIS IS THE COLOR BLACK
            PCXPAL(MINCOLOR).G = 0
            PCXPAL(MINCOLOR).B = 0
            MAXCOLOR = 255
            PCXPAL(MAXCOLOR).R = 255 '* THIS IS THE COLOR BRIGHT WHITE
            PCXPAL(MAXCOLOR).G = 255
            PCXPAL(MAXCOLOR).B = 255
        END IF
        A$ = "'" + PCXFILENAME$ + "' is identified as a v3.0 PVX file."
        DRWSTRING 1, 15, 0, A$, 10, 64
        A$ = "Dimensions are:" + STR$(XSIZE) + " pixels wide and" + STR$(YSIZE) + " pixels high"
        DRWSTRING 1, 15, 0, A$, 10, 80
        A$ = "Number of colors:" + STR$(NUMCOL)
        DRWSTRING 1, 15, 0, A$, 10, 96
        GETKEY RET$
        IF (RET$ = "S") OR (RET$ = "Q") THEN
            FILLSCREEN 0
            SETVIEW 0, 0, GETMAXX, GETMAXY
            EXIT SUB
        END IF

        '*********************************************************************
        '* SHOW PCX GETPUT
        '*********************************************************************
        PALSET PCXPAL(0), 0, 255
        OVERSCANSET MINCOLOR
        FILLSCREEN MINCOLOR
        DRWSTRING 1, MAXCOLOR, MINCOLOR, TITLE$, 10, 0
        A$ = "PCXPUT(Mode,X,Y,FileName$)"
        DRWSTRING 1, MAXCOLOR, MINCOLOR, A$, 10, 16
        SETVIEW 0, 32, GETMAXX, GETMAXY
        Xloc = (GETMAXX \ 2) - (XSIZE \ 2)
        Yloc = ((GETMAXY - 32) \ 2) - (YSIZE \ 2) + 32
        OK = PCXPUT(1, Xloc, Yloc, PCXFILENAME$)
        IF OK <> 1 THEN
        '*********************************************************************
        '* OOPSTHIS FILE HAS SOME PROBLEM
        '********************************************************************
            SOUND 100, 5
            A$ = "The file '" + PCXFILENAME$ + "' "
            B$ = ""
            SELECT CASE OK
                CASE = 0
                    A$ = A$ + "does not exist in the specified directory"
                    B$ = " or there is some disk I/O problem."
                CASE = -1
                    A$ = A$ + "is not a v3.0 PCX file."
                CASE = -2
                    A$ = A$ + "is not run length encoded."
                CASE = -3
                    A$ = A$ + "has some general error."
            END SELECT
            DRWSTRING 1, MINCOLOR, MAXCOLOR, A$, 10, 64
            DRWSTRING 1, MINCOLOR, MAXCOLOR, B$, 10, 80
        END IF
    ELSE
        '*********************************************************************
        '* OOPSTHIS FILE HAS SOME PROBLEM
        '*********************************************************************
        SOUND 100, 5
        A$ = "The file '" + PCXFILENAME$ + "' "
        B$ = ""
        SELECT CASE OK
            CASE = 0
                A$ = A$ + "does not exist in the specified directory"
                B$ = " or there is some disk I/O problem."
            CASE = -1
                A$ = A$ + "is not a v3.0 PCX file."
            CASE = -2
                A$ = A$ + "is not run length encoded."
            CASE = -3
                A$ = A$ + "has some general error."
        END SELECT
        DRWSTRING 1, 15, 0, A$, 10, 64
        DRWSTRING 1, 15, 0, B$, 10, 80
    END IF
    GETKEY RET$
    PALSET ORGPAL(0), 0, 255
    OVERSCANSET 0
    FILLSCREEN 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    END SUB

    
    SUB SHOWHOUSE
    
    SHARED OPLOTARRY()
    SHARED PLOTARRY()

    '*************************************************************************
    '* THIS ROUTINE IS CALLED BY DO3D
    '*************************************************************************

    '*************************************************************************
    '* ERASE THE OLD HOUSE
    '*************************************************************************
    DRWLINE 1, 0, OPLOTARRY(10).X, OPLOTARRY(10).Y, OPLOTARRY(11).X, OPLOTARRY(11).Y
    DRWLINE 1, 0, OPLOTARRY(10).X, OPLOTARRY(10).Y, OPLOTARRY(12).X, OPLOTARRY(12).Y
    DRWLINE 1, 0, OPLOTARRY(10).X, OPLOTARRY(10).Y, OPLOTARRY(13).X, OPLOTARRY(13).Y
    FOR I = 0 TO 2
        DRWLINE 1, 0, OPLOTARRY(I).X, OPLOTARRY(I).Y, OPLOTARRY(I + 1).X, OPLOTARRY(I + 1).Y
        DRWLINE 1, 0, OPLOTARRY(I + 4).X, OPLOTARRY(I + 4).Y, OPLOTARRY(I + 4 + 1).X, OPLOTARRY(I + 4 + 1).Y
        DRWLINE 1, 0, OPLOTARRY(I).X, OPLOTARRY(I).Y, OPLOTARRY(I + 4).X, OPLOTARRY(I + 4).Y
    NEXT I
    DRWLINE 1, 0, OPLOTARRY(3).X, OPLOTARRY(3).Y, OPLOTARRY(7).X, OPLOTARRY(7).Y
    DRWLINE 1, 0, OPLOTARRY(0).X, OPLOTARRY(0).Y, OPLOTARRY(3).X, OPLOTARRY(3).Y
    DRWLINE 1, 0, OPLOTARRY(4).X, OPLOTARRY(4).Y, OPLOTARRY(7).X, OPLOTARRY(7).Y
    DRWLINE 1, 0, OPLOTARRY(3).X, OPLOTARRY(3).Y, OPLOTARRY(8).X, OPLOTARRY(8).Y
    DRWLINE 1, 0, OPLOTARRY(8).X, OPLOTARRY(8).Y, OPLOTARRY(2).X, OPLOTARRY(2).Y
    DRWLINE 1, 0, OPLOTARRY(7).X, OPLOTARRY(7).Y, OPLOTARRY(9).X, OPLOTARRY(9).Y
    DRWLINE 1, 0, OPLOTARRY(9).X, OPLOTARRY(9).Y, OPLOTARRY(6).X, OPLOTARRY(6).Y
    DRWLINE 1, 0, OPLOTARRY(8).X, OPLOTARRY(8).Y, OPLOTARRY(9).X, OPLOTARRY(9).Y

    '*************************************************************************
    '* DRAW THE NEW HOUSE
    '*************************************************************************
    DRWLINE 1, 8, PLOTARRY(10).X, PLOTARRY(10).Y, PLOTARRY(11).X, PLOTARRY(11).Y
    DRWLINE 1, 8, PLOTARRY(10).X, PLOTARRY(10).Y, PLOTARRY(12).X, PLOTARRY(12).Y
    DRWLINE 1, 8, PLOTARRY(10).X, PLOTARRY(10).Y, PLOTARRY(13).X, PLOTARRY(13).Y
    FOR I = 0 TO 2
        DRWLINE 1, 10, PLOTARRY(I).X, PLOTARRY(I).Y, PLOTARRY(I + 1).X, PLOTARRY(I + 1).Y
        DRWLINE 1, 10, PLOTARRY(I + 4).X, PLOTARRY(I + 4).Y, PLOTARRY(I + 4 + 1).X, PLOTARRY(I + 4 + 1).Y
        DRWLINE 1, 10, PLOTARRY(I).X, PLOTARRY(I).Y, PLOTARRY(I + 4).X, PLOTARRY(I + 4).Y
    NEXT I
    DRWLINE 1, 10, PLOTARRY(3).X, PLOTARRY(3).Y, PLOTARRY(7).X, PLOTARRY(7).Y
    DRWLINE 1, 10, PLOTARRY(0).X, PLOTARRY(0).Y, PLOTARRY(3).X, PLOTARRY(3).Y
    DRWLINE 1, 10, PLOTARRY(4).X, PLOTARRY(4).Y, PLOTARRY(7).X, PLOTARRY(7).Y
    DRWLINE 1, 10, PLOTARRY(3).X, PLOTARRY(3).Y, PLOTARRY(8).X, PLOTARRY(8).Y
    DRWLINE 1, 10, PLOTARRY(8).X, PLOTARRY(8).Y, PLOTARRY(2).X, PLOTARRY(2).Y
    DRWLINE 1, 10, PLOTARRY(7).X, PLOTARRY(7).Y, PLOTARRY(9).X, PLOTARRY(9).Y
    DRWLINE 1, 10, PLOTARRY(9).X, PLOTARRY(9).Y, PLOTARRY(6).X, PLOTARRY(6).Y
    DRWLINE 1, 10, PLOTARRY(8).X, PLOTARRY(8).Y, PLOTARRY(9).X, PLOTARRY(9).Y

    '*************************************************************************
    '* SAVE THE OLD POINTS
    '*************************************************************************
    BYTECOPY PLOTARRY(0).X, OPLOTARRY(0).X, 56
    END SUB

    
    SUB SHOWSTAR
    
    SHARED OPLOTARRY()
    SHARED PLOTARRY()

    '*************************************************************************
    '* THIS ROUTINE IS CALLED BY DO2D
    '*************************************************************************

    '*************************************************************************
    '* ERASE THE OLD STAR
    '*************************************************************************
    FOR I = 0 TO 7
        DRWLINE 1, 0, OPLOTARRY(I).X, OPLOTARRY(I).Y, OPLOTARRY(I + 1).X, OPLOTARRY(I + 1).Y
    NEXT I

    '*************************************************************************
    '* DRAW THE NEW STAR
    '*************************************************************************
    FOR I = 0 TO 7
        DRWLINE 1, 10, PLOTARRY(I).X, PLOTARRY(I).Y, PLOTARRY(I + 1).X, PLOTARRY(I + 1).Y
    NEXT I

    '*************************************************************************
    '* SAVE THE OLD POINTS
    '*************************************************************************
    BYTECOPY PLOTARRY(0).X, OPLOTARRY(0).X, 36
    END SUB

 