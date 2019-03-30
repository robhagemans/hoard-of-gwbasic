' File Name     : QBMATRIX.BAS
' Program Name  : QB Matrix
' Version       : Ver 1.1
' Type          : Freeware
' Developed     : 4/15/93
' Author        : Timothy Truman, David Pastore
' Revised       : 7/8/96
'
' Thanks for downloading QB Matrix !
' Please read through the text below before starting this program .
'
' Copyright (c) 1996 Nocturnal Creations
' All rights reserved
' The author makes no warrenties about the operation of this program,
' expressed or implied.
'
' This program may be freely distributed providing no changes are made
' to this program or it's support files. This program may not be
' distributed compiled.
'
' Original functions and subroutines found in this source code may be used
' with permision from the author.
'
' For information on ordering the QuickBASIC 4.5 version with
' greatly enhanced features read the MATRIX.TXT file.
'
' Questions, comments or work related:
' AOL        - Tim Truman
' Compuserve - 74734,2203
' INTERNET   - TimTruman@aol.com
'
'  * INSTRUCTIONS *
'
' Selecting play options :
'-------------------------
'
' Slam Mode -     Setting slam mode will cause the piece in play
'                 to immediatly drop into position after pressing
'                 the down arrow key or the 2 key. Otherwise the
'                 down arrow key or key 2 on the numeric keypad must
'                 be held to drop the piece. Slam mode is best used
'                 after becomming familiar with the game.
'
' Sound -         Allows you to turn off the sound effects so you
'                 won't disturb the boss.
'
' Level -         The higher the selected level the faster the pieces
'                 will drop.
'
' Handicap -      Selecting a handicap greater than zero will fill the
'                 bottom of the pit with random blocks up to the number
'                 of rows equal to the handicap value selected.
'
' Play Matrix -   Start the game with the selected options.
'
' Key usage during option screen:
'      /         - esc
'      8         - move cursor up
'   4  5  6      - move cursor left / press buttons / move cursor right
'      2         - move cursor down
'      Or use the arrow keys and space bar.


' How to play :
'--------------
'    Get the falling pieces to fit the best you can within the
'    confines of the pit. When complete rows are formed they will
'    be cleared. This will make room for more pieces. When pieces land
'    on the very top row of the pit the game will be over.
'
'    Key usage during game :
'        /         - esc
'        8         - spin piece ccwise
'     4  5  6      - move piece left / spin piece cwise / move piece right
'        2         - move piece down
'    Ins   Del     - toggle slam mode / toggle sound
'    Or use the arrow keys and space bar.
'
' Scoring:
'----------
' Points are awarded every time a piece land in the pit. The points
' recieved are calculated by the row the piece lands in and the current
' level. Simply, the higher the piece lands and the higher the level
' the more points that are added to the score.
'
'Entering a highscore :
'----------------------
' QB Matrix keeps the top 15 highscores. If you have beaten one of them
' a red blinking cursor will appear at your rank and you can enter a name
' or phrase of up to 23 charaters in length. The keys respond like a reqular
' text editor. Press enter when done.
'
' Press F5 to start the game!
' Enjoy !


DEFINT A-Z

TYPE highscores              'type for highscores
	rank AS STRING * 3         'rank
	dat  AS STRING * 8         'date
	nam  AS STRING * 25        'name
	lines  AS STRING * 4       'lines cleared
	num  AS STRING * 6         'Score
END TYPE

TYPE hues                    'define the type for hues
	red AS INTEGER             'red component
	grn AS INTEGER             'green component
	blu AS INTEGER             'blue component
END TYPE

DECLARE SUB P3x5Num (x, y, num, colour)
DECLARE SUB EndGame ()
DECLARE SUB TileScreen (tile)
DECLARE SUB Button (x, y, opt, size, fill)
DECLARE SUB BlankPal ()
DECLARE SUB CalcRowDiff ()
DECLARE SUB ChangePitPal ()
DECLARE SUB Clearbuffer ()
DECLARE SUB CheckForCleared ()
DECLARE SUB DisplayNextPiece ()
DECLARE SUB DoFillPit ()
DECLARE SUB DrawBlocks ()
DECLARE SUB DrawPlayPiece (x, y, playpiece, piecepostion)
DECLARE SUB DrawPlayScreen ()
DECLARE SUB DropPlayPiece ()
DECLARE SUB DropRows ()
DECLARE SUB Editor (score() AS highscores, cnt)
DECLARE SUB EndToQBasic ()
DECLARE SUB Eraserows ()
DECLARE SUB Findrowdiff ()
DECLARE SUB GameEnd ()
DECLARE SUB GetArea (ax, ay, bx, by, replace)
DECLARE SUB GetHighScores (mode)
DECLARE SUB GetOptions ()
DECLARE SUB MarkCptRows ()
DECLARE SUB PauseGame ()
DECLARE SUB p5x7font (px, y, Message$, colour)
DECLARE SUB RestorePal ()
DECLARE SUB StoreToGrid ()
DECLARE SUB ShowHighScores (score() AS highscores, mode)
DECLARE SUB SoundFX (fx%)
DECLARE SUB sortgridarray ()
DECLARE SUB Stay (Millisecs!)
DECLARE SUB TitleScreen ()
DECLARE SUB Updatescore ()
DECLARE SUB UpdatePieceMeter (restart)

DECLARE FUNCTION CheckMove (mode)
DECLARE FUNCTION CheckRotate ()
DECLARE FUNCTION Colorvalue& (attribute)
DECLARE FUNCTION GetPiece ()
DECLARE FUNCTION InputText$ (x, y, length)
DECLARE FUNCTION TimeToDrop ()
DECLARE FUNCTION ReturnEvent ()

COMMON SHARED grid(), blocks(), masks(), font(), smallnum(), meterpieces()
COMMON SHARED completerows()
COMMON SHARED xpiece, ypiece, pieceorientation, playpiece, piecelanded
COMMON SHARED gamescore&, oldhigh$, sngle, duble, triple, matrix
COMMON SHARED levelnum, droptime!, linescleared, levelmark, nextlevelmark
COMMON SHARED handicap, soundmode, slammode, gameover, Xpit, Ypit

'mapped key values
CONST F1 = -59
CONST F2 = -60
CONST F3 = -61
CONST up = -72
CONST left = -75
CONST right = -77
CONST down = -80
CONST Insert = -82
CONST backspace = 8
CONST enter = 13
CONST Esc = 27
CONST space = 32
CONST Plus = 43
CONST Minus = 45
CONST Zero = 48
CONST Dot = 46
CONST Slash = 47
CONST two = 50
CONST Four = 52
CONST five = 53
CONST Six = 54
CONST Eight = 56

'other
CONST True = 1
CONST false = 0
CONST blockheight = 7
CONST blockwidth = 11
CONST drop = 1


OUT &H60, &HF3                        'inform keyboard port
FOR d& = 1 TO 800: NEXT               'let hardware settle
OUT &H60, 0                           'send fast typematic rate

DEF fnrnd (num) = INT(RND * num) + 1  'function for random number generation
RANDOMIZE TIMER                       'seed the random number generator

SCREEN 13                             'set video

LOCATE 10, 15: COLOR 7
PRINT "Please Wait."                  'next few routines take some time

DIM completerows(1 TO 4)              'DIM array to hold completed rows

DIM grid(0 TO 22, 0 TO 12)            'DIM array for play pit

FOR y = 0 TO 22                       'to contain moves
	grid(y, 0) = 1
NEXT
FOR y = 0 TO 22                       'ditto
	grid(y, 11) = 1
NEXT
FOR x = 0 TO 11                       'ditto
 grid(22, x) = 1
NEXT

DIM smallnum(9, 5, 3)                    'DIM array for small numbers
FOR offset = 0 TO 9                      'first to last
	FOR ypos = 1 TO 5                      'top to bottom
		FOR xpos = 1 TO 3                    'left to right
			READ dat                           'READ data
			smallnum(offset, ypos, xpos) = dat 'store the data
		NEXT
	NEXT
NEXT


DIM masks(27, 3, 3)                       'DIM array for masks
FOR offset = 0 TO 27                      'first to last
	FOR bity = 0 TO 3                       'top to bottom
		FOR bitx = 0 TO 3                     'left to right
			READ dat                            'get data
			masks(offset, bity, bitx) = dat     'store to array
		NEXT
	NEXT
NEXT

DIM meterpieces(6, 20, 8)                  'DIM array for meter pieces
FOR offset = 0 TO 6                        'first to last
	FOR y = 1 TO 8                           'top to bottom
		FOR x = 1 TO 20                        'left to right
		 READ dat                              'READ data
			meterpieces(offset, x, y) = dat      'store to array
		NEXT
	NEXT
NEXT

DIM font(127, 4, 6)                       'DIM array for fonts
FOR offset = 0 TO 127                     'read in fonts
 FOR y = 0 TO 6                           'top to bottom
	FOR x = 0 TO 4                          'left to right
		 READ dat                             'get data
		 font(offset, x, y) = dat             'store it
	NEXT
 NEXT
NEXT

OPEN "QBMATRIX.OPT" FOR BINARY AS #1            'check for existance of .opt
length = LOF(1)
CLOSE #1
IF length = 0 THEN                              'file did not exist
 OPEN "QBMATRIX.OPT" FOR OUTPUT AS #1           'create file with defaults
 levelnum = 0: handicap = 0: slammode = 0: soundmode = 1
 WRITE #1, levelnum, handicap, slammode, soundmode
 CLOSE #1
ELSE                                            'file exists
 OPEN "QBMATRIX.OPT" FOR INPUT AS #1            'load saved options
 INPUT #1, levelnum, handicap, slammode, soundmode
 CLOSE #1
END IF

Stay (1)                   'initilaize delay routine
BlankPal                   'hide the screen writes
DrawBlocks                 'makes blocks used to make play pieces
CLS                        'clear screen
RestorePal                 'restore pallete
TitleScreen                'draw intro screen
CLS                        'clear screen

droptime! = .5             'initialize drop speed
GetOptions
Xpit = 11                  'set start position
Ypit = 35                  'ditto
'levelnum = 0              'initialize level
'handicap = 0              'initialize handicap
levelmark = 30             'initialize level occurance
nextlevelmark = levelmark  'set
ChangePitPal               'initialize pit color
DrawPlayScreen             'initilaize play screen
UpdatePieceMeter (-1)      'initialize meter
playpiece = GetPiece       'initialize playpiece
xpiece = Xpit * 6          'ditto
ypiece = Ypit              'ditto
DoFillPit                  'in case of handicap
DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation  ' ditto

