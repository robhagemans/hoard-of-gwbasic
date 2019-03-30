Rev 2
  _____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~
			     THE BASIX FANZINE
			  Edited by  Peter Cooper
                                 Issue 6
  _____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~

                         peco@trenham.demon.co.uk

  INTRODUCTION:

  Welcome  to  the sixth issue of the Basix Fanzine whether you are reading
  this as HTML,  text from USENET,  text from an archive or using our brand
  new special FanRead viewer! If you don't have this reader and you want to
  learn more please check Section 4, Part 1.

  We  also  have  two new series this week. As well as the CD-ROM series we
  now have  a  full  series on BASIC demo coding full of useful effects. If
  you  wish  to  submit ideas for the coding series please do.  If you have
  actually  written a demo, please send it in.

  We also have a series about palettes and related topics, these were
  made by Joe Lawrence (lawrencej@ufrsd.k12.nj.us)

  Enjoy the read!

  Cheers! {:o)


==============================================================================
				Contents Page
==============================================================================

 SECTION ONE) - Specialized Articles
  - Part [a] Series
    1) CDROM Series     Continuation of CD Programming     QkBasic,VBDOS,PDS
    2) Coderz Series    Coding combo sine wave effects     QBasic+
    3) Palettes         Joe Lawrences palettes and color   QBasic+

  - Part [b] Topics and Articles
    1) The Gurus!       Interviews with the Basic Gurus    N/A
    2) BASIC Tutor      Final instalment of the tutorials  QBasic+

 SECTION TWO) - General Articles
    1) Useful sources   Places to get basic stuff on inet  Various
    2) Money Wise       How to make your money in BASIC    N/A
    3) Competition UD   Update on the competition (who?)   N/A

 SECTION THREE) - The Public Zone 
    1) Letters          Your comments and questions        Various
    2) Your programs    All of your programs.. here!       Various

 SECTION FOUR) - Administration and Usual Stuff
    1) Latest developments
    2) How do you contribute?
    3) How do you contact the author?
    4) Credits
    5) Last words + next month

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
- SECTION ONE -----------------------------------------------------------------
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 Specialized articles:
______________________________________________________________________________
| SECTION 1 PART A SUBPART 1 | CD Programming Part 2 |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Part 2:  Getting System Information and Using Request Headers/Command Blocks 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Welcome back!

Well, well, well! Another issue has passed and you are still interested in 
programming your CD-ROM drive. Last time we stopped after we got the MSCDEX
Version Number using interrupt &H2F with AX=&H150C. That's how we reference
all these interrupt functions. Now it's time to expand our repertoire of 
MSCDEX interrupt calls, especially getting more information about the computer
system. Sure, most of the time a CD-ROM drive is located on D:, but what if 
someone has it on E:, F: or even Z:. One way would be to just prompt the user
for his/her CD-ROM drive letter, but we can actually determine the number of
the first drive via another interrupt function. You might wonder what a drive 
number is, but it's a fairly simple concept. Since computers are number based 
all of these functions will reference drives by numbers, drive A: is 0, drive 
B: is 1, C: is 2, etc. No sweat! The call uses interrupt &H2F with AX=&H1500 
and returns the number of the first CD-ROM drive in register CX. The BASIC  
code looks like this.

' Get first CD-ROM drive number
inregsx.ax = &H1500                       ' Referencing the CD function
inregsx.cx = &H0                          ' Clear register CX
CALL interruptx(&H2F, inregsx, outregsx)  ' Call interrupt &H2F

drv% = outregsx.cx                        ' Store drive number in drv%

Wow, it doesn't get any easier than this. Actually the entire CD-ROM thing is
very simple, once you find the right documentation. How else would you know
the values for the registers? Since I feel we are on a roll here, let's make
another one of these interrupt calls. The next one will check whether the 
drive referenced by the number in drv% si supported by MSCDEX. This is done 
using AX=&H150B and BX containing the drive number. The interrupt returns a 
value of &HADAD in register BX if the drive is supported, so this is another
fairly simple matter of plugging the right values in the correct registers.

' CD-ROM Drive Check
inregsx.ax = &H150B                       ' Again referencing the CD function
inregsx.bx = &H0                          ' Clear BX
inregsx.cx = drv%                         ' Set CX equal to the first drive
CALL interruptx(&H2F, inregsx, outregsx)  ' Call interrupt &H2F

' Check the value of the BX register after the interrupt call
IF outregsx.bx <> &HADAD THEN
   PRINT "Drive "; CHR$(drv% + 65); ": is not supported by MSCDEX!"
   END
END IF

NOTE: The program will only use the first CD-ROM drive, since it decreases the
      size of the code tremendously. If you would like to use another drive,
      then just set drv% equal to its drive number at this point.

