DEFINT A-Z
DECLARE SUB battle ()
DECLARE SUB Generic ()
DECLARE SUB Enemy ()
DECLARE SUB Warp ()
DECLARE SUB WORMHOLE ()
DECLARE SUB CODEZY ()
DECLARE SUB CODE1 ()
DECLARE SUB ENDer ()
DECLARE SUB Trendy ()
DECLARE SUB grafic ()
DECLARE SUB grafic1 ()
DECLARE SUB grafic2 ()
DECLARE SUB Grafic3 ()
DECLARE SUB warpg1 ()
DECLARE SUB warpg2 ()
TIMER ON
RANDOMIZE TIMER
SCREEN 8

PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
COLOR 4
PRINT "              SPACE COMMANDER";
COLOR 14
PRINT ; "----------------------------"
PRINT "                                               ------"
PRINT "                                           ------"
PRINT "                                       ------"
PRINT "                                   ------"
PRINT "                               ------"
PRINT "                             ---------------------------"
PRINT "                                         V2.1   "
SLEEP 1
COLOR 14
scale$ = "l10abcl5d10abl5cl10abcdcl5bl2f"
'PLAY scale$
COLOR 3
LINE (0, 3)-(600, 3)
LINE (0, 3)-(0, 20)
LINE (600, 3)-(600, 20)
LINE (0, 20)-(100, 20)
LINE (600, 20)-(500, 20)
LINE (100, 20)-(100, 175)
LINE (500, 20)-(500, 175)
LINE (100, 175)-(0, 175)
LINE (500, 175)-(600, 175)
LINE (0, 175)-(0, 195)
LINE (600, 175)-(600, 195)
LINE (0, 195)-(600, 195)
LINE (200, 20)-(400, 20)
LINE (200, 20)-(200, 175)
LINE (400, 20)-(400, 175)
LINE (400, 175)-(200, 175)
COLOR 1
'PAINT (20, 20)
'play scale$
COLOR 7
SLEEP 1
CLS
SCREEN 2
LOCATE 12, 30
PRINT "............THE VIPER'S ATTACK!"
'PLAY scale$
SLEEP 1

SCREEN 12
LOCATE 15, 30
COLOR 15
PRINT "RETURNING FROM HYPERSPACE..."
LOCATE 16, 30
PRINT "Loading Terminal............"
COLOR 4
'otay = 9000
'dre:
'a% = INT(RND * 14) + 1
'COLOR 15
'   x = INT(RND * 640) + 1
'   y = INT(RND * 200) + 1
'   PSET (x, y)
'
'   x = INT(RND * 640) + 1
'   y = INT(RND * 200) + 1
'
'   PRESET (x, y)
'
'   atter = atter + 1
'   otay = otay - 1
'   LOCATE 20, 32
'   COLOR 4
'   PRINT atter; "Time Passed"
'   LOCATE 21, 32
'   PRINT otay; "Time Left    "
'   IF atter > 9000 GOTO sre:
'GOTO dre:
sre:
SCREEN 0
COLOR 2, 1
CLS

INPUT "What is your true name Commander Z?"; gf$


SELECT CASE gf$
CASE "Brian"
   PRINT "Hello God of GOds,  This is your Flight Computer"
CASE "Eric"
   PRINT "Hello Roadbuster, This is your Flight Computer"
CASE "Kevin"
   PRINT "Hello Kevin, This is your Flight Computer"
CASE ELSE
   PRINT "Hello "; gf$; ", This is your Flight Computer"
END SELECT
INPUT "Do you need Instructions? (y/n)"; yn$

SELECT CASE yn$

CASE "n"
 
CASE "y"
   PRINT "You command a Exondro Class Cruiser. You must search the galaxy"
   PRINT "to find the Viper homeworld. But first you must:"
   PRINT "                       1. Find the Safety Key"
   PRINT "                       2. Find the Shield Key"
   PRINT "                       3. Find the Viper Homeworld"
   PRINT
   PRINT "Sound Easy? It isn't. You will encounter Enemy Fighters, and"
   PRINT "much more unexpected things. And if you're smart enough to "
   PRINT " have registered this you'll find alot more."
   PRINT "This version is:UNREGISTERED."
   PRINT "The full version gives you 100 sectors of gameplay, (Unreg. has"
   PRINT "only 30), Supernova's, Sound Effects, and much more."
   PRINT "And not to mention a better battle sequence. It costs only 10$"

CASE ELSE
   PRINT "You can't figure out y or n? earth is in Trouble!"
END SELECT
PRINT "Did I mention that Viper ships will attack on sight?"
PRINT "Whoops!"
PRINT "Oh well, it is just a game, "; gf$
PRINT "the sectors are 1, 2, 3, 4.....................30"
PRINT "It is that simple, get it?"
PRINT "Okay, Where do you want to go"
INPUT a
ky = INT(RND * 26) + 1
wrp = INT(RND * 26) + 1
ot = INT(RND * 26) + 1
IF ky = 5 THEN ky = 6
IF wrp = 5 THEN wrp = 7
IF wrp = 6 THEN wrp = 7
IF ot = ky THEN ot = 5
IF ot = wrp THEN ot = 5
IF ky = wrp THEN wrp = wrp + 1

1 IF a = ky GOTO 100
IF a = wrp GOTO 101
IF a < 5 GOTO 60
IF a = ot GOTO 70
IF a = 6 GOTO 80
IF a < 19 GOTO 90
IF a > 18 GOTO 60
ENDer
'sectors:
60 Generic 'empty
INPUT a
GOTO 1
70 CODEZY  'data
INPUT a
GOTO 1
80 Trendy  'nova
INPUT a
GOTO 1
90 Enemy   'enemy
INPUT a
GOTO 1
100 CODE1  'data
INPUT a
GOTO 1
101 Warp   'end
INPUT a
GOTO 1

