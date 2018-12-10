 1 ' dice.bas
10 pts = 0                                                          
20 die.roll = int(rnd*6) + 1 ' random number bet 1 and 6            
30 while die.roll <> 6 and pts < 20                                 
40    pts = pts + die.roll                                          
50    die.roll = int(rnd*6) + 1                                     
60 wend                                                             
70 if die.roll = 6 then pts = 0                                     
80 if pts>0 then print "You made";pts;"points" else print"You lost" 
