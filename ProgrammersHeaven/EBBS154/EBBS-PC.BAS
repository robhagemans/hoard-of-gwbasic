'EBBS-PC copyright 1987,1988,1989,1990,1991,1992,1993,1994 by Ed Parry
'MSDOS/IBM-PC version started: 08-16-87

' UPDATE IDEAS/NOTES Updated: 03-23-1994

' Optimize - integer math/commands only - etc.
'  QSound, QTimer, QTicks alternate routines
' Add modem presence test
' Add alternate INIT string if it fails 3 times
' UF levels - * = current open sections
' CFG option - NO ratio sections
' Add private uploading to Sysop or user to user
' Add multi/batch ULing
' Xfer: Allow >10 meg filesizes - IE: DL LIST crashes
' Add FLAG files during DL list
' Add NS (nonstop) command for ALL listings (msgs, dl's, etc.)
' Add ufile fields: Autopause on/off, protocol, ANSI on/off, scrn length
' Xfer log - Multi DL - section field o/o
' DL new messages option (offline reader?)
' DOOR - allow mutiple formats - IE: PCBoard, WW4, etc.
' Implement echo conf's
' LHA/PKZIP/ARJ - Add archive file viewing and listing
' Post UL - Add archive virii scan & test
' Simplify text section to single letters vice text
' Add my own internal ANSI output routines (IE: No need for ANSI.SYS!)
' DL Prompt like WWIV - Tag, Untag, Nonstop, Download
' 	V)iew, E)xtra Info, Q)uit, ENTER) Next Screen

'PowerBASIC's compiler options
$COM 8192
$CPU 8086
$ERROR ALL OFF
$FLOAT PROCEDURE
$LIB ALL OFF
$LIB COM ON
$LIB FULLFLOAT ON
$LIB IPRINT ON
$OPTIMIZE SPEED
$OPTION CNTLBREAK OFF, GOSUB OFF
$STATIC
$STRING 8

'Subprogram declares
DECLARE SUB AbortTxt()
DECLARE SUB BadCmd()
DECLARE SUB Bell()
DECLARE SUB CenterLine()
DECLARE SUB CheckCD()
DECLARE SUB ChkSysStats()
DECLARE SUB ChkTime()
DECLARE SUB ClrBufs()
DECLARE SUB ClrScrn()
DECLARE SUB CmdMode(BYVAL STRING)
DECLARE SUB CmdTime()
DECLARE SUB CvtDate()
DECLARE SUB CvtTime()
DECLARE SUB CvtTmr()
DECLARE SUB FindEmpUF()
DECLARE SUB GetSysStats()
DECLARE SUB LmtChg()
DECLARE SUB LoLvl()
DECLARE SUB ModemCmd(BYVAL STRING)
DECLARE SUB NameCase(STRING)
DECLARE SUB NumOnly()
DECLARE SUB OpnUsr()
DECLARE SUB OpnXfer()
DECLARE SUB Prompt(BYVAL STRING)
DECLARE SUB PrnLine()
DECLARE SUB SetBaud()
DECLARE SUB SetDTR(BYVAL INTEGER)
DECLARE SUB SrchKey()
DECLARE SUB StatLine()
DECLARE SUB Tout(BYVAL STRING)
DECLARE SUB TXWait()
DECLARE SUB UpdSysStats()
DECLARE SUB Updton()

DEFINT A-Z

'Initialize variables, etc.
DIM Text$(250),bt$(2),pt$(2),rc$(2),xm$(5),rx$(5),sx$(5)
DIM mblv$(15),hmsg$(26),hmsg(26),rb(26),uff$(17),ufl(17),ufu(17)
DIM ufe$(17),ufo$(17),uhm$(26),stat$(12),sst$(12),sst!(12),xft(10,2)
DIM dl(26),xp$(26),dl$(26),xfe$(6),xff$(6),xfu(6),xfl(6),xft$(10,5)
DIM mb$(30),ix(26),pa$(5),Cfg$(50),hdr$(4),Ansi$(18)
DIM Temp(0 TO 72) AS INTEGER

SHARED lm,lsr,mcr,msr,r$,r2$,s$,p,pt$(),pt,ta
SHARED cps,Port$,dcd,cdm,da$,ti$,True,False,a$,oops
SHARED Port,Cfg$(),PgLen,scrows,Crsr$,it,ton,sec$
SHARED del$,bs$,Start!,Offset!,OnLine,sst$(),sst!(),koff
SHARED au$,stat$(),dl(),dl$(),fi$,ab,ts,nm,nx,ab$
SHARED totl,ct$,ct,uc,gk,i$,wl,cl,ww$,pw%,bt
SHARED dos$,bt$(),nq,i,abort,no,yes,gyn,ch,chrq,itx
SHARED nc,chat,nokey,ot,ufo$(),ufe$(),nam$,ub%,uff$()
SHARED ufl(),ufu(),lod$,ok$,unam$,uhm$()
SHARED yn$,ny$,minon,xp$(),dl,tlim,tl,qu,ac,lv1$,lv2$
SHARED mb$(),ac$,b$,sy$,mblv$(),mn$,Esc$,Ansi,Ansi$(),Baud

SCREEN 0

OPEN "CONS:" FOR OUTPUT AS #9 'Ansi ouput
PRINT#9,chr$(27)"[0;1;37;40m"chr$(27)"[2J"; 'cls

ON ERROR GOTO ErrHan

oops=0:OPEN "SORTUF.FLG" FOR INPUT AS #2
 IF oops=0 THEN
  CLOSE #2
  a$=UCASE$(COMMAND$)
  IF INSTR(a$,"L") THEN pbvUserArea$="Local"
  RUN "UFSORT.PBC"
 END IF
CLOSE #2

up$="04-02-1994"
au$="Ed Parry"
ve$="v1.54"
rg$="PB30/Ep"

r$=CHR$(13)+CHR$(10)
r2$=r$+r$
Esc$=chr$(27)+"["
uf=17
'Exit to DOS = Alt=F10
dos$=CHR$(0)+CHR$(113)
s$=SPACE$(1)
q$=CHR$(34)
pt%=1
True=-1
False=NOT True
NoKey=360
Start!=TIMER
Offset=0
ufo$(7)="Keyboard"
mg$=" Message"
tr$="Upload/Download"
pt$(0)="Auto Pause off."
pt$(1)="Auto pause on."
rc$(0)="Continuous read now off."
rc$(1)="Continuous read now on."
xm$(1)="Xmodem CRC"
xm$(2)="Xmodem 1k "
xm$(3)="Ymodem Bat"
xm$(4)="Zmodem    "
xm$(5)="Ymodem-G  "
xm = 4 'default to zmodem
sx$(1)="sx -c"
sx$(2)="sx -k"
sx$(3)="sb -k"
sx$(4)="sz -m"
sx$(5)="sb -g"
rx$(1)="rc"
rx$(2)="rc"
rx$(3)="rb"
rx$(4)="rz -m"
rx$(5)="rb -g"
ac$="Access"
dl$(0)="All"
bt$(1)="\/,?*!@$%^&()+={}[]:;'<>|`~"+q$
bt$(2)=" #"+bt$(1)
b=0
ub=17
sy$="System Operator"
ll$="60"
clc=100
xlc=100
Ansi=False
GOSUB InitAnsi

DEF fnss$ (tx$) 'Strip Spaces
 i$=LTRIM$(RTRIM$(tx$))
 WHILE INSTR(i$,"  ")
  REPLACE "  " WITH " " IN i$
 WEND
 fnss$=i$
END DEF

DEF fncf$ (tx$) 'get CLEAN config data
 a$=MID$(tx$,INSTR(tx$,"=")+1)
 a$=fnss$(a$):fncf$=a$
END DEF

'*** CONFIG ROUTINES ***

oops=0:OPEN "EBBSCFG.DAT" FOR INPUT AS #2
IF oops=53 THEN
 PRINT #9,"EBBSCFG.DAT file not found. This file is required to run EBBS-PC."
 Bell
 CLOSE #2
 END
END IF

'Get cfg data
INPUT #2,x1
FOR i=1 TO x1
 LINE INPUT #2,a$
 Cfg$(i)=fncf$(a$)
NEXT
INPUT #2,x2
FOR i=1 TO x2
 INPUT #2,a$
 mb$(i)=fncf$(a$)
NEXT
INPUT #2,x3
FOR i=1 TO x3
 INPUT #2,a$,b$
 dl$(i)=fncf$(a$)
 xp$(i)=fncf$(b$)
NEXT
INPUT #2,x4
FOR i=1 TO x4
 INPUT #2,a$,ufl(i),ufu(i)
 uff$(i)=fncf$(a$)
NEXT
INPUT #2,x5
FOR i=1 TO x5
 INPUT #2,a$,xfl(i),xfu(i)
 xff$(i)=fncf$(a$)
NEXT
INPUT #2,x6
FOR i=1 TO x6
 INPUT #2,a$
 stat$(i)=fncf$(a$)
NEXT
INPUT #2,x7
FOR i=1 TO x7
 INPUT #2,a$
 mblv$(i)=fncf$(a$)
NEXT
CLOSE #2

'Init data
Port=VAL(Cfg$(1))
cdm=VAL(Cfg$(16))
ratio=VAL(Cfg$(29))
numblv$=Cfg$(30)
nuxflv$=Cfg$(31)
tlim=VAL(Cfg$(32))
mbc=VAL(mb$(27))
pl=VAL(mb$(28))
scrows=VAL(Cfg$(18))
scols=VAL(Cfg$(19))
PgLen=25-3
ufo$(3)=Cfg$(21)
ufo$(4)=Cfg$(22)
FOR i=1 TO x4
 uff$(i)=LEFT$(uff$(i)+SPACE$(15),10)+": "
NEXT
FOR i=1 TO x5
 xff$(i)=LEFT$(xff$(i)+SPACE$(15),11)+": "
NEXT
FOR i=1 TO x6
 stat$(i)=LEFT$(stat$(i)+SPACE$(15),11)+": "
NEXT
FOR i=25 TO 32
 Cfg$(i)=UCASE$(Cfg$(i))
NEXT
IF INSTR(Cfg$(26),"ON") THEN cb=True
IF INSTR(Cfg$(27),"ON") THEN Ansi=True:GOSUB InitAnsi
IF INSTR(Cfg$(28),"Y") THEN xopn=True
Baud=VAL(Cfg$(14))
a$=UCASE$(COMMAND$)
IF INSTR(a$,"L") THEN Port=0 ELSE IF VAL(a$)>0 THEN Port=VAL(a$)

'Onward...

msr=&H3FE
mcr=&H3FC
lsr=&H3FD
IF Port=0 THEN Port$="CONS: ":lm=True
IF Port THEN Port$="COM"+MID$(STR$(Port),2)+": "
IF Port=2 OR Port=4 THEN msr=&H2FE:mcr=&H2FC:lsr=&H2FD

IF Cfg$(34) <> "NONE" THEN SHELL Cfg$(34)

PRINT#9,Esc$"H"Esc$"0;1;7;37;40m"SPACE$(80);Esc$"1;7H EBBS-PC "ve$;
PRINT#9,", Update: "up$;". EBBS-PC written by "au$"."Esc$"0;1;36;40m"
DELAY 1
SetBaud

'*** MODEM RESET,INIT AND ANSWER ROUTINES **

ResMdm:'Reset modem
 IF Port=0 or test THEN wr=1:GOTO WaitCall
 PRINT#9,Esc$"0;1;36m"Esc$"3;27H Modem Reset: _"CHR$(8);
 IF b=5 THEN
  PRINT#9,Esc$"0;1;31mReset problem; check RESET string."
  Bell
  b=0
  GOTO InitMdm
 END IF
 SetDTR False 'dtr off
 SetBaud
 PRINT #1,r$
 CheckCD
 IF dcd THEN CmdMode Cfg$(13)
 DELAY 1
 ClrBufs
 c!=TIMER
 c=0
 ModemCmd Cfg$(8)
 DO WHILE EOF(1)
  IF TIMER > c!+6 THEN c=True:EXIT DO
 LOOP
 DELAY .1
 a$=INPUT$(LOC(1),1)
 a=INSTR(a$,"0")+INSTR(a$,"O")
 IF c OR a=0 THEN
  INCR b
  PRINT#9,Esc$"0;1;31mFailed. Retry #"b
  GOTO ResMdm
 END IF
 PRINT#9,Esc$"0;1;33mOK"SPACE$(20)
 b=0

InitMdm:
 PRINT#9,Esc$"0;1;36m"Esc$"4;28HModem Init : _"CHR$(8);
 IF b=5 THEN
  PRINT#9,Esc$"0;1;31mInit problem; check INIT string."
  Bell
  wr=1
  DELAY 3
  PRINT#9,Esc$"0;1;36m";
  GOTO WaitCall
 END IF
 ClrBufs
 c!=TIMER
 c=0
 CheckCD
 IF dcd THEN CmdMode Cfg$(13)
 DELAY 1
 ClrBufs
 ModemCmd Cfg$(9)
 DO WHILE EOF(1)
  IF TIMER > c!+6 THEN c=True:EXIT DO
 LOOP
 DELAY .1
 a$=INPUT$(LOC(1),1)
 a=INSTR(a$,"O") 'MUST BE VERBOSE!
 IF c OR a=0 THEN
  INCR b
  PRINT#9,Esc$"0;1;31mFailed. Retry #"b
  GOTO InitMdm
 END IF
 PRINT#9,Esc$"0;1;33mOK"SPACE$(20)
 ClrBufs
 wr=1

WaitCall:'set-up "Waiting for call" screen
 ClrScrn
 a$=mid$(str$(wr),2)
 PRINT#9,Esc$a$";1H";
 PrnLine
 GetSysStats
 a=LEN(Cfg$(20))+LEN(sst$(2))+LEN(sst$(5))+30
 a=(80-a)\2-2
 a$=mid$(str$(a),2)
 PRINT#9,Esc$"0;1;32m"Esc$a$"CLast User: "Esc$"0;1;36m"sst$(2)s$s$;_
   Esc$"0;1;37;44m"s$s$Cfg$(20)s$s$Esc$"0;1;32;40m  Total Log Ons: ";_
   Esc$"0;1;33m"sst$(5)
 PrnLine
 PRINT#9,Esc$"0;1;33m"Esc$"8CPress "Esc$"0;1;37;47m[ды ENTER]";_
   Esc$"0;1;33m for Sysop Menu - Press "_
   Esc$"0;1;37;47m[SPACE BAR]"Esc$"0;1;33m to Log On"
 PrnLine
 a$="Waiting for Call"
 IF Port=0 THEN a$="Waiting for User"
 PRINT#9,Esc$"0;1;32m"Esc$"14CSystem Status: "Esc$"0;1;31m"a$
 PrnLine
 CvtDate
 mt$=ti$
 i$=""

GetCall:'check for ring indicator loop
 CvtDate
 IF mt$ <> ti$ THEN
  IF wr+8 > scrows-6 THEN wr=1:GOTO WaitCall
  wr=wr+8
  GOTO WaitCall
 END IF
 a$=mid$(str$(wr+5),2)
 IF i$ <> RIGHT$(ti$,1) THEN
  PRINT#9,Esc$a$";46H"Esc$"0;1;37;40m : "da$" - "ti$Esc$"0;30;40m"s$
  i$=RIGHT$(ti$,1)
 END IF
 IF LEFT$(TIME$,8)="23:59:59" THEN GOTO DEVENT
 c=INP(msr) AND cdm
 k$=INKEY$ 'ring, dcd or key
 IF (k$=CHR$(13)) OR (k$=s$) THEN GOTO GotCall
 IF k$=dos$ THEN PRINT#9,Esc$"0;37;40m";:CLEAR:END
 IF Port > 0 THEN
  IF c=128 OR RIGHT$(k$,1)=CHR$(63) OR NOT EOF(1) THEN
   CmdMode Cfg$(13)
   ModemCmd Cfg$(10) 'auto ans
   k$=""
   GOTO GotCall
  END IF
 END IF
 IF oops <> 0 THEN CLOSE #1:RUN 'AN ERROR...
GOTO GetCall

GotCall:'Somethin's happenin'!
 x=0
 CvtDate
 lotim$=ti$
 lt$=LEFT$(TIME$,5)
 Start!=TIMER
 DELAY .1
 CvtTmr
 b$=mid$(str$(wr+5),2)
 IF k$ > "" THEN
  PRINT#9,Esc$b$";29H"Esc$"0;1;37;45m  LOCAL INTERRUPT  "Esc$"0;1;36m";
  tlim=180:lm=True
  lv2$="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  lv1$=lv2$+"123456789"
  nokey=1800
  PgLen=scrows-3
  ModemCmd Cfg$(11)
  IF Port>0 THEN DELAY 1
  ClrBufs
 END IF
 IF k$=CHR$(13) THEN
  nam$=sy$
  ufo$(11)="LOCAL"
  ClrBufs
  FOR c=11 TO 16
   ufo$(c)="N/A"
  NEXT
  ClrScrn
  StatLine
  GOTO SysMenu
 END IF
 IF k$ > "" THEN GOTO PrintID
 PRINT#9,Esc$b$";29H"Esc$"0;1;5;37;41m  CALL ANSWERED   "Esc$"0;1;36m";
 CheckCD
 WHILE (dcd=0) AND (ton < 45)
  CheckCD
  CvtTmr
 WEND
 IF dcd=0 THEN
  PRINT#9,Esc$b$";29H"Esc$"0;1;37;46m    NO CARRIER    "Esc$"0;1;36;40m";
  DELAY 2
  GOTO HANGUP
 END IF
 a$=""
 c!=TIMER
 Cfg$(14)=""
 ufo$(7)="Remote"
GBL:
 IF NOT EOF(1) THEN a$=a$+INPUT$(LOC(1),1)
  IF INSTR(a$,"14") THEN Cfg$(14)="14400"
  IF INSTR(a$,"96") THEN Cfg$(14)= "9600"
  IF INSTR(a$,"24") THEN Cfg$(14)= "2400"
  IF INSTR(a$,"12") THEN Cfg$(14)= "1200"
 IF (c!+5 < TIMER) OR (TIMER < 6) AND (Cfg$(14)="") THEN GOTO GBL
GOT1:
 IF Cfg$(14)="" THEN Cfg$(14)="2400" 'most common Baud
 a$="CONNECT "+Cfg$(14)
 SetBaud
 lm=False
 b$=mid$(str$(wr+5),2)
 ClrBufs
 PRINT#9,Esc$b$";29H"Esc$"0;1;33;44m   "a$"   ";
 ClrScrn
 CvtDate
 a$=Cfg$(14)+" Baud connection at "+ti$+" on "+da$
 CenterLine
 Tout SPACE$(ta)+a$
 a$="EBBS-PC "+ve$+" by "+au$+" - ID: "+rg$
 CenterLine
 Tout r$+SPACE$(ta)+a$
 a$="Would you like Ansi Color/Graphics (ENTER=No)? "
 Prompt r$+space$(16)+a$
 Bell
 TXWait
 gyn=False
 GOSUB GetYNA
 Ansi=False
 IF yes THEN Ansi=True
 GOSUB InitAnsi
 GOTO PrintID

'*** ERROR HANDLER ***

ErrHan:
 oops=ERR ' keep an eye on the REM'd lines.
 SELECT CASE oops
  CASE=11 'division by 0
   Tout r$+"Division by 0 error. MAIN MENU recover."
   RESUME MainMenu
  CASE=24
   DELAY .2
   RESUME NEXT 'CTS Timeout error
  CASE=52 'bad filename or number
   CLOSE #2,#3,#4
   Tout r$+"Bad file name/# error. MAIN MENU recover."
   RESUME MainMenu
  CASE=53 'file not found
   RESUME NEXT
  CASE=55 'file already open
   CLOSE #2,#3,#4
   RESUME
  CASE=57 'modem i/o error
   SetBaud
   RESUME NEXT
  CASE=58 'file exists (always overwrite)
   CLOSE #2
   RESUME NEXT
  CASE=64 'bad filename
   RESUME NEXT
  CASE=69 'comm input buffer overflow
   ClrBufs
   RESUME NEXT
  CASE=76 'path not found
   Tout r$+"Path not found."
   RESUME NEXT'path error
  CASE ELSE 'log error & rerun EBBS
   a$=r$+"System Error #"+STR$(oops)+" - "
   a$=a$+"System must reset (hang-up) to recover. "
   Tout r$+a$
   DELAY 5
   CLOSE #2
   OPEN "ERROR.LOG" FOR APPEND AS #2
   IF nam$="" THEN nam$="EBBS"
   PRINT #2,"Error -"oops"at "TIME$" on "DATE$" - "nam$
   CLOSE #2, #1
   RUN
 END SELECT

'*** SYSTEM LOGOFF ROUTINES ***

Logoff:' Here's where we say goodbye!
 IF nam$=sy$ THEN GOTO LOGO1
 qu=1
 Prompt r$+Ansi$(1)+"Log off - "+Ansi$(6)
 Prompt "Leave the System Operator Comments "+Ansi$(3)+"(N/y/abort)? "
 gyn=False
 GOSUB GETYNA
 IF abort THEN GOTO MainMenu
 IF yes THEN sn$=sy$:GOSUB SendMail
LOGO1:
 fi$="CB"
 pt%=0
 GOSUB OUTFILE
 Tout r$+Ansi$(5)+"Logged in : "+lotim$
 CvtDate
 Tout Ansi$(6)+"Logged out: "+ti$
 CvtTmr
 a$=Ansi$(7)+"Time used :"+STR$(INT(ton\60))
 a$=a$+" mins"+STR$(ton MOD 60)+" secs."
 Tout a$

LostCD: 'Save email if carrier was lost
 CLOSE #2
 Tout r$+Cfg$(23)
 Tout ""
 DELAY 3

