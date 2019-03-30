10 SCREEN 12

20 DO WHILE INKEY$ = ""      'keep looping until the user presses a key
30 e = 500 * RND             'random variables less than 500 or 600       
40 s = 600 * RND
50 c = 16 * RND               'random color less than code 16
60 FOR i = 1 TO 100 STEP .2   ' STEP counts by .2   
70 CIRCLE (e, s), i, r        'this is where the variables are used 
80 NEXT I                       

90 FOR l = 100 TO 1 STEP -.2  ' "closes up" the last circle that was made
100 CIRCLE (e, s), l, 0        ' with color code 0 (black)
110 NEXT l                        

120 CLS
130 LOOP                        'back to "DO"  



