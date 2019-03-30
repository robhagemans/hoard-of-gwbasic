

'*********************************************
'* Gnome Walk                                *
'* Programmed by Neil Marshall               *
'*********************************************
'*        This program demonstrates          *
'*       How to animate a character          *
'*         and how to reduce the             *
'*       flicker that you always get         *
'*        when animating in QBasic           *
'*********************************************
'* If you need help you can                  *
'* Contact me at:                            *
'* http://www.pssnet.com/users/marshall/neil *
'* MailTo:marshall@pssnet.com                *
'*********************************************
'
'
'
'
'
DECLARE SUB drawlevel ()
DEFINT A-Z
'Change to screen 9 (640x480x16 Colors, 2 Flip Screens)
SCREEN 9

'Define the Graphical arrays
DIM gnome4(900), gnome3(900), gnome2(900), gnome1(900) 'Gnome
DIM mask4(900), mask3(900), mask2(900), mask1(900)     'Masks


GOSUB getgnomes 'Draw and Grab the gnomes and masks from the end of this file


LOCATE 25, 1: PRINT "Press a key to start...";
WHILE INKEY$ = "": WEND 'Wait for a key press

y = 100 'Set the Y Co-ord
x = 10  'Set the X Co-ord
d$ = "Right" 'Set the direction


DO  'The main loop
 a$ = INKEY$ 'Get any key presses
 IF a$ = "6" THEN d$ = "Right" 'If they pressed 6 then change the direction
 IF a$ = "4" THEN d$ = "Left"  'If they pressed 4 then change the direction
 IF UCASE$(a$) = "Q" THEN END  'End the program
 IF d$ = "Right" THEN x = x + 10 'if the direction is Right than move the character 10 pixels to the right
 IF d$ = "Left" THEN x = x - 10 'if the direction is Left than move the character 10 pixels to the Left
 IF x < 1 THEN x = 1 'If they hit the wall then keep them there
 IF x > 600 THEN x = 600 'If they hit the wall then keep them there


 fm = 1 - fm 'Change the frame (0 or 1)

 IF d$ = "Right" THEN
  IF fm = 1 THEN

   pg = 1 - pg            'Change the screen #
   SCREEN 9, , pg, 1 - pg 'Flip the screens
   WAIT &H3DA, 8 'Wait for the electron beam :)
   CLS
   drawlevel 'Draw the bars for the background

   PUT (x, y), mask4, AND  'paint the mask
   PUT (x, y), gnome4, XOR 'paint paint the gnome onto the mask

   GOSUB waitt           'Wait for .1 of a second

 
  ELSE
   
   pg = 1 - pg
   SCREEN 9, , pg, 1 - pg
   WAIT &H3DA, 8
   CLS
   drawlevel
  
   PUT (x + 1, y), mask3, AND
   PUT (x + 1, y), gnome3, XOR

   GOSUB waitt

  END IF

 ELSE

  IF fm = 1 THEN

   pg = 1 - pg
   SCREEN 9, , pg, 1 - pg
   WAIT &H3DA, 8
   CLS
   drawlevel

  
   PUT (x, y), mask2, AND
   PUT (x, y), gnome2, XOR
   

   GOSUB waitt

  ELSE
  
   pg = 1 - pg
   SCREEN 9, , pg, 1 - pg
   WAIT &H3DA, 8
   CLS
   drawlevel
 
   PUT (x + 1, y), mask1, AND
   PUT (x + 1, y), gnome1, XOR

   GOSUB waitt
  END IF

 END IF


LOOP

END



''''''''''''''''''''''''
getgnomes:

'GOSUB background
'gnome1
  

  x = 100: y = 200
  CIRCLE (x + 5, y + 3), 5, 7: PAINT (x + 5, y + 3), 7, 7
  PSET (x + 2, y + 3), 0
  LINE (x + 12, y + 2)-(x + 3, y - 2), 12
  LINE -(x + 12, y - 10), 12: LINE -(x + 12, y + 2), 12
  PAINT (x + 8, y - 2), 12, 12
  CIRCLE (x + 5, y + 16), 9, 14, , , 5 / 3
  PAINT (x + 5, y + 16), 14, 14
  LINE (x + 9, y + 10)-(x + 14, y + 14), 14
  LINE -(x + 15, y + 19), 14
  LINE -(x + 13, y + 19), 14
  LINE -(x + 11, y + 14), 14
  PAINT (x + 13, y + 17), 14, 14

  LINE (x + 2, y + 11)-(x - 1, y + 15), 14
  LINE -(x - 5, y + 19), 14
  LINE -(x - 6, y + 17), 14
  LINE -(x - 4, y + 15), 14
  LINE -(x, y + 11), 14
  PAINT (x - 2, y + 14), 14, 14
  LINE (x + 11, y + 19)-(x, y + 19), 9
  LINE -(x - 3, y + 30), 9
  LINE -(x - 4, y + 33), 9
  LINE -(x - 2, y + 33), 9
  LINE -(x + 3, y + 28), 9
  LINE -(x, y + 25), 9
  LINE -(x + 7, y + 28), 9
  LINE -(x + 12, y + 33), 9
  LINE -(x + 14, y + 30), 9
  LINE -(x + 9, y + 25), 9
  LINE -(x + 11, y + 19), 9
  PAINT (x + 2, y + 21), 9, 9
  PAINT (x, y + 28), 9, 9
  LINE (x - 3, y + 33)-(x - 5, y + 35), 6, BF
  LINE (x - 5, y + 33)-(x - 7, y + 31), 6, BF
  LINE (x + 17, y + 31)-(x + 15, y + 33), 6, BF
  LINE (x + 15, y + 34)-(x + 9, y + 35), 6, BF
  GET (x - 8, y - 10)-(x + 17, y + 37), gnome1
  'LINE (x - 9, y - 11)-(x + 18, y + 38), 7, B

'gnome2
  x = 200
  CIRCLE (x + 5, y + 3), 5, 7: PAINT (x + 5, y + 3), 7, 7
  PSET (x + 2, y + 3), 0
  LINE (x + 12, y + 2)-(x + 3, y - 2), 12
  LINE -(x + 12, y - 10), 12: LINE -(x + 12, y + 2), 12
  PAINT (x + 8, y - 2), 12, 12
  CIRCLE (x + 5, y + 16), 9, 14, , , 5 / 3
  PAINT (x + 5, y + 16), 14, 14
  LINE (x + 10, y + 19)-(x - 1, y + 19), 9
  LINE -(x + 1, y + 25), 9: LINE -(x + 4, y + 25), 9
  LINE -(x + 3, y + 30), 9
  LINE -(x + 4, y + 35), 9
  LINE -(x + 6, y + 35), 9
  LINE -(x + 6, y + 30), 9
  LINE -(x + 7, y + 25), 9
  LINE -(x + 10, y + 22), 9
  LINE -(x + 10, y + 19), 9
  PAINT (x + 5, y + 21), 9, 9
  LINE (x + 5, y + 11)-(x + 7, y + 21), 14, BF
  LINE (x + 7, y + 35)-(x + 2, y + 37), 6, BF
  GET (x - 7, y - 10)-(x + 17, y + 37), gnome2
'  LINE (x - 8, y - 11)-(x + 18, y + 38), 7, B

'third gnome
  x = 300: y = 200
  CIRCLE (x + 5, y + 3), 5, 7: PAINT (x + 5, y + 3), 7, 7
  PSET (x + 8, y + 3), 0
  LINE (x - 2, y + 2)-(x + 7, y - 2), 12
  LINE -(x - 2, y - 10), 12: LINE -(x - 2, y + 2), 12
  PAINT (x + 2, y - 2), 12, 12
  CIRCLE (x + 5, y + 16), 9, 14, , , 5 / 3
  PAINT (x + 5, y + 16), 14, 14
  LINE (x, y + 19)-(x + 10, y + 19), 9
  LINE -(x + 8, y + 25), 9: LINE -(x + 7, y + 25), 9
  LINE -(x + 8, y + 30), 9
  LINE -(x + 7, y + 35), 9
  LINE -(x + 4, y + 35), 9
  LINE -(x + 5, y + 30), 9
  LINE -(x + 3, y + 25), 9
  LINE -(x + 0, y + 22), 9
  LINE -(x + 0, y + 19), 9
  PAINT (x + 5, y + 21), 9, 9
  LINE (x + 5, y + 11)-(x + 7, y + 21), 14, BF
  LINE (x + 3, y + 35)-(x + 8, y + 37), 6, BF
  GET (x - 7, y - 10)-(x + 17, y + 37), gnome3