Now that we have covered some of the most useful simple interrupt functions,
it's time to move on to bigger and better things. Whenever using any hardware
one should always RESET it before use, so that's what we'll do next. Hold on
a second, though, this is not as easy as it sounds. All the remaining 
interrupt functions that we'll cover in the guide will use AX=&H1510.
According to the documentation, this function is used to send a `Device Driver
Request.' It will need the following register values to work:

AX = &H1510
CX = CD-ROM drive number (In our case the value in drv%)
ES = Segment of CD-ROM device driver request header
BX = Offset of CD-ROM device driver request header

Yikes! What is a request header? A request header contains values that the
interrupt function needs in order to know what it is doing and how it is 
supposed to do it. That's about as simple as I can make it! Usually, these 
request headers are stored in arrays, so ES:BX points to the address in memory 
of the array containing the header. The request header for the RESET function
will be an array that is 26 bytes long, so we will use this line:   

' Reset Drive
DIM rh(25) AS STRING * 1        '25 + 1 * 1 byte = 26 bytes

Since the request header will also access it's own control block of length 1,
we better invoke the following line. A control block is almost exactly like a
request header, so this next line should make sense:

DIM cb(0) AS STRING * 1         'STRING * 1 is one byte long 

All right, now we plug those critical values into our arrays. As you can see,
there are many unused offsets in the array, but they should not concern us.
Explaining all the fields in the array would be over-kill at this point, so
I'll just give you the code and what it means in remarks. This should clear
some things up and make the entire thing easy to read. So ... Let's get down
to it!

' Creating the control block for the RESET function
cb(0) = CHR$(2)         'IOCTL Output control block code: 2 is RESET 
' Now we write the information for the request header                                        
rh(0) = CHR$(26)        'Length of request header in bytes
rh(2) = CHR$(12)        'Request header command code field: 12 is IOCTL Output
rh(14) = CHR$(lbyte%(VARPTR(cb(0))))    'Lowbyte of offset for control block
rh(15) = CHR$(hbyte%(VARPTR(cb(0))))    'Highbyte of offset for control block
rh(16) = CHR$(lbyte%(VARSEG(cb(0))))    'Lowbyte of segment for control block
rh(17) = CHR$(hbyte%(VARSEG(cb(0))))    'Highbyte of segment for control block
rh(18) = CHR$(0)                        'Number of bytes to transfer;Highbyte
rh(19) = CHR$(1)                        'Number of bytes to transfer;Lowbyte
' Time to call interrupt &H2F
inregsx.ax = &H1510
inregsx.es = VARSEG(rh(0))      'Segment of request header
inregsx.bx = VARPTR(rh(0))      'Offset of request header
inregsx.cx = drv%               'Drive number
CALL interruptx(&H2F, inregsx, outregsx)

Wew! This is all I can get into this part of the guide, otherwise Peter is
probably going to club me really, really hard! Next time I'll explain all this
request header stuff once more, since that's what we are going to keep on
using.

_Just for fun_: Replace the 2 in the IOCTL Output command code field
                with a 0!

______________________________________________________________________________
| SECTION 1 PART A SUBPART 2 | Coderz Series |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Welcome to this new series. If you want to create impressive looking effects
 from  QBasic  possibly  for demos,  effects for games or just to learn a bit
 of  math  then keep reading,  if you want to improve your databases or learn
 some  Mode-X routines then steer clear :) This series primarily goes through
 the  theory of creating various effects such as plasma, tunnels etc and then
 presents  source  code  which shows a way these could be done in QBasic, but
 they  will  probably not be optimized but that will make a good exercise for
 you  the  reader,  you  could also convert them into Mode-X or various other
 screen modes. 

 So lets move straight onto our Plasma.
 ____________________
 - Plasma -----------
 ~~~~~~~~~~~~~~~~~~~~
 We  are going to be constructing a _sort_ of plasma. Ok, strictly it may not
 be  a plasma but it produces some plasma like patterns and with some palette
 rotations  it  can look very effective!  We  are going to use our old friend
 the  Sine  Wave.  Without  going into the theory of how sines waves are what
 they are I will explain briefly..  The  sinewave  goes in a range of -1 to 1
 going  through 0 as a middle point, a width of sine wave is 360 degrees.  We
 can  get the y position of the sine wave at any of these 360 points by using
 the SIN command. Unfortunately the SIN command requires the input in Radians
 but we can convert degrees to radians by multiplying the degrees by 0.017453

 So, to get the Y position of the sine wave at 90 degrees we would use this:

 PRINT SIN(90*0.017453)

 and it would give us an answer near to 1.

Fig 1========================================================================

 +1|              /  \
   |          /         \
   |       /               \
   |    /                      \
   |  /                            \                                      
  0|/                                 \                                  /
   |                                     \                            /
   |                                        \                      /
   |                                          \                 /
   |                                              \          /
 -1|                                                   \  /

dgs  0            90                  180               270             360

=============================================================================

 Of course, using a scale of -1 to +1 is a bit limited in my opinion and it
 requires a bit of multiplication and addition so that we can get a range of
 something like 0 to 100 with 50 being the mid point. To make this so:

 PRINT (SIN(dg%*0.017453)*50)+50

 We can actually draw a sine wave on our screens. To do this try this:

 SCREEN 13
 FOR x% = 0 to 360
 PSET (x%, ( SIN(x%*0.017453)*50 )+50),15
 NEXT x%

 But we have one major problem. A sine wave is 360 degrees wide but our mode
 13 is only 320 pixels wide. We'll get an error. So what we'll do is just
 scale down the x% into another variable called xx%

 SCREEN 13
 FOR x% = 0 to 360
 xx% = (x% /360)*320
 PSET (xx%, ( SIN(x%*0.017453)*50 )+50),15
 NEXT x%

 If  you  run  this you'll discover the sinewave goes from middle to a bottom
 then up to a top and then back down to the middle.. Then you'll see our Fig1
 and  think,  hang on,   he's got it round the wrong way.. No, we havn't it's
 just  because  on  our  chart the higher the number the higher it is, but on
 the computer screen it is the opposite, ok?

 Ok,  so  now  we have a sinewave. The sinewave has _amplitude_, this is what
 the range is, in our case it is 0 to 100. If the range was 0 to 50 it'd have
 a  lower  amplitude.  Our  sinewave  also has _frequency_, this is basically
 how  many  sinewaves  we can fit in a certain amount of space, if instead of
 there  being only one wave across the screen there was two then we could say
 that has more frequency, or a _higher_ frequency.

 We  can  also  _mix_  sinewaves.  For example we can mix sinewaves that have
 different  frequencies.  To  be  able  to add this lets simplify our program
 so far:

 SCREEN 13
 FOR x% = 0 to 360
 xx% = (x% /360)*320
 rd = (x% * 0.017453)
 srd = SIN(rd)
 PSET (xx%, ( srd*50 )+50),15
 NEXT x%

 This  program will work just as normal. Now, we want to _mix_ two sinewaves,
 how  can  we do this? Ok, what we can do is take our normal sinewave and mix
 it  with one with a higher frequency! We can do his this by taking the line:

 srd = SIN(rd)

 which  only  creates  a  single wave and "add" another wave with a different
 frequency into it and then average out the pair, like so:

 srd = (SIN(rd)+SIN(rd*1.8))/2

 If  you  make  that  adjustment  and run the program you'll get a wave which
 looks more  random  and out of control and this is what makes good patterns.
 Of  course  you  can  mix  three sinewaves, just add in the relevant SIN and
 change  the  2 to 3.  Simple.  You  could also speed up the program by using
 lookup  tables  or  other tricks. But this is not about optimization, we are
 concerned with theory and getting it to work.

 So  what  has this got to do with colorful patterns and plasma then? you may
 be  asking.  Well  the  sinewaves  give  us  something to create interesting
 palette  setups with.  To be able to demonstrate this better lets adjust the
 program  so  far  so  that  it  goes in a range of 0 to 63 which is what the
 palette uses.

 SCREEN 13
 FOR x% = 0 to 360
 xx% = (x% /360)*320
 rd = (x% * 0.017453)
 srd = (SIN(rd)+SIN(rd*2.8))/2
 PSET (xx%, ( srd*31 )+31),15
 NEXT x%

 Notice  I've  changed  the 1.8 to a 2.8 in the 2nd sinewave, this just makes
 the  wave more "wild", now we have a sinewave that can be used on a palette.
 Lets have a go.  Lets use this sinewave to adjust the palette in colors 1 to
 100. 

 SCREEN 13
 FOR x% = 0 to 360
 xx% = (x% /360)*100    ' notice the change to 100 to scale to 100
 rd = (x% * 0.017453)
 srd = (SIN(rd)+SIN(rd*2.8))/2
 OUT &H3C8,xx%+1
 OUT &H3C9,(srd * 31)+31
 OUT &H3C9,0
 OUT &H3C9,0
 NEXT x%

 Now  this  creates  a fine palette, lets see it in action! Add the following
 code to the end:

 FOR x% = 1 TO 100
 FOR y% = 1 TO 100
 PSET (x%, y%), (x%+y%)/2
 NEXT y%
 NEXT x%

 Now we have a great little effect.

 In Closing
 ~~~~~~~~~~
 Next  Issue  we'll  finish  off  with this,  it's a very wide topic. You can
 adjust  our program so far for different color types, fade from red to blue,
 For example: if you replace the first OUT &H3C9,0 with 
                        OUT &H3C9,63-((srd * 31)+31)
 you'll  get  a  red  and  green  fading  mixture.  Feel  free to send me any
 improvements  and feel free to use the code, it's all theory that anyone can
 work  out  so  feel free to take the code and dream up some things with it..
 You should see it with palette rotations, it looks great. I'll also show you
 how  to create FAR better effects using this sine wave method, but using TWO
 completely  separate  sinewave constructions, one for X axis and one for Y..
 See if you can do it.

 Maybe I'll include some better programs with it next month.

 Next month:  Finishing sines, Tunnels
______________________________________________________________________________
| SECTION 1 PART A SUBPART 3 | Palette Coding |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                           ***Palettes in Qbasic***

Introduction: This is a new series from Joe Lawrence. Part A is in this
              issue of the fanzine. Part B is for next issue. Take it away
              Joe!

Table of Contents
-----------------------------------------------------------------------------
Part A - Documentation
	1.)  Introduction, Screen Modes
	2.)  The PALETTE Function
	3.)  Using Ports to optimize palette functions
Part B - Building Palette routines
	1.)  Introduction to Palette routines
	2.)  PalRGBSet()
	3.)  PalGradient()
	4.)  PalSave()
	5.)  PalLoad()
	6.)  PalRestore()
	7.)  PalBrighten()
	8.)  PalDarken()
	9.)  PalRGBPower()
	10.) PalRotate()
	11.) PalMorph()
	12.) PalFade()


-----------------------------------------------------------------------------
*   Part A, Subject One                            Introduction, Screen Modes
-----------------------------------------------------------------------------          
	Now for a little introduction. Hi I'm Joe Lawrence, webfreak residing 
at http://www.geocities.com/SiliconValley/Park/2323/, and  of course, 
Qbasic programmer. My homepage features QBasic programming content, so stop 
by sometime. All e-mail can be slung towards lawrencej@ufrsd.k12.nj.us  
Enough about me, let's get going... 

	As you most likely know, there are numerous screen modes which to 
work with in Qbasic. Most popular are: screen 7 & 9, both boasting multiple 
video pages, screen 12, featuring 640x480 sharp resolution, and my 
favorite, screen 13 with 256 colors. Although 307200 pixels sound tempting, 
we'll be using screen 13, since we're focusing on colors, not resolution.

-----------------------------------------------------------------------------
*   Part A, Subject Two                                  The PALETTE Function
-----------------------------------------------------------------------------
	Okay, now we get into the coding bit. I assume you have decent 
knowledge of graphic functions, like line, circle, etc. You'll also have to 
be capable of VGA graphics, which most people know have. (If you're not 
sure, try anyway.) Okay, here's an example of the PALETTE function...

	SCREEN 13
	PALETTE 15, 63
	PRINT "The text is now red!"
	SLEEP
	SCREEN 0: SYSTEM

	Let's break the program down. First we change to screen 13, 
320x200x256. Then we change color 15's value to 63. See the palette is an 
array of colors. Color 1 has a value, blue, Color 2 has another, etc. 
(Don't worry about where I got 63 from, I'll explain it in a minute...) 
After we changed the color, we printed something out, waited for a key-
press, then reset the video mode and quit. Now let's breakdown the palette 
statement...

	PALETTE color, value

	The first argument, color, is which color to change. In the example I 
changed color 15, which is normally white. Value, the second argument, is 
the new color we'd like to see in place of argument one (color). The 
formula, is this:

	value = 65536 * Blue + 256 * Green + Red

The blue, green, and red variables are the measure of blue, green, 
and red hue in the new color. Possible values for the hues range from 0 to 
63, where 0 is none and 63 is full. For example, if I wanted to change 
color 15 from white to purple, here's what I would do...

	SCREEN 13

	Blue = 63: Red = 63: Green = 0
	value = 65536 * Blue + 256 * Green + Red
	PALETTE 15, value
	
	PRINT "Color 15 is now purple!"
	SLEEP
	SCREEN 0: SYSTEM

	Neat tricks can be done with the PALETTE function, try this example 
on for size... (Note, you may have to change the delay. For reference, 1000 
works good on a Pentium 100.)

	SCREEN 13
	PRINT "Color 15 is in flux!"

	DO
	  FOR Blue = 63 to 0 step -1
	     value = 65536 * Blue + 256 * Green + Red
	     PALETTE 15, value
	     For Delay = 1 to 1000: NEXT
	  NEXT
	  FOR Red = 63 to 0 step -1
	     value = 65536 * Blue + 256 * Green + Red
	     PALETTE 15, value
 	     For Delay = 1 to 1000: NEXT
	  NEXT
	  FOR Green = 63 to 0 step -1
	     value = 65536 * Blue + 256 * Green + Red
           PALETTE 15, value
	     For Delay = 1 to 1000: NEXT
	  NEXT
	LOOP UNTIL INKEY$ <> ""
	SLEEP
	SCREEN 0: SYSTEM

	By simply decreasing each hue by one, then changing the color, we get
a nice, smooth fading effect.

	In conclusion, although I've only changed text, and color 15, you can
certainly play around with changing graphics and other colors. (Remember 
though, that the PALETTE statement changes a colors RGB value even if it is 
already plotted.)

-----------------------------------------------------------------------------
*   Part A, Subject 3         Three Using Ports to optimize palette functions
-----------------------------------------------------------------------------
	The PALETTE function is sufficient enough to handle a color here, a 
color there, etc. If you plan to do any significant color manipulation, 
however, PALETTE is simply not going to cut it. So we do instead of letting 
Qbasic do the work for us, we'll do it ourselves by accessing the VGA card 
directly, creating much needed speed. Although using the ports take an extra
step or two, the results out weigh your time. For a taste, try this program 
on for size.

	SCREEN 13
	StartTime = TIMER
	LOCATE 1, 1: PRINT "PALETTE Time: "
	FOR N = 1 TO 10000
	 value = 65536 * INT(RND * 63) + 256 * INT(RND * 63) + INT(RND * 63)
	 PALETTE 15, value
	 LOCATE 1, 15: PRINT USING "##.##"; TIMER - StartTime
	NEXT

	StartTime = TIMER
	LOCATE 2, 1: PRINT "Port Time: "
	FOR N = 1 TO 10000
	 OUT &H3C8, 15
	 OUT &H3C9, INT(RND * 63)
	 OUT &H3C9, INT(RND * 63)
	 OUT &H3C9, INT(RND * 63)
	 LOCATE 2, 15: PRINT USING "##.##"; TIMER - StartTime
	NEXT

	This program changes the values of 10000 colors, first with PALETTE,
then with the ports. Although the time difference may seem insignificant, 
when using fading effects, time racks up.

	Okay, now how do these port things work, you ask? Simple. The syntax
 for porting is simply OUT port, data. In this case, we use hexadecimal &H3C8
to tell the VGA card to prepare this color for RGB data. Then we use &H3C9 to
 change that color's RGB values. Remember, though to always change them in 
this order: Red, Green, then Blue. Now what if you'd like to get a color's 
RGB values? Simply use  var = INP (&H3C9) . Here's an example...

	SCREEN 13
	
	' Change color zero to purple
	OUT &H3C8, 0				' Point to color
	OUT &H3C9, 63				' Send RGB values
	OUT &H3C9, 0
	OUT &H3C9, 63

	' Read color zero's Red, Green, and Blue values
	OUT &H3C8, 0				' Point to color
	red = INP (&H3C9)				' Get RGB values
	green = INP (&H3C9)
	blue = INP (&H3C9)

	' Print out the values
	PRINT "Red: "; red; "   Green: "; green; "   Blue: "; blue
	END

	All this short program does is change color 0, the background, to 
bright purple. Then it goes and "asks" the VGA card what color 0's RGB values
are. In this case, bright purple consists of 63 red and 63 blue. (Remember 
their are only 63 hues, so 63 would equal 100%.) Here's a little VGA quirk 
discovered by the authors of Tricks of the Game Programming Gurus... "I found
a little problem with the VGA card in reading a palette register. It seems 
that the register you request is not the one you get all the time. This bug 
is hardware-specific and manifests itself on some VGA cards. For no, my 
solution is to read each color register twice. That seems to fix it..."

______________________________________________________________________________
| SECTION 1 PART B SUBPART 1 | Interviews with some Gurus |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Here thinking of new ideas for the fanzine I decided to pick some of the
 finest of BASIC gurus from the newsgroups each week and interview them.
 For this issue, Dave Navarro (employee at PowerBasic) and Douggie Green
 (author of both BASIC FAQs). More interviews coming soon we hope: <grin>

 First, we have:

                             =================
                               DOUGGIE GREEN
                             =================

Fanzine: What first sparked off your interest in computers and what was your
         first one, and possibly when?

Douggie: I was in my early twenties, bored and looking for something more
         interesting  than working in local government or shipping and my
         brother mentioned that the college where he was doing electronic
         engineering  was  starting  computer  programming courses. So, I
         went to the library and got a book on BASIC (pure '64 Dartmouth)
         and taught myself, dry running simple programs on paper, by hand
         before  I  even  saw  a keyboard!  I didn't buy a computer until
         after the one year course,  and then I bought a BBC 'B', which I
         considered state-of-the-art then,  and  it is still probably the
         best 8-bit machine ever.

Fanzine: Very very true Douggie, I still have one in the shack here, although
         not in use! So, was that your first programming experience and when
         abouts was this? Did you have any major programs to write?

Douggie: It  was  about  1980.  I  was  doing  two programming courses in
         parallel,  one  needed  three  programs to be written (one was a
         simple  arcade  game  on a PET),  the  other  needed  a  serious
         application program written to a fairly rigid design.I chose the
         student registration project, which involved screen design, data
         capture  techniques (I was using inkey$ even then), data storage
         (single-sided 5 1/4 floppies),  sorting (done  disk to disk) and
         data search and retreival.  It  ended  up as a suite of programs
         linked  by  a  menu.  Not bad,  if I say so myself :) It was all
         written  on  a  Tandy  model  II in a BASIC very similar to what
         became MS Basic,  with support for random access files and fixed
         length records.

Fanzine: Ah ok! :) So, did you have any other job options besides in the
         computer industry?

Douggie: A few, but none particularly attractive apart from a brief foray
         into club management in the mid '80s.

Fanzine: Hmm. Sounds interesting <g>. So, What other languages except
         BASIC do you know?

Douggie: Fluently,  none.  I  have  a  working knowledge of 'C', and have
         written a few short (less than 500 lines) programs. I've dabbled
         with  Pascal a few times, mostly because I thought I should :) I
         have  to  turn  out  the  odd  bit  of DBase code for my brother
         (currently production manager at an electronic engineering firm).
         I've  done  a  fair bit of assembly in my time and still find it
         satisfying  to  trim  a few bytes from a routine, or knock off a
         few clock cycles.

Fanzine: Nice to know that there are still some people who get satisfaction
         out of trimming clock cycles off of routines! My putpixel used to be
         a 175 clock thing, it went down to 100, then 80, then 50 and now its
         48 or something.. :) So, Do you have a partner? And if so, then what
         do they think about your computing interests?

Douggie: I am currently un-attached :(

Fanzine: Whoa, Ok then. So how long have you been on the comp.lang.basic.misc
         newsgroup?

Douggie: About 18 months, I think.

Fanzine: Hmm, only a few months before I got there heh. So, which BASIC do you
         usually use for programming or is there a mixture?

Douggie: I'll  often  try  something  out  in  QBasic before taking it to
         QB4.5, which I use for any commercial work. I've got copies of
         most of the available (shareware/freeware/public domain) BASICs,
         and try them out as and when time allows. I like ASIC, although
         I haven't had time to try out 5.0 yet. I've also played with
         VB4Win and VB4Dos, and VB4Dos is now on my 'to get' list. 

Fanzine: Thanks for the interview. I bought VB4Dos when it first came out,
         for roughly err 79 pounds which is about $120. They never released
         another version and yet still people want to buy it. :) If I can
         put the disks back in the original box I'll probably sell it. Ok.
         Cheers, and thank you once again.

Douggie: You're welcome, :)

Readers: you are welcome to check out Douggies homepage at:
         http://www.geocities.com/CapeCanaveral/2124

                             =================
                               DAVE NAVARRO
                             =================


Fanzine: Hi Dave, so what started your computer interests and what sort of
         kit did you get?

Dave:    When  I was 9 years old and living in Dallas Texas my father was
         given  a  prototype  of the TRS Model 80 computer by Radio Shack
         (serial number 8).  He  was a business owner and they wanted him
         to  use  the  computer along with some software they gave him to
         see if it helped make running his business easier.

         After  the  survey was over (it actually slowed him down because
         of the time it took to store and retrieve data on cassette tape)
         he  brought the computer home.  One day he showed me a game they
         had  given  him  where you tried to shoot down tie fighters when
         they moved into your cross-hair.  You pressed the "clear" key to
         fire.

        The "clear" key just happened to be next to the break key and one
        day when I was playing the game (without my father's knowledge) I
        pressed  the  break  key  by  accident.  The game stopped and the 
        computer  sat  there  at the "Ready" prompt.  I was mortified.  I
        thought  I  had  broken the computer.  (Isn't that what the break
        key is for?  To break the computer? <g>)

        In  a  panic I called Radio Shack to see if they could help me to
        fix  it.  The  salesperson  I  talked  to  said  he only knew two
        commands.  He said to type either "RUN" or "LIST".  I typed "RUN"
        and the game started back up.  But I was curious about what "LIST"
        did, so I hit the break key again (this time with more confidence)
        and typed in "LIST".  A whole bunch of words just scrolled up the
        screen  and  when  it  stopped  I  read what hadn't scrolled off.

        It  as  in "English!"  And   I actually understood some of it.  I
        even   recognized   some   of  the  text  from  the  game.  So  I
        experimented  with "PRINT"  and  it actually printed words on the
        screen.  From that day on, I was "hooked".

        There  were  no  books  or  teachers  in  1976.   I learned BASIC
        programming  completely  by  using  "LIST"  on other programs and
        experimenting.

Fanzine: Wow, that sounds quite remarkable! :) Gee, if you still had that
         prototype Radio Shack piece of kit then in a few years it'd be
         worth a lot, dont you reckon? :) So when was your first real
         meaningful program?

Dave:    My  first  real program was written in February of 1977 (I still
         have  it  on cassette and a print out).  By then we had moved to
         Oklahoma  and  I had visited Oklahoma University on a field trip
         from  school.   I played a game where you thought of the name of
         an  animal and the computer would guess what the animal was.  It
         was  fascinating.  One of the students at the university gave me
         a brief run-down on the logic and I wrote my own version at home.
         By the time I finally stopped using TRS-80's I had a database of
         animals on disk so large that very few people ever thought of an
         animal that wasn't there. 

Fanzine: <g> Elephant.. umm, anyway, so were there any jobs ever open to you
         besides in the computer industry? and with PowerBasic specifically?

         When  I  reached  the seventh grade a few "gifted students" from
         our junior high were allowed to take computer programming classes
         over  at  the  high school. Up until that time, I was positively
         convinced  that  I was going to be a veteranarian(sp) because of
         my love of animals.  But I caught "silicon fever" and ever since
         I have only wanted to be a programmer.

Fanzine: Ok, What other languages except BASIC do you know?

Dave:    In  high  school  I learned Z80 assembler.  In college I learned
         Ada,  UCSD Pascal (for unix), and Berkeley C (for unix).  When I
         graduated  from college I continued to use the Basic language at
         Symantec, Software Publishing Corp, and Everex.

         When  I  became  a  consultant in the early 90's I tought myself
         Intel  assembler  from  several books I bought and learned dBase
         and Clipper so that I could bid on several projects.

Fanzine: Quite a fair range, heh. If you have a signigicant other then what
         do they think about your computing interests?

         I  think  I  may  be  one  of  the luckiest men alive.  I met my
         fiancee through CompuServe Email.  And she's the only women I've
         ever  dated who completely shares my love of computers.  She's a
         computer consultant herself and actually spends more time on her
         computer than I do on mine.

Fanzine: Wow, that is amazing! The internet and related services can be useful
         ,  including  the  newsgroups.  How  long  have  you  been  on  the
         comp.lang.basic.misc newsgroup?

Dave:    I  didn't  "discover the Internet"  until three years ago when I
         lived  in  New  York City.  Since then I have been an off-and-on
         participant.  It wasn't until I came to work for PowerBASIC, Inc
         that I begin to be much more active.

Fanzine: How optimistic are you about PowerBASIC, ie do you think that it
         could eventually come to be one of the big names along with Delphi
         and VB?

         I've worked as a programmer at a number of large companies. Even
         companies which are bigger players in the computer industry than
         PowerBASIC, Inc. (Symantec, Software Publishing Corp, Everex and
         Product  Identification to name a few).  But PowerBASIC, Inc. is
         the  first  company where I actually feel at home.  It has a lot
         to do with my Basic programming roots.  PowerBASIC is a software
         company  run  by Basic programmers not by business execs used to
         running   multi - billion   dollar   soda   companies  or   huge
         tire-manufacturing conglomerates.

         I  think that PowerBASIC has a "potential" to make us all at PB,
         Inc. billionaires.  And  while  we' d  all  like to be rich (who
         doesn't?),  that's  not  our goal.  We  keep score like everyone
         else,  but   while  they  do  it  with  money,  we  do  it  with
         technological  innovation.   We' re doing things with Basic that
         everyone  else  said  couldn't be done.  And we do it because we
         want  to  be  better,  not because we want to be the richest kid
         on the block.

Fanzine: Unlike a certain corporation beginning with 'M'? Ok, carry on..

         So  I  guess  my  answer is "yes".  PowerBASIC will be as widely
         known  as  Delphi,  Visual  Basic  and other popular programming
         languages.   But not because of how many products were sold, but
         because of how far we're taking the Basic language and making it
         just as powerful and full-featured as the "so-called" mainstream
         programming languages like C and Pascal.

Fanzine: Ok, thank you Dave. A very interesting interview. Good luck with
         PowerBasic.  I  hope to see it as big a household name as QBasic
         (what household do you live in? -ed). It's definately competition
         to Microsoft and good one too. Good job.


Note to Microsoft, I'll promote your products if you dont mind sponsoring
the fanzine... well' it'd be far better then wouldnt it <g>
______________________________________________________________________________
| SECTION 1 PART B SUBPART 2 | Basic Tutorials |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 BASIC Tutorials - instalment 5
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 If you remember, last issue I gave you an assignment:

  Write a program that clears the screen and then asks for the year that you
  were born in. Then have it work out how old the person is and then display
  it like so:

  You were born in (year%) and that means that now you are (age%) old.

 Let's go through this and try and write a program that would work:

 CLS                                                    ' Clears the screen
 INPUT "What year were you born in?",year%              ' Asks for the year
 age% = 1996-year%
 PRINT "You were born in ";year%;" and that means that now you are ";age%;
       "years old"

 Of course, this wouldnt work all the time, you would also have to take the
 month into account. In this example we have placed an expression to age% on
 the 3rd line ' age% = 1996 - year% ' but you can also place expressions
 direct into PRINT commands. For example:

 PRINT "4*5+99-6*2 = "; 4 * 5 + 99 - 6 * 2

 This would work perfectly fine. So you could shorten the assignment programs
 last line to:

 PRINT "Born in ";year%;" and now you are ";1996-year%;" years old"

 As you can see the expression has been placed actually inside the PRINT
 command. But in many cases this method should not be used. It can be used
 in 'one-off' situations like the above because it saves having to create
 another variable, but if the expression will be printed several times then
 theres two reasons why you should use a variable first:

        o  It saves a bit of typing
        o  It saves time in execution


---

 This  is  the  last instalment.  These  tutorials were designed for the most
 novice of programmers. They have dealt with *very* simple topics very slowly
 in  a  very  basic way.  The tutorials were not designed to teach people how
 to  write  demos  or  games,  they  were  designed  to teach the most novice
 programmer  the  absolute  basics (no pun intended) before they possibly buy
 a book. Most QBasic books probably rush past this sort of stuff in the first
 few pages, but now beginner programmers know for sure what to do.


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
=============================================================================
 The Games Programmers Encyclopedia
  'If you thought you knew it all, think again! The games programmers
   encyclopedia contains information on 3d programming, effects, fire,
   soundcard info for many cards! and more'
  GRAB it from:   x2ftp.oulu.fi
                  /pub/msdos/programming/gpe
=============================================================================
 Blood225s FTP Site
  'Programs for QBasic, but very high quality ones can be found at this
   site, all from a variety of authors. This site is always worth the visit'
   FTP SITE :    users.aol.com
                 /blood225
=============================================================================
 Simtel
  'Recently there has been some changes in SimTel, but it's still there,
   I think.. :) There is a wealth of files for the public there including
   files for users of Basic\QBasic. Mirrors of the site are available world
   wide.
Try:
  Country         Host                     Directory
  ---------       ----------------------   -------------------
  Australia       ftp.bhp.com.au            /pub/simtelnet
  France          ftp.ibp.fr                /pub/simtelnet
  Germany         ftp.rz.uni-wuerzburg.de   /pub/pc/simtelnet
  South Africa    ftp.sun.ac.za             /pub/simtelnet
  UK, London      ftp.demon.co.uk           /pub/simtelnet
  UK, London      sunsite.doc.ic.ac.uk      /packages/simtelnet
  US, California  ftp.cdrom.com             /pub/simtelnet
  US, Michigan    oak.oakland.edu           /pub/simtelnet
  US, New York    ftp.rge.com               /pub/systems/simtelnet

=============================================================================

 Games Programmers site-finland
  'This site is a goldmine. Hundreds of specification files for all sorts of
   PC peripherals, specs for file formats, FAQs on various programming
   concerns. This is one of my top 3 ftp sites.'
 Take a trip to:  x2ftp.oulu.fi
                  /pub/msdos/programming/docs
                                        /formats
                                        /gpe
                                        /faq
=============================================================================

 Basic on the Web

  All of these WWW pages are to do with BASIC or rather, they have things of
  use to BASIC programmers.

  Basix Fanzine site-  http://www.geocities.com/RodeoDrive/2238/fanload.html
  Wrox Press        -  http://www.wrox.com/
  Jumbo shareware   -  http://www.jumbo.com/
  PBSOUND WWW site  -  http://www.snafu.de/~pbsound/

 If you know of any others then please tell me and it'll be added, if you 
 actually own\run the site then please include some info about it and I'll
 check it out. I'm offering a bit of free advertising here.. :)
______________________________________________________________________________
| SECTION 2 SUBPART 2 |  Money Wise    |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 With standard BASICs (excluding VB) there is not a large job market at all
 so how can you make your money with BASIC? It'd be hard to go out and find
 an  actual  career or regular programming job with only knowledge of BASIC
 unless  you  were  willing to be trained.  So I repeat, how do we make our
 money from BASIC?

 Basically  it  goes back to this point. 'What you use to make something is
 not  important  if  the finished product is up to standard', in my opinion
 this  statement  is true.  If you write a database system for DOS in BASIC
 and then an identical one in C then what does it matter?  The C one is not
 better in any way, just because it was written in C (proven to be _harder_
 than BASIC) doesnt make it actually any better. Ok, it may be a few K less
 on  the EXE file but today in the world a lot of us have > 200Mb HDs and a
 few more K is basically insignificant.

 I feel there are a few ways for you to make your money:

        - Shareware -  A  good  option for small amounts of cash, it helps
                       none the less
        - Freelance -  This  could  be called a career,  it would probably
                       be working from home though
        - FreeStock -  The  system Netscape used, they gave a program away
                       for basically nothing and it became so popular they
                       could  float  the company on the stock market  and
                       they made big money

 Lets take a peek at the first two of these methods:

 - Shareware -
  People  take  this  approach all the time. You see shareware programs all
  over  the  Internet,  on  WWW pages, in magazines, on coverdisks, its all
  over the place. People _do_ buy shareware, even if you don't. The rate of
  registrations depends on the product, market and price, in that order.

  The  price  of  a program is not the most important factor,  some authors
  think  it  is and they release shoddy products for cheap prices.  There's
  hardly  any  registrations  and  they start to blame it other products or
  other things. The most important thing is the product, if its a brilliant
  product  then  you can expect registrations. But we have to remember, the
  next  important  thing  is the market.  In general there are two types of
  market, vertical and horizontal (wide market). A vertical market is where
  the  product  is  aimed for a very small number of people, for example, a
  horse  database,  this wouldnt be used by a wide number of people.  Ok, a
  lot  of  people might like horses but not a lot of people would pay for a
  horse database.

  On  the  other hand,  there are horizontal markets,  these cover a lot of
  people.  Games, for example, would fit into this category (although games
  do  tend  to  receive  a far less registration rate) and (if good enough)
  would be used by a wide range of people. Take Wolfenstein 3D for example,
  I  bet  you've played it.  Or if not,  you've probably played Doom. Games
  cover wide markets.

  There  are  other  things to consider in the market situation. What about
  the   sort of people you are trying to "sell" to? If it's games then it's
  probably  the  younger  person  that would be playing it.  The main games
  players are in the 12-22 age group.  A  major  percentage  of these don't
  have jobs, after all, did you have plenty of money to spare when you were
  15? This means that they probably wont register.

  But  then,  consider businesses, they want a professional looking program
  and  they  are willing to pay higher amounts of money, after all, if it's
  under $30 it's not worth them cutting the check (cheque), is it?

  There are lots of points to consider, I could explain them all but we need
  to move on.

 - Freelance -
  In  theory  this is an actual job although you could balance it on top of
  your "normal"  job.  It involves writing programs for companies.  Most of
  these  wont be worried about what language you use as long as the program
  lives  up to their expectations and *works*. They also pay pretty well, I
  mean,  more than shareware but that could be expected,  would you do like
  3 months work for $40? I guess not.

  Finding  this work can be done in many ways.  You may simply know a local
  business  that  requires a specialist database system or the local school
  might  need  some sort of software.  This sort of work can be most simple
  because  you  probably know the people and know the market. But there are
  other ways.  You could advertise your services over the net or in papers,
  this  would bring in companies you probably havnt heard of and more work,
  and  importantly,  more  contacts.  This  market doesnt primarily revolve
  around  adverts  in  newspapers  or any public form of advertising.  It's
  mainly "word of mouth". Think about it, a business might use your service
  and  then  another business might be talking to them and say 'I like that
  database system, where can I get one?' , or directors might be talking to
  each other etc..  So,  you need to leave a good impression so people talk
  about your product in the industry.

  If  you  think,  if  you  concentrate  on  one major industry, lets say a
  database of streets for a taxi-cab firm, you might take 4 months to write
  the  program  and earn $4000 say. Then if another taxifirm approaches you
  then  you  already have the system written! They might want a few changes
  but  the main work is done. You can earn more money with hardly any work.
  So as you can see,  freelancing can bring in big $$ but it involves a lot
  of work.


 We  hope  you  found  this information useful.  For information or queries
 please mail  peco@trenham.demon.co.uk

______________________________________________________________________________
| SECTION 2 SUBPART 3 | Competition!!!  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 This wasnt easy. :) I had five entries. I allowed three to go through to the
 reviewing process.. They were from:

        Kenneth Green  - KG
        Steve Slaven   - SS
        James Eibisch  - JE

 Here is the table of results:
 
    |  GmPl  Docu  Efft  Time  Styl  Pres  Keys | Average
 KG |   4     4     7     4     6     5     8   |    5
 ---+-------------------------------------------+---------
 SS |   7     9     7     5     6     6     3   |    6
 ---+-------------------------------------------+---------
 JE |   8     6     7     8     8     7     8   |    7

 GmPl = GamePlay      generally how fun the game was, how it kept you hooked
                      how it gripped you, etc
 Docu = Documentation how well the game was documented (not source)
 Efft = Effort        how much effort I thought had been placed into making
                      a good game
 Time = Time          how long I played it for
 Styl = Style         Programming style in general
 Pres = Presentation  What the graphics were like etc
 Keys = Keys          How easy the keys were to find\work out


            So I am proud to announce the winner is James Eibisch

 James Eibisch entered a Space Invaders game, very much like the original,
 very good sound effects too, the music gets faster as the game goes on to
 create that gripped feeling that Space Invaders always use to have in the
 arcades. It's a goldie, it's an older, and it's a winner! :)

 Well done James, I will be contacting you. :^) Well done to Steven and
 Kenneth too for being only _just_ behind. I'll probably throw ya some
 goodies for effort. :)

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
- SECTION THREE ---------------------------------------------------------------
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 Your Shout:

 Anything that is sent for use for the zine that doesn't fit into the other
 chapters is here. It's where your questions and programs go unless they fit
 into an article or if you actually write an article yourself.

______________________________________________________________________________
| SECTION 3 SUBPART 1 |  Letters  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From:  Kevin Tomlinson
Site:  http://www.datasys.net/users/stu/ktomlinson/super.htm  

 I am surprised only 193 people have came to your site!! I LOVE the fanzine
 it  is packed with the information I like to read about.  Keep up the good
 work!  BTW when is issue 6 coming out?

---

 Thank you for your mail, the kind words are appreciated.
 Well  seeing  as  the site hasnt been heavily advertised (barely) I'm not
 surprised..  Not  many  peoples  links  go to that site either, its in no
 search engines etc.  It's mostly my own word of mouth. And that 193 means
 193  _different_  people,  which  I think isnt bad. On the old site there
 were over 2000 in a month which I was pretty impressed with, which reminds
 me, if you have a site anyone and the links goes to the
 http://www.teleport.com/~ericksnj/
 site then please change that to:
 http://www.trenham.demon.co.uk/fanload.html

 Cheers

---
From: Jacob Chacko
Site: n/a

 Hi There,
 I am Arpith from Australia. I thought i'd add a few articles for
 your   magazine... Here they are. ENJOY !!!!

---

 Thank you! Readers, you get to see some of the codes in the programs
 section. There's quite a bit so I'm keeping some for next issue too!
 Thanks again.
______________________________________________________________________________
| SECTION 3 SUBPART 2 |  Your Programs  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 A rather rough program here this week, we havnt much room for the others due
 to the super series we have! But heres a source sent in by Jacob Chacko. I
 can't really see how this source can work.. Have a look:

'QBasic NoBreak v1.0a
'Copyright (c)1995 by Daniel Trimble
'Public Domain - use at your own risk.
CLS
DO
 KEY 15, CHR$(4 + 128 + 32 + 64) + CHR$(70)
 ON KEY(15) GOSUB NoBreak: KEY(15) ON
 KEY 16, CHR$(4 + 128) + CHR$(70): ON KEY(16) GOSUB NoBreak: KEY(16) ON
 KEY 17, CHR$(4 + 128 + 32) + CHR$(70): ON KEY(17) GOSUB NoBreak
 KEY(17) ON: KEY 18, CHR$(4 + 128 + 64) + CHR$(70): ON KEY(18) GOSUB NoBreak
 KEY(18) ON: KEY 19, CHR$(4) + CHR$(70): ON KEY(21) GOSUB NoBreak
 KEY(21) ON: KEY 22, CHR$(4 + 64) + CHR$(70)
 ON KEY(22) GOSUB NoBreak: KEY(22) ON: KEY 23, CHR$(4 + 32) + CHR$(46)
 ON KEY(23) GOSUB NoBreak: KEY(23) ON: KEY 24, CHR$(4 + 64) + CHR$(46)
 ON KEY(24) GOSUB NoBreak: KEY(24) ON
 KEY 25, CHR$(4 + 32 + 64) + CHR$(46): ON KEY(25) GOSUB NoBreak: KEY(25) ON

 LOCATE 1, 1, 0: PRINT "QBasic NoBreak v1.0a"
 LOCATE 2, 1, 0: PRINT "Copyright (c)1995 by Daniel Trimble" 
 LOCATE 4, 1, 0: PRINT "This program and all source is public domain.  I";
 PRINT ;"will not be held responsible"
 LOCATE 5, 1, 0: PRINT "for any damage this program may cause.  I am not";
 PRINT ;"at fault; use this at your"
 LOCATE 6, 1, 0: PRINT "own risk - period!"
 LOCATE 15, 1, 0: PRINT "Try pressing either CTRL-BREAK or CTRL-C.";
 PRINT ;" Nothing will happen!"
 LOCATE 16, 1, 0: PRINT "To end the program, hit ENTER."
 IF INKEY$ = CHR$(13) THEN END
LOOP
NoBreak: RETURN
'ctrl =4          extended keys=128
'num lock=32      c=46
'cap lock=64

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
- SECTION FOUR ----------------------------------------------------------------
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
 Details about the fanzine:

  This section has been cut down this week to allow room for more goodies! :)

______________________________________________________________________________
| SECTION 4 SUBPART 1 |  Latest Developments  | 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 These web sites will be uploaded 10th August, if you see this before then
 then appreciate the pages stated may not be available.

 i)   Web Archives
  To get the fanzine (and back issues!) then come to the official site:
          http://www.trenham.demon.co.uk/fanzine/

 ii)  Specialized Viewer
  Thanks to Daniel Garlans (White Shade) we now have a specialized reader
  for the Fanzine! For information and a demo please come to:
          http://www.trenham.demon.co.uk/fanzine/
  and select  FanRead

 iii) HTML Fanzine
  Issue 1 of the zine is available at Joe Lawrences page.
          http://www.geocities.com/SiliconValley/Park/2323

 iv)  Mailing List
  To join the mailing list   :
          arelyea@vt.edu 
  with the following line in the subject header:

     subscribe basix-fanzine

  Any text in the body of the message will be ignored. The mailing list is
  run by Mr. Relyea and the Basix Fanzine claims no responsibility for any
  problems with the mailing list.  The HTML Fanzine is run by Tom Lawrence
  and  again  the Basix Fanzine claims no responsibility for any problems.
______________________________________________________________________________
| SECTION 4 SUBPART 2 |  How do you contribute?  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 So how do you contribute?
 All you have to do is e-mail all of your source code\articles and ideas to:

                peco@trenham.demon.co.uk   - with enquiries
		bmag@trenham.demon.co.uk    - with Q+A, articles, source

 Please, I appreciate it _so_ much if you could donate code, questions,
 answers, Basic stories, your own ideas for the fanzine etc. It all helps
 so much.
______________________________________________________________________________
| SECTION 4 SUBPART 3 |  How do you contact the author?  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Email\enquiries:   peco@trenham.demon.co.uk
 Email\articles:    bmag@trenham.demon.co.uk
 URL:               mailto:peco@trenham.demon.co.uk
 WWW:               http://www.trenham.demon.co.uk/
 IRC:               Efnet as  Peter
 Mod Newsgroup:     alt.games.uv1
______________________________________________________________________________
| SECTION 4 SUBPART 4 |  Credits  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Greets go to (in no real order) :

   Joe Lawrence,
    wrote the palette series

   Marco Koegler, (marco@umr.edu)
    wrote the CDROM series

   Daniel Garlans, (White Shade)
    writing and testing the new FanRead specialized viewer!
    (garlans@usa.pipeline.com)

   Tony Relyea,
    who is the maintainer of the mailing list and owns Russian-under Ware
    ,a software company, strangely enough!  (arelyea@vt.edu)

   Douggie Green,
    author of the two great FAQ documents - the newsgroup one and the code one
    (douggie@blissinx.demon.co.uk)

 Other people who deserve some credit:
    John Woodgate
    SWAG team
    Adrian Sill
    Wrox Press generally
    Kari Patterson
    The rather wierd people on IRC #qbasic..
    Druppy
 
 Remember that this fanzine relies on your contributions. Cheers, ;-)

______________________________________________________________________________
| SECTION 4 SUBPART 5 |  Last Words+Next month  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Next Issue:
	SPECIALIZED ARTICLES:
                [Series]
                More on Demo Coding
                CD programming part 3
                More on Palette Coding
                [Topics and Articles]
                Basic Tutorial  
	ALL LEVELS ARTICLES:
		WWW pages and FTP sites
                The Interviews with the BASIC Gurus! continued hopefully
	YOUR SHOUT:
		Your Questions, Answers and programs
	DETAILS ABOUT THE FANZINE:
		How to contribute, and the usual stuff
                Rundown on the Issue 8 fanzine.

 Last words:

  It's  8am,  I've  been  doing  this  for  the  last hour and I can actually
  say,  it  was  worth  it  and I enjoyed it. The coding series will be bound
  to  be  interesting.  I'm not even going to say sorry for the delay in this
  appearing, you're probably used to it, but that said, Issue 7 should follow
  on  pretty promptly after this one, it is 50% done which is far better than
  usual! Look out for it soon.

  Also, if you're a BASIC guru then watch out because I might be interviewing
  you! 
 
 Cheers {:o) it's me signing off..

Finished: 9th August 1996, 8:13am

note: just discovered first release has problems, recalled posts...
