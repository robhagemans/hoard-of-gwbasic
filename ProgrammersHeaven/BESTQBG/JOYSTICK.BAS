DECLARE FUNCTION Detect.JoyStick! ()
DECLARE SUB waitButton ()
DECLARE SUB GetJoyButtons ()
   
   
   

DIM SHARED joyx.Max%, joyx.Min%, joyy.Max%, joyy.Min%, Joy.Center
DIM SHARED JoyButton.A, JoyButton.B

   
    CLS

IF Detect.JoyStick THEN
  PRINT "A JoyStick is Present"
  PRINT "Center JoyStick and Press Button"
  JoyCenter.x = STICK(0)
  JoyCenter.y = STICK(1)
  waitButton

  
   ELSE
     PRINT "No JoyStick is Present"
   END IF
     PRINT JoyCenter.x, JoyCenter.y



FUNCTION Detect.JoyStick

Temp% = STICK(0)

IF Temp% > 0 THEN
   Detect.JoyStick = 1
      ELSE
       Detect.JoyStick = 0:
      END IF
  

END FUNCTION

SUB GetJoyButtons


'** &HEC = Button A &  &HDC =Button **

byte = INP(&H201)

IF HEX$(byte) = "EC" THEN
     JoyButton.A = 1
          ELSE
            JoyButton.A = 0
               END IF

IF HEX$(byte) = "DC" THEN
     JoyButton.B = 1
          ELSE
            JoyButton.B = 0
               END IF
     
IF HEX$(byte) = "CC" THEN
     JoyButton.A = 1
     JoyButton.B = 1
               END IF
      


END SUB

SUB waitButton


WHILE (JoyButton.A = 0 AND JoyButton.B = 0)
      GetJoyButtons
      WEND

WHILE (NOT JoyButton.A = 0 OR NOT JoyButton.B = 0)
      GetJoyButtons
        WEND



END SUB

