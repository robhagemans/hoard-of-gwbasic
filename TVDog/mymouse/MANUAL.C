                            MYMOUSE
          THE COMPLETE BASIC COMPATIBLE MOUSE PROGRAM






                           CONTENTS

                      WHAT IS MYMOUSE?  2

                      THE PLEXUS  3

                      CANVASES AND GUIDELINES  4

                      FUNCTIONS  5

                      TOOLS  9

                      FUNCTION/TOOL INDEX  21

                      ADVANCED APPLICATIONS 22

                      ADVANCED FUNCTIONS/TOOLS INDEX 31

                      SUPPLEMENTAL PROGRAMS DISK 32

                      GREETING CARDS 32

                      CALCULATING SCREEN COORDINATES 32

                      APPENDIX A A1











               Copyright (C) 1989 by Marcy Yates
                      All Rights Reserved
                      WHAT IS MYMOUSE?

     MYMOUSE is a complete mouse graphics program in GW-BASIC!
It was developed in GW-BASIC (DOS version 3.2) using the Tandy
Color Mouse, catalogue no. 26-3125.

     The powerful advantage here is that MYMOUSE creates and
saves graphics in GW-BASIC, which allows you to take the
graphics created by MYMOUSE and use them in other GW-BASIC
programs.  This feature alone sets MYMOUSE in a distinctive
class by itself, since it is a truly COMPATIBLE STANDARD
PROGRAM which allows for the use of MYMOUSE-created graphics
in other programs - something that no other mouse graphics
program currently on the market can do!

     MYMOUSE is a two disk program requiring at least 256K of
RAM.  The first disk - the PROGRAM DISK - goes in drive A or
on your hard disk, and contains the necessary programs to run
MYMOUSE plus "scrapbooks" and a Safety File.  The "scrapbooks"
are MYMOUSE composite pictures of figures and drawings you
might wish to merge into your own work.  More about this in
the Clip/Paste and Merge sections.  The Safety File is
extremely important.  This simple file is copied to the second
MYMOUSE disk (below) when the program is booted.  This
prevents any accidental errors in saving pictures.  Be sure
not to erase any of the files on the PROGRAM DISK, as a
missing file here is sure to result in a critical error when
the program executes.

     The second disk - the MYMOUSE PORTFOLIO DISK - goes in
drive B and is where your graphics pictures are stored (see
SAVE PICTURE for details).  You can have any number of MYMOUSE
portfolio disks.  You can even make up your own "scrapbooks"
and save them to the MYMOUSE PORTFOLIO DISK(S).

     MYMOUSE uses a 16 color, 320 x 200 pixel resolution
screen.  In GW-BASIC this is called medium resolution, though
most mouse programs refer to it as a high resolution screen.
There are 8 functions and 24 tools available at all times.

     MYMOUSE IS FUN, FAST, ACCURATE AND TRULY COMPATIBLE.

     MYMOUSE is autoexecutable so just load and boot - you do
not need a "password".  The heart of  MYMOUSE lies in the
PLEXUS which we will look at next.

                          THE PLEXUS

     Load MYMOUSE in drive A, a blank, formatted (portfolio)
disk in drive B, and turn on your computer.  MYMOUSE will
prompt you for the date and time.  Next you must select
graphics TMODE or TMODE/R (necessary for printer print-outs of
your pictures - see PRINTER GRAPHICS).  Then you are prompted
to strike a key when ready, and MYMOUSE displays the directory
of the PORTFOLIO DISK in drive B.  Where did the SAFETY.BAS
file come from?  Don't worry, it is supposed to be there and
was copied to the PORTFOLIO DISK by MYMOUSE.

     After following the next prompt you will find yourself at
the blue screen, which reminds you to be sure your caps lock
is on and prompts you to press [Enter] to continue.

     After locking your caps lock and pressing [Enter] you go
to the MYMOUSE graphics screen.  You will notice first that
no function/tool name appears to the left of the MYMOUSE
graphics screen, and you have no cursor at this point.  You
are in the heart of the program - the PLEXUS.  To MYMOUSE
PLEXUS means "central switching network".  From here all
functions/tools of MYMOUSE can be "called" one at a time.  The
PLEXUS is always recognizable, because every time you return
to it there is no cursor nor function/tool name written on the
left border.  Some of the MYMOUSE functions/tools return
automatically to the PLEXUS when they have completed their
routines; others wait for you to "call" the PLEXUS.  As we go
through the functions/tools, which do which will be pointed
out to you.

     Since MYMOUSE is primarily a programmer's program, like
GW-BASIC itself (though you can have plenty of fun just
drawing pictures as with any mouse program), it utilizes SPEED
KEYS from the computer keyboard to speed up changing of
functions and save a little wear and tear on the mouse.  Each
function or tool is "called" at the PLEXUS by pressing the
appropriate letter on the keyboard.  The necessary letters for
each function or tool are given in the sections that deal with
them, and on a quick reference chart on the back cover.

     Besides the white border which defines the MYMOUSE
graphics screen, you will also notice a cross and two sets of
Cyan lines.  The cross marks the center of the screen, and the
grids are to help guide you in the seven canvases available to
you in MYMOUSE.  Canvases and guidelines are next.
                    CANVASES AND GUIDELINES

     There are seven canvases available in MYMOUSE.  This
allows for more precision and control in creating your
graphics.  All of the seven canvases overlap two or more other
canvases to aid in ease of maneuvering from one to the other.

     First you have six small canvases within the MYMOUSE
graphics screen.  Number 1 is in the upper left; number 2 in
the upper center; number 3 in the upper right; number 4 in the
lower left; number 5 in the lower center, and number 6 in the
lower right:

                          1    2    3

                          4    5    6

     To access a particular canvas, first you bring up your
function/tool.  If you want it in canvas 1, for example, you
merely press the number 1 and the cursor will jump to canvas
1.  To change it to, say, canvas 5, wait until neither mouse
button is being pressed and press the number 5.  The cursor
will jump to the related area in canvas 5.  And so on.  Note:
the numbers which access the canvases are on the regular
keypad - NOT the numeric keypad.

     The canvases overlap each other at the points of the Cyan
grids, as mentioned earlier.  This allows for a smooth,
overlapping transition between canvases.  However, if you
should start a tool (say triangles for example) in one of the
six canvases you will not be able to draw your triangle
outside of that canvas.

     Canvas 7 covers the entire MYMOUSE graphics screen, and
whenever you bring up a function/tool you are in canvas 7
(with the exceptions noted below).  From here you decide
whether to stay in canvas 7 or switch to one of the smaller
canvases (1 through 6).  You may switch between canvases 1
through 7, as desired.  A little experience with MYMOUSE will
go a long way in deciding which canvas to use.

                           IMPORTANT
THE DRAW & ERASE TOOLS USE ONLY CANVASES 1 THROUGH 6
THE ARC TOOL USES ONLY CANVAS 7
THE FUNCTIONS AND THE FLIP/QUIT PICTURE TOOLS USE NO CANVASES
ALL OTHER TOOLS USE CANVASES 1 THROUGH 7
                       MYMOUSE FUNCTIONS

     1. THE ERROR TRAP.  This function is extremely helpful in