SUB battle
SCREEN 0
TIMER ON
RANDOMIZE TIMER
vit = 1
hs = 45
inv = 0
hp = 45
loc1 = 1
loc2 = 1
loc3 = 10
loc4 = 58
CLS
xox:
COLOR 15
LOCATE 1, 1
PRINT "*         *              *                *             *  *        /\    "
PRINT "         *            *           *           *      *     *        ||    "
PRINT "  *              *                   *            *        *     <==  ==> "
PRINT "*         *              *                *             *  *        ||    "
PRINT "         *            *           *           *      *     *        \/    "
PRINT "  *              *                   *            *        *              "
PRINT "*         *              *                *             *  *              "
PRINT "         *            *           *           *      *     *  Space= BACH "
PRINT "  *              *                   *            *        *              "
PRINT "*         *              *                *             *  *      q= Quit "
PRINT "Y:"; loc1; " X:"; loc2; "   SHIELDS: "; hp; " His Shields: "; hs
IF hp < 1 GOTO x:
COLOR 4
IF dorky = 1 THEN GOTO dorky:
dorky = 0
dorky:
COLOR 15
IF loc1 < 1 THEN loc1 = 1
IF loc2 < 1 THEN loc2 = 1
IF loc2 > 58 THEN loc2 = 57
IF loc1 > 10 THEN loc1 = 10

zippy% = INT(RND * 4) + 1
IF zippy% = 1 THEN loc3 = loc3 + vit
IF zippy% = 2 THEN loc4 = loc4 + vit
IF zippy% = 3 THEN loc3 = loc3 - vit
IF zippy% = 4 THEN loc4 = loc4 - vit
IF easy = 1 GOTO dork:
IF loc2 > loc4 THEN loc4 = loc4 + 1
IF loc2 < loc4 THEN loc3 = loc3 - 1
IF loc3 > loc1 THEN loc3 = loc3 - 1
IF loc3 < loc1 THEN loc3 = loc3 + 1
IF loc4 < loc2 AND loc3 = loc1 THEN loc4 = loc4 + 1
IF loc4 > loc2 AND loc3 = loc1 AND loc4 - loc2 < 6 THEN loc3 = loc3 + 1

dork:
IF loc4 - loc2 < 2 AND loc1 = loc3 AND loc2 - loc4 < 10 THEN fireit% = 1
IF loc2 - loc4 < 10 AND loc1 = loc3 AND loc4 - loc2 < 2 THEN fireit% = 1

IF loc4 - 5 > loc2 THEN firiet% = 1
IF loc3 > loc1 THEN loc4 = loc4 + 1
IF loc3 < loc1 THEN loc4 = loc4 - 1
IF loc3 < 1 THEN loc3 = 1
IF loc4 < 1 THEN loc4 = 1
IF loc4 > 58 THEN loc4 = 57
IF loc3 > 10 THEN loc3 = 9
IF fireit% = 1 THEN loc4 = loc4 - 7
IF loc4 < 1 THEN loc4 = 1
LOCATE loc3, loc4, 0
x% = CSRLIN
COLOR 4
IF inv = 1 GOTO got:
IF fireit% = 1 THEN PRINT "-------";
IF fireit% = 1 THEN hp = hp - daddy
'IF fireit% = 1 THEN PLAY "l60 o3 b"
IF hp < 1 THEN GOTO x:
got:
COLOR 7
PRINT ; "/_/|";
COLOR 4
IF inv = 1 THEN GOTO got2:
IF fireit% = 1 THEN PRINT ; "-------"
IF fireit% = 1 THEN hp = hp - 5
IF hp < 1 THEN GOTO x:
IF fireit% = 1 THEN loc4 = loc4 + 7
got2:
fireit% = 0
COLOR 15
LOCATE loc1, loc2, 0
x% = CSRLIN
COLOR 3
PRINT "{>=";
COLOR 14
IF fire% = 1 THEN PRINT "--------------"
'IF fire% = 1 THEN PLAY "o4 l60 a"
IF loc1 = loc3 AND fire% = 1 AND loc2 - loc4 < 16 AND loc4 - loc2 < 18 THEN hs = hs - 5
IF hs < 1 GOTO xx:
IF betamv = 1 THEN loc4 = loc4 + 2
betamv = 0
fire% = 0

COLOR 15
102 in$ = INKEY$
SELECT CASE in$
CASE "i"
inv = 1
LOCATE 1, 1
PRINT "DISHONARABLE COMBAT BY PLAYER"
CASE CHR$(0) + "K"
loc2 = loc2 - 1
GOTO 103
CASE CHR$(0) + "M"
loc2 = loc2 + 1
GOTO 103
 CASE CHR$(0) + "P"
loc1 = loc1 + 1
GOTO 103
 CASE CHR$(0) + "H"
loc1 = loc1 - 1
GOTO 103
CASE " "
fire% = 1
GOTO 103
CASE "q"
ENDer
END SELECT
GOTO 102


103
moves = moves + 1


GOTO xox:
x: PRINT "You Have died........."

LINE INPUT "[PRESS RETURN]"; ASD$
ENDer

xx: PRINT "You have defeated the ship!"

LINE INPUT "[Press Enter]", ee$
GOTO frip:

CLS

GOTO xox:
frip:
END SUB

SUB CODE1
SCREEN 0
COLOR 15, 1
CLS

COLOR 15, 0
PRINT "    *    *   *      *     *    *        *"
PRINT "  *    *   *    *     *     *      *     "
PRINT "            THE SAFTEY KEY IS            "
PRINT "                  745                    "
PRINT "        (DON'T TELL COMMANDER Z)         "
PRINT "  *   *    *    *     *    *    *   *   *"
COLOR 15, 1
PRINT
PRINT
PRINT "HMMMM.........THEY KEEP SECRETS BETTER THAN THE US GOVERNMENT"

END SUB

