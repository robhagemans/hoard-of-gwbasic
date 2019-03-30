'**********************************************************
BEGIN DEF
'**********************************************************
    #INCLUDE ffblk.h
    SUB CMDELE(a$,x%)
    SUB CUTEXT(a$,x%)
    SUB GETEXT(a$)
    SUB CUTNAM(a$)
    COMMON ret$
    DIM ele$[3]
    DIM tempele$[3]
'**********************************************************
BEGIN CODE
'**********************************************************
START:
    PRINT "Text to HTML converter.\n\n"
    tail$ = CMDLINE
    FOR i% = 1 TO 3
        CALL CMDELE(tail$,i%)
        ele$[i%] = ret$
        tempele$[i%] = ret$
    NEXT i%
' Rearrange elements so that the switches are in ele$[3]
' First if switches are in ele$[1] put ele$[1] in ele$[3],
' ele$[2] in ele$[1], ele$[3] in ele$[2]. Use a temp array.
    m$ = LEFT(ele$[1],1)
    IF m$ = "/" THEN
        ele$[3] = tempele$[1]
        ele$[2] = tempele$[3]
        ele$[1] = tempele$[2]
        ENDIF
' Next check if switches are in ele$[2]. If so, put ele$[2]
' in ele$[3], ele$[3] in ele$[2], leave ele$[1] where it is.
    m$ = LEFT(ele$[2],1)
    IF m$ = "/" THEN
        ele$[3] = tempele$[2]
        ele$[2] = tempele$[3]
        ENDIF
' If switches are in ele$[3], Leave it alone.
' Next, Check if ele$[1] is blank, if so show the help screen.
    IF ele$[1] = "" THEN
        GOTO HELP
        ENDIF
' Next, Get the extension from each element.
    FOR i% = 1 TO 3
        CALL GETEXT(ele$[i%])
        tempele$[i%] = ret$
    NEXT i%
' Now we'll see if there is no extension. If not, add the
' appropiate extension. .TXT for ele$[1] .HTM for ele$[2]
    IF tempele$[1] = "" THEN
        ele$[1] = ele$[1] + ".TXT"
        ENDIF
    IF tempele$[2] = "" THEN
        ele$[2] = ele$[2] + ".HTM"
        ENDIF
' Check to see if ele$[1] exists. If so get its full name.
    i% = FEXIST(ele$[1],7)
    IF i% = FALSE THEN
        SOUNDON 880
         DELAY 5
          SOUNDOFF
        PRINT "Could not find file: " + ele$[1] + "\n\n"
        GOTO HELP
        ENDIF
    ele$[1] = FTRUENAME(ele$[1])
    ele$[1] = UCASE(ele$[1])
' Now lets cut off the extension. If ele$[2] is blank then
' well add .HTM to the end of tempele$[1]
    FOR i% = 1 TO 3
        CALL CUTEXT(ele$[i%],0)
        tempele$[i%] = ret$
    NEXT i%
    IF tempele$[2] = "" THEN
        ele$[2] = tempele$[1] + ".HTM"
        ENDIF
'Let's do the same with the paths.
    FOR i% = 1 TO 3
        CALL CUTNAM(ele$[i%])
        tempele$[i%] = ret$
    NEXT i%
    IF tempele$[2] = "" THEN
        ele$[2] = tempele$[1] + ele$[2]
        ENDIF
' Yeeee Ha! All the filename manipulation is done.
'           ele$[1] = Full path of source file.
'           ele$[2] = Full path of object file.
'           ele$[3] = Switches
' We could warn the user if object file exists.
' What the heck, let's do it.
    i% = FEXIST(ele$[2],7)
    IF i% = TRUE THEN
        SOUNDON 880
         DELAY 5
          SOUNDOFF
        PRINT "File: " + ele$[2] + " Exists!\n"
        PRINT "Will not overwrite.\n"
        PRINT "Run this program again giving object a different name.\n\n"
        GOTO HELP
        ENDIF
    scenter% = 0
    sbreak% = 0
    sfixed% = 0
    spara% = 0
' Now let's work with the switches.
    IF ele$[3] <> "" THEN
        elen% = LEN(ele$[3])
        FOR i% = 1 to elen%
            m$ = MID(ele$[3],i%,1)
            IF m$ = "C" THEN
                scenter% = 1
                ENDIF
            IF m$ = "B" THEN
                sbreak% = 1
                ENDIF
            IF m$ = "F" THEN
                sfixed% = 1
                ENDIF
            IF m$ = "P" THEN
                spara% = 1
                ENDIF
        NEXT i%
        ENDIF
'Now to the files.
'Open both files. Source for readonly. Object for writeonly.
    hr% = FOPEN(ele$[1],readonly)
    hw% = FOPEN(ele$[2],writeonly)
    q$ = CHR(34)
