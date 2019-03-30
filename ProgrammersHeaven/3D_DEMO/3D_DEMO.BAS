' ษอออออออออออออออออออออออออออออหออออออออออออออออออออออออออออออออออออออออออป
' บ     The QBasic 3D Demo:     บ        Jester World Inc. Members:        บ
' บ                             บ                                          บ
' บ This Demo shows the 3D look บ               Death Jester               บ
' บ and feel in my new upcoming ฬออออออออออออออออออออออออออออออออออออออออออน
' บ series of 3D games. I think บ Yes...there is only ONE person who is in บ
' บ that this 3D Demo will be a บ Jester World Inc. That means, that I did บ
' บ vast improvment in programs บ EVERYTHING by myself. The Artwork, Font, บ
' บ made with Qbasic. Also, all บ 3D Engine, Maps, Research, and Uploading บ
' บ games could now go 3D. This บ the Demo. So that means that I am a one- บ
' บ is a Demo that holds 3 maps บ man Production Company. Does anyone wish บ
' บ to check out. I am creating บ to join Jester World? Or help me? I will บ
' บ a program that will be a 3D บ be grateful if someone helped me because บ
' บ game creation system, but I บ doing all of this work is hard. Also, if บ
' บ will Upload the program, if บ you are interrested in this Demo, or any บ
' บ I get a great responce from บ other thing that I am working on, E-Mail บ
' บ this Demo.                  บ me at:         74563,1436@COMPUSERVE.COM บ
' บ                Death Jester บ          OR           Jester9819@AOL.COM บ
' ศอออออออออออออออออออออออออออออสออออออออออออออออออออออออออออออออออออออออออผ

DECLARE SUB Font (aa$, xx%, yy%)
DECLARE SUB Number (aa&, xx%, yy%)
DECLARE SUB Prepare4Graphics ()
DECLARE SUB Compass (direction$)
DECLARE SUB Status (PlayerName$, PlayerRace$, PlayerSex$, PlayerHit&, PlayerMagic&, PlayerGold&, MapNumber&)
DECLARE SUB lw1 ()
DECLARE SUB lw2 ()
DECLARE SUB lw3 ()
DECLARE SUB rw1 ()
DECLARE SUB rw2 ()
DECLARE SUB rw3 ()
DECLARE SUB fw1 ()
DECLARE SUB fw2 ()
DECLARE SUB fw3 ()
DECLARE SUB mlw1 ()
DECLARE SUB mlw2 ()
DECLARE SUB mlw3 ()
DECLARE SUB mrw1 ()
DECLARE SUB mrw2 ()
DECLARE SUB mrw3 ()
DECLARE SUB mllw1 ()
DECLARE SUB mllw2 ()
DECLARE SUB mllw3 ()
DECLARE SUB mlrw1 ()
DECLARE SUB mlrw2 ()
DECLARE SUB mlrw3 ()

DEFINT A-Z

TheUsualStuff:
 
  TYPE HUES
    red AS INTEGER
    grn AS INTEGER
    blu AS INTEGER
  END TYPE

  DIM SHARED WallPiece(1 TO 7000), Borderart(1 TO 500), CompassLetter(1 TO 1500), Map$(20)

  CLS
  RANDOMIZE TIMER

  Prepare4Graphics

  PlayerName$ = "DEATH JESTER"
  PlayerRace$ = "MYRRAAN"
  PlayerSex$ = "MALE"
  PlayerHit& = 35
  PlayerMagic& = 19
  PlayerGold& = 0

  StatusChange$ = "1"
  locationx = 4
  locationy = 4
  Look$ = "N"
  MapNumber& = 1
  GOSUB Map1