DO                                                   'main loop
	
	 event = ReturnEvent                              'get event
		
	 IF TimeToDrop THEN event = drop

	 SELECT CASE event                                'process event
	 CASE Esc, Slash, Minus: EndToQBasic              'user wants out
	 CASE Plus:  PauseGame                            'nature calling ?
	 CASE up, Eight, space, five                                   'do rotate
		 rempiece = pieceorientation                                 'to restore
		 pieceorientation = (pieceorientation + 1) MOD 4             'adjust
		 IF CheckRotate THEN                                         'ok ?
			 DrawPlayPiece xpiece, ypiece, playpiece, rempiece         'remove
			 DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation 'draw new
		 ELSE                                                        'not ok
			 pieceorientation = rempiece                               'restore
		 END IF

	 CASE left, Four                                               'do left
		 IF CheckMove(left) THEN                                     'ok ?
			 DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation 'remove
			 xpiece = xpiece - blockwidth                              'adjust
			 DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation 'draw new
		 END IF

	 CASE right, Six                                               'do right
		 IF CheckMove(right) THEN                                    'ok?
			 DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation  'remove
			 xpiece = xpiece + blockwidth                               'adjust
			 DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation  'draw new
		 END IF

	 CASE drop
		 IF CheckMove(down) THEN                                     'ok ?
			 DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation 'remove
			 ypiece = ypiece + blockheight                             'adjust
			 DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation 'draw new
		 ELSE                                                        'not ok ?
			IF ypiece <= Ypit + blockheight THEN                       'at top ?
	gameover = True                                          'set flag
	EndGame                                                  'end game
			END IF                                                     'otherwise
			piecelanded = True                              'change piece color
			DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation  ' ditto
			piecelanded = false                           'did it
			CheckForCleared
			Updatescore                                   'taly score
			xpiece = Xpit * 6                             'reset
			ypiece = Ypit                                 'ditto
			pieceorientation = 0                          'reset
			playpiece = GetPiece                          'get new
			DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation 'draw
		END IF
		
		CASE down, two                                               'do down
			DO
	IF CheckMove(down) THEN                                     'ok ?
		DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation  'remove
		ypiece = ypiece + blockheight                              'adjust
		DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation  'draw new
	ELSE                                                        'not ok ?
	 IF ypiece <= Ypit + blockheight THEN                       'at top ?
		 gameover = True                                          'set flag
		 EndGame                                                  'end game
	 END IF                                                     'otherwise
	 piecelanded = True                              'change piece color
	 DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation  'ditto
	 piecelanded = false                           'did it
	 CheckForCleared
	 Updatescore                                   'taly score
	 xpiece = Xpit * 6                             'reset
	 ypiece = Ypit                                 'ditto
	 pieceorientation = 0                          'reset
	 playpiece = GetPiece                          'get new
	 DrawPlayPiece xpiece, ypiece, playpiece, pieceorientation 'draw
	 EXIT DO
	END IF
			LOOP WHILE slammode

		CASE Dot
			soundmode = NOT soundmode                     'toggle sound mode
			LINE (274, 75)-(294, 85), 17, BF              'clear old text
			IF soundmode THEN                             'print new
	p5x7font 274, 75, "On", 81                  'ditto
			ELSE                                          'ditto
	p5x7font 274, 75, "Off", 80                 'ditto
			END IF

		CASE Insert, Zero                                'do insert
			IF slammode THEN                               'slammode on
	slammode = NOT slammode                      'change it
	LINE (274, 62)-(294, 70), 17, BF             'clear old
	p5x7font 274, 62, "Off", 7                   'report
			ELSE                                           'slammode off
	slammode = NOT slammode                      'change it
	LINE (274, 62)-(294, 70), 17, BF             'clear old
	p5x7font 274, 62, "On", 15                   'report
			END IF
		 
		END SELECT

LOOP



'Small Numbers

DATA  1,1,1
DATA  1,0,1
DATA  1,0,1
DATA  1,0,1
DATA  1,1,1

DATA  0,1,0
DATA  0,1,0
DATA  0,1,0
DATA  0,1,0
DATA  0,1,0

DATA  1,1,1
DATA  0,0,1
DATA  1,1,1
DATA  1,0,0
DATA  1,1,1

DATA  1,1,1
DATA  0,0,1
DATA  0,1,1
DATA  0,0,1
DATA  1,1,1

DATA  1,0,1
DATA  1,0,1
DATA  1,1,1
DATA  0,0,1
DATA  0,0,1

DATA  1,1,1
DATA  1,0,0
DATA  1,1,1
DATA  0,0,1
DATA  1,1,1

DATA  1,0,0
DATA  1,0,0
DATA  1,1,1
DATA  1,0,1
DATA  1,1,1

DATA  1,1,1
DATA  0,0,1
DATA  0,0,1
DATA  0,0,1
DATA  0,0,1

DATA  1,1,1
DATA  1,0,1
DATA  1,1,1
DATA  1,0,1
DATA  1,1,1

DATA  1,1,1
DATA  1,0,1
DATA  1,1,1
DATA  0,0,1
DATA  0,0,1



'Data For Masks

'playpiece 0
DATA 1,1,1,1
DATA 0,0,0,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 0,1,0,0
DATA 0,1,0,0
DATA 0,1,0,0
DATA 0,1,0,0

DATA 1,1,1,1
DATA 0,0,0,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 0,1,0,0
DATA 0,1,0,0
DATA 0,1,0,0
DATA 0,1,0,0
	 
				'playpiece 1
DATA 1,1,1,0
DATA 0,1,0,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 0,1,0,0
DATA 1,1,0,0
DATA 0,1,0,0
DATA 0,0,0,0

DATA 0,1,0,0
DATA 1,1,1,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 1,0,0,0
DATA 1,1,0,0
DATA 1,0,0,0
DATA 0,0,0,0
			 'playpiece 2
DATA 1,1,0,0
DATA 1,1,0,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 1,1,0,0
DATA 1,1,0,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 1,1,0,0
DATA 1,1,0,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 1,1,0,0
DATA 1,1,0,0
DATA 0,0,0,0
DATA 0,0,0,0

				'playpiece 3
DATA 1,1,1,0
DATA 0,0,1,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 0,1,0,0
DATA 0,1,0,0
DATA 1,1,0,0
DATA 0,0,0,0

DATA 1,0,0,0
DATA 1,1,1,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 1,1,0,0
DATA 1,0,0,0
DATA 1,0,0,0
DATA 0,0,0,0
			 'playpiece 4

DATA 1,1,1,0
DATA 1,0,0,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 1,1,0,0
DATA 0,1,0,0
DATA 0,1,0,0
DATA 0,0,0,0

DATA 0,0,1,0
DATA 1,1,1,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 1,0,0,0
DATA 1,0,0,0
DATA 1,1,0,0
DATA 0,0,0,0

				'playpiece 5
DATA 0,1,1,0
DATA 1,1,0,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 1,0,0,0
DATA 1,1,0,0
DATA 0,1,0,0
DATA 0,0,0,0

DATA 0,1,1,0
DATA 1,1,0,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 1,0,0,0
DATA 1,1,0,0
DATA 0,1,0,0
DATA 0,0,0,0
			 'playpiece 6

DATA 1,1,0,0
DATA 0,1,1,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 0,1,0,0
DATA 1,1,0,0
DATA 1,0,0,0
DATA 0,0,0,0

DATA 1,1,0,0
DATA 0,1,1,0
DATA 0,0,0,0
DATA 0,0,0,0

DATA 0,1,0,0
DATA 1,1,0,0
DATA 1,0,0,0
DATA 0,0,0,0


'bitmaps for random meters
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
DATA 4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,7
DATA 4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,7
DATA 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,7
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


DATA 0,0,0,0,0,39,39,39,39,39,39,39,39,39,39,39,39,39,39,39
DATA 0,0,0,0,0,34,36,36,36,36,36,36,36,36,36,36,36,36,36,39
DATA 0,0,0,0,0,34,36,36,36,36,36,36,36,36,36,36,36,36,36,39
DATA 0,0,0,0,0,34,34,34,34,34,34,36,36,36,34,34,34,34,34,39
DATA 0,0,0,0,0,0 ,0 ,0 ,0 ,0 ,34,36,36,36,39,0 ,0 ,0 ,0 ,0
DATA 0,0,0,0,0,0 ,0 ,0 ,0 ,0 ,34,36,36,36,39,0 ,0 ,0 ,0 ,0
DATA 0,0,0,0,0,0 ,0 ,0 ,0 ,0 ,34,36,36,36,39,0 ,0 ,0 ,0 ,0
DATA 0,0,0,0,0,0 ,0 ,0 ,0 ,0 ,34,34,34,34,39,0 ,0 ,0 ,0 ,0

DATA 0,0,0,0,0,0,0,0,0,0,127,127,127,127,127,127,127,127,127,127
DATA 0,0,0,0,0,0,0,0,0,0,122,125,125,125,125,125,125,125,125,127
DATA 0,0,0,0,0,0,0,0,0,0,122,125,125,125,125,125,125,125,125,127
DATA 0,0,0,0,0,0,0,0,0,0,122,125,125,125,125,125,125,125,125,127
DATA 0,0,0,0,0,0,0,0,0,0,122,125,125,125,125,125,125,125,125,127
DATA 0,0,0,0,0,0,0,0,0,0,122,125,125,125,125,125,125,125,125,127
DATA 0,0,0,0,0,0,0,0,0,0,122,125,125,125,125,125,125,125,125,127
DATA 0,0,0,0,0,0,0,0,0,0,122,122,122,122,122,122,122,122,122,127

DATA 0,0,0,0,0,15,15,15,15,15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA 0,0,0,0,0,12,14,14,14,15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA 0,0,0,0,0,12,14,14,14,15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA 0,0,0,0,0,12,14,14,14,15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA 0,0,0,0,0,12,14,14,14,15,15,15,15,15,15,15,15,15,15,15
DATA 0,0,0,0,0,12,14,14,14,14,14,14,14,14,14,14,14,14,14,15
DATA 0,0,0,0,0,12,14,14,14,14,14,14,14,14,14,14,14,14,14,15
DATA 0,0,0,0,0,12,12,12,12,12,12,12,12,12,12,12,12,12,12,15

DATA 0,0,0,0,0,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30
DATA 0,0,0,0,0,25,28,28,28,28,28,28,28,28,28,28,28,28,28,30
DATA 0,0,0,0,0,25,28,28,28,28,28,28,28,28,28,28,28,28,28,30
DATA 0,0,0,0,0,25,28,28,28,25,25,25,25,25,25,25,25,25,25,25
DATA 0,0,0,0,0,25,28,28,28,30,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
DATA 0,0,0,0,0,25,28,28,28,30,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
DATA 0,0,0,0,0,25,28,28,28,30,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
DATA 0,0,0,0,0,25,25,25,25,30,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0

DATA 0,0,0,0,0,  0,  0,  0,  0,  0,103,103,103,103,103,103,103,103,103,103
DATA 0,0,0,0,0,  0,  0,  0,  0,  0,100,102,102,102,102,102,102,102,102,103
DATA 0,0,0,0,0,  0,  0,  0,  0,  0,100,102,102,102,102,102,102,102,102,103
DATA 0,0,0,0,0,  0,  0,  0,  0,  0,100,102,102,102,100,100,100,100,100,103
DATA 0,0,0,0,0,103,103,103,103,103,100,102,102,102,103,  0,  0,  0,  0,  0
DATA 0,0,0,0,0,100,102,102,102,102,102,102,102,102,103,  0,  0,  0,  0,  0
DATA 0,0,0,0,0,100,102,102,102,102,102,102,102,102,103,  0,  0,  0,  0,  0
DATA 0,0,0,0,0,100,100,100,100,100,100,100,100,100,103,  0,  0,  0,  0,  0

