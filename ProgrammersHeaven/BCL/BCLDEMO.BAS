'  **************************************************************************
'  **                                                                      **
'  **                   BARCODES-LITE (REV 1.0.0) 11/1993                  **
'  **                                                                      **
'  **************************************************************************
'  **                    PROPRIETARY SOFTWARE STATEMENT                    **
'  **************************************************************************
'  **                                                                      **
'  **   GRAFTech Development Corporation grants you a non-exclusive,       **
'  **   non-transferable license to use this copy of the program and       **
'  **   accompanying documentation according to the terms of the           **
'  **   software license agreement.                                        **
'  **                                                                      **
'  **   In the event you elect to modify, customize or change part of      **
'  **   this program, this proprietary statement must remain a part of     **
'  **   the altered program, in no event and under no circumstances may    **
'  **   this statement be removed without the prior express written        **
'  **   consent of GRAFTech Development Corporation.                       **
'  **                                                                      **
'  **   This program along with any alterations you may elect to make      **
'  **   remains the sole property of GRAFTech Development Corporation.     **
'  **                                                                      **
'  **   Copyright (c) 1988-93 - GRAFTech Development Corporation           **
'  **     All Rights Reserved                                              **
'  **                                                                      **
'  **************************************************************************
'
'
'  PROGRAM TITLE:  Bar Code Developers Library - Lite (Demonstration)
'
'
' ******************************************************************************
' **                                                                          **
' **                                                                          **
' ** BCLITE (BCL.DATA$) - COMPOUND VARIABLE DEFINITION                        **
' **                                                                          **
' **                                                                          **
' ******************************************************************************
' **                                                                          **
' **                                                                          **
' **  VARIABLE: BCL.DATA$ (LEN=41)                                            **
' **                                                                          **
' **                                                                          **
' ******************************************************************************
' **                                                                          **
' **                                                                          **
' **                                                            POSITION      **
' **  INFORMATION                              LENGTH        FIRST     LAST   **
' **                                                                          **
' **                                                                          **
' ******************************************************************************
' **                                                                          **
' **                                                                          **
' **  PRINTER IDENTIFICATION                      3           001       003   **
' **    [E01] EPSON 9 PIN ESC/P                                               **
' **            60/120/240 x 216 dpi                                          **
' **    [E02] EPSON 24 PIN ESC/P2                                             **
' **            180 x 180 dpi                                                 **
' **    [I01] IBM GRAPHICS                                                    **
' **            60/120/240 x 180 dpi                                          **
' **    [O01] OKIDATA OKIGRAPHICS                                             **
' **            60/120/240 x 144 dpi                                          **
' **                                                                          **
' **  PRINT DENSITY                               1           004       004   **
' **    [S] SINGLE DENSITY                                                    **
' **    [D] DOUBLE DENSITY                                                    **
' **    [Q] QUAD DENSITY                                                      **
' **                                                                          **
' **  HORIZONTAL SPACING                          3           005       007   **
' **    [0] THRU [132]                                                        **
' **                                                                          **
' **  RESERVED FOR FUTURE USE                     1           008       008   **
' **                                                                          **
' **  BAR CODE HEIGHT                             1           009       009   **
' **    [0] - 1 LINE HEIGHT (NO LINE FEED AND NO HEADER)                      **
' **    [1] - 1 LINE HEIGHT (WITH LINE FEED)                                  **
' **    [2] - 2 LINE HEIGHT (WITH LINE FEED)                                  **
' **    [3] - 3 LINE HEIGHT (WITH LINE FEED)                                  **
' **    [4] - 4 LINE HEIGHT (WITH LINE FEED)                                  **
' **    [5] - 5 LINE HEIGHT (WITH LINE FEED)                                  **
' **    [6] - 6 LINE HEIGHT (WITH LINE FEED)                                  **
' **    [7] - 7 LINE HEIGHT (WITH LINE FEED)                                  **
' **    [8] - 8 LINE HEIGHT (WITH LINE FEED)                                  **
' **    [9] - 9 LINE HEIGHT (WITH LINE FEED)                                  **
' **                                                                          **
' **  BAR CODE HEADER                             1           010       010   **
' **    [T] PRINT BAR CODE HEADER ABOVE BAR CODE                              **
' **    [B] PRINT BAR CODE HEADER BELOW BAR CODE                              **
' **    [N] DO NOT PRINT BAR CODE HEADER                                      **
' **                                                                          **
' **  BAR CODE SYMBOLOGY CODE                     1           011       011   **
' **    [1] SYMBOLOGY UPC VERSION A                                           **
' **    [2] SYMBOLOGY UPC VERSION E                                           **
' **    [3] SYMBOLOGY UPC/EAN/IAN - 13                                        **
' **    [4] SYMBOLOGY UPC/EAN/IAN - 8                                         **
' **    [5] SYMBOLOGY INTERLEAVED 2 OF 5 - COMMERCIAL LENGTH                  **
' **    [6] SYMBOLOGY INTERLEAVED 2 OF 5 - VARIABLE                           **
' **    [7] SYMBOLOGY CODE 3 OF 9 - NO CHECK DIGIT                            **
' **    [8] SYMBOLOGY CODE 3 OF 9 - CHECK DIGIT                               **
' **    [9] SYMBOLOGY CODE 128 - SERIES "A"                                   **
' **                                                                          **
' **  BAR CODE DATA                              28           012       039   **
' **    ANY VALID CHARACTERS FOR SPECIFIED                                    **
' **      BAR CODE SYMBOLOGY                                                  **
' **                                                                          **
' **  BAR CODE CHECK DIGIT                        1           040       040   **
' **    CALCULATED BY BARCODES-LITE AND RETURNED                              **
' **      TO CALLING PROGRAM                                                  **
' **                                                                          **
' **  BAR CODE ERROR STATUS CODE                  1           041       041   **
' **    CALCULATED BY BARCODES-LITE AND RETURNED                              **
' **      TO CALLING PROGRAM                                                  **
' **    [0] NO ERROR OCCURED                                                  **
' **    [1] INVALID PRINTER IDENTIFICATION SELECTED                           **
' **    [2] INVALID DENSITY SELECTION OR NOT AVAILABLE ON SELECTED PRINTER    **
' **    [3] INVALID HORIZONTAL SPACING SELECTED                               **
' **    [4] INVALID BAR CODE HEIGHT SELECTED                                  **
' **    [5] INVALID BAR CODE HEADER SELECTED                                  **
' **    [6] INVALID BAR CODE TYPE SELECTED                                    **
' **    [7] INVALID BAR CODE DATA CHARACTERS                                  **
' **    [8] INVALID BAR CODE DATA LENGTH                                      **
' **    [9] RESERVED FOR FUTURE USE                                           **
' **                                                                          **
' **    THE FOLLOWING AVAILABLE FOR COMPILERS THAT ALLOW LOCAL ERROR TRAPPING **
' **                                                                          **
' **    [A] DEVICE TIMEOUT                                                    **
' **    [B] DEVICE FAULT                                                      **
' **    [C] DEVICE OUT OF PAPER                                               **
' **    [D] DEVICE LUN NOT OPENED                                             **
' **    [E] DEVICE I/O ERROR                                                  **
' **    [F] DEVICE UNAVAILABLE                                                **
' **    [G] DEVICE COMMUNICATIONS BUFFER OVERFLOW                             **
' **    [P] DEVICE ERROR - UNKNOWN ORIGIN                                     **
' **    [V] DEVICE ERROR - DISK FULL                                          **
' **    [W] DEVICE ERROR - PERMISSION DENIED                                  **
' **    [X] DEVICE ERROR - DISK NOT READY                                     **
' **    [Y] DEVICE ERROR - DISK MEDIA ERROR                                   **
' **    [Z] APPLICATION ERROR OF UNKNOWN ORIGIN                               **
' **                                                                          **
' **                                                                          **
' ******************************************************************************
'
'
'
    DECLARE SUB BCLITE (BCL.DATA$, BCL.LUN)
