10 REM '***                    Colorful Circles                                              ***
20 REM '*** This program displays a series of concentric circles.    ***
30 REM '*** The colors contained in each circle change randomly   ***
40 REM '*** as the graphic is displayed. The background color        ***
50 REM '*** also changes. 
60 REM *** PROGRAM BY  Susan K Baumann, Steven Mandell      ***
80 REM *** GW-BASIC CONVERSION BY     ***
90 REM ***         KindlyRat  18 Feb 05              ***                                                                    
100 CLS
110 SCREEN 1
120 RANDOMIZE TIMER
130 BALLRADIUS = 50
140 COLOR 14, 1
150 FOR OUTER = 1 TO 3
160  COLOR RND * 15, RND * 1   'Determine current background and palette
170   FOR MIDDLE = 1 TO 300
180      FOR INNER = 50 TO 1 STEP -1
190         FRONT = RND * (3)   'Determine color of next circle drawn
200         CIRCLE (160, 100), (BALLRADIUS - INNER), FRONT
210      NEXT INNER
220   NEXT MIDDLE
230 NEXT OUTER
240 END