DATA 0,0,0,0,0,48,48,48,48,48,48,48,48,48,48, 0, 0, 0, 0, 0
DATA 0,0,0,0,0,43,45,45,45,45,45,45,45,45,48, 0, 0, 0, 0, 0
DATA 0,0,0,0,0,43,45,45,45,45,45,45,45,45,48, 0, 0, 0, 0, 0
DATA 0,0,0,0,0,43,43,43,43,43,43,45,45,45,48, 0, 0, 0, 0, 0
DATA 0,0,0,0,0, 0, 0, 0, 0, 0,43,45,45,45,48,48,48,48,48,48
DATA 0,0,0,0,0, 0, 0, 0, 0, 0,43,45,45,45,45,45,45,45,45,48
DATA 0,0,0,0,0, 0, 0, 0, 0, 0,43,45,45,45,45,45,45,45,45,48
DATA 0,0,0,0,0, 0, 0, 0, 0, 0,43,43,43,43,43,43,43,43,43,48



'font bitmaps, duplicates first 128 charactors of ASCII set
' 0 NUL
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
' 1
DATA 1,1,0,1,1
DATA 1,1,0,1,1
DATA 0,1,0,1,0
DATA 0,0,0,0,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
' 2
DATA 1,1,1,1,1
DATA 1,0,1,0,1
DATA 1,0,1,0,1
DATA 1,1,1,1,1
DATA 1,0,1,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
' 3
DATA 0,0,0,0,0
DATA 0,1,0,1,0
DATA 1,1,1,1,1
DATA 1,1,1,1,1
DATA 0,1,1,1,0
DATA 0,0,1,0,0
DATA 0,0,0,0,0
'4
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 1,1,1,1,1
DATA 1,1,1,1,1
DATA 0,1,1,1,0
DATA 0,0,1,0,0
'5
DATA 0,1,1,1,0
DATA 0,1,1,1,0
DATA 1,1,1,1,1
DATA 1,1,1,1,1
DATA 1,1,1,1,1
DATA 0,0,1,0,0
DATA 0,0,1,0,0
'6
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 1,1,1,1,1
DATA 1,1,0,1,1
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,0,0,0
'7
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 0,1,1,1,0
DATA 1,1,1,1,1
DATA 1,1,1,1,1
DATA 0,0,0,1,0
'8
DATA 1,1,1,1,1
DATA 1,1,0,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,0,1
'9
DATA 0,0,0,0,0
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,1,1,0
DATA 0,0,0,0,0
'10
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 0,1,1,1,0
DATA 0,1,1,1,0
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 1,1,1,1,1
'11
DATA 0,0,1,1,1
DATA 0,0,0,1,1
DATA 0,0,1,0,1
DATA 0,1,1,0,0
DATA 1,0,0,1,0
DATA 1,0,0,1,0
DATA 0,1,1,0,0
'12
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,1,1,0
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 0,0,1,0,0
'13
DATA 0,0,1,1,1
DATA 0,0,1,0,0
DATA 0,0,1,1,0
DATA 0,0,1,0,0
DATA 1,1,1,0,0
DATA 1,1,1,0,0
DATA 1,1,1,0,0
'14
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 0,1,0,0,1
DATA 1,1,0,0,1
DATA 1,1,0,1,1
DATA 0,0,0,1,1
'15
DATA 1,0,1,0,1
DATA 0,1,1,1,0
DATA 0,1,0,1,0
DATA 1,1,0,1,1
DATA 0,1,0,1,0
DATA 0,1,1,1,0
DATA 1,0,1,0,1
'16
DATA 1,1,0,0,0
DATA 1,1,1,0,0
DATA 1,1,1,1,0
DATA 1,1,1,1,1
DATA 1,1,1,1,0
DATA 1,1,1,0,0
DATA 1,1,0,0,0
'17
DATA 0,0,0,1,1
DATA 0,0,1,1,1
DATA 0,1,1,1,1
DATA 1,1,1,1,1
DATA 0,1,1,1,1
DATA 0,0,1,1,1
DATA 0,0,0,1,1
'18
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 0,1,1,1,0
DATA 0,0,1,0,0
'19
DATA 1,1,0,1,1
DATA 1,1,0,1,1
DATA 1,1,0,1,1
DATA 1,1,0,1,1
DATA 1,1,0,1,1
DATA 0,0,0,0,0
DATA 1,1,0,1,1
'20
DATA 1,1,1,1,1
DATA 1,1,0,1,0
DATA 1,1,0,1,0
DATA 0,1,0,1,0
DATA 0,1,0,1,0
DATA 0,1,0,1,0
DATA 0,1,0,1,0
'21
DATA 0,0,1,1,0
DATA 0,1,0,0,1
DATA 0,0,1,0,0
DATA 0,0,0,1,0
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 1,1,1,1,0
'22
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 1,1,1,1,1
'23
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 0,0,1,0,0
DATA 1,1,1,1,1
'24
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 1,1,1,1,1
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
'25
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 1,1,1,1,1
DATA 0,1,1,1,0
DATA 0,0,1,0,0
'26
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,0,1,1,0
DATA 1,1,1,1,1
DATA 0,0,1,1,0
DATA 0,0,1,0,0
DATA 0,0,0,0,0
'27
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,1,1,0,0
DATA 1,1,1,1,1
DATA 0,1,1,0,0
DATA 0,0,1,0,0
DATA 0,0,0,0,0
'28
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,1
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'29
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,1,0,1,0
DATA 1,1,1,1,1
DATA 0,1,0,1,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'30
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 1,1,1,1,1
'31
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 0,1,1,1,0
DATA 0,0,1,0,0
'32
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'33
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 0,0,0,0,0
DATA 1,0,0,0,0
'34
DATA 0,1,0,1,0
DATA 0,1,0,1,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'35
DATA 0,1,0,1,0
DATA 0,1,0,1,0
DATA 1,1,1,1,1
DATA 0,1,0,1,0
DATA 1,1,1,1,1
DATA 0,1,0,1,0
DATA 0,1,0,1,0
'36
DATA 0,0,1,0,0
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,1,1,1,1
DATA 0,0,0,0,1
DATA 1,1,1,1,1
DATA 0,0,1,0,0
'37
DATA 1,1,0,0,0
DATA 1,1,0,0,1
DATA 0,0,0,1,0
DATA 0,0,1,0,0
DATA 0,1,0,0,0
DATA 1,0,0,1,1
DATA 0,0,0,1,1
'38
DATA 0,1,1,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 0,1,0,0,0
DATA 1,0,1,1,0
DATA 1,0,1,1,0
DATA 0,1,0,0,1
'39
DATA 0,1,0,0,0
DATA 1,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'40
DATA 0,1,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 0,1,0,0,0
'41
DATA 1,0,0,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 1,0,0,0,0
'42
DATA 0,0,0,0,0
DATA 1,0,1,0,1
DATA 0,1,1,1,0
DATA 1,1,1,1,1
DATA 0,1,1,1,0
DATA 1,0,1,0,1
DATA 0,0,0,0,0
'43
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 0,0,1,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'44
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,1,0,0,0
DATA 1,0,0,0,0
'45
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,1,1,1,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'46
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,0,0,0,0
'47
DATA 0,0,0,0,0
DATA 0,0,0,0,1
DATA 0,0,0,1,0
DATA 0,0,1,0,0
DATA 0,1,0,0,0
DATA 1,0,0,0,0
DATA 0,0,0,0,0
'48
'Numbers
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,1,1,0
'49
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
'50
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 0,0,0,1,0
DATA 0,0,1,0,0
DATA 0,1,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,1
'51
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 0,0,0,0,1
DATA 0,1,1,1,0
DATA 0,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,1,1,0
'52
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,1,1,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
'53
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,0
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 1,1,1,1,0
'54
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,1,1,0
'55
DATA 1,1,1,1,0
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
'56
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,1,1,0
'57
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,1,1,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
'58
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,0,0,0,0
'59
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,1,0,0,0
'60
DATA 0,0,0,0,0
DATA 0,0,0,1,0
DATA 0,0,1,0,0
DATA 0,1,0,0,0
DATA 0,0,1,0,0
DATA 0,0,0,1,0
DATA 0,0,0,0,0
'61
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'62
DATA 0,0,0,0,0
DATA 0,1,0,0,0
DATA 0,0,1,0,0
DATA 0,0,0,1,0
DATA 0,0,1,0,0
DATA 0,1,0,0,0
DATA 0,0,0,0,0
'63
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 0,0,0,0,1
DATA 0,0,0,1,0
DATA 0,0,1,0,0
DATA 0,0,0,0,0
DATA 0,0,1,0,0
'64
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,1,0,1
DATA 1,0,1,1,1
DATA 1,0,0,0,0
DATA 1,0,0,0,1
DATA 0,1,1,1,0
' 65   Capitol
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
'66
DATA 1,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,0
'67
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,1
'68
DATA 1,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,0
'69
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,1
'70
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
'71
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
'72
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
'73
DATA 1,1,1,1,1
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 1,1,1,1,1
'74
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
'75
DATA 1,0,0,0,1
DATA 1,0,0,1,0
DATA 1,0,1,0,0
DATA 1,1,0,0,0
DATA 1,0,1,0,0
DATA 1,0,0,1,0
DATA 1,0,0,0,1
'76
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,1
'77
DATA 1,1,1,1,1
DATA 1,0,1,0,1
DATA 1,0,1,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
'78
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
'79
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
'80
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
'81
DATA 0,1,1,1,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,0,0,1,1
DATA 0,1,1,1,1
'82
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 1,1,0,0,0
DATA 1,0,1,0,0
DATA 1,0,0,1,1
'83
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 1,1,1,1,1
'84
DATA 1,1,1,1,1
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
'85
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
'86
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,0,1,0
DATA 0,1,0,1,0
DATA 0,0,1,0,0
'87
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,1,0,1
DATA 1,0,1,0,1
DATA 1,1,1,1,1
'88
DATA 1,0,0,0,1
DATA 0,1,0,1,0
DATA 0,1,0,1,0
DATA 0,0,1,0,0
DATA 0,1,0,1,0
DATA 0,1,0,1,0
DATA 1,0,0,0,1
'89
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,0,1,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
'90
DATA 1,1,1,1,1
DATA 0,0,0,0,1
DATA 0,0,0,1,0
DATA 0,0,1,0,0
DATA 0,1,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,1
'91
DATA 0,1,1,1,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 0,1,1,1,0
'92
DATA 0,0,0,0,0
DATA 1,0,0,0,0
DATA 0,1,0,0,0
DATA 0,0,1,0,0
DATA 0,0,0,1,0
DATA 0,0,0,0,1
DATA 0,0,0,0,0
'93
DATA 0,1,1,1,0
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 0,1,1,1,0
'94
DATA 0,0,1,0,0
DATA 0,1,0,1,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'95
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
'96
DATA 0,0,1,0,0
DATA 0,0,0,1,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'97
'Lower case
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
'98
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
'99
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,1
'100
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
'101
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,1,1,1,1
'102
DATA 0,0,1,1,1
DATA 0,1,0,0,0
DATA 1,1,1,1,1
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
'103
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 0,0,0,0,1
DATA 1,1,1,1,1
'104
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
'105
DATA 1,0,0,0,0
DATA 0,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
'106
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 1,1,1,1,0
'107
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,1
DATA 1,0,0,1,0
DATA 1,1,1,0,0
DATA 1,0,0,1,0
DATA 1,0,0,0,1
'108
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
'109
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 1,0,1,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
'110
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
'111
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
'112
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,0,0,0,0
'113
DATA 1,1,1,1,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
'114
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
DATA 1,0,0,0,0
'115
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 1,0,0,0,0
DATA 1,1,1,1,1
DATA 0,0,0,0,1
DATA 1,1,1,1,1
'116
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 1,1,1,1,1
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
'117
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
'118
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 0,1,0,1,0
DATA 0,1,0,1,0
DATA 0,0,1,0,0
'119
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,1,0,1
DATA 1,1,1,1,1
'120
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,0,0,0,1
DATA 0,1,0,1,0
DATA 0,0,1,0,0
DATA 0,1,0,1,0
DATA 1,0,0,0,1
'121
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,0,0,0,1
DATA 1,1,1,1,1
DATA 0,0,0,0,1
DATA 0,0,0,0,1
DATA 1,1,1,1,1
'122
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 1,1,1,1,1
DATA 0,0,0,1,0
DATA 0,0,1,0,0
DATA 0,1,0,0,0
DATA 1,1,1,1,1
'123
DATA 0,0,1,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 1,0,0,0,0
DATA 0,1,0,0,0
DATA 0,1,0,0,0
DATA 0,0,1,0,0
'124
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
DATA 0,0,1,0,0
'125
DATA 0,0,1,0,0
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 0,0,0,0,1
DATA 0,0,0,1,0
DATA 0,0,0,1,0
DATA 0,0,1,0,0
'126
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,1,0,1
DATA 0,1,0,1,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
'127
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,0,0,0
DATA 0,0,1,0,0
DATA 0,1,0,1,0
DATA 1,0,0,0,1
DATA 1,1,1,1,1


