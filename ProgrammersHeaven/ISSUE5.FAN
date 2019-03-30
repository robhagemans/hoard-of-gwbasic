
  _____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~
			     THE BASIX FANZINE
			  Edited by  Peter Cooper
				 Issue 5
  _____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~

                         peco@trenham.demon.co.uk

  INTRODUCTION:

  You asked for it, and you got it! This fanzine is cram packed full of
  source, although I dont believe that you should learn solely from reading
  peoples source, it can be useful in learning style and things that are
  hard to describe in words. There's plenty of source available from ModeX
  PCX displayers and Animal Vegetable Mineral games to Com Port initializers.

  A new competition is being released in this issue, a lot of you may already
  have entries.. It is a competition to get the best collections of retro
  games, such as Asteroids and Centipede to Battle Tanks and Space Invaders.
  Check out Section 2 Part 3.

  Anyway, I hope you enjoy this read whether you're reading this from the
  newsgroups, on a web site or an ftpable version.

  Late entry:
        Once again, sorry about the delay in this. It was only about a week
        or two but I should really try and get it out the door on time. But
        hey, I have a compiler to write :) No real excuse though.. Although
        I did have a letdown or two to do with articles but hey, thats life!

==============================================================================
				Contents Page
==============================================================================

 SECTION ONE) - [SPECIALIZED ARTICLES]
  - Part [a] ADVANCED\HARDER STUFF
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1) CDROM Series     How to use audio CD in BASIC!!!    QkBasic,VBDOS,PDS

  - Part [b] EASIER MORE DOWN TO EARTH STUFF
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1) Basic Tutorials  Zooming into the fourth instalment QBasic + up
    2) The creation..   The Creation of Liberty Basic      None
    3) Wrox Press Progs Some Programs from Wrox Press      QBasic
    4) Game Creation    Simple guide to making games       Any (qbasic src)

 SECTION TWO) - [ALL LEVELS ARTICLES]
    1) Useful sources   Places to get basic stuff on inet  Any
    2) Basic hints [1]  Loads of BASIC hints to help you   Any
    3) Competition      The biggest and best competition   QBasic

 SECTION THREE) - [YOUR SHOUT!+FUN]
    1) Letters          Your comments and questions        Any
    2) Your programs    All of your programs.. here!       Various

 SECTION FOUR) - [DETAILS ABOUT THE FANZINE]
    1) Latest developments
    2) How do you contribute?
    3) How do you contact the author?
    4) Credits
    5) Last words + next month

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
- SECTION ONE -----------------------------------------------------------------
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 Specialized articles:

 This section is split into two parts. Part A is for the more advanced or
 intermediate programmer in basic and Part B is more for the beginners of
 BASIC. This sort of layout was something people wanted. Sorry if it seems
 rather insulting but well sorry. 

______________________________________________________________________________
| SECTION 1 PART A SUBPART 1 | GFX Colliding! |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Creating an Audio-CD Player in BASIC (VBDOS/QB4.5)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Part 1:  Introduction and Getting System Information

Hello everybody!

Before I begin this guide I would like to take this moment and introduce
myself to you. My name is Marco Koegler and I'm a student at the University
of Missouri-Rolla. Programming in BASIC is a little hobby of mine and just
recently I figured out how to do something really neat. Well, from the title
of this thing you probably guessed it, I found a way to access the audio
capabilities of my CD-ROM drive. Since it isn't that hard (once you find the
right documentation) I thought I might share my wisdom (or lack thereof) in 
the fanzine. Since space is limited, I will only explain the bare essentials. 
Don't worry, even if you don't know anything about interrupts, registers and 
other `complicated' stuff, following this guide closely will provide you 
with a working program. For those, who want to go beyond the scope of this 
guide and create other nifty little CD functions I recommend the document 
MSCDEX21.ZIP (Archie or SimTel should locate this).  Since most of these 
functions are very similar to the basic types coverd in the guide, the docs 
should provide you with enough knowledge to do what you want to do.

Another issue we should get out of the way is the style of the program. It is
very repetitive, but only because I don't want people to cross-reference 
several fanzines just in order to find a certain function. I recommend that,
once the guide is finished, you plug the different types of calls into 
SUBs or FUNCTIONs anyway. Nonetheless I will use two functions, because 
otherwise the code would be a lot more messier than it already is. They are
as follows:

FUNCTION hbyte% (word%)    'Returns the higher byte of a 2 byte integer
IF word% >= 0 THEN         'Even takes care of negative integers
   hbyte% = word% \ 256
   ELSE
   hbyte% = (65536 + word%) \ 256
   END IF
END FUNCTION

FUNCTION lbyte% (word%)    'Returns the lower byte of a 2 byte integer
IF word% >= 0 THEN         'Even takes care of negative integers
   lbyte% = word% MOD 256
   ELSE
   lbyte% = (65536 + word%) MOD 256
   END IF
END FUNCTION

Before we begin coding this prog, please make sure that the standard QLB is
loaded (i.e. start VBDOS or QuickBasic4.5 with /L switch). We are going to 
need this in order to get the CALL INTERRUPTX routine and RegTypeX. Now, that
you have started the editor and written the two functions above, we have to
include the definition file and declare some variables:

' $INCLUDE: 'vbdos.bi'                    'For VBDOS
DIM SHARED inregsx AS RegTypeX            'SHARED optional, but if you are
DIM SHARED outregsx AS RegTypeX           'going to use it in SUBs leave it!
' $DYNAMIC                                '<- So we can REDIM arrays

All, right. Now we are ready to make our first attempts to `talk' with MSCDEX.
See, the program MSCDEX.EXE defines some nice interrupt functions which we 
will use. All the functions are located on interrupt &H2F and are referenced
by the value in the AX register. For example, the first function we will use
determines the MSCDEX version number and it is referenced by a value of 
&H150C in the AX register. From the documentation, we gather that after the
interrupt is called, the version number will be stored in the BX register.
Like this:  
            1st byte/High byte = Major Version Number
            2nd byte/Low byte  = Minor Version Number

This then results in the following code snippet:

' Determine MSCDEX Version
inregsx.ax = &H150C                       'Referencing the CD function
inregsx.bx = &H0                          'Set BX to zero; Just in case!
CALL interruptx(&H2F, inregsx, outregsx)  'Call interrupt &H2F

IF outregsx.bx = &H0 THEN                 'We are in trouble if this is true
   PRINT "No Valid MSCDEX Version!"       
   END
ELSE
   major$ = LTRIM$(STR$(hbyte%(outregsx.bx)))   'Extract number and store it
   minor$ = LTRIM$(STR$(lbyte%(outregsx.bx)))   'Extract number and store it
   PRINT "MSCDEX Version "; major$;"."; minor$;" is installed on your system!"
END IF

Well, as you can see if the BX register contains a zero value the program will
terminate. 

NOTE: The register only contains a non-zero value if MSCDEX Version 2.0 or
      higher is installed on your system!

All right! We have just written our first piece of code for our CD-Player 
program. But, since this is already getting too long, I'll have to stop here.
In the next part we'll get the first CD-ROM drive number and check whether it
is supported by MSCDEX. Then, we are going to take a look at our first call,
which will use a command block/buffer. See you guys next month!

Note from Peter: I already have all the parts of this series so there is no
danger of it NOT appearing in next issue, it will.. :)

