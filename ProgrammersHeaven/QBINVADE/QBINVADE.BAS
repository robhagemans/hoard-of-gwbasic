'Program : QB Invaders
'Version : Ver 1.1 for Qbasic
'Type    : Shareware
'Revised : 4/29/97
'Author  : Tim Truman
'Address : NET -TimTruman@aol.com, AOL-TimTruman
'
'Copyright(c) 1997 Nocturnal Creations
'
'Feel free to use any routines or code found this program in your own.
'I just ask that you do not distribute this source code program or
'modify and recompile the program for reasons other than personal use.
'
'You are not obligated... however if you like QB Invaders, or plan to use
'code from it, please register by sending a small amount of money to :
'Tim Truman
'110 Homestead Ave.
'Springfield, MA 01151
'USA
'
'-------------------
'Info & Requirements
'-------------------
'Graphics for this program were made using SPRITE 2.0.
'Adlib sound effects were made using FX.
'Requires a VGA.
'Recommend 386 or higher processor, and a sound card.
'
'-------------------
'Running QBInvaders       * Important read this ! *
'-------------------
'Playing under DOS:
' Type qbasic /run qbinvade.
'
'Playing under WIN 3.1 and WIN 95 :
' Use the File Manager and double click on the MSDOS shortcut.
' Why?
' Some key combinations are reserved to windows like ALT-SPACE
' combo used by this program. Using the MSDOS shortcut realeases
' this key combo for Qbasic, preventing program errors.
'
'-------------------
' Program options
'-------------------
'  (1) Change the 'UseFX' variable to false for PC speaker sounds.
'  (2) Change the 'Hard' variable to true for harder gameplay.
'  (3) Two graphics set are available.


DEFINT A-Z

TYPE hues                    ' define the type for hues
	red AS INTEGER             ' red component
	grn AS INTEGER             ' green component
	blu AS INTEGER             ' blue component
END TYPE

TYPE sprite
	x          AS INTEGER        'current alien location
	y          AS INTEGER        '
	lx         AS INTEGER        'last alien location
	ly         AS INTEGER        '
	w          AS INTEGER        'width of image
	h          AS INTEGER        'height of image
	dir        AS INTEGER        'referenced for movement
	health     AS INTEGER        'aliens well being
	sseg       AS INTEGER        'segment of alien char
	tile       AS INTEGER        'offset to frame
	ltile      AS INTEGER        'for erase
	hit        AS INTEGER        'check for a hit before moving
END TYPE

TYPE highscores                'type for highscores
	rank AS STRING * 3           'rank
	dat  AS STRING * 8           'date
	nam  AS STRING * 25          'name
	lines  AS STRING * 4         'lines
	score  AS STRING * 6         'score
END TYPE

DECLARE SUB clearbuffer ()
DECLARE SUB DoAliens ()
DECLARE SUB DoAlienBombs ()
DECLARE SUB DoCollisions ()
DECLARE SUB DocommandShip ()
DECLARE SUB EndToDos ()

DECLARE SUB DoHighScores ()
DECLARE SUB Dolevel ()
DECLARE SUB DoScore (points)
DECLARE SUB DoGunShot ()
DECLARE SUB DoGunshot2 ()
DECLARE SUB DoGunner ()
DECLARE SUB DoGameEnd ()
DECLARE SUB FadePal (fc%, lc%, level%, mode%)
DECLARE SUB GetReady ()

DECLARE SUB InitGameStart ()
DECLARE SUB Initlevel ()
DECLARE SUB Intro ()
DECLARE SUB Mouse (argument)
DECLARE SUB p5x7font (x, y, text$, colour)
DECLARE SUB playsfx (fx$)
DECLARE SUB PalRegInfo (reg, red, grn, blu, mode)
DECLARE SUB Pfont (text$, x, y, colour)
DECLARE SUB ShowHighScores (score() AS highscores, mode)
DECLARE SUB soundfx (fx)
DECLARE SUB stay (Millisecs!)
DECLARE SUB TitleScreen ()

DECLARE FUNCTION CheckFiles ()
DECLARE FUNCTION DoExplode (x, y)
DECLARE FUNCTION DropFileList (filename$)
DECLARE FUNCTION Fileexists (filename$)
DECLARE FUNCTION GetFileName$ (filespec$)
DECLARE FUNCTION InputText$ (xcur%, ycur%, length%)
DECLARE FUNCTION returnevent ()
DECLARE FUNCTION TimeIsUp (n, tsecs!)

'mapped key values
CONST up = -72
CONST Down = -80
CONST Left = -75
CONST Right = -77
CONST Eight = 56
CONST Two = 50
CONST Enter = 13
CONST Esc = 27
CONST space = 32
CONST letterc = 99
'mouse
CONST leftclick = 1
CONST rightclick = 2
'other
CONST true = 1
CONST false = 0

COMMON SHARED Maxx, Maxy, event, font(), pal() AS hues
COMMON SHARED sprites(), elmPerSpr, NewAlienFrame, spriteheight, spritewidth
COMMON SHARED alien() AS sprite, numberofaliens, AliensInPLay, movealiens
COMMON SHARED AliensPerCol, AliensPerRow, alienvelx, AlienVely, TimeToStep!
COMMON SHARED AlienStartX, AlienStartY, AlienStepX, AlienStepY
COMMON SHARED abomb() AS sprite, Numberofbombs, AbombInterval!, Abombvel
COMMON SHARED gunner AS sprite, gunnerlives
COMMON SHARED gunner2 AS sprite, gunnerlives2
COMMON SHARED gunnerMaxx, GunnerMinx, numplayers, gunnervel

COMMON SHARED gunshot AS sprite, GunShotVel
COMMON SHARED cship AS sprite, headisup
COMMON SHARED shield() AS sprite, NumberofShields
COMMON SHARED Barrier() AS sprite
COMMON SHARED level, gamescore&, UseFX, Hard

CLS

DIM SHARED c$(8)   'FM register information for 9 channels
c$(0) = "&hB0&h20&h23&h40&h43&h60&h63&h80&h83&hA0&HBD&HC0&HE0&HE3&hB0"
c$(1) = "&hB1&h21&h24&h41&h44&h61&h64&h81&h84&hA1&HBD&HC1&HE1&HE4&hB1"
c$(2) = "&hB2&h22&h25&h42&h45&h62&h65&h82&h85&hA2&HBD&HC2&HE2&HE5&hB2"
c$(3) = "&hB3&h28&h2B&h48&h4B&h68&h6B&h88&h8B&hA3&HBD&HC3&HE8&HEB&hB3"
c$(4) = "&hB4&h29&h2C&h49&h4C&h69&h6C&h89&h8C&hA4&HBD&HC4&HE9&HEC&hB4"
c$(5) = "&hB5&h2A&h2D&h4A&h4D&h6A&h6D&h8A&h8D&hA5&HBD&HC5&HEA&HED&hB5"
c$(6) = "&hB6&h30&h33&h50&h53&h70&h73&h90&h93&hA6&HBD&HC6&HF0&HF3&hB6"
c$(7) = "&hB7&h31&h34&h51&h54&h71&h74&h91&h94&hA7&HBD&HC7&HF1&HF4&hB7"
c$(8) = "&hB8&h32&h35&h52&h55&h72&h75&h92&h95&hA8&HBD&HC8&HF2&HF5&hB8"