'// data for cursor pointer in choseoptions

DATA 1,0,0,0,0,0
DATA 1,1,0,0,0,0
DATA 1,1,1,0,0,0
DATA 1,1,1,1,0,0
DATA 1,1,1,1,1,0
DATA 1,1,1,1,1,1
DATA 1,1,0,0,0,0
DATA 1,0,0,0,0,0



'data to recontruct qbmatrix.scr in the event it is erased

DATA 1. ,04/11/94 ,Timothy Truman,       0,100
DATA 2. ,04/15/94 ,David Pastore,        0,100
DATA 3. ,04/25/94 ,John Matias,          0,100
DATA 4. ,04/15/94 ,Denise Eberts,        0,100
DATA 5. ,04/18/94 ,Mike,                 0, 50
DATA 6. ,04/18/94 ,Bonnie Soffan,        0, 50
DATA 7. ,04/19/94 ,Patty Effilo,         0, 50
DATA 8. ,04/11/94 ,Kelsi,                0, 45
DATA 9. ,04/21/94 ,Tracy,                0, 45
DATA 10.,04/21/94 ,Heather,              0, 45
DATA 11.,04/22/94 ,Pop Tart,             0, 30
DATA 12.,04/23/94 ,Muffin Man,           0, 30
DATA 13.,04/23/94 ,Cindy Bell,           0, 30
DATA 14.,04/23/94 ,John Smith,           0, 20
DATA 15.,04/25/94 ,Jane Doe,             0, 20

SUB BlankPal
OUT &H3C8, 0                'inform video card
FOR reg = 0 TO 144          'blank first 144 registers
	OUT &H3C9, 0              'send red component
	OUT &H3C9, 0              'send red component
	OUT &H3C9, 0              'send green comonent
NEXT
END SUB

SUB Button (x, y, opt, size, fill)

'draws the shaded buttons on the options screen and load/save game screen.
Clearbuffer

offsety = 14

SELECT CASE (size)

CASE 0
	offsetx = 16
CASE 1
	offsetx = 66
CASE 2
	offsetx = 150
CASE 3
	offsetx = 66
	offsety = 34
CASE 4
	offsetx = 130
	offsety = 15
END SELECT


SELECT CASE (opt)

CASE 0

	LINE (x, y)-(x + offsetx, y), 24
	LINE (x + 2, y + 1)-(x + offsetx - 2, y + 1), 24

	LINE (x + offsetx, y)-(x + offsetx, y + offsety), 24
	LINE (x + offsetx - 1, y + 1)-(x + offsetx - 1, y + offsety - 2), 24

	LINE (x, y)-(x, y + offsety), 18
	LINE (x + 1, y + 1)-(x + 1, y + offsety - 1), 18

	LINE (x, y + offsety)-(x + offsetx, y + offsety), 18
	LINE (x + 1, y + offsety - 1)-(x + offsetx - 1, y + offsety - 1), 18

CASE 1

	LINE (x, y)-(x + offsetx, y), 18
	LINE (x + 2, y + 1)-(x + offsetx - 2, y + 1), 18

	LINE (x + offsetx, y)-(x + offsetx, y + offsety), 18
	LINE (x + offsetx - 1, y + 1)-(x + offsetx - 1, y + offsety - 2), 18

	LINE (x, y)-(x, y + offsety), 24
	LINE (x + 1, y + 1)-(x + 1, y + offsety - 1), 24

	LINE (x, y + offsety)-(x + offsetx, y + offsety), 24
	LINE (x + 1, y + offsety - 1)-(x + offsetx - 1, y + offsety - 1), 24

END SELECT

IF fill THEN LINE (x + 2, y + 2)-(x + offsetx - 2, y + offsety - 2), 126, BF



END SUB

SUB ChangePitPal

' Changes pit color atribute each time it is called.
' After ten times it recycles back to the first color.


STATIC initialize, colour

IF initialize = 0 THEN
	initialize = 1
	colour = levelnum
	IF colour > 9 THEN colour = 9
END IF

SELECT CASE colour

CASE 0                           ' grays (If using Matrix.pal)
	PALETTE 212, Colorvalue&(140)  ' highlight color
	PALETTE 204, Colorvalue&(132)  ' shade color
	PALETTE 208, Colorvalue&(136)  ' block color

CASE 1                           ' use the colors of piece 0
	PALETTE 212, Colorvalue&(7)    ' hc
	PALETTE 204, Colorvalue&(4)    ' sc
	PALETTE 208, Colorvalue&(6)    ' bc
				
CASE 2                           ' use the colors of piece 1
	PALETTE 212, Colorvalue&(39)   ' hc
	PALETTE 204, Colorvalue&(34)   ' sc
	PALETTE 208, Colorvalue&(36)   ' bc

CASE 3                           ' use the colors of piece 2
	PALETTE 212, Colorvalue&(127)  ' hc
	PALETTE 204, Colorvalue&(122)  ' sc
	PALETTE 208, Colorvalue&(125)  ' bc

CASE 4                           ' use the colors of piece 3
	PALETTE 212, Colorvalue&(15)   ' hc
	PALETTE 204, Colorvalue&(12)   ' sc
	PALETTE 208, Colorvalue&(14)   ' bc

CASE 5                           ' use the colors of piece 4
	PALETTE 212, Colorvalue&(30)   ' hc
	PALETTE 204, Colorvalue&(25)   ' sc
	PALETTE 208, Colorvalue&(28)   ' bc

CASE 6                           ' use the colors of piece 5
	PALETTE 212, Colorvalue&(103)  ' hc
	PALETTE 204, Colorvalue&(100)  ' sc
	PALETTE 208, Colorvalue&(102)  ' bc
						 
CASE 7                           ' use the colors of piece 6
	PALETTE 212, Colorvalue&(48)   ' hc
	PALETTE 204, Colorvalue&(43)   ' sc
	PALETTE 208, Colorvalue&(45)   ' bc

CASE 8                           ' pink (If using Matrix.pal)
	PALETTE 212, Colorvalue&(63)   ' hc
	PALETTE 204, Colorvalue&(59)   ' sc
	PALETTE 208, Colorvalue&(61)   ' bc

CASE 9                           ' brown(If using Matrix.pal)
	PALETTE 212, Colorvalue&(55)   ' hc
	PALETTE 204, Colorvalue&(51)   ' sc
	PALETTE 208, Colorvalue&(53)   ' bc
	
END SELECT

colour = (colour + 1) MOD 10     ' increment the color


END SUB

SUB CheckForCleared

					'store landing in grid grid array
FOR xmask = 0 TO 3                'left to right
	FOR ymask = 0 TO 3             'top to bottom
		offset = (playpiece * 4) + pieceorientation    'get offset for mask
		IF masks(offset, ymask, xmask) = 1 THEN          'Bit there ?
			gridx = (((xpiece + (xmask * blockwidth)) / blockwidth) - 1)
			gridy = (((ypiece + (ymask * blockheight))) / blockheight) - 5
			grid(gridy, gridx) = 1
		END IF
	NEXT
NEXT

Clearbuffer
CALL SoundFX(0)                             'make landing noise
Clearbuffer

							'find complete rows
FOR ygrid = 0 TO 21                         'top to bottom
	FOR xgrid = 1 TO 10                       'left to right
		IF grid(ygrid, xgrid) = 1 THEN xcount = xcount + 1 'increment if occupied
			IF xcount = 10 THEN                     'complete row  ?
	 numrows = numrows + 1                 'increment rowcount
	 completerows(numrows) = ygrid         'store the row value for later
			END IF
		NEXT
		xcount = 0                                 'new row
NEXT

DIM word$(4, 10)                             'DIM array for text
							 'stuff arrays with text
word$(1, 1) = " ": word$(2, 1) = " ": word$(3, 1) = " ": word$(4, 1) = " ":
word$(1, 2) = " ": word$(2, 2) = " ": word$(3, 2) = " ": word$(4, 2) = " ":
word$(1, 3) = "S": word$(2, 3) = "D": word$(3, 3) = "T": word$(4, 3) = "M"
word$(1, 4) = "I": word$(2, 4) = "O": word$(3, 4) = "R": word$(4, 4) = "A"
word$(1, 5) = "N": word$(2, 5) = "U": word$(3, 5) = "I": word$(4, 5) = "T"
word$(1, 6) = "G": word$(2, 6) = "B": word$(3, 6) = "P": word$(4, 6) = "R"
word$(1, 7) = "L": word$(2, 7) = "L": word$(3, 7) = "L": word$(4, 7) = "I"
word$(1, 8) = "E": word$(2, 8) = "E": word$(3, 8) = "E": word$(4, 8) = "X"
word$(1, 9) = " ": word$(2, 9) = " ": word$(3, 9) = " ": word$(4, 9) = " ":
word$(1, 10) = " ": word$(2, 10) = " ": word$(3, 10) = " ": word$(4, 10) = " ":