______________________________________________________________________________
| SECTION 1 PART B SUBPART 1 | Basic Tutorials - Part 4 |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 BASIC Tutorials - installment 4
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 In the last instalment I showed you the following piece of code. Assume
 that n$ is holding someones name and that age% is holding the value of
 someones age.

         PRINT "Hello, ",n$
         PRINT "You are ",age%," years old"

 Let's say n$="Ben" and age%=32 .. that piece of code would print the
 following onto the screen:

 Hello, Ben
 You are 32 years old

 Lets go back to the code and look at it bit by bit:

         PRINT "Hello, ",n$

 We can understand the PRINT, we know that the print command will display
 the information produced from the expression following it onto the screen.
 We can also recognise the word 'Hello' (if we know English) next comes a
 comma which is actually in the text and then inverted commas " signify the
 end of the readable text.. Next comes a comma and then a variable name, this
 basically means that the next thing to print is the value of n$.

 Think about it like a list. You can make lists by putting commas between
 each item.. for example:

 My friends names are Fred, Bill, John, Sam, Josh and Bert.

 You can put lists in the PRINT command too and that is what the comma before
 the n$ is signifying.

 PRINT "Hello, ",n$

 Basically what this means is print the text in the inverted commas and _then_
 display the value of n$.
 Onto the next line:

          PRINT "You are ",age%," years old"

 This should be simple to understand now. The number of things to display in
 the list is now 3. The words 'you are', the variable age% and the words
 'years old'. It's simple!

 Sorry if it was going incredibly slow there but now there is no excuse not
 to understand! :)

 [Assignment]

 Write a program that clears the screen and then asks for the year that you
 were born in. Then have it work out how old the person is and then displays
 it like so:

 You were born in (year%) and that means that now you are (age%) old.

______________________________________________________________________________
| SECTION 1 PART B SUBPART 2 | The Creation and story of Liberty Basic |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		     A Short History of Liberty BASIC
		  By Carl Gundel, author of Liberty BASIC
		     Copyright  1996 Shoptalk Systems
			   All Rights Reserved
			Reprinted with permission

In this article I will try to give some feel for the origin of Liberty BASIC,
the ideas that shaped the product, and the keys to its success.

In 1991  I remember installing the first copy of Microsoft Windows at the
factory  where  I  worked.   I  was  very  excited,  but I quickly became
disappointed.   The  mini-applications  that  came with Windows were cute
but  not very useful.  Looking  through catalogs and on the store shelves
I  realized  that  I  couldn't  easily afford more than a program or two.
Software  for Windows was very expensive.  Most applications cost $400 or
more then.  Today it's possible to walk into a computer store with $50 in
your  pocket and walk out with pretty good Windows software in almost any
application category.

To  me,  the  most  disappointing  thing  was  the  lack  of a version of
Microsoft  BASIC  to work with Windows.  It surprised me a lot because it
reversed  the  trend  that PCs would come with some kind of BASIC for the
masses.

In  my  spare  time I began to piece together an expression parser for my
own  BASIC.  I  did this partly out of the desire to prove to myself that
I  could  create  my  own  programming language, and partly because of my
disappointment  that  Microsoft  left  BASIC  out of Windows.  Soon I was
writing  a compiler to go with the parser.  It took me about three months
working about 10 hours a week on the project.  I then had a working BASIC
core  language  with  some GUI features.  I remember hearing about Visual
BASIC during this time, and I was very interested in it.  The funny thing
is after all this time I've never even given it more than a brief look.

My  version of BASIC was deliberately very simple, much like the BASICs I
had  used  on  early  home computers.  I wanted to hide the complexity of
Windows and still give the BASIC programmer control over the Windows GUI.
I  added  things  only  with  careful consideration, trying to create GUI
extensions  would  _feel_ like BASIC.  I reasoned (hoped?) that it should
be  possible  to  write  a  real  Windows  program  in a simplified BASIC
language.  Not everyone needs raw speed or the power of C.

At  some point I realized that I could sell what I developed, so I had to
choose a  name.   I don't even remember anymore what my other ideas were,
but I remember I liked the name Liberty BASIC because it had a very grass
roots  kind  of  feel  to  it.  I remember thinking, "It's so cheap, it's
almost free."  Hence Liberty BASIC.

I  wasn't thinking shareware at that time.  I decided to advertise in the
back  of Computer Shopper.  This proved fruitless.  I could only afford a
single  run  of  a tiny ad in the showcase section.  I got only 1 inquiry
from  that  ad, and it didn't turn into a sale.  I then tried advertising
in  Computer  Marketplace and Computer Hotline for 3 months.  That didn't
generate  any  interest  at  all.  At last I decided to try the shareware
market.  It would be a long wait before I saw any money.

I  released  my first shareware version in March of '92.  It wasn't until
July  or August of that year that the first 2 or 3 registrations arrived.
This  was  exciting,  but it wasn't much money.  Over the next few months
the  best  I  saw was 5 registrations, and a couple of months did produce
any  money at all.  So far I was several thousand dollars and hundreds of
hours  into  this  project.   The  people  who  did  register  were  very
enthusiastic about my software.  This kept my hopes up.

I  kept  working  on  Liberty BASIC in my spare time.  I couldn't justify
very  much  time  working  on  it  because  it  really  wasn't paying for
itself.  I slowly improved it, adding features, fixing bugs and trying to
squeeze  some  extra  speed out of it.  The speed part was tricky because
Liberty  BASIC  is  written  in  Smalltalk,  a  wonderful object oriented
language  that  isn't  known  for  speed of execution.  It wasn't a small
ZIP  file either at about 750K.  Most people still used 2400 baud modems,
and 750k was enormous in 1992.  It would take almost an hour to download.

Two  years  later  I  was  at  a  friend's house.  He was showing me some
software  on  his  computer.  I asked him if he'd seen the latest version
of  Liberty BASIC, and I told him that I had a copy with me.  After I had
run  Liberty  BASIC through its paces for him, he explained to me that he
had just taken a job at Ziff Davis Publishing.  He told me that he was in
a  position  to  offer  me  money for an exclusive promotional version of
Liberty  BASIC that they could give away on ZD-Net.  I was very surprised
and I found it hard to believe that my luck could be so good!

The  deal  did go through.  It made more money than Liberty BASIC made in
the  two  previous  years,  but I was still into the hole for a lot more.
But this was serious progress, so I didn't complain!

In  early  1995  I quit my full time job of 8 years to become a Smalltalk
contractor  for  IBM.   The  pay  was great, and I reasoned that when the
contract was done that I would have enough money saved to work for myself
for a few months.

I  uploaded  Liberty  BASIC  to  Ziff Davis' Author Upload Center to take
part  in  their  annual shareware awards competition.  It was exciting to
hear a couple of months later that Liberty BASIC was chosen as a finalist
in  the  programming tools category.  I was invited to attend SIC '95, an
annual  shareware  conference  in  Scottsdale, Arizona for the awards.  I
went,  and  even though I didn't win the award (CEnvi won), I had a great
time and made some contacts.

A   few  weeks after the conference I was contacted by NRI Schools.  They
discovered  Liberty BASIC on my Internet web site and decided that it was
just what they needed in their new Windows 95 course.  This was the break
that I needed.  We eventually worked out an arrangement and they put in a
large  order.   During  this time I was also working out deals with small 
distributors.   I  have  two  dealers  now and am working with some more.

Things  have  gone very well for Liberty BASIC, but it was a long time in
the making.  It was three and half years before I was able to quit my job
to  work  at  home.  I really believe that more people can do what I did,
but the kind of dialog that I read in most shareware related forums tells
me  that  most people give up too soon to generate any momentum (or to be
there for those seemingly lucky breaks).

There were times that I was starved for feedback(I HATE BEING STARVED FOR
INPUT),  and then there were those wonderful characters who would wake me
up in the middle of the night to give me bug reports and make suggestions.
No  sarcasm meant there!  I really need those devoted Liberty BASIC users
and their input so I can fix bugs and determine which way to take things.

Some  of the people I show Liberty BASIC ask me what it's like to compete
against Visual BASIC. I usually reply that I'm not trying to compete with
Microsoft.  Liberty  BASIC  is  an  end- user programming tool, sort of a
retro-BASIC. Some people seem to think that the whole idea is ridiculous,
but of course I can't afford to think that way.

I  learned the importance of presentation.  My first installation program
was  a text file that explained how to make a program group and create an
icon  for  Liberty BASIC.  Then I wrote a DOS program in Turbo BASIC that
copied  a  group  file  into  the  Windows  directory  and  modified  the
PROGMAN.INI  file.   Finally  I started using a real Windows installation
program and had real Windows help files instead of plain ASCII files.

