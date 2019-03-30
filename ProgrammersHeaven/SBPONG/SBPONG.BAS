'    ******************************************************************
'    **                                                              **
'    **         Pong Mania v2.0 by Molnar \ Kucalaba Productions     **
'    **                                                              **
'    ******************************************************************

'  This is a Pong game that plays FM synthesized "background" multi
' channel Sound Blaster music.  While it does not run at ideal speed under
' QBasic, (this is on a slow 486dx33 under Windows) it is still proof that
' a QBasic game can have quality Sound Blaster music during the game.  And,
' if you compile it, this runs more than fast enough.  For the sound to
' work properly, make sure the CONST BasePort% value is set correctly.

'  ******************************************************************

' If you have any comments or questions about this game do not hesitate to
'                email them to us at  blood225@aol.com .

'  ******************************************************************

'                       This game orginated from :

'             http://members.aol.com/mkwebsite/index.html
'                   ftp://users.aol.com/blood225/

'  ******************************************************************

'  There are some great new programs there, like Gorau shaded polygons,
'     the MKJamz kit, SubQuest, the Ultimate Font, and much more.
  
'  ******************************************************************

DECLARE FUNCTION LoadJamFile% (File$)
DECLARE FUNCTION lnput$ (L%, Row%, Col%)
DECLARE FUNCTION InitDelay% ()
DECLARE SUB GetSpeed ()
DECLARE SUB Delay (msecs!)
DECLARE SUB CloseChannels ()
DECLARE SUB WriteReg (Reg%, value%)
DECLARE SUB ResetSong ()
DECLARE SUB SetIns (Channel%)
DECLARE SUB MakePal ()
DECLARE SUB FSet (Att%, R%, g%, B%)
DECLARE SUB Font (Text$, XStart%, ystart%, xscale%, Yscale%, Style%, Clr%)
DECLARE SUB LooseEnds ()
DECLARE SUB Controls ()
DECLARE SUB Controls2 ()
DECLARE SUB SBInit ()
DECLARE SUB PlayMusic ()
DECLARE SUB SeeControls ()
DECLARE SUB LoadFont ()
DECLARE SUB GetDif ()
DECLARE SUB SoundSelect ()
DECLARE SUB BuildPalette ()
DECLARE SUB Cycle255 ()
DECLARE SUB GetPress ()
DECLARE SUB FormatStrings ()
DECLARE SUB GetInput ()
DECLARE SUB Get2Input ()
DECLARE SUB DrawBarsNBall ()


'  ******************************************************************
CONST BasePort% = &H220  ' Change this for other sound cards.
'  ******************************************************************

'$DYNAMIC
DEFINT A-Z
RANDOMIZE TIMER


DIM SHARED FontBuf(0) AS STRING * 10368
DIM SHARED FileDat(1) AS INTEGER, Name1$, Name2$, Record1$, Record2$
DIM SHARED Place%, Choice%, Diff%, ImageGotten%, DelayRate!
DIM SHARED Bar1%(259), Bar2%(259), Ball%(146), BarMask%(259), BallMask%(146)

DIM SHARED MaxChannel%, MaxNotes%

CONST MaxPlay% = -1

TYPE InsType
 MMult AS INTEGER
 MLevel AS INTEGER
 MAttack AS INTEGER
 MSustain AS INTEGER
 CMult AS INTEGER
 CLevel AS INTEGER
 CAttack AS INTEGER
 CSustain AS INTEGER
END TYPE

TYPE ChannelType
 Defined AS INTEGER
 Speed AS SINGLE
 SongPtr AS INTEGER
 PStat AS SINGLE
 Octave AS INTEGER
 WaveForm AS INTEGER
 Flag AS INTEGER
 Flag2 AS INTEGER
 IsPlaying AS INTEGER
 IsDone AS INTEGER
END TYPE
 


DIM SHARED ChannelStat(1 TO 2) AS ChannelType
DIM SHARED SongBuf(1 TO 2) AS INTEGER
DIM SHARED CurrentIns AS InsType


SBInit


CLS

X% = LoadJamFile%("mking.mkj")

LoadFont

Place% = 1: Pointer% = 0: Mask% = 1: Diff% = 75

CLS
SCREEN 13
FOR X% = 0 TO 255: FSet X%, 0, 0, 0: NEXT
GOSUB GameInit

PlayAgain:
CloseChannels
CLS
SCREEN 13
MakePal
DelayRate! = 2


PlayAgin:
CLS
SCREEN 13
CLS
MakePal


Font "Pong Mania!! v2.0", 10, 2, 2, 3, 3, 0
Font "copyright 1995-1996 by", 55, 40, 1, 1, 2, 64
Font "Molnar \ Kucalaba Productions", 25, 55, 1, 1, 2, 64
FSet 128, 0, 50, 0
Font "Please select one of the following:", 0, 75, 1, 1, 5, 128

FOR X% = 191 TO 196
 FSet X%, 13, 13, 0
