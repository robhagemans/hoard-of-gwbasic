

   rem
   rem This program demonstrates creating and using different fonts/sizes
   rem
   rem
   rem It also demonstrates how to use an icon with a program.
   rem This program works under Windows or DOS
   rem

   rem $ICON: 'SAMPLE14.ICO'
   rem windows size 10,2,70,19

   REM windows name "Font Demonstration"



   rem
   rem Before going into graphics mode say we are handling paint.  If we
   rem wait and do this after SCREEN command then a big bitmap would be
   rem created (during SCREEN command) and then deleted (during ON PAINT).
   rem

   screen 1000
   a=mouseon
   mode=system(7)
   position 10,50,550,450
   line (0,0)-(550,450),7,bf

   color 1,7

   createfont 1,30,0,0,0,0,0,0,0,0,0,0,0,0,""
   createfont 2,40,0,0,0,0,0,0,0,3,0,0,0,&h40,""
   createfont 3,50,0,0,0,0,1,0,0,3,0,0,0,&h40,""
   createfont 4,30,0,0,0,0,0,0,0,3,0,0,0,"COURIER"
   createfont 5,40,0,0,0,0,0,1,0,3,0,0,0,"COURIER"
   createfont 6,40,0,0,0,900,0,0,0,3,0,0,0,0,""

   selectfont 1
'   FOR I=1 TO 1000:NEXT I
   GOSUB DELAY
   locate 10,40
   print "Roses are red";
   GOSUB DELAY
   locate 70,40
   selectfont 3
   print "Violets are blue";
   GOSUB DELAY
   locate 140,40
   SELECTFONT 4
   print "Register this program";
   GOSUB DELAY
   locate 210,40
   selectfont 5
   print "And I'll love you.";
   gosub delay
   locate 280,40
   selectfont 6
   print "....Mark";


   DO WHILE INKEY$=""
   LOOP
   STOP


DELAY:
   FOR I=1 TO 2500:NEXT I
   RETURN


1000
   return