Hangup: 'Here's where we dump 'em!
 ClrBufs
 SetDTR False 'drop dtr
 DELAY 1
 CheckCD
 IF dcd=False THEN
  CmdMode Cfg$(13)
  ModemCmd Cfg$(12)
 END IF
 IF LEN(nam$) > 4 THEN GOSUB LogoffRouts
 IF Start!=0 OR Start! > TIMER THEN GOTO DEVENT
 CLOSE #1
RUN

LogoffRouts: 'Update caller log,userfile,delete email
 IF nam$=sy$ THEN GOTO UpdClog
 IF LEN(nam$) < ufl(1) OR LEN(nam$) > ufu(1) OR qx% OR un=0 THEN RETURN

UpdClog:
 PRINT #9,Ansi$(3)"Updating Caller Log... ";
 oops=0
 OPEN "CALLER.LOG" FOR INPUT AS #2
 IF oops=53 THEN GOTO UCL1
 i=0
 WHILE NOT EOF(2) AND i < clc+1
  INCR i
  LINE INPUT #2,Text$(i)
 WEND
UCL1:
 CLOSE #2
 CvtDate
 i=0
 OPEN "CALLER.LOG" FOR OUTPUT AS #2
  a$=LEFT$(ufo$(3),16)+", "+ufo$(4)
  PRINT #2,nam$SPACE$(20-LEN(nam$))a$SPACE$(20-LEN(a$));
  PRINT #2,lt$"/"LEFT$(TIME$,5)s$s$da$s$RIGHT$(s$+Cfg$(14),5)s$s$;
  CvtTmr
  a$=MID$(STR$(INT(ton\60)),2)
  a$=RIGHT$("  "+a$,3)
  PRINT #2,a$
  WHILE i < clc+1 OR Text$(i) > ""
   INCR i
   IF LEN(Text$(i)) > 30 THEN PRINT #2,Text$(i)
  WEND
 CLOSE #2
 i=un
 PRINT #9,r$;
 ERASE text$
 IF INSTR(lv1$,"0") THEN RETURN

'Update userfile
 IF nam$=sy$ THEN GOTO UpdStats
 ufo$(11)=da$
 CvtTmr
 totl=INT((ton-ot)\60)+VAL(ufo$(17))
 ufo$(17)=MID$(STR$(totl),2)
 PRINT #9,r$Ansi$(4)"Updating "nam$"'s user file... ";
 OpnUsr
 FOR ix=1 TO ub
  PRINT #2,ufo$(ix)
 NEXT
 FOR ix=1 TO 26
  PRINT #2,MID$(STR$(hmsg(ix)),2)
 NEXT
 PUT #2,un
 CLOSE #2
 PRINT #9,r$;

UpdStats:
 PRINT #9,r$Ansi$(6)"Updating System Statistic's Log... ";
 CvtDate
 CvtTmr
 mins=INT(ton\60)
 sst$(3)=ti$
 sst$(4)=MID$(STR$(mins),2)
 sst$(2)=nam$
 sst!(11)=sst!(11)+mins
 IF sst!(11) > TIMER/60 THEN sst!(11)=TIMER/60
 UpdSysStats
 PRINT #9,r$
RETURN

'*** LOGON ROUTINES ***

PrintID:' Print system identification
 ClrBufs
 ClrScrn
 pt%=0
 fi$="ID"+ans$
 GOSUB OUTFILE
 a=0
 pt%=1

Logon: ' Get username and password
 IF a=3 THEN GOTO HANGUP
 qx%=True
 ClrBufs
 Prompt r$+Ansi$(3)+"Please enter your name: "
 pw=2
 tl=35
 ac=True
 GOSUB GETLINE
 i$=fnss$(i$)
 NameCase i$
 e$=i$
 i$=UCASE$(i$)
 IF i$="NEW" THEN e$="":GOTO UsrApp
 nam$=i$
 flo=INSTR(nam$,";")
 IF flo THEN
  nam$=MID$(nam$,1,flo-1)
  pw$=MID$(i$,flo+1)
 END IF
 IF LEN(nam$) < ufl(1) THEN
  Tout Ansi$(1)+ne$+"short!"
  INCR a
  GOTO Logon
 END IF
 IF LEN(nam$) > ufu(1) THEN
  Tout Ansi$(1)+ne$+"long! "
  INCR a
  GOTO Logon
 END IF
 IF flo=0 THEN Prompt Ansi$(5)+"Searching..."
 unam$=nam$
 SrchKey
 IF i=0 THEN
  Tout Ansi$(1)+"Userfile not found."
  GOTO UsrApp
 END IF
 un=i
 OpnUsr
  GET #2,un
  FOR ix=1 TO ub
   LINE INPUT #2,ufo$(ix)
  NEXT
  FOR ix=1 TO 26
   LINE INPUT #2,hmsg$(ix)
   hmsg(ix)=VAL(hmsg$(ix))
  NEXT
 CLOSE #2
 IF INSTR(lv1$,"0") THEN
  Prompt r2$+Ansi$(1)+"Your application is pending validation. "
  Tout "Please try back later."
  GOTO LostCD
 END IF
 IF ufo$(11)=da$ THEN
  totl=VAL(ufo$(17))
   ELSE
    ufo$(17)="0"
    totl=0
  END IF
 lv1$=ufo$(9)
 ChkTime
 IF koff THEN GOTO HANGUP
 IF flo THEN GOTO GPW0
 FOR ix=1 TO LEN(Ansi$(5)+"Searching...")
  PRINT #9,del$;
  IF NOT lm THEN PRINT #1,bs$;
 NEXT
 a=0

GetPass:
 IF a=3 THEN
  Tout Ansi$(1)+ac$+" Denied!"
  GOTO LostCD
 END IF
 Prompt Ansi$(3)+"       System Password: "
 pw=1
 uc=1
 tl=ufu(8)
 GOSUB GETLINE
 pw$=i$
GPW0:
 a$=ufo$(8)
 a$=UCASE$(a$)
 IF a$ <> pw$ THEN
  Tout r$+Ansi$(1)+"Incorrect!"+r$
  flo=0
  INCR a
  GOTO GetPass
 END IF

InitUvars:
 qx%=0
 nam$=ufo$(1)
 lv1$=ufo$(9)+numblv$
 lv2$=ufo$(10)+nuxflv$
 c=VAL(ufo$(12))+1
 ufo$(12)=MID$(STR$(c),2)' update # of calls
 IF INSTR(lv1$,"8") THEN tlim=120

'*** WE'RE OnLine! ***

 StatLine
 Tout r$+Ansi$(6)+Cfg$(20)+" Welcomes "+nam$+"!"
 INCR sst!(5)
 INCR sst!(6)
 sst$(5)=MID$(STR$(sst!(5)),2)
 UpdSysStats
 Prompt r$+Ansi$(2)+"Display User and System Stats"+yn$
 gyn=True
 GOSUB GETYNA
 IF yes THEN
  GOSUB UsrStats
  p=PgLen+5
  GOSUB AUTOPAUSE
 END IF
 GOSUB ReadMail
 fi$="OB"
 oops=0
 OPEN fi$ FOR INPUT AS #2
  IF oops=53 THEN
   Tout r$+Ansi$(1)+fi$+" not found."
   CLOSE #2
   GOTO MainMenu
  END IF
  IF NOT EOF(2) THEN
   LINE INPUT #2,a$
   a$=MID$(a$,26,8)
   IF RIGHT$(a$,1)=s$ THEN a$=LEFT$(a$,8)
   i$=a$
   GOSUB DatNum
   a$=i$
   i$=ufo$(11)
   GOSUB DatNum
  END IF
 CLOSE #2
 IF (VAL(a$)) >= (VAL(i$)) OR (VAL(ufo$(12))=1) THEN
  Prompt r2$+SPACE$(8)+Ansi$(6)+"Opening Bulletin"
  AbortTxt
  GOSUB OUTFILE
 END IF
 GOTO MainMenu

'*** NEW USER LOGON ROUTINES ***

UsrApp:
 Prompt r$+Ansi$(5)+"Apply for System Usership"+yn$
 gyn=True
 GOSUB GETYNA
 IF yes THEN
  fi$="NULOM"
  GOSUB OUTFILE
  GOTO GetApp
 END IF
 Prompt r$+Ansi$(7)+"Try to log on again"+yn$
 gyn=True
 GOSUB GETYNA
 IF yes THEN a=0:GOTO Logon
 GOTO LostCD

GetApp:
 Prompt r$+Ansi$(5)+"Apply for System Usership"+yn$
 gyn=True
 GOSUB GETYNA
 IF no OR abort THEN GOTO HANGUP
 ClrScrn
 a$="Ye Olde EBBS Application"
 CenterLine
 Tout SPACE$(ta)+Ansi$(2)+a$
 a$="Please enter the following information: "
 CenterLine
 Tout SPACE$(ta)+a$+r$
 FOR ix=1 TO 8
  nq=1
GEAP1:
  IF abort=3 THEN GOTO HANGUP
  Prompt Ansi$(3)+uff$(ix)
  pw=0
  IF ix=7 THEN pw=3
  ac=True
  IF ix=4 THEN uc=True
  IF ix=1 THEN IF INSTR(e$,";")=0 then ww$=e$
  bt=1
  tl=ufu(ix)
  GOSUB GETLINE
  i$=fnss$(i$)
  a$=""
  IF LEN(i$)=0 THEN INCR abort:GOTO GEAP1
  IF ix=1 AND INSTR(i$,s$)=0 THEN
   Tout Ansi$(1)+"Please Reenter your first AND last name."
   GOTO GEAP1
  END IF
  IF LEN(i$) < ufl(ix) THEN
   Tout Ansi$(1)+lod$+"short. (Minimum length ="+STR$(ufl(ix))+""
   GOTO GEAP1
  END IF
  IF ix=1 THEN
   Text$(1)=LEFT$(i$,INSTR(i$,s$)-1):Text$(2)=MID$(i$,INSTR(i$,s$)+1)
  END IF
  IF ix<4 THEN NameCase i$
  ufe$(ix)=i$
 NEXT
 Prompt r$+Ansi$(3)+"Is the above data correct"+yn$
 gyn=True
 GOSUB GETYNA
 IF no OR abort THEN GOTO GetApp
'Check for duplicate user file
 Prompt r$+Ansi$(6)+"Checking for duplicate and/or disallowed username... "
 OpnUsr
  GET #2,1
  abort=False
  WHILE NOT EOF(2) AND abort=False
   LINE INPUT #2,a$
   IF a$=ufe$(1) THEN abort=True
   GET #2
  WEND
 CLOSE #2
 IF NOT abort THEN GOTO ChkTrash
 Tout r$+Ansi$(1)+"Your name is already in our userfile."
 GOTO GetApp

ChkTrash:' Checks TRASH.CAN file for illegal names or text
 oops=0
 OPEN "TRASH.CAN" FOR INPUT AS #2
  abort=False
  IF oops=53 THEN GOTO GetEmpUF
  a$=Text$(1)
  a$=UCASE$(a$)
  b$=Text$(2)
  b$=UCASE$(b$)
  DO WHILE NOT EOF(2) AND abort=False
   LINE INPUT #2,c$
   c$=UCASE$(c$)
   IF a$=c$ OR b$=c$ THEN abort=True
  LOOP
  IF abort THEN
   Tout r2$+Ansi$(1)+"Unauthorized text detected in your name: "+c$
   CLOSE #2
   GOTO GetApp
  END IF

GetEmpUF:
 CLOSE #2
 Tout r2$+Ansi$(6)+"No duplicate username found."
 ERASE text$
 FindEmpUF
 un=i

'Save new userfile
 CvtDate
 Prompt r$+Ansi$(5)+"Adding you into the system userfiles... "
 OpnUsr
  FOR ix=1 TO 8
   PRINT #2,ufe$(ix)
  NEXT
  PRINT #2,numblv$
  PRINT #2,nuxflv$
  PRINT #2,da$
  FOR ix=1 TO 32
   PRINT #2,"0"
  NEXT
  PUT #2,un
 CLOSE #2
 Tout r$
 Prompt "Updating the system NEW USER log... "
 INCR sst!(12)
 UpdSysStats
 CvtDate
 oops=0
 OPEN "NEWUSER.LOG" FOR APPEND AS #2
  PRINT #2,ufe$(1)+SPACE$(21-LEN(ufe$(1)));
  PRINT #2,ufe$(3)+"/"+ufe$(4)+SPACE$(24-(LEN(ufe$(3))+3));
  PRINT #2,da$+" - "+ti$
 CLOSE #2
 OPEN "SORTUF.FLG" FOR OUTPUT AS #2:CLOSE #2
 IF numblv$ = "0" THEN
  Tout r$+Ansi$(1)+"Your System validation is now pending."
  Tout r$+Ansi$(7)+"Please try back after 24 hours."
  DELAY 10
  GOTO HANGUP
 END IF
 Prompt r2$+Ansi$(2)+"Are you ready to log on"+yn$
 gyn=True
 GOSUB GETYNA
 IF no OR abort THEN GOTO HANGUP
 OpnUsr
  GET #2,un
  FOR ix=1 TO ub
   LINE INPUT #2,ufo$(ix)
  NEXT
  FOR ix=1 TO 26
   LINE INPUT #2,hmsg$(ix)
   hmsg(ix)=VAL(hmsg$(ix))
  NEXT
  CLOSE #2
 GOTO InitUvars

'*** MAIN MENU ***

MainMenu:
 sn$=""
 CLOSE #2
 GOTO MM1
MM0:
 fi$="MM"+ans$
 GOSUB OUTFILE
 IF ab THEN GOTO MM1
MM1:
 ChkTime
 IF koff THEN GOTO LostCD
 CmdTime
 Prompt r$+ct$+"MAIN MENU: "
 GOSUB GETKEY
 IF chat THEN GOSUB SYSCHAT:GOTO MainMenu
 SELECT CASE i$ 'get main menu choice
  CASE="?",""
   GOTO MM0
  CASE="A"
   IF INSTR(lv1$,"1") THEN GOTO MsgArea
   LoLvl
   GOTO MainMenu
  CASE="B"
   fi$="OB"
   GOSUB OUTFILE
   GOTO MainMenu
  CASE="C"
   GOTO DispClog
  CASE="D"
   IF INSTR(lv1$,"4") THEN GOTO DOORMenu
   LoLvl
   GOTO MainMenu
  CASE="E"
   GOSUB SendMail
   GOTO MainMenu
  CASE="F"
   sn$=sy$
   GOSUB SendMail
   GOTO MainMenu
  CASE="G"
   GOTO Logoff
  CASE="K"
   Ansi=Ansi XOR -1
   GOSUB InitAnsi
   IF NOT Ansi THEN
    a$="Ansi now off."
    PRINT #9,Esc$"0;1;36m";
    ELSE
     a$=Ansi$(3)+"Ansi now on."+Ansi$(2)
   END IF
   Tout r$+a$
   GOTO MainMenu
  CASE="M"
   IF un=0 then un=1
   GOSUB ReadMail
   GOTO MainMenu
  CASE="P"
   GOTO ChngPass
  CASE="S"
   GOSUB UsrStats
   GOTO MainMenu
  CASE="T"
   IF INSTR(lv1$,"3") THEN GOTO TextMenu
   LoLvl
   GOTO MainMenu
  CASE="U"
   GOTO UFDisplay
  CASE="V"
   GOSUB Info
   GOTO MainMenu
  CASE="X"
   IF INSTR(lv1$,"2") THEN GOTO XferMenu
   LoLvl
   GOTO MainMenu
  CASE="Y"
   GOSUB YStats
   GOTO MainMenu
  CASE="!"
   GOTO SysopPage
  CASE="*"
   pt%=ABS(pt%-1)
   Tout r$+pt$(pt%)
   GOTO MainMenu
  CASE="^"
   IF INSTR(lv1$,"9") THEN GOTO SysMenu
  CASE ELSE
   BadCmd
 END SELECT
GOTO MainMenu

'*** MAIN ROUTINES ***

ChngPass:
 Prompt r$+Ansi$(2)+"Enter your NEW Password: "
 uc=1
 tl=ufu(8)
 bt=2
 GOSUB GETLINE
 IF LEN(i$) < ufl(8) THEN
  a$=r$+Ansi$(1)+"System Password change NOT made. (Min len ="
  a$=a$+STR$(ufl(8))+""
  Tout a$
  GOTO MainMenu
 END IF
 ufo$(8)=i$
 Tout r$+Ansi$(16)+"Your NEW Password is "+Ansi$(6)+i$+"."
GOTO MainMenu

DOORMenu:
 ChkTime
 IF koff THEN GOTO LostCD
 CmdTime
 Prompt r$+ct$+"DOOR MENU: "
 pw=4
 e$=bt$(2)
 bt$(2)=bt$(2)+"."
 ts=True
 GOSUB GETLINE
 bt$(2)=e$
 ts=False
 IF b$=CHR$(59) THEN GOSUB SYSCHAT:GOTO DM1
 IF i$="?" OR i$="" THEN fi$="DM":GOSUB OUTFILE:GOTO DM1
 IF i$="M" OR i$="Q" THEN ts=False:GOTO MainMenu
 fi$="DOORS\"+i$+".BAT"
 oops=0
 OPEN fi$ FOR INPUT AS #2:CLOSE #2
 IF oops THEN
  Tout r$+Ansi$(2)+"Sorry, that door is not currently available."
  GOTO DM1
 END IF
 CvtTmr
 it=ton
 GOSUB DOORSys
 SHELL fi$
 SetBaud
 ClrScrn
 CHDIR Cfg$(2)
 ton=ton+it
DM1:
GOTO DOORMenu

DOORSys: 'make DOOR.SYS
 OPEN "DOOR.SYS" FOR OUTPUT AS #2
  CmdTime
  c$=MID$(STR$(ct),2)
  a$="M"
  IF Ansi THEN a$="G"
  b$=MID$(STR$(Port),2)
  IF lm THEN b$="0"
  PRINT#2,nam$r$b$r$Cfg$(14)r$c$r$a$r$"S"r$MID$(STR$(un),2)
 CLOSE #2
RETURN

DispClog:
 Prompt r$+"Caller Log"
 AbortTxt
 Prompt r$+Ansi$(3)+"User Name"+SPACE$(11)+"From"+SPACE$(19)
 Tout "On/Off      Date    Baud  Mins"
 Prompt Ansi$(13)+STRING$(75,ln$)+Ansi$(6)
 fi$="CALLER.LOG"
 GOSUB OUTFILE
GOTO MainMenu

Info:
 Prompt r$+"EBBS-PC "+ve$+", Update: "+up$+" by "+au$+". ID: "+rg$
 fi$="INFO"+ans$
 GOSUB OUTFILE
RETURN

SysopPage:
 PRINT#9,r$SPACE$(22)Ansi$(3)"F1 = CHAT ON - F2 = CHAT OFF"
 Prompt r$+SPACE$(4)+Ansi$(6)+"Paging "+sy$+" - ":PRINT #9,Crsr$;
 StatLine
 IF cb THEN
  FOR i=1 to 10
   Bell
  NEXT i
 END IF
 Tout Ansi$(2)+"Your chat request has been noted, thank you."
 chrq=True
 StatLine
GOTO MainMenu

UsrStats:' Also displays System Stats
 UpdSysStats
 CvtDate
 Tout r$+Ansi$(3)+"Your User Stats: "+SPACE$(24)+_
   Ansi$(6)+da$+" System Stats: "+Ansi$(6)+r$
 a$="From      : "+ufo$(3)+", "+ufo$(4)
 GOSUB Calc41
 Tout Ansi$(3)+a$+Ansi$(6)+stat$(2)+sst$(2)
 FOR i=11 TO 16
  ix=i-8
  a$=uff$(i)+ufo$(i)
  GOSUB Calc41
  a$=Ansi$(3)+a$+Ansi$(6)+stat$(ix)+sst$(ix)
  Tout a$
 NEXT
 UpdTon
 tt=totl+VAL(mn$)
 a$="Time Used :"+STR$(tt)+":"+sec$
 GOSUB Calc41
 Prompt Ansi$(3)+a$
 ix=9
 GOSUB STAT2
 a$="This Call : "+mn$+":"+sec$
 GOSUB Calc41
 Prompt Ansi$(3)+a$
 ix=10
 GOSUB STAT2
 tlim$=STR$(tlim)
 IF lm THEN tlim$=" Disabled"
 a$="Time Limit:"+tlim$
 GOSUB Calc41
 Prompt Ansi$(3)+a$
 CvtTmr
 tut=sst!(11)+(ton/60)
 IF tut > (TIMER/60) THEN tut=TIMER/60:sst!(11)=tut
 hour$="hour"
 IF tut < 60 OR tut > 119 THEN hour$="hrs"
 minute$="mins"
 IF tut MOD 60=1 THEN minute$="min"
 Tout Ansi$(6)+stat$(11)+MID$(STR$(INT(tut\60)),2)+_
   s$+hour$+STR$(tut MOD 60)+s$+minute$
 a$="Time      : "+ti$
 GOSUB Calc41
 tu=(tut/(TIMER/60))*100
 Tout Ansi$(3)+a$+Ansi$(6)+"Useage (%) :"+STR$(tu)+"%"
 a$="Date      : "+da$
 GOSUB Calc41
 Tout Ansi$(3)+a$+Ansi$(6)+stat$(12)+sst$(12)+Ansi$(2)+r$
 IF INSTR(lv1$,"0") THEN Tout "Limited System Access."
 IF INSTR(lv1$,"1") THEN Tout "Message Base Access."
 IF INSTR(lv1$,"2") THEN Tout "Transfer Section Access."
 IF INSTR(lv1$,"9") THEN Tout mblv$(9)+"."
