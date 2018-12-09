60 'Author: Richard Kelly	05/27/2001	E-Mail: Newson@37.com
61 '
62 'This Public Domain release should work fine with GW-BASIC, BASICA,
63 'Q-BASIC, QuickBASIC, PDS, and FirstBASIC.
64 '
65 'The program simply changes readable text into an "encoded" format.
66 'This is great for "hiding" data in adventure games or in DRAW
67 'commands.  Just to make it harder to "translate", the B$ string is
68 'always written backwards.  I could have "scrambled" the characters
69 'around as well, but it was simpler and faster to do it the way it is
70 'now.
71 '
72 'The subroutine in Line 2000 will encode all the text in A$, and the
73 'subroutine in Line 2010 will decode A$.  The altered string is stored
74 'in B$, and A$ remains unchanged.
75 '
76 'The routine is made for standard text messages and DRAW string commands.
77 'The program will *not* work properly with characters above a particular
78 'ASC value, so special symbols like CHR$(250) which are *not* used in
79 'standard text shouldn't be used with this program as is.  Sorry.
80 '
81 'The easiest way to use this program for your own purposes is to create
82 'a program that READs the data into string arrays, make a FOR/NEXT loop,
83 'have A$ equal each string of the array called in the FOR loop, call Line
84 '2000, and write B$ to the data file after Line 2000 has RETURNed.  The
85 'program you distribute to the public would have a similar FOR/LOOP,
86 'only that you'd call Line 2010 first, and have the string array equal B$.
87 '
88 'For those of you who *don't* want to have your data encoded into a
89 'separate file when you release it, just make the encoded file, use MS
90 'Edit, "Copy" the data from the data file to the Clipboard, load your
91 'BASIC file, and then "Paste" the data in there. You can then access the
92 'data by using READ statements.  If you do this, make absolute certain
93 'that you're not going to try to change *any* of the data you choose to
94 'encode, or you'll either have to write it back to a file again and
95 'decode it, or translate the string yourself one character at a time.  :-(
96 '
1000 CLS:PRINT"If you don't want people examining your game data and figuring out things that":PRINT"you don't want them to know, then check this program out.":PRINT
1001 A$="Use letters, numbers (1, 5, 2, ect.), & symbols and this program will encode    them."
1002 PRINT A$:GOSUB 2000:PRINT B$:PRINT
1010 A$="ú‚◊é”“›—”“é€œ‡’›‡ﬁé”÷‚é÷—‚œÂéÂ›º"
1011 GOSUB 2010:PRINT A$:PRINT B$:PRINT
1020 PRINT"Now *you* type in something to encode.":PRINT
1021 LINE INPUT"Go on, now.  ";A$:IF A$=""THEN 1021
1022 GOSUB 2000:PRINT B$:PRINT:PRINT"Thanks for giving this program a try.":PRINT:END:RUN
2000 B$="":FOR L=1 TO LEN(A$):A=ASC(MID$(A$,L,1)):A=A+110:B$=CHR$(A)+B$:NEXT:RETURN
2010 B$="":FOR L=1 TO LEN(A$):A=ASC(MID$(A$,L,1)):A=A-110:B$=CHR$(A)+B$:NEXT:RETURN