SUB CODEZY
SCREEN 0
COLOR 15, 1
CLS
COLOR 15, 0
PRINT "          *          *      *        *"
PRINT "   O   *      l        *      *   *  *"
PRINT "  *     *  *  l  *        *     *  * *"
PRINT "    *    ----(+)----      *           "
PRINT "  *    *      l   *    *      *    *  "
PRINT "    *    *  * l    *    *   *   *   * "
PRINT "*   *   *     *   *   *    *   *  *  *"
COLOR 15, 1
PRINT
PRINT
PRINT "THERE IS A PLANET HERE:   1-TAKE A LOOK    2-LEAVE SECTOR"
ret:
ad$ = INKEY$
IF ad$ = "1" GOTO 20000
IF ad$ = "2" GOTO 30000
GOTO ret:

20000 CLS
PRINT ""
PRINT
PRINT
PRINT "           THERE IS ONE MAN ON THE PLANET AND HE SAYS HE"
PRINT "           HAS THE CODE TO THE VIPER HOMEWORLD SHIELD"
PRINT "           BUT HE SAYS HE WANTS THE SAFETY KEY FIRST."
PRINT "           1-GIVE HIM THE KEY   2-LEAVE SECTOR"
dolt:
app$ = INKEY$
IF app$ = "1" GOTO 20001
IF app$ = "2" GOTO 30000
GOTO dolt:
CODEZY
20001
CLS
PRINT "WHAT IS IT?"
INPUT a
IF a = 745 GOTO 20002
PRINT "THAT IS NOT THE KEY!"
INPUT a
GOTO 30000
20002
PRINT "you have passed the 1st test, now the second, I am thinking of a number"
PRINT "between 1 and 50,  You have 3 guesses!"
num = INT(RND * 50) + 1
INPUT "Guess 1"; a
IF a > num GOTO 20022
IF a = num GOTO 20030
IF a < num GOTO 20023
20003 INPUT "Guess 2"; b
IF b > num GOTO 20024
IF b = num GOTO 20030
IF b < num GOTO 20025
20004 INPUT "Guess 3"; c
IF c = num GOTO 20030
PRINT "WRONG, IT WAS"; num; ", OH LEAVE NOW!"
GOTO 30000
20022 PRINT "to high"
GOTO 20003
20023 PRINT "To low!"
GOTO 20003
20024 PRINT "to high"
GOTO 20004
20025 PRINT "to low!"
GOTO 20004
20030 PRINT "THAT'S RIGHT!"
PRINT "THE CODE IS 9345"
INPUT a
30000 PRINT "NEW SECTOR?"
END SUB

SUB ENDer
' "c:\turbo\games.bas"
SCREEN 0
COLOR 0, 0
CLS
COLOR 15, 4
PRINT "                       Space Commander Z II: The Vipers Attack                  "
COLOR 14, 1
PRINT "      Programmed By: Eric Dorn         Produced by: Turbo Systems Software      "
PRINT "                                                                                "
COLOR 15
PRINT "  This Copy of Space Commander Z II is UNREGISTERED!!! Do you know what this    "
PRINT " Means???? IT MEANS YOU HAVEN'T REGISTERED!! (Very few things in life are that  "
PRINT "  Self explanitory.)  You do know that people who do not register their software"
PRINT " Burn in Hell much longer.  Anyways.............................                "
PRINT "                          If you register you get:                              "
PRINT "                               1. Soundblaster effects                          "
PRINT "                               2. 100 Sectors                                   "
PRINT "                               3. Better battle sequence Graphics               "
PRINT "                               4. A New Car (Just Kidding)                      "
PRINT " It costs a Mere 10$, All checks should be payable to Eric Dorn, Include a      "
PRINT " self-adressed stamped envelope and send to:                                    "
PRINT "                                                                                "
COLOR 14
PRINT "                                TS Software: Space Commander Z                  "
PRINT "                                c/o Eric Dorn                                   "
PRINT "                                2526 N 73rd ST                                  "
PRINT "                                Wauwatosa, WI 53213-1214                        "
COLOR 2
PRINT "WWW: http://members.aol.com/roadbustr/homepage/tss.htm E-Mail: TSSoft1@aol.com  "
COLOR 7, 0
PRINT "                         [Press Enter to Get away from this screen]"
LINE INPUT a$
SYSTEM
END
END SUB

SUB Enemy

SCREEN 12
COLOR 15
CLS
COLOR 15
a$ = "*   ________       * *                    *   *   *    *    *    *   "
b$ = "    l   \     *    * *    *   *    *   *   *   *   *   *  *   *      "
x$ = "    l l \     *    * *    *   *    *   *   *   *   *   *  *   *      "
c$ = "    l V   \ *    *       l    *   *    *    *      *   *   *   *     "
w$ = "    l l   \ *    *       *    *   *    *    *      *   *   *   *     "
d$ = "  * l_______\            l      *        *      *         *          "
v$ = " ----(+)----\            *      *        *      *         *          "
e$ = "   /     -----\     ----(+)----     *       *       *       *   *    "
u$ = "   /  l  -----\          *          *       *       *       *   *    "
f$ = "    \     ------\_______ l     *       *       *        *     *      "
s$ = "    \ l   ------\________      *       *       *        *     *      "
g$ = "      \__________________l\      *        *       *        *         "
t$ = "      \___________________\      *        *       *        *         "
h$ = "    *     *     *    *    *    *    *    *    *    *   *   *  *      "
COLOR 15
grafic
PRINT ""
COLOR 15
PRINT 'a$
PRINT 'b$
PRINT 'c$
PRINT 'd$
PRINT 'e$
PRINT 'f$
PRINT 'g$
PRINT 'h$
COLOR 2
'PRINT "Enemy Ship in sector............"
'PRINT "1-Red Alert and Prepare Weapons    2-Leave sector   3-Ignore"
atta:
ater$ = INKEY$
IF ater$ = "1" GOTO 2
IF ater$ = "2" GOTO 21
IF ater$ = "3" GOTO 20
GOTO atta:
2 COLOR 15
'CLS
'grafic1
PRINT
COLOR 15
PRINT 'a$
PRINT 'x$
PRINT 'w$
PRINT 'v$
PRINT 'u$
PRINT 's$
PRINT 't$
PRINT 'h$
COLOR 1
'PRINT "                            **RED ALERT**"
COLOR 7
'PRINT "You can 1-Fire Proton Torpedos   2-fire Laser Blasters                      "
'PRINT "3-Ion Cannon  4-Subdue them with Mozart"
grafic1
a = INT(RND * 2) + 1
rippit:
xosin$ = INKEY$
IF xosin$ <> "" GOTO 5
GOTO rippit:
ENDer
5 battle
GOTO 21
20202 PRINT "Your Shot Destroys the Enemy Cruiser!"
INPUT l
GOTO 21
6 IF a = 2 GOTO 30303
COLOR 15
CLS
PRINT "They Deflect your shot, The Viper ship attacks and kills you!"
ENDer
30303 PRINT "You kill them!"
GOTO 21
8 COLOR 7
CLS
LOCATE 12, 30
PRINT "Mozart's Sonata in C"


