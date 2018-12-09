1 ' GRAFTRAX as a subroutine  3/12/83
9 ' *********** Get some graphics going for this demo *******************
10 DEFINT A-Z
15 KEY OFF : KEY 7,"gosub 65000"+CHR$(13)
20 TOG=2 : GOSUB 65010 ' use color for this demo
30 SCREEN 1,0 :OUT 980,2:OUT 981,45 ' 45 is standard. 43 shifts 2 chars. right
40 COLOR 0,0 : CLS
50 CIRCLE (160,100),50,3 : CIRCLE (160,100),75,3 : PAINT (160,100),1,3 : PAINT(160,40),2,3 ' draw some graphics
55 ' make sure variables used in this routine are defined BEFORE they are used.
56 ' integer variable descriptors, i.e. variable% should be used in this routine if a DEFINT statement is not present. They are here as a r
59 ' ****************** SETUP ***************************
60 X%=0 : Y%=0 : Z%=0 : GRAFTRAX%=0 : GRSEG%=0 : A$="" : DIM STACK%(50),CG%(10)
70 DEF SEG : Y% = VARPTR(CG%(0))
80 FOR X% = 0 TO 17 : READ Z% : POKE X% + Y% ,Z% : NEXT ' poke routine into an  array
85 DEF SEG=0 : X%=PEEK(&H16) : Y%=PEEK(&H17) : DEF SEG : GRSEG%=X%+(256*Y%) '     GRSEG is the location where DOS put GRAFTRAX.COM
90 INPUT "small or LARGE";A$ : A$=LEFT$(A$,1) : IF A$="l" OR A$="L" OR A$="2" THEN X% = 2 ELSE X% = 1
100 ' ******** ACTUAL ROUTINE - use GOSUB, with RETURN at END **********
110 DEF SEG = GRSEG% : POKE &H273,X% : DEF SEG ' &h273 is the location in        GRAFTRAX.COM that sets a default of 1 = small, 2 = LARGE i
120 GRAFTRAX% = VARPTR(CG%(0)) : Y% = VARPTR(STACK%(50)) ' stack builds DOWN.
130 CALL GRAFTRAX%(Y%) : ' y% is actually a temporary stack passed to the CALL,  since BASIC only leaves 16 bytes. INT routines use lots of
140 ' At some times, GRAFTRAX.COM is 34 words deep in the stack!
150 END
1000 DATA &h55,&H8b,&Hec,&H8b,&H76,&H06,&H8b,&H1c,&H8b,&He3,&Hcd,&H05,&H8b,&He5,&H5d,&Hca,&H02,&H00
65000 IF TOG=1 THEN TOG=2 ELSE TOG=1
65010 ON TOG GOSUB 65080, 65030
65020 RETURN
65030 REM toggle color graphics
65040 DEF SEG=0
65050 POKE &H410, (PEEK(&H410) AND &HCF) OR &H10
65060 SCREEN 1,0,0,0: SCREEN 0:WIDTH 40:LOCATE ,,1,6,7
65070 RETURN
65080 REM toggle monochrome display
65090 DEF SEG=0
65100 POKE &H410, (PEEK(&H410) OR &H30)
65110 SCREEN 0:WIDTH 40:WIDTH 80:LOCATE ,,1,12,13
65120 RETURN