A  key  word  in shareware is DISTRIBUTION.  A lot of time and energy was
spent just uploading Liberty BASIC to bulletin board systems all over the
country.   I even set up shop on a local BBS.  This was a limited success
until  the  Internet  started  taking  off.  A web site and ftp site were
critically  important  to marketing, and the ability to telnet to the BBS
reduced  the  expense to those who formerly had to call long distance. It
matters  a lot that the BBS is reliable (ours has had its ups and downs).

My wife has always been terrific through all this. I can't emphasize this
enough.  If you're married you need the support of your spouse.  Starting
a company is long hours and hard work, spending money that you have faith
will be recouped in the course of time. I won't discount my belief in God
either.  I need all the help I can get!

______________________________________________________________________________
| SECTION 1 PART B SUBPART 3 | Wrox Press Program |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Gee,  don't you go all weepy eyed when you see GWBASIC programs.. Nope, not
really,  but  here  you go, a couple of GWBASIC programs! :) Many thanks to
Adrian Sill of Wrox Press who contributed these to the fanzine.

First up we have the old computer game Animal Vegetable Mineral.. :) If you
are interested in Retro (old 1980s) games then check out our competition.

10 REM ANIMAL VEGETABLE MINERAL
20 REM Written by A.Sill
30 REM FOR WROX PRESS
40 REM (c) 1992
50 REM
60 DIM AVG$(5000)
70 SCREEN 9: CLS
80 A$ = "ANIMAL VEGETABLE MINERAL"
90 COLOR 2
100 LOCATE 2, (80 - LEN(A$)) / 2: PRINT A$
110 COLOR 10
120 COLOR 10: LOCATE 5, 1: PRINT "    Animal Vegetable Mineral is probably one of the simplest and earliest       programs to feature artificial intelligence. It asks you questions about an"
130 PRINT "animal, vegetable or a mineral which you have thought of. It then learns as the program continues - a feat not matched very often. The program is VERY simple   and very short, and is a great example of the use and power of arrays."
140 PRINT "    Press Q to quit at a (Y)es or (N)o prompt."
150 RAND = 0
160 LOCATE 20, 33: COLOR 12: PRINT "Press any key"
170 A$ = ""
180 A$ = INKEY$: RAND = RAND + .1: IF A$ = "" THEN 180
190 RAND = RAND - VAL(RIGHT$(TIME$, 2))
200 RANDOMIZE RAND
210 REM
220 N = 1: B = 1
230 AVG$(1) = "a carrot"
240 CLS
250 PRINT "Think of an Animal, Vegetable or a Mineral ";
260 FOR A = 1 TO 2000: IF (A / 400) = INT(A / 400) THEN PRINT ".";
270 NEXT A
280 IF AVG$(2 * N) <> "" THEN GOTO 430
290 PRINT : PRINT "Is it "; AVG$(N); " ?"
300 PRINT " (Y)es or (N)o ?"
310 A$ = INKEY$: IF A$ = "" THEN GOTO 310
320 IF A$ = "Y" OR A$ = "y" THEN PRINT : PRINT "   Phew - I got one right for once !": WHILE INKEY$ = "": WEND: GOTO 240
330 IF A$ = "Q" OR A$ = "q" THEN GOTO 520
340 IF A$ = "N" OR A$ = "n" THEN GOTO 360
350 GOTO 310
360 AVG$(2 * N) = AVG$(N)
370 PRINT : INPUT "Then what is it "; G$
380 AVG$(2 * N + 1) = G$
390 PRINT : PRINT "Give me a question that would be true for ";
400 PRINT AVG$(2 * N + 1); ", but false for "; AVG$(2 * N)
410 PRINT : INPUT "    : "; AVG$(N)
420 GOTO 240
430 PRINT : PRINT AVG$(N);
440 PRINT " (Y)es or (N)o ?"
450 B$ = INKEY$: IF B$ = "" THEN GOTO 450
460 IF B$ = "Q" OR B$ = "q" THEN GOTO 520
470 IF B$ = "Y" OR B$ = "y" OR B$ = "N" OR B$ = "n" THEN GOTO 480 ELSE GOTO 450
480 N = 2 * N + ABS(B$ = "Y" OR B$ = "y")
490 IF FRE(0) > 1000 THEN GOTO 280
500 PRINT "Ohhh no I'm getting confused - too much data !!!!"
510 WHILE INKEY$ = "": WEND
520 REM ********* RETURN TO MENU POSER
530 CLS
540 COLOR 12: PRINT : PRINT : PRINT "          Do you want to 1. Run again or": PRINT "                         2. Return to DOS ?."
550 LOCATE 3, 26: COLOR 7: PRINT "1"
560 LOCATE 4, 26: PRINT "2"
570 A$ = INKEY$: IF A$ = "" THEN GOTO 570
580 IF A$ = "1" THEN CLEAR : RUN
590 IF A$ = "2" THEN CLS : SYSTEM
600 GOTO 570

I'm afraid thats all I can add in for Wrox Press this week but we'll keep the
sources flowing next issue! :^)

Oh yes, remember to go and buy Revolutionary Guide to QBasic. I was reading
it last night and I actually learnt something. Very useful. The book is
well written out too.. Check out:    http://www.wrox.com/


______________________________________________________________________________
| SECTION 1 PART B SUBPART 4 | Simple game development |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
			   Game Development
			   ~~~~~~~~~~~~~~~~
			     Introduction
		       1-Before you get Started                                                               
			   2-Writing a Game
			 3-Tips and Reference

			     Introduction
			     ~~~~~~~~~~~~
   Making computer games is not as hard as it seems. In this article I'm
going to explain the basics of making games. This article will be tilted
towards simple games, but these steps are used in just about every game
ever made.

Section 1

Before you get started making a game you should have a few things.

Step 1. Planning
	1. An idea. This is the most important part of making a game.
	2. Once you have an idea, think up a storyboard. This is not necessary
	   always. For example, Tetris doesn't have a story.
	3. Now, plan the Levels. If the game has several levels, think how they
	   are going to look.
	4. After you have the basic concept, think about goals. There has to be
	   some kind of goals to make the player keep playing.

	5. Now think about the gameplay.  Gameplay makes a game.  Without gameplay
	   the game is boring.

	6. Finally think of little bonuses you can add.(Score, explosions, sounds,
	   animations, Level completion bonuses, Power-ups, etc.)  Use these to
	   spice the game up.

