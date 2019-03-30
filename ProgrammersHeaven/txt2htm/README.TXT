TXT2HTM.EXE
Created by Robert Madewell
rbtmdl@email.com
Created with the MoonRock Compiler.
The MoonRock Compiler was created by Rowan Crowe.
Visit Rowan's website http://www.rowan.sensation.net.au/
You can download the MoonRock Compiler at his website.

The source code (TXT2HTM.MOO) is included in this package.

TXT2HTM is an idea that I've had for awhile. What I wanted was
a program to take plain text files and add HTML tags to them.
This makes it easy to add the contents of plain text files to
websites. While the HTML files this program creates are not
pretty by themselves, I can cut and paste the HTML code to
webpages. This makes typing the tags in the textfile unnessary.

There have been several earlier attempts. The best earlier version
was created with QBASIC. It still didn't offer the options that
this version does, and it was bigger (38k). This version is only
6962 bytes, about 7k. I wrote a C version that was over 60k after it
was compiled!

I tried to make TXT2HTM very flexible and easy to use. You should
be able to use it in Windows by simply dragging a text file and
dropping it on TXT2HTM, or a shortcut to TXT2HTM. You can also
use TXT2HTM as a commandline program in MS-DOS. As a commandline
program you can use the switches (options). This version has four
switches. Any number of them can be on at the same time. TXT2HTM
should work from anywhere, if it is placed in a path directory.

Here is the help screen that is printed when you enter TXT2HTM on
the MS-DOS command line.

-------------------------------------------------
Text to HTML converter.

USAGE: TXT2HTM source [object] [/switches]

SWITCHES:
C   Center all text.
B   Disable line breaks after each line of text.
F   Use fixed font.(courier)
P   Disable paragraph tags.

EXAMPLE:
TXT2HTM test.txt /fp

This program supports drag and drop.
-------------------------------------------------
Later versions (if there are any) will allow you to control the size of
text, bgcolor, text color, ect. I'm not promising anything.

This version is FREE. You may change the source code to suit your needs.
Don't send me money, but email me if you like this program or if you
need help with it.

Files in this package.
TXT2HTM.EXE:         The executable program.
TXT2HTM.MOO:         The MoonRock source file. Use NotePad
                     or the MS-DOS editor to view it.
TEST.TXT:            A test file. This story was emailed to me.
                     I used it to test TXT2HTM
TEST.HTM:            The HTML file that was created with the
                     command TXT2HTM test /fp
README.TXT:          The plain text version of this file.
README.HTM:          The HTML version of this file. Notice the
                     filepath in the title bar of your browser.
                     That was the original location of the file
                     on my computer. It was created with drag and
                     drop, in Windows.

