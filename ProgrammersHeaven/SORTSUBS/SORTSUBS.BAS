'SortSubs PowerBASIC Sub/Function Organizer
'(C) Copyright 1993 by Tim Gerchmez

'This source code is freeware - free for
'noncommercial use.  Modified versions of
'this program, whether in source or .exe
'format, may not be distributed.

cls:print "SortSubs PowerBASIC Sub/Function Organizer"
    print "(C) Copyright 1993 by Tim Gerchmez."
    print "Freeware - No Charge for Noncommercial Use."
    print
cd$=curdir$
line input "Path: ";p$
if p$="" then goto skippath
if right$(p$,1)="\" then p$=left$(p$,len(p$)-1)
chdir p$
skippath:
if dir$("*.bas")="" then
	print "No BASIC Files in This Directory."
	chdir cd$
	end
end if
cls:files "*.bas":print
line input "File to Sort (No Path): ";f$
if f$="" then chdir cd$:end
if instr(f$,".")=0 then f$=f$+".bas"
print "Use Dividers between Subs? (Y/N): ";:locate,,1
while not instat:wend
a$=inkey$
if lcase$(a$)="y" then divider%=1 else divider%=0
print:print:print "Checking File - ";
open "i",#1,f$:ct%=0
while eof(1)=0
line input #1,a$:a$=lcase$(a$)
if left$(a$,4)="sub " or left$(a$,9)="function " then
	ct%=ct%+1
end if
wend
close #1:print ct%;"Subs/Functions Found."
if ct%=0 then chdir cd$:end
redim sf$(1:ct%),sg$(1:ct%):print:print "Loading Sub/Function Names...":c%=0
open "i",#1,f$
while eof(1)=0
line input #1,a$:b$=lcase$(a$)
if left$(b$,4)="sub " or left$(b$,9)="function " then
	c%=c%+1
	sf$(c%)=a$
end if
wend
close #1
for t%=1 to c%
	a$=lcase$(sf$(t%))
	if left$(a$,4)="sub " then
		sg$(t%)=right$(a$,len(a$)-4)
	end if
	if left$(a$,9)="function " then
		sg$(t%)=right$(a$,len(a$)-9)
	end if
next t%
print "Sorting..."
array sort sg$(),collate ucase,tagarray sf$()
erase sg$
open "o",#2,"temp.$$$"
print "Writing File (May Take Awhile)... ";:locate,,1

'Pass1 - Write Non Sub/Fn Text

close #1
open "i",#1,f$
while eof(1)=0
line input #1,a$
for t%=1 to c%
if a$=sf$(t%) then
	do
	line input #1,a$
	a$=lcase$(a$)

'Strip Quoted Material
	qm%=0:q$=""
	for zz%=1 to len(a$)
	q%=asc(mid$(a$,zz%,1))
	if q%=34 then qm%=1-qm%
	if qm%=0 and q%<>34 then q$=q$+chr$(q%)
	next zz%
	a$=q$

'Strip REMs
	zz% = INSTR(a$, "rem ")
	if zz%<>0 then
		a$ = LTRIM$(LEFT$(a$, zz% - 1))
		if zz%=1 then a$=""
	end if
	zz% = INSTR(a$, "'")
	IF zz% <> 0 THEN
		a$ = LTRIM$(LEFT$(a$, zz% - 1))
		if zz%=1 then a$=""
	end if

'If no END SUB then loop
	if instr(a$,"end sub") <> 0 then goto nextpointx
	if instr(a$,"end function") <> 0 then goto nextpointx
	loop
end if
next t%
if a$<>"" then print #2,a$
nextpointx:
wend

'Pass2 - Write Sub/Fn Text
close #1
for t%=1 to c%
close #1
open "i",#1,f$
while eof(1)=0
line input #1,a$
if a$=sf$(t%) then
	print #2,chr$(13);chr$(10);
	if divider%=1 then print #2,"'";string$(78,"-")
	print #2,a$

	do
	line input #1,a$
	print #2,a$
	a$=lcase$(a$)

'Strip Quoted Material
	qm%=0:q$=""
	for zz%=1 to len(a$)
	q%=asc(mid$(a$,zz%,1))
	if q%=34 then qm%=1-qm%
	if qm%=0 then q$=q$+chr$(q%)
	next zz%
	a$=q$

'Strip REMs
	zz% = INSTR(a$, "rem ")
	if zz%<>0 then
		a$ = LTRIM$(LEFT$(a$, zz% - 1))
		if zz%=1 then a$=""
	end if
	zz% = INSTR(a$, "'")
	IF zz% <> 0 THEN
		a$ = LTRIM$(LEFT$(a$, zz% - 1))
		if zz%=1 then a$=""
	end if

'If no END SUB then loop
	if instr(a$,"end sub") <> 0 then goto nextpoint
	if instr(a$,"end function") <> 0 then goto nextpoint
	loop
end if
wend
nextpoint:
next t%
close #1:close #2
q%=instr(f$,".")
on error resume next
z$=left$(f$,q%-1)+".bak"
kill z$
name f$ as z$
name "temp.$$$" as f$
chdir cd$
print:print:print "Done!"
