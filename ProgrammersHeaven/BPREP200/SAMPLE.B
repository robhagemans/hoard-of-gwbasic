'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
' Sample.b : Sample input file to demonstrate BPREP
'
'
'
'
#include sample.inc

#define SHAREWARE
'#define REGISTERED

#define HEADER          "Super List [c] 1991 HOME-SPUN Technologies!"+CR+LF+LF
#define USAGE           "USAGE: List <filename>"       ' Usage string

#define LIST_FILE       1                              ' list file number

'
'  A simple delay, change DELAY_T for different delay times
'
#define DELAY_T 10000
#define DELAY for x=1 to DELAY_T:for y = 1 to DELAY_T:z=z*2:next y:next x

'
' Main program follows
'
print HEADER

if command$ = "" then print USAGE : system

open command$ for input as #LIST_FILE

do until eof(LIST_FILE)

        input #LIST_FILE, line$
        print line$

loop

#ifdef SHAREWARE
print "To remove this delay and message register today!"
print "        thank you for using shareware!"
DELAY
#endif

#ifdef REGISTERED
print
print
#endif