DIM pit(10000)                              'DIM array to store pit
DIM image(43)                               'DIM array to store blocks

IF numrows THEN                             'found cleared rows  ?
	FOR columns = 1 TO 10                     'left to right
		FOR rows = 1 TO numrows                 'first row to last
			x = (columns + 1) * 11                 'calculate x screen position
			y = ((completerows(rows) + 5) * 7)     'calculate y screen positon
							'GET whats there
			GET (x, y)-(x + blockwidth - 1, y + blockheight - 1), image
			PUT (x, y), image                      'PUT it back to erase

			SELECT CASE numrows                    'print charactor at cleared x
			CASE 1: ele$ = word$(1, letter)        'ditto
			CASE 2: ele$ = word$(2, letter)        'ditto
			CASE 3: ele$ = word$(3, letter)        'ditto
			CASE 4: ele$ = word$(4, letter)        'ditto
			END SELECT
			p5x7font x, y, ele$, 212             'ditto
		NEXT
		Stay (15)                               'slow down the action
		letter = letter + 1                     'increment for next charactor
	NEXT                                     'next row
	SoundFX (1)                              'make row clear noise
END IF



			 'now erase the text and clear the row in the grid() array
FOR column = 1 TO 10                       'left to right
	x = (column + 1) * 11                    'calc x
	FOR row = 1 TO numrows                   'first cleared row to last
		posy = (completerows(row) + 5) * 7    'calc y
		GET (x, y)-(x + blockwidth - 1, y + blockheight - 1), image 'GET area
		PUT (x, y), image                     'PUT to erase
 NEXT
NEXT

'graphicaly drop blocks above cleared rows down and sort grid array

FOR row = 1 TO numrows
	FOR ygrid = completerows(numrows) TO 1 STEP -1'count from cleared row up
		FOR xgrid = 1 TO 10                         'left to right
			grid(ygrid, xgrid) = grid(ygrid - 1, xgrid)  'drop rows in grid
		NEXT                                       'next column
	NEXT                                         'next row

	xget = (blockwidth) + Xpit                   'calc left side of pit
	xend = ((blockwidth + 1) * 10) + Xpit        'calc right side of pit
	ytoget = (completerows(row) * blockheight) + Ypit - 1  'calc bottom y
	ytodrop = (Ypit + blockheight)               'calc y drop
	
	GET (xget, Ypit)-(xend, ytoget), pit         'GET pit
	PUT (xget, Ypit), pit                        'PUT to erase
	PUT (xget, ytodrop), pit, PSET               'PUT to drop
NEXT
				 
IF numrows THEN
	SoundFX (0)                                     'make landing noise
	linescleared = linescleared + numrows           'add lines cleared
	SELECT CASE numrows                             'add line clear types
	CASE 1: sngle = sngle + 1                       'increment
	CASE 2: duble = duble + 1                       'ditto
	CASE 3: triple = triple + 1                     'ditto
	CASE 4: triple = triple + 1                     'ditto
	END SELECT
END IF

END SUB

FUNCTION CheckMove (mode)

ok = True                                            'assume piece can move

offset = (playpiece * 4) + pieceorientation          'calc offset

FOR xmask = 0 TO 3                                   'left to right
	FOR ymask = 0 TO 3                                 'top to bottom
		IF masks(offset, ymask, xmask) = 1 THEN          'bit there ?

			xgrid = ((xpiece + (xmask * blockwidth)) / blockwidth) - 1   'calc grid
			ygrid = ((ypiece + (ymask * blockheight)) / blockheight) - 5 'ditto

			SELECT CASE mode                                   'which direction  ?
			CASE right
	IF grid(ygrid, xgrid + 1) = 1 THEN ok = false   'look right
			CASE left
	IF grid(ygrid, xgrid - 1) = 1 THEN ok = false   'look left
			CASE down
	IF grid(ygrid + 1, xgrid) = 1 THEN ok = false 'look down
			END SELECT
		END IF
	NEXT
NEXT
 

CheckMove = ok

END FUNCTION

FUNCTION CheckRotate

ok = True                           'assume piece can be rotated

offset = (playpiece * 4) + pieceorientation            'calc offset

FOR xmask = 0 TO 3                                     'left to right
	FOR ymask = 0 TO 3                                   'top to bottom
		IF masks(offset, ymask, xmask) = 1 THEN
			xgrid = ((xpiece + (xmask * blockwidth)) / blockwidth) - 1
			ygrid = ((ypiece + (ymask * blockheight)) / blockheight) - 5
			IF grid(ygrid, xgrid) = 1 THEN ok = false
		END IF
	NEXT
NEXT

CheckRotate = ok

END FUNCTION

SUB Clearbuffer             'clear key buffer
DEF SEG = &H40              'point to low memory
POKE &H1A, PEEK(&H1C)       'point head to tail
END SUB

FUNCTION Colorvalue& (attribute)
' returns color value of requested attribute
OUT &H3C7, attribute         ' Inform video card of request
red = INP(&H3C9)             ' get red component
grn = INP(&H3C9)             ' get green component
blu = INP(&H3C9)             ' get blue component
Colorvalue& = (65536 * blu) + (256 * grn) + red   ' Calculate color value

END FUNCTION

SUB DoFillPit


DIM holes(3)                            'dim array for hole values

endy = 22 - handicap                    'how far up the pit ?

FOR ygrid = 21 TO endy STEP -1          'start at bottom
	screeny = (ygrid + 5) * 7             'calc graphic coordinate

	FOR num = 0 TO 3
		holes(num) = (RND * 10) + 1         'generate hole values
	NEXT

	FOR xgrid = 1 TO 10                   'left to right

		nohole = True                      'reset flag
		FOR num = 0 TO 3                   'check for holes
			IF holes(num) = xgrid THEN nohole = false   'don't put a block
		NEXT

		IF nohole = True THEN
			screenx = (xgrid + 1) * 11                  'calc graphic coordinate
			PUT (screenx, screeny), blocks(77, 8) 'PUT block
			grid(ygrid, xgrid) = 1                  ' store value into grid array
	 END IF

	NEXT xgrid
NEXT ygrid



END SUB

SUB DrawBlocks

DEFINT A-Z

REDIM blocks(77, 10)            ' need storage area
						 
				' start Drawing and storing blocks
DO

	row = 0
	Row2 = row + 7 - 1
	col = col + 15
	col2 = col + 11 - 1
 
	colour = colour + 1

	SELECT CASE (colour)
	CASE (1)                         ' reds
		bc = 6                         ' bc - block color
		sc = 4                         ' sc - shade color
		hc = 7                         ' hc - highlight color

	CASE (2)
		bc = 36: sc = 34: hc = 39      ' purples
	
	CASE (3)
		bc = 125: sc = 122: hc = 127    ' blues
			
	CASE (4)
		bc = 14: sc = 12: hc = 15       ' greens
				 
	CASE (5)
		bc = 28: sc = 25: hc = 30       ' yellows
	
	CASE (6)
		bc = 102: sc = 100: hc = 103    ' light blues

	CASE (7)
		bc = 45: sc = 43: hc = 48       ' dark oranges

	CASE (8)
		bc = 136: sc = 132: hc = 140    ' grays

	CASE (9)
		bc = 208: sc = 204: hc = 212    ' color changing blocks
	END SELECT
 
	LINE (col, row)-(col2, Row2), bc, BF      ' draw block
	LINE (col, Row2)-(col2, Row2), sc         ' shade bottom
	LINE (col2, row)-(col2, Row2), hc         ' highlight right side
	LINE (col, row)-(col2, row), hc           ' higlight top
	LINE (col, row)-(col, Row2), sc           ' shade left side
							 
	GET (col, row)-(col2, Row2), blocks(77, colour)   ' store block

 
 LOOP UNTIL colour = 9


END SUB

SUB DrawPlayPiece (x, y, playpiece, pieceorientation)

' Draws playpiece at x,y in position pieceorientation. If piece has stoped
' traveling ,piecelanded will be true and playpiece will change color.


FOR xscan = 0 TO 3
 FOR yscan = 0 TO 3
		offset = (playpiece * 4) + pieceorientation
		IF masks(offset, yscan, xscan) = 1 THEN
			xpos = (xscan * blockwidth)
			ypos = (yscan * blockheight)
			IF piecelanded THEN
	PUT (xpos + x, ypos + y), blocks(77, playpiece + 1)
	PUT (xpos + x, ypos + y), blocks(77, 9)
			ELSE
	PUT (xpos + x, ypos + y), blocks(77, playpiece + 1)
			END IF
		END IF
 NEXT
NEXT

END SUB

SUB DrawPlayScreen



						 ' border
PUT (11, 0), blocks(77, 3)                 ' top left corner
FOR backx = 22 TO 294 STEP 11              ' top line
	PUT (backx, 0), blocks(77, 3)
NEXT
PUT (backx, 0), blocks(77, 3)              ' top Right Corner

FOR backy = 7 TO 183 STEP 7
	PUT (backx, backy), blocks(77, 3)        ' right side
NEXT
PUT (backx, backy), blocks(77, 3)          ' bottom right corner
FOR backx = 286 TO 22 STEP -11             ' right bottom
	PUT (backx, backy), blocks(77, 3)
NEXT
PUT (backx, backy), blocks(77, 3)          ' bottom left corner
FOR backy = 7 TO 184 STEP 7
	PUT (backx, backy), blocks(77, 3)        ' left side
NEXT

LINE (132, 48)-(296, 188), 121, BF
LINE (132, 48)-(132, 188), 122
LINE (200, 100)-(296, 100), 125
LINE (132, 100)-(132, 188), 125

p5x7font 140, 95, "Statistics", 74
LINE (132, 93)-(200, 105), 125, B
LINE (132, 48)-(296, 48), 125
LINE (132, 93)-(132, 48), 125
LINE (230, 48)-(230, 100), 125
LINE (230, 60)-(296, 60), 125

GetHighScores (1)

p5x7font 136, 50, "Score", 68
p5x7font 170, 50, "0", 69
p5x7font 136, 65, "HighScore", 70
p5x7font 190, 65, oldhigh$, 71
p5x7font 136, 80, "Lines", 72
p5x7font 166, 80, "0", 68

p5x7font 234, 62, "Insert", 76
IF slammode THEN
	p5x7font 274, 62, "On", 15
ELSE
	p5x7font 274, 62, "Off", 7
END IF

p5x7font 235, 75, "Sound", 79
IF soundmode THEN
	p5x7font 275, 75, "On", 81
ELSE
	p5x7font 275, 75, "Off", 80
END IF

p5x7font 240, 49, "Messages", 74
p5x7font 22, 6, "Next", 65
levelnum$ = LTRIM$(STR$(levelnum))
p5x7font 111, 14, levelnum$, 67
p5x7font 99, 6, "Level", 66
p5x7font 250, 110, "Singles", 84
p5x7font 250, 130, "Doubles", 86
p5x7font 250, 150, "Triples", 88
p5x7font 250, 170, "Matrixs", 90


END SUB

SUB EndGame
 
