DIM SHARED Arch1(4900)
DIM SHARED Arch2(4900)
DIM SHARED Mask1(4900)
DIM SHARED Mask2(4900)
DIM SHARED Back1(4900)
DIM SHARED Back2(4900)
DEF SEG = VARSEG(Arch1(0)): BLOAD "ARCH.16", VARPTR(Arch1(0))
DEF SEG = VARSEG(Arch2(0)): BLOAD "ARCH.16", VARPTR(Arch2(0))
DEF SEG = VARSEG(Mask1(0)): BLOAD "MASK.16", VARPTR(Mask1(0))
DEF SEG = VARSEG(Mask2(0)): BLOAD "MASK.16", VARPTR(Mask2(0))

CLS
PRINT "Please select screen resolution:"
PRINT "1.  320 x 200"
PRINT "2.  640 x 200"
PRINT "3.  640 x 350"
INPUT "[1 - 3]:", Mode
Mode = Mode + 6
IF Mode < 7 OR Mode > 9 THEN
  PRINT "Illegal choice.  Defaulting to 320 x 200."
  Mode = 7
END IF
SLEEP 3

SCREEN Mode, , 0, 1
PRINT "Initializing..."
PCOPY 0, 1
LINE (0, 0)-(319, 199), 0, BF

RANDOMIZE TIMER
FOR I = 1 TO 300
  x = INT(RND * 245)
  y = INT(RND * 155)
  c = INT(RND * 2) + 7
  PSET (x, y), c
NEXT I
GET (1, 0)-(245, 155), Back1
GET (0, 0)-(2, 155), Back2
LINE (0, 0)-(245, 155), 0, BF

PUT (0, 0), Mask1, PSET
PUT (123, 0), Mask1, PSET
GET (4, 0)-(245, 155), Mask1
GET (0, 0)-(3, 155), Mask2
PUT (0, 0), Arch1, PSET
PUT (123, 0), Arch2, PSET
GET (4, 0)-(245, 155), Arch1
GET (0, 0)-(3, 155), Arch2

LOCATE 22
LINE (0, 0)-(639, 349), 1, BF
PRINT "Wow! Parallax scrolling in QBASIC!"
PRINT "Press any key to end demo."

WHILE INKEY$ <> "": WEND
DO WHILE INKEY$ = ""
  LINE (0, 0)-(245, 155), 0, BF
  PUT (0, 0), Back1, PSET
  PUT (244, 0), Back2, PSET
  GET (1, 0)-(245, 155), Back1
  GET (0, 0)-(2, 155), Back2
  PUT (0, 0), Mask1, PSET
  PUT (242, 0), Mask2, PSET
  GET (4, 0)-(245, 155), Mask1
  GET (0, 0)-(3, 155), Mask2
  PUT (0, 0), Arch1, PSET
  PUT (242, 0), Arch2, PSET
  GET (4, 0)-(245, 155), Arch1
  GET (0, 0)-(3, 155), Arch2
  PUT (0, 0), Back1, PSET
  PUT (244, 0), Back2, PSET
  PUT (0, 0), Mask1, AND
  PUT (242, 0), Mask2, AND
  PUT (0, 0), Arch1, XOR
  PUT (242, 0), Arch2, XOR
  PCOPY 0, 1
LOOP

LINE (0, 0)-(319, 199), 0, BF
PCOPY 0, 1
SCREEN 0: WIDTH 80