PLAY "c2 L4 e g < b. > l16 c d l2 c"
PLAY "> a l4 g > c < g l16 g f e f l2 e"
PLAY "< a8 l16 b > c d e f g a g f e d c < b a"
PLAY "g8 a b > c d e f g f e d c < b a g f8 g a b > c d e"
PLAY "f e d c < b a g f e8 f g a b > c d e d c < b a g f e"
PLAY "d8 e f g a b > c# d <a b > c# d e f g"
PLAY "a b > c < b a g f e f g a g f e d c"
PLAY "< L8 b MS > g e c ML d g MS e c"
PLAY "D4 g4 < g2 g2 > c4 e4 g2"
PLAY "l16 a g f e f e d c e d e d e d e d e d e d e d e c"
PLAY "c4 c < g > c e g e c e f d < b > d"
PLAY "c4 <c < g > c d g e c e f d < b > d c4 > c4 c2"
INPUT a
PLAY "a b >g"
COLOR 7
IF a = 2 GOTO 10101
COLOR 15
CLS
PRINT "THEY BLOW THE CRAP OUT OF YOU!"
ENDer
CLS
10101 PRINT "You destroy everything in the sector!"
GOTO 21

20 IF a = 1 GOTO 40404
COLOR 15
CLS
PRINT " they kill you"
PRINT "[Press Enter]"
LINE INPUT a$
ENDer
40404
PRINT "You kill the bastards!"
COLOR 7
21 PRINT "New Sector?"

END SUB

SUB Generic
SCREEN 12
COLOR 15
CLS
grafic2
PRINT
COLOR 15
PRINT '"*    *     *    *      *     *     *           *      *   * "
PRINT '"     *      *         *             *                      *"
PRINT '" *      *       *          *      *      *     *    *   *   "
PRINT '"      *    *         *         *      *     *    *    *    *"
PRINT '"  *            *       *    *    l     *    *   *   *   *   "
PRINT '"        *         *        *     l        *    *   *      * "
PRINT '" *            *     *   *   ----(+)----   *    *     *      "
PRINT '"       *    *   *   *   *   *    l    *    *     *     *  * "
PRINT '"  *        *      *     *     *  l   *    *   *    *    *  *"
PRINT '" *    *     *      *       *     *    *    *    *    *   *  "
COLOR 5
PRINT "Nothing here, new sector"
COLOR 7
END SUB

SUB grafic
DIM byte AS STRING * 1
CLS
'INPUT "Bitmap Filename"; data$
data$ = "space1.bmp"
'data$ = "c:\win3_1\winlogo.bmp"

IF LTRIM$(RTRIM$(data$)) = "" THEN END
OPEN data$ FOR BINARY AS #1
IF LOF(1) = 0 THEN PRINT "File not found!": CLOSE : KILL data$: END