NEXT
 FSet 190, 50, 50, 0
 
Font "1 Player vs. Computer", 20, 95, 1, 1, 1, 190
Font "2 Players vs. Each Other", 0, 110, 1, 1, 1, 191
Font "Pick the Soundtrack", 20, 125, 1, 1, 1, 192
Font "Select the Difficulty", 10, 140, 1, 1, 1, 193
Font "Change Game Speed", 20, 155, 1, 1, 1, 194
Font "Stupid Text to Read if You're Bored", -65, 170, 1, 1, 1, 195
Font "Exit Pong Mania!! v2.0", -10, 185, 1, 1, 1, 196

High% = 1
KeyB: aa$ = INKEY$: IF aa$ = "" THEN GOTO KeyB
SELECT CASE aa$
 CASE CHR$(0) + "H": IF High% > 1 THEN High% = High% - 1 ELSE High% = 7
 CASE CHR$(0) + "P": IF High% < 7 THEN High% = High% + 1 ELSE High% = 1
 CASE CHR$(13): GOTO Final
END SELECT

FOR X% = 190 TO 196
 FSet X%, 13, 13, 0
NEXT

FSet 189 + High%, 50, 50, 0

GOTO KeyB
Final:
SWAP Choice%, High%
SELECT CASE Choice%
 CASE 1: GetInput
 CASE 2: Get2Input
 CASE 3: SoundSelect: GOTO PlayAgin
 CASE 4: GetDif: GOTO PlayAgin
 CASE 5: GetSpeed: GOTO PlayAgin
 CASE 6: LooseEnds: GOTO PlayAgin
 CASE 7: CLS : SCREEN 0: WIDTH 80: SYSTEM
 CASE ELSE: GOTO PlayAgin
END SELECT

BuildPalette
GOSUB SetGameVariables
GOSUB UpdateBoard

DO


 SELECT CASE BallDir%
    CASE 1: BallHor% = BallHor% - Fast%
            BallVert% = BallVert% - Fast%
    CASE 2: BallHor% = BallHor% + Fast%
            BallVert% = BallVert% - Fast%
    CASE 3: BallHor% = BallHor% - Fast%
            BallVert% = BallVert% + Fast%
    CASE 4: BallHor% = BallHor% + Fast%
            BallVert% = BallVert% + Fast%
 END SELECT



  SELECT CASE BallHor%
   CASE IS <= MaxWest%: SELECT CASE POINT(BallHor% + 1, BallVert% + 9)
                         CASE IS <> 0, -1
                                  IF BallDir% = 1 THEN BallDir% = MoveNE%
                                  IF BallDir% = 3 THEN BallDir% = MoveSE%
                         CASE ELSE: Player1% = Player1% + 1: GOSUB UpdateBoard
                        END SELECT
   CASE IS >= MaxEast%: SELECT CASE POINT(BallHor% + 16, BallVert% + 7)
                          CASE IS <> 0, -1
                                   IF BallDir% = 2 THEN BallDir% = MoveNW%
                                   IF BallDir% = 4 THEN BallDir% = MoveSW%
                          CASE ELSE: Player2% = Player2% + 1: GOSUB UpdateBoard
                        END SELECT
  END SELECT

  SELECT CASE BallVert%
   CASE IS <= MaxNorth%: SELECT CASE BallDir%
                          CASE 1: BallDir% = MoveSW%
                          CASE 2: BallDir% = MoveSE%
                         END SELECT
   CASE IS >= MaxSouth%: SELECT CASE BallDir%
                          CASE 3: BallDir% = MoveNW%
                          CASE 4: BallDir% = MoveNE%
                         END SELECT
  END SELECT
 
  SELECT CASE Choice%
   CASE 1: GOSUB OnePlayerLogic
   CASE 2: GOSUB TwoPlayerLogic
  END SELECT
 
  SELECT CASE Bar1Dir%
   CASE 1: IF Bar1Vert% > BarNorth% THEN Bar1Vert% = Bar1Vert% - 1
   CASE 2: IF Bar1Vert% < BarSouth% THEN Bar1Vert% = Bar1Vert% + 1
  END SELECT
  PlayMusic
  SELECT CASE Bar2Dir%
   CASE 1: IF Bar2Vert% > BarNorth% THEN Bar2Vert% = Bar2Vert% - 1
   CASE 2: IF Bar2Vert% < BarSouth% THEN Bar2Vert% = Bar2Vert% + 1
  END SELECT

 LINE (160, 11)-(160, 198), 254
 PUT (BallHor%, BallVert%), Ball%, PSET
 PUT (Bar1Hor%, Bar1Vert%), Bar1%, PSET
 PUT (Bar2Hor%, Bar2Vert%), Bar2%, PSET

 Delay DelayRate!

 IF Retart% \ 2 = Retart% / 2 THEN Cycle255
 IF Retart% = 15000 THEN Retart% = 0
 Retart% = Retart% + 1