Step 2. Tools
	1. First, you're going to need a graphics program(unless it's a
	   text -adventure OR it's graphics are ASCII characters).  Personally
	   I suggest QBDRAW17(it's only Screen 13 though). There are several
	   graphics programs available(Check Simtel) or you could draw in Window's
	   Paint Brush or another commercial program(you'll need some GIF, PCX or
	   BMP code to load these though)

	2. Second, you're going to need some Algorithyms for Artificial
	   Intelligence. here's an Example,
	   In Space Invaders, the enemies algorithym was:
   
	   1. Go Right until Wall.
	   2. When hit wall go Left.
	   3. Go Left until Wall.
	   4. When hit wall go Right.
	   5. Move Down.
	   6. Loop back to step 1.

	3. Code for Input Devices. (Keyboard, Joystick, Mouse,etc.)  You can get
	   this just about anywhere.

	4. Music and Sound. There is nothing wrong with using the PC Speaker to do
	   sounds(Just don't put long and annoying Music that'll wake up your
	   parents at 3 AM) Remember, you can't adjust the PC Speaker's volume(at
	   least from the outside). If you're going to have Sound Blaster sounds,
	   find some libraries(it's not easy to write them yourself).


Section 2

Now we are going to write a Pong Game

{Cut here}
********************************************************
SCREEN 13: CLS                  'Screen with 256 colors
DIM Sphere(100)                 'Allocate memory for sprites
DIM Paddle(200)
PAINT (160, 100), 201           'Paint Background
CIRCLE (160, 100), 7, 4         'Draw Ball
PAINT (160, 100), 4             'Paint Ball
LINE (10, 10)-(18, 50), 1, BF    'Draw Paddle

GET (151, 92)-(169, 108), Sphere  'Get Sprites and store in array
GET (9, 4)-(19, 56), Paddle
CLS : PAINT (160, 100), 201       'Clear and Repaint screen
				  'Initialize Variables
p1 = 0: p2 = -1    'Scores
X = 1: Y = 1       'Ball's Location
X1 = 5: Y1 = 75    'Player 1's Location
X2 = 295: Y2 = 75  'Player 2's Location

DO WHILE INKEY$ <> CHR$(27)   'Begin Main Program Loop and loop until ESC
			      'is pressed.
LOCATE 1, 8: PRINT p1: LOCATE 1, 36: PRINT p2   'Print Scores

GOSUB Keys
IF X > 300 THEN Xadj = -2: p1 = p1 + 1: SOUND 200, 1 'See if Ball hits Side

IF X <= 1 THEN Xadj = 2: p2 = p2 + 1: SOUND 200, 1   'See if Ball hits Side

IF Y >= 180 THEN Yadj = -2: SOUND 200, 1             'See if Ball hits Top
IF Y <= 1 THEN Yadj = 2: SOUND 200, 1                'See if Ball hits Top

  FOR i = 1 TO 3               'Continously move Ball
    X = X + Xadj
    Y = Y + Yadj
    PUT (X, Y), Sphere, PSET
  NEXT i

  PUT (X1, Y1), Paddle, PSET   'Put Paddles
  PUT (X2, Y2), Paddle, PSET
  FOR q% = 1 TO 100            'Add Delay (Increase if game runs too fast)
  GOSUB Keys
  NEXT q%

 SELECT CASE Y   'If the Ball is within one of the Paddle's Y Range,
		'Compare it's X Location
   CASE (Y1 - 15) TO (Y1 + 30)
   GOSUB Precheck

   CASE (Y2 - 15) TO (Y2 + 30)
   GOSUB Precheck
 END SELECT

LOOP    'Main Program Loop

Precheck:        'Since the last Case found their Y location similiar, It
SELECT CASE X    'checks their X locations. If it's in range, contact occurs.

  CASE X1 TO (X1 + 10)      'Reverse Ball's X direction and play Sound to show
  Xadj = 2: SOUND 37, 1    'contact occured
			 
  CASE (X2 - 10) TO X2      'Reverse Ball's X direction and play Sound to show
  Xadj = -2: SOUND 37, 1   'contact occured
END SELECT
RETURN


Keys:
 SELECT CASE INKEY$                'Get Input from Keyboard
  CASE IS = CHR$(0) + CHR$(72)     'Player 1 Up
  GOSUB up

  CASE IS = CHR$(0) + CHR$(80)     'Player 1 Down
  GOSUB Down

  CASE IS = "Q", "q"               'Player 2 Up
  GOSUB Up2

  CASE IS = "A", "a"               'Player 2 Down
  GOSUB Down2
 END SELECT
RETURN

Down:                        'Move First Player Down
  IF Y1 < 142 THEN           'Makes sure Paddle doesn't go Offscreen
   FOR i = 1 TO 3            'Make Animation Smooth
    Y1 = Y1 + 3
    PUT (X1, Y1), Paddle, PSET
    Y1 = Y1 + 3
   NEXT i
  END IF
RETURN       'Go back to Main Program


Down2:                       'Move Second Player Down
  IF Y2 < 142 THEN           'Makes sure Paddle doesn't go Offscreen
   FOR i = 1 TO 3            'Make Animation Smooth
    Y2 = Y2 + 3
    PUT (X2, Y2), Paddle, PSET
    Y2 = Y2 + 2
   NEXT i
  END IF
RETURN        'Go back to Main Program

up:                          'Move First Player Up
  IF Y1 > 6 THEN             'Makes sure Paddle doesn't go Offscreen
    FOR i = 1 TO 3           'Make Animation Smooth
     Y1 = Y1 - 3
     PUT (X1, Y1), Paddle, PSET
     Y1 = Y1 - 3
    NEXT i
  END IF
RETURN         'Go back to Main Program

Up2:                     'Move Second Player Up
  IF Y2 > 6 THEN         'Makes sure Paddle doesn't go Offscreen
    FOR i = 1 TO 3       'Make Animation Smooth
     Y2 = Y2 - 3
     PUT (X2, Y2), Paddle, PSET
     Y2 = Y2 - 3
    NEXT i
  END IF
RETURN         'Go back to Main Program

*******************************************************
{cut here}


Section 3

Remember, don't try to over-achieve yourself on your First game.
In other words, On your first try, make something like Pac-Man, not DOOM.

A game can be broken down in a few sections

1. The Game World and it's Data
2. The Graphics Engine(Which draws the sprites on the screen)
3. The Input/Output System(Whether it's the Keyboard, Joystick or Mouse)       
4. The Game's Artificial Intelligence System
5. The Main Game Loop(The Loop that continously loops during the game)
6. The User Interface(Title Screen, Options, Score, Lives, Energy, etc.) 
7. The Sound Effects system(Spices up the Gameplay)

Any Questions should be directed to me at: diego@sgi.net

Check out my NEW and Constantly updated Web Page at:

Http://www.geocities.com/SiliconValley/6165/

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-------------------------------------------------------------------------------
- SECTION TWO -----------------------------------------------------------------
-------------------------------------------------------------------------------
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 All levels articles:

 This is where general BASIC info is presented. People of different levels
 (novice,advanced etc) can use this section to their benefit.
______________________________________________________________________________
| SECTION 2 SUBPART 1 | Useful Resources ON THE NET!!! |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 FTP SITES:


	PCGPE (Pc Games Programmers Encyclopedia) -
			   this is a VERY VERY good set of text files about
			   programming (not just games), learn about sound
			   + grafix + mouse etc. VGood. 700k though.
			   x2ftp.oulu.fi
			    /pub/msdos/programming/gpe

        Great BASIC site - (usually filled with neat tricks and goodies!)
                           I do like this site, I rarely visit it but when I
                           do I really like what I see, well done! :)
			   FTP SITE :    users.aol.com
					 /blood225

        SimTel Mirrors  -  Simtel is a large organization who have a wealth
                           of files for the public including files for BASIC.
                           Simtel sites (mirrors) are available all around the
                           world, there are lots of them. Here are two:
			   look at

			   ftp.coast.net        (U.S.)
			    /Simtel/msdos/basic
                           ftp.demon.co.uk      (Uk\Europe)
                            /pub/simtel/msdos/basic
                                             /qbasic

			   Archives of the fanzine are available on the
			   SimTel Mirror sites now! in the BASIC directory
			   If you want to find the fastest simtel for you
			   then check out Douggie Greens FAQ! :)

	Games Programmers site- oulu -
			   x2ftp.oulu.fi
			   /pub/msdos/programming/docs
						 /formats
						 /gpe
                                                 /faq
			   This directory /programming is a directory
			   all for you game programmers out there, check it
			   out. There's info on loads of file formats etc..
			   In the /gpe directory is the programmers 
			   encyclopedia.. loads of format and programs!

 HTML\WWW SITES:

  All of these WWW pages are to do with BASIC or rather, they have things of
  use to BASIC programmers.

  Wrox Press        -  http://www.wrox.com/
  Jumbo shareware   -  http://www.jumbo.com/
  PBSOUND WWW site  -  http://www.snafu.de/~pbsound/
  ABC page removed until final location decided upon

 If you know of any others then please tell me and it'll be added, if you 
 actually own\run the site then please include some info about it and I'll
 check it out. I'm offering a bit of free advertising here.. :)

______________________________________________________________________________
| SECTION 2 SUBPART 2 |  BASIC Hints   |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Steven Sensarn who is one of the knowledged and experienced people on the BASIC
newsgroups has helped to compile this hint list for BASIC. I thought this
would provide useful titbits of information that maybe some of you didn't
know. I've learnt a lot in the past from even simple things such as this.. :)
Hopefully this hint list will get up to 101 tips and would make a great
basic resource for the intermediate user.

                                THE HINT LIST (part 1)
				~~~~~~~~~~~~~

1)    There is no need for a CLS after changing screen modes.

