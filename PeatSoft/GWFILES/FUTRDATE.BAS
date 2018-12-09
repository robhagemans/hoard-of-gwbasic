1 ' (PC)^3 Software Submission FUTRDATE authored on February 14, 1983 by
2 '
3 ' Michael Csontos, 3228 Livonia Center Road, Lima, New York 14485
4 '
5 ' Copyright 1983 Michael Csontos
6 '
7 '  This program is made freely available non-exclusively to the Picture
8 '  City Personal Computer Programmers' Club for distribution to its members
9 '  and through software exchange to other users groups as long as credit is
10 ' given to the author and (PC)^3.
11 '
12 '
13 ' NOTE: The file FUTRDATE.DOC is associated with this program.
15 '
16 '
10000 DEFINT A-Z:DIM MN$(12),DN$(7):CLS:KEY OFF
10100 DN$(1)="SAT.":DN$(2)="SUN.":DN$(3)="MON.":DN$(4)="TUE.":DN$(5)="WED.":DN$(6)="THU.":DN$(7)="FRI."
10200 MN$(1)="JAN.":MN$(2)="FEB.":MN$(3)="MAR.":MN$(4)="APR.":MN$(5)="MAY.":MN$(6)="JUN.":MN$(7)="JUL.":MN$(8)="AUG.":MN$(9)="SEP.":MN$(10)="OCT.":MN$(11)="NOV.":MN$(12)="DEC."
10300 PRINT "This program will give you the date in the future corresponding to the number":PRINT
10400 PRINT "of days, months, weeks and/or years in the future that you enter.":PRINT
10500 PRINT "The program is limited to the range of dates allowed by the BASIC [DATE$]":PRINT
10600 PRINT "function; i.e. 1980 to 2099.":PRINT
10700 PRINT "You may enter a reference date using the same formats as the [DATE$] command":PRINT
10800 PRINT "or just press <enter> (<"CHR$(17)CHR$(196)CHR$(217)">) to use the current date.":PRINT
10900 SDAT$=DATE$
11000 INPUT;"Date";DAT$
11100 IF DAT$="" THEN DAT$=DATE$:PRINT DAT$:GOTO 11300 ELSE ON ERROR GOTO 11200:DATE$=DAT$:ON ERROR GOTO 0:DAT$=DATE$:PRINT:GOTO 11300
11200 PRINT " Improper date format.":RESUME 11000
11300 PRINT:PRINT "Now enter the time to be added to this date, in any combination of years, ":PRINT
11400 PRINT "months, weeks, and days (integers only).":PRINT
11500 INPUT;"YEARS";IYR!:INPUT;", MONTHS";IMO!:INPUT;", WEEKS";IWK!:INPUT", DAYS";IDY!:PRINT
11600 IF IYR!<>INT(IYR!) OR IMO!<>INT(IMO!) OR IWK!<>INT(IWK!) OR IDY!<>INT(IDY!) THEN PRINT "Inputs must be whole numbers.":PRINT:GOTO 11500
11700 DYS=IDY!+IWK!*7
11800 Y=VAL(RIGHT$(DAT$,4)):D=VAL(MID$(DAT$,4,2)):M=VAL(LEFT$(DAT$, 2))
11900 M=M+IMO!:IF M>12 THEN Y=Y+INT(M/12):M=M MOD 12
12000 Y=Y+IYR!:IF Y>2099 THEN 13300
12100 IF D=29 AND M=2 THEN IF Y MOD 4 <>0 THEN D=D-1
12200 M$=STR$(M+100):D$=STR$(D+100):Y$=STR$(Y+10000):M$=RIGHT$(M$,2):D$=RIGHT$(D$,2):Y$=RIGHT$(Y$,4)
12300 ATE$=M$+"-"+D$+"-"+Y$:ON ERROR GOTO 12400:DATE$=ATE$
12400 ON ERROR GOTO 0:GOTO 12500
12500 FOR N=1 TO DYS
12600 D=D+1
12700 M$=STR$(M+100):D$=STR$(D+100):Y$=STR$(Y+10000):M$=RIGHT$(M$,2):D$=RIGHT$(D$,2):Y$=RIGHT$(Y$,4)
12800 ATE$=M$+"-"+D$+"-"+Y$:ON ERROR GOTO 13000:DATE$=ATE$
12900 ON ERROR GOTO 0:GOTO 13400
13000 IF ERR=5 THEN RESUME 13100 ELSE PRINT "DATGEN TROUBLE":ON ERROR GOTO 0
13100 D=1:M=M+1:IF M=13 THEN 13200 ELSE 13400
13200 M=1:Y=Y+1:IF Y>=2099 THEN 13300 ELSE 13400
13300 PRINT "Cannot go beyond year 2099":PRINT:DATE$=SDAT$:GOTO 13900
13400 NEXT N
13500 M4=M:Y4=Y:IF M4>2 THEN 13600 ELSE M4=M4+12:Y4=Y4-1
13600 N=2+D+M4*2+Y4+INT(Y4/4)-INT(Y4/100)+INT(Y4/400)+INT(.6*(M4+1))
13700 DN=1+INT(1/2+(N/7-INT(N/7))*7)
13800 PRINT "The new date is: ";:COLOR 15,0:PRINT DN$(DN)", "MN$(M);:PRINT USING " ##";D;:PRINT ","Y;:PRINT "  or   "DATE$:PRINT:DATE$=SDAT$:COLOR 7,0
13900 PRINT "Press any key to run the program again except <Esc> which will return to BASIC."
14000 X$=INKEY$:IF X$="" THEN 14000 ELSE IF X$=CHR$(27) THEN KEY ON:END ELSE RUN
65000 '         SAVE"futrdate",a
o BASIC."
14000 X$=INKEY$:IF X$="" THEN 14000 ELSE IF X$=CHR$(27) THEN KEY 