LOOP

GameInit:
DrawBarsNBall

GET (0, 89)-(11, 131), Bar1%
GET (309, 89)-(320, 131), Bar2%
GET (143, 92)-(159, 108), Ball%
LINE (143, 92)-(159, 108), 0, BF
ImageGotten% = 1
RETURN

UpdateBoard:
IF Player1% = 7 OR Player2% = 7 THEN GOSUB Gameover
CLS
LOCATE 1, 1
Banner$ = Name1$ + STR$(Player1%) + SPACE$(10) + Name2$ + STR$(Player2%)
PRINT Banner$
BallDir% = INT(RND * 4) + 1
BallVert% = 100
BallHor% = 152
Bar1Hor% = 0
Bar1Vert% = 89
Bar2Hor% = 308
Bar2Vert% = 89
Bar1Dir% = 3
Bar2Dir% = 3
PUT (Bar1Hor%, Bar1Vert%), Bar1%, PSET
PUT (Bar2Hor%, Bar2Vert%), Bar2%, PSET
PUT (BallHor%, BallVert%), Ball%, PSET
LINE (160, 11)-(160, 199), 254
LINE (0, 10)-(320, 10), 255
LINE (0, 199)-(320, 199), 255
OUT &H3C8, 255
OUT &H3C9, 63
OUT &H3C9, 0
OUT &H3C9, 0
LOCATE 10, 18: PRINT "Ready?": DO: PlayMusic: LOOP UNTIL INKEY$ <> "": LOCATE 10, 18: PRINT "      "
LINE (160, 11)-(160, 199), 254
LINE (0, 10)-(320, 10), 255
LINE (0, 199)-(320, 199), 255
RETURN

Gameover:
CloseChannels
CLS
IF Player1% = 7 THEN Victor$ = Record2$ ELSE Victor$ = Record1$
MakePal
Font "Game Over!", 20, 10, 3, 3, 4, 0
Font Victor$ + " is the Pong Champion!", 2, 50, 1, 3, 3, 63
Font "Play Again?  (Y/N) ", 70, 90, 1, 1, 5, 128

A$ = INPUT$(1)

IF UCASE$(A$) = "N" THEN
 CLS : SCREEN 0: WIDTH 80
 SYSTEM
 ELSE GOTO PlayAgain
END IF

RETURN

SetGameVariables:
MoveNW% = 1
MoveNE% = 2
MoveSW% = 3
MoveSE% = 4
BallVert% = 100
BallHor% = 160
Fast% = 1
BarNorth% = 11
BarSouth% = 156
MaxNorth% = 11
MaxSouth% = 182
MaxWest% = 9
MaxEast% = 293
Bar1Hor% = 0
Bar1Vert% = 89
Bar2Hor% = 308
Bar2Vert% = 89
Gameover% = 7
Player1% = 0
Player2% = 0
RETURN

TwoPlayerLogic:
    aa$ = INKEY$
    SELECT CASE UCASE$(aa$)
     CASE "W": Bar1Dir% = 1
     CASE "X": Bar1Dir% = 2
     CASE "S": Bar1Dir% = 3
     CASE CHR$(27): GOTO PlayAgain
     CASE CHR$(0) + "H": Bar2Dir% = 1
     CASE CHR$(0) + "P": Bar2Dir% = 2
     CASE CHR$(13): Bar2Dir% = 3
    END SELECT
RETURN


OnePlayerLogic:
    aa$ = INKEY$
    SELECT CASE UCASE$(aa$)
     CASE CHR$(27): GOTO PlayAgain
     CASE CHR$(0) + "H": Bar1Dir% = 1
     CASE CHR$(0) + "P": Bar1Dir% = 2
     CASE CHR$(13): Bar1Dir% = 3
    END SELECT
    Rand% = INT(RND * Diff%) + 1
    SELECT CASE Rand%
     CASE 1: Rand% = 50
     CASE ELSE: Rand% = 10
    END SELECT
    SELECT CASE Bar2Vert% + 23
     CASE IS > BallVert% - Rand%: Bar2Dir% = 1
     CASE IS < BallVert% - Rand%: Bar2Dir% = 2
     CASE ELSE: Bar2Dir% = 3
    END SELECT
RETURN

REM $STATIC
SUB BuildPalette
PALETTE
Offset% = 30
FOR Times% = 1 TO 10
 OUT &H3C8, Times%
 OUT &H3C9, Offset%
 OUT &H3C9, Offset%
 OUT &H3C9, Offset%
 Offset% = Offset% + 3
NEXT
Offset% = 30
FOR Times% = 200 TO 207
 OUT &H3C8, Times%
 OUT &H3C9, Offset%
 OUT &H3C9, 0
 OUT &H3C9, 0
 Offset% = Offset% + 4
NEXT
END SUB

