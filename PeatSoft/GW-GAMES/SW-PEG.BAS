1 '           *** SWITCH *** 
2 '     by Wes Meier (70215,1017) 
3 ' 
4 '     Written 3/12/82 
5 ' 
6 '     This Program Requires BASICA, the Color Adapter Card, 
7 '     and an 80 Column Monitor. Light Pen Operation is Supported. 
8 ' 
9 SCREEN 0,1 
10 KEY OFF 
11 WIDTH 80 
12 COLOR 6,1,1 
13 LOCATE ,,0,0,6 
14 CLS 
15 CLEAR ,,5000 
16 DEF SEG = 0 
17 POKE &H417,96  
18 ' Set Set Upper Case and All Numbers. 
19 DEF SEG 
20 DEFINT B-Z 
21 DEFSTR A 
22 DIM PEG(11) 
23 PEN ON 
24 ON PEN GOSUB 129 
25 GOSUB 33 
26 TOPPEG$ = "  " + CHR$(220) + "  " 
27 BOTPEG$ = CHR$(220) + STRING$(3,219) + CHR$(220) 
28 XANSTIMER = 25 
29 ' Use 250 for compiler. 
30 GOTO 141 
31 '-------------- Subroutines -------------- 
32 'Initialize Pegs Values Subroutine 
33 FOR X = 1 TO 5 
34   PEG(X) = - 1 ' Red 
35   PEG(X + 6) = 1 'Green 
36 NEXT 
37 PEG(6) = 0 ' Slot Empty 
38 RETURN 
39 '------------------------------------------- 
40 'Capitalize Character Subroutine. 
41 'Input and Output is AX($). 
42 IF AX > = "a" AND AX < = "z" THEN AX = CHR$( ASC(AX) - 32) 
43 RETURN 
44 '------------------------------------------ 
45 'Blinking Cursor Subroutine. 
46 'Output is ANS($). 
47 LL = CSRLIN 
48 TT = POS(0) 
49 LOCATE LL,TT 
50 PRINT CHR$(219); 
51 FOR SNA = 0 TO XANSTIMER 
52   ANS = INKEY$ 
53   IF ANS < > "" THEN SNA = XANSTIMER + 1 
54 NEXT 
55 IF ANS < > "" THEN 64 
56 LOCATE LL,TT 
57 PRINT "?"; 
58 FOR SNA = 0 TO XANSTIMER 
59   ANS = INKEY$ 
60   IF ANS < > "" THEN SNA = XANSTIMER + 1 
61 NEXT 
62 IF ANS < > "" THEN 64 
63 GOTO 49 
64 AX = ANS 
65 GOSUB 42 
66 ANS = AX 
67 LOCATE LL,TT 
68 PRINT ANS; 
69 RETURN 
70 '------------------------------------------ 
71 'Draw Box at Line L Subroutine 
72 LOCATE L,1 
73 PRINT CHR$(201); 
74 GOSUB 96 
75 PRINT CHR$(187); 
76 FOR X0 = 1 TO 4 
77   PRINT CHR$(186); 
78   LOCATE ,80 
79   PRINT CHR$(186); 
80 NEXT 
81 PRINT CHR$(200); 
82 GOSUB 96 
83 PRINT CHR$(188) 
84 T = 4 
85 FOR X = 65 TO 75 
86   LOCATE L + 3,T 
87   COLOR 7,1 
88   PRINT STRING$(5,95); 
89   COLOR 1,7 
90   LOCATE L + 4,T 
91   PRINT "  " CHR$(X)"  "; 
92   T = T + 7 
93 NEXT 
94 COLOR 6,1 
95 RETURN 
96 PRINT STRING$(78,205); 
97 RETURN 
98 '------------------------------------------- 
99 'Blank a Peg at Location L,T 
100 LOCATE L - 1,T 
101 PRINT "     "; 
102 LOCATE L,T 
103 PRINT "     "; 
104 RETURN 
105 '-------------------------------------------- 
106 'Draw a Peg at Location L,T with Color C 
107 COLOR C 
108 LOCATE L - 1,T 
109 PRINT TOPPEG$; 
110 LOCATE L,T 
111 PRINT BOTPEG$; 
112 RETURN 
113 '--------------------------------------------- 
114 'Subroutine to draw the Blocks at L,T 
115 'Blocks are drawn based on the values of array PEG(x) 
116 '-1=Red, 0=Empty, 1=Green. 
117 PEN OFF 
118 FOR X = 1 TO 11 
119   IF PEG(X) = 0 THEN GOSUB 100 : T = T + 7 : GOTO 123 
120   IF PEG(X) = - 1 THEN C = 4  ELSE C = 2 
121   GOSUB 107 
122   T = T + 7 
123 NEXT 
124 COLOR 6 
125 PEN ON 
126 RETURN 
127 '------------------------------------------ 
128 'Light Pen Subroutine 
129 IF PENFLAG = 1 THEN GOSUB 33 : MOVE = 0 : RETURN 195 
130 PENPOS = PEN(9) 
131 'Column Pen was touched in...don't care about row. 
132 ANS = "" 
133 FOR PX = 65 TO 75 
134   IF PENPOS>=(PX-65)*7+4 AND PENPOS<=(PX-65)*7+8 THEN ANS=CHR$(PX) 
135 NEXT 
136 IF ANS = "" THEN RETURN 
137 LOCATE LL,TT 
138 PRINT ANS$ 
139 IF PENFLAG = 2 THEN RETURN 212  ELSE RETURN 229 
140 '------------------------------------------ 
141 PRINT TAB( 31); 
142 COLOR 20,7 
143 PRINT " " STRING$(3,240)" SWITCH " STRING$(3,240)" "; 
144 COLOR 6,1 
145 PRINT 
146 PRINT 
147 PRINT TAB( 3)"      In this puzzle you are faced with the problem of "; 
148 PRINT "switching two" 
149 PRINT TAB( 3)"different sets of pegs. The RED pegs can only move to "; 
150 PRINT "the right" 
151 PRINT TAB( 3)"and the GREEN pegs can only move to the left." 
152 PRINT 
153 PRINT TAB( 3)"      Your selected peg may ONLY jump one other peg OR "; 
154 PRINT "move one Space." 
155 PRINT TAB( 3)"You WIN when you have completely switched both sets of "; 
156 PRINT"pegs. Good Luck!" 
157 PRINT 
158 PRINT TAB( 3)"Note: you will NOT have to press the ENTER key once the "; 
159 PRINT"puzzle has started." 
160 PRINT TAB( 3)"This Program also supports Light Pen Operation." 
161 L = 13 
162 GOSUB 72 
163 L = L + 2 
164 LOCATE 22,15,0 
165 COLOR 22 
166 PRINT "Press any key or Touch the Screen with the Pen to start" 
167 PENFLAG = 1 
168 T = 4 
169 GOSUB 114 
170 COLOR 4,7 
171 LOCATE 20,38 
172 PRINT " Start "; 
173 COLOR ,1 
174 A = INKEY$ 
175 IF A < > "" THEN 195 
176 GOSUB 178 
177 GOTO 185 
178 FOR X = 1 TO 5 
179   PEG(X) = - PEG(X) 
180   PEG(X + 6) = - PEG(X + 6) 
181 NEXT 
182 FOR X = 0 TO 1500 
183 NEXT 
184 RETURN 
185 T = 4 
186 GOSUB 114 
187 LOCATE 20,37 
188 COLOR 4,7 
189 PRINT " Finish "; 
190 COLOR ,1 
191 A = INKEY$ 
192 IF A < > "" THEN 195 
193 GOSUB 178 
194 GOTO 168 
195 COLOR 6,1,1 
196 GOSUB 33 ' Reinitialize Peg(X) 
197 CLS 
198 L = 4 
199 GOSUB 71 
200 L = L + 2 
201 T = 4 
202 GOSUB 114 
203 LOCATE 11,5 
204 PRINT SPACE$(50); 
205 LOCATE 11,5 
206 PRINT "Move from "; 
207 PENFLAG = 2 
208 GOSUB 45 
209 SWAP AX,ANS 
210 GOSUB 40 
211 SWAP AX,ANS 
212 IF ANS > = "A" AND ANS < = "K" THEN 215 
213 SOUND 37,25 
214 GOTO 240 
215 MOVE.FROM = ASC(ANS) - 64 
216 IF PEG(MOVE.FROM) = 0 THEN 213 
217 L = 6 
218 T = (MOVE.FROM - 1) * 7 + 4 
219 IF PEG(MOVE.FROM) = - 1 THEN C = 20  ELSE C = 18 
220 GOSUB 107 
221 COLOR 6 
222 LOCATE 11,25 
223 PRINT "Move to "; 
224 PENFLAG = 3 
225 GOSUB 45 
226 SWAP ANS,AX 
227 GOSUB 40 
228 SWAP ANS,AX 
229 IF ANS < "A" OR ANS > "K" THEN 213 
230 MOVE.TO = ASC(ANS) - 64 
231 IF PEG(MOVE.TO) < > 0 THEN 213 
232 DIFF = MOVE.TO - MOVE.FROM 
233 IF ABS(DIFF) > 2 THEN 213 
234 IF PEG(MOVE.FROM) = - 1 AND DIFF < 0 THEN 213 
235 IF PEG(MOVE.FROM) = 1 AND DIFF > 0 THEN 213 
236 SWAP PEG(MOVE.FROM),PEG(MOVE.TO) 
237 MOVE = MOVE + 1 
238 LOCATE 3,30 
239 PRINT "Number of Moves ="MOVE; 
240 L = 6 
241 T = 4 
242 GOSUB 114 
243 IF PEG(6) < > 0 THEN 203 
244 FLAG = 0 
245 FOR X = 1 TO 5 
246   IF PEG(X) < > 1 THEN FLAG = - 1 
247   IF PEG(X + 6) < > - 1 THEN FLAG = - 1 
248 NEXT 
249 IF FLAG THEN 203 
250 LOCATE 14,5 
251 COLOR 20,7 
252 PRINT " You WON!!! in"MOVE"Moves ! " 
253 FOR Y = 1 TO 3 
254   FOR X = 20 TO 60 
255     PLAY "MBL48T255N=X;" 
256   NEXT 
257 NEXT 
258 LOCATE 16,5 
259 COLOR 6,1 
260 PRINT "Play again "; 
261 PENFLAG = 1 
262 GOSUB 45
263 IF ANS="Y" OR ANS="y" OR ANS=CHR$(13) THEN GOSUB 33:MOVE=0:GOTO 197
264 CLS
265 END ' of program.
