100 print "Press ctrl-shift-b to terminate clock."
110 suspend 0, 0x30, 0x06, 18, 0, timer
120 if not timer then cls : end
130 display 0, 72, time()
140 goto 110