DEFSNG A-Z
SUB Center (Row, Text$)
LOCATE Row, 41 - LEN(Text$) / 2
PRINT Text$;
END SUB

SUB CloseChannels
IF MaxChannel% > 4 THEN FirstLoop% = 3 ELSE FirstLoop% = MaxChannel%
 FOR Channel% = 0 TO 15
  WriteReg &HB0 + Channel%, 0
 NEXT
END SUB

DEFINT A-Z
SUB Controls
CLS
Font "Your controls are:", 2, 0, 2, 2, 3, 0
Font "Move Up : Up arrow key", 0, 50, 1, 1, 5, 128
Font "Move Down : Down arrow key", 0, 65, 1, 1, 5, 128
Font "Stop Moving : Enter key", 0, 80, 1, 1, 5, 128
GetPress
END SUB

SUB Controls2
CLS
Font "The controls are : ", 2, 0, 2, 2, 3, 0
IF LEN(Record1$) > 10 THEN Aka$ = LEFT$(Record1$, 10) ELSE Aka$ = Record1$
Font "The first player (bar on the left)", 0, 30, 1, 1, 2, 63
Font "aka " + Record1$ + " :", 10, 45, 1, 1, 2, 63
Font "Move Up : The 'W' key", 0, 60, 1, 1, 5, 128
Font "Move Down : The 'X' key", 0, 75, 1, 1, 5, 128
Font "Stop Moving : The 'S' key", 0, 90, 1, 1, 5, 128

Font "The second player (bar on the right)", 0, 120, 1, 1, 2, 63
Font "aka " + Record2$ + " :", 10, 135, 1, 1, 2, 63
Font "Move Up : The up arrow key", 0, 150, 1, 1, 5, 128
Font "Move Down : The down arrow key", 0, 165, 1, 1, 5, 128
Font "Stop Moving : The Enter key", 0, 180, 1, 1, 5, 128
GetPress
END SUB

SUB Cycle255
SHARED Pointer%, Mask%
OUT &H3C8, 254
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, Pointer%
 SELECT CASE Mask%
  CASE 1: Pointer% = Pointer% + 1
  CASE 2: Pointer% = Pointer% - 1
 END SELECT
 SELECT CASE Pointer%
  CASE 63: Mask = 2
  CASE 20: Mask = 1
 END SELECT

END SUB

DEFSNG A-Z
SUB Delay (msecs) STATIC
 IF sysfact& THEN
      IF msecs THEN
      count& = (sysfact& * msecs) \ -54
      DO
       count& = count& + 1
       IF count& = z THEN EXIT DO
      LOOP UNTIL t2 = PEEK(&H6C)
      END IF
 ELSE
  DEF SEG = &H40
  t1 = PEEK(&H6C)
  DO
  t2 = PEEK(&H6C)
  LOOP UNTIL t2 <> t1
  DO
   sysfact& = sysfact& + 1
   IF sysfact& = z THEN EXIT DO
  LOOP UNTIL t2 <> PEEK(&H6C)
 t2 = 256
END IF
DEF SEG
END SUB

DEFINT A-Z
SUB DrawBarsNBall
LINE (1, 90)-(10, 130), 31, BF
LINE (310, 90)-(319, 130), 31, BF
x1% = 1: X2% = 10: y1% = 90: Y2% = 130
FOR SaveSpace% = 1 TO 2
 FOR Repeat% = 10 TO 5 STEP -1
  LINE (x1%, y1%)-(X2%, Y2%), Repeat%, BF
  x1% = x1% + 1
  y1% = y1% + 1
  X2% = X2% - 1
  Y2% = Y2% - 1
 NEXT
x1% = 310: X2% = 319: y1% = 90: Y2% = 130
NEXT
CIRCLE (151, 100), 7, 31
PAINT (151, 100), 31, 31
Offset% = 200
 FOR Size% = 7 TO 0 STEP -1
  CIRCLE (151, 100), Size%, Offset%
  PAINT (151, 100), Offset%, Offset%
  Offset% = Offset% + 1
 NEXT

END SUB

DEFSNG A-Z
SUB Font (Text$, XStart%, ystart%, xscale%, Yscale%, Style%, Clr%)
px% = XStart%
py% = ystart%

LHeight% = Yscale% * 8

