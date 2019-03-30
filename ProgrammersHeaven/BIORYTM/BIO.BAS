01 '
10 '           BIORYTHM.BAS
12 '           original code and algorithms by Patrick Underwood {74066,2112}
16 '           Updated by Ron Forbes {72435,343} for Enhanced Graphics Adapter
17 '           Compiled with Turbo Basic v1.0  5/1/87
18 '
on error goto scrn.9.error
er=0: screen 9,1: line (0,0)-(1,1)
if er=0 then ega.scrn.ok
scrn.9.error:
     cls: locate 5,10: er=1
     print "This program requires an EGA graphics card to run."
     print: print: print "Press any key to continue...."
     do
     if instat then stop
     loop
ega.scrn.ok:
      on error goto 0
30 key off: screen 9: color 0,0 : cls
90 dim MO$(27),MO(27),T(3)
110 BIO$="B i o r h y t h m s": CLR%=8
120 locate 4,1: For M%=1 TO 3: color CLR%+M%: print BIO$: Next M%
130 line (1,95)-(640,95),13,,&H800: color 14
getdate:
on error goto getdate
140 locate 12,08: print "BIRTHDATE   ( ex.:  9 15 73  or  9-15-73 )"
145 locate 12,60: input "",BIR$
150 locate 16,08: print "DATE TO BE CHARTED   <enter> for today's date "
155 locate 16,60: input "",TST$
160 '''''''''''''''''''''''''''''''''''''''''''''
500 '    separate birth input into strings
505 '''''''''''''''''''''''''''''''''''''''''''''
510 M%=0
520 M%=M%+1: A$=mid$(BIR$,M%,1): If asc(A$)<48 or asc(A$)>57 Then 550
530 BMO$=BMO$+A$
540 goto 520
550 M%=M%+1: A$=mid$(BIR$,M%,1): If asc(A$)<48 or asc(A$)>57 Then 580
560 BDA$=BDA$+A$
570 goto 550
580 M%=M%+1: N%=len(BIR$): BYR$=mid$(BIR$,M%,N%)
590 If val(BYR$)<100 Then BYR$=str$(val(BYR$)+1900)
595  '''''''''''''''''''''''''''''''''''''''''''''
1000 '   separate testdate input into strings
1005 '''''''''''''''''''''''''''''''''''''''''''''
1010 If TST$="" Then TST$=DATE$
1015 TMO$="": TDA$=""
1020 M%=0
1030 M%=M%+1: A$=mid$(TST$,M%,1): If asc(A$)<48 or asc(A$)>57 Then 1060
1040 TMO$=TMO$+A$
1050 goto 1030
1060 M%=M%+1: A$=mid$(TST$,M%,1): If asc(A$)<48 or asc(A$)>57 Then 1090
1070 TDA$=TDA$+A$
1080 goto 1060
1090 M%=M%+1: N%=len(TST$): TYR$=mid$(TST$,M%,N%)
1100 If val(TYR$)<100 Then TYR$=str$(val(TYR$)+1900)
1105 ''''''''''''''''''''''''''''''''''''''''''''
1500 '   assign variables equivalent to strings
1505 ''''''''''''''''''''''''''''''''''''''''''''
1510 BMO=val(BMO$): BDA=val(BDA$): BYR=val(BYR$)
1540 TMO=val(TMO$): TDA=val(TDA$): TYR=val(TYR$)
1570 ''''''''''''''''''''''''''''''''''''''''''''
2000 '   assign array of days/months                                                     for regular and leap years
2205 ''''''''''''''''''''''''''''''''''''''''''''
2010 restore
2020 read A$: If A$<>"month" then 2020
2030 For M=0 to 27: read MO$(M),MO(M): next M
2035 '''''''''''''''''''''''''''''''''''''''''''''
2505 '   count days between birth and test dates
2506 '''''''''''''''''''''''''''''''''''''''''''''
2510 If BYR<TYR Then 2580
2520 If BYR>TYR Then 2590
2530 If BMO<TMO Then 2580
2540 If BMO>TMO Then 2590
2550 If BDA<TDA Then 2580
2560 If BDA>TDA Then 2590
2570 DCT=0: goto 3000
2580 LYR=BYR: LMO=BMO: LDA=BDA: MYR=TYR: MMO=TMO: MDA=TDA: SG=+1: DST=0
2585 gosub 3040: goto 2600
2590 LYR=TYR: LMO=TMO: LDA=TDA: MYR=BYR: MMO=BMO: MDA=BDA: SG=-1: DST=0
2595 gosub 3040
2600     If LTT=1  Then DST=DST-1            'correction inserted to fix
2605     If LTT=1 and LMO<3 Then DST=DST+2   'leap year calculations
2608     DCT=DST*SG                          'for total days lived
2700 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
3000 '   count days between test date and reference date (1-1-100),friday                                               reference date (1-1-100),friday
3005 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
3010 If TYR>1752 Then LYR=1752: LMO=9: LDA=14: goto 3030
3020 LYR=100: LMO=1: LDA=1
3030 MYR=TYR: MMO=TMO: MDA=TDA: SG=+1: DST=0
3035 gosub 3040: WDC=DST*SG: goto 5590
3040 CYR=LYR: CMO=LMO
3500 If LYR<>MYR Then 4000                   'sbr count
3510     If LMO=1 Then 3530
3520     For M%=1 TO LMO-1: DA=DA+MO(M%): Next M%
3530     gosub 5000: If (LTT=1) and (LMO<3) Then DA=DA+1
3540     DA=DA+LDA
3550     For M%=1 TO MMO-1: DB=DB+MO(M%): Next M%
3560     If (LTT=1) and ((MMO>2) or ((MMO=2) and (MDA=29))) Then DB=DB+1
3570     DB=DB+MDA: DST=DST+(DB-DA): Return
4000 If LYR<MYR-100 Then 4500               'less than 100 yrs
4010     gosub 5000: gosub 5500
4015     If CYR=MYR-1 Then 4050
4020 CYR=CYR+1: gosub 5000: If LTT=1 Then DST=DST+366: goto 4040
4030 DST=DST+365
4040 If CYR<>MYR-1 Then 4020
4050 CYR=MYR: CMO=MMO: gosub 5000
4060 For M%=1 TO MMO-1: DST=DST+MO(M%): Next M%
4070     If (LTT=1) and ((MMO>2) or ((MMO=2) and (MDA=29))) Then DST=DST+1
4080     DST=DST+MDA: Return
4500     gosub 5000: gosub 5500             'greater than 100 yrs
4510     CYR=CYR+1: gosub 5000: If LTT=0 Then DST=DST+365: goto 4510
4520     DST=DST+60
4530     If CYR=>MYR-8 Then LYR=CYR:LMO=2:CMO=2:LDA=29:CDA=29:gosub 3500:Return
4540     CYR=CYR+4: gosub 5000: If LTT=1 Then DST=DST+1461: goto 4530
4550     DST=DST+1460: goto 4530
5000 '                                       'sbr leaptest
5010 If ((CYR/100)=INT(CYR/100)) and ((CYR/400)<>INT(CYR/400)) Then 5030
5020 If (CYR/4)=INT(CYR/4) Then LTT=+1: Return
5030 LTT=0: Return
5500 '                                       'sbr days left in yr
5510 If LMO=12 Then DST=DST+(31-LDA): Return
5520 For M%=LMO+1 TO 12: DST=DST+MO(M%): Next M%
5530 If LTT<>1 Then 5560
5540 If CMO=1 Then DST=DST+1
5550 If CMO=2 Then DST=DST+(29-LDA): Return
5560 DST=DST+(MO(LMO)-LDA): Return
5570 on error goto 0
5580 '
5590 CYR=TYR: CMO=TMO: gosub 5000: If LTT=1 Then TMO=TMO+14
5505 ''''''''''''''''''''''''''''''''''''''''''''
6000 '   determine day of the week
6005 ''''''''''''''''''''''''''''''''''''''''''''
6010 WDA=INT((WDC/7-INT(WDC/7))*7+.5)
6020 If TYR>1752 Then WDA=WDA+6: If WDA>7 Then WDA=WDA-7
6030 N = 0
6040 restore
6050 For M=1 TO WDA-1: read A$: next M
6060 If A$="f " then restore
6065 ''''''''''''''''''''''''''''''''''''''''''''
6500 '   begin printing
6505 ''''''''''''''''''''''''''''''''''''''''''''
6510 cls
6520 N=N+1: If N>39 Then 7000
6530 locate 23,N*2-1: READ A$: print A$;: If A$="f " then restore: goto 6520
6540 goto 6520
6545 ''''''''''''''''''''''''''''''''''''''''''''
7000 '   begin printing day numbers
7005 ''''''''''''''''''''''''''''''''''''''''''''
7010 N=0
7020 If TDA<8 Then GMO=TMO-1: GDA=MO(GMO)+(TDA-8): goto 7040
7030 GMO=TMO: GDA=TDA-8
7040 N=N+1: If N>39 Then 7500
7050 locate 24,N*2-1: GDA=GDA+1: If GDA>MO(GMO) Then GMO=GMO+1: GDA=1
7060 DAY$=str$(GDA): If GDA<10 Then DAY$=" "+DAY$
7070 print mid$(DAY$,2,1);: locate 25,N*2-1: print right$(DAY$,1);: goto 7040
7500 line (108,306)-(122,348),,B: CLR%=1     'draw box around selected date
7505 line (115,305)-(115,58),8,,&H00ff       'draw vertical line thru chart
7510 locate 1,1: For M%=1 TO 3:color CLR%:print BIO$:CLR%=CLR%+CLR%:Next M%
7520 T(1)=15+len(MO$(TMO))+len(TDA$): rf$=str$(dct)
7530 T(2)=10+len(MO$(BMO))+len(BDA$): t(3)=10+len(rf$)
7540 T=37+T(1)/2: color 13
7550 locate 1,37-T(1)/2: print "Chart for ";MO$(TMO);TDA$;",";TYR;
7555 locate 2,T-T(2): print "Born ";MO$(BMO);BDA$;",";BYR;
7556 locate 3,32-t(3)/2: print "You have lived ";dct;" days"
7560 M=0: A$="Physical": A=&HFF00: CLR%=1: color 1: gosub 7590
7570 A$="Intellectual": A=&H7070: CLR%=2: color 2: gosub 7590
7580 A$="Emotional": A=&H3333: CLR%=4: color 4: gosub 7590: color 14: goto 7610
7590 M=M+1: Locate M,78-len(A$): print A$
7595 line (442,M*11)-(508,M*11),CLR%,,A
7600 Return
7610 line (1,58)-(610,58),,,&HA0A0
7620 line (1,276)-(610,276),,,&HA0A0
7630 line (1,167)-(610,167),,,&H7000
7640 LCY=23: A=&HFF00: CLR%=9: Gosub 8000    'Physical 23-day cycle
7650 LCY=33: A=&H7070: CLR%=10: Gosub 8000    'Intellectual 33-day cycle
7660 LCY=28: A=&H3333: CLR%=12: Gosub 8000    'Emotional 28-day cycle
7665 CLR%=0: DCT=0: DST=0: SG=0: LTT=0: DA=0: DB=0
7666 ''''''''''''''''''''''''''''''''''''''''''''
7670 '   new date prompt/keep present birthdate
7675 ''''''''''''''''''''''''''''''''''''''''''''
7680 locate 4,T-20: print "Chart NEW date (Y/N)?";
7690 While not INSTAT
7700 locate 4,t-22: print chr$(026);: locate 4,t+2: print chr$(027);
7710 wend
7740 INK$=inkey$
7750 If INK$="y" or INK$="Y" Then 7770       ' restart
7751 If INK$="n" or INK$="N" Then SYSTEM     ' all done
7760 CLR%=CLR%+1: color CLR%: goto 7670      ' flash a different color
7770 cls: locate 4,1: CLR%=8: For M%=1 TO 3: color CLR%+M%: print BIO$: Next M%
7780 line(1,95)-(640,95),13,,&H800: color 14: locate 12,10: print"BIRTHDATE"
7785 locate 12,60: print BIR$
7790 locate 16,10: print "DATE TO BE CHARTED   <enter> for today's date "
7795 locate 16,60: input "",TST$: goto 1000
7799 ''''''''''''''''''''''''''''''''''''''''''''
8000 '   graphing subroutine
8010 ''''''''''''''''''''''''''''''''''''''''''''
8020 PPD = (DCT-7)/LCY-int((DCT-7)/LCY)
8030 PER = 39/LCY
8040 FAC = LCY/39*610*PPD
8050 For X%=1 TO 610 step 16
8060 Z = (X%+FAC)*PER*6.2/610     'shud be pi ^2/610
8070 Y = 100-88*sin(Z)            'adjust height of curve
8080 If X%=1 Then pset (X%,Y+67)  'adjust beginning point
8090 line -(X%,Y+67),CLR%,,A
8100 Next X%: Return
9000 ''''''''''''''''''''''''''''''''''''''''''''
9005 '   data tables
9010 ''''''''''''''''''''''''''''''''''''''''''''
10000 DATA "s ","s ","m ","t ","w ","h ","f "
10010 DATA month,"December ",31
10020 DATA "January ",31
10030 DATA "February ",28
10040 DATA "March ",31
10050 DATA "April ",30
10060 DATA "May ",31
10070 DATA "June ",30
10080 DATA "July ",31
10090 DATA "August ",31
10100 DATA "September ",30
10110 DATA "October ",31
10120 DATA "November ",30
10130 DATA "December ",31
10140 DATA "January ",31
10150 '                       Leap-year data
10160 DATA "December ",31
10170 DATA "January ",31
10180 DATA "February ",29
10190 DATA "March ",31
10200 DATA "April ",30
10210 DATA "May ",31
10220 DATA "June ",30
10230 DATA "July ",31
10240 DATA "August ",31
10250 DATA "September ",30
10260 DATA "October ",31
10270 DATA "November ",30
10280 DATA "December ",31
10290 DATA "January ",31
10300 end