2)    Place "&" after hex integers to make them long (UNSIGNED)

3)    Never call absolute code without RETF

4)    Labels dont always have to be numbers

5)    Don't use longs or singles/doubles unless you really have to

6)    Breaking/Continuing code in mode 13h messes up colors

7)    Mode 12H uses color planes, not pixel planes

8)    Bmp's are not easy to load

9)    Never use bios keyboard handling in fast action games

10)   Do not pass over a segment boundary with near\far pointers

11)   Using LINE ()-(),0,BF is quicker than CLS in many scenarios

12)   To scroll a screen then you can just PRINT on the bottom line of it


Thank you Sensarn for many of them. Unfortunately Sensarn is not available
on the net anymore (afaik) :( , the basic newsgroups have lost a good member.

______________________________________________________________________________
| SECTION 2 SUBPART 3 | Competition!!!  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you read the introduction to the fanzine then you will have got the jist
of this competition. But let me go into it.

The latest competition is to write a retro game in QBasic or a compatable
language (ASIC is fine) and then send it in and the winner will be flooded
with prizes! :^)

Here are six suggestions:
	- Centipede             (the one where you shoot the 'pede coming)
	- Space Invaders        (you MUST know what this is)
	- Pong                  (the bat and ball game)
	- Defenders             (where you fly a ship above a planet)
	- Asteroids             (the rotate, thrust, and get the ufo game)
	- Text Adventure        (any type of TEXT adventure)

If you want to enter then the deadline is 30th June . Judging will be done
on the 1st and 2nd of July and then the winner will be announced in Fanzine
6 or 7 which will be released only a little while after.

The winner will be flooded with useful programming prizes. You have to enter
to find out what! :^) Although, I'll tell you one.. If it is really good then
I'll compile it (if you cannot do that) and you'll get a free copy of the
QBasic compiler I'm writing (when it actually gets done), besides more. :)
But really the competition is for fun! :)

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
- SECTION THREE ---------------------------------------------------------------
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 Your Shout:

 Anything that is sent for use for the zine that doesn't fit into the other
 chapters is here. It's where your questions and programs go unless they fit
 into an article or if you actually write an article or tutor.

______________________________________________________________________________
| SECTION 3 SUBPART 1 |  Q+A  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        It seems that everyone out there is a genius at qbasic programming
and dont need to ask questions! Well this is the last month that Q+A will be
a permanent part of the fanzine. I wish to use the space for more sources etc.
But if you have a question then send them in and I'll put them in here.

QUESTION: Hello,
      
 Can you please write me a little program that will show me how to use and
 what they are used for?

 NOTE ::: Please write me a program that will show me what the X's are suspose
 to be.  Also tell me what each of them does.

 TYPE (XxXxXxX)
     (XxXxXxX) as (XxXxXxX)
 END TYPE
 and 
 DIM (XxXxXxX) as (XxXxXxX)
 or
 REDIM (XxXxXxX) as (XxXxXxX)

ANSWER: Ok. The things you are mentioning here are records (thats what I call
        them) This would be simpler with explanation.

        TYPE person
                age as integer
                name as string * 20
                address as string * 80
        END TYPE

        This is a 'type' for one person.. It is a defined type. To be able to
        enter data in it properly then you need to DIM it like so:

        DIM SHARED people as person

        Now you can enter data into it like so:

        people.age = 52
        people.name = "fred bloggs"
        people.address = "Topeka City, Winconsin etc.."

        Of course, you can file these to disk using the PUT command, refer
        to qbasic help. You can also declare arrays of these types:

        DIM SHARED people(50) as person

        This would generate '50 people' and you can edit their details etc:

        people(1).age = 25
        people(1).name = "john"
        people(2).age = 50
        people(2).name = "bert"
        etc...

        These are powerful tools.. you can even use them in games, such as
        adventure games where you need to keep track of what screen a certain
        direction goes to (this is just an example and not neccesarily the
        best way to do it):

        TYPE location
                title as string * 50
                ident as integer
                picfile as string * 12
                north as integer
                south as integer
                west as integer
                east as integer
        END TYPE

        If anyone needs more help then please mail me, or post to the basic
        newsgroups.
______________________________________________________________________________
| SECTION 3 SUBPART 2 |  Your Programs  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We have a great bundle of programs this issue! :) The format for every
piece of work is

	From:  Whoever it is from
	Program\Subroutine\Function Type
	A description
	The program

I hope you enjoy this weeks programs:

______________________________________________________________________________
From: Marco Koegler <marco@umr.edu>
PROGRAM

Description:
~~~~~~~~~~~~
The following program has been taken out of the VBDOS Programmers Guide. 
I  have  added the Verify function, which is actually quite unnecessary, 
but  hey,  who  knows,  maybe  someone  would  like to do a byte-to-byte 
comparison  after copying a file.  It takes a while though, that's why I 
have  added the counter.  I have also altered the program so it will run 
in MS-DOS QBasic.


DECLARE FUNCTION BinaryCopy% (SourceName$, TargetName$)
DECLARE FUNCTION Verify% (SourceName$, TargetName$)
CLS
PRINT "Please answer the following with complete path"
INPUT "Source File:"; SourceName$
INPUT "Target File:"; TargetName$
IF BinaryCopy(SourceName$, TargetName$) THEN
    PRINT "Finished copying file!"
    ELSE PRINT "An error has ocurred during filetransfer!"
    END IF
PRINT "Press V if you would like to do a byte-to-byte comparison!"
PRINT "This may take a while!"
a$ = INPUT$(1)
IF a$ = "v" OR a$ = "V" THEN
    IF Verify(SourceName$, TargetName$) THEN
    PRINT "Copy was succesful!"
    ELSE PRINT "An error has ocurred during filetransfer!"
    END IF
END IF
SYSTEM

FUNCTION BinaryCopy% (SourceName$, TargetName$)
BinaryCopy = 0
OPEN SourceName$ FOR BINARY AS #1
OPEN TargetName$ FOR BINARY AS #2
IF LOF(2) <> 0 THEN
	CLOSE #2
	KILL TargetName$
	OPEN TargetName$ FOR BINARY AS #2
	END IF
DIM ByteBuffer AS STRING
' This will determine the number of big chunks (30000 byte pieces) the program
' can copy
ByteBuffer = STRING$(30000, " ")
BigChunks% = LOF(1) \ LEN(ByteBuffer)
LeftOver% = LOF(1) MOD LEN(ByteBuffer)
' The next few lines copy the big chunks
FOR ind% = 1 TO BigChunks%
    GET #1, , ByteBuffer
    PUT #2, , ByteBuffer
NEXT ind%
' If there should be a leftover, then redimension the buffer and copy it
IF LeftOver% THEN
    ByteBuffer = ""
    ByteBuffer = STRING$(LeftOver%, " ")
    GET #1, , ByteBuffer
    PUT #2, , ByteBuffer
END IF
IF LOF(1) = LOF(2) THEN BinaryCopy = -1 ' Simple error check
CLOSE
EXIT FUNCTION
END FUNCTION

FUNCTION Verify% (SourceName$, TargetName$)
Verify = 0
OPEN SourceName$ FOR BINARY AS #1
OPEN TargetName$ FOR BINARY AS #2
DIM ByteBuffer1 AS STRING
DIM ByteBuffer2 AS STRING
ByteBuffer1 = STRING$(1, " ")
ByteBuffer2 = STRING$(1, " ")
DO
GET #1, , ByteBuffer1
GET #2, , ByteBuffer2
IF ByteBuffer1 <> ByteBuffer2 THEN
    BEEP
    CLOSE
    EXIT FUNCTION
    END IF