DEF SEG = VARSEG(FontBuf(0))

 FOR h% = 1 TO LEN(Text$)
  FPtr% = 81 * (ASC(MID$(Text$, h%, 1)) - 1) - 1
  FOR X% = 0 TO 8
   FOR y% = 0 TO 8
 
    Col% = PEEK(VARPTR(FontBuf(0)) + FPtr%)
    FPtr% = FPtr% + 1

    IF Col% THEN
     SELECT CASE Style%
      CASE 1:
            IF Yscale% = 1 THEN
              PSET (px% + .4 * py%, py%), Clr%
            ELSE
             FOR sx% = px% TO px% + xscale%
              FOR sy% = py% TO py% + Yscale%
               PSET (sx% + .4 * sy%, sy%), Clr%
              NEXT
             NEXT
            END IF
      CASE 2: CIRCLE (px%, py%), Yscale%, (54 \ LHeight%) * (py% - ystart%) + Clr% + 9, , , 4
      CASE 3:  FOR sty% = px% TO px% + xscale%
                FOR sty2% = py% TO py% + Yscale%
                 PSET (sty%, sty2%), (63 \ LHeight%) * (sty2% - ystart%) + Clr%
                 IF POINT(sty% - 1, sty2%) = 0 THEN PSET (sty% - 1, sty2%), 63 + Clr% - 1
                 IF POINT(sty%, sty2% - 1) = 0 THEN PSET (sty%, sty2% - 1), 63 + Clr% - 1
                NEXT
               NEXT
       CASE 4: FOR sty% = px% TO px% + xscale%
                FOR sty2% = py% TO py% + Yscale%
                 PSET (sty% + .4 * sty2%, sty2%), (63 \ LHeight%) * (sty2% - ystart%) + Clr%
                 IF POINT((sty% - 1) + .4 * sty2%, sty2%) = 0 THEN PSET ((sty% - 1) + .4 * sty2%, sty2%), 63 + Clr% - 1
                NEXT
               NEXT
       CASE 5: PSET (px%, py%), (63 \ LHeight%) * (py% - ystart%) + Clr%
               PSET (px% + 1, py% + 1), Clr% - 20
      END SELECT
    END IF
    py% = py% + Yscale%
   NEXT
  px% = px% + xscale%
  py% = ystart%
  NEXT
 NEXT h%
DEF SEG
END SUB

DEFINT A-Z
SUB FormatStrings
 IF Name2$ = "" THEN Name2$ = "Bill W"
 IF Name1$ = "" THEN Name1$ = "NAC Freak"
 IF LEN(Name1$) < 11 THEN Name1$ = Name1$ + SPACE$((10 - LEN(Name1$)))
 IF LEN(Name2$) < 11 THEN Name2$ = Name2$ + SPACE$((10 - LEN(Name2$)))
 Name1$ = LEFT$(Name1$, 10) + ":"
 Name2$ = LEFT$(Name2$, 10) + ":"
END SUB

SUB FSet (Att%, R%, g%, B%)
OUT &H3C8, Att%
OUT &H3C9, R%
OUT &H3C9, g%
OUT &H3C9, B%
END SUB

SUB Get2Input
CLS
Font "Player 1 : ", 0, 10, 1, 1, 1, 128
Name1$ = lnput(10, 98, 10)
Font "Player 2 : ", -8, 30, 1, 1, 1, 128
Name2$ = lnput(10, 98, 30)
Record1$ = Name1$
Record2$ = Name2$
FormatStrings
SeeControls
END SUB

SUB GetDif
CLS
Font "Select the desired difficulty level", 2, 10, 1, 3, 3, 0

FOR X% = 191 TO 194
 FSet X%, 13, 13, 0
NEXT

FSet 190, 50, 50, 0
High% = 1
Font "I am now housebroken, barely", 0, 55, 1, 1, 1, 190
Font "My mother still dresses me", 5, 70, 1, 1, 1, 191
Font "I wrote my own version of Pong", -22, 85, 1, 1, 1, 192
Font "I wrote *this* version of Pong!", -28, 100, 1, 1, 1, 193

Font "Use the  and  keys to choose.", 20, 160, 1, 1, 5, 128
Font "Press Enter or Escape to leave.", 20, 175, 1, 1, 5, 128

DO
aa$ = INKEY$
 SELECT CASE aa$
  CASE CHR$(0) + "P": IF High% < 4 THEN High% = High% + 1 ELSE High% = 1
  CASE CHR$(0) + "H": IF High% > 1 THEN High% = High% - 1 ELSE High% = 4
  CASE CHR$(13), CHR$(27): EXIT DO
 END SELECT
 IF aa$ <> "" THEN
  FOR X% = 190 TO 194
   FSet X%, 13, 13, 0
  NEXT
  FSet 189 + High%, 50, 50, 0

 END IF
LOOP

SELECT CASE High%
 CASE 1: Diff% = 46
 CASE 2: Diff% = 75
 CASE 3: Diff% = 130
 CASE 4: Diff% = 32766
END SELECT

END SUB

SUB GetInput
CLS
Font "What is your name : ", 0, 0, 1, 1, 1, 128
Name1$ = lnput(10, 175, 0)
Record1$ = Name1$
Name2$ = "Computer"
Record2$ = "Computer"
FormatStrings
SeeControls
END SUB

DEFSNG A-Z
SUB GetPress
DO: LOOP WHILE INKEY$ = ""
END SUB

