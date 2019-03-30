'       20 X 20 sprite (bitmap) editor.
'       Programmed by: DarkDread
'
'       E-mail me: LIPHILLI@flemingc.on.ca
'       Visit me:  http://www.geocitites.com/SiliconValley/Pines/1732/dds.htm
'
'       Here's a program you can use to create some good tile graphics.
'       Below is a list of all the commands as well as some quick code
'       which demonstrates how to put your tile into your program.  I
'       have created a couple of tiles already which you should have in
'       the same directory as this program.  Have fun.
'
'       Key commands:
'
'       Up arrow key    - move pointer up
'       Down arrow key  - move pointer down
'       Left arrow key  - move pointer left
'       Right arrow key - move pointer right
'
'       C - Change colour (Hit C and then enter a number between 0 and
'           255 to get the colour you want.)
'       B - Fill in a pixel with backround colour #0.  This is black by
'           default.
'       F - Fill the whole 20 X 20 tile with the current colour.  Make
'           sure you've saved anything you've drawn before you do this.
'       L - Load a tile.  You must know the path and name of the tile
'           you wish to load and enter its name correctly.
'       S - Save a tile.  You must specify a vaild tile name plus an
'           extension (like MYTILE.TIL for example).
'
'       Space bar - Press the space bar to fill a pixel with the current
'                   colour.
'       Esc       - Press the Esc key to quit the program.  It will ask
'                   if you wish to save your current tile before quiting.
'
'       Those are all of the commands in the program.  Below is the code
'       you use to put the tile in your program:
'
'       DIM SHARED Tile1(201)                ' Create an array for the tile
'                                            ' this can be any valid variable
'                                            ' name, it doesn't have to be
'                                            ' Tile1.
'
'       SCREEN 13                            ' Switch to mode 13h, 320X200,
'                                            ' with 256 colours.  The tiles
'                                            ' made with this program will
'                                            ' only work in this mode.
'      
'       DEF SEG = VARSEG(Tile1(0))           ' Load the tile into the array
'       BLOAD "MYTILE.TIL", VARPTR(Tile1(0)) ' variable.  If your array is
'                                            ' not Tile1 then change the name
'                                            ' and if your saved tile is not
'                                            ' called MYTILE.TIL, then change
'                                            ' that name as well.
'
'       PUT (0, 0), Tile1, PSET              ' Put the tile on the screen at
'                                            ' X position 0 and Y position 0.
'                                            ' They X and Y positions don't
'                                            ' have to be 0 and 0, they can
'                                            ' be anything that will fit on
'                                            ' a 320X200 screen.  If your
'                                            ' array name is not Tile1, then
'                                            ' change it appropriately.
'
'       One more thing.  When you are saving a tile, the program will ask
'       if you wish to create a mask for your tile.  If your tile has some
'       black (colour #0) background (say you've drawn a tree) and you
'       wish this black to be removed when it is put in your program then
'       you should have the program create a mask for you.  The file name
'       of the mask will be the same as the name you gave your tile only it
'       will have a MSK ending (ie. if your tile was TREE.TIL, your mask
'       would be TREE.MSK).  Here is the code for putting your tile and
'       the mask in your program.
'
'       DIM SHARED Tile1(201)
'       DIM SHARED Tile1Mask(201)
'
'       DEF SEG = VARSEG(Tile1(0))
'       BLOAD "MYTILE.TIL", VARPTR(Tile1(0))
'
'       DEF SEG = VARSEG(Tile1Mask(0))
'       BLOAD "MYTILE.MSK", VARPTR(Tile1Mask(0))
'
'       PUT (0, 0), Tile1Mask, AND
'
'       PUT (0, 0), Tile1, XOR
'
'       That should be enough to get you started.  If for some reason the
'       program doesn't work or you can't get the tiles to do what you want
'       or whatever, feel free to e-mail me and I'll do my best to help you
'       out.  Good luck!
'

DECLARE SUB FillIn ()
DECLARE SUB AskForMask ()
DECLARE SUB CreateMask ()
DECLARE SUB LoadImage ()
DECLARE SUB AskForLoad ()
DECLARE SUB AskForSave ()
DECLARE SUB SaveImage ()
DECLARE SUB EraseSquare ()
DECLARE SUB FillSquare ()
DECLARE SUB ChangeColour ()
DECLARE SUB Right ()
DECLARE SUB Left ()
DECLARE SUB Up ()
DECLARE SUB Down ()
DECLARE SUB InitScreen ()

CLS
LOCATE 12, 35: PRINT "Tile Editor"
LOCATE 14, 35: PRINT "Version 1.0"
WHILE INKEY$ = "": WEND

DIM SHARED Tile(201)

ON ERROR GOTO PathNotFound