DIM SHARED sfx$(25)                   'dim array to hold 26 sounds
OPEN "qbinvade.sfx" FOR INPUT AS #1    'open the .SFX file
FOR sfxnum% = 0 TO 25                 'first to last
 INPUT #1, sfx$(sfxnum%)              'load sound into string
NEXT                                  'next sound
CLOSE #1                              'close the file


SCREEN 13                              'set video mode

Maxx = 319                             'store screen size
Maxy = 199                             'ditto

OUT &H60, &HF3                         'inform keyboard port
stay (500)                             'let hardware settle
OUT &H60, 0                            'fast typematic rate with min delay

bucket = TimeIsUp(7, -1)               'set up timers
stay (1)                               'initilaize delay routine

REDIM pal(255) AS hues                 'array for palette
DEF SEG = VARSEG(pal(0))               'point to it
BLOAD "default.pal", 0                 'load it
OUT &H3C8, 0                           'inform VGA
FOR c = 0 TO 255                       'entire palette
 OUT &H3C9, pal(c).red                 'send red component
 OUT &H3C9, pal(c).grn                 'send green component
 OUT &H3C9, pal(c).blu                 'send blue component
NEXT                                   'next attribute

DIM font(127, 4, 6)                   'DIM array for fonts
DEF SEG = VARSEG(font(0, 0, 0))       'Point to it
BLOAD "qbinvade.fnt", 0               'Load 'em in

' Unremark image file to load. **********   Choose graphics. *************
'filename$ = "atari.spr"
filename$ = "qbinvade.spr"

CLS
Filesize& = 12877                     'File size
bytes = (Filesize& - 7) \ 2 - 1       'BSAVE & BLOAD use 7 bytes
DIM sprites(bytes)                    'dim the sprite array
DEF SEG = VARSEG(sprites(0))          'point to it
BLOAD filename$, 0                    'load the sprite file
spritewidth = sprites(0) \ 8          'get image width
spriteheight = sprites(1)             'get image height
elmPerSpr = ((spritewidth * spriteheight) \ 2) + 3 ' elements in one image


RANDOMIZE TIMER           'seed randomizer
UseFX = true              'set to false for PC speaker
Hard = false              'set to true for harder gameplay
TitleScreen               'start intro
InitGameStart             'init game varaibles/screen


DO                                          'level loop

 level = level + 1                          'increment level
 Initlevel                                  'display graphics
 GetReady                                   'tell user game is ready

 DO                                         'game loop
	 event = returnevent                      'get events
	 IF event = Esc THEN EndToDos             'user wants out
	 DoAlienBombs
	 DoAliens
	 IF TimeIsUp(3, 15) THEN cship.health = true 'time appearance of command ship
	 DocommandShip
	 DoCollisions
	 DoGunner
	 DoGunShot
 LOOP UNTIL AliensInPLay = 0

LOOP



'data to reconstruct qbinvader.scr in the event it is erased
DATA  1,4/11/97  ,Timothy Truman,       2000
DATA  2,4/11/97  ,John Denesha,         2000
DATA  3,4/11/97  ,David Pastore,        2000
DATA  4,4/11/97  ,John Matias  ,        2000
DATA  5,4/11/97  ,Mike Eberts,          1500
DATA  6,4/11/97  ,Bonnie Soffan,        1500
DATA  7,4/11/97  ,Patty Effilo,         1500
DATA  8,4/11/97  ,Kelsi Donahue,        1450
DATA  9,4/11/97  ,Sabrina McIntosh,     1450
DATA 10 ,4/11/97 ,Colleen Wise,         1450
DATA 11 ,4/11/97 ,Michelle Poules,      1300
DATA 12 ,4/11/97 ,Dominic Amato,        1300
DATA 13 ,4/11/97 ,Bobby Barkett,        1300
DATA 14 ,4/11/97 ,Tracy Truman ,        1200
DATA 15 ,4/11/97 ,Chris Hitas  ,        1200


' Visit this FTP for my latest programs and utilities :
'  ftp.aol.members/TimTruman

SUB clearbuffer             'clear keyboard buffer
DEF SEG = &H40              'point to low memory
POKE &H1A, PEEK(&H1C)       'point head to tail
END SUB

SUB DoAlienBombs

FOR ab = 1 TO Numberofbombs                             'do alien bombs
IF abomb(ab).health = false THEN                        'new one set up
IF TimeIsUp(2, AbombInterval!) THEN                     'time has passed
 FOR a = 1 TO numberofaliens
 IF alien(a).health THEN                                'wide scan for gunner
 IF alien(a).x < gunner.x OR alien(a).x > gunner.x - gunner.w THEN
 AlienUnder = false                                       'assume alien under
	FOR m = 1 TO AliensPerCol                               'next row down
	lookunder = (a + (AliensPerRow * m))                    'calc down one
	IF lookunder <= numberofaliens THEN                     'Alien there ?
	IF alien(lookunder).health = 1 THEN AlienUnder = true   'This one can't fire
	END IF
	NEXT
 IF AlienUnder = false THEN
 maybe = RND * 12                                    'this one is possible
 IF maybe > 1 AND maybe < 6 THEN                     'use 'em
 abomb(ab).health = alien(a).health                  'set up Bomp
 abomb(ab).x = alien(a).x + alien(a).w / 2           'ditto
 abomb(ab).y = alien(a).y + alien(a).h               'ditto
 abomb(ab).lx = abomb(ab).x                          'ditto
 abomb(ab).ly = abomb(ab).y                          'ditto
 EXIT FOR                                            'Outa here
 END IF
								 'narrow scan
IF alien(a).x >= gunner.x AND alien(a).x < gunner.x + gunner.w THEN
IF maybe <> 0 THEN                                 'use 'em
abomb(ab).health = alien(a).health                 'set up Bomp
abomb(ab).x = alien(a).x + alien(a).w / 2          'ditto
abomb(ab).y = alien(a).y + alien(a).h              'ditto
abomb(ab).lx = abomb(ab).x                         'ditto
abomb(ab).ly = abomb(ab).y                         'ditto
EXIT FOR                                           'outa here
END IF
END IF
END IF
END IF
END IF
NEXT                                                  'check next alien
END IF

ELSEIF abomb(ab).health = true THEN                        'animate it
 LINE (abomb(ab).lx, abomb(ab).ly)-(abomb(ab).lx, abomb(ab).ly + abomb(ab).h), 0
 abomb(ab).y = abomb(ab).y + Abombvel + Hard                        'adjust bomb y
 IF abomb(ab).y > Maxy THEN                                'it's off screen
 abomb(ab).health = 0                                      'Kill it
 ELSE                                                  'still visible
 LINE (abomb(ab).x, abomb(ab).y)-(abomb(ab).x, abomb(ab).y + abomb(ab).h), 138
 abomb(ab).lx = abomb(ab).x: abomb(ab).ly = abomb(ab).y    'for erase
 END IF
