
Gary Peek's BASIC Source Code Archive
=====================================

http://www.garypeek.com/basic/

>    This section is dedicated to BASIC for the IBM PC and all the people who have written programs     using it and its variations, like IBM BASIC and BASICA, GWBASIC, QBASIC, and the QuickBASIC compiler.
Over the years I have written many programs in these languages, not only applications, but also many test programs. Therefore, I have a signifigant library of programs and routines written that can be used in these languages. Although I have been using the QuickBASIC compiler for a long time, I have always written my code to work even in GWBASIC, because I always found it convenient to work in the interpreter, (and I always wanted to program to the "lowest common denominator".)

>    Although there is much less "professional" programming being done now in these languages, I have found that there are still many people using them, and a lot of students learning to program in BASIC because its various languages are cheap or free. Because so many people are just beginning with these languages, they are requesting tutorials, source code, snippets of code, and solutions to their simple programming problems. In some cases, those of us who have been programming in BASIC for a long time have this code just hanging around and simply need to categorize it and make it available.

>    So at this point it is time to place into the public domain much of the source code that I have developed so that many others may find it quick and easy to write the simple programs they need. I organized and categorized these files quickly, and therefore did not go through them all to remove any comments that refer to a copyright or limitation of use, but you may disregard any that you find.

>    I am providing this code "as is" and with no support. (It's source code after all.)

### Miscellaneous GWBASIC Source Code

placed in the public domain by Gary Peek  

#### Applications/utilities/complete programs

There were many more, but were written for hire and cannot be made
public :(

-   [MESSAGE.BAS](message.bas) messaging and alarm clock program
-   [DUMBTERM.BAS](dumbterm.bas) very simple dumb terminal program
-   [SCP.BAS](scp.bas) serial communcation program, terminal program
    with many features
-   [VIEW.BAS](view.bas) view files in current directory, (similar to PC
    magazine utility FILECTRL or LOTUS MAGELLAN FILE VIEW)
-   [FILEMOD.BAS](filemod.bas) modify files in many ways, remove
    duplicate charaters, add character before or after another, etc.,
    plus a binary editor also
-   [CHKLNUM.BAS](chklnum.bas) check for proper line numbers in GWBASIC
    file
-   [EASYMENU.BAS](easymenu.bas) run DOS programs from a menu that can
    be called from AUTOEXEC.BAT
-   [APPDFILE.BAS](appdfile.bas) shows how to add "menu" command to
    AUTOEXEC.BAT, for "EASYMENU"
-   [DUATCOM.BAS](duatcom.bas) communcation program for pilot weather
    service (for its source code value only, don't mess with the DUAT
    system, besides, its all on the www now anyway)

#### Electronics related programs

-   [VOLTDIV.BAS](voltdiv.bas) calculates voltage divider resistors
-   [LM317.BAS](lm317.bas) calculate LM317 voltage divider resistor
    values
-   [NE555.BAS](ne555.bas) calculate 555 timer values for frequency and
    period
-   [LEDCALC.BAS](ledcalc.bas) calculate series resistor values for LEDs
-   [PARESIST.BAS](paresist.bas) calculates resistance of 2 parallel
    resistors

#### Miscellaneous programs, demo's, and snippets, in alpharandomized order

Note: Many of the "graphics" programs or demos were written a long time
ago for monchrome monitors, block characters, and low resolution
graphics, and are now probably only useful for their instructional value
or some of the ideas or methods in them.

-   [PARPORT.BAS](parport.bas) subroutines with demo to read and write
    values from parallel port
-   [DOW.BAS](dow.bas) shows how to calculate day of week
-   [DTADEMO.BAS](dtademo.bas) demonstrates the use of the Disk Transfer
    Area in DOS so you can get the command line argument into your BASIC
    program
-   [DRAWPCX.BAS](drawpcx.bas) draw graphics on VGA screen and save as a
    PCX file, good demo of writing a PCX file, can read monochrome PCX
    files, (needs to be compiled, will not work in GWBASIC)
-   [DRAWPCXC.BAS](drawpcxc.bas) like DRAWPCX but can read color PCX
    files
-   [GEP.BAS](gep.bas) keyboard operated graphics program
    (Etch-A-Sketch style)
-   [ANGLEMSG.BAS](anglemsg.bas) subroutine to display message at many
    angles, backwards, etc.
-   [BANNER.BAS](banner.bas) creates banners on continuous form tractor
    feed paper on Okidata printer
-   [BIGCHAR.BAS](bigchar.bas) create large block characters on screen
-   [BARLINE.BAS](barline.bas) bar graph routines for SCREEN 1
-   [CAPSON.BAS](capson.bas) turn on the CAPS LOCK key
-   [CIRCLE.BAS](circle.bas) draw arc or circle subroutine with demo
    code
-   [EDGFXCHR.BAS](edgfxchr.bas) edit block graphics characters
-   [EPSBAS.BAS](epsbas.bas) subroutine to print graphics screen to
    EPSON dot matrix printer
-   [EPSON.BAS](epson.bas) set Epson printer print options
-   [HEXDUMP.BAS](hexdump.bas) display contents of a file in hexadecimal
-   [LABELOKI.BAS](labeloki.bas) print labels on Okidata dot matrix
    printer
-   [MAKEFONT.BAS](makefont.bas), [LOOKFONT.BAS](lookfont.bas) create,
    display character fonts in X,Y coordinates and save to files, good
    example of keyboard operated pixel editing
-   [MEMTEST.BAS](memtest.bas) memory test, subroutine to enter
    hexadecimal numbers
-   [MOUSEPOS.BAS](mousepos.bas) display mouse position on a text screen
-   [NUMWORDS.BAS](numwords.bas) finds number of words in a file
-   [OKI.BAS](oki.bas) set options on Okidate printers
-   [PALETTE.BAS](palette.bas) demonstrates showing all 4 shades of a
    color in SCREEN 9
-   [PHONE10.BAS](phone10.bas), [PHONE7.BAS](phone7.bas) make words from
    phone numbers
-   [PRINT39.BAS](print39.bas) code 39 bar code label printing for dot
    matrix printer
-   [PRNSCRN9.BAS](prnscrn9.bas) print screen for SCREEN 9 and
-   [QUIZ.BAS](quiz.bas) run a multiple choice question quiz by reading
    quiz data file
-   [REMOVECR.BAS](removecr.bas) remove carriage returns from file and
    replace with spaces
-   [REMREM.BAS](remrem.bas) remove remarks from GWBASIC source code
    file
-   [SAVEFILE.BAS](savefile.bas) save ASCII data coming into a serial
    port into a file
-   [SPLIT.BAS](split.bas) split large text file into several smaller
    ones
-   [SWATCH.BAS](swatch.bas) shows all the colors available in SCREEN 9
-   [TXBIN.BAS](txbin.bas), [RXBIN.BAS](rxbin.bas) transmit and receive
    binary files from serial port
-   [WHATMON.BAS](whatmon.bas) finds out what monitor type is connected
-   [WSCONVRT.BAS](wsconvrt.bas) convert WordStar files back to regular
-   [SLOWMOUS.BAS](slowmous.bas) reduce the mouse sensitivity
-   [PRINTEST.BAS](printest.bas) shows how to test for printer so as not
    to get errors
-   [SCRNDEMO.BAS](scrndemo.bas) demonstrates "SCREEN", "VIEW", and
    "WINDOW" commands in SCREEN 0
