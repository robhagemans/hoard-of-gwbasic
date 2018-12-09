1 ' (PC)^3 Software Submission SCNMAP authored on February 4, 1983 by
2 '
3 ' Michael Csontos, 3228 Livonia Center Road, Lima, New York 14485
4 '
5 ' Copyright 1983 Michael Csontos
6 '
7 '  This program is made freely available non-exclusively to the Picture
8 '  City Personal Computer Programmers' Club for distribution to its members
9 '  and through software exchange to other users groups as long as credit is
10 ' given to the author and (PC)^3.
11 '
15 '
16 '
10000 CLS:SCREEN 0,0,0:WIDTH 80:KEY OFF:WIDTH "lpt1:",255:DEFINT A-Z
10100 PRINT "This program will cause the Epson printer (with script capability) to make
10200 PRINT "a form that can be used to lay-out screen formats for the IBM color-graphics
10300 PRINT "adapter card in the alpha-numeric mode in either the 40 or 80 column width.
10400 PRINT "You may choose either a blank form or one with each character position filled
10500 PRINT "with the address of the memory location corresponding to that position.
10600 PRINT
10700 PRINT "Do you want: 1) a blank 40 width form,
10800 PRINT " or          2) a filled 40 width form,
10900 PRINT " or          3) a blank 80 width form,
11000 PRINT " or          4) a filled 80 width form,
11100 PRINT " or          <Esc> to end the program.
11200 PRINT:PRINT "Please press 1, 2, 3, 4, or <Esc>.
11300 X$=INKEY$:IF X$="" THEN 11300 ELSE IF X$=CHR$(27) THEN 11700 ELSE A=VAL(X$)
11350 ON ERROR GOTO 11650
11400 IF A>4 OR A<1 THEN 11200
11500 IF A=1 OR A=2 THEN 11800
11600 IF A=3 OR A=4 THEN 14500
11650 RESUME
11700 CLS:KEY ON:END
11800 LPRINT CHR$(27)CHR$(64)CHR$(15)CHR$(27)CHR$(48)'reset;compressed;1/8" lines
11900 IF A=1 THEN LPRINT "Blank layout for screen graphics for the IBM Personal Computer Color Graphics Adapter Card in the 40 column width mode.":LPRINT:GOTO 12100
12000 LPRINT "Memory map of the screen graphics RAM for the IBM Personal Computer Color Graphics Adapter Card in the 40 column width A/N mode.":LPRINT
12100 LPRINT CHR$(27)CHR$(45)CHR$(1);:FOR L=25 TO 1 STEP -1:LPRINT USING "|  ##";L;:NEXT L:LPRINT CHR$(27)CHR$(45)CHR$(0)'underlined
12200 FOR M=1 TO 40
12300 LPRINT CHR$(27)CHR$(51)CHR$(1);'1/216" lines (effectively no LF)
12400 FOR N=1 TO 26:LPRINT CHR$(156);:LPRINT STRING$(4," ");:NEXT N:LPRINT
12500 IF A=1 THEN LPRINT:GOTO 12800
12600 LPRINT CHR$(27)CHR$(83)CHR$(1);'subscript
12700 FOR L=0 TO 24 STEP 1:LPRINT USING " ####";(80*(25-L))-(80-2*M+1)-1;:NEXT L:LPRINT
12800 LPRINT CHR$(27)CHR$(49)CHR$(27)CHR$(84)CHR$(27)CHR$(72)'7/72" lines;cancel script; cancel double strike;line feed
12900 LPRINT CHR$(27)CHR$(51)CHR$(1):LPRINT:LPRINT '1/216" lines (effectively no LF)
13000 LPRINT CHR$(27)CHR$(45)CHR$(1);'underline
13100 FOR N=1 TO 26:LPRINT CHR$(156);:LPRINT STRING$(4," ");:NEXT N:LPRINT USING "##";M
13200 LPRINT CHR$(27)CHR$(45)CHR$(0);'cancel underline
13300 IF A=1 THEN LPRINT:GOTO 13600
13400 LPRINT CHR$(27)CHR$(83)CHR$(0);'superscript
13500 FOR L=0 TO 24 STEP 1:LPRINT USING " ####";(80*(25-L))-(80-2*M)-1;:NEXT L:LPRINT
13600 LPRINT CHR$(27)CHR$(49)CHR$(27)CHR$(84)CHR$(27)CHR$(72) '7/72" lines;cancel script; cancel double strike;line feed
13700 NEXT M
13800 LPRINT CHR$(27)CHR$(65)CHR$(2)'line feed 2/72"
13900 FOR L=25 TO 1 STEP -1:LPRINT USING "|  ##";L;:NEXT L:LPRINT
14000 LPRINT CHR$(15)CHR$(27)CHR$(48);'compressed;1/8" lines
14100 IF A=1 THEN LPRINT:LPRINT "In the above chart each block represents a character (pel).":GOTO 14400
14200 LPRINT:LPRINT "In the above chart each block represents a character (pel). The upper number is the address of the character, the lower is the
14300 LPRINT "address of the attribute. To access these bytes in BASIC, use the instruction DEF SEG=&HB800 then PEEK(n) or POKE n,data.
14400 LPRINT CHR$(12);:ON ERROR GOTO 0:RUN
14500 C=80:R=25
14600 LPRINT CHR$(27)CHR$(64)CHR$(15)CHR$(27)CHR$(48)'reset;compressed;1/8" lines
14700 IF A=3 THEN LPRINT "Blank layout for screen graphics for the IBM Personal Computer Color Graphics Adapter Card in the 80 column width mode.":LPRINT:GOTO 14900
14800 LPRINT "Memory map of the screen graphics RAM for the IBM Personal Computer Color Graphics Adapter Card in the 80 column width A/N mode.":LPRINT
14900 LPRINT CHR$(27)CHR$(45)CHR$(1);:FOR L=25 TO 1 STEP -1:LPRINT USING "|  ##";L;:NEXT L:LPRINT CHR$(27)CHR$(45)CHR$(0);'underlined
15000 LPRINT CHR$(27)CHR$(65)CHR$(1)'1/72" lines
15100 FOR P=1 TO 5:LPRINT :NEXT P
15200 FOR M=1 TO C
15300 FOR N=1 TO R+1:LPRINT CHR$(156);:LPRINT STRING$(4," ");:NEXT N:LPRINT
15400 LPRINT CHR$(27)CHR$(83)CHR$(1);'subscript
15500 IF A=3 THEN FOR L=0 TO R-1 STEP 1:LPRINT "     ";:NEXT L:LPRINT USING "   ##";M:GOTO 15700
15600 FOR L=0 TO R-1 STEP 1:LPRINT USING " ####";(2*C*(R-L))-(2*C-2*M+1)-1;:NEXT L:LPRINT USING "   ##";M
15700 LPRINT CHR$(27)CHR$(84)CHR$(27)CHR$(72);'cancel script; cancel double strike
15800 LPRINT CHR$(27)CHR$(45)CHR$(1);'underline
15900 FOR N=1 TO R+1:LPRINT CHR$(156);:LPRINT STRING$(4," ");:NEXT N:LPRINT "_"
16000 LPRINT CHR$(27)CHR$(45)CHR$(0);'cancel underline
16100 LPRINT CHR$(27)CHR$(83)CHR$(0);'superscript
16200 FOR P=1 TO 5:LPRINT:NEXT P
16300 LPRINT CHR$(27)CHR$(84)CHR$(27)CHR$(72);'cancel script; cancel double strike
16400 NEXT M
16500 FOR P=1 TO 6:LPRINT:NEXT P
16600 LPRINT CHR$(15)CHR$(27)CHR$(48);'reset;compressed;1/8" lines
16700 FOR L=R TO 1 STEP -1:LPRINT USING "|  ##";L;:NEXT L:LPRINT
16800 IF A=3 THEN LPRINT:LPRINT "In the above chart each block represents a character (pel).":GOTO 17100
16900 LPRINT:LPRINT "In the above chart each block represents a character (pel). The number is the address of the character, add one to this number for
17000 LPRINT "the address of the attribute. To access these bytes in BASIC, use the instruction DEF SEG=&HB800 then PEEK(n) or POKE n,data.
17100 LPRINT CHR$(12);:ON ERROR GOTO 0:RUN
17200 '         SAVE"scnmap.bas",a
n DEF SEG=&H