END IF

NEXT



END SUB

SUB DoAliens

STATIC dir, ctr1



IF TimeIsUp(1, TimeToStep!) THEN                   'Move aliens ?
	
	FOR a = 1 TO numberofaliens                      'look for live aliens
	IF alien(a).health THEN                          'got one
	CountEm = CountEm + 1                            'count em in
	IF dir = 1 THEN                                  'going left
	alien(a).x = alien(a).x - alienvelx              'adjust x position
	IF alien(a).x <= alienvelx THEN dflag = true     'drop em ?
	IF dflag AND CountEm = AliensInPLay THEN         'wait for every x adjust
	FOR b = 1 TO numberofaliens                      'drop em all at once
	IF alien(b).health THEN alien(b).y = alien(b).y + AlienVely
	NEXT                                             'next one
	dflag = false: dir = 0                         'did drop; change direction
	END IF
	ELSEIF dir = 0 THEN                              'going right
	alien(a).x = alien(a).x + alienvelx              'adjust x position
	IF alien(a).x > Maxx - alien(a).w - alienvelx THEN dflag = true ' drop ?
	IF dflag AND CountEm = AliensInPLay THEN         'wait for every x adjust
	FOR b = 1 TO numberofaliens                      'drop em all at once
	IF alien(b).health THEN alien(b).y = alien(b).y + AlienVely
	NEXT                                             'next
	dflag = false: dir = 1                          'did drop; change direction
	END IF
	END IF
	END IF
	NEXT
	CountEm = 0                                     'reset
	movealiens = true                               'update screen
END IF

DO: LOOP UNTIL (INP(&H3DA) AND 8)                  'wait for VGA retrace
															 
 IF movealiens = true THEN
	FOR a = numberofaliens TO 1 STEP -1                        'start at bot
	IF alien(a).health AND (alien(a).hit = false) THEN          'got a live one
	PUT (alien(a).lx, alien(a).ly), sprites(elmPerSpr * 20), PSET   'erase last
	alien(a).tile = (alien(a).tile + elmPerSpr) MOD NewAlienFrame   'calc ani frame
	alien(a).tile = alien(a).tile + alien(a).sseg              'calc alien
	PUT (alien(a).x, alien(a).y), sprites(alien(a).tile), PSET 'Put it
	alien(a).lx = alien(a).x: alien(a).ly = alien(a).y         'for erase
	alien(a).ltile = alien(a).tile                             'ditto
	END IF
 NEXT

 IF UseFX = 1 THEN
	ctr1 = (ctr1 + 1) MOD 2
	IF ctr1 THEN playsfx (sfx$(2)) ELSE playsfx (sfx$(3))
 ELSE
	soundfx (1)
 END IF
 movealiens = false                                         'done

END IF

END SUB

SUB DoCollisions

'--* do collisions
'--* check for collisions between aliens and gunshots using a bounding box

FOR b = 1 TO numberofaliens
 IF alien(b).health = 1 AND gunshot.health = 1 THEN
	IF gunshot.y >= alien(b).y AND gunshot.y <= alien(b).y + alien(b).h THEN
	 IF gunshot.x >= alien(b).x AND gunshot.x <= alien(b).x + alien(b).w THEN
		 PUT (alien(b).lx, alien(b).ly), sprites(alien(b).ltile)'erase old
		 LINE (gunshot.lx, gunshot.ly)-(gunshot.lx, gunshot.ly + gunshot.h), 0
		 'soundfx (4)
		 IF UseFX = 1 THEN
			playsfx (sfx$(1))
		 ELSE
			soundfx (4)
		 END IF

		 alien(b).health = 0
		 gunshot.health = 0
		 AliensInPLay = AliensInPLay - 1                         'one less alien
		 row = ((b - 1) \ (AliensPerRow)) + 1
		 points = 5 * ABS(row - (AliensPerRow + 1))
		 DoScore (points)
		EXIT FOR
	 END IF
	END IF
 END IF
NEXT


'--* check for collisions between alien bombs and barriers

FOR ab = 1 TO Numberofbombs
 FOR b = 1 TO 2
 IF abomb(ab).health THEN
	IF abomb(ab).y > Barrier(b).y AND abomb(ab).y < Barrier(b).y + spriteheight THEN
	 IF abomb(ab).x >= Barrier(b).x AND abomb(ab).x <= Barrier(b).x + spritewidth THEN
		 abomb(ab).health = 0
		 LINE (abomb(ab).lx, abomb(ab).ly)-(abomb(ab).lx, abomb(ab).ly + abomb(ab).h), 0
	 END IF
	END IF
 END IF
NEXT
NEXT

'--* check for collisions between alien bombs and gunner

FOR ab = 1 TO Numberofbombs
 IF abomb(ab).health = 1 THEN
 IF abomb(ab).x > (gunner.x + 4) AND abomb(ab).x < (gunner.x + gunner.w - 4) THEN
	IF abomb(ab).y >= gunner.y AND abomb(ab).y <= gunner.y THEN
			abomb(ab).health = 0
			gunner.health = 0
			LINE (abomb(ab).lx, abomb(ab).ly)-(abomb(ab).lx, abomb(ab).ly + abomb(ab).h), 0
	 END IF
	END IF
 END IF
NEXT



'--* bombs against gunshots

	FOR ab = 1 TO Numberofbombs
	IF abomb(ab).health = 1 AND gunshot.health THEN
	IF abomb(ab).x = gunshot.x THEN
	IF abomb(ab).y >= gunshot.y AND abomb(ab).y <= gunshot.y + gunshot.h THEN
			abomb(ab).health = 0
			gunshot.health = 0
			LINE (abomb(ab).lx, abomb(ab).ly)-(abomb(ab).lx, abomb(ab).ly + abomb(ab).h), 0
			LINE (gunshot.x, gunshot.y)-(gunshot.x, gunshot.y + gunshot.h), 0, BF   'ditto
			IF UseFX = true THEN
				playsfx (sfx$(4))
			ELSE
			 soundfx (3)
			END IF
 END IF
 END IF
 END IF
 NEXT