LOCATE 10, 1: PRINT "               "
LOCATE 10, 1: PRINT INT(LOC(1) / LOF(1) * 100); "% complete"
LOOP UNTIL EOF(1)
Verify = -1
CLOSE
END FUNCTION

______________________________________________________________________________
From: garlans@usa.pipeline.com (White Shade)
SUBROUTINES
Description:
~~~~~~~~~~~~

The first subroutine 'centerprint' is used to print some text passed to it
in text$ on the row passed to it in  row . It centres the text on that row
in any text screen mode that QBasic is capable of.

The second routine is used to set the palette. This can be very effective.
It works in nearly all screen modes. If you do not understand a palette then
it may not be of much use but what it allows you to do is set the red,green
and blue values for any colour. Even black.. so you can change the background
to bright red instantly! :)

SUB centerprint (text$, row) 
sl = LEN(text$) 
col = 40 - (sl \ 2) '20=40 column display..40=80 column display. 
LOCATE row, col 
PRINT text$; 
END SUB 
 
SUB setpal (reg, RED, GREEN, BLUE) STATIC 
  OUT &H3C8, reg 
  OUT &H3C9, RED 
  OUT &H3C9, GREEN 
  OUT &H3C9, BLUE 
END SUB 

_____________________________________________________________________________
From: "Daniel P Hudson" <afn03257@afn.org>
FUNCTIONS
Description:
~~~~~~~~~~~~

Two of these functions deal with communications. There is a communications
port initializer, and a FIFO buffer creator. There is also a trunc routine
that is described in the remarks in detail.

DECLARE FUNCTION ComInit% (port%, bps&, status%)
DECLARE FUNCTION FIFO% (BasePort%)
DECLARE FUNCTION TRUNC% (F AS STRING, Position AS LONG)

' $INCLUDE: 'QB.BI'

' VBDOS/PDS Users need make proper adjustments to Include file and the
' line that obtains the string address, change VARSEG($) to SSEG($)
' where applicable in the TRUNC% function.

' Constant definition for status% argument to Cominit are listed below
' Line 1 is for parity
' Line 2 is for Stop Bits
' Line 3 for word length
' the value passed is derived by OR ing the proper values togather

CONST None% = 0, Even% = 24, Odd% = 8, Mark% = 40, Space% = 56
CONST One% = 0, Two% = 4
CONST Five% = 0, Six% = 1, Seven% = 2, Eight% = 3

'----------------------------------------------------------------------------
X% = ComInit%(1, 38400&, None% OR One% OR Eight%)
IF FIFO(X%) THEN PRINT "FIFO Enabled" ELSE PRINT "FIFO not enabled"

A$ = "HELLO.TXT"
OPEN A$ FOR OUTPUT AS #1
PRINT #1, STRING$(2000, "!")   ' fille string with 2000 !'s
CLOSE #1
X% = TRUNC%(A$, 30)            ' truncate down to 30 bytes
IF X% THEN
  PRINT "ERROR opening File " + A$
ELSE
  OPEN A$ FOR INPUT AS #1
  PRINT A$ + " Length:"; LOF(1)
  CLOSE #1
END IF
KILL A$
END


 '**************************************************************************
 '* ComInit%() is a function designed to set the BPS rate, type of parity, *
 '*            # of stop bits, and word length as specified by the         *
 '*            arguments passed. It supports COM 1-4 which is passed as    *
 '*            port%. bps& is simply the BPS rate to set the UART at.      *
 '*            All other access can be handled through                     *
 '*            OPEN "COMn" FOR ACCESSTYPE AS #n                            *
 '**************************************************************************
FUNCTION ComInit% (port%, bps&, status%)

  Offset% = (port% - 1) * 2            ' get offset in bios
  baud$ = MKI$(CINT(115200 \ bps&))     ' calculate baud rate divisor
  
  ' retrieve cam port bas i/o address from BIOS, COM 1-4 supported
  DEF SEG = &H40
  Offset% = CVI(CHR$(PEEK(Offset%)) + CHR$(PEEK(Offset% + 1)))
  DEF SEG

  ' set BPS, Parity, stop bits, and wordlen
  OUT Offset% + 3, 128  ' set DLAB
  OUT Offset%, ASC(baud$)
  OUT Offset% + 1, ASC(RIGHT$(baud$, 1))
  OUT Offset% + 3, status%

  ' return Comport base I/O address for other functions.
  ComInit% = Offset%

END FUNCTION

FUNCTION FIFO% (BasePort%)
 bp% = INP(X%)                      ' clear any left over data
 OUT BasePort% + 2, &H7             ' Init fifo buffer
 bp% = INP(BasePort% + 2) AND &HC0  ' Get return value
 FIFO% = bp%                        ' 0 indicate NO FIFO Available
END FUNCTION

'+------------------------------------------------------------------------+
'|                                                                        |
'| FUNCTION TRUNC, truncates a file at the length specified in the        |
'| parameter position. The filename optionally including the full path,   |
'| is specified as parameter F. The file should not be opened without     |
'| sharing when calling this function, just close it to be sure.          |
'|                                                                        |
'| On a successful execution TRUNC returns 0                              |
'| Error Values for TRUNC with short explanations follow :                |
'|                                                                        |
'| 2 - File not Found                                                     |
'| 3 - Path not found                                                     |
'| 4 - Too many opened files                                              |
'| 5 - Access Denied, F$ is directory, volume header, or read-only        |
'| 6 - Invalid Access, File is on a network drive that has not granted    |
'|     proper Access permission. Not a likely problem for what we want to |
'|     do.                                                                |
'+------------------------------------------------------------------------+
FUNCTION TRUNC% (F AS STRING, Position AS LONG)

  SWAP$ = MKL$(Position)
  High% = CVI(RIGHT$(SWAP$, 2))
  Low% = CVI(LEFT$(SWAP$, 2))


  DIM RegI AS RegTypeX, RegO AS RegTypeX
  F = F$ + CHR$(0)
  FSEG% = VARSEG(F$)
  FPTR% = SADD(F$)

  ' OPEN FILE
  RegI.ax = &H3D02
  RegI.dx = FPTR%
  RegI.ds = FSEG%
  CALL INTERRUPTX(&H21, RegI, RegO)
  IF (RegO.flags AND 1) THEN
		TRUNC = RegO.ax
		EXIT FUNCTION
  ELSE Handle% = RegO.ax
  END IF

  'MOVE FILE POINTER
  RegI.ax = &H4200
  RegI.bx = Handle%
  RegI.cx = High%
  RegI.dx = Low%
  CALL INTERRUPTX(&H21, RegI, RegO)

  'TRUNCATE FILE
  RegI.ax = &H4000
  RegI.bx = Handle%
  RegI.cx = 0
  CALL INTERRUPTX(&H21, RegI, RegO)

  ' CLOSE FILE
  RegI.ax = &H3E00
  CALL INTERRUPTX(&H21, RegI, RegO)

  TRUNC = 0

END FUNCTION

_____________________________________________________________________________
From: "Steven Sensarn" ( Internal note : FILL THIS OUT AND FILL IT IN )
FUNCTIONS
Description:
~~~~~~~~~~~~
The following piece of code may be very useful to some of you QBasic Games
programmers out there. This code will display a 320x240 PCX in Mode X.
Notice the // before the remarks.. I detect a C++ presence here! :^)
Well, Sensarn is a C++ programmer too, so ok..

'//MODEXPCX.BAS -- CREATED IN QBASIC 1.1 BY STEVEN SENSARN
'//SPEED HAS BEEN COMPROMISED FOR SIZE