StartUpInformation:
         
          Font "THANK YOU FOR DOWNLOADING THIS 3D DEMO. I HOPE YOU", 1, 1
          Font "ENJOY THE ENGINE AND THE WONDERFUL 3D EFFECTS THAT", 1, 7
          Font "IT CAN PRODUCE. IF YOU ARE INTERRESTED IN THIS, OR", 1, 13
          Font "YOU WOULD LIKE TO JOIN MY GROUP, CONTACT ME AND WE", 1, 19
          Font "CAN WORK THIS OUT. AND REMEMBER, THERE IS ONLY ONE", 1, 25
          Font "PERSON WORKING ON THIS PROJECT...ME!              ", 1, 31
          Font "        SO, I WOULD APPRECIATE SOME HELP.         ", 1, 43
          Font "          MAKE SURE THAT YOUR CAPS LOCK           ", 1, 69
          Font "            AND NUM LOCK KEYS ARE ON.             ", 1, 75
          Font "          MOVE AROUND WITH THE KEY PAD            ", 3, 81
          Font "        AND TO QUIT AT ANY TIME, PRESS Q          ", 3, 87
          Font "  SEARCH THROUGHOUT THE MAZE, AND FIND THE EXIT.  ", 1, 117
          Font " WHEN YOU FIND THE EXIT YOU WILL BE TELEPORTED TO ", 1, 123
          Font " THE NEXT MAP. AND BEWARE, THE EXIT LOOKS LIKE A ", 3, 129
          Font "   NORMAL WALL, SO GO DOWN EVERY HALL YOU FIND.   ", 1, 135
  a$ = INPUT$(1)

ChooseBorderArt:

  CLS
         
          Font "PLEASE CHOOSE A BORDER FOR THE GAME", 1, 1
          Font "1.  FOREST GREEN", 1, 17:
          Font "2.  GRAY STONE", 1, 38
          Font "3.  FIRE ROCK", 1, 60
 
  DEF SEG = VARSEG(Borderart(1)): BLOAD "border2.til", VARPTR(Borderart(1))
  PUT (122, 10), Borderart, PSET
 
  DEF SEG = VARSEG(Borderart(1)): BLOAD "border1.til", VARPTR(Borderart(1))
  PUT (122, 31), Borderart, PSET
 
  DEF SEG = VARSEG(Borderart(1)): BLOAD "border3.til", VARPTR(Borderart(1))
  PUT (122, 52), Borderart, PSET
 
  PlayerInput$ = INPUT$(1)

  IF PlayerInput$ = "1" THEN bordername$ = "Border2.til": GOTO DrawBorderArt
  IF PlayerInput$ = "2" THEN bordername$ = "Border1.til ": GOTO DrawBorderArt
  IF PlayerInput$ = "3" THEN bordername$ = "Border3.til": GOTO DrawBorderArt
  IF PlayerInput$ = "Q" THEN GOTO Quiting
 
  GOTO ChooseBorderArt

ReadMapData:

  IF MapNumber& = 1 THEN GOSUB Map1
  IF MapNumber& = 2 THEN GOSUB Map2
  IF MapNumber& = 3 THEN GOSUB Map3
  IF MapNumber& > 3 THEN END

DrawBorderArt:
 
  DEF SEG = VARSEG(Borderart(1)): BLOAD bordername$, VARPTR(Borderart(1))
  
  FOR borderx = 0 TO 300 STEP 20
    FOR bordery = 0 TO 180 STEP 20
      PUT (borderx, bordery), Borderart, PSET
    NEXT
  NEXT


PrintLookingDirection:

'  LOCATE 11, 2: PRINT look$
  HitWall$ = MID$(Map$(locationy), locationx, 1)

  IF HitWall$ = "1" THEN
    locationx = oldlocationx
    locationy = oldlocationy
    GOTO InputFromPlayer
  END IF
 
'  LOCATE 12, 1: PRINT locationx: LOCATE 12, 4: PRINT locationy
'  LOCATE 13, 2: PRINT "HitWall$ = "; HitWall$
                                                                 