'gnome4
  x = 400: y = 200
  CIRCLE (x + 5, y + 3), 5, 7: PAINT (x + 5, y + 3), 7, 7
  PSET (x + 8, y + 3), 0
  LINE (x - 2, y + 2)-(x + 7, y - 2), 12
  LINE -(x - 2, y - 10), 12: LINE -(x - 2, y + 2), 12
  PAINT (x + 2, y - 2), 12, 12
  CIRCLE (x + 5, y + 16), 9, 14, , , 5 / 3
  PAINT (x + 5, y + 16), 14, 14
  LINE (x + 1, y + 10)-(x - 4, y + 14), 14
  LINE -(x - 5, y + 19), 14
  LINE -(x - 3, y + 19), 14
  LINE -(x - 1, y + 14), 14
  PAINT (x - 1, y + 12), 14, 14
  LINE (x + 8, y + 11)-(x + 11, y + 15), 14
  LINE -(x + 15, y + 19), 14
  LINE -(x + 16, y + 17), 14
  LINE -(x + 14, y + 15), 14
  LINE -(x + 10, y + 11), 14
  PAINT (x + 12, y + 14), 14, 14
  LINE (x - 1, y + 19)-(x + 10, y + 19), 9
  LINE -(x + 13, y + 30), 9
  LINE -(x + 14, y + 33), 9
  LINE -(x + 12, y + 33), 9
  LINE -(x + 7, y + 28), 9
  LINE -(x + 5, y + 25), 9
  LINE -(x + 3, y + 28), 9
  LINE -(x - 2, y + 33), 9
  LINE -(x - 4, y + 30), 9
  LINE -(x + 1, y + 25), 9
  LINE -(x - 1, y + 19), 9
  PAINT (x + 5, y + 21), 9, 9
  LINE (x + 13, y + 33)-(x + 15, y + 35), 6, BF
  LINE (x + 15, y + 33)-(x + 17, y + 31), 6, BF
  LINE (x - 7, y + 31)-(x - 5, y + 33), 6, BF
  LINE (x - 5, y + 34)-(x + 1, y + 35), 6, BF
  GET (x - 8, y - 10)-(x + 17, y + 37), gnome4


'fifth gnome
  x = 500: y = 200
  CIRCLE (x + 5, y + 3), 5, 7: PAINT (x + 5, y + 3), 7, 7
  PSET (x + 4, y + 3), 0: PSET (x + 8, y + 3), 0
  LINE (x + 2, y + 0)-(x + 8, y), 12
  LINE -(x + 5, y - 10), 12: LINE -(x + 0, y), 12
  PAINT (x + 5, y - 2), 12, 12
  CIRCLE (x + 5, y + 16), 9, 14, , , 3 / 2
  PAINT (x + 5, y + 16), 14, 14
  LINE (x, y + 19)-(x + 10, y + 19), 9
  LINE -(x + 12, y + 35), 9: LINE -(x + 6, y + 25), 9
  LINE -(x + 4, y + 25), 9: LINE -(x - 2, y + 35), 9
  LINE -(x, y + 19), 9: PAINT (x + 5, y + 20), 9, 9
  LINE (x + 11, y + 35)-(x + 16, y + 37), 6, BF
  LINE (x - 1, y + 35)-(x - 6, y + 37), 6, BF
  LINE (x - 1, y + 8)-(x + 11, y + 8), 14
  LINE -(x + 16, y + 14), 14: LINE -(x + 12, y + 20), 14
  LINE (x + 11, y + 11)-(x + 13, y + 14), 14
  LINE -(x + 12, y + 20), 14
  PAINT (x + 15, y + 14), 14
  LINE (x - 2, y + 8)-(x - 7, y + 14), 14: LINE -(x - 3, y + 20), 14
  LINE -(x - 2, y + 18), 14
  LINE -(x - 4, y + 14), 14' LINE -(x-3, y+14), 14
  LINE -(x + 1, y + 12), 14: LINE -(x - 2, y + 8), 14
  PAINT (x - 3, y + 11), 14, 14
  LINE (x - 5, y + 14)-(x - 2, y + 20), 14
  LINE (x - 6, y + 14)-(x - 3, y + 20), 14
  PSET (x - 5, y + 13), 14
  LINE (x + 2, y + 19)-(x + 1, y + 8), 9: LINE (x + 8, y + 19)-(x + 9, y + 8), 9