DEFINT A-Z
SUB GetSpeed
CLS
Font "Speed Select", 50, 10, 2, 3, 3, 0
ResetSong
Font "Use the + and - keys to slow down", 10, 45, 1, 1, 5, 128
Font "and speed up the ball, respectively.", 1, 60, 1, 1, 5, 128
F% = 30
FOR X% = 200 TO 207
 FSet X%, F%, 0, 0
 F% = F% + 4
NEXT
FSet 255, 0, 53, 0

LINE (2, 80)-(317, 199), 255, B
BallX% = 155
BallY% = 140
XDir% = 1
YDir% = 1

DO

 PUT (BallX%, BallY%), Ball%, PSET

 BallX% = BallX% + XDir%
 BallY% = BallY% + YDir%

 IF BallX% = 3 THEN XDir% = 1 ELSE IF BallX% = 300 THEN XDir% = -1
 IF BallY% = 81 THEN YDir% = 1 ELSE IF BallY% = 182 THEN YDir% = -1

 PlayMusic

 Delay DelayRate!

 aa$ = INKEY$

 SELECT CASE aa$
  CASE "+": IF DelayRate < 5 THEN DelayRate! = DelayRate! + 1
  CASE "-": IF DelayRate! > 0 THEN DelayRate! = DelayRate! - 1
  CASE CHR$(13), CHR$(27): CLS : ResetSong: EXIT SUB
 END SELECT

LOOP
GetPress

END SUB

DEFSNG A-Z
FUNCTION lnput$ (L%, Row%, Col%)
Orow% = Row%
txt$ = ""

FOR Times% = 1 TO L%
 Font "_", Row% + Times% * 8 - 10, Col% + 4, 1, 2, 2, 7
NEXT

DO
ax$ = INKEY$
SELECT CASE ax$
 CASE CHR$(8):  IF LEN(txt$) > 0 THEN txt$ = LEFT$(txt$, LEN(txt$) - 1)
                IF Orow% < Row% THEN Row% = Row% - 8
                LINE (Row%, Col%)-(Row% + 8, Col% + 19), 0, BF
 CASE " ":  Row% = Row% + 8: txt$ = txt$ + " "
 CASE CHR$(13): lnput$ = txt$: EXIT FUNCTION
 CASE CHR$(27): lnput$ = txt$: EXIT FUNCTION
 CASE ELSE:
            IF LEN(txt$) < L% AND LEN(ax$) = 1 THEN
             txt$ = txt$ + ax$
             Font ax$, Row%, Col%, 1, 1, 5, 128
             Row% = Row% + 8
            END IF

END SELECT
LOOP
END FUNCTION

SUB LoadFont
OPEN "basefont.dat" FOR BINARY AS #1
 IF LOF(1) < 2 THEN
  CLOSE
  KILL "basefont.dat"
  PRINT "Font Data File not located, cannot run Pong Mania."
  GetPress
  SYSTEM
 END IF

 GET #1, , FontBuf(0)

CLOSE #1
END SUB

FUNCTION LoadJamFile% (File$)
SBInit