'--* alienbombs against shields

 FOR s = 1 TO NumberofShields
 FOR ab = 1 TO Numberofbombs
 IF abomb(ab).x > shield(s).x AND abomb(ab).x < shield(s).x + shield(s).w THEN
 IF abomb(ab).y >= shield(s).y AND abomb(ab).y <= shield(s).y + shield(s).h THEN
 IF POINT(abomb(ab).x, abomb(ab).y + abomb(ab).h + 1) > 0 THEN
	 LINE (abomb(ab).x, abomb(ab).y)-(abomb(ab).x, abomb(ab).y + abomb(ab).h + 1), 0
	 PSET (abomb(ab).x + (RND * -2), abomb(ab).y + abomb(ab).h + 1), 0
	 PSET (abomb(ab).x + (RND * 2), abomb(ab).y + abomb(ab).h + 1), 0
	 abomb(ab).health = 0
 END IF
 END IF
 END IF
 NEXT
 NEXT


 '--* gunshots against shields

 FOR s = 1 TO NumberofShields
 IF gunshot.x > shield(s).x AND gunshot.x < shield(s).x + shield(s).w THEN
 IF gunshot.y >= shield(s).y AND gunshot.y <= shield(s).y + shield(s).h THEN
 IF POINT(gunshot.x, gunshot.y - 1) > 0 THEN
	 LINE (gunshot.x, gunshot.y - 1)-(gunshot.x, gunshot.y + gunshot.h), 0
	 gunshot.health = 0
 END IF
 END IF
 END IF
 NEXT

 '--* gunshots against command ship

 IF cship.health AND gunshot.health THEN
 IF gunshot.y < cship.y + spriteheight THEN
 IF gunshot.x > cship.x AND gunshot.x < cship.x + spritewidth THEN
	 
	 IF headisup THEN
		 gunnerlives = gunnerlives + 1
		 IF UseFX = true THEN
			 playsfx (sfx$(7))
		 ELSE
			 soundfx (7)
		 END IF
	 ELSE
		 IF UseFX = true THEN
			 playsfx (sfx$(6))
		 ELSE
			 soundfx (6)
		 END IF
	 END IF

	 cship.health = 0
	 gunshot.health = 0
	 LINE (gunshot.x, gunshot.y)-(gunshot.x, gunshot.y + gunshot.h), 0, BF   'ditto
	 DoScore (50)
 END IF
 END IF
 END IF


 FOR a = 1 TO numberofaliens
	 IF alien(a).y + alien(a).h >= gunner.y THEN
		 IF UseFX = true THEN
			 playsfx (sfx$(9))
		 ELSE
			 soundfx (5)
		 END IF
		 clearbuffer
		 DO: LOOP UNTIL returnevent
		 DoGameEnd
	 END IF
 NEXT

END SUB

SUB DocommandShip

STATIC initialize, startframe, xstart, dir, frame, framedir, counter



IF cship.health THEN

 IF NOT initialize THEN
	 startframe = (24 * elmPerSpr)                     'calc start frame
	 cship.x = 300                                     'set start coridinates
	 cship.y = 1                                       'ditto
	 FOR xerase = 1 TO 300 STEP 20                     'clear top of screen
		 PUT (xerase, 1), sprites(20 * elmPerSpr), PSET
	 NEXT
	' soundfx (8)                        'make command ship noise
 IF UseFX = true THEN
	 playsfx (sfx$(5))
 ELSE
	soundfx (8)
 END IF

	 initialize = NOT initialize                       'don't do this again
 END IF

 IF TimeIsUp(5, 3) THEN 'soundfx (8)                   'time sound effect
 IF UseFX = true THEN
	 playsfx (sfx$(5))
 ELSE
	soundfx (8)
 END IF
END IF
 PUT (cship.lx, cship.y), sprites(20 * elmPerSpr), PSET  'clear spot
 PUT (cship.x, cship.y), sprites(startframe + (frame * elmPerSpr)), PSET

 IF framedir = 0 THEN                                  'add to last frame
	 IF TimeIsUp(4, 1.1) THEN frame = (frame + 1) MOD 6  'time frames
	 IF frame = 5 THEN                          'extra life hitting this frame
		headisup = true                           'raise flag
		framedir = 1                              'reverse frame direction
	 END IF
 ELSE                                             'subtract from last frame
	 IF TimeIsUp(4, 1.1) THEN
		 frame = (frame - 1)   'time frames
		 headisup = false                             'drop flag
	 END IF
	 IF frame = 0 THEN framedir = 0                 'reverse frame direction
 END IF

 cship.lx = cship.x                               'save for erase

 counter = (counter + 1) MOD 3                    'slow down ship movement
 IF counter = 2 THEN cship.x = cship.x - 1        'move ship

 IF cship.x <= 1 THEN cship.health = false        'ship reached left limit

ELSEIF cship.health = false THEN                  'ship has gone off screen

	 IF initialize THEN
		PUT (cship.x, 1), sprites(20 * elmPerSpr), PSET   'remove ship
		bitbucket = TimeIsUp(3, 0)                        'reset timers
		bitbucket = TimeIsUp(4, 0)                        'ditto
		bitbucket = TimeIsUp(5, 0)                        'ditto
		initialize = NOT initialize                       'to re-initialize ship
		framedir = 0                                      'reset frame direction
		DoScore (0)                                       'redraw score and lives
	 END IF
END IF

END SUB

FUNCTION DoExplode (x, y)

STATIC frame

ExplodeFrame = elmPerSpr * 17     'point to Explosion frames

DoExplode = false

PUT (x, y), sprites(ExplodeFrame + (frame * elmPerSpr)), PSET ' dislplay it

IF TimeIsUp(3, .4) THEN                               'time each frame
 PUT (x, y), sprites(ExplodeFrame + ((frame + 1) * elmPerSpr)), PSET' dislplay it
 frame = (frame + 1) MOD 3                             'calc next frame
 IF frame = 0 THEN DoExplode = true                     'Did all frames
END IF






END FUNCTION

SUB DoGameEnd


Pfont "Game Over", 125, 90, 190
playsfx (sfx$(10))
DO: LOOP UNTIL returnevent

DoHighScores


'CHAIN "qbinvade.exe"

END

END SUB

SUB DoGunner

IF gunner.health THEN

	DEF SEG = &H0                                  'point to low memory
	kbyte1 = PEEK(&H417)                           'get keyboard byte status
	kbyte2 = PEEK(&H418)                           'ditto

	IF (kbyte1 AND &H4) THEN                       'left ctrl key
		gunner.x = gunner.x + gunnervel              'move gunner                                'check Ctrl key
	END IF

	IF (kbyte1 AND &H8) THEN                       'alt key
		gunner.x = gunner.x - gunnervel              'move gunner
	END IF
	
	IF gunner.x > gunnerMaxx THEN gunner.x = gunnerMaxx  'keep gunner in bounds
	IF gunner.x < GunnerMinx THEN gunner.x = GunnerMinx  'ditto

	IF gunner.x <> gunner.lx THEN                           'gunner moved ?
		PUT (gunner.lx, gunner.ly), sprites(gunner.ltile)     'erase old
		gunner.tile = ((gunner.tile + elmPerSpr) MOD NewAlienFrame) + gunner.sseg
		PUT (gunner.x, gunner.y), sprites(gunner.tile), PSET  'draw new
		gunner.lx = gunner.x: gunner.ly = gunner.y            'for erase
		gunner.ltile = gunner.tile                            'ditto
	END IF

ELSE                                                     'gunner got hit

																			 
			IF UseFX = true THEN                            'make hit noise
				playsfx (sfx$(8))
			ELSE
			 soundfx (2)
			END IF

	DO
	 clearbuffer                                           'clear key buffer
	 IF DoExplode(gunner.x, gunner.y) THEN                 'show all frames ?
	 DO: clearbuffer: LOOP UNTIL TimeIsUp(3, .7) 'wait a bit so user can get ready
		 gunnerlives = gunnerlives - 1                       'less one gun
		 DoScore (0)                                         'redraw gun count
		 IF gunnerlives = 0 THEN DoGameEnd                  'any more guns ?
			FOR ab = 1 TO Numberofbombs               'yes, then reset alien bombs
			 abomb(ab).health = 0          'kill bomb and remove it from screen
			 LINE (abomb(ab).x, abomb(ab).y)-(abomb(ab).x, abomb(ab).y + abomb(ab).h), 0
			NEXT                                      'next alien bomb
			gunner.health = 1                         'reset gunner health
			PUT (gunner.x, gunner.y), sprites(gunner.tile), PSET   'put on screen
		 END IF
	LOOP UNTIL gunner.health = 1                 ' all done

