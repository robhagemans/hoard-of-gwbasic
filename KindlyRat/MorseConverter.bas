10 REM Morse code - MORSE.BAS
20 CLEAR :CLS :KEY OFF
30 PRINT "Type a message and see it appear as Morse Code." :PRINT
40 DIM CODE$(122)
50 RESTORE
60 FOR A = 32 TO 122
70   READ CODE$(A)
80   PRINT CHR$(A);"  ";
90 NEXT A
100 PRINT :PRINT
110 INPUT "Use any of the above - What is your message "; MESSAGE$
120 PRINT
130 L = LEN(MESSAGE$)
140 FOR B = 1 TO L
150   PRINT CODE$(ASC(MID$(MESSAGE$,B,1)));" ";
160 NEXT B
170 PRINT :PRINT
180 END
190 DATA " ","!","|","#","$","%","&","'","(",")",".","+",",","-","   ","/"
200 DATA -----,.----,..---,...--,....-,.....,-....,--...,---..,----.
210 DATA ":",";","<","=",">","?","@"
220 DATA .-, -..., -.-., -.., ., ..-., --., ...., .., .---, -.-, .-.., --
230 DATA -., ---, .--., --.-, .-., ..., -, ..-, ...-, .--, -..-, -.--, --..
240 DATA "[","\","]","^","_","'"
250 DATA ._, -..., -.-., -.., ., ..-., --., ...., .., .---, -.-, .-.., --
260 DATA -., ---, .--., --.-, .-., ..., -, ..-, ...-, .--, -..-, -.--, --..