preventing an error from ruining hours of work.  Errors can
occur, and if they should, they would normally break up your
screen, destroying your graphics in the process while BASIC
prints out the error message.  One of the most common errors
is to merge an image too close to the boundary of the MYMOUSE
graphics screen.  This causes the image to be put "out of
bounds", resulting in an error that would destroy your
picture.  However, the ERROR TRAP intercepts the message,
and allows MYMOUSE to continue on without disturbing your
picture.  If at any time you do not have a cursor, move your
mouse up and/or left.

     SPECIAL NOTE: In many months of testing, the ERROR TRAP
has never failed.  However, there are errors that BASIC cannot
recover from.  The one of these to be most concerned about is
an "Out Of Memory" error.  Should you run out of memory (we
never have) there might not be enough memory to execute the
ERROR TRAP and save your picture.  Though it is extremely
unlikely that this will occur, it is still best to safeguard
against it by saving your pictures frequently - especially
after you have just completed something difficult.



     A final note here:  Painting uses a lot of BASIC's stack
space and is most apt of all the functions/tools to result in
an "Out Of Memory" error.  So save, save, save.  Again,
nothing has ever gotten past the ERROR TRAP - not even
excessive painting in nooks and crannies, but better safe than
sorry.  If, while painting, the painting should stop and you
find yourself at the PLEXUS don't worry - it is just the ERROR
TRAP functioning as it should.  Simply go back into PAINT and
continue on.

     The ERROR TRAP is an automatic function and cannot be
"called" from the PLEXUS.  However, when the ERROR TRAP
executes, MYMOUSE returns you to the PLEXUS.








     2. PRINTER GRAPHICS.  MYMOUSE is set for printer graphics
using the Tandy DMP 130A printer set in the Tandy Mode.

     At any time in the PLEXUS you can print out your graphics
by pressing [Shift] [Print] simultaneously.  The printer will
start up and print the entire graphics screen contents.  If
you should wish to halt printing before a picture is complete,
merely press [Shift] [Print] simultaneously again.

     The printer prints the graphics in varying shades of
gray.  Sometimes the colors on the monitor screen and how they
are interpreted by the printer do not seem logical to the eye.
To correct for this you might want to change your colors on
the monitor expressly for the purpose of a print-out, then
return them to their original colors for your disk file.
Appendix A contains charts showing what the colors look like
when interpreted by the printer. You can select graphics TMODE
or TMODE/R during start up, as explained on the inside front
cover.  If you should find that you selected the wrong mode,
or can't remember which mode you selected, just save your
picture, press [F1] and type "TR" at the DOS prompt.  This
restarts MYMOUSE, letting you select the graphics mode you
want and then you simply GET your picture back from disk.

     3. SAVE PICTURE.  This function is called from the PLEXUS
by pressing the speed key "S".

S    The words SAVE PICTURE appear, written vertically, to
A    the left of the MYMOUSE graphics screen.  After a slight
V    pause, the screen will clear and all of the files already
E    saved on the PORTFOLIO DISK will be displayed.  At the
     bottom of this screen you are prompted for a file name
P    under which to save your picture.  Enter the filename
I    using eight letters or less for the filename itself;
C    include quotes, drive specification and extension with
T    close quotes.  Use only the extensions "MMP" or "NET" as
U    others will disrupt the program.  EXAMPLE: "B:MYPIC.MMP".
R    If there is an error during the SAVE a screen will appear
E    detailing what might have gone wrong.  Determine the
     problem as suggested by the help screen and press [ENTER]
     when you are ready to retry the SAVE.  Your picture will
     return to the screen and you should start over by
     pressing "S".

     MYMOUSE will save ten pictures to a 5.25 disk and 21