'
' >>>>>> OPEN PRINTER ON FILE NUMBER ONE <<<<<<
'
    BCL.LUN = 1                            ' SET PRINTER LOGICAL UNIT NUMBER
    WIDTH "LPT1:", 255                     ' SET PRINTER PORT FOR CONTINUOUS
    OPEN "LPT1:BIN" FOR OUTPUT AS BCL.LUN  ' OPEN PRINTER IN BINARY MODE
'
' >>>>>> DEMONSTRATION SCREEN DISPLAY <<<<<<
'
    TP$ = CHR$(16) + CHR$(32) + CHR$(32) + CHR$(32)
    CLS
    GOSUB F001
    GOSUB F002
    GOSUB F003
    '
ENTRY1:
    '
    COLOR 1, 7
    LOCATE 17, 1: PRINT SPACE$(80);
    LOCATE 17, 5: PRINT "Enter [T]arget Printer, [P]rint, [R]egistration Benefits or [E]nd:";
    LOCATE 17, 73:
    DO: A$ = INKEY$: LOOP UNTIL A$ <> ""
    A$ = UCASE$(A$)
    LOCATE 17, 73: PRINT A$;
    IF A$ = "E" THEN GOTO SAMPLE.END
    IF A$ = "R" THEN GOSUB F004
    IF A$ = "T" THEN
        IF CHR$(16) = MID$(TP$, 1, 1) THEN
            TP$ = CHR$(32) + CHR$(16) + CHR$(32) + CHR$(32)
            GOTO ENTRY2
        END IF
        IF CHR$(16) = MID$(TP$, 2, 1) THEN
            TP$ = CHR$(32) + CHR$(32) + CHR$(16) + CHR$(32)
            GOTO ENTRY2
        END IF
        IF CHR$(16) = MID$(TP$, 3, 1) THEN
            TP$ = CHR$(32) + CHR$(32) + CHR$(32) + CHR$(16)
            GOTO ENTRY2
        END IF
        IF CHR$(16) = MID$(TP$, 4, 1) THEN
            TP$ = CHR$(16) + CHR$(32) + CHR$(32) + CHR$(32)
            GOTO ENTRY2
        END IF