LookingNorth:
 
  IF Look$ = "N" THEN
   
    dlw1$ = MID$(Map$(locationy), locationx - 1, 1)
    dlw2$ = MID$(Map$(locationy - 1), locationx - 1, 1)
    dlw3$ = MID$(Map$(locationy - 2), locationx - 1, 1)
   
    drw1$ = MID$(Map$(locationy), locationx + 1, 1)
    drw2$ = MID$(Map$(locationy - 1), locationx + 1, 1)
    drw3$ = MID$(Map$(locationy - 2), locationx + 1, 1)
   
    dfw1$ = MID$(Map$(locationy - 1), locationx, 1)
    dfw2$ = MID$(Map$(locationy - 2), locationx, 1)
    dfw3$ = MID$(Map$(locationy - 3), locationx, 1)
   
    dflw1$ = MID$(Map$(locationy - 1), locationx - 1, 1)
    dflw2$ = MID$(Map$(locationy - 2), locationx - 1, 1)
    dflw3$ = MID$(Map$(locationy - 3), locationx - 1, 1)
   
    dfrw1$ = MID$(Map$(locationy - 1), locationx + 1, 1)
    dfrw2$ = MID$(Map$(locationy - 2), locationx + 1, 1)
    dfrw3$ = MID$(Map$(locationy - 3), locationx + 1, 1)
 
  END IF

LookingWest:

  IF Look$ = "W" THEN
   
    dlw1$ = MID$(Map$(locationy + 1), locationx, 1)
    dlw2$ = MID$(Map$(locationy + 1), locationx - 1, 1)
    dlw3$ = MID$(Map$(locationy + 1), locationx - 2, 1)
   
    drw1$ = MID$(Map$(locationy - 1), locationx, 1)
    drw2$ = MID$(Map$(locationy - 1), locationx - 1, 1)
    drw3$ = MID$(Map$(locationy - 1), locationx - 2, 1)
   
    dfw1$ = MID$(Map$(locationy), locationx - 1, 1)
    dfw2$ = MID$(Map$(locationy), locationx - 2, 1)
    dfw3$ = MID$(Map$(locationy), locationx - 3, 1)
   
    dflw1$ = MID$(Map$(locationy + 1), locationx - 1, 1)
    dflw2$ = MID$(Map$(locationy + 1), locationx - 2, 1)
    dflw3$ = MID$(Map$(locationy + 1), locationx - 3, 1)
   
    dfrw1$ = MID$(Map$(locationy - 1), locationx - 1, 1)
    dfrw2$ = MID$(Map$(locationy - 1), locationx - 2, 1)
    dfrw3$ = MID$(Map$(locationy - 1), locationx - 3, 1)
  END IF

LookingSouth:

  IF Look$ = "S" THEN
   
    dlw1$ = MID$(Map$(locationy), locationx + 1, 1)
    dlw2$ = MID$(Map$(locationy + 1), locationx + 1, 1)
    dlw3$ = MID$(Map$(locationy + 2), locationx + 1, 1)
   
    drw1$ = MID$(Map$(locationy), locationx - 1, 1)
    drw2$ = MID$(Map$(locationy + 1), locationx - 1, 1)
    drw3$ = MID$(Map$(locationy + 2), locationx - 1, 1)
   
    dfw1$ = MID$(Map$(locationy + 1), locationx, 1)
    dfw2$ = MID$(Map$(locationy + 2), locationx, 1)
    dfw3$ = MID$(Map$(locationy + 3), locationx, 1)
   
    dflw1$ = MID$(Map$(locationy + 1), locationx + 1, 1)
    dflw2$ = MID$(Map$(locationy + 2), locationx + 1, 1)
    dflw3$ = MID$(Map$(locationy + 3), locationx + 1, 1)
   
    dfrw1$ = MID$(Map$(locationy + 1), locationx - 1, 1)
    dfrw2$ = MID$(Map$(locationy + 2), locationx - 1, 1)
    dfrw3$ = MID$(Map$(locationy + 3), locationx - 1, 1)
 
  END IF