' GET (x - 7, y - 10)-(x + 17, y + 37), gnome5


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''






 

  x = 100: y = 100
  LINE (x - 8, y - 10)-(x + 17, y + 37), 15, BF
  CIRCLE (x + 5, y + 3), 5, 0: PAINT (x + 7, y + 5), 0, 0
  PSET (x + 2, y + 3), 0
  LINE (x + 12, y + 2)-(x + 3, y - 2), 0
  LINE -(x + 12, y - 10), 0: LINE -(x + 12, y + 2), 0
  PAINT (x + 8, y - 2), 0, 0
  CIRCLE (x + 5, y + 16), 9, 0, , , 5 / 3
  PAINT (x + 5, y + 16), 0, 0
  LINE (x + 9, y + 10)-(x + 14, y + 14), 0
  LINE -(x + 15, y + 19), 0
  LINE -(x + 13, y + 19), 0
  LINE -(x + 11, y + 14), 0
  PAINT (x + 13, y + 17), 0, 0

  LINE (x + 2, y + 11)-(x - 1, y + 15), 0
  LINE -(x - 5, y + 19), 0
  LINE -(x - 6, y + 17), 0
  LINE -(x - 4, y + 15), 0
  LINE -(x, y + 11), 0
  PAINT (x - 2, y + 14), 0, 0
  LINE (x + 11, y + 19)-(x, y + 19), 0
  LINE -(x - 3, y + 30), 0
  LINE -(x - 4, y + 33), 0
  LINE -(x - 2, y + 33), 0
  LINE -(x + 3, y + 28), 0
  LINE -(x, y + 25), 0
  LINE -(x + 7, y + 28), 0
  LINE -(x + 12, y + 33), 0
  LINE -(x + 14, y + 30), 0
  LINE -(x + 9, y + 25), 0
  LINE -(x + 11, y + 19), 0
  PAINT (x + 3, y + 25), 0, 0
  PAINT (x, y + 26), 0, 0
  LINE (x - 3, y + 33)-(x - 5, y + 35), 0, BF
  LINE (x - 5, y + 33)-(x - 7, y + 31), 0, BF
  LINE (x + 17, y + 31)-(x + 15, y + 33), 0, BF
  LINE (x + 15, y + 34)-(x + 9, y + 35), 0, BF
  GET (x - 8, y - 10)-(x + 17, y + 37), mask1
  

'gnome2
  x = 200
  LINE (x - 7, y - 10)-(x + 17, y + 37), 15, BF
  CIRCLE (x + 5, y + 3), 5, 0: PAINT (x + 5, y + 3), 0, 0
  PSET (x + 2, y + 3), 0
  LINE (x + 12, y + 2)-(x + 3, y - 2), 0
  LINE -(x + 12, y - 10), 0: LINE -(x + 12, y + 2), 0
  PAINT (x + 8, y - 2), 0, 0
  CIRCLE (x + 5, y + 16), 9, 0, , , 5 / 3
  PAINT (x + 5, y + 16), 0, 0
  LINE (x + 10, y + 19)-(x - 1, y + 19), 0
  LINE -(x + 1, y + 25), 0: LINE -(x + 4, y + 25), 0
  LINE -(x + 3, y + 30), 0
  LINE -(x + 4, y + 35), 0
  LINE -(x + 6, y + 35), 0
  LINE -(x + 6, y + 30), 0
  LINE -(x + 7, y + 25), 0
  LINE -(x + 10, y + 22), 0
  LINE -(x + 10, y + 19), 0
  PAINT (x + 4, y + 30), 0, 0
  LINE (x + 5, y + 11)-(x + 7, y + 21), 0, BF
  LINE (x + 7, y + 35)-(x + 2, y + 37), 0, BF
  GET (x - 7, y - 10)-(x + 17, y + 37), mask2