RETURN
STAT2:
 a$=Ansi$(6)+stat$(ix)+MID$(STR$(sst!(ix)),2)
 Tout a$
RETURN
Calc41:'put crsr at pos 41
 ta=(41-len(a$))
 a$=a$+SPACE$(ta)
RETURN

TextMenu:
 ChkTime
 IF koff THEN GOTO LostCD
 CmdTime
 Prompt r$+ct$+"TEXT MENU: "
 ts=True
 pw=4
 e$=bt$(2)
 bt$(2)=bt$(2)+"."
 GOSUB GETLINE
 bt$(2)=e$
 IF b$=CHR$(59) THEN GOSUB SYSCHAT:GOTO TextMenu
 IF i$="?" OR i$="" THEN fi$="TM":GOSUB OUTFILE:GOTO TextMenu
 IF i$="M" OR i$="Q" THEN ts=False:GOTO MainMenu
 Prompt r$+"Read Text File"
 AbortTxt
 fi$=Cfg$(3)+"\"+i$+".TXT"
 GOSUB OUTFILE
GOTO TextMenu

UFDisplay:
 p=1
 ChkTime
 IF koff THEN GOTO LostCD
 Prompt r$+Ansi$(2)+"Enter Match Pattern: "
 ww$="All"
 ac=True
 tl=20
 bt=1
 GOSUB GETLINE
 i$=fnss$(i$)
 IF LEN(i$)=0 THEN GOTO MainMenu
 i$=UCASE$(i$)
 d=0
 Prompt r$+"Userfile Search"
 AbortTxt
 Prompt r$+Ansi$(16)+"Name"+SPACE$(16)+"From"+SPACE$(15)+"Last Call"
 Tout "   Calls   Posts   Reads"
 Tout Ansi$(4)+STRING$(75,ln$)+Ansi$(6)
 OpnUsr
  i=0
UFSE0:
  INCR i
  GET #2,i
  IF EOF(2) THEN GOTO EXUFS
  LINE INPUT #2,na$
  IF LEN(na$) < 5 THEN GOTO UFSE0
  FOR ix=2 TO ub-1
   LINE INPUT #2,ufe$(ix)
  NEXT
  a$=na$+s$+ufe$(3)+s$+ufe$(4)+s$+ufe$(11)
  a$=UCASE$(a$)
  IF i$ <> "ALL" THEN IF INSTR(a$,i$)=0 THEN GOTO UFSE0
  a$=(na$)+s$+(b$)+s$+(c$)
  a$=UCASE$(a$)
  GOSUB PAB
  IF ab THEN GOTO EXUF1
  b$=na$+SPACE$(20-LEN(na$))
  c$=LEFT$(ufe$(3),15)+"/"+ufe$(4)
  c$=c$+SPACE$(18-LEN(c$))
  d$=SPACE$(10-LEN(ufe$(11)))+ufe$(11)
  e$=""
  FOR ix=12 TO 14
   e$=e$+SPACE$(8-LEN(ufe$(ix)))+ufe$(ix)
  NEXT
  a$=b$+c$+d$+e$
  GOSUB LINEOUT
  IF ab THEN GOTO EXUF1
  GOSUB AUTOPAUSE
  IF ab THEN GOTO EXUFS
  INCR d
  GOTO UFSE0
EXUFS:
  Prompt Ansi$(17)+MID$(STR$(d),2,3)+" system user"
  IF d <> 1 THEN Prompt "s"
  Tout "."
EXUF1:
 CLOSE #2
GOTO MainMenu

YStats:
 oops=0
 OPEN "YESTRDAY.LOG" FOR INPUT AS #2
  IF oops=53 THEN
   CLOSE #2
   Tout r$+"Not available."
   GOTO YESTX
  END IF
 FOR ix=1 TO 12
  LINE INPUT #2,Text$(ix)
 NEXT
 CLOSE #2
 Tout r$+"Yesterdays Stats: "+r$
 Tout "Calls    : "+Text$(6)
 Tout "Posts    : "+Text$(7)
 Tout "Reads    : "+Text$(8)
 Tout "Uploads  : "+Text$(9)
 Tout "Downloads: "+Text$(10)
 minutes=VAL(Text$(11))
 Tout "Time Used:"+STR$(INT(minutes\60))+" hrs"+STR$(minutes MOD 60)+" mins"
 tu!=VAL(Text$(11))
 tu!=(tu!/1440)*100
 Tout "Useage   :"+STR$(INT(tu!))+"%"
 Tout "New Users: "+Text$(12)
 ERASE text$
YESTX:
RETURN

'*** SYSOP MENU ***

SysMenu:
 CLOSE #2
 GOTO SYSM1
SYSM0:
 fi$="SM"+ans$
 GOSUB OUTFILE
 IF ab THEN GOTO SYSM1
SYSM1:
 CmdTime
 Prompt r$+ct$+"SYSOP MENU: "
 GOSUB GETKEY
 IF chat THEN GOSUB SYSCHAT:GOTO SysMenu
 SELECT CASE i$
  CASE="?",""
   GOTO SYSM0
  CASE="A"
   GOTO MsgArea
  CASE="B"
   fi$="SYSOP.BUL"
   GOSUB OUTFILE
   GOTO SysMenu
  CASE="D"
   GOSUB Dir
   GOTO SysMenu
  CASE="E"
   fi$="ERROR.LOG"
   GOSUB OUTFILE
   GOTO SysMenu
  CASE="F"
   Tout r$+"Free Memory: "+LTRIM$(USING$("#######,",FRE(-1)))
   ! MOV AH, &H36
   ! MOV DL, &H0
   ! INT &H21
   ! MOV a??, AX
   ! MOV b??, BX
   ! MOV c??, CX
   d&=(a?? * c??) * b??
   Tout "Free Space : "+LTRIM$(USING$("###############,",d&))
   GOTO SysMenu
  CASE="G"
   GOTO Logoff
  CASE="L"
   GOTO LoadFile
  CASE="M"
   IF un<2 THEN
    an=un
    un=0
    GOSUB ReadMail
    un=an
    GOTO SysMenu
   END IF
  CASE="N"
   GOTO NuUsrLog
  CASE="R"
   GOTO ReadFile
  CASE="S"
   IF un<2 THEN GOTO DOSShell
  CASE="U"
   IF un<2 THEN i=0
   GOSUB UFEDITOR
   GOTO SysMenu
  CASE="X"
   GOTO XferMenu
  CASE="W"
   GOTO WriteFile
  CASE="Z"
   i=0
   GOTO XFEditor
  CASE="^","Q"
   GOTO MainMenu
  CASE="/"
   Prompt Ansi$(7)+r$+"Press key to scan: "+Crsr$
   DO
   k$=INKEY$
   IF Port > 0 THEN
    IF NOT EOF(1) THEN
     WHILE LOC(1) > 0
      DELAY .1
      k$=k$+INPUT$(LOC(1),1)
     WEND
    END IF
   END IF
   LOOP WHILE LEN(k$)=0
   Prompt ""
   FOR i=1 TO LEN(k$)
    a=ASCII(MID$(k$,i,1))
    Prompt STR$(a)
   NEXT i
   Tout ""
   GOTO SysMenu
  CASE ELSE
   BadCmd
 END SELECT
GOTO SysMenu

'*** SYSOP ROUTINES ***

NuUsrLog:
 Prompt r$+Ansi$(3)+"Newuser Name"+SPACE$(9)+"City/State"+_
   SPACE$(14)+"Date"+SPACE$(7)+"Time"+r$+Ansi$(13)+STRING$(75,ln$)
 fi$="NEWUSER.LOG"
 GOSUB OUTFILE
GOTO SysMenu

LoadFile:
 ww$=fi$
 Prompt r$+Ansi$(2)+"Load file: "
 uc=True
 GOSUB GETLINE
 IF i$="" OR i$ < CHR$(33) THEN GOTO SysMenu
 fi$=i$
 fi$=UCASE$(fi$)
 oops=0
 OPEN fi$ FOR INPUT AS #2
  IF oops=53 THEN
   CLOSE #2
   Tout Ansi$(1)+r$+q$+fi$+q$+" file not found."
   GOTO SysMenu
  END IF
  Prompt r$+Ansi$(5)+"Loading "+q$+fi$+q$+" file into editor: "
  ERASE text$
  l=1
  file$=fi$
  WHILE NOT EOF(2) AND l<251
   LINE INPUT #2,a$
   IF a$="" THEN a$=s$
   Text$(l)=LEFT$(a$,75)
   INCR l
  WEND
 CLOSE #2
 Tout Ansi$(3)+STR$(l-1)+" lines loaded."
 ll=250
 GOSUB EI2
 fi$=file$
 IF ab% THEN ERASE text$:GOTO SysMenu
GOTO WTF1

ReadFile:
 Prompt r$+Ansi$(2)+"Read File: "
 GOSUB GETLINE:l=0
 IF LEN(i$)=0 THEN GOTO SysMenu
 fi$=(i$)
 fi$=UCASE$(fi$)
 Prompt r$+"Read File Mode"
 AbortTxt
 GOSUB OUTFILE
GOTO SysMenu

Dir:
 ww$=fi$
 if fi$="" then ww$="*.*"
 Prompt r$+Ansi$(2)+"Enter filespec: "
 uc=True
 tl=25
 GOSUB GETLINE
 IF LEN(i$)=0 THEN RETURN
 PRINT#9,Esc$"1A"Esc$"s";
 a$="DIR"
 IF Ansi THEN a$="DR"
 SHELL a$+s$+i$+" > TEMP"
 PRINT#9,Esc$"u";
 fi$="TEMP"
 GOSUB OUTFILE
 KILL "TEMP"
 StatLine
 fi$=i$
RETURN

DOSShell: 'DOS psuedo shell
 Tout r$+Ansi$(1)+"DOS Psuedo Shell - Use EXTREME caution with this command."
 Prompt r$+Ansi$(3)+CURDIR$+">"
 tl=60
 GOSUB Getline
 IF LEN(i$)<1 OR UCASE$(i$)="EXIT" THEN GOTO SysMenu
 IF INSTR("RD REMCD CHDFORFDIDELERADEBDISSUBSETMODLABUNDBACRESREPSYSREN",LEFT$(i$,3)) THEN
  Tout r$+Ansi$(2)+"That DOS command is not allowed here."
  GOTO DOSShell
 END IF
 PRINT#9,Esc$"1A"Esc$"s";
 ShellString$=i$
 SHELL i$+" > TEMP"
 PRINT#9,Esc$"u";
 fi$="TEMP"
 GOSUB Outfile
 KILL "TEMP"
GOTO DOSShell

WriteFile:
 Prompt r$+Ansi$(2)+"Write File: "
 GOSUB GETLINE
 fi$=i$
 l=0
 IF LEN(i$)=0 THEN GOTO SysMenu
 ll$="250"
 tc$=fi$
 su$="Write File Mode"
 GOSUB EdInp
 IF ab% THEN GOTO SysMenu
WTF1:
 Prompt r$+Ansi$(3)+"Do you want to add a date/time header"+ny$
 gyn=False
 GOSUB GETYNA
 Prompt r$+Ansi$(7)+"Saving "+q$+fi$+q$+"... "
 OPEN fi$ FOR OUTPUT AS #2
  l=1
  IF no OR abort THEN GOTO WTF2
  CvtDate
  a$=da$+" - "+ti$
  PRINT #2,SPACE$(25)a$
  a$=STRING$(LEN(a$),"-")
  PRINT #2,SPACE$(25)a$
WTF2:
  WHILE Text$(l) <> "" AND l < ll+1
   PRINT #2,Text$(l)
   INCR l
  WEND
 CLOSE #2
 ERASE text$
 Tout Ansi$(5)+"Saved."
GOTO SysMenu

'*** MSG BASE ROUTINES ***

MsgArea:
 CLOSE #2
 cm=False
 rnew=False
 rall=False
 IF mb=0 THEN mb=1
 GOTO MBM1
MBM0:
 fi$="MBM"+ans$
 GOSUB Outfile
MBM1:
 xbase=False
 ChkTime
 IF koff THEN GOTO LostCD
 CmdTime
 Prompt r$+ct$+mb$(mb)+" ["+CHR$(mb+64)+"]: "
 nx=0
 rnew=0
 GOSUB GETKEY
 IF chat THEN GOSUB SYSCHAT:GOTO MsgArea
 SELECT CASE i$
  CASE="?",""
   ClrBufs
   GOTO MBM0
  CASE="+"
   GOTO IncBase
  CASE="-"
   GOTO DecBase
  CASE="A"
   rnew=True
   rall=True
   GOTO ReadMsgs
  CASE="C"
   rnew=True
   pt%=False
   cm=True
   GOTO ReadMsgs
  CASE="F","R"
   GOTO ReadMsgs
  CASE="G"
   GOTO Logoff
  CASE="H"
   fi$="MBH"
   GOSUB OUTFILE
   GOTO MsgArea
  CASE="M","Q"
   GOTO MainMenu
  CASE="N"
   rnew=True
   GOTO ReadMsgs
  CASE="P"
   IF pl < 1 THEN
    Tout r$+"Post Limit Exceeded for this call."
    GOTO MsgArea
   END IF
   GOSUB PostMsg
   GOTO MsgArea
  CASE="S"
   GOTO SetBase
  CASE="X"
   IF INSTR(lv1$,"2") THEN GOTO XferMenu
  CASE="^"
   IF INSTR(lv1$,"9") THEN GOTO SysMenu
  CASE ELSE
   BadCmd
 END SELECT
GOTO MsgArea

PostMsg:
 path$=".\MSGS\MB"+CHR$(64+mb)
 GOSUB InitHdr
 Tout r$+Ansi$(3)+"Post "+mb$(mb)+mg$+_
   " - "+Ansi$(1)+"(System timer is halted while posting)"+r$
 Prompt hdr$(1)
 ww$="All"
 ac=True
 tl=25
 bt=1
 GOSUB GETLINE
 IF LEN(i$)=0 THEN RETURN
 tc$=i$
 su$="Commentary"
 Tout hdr$(2)+nam$
PostReply:' Jump here for reply
 GOSUB InitHdr
 IF tc$=nam$ THEN tc$="All"
 IF reply THEN
  Tout r$+mb$(mb)+mg$+r2$+hdr$(1)+tc$+r$+hdr$(2)+nam$
  d$=MID$(STR$(ms),2)
 END IF
 ww$=su$
 tl=38
 ac=True
 Prompt hdr$(3)
 GOSUB GETLINE
 IF LEN(i$) < 2 THEN RETURN
 su$=i$
 IF reply THEN
  IF LEN(d$) < 5 THEN d$=STRING$(5-LEN(d$),"0")+d$
  c$=" (Reference is "+d$+")"
 END IF
 CvtDate
 Tout hdr$(4)+da$+" @ "+ti$
POST0:
 Prompt ok$
 gyn=True
 GOSUB GETYNA
 IF no AND reply THEN GOTO PostReply
 IF no THEN GOTO PostMsg
 IF abort THEN RETURN
 IF reply THEN su$=su$+c$
POST1:
 CvtTmr
 itx=ton
 GOSUB EdInp
 IF ab THEN RETURN
 Prompt r$+Ansi$(2)+"Saving"+mg$+"... "
 INCR hi
IND1:
 oops=0
 OPEN "INDEX.MSB" FOR INPUT AS #2
  IF oops=53 THEN CLOSE #2:GOSUB InitIndex:GOTO IND1
  FOR i=1 TO 26
   INPUT #2,ix(i)
  NEXT
  INCR ix(mb)
 CLOSE #2
 OPEN "INDEX.MSB" FOR OUTPUT AS #2
  FOR i=1 TO 26
   PRINT #2,ix(i)
  NEXT
 CLOSE #2
 msg$=MID$(STR$(ix(mb)),2)
MBD1:
 oops=0
 ERASE Ansi$
 GOSUB InitHdr
 OPEN path$+"\MSG"+RIGHT$("0000"+msg$,5) FOR OUTPUT AS #2
  PRINT #2,r$hdr$(1)tc$r$hdr$(2)nam$r$hdr$(3)su$r$hdr$(4)da$" @ "ti$r$s$
  l=1
  WHILE Text$(l) <> ""
   PRINT #2,Text$(l)
   INCR l
  WEND
  PRINT #2,r$; nam$" from "ufo$(3) ", "ufo$(4)" - Replies: ";
 CLOSE #2
 IF reply THEN
  oops=0
  OPEN mesg$ FOR APPEND AS #2
   IF oops=53 THEN GOTO POST2
   PRINT #2,"#"; msg$; s$;
 END IF
POST2:
  CLOSE #2
 GOSUB InitAnsi
 Tout Ansi$(5)+" Message "+msg$+" saved."
 LmtChg
 ERASE text$
 INCR sst!(7)
 sf=ix(mb)-mbc
 IF sf < 1 THEN sf=0
 msg$=MID$(STR$(sf),2)
 c=VAL(ufo$(13))+1
 ufo$(13)=MID$(STR$(c),2)
 a$=path$+"\MSG"+RIGHT$("0000"+msg$,5)+"*"
 KILL a$
 DECR pl
 IF pl - VAL(mb$(28)) MOD 3 THEN ratio=ratio * 2
RETURN

InitIndex:
 OPEN "INDEX.MSB" FOR OUTPUT AS #2
  FOR i=1 TO 26
   PRINT #2,0
  NEXT
 CLOSE #2
RETURN

ReadMsgs:
 ma=True
 path$=".\MSGS\MB"+CHR$(64+mb)
 IF rnew THEN
   Tout r$+Ansi$(6)+"Checking for NEW "+mb$(mb)+" messages... "
 END IF
 IF NOT rnew then Tout r$+Ansi$(7)+"Forward"+mg$+" Read Mode"+r$
 ClrBufs
 CLOSE #2
RM6:
 oops=0
 OPEN "INDEX.MSB" FOR INPUT AS #2
  IF oops=53 THEN
   CLOSE #2
   GOSUB InitIndex
   GOTO RM6
  END IF
 FOR i=1 TO 26
  INPUT #2,ix(i)
 NEXT
 CLOSE #2
 hi=ix(mb)
 lo=(hi-mbc)+1
 IF lo < 1 THEN lo=1
 IF NOT rnew THEN GOTO RM0
 IF hmsg(mb)>hi THEN hmsg(mb)=lo
 ms=hmsg(mb)+1
 ns=hi-hmsg(mb)
 IF ns > mbc THEN ns=mbc
 IF ns < 1 THEN
  Tout r$+Ansi$(1)+"No NEW "+mb$(mb)+" messages... "
  IF NOT rall THEN GOTO MsgArea
  GOTO NextBase
 END IF
 Prompt r$+Ansi$(17)+MID$(STR$(ns),2)+" NEW "+mb$(mb)+" message"
 a$=": "
 IF ns <> 1 THEN a$="s: "
 Tout a$
 GOTO RM1
RM0:
 IF lo=0 THEN Tout Ansi$(2)+"No messages.":GOTO MsgArea
 Tout Ansi$(6)+"Low"+mg$+" # is"+STR$(lo)+_
   " - High"+mg$+" # is"+STR$(hi)
 IF hmsg(mb) < lo THEN hmsg(mb)=lo
 ww$=MID$(STR$(hmsg(mb)),2)
 Prompt r$+Ansi$(3)+"Start at"+mg$+" #: "
 bt=2
 tl=5
 uc=1
 GOSUB GETLINE
 NumOnly
 IF abort THEN i$="0"
 ms=VAL(LEFT$(i$,4))
 IF ms=0 THEN GOTO MsgArea
RM1:
 IF ms > hi THEN
  Tout r$+Ansi$(2)+"End of "+mb$(mb)+" messages."
  IF NOT rall THEN GOTO MsgArea
  GOTO NextBase
 END IF
 IF ms < lo AND pr% THEN pr%=False
 IF ms < lo THEN ms=lo
RM5:
 thr=False
 msg$=MID$(STR$(ms),2)
 mesg$=path$+"\MSG"+RIGHT$("0000"+msg$,5)
 oops=0
 OPEN mesg$ FOR INPUT AS #2
  a=oops
  CheckCD
  IF dcd=0 THEN GOTO LostCD
  IF ms > hmsg(mb) THEN hmsg(mb)=ms
  IF pr% AND a > 0 THEN
   CLOSE #2
   DECR ms
   GOTO RM1
  END IF
  pr%=0
  IF a THEN CLOSE #2:GOTO RM2
  Tout r$+Ansi$(5)+mb$(mb)+" Message #"+STR$(ms)+" of"+STR$(hi)+Ansi$(3)
  ClrBufs
  nx=1
  p=4
  WHILE NOT EOF(2) AND INSTR(a$,"From")=0
   LINE INPUT #2,a$
   Tout a$
  WEND
  sn$=MID$(a$,7)
  fr$=sn$
  ab=0
  nm=0
  LINE INPUT #2,a$
  Tout a$
  ref=VAL(RIGHT$(a$,6))
  b$=MID$(a$,7)
  c=INSTR(b$," ("):if c then DECR c
  IF c=0 THEN c=LEN(b$)
  su$=LEFT$(b$,c)
  WHILE NOT EOF(2) AND ab=0 AND nm=0
   LINE INPUT #2,a$
   GOSUB LINEOUT
   Prompt Ansi$(6)
   GOSUB AUTOPAUSE
  WEND
 CLOSE #2
 IF POS(0) > 1 THEN Tout ""
 thr=INSTR(a$,"#")
 IF thr THEN thr$=RIGHT$(a$,LEN(a$)-thr)
 IF nm AND rref THEN i$="N":GOTO RM7
 IF nm OR (cm AND ab=0) THEN GOTO RM2
