### GWBASIC Source Code Libraries of General Purpose Routines

placed in the public domain by Gary Peek  
from Gary Peek's BASIC Source Code Archive

As I was writing DOS based BASIC programs over the years I found the
need, (as many programmers who used BASIC did), for general purpose
subroutines that could be used with the programs I was writing. At one
time I even packaged a well documented set of routines for sale. The
result of this work was [ROUTINES.BAS](routines.bas).

It has features that you have seen on many older DOS programs like
shadowed boxes with selectable color combinations. I actually put too
much effort into putting all these features in it, because I reverted to
using (and still use) just a monochrome subset of these routines in
[ROUTSMAL.BAS](routsmal.bas). I also continue to make slight
improvements to ROUTSMAL when I have the need.

I recommend ROUTSMAL over ROUTINES except to learn how to do something
or to copy a routine you need that is not in ROUTINES. Also, the line
numbers between the two are different. *Keep in mind that some of the
test programs and other complete programs described on other pages may
use some of these routines in a way that demonstrate them better or
better provides a way to extract them for your uses.*

The subroutine that started it all was [EDITSUB.BAS](editsub.bas), a
replacement for BASIC's INPUT statement, and is still useful if you need
something small.

Note: Some of the programs in the *Miscellaneous* section use some of
these subroutines *or earlier and simpler versions of them*. The
assembly language interface subroutine is the only place where it was
necessary to have different commands for GWBASIC and QuickBASIC, and it
is commented.

ROUTSMAL contains only the following:

-   outline the screen
-   display centered message
-   edit a field at row and column
-   select a file from the current directory
-   select a file from any directory on the disk
-   multiple selection menu
-   point and shoot menu of up to 9 items
-   scrolling point and shoot menu for &gt;20 and &lt;100 items

ROUTINES contains the following:

-   display and select colors for ROUTINES
-   outline the screen
-   erase line
-   display message at row and column
-   edit a field at row and column
-   message and field/date/time/dollar amount
-   enter or change date
-   enter or change time
-   enter dollar amount
-   wait for any key hit
-   delay in seconds
-   delay in seconds or key hit
-   wait for a function key hit
-   display and select file names (vertically)
-   display and select file names (wide)
-   point and shoot style menu
-   multiple selection on/off menu
-   full screen menu with work & prompt areas
-   erase menu work area
-   erase menu prompt area
-   display a bar graph
-   draw 1 bar for bar graph
-   create messages with large characters
-   display messages with large characters

The following require the assembly language interface:

-   get monitor type

    The following provide access to mouse function calls:

    -   hardware reset and status
    -   show cursor
    -   hide cursor
    -   get button status and mouse position
    -   set cursor position
    -   get button press info
    -   get button release info
    -   set cursor limits
    -   set graphics cursor
    -   set text cursor
    -   read motion counters
    -   set sensitivity and double speed
    -   get driver version, type, IRQ

This is the assembly language interface:

-   set up and call assembly language subroutine
-   load assembly language subroutine

ROUTINES is so large that there is not enough room in the GWBASIC
interpreter to include demo code to show how to use it, so I broke it
apart into files that include parts of ROUTINES and demo code. They are
as follows:

[ROUTDEMI.BAS](routdemi.bas), assembly language interface, mouse
support. This is a crude EGA graphics drawing program. (However, a
better graphics program can be found in the graphics program area.)

[ROUTDEMF.BAS](routdemf.bas), file selection. (However, ROUTSMAL has
monochrome file selection routines with more features.)

[ROUTDEMD.BAS](routdemd.bas), display and data entry.

[ROUTDEMG.BAS](routdemg.bas), block graphics, bar charts. All of these
work on monochrome monitors.

[ROUTDEMM.BAS](routdemm.bas), menus and menu selection. "Point and
shoot", toggle lists of items, etc.
