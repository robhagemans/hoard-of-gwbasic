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

    SUB DOBLOCK (RET$)
    
    MYPI! = ATN(1) * 4

    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 5: Block functions and Sprites"
    PALSET PAL(0), 0, 255

    '*************************************************************************
    '* SHOW BLOCK GET (DRAW SOME CIRCLES AND "GET A CHUNK OF THEM")
    '*************************************************************************
    FILLSCREEN 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "BLKGET (X1,Y1,X2,Y2,GfxBlock)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    Colr = 16
    FOR I = 0 TO GETMAXX \ 2
        DRWCIRCLE 1, Colr, GETMAXX \ 4 + I, GETMAXY \ 2, GETMAXY \ 5
        Colr = Colr + 4
        IF Colr > 255 THEN
            Colr = 16
        END IF
    NEXT I
    XINC = GETMAXX \ 20
    YINC = GETMAXY \ 20
    X1 = GETMAXX \ 2 - XINC
    Y1 = GETMAXY \ 2 - YINC
    X2 = GETMAXX \ 2 + XINC
    Y2 = GETMAXY \ 2 + YINC
    DRWBOX 1, 0, X1, Y1, X2, Y2
    BLKSIZE1 = (((X2 - X1 + 1) * (Y2 - Y1 + 1)) / 2) + 3
  REDIM DYNAMIC GFXBLK1(BLKSIZE1) AS SHARED INTEGER
    BLKGET X1, Y1, X2, Y2, GFXBLK1(0)
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW BLOCK ROTATE AND SPRITE STUFF
    '*************************************************************************
    X = (X2 - X1) \ 2 + X1
    Y = (Y2 - Y1) \ 2 + Y1
    A$ = "BLKROTATE (Angle,BackFill,SourceGfxBlock,DestGfxBlock)   "
    DRWSTRING 1, 7, 0, A$, 10, 16
    A$ = "SPRITEGAP(TranSColr,X,Y,SpriteArray,BackGroundGfxBlock)"
    DRWSTRING 1, 7, 0, A$, 10, 32
    A$ = "SPRITEPUT(Mode%,TranSColr,X,Y,SpriteArray)"
    DRWSTRING 1, 7, 0, A$, 10, 48
    FILLAREA X1 + 2, Y1 + 2, 0, 0
    BLKSIZE2 = (BLKROTATESIZE(45, GFXBLK1(0)) \ 2) + 1
  REDIM DYNAMIC GFXBLK2(BLKSIZE2) AS SHARED INTEGER
  REDIM DYNAMIC GFXBLK3(BLKSIZE2) AS SHARED INTEGER
    BLKGET X1, Y1, X2, Y2, GFXBLK3(0)
    SETVIEW 0, 64, GETMAXX, GETMAXY
    FOR I = 0 TO 360 STEP 3
        DUMMY = BLKROTATE(I, 1, GFXBLK1(0), GFXBLK2(0))
        SPRITEPUT 1, 1, X - GFXBLK3(0) \ 2, Y - GFXBLK3(1) \ 2, GFXBLK3(0)
        SPRITEGAP 1, X - GFXBLK2(0) \ 2, Y - GFXBLK2(1) \ 2, GFXBLK2(0), GFXBLK3(0)
        SDELAY 4
    NEXT I
    SPRITEPUT 1, 1, X - GFXBLK3(0) \ 2, Y - GFXBLK3(1) \ 2, GFXBLK3(0)
    BLKPUT 1, X1, Y1, GFXBLK1(0)
    GETKEY RET$
    SETVIEW 0, 0, GETMAXX, GETMAXY
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW BLOCK RESIZE AND SPRITE STUFF
    '*************************************************************************
    A$ = "BLKRESIZE (NewWidth,NewHeight,SourceGfxBlock,DestGfxBlock)   "
    DRWSTRING 1, 7, 0, A$, 10, 16
    A$ = "SPRITEGAP(TranSColr,X,Y,SpriteArray,BackGroundGfxBlock)"
    DRWSTRING 1, 7, 0, A$, 10, 32
    A$ = "SPRITEPUT(Mode%,TranSColr,X,Y,SpriteArray)"
    DRWSTRING 1, 7, 0, A$, 10, 48
    SETVIEW 0, 64, GETMAXX, GETMAXY
    FILLAREA X1 + 2, Y1 + 2, 0, 0
    BLKSIZE3 = (((X2 - X1 + 1) * (Y2 - Y1 + 1)) / 2) + 3
  REDIM DYNAMIC GFXBLK3(BLKSIZE3) AS SHARED INTEGER
    BLKGET X1, Y1, X2, Y2, GFXBLK3(0)
    BLKSIZE2 = (((GFXBLK1(0) + 1) * (GFXBLK1(1) + 1)) / 2) + 3
  REDIM DYNAMIC GFXBLK2(BLKSIZE2) AS SHARED INTEGER
    FOR I = 0 TO XINC
        BLKRESIZE GFXBLK1(0) - I, GFXBLK1(1) - I, GFXBLK1(0), GFXBLK2(0)
        SPRITEPUT 1, 1, X - GFXBLK3(0) \ 2, Y - GFXBLK3(1) \ 2, GFXBLK3(0)
        SPRITEGAP 1, X - GFXBLK2(0) \ 2, Y - GFXBLK2(1) \ 2, GFXBLK2(0), GFXBLK3(0)
        SDELAY 5
    NEXT I
    SPRITEPUT 1, 1, X - GFXBLK3(0) \ 2, Y - GFXBLK3(1) \ 2, GFXBLK3(0)
    FOR I = XINC TO 0 STEP -1
        BLKRESIZE GFXBLK1(0) - I, GFXBLK1(1) - I, GFXBLK1(0), GFXBLK2(0)
        SPRITEPUT 1, 1, X - GFXBLK3(0) \ 2, Y - GFXBLK3(1) \ 2, GFXBLK3(0)
        SPRITEGAP 1, X - GFXBLK2(0) \ 2, Y - GFXBLK2(1) \ 2, GFXBLK2(0), GFXBLK3(0)
        SDELAY 5
    NEXT I
    SPRITEPUT 1, 1, X - GFXBLK1(0) \ 2, Y - GFXBLK1(1) \ 2, GFXBLK1(0)
    GETKEY RET$
    SETVIEW 0, 0, GETMAXX, GETMAXY
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        EXIT SUB
    END IF

    '*************************************************************************
    '* SHOW BLOCK PUT (PUT THE "CHUNKS" RANDOMLY AROUND THE SCREEN)
    '*************************************************************************
    SETVIEW 0, 31, GETMAXX, 64
    FILLVIEW 0
    A$ = "BLKPUT (Mode,X,Y,GfxBlock)   "
    DRWSTRING 1, 7, 0, A$, 10, 16
    XINC = GETMAXX \ 10
    YINC = GETMAXY \ 10
    SETVIEW 0, 32, GETMAXX, GETMAXY
    FOR I = 0 TO GETMAXX \ 2
        X = (GETMAXX + XINC) * RND - XINC
        Y = (GETMAXY + YINC) * RND - YINC
        BLKPUT 1, X, Y, GFXBLK1(0)
    NEXT I
    GETKEY RET$
    SETVIEW 0, 0, GETMAXX, GETMAXY
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        EXIT SUB
    END IF

    END SUB

    SUB DOCLIP (RET$)
    
    '*************************************************************************
    '* SET UP AND SHOW THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 2: Clipping capability"
    PALSET PAL2(0), 0, 255

    '*************************************************************************
    '* SET UP THE WINDOWS
    '*************************************************************************
    FILLSCREEN 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "All primitives automatically clip"
    DRWSTRING 1, 7, 0, A$, 10, 16
    WDTH = (GETMAXX + 1) / 2.25
    SPCINGX = ((GETMAXX + 1) - WDTH * 2) / 3
    HGTH = (GETMAXY + 1 - 35) / 2.25
    SPCINGY = ((GETMAXY + 1 - 35) - HGTH * 2) / 3
    XINC = WDTH * 1.5
    YINC = HGTH * 1.5
    XSUB = WDTH * .25
    YSUB = HGTH * .25
    B1X1 = SPCINGX
    B1X2 = B1X1 + WDTH
    B1Y1 = SPCINGY + 35
    B1Y2 = B1Y1 + HGTH
    B2X2 = GETMAXX - SPCINGX
    B2X1 = B2X2 - WDTH
    B2Y1 = SPCINGY + 35
    B2Y2 = B2Y1 + HGTH
    B3X2 = GETMAXX - SPCINGX
    B3X1 = B3X2 - WDTH
    B3Y2 = GETMAXY - SPCINGY
    B3Y1 = B3Y2 - HGTH
    B4X1 = SPCINGX
    B4X2 = B4X1 + WDTH
    B4Y2 = GETMAXY - SPCINGY
    B4Y1 = B4Y2 - HGTH
    DRWBOX 1, 15, B1X1, B1Y1, B1X2, B1Y2
    DRWBOX 1, 15, B2X1, B2Y1, B2X2, B2Y2
    DRWBOX 1, 15, B3X1, B3Y1, B3X2, B3Y2
    DRWBOX 1, 15, B4X1, B4Y1, B4X2, B4Y2
    B1X1 = B1X1 + 1
    B1Y1 = B1Y1 + 1
    B1X2 = B1X2 - 1
    B1Y2 = B1Y2 - 1
    B2X1 = B2X1 + 1
    B2Y1 = B2Y1 + 1
    B2X2 = B2X2 - 1
    B2Y2 = B2Y2 - 1
    B3X1 = B3X1 + 1
    B3Y1 = B3Y1 + 1
    B3X2 = B3X2 - 1
    B3Y2 = B3Y2 - 1
    B4X1 = B4X1 + 1
    B4Y1 = B4Y1 + 1
    B4X2 = B4X2 - 1
    B4Y2 = B4Y2 - 1
    Colr = 1
    
    '*************************************************************************
    '* SHOW THE CLIPPING
    '*************************************************************************
    FOR I = 0 TO GETMAXX \ 6
        FOR J = 1 TO 4
            SELECT CASE J
                CASE = 1
                    SETVIEW B1X1, B1Y1, B1X2, B1Y2
                    FOR K = 0 TO 4
                        X = B1X1 + RND * XINC - XSUB
                        Y = B1Y1 + RND * XINC - XSUB
                        DRWPOINT 1, Colr, X, Y
                        Colr = Colr + 1
                        IF Colr > 15 THEN
                            Colr = 1
                        END IF
                    NEXT K
                CASE = 2
                    SETVIEW B2X1, B2Y1, B2X2, B2Y2
                    X1 = B2X1 + RND * XINC - XSUB
                    Y1 = B2Y1 + RND * XINC - XSUB
                    X2 = B2X1 + RND * XINC - XSUB
                    Y2 = B2Y1 + RND * XINC - XSUB
                    DRWLINE 1, Colr, X1, Y1, X2, Y2
                    Colr = Colr + 1
                    IF Colr > 15 THEN
                        Colr = 1
                    END IF
                CASE = 3
                    SETVIEW B3X1, B3Y1, B3X2, B3Y2
                    X = B3X1 + RND * XINC - XSUB
                    Y = B3Y1 + RND * XINC - XSUB
                    RAD = RND * WDTH \ 2
                    DRWCIRCLE 1, Colr, X, Y, RAD
                    Colr = Colr + 1
                    IF Colr > 15 THEN
                        Colr = 1
                    END IF
                CASE = 4
                    SETVIEW B4X1, B4Y1, B4X2, B4Y2
                    X = B4X1 + RND * XINC - XSUB
                    Y = B4Y1 + RND * XINC - XSUB
                    RADX = RND * WDTH \ 2
                    RADY = RND * WDTH \ 2
                    DRWELLIPSE 1, Colr, X, Y, RADX, RADY
                    Colr = Colr + 1
                    IF Colr > 15 THEN
                        Colr = 1
                    END IF
            END SELECT
        NEXT J
    NEXT I
    SETVIEW 0, 0, GETMAXX, GETMAXY
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        EXIT SUB
    END IF
    END SUB

    SUB DOFILL (RET$)
    
    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 3: Filling functions"
    PALSET PAL(0), 0, 255
    
    '*************************************************************************
    '* SHOW SCREEN FILL
    '*************************************************************************
    FILLSCREEN 10
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "FILLSCREEN (Color)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    
    '*************************************************************************
    '* SET UP WINDOWS AND SHOW VIEWPORT FILL
    '*************************************************************************
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "FILLVIEW (Color)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    WDTH = (GETMAXX + 1) / 2.25
    SPCINGX = ((GETMAXX + 1) - WDTH * 2) / 3
    HGTH = (GETMAXY + 1 - 35) / 2.25
    SPCINGY = ((GETMAXY + 1 - 35) - HGTH * 2) / 3
    XINC = WDTH * 1.5
    YINC = HGTH * 1.5
    XSUB = WDTH * .25
    YSUB = HGTH * .25
    B1X1 = SPCINGX
    B1X2 = B1X1 + WDTH
    B1Y1 = SPCINGY + 35
    B1Y2 = B1Y1 + HGTH
    B2X2 = GETMAXX - SPCINGX
    B2X1 = B2X2 - WDTH
    B2Y1 = SPCINGY + 35
    B2Y2 = B2Y1 + HGTH
    B3X2 = GETMAXX - SPCINGX
    B3X1 = B3X2 - WDTH
    B3Y2 = GETMAXY - SPCINGY
    B3Y1 = B3Y2 - HGTH
    B4X1 = SPCINGX
    B4X2 = B4X1 + WDTH
    B4Y2 = GETMAXY - SPCINGY
    B4Y1 = B4Y2 - HGTH
    DRWBOX 1, 15, B1X1, B1Y1, B1X2, B1Y2
    DRWBOX 1, 15, B2X1, B2Y1, B2X2, B2Y2
    DRWBOX 1, 15, B3X1, B3Y1, B3X2, B3Y2
    DRWBOX 1, 15, B4X1, B4Y1, B4X2, B4Y2
    B1X1 = B1X1 + 1
    B1Y1 = B1Y1 + 1
    B1X2 = B1X2 - 1
    B1Y2 = B1Y2 - 1
    B2X1 = B2X1 + 1
    B2Y1 = B2Y1 + 1
    B2X2 = B2X2 - 1
    B2Y2 = B2Y2 - 1
    B3X1 = B3X1 + 1
    B3Y1 = B3Y1 + 1
    B3X2 = B3X2 - 1
    B3Y2 = B3Y2 - 1
    B4X1 = B4X1 + 1
    B4Y1 = B4Y1 + 1
    B4X2 = B4X2 - 1
    B4Y2 = B4Y2 - 1
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    SETVIEW B1X1, B1Y1, B1X2, B1Y2
    FILLVIEW 10
    SETVIEW B2X1, B2Y1, B2X2, B2Y2
    FILLVIEW 12
    SETVIEW B3X1, B3Y1, B3X2, B3Y2
    FILLVIEW 13
    SETVIEW B4X1, B4Y1, B4X2, B4Y2
    FILLVIEW 14
    SETVIEW 0, 0, GETMAXX, GETMAXY
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    
    '*************************************************************************
    '* SET UP WINDOW AND SHOW AREA FILL
    '*************************************************************************
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "FILLAREA (Xseed,Yseed,BrdrCol,FilCol)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    DRWBOX 1, 15, 5, 35, GETMAXX - 4, GETMAXY - 4
    SETVIEW 6, 36, GETMAXX - 5, GETMAXY - 5

    Colr = 1
    FOR I = 0 TO GETMAXX \ 10
        X = 50 + RND * (GETMAXX - 50)
        Y = 50 + RND * (GETMAXY - 50)
        RADX = 2 + RND * GETMAXX \ 20
        RADY = 2 + RND * GETMAXX \ 20
        DRWELLIPSE 1, Colr, X, Y, RADX, RADY
        Colr = Colr + 1
        IF Colr > 9 THEN
            Colr = 1
        END IF
    NEXT I
    FOR I = 0 TO GETMAXX \ 15
        X = 50 + RND * (GETMAXX - 50)
        Y = 50 + RND * (GETMAXY - 50)
        RADX = 2 + RND * GETMAXX \ 20
        RADY = 2 + RND * GETMAXX \ 20
        DRWELLIPSE 1, 12, X, Y, RADX, RADY
    NEXT I
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    FILLAREA 7, 37, 12, 10
    GETKEY RET$
    SETVIEW 0, 0, GETMAXX, GETMAXY
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        EXIT SUB
    END IF
    
    '*************************************************************************
    '* SET UP WINDOW AND SHOW COLOR FILL
    '*************************************************************************
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "FILLCOLOR (Xseed,Yseed,OldCol,FilCol)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    DRWBOX 1, 15, 5, 35, GETMAXX - 4, GETMAXY - 4
    SETVIEW 6, 36, GETMAXX - 5, GETMAXY - 5
    Colr = 1
    FOR I = 0 TO GETMAXX \ 10
        X = 50 + RND * (GETMAXX - 50)
        Y = 50 + RND * (GETMAXY - 50)
        RADX = 2 + RND * GETMAXX \ 20
        RADY = 2 + RND * GETMAXX \ 20
        DRWELLIPSE 1, Colr, X, Y, RADX, RADY
        Colr = Colr + 1
        IF Colr > 9 THEN
            Colr = 1
        END IF
    NEXT I
    FOR I = 0 TO GETMAXX \ 15
        X = 50 + RND * (GETMAXX - 50)
        Y = 50 + RND * (GETMAXY - 50)
        RADX = 2 + RND * GETMAXX \ 20
        RADY = 2 + RND * GETMAXX \ 20
        DRWELLIPSE 1, 12, X, Y, RADX, RADY
    NEXT I
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    FILLCOLOR 7, 37, 0, 10
    SETVIEW 0, 0, GETMAXX, GETMAXY
    GETKEY RET$
    END SUB

    SUB DOPAL (RET$)
    
    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 4: Palette functions"
    PALSET ORGPAL(0), 0, 255
    
    '*************************************************************************
    '* SHOW PALETTE SET/GET
    '*************************************************************************
    FILLSCREEN 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "PALGET (Palette,FirstColr,LastColr) PALSET (Palette,FirtColr,LastColr)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    Colr = 16
    X1 = 10
    X2 = GETMAXX - 9
    Y1 = 35
    Y2 = GETMAXY - 9
    I = 0
    WHILE Y1 + I < Y2 - I
        DRWBOX 1, Colr, X1 + I, Y1 + I, X2 - I, Y2 - I
        Colr = Colr + 1
        IF Colr > 255 THEN
            Colr = 16
        END IF
        I = I + 1
    WEND
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        FILLSCREEN 0
        PALSET PAL(0), 16, 255
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    PALSET PAL(0), 16, 255
    
    '*************************************************************************
    '* SHOW PALETTE AUTO FADE OUT/IN
    '*************************************************************************
    A$ = "PALIOAUTO (Palette,FirstColr,LastColr,Speed)                           "
    DRWSTRING 1, 7, 0, A$, 10, 16
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    PALIOAUTO PAL(0), 16, 255, -2
    PALIOAUTO PAL(0), 16, 255, 2

    '*************************************************************************
    '* SHOW PALETTE AUTO FADE TO
    '*************************************************************************
    A$ = "PALCHGAUTO (Palette,NewPalette$,FirstColr,LastColr,Speed)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    PALCHGAUTO PAL(0), PAL2(0), 16, 255, 2
    PALCHGAUTO PAL2(0), PAL(0), 16, 255, 2

    '*************************************************************************
    '* SHOW PALETTE ROTATE
    '*************************************************************************
    A$ = "PALROTATE (Palette,FirstColr,LastColr,Shift)             "
    DRWSTRING 1, 7, 0, A$, 10, 16
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    FOR I = 0 TO 240
        PALROTATE PAL(0), 16, 255, 2
        PALGET PAL(0), 16, 255
    NEXT I
    FOR I = 0 TO 120
        PALROTATE PAL(0), 16, 255, -8
        PALGET PAL(0), 16, 255
    NEXT I
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    END SUB

    SUB DOPRIMS (RET$)
    
    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 1: Primitives"
    PALSET PAL(0), 0, 255

    DIM P1 AS P2DType
    DIM OFF1 AS P2DType
    DIM OFF2 AS P2DType
    DIM P2 AS P2DType
     
    '*************************************************************************
    '* DRAW SOME POINTS
    '*************************************************************************
    FILLSCREEN 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWPOINT (Mode,Color,X1,Y1,X2,Y2)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    Colr = 1
    NUMOF = GETMAXX * 2
    FOR A = 0 TO NUMOF
        X1 = RND * GETMAXX
        Y1 = RND * GETMAXY
        DRWPOINT 1, Colr, X1, Y1
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* DRAW SOME LINES
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWLINE (Mode,Color,X1,Y1,X2,Y2)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 6
    FOR A = 0 TO NUMOF
        X1 = RND * GETMAXX
        Y1 = RND * GETMAXY
        X2 = RND * GETMAXX
        Y2 = RND * GETMAXY
        DRWLINE 1, Colr, X1, Y1, X2, Y2
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* DRAW SOME ANTIALIASED LINES
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWALINE (IntsBits,Color,X1,Y1,X2,Y2)  [antialiased lines]"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 8
    '* SET UP THE PALETTE..WE USE PCXPAL AS A TEMPORARY PALETTE
    INTSBITS = 2
    NUMLEVELS = 2 ^ INTSBITS
    PALGET PCXPAL(0), 0, 255
    FOR I = 0 TO NUMLEVELS - 1
        '* BLUE
        OFST = 128 + NUMLEVELS * 0 + I
        PCXPAL(OFST).R = 0
        PCXPAL(OFST).G = 0
        PCXPAL(OFST).B = 63 - 35 * I / (NUMLEVELS - 1)

        '* GREEN
        OFST = 128 + NUMLEVELS * 1 + I
        PCXPAL(OFST).R = 0
        PCXPAL(OFST).G = 63 - 35 * I / (NUMLEVELS - 1)
        PCXPAL(OFST).B = 0
     
        '* CYAN
        OFST = 128 + NUMLEVELS * 2 + I
        PCXPAL(OFST).R = 0
        PCXPAL(OFST).G = 63 - 35 * I / (NUMLEVELS - 1)
        PCXPAL(OFST).B = 63 - 35 * I / (NUMLEVELS - 1)

        '* RED
        OFST = 128 + NUMLEVELS * 3 + I
        PCXPAL(OFST).R = 63 - 35 * I / (NUMLEVELS - 1)
        PCXPAL(OFST).G = 0
        PCXPAL(OFST).B = 0

        '* MAGENTA
        OFST = 128 + NUMLEVELS * 4 + I
        PCXPAL(OFST).R = 63 - 35 * I / (NUMLEVELS - 1)
        PCXPAL(OFST).G = 0
        PCXPAL(OFST).B = 63 - 35 * I / (NUMLEVELS - 1)

        '* YELLOW
        OFST = 128 + NUMLEVELS * 5 + I
        PCXPAL(OFST).R = 63 - 35 * I / (NUMLEVELS - 1)
        PCXPAL(OFST).G = 63 - 35 * I / (NUMLEVELS - 1)
        PCXPAL(OFST).B = 0

        '* WHITE
        OFST = 128 + NUMLEVELS * 6 + I
        PCXPAL(OFST).R = 63 - 35 * I / (NUMLEVELS - 1)
        PCXPAL(OFST).G = 63 - 35 * I / (NUMLEVELS - 1)
        PCXPAL(OFST).B = 63 - 35 * I / (NUMLEVELS - 1)
    NEXT I
    PALSET PCXPAL(0), 0, 255

    Colr = 0
    FOR A = 0 TO NUMOF
        X1 = RND * GETMAXX
        Y1 = RND * GETMAXY
        X2 = RND * GETMAXX
        Y2 = RND * GETMAXY
        DRWALINE INTSBITS, 128 + Colr * NUMLEVELS, X1, Y1, X2, Y2
        Colr = Colr + 1
        IF Colr > 6 THEN
            Colr = 0
        END IF
    NEXT A
    GETKEY RET$
    PALSET ORGPAL(0), 0, 255
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
 
    '*************************************************************************
    '* DRAW SOME BOXES
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWBOX (Mode,Color,X1,Y1,X2,Y2)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 10
    FOR A = 0 TO NUMOF
        X1 = RND * GETMAXX
        Y1 = RND * GETMAXY
        X2 = RND * GETMAXX
        Y2 = RND * GETMAXY
        DRWBOX 1, Colr, X1, Y1, X2, Y2
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* DRAW SOME FILLED BOXES
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWFILLBOX (Mode,Color,X1,Y1,X2,Y2)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 15
    FOR A = 0 TO NUMOF
        X1 = RND * GETMAXX
        Y1 = RND * GETMAXY
        X2 = RND * GETMAXX
        Y2 = RND * GETMAXY
        DRWFILLBOX 1, Colr, X1, Y1, X2, Y2
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
 
    '*************************************************************************
    '* DRAW SOME CIRCLES
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWCIRCLE (Mode,Color,Cx,Cy,Radius)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 20
    MAXRAD = GETMAXX \ 2
    FOR A = 0 TO NUMOF
        X = RND * GETMAXX
        Y = RND * GETMAXY
        RAD = RND * MAXRAD
        DRWCIRCLE 1, Colr, X, Y, RAD
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    
    '*************************************************************************
    '* DRAW SOME FILLED CIRCLES
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWFILLCIRCLE (Mode,Color,Cx,Cy,Radius)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 25
    MAXRAD = GETMAXX \ 2
    FOR A = 0 TO NUMOF
        X = RND * GETMAXX
        Y = RND * GETMAXY
        RAD = RND * MAXRAD
        DRWFILLCIRCLE 1, Colr, X, Y, RAD
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
 
    '*************************************************************************
    '* DRAW SOME ELLIPSES
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWELLIPSE (Mode,Color,Cx,Cy,RadiusX,RadiusY)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 20
    MAXRAD = GETMAXX \ 2
    FOR A = 0 TO NUMOF
        X = RND * GETMAXX
        Y = RND * GETMAXY + 35
        RADX = RND * MAXRAD
        RADY = RND * MAXRAD
        DRWELLIPSE 1, Colr, X, Y, RADX, RADY
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    SETVIEW 0, 0, GETMAXX, GETMAXY
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        EXIT SUB
    END IF
 
    '*************************************************************************
    '* DRAW SOME FILLED ELLIPSES
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWFILLELLIPSE (Mode,Color,Cx,Cy,RadiusX,RadiusY)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 25
    MAXRAD = GETMAXX \ 2
    FOR A = 0 TO NUMOF
        X = RND * GETMAXX
        Y = RND * GETMAXY + 35
        RADX = RND * MAXRAD
        RADY = RND * MAXRAD
        DRWFILLELLIPSE 1, Colr, X, Y, RADX, RADY
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    SETVIEW 0, 0, GETMAXX, GETMAXY
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        EXIT SUB
    END IF

    '*************************************************************************
    '* DRAW SOME CIRCLULAR ARCS
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWCIRARC (Mode,Color,Cx,Cy,Radius,StartAng,EndAng)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 20
    MAXRAD = GETMAXX \ 2
    FOR A = 0 TO NUMOF
        X = RND * GETMAXX
        Y = RND * GETMAXY
        RAD = RND * MAXRAD
        SANG = RND * 360
        EANG = RND * 360 + SANG
        DRWCIRARC 1, Colr, X, Y, RAD, SANG, EANG
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

    '*************************************************************************
    '* DRAW SOME ELLIPTICAL ARCS
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWELLARC (Mode,Color,Cx,Cy,RadiusX,RadiusY,StartAng,EndAng)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 20
    MAXRAD = GETMAXX \ 2
    FOR A = 0 TO NUMOF
        X = RND * GETMAXX
        Y = RND * GETMAXY + 35
        RADX = RND * MAXRAD
        RADY = RND * MAXRAD
        SANG = RND * 360
        EANG = RND * 360 + SANG
        DRWELLARC 1, Colr, X, Y, RADX, RADY, SANG, EANG
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    SETVIEW 0, 0, GETMAXX, GETMAXY
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        EXIT SUB
    END IF
 
    '*************************************************************************
    '* DRAW SOME CUBIC BEZIER CURVES
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    FILLSCREEN 0
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWCUBICBEZIER (Mode,Color,Pon1,Poff1,Poff2,Pon2)"
    DRWSTRING 1, 7, 0, A$, 10, 18
    SETVIEW 0, 32, GETMAXX, GETMAXY
    NUMOF = GETMAXX \ 20
    FOR A = 0 TO NUMOF
        P1.X = RND * GETMAXX
        P1.Y = RND * GETMAXY
        OFF1.X = RND * GETMAXX
        OFF1.Y = RND * GETMAXY
        OFF2.X = RND * GETMAXX
        OFF2.Y = RND * GETMAXY
        P2.X = RND * GETMAXX
        P2.Y = RND * GETMAXY
        DRWCUBICBEZIER 1, Colr, P1.X, OFF1.X, OFF2.X, P2.X
        Colr = Colr + 1
        IF Colr > 15 THEN
            Colr = 1
        END IF
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
    

    END SUB

    SUB DOSCROLL (RET$)
    
    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 7: Scrolling and Paging Functions"
    PALSET PAL(0), 0, 255
    FILLSCREEN 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0

    SPCNG = (GETMAXY - 32) \ 5
    X1 = ((GETMAXX + 1) \ 2) - SPCNG
    Y1 = (((GETMAXY + 1 - 32) \ 2) + 32) - SPCNG
    X2 = ((GETMAXX + 1) \ 2) + SPCNG
    Y2 = (((GETMAXY + 1 - 32) \ 2) + 32) + SPCNG
    SKIP = SPCNG / 15
    NUM = SPCNG / SKIP
    DRWBOX 1, 12, X1, Y1, X2, Y2
    X1 = X1 + 1
    Y1 = Y1 + 1
    X2 = X2 - 1
    Y2 = Y2 - 1
    Colr = 16
    TEXT$ = "TEXT text TEXT text TEXT"

    '*************************************************************************
    '* SHOW SCROLLUP
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    A$ = "SCROLLUP (X1,Y1,X2,Y2,NumLines,FillColr)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW X1, Y1, X2, Y2
    FILLVIEW 0
    NUMOF = GETMAXX \ 10
    FOR A = 0 TO NUMOF
        X = RND * GETMAXX
        Y = RND * GETMAXY
        I = RND * GETMAXX
        J = RND * GETMAXY
        DRWLINE 1, Colr, X, Y, I, J
        Colr = Colr + 3
        IF Colr > 255 THEN
            Colr = 16
        END IF
    NEXT A
    DRWSTRING 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGLT 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGDN 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGRT 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    FOR A = 0 TO NUM
        SCROLLUP X1, Y1, X2, Y2, SKIP, 0   '* HERE IT IS!
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
 
    '*************************************************************************
    '* SHOW SCROLLLT
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    A$ = "SCROLLLT (X1,Y1,X2,Y2,NumLines,FillColr)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW X1, Y1, X2, Y2
    FILLVIEW 0
    NUMOF = GETMAXX \ 10
    FOR A = 0 TO NUMOF
        X = RND * GETMAXX
        Y = RND * GETMAXY
        I = RND * GETMAXX
        J = RND * GETMAXY
        DRWLINE 1, Colr, X, Y, I, J
        Colr = Colr + 3
        IF Colr > 255 THEN
            Colr = 16
        END IF
    NEXT A
    DRWSTRING 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGLT 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGDN 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGRT 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    FOR A = 0 TO NUM
        SCROLLLT X1, Y1, X2, Y2, SKIP, 0   '* HERE IT IS!
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
 
    '*************************************************************************
    '* SHOW SCROLLDN
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    A$ = "SCROLLDN (X1,Y1,X2,Y2,NumLines,FillColr)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW X1, Y1, X2, Y2
    FILLVIEW 0
    NUMOF = GETMAXX \ 10
    FOR A = 0 TO NUMOF
        X = RND * GETMAXX
        Y = RND * GETMAXY
        I = RND * GETMAXX
        J = RND * GETMAXY
        DRWLINE 1, Colr, X, Y, I, J
        Colr = Colr + 3
        IF Colr > 255 THEN
            Colr = 16
        END IF
    NEXT A
    DRWSTRING 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGLT 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGDN 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGRT 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    FOR A = 0 TO NUM
        SCROLLDN X1, Y1, X2, Y2, SKIP, 0   '* HERE IT IS!
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
 
    '*************************************************************************
    '* SHOW SCROLLRT
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY
    A$ = "SCROLLRT (X1,Y1,X2,Y2,NumLines,FillColr)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW X1, Y1, X2, Y2
    FILLVIEW 0
    NUMOF = GETMAXX \ 10
    FOR A = 0 TO NUMOF
        X = RND * GETMAXX
        Y = RND * GETMAXY
        I = RND * GETMAXX
        J = RND * GETMAXY
        DRWLINE 1, Colr, X, Y, I, J
        Colr = Colr + 3
        IF Colr > 255 THEN
            Colr = 16
        END IF
    NEXT A
    DRWSTRING 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGLT 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGDN 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    DRWSTRINGRT 1, 7, 0, TEXT$, X1 + SPCNG, Y1 + SPCNG
    FOR A = 0 TO NUM
        SCROLLRT X1, Y1, X2, Y2, SKIP, 0   '* HERE IT IS!
    NEXT A
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
 
    '*************************************************************************
    '* SHOW PAGING
    '*************************************************************************
    SETVIEW 0, 0, GETMAXX, GETMAXY

    '*************************************************************************
    '* CHECK TO SEE IF CARD SUPPORTS CHANGING THE DISPLAY OFFSET
    '*************************************************************************
    X1 = GETMAXX + 1
    Y1 = GETMAXY + 1
    IF PAGEDISPLAY(0, 0, 0) = 0 THEN
        FILLSCREEN 0
        SOUND 100, 5
        DRWSTRING 1, 7, 0, TITLE$, 10, 0
        A$ = "Sorry, This Video Card Does Not Support"
        DRWSTRING 1, 7, 0, A$, 10, 16
        A$ = "Changing The Display Offset In This"
        DRWSTRING 1, 7, 0, A$, 10, 32
        A$ = "Video Mode...Can Not Do The Paging Demo."
        DRWSTRING 1, 7, 0, A$, 10, 48
        A$ = "Press A Key..."
        DRWSTRING 1, 15, 0, A$, 10, 64
        WHILE INKEY$ = ""
        WEND
        FILLSCREEN 0
        EXIT SUB
    END IF
 
    
    '*************************************************************************
    '* CHECK TO SEE IF THERE IS ENOUGH MEMORY FOR MULTIPLE PAGES
    '*************************************************************************
    NUMBANKS = WHICHMEM / 64
    XSIZE& = GETMAXX + 1
    YSIZE& = GETMAXY + 1
    BANKSPERPAGE& = XSIZE& * YSIZE& / 65536
    NUMPAGES = INT((NUMBANKS / BANKSPERPAGE&) - 1)

    '* LIMIT THE TOTAL NUMBER OF PAGES TO 3 (0-2) FOR THIS DEMO
    IF NUMPAGES > 2 THEN
        NUMPAGES = 2
    END IF

    IF NUMPAGES = 0 THEN
        FILLSCREEN 0
        SOUND 100, 5
        DRWSTRING 1, 7, 0, TITLE$, 10, 0
        A$ = "Sorry, This Video Card Does Not Have Enough Video"
        DRWSTRING 1, 7, 0, A$, 10, 16
        A$ = "Memory To Support Multiple Video Pages In This Mode."
        DRWSTRING 1, 7, 0, A$, 10, 32
        A$ = "Press A Key..."
        DRWSTRING 1, 15, 0, A$, 10, 48
        WHILE INKEY$ = ""
        WEND
        FILLSCREEN 0
        EXIT SUB
    END IF
    NUMOF = GETMAXX \ 6
    FILLSCREEN 0
    FOR PAGE = 0 TO NUMPAGES
        SETVIEW 0, 0, GETMAXX, GETMAXY
        DUMMY = PAGEACTIVE(PAGE)
        DUMMY = PAGEDISPLAY(0, 0, PAGE)
        FILLPAGE 0
        DRWSTRING 1, 7, 0, TITLE$, 10, 0
        A$ = "PAGEACTIVE(Page)"
        DRWSTRING 1, 7, 0, A$, 10, 16
        A$ = "PAGEDISPLAY(StartX,StartY,Page)"
        DRWSTRING 1, 7, 0, A$, 10, 32
        DRWBOX 1, 15, 0, 48, GETMAXX, GETMAXY
        A$ = "THIS IS PAGE" + STR$(PAGE)
        FOR I = 0 TO 20
            DRWSTRING 1, 12 + PAGE, 0, A$, 10, 50 + I * 16
        NEXT I
        SETVIEW 150, 58, GETMAXX - 10, GETMAXY - 10
        FOR I = 0 TO NUMOF
            X1 = RND * GETMAXX
            Y1 = RND * GETMAXY
            X2 = RND * 100
            Y2 = RND * 100
            C = RND * 15
            SELECT CASE PAGE
                CASE = 0
                    DRWFILLCIRCLE 1, C, X1, Y1, X2
                CASE = 1
                    DRWLINE 1, C, X1, Y1, X1 + X2, Y1 + Y2
                    DRWELLIPSE 1, C + 1, X1, Y1, X2 / 4, Y2 / 4
                CASE = 2
                    DRWFILLBOX 1, C, X1, Y1, X1 + X2, Y1 + Y2
            END SELECT
        NEXT I
        DRWBOX 1, 15, 150, 58, GETMAXX - 10, GETMAXY - 10
        SDELAY 35
    NEXT PAGE
    DUMMY = PAGEACTIVE(0)
    DUMMY = PAGEDISPLAY(0, 0, 0)

    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF
 
    FOR I = 0 TO 1
        FOR PAGE = 0 TO NUMPAGES
            DUMMY = PAGEDISPLAY(0, 0, PAGE)
            SDELAY 35
        NEXT PAGE
    NEXT I
    FOR I = 0 TO 20
        FOR PAGE = 0 TO NUMPAGES
            DUMMY = PAGEDISPLAY(0, 0, PAGE)
            SDELAY 1
        NEXT PAGE
    NEXT I
    DUMMY = PAGEDISPLAY(0, 0, 0)

    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        EXIT SUB
    END IF

 
    END SUB

    SUB DOTEXT (RET$)
    
    '*************************************************************************
    '* SET UP THE TITLE
    '*************************************************************************
    TITLE$ = "DEMO 6: Text functions"
    PALSET PAL(0), 0, 255

    '*************************************************************************
    '* SHOW ALTERNATE PRINT DIRECTIONS
    '*************************************************************************

    FILLSCREEN 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    DRWSTRING 1, 7, 0, TITLE$, 10, 0
    A$ = "DRWSTRING(Mode,ForeGndColr,BackGndColr,Text$,X,Y)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    A$ = "The Quick Brown Fox Jumped Over The Lazy Dog's Back! 0123456789"
    Colr = 16
    FOR Y = 32 TO GETMAXY STEP 20
        DRWSTRING 1, Colr, 0, A$, 0, Y
        Colr = Colr + 5
        IF Colr > 255 THEN
            Colr = 16
        END IF
    NEXT Y
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        FILLSCREEN 0
        EXIT SUB
    END IF

    FILLVIEW 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    A$ = "DRWSTRINGLT(Mode,ForeGndColr,BackGndColr,Text$,X,Y)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    A$ = "The Quick Brown Fox Jumped Over The Lazy Dog's Back! 0123456789"
    FOR X = 0 TO GETMAXX STEP 20
        DRWSTRINGLT 1, Colr, 0, A$, X, GETMAXY
        Colr = Colr + 5
        IF Colr > 255 THEN
            Colr = 16
        END IF
    NEXT X
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        FILLSCREEN 0
        EXIT SUB
    END IF

    FILLVIEW 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    A$ = "DRWSTRINGDN(Mode,ForeGndColr,BackGndColr,Text$,X,Y)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    A$ = "The Quick Brown Fox Jumped Over The Lazy Dog's Back! 0123456789"
    Colr = 16
    FOR Y = GETMAXY TO 32 STEP -20
        DRWSTRINGDN 1, Colr, 0, A$, GETMAXX, Y
        Colr = Colr + 5
        IF Colr > 255 THEN
            Colr = 16
        END IF
    NEXT Y
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        FILLSCREEN 0
        EXIT SUB
    END IF
    FILLVIEW 0
    SETVIEW 0, 0, GETMAXX, GETMAXY
    A$ = "DRWSTRINGRT(Mode,ForeGndColr,BackGndColr,Text$,X,Y)"
    DRWSTRING 1, 7, 0, A$, 10, 16
    SETVIEW 0, 32, GETMAXX, GETMAXY
    A$ = "The Quick Brown Fox Jumped Over The Lazy Dog's Back! 0123456789"
    FOR X = GETMAXX TO 0 STEP -20
        DRWSTRINGRT 1, Colr, 0, A$, X, 32
        Colr = Colr + 5
        IF Colr > 255 THEN
            Colr = 16
        END IF
    NEXT X
    GETKEY RET$
    IF (RET$ = "S") OR (RET$ = "Q") THEN
        SETVIEW 0, 0, GETMAXX, GETMAXY
        FILLSCREEN 0
        EXIT SUB
    END IF
    END SUB

 