'third gnome
  x = 300
  LINE (x - 7, y - 10)-(x + 17, y + 37), 15, BF

  CIRCLE (x + 5, y + 3), 5, 0: PAINT (x + 5, y + 3), 0, 0
 
  PSET (x + 8, y + 3), 0
  LINE (x - 2, y + 2)-(x + 7, y - 2), 0
  LINE -(x - 2, y - 10), 0: LINE -(x - 2, y + 2), 0
  PAINT (x + 2, y - 2), 0, 0
 
  CIRCLE (x + 5, y + 16), 9, 0, , , 5 / 3
 
  PAINT (x + 5, y + 16), 0, 0
  LINE (x, y + 19)-(x + 10, y + 19), 0
  LINE -(x + 8, y + 25), 0: LINE -(x + 7, y + 25), 0
  LINE -(x + 8, y + 30), 0
  LINE -(x + 7, y + 35), 0
  LINE -(x + 4, y + 35), 0
  LINE -(x + 5, y + 30), 0
  LINE -(x + 3, y + 25), 0
  LINE -(x + 0, y + 22), 0
  LINE -(x + 0, y + 19), 0
  PAINT (x + 6, y + 30), 0, 0
  LINE (x + 5, y + 11)-(x + 7, y + 21), 0, BF
  LINE (x + 3, y + 35)-(x + 8, y + 37), 0, BF
  GET (x - 7, y - 10)-(x + 17, y + 37), mask3


'gnome4
  x = 400
  LINE (x - 8, y - 10)-(x + 17, y + 37), 15, BF
  CIRCLE (x + 5, y + 3), 5, 0: PAINT (x + 5, y + 3), 0, 0
  PSET (x + 8, y + 3), 0
  LINE (x - 2, y + 2)-(x + 7, y - 2), 0
  LINE -(x - 2, y - 10), 0: LINE -(x - 2, y + 2), 0
  PAINT (x + 2, y - 2), 0, 0
  CIRCLE (x + 5, y + 16), 9, 0, , , 5 / 3
  PAINT (x + 5, y + 16), 0, 0
  LINE (x + 1, y + 10)-(x - 4, y + 14), 0
  LINE -(x - 5, y + 19), 0
  LINE -(x - 3, y + 19), 0
  LINE -(x - 1, y + 14), 0
  PAINT (x - 1, y + 12), 0, 0
  LINE (x + 8, y + 11)-(x + 11, y + 15), 0
  LINE -(x + 15, y + 19), 0
  LINE -(x + 16, y + 17), 0
  LINE -(x + 14, y + 15), 0
  LINE -(x + 10, y + 11), 0
  PAINT (x + 12, y + 14), 0, 0
  LINE (x - 1, y + 19)-(x + 10, y + 19), 0
  LINE -(x + 13, y + 30), 0
  LINE -(x + 14, y + 33), 0
  LINE -(x + 12, y + 33), 0
  LINE -(x + 7, y + 28), 0
  LINE -(x + 5, y + 25), 0
  LINE -(x + 3, y + 28), 0
  LINE -(x - 2, y + 33), 0
  LINE -(x - 4, y + 30), 0
  LINE -(x + 1, y + 25), 0
  LINE -(x - 1, y + 19), 0
  PAINT (x + 8, y + 24), 0, 0
  PAINT (x + 2, y + 24), 0, 0
  LINE (x + 13, y + 33)-(x + 15, y + 35), 0, BF
  LINE (x + 15, y + 33)-(x + 17, y + 31), 0, BF
  LINE (x - 7, y + 31)-(x - 5, y + 33), 0, BF
  LINE (x - 5, y + 34)-(x + 1, y + 35), 0, BF
  GET (x - 8, y - 10)-(x + 17, y + 37), mask4

RETURN
waitt:
  T! = TIMER
  DO UNTIL TIMER > T! + .1
  LOOP
  RETURN

SUB drawlevel
  LINE (1, 100)-(649, 100), 2
  LINE (1, 147)-(649, 147), 2
  FOR i = 1 TO 640 STEP 25
    LINE (i, 1)-(i + 2, 200), 3, BF
  NEXT
END SUB