ENTRY2:    
        GOSUB F003
    END IF
    IF A$ = "P" THEN GOSUB SAMPLE
    GOTO ENTRY1
'
' >>>>>> SET FIXED CALL ARGUMENT ELEMENTS <<<<<<
'
SAMPLE:
    '
    BCL.DATA$ = SPACE$(41)
    IF CHR$(16) = MID$(TP$, 1, 1) THEN
        MID$(BCL.DATA$, 1, 3) = "E01"      ' SET PRINTER IDENTIFICAITON
    END IF
    IF CHR$(16) = MID$(TP$, 2, 1) THEN
        MID$(BCL.DATA$, 1, 3) = "E02"      ' SET PRINTER IDENTIFICAITON
    END IF
    IF CHR$(16) = MID$(TP$, 3, 1) THEN
        MID$(BCL.DATA$, 1, 3) = "I01"      ' SET PRINTER IDENTIFICAITON
    END IF
    IF CHR$(16) = MID$(TP$, 4, 1) THEN
        MID$(BCL.DATA$, 1, 3) = "O01"      ' SET PRINTER IDENTIFICAITON
    END IF
    MID$(BCL.DATA$, 4, 1) = "D"            ' SET PRINT DENSITY
    MID$(BCL.DATA$, 5, 3) = "043"          ' SET PRINT INDENT
    MID$(BCL.DATA$, 8, 1) = " "            ' RESERVED FOR FUTURE USE
    MID$(BCL.DATA$, 9, 1) = "0"            ' SET PRINT HEIGHT
    MID$(BCL.DATA$, 10, 1) = "N"           ' SET HEADER CODE