pictures to a 3.50 disk. (These files do not include
"SAFETY.BAS", "BIGFONT.BAS" or "PRN4MAT.BAS".  It is
important, however, to leave one picture open for "ZERO.NET";
a picture that is needed for the ADVANCED APPLICATIONS
SECTIONS.  So more realistically you have room for nine
pictures on a 5.25 diskette and 20 pictures on a 3.50
diskette.  This will be explained in more detail in the
ADVANCED APPLICATIONS SECTION.

     A very handy feature of the SAVE PICTURE function is that
it allows you to "call" it, read the files on the PORTFOLIO
DISK, then press [ENTER] without any file name.  This returns
you to the help screen from where you can simply press [ENTER]
again to restore your picture.  In so doing, SAVE PICTURE
functions as a sort of directory of the PORTFOLIO DISK without
disturbing anything.  GET PICTURE and KILL PICTURE (below) can
be used in the same way.

     Though the files on the PROGRAM DISK (drive A) are not
displayed in the SAVE PICTURE function, it is possible to save
a picture to the PROGRAM DISK by specifying the proper
pathname.  You would do this only when making changes to your
"scrapbooks" which are on the PROGRAM DISK.  You especially do
not want to overwrite BOOKD.MMP on the program disk as it
contains the letters for BIGFONT (see ADVANCED APPLICATIONS).
To guard against this, be sure to make a working copy of your
MYMOUSE PROGRAM DISK and keep the MASTER copy in a safe place.
This way, if you should accidentally overwrite a "scrapbook"
you can retrieve it from your MYMOUSE MASTER disk.  You can
also first GET your picture (see below) and save it to your
PORTFOLIO DISK so nothing is lost.  Further recommended here
is that you keep back-up copies of all MYMOUSE portfolio
disks.

     When you save a picture MYMOUSE returns you to the
PLEXUS.









     4. GET PICTURE.  This function is called from the PLEXUS
by pressing the speed key "G".

G    The words GET PICTURE appear, written vertically, to
E    the left of the MYMOUSE graphics screen.  This function
T    will retrieve to the monitor any picture saved on either
     the PROGRAM or PORTFOLIO DISK.
P    You must remember that the PROGRAM DISK contains your
I    "scrapbooks" "BOOKA.MMP", "BOOKB.MMP", "BOOKC.MMP", and
C    "BOOKD.MMP", and what is on them.  GET PICTURE functions
T    as does SAVE PICTURE, requiring the same type of input
U    at the prompt.
R    When a picture is retrieved with GET PICTURE it will
E    overwrite any picture currently on the monitor screen.

     When you GET a picture, MYMOUSE returns you to the
PLEXUS.

     5. KILL PICTURE.  This function is called from the PLEXUS
by pressing the speed key "K".

K    The words KILL PICTURE appear, written vertically, to
I    the left of the MYMOUSE graphics screen.  After entering
L    the file name of the picture you wish to KILL, you will
L    hear a warning beep, followed by a screen instructing you
     on how to proceed and finally followed by another beep.
P    To kill a picture means to delete the file from the
I    PORTFOLIO DISK.
C
T    KILL PICTURE may sound a bit harsh, but is GW-BASIC's
U    standard delete statement, and is used here to sort of
R    sound an alarm so you are sure you want the file deleted.
E

     After acting on the warning screen, MYMOUSE returns you
to the PLEXUS.

     6. QUIT PROGRAM.  This function is called from the PLEXUS
by pressing the speed key "F1".

     QUIT PROGRAM exits MYMOUSE and returns control to MS-DOS.
Be sure you have saved any picture you want to keep!

     Note:  The remaining two MYMOUSE functions; FORMAT and
PRN4MAT, are covered in the ADVANCED APPLICATIONS section.

                             TOOLS

     MYMOUSE has 18 tools available at all times:

1.  DRAW                           10.  CLIP/PASTE
2.  LINES                          11.  MERGE
3.  GUIDELINES                     12.  FLIP HORIZONTAL
4.  BOXES                          13.  FLIP VERTICAL
5.  CIRCLES                        14.  FLIP QUARTER
6.  ARCS                           15.  FLIP ROTATE
7.  TRIANGLES                      16.  ERASE
8.  TEXT                           17.  WASH
9.  PAINT                          18.  QUIT PICTURE

Note: The remaining six MYMOUSE tools; BIGFONT, CUBES,
DIGIFONT, GABLES, PYRAMIDS and 3D are covered in the ADVANCED
APPLICATIONS section.


     IMPORTANT NOTE ON THE TOOLS: All of the tools are called,
one at a time, from the PLEXUS with the speed keys indicated.
When a tool is called it's name appears, written vertically,
to the left of the MYMOUSE graphics screen.  THE LEFT MOUSE
BUTTON ACTIVATES THE TOOL, AND, ON TOOLS THAT DON'T
AUTOMATICALLY RETURN YOU TO THE PLEXUS, THE RIGHT MOUSE BUTTON
RETURNS YOU TO THE PLEXUS.
     If you cannot see the cursor, move the mouse upward
and/or to the left.

     1. DRAW.  This tool is called from the PLEXUS by
pressing the speed key "D".

D    The DRAW cursor always appears in the first canvas when
R    DRAW is called.  To locate it in another canvas, refer to
A    the section CANVASES AND GUIDELINES.  DRAW is a freehand
W    drawing tool.  Position the cursor by moving the mouse
     to the desired location.  When you wish to begin drawing,
simply press and hold down the left mouse button and a white
line is drawn at the tip of the arrow cursor.  To stop
drawing, simply release the left mouse button.  You can then
reposition the cursor, press the left mouse button and draw
some more, or you can press the right mouse button to return
to the PLEXUS.



     2. LINES.  This tool is called from the PLEXUS by
pressing the speed key "L".

L    The LINES cursor appears in canvas 7 ( see CANVASES AND
I    GUIDELINES).  Position the cursor by moving the mouse.
N    You will notice a question mark beneath the word LINES
E    to the left of the MYMOUSE graphics screen.  This is
S    because regular (white) LINES and GUIDELINES (cyan) share
     this routine in MYMOUSE.  To draw a white line, position
?    the cursor to where you want the line to begin, then tap
     the speed key "W" at the same time as you press and hold
down the left mouse button.  The cursor will disappear, and,
as you move the mouse a yellow line will extend from the spot
where you first pressed the left mouse button to wherever you
move the mouse.  When you have positioned the line where you
want it, release the left mouse button and, after a brief
pause, a white line appears.  Do not be disturbed if the
yellow line disrupts a portion of your picture - it will be
replaced intact when you release the left mouse button.  You
can now draw another line or press the right mouse button to
return to the PLEXUS.

     3. GUIDELINES.  This tool is called from the PLEXUS by
pressing the speed key "L".

L    The GUIDELINES cursor appears in canvas 7. (See CANVASES
I    AND GUIDELINES).  GUIDELINES functions exactly as LINES,
N    above, except that you tap the speed key "G" as you press
E    and hold the left mouse button.  Further, the line drawn
S    when you release the left mouse button is cyan.
     GUIDELINES are extremely helpful in "lining up" items on
?    the MYMOUSE graphics screen, and can easily be erased by
     painting them out with black (see PAINT).  If you
position your GUIDELINES over existing white lines, gaps will
be left when the GUIDELINES are erased, so it is best to avoid
this where possible.  As with LINES, above, you may draw more
than one GUIDELINE or return to the PLEXUS by pressing the
right mouse button.








     4. BOXES.  This tool is called from the PLEXUS by
pressing the speed key "B".

B    The BOXES cursor appears in canvas 7. (See CANVASES AND
O    GUIDELINES).  Position the cursor by moving the mouse.
X    When the point of the cursor is where you want to start
E    drawing your box, press and hold down the left mouse
S    button.  The cursor will disappear and, as you move your
     mouse, a yellow box will appear with one corner being
where you first pressed and held down the left mouse button.
Move the mouse until you have your box positioned where you
want it, then release the left mouse button.  After a slight
pause a white box appears.  Do not be disturbed if portions of
your picture are disrupted when the yellow box line is moving
- they will be restored intact when you release the left mouse
button.  You can now reposition the cursor to draw another box
or press the right mouse button to return to the PLEXUS.

     5. CIRCLES.  This tool is called from the PLEXUS by
pressing the speed key "C".

C    The CIRCLES cursor appears in canvas 7.  (See CANVASES
I    AND GUIDELINES). Position the cursor by moving the mouse.
R    The tip of the cursor will end up being the center of the
C    circle.  When you are ready to draw your circle press and
L    hold down the left mouse button.  Now move the mouse to
E    the right and then down and a yellow circle (or other
S    ellipse) will begin flashing.  When you have your circle
     positioned where you want it, release the left mouse
button and, after a short pause, a white circle will appear.
Do not be disturbed if portions of your picture are disrupted
by the yellow circle - they will be replaced intact when you
release the left mouse button.  You may now reposition the
cursor and draw another circle or press the right mouse button
to return to the PLEXUS.

TIP: If you wish to draw concentric circles, first place a
single dot with the DRAW tool where you want the center of
all the circles to be.  The "guide" dot can be erased when the
circles are completed.






     6. ARCS.  This tool is called from the PLEXUS by pressing
the speed key "A".

A    The ARCS cursor appears in - and must be used only in -
R    canvas 7.  There are two steps to drawing an arc.  First
C    you position the cursor to draw a "start line".  When
S    the cursor is positioned, you tap the speed key "L" and
/    press and hold down the left mouse button.  You now draw
T    a yellow line, just as you did in LINES, except that this
R    time when you release the left mouse button the line will
I    remain yellow.  Time for the second step.  Reposition the
A    cursor along the yellow line and tap the speed key "A"
N    while you press and hold down the left mouse button.  The
G    yellow start line disappears, and, as you move the mouse,
L    an arc is formed by a yellow, pulsating line.  When you
E    have positioned the arc where you want it, release the
S    left mouse button and, after a short pause, a white arc
     takes the place of the yellow arc.  Do not be disturbed
if part of your picture is disrupted by the yellow lines -
everything will be restored intact when you release the left
mouse button.  You may now reposition the cursor to draw
another arc or press the right mouse button to return to the
PLEXUS.

     For best results in drawing arcs, always draw your start
lines from left to right or top to bottom.  If the line is
diagonal the program will interpret it as left to right or top
to bottom depending on which direction is the longest.

     ARCS and TRIANGLES share the same routine in MYMOUSE, as
you probably guessed from above.  Be careful to just tap the
speed keys that begin the start line, arc draw, and triangle
draw, as holding them down can result in your cursor not
returning when it should.  If this should happen just hold the
mouse still and press and release the left mouse button until
the cursor reappears.










     7. TRIANGLES.  This tool is called from the PLEXUS by
pressing the speed key "A".

A    The TRIANGLES cursor appears in canvas 7.  (See CANVASES
R    AND GUIDELINES).  As mentioned above, ARCS and TRIANGLES
C    share the same routine in MYMOUSE.  Therefore the first
S    step (the "start" line) for TRIANGLES is identical to
/    the first step for ARCS.  When you have your start line,
T    reposition your cursor along it and tap the speed key "T"
R    while you press and hold down the left mouse button.
I    The cursor disappears and a flashing yellow triangle
A    appears.  Now move the mouse around until you have your
N    triangle placed where you want it.  When your triangle
G    is placed where you want it, release the left mouse
L    button and, after a short pause, a white triangle will
E    appear.  Do not be disturbed if the yellow triangle
S    disrupted parts of your picture - they will be replaced
     intact when you release the left mouse button.  You can
now draw another triangle or press the right mouse button to
return to the PLEXUS.


     8. TEXT.  This tool is called from the PLEXUS by pressing
the speed key "T".

T    The TEXT cursor appears in canvas 7.  (See CANVASES AND
E    GUIDELINES).  Position the cursor by moving the mouse.
X    When you are ready to begin TEXT writing, simply press
T    and release the left mouse button and a TEXT cursor will
     appear.  This cursor can be manipulated with the arrow
keys without disturbing your picture.  When you are ready to
begin TEXT writing just enter input from the keyboard.  This
can be the standard TEXT as you are reading now, or special
characters are available by pressing and holding down the
[ALT] key while you type in their ASCII codes ON THE NUMERIC
KEYPAD and then release the [ALT] key.  A diagram of these
special characters, along with their ASCII code numbers, is
provided in appendix A.

     TEXT has some special features.  For one thing, when you
enter TEXT from the keyboard it will erase anything already on
the monitor.  This makes the TEXT cursor a very effective
eraser if you just line it up (using the arrow keys - it
doesn't erase here, remember) with what you want erased and
then press the space bar until it has erased what you wish to
get off the screen.  But except for moving the TEXT cursor
forward with the space bar to erase, or when actually writing
TEXT, ALWAYS USE THE ARROW KEYS TO MOVE THE TEXT CURSOR.  A
backspace can disrupt the border of your MYMOUSE graphics
screen.  This is NOT a problem that will be caught by the
ERROR TRAP.  Also, NEVER hit the [Enter] key when the TEXT
cursor is in the bottom line of the MYMOUSE graphics screen.
This, too, will disrupt your picture and is NOT a problem that
is intercepted by the ERROR TRAP.  If you find yourself in the
bottom column of the MYMOUSE graphics screen with the TEXT
cursor, just use the arrow keys to move it up and away from
all borders before you strike [Enter].

     Striking [Enter] causes the TEXT cursor to disappear and
the MYMOUSE arrow cursor to reappear.  You can now press
the right mouse button to return to the PLEXUS.


     9. PAINT.  This tool is called from the PLEXUS by
pressing the speed key "P".

P    The PAINT cursor appears in canvas 7.  (See CANVASES AND
A    GUIDELINES).  Position the cursor by moving the mouse.
I    When you are ready to PAINT (remember - the tip of the
N    arrow cursor marks the spot!) simply press the desired
T    speed key (listed below) for the color or pattern you
     want and press the left mouse button.  Release both the
speed key and mouse button as soon as PAINTing starts.  If an
occasional "spike" causes you to PAINT an area you hadn't
intended to, just go to that area and PAINT with black.  Black
is the MYMOUSE background color and will erase other colors
EXCEPT WHITE and all patterns EXCEPT PATTERNS [F7] AND [F8].
You can move about the MYMOUSE graphics screen PAINTing your
pictures with different colors as you go.  When you are done,
simply press the right mouse button to return to the PLEXUS.

MYMOUSE PAINT COLORS AND THEIR SPEED KEYS:


1.  "K"  BLACK                     9.  "W"  WHITE
2.  "E"  BROWN                    10.  "Y"  YELLOW
3.  "B"  BLUE                     11.  "b"  LIGHT BLUE
4.  "G"  GREEN                    12.  "g"  LIGHT GREEN
5.  "C"  CYAN                     13.  "c"  LIGHT CYAN
6.  "R"  RED                      14.  "r"  LIGHT RED
7.  "M"  MAGENTA                  15.  "m"  LIGHT MAGENTA
8.  "V"  DARK GRAY                16.  "v"  GRAY

    (For lower case letters with caps lock on use [Shift])

There are also six patterns available:

        [F7]   [F8]   [F9]   [F10]   [F11]   [F12]

     A little experimentation will show you what these colors
and patterns look like on the monitor.

     SPECIAL NOTE: White is the border color for MYMOUSE and
cannot be PAINTed out with any other color.  Patterns [F7] and
[F8] cannot be completely PAINTed out either, since they
contain white in them.  So, if you are going to PAINT with
white, be sure your picture is saved first.  This will prevent
an errant "spike" from PAINTing an area white which you did
not want white.  If your picture is saved you can just press
GET PICTURE and bring it up without the blemish to be
rePAINTed.  Also, don't use patterns [F7] and/or [F8] unless
you are sure you want them, as they can only be partially
PAINTed out.

     10. CLIP/PASTE.  This tool is called from the PLEXUS by
pressing the speed key "c" ([Shift] [C] when caps locks is
on).

C    The CLIP/PASTE cursor appears in canvas 7.  (See CANVASES
L    AND GUIDELINES). Position the cursor by moving the mouse.
I    CLIP/PASTE is a very useful tool that lets you copy
P    portions of the MYMOUSE graphics screen and move them
/    to other areas of the MYMOUSE graphics screen.  When
P    CLIP/PASTE copies a portion of the screen (it is capable
A    of copying an area as large as 1/7th of the screen), it
S    DOES NOT erase the area copied.  Instead, it "picks up"
T    the graphics you marked and allows you to move them to,
E    and insert them at, another area of the MYMOUSE graphics
     screen.  This can be very handy for copying exact
     duplicates of graphics images, and is the primary tool
     for getting pictures from your "scrapbooks".

     To begin a CLIP/PASTE operation, you must start by
marking the graphics area you want copied.  First position
your cursor at a spot that would mark the upper left hand
corner of a box that is going to hold the graphics that you
want to CLIP/PASTE.  Now press the speed key "X" to set a
white point.  Next move the cursor to a spot that would mark
the lower right hand corner of a box that is going to hold the
graphics you want to CLIP/PASTE.  Press the speed key "Y" to
set a second white dot here.  Return your cursor to the spot
marking the upper left hand corner of the box and...bring on
the mouse!

     Press and hold down the left mouse button.  The area of
the graphics screen picked up by CLIP/PASTE will begin to
blink.  (If you tried to pick up an area too large for
CLIP/PASTE to handle, you will hear a little musical ditty,
then can start again.)  Holding the mouse button down, you can
now move the image to another area of the screen.  When it is
positioned where you want it just release the left mouse
button and it will be put in its new place.  The CLIP/PASTE
graphics will not disturb other graphics as it passes over
them, though you may notice some temporary color changes.

     You can now CLIP/PASTE another graphics area or return to
the PLEXUS by pressing the right mouse button.

     CAUTION.  The area of the graphics screen picked up by
CLIP/PASTE is still "in the left mouse button" after it has
been moved.  Pressing the left mouse button will bring it up
again - often with unexpected results.  It is best to pick up
the area of the graphics screen with CLIP/PASTE and then use
the MERGE tool (below) for placing it elsewhere on the MYMOUSE
graphics screen.  To do this, simply mark your box as
described, position the cursor at the upper left hand corner
of the box and press the left mouse button until the graphics
you picked up in CLIP/PASTE begin to blink.  DO NOT MOVE THE
MOUSE.  Instead just release the left mouse button, leaving
the graphics intact, then use the right mouse button to return
to the PLEXUS, from which you go into MERGE.  This is not only
a good idea in general, but a MUST when getting graphics from
one picture (a "scrapbook", say), and then MERGEing them into
another picture.










11. MERGE.  This tool is called from the PLEXUS by
pressing the speed key "M".

M    The MERGE cursor appears in canvas 7.  (See CANVASES AND
E    GUIDELINES).
R
G
E    When positioning the MERGE cursor keep in mind
     three things.  First, remember the size of the graphics
image held in the MERGE cursor.  Second, remember that the
graphics image in the MERGE cursor will always appear to the
right of and below the cursor.  Third, you have more precise
control in canvases 1 through 6 than you have in canvas 7.

     Position the cursor.  Press the left mouse button and the
MERGE image will appear, flashing.  You can now move the image
about the MYMOUSE graphics screen until you have it right
where you want it.  The MERGE image will not disturb other on-
screen graphics as it passes over them and can be put on top
of other images, if desired.  When you release the left mouse
button the MERGE image is put onto the MYMOUSE graphics
screen.  The image is still in the MERGE cursor and can be
placed at any other location you desire on the MYMOUSE
graphics screen as often as you want by simply following the
instructions above.  When you wish to exit the MERGE tool,
press the right mouse button to return to the PLEXUS.

     A very important difference between the CLIP/PASTE and
MERGE images.  If you put a CLIP/PASTE image over other
graphics it will combine with them, resulting in some color
changes.  The same is true of the MERGE image, but it will
also erase any identical item it is put over!  Also, when you
put a MERGE image on a color other than black you get a new
color for the image.  This can help in your creativity, and a
COLOR MERGER TABLE is provided in Appendix A for your
convenience.  So the MERGE image can be used as an eraser when
the image is put over an identical on-screen image.

     So, with CLIP/PASTE and MERGE you can move images about
the same MYMOUSE graphics screen, or CLIP/PASTE an image from
one MYMOUSE graphics screen - use GET PICTURE to bring up
another MYMOUSE graphics screen (picture) - then use MERGE to
transfer the graphics to the new MYMOUSE graphics screen.

     Pretty handy.  And, when used with the FLIP tools, below,
it is easy to see how combining these tools with FLIP makes
for a truly powerful way of creating perfectly symmetrical
graphics!

     12. FLIP HORIZONTAL.  This tool is called from the PLEXUS
by pressing the speed key "F".

F    The FLIP tools have no cursor, and all four of them share
L    the same MYMOUSE routine.  To FLIP HORIZONTAL, merely
I    press the speed key "H".  MYMOUSE then automatically
P    initiates a horizontal flip of the picture.  When the
     FLIP is complete, MYMOUSE executes an AUTOMATIC PLEXUS
H    RETURN.  It is important that, after starting a FLIP,
/    you wait for MYMOUSE to return to the PLEXUS before
V    doing anything else.
/
Q    Notice that the mouse was not used at all with this tool.
/    As with most MYMOUSE functions/tools, however, the right
R    mouse button will return you to the PLEXUS if you press
     it BEFORE you initiate the function/tool.

     13. FLIP VERTICAL.  This tool is called from the PLEXUS
by pressing the speed key "F".

     The details here are exactly the same as in FLIP
HORIZONTAL, above, except that you press the speed key "V"
when you want a FLIP VERTICAL.

     14. FLIP QUARTER.  This tool is called from the PLEXUS by
pressing the speed key "F".

     FLIP QUARTER is a special tool that is used for creating
special effects with individual keyboard characters.
Therefore, it is almost always desirable to initiate FLIP
QUARTER from a blank MYMOUSE graphics screen.

     After calling the FLIP tool from the PLEXUS, merely press
the speed key "Q".  A text cursor will appear in the upper
left hand corner of the MYMOUSE graphics screen.  Now type in
a single keyboard character (can be a special [ALT] character
- see TEXT), and press [Enter].  MYMOUSE automatically
executes three quarter (90 degree) rotations of the keyboard
character you entered, then executes an AUTOMATIC PLEXUS
RETURN (APR).  From here it is up to CLIP/PASTE, MERGE,
GUIDELINES and your creative imagination.

     Again note that the mouse was not used here, though it
could have been used to return to the PLEXUS before the
FLIP QUARTER was initiated.  FLIP QUARTER is a very handy tool
for placing text "sideways", and is not found in other mouse
graphics programs.

     15. FLIP ROTATE.  This tool is called from the PLEXUS by
pressing the speed key "F".

     FLIP ROTATE is another special tool not found in other
mouse graphics programs.  FLIP ROTATE is initiated by pressing
the speed key "R".  MYMOUSE then automatically takes a 140 x
140 pixel square in the upper left hand corner of the MYMOUSE
graphics screen and rotates it ninety degrees (lays it on its
side) on the right side of the MYMOUSE graphics screen, then
executes an AUTOMATIC PLEXUS RETURN.  Because there are in
excess of 39,200 steps required to complete a FLIP ROTATE,
this tool is time consuming.  Be sure not to take any further
action until MYMOUSE executes the AUTOMATIC PLEXUS RETURN.

     FLIP ROTATE has its primary use in rotating (turning)
large graphics figures.  Usually these are special or unique
graphics figures which you wish to display at another angle,
but would find difficult to redraw.  Remember CLIP/PASTE and
MERGE!

     Again, the mouse is used only if you wish to escape the
tool before initiating a FLIP ROTATE, in which case you would
press the right mouse button to return to the PLEXUS.

     16. ERASE.  This tool is called from the PLEXUS by
pressing the speed key "E".

E    The ERASE cursor always appears in the first canvas when
R    ERASE is called.  To locate it in another canvas, see the
A    section CANVASES AND GUIDELINES.  ERASE is a fine, or
S    detail, eraser which is extremely useful for working in
E    small areas. It erases at the point of its arrow cursor.
     Position the cursor by moving the mouse.  When you are at
a position where you wish to erase, press and hold down the
left mouse button.  You may now move the mouse about, erasing
as you go.  When you release the left mouse button erasing
stops and you can either reposition the cursor for more
erasing or press the right mouse button to return to the
PLEXUS.


     17. WASH.  This tool is called from the PLEXUS by
pressing the speed key "W".

W    The WASH cursor (a yellow box instead of the standard
A    arrow cursor) appears in canvas 7.  (See CANVASES AND
S    GUIDELINES).  Position the cursor by moving the mouse.
H    WASH is a sort of "bulk" eraser which erases an area
     the size of its cursor.  When your cursor is where you
wish to begin erasing, press and hold down the left mouse
button.  You may now move about, erasing as you go.  When you
release the left mouse button WASHing stops.  You can now
reposition the cursor to WASH again or press the right mouse
button to return to the PLEXUS.


     18. QUIT PICTURE.  This tool is called from the PLEXUS by
pressing the speed key "Q".

     Calling QUIT PICTURE from the PLEXUS causes MYMOUSE to
automatically erase the entire screen and bring up a new,
empty, MYMOUSE graphics screen, then execute an AUTOMATIC
PLEXUS RETURN.  BE SURE YOU DO NOT USE THIS TOOL ON AN UNSAVED
PICTURE THAT YOU WANT TO KEEP.

     NOTE that here the mouse is not used at all - it cannot
even be used to escape the tool!

SPECIAL NOTE.  MYMOUSE has SIX erasers available: ERASE, WASH,
PAINT, MERGE, QUIT PICTURE, and THE TEXT CURSOR.  And more in
the ADVANCED APPLICATIONS section!
























                      FUNCTION/TOOL INDEX



                      ARCS  12
                      BOXES  11
                      CIRCLES  11
                      CLIP/PASTE  15
                      DRAW  9
                      ERASE  19
                      ERROR TRAP  5
                      FLIP HORIZONTAL  18
                      FLIP QUARTER  18
                      FLIP ROTATE  19
                      FLIP VERTICAL  18
                      GET PICTURE  8
                      GUIDELINES  10
                      KILL PICTURE  8
                      LINES  10
                      MERGE  17
                      PAINT  14
                      PRINTER GRAPHICS  6
                      QUIT PICTURE  20
                      QUIT PROGRAM  8
                      SAVE PICTURE  6
                      TEXT  13
                      TRIANGLES  13
                      WASH  20










                 MYMOUSE ADVANCED APPLICATIONS


     Now that you are familiar with the basic functions/tools
of MYMOUSE it is time to look at some of the more advanced
possibilities available.

     First, let's look again at the CLIP/PASTE and MERGE tools
that we have already discussed.  As mentioned, CLIP/PASTE can
pick up an area equal to approximately 1/7th of the MYMOUSE
graphics screen.  So what if the image you want to shift is
larger than that?  You can still use CLIP/PASTE and/or MERGE
to move it.  If the image is to be shifted on the same
graphics screen you will just need CLIP/PASTE.  If the image
must be transferred from one picture to another, you pick it
up with CLIP/PASTE, get your new picture and lay it down IN
PIECES on the new picture with MERGE.  In all cases the final
recombining of the image MUST be done with CLIP/PASTE.

     First, pick up as much of the graphics which you wish to
move as CLIP/PASTE will allow.  Using CLIP/PASTE, move the
image to its new location on the screen.  Release the left
mouse button to put the image at the new location.  Now go
back and pick up more of the image with CLIP/PASTE.  Be sure
the new section overlaps part of what you moved first, and now
move the new image until it is aligned perfectly (in the
overlapping area) with the first image you shifted.  Release
the left button and they combine to form the new, larger
image.  Repeat as often as necessary until you have shifted
the entire graphics.  This takes practice, but can be well
worth it.

     Also regarding CLIP/PASTE:  as you know, if you put a
CLIP/PASTE image on top of another image and then press the
left mouse button again you will find that you now have a
combination of the original image and the image which the
original was put on top of.  This can sometimes be annoying if
you happen to shift the mouse slightly in your initial pick up
of an image in CLIP/PASTE, since it results in a sort of
"double image" which distorts your graphics.  To be safe,
mark your CLIP/PASTE area as described on pp 15-16 then move
your cursor to a black area of the screen if you have one.
NOW press the left button and let the CLIP/PASTE image come up
on black.  Release the left button and leave it there.  From
here you go into MERGE.  By putting the MERGE image directly
over any identical on-screen image (until they begin to blink
in unison) and releasing the left mouse button, you erase the
on-screen image.  You can now use MERGE to place the image
wherever you want it.

     This approach can be a real time saver for things like
putting text on a background color.  We will find out later
about formatting and color mergers, but here is the basic idea
of how to put text on a background color without having to go
back and painstakingly paint in all the closed areas of the
text:

     Set up and paint the area where your text will be placed.
Now type the text in a black area of the MYMOUSE graphics
screen using TEXT.  Pick up the text with CLIP/PASTE and move
it to another black area.  Go into MERGE and put your text
onto the background color.  Finally, use MERGE to erase the
text in the black areas of the screen by placing the MERGE
image directly over them and releasing the left mouse button.

______________________________________________________________

                         IMPORTANT!!!

     A couple of final words before we go into the ADVANCED
APPLICATIONS:  it is a good idea to keep formatted disks handy
in case you go to SAVE a picture and find your disk is full.
Any formatted disk with enough room on it will do - if
necessary the picture can always be later transferred by
MYMOUSE or MS-DOS to a PORTFOLIO DISK.

     ZERO.NET is a picture you can not do without!  This
picture is necessary to prevent a critical error when running
the advanced applications and must be on disk before you run
any advanced application.  Therefore, it is strongly
recommended that when you create a new MYMOUSE PORTFOLIO DISK
you go into MYMOUSE and when you arrive at the PLEXUS for the
first time SAVE the blank MYMOUSE graphics screen to your
PORTFOLIO DISK as "B:ZERO.NET".

______________________________________________________________






                      ADVANCED FUNCTIONS


     1.  FORMAT.  This function is called from the PLEXUS by
pressing the speed key [F4].

     FORMAT controls the background and text colors of
MYMOUSE.  The background color is defined as the color up to
which MYMOUSE will paint.  When FORMAT is called the screen
clears, and colors 1 through 15 are displayed, along with a
prompt asking you to select a text color.  You enter the
appropriate color number at the prompt (chosen from the colors
listed on the FORMAT screen), press [Enter], and you are
prompted to select a new background color.  Again, you enter a
number and press [Enter].  You are then returned to your
picture and the border of the MYMOUSE graphics screen turns to
the background color.


     Black (color 0) is not shown on the format screen. Black
is not a legal text color, but can be entered as a background
color.  If you input illegal number values at the FORMAT
prompt they are rejected and you are prompted again to select
a color.  Should you enter a character other than a number at
the FORMAT prompt the message: "?Redo from start" will appear.
If this happens, just enter a legal number and MYMOUSE will
continue.

     As mentioned, black (color 0) is not a legal text color.
However, if you want black text you can have it by FORMATting
your text color to the same color as the background on which
you wish to place it.  Then simply type the text in a black
area of the screen and use CLIP/PASTE and MERGE to pick it up
and then put it on the background color.  When you MERGE a
color onto itself the result is black (an eraser).

     ---Did you remember to use MERGE to erase the text you
placed in the black area of the screen?---

     FORMATted pictures have the obvious advantage of not
having white lines around every figure on the graphics screen
and can make a very big difference in how your picture looks.
You control what colors the original 18 tools produce now!
But don't get power mad - there are dangers here, too.  The
biggest thing to keep in mind is when PAINTing.  PAINT will
paint over everything but the current background setting!  It
is easy to see that some careful planning and liberal SAVEing
are in order.  Some experience with FORMAT will show it to be
a very useful, and friendly function.  Have some fun
experimenting.

     Changing your background color will affect your MYMOUSE
guidelines as well as the start lines, etc. in the other
tools.  Though their colors have changed, they still function
in the same manner.  One area that needs to be kept in mind is
if you should use LINES.  If you recall, we press the speed
key "W" for a white line.  Well, the speed key remains the
same after using FORMAT, but the line will come out whatever
color you specified for a background color.

     As a final note on FORMAT:  when you set the text color
here it is used by both TEXT and DIGIFONT, which we will be
looking at later.  So, if you want a special text color for
DIGIFONT be sure to FORMAT to that text color before going
into DIGIFONT.

     2. PRN4MAT This function is called from the PLEXUS by
pressing the speed keys [Alt] [P] simultaneously.

     SAVE your picture before using this function!

P    This function is primarily for changing colors in
R    FORMATted pictures for the purpose of a print-out.  It is
N    also handy for changing the colors of BIGFONT, which we
4    will look at later.  When PRN4MAT is called the drive
M    whirs and you end up with the function name to the left
A    of the MYMOUSE graphics screen.  When the drive light
T    goes out, press the left mouse button.  The screen clears
     and you arrive at the PRN4MAT help screen.  Colors are
     displayed, this time with letter choices for each, and a
help box is written in.  Finally, there appears at the bottom
of the screen a prompt.  Be sure to wait for the prompt at the
bottom of the help screen before taking any action.

     Follow the on-screen instructions carefully.  When you
enter a color choice DO NOT press [Enter], MYMOUSE will handle
the input.  After your final input the last prompt (W), and
your response to it will remain on screen.  When you press the
right mouse button your picture returns with the word
"editing" written vertically to the left of the MYMOUSE
graphics screen.

     The PRN4MAT edit is very slow.  It systematically checks
over 57,000 individual pixels for up to as many as sixteen
colors and edits them, then returns you to the PLEXUS.  You'd
be slow, too.  The fewer colors that are being changed the
faster PRN4MAT is.  Note that the letters used to designate
each color are the same ones we use in PAINT.

     To speed things up a bit, you can press the right mouse
button at any time during the edit and return to the PLEXUS.

IT IS VERY IMPORTANT THAT YOU OPERATE PRN4MAT EXACTLY AS SHOWN
ON SCREEN AND MENTIONED HERE.  IF YOU DO NOT A CRITICAL ERROR
FROM WHICH MYMOUSE CAN NOT RECOVER WILL OCCUR.



                        ADVANCED TOOLS


     1. CUBES.  This tool is called from the PLEXUS by
pressing the speed key "B".

C    Your cursor will appear in canvas 7 (see CANVASES AND
U    GUIDELINES), and "BOXES" will be written vertically to
B    the left of the MYMOUSE graphics screen.  CUBES is a
E    "tool within a tool."  First, you draw a box as outlined
S    in BOXES.  Having done this, press the speed key "Z".
     The word "CUBES" now appears to the left of the MYMOUSE
     graphics screen.  Simply position your cursor and draw a
second box.  When you release the left mouse button the two
boxes are joined by lines at their corners.  You are then
returned to BOXES.  This process, as outlined here, must be
repeated if you wish to draw another CUBE.  You must press the
right mouse button if you wish to return to the PLEXUS.

     2. PYRAMIDS.  This tool is called from the PLEXUS by
pressing the speed key "B".

P    As with CUBES, above, PYRAMIDS is a "tool within a tool"
Y    - and again the first tool is BOXES.  Draw your first
R    box as outlined in BOXES.  Now press the speed key "z"
A    ( [Shift] [Z] with caps lock on ) and the word
M    "PYRAMIDS" appears to the left of the MYMOUSE graphics
I    screen.  Position your cursor and press and hold down the
D    left mouse button.  Yellow (if you haven't FORMATted)
S    lines will pulsate from the corners of the box to the tip
of the cursor.  Move the cursor to where you want it and
release the left mouse button.  White lines come from each
corner of the box and converge at the same place.  You are
then returned to BOXES.  This process, as outlined here, must
be repeated if you wish to draw another pyramid.  You must
press the right mouse button if you wish to return to the
PLEXUS.

     3. GABLES.  This tool is called from the PLEXUS by
pressing the speed key "A".

G    ARCS/TRIANGLES will appear to the left of the MYMOUSE
A    graphics screen first for this "tool within a tool".
B    Follow the steps in TRIANGLES to create a triangle.
L    Now press the speed key "Z" and GABLES will appear to
E    the left of the MYMOUSE graphics screen.  Draw a second
S    triangle where you want it and when you release the left
     mouse button the two triangles will be connected by lines
from their corners.  You are then returned to ARCS/TRIANGLES.
If you wish to draw another GABLE you must follow the
procedure above.  Pressing the right mouse button will return
you to the PLEXUS.

     4. 3D.  This tool is called from the PLEXUS by pressing
the speed key "A".

3    ARCS/TRIANGLES will appear to the left of the MYMOUSE
D    graphics screen first for this "tool within a tool".
     Follow the steps in TRIANGLES to create a triangle.  Now
press the speed key "z" ( [Shift] [Z] with caps lock on ) and
3D will appear to the left of the MYMOUSE graphics screen.
Position your cursor where you want it and press and hold down
the left mouse button.  Yellow (if you have not FORMATted)
lines will begin to pulsate from the corners of the first
triangle to the point of the cursor.  Move the cursor to where
you want it and release the left mouse button.  When you do
lines are drawn from the corners of the triangle converging
where the cursor was last positioned.  You are then returned
to ARCS/TRIANGLES and must follow the steps outlined above if
you wish to make another 3D figure.  Pressing the right mouse
button will return you to the PLEXUS.






     5. DIGIFONT.  This tool is called from the PLEXUS by
pressing the speed keys [Alt] [D] simultaneously.

D    DIGIFONT loads slowly, so be patient.  Normally the
I    drive light comes on, there is a whir, then a long pause,
G    then DIGIFONT loads.  The word DIGIFONT appears to the
I    left of the MYMOUSE graphics screen and a cursor appears
F    blinking on screen.  The cursor can be moved with the
O    arrow keys to where you want it.  DIGIFONT is a text
N    tool that provides you with very small letters. (Did
T    you remember to FORMAT text to the desired color before
     entering DIGIFONT?)  The DIGIFONT text is typed in from
the keyboard and can later be CLIP/PASTEd and/or MERGEd if you
so desire.  Besides the arrow keys, the space bar causes the
cursor to move one space to the right.  If you need to erase a
character, place the cursor over it and press [Shift] [E].  If
you should accidentally go out of bounds with DIGIFONT you
will hear a beep and the cursor will be repositioned where it
was when DIGIFONT was first brought up.  Nothing is lost.

     Besides the letters of the alphabet (all caps), DIGIFONT
also has available the following characters:  plus; slash;
dollar sign; left parenthesis; right parenthesis; colon; semi-
colon; period; comma; question mark; exclamation point; dash
(also serves as a minus sign); apostrophe (two in a row
provide quotes); equals.

     Notice that the mouse is not used here.  Pressing the
speed keys [Alt] [M] simultaneously returns you to the PLEXUS.
YOU MUST RETURN DIRECTLY TO THE PLEXUS FROM DIGIFONT.

     6. BIGFONT.  This tool is called from the PLEXUS by
pressing the speed keys [Alt] [B] simultaneously.

B    Your picture is first saved as "B:ZERO.NET", then
I    BOOKD.MMP is loaded to screen and the word "getting..."
G    appears to the left of the MYMOUSE graphics screen.  At
F    this point all characters available to you in BIGFONT are
O    visible.  The dash doubles as a minus sign; two
N    apostrophes make a quote; the slash doubles for a
T    division sign; the X doubles for a multiplication sign.
     Obviously this is another text application and a cursor
appears in the upper left hand corner for these large letters.
The cursor can be positioned by the arrow keys, the [Return]
key, or the space bar will cause it to move one space right
and text is typed in from the keyboard.

     Striking over the same letter creates an eraser.  You are
protected by MYMOUSE from going out of bounds, but there is a
danger here, all the same.  DO NOT insert a comma or a semi-
colon at the bottom of the page.  This will result in a
critical error!

     Pressing the speed keys [Alt] [M] simultaneously returns
you to the PLEXUS.  YOU MUST ALWAYS RETURN DIRECTLY TO THE
PLEXUS FROM BIGFONT OR A CRITICAL ERROR WILL OCCUR.

     Remember PRN4MAT?  Of course you do.  If you wish to
change the colors of BIGFONT use PRN4MAT to do it, then
eventually SAVE your new colors as "A:BOOKD.MMP".  This must
be done before you go into BIGFONT and can be 'undone' by
simply recovering the original "A:BOOKD.MMP" from your master
disk, if you so desire.

     7. 8. ZOOM.  This tool is called from the PLEXUS by
pressing the speed keys [Alt] [Z] simultaneously.

Z    Before going into ZOOM bring up any MYMOUSE tool like
O    TEXT and be sure your cursor is in the middle of the
O    screen.  Having done this, return to the PLEXUS and go
M    into ZOOM.  On first entering ZOOM you will find a box
     cursor on screen.  If there is no cursor you will hear
the song "Three Blind Mice".  This is the Error Trap
functioning, and you will soon be told that you are probably
off the screen.  Move the mouse up and/or to the left and wait
until the cursor appears.  Position this cursor over the area
you want to edit and press the left mouse button.  The screen
will clear, and ZOOM, written vertically, will appear to the
left of the screen.  Also in the upper left hand corner of the
screen will appear the area of your picture which you selected
with the box cursor before pressing the left mouse button.  In
the upper right of the screen will appear the words "Row:",
and "Column:".  Now the main portion of the screen will fill
with an enlarged duplication of the art in the upper left hand
corner.  When the enlarged graphics are completed a cursor
appears, blinking, in the upper left hand corner of the
enlarged graphics, and on-screen instructions are displayed to
the left of the enlarged graphics.  If you select a black area
of the screen with the box cursor (which you might well do to
create new graphics) be sure to wait for your cursor and on-
screen instructions.
     The Row and Column at the upper right will tell you which
row and column the cursor is currently at.  Rows run
horizontally; columns vertically.  Pressing [F8] will give you
a graph overlay (especially useful in creating new graphics)
which will not be reflected on the original art in the upper
left hand corner of this edit screen and will not be
transferred back to your picture when you return to it.  The
arrow and tab keys controls movement of the cursor as
indicated, with no disruption to the graphics.  Also
controlling cursor movement without disrupting the graphics
are the space bar, which moves the cursor one space (pixel) to
the right, and the [Return], which moves the cursor down one
row and returns it to the first column.  If you strike the
HOLD key the cursor will either temporarily disappear or
"freeze" until you press HOLD again - there is no disruption
to your graphics here, either.

     ZOOM is really a graphics editor and custom graphics
maker in one - (it was the tool used to create the BIGFONT
characters, for instance) - that is why it is shown as
ADVANCED TOOLS 7 AND 8.  The area picked up by the cursor is
40 pixels wide and 30 pixels from top to bottom.  Position
your cursor where you want it on the enlarged graphics and
press a color speed key - these are the same keys used for the
PAINT tool, and they are listed in PAINT and on the back cover
of the instructions - when you do, the area on the enlarged
graphics is painted the color you chose and the corresponding
pixel in the original art in the upper left hand corner is
also painted the same color.  (Repainting of pixels can be
done at any time while on the edit screen.)  If you hold the
speed keys down the cursor will begin rapid movement.  Be
careful here, though.  If you should be going "full tilt" it
is possible to go off screen to the right or bottom.  Should
this happen, the ERROR TRAP is activated and you are returned
to your original picture - WITH ANY EDITING WORK DONE UP TO
THAT TIME LOST.  So exercise caution when approaching the
right side and/or bottom of the edit screen.

     ZOOM is a very powerful set of tools.  You can ZOOM in
for detail work which would otherwise be near impossible,
and/or you can create new graphics images with single pixel
precision!  It's a treat to work with and very precise.

     The final two instructions on the left of the edit screen
are very important. To return to your picture (RET) with the
changes you have made, press the right mouse button.  If, for
any reason, you wish to cancel your edit, press [Control]
[Home] and you are returned to the picture without any
changes.

     When you are through ZOOMing in and out you return to the
PLEXUS by pressing [Alt] [M] while your complete picture is on
screen (not at the edit screen).  [Alt] [M] IS THE ONLY LEGAL
WAY TO EXIT ZOOM - ANY OTHER ATTEMPT WILL RESULT IN A CRITICAL
ERROR FROM WHICH MYMOUSE CAN NOT RECOVER.

______________________________________________________________

     As a final note here, ADVANCED TOOLS have added three
more erasers to MYMOUSE.  They are:  1. DIGIFONT [Shift] [E];
2.  ZOOM paint over (especially black); 3. BIGFONT strikeover.
______________________________________________________________














                ADVANCED FUNCTIONS/TOOLS INDEX


             BIGFONT...........................28
             CUBES.............................26
             DIGIFONT..........................28
             FORMAT............................24
             GABLES............................27
             PRN4MAT...........................25
             PYRAMIDS..........................26
             ZOOM..............................29
             3D................................27




                  SUPPLEMENTAL PROGRAMS DISK


     If you are using 5.25 diskettes you have a SUPPLEMENTAL
PROGRAMS DISK (3.5 disks contain all MYMOUSE programs on one
disk).  On it are some of the programs we have referred to so
far, as well as some MYMOUSE pictures which make up Appendix
A.  Also on this diskette are "GC4MAT-R.MMP" and
"GC4MAT-T.MMP".  These two pictures are helpful for setting up
greeting cards as per the following.

                        GREETING CARDS

     If you are going to print out in TMODE, select
"GC4MAT-T.MMP" (mentioned above) - if you are going to print
in TMODE/R, select "GC4MAT-R.MMP".

     First SAVE your "GC4MAT" picture under two different
names.  Now bring up the first picture and do the front cover
of your greeting card on the RIGHT hand side of the screen.
Then do the back cover on the LEFT hand side.  Next FLIP your
picture horizontally, then vertically and SAVE it.  Bring up
your second "GC4MAT" picture and treat it just like the inside
of the card (that's what it is), and SAVE it.  This way you
can put graphics on all four pages of a greeting card.

     Paper location in your printer is critical for printing
out greeting cards, as you have very little room to spare.
Line your paper up very carefully and print your first
picture.  Next, roll the paper back a little and print your
second picture.  Now remove the card from the printer, fold it
into four pages and you are all set.  Positioning the paper in
the printer may take some practice.

                CALCULATING SCREEN COORDINATES

     When creating MYMOUSE graphics for use in other programs
it is often necessary to know the screen coordinates of a
certain spot (or spots) in your picture.  To help in
calculating this, bring up your TEXT cursor.  It is 8 pixels
wide by 8 pixels high.  The upper left hand coordinates of the
MYMOUSE graphics screen are 11 horizontally and 2 vertically.
By placing your text cursor in the upper left hand corner of
the MYMOUSE screen and counting how many cursor movements
horizontally (x8) and vertically (x8) you arrive at the actual
screen coordinates for use in your other program.