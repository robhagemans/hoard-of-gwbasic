DECLARE SUB ResetPal ()
DECLARE SUB Pal (Pn!, I!, C!)
DECLARE SUB GetOrigPal ()
DECLARE SUB RestorePal ()
DECLARE FUNCTION Bucket! (I!, C1!, C2!)
COMMON SHARED C1, C2, C3, C4
SCREEN 13
RANDOMIZE TIMER
' Programmed by: Everett Arvin (|Malice| on IRC)
' Structuring sucks, so if you don't like my
' programming, please feel free to bite me
' This thing was made on a 5x86 133 w/ 16mb ram don't
' complain about speed problems... Edit the Speed
' variable below.  And for even slower computers out
' out there please edit the MaxExpRad variable too.
' send questions, comments, etc. to jester@si-net.com
' watch what you didn't think QB could do...
' Special thanks to Destruct for the Elastic idea
' Actually it was just some suggestions, but I
' gave him credit anyways...
                   'Rec.=Recommended
Elastic = 1        'Elastic fworks! 1=bouncy, 0=not bouncy (1's cool)
                   '**Note: The fireworks are launched further
                   '        and faster when this is on... It adds
                   '        to the elastic effect...
Speed = 5000       'Speed of launch >=slower
                   '{0 - 10000 Rec.}
MaxExpRad = 100    'Fragments >=more {50 - 500 Rec.}
Gravity = .1       'Gravity >=more {.01 - 2 Rec.}
TFrag = 1          'Type of fragment: {1 - 4}
                   '1=Regular dot (default)
                   '2=Circle      <- these can look funky at times...     
                   '3=Box         <-
                   '4=NIN (for those nine inch nails fans :)
Tail = 5           'Length of fragment tail (some bugs occur here) 5's default
                   '{1 - 63 Rec.}
IF TFrag = 4 THEN MaxExpRad = MaxExpRad / 2
DIM EX(MaxExpRad)
DIM EY(MaxExpRad)
DIM EXD(MaxExpRad)
DIM EYD(MaxExpRad)
DIM EC(MaxExpRad)
DIM SHARED OrigPal(255, 3)
GetOrigPal
CLS
IF Elastic = 1 THEN Inc = 7 ELSE Inc = 2
ExpSize = .01
DO
X = INT(RND * 320) + 1
Y = 199
YD = INT(RND * 3) + 2
IF X > 160 THEN Xd = -(RND * Inc) ELSE Xd = RND * Inc
C1 = INT(RND * 7) + 1
ResetPal
C = 1
Launch:
DO
'IF Elastic = 1 THEN IF Y + YD > 200 OR Y + YD < 0 THEN YD = -YD
Y = Y - YD
YD = YD - RND * .09
IF Elastic = 1 THEN IF X + Xd > 320 OR X + Xd < 0 THEN Xd = -Xd
X = X + Xd
Low = 1: High = 63
IF TFrag = 1 THEN PSET (X, Y), High
IF TFrag = 2 THEN CIRCLE (X, Y), 2, High
IF TFrag = 3 THEN LINE (X - 2, Y - 2)-(X + 2, Y + 2), High, B
IF TFrag = 4 THEN DRAW "BM" + STR$(INT(X)) + "," + STR$(INT(Y)) + "C" + STR$(High) + "d5u5f5u5br2d5br2u5d5e5d5br1bd1u7l16d7r16"
FOR S = 1 TO Speed: NEXT S
IF TFrag = 1 THEN PRESET (X, Y)
IF TFrag = 2 THEN CIRCLE (X, Y), 2, 0
IF TFrag = 3 THEN LINE (X - 2, Y - 2)-(X + 2, Y + 2), 0, B
IF TFrag = 4 THEN DRAW "BM" + STR$(INT(X)) + "," + STR$(INT(Y)) + "C0d5u5f5u5br2d5br2u5d5e5d5br1bd1u7l16d7r16"
LOOP UNTIL YD = -ABS(YD)
Explode:
I = High
FOR O = 1 TO MaxExpRad
EX(O) = X
EY(O) = Y
EXD(O) = RND - RND
EYD(O) = RND - RND
NEXT O
DO
FOR Boom = 1 TO MaxExpRad
IF Elastic = 1 THEN IF EX(Boom) + EXD(Boom) > 320 OR EX(Boom) + EXD(Boom) < 0 THEN EXD(Boom) = -EXD(Boom)
EX(Boom) = EX(Boom) + EXD(Boom)
IF Elastic = 1 THEN IF EY(Boom) + EYD(Boom) > 200 OR EX(Boom) + EYD(Boom) < 0 THEN EYD(Boom) = -EYD(Boom)
EY(Boom) = EY(Boom) + EYD(Boom)
EYD(Boom) = EYD(Boom) + Gravity * RND
IF TFrag = 1 THEN PSET (EX(Boom), EY(Boom)), I
IF TFrag = 2 THEN CIRCLE (EX(Boom), EY(Boom)), 2, I
IF TFrag = 3 THEN LINE (EX(Boom) - 2, EY(Boom) - 2)-(EX(Boom) + 2, EY(Boom) + 2), I, B
IF TFrag = 4 THEN DRAW "BM" + STR$(INT(EX(Boom))) + "," + STR$(INT(EY(Boom))) + "C" + STR$(INT(I)) + "d5u5f5u5br2d5br2u5d5e5d5br1bd1u7l16d7r16"
NEXT Boom
I = INT(I - ExpSize)
IF Tail <> 0 THEN IF I < 63 - Tail THEN Pal I + Tail + 1, 0, 0
LOOP UNTIL I < Low
CLS
ResetPal
LOOP WHILE INKEY$ = ""
RestorePal