SoundFX 4
LINE (44, 57)-(109, 84), 21, BF               'make a plate
LINE (44, 57)-(109, 84), 23, B                'ditto
p5x7font 49, 66, "GAME OVER", 140             'let em know what happened
DO: LOOP UNTIL ReturnEvent                    'wait for a keypress
GetHighScores (0)                             'display highscores
RUN                                           'restart Matrix
END

END SUB

SUB EndToQBasic


x1 = 105: x2 = 210: y1 = 50: y2 = 115     'define box

GetArea x1, y1, x2, y2, 0                 'save area

LINE (x1, y1)-(x2, y2), 29, BF            'draw box
LINE (x1, y1)-(x2, y2), 26, B             'ditto

p5x7font 120, 67, "Exit to Qbasic", 32       'print text
p5x7font 120, 68, "Exit to Qbasic", 0       'print text

p5x7font 127, 79, "   (Y/N)   ", 32          'ditto
p5x7font 127, 78, "   (Y/N)   ", 0          'ditto

p5x7font 127, 89, " (R)estart ", 32          'ditto
p5x7font 127, 88, " (R)estart ", 0          'ditto

DO                                        'input loop

 a$ = INKEY$                              'get key press
 SELECT CASE a$                           'process it
 CASE "Y", "y": END
 CASE "N", "n": EXIT DO
 CASE "R", "r": RUN
 END SELECT

LOOP

GetArea x1, y1, x2, y2, 1                 'restore screen
				 
END SUB

SUB GetArea (ax, ay, bx, by, replace)

STATIC x, y, stor()

IF replace = 0 THEN
	size1 = ax - bx
	size2 = ay - by
	totalsize = size1 * size2
	REDIM stor(totalsize)
	GET (ax, ay)-(bx, by), stor
	x = ax
	y = ay
ELSE
	PUT (x, y), stor, PSET
	ERASE stor
END IF

END SUB

SUB GetHighScores (mode)

DIM score(1 TO 16) AS highscores

filespec$ = "QBMATRIX.SCR"

OPEN filespec$ FOR RANDOM AS #1 LEN = 46            'open  file
FOR n = 1 TO 15                                     'first to last
	GET #1, n, score(n)                               'load it in
NEXT n                                              'next entry
CLOSE #1                                            'close the file

IF VAL(score(1).num) = 0 THEN                       'did file exist
	 OPEN filespec$ FOR RANDOM AS #1 LEN = 46         'create file
	 FOR n = 1 TO 15                                  'first to last
		 READ a$, B$, c$, d$, e$                        'read in data
			score(n).rank = a$                            'store it
			score(n).dat = B$                             'ditto
			score(n).nam = c$                             'ditto
			score(n).lines = d$                             'ditto
			score(n).num = e$                             'ditto
		 PUT #1, n, score(n)                            'write it
		NEXT n                                          'next entry
	CLOSE #1                                          'close file
END IF


SELECT CASE mode

CASE 0

 Temp$ = LTRIM$(STR$(gamescore&))                    'convert to clean string
 addpad = 6 - LEN(Temp$)                             'calc padding
 gamescor$ = Temp$ + STRING$(addpad, 32)             'add it

 FOR rank = 1 TO 15                                  'find players rank

	 IF gamescore& > VAL(score(rank).num) THEN         'make the list ?
 
		 FOR bump = 14 TO rank STEP -1                   'sort it
	score(bump + 1).dat = score(bump).dat        'bump ahead
	score(bump + 1).nam = score(bump).nam        'ditto
	score(bump + 1).lines = score(bump).lines        'ditto
	score(bump + 1).num = score(bump).num        'ditto
		 NEXT                                            'bump next
		 month$ = MID$(DATE$, 1, 2)                      'get month
		 day$ = MID$(DATE$, 4, 2)                        'get day
		 year$ = MID$(DATE$, 9, 2)                       'get year
		 format$ = month$ + "/" + day$ + "/" + year$     'format the date
		 score(rank).dat = format$                       'store it
		 score(rank).lines = LTRIM$(STR$(linescleared))  'store it
		 score(rank).num = gamescor$                     'store gamescore
		 score(rank).nam = ""
		 ShowHighScores score(), 1                       'print the list
		 y = (rank * 10) + 26                            'calc y
		 score(rank).nam = InputText$(93, y, 24)         'enter name
		 OPEN filespec$ FOR RANDOM AS #1 LEN = 46        'open file
		 FOR n = 1 TO 15                                 'first to last
			 PUT #1, n, score(n)                           'write entry
		 NEXT                                            'next entry
		 CLOSE #1                                        'close file
		 EXIT FOR                                        'all done
	 END IF
	NEXT

CASE 1                                               'return highscore
	oldhigh$ = score(1).num
CASE 2
	ShowHighScores score(), 0                          'print the list
END SELECT



END SUB

SUB GetOptions

xmin = 20                              'set cursor limits
ymin = 20
xmax = 300
ymax = 190

CLS

LINE (11, 7)-(307, 188), 124, BF      'make a background plate

TileScreen (0)

					 
						 'ini buttons
Button 35, 24, 0, 1, 1               'quick drop
Button 35, 44, 0, 1, 1               'ditto
Button 219, 24, 0, 1, 1              'sound mode
Button 219, 44, 0, 1, 1              'ditto
Button 126, 24, 0, 3, 1              'Play matrix
						 
							' print headers
p5x7font 140, 10, "Options", 95
p5x7font 149, 32, "Play", 0
p5x7font 135, 43, "QB Matrix", 0
p5x7font 150, 31, "Play", 84
p5x7font 136, 42, "QB Matrix", 84
p5x7font 145, 62, "Level", 96
p5x7font 136, 92, "Handicap", 96
p5x7font 48, 28, "Slam on", 96
p5x7font 48, 48, "Slam off", 96
p5x7font 216, 28, "  Sound On", 96
p5x7font 214, 48, "  Sound Off", 96

p5x7font 14, 148, " Use Arrow keys or numeric key pad to move cursor.", 96
p5x7font 32, 158, " Press space bar or 5 key to press buttons.", 96


x = 45                                         'level number buttons
FOR n = 0 TO 9
	Button x - 5, 74, 0, 0, 1
	p5x7font x, 77, CHR$(n + 48), 96
	x = x + 25
NEXT n

x = 45                                         'number handicap buttons
FOR n = 0 TO 9
	Button x - 5, 104, 0, 0, 1
	p5x7font x, 107, CHR$(n + 48), 96
	x = x + 25
NEXT n

								 'set previous options
xbut = (levelnum * 25) + 40                    'calc button
Button xbut, 74, 1, 0, 0                       'push it in
xbut = (handicap * 25) + 40                    'calc button
Button xbut, 104, 1, 0, 0                      'push it in


IF slammode THEN                      'Set slammode
	Button 35, 24, 1, 1, 0
ELSE
	Button 35, 44, 1, 1, 0
END IF

IF soundmode THEN                       'set sound
	Button 219, 24, 1, 1, 0               'push button
ELSE                                    'sound off
	Button 219, 44, 1, 1, 0               'push button
END IF



PALETTE 255, (65536 * 0) + (256 * 0) + 60      'define cusor
curwidth = 6                                   'ditto
curheight = 8                                  'ditto
DIM cursor(1 TO curwidth, 1 TO curheight)      'dim array
FOR y = 1 TO curheight                         'top to bottom
	FOR x = 1 TO curwidth                        'left to right
	 READ dat                                    'read data
		cursor(x, y) = dat                         'store to array
	 NEXT
NEXT


xcur = 160: ycur = 40                                      'set position

bytes = ((xcur + curwidth) * (ycur + curheight)) / 2 + 2   'calc bytes
DIM background(bytes)                                  'to restore background



DO                                                        ' input loop


	 GET (xcur, ycur)-(xcur + curwidth, ycur + curheight), background

	 FOR y = 1 TO curheight
		FOR x = 1 TO curwidth                             'Draw cursor
		 IF cursor(x, y) = 1 THEN PSET (xcur + x, ycur + y), 255
		NEXT
	 NEXT
 
	 DO
		 event = ReturnEvent
		 red = red + 1: IF red > 63 THEN red = 10          'strobe cursor
		 PALETTE 255, (65536 * blu) + (256 * grn) + red    'ditto
	 LOOP UNTIL event
	
	 PUT (xcur, ycur), background, PSET

 
	 SELECT CASE event
							 'process events
	 CASE Esc
			EndToQBasic
	 CASE up, Eight
		 IF ycur > ymin THEN ycur = ycur - 6
	 CASE down, two
		 IF ycur < ymax THEN ycur = ycur + 6
	 CASE left, Four
		 IF xcur > xmin THEN xcur = xcur - 6
	 CASE right, Six
		 IF xcur < xmax THEN xcur = xcur + 6
	 CASE enter, space, five
		 
		 IF xcur >= 126 AND xcur <= 191 THEN
				SELECT CASE ycur
				CASE 25 TO 57                                    'Play Matrix
		OPEN "QBMATRIX.OPT" FOR OUTPUT AS #1          'open file
		WRITE #1, levelnum, handicap, slammode, soundmode  'save game options
		CLOSE #1                                   'close the file
		EXIT DO                                'leave options screen
				END SELECT
		 END IF
		
		IF ycur >= 74 AND ycur <= 88 THEN          'level select
			IF xcur >= 40 AND xcur <= 280 THEN
				FOR x = 40 TO 265 STEP 25              'reset all buttons
		Button x, 74, 0, 0, 0
				NEXT
				xbut = (((xcur - 40) \ 25) * 25) + 40    'calc button
				Button xbut, 74, 1, 0, 0                'push it in
				levelnum = ((xcur - 40) \ 25)            'calc levelnum
				droptime! = (.5 / (levelnum + 1))  'calc new droptime
			END IF
		END IF

	
	 IF ycur >= 104 AND ycur <= 118 THEN         'handicap select
		 IF xcur >= 40 AND xcur <= 280 THEN
			 FOR x = 40 TO 265 STEP 25               'reset all buttons
				Button x, 104, 0, 0, 0                 'pop 'em  out
			 NEXT
			 xbut = (((xcur - 40) \ 25) * 25) + 40   'calc button
			 Button xbut, 104, 1, 0, 0               'push it in
			 handicap = ((xcur - 40) \ 25)           'calc handicap
		 END IF
	 END IF
	 
	 IF xcur >= 35 AND xcur <= 102 THEN
		 SELECT CASE ycur
		 CASE 25 TO 38                        'slammode on
			 slammode = -1                      'set slammode
			 Button 35, 24, 1, 1, 0             'push button
			 Button 35, 44, 0, 1, 0             'pop button
		 CASE 44 TO 57                        'slammode off
			 slammode = 0                       'set slammode
			 Button 35, 44, 1, 1, 0             'push button
			 Button 35, 24, 0, 1, 0             'pop button
		 END SELECT
	 END IF


	 IF xcur >= 220 AND xcur <= 284 THEN
		 SELECT CASE ycur
		 CASE 25 TO 38                          'sound on
			 soundmode = -1                       'set sound
			 Button 219, 24, 1, 1, 0              'push button
			 Button 219, 44, 0, 1, 0              'pop button
		 CASE 44 TO 57                          'sound off
			 soundmode = 0                        'set sound
			 Button 219, 24, 0, 1, 0              'push button
			 Button 219, 44, 1, 1, 0              'pop button
		 END SELECT
	 END IF



	 SoundFX (0)
	 Stay (30)

 END SELECT


