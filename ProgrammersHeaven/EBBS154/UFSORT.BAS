' **************************************************************************
' *             EBBS-PC userfile.key sort module - started 871127          *
' **************************************************************************
'
' This module sorts the USERFILE.KEY file so EBBS-PC can use a binary
' tree userfile search algorithym for FAST logons, etc.
'
' Compile for SPEED vice SIZE.
'
' Update: 05-22-1993
'
'*************************************************************************
'*           INITIALIZE ALL SYSTEM VARIABLES - MISC EBBS SETUP           *
'*************************************************************************

'INITIALIZE:
$COM 0
$COMPILE CHAIN
$CPU 8086
$ERROR ALL OFF
$LIB ALL OFF
$FLOAT EMULATE
$OPTIMIZE SPEED
$OPTION GOSUB OFF, CNTLBREAK OFF
$STATIC  ' All arrays pre-allocated

DIM username$(2500),usernum%(2500)

SHARED mx%,username$(),usernum%()

SCREEN 0, 0, 0
COLOR 0, 0,0
LOCATE , , 0
DEFINT A-Z
SHELL "DEL USERFILE.KEY"
CLS

'**************************************************************************
'*                   EBBS-PC Sort Module Main Routines                    *
'**************************************************************************

INFO.WINDOW: ' Show Sysop whats going on
 CALL WINDW(20, 60, 2, 12): ta = 28
 LOCATE 4: CALL CENTER(" SORTING EBBS-PC USER KEY FILE ")
 LOCATE 6,  ta: PRINT "Userfiles to Read :"
 LOCATE 7,  ta: PRINT "Userfiles Read    :"
 LOCATE 8,  ta: PRINT "Sorting           :";
 color 10:print " No":color 11
 LOCATE 9,  ta: PRINT "Sort Time         :"
 LOCATE 10, ta: PRINT "Writing File #    :"
 COLOR 10

READ.USERFILE: ' Read in usernames & numbers
 OPEN "USERFILE.DAT" FOR RANDOM AS #2 LEN = 512
 mx = LOF(2) / 512
 LOCATE 6, ta + 19: PRINT mx
 FOR i = 1 TO mx: GET #2: LINE INPUT #2, username$(i): usernum(i) = i
 username$(i) = UCASE$(username$(i))
 LOCATE 7, ta + 19: PRINT i: NEXT: CLOSE #2

SORT.NAMES: ' Alpha (Shell) Sort userfile names
 LOCATE 8, ta + 20: PRINT "Yes"
 start.sort! = TIMER
 ARRAY SORT username$(1) FOR mx, TAGARRAY usernum%()
 'call ShellSort
 sort.time! = TIMER - start.sort!
 LOCATE 8, ta + 20: PRINT "No "
 LOCATE 9, ta + 19: PRINT USING  "##.##";sort.time!

WRITE.KEYFILE:
 OPEN "USERFILE.KEY" FOR RANDOM AS #2 LEN = 30
 FOR i = 1 TO mx: PRINT #2, username$(i): PRINT #2, usernum(i): PUT #2
 LOCATE 10, ta + 19: PRINT i: NEXT: CLOSE #2

BOOT.EBBS:
 KILL "SORTUF.FLG"
 a$=""
 IF LEFT$(pbvUserArea$,5)="Local" THEN a$=" L"
 EXECUTE "EBBS-PC.EXE"+a$
 END

'**************************************************************************
'*                     System Sub Programs                                *
'**************************************************************************

SUB CENTER (text$) STATIC
 color 14
 ta = (80 - LEN(text$)) / 2
 LOCATE , ta: PRINT text$
 color 11
END SUB

SUB WINDW (lcol%, rcol%, trow%, brow%) STATIC
 CLS : COLOR 9
 LOCATE trow%, lcol%: PRINT CHR$(201)
 LOCATE trow%, rcol%: PRINT CHR$(187)
 LOCATE brow%, lcol%: PRINT CHR$(200)
 LOCATE brow%, rcol%: PRINT CHR$(188)
 FOR vert% = trow% + 1 TO brow% - 1
  LOCATE vert%, lcol%: PRINT CHR$(186)
  LOCATE vert%, rcol%: PRINT CHR$(186)
 NEXT
 hlen% = rcol% - lcol% - 1
 hlin$ = STRING$(hlen%, 205)
 LOCATE trow%, lcol% + 1: PRINT hlin$
 LOCATE brow%, lcol% + 1: PRINT hlin$;
 LOCATE trow% + 1, lcol% + 1
 COLOR 11
END SUB
