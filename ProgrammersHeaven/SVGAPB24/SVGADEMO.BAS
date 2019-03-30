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


    $LINK "SVGAPB.PBL"
    $INCLUDE "SVGAPB.BI"

    DEFINT A-Z

    DIM POINTARRY3D(13) AS SHARED P3Dtype
    DIM PLAYARRY(13) AS SHARED P3Dtype
    DIM PLOTARRY(13) AS SHARED P2DType
    DIM OPLOTARRY(13) AS SHARED P2DType
    DIM DYNAMIC GFXBLK1(10000) AS SHARED INTEGER
    DIM DYNAMIC GFXBLK2(32000) AS SHARED INTEGER
    DIM DYNAMIC GFXBLK3(32000) AS SHARED INTEGER
    DIM MAGMOUSECURSOR(386) AS SHARED BYTE
    DIM BIGMOUSECURSOR(386) AS SHARED BYTE
    DIM STWMOUSECURSOR(386) AS SHARED BYTE
    DIM PAL(255) AS SHARED RGBType
    DIM PAL2(255) AS SHARED RGBType
    DIM ORGPAL(255) AS SHARED RGBType
    DIM PCXPAL(255) AS SHARED RGBType
    
    $INCLUDE "SVGADEMO.BI"
    $INCLUDE "SVGAMOD1.BAS"
    $INCLUDE "SVGAMOD2.BAS"
    

    '*************************************************************************
    '* SAVE THE STARTING VIDEOMODE AND SET IT TO MODE 3.
    '*************************************************************************
    STARTVIDEOMODE = VIDEOMODEGET
    DUMMY = RESTEXT
    CLS
    FOR A = 0 TO 33
        DUMMY$ = INKEY$  '* CLEAR THE KEYBOARD BUFFER
    NEXT A

    '*************************************************************************
    '* MOVE THE DOS CURSOR TO THE TOP LEFT TO START THE PROGRAM AND SAY HELLO
    '*************************************************************************
    LOCATE 1, 15
    PRINT "'SVGAPB' A Super VGA Graphics Librarys for use with"

    LOCATE 2, 19
    PRINT "Power Basic Inc's Power BASIC 3.00c and later"

    LOCATE 4, 10
    PRINT "Copyright 1993-1995 by Stephen L. Balkum and Daniel A. Sill"
    LOCATE 12, 25
    PRINT "Demonstration/Example Program"
    LOCATE 23, 1
    PRINT "Press a key to begin the demo..."
    GETKEY (RET$)
    CLS

    '*************************************************************************
    '* LET'S ID THE PROCESSOR FIRST AS THE LIBRARY REQUIRES A 386 OR BETTER.
    '*************************************************************************
    'LOCATE 1, 1
    CPU = WHICHCPU
    CPU$ = STR$(CPU)
    L = LEN(CPU$)
    CPU$ = RIGHT$(CPU$, L - 1)
    IF CPU < 386 THEN
        PRINT "Sorry, this library requires a 80386 or better processor."
        PRINT "Processor is identified as a 80"; CPU$; "."
        PRINT "Demo program will be terminated."
        PRINT
        PRINT "Press a key..."
        SOUND 100, 5
        WHILE INKEY$ = ""
        WEND
        VIDEOMODESET STARTVIDEOMODE
    END
    END IF

    '*************************************************************************
    '* LET'S ID THE VIDEO CARD/CHIP AS THE LIBRARY REQUIRES A SUPERVGA ADAPTER.
    '*************************************************************************
    VGA = WHICHVGA
    PRINT "Microprocessor is identified as a 80"; CPU$; "."
    PRINT
    SELECT CASE VGA
        CASE = 1
            VGA$ = "Acumos AVGA2/3 SuperVGA"
        CASE = 2
            VGA$ = "ATI Technologies 18/28/38/68800 SuperVGA"
        CASE = 3
            VGA$ = "Ahead V5000 ver A SuperVGA"
        CASE = 4
            VGA$ = "Ahead V5000 ver B SuperVGA"
        CASE = 5
            VGA$ = "Chips and Technologies 82C450/1/2/3/5/6/7 SuperVGA"
        CASE = 6
            VGA$ = "Cirrus Logic CL-GD 5xx,6xx,28xx,54xx,62xx SuperVGA"
        CASE = 7
            VGA$ = "Everex Ev236/6xx Micro Enhancer SuperVGA"
        CASE = 8
            VGA$ = "Genoa 61/62/63/64/6600 SuperVGA"
        CASE = 9
            VGA$ = "NCR 77C21/22/22E/22E+ SuperVGA"
        CASE = 10
            VGA$ = "Oak Technologies OTI-037C/067/077/087 SuperVGA"
        CASE = 11
            VGA$ = "Paradise/Western Digital PVGA1A,WD90C00/1x/2x/3x SuperVGA"
        CASE = 12
            VGA$ = "Realtek RT3106 SuperVGA"
        CASE = 13
            VGA$ = "Trident 8800CS,8900B/C/CL/CX,90x0 SuperVGA"
        CASE = 14
            VGA$ = "Tseng Labs ET3000-AX/BX/BP SuperVGA"
        CASE = 15
            VGA$ = "Tseng Labs ET4000/W32/W32I SuperVGA"
        CASE = 16
            VGA$ = "VESA compatible SuperVGA"
        CASE = 17
            VGA$ = "Video 7 HT-208/16 SuperVGA"
        CASE = 18
            VGA$ = "Avance Logic AL2101 SuperVGA"
        CASE = 19
            VGA$ = "MXIC MX68000/10 SuperVGA"
        CASE = 20
            VGA$ = "Primus P2000 SuperVGA"
        CASE ELSE
            VGA$ = "Unknown"
            VGA = 0
    END SELECT
    IF VGA < 1 THEN
        PRINT "Sorry, unable to identify video card or it is not a SuperVGA video adapter."
        PRINT "Demo program will be terminated."
        PRINT
        PRINT "Press a key..."
        SOUND 100, 5
        WHILE INKEY$ = ""
        WEND
        PRINT "VGA=";VGA
        VIDEOMODESET STARTVIDEOMODE
        END
    ELSE
        PRINT "Video card/chip is identified as a "; VGA$; "."
    END IF

    '*************************************************************************
    '* LET'S SEE THE HOW MUCH MEMORY IS INSTALLED ON THE SUPER VGA ADAPTER.
    '*************************************************************************
    VIDEOMEMORY = WHICHMEM
    MEM$ = STR$(VIDEOMEMORY)
    MEM$ = RIGHT$(MEM$, LEN(MEM$) - 1) + " kB"
    IF VIDEOMEMORY < 1 THEN
        PRINT "Sorry, unable to identify the amount of installed video memory."
        PRINT "Demo program will be terminated."
        PRINT
        PRINT "Press a key..."
        SOUND 100, 5
        WHILE INKEY$ = ""
        WEND
        VIDEOMODESET STARTVIDEOMODE
        END
    ELSE
        PRINT "Installed video memory identified as "; MEM$; "."
    END IF

    '*************************************************************************
    '* LET'S TELL THE USER WHAT THE HIGHEST RESOLUTION THAT THE VIDEO CARD
    '* AND ITS INSTALLED MEMORY CARD IS CAPABLE OF. THE MONITOR MUST BE ABLE
    '* TO SUPPORT THOSE MODES TOO !
    '*************************************************************************
    PRINT "Video card and installed memory is capable of the following resolutions:"
    SELECT CASE VIDEOMEMORY
        CASE > 2047
            PRINT TAB(4); "320x200 in 256 colors"
            PRINT TAB(4); "640x400 in 256 colors"
            PRINT TAB(4); "640x480 in 256 colors"
            PRINT TAB(4); "800x600 in 256 colors"
            PRINT TAB(4); "1024x768 in 256 colors"
            PRINT TAB(4); "1280x1024 in 256 colors"
            MAXVAL = 5
        CASE > 1023
            PRINT TAB(4); "320x200 in 256 colors"
            PRINT TAB(4); "640x400 in 256 colors"
            PRINT TAB(4); "640x480 in 256 colors"
            PRINT TAB(4); "800x600 in 256 colors"
            PRINT TAB(4); "1024x768 in 256 colors"
            MAXVAL = 4
        CASE > 511
            PRINT TAB(4); "320x200 in 256 colors"
            PRINT TAB(4); "640x400 in 256 colors"
            PRINT TAB(4); "640x480 in 256 colors"
            PRINT TAB(4); "800x600 in 256 colors"
            MAXVAL = 3
        CASE ELSE
            PRINT TAB(4); "320x200 in 256 colors"
            PRINT TAB(4); "640x400 in 256 colors"
            MAXVAL = 1
    END SELECT
    PRINT
    PRINT "PLEASE keep in mind that not all monitors support all resolutions."
    PRINT "If you know your monitor will not work properly in certain resolutions"
    PRINT "(such as 1024x768 or 1280x1024), do NOT run the demo in that resolution."
    PRINT

    '*************************************************************************
    '* LET'S LOOK FOR A MOUSE. IF WE FIND ONE, TELL ALL ABOUT IT
    '*************************************************************************
    MOUSE = WHICHMOUSE
    IF MOUSE > 0 THEN
        MOUSEINFO MJV, MNV, TP, I
        VER$ = STR$(MNV)
        L = LEN(VER$)
        VER$ = STR$(MJV) + "." + RIGHT$(VER$, L - 1)
        VER$ = "Software driver version is" + VER$ + " (Microsoft equivalent version)."
        SELECT CASE TP
            CASE = 1
                MTYPE$ = "bus mouse"
            CASE = 2
                MTYPE$ = "serial mouse"
            CASE = 3
                MTYPE$ = "Inport mouse"
            CASE = 4
                MTYPE$ = "PS/2 mouse"
            CASE = 5
                MTYPE$ = "HP mouse"
            CASE ELSE
                MTYPE$ = "unknown type"
        END SELECT
        PRINT "Microsoft compatible " + MTYPE$ + " detected with" + STR$(MOUSE) + " buttons on IRQ" + STR$(I) + "."
        PRINT VER$
    ELSE
        PRINT "No Microsoft compatible mouse detected."
    END IF
    PRINT

    '*************************************************************************
    '* LET'S LOOK FOR JOYSTICKS
    '*************************************************************************
    JOYSTICK = WHICHJOYSTICK
    SELECT CASE JOYSTICK
        CASE = -1
            A$ = "No joystick port detected or no joystick BIOS support present."
        CASE = 0
            A$ = "No joystick detected."
        CASE = 1
            A$ = "Joystick A is present and available."
        CASE = 2
            A$ = "Joystick B is present and available."
        CASE = 3
            A$ = "Both Joystick A and Joystick B are present and available."
    END SELECT
    PRINT A$
    PRINT
    PRINT "Press a key..."
    GETKEY RET$

    '*************************************************************************
    '* LET'S GET DOWN TO BUSINESS!
    '*************************************************************************
    RES = 1
    ENDIT = 0

    '*************************************************************************
    '* INIT ALTERNATE MOUSE CURSORS
    '*************************************************************************
    FOR I = 0 TO 385
        READ MAGMOUSECURSOR(I)
    NEXT I
    FOR I = 0 TO 385
        READ BIGMOUSECURSOR(I)
    NEXT I
    FOR I = 0 TO 385
        READ STWMOUSECURSOR(I)
    NEXT I

    '*************************************************************************
    '* INIT ALTERNATE COLOR PALETTES
    '*************************************************************************
    DUMMY = RES320
    PALGET ORGPAL(0), 0, 255
    PALCOPY ORGPAL(0), PAL(0), 0, 255
    PALCOPY ORGPAL(0), PAL2(0), 0, 255
    MYPI! = 8 * ATN(1) / 240
    FOR Colr = 0 TO 239
        R1 = 32 + SIN((Colr + 0) * MYPI!) * 31
        G1 = 32 + SIN((Colr + 80) * MYPI!) * 31
        B1 = 32 + SIN((Colr + 160) * MYPI!) * 31
        R2 = 32 + SIN((Colr + 10) * MYPI!) * 31
        G2 = 32 + SIN((Colr + 30) * MYPI!) * 31
        B2 = 32 + SIN((Colr + 50) * MYPI!) * 31
        OFFSET = Colr + 16
        PAL(OFFSET).R = R1  '* RED
        PAL(OFFSET).G = G1  '* GREEN
        PAL(OFFSET).B = B1  '* BLUE
        PAL2(OFFSET).R = R2  '* RED
        PAL2(OFFSET).G = G2  '* GREEN
        PAL2(OFFSET).B = B2  '* BLUE
    NEXT Colr
    DUMMY = RESTEXT

    '*************************************************************************
    '* HERE IS THE MAIN SELECTOR LOOP
    '*************************************************************************
    WHILE ENDIT = 0
        RetVal$ = ""
        CLS
        SOUND 700, .75
        SELECT CASE RES
            CASE = 1
                RES$ = "320x200x256"
            CASE = 2
                RES$ = "640x400x256"
            CASE = 3
                RES$ = "640x480x256"
            CASE = 4
                RES$ = "800x600x256"
            CASE = 5
                RES$ = "1024x768x256"
            CASE = 6
                RES$ = "1280x1024x256"
        END SELECT
        PRINT "Please select the demo you would like to see in the " + RES$ + " resolution:"
        PRINT
        PRINT "(0)  Exit This Program"
        PRINT
        PRINT "(1)  Demo #1  The Primitive Drawing Routines"
        PRINT "(2)  Demo #2  The Clipping Capabilities"
        PRINT "(3)  Demo #3  The Fill Routines"
        PRINT "(4)  Demo #4  The Palette Routines"
        PRINT "(5)  Demo #5  The Block Routines"
        PRINT "(6)  Demo #6  The Text Routines"
        PRINT "(7)  Demo #7  The Scrolling And Paging Routines"
        PRINT "(8)  Demo #8  The PCX Routines"
        PRINT "(9)  Demo #9  The Mouse Routines"
        PRINT "(10) Demo #10 The Joystick Routines"
        PRINT "(11) Demo #11 The Two Dimensional Routines"
        PRINT "(12) Demo #12 The Three Dimensional Routines"
        PRINT "(13) The Grand Tour Of All Demos"
        SELECT CASE VIDEOMEMORY
            CASE > 2047
                PRINT "(14) Use 320x200x256  Resolution"
                PRINT "(15) Use 640x400x256  Resolution"
                PRINT "(16) Use 640x480x256  Resolution"
                PRINT "(17) Use 800x600x256  Resolution"
                PRINT "(18) Use 1024x768x256 Resolution"
                PRINT "(19) Use 1280x1024x256 Resolution"
                MAXVAL = 19
            CASE > 1023
                PRINT "(14) Use 320x200x256  Resolution"
                PRINT "(15) Use 640x400x256  Resolution"
                PRINT "(16) Use 640x480x256  Resolution"
                PRINT "(17) Use 800x600x256  Resolution"
                PRINT "(18) Use 1024x768x256 Resolution"
                MAXVAL = 18
            CASE > 511
                PRINT "(14) Use 320x200x256  Resolution"
                PRINT "(15) Use 640x400x256  Resolution"
                PRINT "(16) Use 640x480x256  Resolution"
                PRINT "(17) Use 800x600x256  Resolution"
                MAXVAL = 17
            CASE ELSE
                PRINT "(14) Use 320x200x256  Resolution"
                PRINT "(15) Use 640x400x256  Resolution"
                MAXVAL = 15
        END SELECT
        A$ = ""
        INPUT "Your Choice"; A$
        KY = VAL(A$)
        IF (A$ > "9") OR (A$ < "0") THEN
            KY = -1
        END IF
        IF KY > MAXVAL THEN
            KY = -1
        END IF
        IF KY > 0 AND KY < 13 THEN
            SELECT CASE RES
                CASE = 1
                    OK = RES320
                CASE = 2
                    OK = RES640L
                CASE = 3
                    OK = RES640
                CASE = 4
                    OK = RES800
                CASE = 5
                    OK = RES1024
                CASE = 6
                    OK = RES1280
            END SELECT
            IF OK <> 1 THEN
                DUMMY = RESTEXT
                CLS
                SOUND 100, 5
                PRINT "Sorry, although your video card has enough memeory, it does"
                PRINT "not support this video mode. PRESS A KEY."
                GETKEY RET$
                KY = -1
            END IF
        END IF
        SELECT CASE KY
            CASE = 0
                ENDIT = 1
            CASE = 1
                'DEMO #1
                DOPRIMS RetVal$
                DUMMY = RESTEXT
            CASE = 2
                'DEMO #2
                DOCLIP RetVal$
                DUMMY = RESTEXT
            CASE = 3
                'DEMO #3
                DOFILL RetVal$
                DUMMY = RESTEXT
            CASE = 4
                'DEMO #4
                DOPAL RetVal$
                DUMMY = RESTEXT
            CASE = 5
                'DEMO #5
                DOBLOCK RetVal$
                DUMMY = RESTEXT
            CASE = 6
                'DEMO #6
                DOTEXT RetVal$
                DUMMY = RESTEXT
            CASE = 7
                'DEMO #7
                DOSCROLL RetVal$
                DUMMY = RESTEXT
            CASE = 8
                'DEMO #8
                DOPCX RetVal$
                DUMMY = RESTEXT
            CASE = 9
                'DEMO #9
                DOMOUSE RetVal$
                DUMMY = RESTEXT
            CASE = 10
                'DEMO #10
                DOJOYSTICK RetVal$
                DUMMY = RESTEXT
            CASE = 11
                'DEMO #11
                DO2D RetVal$
                DUMMY = RESTEXT
            CASE = 12
                'DEMO #12
                DO3D RetVal$
                DUMMY = RESTEXT
            CASE = 13
                'DO THE GRAND TOUR OF ALL DEMOS!
                CLS
                PRINT "Press 'Q' To End Grand Tour At Any Time. Press 'S' To Skip To The Next"
                PRINT "Demo At Any Time. Press Any Other Key to Begin The Grand Tour..."
                GETKEY RET$
                IF RET$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF

                SELECT CASE RES
                    CASE = 1
                        OK = RES320
                    CASE = 2
                        OK = RES640L
                    CASE = 3
                        OK = RES640
                    CASE = 4
                        OK = RES800
                    CASE = 5
                        OK = RES1024
                    CASE = 6
                        OK = RES1280
                END SELECT
                IF OK <> 1 THEN
                    DUMMY = RESTEXT
                    CLS
                    SOUND 100, 5
                    PRINT "Sorry, although your video card has enough memeory, it does"
                    PRINT "not support this video mode. PRESS A KEY."
                    GETKEY RET$
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #1
                DOPRIMS RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #2
                DOCLIP RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #3
                DOFILL RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #4
                DOPAL RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #5
                DOBLOCK RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #6
                DOTEXT RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #7
                DOSCROLL RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #8
                DOPCX RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #9
                DOMOUSE RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #10
                DOJOYSTICK RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #11
                DO2D RetVal$
                IF RetVal$ = "Q" THEN
                    GOTO EXITGRANDTOUR
                END IF
                'DEMO #12
                DO3D RetVal$
