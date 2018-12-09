100   ON ERROR GOTO 8020:DEFSTR A-D:DEFINT E-Z:DIM A(1000):DL=STRING$(79,205)
110   'Line 100 is a copy of line 4985 to satisfy the BASIC Compiler - T.Hall 7-20-83
120   '          D. MCCOY - 05/07/83
140   GOTO 4980
160   '-------------------- SUBROUTINES -----------------------
200   K$=INKEY$:IF K$="" THEN PRINT "      ";CHR$(221);BS;BS;BS;BS;BS;BS;BS;:GOTO 200
220   RETURN
230   K$=INKEY$:RETURN
240   '-------------------- INKEY$ AND CONVERT TO UPPER CASE----
260   PRINT " --> ";
280   K$=INKEY$:IF K$="" THEN 280
300   IF ASC(K$)>96 AND ASC(K$)<123 THEN K$=CHR$(ASC(K$)-32)
320   PRINT K$:RETURN
340   '-------------------- DISPLAY FULL LINE -----------------
360   PRINT USING B;NL;:PRINT A(NL):RETURN
380   '-------------------- DISPLAY INDENTED LINE ------------
400   LD=INT(LEN(A(NL))/73):FOR J=0 TO LD
420   IF J=0 THEN PRINT USING B4;NL,MID$(A(NL),1,72) ELSE PRINT USING B3;MID$(A(NL),J*72+1,72)
440   NEXT:RETURN
460   '------------------- EDIT SUBROUTINE --------------------
480   LA=LEN(A(NL)):PRINT "EDIT->";CHR$(221);
500   FOR I=1 TO LA
540     K1$=INKEY$:IF K1$="" THEN PRINT CHR$(95);BS;:GOTO 540
560     IF ASC(K1$)>96 AND ASC(K1$)<123 THEN K1$=CHR$(ASC(K1$)-32)
580     IF ASC(K1$)=8 AND I>1 THEN 1100        'BACKSPACE
600     IF ASC(K1$)=13 THEN 1560               'ENTER
620     IF K1$=" " THEN 1020     'space bar
640     IF K1$="I" THEN 1420     'insert mode
660     IF K1$="C" THEN 1240     'change char
680     IF K1$="D" THEN 1360     'delete char
700     IF K1$="X" THEN 1560     'list line & insert
720     IF K1$="H" THEN 1680     'hack & insert
740     IF K1$="S" THEN 1720     'search for char
760     IF K1$="Q" THEN 900      'abort changes & return
770     IF K1$="?" THEN 910      'abort changes, help & return
780     IF ASC(K1$)<48 OR ASC(K1$)>57 THEN 820     'number key
800     IF LEN(K5$)<3 THEN K5$=K5$+K1$:K5=VAL(K5$)
820     GOTO 540
840     K5$="":K5=0
860   NEXT I
880   A(NL)=AN
900   RETURN
908   '          HELP EDIT
910   PRINT:GOSUB 1924:AN="":GOSUB 400:GOTO 480
920   '          SET K5 PARAMETERS
940   IF K5>(LA-I+1) THEN K5=LA-I+1
960   IF K5<1 THEN K5=1
980   RETURN
1000   '          SPACEBAR
1020   GOSUB 940
1040   AN=AN+MID$(A(NL),I,K5):PRINT MID$(A(NL),I,K5);:I=I+K5-1
1060   FOR J=1 TO 80:NEXT J:GOTO 840
1080   '          BACKSPACE
1100   GOSUB 940:FOR J=1 TO K5
1160   IF LEN(AN)>0 THEN AN=LEFT$(AN,LEN(AN)-1)
1180   IF I>1 THEN I=I-1:PRINT BS;
1200   NEXT J:K5=0:K5$="":GOTO 540
1220   '           C EDIT
1240   GOSUB 940  :FOR J=1 TO K5
1260   K2$=INKEY$:IF K2$="" THEN PRINT CHR$(223);BS;:GOTO 1260
1280   AN=AN+K2$:PRINT K2$;:I=I+1
1300   NEXT J:I=I-1:K1$=""
1320   GOTO 840
1340   '          D EDIT
1360   GOSUB 940
1380   FOR J=1 TO K5:PRINT CHR$(219);:NEXT J:I=I+J-2:GOTO 840
1400   '          I EDIT
1420   K3$=INKEY$:IF K3$=""THEN PRINT CHR$(220);BS;:GOTO 1420
1440   IF ASC(K3$)=27 THEN I=I-1:GOTO 840
1460   IF ASC(K3$)=13 THEN 1560        'TO X EDIT
1480   IF ASC(K3$)= 8 THEN AN=LEFT$(AN,LEN(AN)-1):PRINT BS;:GOTO 1530
1500   AN=AN+K3$
1520   PRINT K3$;
1530   GOTO 1420
1540   '          X EDIT
1560   GOSUB 940
1562   IF I=1 THEN 1580
1564   IF I>LA THEN 1620
1566   IF I<1 THEN 1620
1568   IF I>255 THEN 1620
1580   K5=LA-I+1:IF K5<0 THEN 1620
1600   AM=MID$(A(NL),I,K5):AN=AN+AM:PRINT AM;:I=I+K5:K5=0:K5$=""
1620   IF ASC(K1$)=13 OR ASC(K3$)=13 THEN K1$=" ":K3$=" ":GOTO 880
1640   GOTO 1420
1660   '          H EDIT
1680   I=LA+1:GOTO 1420
1700   '          SEARCH FOR CHAR
1720   K4$=INKEY$:IF K4$="" THEN 1720
1740   K6=0:K7=I+1:GOSUB 940:FOR J=1 TO K5
1760   K6=INSTR(K7,A(NL),K4$)
1780   IF K6>0 THEN K7=K6+1
1800   NEXT J:K5=0:K5$=""
1820   IF K6<1 THEN K6=LA+1
1840   L3=K6-I:IF L3<0 THEN L3=0
1860   AM=MID$(A(NL),I,L3):AN=AN+AM:PRINT AM;:I=I+L3
1880   IF I<LA+1 THEN 540
1900   AN=AN+MID$(A(NL),I,1):PRINT MID$(A(NL),I,1);:GOTO 880
1920   '--------------------- HELP MENUS -----------------------
1922   '--------------------- EDIT MENU ------------------------
1924   PRINT DL:PRINT"    EDIT Subcommands:        nC=Change    n<Spacebar>=Copy Character(s)"
1926   PRINT"        H=Hack & Insert      nD=Delete    n(<--)=Backspace(s)"
1928   PRINT"        X=List & Insert      I=Insert     <Esc>=Insert OFF"
1929   PRINT"        Q=Quit No Changes    ?=Help       <Enter>=End Edit Save Changes"
1930   PRINT"        nSc=Search for Nth occurance of Character c"
1931   PRINT DL:RETURN
1932   PRINT B2;"EDIT:   n<C>  n<D>  <H>  <I>  <Q>  n<S>c  <X>  n< >  <Esc>  <?>":RETURN
1940   '--------------------- COMMANDS -------------------------
1960   PRINT DL
1980   PRINT"    Commands:       A=Add         F=Find      K=Memory      P=Print"
2000   PRINT"        R=Replace   S=Save        X=eXit      &=Merge       ?=Help"
2020   PRINT"        Cn=Copy n   Dn=Delete n   En=Edit n   In=Insert n   Ln=List n"
2040   PRINT DL:RETURN
2060   '-------------------- LIST SUBCOMMANDS ------------------
2100   PRINT DL:PRINT "    LIST Subcommands:"TAB(39)"/=Commands                 X=eXit"
2120   PRINT"<Up Arrow>=Scroll backward    <Left Arrow>=First line   ?=Help       <PgUp>"
2140   PRINT"<Down Arrow>=Scroll forward   <Right Arrow>=Last line   <Home>=CLS   <PgDn>"
2155   PRINT DL:RETURN
2160   '--------------------- MESSAGE DELAY -------------------
2180   FOR J=1 TO 1000:NEXT:RETURN
2200   '---------------------- COMMAND LINE PROCESSOR ---------
2240   GOSUB 1960       'HELP MENUS
2260   IF NL>LN THEN NL=LN
2270   PRINT B2;"Lines are numbered 1 to";LN;TAB(43)"Current line #";NL
2280   PRINT B2;"(A,F,K,P,R,S,X,&,? or Cn,Dn,En,In,Ln)  Command : ";
2300   LINE INPUT K3$:IF K3$="" OR LEN(K3$)>4 THEN 2260
2320   K$=LEFT$(K3$,1):IF ASC(K$)>96 AND ASC(K$)<123 THEN K$=CHR$(ASC(K$)-32)
2340   NM=NL:NL=VAL(MID$(K3$,2,3)):IF NL=0 THEN NL=NM
2360   IF LN<1 AND K3$<>"X" AND K3$<>"?" THEN 2920
2380   IF NL>LN THEN NL=LN
2400   KM$=K$:KN=INSTR("ACDEFKILPRSX&?",K$)
2420   ON KN GOTO 2920 ,4420 ,4560 ,4700 ,3080 ,7000,4760 ,2480 ,5500  ,3220 ,5780  ,5920  ,5240
2440   GOTO 2240
2460   '-------------------- LIST -----------------------------
2480   PRINT B2;"LIST: Arrw keys  /=Commnds  X=eXit  ?=Help  <Home>=CLS  <PgUp>  <PgDn>"
2500   GOSUB 400
2520   GOSUB 200
2560   IF K$="?" THEN GOSUB 2100 :GOSUB 400   '? HELP
2580   IF G3=128 AND G4=2 THEN GOSUB 2100 :GOSUB 400   '? HELP/R
2600   IF K$="X" OR K$="x" THEN GOSUB 230:GOTO 2240     'X EXIT
2620   IF K$="/" THEN GOSUB 230:GOTO 2260     '/ EXIT
2630   IF LEN(K$)=2 THEN K=ASC(RIGHT$(K$,1)) ELSE K=0
2640   IF K=71 THEN CLS:GOTO 2480
2660   IF K<>80 THEN 2680
2670   IF NL<LN THEN NL=NL+1:GOSUB 400 ELSE GOSUB 2100:NL=1:GOSUB 400
2680   IF K<>72 THEN 2700
2690   IF NL>1 THEN NL=NL-1:GOSUB 400 ELSE GOSUB 2100:NL=LN:GOSUB 400
2700   IF K=75 THEN NL=1:GOTO 2500
2720   IF K=77 THEN NL=LN:GOTO 2500
2730   IF K<>81 THEN 2790
2735   IF NL<LN THEN LO=NL+1
2740   HI=LO+19:IF HI>LN THEN HI=LN
2750   FOR NL=LO TO HI-1
2770     GOSUB 400
2780   NEXT NL:GOSUB 400
2790   IF K<>73 THEN 2880
2795   IF NL>1 THEN HI=NL-1
2800   LO=NL-19:IF LO<2 THEN LO=2
2810   FOR NL=HI TO LO STEP-1
2830     GOSUB 400
2840   NEXT NL:GOSUB 400
2880   GOTO 2520
2900   '---------------------- ADD NEW LINES ------------------
2920   IF LN>1 THEN NL=LN-1:GOSUB 400
2940   IF LN>0 THEN NL=LN:GOSUB 400 ELSE CLS:PRINT "To create a new file:"
2960   PRINT B2;"ADD new lines below (Blank Line to END)"
2980   IF LN>998 THEN PRINT B2;"*** LINES FULL ***":GOTO 2260
3000   LN=LN+1:PRINT USING B;LN;
3020   LINE INPUT A(LN):IF A(LN)="" THEN LN=LN-1:NL=LN:GOTO 2260
3040   GOTO 2980
3060   '-------------------- FIND/SEARCH ----------------------
3080   PRINT B2;:LINE INPUT"Enter search string to FIND : ";S2$:IK=0
3100   FOR NL=1 TO LN
3120     IJ=INSTR(A(NL),S2$)
3140     IF IJ>0 THEN GOSUB 400  :IK=IK+1
3160     IF IK=5 THEN IK=0:PRINT B2;"X=eXit.    Any key to continue ";:GOSUB 260  :IK=0:IF K$="X" THEN 2260
3180   NEXT:GOTO 2260
3200   '-------------------- REPLACE CHAR/STRING --------------
3220   PRINT DL:PRINT"REPLACE: A=ASCII Code #   S=String   V=View Current Line #";NL
3240   PRINT"         C=Convert UC to LC if in quotes          X=eXit":PRINT DL
3260   PRINT B2;"Selection";:GOSUB 260
3280   IF K$="S" THEN 3760
3300   IF K$="C" THEN 4140
3310   IF K$="V" THEN 4382
3320   IF K$<>"A" THEN 2260
3340   KN$=K$:CLS:FOR J=32 TO 255:PRINT USING "### = ! ";J,CHR$(J);:NEXT:PRINT
3360   INPUT"Enter ASCII code number to be REPLACED (0-255): ";S2
3380   IF S2<0 OR S2>255 THEN CLS:GOTO 2240
3400   INPUT "Enter ASCII code number of replacement character (0-255): ";S3
3420   IF S3<0 OR S3>255 THEN CLS:GOTO 2240
3440   S3$=CHR$(S3):S2$=CHR$(S2)
3460   PRINT"Prompt for each change (Y/N)? ";:GOSUB 260
3480   KM$=K$:IF KM$<>"Y" THEN KM$="N"
3500   CLS:FOR NL=1 TO LN:JJ=1
3520     IF LEN(A(NL))<1 THEN 3700
3540     IJ=INSTR(JJ,A(NL),S2$):JJ=IJ+1
3560     IF IJ<1 THEN 3700
3580     IF KM$="N" THEN 3680    'no prompting
3600     GOSUB 360  :PRINT TAB(IJ+7);CHR$(94)
3620     PRINT "Replace (Y/N or X=eXit) ? ";:GOSUB 260:CLS
3640     IF K$="X" THEN 3720
3660     IF K$<>"Y" THEN IF IJ<LEN(A(NL)) THEN 3540 ELSE 3700
3680     MID$(A(NL),IJ)=S3$
3685     IF KM$="N" THEN GOSUB 360
3688     GOTO 3540
3700   NEXT
3720   GOTO 2240
3740   '         REPLACE STRING
3760   PRINT B2;:LINE INPUT "Enter string to be REPLACED : ";B1:IF B1="" THEN 3760
3780   PRINT B2;:LINE INPUT "Enter new text of replacement string : ";C1$
3800   PRINT B2;"Prompt for each change (Y/N)?";:GOSUB 260
3820   IF K$="Y" THEN KM$="Y" ELSE KM$="N"
3840   CLS:P=0:FOR NL=1 TO LN
3860     P=INSTR(P+1,A(NL),B1) : IF P<1 THEN 4100
3880     IF KM$="N" THEN 3980
3900     GOSUB 360
3920     PRINT TAB(P+7) CHR$(94)
3940     PRINT "Replace (Y/N/X)?";:GOSUB 260:CLS:IF K$="X" THEN 2240
3960     IF K$<>"Y" THEN P=P+LEN(B1)-1:GOTO 3860
3980     A1$=LEFT$(A(NL),P-1)
4000     L1=LEN(A(NL))-LEN(A1$)-LEN(B1)
4020     A2$=RIGHT$(A(NL),L1)
4040     A(NL)=A1$+C1$+A2$
4060     IF KM$="N" THEN GOSUB 360
4080     GOTO 3860
4100   NEXT:GOTO 2240
4120   '-------------------- U/C TO L/C -----------------------
4140   CLS:FOR NL=1 TO LN:P=1
4160   IJ=INSTR(P,A(NL),CHR$(34)):IF IJ<1 THEN 4360
4180   IK=INSTR(IJ+1,A(NL),CHR$(34)):IF IK<1 THEN IK=LEN(A(NL))
4200   FOR I=IJ+2 TO IK
4220    X$=MID$(A(NL),I,1):IF X$="" THEN 4320
4240    Y$=MID$(A(NL),I-1,1):IF Y$="=" OR Y$=" "THEN 4320
4260    IF ASC(X$)<65 OR ASC(X$)>90 THEN 4320
4280    X$=CHR$(ASC(X$)+32)
4300    MID$(A(NL),I,1)=X$
4320   NEXT I:GOSUB 400
4340   P=I:GOTO 4160
4344   X$=MID$(A(NL),I,1):PRINT USING "! = ### ";X$,ASC(X$);
4360   NEXT NL
4380   GOTO 2240
4381   '-------------------- VERYIFY ASCII CODES -------------
4382   CLS:NA=LEN(A(NL)):IF NA<1 THEN 4398 ELSE N2=NA/20
4383   FOR J=0 TO N2:N3=J*20+1:N4=N3+19
4384   FOR I=N3 TO N4
4386   IF I<=NA THEN PRINT USING " !  ";MID$(A(NL),I,1);
4388   NEXT I:IF I=>NA THEN PRINT
4390   FOR I=N3 TO N4
4392   IF I<=NA THEN PRINT USING "### ";ASC(MID$(A(NL),I,1));
4394   NEXT I:IF I=>NA THEN PRINT
4395   IF (J+1)/4-INT((J+1)/4)=0 AND I<NA THEN PRINT"Press any key to continue";:GOSUB 260
4396   NEXT J:PRINT
4398   GOTO 2240
4400   '--------------------- COPY LINE -----------------------
4420   NI$="":GOSUB 400  :PRINT B2;:PRINT"COPY  (X=Exit)  Line # to INSERT AFTER:";LC+1;:INPUT NI$
4440   NI=VAL(NI$):IF NI$="X" OR NI$="x" OR NI<0 OR NI>LN THEN 2260  ELSE A(0)=A(NL)
4445   IF NI=0 THEN NI=LC+1
4460   LC=NI:IF LC>998 THEN PRINT B2;"*** LINES FULL ***":GOTO 2260
4480   PRINT B2;"Working...*** Any Higher Line # Increased by 1 ***"
4500   FOR J=LN TO LC+1 STEP -1:A(J+1)=A(J):NEXT J:LN=LN+1:A(LC+1)=A(0)
4520   IF LC+1>NL THEN NL=NL+1:IF NL>LN THEN NL=LN
4522   IF LC+1<NL THEN NL=NL+2:IF NL>LN THEN NL=LN
4525   NM=NL:NL=LC+1:GOSUB 400:NL=NM
4530   GOTO 2260
4540   '--------------------- DELETE --------------------------
4560   GOSUB 400  :PRINT B2;"DELETE...Are you sure (Y/N)? ";:GOSUB 260
4580   IF K$<>"Y" THEN NL=NL+1:GOTO 2260
4600   IF NL>999 THEN PRINT B2;"*** UNABLE TO DELETE ***":GOTO 2260
4620   PRINT B2;"Working...*** Any Higher Line # Decreased by 1 ***"
4640   FOR J=NL TO LN-1:A(J)=A(J+1):NEXT:LN=LN-1:IF NL>LN THEN NL=LN
4660   GOSUB 400:GOTO 2260
4680   '---------------------- EDIT ---------------------------
4700   GOSUB 1932:GOSUB 400  :AN="":GOSUB 480  :AN="":PRINT:GOSUB 400:NL=NL+1:GOTO 2260
4740   '-------------------- INSERT ---------------------------
4760   IF NL>0 THEN GOSUB 400
4780   PRINT USING B;NL+1;:LINE INPUT A(0)
4800   IF LN>998 THEN PRINT B2;"*** LINES FULL ***":GOTO 2260
4820   PRINT B2;"Working...*** Any Higher Line # Increased by 1 ***"
4840   FOR J=LN TO NL+1 STEP-1:A(J+1)=A(J):NEXT:LN=LN+1:A(NL+1)=A(0)
4860   NL=NL+1:IF NL>LN THEN NL=1
4880   GOSUB 400:GOTO 2260
4900   '-------------------------------------------------------
4920   ' D. MCCOY 03/25/83
4960   '-------------------- INITIALIZE -----------------------
4980   CLS:PRINT TAB(11)"ET - Edit Text - IBM PC File Editor"
4985   'ON ERROR GOTO 8020:DEFSTR A-D:DEFINT E-Z:DIM A(999+1):DL=STRING$(79,205
5000   PRINT TAB(11)"Vers. 3.4     D. McCoy      70040,1131":PRINT DL
5020   PRINT"      This program is designed to edit ASCII text files."
5040   PRINT"      BASIC programs must be saved in the ,A ASCII"
5060   PRINT"      format for editing."
5070   PRINT DL
5120   B=CHR$(91)+"###"+CHR$(93)+CHR$(32)+CHR$(221)
5130   B2="      "+CHR$(221)+CHR$(219)+" "
5140   B3="      "+CHR$(221)+"\                                                                      \"
5160   B4=B+"\                                                                      \"
5180   BS=CHR$(29)+CHR$(32)+CHR$(29)
5200   '---------------------- LOAD TEXT FILE -----------------
5240   IF K$="&" THEN PRINT B2;"To MERGE another file -"
5260   PRINT B2;"Enter the filespec of the file to be LOADED "
5280   IF KM$="&" THEN PRINT B2;"? = Dir or X to eXit : ";:ELSE PRINT B2;"? = Dir or <Enter> to create a NEW file : ";
5300   LINE INPUT FS$: IF FS$<>"?" THEN 5320
5310   IF FS$="?" THEN PRINT B2;"Which drive (A/B)";:GOSUB 260
5315   IF K$="A" THEN PRINT DL:FILES "A:*.*":PRINT DL:GOTO 5260
5318   IF K$="B" THEN PRINT DL:FILES "B:*.*":PRINT DL:GOTO 5260
5320   IF FS$="" AND KM$<>"&" THEN 2920
5340   IF FS$="" OR FS$="X" OR FS$="x" THEN FS$="":GOTO 5440
5360   OPEN "I",1,FS$
5380   IF EOF(1) THEN CLOSE:GOTO 5440
5400   LN=LN+1:IF LN>999 THEN LN=LN-1:CLOSE:GOTO 5440
5420   LINE INPUT #1,A(LN):LOCATE 6,40:PRINT"Index Line #";LN;:GOTO 5380
5440   NL=1:CLS:GOTO 2240
5480   '--------------------- PRINT ---------------------------
5500   PRINT B2;"Ready printer...":PRINT B2;"X=eXit.  PRINT index line numbers (Y/N)?";:GOSUB 260
5520   IF K$="X" THEN 2260  ELSE IF K$<>"Y" AND K$<>"N" THEN 5500
5540   LO=1:PRINT B2;"Enter LOWEST  line # to print ( 1 to";LN;")";:INPUT LO
5560   IF LO<1 THEN LO=1
5565   IF LO>LN THEN LO=LN
5580   HI=LN:PRINT B2;"Enter HIGHEST line # to print (";LO;"to";LN;")";:INPUT HI
5600   IF HI>LN THEN HI=LN
5610   IF HI<1 THEN HI=LN
5615   IF HI<LO THEN HI=LO
5620   C="<###>  ":PRINT B2;"Printing index lines"LO"to"HI"..."
5640   LPRINT "       "; FS$;TAB(40)LEFT$(TIME$,8):LPRINT
5660   FOR J=LO TO HI
5680     IF K$="Y" THEN LPRINT USING C;J; ELSE LPRINT "       ";
5700     LPRINT A(J)
5720   NEXT
5740   FOR J=1 TO 6 : LPRINT : NEXT:GOTO 2260
5760   '--------------------- SAVE TEXT FILE ------------------
5780   PRINT B2;"Current filespec is: ";FS$
5800   PRINT B2;:LINE INPUT "X=eXit.  New Filespec to SAVE or <Enter>: ";F2$
5820   IF F2$="X" OR F2$="x" THEN 2260
5840   IF F2$<>"" THEN FS$=F2$
5860   OPEN "O",1,FS$
5880   FOR J=1 TO LN:PRINT#1,A(J):NEXT:CLOSE:GOTO 2260
5900   '-------------------- END ------------------------------
5920   PRINT B2; "EXIT...Was text file saved (Y/N)?";:GOSUB 260
5940   IF K$="Y" THEN 5960   ELSE 2260
5960   PRINT B2;"Run again (Y/N)?";:GOSUB 260
5980   IF K$="N" THEN CLEAR 50:END
6000   RUN
6980   '-------------------- MEMORY --------------------------
7000   PRINT B2;"Bytes free space =";FRE(X)
7060   GOTO 2260
8000   '-------------------- ERROR TRAP ------------------------
8020   IF  ERR=53 THEN PRINT B2;"*** File not found ***":GOSUB 2180 :IF ERL=5360  THEN RESUME 5240  ELSE RESUME 5800
8040   IF  ERR=64 THEN PRINT B2; "*** Bad file name ***" :GOSUB 2180 :IF ERL=5360  THEN RESUME 5240  ELSE RESUME 5800
8060   IF  ERR=15 AND ERL=1500 THEN PRINT B2;"*** Line too long ***":GOSUB 2180 :RESUME 880
8080   CLOSE:PRINT B2;"*** Error"; ERR;"in line"ERL" ***":GOSUB 1960 :GOTO 2260
8100   '-------------------- END ------------------------------