END IF


END SUB

SUB DoGunShot

STATIC colour

IF gunshot.health = false THEN                        'Do gun shot
	IF event = space THEN                               'fire shot ?
	gunshot.x = gunner.x + (gunner.w / 2)               'calc pos
	gunshot.y = gunner.y - 1
	gunshot.health = 1                                  'give it life
	gunshot.lx = gunner.x                               'for erase
	gunshot.ly = gunner.y                               'ditto
	'IF usefx THEN playsfx (sfx$(0))
	END IF
ELSEIF gunshot.health = true THEN                     'animate it
	PSET (gunshot.lx, gunshot.ly), 0                    'erase last
	LINE -(gunshot.lx, gunshot.ly + gunshot.h), 0, BF   'ditto
	gunshot.y = gunshot.y - GunShotVel                  'move shot

	IF cship.health THEN
		IF gunshot.y < 1 THEN gunshot.health = 0         'it's off screen
	ELSE
		IF gunshot.y < spriteheight + 1 THEN gunshot.health = 0
	END IF
	IF gunshot.health THEN
	colour = ((colour + 1) MOD 16) + 48
	PSET (gunshot.x, gunshot.y), 0                      'draw new
	LINE -(gunshot.x, gunshot.y + gunshot.h), colour    'ditto
	gunshot.lx = gunshot.x: gunshot.ly = gunshot.y      'for erase
	END IF
END IF



END SUB

SUB DoHighScores

fc = 199

DIM score(1 TO 16) AS highscores

filespec$ = "qbvaders.scr"

OPEN filespec$ FOR RANDOM AS #1 LEN = 46            'open high score file
FOR n = 1 TO 15                                     'first to last
	GET #1, n, score(n)                               'load it in
NEXT n                                              'next entry
CLOSE #1                                            'close the file

IF VAL(score(1).score) = 0 THEN                     'did file exist
	 OPEN filespec$ FOR RANDOM AS #1 LEN = 46         'create file
	 FOR n = 1 TO 15                                  'first to last
		 READ a$, b$, c$, d$                           'read in data
			score(n).rank = a$                            'store it
			score(n).dat = b$                             'ditto
			score(n).nam = c$                             'ditto
			score(n).score = d$                           'ditto
		 PUT #1, n, score(n)                            'write it
		NEXT n                                          'next entry
	CLOSE #1                                          'close file
END IF


 Temp$ = LTRIM$(STR$(gamescore&))                    'convert to clean string
 addpad = 6 - LEN(Temp$)                             'calc padding
 gamescor$ = Temp$ + STRING$(addpad, 32)             'add it

 FOR rank = 1 TO 15                                  'find players rank
								
	 IF gamescore& > VAL(score(rank).score) THEN       'make the list ?
		 madelist = true                                 'setflag

		 FOR bump = 14 TO rank STEP -1                   'sort it
	score(bump + 1).dat = score(bump).dat        'bump ahead
	score(bump + 1).nam = score(bump).nam        'ditto
	score(bump + 1).score = score(bump).score    'ditto
		 NEXT                                            'bump next
		 month$ = MID$(DATE$, 1, 2)                      'get month
		 day$ = MID$(DATE$, 4, 2)                        'get day
		 year$ = MID$(DATE$, 9, 2)                       'get year
		 format$ = month$ + "/" + day$ + "/" + year$     'format the date
		 score(rank).dat = format$                       'store it
		 score(rank).nam = SPACE$(14)                    'blank name
		 score(rank).score = gamescor$                   'store gamescore
		 ShowHighScores score(), 1                       'print the list
		 y = (rank * 10) + 26                            'calc y
		 score(rank).nam = InputText$(93 + 8, y, 199)       'enter name
		 OPEN filespec$ FOR RANDOM AS #1 LEN = 46     'open file to save
		 FOR n = 1 TO 15                              'first to last
			 PUT #1, n, score(n)                        'write entry
		 NEXT                                         'next entry
		 CLOSE #1                                     'close file
		 EXIT FOR                                     'all done
	 END IF
	NEXT

	IF madelist = false THEN ShowHighScores score(), 0




END SUB

SUB Dolevel

 
 SELECT CASE level

 CASE 1 TO 5
	AlienStartY = (level * 7) + 20
	alienvelx = 1
	TimeToStep! = .5

 CASE 6 TO 11
	AlienStartY = 18
	alienvelx = (level - 6) + 1
	TimeToStep! = .5

 CASE 12
	AlienStartY = 21
	alienvelx = alienvelx - 2

 CASE 13 TO 17
	AlienStartY = ((level - 14) * 7) + 20
	alienvelx = ((level - 14) + 1)
	TimeToStep! = .5

 CASE 18 TO 24
	AlienStartY = ((level - 18) * 7) + 20
	alienvelx = ((level - 18) + 2)
	TimeToStep! = .5

 CASE 25
	AlienStartY = ((level - 25) * 7) + 20
	alienvelx = 7

 CASE 26
	AlienStartY = ((level - 26) * 7) + 20
	alienvelx = 1
	TimeToStep! = .5
	level = 1

 END SELECT


END SUB

SUB DoScore (points)

STATIC lgunnerlives, lTimeToStep!

SELECT CASE AliensInPLay
CASE 1: TimeToStep! = .01: IF level = 25 THEN TimeToStep! = 0!
CASE 4: TimeToStep! = .09
CASE 5 TO 8: TimeToStep! = .15
CASE 9 TO 22: TimeToStep! = .25
CASE 23 TO 42: TimeToStep! = .5
END SELECT

IF lTimeToStep! <> TimeToStep! THEN
SELECT CASE AliensInPLay
CASE 1: alienvelx = alienvelx + 4
CASE 4: alienvelx = alienvelx + 1
CASE 9 TO 22: alienvelx = alienvelx + 1
END SELECT
END IF
lTimeToStep! = TimeToStep!

startframe = (30 * elmPerSpr)            'point to start of score frames
xscore = 1: yscore = 1
xstep = 20
gamescore& = gamescore& + points


IF cship.health = false THEN

onedigit = (gamescore& \ 1) MOD 10
tendigit = (gamescore& \ 10) MOD 10
hdigit = (gamescore& \ 100) MOD 10
tdigit = (gamescore& \ 1000) MOD 10
ttdigit = (gamescore& \ 10000) MOD 10

PUT (xscore, yscore), sprites(startframe + (ttdigit * elmPerSpr)), PSET
PUT (xscore + xstep, yscore), sprites(startframe + (tdigit * elmPerSpr)), PSET
PUT (xscore + (xstep * 2), yscore), sprites(startframe + (hdigit * elmPerSpr)), PSET
PUT (xscore + (xstep * 3), yscore), sprites(startframe + (tendigit * elmPerSpr)), PSET
PUT (xscore + (xstep * 4), yscore), sprites(startframe + (onedigit * elmPerSpr)), PSET