LookingEast:

  IF Look$ = "E" THEN
    dlw1$ = MID$(Map$(locationy - 1), locationx, 1)
    dlw2$ = MID$(Map$(locationy - 1), locationx + 1, 1)
    dlw3$ = MID$(Map$(locationy - 1), locationx + 2, 1)
   
    drw1$ = MID$(Map$(locationy + 1), locationx, 1)
    drw2$ = MID$(Map$(locationy + 1), locationx + 1, 1)
    drw3$ = MID$(Map$(locationy + 1), locationx + 2, 1)
   
    dfw1$ = MID$(Map$(locationy), locationx + 1, 1)
    dfw2$ = MID$(Map$(locationy), locationx + 2, 1)
    dfw3$ = MID$(Map$(locationy), locationx + 3, 1)
   
    dflw1$ = MID$(Map$(locationy - 1), locationx + 1, 1)
    dflw2$ = MID$(Map$(locationy - 1), locationx + 2, 1)
    dflw3$ = MID$(Map$(locationy - 1), locationx + 3, 1)
   
    dfrw1$ = MID$(Map$(locationy + 1), locationx + 1, 1)
    dfrw2$ = MID$(Map$(locationy + 1), locationx + 2, 1)
    dfrw3$ = MID$(Map$(locationy + 1), locationx + 3, 1)
  END IF

BorderOfViewPort:
 
  LINE (49, 9)-(268, 81), 8, B
  LINE (50, 10)-(267, 80), 7, B
  LINE (51, 11)-(266, 79), 15, B
  LINE (52, 12)-(265, 78), 7, B
  LINE (53, 13)-(264, 77), 8, B

CompassBorder:

  LINE (13, 35)-(34, 56), 8, B
  LINE (12, 34)-(35, 57), 7, B
  LINE (11, 33)-(36, 58), 15, B
  LINE (10, 32)-(37, 59), 7, B
  LINE (9, 31)-(38, 60), 8, B
 
  Compass Look$

StatusBorder:

  LINE (13, 104)-(302, 185), 8, B
  LINE (12, 103)-(303, 186), 7, B
  LINE (11, 102)-(304, 187), 15, B
  LINE (10, 101)-(305, 188), 7, B
  LINE (9, 100)-(306, 189), 8, B

  IF StatusChange$ = "1" THEN
    Status PlayerName$, PlayerRace$, PlayerSex$, PlayerHit&, PlayerMagic&, PlayerGold&, MapNumber&
    StatusChange$ = "0"
  END IF

  IF StatusChange$ = "2" THEN
    Status PlayerName$, PlayerRace$, PlayerSex$, PlayerHit&, PlayerMagic&, PlayerGold&, MapNumber&
    StatusChange$ = "0"
    GOTO InputFromPlayer
  END IF
 
ClearInsideOfViewPort:

  LINE (54, 14)-(263, 76), 0, BF

PlacementOfWalls:

  IF dlw1$ = "1" THEN lw1
  IF drw1$ = "1" THEN rw1
  IF dlw1$ = "0" AND dflw1$ = "1" THEN mllw1
  IF drw1$ = "0" AND dfrw1$ = "1" THEN mlrw1
  IF dfw1$ = "1" THEN fw1: GOTO ResetWalls

  IF dlw2$ = "1" THEN lw2
  IF drw2$ = "1" THEN rw2
  IF dlw2$ = "0" AND dflw2$ = "1" AND dlw1$ = "0" THEN mllw2
  IF drw2$ = "0" AND dfrw2$ = "1" AND drw1$ = "0" THEN mlrw2
  IF dlw2$ = "0" AND dflw2$ = "1" AND dlw1$ = "1" THEN mlw2
  IF drw2$ = "0" AND dfrw2$ = "1" AND drw1$ = "1" THEN mrw2
  IF dfw2$ = "1" THEN fw2: GOTO ResetWalls

  IF dlw3$ = "1" THEN lw3
  IF drw3$ = "1" THEN rw3
  IF dlw3$ = "0" AND dflw3$ = "1" AND dlw2$ = "0" THEN mllw3
  IF drw3$ = "0" AND dfrw3$ = "1" AND drw2$ = "0" THEN mlrw3
  IF dlw3$ = "0" AND dflw3$ = "1" AND dlw2$ = "1" THEN mlw3
  IF drw3$ = "0" AND dfrw3$ = "1" AND drw2$ = "1" THEN mrw3
  IF dfw3$ = "1" THEN fw3: GOTO ResetWalls
  