EXITGRANDTOUR:
                RetVal$ = ""
                DUMMY = RESTEXT
            CASE = 14
                RES = 1
            CASE = 15
                RES = 2
            CASE = 16
                RES = 3
            CASE = 17
                RES = 4
            CASE = 18
                RES = 5
            CASE = 19
                RES = 6
            CASE ELSE
                SOUND 100, 5
        END SELECT
        IF RetVal$ = "Q" THEN
            ENDIT = 1
        END IF
    WEND

    '*************************************************************************
    '* THAT'S ALL FOLKS! END THE PROGRAM
    '*************************************************************************
    DUMMY = RESTEXT '* FORCE THE VGA PALETTE TO RESET
    VIDEOMODESET STARTVIDEOMODE '*RESTORE THE VIDEOMODE WE STARTED IN
    DUMMY = RESTEXT '* FORCE THE VGA PALETTE TO RESET
    CLEAR
    END


    '*************************************************************************
    '* DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA DATA
    '*************************************************************************

    REM *MAGNIFIER MOUSE CURSOR DATA
    DATA 7,6
    DATA 255,255,255,255,255,7  ,7  ,7  ,7  ,255,255,255,255,255,255,255
    DATA 255,255,255,  7,  7,255,255,255,255,7  ,7,  255,255,255,255,255
    DATA 255,255,7  ,255,255,255,255,255,255,255,255,7  ,255,255,255,255
    DATA 255,7  ,255,255,255,255,255,255,255,255,255,255,7  ,255,255,255
    DATA 255,7  ,255,255,255,255,255,255,255,255,255,255,7  ,255,255,255
    DATA 7  ,255,255,255,255,255,255,255,255,255,255,255,255,7  ,255,255
    DATA 7  ,255,255,255,255,255,255,255,255,255,255,255,255,7  ,255,255
    DATA 7  ,255,255,255,255,255,255,255,255,255,255,255,255,7  ,255,255
    DATA 7  ,255,255,255,255,255,255,255,255,255,255,255,255,7  ,255,255
    DATA 255,7  ,255,255,255,255,255,255,255,255,255,255,7  ,255,255,255
    DATA 255,7  ,255,255,255,255,255,255,255,255,255,255,7  ,255,255,255
    DATA 255,7  ,7  ,255,255,255,255,255,255,255,255,7  ,7  ,255,255,255
    DATA 255,255,7  ,7  ,7  ,255,255,255,255,7  ,7  ,7  ,255,255,255,255
    DATA 255,255,255,7  ,7  ,7  ,7  ,7  ,7  ,8  ,8  ,255,255,255,255,255
    DATA 255,255,255,255,255,7  ,7  ,7  ,7  ,7  ,8  ,8  ,255,255,255,255
    DATA 255,255,255,255,255,255,255,255,255,7  ,8  ,8  ,255,255,255,255
    DATA 255,255,255,255,255,255,255,255,255,255,7  ,8  ,8  ,255,255,255
    DATA 255,255,255,255,255,255,255,255,255,255,7  ,8  ,8  ,255,255,255
    DATA 255,255,255,255,255,255,255,255,255,255,255,7  ,8  ,8  ,255,255
    DATA 255,255,255,255,255,255,255,255,255,255,255,7  ,8  ,8  ,255,255
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,7  ,8  ,8  ,255
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,7  ,8  ,8  ,255
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,255,7  ,8  ,8
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,255,7  ,7  ,7

    REM *BIG ARROW MOUSE CURSOR DATA
    DATA 1,1
    DATA 0  ,0  ,0  ,255,255,255,255,255,255,255,255,255,255,255,255,255
    DATA 0  ,15 ,15 ,0  ,0  ,255,255,255,255,255,255,255,255,255,255,255
    DATA 0  ,15 ,15 ,15 ,15 ,0  ,0  ,0  ,255,255,255,255,255,255,255,255
    DATA 0  ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,0  ,0  ,255,255,255,255,255,255
    DATA 0  ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,0  ,0  ,0  ,255,255,255
    DATA 0  ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,0  ,0  ,255
    DATA 0  ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,0  ,255
    DATA 0  ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,0  ,0  ,255,255
    DATA 0  ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,0  ,255,255,255,255
    DATA 0  ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,0  ,0  ,255,255,255,255,255
    DATA 0  ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,15 ,0  ,255,255,255,255,255,255
    DATA 0  ,15 ,15 ,15 ,15 ,15 ,0  ,15 ,15 ,15 ,0  ,255,255,255,255,255
    DATA 0  ,15 ,15 ,15 ,15 ,0  ,0  ,15 ,15 ,15 ,0  ,255,255,255,255,255
    DATA 0  ,15 ,15 ,0  ,0  ,255,255,0  ,15 ,15 ,15 ,0  ,255,255,255,255
    DATA 0  ,15 ,0  ,255,255,255,255,0  ,15 ,15 ,15 ,0  ,255,255,255,255
    DATA 0  ,0  ,255,255,255,255,255,255,0  ,15 ,15 ,15 ,0  ,255,255,255
    DATA 255,255,255,255,255,255,255,255,255,0  ,15 ,15 ,15 ,0  ,255,255
    DATA 255,255,255,255,255,255,255,255,255,0  ,15 ,15 ,15 ,0  ,255,255
    DATA 255,255,255,255,255,255,255,255,255,255,0  ,15 ,15 ,15 ,0  ,255
    DATA 255,255,255,255,255,255,255,255,255,255,255,0  ,15 ,15 ,15 ,0
    DATA 255,255,255,255,255,255,255,255,255,255,255,0, 15  ,15 ,15 ,0
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,0  ,15 ,15 ,0
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,255,0  ,0  ,0
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255

    REM *STOPWATCH MOUSE CURSOR DATA
    DATA 8,11
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
    DATA 255,255,255,255,255,255,15 ,15 ,15 ,15 ,255,255,255,255,255,255
    DATA 255,255,255,255,255,255,15 ,15 ,15 ,15 ,255,255,255,255,255,255
    DATA 255,255,255,255,255,255,255,15 ,15 ,255,255,255,255,255,255,255
    DATA 255,255,255,255,255,255,15 ,15 ,15 ,15 ,255,255,255,255,255,255
    DATA 255,255,255,255,15 ,15 ,15 ,7  ,7  ,15 ,15 ,15 ,255,255,255,255
    DATA 255,255,255,15 ,15 ,7  ,7  ,7  ,7  ,7  ,7  ,15 ,15 ,255,255,255
    DATA 255,255,15 ,15 ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,15 ,15 ,255,255
    DATA 255,15 ,15 ,7  ,0  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,15 ,15 ,255
    DATA 255,15 ,7  ,7  ,7  ,0  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,15 ,255
    DATA 15 ,15 ,7  ,7  ,7  ,7  ,0  ,7  ,7  ,7  ,0  ,0  ,7  ,7  ,15 ,15
    DATA 15 ,7  ,7  ,7  ,7  ,7  ,7  ,0  ,0  ,0  ,7  ,7  ,7  ,7  ,7  ,15
    DATA 15,7   ,7  ,7  ,7  ,7  ,7  ,0  ,0  ,7  ,7  ,7  ,7  ,7  ,7  ,15
    DATA 15,15  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,15 ,15
    DATA 255,15 ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,15 ,255
    DATA 255,15 ,15 ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,15 ,15 ,255
    DATA 255,255,15 ,15 ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,7  ,15 ,15 ,255,255
    DATA 255,255,255,15 ,15 ,7  ,7  ,7  ,7  ,7  ,7  ,15 ,15 ,255,255,255
    DATA 255,255,255,255,15 ,15 ,15 ,7  ,7  ,15 ,15 ,15 ,255,255,255,255
    DATA 255,255,255,255,255,255,15 ,15 ,15 ,15 ,255,255,255,255,255,255
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
    DATA 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255


    SUB GETKEY (KEYP$)

    '*************************************************************************
    '* THIS ROUTINE WAITS FOR A KEY STROKE
    '*************************************************************************
    FOR A = 0 TO 7 '* CLEAR THE KBD BUFFER
        A$ = INKEY$
    NEXT A
    SOUND 700, .75
    A$ = ""
    WHILE A$ = ""
        A$ = INKEY$
        IF A$ = "q" THEN
            A$ = "Q"
        END IF
        IF A$ = "s" THEN
            A$ = "S"
        END IF
    WEND
    KEYP$ = A$
    END SUB

 