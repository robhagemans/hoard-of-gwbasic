'       *** AutoClock v1.0 ***
'*** By Robert L. Folmer 11/02/92 ***
'
'
BEGIN:
     CLS : SCREEN 7, 0, 0: COLOR 9: LOCATE 1, 1: PRINT "AutoClock v1.0"
GETCLOCK:
     LOCATE 11, 17: COLOR 12: PRINT TIME$   ' Postion screen location for clock
     DO WHILE INKEY$ = ""                   ' Check if key is pressed and exit
     GOTO GETCLOCK                          ' Loop back to GETCLOCK routine while keyboard buffer empty
     LOOP
     CLS : SCREEN 0, 0, 0: WIDTH 80: COLOR 7, 0, 0: SYSTEM ' Restore screen upon exiting