'gunnerlives = 10
FOR lives = 1 TO 10
 IF lives >= gunnerlives THEN
	PUT (280 - gx, yscore), sprites(elmPerSpr * 20), PSET
 ELSE
	PUT (280 - gx, yscore), sprites(gunner.tile), PSET
 END IF
 gx = gx + xstep
NEXT



END IF


END SUB

SUB EndToDos

DIM buffer(1000)

x1 = 130
x2 = 190
y1 = 90
y2 = 102

GET (x1, y1)-(x2, y2), buffer

LINE (x1, y1)-(x2, y2), 120, BF
LINE (x1, y1)-(x2, y2), 123, B
p5x7font x1 + 3, y1 + 3, "Quit? (y/n)", 1
DO
 event = returnevent
 
 SELECT CASE event
 CASE 89, 121
	 EXIT DO
 CASE 78, 110
	 PUT (x1, y1), buffer, PSET
	 EXIT SUB
 END SELECT
LOOP
										 'zero out adlib regs incase of hanging sounds
FOR sfx = 11 TO 19   'sounds effects 11 through 19 zero out all channels
	IF UesFX THEN playsfx (sfx$(sfx))
NEXT


WIDTH 80
SCREEN 0, 0, 0

END

END SUB

SUB FadePal (fc, lc, level, mode)

STATIC savepal() AS hues

IF mode THEN                      'fade in
	
	FOR value = 0 TO level               'bring 'em all up
		 OUT &H3C8, fc                  'tell video card to get ready
		FOR attrib = fc TO lc           'first color to last color

		IF pal(attrib).red < savepal(attrib).red THEN pal(attrib).red = pal(attrib).red + 1
		IF pal(attrib).grn < savepal(attrib).grn THEN pal(attrib).grn = pal(attrib).grn + 1
		IF pal(attrib).blu < savepal(attrib).blu THEN pal(attrib).blu = pal(attrib).blu + 1

		OUT &H3C9, pal(attrib).red   'send red component
		OUT &H3C9, pal(attrib).grn   'send green component
		OUT &H3C9, pal(attrib).blu   'send blue component
	
	 NEXT attrib
		 stay (10)
		 clearbuffer
	NEXT value

ELSE                             'fade out

	REDIM savepal(255)  AS hues

	FOR attrib = 0 TO 255
		 savepal(attrib).red = pal(attrib).red        'save pal to restore
		 savepal(attrib).grn = pal(attrib).grn        'ditto
		 savepal(attrib).blu = pal(attrib).blu        'ditto
	NEXT

	FOR value = 0 TO level
		OUT &H3C8, fc                        'tell video card to get ready

		FOR attrib = fc TO lc                'first color to last color
	
	
		 IF pal(attrib).red > 0 THEN pal(attrib).red = pal(attrib).red - 1
		 IF pal(attrib).grn > 0 THEN pal(attrib).grn = pal(attrib).grn - 1
		 IF pal(attrib).blu > 0 THEN pal(attrib).blu = pal(attrib).blu - 1

		 OUT &H3C9, pal(attrib).red  'send red component
		 OUT &H3C9, pal(attrib).grn  'send green component
		 OUT &H3C9, pal(attrib).blu  'send blue component

	 NEXT attrib

		stay (10)
		clearbuffer
 NEXT value

END IF

END SUB

SUB GetReady


DO
clearbuffer
LOOP UNTIL TimeIsUp(7, 1)  'wait a bit so user can get ready
clearbuffer

x1 = 130
y1 = 80

DO

 IF TimeIsUp(5, .4) THEN toggle = NOT toggle
 IF toggle THEN
	 p5x7font x1, y1, "Get Ready", 0
	 p5x7font x1, y1 + 8, "Wave " + STR$(level), 0
	 

 ELSE
	 p5x7font x1, y1, "Get Ready", 190
	 p5x7font x1, y1 + 8, "Wave " + STR$(level), 190
 END IF

 IF TimeIsUp(6, 4) THEN EXIT DO

LOOP UNTIL returnevent = space

p5x7font x1, y1, "Get Ready", 0
p5x7font x1, y1 + 8, "Wave " + STR$(level), 0

END SUB

SUB InitGameStart

'--* set up aliens

AliensPerRow = 6                   'eight max
IF Hard THEN AliensPerRow = 8
AliensPerCol = 6                    'six max
numberofaliens = (AliensPerRow * AliensPerCol)
AliensInPLay = numberofaliens
DIM alien(AliensInPLay) AS sprite                   'need storage
AlienStepX = 35                                     'spaceing
AlienStepY = 20                                     'ditto
AlienStartX = 35                                    'position
AlienStartY = 20
alienvelx = 2                                       'velocity
AlienVely = AlienStepY / 2                          'ditto
Cornerx = AlienStartX                               'for adding steps
Cornery = AlienStartY                               'ditto
AlienEndX = (AlienStepX * AliensPerRow) + AlienStartX 'calc end column
NewAlienFrame = (elmPerSpr * 2)                     'to skip animation frames


'--*set up gunner 1
gunnerlives = 3
gunnerMaxx = Maxx - (20 * 4)             'set limits of movement
GunnerMinx = (20 * 3)                    'ditto
GunnerY = Maxy - 14                      'placement
gunnervel = 1                            'velocity
gunner.x = gunnerMaxx - 18               'start position
gunner.y = Maxy - 14                     'ditto
gunner.lx = gunner.x - 1                 'force update
gunner.ly = gunner.y                     'ditto
gunner.w = spritewidth                   'gunner width
gunner.h = spriteheight                  'gunner height
gunner.health = 1                        'set health
gunner.sseg = elmPerSpr * 14             'pointer to image
gunner.tile = elmPerSpr * 14             'offset to frame
gunner.ltile = elmPerSpr * 14            'for erase

'--* set up gunshots
gunshot.w = 1
gunshot.h = 4
gunshot.health = 0
GunShotVel = 2

'--* set up alien bombs
Numberofbombs = 3
DIM abomb(Numberofbombs) AS sprite
FOR ab = 1 TO Numberofbombs
	abomb(ab).w = 1
	abomb(ab).h = 4
	abomb(ab).health = 0
NEXT
Abombvel = 1
AbombInterval! = .2

'--* set up shields

NumberofShields = 3
DIM shield(NumberofShields) AS sprite
shield(1).x = 80
shield(1).y = 170
shield(2).x = 150
shield(2).y = 170
shield(3).x = 220
shield(3).y = 170
FOR s = 1 TO NumberofShields
	shield(s).w = 20
	shield(s).h = 14
NEXT

'--* set up barriers

DIM Barrier(2) AS sprite
Barrier(1).x = GunnerMinx - spritewidth
Barrier(1).y = GunnerY
Barrier(1).tile = elmPerSpr * 12
Barrier(2).x = gunnerMaxx + spritewidth
Barrier(2).y = GunnerY
Barrier(2).tile = elmPerSpr * 13