table$ = INPUT$(54, #1)  'Get the file header (54 bytes)
DIM table&(30)           'Create numerical array for header
DEF SEG = VARSEG(table&(1))
pointer% = VARPTR(table&(1))

'Poke the data from string "table$" into numerical array "table&"
FOR x% = 0 TO 51
 POKE pointer% + x%, ASC(MID$(table$, x% + 3, 1))
NEXT
DEF SEG

'Check for valid file type
IF MID$(table$, 1, 2) <> "BM" OR table&(4) <> 40 THEN
   PRINT "Not a valid *.BMP file!": END
END IF
IF table&(8) <> 0 THEN
   PRINT "This program will not diplay RLE encoded files": END
END IF
'IF ASC(MID$(table$, 29, 1)) <> 4 THEN
'   PRINT "Only 16 color bitmaps are supported!": END
'END IF

'Set the video mode for best picture fit
IF (table&(5) < 321) AND (table&(6) < 201) THEN
   SCREEN 12
ELSE
   SCREEN 12
END IF
LOCATE 2, 1
'PRINT " Image is "; table&(5); " by "; table&(6)
COLOR 12
PAINT (200, 200)


thecolors$ = INPUT$(table&(3) - 54, #1) 'Read in pallette info

DEF SEG = VARSEG(pal&)
pointer% = VARPTR(pal&)
'Poke the pallette info from the string "thecolors$"
'into pal& and reduce to 6 bits per byte.
FOR x% = 0 TO 63 STEP 4
 POKE pointer%, (ASC(MID$(thecolors$, x% + 3, 1))) \ 4
 POKE pointer% + 1, (ASC(MID$(thecolors$, x% + 2, 1))) \ 4
 POKE pointer% + 2, (ASC(MID$(thecolors$, x% + 1, 1))) \ 4
 POKE pointer% + 3, 0
PALETTE x% \ 4, pal&
NEXT
DEF SEG



'Read in Bitmap data and set pixels accordingly
y% = table&(6) 'Put number of vertical pixels into y%
DO
  data$ = INPUT$((((table&(5) - 1) OR 7) + 1) \ 2, #1)
    IF (table&(5) \ 2) < LEN(data$) THEN
       linelength% = table&(5) \ 2
    ELSE
       linelength% = LEN(data$)
    END IF
    FOR x% = 1 TO linelength%
      pixel% = ASC(MID$(data$, x%, 1))
      PSET (x% * 2 + 1, y%), pixel% AND 15
      PSET (x% * 2, y%), pixel% \ 16
     NEXT
    y% = y% - 1
LOOP UNTIL EOF(1) OR INKEY$ <> ""
CLOSE
END SUB

SUB grafic1
DIM byte AS STRING * 1
'CLS
'INPUT "Bitmap Filename"; data$
data$ = "space2.bmp"
'data$ = "c:\win3_1\winlogo.bmp"

IF LTRIM$(RTRIM$(data$)) = "" THEN END
OPEN data$ FOR BINARY AS #1
IF LOF(1) = 0 THEN PRINT "File not found!": CLOSE : KILL data$: END

table$ = INPUT$(54, #1)  'Get the file header (54 bytes)
DIM table&(30)           'Create numerical array for header
DEF SEG = VARSEG(table&(1))
pointer% = VARPTR(table&(1))

'Poke the data from string "table$" into numerical array "table&"
FOR x% = 0 TO 51
 POKE pointer% + x%, ASC(MID$(table$, x% + 3, 1))
NEXT
DEF SEG

'Check for valid file type
IF MID$(table$, 1, 2) <> "BM" OR table&(4) <> 40 THEN
   PRINT "Not a valid *.BMP file!": END
END IF
IF table&(8) <> 0 THEN
   PRINT "This program will not diplay RLE encoded files": END
END IF
'IF ASC(MID$(table$, 29, 1)) <> 4 THEN
'   PRINT "Only 16 color bitmaps are supported!": END
'END IF

'Set the video mode for best picture fit
IF (table&(5) < 321) AND (table&(6) < 201) THEN
   SCREEN 12
ELSE
   SCREEN 12
END IF
LOCATE 2, 1
'PRINT " Image is "; table&(5); " by "; table&(6)

thecolors$ = INPUT$(table&(3) - 54, #1) 'Read in pallette info

DEF SEG = VARSEG(pal&)
pointer% = VARPTR(pal&)
'Poke the pallette info from the string "thecolors$"
'into pal& and reduce to 6 bits per byte.
FOR x% = 0 TO 63 STEP 4
 POKE pointer%, (ASC(MID$(thecolors$, x% + 3, 1))) \ 4
 POKE pointer% + 1, (ASC(MID$(thecolors$, x% + 2, 1))) \ 4
 POKE pointer% + 2, (ASC(MID$(thecolors$, x% + 1, 1))) \ 4
 POKE pointer% + 3, 0
PALETTE x% \ 4, pal&
NEXT
DEF SEG



'Read in Bitmap data and set pixels accordingly
y% = table&(6) 'Put number of vertical pixels into y%
DO
  data$ = INPUT$((((table&(5) - 1) OR 7) + 1) \ 2, #1)
    IF (table&(5) \ 2) < LEN(data$) THEN
       linelength% = table&(5) \ 2
    ELSE
       linelength% = LEN(data$)
    END IF
    FOR x% = 1 TO linelength%
      pixel% = ASC(MID$(data$, x%, 1))
      PSET (x% * 2 + 1, y%), pixel% AND 15
      PSET (x% * 2, y%), pixel% \ 16
     NEXT
    y% = y% - 1
LOOP UNTIL EOF(1) OR INKEY$ <> ""
CLOSE
END SUB

SUB grafic2
DIM byte AS STRING * 1
CLS
'INPUT "Bitmap Filename"; data$
data$ = "space3.bmp"
'data$ = "c:\win3_1\winlogo.bmp"

IF LTRIM$(RTRIM$(data$)) = "" THEN END
OPEN data$ FOR BINARY AS #1
IF LOF(1) = 0 THEN PRINT "File not found!": CLOSE : KILL data$: END

table$ = INPUT$(54, #1)  'Get the file header (54 bytes)
DIM table&(30)           'Create numerical array for header
DEF SEG = VARSEG(table&(1))
pointer% = VARPTR(table&(1))

'Poke the data from string "table$" into numerical array "table&"
FOR x% = 0 TO 51
 POKE pointer% + x%, ASC(MID$(table$, x% + 3, 1))
NEXT
DEF SEG

'Check for valid file type
IF MID$(table$, 1, 2) <> "BM" OR table&(4) <> 40 THEN
   PRINT "Not a valid *.BMP file!": END
END IF
IF table&(8) <> 0 THEN
   PRINT "This program will not diplay RLE encoded files": END
END IF
'IF ASC(MID$(table$, 29, 1)) <> 4 THEN
'   PRINT "Only 16 color bitmaps are supported!": END
'END IF

'Set the video mode for best picture fit
IF (table&(5) < 321) AND (table&(6) < 201) THEN
   SCREEN 12
ELSE
   SCREEN 12
END IF
LOCATE 2, 1
'PRINT " Image is "; table&(5); " by "; table&(6)
COLOR 12
PAINT (200, 200)


thecolors$ = INPUT$(table&(3) - 54, #1) 'Read in pallette info

DEF SEG = VARSEG(pal&)
pointer% = VARPTR(pal&)
'Poke the pallette info from the string "thecolors$"
'into pal& and reduce to 6 bits per byte.
FOR x% = 0 TO 63 STEP 4
 POKE pointer%, (ASC(MID$(thecolors$, x% + 3, 1))) \ 4
 POKE pointer% + 1, (ASC(MID$(thecolors$, x% + 2, 1))) \ 4
 POKE pointer% + 2, (ASC(MID$(thecolors$, x% + 1, 1))) \ 4
 POKE pointer% + 3, 0
PALETTE x% \ 4, pal&
NEXT
DEF SEG



'Read in Bitmap data and set pixels accordingly
y% = table&(6) 'Put number of vertical pixels into y%
DO
  data$ = INPUT$((((table&(5) - 1) OR 7) + 1) \ 2, #1)
    IF (table&(5) \ 2) < LEN(data$) THEN
       linelength% = table&(5) \ 2
    ELSE
       linelength% = LEN(data$)
    END IF
    FOR x% = 1 TO linelength%
      pixel% = ASC(MID$(data$, x%, 1))
      PSET (x% * 2 + 1, y%), pixel% AND 15
      PSET (x% * 2, y%), pixel% \ 16
     NEXT
    y% = y% - 1
LOOP UNTIL EOF(1) OR INKEY$ <> ""
CLOSE

END SUB

SUB Grafic3
DIM byte AS STRING * 1
CLS
'INPUT "Bitmap Filename"; data$
data$ = "space5.bmp"
'data$ = "c:\win3_1\winlogo.bmp"

IF LTRIM$(RTRIM$(data$)) = "" THEN END
OPEN data$ FOR BINARY AS #1
IF LOF(1) = 0 THEN PRINT "File not found!": CLOSE : KILL data$: END

table$ = INPUT$(54, #1)  'Get the file header (54 bytes)
DIM table&(30)           'Create numerical array for header
DEF SEG = VARSEG(table&(1))
pointer% = VARPTR(table&(1))

'Poke the data from string "table$" into numerical array "table&"
FOR x% = 0 TO 51
 POKE pointer% + x%, ASC(MID$(table$, x% + 3, 1))
NEXT
DEF SEG

'Check for valid file type
IF MID$(table$, 1, 2) <> "BM" OR table&(4) <> 40 THEN
   PRINT "Not a valid *.BMP file!": END
END IF
IF table&(8) <> 0 THEN
   PRINT "This program will not diplay RLE encoded files": END
END IF
'IF ASC(MID$(table$, 29, 1)) <> 4 THEN
'   PRINT "Only 16 color bitmaps are supported!": END
'END IF

'Set the video mode for best picture fit
IF (table&(5) < 321) AND (table&(6) < 201) THEN
   SCREEN 12
ELSE
   SCREEN 12
END IF
LOCATE 2, 1
'PRINT " Image is "; table&(5); " by "; table&(6)
COLOR 12
PAINT (200, 200)


thecolors$ = INPUT$(table&(3) - 54, #1) 'Read in pallette info

DEF SEG = VARSEG(pal&)
pointer% = VARPTR(pal&)
'Poke the pallette info from the string "thecolors$"
'into pal& and reduce to 6 bits per byte.
FOR x% = 0 TO 63 STEP 4
 POKE pointer%, (ASC(MID$(thecolors$, x% + 3, 1))) \ 4
 POKE pointer% + 1, (ASC(MID$(thecolors$, x% + 2, 1))) \ 4
 POKE pointer% + 2, (ASC(MID$(thecolors$, x% + 1, 1))) \ 4
 POKE pointer% + 3, 0
PALETTE x% \ 4, pal&
NEXT
DEF SEG



'Read in Bitmap data and set pixels accordingly
y% = table&(6) 'Put number of vertical pixels into y%
DO
  data$ = INPUT$((((table&(5) - 1) OR 7) + 1) \ 2, #1)
    IF (table&(5) \ 2) < LEN(data$) THEN
       linelength% = table&(5) \ 2
    ELSE
       linelength% = LEN(data$)
    END IF
    FOR x% = 1 TO linelength%
      pixel% = ASC(MID$(data$, x%, 1))
      PSET (x% * 2 + 1, y%), pixel% AND 15
      PSET (x% * 2, y%), pixel% \ 16
     NEXT
    y% = y% - 1
LOOP UNTIL EOF(1) OR INKEY$ <> ""
CLOSE

END SUB

SUB Trendy
SCREEN 0
COLOR 15, 1
CLS
COLOR 15, 0
PRINT "           .             .          .       ."
PRINT "  .    I           .            .      .     "
PRINT "       I    .           .    .     .     .   "
PRINT "  ----(+)----    .      .     .    .    .  . "
PRINT "       I    .       *      .     .   .    .  "
PRINT "  .    I   .    . **O**      .     .    .  . "
PRINT "    .        .      *           .      .  .  "
COLOR 20, 1
PRINT "          ***WARNING***SUPER NOVA IN SECTOR***"
COLOR 15, 1
PRINT "          Leaving Sector......................."
PRINT "New sector?"
END SUB

SUB Warp


CLS
PRINT
Grafic3
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
COLOR 1
PRINT "***WORM HOLE***"
PRINT
COLOR 7
PRINT "I AM CONFUSED! I HAVE NEVER ENCOUNTERED THIS BEF........"
PRINT "LOSS OF CONTROL! BEING SUCKED INTO WORMHOLE!!!!!!!!!!!!!!!!!"

INPUT a
CLS
x$ = "l2o1b-o2fb-o3l5feo0l10ab-ab-ab-"
3000 SCREEN 12
a% = INT(RND * 14) + 1
COLOR a%
IF x = 410 THEN GOTO 3001
x = x + 1
CIRCLE (300, 250), x
GOTO 3000
3001 'PLAY x$
INPUT a
SCREEN 0
COLOR 20, 1
CLS
PRINT "                        **** FLIGHT COMPUTER CONFUSED ****"
COLOR 15
PRINT
PRINT "                                    Um, sorry,"
PRINT "                            I Don't know where we are!"
PRINT "         None of this Matches any of my Charts.  ugggggg! THIS HAS ME MAD!"
PRINT "                                  "
PRINT
PRINT
PRINT
PRINT
PRINT " "
COLOR 20
PRINT "                    **EMERGENCY!!!! PRESS RETURN!!!!!!!!!**"
COLOR 1
INPUT a
CLS
COLOR 20
PRINT "                        **** FLIGHT COMPUTER CONFUSED ****"
COLOR 15
PRINT
PRINT
PRINT "                    I have an incoming Transmission, Commander."
PRINT "                           It is from an unknown Source."
PRINT "  "
PRINT ""
COLOR 4
23 PRINT "                            (A)ccept            (I)gnore "
PRINT "                             What Should I do Commander?"
crap:
ASD$ = INKEY$
SELECT CASE ASD$

CASE "A"
     GOTO 1000
CASE "a"
     GOTO 1000
CASE "I"
     GOTO 2000
CASE "i"
     GOTO 2000
END SELECT
GOTO crap:
1000 COLOR 20, 1
CLS
PRINT "                           ***COMMUNICATIONS TERMINAL***"
COLOR 15
PRINT
PRINT "                              The message reads......."
COLOR 4, 0
PRINT
PRINT "This is Jack Coostieow, Commander of the VIPER FLAGSHIP S.U.B. Mayrine"
PRINT "Please Identify yourself Earthling!!!!"
COLOR 15, 1
PRINT
24 PRINT "                            Your choices Commander are..."
PRINT "                                    (R)eply   (I)gnore"
PRINT "                         I await your order as your trusty AI"
fred:
fg$ = INKEY$
SELECT CASE fg$
     CASE "R"
        GOTO 1006
     CASE "I"
        GOTO 2000
     CASE "r"
        GOTO 1006
     CASE "i"
        GOTO 2000
     CASE "A"
        GOTO 1100
     CASE "a"
        GOTO 1100
END SELECT
GOTO fred:
1006 COLOR 20, 1
CLS
PRINT "                           ***COMMUNICATIONS TERMINAL***"
COLOR 15
PRINT
1007  PRINT "                              Okay, Tell him your Name."
INPUT a$
SELECT CASE a$
     CASE "Commander Z"
        PRINT "                    He  replies: "
        COLOR 4, 0
        PRINT "I know that stupid! It's only written in big letters on the side of your ship! I mean your real name!"
        COLOR 15, 1
        GOTO 1007
     CASE ELSE
        COLOR 15, 1
        PRINT "He replies........................................"
        COLOR 4, 0
        PRINT "Ah, I have heard of you, "; a$; ".  It is said you are a good Pilot. It does not Matter Though, You shall die anyway!"
        GOTO 1004
END SELECT
1004 COLOR 15, 1
PRINT "                          That doesn't sound good..........."
PRINT "                                  You can:"
PRINT "                      (A)ttack  (F)loor it towards the Worm hole"
PRINT "                 (A)ttack  (R)un like hell  and did I mention (A)ttack?"
PRINT "                                  What'll it be"
gong:
b$ = INKEY$
SELECT CASE b$
     CASE "A"
        GOTO 1100
     CASE "a"
        GOTO 1100
     CASE "F"
        GOTO 2010
     CASE "f"
        GOTO 2010
     CASE "R"
        GOTO 2010
     CASE "r"
        GOTO 2010
END SELECT
GOTO gong:
1100 COLOR 20, 1
shield = 20
killer = 30
112233 COLOR 20, 1
CLS

PRINT "                            ***RED ALERT***"
PRINT ""
PRINT "  ";
COLOR 15, 0
PRINT ; "                     ";
COLOR 15, 1
PRINT ; "      Battle"
PRINT "  ";
COLOR 15, 0
PRINT ; "                     ";
COLOR 15, 1
PRINT ; "      Scope 1"
PRINT "  ";
COLOR 15, 0
PRINT ; "         l           "
COLOR 15, 1
PRINT "  ";
COLOR 15, 0
PRINT ; "       --+--         "
COLOR 15, 1
PRINT "  ";
COLOR 15, 0
PRINT ; "         l           "
COLOR 20, 1
PRINT "    **TARGET LOCKED**"
PRINT ""
COLOR 15, 1
PRINT "   1-Use Proton Torpedos  2-Laser Blasters  3-ion cannon 4-Mozart"
PRINT "   Sheilds are at:"; shield; "   He is at"; killer
set:
ad$ = INKEY$
his = INT(RND * 5) + 1
IF ad$ = "1" GOTO 1101
IF ad$ = "2" GOTO 1105
IF ad$ = "3" GOTO 1110
IF ad$ = "4" GOTO 1115
GOTO set:
1101 COLOR 15, 4
CLS
PRINT "You hit him for 4 damage!"
PRINT "Unfortunatly he hits you for"; his
PRINT "                "
PRINT "                        press return..........."
INPUT a
shield = shield - his
killer = killer - 4
IF shield < 1 GOTO 181
IF killer < 1 GOTO 2011
GOTO 1.2
181 PRINT "You die :("
ENDer
1.2
GOTO 112233
1105 CLS
PRINT "You hit him for 5!"
PRINT "He hits you for 200, just kidding, only"; his
shield = shield - his
killer = killer - 5
IF shield < 1 GOTO 181
IF killer < 1 GOTO 2011
GOTO 1.2

GOTO 2011
1110 COLOR 15, 4
CLS
PRINT "You make an unsuccessful atempt and die............"
ENDer
1115  CLS
PRINT "It didn't work"
GOTO 1110
2000 COLOR 15, 4
CLS
PRINT "You get blown to kingdomcome....."
ENDer
2010 COLOR 15, 4
CLS
PRINT "You try to escape but you get killed, dead, etc...."
ENDer
2011 INPUT a
REM ember the Alamo!
COLOR 20, 1
CLS
PRINT "                        **** FLIGHT COMPUTER CONFUSED ****"
PRINT ""
COLOR 15, 1
PRINT "                                    Alright!"
PRINT "                        Unfortunetly I still don't Know where"
PRINT "                        We are. But Fear not "; a$; ""
PRINT "                        We will get Out!!!!!!!!!!!!!!!!!!!!!!!"
PRINT
PRINT "                  Okay, You can: (E)xplore (H)eadback to the Wormhole"
PRINT "                                  Vhat vill it be"
that:
s$ = INKEY$
SELECT CASE s$
      CASE "e"
         GOTO 4000
      CASE "E"
         GOTO 4000
      CASE "H"
         GOTO 3010
      CASE "h"
         GOTO 3010
END SELECT
GOTO that:
3010  CLS
PRINT "             ***************WORM HOLE******WORM HOLE**************"
PRINT ""
PRINT "                            PRESS RETURN SIR!!!!!!!!"
COLOR 1
INPUT a
CLS
3012 WORMHOLE
INPUT a
SCREEN 0
COLOR 15, 1
CLS
PRINT
PRINT "                 WE ARE BACK IN NORMAL SPACE!!!!!!!!"
PRINT "                           NEW SECTOR"
GOTO 6000
4000 COLOR 15, 1
CLS
h = 10
p = 10
PRINT "                 Suddenly there is a bright light in front"
PRINT "                             of you. Standing in"
PRINT "                front of you is a man.  He is attacking you!"
4001
PRINT "                You have "; h; " hp and he has "; p; " hp"
PRINT "                   (A)ttack  (D)efend   (M)ove"
duh:
ah$ = INKEY$
kicker = INT(RND * 5) + 1
hitter = INT(RND * 3) + 1
SELECT CASE ah$
        CASE "A"
           PRINT "You attack, he loses "; kicker; " hp"
           p = p - kicker
           GOTO fr:
        CASE "a"
           PRINT "You attack, he loses "; kicker; " hp"
           p = p - kicker
           GOTO fr:
        CASE "D"
           PRINT "He loses"; hitter; ", you lose"; kicker
           p = p - hitter
           h = h - kicker
           GOTO fr:
        CASE "d"
           PRINT "He loses"; hitter; ", you lose"; kicker
           p = p - hitter
           h = h - kicker
           GOTO fr:
        CASE "M"
           PRINT "He loses"; kicker; ", you lose"; hitter
           p = p - kicker
           h = h - hitter
           GOTO fr:
        CASE "m"
           PRINT "He loses"; kicker; ", you lose"; hitter
           p = p - kicker
           h = h - hitter
           GOTO fr:
END SELECT
GOTO duh:
fr:
PRINT "  He attacks, you lose 1 hit points!"
h = h - 1
IF p < 1 GOTO 5000
IF h < 1 GOTO 4002
GOTO 4001
4002 INPUT d
COLOR 15, 4
CLS
PRINT "He kills you"
ENDer
5000 PRINT "You kill him!"
     PRINT "HIT ENTER"
INPUT a
5001
COLOR 15, 1
CLS
PRINT
PRINT
PRINT
COLOR 20, 1
PRINT "           **********************PLANET ON SCOPE**************************"
COLOR 15
PRINT
PRINT
PRINT "Commander, there is a planet on the scope.................................."
PRINT "Incoming transmission sir:    (A)ccept Transmission     (L)and     (I)gnore"
dip:
b$ = INKEY$
SELECT CASE b$
CASE "a"
GOTO 5004
CASE "A"
GOTO 5004
CASE "l"
GOTO 5002
CASE "L"
GOTO 5002
CASE "I"
GOTO 5003
CASE "i"
GOTO 5003
END SELECT
GOTO dip:
5002
CLS
PRINT "WE ARE TRYING TO LAND>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
PRINT "KAKAKAKAKAKAKABOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOM!"
PRINT "we hit a force shield and blow up"
ENDer
5003
CLS
PRINT "We are ignoring them...........They blow us up!"
ENDer
5004
COLOR 20, 1
CLS
PRINT
PRINT
PRINT "                        **COMMUNICATIONS TERMINAL**"
PRINT
PRINT
COLOR 4, 0
PRINT "THIS IS THE VIPER HOMEWORLD. WHAT IS THE SHIELD CODE?"
COLOR 15, 1
PRINT "    1-GIVE HIM THE CODE           2-GET OUT OF HERE"
huh:
a$ = INKEY$
IF a$ = "1" GOTO 5006
IF a$ = "2" GOTO 5008
GOTO huh:
ENDer
5005 COLOR 4, 2
CLS
COLOR 5, 1
PRINT "                Full screen mode....landing sight               "
PRINT "                                     "
PRINT "                                          "
PRINT "                                             "
PRINT "                                                                "
PRINT "                                                         "
PRINT "                                                             "
PRINT "                                                                     "
COLOR 2, 1
PRINT "                        You Ready your Weapons...                               "
PRINT "                                                    "
PRINT "                                      "
PRINT "                                                   "
PRINT "                              "
PRINT "                        "
PRINT "           "
PRINT "     "
xosquad = 0
SLEEP 1
hutt:
COLOR 15, 4
CLS
PRINT ""
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT "                               KAKAKAKAKAKAKKA BOOOOOOOOOOOOOOM!!!!!!!                         "
endor = 0
frog:
endor = endor + 1
IF endor = 9000 GOTO gy:
GOTO frog
gy:
SLEEP 1
'PLAY "o0 l60 abbbaba"
COLOR 27, 1
CLS
PRINT "                             *****CONGRATULATIONS!*****"
COLOR 7, 1
PRINT "                     You, Commander, are awesome!"; a$; " Is GOD!"
PRINT "   The Universe Is saved from the Vipers!  Commander,  I will see you in"
PRINT "                               SPACE COMMANDER Z III"
PRINT "     Until next time................................................."
LINE INPUT "[Press Enter]"; a$
ENDer
5006
COLOR 20, 1
CLS
PRINT
PRINT
PRINT "                        **COMMUNICATIONS TERMINAL**"
PRINT
PRINT
COLOR 4, 0
INPUT "WHAT IS IT"; a
IF a = 9345 GOTO 5005
PRINT "YOU ENTER THE WRONG CODE AND YOU ARE DESTROYED!"
ENDer
5008 WORMHOLE




6000

END SUB

SUB warpg1

END SUB

SUB warpg2
END SUB

SUB WORMHOLE
0 SCREEN 12
a% = INT(RND * 14) + 1
COLOR a%
IF x = 410 GOTO 7
x = x + 1
CIRCLE (300, 250), x
GOTO 0
7
END SUB