ResetWalls:
  
  dlw1$ = "0"
  dlw2$ = "0"
  dlw3$ = "0"
  drw1$ = "0"
  drw2$ = "0"
  drw3$ = "0"
  dfw1$ = "0"
  dfw2$ = "0"
  dfw3$ = "0"
  dflw1$ = "0"
  dflw2$ = "0"
  dflw3$ = "0"
  dfrw1$ = "0"
  dfrw2$ = "0"
  dfrw3$ = "0"

  IF HitWall$ = "2" THEN
    LOCATE 10, 1
     Font "YOU FOUND THE EXIT!", 100, 175
    a$ = INPUT$(1)
    MapNumber& = MapNumber& + 1
    locationx = 4: locationy = 4
    StatusChange$ = "1"
    Look$ = "E"
    GOTO ReadMapData
  END IF

InputFromPlayer:

  move$ = INPUT$(1)
 
  IF move$ = "4" AND Look$ = "N" THEN Look$ = "W": GOTO PrintLookingDirection
  IF move$ = "4" AND Look$ = "E" THEN Look$ = "N": GOTO PrintLookingDirection
  IF move$ = "4" AND Look$ = "S" THEN Look$ = "E": GOTO PrintLookingDirection
  IF move$ = "4" AND Look$ = "W" THEN Look$ = "S": GOTO PrintLookingDirection
  IF move$ = "6" AND Look$ = "N" THEN Look$ = "E": GOTO PrintLookingDirection
  IF move$ = "6" AND Look$ = "E" THEN Look$ = "S": GOTO PrintLookingDirection
  IF move$ = "6" AND Look$ = "S" THEN Look$ = "W": GOTO PrintLookingDirection
  IF move$ = "6" AND Look$ = "W" THEN Look$ = "N": GOTO PrintLookingDirection
  IF move$ = "8" AND Look$ = "N" THEN oldlocationx = locationx: oldlocationy = locationy: locationy = locationy - 1: GOTO PrintLookingDirection
  IF move$ = "8" AND Look$ = "E" THEN oldlocationx = locationx: oldlocationy = locationy: locationx = locationx + 1: GOTO PrintLookingDirection
  IF move$ = "8" AND Look$ = "S" THEN oldlocationx = locationx: oldlocationy = locationy: locationy = locationy + 1: GOTO PrintLookingDirection
  IF move$ = "8" AND Look$ = "W" THEN oldlocationx = locationx: oldlocationy = locationy: locationx = locationx - 1: GOTO PrintLookingDirection
  IF move$ = "2" AND Look$ = "N" THEN oldlocationx = locationx: oldlocationy = locationy: locationy = locationy + 1: GOTO PrintLookingDirection
  IF move$ = "2" AND Look$ = "E" THEN oldlocationx = locationx: oldlocationy = locationy: locationx = locationx - 1: GOTO PrintLookingDirection
  IF move$ = "2" AND Look$ = "S" THEN oldlocationx = locationx: oldlocationy = locationy: locationy = locationy - 1: GOTO PrintLookingDirection
  IF move$ = "2" AND Look$ = "W" THEN oldlocationx = locationx: oldlocationy = locationy: locationx = locationx + 1: GOTO PrintLookingDirection
  IF move$ = "Q" THEN GOTO Quiting
  IF move$ = "!" THEN PlayerHit& = 9999: PlayerRace$ = "CHEATER": StatusChange$ = "2": GOTO StatusBorder
  IF move$ = "@" THEN PlayerMagic& = 9999: PlayerRace$ = "CHEATER": StatusChange$ = "2": GOTO StatusBorder
  IF move$ = "#" THEN PlayerGold& = 999999: PlayerRace$ = "CHEATER": StatusChange$ = "2": GOTO StatusBorder
  GOTO InputFromPlayer

Quiting:

  SCREEN 0
  WIDTH 80
  CLS
  END






















