LOOP

CLS


END SUB

FUNCTION GetPiece
'Chooses and displayed next playpiece in upper left hand corner.

STATIC initialize, nextplaypiece


IF NOT initialize THEN
	playpiece = INT(RND * 7)
	nextplaypiece = INT(RND * 7)
	DrawPlayPiece 22, 14, nextplaypiece, 0
	initialize = NOT intialize
ELSE
	DrawPlayPiece 22, 14, nextplaypiece, 0      ' erase last piece
	playpiece = nextplaypiece
	nextplaypiece = INT(RND * 7)
	DrawPlayPiece 22, 14, nextplaypiece, 0      ' draw next piece
END IF

UpdatePieceMeter (0)

GetPiece = playpiece

END FUNCTION

FUNCTION InputText$ (xcur, ycur, length)


PALETTE 255, (65536 * 0) + (256 * 0) + 60  'define cursor color
DIM Edit$(length)                            'dim array to edit
ele = 1                                      'first element
DIM background(35, length + 2)
GET (xcur, ycur)-(xcur + 6, ycur + 8), background(35, 1)
p5x7font xcur, ycur, "_", 255              'init curser


Clearbuffer

DO

	 DO                                                  'event loop
		 event = ReturnEvent                               'anything happen ?
		 IF dir = 0 THEN                                   'strobe cursor
			 red = red + 1: IF red > 62 THEN dir = 1           'ditto
		 ELSE                                              'ditto
			 red = red - 1: IF red < 10 THEN dir = 0           'ditto
		 END IF                                            'ditto
		 PALETTE 255, (65536 * blu) + (256 * grn) + red    'ditto
	 LOOP UNTIL event                                    'back for event

	 SELECT CASE event
	 CASE Esc: EXIT DO                          'do Esc
	 CASE enter: EXIT DO                        'do enter
	 CASE 1 TO 7, 9 TO 126                              'do regular keys
		 event$ = CHR$(event)                     'convert for printing
		 IF ele < length THEN                     'stay in bounds
			 PUT (xcur, ycur), background(35, ele), PSET
			 p5x7font xcur, ycur, CHR$(event), 144 'print font
			 Edit$(ele) = event$                     'for backspace
			 SELECT CASE event$                      'adjust kern
			 CASE "i": xcur = xcur + 2               'ditto
			 CASE "j": xcur = xcur + 5               'ditto
			 CASE "l": xcur = xcur + 2               'ditto
			 CASE "r": xcur = xcur + 5               'ditto
			 CASE ".": xcur = xcur + 3               'ditto
			 CASE "(": xcur = xcur + 3               'ditto
			 CASE ")": xcur = xcur + 3               'ditto
			 CASE "'": xcur = xcur + 2               'ditto
			 CASE "!": xcur = xcur + 2               'ditto
			 CASE ELSE: xcur = xcur + 6              'ditto
			 END SELECT
			 ele = ele + 1                           'adjust
			 GET (xcur, ycur)-(xcur + 6, ycur + 8), background(35, ele)
			 p5x7font xcur, ycur, "_", 255         'print cursor
		 END IF

	 CASE backspace, left                       'do backspace
		 IF ele > 1 THEN
			 PUT (xcur, ycur), background(35, ele), PSET
			 ele = ele - 1   'adjust
			 SELECT CASE (Edit$(ele))               'adjust kern
			 CASE "i": xcur = xcur - 2              'ditto
			 CASE "j": xcur = xcur - 5              'ditto
			 CASE "l": xcur = xcur - 2              'ditto
			 CASE "r": xcur = xcur - 5              'ditto
			 CASE ".": xcur = xcur - 3              'ditto
			 CASE "(": xcur = xcur - 3              'ditto
			 CASE ")": xcur = xcur - 3              'ditto
			 CASE "'": xcur = xcur - 2              'ditto
			 CASE "!": xcur = xcur - 2              'ditto
			 CASE ELSE: xcur = xcur - 6             'ditto
			 END SELECT
			 PUT (xcur, ycur), background(35, ele), PSET
			 p5x7font xcur, ycur, "_", 255        'print cursor
			 Edit$(ele) = CHR$(space)               'clear element
		 END IF
	END SELECT
LOOP

FOR n = 1 TO length - 1                         'put elements into a string
 IF Edit$(n) = "" THEN Edit$(n) = CHR$(space)   'replace nulls
 Temp$ = Temp$ + Edit$(n)                       'create string
NEXT n

InputText$ = Temp$


END FUNCTION

SUB P3x5Num (x, y, num, colour)

Temp$ = LTRIM$(STR$(num))                   'convert number to string
length = LEN(Temp$)                         'get it's length

FOR ele = 1 TO length                       'print charactors in string
 offset = ASC(MID$(Temp$, ele, 1)) - 48  'extract charactor/calc array offset
 FOR ypos = 1 TO 5                                'top to bottom
	 FOR xpos = 1 TO 3                              'left to right
		 IF smallnum(offset, ypos, xpos) = 1 THEN     'set bits only
			 PSET (x + xpos + xkern, y + ypos), colour  'PSET using colour
		 END IF
	 NEXT xpos
 NEXT ypos
 xkern = xkern + 4                         'adjust kern
 Clearbuffer                                'clear the buffer
NEXT ele

END SUB

SUB p5x7font (x, y, text$, colour)

length = LEN(text$)                    'get characters to print
IF length = 0 THEN EXIT SUB            'check length

FOR char = 0 TO length - 1             'print loop

	 piece$ = MID$(text$, char + 1, 1)   'look at each piece of string
	 aski = ASC(piece$)                  'assign it's ASCII value
 
	 SELECT CASE (piece$)                 'adjust lower case
	 CASE "g": kerny = kerny + 2         'ditto
	 CASE "j": kerny = kerny + 2         'ditto
	 CASE "p": kerny = kerny + 2         'ditto
	 CASE "q": kerny = kerny + 2         'ditto
	 CASE "y": kerny = kerny + 2         'ditto
	 END SELECT

	 FOR ybit = 0 TO 6                               'top to Bottom
		 FOR xbit = 0 TO 4                              'left to right
			 IF font(aski, xbit, ybit) = 1 THEN           'set true bits only
	 PSET (x + xbit + kernx, y + ybit + kerny), colour   'PSET data
			 END IF
		 NEXT
	 NEXT

	 SELECT CASE (piece$)                'kern adjusment
	 CASE "i": kernx = kernx + 2        'ditto
	 CASE "j": kernx = kernx + 5        'ditto
	 CASE "l": kernx = kernx + 2        'ditto
	 CASE "r": kernx = kernx + 5        'ditto
	 CASE ".": kernx = kernx + 3        'ditto
	 CASE "(": kernx = kernx + 3        'ditto
	 CASE ")": kernx = kernx + 3        'ditto
	 CASE "'": kernx = kernx + 2        'ditto
	 CASE "!": kernx = kernx + 2        'ditto
	 CASE ELSE: kernx = kernx + 6       'ditto
	 END SELECT

	 kerny = 0                           'reset

NEXT


END SUB

SUB PauseGame

SoundFX 2
GetArea 242, 85, 292, 97, 0
p5x7font 242, 85, "Paused", 47
DO: LOOP UNTIL ReturnEvent
CALL GetArea(1, 1, 0, 0, 1)
Newcycle = false
SoundFX 3

END SUB

SUB RestorePal
	
DIM pal(256) AS hues                'DIM array for palette
DEF SEG = VARSEG(pal(0))            'point to it
BLOAD "QBMATRIX.PAL", 0             'load palette

OUT &H3C8, 0                        'inform video card
FOR c = 0 TO 255                    'load all registers
	OUT &H3C9, pal(c).red             'send red component
	OUT &H3C9, pal(c).grn             'send green component
	OUT &H3C9, pal(c).blu             'send blue component
NEXT

END SUB

FUNCTION ReturnEvent

kee$ = INKEY$                               'get key from buffer
	
IF kee$ <> "" THEN                          'key pressed ?
 IF LEN(kee$) = 1 THEN                      'whats the length ?
	 keycode = ASC(kee$)                      'it's a regular key
 ELSE
	 keycode = -ASC(RIGHT$(kee$, 1))          'it's an extented key
 END IF
END IF


ReturnEvent = keycode                       'return the event


END FUNCTION

SUB ShowHighScores (score() AS highscores, mode)


CLS

tile = (RND * 14) + 1                           'get a random tile
TileScreen (tile)                               'tile the screen

p5x7font 111, 17, "Matrix Hall of Fame", 0
p5x7font 110, 16, "Matrix Hall of Fame", 144

p5x7font 20, 25, "Rank                             Lines  Score", 0
p5x7font 20, 25, "Rank                             Lines  Score", 30

placey = 35
shadow = 1

FOR a = 1 TO 15
	 p5x7font 22 + shadow, placey + shadow, score(a).rank, 0
	 p5x7font 38 + shadow, placey + shadow, score(a).dat, 0
	 p5x7font 93 + shadow, placey + shadow, score(a).nam, 0
	 p5x7font 240 + shadow, placey + shadow, score(a).lines, 0
	 p5x7font 268 + shadow, placey + shadow, score(a).num, 0
	 p5x7font 22, placey, score(a).rank, 144
	 p5x7font 38, placey, score(a).dat, 144
	 p5x7font 93, placey, score(a).nam, 144
	 p5x7font 240, placey, score(a).lines, 144
	 p5x7font 268, placey, score(a).num, 144
	 placey = placey + 10                       ' drop y to a new line
NEXT a

IF mode THEN EXIT SUB

DO

FOR x = 19 TO 419 STEP 5          ' highlights highscore entry
	FOR y = 35 TO 42
		FOR offsetx = 0 TO 10
			IF POINT(x + offsetx, y) = 144 THEN PSET (x + offsetx, y), 8
			IF ReturnEvent THEN EXIT DO
		NEXT
	NEXT
	Stay (40)
	FOR y = 35 TO 42
		FOR offsetx = 0 TO 10
		 IF POINT(x + offsetx, y) = 8 THEN PSET (x + offsetx, y), 144
		 IF ReturnEvent THEN EXIT DO
		NEXT
	NEXT
NEXT

LOOP UNTIL ReturnEvent


END SUB

DEFSNG A-Z
SUB SoundFX (fx%)

IF soundmode% = 0 THEN EXIT SUB


SELECT CASE fx%

CASE 0                            'landing hit
	frequency = 147
	FOR scale = 6 TO 1 STEP -1
		duration = scale / 100
		frequency = frequency + 47
		SOUND frequency, duration
	NEXT

CASE 1                             'Row clear
	FOR scale = 6 TO 1 STEP -1
		duration = scale / 10
		frequency = frequency + 100
		SOUND frequency, duration
	NEXT
	Stay (27)
	SOUND 700, .1
	SOUND 800, .2
	SOUND 900, .3