RM4:
 p=0
 nx=0
 ClrBufs
 CmdTime
 ChkTime
 IF koff THEN GOTO HANGUP
 Prompt r$+ct$+"MESSAGE READ: "
 GOSUB GETKEY
 IF chat THEN GOSUB SYSCHAT:GOTO RM4
 IF i$="?" THEN
  fi$="MRM"+ans$
  GOSUB OUTFILE
  GOTO RM4
 END IF
RM7:
 SELECT CASE i$
 CASE="N",""
  IF rref THEN
   Tout r$+"Resuming Normal Read"
   ms=resmsg
   rref=False
   GOTO RM5
  END IF
  Tout r$+"Next"+mg$
  c=VAL(ufo$(14))+1
  ufo$(14)=MID$(STR$(c),2)
  GOTO RM2
 CASE="A"
  CLOSE #2
  GOTO MsgArea
 CASE="C"
  cm=ABS(cm-1)
  pt%=False
  Tout r$+rc$(cm)
  GOTO RM4
 CASE="D"
  IF INSTR(lv1$,"9") OR nam$=LEFT$(fr$,LEN(nam$)) THEN GOSUB DelMsg:GOTO RM4
 CASE="E"
  Tout r$+"Private Reply by Mail"
  em=1
  GOSUB SendMail
  em=0
  GOTO RM4
 CASE="H"
  fi$="MBH"
  GOSUB OUTFILE
  GOTO RM4
 CASE="I"
  Prompt r$+"Read"+mg$+" # ("+MID$(STR$(lo),2)+"-"+MID$(STR$(hi),2)+"): "
  GOSUB GETLINE
  NumOnly
  IF abort THEN GOTO RM4
  ms=VAL(LEFT$(i$,4))
  GOTO RM1
 CASE="M","Q"
  CLOSE #2
  GOTO MainMenu
 CASE="O"
  Tout r$+"Read"+mg$+" Over"
  GOTO RM5
 CASE="P"
  Tout r$+"Previous"+mg$
  pr%=1
  DECR ms
  GOTO RM1
 CASE="G"
  GOTO Logoff
 CASE="R"
  IF pl < 1 THEN
   Tout r$+"Post Limit exceeded for this call."
   GOTO RM4
  END IF
  Tout r$+"Post Public Reply"
  tc$=sn$
  reply=True
  GOSUB PostReply
  reply=False
  GOTO RM2
 CASE="T"
  IF thr THEN GOSUB ReadThrd:GOTO RM4
 CASE="V"
  GOSUB MvMsg:GOTO RM4
 CASE="*"
  pt%=ABS(pt%-1)
  Tout r$+pt$(pt%)
  GOTO RM4
 CASE="#"
  IF ref > lo THEN
   Tout r$+"Read Reference"
   IF rref=0 THEN resmsg=ms
   rref=True
   ms=ref
   GOTO RM5
  END IF
  IF ref < lo THEN
   TOUT Ansi$(1)+r$+"Sorry, the reference message has already been deleted."
  END IF
  GOTO RM4
 CASE ELSE
  BadCmd
  ClrBufs
 END SELECT
 GOTO RM4
RM2:
 CLOSE #2
 INCR sst!(8)
 CheckCD
 IF dcd=0 THEN GOTO LostCD
 INCR ms
GOTO RM1

NextBase:' Figure users next available base
 IF (INSTR(lv1$,CHR$(mb+64))) AND (mb$(mb) <> "NA") THEN
  Prompt r$+Ansi$(2)+"Post a "+mb$(mb)+" message "+Ansi$(2)+"(N/y/abort)? "
  gyn=False
  GOSUB GETYNA
  IF yes THEN GOSUB PostMsg
 END IF
 IF abort THEN GOTO MsgArea
 INCR mb
 IF mb > 26 THEN
   mb=lb
   Tout r$+Ansi$(5)+"That's all of em!"
   GOTO MsgArea
 END IF
 IF (INSTR(lv1$,CHR$(mb+64))=0) OR (mb$(mb)="NA") THEN GOTO NextBase
 lb=mb
GOTO ReadMsgs

ReadThrd: 'Displays message reply thread
 oops=0
 tmsg$=LEFT$(thr$,INSTR(thr$,s$)-1)
 Prompt r$+"Read thread - Message # "+tmsg$
 tms$=Cfg$(4)+hd$(mb)+"\MB"+CHR$(64+mb)+"\MSG"+STRING$(5-LEN(tmsg$),"0")+tmsg$
 fi$=tms$
 GOSUB OUTFILE
 thr=INSTR(thr$,"#")
 IF thr=0 THEN GOTO RETH1
 Prompt r$+Ansi$(3)+"Read next message in thread"+yn$
 gyn=True
 GOSUB GETYNA
 IF no OR abort THEN RETURN
 thr$=RIGHT$(thr$,LEN(thr$)-thr)
 GOTO ReadThrd
RETH1:
 Prompt r$+Ansi$(3)+"End of thread. Add a reply"+ny$
 gyn=False
 GOSUB GETYNA
 IF no OR abort THEN RETURN
 tc$=sn$
 reply=True
 GOSUB PostReply
 reply=False
RETURN

DelMsg:' Delete message
 Prompt r$+Ansi$(3)+"Delete this"+mg$+ny$
 gyn=False
 GOSUB GETYNA
 IF no OR abort THEN RETURN
 KILL mesg$
 Tout r$+Ansi$(1)+"Message deleted."
RETURN

MvMsg:' Allows Sysops to move msg to another base
 IF INSTR(lv1$,"9")=0 THEN RETURN 'Sysop's only
 Prompt r$+Ansi$(7)+"Move to which base: "
 GOSUB GETKEY
 IF i$="" THEN RETURN
 Tout ""
 IF i$ < "A" OR i$ > "Z" THEN
  'display choices
  FOR i=1 to 26
   IF mb$(i) <> "NA" THEN
    Prompt SPACE$(s)+Ansi$(3)+"["+CHR$(64+i)+"]"+s$+mb$(i)
    IF s=0 THEN s=30-LEN(mb$(i)) ELSE Tout "":s=0
   END IF
  NEXT
  GOTO MvMsg
 END IF
 i=ASC(i$)-64
 IF mb$(i)="NA" THEN
  Tout r$+Ansi$(2)+"Invalid message base."
  GOTO MvMsg
 END IF
 tmb=i
 Prompt Ansi$(3)+_
  "Move this message to the "+mb$(tmb)+" message base"+yn$
 gyn=True
 GOSUB GETYNA
 IF no OR abort THEN RETURN
 OPEN Cfg$(2)+"\INDEX.MSB" FOR INPUT AS #2
  IF oops=53 THEN CLOSE #2:RETURN
  FOR i=1 TO 26
   INPUT #2,ix(i)
  NEXT
  ix(tmb)=ix(tmb)+1
 CLOSE #2
 OPEN Cfg$(2)+"\INDEX.MSB" FOR OUTPUT AS #2
  FOR i=1 TO 26
   PRINT #2,ix(i)
  NEXT
 CLOSE #2
 tmsg$=LTRIM$(STR$(ix(tmb)))
 tms$=Cfg$(4)+hd$(tmb)+"\MB"+CHR$(tmb+64)+"\MSG"+RIGHT$("0000"+tmsg$,5)
 NAME mesg$ AS tms$
 CvtDate
 Tout r$+Ansi$(5)+"Message move complete."
RETURN

SetBase:
 Prompt r$+Ansi$(2)+"Select Message Section: "
 GOSUB GETKEY
 IF i$="?" OR i$="" THEN GOTO MBS1
 IF (INSTR(lv1$,i$)=0) OR (mb$(ASC(i$)-64)="NA") THEN i$=""
 IF i$=>"A" AND i$=<"Z" THEN mb=ASC(i$)-64:GOTO MsgArea
 BadCmd
 GOTO SetBase
MBS1:
 Tout "":s=0
 FOR i=1 to 26
  IF INSTR(lv1$,CHR$(64+i)) AND mb$(i) <> "NA" THEN
    Prompt SPACE$(s)+Ansi$(3)+"["+CHR$(64+i)+"]"+s$+mb$(i)
    IF s=0 THEN s=30-LEN(mb$(i)) ELSE Tout "":s=0
  END IF
 NEXT
 IF s THEN Tout ""
GOTO SetBase

IncBase:
 IF mb=26 THEN GOTO MsgArea
 FOR x=(mb+1) TO 26
  IF (INSTR(lv1$,CHR$(x+64))) AND (mb$(x)<>"NA") THEN mb=x:EXIT FOR
 NEXT
GOTO MsgArea

DecBase:
 IF mb=1 THEN GOTO MsgArea
 FOR x=(mb-1) to 1 STEP - 1
  IF (INSTR(lv1$,CHR$(x+64))) AND (mb$(x)<>"NA") THEN mb=x:EXIT FOR
 NEXT
GOTO MsgArea

'*** EMAIL ROUTINES ***

SendMail:
 GOSUB InitHdr
 IF (INSTR(lv1$,"5")=0) AND (sn$ <> sy$) THEN LoLvl:RETURN
 IF sn$=sy$ THEN sn=0:GOTO SE0
 pattern=False
 IF em THEN GOTO SE3
 Prompt r$+Ansi$(3)+"Send Email to: "
 bt=1
 tl=25
 ac=True
 GOSUB GETLINE
 IF LEN(i$)=0 THEN RETURN
 sn$=fnss$(i$)
 IF LEFT$(i$,LEN(i$))=LEFT$(sy$,LEN(i$)) OR i$="Sysop" THEN
  sn$=sy$
  GOTO SendMail
 END IF
SE3:
 unam$=sn$
 SrchKey
 IF i=0 THEN Tout r$+Ansi$(1)+sn$+" not in system userfile.":RETURN
 OpnUsr
  GET #2,i
  LINE INPUT #2,na$
  pattern=False
  IF LEN(sn$) <> LEN(na$) THEN pattern=True
 CLOSE #2
 sn=i
 sn$=na$
 IF pattern THEN
  Prompt r$+Ansi$(6)+"Send EMAIL to "+sn$+yn$
  gyn=True
  GOSUB GETYNA
  IF no OR abort THEN GOTO SendMail
 END IF
SE0:
 Prompt r$+Ansi$(6)+"Checking "+sn$+"'s mailbox... "
 GOSUB CntEml
 Tout ""
SE1:
 Prompt r$+hdr$(1)+sn$+r$+hdr$(2)+nam$+r$+hdr$(3)
 ww$="Chit Chat"
 IF em THEN ww$=su$
 IF sn=0 AND em=0 AND ww$="" THEN ww$="Feedback"
 cl=0
 ac=True
 tl=38
 GOSUB GETLINE
 IF LEN(i$) < 2 THEN RETURN
 su$=i$
 CvtDate
 Tout hdr$(4)+da$+" @ "+ti$
SE2:
 Prompt ok$
 gyn=True
 GOSUB GETYNA
 IF no THEN GOTO SE1
 IF abort THEN RETURN
 tc$=sn$
 GOSUB EdInp
 IF ab% THEN RETURN
 a$="Sending Email"
 IF sn$=sy$ THEN a$="Sending Feedback"
 Prompt r$+a$+"... "
 oops=0
 a$=MID$(STR$(zm+1),2)
 b$=MID$(STR$(sn),2)
 b$=STRING$(4-LEN(b$),"0")+b$
 ERASE Ansi$
 GOSUB InitHdr
 OPEN Cfg$(5)+"\"+b$+"."+STRING$(3-LEN(a$),"0")+a$ FOR OUTPUT AS #2
  PRINT #2,hdr$(1)sn$r$hdr$(2)nam$r$hdr$(3)su$r$hdr$(4)da$" @ "ti$r$s$
  l=1
  WHILE Text$(l) <> ""
   PRINT #2,Text$(l)
   INCR l
  WEND
  PRINT #2,s$r$nam$" from "ufo$(3)", "ufo$(4)
 CLOSE #2
 a$="Email sent."
 IF sn$=sy$ THEN a$="Feedback sent."
 ERASE text$
 GOSUB InitAnsi
 Tout Ansi$(6)+a$
RETURN

ReadMail:
 Prompt r$+Ansi$(6)+"Checking for Email... "
 sn=un
 GOSUB CntEml
 e=0
 IF zm=0 THEN
  Tout r2$+Ansi$(1)+"Sorry, no Email this time."
  CLOSE #2
  RETURN
 END IF
 a$=" pieces"
 IF zm=1 THEN a$=" piece"
 IF zm > 0 THEN
  Tout r2$+Ansi$(3)+"You have "+MID$(STR$(zm),2)+a$+" of email."
  Prompt r$+Ansi$(2)+"Press RETURN: "
  ema=zm
  GOSUB GETKEY
 END IF
RE0:
 p=3
 INCR e
 CLOSE #2
 a$=MID$(STR$(e),2)
 oops=0
 b$=MID$(STR$(un),2)
 b$=STRING$(4-LEN(b$),"0")+b$
 email$=Cfg$(5)+"\"+b$+"."+STRING$(3-LEN(a$),"0")+a$
 OPEN email$ FOR INPUT AS #2
  IF oops=53 AND e > 1 THEN
   Prompt r$+Ansi$(2)+"No more Email - Okay to clear your mailbox (N/y)? "
   CLOSE #2
   gyn=False
   GOSUB GETYNA
   IF yes THEN GOSUB KillMail
   RETURN
  END IF
  Tout r$+Ansi$(5)+"Email #"+STR$(e)+" of"+STR$(ema)+r$+Ansi$(3):a$=""
  WHILE NOT EOF(2) AND INSTR(a$,"From")=0
   LINE INPUT #2,a$
   Tout a$
  WEND
  ab=0
  sn$=MID$(a$,7)
  WHILE NOT EOF(2) AND ab=0
   LINE INPUT #2,a$
   IF INSTR(a$,"Date") THEN a$=a$+Ansi$(6)
   GOSUB LINEOUT
   IF INSTR(a$,"Subj") THEN su$=MID$(a$,7)
   GOSUB AUTOPAUSE
  WEND
 CLOSE #2
RE1:
 CmdTime
 Prompt r$+ct$+"EMAIL: "
 GOSUB GETKEY
 IF chat THEN GOSUB SYSCHAT:GOTO RE1
 SELECT CASE i$
 CASE="?"
  fi$="EMM"+ans$
  GOSUB OUTFILE
  GOTO RE1
 CASE="A"
  RETURN
 CASE="N",""
  Tout r$+"Read Next Letter"
  GOTO RE0
 CASE="P"
  IF e > 1 THEN
   Tout r$+"Read Previous Letter"
   e=e-2
   GOTO RE0
  END IF
  IF e=1 THEN
   Tout r$+"Read Last Letter"
   e=ema-1
   GOTO RE0
  END IF
 CASE="R"
  Tout r$+"Reply to Mail"
   em=True
   GOSUB SendMail
   em=False
   GOTO RE0
  CASE="V","O"
   Tout r$+"Read Letter Over"
   DECR e
   GOTO RE0
  CASE ELSE
   BadCmd
   ClrBufs
   GOTO RE1
  END SELECT

CntEml:
 zm=0
 oops=0
 DO WHILE oops <> 53
  CLOSE #2
  a$=MID$(STR$(zm+1),2)
  b$=MID$(STR$(sn),2)
  b$=STRING$(4-LEN(b$),"0")+b$
  OPEN Cfg$(5)+"\"+b$+"."+STRING$(3-LEN(a$),"0")+a$ FOR INPUT AS #2
   IF oops=53 THEN EXIT DO
   INCR zm
 LOOP
  CLOSE #2
RETURN

KillMail: 'Delete Email
 Tout r$+Ansi$(2)+"Email deleted."
 b$=MID$(STR$(un),2):b$=STRING$(4-LEN(b$),"0")+b$
 KILL Cfg$(5)+"\"+b$+".*"
RETURN

'*** EDITOR ROUTINES ***

EdInp:
 Prompt Ansi$(3)+r$+"ANSI Screen Editor "+Ansi$(2)+"(N/y)? "
 gyn=False
 GOSUB GETYNA
 IF yes THEN GOSUB ScreenEditor:uc=0:cl=uc:RETURN
 IF lm OR INSTR(lv1$,"6") THEN ll$="250"
 a$=r$+ll$+" line input limit. Press (RETURN) alone on a line to end."+r$
 a$=a$+"Word wrap will occur automatically at the end of each line."+r$
 Tout Ansi$(3)+a$
 ll=VAL(ll$)
 l=0
 cl=l
 uc=l
EI0:
 INCR l
 Prompt Ansi$(5)+MID$(STR$(l),2)+SPACE$(4-LEN(STR$(l)))+": "
 GOSUB GETLINE
 Text$(l)=i$
 IF LEN(i$)=0 THEN GOTO EI2
 IF l=ll-10 THEN Tout Ansi$(1)+"--- 10 Lines Remaining ---"
EI1:
 IF l=ll THEN
  Tout Ansi$(1)+"--- No More Room ---"
  l=ll+1
  GOTO EI2
 END IF
 GOTO EI0
EI2:
 GOSUB EDITOR
 IF co THEN GOTO EI1
RETURN

EDITOR:
 GOTO ED1
ED0:
 temp$=fi$
 fi$="EDM"+ans$
 GOSUB OUTFILE
 fi$=temp$
ED1:
 CmdTime
 nx=0
 Prompt r$+ct$+"LINE EDITOR: "
 GOSUB GETKEY
 co=0
 ab%=0
 IF chat THEN GOSUB SYSCHAT:GOTO EDITOR
 SELECT CASE i$
 CASE="?",""
  GOTO ED0
 CASE="A"
  GOTO AbortEdit
 CASE="C"
  DECR l
  co=1
  RETURN
 CASE="D"
  GOTO DelLines
 CASE="E"
  GOTO EditLine
 CASE="I"
  GOTO InsLines
 CASE="L"
  GOTO ListLines
 CASE="O"
  IF reply THEN
   fi$=mesg$
   GOSUB OUTFILE
   GOTO EDITOR
  END IF
  IF em THEN
   fi$=email$
   Tout ""
   GOSUB OUTFILE
   GOTO EDITOR
  END IF
 CASE="P"
  GOTO PrevTxt
 CASE="R"
  GOTO RewrLine
 CASE="S"
  RETURN
 CASE ELSE
  BadCmd
 END SELECT
GOTO EDITOR

AbortEdit:
 Prompt r$+Ansi$(1)+"Abort"+ny$
 gyn=False
 GOSUB GETYNA
 IF yes THEN
  ab%=1
  ERASE text$
  RETURN
 END IF
GOTO EDITOR

DelLines:
 Prompt r$+Ansi$(2)+"Delete from line: "
 uc=1
 bt=1
 tl=3
 GOSUB GETLINE
 GOSUB EdTrap
 IF abort THEN GOTO EXDEL
 a=i
 Prompt Ansi$(2)+"  Delete to line: "
 uc=1
 bt=1
 tl=3
 GOSUB GETLINE
 GOSUB EdTrap
 IF abort THEN GOTO EXDEL
 b=i
 IF a > b THEN GOTO EXDEL
 d=(b-a)+1
 i=a
 Tout ""
 IF d > 1 THEN Prompt Ansi$(3)+"DELETE lines"+STR$(a)+" through"+STR$(b)+yn$
 IF d=1 THEN Prompt Ansi$(3)+"DELETE line"+STR$(a)+yn$
 gyn=True
 GOSUB GETYNA
 IF no OR abort THEN GOTO EXDEL
 WHILE Text$(i) <> ""
  Text$(i)=Text$(i+d)
  INCR i
 WEND
 Prompt r$+Ansi$(1)+MID$(STR$(d),2)+" line"
 IF d > 1 THEN Prompt "s"
 Tout " deleted."
 l=l-d
EXDEL:
GOTO EDITOR

EditLine:
 Tout r$+Ansi$(6)+"Line Edit (search & replace on one line only)"
 Prompt r$+Ansi$(2)+"Enter line # to Edit: "
 tl=3
 bt=1
 uc=1
 GOSUB GETLINE
 GOSUB EdTrap
 IF abort THEN GOTO EDITOR
EDL1:
 a$=MID$(STR$(i),2)
 a$=a$+SPACE$(3-LEN(a$))+": "
 Prompt r$+Ansi$(5)+a$+Ansi$(6)+Text$(i)+r2$+Ansi$(2)+"Enter Search text : "
 tl=40
 GOSUB GETLINE
 c$=i$
 IF LEN(i$)=0 THEN GOTO EDITOR
 st=INSTR(Text$(i),c$)
 IF st=0 THEN Tout r$+Ansi$(1)+"Search text not found!":GOTO EDL1
 Prompt Ansi$(2)+"Enter Replace text: "
 tl=40
 GOSUB GETLINE
 d$=i$
 rt=LEN(d$)
 IF rt=0 THEN GOTO EDITOR
 a$=Text$(i)
 b$=LEFT$(a$,st-1)+d$+MID$(a$,st+LEN(c$))
 Text$(i)=LEFT$(b$,75)
GOTO EDL1

EdTrap:' Trap and handle all editor crash attempts
 NumOnly
 IF LEN(i$)=0 THEN abort=1
 IF abort THEN RETURN
 i=ABS(INT(VAL(LEFT$(i$,3))))
 IF i < 1 OR i > ll THEN abort=1
 IF Text$(i)="" THEN abort=1
RETURN

InsLines:
 Prompt r$+Ansi$(2)+"INSERT line(s) BEFORE line #: "
 tl=3
 bt=1
 uc=1
 GOSUB GETLINE
 GOSUB EdTrap
 IF abort THEN GOTO EDITOR
 j=i
 IF Text$(ll) > "" THEN GOTO EDITOR
 Tout r$+Text$(i-1)+r2$+Text$(i)+r$
 Prompt Ansi$(3)+"INSERT line(s) BETWEEN these lines"+yn$
 gyn=True
 GOSUB GETYNA
 IF no OR abort THEN GOTO EDITOR
 Tout ""