Map1:

  Map$(1) = "11111111111111111111"
  Map$(2) = "11111111111111111111"
  Map$(3) = "11111111111111111111"
  Map$(4) = "11100010000000000111"
  Map$(5) = "11111010111011110111"
  Map$(6) = "11100000101000110111"
  Map$(7) = "11101111100010110111"
  Map$(8) = "11100000111010110111"
  Map$(9) = "11101110000000000111"
 Map$(10) = "11101111111111111111"
 Map$(11) = "11100000010000000111"
 Map$(12) = "11111011010111110111"
 Map$(13) = "11100011000101010111"
 Map$(14) = "11101111110101010111"
 Map$(15) = "11110000010001000111"
 Map$(16) = "11111101011111101111"
 Map$(17) = "11120001000000000111"
 Map$(18) = "11111111111111111111"
 Map$(19) = "11111111111111111111"
 Map$(20) = "11111111111111111111"

RETURN

Map2:

  Map$(1) = "11111111111111111111"
  Map$(2) = "11111111111111111111"
  Map$(3) = "11111111111111111111"
  Map$(4) = "11100010000001000111"
  Map$(5) = "11111010111011110111"
  Map$(6) = "11100000101000110111"
  Map$(7) = "11101111100010110111"
  Map$(8) = "11100000111010110111"
  Map$(9) = "11101110000000000111"
 Map$(10) = "11111111111101111111"
 Map$(11) = "11100000010000000111"
 Map$(12) = "11111011010111110111"
 Map$(13) = "11111011000101010111"
 Map$(14) = "11111111110101010111"
 Map$(15) = "11110000010001000111"
 Map$(16) = "11111101011111101111"
 Map$(17) = "11120001000000000111"
 Map$(18) = "11111111111111111111"
 Map$(19) = "11111111111111111111"
 Map$(20) = "11111111111111111111"

RETURN

Map3:

  Map$(1) = "11111111111111111111"
  Map$(2) = "11111111111111111111"
  Map$(3) = "11111111111111111111"
  Map$(4) = "11100010000010100111"
  Map$(5) = "11111010111000110111"
  Map$(6) = "11100000101010110111"
  Map$(7) = "11101111100010000111"
  Map$(8) = "11100000001110101111"
  Map$(9) = "11111011111010100111"
 Map$(10) = "11111000100000110111"
 Map$(11) = "11101110101110110111"
 Map$(12) = "11100000100000000111"
 Map$(13) = "11101111111110111111"
 Map$(14) = "11101000010100000111"
 Map$(15) = "11100011000101110111"
 Map$(16) = "11111110011001010111"
 Map$(17) = "11120000110011000111"
 Map$(18) = "11111111111111111111"
 Map$(19) = "11111111111111111111"
 Map$(20) = "11111111111111111111"

RETURN

SUB Compass (direction$)

OpenCompassFile:

  OPEN "Nwse.fnt" FOR BINARY AS #1
  filesize& = LOF(1)
  CLOSE #1

LoadCompassFile:

  bytes = (filesize& - 7) \ 2 - 1
  REDIM sprites(bytes)
  DEF SEG = VARSEG(sprites(0))
  BLOAD "Nwse.fnt", 0
  spritewidth = sprites(0) \ 8
  spriteheight = sprites(1)

WhatIsTheDirection:

  IF direction$ = "N" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 0
  IF direction$ = "W" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 1
  IF direction$ = "S" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 2
  IF direction$ = "E" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 3

PlaceTheCompassDirection:

  PUT (14, 36), sprites(offset), PSET

END SUB

SUB Font (aa$, xx, yy)

OpenFontFile:

  OPEN "Font.fnt" FOR BINARY AS #1
  filesize& = LOF(1)
  CLOSE #1

LoadFontFile:

  bytes = (filesize& - 7) \ 2 - 1
  REDIM sprites(bytes)
  DEF SEG = VARSEG(sprites(0))
  BLOAD "Font.fnt", 0
  spritewidth = sprites(0) \ 8
  spriteheight = sprites(1)

FontCalculations:
 
  xsprites = 319 \ (spritewidth + 1)
  xend = spritewidth * (xsprites - 1) + xsprites

ConversionInLocation:
 
  fontx = xx: fonty = yy

WhatIsTheFontsLetter:

  FOR PointToLetter = 1 TO LEN(aa$)
  letter$ = MID$(aa$, PointToLetter, 1)