'
' >>>>>> DEMONSTRATION BAR CODE PRINT <<<<<<
'
    GOSUB PAGE.HEADER
    MID$(BCL.DATA$, 11, 1) = "1"           ' SET SYMBOLOGY
    MID$(BCL.DATA$, 12, 28) = "78211300045                 "
    MID$(BCL.DATA$, 40, 1) = " "           ' SET CHECK DIGIT
    MID$(BCL.DATA$, 41, 1) = " "           ' RESET ERROR CODE
    GOSUB BAR.HEADER
    MID$(BCL.DATA$, 11, 1) = "2"
    MID$(BCL.DATA$, 12, 28) = "02820000895                 "
    MID$(BCL.DATA$, 40, 1) = " "
    MID$(BCL.DATA$, 41, 1) = " "
    GOSUB BAR.HEADER
    MID$(BCL.DATA$, 11, 1) = "3"
    MID$(BCL.DATA$, 12, 28) = "078211300045                "
    MID$(BCL.DATA$, 40, 1) = " "
    MID$(BCL.DATA$, 41, 1) = " "
    GOSUB BAR.HEADER
    MID$(BCL.DATA$, 11, 1) = "4"
    MID$(BCL.DATA$, 12, 28) = "2664345                     "
    MID$(BCL.DATA$, 40, 1) = " "
    MID$(BCL.DATA$, 41, 1) = " "
    GOSUB BAR.HEADER
    MID$(BCL.DATA$, 11, 1) = "5"
    MID$(BCL.DATA$, 12, 28) = "1078211300054               "
    MID$(BCL.DATA$, 40, 1) = " "
    MID$(BCL.DATA$, 41, 1) = " "
    GOSUB BAR.HEADER
    MID$(BCL.DATA$, 11, 1) = "6"
    MID$(BCL.DATA$, 12, 28) = "10782113054                 "
    MID$(BCL.DATA$, 40, 1) = " "
    MID$(BCL.DATA$, 41, 1) = " "
    GOSUB BAR.HEADER
    MID$(BCL.DATA$, 11, 1) = "7"
    MID$(BCL.DATA$, 12, 28) = "30501                       "
    MID$(BCL.DATA$, 40, 1) = " "
    MID$(BCL.DATA$, 41, 1) = " "
    GOSUB BAR.HEADER
    MID$(BCL.DATA$, 11, 1) = "8"
    MID$(BCL.DATA$, 12, 28) = "30501                       "
    MID$(BCL.DATA$, 40, 1) = " "
    MID$(BCL.DATA$, 41, 1) = " "
    GOSUB BAR.HEADER
    MID$(BCL.DATA$, 11, 1) = "9"
    MID$(BCL.DATA$, 12, 28) = "ABC123                      "
    MID$(BCL.DATA$, 40, 1) = " "
    MID$(BCL.DATA$, 41, 1) = " "
    GOSUB BAR.HEADER
    GOSUB PAGE.FOOTER
    RETURN
    '
PAGE.HEADER:
    '
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, "     ³³Û³³³Û³³ GRAFTech's"
    PRINT #BCL.LUN, "     ³³Û³³³Û³³ BARCODES-LITE Developers Library"
    PRINT #BCL.LUN, "     ³³Û³³³Û³³ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    PRINT #BCL.LUN, "     ³³Û³³³Û³³ The Next Generation Of Business Software"
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, "     With BARCODES-LITE, creating professional bar code applications can"
    PRINT #BCL.LUN, "     be as simple as deciding where you want bar codes and placing a few"
    PRINT #BCL.LUN, "     simple program statements into your existing application programs."
    PRINT #BCL.LUN, "     There's no special hardware to buy and no arcane control sequences"
    PRINT #BCL.LUN, "     to learn.  Supporting hundreds of printers, BARCODES-LITE helps you"
    PRINT #BCL.LUN, "     create professional, high-performance business applications, fast."
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, "     Bar Code Symbology                    Bar Code Specimen";
    RETURN
    '
BAR.HEADER:
    '
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, SPC(5);
    IF MID$(BCL.DATA$, 11, 1) = "1" THEN PRINT #BCL.LUN, "UPC Version A";
    IF MID$(BCL.DATA$, 11, 1) = "2" THEN PRINT #BCL.LUN, "UPC Version E";
    IF MID$(BCL.DATA$, 11, 1) = "3" THEN PRINT #BCL.LUN, "UPC/EAN/IAN-13";
    IF MID$(BCL.DATA$, 11, 1) = "4" THEN PRINT #BCL.LUN, "UPC/EAN/IAN-8";
    IF MID$(BCL.DATA$, 11, 1) = "5" THEN PRINT #BCL.LUN, "Interleaved 2 of 5 - Commercial";
    IF MID$(BCL.DATA$, 11, 1) = "6" THEN PRINT #BCL.LUN, "Interleaved 2 of 5 - Variable";
    IF MID$(BCL.DATA$, 11, 1) = "7" THEN PRINT #BCL.LUN, "Code 3 of 9 - No Check Digit";
    IF MID$(BCL.DATA$, 11, 1) = "8" THEN PRINT #BCL.LUN, "Code 3 of 9 - With Check Digit";
    IF MID$(BCL.DATA$, 11, 1) = "9" THEN PRINT #BCL.LUN, "Code 128 - Series 'A'";
'
' >>>>>> CALL BAR CODE LIBRARY <<<<<<
'
    CALL BCLITE(BCL.DATA$, BCL.LUN)
'
' >>>>>> VERIFY RETURN ERROR CODE <<<<<<
'
'   IF "0" <> MID$(BCL.DATA$, 41, 1) THEN GOTO xxxx
'
    RETURN
    '