'//FUNCTION PROTOTYPES
DECLARE SUB X.PLANE (P AS INTEGER) 'USE THIS TO CHANGE PLANES
DECLARE SUB X.PIXEL (X AS LONG, Y AS LONG, CLR AS INTEGER) 'PLOTS PIXEL
DECLARE SUB MODEX () 'CHANGES TO MODE X 320x240x256
DECLARE SUB WAIT.KEY () 'PRESS ANY KEY TO CONTINUE
DECLARE SUB OPEN.FILE () 'USED TO LOAD THE PCX FILE

'//STRUCTURES
TYPE THEADER
    MAN AS STRING * 1 'MANUFACTURER -- 10
    VER AS STRING * 1 'VERSION -- 5+
    ENC AS STRING * 1 'ENCODING -- 1 (RLE)
    BPP AS STRING * 1 'BITS PER PIXEL PER PLANE -- 8
    MNX AS INTEGER 'MINIMUM X SIZE
    MNY AS INTEGER 'MINIMUM Y SIZE
    MAX AS INTEGER 'MAXIMUM X SIZE
    MAY AS INTEGER 'MAXIMUM Y SIZE
    HRS AS INTEGER 'HORIZONTAL RESOLUTION
    VRS AS INTEGER 'VERTICAL RESOLUTION
    COL AS STRING * 48 'EGA COLOR PALETTE -- IGNORE
    RES AS STRING * 1 'RESERVED
    NMP AS STRING * 1 'NUMBER OF PLANES -- 1
    BPL AS INTEGER 'BYTES PER SCANLINE
    PAL AS INTEGER 'PALETTE INFO -- IGNORE
    FIL AS STRING * 58 'FILLUP SPACE
END TYPE

'//VARIABLE DECLARATIONS
DIM BYTE AS STRING * 1 'USED TO READ BYTES
DIM HEADER AS THEADER 'USED FOR HEADER INFORMATION
DIM FILE AS STRING * 50 'USED TO HOLD FILE NAME
DIM INDEX AS LONG 'USED TO CONTROL DECODING
DIM SIZE AS LONG 'USED TO CONTROL DECODING
DIM XSIZE AS INTEGER, YSIZE AS INTEGER 'USED TO MEASURE IMAGE
DIM TOTALBYTES AS INTEGER 'USED TO MEASUER SCAN LINES
DIM VALUE AS INTEGER 'USED FOR CONVERTING CHAR TO INT
DIM RLP 'USED FOR RUN LENGTH LOOP
DIM X AS LONG, Y AS LONG 'USED FOR PIXEL TRACKING

'//VARIABLE INITIALIZATIONS
INDEX = 1 'BE ON THE SAFE SIDE

'//MAIN
ON ERROR GOTO ERROR.HANDLER 'JUST IN CASE...

CLS
CALL OPEN.FILE 'OPEN THE FILE

GET #1, 1, HEADER 'LOAD HEADER

'//BASIC TEST (NOT FOOL-PROOF) -- REQUIREMENTS
IF ASC(HEADER.MAN) <> 10 THEN CLOSE #1: END 'NOT PCX
IF ASC(HEADER.VER) < 5 THEN CLOSE #1: END 'NOT 256 COLOR
IF ASC(HEADER.ENC) <> 1 THEN CLOSE #1: END 'NOT RLE
IF ASC(HEADER.NMP) <> 1 THEN CLOSE #1: END 'NOT SUPPORTIVE OF MODE X PLANES

'//LOAD WHILE LOOP INFORMATION
XSIZE = HEADER.MAX - HEADER.MNX + 1 'LOAD HORIZONTAL GRAPHIC SIZE
YSIZE = HEADER.MAY - HEADER.MNY + 1 'LOAD VERTICAL GRAPHIC SIZE
TOTALBYTES = HEADER.BPL 'USED TO TRACK END-OF-SCANLINE
SIZE = 1& * XSIZE * YSIZE 'LOAD SIZE -- FORCE LONG
IF SIZE > 76800 THEN CLOSE : END 'GRAPHIC TOO LARGE -- WON'T FIT ON SCREEN

'//DISPLAY STATUS TO THE USER
CLS : SCREEN 0: WIDTH 80
PRINT "FILENAME: ", , " "; FILE: PRINT
PRINT "MANUFACTURER: ", ASC(HEADER.MAN)
PRINT "VERSION: ", , ASC(HEADER.VER)
PRINT "RLE ENCODING: ", ASC(HEADER.ENC)
PRINT "BITS PER PIXEL PER PLANE: ", ASC(HEADER.BPP)
PRINT "WINDOW X MIN: ", HEADER.MNX
PRINT "WINDOW Y MIN: ", HEADER.MNY
PRINT "WINDOW X MAX: ", HEADER.MAX
PRINT "WINDOW Y MAX: ", HEADER.MAY
PRINT "HORIZONTAL RESOLUTION: ", HEADER.HRS
PRINT "VERTICAL RESOLUTION: ", HEADER.VRS
PRINT "NUMBER OF PLANES: ", ASC(HEADER.NMP)
PRINT "BYTES PER LINE: ", HEADER.BPL
PRINT
IF NOT HEADER.HRS / 320 = INT(HEADER.HRS / 320) THEN
    PRINT "ASPECT RATIO MISMATCH ", " -- X AXIS" 'WARPED IMAGE -- NO BIG DEAL
ELSE
    PRINT
END IF
IF NOT HEADER.VRS / 240 = INT(HEADER.VRS / 240) THEN
    PRINT "ASPECT RATIO MISMATCH ", " -- Y AXIS" 'WARPED IMAGE -- NO BIG DEAL
END IF
WAIT.KEY 'PRESS ANY KEY TO CONTINUE
MODEX 'SWITCH TO MODE X -- 320x240x256
DEF SEG = &HA000 'VIDEO MEMORY ACCESS

'//DECODE AND DISPLAY
WHILE INDEX <= SIZE 'WHILE PICTURE ISN'T DONE LOADING...
    GET #1, , BYTE 'READ BYTE
    IF (ASC(BYTE) AND &HC0) = &HC0 THEN 'TEST TOP TWO BITS FOR 1'S
	RLP = ASC(BYTE) AND &H3F 'SET RUN LENGTH
	GET #1, , BYTE 'READ DATA BYTE
	WHILE RLP > 0 'WHILE RUN LENGTH HAS NOT YET FINISHED DUPLICATION
	    IF NOT X > XSIZE THEN CALL X.PIXEL(X, Y, ASC(BYTE)) 'PLOT PIXEL
	    X = X + 1 'RENEW PIXEL POSITION
	    IF X >= TOTALBYTES THEN X = 0: Y = Y + 1 'TEST FOR END OF SCANLINE
	    RLP = RLP - 1 'REDUCE RUN LENGTH LOOP VARIABLE
	    INDEX = INDEX + 1 'INCREASE TOTAL
	WEND
    ELSE 'IF THE BYTE IS NOT ENCODED
	IF NOT X > XSIZE THEN CALL X.PIXEL(X, Y, ASC(BYTE)) 'PLOT PIXEL
	X = X + 1 'RENEW PIXEL POSITION
	IF X >= TOTALBYTES THEN X = 0: Y = Y + 1 'TEST FOR END OF SCANLINE
	INDEX = INDEX + 1 'INCREASE TOTAL
    END IF
WEND

'//CHANGE PALETTE
GET #1, LOF(1) - 768, BYTE
IF ASC(BYTE) <> 12 THEN CLOSE : END 'NO 256 COLOR PALETTE
FOR INDEX = 0 TO 255
  OUT &H3C6, &HFF 'INITIALIZE VGA PALETTE
  OUT &H3C8, INDEX 'SELECT COLOR INDEX
  GET #1, , BYTE
  OUT &H3C9, INT(ASC(BYTE) / 4) 'SEND RED VALUE -- ONLY NEED TOP 6 BITS
  GET #1, , BYTE
  OUT &H3C9, INT(ASC(BYTE) / 4) 'SEND GREEN VALUE -- ONLY NEED TOP 6 BITS
  GET #1, , BYTE
  OUT &H3C9, INT(ASC(BYTE) / 4) 'SEND BLUE VALUE -- ONLY NEED TOP 6 BITS