IL0:
 IF Text$(ll) > "" THEN GOTO EDITOR
 Prompt Ansi$(2)+MID$(STR$(j),2)+SPACE$(4-LEN(STR$(j)))+": "
 GOSUB GETLINE
 IF LEN(i$)=0 THEN GOTO EDITOR
 FOR i=l TO j STEP -1
  Text$(i)=Text$(i-1)
 NEXT
 Text$(j)=i$
 INCR l
 INCR j
GOTO IL0

ListLines:
 p=1
 ww$="1"
 bt=1
 tl=3
 uc=1
 Prompt r$+Ansi$(2)+"List from line: "
 GOSUB GETLINE
 IF LEN(i$)=0 THEN i$="1"
 GOSUB EdTrap
 IF abort THEN GOTO EDITOR
 Tout ""
LL0:
 IF i > ll OR Text$(i)="" THEN GOTO EDITOR
 Prompt Ansi$(1)+MID$(STR$(i),2)+SPACE$(4-LEN(STR$(i)))+": "
 a$=Ansi$(7)+Text$(i)
 GOSUB LINEOUT
 GOSUB AUTOPAUSE
 IF ab THEN GOTO EDITOR
 INCR i
GOTO LL0

PrevTxt:
 j=1
 p=1
 Tout ""
 WHILE Text$(j) > "" AND ab=0
  a$=Text$(j)
  GOSUB LINEOUT
  INCR j
  GOSUB AUTOPAUSE
 WEND
GOTO EDITOR

RewrLine:
 Prompt r$+Ansi$(2)+"Enter line # to Rewrite: "
 uc=1
 tl=3
 bt=1
 GOSUB GETLINE
 GOSUB EdTrap
 IF abort THEN GOTO EDITOR
 Prompt r$+Ansi$(7)+"Line"+STR$(i)+" currently reads: "
 Tout r2$+Ansi$(6)+Text$(i)+r$
 Tout Ansi$(2)+"Please reenter line"+STR$(i)+" - (ENTER aborts): "+r$
 GOSUB GETLINE
 IF LEN(i$)=0 THEN Tout ab$:GOTO EDITOR
 Text$(i)=i$
 Tout r$+Ansi$(5)+"Line"+STR$(i)+" rewritten."
GOTO EDITOR

$SEGMENT

'*** FILE TRANSFER ROUTINES ***

XferMenu:
 IF xopn=False THEN
  Tout r$+Ansi$(1)+"Sorry, the file transfer section is presently closed."
  IF NOT lm THEN GOTO MainMenu
 END IF
 fi$=""
 nd=0
 cf=0
 ff=0
 hdr=0
 CLOSE #2
 xall=False
 IF dl=0 THEN xall=True
 p=1
 inx=True
 GOTO XFER1
XFER2:
 fi$="XFM"+ans$
 GOSUB OUTFILE
XFER1:
 ChkTime
 IF koff THEN GOTO HANGUP
 CmdTime
 ClrBufs
 Prompt r$+ct$+"UL/DL ["+dl$(dl)+"]: "
 uc=1
 GOSUB GETKEY
 IF chat THEN GOSUB SYSCHAT:GOTO XferMenu
 SELECT CASE i$
 CASE="?",""
  GOTO XFER2
 CASE="+"
  GOSUB IncXfer
  GOTO XferMenu
 CASE="-"
  GOSUB DecXfer
  GOTO XferMenu
 CASE="A"
  IF INSTR(lv1$,"1") THEN GOTO MsgArea
  LoLvl
  GOTO XferMenu
 CASE="B"
  GOTO BatchDL
 CASE="D"
  GOTO DLFile
 CASE="F"
  GOSUB FindFile
  GOTO XferMenu
 CASE="H"
  fi$="XFER.HLP"
  GOSUB OUTFILE
  GOTO XferMenu
 CASE="L"
  p=1
  GOSUB DLDir
  Tout r$+Ansi$(5)+"Total files:"+Ansi$(7)+str$(cf)
  GOTO XferMenu
 CASE="M","Q"
  GOTO MainMenu
 CASE="N"
  nd=1
  p=1
  GOSUB GetDate
  Tout r$+Ansi$(5)+"New files:"+Ansi$(7)+str$(cf)
  GOTO XferMenu
 CASE="P"
  GOSUB SetProt
  GOTO XferMenu
 CASE="G"
  GOTO Logoff
 CASE="S"
  GOSUB SetXfer
  GOTO XferMenu
 CASE="T"
  IF INSTR(lv1$,"9") THEN GOTO ReadXlog
  LoLvl
  GOTO XferMenu
 CASE="U"
  GOTO ULFile
 CASE="X"
  GOSUB ULlog:GOTO XferMenu
 CASE="^"
  IF INSTR(lv1$,"9") THEN GOTO SysMenu
 CASE ELSE
  BadCmd
 END SELECT
GOTO XFER1

ULlog:
 p=1
 ab%=0
 oops=0
 Tout r$+Ansi$(1)+"# Filename       Bytes Description"+SPACE$(32)+"UL Date"
 Prompt Ansi$(11)+STRING$(78,ln$)+Ansi$(6)
 Tout ""
 CLOSE #2
 OPEN "UL.LOG" FOR INPUT AS #2
  IF oops=53 THEN
   Tout Ansi$(17)+"No new uploads found."
   CLOSE #2
   ab%=1
   RETURN
  END IF
  IF oops THEN PRINT #9,"Error: "; oops:GOTO XferMenu
  WHILE NOT EOF(2) AND ab=0
   LINE INPUT #2,a$
   IF INSTR(lv2$,LEFT$(a$,1)) THEN GOSUB LINEOUT
   IF ab=0 THEN GOSUB AUTOPAUSE
  WEND
 CLOSE #2
RETURN

SetProt:
 a$="CKYZG"
 Tout ""
  FOR x=1 TO 5
   Tout Ansi$(3)+"("+MID$(a$,x,1)+") "+Ansi$(6)+xm$(x)
  NEXT
 Prompt r$+Ansi$(2)+"PROTOCOL: "
 GOSUB GETKEY
 a$="CKYZG"
 c=INSTR(a$,i$)
 IF c=0 OR LEN(i$)=0 THEN GOTO SetProt
 i$=UCASE$(i$)
 xm=c
 Tout r$+Ansi$(16)+"Protocol is now set to "+Ansi$(3)+xm$(xm)
RETURN

SetXfer:
 Prompt r$+Ansi$(2)+"Select Transfer Section: "
 GOSUB GETKEY
 IF i$="?" OR i$="" THEN GOTO SXS1
 IF (INSTR(lv2$+"!",i$)=0) OR (dl$(ASC(i$)-64)="NA") THEN i$=""
 IF i$="!" AND inx THEN dl=0:xall=True:RETURN
 IF i$=>"A" AND i$=<"Z" THEN dl=ASC(i$)-64:RETURN
 BadCmd
 GOTO SetXfer
SXS1:
 Tout ""
 s=0
 FOR i=1 to 26
  IF INSTR(lv2$,CHR$(64+i)) AND dl$(i) <> "NA" THEN
    Prompt SPACE$(s)+Ansi$(3)+"["+CHR$(64+i)+"]"+s$+dl$(i)
    IF s=0 THEN s=30-LEN(dl$(i)) ELSE Tout "":s=0
  END IF
 NEXT
 IF inx THEN Prompt SPACE$(s)+Ansi$(6)+"[!] All Transfer Sections"+r$
 IF (s>1) AND (inx=0) THEN Tout ""
GOTO SetXfer

ReadXlog:
 Prompt r$+Ansi$(5)+"Username"+SPACE$(13)+"UD # Filename"
 Tout SPACE$(11)+"Time/Date       Protocol (CPS %)"
 Prompt Ansi$(4)+STRING$(79,ln$)+Ansi$(6)
 fi$="XFER.LOG"
 GOSUB OUTFILE
GOTO XferMenu

UpdXlog:' after upload or download
 oops=0
 OPEN "XFER.LOG" FOR INPUT AS #2
  IF oops=53 THEN GOTO UXL1
  i=0
  WHILE NOT EOF(2) AND i <= xlc
   INCR i
   LINE INPUT #2,Text$(i)
  WEND
UXL1:
 CLOSE #2
 CvtDate
 OPEN "XFER.LOG" FOR OUTPUT AS #2
  z=xc
  IF z=0 THEN z=1
  FOR x=1 to z
    IF xc THEN xfe$(1)=xft$(x,2)
    PRINT #2,nam$SPACE$(20-LEN(nam$))uldl$CHR$(64+dl)s$;
    PRINT #2,xfe$(1)SPACE$(13-LEN(xfe$(1)));
    CvtDate
    PRINT #2,SPACE$(10-LEN(ti$))ti$"/"SPACE$(8-LEN(da$))da$;
    PRINT #2," - "xm$(xm)" ("MID$(STR$(INT(c!)),2,3)"%)"
  NEXT
  i=1
  WHILE i <= xlc AND Text$(i) > ""
   IF LEN(Text$(i)) > 30 THEN PRINT #2,LEFT$(Text$(i),79)
   INCR i
  WEND
 CLOSE #2
 ERASE text$
 IF uldl$=" DL " THEN RETURN

UpdULog:' UL log - last "clc" files
 oops=0
 OPEN "UL.LOG" FOR INPUT AS #2
  IF oops=53 THEN GOTO UUL1
  i=0
  WHILE NOT EOF(2) AND i <= 80
   INCR i
   LINE INPUT #2,Text$(i)
  WEND
UUL1:
 CLOSE #2
 CvtDate
 OPEN "UL.LOG" FOR OUTPUT AS #2
  PRINT #2,CHR$(64+dl)s$xfe$(1)SPACE$(13-LEN(xfe$(1)));
  PRINT #2,SPACE$(7-LEN(xfe$(2)))xfe$(2)s$;
  PRINT #2,xfe$(6)SPACE$(42-LEN(xfe$(6)));
  CvtDate
  PRINT #2,SPACE$(9-LEN(da$))da$
  i=1
  WHILE i <= clc AND Text$(i) > ""
   IF LEN(Text$(i)) > 30 THEN PRINT #2,Text$(i)
   INCR i
  WEND
 CLOSE #2
 ERASE text$
RETURN

GetDate:
 i$=ufo$(11)
 IF VAL(i$)=0 THEN i$=da$
 GOSUB DatNum
 Prompt r$+Ansi$(2)+"Search from date (YYMMDD): "
 ww$=i$
 uc=True
 bt=2
 tl=6
 GOSUB GETLINE
 NumOnly
 IF abort THEN
  Tout Ansi$(1)+"YYMMDD numeric format only."
  GOTO GetDate
 END IF
 IF i$="" OR LEN(i$) <> 6 THEN GOTO XferMenu
 c!=VAL(i$)
 GOSUB DLDir
RETURN

FindFile:
 Prompt r$+Ansi$(3)+"Search for: "
 uc=True
 tl=8
 bt=1
 GOSUB Getline
 IF LEN(i$)=0 then RETURN
 fi$=i$
 fi$=UCASE$(fi$)
 ff=True:p=1
 GOSUB DLDir
 Tout r$+Ansi$(5)+"Matches found:"+Ansi$(7)+str$(cf)
RETURN

DLDir:
 IF dl=0 THEN GOTO DLD3 'dl=1
 i=1
 OpnXfer
  GET #2,i
  GOSUB PAB
  WHILE NOT EOF(2) AND ab=0
   FOR ix=1 TO 6
    LINE INPUT #2,xfe$(ix)
   NEXT
   IF nd THEN i$=xfe$(3):GOSUB DatNum:IF VAL(i$) < c! THEN GOTO DLD1
   IF nd THEN INCR cf
   IF xfe$(1)=s$ THEN GOTO DLD1
   GOSUB PAB:IF ab THEN GOTO DLD2
   i$=MID$(STR$(i),2)
   a$=i$+STRING$(4-LEN(i$),s$)+xfe$(1)+STRING$(13-LEN(xfe$(1)),s$)
   a$=a$+STRING$(7-LEN(xfe$(2)),s$)+xfe$(2)+STRING$(10-LEN(xfe$(3)),s$)
   a$=a$+xfe$(3)+STRING$(4-LEN(xfe$(5)),s$)+xfe$(5)+s$+xfe$(6)
   a$=UCASE$(a$)
   a=INSTR(a$,fi$) 'search DL
   IF ff AND a THEN
    IF hdr=0 THEN GOSUB DLHdr
    INCR cf
    b$=MID$(a$,a,LEN(fi$))
    a$=LEFT$(a$,a-1)+Ansi$(3)+b$+Ansi$(6)+MID$(a$,a+len(b$))
   END IF
   IF ff and a=0 THEN GOTO DLD1
   GOSUB DLHdr
   IF ff=0 and nd=0 THEN INCR cf
   Tout a$
   GOSUB AUTOPAUSE
   IF ab THEN GOTO DLD2
DLD1:
   GOSUB PAB
   INCR i
   GET #2,i
 WEND
 CLOSE #2
 GOSUB AUTOPAUSE
 IF ab THEN GOTO DLD2
 IF xall=False THEN GOTO DLD2
DLD3:
 hdr=0
 INCR dl
 IF INSTR(lv2$,CHR$(dl+64)) AND dl < 27 THEN GOTO DLDir
 IF dl < 27 THEN GOTO DLD3
DLD2:
 IF xall THEN dl=0
RETURN

DLHdr:
 IF hdr THEN RETURN
 p=p+5
 b$="Download Directory"
 IF nd THEN b$="New Download Directory"
 IF ff THEN b$="Search Download Directory"
 Tout r$+Ansi$(7)+b$+" - "+dl$(dl)+" Files -"+" Section"+s$+CHR$(dl+64)
 Tout r$+Ansi$(2)+"#   Filename       Bytes  UL Date  DLs Description"
 Tout Ansi$(12)+STRING$(78,ln$)+Ansi$(6)
 hdr=1
RETURN

DatNum:' Converts date from MM-DD-YYYY to YYMMDD
 i$=RIGHT$(i$,2)+LEFT$(i$,2)+MID$(i$,4,2)
RETURN

DLFile:
 IF dl=0 THEN
  Tout r$+Ansi$(2)+"Please set xfer section 1st."
  inx=False
  GOSUB SetXfer
 END IF
 IF INSTR(lv1$,"9") OR INSTR(lv1$,"7") THEN GOTO DLF0 'no ratio
 IF ma=0 THEN
  Tout r$+"Don't forget to check into the message area occasionally!"
  Bell
 END IF
 a!=VAL(ufo$(15))
 b!=VAL(ufo$(16))+VAL(xft$(0,1))
 a!=(a!+1024) * ratio
 INCR b!
 c!=a!/b!
 IF c! < 1 THEN
  IF LEN(xft$(1,1))=0 THEN
   Tout r$+Ansi$(1)+"Download ratio exceeded - Time to Upload."
   Bell
  END IF
  IF LEN(xft$(1,1)) > 0 THEN
   Prompt r$+Ansi$(1)
   Tout "After downloading your selected files, you will be required"
   Tout "to upload before you will be able to download again. Your"
   Tout "download ratio will then be exceeded."
  END IF
  GOTO XferMenu
 END IF
DLF0:
 Prompt r$+Ansi$(2)+"Download File #: "
 uc=1
 bt=2
 tl=5
 GOSUB GETLINE
 i=LEN(i$)
 NumOnly
 IF LEN(i$)=0 THEN abort=True
 IF abort THEN
  IF i > 0 THEN
   Tout r$+Ansi$(2)+"Download files can ONLY be requested by NUMBER."
  END IF
  GOTO XferMenu
 END IF
 ii=VAL(LEFT$(i$,3))
 'IF xm=0 THEN GOSUB SetProt
 Prompt r$+"Searching..."
 OpnXfer
  GET #2,ii
  IF EOF(2) THEN xfe$(1)=s$:GOTO DLF1
  FOR i=1 TO 6
   LINE INPUT #2,xfe$(i)
  NEXT
DLF1:
 CLOSE #2
 IF xfe$(1)=s$ THEN
  Tout r2$+Ansi$(1)+"Sorry, that file does not exist."
  GOTO XferMenu
 END IF
 Prompt Ansi$(3)+"Download File #"+STR$(ii)+" - "+dl$(dl)
 Tout " Section"+Ansi$(7)+r$
 FOR ix=1 TO 6
  Tout xff$(ix)+xfe$(ix)
 NEXT
 Tout "Protocol   : "+xm$(xm)
 c=128
 a!=.75
 IF xm > 2 THEN c=1024:a!=.9
 c!=VAL(xfe$(2))
 d=c!/(a!*cps)
 c=INT(d\60)
 b=INT(d) MOD 60
 Prompt "DL Time    :"+STR$(c)+" min"
 IF c <> 1 THEN Prompt "s"
 Prompt STR$(b)+" sec"
 IF b <> 1 THEN Prompt "s"
 Tout ""
 PRINT#9,Esc$"s";
 a$="PKUNZIP "
 IF RIGHT$(xfe$(1),3)="ARJ" THEN a$="ARJ x "
 SHELL a$+xp$(dl)+"\"+xfe$(1)+" FILE_ID.DIZ > NUL"
 PRINT#9,Esc$"u";
 fi$="FILE_ID.DIZ"
 oops=0
 OPEN fi$ FOR INPUT AS #2
 CLOSE #2
 IF oops = 0 THEN GOSUB OUTFILE
 KILL fi$
 d=(c*60)+b
 CvtTmr
 c=c+VAL(xft$(0,2))
 IF lm=0 THEN
  IF c > tlim-INT(ton\60) THEN
   Prompt r2$+Ansi$(1)
   Tout "Sorry, not enough time remaining to download this file."
   GOTO XferMenu
  END IF
 END IF
 fi$=xp$(dl)+"\"+xfe$(1)
 oops=0
 OPEN fi$ FOR INPUT AS #2
  IF oops=53 THEN
   CLOSE #2
   Tout r$+Ansi$(1)+"File not found."
   GOTO XferMenu
  END IF
 CLOSE #2
 f$=fi$
 fi$="DLM"
 GOSUB Outfile
 fi$=f$
 Prompt r$+Ansi$(2)+"DL Command: "
 GOSUB Getkey
 IF i$="D" THEN GOTO DLF2
 IF i$="G" THEN nokey=1:GOTO DLF2
 IF i$="S" THEN
  INCR xc
  IF xc > 9 THEN
   xc=9
   Tout r$+Ansi$(1)+"Sorry, Maximum BATCH DL files = 9"
   GOTO XferMenu
  END IF
  xft$(xc,1)=f$
  xft$(xc,2)=xfe$(1)
  xft$(xc,3)=xfe$(2)
  d=INT(d\60)
  IF d<1 THEN d=1
  xft$(xc,4)=MID$(STR$(d),2)
  xft$(xc,5)=xfe$(6)
  a!=VAL(xft$(0,1))+VAL(xft$(xc,3))
  xft$(0,1)=MID$(STR$(a!),2)
  a=VAL(xft$(0,2))+VAL(xft$(xc,4))
  xft$(0,2)=MID$(STR$(a),2)
  xft(xc,1)=dl
  xft(xc,2)=ii
  Tout r$+Ansi$(3)+xfe$(1)+" selected."
 END IF
 GOTO XferMenu
