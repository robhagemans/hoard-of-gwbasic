10 '$#0
20 '.pf8.ce"finish"
30 '.pf0.cea formatting printer
40 '.cefor the IBM Personal Computer
50 '.ceand  the EPSON MX-80
60 '.bl1.ceby Paul F. Doering
70 '.bl3.pf6
80 'Introduction
90 '.pf0.in5
100 'In the August 1978 issue of KILOBAUD (now MICROCOMPUTING) there appeared
110 'the full listing of a program its authors called "DOCUFORM". It marked
120 'the first time that anyone had put a complex text-formatting program
130 'into the public domain, and it led to a host of look-alikes on a wide
140 'variety of personal computers. Today its descendents form the nuclei of
150 'several word processors being sold for hundreds of dollars. My version,
160 'heavily modified and extended, is called "finish". Because it is based on
170 'work given freely by its originators, I have maintained that spirit and
180 'have elected to distribute "finish" without charge. There is a corollary,
190 'of course: "finish" comes to you without any guarantees. I will not
200 'promise that it will work under new circumstances. I will not send you
210 'updates. I will not fix bugs in your copy. All I will say now is that
220 'this documentation has been prepared using "finish"; to this extent it is
230 'functional. Have fun with it. It's yours without restriction.
240 '.bl2.pf6.tp4
250 'The files on your diskette
260 '.pf0.in5
270 '"finish" expects to run in a single-drive, single-sided, double-density environment. You can
280 'modify it by yourself. Frankly, I don't feel it's
290 'worth the bother. Put the diskette into drive A and run a directory listing.
300 'You'll find these files.
310 '.bl1.tp4.ma5
320 '*  finish.bas - This is the program itself, saved in ASCII (untokenized)
330 'format for reasons not germane to this discussion. This file is heavily
340 'and cogently commented. Reading it will give you a lot of insight into
350 'both "finish" and BASIC programming in general.
360 '.bl1.tp4
370 '*  finishtx.bas - This is the raw text file for the documentation you are
380 'now reading. It is instructive to compare a straight dump of this file
390 'with the formatted material "finish" produces from it. That comparison is
400 'a good introduction to the principles of imbedded commands, the form of
410 'command "finish" uses to implement your wishes.
411 '.bl1.tp4
412 '*  labels.bas - a little worksaver to which "finish" chains when it is done.
413 '"labels" will produce an altered set of soft labels for the function keys,
414 'a set that I find more useful than IBM's choice. You can change it; but
415 'there has to be such a program, or the chain will fail as "finish" exits.
420 '.bl1.tp4.ma0.in5
430 'What you will NOT find on your diskette is a program to capture the text to
440 'be processed later by "finish". There used to be such a program, called
450 '"keyin". It was so simple that it turned out to be scant help, so I
460 'scuttled it. I have found that I can create text files for "finish" without
470 'the nuisance of a text-capture program's getting in my way. Maybe you'll
480 'disagree and choose to write one. Good luck.
490 '.bl1.tp2.in5
500 'Also mysteriously missing is any kind of an editing program. There's a
510 'good reason for that. Your PC comes with a full-screen editor as a part of
520 'the BASIC interpreter. Why go to the trouble of writing another one?
530 '.bl2.pf6.tp4
540 'The basic principles of "finish"
550 '.pf0.in5
560 'The raw text that "finish" processes is actually a BASIC program that
570 'consists entirely of REMARK statements. Therefore, every line in your raw
580 'text file must begin with a unique line number; and these numbers determine
590 'the actual sequence of the lines in the final documents, just as they do in
600 'BASIC. In the IBM PC, a REMARK statement is indicated by the presence of an
610 'apostrophe following the line number. We have to follow that rule, too; and
620 'you can take my word that your most frequent mistake will be forgetting to
630 'include the apostrophe.
640 '.bl1.tp2.in5
650 'Now you know why file "finishtx.bas" looks as it does. You also know how to
660 'create a file of raw text for "finish" to process. You just start every
670 'line with a line number in increasing sequence, follow it with an
680 'apostrophe, and then enter a line of your intended material. Like any BASIC
690 'line, your text line can have up to 255 characters, including the number
700 'and apostrophe. Personally, I find it easier to read my raw text if I limit
710 'each line's length to the 80-character width of the screen. That's pretty
720 'much the convention in "finishtx.bas".
730 '.bl1.tp2.in5
740 'When you have completed the raw text file, just save it on diskette by
750 'using the command
760 '.bl1.nf
770 '     save"textname",a
780 '.bl1.fi
790 'The use of the ",a" modifier when saving the file to diskette is crucial.
800 '"finish" can only process files saved in ASCII format, and the ",a" is
810 'BASIC's cue to use ASCII instead of the default tokenized format. If you
820 'ever get weird results when asking "finish" to process a file, check to see
830 'with a PC-DOS "type" command whether the file is in ASCII. I'll bet it
840 'won't be.
850 '.bl1.tp2.in5
860 'Incidentally, the raw text will be accumulating in RAM as you enter it in
870 'the form of a peculiar BASIC program. It is good practice to save it onto
880 'the diskette from time to time as it grows larger, guarding yourself
890 'against the disaster of losing the whole job if something goes wrong.
900 '.bl1.tp2.in5
910 'You can see, then, that there are three steps in going from no text at all
920 'to having a finished, printed document.
930 '.bl1.tp4.ma5
940 '1. Using the apostrophe convention for a REMARK statement, create the raw
950 'text of your document in the form of a sequentially numbered set of lines.
960 'Because you are writing a kind of BASIC program, you have the full power
970 'of the BASIC editor available.
980 '.bl1.tp2
990 '2. Save the file of raw text on diskette, using the BASIC "save" command
1000 'and the ",a" option to force a file in ASCII format. To save a file
1010 'named, say, "FRED", you would use the command
1020 '.nf.bl1
1021 '     save"fred",a
1030 '.fi.bl1.tp2
1040 '3. Run the program "finish" as explained below, specifying the name of the
1050 'file of raw text to be processed.
1060 '.bl1.tp2.ma0.in5
1070 'If the document turns out to have mistypings in it, you can return to step
1080 '1, using the BASIC editor in the normal fashion to correct the file. If
1090 'the only problem is the format of the document, as opposed to its content,
1100 'you can make runtime format changes in using "finish" and will not have
1110 'to alter the text file. Only step 3 need be repeated.
1120 '.bl2.pf6.tp4
1130 'Running "finish"
1140 '.pf0.in5
1150 '"finish" is easy to run. Get into BASIC and type
1160 '.nf.bl1
1170 '     run"finish
1180 '.fi.bl1.tp2
1190 'There will be some diskette action, followed by a few seconds of blank
1200 'screen, after which a full screen of instructions will appear. There will
1210 'also be a new set of soft labels on the 25th screen line. These refer to
1220 'the actions of the ten function keys, F1 - F10. Read the instructions.
1230 'Note especially that you will be unsuccessful in getting printed output
1240 'if you fail to hit F7 and type in a file name (like "fred") before you
1250 'hit F10, the "Begin" key.
1260 '.bl1.tp2.in5
1270 'The actions of those function keys deserve some discussion.
1280 'F1 sets the absolute left margin for the printed text. F2 does the same
1290 'for the right. By "absolute" I mean that all adjustments to the margin
1300 'settings by any imbedded commands (see below) will be RELATIVE to the
1310 'runtime values set with F1 and F2. Default values are 3 and 72. Margins
1320 'are set in terms of tenths of inches from the "1" position on the
1330 'printer. These tenths of inches also correspond to the embossed numbers
1340 'on the printer's metal paper bail. Even if you use compressed characters
1350 'at 17 to the inch, these margin settings will still be in tenths of
1360 'inches and will still align with the paper bail.
1370 '.bl1.tp2.in5
1380 'F3 is a toggle. It switches back and forth between 10 characters per inch
1390 'and 17 cpi. That means that at runtime you can select compressed or normal
1400 'fonts. Notice that any toggling key always shows on its soft label what
1410 'will happen the next time it's hit, not what the current state of its
1420 'parameter is. F3's label starts out saying "17 cpi", but "finish" is set
1430 'at that stage to print at 10 cpi. If you hit F3, "finish" will set itself
1440 'for 17 cpi, and the new soft label for F3 will say "10 cpi". If you find
1450 'yourself confused, just hit F9 for a complete status report.
1460 '.bl1.tp2.in5
1470 'F4 toggles between two fonts: "pretty" and "plain", corresponding to
1480 'the printer's emphasized and normal typeface, respectively. "Plain" runs
1490 'faster and is useful for drafts. "Pretty" makes a nicer looking final
1500 'copy. There is an interlock between F3 and F4. The "pretty" font can only
1510 'exist at 10 cpi, and "finish" will not allow otherwise.
1520 '.bl1.tp2.in5
1530 'F5 toggles the justification of the right margin between fully justified
1540 'and ragged. Unless you specify a peculiar left margin justification by an
1550 'imbedded command in the raw text, the left marging is always justified.
1560 '.bl1.tp2.in5
1561 'F6 toggles between single-spaced lines of text and double-spaced.
1562 '.bl1.tp2.in5
1570 'F7 allows you to specify the file name of the raw text. This is mandatory.
1580 'Enter only the name, not the ".bas" extension. You do not have to specify
1590 'a diskette drive, since the program expects everything to be on drive A.
1600 'Nevertheless, you can prefix a "b:" to the file name and it will be
1610 'honored.
1620 '.bl1.tp2.in5
1630 'F8 lets you specify a header, text to be written right-justified with the
1640 'page number at the top of pages two and beyond. If you choose to not
1650 'supply a header, the page number will not be typed either.
1660 '.bl1.tp2.in5
1670 'F9 is the "Review" key. Whenever the blinking cursor is at the left side
1680 'of the screen, awaiting the striking of a function key, you may hit F9
1690 'to get a display of the existing values of the runtime parameters. Until
1700 'you get the hang of using the toggling keys, it's a good idea to take a
1710 'reading with F9 occasionally.
1720 '.bl1.tp2.in5
1730 'F10 is the key you hit when you're ready to start the printing. "finish"
1740 'will conduct a few plausibility tests on the runtime parameters and will
1750 'announce that it can't start printing and why, should it find an
1760 'inconsistency. Accept its criticism without rancor, and correct the
1770 'situation. When you think all is well, hit F10 again.
1780 '.bl1.tp2.in5
1790 'The display will pose a question about what text you wish to substitute
1800 'for a thing called dollar/number 0. This is as good a place to talk about the dollar/number
1810 'codes as any; but there is a logistical problem to be cleared up first.
1812 'In this documentation I am forced to use the term "dollar/number" when I
1814 'really mean the pair of characters produced as shifted-4 and shifted-3,
1816 'respectively. The problem is that I can't actually type those two
1818 'characters, because "finish" will regard them as a substitution request;
1819 'and I don't really want one. Read on; you'll see what I mean....
1820 '.bl2.pf6.tp4
1830 'The substitution-string codes
1840 '.pf0.in5
1850 'There are times when you want to prepare a document for general use under
1860 'more than one circumstance. A form letter is an example. The substitution-
1870 'string codes are place markers that let you tell "finish" that here is a
1880 'place where you wish to insert some text (like an addressee's name) that
1890 'was indeterminate at composing time. You may use up to ten such codes.
1900 'They are designated by the character grouping dollar/number 0 through dollar/number 9. For
1910 'example, you might begin a form letter with
1920 '.bl1.nf
1930 '     Dear dollar/number 1,
1940 '.bl1.fi
1950 'At runtime you would respond to the display inquiry about what you wanted
1960 'to substitute in the place of dollar/number 1 by entering, say, Hilda. At that part
1970 'of the letter, the printer would put out
1980 '.bl1.nf.tp3
1990 '     Dear Hilda,
2000 '.bl1.fi
2010 'having substituted "Hilda" for the dollar/number 1 between the space and the comma.
2020 '.bl1.tp2.in5
2030 'Since there is no conceptual limitation on the nature of the string you
2040 'substitute at runtime, you may also replace a dollar/number with one or more imbedded
2050 'commands. There's no law that says a substitute string has to show up in
2060 'the document as so many words. I think that this is enough on that subject.
2070 'You'll learn most about the dollar/number codes by playing with them. I generally put
2080 'dollar/number 0 as the complete content of the first line of my raw text, so I can
2090 'decide at runtime whether there are any last-minute commands I want to
2100 'imbed. Remember that "finish" will respond to your hitting F10, the "Begin"
2110 'key, by asking what (if any) strings you want to substitute for the
2120 'occurrence of the dollar/number codes, should they be encountered later in the raw
2130 'text.
2140 '.bl1.tp2.in5
2150 'You should not skip any integers in the sequence from 0 to 9 for the
2160 'dollar/number codes. Begin with 0 and go as high as you must without
2170 'leaving any out.
2180 '.bl1.tp2.in5
2190 'PHEW! Now let's get back to what happens when you hit the F10 key and the
2200 'program begins its execution. If you have used any dollar/number codes,
2210 'you can indicate what you want them to stand for in this one printing. They
2220 'can stand for something else during the next printing. Hitting the "enter"
2230 'key without specifying a substitute string terminates "finish"'s inquiries
2240 'on that subject and gets you on to other things.
2250 '.bl1.tp2.in5
2260 '"finish" next asks you to choose output to the screen or the printer. You
2270 'can't have both at once. Make a choice by hitting s or p.
2280 '.bl1.tp2.in5
2290 '"finish" will ask whether you want to print the whole document or just a
2300 'partial set of pages. Most of the time you'll want the whole thing; but
2310 'there'll be times when there's an error on just one page in the middle,
2320 'and then you'll be glad for this feature.
2330 '.bl1.tp2.in5
2340 'That's it. If the printer is turned on, you'll get your document.
2350 'When "finish" is done, it will ask whether you want to make another copy
2360 'with the same dollar/number substitutions. You answer y or n. Guess what
2370 'happens....
2400 '.bl2.tp4.pf6
2401 'Using imbedded commands to control format
2402 '.pf0.in5
2450 'There are two ways to instruct "finish" concerning the appearance of
2460 'the printed results. The first way is the use of the function keys to set
2470 'up runtime specifications on margin placement, font size and elegance, edge
2480 'alignment, line spacing, and header content. You have the power to set these
2490 'parameters before any printing occurs.
2500 '.bl1.tp2.in5
2510 'The other way is to insert the instructions for "finish" directly into
2520 'the body of the text itself. Provided that there is a way for "finish" to
2530 'identify these instructions and to distinguish them from the material being
2540 'printed, this scheme can be quite powerful. These imbedded
2550 'commands, as they are called, can be placed in the flow of text with great
2560 'precision, so as to affect the formatting of a very specific section.
2570 '.bl1.tp2.in5
2580 'You can envision the parameters settable with the function keys as being
2590 'a kind of framework for the formatting process, a set of default conditions that
2600 'apply in the absence of counter-instructions buried in the text. In general,
2610 'any imbedded command has precedence over any runtime specification. For
2620 'example, the imbedded command to begin double line spacing overrides your
2630 'runtime choice from function key 6, the "single/double" key.
2640 '.bl1.tp2.in5
2650 'There is one pair of runtime parameters that will remain in effect
2660 'irrespective of the occurrence of their imbedded counterparts. The left-
2670 'margin and right-margin values from the function keys become absolute.
2680 'All margin adjustments made with imbedded commands are understood to be
2690 'relative to the runtime values. If you use function key 1 to set the runtime
2700 'left margin at 15, then any imbedded command later setting it to 5 will be
2710 'taken to mean "5 with respect to 15", for an actual margin setting of 20 on
2720 'the physical page.
2730 '.bl1.tp2.in5
2740 'To help "finish" identify an imbedded command, we adhere to a brief set
2750 'of rules governing their form and placement in the text.
2760 '.bl1.tp2.in5
2770 'Imbedded commands may occur alone or in chains, but they must always
2780 'start at the left end on a line typed in from the keyboard. The term "imbedded"
2790 'alludes to the commands' being within the body of the text as a whole, not to
2800 'their being allowed to appear at random within any given entered line of that
2810 'text.
2820 '.bl1.tp2.in5
2830 'An imbedded command consists of three characters: a period and two
2840 'lower-case alphabetic characters. This trio may sometimes be followed by an
2850 'integer or a string of textual material as an argument, if permitted by the
2860 'rules outlined in the next section.
2870 '.bl1.tp2.in5
2880 'An example of an imbedded command that takes no argument is
2890 '.ce.wt
2900 'which is the command Wait at Top, forcing "finish" to stop printing at the top
2910 'of all subsequent pages, presumably because you want to align the
2920 'paper manually before printing begins on the new sheet.
2930 '.bl1.tp2.in5
2940 'An example of a command that takes an integer as an argument is
2950 '.ce.lm5
2960 'which is the command mentioned above to move the left margin inward five
2970 'columns with respect to the physical absolute left margin set at runtime with
2980 'function key 1.
2990 '.bl1.tp2.in5
3000 'An example of a command that takes a string of text as an argument is
3010 '.ce.ceTitle
3020 'which is the command to center between the effective margins whatever textual
3030 'material occurs from immediately after the .ce command to the next carriage
3040 'return. In this example, the word   Title   would be centered.
3050 '.bl1.tp2.in5
3060 'In the examples just cited the commands are shown in the center of the
3070 'page to set them apart for emphasis. Remember that when they are imbedded in
3080 'the text, you must type them at the start of a new line. You may not even
3090 'type an innocent space-character first on that line.
3100 '.bl1.tp2.in5
3110 'In the following definitions and explanations, the symbol # will denote
3120 'an integer and XXXX will denote a string of text.
3150 '.bl2.tp9.pf6
3160 'Definitions of the imbedded commands
3170 '.pf0.bl3
3180 'Commands that control margin placement --
3190 '.bl2.tp2
3200 'Set the number of blank lines at the top of the page            .tm#
3210 '.in3
3220 'The default value is zero. Printing will begin at top-of-form.
3230 '.bl1.tp3
3240 'Set the number of blank lines at the bottom of the page         .bm#
3250 '.in3
3260 'Default is 12. Taken together, these two default values will
3270 '.in3
3280 'leave a 12-line gap across the page perforations.
3290 '.bl1.tp2
3300 'Set the left margin at a chosen column                          .lm#
3310 '.in3
3320 'Default is zero; i.e. the runtime margin.
3330 '.bl1.tp2
3340 'Set the right margin at a chosen column                         .rm#
3350 '.in3
3360 'Default is zero; i.e. the runtime margin.
3370 '.bl1.tp2
3380 'Set the number of lines on a physical page                      .pl#
3390 '.in3
3400 'Default is 66, the length of an 8 1/2 by 11" sheet.
3410 '.bl1.tp2
3420 'Adjust both margins in (+) or out(-) by the same amount         .ma#
3430 '.in3
3440 'Default is zero; .ma0 restores the runtime margins.
3450 '.bl1.tp2
3460 'Move all printing rightward (+) or leftward (-)                 .ov#
3470 '.bl2.tp10
3480 'Commands that format the text --
3490 '.bl2.tp2
3500 'Insert blank lines                                              .bl#
3510 '.in3
3520 'Must be >0. Usually used as .bl1 between paragraphs.
3530 '.bl1.tp2
3540 'Indent at the start of a line                                   .in#
3550 '.in3
3560 'Essentially a versatile tab command.
3570 '.bl1.tp2
3580 'Justify left edge of text aligned (right edge ragged)           .jl
3590 '.in3
3600 'This is the default condition, like most typing.
3610 '.bl1.tp2
3620 'Justify right edge aligned (left edge ragged)                   .jr
3630 '.in3
3640 'Seldom used. Find a use and win a prize.
3650 '.bl1.tp2
3660 'Justify both edges aligned                                      .jb
3670 '.in3
3680 'This lengthens the line by extra spaces between words.
3690 '.bl1.tp2
3700 'Set single- (#=1) or double- (#=2) line spacing                 .ls#
3710 '.in3
3720 'Any # not 2 will be reset to 1, which is the default.
3730 '.bl1.tp2
3740 'Center the following text between the current margins           .ceXXXX
3750 '.in3
3760 'It's up to you to see that it fits!
3770 '.bl1.tp2
3780 'Fill the current line with text from the next one if possible   .fi
3790 '.in3
3800 'This is normal operation, the default condition.
3810 '.bl1.tp2
3820 'No filling. Add no text to this line from the following one     .nf
3830 '.in3
3840 'This is useful for inside addresses in letters.
3850 '.bl2.tp10
3860 'Commands related to paging
3870 '.bl2.tp2
3880 'Immediately start a new page                                    .pa
3890 '.in3
3900 'Continuous page numbering is maintained.
3910 '.bl1.tp2
3920 'Immediately start a new page                                    .pa#
3930 '.in3
3940 'Assign # as the number of the new page.
3950 '.bl1.tp2
3960 'Wait at the top of each successive new page                     .wt
3970 '.in3
3980 'This allows paper alignment before printing.
3990 '.bl1.tp3
4000 'Test if there's enough room at the bottom of this page          .tp#
4010 '.in3
4020 'Start a new page unless there are at least # remaining lines
4030 '.in3
4040 'on the current page. Useful for keeping charts & tables intact.
4050 '.bl1.tp3
4060 'Define a header                                                 .hdXXXX
4070 '.in3
4080 'The string of text and the page number will print at the top
4090 '.in3
4100 'of the following pages until superseded by another .hd command.
4110 '.bl2.tp8
4120 'Commands to select an printer font
4130 '.bl2.tp5
4140 'Select a printer font                                           .pf#
4150 '.in3
4160 'The new font applies to a full line. No mixing of fonts on
4170 '.in3
4180 'a single line is possible.
4190 '.bl2.tp12
4200 '.pf1
4210 'This is a sample of the font you get when you use .pf1
4220 '.pf2
4230 'This is a sample of the font you get when you use .pf2
4240 '.pf3
4250 'This is a sample of the font you get when you use .pf3
4260 '.pf4
4270 'This is a sample of the font you get when you use .pf4
4280 '.pf5
4290 'This is a sample of the font you get when you use .pf5
4300 '.pf6
4310 'This is a sample of the font you get when you use .pf6
4311 '.pf7
4312 'This is the font from .pf7
4313 '.pf8
4314 'This is the font from .pf8
4320 '.pf0.bl1.tp2
4330 'Using .pf0 restores the font chosen at runtime, "plain" or "pretty"
14 