' First lets write the HTML header.
    FPRINT(hw%,"<HTML>\n<HEAD>\n")
    FPRINT(hw%,"<TITLE>\n    " + ele$[2] + "\n</TITLE>\n</HEAD>\n")
    FPRINT(hw%,"<!--  This file was created with TXT2HTM.EXE       -->\n")
    FPRINT(hw%,"<!--  A text to HTML converter,created with        -->\n")
    FPRINT(hw%,"<!--  the MoonRock compiler. You can find MoonRock -->\n")
    FPRINT(hw%,"<!--  at http://www.rowan.sensation.net.au/        -->\n")
    FPRINT(hw%,"<!--  To obtain TXT2HTM.EXE write to               -->\n")
    FPRINT(hw%,"<!--  rbtmdl@email.com                             -->\n")
    FPRINT(hw%,"<BODY bgcolor=" + q$ + "#FFFFFF" + q$)
    FPRINT(hw%," text=" + q$ + "#000000" + q$ + ">\n")
    IF sfixed% = 0 THEN
        FPRINT(hw%,"<FONT FACE=" + q$ + "arial" + q$ + ">\n")
    ELSE
        FPRINT(hw%,"<FONT FACE=" + q$ + "courier" + q$ + ">\n"
    ENDIF
    IF scenter% <> 0 THEN
        FPRINT(hw%,"<CENTER>\n")
        ENDIF
    p% = 0
    ef% = FEOF(hr%)
    WHILE ef% = FALSE
        FINPUT(hr%,a$)
        a$ = LTRIM(a$)
        IF a$ = "" THEN
            IF p% = 0 THEN
                p% = 1
                IF spara% = 0 THEN
                    a$ = "<P>"
                    ENDIF
                ENDIF
        ELSE
            p% = 0
            ENDIF
        IF a$ <> "" THEN
            IF a$ <> "<P>" THEN
                IF sbreak% = 0 THEN
                    a$ = a$ + "<BR>"
                    ENDIF
                ENDIF
            ENDIF
        IF a$ <> "" THEN
            a$ = a$ + "\n"
            ENDIF

        FPRINT(hw%,a$)
    ef% = FEOF(hr%)
    WEND
    IF scenter% <> 0 THEN
        FPRINT(hw%,"</CENTER>\n")
        ENDIF
    FPRINT(hw%,"</FONT>\n")
' Now let print the end of the file.
    FPRINT(hw%,"</BODY>\n</HTML>\n")
    FCLOSE(hr%)
    FCLOSE(hw%)
    PRINT "File: " + ele$[2] + " created successfully.\n\n"
    GOTO ENDIT
HELP:
    PRINT "USAGE: TXT2HTM source [object] [/switches]\n\n"
    PRINT "SWITCHES:\n"
    PRINT "C   Center all text.\n"
    PRINT "B   Disable line breaks after each line of text.\n"
    PRINT "F   Use fixed font.(courier)\n"
    PRINT "P   Disable paragraph tags.\n\n"
    PRINT "EXAMPLE:\n"
    PRINT "TXT2HTM test.txt /fp\n\n"
    PRINT "This program supports drag and drop.\n\n"
ENDIT:
    END
'**********************************************************
'*                        SUBS                            *
'**********************************************************
SUB CMDELE(a$,x%)
    ret$ = ""
    a$ = LTRIM(a$)
    c% = 1
    alen% = LEN(a$)
    FOR i% = 1 TO alen%
        m$ = MID(a$,i%,1)
        IF m$ = " " THEN
            c% = c% + 1
            ENDIF
        IF c% = x% THEN
            IF m$ <> " " THEN
                ret$ = ret$ + m$
                ENDIF
            ENDIF
   NEXT i%
   ret$ = UCASE(ret$)
END SUB
'**********************************************************
SUB CUTEXT(a$,x%)
    ret$ = ""
    a$ = LTRIM(a$)
    c% = 0
    alen% = LEN(a$)
    FOR j% = 1 TO alen%
        IF x% = 0 THEN
            i% = j%
        ELSE
            i% = alen% - j% + 1
            ENDIF
        m$ = MID(a$,i%,1)
        IF m$ = "." THEN
            IF x% = 0 THEN
                c% = 1
                ENDIF
            ENDIF
        IF c% <> 1 THEN
            ret$ = ret$ + m$
            ENDIF
    NEXT j%
    ret$ = UCASE(ret$)
END SUB
'**********************************************************
SUB GETEXT(a$)
    ret$ = ""
    a$ = LTRIM(a$)
    c% = 0
    alen% = LEN(a$)
    FOR i% = 1 TO alen%
        m$ = MID(a$,i%,1)
        IF m$ = "." THEN
            c% = 1
            ENDIF
        IF c% <> 0 THEN
            ret$ = ret$ + m$
            ENDIF
    NEXT i%
    ret$ = UCASE(ret$)
END SUB
'**********************************************************
SUB CUTNAM(a$)
    ret$ = ""
    a$ = UCASE(a$)
    c% = 0
    alen% = LEN(a$)
    FOR i% = 1 TO alen%
        m$ = MID(a$,i%,1)
        IF m$ = "\\" THEN
            c% = i%
            ENDIF
    NEXT i%
    IF c% <> 0 THEN
        ret$ = LEFT(a$,c%)
        ENDIF
END SUB
'**********************************************************