NiceLetteringInsteadOfCheapDosStuff:

  IF letter$ = "A" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 0
  IF letter$ = "B" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 1
  IF letter$ = "C" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 2
  IF letter$ = "D" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 3
  IF letter$ = "E" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 4
  IF letter$ = "F" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 5
  IF letter$ = "G" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 6
  IF letter$ = "H" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 7
  IF letter$ = "I" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 8
  IF letter$ = "J" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 9
  IF letter$ = "K" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 10
  IF letter$ = "L" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 11
  IF letter$ = "M" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 12
  IF letter$ = "N" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 13
  IF letter$ = "O" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 14
  IF letter$ = "P" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 15
  IF letter$ = "Q" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 16
  IF letter$ = "R" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 17
  IF letter$ = "S" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 18
  IF letter$ = "T" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 19
  IF letter$ = "U" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 20
  IF letter$ = "V" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 21
  IF letter$ = "W" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 22
  IF letter$ = "X" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 23
  IF letter$ = "Y" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 24
  IF letter$ = "Z" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 25
  IF letter$ = "1" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 26
  IF letter$ = "2" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 27
  IF letter$ = "3" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 28
  IF letter$ = "4" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 29
  IF letter$ = "5" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 30
  IF letter$ = "6" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 31
  IF letter$ = "7" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 32
  IF letter$ = "8" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 33
  IF letter$ = "9" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 34
  IF letter$ = "0" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 35
  IF letter$ = "." THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 36
  IF letter$ = "!" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 37
  IF letter$ = "?" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 38
  IF letter$ = CHR$(34) THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 39
  IF letter$ = "," THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 40
  IF letter$ = "%" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 41
  IF letter$ = "$" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 42
  IF letter$ = "'" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 43
  IF letter$ = " " THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 44
  IF letter$ = ":" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 45

PlaceTheNiceFont:

  PUT (xx, yy), sprites(offset), PSET
   xx = xx + spritewidth
    IF xx > xend THEN
     xx = 0
     yy = yy + spriteheight
  END IF

GotoNextLetter:

  NEXT PointToLetter

END SUB

SUB fw1

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Fw1.wal", VARPTR(WallPiece(1))
  PUT (99, 14), WallPiece
  PUT (159, 14), WallPiece

END SUB

SUB fw2

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Fw2.wal", VARPTR(WallPiece(1))
  PUT (129, 14), WallPiece

END SUB

SUB fw3
 
  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Fw3.wal", VARPTR(WallPiece(1))
  PUT (144, 14), WallPiece

END SUB

SUB lw1
 
  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Lw1.wal", VARPTR(WallPiece(1))
  PUT (54, 14), WallPiece
    
END SUB

SUB lw2
 
  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Lw2.wal", VARPTR(WallPiece(1))
  PUT (99, 14), WallPiece

END SUB

SUB lw3
 
  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Lw3.wal", VARPTR(WallPiece(1))
  PUT (129, 14), WallPiece

END SUB

SUB mllw1

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Mw1.wal", VARPTR(WallPiece(1))
  PUT (54, 14), WallPiece

END SUB

SUB mllw2
 
  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Fw2.wal", VARPTR(WallPiece(1))
  PUT (69, 14), WallPiece

END SUB

SUB mllw3
 
  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Fw3.wal", VARPTR(WallPiece(1))
  PUT (114, 14), WallPiece

END SUB

SUB mlrw1

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Mw1.wal", VARPTR(WallPiece(1))
  PUT (219, 14), WallPiece

END SUB

SUB mlrw2
 
  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Fw2.wal", VARPTR(WallPiece(1))
  PUT (189, 14), WallPiece

END SUB

SUB mlrw3

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Fw3.wal", VARPTR(WallPiece(1))
  PUT (174, 14), WallPiece

END SUB

SUB mlw2

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Mw2.wal", VARPTR(WallPiece(1))
  PUT (99, 14), WallPiece

END SUB

SUB mlw3

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Mw3.wal", VARPTR(WallPiece(1))
  PUT (129, 14), WallPiece