CASE 2                ' event leave noise
	SOUND 1000, .1
	Stay (210)
	SOUND 2000, .1

CASE 3                'event enter noise
	SOUND 2000, .1
	Stay (210)
	SOUND 1000, .1


CASE 4               'game end
 decay = 10
 duration = .1
 FOR freq = 500 TO 100 STEP -decay
	 SOUND freq, duration
	 Stay (20)
	 Clearbuffer
 NEXT
 decay = 10
 duration! = .1
 FOR frequency = 500 TO 100 STEP -decay
	 SOUND frequency, duration
	 Stay (50)
	 Clearbuffer
 NEXT

END SELECT

END SUB

SUB Stay (Millisecs)

STATIC syspeed&, Time2


IF syspeed& THEN                ' First time here -get relative system speed
 IF Millisecs THEN             ' Start Delay loop
				 
	 Factor& = (syspeed& * Millisecs) \ 55          'num of loops needed
				
	 DO                                             ' delay loop
		 Factor& = Factor& - 1                        ' Sub the num of loops
		 LOOP UNTIL Time2 = PEEK(&H6C) OR Factor& = 0   ' make loop same as below

	END IF
ELSE                               ' Relative system speed processed here
	DEF SEG = &H40
	Time1 = PEEK(&H6C)

	DO
		Time2 = PEEK(&H6C)             ' get another
	LOOP UNTIL Time1 <> Time2        ' loop until new clock tick

	DO                               ' start here at new clock tick
		syspeed& = syspeed& - 1        ' Count the number of times looped
	LOOP UNTIL Time2 <> PEEK(&H6C) OR syspeed& = 0  'make same as loop above
	Time2 = 1255
	syspeed& = ABS(syspeed&)        'cant use this neg -reverse it
	
END IF



END SUB

DEFINT A-Z
SUB TileScreen (tile)
DIM buffer(141, 20)
DEF SEG = VARSEG(buffer(0, 0))
BLOAD "QBMATRIX.TL1", 0
FOR y = 0 TO 190 STEP 14
 FOR x = 0 TO 319 STEP 20
		PUT (x, y), buffer(141, tile), PSET
 NEXT
NEXT
END SUB

FUNCTION TimeToDrop

STATIC samp!

ok = false            'assume no drop

IF samp! = 0 THEN
	samp! = TIMER
ELSE
 IF ABS(TIMER - samp!) >= droptime! THEN
	 ok = True
	 samp! = 0
 END IF
END IF


TimeToDrop = ok


END FUNCTION

SUB TitleScreen

col = 18                                           'draw background
FOR x = 0 TO 320
	col = col + 1: IF col > 24 THEN col = 18
	x2 = 160
	y = 0
	y2 = 100
	LINE (x, y)-(x2, y2), col
NEXT

FOR x = 0 TO 320
 col = col + 1: IF col > 24 THEN col = 18
 x2 = 160
 y = 200
 y2 = 100
 LINE (x, y)-(x2, y2), col
NEXT

FOR y = 0 TO 200
	col = col + 1: IF col > 24 THEN col = 18
	x2 = 160
	x = 0
	y2 = 100
	LINE (x, y)-(x2, y2), col
NEXT

FOR y = 0 TO 200
 col = col + 1: IF col > 24 THEN col = 18
 x2 = 160
 x = 320
 y2 = 100
 LINE (x, y)-(x2, y2), col
NEXT


Clearbuffer                                  'clearkeybuffer
		
p5x7font 133, 50, "QB Matrix", 138              'shadow title
p5x7font 133, 51, "QB Matrix", 54              'print title


						 
p5x7font 57, 105, "Copyright ", 138               'shadow Copyright
CIRCLE (118, 110), 5, 138                      'ditto
CIRCLE (118, 110), 2, 138, 1, 5                'ditto
p5x7font 129, 106, "1996", 138                    'ditto
p5x7font 162, 106, "Nocturnal Creations", 138     'ditto
							
p5x7font 58, 105, "Copyright ", 0             'print Copyright
CIRCLE (119, 110), 5, 0                    'ditto
CIRCLE (119, 110), 2, 0, 1, 5              'ditto
p5x7font 130, 106, "1996", 0                  'ditto
p5x7font 161, 106, "Nocturnal Creations", 0   'ditto
					
p5x7font 96, 161, "Press any key to start.", 138   'ditto
p5x7font 96, 160, "Press any key to start.", 26   'ditto
							
col! = 65536
var1 = 15
var2 = 30
var3 = 45
var4 = 62

DO                                         ' animate background
	 
	PALETTE 18, var1 * col!
	IF CountForwards1 = 0 THEN
		var1 = var1 + 1
		IF var1 >= 62 THEN CountForwards1 = 1
	ELSE
		var1 = var1 - 1
		IF var1 <= 20 THEN CountForwards1 = 0
	END IF

	PALETTE 24, var2 * col!
	IF CountForwards2 = 0 THEN
		var2 = var2 + 1
		IF var2 >= 62 THEN CountForwards2 = 1
	ELSE
		var2 = var2 - 1
		IF var2 <= 20 THEN CountForwards2 = 0
	END IF

	PALETTE 21, var3 * col!
	IF CountForwards3 = 0 THEN
		var3 = var3 + 1
		IF var3 >= 62 THEN CountForwards3 = 1
	ELSE
		var3 = var3 - 1
		IF var3 <= 20 THEN CountForwards3 = 0
	END IF

	PALETTE 19, var4 * col!
	IF CountForwards4 = 0 THEN
		var4 = var4 + 1
		IF var4 >= 62 THEN CountForwards4 = 1
	ELSE
		var4 = var4 - 1
		IF var4 <= 20 THEN CountForwards4 = 0
	END IF

	PALETTE 22, var2 * col!
	PALETTE 23, var3 * col!

	event = ReturnEvent                            'check for events

	SELECT CASE event                              'process 'em
	CASE false                                     'absorb Nulls
	CASE Esc: EndToQBasic                          'end game
	CASE ELSE: RestorePal: EXIT DO                 'play game

	END SELECT

LOOP

					 

END SUB

SUB UpdatePieceMeter (mode)

STATIC bg1(), xm(), ym(), Total(), bg2(), xhigh

xstart = 145   'set start values
ystart = 110   'ditto
xlimit = 200   'limit travel


IF mode = -1 THEN
 DIM bg1(160, 7)        'To restore background behind pieces
 DIM bg2(105, 8)        'To restore background behind small numbers
 DIM xm(6)              'x placement
 DIM ym(6)              'y placement
 DIM Total(6)           'Total of each piece played
 
 FOR piece = 0 TO 6         'initialize all pieces
	 xm(piece) = xstart        'set coordinates
	 ym(piece) = ystart        'ditto
	 ystart = ystart + 10      'adjust y

' GET background info
GET (xm(piece), ym(piece))-(xm(piece) + 20, ym(piece) + 8), bg1(160, piece)
GET (xm(piece) + 24, ym(piece) + 2)-(xm(piece) + 36, ym(piece) + 8), bg2(105, piece)
GET (xm(piece) + 24, 180)-(xm(piece) + 41, 180 + 8), bg2(105, 7)
		 
			
	 FOR y = 1 TO 8                                'from top to bottom
		 FOR x = 1 TO 20                              'left to right
			 dat = meterpieces(piece, x, y)              'get data
			 IF dat <> 0 THEN PSET (xm(piece) + x, ym(piece) + y), dat   'PSET data
		 NEXT x                                       'next x
	 NEXT y                                        'next y

	 P3x5Num xm(piece) + 24, ym(piece) + 1, 0, 92  'print numbers

 NEXT piece                                     'next piece
					 
ELSE                                            'move meter bitmaps


						'restore background
	PUT (xm(playpiece), ym(playpiece)), bg1(160, 0), PSET
	PUT ((xm(playpiece) + 24), ym(playpiece) + 2), bg2(105, 0), PSET
	PUT ((xhigh + 24), 180), bg2(105, 7), PSET

	Total(playpiece) = Total(playpiece) + 1       'increment piece total

	xm(playpiece) = xm(playpiece) + 1             'increment piece x value
	IF xm(playpiece) > xlimit THEN xm(playpiece) = xstart   'keep in bounds
								 'print value
	P3x5Num xm(playpiece) + 24, ym(playpiece) + 1, Total(playpiece), 92

	FOR y = 1 TO 8                              'top to bottom
		FOR x = 1 TO 20                            'left to right
			dat = meterpieces(playpiece, x, y)       'get data
			IF dat <> 0 THEN PSET (xm(playpiece) + x, ym(playpiece) + y), dat
		NEXT x                                     'next x
	NEXT y                                      'next y

END IF
							

	 'Tally the number of pieces played and display the result.
	 
FOR piece = 0 TO 6                            'count each piece
 piecetotal = piecetotal + Total(piece)      'add 'em up
NEXT                                          'next piece

	' Find the piece with the highest value and use its x value

FOR piece = 0 TO 6                            'look at each piece
	xdata = xm(playpiece)                       'get it's x value
	IF xhigh < xdata THEN xhigh = xdata    'adjust xhigh
NEXT
 
P3x5Num xhigh + 24, 180, piecetotal, 93       'print total pieces played


END SUB

SUB Updatescore

Clearbuffer                                   'clear buffer

ygrid = -(((ypiece / blockheight) - 5) - 22)  'calc landing
mult = levelnum + 1                           'calc multiplier
points = (mult * mult) + (ygrid * mult)       'calc points
gamescore& = gamescore& + points              'add 'em


LINE (170, 50)-(207, 58), 121, BF             'erase old score
gamescore$ = LTRIM$(STR$(gamescore&))         'convert to string
p5x7font 170, 50, gamescore$, 69              'report


LINE (166, 80)-(202, 88), 121, BF              'erase old
linescleared$ = LTRIM$(STR$(linescleared))     'convert to a string
p5x7font 166, 80, linescleared$, 73            'report

LINE (267, 121)-(292, 128), 121, BF            'ditto
single$ = LTRIM$(STR$(sngle))
p5x7font 267, 121, single$, 86

LINE (267, 141)-(292, 148), 121, BF            'ditto
double$ = LTRIM$(STR$(duble))
p5x7font 267, 141, double$, 88

LINE (267, 161)-(292, 168), 121, BF            'ditto
triple$ = LTRIM$(STR$(triple))
p5x7font 267, 161, triple$, 90

LINE (267, 179)-(292, 188), 121, BF            'ditto
matrix$ = LTRIM$(STR$(matrix))
p5x7font 267, 179, matrix$, 92

							

IF linescleared >= nextlevelmark THEN          'change level ?
	levelnum = levelnum + 1                     'increment level
	nextlevelmark = nextlevelmark + levelmark   'adjust next level marker
	IF levelnum < 10 THEN
		droptime! = droptime! - .05                'calc new droptime
	END IF
	ChangePitPal                                'change pit color
	levelnum$ = LTRIM$(STR$(levelnum))          'convert to a string
	LINE (111, 14)-(122, 21), 0, BF             'erase old
	p5x7font 111, 14, levelnum$, 67             'report new
END IF

Clearbuffer                                    'clear the keybuffer

END SUB

