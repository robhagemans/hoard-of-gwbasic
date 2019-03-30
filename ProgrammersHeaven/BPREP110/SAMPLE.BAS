'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
' Sample.b : Sample input file to demonstrate BPREP
'
'
'
'
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
' Sample.inc : Sample include file to demonstrate BPREP
'
'
'
'
              


'#define REGISTERED

                     
       
'
'  A simple delay, change DELAY_T for different delay times
'
  
'
' Main program follows
'
print "Super List [c] 1991 HOME-SPUN Technologies!"+chr$(13)+chr$(10)+chr$(10)

if command$ = "" then print "USAGE: List <filename>" : system

open command$ for input as #1

do until eof(1)

        input #1, line$
        print line$

loop


print "To remove this delay and message register today!"
print "        thankyou for using shareware!"
for x=1 to 10000:for y = 1 to 10000:z=z*2:next y:next x