CLS
INPUT "Enter save directory (default C:\): ", DefaultDir$
IF DefaultDir$ = "" THEN DefaultDir$ = "C:\"
CHDIR DefaultDir$
FILES DefaultDir$ + "*.*"
PRINT : PRINT "Press a key to start sprite editor."
WHILE INKEY$ = "": WEND
SCREEN 13

InitScreen
  XPos = 0: YPos = 0
  X = 230: Y = 1
  LINE (XPos, YPos)-(XPos + 8, YPos + 8), 40, B

DO
  SELECT CASE INKEY$
    CASE CHR$(0) + CHR$(80)
      Down
    CASE CHR$(0) + CHR$(77)
      Right
    CASE CHR$(0) + CHR$(75)
      Left
    CASE CHR$(0) + CHR$(72)
      Up
    CASE IS = "c", "C"
      ChangeColour
    CASE IS = "b", "B"
      EraseSquare
    CASE IS = "l", "L"
      AskForLoad
    CASE IS = "f", "F"
      FillIn
    CASE IS = "s", "S"
      AskForSave
    CASE CHR$(32)
      FillSquare
    CASE CHR$(27)
      Quit = 1
  END SELECT
  IF Quit = 1 THEN EXIT DO
LOOP

AskForSave
SYSTEM

PathNotFound:
  CLS
  PRINT "Oh oh, looks like some kind of error"
  PRINT "just occured.  You probably entered "
  PRINT "an invalid path somewhere."
  WHILE INKEY$ = "": WEND
  SYSTEM

SUB AskForLoad
  SHARED Mirror$
  LINE (0, 165)-(160, 180), 0, BF
  LINE (0, 165)-(160, 180), 15, B
  LOCATE 22, 2: PRINT "Load image?"
  WHILE INKEY$ <> "": WEND
  Load$ = LCASE$(INPUT$(1))
  LOCATE 22, 2: PRINT "Mirror-image?"
  Mirror$ = LCASE$(INPUT$(1))
  IF Load$ = "y" THEN LoadImage
  LINE (0, 165)-(160, 180), 120, BF
END SUB

SUB AskForMask
  LINE (0, 165)-(160, 180), 0, BF
  LINE (0, 165)-(160, 180), 15, B
  LOCATE 22, 2: PRINT "Create mask?"
  WHILE INKEY$ <> "": WEND
  mask$ = LCASE$(INPUT$(1))
  IF mask$ = "y" THEN CreateMask
  LINE (0, 165)-(160, 180), 120, BF
END SUB

SUB AskForSave
  LINE (0, 165)-(160, 180), 0, BF
  LINE (0, 165)-(160, 180), 15, B
  LOCATE 22, 2: PRINT "Save image?"
  WHILE INKEY$ <> "": WEND
  Save$ = LCASE$(INPUT$(1))
  IF Save$ = "y" THEN SaveImage
  LINE (0, 165)-(160, 180), 120, BF
END SUB

SUB ChangeColour
  SHARED Colour
  LINE (0, 165)-(160, 180), 0, BF
  LINE (0, 165)-(160, 180), 15, B
  LOCATE 22, 2: INPUT "Colour # --> ", Colour
  IF Colour < 0 AND Colour > 255 THEN Colour = 0
  LINE (280, 40)-(300, 45), Colour, BF
  LINE (0, 165)-(160, 180), 120, BF
END SUB

SUB CreateMask
  SHARED Name$
  FOR Y = 1 TO 20
    FOR X = 230 TO 249
      IF POINT(X, Y) = 0 THEN
          PSET (X, Y), 255
        ELSE
          PSET (X, Y), 0
      END IF
    NEXT X
  NEXT Y
  GET (230, 1)-(249, 20), Tile
  DEF SEG = VARSEG(Tile(0))
  DO
    I = I + 1
    IF MID$(Name$, I, 1) = "." THEN EXIT DO
  LOOP
  BSAVE LEFT$(Name$, I - 1) + ".msk", VARPTR(Tile(0)), 411
END SUB

SUB Down
  SHARED XPos, YPos, X, Y
  IF YPos = 152 THEN EXIT SUB
  LINE (XPos, YPos)-(XPos + 8, YPos + 8), 15, B
  YPos = YPos + 8: Y = Y + 1
  LINE (XPos, YPos)-(XPos + 8, YPos + 8), 40, B
END SUB

SUB EraseSquare
  SHARED XPos, YPos, X, Y
  LINE (XPos + 1, YPos + 1)-(XPos + 7, YPos + 7), 0, BF
  PSET (X, Y), 0
END SUB