OPEN File$ FOR BINARY AS #1

 IF LOF(1) < 2 THEN
  CLOSE #1
  KILL File$
  LoadJamFile% = -1
  EXIT FUNCTION
 END IF

 IF INPUT$(6, #1) <> "MKJamz" THEN
   LoadJamFile% = -2
   EXIT FUNCTION
 END IF

 GET #1, , Version!
 IF Version! > 1.1 THEN
  LoadJamFile% = -3
  EXIT FUNCTION
 END IF

 GET #1, , MaxChannel%

  FOR X% = 1 TO MaxChannel%
    GET #1, , CurrentIns
    Save% = X%
    SetIns X%
    X% = Save%
   NEXT

 GET #1, , MaxNotes%

  ERASE SongBuf, ChannelStat

  REDIM SongBuf(1 TO (MaxChannel% + 1) * MaxNotes%) AS INTEGER
  REDIM ChannelStat(1 TO MaxChannel%) AS ChannelType

  FOR X% = 1 TO MaxChannel%
    GET #1, , ChannelStat(X%).Defined
    ChannelStat(X%).SongPtr = 1
    ChannelStat(X%).Octave = 4
  NEXT

  RemBytes& = LOF(1) - LOC(1)
 
  BufferSize% = 2000           ' The buffer size to use.
 

  LeftBytes& = RemBytes& MOD BufferSize% ' The amount of left over bytes

  IF (LeftBytes& < RemBytes&) THEN
    FOR QuickLoad% = 1 TO (RemBytes& - LeftBytes&) / BufferSize%
       Buffer$ = INPUT$(BufferSize%, #1) ' Load all the data into buffer
         FOR X% = 1 TO LEN(Buffer$)
            DEF SEG = VARSEG(SongBuf(1)) ' The segment of the song buffer
            POKE VARPTR(SongBuf(1)) + Ptr&, ASC(MID$(Buffer$, X%, 1))
            DEF SEG
            Ptr& = Ptr& + 1
         NEXT
       RemBytes& = RemBytes& - BufferSize%
    NEXT
  END IF

  IF (LeftBytes& > 0) THEN
    Buffer$ = INPUT$(LeftBytes&, #1)
     FOR X% = 1 TO LEN(Buffer$)
        DEF SEG = VARSEG(SongBuf(1)) ' The segment of the song buffer
        POKE VARPTR(SongBuf(1)) + Ptr&, ASC(MID$(Buffer$, X%, 1))
        DEF SEG
        Ptr& = Ptr& + 1
     NEXT
   END IF

  DEF SEG

CLOSE #1

LoadJamFile% = 1

END FUNCTION

DEFINT A-Z
SUB LooseEnds
CLS
Font "Stupid Rubbish That You Will Read", 10, 0, 1, 3, 3, 0
Font "You play until someone", 60, 30, 1, 1, 5, 128
Font "reaches 7 points.", 80, 45, 1, 1, 5, 128
Font "Do something worthwhile!  Add some", 0, 65, 1, 1, 2, 64
Font "meaning to your life!  Visit us on", 0, 80, 1, 1, 2, 64
Font "the Internet via FTP & WWW!", 30, 95, 1, 1, 2, 64
Font "WWW", 60, 110, 3, 3, 4, 0
Font "http://members.aol.com/mkwebsite/", 10, 135, 1, 1, 5, 128
Font "ftp", 45, 150, 3, 3, 4, 0
Font "ftp://users.aol.com/blood225/", 20, 175, 1, 1, 5, 128
GetPress
END SUB

SUB MakePal
FOR X% = 1 TO 63
 FSet X%, X%, 0, 0
 FSet X% + 63, 0, 0, X%
 FSet X% + 126, X%, 0, X%
NEXT
END SUB

DEFSNG A-Z
SUB PlayMusic

FOR Channel% = 1 TO MaxChannel%

  IF ChannelStat(Channel%).Defined = 0 THEN GOTO NoGotosPlease

  RChan% = Channel% - 1

  IF ChannelStat(Channel%).IsDone = 1 THEN
   ChannelStat(Channel%).PStat = TIMER + ChannelStat(Channel%).Speed
   ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
   ChannelStat(Channel%).IsDone = 0
   ChannelStat(Channel%).IsPlaying = 0
  END IF

   IF ChannelStat(Channel%).IsPlaying = 0 AND SongBuf(ChannelStat(Channel%).SongPtr + Channel% - 1) <> 0 THEN
    ChannelStat(Channel%).PStat = TIMER + ChannelStat(Channel%).Speed
     SELECT CASE SongBuf(ChannelStat(Channel%).SongPtr + RChan%)
       CASE 68   ' "D"
         WriteReg &HA0 + RChan%, &H81
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 69   ' "E"
         WriteReg &HA0 + RChan%, &HB0
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 70   ' "F"
         WriteReg &HA0 + RChan%, &HCA
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 71    ' "G"
         WriteReg &HA0 + RChan%, &H2
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
       CASE 65 ' "A"
         WriteReg &HA0 + RChan%, &H41
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
       CASE 66   ' "B"
         WriteReg &HA0 + RChan%, &H87
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
       CASE 67  '  "C"
         WriteReg &HA0 + RChan%, &HAE
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
       CASE 17 ' "C#"
         WriteReg &HA0 + RChan%, &H6B
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 18 ' "D#"
         WriteReg &HA0 + RChan%, &H98
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 20 ' F#"
         WriteReg &HA0 + RChan%, &HE5
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 21 ' "G#"
         WriteReg &HA0 + RChan%, &H20
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
       CASE 15 ' "A#"
         WriteReg &HA0 + RChan%, &H63
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
      
       CASE 255
         ChannelStat(Channel%).IsPlaying = 1
         ChannelStat(Channel%).PStat = TIMER + (SongBuf(ChannelStat(Channel%).SongPtr + Channel% - 1 + MaxChannel%) / 100)
         ChannelStat(Channel%).Flag = -1
       CASE 254
         ChannelStat(Channel%).Octave = SongBuf(ChannelStat(Channel%).SongPtr + Channel% - 1 + MaxChannel%)
         ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
       CASE 253
         ChannelStat(Channel%).Speed = (SongBuf(ChannelStat(Channel%).SongPtr + Channel% - 1 + MaxChannel%) / 100)
         ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
       CASE 252
         ChannelStat(Channel%).WaveForm = SongBuf(ChannelStat(Channel%).SongPtr + Channel% - 1 + MaxChannel%) - 300
         ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
         IF RChan% > 2 THEN RRChan% = RChan% + 6 ELSE RRChan% = 0
         WriteReg &HE0 + RChan% + RRChan%, ChannelStat(Channel%).WaveForm
       CASE 251
         ResetSong
         ChannelStat(1).Flag2 = -1
          CloseChannels
          EXIT SUB
     END SELECT
   END IF

    IF ChannelStat(Channel%).IsPlaying = 1 THEN
     IF TIMER >= ChannelStat(Channel%).PStat THEN
      WriteReg &HB0 + RChan%, 0
      ChannelStat(Channel%).IsDone = 1
       IF ChannelStat(Channel%).Flag = -1 THEN
        ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
        ChannelStat(Channel%).Flag = 0
       END IF
     END IF
    END IF
 
   IF ChannelStat(Channel%).SongPtr > MaxChannel% + 1 THEN
     IF SongBuf(ChannelStat(Channel%).SongPtr + RChan%) <> 0 AND SongBuf(ChannelStat(Channel%).SongPtr - MaxChannel% + RChan%) < 250 THEN
       IF ChannelStat(Channel%).IsPlaying = 0 THEN ChannelStat(Channel%).IsPlaying = 1
     END IF
   END IF

NoGotosPlease:
NEXT Channel%


FOR Channel% = 1 TO MaxChannel%

 IF ChannelStat(Channel%).IsPlaying = 0 THEN
  ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
  IF ChannelStat(Channel%).SongPtr >= UBOUND(SongBuf) / MaxChannel% THEN
   ChannelStat(Channel%).SongPtr = 1
  END IF
 END IF
NEXT Channel%



END SUB

SUB ResetSong
     CloseChannels
           FOR X% = 1 TO MaxChannel%
             ChannelStat(X%).IsPlaying = 0
             ChannelStat(X%).IsDone = 0
             ChannelStat(X%).SongPtr = 1
             ChannelStat(X%).Flag = 0
            NEXT

END SUB

SUB SBInit
   FOR z% = 1 TO 244
      WriteReg z%, 0
   NEXT z%
END SUB

DEFINT A-Z
SUB SeeControls
CLS
Font "Do you wish to see the controls?", 10, 90, 1, 1, 5, 128
DO
YorN$ = INKEY$
LOOP UNTIL YorN$ <> ""
 IF UCASE$(YorN$) = "Y" THEN
  IF Choice% = 1 THEN Controls ELSE Controls2
 END IF
CLS
ResetSong
END SUB

DEFSNG A-Z
SUB SetIns (Channel%)

Channel% = Channel% - 1
CarChan% = Channel%
ModChan% = Channel%

IF Channel% >= 3 THEN
 CarChan% = CarChan% + 5
 ModChan% = ModChan% + 5
END IF

WriteReg &H20 + CarChan%, CurrentIns.CMult
WriteReg &H23 + ModChan%, CurrentIns.MMult
WriteReg &H40 + CarChan%, CurrentIns.CLevel
WriteReg &H43 + ModChan%, CurrentIns.MLevel
WriteReg &H60 + CarChan%, CurrentIns.CAttack
WriteReg &H63 + ModChan%, CurrentIns.MAttack
WriteReg &H80 + CarChan%, CurrentIns.CSustain
WriteReg &H83 + ModChan%, CurrentIns.MSustain
END SUB

DEFINT A-Z
SUB SoundSelect
FOR X% = 190 TO 194
 FSet X%, 13, 13, 0
NEXT

FSet 190, 50, 50, 0
CLS
Place% = 1
ret% = LoadJamFile%("mking.mkj")
Font "Pick a song foo", 22, 10, 2, 3, 3, 0

Font "In the Hall of the Mountain King", -15, 60, 1, 2, 1, 190
Font "Moonlight Sonata", -20, 90, 2, 2, 1, 191
Font "Groovy Song", 10, 120, 2, 2, 1, 192

Font "Use the  and  keys to choose.", 20, 160, 1, 1, 5, 128
Font "Press Enter or Escape to leave.", 20, 175, 1, 1, 5, 128
Inky:
PlayMusic
aa$ = INKEY$: IF aa$ = "" THEN GOTO Inky

SELECT CASE UCASE$(aa$)
 CASE CHR$(0) + "H": IF Place% > 1 THEN Place% = Place% - 1 ELSE Place% = 3

 CASE CHR$(0) + "P": IF Place% < 3 THEN Place% = Place% + 1 ELSE Place% = 2

 CASE CHR$(13), CHR$(27): ResetSong
                EXIT SUB
 CASE ELSE: GOTO Inky

END SELECT

FOR X% = 190 TO 194
 FSet X%, 13, 13, 0
NEXT
FSet 189 + Place%, 50, 50, 0

IF Place% = 1 THEN Name$ = "mking.mkj" ELSE IF Place% = 2 THEN Name$ = "sonata.mkj" ELSE Name$ = "groovy.mkj"
ret% = LoadJamFile(Name$)
GOTO Inky


END SUB

SUB WriteReg (Reg%, value%)
OUT BasePort% + 8, Reg%
 FOR V% = 1 TO 6
  Buf% = INP(BasePort% + 8)
 NEXT
OUT BasePort% + 9, value%
 FOR V% = 1 TO 34
  Buf% = INP(BasePort% + 9)
 NEXT
END SUB