FUNCTION Bucket (I, C1, C2) STATIC
M1 = 0
M2 = 0
IF C1 = 1 THEN M1 = I * 65536
IF C1 = 2 THEN M1 = I * 256
IF C1 = 3 THEN M1 = I * 65536 + I * 256
IF C1 = 4 THEN M1 = I
IF C1 = 5 THEN M1 = I * 65536 + I
IF C1 = 6 THEN M1 = I + I * 256
IF C1 = 7 THEN M1 = I * 65536 + I * 256 + I
IF C2 = 1 THEN M2 = (63 - I) * 65536
IF C2 = 2 THEN M2 = (63 - I) * 256
IF C2 = 3 THEN M2 = (63 - I) * 65536 + (63 - I) * 256
IF C2 = 4 THEN M2 = (63 - I)
IF C2 = 5 THEN M2 = (63 - I) * 65536 + (63 - I)
IF C2 = 6 THEN M2 = (63 - I) + (63 - I) * 256
IF C2 = 7 THEN M2 = (63 - I) * 65536 + (63 - I) * 256 + (63 - I)
Bucket = M1 + M2
END FUNCTION

SUB GetOrigPal STATIC
FOR X = 0 TO 255
OUT 968, X
OrigPal(X, 1) = INP(969)
OrigPal(X, 2) = INP(969)
OrigPal(X, 3) = INP(969)
NEXT X
END SUB

SUB Pal (Pn, I, C) STATIC
SELECT CASE C
CASE 0
OUT 968, Pn
OUT 969, 0
OUT 969, 0
OUT 969, 0
CASE 1
OUT 968, Pn
OUT 969, 0
OUT 969, 0
OUT 969, I
CASE 2
OUT 968, Pn
OUT 969, 0
OUT 969, I
OUT 969, 0
CASE 3
OUT 968, Pn
OUT 969, 0
OUT 969, I
OUT 969, I
CASE 4
OUT 968, Pn
OUT 969, I
OUT 969, 0
OUT 969, 0
CASE 5
OUT 968, Pn
OUT 969, I
OUT 969, 0
OUT 969, I
CASE 6
OUT 968, Pn
OUT 969, I
OUT 969, I
OUT 969, 0
CASE 7
OUT 968, Pn
OUT 969, I
OUT 969, I
OUT 969, I
END SELECT
END SUB

SUB ResetPal STATIC
FOR C = 1 TO 63
Pal C, C, C1
NEXT C
FOR C = 64 TO 126
Pal C, C - 63, C2
NEXT C
FOR C = 127 TO 189
Pal C, C - 126, C3
NEXT C
FOR C = 190 TO 252
Pal C, C - 189, C4
NEXT C
END SUB

SUB RestorePal STATIC
FOR X = 1 TO 255
OUT 968, X
OUT 969, OrigPal(X, 1)
OUT 969, OrigPal(X, 2)
OUT 969, OrigPal(X, 3)
NEXT X
END SUB