SUB FillIn
  SHARED Colour
  LINE (1, 1)-(159, 159), Colour, BF
  LINE (230, 1)-(249, 20), Colour, BF
  FOR X = 0 TO 160 STEP 8
    LINE (X, 0)-(X, 160), 15
  NEXT X
  FOR Y = 0 TO 160 STEP 8
    LINE (0, Y)-(160, Y), 15
  NEXT Y
END SUB

SUB FillSquare
  SHARED XPos, YPos, X, Y, Colour
  LINE (XPos + 1, YPos + 1)-(XPos + 7, YPos + 7), Colour, BF
  PSET (X, Y), Colour
  IF Colour = 16 THEN PSET (XPos + 4, YPos + 4), 15
END SUB

SUB InitScreen
  SHARED Colour
  PALETTE 255, 50
  FOR X = 0 TO 160 STEP 8
    LINE (X, 0)-(X, 160)
  NEXT X
  FOR Y = 0 TO 160 STEP 8
    LINE (0, Y)-(160, Y)
  NEXT Y
  LINE (163, 58)-(319, 188), 15, B
  FOR Y = 60 TO 197 STEP 7
    FOR X = 166 TO 310 STEP 10
      LINE (X, Y)-(X + 10, Y + 7), Colour, BF
      Colour = Colour + 1
      IF Colour = 256 THEN EXIT FOR
    NEXT X
    IF Colour = 256 THEN EXIT FOR
  NEXT Y
  LINE (229, 0)-(250, 21), 15, B
  LINE (163, 35)-(310, 50), 15, B
  Colour = 15
  LINE (280, 40)-(300, 45), Colour, BF
  LOCATE 6, 22: PRINT "Colour "
  PAINT (319, 0), 120, 15
END SUB

SUB Left
  SHARED XPos, YPos, X, Y
  IF XPos = 0 THEN EXIT SUB
  LINE (XPos, YPos)-(XPos + 8, YPos + 8), 15, B
  XPos = XPos - 8: X = X - 1
  LINE (XPos, YPos)-(XPos + 8, YPos + 8), 40, B
END SUB

SUB LoadImage
  SHARED DefaultDir$, Mirror$
  LINE (0, 165)-(160, 180), 0, BF
  LINE (0, 165)-(160, 180), 15, B
  LOCATE 22, 2: INPUT "Name: ", Name$
  LINE (0, 165)-(160, 180), 0, BF
  LINE (0, 165)-(160, 180), 15, B
  IF Mirror$ = "y" THEN
    LOCATE 22, 2: INPUT "Mirror: ", MirrorName$
    LINE (0, 165)-(160, 180), 0, BF
    LINE (0, 165)-(160, 180), 15, B
    DEF SEG = VARSEG(Tile(0)): BLOAD MirrorName$, VARPTR(Tile(0))
    PUT (290, 1), Tile, PSET
  END IF
  LOCATE 22, 2: PRINT "Loading..."
  DEF SEG = VARSEG(Tile(0)): BLOAD Name$, VARPTR(Tile(0))
  PUT (230, 1), Tile, PSET
  X = 229: Y = 0
  FOR YPos = 0 TO 152 STEP 8
    Y = Y + 1
    FOR XPos = 0 TO 152 STEP 8
      X = X + 1
      LINE (XPos + 1, YPos + 1)-(XPos + 7, YPos + 7), POINT(X, Y), BF
      IF POINT(X, Y) = 16 THEN PSET (XPos + 4, YPos + 4), 15
    NEXT XPos
    X = 229
  NEXT YPos
END SUB

SUB Right
  SHARED XPos, YPos, X, Y
  IF XPos = 152 THEN EXIT SUB
  LINE (XPos, YPos)-(XPos + 8, YPos + 8), 15, B
  XPos = XPos + 8: X = X + 1
  LINE (XPos, YPos)-(XPos + 8, YPos + 8), 40, B
END SUB

SUB SaveImage
  SHARED Name$
  GET (230, 1)-(249, 20), Tile
  LINE (0, 165)-(160, 180), 0, BF
  LINE (0, 165)-(160, 180), 15, B
  LOCATE 22, 2: INPUT "Name: ", Name$
  LINE (0, 165)-(160, 180), 0, BF
  LINE (0, 165)-(160, 180), 15, B
  LOCATE 22, 2: PRINT "Saving..."
  Name$ = LEFT$(Name$, 12)
  DEF SEG = VARSEG(Tile(0))
  BSAVE Name$, VARPTR(Tile(0)), 404
  AskForMask
END SUB

SUB Up
  SHARED XPos, YPos, X, Y
  IF YPos = 0 THEN EXIT SUB
  LINE (XPos, YPos)-(XPos + 8, YPos + 8), 15, B
  YPos = YPos - 8: Y = Y - 1
  LINE (XPos, YPos)-(XPos + 8, YPos + 8), 40, B
END SUB