NEXT INDEX
SOUND 3000, .25 'DONE -- YOU WILL NOT SEE THE 'PRESS ANY KEY TO CONTINUE'
END

'//ERRORS
ERROR.HANDLER:
SCREEN 0: WIDTH 80
CLS
PRINT : PRINT "SOMETHING HAS OCCURED IN THE PROGRAM THAT HAS"
PRINT "CAUSED IT TO HALT.  TERMINATING..."
WAIT.KEY
END

'//DONE
CLOSE #1 'CLOSE THE FILE
SOUND 3000, .25 'SIGNAL USER
END 'END THE PROGRAM

'//NOTICE
'I HAVE ABSOLUTELY NO EXPERIENCE WITH PLANE BASED PCX FILES BECAUSE I USE
'MICROSOFT WINDOWS 3.1 PAINTBRUSH AND I CAN'T SEEM TO CREATE ONE.  IF
'ANYBODY WOULD BE WILLING TO DRAW ME ONE THAT USES PLANES, I WOULD GREATLY
'APPRECIATE IT.  SENT TO "txs53132@bayou.uh.edu" VIA BINHEX OR MIME.

SUB MODEX
    SCREEN 13
    DEF SEG = &HA000
    OUT &H3C4, &H4
    OUT &H3C5, &H6
    OUT &H3C4, &H2
    OUT &H3C5, &HF
    CLS
    OUT &H3D4, &H14
    OUT &H3D5, &H0
    OUT &H3D4, &H17
    OUT &H3D5, &HE3
    OUT &H3C2, &HE3
    OUT &H3D4, &H11
    OUT &H3D5, &H2C
    OUT &H3D4, &H6
    OUT &H3D5, &HD
    OUT &H3D4, &H7
    OUT &H3D5, &H3E
    OUT &H3D4, &H10
    OUT &H3D5, &HEA
    OUT &H3D4, &H11
    OUT &H3D5, &HAC
    OUT &H3D4, &H12
    OUT &H3D5, &HDF
    OUT &H3D4, &H15
    OUT &H3D5, &HE7
    OUT &H3D4, &H16
    OUT &H3D5, &H6
END SUB

SUB OPEN.FILE
+    SHARED FILE AS STRING * 50
    PRINT "<>/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\<>"
    PRINT "<> PLEASE NOTE THAT THE FILE THAT IS TO BE LOADED MUST HAVE A   <>"
    PRINT "<> SIZE NO LARGER THAN 320x240.  IF YOU WOULD LIKE TO TERMINATE <>"
    PRINT "<> THIS PROGRAM, DO SO ENTERING AN EMPTY FILENAME.              <>"
    PRINT "<>\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/<>"
    PRINT
    INPUT "FILENAME: ", FILE
    FILE = RTRIM$(FILE)
    FILE = UCASE$(FILE)
    IF NOT RIGHT$(RTRIM$(FILE), 4) = ".PCX" THEN END 'NO VALID EXTENSION
    OPEN FILE FOR BINARY AS #1
    IF LOF(1) = 0 THEN CLOSE #1: KILL FILE: END 'FILE EMPTY OR NOT FOUND
END SUB

SUB WAIT.KEY
  WHILE LEN(INKEY$) = 0: WEND
END SUB

'//ASSUMING CURRENT SEGMENT IS A000:0000H
SUB X.PIXEL (X AS LONG, Y AS LONG, CLR AS INTEGER)
    CALL X.PLANE(X AND 3)
    POKE INT(Y * 80 + X / 4), CLR
END SUB

'//USED TO CHANGE PLANE
SUB X.PLANE (P AS INTEGER)
    OUT &H3C4, 2
    OUT &H3C5, 2 ^ P
END SUB

A good lot of programs. You asked for source and you got it! :)

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
- SECTION FOUR ----------------------------------------------------------------
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
 Details about the fanzine:

  This section has been cut down this week to allow room for more goodies! :)

______________________________________________________________________________
| SECTION 4 SUBPART 1 |  Latest Developments  | 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hopefully soon there will be a specialized reader for the fanzine.. You will
be able to download it from my web site, or from an ftp site.. You can feed
the fanzine into it and then have a nice interface to get programs out of
it and all sorts! :)

i)   Web Sites
 The WWW site for issues of the fanzine is:
	http://www.teleport.com/~ericksnj/fanzine/

 To get downloadable text versions of the fanzine then please go to:
	http://www.geocities.com/RodeoDrive/2238/fanload.html

ii)  Mailing List
 To join mailing list   :
				arelyea@vt.edu 
 with the following line in the subject header:

     subscribe basix-fanzine

 Any text in the body of the message will be ignored. 

If you would like to see further developments to the fanzine then please give
me some ideas! :-)
______________________________________________________________________________
| SECTION 4 SUBPART 2 |  How do you contribute?  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 So how do you contribute?
 All you have to do is e-mail all of your source code\articles and ideas to:

                peco@trenham.demon.co.uk   - with enquiries
		bmag@trenham.demon.co.uk    - with Q+A, articles, source

______________________________________________________________________________
| SECTION 4 SUBPART 3 |  How do you contact the author?  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It's simple, you can just mail me at:
                peco@trenham.demon.co.uk  

______________________________________________________________________________
| SECTION 4 SUBPART 4 |  Credits  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Greets go to (in no real order) :

   Adrian Sill, Wrox Press
    for contributing some of his own source to the fanzine, hopefully we will
    put more of it into the next fanzine
    (adrians@wrox.com)
   
   James Erickson,
    who's cool but doesn't read the basic newsgroups :(.... and the web site
    guy
    snake@bendnet.com

   Tony Relyea,
    who is the maintainer of the mailing list and owns Russian-under Ware
    ,a software company, strangely enough!  (arelyea@vt.edu)

   Douggie Green,
    author of the two great FAQ documents - the newsgroup one and the code one
    (douggie@blissinx.demon.co.uk)
   
   Other people who wrote to me and who contributed code, gave me ideas or
   helped in any way:
    The few people on #basic  (IRC)
    John Woodgate
    Marco Koegler
    Wrox Press generally
    Garlans (white shade)
    Alex Demko
    SWAG team
 
 Remember that this fanzine relies on your contributions. Cheers, ;-)

______________________________________________________________________________
| SECTION 4 SUBPART 5 |  Last Words+Next month  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 I don't know why I keep promises.. :) In the last fanzine I said there would
 be a bit about binary in this 'zine but there wasn't.. Basically there wasn't
 enough room because of all the brilliant source I had received!

 NEXT TIME (May 1996):
	SPECIALIZED ARTICLES:
		[Advanced\Intermediate]
                3D article part 2 (I'll write it if noone offers)
                CD programming part 2 
		[Novice]
                Basic Tutorial  
	ALL LEVELS ARTICLES:
		WWW pages and FTP sites
                The Interviews with the BASIC Gurus! (NEW!!)
	YOUR SHOUT:
		Your Questions, Answers and programs
	DETAILS ABOUT THE FANZINE:
		How to contribute, and the usual stuff
                Rundown on the Issue 7 fanzine.

 Last words:

 Well, I'm rather disappointed with my delay in getting this issue out :(
 A number of contributing factors did not help but hey I'm not making excuses!
 It's been fun as usual and in the next issue we should see some great stuff
 because 'The Interviews with the BASIC Gurus!' will be there. What that will
 be is BASIC Gurus from all over the world will be interviewed especially for
 the fanzine. All we have to do is contact them and talk to them! People
 who we think would be good for interview include  Douggie Green, Ben Ashley
 and Dave Navarro. If I have missed you off the list and you think you
 deserve to be there then mail me, I might have already thought of you! :)
 Anyway, have fun.. Now that I have this darn computer sorted I _AM_ going
 to release the fanzine in a months time! :) I must say that I dont think
 this is the best fanzine so far, but watch out for next time!! :)

 Cheers :)