DLF2:
 Prompt r$+Ansi$(5)+"Ready to Send file. "
 Tout "Enter Receive mode now. Ctrl X twice will Abort."+Ansi$(17)
 StatLine
 CvtTmr
 it=ton
 locate 22,1 'for DSZ
 send$=Cfg$(33)+" CON port"+STR$(Port)+" handshake both "+sx$(xm)+s$+fi$
 DELAY 2
 SHELL send$
 SetBaud
 StatLine
 b$=mid$(str$(scrows-1),2)
 print#9,Esc$b$";1H";
 oops=0
 OPEN "DSZ.LOG" FOR INPUT AS #2
  WHILE NOT EOF(2)
   INPUT #2,a$
  WEND
  b$=LEFT$(a$,1)
  b=INSTR(a$,"cps")
  a=VAL(MID$(a$,b-6,5))
  IF b$="E" OR b$="L" THEN abort=True
 CLOSE #2
 DELAY 3
 IF abort THEN
  nokey=360
  Tout Ansi$(1)+"Download Aborted."
  GOTO XferMenu
 END IF
 c!=(a/cps)*100
 ClrBufs
 Tout r$+Ansi$(7)+"CPS Average   :"+STR$(a)
 Tout "Efficiency    :"+STR$(INT(c!))+"%"
 INCR sst!(10)
 d#=VAL(xfe$(2))+VAL(ufo$(16))+VAL(xft$(0,1))
 ufo$(16)=MID$(STR$(d#),2)
 Tout "Total DL Bytes: "+ufo$(16)
 ton=ton+it
 GOSUB UpdDLs
 uldl$=" DL ":GOSUB UpdXlog
 xc=0
 erase xft$,xft
GOTO XferMenu

UpdDLs:
 z=xc
 IF z=0 THEN z=1
 FOR x=1 to z
  IF xc THEN dl=xft(x,1):ii=xft(x,2)
  OpnXfer
   GET #2,ii
    FOR ix=1 TO 6
     LINE INPUT #2,xfe$(ix)
    NEXT
  CLOSE #2
  a=VAL(xfe$(5))+1
  xfe$(5)=MID$(STR$(a),2)
  OpnXfer
   FOR ix=1 TO 6
    PRINT #2,xfe$(ix)
   NEXT
  PUT #2,ii
  CLOSE #2
 NEXT
RETURN

BatchDL:
 IF xm<3 then xm=4
 IF LEN(xft$(1,1))=0 THEN
  Tout r$+Ansi$(1)+"No files selected."
  GOTO XferMenu
 END IF
 KILL "BATCH.LST"
 Tout Ansi$(1)+r$+"BATCH Multiple File Download Mode"
 Tout r$+Ansi$(7)+"# Filename        Bytes Mins Description"
 Tout Ansi$(11)+STRING$(72,ln$)+Ansi$(3)
 FOR i=1 TO xc
  a$=MID$(STR$(i),2)+s$+xft$(i,2)+SPACE$(13-LEN(xft$(i,2)))
  a$=a$+SPACE$(9-LEN(xft$(i,3)))+xft$(i,3)
  a$=a$+SPACE$(4-LEN(xft$(i,4)))+xft$(i,4)+s$+xft$(i,5)
  Tout a$
 NEXT
 a$=SPACE$(9-LEN(xft$(0,1)))+xft$(0,1)
 b$=SPACE$(4-LEN(xft$(0,2)))+xft$(0,2)
 Tout Ansi$(2)+"  Total        "+a$+b$
 fi$="BDM"
 GOSUB Outfile
 Prompt r$+Ansi$(3)+"Batch Command: "
 GOSUB Getkey
 IF i$="C" THEN xc=0:erase xft$,xft:i$=""
 IF i$="D" THEN GOTO BDL1
 IF i$="G" THEN nokey=1:GOTO BDL1
 GOTO XferMenu
BDL1:
 OPEN "BATCH.LST" FOR OUTPUT AS #2
  FOR i=1 TO xc
   PRINT#2,xft$(i,1)
  NEXT
 CLOSE #2
 fi$="@"+Cfg$(2)+"\BATCH.LST"
GOTO DLF2

ULFile:
 IF dl=0 THEN
  Tout r$+Ansi$(2)+"Please select section first."
  inx=False
  GOSUB SetXfer
 END IF
 'IF xm=0 THEN GOSUB SetProt
 CvtTmr
 itx=ton
 Tout r$+Ansi$(6)+"Upload File Mode"+" - "+dl$(dl)+" Section"+r$
 Tout Ansi$(2)+"Please enter the following file information: "
 Prompt r$+Ansi$(6)+xff$(1)
 pw=4
 GOSUB GETLINE
 IF LEN(i$)=0 THEN GOTO XferMenu
 IF LEN(i$) < xfl(1) THEN
  Tout r$+Ansi$(1)+lod$+"short. Min chrs ="+STR$(xfl(1))
  GOTO ULFile
 END IF
 i$=UCASE$(i$)
 xfe$(1)=i$
 fi$=xp$(dl)+"\"+xfe$(1)
 Oops=0
 OPEN fi$ FOR INPUT AS #2
  a=Oops
 CLOSE #2
 IF a=53 THEN GOTO ULF1
 Tout Ansi$(5)+r$+"File already exists."
 Bell
 GOTO XferMenu
ULF1:
 c$=Ansi$(5)+"Text Min/Max: "+SPACE$(xfl(6))+STRING$((xfu(6)-xfl(6)),"-")
 Prompt Ansi$(6)+xff$(6)
 tl=xfu(6)
 GOSUB GETLINE
 IF LEN(i$)=0 THEN GOTO XferMenu
 IF LEN(i$) < xfl(6) THEN Tout Ansi$(1)+lod$+"short."+r$+c$:GOTO ULF1
 xfe$(6)=i$
 Tout Ansi$(6)+"Protocol   : "+xm$(xm)
 'Tout Ansi$(6)+"Status     : Timer halted during upload."
 Prompt r$+Ansi$(5)+"Ready to Receive file. "
 Tout "Enter Send mode now. Ctrl X will Abort."+Ansi$(17)
 StatLine
 send$=Cfg$(33)+" CON port"+STR$(Port)+" handshake both "+rx$(xm)+s$+fi$
 DELAY 2
 LOCATE 16,1
 SHELL send$
 SetBaud
 StatLine
 b$=mid$(str$(scrows-1),2)
 print#9,Esc$b$";1H";
 ClrBufs
 oops=0
 OPEN "DSZ.LOG" FOR INPUT AS #2
  IF oops THEN abort=True:GOTO ULAB
  WHILE NOT EOF(2)
   INPUT #2,a$
  WEND
 CLOSE #2
 b$=LEFT$(a$,1)
 IF b$="E" OR b$="L" THEN abort=True:GOTO ULAB
 oops=0
 OPEN fi$ FOR INPUT AS #2
 CLOSE #2
 Abort=False
 IF oops=53 THEN Abort=True
ULAB:
 IF Abort THEN
  CLOSE #2
  KILL fi$
  Tout r$+Ansi$(1)+"Upload aborted - Thanks for trying though!"+r$
  LmtChg
  GOTO XferMenu
 END IF
 OPEN fi$ FOR INPUT AS #2
  xfe$(2)=MID$(STR$(LOF(2)),2)
 CLOSE #2
 b=INSTR(a$,"cps")
 d=VAL(MID$(a$,b-6,5))
 DELAY 2
 Tout Ansi$(7)+r$+"Bytes Recvd   : "+xfe$(2)+r$+"CPS Average   :"+STR$(d)
 c!=(d/cps)*100
 Tout "Efficiency    :"+STR$(INT(c!))+"%"
 INCR sst!(9)
 d#=VAL(xfe$(2))+VAL(ufo$(15)):ufo$(15)=MID$(STR$(d#),2)
 Tout "Total UL Bytes: "+ufo$(15)
 uldl$=" UL "
 GOSUB UpdXlog
 CvtDate
 xfe$(3)=da$
 xfe$(4)=nam$
 xfe$(5)="0"
 GOSUB FindEmpXF
 OpnXfer
  FOR x=1 TO 6
   PRINT #2,xfe$(x)
  NEXT
  PUT #2,i
 CLOSE #2
 'LmtChg
GOTO XferMenu

'*** SUB ROUTINES ***

AutoPause:
 INCR p
 IF pt%=False OR p < PgLen THEN RETURN
 StatLine
 j$=""
 IF Ansi THEN j$=Esc$+"0;1;37;44m"
 Prompt j$+Cfg$(24)+Ansi$(6)
 PRINT #9,Crsr$;
 CvtTmr
 it=ton
 ab=False
AP1:
 k$=""
 IF Port > 0 THEN IF NOT EOF(1) THEN k$=INPUT$(1,1)
 j$=INKEY$
 k$=j$+k$
 CvtTmr
 IF VAL(sec$) <> ton MOD 60 THEN
  UpdTon
  CheckCD
  IF dcd=0 THEN GOTO HANGUP
 END IF
 IF len(k$)=0 AND ton < (it+180) THEN GOTO AP1
 IF INSTR(r$+" aA",k$)=0 AND ton < (it+180) THEN GOTO AP1
 p=1
 IF k$>"" AND INSTR(" aA",k$) THEN ab=True
 FOR c=1 TO LEN(Cfg$(24))
  PRINT #9,del$;
  IF NOT lm THEN PRINT #1,bs$;
 NEXT
 PRINT #9,s$CHR$(8)Ansi$(6);
 IF ab THEN Tout ab$
RETURN

Devent: 'midnight event
 oops=0
 OPEN Cfg$(7) FOR INPUT AS #2
  IF oops=53 THEN CLOSE #1:RUN 'no Event.bat
 CLOSE #2
 ModemCmd Cfg$(11)
 ClrScrn
 a$="Processing daily event file."
 CenterLine
 Tout SPACE$(ta)+a$
 ModemCmd Cfg$(11)
 DELAY 1
 ClrBufs
EXECUTE "EVENT.BAT"

Getkey: 'Get ONE keypress
 uc=True
 gk=True
 GOSUB GETLINE
RETURN

Getline: 'Line input
 StatLine
GLIN:
 CvtTmr
 i$=""
 wl=0
 it=ton
 IF cl THEN uc=True
 IF ww OR ww$ > "" THEN
  IF ww=0 THEN ww=1
  i$=ww$
  Prompt Ansi$(7)+i$
  ww$=""
  aw=ww
  ww=0
 END IF
 IF pw=4 THEN
  bt=2
  tl=12
  uc=True
 END IF
GL0:
 PRINT #9,Crsr$;
 CvtTmr
 it=ton
 IF Ansi THEN Prompt Ansi$(7)
GL1:
 a$=""
 IF Port > 0 THEN IF NOT EOF(1) THEN IF LOC(1) > 0 THEN a$=INPUT$(1,1)
 b$=INKEY$
 GOSUB INCTIME
 IF len(a$+b$)=0 THEN GOTO GL1
 c=ASC(a$+b$)
 IF b$=dos$ THEN
  PRINT#9,Esc$"0;37;40m";
  CLEAR
  END
 END IF
 IF gk THEN GOTO GKEY1
 IF ts THEN
  tl=8
  IF c=63 THEN
   i$=CHR$(c)
   Prompt i$
   c=13
   GOTO GL2
  END IF
 END IF
 IF bt THEN IF INSTR(bt$(bt),CHR$(c)) THEN Bell:GOTO GL1
 IF c=8 OR c=127 THEN
  IF i$ > "" THEN
   i$=LEFT$(i$,LEN(i$)-1)
   PRINT #9,del$;
   IF NOT lm THEN PRINT #1,bs$;
  END IF
  IF wl > 0 THEN DECR wl
  aw=0
  GOTO GL0
 END IF
 IF ABS(aw)=1 THEN
  IF c <> 13 AND c <> 32 AND c <> 8 AND c <> 3 AND c <> 127 THEN
   GOSUB GL4:i$=""
  END IF
 END IF
 aw=0
 IF nq THEN IF c=34 THEN c=39
 IF c=3 THEN i$=CHR$(3):c=13:GOTO GL2
 IF c=9 AND LEN(i$) < 60 AND tl=0 THEN
  a$=SPACE$(8-(POS(0) MOD 8))
  PRINT #9,a$Crsr$;
  IF NOT lm THEN PRINT #1,a$;
  i$=i$+a$
  a$=""
  GOTO GL1
 END IF
 IF c=12 THEN uc=0:cl=0
 IF b$=CHR$(21) THEN uc=True:cl=True
 IF c=24 or c=27 THEN GOSUB GL4:GOTO GLIN
GKEY1:
 IF LEN(b$) < 2 THEN GOTO GL2
 b$=RIGHT$(b$,1)
 IF b$ > CHR$(58) AND b$ < CHR$(69) THEN GOSUB SYSKEYS:RETURN
GL2:
 IF c=13 THEN
  PRINT #9,s$+CHR$(8)
  IF NOT lm THEN PRINT #1,r$;
  gk=False
  nq=0
  pw=0
  uc=0
  ac=0
  bt=0
  tl=0
  RETURN
 END IF
 IF tl THEN IF LEN(i$) >= tl THEN Bell:GOTO GL1
 IF uc THEN c=ASC(UCASE$(CHR$(c))):ac=False
 IF ac THEN
  IF c > 96 AND c < 123 THEN
   IF RIGHT$(i$,1)=s$ OR LEN(i$)=0 THEN c=c-32
  END IF
 END IF
 IF c < 32 THEN GOTO GL1
 IF NOT Ansi THEN IF c > 126 THEN GOTO GL1
 IF pw=1 OR (pw=2 AND INSTR(i$,";")) THEN Prompt "_":GOTO GL3
 IF pw=4 THEN
  b=False
  a=INSTR(i$,".")
  d=LEN(i$)
  IF (d=0 OR d > 8) AND c=46 THEN b=True
  IF a AND a < d+1 AND c=46 THEN b=True
  IF a THEN IF LEN(i$) > a+2 THEN b=True
  IF b THEN Bell:GOTO GL1
  IF LEN(i$)=8 AND c <> 46 AND a=0 AND ts=0 THEN i$=i$+".":Prompt "."
 END IF
GL5:
 IF pw=3 AND LEN(i$)=3 AND c <> 45 THEN i$=i$+"-":Prompt "-"
 PRINT #9,CHR$(c);
 IF NOT lm THEN PRINT #1,CHR$(c);
 IF gk THEN i$=CHR$(c):c=13:GOTO GL2
GL3:
 i$=i$+CHR$(c)
 INCR wl
 IF wl > 20 OR c=32 OR RIGHT$(i$,LEN(i$))=s$ THEN wl=0
 IF LEN(i$)=69 THEN
  ww$=RIGHT$(i$,wl)
  i$=LEFT$(i$,LEN(i$)-wl)
  ww=2
 END IF
 IF ww=0 THEN GOTO GL0
 FOR a=1 TO LEN(ww$)
  PRINT #9,CHR$(8);
  IF NOT lm THEN PRINT #1,bs$;
 NEXT
 c=13
 PRINT #9,SPACE$(LEN(ww$));
 GOTO GL2
GL4:
 IF LEN(i$) > 0 THEN
  a=LEN(i$)
  FOR v=1 TO a
   IF NOT lm THEN PRINT #1,bs$;
   PRINT #9,CHR$(8);
  NEXT
  PRINT #9,SPACE$(a+1);
  FOR v=1 TO a+1
   PRINT #9,CHR$(8);
  NEXT
 END IF
RETURN

GetYNA: 'Get yes/no/abort
 StatLine
 PRINT #9,Crsr$;
 c=0
 abort=False
 no=False
 yes=False
 ClrBufs
 CvtTmr
 it=ton
 a$=""
GYN1:
 a$=""
 IF Port > 0 THEN IF NOT EOF(1) THEN a$=INPUT$(1,1)
 b$=INKEY$
 IF LEFT$(b$,1)=CHR$(0) THEN GOSUB SYSKEYS
 GOSUB INCTIME
 CheckCD
 IF dcd=0 THEN GOTO HANGUP
 IF len(a$+b$)=0 THEN GOTO GYN1
 c=ASC(a$+b$)
 IF c=10 OR c=13 AND gyn THEN c=89 'cr=yes
 IF c=10 OR c=13 AND NOT gyn THEN c=78 'cr=no
 IF c=89 OR c=121 THEN Tout "Yes":yes=True:RETURN
 IF c=78 OR c=110 THEN Tout "No":no=True:RETURN
 IF c=65 OR c=97 THEN Tout "Abort":abort=True:RETURN
GOTO GYN1

IncTime: 'Update time and check dcd
 CvtTmr
 IF VAL(sec$) <> ton MOD 60 THEN
  UpdTon
  CheckCD
  IF dcd=False THEN PRINT #9,r2$"LOST CARRIER":GOTO HANGUP
 END IF

 IF ton = (it+nokey)-60 THEN
  Bell
  DELAY 1
  ton=ton+1
 END IF

 IF ton > it+nokey THEN
  IF nokey<20 THEN qu=True:GOTO LOGO1
  Tout "KEY TIMEOUT"
  Bell
  GOTO HANGUP
 END IF
RETURN

InitAnsi:
 ERASE Ansi$
 ans$=""
 ln$="-"
 IF Ansi THEN
  ans$=".ANS"
  ln$=CHR$(196)
  FOR i=0 TO 7
   i$=MID$(STR$(i+30),2)
   Ansi$(i)=Esc$+"0;1;"+i$+";40m"
  NEXT
  FOR i=0 TO 7
   i$=MID$(STR$(i+30),2)
   Ansi$(i+10)=Esc$+"0;"+i$+";40m"
  NEXT
 END IF
'reinit Ansi$ variables
 Crsr$=Ansi$(7)+CHR$(219)+CHR$(8)
 del$=s$+CHR$(8)+CHR$(8)+s$+CHR$(8)+Crsr$
 bs$=CHR$(8)
 ne$=r$+Ansi$(1)+"The name you entered is too "
 ok$=r$+Ansi$(2)+"Correct (Y/n/abort)? "
 ab$=r$+Ansi$(1)+"[ABORTED]"
 yn$=Ansi$(2)+" (Y/n)? "+Ansi$(7)
 ny$=Ansi$(1)+" (N/y)? "+Ansi$(7)
 lod$=Ansi$(1)+"The length of the entered data is too "
RETURN

InitHdr:
 a=6:b=7
 hdr$(1)=Ansi$(a)+"To  : "+Ansi$(b)
 hdr$(2)=Ansi$(a)+"From: "+Ansi$(b)
 hdr$(3)=Ansi$(a)+"Subj: "+Ansi$(b)
 hdr$(4)=Ansi$(a)+"Date: "+Ansi$(b)
RETURN

Lineout:
 GOSUB PAB
 IF ab OR nm THEN RETURN
 PRINT #9,a$
 IF NOT lm THEN
  PRINT #1,a$r$;
  TXWait
  CheckCD
  IF dcd=False THEN GOTO HANGUP
 END IF
 GOSUB PAB
RETURN

PAB: 'Pause ABORT,etc.
 nm=0
 ab=0
 w$=""
 IF Port > 0 THEN IF NOT EOF(1) THEN w$=INPUT$(1,1)
 y$=INKEY$
 w$=w$+y$
 IF len(w$)=0 THEN RETURN
 IF INSTR(" aA"+CHR$(3),w$) THEN
  ab=1
  p=0
  PRINT #9,ab$
  IF NOT lm THEN PRINT #1,ab$
 END IF
 IF nx THEN
  IF INSTR(CHR$(13)+"nN"+CHR$(25),w$) THEN
   nm=1
   nx=0
   a$=r$+"[NEXT MESSAGE]"
   p=0
   PRINT #9,a$
   IF NOT lm THEN PRINT #1,a$
  END IF
 END IF
 IF INSTR(CHR$(19)+"sS*",w$) THEN GOSUB PAR
 ClrBufs
RETURN

PAR:' Pause/resume
 CvtTmr:it=ton
RES1:
 w$=""
 IF Port > 0 THEN IF NOT EOF(1) THEN w$=INPUT$(1,1)
 y$=INKEY$
 w$=w$+y$
 CvtTmr
 IF VAL(sec$) <> ton MOD 60 THEN
  UpdTon
  CheckCD
  IF dcd=0 THEN GOTO HANGUP
 END IF
 IF LEN(w$)=0 AND ton < (it+60) THEN GOTO RES1
RETURN

OutFile: 'OUTPUT fi$
 p=1
 ab=0
 oops=0
 fi$=UCASE$(fi$)
 Tout Ansi$(6)
 OPEN fi$ FOR INPUT AS #2
  IF oops=53 THEN
   IF ts=False THEN Tout q$+fi$+q$+" file not found."
   IF ts=True THEN Tout "Sorry, that text file cannot be found."
  END IF
  IF oops=64 THEN Tout "Bad file name."
  IF oops THEN ab=True:GOTO OF1
  WHILE NOT EOF(2) AND ab=0
   LINE INPUT #2,a$
   GOSUB LINEOUT
   IF ab=0 THEN GOSUB AUTOPAUSE
  WEND
OF1:
 CLOSE #2
RETURN

SysChat: 'Chat mode
 IF ch THEN RETURN
 Tout s$
 chrq=False
 bt=0
 tl=0
 ts=0
 itx=ton
 uc=0
 pw=0
 ch=1
 Tout r$+sy$+" OnLine: "+r$
 cl=0
 nc=0
 ac=False
 uc=False
 WHILE nc=0
  GOSUB GETLINE
 WEND
 nc=0
RETURN

SysKeys: 'Sysop function keys
 IF b$=CHR$(59) AND gk THEN chat=True:gk=False:RETURN
 IF b$=CHR$(59) THEN GOSUB SYSCHAT:RETURN
 IF b$=CHR$(60) THEN
  Tout s$+r2$+sy$+" OFFLINE."
  ch=0
  nc=1
  chat=False
  LmtChg
 END IF
 IF b$=CHR$(61) THEN Tout s$:ch=0:GOTO SYSMENU
 IF b$=CHR$(67) THEN PRINT #9,s$; CHR$(8):GOTO HANGUP
 IF b$=CHR$(68) THEN CLOSE #1:RUN
RETURN

'*** SUB-PROGRAMS ***

SUB AbortTxt STATIC
 Tout " - Press SPACE to ABORT - "+pt$(pt%)
END SUB

SUB BadCmd STATIC
 Tout r$+Ansi$(1)+"Invalid command. Press ? for help menu."
 ClrBufs
END SUB

SUB Bell STATIC
 IF lm THEN BEEP ELSE PRINT #1,CHR$(7);
END SUB

SUB CenterLine STATIC
 ta=((80-(LEN(a$)))\2)
END SUB

SUB CheckCD STATIC
 dcd=True
 IF lm OR Port=0 THEN EXIT SUB
 IF (INP(msr) AND cdm) <> cdm THEN dcd=False
END SUB

SUB ChkSysStats STATIC
 CvtDate
 oops=0
 OPEN "STATUS.LOG" FOR INPUT AS #4
  IF oops=53 THEN
   CLOSE #4
   OPEN "STATUS.LOG" FOR OUTPUT AS #4
    PRINT #4,da$
    PRINT #4,au$
    PRINT #4,ti$
    PRINT #4,"30"
    mx=UBOUND(stat$)
    FOR x=5 TO mx
     PRINT #4,"0"
    NEXT
  END IF
 CLOSE #4
END SUB

SUB ChkTime STATIC 'check OnLine time
 koff=False
 IF lm or (un=1) THEN EXIT SUB
 IF INSTR(lv1$,"8") THEN tlim=120
 CvtTmr
 minon=(ton\60)+totl
 IF minon > tlim THEN GOTO BYE
 IF minon > (tlim-6) THEN
  a=tlim-minon
  Prompt r$+Ansi$(1)+"Auto Logoff in"+STR$(a)+" minute"
  IF a > 1 THEN Prompt "s"
  Tout "."
 END IF
BYE:
 IF minon > tlim THEN
  Tout r$+Ansi$(1)+"Your daily time limit has been exceeded!"+r$
  Bell
  Bell
  DELAY 3
  Bell
  koff=True
  qu=1
 END IF
END SUB

SUB ClrBufs STATIC' Clear keyboard and RS232 input buffers
 DO
  a$=INKEY$
 LOOP UNTIL LEN(a$)=0
 IF Port=0 THEN EXIT SUB
 WHILE NOT EOF(1)
  a$=INPUT$(LOC(1),#1)
 WEND
END SUB

SUB ClrScrn STATIC ' Clear remote and local screen
 LOCATE 2,1
 PRINT #9,Esc$"0;1;36;40m"Esc$"2J"
 CheckCD
 IF (lm=0) AND (Port>0) AND dcd THEN
   PRINT #1,r$CHR$(12)STRING$(10,CHR$(0));
 END IF
 IF OnLine then StatLine
END SUB

SUB CmdMode(BYVAL a$) STATIC
 IF Port=0 THEN EXIT SUB
 DELAY 1.1
 PRINT #1,a$;
 DELAY 1.1
END SUB

SUB CmdTime STATIC 'Show remaining time at Prompts
 CvtTmr
 minon=INT(ton\60)+totl
 ct=(tlim-minon):a$="["
 IF ct < 0 THEN a$="[+"
 ct=ABS(ct)
 minute$=" mins"
 IF ct=1 THEN minute$=" min"
 ct$=a$+RIGHT$(STR$(ct),(LEN(STR$(ct))-1))+minute$+"]"
 IF Ansi THEN ct$=Esc$+"0;1;37;44m"+ct$+Esc$+"0;1;33;40m"
 ct$=ct$+s$
END SUB

SUB CvtDate STATIC 'Convert date$ from DD-MM-YYYY to DD MMM YY format
 da$=LEFT$(DATE$,6)+RIGHT$(DATE$,2)
 CvtTime
END SUB

SUB CvtTime STATIC 'Convert time$ to HOUR:MINUTE am/pm format
 ti$=LEFT$(TIME$,5)
END SUB

SUB CvtTmr STATIC 'Use timer to maintain and calc OnLine time
 IF Start! > TIMER OR TIMER > 86398 THEN
  Offset!=86400-Start!
  Start!=0
  DELAY 3
  UpdSysStats
 END IF
 ton=(TIMER-Start!)+Offset!
END SUB

SUB FindEmpUF STATIC
 OpnUsr
 i=(LOF(2)\512)+1
 CLOSE #2
END SUB

SUB GetSysStats STATIC
 ChkSysStats
 OPEN "STATUS.LOG" FOR INPUT AS #4
  FOR x=1 TO 4
   LINE INPUT #4,sst$(x)
  NEXT
  FOR x=5 TO 12
   LINE INPUT #4,sst$(x)
   sst!(x)=VAL(sst$(x))
  NEXT
 CLOSE #4
END SUB

SUB LmtChg STATIC 'adjust OnLine time
 CvtTmr
 ot=ot+(ton-itx)
 tlim=tlim+INT((ton-itx)\60)
END SUB

SUB LoLvl STATIC
 Tout r$+"Sorry, access not authorized."
END SUB

SUB ModemCmd(BYVAL b$) STATIC
 IF Port=0 THEN EXIT SUB
 FOR i=1 TO LEN(b$)
  a$=MID$(b$,i,1)
  IF a$="~" THEN DELAY 1:a$=""
  IF a$="|" THEN a$=CHR$(13)
  DELAY .05
  PRINT #1,a$;
 NEXT
END SUB

SUB NameCase(x$) STATIC
 FOR z=1 to LEN(x$)
  z$=MID$(x$,z,1)
  IF z=1 THEN z$=UCASE$(z$)
  IF z>1 THEN
   z$=LCASE$(z$)
   IF MID$(x$,z-1,1) = " " THEN z$=UCASE$(z$)
  END IF
  MID$(x$,z,1)=z$
 NEXT
END SUB

SUB NumOnly STATIC
 abort=False
 IF LEN(i$)=0 THEN abort=True:EXIT SUB
 FOR c=1 TO LEN(i$)
  a$=MID$(i$,c,1)
  IF a$ < "0" OR a$ > "9" THEN abort=True
 NEXT
END SUB

SUB OpnUsr STATIC
 OPEN "USERFILE.DAT" FOR RANDOM AS #2 LEN=512
END SUB

SUB OpnXfer STATIC
 oops=0
 OPEN xp$(dl)+"\XFERFILE.DAT" FOR RANDOM AS #2 LEN=128
END SUB

SUB PrnLine STATIC
 PRINT#9,Esc$"0;1;34;40m"STRING$(80,CHR$(219))Esc$"0;1;36m";
END SUB

SUB Prompt (BYVAL a$) STATIC 'output text - No CR/LF
 PRINT #9,a$;
 IF NOT lm THEN PRINT #1,a$;
 r$=CHR$(13)+CHR$(10)
END SUB

SUB SetBaud STATIC
 cps=VAL(Cfg$(14))\10
 IF Port=0 THEN EXIT SUB
 ba$=Cfg$(14)
 CLOSE #1
 SetDTR True 'dtr on
 c$="RS,CS"
 IF Baud>2400 THEN ba$="19200":c$="DS0,CS30000"
 OPEN Port$+ba$+",N,8,1,LF,"+c$ FOR RANDOM AS #1
END SUB

SUB SetDTR(BYVAL dtr) STATIC
 IF dtr THEN
  OUT mcr,INP(mcr) OR 1 'dtr on
  ELSE
   OUT mcr,INP(mcr) AND 254 'dtr off
 END IF
END SUB

SUB SrchKey STATIC 'binary userfile search
 found=False
 unam$=UCASE$(unam$)
 oops=0
 OPEN "USERFILE.KEY" FOR RANDOM AS #2 LEN=30
  IF oops THEN
   PRINT #9,oops
   i=0
   CLOSE #2
   EXIT SUB
  END IF
 a=1
 b=LOF(2)\30
 c=(a+b)\2
 GET #2,c
 WHILE NOT EOF(2)
  LINE INPUT #2,a$
  INPUT #2,i
  a$=UCASE$(a$)
  IF LEFT$(a$,LEN(unam$))=unam$ THEN found=True:EXIT LOOP
  IF a$ < unam$ THEN a=c+1 ELSE b=c-1
  IF a>b THEN EXIT LOOP
  c=(a+b)\2
  GET #2,c
 WEND
 IF found=False THEN i=0
 CLOSE #2
END SUB

SUB StatLine STATIC
 PRINT#9,Esc$"s"Esc$"1;1H"Esc$"0;30;47m;
 CvtDate
 IF nam$="" THEN nam$="Unknown"
 b$=ufo$(7)
 IF ufo$(6) > "" THEN b$=ufo$(6)+"-"+ufo$(7)
 a$=nam$+" : "+ufo$(3)+", "+ufo$(4)+" : "+b$+" : "+da$
 IF chrq THEN a$="!CHAT! "+a$
 b$=SPACE$((80-len(a$))\2)
 a$=left$(b$+a$+b$,80)
 PRINT#9,Esc$"1;1H"a$Esc$"0;1;36;40m"Esc$"u";
 OnLine=True
END SUB

SUB Tout(BYVAL a$) STATIC 'outut text - add CR/LF at EOL
 IF LEN(r$)=1 THEN r$=CHR$(13)+CHR$(10)
 PRINT #9,a$
 IF NOT lm THEN PRINT #1,a$r$;
END SUB

SUB TXWait STATIC 'Wait for xmit buffer to clear
 IF NOT lm THEN
  WHILE INP(lsr%)=0
  WEND
 END IF
END SUB

SUB UpdSysStats STATIC
 CvtDate
 IF da$ <> sst$(1) THEN
  KILL "DSZ.LOG"
  CLOSE #3,#4
  OPEN "STATUS.LOG" FOR INPUT AS #4
  OPEN "YESTRDAY.LOG" FOR OUTPUT AS #3
   WHILE NOT EOF(4)
    INPUT #4,a$
    PRINT #3,a$
   WEND
  CLOSE #3,#4
  FOR x=6 TO 12
   sst!(x)=0
  NEXT
 END IF
 OPEN "STATUS.LOG" FOR OUTPUT AS #4
  PRINT #4,da$
   FOR x=2 TO 5
    PRINT #4,sst$(x)
   NEXT
  FOR x=6 TO 12
   PRINT #4,MID$(STR$(sst!(x)),2)
  NEXT
 CLOSE #4
 GetSysStats
END SUB

SUB Updton STATIC 'Update time on
 PRINT#9,Esc$"s"Esc$"1;73H";
 CvtTmr
 mn$=MID$(STR$(INT(ton\60)),2)
 sec$=MID$(STR$(ton MOD 60),2)
 sec$=RIGHT$("0"+sec$,2)
 za$=Esc$+"0;30;47m"+mn$+":"+sec$+Esc$+"0;1;36;40m"+Esc$+"u"
 IF Ansi THEN REPLACE ";36" WITH ";37" in za$
 PRINT#9,za$;
END SUB

'*** USERFILE EDITOR ***

UFEditor: 'USERFILE EDITOR
 CLOSE #2
 GOTO UFM1
UFM0:
 fi$="UEM"+ans$
 GOSUB OUTFILE
UFM1:
 CmdTime
 Prompt r$+ct$+"UFILE EDITOR: "
 GOSUB GETKEY
 IF chat THEN GOSUB SYSCHAT:GOTO UFEDITOR
 SELECT CASE i$
 CASE="?"
  GOTO UFM0
 CASE="A"
  GOTO AddUsr
 CASE="D"
  GOTO DelUsr
 CASE="E"
  GOTO EditUF
 CASE="F"
  GOTO SearchUF
 CASE="M","Q"
  RETURN
 CASE="N",""
  Tout ""
  INCR i
  GOSUB DispUF
  GOTO UFEDITOR
 CASE="P"
  Tout ""
  DECR i
  GOSUB DispUF
  GOTO UFEDITOR
 CASE="V"
  Tout ""
  GOSUB DispUF
  GOTO UFEDITOR
 CASE ELSE
  BadCmd
 END SELECT
GOTO UFEDITOR

AddUsr:
 FindEmpUF
 ufe$(1)=""
 Tout r$+"Adding user to system userfile #"+STR$(i)+r$
 abort=0
 FOR ix=1 TO ub
  nq=1
ADU0:
  Prompt Ansi$(1)+uff$(ix)
  ac=True
  bt=1
  tl=ufu(ix)
  pw=0
  IF ix=7 THEN pw=3
  IF ix=4 THEN uc=True
  IF ix=9 THEN uc=True:ww$=numblv$
  IF ix=10 THEN uc=True:ww$=nuxflv$
  IF ix=11 THEN CvtDate:ww$=da$
  IF ix > 11 THEN ww$="0"
  GOSUB GETLINE
  a$=""
  IF LEN(i$)=0 THEN abort=1:EXIT FOR
  IF LEN(i$) < ufl(ix) THEN
   Tout lod$+"short. (Minimum length ="+STR$(ufl(ix))+""
   GOTO ADU0
  END IF
  ufe$(ix)=i$
 NEXT
 IF abort THEN GOTO UFEDITOR
ADU1:
 Prompt ok$
 gyn=True
 GOSUB GETYNA
 IF no THEN GOTO AddUsr
 IF abort THEN GOTO UFEDITOR
 Prompt r$+"Adding "+ufe$(1)+" to userfiles... "
 OpnUsr
  FOR ix=1 TO ub
   PRINT #2,ufe$(ix)
  NEXT
  FOR ix=1 TO 26
   PRINT #2,"0"
  NEXT
  PUT #2,i
 CLOSE #2
 Tout ""
 OPEN "SORTUF.FLG" FOR OUTPUT AS #2
 CLOSE #2
GOTO UFEDITOR

SearchUF:
 a$=r$+"Find & Display Userfile"+r2$+Ansi$(2)+"Enter User's Name: "
 Prompt a$
 ac=True
 GOSUB GETLINE
 IF LEN(i$)=0 THEN GOTO UFEDITOR
 unam$=fnss$(i$)
 SrchKey
 IF i=0 THEN
  Tout r$+Ansi$(1)+"Userfile does not exist."
  GOTO UFEDITOR
 END IF
 Tout ""
 GOSUB DispUF
GOTO UFEDITOR

DispUF:
 OpnUsr
  IF i < 1 THEN i=LOF(2)\512:IF i=0 THEN i=1
  IF i > LOF(2)\512 THEN i=1
  Tout "Userfile #"+STR$(i)+r$
  GET #2,i
  IF EOF(2) THEN
   Tout Ansi$(1)+"Non existant userfile."
   ufe$(1)=""
   GOTO DISU0
  END IF
  FOR x=1 TO ub
   LINE INPUT #2,ufe$(x)
  NEXT
  FOR x=1 TO 26
   LINE INPUT #2,uhm$(x)
  NEXT
  FOR x=1 TO ub
   Tout Ansi$(3)+uff$(x)+Ansi$(6)+ufe$(x)
  NEXT
DISU0:
 CLOSE #2
RETURN

EditUF:
 IF LEN(ufe$(1)) < 5 THEN GOTO SearchUF
 a$=r$+"Edit Userfile #"+STR$(i)
 a$=a$+" - ENTER leaves the field "+"unchanged. Ctrl-C will exit."+r$
 Tout a$
 FOR ix=1 TO ub
  IF ix=4 THEN uc=True
EDU0:
  Prompt Ansi$(3)+uff$(ix)
  ww$=ufe$(ix)
  ac=True
  nq=1
  bt=1
  tl=ufu(ix)
  pw=0
  IF ix=7 THEN pw=3
  IF ix=9 OR ix=10 THEN
   bt=0
   uc=True
   ww=2
  END IF
  GOSUB GETLINE
  a$=""
  ab=0
  IF LEN(i$)=0 THEN ab=True:EXIT FOR
  abort=0
  IF ix=9 AND i$="?" THEN GOSUB DispBases:GOTO EDU0
  IF ix=10 AND i$="?" THEN GOSUB DispXfers:GOTO EDU0
  IF i$=CHR$(3) THEN EXIT FOR
  IF LEN(i$) < ufl(ix) THEN
   Tout lod$+"short. (Minimum length ="+STR$(ufl(ix))+""
   GOTO EDU0
  END IF
  ufe$(ix)=i$
 NEXT
 IF ab THEN GOTO UFEDITOR
EDU1:
 Prompt ok$
 gyn=True
 GOSUB GETYNA
 IF no THEN GOTO EditUF
 IF abort THEN GOTO UFEDITOR
 Prompt r$+"Resaving "+ufe$(1)+"'s edited userfile... "
 OpnUsr
  FOR ix=1 TO ub
   PRINT #2,ufe$(ix)
   IF ufe$(1)=ufo$(1) THEN
    ufo$(ix)=ufe$(ix)
    nam$=ufo$(1)
    lv1$=ufo$(9)
    lv2$=ufo$(10)
    totl=VAL(ufo$(17))
   END IF
  NEXT
  IF INSTR(lv1$,"8") THEN tlim=120
  FOR ix=1 TO 26
   PRINT #2,uhm$(ix)
  NEXT
  PUT #2,i
 CLOSE #2
 Tout ""
 OPEN "SORTUF.FLG" FOR OUTPUT AS #2
 CLOSE #2
GOTO UFEDITOR

DelUsr:
 IF (ufe$(1)="") AND (i=0) THEN
  Tout r$+"You must find & display a userfile first."
  GOTO UFEDITOR
 END IF
 Prompt r$+"Delete "+ufe$(1)+"'s Userfile"+yn$
 gyn=True
 GOSUB GETYNA
 IF no OR abort THEN GOTO UFEDITOR
 Prompt r$+"Deleting Userfile #"+STR$(i)
 OpnUsr
  FOR ix=1 TO 50
   PRINT #2,s$
  NEXT
  PUT #2,i
 CLOSE #2
 b$=MID$(STR$(i),2)
 b$=STRING$(4-LEN(b$),"0")+b$
 KILL Cfg$(5)+"\"+b$+".*"
 Tout ""
 OPEN "SORTUF.FLG" FOR OUTPUT AS #2
 CLOSE #2
GOTO UFEDITOR

DispBases:
 Tout "":s=0
 FOR x=1 to 26
  IF mb$(x) <> "NA" THEN
    Prompt SPACE$(s)+Ansi$(5)+"["+CHR$(64+x)+"]"+s$+mb$(x)
    IF s=0 THEN s=30-LEN(mb$(x)) ELSE Tout "":s=0
  END IF
 NEXT
 FOR x=1 to 9
  Prompt SPACE$(s)+Ansi$(6)+"["+CHR$(48+x)+"]"+s$+mblv$(x)
  IF s=0 THEN s=30-LEN(mblv$(x)) ELSE Tout "":s=0
 NEXT
 IF s THEN Tout r$
RETURN

'*** TRANSFER FILE EDITOR ***

XFEditor:
 CLOSE #2
 inx=False
 xall=False
 nd=0
 cf=0
 ff=0
 hdr=0
 IF dl=0 THEN GOSUB SetXfer
 GOTO XFM1
XFM0:
 fi$="XEM"+ans$
 GOSUB OUTFILE
XFM1:
 CmdTime
 Prompt r$+ct$+"XFILE EDITOR ["+dl$(dl)+"]: "
 GOSUB GETKEY
 IF chat THEN GOSUB SYSCHAT:GOTO XFEditor
 SELECT CASE i$
 CASE="?"
  GOTO XFM0
 CASE="+"
  GOSUB IncXfer
  GOTO XFEditor
 CASE="-"
  GOSUB DecXfer
  GOTO XFEditor
 CASE="A"
  GOTO AddXF
 CASE="D"
  GOTO DelXF
 CASE="E"
  GOTO EditXF
 CASE="F"
  GOTO SrchXF
 CASE="L"
  p=1
  GOSUB DLDir
  GOTO XFEditor
 CASE="M","Q"
  GOTO SysMenu
 CASE="N",""
  Tout ""
  INCR i
  GOSUB DispXF
  GOTO XFEditor
 CASE="O"
  Tout ""
  GOSUB DispXF
  GOTO XFEditor
 CASE="P"
  Tout ""
  DECR i
  GOSUB DispXF
  GOTO XFEditor
 CASE="S"
  GOSUB SetXfer
  i=0
  GOTO XFEditor
 CASE="V"
  GOSUB MoveFile
  GOTO Xfeditor
 CASE="X"
  fi$=xp$(dl)+"\*.*"
  GOSUB Dir
  GOTO XFeditor
 CASE ELSE
  BadCmd
 END SELECT
GOTO XFEditor

FindEmpXF:
 OpnXfer
  i=(LOF(2)\128)+1
 CLOSE #2
RETURN

AddXF:
 GOSUB FindEmpXF
 xfe$(1)=""
 Tout r$+Ansi$(6)+"Add File - "+dl$(dl)+" Section - Xferfile #"+STR$(i)+r$
 nq=1
 abort=0
 FOR ix=1 TO 6
ADX0:
  IF ix=6 THEN
   Prompt Ansi$(3)+SPACE$(9)+"Min length > *"+STRING$(29,"-")
   Tout "* < Max length."
  END IF
  Prompt Ansi$(2)+xff$(ix)
  ac=1
  IF ix=6 THEN ac=False
  IF ix=1 THEN pw=4
  IF ix=2 THEN
   fi$=xp$(dl)+"\"+xfe$(1)
   oops=0
   OPEN fi$ FOR INPUT AS #2
    IF oops=0 THEN ww$=MID$(STR$(LOF(2)),2)
   CLOSE #2
  END IF
  IF ix=3 THEN CvtDate:ww$=da$
  IF ix=4 THEN ww$=sy$
  IF ix=5 THEN ww$="0"
  tl=xfu(ix)
  GOSUB GETLINE
  i$=fnss$(i$)
  a$=""
  IF LEN(i$)=0 THEN abort=1:EXIT FOR
  IF LEN(i$) < xfl(ix) THEN
   Tout Ansi$(1)+lod$+"short. (Minimum length ="+STR$(xfl(ix))
   GOTO ADX0
  END IF
  xfe$(ix)=i$
 NEXT
 IF abort THEN GOTO XFEditor
ADX1:
 Prompt ok$
 gyn=True
 GOSUB GETYNA
 IF no THEN GOTO AddXF
 IF abort THEN GOTO XFEditor
 Prompt r$+Ansi$(5)+"Adding "+xfe$(1)+" to xferfiles... "
 OpnXfer
  FOR ix=1 TO 6
   PRINT #2,xfe$(ix)
 NEXT
 PUT #2,i
 CLOSE #2
 Tout ""
GOTO XFEditor

SrchXF:
 a$=r$+"Find & Display Xferfile"+r2$+Ansi$(2)+"Enter Filename: "
 Prompt a$
 ac=True
 pw=4
 GOSUB GETLINE
 IF LEN(i$)=0 THEN GOTO XFEditor
 i$=UCASE$(i$)
 Prompt r$+Ansi$(6)+"Searching..."
 OpnXfer
  GET #2,1:a$=""
  WHILE NOT EOF(2) AND i$ <> LEFT$(a$,LEN(i$))
   LINE INPUT #2,a$
   a$=UCASE$(a$)
   GET #2
  WEND
 i=LOC(2)-1
 CLOSE #2
 IF i$ <> LEFT$(a$,LEN(i$)) THEN
  Tout Ansi$(1)+"Xferfile does not exist."
  GOTO XFEditor
 END IF
 FOR ix=1 TO LEN("Searching...")
  IF NOT lm THEN PRINT #1,bs$;
  PRINT #9,del$;
 NEXT
 GOSUB DispXF
GOTO XFEditor

DispXF:
 OpnXfer
  IF i < 1 THEN i=LOF(2)\128:IF i=0 THEN i=1
  IF i > LOF(2)\128 THEN i=1
  Prompt Ansi$(6)+dl$(dl)+" Section"
  Tout " - Xferfile #"+STR$(i)+r$
  GET #2,i
  IF EOF(2) THEN Tout Ansi$(1)+"Non existant xferfile.":xfe$="":GOTO DISX0
  FOR ix=1 TO 6
   LINE INPUT #2,xfe$(ix)
  NEXT
  FOR ix=1 TO 6
   Tout Ansi$(2)+xff$(ix)+Ansi$(7)+xfe$(ix)
  NEXT
DISX0:
 CLOSE #2
RETURN

EditXF:
 IF LEN(xfe$(1)) < 1 THEN GOTO SrchXF
 a$=r$+Ansi$(6)+"Edit Xferfile #"+STR$(i)+" - ENTER leaves the field "
 a$=a$+"unchanged. Ctrl-C will EXIT."+r$
 Tout a$
 FOR ix=1 TO 6
EDX0:
  IF ix=6 THEN
   Prompt Ansi$(6)+SPACE$(9)+"Min length > *"+STRING$(29,"-")
   Tout "* < Max length."
  END IF
  Prompt Ansi$(3)+xff$(ix)
  ww$=xfe$(ix)
  IF ix=1 THEN pw=4
  ac=True
  IF ix=6 THEN ac=False
  tl=xfu(ix)
  GOSUB GETLINE
  a$=""
  ab=0
  IF LEN(i$)=0 THEN ab=True:EXIT FOR
  abort=0
  IF i$=CHR$(3) THEN EXIT FOR
  IF LEN(i$) < xfl(ix) THEN
   Tout Ansi$(1)+lod$+"short. (Minimum length ="+STR$(xfl(ix))+""
   GOTO EDX0
  END IF
  xfe$(ix)=i$
 NEXT
 IF ab THEN GOTO XFEditor
EDX1:
 Prompt ok$
 gyn=True
 GOSUB GETYNA
 IF no THEN GOTO EditXF
 IF abort THEN GOTO XFEditor
 Prompt r$+Ansi$(4)+"Resaving "+xfe$(1)+"'s edited xferfile... "
 OpnXfer
 FOR ix=1 TO 6
  PRINT #2,xfe$(ix)
 NEXT
 PUT #2,i
 CLOSE #2
 Tout ""
GOTO XFEditor

DelXF:
 IF xfe$(1)="" OR i=0 THEN
  Tout r$+Ansi$(16)+"You must first find & display an xferfile."
  GOTO XFEditor
 END IF
 Prompt r$+Ansi$(2)+"Delete "+xfe$(1)+"'s Xferfile"+yn$
 gyn=True
 GOSUB GETYNA
 IF no OR abort THEN GOTO XFEditor
 Prompt r$+Ansi$(1)+"Deleting Xferfile #"+STR$(i)
 OpnXfer
  FOR ix=1 TO 10
   PRINT #2,s$
  NEXT
  PUT #2,i
 CLOSE #2
 Prompt r2$+Ansi$(3)+"Delete "+xfe$(1)+"'s diskfile"+yn$
 gyn=True
 GOSUB GETYNA
 IF no OR abort THEN GOTO XFEditor
 KILL xp$(dl)+"\"+xfe$(1)
GOTO XFEditor

DispXfers:
 Tout "":s=0
 FOR x=1 to 26
  IF dl$(x) <> "NA" THEN
   Prompt SPACE$(s)+Ansi$(6)+"["+CHR$(64+x)+"]"+s$+dl$(x)
   IF s=0 THEN s=30-LEN(dl$(x)) ELSE Tout "":s=0
  END IF
 NEXT
 IF s THEN Tout r$
RETURN

MoveFile:
 Prompt r$+Ansi$(2)+"Move file to which section: "
 GOSUB Getkey
 i$=UCASE$(i$)
 IF i$="?" THEN GOSUB DispXfers:GOTO MoveFile
 IF i$ < "A" OR i$ > "Z" THEN GOTO XFeditor
 Prompt r$+Ansi$(7)+"Moving "+xfe$(1)+" file: "
 c=dl
 d=i
 OpnXfer 'del old entry
  FOR ix=1 TO 6
   PRINT #2,s$
  NEXT
  PUT #2,i
 CLOSE #2
 dl=ASC(i$)-64
 GOSUB FindEmpXF 'add new entry
 OpnXfer
  FOR ix=1 TO 6
   PRINT #2,xfe$(ix)
  NEXT
  PUT #2,i
 CLOSE #2
 PRINT#9,Esc$"s";
 'move file/kill oldfile
 a$=xp$(c)+"\"+xfe$(1)  'oldname/path
 b$=xp$(dl)+"\"+xfe$(1) 'newname/path
 IF LEFT$(a$,2) <> LEFT$(b$,2) THEN
  SHELL "COPY "+a$+" "+b$+" > NUL"
  KILL a$
  ELSE
   NAME a$ AS b$
 END IF
 PRINT#9,Esc$"u";
 Tout Ansi$(5)+" Done."
 dl=c
 i=d
GOTO XFEditor

IncXfer:
 IF dl=26 THEN RETURN
 FOR x=(dl+1) TO 26
  IF (INSTR(lv2$,CHR$(x+64))) AND (dl$(x)<>"NA") THEN dl=x:EXIT FOR
 NEXT
RETURN

DecXfer:
 IF dl=1 THEN RETURN
 FOR x=(dl-1) to 1 STEP - 1
  IF (INSTR(lv2$,CHR$(x+64))) AND (dl$(x)<>"NA") THEN dl=x:EXIT FOR
 NEXT
RETURN

ScreenEditor:
'SED - EBBS Full Screen editor
'Ed Parry
'Started: 12-11-1993
'Updated: 01-05-1994
'EBBS-PC/PB30C

'Integration into EBBS-PC notes:

VideoSeg& = (pbvScrnBuff\65536)

'vars
ab = False
SDel$ = CHR$(29) + s$ + CHR$(29)
Page = 0 'starting page number
WordWrap = False
WrapWord$ = ""

'Print first set of line numbers
GOSUB PrintLineNumbers

'turn crsr on and let em type!
Prompt Ansi$(7)
LOCATE 4, 5, 1, 11, 12
Prompt Esc$+"4;5H"
COLOR 15, 0
CvtTmr
it=ton

SEDMain:
 GOSUB IncTime

 w$=INKEY$
 y$=""

 IF Port > 0 THEN
  IF NOT EOF(1) THEN
   IF LOC(1) THEN y$=INPUT$(1,1)
  END IF
 END IF

 k$=w$+y$

 IF LEN(k$)=0 THEN GOTO SEDMain

 CvtTmr
 it=ton
 k = ASC(k$)
 Flag = 0

 'handle escape key
 IF k=27 THEN
  IF lm THEN GOTO PrintOptions
  'Delay .1
  IF Port>0 THEN
   IF LOC(1)<2 THEN DELAY .1
   IF EOF(1) THEN GOTO PrintOptions
   IF LOC(1) > 1 THEN
    y$=INPUT$(1,1)
    IF y$="[" AND LOC(1) THEN y$=INPUT$(1,1):Flag=ASC(y$)
   END IF
  END IF
 END IF

 'handle ctrl-t (top of screen)
 IF k=20 THEN
  LOCATE 4, 5
  Prompt Esc$+"4;5H"
  Prompt ""
  GOTO SEDMain
 END IF

 'handle ctrl-b (top of screen)
 IF k=2 THEN
  LOCATE 23, 5
  Prompt Esc$+"23;5H"
  Prompt ""
  GOTO SEDMain
 END IF

 'handle pgup/Ctrl-P
 IF k$=CHR$(0, &H49) OR k=16 THEN
  Prompt Esc$+"4;5H"
  LOCATE 4, 5
  k$=CHR$(0, &H48)
 END IF

 'handle crsr up
 IF k$=CHR$(0,&H48) OR k=21 OR Flag=65 THEN
  IF CSRLIN = 4 THEN
   GOSUB DisplayPrevPage
   GOTO SEDMain
  END IF
  IF CSRLIN > 4 THEN
   Prompt Esc$+"1A"
   LOCATE CSRLIN -1
   Prompt ""
   GOTO SEDMain
  END IF
 END IF

 'handle pgdn
 IF k$=CHR$(0,&H51) OR k=14 THEN
  Prompt Esc$+"23;5H"
  LOCATE 23, 5
  k$=CHR$(0, &H50)
 END IF

 'handle crsr down
 IF k$=CHR$(0,&H50) OR k=4 OR Flag=66 THEN
  Row = CSRLIN
  IF Row = 23 THEN
   GOSUB DisplayNextPage
   GOTO SEDMain
  END IF
  IF (Row < 23) AND (Row > 3) THEN
   Prompt Esc$+"1B"
   LOCATE Row +1
   Prompt ""
   GOTO SEDMain
  END IF
 END IF

 'handle crsr left
 IF k$=CHR$(0,&H4B) OR k=12 OR Flag=68 THEN
  c = POS(0)
  r = CSRLIN
  IF c > 5 THEN
   Prompt Esc$+"1D"
   LOCATE , c - 1
   Prompt ""
   GOTO SEDMain
  END IF
 END IF

 'handle crsr right
 IF k$=CHR$(0,&H4D) OR k=18 OR Flag=67 THEN
  Col = POS(0)
  IF Col < 78 THEN
   Prompt Esc$+"1C"
   LOCATE , Col + 1
   Prompt ""
  END IF
  GOTO SEDMain
 END IF

 'handle home
 IF k$=CHR$(0,&H47) OR k=19 OR Flag=72 THEN
  Prompt Esc$+LTRIM$(STR$(CSRLIN))+";5H"
  LOCATE , 5
  Prompt ""
  GOTO SEDMain
 END IF

 'handle end
 IF k$=CHR$(0,&H4F) OR k=5 OR FLag=75 THEN
  GOSUB ReadCurrentLine
  l = LEN(Buffer$)
  Prompt Esc$+LTRIM$(STR$(CSRLIN))+";"+LTRIM$(STR$(l + 5))+"H"
  LOCATE , l + 5
  Prompt ""
  GOTO SEDMain
 END IF

 'handle backspace
 IF k=8 THEN
  IF POS(0) > 5 THEN
   IF NOT lm THEN PRINT #1,bs$;
   PRINT SDel$;
   GOTO SEDMain
  END IF
 END IF

 'handle word wrap
 IF (POS(0) > 75) THEN
  IF Page=4 AND CSRLIN=23 THEN Bell:GOTO SEDMain
  PRINT k$;
  IF NOT lm THEN PRINT #1, k$;
  cl = CSRLIN - 1
  VidOffset = (cl * (80 * 2)) + (POS(0) * 2) - 4
  DEF SEG = VideoSeg&
  'read from crsr pos backwards til we find a space
  FOR x = 0 TO 25
   Char = PEEK(VidOffset - (x * 2))
   IF Char = 32 THEN EXIT FOR 'found our space delimeter
  NEXT x
  'adjust VideoOffset
  VidOffset = VidOffset - (x * 2)
  'set word len (chars to read)
  WordLen = x
  'Read from the last space on the line til EOL
  FOR x = 0 TO WordLen
   Temp(x) = PEEK(VidOffset + (x * 2))
  NEXT x
  Buffer$ = SPACE$(25) 'our 'word to wrap' buffer
  DEF SEG = STRSEG(Buffer$)
  Offset& = STRPTR(Buffer$)
  FOR wc = 0 TO WordLen
   POKE Offset& + wc, Temp(wc)
  NEXT wc
  WrapWord$ = LTRIM$(RTRIM$(Buffer$))
  DEF SEG
  Prompt Esc$+LTRIM$(STR$(CSRLIN))+";"+LTRIM$(STR$(77 - WordLen))+"H"
  LOCATE , 77 - WordLen
  a$=SPACE$(WordLen)
  PRINT a$;
  IF NOT lm THEN PRINT #1,a$;
  WordWrap = True
  k=13
 END IF

 'handle enter key, page wrap & WordWrap
 IF k=13 THEN
  IF CSRLIN = 23 THEN
   GOSUB DisplayNextPage
   ELSE
    Row = CSRLIN + 1
    Prompt Esc$+LTRIM$(STR$(Row))+";5H"
    LOCATE Row, 5
  END IF
  IF WordWrap THEN
   PRINT WrapWord$;
   IF NOT lm THEN PRINT #1, WrapWord$;
   WordWrap = False
   WrapWord$ = ""
  END IF
  GOTO SEDMain
 END IF

 'handle tab key
 IF k=9 THEN
  IF POS(0) < 68 THEN
   Col = POS(0) - 5
   TabLen = 8 - (Col MOD 8)
   Col = Col + TabLen
   Prompt Esc$+LTRIM$(STR$(CSRLIN))+";"+LTRIM$(STR$(Col + 5))+"H"
   LOCATE , Col + 5
   Prompt ""
  END IF
 END IF

 'handle insert key (IE: Each keypress = INSERT a space)
 IF k$=CHR$(0,&H52) or k$=CHR$(0) THEN
  Row = CSRLIN
  Col = POS(0)
  GOSUB ReadCurrentLine
  LinLen = LEN(Buffer$)
  IF LinLen < 73 THEN
   LOCATE Row, Col
   Prompt Esc$+LTRIM$(STR$(Row))+";"+LTRIM$(STR$(Col))+"H"
   Prompt s$+MID$(Buffer$, Col - 4)
   LOCATE Row, Col
   Prompt Esc$+LTRIM$(STR$(Row))+";"+LTRIM$(STR$(Col))+"H"
   ELSE
    Bell
  END IF
 END IF

 'handle delete
 IF k$=CHR$(0, &H53) or k=127 THEN
  Row = CSRLIN
  Col = POS(0)
  GOSUB ReadCurrentLine
  IF Col < 78 THEN
   LOCATE Row, Col
   Prompt Esc$+LTRIM$(STR$(Row))+";"+LTRIM$(STR$(Col))+"H"
   Prompt MID$(Buffer$, Col - 3)+s$
   LOCATE Row, Col
   Prompt Esc$+LTRIM$(STR$(Row))+";"+LTRIM$(STR$(Col))+"H"
  END IF
  k$=""
 END IF

 'handle delete line (Ctrl-Y)
 IF k=25 THEN
  a = CSRLIN
  LOCATE a, 5
  Prompt Esc$+LTRIM$(STR$(a))+";5H"
  Prompt SPACE$(73)
  LOCATE a, 5
  Prompt Esc$+LTRIM$(STR$(a))+";5H"
 END IF

 'print chars
 IF k > 31 THEN
  PRINT k$;
  IF NOT lm THEN PRINT #1, k$;
 END IF

GOTO SEDMain

PrintOptions:
 Row = CSRLIN
 Col = POS(0)
PO1:
 LOCATE 25, 1
 Prompt Esc$+"25;1H"
 Prompt Ansi$(2)+"A)bort, C)ontinue, H)elp, S)ave : "+Ansi$(3)
 ClrBufs
PO2:
 CheckCD
 IF dcd=False THEN RETURN
 GOSUB IncTime
 k$ = INKEY$
 IF Port > 0 THEN
  IF NOT EOF(1) THEN
   IF LOC(1) > 0 THEN
    k$=INPUT$(1,1)
   END IF
  END IF
 END IF
 IF LEN(k$)=0 THEN GOTO PO2:
 k$ = UCASE$(k$)
 SELECT CASE k$
  CASE "A"
   Prompt "A"
   ab = True
   LOCATE ,,0
   Tout r$+ab$
   RETURN
  CASE "C"
   Prompt "C"
   Hrow = Row
   Hcol = Col
   GOTO ContinueInput
  CASE "H"
   Prompt "H"
   Hrow = Row
   Hcol = Col
   GOSUB ReadCurrentPage
   GOSUB PrintHelp
   GOSUB PrintLineNumbers
   GOSUB PrintPageData
   Row = Hrow
   Col = Hcol
   GOTO ContinueInput
  CASE "S"
   Prompt "S"
   LOCATE ,,0
   GOTO SaveText
  CASE ELSE
   Bell
 END SELECT
GOTO PO1

'*** SED Sub Routines ***

ContinueInput:
LOCATE 25, 1
Prompt Esc$+"25;1H"
Prompt SPACE$(50)
LOCATE Row, Col
Prompt Esc$+LTRIM$(STR$(Row))+";"+LTRIM$(STR$(Col))+"H"
GOTO SEDMain

PrintLineNumbers:
ClrScrn
GOSUB PrintHeaderInfo
Prompt Ansi$(3)
li = (Page * 20) + 1 '1, 21, 41, etc.
LOCATE 4, 1
Prompt Esc$+"4;1H"
FOR li = li TO li + 19
 a$ = SPACE$(2) + STR$(li) + ": "
 Tout RIGHT$(a$, 4)
NEXT li
LOCATE 4, 5
Prompt Esc$+"4;5H"
RETURN

DisplayNextPage:
GOSUB ReadCurrentPage
Page = Page + 1
IF Page = 5 THEN
 Bell
 Page = 4
 GOTO DNPExit
END IF
GOSUB PrintLineNumbers
GOSUB PrintPageData
DNPExit:
RETURN

DisplayPrevPage:
GOSUB ReadCurrentPage
Page = Page - 1
IF Page < 0 THEN
 Bell
 Page = 0
 GOTO DPPExit
END IF
GOSUB PrintLineNumbers
GOSUB PrintPageData
LOCATE 23, 5
Prompt Esc$+"23;5H"
DPPExit:
RETURN

ReadCurrentPage:
x = (Page * 20) + 1
FOR li = 1 TO 20 'read all 20 lines from screen
 b = li + 3
 'starting video offset for each line
 VidOffset = ((b - 1) * (80 * 2)) + 8
 DEF SEG = VideoSeg&
 'read each line from screen
 FOR rl = 0 TO 72 'only read ascii bytes, not attributes
  Temp(rl) = PEEK(VidOffset + (rl * 2))
 NEXT rl
 'directly writes changes to buffer$ var
 Buffer$ = SPACE$(75)
 DEF SEG = STRSEG(Buffer$)
 Offset& = STRPTR(Buffer$)
 FOR wc = 0 TO 72
  POKE Offset& + wc, Temp(wc)
 NEXT wc
 Text$(x) = RTRIM$(Buffer$)
 x = x + 1
NEXT li
DEF SEG
RETURN

PrintPageData:
x = (Page * 20) + 1
Row = 3
'COLOR 15, 0
Prompt Ansi$(7)
FOR li = 1 TO 20
 LOCATE Row + li, 5
 Prompt Esc$+LTRIM$(STR$(Row + li))+";5H"
 IF Text$(x) > CHR$(0) THEN Prompt Text$(x)
 x = x + 1
NEXT li
LOCATE 4, 5
Prompt Esc$+"4;5H"
RETURN

ReadCurrentLine:
b = CSRLIN
'starting video offset for each line
VidOffset = ((b - 1) * (80 * 2)) + 8
DEF SEG = VideoSeg&
'read each line from screen
FOR rl = 0 TO 72 'only read ascii bytes, not attributes
 Temp(rl) = PEEK(VidOffset + (rl * 2))
NEXT rl
'directly writes changes to buffer$ var
Buffer$ = SPACE$(75)
DEF SEG = STRSEG(Buffer$)
Offset& = STRPTR(Buffer$)
FOR wc = 0 TO 72
 POKE Offset& + wc, Temp(wc)
NEXT wc
Buffer$ = RTRIM$(Buffer$)
DEF SEG
RETURN

PrintHeaderInfo:
Prompt Ansi$(6)
LOCATE 24, 8
Prompt Esc$+"24;8H"
Prompt "    EBBS Screen Editor v1.0 - 100 Lines Max - ESCape to Exit  "
Prompt Ansi$(5)
Prompt Esc$+"2;5H"+"TO : "
Prompt Ansi$(7)+tc$
Prompt Esc$+"2;35H"
Prompt Ansi$(5)+"SUBJECT: "
Prompt Ansi$(7)+LEFT$(su$,35)
RETURN

SaveText:
GOSUB ReadCurrentPage
FOR i = 1 TO 100
 IF Text$(i) > "" THEN MaxLine = i
NEXT i
IF MaxLine = 0 THEN Bell: ab = True: RETURN
FOR i=1 TO MaxLine
 IF Text$(i) = "" THEN Text$(i)=s$
NEXT i
ll=MaxLine
Tout ""
RETURN

PrintHelp:
ClrScrn
Prompt Ansi$(6)
Tout r$+"EBBS Screen Editor Command Help"+r$
Prompt Ansi$(7)
Tout "CRSR Control Keys OR: Ctrl-U = CrsrUp,   Ctrl-D = Crsr Down"
Tout "                      Ctrl-L = CrsrLeft, Ctrl-R = CrsrRight"
Tout "CTRL-Y : Deletes the entire current line and home's the cursor."
Tout "HOME/Ctrl-S: Cursor to the start of current line."
Tout "END/Ctrl-E: Cursor to the end of the current line."
Tout "CTRL-T: Cursor to the top line of the current page."
Tout "CTRL-B: Cursor to the bottom line of the current page."
Tout "PGUP/Ctrl-P: Display the Previous screen page."
Tout "PGDN/Ctrl-N: Display the Next screen page."
Tout "ESCape: Exit screen editor to command prompt: Save, Abort or Continue."
Tout "BACKSPACE: Delete the character to the left of the cursor."
Tout "DELete: Delete one character at the current cursor position."
Tout "INSert: Insert one space at the current cursor position."
Tout "NEXT PAGE WRAP: Occurs automatically at the end of the page."
Tout "PREV PAGE WRAP: Occurs automatically at the top of the page."
Tout "OVERSTRIKE Mode is ALWAYS on."
Tout "INSERT typing mode is NOT supported."
Tout "Word Wrap occurs at column 78."
Tout "Word Wrap does not insert text on next line, it overwrites it."+r$
Prompt Ansi$(1)
Prompt "PRESS [ENTER] TO RESUME EDITING."
GOSUB GetKey
Prompt Ansi$(7)
RETURN