PUT (Barrier(1).x, Barrier(1).y), sprites(Barrier(1).tile), PSET
PUT (Barrier(2).x, Barrier(2).y), sprites(Barrier(2).tile), PSET

DoScore (0)                          'display score


END SUB

SUB Initlevel

	Dolevel
	'--* reset alien bombs
	FOR ab = 1 TO Numberofbombs                            'Do alien bombs
	 abomb(ab).health = 0                                  'reset em
	 LINE (abomb(ab).lx, abomb(ab).ly)-(abomb(ab).lx, abomb(ab).ly + abomb(ab).h), 0
	 LINE (abomb(ab).x, abomb(ab).y)-(abomb(ab).x, abomb(ab).y + abomb(ab).h), 0
	NEXT
	'--* reset barriers
	PUT (shield(1).x, shield(1).y), sprites(elmPerSpr * 21), PSET
	PUT (shield(2).x, shield(2).y), sprites(elmPerSpr * 22), PSET
	PUT (shield(3).x, shield(3).y), sprites(elmPerSpr * 23), PSET
	'--* reset gunner1
	PUT (gunner.x, gunner.y), sprites(20 * elmPerSpr), PSET
	gunner.x = gunnerMaxx - 18
	gunner.lx = gunner.x
	PUT (gunner.x, gunner.y), sprites(gunner.tile), PSET
	'--* reset aliens
	AliensInPLay = numberofaliens
	movealiens = true                                 'so aliens appear
	Cornerx = AlienStartX                             'for adding steps
	Cornery = AlienStartY                             'ditto
	AlienEndX = (AlienStepX * AliensPerRow) + AlienStartX    'calc end column
	NewAlienFrame = (elmPerSpr * 2)                          'to skip animation frames
	NextChar = 0
	NextFrame = 0
	FOR a = 1 TO numberofaliens                                   'initilaize aliens
	 alien(a).x = Cornerx                             'position
	 alien(a).y = Cornery                             'ditto
	 alien(a).lx = Cornerx                            'ditto
	 alien(a).ly = Cornery                            'ditto
	 alien(a).w = spritewidth                         'size
	 alien(a).h = spriteheight                        'ditto
	 alien(a).dir = 1                                 'walk towards left
	 alien(a).health = 1                              'make alive
	 alien(a).sseg = NextChar                         'pointer to images
	 alien(a).tile = NextChar                         'offset to frame
	 alien(a).ltile = NextChar                        'for erase
	 NextFrame = (NextFrame + elmPerSpr) MOD NewAlienFrame 'calc next frame
	 Cornerx = Cornerx + AlienStepX                   'next column
	 IF Cornerx = AlienEndX THEN                      'last in row
			Cornerx = AlienStartX                         'reset column
			Cornery = Cornery + AlienStepY                'next row
			NextChar = NextChar + (NewAlienFrame)         'next char
	 END IF
	NEXT


END SUB

FUNCTION InputText$ (xcur, ycur, length)

PalRegInfo 255, red, 0, 0, 1                 'define cursor color
DIM Edit$(length)                            'DIM array to edit
ele = 1                                      'set first element
DIM background(35, length + 2)               'DIM array to save background
GET (xcur, ycur)-(xcur + 6, ycur + 8), background(35, 1) 'GET background
p5x7font xcur, ycur, "_", 255                'init curser


clearbuffer                                  'clear the keybuffer

DO

	DO                                                  'event loop
		event = returnevent                               'anything happen ?
		IF dir = 0 THEN                                   'strobe cursor
		red = red + 1: IF red > 62 THEN dir = 1           'ditto
		ELSE                                              'ditto
		red = red - 1: IF red < 10 THEN dir = 0           'ditto
		END IF                                            'ditto
		PALETTE 255, (65536 * blu) + (256 * grn) + red    'ditto
	LOOP UNTIL event                                    'back for event

	SELECT CASE event

	 CASE Esc: EXIT DO                                  'do Esc
	 CASE Enter: EXIT DO                                'do enter

	 CASE 1 TO 7, 9 TO 126                       'do regular keys
		 event$ = CHR$(event)                     'convert for printing
		 IF ele < length THEN                     'stay in bounds
			PUT (xcur, ycur), background(35, ele), PSET
			p5x7font xcur, ycur, CHR$(event), 191 'print font
			Edit$(ele) = event$                     'in case of backspace
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
			ele = ele + 1                           'advance to next element
			GET (xcur, ycur)-(xcur + 6, ycur + 8), background(35, ele)
			p5x7font xcur, ycur, "_", 255          'print cursor
		 END IF

	 CASE Backspace, Left                       'do backspace
						 
		 IF ele > 1 THEN
			 PUT (xcur, ycur), background(35, ele), PSET   'restore background
			 ele = ele - 1                          'move to previous element
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
			p5x7font xcur, ycur, "_", 255           'print cursor
			Edit$(ele) = CHR$(space)                'clear element
		 END IF
	 END SELECT

LOOP

FOR n = 1 TO length - 1                         'put elements into a string
 IF Edit$(n) = "" THEN Edit$(n) = CHR$(space)   'replace nulls
 Temp$ = Temp$ + Edit$(n)                       'create string
NEXT n

InputText$ = Temp$                             'return the string

END FUNCTION

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
		 IF font(aski, xbit, ybit) = 1 THEN           'set bits only
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

SUB PalRegInfo (reg, red, grn, blu, mode)
SELECT CASE mode
CASE 0            'get individual palette register
OUT &H3C7, reg    'tell video card which register
red = INP(&H3C9)  'get red component
grn = INP(&H3C9)  'get green component
blu = INP(&H3C9)  'get blue component
CASE 1            'set individual palette register
OUT &H3C8, reg    'tell video card which register to change
OUT &H3C9, red    'send red component
OUT &H3C9, grn    'send green component
OUT &H3C9, blu    'send blue component
END SELECT
END SUB

SUB Pfont (text$, x, y, colour)


DEF SEG = &HFFA6
FOR piece = 1 TO LEN(text$)
	address = (8 * ASC(MID$(text$, piece))) + 14
	FOR hl = 0 TO 7
		mask = PEEK(address + hl) * 128
		LINE (x + kernx, y + hl)-(x + 8 + kernx, y + hl), colour, , mask
	NEXT
 kernx = kernx + 8
NEXT
'x = 0
DEF SEG

END SUB

SUB playsfx (sfx$)

'plays an sfx$ that is sent to it.
'sub expects the c$() array (channel info) to be global

chan% = VAL(MID$(sfx$, 61, 4))
FOR in = 1 TO 60 STEP 4
	reg$ = MID$(c$(chan%), in, 4): reg% = VAL(reg$)
	dat$ = MID$(sfx$, in, 4): dat% = VAL(dat$)
	OUT &H388, reg%: FOR d% = 1 TO 6: b% = INP(&H388): NEXT
	OUT &H389, dat%: FOR d% = 1 TO 35: b% = INP(&H388): NEXT
NEXT

END SUB

FUNCTION returnevent


