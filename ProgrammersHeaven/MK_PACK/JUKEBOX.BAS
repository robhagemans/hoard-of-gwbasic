CLS
10 PRINT "This is a jukebox."
20 PRINT "1 = Mickey Mouse Club"
30 PRINT "2 = Lets Get Together"
40 PRINT "3 = The Ballad of Davy Crockett"
60 INPUT "Choose a number from 1 to 3. ", entry
70 IF entry > 3 OR entry < 1 THEN PRINT "Incorrect entry."
80 IF entry > 3 OR entry < 1 GOTO 60 ELSE GOTO 90
90 IF entry = 1 THEN PLAY "l4fcdefcdel6fl16fl6fl16fl6gl16fl6el16dl8cl6fl16fl4fl6fl16fl4fl6al16fl6gl16el2f" ELSE GOTO 100
100 IF entry = 2 THEN PLAY "l4el8ed#el6gl8gl4al6g.l4l16eggel8gl6al8al6g.l2l4al8ag#ao4l6cl16ccdl6c.l4o3l16eggel8gl6al8gl6al8al6g.l16l16gagl4bo4do3bgl2f.l16l16gagl4bo4do3bgl2f.l16l8go4l1co3l4bagf" ELSE GOTO 110
110 IF entry = 3 THEN PLAY "l4fl8fgl16agfcl4dfl2cl4fgal8gfl4gl8gal2gl4cl8ccl4fl8ccl4dl8ddl2gl4el8ee16el8dl16ccdel2f"
120 END


