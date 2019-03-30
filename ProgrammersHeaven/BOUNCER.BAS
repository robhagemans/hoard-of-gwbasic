
'         Bouncing pixels, mini program coded by Luke Molnar

'                 Watch for Ambush at South Range 3!

'  Bouncing Pixels, (c) copyright 1995 by Molnar \ Kucalaba Productions

' Another program exclusively available at Molnar \ Kucalaba Production's
'   FTP site! If someone gave this to you, be sure to check FTP site:
' * users:/blood225 * IIt has some of the best QBasic programs ever!


DECLARE SUB RandomNum (UpperBound%)
CLS
SCREEN 13
DIM SHARED OutP%
CONST MoveNW% = 1, MoveNE% = 2, MoveSW% = 3, MoveSE% = 4
RANDOMIZE TIMER

MaxNorth% = 20
MaxSouth% = 170
MaxWest% = 25
MaxEast% = 295


NumPoints% = 75  'Number of Pixels, feel free to change


Speed% = 0

DIM Vector1a(NumPoints%, 2) AS INTEGER
DIM Vector1b(NumPoints%, 2) AS INTEGER
DIM ColorIndex(NumPoints%) AS INTEGER

FOR Times% = 1 TO NumPoints%
 RandomNum MaxEast%
 Vector1a(Times%, 1) = OutP%
 RandomNum MaxSouth%
 Vector1b(Times%, 1) = OutP%
NEXT Times%


FOR Times% = 1 TO NumPoints%
 RandomNum 4
 Vector1a(Times%, 2) = OutP%
NEXT Times%

FOR Times% = 1 TO NumPoints%
 RandomNum 4
 Vector1b(Times%, 2) = OutP%
 RandomNum 104
 ColorIndex(Times%) = OutP%
NEXT Times%


DO UNTIL INKEY$ = CHR$(27)
ReDraw% = ReDraw% + 1
LINE (MaxWest%, MaxNorth%)-(MaxEast%, MaxSouth%), 31, B
FOR Times% = 1 TO NumPoints%
PSET (Vector1a(Times%, 1), Vector1b(Times%, 1)), 0

 SELECT CASE Vector1a(Times%, 2)
    CASE 1: Vector1a(Times%, 1) = Vector1a(Times%, 1) - Vector1b(Times%, 2)
            Vector1b(Times%, 1) = Vector1b(Times%, 1) - Vector1b(Times%, 2)
    CASE 2: Vector1a(Times%, 1) = Vector1a(Times%, 1) + Vector1b(Times%, 2)
            Vector1b(Times%, 1) = Vector1b(Times%, 1) - Vector1b(Times%, 2)
    CASE 3: Vector1a(Times%, 1) = Vector1a(Times%, 1) - Vector1b(Times%, 2)
            Vector1b(Times%, 1) = Vector1b(Times%, 1) + Vector1b(Times%, 2)
    CASE 4: Vector1a(Times%, 1) = Vector1a(Times%, 1) + Vector1b(Times%, 2)
            Vector1b(Times%, 1) = Vector1b(Times%, 1) + Vector1b(Times%, 2)
  END SELECT
 
  SELECT CASE Vector1a(Times%, 1)
   CASE IS <= MaxWest%: SELECT CASE Vector1a(Times%, 2)
                   CASE 1: Vector1a(Times%, 2) = MoveNE%
                   CASE 3: Vector1a(Times%, 2) = MoveSE%
                  END SELECT
   CASE IS >= MaxEast%: SELECT CASE Vector1a(Times%, 2)
                   CASE 2: Vector1a(Times%, 2) = MoveNW%
                   CASE 4: Vector1a(Times%, 2) = MoveSW%
                  END SELECT
  END SELECT
 
  SELECT CASE Vector1b(Times%, 1)
   CASE IS <= MaxNorth%: SELECT CASE Vector1a(Times%, 2)
                  CASE 1: Vector1a(Times%, 2) = MoveSW%
                  CASE 2: Vector1a(Times%, 2) = MoveSE%
                 END SELECT
   CASE IS >= MaxSouth%: SELECT CASE Vector1a(Times%, 2)
                    CASE 3: Vector1a(Times%, 2) = MoveNW%
                    CASE 4: Vector1a(Times%, 2) = MoveNE%
                 END SELECT
  END SELECT
 
PSET (Vector1a(Times%, 1), Vector1b(Times%, 1)), ColorIndex(Times%)
NEXT

 FOR Delay% = 1 TO 900: NEXT
IF ReDraw% = 2 THEN GOSUB ReDraw

LOOP

END

ReDraw:
LOCATE 1, 1: PRINT "             Bouncing Pixels!"
LOCATE 23, 1: PRINT "          Number of Pixels: "; NumPoints%
RETURN

SUB RandomNum (UpperBound%)
 OutP% = INT(RND * UpperBound%) + 1
END SUB