kee$ = INKEY$
IF kee$ <> "" THEN
	IF LEN(kee$) = 1 THEN
	 keycode = ASC(kee$)
	ELSE
	 keycode = -ASC(RIGHT$(kee$, 1))
	END IF
END IF


returnevent = keycode

END FUNCTION

SUB ShowHighScores (score() AS highscores, mode)

fc = 199
CLS

FadePal 16, 255, 23, 0


alien = INT(RND * 12)

FOR x = 1 TO 300 STEP 20
	FOR y = 1 TO 186 STEP 14
	 PUT (x, y), sprites(elmPerSpr * alien), PSET
	NEXT
NEXT



p5x7font 96, 17, "Invader Hall of Fame", 19
p5x7font 96, 16, "Invader Hall of Fame", 7

placey = 35
shadow = 1

	FOR a = 1 TO 15
		p5x7font 20 + 8 - shadow, placey + shadow, score(a).rank, 19
		p5x7font 38 + 8 - shadow, placey + shadow, score(a).dat, 19
		p5x7font 93 + 8 - shadow, placey + shadow, score(a).nam, 19
		p5x7font 240 + 8 - shadow, placey + shadow, score(a).score, 19
		p5x7font 20 + 8, placey, score(a).rank, 191
		p5x7font 38 + 8, placey, score(a).dat, 29
		p5x7font 93 + 8, placey, score(a).nam, 191
		p5x7font 240 + 8, placey, score(a).score, 29
		placey = placey + 10                       ' drop y to a new line
NEXT a

IF mode THEN EXIT SUB


DO

 IF TimeIsUp(6, 120) THEN EXIT DO
 event = returnevent
LOOP UNTIL event



END SUB

SUB soundfx (fx)

SELECT CASE fx

CASE 1                                              'step sound

	SOUND 60, .1
 
CASE 2                                              'gunner hit

	FOR freq! = 160 TO 60 STEP -10
	 duration! = freq! / 100
	 SOUND freq!, duration!
	 NEXT

CASE 3                                         'alien bomb hiting gunshot
								 
	 SOUND 1160, .1

CASE 4                                         ' gunshot hit alien
	
	 PLAY "MB" + "O0" + "L64" + "A" + "B" + "C" + "B" + "C" + "A"

CASE 5

	 FOR freq! = 200 TO 60 STEP -8
		stay (10)
		SOUND freq!, .1
	 NEXT

CASE 6                                        'hit command ship

 PLAY "MB" + "O1" + "L20" + "G" + "G" + "G "

CASE 7
							 'hit command ship with head up
 PLAY "MB" + "O2" + "L30" + "C" + "D" + "E " + "F"

CASE 8

 play$ = "C" + "D" + "E" + "F" + "G" + "F" + "E" + "D"
 PLAY "MB" + "O0" + "L40" + play$

END SELECT



END SUB

DEFSNG A-Z
SUB stay (Millisecs!)

STATIC Syspeed&, Time2

IF Syspeed& THEN                ' First time here -get relative system speed

	IF Millisecs THEN             ' Start Delay loop
	 
		 factor& = (Syspeed& * Millisecs) \ 55          'num of loops needed
		
		 IF factor& < 1 THEN EXIT SUB
		 DO                                             ' delay loop
			 factor& = factor& - 1                        ' Sub the num of loops
		 LOOP UNTIL Time2 = PEEK(&H6C) OR factor& = 0   ' make loop same as below
	 
	END IF
ELSE                               ' Relative system speed processed here

	DEF SEG = &H40
	Time1 = PEEK(&H6C)

	DO
		Time2 = PEEK(&H6C)             ' get another
	LOOP UNTIL Time1 <> Time2        ' loop until new clock tick


	DO                               ' start here at new clock tick
		Syspeed& = Syspeed& - 1        ' Count the number of times looped
	LOOP UNTIL Time2 <> PEEK(&H6C) OR Syspeed& = 0  'make same as loop above
	 Time2 = 1255
	 Syspeed& = ABS(Syspeed&)        'cant use this neg -reverse it



END IF



END SUB

DEFINT A-Z
FUNCTION TimeIsUp (n, tsecs!)


' Poll this function to check for passage of time. When the amount of
' time in tsecs has passed timeisup() returns TRUE, otherwise the function
' returns false.
' Initialize this routine with tsecs! = -1 and n = to the number
' of timers to set up.

STATIC getclock(), oldtsecs!(), Time1!()

IF tsecs! = -1 THEN                    ' initialize timers
	DIM getclock(n)
	DIM oldtsecs!(n)
	DIM Time1!(n)
END IF


IF tsecs! <> oldtsecs!(n) THEN getclock(n) = 0

IF getclock(n) = 0 THEN
	 Time1!(n) = TIMER
	 getclock(n) = 1
	 oldtsecs!(n) = tsecs!
ELSE
	 IF ABS(TIMER - Time1!(n)) >= tsecs! THEN
			TimeIsUp = 1
			getclock(n) = 0
	 ELSE
			TimeIsUp = 0
	 END IF
END IF



END FUNCTION

SUB TitleScreen


text$ = "QB Invaders"

FOR alien = 0 TO 7 STEP 2                'select alien to pull title
 IF INT(RND * 11) = 5 THEN EXIT FOR
NEXT


FOR x = 300 TO 95 STEP -1
	 counter = (counter + 1) MOD 6
	 IF counter = 2 THEN frame = (frame + 1) MOD 2
	 PUT (lx, 90), sprites(elmPerSpr * 20), PSET   'erase last
	 p5x7font lx + 20, 90, text$, 0
	 event = returnevent
	 IF event THEN EXIT FOR
	 PUT (x, 90), sprites((alien + frame) * elmPerSpr), PSET
	 p5x7font x + 20, 90, text$, 155
	 lx = x
	 DO: LOOP UNTIL INP(&H3DA) AND 8                          'wait for VGA retrace
NEXT


PUT (95, 90), sprites((alien + frame) * elmPerSpr), PSET


IF event = 0 THEN FadePal 140, 187, 60, 0
p5x7font 95 + 20, 90, text$ + " Ver 1.0", 155
p5x7font 78, 120, "Atari graphics by John Denesha", 155
p5x7font 69, 130, "Other graphics by Timothy Truman", 187
p5x7font 79, 140, "Program Author Timothy Truman", 187
p5x7font 59, 160, "Copyright (c) 1997 Nocturnal Creations", 170
IF event = 0 THEN FadePal 140, 187, 60, 1

IF event = 0 THEN FadePal 154, 154, 60, 0
p5x7font 65, 40, "Use right Ctrl and Alt keys to move", 154
p5x7font 100, 50, "Use Space bar to fire", 154
p5x7font 130, 60, "Esc to Quit", 154

IF event = 0 THEN FadePal 154, 154, 60, 1


DO
	DO: LOOP UNTIL INP(&H3DA) AND 8                          'wait for VGA retrace
	 IF TimeIsUp(3, 1) THEN cship.health = true
	 DocommandShip
	 event = returnevent
	 IF event = Esc THEN
		EndToDos
		event = 0
	 END IF
LOOP UNTIL event

cship.health = false
CLS

END SUB

