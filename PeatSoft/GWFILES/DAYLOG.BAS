1 '     Picture City Personal Computer Programmers Club Software Library
2 '
3 '     Program - DAYLOG - submitted by:
4 '
5 '     Michael Csontos, 3228 Livonia Center Road, Lima, New York 14485
6 '
7 '     August 18, 1982
8 '
9 '
110 PRINT "This program generates a form for recording data on a day by day basis with
120 PRINT "      each line labeled with the day and date.  Columns are set up and labeled
130 PRINT "      by the user.":PRINT
140 PRINT "The form will look something like the following:":PRINT
150 PRINT "             Date____|_Title_1_|_Title_2_|_Title 3_|_Title_4_|_Title 5_|
160 PRINT "             Mon.    |         |         |         |         |         |
170 PRINT "             Jan. 1  |         |         |         |         |         |
180 PRINT "             2001____|_________|_________|_________|_________|_________|
190 PRINT "             Tue.    |         |         |         |         |         |":PRINT
200 PRINT "The dates will run consecutively between starting and ending dates that you
210 PRINT "     enter, but you may select days of the week to be skipped.  This program
220 PRINT "     was written for a Epson MX-80 printer with Graphtrack.  Although no
230 PRINT "     special graphics features were used, some printer commands may have to be
240 PRINT "     changed for other printers.":PRINT
250 PRINT "You may have a set of titles and other format data filed on the disk.
260 DIM MTHNAME$(12):MTHNAME$(1)="JAN.":MTHNAME$(2)="FEB.":MTHNAME$(3)="MAR.":MTHNAME$(4)="APR.":MTHNAME$(5)="MAY.":MTHNAME$(6)="JUN.":MTHNAME$(7)="JUL.":MTHNAME$(8)="AUG.":MTHNAME$(9)="SEP.":MTHNAME$(10)="OCT.":MTHNAME$(11)="NOV.":MTHNAME$(12)="DEC."
270 KEY OFF:PRINT:PRINT "Do you have a format on file";:GOSUB 12000:ON A GOTO 310,280,270'YESORNOA
280 GOSUB 11000'retrieve file GETFILE
290 IF NOFILE=1 THEN GOTO 310 ELSE GOSUB 14000'modify? CHNGFORM
300 GOTO 520
310 PRINT "Please enter the date at which you want the form to start.":PRINT
320 GOSUB 1000' enter date  DATCHECK
330 STARTDATE$ = DAT$
340 PRINT "Please enter the date at which you want the form to end.":PRINT
350 GOSUB 1000' enter date  DATCHECK
360 ENDDATE$ = DAT$
370 PRINT "Do you want to skip any days of the week";:GOSUB 12000:ON A GOTO 390,380,370'YESORNOA
380 GOSUB 10000' input days to be skipped  SKIPDAY
390 GOSUB 8000' enter titles  TITLEIN
400 LINES=0:PRINT "This program is set up for 11 inch pages. You have four options for paging.":PRINT
410 PRINT "     1  30 lines per page regardless of content.
420 PRINT "     2  Start a new page for each new month.
430 PRINT "     3  Continuous chart with no paging.
440 PRINT "     4  The number of lines you choose (greater than 3 lines).
450 PRINT:INPUT "Please enter the number of the option you choose";LINES
460 IF LINES<1 OR INT(LINES)<>LINES OR LINES>4 THEN PRINT "Please enter a number corresponding to one of the options listed.":GOTO 400
470 IF LINES=4 THEN INPUT "Enter the number of lines you want per page";LINES
480 PRINT:PRINT "You may have a heading at the top of each page. Please enter the heading."
490 INPUT "Heading";HEADING$
500 PRINT "Do you want to save the format for this form";:GOSUB 12000:ON A GOTO 520,510,500'YESORNOA
510 GOSUB 13000'file the format variables  MAKEFILE
520 HOLD=0:TITLE$(0)="date    ":BADTITLE=0
530 WIDE=0:FOR W=0 TO 10:WIDE=WIDE+LEN(TITLE$(W))+1:NEXT W
540 LEFTMAR=132-WIDE:IF LEFTMAR<0 THEN 550 ELSE 570
550 Z=ABS(LEFTMAR)+1:PRINT "The chart is " Z " characters too wide. You should make your titles shorter.":BADTITLE=1:GOSUB 14000'modify? CHNGFORM
560 IF MODIFIED=1 THEN GOTO 520 ELSE LEFTMAR=0:BADTITLE=0
570 LEFTMAR$=STRING$(LEFTMAR," ")
580 BADHEAD=0:HEADGAP=8.5*(8-(LEFTMAR/17.16+LEN(HEADING$)/8.5+9/8.5))-1:IF HEADGAP<1 THEN 590 ELSE HEADMAR$=LEFTMAR$:GOTO 620
590 HEADGAP=2:HEADMAR=8.5*(8-(LEN(HEADING$)/8.5+9/8.5))-1:IF HEADMAR<1 THEN 600 ELSE HEADMAR$=STRING$(HEADMAR," "):GOTO 620
600 ZZ=INT(ABS(HEADMAR))+2:PRINT "The heading is " ZZ " characters too wide. You should make your heading shorter.":BADHEAD=1:GOSUB 14000'modify? CHNGFORM
610 IF MODIFIED=1  THEN GOTO 580 ELSE HEADGAP=1:HEADMAR$="":BADHEAD=0
620 PRINT "Is the printer ready to print the form";:GOSUB 12000:ON A GOTO 620,630,620'YESORNOA
630 PRINT "Pressing <H> will cause the printer to pause at the end of each page to allow ":PRINT "single sheet feeding.
640 PRINT "Pressing <Esc> will cause the printing to stop at the end of the date line being printed.":GOSUB 9000' set up printer  CHRTPRNT
650 DAT$=STARTDATE$:PAGENUM=0:GOSUB 2000'convert date to numbers DATTONUM
660 D=D-1:LINENUM=0:PAGENUM=PAGENUM+1
670 PRINTIME=0:ON ERROR GOTO 15000' printer error subroutine PRTERROR
680 LPRINT HEADMAR$ CHR$(14) HEADING$ SPC(HEADGAP) "Page" PAGENUM:LPRINT
690 LPRINT LEFTMAR$ CHR$(27)CHR$(45)CHR$(1);
700 FOR T=0 TO 10:LPRINT TITLE$(T);CHR$(156);:NEXT T:LPRINT
710 LPRINT CHR$(27)CHR$(45)CHR$(0);:ON ERROR GOTO 0
720 D=D+1:GOSUB 4000' check new date  DATGEN
730 IF DATINC=1 THEN GOTO 910
740 GOSUB 3000' find day of week  DAYNAME
750 FOR WKDY=1 TO 7:IF DAYNAME$ = DAYSKIP$(WKDY) THEN GOTO 780
760 NEXT WKDY
770 LINENUM=LINENUM+1:GOSUB 7000' print a form line  LINEFORM
780 IF ATE$ = ENDDATE$ THEN GOTO 850
790 ESC$=INKEY$:IF ESC$="H" OR ESC$="h" THEN HOLD=1
800 IF ESC$=CHR$(27) THEN PRINT "Form terminated. ";:FOR N=0 TO 15:DUMP$=INKEY$:NEXT:GOTO 860 ELSE IF ESC$<>"" THEN GOTO 790
810 IF LINES=1 AND LINENUM>=30 THEN GOTO 830
820 IF LINES>=4 AND LINENUM>=LINES THEN GOTO 830 ELSE GOTO 720
830 LPRINT CHR$(140):IF HOLD=1 THEN PRINT "Page " PAGENUM " finished. Press <Esc> to exit, any other key to continue.":FOR N=0 TO 15:DUMP$=INKEY$:NEXT:GOTO 840 ELSE GOTO 660
840 RESTART$=INKEY$:IF RESTART$=CHR$(27) THEN GOTO 860 ELSE IF RESTART$<>"" THEN GOTO 660 ELSE GOTO 840
850 PRINT "Form completed. ";:IF LINES=3 THEN GOTO 860 ELSE LPRINT CHR$(140)
860 GOSUB 14000:IF MODIFY=0 THEN GOTO 880'modify CHNGFORM
870 PRINT "Do you want to run this modification";:GOSUB 12000:ON A GOTO 890,520,870'YESORNOA
880 PRINT "Do want to run another copy of this form";:GOSUB 12000:ON A GOTO 900,620,880'YESORNOA
890 PRINT "Are you sure";:GOSUB 12000:ON A GOTO 870,900,890
900 PRINT "GOOD BYE":KEY ON:END
910 GOSUB 5000' increment to next month  NEXTDAY
920 GOSUB 4000' check incremented date  DATGEN
930 IF LINES=2 THEN GOTO 830 ELSE GOTO 740
1000 Z1000$=DATE$'                                           --
1010 INPUT "date";DAT$'                                       | subroutine
1020 ON ERROR GOTO 1070'        Converts input                |    to
1030 DATE$=DAT$'                to standard                   |   enter
1040 ON ERROR GOTO 0'           date format (mm-dd-yyyy)      |    and
1050 DAT$=DATE$:DATE$=Z1000$'   and returns it as DAT$        |   check
1060 RETURN'                                                  |    the
1070 IF ERR=5 THEN 1080 ELSE PRINT "DATCHECK TROUBLE":STOP'   |   date
1080 PRINT "Not a valid date. Try again.":RESUME 1010'       --
2000 Y=VAL(RIGHT$(DAT$,4))'                        --
2010 D=VAL(MID$(DAT$,4,2))'   dat$ as mm-dd-yyyy     |  subroutine
2020 M=VAL(LEFT$(DAT$, 2))'    to  M,D,Y,M$,D$,Y$    |     to
2030 M2030=M+100:D2030=D+100'                        |  decompose
2040 M$=STR$(M2030):D$=STR$(D2030):Y$=STR$(Y)'       |    dates
2050 M$=RIGHT$(M$,2):D$=RIGHT$(D$,2):Y$=RIGHT$(Y$,4)'|    into
2060 RETURN'                                       --  strings & numbers
3000 M3000=M:Y3000=Y'
3010 IF M3000>2 THEN 3030'
3020 M3000=M3000+12:Y3000=Y3000-1'
3030 N=2+D+M3000*2+Y3000+INT(Y3000/4)-INT(Y3000/100)+INT(Y3000/400)+INT(.6*(M3000+1))'
3040 ON 1+INT(1/2+(N/7-INT(N/7))*7) GOTO 3050,3060,3070,3080,3090,3100,3110'
3050 DAYNAME$="SAT.":RETURN'
3060 DAYNAME$="SUN.":RETURN'         Subroutine to give day of week
3070 DAYNAME$="MON.":RETURN'
3080 DAYNAME$="TUE.":RETURN'                     from
3090 DAYNAME$="WED.":RETURN'
3100 DAYNAME$="THU.":RETURN'            integers M, D, & Y.
3110 DAYNAME$="FRI.":RETURN'
4000 DATINC=0:Z4000$=DATE$'                                  --
4010 M$=STR$(M+100):D$=STR$(D+100):Y$=STR$(Y+10000)'           | subroutine
4020 M$=RIGHT$(M$,2):D$=RIGHT$(D$,2):Y$=RIGHT$(Y$,4)'          |    to
4030 ATE$=M$+"-"+D$+"-"+Y$'                                    |   form
4040 ON ERROR GOTO 4080'   Converts M,D, & Y integers          |    and
4050 DATE$=ATE$'           into ATE$ in form mm-dd-yyyy        |   check
4060 ON ERROR GOTO 0'      and M$,D$, & Y$ as mm, dd, & yyyy.  |     a
4070 DATE$=Z4000$:RETURN'  If invalid date, returns DATINC = 1.| standard
4080 IF ERR=5 THEN DATINC=1 ELSE PRINT "DATGEN TROUBLE":STOP'  |date format
4090 RESUME 4060'                                            --
5000 D=1:M=M+1:YEARLIM=0'                                 --
5010 IF M=13 THEN 5030'     Uses M, D, & Y.                 | subroutine
5020 RETURN'                Assumes end of old month.       |    for
5030 M=1:Y=Y+1'             Returns D=1,M+1,Y+1 as needed.  | incrementing
5040 IF Y>=2099 THEN 5060'  If Y exceeds 2099,              |    a
5050 RETURN'                      returns: YEARLIM = 1      |   date
5060 PRINT "Cannot go beyond year 2099"'                    |    by
5070 YEARLIM=1:RETURN'                                    --   one month
7000 ON ERROR GOTO 15000:COL0DL = LEN(TITLE$(0))-LEN(DAYNAME$)'
7010 IF D<10 THEN DD=3 ELSE DD=4'                                    |
7020 COL0ML = LEN(TITLE$(0))-(LEN(MTHNAME$(M))+DD)'                  |subrtn.
7030 COL0YL = LEN(TITLE$(0))-LEN(Y$)'                                |to
7040 COL0D$ = STRING$(COL0DL," ")'        needs TITLE$(t)            |print
7050 COL0M$ = STRING$(COL0ML," ")'              MTHNAME$(m)          |a
7060 COL0Y$ = STRING$(COL0YL," ")'              DAYNAME$             |three
7070 FOR C=1 TO 10'                             Y$                   |line
7080 COL$(C) = STRING$(LEN(TITLE$(C))," ")'     D                    |form
7090 NEXT C'                                    COL$(C) array must be|with
7100 LPRINT LEFTMAR$ DAYNAME$ COL0D$ CHR$(156);'dimensioned if C>10  |up
7110 FOR C=1 TO 10:LPRINT COL$(C) CHR$(156);:NEXT C:LPRINT'          |to
7120 LPRINT LEFTMAR$ MTHNAME$(M) D COL0M$ CHR$(156);'                |ten
7130 FOR C=1 TO 10:LPRINT COL$(C) CHR$(156);:NEXT C:LPRINT'          |columns
7140 LPRINT LEFTMAR$ CHR$(27) "-" CHR$(1);Y$;COL0Y$ CHR$(156);'      |defined
7150 FOR C=1 TO 10:LPRINT COL$(C) CHR$(156);:NEXT C'                 |by their
7160 LPRINT CHR$(27) "-" CHR$(0)'                                    |title
7170 ON ERROR GOTO 0:RETURN
8000 PRINT:PRINT "You may have up to ten titles. The maximum width is 132 characters but ten are"
8010 PRINT "taken up by dividing lines and ten by the date  (0)  column,  leaving 112.  By"
8020 PRINT "skipping a title you will have a double vertical dividing line. Extra dividing"
8030 PRINT "lines appear as a right-hand border.  The width of the column is determined by"
8040 PRINT "the title. To extend the width of the title beyond the title word use a period"
8050 PRINT "or quotation marks, eg.: .   123  . or  " CHR$(34) "   b   " CHR$(34) " .   Use (" CHR$(34) ")'s around a title
8055 PRINT "that has commas in it.
8060 TITLELENGTH=20
8070 FOR T=1 TO 10
8080 PRINT "Title for data column number";T;:INPUT TITLE$(T)
8090 TITLELENGTH=TITLELENGTH+LEN(TITLE$(T))
8100 PRINT "You have used " TITLELENGTH "characters. You have room for " 132-TITLELENGTH "more.":PRINT
8110 NEXT T
8120 RETURN
9000 ON ERROR GOTO 15000:LPRINT CHR$(27) "@";
9010 WIDTH "LPT1:",255
9020 LPRINT CHR$(27);CHR$(67);CHR$(0);CHR$(11);'ESC,FORM LENGTH,ELEVEN INCHES
9030 LPRINT CHR$(15);CHR$(27);CHR$(65);CHR$(8);'COMPRESSED,ESC,LINEFEED,8/72 ON
9040 LPRINT CHR$(27)+CHR$(85)+CHR$(1);         'ESC,UNIDIRECTIONAL PRINTING,ON
9050 ON ERROR GOTO 0:RETURN'
10000 DAY$(1)="Saturday":DAY$(2)="Sunday":DAY$(3)="Monday":DAY$(4)="Tuesday":DAY$(5)="Wednesday":DAY$(6)="Thursday":DAY$(7)="Friday"
10010 SKIPDAY$(1)="SAT.":SKIPDAY$(2)="SUN.":SKIPDAY$(3)="MON.":SKIPDAY$(4)="TUE.":SKIPDAY$(5)="WED.":SKIPDAY$(6)="THU.":SKIPDAY$(7)="FRI."
10020 FOR SKN=1 TO 7'                                          subroutine to
10030 PRINT "Do you want to skip "DAY$(SKN);:INPUT SKIP$'      return an array
10040 IF SKIP$="Y" THEN DAYSKIP$(SKN)=SKIPDAY$(SKN):GOTO 10090'of day and null
10050 IF SKIP$="y" THEN DAYSKIP$(SKN)=SKIPDAY$(SKN):GOTO 10090'strings as the
10060 IF SKIP$="N" THEN DAYSKIP$(SKN)="":GOTO 10090'           var. DAYSKIP$
10070 IF SKIP$="n" THEN DAYSKIP$(SKN)="":GOTO 10090'
10080 PRINT "Please answer y or n.":GOTO 10030'   requires no common variables
10090 NEXT'                                       uses SKN,DAYS$(1-7),SKIP$
10100 RETURN'                                     SKIPDAY$(1-7)
11000 ON ERROR GOTO 11130:NOFILE=0
11010 PRINT:PRINT "The following files are available.":FILES "*.frm"
11020 ON ERROR GOTO 0
11030 PRINT:PRINT "What is the filename of the one you want to use":INPUT "(if none type NONE)";FILENAME$
11040 IF FILENAME$="NONE" OR FILENAME$="none" OR FILENAME$="None" THEN NOFILE=1:RETURN
11050 FILENAME$=FILENAME$+".frm"
11060 ON ERROR GOTO 11150:OPEN FILENAME$ FOR INPUT AS #1
11070 INPUT #1,STARTDATE$,ENDDATE$
11080 FOR N=1 TO 7:INPUT #1,DAYSKIP$(N):NEXT
11090 FOR N=1 TO 10:INPUT #1,TITLE$(N):NEXT
11100 INPUT #1,LINES,HEADING$
11110 CLOSE #1:ON ERROR GOTO 0
11120 RETURN
11130 IF ERR=53 THEN 11140 ELSE PRINT "GETFILE TROUBLE":STOP
11140 PRINT "There are no files for this program on this disk.":NOFILE=1:RESUME 11120
11150 IF ERR = 52 THEN PRINT "That is not a correct filespec, try again":RESUME 11020
11160 IF ERR = 62 THEN PRINT "Bad file data. You are trying to read from the wrong file. Try again.":RESUME 11000
11170 IF ERR = 53 THEN 11180 ELSE PRINT "GETFILE TROUBLE":STOP
11180 PRINT "That isn't one of the files available, try again.":RESUME 11020
12000 INPUT Q$'                         subroutine which returns    --
12010 IF Q$="n" THEN A=1:RETURN'         A = 1, 2, or 3 in response    |
12020 IF Q$="N" THEN A=1:RETURN'         to a yes or no question.      |
12030 IF Q$="y" THEN A=2:RETURN'                                       |
12040 IF Q$="Y" THEN A=2 ELSE A=3:PRINT "Please answer Y, y, N, or n."'|
12050 RETURN'                                                       --
13000 ON ERROR GOTO 13160
13010 PRINT:FILES "*.frm"
13020 PRINT:PRINT "The above file names have been used."
13030 ON ERROR GOTO 0
13040 PRINT "What filename do you want to use? (Up to 8 characters, no extension;Type NONE
13050 INPUT "to return to printing without saving modifications.):  FILENAME";FILENAME$
13060 IF FILENAME$="none" OR FILENAME$="None" OR FILENAME$="NONE" THEN RETURN
13070 IF LEN(FILENAME$)>8 THEN PRINT "Filename too long. Try again. Do not use extension. Extension {.FRM} is added.":GOTO 13040
13080 FILENAME$=FILENAME$+".frm"
13090 ON ERROR GOTO 16000' disk error subroutine DSKERROR
13100 OPEN FILENAME$ FOR OUTPUT AS #1
13110 WRITE #1,STARTDATE$,ENDDATE$
13120 FOR N=1 TO 7:WRITE #1,DAYSKIP$(N):NEXT
13130 FOR N=1 TO 10:WRITE #1,TITLE$(N):NEXT
13140 WRITE #1,LINES,HEADING$
13150 CLOSE #1:ON ERROR GOTO 0:RETURN
13160 IF ERR = 53 THEN 13170 ELSE PRINT "MAKEFILE TROUBLE":STOP
13170 PRINT "There are no format files on this disk":RESUME 13030
14000 PRINT "Do you want to modify this form";:GOSUB 12000:ON A GOTO 14010,14020,14000'YESORNOA
14010 MODIFIED=0:RETURN
14020 MODIFIED=1:IF BADTITLE=1 THEN GOTO 14150
14030 IF BADHEAD=1 THEN GOTO 14280
14040 PRINT "The current starting date is "STARTDATE$". Do you want to change it";:GOSUB 12000:ON A GOTO 14080,14050,14040'YESORNOA
14050 PRINT "New ";:GOSUB 1000' enter date DATCHECK
14060 GOSUB 2000' generate numerical date constants  DATTONUM
14070 STARTDATE$=DAT$
14080 PRINT "The current ending date is " ENDDATE$ ". Do you want to change it";:GOSUB 12000:ON A GOTO 14110,14090,14080'YESORNOA
14090 PRINT "New ";:GOSUB 1000' enter date DATCHECK
14100 ENDDATE$=DAT$:GOTO 14110
14110 PRINT "Presntly the days to be skipped are: ";:FOR N=1 TO 7:PRINT DAYSKIP$(N) ", ";:NEXT:PRINT
14120 PRINT "Do you want to change these";:GOSUB 12000'YESORNOA
14130 ON A GOTO 14150,14140,14110
14140 GOSUB 10000' reenter skip days SKIPDAY
14150 PRINT "The present set of column titles is:"
14160 FOR N=1 TO 10:PRINT TITLE$(N):NEXT:PRINT
14170 PRINT "Do you want to change these";:GOSUB 12000:ON A GOTO 14220,14180,14150'YESORNOA
14180 FOR CHG = 1 TO 10
14190 PRINT USING "The title for column ## is:   "; CHG :PRINT SPC(29) TITLE$(CHG) :PRINT "Do you want to change it";:GOSUB 12000:ON A GOTO 14210,14200,14190'YESORNOA
14200 GOSUB 14330:INPUT "New title";TITLE$(CHG):GOSUB 14350
14210 NEXT CHG
14220 IF BADTITLE=1 THEN GOTO 14300
14230 PRINT "The form length options are 1. 31 lines; 2. months; 3. continuous; 4. specified."
14240 PRINT "The current option is " LINES ". Do you want to change it";:GOSUB 12000:ON A GOTO 14280,14250,14230'YESORNOA
14250 INPUT "New option number";LINES
14260 IF LINES<1 OR INT(LINES)<>LINES OR LINES>4 THEN PRINT "Please enter  1, 2, 3, or 4.":GOTO 14230
14270 IF LINES=4 THEN INPUT "Number of lines";LINES
14280 PRINT "The present heading for the chart is:":PRINT:PRINT HEADING$:PRINT "Do you want to change it";:GOSUB 12000:ON A GOTO 14300,14290,14280'YESORNOA
14290 GOSUB 14340:INPUT "New heading";HEADING$:GOSUB 14350:PRINT:PRINT
14300 PRINT "Do you want to save these modifications";:GOSUB 12000:ON A GOTO 14320,14310,14300'YESORNOA
14310 GOSUB 13000'file the new variables MAKEFILE
14320 RETURN
14330 X=CSRLIN:LOCATE 25,1:PRINT "Note: You may edit and enter an isolated line above instead of retyping it!":LOCATE X-4,30:PRINT "12345678901234567890123456789012345678901234567890":LOCATE X,1:RETURN
14340 X=CSRLIN:LOCATE 25,1:PRINT "Note: You may edit and enter an isolated line above instead of retyping it!":LOCATE X-4,1:PRINT "1234567890123456789012345678901234567890123456789012345678901234567890123456789":LOCATE X,1:RETURN
14350 X=CSRLIN:LOCATE 25,1:BLANK$=STRING$(79," "):PRINT BLANK$;:LOCATE X,1:RETURN
15000 IF ERR = 27 THEN PRINT "Printer off or out of paper. Program will continue when problem is corrected.":RESUME
15010 IF ERR = 68 THEN PRINT "Printer unavailable or disabled. Program will continue when problem is corrected.":RESUME
15020 IF ERR = 25 THEN PRINT "Printer fault. Program will continue when problem is corrected.":RESUME
15030 IF ERR = 24 THEN PRINTIME=PRINTIME+1 ELSE PRINT "PRTERROR problem:on error GOTO 0:stop
15040 IF PRINTIME < 2 THEN RESUME ELSE PRINT "Printer off line. Program will continue when problem is corrected.":PRINTIME=0:RESUME
16000 IF ERR=24 THEN PRINT "No disk in drive? Device timeout.":GOTO 16090
16010 IF ERR=57 THEN PRINT "I/O error. Try another disk.":GOTO 16090
16020 IF ERR=61 THEN PRINT "Disk full. Try another disk.":GOTO 16090
16030 IF ERR=64 THEN PRINT "Bad file name. ";:INPUT "Try entering the complete filespec (with extension).";FILENAME$:RESUME
16040 IF ERR=67 THEN PRINT "Too many files in directory. Try another disk to temoroarily save your data.":GOTO 16090
16050 IF ERR=68 THEN PRINT "Disk drive unavailable.":GOTO 16090
16060 IF ERR=70 THEN PRINT "You have write protected this disk!":GOTO 16090
16070 IF ERR=71 THEN PRINT "No disk in drive or door not closed.":GOTO 16090
16080 IF ERR=72 THEN PRINT "Disk Media Error. Try another disk.":GOTO 16090
16090 PRINT "Program will continue when problem is corrected.":RESUME
65000 ' SAVE"DAYLOG.bas",a
 another disk.":GOTO 16