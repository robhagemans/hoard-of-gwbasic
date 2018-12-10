10 ' MARK A. SWANSON         19:35:44  2/27/1985
20 CLS
30 PRINT "           ";:FOR A=1 TO 58:PRINT CHR$(176);:NEXT A
40 PRINT "           °               THE BASIC TUTORIAL MENU                  °
50 PRINT "           °                                                        °
60 PRINT "           °                                                        °
70 PRINT "           °   [1]  BASIC GUIDE                [6]  FOR / NEXT      °
80 PRINT "           °                                                        °
90 PRINT "           °   [2]  PRINT                      [7]  INPUT           °
100 PRINT "           °                                                        °
110 PRINT "           °   [3]  MODES OF OPERATION         [8]  IF / THEN       °
120 PRINT "           °                                                        °
130 PRINT "           °   [4]  GOTO                       [9]  READ / DATA     °
140 PRINT "           °                                                        °
150 PRINT "           °   [5]  LET                       [10]  GOSUB / RETURN  °
160 PRINT "           °                                                        °
170 PRINT "           °                                                        °
180 PRINT "           °                       Q   QUIT                         °
190 PRINT "           ";:FOR A=1 TO 58:PRINT CHR$(176);:NEXT A
200 PRINT:PRINT:PRINT:PRINT
210 INPUT "               PRESS THE NUMBER FOR THE LESSON YOU WOULD LIKE ";Z$
220 IF Z$="1" THEN LOAD"B:GUIDE.BAS",R
230 IF Z$="2" THEN LOAD"B:PRINT.BAS",R
240 IF Z$="3" THEN LOAD"B:MODES.BAS",R
250 IF Z$="4" THEN LOAD"B:GOTO.BAS",R
260 IF Z$="5" THEN LOAD"B:LET.BAS",R
270 IF Z$="6" THEN LOAD"B:FORNEXT.BAS",R
280 IF Z$="7" THEN LOAD"B:INPUT.BAS",R
290 IF Z$="8" THEN LOAD"B:IFTHEN.BAS",R
300 IF Z$="9" THEN LOAD"B:READDATA.BAS",R
310 IF Z$="10" THEN LOAD"B:GR.BAS",R
320 IF Z$="Q" THEN LOAD"B:MENU.BAS",R
330 PRINT "INVALID RESPONSE ..............> TRY AGAIN ":GOTO 210
HEN LOAD"B:GR.BAS",R
32