END SUB

SUB mrw2

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Mw2.wal", VARPTR(WallPiece(1))
  PUT (189, 14), WallPiece

END SUB

SUB mrw3

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Mw3.wal", VARPTR(WallPiece(1))
  PUT (174, 14), WallPiece

END SUB

SUB Number (aa&, xx, yy)
 
OpenTheFontFile:
 
  OPEN "Font.fnt" FOR BINARY AS #1
  filesize& = LOF(1)
  CLOSE #1

LoadTheFontFile:
    
  bytes = (filesize& - 7) \ 2 - 1
  REDIM sprites(bytes)
  DEF SEG = VARSEG(sprites(0))
  BLOAD "Font.fnt", 0
  spritewidth = sprites(0) \ 8
  spriteheight = sprites(1)

Calculations:
 
  xsprites = 319 \ (spritewidth + 1)
  xend = spritewidth * (xsprites - 1) + xsprites
 
ConversionsInLocation:
 
  fontx = xx: fonty = yy

ConvertIntegerToString:

'**********CONVERSION FROM INTEGER TO STRING!!!**********
 
  aa$ = LTRIM$(STR$(aa&))

'********************************************************


WhatIsTheLetter:
 
  FOR PointToLetter = 1 TO LEN(aa$)
  letter$ = MID$(aa$, PointToLetter, 1)

CheapDosLettersToNiceFontLetters:

  IF letter$ = "1" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 26
  IF letter$ = "2" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 27
  IF letter$ = "3" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 28
  IF letter$ = "4" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 29
  IF letter$ = "5" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 30
  IF letter$ = "6" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 31
  IF letter$ = "7" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 32
  IF letter$ = "8" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 33
  IF letter$ = "9" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 34
  IF letter$ = "0" THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 35
  IF letter$ = " " THEN : offset = (((spritewidth * spriteheight) \ 2) + 3) * 44
 
PlaceTheLetter:
 
  PUT (xx, yy), sprites(offset), PSET
  xx = xx + spritewidth
  IF xx > xend THEN
    xx = 0
    yy = yy + spriteheight
  END IF

NextLetter:
 
  NEXT PointToLetter

END SUB

SUB Prepare4Graphics

SCREEN 13                                'change mode

DIM Pal(255) AS HUES                     'dim array for palette
DEF SEG = VARSEG(Pal(0))                 'point to it
BLOAD "3d_demo.pal", 0                   'load the goods
OUT &H3C8, 0                             'inform vga
FOR atrib = 0 TO 255                     'entire palette
 OUT &H3C9, Pal(atrib).red               'send red component
 OUT &H3C9, Pal(atrib).grn               'send grn component
 OUT &H3C9, Pal(atrib).blu               'send blu component
NEXT atrib                               'next attribute

END SUB

SUB rw1
 
  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Rw1.wal", VARPTR(WallPiece(1))
  PUT (219, 14), WallPiece

END SUB

SUB rw2

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Rw2.wal", VARPTR(WallPiece(1))
  PUT (189, 14), WallPiece

END SUB

SUB rw3

  DEF SEG = VARSEG(WallPiece(1)): BLOAD "Rw3.wal", VARPTR(WallPiece(1))
  PUT (174, 14), WallPiece

END SUB

SUB Status (PlayerName$, PlayerRace$, PlayerSex$, PlayerHit&, PlayerMagic&, PlayerGold&, MapNumber&)

  LINE (14, 105)-(301, 184), 0, BF
   
    Font "NAME:", 20, 110
    Font "RACE:", 20, 116
    Font "GENDER:", 20, 122
    Font "HIT POINTS:", 20, 128
    Font "MAGIC POINTS:", 20, 134
    Font "GOLD PIECES:", 20, 140
    Font "MAP NUMBER:", 220, 110

    Font PlayerName$, 53, 110
    Font PlayerRace$, 53, 116
    Font PlayerSex$, 65, 122
    Number PlayerHit&, 89, 128
    Number PlayerMagic&, 100, 134
    Number PlayerGold&, 95, 140
    Number MapNumber&, 285, 110
END SUB