PAGE.FOOTER:
    '
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, "     BARCODES-LITE . . ."
    PRINT #BCL.LUN, "          The Professionals Choice For Professional Bar Code Development."
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, ""
    PRINT #BCL.LUN, " Copyright (c) 1988-93 - GRAFTech Development Corporation - All Rights Reserved"
    PRINT #BCL.LUN, CHR$(12);
    RETURN
    '
F001:
    '
    COLOR 15, 1
    LOCATE 1, 1: PRINT SPACE$(80);
    LOCATE 1, 2: PRINT DATE$;
    LOCATE 1, 26: PRINT "BARCODES-LITE Demonstration"
    LOCATE 1, 72: PRINT TIME$;
    COLOR 1, 7
    FOR X = 2 TO 23
        LOCATE X, 1: PRINT SPACE$(80);
    NEXT X
    COLOR 15, 1
    LOCATE 24, 1: PRINT SPACE$(80);
    LOCATE 24, 1: PRINT " Copyright (c) 1988-93 - GRAFTech Development Corporation - All Rights Reserved";
    RETURN
    '
F002:
    '
    COLOR 1, 7
    LOCATE 3, 3: PRINT "³³Û³³³Û³³ GRAFTech's";
    LOCATE 4, 3: PRINT "³³Û³³³Û³³ BARCODES-LITE Developers Library";
    LOCATE 5, 3: PRINT "³³Û³³³Û³³ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ";
    LOCATE 6, 3: PRINT "³³Û³³³Û³³ The Next Generation Of Business Software";
    LOCATE 10, 5: PRINT "Target Printer";
    LOCATE 12, 10: PRINT "Epson and Compatibles";
    LOCATE 13, 10: PRINT "Epson 24 Pin ESC/P2 and Compatibles";
    LOCATE 14, 10: PRINT "IBM and Compatibles";
    LOCATE 15, 10: PRINT "Okidata (OKI Graphics) and Compatibles";
    LOCATE 20, 3: PRINT "BARCODES-LITE is a shareware program.  You are granted the right to use this";
    LOCATE 21, 3: PRINT "program for a period of 30 days for evaluation and testing.  Registration is";
    LOCATE 22, 3: PRINT "easy, simply complete the included registration form and mail to GRAFTech.";
    RETURN
    '
F003:
    '
    LOCATE 12, 8: PRINT MID$(TP$, 1, 1);
    LOCATE 13, 8: PRINT MID$(TP$, 2, 1);
    LOCATE 14, 8: PRINT MID$(TP$, 3, 1);
    LOCATE 15, 8: PRINT MID$(TP$, 4, 1);
    RETURN
    '
F004:
    '
    PCOPY 0, 1
    GOSUB F001
    COLOR 1, 7
    LOCATE 3, 3: PRINT "³³Û³³³Û³³ GRAFTech's";
    LOCATE 4, 3: PRINT "³³Û³³³Û³³ BARCODES-LITE Developers Library";
    LOCATE 5, 3: PRINT "³³Û³³³Û³³ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ";
    LOCATE 6, 3: PRINT "³³Û³³³Û³³ The Next Generation Of Business Software";
    LOCATE 8, 3: PRINT "BENEFITS OF REGISTRATION . . .";
    LOCATE 9, 5: PRINT "Printed Manual";
    LOCATE 10, 5: PRINT "Complete Source Coding";
    LOCATE 11, 5: PRINT "Notification Of Updates";
    LOCATE 12, 5: PRINT "Discounted Hardware and Software Offers";
    LOCATE 13, 5: PRINT "  (Notification as Available)";
    LOCATE 14, 5: PRINT "Royalty Free Distribution of Developed Applications";
    LOCATE 16, 3: PRINT "SOURCE COMPATIBILITY . . .";
    LOCATE 17, 5: PRINT "Microsoft QBASIC";
    LOCATE 18, 5: PRINT "Microsoft QuickBASIC";
    LOCATE 19, 5: PRINT "Microsoft BASIC Professional Development System";
    LOCATE 20, 5: PRINT "Microsoft VisualBASIC for DOS";
    LOCATE 21, 5: PRINT ". . . and, portable to other BASICs";
    LOCATE 23, 48: PRINT "Press Any Key To Continue . . .";
    DO: A$ = INKEY$: LOOP UNTIL A$ <> ""
    PCOPY 1, 0
    RETURN
    '
SAMPLE.END:
    '
    COLOR 7, 0
    CLS
    LOCATE 1, 1: PRINT "Thank you for trying BARCODES-LITE Developers Library!";
    END

