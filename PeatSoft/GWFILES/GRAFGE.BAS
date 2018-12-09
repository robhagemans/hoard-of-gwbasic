1 '      *************
2 '      ** GRAFGEN **
3 '      *************
4 '
5 '      by Wes Meier
6 '      230 B Park Lake Circle
7 '      Walnut Creek, CA 94598
8 '
9 '      June/July 1982
10 '
11 '     Requires Color Adapter, BASICA,
12 '     and, optionally, IBM or Epson
13 '     (MX-80 or MX-100) equipped with
14 '     the GRAFTRAX ROMs.
15 '
16 KEY OFF
17 WIDTH 40
18 SCREEN 1,0
19 COLOR 1,0
20 DEFINT A-Z
21 DIM GRID (700),REDBOX (20), YELLOWBOX (17)
22 CLS
23 DEF FNGC(G,C)=(G-128)*8+C
24 DEF FNEXC(C)=2^(7-C)
25 Q$=CHR$(34)' Quote Marks
26 ' Set up graphics grid.
27 FOR X=0 TO 73 STEP 9
28 LINE (X,0)-(X,72),1
29 NEXT
30 FOR Y= 0 TO 73 STEP 9
31 LINE (0,Y)-(72,Y),1
32 NEXT
33 GET (0,0)-(72,72),GRID
34 CLS
35 ' Set up cursor.
36 LINE (2,2)-(7,7),2,BF
37 GET (1,1)-(8,8),REDBOX
38 CLS
39 ' Set up graphics block.
40 LINE (1,1)-(8,8),3,BF
41 GET (1,1)-(8,8),YELLOWBOX
42 GOSUB 45
43 GOTO 225
44 ' Set up Main Menu Key Vectors.
45 ON KEY(1) GOSUB 66
46 ON KEY(2) GOSUB 73
47 ON KEY(3) GOSUB 80
48 ON KEY(4) GOSUB 86
49 ON KEY(5) GOSUB 89
50 ON KEY(6) GOSUB 100
51 ON KEY(7) GOSUB 97
52 ON KEY(8) GOSUB 108
53 ON KEY(9) GOSUB 111
54 ON KEY(10) GOSUB 122
55 ON KEY(11) GOSUB 199
56 ON KEY(12) GOSUB 209
57 ON KEY(13) GOSUB 214
58 ON KEY(14) GOSUB 219
59 ' Turn on Key Trapping.
60 FOR X=1 TO 14
61 KEY (X) ON
62 NEXT
63 RETURN
64 ' Main Menu Key Subroutines
65 ' F1 Sub. Set Block.
66 T=PEEK(FNGC(GN,ROW))
67 IF T AND FNEXC(COL) THEN 71' Block already set.
68 PUT (COL*9+1,ROW*9+1),YELLOWBOX,PSET'Set block.
69 T=T+FNEXC(COL)
70 POKE(FNGC(GN,ROW)),T'Put it in memory.
71 RETURN
72 ' F2 Sub. Reset block.
73 T=PEEK(FNGC(GN,ROW))
74 IF (T AND FNEXC(COL))=0 THEN 71' Cell not set. Return.
75 PUT (COL*9+1,ROW*9+1),YELLOWBOX' Reset Block (XOR).
76 T=T-FNEXC(COL)
77 GOSUB 204' Put cursor there.
78 GOTO 70'Put in mem. and return.
79 ' F3 Sub. Fill grid.
80 K=255' All dots on.
81 FOR ROW=0 TO 7
82 POKE FNGC(GN,ROW),K
83 NEXT
84 RETURN 277
85 ' F4 Sub. Clear grid.
86 K=0' All dots off.
87 GOTO 81' Use fill routine.
88 ' F5 Sub. Fill Current column.
89 FOR ROW=0 TO 7
90 P=PEEK(FNGC(GN,ROW))
91 IF (P AND FNEXC(COL)) THEN 94
92 P=P+FNEXC(COL)
93 POKE FNGC(GN,ROW),P
94 NEXT
95 GOTO 84
96 ' F7 Sub. Fill Current Row.
97 POKE FNGC(GN,ROW),255
98 GOTO 84
99 ' F6 Sub. Reset Current Column.
100 FOR ROW=0 TO 7
101 P=PEEK (FNGC(GN,ROW))
102 IF (P AND FNEXC(COL))=0 THEN 105
103 P=P-FNEXC(COL)
104 POKE FNGC(GN,ROW),P
105 NEXT
106 GOTO 84
107 ' F8 Sub. Reset Current Row.
108 POKE FNGC(GN,ROW),0
109 GOTO 84
110 ' F9 Sub. Save Set on Disk.
111 CLS
112 LOCATE 12,1
113 INPUT "Enter Filespec ";FS$
114 IF LEN(FS$)>14 THEN BEEP:GOTO 111
115 PRINT"Is "Q$FS$Q$" correct (Y/N) ?";
116 A$=INKEY$:IF A$="" THEN 116
117 IF A$="Y" OR A$="y" OR A$=CHR$(13) THEN 119
118 IF A$="N" OR A$="n" OR A$="0" THEN 111 ELSE BEEP:GOTO 116
119 BSAVE FS$,0,1024
120 RETURN 249
121 ' F10 Sub. Select Alternate Menu.
122 RETURN 124
123 ' Set up Alternate Menu.
124 LINE (1,100)-(318,163),0,BF
125 LOCATE 14,13
126 PRINT"Alternate Menu"
127 LOCATE 15,3:PRINT"F1 Main Menu.      F2  Display Set."
128 LOCATE 16,3:PRINT"F3 Print Set.      F4  End Program."
129 ' Set up Alternate Menu Keys.
130 ON KEY (1) GOSUB 140
131 ON KEY (2) GOSUB 143
132 ON KEY (3) GOSUB 160
133 ON KEY (4) GOSUB 190
134 ' Turn off Keys 5-14.
135 FOR X=5 TO 14
136 KEY (X) OFF
137 NEXT
138 GOTO 138' Pressing the proper "F" key will break this loop.
139 ' F1 Sub. Return to Main Menu.
140 GOSUB 45' Restore Main Key Vectors.
141 RETURN 264
142 ' F2 Sub. Display Set on CRT.
143 CLS
144 FOR X=128 TO 255 STEP 3
145 FOR Y=0 TO 2
146 IF X+Y>255 THEN 148
147 PRINT"#";:PRINT USING "### = "+Q$+"!"+Q$+" ";X+Y;CHR$(X+Y);
148 NEXT:PRINT
149 IF X<>191 THEN 153
150 PRINT"Press any key to continue..."
151 A$=INKEY$
152 IF A$=""THEN 151
153 NEXT
154 PRINT"Press any key to continue..."
155 A$=INKEY$
156 IF A$="" THEN 155
157 CLS
158 GOTO 140
159 '
160 ' F3 Sub. Display Character Set on Printer.
161 ' This routine will function only
162 ' with an IBM or EPSON (MX-80 or 100)
163 ' equipped with the GRAFTRAX graphics
164 ' ROMS!!
165 ' Also, use this routine only if you
166 ' have IBM DOS Version 1.10. Version
167 ' 1.00 has a bug in its printer
168 ' I/O routine.
169 LPRINT CHR$(27)"@"' Reset Printer.
170 FOR X=128 TO 255 STEP 4
171  FOR Y=0 TO 3
172   IF Y+X>254 THEN 183
173   LPRINT "#";:LPRINT USING "### = "+Q$;X+Y;
174   LPRINT CHR$(27)"K"CHR$(8)CHR$(0);
175   FOR Z=0 TO 7
176    BYTE=0
177    FOR B=0 TO 7
178     IF PEEK(FNGC(X+Y,B)) AND FNEXC(Z) THEN BYTE=BYTE + FNEXC(B)
179    NEXT B
180   LPRINT CHR$(BYTE);
181   NEXT Z
182  LPRINT Q$SPACE$(3);
183  NEXT Y
184 LPRINT
185 NEXT X
186 LPRINT CHR$(12)
187 CLS
188 GOTO 140
189 ' F4 Sub. End Program.
190 CLS
191 RETURN 192
192 ' Turn Key Trapping off.
193 FOR X=1 TO 14
194 KEY (X) OFF
195 NEXT
196 END
197 ' Cursor Positioning Subroutines.
198 ' F11 Sub. Cursor Up.
199 IF ROW-1<0 THEN RETURN' At top of grid already.
200 GOSUB 204'XOR Cursor.
201 ROW=ROW-1'Go Up.
202 ' This Sub. erases cursor, if there,
203 ' or sets it, if not there.
204 PUT (COL*9+1,ROW*9+1),REDBOX
205 X=RND*6
206 PLAY"MBMSL64O=X;T255A"' Just for the fun of it.
207 RETURN
208 ' F12 Sub. Cursor Left.
209 IF COL-1<0 THEN RETURN' Already at left side of grid.
210 GOSUB 204' XOR Current cursor.
211 COL=COL-1' Go left.
212 GOTO 204' Set Cursor.
213 ' F13 Sub. Cursor Right.
214 IF COL+1>7 THEN RETURN
215 GOSUB 204
216 COL=COL+1
217 GOTO 204
218 ' F14 Sub. Cursor Down.
219 IF ROW+1>7 THEN RETURN
220 GOSUB 204
221 ROW=ROW+1
222 GOTO 204
223 'Point graphics vector to area just
224 'above BASICA in a 128K system.
225 DEF SEG=0' Point to Bottom of RAM.
226 POKE 124,0
227 POKE 125,0
228 POKE 126,PEEK(&H510)+1
229 POKE 127,PEEK(&H511)+16
230 'The vector at 0000:0510H-0511H points to the start of BASICA's
231 '64K segment.
232 '
233 'Point to Graphics table 64K+1 bytes
234 'above beginning of BASICA.
235 DEF SEG=256*PEEK(127)+PEEK(126)
236 CLS
237 LOCATE 12,1
238 PRINT"Do you want to load a previously saved"
239 PRINT"character set (Y/N) ?"
240 A$=INKEY$:IF A$="" THEN 240
241 IF A$="N" OR A$="n" OR A$="0" THEN 249
242 IF A$<>CHR$(13) AND A$<>"Y" AND A$<>"y" THEN BEEP:GOTO 240
243 INPUT "Enter filespec ";FS$
244 ON ERROR GOTO 246'Trap "File not found" error. ERR=53.
245 GOTO 248
246 IF ERR=53 THEN PRINT Q$FS$Q$" was not found.":BEEP:RESUME 243
247 ON ERROR GOTO 0' Crash if any other error.
248 BLOAD FS$,0
249 CLS
250 LOCATE 12,1
251 PRINT"Last Character number generated ="GN
252 X=GN
253 PRINT "Enter Character number to"
254 INPUT "generate (128-255)(EN=Next) ";GN
255 IF GN=0 THEN GN=X+1
256 IF GN<128 THEN GN=128
257 IF GN>255 THEN GN=255
258 IF GN<>255 THEN 263
259 PRINT
260 PRINT"CHR$(255) is always null and cannot be"
261 PRINT"modified."
262 GOTO 253
263 CLS
264 LOCATE 14,1
265 LINE (1,100)-(318,163),0,BF
266 LOCATE 14,3:PRINT"Use Arrow Keys to move Cursor."
267 LOCATE 15,3:PRINT"F1 Sets Dot.    F2  Resets Dot."
268 LOCATE 16,3:PRINT"F3 Fills Grid.  F4  Clears Grid."
269 LOCATE 17,3:PRINT"F5 Fills Col.   F6  Clears Col."
270 LOCATE 18,3:PRINT"F7 Fills Row.   F8  Clears Row."
271 LOCATE 19,3:PRINT"F9 Saves Set.   F10 Alternate Menu."
272 LOCATE 20,3:PRINT"Press Enter to Accept Character."
273 LINE (0,99)-(319,164),2,B
274 FOR X=0 TO 7
275 LINE(73,X*9+4)-(152,X*8+3),2
276 NEXT
277 PUT (0,0),GRID,PSET' Overwrite the existing grid.
278 FOR ROW=0 TO 7
279 P=PEEK(FNGC(GN,ROW))
280 IF P=0 THEN 284' Skip a blank row.
281 FOR COL=0 TO 7
282 IF P AND FNEXC(COL) THEN GOSUB 204:PUT(COL*9+1,ROW*9+1),YELLOWBOX
283 NEXT
284 NEXT
285 ROW=0
286 COL=0
287 PUT(1,1),REDBOX
288 GOTO 294
289 ROW=0
290 COL=0
291 PUT (0,0),GRID
292 PUT (1,1),REDBOX
293 REM *** Main Strobe Loop ***
294 LOCATE 12,1
295 PRINT"CHR$("RIGHT$(STR$(GN),3)") = "Q$CHR$(GN)Q$" ";
296 PRINT"STRING$(5,"RIGHT$(STR$(GN),3)") = "Q$STRING$(5,GN)Q$;
297 A$=INKEY$
298 IF A$=CHR$(13) THEN 249' "Enter" key? Get a new Character if so.
299 FOR X=0 TO 7
300 LOCATE X+1,20
301 PRINT"Byte"X"= "RIGHT$("0"+HEX$(PEEK(FNGC(GN,X))),2)
302 NEXT
303 GOTO 294
304 END ' of program.


